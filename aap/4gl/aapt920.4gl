#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt920.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0028(2017-01-20 10:34:18), PR版次:0028(2017-01-26 09:09:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000189
#+ Filename...: aapt920
#+ Description: 應付帳款各期重評價維護作業
#+ Creator....: 04152(2014-10-29 23:28:38)
#+ Modifier...: 06821 -SD/PR- 01531
 
{</section>}
 
{<section id="aapt920.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#141218-00011#6              By Belle    單身維護時：其他信息的核算，不必檢核是否有輸入及合理性。
#141202-00061#17             By Belle    產生分錄底稿
#150126-00027#1              By Belle    增加傳票補號
#150202-00002#1              By Reanna   月結部份不用判斷單別是否拋傳票，都要拋
#150205-00012#1              BY Hans     進欄位之後只顯示編號不顯示中文名稱
#150302                      By Reanna   固定核算項增加查詢開窗&WBS開窗+檢核&檢核取用的元件修改(mail 15/01/19)
#150323                      By Reanna   拋傳票時日期default單據日期
#150507                      By Reanna   核算項檢核bug修正
#150506-00033#6              By RayHuang 新增單據串查功能
#150527-00020#1              By Reanna   傳票還原增加簡和總帳關帳日
#150401-00001#13             By RayHuang statechange段問題修正
#150812-00010#3              By apo      跟隨樣板更新單頭刷新sql
#150825-00004#7   2015/08/31 By Reanna   增加aapt920重評價依幣別彙總
#141116-00001#22             By yangtt   新增報表列印
#151020-00003#4              By Jessy    確認作業/取消確認: 只能執行大於等於關帳年月之資料
#151203-00013#3              By Jessy    150825-00004#6/7/9三張單修改的段落,全數還原,因原來分錄底稿就已有依幣別匯總
#150916-00015#1   2015/12/7  By Xiaozg   当有账套时，科目检查改为检查是否存在于glad_t中
#160125-00005#6   2016/02/15 By 02097    查詢時，只顯示有權限的帳套
#160129-00015#2   2016/02/24 by sakura   效率改善
#160225-00001#1   2016/03/04 By 02097    參數D-FIN-0033=N 時不管什麼欄位都不可異動
#160321-00016#22  2016/03/24 By Jessy    修正azzi920重複定義之錯誤訊息
#160818-00017#2   2016/08/24 By 07900    删除修改未重新判断状态码
#161006-00005#6   2016/10/12 By 08732    組織類型與職能開窗調整
#161014-00053#4   2016/10/24 By 08171    帳套權限調整
#161014-00053#4   2016/10/24 By 08171    帳套權限調整
#161114-00017#1   2016/11/15 By Reanna   開窗權限調整
#161104-00046#8   2016/12/30 By 06821    單別預設值;資料依照單別user dept權限過濾單號
#170103-00019#6   2017/01/09 By Reanna   产生凭证时，应一并检核立冲否，并写入立冲明细表；为科目冲销时，明细操作的立冲处理需开放点选。
#161213-00023#2   2017/01/12 By 06694    新增aapp330_01元件單別參數，默認拋轉單別
#161229-00018#1   2017/01/20 By 06821    參考 axrt920 增加 整單操作-更新摘要 功能,更新 xreh033 欄位
#170123-00017#1   2017/01/23 By 06821    若啟用分錄底稿,整單操作更新摘要需同步更新分錄底稿摘要
#170120-00017#1   2017/01/23 By Reanna   修改#170103-00019#6還原時的bug
#161229-00047#65  2017/01/24 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#170116-00049#1   2017/01/26 By 01531    aapt920 抛转传票是汇总方式默认为5：全部
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
PRIVATE type type_g_xreg_m        RECORD
       xregsite LIKE xreg_t.xregsite, 
   l_xregsite_desc LIKE type_t.chr80, 
   xregld LIKE xreg_t.xregld, 
   l_xregld_desc LIKE type_t.chr80, 
   xreg004 LIKE xreg_t.xreg004, 
   l_xreg004_desc LIKE type_t.chr80, 
   xregdocno LIKE xreg_t.xregdocno, 
   xregdocdt LIKE xreg_t.xregdocdt, 
   xreg001 LIKE xreg_t.xreg001, 
   xreg002 LIKE xreg_t.xreg002, 
   xreg005 LIKE xreg_t.xreg005, 
   xregstus LIKE xreg_t.xregstus, 
   xregownid LIKE xreg_t.xregownid, 
   xregownid_desc LIKE type_t.chr80, 
   xregcrtdp LIKE xreg_t.xregcrtdp, 
   xregcrtdp_desc LIKE type_t.chr80, 
   xregowndp LIKE xreg_t.xregowndp, 
   xregowndp_desc LIKE type_t.chr80, 
   xregcrtdt LIKE xreg_t.xregcrtdt, 
   xregcrtid LIKE xreg_t.xregcrtid, 
   xregcrtid_desc LIKE type_t.chr80, 
   xregmodid LIKE xreg_t.xregmodid, 
   xregmodid_desc LIKE type_t.chr80, 
   xregcnfdt LIKE xreg_t.xregcnfdt, 
   xregmoddt LIKE xreg_t.xregmoddt, 
   xregcnfid LIKE xreg_t.xregcnfid, 
   xregcnfid_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xreh_d        RECORD
       xrehld LIKE xreh_t.xrehld, 
   xrehseq LIKE xreh_t.xrehseq, 
   xrehorga LIKE xreh_t.xrehorga, 
   xreh004 LIKE xreh_t.xreh004, 
   xreh005 LIKE xreh_t.xreh005, 
   xreh006 LIKE xreh_t.xreh006, 
   xreh007 LIKE xreh_t.xreh007, 
   xreh009 LIKE xreh_t.xreh009, 
   l_xreh009_desc LIKE type_t.chr500, 
   xreh008 LIKE xreh_t.xreh008, 
   xreh100 LIKE xreh_t.xreh100, 
   xreh102 LIKE xreh_t.xreh102, 
   xreh101 LIKE xreh_t.xreh101, 
   xreh103 LIKE xreh_t.xreh103, 
   xreh113 LIKE xreh_t.xreh113, 
   xreh114 LIKE xreh_t.xreh114, 
   xreh115 LIKE xreh_t.xreh115
       END RECORD
PRIVATE TYPE type_g_xreh2_d RECORD
       xrehld LIKE xreh_t.xrehld, 
   xrehseq LIKE xreh_t.xrehseq, 
   l_xreh005_2 LIKE type_t.chr20, 
   l_xreh006_2 LIKE type_t.num10, 
   xreh033 LIKE xreh_t.xreh033, 
   l_xrehorga_2 LIKE type_t.chr10, 
   xreh019 LIKE xreh_t.xreh019, 
   xreh019_desc LIKE type_t.chr500, 
   xreh034 LIKE xreh_t.xreh034, 
   xreh034_desc LIKE type_t.chr500, 
   xreh016 LIKE xreh_t.xreh016, 
   xreh016_desc LIKE type_t.chr500, 
   xreh011 LIKE xreh_t.xreh011, 
   xreh011_desc LIKE type_t.chr500, 
   xreh012 LIKE xreh_t.xreh012, 
   xreh012_desc LIKE type_t.chr500, 
   xreh013 LIKE xreh_t.xreh013, 
   xreh013_desc LIKE type_t.chr500, 
   xreh014 LIKE xreh_t.xreh014, 
   xreh014_desc LIKE type_t.chr500, 
   xreh015 LIKE xreh_t.xreh015, 
   xreh015_desc LIKE type_t.chr500, 
   xreh017 LIKE xreh_t.xreh017, 
   xreh017_desc LIKE type_t.chr500, 
   xreh018 LIKE xreh_t.xreh018, 
   xreh018_desc LIKE type_t.chr500, 
   xreh020 LIKE xreh_t.xreh020, 
   xreh020_desc LIKE type_t.chr500, 
   xreh021 LIKE xreh_t.xreh021, 
   xreh021_desc LIKE type_t.chr500, 
   xreh022 LIKE xreh_t.xreh022, 
   xreh022_desc LIKE type_t.chr500, 
   xreh023 LIKE xreh_t.xreh023, 
   xreh023_desc LIKE type_t.chr500, 
   xreh024 LIKE xreh_t.xreh024, 
   xreh024_desc LIKE type_t.chr500, 
   xreh025 LIKE xreh_t.xreh025, 
   xreh025_desc LIKE type_t.chr500, 
   xreh026 LIKE xreh_t.xreh026, 
   xreh026_desc LIKE type_t.chr500, 
   xreh027 LIKE xreh_t.xreh027, 
   xreh027_desc LIKE type_t.chr500, 
   xreh028 LIKE xreh_t.xreh028, 
   xreh028_desc LIKE type_t.chr500, 
   xreh029 LIKE xreh_t.xreh029, 
   xreh029_desc LIKE type_t.chr500, 
   xreh030 LIKE xreh_t.xreh030, 
   xreh030_desc LIKE type_t.chr500, 
   xreh031 LIKE xreh_t.xreh031, 
   xreh031_desc LIKE type_t.chr500, 
   xreh032 LIKE xreh_t.xreh032, 
   xreh032_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xreh3_d RECORD
       xrehld LIKE xreh_t.xrehld, 
   xrehseq LIKE xreh_t.xrehseq, 
   l_xreh005_3 LIKE type_t.chr20, 
   l_xreh006_3 LIKE type_t.num10, 
   xreh121 LIKE xreh_t.xreh121, 
   xreh123 LIKE xreh_t.xreh123, 
   xreh124 LIKE xreh_t.xreh124, 
   xreh125 LIKE xreh_t.xreh125, 
   xreh131 LIKE xreh_t.xreh131, 
   xreh133 LIKE xreh_t.xreh133, 
   xreh134 LIKE xreh_t.xreh134, 
   xreh135 LIKE xreh_t.xreh135
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xregld LIKE xreg_t.xregld,
      b_xregsite LIKE xreg_t.xregsite,
      b_xreg004 LIKE xreg_t.xreg004,
      b_xregdocno LIKE xreg_t.xregdocno,
      b_xregdocdt LIKE xreg_t.xregdocdt,
      b_xreg001 LIKE xreg_t.xreg001,
      b_xreg002 LIKE xreg_t.xreg002,
      b_xreg005 LIKE xreg_t.xreg005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#DEFINE g_glad                RECORD LIKE glad_t.*
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
DEFINE g_glaa102             LIKE glaa_t.glaa102    #借貸不平衡處理方式
DEFINE g_glaa004             LIKE glaa_t.glaa004    #會計科目參照表
DEFINE g_glaa015             LIKE glaa_t.glaa015    #本位幣二啟用否
DEFINE g_glaa019             LIKE glaa_t.glaa019    #本位幣三啟用否
DEFINE g_dfin0030            LIKE type_t.chr1       #141202-00061#17
DEFINE g_ap_slip             LIKE apca_t.apcadocno  #141202-00061#17
DEFINE g_glaacomp            LIKE glaa_t.glaacomp   #141202-00061#17
DEFINE g_glaa121             LIKE glaa_t.glaa121    #141202-00061#17
DEFINE g_wc_cs_ld            STRING                 #160125-00005#6
DEFINE g_wc_cs_orga          STRING                 #160125-00005#6
DEFINE g_site_str            STRING                 #161014-00053#4
DEFINE g_sql_ctrl            STRING                 #161114-00017#1
#161104-00046#8 --s add
DEFINE g_user_dept_wc        STRING
DEFINE g_user_dept_wc_q      STRING
#161104-00046#8 --e add
#161229-00047#65 add ------
DEFINE g_wc_cs_comp          STRING
DEFINE g_comp_str            STRING
#161229-00047#65 add end---
#end add-point
       
#模組變數(Module Variables)
DEFINE g_xreg_m          type_g_xreg_m
DEFINE g_xreg_m_t        type_g_xreg_m
DEFINE g_xreg_m_o        type_g_xreg_m
DEFINE g_xreg_m_mask_o   type_g_xreg_m #轉換遮罩前資料
DEFINE g_xreg_m_mask_n   type_g_xreg_m #轉換遮罩後資料
 
   DEFINE g_xregdocno_t LIKE xreg_t.xregdocno
 
 
DEFINE g_xreh_d          DYNAMIC ARRAY OF type_g_xreh_d
DEFINE g_xreh_d_t        type_g_xreh_d
DEFINE g_xreh_d_o        type_g_xreh_d
DEFINE g_xreh_d_mask_o   DYNAMIC ARRAY OF type_g_xreh_d #轉換遮罩前資料
DEFINE g_xreh_d_mask_n   DYNAMIC ARRAY OF type_g_xreh_d #轉換遮罩後資料
DEFINE g_xreh2_d          DYNAMIC ARRAY OF type_g_xreh2_d
DEFINE g_xreh2_d_t        type_g_xreh2_d
DEFINE g_xreh2_d_o        type_g_xreh2_d
DEFINE g_xreh2_d_mask_o   DYNAMIC ARRAY OF type_g_xreh2_d #轉換遮罩前資料
DEFINE g_xreh2_d_mask_n   DYNAMIC ARRAY OF type_g_xreh2_d #轉換遮罩後資料
DEFINE g_xreh3_d          DYNAMIC ARRAY OF type_g_xreh3_d
DEFINE g_xreh3_d_t        type_g_xreh3_d
DEFINE g_xreh3_d_o        type_g_xreh3_d
DEFINE g_xreh3_d_mask_o   DYNAMIC ARRAY OF type_g_xreh3_d #轉換遮罩前資料
DEFINE g_xreh3_d_mask_n   DYNAMIC ARRAY OF type_g_xreh3_d #轉換遮罩後資料
 
 
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
 
{<section id="aapt920.main" >}
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
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_orga #160125-00005#6
   CALL s_fin_get_wc_str(g_wc_cs_orga) RETURNING g_wc_cs_orga  #160125-00005#6
   
   #161114-00017#1 add ------
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO g_glaacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#65 mark
   #161114-00017#1 add end---
   #161229-00047#65 add ------
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#65 add end---
   #161104-00046#8 --s add
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','xregld','xregent','xregdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   #161104-00046#8 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xregsite,'',xregld,'',xreg004,'',xregdocno,xregdocdt,xreg001,xreg002, 
       xreg005,xregstus,xregownid,'',xregcrtdp,'',xregowndp,'',xregcrtdt,xregcrtid,'',xregmodid,'',xregcnfdt, 
       xregmoddt,xregcnfid,''", 
                      " FROM xreg_t",
                      " WHERE xregent= ? AND xregdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt920_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xregsite,t0.xregld,t0.xreg004,t0.xregdocno,t0.xregdocdt,t0.xreg001, 
       t0.xreg002,t0.xreg005,t0.xregstus,t0.xregownid,t0.xregcrtdp,t0.xregowndp,t0.xregcrtdt,t0.xregcrtid, 
       t0.xregmodid,t0.xregcnfdt,t0.xregmoddt,t0.xregcnfid,t1.ooag011 ,t2.ooefl003 ,t3.ooefl003 ,t4.ooag011 , 
       t5.ooag011 ,t6.ooag011",
               " FROM xreg_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xregownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xregcrtdp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.xregowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.xregcrtid  ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.xregmodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xregcnfid  ",
 
               " WHERE t0.xregent = " ||g_enterprise|| " AND t0.xregdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt920_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt920 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt920_init()   
 
      #進入選單 Menu (="N")
      CALL aapt920_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt920
      
   END IF 
   
   CLOSE aapt920_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt920.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt920_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xregstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2','3',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_set_comp_scc('xreg001','43')   #年度
   CALL s_fin_set_comp_scc('xreg002','111')  #期別
   CALL cl_set_combo_scc('xreh004','8502')
   CALL cl_set_combo_scc('xreh020_desc','6013')
   CALL cl_set_comp_visible('page_4',FALSE)                    #先關閉"其他本位幣"頁籤
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #寫入暫存檔
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   #aapt920_02暫不啟用
   CALL cl_set_toolbaritem_visible("open_aapt920_02", FALSE)
   CALL s_fin_continue_no_tmp()               #150126-00027#1
   #end add-point
   
   #初始化搜尋條件
   CALL aapt920_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt920.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt920_ui_dialog()
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
   DEFINE l_slip      LIKE glap_t.glapdocno 
   DEFINE l_date      LIKE glap_t.glapdocdt
   DEFINE l_count     LIKE type_t.num5
   DEFINE l_docno     LIKE xrem_t.xremdocno
   DEFINE l_start_no  LIKE glap_t.glapdocno
   DEFINE l_stus      LIKE glap_t.glapstus
   DEFINE l_sfin3007  LIKE type_t.dat
   DEFINE l_glca002   LIKE glca_t.glca002
   DEFINE l_glaacomp  LIKE glaa_t.glaacomp
   DEFINE l_glaa013   LIKE glaa_t.glaa013    #150527-00020#1
   DEFINE l_glapdocdt LIKE glap_t.glapdocdt  #150527-00020#1
   DEFINE l_sys       LIKE type_t.chr2       #150829
   DEFINE l_wc        STRING                 #141116-00001#22
   #170103-00019#6 add ------
   DEFINE l_scom0002  LIKE type_t.chr10
   DEFINE l_success   LIKE type_t.num5
   #170103-00019#6 add end---
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
         INITIALIZE g_xreg_m.* TO NULL
         CALL g_xreh_d.clear()
         CALL g_xreh2_d.clear()
         CALL g_xreh3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt920_init()
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
               
               CALL aapt920_fetch('') # reload data
               LET l_ac = 1
               CALL aapt920_ui_detailshow() #Setting the current row 
         
               CALL aapt920_idx_chk()
               #NEXT FIELD xrehld
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xreh_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt920_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2','3',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt920_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_xreh005
                  LET g_action_choice="prog_xreh005"
                  IF cl_auth_chk_act("prog_xreh005") THEN
                     
                     #add-point:ON ACTION prog_xreh005 name="menu.detail_show.page1_sub.prog_xreh005"
                     CALL aapt920_qrystr('xreh005')       #150506-00033#6
                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xreh2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt920_idx_chk()
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
               CALL aapt920_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xreh3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt920_idx_chk()
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
               CALL aapt920_idx_chk()
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
            CALL aapt920_browser_fill("")
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
               CALL aapt920_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt920_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt920_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt920_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt920_set_act_visible()   
            CALL aapt920_set_act_no_visible()
            IF NOT (g_xreg_m.xregdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xregent = " ||g_enterprise|| " AND",
                                  " xregdocno = '", g_xreg_m.xregdocno, "' "
 
               #填到對應位置
               CALL aapt920_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "xreg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xreh_t" 
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
               CALL aapt920_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "xreg_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xreh_t" 
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
                  CALL aapt920_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt920_fetch("F")
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
               CALL aapt920_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt920_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt920_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt920_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt920_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt920_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt920_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt920_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt920_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt920_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt920_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xreh_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xreh2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xreh3_d)
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
               NEXT FIELD xrehld
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
         ON ACTION action_5
            LET g_action_choice="action_5"
            IF cl_auth_chk_act("action_5") THEN
               
               #add-point:ON ACTION action_5 name="menu.action_5"
               CALL s_transaction_begin()
               #傳票還原
               IF g_xreg_m.xregdocno IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "std-00003"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #無傳票 不可還原
               IF g_xreg_m.xreg005 IS NULL THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "anm-00186"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #150527-00020#1 add ------
               #傳票還原單據日期不可大於過帳日期
               SELECT glapdocdt INTO l_glapdocdt
                 FROM glap_t
                WHERE glapent = g_enterprise
                  AND glapld = g_xreg_m.xregld
                  AND glapdocno = g_xreg_m.xreg005
               
               SELECT glaa013 INTO l_glaa013
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_xreg_m.xregld
               
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
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               ELSE
                  #傳票已經確認不可還原
                  SELECT glapstus INTO l_stus
                    FROM glap_t
                   WHERE glapent = g_enterprise
                     AND glapdocno = g_xreg_m.xreg005
                  
                 #IF l_stus = 'Y' THEN       #02097
                  IF NOT l_stus MATCHES '[NX]' THEN    #02097 modify 未確認才能刪除
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axr-00076'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                  ELSE
                     #170103-00019#6 add ------
                     #更新相关的细项立冲账资料
                     LET l_success = TRUE
                     CALL cl_get_para(g_enterprise,g_glaacomp,'S-COM-0002') RETURNING l_scom0002
                     CALL s_pre_voucher_delete_glax(g_xreg_m.xregld,g_xreg_m.xreg005,'',l_scom0002) RETURNING l_success
                     IF l_success = FALSE THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     
                     IF l_scom0002 = 'Y' THEN
                        #凭证作废处理
                        UPDATE glap_t SET glapstus = 'X'
                         WHERE glapent = g_enterprise
                           AND glapld = g_xreg_m.xregld
                           AND glapdocno = g_xreg_m.xreg005
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
                     #170103-00019#6 add end---
                        
                        #刪除單頭
                        DELETE FROM glap_t
                         WHERE glapent   = g_enterprise
                           AND glapld = g_xreg_m.xregld
                           AND glapdocno = g_xreg_m.xreg005
                        #刪除單身
                        DELETE FROM glaq_t
                         WHERE glaqent = g_enterprise
                           AND glaqld = g_xreg_m.xregld 
                           AND glaqdocno = g_xreg_m.xreg005
                        
                        #151203-00013#3 --s
                        ##150825-00004#7 add ------
                        ##刪除傳票產生的現金變動碼
                        #CALL s_cashflow_nm_del_glbc(l_glapdocdt,g_xreg_m.xregld,g_xreg_m.xreg005,'')
                        #     RETURNING g_sub_success,g_errno
                        #IF NOT g_sub_success THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code   = g_errno
                        #   LET g_errparam.extend = 'DELETE glbc_t'
                        #   LET g_errparam.popup  = TRUE
                        #   CALL s_transaction_end('N','0')
                        #   CALL cl_err()
                        #END IF
                        ##150825-00004#7 add end---
                        #151203-00013#3 --e
                        #170120-00017#1 mark ------
                        ##更新月結這邊的傳票號碼要給空
                        #UPDATE xreg_t
                        #   SET xreg005 = ''
                        # WHERE xregent = g_enterprise
                        #   AND xregdocno = g_xreg_m.xregdocno
                        #   AND xreg003 ='AP'
                        #170120-00017#1 mark end---
                        #更新最大號
                        SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                          FROM glca_t
                         WHERE glcaent = g_enterprise
                           AND glcald  = g_xreg_m.xregld AND glca001 = 'AP'
                        IF l_glca002 = 'Y' THEN
                           LET g_prog = 'aglt350'
                        ELSE
                           LET g_prog = 'aglt310'
                        END IF
                        #150527-00020#1 改傳傳票日期 l_glapdocdt
                        IF NOT s_aooi200_fin_del_docno(g_xreg_m.xregld,g_xreg_m.xreg005,l_glapdocdt) THEN
                           CALL s_transaction_end('N','0')
                           CONTINUE DIALOG
                        END IF
                        LET g_prog = 'aapt920'
                        #170120-00017#1 mark ------
                        #LET g_xreg_m.xreg005 = ''
                        #DISPLAY BY NAME g_xreg_m.xreg005
                        #170120-00017#1 mark end---
                        #141202-00061#17
                        UPDATE glga_t SET glga007 = ''
                         WHERE glgaent = g_enterprise AND glgald = g_xreg_m.xregld 
                           AND glgadocno=g_xreg_m.xregdocno AND glga100 = 'AP' AND glga101 = 'P40'
                        #141202-00061#17
                        
                        #CALL s_transaction_end('Y','0') #170120-00017#1 mark
                     
                     END IF  #170103-00019#6 add
                     #170120-00017#1 add ------
                     #更新月結這邊的傳票號碼要給空
                     UPDATE xreg_t
                        SET xreg005 = ''
                      WHERE xregent = g_enterprise
                        AND xregdocno = g_xreg_m.xregdocno
                        AND xreg003 ='AP'
                     LET g_xreg_m.xreg005 = ''
                     DISPLAY BY NAME g_xreg_m.xreg005
                     
                     CALL s_transaction_end('Y','0')
                     #170120-00017#1 add end---
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt920_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt920_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_pre
            LET g_action_choice="open_pre"
            IF cl_auth_chk_act("open_pre") THEN
               
               #add-point:ON ACTION open_pre name="menu.open_pre"
               #141202-00061#17--產生分錄底稿
               IF NOT cl_null(g_xreg_m.xregdocno) AND g_xreg_m.xregstus = 'N' THEN
                  CALL s_pre_voucher_ins('AP','P40',g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,'1')
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
               #傳票預覽
               #150829 add ------
               SELECT (CASE WHEN glca002 = '2' THEN 'Y' ELSE 'N' END) INTO l_glca002
                 FROM glca_t
                WHERE glcaent = g_enterprise
                  AND glcald  = g_xreg_m.xregld AND glca001 = 'AP'
               IF l_glca002 = 'Y' THEN
                  LET l_sys = 'AC'
               ELSE
                  LET l_sys = 'AP'
               END IF
               #150829 add end---
               #141202-00061#17
               CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa121') RETURNING g_sub_success,g_glaa121
               IF g_glaa121 = 'Y' THEN
                 #CALL s_pre_voucher('AP','P40',g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt)    #150829 mark
                  CALL s_pre_voucher(l_sys,'P40',g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt)   #150829
               ELSE
               #141202-00061#17
                  CALL aapt300_14(g_xreg_m.xregld,g_xreg_m.xregdocno,'1')
               END IF        #141202-00061#17
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt920_02
            LET g_action_choice="open_aapt920_02"
            IF cl_auth_chk_act("open_aapt920_02") THEN
               
               #add-point:ON ACTION open_aapt920_02 name="menu.open_aapt920_02"
               #依幣別更新重評價匯率
               CALL aapt920_02()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt920_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt920_01
            LET g_action_choice="open_aapt920_01"
            IF cl_auth_chk_act("open_aapt920_01") THEN
               
               #add-point:ON ACTION open_aapt920_01 name="menu.open_aapt920_01"
               #批次產生
               CALL aapt920_01()RETURNING g_sub_success,g_xreg_m.xregdocno
               IF g_sub_success THEN
                   #150812-00010#3-mod-s
                   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
                       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
                       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
                       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
                       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
                       g_xreg_m.xregcnfid_desc
                   #150812-00010#3--mod-e
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = "xreg_t"
                      LET g_errparam.code   = SQLCA.sqlcode
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()
                      INITIALIZE g_xreg_m.* TO NULL
                      CONTINUE DIALOG
                   END IF
   
                  #根據資料狀態切換action狀態
                  CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
                  CALL aapt920_set_act_visible()
                  CALL aapt920_set_act_no_visible()
                  
                  CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
                  IF g_xreg_m.xregstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
                     CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
                  END IF
   
                  LET g_xreg_m_t.* = g_xreg_m.*
                  LET g_xreg_m_o.* = g_xreg_m.*
                  
                  LET g_data_owner = g_xreg_m.xregownid
                  LET g_data_dept  = g_xreg_m.xregowndp
                  
                  #重新顯示
                  CALL aapt920_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aap/aapt920_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               #141116-00001#22----add---str--
               LET l_wc = " xregsite='",g_xreg_m.xregsite,"' AND xregld='",g_xreg_m.xregld,"'",
                          " AND xreg001='",g_xreg_m.xreg001,"' AND xreg002='",g_xreg_m.xreg002,"'"
          
               #                            來源類型         匯總條件
               CALL axrr920_x01(l_wc,'1','0')
               #141116-00001#22----add---end--
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/aap/aapt920_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt920_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_xreh033
            LET g_action_choice="update_xreh033"
            IF cl_auth_chk_act("update_xreh033") THEN
               
               #add-point:ON ACTION update_xreh033 name="menu.update_xreh033"
               #161229-00018#1 --s add
               IF NOT cl_null(g_xreg_m.xregdocno) THEN 
                  CALL aapt920_update_xreh033()
                  #170123-00017#1 --s add
                  #如果有啟用分錄底稿,應一併更新
                  IF g_glaa121 = 'Y' THEN 
                     CALL s_transaction_begin()
                     CALL s_pre_voucher_ins('AP','P40',g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,'1')
                          RETURNING g_sub_success
                     IF g_sub_success THEN 
                        CALL s_transaction_end('Y','0')
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF                  
                  #170123-00017#1 --e add
               END IF
               #161229-00018#1 --e add
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axrp330_01
            LET g_action_choice="open_axrp330_01"
            IF cl_auth_chk_act("open_axrp330_01") THEN
               
               #add-point:ON ACTION open_axrp330_01 name="menu.open_axrp330_01"
               IF g_xreg_m.xregdocno IS NULL THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "" 
                 LET g_errparam.code   = "std-00003" 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 CONTINUE DIALOG
               END IF
               
               #未確認單據不可拋轉
               IF g_xreg_m.xregstus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00185'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #已拋轉傳票的單據不可以再拋轉 #Reanna 15/02/11 add
               IF NOT cl_null(g_xreg_m.xreg005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00198'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               #無傳票號碼才可拋轉
               IF cl_null(g_xreg_m.xreg005) THEN
                  #傳票成立時,借貸不平衡的處理方式
                  CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaacomp|glaa102')
                       RETURNING g_sub_success,l_glaacomp,g_glaa102
                  #取所屬法人關帳日
                  CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-3007') RETURNING l_sfin3007 
                  
                  #產生單別/日期
                  #CALL axrp330_01(g_xreg_m.xregld) RETURNING l_slip,l_date #150323 mark
                  CALL aapp330_01(g_xreg_m.xregld,g_xreg_m.xregdocdt,'P40',g_xreg_m.xregdocno) RETURNING l_slip,l_date #150323   #161213-00023#2 add g_xreg_m.xregdocno
                  
                  #若取消產生時，就不往下走拋轉了 #Reanna 15/02/11 add
                  IF cl_null(l_slip) THEN
                     CONTINUE DIALOG
                  END IF
                  
                  #必須大於帳套關帳日期才可拋轉
                  IF l_date < l_sfin3007 THEN
                     LET g_errparam.code = 'aap-00077'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CONTINUE DIALOG
                  END IF

                  CALL s_transaction_begin()
                  
                  DELETE FROM s_voucher_tmp
                  
                  INSERT INTO s_voucher_tmp (docno,type)
                         VALUES ( g_xreg_m.xregdocno, '0' )
                  SELECT docno INTO l_docno FROM s_voucher_tmp WHERE type = 0
                  
                  SELECT count(*) INTO l_count FROM s_voucher_tmp
                  
                  IF l_count > 0 THEN
                     #CALL s_aapp330_gen_ac('1','P40',g_xreg_m.xregld,'','','1','!#@',g_xreg_m.xregstus) RETURNING g_sub_success,l_start_no,l_start_no #170116-00049#1 mark
                     CALL s_aapp330_gen_ac('1','P40',g_xreg_m.xregld,'','','5','!#@',g_xreg_m.xregstus) RETURNING g_sub_success,l_start_no,l_start_no  #170116-00049#1 add
                     IF g_sub_success THEN
                        CALL s_transaction_end('Y','Y')
                     ELSE
                        CALL s_transaction_end('N','Y')
                     END IF
                     
                     #傳票拋轉
                     CALL s_transaction_begin()
                     CALL cl_err_collect_init()
                     #CALL s_aapp330_generate_voucher('P40',l_slip,l_date,g_xreg_m.xregld,'1','Y',g_glaa102,'AP')  #170116-00049#1 mark
                     CALL s_aapp330_generate_voucher('P40',l_slip,l_date,g_xreg_m.xregld,'5','Y',g_glaa102,'AP')   #170116-00049#1 add
                          RETURNING g_sub_success,g_xreg_m.xreg005,g_xreg_m.xreg005
                     CALL cl_err_collect_show()
                     
                     #成功則更新aapt920的傳票號碼
                     IF g_sub_success THEN
                        UPDATE xreg_t SET xreg005 = g_xreg_m.xreg005
                         WHERE xregent = g_enterprise
                           AND xregdocno = g_xreg_m.xregdocno
                           AND xreg003 ='AP'
                        #141202-00061#17
                        UPDATE glga_t SET glga007 =  g_xreg_m.xreg005
                         WHERE glgaent = g_enterprise AND glgald = g_xreg_m.xregld 
                           AND glgadocno=g_xreg_m.xregdocno AND glga100 = 'AP' AND glga101 = 'P40'
                        #141202-00061#17
                        CALL s_transaction_end('Y','Y')
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'adz-00217'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     ELSE
                        CALL s_transaction_end('N','Y')
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'adz-00218'
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                     #重新顯示傳票號碼
                     SELECT xreg005 INTO g_xreg_m.xreg005
                       FROM xreg_t
                      WHERE xregent = g_enterprise
                        AND xregdocno = g_xreg_m.xregdocno
                        AND xreg003 ='AP'
                     DISPLAY BY NAME g_xreg_m.xreg005
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xreg004
            LET g_action_choice="prog_xreg004"
            IF cl_auth_chk_act("prog_xreg004") THEN
               
               #add-point:ON ACTION prog_xreg004 name="menu.prog_xreg004"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_xreg_m.xreg004)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_xreg005
            LET g_action_choice="prog_xreg005"
            IF cl_auth_chk_act("prog_xreg005") THEN
               
               #add-point:ON ACTION prog_xreg005 name="menu.prog_xreg005"
               #應用 a41 樣板自動產生(Version:2)
               CALL aapt920_qrystr('xreg005')       #150506-00033#6
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt920_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt920_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt920_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xreg_m.xregdocdt)
 
 
 
         
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
 
{<section id="aapt920.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt920_browser_fill(ps_page_action)
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
   #161014-00053#4 --s add
   CALL s_axrt300_get_site(g_user,'','2') RETURNING l_ld_str  
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xregld")
   LET l_wc = l_wc," AND ",l_ld_str
   #161014-00053#4 --e add
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xregdocno ",
                      " FROM xreg_t ",
                      " ",
                      " LEFT JOIN xreh_t ON xrehent = xregent AND xregdocno = xrehdocno ", "  ",
                      #add-point:browser_fill段sql(xreh_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE xregent = " ||g_enterprise|| " AND xrehent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xreg_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xregdocno ",
                      " FROM xreg_t ", 
                      "  ",
                      "  ",
                      " WHERE xregent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xreg_t")
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
      INITIALIZE g_xreg_m.* TO NULL
      CALL g_xreh_d.clear()        
      CALL g_xreh2_d.clear() 
      CALL g_xreh3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xregld,t0.xregsite,t0.xreg004,t0.xregdocno,t0.xregdocdt,t0.xreg001,t0.xreg002,t0.xreg005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xregstus,t0.xregld,t0.xregsite,t0.xreg004,t0.xregdocno,t0.xregdocdt, 
          t0.xreg001,t0.xreg002,t0.xreg005 ",
                  " FROM xreg_t t0",
                  "  ",
                  "  LEFT JOIN xreh_t ON xrehent = xregent AND xregdocno = xrehdocno ", "  ", 
                  #add-point:browser_fill段sql(xreh_t1) name="browser_fill.join.xreh_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.xregent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xreg_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xregstus,t0.xregld,t0.xregsite,t0.xreg004,t0.xregdocno,t0.xregdocdt, 
          t0.xreg001,t0.xreg002,t0.xreg005 ",
                  " FROM xreg_t t0",
                  "  ",
                  
                  " WHERE t0.xregent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xreg_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   IF NOT cl_null(g_wc_cs_ld) THEN     #160125-00005#6--(S)
      LET g_sql = g_sql , " AND xregld IN ",g_wc_cs_ld
   END IF                              #160125-00005#6--(E)
   #end add-point
   LET g_sql = g_sql, " ORDER BY xregdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xreg_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xregld,g_browser[g_cnt].b_xregsite, 
          g_browser[g_cnt].b_xreg004,g_browser[g_cnt].b_xregdocno,g_browser[g_cnt].b_xregdocdt,g_browser[g_cnt].b_xreg001, 
          g_browser[g_cnt].b_xreg002,g_browser[g_cnt].b_xreg005
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
         CALL aapt920_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_xregdocno) THEN
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
 
