#該程式未解開Section, 採用最新樣板產出!
{<section id="afat470.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0025(2016-10-10 13:06:25), PR版次:0025(2017-01-04 09:11:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000200
#+ Filename...: afat470
#+ Description: 資產合併維護作業
#+ Creator....: 01531(2014-08-09 19:56:44)
#+ Modifier...: 07900 -SD/PR- 06821
 
{</section>}
 
{<section id="afat470.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150731-00004#1     BY yangtt 20150826     錯誤信息匯總報錯，將舊的報錯方式(cl_errmsg)改成新的報錯方式
#140721-00004#15    BY yangtt 20151022     新增列印功能
#151125-00001#1...: 2015/11/27 BY fionchen 執行[作廢]作業時,增加詢問「是否執行作廢？」
#151210-00006#1     2015/12/10 BY yangtt   单据作业动态设定打印报表元件
#151125-00006#1...: 2015/12/21 BY aiqq     新增/修改/複製/審核單據后立即執行審核/拋轉總賬傳票
#151130-00015#2     2015/12/21 BY taozf    判断 是否可以更改單據日期 設定開放單據日期修改
#160318-00005#10    2016/03/23 BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#4     2016/04/12 BY 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160414-00015#1     2016/04/22 BY 07673    复制时清空特定栏位
#160812-00017#7     2016/08/16 BY 06137    hange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160426-00014#33    2016/08/17 BY 02114    修改权限的问题
#160818-00017#9     2016/08/29 By 07900    删除修改未重新判断状态码
#160905-00007#2     2016/09/05 by 08742    调整系统中无ENT的SQL条件增加ent
#160426-00014#23    2016/09/13 By 07900    固定资产的t作业的单身都增加名称与规格二个栏位，取值来源为afai100的faah012,faah013,各单身表栏位直接按现有表依序增加
#161009-00007#1     2016/10/10 By 07900    1）单身一多了一个‘规格’栏位，测试和‘规格型号’是一样的。
#                                          2）单身二增加名称栏位（实体字段，表结构要加字段），产生到afai100时，faah013=单身二的名称。
#161009-00006#7     2016/10/13 By 02114    卡编自动编码时，抓取max（卡编）要按归属法人来抓
#161017-00023#1     2016/10/26 By 02114    权限调整
#161024-00008#3     2016/10/26 By Hans     AFA組織類型與職能開窗清單調整。
#161111-00028#7     2016/11/22 by 02481    标准程式定义采用宣告模式,弃用.*写法
#160824-00007#235   2016/12/02 By sakura   新舊值備份處理
#161123-00048#2     2016/12/26 By 08171    開窗範圍處理(卡片編號、財產編號、附號、主要類型)
#161104-00046#16    2017/01/04 By 06821    單別預設值;資料依照單別user dept權限過濾單號
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
PRIVATE type type_g_faba_m        RECORD
       fabasite LIKE faba_t.fabasite, 
   fabasite_desc LIKE type_t.chr80, 
   faba001 LIKE faba_t.faba001, 
   faba001_desc LIKE type_t.chr80, 
   fabacomp LIKE faba_t.fabacomp, 
   fabacomp_desc LIKE type_t.chr80, 
   faba004 LIKE type_t.chr20, 
   faba004_desc LIKE type_t.chr80, 
   faba005 LIKE type_t.chr10, 
   faba005_desc LIKE type_t.chr80, 
   faba006 LIKE type_t.dat, 
   faba003 LIKE faba_t.faba003, 
   fabadocno LIKE faba_t.fabadocno, 
   fabadocdt LIKE faba_t.fabadocdt, 
   fabastus LIKE faba_t.fabastus, 
   fabaownid LIKE faba_t.fabaownid, 
   fabaownid_desc LIKE type_t.chr80, 
   fabaowndp LIKE faba_t.fabaowndp, 
   fabaowndp_desc LIKE type_t.chr80, 
   fabacrtid LIKE faba_t.fabacrtid, 
   fabacrtid_desc LIKE type_t.chr80, 
   fabacrtdp LIKE faba_t.fabacrtdp, 
   fabacrtdp_desc LIKE type_t.chr80, 
   fabacrtdt LIKE faba_t.fabacrtdt, 
   fabamodid LIKE faba_t.fabamodid, 
   fabamodid_desc LIKE type_t.chr80, 
   fabamoddt LIKE faba_t.fabamoddt, 
   fabacnfid LIKE faba_t.fabacnfid, 
   fabacnfid_desc LIKE type_t.chr80, 
   fabacnfdt LIKE faba_t.fabacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fabl_d        RECORD
       fablseq LIKE fabl_t.fablseq, 
   fabl001 LIKE fabl_t.fabl001, 
   fabl002 LIKE fabl_t.fabl002, 
   fabl003 LIKE fabl_t.fabl003, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   fabl017 LIKE fabl_t.fabl017, 
   fabl004 LIKE fabl_t.fabl004, 
   fabl004_desc LIKE type_t.chr500, 
   fabl005 LIKE fabl_t.fabl005, 
   fabl006 LIKE fabl_t.fabl006, 
   fabl007 LIKE fabl_t.fabl007, 
   fabl008 LIKE fabl_t.fabl008, 
   fabl009 LIKE fabl_t.fabl009, 
   fabl010 LIKE fabl_t.fabl010, 
   fabl011 LIKE fabl_t.fabl011, 
   fabl012 LIKE fabl_t.fabl012, 
   fabl016 LIKE type_t.num20_6, 
   fabl019 LIKE type_t.num20_6, 
   fabl013 LIKE fabl_t.fabl013, 
   fabl014 LIKE fabl_t.fabl014, 
   fabl015 LIKE fabl_t.fabl015, 
   fabl101 LIKE type_t.chr10, 
   fabl102 LIKE type_t.num26_10, 
   fabl103 LIKE type_t.num20_6, 
   fabl104 LIKE type_t.num20_6, 
   fabl105 LIKE type_t.num20_6, 
   fabl106 LIKE type_t.num20_6, 
   fabl201 LIKE type_t.chr10, 
   fabl202 LIKE type_t.num26_10, 
   fabl203 LIKE type_t.num20_6, 
   fabl204 LIKE type_t.num20_6, 
   fabl205 LIKE type_t.num20_6, 
   fabl206 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_fabl2_d RECORD
       fabmseq LIKE fabm_t.fabmseq, 
   fabm005 LIKE fabm_t.fabm005, 
   fabm001 LIKE fabm_t.fabm001, 
   fabm002 LIKE fabm_t.fabm002, 
   fabm003 LIKE fabm_t.fabm003, 
   fabm020 LIKE fabm_t.fabm020, 
   fabm006 LIKE fabm_t.fabm006, 
   fabm004 LIKE fabm_t.fabm004, 
   fabm004_desc LIKE type_t.chr500, 
   fabm007 LIKE fabm_t.fabm007, 
   fabm008 LIKE fabm_t.fabm008, 
   fabm009 LIKE fabm_t.fabm009, 
   fabm010 LIKE fabm_t.fabm010, 
   fabm011 LIKE fabm_t.fabm011, 
   fabm012 LIKE fabm_t.fabm012, 
   fabm013 LIKE fabm_t.fabm013, 
   fabm017 LIKE type_t.num20_6, 
   fabm018 LIKE type_t.num20_6, 
   fabm014 LIKE fabm_t.fabm014, 
   fabm015 LIKE fabm_t.fabm015, 
   fabm016 LIKE fabm_t.fabm016, 
   fabm101 LIKE type_t.chr10, 
   fabm102 LIKE type_t.num26_10, 
   fabm103 LIKE type_t.num20_6, 
   fabm104 LIKE type_t.num20_6, 
   fabm105 LIKE type_t.num20_6, 
   fabm106 LIKE type_t.num20_6, 
   fabm201 LIKE type_t.chr10, 
   fabm202 LIKE type_t.num26_10, 
   fabm203 LIKE type_t.num20_6, 
   fabm204 LIKE type_t.num20_6, 
   fabm205 LIKE type_t.num20_6, 
   fabm206 LIKE type_t.num20_6
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fabadocno LIKE faba_t.fabadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ooan005             LIKE ooan_t.ooan005
DEFINE g_glaald              LIKE glaa_t.glaald
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa025             LIKE glaa_t.glaa025
DEFINE g_para_data           LIKE type_t.chr80     #卡片編號是否自動編號
DEFINE g_faac016             LIKE faac_t.faac016
DEFINE g_faac003             LIKE faac_t.faac003
DEFINE g_faac004             LIKE faac_t.faac004
#161111-00028#7---modify----begin--------- 
#DEFINE g_glaa               RECORD LIKE glaa_t.*    #20150608 add lujh 
DEFINE g_glaa RECORD  #帳套資料檔
       glaaent LIKE glaa_t.glaaent, #企業編號
       glaaownid LIKE glaa_t.glaaownid, #資料所有者
       glaaowndp LIKE glaa_t.glaaowndp, #資料所屬部門
       glaacrtid LIKE glaa_t.glaacrtid, #資料建立者
       glaacrtdp LIKE glaa_t.glaacrtdp, #資料建立部門
       glaacrtdt LIKE glaa_t.glaacrtdt, #資料創建日
       glaamodid LIKE glaa_t.glaamodid, #資料修改者
       glaamoddt LIKE glaa_t.glaamoddt, #最近修改日
       glaastus LIKE glaa_t.glaastus, #狀態碼
       glaald LIKE glaa_t.glaald, #帳套編號
       glaacomp LIKE glaa_t.glaacomp, #歸屬法人
       glaa001 LIKE glaa_t.glaa001, #使用幣別
       glaa002 LIKE glaa_t.glaa002, #匯率參照表號
       glaa003 LIKE glaa_t.glaa003, #會計週期參照表號
       glaa004 LIKE glaa_t.glaa004, #會計科目參照表號
       glaa005 LIKE glaa_t.glaa005, #現金變動參照表號
       glaa006 LIKE glaa_t.glaa006, #月結方式
       glaa007 LIKE glaa_t.glaa007, #年結方式
       glaa008 LIKE glaa_t.glaa008, #平行記帳否
       glaa009 LIKE glaa_t.glaa009, #傳票登入方式
       glaa010 LIKE glaa_t.glaa010, #現行年度
       glaa011 LIKE glaa_t.glaa011, #現行期別
       glaa012 LIKE glaa_t.glaa012, #最後過帳日期
       glaa013 LIKE glaa_t.glaa013, #關帳日期
       glaa014 LIKE glaa_t.glaa014, #主帳套
       glaa015 LIKE glaa_t.glaa015, #啟用本位幣二
       glaa016 LIKE glaa_t.glaa016, #本位幣二
       glaa017 LIKE glaa_t.glaa017, #本位幣二換算基準
       glaa018 LIKE glaa_t.glaa018, #本位幣二匯率採用
       glaa019 LIKE glaa_t.glaa019, #啟用本位幣三
       glaa020 LIKE glaa_t.glaa020, #本位幣三
       glaa021 LIKE glaa_t.glaa021, #本位幣三換算基準
       glaa022 LIKE glaa_t.glaa022, #本位幣三匯率採用
       glaa023 LIKE glaa_t.glaa023, #次帳套帳務產生時機
       glaa024 LIKE glaa_t.glaa024, #單據別參照表號
       glaa025 LIKE glaa_t.glaa025, #本位幣一匯率採用
       glaa026 LIKE glaa_t.glaa026, #幣別參照表號
       glaa100 LIKE glaa_t.glaa100, #傳票輸入時自動按缺號產生
       glaa101 LIKE glaa_t.glaa101, #傳票總號輸入時機
       glaa102 LIKE glaa_t.glaa102, #傳票成立時,借貸不平衡的處理方式
       glaa103 LIKE glaa_t.glaa103, #未列印的傳票可否進行過帳
       glaa111 LIKE glaa_t.glaa111, #應計調整單別
       glaa112 LIKE glaa_t.glaa112, #期末結轉單別
       glaa113 LIKE glaa_t.glaa113, #年底結轉單別
       glaa120 LIKE glaa_t.glaa120, #成本計算類型
       glaa121 LIKE glaa_t.glaa121, #子模組啟用分錄底稿
       glaa122 LIKE glaa_t.glaa122, #總帳可維護資金異動明細
       glaa027 LIKE glaa_t.glaa027, #單據據點編號
       glaa130 LIKE glaa_t.glaa130, #合併帳套否
       glaa131 LIKE glaa_t.glaa131, #分層合併
       glaa132 LIKE glaa_t.glaa132, #平均匯率計算方式
       glaa133 LIKE glaa_t.glaa133, #非T100公司匯入餘額類型
       glaa134 LIKE glaa_t.glaa134, #合併科目轉換依據異動碼設定值
       glaa135 LIKE glaa_t.glaa135, #現流表間接法群組參照表號
       glaa136 LIKE glaa_t.glaa136, #應收帳款核銷限定己立帳傳票
       glaa137 LIKE glaa_t.glaa137, #應付帳款核銷限定已立帳傳票
       glaa138 LIKE glaa_t.glaa138, #合併報表編制期別
       glaa139 LIKE glaa_t.glaa139, #遞延收入(負債)管理產生否
       glaa140 LIKE glaa_t.glaa140, #無原出貨單的遞延負債減項者,是否仍立遞延收入管理?
       glaa123 LIKE glaa_t.glaa123, #應收帳款核銷可維護資金異動明細
       glaa124 LIKE glaa_t.glaa124, #應付帳款核銷可維護資金異動明細
       glaa028 LIKE glaa_t.glaa028  #匯率來源
       END RECORD
   #161111-00028#3---modify----end---------
DEFINE g_site_str            STRING                  #160426-00014#33 add lujh
#161104-00046#16 --s add
DEFINE g_user_dept_wc        STRING     
DEFINE g_user_dept_wc_q      STRING     
DEFINE g_user_slip_wc        STRING  
DEFINE g_ap_slip             LIKE ooba_t.ooba002
#161104-00046#16 --e add
#end add-point
       
#模組變數(Module Variables)
DEFINE g_faba_m          type_g_faba_m
DEFINE g_faba_m_t        type_g_faba_m
DEFINE g_faba_m_o        type_g_faba_m
DEFINE g_faba_m_mask_o   type_g_faba_m #轉換遮罩前資料
DEFINE g_faba_m_mask_n   type_g_faba_m #轉換遮罩後資料
 
   DEFINE g_fabadocno_t LIKE faba_t.fabadocno
 
 
DEFINE g_fabl_d          DYNAMIC ARRAY OF type_g_fabl_d
DEFINE g_fabl_d_t        type_g_fabl_d
DEFINE g_fabl_d_o        type_g_fabl_d
DEFINE g_fabl_d_mask_o   DYNAMIC ARRAY OF type_g_fabl_d #轉換遮罩前資料
DEFINE g_fabl_d_mask_n   DYNAMIC ARRAY OF type_g_fabl_d #轉換遮罩後資料
DEFINE g_fabl2_d          DYNAMIC ARRAY OF type_g_fabl2_d
DEFINE g_fabl2_d_t        type_g_fabl2_d
DEFINE g_fabl2_d_o        type_g_fabl2_d
DEFINE g_fabl2_d_mask_o   DYNAMIC ARRAY OF type_g_fabl2_d #轉換遮罩前資料
DEFINE g_fabl2_d_mask_n   DYNAMIC ARRAY OF type_g_fabl2_d #轉換遮罩後資料
 
 
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
 
{<section id="afat470.main" >}
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
   CALL cl_ap_init("afa","")
 
   #add-point:作業初始化 name="main.init"
   #161104-00046#16 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_faba_m','','','','','','')RETURNING g_sub_success
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('fabacomp','','fabaent','fabadocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#16 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fabasite,'',faba001,'',fabacomp,'','','','','','',faba003,fabadocno,fabadocdt, 
       fabastus,fabaownid,'',fabaowndp,'',fabacrtid,'',fabacrtdp,'',fabacrtdt,fabamodid,'',fabamoddt, 
       fabacnfid,'',fabacnfdt", 
                      " FROM faba_t",
                      " WHERE fabaent= ? AND fabadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat470_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fabasite,t0.faba001,t0.fabacomp,t0.faba004,t0.faba005,t0.faba006, 
       t0.faba003,t0.fabadocno,t0.fabadocdt,t0.fabastus,t0.fabaownid,t0.fabaowndp,t0.fabacrtid,t0.fabacrtdp, 
       t0.fabacrtdt,t0.fabamodid,t0.fabamoddt,t0.fabacnfid,t0.fabacnfdt,t1.ooefl003 ,t2.ooag011 ,t3.ooefl003 , 
       t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,t10.ooag011 ,t11.ooag011", 
 
               " FROM faba_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.fabasite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.faba001  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.fabacomp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.faba004  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.faba005 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.fabaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.fabaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.fabacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.fabacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.fabamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.fabacnfid  ",
 
               " WHERE t0.fabaent = " ||g_enterprise|| " AND t0.fabadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afat470_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afat470 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afat470_init()   
 
      #進入選單 Menu (="N")
      CALL afat470_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afat470
      
   END IF 
   
   CLOSE afat470_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afat470.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afat470_init()
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
      CALL cl_set_combo_scc_part('fabastus','13','N,Y,A,D,R,W,S,X')
 
      CALL cl_set_combo_scc('faba003','9910') 
   CALL cl_set_combo_scc('fabl017','9911') 
   CALL cl_set_combo_scc('fabl007','9903') 
   CALL cl_set_combo_scc('fabl008','9917') 
   CALL cl_set_combo_scc('fabm005','9911') 
   CALL cl_set_combo_scc('fabm008','9903') 
   CALL cl_set_combo_scc('fabm009','9917') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_faba_m.faba003 = '18'
   CALL cl_set_combo_scc_part('faba003','9910','18')
   CALL s_fin_create_account_center_tmp() 
   #end add-point
   
   #初始化搜尋條件
   CALL afat470_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afat470.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afat470_ui_dialog()
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
   DEFINE l_wc       STRING    #140721-00004#15
   #151125-00006#1 add ---s 
   DEFINE l_cn              LIKE type_t.num5
   #151125-00006#1 add ---e
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
            CALL afat470_insert()
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
         INITIALIZE g_faba_m.* TO NULL
         CALL g_fabl_d.clear()
         CALL g_fabl2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afat470_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fabl_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat470_idx_chk()
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
               CALL afat470_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fabl2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afat470_idx_chk()
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
               CALL afat470_idx_chk()
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
            CALL afat470_browser_fill("")
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
               CALL afat470_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afat470_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afat470_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afat470_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afat470_set_act_visible()   
            CALL afat470_set_act_no_visible()
            IF NOT (g_faba_m.fabadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fabaent = " ||g_enterprise|| " AND",
                                  " fabadocno = '", g_faba_m.fabadocno, "' "
 
               #填到對應位置
               CALL afat470_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "faba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabl_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabm_t" 
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
               CALL afat470_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "faba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabl_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fabm_t" 
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
                  CALL afat470_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afat470_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afat470_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat470_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afat470_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat470_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afat470_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat470_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afat470_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat470_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afat470_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afat470_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fabl_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fabl2_d)
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
               CALL afat470_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#1---add--s
               CALL afat470_ui_headershow()
               #151125-00006#1---add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afat470_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#1---add--s
               CALL afat470_ui_headershow()
               #151125-00006#1---add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afat470_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afat470_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#1---add--s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM faba_t 
                      WHERE fabaent = g_enterprise
                        AND fabadocno = g_faba_m.fabadocno
                        
               IF l_cn > 0 THEN
                  CALL afat470_ui_headershow()
               END IF
               #151125-00006#1---add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #151210-00006#1---add----str--
               LET g_rep_wc = " fabasite ='"||g_faba_m.fabasite||"' AND faba003 = '"||
                              g_faba_m.faba003||"' AND fabastus = '"||g_faba_m.fabastus||
                              "' AND fabadocno = '"||g_faba_m.fabadocno||"'"
               #151210-00006#1---add----end--
               #END add-point
               &include "erp/afa/afat470_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
#151210-00006#1---mark----str--
               #140721-00004#15---add---str
#               LET l_wc = " fabadocno = '",g_faba_m.fabadocno,"'"
#               CALL afar500_g08(l_wc,g_faba_m.fabasite,g_faba_m.faba003,g_faba_m.fabastus)
               #140721-00004#15---add---end
#151210-00006#1---mark----end--
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #151210-00006#1---add----str--
               LET g_rep_wc = " fabasite ='"||g_faba_m.fabasite||"' AND faba003 = '"||
                              g_faba_m.faba003||"' AND fabastus = '"||g_faba_m.fabastus||
                              "' AND fabadocno = '"||g_faba_m.fabadocno||"'"
               #151210-00006#1---add----end--
               #END add-point
               &include "erp/afa/afat470_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afat470_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#1---add--s
               LET l_cn = 0 
               SELECT COUNT(*) INTO l_cn FROM faba_t 
                      WHERE fabaent = g_enterprise
                        AND fabadocno = g_faba_m.fabadocno
                        
               IF l_cn > 0 THEN
                  CALL afat470_ui_headershow()
               END IF
               #151125-00006#1---add--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afat470_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faba001
            LET g_action_choice="prog_faba001"
            IF cl_auth_chk_act("prog_faba001") THEN
               
               #add-point:ON ACTION prog_faba001 name="menu.prog_faba001"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faba_m.faba001)
 


               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_faba004
            LET g_action_choice="prog_faba004"
            IF cl_auth_chk_act("prog_faba004") THEN
               
               #add-point:ON ACTION prog_faba004 name="menu.prog_faba004"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_faba_m.faba004)


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afat470_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afat470_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afat470_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_faba_m.fabadocdt)
 
 
 
         
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
 
{<section id="afat470.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afat470_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_comp_str        STRING    #160426-00014#33 add lujh
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
   LET l_wc=l_wc," AND faba003='18' "
   
   #160426-00014#33--add--str--lujh
   CALL s_axrt300_get_site(g_user,'','1') RETURNING l_comp_str
   LET l_comp_str = cl_replace_str(l_comp_str,"ooef001","fabasite")
   LET l_wc = l_wc," AND ",l_comp_str
   #160426-00014#33--add--end--lujh
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fabadocno ",
                      " FROM faba_t ",
                      " ",
                      " LEFT JOIN fabl_t ON fablent = fabaent AND fabadocno = fabldocno ", "  ",
                      #add-point:browser_fill段sql(fabl_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN fabm_t ON fabment = fabaent AND fabadocno = fabmdocno", "  ",
                      #add-point:browser_fill段sql(fabm_t1) name="browser_fill.cnt.join.fabm_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE fabaent = " ||g_enterprise|| " AND fablent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("faba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fabadocno ",
                      " FROM faba_t ", 
                      "  ",
                      "  ",
                      " WHERE fabaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("faba_t")
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
      INITIALIZE g_faba_m.* TO NULL
      CALL g_fabl_d.clear()        
      CALL g_fabl2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fabadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabastus,t0.fabadocno ",
                  " FROM faba_t t0",
                  "  ",
                  "  LEFT JOIN fabl_t ON fablent = fabaent AND fabadocno = fabldocno ", "  ", 
                  #add-point:browser_fill段sql(fabl_t1) name="browser_fill.join.fabl_t1"
                  
                  #end add-point
                  "  LEFT JOIN fabm_t ON fabment = fabaent AND fabadocno = fabmdocno", "  ", 
                  #add-point:browser_fill段sql(fabm_t1) name="browser_fill.join.fabm_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.fabaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("faba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fabastus,t0.fabadocno ",
                  " FROM faba_t t0",
                  "  ",
                  
                  " WHERE t0.fabaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("faba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fabadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"faba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fabadocno
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
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_fabadocno) THEN
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
 
{<section id="afat470.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afat470_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_faba_m.fabadocno = g_browser[g_current_idx].b_fabadocno   
 
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
   CALL afat470_faba_t_mask()
   CALL afat470_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afat470.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afat470_ui_detailshow()
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
 
{<section id="afat470.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afat470_ui_browser_refresh()
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
      IF g_browser[l_i].b_fabadocno = g_faba_m.fabadocno 
 
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
 
{<section id="afat470.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afat470_construct()
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
   DEFINE l_comp_str  STRING    #160426-00014#33 add lujh
   DEFINE l_ld_str    STRING    #161123-00048#2 add
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_faba_m.* TO NULL
   CALL g_fabl_d.clear()        
   CALL g_fabl2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_site_str = NULL      #160426-00014#33 add lujh
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fabasite,faba001,fabacomp,faba004,faba005,faba006,faba003,fabadocno, 
          fabadocdt,fabastus,fabaownid,fabaowndp,fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt,fabacnfid, 
          fabacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fabacrtdt>>----
         AFTER FIELD fabacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fabamoddt>>----
         AFTER FIELD fabamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabacnfdt>>----
         AFTER FIELD fabacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fabapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.fabasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabasite
            #add-point:ON ACTION controlp INFIELD fabasite name="construct.c.fabasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            #CALL q_ooef001()                           #呼叫開窗         #161024-00008#3 
            CALL q_ooef001_47()                                          #161024-00008#3 
            DISPLAY g_qryparam.return1 TO fabasite  #顯示到畫面上
            NEXT FIELD fabasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabasite
            #add-point:BEFORE FIELD fabasite name="construct.b.fabasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabasite
            
            #add-point:AFTER FIELD fabasite name="construct.a.fabasite"
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_site_str      #160426-00014#33 add lujh
            #END add-point
            
 
 
         #Ctrlp:construct.c.faba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba001
            #add-point:ON ACTION controlp INFIELD faba001 name="construct.c.faba001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faba001  #顯示到畫面上
            NEXT FIELD faba001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba001
            #add-point:BEFORE FIELD faba001 name="construct.b.faba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba001
            
            #add-point:AFTER FIELD faba001 name="construct.a.faba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabacomp
            #add-point:ON ACTION controlp INFIELD fabacomp name="construct.c.fabacomp"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str      #160426-00014#33 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y' AND ",l_comp_str      #160426-00014#33 add l_comp_str lujh
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#3 
            CALL q_ooef001_2()                           #呼叫開窗 #161024-00008#3 
            DISPLAY g_qryparam.return1 TO fabacomp  #顯示到畫面上
            NEXT FIELD fabacomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacomp
            #add-point:BEFORE FIELD fabacomp name="construct.b.fabacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabacomp
            
            #add-point:AFTER FIELD fabacomp name="construct.a.fabacomp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba004
            #add-point:BEFORE FIELD faba004 name="construct.b.faba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba004
            
            #add-point:AFTER FIELD faba004 name="construct.a.faba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba004
            #add-point:ON ACTION controlp INFIELD faba004 name="construct.c.faba004"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO faba004  #顯示到畫面上
            NEXT FIELD faba004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba005
            #add-point:BEFORE FIELD faba005 name="construct.b.faba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba005
            
            #add-point:AFTER FIELD faba005 name="construct.a.faba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba005
            #add-point:ON ACTION controlp INFIELD faba005 name="construct.c.faba005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO faba005  #顯示到畫面上
            NEXT FIELD faba005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba006
            #add-point:BEFORE FIELD faba006 name="construct.b.faba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba006
            
            #add-point:AFTER FIELD faba006 name="construct.a.faba006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba006
            #add-point:ON ACTION controlp INFIELD faba006 name="construct.c.faba006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba003
            #add-point:BEFORE FIELD faba003 name="construct.b.faba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba003
            
            #add-point:AFTER FIELD faba003 name="construct.a.faba003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.faba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba003
            #add-point:ON ACTION controlp INFIELD faba003 name="construct.c.faba003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocno
            #add-point:BEFORE FIELD fabadocno name="construct.b.fabadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocno
            
            #add-point:AFTER FIELD fabadocno name="construct.a.fabadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocno
            #add-point:ON ACTION controlp INFIELD fabadocno name="construct.c.fabadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " faba003 = '18' "
            #161104-00046#16 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#16 --e add            
            CALL q_fabadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabadocno  #顯示到畫面上
            NEXT FIELD fabadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocdt
            #add-point:BEFORE FIELD fabadocdt name="construct.b.fabadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocdt
            
            #add-point:AFTER FIELD fabadocdt name="construct.a.fabadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocdt
            #add-point:ON ACTION controlp INFIELD fabadocdt name="construct.c.fabadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabastus
            #add-point:BEFORE FIELD fabastus name="construct.b.fabastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabastus
            
            #add-point:AFTER FIELD fabastus name="construct.a.fabastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabastus
            #add-point:ON ACTION controlp INFIELD fabastus name="construct.c.fabastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabaownid
            #add-point:ON ACTION controlp INFIELD fabaownid name="construct.c.fabaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabaownid  #顯示到畫面上
            NEXT FIELD fabaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabaownid
            #add-point:BEFORE FIELD fabaownid name="construct.b.fabaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabaownid
            
            #add-point:AFTER FIELD fabaownid name="construct.a.fabaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabaowndp
            #add-point:ON ACTION controlp INFIELD fabaowndp name="construct.c.fabaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabaowndp  #顯示到畫面上
            NEXT FIELD fabaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabaowndp
            #add-point:BEFORE FIELD fabaowndp name="construct.b.fabaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabaowndp
            
            #add-point:AFTER FIELD fabaowndp name="construct.a.fabaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabacrtid
            #add-point:ON ACTION controlp INFIELD fabacrtid name="construct.c.fabacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabacrtid  #顯示到畫面上
            NEXT FIELD fabacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacrtid
            #add-point:BEFORE FIELD fabacrtid name="construct.b.fabacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabacrtid
            
            #add-point:AFTER FIELD fabacrtid name="construct.a.fabacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fabacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabacrtdp
            #add-point:ON ACTION controlp INFIELD fabacrtdp name="construct.c.fabacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabacrtdp  #顯示到畫面上
            NEXT FIELD fabacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacrtdp
            #add-point:BEFORE FIELD fabacrtdp name="construct.b.fabacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabacrtdp
            
            #add-point:AFTER FIELD fabacrtdp name="construct.a.fabacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacrtdt
            #add-point:BEFORE FIELD fabacrtdt name="construct.b.fabacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabamodid
            #add-point:ON ACTION controlp INFIELD fabamodid name="construct.c.fabamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabamodid  #顯示到畫面上
            NEXT FIELD fabamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabamodid
            #add-point:BEFORE FIELD fabamodid name="construct.b.fabamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabamodid
            
            #add-point:AFTER FIELD fabamodid name="construct.a.fabamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabamoddt
            #add-point:BEFORE FIELD fabamoddt name="construct.b.fabamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fabacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabacnfid
            #add-point:ON ACTION controlp INFIELD fabacnfid name="construct.c.fabacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabacnfid  #顯示到畫面上
            NEXT FIELD fabacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacnfid
            #add-point:BEFORE FIELD fabacnfid name="construct.b.fabacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabacnfid
            
            #add-point:AFTER FIELD fabacnfid name="construct.a.fabacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacnfdt
            #add-point:BEFORE FIELD fabacnfdt name="construct.b.fabacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fablseq,fabl001,fabl002,fabl003,faah012,faah013,fabl017,fabl004,fabl005, 
          fabl006,fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014,fabl015, 
          fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206 
 
           FROM s_detail1[1].fablseq,s_detail1[1].fabl001,s_detail1[1].fabl002,s_detail1[1].fabl003, 
               s_detail1[1].faah012,s_detail1[1].faah013,s_detail1[1].fabl017,s_detail1[1].fabl004,s_detail1[1].fabl005, 
               s_detail1[1].fabl006,s_detail1[1].fabl007,s_detail1[1].fabl008,s_detail1[1].fabl009,s_detail1[1].fabl010, 
               s_detail1[1].fabl011,s_detail1[1].fabl012,s_detail1[1].fabl016,s_detail1[1].fabl019,s_detail1[1].fabl013, 
               s_detail1[1].fabl014,s_detail1[1].fabl015,s_detail1[1].fabl101,s_detail1[1].fabl102,s_detail1[1].fabl103, 
               s_detail1[1].fabl104,s_detail1[1].fabl105,s_detail1[1].fabl106,s_detail1[1].fabl201,s_detail1[1].fabl202, 
               s_detail1[1].fabl203,s_detail1[1].fabl204,s_detail1[1].fabl205,s_detail1[1].fabl206
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fablseq
            #add-point:BEFORE FIELD fablseq name="construct.b.page1.fablseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fablseq
            
            #add-point:AFTER FIELD fablseq name="construct.a.page1.fablseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fablseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fablseq
            #add-point:ON ACTION controlp INFIELD fablseq name="construct.c.page1.fablseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl001
            #add-point:ON ACTION controlp INFIELD fabl001 name="construct.c.page1.fabl001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah003_5() 
			   #161123-00048#2 add e--- 
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabl001  #顯示到畫面上
            NEXT FIELD fabl001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl001
            #add-point:BEFORE FIELD fabl001 name="construct.b.page1.fabl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl001
            
            #add-point:AFTER FIELD fabl001 name="construct.a.page1.fabl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl002
            #add-point:ON ACTION controlp INFIELD fabl002 name="construct.c.page1.fabl002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah004()
			   #161123-00048#2 add e--- 
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabl002  #顯示到畫面上
            NEXT FIELD fabl002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl002
            #add-point:BEFORE FIELD fabl002 name="construct.b.page1.fabl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl002
            
            #add-point:AFTER FIELD fabl002 name="construct.a.page1.fabl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl003
            #add-point:ON ACTION controlp INFIELD fabl003 name="construct.c.page1.fabl003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah001()
			   #161123-00048#2 add e--- 
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabl003  #顯示到畫面上
            NEXT FIELD fabl003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl003
            #add-point:BEFORE FIELD fabl003 name="construct.b.page1.fabl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl003
            
            #add-point:AFTER FIELD fabl003 name="construct.a.page1.fabl003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="construct.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="construct.a.page1.faah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="construct.c.page1.faah012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="construct.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="construct.a.page1.faah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="construct.c.page1.faah013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl017
            #add-point:BEFORE FIELD fabl017 name="construct.b.page1.fabl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl017
            
            #add-point:AFTER FIELD fabl017 name="construct.a.page1.fabl017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl017
            #add-point:ON ACTION controlp INFIELD fabl017 name="construct.c.page1.fabl017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl004
            #add-point:ON ACTION controlp INFIELD fabl004 name="construct.c.page1.fabl004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161123-00048#2 add e---  
            #CALL q_faac001()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabl004  #顯示到畫面上
            NEXT FIELD fabl004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl004
            #add-point:BEFORE FIELD fabl004 name="construct.b.page1.fabl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl004
            
            #add-point:AFTER FIELD fabl004 name="construct.a.page1.fabl004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl005
            #add-point:BEFORE FIELD fabl005 name="construct.b.page1.fabl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl005
            
            #add-point:AFTER FIELD fabl005 name="construct.a.page1.fabl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl005
            #add-point:ON ACTION controlp INFIELD fabl005 name="construct.c.page1.fabl005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl006
            #add-point:BEFORE FIELD fabl006 name="construct.b.page1.fabl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl006
            
            #add-point:AFTER FIELD fabl006 name="construct.a.page1.fabl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl006
            #add-point:ON ACTION controlp INFIELD fabl006 name="construct.c.page1.fabl006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl007
            #add-point:BEFORE FIELD fabl007 name="construct.b.page1.fabl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl007
            
            #add-point:AFTER FIELD fabl007 name="construct.a.page1.fabl007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl007
            #add-point:ON ACTION controlp INFIELD fabl007 name="construct.c.page1.fabl007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl008
            #add-point:BEFORE FIELD fabl008 name="construct.b.page1.fabl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl008
            
            #add-point:AFTER FIELD fabl008 name="construct.a.page1.fabl008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl008
            #add-point:ON ACTION controlp INFIELD fabl008 name="construct.c.page1.fabl008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl009
            #add-point:ON ACTION controlp INFIELD fabl009 name="construct.c.page1.fabl009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabl009  #顯示到畫面上
            NEXT FIELD fabl009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl009
            #add-point:BEFORE FIELD fabl009 name="construct.b.page1.fabl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl009
            
            #add-point:AFTER FIELD fabl009 name="construct.a.page1.fabl009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl010
            #add-point:BEFORE FIELD fabl010 name="construct.b.page1.fabl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl010
            
            #add-point:AFTER FIELD fabl010 name="construct.a.page1.fabl010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl010
            #add-point:ON ACTION controlp INFIELD fabl010 name="construct.c.page1.fabl010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl011
            #add-point:BEFORE FIELD fabl011 name="construct.b.page1.fabl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl011
            
            #add-point:AFTER FIELD fabl011 name="construct.a.page1.fabl011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl011
            #add-point:ON ACTION controlp INFIELD fabl011 name="construct.c.page1.fabl011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl012
            #add-point:BEFORE FIELD fabl012 name="construct.b.page1.fabl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl012
            
            #add-point:AFTER FIELD fabl012 name="construct.a.page1.fabl012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl012
            #add-point:ON ACTION controlp INFIELD fabl012 name="construct.c.page1.fabl012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl016
            #add-point:BEFORE FIELD fabl016 name="construct.b.page1.fabl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl016
            
            #add-point:AFTER FIELD fabl016 name="construct.a.page1.fabl016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl016
            #add-point:ON ACTION controlp INFIELD fabl016 name="construct.c.page1.fabl016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl019
            #add-point:BEFORE FIELD fabl019 name="construct.b.page1.fabl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl019
            
            #add-point:AFTER FIELD fabl019 name="construct.a.page1.fabl019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl019
            #add-point:ON ACTION controlp INFIELD fabl019 name="construct.c.page1.fabl019"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabl013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl013
            #add-point:ON ACTION controlp INFIELD fabl013 name="construct.c.page1.fabl013"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str     #161017-00023#1 add lujh
            
            #CALL q_ooef001()                           #呼叫開窗 #161024-00008#3 
            CALL q_ooef001_47()                           #呼叫開窗 #161024-00008#3 
            DISPLAY g_qryparam.return1 TO fabl013  #顯示到畫面上
            NEXT FIELD fabl013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl013
            #add-point:BEFORE FIELD fabl013 name="construct.b.page1.fabl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl013
            
            #add-point:AFTER FIELD fabl013 name="construct.a.page1.fabl013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl014
            #add-point:ON ACTION controlp INFIELD fabl014 name="construct.c.page1.fabl014"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabl014  #顯示到畫面上
            NEXT FIELD fabl014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl014
            #add-point:BEFORE FIELD fabl014 name="construct.b.page1.fabl014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl014
            
            #add-point:AFTER FIELD fabl014 name="construct.a.page1.fabl014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl015
            #add-point:ON ACTION controlp INFIELD fabl015 name="construct.c.page1.fabl015"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161017-00023#1--add--str--lujh
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str
            CALL q_ooef001()  
            #161017-00023#1--add--end--lujh
            #CALL q_ooef001_04()                   #呼叫開窗     #161017-00023#1 mark lujh
            DISPLAY g_qryparam.return1 TO fabl015  #顯示到畫面上
            NEXT FIELD fabl015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl015
            #add-point:BEFORE FIELD fabl015 name="construct.b.page1.fabl015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl015
            
            #add-point:AFTER FIELD fabl015 name="construct.a.page1.fabl015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl101
            #add-point:ON ACTION controlp INFIELD fabl101 name="construct.c.page1.fabl101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabl101  #顯示到畫面上
            NEXT FIELD fabl101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl101
            #add-point:BEFORE FIELD fabl101 name="construct.b.page1.fabl101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl101
            
            #add-point:AFTER FIELD fabl101 name="construct.a.page1.fabl101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl102
            #add-point:BEFORE FIELD fabl102 name="construct.b.page1.fabl102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl102
            
            #add-point:AFTER FIELD fabl102 name="construct.a.page1.fabl102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl102
            #add-point:ON ACTION controlp INFIELD fabl102 name="construct.c.page1.fabl102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl103
            #add-point:BEFORE FIELD fabl103 name="construct.b.page1.fabl103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl103
            
            #add-point:AFTER FIELD fabl103 name="construct.a.page1.fabl103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl103
            #add-point:ON ACTION controlp INFIELD fabl103 name="construct.c.page1.fabl103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl104
            #add-point:BEFORE FIELD fabl104 name="construct.b.page1.fabl104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl104
            
            #add-point:AFTER FIELD fabl104 name="construct.a.page1.fabl104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl104
            #add-point:ON ACTION controlp INFIELD fabl104 name="construct.c.page1.fabl104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl105
            #add-point:BEFORE FIELD fabl105 name="construct.b.page1.fabl105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl105
            
            #add-point:AFTER FIELD fabl105 name="construct.a.page1.fabl105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl105
            #add-point:ON ACTION controlp INFIELD fabl105 name="construct.c.page1.fabl105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl106
            #add-point:BEFORE FIELD fabl106 name="construct.b.page1.fabl106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl106
            
            #add-point:AFTER FIELD fabl106 name="construct.a.page1.fabl106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl106
            #add-point:ON ACTION controlp INFIELD fabl106 name="construct.c.page1.fabl106"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fabl201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl201
            #add-point:ON ACTION controlp INFIELD fabl201 name="construct.c.page1.fabl201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabl201  #顯示到畫面上
            NEXT FIELD fabl201                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl201
            #add-point:BEFORE FIELD fabl201 name="construct.b.page1.fabl201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl201
            
            #add-point:AFTER FIELD fabl201 name="construct.a.page1.fabl201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl202
            #add-point:BEFORE FIELD fabl202 name="construct.b.page1.fabl202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl202
            
            #add-point:AFTER FIELD fabl202 name="construct.a.page1.fabl202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl202
            #add-point:ON ACTION controlp INFIELD fabl202 name="construct.c.page1.fabl202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl203
            #add-point:BEFORE FIELD fabl203 name="construct.b.page1.fabl203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl203
            
            #add-point:AFTER FIELD fabl203 name="construct.a.page1.fabl203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl203
            #add-point:ON ACTION controlp INFIELD fabl203 name="construct.c.page1.fabl203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl204
            #add-point:BEFORE FIELD fabl204 name="construct.b.page1.fabl204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl204
            
            #add-point:AFTER FIELD fabl204 name="construct.a.page1.fabl204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl204
            #add-point:ON ACTION controlp INFIELD fabl204 name="construct.c.page1.fabl204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl205
            #add-point:BEFORE FIELD fabl205 name="construct.b.page1.fabl205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl205
            
            #add-point:AFTER FIELD fabl205 name="construct.a.page1.fabl205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl205
            #add-point:ON ACTION controlp INFIELD fabl205 name="construct.c.page1.fabl205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl206
            #add-point:BEFORE FIELD fabl206 name="construct.b.page1.fabl206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl206
            
            #add-point:AFTER FIELD fabl206 name="construct.a.page1.fabl206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fabl206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl206
            #add-point:ON ACTION controlp INFIELD fabl206 name="construct.c.page1.fabl206"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON fabmseq,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006,fabm004,fabm007, 
          fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014,fabm015,fabm016,fabm101, 
          fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206
           FROM s_detail2[1].fabmseq,s_detail2[1].fabm005,s_detail2[1].fabm001,s_detail2[1].fabm002, 
               s_detail2[1].fabm003,s_detail2[1].fabm020,s_detail2[1].fabm006,s_detail2[1].fabm004,s_detail2[1].fabm007, 
               s_detail2[1].fabm008,s_detail2[1].fabm009,s_detail2[1].fabm010,s_detail2[1].fabm011,s_detail2[1].fabm012, 
               s_detail2[1].fabm013,s_detail2[1].fabm017,s_detail2[1].fabm018,s_detail2[1].fabm014,s_detail2[1].fabm015, 
               s_detail2[1].fabm016,s_detail2[1].fabm101,s_detail2[1].fabm102,s_detail2[1].fabm103,s_detail2[1].fabm104, 
               s_detail2[1].fabm105,s_detail2[1].fabm106,s_detail2[1].fabm201,s_detail2[1].fabm202,s_detail2[1].fabm203, 
               s_detail2[1].fabm204,s_detail2[1].fabm205,s_detail2[1].fabm206
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabmseq
            #add-point:BEFORE FIELD fabmseq name="construct.b.page2.fabmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabmseq
            
            #add-point:AFTER FIELD fabmseq name="construct.a.page2.fabmseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabmseq
            #add-point:ON ACTION controlp INFIELD fabmseq name="construct.c.page2.fabmseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm005
            #add-point:BEFORE FIELD fabm005 name="construct.b.page2.fabm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm005
            
            #add-point:AFTER FIELD fabm005 name="construct.a.page2.fabm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm005
            #add-point:ON ACTION controlp INFIELD fabm005 name="construct.c.page2.fabm005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm001
            #add-point:ON ACTION controlp INFIELD fabm001 name="construct.c.page2.fabm001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah003_5() 
			   #161123-00048#2 add e--- 
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabm001  #顯示到畫面上
            NEXT FIELD fabm001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm001
            #add-point:BEFORE FIELD fabm001 name="construct.b.page2.fabm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm001
            
            #add-point:AFTER FIELD fabm001 name="construct.a.page2.fabm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm002
            #add-point:ON ACTION controlp INFIELD fabm002 name="construct.c.page2.fabm002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah004()  
			   #161123-00048#2 add e---
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabm002  #顯示到畫面上
            NEXT FIELD fabm002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm002
            #add-point:BEFORE FIELD fabm002 name="construct.b.page2.fabm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm002
            
            #add-point:AFTER FIELD fabm002 name="construct.a.page2.fabm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm003
            #add-point:ON ACTION controlp INFIELD fabm003 name="construct.c.page2.fabm003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s--- 
			   CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str 
			   LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","faah032")
			   LET g_qryparam.where = " faah032 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str 
			   CALL q_faah001()  
			   #161123-00048#2 add e--- 
            #CALL q_faah003_3()                           #呼叫開窗 #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabm003  #顯示到畫面上
            NEXT FIELD fabm003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm003
            #add-point:BEFORE FIELD fabm003 name="construct.b.page2.fabm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm003
            
            #add-point:AFTER FIELD fabm003 name="construct.a.page2.fabm003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm020
            #add-point:BEFORE FIELD fabm020 name="construct.b.page2.fabm020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm020
            
            #add-point:AFTER FIELD fabm020 name="construct.a.page2.fabm020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm020
            #add-point:ON ACTION controlp INFIELD fabm020 name="construct.c.page2.fabm020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm006
            #add-point:BEFORE FIELD fabm006 name="construct.b.page2.fabm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm006
            
            #add-point:AFTER FIELD fabm006 name="construct.a.page2.fabm006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm006
            #add-point:ON ACTION controlp INFIELD fabm006 name="construct.c.page2.fabm006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm004
            #add-point:ON ACTION controlp INFIELD fabm004 name="construct.c.page2.fabm004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161123-00048#2 add s---
			   CALL s_axrt300_get_site(g_user,g_site,'2') RETURNING l_ld_str 
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","faalld")			   
            LET g_qryparam.where = l_ld_str  
            CALL q_faal001_1() 
            #161123-00048#2 add e---  
            #CALL q_faac001()                           #呼叫開窗  #161123-00048#2 mark
            DISPLAY g_qryparam.return1 TO fabm004  #顯示到畫面上
            NEXT FIELD fabm004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm004
            #add-point:BEFORE FIELD fabm004 name="construct.b.page2.fabm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm004
            
            #add-point:AFTER FIELD fabm004 name="construct.a.page2.fabm004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm007
            #add-point:BEFORE FIELD fabm007 name="construct.b.page2.fabm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm007
            
            #add-point:AFTER FIELD fabm007 name="construct.a.page2.fabm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm007
            #add-point:ON ACTION controlp INFIELD fabm007 name="construct.c.page2.fabm007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm008
            #add-point:BEFORE FIELD fabm008 name="construct.b.page2.fabm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm008
            
            #add-point:AFTER FIELD fabm008 name="construct.a.page2.fabm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm008
            #add-point:ON ACTION controlp INFIELD fabm008 name="construct.c.page2.fabm008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm009
            #add-point:BEFORE FIELD fabm009 name="construct.b.page2.fabm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm009
            
            #add-point:AFTER FIELD fabm009 name="construct.a.page2.fabm009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm009
            #add-point:ON ACTION controlp INFIELD fabm009 name="construct.c.page2.fabm009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabm010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm010
            #add-point:ON ACTION controlp INFIELD fabm010 name="construct.c.page2.fabm010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabm010  #顯示到畫面上
            NEXT FIELD fabm010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm010
            #add-point:BEFORE FIELD fabm010 name="construct.b.page2.fabm010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm010
            
            #add-point:AFTER FIELD fabm010 name="construct.a.page2.fabm010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm011
            #add-point:BEFORE FIELD fabm011 name="construct.b.page2.fabm011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm011
            
            #add-point:AFTER FIELD fabm011 name="construct.a.page2.fabm011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm011
            #add-point:ON ACTION controlp INFIELD fabm011 name="construct.c.page2.fabm011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm012
            #add-point:BEFORE FIELD fabm012 name="construct.b.page2.fabm012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm012
            
            #add-point:AFTER FIELD fabm012 name="construct.a.page2.fabm012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm012
            #add-point:ON ACTION controlp INFIELD fabm012 name="construct.c.page2.fabm012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm013
            #add-point:BEFORE FIELD fabm013 name="construct.b.page2.fabm013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm013
            
            #add-point:AFTER FIELD fabm013 name="construct.a.page2.fabm013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm013
            #add-point:ON ACTION controlp INFIELD fabm013 name="construct.c.page2.fabm013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm017
            #add-point:BEFORE FIELD fabm017 name="construct.b.page2.fabm017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm017
            
            #add-point:AFTER FIELD fabm017 name="construct.a.page2.fabm017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm017
            #add-point:ON ACTION controlp INFIELD fabm017 name="construct.c.page2.fabm017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm018
            #add-point:BEFORE FIELD fabm018 name="construct.b.page2.fabm018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm018
            
            #add-point:AFTER FIELD fabm018 name="construct.a.page2.fabm018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm018
            #add-point:ON ACTION controlp INFIELD fabm018 name="construct.c.page2.fabm018"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabm014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm014
            #add-point:ON ACTION controlp INFIELD fabm014 name="construct.c.page2.fabm014"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef207 = 'Y' AND ",l_comp_str     #161017-00023#1 add lujh
            #CALL q_ooef001()                           #呼叫開窗        #161024-00008#3 
            CALL q_ooef001_47()                                          #161024-00008#3 
            DISPLAY g_qryparam.return1 TO fabm014  #顯示到畫面上
            NEXT FIELD fabm014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm014
            #add-point:BEFORE FIELD fabm014 name="construct.b.page2.fabm014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm014
            
            #add-point:AFTER FIELD fabm014 name="construct.a.page2.fabm014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm015
            #add-point:ON ACTION controlp INFIELD fabm015 name="construct.c.page2.fabm015"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabm015  #顯示到畫面上
            NEXT FIELD fabm015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm015
            #add-point:BEFORE FIELD fabm015 name="construct.b.page2.fabm015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm015
            
            #add-point:AFTER FIELD fabm015 name="construct.a.page2.fabm015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm016
            #add-point:ON ACTION controlp INFIELD fabm016 name="construct.c.page2.fabm016"
            #此段落由子樣板a08產生
            #開窗c段
            CALL s_axrt300_get_site(g_user,g_site_str,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3'
            #161017-00023#1--add--str--lujh
            LET g_qryparam.where = " ooef204 = 'Y' AND ",l_comp_str
            CALL q_ooef001()  
            #161017-00023#1--add--end--lujh
            #CALL q_ooef001_04()                   #呼叫開窗     #161017-00023#1 mark lujh
            DISPLAY g_qryparam.return1 TO fabm016  #顯示到畫面上
            NEXT FIELD fabm016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm016
            #add-point:BEFORE FIELD fabm016 name="construct.b.page2.fabm016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm016
            
            #add-point:AFTER FIELD fabm016 name="construct.a.page2.fabm016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm101
            #add-point:ON ACTION controlp INFIELD fabm101 name="construct.c.page2.fabm101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabm101  #顯示到畫面上
            NEXT FIELD fabm101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm101
            #add-point:BEFORE FIELD fabm101 name="construct.b.page2.fabm101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm101
            
            #add-point:AFTER FIELD fabm101 name="construct.a.page2.fabm101"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm102
            #add-point:BEFORE FIELD fabm102 name="construct.b.page2.fabm102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm102
            
            #add-point:AFTER FIELD fabm102 name="construct.a.page2.fabm102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm102
            #add-point:ON ACTION controlp INFIELD fabm102 name="construct.c.page2.fabm102"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm103
            #add-point:BEFORE FIELD fabm103 name="construct.b.page2.fabm103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm103
            
            #add-point:AFTER FIELD fabm103 name="construct.a.page2.fabm103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm103
            #add-point:ON ACTION controlp INFIELD fabm103 name="construct.c.page2.fabm103"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm104
            #add-point:BEFORE FIELD fabm104 name="construct.b.page2.fabm104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm104
            
            #add-point:AFTER FIELD fabm104 name="construct.a.page2.fabm104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm104
            #add-point:ON ACTION controlp INFIELD fabm104 name="construct.c.page2.fabm104"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm105
            #add-point:BEFORE FIELD fabm105 name="construct.b.page2.fabm105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm105
            
            #add-point:AFTER FIELD fabm105 name="construct.a.page2.fabm105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm105
            #add-point:ON ACTION controlp INFIELD fabm105 name="construct.c.page2.fabm105"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm106
            #add-point:BEFORE FIELD fabm106 name="construct.b.page2.fabm106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm106
            
            #add-point:AFTER FIELD fabm106 name="construct.a.page2.fabm106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm106
            #add-point:ON ACTION controlp INFIELD fabm106 name="construct.c.page2.fabm106"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.fabm201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm201
            #add-point:ON ACTION controlp INFIELD fabm201 name="construct.c.page2.fabm201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fabm201  #顯示到畫面上
            NEXT FIELD fabm201                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm201
            #add-point:BEFORE FIELD fabm201 name="construct.b.page2.fabm201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm201
            
            #add-point:AFTER FIELD fabm201 name="construct.a.page2.fabm201"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm202
            #add-point:BEFORE FIELD fabm202 name="construct.b.page2.fabm202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm202
            
            #add-point:AFTER FIELD fabm202 name="construct.a.page2.fabm202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm202
            #add-point:ON ACTION controlp INFIELD fabm202 name="construct.c.page2.fabm202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm203
            #add-point:BEFORE FIELD fabm203 name="construct.b.page2.fabm203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm203
            
            #add-point:AFTER FIELD fabm203 name="construct.a.page2.fabm203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm203
            #add-point:ON ACTION controlp INFIELD fabm203 name="construct.c.page2.fabm203"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm204
            #add-point:BEFORE FIELD fabm204 name="construct.b.page2.fabm204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm204
            
            #add-point:AFTER FIELD fabm204 name="construct.a.page2.fabm204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm204
            #add-point:ON ACTION controlp INFIELD fabm204 name="construct.c.page2.fabm204"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm205
            #add-point:BEFORE FIELD fabm205 name="construct.b.page2.fabm205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm205
            
            #add-point:AFTER FIELD fabm205 name="construct.a.page2.fabm205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm205
            #add-point:ON ACTION controlp INFIELD fabm205 name="construct.c.page2.fabm205"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm206
            #add-point:BEFORE FIELD fabm206 name="construct.b.page2.fabm206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm206
            
            #add-point:AFTER FIELD fabm206 name="construct.a.page2.fabm206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fabm206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm206
            #add-point:ON ACTION controlp INFIELD fabm206 name="construct.c.page2.fabm206"
            
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
                  WHEN la_wc[li_idx].tableid = "faba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fabl_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fabm_t" 
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
   #161104-00046#16 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#16 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afat470_query()
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
   CALL g_fabl_d.clear()
   CALL g_fabl2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afat470_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afat470_browser_fill("")
      CALL afat470_fetch("")
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
   CALL afat470_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL afat470_fetch("F") 
      #顯示單身筆數
      CALL afat470_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afat470_fetch(p_flag)
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
   
   LET g_faba_m.fabadocno = g_browser[g_current_idx].b_fabadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
   #遮罩相關處理
   LET g_faba_m_mask_o.* =  g_faba_m.*
   CALL afat470_faba_t_mask()
   LET g_faba_m_mask_n.* =  g_faba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat470_set_act_visible()   
   CALL afat470_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_faba_m.fabastus NOT MATCHES "[NDR]" THEN  
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_faba_m_t.* = g_faba_m.*
   LET g_faba_m_o.* = g_faba_m.*
   
   LET g_data_owner = g_faba_m.fabaownid      
   LET g_data_dept  = g_faba_m.fabaowndp
   
   #重新顯示   
   CALL afat470_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.insert" >}
#+ 資料新增
PRIVATE FUNCTION afat470_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   INITIALIZE g_faba_m_t.* LIKE faba_t.* 
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fabl_d.clear()   
   CALL g_fabl2_d.clear()  
 
 
   INITIALIZE g_faba_m.* TO NULL             #DEFAULT 設定
   
   LET g_fabadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faba_m.fabaownid = g_user
      LET g_faba_m.fabaowndp = g_dept
      LET g_faba_m.fabacrtid = g_user
      LET g_faba_m.fabacrtdp = g_dept 
      LET g_faba_m.fabacrtdt = cl_get_current()
      LET g_faba_m.fabamodid = g_user
      LET g_faba_m.fabamoddt = cl_get_current()
      LET g_faba_m.fabastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_faba_m.faba003 = "18"
      LET g_faba_m.fabastus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL afat470_default()
      LET g_faba_m.faba004 = g_user
      CALL afat470_faba004_desc() 
      DISPLAY BY NAME g_faba_m.faba004_desc 
      
      SELECT ooag003 INTO g_faba_m.faba005
        FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = g_user
         
      CALL afat470_faba005_desc() 
      DISPLAY BY NAME g_faba_m.faba005_desc 
      LET g_faba_m.faba006 = g_today
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_faba_m_t.* = g_faba_m.*
      LET g_faba_m_o.* = g_faba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faba_m.fabastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL afat470_input("a")
      
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
         INITIALIZE g_faba_m.* TO NULL
         INITIALIZE g_fabl_d TO NULL
         INITIALIZE g_fabl2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afat470_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fabl_d.clear()
      #CALL g_fabl2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afat470_set_act_visible()   
   CALL afat470_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabadocno_t = g_faba_m.fabadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabaent = " ||g_enterprise|| " AND",
                      " fabadocno = '", g_faba_m.fabadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat470_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afat470_cl
   
   CALL afat470_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
   
   #遮罩相關處理
   LET g_faba_m_mask_o.* =  g_faba_m.*
   CALL afat470_faba_t_mask()
   LET g_faba_m_mask_n.* =  g_faba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc,g_faba_m.faba001,g_faba_m.faba001_desc,g_faba_m.fabacomp, 
       g_faba_m.fabacomp_desc,g_faba_m.faba004,g_faba_m.faba004_desc,g_faba_m.faba005,g_faba_m.faba005_desc, 
       g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid, 
       g_faba_m.fabaownid_desc,g_faba_m.fabaowndp,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdp_desc,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamodid_desc, 
       g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfid_desc,g_faba_m.fabacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_faba_m.fabaownid      
   LET g_data_dept  = g_faba_m.fabaowndp
   
   #功能已完成,通報訊息中心
   CALL afat470_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.modify" >}
#+ 資料修改
PRIVATE FUNCTION afat470_modify()
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
   LET g_faba_m_t.* = g_faba_m.*
   LET g_faba_m_o.* = g_faba_m.*
   
   IF g_faba_m.fabadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fabadocno_t = g_faba_m.fabadocno
 
   CALL s_transaction_begin()
   
   OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat470_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat470_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
   #檢查是否允許此動作
   IF NOT afat470_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faba_m_mask_o.* =  g_faba_m.*
   CALL afat470_faba_t_mask()
   LET g_faba_m_mask_n.* =  g_faba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   #151231-00005#2--add--str--lujh
   IF NOT cl_null(g_faba_m.fabadocdt) THEN 
      IF NOT s_afa_date_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN 
         CLOSE afat470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#2--add--end--lujh
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL afat470_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_fabadocno_t = g_faba_m.fabadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_faba_m.fabamodid = g_user 
LET g_faba_m.fabamoddt = cl_get_current()
LET g_faba_m.fabamodid_desc = cl_get_username(g_faba_m.fabamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afat470_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE faba_t SET (fabamodid,fabamoddt) = (g_faba_m.fabamodid,g_faba_m.fabamoddt)
          WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_faba_m.* = g_faba_m_t.*
            CALL afat470_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_faba_m.fabadocno != g_faba_m_t.fabadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fabl_t SET fabldocno = g_faba_m.fabadocno
 
          WHERE fablent = g_enterprise AND fabldocno = g_faba_m_t.fabadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fabl_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
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
         
         UPDATE fabm_t
            SET fabmdocno = g_faba_m.fabadocno
 
          WHERE fabment = g_enterprise AND
                fabmdocno = g_fabadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fabm_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
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
   CALL afat470_set_act_visible()   
   CALL afat470_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fabaent = " ||g_enterprise|| " AND",
                      " fabadocno = '", g_faba_m.fabadocno, "' "
 
   #填到對應位置
   CALL afat470_browser_fill("")
 
   CLOSE afat470_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat470_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afat470.input" >}
#+ 資料輸入
PRIVATE FUNCTION afat470_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_ooag004             LIKE ooag_t.ooag004
   DEFINE  l_para_data           LIKE faba_t.fabadocdt
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef017             LIKE ooef_t.ooef017
   DEFINE  l_faab004             LIKE faab_t.faab004 
   DEFINE  l_n2                  LIKE type_t.num5
   DEFINE  l_n3                  LIKE type_t.num5 
   DEFINE  l_fabl001             LIKE fabl_t.fabl001
   DEFINE  l_fabl002             LIKE fabl_t.fabl002 
   DEFINE  l_fabl003             LIKE fabl_t.fabl003
   DEFINE  l_fabm001             LIKE fabm_t.fabm001 
   DEFINE  l_n4                  LIKE type_t.num5
   DEFINE  l_fabm003             LIKE fabm_t.fabm003   
   DEFINE  l_fabl006             LIKE fabl_t.fabl006
   DEFINE  l_fabl011             LIKE fabl_t.fabl011
   DEFINE  l_fabl012             LIKE fabl_t.fabl012
   DEFINE  l_fabm007             LIKE fabm_t.fabm007
   DEFINE  l_fabm012             LIKE fabm_t.fabm012
   DEFINE  l_fabm013             LIKE fabm_t.fabm013
   DEFINE  l_n5                  LIKE type_t.num5
   DEFINE  l_n6                  LIKE type_t.num5
   DEFINE  l_sql                 STRING
   DEFINE l_origin_str           STRING   #組織範圍  20141121
   DEFINE  l_glaa024             LIKE glaa_t.glaa024
   DEFINE  l_glaald              LIKE glaa_t.glaald
   DEFINE  l_glaa003             LIKE glaa_t.glaa003
   DEFINE  l_count1              LIKE type_t.num5
   #151125-00006#1-add-s
   DEFINE  l_ooba002             LIKE ooba_t.ooba002
   DEFINE  l_dfin0031            LIKE type_t.chr1
   DEFINE  l_conf_success        LIKE type_t.num5
   DEFINE la_param               RECORD
          prog                   STRING,
          param                  DYNAMIC ARRAY OF STRING
                                 END RECORD
   DEFINE ls_js                  STRING
   #151125-00006#1-add-e
   DEFINE l_flag                 LIKE type_t.num5       #161104-00046#16 add
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
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc,g_faba_m.faba001,g_faba_m.faba001_desc,g_faba_m.fabacomp, 
       g_faba_m.fabacomp_desc,g_faba_m.faba004,g_faba_m.faba004_desc,g_faba_m.faba005,g_faba_m.faba005_desc, 
       g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid, 
       g_faba_m.fabaownid_desc,g_faba_m.fabaowndp,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdp_desc,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamodid_desc, 
       g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfid_desc,g_faba_m.fabacnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fablseq,fabl001,fabl002,fabl003,fabl017,fabl004,fabl005,fabl006,fabl007, 
       fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014,fabl015,fabl101,fabl102, 
       fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206 FROM fabl_t WHERE  
       fablent=? AND fabldocno=? AND fablseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat470_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fabmseq,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006,fabm004,fabm007, 
       fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014,fabm015,fabm016,fabm101, 
       fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206 FROM  
       fabm_t WHERE fabment=? AND fabmdocno=? AND fabmseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afat470_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afat470_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afat470_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.faba001,g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005, 
       g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afat470.input.head" >}
      #單頭段
      INPUT BY NAME g_faba_m.fabasite,g_faba_m.faba001,g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005, 
          g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat470_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat470_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afat470_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF p_cmd = 'a' THEN
               LET g_faba_m.fabadocdt = g_today
               LET g_faba_m.faba001 = g_user
               CALL afat470_get_faba001_desc()
#               CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING g_sub_success,g_faba_m.fabasite,g_errno
#               CALL afat470_get_fabasite_desc()
            END IF
            #end add-point
            CALL afat470_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabasite
            
            #add-point:AFTER FIELD fabasite name="input.a.fabasite"
#160426-00014#33--mark--str--lujh
#            IF NOT cl_null(g_faba_m.fabasite) THEN
#                IF NOT afat470_fabasite_chk(g_faba_m.fabasite) THEN
#                  LET g_faba_m.fabasite = g_faba_m_t.fabasite
#                  CALL afat470_get_fabasite_desc()
#                  NEXT FIELD CURRENT
#               END IF
#               #人员不为空
#               IF NOT cl_null(g_faba_m.faba001) THEN
#                  IF NOT afat470_fabasite_faba001_chk(g_faba_m.fabasite,g_faba_m.faba001) THEN
#                     LET g_faba_m.fabasite = g_faba_m_t.fabasite
#                     CALL afat470_get_fabasite_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#               #法人不为空
#               IF NOT cl_null(g_faba_m.fabacomp) THEN
#                  IF NOT afat470_fabasite_fabacomp_chk(g_faba_m.fabasite,g_faba_m.fabacomp) THEN
#                     LET g_faba_m.fabasite = g_faba_m_t.fabasite
#                    CALL afat470_get_fabasite_desc()
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF       
#            END IF
#            CALL afat470_get_fabasite_desc()
#160426-00014#33--mark--end--lujh            

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_faba_m.fabasite) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_faba_m.fabasite != g_faba_m_t.fabasite OR g_faba_m_t.fabasite IS NULL )) THEN   #160824-00007#235 by sakura mark
               IF g_faba_m.fabasite != g_faba_m_o.fabasite OR cl_null(g_faba_m_o.fabasite) THEN   #160824-00007#235 by sakura add
                  
                 #CALL s_afa_site_chk(g_faba_m.fabasite,g_faba_m_t.fabasite,g_faba_m.fabacomp,g_glaa.glaald,g_faba_m.fabadocdt)   #160824-00007#235 by sakura mark
                  CALL s_afa_site_chk(g_faba_m.fabasite,g_faba_m_o.fabasite,g_faba_m.fabacomp,g_glaa.glaald,g_faba_m.fabadocdt)   #160824-00007#235 by sakura add
                  RETURNING l_success,g_faba_m.fabacomp,g_glaa.glaald
                  
                  IF l_success = FALSE THEN
                     #160824-00007#235 by sakura mark(S)                  
                     #LET g_faba_m.fabasite = g_faba_m_t.fabasite
                     #LET g_faba_m.fabacomp = g_faba_m_t.fabacomp
                     #160824-00007#235 by sakura mark(E)
                     #160824-00007#235 by sakura add(S)
                     LET g_faba_m.fabasite = g_faba_m_o.fabasite
                     LET g_faba_m.fabacomp = g_faba_m_o.fabacomp
                     #160824-00007#235 by sakura add(E)
                     CALL s_desc_get_department_desc(g_faba_m.fabasite) RETURNING g_faba_m.fabasite_desc
                     DISPLAY BY NAME g_faba_m.fabasite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #人员不为空
                  IF NOT cl_null(g_faba_m.faba001) THEN
                     CALL s_afa_person_chk(g_faba_m.fabasite,g_faba_m.faba001)
                     RETURNING l_success
                     IF l_success = FALSE THEN
                       #LET g_faba_m.fabasite = g_faba_m_t.fabasite   #160824-00007#235 by sakura mark
                        #160824-00007#235 by sakura add(S)
                        LET g_faba_m.fabasite = g_faba_m_o.fabasite
                        LET g_faba_m.fabacomp = g_faba_m_o.fabacomp                        
                        #160824-00007#235 by sakura add(E)
                        CALL s_desc_get_department_desc(g_faba_m.fabasite) RETURNING g_faba_m.fabasite_desc
                        DISPLAY BY NAME g_faba_m.fabasite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_today,'1')
            #160824-00007#235 by sakura mark(S)
            #LET g_faba_m_t.fabasite = g_faba_m.fabasite
            #LET g_faba_m_t.fabacomp = g_faba_m.fabacomp
            #160824-00007#235 by sakura mark(E)
            LET g_faba_m_o.* = g_faba_m.*   #160824-00007#235 by sakura add            
            CALL s_desc_get_department_desc(g_faba_m.fabasite) RETURNING g_faba_m.fabasite_desc
            CALL s_desc_get_department_desc(g_faba_m.fabacomp) RETURNING g_faba_m.fabacomp_desc
            DISPLAY BY NAME g_faba_m.fabasite_desc,g_faba_m.fabacomp_desc
            CALL afat470_get_glaa()
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabasite
            #add-point:BEFORE FIELD fabasite name="input.b.fabasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabasite
            #add-point:ON CHANGE fabasite name="input.g.fabasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba001
            
            #add-point:AFTER FIELD faba001 name="input.a.faba001"
#160426-00014#33--mark--str--lujh
#              IF NOT cl_null(g_faba_m.faba001) THEN
#               #檢查是否存在  員工資料檔中
#               IF NOT ap_chk_isExist(g_faba_m.faba001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? ",'aim-00069',1) THEN
#                  LET g_faba_m.faba001 = g_faba_m_t.faba001
#                   CALL afat470_get_faba001_desc()                   
#                  NEXT FIELD CURRENT
#               END IF   
#               #檢查是否有效               
##               IF NOT ap_chk_isExist(g_faba_m.faba001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'aim-00070',1) THEN
#               IF NOT ap_chk_isExist(g_faba_m.faba001,"SELECT COUNT(*) FROM ooag_t WHERE "||"ooagent = '" ||g_enterprise|| "' AND "||"ooag001 = ? AND ooagstus = 'Y'",'sub-01302','aooi130') THEN #160318-00005#10 mod
#                  LET g_faba_m.faba001 = g_faba_m_t.faba001
#                   CALL afat470_get_faba001_desc()
#                  NEXT FIELD CURRENT
#               END IF      
#                #資產中心不為空的情況下
#               IF NOT cl_null(g_faba_m.fabasite) THEN       
#                  #獲取當前資產中心的組織編號
#                   IF NOT afat470_fabasite_faba001_chk(g_faba_m.fabasite,g_faba_m.faba001) THEN
#                      LET g_faba_m.faba001 = g_faba_m_t.faba001
#                      CALL afat470_get_faba001_desc() 
#                       NEXT FIELD CURRENT
#                   END IF                                
#               END IF                  
#            END IF  
#            
#            CALL afat470_get_faba001_desc() 
#160426-00014#33--mark--end--lujh

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_faba_m.faba001) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faba_m.faba001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  IF NOT cl_null(g_faba_m.fabasite) THEN 
                     CALL s_afa_person_chk(g_faba_m.fabasite,g_faba_m.faba001) RETURNING l_success
                     
                     IF l_success = FALSE THEN
                        LET g_faba_m.faba001 = g_faba_m_t.faba001
                        CALL s_desc_get_person_desc(g_faba_m.faba001) RETURNING g_faba_m.faba001_desc
                        DISPLAY BY NAME g_faba_m.faba001_desc  
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_person_desc(g_faba_m.faba001) RETURNING g_faba_m.faba001_desc
            DISPLAY BY NAME g_faba_m.faba001_desc  
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba001
            #add-point:BEFORE FIELD faba001 name="input.b.faba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faba001
            #add-point:ON CHANGE faba001 name="input.g.faba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabacomp
            
            #add-point:AFTER FIELD fabacomp name="input.a.fabacomp"
#160426-00014#33--mark--str--lujh
#               LET g_faba_m.fabacomp_desc =''
#            DISPLAY BY NAME g_faba_m.fabacomp_desc
#            IF NOT cl_null(g_faba_m.fabacomp) THEN
#               IF NOT afat470_fabacomp_chk() THEN
#                  LET g_faba_m.fabacomp = g_faba_m_t.fabacomp
#                  CALL afat470_fabacomp_desc()
#                  NEXT FIELD CURRENT
#               END IF
#               IF NOT afat470_fabasite_fabacomp_chk(g_faba_m.fabasite,g_faba_m.fabacomp) THEN
#                  LET g_faba_m.fabacomp = g_faba_m_t.fabacomp
#                  CALL afat470_fabacomp_desc()    
#                  NEXT FIELD CURRENT  
#               END IF          
#            END IF
#            CALL afat470_fabacomp_desc()
#160426-00014#33--mark--end--lujh 

#160426-00014#33--add--str--lujh
            IF NOT cl_null(g_faba_m.fabacomp) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_faba_m.fabacomp != g_faba_m_t.fabacomp OR g_faba_m_t.fabacomp IS NULL )) THEN   #160824-00007#235 by sakura mark
               IF g_faba_m.fabacomp != g_faba_m_o.fabacomp OR cl_null(g_faba_m_o.fabacomp) THEN   #160824-00007#235 by sakura add
                  CALL s_afa_comp_chk(g_faba_m.fabasite,g_faba_m.fabacomp)
                  RETURNING l_success,g_glaa.glaald
                  
                  IF l_success = FALSE THEN 
                    #LET g_faba_m.fabacomp = g_faba_m_t.fabacomp   #160824-00007#235 by sakura mark
                     LET g_faba_m.fabacomp = g_faba_m_o.fabacomp   #160824-00007#235 by sakura add
                     CALL s_desc_get_department_desc(g_faba_m.fabacomp) RETURNING g_faba_m.fabacomp_desc
                     DISPLAY BY NAME g_faba_m.fabacomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
           #LET g_faba_m_t.fabacomp = g_faba_m.fabacomp   #160824-00007#235 by sakura mark
            LET g_faba_m_o.* = g_faba_m.*   #160824-00007#235 by sakura add
            CALL s_desc_get_department_desc(g_faba_m.fabacomp) RETURNING g_faba_m.fabacomp_desc
            DISPLAY BY NAME g_faba_m.fabacomp_desc
            CALL afat470_get_glaa()