{<section id="aapt920.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt920_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xreg_m.xregdocno = g_browser[g_current_idx].b_xregdocno   
 
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
   CALL aapt920_xreg_t_mask()
   CALL aapt920_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt920.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt920_ui_detailshow()
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
 
{<section id="aapt920.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt920_ui_browser_refresh()
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
      IF g_browser[l_i].b_xregdocno = g_xreg_m.xregdocno 
 
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
 
{<section id="aapt920.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt920_construct()
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
   DEFINE l_para_data LIKE type_t.chr80
   DEFINE l_ld_str    STRING               #161014-00053#4 add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_xreg_m.* TO NULL
   CALL g_xreh_d.clear()        
   CALL g_xreh2_d.clear() 
   CALL g_xreh3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL   #161014-00053#4
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xregsite,xregld,xreg004,xregdocno,xregdocdt,xreg001,xreg002,xregstus, 
          xregownid,xregcrtdp,xregowndp,xregcrtdt,xregcrtid,xregmodid,xregcnfdt,xregmoddt,xregcnfid
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
 
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xregcrtdt>>----
         AFTER FIELD xregcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xregmoddt>>----
         AFTER FIELD xregmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xregcnfdt>>----
         AFTER FIELD xregcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xregpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregsite
            #add-point:BEFORE FIELD xregsite name="construct.b.xregsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregsite
            
            #add-point:AFTER FIELD xregsite name="construct.a.xregsite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str #161014-00053#4
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregsite
            #add-point:ON ACTION controlp INFIELD xregsite name="construct.c.xregsite"
			   #帳務中心
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()      #161006-00005#6   mark
            CALL q_ooef001_46()    #161006-00005#6   add
            DISPLAY g_qryparam.return1 TO xregsite
            NEXT FIELD xregsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregld
            #add-point:BEFORE FIELD xregld name="construct.b.xregld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregld
            
            #add-point:AFTER FIELD xregld name="construct.a.xregld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregld
            #add-point:ON ACTION controlp INFIELD xregld name="construct.c.xregld"
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str #161014-00053#4 add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
           #LET g_qryparam.where = " glaald IN ",g_wc_cs_ld    #160125-00005#6              #161014-00053#4 mark
            LET g_qryparam.where = l_ld_str CLIPPED," AND (glaa008 = 'Y' OR glaa014 = 'Y')" #161014-00053#4 add
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO xregld
            NEXT FIELD xregld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg004
            #add-point:BEFORE FIELD xreg004 name="construct.b.xreg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg004
            
            #add-point:AFTER FIELD xreg004 name="construct.a.xreg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xreg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg004
            #add-point:ON ACTION controlp INFIELD xreg004 name="construct.c.xreg004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
   			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xreg004
            NEXT FIELD xreg004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocno
            #add-point:BEFORE FIELD xregdocno name="construct.b.xregdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocno
            
            #add-point:AFTER FIELD xregdocno name="construct.a.xregdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocno
            #add-point:ON ACTION controlp INFIELD xregdocno name="construct.c.xregdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "xreg003 = 'AP'"
            #161114-00017#1 add ------
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xregld")
            LET g_qryparam.where = g_qryparam.where," AND ",l_ld_str
            #161114-00017#1 add end---
            #161104-00046#8 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#8 --e add           
            CALL q_xregdocno()
            DISPLAY g_qryparam.return1 TO xregdocno
            NEXT FIELD xregdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocdt
            #add-point:BEFORE FIELD xregdocdt name="construct.b.xregdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocdt
            
            #add-point:AFTER FIELD xregdocdt name="construct.a.xregdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocdt
            #add-point:ON ACTION controlp INFIELD xregdocdt name="construct.c.xregdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg001
            #add-point:BEFORE FIELD xreg001 name="construct.b.xreg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg001
            
            #add-point:AFTER FIELD xreg001 name="construct.a.xreg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xreg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg001
            #add-point:ON ACTION controlp INFIELD xreg001 name="construct.c.xreg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg002
            #add-point:BEFORE FIELD xreg002 name="construct.b.xreg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg002
            
            #add-point:AFTER FIELD xreg002 name="construct.a.xreg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xreg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg002
            #add-point:ON ACTION controlp INFIELD xreg002 name="construct.c.xreg002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregstus
            #add-point:BEFORE FIELD xregstus name="construct.b.xregstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregstus
            
            #add-point:AFTER FIELD xregstus name="construct.a.xregstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregstus
            #add-point:ON ACTION controlp INFIELD xregstus name="construct.c.xregstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xregownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregownid
            #add-point:ON ACTION controlp INFIELD xregownid name="construct.c.xregownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO xregownid
            NEXT FIELD xregownid
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregownid
            #add-point:BEFORE FIELD xregownid name="construct.b.xregownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregownid
            
            #add-point:AFTER FIELD xregownid name="construct.a.xregownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregcrtdp
            #add-point:ON ACTION controlp INFIELD xregcrtdp name="construct.c.xregcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xregcrtdp  #顯示到畫面上
            NEXT FIELD xregcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregcrtdp
            #add-point:BEFORE FIELD xregcrtdp name="construct.b.xregcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregcrtdp
            
            #add-point:AFTER FIELD xregcrtdp name="construct.a.xregcrtdp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregowndp
            #add-point:ON ACTION controlp INFIELD xregowndp name="construct.c.xregowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xregowndp  #顯示到畫面上
            NEXT FIELD xregowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregowndp
            #add-point:BEFORE FIELD xregowndp name="construct.b.xregowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregowndp
            
            #add-point:AFTER FIELD xregowndp name="construct.a.xregowndp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregcrtdt
            #add-point:BEFORE FIELD xregcrtdt name="construct.b.xregcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xregcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregcrtid
            #add-point:ON ACTION controlp INFIELD xregcrtid name="construct.c.xregcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xregcrtid  #顯示到畫面上
            NEXT FIELD xregcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregcrtid
            #add-point:BEFORE FIELD xregcrtid name="construct.b.xregcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregcrtid
            
            #add-point:AFTER FIELD xregcrtid name="construct.a.xregcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xregmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregmodid
            #add-point:ON ACTION controlp INFIELD xregmodid name="construct.c.xregmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xregmodid  #顯示到畫面上
            NEXT FIELD xregmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregmodid
            #add-point:BEFORE FIELD xregmodid name="construct.b.xregmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregmodid
            
            #add-point:AFTER FIELD xregmodid name="construct.a.xregmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregcnfdt
            #add-point:BEFORE FIELD xregcnfdt name="construct.b.xregcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregmoddt
            #add-point:BEFORE FIELD xregmoddt name="construct.b.xregmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xregcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregcnfid
            #add-point:ON ACTION controlp INFIELD xregcnfid name="construct.c.xregcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xregcnfid  #顯示到畫面上
            NEXT FIELD xregcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregcnfid
            #add-point:BEFORE FIELD xregcnfid name="construct.b.xregcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregcnfid
            
            #add-point:AFTER FIELD xregcnfid name="construct.a.xregcnfid"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009,xreh008,xreh100,xreh102, 
          xreh101,xreh103,xreh113,xreh114,xreh115,xreh033,xreh019,xreh019_desc,xreh034,xreh034_desc, 
          xreh016,xreh016_desc,xreh011,xreh011_desc,xreh012,xreh012_desc,xreh013,xreh013_desc,xreh014, 
          xreh014_desc,xreh015,xreh015_desc,xreh017,xreh017_desc,xreh018,xreh018_desc,xreh020,xreh020_desc, 
          xreh021,xreh021_desc,xreh022,xreh022_desc
           FROM s_detail1[1].xrehorga,s_detail1[1].xreh004,s_detail1[1].xreh005,s_detail1[1].xreh006, 
               s_detail1[1].xreh007,s_detail1[1].xreh009,s_detail1[1].xreh008,s_detail1[1].xreh100,s_detail1[1].xreh102, 
               s_detail1[1].xreh101,s_detail1[1].xreh103,s_detail1[1].xreh113,s_detail1[1].xreh114,s_detail1[1].xreh115, 
               s_detail2[1].xreh033,s_detail2[1].xreh019,s_detail2[1].xreh019_desc,s_detail2[1].xreh034, 
               s_detail2[1].xreh034_desc,s_detail2[1].xreh016,s_detail2[1].xreh016_desc,s_detail2[1].xreh011, 
               s_detail2[1].xreh011_desc,s_detail2[1].xreh012,s_detail2[1].xreh012_desc,s_detail2[1].xreh013, 
               s_detail2[1].xreh013_desc,s_detail2[1].xreh014,s_detail2[1].xreh014_desc,s_detail2[1].xreh015, 
               s_detail2[1].xreh015_desc,s_detail2[1].xreh017,s_detail2[1].xreh017_desc,s_detail2[1].xreh018, 
               s_detail2[1].xreh018_desc,s_detail2[1].xreh020,s_detail2[1].xreh020_desc,s_detail2[1].xreh021, 
               s_detail2[1].xreh021_desc,s_detail2[1].xreh022,s_detail2[1].xreh022_desc
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrehorga
            #add-point:BEFORE FIELD xrehorga name="construct.b.page1.xrehorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrehorga
            
            #add-point:AFTER FIELD xrehorga name="construct.a.page1.xrehorga"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xrehorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrehorga
            #add-point:ON ACTION controlp INFIELD xrehorga name="construct.c.page1.xrehorga"
            #來源組織
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_wc_cs_orga) THEN         #160125-00005#6
   			   LET g_qryparam.where = " ooef001 IN ",g_wc_cs_orga,
   			                          " AND ooef201 = 'Y'"   #161006-00005#6  add
   			END IF                                    #160125-00005#6
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO xrehorga
            NEXT FIELD xrehorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh004
            #add-point:BEFORE FIELD xreh004 name="construct.b.page1.xreh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh004
            
            #add-point:AFTER FIELD xreh004 name="construct.a.page1.xreh004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh004
            #add-point:ON ACTION controlp INFIELD xreh004 name="construct.c.page1.xreh004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh005
            #add-point:BEFORE FIELD xreh005 name="construct.b.page1.xreh005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh005
            
            #add-point:AFTER FIELD xreh005 name="construct.a.page1.xreh005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh005
            #add-point:ON ACTION controlp INFIELD xreh005 name="construct.c.page1.xreh005"
            #來源單據編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xreh005()
            DISPLAY g_qryparam.return1 TO xreh005
            NEXT FIELD xreh005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh006
            #add-point:BEFORE FIELD xreh006 name="construct.b.page1.xreh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh006
            
            #add-point:AFTER FIELD xreh006 name="construct.a.page1.xreh006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh006
            #add-point:ON ACTION controlp INFIELD xreh006 name="construct.c.page1.xreh006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh007
            #add-point:BEFORE FIELD xreh007 name="construct.b.page1.xreh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh007
            
            #add-point:AFTER FIELD xreh007 name="construct.a.page1.xreh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh007
            #add-point:ON ACTION controlp INFIELD xreh007 name="construct.c.page1.xreh007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh009
            #add-point:BEFORE FIELD xreh009 name="construct.b.page1.xreh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh009
            
            #add-point:AFTER FIELD xreh009 name="construct.a.page1.xreh009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh009
            #add-point:ON ACTION controlp INFIELD xreh009 name="construct.c.page1.xreh009"
            #帳款對象編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            #161114-00017#1 add ------
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161114-00017#1 add end---
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO xreh009
            NEXT FIELD xreh009
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh008
            #add-point:BEFORE FIELD xreh008 name="construct.b.page1.xreh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh008
            
            #add-point:AFTER FIELD xreh008 name="construct.a.page1.xreh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh008
            #add-point:ON ACTION controlp INFIELD xreh008 name="construct.c.page1.xreh008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh100
            #add-point:BEFORE FIELD xreh100 name="construct.b.page1.xreh100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh100
            
            #add-point:AFTER FIELD xreh100 name="construct.a.page1.xreh100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh100
            #add-point:ON ACTION controlp INFIELD xreh100 name="construct.c.page1.xreh100"
            #幣別
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO xreh100
            NEXT FIELD xreh100
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh102
            #add-point:BEFORE FIELD xreh102 name="construct.b.page1.xreh102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh102
            
            #add-point:AFTER FIELD xreh102 name="construct.a.page1.xreh102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh102
            #add-point:ON ACTION controlp INFIELD xreh102 name="construct.c.page1.xreh102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh101
            #add-point:BEFORE FIELD xreh101 name="construct.b.page1.xreh101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh101
            
            #add-point:AFTER FIELD xreh101 name="construct.a.page1.xreh101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh101
            #add-point:ON ACTION controlp INFIELD xreh101 name="construct.c.page1.xreh101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh103
            #add-point:BEFORE FIELD xreh103 name="construct.b.page1.xreh103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh103
            
            #add-point:AFTER FIELD xreh103 name="construct.a.page1.xreh103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh103
            #add-point:ON ACTION controlp INFIELD xreh103 name="construct.c.page1.xreh103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh113
            #add-point:BEFORE FIELD xreh113 name="construct.b.page1.xreh113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh113
            
            #add-point:AFTER FIELD xreh113 name="construct.a.page1.xreh113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh113
            #add-point:ON ACTION controlp INFIELD xreh113 name="construct.c.page1.xreh113"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh114
            #add-point:BEFORE FIELD xreh114 name="construct.b.page1.xreh114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh114
            
            #add-point:AFTER FIELD xreh114 name="construct.a.page1.xreh114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh114
            #add-point:ON ACTION controlp INFIELD xreh114 name="construct.c.page1.xreh114"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh115
            #add-point:BEFORE FIELD xreh115 name="construct.b.page1.xreh115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh115
            
            #add-point:AFTER FIELD xreh115 name="construct.a.page1.xreh115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xreh115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh115
            #add-point:ON ACTION controlp INFIELD xreh115 name="construct.c.page1.xreh115"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh033
            #add-point:BEFORE FIELD xreh033 name="construct.b.page2.xreh033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh033
            
            #add-point:AFTER FIELD xreh033 name="construct.a.page2.xreh033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh033
            #add-point:ON ACTION controlp INFIELD xreh033 name="construct.c.page2.xreh033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh019
            #add-point:BEFORE FIELD xreh019 name="construct.b.page2.xreh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh019
            
            #add-point:AFTER FIELD xreh019 name="construct.a.page2.xreh019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh019
            #add-point:ON ACTION controlp INFIELD xreh019 name="construct.c.page2.xreh019"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh019_desc
            #add-point:BEFORE FIELD xreh019_desc name="construct.b.page2.xreh019_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh019_desc
            
            #add-point:AFTER FIELD xreh019_desc name="construct.a.page2.xreh019_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh019_desc
            #add-point:ON ACTION controlp INFIELD xreh019_desc name="construct.c.page2.xreh019_desc"
            #應付科目 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "
            #161114-00017#1 add ------
            SELECT ooef017 INTO g_glaacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xreg_m.xregld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_glaacomp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xreg_m.xregld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161114-00017#1 add end---
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO xreh019
            DISPLAY g_qryparam.return1 TO xreh019_desc
            NEXT FIELD xreh019_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh034
            #add-point:BEFORE FIELD xreh034 name="construct.b.page2.xreh034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh034
            
            #add-point:AFTER FIELD xreh034 name="construct.a.page2.xreh034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh034
            #add-point:ON ACTION controlp INFIELD xreh034 name="construct.c.page2.xreh034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh034_desc
            #add-point:BEFORE FIELD xreh034_desc name="construct.b.page2.xreh034_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh034_desc
            
            #add-point:AFTER FIELD xreh034_desc name="construct.a.page2.xreh034_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh034_desc
            #add-point:ON ACTION controlp INFIELD xreh034_desc name="construct.c.page2.xreh034_desc"
            #重評價科目 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "
            #161114-00017#1 add ------
            SELECT ooef017 INTO g_glaacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_xreg_m.xregld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_glaacomp AND glaa014 = 'Y'
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_xreg_m.xregld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161114-00017#1 add end---
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO xreh034
            DISPLAY g_qryparam.return1 TO xreh034_desc
            NEXT FIELD xreh034_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh016
            #add-point:BEFORE FIELD xreh016 name="construct.b.page2.xreh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh016
            
            #add-point:AFTER FIELD xreh016 name="construct.a.page2.xreh016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh016
            #add-point:ON ACTION controlp INFIELD xreh016 name="construct.c.page2.xreh016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh016_desc
            #add-point:BEFORE FIELD xreh016_desc name="construct.b.page2.xreh016_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh016_desc
            
            #add-point:AFTER FIELD xreh016_desc name="construct.a.page2.xreh016_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh016_desc
            #add-point:ON ACTION controlp INFIELD xreh016_desc name="construct.c.page2.xreh016_desc"
            #業務人員 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO xreh016
            DISPLAY g_qryparam.return1 TO xreh016_desc
            NEXT FIELD xreh016_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh011
            #add-point:BEFORE FIELD xreh011 name="construct.b.page2.xreh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh011
            
            #add-point:AFTER FIELD xreh011 name="construct.a.page2.xreh011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh011
            #add-point:ON ACTION controlp INFIELD xreh011 name="construct.c.page2.xreh011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh011_desc
            #add-point:BEFORE FIELD xreh011_desc name="construct.b.page2.xreh011_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh011_desc
            
            #add-point:AFTER FIELD xreh011_desc name="construct.a.page2.xreh011_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh011_desc
            #add-point:ON ACTION controlp INFIELD xreh011_desc name="construct.c.page2.xreh011_desc"
            #業務部門 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO xreh011
            DISPLAY g_qryparam.return1 TO xreh011_desc
            NEXT FIELD xreh011_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh012
            #add-point:BEFORE FIELD xreh012 name="construct.b.page2.xreh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh012
            
            #add-point:AFTER FIELD xreh012 name="construct.a.page2.xreh012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh012
            #add-point:ON ACTION controlp INFIELD xreh012 name="construct.c.page2.xreh012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh012_desc
            #add-point:BEFORE FIELD xreh012_desc name="construct.b.page2.xreh012_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh012_desc
            
            #add-point:AFTER FIELD xreh012_desc name="construct.a.page2.xreh012_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh012_desc
            #add-point:ON ACTION controlp INFIELD xreh012_desc name="construct.c.page2.xreh012_desc"
            #責任中心 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.where = " ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()
            DISPLAY g_qryparam.return1 TO xreh012
            DISPLAY g_qryparam.return1 TO xreh012_desc
            NEXT FIELD xreh012_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh013
            #add-point:BEFORE FIELD xreh013 name="construct.b.page2.xreh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh013
            
            #add-point:AFTER FIELD xreh013 name="construct.a.page2.xreh013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh013
            #add-point:ON ACTION controlp INFIELD xreh013 name="construct.c.page2.xreh013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh013_desc
            #add-point:BEFORE FIELD xreh013_desc name="construct.b.page2.xreh013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh013_desc
            
            #add-point:AFTER FIELD xreh013_desc name="construct.a.page2.xreh013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh013_desc
            #add-point:ON ACTION controlp INFIELD xreh013_desc name="construct.c.page2.xreh013_desc"
            #區域 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()
            DISPLAY g_qryparam.return1 TO xreh013
            DISPLAY g_qryparam.return1 TO xreh013_desc
            NEXT FIELD xreh013_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh014
            #add-point:BEFORE FIELD xreh014 name="construct.b.page2.xreh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh014
            
            #add-point:AFTER FIELD xreh014 name="construct.a.page2.xreh014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh014
            #add-point:ON ACTION controlp INFIELD xreh014 name="construct.c.page2.xreh014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh014_desc
            #add-point:BEFORE FIELD xreh014_desc name="construct.b.page2.xreh014_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh014_desc
            
            #add-point:AFTER FIELD xreh014_desc name="construct.a.page2.xreh014_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh014_desc
            #add-point:ON ACTION controlp INFIELD xreh014_desc name="construct.c.page2.xreh014_desc"
            #客群 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()
            DISPLAY g_qryparam.return1 TO xreh014
            DISPLAY g_qryparam.return1 TO xreh014_desc
            NEXT FIELD xreh014_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh015
            #add-point:BEFORE FIELD xreh015 name="construct.b.page2.xreh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh015
            
            #add-point:AFTER FIELD xreh015 name="construct.a.page2.xreh015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh015
            #add-point:ON ACTION controlp INFIELD xreh015 name="construct.c.page2.xreh015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh015_desc
            #add-point:BEFORE FIELD xreh015_desc name="construct.b.page2.xreh015_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh015_desc
            
            #add-point:AFTER FIELD xreh015_desc name="construct.a.page2.xreh015_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh015_desc
            #add-point:ON ACTION controlp INFIELD xreh015_desc name="construct.c.page2.xreh015_desc"
            #產品類別 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()
            DISPLAY g_qryparam.return1 TO xreh015
            DISPLAY g_qryparam.return1 TO xreh015_desc
            NEXT FIELD xreh015_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh017
            #add-point:BEFORE FIELD xreh017 name="construct.b.page2.xreh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh017
            
            #add-point:AFTER FIELD xreh017 name="construct.a.page2.xreh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh017
            #add-point:ON ACTION controlp INFIELD xreh017 name="construct.c.page2.xreh017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh017_desc
            #add-point:BEFORE FIELD xreh017_desc name="construct.b.page2.xreh017_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh017_desc
            
            #add-point:AFTER FIELD xreh017_desc name="construct.a.page2.xreh017_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh017_desc
            #add-point:ON ACTION controlp INFIELD xreh017_desc name="construct.c.page2.xreh017_desc"
            #專案代號 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()
            DISPLAY g_qryparam.return1 TO xreh017
            DISPLAY g_qryparam.return1 TO xreh017_desc
            NEXT FIELD xreh017_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh018
            #add-point:BEFORE FIELD xreh018 name="construct.b.page2.xreh018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh018
            
            #add-point:AFTER FIELD xreh018 name="construct.a.page2.xreh018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh018
            #add-point:ON ACTION controlp INFIELD xreh018 name="construct.c.page2.xreh018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh018_desc
            #add-point:BEFORE FIELD xreh018_desc name="construct.b.page2.xreh018_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh018_desc
            
            #add-point:AFTER FIELD xreh018_desc name="construct.a.page2.xreh018_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh018_desc
            #add-point:ON ACTION controlp INFIELD xreh018_desc name="construct.c.page2.xreh018_desc"
            #WBS #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "pjbb012='1'"
            CALL q_pjbb002()
            DISPLAY g_qryparam.return1 TO xreh018
            DISPLAY g_qryparam.return1 TO xreh018_desc
            NEXT FIELD xreh018_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh020
            #add-point:BEFORE FIELD xreh020 name="construct.b.page2.xreh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh020
            
            #add-point:AFTER FIELD xreh020 name="construct.a.page2.xreh020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh020
            #add-point:ON ACTION controlp INFIELD xreh020 name="construct.c.page2.xreh020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh020_desc
            #add-point:BEFORE FIELD xreh020_desc name="construct.b.page2.xreh020_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh020_desc
            
            #add-point:AFTER FIELD xreh020_desc name="construct.a.page2.xreh020_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh020_desc
            #add-point:ON ACTION controlp INFIELD xreh020_desc name="construct.c.page2.xreh020_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh021
            #add-point:BEFORE FIELD xreh021 name="construct.b.page2.xreh021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh021
            
            #add-point:AFTER FIELD xreh021 name="construct.a.page2.xreh021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh021
            #add-point:ON ACTION controlp INFIELD xreh021 name="construct.c.page2.xreh021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh021_desc
            #add-point:BEFORE FIELD xreh021_desc name="construct.b.page2.xreh021_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh021_desc
            
            #add-point:AFTER FIELD xreh021_desc name="construct.a.page2.xreh021_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh021_desc
            #add-point:ON ACTION controlp INFIELD xreh021_desc name="construct.c.page2.xreh021_desc"
            #渠道 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_2()
            DISPLAY g_qryparam.return1 TO xreh021
            DISPLAY g_qryparam.return1 TO xreh021_desc
            NEXT FIELD xreh021_desc
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh022
            #add-point:BEFORE FIELD xreh022 name="construct.b.page2.xreh022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh022
            
            #add-point:AFTER FIELD xreh022 name="construct.a.page2.xreh022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh022
            #add-point:ON ACTION controlp INFIELD xreh022 name="construct.c.page2.xreh022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh022_desc
            #add-point:BEFORE FIELD xreh022_desc name="construct.b.page2.xreh022_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh022_desc
            
            #add-point:AFTER FIELD xreh022_desc name="construct.a.page2.xreh022_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xreh022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh022_desc
            #add-point:ON ACTION controlp INFIELD xreh022_desc name="construct.c.page2.xreh022_desc"
            #品牌 #150302
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()
            DISPLAY g_qryparam.return1 TO xreh022
            DISPLAY g_qryparam.return1 TO xreh022_desc
            NEXT FIELD xreh022_desc
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#65 add
         #140415 因第一頁籤增加sum所以此要增加DISPLAY才可以查詢
         LET g_xreh_d[1].xrehorga = ''
         DISPLAY ARRAY g_xreh_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
                  WHEN la_wc[li_idx].tableid = "xreg_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xreh_t" 
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
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc," AND xreg003 = 'AP' "
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
 
{<section id="aapt920.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt920_filter()
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
      CONSTRUCT g_wc_filter ON xregld,xregsite,xreg004,xregdocno,xregdocdt,xreg001,xreg002,xreg005
                          FROM s_browse[1].b_xregld,s_browse[1].b_xregsite,s_browse[1].b_xreg004,s_browse[1].b_xregdocno, 
                              s_browse[1].b_xregdocdt,s_browse[1].b_xreg001,s_browse[1].b_xreg002,s_browse[1].b_xreg005 
 
 
         BEFORE CONSTRUCT
               DISPLAY aapt920_filter_parser('xregld') TO s_browse[1].b_xregld
            DISPLAY aapt920_filter_parser('xregsite') TO s_browse[1].b_xregsite
            DISPLAY aapt920_filter_parser('xreg004') TO s_browse[1].b_xreg004
            DISPLAY aapt920_filter_parser('xregdocno') TO s_browse[1].b_xregdocno
            DISPLAY aapt920_filter_parser('xregdocdt') TO s_browse[1].b_xregdocdt
            DISPLAY aapt920_filter_parser('xreg001') TO s_browse[1].b_xreg001
            DISPLAY aapt920_filter_parser('xreg002') TO s_browse[1].b_xreg002
            DISPLAY aapt920_filter_parser('xreg005') TO s_browse[1].b_xreg005
      
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
 
      CALL aapt920_filter_show('xregld')
   CALL aapt920_filter_show('xregsite')
   CALL aapt920_filter_show('xreg004')
   CALL aapt920_filter_show('xregdocno')
   CALL aapt920_filter_show('xregdocdt')
   CALL aapt920_filter_show('xreg001')
   CALL aapt920_filter_show('xreg002')
   CALL aapt920_filter_show('xreg005')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt920_filter_parser(ps_field)
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
 
{<section id="aapt920.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt920_filter_show(ps_field)
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
   LET ls_condition = aapt920_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt920_query()
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
   CALL g_xreh_d.clear()
   CALL g_xreh2_d.clear()
   CALL g_xreh3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt920_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt920_browser_fill("")
      CALL aapt920_fetch("")
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
      CALL aapt920_filter_show('xregld')
   CALL aapt920_filter_show('xregsite')
   CALL aapt920_filter_show('xreg004')
   CALL aapt920_filter_show('xregdocno')
   CALL aapt920_filter_show('xregdocdt')
   CALL aapt920_filter_show('xreg001')
   CALL aapt920_filter_show('xreg002')
   CALL aapt920_filter_show('xreg005')
   CALL aapt920_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt920_fetch("F") 
      #顯示單身筆數
      CALL aapt920_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt920_fetch(p_flag)
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
   
   LET g_xreg_m.xregdocno = g_browser[g_current_idx].b_xregdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
   #遮罩相關處理
   LET g_xreg_m_mask_o.* =  g_xreg_m.*
   CALL aapt920_xreg_t_mask()
   LET g_xreg_m_mask_n.* =  g_xreg_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt920_set_act_visible()   
   CALL aapt920_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xreg_m_t.* = g_xreg_m.*
   LET g_xreg_m_o.* = g_xreg_m.*
   
   LET g_data_owner = g_xreg_m.xregownid      
   LET g_data_dept  = g_xreg_m.xregowndp
   
   #重新顯示   
   CALL aapt920_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt920_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xreh_d.clear()   
   CALL g_xreh2_d.clear()  
   CALL g_xreh3_d.clear()  
 
 
   INITIALIZE g_xreg_m.* TO NULL             #DEFAULT 設定
   
   LET g_xregdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xreg_m.xregownid = g_user
      LET g_xreg_m.xregowndp = g_dept
      LET g_xreg_m.xregcrtid = g_user
      LET g_xreg_m.xregcrtdp = g_dept 
      LET g_xreg_m.xregcrtdt = cl_get_current()
      LET g_xreg_m.xregmodid = g_user
      LET g_xreg_m.xregmoddt = cl_get_current()
      LET g_xreg_m.xregstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xreg_m_t.* = g_xreg_m.*
      LET g_xreg_m_o.* = g_xreg_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xreg_m.xregstus 
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
 
 
 
    
      CALL aapt920_input("a")
      
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
         INITIALIZE g_xreg_m.* TO NULL
         INITIALIZE g_xreh_d TO NULL
         INITIALIZE g_xreh2_d TO NULL
         INITIALIZE g_xreh3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt920_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xreh_d.clear()
      #CALL g_xreh2_d.clear()
      #CALL g_xreh3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt920_set_act_visible()   
   CALL aapt920_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xregdocno_t = g_xreg_m.xregdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xregent = " ||g_enterprise|| " AND",
                      " xregdocno = '", g_xreg_m.xregdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt920_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt920_cl
   
   CALL aapt920_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
   
   #遮罩相關處理
   LET g_xreg_m_mask_o.* =  g_xreg_m.*
   CALL aapt920_xreg_t_mask()
   LET g_xreg_m_mask_n.* =  g_xreg_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc, 
       g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001, 
       g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtdt, 
       g_xreg_m.xregcrtid,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid,g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfdt, 
       g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregcnfid_desc
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_xreg_m.xregownid      
   LET g_data_dept  = g_xreg_m.xregowndp
   
   #功能已完成,通報訊息中心
   CALL aapt920_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt920_modify()
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
   LET g_xreg_m_t.* = g_xreg_m.*
   LET g_xreg_m_o.* = g_xreg_m.*
   
   IF g_xreg_m.xregdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xregdocno_t = g_xreg_m.xregdocno
 
   CALL s_transaction_begin()
   
   OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt920_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt920_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
   #檢查是否允許此動作
   IF NOT aapt920_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xreg_m_mask_o.* =  g_xreg_m.*
   CALL aapt920_xreg_t_mask()
   LET g_xreg_m_mask_n.* =  g_xreg_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aapt920_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_xregdocno_t = g_xreg_m.xregdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xreg_m.xregmodid = g_user 
LET g_xreg_m.xregmoddt = cl_get_current()
LET g_xreg_m.xregmodid_desc = cl_get_username(g_xreg_m.xregmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_xreg_m.xregstus MATCHES "[DR]" THEN
         LET g_xreg_m.xregstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt920_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xreg_t SET (xregmodid,xregmoddt) = (g_xreg_m.xregmodid,g_xreg_m.xregmoddt)
          WHERE xregent = g_enterprise AND xregdocno = g_xregdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xreg_m.* = g_xreg_m_t.*
            CALL aapt920_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xreg_m.xregdocno != g_xreg_m_t.xregdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xreh_t SET xrehdocno = g_xreg_m.xregdocno
 
          WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m_t.xregdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
            AND xreg003 ='AP'
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xreh_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
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
   CALL aapt920_set_act_visible()   
   CALL aapt920_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xregent = " ||g_enterprise|| " AND",
                      " xregdocno = '", g_xreg_m.xregdocno, "' "
 
   #填到對應位置
   CALL aapt920_browser_fill("")
 
   CLOSE aapt920_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt920_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt920.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt920_input(p_cmd)
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
   DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc, 
       g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001, 
       g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtdt, 
       g_xreg_m.xregcrtid,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid,g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfdt, 
       g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregcnfid_desc
   
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
   LET g_forupd_sql = "SELECT xrehld,xrehseq,xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009,xreh008, 
       xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xrehld,xrehseq,xreh033,xreh019,xreh034, 
       xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020,xreh021,xreh022,xreh023, 
       xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032,xrehld,xrehseq,xreh121, 
       xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135 FROM xreh_t WHERE xrehent=? AND xrehdocno=?  
       AND xrehld=? AND xrehseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt920_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt920_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt920_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno,g_xreg_m.xregdocdt, 
       g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xregstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt920.input.head" >}
      #單頭段
      INPUT BY NAME g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno,g_xreg_m.xregdocdt, 
          g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xregstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt920_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt920_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt920_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa121') RETURNING g_sub_success,l_glaa121  #141218-00011#6
            #end add-point
            CALL aapt920_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregsite
            
            #add-point:AFTER FIELD xregsite name="input.a.xregsite"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregsite
            #add-point:BEFORE FIELD xregsite name="input.b.xregsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregsite
            #add-point:ON CHANGE xregsite name="input.g.xregsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregld
            
            #add-point:AFTER FIELD xregld name="input.a.xregld"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregld
            #add-point:BEFORE FIELD xregld name="input.b.xregld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregld
            #add-point:ON CHANGE xregld name="input.g.xregld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg004
            
            #add-point:AFTER FIELD xreg004 name="input.a.xreg004"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg004
            #add-point:BEFORE FIELD xreg004 name="input.b.xreg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg004
            #add-point:ON CHANGE xreg004 name="input.g.xreg004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocno
            #add-point:BEFORE FIELD xregdocno name="input.b.xregdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocno
            
            #add-point:AFTER FIELD xregdocno name="input.a.xregdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xreg_m.xregdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xreg_m.xregdocno != g_xregdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xreg_t WHERE "||"xregent = '" ||g_enterprise|| "' AND "||"xregdocno = '"||g_xreg_m.xregdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocno
            #add-point:ON CHANGE xregdocno name="input.g.xregdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregdocdt
            #add-point:BEFORE FIELD xregdocdt name="input.b.xregdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregdocdt
            
            #add-point:AFTER FIELD xregdocdt name="input.a.xregdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregdocdt
            #add-point:ON CHANGE xregdocdt name="input.g.xregdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg001
            #add-point:BEFORE FIELD xreg001 name="input.b.xreg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg001
            
            #add-point:AFTER FIELD xreg001 name="input.a.xreg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg001
            #add-point:ON CHANGE xreg001 name="input.g.xreg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreg002
            #add-point:BEFORE FIELD xreg002 name="input.b.xreg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreg002
            
            #add-point:AFTER FIELD xreg002 name="input.a.xreg002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreg002
            #add-point:ON CHANGE xreg002 name="input.g.xreg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xregstus
            #add-point:BEFORE FIELD xregstus name="input.b.xregstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xregstus
            
            #add-point:AFTER FIELD xregstus name="input.a.xregstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xregstus
            #add-point:ON CHANGE xregstus name="input.g.xregstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xregsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregsite
            #add-point:ON ACTION controlp INFIELD xregsite name="input.c.xregsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregld
            #add-point:ON ACTION controlp INFIELD xregld name="input.c.xregld"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg004
            #add-point:ON ACTION controlp INFIELD xreg004 name="input.c.xreg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocno
            #add-point:ON ACTION controlp INFIELD xregdocno name="input.c.xregdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregdocdt
            #add-point:ON ACTION controlp INFIELD xregdocdt name="input.c.xregdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg001
            #add-point:ON ACTION controlp INFIELD xreg001 name="input.c.xreg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xreg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreg002
            #add-point:ON ACTION controlp INFIELD xreg002 name="input.c.xreg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xregstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xregstus
            #add-point:ON ACTION controlp INFIELD xregstus name="input.c.xregstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xreg_m.xregdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xreg_t (xregent,xregsite,xregld,xreg004,xregdocno,xregdocdt,xreg001,xreg002, 
                   xreg005,xregstus,xregownid,xregcrtdp,xregowndp,xregcrtdt,xregcrtid,xregmodid,xregcnfdt, 
                   xregmoddt,xregcnfid)
               VALUES (g_enterprise,g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno, 
                   g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
                   g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
                   g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xreg_m:",SQLERRMESSAGE 
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
                  CALL aapt920_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt920_b_fill()
                  CALL aapt920_b_fill2('0')
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
               CALL aapt920_xreg_t_mask_restore('restore_mask_o')
               
               UPDATE xreg_t SET (xregsite,xregld,xreg004,xregdocno,xregdocdt,xreg001,xreg002,xreg005, 
                   xregstus,xregownid,xregcrtdp,xregowndp,xregcrtdt,xregcrtid,xregmodid,xregcnfdt,xregmoddt, 
                   xregcnfid) = (g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004,g_xreg_m.xregdocno, 
                   g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
                   g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
                   g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid)
                WHERE xregent = g_enterprise AND xregdocno = g_xregdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xreg_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt920_xreg_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xreg_m_t)
               LET g_log2 = util.JSON.stringify(g_xreg_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xregdocno_t = g_xreg_m.xregdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt920.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xreh_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            #修改時強制進入頁籤二用，頁籤一不開放
            NEXT FIELD xreh033
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xreh_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt920_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2','3',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xreh_d.getLength()
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
            OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt920_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt920_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xreh_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xreh_d[l_ac].xrehld IS NOT NULL
               AND g_xreh_d[l_ac].xrehseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xreh_d_t.* = g_xreh_d[l_ac].*  #BACKUP
               LET g_xreh_d_o.* = g_xreh_d[l_ac].*  #BACKUP
               CALL aapt920_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt920_set_no_entry_b(l_cmd)
               IF NOT aapt920_lock_b("xreh_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt920_bcl INTO g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq,g_xreh_d[l_ac].xrehorga, 
                      g_xreh_d[l_ac].xreh004,g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006,g_xreh_d[l_ac].xreh007, 
                      g_xreh_d[l_ac].xreh009,g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100,g_xreh_d[l_ac].xreh102, 
                      g_xreh_d[l_ac].xreh101,g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113,g_xreh_d[l_ac].xreh114, 
                      g_xreh_d[l_ac].xreh115,g_xreh2_d[l_ac].xrehld,g_xreh2_d[l_ac].xrehseq,g_xreh2_d[l_ac].xreh033, 
                      g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh011, 
                      g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014,g_xreh2_d[l_ac].xreh015, 
                      g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020,g_xreh2_d[l_ac].xreh021, 
                      g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024,g_xreh2_d[l_ac].xreh025, 
                      g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028,g_xreh2_d[l_ac].xreh029, 
                      g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032,g_xreh3_d[l_ac].xrehld, 
                      g_xreh3_d[l_ac].xrehseq,g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123,g_xreh3_d[l_ac].xreh124, 
                      g_xreh3_d[l_ac].xreh125,g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133,g_xreh3_d[l_ac].xreh134, 
                      g_xreh3_d[l_ac].xreh135
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xreh_d_t.xrehld,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xreh_d_mask_o[l_ac].* =  g_xreh_d[l_ac].*
                  CALL aapt920_xreh_t_mask()
                  LET g_xreh_d_mask_n[l_ac].* =  g_xreh_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt920_show()
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
            INITIALIZE g_xreh_d[l_ac].* TO NULL 
            INITIALIZE g_xreh_d_t.* TO NULL 
            INITIALIZE g_xreh_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_xreh_d[l_ac].xrehseq = "0"
      LET g_xreh_d[l_ac].xreh103 = "0"
      LET g_xreh_d[l_ac].xreh113 = "0"
      LET g_xreh_d[l_ac].xreh114 = "0"
      LET g_xreh_d[l_ac].xreh115 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xreh_d_t.* = g_xreh_d[l_ac].*     #新輸入資料
            LET g_xreh_d_o.* = g_xreh_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt920_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt920_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xreh_d[li_reproduce_target].* = g_xreh_d[li_reproduce].*
               LET g_xreh2_d[li_reproduce_target].* = g_xreh2_d[li_reproduce].*
               LET g_xreh3_d[li_reproduce_target].* = g_xreh3_d[li_reproduce].*
 
               LET g_xreh_d[li_reproduce_target].xrehld = NULL
               LET g_xreh_d[li_reproduce_target].xrehseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM xreh_t 
             WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m.xregdocno
 
               AND xrehld = g_xreh_d[l_ac].xrehld
               AND xrehseq = g_xreh_d[l_ac].xrehseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xreg_m.xregdocno
               LET gs_keys[2] = g_xreh_d[g_detail_idx].xrehld
               LET gs_keys[3] = g_xreh_d[g_detail_idx].xrehseq
               CALL aapt920_insert_b('xreh_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xreh_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt920_b_fill()
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
               LET gs_keys[01] = g_xreg_m.xregdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xreh_d_t.xrehld
               LET gs_keys[gs_keys.getLength()+1] = g_xreh_d_t.xrehseq
 
            
               #刪除同層單身
               IF NOT aapt920_delete_b('xreh_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt920_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt920_key_delete_b(gs_keys,'xreh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt920_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt920_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xreh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xreh_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xrehorga
            #add-point:BEFORE FIELD xrehorga name="input.b.page1.xrehorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xrehorga
            
            #add-point:AFTER FIELD xrehorga name="input.a.page1.xrehorga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xrehorga
            #add-point:ON CHANGE xrehorga name="input.g.page1.xrehorga"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xrehorga
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xrehorga
            #add-point:ON ACTION controlp INFIELD xrehorga name="input.c.page1.xrehorga"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xreh_d[l_ac].* = g_xreh_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt920_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xreh_d[l_ac].xrehld 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xreh_d[l_ac].* = g_xreh_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt920_xreh_t_mask_restore('restore_mask_o')
      
               UPDATE xreh_t SET (xrehdocno,xrehld,xrehseq,xrehorga,xreh004,xreh005,xreh006,xreh007, 
                   xreh009,xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xreh033,xreh019, 
                   xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020,xreh021, 
                   xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032, 
                   xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135) = (g_xreg_m.xregdocno, 
                   g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq,g_xreh_d[l_ac].xrehorga,g_xreh_d[l_ac].xreh004, 
                   g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006,g_xreh_d[l_ac].xreh007,g_xreh_d[l_ac].xreh009, 
                   g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100,g_xreh_d[l_ac].xreh102,g_xreh_d[l_ac].xreh101, 
                   g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113,g_xreh_d[l_ac].xreh114,g_xreh_d[l_ac].xreh115, 
                   g_xreh2_d[l_ac].xreh033,g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016, 
                   g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014, 
                   g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020, 
                   g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024, 
                   g_xreh2_d[l_ac].xreh025,g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028, 
                   g_xreh2_d[l_ac].xreh029,g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032, 
                   g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123,g_xreh3_d[l_ac].xreh124,g_xreh3_d[l_ac].xreh125, 
                   g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133,g_xreh3_d[l_ac].xreh134,g_xreh3_d[l_ac].xreh135) 
 
                WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m.xregdocno 
 
                  AND xrehld = g_xreh_d_t.xrehld #項次   
                  AND xrehseq = g_xreh_d_t.xrehseq  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xreh_d[l_ac].* = g_xreh_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xreh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xreh_d[l_ac].* = g_xreh_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xreg_m.xregdocno
               LET gs_keys_bak[1] = g_xregdocno_t
               LET gs_keys[2] = g_xreh_d[g_detail_idx].xrehld
               LET gs_keys_bak[2] = g_xreh_d_t.xrehld
               LET gs_keys[3] = g_xreh_d[g_detail_idx].xrehseq
               LET gs_keys_bak[3] = g_xreh_d_t.xrehseq
               CALL aapt920_update_b('xreh_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt920_xreh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xreh_d[g_detail_idx].xrehld = g_xreh_d_t.xrehld 
                  AND g_xreh_d[g_detail_idx].xrehseq = g_xreh_d_t.xrehseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xreg_m.xregdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xreh_d_t.xrehld
                  LET gs_keys[gs_keys.getLength()+1] = g_xreh_d_t.xrehseq
 
                  CALL aapt920_key_update_b(gs_keys,'xreh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xreg_m),util.JSON.stringify(g_xreh_d_t)
               LET g_log2 = util.JSON.stringify(g_xreg_m),util.JSON.stringify(g_xreh_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt920_unlock_b("xreh_t","'1'")
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
               LET g_xreh_d[li_reproduce_target].* = g_xreh_d[li_reproduce].*
               LET g_xreh2_d[li_reproduce_target].* = g_xreh2_d[li_reproduce].*
               LET g_xreh3_d[li_reproduce_target].* = g_xreh3_d[li_reproduce].*
 
               LET g_xreh_d[li_reproduce_target].xrehld = NULL
               LET g_xreh_d[li_reproduce_target].xrehseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xreh_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xreh_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xreh2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL aapt920_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xreh2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            #150507 add glaa121
            CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa004|glaa121') RETURNING  g_sub_success,g_glaa004,l_glaa121
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xreh2_d[l_ac].* TO NULL 
            INITIALIZE g_xreh2_d_t.* TO NULL 
            INITIALIZE g_xreh2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xreh2_d_t.* = g_xreh2_d[l_ac].*     #新輸入資料
            LET g_xreh2_d_o.* = g_xreh2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt920_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt920_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xreh_d[li_reproduce_target].* = g_xreh_d[li_reproduce].*
               LET g_xreh2_d[li_reproduce_target].* = g_xreh2_d[li_reproduce].*
               LET g_xreh3_d[li_reproduce_target].* = g_xreh3_d[li_reproduce].*
 
               LET g_xreh2_d[li_reproduce_target].xrehld = NULL
               LET g_xreh2_d[li_reproduce_target].xrehseq = NULL
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
            OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt920_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt920_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xreh2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xreh2_d[l_ac].xrehld IS NOT NULL
               AND g_xreh2_d[l_ac].xrehseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xreh2_d_t.* = g_xreh2_d[l_ac].*  #BACKUP
               LET g_xreh2_d_o.* = g_xreh2_d[l_ac].*  #BACKUP
               CALL aapt920_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL aapt920_set_no_entry_b(l_cmd)
               IF NOT aapt920_lock_b("xreh_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt920_bcl INTO g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq,g_xreh_d[l_ac].xrehorga, 
                      g_xreh_d[l_ac].xreh004,g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006,g_xreh_d[l_ac].xreh007, 
                      g_xreh_d[l_ac].xreh009,g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100,g_xreh_d[l_ac].xreh102, 
                      g_xreh_d[l_ac].xreh101,g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113,g_xreh_d[l_ac].xreh114, 
                      g_xreh_d[l_ac].xreh115,g_xreh2_d[l_ac].xrehld,g_xreh2_d[l_ac].xrehseq,g_xreh2_d[l_ac].xreh033, 
                      g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh011, 
                      g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014,g_xreh2_d[l_ac].xreh015, 
                      g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020,g_xreh2_d[l_ac].xreh021, 
                      g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024,g_xreh2_d[l_ac].xreh025, 
                      g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028,g_xreh2_d[l_ac].xreh029, 
                      g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032,g_xreh3_d[l_ac].xrehld, 
                      g_xreh3_d[l_ac].xrehseq,g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123,g_xreh3_d[l_ac].xreh124, 
                      g_xreh3_d[l_ac].xreh125,g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133,g_xreh3_d[l_ac].xreh134, 
                      g_xreh3_d[l_ac].xreh135
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xreh2_d_mask_o[l_ac].* =  g_xreh2_d[l_ac].*
                  CALL aapt920_xreh_t_mask()
                  LET g_xreh2_d_mask_n[l_ac].* =  g_xreh2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt920_show()
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
               LET gs_keys[01] = g_xreg_m.xregdocno
               LET gs_keys[gs_keys.getLength()+1] = g_xreh2_d_t.xrehld
               LET gs_keys[gs_keys.getLength()+1] = g_xreh2_d_t.xrehseq
            
               #刪除同層單身
               IF NOT aapt920_delete_b('xreh_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt920_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt920_key_delete_b(gs_keys,'xreh_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt920_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt920_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xreh_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xreh2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xreh_t 
             WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m.xregdocno
               AND xrehld = g_xreh2_d[l_ac].xrehld
               AND xrehseq = g_xreh2_d[l_ac].xrehseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xreg_m.xregdocno
               LET gs_keys[2] = g_xreh2_d[g_detail_idx].xrehld
               LET gs_keys[3] = g_xreh2_d[g_detail_idx].xrehseq
               CALL aapt920_insert_b('xreh_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xreh_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt920_b_fill()
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
               LET g_xreh2_d[l_ac].* = g_xreh2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt920_bcl
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
               LET g_xreh2_d[l_ac].* = g_xreh2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt920_xreh_t_mask_restore('restore_mask_o')
                              
               UPDATE xreh_t SET (xrehdocno,xrehld,xrehseq,xrehorga,xreh004,xreh005,xreh006,xreh007, 
                   xreh009,xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xreh033,xreh019, 
                   xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020,xreh021, 
                   xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032, 
                   xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135) = (g_xreg_m.xregdocno, 
                   g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq,g_xreh_d[l_ac].xrehorga,g_xreh_d[l_ac].xreh004, 
                   g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006,g_xreh_d[l_ac].xreh007,g_xreh_d[l_ac].xreh009, 
                   g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100,g_xreh_d[l_ac].xreh102,g_xreh_d[l_ac].xreh101, 
                   g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113,g_xreh_d[l_ac].xreh114,g_xreh_d[l_ac].xreh115, 
                   g_xreh2_d[l_ac].xreh033,g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016, 
                   g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014, 
                   g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020, 
                   g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024, 
                   g_xreh2_d[l_ac].xreh025,g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028, 
                   g_xreh2_d[l_ac].xreh029,g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032, 
                   g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123,g_xreh3_d[l_ac].xreh124,g_xreh3_d[l_ac].xreh125, 
                   g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133,g_xreh3_d[l_ac].xreh134,g_xreh3_d[l_ac].xreh135)  
                   #自訂欄位頁簽
                WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m.xregdocno
                  AND xrehld = g_xreh2_d_t.xrehld #項次 
                  AND xrehseq = g_xreh2_d_t.xrehseq
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xreh2_d[l_ac].* = g_xreh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xreh_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xreh2_d[l_ac].* = g_xreh2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xreg_m.xregdocno
               LET gs_keys_bak[1] = g_xregdocno_t
               LET gs_keys[2] = g_xreh2_d[g_detail_idx].xrehld
               LET gs_keys_bak[2] = g_xreh2_d_t.xrehld
               LET gs_keys[3] = g_xreh2_d[g_detail_idx].xrehseq
               LET gs_keys_bak[3] = g_xreh2_d_t.xrehseq
               CALL aapt920_update_b('xreh_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt920_xreh_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xreh2_d[g_detail_idx].xrehld = g_xreh2_d_t.xrehld 
                  AND g_xreh2_d[g_detail_idx].xrehseq = g_xreh2_d_t.xrehseq 
                  ) THEN
                  LET gs_keys[01] = g_xreg_m.xregdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xreh2_d_t.xrehld
                  LET gs_keys[gs_keys.getLength()+1] = g_xreh2_d_t.xrehseq
                  CALL aapt920_key_update_b(gs_keys,'xreh_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xreg_m),util.JSON.stringify(g_xreh2_d_t)
               LET g_log2 = util.JSON.stringify(g_xreg_m),util.JSON.stringify(g_xreh2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh033
            #add-point:BEFORE FIELD xreh033 name="input.b.page2.xreh033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh033
            
            #add-point:AFTER FIELD xreh033 name="input.a.page2.xreh033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh033
            #add-point:ON CHANGE xreh033 name="input.g.page2.xreh033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh019
            #add-point:BEFORE FIELD xreh019 name="input.b.page2.xreh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh019
            
            #add-point:AFTER FIELD xreh019 name="input.a.page2.xreh019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh019
            #add-point:ON CHANGE xreh019 name="input.g.page2.xreh019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh019_desc
            #add-point:BEFORE FIELD xreh019_desc name="input.b.page2.xreh019_desc"
            LET g_xreh2_d[l_ac].xreh019_desc = g_xreh2_d[l_ac].xreh019   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh019_desc
            
            #add-point:AFTER FIELD xreh019_desc name="input.a.page2.xreh019_desc"
            IF NOT cl_null(g_xreh2_d[l_ac].xreh019_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_xreg_m.xregld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh019_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_xreh2_d[l_ac].xreh019_desc
                LET g_qryparam.arg3 = g_xreg_m.xregld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                  LET g_xreh2_d[l_ac].xreh019 = g_qryparam.return1
                  LET g_xreh2_d[l_ac].xreh019_desc = g_qryparam.return1
                  DISPLAY BY NAME g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc  
              END IF
              IF NOT s_aglt310_lc_subject(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019_desc,'N') THEN
                     LET g_xreh2_d[l_ac].xreh019      = g_xreh2_d_t.xreh019
                        LET g_xreh2_d[l_ac].xreh019_desc = g_xreh2_d_t.xreh019_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc
                        NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               
               IF ( g_xreh2_d[l_ac].xreh019_desc != g_xreh2_d_t.xreh019_desc OR g_xreh2_d_t.xreh019_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh019 = g_xreh2_d[l_ac].xreh019_desc
                  IF (g_xreh2_d[l_ac].xreh019 != g_xreh2_d_t.xreh019 OR g_xreh2_d_t.xreh019 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_xreh2_d[l_ac].xreh019,g_xreg_m.xregld) RETURNING g_sub_success,g_errno
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
                        LET g_xreh2_d[l_ac].xreh019      = g_xreh2_d_t.xreh019
                        LET g_xreh2_d[l_ac].xreh019_desc = g_xreh2_d_t.xreh019_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh019 = ''
            END IF
            LET g_xreh2_d_t.xreh019_desc = g_xreh2_d[l_ac].xreh019_desc
            LET g_xreh2_d[l_ac].xreh019_desc = s_desc_show1(g_xreh2_d[l_ac].xreh019,s_desc_get_account_desc(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh019_desc
            #add-point:ON CHANGE xreh019_desc name="input.g.page2.xreh019_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh034
            #add-point:BEFORE FIELD xreh034 name="input.b.page2.xreh034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh034
            
            #add-point:AFTER FIELD xreh034 name="input.a.page2.xreh034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh034
            #add-point:ON CHANGE xreh034 name="input.g.page2.xreh034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh034_desc
            #add-point:BEFORE FIELD xreh034_desc name="input.b.page2.xreh034_desc"
            LET g_xreh2_d[l_ac].xreh034_desc = g_xreh2_d[l_ac].xreh034   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh034_desc
            
            #add-point:AFTER FIELD xreh034_desc name="input.a.page2.xreh034_desc"
            IF NOT cl_null(g_xreh2_d[l_ac].xreh034_desc) THEN
               #  150916-00015#1 BEGIN    快捷带出类似科目编号     ADD BY XZG201511207
              LET l_sql = ""
              IF  s_aglt310_getlike_lc_subject(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh034_desc,l_sql) THEN
                 INITIALIZE g_qryparam.* TO NULL
                 SELECT glaa004 INTO l_glaa004
                  FROM glaa_t
                 WHERE glaaent = g_enterprise
                   AND glaald = g_xreg_m.xregld
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = 'FALSE'
                LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh034_desc
                
                LET g_qryparam.arg1 = l_glaa004
                LET g_qryparam.arg2 = g_xreh2_d[l_ac].xreh034_desc
                LET g_qryparam.arg3 = g_xreg_m.xregld
                LET g_qryparam.arg4 = "1 "
                CALL q_glac002_6()
                LET g_xreh2_d[l_ac].xreh034 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh034_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc
              END IF
              IF NOT s_aglt310_lc_subject(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh034_desc,'N') THEN
                  LET g_xreh2_d[l_ac].xreh034      = g_xreh2_d_t.xreh034
                        LET g_xreh2_d[l_ac].xreh034_desc = g_xreh2_d_t.xreh034_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc
                        NEXT FIELD CURRENT
              END IF
 #  150916-00015#1 END
               IF ( g_xreh2_d[l_ac].xreh034_desc != g_xreh2_d_t.xreh034_desc OR g_xreh2_d_t.xreh034_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh034 = g_xreh2_d[l_ac].xreh034_desc
                  IF (g_xreh2_d[l_ac].xreh034 != g_xreh2_d_t.xreh034 OR g_xreh2_d_t.xreh034 IS NULL) THEN
                     CALL s_aap_glac002_chk(g_xreh2_d[l_ac].xreh034,g_xreg_m.xregld) RETURNING g_sub_success,g_errno
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
                        LET g_xreh2_d[l_ac].xreh034      = g_xreh2_d_t.xreh034
                        LET g_xreh2_d[l_ac].xreh034_desc = g_xreh2_d_t.xreh034_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh034 = ''
            END IF
            LET g_xreh2_d_t.xreh034_desc = g_xreh2_d[l_ac].xreh034_desc
            LET g_xreh2_d[l_ac].xreh034_desc = s_desc_show1(g_xreh2_d[l_ac].xreh034,s_desc_get_account_desc(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh034))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh034_desc
            #add-point:ON CHANGE xreh034_desc name="input.g.page2.xreh034_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh016
            #add-point:BEFORE FIELD xreh016 name="input.b.page2.xreh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh016
            
            #add-point:AFTER FIELD xreh016 name="input.a.page2.xreh016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh016
            #add-point:ON CHANGE xreh016 name="input.g.page2.xreh016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh016_desc
            #add-point:BEFORE FIELD xreh016_desc name="input.b.page2.xreh016_desc"
            LET g_xreh2_d[l_ac].xreh016_desc = g_xreh2_d[l_ac].xreh016   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh016_desc
            
            #add-point:AFTER FIELD xreh016_desc name="input.a.page2.xreh016_desc"
            #業務人員
            IF NOT cl_null(g_xreh2_d[l_ac].xreh016_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh016_desc != g_xreh2_d_t.xreh016_desc OR g_xreh2_d_t.xreh016_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh016 = g_xreh2_d[l_ac].xreh016_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh016 != g_xreh2_d_t.xreh016 OR g_xreh2_d_t.xreh016 IS NULL) THEN
                        CALL s_employee_chk(g_xreh2_d[l_ac].xreh016_desc) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_xreh2_d[l_ac].xreh016 = g_xreh2_d_t.xreh016
                           LET g_xreh2_d[l_ac].xreh016_desc = g_xreh2_d_t.xreh016_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh016_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh016 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh016_desc = s_desc_show1(g_xreh2_d[l_ac].xreh016,s_desc_get_person_desc(g_xreh2_d[l_ac].xreh016))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh016_desc
            LET g_xreh2_d_t.xreh016_desc = g_xreh2_d[l_ac].xreh016_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh016_desc
            #add-point:ON CHANGE xreh016_desc name="input.g.page2.xreh016_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh011
            #add-point:BEFORE FIELD xreh011 name="input.b.page2.xreh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh011
            
            #add-point:AFTER FIELD xreh011 name="input.a.page2.xreh011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh011
            #add-point:ON CHANGE xreh011 name="input.g.page2.xreh011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh011_desc
            #add-point:BEFORE FIELD xreh011_desc name="input.b.page2.xreh011_desc"
            LET g_xreh2_d[l_ac].xreh011_desc = g_xreh2_d[l_ac].xreh011   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh011_desc
            
            #add-point:AFTER FIELD xreh011_desc name="input.a.page2.xreh011_desc"
            #業務部門
            IF NOT cl_null(g_xreh2_d[l_ac].xreh011_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh011_desc != g_xreh2_d_t.xreh011_desc OR g_xreh2_d_t.xreh011_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh011 = g_xreh2_d[l_ac].xreh011_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh011 != g_xreh2_d_t.xreh011 OR g_xreh2_d_t.xreh011 IS NULL) THEN
                        CALL s_department_chk(g_xreh2_d[l_ac].xreh011_desc,g_xreg_m.xregdocdt) RETURNING g_sub_success
                        IF NOT g_sub_success THEN
                           LET g_xreh2_d[l_ac].xreh011 = g_xreh2_d_t.xreh011
                           LET g_xreh2_d[l_ac].xreh011_desc = g_xreh2_d_t.xreh011_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh011 ,g_xreh2_d[l_ac].xreh011_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh011 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh011_desc = s_desc_show1(g_xreh2_d[l_ac].xreh011,s_desc_get_department_desc(g_xreh2_d[l_ac].xreh011))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh011 ,g_xreh2_d[l_ac].xreh011_desc
            LET g_xreh2_d_t.xreh011_desc = g_xreh2_d[l_ac].xreh011_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh011_desc
            #add-point:ON CHANGE xreh011_desc name="input.g.page2.xreh011_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh012
            #add-point:BEFORE FIELD xreh012 name="input.b.page2.xreh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh012
            
            #add-point:AFTER FIELD xreh012 name="input.a.page2.xreh012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh012
            #add-point:ON CHANGE xreh012 name="input.g.page2.xreh012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh012_desc
            #add-point:BEFORE FIELD xreh012_desc name="input.b.page2.xreh012_desc"
            LET g_xreh2_d[l_ac].xreh012_desc = g_xreh2_d[l_ac].xreh012   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh012_desc
            
            #add-point:AFTER FIELD xreh012_desc name="input.a.page2.xreh012_desc"
            #責任中心
            IF NOT cl_null(g_xreh2_d[l_ac].xreh012_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh012_desc != g_xreh2_d_t.xreh012_desc OR g_xreh2_d_t.xreh012_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh012 = g_xreh2_d[l_ac].xreh012_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh012 != g_xreh2_d_t.xreh012 OR g_xreh2_d_t.xreh012 IS NULL) THEN
                        #CALL s_department_chk(g_xreh2_d[l_ac].xreh012_desc,g_xreg_m.xregdocdt) RETURNING g_sub_success #150302
                        CALL s_voucher_glaq019_chk(g_xreh2_d[l_ac].xreh012_desc,g_xreg_m.xregdocdt) #150302
                        #IF NOT g_sub_success THEN   #150507 mark
                        IF NOT cl_null(g_errno) THEN #150507
                           LET g_xreh2_d[l_ac].xreh012 = g_xreh2_d_t.xreh012
                           LET g_xreh2_d[l_ac].xreh012_desc = g_xreh2_d_t.xreh012_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh012_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh012 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh012_desc = s_desc_show1(g_xreh2_d[l_ac].xreh012,s_desc_get_department_desc(g_xreh2_d[l_ac].xreh012))         
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh012 ,g_xreh2_d[l_ac].xreh012_desc
            LET g_xreh2_d_t.xreh012_desc = g_xreh2_d[l_ac].xreh012_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh012_desc
            #add-point:ON CHANGE xreh012_desc name="input.g.page2.xreh012_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh013
            #add-point:BEFORE FIELD xreh013 name="input.b.page2.xreh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh013
            
            #add-point:AFTER FIELD xreh013 name="input.a.page2.xreh013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh013
            #add-point:ON CHANGE xreh013 name="input.g.page2.xreh013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh013_desc
            #add-point:BEFORE FIELD xreh013_desc name="input.b.page2.xreh013_desc"
            LET g_xreh2_d[l_ac].xreh013_desc = g_xreh2_d[l_ac].xreh013   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh013_desc
            
            #add-point:AFTER FIELD xreh013_desc name="input.a.page2.xreh013_desc"
            #區域
            IF NOT cl_null(g_xreh2_d[l_ac].xreh013_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh013_desc != g_xreh2_d_t.xreh013_desc OR g_xreh2_d_t.xreh013_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh013 = g_xreh2_d[l_ac].xreh013_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh013 != g_xreh2_d_t.xreh013 OR g_xreh2_d_t.xreh013 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('287',g_xreh2_d[l_ac].xreh013) THEN
                           LET g_xreh2_d[l_ac].xreh013 = g_xreh2_d_t.xreh013
                           LET g_xreh2_d[l_ac].xreh013_desc = g_xreh2_d_t.xreh013_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh013 ,g_xreh2_d[l_ac].xreh013_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_xreh2_d[l_ac].xreh013_desc = s_desc_show1(g_xreh2_d[l_ac].xreh013,s_desc_get_acc_desc('287',g_xreh2_d[l_ac].xreh013))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh013 ,g_xreh2_d[l_ac].xreh013_desc
            LET g_xreh2_d_t.xreh013_desc = g_xreh2_d[l_ac].xreh013_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh013_desc
            #add-point:ON CHANGE xreh013_desc name="input.g.page2.xreh013_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh014
            #add-point:BEFORE FIELD xreh014 name="input.b.page2.xreh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh014
            
            #add-point:AFTER FIELD xreh014 name="input.a.page2.xreh014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh014
            #add-point:ON CHANGE xreh014 name="input.g.page2.xreh014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh014_desc
            #add-point:BEFORE FIELD xreh014_desc name="input.b.page2.xreh014_desc"
            LET g_xreh2_d[l_ac].xreh014_desc = g_xreh2_d[l_ac].xreh014   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh014_desc
            
            #add-point:AFTER FIELD xreh014_desc name="input.a.page2.xreh014_desc"
            #客群
            IF NOT cl_null(g_xreh2_d[l_ac].xreh014_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh014_desc != g_xreh2_d_t.xreh014_desc OR g_xreh2_d_t.xreh014_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh014 = g_xreh2_d[l_ac].xreh014_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh014 != g_xreh2_d_t.xreh014 OR g_xreh2_d_t.xreh014 IS NULL) THEN
                        IF NOT s_azzi650_chk_exist('281',g_xreh2_d[l_ac].xreh014) THEN
                           LET g_xreh2_d[l_ac].xreh014 = g_xreh2_d_t.xreh014
                           LET g_xreh2_d[l_ac].xreh014_desc = g_xreh2_d_t.xreh014_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh014 ,g_xreh2_d[l_ac].xreh014_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh014 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh014_desc = s_desc_show1(g_xreh2_d[l_ac].xreh014,s_desc_get_acc_desc('281',g_xreh2_d[l_ac].xreh014))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh014 ,g_xreh2_d[l_ac].xreh014_desc
            LET g_xreh2_d_t.xreh014_desc = g_xreh2_d[l_ac].xreh014_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh014_desc
            #add-point:ON CHANGE xreh014_desc name="input.g.page2.xreh014_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh015
            #add-point:BEFORE FIELD xreh015 name="input.b.page2.xreh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh015
            
            #add-point:AFTER FIELD xreh015 name="input.a.page2.xreh015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh015
            #add-point:ON CHANGE xreh015 name="input.g.page2.xreh015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh015_desc
            #add-point:BEFORE FIELD xreh015_desc name="input.b.page2.xreh015_desc"
            LET g_xreh2_d[l_ac].xreh015_desc = g_xreh2_d[l_ac].xreh015   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh015_desc
            
            #add-point:AFTER FIELD xreh015_desc name="input.a.page2.xreh015_desc"
            #產品類別
            IF NOT cl_null(g_xreh2_d[l_ac].xreh015_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh015_desc != g_xreh2_d_t.xreh015_desc OR g_xreh2_d_t.xreh015_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh015 = g_xreh2_d[l_ac].xreh015_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh015 != g_xreh2_d_t.xreh015 OR g_xreh2_d_t.xreh015 IS NULL) THEN
                        CALL s_voucher_glaq024_chk(g_xreh2_d[l_ac].xreh015) 
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
                           LET g_xreh2_d[l_ac].xreh015 = g_xreh2_d_t.xreh015
                           LET g_xreh2_d[l_ac].xreh015_desc = g_xreh2_d_t.xreh015_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh015 ,g_xreh2_d[l_ac].xreh015_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh015 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh015_desc = s_desc_show1(g_xreh2_d[l_ac].xreh015,s_desc_get_rtaxl003_desc(g_xreh2_d[l_ac].xreh015))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh015 ,g_xreh2_d[l_ac].xreh015_desc
            LET g_xreh2_d_t.xreh015_desc = g_xreh2_d[l_ac].xreh015_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh015_desc
            #add-point:ON CHANGE xreh015_desc name="input.g.page2.xreh015_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh017
            #add-point:BEFORE FIELD xreh017 name="input.b.page2.xreh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh017
            
            #add-point:AFTER FIELD xreh017 name="input.a.page2.xreh017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh017
            #add-point:ON CHANGE xreh017 name="input.g.page2.xreh017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh017_desc
            #add-point:BEFORE FIELD xreh017_desc name="input.b.page2.xreh017_desc"
            LET g_xreh2_d[l_ac].xreh017_desc = g_xreh2_d[l_ac].xreh017   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh017_desc
            
            #add-point:AFTER FIELD xreh017_desc name="input.a.page2.xreh017_desc"
            #專案代號
            IF NOT cl_null(g_xreh2_d[l_ac].xreh017_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh017_desc != g_xreh2_d_t.xreh017_desc OR g_xreh2_d_t.xreh017_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh017 = g_xreh2_d[l_ac].xreh017_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh017 != g_xreh2_d_t.xreh017 OR g_xreh2_d_t.xreh017 IS NULL) THEN
                        CALL s_aap_project_chk( g_xreh2_d[l_ac].xreh017) RETURNING g_sub_success,g_errno
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
                           LET g_xreh2_d[l_ac].xreh017      = g_xreh2_d_t.xreh017
                           LET g_xreh2_d[l_ac].xreh017_desc = g_xreh2_d_t.xreh017_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh017_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh017 = ''                 
            END IF
            LET g_xreh2_d[l_ac].xreh017_desc = s_desc_show1(g_xreh2_d[l_ac].xreh017,s_desc_get_project_desc(g_xreh2_d[l_ac].xreh017))
            LET g_xreh2_d_t.xreh017 = g_xreh2_d[l_ac].xreh017_desc
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh017_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh017_desc
            #add-point:ON CHANGE xreh017_desc name="input.g.page2.xreh017_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh018
            #add-point:BEFORE FIELD xreh018 name="input.b.page2.xreh018"
            LET g_xreh2_d[l_ac].xreh018_desc = g_xreh2_d[l_ac].xreh018   #150302
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh018
            
            #add-point:AFTER FIELD xreh018 name="input.a.page2.xreh018"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh018
            #add-point:ON CHANGE xreh018 name="input.g.page2.xreh018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh018_desc
            #add-point:BEFORE FIELD xreh018_desc name="input.b.page2.xreh018_desc"
            LET g_xreh2_d[l_ac].xreh018_desc = g_xreh2_d[l_ac].xreh018   #150302
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh018_desc
            
            #add-point:AFTER FIELD xreh018_desc name="input.a.page2.xreh018_desc"
            #150302 add---
            #WBS
            IF NOT cl_null(g_xreh2_d[l_ac].xreh018_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh018_desc != g_xreh2_d_t.xreh018_desc OR g_xreh2_d_t.xreh018_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh018 = g_xreh2_d[l_ac].xreh018_desc
                  IF l_glaa121 = 'N' THEN
                     IF (g_xreh2_d[l_ac].xreh018 != g_xreh2_d_t.xreh018 OR g_xreh2_d_t.xreh018 IS NULL) THEN
                        CALL s_voucher_glaq028_chk(g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018)
                        #150507 mark ---
                        #IF NOT g_sub_success THEN
                        #   INITIALIZE g_errparam TO NULL
                        #   LET g_errparam.code = g_errno
                        #   LET g_errparam.extend = ''
                        #   LET g_errparam.popup = TRUE
                        #   CALL cl_err()
                        #150507 mark end---
                        IF NOT cl_null(g_errno) THEN #150507
                           LET g_xreh2_d[l_ac].xreh018      = g_xreh2_d_t.xreh018
                           LET g_xreh2_d[l_ac].xreh018_desc = g_xreh2_d_t.xreh018_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh018_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh018 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh018_desc = s_desc_show1(g_xreh2_d[l_ac].xreh018,s_desc_get_pjbbl004_desc(g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018))
            LET g_xreh2_d_t.xreh018 = g_xreh2_d[l_ac].xreh018_desc
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh018_desc
            #150302 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh018_desc
            #add-point:ON CHANGE xreh018_desc name="input.g.page2.xreh018_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh020
            #add-point:BEFORE FIELD xreh020 name="input.b.page2.xreh020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh020
            
            #add-point:AFTER FIELD xreh020 name="input.a.page2.xreh020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh020
            #add-point:ON CHANGE xreh020 name="input.g.page2.xreh020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh020_desc
            #add-point:BEFORE FIELD xreh020_desc name="input.b.page2.xreh020_desc"
            LET g_xreh2_d[l_ac].xreh020_desc = g_xreh2_d[l_ac].xreh020   #150302
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh020_desc
            
            #add-point:AFTER FIELD xreh020_desc name="input.a.page2.xreh020_desc"
            #150302 add---
            #經營方式
            IF NOT cl_null(g_xreh2_d[l_ac].xreh020_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh020_desc != g_xreh2_d_t.xreh020_desc OR g_xreh2_d_t.xreh020_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh020 = g_xreh2_d[l_ac].xreh020_desc
                  IF l_glaa121 = 'N' THEN
                     IF (g_xreh2_d[l_ac].xreh020 != g_xreh2_d_t.xreh020 OR g_xreh2_d_t.xreh020 IS NULL) THEN
                        CALL s_voucher_glaq051_chk(g_xreh2_d[l_ac].xreh020) 
                        IF NOT g_sub_success THEN
                            INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_xreh2_d[l_ac].xreh020      = g_xreh2_d_t.xreh020
                           LET g_xreh2_d[l_ac].xreh020_desc = g_xreh2_d_t.xreh020_desc
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh020,g_xreh2_d[l_ac].xreh020_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh020 = ''
            END IF
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh020 ,g_xreh2_d[l_ac].xreh020_desc
            LET g_xreh2_d_t.xreh020_desc = g_xreh2_d[l_ac].xreh020_desc
            #150302 add end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh020_desc
            #add-point:ON CHANGE xreh020_desc name="input.g.page2.xreh020_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh021
            #add-point:BEFORE FIELD xreh021 name="input.b.page2.xreh021"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh021
            
            #add-point:AFTER FIELD xreh021 name="input.a.page2.xreh021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh021
            #add-point:ON CHANGE xreh021 name="input.g.page2.xreh021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh021_desc
            #add-point:BEFORE FIELD xreh021_desc name="input.b.page2.xreh021_desc"
            LET g_xreh2_d[l_ac].xreh021_desc = g_xreh2_d[l_ac].xreh021   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh021_desc
            
            #add-point:AFTER FIELD xreh021_desc name="input.a.page2.xreh021_desc"
            #渠道
            IF NOT cl_null(g_xreh2_d[l_ac].xreh021_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh021_desc != g_xreh2_d_t.xreh021_desc OR g_xreh2_d_t.xreh021_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh021 = g_xreh2_d[l_ac].xreh021_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     #CALL s_aap_oojd001_chk(g_xreh2_d[l_ac].xreh021) RETURNING g_sub_success,g_errno #150302 mark
                     CALL s_voucher_glaq052_chk(g_xreh2_d[l_ac].xreh021) #150302
                     #150507 mark ---
                     #IF NOT g_sub_success THEN
                     #   INITIALIZE g_errparam TO NULL
                     #   LET g_errparam.code = g_errno
                     #   LET g_errparam.extend = ''
                     #   LET g_errparam.popup = TRUE
                     #   CALL cl_err()
                     #150507 mark end---
                     IF NOT cl_null(g_errno) THEN #150507
                        LET g_xreh2_d[l_ac].xreh021 = g_xreh2_d_t.xreh021
                        LET g_xreh2_d[l_ac].xreh021_desc = g_xreh2_d_t.xreh021_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh021_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh021 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh021_desc = s_desc_show1(g_xreh2_d[l_ac].xreh021,s_desc_get_oojdl003_desc(g_xreh2_d[l_ac].xreh021))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh021_desc
            LET g_xreh2_d_t.xreh021_desc = g_xreh2_d[l_ac].xreh021_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh021_desc
            #add-point:ON CHANGE xreh021_desc name="input.g.page2.xreh021_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh022
            #add-point:BEFORE FIELD xreh022 name="input.b.page2.xreh022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh022
            
            #add-point:AFTER FIELD xreh022 name="input.a.page2.xreh022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh022
            #add-point:ON CHANGE xreh022 name="input.g.page2.xreh022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh022_desc
            #add-point:BEFORE FIELD xreh022_desc name="input.b.page2.xreh022_desc"
            LET g_xreh2_d[l_ac].xreh022_desc = g_xreh2_d[l_ac].xreh022   #150205-00012#1 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh022_desc
            
            #add-point:AFTER FIELD xreh022_desc name="input.a.page2.xreh022_desc"
            #品牌
            IF NOT cl_null(g_xreh2_d[l_ac].xreh022_desc) THEN
               IF ( g_xreh2_d[l_ac].xreh022_desc != g_xreh2_d_t.xreh022_desc OR g_xreh2_d_t.xreh022_desc IS NULL ) THEN
                  LET g_xreh2_d[l_ac].xreh022 = g_xreh2_d[l_ac].xreh022_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF NOT s_azzi650_chk_exist('2002',g_xreh2_d[l_ac].xreh022) THEN
                        LET g_xreh2_d[l_ac].xreh022      = g_xreh2_d_t.xreh022
                        LET g_xreh2_d[l_ac].xreh022_desc = g_xreh2_d_t.xreh022_desc
                        DISPLAY BY NAME g_xreh2_d[l_ac].xreh022 ,g_xreh2_d[l_ac].xreh022_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh022 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh022_desc = s_desc_show1(g_xreh2_d[l_ac].xreh022,s_desc_get_acc_desc('2002',g_xreh2_d[l_ac].xreh022))      
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh022 ,g_xreh2_d[l_ac].xreh022_desc
            LET g_xreh2_d_t.xreh022_desc = g_xreh2_d[l_ac].xreh022_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh022_desc
            #add-point:ON CHANGE xreh022_desc name="input.g.page2.xreh022_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh023
            #add-point:BEFORE FIELD xreh023 name="input.b.page2.xreh023"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh023
            
            #add-point:AFTER FIELD xreh023 name="input.a.page2.xreh023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh023
            #add-point:ON CHANGE xreh023 name="input.g.page2.xreh023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh023_desc
            #add-point:BEFORE FIELD xreh023_desc name="input.b.page2.xreh023_desc"
            #自由核算項一
            CALL s_fin_get_glae009(g_glad.glad0171) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh023_desc = g_xreh2_d[l_ac].xreh023   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh023_desc
            
            #add-point:AFTER FIELD xreh023_desc name="input.a.page2.xreh023_desc"
            #自由核算項一
            IF NOT cl_null(g_xreh2_d[l_ac].xreh023_desc) THEN
               IF (g_xreh2_d[l_ac].xreh023_desc != g_xreh2_d_t.xreh023_desc OR g_xreh2_d_t.xreh023_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh023 = g_xreh2_d[l_ac].xreh023_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh023 != g_xreh2_d_t.xreh023 OR g_xreh2_d_t.xreh023 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0171,g_xreh2_d[l_ac].xreh023,g_glad.glad0172) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh023 = g_xreh2_d_t.xreh023
                           LET g_xreh2_d[l_ac].xreh023_desc = s_desc_show1(g_xreh2_d[l_ac].xreh023,s_fin_get_accting_desc(g_glad.glad0171,g_xreh2_d[l_ac].xreh023))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh023_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh023 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh023_desc = s_desc_show1(g_xreh2_d[l_ac].xreh023,s_fin_get_accting_desc(g_glad.glad0171,g_xreh2_d[l_ac].xreh023))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh023_desc
            LET g_xreh2_d_t.xreh023_desc = g_xreh2_d[l_ac].xreh023_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh023_desc
            #add-point:ON CHANGE xreh023_desc name="input.g.page2.xreh023_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh024
            #add-point:BEFORE FIELD xreh024 name="input.b.page2.xreh024"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh024
            
            #add-point:AFTER FIELD xreh024 name="input.a.page2.xreh024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh024
            #add-point:ON CHANGE xreh024 name="input.g.page2.xreh024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh024_desc
            #add-point:BEFORE FIELD xreh024_desc name="input.b.page2.xreh024_desc"
            #自由核算項二
            CALL s_fin_get_glae009(g_glad.glad0181) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh024_desc = g_xreh2_d[l_ac].xreh024   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh024_desc
            
            #add-point:AFTER FIELD xreh024_desc name="input.a.page2.xreh024_desc"
            #自由核算項二
            IF NOT cl_null(g_xreh2_d[l_ac].xreh024_desc) THEN
               IF (g_xreh2_d[l_ac].xreh024_desc != g_xreh2_d_t.xreh024_desc OR g_xreh2_d_t.xreh024_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh024 = g_xreh2_d[l_ac].xreh024_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh024 != g_xreh2_d_t.xreh024 OR g_xreh2_d_t.xreh024 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0181,g_xreh2_d[l_ac].xreh024,g_glad.glad0182) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh024 = g_xreh2_d_t.xreh024
                           LET g_xreh2_d[l_ac].xreh024_desc = s_desc_show1(g_xreh2_d[l_ac].xreh024,s_fin_get_accting_desc(g_glad.glad0181,g_xreh2_d[l_ac].xreh024))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh024_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh024 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh024_desc = s_desc_show1(g_xreh2_d[l_ac].xreh024,s_fin_get_accting_desc(g_glad.glad0181,g_xreh2_d[l_ac].xreh024))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh024_desc 
            LET g_xreh2_d_t.xreh024_desc = g_xreh2_d[l_ac].xreh024_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh024_desc
            #add-point:ON CHANGE xreh024_desc name="input.g.page2.xreh024_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh025
            #add-point:BEFORE FIELD xreh025 name="input.b.page2.xreh025"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh025
            
            #add-point:AFTER FIELD xreh025 name="input.a.page2.xreh025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh025
            #add-point:ON CHANGE xreh025 name="input.g.page2.xreh025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh025_desc
            #add-point:BEFORE FIELD xreh025_desc name="input.b.page2.xreh025_desc"
            #自由核算項三
            CALL s_fin_get_glae009(g_glad.glad0191) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh025_desc = g_xreh2_d[l_ac].xreh025   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh025_desc
            
            #add-point:AFTER FIELD xreh025_desc name="input.a.page2.xreh025_desc"
            #自由核算項三
            IF NOT cl_null(g_xreh2_d[l_ac].xreh025_desc) THEN
               IF (g_xreh2_d[l_ac].xreh025_desc != g_xreh2_d_t.xreh025_desc OR g_xreh2_d_t.xreh025_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh025 = g_xreh2_d[l_ac].xreh025_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh025 != g_xreh2_d_t.xreh025 OR g_xreh2_d_t.xreh025 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0191,g_xreh2_d[l_ac].xreh025,g_glad.glad0192) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh025 = g_xreh2_d_t.xreh025
                           LET g_xreh2_d[l_ac].xreh025_desc = s_desc_show1(g_xreh2_d[l_ac].xreh025,s_fin_get_accting_desc(g_glad.glad0191,g_xreh2_d[l_ac].xreh025))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh025_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh025 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh025_desc = s_desc_show1(g_xreh2_d[l_ac].xreh025,s_fin_get_accting_desc(g_glad.glad0191,g_xreh2_d[l_ac].xreh025))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh025_desc 
            LET g_xreh2_d_t.xreh025_desc = g_xreh2_d[l_ac].xreh025_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh025_desc
            #add-point:ON CHANGE xreh025_desc name="input.g.page2.xreh025_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh026
            #add-point:BEFORE FIELD xreh026 name="input.b.page2.xreh026"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh026
            
            #add-point:AFTER FIELD xreh026 name="input.a.page2.xreh026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh026
            #add-point:ON CHANGE xreh026 name="input.g.page2.xreh026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh026_desc
            #add-point:BEFORE FIELD xreh026_desc name="input.b.page2.xreh026_desc"
            #自由核算項四
            CALL s_fin_get_glae009(g_glad.glad0201) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh026_desc = g_xreh2_d[l_ac].xreh026   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh026_desc
            
            #add-point:AFTER FIELD xreh026_desc name="input.a.page2.xreh026_desc"
            #自由核算項四
            IF NOT cl_null(g_xreh2_d[l_ac].xreh026_desc) THEN
               IF (g_xreh2_d[l_ac].xreh026_desc != g_xreh2_d_t.xreh026_desc OR g_xreh2_d_t.xreh026_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh026 = g_xreh2_d[l_ac].xreh026_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh026 != g_xreh2_d_t.xreh026 OR g_xreh2_d_t.xreh026 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0201,g_xreh2_d[l_ac].xreh026,g_glad.glad0202) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh026 = g_xreh2_d_t.xreh026
                           LET g_xreh2_d[l_ac].xreh026_desc = s_desc_show1(g_xreh2_d[l_ac].xreh026,s_fin_get_accting_desc(g_glad.glad0201,g_xreh2_d[l_ac].xreh026))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh026_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh026 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh026_desc = s_desc_show1(g_xreh2_d[l_ac].xreh026,s_fin_get_accting_desc(g_glad.glad0201,g_xreh2_d[l_ac].xreh026))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh026_desc 
            LET g_xreh2_d_t.xreh026_desc = g_xreh2_d[l_ac].xreh026_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh026_desc
            #add-point:ON CHANGE xreh026_desc name="input.g.page2.xreh026_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh027
            #add-point:BEFORE FIELD xreh027 name="input.b.page2.xreh027"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh027
            
            #add-point:AFTER FIELD xreh027 name="input.a.page2.xreh027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh027
            #add-point:ON CHANGE xreh027 name="input.g.page2.xreh027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh027_desc
            #add-point:BEFORE FIELD xreh027_desc name="input.b.page2.xreh027_desc"
            #自由核算項五
            CALL s_fin_get_glae009(g_glad.glad0211) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh027_desc = g_xreh2_d[l_ac].xreh027   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh027_desc
            
            #add-point:AFTER FIELD xreh027_desc name="input.a.page2.xreh027_desc"
            #自由核算項五
            IF NOT cl_null(g_xreh2_d[l_ac].xreh027_desc) THEN
               IF (g_xreh2_d[l_ac].xreh027_desc != g_xreh2_d_t.xreh027_desc OR g_xreh2_d_t.xreh027_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh027 = g_xreh2_d[l_ac].xreh027_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh027 != g_xreh2_d_t.xreh027 OR g_xreh2_d_t.xreh027 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0211,g_xreh2_d[l_ac].xreh027,g_glad.glad0212) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh027 = g_xreh2_d_t.xreh027
                           LET g_xreh2_d[l_ac].xreh027_desc = s_desc_show1(g_xreh2_d[l_ac].xreh027,s_fin_get_accting_desc(g_glad.glad0211,g_xreh2_d[l_ac].xreh027))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh027_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh027 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh027_desc = s_desc_show1(g_xreh2_d[l_ac].xreh027,s_fin_get_accting_desc(g_glad.glad0211,g_xreh2_d[l_ac].xreh027))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh027_desc
            LET g_xreh2_d_t.xreh027_desc = g_xreh2_d[l_ac].xreh027_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh027_desc
            #add-point:ON CHANGE xreh027_desc name="input.g.page2.xreh027_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh028
            #add-point:BEFORE FIELD xreh028 name="input.b.page2.xreh028"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh028
            
            #add-point:AFTER FIELD xreh028 name="input.a.page2.xreh028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh028
            #add-point:ON CHANGE xreh028 name="input.g.page2.xreh028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh028_desc
            #add-point:BEFORE FIELD xreh028_desc name="input.b.page2.xreh028_desc"
            #自由核算項六
            CALL s_fin_get_glae009(g_glad.glad0221) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh028_desc = g_xreh2_d[l_ac].xreh028   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh028_desc
            
            #add-point:AFTER FIELD xreh028_desc name="input.a.page2.xreh028_desc"
            #自由核算項六
            IF NOT cl_null(g_xreh2_d[l_ac].xreh028_desc) THEN
               IF (g_xreh2_d[l_ac].xreh028_desc != g_xreh2_d_t.xreh028_desc OR g_xreh2_d_t.xreh028_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh028 = g_xreh2_d[l_ac].xreh028_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh028 != g_xreh2_d_t.xreh028 OR g_xreh2_d_t.xreh028 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0221,g_xreh2_d[l_ac].xreh028,g_glad.glad0222) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh028 = g_xreh2_d_t.xreh028
                           LET g_xreh2_d[l_ac].xreh028_desc = s_desc_show1(g_xreh2_d[l_ac].xreh028,s_fin_get_accting_desc(g_glad.glad0221,g_xreh2_d[l_ac].xreh028))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh028_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh028 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh028_desc = s_desc_show1(g_xreh2_d[l_ac].xreh028,s_fin_get_accting_desc(g_glad.glad0221,g_xreh2_d[l_ac].xreh028))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh028_desc 
            LET g_xreh2_d_t.xreh028_desc = g_xreh2_d[l_ac].xreh028_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh028_desc
            #add-point:ON CHANGE xreh028_desc name="input.g.page2.xreh028_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh029
            #add-point:BEFORE FIELD xreh029 name="input.b.page2.xreh029"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh029
            
            #add-point:AFTER FIELD xreh029 name="input.a.page2.xreh029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh029
            #add-point:ON CHANGE xreh029 name="input.g.page2.xreh029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh029_desc
            #add-point:BEFORE FIELD xreh029_desc name="input.b.page2.xreh029_desc"
            #自由核算項七
            CALL s_fin_get_glae009(g_glad.glad0231) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh029_desc = g_xreh2_d[l_ac].xreh029   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh029_desc
            
            #add-point:AFTER FIELD xreh029_desc name="input.a.page2.xreh029_desc"
            #自由核算項七
            IF NOT cl_null(g_xreh2_d[l_ac].xreh029_desc) THEN
               IF (g_xreh2_d[l_ac].xreh029_desc != g_xreh2_d_t.xreh029_desc OR g_xreh2_d_t.xreh029_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh029 = g_xreh2_d[l_ac].xreh029_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh029 != g_xreh2_d_t.xreh029 OR g_xreh2_d_t.xreh029 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0231,g_xreh2_d[l_ac].xreh029,g_glad.glad0232) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh029 = g_xreh2_d_t.xreh029
                           LET g_xreh2_d[l_ac].xreh029_desc = s_desc_show1(g_xreh2_d[l_ac].xreh029,s_fin_get_accting_desc(g_glad.glad0231,g_xreh2_d[l_ac].xreh029))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh029_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh029 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh029_desc = s_desc_show1(g_xreh2_d[l_ac].xreh029,s_fin_get_accting_desc(g_glad.glad0231,g_xreh2_d[l_ac].xreh029))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh029_desc 
            LET g_xreh2_d_t.xreh029_desc = g_xreh2_d[l_ac].xreh029_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh029_desc
            #add-point:ON CHANGE xreh029_desc name="input.g.page2.xreh029_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh030
            #add-point:BEFORE FIELD xreh030 name="input.b.page2.xreh030"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh030
            
            #add-point:AFTER FIELD xreh030 name="input.a.page2.xreh030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh030
            #add-point:ON CHANGE xreh030 name="input.g.page2.xreh030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh030_desc
            #add-point:BEFORE FIELD xreh030_desc name="input.b.page2.xreh030_desc"
            #自由核算項八
            CALL s_fin_get_glae009(g_glad.glad0241) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh030_desc = g_xreh2_d[l_ac].xreh030   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh030_desc
            
            #add-point:AFTER FIELD xreh030_desc name="input.a.page2.xreh030_desc"
            #自由核算項八
            IF NOT cl_null(g_xreh2_d[l_ac].xreh030_desc) THEN
               IF (g_xreh2_d[l_ac].xreh030_desc != g_xreh2_d_t.xreh030_desc OR g_xreh2_d_t.xreh030_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh030 = g_xreh2_d[l_ac].xreh030_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh030 != g_xreh2_d_t.xreh030 OR g_xreh2_d_t.xreh030 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0241,g_xreh2_d[l_ac].xreh030,g_glad.glad0242) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh030 = g_xreh2_d_t.xreh030
                           LET g_xreh2_d[l_ac].xreh030_desc = s_desc_show1(g_xreh2_d[l_ac].xreh030,s_fin_get_accting_desc(g_glad.glad0241,g_xreh2_d[l_ac].xreh030))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh030_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh030 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh030_desc = s_desc_show1(g_xreh2_d[l_ac].xreh030,s_fin_get_accting_desc(g_glad.glad0241,g_xreh2_d[l_ac].xreh030))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh030_desc
            LET g_xreh2_d_t.xreh030_desc = g_xreh2_d[l_ac].xreh030_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh030_desc
            #add-point:ON CHANGE xreh030_desc name="input.g.page2.xreh030_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh031
            #add-point:BEFORE FIELD xreh031 name="input.b.page2.xreh031"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh031
            
            #add-point:AFTER FIELD xreh031 name="input.a.page2.xreh031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh031
            #add-point:ON CHANGE xreh031 name="input.g.page2.xreh031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh031_desc
            #add-point:BEFORE FIELD xreh031_desc name="input.b.page2.xreh031_desc"
            #自由核算項九
            CALL s_fin_get_glae009(g_glad.glad0251) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh031_desc = g_xreh2_d[l_ac].xreh031   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh031_desc
            
            #add-point:AFTER FIELD xreh031_desc name="input.a.page2.xreh031_desc"
            #自由核算項九
            IF NOT cl_null(g_xreh2_d[l_ac].xreh031_desc) THEN
               IF (g_xreh2_d[l_ac].xreh031_desc != g_xreh2_d_t.xreh031_desc OR g_xreh2_d_t.xreh031_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh031 = g_xreh2_d[l_ac].xreh031_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh031 != g_xreh2_d_t.xreh031 OR g_xreh2_d_t.xreh031 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0251,g_xreh2_d[l_ac].xreh031,g_glad.glad0252) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh031 = g_xreh2_d_t.xreh031
                           LET g_xreh2_d[l_ac].xreh031_desc = s_desc_show1(g_xreh2_d[l_ac].xreh031,s_fin_get_accting_desc(g_glad.glad0251,g_xreh2_d[l_ac].xreh031))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh031_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh031 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh031_desc = s_desc_show1(g_xreh2_d[l_ac].xreh031,s_fin_get_accting_desc(g_glad.glad0251,g_xreh2_d[l_ac].xreh031))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh031_desc
            LET g_xreh2_d_t.xreh031_desc = g_xreh2_d[l_ac].xreh031_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh031_desc
            #add-point:ON CHANGE xreh031_desc name="input.g.page2.xreh031_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh032
            #add-point:BEFORE FIELD xreh032 name="input.b.page2.xreh032"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh032
            
            #add-point:AFTER FIELD xreh032 name="input.a.page2.xreh032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh032
            #add-point:ON CHANGE xreh032 name="input.g.page2.xreh032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xreh032_desc
            #add-point:BEFORE FIELD xreh032_desc name="input.b.page2.xreh032_desc"
            #自由核算項十
            CALL s_fin_get_glae009(g_glad.glad0261) RETURNING l_glae009
            LET g_xreh2_d[l_ac].xreh032_desc = g_xreh2_d[l_ac].xreh032   #150205-00012#1
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xreh032_desc
            
            #add-point:AFTER FIELD xreh032_desc name="input.a.page2.xreh032_desc"
            #自由核算項十
            IF NOT cl_null(g_xreh2_d[l_ac].xreh032_desc) THEN
               IF (g_xreh2_d[l_ac].xreh032_desc != g_xreh2_d_t.xreh032_desc OR g_xreh2_d_t.xreh032_desc IS NULL) THEN
                  LET g_xreh2_d[l_ac].xreh032 = g_xreh2_d[l_ac].xreh032_desc
                  IF l_glaa121 = 'N' THEN     #141218-00011#6
                     IF (g_xreh2_d[l_ac].xreh032 != g_xreh2_d_t.xreh032 OR g_xreh2_d_t.xreh032 IS NULL) THEN
                        CALL s_voucher_free_account_chk(g_glad.glad0261,g_xreh2_d[l_ac].xreh032,g_glad.glad0262) RETURNING g_errno
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
                           LET g_xreh2_d[l_ac].xreh032 = g_xreh2_d_t.xreh032
                           LET g_xreh2_d[l_ac].xreh032_desc = s_desc_show1(g_xreh2_d[l_ac].xreh032,s_fin_get_accting_desc(g_glad.glad0261,g_xreh2_d[l_ac].xreh032))
                           DISPLAY BY NAME g_xreh2_d[l_ac].xreh032_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               LET g_xreh2_d[l_ac].xreh032 = ''
            END IF
            LET g_xreh2_d[l_ac].xreh032_desc = s_desc_show1(g_xreh2_d[l_ac].xreh032,s_fin_get_accting_desc(g_glad.glad0261,g_xreh2_d[l_ac].xreh032))
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh032_desc
            LET g_xreh2_d_t.xreh032_desc = g_xreh2_d[l_ac].xreh032_desc
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xreh032_desc
            #add-point:ON CHANGE xreh032_desc name="input.g.page2.xreh032_desc"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xreh033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh033
            #add-point:ON ACTION controlp INFIELD xreh033 name="input.c.page2.xreh033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh019
            #add-point:ON ACTION controlp INFIELD xreh019 name="input.c.page2.xreh019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh019_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh019_desc
            #add-point:ON ACTION controlp INFIELD xreh019_desc name="input.c.page2.xreh019_desc"
            #應付帳款科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh019
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161114-00017#1
                                   " AND gladld='",g_xreg_m.xregld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_xreh2_d[l_ac].xreh019 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh019_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc
            NEXT FIELD xreh019_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh034
            #add-point:ON ACTION controlp INFIELD xreh034 name="input.c.page2.xreh034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh034_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh034_desc
            #add-point:ON ACTION controlp INFIELD xreh034_desc name="input.c.page2.xreh034_desc"
            #重評價會科
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh034
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ", #161114-00017#1
                                   " AND gladld='",g_xreg_m.xregld,"' AND gladent='",g_enterprise,"'",
                                   " AND gladstus = 'Y' )"
            CALL aglt310_04()
            LET g_xreh2_d[l_ac].xreh034 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh034_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc
            NEXT FIELD xreh034_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh016
            #add-point:ON ACTION controlp INFIELD xreh016 name="input.c.page2.xreh016"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh016_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh016_desc
            #add-point:ON ACTION controlp INFIELD xreh016_desc name="input.c.page2.xreh016_desc"
            #業務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh016
            CALL q_ooag001_8()
            LET g_xreh2_d[l_ac].xreh016 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh016_desc = g_qryparam.return1 
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh016_desc
            NEXT FIELD xreh016_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh011
            #add-point:ON ACTION controlp INFIELD xreh011 name="input.c.page2.xreh011"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh011_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh011_desc
            #add-point:ON ACTION controlp INFIELD xreh011_desc name="input.c.page2.xreh011_desc"
            #業務部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh011
            LET g_qryparam.arg1 = g_xreg_m.xregdocdt    #應以單據日期
            CALL q_ooeg001_4()
            LET g_xreh2_d[l_ac].xreh011 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh011_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh011_desc
            NEXT FIELD xreh011_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh012
            #add-point:ON ACTION controlp INFIELD xreh012 name="input.c.page2.xreh012"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh012_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh012_desc
            #add-point:ON ACTION controlp INFIELD xreh012_desc name="input.c.page2.xreh012_desc"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_xreh2_d[l_ac].xreh012
            LET g_qryparam.arg1 = g_xreg_m.xregdocdt
            #LET g_qryparam.where = " ooeg003 IN ('1','2','3')"    #141218-00011#6 #150302 mark
            CALL q_ooeg001_5()
            LET g_xreh2_d[l_ac].xreh012 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh012_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh012_desc
            NEXT FIELD xreh012_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh013
            #add-point:ON ACTION controlp INFIELD xreh013 name="input.c.page2.xreh013"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh013_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh013_desc
            #add-point:ON ACTION controlp INFIELD xreh013_desc name="input.c.page2.xreh013_desc"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh013
            CALL q_oocq002_287()
            LET g_xreh2_d[l_ac].xreh013 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh013_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh013_desc
            NEXT FIELD xreh013_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh014
            #add-point:ON ACTION controlp INFIELD xreh014 name="input.c.page2.xreh014"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh014_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh014_desc
            #add-point:ON ACTION controlp INFIELD xreh014_desc name="input.c.page2.xreh014_desc"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh014
            CALL q_oocq002_281()
            LET g_xreh2_d[l_ac].xreh014 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh014_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xreh2_d[l_ac].xreh014,g_xreh2_d[l_ac].xreh014_desc
            NEXT FIELD xreh014_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh015
            #add-point:ON ACTION controlp INFIELD xreh015 name="input.c.page2.xreh015"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh015_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh015_desc
            #add-point:ON ACTION controlp INFIELD xreh015_desc name="input.c.page2.xreh015_desc"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh015
            CALL q_rtax001()
            LET g_xreh2_d[l_ac].xreh015 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh015_desc = g_qryparam.return1
            DISPLAY BY NAME  g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh015_desc
            NEXT FIELD xreh015_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh017
            #add-point:ON ACTION controlp INFIELD xreh017 name="input.c.page2.xreh017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh017_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh017_desc
            #add-point:ON ACTION controlp INFIELD xreh017_desc name="input.c.page2.xreh017_desc"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh017
            CALL q_pjba001()
            LET g_xreh2_d[l_ac].xreh017      = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh017_desc = g_xreh2_d[l_ac].xreh017
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh017_desc
            NEXT FIELD xreh017_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh018
            #add-point:ON ACTION controlp INFIELD xreh018 name="input.c.page2.xreh018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh018_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh018_desc
            #add-point:ON ACTION controlp INFIELD xreh018_desc name="input.c.page2.xreh018_desc"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh018
            #150302 add---
            IF NOT cl_null(g_xreh2_d[l_ac].xreh017) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_xreh2_d[l_ac].xreh017,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #150302 add end ---
            CALL q_pjbb002()
            LET g_xreh2_d[l_ac].xreh018 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh018_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh018_desc
            NEXT FIELD xreh018_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh020
            #add-point:ON ACTION controlp INFIELD xreh020 name="input.c.page2.xreh020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh020_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh020_desc
            #add-point:ON ACTION controlp INFIELD xreh020_desc name="input.c.page2.xreh020_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh021
            #add-point:ON ACTION controlp INFIELD xreh021 name="input.c.page2.xreh021"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh021_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh021_desc
            #add-point:ON ACTION controlp INFIELD xreh021_desc name="input.c.page2.xreh021_desc"
            #渠道
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh021
            CALL q_oojd001_2()
            LET g_xreh2_d[l_ac].xreh021 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh021_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh021_desc
            NEXT FIELD xreh021_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh022
            #add-point:ON ACTION controlp INFIELD xreh022 name="input.c.page2.xreh022"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh022_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh022_desc
            #add-point:ON ACTION controlp INFIELD xreh022_desc name="input.c.page2.xreh022_desc"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh022
            CALL q_oocq002_2002()
            LET g_xreh2_d[l_ac].xreh022 = g_qryparam.return1
            LET g_xreh2_d[l_ac].xreh022_desc = g_qryparam.return1
            DISPLAY BY NAME g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh022_desc
            NEXT FIELD xreh022_desc
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh023
            #add-point:ON ACTION controlp INFIELD xreh023 name="input.c.page2.xreh023"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh023_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh023_desc
            #add-point:ON ACTION controlp INFIELD xreh023_desc name="input.c.page2.xreh023_desc"
            #自由核算項一
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh023
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0171,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh023 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh023_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh023_desc
               NEXT FIELD xreh023_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh024
            #add-point:ON ACTION controlp INFIELD xreh024 name="input.c.page2.xreh024"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh024_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh024_desc
            #add-point:ON ACTION controlp INFIELD xreh024_desc name="input.c.page2.xreh024_desc"
            #自由核算項二
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh024
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0181,"'" #自由核算項類型
               END IF 
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh024 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh024_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh024,g_xreh2_d[l_ac].xreh024_desc
               NEXT FIELD xreh024_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh025
            #add-point:ON ACTION controlp INFIELD xreh025 name="input.c.page2.xreh025"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh025_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh025_desc
            #add-point:ON ACTION controlp INFIELD xreh025_desc name="input.c.page2.xreh025_desc"
            #自由核算項三
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh025
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0191,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh025 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh025_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh025,g_xreh2_d[l_ac].xreh025_desc
               NEXT FIELD xreh025_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh026
            #add-point:ON ACTION controlp INFIELD xreh026 name="input.c.page2.xreh026"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh026_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh026_desc
            #add-point:ON ACTION controlp INFIELD xreh026_desc name="input.c.page2.xreh026_desc"
            #自由核算項四
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh026
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0201,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh026 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh026_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh026_desc
               NEXT FIELD xreh026_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh027
            #add-point:ON ACTION controlp INFIELD xreh027 name="input.c.page2.xreh027"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh027_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh027_desc
            #add-point:ON ACTION controlp INFIELD xreh027_desc name="input.c.page2.xreh027_desc"
            #自由核算項五
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh027
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0211,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh027 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh027_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh027_desc
               NEXT FIELD xreh027_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh028
            #add-point:ON ACTION controlp INFIELD xreh028 name="input.c.page2.xreh028"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh028_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh028_desc
            #add-point:ON ACTION controlp INFIELD xreh028_desc name="input.c.page2.xreh028_desc"
            #自由核算項六
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh028
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0221,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh028 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh028_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh028,g_xreh2_d[l_ac].xreh028_desc 
               NEXT FIELD xreh028_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh029
            #add-point:ON ACTION controlp INFIELD xreh029 name="input.c.page2.xreh029"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh029_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh029_desc
            #add-point:ON ACTION controlp INFIELD xreh029_desc name="input.c.page2.xreh029_desc"
            #自由核算項七
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh029
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0231,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh029 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh029_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh029,g_xreh2_d[l_ac].xreh029_desc
               NEXT FIELD xreh029_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh030
            #add-point:ON ACTION controlp INFIELD xreh030 name="input.c.page2.xreh030"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh030_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh030_desc
            #add-point:ON ACTION controlp INFIELD xreh030_desc name="input.c.page2.xreh030_desc"
            #自由核算項八
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh030
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0241,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh030 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh030_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh030_desc
               NEXT FIELD xreh030_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh031
            #add-point:ON ACTION controlp INFIELD xreh031 name="input.c.page2.xreh031"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh031_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh031_desc
            #add-point:ON ACTION controlp INFIELD xreh031_desc name="input.c.page2.xreh031_desc"
            #自由核算項九
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh031
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0251,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh031 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh031_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh031_desc
               NEXT FIELD xreh031_desc
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh032
            #add-point:ON ACTION controlp INFIELD xreh032 name="input.c.page2.xreh032"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.xreh032_desc
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xreh032_desc
            #add-point:ON ACTION controlp INFIELD xreh032_desc name="input.c.page2.xreh032_desc"
            #自由核算項十
            IF NOT cl_null(l_glae009) THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.state = "i"
               LET g_qryparam.default1 = g_xreh2_d[l_ac].xreh032
               IF l_glae009 = 'q_glaf002' THEN
                  LET g_qryparam.where = "glaf001 = '",g_glad.glad0261,"'" #自由核算項類型
               END IF
               CALL q_agli041(l_glae009)
               LET g_xreh2_d[l_ac].xreh032 = g_qryparam.return1
               LET g_xreh2_d[l_ac].xreh032_desc = g_qryparam.return1
               DISPLAY BY NAME g_xreh2_d[l_ac].xreh032,g_xreh2_d[l_ac].xreh032_desc
               NEXT FIELD xreh032_desc
            END IF
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xreh2_d[l_ac].* = g_xreh2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt920_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt920_unlock_b("xreh_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            #141202-00061#17
            CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa121|glaacomp') RETURNING g_sub_success,g_glaa121,g_glaacomp
            #161114-00017#1 add ------
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#65 mark
            #161114-00017#1 add end---
            #161229-00047#65 add ------
            CALL s_fin_get_wc_str(g_glaacomp) RETURNING g_comp_str
            CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            #161229-00047#65 add end---
            CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING g_sub_success,g_ap_slip
            #150202-00002#1 mark
            #CALL s_fin_get_doc_para(g_xreg_m.xregld,g_glaacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
            #IF g_glaa121 = 'Y' AND g_dfin0030 = 'Y' THEN
            IF g_glaa121 = 'Y' THEN #150202-00002#1 add
               CALL s_transaction_begin()
               CALL s_pre_voucher_ins('AP','P40',g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,'1')
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
               LET g_xreh_d[li_reproduce_target].* = g_xreh_d[li_reproduce].*
               LET g_xreh2_d[li_reproduce_target].* = g_xreh2_d[li_reproduce].*
               LET g_xreh3_d[li_reproduce_target].* = g_xreh3_d[li_reproduce].*
 
               LET g_xreh2_d[li_reproduce_target].xrehld = NULL
               LET g_xreh2_d[li_reproduce_target].xrehseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xreh2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xreh2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_xreh3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL aapt920_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL aapt920_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="aapt920.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #IF g_aw = "s_detail1" OR cl_null(g_aw) THEN LET g_aw = "s_detail2" END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2','3',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xregdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xrehld
               WHEN "s_detail2"
                  NEXT FIELD xrehld_2
               WHEN "s_detail3"
                  NEXT FIELD xrehld_3
 
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
 
{<section id="aapt920.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt920_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt920_b_fill() #單身填充
      CALL aapt920_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt920_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_xreg_m.l_xregsite_desc = s_desc_get_department_desc(g_xreg_m.xregsite)
   LET g_xreg_m.l_xregld_desc = s_desc_get_ld_desc(g_xreg_m.xregld)
   LET g_xreg_m.l_xreg004_desc = s_desc_get_person_desc(g_xreg_m.xreg004)
   #end add-point
   
   #遮罩相關處理
   LET g_xreg_m_mask_o.* =  g_xreg_m.*
   CALL aapt920_xreg_t_mask()
   LET g_xreg_m_mask_n.* =  g_xreg_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc, 
       g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001, 
       g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtdt, 
       g_xreg_m.xregcrtid,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid,g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfdt, 
       g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregcnfid_desc
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xreg_m.xregstus 
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
   FOR l_ac = 1 TO g_xreh_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xreh2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xreh3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt920_detail_show()
 
   #add-point:show段之後 name="show.after"
   #取得帳別相關資訊
   CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaa015|glaa019|glaa121') RETURNING g_sub_success,g_glaa015,g_glaa019,g_glaa121
   IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
   END IF
   #141202-00061#17
   #是否啟用分錄底稿
   IF g_glaa121 = 'Y' THEN
      CALL cl_set_act_visible("open_pre", TRUE)
   ELSE
      CALL cl_set_act_visible("open_pre", FALSE)
   END IF
   #141202-00061#17
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt920_detail_show()
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
 
{<section id="aapt920.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt920_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xreg_t.xregdocno 
   DEFINE l_oldno     LIKE xreg_t.xregdocno 
 
   DEFINE l_master    RECORD LIKE xreg_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xreh_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_xreg_m.xregdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xregdocno_t = g_xreg_m.xregdocno
 
    
   LET g_xreg_m.xregdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xreg_m.xregownid = g_user
      LET g_xreg_m.xregowndp = g_dept
      LET g_xreg_m.xregcrtid = g_user
      LET g_xreg_m.xregcrtdp = g_dept 
      LET g_xreg_m.xregcrtdt = cl_get_current()
      LET g_xreg_m.xregmodid = g_user
      LET g_xreg_m.xregmoddt = cl_get_current()
      LET g_xreg_m.xregstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xreg_m.xregstus 
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
   
   
   CALL aapt920_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xreg_m.* TO NULL
      INITIALIZE g_xreh_d TO NULL
      INITIALIZE g_xreh2_d TO NULL
      INITIALIZE g_xreh3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt920_show()
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
   CALL aapt920_set_act_visible()   
   CALL aapt920_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xregdocno_t = g_xreg_m.xregdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xregent = " ||g_enterprise|| " AND",
                      " xregdocno = '", g_xreg_m.xregdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt920_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt920_idx_chk()
   
   LET g_data_owner = g_xreg_m.xregownid      
   LET g_data_dept  = g_xreg_m.xregowndp
   
   #功能已完成,通報訊息中心
   CALL aapt920_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt920_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xreh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt920_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xreh_t
    WHERE xrehent = g_enterprise AND xrehdocno = g_xregdocno_t
 
    INTO TEMP aapt920_detail
 
   #將key修正為調整後   
   UPDATE aapt920_detail 
      #更新key欄位
      SET xrehdocno = g_xreg_m.xregdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xreh_t SELECT * FROM aapt920_detail
   
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
   DROP TABLE aapt920_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xregdocno_t = g_xreg_m.xregdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt920_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xreg_m.xregdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt920_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt920_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt920_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xreg_m_mask_o.* =  g_xreg_m.*
   CALL aapt920_xreg_t_mask()
   LET g_xreg_m_mask_n.* =  g_xreg_m.*
   
   CALL aapt920_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt920_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xregdocno_t = g_xreg_m.xregdocno
 
 
      DELETE FROM xreg_t
       WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
         AND xreg003 ='AP'
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xreg_m.xregdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_xreg_m.xregld,g_xreg_m.xregdocno,g_xreg_m.xregdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #141202-00061#17
      CALL s_ld_sel_glaa(g_xreg_m.xregld,'glaacomp|glaa121') RETURNING g_sub_success,g_glaacomp,g_glaa121
      #161114-00017#1 add ------
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#65 mark
      #161114-00017#1 add end---
      #161229-00047#65 add ------
      CALL s_fin_get_wc_str(g_glaacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      #161229-00047#65 add end---
      CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING g_sub_success,g_ap_slip
      #150202-00002#1 mark
      #CALL s_fin_get_doc_para(g_xreg_m.xregld,g_glaacomp,g_ap_slip,'D-FIN-0030') RETURNING g_dfin0030
      #IF g_glaa121 = 'Y' AND g_dfin0030 = 'Y' THEN
      IF g_glaa121 = 'Y' THEN #150202-00002#1 add
         #分錄單頭
         SELECT count(*) INTO l_cnt
           FROM glga_t
          WHERE glgaent = g_enterprise
            AND glgald  = g_xreg_m.xregld AND glgadocno = g_xreg_m.xregdocno
            AND glga100 = 'AP' AND glga101 LIKE 'P%'
          
          IF l_cnt > 0 THEN
            DELETE FROM glga_t
             WHERE glgaent = g_enterprise
               AND glgald  = g_xreg_m.xregld AND glgadocno = g_xreg_m.xregdocno
               AND glga100 = 'AP' AND glga101 LIKE 'P%'
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xreg_m.xregdocno 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
            END IF 
          END IF
          
          #分錄單身
          SELECT count(*) INTO l_cnt
           FROM glgb_t
          WHERE glgbent = g_enterprise
            AND glgbld  = g_xreg_m.xregld AND glgbdocno = g_xreg_m.xregdocno
            AND glgb100 = 'AP' AND glgb101 LIKE 'P%'
          
          IF l_cnt > 0 THEN
            DELETE FROM glgb_t
             WHERE glgbent = g_enterprise
               AND glgbld  = g_xreg_m.xregld AND glgbdocno = g_xreg_m.xregdocno
               AND glgb100 = 'AP' AND glgb101 LIKE 'P%'
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_xreg_m.xregdocno 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = FALSE 
                  CALL cl_err()
               END IF 
          END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xreh_t
       WHERE xrehent = g_enterprise AND xrehdocno = g_xreg_m.xregdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xreg_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt920_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xreh_d.clear() 
      CALL g_xreh2_d.clear()       
      CALL g_xreh3_d.clear()       
 
     
      CALL aapt920_ui_browser_refresh()  
      #CALL aapt920_ui_headershow()  
      #CALL aapt920_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt920_browser_fill("")
         CALL aapt920_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt920_cl
 
   #功能已完成,通報訊息中心
   CALL aapt920_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt920.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt920_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #160129-00015#5 add(S)
   #多語言SQL
   DEFINE l_get_sql   RECORD
          xreh009     STRING,
          xreh011     STRING,
          xreh012     STRING,
          xreh013     STRING,
          xreh014     STRING,
          xreh015     STRING,
          xreh016     STRING,
          xreh017     STRING,
          xreh018     STRING,
          xreh019     STRING,
          xreh020     STRING,
          xreh021     STRING,
          xreh022     STRING,
          xreh034     STRING          
                      END RECORD
   #160129-00015#5 add(E)
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xreh_d.clear()
   CALL g_xreh2_d.clear()
   CALL g_xreh3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF aapt920_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xrehld,xrehseq,xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009, 
             xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xrehld,xrehseq,xreh033, 
             xreh019,xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020, 
             xreh021,xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031, 
             xreh032,xrehld,xrehseq,xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135  FROM xreh_t", 
                
                     " INNER JOIN xreg_t ON xregent = " ||g_enterprise|| " AND xregdocno = xrehdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xrehent=? AND xrehdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xreh_t.xrehld,xreh_t.xrehseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt920_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt920_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xreg_m.xregdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xreg_m.xregdocno INTO g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq, 
          g_xreh_d[l_ac].xrehorga,g_xreh_d[l_ac].xreh004,g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006, 
          g_xreh_d[l_ac].xreh007,g_xreh_d[l_ac].xreh009,g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100, 
          g_xreh_d[l_ac].xreh102,g_xreh_d[l_ac].xreh101,g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113, 
          g_xreh_d[l_ac].xreh114,g_xreh_d[l_ac].xreh115,g_xreh2_d[l_ac].xrehld,g_xreh2_d[l_ac].xrehseq, 
          g_xreh2_d[l_ac].xreh033,g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016, 
          g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014, 
          g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020, 
          g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024, 
          g_xreh2_d[l_ac].xreh025,g_xreh2_d[l_ac].xreh026,g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028, 
          g_xreh2_d[l_ac].xreh029,g_xreh2_d[l_ac].xreh030,g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032, 
          g_xreh3_d[l_ac].xrehld,g_xreh3_d[l_ac].xrehseq,g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123, 
          g_xreh3_d[l_ac].xreh124,g_xreh3_d[l_ac].xreh125,g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133, 
          g_xreh3_d[l_ac].xreh134,g_xreh3_d[l_ac].xreh135   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #其他頁籤給值
         LET g_xreh2_d[l_ac].l_xreh005_2 = g_xreh_d[l_ac].xreh005
         LET g_xreh2_d[l_ac].l_xreh006_2 = g_xreh_d[l_ac].xreh006
         LET g_xreh2_d[l_ac].l_xrehorga_2 = g_xreh_d[l_ac].xrehorga
         LET g_xreh3_d[l_ac].l_xreh005_3 = g_xreh_d[l_ac].xreh005
         LET g_xreh3_d[l_ac].l_xreh006_3 = g_xreh_d[l_ac].xreh006

         CALL s_desc_get_trading_partner_abbr_desc(g_xreh_d[l_ac].xreh009) RETURNING g_xreh_d[l_ac].l_xreh009_desc
         
         #固定核算項
         LET g_xreh2_d[l_ac].xreh019_desc = s_desc_show1(g_xreh2_d[l_ac].xreh019,s_desc_get_account_desc(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019))
         LET g_xreh2_d[l_ac].xreh034_desc = s_desc_show1(g_xreh2_d[l_ac].xreh034,s_desc_get_account_desc(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh034))
         LET g_xreh2_d[l_ac].xreh016_desc = s_desc_show1(g_xreh2_d[l_ac].xreh016,s_desc_get_person_desc(g_xreh2_d[l_ac].xreh016))
         LET g_xreh2_d[l_ac].xreh011_desc = s_desc_show1(g_xreh2_d[l_ac].xreh011,s_desc_get_department_desc(g_xreh2_d[l_ac].xreh011))
         LET g_xreh2_d[l_ac].xreh012_desc = s_desc_show1(g_xreh2_d[l_ac].xreh012,s_desc_get_department_desc(g_xreh2_d[l_ac].xreh012))
         LET g_xreh2_d[l_ac].xreh013_desc = s_desc_show1(g_xreh2_d[l_ac].xreh013,s_desc_get_acc_desc('287',g_xreh2_d[l_ac].xreh013))
         LET g_xreh2_d[l_ac].xreh014_desc = s_desc_show1(g_xreh2_d[l_ac].xreh014,s_desc_get_acc_desc('281',g_xreh2_d[l_ac].xreh014))
         LET g_xreh2_d[l_ac].xreh015_desc = s_desc_show1(g_xreh2_d[l_ac].xreh015,s_desc_get_rtaxl003_desc(g_xreh2_d[l_ac].xreh015))
         LET g_xreh2_d[l_ac].xreh017_desc = s_desc_show1(g_xreh2_d[l_ac].xreh017,s_desc_get_project_desc(g_xreh2_d[l_ac].xreh017))
         #150302 add---
         LET g_xreh2_d[l_ac].xreh018_desc = s_desc_show1(g_xreh2_d[l_ac].xreh018,s_desc_get_pjbbl004_desc(g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh018))
         LET g_xreh2_d[l_ac].xreh020_desc = g_xreh2_d[l_ac].xreh020
         #150302 add end---
         LET g_xreh2_d[l_ac].xreh021_desc = s_desc_show1(g_xreh2_d[l_ac].xreh021,s_desc_get_oojdl003_desc(g_xreh2_d[l_ac].xreh021))
         LET g_xreh2_d[l_ac].xreh022_desc = s_desc_show1(g_xreh2_d[l_ac].xreh022,s_desc_get_acc_desc('2002',g_xreh2_d[l_ac].xreh022))

         #自由核算項
         CALL s_fin_sel_glad(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
              RETURNING g_errno,g_glad.*
         IF NOT cl_null(g_xreh2_d[l_ac].xreh023) THEN
            LET g_xreh2_d[l_ac].xreh023_desc = s_desc_show1(g_xreh2_d[l_ac].xreh023,s_fin_get_accting_desc(g_glad.glad0171,g_xreh2_d[l_ac].xreh023))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh024) THEN
            LET g_xreh2_d[l_ac].xreh024_desc = s_desc_show1(g_xreh2_d[l_ac].xreh024,s_fin_get_accting_desc(g_glad.glad0181,g_xreh2_d[l_ac].xreh024))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh025) THEN
            LET g_xreh2_d[l_ac].xreh025_desc = s_desc_show1(g_xreh2_d[l_ac].xreh025,s_fin_get_accting_desc(g_glad.glad0191,g_xreh2_d[l_ac].xreh025))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh026) THEN
            LET g_xreh2_d[l_ac].xreh026_desc = s_desc_show1(g_xreh2_d[l_ac].xreh026,s_fin_get_accting_desc(g_glad.glad0201,g_xreh2_d[l_ac].xreh026))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh027) THEN
            LET g_xreh2_d[l_ac].xreh027_desc = s_desc_show1(g_xreh2_d[l_ac].xreh027,s_fin_get_accting_desc(g_glad.glad0211,g_xreh2_d[l_ac].xreh027))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh028) THEN
            LET g_xreh2_d[l_ac].xreh028_desc = s_desc_show1(g_xreh2_d[l_ac].xreh028,s_fin_get_accting_desc(g_glad.glad0221,g_xreh2_d[l_ac].xreh028))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh029) THEN
            LET g_xreh2_d[l_ac].xreh029_desc = s_desc_show1(g_xreh2_d[l_ac].xreh029,s_fin_get_accting_desc(g_glad.glad0231,g_xreh2_d[l_ac].xreh029))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh030) THEN
            LET g_xreh2_d[l_ac].xreh030_desc = s_desc_show1(g_xreh2_d[l_ac].xreh030,s_fin_get_accting_desc(g_glad.glad0241,g_xreh2_d[l_ac].xreh030))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh031) THEN
            LET g_xreh2_d[l_ac].xreh031_desc = s_desc_show1(g_xreh2_d[l_ac].xreh031,s_fin_get_accting_desc(g_glad.glad0251,g_xreh2_d[l_ac].xreh031))
         END IF
         IF NOT cl_null(g_xreh2_d[l_ac].xreh032) THEN
            LET g_xreh2_d[l_ac].xreh032_desc = s_desc_show1(g_xreh2_d[l_ac].xreh032,s_fin_get_accting_desc(g_glad.glad0261,g_xreh2_d[l_ac].xreh032))
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
   #160129-00015#2 add(S)
   INITIALIZE l_get_sql.* TO NULL
   #帳款對象
   CALL s_fin_get_trading_partner_abbr_sql('ta1','xrehent','xreh009') RETURNING l_get_sql.xreh009
   #應收科目
   CALL s_fin_get_account_sql('ta2','ta3','xrehent','xrehld','xreh019') RETURNING l_get_sql.xreh019
   #重評價會科
   CALL s_fin_get_account_sql('ta4','ta5','xrehent','xrehld','xreh034') RETURNING l_get_sql.xreh034
   #人員
   CALL s_fin_get_person_sql('ta6','xrehent','xreh016') RETURNING l_get_sql.xreh016
   #部門
   CALL s_fin_get_department_sql('ta7','xrehent','xreh011') RETURNING l_get_sql.xreh011
   #責任中心
   CALL s_fin_get_department_sql('ta8','xrehent','xreh012') RETURNING l_get_sql.xreh012
   #區域
   CALL s_fin_get_acc_sql('ta9','xrehent','287','xreh013') RETURNING l_get_sql.xreh013
   #客群
   CALL s_fin_get_acc_sql('ta10','xrehent','281','xreh014') RETURNING l_get_sql.xreh014
   #產品類別
   CALL s_fin_get_rtaxl003_sql('ta11','xrehent','xreh015') RETURNING l_get_sql.xreh015
   #專案代號
   CALL s_fin_get_project_sql('ta12','xrehent','xreh017') RETURNING l_get_sql.xreh017
   #WBS編號
   CALL s_fin_get_wbs_sql('ta13','xrehent','xreh017','xreh018') RETURNING l_get_sql.xreh018
   #渠道
   CALL s_fin_get_oojdl003_sql('ta14','xrehent','xreh021') RETURNING l_get_sql.xreh021
   #品牌
   CALL s_fin_get_acc_sql('ta15','xrehent','2002','xreh022') RETURNING l_get_sql.xreh022   
   
   LET g_sql = "SELECT  DISTINCT xrehld,xrehseq,xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009," ,
               "                 xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xrehld,xrehseq,xreh033, ",
               "                 xreh019,xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020, ",
               "                 xreh021,xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031, ",
               "                 xreh032,xrehld,xrehseq,xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135,  ",
               l_get_sql.xreh009,",",l_get_sql.xreh019,",",l_get_sql.xreh034,",",l_get_sql.xreh016,",",l_get_sql.xreh011,",",
               l_get_sql.xreh012,",",l_get_sql.xreh013,",",l_get_sql.xreh014,",",l_get_sql.xreh015,",",l_get_sql.xreh017,",",
               l_get_sql.xreh018,",",l_get_sql.xreh021,",",l_get_sql.xreh022,
               "  FROM xreh_t",
               " INNER JOIN xreg_t ON xregdocno = xrehdocno ",
               " WHERE xrehent=? AND xrehdocno=?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
    
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
   END IF
   
   #子單身的WC
   
   LET g_sql = g_sql, " ORDER BY xreh_t.xrehld,xreh_t.xrehseq"
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aapt920_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR aapt920_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN b_fill_cs1 USING g_enterprise,g_xreg_m.xregdocno
                                            
   FOREACH b_fill_cs1 INTO g_xreh_d[l_ac].xrehld,g_xreh_d[l_ac].xrehseq,g_xreh_d[l_ac].xrehorga,g_xreh_d[l_ac].xreh004, 
                           g_xreh_d[l_ac].xreh005,g_xreh_d[l_ac].xreh006,g_xreh_d[l_ac].xreh007,g_xreh_d[l_ac].xreh009, 
                           g_xreh_d[l_ac].xreh008,g_xreh_d[l_ac].xreh100,g_xreh_d[l_ac].xreh102,g_xreh_d[l_ac].xreh101, 
                           g_xreh_d[l_ac].xreh103,g_xreh_d[l_ac].xreh113,g_xreh_d[l_ac].xreh114,g_xreh_d[l_ac].xreh115, 
                           g_xreh2_d[l_ac].xrehld,g_xreh2_d[l_ac].xrehseq,g_xreh2_d[l_ac].xreh033,g_xreh2_d[l_ac].xreh019, 
                           g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh012, 
                           g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh014,g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh017, 
                           g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh020,g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh022, 
                           g_xreh2_d[l_ac].xreh023,g_xreh2_d[l_ac].xreh024,g_xreh2_d[l_ac].xreh025,g_xreh2_d[l_ac].xreh026, 
                           g_xreh2_d[l_ac].xreh027,g_xreh2_d[l_ac].xreh028,g_xreh2_d[l_ac].xreh029,g_xreh2_d[l_ac].xreh030, 
                           g_xreh2_d[l_ac].xreh031,g_xreh2_d[l_ac].xreh032,g_xreh3_d[l_ac].xrehld,g_xreh3_d[l_ac].xrehseq, 
                           g_xreh3_d[l_ac].xreh121,g_xreh3_d[l_ac].xreh123,g_xreh3_d[l_ac].xreh124,g_xreh3_d[l_ac].xreh125, 
                           g_xreh3_d[l_ac].xreh131,g_xreh3_d[l_ac].xreh133,g_xreh3_d[l_ac].xreh134,g_xreh3_d[l_ac].xreh135,
                           g_xreh_d[l_ac].l_xreh009_desc,g_xreh2_d[l_ac].xreh019_desc,g_xreh2_d[l_ac].xreh034_desc,g_xreh2_d[l_ac].xreh016_desc,
                           g_xreh2_d[l_ac].xreh011_desc ,g_xreh2_d[l_ac].xreh012_desc,g_xreh2_d[l_ac].xreh013_desc,g_xreh2_d[l_ac].xreh014_desc,
                           g_xreh2_d[l_ac].xreh015_desc ,g_xreh2_d[l_ac].xreh017_desc,g_xreh2_d[l_ac].xreh018_desc,g_xreh2_d[l_ac].xreh021_desc,
                           g_xreh2_d[l_ac].xreh022_desc
    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      #其他頁籤給值
      LET g_xreh2_d[l_ac].l_xreh005_2 = g_xreh_d[l_ac].xreh005
      LET g_xreh2_d[l_ac].l_xreh006_2 = g_xreh_d[l_ac].xreh006
      LET g_xreh2_d[l_ac].l_xrehorga_2 = g_xreh_d[l_ac].xrehorga
      LET g_xreh3_d[l_ac].l_xreh005_3 = g_xreh_d[l_ac].xreh005
      LET g_xreh3_d[l_ac].l_xreh006_3 = g_xreh_d[l_ac].xreh006
      
      #固定核算項
      LET g_xreh2_d[l_ac].xreh019_desc = s_desc_show1(g_xreh2_d[l_ac].xreh019,g_xreh2_d[l_ac].xreh019_desc)
      LET g_xreh2_d[l_ac].xreh034_desc = s_desc_show1(g_xreh2_d[l_ac].xreh034,g_xreh2_d[l_ac].xreh034_desc)
      LET g_xreh2_d[l_ac].xreh016_desc = s_desc_show1(g_xreh2_d[l_ac].xreh016,g_xreh2_d[l_ac].xreh016_desc)
      LET g_xreh2_d[l_ac].xreh011_desc = s_desc_show1(g_xreh2_d[l_ac].xreh011,g_xreh2_d[l_ac].xreh011_desc)
      LET g_xreh2_d[l_ac].xreh012_desc = s_desc_show1(g_xreh2_d[l_ac].xreh012,g_xreh2_d[l_ac].xreh012_desc)
      LET g_xreh2_d[l_ac].xreh013_desc = s_desc_show1(g_xreh2_d[l_ac].xreh013,g_xreh2_d[l_ac].xreh013_desc)
      LET g_xreh2_d[l_ac].xreh014_desc = s_desc_show1(g_xreh2_d[l_ac].xreh014,g_xreh2_d[l_ac].xreh014_desc)
      LET g_xreh2_d[l_ac].xreh015_desc = s_desc_show1(g_xreh2_d[l_ac].xreh015,g_xreh2_d[l_ac].xreh015_desc)
      LET g_xreh2_d[l_ac].xreh017_desc = s_desc_show1(g_xreh2_d[l_ac].xreh017,g_xreh2_d[l_ac].xreh017_desc)
      LET g_xreh2_d[l_ac].xreh018_desc = s_desc_show1(g_xreh2_d[l_ac].xreh018,g_xreh2_d[l_ac].xreh018_desc)
      LET g_xreh2_d[l_ac].xreh020_desc = g_xreh2_d[l_ac].xreh020
      LET g_xreh2_d[l_ac].xreh021_desc = s_desc_show1(g_xreh2_d[l_ac].xreh021,g_xreh2_d[l_ac].xreh021_desc)
      LET g_xreh2_d[l_ac].xreh022_desc = s_desc_show1(g_xreh2_d[l_ac].xreh022,g_xreh2_d[l_ac].xreh022_desc)
    
      #自由核算項
      CALL s_fin_sel_glad(g_xreg_m.xregld,g_xreh2_d[l_ac].xreh019,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
           RETURNING g_errno,g_glad.*
      IF NOT cl_null(g_xreh2_d[l_ac].xreh023) THEN
         LET g_xreh2_d[l_ac].xreh023_desc = s_desc_show1(g_xreh2_d[l_ac].xreh023,s_fin_get_accting_desc(g_glad.glad0171,g_xreh2_d[l_ac].xreh023))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh024) THEN
         LET g_xreh2_d[l_ac].xreh024_desc = s_desc_show1(g_xreh2_d[l_ac].xreh024,s_fin_get_accting_desc(g_glad.glad0181,g_xreh2_d[l_ac].xreh024))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh025) THEN
         LET g_xreh2_d[l_ac].xreh025_desc = s_desc_show1(g_xreh2_d[l_ac].xreh025,s_fin_get_accting_desc(g_glad.glad0191,g_xreh2_d[l_ac].xreh025))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh026) THEN
         LET g_xreh2_d[l_ac].xreh026_desc = s_desc_show1(g_xreh2_d[l_ac].xreh026,s_fin_get_accting_desc(g_glad.glad0201,g_xreh2_d[l_ac].xreh026))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh027) THEN
         LET g_xreh2_d[l_ac].xreh027_desc = s_desc_show1(g_xreh2_d[l_ac].xreh027,s_fin_get_accting_desc(g_glad.glad0211,g_xreh2_d[l_ac].xreh027))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh028) THEN
         LET g_xreh2_d[l_ac].xreh028_desc = s_desc_show1(g_xreh2_d[l_ac].xreh028,s_fin_get_accting_desc(g_glad.glad0221,g_xreh2_d[l_ac].xreh028))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh029) THEN
         LET g_xreh2_d[l_ac].xreh029_desc = s_desc_show1(g_xreh2_d[l_ac].xreh029,s_fin_get_accting_desc(g_glad.glad0231,g_xreh2_d[l_ac].xreh029))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh030) THEN
         LET g_xreh2_d[l_ac].xreh030_desc = s_desc_show1(g_xreh2_d[l_ac].xreh030,s_fin_get_accting_desc(g_glad.glad0241,g_xreh2_d[l_ac].xreh030))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh031) THEN
         LET g_xreh2_d[l_ac].xreh031_desc = s_desc_show1(g_xreh2_d[l_ac].xreh031,s_fin_get_accting_desc(g_glad.glad0251,g_xreh2_d[l_ac].xreh031))
      END IF
      IF NOT cl_null(g_xreh2_d[l_ac].xreh032) THEN
         LET g_xreh2_d[l_ac].xreh032_desc = s_desc_show1(g_xreh2_d[l_ac].xreh032,s_fin_get_accting_desc(g_glad.glad0261,g_xreh2_d[l_ac].xreh032))
      END IF
   
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
   #160129-00015#2 add(E)
   #end add-point
   
   CALL g_xreh_d.deleteElement(g_xreh_d.getLength())
   CALL g_xreh2_d.deleteElement(g_xreh2_d.getLength())
   CALL g_xreh3_d.deleteElement(g_xreh3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt920_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xreh_d.getLength()
      LET g_xreh_d_mask_o[l_ac].* =  g_xreh_d[l_ac].*
      CALL aapt920_xreh_t_mask()
      LET g_xreh_d_mask_n[l_ac].* =  g_xreh_d[l_ac].*
   END FOR
   
   LET g_xreh2_d_mask_o.* =  g_xreh2_d.*
   FOR l_ac = 1 TO g_xreh2_d.getLength()
      LET g_xreh2_d_mask_o[l_ac].* =  g_xreh2_d[l_ac].*
      CALL aapt920_xreh_t_mask()
      LET g_xreh2_d_mask_n[l_ac].* =  g_xreh2_d[l_ac].*
   END FOR
   LET g_xreh3_d_mask_o.* =  g_xreh3_d.*
   FOR l_ac = 1 TO g_xreh3_d.getLength()
      LET g_xreh3_d_mask_o[l_ac].* =  g_xreh3_d[l_ac].*
      CALL aapt920_xreh_t_mask()
      LET g_xreh3_d_mask_n[l_ac].* =  g_xreh3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt920_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM xreh_t
       WHERE xrehent = g_enterprise AND
         xrehdocno = ps_keys_bak[1] AND xrehld = ps_keys_bak[2] AND xrehseq = ps_keys_bak[3]
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
         CALL g_xreh_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xreh2_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xreh3_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt920_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO xreh_t
                  (xrehent,
                   xrehdocno,
                   xrehld,xrehseq
                   ,xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009,xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xreh033,xreh019,xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020,xreh021,xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032,xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_xreh_d[g_detail_idx].xrehorga,g_xreh_d[g_detail_idx].xreh004,g_xreh_d[g_detail_idx].xreh005, 
                       g_xreh_d[g_detail_idx].xreh006,g_xreh_d[g_detail_idx].xreh007,g_xreh_d[g_detail_idx].xreh009, 
                       g_xreh_d[g_detail_idx].xreh008,g_xreh_d[g_detail_idx].xreh100,g_xreh_d[g_detail_idx].xreh102, 
                       g_xreh_d[g_detail_idx].xreh101,g_xreh_d[g_detail_idx].xreh103,g_xreh_d[g_detail_idx].xreh113, 
                       g_xreh_d[g_detail_idx].xreh114,g_xreh_d[g_detail_idx].xreh115,g_xreh2_d[g_detail_idx].xreh033, 
                       g_xreh2_d[g_detail_idx].xreh019,g_xreh2_d[g_detail_idx].xreh034,g_xreh2_d[g_detail_idx].xreh016, 
                       g_xreh2_d[g_detail_idx].xreh011,g_xreh2_d[g_detail_idx].xreh012,g_xreh2_d[g_detail_idx].xreh013, 
                       g_xreh2_d[g_detail_idx].xreh014,g_xreh2_d[g_detail_idx].xreh015,g_xreh2_d[g_detail_idx].xreh017, 
                       g_xreh2_d[g_detail_idx].xreh018,g_xreh2_d[g_detail_idx].xreh020,g_xreh2_d[g_detail_idx].xreh021, 
                       g_xreh2_d[g_detail_idx].xreh022,g_xreh2_d[g_detail_idx].xreh023,g_xreh2_d[g_detail_idx].xreh024, 
                       g_xreh2_d[g_detail_idx].xreh025,g_xreh2_d[g_detail_idx].xreh026,g_xreh2_d[g_detail_idx].xreh027, 
                       g_xreh2_d[g_detail_idx].xreh028,g_xreh2_d[g_detail_idx].xreh029,g_xreh2_d[g_detail_idx].xreh030, 
                       g_xreh2_d[g_detail_idx].xreh031,g_xreh2_d[g_detail_idx].xreh032,g_xreh3_d[g_detail_idx].xreh121, 
                       g_xreh3_d[g_detail_idx].xreh123,g_xreh3_d[g_detail_idx].xreh124,g_xreh3_d[g_detail_idx].xreh125, 
                       g_xreh3_d[g_detail_idx].xreh131,g_xreh3_d[g_detail_idx].xreh133,g_xreh3_d[g_detail_idx].xreh134, 
                       g_xreh3_d[g_detail_idx].xreh135)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xreh_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_xreh2_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'3'" THEN 
         CALL g_xreh3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt920_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2','3',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xreh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt920_xreh_t_mask_restore('restore_mask_o')
               
      UPDATE xreh_t 
         SET (xrehdocno,
              xrehld,xrehseq
              ,xrehorga,xreh004,xreh005,xreh006,xreh007,xreh009,xreh008,xreh100,xreh102,xreh101,xreh103,xreh113,xreh114,xreh115,xreh033,xreh019,xreh034,xreh016,xreh011,xreh012,xreh013,xreh014,xreh015,xreh017,xreh018,xreh020,xreh021,xreh022,xreh023,xreh024,xreh025,xreh026,xreh027,xreh028,xreh029,xreh030,xreh031,xreh032,xreh121,xreh123,xreh124,xreh125,xreh131,xreh133,xreh134,xreh135) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_xreh_d[g_detail_idx].xrehorga,g_xreh_d[g_detail_idx].xreh004,g_xreh_d[g_detail_idx].xreh005, 
                  g_xreh_d[g_detail_idx].xreh006,g_xreh_d[g_detail_idx].xreh007,g_xreh_d[g_detail_idx].xreh009, 
                  g_xreh_d[g_detail_idx].xreh008,g_xreh_d[g_detail_idx].xreh100,g_xreh_d[g_detail_idx].xreh102, 
                  g_xreh_d[g_detail_idx].xreh101,g_xreh_d[g_detail_idx].xreh103,g_xreh_d[g_detail_idx].xreh113, 
                  g_xreh_d[g_detail_idx].xreh114,g_xreh_d[g_detail_idx].xreh115,g_xreh2_d[g_detail_idx].xreh033, 
                  g_xreh2_d[g_detail_idx].xreh019,g_xreh2_d[g_detail_idx].xreh034,g_xreh2_d[g_detail_idx].xreh016, 
                  g_xreh2_d[g_detail_idx].xreh011,g_xreh2_d[g_detail_idx].xreh012,g_xreh2_d[g_detail_idx].xreh013, 
                  g_xreh2_d[g_detail_idx].xreh014,g_xreh2_d[g_detail_idx].xreh015,g_xreh2_d[g_detail_idx].xreh017, 
                  g_xreh2_d[g_detail_idx].xreh018,g_xreh2_d[g_detail_idx].xreh020,g_xreh2_d[g_detail_idx].xreh021, 
                  g_xreh2_d[g_detail_idx].xreh022,g_xreh2_d[g_detail_idx].xreh023,g_xreh2_d[g_detail_idx].xreh024, 
                  g_xreh2_d[g_detail_idx].xreh025,g_xreh2_d[g_detail_idx].xreh026,g_xreh2_d[g_detail_idx].xreh027, 
                  g_xreh2_d[g_detail_idx].xreh028,g_xreh2_d[g_detail_idx].xreh029,g_xreh2_d[g_detail_idx].xreh030, 
                  g_xreh2_d[g_detail_idx].xreh031,g_xreh2_d[g_detail_idx].xreh032,g_xreh3_d[g_detail_idx].xreh121, 
                  g_xreh3_d[g_detail_idx].xreh123,g_xreh3_d[g_detail_idx].xreh124,g_xreh3_d[g_detail_idx].xreh125, 
                  g_xreh3_d[g_detail_idx].xreh131,g_xreh3_d[g_detail_idx].xreh133,g_xreh3_d[g_detail_idx].xreh134, 
                  g_xreh3_d[g_detail_idx].xreh135) 
         WHERE xrehent = g_enterprise AND xrehdocno = ps_keys_bak[1] AND xrehld = ps_keys_bak[2] AND xrehseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xreh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xreh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt920_xreh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aapt920.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt920_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt920.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt920_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt920.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt920_lock_b(ps_table,ps_page)
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
   #CALL aapt920_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2','3',"
   #僅鎖定自身table
   LET ls_group = "xreh_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt920_bcl USING g_enterprise,
                                       g_xreg_m.xregdocno,g_xreh_d[g_detail_idx].xrehld,g_xreh_d[g_detail_idx].xrehseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt920_bcl:",SQLERRMESSAGE 
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
 
{<section id="aapt920.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt920_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2','3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt920_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt920_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xregdocno,xregld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xregdocno",TRUE)
      CALL cl_set_comp_entry("xregdocdt",TRUE)
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
 
{<section id="aapt920.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt920_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xregdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("xregld,xregsite,xreg004,xregdocdt,xreg001,xreg002",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xregdocno,xregld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xregdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt920.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt920_set_entry_b(p_cmd)
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
 
{<section id="aapt920.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt920_set_no_entry_b(p_cmd)
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
 
{<section id="aapt920.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt920_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt920_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_ld          LIKE glaa_t.glaald      #160225-00001#1
   DEFINE l_comp        LIKE glaa_t.glaacomp    #160225-00001#1
   DEFINE l_dfin0033    LIKE type_t.chr1        #160225-00001#1
   DEFINE l_slip        LIKE apca_t.apcadocno   #160225-00001#1
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_xreg_m.xregstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #160225-00001#1--(S)
   IF NOT cl_null(g_xreg_m.xregdocno) THEN
      SELECT xregld,xregcomp INTO l_ld,l_comp
        FROM xreg_t
       WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno
      CALL s_aooi200_fin_get_slip(g_xreg_m.xregdocno) RETURNING g_sub_success,l_slip
      CALL s_fin_get_doc_para(l_ld,l_comp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      CALL s_fin_date_close_chk('@',l_comp,'AAP',g_xreg_m.xregdocdt) RETURNING g_sub_success
      IF l_dfin0033 = "N" AND NOT g_sub_success THEN 
         CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
      END IF
   END IF
   #160225-00001#1--(E)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt920_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt920_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt920_default_search()
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
      LET ls_wc = ls_wc, " xregdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "xreg_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xreh_t" 
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
 
{<section id="aapt920.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt920_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_sfin3007  LIKE type_t.dat          #151020-00003#4
   DEFINE l_xregcomp  LIKE xreg_t.xregcomp     #151020-00003#4
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xreg_m.xregdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt920_cl USING g_enterprise,g_xreg_m.xregdocno
   IF STATUS THEN
      CLOSE aapt920_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt920_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld,g_xreg_m.xreg004, 
       g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus, 
       g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt,g_xreg_m.xregcrtid, 
       g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid_desc, 
       g_xreg_m.xregcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt920_action_chk() THEN
      CLOSE aapt920_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc, 
       g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001, 
       g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregownid_desc, 
       g_xreg_m.xregcrtdp,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtdt, 
       g_xreg_m.xregcrtid,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid,g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfdt, 
       g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregcnfid_desc
 
   CASE g_xreg_m.xregstus
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
         CASE g_xreg_m.xregstus
            
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
     
      CASE g_xreg_m.xregstus
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
            IF NOT aapt920_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt920_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aapt920_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aapt920_cl
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
      g_xreg_m.xregstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt920_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      ) OR 
      cl_null(lc_state) THEN
      CALL s_transaction_end('N','0')      #150401-00001#13
      RETURN
   END IF
   #確認
   IF lc_state = 'Y' THEN
      IF g_xreg_m.xregstus = 'N' THEN
         CALL cl_err_collect_init()
         CALL s_aapt920_conf_chk(g_xreg_m.xregdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                    #150401-00001#13
         ELSE
            #151020-00003#4---s
            #只能執行大於等於關帳年月之資料
            SELECT xregcomp INTO l_xregcomp FROM xreg_t WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno AND xreg003 = 'AP'  #151020-00003#4
            CALL cl_get_para(g_enterprise,l_xregcomp,'S-FIN-3007') RETURNING l_sfin3007 
            IF g_xreg_m.xregdocdt < l_sfin3007 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00061'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0') 
               CALL cl_err_collect_show()
               RETURN
            END IF
            #151020-00003#4---e
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               CALL cl_err_collect_show()
               RETURN                                 #150401-00001#13
            ELSE
               CALL s_transaction_begin()
               CALL s_aapt920_conf_upd(g_xreg_m.xregdocno) RETURNING g_sub_success
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
      CALL s_aapt920_unconf_chk(g_xreg_m.xregdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                    #150401-00001#13
      ELSE
         #151020-00003#4---s
         #只能執行大於等於關帳年月之資料
         SELECT xregcomp INTO l_xregcomp FROM xreg_t WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno AND xreg003 = 'AP'  #151020-00003#4
         CALL cl_get_para(g_enterprise,l_xregcomp,'S-FIN-3007') RETURNING l_sfin3007 
         IF g_xreg_m.xregdocdt < l_sfin3007 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'afa-00061'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
            CALL s_transaction_end('N','0') 
            CALL cl_err_collect_show()
            RETURN
         END IF
         #151020-00003#4---e
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                 #150401-00001#13
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt920_unconf_upd(g_xreg_m.xregdocno) RETURNING g_sub_success
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
      CALL s_aapt920_void_chk(g_xreg_m.xregdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         CALL cl_err_collect_show()
         RETURN                                    #150401-00001#13                          
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN   #是否執行取消作廢？
            CALL s_transaction_end('N','0')        #150401-00001#13
            CALL cl_err_collect_show()
            RETURN                                 #150401-00001#13
         ELSE
            CALL s_transaction_begin()
            CALL s_aapt920_void_upd(g_xreg_m.xregdocno) RETURNING g_sub_success
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
   
   LET g_xreg_m.xregmodid = g_user
   LET g_xreg_m.xregmoddt = cl_get_current()
   LET g_xreg_m.xregstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xreg_t 
      SET (xregstus,xregmodid,xregmoddt) 
        = (g_xreg_m.xregstus,g_xreg_m.xregmodid,g_xreg_m.xregmoddt)     
    WHERE xregent = g_enterprise AND xregdocno = g_xreg_m.xregdocno
 
    
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
      EXECUTE aapt920_master_referesh USING g_xreg_m.xregdocno INTO g_xreg_m.xregsite,g_xreg_m.xregld, 
          g_xreg_m.xreg004,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001,g_xreg_m.xreg002,g_xreg_m.xreg005, 
          g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregcrtdp,g_xreg_m.xregowndp,g_xreg_m.xregcrtdt, 
          g_xreg_m.xregcrtid,g_xreg_m.xregmodid,g_xreg_m.xregcnfdt,g_xreg_m.xregmoddt,g_xreg_m.xregcnfid, 
          g_xreg_m.xregownid_desc,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtid_desc, 
          g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xreg_m.xregsite,g_xreg_m.l_xregsite_desc,g_xreg_m.xregld,g_xreg_m.l_xregld_desc, 
          g_xreg_m.xreg004,g_xreg_m.l_xreg004_desc,g_xreg_m.xregdocno,g_xreg_m.xregdocdt,g_xreg_m.xreg001, 
          g_xreg_m.xreg002,g_xreg_m.xreg005,g_xreg_m.xregstus,g_xreg_m.xregownid,g_xreg_m.xregownid_desc, 
          g_xreg_m.xregcrtdp,g_xreg_m.xregcrtdp_desc,g_xreg_m.xregowndp,g_xreg_m.xregowndp_desc,g_xreg_m.xregcrtdt, 
          g_xreg_m.xregcrtid,g_xreg_m.xregcrtid_desc,g_xreg_m.xregmodid,g_xreg_m.xregmodid_desc,g_xreg_m.xregcnfdt, 
          g_xreg_m.xregmoddt,g_xreg_m.xregcnfid,g_xreg_m.xregcnfid_desc
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt920_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt920_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt920.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt920_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xreh_d.getLength() THEN
         LET g_detail_idx = g_xreh_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xreh_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xreh_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xreh2_d.getLength() THEN
         LET g_detail_idx = g_xreh2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xreh2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xreh2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xreh3_d.getLength() THEN
         LET g_detail_idx = g_xreh3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xreh3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xreh3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt920_b_fill2(pi_idx)
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
   
   CALL aapt920_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt920_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   RETURN FALSE   #160129-00015#2  #用自己寫的b_fill段
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
 
{<section id="aapt920.status_show" >}
PRIVATE FUNCTION aapt920_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt920.mask_functions" >}
&include "erp/aap/aapt920_mask.4gl"
 
{</section>}
 
{<section id="aapt920.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aapt920_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL aapt920_show()
   CALL aapt920_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_xreg_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_xreh_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_xreh2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_xreh3_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   #確認前檢核段
   IF NOT s_aapt920_conf_chk(g_xreg_m.xregdocno) THEN
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
   #CALL aapt920_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aapt920_ui_headershow()
   CALL aapt920_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aapt920_draw_out()
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
   CALL aapt920_ui_headershow()  
   CALL aapt920_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aapt920.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt920_set_pk_array()
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
   LET g_pk_array[1].values = g_xreg_m.xregdocno
   LET g_pk_array[1].column = 'xregdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt920.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt920.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt920_msgcentre_notify(lc_state)
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
   CALL aapt920_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xreg_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt920.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt920_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#2    16/08/24   By 07900  --add--s--
   SELECT xregstus INTO g_xreg_m.xregstus
     FROM xreg_t
    WHERE xregent = g_enterprise
      AND xregdocno = g_xreg_m.xregdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL   
     CASE g_xreg_m.xregstus
        
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
        LET g_errparam.extend = g_xreg_m.xregdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aapt920_set_act_visible()
        CALL aapt920_set_act_no_visible()
        CALL aapt920_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#2    16/08/24   By 07900  --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt920.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 依據傳入參數不同,執行單據串查
# Memo...........:
# Usage..........: aapt920_qrystr(p_field)
# Date & Author..: 150528 By rayhuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt920_qrystr(p_field)
   DEFINE p_field       LIKE type_t.chr500     
   DEFINE la_param      RECORD
          prog          STRING,
          actionid      STRING,
          background    LIKE type_t.chr1,
          param         DYNAMIC ARRAY OF STRING
                        END RECORD
   DEFINE ls_js      STRING
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_j           LIKE type_t.num5
           
   INITIALIZE la_param.* TO NULL
   CASE p_field 
      WHEN 'xreg005'
         IF cl_null(g_xreg_m.xregld) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'xregld')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         IF cl_null(g_xreg_m.xreg005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'xreg005')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         CALL s_aapt300_get_aglt3xx_prog(g_xreg_m.xregld,g_xreg_m.xreg005)RETURNING la_param.prog
         LET la_param.param[1] = g_xreg_m.xregld
         LET la_param.param[2] = g_xreg_m.xreg005
      
      WHEN 'xreh005'
         IF cl_null(g_xreg_m.xregld) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'xregld')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         IF cl_null(g_xreh_d[g_detail_idx].xreh005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = 'sub-00280'
            LET g_errparam.extend = s_fin_get_colname(g_prog,'xreh005')
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         END IF
         CALL s_aapt300_get_aapt3xx_prog(g_xreg_m.xregld,g_xreh_d[g_detail_idx].xreh005)RETURNING la_param.prog,l_i,l_j
         LET la_param.param[l_i] = g_xreg_m.xregld
         LET la_param.param[l_j] = g_xreh_d[g_detail_idx].xreh005
          
   END CASE
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js)
END FUNCTION

################################################################################
# Descriptions...: 更新摘要
# Memo...........: #161229-00018#1
# Usage..........: CALL aapt920_update_xreh033()
# Date & Author..: 170120 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt920_update_xreh033()
DEFINE l_sql             STRING
DEFINE l_xreh033         LIKE xreh_t.xreh033
DEFINE l_success         LIKE type_t.num5
   
   LET l_success = TRUE
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   LET l_xreh033 = ''
   LET l_sql = "SELECT xreh033 FROM xreh_t ",
               " WHERE xrehent = '",g_enterprise,"'",
               "   AND xrehld = '",g_xreg_m.xregld,"'",
               "   AND xrehdocno = '",g_xreg_m.xregdocno,"'",
               "   AND xreh033 IS NOT NULL"
   PREPARE aapt920_xreh033_pre FROM l_sql
   DECLARE aapt920_xreh033_cur SCROLL CURSOR WITH HOLD FOR aapt920_xreh033_pre
   OPEN aapt920_xreh033_cur
   FETCH FIRST aapt920_xreh033_cur INTO l_xreh033
   CLOSE aapt920_xreh033_cur
   
   
   UPDATE xreh_t SET xreh033 = l_xreh033
    WHERE xrehent = g_enterprise
      AND xrehld = g_xreg_m.xregld
      AND xrehdocno = g_xreg_m.xregdocno
      AND xreh033 IS NULL
      
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'upd xreh_t'
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET l_success = FALSE 
   END IF 
   
   IF l_success = TRUE THEN 
      CALL s_transaction_end('Y','1')
   ELSE
      CALL s_transaction_end('N','1')
   END IF
   CALL cl_err_collect_show()
   CALL aapt920_show()
END FUNCTION

 
{</section>}
 