#160426-00014#33--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabacomp
            #add-point:BEFORE FIELD fabacomp name="input.b.fabacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabacomp
            #add-point:ON CHANGE fabacomp name="input.g.fabacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba004
            
            #add-point:AFTER FIELD faba004 name="input.a.faba004"
            IF NOT cl_null(g_faba_m.faba004) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faba_m.faba004
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#4--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_faba_m.faba004 = g_faba_m_t.faba004
                  CALL afat470_faba004_desc()
                  NEXT FIELD CURRENT
               END IF
               #add by yangxf ----
               SELECT ooag003 INTO g_faba_m.faba005
                 FROM ooag_t
                WHERE ooagent = g_enterprise
                  AND ooag001 = g_faba_m.faba004
               CALL afat470_faba005_desc() 
               #add by yangxf ---
            END IF 
            CALL afat470_faba004_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba004
            #add-point:BEFORE FIELD faba004 name="input.b.faba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faba004
            #add-point:ON CHANGE faba004 name="input.g.faba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba005
            
            #add-point:AFTER FIELD faba005 name="input.a.faba005"
            IF NOT cl_null(g_faba_m.faba005) THEN
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_faba_m.faba005
               LET g_chkparam.arg2 = g_today
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #add by yangxf ---
                  IF NOT cl_null(g_faba_m.faba004) THEN 
                     INITIALIZE g_chkparam.* TO NULL
               
                     #設定g_chkparam.*的參數
                     LET g_chkparam.arg1 = g_faba_m.faba004
                     LET g_chkparam.arg2 = g_faba_m.faba005
                        
                     #呼叫檢查存在並帶值的library
                     IF cl_chk_exist("v_ooag003") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
                     ELSE
                        #檢查失敗時後續處理
                        LET g_faba_m.faba005 = g_faba_m_t.faba005
                        CALL afat470_faba005_desc() 
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
                  #add by yangxf ---
               ELSE
                  #檢查失敗時後續處理
                  LET g_faba_m.faba005 = g_faba_m_t.faba005
                  CALL afat470_faba005_desc()
                  NEXT FIELD CURRENT
               END IF
           
            END IF 
            CALL afat470_faba005_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba005
            #add-point:BEFORE FIELD faba005 name="input.b.faba005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faba005
            #add-point:ON CHANGE faba005 name="input.g.faba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba006
            #add-point:BEFORE FIELD faba006 name="input.b.faba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba006
            
            #add-point:AFTER FIELD faba006 name="input.a.faba006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faba006
            #add-point:ON CHANGE faba006 name="input.g.faba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faba003
            #add-point:BEFORE FIELD faba003 name="input.b.faba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faba003
            
            #add-point:AFTER FIELD faba003 name="input.a.faba003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faba003
            #add-point:ON CHANGE faba003 name="input.g.faba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocno
            #add-point:BEFORE FIELD fabadocno name="input.b.fabadocno"
            IF cl_null(g_faba_m.fabacomp) THEN
               NEXT FIELD fabacomp
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocno
            
            #add-point:AFTER FIELD fabadocno name="input.a.fabadocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_faba_m.fabadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_faba_m.fabadocno != g_fabadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM faba_t WHERE "||"fabaent = '" ||g_enterprise|| "' AND "||"fabadocno = '"||g_faba_m.fabadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_faba_m.fabacomp) THEN
               SELECT glaald,glaa024 INTO l_glaald,l_glaa024 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaacomp = g_faba_m.fabacomp
                  AND glaa014 = 'Y'      

                CALL afat470_get_glaa()   #20150608 add lujh
            END IF
            IF NOT cl_null(g_faba_m.fabadocno) THEN           
               #IF NOT s_aooi200_chk_slip(g_faba_m.fabadocno,l_ooef004,g_faba_m.fabadocno,'afat470') THEN
               IF NOT s_aooi200_fin_chk_slip(l_glaald,l_glaa024,g_faba_m.fabadocno,'afat470') THEN
                  LET g_faba_m.fabadocno = g_faba_m_t.fabadocno
                  NEXT FIELD CURRENT
               END IF
               #161104-00046#16 --s add
               CALL s_control_chk_doc('1',g_faba_m.fabadocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_faba_m.fabadocno = g_faba_m_t.fabadocno
                  NEXT FIELD CURRENT         
               END IF
               CALL s_aooi200_fin_get_slip(g_faba_m.fabadocno) RETURNING g_sub_success,g_ap_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_faba_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_faba_m.fabasite,'2',g_ap_slip,'','',l_glaald)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_faba_m.* FROM s_aooi200def1               
               #161104-00046#16 --e add               
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabadocno
            #add-point:ON CHANGE fabadocno name="input.g.fabadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabadocdt
            #add-point:BEFORE FIELD fabadocdt name="input.b.fabadocdt"
            IF cl_null(g_faba_m.fabacomp) THEN
               NEXT FIELD fabacomp
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabadocdt
            
            #add-point:AFTER FIELD fabadocdt name="input.a.fabadocdt"
            IF NOT cl_null(g_faba_m.fabadocdt) THEN
               CALL cl_get_para(g_enterprise,g_faba_m.fabacomp,'S-FIN-9003') RETURNING l_para_data
               IF NOT cl_null(l_para_data) AND g_faba_m.fabadocdt <= l_para_data THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "afa-00060"
                  LET g_errparam.extend = g_faba_m.fabadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_faba_m.fabadocdt = g_faba_m_t.fabadocdt
                  NEXT FIELD fabadocdt
               END IF
              IF NOT cl_null(g_faba_m.fabacomp) THEN
                 IF NOT s_afat503_sys_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
                    LET g_faba_m.fabadocdt = g_faba_m_t.fabadocdt
                    NEXT FIELD fabadocdt
                 END IF
              END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabadocdt
            #add-point:ON CHANGE fabadocdt name="input.g.fabadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabastus
            #add-point:BEFORE FIELD fabastus name="input.b.fabastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabastus
            
            #add-point:AFTER FIELD fabastus name="input.a.fabastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabastus
            #add-point:ON CHANGE fabastus name="input.g.fabastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fabasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabasite
            #add-point:ON ACTION controlp INFIELD fabasite name="input.c.fabasite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.fabasite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

#            IF NOT cl_null(g_faba_m.faba001) THEN 
#               LET g_qryparam.where = " faab004 IN (SELECT ooag004 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 ='",g_faba_m.faba001,"')"
#            END IF
#           
            LET g_qryparam.where =" ooef207='Y'"    #160426-00014#33 add lujh
            #CALL q_ooef001()                                #呼叫開窗    #161024-00008#3
            CALL q_ooef001_47()                                          #161024-00008#3 

            LET g_faba_m.fabasite = g_qryparam.return1              

            CALL afat470_get_fabasite_desc()
            DISPLAY g_faba_m.fabasite TO fabasite              #
            DISPLAY g_faba_m.fabasite_desc TO fabasite_desc
            
            NEXT FIELD fabasite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.faba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba001
            #add-point:ON ACTION controlp INFIELD faba001 name="input.c.faba001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.faba001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faba_m.faba001 = g_qryparam.return1              

            CALL afat470_get_faba001_desc()
            DISPLAY g_faba_m.faba001 TO faba001              #
            DISPLAY g_faba_m.faba001_desc TO faba001_desc

            NEXT FIELD faba001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fabacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabacomp
            #add-point:ON ACTION controlp INFIELD fabacomp name="input.c.fabacomp"
            #應用 a07 樣板自動產生(Version:1)   
            #開窗i段
            #20141121 --add--str-- by chenying
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.fabacomp             #給予default值
            CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_faba_m.fabadocdt,'1')
            CALL s_fin_account_center_comp_str()RETURNING l_origin_str
            CALL afat470_change_to_sql(l_origin_str)RETURNING l_origin_str
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN(",l_origin_str CLIPPED,") "
            #給予arg

            #CALL q_ooef001()                                #呼叫開窗 #161024-00008#3 
            CALL q_ooef001_2()                               #呼叫開窗 #161024-00008#3 

            LET g_faba_m.fabacomp = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL afat470_fabacomp_desc()
            DISPLAY g_faba_m.fabacomp TO fabacomp              #顯示到畫面上

            NEXT FIELD fabacomp     
            #20141121 --add--end-- by chenying

            #END add-point
 
 
         #Ctrlp:input.c.faba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba004
            #add-point:ON ACTION controlp INFIELD faba004 name="input.c.faba004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.faba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooag001()                                #呼叫開窗

            LET g_faba_m.faba004 = g_qryparam.return1              

            DISPLAY g_faba_m.faba004 TO faba004              #
            CALL afat470_faba004_desc()
            NEXT FIELD faba004                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.faba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba005
            #add-point:ON ACTION controlp INFIELD faba005 name="input.c.faba005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_faba_m.faba005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_faba_m.faba005 = g_qryparam.return1              

            DISPLAY g_faba_m.faba005 TO faba005              #
            CALL afat470_faba005_desc()
            NEXT FIELD faba005 
            #END add-point
 
 
         #Ctrlp:input.c.faba006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba006
            #add-point:ON ACTION controlp INFIELD faba006 name="input.c.faba006"
            
            #END add-point
 
 
         #Ctrlp:input.c.faba003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faba003
            #add-point:ON ACTION controlp INFIELD faba003 name="input.c.faba003"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocno
            #add-point:ON ACTION controlp INFIELD fabadocno name="input.c.fabadocno"
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_faba_m.fabadocno             #給予default值
            
            IF NOT cl_null(g_faba_m.fabacomp) THEN
               SELECT glaa024 INTO l_glaa024 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaacomp = g_faba_m.fabacomp
                  AND glaa014 = 'Y'              
            END IF

            LET g_qryparam.arg1 = l_glaa024
            #LET g_qryparam.arg2 = "afat470"     #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add
            #161104-00046#16 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#16 --e add
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_faba_m.fabadocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_faba_m.fabadocno TO fabadocno              #顯示到畫面上

            NEXT FIELD fabadocno                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.fabadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabadocdt
            #add-point:ON ACTION controlp INFIELD fabadocdt name="input.c.fabadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.fabastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabastus
            #add-point:ON ACTION controlp INFIELD fabastus name="input.c.fabastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_faba_m.fabadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            IF NOT cl_null(g_faba_m.fabadocdt) THEN
               CALL cl_get_para(g_enterprise,g_faba_m.fabacomp,'S-FIN-9003') RETURNING l_para_data
               IF NOT cl_null(l_para_data) AND g_faba_m.fabadocdt <= l_para_data THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "afa-00060"
                  LET g_errparam.extend = g_faba_m.fabadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fabadocdt
               END IF
               IF NOT cl_null(g_faba_m.fabacomp) THEN
                 IF NOT s_afat503_sys_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
                    LET g_faba_m.fabadocdt = g_faba_m_t.fabadocdt
                    NEXT FIELD fabadocdt
                 END IF
              END IF
            END IF
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"

              # CALL s_aooi200_gen_docno(l_ooag004,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_prog)
              #    RETURNING l_success,g_faba_m.fabadocno
               SELECT glaald,glaa024,glaa003 INTO l_glaald,l_glaa024,l_glaa003 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaacomp = g_faba_m.fabacomp
                  AND glaa014 = 'Y' 
               CALL s_aooi200_fin_gen_docno(l_glaald,l_glaa024,l_glaa003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_prog)
                   RETURNING l_success,g_faba_m.fabadocno
                  IF l_success  = 0  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00003'
                     LET g_errparam.extend = g_faba_m.fabadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD fabadocno
                  END IF
                  DISPLAY BY NAME g_faba_m.fabadocno
               #end add-point
               
               INSERT INTO faba_t (fabaent,fabasite,faba001,fabacomp,faba004,faba005,faba006,faba003, 
                   fabadocno,fabadocdt,fabastus,fabaownid,fabaowndp,fabacrtid,fabacrtdp,fabacrtdt,fabamodid, 
                   fabamoddt,fabacnfid,fabacnfdt)
               VALUES (g_enterprise,g_faba_m.fabasite,g_faba_m.faba001,g_faba_m.fabacomp,g_faba_m.faba004, 
                   g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt, 
                   g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid,g_faba_m.fabacrtdp, 
                   g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_faba_m:",SQLERRMESSAGE 
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
                  CALL afat470_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afat470_b_fill()
                  CALL afat470_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               LET p_cmd = 'u'
               CALL afat470_set_entry(p_cmd)
               CALL afat470_set_no_entry(p_cmd)
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afat470_faba_t_mask_restore('restore_mask_o')
               
               UPDATE faba_t SET (fabasite,faba001,fabacomp,faba004,faba005,faba006,faba003,fabadocno, 
                   fabadocdt,fabastus,fabaownid,fabaowndp,fabacrtid,fabacrtdp,fabacrtdt,fabamodid,fabamoddt, 
                   fabacnfid,fabacnfdt) = (g_faba_m.fabasite,g_faba_m.faba001,g_faba_m.fabacomp,g_faba_m.faba004, 
                   g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt, 
                   g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid,g_faba_m.fabacrtdp, 
                   g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfdt) 
 
                WHERE fabaent = g_enterprise AND fabadocno = g_fabadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "faba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afat470_faba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_faba_m_t)
               LET g_log2 = util.JSON.stringify(g_faba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fabadocno_t = g_faba_m.fabadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afat470.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fabl_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabl_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat470_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fabl_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL afat470_set_comp()
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
            OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat470_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat470_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabl_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabl_d[l_ac].fablseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fabl_d_t.* = g_fabl_d[l_ac].*  #BACKUP
               LET g_fabl_d_o.* = g_fabl_d[l_ac].*  #BACKUP
               CALL afat470_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afat470_set_no_entry_b(l_cmd)
               IF NOT afat470_lock_b("fabl_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat470_bcl INTO g_fabl_d[l_ac].fablseq,g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002, 
                      g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl017,g_fabl_d[l_ac].fabl004,g_fabl_d[l_ac].fabl005, 
                      g_fabl_d[l_ac].fabl006,g_fabl_d[l_ac].fabl007,g_fabl_d[l_ac].fabl008,g_fabl_d[l_ac].fabl009, 
                      g_fabl_d[l_ac].fabl010,g_fabl_d[l_ac].fabl011,g_fabl_d[l_ac].fabl012,g_fabl_d[l_ac].fabl016, 
                      g_fabl_d[l_ac].fabl019,g_fabl_d[l_ac].fabl013,g_fabl_d[l_ac].fabl014,g_fabl_d[l_ac].fabl015, 
                      g_fabl_d[l_ac].fabl101,g_fabl_d[l_ac].fabl102,g_fabl_d[l_ac].fabl103,g_fabl_d[l_ac].fabl104, 
                      g_fabl_d[l_ac].fabl105,g_fabl_d[l_ac].fabl106,g_fabl_d[l_ac].fabl201,g_fabl_d[l_ac].fabl202, 
                      g_fabl_d[l_ac].fabl203,g_fabl_d[l_ac].fabl204,g_fabl_d[l_ac].fabl205,g_fabl_d[l_ac].fabl206 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fabl_d_t.fablseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabl_d_mask_o[l_ac].* =  g_fabl_d[l_ac].*
                  CALL afat470_fabl_t_mask()
                  LET g_fabl_d_mask_n[l_ac].* =  g_fabl_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat470_show()
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
            INITIALIZE g_fabl_d[l_ac].* TO NULL 
            INITIALIZE g_fabl_d_t.* TO NULL 
            INITIALIZE g_fabl_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fabl_d[l_ac].fabl017 = "1"
      LET g_fabl_d[l_ac].fabl006 = "0"
      LET g_fabl_d[l_ac].fabl008 = "1"
      LET g_fabl_d[l_ac].fabl011 = "0"
      LET g_fabl_d[l_ac].fabl012 = "0"
      LET g_fabl_d[l_ac].fabl016 = "0"
      LET g_fabl_d[l_ac].fabl019 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fabl_d_t.* = g_fabl_d[l_ac].*     #新輸入資料
            LET g_fabl_d_o.* = g_fabl_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat470_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afat470_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabl_d[li_reproduce_target].* = g_fabl_d[li_reproduce].*
 
               LET g_fabl_d[li_reproduce_target].fablseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF g_fabl_d[l_ac].fablseq IS NULL OR g_fabl_d[l_ac].fablseq = 0 THEN
               SELECT max(fablseq)+1 INTO g_fabl_d[l_ac].fablseq
                 FROM fabl_t
                WHERE fablent = g_enterprise   
                  AND fabldocno = g_faba_m.fabadocno
               IF cl_null(g_fabl_d[l_ac].fablseq) THEN
                  LET g_fabl_d[l_ac].fablseq = 1
               END IF
            END IF
            
            #20150608--add--str--lujh
            IF cl_null(g_fabl_d[l_ac].fabl002) THEN 
               LET g_fabl_d[l_ac].fabl002=' ' 
            END IF
            #20150608--add--end--lujh
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
            SELECT COUNT(1) INTO l_count FROM fabl_t 
             WHERE fablent = g_enterprise AND fabldocno = g_faba_m.fabadocno
 
               AND fablseq = g_fabl_d[l_ac].fablseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faba_m.fabadocno
               LET gs_keys[2] = g_fabl_d[g_detail_idx].fablseq
               CALL afat470_insert_b('fabl_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_fabl_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat470_b_fill()
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
               LET gs_keys[01] = g_faba_m.fabadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_fabl_d_t.fablseq
 
            
               #刪除同層單身
               IF NOT afat470_delete_b('fabl_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat470_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat470_key_delete_b(gs_keys,'fabl_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat470_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afat470_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fabl_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabl_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fablseq
            #add-point:BEFORE FIELD fablseq name="input.b.page1.fablseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fablseq
            
            #add-point:AFTER FIELD fablseq name="input.a.page1.fablseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faba_m.fabadocno IS NOT NULL AND g_fabl_d[g_detail_idx].fablseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faba_m.fabadocno != g_fabadocno_t OR g_fabl_d[g_detail_idx].fablseq != g_fabl_d_t.fablseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabl_t WHERE "||"fablent = '" ||g_enterprise|| "' AND "||"fabldocno = '"||g_faba_m.fabadocno ||"' AND "|| "fablseq = '"||g_fabl_d[g_detail_idx].fablseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fablseq
            #add-point:ON CHANGE fablseq name="input.g.page1.fablseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl001
            
            #add-point:AFTER FIELD fabl001 name="input.a.page1.fabl001"
            IF NOT cl_null(g_fabl_d[l_ac].fabl001) THEN 
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=g_fabl_d[l_ac].fabl001
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faah003") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
                 
                     ############################################### mark by huangtao
                     #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabl_d[l_ac].fabl001 != g_fabl_d_t.fabl001)) THEN
                     #   LET g_fabl_d[l_ac].fabl003 = ' '
                     #   CALL afat470_faid_def()
                     #   DISPLAY g_fabl_d[l_ac].fabl003 TO s_detail1[l_ac].fabl003
                     #END IF
                     ################################################
                    # IF  NOT cl_null(g_fabl_d[l_ac].fabl003) THEN
      #             #  IF g_fabh_d[l_ac].fabh002 IS NOT NULL AND NOT cl_null(g_fabh_d[l_ac].fabh000) THEN
                    #    INITIALIZE g_chkparam.* TO NULL
                    #    #設定g_chkparam.*的參數
                    #    LET g_chkparam.arg1 =g_fabl_d[l_ac].fabl001
                    #    LET g_chkparam.arg2 = g_fabl_d[l_ac].fabl002
                    #    LET g_chkparam.arg3 = g_fabl_d[l_ac].fabl003
                    #    #呼叫檢查存在並帶值的library
                    #    IF NOT cl_chk_exist("v_faah003_3") THEN
                    #       #檢查失敗時後續處理
                    #       LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001
                    #       LET g_fabl_d[l_ac].fabl002=g_fabl_d_t.fabl002
                    #       LET g_fabl_d[l_ac].fabl003=g_fabl_d_t.fabl003
                    #       NEXT FIELD CURRENT
                    #    END IF
                    # END IF
                     IF NOT s_afat503_fixed_chk(g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003,"afat470",'',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
                        LET g_fabl_d[l_ac].fabl001 = g_fabl_d_t.fabl001
                        NEXT FIELD CURRENT 
                     END IF
                     
                     #20150608--add--str--lujh
                     IF NOT cl_null(g_fabl_d[l_ac].fabl001) AND g_fabl_d[l_ac].fabl002 IS NOT NULL AND NOT cl_null(g_fabl_d[l_ac].fabl003) THEN 
                        CALL s_afa_faan_chk(g_faba_m.fabadocdt,g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_glaa.glaald) 
                        RETURNING l_success
                        
                        IF l_success = FALSE THEN 
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = ''
                           LET g_errparam.code   = 'afa-01026'
                           LET g_errparam.popup  = TRUE 
                           CALL cl_err()
                           LET g_fabl_d[l_ac].fabl001 = g_fabl_d_t.fabl001
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                     #20150608--add--end--lujh
                     
                     CALL afat470_faid_chk() RETURNING l_success
                     IF NOT l_success THEN
                        NEXT FIELD CURRENT
                     END IF
                     ###################
                    #CALL cl_showmsg_init()       #150731-00004#1 20150826 mark
                     CALL cl_err_collect_init()   #150731-00004#1 20150826 add
                     CALL s_afat503_conf_ins_tab_chk(g_faba_m.fabadocno,'',g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003) RETURNING l_success
                     IF l_success = FALSE THEN
                        #CALL cl_err_showmsg()        #150731-00004#1 20150826 mark
                        CALL cl_err_collect_show()    #150731-00004#1 20150826 add
                        NEXT FIELD CURRENT 
                     END IF
                     #####################
                     CALL afat470_get_faah()
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001           
                  NEXT FIELD CURRENT
               END IF
              #IF cl_null(g_fabl_d[l_ac].fabl002) THEN
              #   LET g_fabl_d[l_ac].fabl002 = ' '
              #END IF
              ##若不是開窗，直接輸入欄位時，需帶出當前停用單中未使用的資料
              #LET l_n6 = 1
              #LET l_n5 = 0
              #SELECT COUNT(*) INTO l_n5 FROM faah_t    #符合條件的筆數
              # WHERE faahent = g_enterprise
              #   AND faah004 = g_fabl_d[l_ac].fabl002
              #LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
              #            "  WHERE faahent = '",g_enterprise,"'",
              #            "    AND faah003 = '",g_fabl_d[l_ac].fabl001,"'",
              #            "    AND faah004 = '",g_fabl_d[l_ac].fabl002,"'",
              #            "    AND faah015 <> '0' AND faah015 <> '5'",
              #            "    AND faah015 <> '6' AND faah015 <> '10'",
              #            "    AND faahstus = 'Y' ",
              #            "  ORDER BY faah001,faah003,faah004 "
              #PREPARE afat470_pb5_1 FROM l_sql
              #DECLARE afat470_cs5_1 CURSOR FOR afat470_pb5_1
              #FOREACH afat470_cs5_1 INTO l_fabl003,l_fabl001,l_fabl002
		        #
              #   IF SQLCA.sqlcode THEN
              #      INITIALIZE g_errparam TO NULL
              #      LET g_errparam.code = SQLCA.sqlcode
              #      LET g_errparam.extend = "afat470_cs5"
              #      LET g_errparam.popup = TRUE
              #      CALL cl_err()
              #   
              #      EXIT FOREACH
              #   END IF
		        #   
              #   LET l_n4 = 0
              #   SELECT COUNT(*) INTO l_n4 FROM fabl_t
              #    WHERE fablent = g_enterprise
              #      AND fabldocno = g_faba_m.fabadocno
              #      AND fabl001 = l_fabl001
              #      AND fabl002 = l_fabl002
              #      AND fabl003 = l_fabl003
              #   IF l_n4 >=1 THEN
              #      LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
              #      CONTINUE FOREACH
              #   ELSE
              #      LET g_fabl_d[l_ac].fabl001 = l_fabl001
              #      LET g_fabl_d[l_ac].fabl002 = l_fabl002
              #      LET g_fabl_d[l_ac].fabl003 = l_fabl003
              #      EXIT FOREACH
              #   END IF
              #END FOREACH 
            END IF 
                  

           



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl001
            #add-point:BEFORE FIELD fabl001 name="input.b.page1.fabl001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl001
            #add-point:ON CHANGE fabl001 name="input.g.page1.fabl001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl002
            
            #add-point:AFTER FIELD fabl002 name="input.a.page1.fabl002"
            IF  cl_null(g_fabl_d[l_ac].fabl002) THEN 
               LET g_fabl_d[l_ac].fabl002=' ' 
            END IF
           ##########################################modify by huangtao
           #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_fabl_d[l_ac].fabl002 != g_fabl_d_t.fabl002)) THEN
           #   LET g_fabl_d[l_ac].fabl003 = ''
           #   CALL afat470_faid_def()
           #   DISPLAY g_fabl_d[l_ac].fabl003 TO s_detail1[l_ac].fabl003
           #END IF
             ######################copy from afat502###############
           # IF NOT cl_null(g_fabl_d[l_ac].fabl001) THEN
           #
           #      #若不是開窗，直接輸入欄位時，需帶出當前停用單中未使用的資料
           #      LET l_n6 = 1
           #      LET l_n5 = 0
		     #     
           #      SELECT COUNT(*) INTO l_n5 FROM faah_t    #符合條件的筆數
           #       WHERE faahent = g_enterprise
           #         AND faah004 = g_fabl_d[l_ac].fabl002
           #      LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
           #                  "  WHERE faahent = '",g_enterprise,"'",
           #                  "    AND faah003 = '",g_fabl_d[l_ac].fabl001,"'",
           #                  "    AND faah004 = '",g_fabl_d[l_ac].fabl002,"'",
           #                  "    AND faah015 <> '0' AND faah015 <> '5'",
           #                  "    AND faah015 <> '6' AND faah015 <> '10'",
           #                  "    AND faahstus = 'Y' ",
           #                  "  ORDER BY faah001,faah003,faah004 "
           #      PREPARE afat470_pb5 FROM l_sql
           #      DECLARE afat470_cs5 CURSOR FOR afat470_pb5
           #      FOREACH afat470_cs5 INTO l_fabl003,l_fabl001,l_fabl002
		     #     
           #        IF SQLCA.sqlcode THEN
           #           INITIALIZE g_errparam TO NULL
           #           LET g_errparam.code = SQLCA.sqlcode
           #           LET g_errparam.extend = "afat470_cs5"
           #           LET g_errparam.popup = TRUE
           #           CALL cl_err()
           #    
           #           EXIT FOREACH
           #        END IF
		     #     
           #        LET l_n4 = 0
           #        SELECT COUNT(*) INTO l_n4 FROM fabl_t
           #         WHERE fablent = g_enterprise
           #           AND fabldocno = g_faba_m.fabadocno
           #           AND fabl001 = l_fabl001
           #           AND fabl002 = l_fabl002
           #           AND fabl003 = l_fabl003
           #        IF l_n4 >=1 THEN
           #           LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
           #           CONTINUE FOREACH
           #        ELSE
           #           LET g_fabl_d[l_ac].fabl001 = l_fabl001
           #           LET g_fabl_d[l_ac].fabl002 = l_fabl002
           #           LET g_fabl_d[l_ac].fabl003 = l_fabl003
           #           EXIT FOREACH
           #        END IF
           #    END FOREACH 
           # END IF
            ##########################copy from afat502#############
           ##########################################
           # IF g_fabl_d[l_ac].fabl001 IS NOT NULL AND NOT cl_null(g_fabl_d[l_ac].fabl003) THEN
           #    INITIALIZE g_chkparam.* TO NULL
           #    #設定g_chkparam.*的參數
           #    LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl001
           #    LET g_chkparam.arg2 = g_fabl_d[l_ac].fabl002
           #    LET g_chkparam.arg3 = g_fabl_d[l_ac].fabl003
           #    #呼叫檢查存在並帶值的library
           #    IF NOT cl_chk_exist("v_faah003_3") THEN
           #       #檢查失敗時後續處理
           #       LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001
           #       LET g_fabl_d[l_ac].fabl002=g_fabl_d_t.fabl002
           #       LET g_fabl_d[l_ac].fabl003=g_fabl_d_t.fabl003
           #       NEXT FIELD CURRENT
           #    END IF
           # END IF
           IF NOT s_afat503_fixed_chk(g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003,"afat470",'',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
              LET g_fabl_d[l_ac].fabl002 = g_fabl_d_t.fabl002
              NEXT FIELD CURRENT 
           END IF
           
           #20150608--add--str--lujh
           IF NOT cl_null(g_fabl_d[l_ac].fabl001) AND g_fabl_d[l_ac].fabl002 IS NOT NULL AND NOT cl_null(g_fabl_d[l_ac].fabl003) THEN 
              CALL s_afa_faan_chk(g_faba_m.fabadocdt,g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_glaa.glaald) 
              RETURNING l_success
              
              IF l_success = FALSE THEN 
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = ''
                 LET g_errparam.code   = 'afa-01026'
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 LET g_fabl_d[l_ac].fabl002 = g_fabl_d_t.fabl002
                 NEXT FIELD CURRENT
              END IF
           END IF
           #20150608--add--end--lujh
           
           CALL afat470_faid_chk() RETURNING l_success
           IF NOT l_success THEN
              NEXT FIELD CURRENT
           END IF
            ###################
           #CALL cl_showmsg_init()       #150731-00004#1 20150826 mark
           CALL cl_err_collect_init()   #150731-00004#1 20150826 add
           CALL s_afat503_conf_ins_tab_chk(g_faba_m.fabadocno,'',g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003) RETURNING l_success
           IF l_success = FALSE THEN
              #CALL cl_err_showmsg()        #150731-00004#1 20150826 mark
              CALL cl_err_collect_show()    #150731-00004#1 20150826 add
              NEXT FIELD CURRENT 
           END IF
           #####################
           CALL afat470_get_faah()
                    


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl002
            #add-point:BEFORE FIELD fabl002 name="input.b.page1.fabl002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl002
            #add-point:ON CHANGE fabl002 name="input.g.page1.fabl002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl003
            
            #add-point:AFTER FIELD fabl003 name="input.a.page1.fabl003"
           #########################copy from afat502 by huangtao ###########
           #IF (l_cmd = 'a' AND NOT cl_null(g_fabl_d[l_ac].fabl003) AND NOT cl_null(g_fabl_d[l_ac].fabl001)) 
           #    OR (l_cmd = 'u' AND (g_fabl_d[l_ac].fabl003 != g_fabl_d_t.fabl003)) THEN
           #      #若不是開窗，直接輸入欄位時，需帶出當前停用單中未使用的資料
           #      LET l_n6 = 1
           #      LET l_n5 = 0
		     #     
           #      SELECT COUNT(*) INTO l_n5 FROM faah_t    #符合條件的筆數
           #       WHERE faahent = g_enterprise
           #         AND faah001 = g_fabl_d[l_ac].fabl003
           #      LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
           #                  "  WHERE faahent = '",g_enterprise,"'",
           #                  "    AND faah001 = '",g_fabl_d[l_ac].fabl003,"'",
           #                  "    AND faah003 = '",g_fabl_d[l_ac].fabl001,"'",
           #                  "    AND faah015 <> '0' AND faah015 <> '5'",
           #                  "    AND faah015 <> '6' AND faah015 <> '10'",
           #                  "    AND faahstus = 'Y' ",
           #                  "  ORDER BY faah001,faah003,faah004 "
           #      PREPARE afat470_pb6 FROM l_sql
           #      DECLARE afat470_cs6 CURSOR FOR afat470_pb6
           #      FOREACH afat470_cs6 INTO l_fabl003,l_fabl001,l_fabl002
		     #     
           #        IF SQLCA.sqlcode THEN
           #           INITIALIZE g_errparam TO NULL
           #           LET g_errparam.code = SQLCA.sqlcode
           #           LET g_errparam.extend = "afat470_cs6"
           #           LET g_errparam.popup = TRUE
           #           CALL cl_err()
           #    
           #           EXIT FOREACH
           #        END IF
		     #     
           #        LET l_n4 = 0
           #        SELECT COUNT(*) INTO l_n4 FROM fabl_t
           #         WHERE fablent = g_enterprise
           #           AND fabldocno = g_faba_m.fabadocno
           #           AND fabl001 = l_fabl001
           #           AND fabl002 = l_fabl002
           #           AND fabl003 = l_fabl003
           #        IF l_n4 >=1 THEN
           #           LET l_n6 = l_n6 + 1  #存在重複資料時，繼續下一筆
           #           CONTINUE FOREACH
           #        ELSE
           #           LET g_fabl_d[l_ac].fabl003 = l_fabl003
           #           LET g_fabl_d[l_ac].fabl001 = l_fabl001
           #           LET g_fabl_d[l_ac].fabl002 = l_fabl002
           #           EXIT FOREACH
           #        END IF
           #    END FOREACH 
           # END IF
            #####################copy from afat502 by huangtao ########### 
           
           
          #IF g_fabl_d[l_ac].fabl002 IS NOT NULL AND NOT cl_null(g_fabl_d[l_ac].fabl003) AND NOT cl_null(g_fabl_d[l_ac].fabl001) THEN
          #    INITIALIZE g_chkparam.* TO NULL
          #    #設定g_chkparam.*的參數
          #    LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl001
          #    LET g_chkparam.arg2 = g_fabl_d[l_ac].fabl002
          #    LET g_chkparam.arg3 = g_fabl_d[l_ac].fabl003
          #    #呼叫檢查存在並帶值的library
          #    IF NOT cl_chk_exist("v_faah003_3") THEN
          #       #檢查失敗時後續處理
          #       LET g_fabl_d[l_ac].fabl003 = g_fabl_d_t.fabl003
          #       NEXT FIELD CURRENT
          #    END IF
          # END IF
               IF NOT s_afat503_fixed_chk(g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003,"afat470",'',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
                 LET g_fabl_d[l_ac].fabl003 = g_fabl_d_t.fabl003
                 NEXT FIELD CURRENT 
               END IF
               
               #20150608--add--str--lujh
               IF NOT cl_null(g_fabl_d[l_ac].fabl001) AND g_fabl_d[l_ac].fabl002 IS NOT NULL AND NOT cl_null(g_fabl_d[l_ac].fabl003) THEN 
                  CALL s_afa_faan_chk(g_faba_m.fabadocdt,g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_glaa.glaald) 
                  RETURNING l_success
                  
                  IF l_success = FALSE THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'afa-01026'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_fabl_d[l_ac].fabl003 = g_fabl_d_t.fabl003
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #20150608--add--end--lujh
            
               CALL afat470_faid_chk() RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
               ###################
               #CALL cl_showmsg_init()       #150731-00004#1 20150826 mark
               CALL cl_err_collect_init()   #150731-00004#1 20150826 add
               CALL s_afat503_conf_ins_tab_chk(g_faba_m.fabadocno,'',g_fabl_d[l_ac].fabl001,g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003) RETURNING l_success
               IF l_success = FALSE THEN
                  #CALL cl_err_showmsg()        #150731-00004#1 20150826 mark
              CALL cl_err_collect_show()    #150731-00004#1 20150826 add
                  NEXT FIELD CURRENT 
               END IF
              #####################
               CALL afat470_get_faah()
          
           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl003
            #add-point:BEFORE FIELD fabl003 name="input.b.page1.fabl003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl003
            #add-point:ON CHANGE fabl003 name="input.g.page1.fabl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah012
            #add-point:BEFORE FIELD faah012 name="input.b.page1.faah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah012
            
            #add-point:AFTER FIELD faah012 name="input.a.page1.faah012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah012
            #add-point:ON CHANGE faah012 name="input.g.page1.faah012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD faah013
            #add-point:BEFORE FIELD faah013 name="input.b.page1.faah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD faah013
            
            #add-point:AFTER FIELD faah013 name="input.a.page1.faah013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE faah013
            #add-point:ON CHANGE faah013 name="input.g.page1.faah013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl017
            #add-point:BEFORE FIELD fabl017 name="input.b.page1.fabl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl017
            
            #add-point:AFTER FIELD fabl017 name="input.a.page1.fabl017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl017
            #add-point:ON CHANGE fabl017 name="input.g.page1.fabl017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl004
            
            #add-point:AFTER FIELD fabl004 name="input.a.page1.fabl004"
#            IF NOT cl_null(g_fabl_d[l_ac].fabl004) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl004
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_faac001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_fabl_d[l_ac].fabl004
#            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_fabl_d[l_ac].fabl004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_fabl_d[l_ac].fabl004_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl004
            #add-point:BEFORE FIELD fabl004 name="input.b.page1.fabl004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl004
            #add-point:ON CHANGE fabl004 name="input.g.page1.fabl004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl005
            #add-point:BEFORE FIELD fabl005 name="input.b.page1.fabl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl005
            
            #add-point:AFTER FIELD fabl005 name="input.a.page1.fabl005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl005
            #add-point:ON CHANGE fabl005 name="input.g.page1.fabl005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl006
            #add-point:BEFORE FIELD fabl006 name="input.b.page1.fabl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl006
            
            #add-point:AFTER FIELD fabl006 name="input.a.page1.fabl006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl006
            #add-point:ON CHANGE fabl006 name="input.g.page1.fabl006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl007
            #add-point:BEFORE FIELD fabl007 name="input.b.page1.fabl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl007
            
            #add-point:AFTER FIELD fabl007 name="input.a.page1.fabl007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl007
            #add-point:ON CHANGE fabl007 name="input.g.page1.fabl007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl008
            #add-point:BEFORE FIELD fabl008 name="input.b.page1.fabl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl008
            
            #add-point:AFTER FIELD fabl008 name="input.a.page1.fabl008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl008
            #add-point:ON CHANGE fabl008 name="input.g.page1.fabl008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl009
            #add-point:BEFORE FIELD fabl009 name="input.b.page1.fabl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl009
            
            #add-point:AFTER FIELD fabl009 name="input.a.page1.fabl009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl009
            #add-point:ON CHANGE fabl009 name="input.g.page1.fabl009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl010
            #add-point:BEFORE FIELD fabl010 name="input.b.page1.fabl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl010
            
            #add-point:AFTER FIELD fabl010 name="input.a.page1.fabl010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl010
            #add-point:ON CHANGE fabl010 name="input.g.page1.fabl010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl011
            #add-point:BEFORE FIELD fabl011 name="input.b.page1.fabl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl011
            
            #add-point:AFTER FIELD fabl011 name="input.a.page1.fabl011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl011
            #add-point:ON CHANGE fabl011 name="input.g.page1.fabl011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl012
            #add-point:BEFORE FIELD fabl012 name="input.b.page1.fabl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl012
            
            #add-point:AFTER FIELD fabl012 name="input.a.page1.fabl012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl012
            #add-point:ON CHANGE fabl012 name="input.g.page1.fabl012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl016
            #add-point:BEFORE FIELD fabl016 name="input.b.page1.fabl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl016
            
            #add-point:AFTER FIELD fabl016 name="input.a.page1.fabl016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl016
            #add-point:ON CHANGE fabl016 name="input.g.page1.fabl016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl019
            #add-point:BEFORE FIELD fabl019 name="input.b.page1.fabl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl019
            
            #add-point:AFTER FIELD fabl019 name="input.a.page1.fabl019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl019
            #add-point:ON CHANGE fabl019 name="input.g.page1.fabl019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl013
            
            #add-point:AFTER FIELD fabl013 name="input.a.page1.fabl013"
#            IF NOT cl_null(g_fabl_d[l_ac].fabl013) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl013
##               LET g_chkparam.arg2 = '參數2'
##               LET g_chkparam.arg3 = 
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_faab004") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl013
            #add-point:BEFORE FIELD fabl013 name="input.b.page1.fabl013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl013
            #add-point:ON CHANGE fabl013 name="input.g.page1.fabl013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl014
            
            #add-point:AFTER FIELD fabl014 name="input.a.page1.fabl014"
#            IF NOT cl_null(g_fabl_d[l_ac].fabl014) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl014
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 
#

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl014
            #add-point:BEFORE FIELD fabl014 name="input.b.page1.fabl014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl014
            #add-point:ON CHANGE fabl014 name="input.g.page1.fabl014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl015
            
            #add-point:AFTER FIELD fabl015 name="input.a.page1.fabl015"
#            IF NOT cl_null(g_fabl_d[l_ac].fabl015) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl_d[l_ac].fabl015
#               LET g_chkparam.arg2 = '參數2'
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001_3") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl015
            #add-point:BEFORE FIELD fabl015 name="input.b.page1.fabl015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl015
            #add-point:ON CHANGE fabl015 name="input.g.page1.fabl015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl101
            #add-point:BEFORE FIELD fabl101 name="input.b.page1.fabl101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl101
            
            #add-point:AFTER FIELD fabl101 name="input.a.page1.fabl101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl101
            #add-point:ON CHANGE fabl101 name="input.g.page1.fabl101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl102
            #add-point:BEFORE FIELD fabl102 name="input.b.page1.fabl102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl102
            
            #add-point:AFTER FIELD fabl102 name="input.a.page1.fabl102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl102
            #add-point:ON CHANGE fabl102 name="input.g.page1.fabl102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl103
            #add-point:BEFORE FIELD fabl103 name="input.b.page1.fabl103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl103
            
            #add-point:AFTER FIELD fabl103 name="input.a.page1.fabl103"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl103
            #add-point:ON CHANGE fabl103 name="input.g.page1.fabl103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl104
            #add-point:BEFORE FIELD fabl104 name="input.b.page1.fabl104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl104
            
            #add-point:AFTER FIELD fabl104 name="input.a.page1.fabl104"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl104
            #add-point:ON CHANGE fabl104 name="input.g.page1.fabl104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl105
            #add-point:BEFORE FIELD fabl105 name="input.b.page1.fabl105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl105
            
            #add-point:AFTER FIELD fabl105 name="input.a.page1.fabl105"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl105
            #add-point:ON CHANGE fabl105 name="input.g.page1.fabl105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl106
            #add-point:BEFORE FIELD fabl106 name="input.b.page1.fabl106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl106
            
            #add-point:AFTER FIELD fabl106 name="input.a.page1.fabl106"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl106
            #add-point:ON CHANGE fabl106 name="input.g.page1.fabl106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl201
            #add-point:BEFORE FIELD fabl201 name="input.b.page1.fabl201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl201
            
            #add-point:AFTER FIELD fabl201 name="input.a.page1.fabl201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl201
            #add-point:ON CHANGE fabl201 name="input.g.page1.fabl201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl202
            #add-point:BEFORE FIELD fabl202 name="input.b.page1.fabl202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl202
            
            #add-point:AFTER FIELD fabl202 name="input.a.page1.fabl202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl202
            #add-point:ON CHANGE fabl202 name="input.g.page1.fabl202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl203
            #add-point:BEFORE FIELD fabl203 name="input.b.page1.fabl203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl203
            
            #add-point:AFTER FIELD fabl203 name="input.a.page1.fabl203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl203
            #add-point:ON CHANGE fabl203 name="input.g.page1.fabl203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl204
            #add-point:BEFORE FIELD fabl204 name="input.b.page1.fabl204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl204
            
            #add-point:AFTER FIELD fabl204 name="input.a.page1.fabl204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl204
            #add-point:ON CHANGE fabl204 name="input.g.page1.fabl204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl205
            #add-point:BEFORE FIELD fabl205 name="input.b.page1.fabl205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl205
            
            #add-point:AFTER FIELD fabl205 name="input.a.page1.fabl205"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl205
            #add-point:ON CHANGE fabl205 name="input.g.page1.fabl205"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabl206
            #add-point:BEFORE FIELD fabl206 name="input.b.page1.fabl206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabl206
            
            #add-point:AFTER FIELD fabl206 name="input.a.page1.fabl206"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabl206
            #add-point:ON CHANGE fabl206 name="input.g.page1.fabl206"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fablseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fablseq
            #add-point:ON ACTION controlp INFIELD fablseq name="input.c.page1.fablseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl001
            #add-point:ON ACTION controlp INFIELD fabl001 name="input.c.page1.fabl001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            
            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl001 #財產編號            #給予default值
            LET g_qryparam.default2 = g_fabl_d[l_ac].fabl002 #附號
            LET g_qryparam.default3 = g_fabl_d[l_ac].fabl003 
            #給予arg
            LET g_qryparam.arg1 = "" #
             CALL s_fin_create_account_center_tmp() 
             CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_faba_m.fabadocdt,'1')
             CALL s_fin_account_center_comp_str() RETURNING l_origin_str
             CALL afat470_change_to_sql(l_origin_str)RETURNING l_origin_str
             LET l_origin_str = "(",l_origin_str,")" 
          
             LET g_qryparam.where = "faah015 NOT IN ('0','5','6','8','10') AND faah032 = '",g_faba_m.fabacomp,"' AND faah028 IN ",l_origin_str
            CALL q_faah003_5()                                #呼叫開窗

            LET g_fabl_d[l_ac].fabl001 = g_qryparam.return1              
            LET g_fabl_d[l_ac].fabl002 = g_qryparam.return2 
            LET g_fabl_d[l_ac].fabl003 = g_qryparam.return3 
            DISPLAY g_fabl_d[l_ac].fabl001 TO fabl001  #財產編號
            DISPLAY g_fabl_d[l_ac].fabl002 TO faal002  #附號
            DISPLAY g_fabl_d[l_ac].fabl003 TO faal003  #卡號

            NEXT FIELD fabl001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl002
            #add-point:ON ACTION controlp INFIELD fabl002 name="input.c.page1.fabl002"
           #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl001 #財產編號            #給予default值
            LET g_qryparam.default2 = g_fabl_d[l_ac].fabl002 #附號
            LET g_qryparam.default3 = g_fabl_d[l_ac].fabl003 
             CALL s_fin_create_account_center_tmp() 
             CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_faba_m.fabadocdt,'1')
             CALL s_fin_account_center_comp_str() RETURNING l_origin_str
             CALL afat470_change_to_sql(l_origin_str)RETURNING l_origin_str
             LET l_origin_str = "(",l_origin_str,")" 
          
             LET g_qryparam.where = "faah015 NOT IN ('0','5','6','8','10') AND faah032 = '",g_faba_m.fabacomp,"' AND faah028 IN ",l_origin_str
            
            
            IF NOT cl_null(g_fabl_d[l_ac].fabl001) THEN
               LET g_qryparam.where = " AND faaj001 = '",g_fabl_d[l_ac].fabl001,"'"
            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faah003_6()                                #呼叫開窗

            LET g_fabl_d[l_ac].fabl002 = g_qryparam.return2              
            #LET g_fabh_d[l_ac].faah003 = g_qryparam.return2 
            #LET g_fabh_d[l_ac].faah004 = g_qryparam.return3 
            DISPLAY g_fabl_d[l_ac].fabl002 TO fabl002              #
            #DISPLAY g_fabh_d[l_ac].faah003 TO faah003 #財產編號
            #DISPLAY g_fabh_d[l_ac].faah004 TO faah004 #附號
            NEXT FIELD fabl002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl003
            #add-point:ON ACTION controlp INFIELD fabl003 name="input.c.page1.fabl003"
            #此段落由子樣板a07產生            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF cl_null(g_fabl_d[l_ac].fabl002) THEN LET g_fabl_d[l_ac].fabl002=' ' END IF
            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl001 #財產編號            #給予default值
            LET g_qryparam.default2 = g_fabl_d[l_ac].fabl002 #附號
            LET g_qryparam.default3 = g_fabl_d[l_ac].fabl003 
            
             CALL s_fin_create_account_center_tmp() 
             CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_faba_m.fabadocdt,'1')
             CALL s_fin_account_center_comp_str() RETURNING l_origin_str
             CALL afat470_change_to_sql(l_origin_str)RETURNING l_origin_str
             LET l_origin_str = "(",l_origin_str,")" 
          
             LET g_qryparam.where = "faah015 NOT IN ('0','5','6','8','10') AND faah032 = '",g_faba_m.fabacomp,"' AND faah028 IN ",l_origin_str
            
            
           IF NOT cl_null(g_fabl_d[l_ac].fabl001) THEN
               LET g_qryparam.where = g_qryparam.where," AND faaj001 = '",g_fabl_d[l_ac].fabl001,"'"
            END IF
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faah003_7()                                #呼叫開窗

            LET g_fabl_d[l_ac].fabl003 = g_qryparam.return3              
            #LET g_fabh_d[l_ac].faah003 = g_qryparam.return2 
            #LET g_fabh_d[l_ac].faah004 = g_qryparam.return3 
            DISPLAY g_fabl_d[l_ac].fabl003 TO fabl003              #
            #DISPLAY g_fabh_d[l_ac].faah003 TO faah003 #財產編號
            #DISPLAY g_fabh_d[l_ac].faah004 TO faah004 #附號
            NEXT FIELD fabl003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.faah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah012
            #add-point:ON ACTION controlp INFIELD faah012 name="input.c.page1.faah012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.faah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD faah013
            #add-point:ON ACTION controlp INFIELD faah013 name="input.c.page1.faah013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl017
            #add-point:ON ACTION controlp INFIELD fabl017 name="input.c.page1.fabl017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl004
            #add-point:ON ACTION controlp INFIELD fabl004 name="input.c.page1.fabl004"
            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl004             #給予default值
#
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_faac001()                                #呼叫開窗
#
#            LET g_fabl_d[l_ac].fabl004 = g_qryparam.return1              
#
#            DISPLAY g_fabl_d[l_ac].fabl004 TO fabl004              #
#
#            NEXT FIELD fabl004                          #返回原欄位
#

            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl005
            #add-point:ON ACTION controlp INFIELD fabl005 name="input.c.page1.fabl005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl006
            #add-point:ON ACTION controlp INFIELD fabl006 name="input.c.page1.fabl006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl007
            #add-point:ON ACTION controlp INFIELD fabl007 name="input.c.page1.fabl007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl008
            #add-point:ON ACTION controlp INFIELD fabl008 name="input.c.page1.fabl008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl009
            #add-point:ON ACTION controlp INFIELD fabl009 name="input.c.page1.fabl009"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl009             #給予default值
#
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_ooaj002()                                #呼叫開窗
#
#            LET g_fabl_d[l_ac].fabl009 = g_qryparam.return1              
#
#            DISPLAY g_fabl_d[l_ac].fabl009 TO fabl009              #
#
#            NEXT FIELD fabl009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl010
            #add-point:ON ACTION controlp INFIELD fabl010 name="input.c.page1.fabl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl011
            #add-point:ON ACTION controlp INFIELD fabl011 name="input.c.page1.fabl011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl012
            #add-point:ON ACTION controlp INFIELD fabl012 name="input.c.page1.fabl012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl016
            #add-point:ON ACTION controlp INFIELD fabl016 name="input.c.page1.fabl016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl019
            #add-point:ON ACTION controlp INFIELD fabl019 name="input.c.page1.fabl019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl013
            #add-point:ON ACTION controlp INFIELD fabl013 name="input.c.page1.fabl013"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl013             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl_d[l_ac].ooefl003 #說明(簡稱)
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_ooef001()                                #呼叫開窗
#
#            LET g_fabl_d[l_ac].fabl013 = g_qryparam.return1              
#            #LET g_fabl_d[l_ac].ooefl003 = g_qryparam.return2 
#            DISPLAY g_fabl_d[l_ac].fabl013 TO fabl013              #
#            #DISPLAY g_fabl_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
#            NEXT FIELD fabl013                          #返回原欄位
#

            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl014
            #add-point:ON ACTION controlp INFIELD fabl014 name="input.c.page1.fabl014"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl014             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl_d[l_ac].ooefl003 #說明(簡稱)
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_ooef001()                                #呼叫開窗
#
#            LET g_fabl_d[l_ac].fabl014 = g_qryparam.return1              
#            #LET g_fabl_d[l_ac].ooefl003 = g_qryparam.return2 
#            DISPLAY g_fabl_d[l_ac].fabl014 TO fabl014              #
#            #DISPLAY g_fabl_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
#            NEXT FIELD fabl014                          #返回原欄位
#

            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl015
            #add-point:ON ACTION controlp INFIELD fabl015 name="input.c.page1.fabl015"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl_d[l_ac].fabl015             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl_d[l_ac].ooefl003 #說明(簡稱)
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_ooef001()                                #呼叫開窗
#
#            LET g_fabl_d[l_ac].fabl015 = g_qryparam.return1              
#            #LET g_fabl_d[l_ac].ooefl003 = g_qryparam.return2 
#            DISPLAY g_fabl_d[l_ac].fabl015 TO fabl015              #
#            #DISPLAY g_fabl_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
#            NEXT FIELD fabl015                          #返回原欄位
#

            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl101
            #add-point:ON ACTION controlp INFIELD fabl101 name="input.c.page1.fabl101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl102
            #add-point:ON ACTION controlp INFIELD fabl102 name="input.c.page1.fabl102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl103
            #add-point:ON ACTION controlp INFIELD fabl103 name="input.c.page1.fabl103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl104
            #add-point:ON ACTION controlp INFIELD fabl104 name="input.c.page1.fabl104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl105
            #add-point:ON ACTION controlp INFIELD fabl105 name="input.c.page1.fabl105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl106
            #add-point:ON ACTION controlp INFIELD fabl106 name="input.c.page1.fabl106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl201
            #add-point:ON ACTION controlp INFIELD fabl201 name="input.c.page1.fabl201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl202
            #add-point:ON ACTION controlp INFIELD fabl202 name="input.c.page1.fabl202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl203
            #add-point:ON ACTION controlp INFIELD fabl203 name="input.c.page1.fabl203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl204
            #add-point:ON ACTION controlp INFIELD fabl204 name="input.c.page1.fabl204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl205
            #add-point:ON ACTION controlp INFIELD fabl205 name="input.c.page1.fabl205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fabl206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabl206
            #add-point:ON ACTION controlp INFIELD fabl206 name="input.c.page1.fabl206"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fabl_d[l_ac].* = g_fabl_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat470_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fabl_d[l_ac].fablseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_fabl_d[l_ac].* = g_fabl_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afat470_fabl_t_mask_restore('restore_mask_o')
      
               UPDATE fabl_t SET (fabldocno,fablseq,fabl001,fabl002,fabl003,fabl017,fabl004,fabl005, 
                   fabl006,fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014, 
                   fabl015,fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204, 
                   fabl205,fabl206) = (g_faba_m.fabadocno,g_fabl_d[l_ac].fablseq,g_fabl_d[l_ac].fabl001, 
                   g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl017,g_fabl_d[l_ac].fabl004, 
                   g_fabl_d[l_ac].fabl005,g_fabl_d[l_ac].fabl006,g_fabl_d[l_ac].fabl007,g_fabl_d[l_ac].fabl008, 
                   g_fabl_d[l_ac].fabl009,g_fabl_d[l_ac].fabl010,g_fabl_d[l_ac].fabl011,g_fabl_d[l_ac].fabl012, 
                   g_fabl_d[l_ac].fabl016,g_fabl_d[l_ac].fabl019,g_fabl_d[l_ac].fabl013,g_fabl_d[l_ac].fabl014, 
                   g_fabl_d[l_ac].fabl015,g_fabl_d[l_ac].fabl101,g_fabl_d[l_ac].fabl102,g_fabl_d[l_ac].fabl103, 
                   g_fabl_d[l_ac].fabl104,g_fabl_d[l_ac].fabl105,g_fabl_d[l_ac].fabl106,g_fabl_d[l_ac].fabl201, 
                   g_fabl_d[l_ac].fabl202,g_fabl_d[l_ac].fabl203,g_fabl_d[l_ac].fabl204,g_fabl_d[l_ac].fabl205, 
                   g_fabl_d[l_ac].fabl206)
                WHERE fablent = g_enterprise AND fabldocno = g_faba_m.fabadocno 
 
                  AND fablseq = g_fabl_d_t.fablseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabl_d[l_ac].* = g_fabl_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabl_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabl_d[l_ac].* = g_fabl_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faba_m.fabadocno
               LET gs_keys_bak[1] = g_fabadocno_t
               LET gs_keys[2] = g_fabl_d[g_detail_idx].fablseq
               LET gs_keys_bak[2] = g_fabl_d_t.fablseq
               CALL afat470_update_b('fabl_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afat470_fabl_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fabl_d[g_detail_idx].fablseq = g_fabl_d_t.fablseq 
 
                  ) THEN
                  LET gs_keys[01] = g_faba_m.fabadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fabl_d_t.fablseq
 
                  CALL afat470_key_update_b(gs_keys,'fabl_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_faba_m),util.JSON.stringify(g_fabl_d_t)
               LET g_log2 = util.JSON.stringify(g_faba_m),util.JSON.stringify(g_fabl_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afat470_unlock_b("fabl_t","'1'")
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
               LET g_fabl_d[li_reproduce_target].* = g_fabl_d[li_reproduce].*
 
               LET g_fabl_d[li_reproduce_target].fablseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabl_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabl_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fabl2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM fabl_t
             WHERE fablent = g_enterprise
               AND fabldocno = g_faba_m.fabadocno
               AND fabl017 = '1'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "afa-00256" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               NEXT FIELD fabl001
            END IF 
            LET l_n = 0
            SELECT COUNT(*) INTO l_n
              FROM fabm_t
             WHERE fabment = g_enterprise
               AND fabmdocno = g_faba_m.fabadocno
            #单身二笔数为零才出提示
            IF l_n = 0 THEN 
               CALL afat470_01(g_faba_m.fabadocno)
            END IF 
            CALL afat470_set_comp()
            #######################################huangtao add 
            CALL afat470_b_fill()
            #######################################huangtao add
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fabl2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afat470_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fabl2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fabl2_d[l_ac].* TO NULL 
            INITIALIZE g_fabl2_d_t.* TO NULL 
            INITIALIZE g_fabl2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_fabl2_d[l_ac].fabm007 = "0"
      LET g_fabl2_d[l_ac].fabm008 = "1"
      LET g_fabl2_d[l_ac].fabm009 = "1"
      LET g_fabl2_d[l_ac].fabm012 = "0"
      LET g_fabl2_d[l_ac].fabm013 = "0"
      LET g_fabl2_d[l_ac].fabm018 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fabl2_d_t.* = g_fabl2_d[l_ac].*     #新輸入資料
            LET g_fabl2_d_o.* = g_fabl2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afat470_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afat470_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fabl2_d[li_reproduce_target].* = g_fabl2_d[li_reproduce].*
 
               LET g_fabl2_d[li_reproduce_target].fabmseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            IF g_fabl2_d[l_ac].fabmseq IS NULL OR g_fabl2_d[l_ac].fabmseq = 0 THEN
               SELECT max(fabmseq)+1 INTO g_fabl2_d[l_ac].fabmseq
                 FROM fabm_t
                WHERE fabment = g_enterprise   
                  AND fabmdocno = g_faba_m.fabadocno
               IF cl_null(g_fabl2_d[l_ac].fabmseq) THEN
                  LET g_fabl2_d[l_ac].fabmseq = 1
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
            OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afat470_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE afat470_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fabl2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fabl2_d[l_ac].fabmseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fabl2_d_t.* = g_fabl2_d[l_ac].*  #BACKUP
               LET g_fabl2_d_o.* = g_fabl2_d[l_ac].*  #BACKUP
               CALL afat470_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afat470_set_no_entry_b(l_cmd)
               IF NOT afat470_lock_b("fabm_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afat470_bcl2 INTO g_fabl2_d[l_ac].fabmseq,g_fabl2_d[l_ac].fabm005,g_fabl2_d[l_ac].fabm001, 
                      g_fabl2_d[l_ac].fabm002,g_fabl2_d[l_ac].fabm003,g_fabl2_d[l_ac].fabm020,g_fabl2_d[l_ac].fabm006, 
                      g_fabl2_d[l_ac].fabm004,g_fabl2_d[l_ac].fabm007,g_fabl2_d[l_ac].fabm008,g_fabl2_d[l_ac].fabm009, 
                      g_fabl2_d[l_ac].fabm010,g_fabl2_d[l_ac].fabm011,g_fabl2_d[l_ac].fabm012,g_fabl2_d[l_ac].fabm013, 
                      g_fabl2_d[l_ac].fabm017,g_fabl2_d[l_ac].fabm018,g_fabl2_d[l_ac].fabm014,g_fabl2_d[l_ac].fabm015, 
                      g_fabl2_d[l_ac].fabm016,g_fabl2_d[l_ac].fabm101,g_fabl2_d[l_ac].fabm102,g_fabl2_d[l_ac].fabm103, 
                      g_fabl2_d[l_ac].fabm104,g_fabl2_d[l_ac].fabm105,g_fabl2_d[l_ac].fabm106,g_fabl2_d[l_ac].fabm201, 
                      g_fabl2_d[l_ac].fabm202,g_fabl2_d[l_ac].fabm203,g_fabl2_d[l_ac].fabm204,g_fabl2_d[l_ac].fabm205, 
                      g_fabl2_d[l_ac].fabm206
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fabl2_d_mask_o[l_ac].* =  g_fabl2_d[l_ac].*
                  CALL afat470_fabm_t_mask()
                  LET g_fabl2_d_mask_n[l_ac].* =  g_fabl2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afat470_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            #類型為主件時，附號不可錄
            IF g_fabl2_d[l_ac].fabm005 = '1' THEN
               CALL cl_set_comp_entry("fabm001",TRUE)
               CALL cl_set_comp_entry("fabm002",FALSE)
            ELSE
               CALL cl_set_comp_entry("fabm001",FALSE)
               CALL cl_set_comp_entry("fabm002",TRUE)
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
               LET gs_keys[01] = g_faba_m.fabadocno
               LET gs_keys[gs_keys.getLength()+1] = g_fabl2_d_t.fabmseq
            
               #刪除同層單身
               IF NOT afat470_delete_b('fabm_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat470_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afat470_key_delete_b(gs_keys,'fabm_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afat470_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afat470_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fabl_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fabl2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM fabm_t 
             WHERE fabment = g_enterprise AND fabmdocno = g_faba_m.fabadocno
               AND fabmseq = g_fabl2_d[l_ac].fabmseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faba_m.fabadocno
               LET gs_keys[2] = g_fabl2_d[g_detail_idx].fabmseq
               CALL afat470_insert_b('fabm_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fabl_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afat470_b_fill()
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
               LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat470_bcl2
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
               LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afat470_fabm_t_mask_restore('restore_mask_o')
                              
               UPDATE fabm_t SET (fabmdocno,fabmseq,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006, 
                   fabm004,fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014, 
                   fabm015,fabm016,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203, 
                   fabm204,fabm205,fabm206) = (g_faba_m.fabadocno,g_fabl2_d[l_ac].fabmseq,g_fabl2_d[l_ac].fabm005, 
                   g_fabl2_d[l_ac].fabm001,g_fabl2_d[l_ac].fabm002,g_fabl2_d[l_ac].fabm003,g_fabl2_d[l_ac].fabm020, 
                   g_fabl2_d[l_ac].fabm006,g_fabl2_d[l_ac].fabm004,g_fabl2_d[l_ac].fabm007,g_fabl2_d[l_ac].fabm008, 
                   g_fabl2_d[l_ac].fabm009,g_fabl2_d[l_ac].fabm010,g_fabl2_d[l_ac].fabm011,g_fabl2_d[l_ac].fabm012, 
                   g_fabl2_d[l_ac].fabm013,g_fabl2_d[l_ac].fabm017,g_fabl2_d[l_ac].fabm018,g_fabl2_d[l_ac].fabm014, 
                   g_fabl2_d[l_ac].fabm015,g_fabl2_d[l_ac].fabm016,g_fabl2_d[l_ac].fabm101,g_fabl2_d[l_ac].fabm102, 
                   g_fabl2_d[l_ac].fabm103,g_fabl2_d[l_ac].fabm104,g_fabl2_d[l_ac].fabm105,g_fabl2_d[l_ac].fabm106, 
                   g_fabl2_d[l_ac].fabm201,g_fabl2_d[l_ac].fabm202,g_fabl2_d[l_ac].fabm203,g_fabl2_d[l_ac].fabm204, 
                   g_fabl2_d[l_ac].fabm205,g_fabl2_d[l_ac].fabm206) #自訂欄位頁簽
                WHERE fabment = g_enterprise AND fabmdocno = g_faba_m.fabadocno
                  AND fabmseq = g_fabl2_d_t.fabmseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabm_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_faba_m.fabadocno
               LET gs_keys_bak[1] = g_fabadocno_t
               LET gs_keys[2] = g_fabl2_d[g_detail_idx].fabmseq
               LET gs_keys_bak[2] = g_fabl2_d_t.fabmseq
               CALL afat470_update_b('fabm_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afat470_fabm_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fabl2_d[g_detail_idx].fabmseq = g_fabl2_d_t.fabmseq 
                  ) THEN
                  LET gs_keys[01] = g_faba_m.fabadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_fabl2_d_t.fabmseq
                  CALL afat470_key_update_b(gs_keys,'fabm_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_faba_m),util.JSON.stringify(g_fabl2_d_t)
               LET g_log2 = util.JSON.stringify(g_faba_m),util.JSON.stringify(g_fabl2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               IF g_fabl2_d[l_ac].fabm005 = '1' THEN 
                  #UPDATE fabm_t SET fabm001 = g_fabl2_d[l_ac].fabm001 WHERE fabmdocno = g_faba_m.fabadocno
                  UPDATE fabm_t SET fabm001 = g_fabl2_d[l_ac].fabm001 WHERE fabmdocno = g_faba_m.fabadocno   AND fabment = g_enterprise   #160905-00007#2 add    
                  IF SQLCA.sqlcode THEN #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fabm_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
                  END IF 
                  CALL afat470_b_fill()
               END IF                    
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabmseq
            #add-point:BEFORE FIELD fabmseq name="input.b.page2.fabmseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabmseq
            
            #add-point:AFTER FIELD fabmseq name="input.a.page2.fabmseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_faba_m.fabadocno IS NOT NULL AND g_fabl2_d[g_detail_idx].fabmseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_faba_m.fabadocno != g_fabadocno_t OR g_fabl2_d[g_detail_idx].fabmseq != g_fabl2_d_t.fabmseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fabm_t WHERE "||"fabment = '" ||g_enterprise|| "' AND "||"fabmdocno = '"||g_faba_m.fabadocno ||"' AND "|| "fabmseq = '"||g_fabl2_d[g_detail_idx].fabmseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabmseq
            #add-point:ON CHANGE fabmseq name="input.g.page2.fabmseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm005
            #add-point:BEFORE FIELD fabm005 name="input.b.page2.fabm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm005
            
            #add-point:AFTER FIELD fabm005 name="input.a.page2.fabm005"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm005) THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_fabl2_d[l_ac].fabm005 != g_fabl2_d_t.fabm005) THEN   #160824-00007#235 by sakura mark
               IF g_fabl2_d[l_ac].fabm005 != g_fabl2_d_o.fabm005 OR cl_null(g_fabl2_d_o.fabm005) THEN     #160824-00007#235 by sakura add
                  #單身合併類型不能重複
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_n2 FROM fabm_t 
                   WHERE fabment = g_enterprise 
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabm005 = g_fabl2_d[l_ac].fabm005
                  IF l_n2 >= 1 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00167'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_fabl2_d[l_ac].fabm005 = g_fabl2_d_o.fabm005   #160824-00007#235 by sakura add
                     NEXT FIELD fabm005
                  END IF   
               END IF
               
               #類型為主件時，附號不可錄
               IF g_fabl2_d[l_ac].fabm005 = '1' THEN
                  CALL cl_set_comp_entry("fabm001",TRUE)
                  CALL cl_set_comp_entry("fabm002",FALSE)
                  LET g_fabl2_d[l_ac].fabm002 = " "
               ELSE
                  CALL cl_set_comp_entry("fabm001",FALSE)
                  CALL cl_set_comp_entry("fabm002",TRUE)             
               END IF
               IF l_cmd = 'a' THEN 
                  #從單身一fabl_t中獲取符合類型的其中一筆資料的預設值
                  CALL afat470_detail_def(g_fabl2_d[l_ac].fabm005) RETURNING l_fabl001,l_fabl002,l_fabl003  
                  
                  #獲取單身預設值-主要類型、規格、資產性質、資產屬性、幣別、匯率、管理組織、所有組織，核算組織              
                  SELECT fabl004,fabl005,fabl007,fabl008,fabl009,fabl010,
                         fabl013,fabl014,fabl015
                    INTO g_fabl2_d[l_ac].fabm004,g_fabl2_d[l_ac].fabm006,g_fabl2_d[l_ac].fabm008,
                         g_fabl2_d[l_ac].fabm009,g_fabl2_d[l_ac].fabm010,g_fabl2_d[l_ac].fabm011,
                         g_fabl2_d[l_ac].fabm014,g_fabl2_d[l_ac].fabm015,g_fabl2_d[l_ac].fabm016
                    FROM fabl_t
                   WHERE fablent = g_enterprise
                     AND fabldocno = g_faba_m.fabadocno
                     AND fabl001 = l_fabl001 
                     AND fabl002 = l_fabl002
                     AND fabl003 = l_fabl003   
                  #161009-00007#1--add--s--
                  #獲取單身預設值-名称
                  IF cl_null(l_fabl002) THEN
                     LET l_fabl002 = ' '
                  END IF
                  SELECT faah012 INTO g_fabl2_d[l_ac].fabm020
                    FROM faah_t
                   WHERE faahent = g_enterprise
                     AND faah003 = l_fabl001
                     AND faah004 = l_fabl002 
                     AND faah001 = l_fabl003                   
                  #161009-00007#1--add--e--
                  CALL afat470_get_fabm004_desc()
                  
                  #卡片編號
                  CALL cl_get_para(g_enterprise,g_faba_m.fabasite,'S-FIN-9005') RETURNING g_para_data   #卡片編號是否自動編號
                  
                  IF g_para_data = 'Y' THEN 
                     SELECT MAX(fabm003) INTO l_fabm003 FROM fabm_t
                      WHERE fabment = g_enterprise
                        AND fabmdocno = g_faba_m.fabadocno
                     IF cl_null(l_fabm003) THEN                   
                        #SELECT lpad((MAX(faah001) + 1),10,'0') INTO g_fabl2_d[l_ac].fabm003             #161009-00006#7 mark lujh
                        SELECT lpad((MAX(lpad(faah001,10,'0')) + 1),10,'0') INTO g_fabl2_d[l_ac].fabm003 #161009-00006#7 add lujh
                          FROM faah_t
                         WHERE faahent = g_enterprise
                           AND faah032 = g_faba_m.fabacomp    #161009-00006#7 add lujh
                     ELSE
                        #SELECT lpad((MAX(fabm003)+ 1),10,'0') INTO g_fabl2_d[l_ac].fabm003 FROM fabm_t               #161009-00006#7 mark lujh
                        SELECT lpad((MAX(lpad(fabm003,10,'0'))+ 1),10,'0') INTO g_fabl2_d[l_ac].fabm003 FROM fabm_t   #161009-00006#7 add lujh
                         WHERE fabment = g_enterprise
                           AND fabmdocno = g_faba_m.fabadocno   #161009-00006#7 unmark lujh
                     END IF                  
                  ELSE
                      LET g_fabl2_d[l_ac].fabm003 = ''                  
                  END IF
                  
                  #數量預設為1
                  LET g_fabl2_d[l_ac].fabm007 = 1
                  
                  #原幣、本幣金額匯總
                  SELECT SUM(fabl011),SUM(fabl012) 
                    INTO g_fabl2_d[l_ac].fabm012,g_fabl2_d[l_ac].fabm013
                    FROM fabl_t
                   WHERE fablent = g_enterprise
                     AND fabldocno = g_faba_m.fabadocno
                     AND fabl017 = g_fabl2_d[l_ac].fabm005  
                     
                  #類型為附屬配件或附屬費用時
                  #若單身已存在主件，則財編=主件財編，否則為空需自行輸入
                  IF g_fabl2_d[l_ac].fabm005 = '2' OR g_fabl2_d[l_ac].fabm005 = '3' THEN
                     SELECT fabm001 INTO l_fabm001 FROM fabm_t
                      WHERE fabment = g_enterprise
                        AND fabmdocno = g_faba_m.fabadocno
                        AND fabm005 = '1' 
                     IF NOT cl_null(l_fabm001) THEN
                        LET g_fabl2_d[l_ac].fabm001 = l_fabm001
                     ELSE
                        LET g_fabl2_d[l_ac].fabm001 = ''                     
                     END IF                     
                  END IF   
               END IF                   
            END IF
            LET g_fabl2_d_o.* = g_fabl2_d[l_ac].*   #160824-00007#235 by sakura add            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm005
            #add-point:ON CHANGE fabm005 name="input.g.page2.fabm005"
            IF g_fabl2_d[l_ac].fabm005 = '1' AND NOT cl_null(g_fabl2_d[l_ac].fabm001) THEN 
               LET l_n3 = 0
               SELECT count(*) INTO l_n3 
                 FROM faah_t
                WHERE faahent = g_enterprise
                  AND faah003 = g_fabl2_d[l_ac].fabm001
                  AND faah002 = '1'
               IF l_n3 > 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00255'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm005
               END IF  
            END IF 
            IF g_fabl2_d[l_ac].fabm005 = '1' THEN
               CALL cl_set_comp_entry("fabm001",TRUE)
               CALL cl_set_comp_entry("fabm002",FALSE)
               LET g_fabl2_d[l_ac].fabm002 = " "
            ELSE
               CALL cl_set_comp_entry("fabm001",FALSE)
               CALL cl_set_comp_entry("fabm002",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm001
            
            #add-point:AFTER FIELD fabm001 name="input.a.page2.fabm001"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm001) THEN 
               IF g_fabl2_d[l_ac].fabm005 = '2' OR g_fabl2_d[l_ac].fabm005 = '3' THEN
                  LET l_fabm001 = ''
                  SELECT fabm001 INTO l_fabm001 FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabm005 = '1' 
                  #若不同于已有的主件財編，則需檢查改財編是否faah中存在主件   
                  IF l_fabm001 != g_fabl2_d[l_ac].fabm001 THEN
                     LET l_n3 = 0
                     SELECT count(*) INTO l_n3 
                       FROM faah_t
                      WHERE faahent = g_enterprise
                        AND faah003 = g_fabl2_d[l_ac].fabm001
                        AND faah002 = '1'
                        
                     IF l_n = 0 THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'afa-00016'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD fabm001
                     END IF                                        
                  END IF
               END IF   
               IF g_fabl2_d[l_ac].fabm005 = '1' THEN 
                  LET l_n3 = 0
                  SELECT count(*) INTO l_n3 
                    FROM faah_t
                   WHERE faahent = g_enterprise
                     AND faah003 = g_fabl2_d[l_ac].fabm001
                     AND faah002 = '1'
                  IF l_n3 > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00255'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD fabm001
                  END IF  
               END IF 
            END IF   
            #2015/02/15 Add By 01727 客戶家財編為Key值,重複需要提醒,但不需要卡死
            #2015/02/15 Add ---(S)---
            IF NOT cl_null(g_fabl2_d[l_ac].fabm001) AND NOT cl_null(g_fabl2_d[l_ac].fabm005) AND g_fabl2_d[l_ac].fabm005 = '1' THEN  #类型为主件时候才需要判断
               LET l_count = 0
               SELECT COUNT(*) INTO l_count FROM faah_t WHERE faahent = g_enterprise
                  AND faah003 = g_fabl2_d[l_ac].fabm001
               IF cl_null(l_count) THEN lET l_count = 0 END IF
               IF l_cmd = 'a' OR (l_cmd = 'u' AND g_fabl2_d[l_ac].fabm001 <> g_fabl2_d_t.fabm001) THEN
                  LET l_count1 = 0
                  SELECT COUNT(*) INTO l_count1 FROM fabm_t WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabm001 = g_fabl2_d[l_ac].fabm001
                  IF cl_null(l_count1) THEN LET l_count1 = 0 END IF
               END IF
               LET l_count = l_count + l_count1
               IF l_count > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00449'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
            END IF
            #2015/02/15 Add ---(E)---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm001
            #add-point:BEFORE FIELD fabm001 name="input.b.page2.fabm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm001
            #add-point:ON CHANGE fabm001 name="input.g.page2.fabm001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm002
            
            #add-point:AFTER FIELD fabm002 name="input.a.page2.fabm002"
            IF cl_null(g_fabl2_d[l_ac].fabm002) THEN 
               LET g_fabl2_d[l_ac].fabm002 = " "
               DISPLAY BY NAME g_fabl2_d[l_ac].fabm002
            END IF
#            IF NOT cl_null(g_fabl2_d[l_ac].fabm002) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm002
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_faah004") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm002
            #add-point:BEFORE FIELD fabm002 name="input.b.page2.fabm002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm002
            #add-point:ON CHANGE fabm002 name="input.g.page2.fabm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm003
            
            #add-point:AFTER FIELD fabm003 name="input.a.page2.fabm003"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm003) THEN
               LET l_n4 = 0
               #SELECT COUNT(*) INTO l_n4 FROM faah_t  WHERE faah001 = g_fabl2_d[l_ac].fabm003  #160905-00007#2 mark
               SELECT COUNT(*) INTO l_n4 FROM faah_t  WHERE faah001 = g_fabl2_d[l_ac].fabm003 AND faahent = g_enterprise   #160905-00007#2 add
               IF l_n4 > 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00174'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm005               
               END IF
            END IF
#            IF NOT cl_null(g_fabl2_d[l_ac].fabm003) THEN 
##此段落由子樣板a19產生
#               #校驗代值
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#               
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm003
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_faah001") THEN
#                  #檢查成功時後續處理
#                  #LET  = g_chkparam.return1
#                  #DISPLAY BY NAME 
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#            
#
#            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm003
            #add-point:BEFORE FIELD fabm003 name="input.b.page2.fabm003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm003
            #add-point:ON CHANGE fabm003 name="input.g.page2.fabm003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm020
            #add-point:BEFORE FIELD fabm020 name="input.b.page2.fabm020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm020
            
            #add-point:AFTER FIELD fabm020 name="input.a.page2.fabm020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm020
            #add-point:ON CHANGE fabm020 name="input.g.page2.fabm020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm006
            #add-point:BEFORE FIELD fabm006 name="input.b.page2.fabm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm006
            
            #add-point:AFTER FIELD fabm006 name="input.a.page2.fabm006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm006
            #add-point:ON CHANGE fabm006 name="input.g.page2.fabm006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm004
            
            #add-point:AFTER FIELD fabm004 name="input.a.page2.fabm004"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm004) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm004
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afa-00007:sub-01302|afai020|",cl_get_progname("afai020",g_lang,"2"),"|:EXEPROGafai020"
               #160318-00025#4--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_faac001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            CALL afat470_get_fabm004_desc()


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm004
            #add-point:BEFORE FIELD fabm004 name="input.b.page2.fabm004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm004
            #add-point:ON CHANGE fabm004 name="input.g.page2.fabm004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm007
            #add-point:BEFORE FIELD fabm007 name="input.b.page2.fabm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm007
            
            #add-point:AFTER FIELD fabm007 name="input.a.page2.fabm007"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm007) THEN 
               IF g_fabl2_d[l_ac].fabm007 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "aqc-00004"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm007
               END IF
               #检查数量是否大于单身一明细数量
               SELECT SUM(fabl006) INTO l_fabl006
                 FROM fabl_t
                WHERE fablent = g_enterprise
                  AND fabldocno = g_faba_m.fabadocno
               IF l_cmd = 'a' THEN 
                  SELECT SUM(fabm007) INTO l_fabm007
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
               ELSE
                  SELECT SUM(fabm007) INTO l_fabm007
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabmseq <> g_fabl2_d_t.fabmseq
                  IF cl_null(l_fabm007) THEN 
                     LET l_fabm007 = 0
                  END IF 
               END IF 
               IF l_fabm007 + g_fabl2_d[l_ac].fabm007 > l_fabl006 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00259"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm007
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm007
            #add-point:ON CHANGE fabm007 name="input.g.page2.fabm007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm008
            #add-point:BEFORE FIELD fabm008 name="input.b.page2.fabm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm008
            
            #add-point:AFTER FIELD fabm008 name="input.a.page2.fabm008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm008
            #add-point:ON CHANGE fabm008 name="input.g.page2.fabm008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm009
            #add-point:BEFORE FIELD fabm009 name="input.b.page2.fabm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm009
            
            #add-point:AFTER FIELD fabm009 name="input.a.page2.fabm009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm009
            #add-point:ON CHANGE fabm009 name="input.g.page2.fabm009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm010
            #add-point:BEFORE FIELD fabm010 name="input.b.page2.fabm010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm010
            
            #add-point:AFTER FIELD fabm010 name="input.a.page2.fabm010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm010
            #add-point:ON CHANGE fabm010 name="input.g.page2.fabm010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm011
            #add-point:BEFORE FIELD fabm011 name="input.b.page2.fabm011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm011
            
            #add-point:AFTER FIELD fabm011 name="input.a.page2.fabm011"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm011) THEN 
               IF g_fabl2_d[l_ac].fabm011 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "aqc-00004"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm011
            #add-point:ON CHANGE fabm011 name="input.g.page2.fabm011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm012
            #add-point:BEFORE FIELD fabm012 name="input.b.page2.fabm012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm012
            
            #add-point:AFTER FIELD fabm012 name="input.a.page2.fabm012"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm012) THEN 
               IF g_fabl2_d[l_ac].fabm012 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "aqc-00004"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm012
               END IF
               #检查数量是否大于单身一明细数量
               SELECT SUM(fabl011) INTO l_fabl011
                 FROM fabl_t
                WHERE fablent = g_enterprise
                  AND fabldocno = g_faba_m.fabadocno
               IF l_cmd = 'a' THEN 
                  SELECT SUM(fabm012) INTO l_fabm012
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
               ELSE
                  SELECT SUM(fabm012) INTO l_fabm012
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabmseq <> g_fabl2_d_t.fabmseq
                  IF cl_null(l_fabm012) THEN 
                     LET l_fabm012 = 0
                  END IF 
               END IF 
               IF l_fabm012 + g_fabl2_d[l_ac].fabm012 > l_fabl011 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00374"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm012
               END IF                
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm012
            #add-point:ON CHANGE fabm012 name="input.g.page2.fabm012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm013
            #add-point:BEFORE FIELD fabm013 name="input.b.page2.fabm013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm013
            
            #add-point:AFTER FIELD fabm013 name="input.a.page2.fabm013"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm013) THEN 
               IF g_fabl2_d[l_ac].fabm013 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "aqc-00004"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm013
               END IF
               #检查数量是否大于单身一明细数量
               SELECT SUM(fabl012) INTO l_fabl012
                 FROM fabl_t
                WHERE fablent = g_enterprise
                  AND fabldocno = g_faba_m.fabadocno
               IF l_cmd = 'a' THEN 
                  SELECT SUM(fabm013) INTO l_fabm013
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
               ELSE
                  SELECT SUM(fabm013) INTO l_fabm013
                    FROM fabm_t
                   WHERE fabment = g_enterprise
                     AND fabmdocno = g_faba_m.fabadocno
                     AND fabmseq <> g_fabl2_d_t.fabmseq
                  IF cl_null(l_fabm013) THEN 
                     LET l_fabm013 = 0
                  END IF 
               END IF 
               IF l_fabm013 + g_fabl2_d[l_ac].fabm013 > l_fabl012 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = "afa-00374"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  NEXT FIELD fabm013
               END IF 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm013
            #add-point:ON CHANGE fabm013 name="input.g.page2.fabm013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm017
            #add-point:BEFORE FIELD fabm017 name="input.b.page2.fabm017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm017
            
            #add-point:AFTER FIELD fabm017 name="input.a.page2.fabm017"
            IF g_fabl2_d[l_ac].fabm017 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm017
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm017
            #add-point:ON CHANGE fabm017 name="input.g.page2.fabm017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm018
            #add-point:BEFORE FIELD fabm018 name="input.b.page2.fabm018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm018
            
            #add-point:AFTER FIELD fabm018 name="input.a.page2.fabm018"
            IF g_fabl2_d[l_ac].fabm018 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm018
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm018
            #add-point:ON CHANGE fabm018 name="input.g.page2.fabm018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm014
            
            #add-point:AFTER FIELD fabm014 name="input.a.page2.fabm014"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm014) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm014
               #160318-00025#4--add--str
                LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN    #161024-00008#3
               IF cl_chk_exist("v_ooef001_26") THEN #161024-00008#3
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabl2_d[l_ac].fabm014 = g_fabl2_d_t.fabm014
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm014
            #add-point:BEFORE FIELD fabm014 name="input.b.page2.fabm014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm014
            #add-point:ON CHANGE fabm014 name="input.g.page2.fabm014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm015
            
            #add-point:AFTER FIELD fabm015 name="input.a.page2.fabm015"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm015) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm015
               LET g_chkparam.arg2 = g_site
               #160318-00025#4--add--str
                LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#4--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  #所有組織faah028的歸屬法人 需與 資金中心包含的法人且包含賬務人員的歸屬法人 一樣
                  SELECT faab004 INTO l_faab004 FROM faab_t
                   WHERE faab001 = '4'  #資產中心類型
                     AND faab002 = g_faba_m.fabasite 
                     AND faab007 = 'Y'  #現行版本
                     AND faabent = g_enterprise
                     AND faab004 IN (SELECT ooag004 FROM ooag_t 
                                      WHERE ooagent = g_enterprise AND ooag001 = g_faba_m.faba001 
                                        AND ooagstus = 'Y')
                                        
                  #所有組織的歸屬法人
                  SELECT ooef017 INTO l_ooef017 FROM ooef_t 
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_fabl2_d[l_ac].fabm015
                      
                  IF l_ooef017 != l_faab004 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'afa-00163'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()                  
                  END IF   
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabl2_d[l_ac].fabm015 = g_fabl2_d_t.fabm015
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm015
            #add-point:BEFORE FIELD fabm015 name="input.b.page2.fabm015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm015
            #add-point:ON CHANGE fabm015 name="input.g.page2.fabm015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm016
            
            #add-point:AFTER FIELD fabm016 name="input.a.page2.fabm016"
            IF NOT cl_null(g_fabl2_d[l_ac].fabm016) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fabl2_d[l_ac].fabm016
               LET g_chkparam.arg2 = '3'
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_fabl2_d[l_ac].fabm016 = g_fabl2_d_t.fabm016
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm016
            #add-point:BEFORE FIELD fabm016 name="input.b.page2.fabm016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm016
            #add-point:ON CHANGE fabm016 name="input.g.page2.fabm016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm101
            #add-point:BEFORE FIELD fabm101 name="input.b.page2.fabm101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm101
            
            #add-point:AFTER FIELD fabm101 name="input.a.page2.fabm101"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm101
            #add-point:ON CHANGE fabm101 name="input.g.page2.fabm101"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm102
            #add-point:BEFORE FIELD fabm102 name="input.b.page2.fabm102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm102
            
            #add-point:AFTER FIELD fabm102 name="input.a.page2.fabm102"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm102
            #add-point:ON CHANGE fabm102 name="input.g.page2.fabm102"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm103
            #add-point:BEFORE FIELD fabm103 name="input.b.page2.fabm103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm103
            
            #add-point:AFTER FIELD fabm103 name="input.a.page2.fabm103"
            IF g_fabl2_d[l_ac].fabm103 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm103
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm103
            #add-point:ON CHANGE fabm103 name="input.g.page2.fabm103"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm104
            #add-point:BEFORE FIELD fabm104 name="input.b.page2.fabm104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm104
            
            #add-point:AFTER FIELD fabm104 name="input.a.page2.fabm104"
            IF g_fabl2_d[l_ac].fabm104 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm104
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm104
            #add-point:ON CHANGE fabm104 name="input.g.page2.fabm104"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm105
            #add-point:BEFORE FIELD fabm105 name="input.b.page2.fabm105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm105
            
            #add-point:AFTER FIELD fabm105 name="input.a.page2.fabm105"
            IF g_fabl2_d[l_ac].fabm105 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm105
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm105
            #add-point:ON CHANGE fabm105 name="input.g.page2.fabm105"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm106
            #add-point:BEFORE FIELD fabm106 name="input.b.page2.fabm106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm106
            
            #add-point:AFTER FIELD fabm106 name="input.a.page2.fabm106"
            IF g_fabl2_d[l_ac].fabm106 < 0 THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = "aqc-00004"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD fabm106
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm106
            #add-point:ON CHANGE fabm106 name="input.g.page2.fabm106"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm201
            #add-point:BEFORE FIELD fabm201 name="input.b.page2.fabm201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm201
            
            #add-point:AFTER FIELD fabm201 name="input.a.page2.fabm201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm201
            #add-point:ON CHANGE fabm201 name="input.g.page2.fabm201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm202
            #add-point:BEFORE FIELD fabm202 name="input.b.page2.fabm202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm202
            
            #add-point:AFTER FIELD fabm202 name="input.a.page2.fabm202"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm202
            #add-point:ON CHANGE fabm202 name="input.g.page2.fabm202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm203
            #add-point:BEFORE FIELD fabm203 name="input.b.page2.fabm203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm203
            
            #add-point:AFTER FIELD fabm203 name="input.a.page2.fabm203"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm203
            #add-point:ON CHANGE fabm203 name="input.g.page2.fabm203"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm204
            #add-point:BEFORE FIELD fabm204 name="input.b.page2.fabm204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm204
            
            #add-point:AFTER FIELD fabm204 name="input.a.page2.fabm204"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm204
            #add-point:ON CHANGE fabm204 name="input.g.page2.fabm204"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm205
            #add-point:BEFORE FIELD fabm205 name="input.b.page2.fabm205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm205
            
            #add-point:AFTER FIELD fabm205 name="input.a.page2.fabm205"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm205
            #add-point:ON CHANGE fabm205 name="input.g.page2.fabm205"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fabm206
            #add-point:BEFORE FIELD fabm206 name="input.b.page2.fabm206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fabm206
            
            #add-point:AFTER FIELD fabm206 name="input.a.page2.fabm206"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fabm206
            #add-point:ON CHANGE fabm206 name="input.g.page2.fabm206"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fabmseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabmseq
            #add-point:ON ACTION controlp INFIELD fabmseq name="input.c.page2.fabmseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm005
            #add-point:ON ACTION controlp INFIELD fabm005 name="input.c.page2.fabm005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm001
            #add-point:ON ACTION controlp INFIELD fabm001 name="input.c.page2.fabm001"
            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm001             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl2_d[l_ac].faah003 #財產編號
#            LET g_qryparam.default3 = "" #g_fabl2_d[l_ac].faah004 #附號
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_faah003_3()                                #呼叫開窗
#
#            LET g_fabl2_d[l_ac].fabm001 = g_qryparam.return1              
#            #LET g_fabl2_d[l_ac].faah003 = g_qryparam.return2 
#            #LET g_fabl2_d[l_ac].faah004 = g_qryparam.return3 
#            DISPLAY g_fabl2_d[l_ac].fabm001 TO fabm001              #
#            #DISPLAY g_fabl2_d[l_ac].faah003 TO faah003 #財產編號
#            #DISPLAY g_fabl2_d[l_ac].faah004 TO faah004 #附號
#            NEXT FIELD fabm001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm002
            #add-point:ON ACTION controlp INFIELD fabm002 name="input.c.page2.fabm002"
#            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm002             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl2_d[l_ac].faah003 #財產編號
#            LET g_qryparam.default3 = "" #g_fabl2_d[l_ac].faah004 #附號
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_faah003_3()                                #呼叫開窗
#
#            LET g_fabl2_d[l_ac].fabm002 = g_qryparam.return1              
#            #LET g_fabl2_d[l_ac].faah003 = g_qryparam.return2 
#            #LET g_fabl2_d[l_ac].faah004 = g_qryparam.return3 
#            DISPLAY g_fabl2_d[l_ac].fabm002 TO fabm002              #
#            #DISPLAY g_fabl2_d[l_ac].faah003 TO faah003 #財產編號
#            #DISPLAY g_fabl2_d[l_ac].faah004 TO faah004 #附號
#            NEXT FIELD fabm002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm003
            #add-point:ON ACTION controlp INFIELD fabm003 name="input.c.page2.fabm003"
            #此段落由子樣板a07產生            
#            #開窗i段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#
#            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm003             #給予default值
#            LET g_qryparam.default2 = "" #g_fabl2_d[l_ac].faah003 #財產編號
#            LET g_qryparam.default3 = "" #g_fabl2_d[l_ac].faah004 #附號
#            #給予arg
#            LET g_qryparam.arg1 = "" #
#
#            
#            CALL q_faah003_3()                                #呼叫開窗
#
#            LET g_fabl2_d[l_ac].fabm003 = g_qryparam.return1              
#            #LET g_fabl2_d[l_ac].faah003 = g_qryparam.return2 
#            #LET g_fabl2_d[l_ac].faah004 = g_qryparam.return3 
#            DISPLAY g_fabl2_d[l_ac].fabm003 TO fabm003              #
#            #DISPLAY g_fabl2_d[l_ac].faah003 TO faah003 #財產編號
#            #DISPLAY g_fabl2_d[l_ac].faah004 TO faah004 #附號
#            NEXT FIELD fabm003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm020
            #add-point:ON ACTION controlp INFIELD fabm020 name="input.c.page2.fabm020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm006
            #add-point:ON ACTION controlp INFIELD fabm006 name="input.c.page2.fabm006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm004
            #add-point:ON ACTION controlp INFIELD fabm004 name="input.c.page2.fabm004"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_faac001()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm004 = g_qryparam.return1              

            DISPLAY g_fabl2_d[l_ac].fabm004 TO fabm004              #

            NEXT FIELD fabm004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm007
            #add-point:ON ACTION controlp INFIELD fabm007 name="input.c.page2.fabm007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm008
            #add-point:ON ACTION controlp INFIELD fabm008 name="input.c.page2.fabm008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm009
            #add-point:ON ACTION controlp INFIELD fabm009 name="input.c.page2.fabm009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm010
            #add-point:ON ACTION controlp INFIELD fabm010 name="input.c.page2.fabm010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm010 = g_qryparam.return1              

            DISPLAY g_fabl2_d[l_ac].fabm010 TO fabm010              #

            NEXT FIELD fabm010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm011
            #add-point:ON ACTION controlp INFIELD fabm011 name="input.c.page2.fabm011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm012
            #add-point:ON ACTION controlp INFIELD fabm012 name="input.c.page2.fabm012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm013
            #add-point:ON ACTION controlp INFIELD fabm013 name="input.c.page2.fabm013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm017
            #add-point:ON ACTION controlp INFIELD fabm017 name="input.c.page2.fabm017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm018
            #add-point:ON ACTION controlp INFIELD fabm018 name="input.c.page2.fabm018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm014
            #add-point:ON ACTION controlp INFIELD fabm014 name="input.c.page2.fabm014"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm014             #給予default值
            LET g_qryparam.default2 = "" #g_fabl2_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            #CALL q_ooef001()                                #呼叫開窗
            CALL q_ooef001_47()                                           #161024-00008#3 

            LET g_fabl2_d[l_ac].fabm014 = g_qryparam.return1              
            #LET g_fabl2_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabl2_d[l_ac].fabm014 TO fabm014              #
            #DISPLAY g_fabl2_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabm014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm015
            #add-point:ON ACTION controlp INFIELD fabm015 name="input.c.page2.fabm015"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm015             #給予default值
            LET g_qryparam.default2 = "" #g_fabl2_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm015 = g_qryparam.return1              
            #LET g_fabl2_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_fabl2_d[l_ac].fabm015 TO fabm015              #
            #DISPLAY g_fabl2_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD fabm015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm016
            #add-point:ON ACTION controlp INFIELD fabm016 name="input.c.page2.fabm016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3" #

            
            CALL q_ooef001_04()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm016 = g_qryparam.return1              

            DISPLAY g_fabl2_d[l_ac].fabm016 TO fabm016              #

            NEXT FIELD fabm016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm101
            #add-point:ON ACTION controlp INFIELD fabm101 name="input.c.page2.fabm101"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm101             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooai001()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm101 = g_qryparam.return1              

            DISPLAY g_fabl2_d[l_ac].fabm101 TO fabm101              #

            NEXT FIELD fabm101                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm102
            #add-point:ON ACTION controlp INFIELD fabm102 name="input.c.page2.fabm102"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm103
            #add-point:ON ACTION controlp INFIELD fabm103 name="input.c.page2.fabm103"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm104
            #add-point:ON ACTION controlp INFIELD fabm104 name="input.c.page2.fabm104"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm105
            #add-point:ON ACTION controlp INFIELD fabm105 name="input.c.page2.fabm105"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm106
            #add-point:ON ACTION controlp INFIELD fabm106 name="input.c.page2.fabm106"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm201
            #add-point:ON ACTION controlp INFIELD fabm201 name="input.c.page2.fabm201"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fabl2_d[l_ac].fabm201             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooai001()                                #呼叫開窗

            LET g_fabl2_d[l_ac].fabm201 = g_qryparam.return1              

            DISPLAY g_fabl2_d[l_ac].fabm201 TO fabm201              #

            NEXT FIELD fabm201                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm202
            #add-point:ON ACTION controlp INFIELD fabm202 name="input.c.page2.fabm202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm203
            #add-point:ON ACTION controlp INFIELD fabm203 name="input.c.page2.fabm203"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm204
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm204
            #add-point:ON ACTION controlp INFIELD fabm204 name="input.c.page2.fabm204"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm205
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm205
            #add-point:ON ACTION controlp INFIELD fabm205 name="input.c.page2.fabm205"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fabm206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fabm206
            #add-point:ON ACTION controlp INFIELD fabm206 name="input.c.page2.fabm206"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fabl2_d[l_ac].* = g_fabl2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE afat470_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afat470_unlock_b("fabm_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            CALL afat470_fabm001_chk() RETURNING l_success
            IF NOT l_success THEN 
               NEXT FIELD fabm001
            END IF 
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fabl2_d[li_reproduce_target].* = g_fabl2_d[li_reproduce].*
 
               LET g_fabl2_d[li_reproduce_target].fabmseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fabl2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fabl2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="afat470.input.other" >}
      
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
            NEXT FIELD fabasite    #160426-00014#33 add lujh
            #end add-point  
            NEXT FIELD fabadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fablseq
               WHEN "s_detail2"
                  NEXT FIELD fabmseq
 
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
   #151125-00006#1 --s
   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()   
      CALL s_aooi200_fin_get_slip(g_faba_m.fabadocno) RETURNING l_success,l_ooba002
      CALL s_fin_get_doc_para(g_glaa.glaald,g_faba_m.fabacomp,l_ooba002,'D-FIN-0031') RETURNING l_dfin0031
      IF NOT cl_null(l_dfin0031) AND l_dfin0031 MATCHES '[Yy]' THEN 
         IF cl_ask_confirm('aap-00403') THEN
            CALL afat470_immediately_conf() RETURNING l_conf_success
         END IF 
      END IF  
      IF NOT l_conf_success THEN 
         CALL s_transaction_end('N','0')
         CALL cl_err_collect_show()
      ELSE      
         CALL s_transaction_end('Y','0') 
         LET la_param.prog = 'afai100'
         LET la_param.param[6] = g_faba_m.fabadocno
         LET ls_js = util.JSON.stringify(la_param)
         CALL cl_cmdrun_wait(ls_js)         
      END IF      
   END IF      
   #151125-00006#1 --e 
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afat470_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL afat470_get_glaa()   #20150608 add lujh
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afat470_b_fill() #單身填充
      CALL afat470_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afat470_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_faba_m_mask_o.* =  g_faba_m.*
   CALL afat470_faba_t_mask()
   LET g_faba_m_mask_n.* =  g_faba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc,g_faba_m.faba001,g_faba_m.faba001_desc,g_faba_m.fabacomp, 
       g_faba_m.fabacomp_desc,g_faba_m.faba004,g_faba_m.faba004_desc,g_faba_m.faba005,g_faba_m.faba005_desc, 
       g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid, 
       g_faba_m.fabaownid_desc,g_faba_m.fabaowndp,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdp_desc,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamodid_desc, 
       g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfid_desc,g_faba_m.fabacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faba_m.fabastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fabl_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fabl2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   CALL afat470_set_comp()
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afat470_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afat470_detail_show()
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
 
{<section id="afat470.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afat470_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE faba_t.fabadocno 
   DEFINE l_oldno     LIKE faba_t.fabadocno 
 
   DEFINE l_master    RECORD LIKE faba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE fabl_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fabm_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_faba_m.fabadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fabadocno_t = g_faba_m.fabadocno
 
    
   LET g_faba_m.fabadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_faba_m.fabaownid = g_user
      LET g_faba_m.fabaowndp = g_dept
      LET g_faba_m.fabacrtid = g_user
      LET g_faba_m.fabacrtdp = g_dept 
      LET g_faba_m.fabacrtdt = cl_get_current()
      LET g_faba_m.fabamodid = g_user
      LET g_faba_m.fabamoddt = cl_get_current()
      LET g_faba_m.fabastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #160414-00015#1 -add -str   
   LET g_faba_m.fabacnfid  = NULL
   LET g_faba_m.fabacnfid_desc = NULL
   LET g_faba_m.fabacnfdt  = NULL
   LET g_faba_m.fabadocdt  = g_today
   #160414-00015#1 -add -end
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_faba_m.fabastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL afat470_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_faba_m.* TO NULL
      INITIALIZE g_fabl_d TO NULL
      INITIALIZE g_fabl2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afat470_show()
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
   CALL afat470_set_act_visible()   
   CALL afat470_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fabadocno_t = g_faba_m.fabadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " fabaent = " ||g_enterprise|| " AND",
                      " fabadocno = '", g_faba_m.fabadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afat470_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afat470_idx_chk()
   
   LET g_data_owner = g_faba_m.fabaownid      
   LET g_data_dept  = g_faba_m.fabaowndp
   
   #功能已完成,通報訊息中心
   CALL afat470_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afat470_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fabl_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE fabm_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afat470_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabl_t
    WHERE fablent = g_enterprise AND fabldocno = g_fabadocno_t
 
    INTO TEMP afat470_detail
 
   #將key修正為調整後   
   UPDATE afat470_detail 
      #更新key欄位
      SET fabldocno = g_faba_m.fabadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fabl_t SELECT * FROM afat470_detail
   
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
   DROP TABLE afat470_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fabm_t 
    WHERE fabment = g_enterprise AND fabmdocno = g_fabadocno_t
 
    INTO TEMP afat470_detail
 
   #將key修正為調整後   
   UPDATE afat470_detail SET fabmdocno = g_faba_m.fabadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fabm_t SELECT * FROM afat470_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afat470_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fabadocno_t = g_faba_m.fabadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afat470_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_glaald        LIKE glaa_t.glaald
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_faba_m.fabadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat470_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE afat470_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afat470_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_faba_m_mask_o.* =  g_faba_m.*
   CALL afat470_faba_t_mask()
   LET g_faba_m_mask_n.* =  g_faba_m.*
   
   CALL afat470_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   #151231-00005#2--add--str--lujh
   IF NOT cl_null(g_faba_m.fabadocdt) THEN 
      IF NOT s_afa_date_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN 
         CLOSE afat470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#2--add--end--lujh
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      SELECT glaald INTO l_glaald FROM glaa_t
       WHERE glaaent = g_enterprise AND glaacomp = g_faba_m.fabacomp AND glaa014 = 'Y'
      IF NOT s_aooi200_fin_del_docno(l_glaald,g_faba_m.fabadocno,g_faba_m.fabadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afat470_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fabadocno_t = g_faba_m.fabadocno
 
 
      DELETE FROM faba_t
       WHERE fabaent = g_enterprise AND fabadocno = g_faba_m.fabadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_faba_m.fabadocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM fabl_t
       WHERE fablent = g_enterprise AND fabldocno = g_faba_m.fabadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
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
      DELETE FROM fabm_t
       WHERE fabment = g_enterprise AND
             fabmdocno = g_faba_m.fabadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_faba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE afat470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fabl_d.clear() 
      CALL g_fabl2_d.clear()       
 
     
      CALL afat470_ui_browser_refresh()  
      #CALL afat470_ui_headershow()  
      #CALL afat470_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afat470_browser_fill("")
         CALL afat470_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afat470_cl
 
   #功能已完成,通報訊息中心
   CALL afat470_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afat470.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afat470_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fabl_d.clear()
   CALL g_fabl2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afat470_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fablseq,fabl001,fabl002,fabl003,fabl017,fabl004,fabl005,fabl006, 
             fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014,fabl015, 
             fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205, 
             fabl206 ,t1.faacl003 FROM fabl_t",   
                     " INNER JOIN faba_t ON fabaent = " ||g_enterprise|| " AND fabadocno = fabldocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN faacl_t t1 ON t1.faaclent="||g_enterprise||" AND t1.faacl001=fabl004 AND t1.faacl002='"||g_dlang||"' ",
 
                     " WHERE fablent=? AND fabldocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fabl_t.fablseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat470_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afat470_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_faba_m.fabadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_faba_m.fabadocno INTO g_fabl_d[l_ac].fablseq,g_fabl_d[l_ac].fabl001, 
          g_fabl_d[l_ac].fabl002,g_fabl_d[l_ac].fabl003,g_fabl_d[l_ac].fabl017,g_fabl_d[l_ac].fabl004, 
          g_fabl_d[l_ac].fabl005,g_fabl_d[l_ac].fabl006,g_fabl_d[l_ac].fabl007,g_fabl_d[l_ac].fabl008, 
          g_fabl_d[l_ac].fabl009,g_fabl_d[l_ac].fabl010,g_fabl_d[l_ac].fabl011,g_fabl_d[l_ac].fabl012, 
          g_fabl_d[l_ac].fabl016,g_fabl_d[l_ac].fabl019,g_fabl_d[l_ac].fabl013,g_fabl_d[l_ac].fabl014, 
          g_fabl_d[l_ac].fabl015,g_fabl_d[l_ac].fabl101,g_fabl_d[l_ac].fabl102,g_fabl_d[l_ac].fabl103, 
          g_fabl_d[l_ac].fabl104,g_fabl_d[l_ac].fabl105,g_fabl_d[l_ac].fabl106,g_fabl_d[l_ac].fabl201, 
          g_fabl_d[l_ac].fabl202,g_fabl_d[l_ac].fabl203,g_fabl_d[l_ac].fabl204,g_fabl_d[l_ac].fabl205, 
          g_fabl_d[l_ac].fabl206,g_fabl_d[l_ac].fabl004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
          #160426-00014#23--add--s--
          CALL afat470_get_faah()
          #160426-00014#23--add--e--
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
   IF afat470_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT fabmseq,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006,fabm004, 
             fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014,fabm015, 
             fabm016,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204, 
             fabm205,fabm206 ,t2.faacl003 FROM fabm_t",   
                     " INNER JOIN  faba_t ON fabaent = " ||g_enterprise|| " AND fabadocno = fabmdocno ",
 
                     "",
                     
                                    " LEFT JOIN faacl_t t2 ON t2.faaclent="||g_enterprise||" AND t2.faacl001=fabm004 AND t2.faacl002='"||g_dlang||"' ",
 
                     " WHERE fabment=? AND fabmdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fabm_t.fabmseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afat470_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR afat470_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_faba_m.fabadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_faba_m.fabadocno INTO g_fabl2_d[l_ac].fabmseq,g_fabl2_d[l_ac].fabm005, 
          g_fabl2_d[l_ac].fabm001,g_fabl2_d[l_ac].fabm002,g_fabl2_d[l_ac].fabm003,g_fabl2_d[l_ac].fabm020, 
          g_fabl2_d[l_ac].fabm006,g_fabl2_d[l_ac].fabm004,g_fabl2_d[l_ac].fabm007,g_fabl2_d[l_ac].fabm008, 
          g_fabl2_d[l_ac].fabm009,g_fabl2_d[l_ac].fabm010,g_fabl2_d[l_ac].fabm011,g_fabl2_d[l_ac].fabm012, 
          g_fabl2_d[l_ac].fabm013,g_fabl2_d[l_ac].fabm017,g_fabl2_d[l_ac].fabm018,g_fabl2_d[l_ac].fabm014, 
          g_fabl2_d[l_ac].fabm015,g_fabl2_d[l_ac].fabm016,g_fabl2_d[l_ac].fabm101,g_fabl2_d[l_ac].fabm102, 
          g_fabl2_d[l_ac].fabm103,g_fabl2_d[l_ac].fabm104,g_fabl2_d[l_ac].fabm105,g_fabl2_d[l_ac].fabm106, 
          g_fabl2_d[l_ac].fabm201,g_fabl2_d[l_ac].fabm202,g_fabl2_d[l_ac].fabm203,g_fabl2_d[l_ac].fabm204, 
          g_fabl2_d[l_ac].fabm205,g_fabl2_d[l_ac].fabm206,g_fabl2_d[l_ac].fabm004_desc   #(ver:78)
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
   
   CALL g_fabl_d.deleteElement(g_fabl_d.getLength())
   CALL g_fabl2_d.deleteElement(g_fabl2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afat470_pb
   FREE afat470_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fabl_d.getLength()
      LET g_fabl_d_mask_o[l_ac].* =  g_fabl_d[l_ac].*
      CALL afat470_fabl_t_mask()
      LET g_fabl_d_mask_n[l_ac].* =  g_fabl_d[l_ac].*
   END FOR
   
   LET g_fabl2_d_mask_o.* =  g_fabl2_d.*
   FOR l_ac = 1 TO g_fabl2_d.getLength()
      LET g_fabl2_d_mask_o[l_ac].* =  g_fabl2_d[l_ac].*
      CALL afat470_fabm_t_mask()
      LET g_fabl2_d_mask_n[l_ac].* =  g_fabl2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afat470_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM fabl_t
       WHERE fablent = g_enterprise AND
         fabldocno = ps_keys_bak[1] AND fablseq = ps_keys_bak[2]
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
         CALL g_fabl_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM fabm_t
       WHERE fabment = g_enterprise AND
             fabmdocno = ps_keys_bak[1] AND fabmseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fabl2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afat470_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO fabl_t
                  (fablent,
                   fabldocno,
                   fablseq
                   ,fabl001,fabl002,fabl003,fabl017,fabl004,fabl005,fabl006,fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014,fabl015,fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fabl_d[g_detail_idx].fabl001,g_fabl_d[g_detail_idx].fabl002,g_fabl_d[g_detail_idx].fabl003, 
                       g_fabl_d[g_detail_idx].fabl017,g_fabl_d[g_detail_idx].fabl004,g_fabl_d[g_detail_idx].fabl005, 
                       g_fabl_d[g_detail_idx].fabl006,g_fabl_d[g_detail_idx].fabl007,g_fabl_d[g_detail_idx].fabl008, 
                       g_fabl_d[g_detail_idx].fabl009,g_fabl_d[g_detail_idx].fabl010,g_fabl_d[g_detail_idx].fabl011, 
                       g_fabl_d[g_detail_idx].fabl012,g_fabl_d[g_detail_idx].fabl016,g_fabl_d[g_detail_idx].fabl019, 
                       g_fabl_d[g_detail_idx].fabl013,g_fabl_d[g_detail_idx].fabl014,g_fabl_d[g_detail_idx].fabl015, 
                       g_fabl_d[g_detail_idx].fabl101,g_fabl_d[g_detail_idx].fabl102,g_fabl_d[g_detail_idx].fabl103, 
                       g_fabl_d[g_detail_idx].fabl104,g_fabl_d[g_detail_idx].fabl105,g_fabl_d[g_detail_idx].fabl106, 
                       g_fabl_d[g_detail_idx].fabl201,g_fabl_d[g_detail_idx].fabl202,g_fabl_d[g_detail_idx].fabl203, 
                       g_fabl_d[g_detail_idx].fabl204,g_fabl_d[g_detail_idx].fabl205,g_fabl_d[g_detail_idx].fabl206) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fabl_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO fabm_t
                  (fabment,
                   fabmdocno,
                   fabmseq
                   ,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006,fabm004,fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014,fabm015,fabm016,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fabl2_d[g_detail_idx].fabm005,g_fabl2_d[g_detail_idx].fabm001,g_fabl2_d[g_detail_idx].fabm002, 
                       g_fabl2_d[g_detail_idx].fabm003,g_fabl2_d[g_detail_idx].fabm020,g_fabl2_d[g_detail_idx].fabm006, 
                       g_fabl2_d[g_detail_idx].fabm004,g_fabl2_d[g_detail_idx].fabm007,g_fabl2_d[g_detail_idx].fabm008, 
                       g_fabl2_d[g_detail_idx].fabm009,g_fabl2_d[g_detail_idx].fabm010,g_fabl2_d[g_detail_idx].fabm011, 
                       g_fabl2_d[g_detail_idx].fabm012,g_fabl2_d[g_detail_idx].fabm013,g_fabl2_d[g_detail_idx].fabm017, 
                       g_fabl2_d[g_detail_idx].fabm018,g_fabl2_d[g_detail_idx].fabm014,g_fabl2_d[g_detail_idx].fabm015, 
                       g_fabl2_d[g_detail_idx].fabm016,g_fabl2_d[g_detail_idx].fabm101,g_fabl2_d[g_detail_idx].fabm102, 
                       g_fabl2_d[g_detail_idx].fabm103,g_fabl2_d[g_detail_idx].fabm104,g_fabl2_d[g_detail_idx].fabm105, 
                       g_fabl2_d[g_detail_idx].fabm106,g_fabl2_d[g_detail_idx].fabm201,g_fabl2_d[g_detail_idx].fabm202, 
                       g_fabl2_d[g_detail_idx].fabm203,g_fabl2_d[g_detail_idx].fabm204,g_fabl2_d[g_detail_idx].fabm205, 
                       g_fabl2_d[g_detail_idx].fabm206)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fabl2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afat470_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabl_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afat470_fabl_t_mask_restore('restore_mask_o')
               
      UPDATE fabl_t 
         SET (fabldocno,
              fablseq
              ,fabl001,fabl002,fabl003,fabl017,fabl004,fabl005,fabl006,fabl007,fabl008,fabl009,fabl010,fabl011,fabl012,fabl016,fabl019,fabl013,fabl014,fabl015,fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fabl_d[g_detail_idx].fabl001,g_fabl_d[g_detail_idx].fabl002,g_fabl_d[g_detail_idx].fabl003, 
                  g_fabl_d[g_detail_idx].fabl017,g_fabl_d[g_detail_idx].fabl004,g_fabl_d[g_detail_idx].fabl005, 
                  g_fabl_d[g_detail_idx].fabl006,g_fabl_d[g_detail_idx].fabl007,g_fabl_d[g_detail_idx].fabl008, 
                  g_fabl_d[g_detail_idx].fabl009,g_fabl_d[g_detail_idx].fabl010,g_fabl_d[g_detail_idx].fabl011, 
                  g_fabl_d[g_detail_idx].fabl012,g_fabl_d[g_detail_idx].fabl016,g_fabl_d[g_detail_idx].fabl019, 
                  g_fabl_d[g_detail_idx].fabl013,g_fabl_d[g_detail_idx].fabl014,g_fabl_d[g_detail_idx].fabl015, 
                  g_fabl_d[g_detail_idx].fabl101,g_fabl_d[g_detail_idx].fabl102,g_fabl_d[g_detail_idx].fabl103, 
                  g_fabl_d[g_detail_idx].fabl104,g_fabl_d[g_detail_idx].fabl105,g_fabl_d[g_detail_idx].fabl106, 
                  g_fabl_d[g_detail_idx].fabl201,g_fabl_d[g_detail_idx].fabl202,g_fabl_d[g_detail_idx].fabl203, 
                  g_fabl_d[g_detail_idx].fabl204,g_fabl_d[g_detail_idx].fabl205,g_fabl_d[g_detail_idx].fabl206)  
 
         WHERE fablent = g_enterprise AND fabldocno = ps_keys_bak[1] AND fablseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabl_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabl_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat470_fabl_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fabm_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afat470_fabm_t_mask_restore('restore_mask_o')
               
      UPDATE fabm_t 
         SET (fabmdocno,
              fabmseq
              ,fabm005,fabm001,fabm002,fabm003,fabm020,fabm006,fabm004,fabm007,fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm017,fabm018,fabm014,fabm015,fabm016,fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fabl2_d[g_detail_idx].fabm005,g_fabl2_d[g_detail_idx].fabm001,g_fabl2_d[g_detail_idx].fabm002, 
                  g_fabl2_d[g_detail_idx].fabm003,g_fabl2_d[g_detail_idx].fabm020,g_fabl2_d[g_detail_idx].fabm006, 
                  g_fabl2_d[g_detail_idx].fabm004,g_fabl2_d[g_detail_idx].fabm007,g_fabl2_d[g_detail_idx].fabm008, 
                  g_fabl2_d[g_detail_idx].fabm009,g_fabl2_d[g_detail_idx].fabm010,g_fabl2_d[g_detail_idx].fabm011, 
                  g_fabl2_d[g_detail_idx].fabm012,g_fabl2_d[g_detail_idx].fabm013,g_fabl2_d[g_detail_idx].fabm017, 
                  g_fabl2_d[g_detail_idx].fabm018,g_fabl2_d[g_detail_idx].fabm014,g_fabl2_d[g_detail_idx].fabm015, 
                  g_fabl2_d[g_detail_idx].fabm016,g_fabl2_d[g_detail_idx].fabm101,g_fabl2_d[g_detail_idx].fabm102, 
                  g_fabl2_d[g_detail_idx].fabm103,g_fabl2_d[g_detail_idx].fabm104,g_fabl2_d[g_detail_idx].fabm105, 
                  g_fabl2_d[g_detail_idx].fabm106,g_fabl2_d[g_detail_idx].fabm201,g_fabl2_d[g_detail_idx].fabm202, 
                  g_fabl2_d[g_detail_idx].fabm203,g_fabl2_d[g_detail_idx].fabm204,g_fabl2_d[g_detail_idx].fabm205, 
                  g_fabl2_d[g_detail_idx].fabm206) 
         WHERE fabment = g_enterprise AND fabmdocno = ps_keys_bak[1] AND fabmseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabm_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fabm_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afat470_fabm_t_mask_restore('restore_mask_n')
 
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
 
{<section id="afat470.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afat470_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afat470.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afat470_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afat470.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afat470_lock_b(ps_table,ps_page)
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
   #CALL afat470_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "fabl_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afat470_bcl USING g_enterprise,
                                       g_faba_m.fabadocno,g_fabl_d[g_detail_idx].fablseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat470_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "fabm_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afat470_bcl2 USING g_enterprise,
                                             g_faba_m.fabadocno,g_fabl2_d[g_detail_idx].fabmseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afat470_bcl2:",SQLERRMESSAGE 
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
 
{<section id="afat470.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afat470_unlock_b(ps_table,ps_page)
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
      CLOSE afat470_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afat470_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afat470_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("fabadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fabadocno",TRUE)
      CALL cl_set_comp_entry("fabadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("fabadocdt",TRUE)  #151130-00015#2 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afat470_set_no_entry(p_cmd)
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
      CALL cl_set_comp_entry("fabadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("fabadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("fabadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"

   #151130-00015#2  -add -str
   IF NOT cl_null(g_faba_m.fabadocno) THEN  
      #获取单别
      CALL s_aooi200_fin_get_slip(g_faba_m.fabadocno) RETURNING l_success,l_slip
      #判断是否可以修改单据日期
      CALL s_fin_get_doc_para(g_glaa.glaald,g_faba_m.fabacomp,l_slip,'D-FIN-0033') RETURNING l_dfin0033
      IF l_dfin0033 = "Y"  THEN 
         CALL cl_set_comp_entry("fabadocdt",TRUE)
    
      END IF          
   END IF 
   #151130-00015#2  -end -str
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afat470_set_entry_b(p_cmd)
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
 
{<section id="afat470.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afat470_set_no_entry_b(p_cmd)
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
 
{<section id="afat470.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afat470_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afat470_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_faba_m.fabastus MATCHES "[NDR]" THEN
      CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afat470_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat470.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afat470_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afat470.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afat470_default_search()
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
      LET ls_wc = ls_wc, " fabadocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "faba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fabl_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fabm_t" 
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
 
{<section id="afat470.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afat470_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_today             DATETIME YEAR TO SECOND
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING   
   #20150608--add--str--lujh
   DEFINE  l_gzzd005             LIKE gzzd_t.gzzd005
   DEFINE  l_colname             STRING
   DEFINE  l_comment             STRING
   #20150608--add--end--lujh   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_faba_m.fabadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afat470_cl USING g_enterprise,g_faba_m.fabadocno
   IF STATUS THEN
      CLOSE afat470_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afat470_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
       g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
       g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
       g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
       g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afat470_action_chk() THEN
      CLOSE afat470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc,g_faba_m.faba001,g_faba_m.faba001_desc,g_faba_m.fabacomp, 
       g_faba_m.fabacomp_desc,g_faba_m.faba004,g_faba_m.faba004_desc,g_faba_m.faba005,g_faba_m.faba005_desc, 
       g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid, 
       g_faba_m.fabaownid_desc,g_faba_m.fabaowndp,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid,g_faba_m.fabacrtid_desc, 
       g_faba_m.fabacrtdp,g_faba_m.fabacrtdp_desc,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamodid_desc, 
       g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfid_desc,g_faba_m.fabacnfdt
 
   CASE g_faba_m.fabastus
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
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   #151231-00005#2--add--str--lujh
   IF NOT cl_null(g_faba_m.fabadocdt) THEN 
      IF NOT s_afa_date_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN 
         CLOSE afat470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
   END IF 
   #151231-00005#2--add--end--lujh
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_faba_m.fabastus
            
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
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("confirmed,unconfirmed,posted,unposted,invalid,unhold,hold",FALSE)

      CASE g_faba_m.fabastus
         WHEN "N"   #未確認
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"   #作廢
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN

         WHEN "Y"   #已確認
#            CALL cl_set_act_visible("unconfirmed,posted,hold",TRUE)    #mark by yangxf
             CALL cl_set_act_visible("unconfirmed,hold",TRUE)           #add by yangxf

         WHEN "S"   #已過帳
            CALL cl_set_act_visible("unposted",TRUE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "D"   #抽單
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)

         WHEN "H"  #留置
            CALL cl_set_act_visible("unhold",TRUE)

#         WHEN "UH" #取消留置
#         WHEN "Z"  #扣帳還原

      END CASE
      #CALL cl_showmsg_init()      #150731-00004#1 20150826 mark
      CALL cl_err_collect_init()   #150731-00004#1 20150826 add 
      LET l_success=TRUE
      CALL s_transaction_begin()
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afat470_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat470_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afat470_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afat470_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #20150608--add--str--lujh
            CALL cl_err_collect_init()
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_glaa.glaald,g_faba_m.fabadocno,g_faba_m.fabadocdt,'fabl_t','fabl003','fabl001','fabl002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN 
            END IF
            CALL cl_err_collect_show()
            #20150608--add--end--lujh
            
            CALL afat470_unconf_chk_faba() RETURNING l_success
            IF l_success = TRUE THEN
               CALL afat470_unconf_upd_faba() RETURNING l_success
            END IF
            IF l_success = TRUE THEN
               #更新狀態碼=未審核, 確認人=NULL,確認日期=NULL
               UPDATE faba_t SET fabastus = 'N',
                                 fabacnfid = '',
                                 fabacnfdt = ''
                           WHERE fabaent = g_enterprise
                             AND fabadocno = g_faba_m.fabadocno
                IF SQLCA.SQLCODE THEN
                  LET l_success = FALSE
                  #150731-00004#1 20150826 str---
                   #CALL cl_errmsg('fabastus',g_faba_m.fabadocno,'N',sqlca.sqlcode,1)
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = sqlca.sqlcode
                   LET g_errparam.extend = 'fabastus：'||g_faba_m.fabadocno
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   #150731-00004#1 20150826 end--- 
                END IF          
            END IF            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
           #############################add by huangtao
            IF NOT s_afat503_sys_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN 
            END IF
            ################################
            
            #20150608--add--str--lujh
            CALL cl_err_collect_init()
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
            LET g_coll_title[1] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
            LET g_coll_title[2] = l_colname
            CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
            LET g_coll_title[3] = l_colname
            
            CALL s_afa_p_faan_chk(g_glaa.glaald,g_faba_m.fabadocno,g_faba_m.fabadocdt,'fabl_t','fabl003','fabl001','fabl002') RETURNING l_success
            IF l_success = FALSE THEN 
               CALL cl_err_collect_show()
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN 
            END IF
            CALL cl_err_collect_show()
            #20150608--add--end--lujh

            CALL afat470_conf_chk_faba() RETURNING l_success
            IF l_success = TRUE THEN
               CALL afat470_conf_upd_faba() RETURNING l_success
 
            END IF
            IF l_success = TRUE THEN 
               LET l_today  = cl_get_current()
               #检查完毕，更新狀態碼=已確認,確認人=登入user,確認日期=g_today
               UPDATE faba_t SET fabastus = 'Y',
                                 fabacnfid = g_user,
                                 fabacnfdt = l_today
                           WHERE fabaent = g_enterprise
                             AND fabadocno = g_faba_m.fabadocno
                IF SQLCA.SQLCODE THEN
                   LET l_success = FALSE
                   #150731-00004#1 20150826 str---
                   #CALL cl_errmsg('fabastus',g_faba_m.fabadocno,'Y',sqlca.sqlcode,1)
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = sqlca.sqlcode
                   LET g_errparam.extend = 'fabastus：'||g_faba_m.fabadocno
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   #150731-00004#1 20150826 end--- 
                END IF 
            END IF    
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
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            IF g_faba_m.fabastus != 'N' THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('void',g_faba_m.fabadocno,'','afa-00049',1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'afa-00049'
               LET g_errparam.extend = 'void：'||g_faba_m.fabadocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end--- 
               LET l_success = FALSE     
            END IF
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
      AND lc_state <> "S"
      AND lc_state <> "X"
      ) OR 
      g_faba_m.fabastus = lc_state OR cl_null(lc_state) THEN
      CLOSE afat470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#1 add start ------------------
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
         RETURN
      END IF
   END IF
   #151125-00001#1 add end   ------------------
   IF l_success = FALSE  THEN
      #CALL cl_err_showmsg()        #150731-00004#1 20150826 mark
      CALL cl_err_collect_show()    #150731-00004#1 20150826 add
      CALL s_transaction_end('N','0') 
      RETURN    
   ELSE
      CALL s_transaction_end('Y','0')    
   END IF 
   #end add-point
   
   LET g_faba_m.fabamodid = g_user
   LET g_faba_m.fabamoddt = cl_get_current()
   LET g_faba_m.fabastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE faba_t 
      SET (fabastus,fabamodid,fabamoddt) 
        = (g_faba_m.fabastus,g_faba_m.fabamodid,g_faba_m.fabamoddt)     
    WHERE fabaent = g_enterprise AND fabadocno = g_faba_m.fabadocno
 
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afat470_master_referesh USING g_faba_m.fabadocno INTO g_faba_m.fabasite,g_faba_m.faba001, 
          g_faba_m.fabacomp,g_faba_m.faba004,g_faba_m.faba005,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno, 
          g_faba_m.fabadocdt,g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaowndp,g_faba_m.fabacrtid, 
          g_faba_m.fabacrtdp,g_faba_m.fabacrtdt,g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid, 
          g_faba_m.fabacnfdt,g_faba_m.fabasite_desc,g_faba_m.faba001_desc,g_faba_m.fabacomp_desc,g_faba_m.faba004_desc, 
          g_faba_m.faba005_desc,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp_desc,g_faba_m.fabacrtid_desc, 
          g_faba_m.fabacrtdp_desc,g_faba_m.fabamodid_desc,g_faba_m.fabacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc,g_faba_m.faba001,g_faba_m.faba001_desc, 
          g_faba_m.fabacomp,g_faba_m.fabacomp_desc,g_faba_m.faba004,g_faba_m.faba004_desc,g_faba_m.faba005, 
          g_faba_m.faba005_desc,g_faba_m.faba006,g_faba_m.faba003,g_faba_m.fabadocno,g_faba_m.fabadocdt, 
          g_faba_m.fabastus,g_faba_m.fabaownid,g_faba_m.fabaownid_desc,g_faba_m.fabaowndp,g_faba_m.fabaowndp_desc, 
          g_faba_m.fabacrtid,g_faba_m.fabacrtid_desc,g_faba_m.fabacrtdp,g_faba_m.fabacrtdp_desc,g_faba_m.fabacrtdt, 
          g_faba_m.fabamodid,g_faba_m.fabamodid_desc,g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfid_desc, 
          g_faba_m.fabacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   SELECT fabamodid,fabamoddt,fabacnfid,fabacnfdt INTO
     g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfdt FROM faba_t
   WHERE fabaent = g_enterprise AND fabadocno = g_faba_m.fabadocno
   DISPLAY BY NAME g_faba_m.fabamodid,g_faba_m.fabamoddt,g_faba_m.fabacnfid,g_faba_m.fabacnfdt
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_faba_m.fabastus NOT MATCHES "[NDR]" THEN  
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF lc_state = 'Y' THEN 
      LET la_param.prog = 'afai100'
      LET la_param.param[6] = g_faba_m.fabadocno
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js) 
   END IF  
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afat470_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afat470_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat470.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afat470_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fabl_d.getLength() THEN
         LET g_detail_idx = g_fabl_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabl_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabl_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fabl2_d.getLength() THEN
         LET g_detail_idx = g_fabl2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fabl2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fabl2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afat470_b_fill2(pi_idx)
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
   
   CALL afat470_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afat470_fill_chk(ps_idx)
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
 
{<section id="afat470.status_show" >}
PRIVATE FUNCTION afat470_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afat470.mask_functions" >}
&include "erp/afa/afat470_mask.4gl"
 
{</section>}
 
{<section id="afat470.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afat470_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL afat470_show()
   CALL afat470_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_faba_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fabl_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fabl2_d))
 
 
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
   #CALL afat470_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afat470_ui_headershow()
   CALL afat470_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afat470_draw_out()
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
   CALL afat470_ui_headershow()  
   CALL afat470_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afat470.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afat470_set_pk_array()
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
   LET g_pk_array[1].values = g_faba_m.fabadocno
   LET g_pk_array[1].column = 'fabadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat470.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afat470.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afat470_msgcentre_notify(lc_state)
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
   CALL afat470_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_faba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afat470.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afat470_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#9     2016/08/29 By 07900  --add--s--
   SELECT fabastus INTO g_faba_m.fabastus
     FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno = g_faba_m.fabadocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_faba_m.fabastus
       
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
        LET g_errparam.extend =  g_faba_m.fabadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL afat470_set_act_visible()
        CALL afat470_set_act_no_visible()
        CALL afat470_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#9     2016/08/29 By 07900  --add--e--
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afat470.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 帳務人員說明
# Memo...........:
# Usage..........: CALL afat470_get_faba001_desc()
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_faba001_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faba_m.faba001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_faba_m.faba001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faba_m.faba001_desc
END FUNCTION

################################################################################
# Descriptions...: 資產中心說明
# Memo...........:
# Usage..........: CALL afat470_get_fabasite_desc()
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_fabasite_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_faba_m.fabasite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_faba_m.fabasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_faba_m.fabasite_desc
END FUNCTION

################################################################################
# Descriptions...: 預設
# Memo...........:
# Usage..........: CALL afat470_default()
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_default()
   LET g_faba_m.faba001 = g_user
   CALL afat470_get_faba001_desc() 
   DISPLAY BY NAME g_faba_m.faba001,g_faba_m.faba001_desc
   
#   SELECT DISTINCT faab002 INTO g_faba_m.fabasite FROM faab_t  
#     WHERE faab004 IN (SELECT ooag004 FROM ooag_t WHERE ooag001 = g_faba_m.faba001 AND ooagstus = 'Y')
#       AND faab007 ='Y' AND faabstus ='Y' AND faab001 = '4'
#     ORDER BY faab002
#     
#20141121 mod--str-- by chenying
#   LET g_faba_m.fabasite=g_site
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'5',g_today) RETURNING g_sub_success,g_faba_m.fabasite,g_errno
      
      
      #所屬法人
      SELECT ooef017 INTO g_faba_m.fabacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_faba_m.fabasite
         AND ooefstus = 'Y'  
      CALL afat470_fabacomp_desc() 
#20141121 mod--end-- by chenying
   CALL afat470_get_fabasite_desc()
   DISPLAY BY NAME g_faba_m.fabasite,g_faba_m.fabasite_desc   
     
   LET g_faba_m.fabadocdt = g_today  
END FUNCTION

################################################################################
# Descriptions...: 財編檢查
# Memo...........:
# Usage..........: CALL afat470_fabl001_chk()
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_fabl001_chk()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_faah015   LIKE faah_t.faah015
   DEFINE l_faah042   LIKE faah_t.faah042
   DEFINE l_faah028   LIKE faah_t.faah028
   DEFINE l_faah020   LIKE faah_t.faah020   
   DEFINE l_faab004   LIKE faab_t.faab004
   DEFINE l_fabl003   LIKE fabl_t.fabl003
   DEFINE l_fabl002   LIKE fabl_t.fabl002
   DEFINE l_fabl001   LIKE fabl_t.fabl001
   DEFINE l_fabl009   LIKE fabl_t.fabl009
   DEFINE l_ooef017   LIKE ooef_t.ooef017
   DEFINE l_ooef017_1 LIKE ooef_t.ooef017
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_sql       STRING   

   LET g_errno=""
   
   #检查财编是否已经合并
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM faba_t,fabl_t
    WHERE fabaent = fablent
      AND fabaent = g_enterprise
      AND fabadocno <> g_faba_m.fabadocno
      AND fabadocno = fabldocno
      AND fabastus = 'Y'
      AND fabl001 = g_fabl_d[l_ac].fabl001
   IF l_cnt > 0 THEN 
      LET g_errno = 'afa-00253'
      RETURN 
   END IF 
  ##########################################################huangtao mark 
  # #若不是開窗，直接輸入欄位時，需默認帶出相應的卡片+附號
  # #當前合併單中未使用的資料                  
  # IF cl_null(g_fabl_d[l_ac].fabl003) AND cl_null(g_fabl_d[l_ac].fabl002) 
  #    AND NOT cl_null(g_fabl_d[l_ac].fabl001) THEN 
  #    LET l_sql = " SELECT faah001,faah003,faah004 FROM faah_t ",
  #                "  WHERE faahent = '",g_enterprise,"'",  
  #                "    AND faah003 = '",g_fabl_d[l_ac].fabl001,"'", 
  #                "    AND faah015 = '0' ",
  #                "  ORDER BY faah001,faah003,faah004 "
  #    PREPARE afat470_faah_pb FROM l_sql
  #    DECLARE afat470_faah_cs CURSOR FOR afat470_faah_pb
  #    LET l_flag=FALSE #記錄是否抓取到合適資料  
  #    
  #    FOREACH afat470_faah_cs INTO l_fabl003,l_fabl001,l_fabl002 
  #       IF SQLCA.sqlcode THEN
  #          LET g_errno=SQLCA.sqlcode
  #          EXIT FOREACH
  #       END IF             
  #       LET l_cnt = 0
  #       SELECT COUNT(*) INTO l_cnt FROM fabl_t 
  #        WHERE fablent = g_enterprise
  #          AND fabldocno = g_faba_m.fabadocno
  #          AND fabl001 = l_fabl001 
  #          AND fabl002 = l_fabl002
  #          AND fabl003 = l_fabl003
  #          AND fablseq <>g_fabl_d[l_ac].fablseq
  #       IF l_cnt>0 THEN 
  #          CONTINUE FOREACH
  #       ELSE 
  #          LET l_flag=TRUE
  #          LET g_fabl_d[l_ac].fabl002 = l_fabl002
  #          LET g_fabl_d[l_ac].fabl003 = l_fabl003
  #          EXIT FOREACH
  #       END IF 
  #    END FOREACH  
  #    IF l_flag=FALSE THEN  #排除輸入的不符合條件的資料
  #       LET g_errno = 'afa-00165'
  #       RETURN
  #    END IF    
  # END IF
  #########################################################huangtao mark   
#   IF NOT cl_null(g_fabl_d[l_ac].fabl001) AND NOT cl_null(g_fabl_d[l_ac].fabl002) AND  
#      NOT cl_null(g_fabl_d[l_ac].fabl003) THEN 
   IF cl_null(g_fabl_d[l_ac].fabl002) THEN
      LET g_fabl_d[l_ac].fabl002 = ' '
   END IF
   IF NOT cl_null(g_fabl_d[l_ac].fabl001) THEN
      #當前合併單 財產編號不可重複
       LET l_cnt = 0
       SELECT COUNT(*) INTO l_cnt FROM fabl_t
        WHERE fablent   = g_enterprise
          AND fabldocno = g_faba_m.fabadocno
          AND fabl001   = g_fabl_d[l_ac].fabl001 
          AND fablseq  <> g_fabl_d[l_ac].fablseq
       IF l_cnt>0 THEN
          LET g_errno= 'afa-00269'
          RETURN
       END IF 
   ELSE
      RETURN
   END IF
   IF  NOT cl_null(g_fabl_d[l_ac].fabl003) THEN  
      #卡片+财编+附號需存在於faah_t固定資產基礎資料檔中   
      SELECT faah015,faah042,faah028,faah020 
        INTO l_faah015,l_faah042,l_faah028,l_faah020 
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = g_fabl_d[l_ac].fabl001
         AND faah004 = g_fabl_d[l_ac].fabl002 
         AND faah001 = g_fabl_d[l_ac].fabl003
         
      IF SQLCA.SQLCODE = 100 THEN 
         LET g_errno= 'afa-00076'
         RETURN
      END IF
      
#      #所有組織faah028的歸屬法人 需與 資金中心包含的法人且包含賬務人員的歸屬法人 一樣
#      SELECT faab004 INTO l_faab004 FROM faab_t
#       WHERE faab001 = '4'  #資產中心類型
#         AND faab002 = g_faba_m.fabasite 
#         AND faab007 = 'Y'  #現行版本
#         AND faabent = g_enterprise
#         AND faab004 IN (SELECT ooag004 FROM ooag_t 
#                          WHERE ooagent = g_enterprise AND ooag001 = g_faba_m.faba001 
#                            AND ooagstus = 'Y')
                            
      #所有組織的歸屬法人
      SELECT ooef017 INTO l_ooef017 FROM ooef_t 
       WHERE ooefent = g_enterprise
         AND ooef001 = l_faah028
      
      SELECT ooef017 INTO l_ooef017_1 
        FROM ooef_t 
       WHERE ooefent = g_enterprise
         AND ooef001 = g_faba_m.fabasite       
      IF l_ooef017 != l_ooef017_1 THEN 
         LET g_errno='afa-00163'
         RETURN
      END IF  
     ####################################huangtao mark##############
     #IF g_fabl_d[l_ac].fabl001 != g_fabl_d_t.fabl001 OR cl_null(g_fabl_d_t.fabl001) 
     #OR g_fabl_d[l_ac].fabl002 != g_fabl_d_t.fabl002 
     #OR g_fabl_d[l_ac].fabl003 != g_fabl_d_t.fabl003 THEN 
     #   #當前合併單，卡片+財產編號+附號不可重複
     #   LET l_cnt = 0
     #   SELECT COUNT(*) INTO l_cnt FROM fabl_t
     #    WHERE fablent   = g_enterprise
     #      AND fabldocno = g_faba_m.fabadocno
     #      AND fabl001   = g_fabl_d[l_ac].fabl001 
     #      AND fabl002   = g_fabl_d[l_ac].fabl002
     #      AND fabl003   = g_fabl_d[l_ac].fabl003
     #      AND fablseq  <> g_fabl_d[l_ac].fablseq
     #   IF l_cnt>0 THEN
     #      LET g_errno= 'afa-00164'
     #      RETURN
     #   END IF 
     #END IF 
     #####################################huangtao mark################
      #財產狀態不可為5：出售、6：銷賬、8：停用、10：被資本化
   IF l_faah015='5' OR l_faah015='6' OR l_faah015='8' OR l_faah015='10'  THEN
         LET g_errno='afa-01004'
         RETURN
      END IF
      
      #資產屬性需為1:自由才能合併
      IF l_faah042 != '1' THEN 
         LET g_errno='afa-00162'
         RETURN
      END IF
      
      #幣別不同不可合併
      SELECT DISTINCT fabl009 INTO l_fabl009 FROM fabl_t
       WHERE fablent   = g_enterprise
         AND fabldocno = g_faba_m.fabadocno
      IF NOT cl_null(l_fabl009) THEN 
         IF l_fabl009 != l_faah020 THEN 
            LET g_errno='afa-00166'
            RETURN
         END IF
      END IF     
   END IF   
 

END FUNCTION

################################################################################
# Descriptions...: faah
# Memo...........:
# Usage..........: CALL afat470_get_faah()
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_faah()
DEFINE l_ooef017     LIKE ooef_t.ooef017
DEFINE l_ooag004     LIKE ooag_t.ooag004
DEFINE l_glaald      LIKE glaa_t.glaald

   #類型、主要類型、規格、數量、資產性質、資產屬性、幣別、
   #原幣金額、本幣金額、管理組織、所有組織，核算組織
   ############################################huangtao add
   IF cl_null(g_fabl_d[l_ac].fabl001) OR cl_null(g_fabl_d[l_ac].fabl003) THEN
      RETURN 
   END IF
   IF cl_null(g_fabl_d[l_ac].fabl002) THEN
      LET g_fabl_d[l_ac].fabl002 = ' '
   END IF
   ############################################huangtao add
   SELECT faah002,faah006,faah013,faah018,faah005,faah042,faah020,
          faah022,faah030,faah028,faah031,faah012,faah013  #160426-00014#23 add faah012,faah013
     INTO g_fabl_d[l_ac].fabl017,g_fabl_d[l_ac].fabl004,g_fabl_d[l_ac].fabl005,g_fabl_d[l_ac].fabl006,
          g_fabl_d[l_ac].fabl007,g_fabl_d[l_ac].fabl008,g_fabl_d[l_ac].fabl009,
          g_fabl_d[l_ac].fabl011,g_fabl_d[l_ac].fabl013,
          g_fabl_d[l_ac].fabl014,g_fabl_d[l_ac].fabl015,g_fabl_d[l_ac].faah012,g_fabl_d[l_ac].faah013 #160426-00014#23 add g_fabl_d[l_ac].faah012,g_fabl_d[l_ac].faah013
     FROM faah_t
    WHERE faahent = g_enterprise
      AND faah003 = g_fabl_d[l_ac].fabl001
      AND faah004 = g_fabl_d[l_ac].fabl002 
      AND faah001 = g_fabl_d[l_ac].fabl003  
      
   #主要類型說明   
   CALL afat470_get_fabl004_desc()   

#   #匯率
#   SELECT ooag004 INTO l_ooag004
#     FROM ooag_t
#    WHERE ooagent = g_enterprise
#      AND ooag001 = g_faba_m.faba001
#   
#   SELECT ooef017 INTO l_ooef017 
#     FROM ooef_t
#    WHERE ooefent = g_enterprise
#      AND ooef001 = l_ooag004
   
   SELECT glaa001,glaald,glaa025
     INTO g_glaa001,g_glaald,g_glaa025
     FROM glaa_t
    WHERE glaaent = g_enterprise
#      AND glaacomp = l_ooef017
      AND glaacomp = g_faba_m.fabacomp
      AND glaa014 = 'Y'
   
   CALL afat470_get_rate(g_glaald,g_fabl_d[l_ac].fabl009,g_glaa001,g_glaa025)  
   
   LET g_fabl_d[l_ac].fabl010 = g_ooan005
   
   #获取法人组织对应主帐套
   SELECT glaald INTO l_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_faba_m.fabacomp
      AND glaa014 = 'Y'
   #获取主帐套减值准备，未折减额,本位币二、三等资料
   SELECT faaj017,faaj028,faaj021-faaj027,faaj101,faaj102,faaj103,faaj104,faaj108,faaj112-faaj110,
          faaj151,faaj152,faaj153,faaj154,faaj158,faaj160,faaj162-faaj160
     INTO g_fabl_d[l_ac].fabl012,g_fabl_d[l_ac].fabl016,g_fabl_d[l_ac].fabl019,g_fabl_d[l_ac].fabl101,
          g_fabl_d[l_ac].fabl102,g_fabl_d[l_ac].fabl103,g_fabl_d[l_ac].fabl104,
          g_fabl_d[l_ac].fabl105,g_fabl_d[l_ac].fabl106,
          g_fabl_d[l_ac].fabl201, g_fabl_d[l_ac].fabl202,g_fabl_d[l_ac].fabl203,g_fabl_d[l_ac].fabl204,
          g_fabl_d[l_ac].fabl205,g_fabl_d[l_ac].fabl206
     FROM faaj_t
    WHERE faajent = g_enterprise
      AND faaj001 = g_fabl_d[l_ac].fabl001
      AND faaj002 = g_fabl_d[l_ac].fabl002 
      AND faaj037 = g_fabl_d[l_ac].fabl003  
      AND faajld = l_glaald
      
   DISPLAY BY NAME g_fabl_d[l_ac].fabl017,g_fabl_d[l_ac].fabl004,g_fabl_d[l_ac].fabl005,g_fabl_d[l_ac].fabl006,
                   g_fabl_d[l_ac].fabl007,g_fabl_d[l_ac].fabl008,g_fabl_d[l_ac].fabl009,
                   g_fabl_d[l_ac].fabl011,g_fabl_d[l_ac].fabl012,g_fabl_d[l_ac].fabl013,
                   g_fabl_d[l_ac].fabl014,g_fabl_d[l_ac].fabl004_desc,g_fabl_d[l_ac].fabl010
                   
END FUNCTION

################################################################################
# Descriptions...: 匯率
# Memo...........:
# Usage..........: CALL afat470_get_rate(p_ld,p_ooan002,p_glaa001,p_glaa025)
# Input parameter:  
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_rate(p_ld,p_ooan002,p_glaa001,p_glaa025)
   DEFINE p_ld           LIKE glaa_t.glaald
   DEFINE p_glaa001      LIKE glaa_t.glaa001
   DEFINE p_glaa025      LIKE glaa_t.glaa025
   DEFINE p_ooan002      LIKE ooan_t.ooan002
   
   LET g_ooan005 = NULL
                            #     帳套; 日期;   來源幣別
   CALL s_aooi160_get_exrate('2',p_ld,g_today,p_ooan002,
                         #目的幣別;  交易金額;  匯類類型
                          p_glaa001,0,p_glaa025)
   RETURNING g_ooan005
   
END FUNCTION

################################################################################
# Descriptions...: 主要類型說明
# Memo...........:
# Usage..........: CALL afat470_get_fabl004_desc()
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_fabl004_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabl_d[l_ac].fabl004
            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabl_d[l_ac].fabl004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabl_d[l_ac].fabl004_desc
END FUNCTION

################################################################################
# Descriptions...: 單身預設
# Memo...........:
# Usage..........: CALL afat470_detail_def(p_fabm005)
# Input parameter: 
# Date & Author..: 2014/8/12 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_detail_def(p_fabm005)
DEFINE p_fabm005    LIKE fabm_t.fabm005
DEFINE l_fabl001    LIKE fabl_t.fabl001
DEFINE l_fabl002    LIKE fabl_t.fabl002
DEFINE l_fabl003    LIKE fabl_t.fabl003

   LET g_sql = " SELECT fabl001,fabl002,fabl003 FROM fabl_t ",
               "  WHERE fablent = '",g_enterprise,"'",
               "    AND fabldocno = '",g_faba_m.fabadocno,"'",
               "    AND fabl017 = '",p_fabm005,"'"
               
   PREPARE afat470_fabl_pb FROM g_sql
   DECLARE afat470_fabl_cs CURSOR FOR afat470_fabl_pb  

   FOREACH afat470_fabl_cs INTO l_fabl001,l_fabl002,l_fabl003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach fabl:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF NOT cl_null(l_fabl001) THEN
         RETURN l_fabl001,l_fabl002,l_fabl003  
         EXIT FOREACH
      ELSE
         CONTINUE FOREACH
      END IF   
   END FOREACH
   
   RETURN l_fabl001,l_fabl002,l_fabl003          
END FUNCTION

################################################################################
# Descriptions...: conf chk
# Memo...........:
# Usage..........: CALL afat470_conf_chk_faba()
# Input parameter:  
# Date & Author..: 2014/8/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_conf_chk_faba()
DEFINE r_success           LIKE type_t.num5
DEFINE l_n1                LIKE type_t.num5
DEFINE l_n2                LIKE type_t.num5
DEFINE l_cnt               LIKE type_t.num5
DEFINE l_fabastus          LIKE faba_t.fabastus
DEFINE l_faahstus          LIKE faah_t.faahstus
DEFINE l_fabl001           LIKE fabl_t.fabl001
DEFINE l_fabl002           LIKE fabl_t.fabl002
DEFINE l_fabl003           LIKE fabl_t.fabl003
DEFINE  l_para_data           LIKE faba_t.fabadocdt

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET l_n1 = 0
   LET l_n2 = 0
   LET l_cnt = 0

   CALL cl_get_para(g_enterprise,g_faba_m.fabacomp,'S-FIN-9003') RETURNING l_para_data
   IF NOT cl_null(l_para_data) AND g_faba_m.fabadocdt <= l_para_data THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "afa-00060"
      LET g_errparam.extend = g_faba_m.fabadocdt
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
        
            
   SELECT fabastus INTO l_fabastus FROM faba_t WHERE fabaent=g_enterprise AND fabadocno=g_faba_m.fabadocno
   #狀態碼=未審核,才可進行確認動作   
   IF l_fabastus <> 'N' THEN
      LET r_success = FALSE
#      CALL cl_errmsg('fabastus',g_faba_m.fabadocno,'','afa-00024',1)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_faba_m.fabadocno
      LET g_errparam.code   = 'afa-00024'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()     
      RETURN r_success
   END IF 
   
   #單身一:合併明細是否有資料
   SELECT COUNT(*) INTO l_n1 FROM fabl_t 
    WHERE fablent = g_enterprise
      AND fabldocno = g_faba_m.fabadocno
      
   IF l_n1 = 0 THEN 
      LET r_success = FALSE
#      CALL cl_errmsg('',g_faba_m.fabadocno,'','afa-00168',1)   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_faba_m.fabadocno
      LET g_errparam.code   = 'afa-00168'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()       
      RETURN r_success
   END IF
   
   #單身二:合併是否有資料
   SELECT COUNT(*) INTO l_n2 FROM fabm_t 
    WHERE fabment = g_enterprise
      AND fabmdocno = g_faba_m.fabadocno
   IF l_n2 = 0 THEN  
      LET r_success = FALSE
#      CALL cl_errmsg('',g_faba_m.fabadocno,'','afa-00168',1)   
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_faba_m.fabadocno
      LET g_errparam.code   = 'afa-00168'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()       
      RETURN r_success
   END IF  
   #检查单身二财编和附号是否都存在
   CALL afat470_fabm001_chk() RETURNING r_success
   IF NOT r_success THEN 
      RETURN r_success
   END IF 
   #單身一財編是否有效
   LET g_sql = " SELECT fabl001,fabl002,fabl003 ",
               "   FROM fabl_t",
               "  WHERE fablent = '",g_enterprise,"'",
               "    AND fabldocno = '",g_faba_m.fabadocno,"'"
                 
   PREPARE afat470_fabl_pb3 FROM g_sql
   DECLARE afat470_fabl_cs3 CURSOR FOR afat470_fabl_pb3   
   FOREACH afat470_fabl_cs3 INTO l_fabl001,l_fabl002,l_fabl003
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('foreach: fabl3','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach: fabl3'
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         LET r_success = FALSE         
         EXIT FOREACH
      END IF 
      SELECT faahstus INTO l_faahstus FROM faah_t
       WHERE faahent = g_enterprise
         AND faah003 = l_fabl001
         AND faah004 = l_fabl002
         AND faah001 = l_fabl003
      IF l_faahstus = 'X' THEN
#         CALL cl_errmsg('faahstus',l_fabl001,'Y','afa-00175',1)
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_fabl001
         LET g_errparam.code   = 'afa-00175'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()         
         LET r_success = FALSE         
         EXIT FOREACH         
      END IF      
      #检查财编是否已经合并
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM faba_t,fabl_t
       WHERE fabaent = fablent
         AND fabaent = g_enterprise
         AND fabadocno <> g_faba_m.fabadocno
         AND fabadocno = fabldocno
         AND fabastus = 'Y'
         AND fabl001 = l_fabl001
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_fabl001
         LET g_errparam.code   = 'afa-00253'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE         
         EXIT FOREACH  
      END IF 
   END FOREACH 
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 確認處理
# Memo...........:
# Usage..........: CALL afat470_conf_upd_faba()
# Input parameter:  
# Date & Author..: 2014/8/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_conf_upd_faba()
DEFINE r_success   LIKE type_t.num5
#161111-00028#7---modify--begin-----------
#DEFINE l_faah      RECORD LIKE faah_t.*
#DEFINE l_faaj      RECORD LIKE faaj_t.*
DEFINE l_faah RECORD  #固定資產基礎資料檔
       faahent LIKE faah_t.faahent, #企業編號
       faah000 LIKE faah_t.faah000, #產生批號
       faah001 LIKE faah_t.faah001, #卡片編號
       faah002 LIKE faah_t.faah002, #型態
       faah003 LIKE faah_t.faah003, #財產編號
       faah004 LIKE faah_t.faah004, #附號
       faah005 LIKE faah_t.faah005, #資產性質
       faah006 LIKE faah_t.faah006, #資產主要類型
       faah007 LIKE faah_t.faah007, #資產次要類型
       faah008 LIKE faah_t.faah008, #資產組
       faah009 LIKE faah_t.faah009, #供應供應商
       faah010 LIKE faah_t.faah010, #製造供應商
       faah011 LIKE faah_t.faah011, #產地
       faah012 LIKE faah_t.faah012, #名稱
       faah013 LIKE faah_t.faah013, #規格型號
       faah014 LIKE faah_t.faah014, #取得日期
       faah015 LIKE faah_t.faah015, #資產狀態
       faah016 LIKE faah_t.faah016, #取得方式
       faah017 LIKE faah_t.faah017, #單位
       faah018 LIKE faah_t.faah018, #數量
       faah019 LIKE faah_t.faah019, #在外數量
       faah020 LIKE faah_t.faah020, #幣別
       faah021 LIKE faah_t.faah021, #原幣單價
       faah022 LIKE faah_t.faah022, #原幣金額
       faah023 LIKE faah_t.faah023, #本幣單價
       faah024 LIKE faah_t.faah024, #本幣金額
       faah025 LIKE faah_t.faah025, #保管人員
       faah026 LIKE faah_t.faah026, #保管部門
       faah027 LIKE faah_t.faah027, #存放位置
       faah028 LIKE faah_t.faah028, #存放組織
       faah029 LIKE faah_t.faah029, #負責人員
       faah030 LIKE faah_t.faah030, #管理組織
       faah031 LIKE faah_t.faah031, #核算組織
       faah032 LIKE faah_t.faah032, #歸屬法人
       faah033 LIKE faah_t.faah033, #直接資本化
       faah034 LIKE faah_t.faah034, #保稅
       faah035 LIKE faah_t.faah035, #保險
       faah036 LIKE faah_t.faah036, #免稅
       faah037 LIKE faah_t.faah037, #抵押
       faah038 LIKE faah_t.faah038, #採購單號
       faah039 LIKE faah_t.faah039, #收貨單號
       faah040 LIKE faah_t.faah040, #帳款單號
       faah041 LIKE faah_t.faah041, #來源營運中心
       faah042 LIKE faah_t.faah042, #資產屬性
       faah043 LIKE faah_t.faah043, #預計總工作量
       faah044 LIKE faah_t.faah044, #已使用工作量
       faah045 LIKE faah_t.faah045, #帳款編號項次
       faahownid LIKE faah_t.faahownid, #資料所有者
       faahowndp LIKE faah_t.faahowndp, #資料所屬部門
       faahcrtid LIKE faah_t.faahcrtid, #資料建立者
       faahcrtdp LIKE faah_t.faahcrtdp, #資料建立部門
       faahcrtdt LIKE faah_t.faahcrtdt, #資料創建日
       faahmodid LIKE faah_t.faahmodid, #資料修改者
       faahmoddt LIKE faah_t.faahmoddt, #最近修改日
       faahstus LIKE faah_t.faahstus, #狀態碼
       faah046 LIKE faah_t.faah046, #備註
       faah047 LIKE faah_t.faah047, #保稅機器擷取否
       faah048 LIKE faah_t.faah048, #投資抵減狀態
       faah049 LIKE faah_t.faah049, #投資抵減合併碼
       faah050 LIKE faah_t.faah050, #抵減率
       faah051 LIKE faah_t.faah051, #投資抵減用途
       faah052 LIKE faah_t.faah052, #抵減金額
       faah053 LIKE faah_t.faah053, #已抵減金額
       faah054 LIKE faah_t.faah054, #投資抵減否
       faah055 LIKE faah_t.faah055, #投資抵減年限
       faah056 LIKE faah_t.faah056  #免稅狀態
       END RECORD

DEFINE l_faaj RECORD  #固定資產帳套折舊資訊資料檔
       faajent LIKE faaj_t.faajent, #企業編碼
       faajld LIKE faaj_t.faajld, #帳套別編碼
       faajsite LIKE faaj_t.faajsite, #營運據點
       faaj000 LIKE faaj_t.faaj000, #批號
       faaj001 LIKE faaj_t.faaj001, #財產編號
       faaj002 LIKE faaj_t.faaj002, #附號
       faaj003 LIKE faaj_t.faaj003, #折舊方式
       faaj004 LIKE faaj_t.faaj004, #耐用年限(月數)
       faaj005 LIKE faaj_t.faaj005, #未使用年限(月數)
       faaj006 LIKE faaj_t.faaj006, #分攤方式
       faaj007 LIKE faaj_t.faaj007, #分攤類別
       faaj008 LIKE faaj_t.faaj008, #開始折舊年月
       faaj009 LIKE faaj_t.faaj009, #最近折舊年度
       faaj010 LIKE faaj_t.faaj010, #最近折舊期別
       faaj011 LIKE faaj_t.faaj011, #折畢再提
       faaj012 LIKE faaj_t.faaj012, #折畢再提預留殘值
       faaj013 LIKE faaj_t.faaj013, #折畢再提預留年月（數）
       faaj014 LIKE faaj_t.faaj014, #幣別
       faaj015 LIKE faaj_t.faaj015, #匯率
       faaj016 LIKE faaj_t.faaj016, #成本
       faaj017 LIKE faaj_t.faaj017, #累折
       faaj018 LIKE faaj_t.faaj018, #本期累折
       faaj019 LIKE faaj_t.faaj019, #預留殘值
       faaj020 LIKE faaj_t.faaj020, #調整成本
       faaj021 LIKE faaj_t.faaj021, #已提列減值準備
       faaj022 LIKE faaj_t.faaj022, #年折舊額
       faaj023 LIKE faaj_t.faaj023, #資產科目
       faaj024 LIKE faaj_t.faaj024, #累折科目
       faaj025 LIKE faaj_t.faaj025, #折舊科目
       faaj026 LIKE faaj_t.faaj026, #減值準備科目
       faaj027 LIKE faaj_t.faaj027, #銷帳減值準備
       faaj028 LIKE faaj_t.faaj028, #未折減額
       faaj029 LIKE faaj_t.faaj029, #第一個月未折減額
       faaj030 LIKE faaj_t.faaj030, #帳款編號
       faaj031 LIKE faaj_t.faaj031, #帳款編號項次
       faaj032 LIKE faaj_t.faaj032, #本期處置累折
       faaj033 LIKE faaj_t.faaj033, #處置數量
       faaj034 LIKE faaj_t.faaj034, #處置成本
       faaj035 LIKE faaj_t.faaj035, #處置累折
       faaj036 LIKE faaj_t.faaj036, #交易價格差異
       faaj037 LIKE faaj_t.faaj037, #卡片編號
       faaj038 LIKE faaj_t.faaj038, #資產狀態
       faaj039 LIKE faaj_t.faaj039, #部門
       faaj040 LIKE faaj_t.faaj040, #利潤/成本中心
       faaj041 LIKE faaj_t.faaj041, #區域
       faaj042 LIKE faaj_t.faaj042, #交易客商
       faaj043 LIKE faaj_t.faaj043, #帳款客商
       faaj044 LIKE faaj_t.faaj044, #客群
       faaj045 LIKE faaj_t.faaj045, #專案編號
       faaj046 LIKE faaj_t.faaj046, #WBS
       faaj047 LIKE faaj_t.faaj047, #人員
       faaj101 LIKE faaj_t.faaj101, #本位幣二幣別
       faaj102 LIKE faaj_t.faaj102, #本位幣二匯率
       faaj103 LIKE faaj_t.faaj103, #本位幣二成本
       faaj104 LIKE faaj_t.faaj104, #本位幣二累折
       faaj105 LIKE faaj_t.faaj105, #本位幣二預留殘值
       faaj106 LIKE faaj_t.faaj106, #本位幣二折畢再提預留殘值
       faaj107 LIKE faaj_t.faaj107, #本位幣二年折舊額
       faaj108 LIKE faaj_t.faaj108, #本位幣二未折減額
       faaj109 LIKE faaj_t.faaj109, #本位幣二第一月未折減額
       faaj110 LIKE faaj_t.faaj110, #本位幣二處置減值準備
       faaj111 LIKE faaj_t.faaj111, #本位幣二本年累折
       faaj112 LIKE faaj_t.faaj112, #本位幣二已提列減值準備
       faaj113 LIKE faaj_t.faaj113, #本位幣二處置成本
       faaj114 LIKE faaj_t.faaj114, #本位幣二處置累折
       faaj115 LIKE faaj_t.faaj115, #本位幣二本期處置累折
       faaj116 LIKE faaj_t.faaj116, #本位幣二交易價格差異
       faaj117 LIKE faaj_t.faaj117, #本位幣二調整成本
       faaj151 LIKE faaj_t.faaj151, #本位幣三幣別
       faaj152 LIKE faaj_t.faaj152, #本位幣三匯率
       faaj153 LIKE faaj_t.faaj153, #本位幣三成本
       faaj154 LIKE faaj_t.faaj154, #本位幣三累折
       faaj155 LIKE faaj_t.faaj155, #本位幣三預留殘值
       faaj156 LIKE faaj_t.faaj156, #本位幣三折畢再提預留殘值
       faaj157 LIKE faaj_t.faaj157, #本位幣三年折舊額
       faaj158 LIKE faaj_t.faaj158, #本位幣三未折減額
       faaj159 LIKE faaj_t.faaj159, #本位幣三第一月未折減額
       faaj160 LIKE faaj_t.faaj160, #本位幣三處置減值準備
       faaj161 LIKE faaj_t.faaj161, #本位幣三本年累折
       faaj162 LIKE faaj_t.faaj162, #本位幣三已提列減值準備
       faaj163 LIKE faaj_t.faaj163, #本位幣三處置成本
       faaj164 LIKE faaj_t.faaj164, #本位幣三處置累折
       faaj165 LIKE faaj_t.faaj165, #本位幣三本期處置累折
       faaj166 LIKE faaj_t.faaj166, #本位幣三交易價格差異
       faaj167 LIKE faaj_t.faaj167, #本位幣三調整成本
       faajownid LIKE faaj_t.faajownid, #資料所有者
       faajowndp LIKE faaj_t.faajowndp, #資料所屬部門
       faajcrtid LIKE faaj_t.faajcrtid, #資料建立者
       faajcrtdp LIKE faaj_t.faajcrtdp, #資料建立部門
       faajcrtdt LIKE faaj_t.faajcrtdt, #資料創建日
       faajmodid LIKE faaj_t.faajmodid, #資料修改者
       faajmoddt LIKE faaj_t.faajmoddt, #最近修改日
       faajstus LIKE faaj_t.faajstus, #狀態碼
       faaj048 LIKE faaj_t.faaj048    #資產分類
       END RECORD

#161111-00028#7---modify--end-----------
DEFINE l_fabl001   LIKE fabl_t.fabl001
DEFINE l_fabl002   LIKE fabl_t.fabl002
DEFINE l_fabl003   LIKE fabl_t.fabl003
DEFINE l_faaj001   LIKE faaj_t.faaj001
DEFINE l_faaj002   LIKE faaj_t.faaj002
DEFINE l_faaj037   LIKE faaj_t.faaj037
DEFINE l_faaj016   LIKE faaj_t.faaj016
DEFINE l_faajld    LIKE faaj_t.faajld
DEFINE l_faah002   LIKE faah_t.faah002
DEFINE l_ooam003   LIKE ooam_t.ooam003
DEFINE l_test      LIKE type_t.num5


   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   CALL afat470_create_tmp()
   
   #1、更新合併財編明細資料為無效
   LET g_sql = " SELECT fabl001,fabl002,fabl003 ",
               "   FROM fabl_t",
               "  WHERE fablent = '",g_enterprise,"'",
               "    AND fabldocno = '",g_faba_m.fabadocno,"'"
                 
   PREPARE afat470_fabl_pb1 FROM g_sql
   DECLARE afat470_fabl_cs1 CURSOR FOR afat470_fabl_pb1
   
   
   #2、新增合併財編faah
   LET g_sql = " SELECT fabm001,fabm002,fabm003,fabm004,fabm005,fabm006,fabm007,",
               "        fabm008,fabm009,fabm010,fabm011,fabm012,fabm013,fabm014,fabm015,fabm016,fabm017,fabm018, ",
               "        fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206,fabm020", #161009-00007#1 add fabm020
               "   FROM fabm_t",
               "  WHERE fabment = '",g_enterprise,"'",
               "    AND fabmdocno = '",g_faba_m.fabadocno,"'"
                 
   PREPARE afat470_fabm_pb FROM g_sql
   DECLARE afat470_fabm_cs CURSOR FOR afat470_fabm_pb  
   
   
   #3、用於faaj新增
   LET g_sql = " SELECT faaj001,faaj002,faaj037,faajld,faah002,SUM(faaj016) ",
               "   FROM faaj_t LEFT OUTER JOIN faah_t ",
               "     ON faahent = faajent AND faah003 = faaj001 AND faah004 = faaj002",
               "  WHERE faajent = '",g_enterprise,"'",
               "    AND faaj001 = ? AND faaj002 = ? AND faaj037 = ? ",
               "  GROUP BY faaj001,faaj002,faaj037,faajld,faah002"                
   PREPARE afat470_faaj_pb FROM g_sql
   DECLARE afat470_faaj_cs CURSOR FOR afat470_faaj_pb               
   
   
   #1
   FOREACH afat470_fabl_cs1 INTO l_fabl001,l_fabl002,l_fabl003
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('foreach: fabl','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach: fabl'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end--- 
         LET r_success = FALSE         
         EXIT FOREACH
      END IF      
      ####################
      #检查是否存在未审核异动单据
      #CALL cl_showmsg_init()      #150731-00004#1 20150826 mark
      CALL cl_err_collect_init()   #150731-00004#1 20150826 add 
      CALL s_afat503_conf_ins_tab_chk(g_faba_m.fabadocno,'',l_fabl001,l_fabl002,l_fabl003) RETURNING r_success
      IF r_success = FALSE THEN
         #CALL cl_err_showmsg()        #150731-00004#1 20150826 mark
         CALL cl_err_collect_show()    #150731-00004#1 20150826 add
         EXIT FOREACH
      END IF
      ###################
      UPDATE faah_t SET faahstus = 'X'
       WHERE faahent = g_enterprise
         AND faah003 = l_fabl001
         AND faah004 = l_fabl002
         AND faah001 = l_fabl003
         AND faahstus = 'Y'
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('upd faah :','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd faah :'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end--- 
         LET r_success = FALSE   
      END IF   
      
      #161111-00028#3---MODIFY----begin---------
      #SELECT * INTO l_faah.*
       SELECT faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,
              faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,
              faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,
              faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,
              faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,
              faahmoddt,faahstus,faah046,faah047,faah048,faah049,faah050,faah051,faah052,faah053,
              faah054,faah055,faah056 INTO l_faah.*
      #161111-00028#3---MODIFY----end-----------
        FROM faah_t
       WHERE faahent = g_enterprise
         AND faah001 = l_fabl003
         AND faah003 = l_fabl001
         AND faah004 = l_fabl002
      #根據合併明細財編新增tmp
      IF r_success = TRUE THEN 
         FOREACH afat470_faaj_cs USING l_fabl001,l_fabl002,l_fabl003
            INTO l_faaj001,l_faaj002,l_faaj037,l_faajld,l_faah002,l_faaj016
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('foreach faaj:','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'foreach faaj:'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end--- 
               LET r_success = FALSE         
               EXIT FOREACH
            END IF  

            INSERT INTO afat470_tmp VALUES(l_faaj001,l_faaj002,l_faaj037,l_faah002,l_faajld,l_faaj016)
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('ins tmp :','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins tmp :'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end--- 
               LET r_success = FALSE 
            END IF  
            SELECT COUNT(*) INTO l_test FROM afat470_tmp
         END FOREACH
      END IF   
   END FOREACH

   #2
   FOREACH afat470_fabm_cs INTO l_faah.faah003,l_faah.faah004,l_faah.faah001,l_faah.faah006,
                                l_faah.faah002,l_faah.faah013,l_faah.faah018,l_faah.faah005,
                                l_faah.faah042,l_faah.faah020,l_faaj.faaj015,l_faah.faah022,l_faah.faah024,
                                l_faah.faah030,l_faah.faah028,l_faah.faah031,l_faaj.faaj028,l_faaj.faaj027,
                                l_faaj.faaj101,l_faaj.faaj102,l_faaj.faaj103,l_faaj.faaj104,l_faaj.faaj108,
                                l_faaj.faaj110,l_faaj.faaj151,l_faaj.faaj152,l_faaj.faaj153,l_faaj.faaj154,
                                l_faaj.faaj158,l_faaj.faaj160,l_faah.faah012 #161009-00007#1 add l_faah.faah012
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('foreach: fabm','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach: fabm'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end--- 
         LET r_success = FALSE         
         EXIT FOREACH
      END IF                             
        
      #主要類型，帶預設值
      SELECT faac007,faac008,faac009,faac010,faac011,faac016,faac003,faac004
        INTO l_faah.faah033,l_faah.faah034,l_faah.faah035,
             l_faah.faah036,l_faah.faah037,
             g_faac016,g_faac003,g_faac004
        FROM faac_t
       WHERE faacent = g_enterprise
         AND faac001 = l_faah.faah006
      LET l_faah.faahent = g_enterprise
      LET l_faah.faah014 = g_today  #取得日期
      LET l_faah.faah015 = '0'      #資產狀態0:取得
      LET l_faah.faahownid = g_user
      LET l_faah.faahowndp = g_dept
      LET l_faah.faahcrtid = g_user
      LET l_faah.faahcrtdp = g_dept 
      LET l_faah.faahcrtdt = cl_get_current()
      LET l_faah.faahmodid = ""
      LET l_faah.faahmoddt = ""
      LET l_faah.faahstus = 'N'  #未確認，供user修改資料
      LET l_faah.faah000 = ' '
      IF cl_null(l_faah.faah004) THEN 
         LET l_faah.faah004 = ' '
      END IF
      LET l_faah.faah040 = g_faba_m.fabadocno
      LET l_faah.faah016 = '1'
      LET l_faah.faah042 = '1'
      #161111-00028#7---modify--begin-----------
      #INSERT INTO faah_t VALUES(l_faah.*) 
       INSERT INTO faah_t (faahent,faah000,faah001,faah002,faah003,faah004,faah005,faah006,faah007,faah008,faah009,
                           faah010,faah011,faah012,faah013,faah014,faah015,faah016,faah017,faah018,faah019,faah020,
                           faah021,faah022,faah023,faah024,faah025,faah026,faah027,faah028,faah029,faah030,faah031,
                           faah032,faah033,faah034,faah035,faah036,faah037,faah038,faah039,faah040,faah041,faah042,
                           faah043,faah044,faah045,faahownid,faahowndp,faahcrtid,faahcrtdp,faahcrtdt,faahmodid,
                           faahmoddt,faahstus,faah046,faah047,faah048,faah049,faah050,faah051,faah052,faah053,
                           faah054,faah055,faah056)
         VALUES(l_faah.faahent,l_faah.faah000,l_faah.faah001,l_faah.faah002,l_faah.faah003,l_faah.faah004,l_faah.faah005,l_faah.faah006,l_faah.faah007,l_faah.faah008,l_faah.faah009,
                l_faah.faah010,l_faah.faah011,l_faah.faah012,l_faah.faah013,l_faah.faah014,l_faah.faah015,l_faah.faah016,l_faah.faah017,l_faah.faah018,l_faah.faah019,l_faah.faah020,
                l_faah.faah021,l_faah.faah022,l_faah.faah023,l_faah.faah024,l_faah.faah025,l_faah.faah026,l_faah.faah027,l_faah.faah028,l_faah.faah029,l_faah.faah030,l_faah.faah031,
                l_faah.faah032,l_faah.faah033,l_faah.faah034,l_faah.faah035,l_faah.faah036,l_faah.faah037,l_faah.faah038,l_faah.faah039,l_faah.faah040,l_faah.faah041,l_faah.faah042,
                l_faah.faah043,l_faah.faah044,l_faah.faah045,l_faah.faahownid,l_faah.faahowndp,l_faah.faahcrtid,l_faah.faahcrtdp,l_faah.faahcrtdt,l_faah.faahmodid,
                l_faah.faahmoddt,l_faah.faahstus,l_faah.faah046,l_faah.faah047,l_faah.faah048,l_faah.faah049,l_faah.faah050,l_faah.faah051,l_faah.faah052,l_faah.faah053,
                l_faah.faah054,l_faah.faah055,l_faah.faah056)       
      #161111-00028#7---modify--end-----------                            
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('ins faah :','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins faah :'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end--- 
         LET r_success = FALSE         
      END IF  

      #3、通過tmp新增faaj資料
      IF r_success = TRUE THEN  
         #根據類型匯總成本
         LET g_sql = " SELECT faah002,faajld,SUM(faaj016) FROM afat470_tmp ",
                     "  WHERE faah002 = ",l_faah.faah002,
                     "  GROUP BY faah002,faajld " 
         PREPARE afat470_tmp_pb FROM g_sql
         DECLARE afat470_tmp_cs CURSOR FOR afat470_tmp_pb               
         FOREACH afat470_tmp_cs INTO l_faah002,l_faaj.faajld,l_faaj.faaj016
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('foreach tmp:','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'foreach tmp:'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end--- 
               LET r_success = FALSE         
               EXIT FOREACH
            END IF
            
            LET l_faaj.faaj019 = l_faaj.faaj016 * g_faac016/100
            LET l_faaj.faaj003 = g_faac003
            LET l_faaj.faaj004 = g_faac004
            LET l_faaj.faaj011 = 'N'
#mark by yangxf
#            #多本位幣
#            IF NOT cl_null(l_faaj.faajld) THEN 
#               SELECT * INTO g_glaa.* FROM glaa_t
#               WHERE glaaent = g_enterprise
#                 AND glaald = l_faaj.faajld  
#                 
#               IF g_glaa.glaa015 = 'Y' THEN    
#                  #-----本位币二-------
#                  #來源幣別
#                  LET l_ooam003 = ''
#                  IF g_glaa.glaa017 = '1' THEN
#                     LET l_ooam003 = l_faah.faah020
#                  ELSE   #表示帳簿幣別 
#                     LET l_ooam003 = g_glaa.glaa001            #帳套使用幣別
#                  END IF
#                  
#                  LET l_faaj.faaj101 = g_glaa.glaa016
#                                           #匯率參照表;帳套;       日期;    來源幣別
#                  CALL s_aooi160_get_exrate('2',l_faaj.faajld,g_today,l_ooam003,
#                                            #目的幣別;      交易金額; 匯類類型
#                                            l_faaj.faaj101,0,g_glaa.glaa018)
#                  RETURNING l_faaj.faaj102   
#                  
#                  LET l_faaj.faaj103 = l_faah.faah022 * l_faaj.faaj102
#               END IF
#               IF g_glaa.glaa019 = 'Y' THEN      
#                  #-----本位币三-------
#                  LET l_ooam003 = ''
#                  IF g_glaa.glaa021 = '1' THEN
#                     LET l_ooam003 = l_faah.faah020
#                  ELSE   #表示帳簿幣別 
#                     LET l_ooam003 = g_glaa.glaa001            #帳套使用幣別
#                  END IF
#                  LET l_faaj.faaj151 = g_glaa.glaa020
#                                           #匯率參照表;帳套;       日期;    來源幣別
#                  CALL s_aooi160_get_exrate('2',l_faaj.faajld,g_today,l_ooam003,
#                                            #目的幣別;      交易金額; 匯類類型
#                                            l_faaj.faaj151,0,g_glaa.glaa022)
#                  RETURNING l_faaj.faaj152   
#               
#                  LET l_faaj.faaj153 = l_faah.faah022 * l_faaj.faaj152
#               END IF
#            END IF
#mark by yangxf
            LET l_faaj.faajownid = g_user
            LET l_faaj.faajowndp = g_dept
            LET l_faaj.faajcrtid = g_user
            LET l_faaj.faajcrtdp = g_dept 
            LET l_faaj.faajcrtdt = cl_get_current()
            LET l_faaj.faaj030 = g_faba_m.fabadocno
            LET l_faaj.faajmodid = ""
            LET l_faaj.faajmoddt = ""
            IF cl_null(l_faaj.faaj000) THEN 
               LET l_faaj.faaj000 = ' '
            END IF
            IF cl_null(l_faah.faah004) THEN #附號
               LET l_faah.faah004 = ' '
            END IF              
            #获取资产科目，累着科目，折旧科目，减值准备科目
            SELECT glab005 INTO l_faaj.faaj023
              FROM glab_t
             WHERE glabld = l_faaj.faajld
               AND glab002 = l_faah.faah006
               AND glabent = g_enterprise
               AND glab003 = '9901_01'
            SELECT glab005 INTO l_faaj.faaj024
              FROM glab_t
             WHERE glabld = l_faaj.faajld
               AND glab002 = l_faah.faah006
               AND glabent = g_enterprise
               AND glab003 = '9901_02'
            SELECT glab005 INTO l_faaj.faaj025
              FROM glab_t
             WHERE glabld = l_faaj.faajld
               AND glab002 = l_faah.faah006
               AND glabent = g_enterprise
               AND glab003 = '9901_03'
            SELECT glab005 INTO l_faaj.faaj026
              FROM glab_t
             WHERE glabld = l_faaj.faajld
               AND glab002 = l_faah.faah006
               AND glabent = g_enterprise
               AND glab003 = '9901_04'
            INSERT INTO faaj_t (faajent,faajld,faaj000,faaj001,faaj002,faaj003,faaj004,faaj011,faaj016,faaj019,faaj014,faaj030,faaj037,
                                faaj101,faaj102,faaj103,faaj151,faaj152,faaj153,faajstus,
                                faajownid,faajowndp,faajcrtid,faajcrtdp,faajcrtdt,faajmodid,faajmoddt,faaj023,faaj024,faaj025,faaj026)
                   VALUES (g_enterprise,l_faaj.faajld,l_faaj.faaj000,l_faah.faah003,l_faah.faah004,g_faac003,g_faac004,
                           l_faaj.faaj011,l_faaj.faaj016,l_faaj.faaj019,l_faah.faah020,l_faaj.faaj030,l_faah.faah001,
                           l_faaj.faaj101,l_faaj.faaj102,l_faaj.faaj103,
                           l_faaj.faaj151,l_faaj.faaj152,l_faaj.faaj153,'N',
                           l_faaj.faajownid,l_faaj.faajowndp,l_faaj.faajcrtid,l_faaj.faajcrtdp,
                           l_faaj.faajcrtdt,l_faaj.faajmodid,l_faaj.faajmoddt,l_faaj.faaj023,l_faaj.faaj024,l_faaj.faaj025,l_faaj.faaj026)
            IF SQLCA.sqlcode THEN
               #150731-00004#1 20150826 str---
               #CALL cl_errmsg('ins faaj :','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins faaj :'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               #150731-00004#1 20150826 end--- 
               LET r_success = FALSE 
           END IF   
        END FOREACH               
      END IF
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 新增faaj臨時表
# Memo...........:
# Usage..........: CALL afat470_create_tmp()
# Input parameter:  
# Date & Author..: 2014/8/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_create_tmp()

    DROP TABLE afat470_tmp;
      CREATE TEMP TABLE afat470_tmp(
      faaj001   VARCHAR(20),        #財編
      faaj002   VARCHAR(20),        #附號
      faaj037   VARCHAR(10),        #卡号
      faah002   INTEGER,        #類型： 主件、附屬配件、附屬費用
      faajld    VARCHAR(5),        #帳套
      faaj016   DECIMAL(20,6))        #成本
      

END FUNCTION

################################################################################
# Descriptions...:  unconf upd
# Memo...........:
# Usage..........: CALL afat470_unconf_upd_faba()
# Input parameter:  
# Date & Author..: 2014/8/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_unconf_upd_faba()
DEFINE l_fabl001   LIKE fabl_t.fabl001
DEFINE l_fabl002   LIKE fabl_t.fabl002
DEFINE l_fabl003   LIKE fabl_t.fabl003
DEFINE l_fabm001   LIKE fabm_t.fabm001
DEFINE l_fabm002   LIKE fabm_t.fabm002
DEFINE l_fabm003   LIKE fabm_t.fabm003
DEFINE r_success   LIKE type_t.num5
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   #獲取合併財編明細資料-單身一
   LET g_sql = " SELECT fabl001,fabl002,fabl003 ",
               "   FROM fabl_t",
               "  WHERE fablent = '",g_enterprise,"'",
               "    AND fabldocno = '",g_faba_m.fabadocno,"'"
                 
   PREPARE afat470_fabl_pb2 FROM g_sql
   DECLARE afat470_fabl_cs2 CURSOR FOR afat470_fabl_pb2
   
   
   #獲取合併財編資料-單身二
   LET g_sql = " SELECT fabm001,fabm002,fabm003 ",
               "   FROM fabm_t",
               "  WHERE fabment = '",g_enterprise,"'",
               "    AND fabmdocno = '",g_faba_m.fabadocno,"'"
                 
   PREPARE afat470_fabm_pb2 FROM g_sql
   DECLARE afat470_fabm_cs2 CURSOR FOR afat470_fabm_pb2 
   
   #還原合併財編無效資料為已確認
   FOREACH afat470_fabl_cs2 INTO l_fabl001,l_fabl002,l_fabl003
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('foreach fabl ','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach fabl'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end---
         LET r_success = FALSE         
         EXIT FOREACH
      END IF    
      
      UPDATE faah_t SET faahstus = 'Y'
                  WHERE faahent = g_enterprise
                    AND faah003 = l_fabl001
                    AND faah004 = l_fabl002
                    AND faah001 = l_fabl003
                    AND faahstus = 'X'
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('upd faah ','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'upd faah '
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end---
         LET r_success = FALSE         
      END IF                       
   END FOREACH
   
   #刪除合併財編faah和faaj資料
   FOREACH afat470_fabm_cs2 INTO l_fabm001,l_fabm002,l_fabm003
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('foreach fabm  ','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach fabm '
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end---
         LET r_success = FALSE         
         EXIT FOREACH
      END IF 

      DELETE FROM faah_t WHERE faahent = g_enterprise
                           AND faah003 = l_fabm001
                           AND faah004 = l_fabm002
                           AND faah001 = l_fabm003
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('del faah  ','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del faah '
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end---
         LET r_success = FALSE         
      END IF   

      DELETE FROM faaj_t WHERE faajent = g_enterprise
                           AND faaj001 = l_fabm001
                           AND faaj002 = l_fabm002
      IF SQLCA.sqlcode THEN
         #150731-00004#1 20150826 str---
         #CALL cl_errmsg('del faaj  ','','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del faaj '
         LET g_errparam.popup = TRUE
         CALL cl_err()
         #150731-00004#1 20150826 end---
         LET r_success = FALSE         
      END IF   
   END FOREACH

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取消確認
# Memo...........:
# Usage..........: CALL afat470_unconf_chk_faba()
# Input parameter:  
# Date & Author..: 2014/8/13 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_unconf_chk_faba()
   DEFINE r_success           LIKE type_t.num5                #檢核狀態
   DEFINE l_fabastus          LIKE faba_t.fabastus            #状态码
   DEFINE l_n                 LIKE type_t.num5
   DEFINE l_para_data         LIKE faba_t.fabadocdt
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   CALL cl_get_para(g_enterprise,g_faba_m.fabacomp,'S-FIN-9003') RETURNING l_para_data
   IF NOT cl_null(l_para_data) AND g_faba_m.fabadocdt <= l_para_data THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "afa-00060"
      LET g_errparam.extend = g_faba_m.fabadocdt
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #狀態碼=确认,才可進行確認動作
   SELECT fabastus INTO l_fabastus FROM faba_t
    WHERE fabaent = g_enterprise
      AND fabadocno = g_faba_m.fabadocno
   IF l_fabastus <>'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "afa-00026"
      LET g_errparam.extend = g_faba_m.fabadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   LET l_n = 0
   #检查合并后的财编在afai100中是否已经确认
   SELECT COUNT(*) INTO l_n
     FROM faah_t,fabm_t
    WHERE faahent = fabment
      AND faah003 = fabm001
      AND faah004 = fabm002
      AND faah001 = fabm003
      AND fabment = g_enterprise
      AND fabmdocno = g_faba_m.fabadocno
      AND faahstus = 'Y'
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_faba_m.fabadocno
      LET g_errparam.code   = 'afa-00254'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()  
      LET r_success = FALSE
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat470_get_fabm004_desc() 
# Input parameter:  
# Date & Author..: 2014/8/14 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_get_fabm004_desc()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fabl2_d[l_ac].fabm004
            CALL ap_ref_array2(g_ref_fields,"SELECT faacl003 FROM faacl_t WHERE faaclent='"||g_enterprise||"' AND faacl001=? AND faacl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fabl2_d[l_ac].fabm004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fabl2_d[l_ac].fabm004_desc
END FUNCTION

################################################################################
# Descriptions...: 检查财编和附号是否有维护
# Memo...........:
# Usage..........: CALL afat470_fabm001_chk()
#                  RETURNING l_success
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/10/20 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_fabm001_chk()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_n = 0
   #检查合并财编里主件是否为空
   SELECT COUNT(*) INTO l_n
     FROM fabm_t
    WHERE fabment = g_enterprise
      AND fabmdocno = g_faba_m.fabadocno
      AND fabm005 = '1'
      AND fabm001 IS NULL
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'afa-00257'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()   
      LET r_success = FALSE
      RETURN r_success
   END IF 
   LET l_n = 0
   #检查类型不为主件的附号是否有空值
   SELECT COUNT(*) INTO l_n
     FROM fabm_t
    WHERE fabment = g_enterprise
      AND fabmdocno = g_faba_m.fabadocno
      AND fabm005 <> '1'
      AND (fabm002 IS NULL OR fabm002 = ' ')
   IF l_n > 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = 'afa-00258'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()   
      LET r_success = FALSE
      RETURN r_success
   END IF 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 財產編號、附號、卡片編號檢查
# Memo...........:
# Usage..........: CALL afat470_faid_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否     TRUE/FALSE
# Date & Author..: 2014/10/23 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_faid_chk()
   DEFINE l_faah015         LIKE faah_t.faah015
   DEFINE l_n1              LIKE type_t.num5 
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
   DEFINE l_faah042         LIKE faah_t.faah042
   DEFINE l_faah020         LIKE faah_t.faah020
   DEFINE l_fabl009         LIKE fabl_t.fabl009
   
   LET r_success = TRUE

   #無財編、卡片編號則不需要做檢查，無附號則便是類型為'1.主件'所以不需要考慮附號值否有
   IF cl_null(g_fabl_d[l_ac].fabl001) OR g_fabl_d[l_ac].fabl002 IS NULL THEN
      RETURN r_success
   END IF

   #########################################################huangtao mark
    #若財編、附號不為空，卡片編號為空，可自動帶出
   #IF g_fabl_d[l_ac].fabl002 IS NOT NULL AND cl_null(g_fabl_d[l_ac].fabl003) THEN
   #   CALL afat470_faid_def()
   #END IF
   #########################################################huangtao mark

   IF cl_null(g_fabl_d[l_ac].fabl003) THEN RETURN r_success END IF

  # LET l_n = 0
  # SELECT COUNT(*) INTO l_n
  #   FROM faaj_t
  #  WHERE faajent = g_enterprise
  #    AND faaj037 = g_fabl_d[l_ac].fabl003
  #    AND faaj001 = g_fabl_d[l_ac].fabl001
  #    AND faaj002 = g_fabl_d[l_ac].fabl002
  #
  # IF l_n = 0 THEN 
  #    INITIALIZE g_errparam TO NULL
  #    LET g_errparam.code = 'afa-00178'
  #    LET g_errparam.extend = ''
  #    LET g_errparam.popup = TRUE
  #    CALL cl_err()
  #
  #    LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001
  #    LET g_fabl_d[l_ac].fabl002=g_fabl_d_t.fabl002
  #    LET g_fabl_d[l_ac].fabl003=g_fabl_d_t.fabl003
  #    LET r_success = FALSE
  #    RETURN r_success
  # END IF
  #
  # SELECT faah015 INTO l_faah015 FROM faah_t
  #  WHERE faahent = g_enterprise
  #    AND faah003 = g_fabl_d[l_ac].fabl001
  #    AND faah004 = g_fabl_d[l_ac].fabl002 
  #    AND faah001 = g_fabl_d[l_ac].fabl003
  # #財產狀態不可為5：出售、6：銷賬、8：停用、10：被資本化
  # IF l_faah015='5' OR l_faah015='6' OR l_faah015='8' OR l_faah015='10'  THEN
  #    INITIALIZE g_errparam TO NULL
  #    LET g_errparam.code = 'afa-01004'
  #    LET g_errparam.extend = ''
  #    LET g_errparam.popup = TRUE
  #    CALL cl_err()
  #
  #    LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001
  #    LET g_fabl_d[l_ac].fabl002=g_fabl_d_t.fabl002
  #    LET g_fabl_d[l_ac].fabl003=g_fabl_d_t.fabl003
  #    LET r_success = FALSE
  #    RETURN r_success
  # END IF 

   #當前折畢再單，卡片+財產編號+附號不可重複
   LET l_n1 = 0
   SELECT COUNT(*) INTO l_n1 FROM fabh_t
    WHERE fabhent = g_enterprise
      AND fabhdocno = g_faba_m.fabadocno
      AND fabh001 = g_fabl_d[l_ac].fabl001
      AND fabh002 = g_fabl_d[l_ac].fabl002
      AND fabh000 = g_fabl_d[l_ac].fabl003
      AND fabhseq <> g_fabl_d[l_ac].fablseq
   IF l_n1 > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00142'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_fabl_d[l_ac].fabl001=g_fabl_d_t.fabl001
      LET g_fabl_d[l_ac].fabl002=g_fabl_d_t.fabl002
      LET g_fabl_d[l_ac].fabl003=g_fabl_d_t.fabl003
      LET r_success = FALSE
      RETURN r_success
   END IF

   SELECT faah042,faah020 INTO l_faah042,l_faah020 FROM faah_t
    WHERE faahent = g_enterprise
      AND faah003 = g_fabl_d[l_ac].fabl001
      AND faah004 = g_fabl_d[l_ac].fabl002 
      AND faah001 = g_fabl_d[l_ac].fabl003
      
   #資產屬性需為1:自由才能合併
   IF l_faah042 != '1' THEN 
       INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00162'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
      
      #幣別不同不可合併
   SELECT DISTINCT fabl009 INTO l_fabl009 FROM fabl_t
    WHERE fablent   = g_enterprise
      AND fabldocno = g_faba_m.fabadocno
   IF NOT cl_null(l_fabl009) THEN 
      IF l_fabl009 != l_faah020 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'afa-00166'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF     

   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 財產編號、附號、卡片編號檢查
# Memo...........:
# Usage..........: CALL afat470_faid_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      執行成功否     TRUE/FALSE
# Date & Author..: 2014/10/23 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_faid_def()
  #DEFINE l_fabl003         LIKE fabl_t.fabl003
  #DEFINE l_sql             STRING
  #DEFINE l_faah015         LIKE faah_t.faah015
  #
  #LET l_sql = " SELECT faaj037, faaj002, faaj001 FROM faaj_t WHERE faajent = '",g_enterprise,"'",
  #            "   AND NOT EXISTS (SELECT fabh000 FROM fabh_t WHERE fabhent = '",g_enterprise,"'",
  #            "   AND fabhdocno = '",g_faba_m.fabadocno,"'                                     ",
  #            "   AND fabh001 = faaj001                                                        ",
  #            "   AND fabh002 = faaj002                                                        ",
  #            "   AND fabh000 = faaj037)                                                       ",
  #            "   AND faaj001 = '",g_fabl_d[l_ac].fabl001,"'                                   ",
  #            "   AND faaj002 = '",g_fabl_d[l_ac].fabl002,"'                                   "
  #PREPARE afat470_pb5 FROM l_sql
  #DECLARE afat470_cs5 CURSOR FOR afat470_pb5 
  #
  #   FOREACH afat470_cs5 INTO l_fabl003
  #      SELECT faah015 INTO l_faah015 FROM faah_t
  #       WHERE faahent = g_enterprise
  #         AND faah003 = g_fabl_d[l_ac].fabl001
  #         AND faah004 = g_fabl_d[l_ac].fabl002
  #         AND faah001 = l_fabl003
  #      #財產狀態不可為0：取得、5：出售、6：銷賬、10：被資本化
  #      IF l_faah015<>'0'  THEN
  #         CONTINUE FOREACH
  #      ELSE
  #         LET g_fabl_d[l_ac].fabl003 = l_fabl003
  #         EXIT FOREACH
  #      END IF 
  #   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL afat470_change_to_sql(p_wc)
# Input parameter:  

################################################################################
PRIVATE FUNCTION afat470_change_to_sql(p_wc)
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
# Descriptions...:  
# Memo...........:
# Usage..........: CALL afat470_fabacomp_desc()
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_fabacomp_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faba_m.fabacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faba_m.fabacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faba_m.fabacomp_desc
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
PUBLIC FUNCTION afat470_fabasite_chk(p_site)
DEFINE p_site    LIKE faba_t.fabasite
DEFINE l_n       LIKE type_t.num5
DEFINE l_ooef003 LIKE ooef_t.ooef003

    #检查是否存在ooef 组织档
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00094'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
    #检查是否有效
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site AND ooefstus = 'Y'
    IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00105'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
    END IF
     #检查是否是资产中心
    SELECT COUNT(*) INTO l_n FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_site AND ooefstus = 'Y' AND ooef207 = 'Y'
    IF l_n = 0 THEN      
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = 'afa-00004'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN FALSE     
    END IF

    RETURN TRUE
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
PUBLIC FUNCTION afat470_fabasite_faba001_chk(p_fabasite,p_faba001)
DEFINE p_fabasite  LIKE faba_t.fabasite
DEFINE p_faba001   LIKE faba_t.faba001
DEFINE l_n         LIKE type_t.num5

   SELECT COUNT(*) INTO l_n FROM gzxc_t 
    WHERE gzxcent = g_enterprise AND gzxc001 = p_faba001  
      AND gzxc004 = p_fabasite 
      AND ((gzxc005 IS NULL  OR gzxc005 <=g_today) AND (gzxc006 IS NULL OR gzxc006 >=g_today))

   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00291'  
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   RETURN TRUE
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
PUBLIC FUNCTION afat470_fabasite_fabacomp_chk(p_fabasite,p_fabacomp)
DEFINE p_fabasite  LIKE faba_t.fabasite
DEFINE p_fabacomp    LIKE faba_t.fabacomp
DEFINE l_sql       STRING
DEFINE l_count     LIKE type_t.num5
DEFINE l_origin_str  STRING

   #资产中心范围包含 这个法人组织。
  CALL s_fin_create_account_center_tmp() 
  CALL s_fin_account_center_sons_query('5',g_faba_m.fabasite,g_faba_m.fabadocdt,'1')
  CALL s_fin_account_center_comp_str() RETURNING l_origin_str
  
  
  CALL afat470_change_to_sql(l_origin_str)RETURNING l_origin_str
  LET l_origin_str = "(",l_origin_str,")"
  LET l_sql = " SELECT COUNT(*) FROM ooef_t ",
              "  WHERE ooefent = '",g_enterprise,"' AND ooef017='",p_fabacomp,"'",
              "    AND ooef001 IN ",l_origin_str


   PREPARE sel_fabacomp FROM l_sql
   EXECUTE sel_fabacomp INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
 
   IF l_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00294'      
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
 
   RETURN TRUE
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
PUBLIC FUNCTION afat470_fabacomp_chk()
DEFINE l_ooefstus         LIKE ooef_t.ooefstus
   DEFINE l_ooef003          LIKE ooef_t.ooef003
   
   LET g_errno = ''
   SELECT ooefstus,ooef003 INTO l_ooefstus,l_ooef003
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_faba_m.fabacomp
   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00090'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302' #'aoo-00091' #160318-00005#10 mod 
      WHEN l_ooef003 = 'N'        LET g_errno = 'anm-00037'
   END CASE
   
   IF NOT cl_null(g_errno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = g_errno    
      LET g_errparam.extend = ''
      #160318-00005#10   --add--str
      LET g_errparam.replace[1] ='aooi100'
      LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
      LET g_errparam.exeprog    ='aooi100'
      #160318-00005#10  --add--end
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示隐藏本位币栏位
# Memo...........:
# Usage..........: CALL afat470_set_comp()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/12/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_set_comp()
   DEFINE l_glaa015  LIKE glaa_t.glaa015
   DEFINE l_glaa019  LIKE glaa_t.glaa019
   
   #获取法人主帐套对应的本位币二、三是否启用
   SELECT glaa015,glaa019 INTO l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_faba_m.fabacomp
      AND glaa014 = 'Y'
   IF l_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible("fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,
                                fabm101,fabm102,fabm103,fabm104,fabm105,fabm106",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabl101,fabl102,fabl103,fabl104,fabl105,fabl106,fabl201,fabl202,fabl203,fabl204,fabl205,fabl206,
                                fabm101,fabm102,fabm103,fabm104,fabm105,fabm106,fabm201,fabm202,fabm203,fabm204,fabm205,fabm206",FALSE)
   END IF 
   IF l_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible("fabl201,fabl202,fabl203,fabl204,fabl205,fabl206,
                                fabm201,fabm202,fabm203,fabm204,fabm205,fabm206",TRUE)
   ELSE
      CALL cl_set_comp_visible("fabl201,fabl202,fabl203,fabl204,fabl205,fabl206,
                                fabm201,fabm202,fabm203,fabm204,fabm205,fabm206",FALSE)
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
PRIVATE FUNCTION afat470_faba004_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faba_m.faba004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_faba_m.faba004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faba_m.faba004_desc
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
PRIVATE FUNCTION afat470_faba005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_faba_m.faba005
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_faba_m.faba005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_faba_m.faba005_desc
END FUNCTION
# 获取agli010资料
PRIVATE FUNCTION afat470_get_glaa()
   
   #161111-00028#3---MODIFY----begin---------
   #SELECT * INTO g_glaa.* 
    SELECT glaaent,glaaownid,glaaowndp,glaacrtid,glaacrtdp,glaacrtdt,glaamodid,glaamoddt,glaastus,glaald,
           glaacomp,glaa001,glaa002,glaa003,glaa004,glaa005,glaa006,glaa007,glaa008,glaa009,glaa010,
           glaa011,glaa012,glaa013,glaa014,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,
           glaa022,glaa023,glaa024,glaa025,glaa026,glaa100,glaa101,glaa102,glaa103,glaa111,glaa112,
           glaa113,glaa120,glaa121,glaa122,glaa027,glaa130,glaa131,glaa132,glaa133,glaa134,
           glaa135,glaa136,glaa137,glaa138,glaa139,glaa140,glaa123,glaa124,glaa028 INTO g_glaa.*
   #161111-00028#3---MODIFY----end---------
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = g_faba_m.fabacomp
      AND glaa014 = 'Y'
      
END FUNCTION

################################################################################
# Descriptions...: 编辑完直接审核功能
# Memo...........:
# Usage..........: CALL afat460_immediately_conf()
#                  RETURNING r_success()
#                :
# Date & Author..: 2015/12/11 By 06862
# Modify.........:
################################################################################
PRIVATE FUNCTION afat470_immediately_conf()
   DEFINE l_today           LIKE faba_t.fabacnfdt
   DEFINE l_success         LIKE type_t.num5
 # DEFINE l_glaa            RECORD LIKE glaa_t.*    #161111-00028#7--MARK
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_n               LIKE type_t.num5
   DEFINE r_success         LIKE type_t.num5
   DEFINE l_colname         STRING
   DEFINE l_comment         STRING
   DEFINE l_table           LIKE type_t.chr10
   DEFINE l_table000        LIKE type_t.chr20
   DEFINE l_table001        LIKE type_t.chr20
   DEFINE l_table002        LIKE type_t.chr20
   DEFINE l_glgbdocno       LIKE glgb_t.glgbdocno
   DEFINE l_glgbseq         LIKE glgb_t.glgbseq
   DEFINE l_sql             STRING
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   
   LET r_success = TRUE 
   
   #無資料直接返回不做處理
   IF cl_null(g_faba_m.fabadocno) THEN 
      LET r_success = FALSE 
      RETURN r_success
   END IF   
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
  
   LET l_success = TRUE
   
   IF NOT s_afat503_sys_chk('',g_faba_m.fabacomp,g_faba_m.fabadocdt) THEN
      LET r_success = FALSE 
      RETURN r_success
   END IF
   
    CALL cl_err_collect_init()
    CALL s_azzi902_get_gzzd('afap100',"lbl_faah001") RETURNING l_colname,l_comment  #卡片编号
    LET g_coll_title[1] = l_colname
    CALL s_azzi902_get_gzzd('afap100',"lbl_faah003") RETURNING l_colname,l_comment  #财产编号
    LET g_coll_title[2] = l_colname
    CALL s_azzi902_get_gzzd('afap100',"lbl_faah004") RETURNING l_colname,l_comment  #符号
    LET g_coll_title[3] = l_colname
    
    CALL s_afa_p_faan_chk(g_glaa.glaald,g_faba_m.fabadocno,g_faba_m.fabadocdt,'fabj_t','fabj003','fabj001','fabj002') 
         RETURNING l_success
     
    CALL afat470_conf_chk_faba() RETURNING l_success
    IF l_success = TRUE THEN
       CALL afat470_conf_upd_faba() RETURNING l_success
    END IF 
    IF l_success = TRUE THEN 
       LET l_today  = cl_get_current()
       #检查完毕，更新狀態碼=已確認,確認人=登入user,確認日期=g_today
       UPDATE faba_t SET fabastus = 'Y',
                         fabacnfid = g_user,
                         fabacnfdt = l_today
                   WHERE fabaent = g_enterprise
                     AND fabadocno = g_faba_m.fabadocno
        IF SQLCA.SQLCODE THEN
           LET l_success = FALSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.SQLCODE
           LET g_errparam.extend = 'fabastus'||g_faba_m.fabadocno
           LET g_errparam.popup = TRUE
           CALL cl_err()              
        END IF 
        CALL afat470_b_fill()                
    END IF 
    
    IF l_success = FALSE THEN 
       LET r_success = FALSE 
    END IF
   
    RETURN r_success
END FUNCTION

 
{</section>}
 
