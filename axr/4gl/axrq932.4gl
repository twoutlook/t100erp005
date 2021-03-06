#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq932.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:23(2015-12-28 13:56:50), PR版次:0023(2017-02-17 16:15:10)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000077
#+ Filename...: axrq932
#+ Description: 各期應收帳齡分析查詢
#+ Creator....: 01727(2015-04-01 18:05:32)
#+ Modifier...: 04152 -SD/PR- 05016
 
{</section>}
 
{<section id="axrq932.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150901-00020#4    2015/09/03 By Hans       明細增加會計科目，彙總增加第三條件，帳務單號+發票號碼，說明回抓 xrea
#                                           彙總條件增加部門+人員
#151012-00014#4    2015/10/21 By Hans       當顯示原幣的時候，第二頁籤帳齡用原幣顯示
#151022-00017#4    2015/10/26 By Hans       aapq930 將部門/人員/交易條件 從匯總條件一二拿掉 aapq932 彙總增加說明
#151029            2015/10/29 By Hans       信用額度不在依據狀態做隱顯
#150401-00001#35   2015/10/11 By Hans       931增加彙總條件 4.5 / 930 月結取值回扣
#151223-00001#4    2015/12/28 By Reanna     加一欄:重評前本幣>>xrea113 - 調匯金額
#151223-00001#2    2015/12/30 By Hans       增加彙總條件4.5/調整匯總條件
#160107-00003#4    2016/01/19 By fionchen   沖銷參數1/2的狀態下，其實xrcb/xrcc是對不上的
#160318-00025#53   2016/04/27 By 07673      將重複內容的錯誤訊息置換為公用錯誤訊息
#160505-00007#25   2016/05/16 By 01531      效能优化
#160705-00042#10   2016/07/13 By sakura     程式中寫死g_prog部分改寫MATCHES方式
#160727-00019#6    2016/07/29 By 08734      axrq932_print_tmp ——> axrq932_tmp01
#160727-00019#6    2016/07/29 By 08734      axrq932_print_tmp1 ——> axrq932_tmp02
#160727-00019#6    2016/07/29 By 08734      axrq932_print_tmp2 ——> axrq932_tmp03
#160811-00009#2    2016/08/17 By 01531      账务中心/法人/账套权限控管
#161011-00004#1    2016/10/18 By 01727      程序二次筛选时查询不出资料
#161021-00050#6    2016/10/26 By 08729      處理組織開窗
#161102-00021#1    2016/11/02 By 02114      axrq930查询时，同一个单号+项次会重复出现
#161111-00049#2    2016/11/12 By 01727      控制组权限修改
#161205-00002#1    2016/12/06 By 01727      声名axrq932_pb3_prep10使用的SQL语句中使用了全角问号,导致执行SQL语句出错
#161208-00002#1    2016/12/08 By 05016      當 aoos020 應收/付沖帳參數設定為 3.沖銷至明細時,以下相關查詢呈現的科目請抓取單身科目為主:aapq911,axrq911,aapq930,axrq930
#161209-00048#1    2016/12/13 By 07900      坏账计提比率取值有误 5区，DSCNJ，账龄类型=A01，查询出的账款账龄=8天，但是坏账计提率始终取的是axri014最后一个区间的计提率。
#161226-00039#2    2016/12/26 By 05016      沖銷參數='3'時, 會有重覆資料顯示。
#161229-00045#1    2017/01/03 By Hans       壞帳計算,應控客戶等級不同計計提列率 相關程式axrq932,aapq932
#170124-00013#1    2017/02/03 By Hans       應收/應付 帳齡分析表及月結表，因採月底重評價作業期初迴轉，故相關的結帳報表,期初值應扣減重評價金額。
#                                           一.aapq930,axrq930的處理,金額表達不含本期調匯數。 
#                                             1.調匯不迴轉: 期初值含上期調匯數,本期不含調匯金額。
#                                             2.調匯迴轉:金額皆不含調匯數。
#170217-00022#1    2017/02/17 By Hans        一.aapq930,axrq930相關的結帳報表,期初值應扣減重評價金額，修改。

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xrea_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   xrea001 LIKE xrea_t.xrea001, 
   xrea002 LIKE xrea_t.xrea002, 
   xreald LIKE xrea_t.xreald, 
   xreald_desc LIKE type_t.chr500, 
   xrea009 LIKE xrea_t.xrea009, 
   xrea009_desc LIKE type_t.chr500, 
   xrea004 LIKE xrea_t.xrea004, 
   xrea005 LIKE xrea_t.xrea005, 
   xrea006 LIKE xrea_t.xrea006, 
   xrea007 LIKE xrea_t.xrea007, 
   xrea019 LIKE xrea_t.xrea019, 
   xrea019_desc LIKE type_t.chr500, 
   xrea008 LIKE xrea_t.xrea008, 
   l_apcc004 LIKE type_t.dat, 
   day LIKE type_t.chr500, 
   day2 LIKE type_t.chr500, 
   xrea100 LIKE xrea_t.xrea100, 
   xrea103 LIKE xrea_t.xrea103, 
   xrea113 LIKE xrea_t.xrea113, 
   l_debt LIKE type_t.num20_6, 
   l_xrea103_debt LIKE type_t.num20_6, 
   l_xrea113_debt LIKE type_t.num20_6, 
   xrea003 LIKE xrea_t.xrea003 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input     RECORD #單頭input
        xreasite       LIKE xrea_t.xreasite,
        xreasite_desc  LIKE type_t.chr80,
        year           LIKE xrea_t.xrea001,
        strmon         LIKE type_t.num5,
        endmon         LIKE type_t.num5,
        group          LIKE type_t.chr80,
        xrad001        LIKE xrad_t.xrad001,
        xrad001_desc   LIKE type_t.chr80,
        xrad004        LIKE xrad_t.xrad004,
        apca0010       LIKE type_t.chr1,
        apca0012       LIKE type_t.chr1,
        dedtype        LIKE glcb_t.glcb008,
        curr           LIKE type_t.chr1,
        b_check        LIKE type_t.chr1,
        cre            LIKE type_t.chr1, 
        enddate        LIKE apca_t.apcadocdt            
                   END RECORD
                   
TYPE type_g_xrea2_d RECORD #第二單身Array
      group1         LIKE type_t.chr80,      
      group1_desc    LIKE type_t.chr80,      
      group2         LIKE type_t.chr80,
      group2_desc    LIKE type_t.chr80,      
      group3         LIKE type_t.chr80,
      group3_desc    LIKE type_t.chr80,
      xrea011        LIKE xrea_t.xrea011, #部門
      xrea011_desc   LIKE type_t.chr80,
      xrea016        LIKE xrea_t.xrea016, #人員
      xrea016_desc   LIKE type_t.chr80,    
      pmab053        LIKE pmab_t.pmab053, #交易條件
      pmab053_desc   LIKE type_t.chr80,      
      xrea100        LIKE xrea_t.xrea100, #幣別 
      xrea1031       LIKE xrea_t.xrea103, #原幣期初金額
      xrea1032       LIKE xrea_t.xrea103, #原幣本期增加金額
      xrea1033       LIKE xrea_t.xrea103, #原幣本期減少金額 
      xrea1034       LIKE xrea_t.xrea103, #原幣期末金額
      xrea1131       LIKE xrea_t.xrea113, #本幣期初金額
      xrea1132       LIKE xrea_t.xrea113, #本幣本期增加金額
      xrea1133       LIKE xrea_t.xrea103, #本幣本期減少金額
      xrea1136       LIKE xrea_t.xrea103, #重評前本幣 #151223-00001#4
      xrea1134       LIKE xrea_t.xrea103, #本幣期末金額>>重評後未沖本幣
      xrea1035       LIKE xrea_t.xrea103, #原幣壞帳數
      xrea1135       LIKE xrea_t.xrea113, #本幣壞帳數
      crecurr        LIKE xrea_t.xrea100, #信用額度幣別
      crelim         LIKE xrea_t.xrea113, #信用額度
      stomoney       LIKE xrea_t.xrea113, #本期入庫金額
      advmoney       LIKE xrea_t.xrea113, #本期預付金額 
      retmoney       LIKE xrea_t.xrea113, #本期退貨金額
      addmoney       LIKE xrea_t.xrea113, #本期調增金額      
      adjmoney       LIKE xrea_t.xrea113, #調匯金額
      redmoney       LIKE xrea_t.xrea113, #本期調減金額
      paymoney       LIKE xrea_t.xrea113, #實際付款金額
      anomoney       LIKE xrea_t.xrea113, #本期其他沖帳金額
      xrea103_01     LIKE xrea_t.xrea103, #未沖本幣
      xrea113_01     LIKE xrea_t.xrea113, #本幣壞帳
      xrea103_02     LIKE xrea_t.xrea103,
      xrea113_02     LIKE xrea_t.xrea113,
      xrea103_03     LIKE xrea_t.xrea103,
      xrea113_03     LIKE xrea_t.xrea113,
      xrea103_04     LIKE xrea_t.xrea103,
      xrea113_04     LIKE xrea_t.xrea113,
      xrea103_05     LIKE xrea_t.xrea103,
      xrea113_05     LIKE xrea_t.xrea113,
      xrea103_06     LIKE xrea_t.xrea103,
      xrea113_06     LIKE xrea_t.xrea113,
      xrea103_07     LIKE xrea_t.xrea103,
      xrea113_07     LIKE xrea_t.xrea113,
      xrea103_08     LIKE xrea_t.xrea103,
      xrea113_08     LIKE xrea_t.xrea113,
      xrea103_09     LIKE xrea_t.xrea103,
      xrea113_09     LIKE xrea_t.xrea113,
      xrea103_10     LIKE xrea_t.xrea103,
      xrea113_10     LIKE xrea_t.xrea113,
      xrea103_11     LIKE xrea_t.xrea103,
      xrea113_11     LIKE xrea_t.xrea113,
      xrea103_12     LIKE xrea_t.xrea103,
      xrea113_12     LIKE xrea_t.xrea113,
      xrea103_13     LIKE xrea_t.xrea103,
      xrea113_13     LIKE xrea_t.xrea113,
      xrea103_14     LIKE xrea_t.xrea103,
      xrea113_14     LIKE xrea_t.xrea113,
      xrea103_15     LIKE xrea_t.xrea103,
      xrea113_15     LIKE xrea_t.xrea113,
      xrea103_16     LIKE xrea_t.xrea103,
      xrea113_16     LIKE xrea_t.xrea113,
      xrea103_17     LIKE xrea_t.xrea103,
      xrea113_17     LIKE xrea_t.xrea113,
      xrea103_18     LIKE xrea_t.xrea103,
      xrea113_18     LIKE xrea_t.xrea113,
      xrea103_19     LIKE xrea_t.xrea103,
      xrea113_19     LIKE xrea_t.xrea113,
      xrea103_20     LIKE xrea_t.xrea103,
      xrea113_20     LIKE xrea_t.xrea113,
      xrea103_21     LIKE xrea_t.xrea103,
      xrea113_21     LIKE xrea_t.xrea113,
      mon1           LIKE xrea_t.xrea113, 
      mon2           LIKE xrea_t.xrea113,
      mon3           LIKE xrea_t.xrea113,
      mon4           LIKE xrea_t.xrea113, 
      mon5           LIKE xrea_t.xrea113, 
      mon6           LIKE xrea_t.xrea113, 
      mon7           LIKE xrea_t.xrea113, 
      mon8           LIKE xrea_t.xrea113, 
      mon9           LIKE xrea_t.xrea113,                 
      mon10          LIKE xrea_t.xrea113,
      mon11          LIKE xrea_t.xrea113,
      mon12          LIKE xrea_t.xrea113

          END RECORD               
DEFINE g_xrea2_d   DYNAMIC ARRAY OF type_g_xrea2_d
DEFINE g_wc_xreald   STRING
DEFINE g_wc_xreasite STRING
DEFINE g_wc_xreacomp STRING
#資料瀏覽之欄位 
DEFINE g_xrea3_d       DYNAMIC ARRAY OF RECORD    
       xrea002         LIKE xrea_t.xrea002
      END RECORD
      
DEFINE g_current_row   LIKE type_t.num5
DEFINE g_current_idx   LIKE type_t.num10
DEFINE g_jump          LIKE type_t.num10
DEFINE g_no_ask        LIKE type_t.num5
DEFINE g_rec_b         LIKE type_t.num5      
            
DEFINE g_xrea002       LIKE xrea_t.xrea002        #期別跳頁  
DEFINE g_xreald        LIKE xrea_t.xreald
DEFINE g_xreacomp      LIKE xrea_t.xreacomp

DEFINE g_strdate         LIKE glav_t.glav004 #會計日期
DEFINE g_enddate         LIKE glav_t.glav004 #會計日期

#日期區間使用的Array
DEFINE g_xrae      DYNAMIC ARRAY OF RECORD 
       str      LIKE xrae_t.xrae003,
       end      LIKE xrae_t.xrae004 
       END RECORD
DEFINE g_end_day    LIKE type_t.num5  #最後一天
DEFINE g_b2_wc      STRING #單身二所使用的條件
DEFINE g_hideflag             LIKE type_t.num5
DEFINE g_sql_ctrl       STRING                #161111-00049#2 Add 料件控制组
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xrea_d
DEFINE g_master_t                   type_g_xrea_d
DEFINE g_xrea_d          DYNAMIC ARRAY OF type_g_xrea_d
DEFINE g_xrea_d_t        type_g_xrea_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axrq932.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_ooef017         LIKE ooef_t.ooef017   #161111-00049#2 Add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axr","")
 
   #add-point:作業初始化 name="main.init"
  #161111-00049#2 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
  #161111-00049#2 Add  ---(E)---
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq932_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq932_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq932_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq932 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq932_init()   
 
      #進入選單 Menu (="N")
      CALL axrq932_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq932
      
   END IF 
   
   CLOSE axrq932_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq932.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq932_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_sql         STRING
   DEFINE l_str         STRING
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_fin_create_account_center_tmp()
   CALL axrq932_create_tmp()   
   CALL s_fin_set_comp_scc('year','43')      #年度
   CALL s_fin_set_comp_scc('strmon','111')   #13期  
   CALL s_fin_set_comp_scc('endmon','111')  
   #151022-00017#4 ---s---
   #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_combo_scc('group','8342')      #彙總條件 axrq930
   ELSE
      CALL cl_set_combo_scc('group','8330')      #彙總條件 axrq932
   END IF
   #151022-00017#4 ---e---
   CALL cl_set_combo_scc('dedtype','8328')    #扣除方式
   CALL cl_set_combo_scc('b_xrea004','8302')  #帳款單性質
   #帳齡起算日基準
   LET l_sql = "SELECT gzcb002 FROM gzcb_t  ",
               " WHERE gzcb001 = '",8312,"' ",
               "   AND gzcb003  ='Y'        ",          
               " ORDER BY gzcb002           "
   PREPARE sel_s_fin_gzcb002p FROM l_sql
   DECLARE sel_s_fin_gzcb002c CURSOR FOR sel_s_fin_gzcb002p
   LET l_gzcb002 = NULL
   FOREACH sel_s_fin_gzcb002c INTO l_gzcb002
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(l_str)THEN
         LET l_str = l_gzcb002 CLIPPED
      ELSE
         LET l_str = l_str CLIPPED,",",l_gzcb002 CLIPPED
      END IF
   END FOREACH   
   CALL cl_set_combo_scc_part('xrad004','8312',l_str)  
   
   #end add-point
 
   CALL axrq932_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq932.default_search" >}
PRIVATE FUNCTION axrq932_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xreald = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xrea001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xrea002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xrea003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xrea004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xrea005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xrea006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xrea007 = '", g_argv[08], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq932_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_i                   LIKE type_t.num5
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
   ELSE
      CALL axrq932_default()
   END IF
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq932_b_fill()
   ELSE
      CALL axrq932_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xrea_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axrq932_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xrea_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq932_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq932_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               #筆數設定             
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_xrea3_d.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xrea_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xrea2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
         
         BEFORE DISPLAY 
            LET g_current_page = 1
            CALL ui.Interface.refresh()
         BEFORE ROW
            CALL ui.Interface.refresh()          
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq932_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE)
                  CALL cl_set_act_visible("jump,next,last", TRUE)
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE)
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE)
                     CALL cl_set_act_visible("next,last", FALSE)
                  END IF
               END IF
            END IF
            CALL cl_set_comp_visible('sel', FALSE)
            CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
              #CALL axrq932_x01('1=1','axrq932_print_tmp')
               IF NOT cl_ask_confirm("aap-00302") THEN
                  #按否列印匯總
                  CALL axrq932_x02('1=1','axrq932_tmp03',g_input.b_check,g_input.curr,g_input.cre,g_hideflag,g_input.group)   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
               ELSE
                  FOR l_i = 9 TO 14
                     INITIALIZE g_xg_fieldname[l_i] TO NULL
                  END FOR
                  CALL axrq932_x01('1=1','axrq932_tmp02',g_input.b_check,g_input.curr)     #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
              #CALL axrq932_x01('1=1','axrq932_print_tmp')
               IF NOT cl_ask_confirm("aap-00302") THEN
                  #按否列印匯總
                  CALL axrq932_x02('1=1','axrq932_tmp03',g_input.b_check,g_input.curr,g_input.cre,g_hideflag,g_input.group)   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
               ELSE
                  FOR l_i = 9 TO 14
                     INITIALIZE g_xg_fieldname[l_i] TO NULL
                  END FOR
                  CALL axrq932_x01('1=1','axrq932_tmp02',g_input.b_check,g_input.curr)     #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq932_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel', FALSE)
               CALL cl_set_act_visible('selall,selnone,unsel,sel',FALSE)
               EXIT DIALOG
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrq932_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL axrq932_dis()
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axrq932_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xrea_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_xrea2_d)
               LET g_export_id[2]   = "s_detail2"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axrq932_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq932_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq932_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq932_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xrea_d.getLength()
               LET g_xrea_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xrea_d.getLength()
               LET g_xrea_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xrea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrea_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xrea_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xrea_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
             
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION previous
            LET g_action_choice="previous"
            CALL axrq932_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
 
         ON ACTION first
            LET g_action_choice="first"
            CALL axrq932_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG

         ON ACTION jump
            LET g_action_choice="jump"
            CALL axrq932_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION next
            LET g_action_choice="next"
            CALL axrq932_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
            
         ON ACTION last
            LET g_action_choice="last"
            CALL axrq932_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            EXIT DIALOG
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq932_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xrea_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xrea001,xreald,xrea009,xrea005,xrea019,xrea100
           FROM s_detail1[1].b_xrea001,s_detail1[1].b_xreald,s_detail1[1].b_xrea009,s_detail1[1].b_xrea005, 
               s_detail1[1].b_xrea019,s_detail1[1].b_xrea100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
{
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_xrea001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea001
            #add-point:BEFORE FIELD b_xrea001 name="construct.b.page1.b_xrea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea001
            
            #add-point:AFTER FIELD b_xrea001 name="construct.a.page1.b_xrea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea001
            #add-point:ON ACTION controlp INFIELD b_xrea001 name="construct.c.page1.b_xrea001"
 
            #END add-point
 
 
         #----<<b_xrea002>>----
         #----<<b_xreald>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreald
            #add-point:BEFORE FIELD b_xreald name="construct.b.page1.b_xreald"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreald
            
            #add-point:AFTER FIELD b_xreald name="construct.a.page1.b_xreald"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreald
            #add-point:ON ACTION controlp INFIELD b_xreald name="construct.c.page1.b_xreald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept      
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_xreald
            NEXT FIELD b_xreald
            #END add-point
 
 
         #----<<xreald_desc>>----
         #----<<b_xrea009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea009
            #add-point:BEFORE FIELD b_xrea009 name="construct.b.page1.b_xrea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea009
            
            #add-point:AFTER FIELD b_xrea009 name="construct.a.page1.b_xrea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea009
            #add-point:ON ACTION controlp INFIELD b_xrea009 name="construct.c.page1.b_xrea009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO b_xrea009            
            NEXT FIELD b_xrea009   
            #END add-point
 
 
         #----<<xrea009_desc>>----
         #----<<b_xrea004>>----
         #----<<b_xrea005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea005
            #add-point:BEFORE FIELD b_xrea005 name="construct.b.page1.b_xrea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea005
            
            #add-point:AFTER FIELD b_xrea005 name="construct.a.page1.b_xrea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea005
            #add-point:ON ACTION controlp INFIELD b_xrea005 name="construct.c.page1.b_xrea005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apcacomp  IN  ",g_wc_xreacomp, 
                                   " AND apcald IN ",g_wc_xreald
            CALL q_apcadocno()                           
            DISPLAY g_qryparam.return1 TO b_xrea004
            NEXT FIELD b_xrea004
            #END add-point
 
 
         #----<<b_xrea006>>----
         #----<<b_xrea007>>----
         #----<<b_xrea019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea019
            #add-point:BEFORE FIELD b_xrea019 name="construct.b.page1.b_xrea019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea019
            
            #add-point:AFTER FIELD b_xrea019 name="construct.a.page1.b_xrea019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea019
            #add-point:ON ACTION controlp INFIELD b_xrea019 name="construct.c.page1.b_xrea019"
            
            #END add-point
 
 
         #----<<xrea019_desc>>----
         #----<<b_xrea008>>----
         #----<<l_apcc004>>----
         #----<<day>>----
         #----<<day2>>----
         #----<<b_xrea100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xrea100
            #add-point:BEFORE FIELD b_xrea100 name="construct.b.page1.b_xrea100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xrea100
            
            #add-point:AFTER FIELD b_xrea100 name="construct.a.page1.b_xrea100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xrea100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea100
            #add-point:ON ACTION controlp INFIELD b_xrea100 name="construct.c.page1.b_xrea100"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_xrea100     
            NEXT FIELD b_xrea100  }
            #END add-point
 
 
         #----<<b_xrea103>>----
         #----<<b_xrea113>>----
         #----<<l_debt>>----
         #----<<l_xrea103_debt>>----
         #----<<l_xrea113_debt>>----
         #----<<b_xrea003>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.xreasite,g_input.xreasite_desc,g_input.year,
                    g_input.strmon,g_input.endmon,g_input.group,
                    g_input.xrad001,g_input.xrad001_desc,g_input.xrad004,
                    g_input.apca0010,g_input.apca0012,
                    g_input.dedtype,g_input.curr,g_input.b_check,
                    g_input.cre ,g_input.enddate                   
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD xreasite
            LET g_input.xreasite_desc = ''
            IF NOT cl_null(g_input.xreasite) THEN   
               CALL s_fin_account_center_with_ld_chk(g_input.xreasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF                               
               #取得所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_input.xreasite) RETURNING g_sub_success,g_errno,g_xreacomp,g_xreald
               CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_comp_str() RETURNING g_wc_xreacomp
               CALL s_fin_get_wc_str(g_wc_xreacomp) RETURNING g_wc_xreacomp
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
               CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald                  
               LET g_input.xreasite_desc = s_desc_get_department_desc(g_input.xreasite)
               DISPLAY BY NAME g_input.xreasite_desc
               CALL axrq932_dedtype_def() #扣除方式
            END IF
             
         AFTER FIELD xrad001
            LET g_input.xrad001_desc = '' 
            IF NOT cl_null(g_input.xrad001) THEN                 
               LET g_chkparam.arg1 = g_input.xrad001
               LET g_errshow = TRUE   #160318-00025#53
               LET g_chkparam.err_str[1] = "agl-00140:sub-01302|axri014|",cl_get_progname("axri014",g_lang,"2"),"|:EXEPROGaxri014"    #160318-00025#53
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_xrad001") THEN
                  LET g_input.xrad001 =''  
                  NEXT FIELD CURRENT                  
               END IF  
            END IF                             
            # 重新取得帳齡基準日                             
            SELECT xrad004 INTO g_input.xrad004
              FROM xrad_t
             WHERE xradent = g_enterprise
               AND xrad001 = g_input.xrad001
            IF cl_null(g_input.xrad004) THEN LET g_input.xrad004 = '90' END IF
            CALL s_desc_get_xrad001_desc(g_input.xrad001)RETURNING g_input.xrad001_desc
            DISPLAY BY NAME g_input.xrad004,g_input.xrad001_desc

         ON CHANGE curr
            IF g_input.curr ='Y' THEN
               CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,l_xrea103_debt,xrea1031,xrea1032,xrea1033,xrea1034',TRUE)
            ELSE
               CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,l_xrea103_debt,xrea1031,xrea1032,xrea1033,xrea1034',FALSE)
            END IF             
            
         ON CHANGE strmon
            IF g_input.endmon < g_input.strmon THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.code = 'agl-00227'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()                                             
               LET g_input.endmon = g_input.strmon
            END IF
            DISPLAY BY NAME g_input.endmon,g_input.strmon

         ON CHANGE endmon
            IF g_input.endmon < g_input.strmon THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'agl-00228'
               LET g_errparam.extend =''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_input.strmon = g_input.endmon
            END IF
            DISPLAY BY NAME g_input.endmon,g_input.strmon
            
         ON CHANGE cre
#            CALL cl_set_comp_visible('crecurr,crelim',FALSE)
#            IF g_input.cre != 1 THEN
#               CALL cl_set_comp_visible('crecurr,crelim',TRUE)
#            END IF
            
         ON CHANGE group
            CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',FALSE)
            CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',FALSE)
            CALL axrq932_get_type()
            CASE                #151022-00017#4 ---s
               WHEN g_input.group = '1' #帳套+交易對象
                  #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
                  IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
                     CALL cl_set_comp_visible('group1,group2',TRUE)                   
                     CALL cl_set_comp_visible('group1_desc,group2_desc',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('group1,group2,xrea011,xrea016,pmab053',TRUE)                                    
                     CALL cl_set_comp_visible('group1_desc,group2_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)  
                  END IF               
               WHEN g_input.group = '2' #帳套+交易對象+科目
                  #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
                  IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
                     CALL cl_set_comp_visible('group1,group2,group3',TRUE)                   
                     CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc',TRUE)
                  ELSE
                     CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',TRUE)             
                     CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)
                  END IF  #151022-00017#4 ---e---
               WHEN g_input.group ='3' #帳務單號+發票號碼
                  CALL cl_set_comp_visible('group2,group3,xrea011,xrea011_desc,xrea016,xrea016_desc,pmab053,pmab053_desc',TRUE)   #150901-00020#4                 
               WHEN g_input.group = '4' #150401-00001#35 ---s---
                  CALL cl_set_comp_visible('group1,group2,xrea011,xrea016,pmab053',TRUE) 
                  CALL cl_set_comp_visible('group1_desc,group2_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE) 
               WHEN g_input.group = '5'
                  CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',TRUE)             
                  CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)      
                                        #150401-00001#35 ---e---      
            END CASE
            
         AFTER FIELD apca0012
            IF g_input.apca0012 = 'Y' THEN
               LET g_input.dedtype = '4'
            END IF
            
         ON CHANGE apca0012
            IF g_input.apca0012 = 'Y' THEN
               LET g_input.dedtype ='4'
            END IF   
        
        ON CHANGE b_check   #01727
            CALL axrq932_dis()            
         
                
         ON ACTION controlp INFIELD xreasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.xreasite
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#2
            #CALL q_ooef001()        #161021-00050#6 mark
            CALL q_ooef001_46()      #161021-00050#6 add
            LET g_input.xreasite = g_qryparam.return1
            CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
            #取得帳務中心底下之組織範圍            
            CALL s_fin_account_center_comp_str() RETURNING g_wc_xreacomp  
            CALL s_fin_get_wc_str(g_wc_xreacomp) RETURNING g_wc_xreacomp
            #取得帳務中心底下的帳套範圍               
            CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
            CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald      
            CALL s_desc_get_department_desc(g_input.xreasite) RETURNING g_input.xreasite_desc
            DISPLAY BY NAME  g_input.xreasite_desc
            NEXT FIELD xreasite

         ON ACTION controlp INFIELD xrad001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_input.xrad001
            CALL q_xrad001()    
            LET g_input.xrad001 = g_qryparam.return1                               
            SELECT xrad004 INTO g_input.xrad004
              FROM xrad_t
             WHERE xradent = g_enterprise
               AND xrad001 = g_input.xrad001
            IF cl_null(g_input.xrad004)THEN LET g_input.xrad004  = '90' END IF
            CALL s_desc_get_xrad001_desc(g_input.xrad001)RETURNING g_input.xrad001_desc
            DISPLAY BY NAME g_input.xrad001_desc,g_input.xrad004,g_input.xrad001,g_input.xrad004 
            NEXT FIELD xrad001     
         
      ENd INPUT
      
     
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      CALL axrq932_default()
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   #IF g_prog <> 'axrq930' THEN           #160705-00042#10 160713 by sakura mark
   IF g_prog NOT MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
      #CALL axrq932_insert_tmp()  #160505-00007#25 mark
      CALL axrq932_set_page()
      CALL axrq932_fetch1('F')
      LET g_error_show = 1
      IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code   = -100
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN
      END IF
      CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
      CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
      RETURN
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL axrq932_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axrq932.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq932_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_day2            DATE #計算帳齡天數
   DEFINE l_glaa003         LIKE glaa_t.glaa003
   DEFINE l_apcc004         LIKE apcc_t.apcc004  # 90 應收付款日 
   DEFINE l_apcc010         LIKE apcc_t.apcc010  # 03 發票日期     
   DEFINE l_apcc011         LIKE apcc_t.apcc011  # 01 交易單據日期
   DEFINE l_apcc012         LIKE apcc_t.apcc012  # 05 立帳日期
   DEFINE l_apcc013         LIKE apcc_t.apcc013  # 09 交易認定日期
   DEFINE l_apcc014         LIKE apcc_t.apcc014  # 07 出入庫扣帳日期 
   DEFINE l_xreasite        LIKE type_t.chr80
   DEFINE l_xrad001         LIKE type_t.chr80
   DEFINE l_xrad004         LIKE type_t.chr80
   DEFINE l_dedtype         LIKE type_t.chr80  
   DEFINE l_xrea004         LIKE type_t.chr80
   DEFINE l_cre_desc        LIKE type_t.chr80
   DEFINE l_group_desc      LIKE type_t.chr80
   DEFINE l_debt            LIKE type_t.num20_6
   DEFINE g_wc1             STRING  #160811-00009#2
   DEFINE l_ld_str          STRING  #160811-00009#2
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #IF g_prog <> 'axrq930' THEN           #160705-00042#10 160713 by sakura mark
   IF g_prog NOT MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
      CALL axrq932_insert_tmp()
   ELSE
      CALL axrq932_insert_tmp2()
   END IF  
   LET g_wc2 = " 1=1"  #160505-00007#25 add
   
   DELETE FROM axrq932_tmp02     #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
  
   LET l_xreasite = g_input.xreasite,'     ',g_input.xreasite_desc       
   LET l_xrad001  = g_input.xrad001,'     ',g_input.xrad001_desc
   LET l_xrad004  = g_input.xrad004,':',s_desc_gzcbl004_desc('8312',g_input.xrad004)  #帳玲起算基準日
   LET l_dedtype  = g_input.dedtype,':',s_desc_gzcbl004_desc('8328',g_input.dedtype)    
   LET l_group_desc = s_desc_gzcbl004_desc('8330',g_input.group)
   CASE g_input.cre
      WHEN '1'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.1' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
      WHEN '2'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.2' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
      WHEN '3'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.3' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
   END CASE
   #160811-00009#2 Add  ---(S)---
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
   CALL s_fin_account_center_comp_str() RETURNING g_wc1
   CALL s_fin_get_wc_str(g_wc1) RETURNING g_wc1
   LET g_wc1=g_wc1.substring(3,g_wc1.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,g_wc1,'2')  RETURNING l_ld_str   
   LET l_ld_str = cl_replace_str(l_ld_str,'glaald','xreald')   
   #161011-00004#1 Mark ---(S)---
  #IF cl_null(g_wc) THEN
  #   LET g_wc = " 1=1"
  #END IF   
  #LET g_wc = g_wc CLIPPED," AND ",l_ld_str  
   #161011-00004#1 Mark ---(E)---
   #161011-00004#1 Add  ---(S)---
      LET g_wc = l_ld_str
   #161011-00004#1 Add  ---(E)---
   #160811-00009#2 Add  ---(E)---   
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006, 
       xrea007,xrea019,'',xrea008,'','','',xrea100,xrea103,xrea113,'','','',xrea003  ,DENSE_RANK() OVER( ORDER BY xrea_t.xreald, 
       xrea_t.xrea001,xrea_t.xrea002,xrea_t.xrea003,xrea_t.xrea004,xrea_t.xrea005,xrea_t.xrea006,xrea_t.xrea007) AS RANK FROM xrea_t", 
 
 
 
                     "",
                     " WHERE xreaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xrea_t"),
                     " ORDER BY xrea_t.xreald,xrea_t.xrea001,xrea_t.xrea002,xrea_t.xrea003,xrea_t.xrea004,xrea_t.xrea005,xrea_t.xrea006,xrea_t.xrea007"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006,xrea007,xrea019, 
       '',xrea008,'','','',xrea100,xrea103,xrea113,'','','',xrea003",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160505-00007#25 add---s---
   LET g_sql = " SELECT xrae003,xrae004,xrae005     ",
                "   FROM xrae_t                     ",
                "  WHERE xraeent = ",g_enterprise," ",
                "    AND xrae001 = '",g_input.xrad001,"' "
   PREPARE axrq932_pre_1  FROM g_sql
   DECLARE axrq932_curs CURSOR FOR axrq932_pre_1    
   
   #160505-00007#25 add---e---   
   
   LET g_sql = " SELECT ''    ,xrea001,xrea002,xreald,'',xrea009,'',xrea004,xrea005,xrea006,xrea007,xrea019,'',     ",
               "       xrea008,apcc004,'','',xrea100,xrea103,xrea113,'',xrea103_debt,xrea113_debt,'' ",
               " FROM axrq932_tmp                                                                    ",
               " WHERE xreaent= ? AND 1=1 AND xrea002 = '",g_xrea002,"'  AND ", ls_wc,cl_sql_add_filter("xrea_t"),
               "   AND per = '2' AND xrea103 <>  0 "    
   LET g_sql = g_sql, " Order By xrea009,xrea100,xrea008 "
   LET g_b2_wc = ls_wc
   

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq932_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq932_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xrea_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xrea_d[l_ac].sel,g_xrea_d[l_ac].xrea001,g_xrea_d[l_ac].xrea002,g_xrea_d[l_ac].xreald, 
       g_xrea_d[l_ac].xreald_desc,g_xrea_d[l_ac].xrea009,g_xrea_d[l_ac].xrea009_desc,g_xrea_d[l_ac].xrea004, 
       g_xrea_d[l_ac].xrea005,g_xrea_d[l_ac].xrea006,g_xrea_d[l_ac].xrea007,g_xrea_d[l_ac].xrea019,g_xrea_d[l_ac].xrea019_desc, 
       g_xrea_d[l_ac].xrea008,g_xrea_d[l_ac].l_apcc004,g_xrea_d[l_ac].day,g_xrea_d[l_ac].day2,g_xrea_d[l_ac].xrea100, 
       g_xrea_d[l_ac].xrea103,g_xrea_d[l_ac].xrea113,g_xrea_d[l_ac].l_debt,g_xrea_d[l_ac].l_xrea103_debt, 
       g_xrea_d[l_ac].l_xrea113_debt,g_xrea_d[l_ac].xrea003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xrea_d[l_ac].statepic = cl_get_actipic(g_xrea_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_xrea_d[l_ac].xreald,'glaa003') RETURNING g_sub_success,l_glaa003
      #本期起始結束日期      
      CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_xrea002)RETURNING g_strdate,g_enddate
      #IF g_prog = 'axrq930' THEN LET g_enddate = g_input.enddate END IF        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' THEN LET g_enddate = g_input.enddate END IF   #160705-00042#10 160713 by sakura add
      #取得應兌現日
      SELECT xrcc004 INTO g_xrea_d[l_ac].l_apcc004
        FROM xrcc_t
       WHERE xrccent   = g_enterprise
         AND xrccdocno = g_xrea_d[l_ac].xrea005 
         AND xrccseq   = g_xrea_d[l_ac].xrea006
         AND xrcc001   = g_xrea_d[l_ac].xrea007
         AND xrccld    = g_xrea_d[l_ac].xreald
        
      #會計科目
      LET g_xrea_d[l_ac].xrea019_desc = s_desc_get_account_desc(g_xrea_d[l_ac].xreald,g_xrea_d[l_ac].xrea019)
      
      #逾期天數
      LET g_xrea_d[l_ac].day = g_enddate - g_xrea_d[l_ac].l_apcc004 
      IF g_xrea_d[l_ac].day  < 0 OR cl_null(g_xrea_d[l_ac].day) THEN 
         LET  g_xrea_d[l_ac].day  = 0 
      END IF 
      
      #帳齡天數
      LET l_day2 = ''
      SELECT xrcc011,  xrcc010  ,xrcc012  ,xrcc014  ,xrcc013  ,xrcc004
        INTO l_apcc011,l_apcc010,l_apcc012,l_apcc014,l_apcc013,l_apcc004
        FROM xrcc_t
       WHERE xrccent    = g_enterprise
         AND xrccdocno  = g_xrea_d[l_ac].xrea005
         AND xrccseq    = g_xrea_d[l_ac].xrea006
         AND xrcc001    = g_xrea_d[l_ac].xrea007    
      
      CASE  #取帳齡天數 --> l_endate - 立帳日期
         WHEN g_input.xrad004 = '01' 
            IF cl_null(l_apcc011) THEN #01 交易單據日期
               LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
               LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc011   
            END IF 
         WHEN g_input.xrad004 = '03' #發票日期     
           IF cl_null(l_apcc010) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc010 
           END IF            
         WHEN  g_input.xrad004 = '05' #入庫日期 
             IF cl_null(l_apcc012) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc012 
           END IF                          
         WHEN g_input.xrad004 = '07' 
            #07 出入庫扣帳日期 
            IF cl_null(l_apcc014) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc014 
            END IF      
         WHEN g_input.xrad004 = '09'
            #09 交易認定日期
            IF cl_null(l_apcc013) THEN
              LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
            ELSE   
              LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc013 
            END IF          
         WHEN g_input.xrad004 = '90'      
           #09 應收付款日           
           IF cl_null(l_apcc004) THEN
             LET g_xrea_d[l_ac].day2 = g_enddate - g_xrea_d[l_ac].xrea008
           ELSE   
             LET g_xrea_d[l_ac].day2 = g_enddate - l_apcc004 
           END IF               
      END CASE   
      #負的天數給0天
      IF g_xrea_d[l_ac].day2 < 0 THEN LET g_xrea_d[l_ac].day2 = 0 END IF
      #壞帳提列比率
      #CALL axrq932_debt_ref()        #161229-00045#1 mark
      CALL axrq932_get_xrek039(g_xreacomp,g_xrea_d[l_ac].xrea009,g_xrea_d[l_ac].day2)     #161229-00045#1 add
         RETURNING g_xrea_d[l_ac].l_debt                                                  #161229-00045#1 add
     
      #壞帳原幣金額
      LET g_xrea_d[l_ac].l_xrea103_debt = g_xrea_d[l_ac].l_xrea103_debt * g_xrea_d[l_ac].l_debt  /100
      #壞帳本幣金額
      LET g_xrea_d[l_ac].l_xrea113_debt = g_xrea_d[l_ac].l_xrea113_debt * g_xrea_d[l_ac].l_debt  /100 
            
      #161229-00045#1 ---s---
      IF cl_null(g_xrea_d[l_ac].l_debt) THEN LET g_xrea_d[l_ac].l_debt = 0 END IF
      IF cl_null(g_xrea_d[l_ac].l_xrea103_debt) THEN LET g_xrea_d[l_ac].l_xrea103_debt = 0 END IF
      IF cl_null(g_xrea_d[l_ac].l_xrea113_debt) THEN LET g_xrea_d[l_ac].l_xrea113_debt = 0 END IF
      #161229-00045#1 ---e---  


      
      #交易對象/帳套             
      CALL s_desc_get_trading_partner_abbr_desc(g_xrea_d[l_ac].xrea009)RETURNING g_xrea_d[l_ac].xrea009_desc 
      CALL s_desc_get_ld_desc(g_xrea_d[l_ac].xreald) RETURNING g_xrea_d[l_ac].xreald_desc        
      
      #更新temp_taple
      UPDATE axrq932_tmp 
         SET (day2,debt
              ,xrea103_debt,xrea113_debt)  =     
             (g_xrea_d[l_ac].day2,g_xrea_d[l_ac].l_debt,
              g_xrea_d[l_ac].l_xrea103_debt,g_xrea_d[l_ac].l_xrea113_debt )
       WHERE xrea002   = g_xrea002
         AND xrea005   = g_xrea_d[l_ac].xrea005
         AND xrea006   = g_xrea_d[l_ac].xrea006
         AND xrea007   = g_xrea_d[l_ac].xrea007
         AND xrea004   = g_xrea_d[l_ac].xrea004 
         AND per       = '2'         
      
            
#     #報表用
      INSERT INTO axrq932_tmp01    #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp ——> axrq932_tmp01
      VALUES(g_xrea_d[l_ac].xreald,g_xrea_d[l_ac].xreald_desc, 
             g_xrea_d[l_ac].xrea009,g_xrea_d[l_ac].xrea009_desc,l_xrea004, 
             g_xrea_d[l_ac].xrea005,g_xrea_d[l_ac].xrea006,g_xrea_d[l_ac].xrea007,
              g_xrea_d[l_ac].xrea019,g_xrea_d[l_ac].xrea019_desc,
              g_xrea_d[l_ac].xrea008,g_xrea_d[l_ac].l_apcc004, 
             g_xrea_d[l_ac].day,g_xrea_d[l_ac].day2,g_xrea_d[l_ac].xrea100,g_xrea_d[l_ac].xrea103,g_xrea_d[l_ac].xrea113, 
             g_xrea_d[l_ac].l_debt,g_xrea_d[l_ac].l_xrea103_debt,g_xrea_d[l_ac].l_xrea113_debt,
             l_xreasite, g_input.year,g_xrea_d[l_ac].xrea002,l_xrad001,l_xrad004,l_dedtype                )

      #XG用---yangtt
      LET l_xrea004 = g_xrea_d[l_ac].xrea004,":",s_desc_gzcbl004_desc('8502',g_xrea_d[l_ac].xrea004)
      INSERT INTO axrq932_tmp02       #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
       VALUES(l_xreasite, g_input.year,g_xrea_d[l_ac].xrea002,l_xrad001,l_xrad004,l_dedtype,l_cre_desc,l_group_desc,
              g_xrea_d[l_ac].xrea001,g_xrea_d[l_ac].xrea002,g_xrea_d[l_ac].xreald, 
              g_xrea_d[l_ac].xreald_desc,g_xrea_d[l_ac].xrea009,g_xrea_d[l_ac].xrea009_desc,l_xrea004, 
              g_xrea_d[l_ac].xrea005,g_xrea_d[l_ac].xrea006,g_xrea_d[l_ac].xrea007,   
              g_xrea_d[l_ac].xrea019,g_xrea_d[l_ac].xrea019_desc,              
              g_xrea_d[l_ac].xrea008,g_xrea_d[l_ac].l_apcc004, 
              g_xrea_d[l_ac].day,g_xrea_d[l_ac].day2,g_xrea_d[l_ac].xrea100,g_xrea_d[l_ac].xrea103,g_xrea_d[l_ac].xrea113, 
              g_xrea_d[l_ac].l_debt,g_xrea_d[l_ac].l_xrea103_debt,g_xrea_d[l_ac].l_xrea113_debt)
      #XG用---yangtt
      #end add-point
 
      CALL axrq932_detail_show("'1'")      
 
      CALL axrq932_xrea_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xrea_d.deleteElement(g_xrea_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL axrq932_b_fill2()
   #end add-point
 
   LET g_detail_cnt = g_xrea_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq932_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq932_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq932_detail_action_trans()
 
   IF g_xrea_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq932_fetch()
   END IF
   
      CALL axrq932_filter_show('xrea001','b_xrea001')
   CALL axrq932_filter_show('xreald','b_xreald')
   CALL axrq932_filter_show('xrea009','b_xrea009')
   CALL axrq932_filter_show('xrea005','b_xrea005')
   CALL axrq932_filter_show('xrea019','b_xrea019')
   CALL axrq932_filter_show('xrea100','b_xrea100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq932_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrq932.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq932_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq932_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ooef017     LIKE ooef_t.ooef017   #161111-00049#2 Add
   DEFINE l_glaa004     LIKE glaa_t.glaa004   #161111-00049#2 Add

   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   #161111-00049#2 Add  ---(S)---
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
   #161111-00049#2 Add  ---(E)---
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xrea001,xreald,xrea009,xrea005,xrea019,xrea100
                          FROM s_detail1[1].b_xrea001,s_detail1[1].b_xreald,s_detail1[1].b_xrea009,s_detail1[1].b_xrea005, 
                              s_detail1[1].b_xrea019,s_detail1[1].b_xrea100
 
         BEFORE CONSTRUCT
                     DISPLAY axrq932_filter_parser('xrea001') TO s_detail1[1].b_xrea001
            DISPLAY axrq932_filter_parser('xreald') TO s_detail1[1].b_xreald
            DISPLAY axrq932_filter_parser('xrea009') TO s_detail1[1].b_xrea009
            DISPLAY axrq932_filter_parser('xrea005') TO s_detail1[1].b_xrea005
            DISPLAY axrq932_filter_parser('xrea019') TO s_detail1[1].b_xrea019
            DISPLAY axrq932_filter_parser('xrea100') TO s_detail1[1].b_xrea100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrea001>>----
         #Ctrlp:construct.c.filter.page1.b_xrea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea001
            #add-point:ON ACTION controlp INFIELD b_xrea001 name="construct.c.filter.page1.b_xrea001"
 
            #END add-point
 
 
         #----<<b_xrea002>>----
         #----<<b_xreald>>----
         #Ctrlp:construct.c.filter.page1.b_xreald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreald
            #add-point:ON ACTION controlp INFIELD b_xreald name="construct.c.filter.page1.b_xreald"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreald
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               CALL q_authorised_ld()
               DISPLAY g_qryparam.return1 TO b_xreald
               NEXT FIELD b_xreald
            #END add-point
 
 
         #----<<xreald_desc>>----
         #----<<b_xrea009>>----
         #Ctrlp:construct.c.filter.page1.b_xrea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea009
            #add-point:ON ACTION controlp INFIELD b_xrea009 name="construct.c.filter.page1.b_xrea009"
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.arg1 = "('2','3')"   #161111-00049#2 MOd 1,3 --> 2,3
              #161111-00049#2 Add  ---(S)---
              IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                 LET g_qryparam.where = g_sql_ctrl
              END IF
              #161111-00049#2 Add  ---(E)---
              CALL q_pmaa001_1()
              DISPLAY g_qryparam.return1 TO b_xrea009
              NEXT FIELD b_xrea009
            #END add-point
 
 
         #----<<xrea009_desc>>----
         #----<<b_xrea004>>----
         #----<<b_xrea005>>----
         #Ctrlp:construct.c.filter.page1.b_xrea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea005
            #add-point:ON ACTION controlp INFIELD b_xrea005 name="construct.c.filter.page1.b_xrea005"
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              LET g_qryparam.where = " xrcacomp  IN  ",g_wc_xreacomp,
                                     " AND xrcald IN ",g_wc_xreald
              CALL q_xrcadocno()
              DISPLAY g_qryparam.return1 TO b_xrea005
              NEXT FIELD b_xrea005
            #END add-point
 
 
         #----<<b_xrea006>>----
         #----<<b_xrea007>>----
         #----<<b_xrea019>>----
         #Ctrlp:construct.c.filter.page1.b_xrea019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea019
            #add-point:ON ACTION controlp INFIELD b_xrea019 name="construct.c.filter.page1.b_xrea019"
            #161111-00049#2 Add  ---(S)---
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = " glac001 = '",l_glaa004,"'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xrea019  #顯示到畫面上
            NEXT FIELD b_xrea019                     #返回原欄位
            #161111-00049#2 Add  ---(E)---

            #END add-point
 
 
         #----<<xrea019_desc>>----
         #----<<b_xrea008>>----
         #----<<l_apcc004>>----
         #----<<day>>----
         #----<<day2>>----
         #----<<b_xrea100>>----
         #Ctrlp:construct.c.filter.page1.b_xrea100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrea100
            #add-point:ON ACTION controlp INFIELD b_xrea100 name="construct.c.filter.page1.b_xrea100"
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
              CALL q_ooai001()
              DISPLAY g_qryparam.return1 TO b_xrea100
              NEXT FIELD b_xrea100
            #END add-point
 
 
         #----<<b_xrea103>>----
         #----<<b_xrea113>>----
         #----<<l_debt>>----
         #----<<l_xrea103_debt>>----
         #----<<l_xrea113_debt>>----
         #----<<b_xrea003>>----
   
 
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axrq932_filter_show('xrea001','b_xrea001')
   CALL axrq932_filter_show('xreald','b_xreald')
   CALL axrq932_filter_show('xrea009','b_xrea009')
   CALL axrq932_filter_show('xrea005','b_xrea005')
   CALL axrq932_filter_show('xrea019','b_xrea019')
   CALL axrq932_filter_show('xrea100','b_xrea100')
 
    
   CALL axrq932_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq932_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="axrq932.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq932_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axrq932_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.insert" >}
#+ insert
PRIVATE FUNCTION axrq932_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq932.modify" >}
#+ modify
PRIVATE FUNCTION axrq932_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq932_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.delete" >}
#+ delete
PRIVATE FUNCTION axrq932_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq932_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq932_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_xrea_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xrea_d.getLength() AND g_xrea_d.getLength() > 0
            LET g_detail_idx = g_xrea_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xrea_d.getLength() THEN
               LET g_detail_idx = g_xrea_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axrq932.mask_functions" >}
 &include "erp/axr/axrq932_mask.4gl"
 
{</section>}
 
{<section id="axrq932.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 新增臨時表
# Memo...........:
# Usage..........: CALL axrq932_create_tmp()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_create_tmp()

   DROP TABLE axrq932_tmp;
      CREATE TEMP TABLE axrq932_tmp(
             xrea001       LIKE xrea_t.xrea001,     #年度
             xrea002       LIKE xrea_t.xrea002,     #期別
             xreald        LIKE xrea_t.xreald,
             xrea009       LIKE xrea_t.xrea009,     #交易對象
             xrea004       LIKE xrea_t.xrea004,     #帳款單性質
             xrea005       LIKE xrea_t.xrea005,     #單據號碼
             xrea006       LIKE xrea_t.xrea006,     #項次
             xrea007       LIKE xrea_t.xrea007,     #項序
             xrea008       LIKE xrea_t.xrea008,     #立帳日期
             apcc004       LIKE apcc_t.apcc004,     #應兌現日
             day2          LIKE type_t.chr500,      #帳齡天數
             xrea100       LIKE xrea_t.xrea100,     #幣別   
             xrea103       LIKE xrea_t.xrea103,     #原幣未沖金額
             xrea113       LIKE xrea_t.xrea113,     #本幣未沖金額
             debt          LIKE xrac_t.xrac008,     #壞帳提列比率
             xrea103_debt  LIKE xrea_t.xrea103,     #壞帳原幣金額
             xrea113_debt  LIKE xrea_t.xrea113,     #壞帳本幣金額
             xrea019       LIKE xrea_t.xrea019,     #應付科目      1
             xrea011       LIKE xrea_t.xrea011,     #業務部門      3
             xrea016       LIKE xrea_t.xrea016,     #業務人員          
             per           LIKE type_t.chr10,       #上期資料flag
             xreaent       LIKE xrea_t.xreaent,
             apcc108       LIKE apcc_t.apcc108,
             apcc118       LIKE apcc_t.apcc118,
             xrea044       LIKE xrea_t.xrea044,     #發票號碼  #150901-00020#4
             xrea045       LIKE xrea_t.xrea045                #150901-00020#4
              )       
   CREATE INDEX aap_ix1 ON axrq932_temp (xrea002)
   
   DROP TABLE axrq932_tmp01;   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp ——> axrq932_tmp01
      CREATE TEMP TABLE axrq932_tmp01(  #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp ——> axrq932_tmp01
             xreald         LIKE xrea_t.xreald, 
             xreald_desc    LIKE type_t.chr500, 
             xrea009        LIKE xrea_t.xrea009, 
             xrea009_desc   LIKE type_t.chr500, 
             l_xrea004      LIKE type_t.chr80, 
             xrea005        LIKE xrea_t.xrea005, 
             xrea006        LIKE xrea_t.xrea006, 
             xrea007        LIKE xrea_t.xrea007,
             xrea019        LIKE xrea_t.xrea019,
             xrea019_desc   LIKE type_t.chr100,             
             xrea008        LIKE xrea_t.xrea008, 
             l_apcc004      LIKE type_t.dat, 
             day            LIKE type_t.chr500, 
             day2           LIKE type_t.chr500, 
             xrea100        LIKE xrea_t.xrea100, 
             xrea103        LIKE xrea_t.xrea103, 
             xrea113        LIKE xrea_t.xrea113, 
             l_debt         LIKE type_t.num20_6, 
             l_xrea103_debt LIKE type_t.num20_6, 
             l_xrea113_debt LIKE type_t.num20_6, 
             l_xreasite      LIKE type_t.chr80,
             l_year          LIKE xrea_t.xrea001,
             l_mon           LIKE xrea_t.xrea002,
             l_xrad001       LIKE type_t.chr80,
             l_xrad004       LIKE type_t.chr80,
             l_dedtype       LIKE type_t.chr80    
                   )  
                   
   DROP TABLE axrq932_tmp02;     #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
      CREATE TEMP TABLE axrq932_tmp02(        #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp1 ——> axrq932_tmp02
         l_xreasite      LIKE type_t.chr80,
         l_year          LIKE xrea_t.xrea001,
         l_mon           LIKE xrea_t.xrea002,
         l_xrad001       LIKE type_t.chr80,
         l_xrad004       LIKE type_t.chr80,
         l_dedtype       LIKE type_t.chr80,
         l_cre_desc      LIKE type_t.chr80,
         l_group_desc    LIKE type_t.chr80,
         xrea001 LIKE xrea_t.xrea001, 
         xrea002 LIKE xrea_t.xrea002, 
         xreald LIKE xrea_t.xreald, 
         xreald_desc LIKE type_t.chr500, 
         xrea009 LIKE xrea_t.xrea009, 
         xrea009_desc LIKE type_t.chr500, 
         xrea004 LIKE type_t.chr500, 
         xrea005 LIKE xrea_t.xrea005, 
         xrea006 LIKE xrea_t.xrea006, 
         xrea007 LIKE xrea_t.xrea007,
         xrea019        LIKE xrea_t.xrea019,
         xrea019_desc   LIKE type_t.chr100,           
         xrea008 LIKE xrea_t.xrea008, 
         l_apcc004 LIKE type_t.dat, 
         day LIKE type_t.chr500, 
         day2 LIKE type_t.chr500, 
         xrea100 LIKE xrea_t.xrea100, 
         xrea103 LIKE xrea_t.xrea103, 
         xrea113 LIKE xrea_t.xrea113, 
         l_debt LIKE type_t.num20_6, 
         l_xrea103_debt LIKE type_t.num20_6, 
         l_xrea113_debt LIKE type_t.num20_6
   )
   
   DROP TABLE axrq932_tmp03;   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
      CREATE TEMP TABLE axrq932_tmp03(   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
      l_xreasite      LIKE type_t.chr80,
      l_year          LIKE xrea_t.xrea001,
      l_mon           LIKE xrea_t.xrea002,
      l_xrad001       LIKE type_t.chr80,
      l_xrad004       LIKE type_t.chr80,
      l_dedtype       LIKE type_t.chr80,
      l_cre_desc      LIKE type_t.chr80,
      l_group_desc    LIKE type_t.chr80,
      group1         LIKE type_t.chr80,      
      group1_desc    LIKE type_t.chr80,      
      group2         LIKE type_t.chr80,
      group2_desc    LIKE type_t.chr80,      
      group3         LIKE type_t.chr80,
      group3_desc    LIKE type_t.chr80,
      xrea011        LIKE xrea_t.xrea011, #部門
      xrea011_desc   LIKE type_t.chr80,
      xrea016        LIKE xrea_t.xrea016, #人員
      xrea016_desc   LIKE type_t.chr80,    
      pmab053        LIKE pmab_t.pmab053, #交易條件
      pmab053_desc   LIKE type_t.chr80,      
      xrea100        LIKE xrea_t.xrea100, #幣別 
      xrea1031       LIKE xrea_t.xrea103, #原幣期初金額
      xrea1032       LIKE xrea_t.xrea103, #原幣本期增加金額
      xrea1033       LIKE xrea_t.xrea103, #原幣本期減少金額 
      xrea1034       LIKE xrea_t.xrea103, #原幣期末金額
      xrea1131       LIKE xrea_t.xrea113, #本幣期初金額
      xrea1132       LIKE xrea_t.xrea113, #本幣本期增加金額
      xrea1133       LIKE xrea_t.xrea103, #本幣本期減少金額
      xrea1136       LIKE xrea_t.xrea103, #151223-00001#4
      xrea1134       LIKE xrea_t.xrea103, #本幣期末金額  
      xrea1035       LIKE xrea_t.xrea103, #原幣壞帳數
      xrea1135       LIKE xrea_t.xrea113, #本幣壞帳數
      crecurr        LIKE xrea_t.xrea100, #信用額度幣別
      crelim         LIKE xrea_t.xrea113, #信用額度
      stomoney       LIKE xrea_t.xrea113, #本期入庫金額
      advmoney       LIKE xrea_t.xrea113, #本期預付金額 
      retmoney       LIKE xrea_t.xrea113, #本期退貨金額
      addmoney       LIKE xrea_t.xrea113, #本期調增金額      
      adjmoney       LIKE xrea_t.xrea113, #調匯金額
      redmoney       LIKE xrea_t.xrea113, #本期調減金額
      paymoney       LIKE xrea_t.xrea113, #實際付款金額
      anomoney       LIKE xrea_t.xrea113, #本期其他沖帳金額
      xrea103_01     LIKE xrea_t.xrea103, #未沖本幣
      xrea113_01     LIKE xrea_t.xrea113, #本幣壞帳
      xrea103_02     LIKE xrea_t.xrea103,
      xrea113_02     LIKE xrea_t.xrea113,
      xrea103_03     LIKE xrea_t.xrea103,
      xrea113_03     LIKE xrea_t.xrea113,
      xrea103_04     LIKE xrea_t.xrea103,
      xrea113_04     LIKE xrea_t.xrea113,
      xrea103_05     LIKE xrea_t.xrea103,
      xrea113_05     LIKE xrea_t.xrea113,
      xrea103_06     LIKE xrea_t.xrea103,
      xrea113_06     LIKE xrea_t.xrea113,
      xrea103_07     LIKE xrea_t.xrea103,
      xrea113_07     LIKE xrea_t.xrea113,
      xrea103_08     LIKE xrea_t.xrea103,
      xrea113_08     LIKE xrea_t.xrea113,
      xrea103_09     LIKE xrea_t.xrea103,
      xrea113_09     LIKE xrea_t.xrea113,
      xrea103_10     LIKE xrea_t.xrea103,
      xrea113_10     LIKE xrea_t.xrea113,
      xrea103_11     LIKE xrea_t.xrea103,
      xrea113_11     LIKE xrea_t.xrea113,
      xrea103_12     LIKE xrea_t.xrea103,
      xrea113_12     LIKE xrea_t.xrea113,
      xrea103_13     LIKE xrea_t.xrea103,
      xrea113_13     LIKE xrea_t.xrea113,
      xrea103_14     LIKE xrea_t.xrea103,
      xrea113_14     LIKE xrea_t.xrea113,
      xrea103_15     LIKE xrea_t.xrea103,
      xrea113_15     LIKE xrea_t.xrea113,
      xrea103_16     LIKE xrea_t.xrea103,
      xrea113_16     LIKE xrea_t.xrea113,
      xrea103_17     LIKE xrea_t.xrea103,
      xrea113_17     LIKE xrea_t.xrea113,
      xrea103_18     LIKE xrea_t.xrea103,
      xrea113_18     LIKE xrea_t.xrea113,
      xrea103_19     LIKE xrea_t.xrea103,
      xrea113_19     LIKE xrea_t.xrea113,
      xrea103_20     LIKE xrea_t.xrea103,
      xrea113_20     LIKE xrea_t.xrea113,
      xrea103_21     LIKE xrea_t.xrea103,
      xrea113_21     LIKE xrea_t.xrea113,
      mon1           LIKE xrea_t.xrea113, 
      mon2           LIKE xrea_t.xrea113,
      mon3           LIKE xrea_t.xrea113,
      mon4           LIKE xrea_t.xrea113, 
      mon5           LIKE xrea_t.xrea113, 
      mon6           LIKE xrea_t.xrea113, 
      mon7           LIKE xrea_t.xrea113, 
      mon8           LIKE xrea_t.xrea113, 
      mon9           LIKE xrea_t.xrea113,                 
      mon10          LIKE xrea_t.xrea113,
      mon11          LIKE xrea_t.xrea113,
      mon12          LIKE xrea_t.xrea113
      )

END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........:
# Usage..........: CALL axrq932_insert_tmp()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_insert_tmp()
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_ld            LIKE glaa_t.glaald  
DEFINE l_preyear       LIKE xrea_t.xrea001 #上期年
DEFINE l_premon        LIKE xrea_t.xrea002 #上期月
DEFINE l_strdate       LIKE apca_t.apcadocdt
DEFINE l_enddate       LIKE apca_t.apcadocdt
DEFINE l_date1         LIKE apca_t.apcadocdt
DEFINE l_date2         LIKE apca_t.apcadocdt 
DEFINE l_xrea001       LIKE xrea_t.xrea001
DEFINE l_xrea002       LIKE xrea_t.xrea002
DEFINE l_ooef017       LIKE ooef_t.ooef017   #161111-00049#2 Add
 
   
   DELETE FROM axrq932_tmp   
   LET g_sql = " SELECT glaald FROM glaa_t ",
               "  WHERE glaaent = ",g_enterprise,"  ",
               "    AND glaald IN ",g_wc_xreald CLIPPED,
               "    AND glaastus = 'Y' ",#161111-00049#2 Add
               "    AND (glaa008 = 'Y' OR glaa014 = 'Y') " 
   PREPARE axrq932_ldp1 FROM g_sql
   DECLARE axrq932_ldc1 CURSOR FOR axrq932_ldp1      
   FOREACH axrq932_ldc1 INTO l_ld
      CALL s_ld_sel_glaa(l_ld,'glaa003') RETURNING g_sub_success,l_glaa003     
      #取上期會計年月
      CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_xrea002)
                        RETURNING g_sub_success,l_preyear,l_premon

      #161111-00049#2 Add  ---(S)---
       SELECT ooef017 INTO l_ooef017 FROM ooef_t
        WHERE ooefent = g_enterprise
          AND ooef001 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_ld)
          AND ooefstus = 'Y'
       CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
      #161111-00049#2 Add  ---(E)---

      LET g_sql =   "   INSERT INTO axrq932_tmp                                      ", #上期年月 per =1
                    "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",
                    "           xrea005,xrea006,xrea007,xrea008,'',0,xrea100,   ",                                                                              
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN ",  #xrea113 * -1 ELSE xrea113 END), ", #170124-00013#1 mark
                    #170124-00013#3 ---s---
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) * -1               ",
                    "            ELSE      ",
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' ) ='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END),              ",  
                    #170124-00013#3 ---e---                  
                    "           0,                                                                                                    ",      
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN ",  #xrea113 * -1 ELSE xrea113 END), ", #170124-00013#1 mark                                                                
                    #170124-00013#3 ---s---
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) * -1               ",
                    "            ELSE      ",
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' ) ='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END),              ",  
                    #170124-00013#3 ---e---                                            
                    "           xrea019,xrea011,xrea016,'1',xreaent,0,0                                      ",
                    "           ,xrea044,xrea045                                                             ", #150901-00020#4     
                    "      FROM xrea_t                                                                       ", 
                    "     WHERE xreaent = '",g_enterprise,"'                                                 ",
                    "       AND xreald = '",l_ld,"'                                                          ",
                    "       AND xrea003 = 'AR'                                                               ",
                    "       AND xrea001 = '",l_preyear,"'                                                    ",
                    "       AND xrea002 = '",l_premon,"'                                                     ",
                    "       AND xreacomp IN  ", g_wc_xreacomp                          
      LET g_sql = g_sql CLIPPED,
                  " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                 " OR (xrea004 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (xrea004 LIKE '2%') "
      END IF
     #LET g_sql = g_sql CLIPPED,")",   #161111-00049#2 Mark
      #161111-00049#2 Add  ---(S)---
      LET g_sql = g_sql CLIPPED,")"
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrea009 )"
      END IF
      LET g_sql = g_sql CLIPPED,
      #161111-00049#2 Add  ---(E)---
                       "     UNION  ",           # 本期區間 per =2
                       "   SELECT  xrea001,xrea002,xreald,xrea009,xrea004,              ",  
                       "           xrea005,xrea006,xrea007,xrea008,'',0,xrea100,   ",                                                    
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",
                       "           0,                                                                                                    ",   
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END), ",
                       "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea113 *-1 ELSE xrea113 END), ",   
                       "           xrea019,xrea011,xrea016,'2',xreaent,0,0                                     ",
                       "           ,xrea044,xrea045                                                            ", #150901-00020#4
                       "      FROM xrea_t                                                                      ", 
                       "     WHERE xreaent = '",g_enterprise,"'                                                ",
                       "       AND xreald = '",l_ld,"'                                                         ",
                       "       AND xrea003 = 'AR'                                                              ",
                       "       AND xrea001 = '",g_input.year,"'                                                ",
                       "       AND xrea002 BETWEEN  '",g_input.strmon,"' AND '",g_input.endmon,"'              ",
                       "       AND xreacomp IN  ", g_wc_xreacomp
      LET g_sql = g_sql CLIPPED,
                       " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                       " OR (xrea004 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                      " OR (xrea004 LIKE '2%') "
      END IF    
      LET g_sql = g_sql CLIPPED,")"   
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrea009 )"
      END IF
      #161111-00049#2 Add  ---(E)---   
      PREPARE axrq932_ins_tmp_1 FROM g_sql
      EXECUTE axrq932_ins_tmp_1 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF    
   
      CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_xrea002)RETURNING l_strdate,l_date1 #開始日期
      #如果取不到取上期會計日期的起始日期
      IF cl_null(l_strdate) THEN
         CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_xrea002)
                          RETURNING g_sub_success,l_xrea001,l_xrea002
         CALL s_fin_date_get_period_range(l_glaa003,l_xrea001,l_xrea002)RETURNING l_strdate,l_date1 #開始日期                    
      END IF
      CALL s_fin_date_get_period_range(l_glaa003,g_input.year,g_xrea002)RETURNING l_date2,l_enddate #結束日期
      IF cl_null(l_enddate) THEN
         CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_xrea002)
                          RETURNING g_sub_success,l_xrea001,l_xrea002
         CALL s_fin_date_get_period_range(l_glaa003,l_xrea001,l_xrea002)RETURNING l_date2,l_enddate #結束日期                    
      END IF
      IF cl_null(l_strdate) OR cl_null(l_enddate) THEN CONTINUE FOREACH END IF
      LET g_sql =  "   INSERT INTO axrq932_tmp ", 
                   "   SELECT  to_char(xrcadocdt,'yyyy'),to_char(xrcadocdt,'mm'),xrccld,xrca004,xrca001,    ",
                   "           xrccdocno,xrccseq,xrcc001,xrcadocdt,xrcc004,0,xrca100,                       ",
                   "           0,0,0,0,0,                                                                   ",
                   "           xrca035,xrca015,xrca014,3,xrcaent,            ",
                   "(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN xrcc108 *-1 ELSE xrcc108 END),  ",
                   "(CASE WHEN (xrca001 ='02' OR xrca001 = '04' OR xrca001 LIKE '2%') THEN (xrcc113+xrcc118) *-1 ELSE (xrcc113+xrcc118) END)  ",
                   "           ,xrcc009,xrca008                                                             ", #150901-00020#4
                   "      FROM xrca_t,xrcc_t                                                                ",
                   "    WHERE xrcaent = xrccent AND xrcaent = '",g_enterprise,"'                            ",
                   "      AND xrcadocno = xrccdocno AND xrcald = xrccld                                     ",
                   "      AND xrcastus = 'Y'                                                                ",
                   "      AND xrcadocdt BETWEEN '",l_strdate,"' AND '",l_enddate,"'                         ",      
                   "      AND xrcald = '",l_ld,"'                                                           ",
                   "      AND xrcacomp IN  ", g_wc_xreacomp
      LET g_sql = g_sql CLIPPED,
                   " AND ((xrca001 NOT LIKE '2%' AND xrca001 NOT LIKE '0%') "         
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                        " OR (xrca001 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (xrca001 LIKE '2%') "
      END IF       
      LET g_sql = g_sql CLIPPED,")"
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrca004 )"
      END IF
      #161111-00049#2 Add  ---(E)---
      PREPARE axrq932_ins_tmp_2 FROM g_sql
      EXECUTE axrq932_ins_tmp_2 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF 
    
   END FOREACH  
   
   SELECT COUNT(*) INTO l_cnt FROM axrq932_tmp
END FUNCTION

################################################################################
# Descriptions...: 插入臨時表
# Memo...........: axrq930使用
# Usage..........: CALL axrq932_insert_tmp2()
# Date & Author..: 2015/09/24 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_insert_tmp2()
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_glaa003       LIKE glaa_t.glaa003  #會計參照表號
DEFINE l_glcb007       LIKE glcb_t.glcb007  
DEFINE l_ld            LIKE glaa_t.glaald   
DEFINE l_preyear       LIKE xrea_t.xrea001  #上期年
DEFINE l_premon        LIKE xrea_t.xrea002  #上期月
DEFINE l_strdate       LIKE apca_t.apcadocdt
DEFINE l_str1          STRING
DEFINE l_str2          STRING
DEFINE l_ooef017       LIKE ooef_t.ooef017   #161111-00049#2 Add
DEFINE l_xrea017       STRING                 #161208-00002#1
DEFINE l_s_fin_1002    LIKE type_t.chr1       #161208-00002#1

   #161208-00002#1---s---
   CALL cl_get_para(g_enterprise,g_xreacomp,'S-FIN-1002') RETURNING l_s_fin_1002
   IF l_s_fin_1002 = '3' THEN
      LET l_xrea017 = 'xrcb029' 
   ELSE
      LET l_xrea017 = 'a.xrca035' 
   END IF
   #161208-00002#1---e---

   DELETE FROM axrq932_tmp 
   CALL s_date_get_first_date(g_input.enddate) RETURNING l_strdate 
   LET g_input.year = YEAR(g_input.enddate)
   LET g_xrea002    = MONTH(g_input.enddate)
  
  
   LET g_sql = " SELECT glaald FROM glaa_t ",
               "  WHERE glaaent = ",g_enterprise," ",
               "    AND glaald IN ",g_wc_xreald CLIPPED,
               "    AND glaastus = 'Y' ",#161111-00049#2 Add
               "    AND (glaa008 = 'Y' OR glaa014 = 'Y') " 
   PREPARE aapq932_ldp2 FROM g_sql
   DECLARE aapq932_ldc2 CURSOR FOR aapq932_ldp2   
   
   FOREACH aapq932_ldc2 INTO l_ld
      #取上期會計年月
      CALL s_ld_sel_glaa(l_ld,'glaa003') RETURNING g_sub_success,l_glaa003 
      CALL s_fin_date_get_last_period(l_glaa003,l_ld,g_input.year,g_xrea002)
          RETURNING g_sub_success,l_preyear,l_premon      

      #161111-00049#2 Add  ---(S)---
       SELECT ooef017 INTO l_ooef017 FROM ooef_t
        WHERE ooefent = g_enterprise
          AND ooef001 IN (SELECT glaacomp FROM glaa_t WHERE glaaent = g_enterprise AND glaald = l_ld)
          AND ooefstus = 'Y'
       CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',l_ooef017) RETURNING g_sub_success,g_sql_ctrl
      #161111-00049#2 Add  ---(E)---

      LET g_sql =   "   INSERT INTO axrq932_tmp                                      ", #上期年月 per =1
                    "   SELECT  DISTINCT xrea001,xrea002,xreald,xrea009,xrea004,              ",   #161102-00021#1 add DISTINCT lujh
                    "           xrea005,xrea006,xrea007,xrea008,'',0,xrea100,   ",                                                                              
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 *-1 ELSE xrea103 END),  ",
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN ", #xrea113 * -1 ELSE xrea113 END), ", #170124-00013#1 mark  
                     #170124-00013#1 ---s---
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xrea001 = xreb001 AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) * -1               ",
                    "            ELSE      ",
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' ) ='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xrea001 = xreb001 AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END),              ",  
                    #170124-00013#1 ---e---      
                    "           0,                                                                                                     ",      
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN xrea103 * -1 ELSE xrea103 END), ",
                    "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN ", #xrea113 * -1 ELSE xrea113 END), ", #170124-00013#1 mark
                    #170124-00013#1 ---s---
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xrea001 = xreb001 AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) * -1               ",
                    "            ELSE      ",
                    "           (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR' ) ='2'                                       ",
                    "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = xrea002 ",
                    "                                AND xrea001 = xreb001 AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )  ELSE xrea113 END ) END),              ",  
                    #170124-00013#1 ---e---              
                    "           xrea019,xrea011,xrea016,'1',xreaent,0,0                                      ",
                    "           ,xrea044,xrea045                                                             ", #150901-00020#4     
                    "      FROM xrea_t                                                                       ", 
                    "     WHERE xreaent = '",g_enterprise,"'                                                 ",
                    "       AND xreald = '",l_ld,"'                                                          ",
                    "       AND xrea003 = 'AR'                                                               ",
                    "       AND xrea001 = '",l_preyear,"'                                                    ",
                    "       AND xrea002 = '",l_premon,"'                                                     ",
                    "       AND xreacomp IN  ", g_wc_xreacomp                          
      LET g_sql = g_sql CLIPPED,
                  " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                 " OR (xrea004 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (xrea004 LIKE '2%') "
      END IF   
      
      LET g_sql = g_sql CLIPPED,")"   
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrea009 )"
      END IF
      #161111-00049#2 Add  ---(E)---   
      PREPARE axrq932_ins_tmp_31 FROM g_sql
      EXECUTE axrq932_ins_tmp_31 
      
      LET g_sql = "   INSERT INTO axrq932_tmp                                      ", #上期年月 per =1  
                  "   SELECT  DISTINCT '",YEAR(g_input.enddate),"','",MONTH(g_input.enddate),"',xreald,xrea009,xrea004,            ",    #161102-00021#1 add DISTINCT lujh
                  "           xrea005,xrea006,xrea007,xrea008,'',0,xrea100,                                                        ",                                                                              
                  "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN                               ",
                  "           (xrea103-COALESCE(xrce109,0)-COALESCE(apce109,0)-COALESCE(xrce1091,0)-COALESCE(xrcf103,0)) * -1 ELSE  ",
                  "           (xrea103-COALESCE(xrce109,0)-COALESCE(apce109,0)-COALESCE(xrce1091,0)-COALESCE(xrcf103,0)) END),      ",
                  "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN                               ",
                  #"           (xrea113-COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)) * -1 ELSE  ", #170217-00022#1 mark
                  #"           (xrea113-COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)) END),      ", #170217-00022#1 mark
                  #170217-00022#1---s---
                  "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                        ",
                  "                THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = '",l_premon,"' ",
                  "                                    AND xreb001 = '",l_preyear,"' AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )                 ",
                  "                          - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)                                                                             ",                                       
                  "                ELSE xrea113 -COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)  END ) * -1                                                               ",
                  "          ELSE      ",
                  "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  ) ='2'                                         ",
                  "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = '",l_premon,"' ",
                  "                               AND xreb001 = '",l_preyear,"'  AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )                 ", 
                  "                          - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)                                                                            ",
                  "                ELSE xrea113 - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0) END ) END),                                                              ",  
                  #170217-00022#1 ---e---                              
                  "           0,                                                                                                    ",      
                  "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN                                ",
                  "           (xrea103-COALESCE(xrce109,0)-COALESCE(apce109,0)-COALESCE(xrce1091,0)-COALESCE(xrcf103,0)) * -1 ELSE  ",
                  "           (xrea103-COALESCE(xrce109,0)-COALESCE(apce109,0)-COALESCE(xrce1091,0)-COALESCE(xrcf103,0)) END),      ",
                  "           (CASE WHEN (xrea004 ='02' OR xrea004 = '04' OR xrea004 LIKE '2%') THEN                                ",
                 #"           (xrea113-COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)) * -1 ELSE  ", #170217-00022#1
                 #"           (xrea113-COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)) END),      ", #170217-00022#1   
                 #170217-00022#1---s---
                  "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  )='2'                        ",
                  "                THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = '",l_premon,"' ",
                  "                                AND xreb001 = '",l_preyear,"' AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )                 ",
                  "                          - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)                                                                            ",                                       
                  "                ELSE xrea113 - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)  END ) * -1                                                               ",
                  "          ELSE      ",
                  "               (CASE WHEN (SELECT glca002 FROM glca_t WHERE glcaent = xreaent AND glcald = xreald AND glca001 = 'AR'  ) ='2'                                         ",
                  "            THEN  xrea113 - (SELECT NVL(SUM(xreb115),0) FROM xreb_t WHERE xrebent = xreaent AND xrebcomp = xreacomp AND xrebld = xreald AND xreb002 = '",l_premon,"' ",
                  "                               AND xreb001 = '",l_preyear,"'  AND xreb003 = 'AR' AND xreb005 = xrea005 AND xreb006 = xrea006 AND xreb007 = xrea007 )                 ", 
                  "                          - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0)                                                                             ",
                  "                ELSE xrea113 - COALESCE(xrce119,0)-COALESCE(apce119,0)-COALESCE(xrce1191,0)-COALESCE(xrcf113,0) END ) END),                                                              ",  
                  #170217-00022#1 ---e---                                    
                  "           xrea019,xrea011,xrea016,'2',xreaent,0,0                                      ",
                  "           ,xrea044,xrea045                                                             ",                   
                  "      FROM xrea_t                                                                       ", 
                  "   LEFT OUTER JOIN(SELECT xrdald,xrce003,xrce004,xrce005,xrce054,SUM(xrce109) xrce109,                       ",   #aapt420>截止日被沖帳的金額
                  "                      SUM(xrce119) xrce119,SUM(xrce129) xrce129, SUM(xrce139) xrce139                        ",   
                  "                     FROM xrda_t,xrce_t                                                                      ",   
                  "                    WHERE xrdaent = xrceent AND xrdaent = ",g_enterprise,"                                   ",   
                  "                      AND xrdald  = xrceld  AND xrdadocno = xrcedocno                                        ",   
                  "                      AND xrdastus = 'Y'  AND xrdadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'    ",                   
                  "                    GROUP BY xrdald,xrce003,xrce004,xrce005,xrce054) b                                       ",   
                  "                       ON b.xrdald = xreald   AND b.xrce003 = xrea005 AND b.xrce004 = xrea006                ",   
                  "                      AND b.xrce005 = xrea007                                                                ", 
                  "   LEFT OUTER JOIN(                                                                             ",    #150401-00001#35---s---
                    "               SELECT apdald,apce003,apce004,apce005,apce048,SUM(apce109) apce109,             ",    
                    "                      SUM(apce119) apce119,SUM(apce129) apce129, SUM(apce139) apce139          ",
                    "                 FROM apce_t,apda_t                                                            ",
                    "                WHERE apdaent = ",g_enterprise," AND apceent = apdaent                         ",                                               
                    "                  AND apceld  = apdald                                                         ",
                    "                  AND apcedocno = apdadocno                                                    ",
                    "                  AND apdastus = 'Y'                                                           ",
                    "                  AND apdadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'              ",
                    "                GROUP BY apdald,apce003,apce004,apce005,apce048                                ",
                    "                   ) ON apdald = xreald AND apce003 = xrea005 AND apce004 = xrea006            ",
                    "                  AND apce005 = xrea007                                                        ", 
                    "   LEFT OUTER JOIN(SELECT xrcald,xrce003,xrce004,xrce005,xrce048,SUM(xrce109) xrce1091,        ",
                    "                SUM(xrce119) xrce1191,SUM(xrce129) xrce1291, SUM(xrce139) xrce1391             ",
                    "               FROM xrca_t,xrce_t                                                              ",
                    "              WHERE xrcaent = xrceent  AND xrcaent = ",g_enterprise,"                          ",
                    "                AND xrcald  = xrceld   AND xrcedocno = xrcadocno                               ",
                    "                AND xrcastus = 'Y'     AND xrcadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'    ",
                    "              GROUP BY xrcald,xrce003,xrce004,xrce005,xrce048) c                                      ",
                    "                 ON c.xrcald  = xreald   AND c.xrce003 = xrea005 AND c.xrce004 = xrea006              ",
                    "                AND c.xrce005 = xrea007                                                               ",
                    "   LEFT OUTER JOIN(SELECT xrcald,xrcf008,xrcf009,xrcf010,SUM(xrcf103) xrcf103,                 ",
                    "                SUM(xrcf113) xrcf113,SUM(xrcf123) xrcf123, SUM(xrcf133) xrcf133                ",
                    "               FROM xrca_t,xrcf_t                                                              ",
                    "              WHERE xrcaent = xrcfent AND xrcaent = ",g_enterprise,"                           ",
                    "                AND xrcald  = xrcfld  AND xrcfdocno = xrcadocno                                ",
                    "                AND xrcastus = 'Y'    AND xrcadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'    ",
                    "              GROUP BY xrcald,xrcf008,xrcf009,xrcf010) d                                       ",
                    "                 ON d.xrcald  = xreald   AND d.xrcf008 = xrea005 AND d.xrcf009 = xrea006       ",
                    "                AND d.xrcf010 = xrea007                                                        " , #150401-00001#35 ---e---                          
                  "     WHERE xreaent = '",g_enterprise,"'                                                          ",
                  "       AND xreald = '",l_ld,"'                                                                   ",
                  "       AND xrea003 = 'AR'                                                                        ",
                  "       AND xrea001 = '",l_preyear,"'                                                             ",
                  "       AND xrea002 = '",l_premon,"'                                                              ",
                  "       AND xreacomp IN  ", g_wc_xreacomp                                   
      LET g_sql = g_sql CLIPPED,
                  " AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                 " OR (xrea004 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (xrea004 LIKE '2%') "
      END IF   
      
      LET g_sql = g_sql CLIPPED,")"   
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrea009 )"
      END IF
      #161111-00049#2 Add  ---(E)---   
      PREPARE axrq932_ins_tmp_32 FROM g_sql
      EXECUTE axrq932_ins_tmp_32 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF             
      LET g_sql =   " INSERT INTO axrq932_tmp ", 
      
                    " SELECT DISTINCT '",YEAR(g_input.enddate),"','",MONTH(g_input.enddate),"',a.xrcald,a.xrca004,a.xrca001,        ",   #161102-00021#1 add DISTINCT lujh
                    "         xrccdocno,xrccseq,xrcc001,a.xrcadocdt,xrcc004,'',a.xrca100,                                  ",                 
                    "       (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                  ",
                    "       (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) * -1 ELSE ",
                    "       (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) END ),    ",
                    "       (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                                            ",
                    "       (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) * -1 ELSE ",
                    "       (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) END ),    ",
                    "        0 ,                                                                                                                     ",
                    "       (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                                            ",
                    "       (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) * -1 ELSE ",
                    "       (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) END ),    ", 
                    "       (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                                            ",                  
                    "       (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) * -1 ELSE ",
                    "       (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) END),     ",                      
                   #"        a.xrca035,a.xrca015,a.xrca014,'2',a.xrcaent,xrcc108,xrcc118,xrcc009,a.xrca008                 ",        #161208-00002#1 
                           l_xrea017,",a.xrca015,a.xrca014,'2',a.xrcaent,xrcc108,xrcc118,xrcc009,a.xrca008                 ",        #161208-00002#1                    
                    "   FROM xrca_t a,xrcb_t,xrcc_t                                                                        ",
                    "   LEFT OUTER JOIN(SELECT xrdald,xrce003,xrce004,xrce005,xrce054,SUM(xrce109) xrce109,                ",   #aapt420>截止日被沖帳的金額
                    "                      SUM(xrce119) xrce119,SUM(xrce129) xrce129, SUM(xrce139) xrce139                 ",   
                    "                     FROM xrda_t,xrce_t                                                               ",   
                    "                    WHERE xrdaent = xrceent AND xrdaent = ",g_enterprise,"                            ",   
                    "                      AND xrdald  = xrceld  AND xrdadocno = xrcedocno                                 ",   
                    "                      AND xrdastus = 'Y'    AND xrdadocdt > '",g_input.enddate,"'                     ",                   
                    "                    GROUP BY xrdald,xrce003,xrce004,xrce005,xrce054) b                                ",   
                    "                       ON b.xrdald = xrccld   AND b.xrce003 = xrccdocno AND b.xrce004 = xrccseq       ",   
                    "                      AND b.xrce005 = xrcc001 AND b.xrce054 = xrcc009                                 ",     
                    "   LEFT OUTER JOIN(                                                                            ",   
                    "               SELECT apdald,apce003,apce004,apce005,apce048,SUM(apce109) apce109,             ",    
                    "                      SUM(apce119) apce119,SUM(apce129) apce129, SUM(apce139) apce139          ",
                    "                 FROM apce_t,apda_t                                                            ",
                    "                WHERE apdaent = ",g_enterprise," AND apceent = apdaent                         ",                                               
                    "                  AND apceld  = apdald                                                         ",
                    "                  AND apcedocno = apdadocno                                                    ",
                    "                  AND apdastus = 'Y'                                                           ",
                    "                  AND apdadocdt > '",g_input.enddate,"'                                        ",
                    "                GROUP BY apdald,apce003,apce004,apce005,apce048                                ",
                    "                   ) ON apdald = xrccld AND apce003 = xrccdocno AND apce004 = xrccseq          ",
                    "                  AND apce005 = xrcc001                                                        ", 
                    "   LEFT OUTER JOIN(SELECT xrcald,xrce003,xrce004,xrce005,xrce048,SUM(xrce109) xrce1091,        ",
                    "                SUM(xrce119) xrce1191,SUM(xrce129) xrce1291, SUM(xrce139) xrce1391             ",
                    "               FROM xrca_t,xrce_t                                                              ",
                    "              WHERE xrcaent = xrceent  AND xrcaent = ",g_enterprise,"                          ",
                    "                AND xrcald  = xrceld   AND xrcedocno = xrcadocno                               ",
                    "                AND xrcastus = 'Y'     AND xrcadocdt > '",g_input.enddate,"'                   ",
                    "              GROUP BY xrcald,xrce003,xrce004,xrce005,xrce048) c                               ",
                    "                 ON c.xrcald  = xrccld   AND c.xrce003 = xrccdocno AND c.xrce004 = xrccseq     ",
                    "                AND c.xrce005 = xrcc001  AND c.xrce048 = xrcc009                               ",  
                    "   LEFT OUTER JOIN(SELECT xrcald,xrcf008,xrcf009,xrcf010,SUM(xrcf103) xrcf103,                 ",
                    "                SUM(xrcf113) xrcf113,SUM(xrcf123) xrcf123, SUM(xrcf133) xrcf133                ",
                    "               FROM xrca_t,xrcf_t                                                              ",
                    "              WHERE xrcaent = xrcfent AND xrcaent = ",g_enterprise,"                           ",
                    "                AND xrcald  = xrcfld  AND xrcfdocno = xrcadocno                                ",
                    "                AND xrcastus = 'Y'    AND xrcadocdt > '",g_input.enddate,"'                    ",
                    "              GROUP BY xrcald,xrcf008,xrcf009,xrcf010) d                                       ",
                    "                 ON d.xrcald  = xrccld   AND d.xrcf008 = xrccdocno AND d.xrcf009 = xrccseq     ",
                    "                AND d.xrcf010 = xrcc001                                                        ",                    
                    "  WHERE a.xrcaent = xrcbent AND xrcaent = xrccent AND a.xrcaent = '",g_enterprise,"'           "  #161226-00039#2 
                   #"    AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno AND xrcbseq = xrccseq              ", #160107-00003#4 mark
                   #"    AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno                                    ", #160107-00003#4 add #161226-00039#2 mark
                   #161226-00039#2---s---
                    IF l_s_fin_1002 = '3' THEN                                                                                
                       LET g_sql = g_sql," AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno AND xrcbseq = xrccseq   "  
                    ELSE
                       LET g_sql = g_sql," AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno                          "
                    END IF
                    LET g_sql = g_sql," AND a.xrcald    = xrcbld  AND a.xrcald = xrccld AND a.xrcald  = '",l_ld,"'        ",
                    #161226-00039#2 ---e---
                    "    AND a.xrcastus  = 'Y'                                                                      ",
                    "    AND (xrcc108 + COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrcf103,0) > 0)            ",
                    "    AND a.xrcacomp IN " , g_wc_xreacomp,
                    "    AND a.xrcadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'                          "
  
      LET g_sql = g_sql CLIPPED,
                    " AND ((a.xrca001 NOT LIKE '2%' AND a.xrca001 NOT LIKE '0%') "
      #暫估類帳款納入分析否
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                        " OR (a.xrca001 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (a.xrca001 LIKE '2%') "
      END IF       
      
      LET g_sql = g_sql CLIPPED,")"
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrca004 )"
      END IF
      #161111-00049#2 Add  ---(E)---
      PREPARE aapq932_ins_tmp_4 FROM g_sql
      EXECUTE aapq932_ins_tmp_4 
      LET g_sql =   " INSERT INTO axrq932_tmp ", #明細
                    " SELECT DISTINCT '",YEAR(g_input.enddate),"','",MONTH(g_input.enddate),"',a.xrcald,a.xrca004,a.xrca001,        ",  #161102-00021#1 add DISTINCT lujh
                    "         xrccdocno,xrccseq,xrcc001,a.xrcadocdt,xrcc004,'',a.xrca100,                                  ", 
                    "        (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                 ",                    
                    "        (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) * -1 ELSE ",
                    "        (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) END),     ",
                    "        (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                 ",                     
                    "        (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) * -1 ELSE ",
                    "        (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) END),     ",
                    "        0 ,                                                                                           ",
                    "        (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                 ",     
                    "        (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) * -1 ELSE ",
                    "        (xrcc108-COALESCE(xrcc109,0)+COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrce1091,0)+COALESCE(xrcf103,0)) END),     ", 
                    "        (CASE WHEN ( a.xrca001 ='02' OR a.xrca001 = '04' OR a.xrca001 LIKE '2%') THEN                 ",                         
                    "        (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) * -1 ELSE ", 
                    "        (xrcc118-COALESCE(xrcc119,0)+COALESCE(xrce119,0)+COALESCE(apce119,0)+COALESCE(xrce1191,0)+COALESCE(xrcf113,0)) END),     ",                    
                    #"        a.xrca035,a.xrca015,a.xrca014,'3',a.xrcaent,xrcc108,xrcc118,xrcc009,a.xrca008                 ",                   #161208-00002#1  
                            l_xrea017,",a.xrca015,a.xrca014,'3',a.xrcaent,xrcc108,xrcc118,xrcc009,a.xrca008                 ",                   #161208-00002#1                    
                    "   FROM xrca_t a,xrcb_t,xrcc_t                                                                        ",
                    "   LEFT OUTER JOIN(SELECT xrdald,xrce003,xrce004,xrce005,xrce054,SUM(xrce109) xrce109,                ",   #aapt420>截止日被沖帳的金額
                    "                      SUM(xrce119) xrce119,SUM(xrce129) xrce129, SUM(xrce139) xrce139                 ",   
                    "                     FROM xrda_t,xrce_t                                                               ",   
                    "                    WHERE xrdaent = xrceent AND xrdaent = ",g_enterprise,"                            ",   
                    "                      AND xrdald  = xrceld  AND xrdadocno = xrcedocno                                 ",   
                    "                      AND xrdastus = 'Y'    AND xrdadocdt > '",g_input.enddate,"'                     ",                   
                    "                    GROUP BY xrdald,xrce003,xrce004,xrce005,xrce054) b                                ",   
                    "                       ON b.xrdald = xrccld   AND b.xrce003 = xrccdocno AND b.xrce004 = xrccseq       ",   
                    "                      AND b.xrce005 = xrcc001 AND b.xrce054 = xrcc009                                 ",     
                    "   LEFT OUTER JOIN(                                                                            ",   
                    "               SELECT apdald,apce003,apce004,apce005,apce048,SUM(apce109) apce109,             ",    
                    "                      SUM(apce119) apce119,SUM(apce129) apce129, SUM(apce139) apce139          ",
                    "                 FROM apce_t,apda_t                                                            ",
                    "                WHERE apdaent = ",g_enterprise," AND apceent = apdaent                         ",                                               
                    "                  AND apceld  = apdald                                                         ",
                    "                  AND apcedocno = apdadocno                                                    ",
                    "                  AND apdastus = 'Y'                                                           ",
                    "                  AND apdadocdt > '",g_input.enddate,"'                                        ",
                    "                GROUP BY apdald,apce003,apce004,apce005,apce048                                ",
                    "                   ) ON apdald = xrccld AND apce003 = xrccdocno AND apce004 = xrccseq          ",
                    "                  AND apce005 = xrcc001                                                        ", 
                    "   LEFT OUTER JOIN(SELECT xrcald,xrce003,xrce004,xrce005,xrce048,SUM(xrce109) xrce1091,        ",
                    "                SUM(xrce119) xrce1191,SUM(xrce129) xrce1291, SUM(xrce139) xrce1391             ",
                    "               FROM xrca_t,xrce_t                                                              ",
                    "              WHERE xrcaent = xrceent  AND xrcaent = ",g_enterprise,"                          ",
                    "                AND xrcald  = xrceld   AND xrcedocno = xrcadocno                               ",
                    "                AND xrcastus = 'Y'     AND xrcadocdt > '",g_input.enddate,"'                   ",
                    "              GROUP BY xrcald,xrce003,xrce004,xrce005,xrce048) c                               ",
                    "                 ON c.xrcald  = xrccld   AND c.xrce003 = xrccdocno AND c.xrce004 = xrccseq     ",
                    "                AND c.xrce005 = xrcc001  AND c.xrce048 = xrcc009                               ",  
                    "   LEFT OUTER JOIN(SELECT xrcald,xrcf008,xrcf009,xrcf010,SUM(xrcf103) xrcf103,                 ",
                    "                SUM(xrcf113) xrcf113,SUM(xrcf123) xrcf123, SUM(xrcf133) xrcf133                ",
                    "               FROM xrca_t,xrcf_t                                                              ",
                    "              WHERE xrcaent = xrcfent AND xrcaent = ",g_enterprise,"                           ",
                    "                AND xrcald  = xrcfld  AND xrcfdocno = xrcadocno                                ",
                    "                AND xrcastus = 'Y'    AND xrcadocdt > '",g_input.enddate,"'                    ",
                    "              GROUP BY xrcald,xrcf008,xrcf009,xrcf010) d                                       ",
                    "                 ON d.xrcald  = xrccld   AND d.xrcf008 = xrccdocno AND d.xrcf009 = xrccseq     ",
                    "                AND d.xrcf010 = xrcc001                                                        ",                    
                    "  WHERE a.xrcaent = xrcbent AND xrcaent = xrccent AND a.xrcaent = '",g_enterprise,"'           " #161226-00039#2
                   #"    AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno AND xrcbseq = xrccseq              ", #160107-00003#4 mark
                   #"    AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno                                    ", #160107-00003#4 add #161226-00039#2 mark
                   #161226-00039#2---s---
                    IF l_s_fin_1002 = '3' THEN                                                                                
                       LET g_sql = g_sql," AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno AND xrcbseq = xrccseq   "  
                    ELSE
                       LET g_sql = g_sql," AND a.xrcadocno = xrcbdocno AND a.xrcadocno = xrccdocno                          "
                    END IF
                    LET g_sql = g_sql," AND a.xrcald    = xrcbld  AND a.xrcald = xrccld AND a.xrcald  = '",l_ld,"'        ",
                    #161226-00039#2 ---e---                                 ", 
                    "    AND a.xrcald    = xrcbld    AND a.xrcald = xrccld AND a.xrcald  = '",l_ld,"'               ",
                    "    AND a.xrcastus  = 'Y'                                                                      ",
                    "    AND (xrcc108 + COALESCE(xrce109,0)+COALESCE(apce109,0)+COALESCE(xrcf103,0) > 0)            ",
                    "    AND a.xrcacomp IN " , g_wc_xreacomp,
                    "    AND a.xrcadocdt BETWEEN '",l_strdate,"' AND '",g_input.enddate,"'                          "
 
      LET g_sql = g_sql CLIPPED,
                    " AND ((a.xrca001 NOT LIKE '2%' AND a.xrca001 NOT LIKE '0%') "
      #暫估類帳款納入分析否
      IF g_input.apca0010 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                        " OR (a.xrca001 LIKE '0%' ) "
      END IF         
      IF g_input.apca0012 = 'Y' THEN
         LET g_sql = g_sql CLIPPED,
                  " OR (a.xrca001 LIKE '2%') "
      END IF       
      
      LET g_sql = g_sql CLIPPED,")"
      #161111-00049#2 Add  ---(S)---
      IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
         LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                           "              WHERE pmaaent = ",g_enterprise,
                           "                AND ",g_sql_ctrl,
                           "                AND pmaa001 = xrca004 )"
      END IF
      #161111-00049#2 Add  ---(E)---
      PREPARE aapq932_ins_tmp_5 FROM g_sql
      EXECUTE aapq932_ins_tmp_5 
 
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF          
   END FOREACH   
   
   SELECT COUNT(*) INTO l_cnt FROM axrq932_tmp   
   
   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code ='-100'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF      

END FUNCTION

################################################################################
# Descriptions...: 設置翻頁
# Memo...........:
# Usage..........: CALL axrq932_set_page
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_set_page()
DEFINE l_idx    LIKE type_t.num5
DEFINE l_sql    STRING
DEFINE i        LIKE type_t.num5
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   CALL g_xrea3_d.clear()
   #只依照期別跳頁
   #160505-00007#25 mod---s--- 
   #LET l_sql="   SELECT DISTINCT xrea002 ",
   #          "     FROM axrq932_tmp ",
   #          "    WHERE 1=1  AND ", g_wc ,
   #          "      AND per = '2' ",
   #          " ORDER BY xrea002   " 
   LET l_sql = " SELECT DISTINCT xrea002 ",
               "   FROM xrea_t           ",
               "  WHERE xreaent = '",g_enterprise,"'                                                ",
               "    AND xreald IN ",g_wc_xreald,
               "    AND xrea003 = 'AR'                                                              ",
               "    AND xrea001 = '",g_input.year,"'                                                ",
               "    AND xrea002 BETWEEN  '",g_input.strmon,"' AND '",g_input.endmon,"'              ",
               "    AND xreacomp IN  ", g_wc_xreacomp
   LET l_sql = l_sql CLIPPED," AND ((xrea004 NOT LIKE '2%' AND xrea004 NOT LIKE '0%') "         
   IF g_input.apca0010 = 'Y' THEN
      LET l_sql = l_sql CLIPPED," OR (xrea004 LIKE '0%' ) "
   END IF         
   IF g_input.apca0012 = 'Y' THEN
      LET l_sql = l_sql CLIPPED," OR (xrea004 LIKE '2%') "
   END IF    
   LET l_sql = l_sql CLIPPED,")"
   LET l_sql = l_sql CLIPPED," ORDER BY xrea002 "   
   #160505-00007#25 mod---e---    
   
   PREPARE axrq932_pr FROM l_sql
   DECLARE axrq932_cr CURSOR FOR axrq932_pr      
   LET l_idx=1  
   FOREACH axrq932_cr INTO g_xrea3_d[l_idx].xrea002
      IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'FOREACH axrq932_cr'
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
      END IF
      IF l_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF cl_null(g_xrea3_d[l_idx].xrea002) THEN
         CALL g_xrea3_d.deleteElement(l_idx)
      ELSE
         LET l_idx=l_idx+1
      END IF        
    
   END FOREACH 
   
   LET l_idx = l_idx - 1
   CALL g_xrea3_d.deleteElement(g_xrea3_d.getLength())
   LET g_header_cnt = g_xrea3_d.getLength()
   LET g_rec_b = l_idx   
   DISPLAY g_header_cnt TO FORMONLY.h_count     
END FUNCTION

################################################################################
# Descriptions...: 抓取分頁資料
# Memo...........:
# Usage..........: CALL axrq932_fetch1(p_flag)
# Input parameter: p_flag    所在筆數 
# Date & Author..: 2014/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_fetch1(p_flag)
DEFINE p_flag   LIKE type_t.chr1
DEFINE ls_msg     STRING

   IF g_header_cnt = 0 THEN
      RETURN
   END IF

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt
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
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
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

         IF g_jump > 0 AND g_jump <= g_xrea3_d.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE
   #代表沒有資料
   IF g_current_idx = 0 OR g_xrea3_d.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_xrea3_d.getLength() THEN
      LET g_current_idx = g_xrea3_d.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index                                 
   LET g_xrea002 = g_xrea3_d[g_current_idx].xrea002
   
   CALL axrq932_b_fill()        
END FUNCTION

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL axrq932_default()
# Date & Author..: 2015/01/27 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_default()
   
   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,
                                                       g_input.xreasite,g_xreald,g_xreacomp   
   CALL s_fin_account_center_sons_query('3',g_input.xreasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_xreasite
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xreacomp  #同aapq910
   CALL s_fin_get_wc_str(g_wc_xreacomp) RETURNING g_wc_xreacomp
   #取得帳務中心底下的帳套範圍   
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xreald
   CALL s_fin_get_wc_str(g_wc_xreald) RETURNING g_wc_xreald

   CALL s_desc_get_department_desc(g_input.xreasite) RETURNING g_input.xreasite_desc     
   #帳齡預設
   SELECT glcb003 INTO g_input.xrad001
     FROM glcb_t
    WHERE glcbent = g_enterprise
      AND glcbld  = g_xreald
      AND glcb001 = 'AR'
   #帳齡起算日基準  
   IF NOT cl_null(g_input.xrad001)THEN      
      SELECT xrad004 INTO g_input.xrad004
        FROM xrad_t
       WHERE xradent = g_enterprise
         AND xrad001 = g_input.xrad001       
   END IF
   CALL axrq932_dedtype_def() #扣除方式
   CALL s_desc_get_xrad001_desc(g_input.xrad001)RETURNING g_input.xrad001_desc
   IF cl_null(g_input.xrad004)THEN LET g_input.xrad004 = '90' END IF   
   LET g_input.group = '1'     #彙總方式
   LET g_input.apca0010 = 'Y'
   LET g_input.apca0012 = 'Y'
   LET g_input.cre ='1'        #信用額度
   LET g_input.year = YEAR(g_today)
   LET g_input.strmon = MONTH(g_today)
   LET g_input.endmon = MONTH(g_today)
   LET g_input.curr ='Y'
   LET g_input.b_check ='N'
   LET g_input.enddate = g_today     
   CALL axrq932_get_type()        
   CALL cl_set_comp_visible('b_xrea103,b_xrea100,xrea100,xrea1031,xrea1032,xrea1033,xrea1034',TRUE)
   CALL cl_set_comp_visible('group1,group2,group3,xrea011,xrea016,pmab053',FALSE) #先全部關閉
   CALL cl_set_comp_visible('group1_desc,group2_desc,group3_desc,xrea011_desc,xrea016_desc,pmab053_desc',FALSE) #先全部關閉
 #  CALL cl_set_comp_visible('group1,group2',TRUE)             #151020   #151022-00017#4 ---mark---
 #  CALL cl_set_comp_visible('group1_desc,group2_desc',TRUE)   #151020   #151022-00017#4 ---mark---
    CALL cl_set_comp_visible('h_index,h_count,lbl_hend',FALSE)  
   #IF  g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
   IF  g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
      CALL cl_set_comp_visible('group1,group2',TRUE)           #151022-00017#4         
      CALL cl_set_comp_visible('group1_desc,group2_desc',TRUE) #151022-00017#4
      CALL cl_set_comp_visible('xrea002,year,strmon,endmon,first,previous,jump,next,last',FALSE)
      CALL cl_set_comp_visible('b_xrea002',FALSE)
   ELSE
      CALL cl_set_comp_visible('group1,group2,xrea011,xrea016,pmab053',TRUE)  #151022-00017#4                                   
      CALL cl_set_comp_visible('group1_desc,group2_desc,xrea011_desc,xrea016_desc,pmab053_desc',TRUE)   #151022-00017#4
      CALL cl_set_comp_visible('enddate',FALSE)      
   END IF   
   CALL axrq932_dis() 
   
   DISPLAY BY NAME g_input.xreasite_desc,g_input.xrad001_desc,
                   g_input.group,g_input.dedtype,   
                   g_input.apca0010,g_input.apca0012,g_input.xrad004 
END FUNCTION

################################################################################
# Descriptions...: 壞帳提列比率
# Memo...........:
# Usage..........: CALL axrq932_debt_ref()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_debt_ref()
   DEFINE l_xrae003 LIKE xrae_t.xrae003
   DEFINE l_xrae004 LIKE xrae_t.xrae004
   DEFINE l_xrae005 LIKE xrae_t.xrae005

   #160505-00007#25 mod---s---
   #LET g_sql = " SELECT xrae003,xrae004,xrae005     ",
   #             "   FROM xrae_t                     ",
   #             "  WHERE xraeent = ",g_enterprise," ",
   #             "    AND xrae001 = '",g_input.xrad001,"' "
   #PREPARE axrq932_pre_1  FROM g_sql
   #DECLARE axrq932_curs CURSOR FOR axrq932_pre_1 
   #160505-00007#25 mod---e---
   
   FOREACH axrq932_curs INTO l_xrae003,l_xrae004,l_xrae005
      IF g_xrea_d[l_ac].day2 >= l_xrae003 AND g_xrea_d[l_ac].day2 <= l_xrae004 THEN
         LET g_xrea_d[l_ac].l_debt = l_xrae005
         EXIT FOREACH    #161209-00048#1 --ADD      
      END IF
      #161209-00048#1--MARK--S--
#      #帳齡天數大於起始天數，不再範圍者
#      IF g_xrea_d[l_ac].day2 > l_xrae004 THEN
#         LET g_xrea_d[l_ac].l_debt = l_xrae005
#      END IF
#      #帳齡天數小於起始天數，不再範圍者
#      IF g_xrea_d[l_ac].day2  < l_xrae003 THEN 
#         LET g_xrea_d[l_ac].l_debt = l_xrae005 
#      END IF
      #161209-00048#1--MARK--E---
   END FOREACH
   #161209-00048#1--ADD--S--
   #帳齡天數小於起始天數，不再範圍者
   SELECT MIN(xrae003) INTO l_xrae003
     FROM xrae_t
    WHERE xraeent = g_enterprise
      AND xrae001 = g_input.xrad001
   IF g_xrea_d[l_ac].day2 < l_xrae003 THEN
      SELECT xrae005 INTO g_xrea_d[l_ac].l_debt
        FROM xrae_t 
       WHERE xraeent = g_enterprise
         AND xrae001 = g_input.xrad001
         AND xrae003 = l_xrae003
   END IF
   #帳齡天數大於起始天數，不再範圍者
   SELECT MAX(xrae004) INTO l_xrae004
     FROM xrae_t
    WHERE xraeent = g_enterprise     
      AND xrae001 = g_input.xrad001
   IF g_xrea_d[l_ac].day2 > l_xrae004 THEN   
       SELECT xrae005 INTO g_xrea_d[l_ac].l_debt
        FROM xrae_t 
       WHERE xraeent = g_enterprise
         AND xrae001 = g_input.xrad001
         AND xrae004 = l_xrae004
   END IF   
   #161209-00048#1--ADD--E--

END FUNCTION

################################################################################
# Descriptions...: 填充第二單身
# Memo...........:
# Usage..........: CALL axrq932_b_fill2()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_b_fill2()
   DEFINE ls_wc2           STRING
   DEFINE l_title         LIKE type_t.chr80   #year年mon月title
   DEFINE l_xrea001       LIKE xrea_t.xrea001
   DEFINE l_xrea002       LIKE xrea_t.xrea002
   DEFINE l_strdate       LIKE xrea_t.xrea008
   DEFINE l_enddate       LIKE xrea_t.xrea008
   DEFINE l_mon           LIKE type_t.chr50
   DEFINE l_year          LIKE type_t.chr50
   DEFINE l_xrea009       LIKE xrea_t.xrea009 #對象
   DEFINE l_pmab005       LIKE pmab_t.pmab005 #幣別
   DEFINE l_pmab006       LIKE pmab_t.pmab006 #信用額度
   DEFINE l_glaa001       LIKE glaa_t.glaa001
   DEFINE l_glaa003       LIKE glaa_t.glaa003 #主帳套之會計週期參照表
   DEFINE l_xrea019       LIKE type_t.chr100  #應收付科目
   DEFINE l_ooao004       LIKE ooao_t.ooao004 #
   DEFINE l_ooao006       LIKE ooao_t.ooao006 #重評匯率
   DEFINE l_glaa002       LIKE glaa_t.glaa002
   DEFINE l_xreaald       LIKE type_t.chr100
   DEFINE l_xrea100       LIKE type_t.chr100
   DEFINE l_xrea1001      LIKE xrea_t.xrea100
   DEFINE l_preyear       LIKE xrea_t.xrea001 #上期年
   DEFINE l_premon        LIKE xrea_t.xrea002 #上期月
   DEFINE l_group1        LIKE type_t.chr100
   DEFINE l_group2        LIKE type_t.chr100
   DEFINE l_group3        LIKE type_t.chr100  
   DEFINE l_pmab031       LIKE pmab_t.pmab031 #人員   
   DEFINE l_group         STRING
   DEFINE l_count         LIKE type_t.num5 
   DEFINE l_str           LIKE type_t.chr100
   DEFINE l_str2          LIKE type_t.chr100
   DEFINE l_pmabsite      LIKE pmab_t.pmabsite   #20150308 add
   DEFINE l_pmab109       LIKE pmab_t.pmab109    #20150308 add
   DEFINE l_xrea     DYNAMIC ARRAY OF RECORD
          xrea113      LIKE xrea_t.xrea113,  #各區間的本幣
          xrea113_debt LIKE xrea_t.xrea113   #各區間本幣壞帳
          END RECORD 
   #扣除方式使用Array   
   DEFINE l_sum DYNAMIC ARRAY OF RECORD
        type          LIKE type_t.chr500,      #條件 
        xrea005       LIKE xrea_t.xrea005,     #正項條件
        xrea006       LIKE xrea_t.xrea006,
        xrea007       LIKE xrea_t.xrea007,
        xrea0052      LIKE xrea_t.xrea005,     #負項條件
        xrea0062      LIKE xrea_t.xrea006,
        xrea0072      LIKE xrea_t.xrea007,
        xrea103       LIKE xrea_t.xrea103,      #原幣未沖金額
        xrea113       LIKE xrea_t.xrea113,      #本幣未沖金額
        xrea1032      LIKE xrea_t.xrea103,      #原幣未沖金額
        xrea1132      LIKE xrea_t.xrea113,      #本幣未沖金額
        xrea100       LIKE xrea_t.xrea100      #幣別 
   END RECORD  
   DEFINE l_xreasite        LIKE type_t.chr80
   DEFINE l_xrad001         LIKE type_t.chr80
   DEFINE l_xrad004         LIKE type_t.chr80
   DEFINE l_dedtype         LIKE type_t.chr80  
   DEFINE l_xrea004         LIKE type_t.chr80
   DEFINE l_cre_desc        LIKE type_t.chr80
   DEFINE l_group_desc      LIKE type_t.chr80
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_field           LIKE type_t.chr100  #151012-00014#4
   DEFINE l_field2          LIKE type_t.chr100  #151012-00014#4   
   DEFINE l_field3          LIKE type_t.chr100  #151022-00017#4

   DELETE FROM axrq932_tmp03   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
   LET l_xreasite = g_input.xreasite,'      ',g_input.xreasite_desc       
   LET l_xrad001  = g_input.xrad001,'       ',g_input.xrad001_desc
   LET l_xrad004  = g_input.xrad004,':',s_desc_gzcbl004_desc('8312',g_input.xrad004)  #帳玲起算基準日
   LET l_dedtype  = g_input.dedtype,':',s_desc_gzcbl004_desc('8328',g_input.dedtype)    
   LET l_group_desc = s_desc_gzcbl004_desc('8330',g_input.group)
   CASE g_input.cre
      WHEN '1'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
      WHEN '2'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.2' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
      WHEN '3'
         SELECT gzzd005 INTO l_cre_desc FROM gzzd_t WHERE gzzd003 = 'rdo_cre.3' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
   END CASE
   
   CALL g_xrea2_d.clear()
   CALL axrq932_title_change()
   CASE        
     WHEN g_input.group = 1
        #IF g_prog  = 'axrq930' THEN  #帳套+交易對象        #160705-00042#10 160713 by sakura mark
        IF g_prog  MATCHES 'axrq930' THEN  #帳套+交易對象   #160705-00042#10 160713 by sakura add
           LET l_str = " xreald||'@'||xrea009 " #151022-00017#4   
           LET l_group = " GROUP BY xreald||'@'||xrea009,xreald,xrea009 " #151022-00017#4  
        ELSE                        #帳套+交易對象+部門+人員+交易條件
           LET l_str = " xreald||'@'||xrea009||'@'||xrea011||'@'||xrea016||'@'||xrea045 "#150901-00020#4  
           LET l_group = " GROUP BY xreald||'@'||xrea009||'@'||xrea011||'@'||xrea016||'@'||xrea045,xreald,xrea009, ", #150901-00020#4
                                                                                   "  xrea011,xrea016,xrea045      "               
        END IF
        LET l_group1  = 'xreald'
        LET l_group2 = 'xrea009'
        LET l_group3 = "''"      
     WHEN g_input.group = 2 
        #IF g_prog = 'axrq930' THEN #帳套交易對象+科目        #160705-00042#10 160713 by sakura mark
        IF g_prog MATCHES 'axrq930' THEN #帳套交易對象+科目   #160705-00042#10 160713 by sakura add
           LET l_str = " xreald||'@'||xrea009||'@'||xrea019 " #151022-00017#4  
           LET l_group = " GROUP BY xreald||'@'||xrea009||'@'||xrea019,xreald,xrea009,xrea019 " #151022-00017#4       
        ELSE                       #帳套交易對象+科目+部門+人員+交易條件
           LET l_str = " xreald||'@'||xrea009||'@'||xrea019||'@'||xrea011||'@'||xrea016||'@'||xrea045 "#150901-00020#4 
           LET l_group = " GROUP BY xreald||'@'||xrea009||'@'||xrea019||'@'||xrea011||'@'||xrea016||'@'||xrea045,xreald,xrea009,xrea019,",  #150901-00020#4 
                                                                                                        "  xrea011,xrea016,xrea045      "    
        END IF      
        LET l_group1  = 'xreald'
        LET l_group2  = 'xrea009'
        LET l_group3  = 'xrea019'
     WHEN g_input.group = 3 #帳務單號+發票號碼 #150901-00020#4 ---s--- 帳款單號+發票號碼+部門+人員+交易條件
        LET l_str = " xreald||'@'||xrea005||'@'||xrea044||'@'||xrea011||'@'||xrea016||'@'||xrea045 "
        LET l_group1 = 'xreald'
        LET l_group2 = 'xrea005'
        LET l_group3 = 'xrea044'
        LET l_group = " GROUP BY xreald||'@'||xrea005||'@'||xrea044||'@'||xrea011||'@'||xrea016||'@'||xrea045,xreald,xrea005,xrea044, ",   #150901-00020#4 ---e---
                                                                                                      "  xrea011,xrea016,xrea045      "
           #150401-00001#35 ---s---                                                                                                      
     WHEN g_input.group = 4   #帳套+交易對象
         LET l_str = " xreald||'@'||xrea009 "  
         LET l_group = " GROUP BY xreald||'@'||xrea009,xreald,xrea009 "
         LET l_group1  = 'xreald'
         LET l_group2 = 'xrea009'
         LET l_group3 = "''"       
      WHEN g_input.group = 5   #帳套+交易對象+科目
         LET l_str = " xreald||'@'||xrea009||'@'||xrea019 " #151022-00017#4  
         LET l_group = " GROUP BY xreald||'@'||xrea009||'@'||xrea019,xreald,xrea009,xrea019 " #151022-00017#4     
         LET l_group1  = 'xreald'
         LET l_group2  = 'xrea009'
         LET l_group3  = 'xrea019'      
         #150401-00001#35 ---e---                                                                                                "  xrea011,xrea016,xrea045      "    
   END CASE
   
   IF g_input.curr = 'Y' THEN
      LET l_xrea100 = 'xrea100'
      LET l_group = l_group,',xrea100 ' 
   ELSE
      LET l_xrea100 = "''"
   END IF  
   #151022-00017#4 ---s---
   LET l_field3 ="' '"
   #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark    
   IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
      IF g_input.group = '3' THEN  LET l_field3 ='xrea011,xrea016,xrea045' END IF
   ELSE
      IF g_input.group ='1' OR g_input.group = '2' OR g_input.group = '3'THEN   #150401-00001#35
         LET l_field3 ='xrea011,xrea016,xrea045'
      END IF     
   END IF
   #151022-00017#4 ---e---
   #取得字串年/月
   CALL cl_getmsg('agl-00274',g_dlang) RETURNING l_year 
   CALL cl_getmsg('aoo-00215',g_dlang) RETURNING l_mon   
   LET g_sql = "   SELECT ",l_str," ,                                  ",
               "          ",l_group1," , ",l_group2," , ",l_group3," , ",
               "          ",l_xrea100,",                               ",      #150901-00020#4 增加　匯總條件
               "          ",l_field3,"                                 ",      #151022-00017#4                
               "     FROM axrq932_tmp                                  ",
               "    WHERE 1=1  AND " ,g_b2_wc 
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算  
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF   
   LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  " #150901-00020#4
                                                              
   PREPARE aapq932_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR aapq932_pb3
   
   LET l_ac = 1    
   LET l_i = 95
   #151012-00014#4 ---s---
   #IF g_prog = 'axrq930' AND g_input.curr ='Y' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq930' AND g_input.curr ='Y' THEN   #160705-00042#10 160713 by sakura add
      LET l_field  = 'xrea103'
      LET l_field2 = 'xrea103_debt'
   ELSE 
      LET l_field  = 'xrea113'
      LET l_field2 = 'xrea113_debt'
   END IF
   #151012-00014#4 ---e---
   
   #160505-00007#25 add---s---
   LET g_sql = "    SELECT SUM(",l_field,")                    ",   
               "      FROM axrq932_tmp                         ",
               "     WHERE xrea008 <= ?                        ",                 
               "       AND per = 2                             ",                        
               "       AND ",l_str," = ?                       ",
               "       AND xrea001 = '",g_input.year,"'        ",
               "       AND xrea002 = '",g_xrea002,"'           ",
               "       AND " , g_b2_wc                       
                  
               
   IF g_input.curr = 'Y' THEN 
      LET g_sql = g_sql, "  AND xrea100 = ? "
   END IF
   PREPARE axrq932_pb3_prep7 FROM g_sql  
            
   LET g_sql = "    SELECT SUM(",l_field,")                   ",               
               "      FROM axrq932_tmp                        ",
               "     WHERE xrea008 BETWEEN ? AND ?            ",
               "       AND per = '2'                          ",
               "       AND ",l_str," = ?                      ",
               "       AND xrea001 = '",g_input.year,"'       ",
               "       AND xrea002 = '",g_xrea002,"'          ",
               "       AND " , g_b2_wc                                   
   IF g_input.curr = 'Y' THEN 
      LET g_sql = g_sql, "  AND xrea100 = ? "
   END IF
   PREPARE axrq932_pb3_prep8 FROM g_sql     
   #160505-00007#25 add---e---
   
   #往前推各月帳款日期本幣所在區間
   FOREACH b_fill_curs3 INTO l_str2,
                             g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                             g_xrea2_d[l_ac].xrea100  
      CALL l_xrea.clear() 
      #取得會計週期參照表
      CALL s_ld_sel_glaa(g_xrea2_d[l_ac].group1,'glaa003') RETURNING g_sub_success,l_glaa003
      FOR l_count = 12 TO 1 step -1
         IF l_count < 12 THEN          
            #從上期開始年月
            CALL s_fin_date_get_last_period(l_glaa003,g_xreald,l_xrea001,l_xrea002)
                RETURNING g_sub_success,l_xrea001,l_xrea002 #上期年月 
         ELSE
            #當期年月
            LET l_xrea001 = g_input.year
            LET l_xrea002 = g_xrea002
         END IF
         LET l_title = l_xrea001||l_year||l_xrea002||l_mon
         CALL cl_set_comp_att_text('mon'||l_count,l_title)
         IF l_i >= 83 THEN
            LET g_xg_fieldname[l_i] = l_title
            LET l_i = l_i-1 
         END IF
         #起始截止日期
         CALL s_fin_date_get_period_range(l_glaa003,l_xrea001,l_xrea002)RETURNING l_strdate,l_enddate 
         IF l_count = 1 THEN
            #160505-00007#25 mod----s---
            #LET g_sql = "    SELECT SUM(xrea113)                       ",  #151012-00014#4
            #LET g_sql = "    SELECT SUM(",l_field,")                    ",  #151012-00014#4                    
            #            "      FROM axrq932_tmp                         ",
            #            "     WHERE xrea008 <= '",l_enddate,"'          ",
            #            "       AND xrea001 = '",g_input.year,"'        ",
            #            "       AND xrea002 = '",g_xrea002,"'           ",                        
            #            "       AND per = 2                             ",                        
            #            "       AND ",l_str," = '",l_str2,"'            ",
            #            "       AND " , g_b2_wc                                
            #IF g_input.curr = 'Y' THEN 
            #   LET g_sql = g_sql, "  AND xrea100 = '",g_xrea2_d[l_ac].xrea100,"' "
            #END IF
            #PREPARE aapq932_pb3_prep7 FROM g_sql  
            #EXECUTE aapq932_pb3_prep7 INTO l_xrea[1].xrea113 
            IF g_input.curr = 'Y' THEN
               EXECUTE axrq932_pb3_prep7 INTO l_xrea[1].xrea113 USING l_enddate,l_str2,g_xrea2_d[l_ac].xrea100
            ELSE
               EXECUTE axrq932_pb3_prep7 INTO l_xrea[1].xrea113 USING l_enddate,l_str2
            END IF            
            #160505-00007#25 mod----e---            
         ELSE 
            #160505-00007#25 mod----s---         
          # #LET g_sql = "    SELECT SUM(xrea113)                       ",  #151012-00014#4 
            #LET g_sql = "    SELECT SUM(",l_field,")                   ",  #151012-00014#4                    
            #            "      FROM axrq932_tmp                  ",
            #            "     WHERE xrea008 BETWEEN '",l_strdate,"' AND '",l_enddate,"' ",
            #            "       AND xrea001 = '",g_input.year,"'           ",
            #            "       AND xrea002 = '",g_xrea002,"'           ",  
            #            "       AND per = '2'                           ",
            #            "       AND ",l_str," = '",l_str2,"'            ",
            #            "       AND " , g_b2_wc                        
            #IF g_input.curr = 'Y' THEN 
            #   LET g_sql = g_sql, "  AND xrea100 = '",g_xrea2_d[l_ac].xrea100,"' "
            #END IF
            #PREPARE aapq932_pb3_prep8 FROM g_sql  
            #EXECUTE aapq932_pb3_prep8 INTO l_xrea[l_count].xrea113  
            IF g_input.curr = 'Y' THEN 
               EXECUTE axrq932_pb3_prep8 INTO l_xrea[l_count].xrea113 USING l_strdate,l_enddate,l_str2,g_xrea2_d[l_ac].xrea100
            ELSE
               EXECUTE axrq932_pb3_prep8 INTO l_xrea[l_count].xrea113 USING l_strdate,l_enddate,l_str2 
            END IF            
            #160505-00007#25 mod---e---
         END IF                      
         IF cl_null(l_xrea[l_count].xrea113) THEN LET l_xrea[l_count].xrea113 = 0 END IF 
      END FOR
      LET g_xrea2_d[l_ac].mon1  = l_xrea[1 ].xrea113
      LET g_xrea2_d[l_ac].mon2  = l_xrea[2 ].xrea113
      LET g_xrea2_d[l_ac].mon3  = l_xrea[3 ].xrea113
      LET g_xrea2_d[l_ac].mon4  = l_xrea[4 ].xrea113
      LET g_xrea2_d[l_ac].mon5  = l_xrea[5 ].xrea113
      LET g_xrea2_d[l_ac].mon6  = l_xrea[6 ].xrea113
      LET g_xrea2_d[l_ac].mon7  = l_xrea[7 ].xrea113
      LET g_xrea2_d[l_ac].mon8  = l_xrea[8 ].xrea113
      LET g_xrea2_d[l_ac].mon9  = l_xrea[9 ].xrea113
      LET g_xrea2_d[l_ac].mon10 = l_xrea[10].xrea113
      LET g_xrea2_d[l_ac].mon11 = l_xrea[11].xrea113
      LET g_xrea2_d[l_ac].mon12 = l_xrea[12].xrea113
      LET l_ac = l_ac + 1   
   END FOREACH
  
   #信用扣抵
   #取得當月對象/幣別
   LET l_xrea009 = ''  
   LET l_xrea1001 = ''  
   IF g_input.cre != '1' THEN      
      LET g_sql =  "  SELECT DISTINCT xrea009,xrea100   ",
                   "    FROM  axrq932_tmp               ",
                   "   WHERE xrea002 = '",g_xrea002,"'  "                   
      PREPARE axrq932_pb_prep9 FROM g_sql
      DECLARE axrq932_pb_curs9 CURSOR FOR axrq932_pb_prep9       
      CASE
         WHEN g_input.cre = '2' 
            LET g_sql = g_sql," ORDER BY day2 "
         WHEN g_input.cre = '3' 
            LET g_sql = g_sql," ORDER BY day2 DESC"
      END CASE         
      PREPARE axrq932_pb_prep10 FROM g_sql
      DECLARE axrq932_pb_curs10 CURSOR FOR axrq932_pb_prep10
         
      FOREACH axrq932_pb_curs9 INTO l_xrea009,l_xrea1001
         #幣別/信用額度
         SELECT pmab005,pmab006
           INTO l_pmab005,l_pmab006
           FROM pmab_t
          WHERE pmabent  = g_enterprise
            AND pmabsite = g_input.xreasite
            AND pmab001  = l_xrea009
        
         IF cl_null(l_pmab005) OR cl_null(l_pmab006) THEN EXIT FOREACH END IF
         #取得匯率參照表號
         CALL s_ld_sel_glaa(g_xreald,'glaa001||glaa003') RETURNING g_sub_success,l_glaa001,l_glaa003 
         #年月
         LET l_ooao004 = g_input.year||g_xrea002
         #取得重評價之後的匯率
         SELECT ooao006 INTO l_ooao006
           FROM ooao_t
          WHERE ooaoent = g_enterprise
            AND ooao001 = l_glaa003 
            AND ooao002 = l_xrea1001
            AND ooao003 = l_pmab006
            AND ooao004 = l_glaa001 #本幣幣別
         IF cl_null(l_ooao006) THEN LET l_ooao006 = 0 END IF
         #換算
         LET l_pmab006 = l_pmab006 * l_ooao006                
         #本幣金額   
        #LET g_sql =  "   SELECT xrea113                             ",  #151012-00014#4 
         LET g_sql =  "    SELECT SUM(",l_field,")                   ",  #151012-00014#4  
                      "          xrea005,xrea006,xrea007,xrea100     ",
                      "     FROM axrq932_tmp                         ",
                      "    WHERE xrea004 LIKE '1%'                   ",
                      "      AND xrea002 ='",g_xrea002,"'            ",           
                      "      AND xrea009 = '",l_xrea009,"'           ",
                      "      AND per    =  '2'                       ",
                      "      AND xrea100 = '",l_xrea1001,"'          "
         LET g_sql = g_sql, "AND ", g_b2_wc
         CASE
            WHEN g_input.cre = '2' 
               LET g_sql = g_sql," ORDER BY day2 "
            WHEN g_input.cre = '3' 
               LET g_sql = g_sql," ORDER BY day2 DESC"
         END CASE         
         PREPARE axrq932_pb_prep11 FROM g_sql
         DECLARE axrq932_pb_curs11 CURSOR FOR axrq932_pb_prep11
         FOREACH axrq932_pb_curs11 INTO  l_sum[l_ac].xrea113,l_sum[l_ac].xrea005, 
                                         l_sum[l_ac].xrea006,l_sum[l_ac].xrea007,
                                         l_sum[l_ac].xrea100
            IF l_pmab006 <> 0 THEN                             
               LET l_pmab006 = l_pmab006 - l_sum[l_ac].xrea113                     #餘額扣除
               LET l_sum[l_ac].xrea113 = l_sum[l_ac].xrea113 - l_sum[l_ac].xrea113 #歸0
            END IF
            
            #扣完之後 < 0 把當筆加回去            
            IF l_pmab006 <= 0 THEN
               LET l_sum[l_ac].xrea113 = l_sum[l_ac].xrea113 -  l_pmab006          
            END IF
             #151012-00014#4---s---
            #IF g_prog = 'axrq930' AND g_input.curr = 'Y' THEN        #160705-00042#10 160713 by sakura mark
            IF g_prog MATCHES 'axrq930' AND g_input.curr = 'Y' THEN   #160705-00042#10 160713 by sakura add
               UPDATE axrq932_tmp
                 SET xrea103   = l_sum[l_ac].xrea113
               WHERE xrea005   = l_sum[l_ac].xrea005
                 AND xrea006   = l_sum[l_ac].xrea006
                 AND xrea007   = l_sum[l_ac].xrea007                    
                 AND xrea100   = l_sum[l_ac].xrea100
                 AND xrea002   = g_xrea002     
                 AND per       = '2'           
             ELSE
                UPDATE axrq932_tmp
                  SET xrea113   = l_sum[l_ac].xrea113
                WHERE xrea005   = l_sum[l_ac].xrea005
                  AND xrea006   = l_sum[l_ac].xrea006
                  AND xrea007   = l_sum[l_ac].xrea007                    
                  AND xrea100   = l_sum[l_ac].xrea100
                  AND xrea002   = g_xrea002     
                  AND per       = '2'    
             END IF            #151012-00014#4                  
             IF l_pmab006 <= 0 THEN EXIT FOREACH END IF
          END FOREACH
       END FOREACH
   END IF
   
   #160505-00007#25 add---s---
   #把全部1類的資料都抓進來(正)
   LET g_sql =  "   SELECT  xrea103,xrea113,                   ",
                "           xrea005,xrea006,xrea007,xrea100    ",
                "     FROM axrq932_tmp                         ",
                "    WHERE xrea004 LIKE '1%'                   ",
                "      AND xrea002 ='",g_xrea002,"'            ", 
                "      AND per = '2'                           ",                     
                "      AND ",l_str," = ?                       "
   LET g_sql = g_sql, "AND ", g_b2_wc
   CASE
      WHEN g_input.dedtype = '2'   #先進先出
        LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項
      WHEN g_input.dedtype = '3'   #先進後出
        LET g_sql  = g_sql, "   ORDER BY day2              "
      WHEN g_input.dedtype = '5'   #先進先出 
        LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項              
   END CASE
   PREPARE axrq932_pb_prep6 FROM g_sql
   DECLARE axrq932_pb_curs6 CURSOR FOR axrq932_pb_prep6   
   
   #找出二類交易對象的金額 /相同匯總條件相同幣別                                                      
   LET g_sql = "   SELECT xrea103,xrea113,                    ",
               "          xrea005,xrea006,xrea007             ",
               "     FROM axrq932_tmp                         ",
               "    WHERE xrea004 LIKE '2%'                   ",
               "      AND xrea100 = '?                        ",
               "      AND xrea002 ='",g_xrea002,"'            ",
               "      AND per     ='2'                        ",                        
               "      AND ",l_str," = ?                       "
   LET g_sql = g_sql,"AND ", g_b2_wc
   CASE 
     WHEN g_input.dedtype = '2'  
        LET g_sql  = g_sql, "   ORDER BY day2 DESC          "# 帳齡天數大的正項 去扣除帳齡天數大的負項
     WHEN g_input.dedtype = '3' 
        LET g_sql  = g_sql, "   ORDER BY day2                " 
     WHEN g_input.dedtype = '5' #per 期間flag
        LET g_sql  = g_sql, "   ORDER BY per DESC,day2 DESC     " 
   END CASE                                          
   PREPARE axrq932_pb_prep7 FROM g_sql
   DECLARE axrq932_pb_curs7 CURSOR FOR axrq932_pb_prep7
   #160505-00007#25 add---e---
   
   #扣除方式計算
   IF g_input.dedtype = '2' OR g_input.dedtype = '3' OR g_input.dedtype = '5' THEN  
      LET l_ac = 1
      #找出類型 匯總
      LET g_sql =  "  SELECT DISTINCT ",l_str,"  ",
                   "    FROM  axrq932_tmp       "                   
      PREPARE axrq932_pb_prep8 FROM g_sql
      DECLARE axrq932_pb_curs8 CURSOR FOR axrq932_pb_prep8
      
      FOREACH axrq932_pb_curs8 INTO l_sum[l_ac].type
         #160505-00007#25 mod---s---
         ##把全部1類的資料都抓進來(正)
         #LET g_sql =  "   SELECT  xrea103,xrea113,                   ",
         #             "           xrea005,xrea006,xrea007,xrea100    ",
         #             "     FROM axrq932_tmp                         ",
         #             "    WHERE xrea004 LIKE '1%'                   ",
         #             "      AND xrea002 ='",g_xrea002,"'            ", 
         #             "      AND per = '2'                           ",                     
         #             "      AND ",l_str," = '",l_sum[l_ac].type,"'  "
         #LET g_sql = g_sql, "AND ", g_b2_wc
         #CASE
         #   WHEN g_input.dedtype = '2'   #先進先出
         #     LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項
         #   WHEN g_input.dedtype = '3'   #先進後出
         #     LET g_sql  = g_sql, "   ORDER BY day2              "
         #   WHEN g_input.dedtype = '5'   #先進先出 
         #     LET g_sql  = g_sql, "   ORDER BY day2 DESC         " #150316 帳齡天數大的正項 去扣除帳齡天數大的負項              
         #END CASE
         #PREPARE axrq932_pb_prep6 FROM g_sql
         #DECLARE axrq932_pb_curs6 CURSOR FOR axrq932_pb_prep6
         OPEN axrq932_pb_curs6 USING l_sum[l_ac].type       
         #160505-00007#25 mod---e--- 
         FOREACH axrq932_pb_curs6 INTO l_sum[l_ac].xrea103   , l_sum[l_ac].xrea113,
                                       l_sum[l_ac].xrea005 , l_sum[l_ac].xrea006, l_sum[l_ac].xrea007,
                                       l_sum[l_ac].xrea100
            #160505-00007#25 mod---s---
            ##找出二類交易對象的金額 /相同匯總條件相同幣別                                                      
            #LET g_sql = "   SELECT xrea103,xrea113,                    ",
            #            "          xrea005,xrea006,xrea007             ",
            #            "     FROM axrq932_tmp                         ",
            #            "    WHERE xrea004 LIKE '2%'                   ",
            #            "      AND xrea100 = '",l_sum[l_ac].xrea100,"' ",
            #            "      AND xrea002 ='",g_xrea002,"'            ",
            #            "      AND per     ='2'                        ",                        
            #            "      AND ",l_str," = '",l_sum[l_ac].type,"'  "
            #LET g_sql = g_sql,"AND ", g_b2_wc
            #CASE 
            #  WHEN g_input.dedtype = '2'  
            #     LET g_sql  = g_sql, "   ORDER BY day2 DESC          "# 帳齡天數大的正項 去扣除帳齡天數大的負項
            #  WHEN g_input.dedtype = '3' 
            #     LET g_sql  = g_sql, "   ORDER BY day2                " 
            #  WHEN g_input.dedtype = '5' #per 期間flag
            #     LET g_sql  = g_sql, "   ORDER BY per DESC,day2 DESC     " 
            #END CASE                                          
            #PREPARE axrq932_pb_prep7 FROM g_sql
            #DECLARE axrq932_pb_curs7 CURSOR FOR axrq932_pb_prep7
            OPEN axrq932_pb_curs7 USING l_sum[l_ac].xrea100,l_sum[l_ac].type
            #160505-00007#25 mod---s---
            FOREACH axrq932_pb_curs7 INTO  l_sum[l_ac].xrea1032, l_sum[l_ac].xrea1132,
                                           l_sum[l_ac].xrea0052, l_sum[l_ac].xrea0062,   l_sum[l_ac].xrea0072                                                       
               IF s_math_abs(l_sum[l_ac].xrea1132) > s_math_abs(l_sum[l_ac].xrea113) THEN
                  LET l_sum[l_ac].xrea1132  = l_sum[l_ac].xrea1132  + l_sum[l_ac].xrea113 #二類+一類
                  LET l_sum[l_ac].xrea113   = l_sum[l_ac].xrea113   - l_sum[l_ac].xrea113 #一類歸零
               ELSE
                  LET l_sum[l_ac].xrea113   = l_sum[l_ac].xrea113   + l_sum[l_ac].xrea1132  #一類-二類 
                  LET l_sum[l_ac].xrea1132  = l_sum[l_ac].xrea1132  - l_sum[l_ac].xrea1132  #二類歸零         
               END IF               
                  
               #更新資料
               UPDATE axrq932_tmp
                  SET xrea113   = l_sum[l_ac].xrea113
                WHERE xrea005   = l_sum[l_ac].xrea005
                  AND xrea006   = l_sum[l_ac].xrea006
                  AND xrea007   = l_sum[l_ac].xrea007                    
                  AND xrea100   = l_sum[l_ac].xrea100
                  AND xrea002   = g_xrea002  
                  AND per       = '2'                  
                  
               UPDATE axrq932_tmp
                  SET xrea113   = l_sum[l_ac].xrea1132
                WHERE xrea005   = l_sum[l_ac].xrea0052 
                  AND xrea006   = l_sum[l_ac].xrea0062
                  AND xrea007   = l_sum[l_ac].xrea0072   
                  AND xrea100   = l_sum[l_ac].xrea100 
                  AND xrea002   = g_xrea002                 
                  AND per       = '2'  
                  
               #151012-00014#4 ---s---
               UPDATE axrq932_tmp
                  SET xrea103   = l_sum[l_ac].xrea103
                WHERE xrea005   = l_sum[l_ac].xrea005
                  AND xrea006   = l_sum[l_ac].xrea006
                  AND xrea007   = l_sum[l_ac].xrea007                    
                  AND xrea100   = l_sum[l_ac].xrea100
                  AND xrea002   = g_xrea002  
                  AND per       = '2'   
               
               UPDATE axrq932_tmp
                  SET xrea103   = l_sum[l_ac].xrea1032
                WHERE xrea005   = l_sum[l_ac].xrea0052 
                  AND xrea006   = l_sum[l_ac].xrea0062
                  AND xrea007   = l_sum[l_ac].xrea0072   
                  AND xrea100   = l_sum[l_ac].xrea100 
                  AND xrea002   = g_xrea002                 
                  AND per       = '2'  
               #151012-00014#4 ---e---   
                  
               #正的攤完就跑下一筆正的
                #151012-00014#4 
               #IF g_prog = 'axrq930' AND g_input.curr ='Y'  THEN        #160705-00042#10 160713 by sakura mark
               IF g_prog MATCHES 'axrq930' AND g_input.curr ='Y'  THEN   #160705-00042#10 160713 by sakura add
                  IF l_sum[l_ac].xrea103 = 0 THEN
                     EXIT FOREACH
                  END IF   
               ELSE             
                  IF l_sum[l_ac].xrea113 = 0 THEN
                     EXIT FOREACH
                  END IF
               END IF
                                                                           
            END FOREACH  
            CLOSE axrq932_pb_curs7 #160505-00007#25            
         END FOREACH
         CLOSE axrq932_pb_curs6    #160505-00007#25 
         LET l_ac = l_ac+ 1
      END FOREACH
   END IF  
   
   LET l_xrea009 = ''   
   LET l_ac = 1

   #160505-00007#25 add--s---
      LET g_sql = "  SELECT                                                                  ",
                  "     SUM(CASE WHEN xrca001 IN ('01','12','13','17','14','31') THEN xrcc118 ELSE 0 END),  ", #本期入庫金額
                  "     SUM(CASE WHEN xrca001 IN ('22','02') THEN xrcc118 ELSE 0 END),       ", #本期退貨金額
                  "     SUM(CASE WHEN xrca001 IN ('19','03') THEN xrcc118 ELSE 0 END),       ", #本期調增金額
                  "     SUM(CASE WHEN xrca001 IN ('29','04','24') THEN xrcc118 ELSE 0 END),  ", #本期調減金額
                  "     SUM(CASE WHEN xrca001 IN ('11','15','16','21','23','25','26')   ", #本期預付金額/2開頭是負值
                  "     THEN (CASE WHEN xrca001 IN ('11','15','16') THEN xrcc118 ELSE xrcc118 * -1 END) ELSE 0 END) ",
                  "    FROM xrca_t,xrcc_t                                         ",
                  "   WHERE xrcaent = xrccent                                     ",
                  "     AND xrcaent = '",g_enterprise,"'                          ",
                  "     AND xrcadocno = xrccdocno                                 ",
                  "     AND xrcald    = xrccld                                    ",
                  "     AND xrcastus = 'Y'                                        ",
                  "     AND xrcald    = ?                                         ",  
                  "     AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' "
                #  "     AND xrca004   = '",g_xrea2_d[l_ac].group2,"'              "                  
      #151223-00001#2  ---s---       
      #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
          CASE g_input.group
            WHEN 1 
                LET g_sql = g_sql CLIPPED ," AND xrca004 = ? "
            WHEN 2
                LET g_sql = g_sql CLIPPED ," AND xrca004 = ? ", #交易對象
                                           " AND xrca035 = ? "  #科目
            WHEN 3
               LET g_sql = g_sql CLIPPED ," AND xrcadocno = ? "     
         END CASE  
      ELSE
         CASE g_input.group
            WHEN 1 
              LET g_sql = g_sql CLIPPED," AND xrca004 = ? ",
                                        " AND xrca015 = ? ", #部門
                                        " AND xrca014 = ? ", #人員
                                        " AND xrca008 = ? "  #交易條件
            WHEN 2
              LET g_sql = g_sql CLIPPED," AND xrca004 = ? ",
                                        " AND xrca035 = ? ",
                                        " AND xrca015 = ? ", #部門
                                        " AND xrca014 = ? ", #人員
                                        " AND xrca008 = ? "  #交易條件
            WHEN 3
                LET g_sql = g_sql CLIPPED ," AND xrcadocno = ? "     
            WHEN 4
                LET g_sql = g_sql CLIPPED ," AND xrca004 = ? "
            WHEN 5
                LET g_sql = g_sql CLIPPED ," AND xrca004 = ? ", #交易對象
                                           " AND xrca035 = ? "  #科目
         END CASE  
      END IF
      #151223-00001#2  ---e---  
      #151203    
      IF g_input.curr = 'Y' THEN #加上幣別
         LET g_sql = g_sql CLIPPED ," AND xrca100 = ? "
      END IF
      PREPARE axrq932_pb3_prep9 FROM g_sql 

      #161205-00002#1 Mod  ---(S)--- 将全角问号修改成半角问号
#調匯
      LET g_sql = "   SELECT SUM(xreh115)                                                   ",
                  "     FROM xreg_t,xreh_t                                                  ",
                  "         ,xrea_t ",    #151223-00001#2 調匯串月結
                  "    WHERE xregent = xrehent AND xregent = '",g_enterprise,"'             ",
                  "      AND xregld = xrehld   AND xregld  = ?                              ",
                  "      AND xregdocno = xrehdocno                                           ",
                  "      AND xreg003 = 'AR'                              ",
                  "      AND xreg001 = '",g_input.year,"' AND xreg002 = '",g_xrea002,"'     ",                 
                  "      AND xregstus = 'Y'                              ",
                  #151223-00001#2-----s
                  "      AND xreaent = xrehent ",
                  "      AND xreald  = xrehld ",
                  "      AND xrea001 = xreh001 ",
                  "      AND xrea002 = xreh002 ",
                  "      AND xrea003 = xreh003 ",
                  "      AND xrea004 = xreh004 ",
                  "      AND xrea005 = xreh005 ",
                  "      AND xrea006 = xreh006 ",
                  "      AND xrea007 = xreh007 "
                  #151223-00001#2-----e
                  #"      AND xreh009 =  '",g_xrea2_d[l_ac].group2,"'                        "
      #151223-00001#2---s---   
      #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
         CASE g_input.group
            WHEN 1 
                LET g_sql = g_sql CLIPPED ," AND xreh009 = ? "  #交易對象
            WHEN 2
                LET g_sql = g_sql CLIPPED ," AND xreh009 = ? ", #交易對象
                                           " AND xreh019 = ? "  #科目  
            WHEN 3
                LET g_sql = g_sql CLIPPED ," AND xreh005 = ? "  #單號  
         END CASE
      ELSE
      
         CASE g_input.group
            WHEN 1 
              LET g_sql = g_sql CLIPPED," AND xreh009 = ?  ", #交易對象
                                        " AND COALESCE(xreh011,' ') = COALESCE(?,' ') ", #部門
                                        " AND COALESCE(xreh016,' ') = COALESCE(?,' ') ",  #人員
                                        " AND xrea045 = ? "  #交易條件   #albireo 151228沒單
            WHEN 2
              LET g_sql = g_sql CLIPPED," AND xreh009 = ?  ",
                                        " AND xreh019 = ?  ",
                                        " AND COALESCE(xreh011,' ') = COALESCE(?,' ') ", #部門
                                        " AND COALESCE(xreh016,' ') = COALESCE(?,' ') ",  #人員
                                        " AND xrea045 = '? "  #交易條件   #albireo 151228沒單
            WHEN 3
                LET g_sql = g_sql CLIPPED ," AND xreh005 = ? "     
            WHEN 4
                LET g_sql = g_sql CLIPPED ," AND xreh009 = ? "
            WHEN 5
                LET g_sql = g_sql CLIPPED ," AND xreh009 = ? ", #交易對象
                                           " AND xreh019 = ? "  #科目
         END CASE    
      END IF         
      #151223-00001#2---e---
      IF g_input.curr = 'Y' THEN #加上幣別
         LET g_sql = g_sql CLIPPED ," AND xreh100 = ? "
      END IF

      #161205-00002#1 Mod  ---(E)---

      PREPARE axrq932_pb3_prep10 FROM g_sql  

      #本幣各個金額所在的區間
      LET g_sql = "   SELECT SUM(",l_field,"),SUM(",l_field2,")                               ",     #151012-00014#4                     
                  "     FROM axrq932_tmp                                                      ",        
                  "    WHERE day2 BETWEEN ? AND ?                                             ",
                  "      AND ",l_str," = ?                                                    ", 
                  "      AND xrea002 ='",g_xrea002,"'                                         ",
                  "      AND per = '2'                                                        ",                    
                  "      AND " , g_b2_wc
      IF g_input.curr = 'Y' THEN          
         LET g_sql = g_sql CLIPPED , "  AND xrea100 =  ?  "
      END IF            
      IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN 
         LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      END IF   
      LET g_sql = g_sql,l_group
               
      PREPARE axrq932_pb3_prep5 FROM g_sql           
 


   #本期其他沖帳金額
   LET g_sql = "   SELECT SUM(a)                                                        ", 
               "     FROM( SELECT (CASE WHEN xrde015 ='D' THEN xrde119 * -1 ELSE xrde119 END) a  ",
               "             FROM xrca_t,xrde_t                                         ",
               "            WHERE xrcaent = xrdeent                                     ",
               "              AND xrcaent = '",g_enterprise,"'                          ",
               "              AND xrcald = xrdeld                                       ",
               "              AND xrcadocno = xrdedocno                                 ",
               "              AND xrcald = ?                                            ",
               "              AND xrde002 <> '20' AND xrde002 <> '10'                                       ",
               "              AND xrcastus = 'Y'                                        ", 
               "              AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
               "              AND xrca004   = ?                                         "
   IF g_input.group ='2' THEN  #加上科目彙總
      LET g_sql = g_sql CLIPPED," AND xrce016 =?  "
   END IF
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrca100 = ? "
   END IF
   LET g_sql = g_sql CLIPPED ," UNION  ",
               "    SELECT (CASE WHEN xrde015 ='D' THEN xrde119 * -1 ELSE xrde119 END) ",
               "      FROM xrda_t,xrde_t                                          ",
               "     WHERE xrdaent = xrdeent                                      ",
               "       AND xrdaent = '",g_enterprise,"'                           ",
               "       AND xrdald = xrdeld                                        ",
               "       AND xrdald = ?                                             ",
               "       AND xrdadocno = xrdedocno                                  ",
               "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'  ",
               "              AND xrde002 <> '20' AND xrde002 <> '10'                                       ",
                "      AND xrdastus = 'Y'                                         ",  
               "       AND xrda005   = ?                                          "
   IF g_input.group ='2' THEN  #加上科目彙總
      LET g_sql = g_sql CLIPPED," AND xrde016 = ?                                 "
   END IF
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrde100 = ? "
   END IF
   LET g_sql = g_sql CLIPPED ," UNION  ",
               "    SELECT (CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END)    ",
               "      FROM xrca_t,xrce_t                                                  ",
               "     WHERE xrcaent = xrceent AND xrcaent = '",g_enterprise,"'             ",
               "       AND xrcald = xrceld AND xrcald = ?                                 ",
               "       AND xrcadocno = xrcedocno                                          ",
               "       AND xrce027 = 'N'                                                  ",
               "       AND NOT (xrce001 = 'axrt430' AND EXISTS(SELECT 1 FROM xrca_t       ",
               "                                                WHERE xrcaent = xrceent   ",
               "                                                  AND xrcadocno = xrce003 ",
               "                                                  AND xrcald = xrceld     ",
               "                                                  AND xrca001 LIKE '1%')) ", 
               "                  AND xrce002 LIKE '4%'                                   ",
               "       AND xrcastus = 'Y'                                              ",
               "       AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'       ",
               "       AND xrca004   = ?                                               "
   IF g_input.group ='2' THEN  #加上科目彙總
      LET g_sql = g_sql CLIPPED," AND xrce016 = ? "
   END IF  
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrca100 = ? "
   END IF      
   LET g_sql = g_sql CLIPPED ," UNION  ",
               "    SELECT (CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END) b  ",
               "      FROM xrda_t,xrce_t                                                  ",
               "     WHERE xrdaent = xrceent AND xrdaent = '",g_enterprise,"'             ",
               "       AND xrdald = xrceld  AND xrdald = ?                                ",
               "       AND xrdadocno = xrcedocno                                          ",
               "       AND xrce027  = 'N'                                                 ",
               "       AND xrdastus = 'Y'                                                 ",
               "       AND NOT (xrce001 = 'axrt430' AND EXISTS(SELECT 1 FROM xrca_t       ",
               "                                                WHERE xrcaent = xrceent   ",
               "                                                  AND xrcadocno = xrce003 ",
               "                                                  AND xrcald = xrceld     ",
               "                                                  AND xrca001 LIKE '1%')) ",                  
               "       AND xrce002 LIKE '4%'                                             ",               
               "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'         ",                  
               "       AND xrda005   = ?                                                  "
   IF g_input.group ='2' THEN  #加上科目彙總
      LET g_sql = g_sql CLIPPED," AND xrce016 = ?      "
   END IF
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrce100 = ? "
   END IF
   LET g_sql = g_sql CLIPPED , ")" 
   PREPARE axrq932_pb3_prep12 FROM g_sql  

   #實際付款金額      
   LET g_sql = "   SELECT SUM(a)                                                        ", 
               "     FROM( SELECT xrde119 a                                             ",
               "             FROM xrca_t,xrde_t                                         ",
               "            WHERE xrcaent = xrdeent                                     ",
               "              AND xrcaent = '",g_enterprise,"'                          ",
               "              AND xrcald = xrdeld                                       ",
               "              AND xrcadocno = xrdedocno                                 ",
               "              AND xrcald = '?                                           ",
               "              AND xrde002 = '10'                                        ",
               "              AND xrcastus = 'Y'                                        ",  
               "              AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
               "              AND xrca004   = ?                                         "
   IF g_input.group ='2' THEN  #加上科目彙總
      LET g_sql = g_sql CLIPPED," AND xrca035 = ? "               
   END IF
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrca100 = ? "
   END IF
   LET g_sql = g_sql CLIPPED ," UNION  ALL",
               "   SELECT xrde119                                                 ",
               "      FROM xrda_t,xrde_t                                          ",
               "     WHERE xrdaent = xrdeent                                      ",
               "       AND xrdaent = '",g_enterprise,"'                           ",
               "       AND xrdald = xrdeld                                        ",
               "       AND xrdald = ?                                             ",
               "       AND xrdadocno = xrdedocno                                  ",
               "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'  ",
               "       AND xrde002 = '10'                                         ",
               "       AND xrdastus = 'Y'                                         ",  
               "       AND xrda005   = ?               "
   IF g_input.group ='2' THEN  #加上科目彙總
     LET g_sql = g_sql CLIPPED," AND xrde016 = ?      "
   END IF 
   IF g_input.curr = 'Y' THEN #加上幣別
      LET g_sql = g_sql CLIPPED ," AND xrde100 = ? "
   END IF
   LET g_sql = g_sql CLIPPED , ")" 
   PREPARE axrq932_pb3_prep11 FROM g_sql
   
   #不在範圍內的天數#固定塞到第21格
   #LET g_sql = "   SELECT SUM(xrea113),SUM(xrea113_debt)            ", #151012-00014#4                      
    LET g_sql = "   SELECT SUM(",l_field,"),SUM(",l_field2,")        ", #151012-00014#4                     
                "     FROM axrq932_tmp                               ",        
                "    WHERE day2 >  ",g_end_day,"                     ",
                "      AND ",l_str," = ?                             ",
                "      AND per = '2'                                 ",                   
                "      AND xrea002 ='",g_xrea002,"'                  ",                      
                "      AND " , g_b2_wc
   IF g_input.curr = 'Y' THEN          
      LET g_sql = g_sql CLIPPED , "  AND xrea100 =  ?  "
   END IF             
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF   
   LET g_sql = g_sql,l_group     
   PREPARE axrq932_pb3_prep6 FROM g_sql  

   #本期增加金額/當期異動之apcc         
   LET g_sql =  " SELECT SUM(apcc108),SUM(apcc118)                            ",                                                                             
                "   FROM axrq932_tmp                                          ",
                "   WHERE xrea008 BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
                "     AND per = '3'                                           ",                   
                "     AND ",l_str," = ?                                       ",
                "     AND ",g_b2_wc
   IF g_input.curr = 'Y' THEN          
      LET g_sql = g_sql CLIPPED , "  AND xrea100 =  ?  "
   END IF
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算             
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF   
   LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
   PREPARE axrq932_sum_ori_loc FROM g_sql
   
   #原幣期末金額
   LET g_sql = "   SELECT                                              ",
               "           SUM(xrea103),SUM(xrea113),                  ", #原幣未沖，本幣別未沖 ,
               "           SUM(xrea103_debt),SUM(xrea113_debt)         ", #原幣壞帳，本幣別壞帳               
               "     FROM axrq932_tmp                                  ",
               "    WHERE 1=1 AND " ,g_b2_wc  ,
               "      AND xrea002 =  '",g_xrea002,"'                   ",
               "      AND per = '2'                                    ",                  
               "      AND ",l_str," = ?                                ",
               "      AND ",g_b2_wc
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    #150215 Belle Mark    
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF
      IF g_input.curr = 'Y' THEN          
         LET g_sql = g_sql CLIPPED , "  AND xrea100 =  ?  "
      END IF            
   LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
   PREPARE axrq932_sum_ori_lo1 FROM g_sql   
   
   
   LET g_sql =  "   SELECT SUM(xrea103),SUM(xrea113)                                ",                                                                             
                "     FROM axrq932_tmp                                              ",
                "    WHERE 1=1 AND " ,g_b2_wc,
                "      AND ",l_str," = ?                                            ",
                "      AND per = '1'                                                "
   IF g_input.curr = 'Y' THEN          
      LET g_sql = g_sql CLIPPED , "  AND xrea100 =  ? "
   END IF             
   IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算      
      LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   END IF   
   LET g_sql = g_sql,l_group
   PREPARE axrq932_pb4 FROM g_sql   
   #160505-00007#25 add--e---

   FOREACH b_fill_curs3 INTO l_str2,
                             g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                             g_xrea2_d[l_ac].xrea100
                             ,g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].pmab053  #150901-00020#4
      #160505-00007#25 mod---s---
      ##本期增加金額/當期異動之apcc         
      #LET g_sql =  " SELECT SUM(apcc108),SUM(apcc118)                            ",                                                                             
      #             "   FROM axrq932_tmp                                          ",
      #             "   WHERE xrea008 BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
      #             "     AND per = '3'                                           ",                   
      #             "     AND ",l_str," = '",l_str2,"'                            ",
      #             "     AND ",g_b2_wc
      #IF g_input.curr = 'Y' THEN          
      #   LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      #END IF
      #IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算             
      #   LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      #END IF   
      #LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
      #PREPARE axrq932_sum_ori_loc FROM g_sql
      #EXECUTE axrq932_sum_ori_loc INTO g_xrea2_d[l_ac].xrea1032,g_xrea2_d[l_ac].xrea1132  
      IF g_input.curr = 'Y' THEN   
         EXECUTE axrq932_sum_ori_loc INTO g_xrea2_d[l_ac].xrea1032,g_xrea2_d[l_ac].xrea1132    
                                      USING l_str2,g_xrea2_d[l_ac].xrea100
      ELSE
         EXECUTE axrq932_sum_ori_loc INTO g_xrea2_d[l_ac].xrea1032,g_xrea2_d[l_ac].xrea1132    
                                      USING l_str2      
      END IF      
      #160505-00007#25 mod---e---      
      IF cl_null(g_xrea2_d[l_ac].xrea1032) THEN LET g_xrea2_d[l_ac].xrea1032 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1132) THEN LET g_xrea2_d[l_ac].xrea1132 = 0 END IF      
      
      #160505-00007#25 mod---s---
      ##原幣期末金額
      #LET g_sql = "   SELECT                                              ",
      #            "           SUM(xrea103),SUM(xrea113),                  ", #原幣未沖，本幣別未沖 ,
      #            "           SUM(xrea103_debt),SUM(xrea113_debt)         ", #原幣壞帳，本幣別壞帳               
      #            "     FROM axrq932_tmp                                  ",
      #            "    WHERE 1=1 AND " ,g_b2_wc  ,
      #            "      AND xrea002 =  '",g_xrea002,"'                   ",
      #            "      AND per = '2'                                    ",                  
      #            "      AND ",l_str," = '",l_str2,"'                     ",
      #            "      AND ",g_b2_wc
      #IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    #150215 Belle Mark    
      #   LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      #END IF
      #   IF g_input.curr = 'Y' THEN          
      #      LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      #   END IF            
      #LET g_sql = g_sql,l_group," ORDER BY ",l_str,"  "
      #PREPARE axrq932_sum_ori_lo1 FROM g_sql
      #EXECUTE axrq932_sum_ori_lo1 INTO g_xrea2_d[l_ac].xrea1034,g_xrea2_d[l_ac].xrea1134,
      #                                 g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135
      IF g_input.curr = 'Y' THEN     
         EXECUTE axrq932_sum_ori_lo1 INTO g_xrea2_d[l_ac].xrea1034,g_xrea2_d[l_ac].xrea1134,
                                          g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135       
                                    USING l_str2,g_xrea2_d[l_ac].xrea100                                      
      ELSE
         EXECUTE axrq932_sum_ori_lo1 INTO g_xrea2_d[l_ac].xrea1034,g_xrea2_d[l_ac].xrea1134,
                                          g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135       
                                    USING l_str2      
      END IF      
      #160505-00007#25 mod---e---                                       
      IF cl_null(g_xrea2_d[l_ac].xrea1034) THEN LET g_xrea2_d[l_ac].xrea1034 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1134) THEN LET g_xrea2_d[l_ac].xrea1134 = 0 END IF 
      IF cl_null(g_xrea2_d[l_ac].xrea1035) THEN LET g_xrea2_d[l_ac].xrea1035 = 0 END IF        
      IF cl_null(g_xrea2_d[l_ac].xrea1135) THEN LET g_xrea2_d[l_ac].xrea1135 = 0 END IF 

      #160505-00007#25 mod---s---
      ##取得會計週期參照表
      #CALL s_ld_sel_glaa(g_xreald,'glaa003') RETURNING g_sub_success,l_glaa003
      ##期初金額/月結檔上一期的金額匯總
      #CALL s_fin_date_get_last_period(l_glaa003,g_xreald,g_input.year,g_xrea002)
      #               RETURNING g_sub_success,l_preyear,l_premon    
      #LET g_sql =  "   SELECT SUM(xrea103),SUM(xrea113)                                ",                                                                             
      #             "     FROM axrq932_tmp                                              ",
      #             "    WHERE 1=1 AND " ,g_b2_wc,
      #             "      AND ",l_str," = '",l_str2,"'                                 ",
      #             "      AND per = '1'                                                "
      #           #  "      AND xrea001 =  '",l_preyear,"' AND xrea002 = '",l_premon,"'  "
      #IF g_input.curr = 'Y' THEN          
      #   LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      #END IF             
      #IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算      
      #   LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
   　 #END IF   
      #LET g_sql = g_sql,l_group
      #PREPARE axrq932_pb4 FROM g_sql
      #EXECUTE axrq932_pb4 INTO g_xrea2_d[l_ac].xrea1031,g_xrea2_d[l_ac].xrea1131
      IF g_input.curr = 'Y' THEN 
         EXECUTE axrq932_pb4 INTO g_xrea2_d[l_ac].xrea1031,g_xrea2_d[l_ac].xrea1131
                            USING l_str2,g_xrea2_d[l_ac].xrea100
      ELSE
         EXECUTE axrq932_pb4 INTO g_xrea2_d[l_ac].xrea1031,g_xrea2_d[l_ac].xrea1131
                            USING l_str2
      END IF      
      #160505-00007#25 mod---e---
      
      IF cl_null(g_xrea2_d[l_ac].xrea1031) THEN LET g_xrea2_d[l_ac].xrea1031 = 0 END IF
      IF cl_null(g_xrea2_d[l_ac].xrea1131) THEN LET g_xrea2_d[l_ac].xrea1131 = 0 END IF
      #本期減少金額 = 期初 + 本期新增金额 - 期末
      LET g_xrea2_d[l_ac].xrea1033 = g_xrea2_d[l_ac].xrea1031 + g_xrea2_d[l_ac].xrea1032 - g_xrea2_d[l_ac].xrea1034
      LET g_xrea2_d[l_ac].xrea1133 = g_xrea2_d[l_ac].xrea1131 + g_xrea2_d[l_ac].xrea1132 - g_xrea2_d[l_ac].xrea1134
      
      
      LET l_xrea001 = g_input.year
      LET l_xrea002 = g_xrea002      
      CALL cl_getmsg('agl-00274',g_dlang) RETURNING l_year 
      CALL cl_getmsg('aoo-00215',g_dlang) RETURNING l_mon
      CALL l_xrea.clear()
            
      #幣別/信用額度
      CASE g_input.group
         WHEN 3 
            SELECT DISTINCT xrea009 INTO l_xrea009 FROM axrq932_tmp WHERE xrea005 = g_xrea2_d[l_ac].group2
            SELECT pmab005,pmab006
              INTO g_xrea2_d[l_ac].crecurr ,g_xrea2_d[l_ac].crelim 
              FROM pmab_t
             WHERE pmabent  = g_enterprise
               AND pmabsite = g_input.xreasite
               AND pmab001  = l_xrea009 
        OTHERWISE
           IF l_xrea009 <> g_xrea2_d[l_ac].group2 OR l_ac = 1 THEN              
              SELECT pmab005,pmab006
                INTO g_xrea2_d[l_ac].crecurr ,g_xrea2_d[l_ac].crelim 
                FROM pmab_t
               WHERE pmabent  = g_enterprise
                 AND pmabsite = g_input.xreasite
                 AND pmab001  = g_xrea2_d[l_ac].group2 
              LET l_xrea009 = g_xrea2_d[l_ac].group2                 
           END IF 
      END CASE
      IF cl_null(g_xrea2_d[l_ac].crelim ) THEN LET g_xrea2_d[l_ac].crelim = 0 END IF     

      #160505-00007#25 mod---s---
      #本期入庫金額/本期退貨金額/本期調增金額/本期調減金額
      #LET g_sql = "  SELECT                                                                  ",
      #            "     SUM(CASE WHEN xrca001 IN ('01','12','13','17','14','31') THEN xrcc118 ELSE 0 END),  ", #本期入庫金額
      #            "     SUM(CASE WHEN xrca001 IN ('22','02') THEN xrcc118 ELSE 0 END),       ", #本期退貨金額
      #            "     SUM(CASE WHEN xrca001 IN ('19','03') THEN xrcc118 ELSE 0 END),       ", #本期調增金額
      #            "     SUM(CASE WHEN xrca001 IN ('29','04','24') THEN xrcc118 ELSE 0 END),  ", #本期調減金額
      #            "     SUM(CASE WHEN xrca001 IN ('11','15','16','21','23','25','26')   ", #本期預付金額/2開頭是負值
      #            "     THEN (CASE WHEN xrca001 IN ('11','15','16') THEN xrcc118 ELSE xrcc118 * -1 END) ELSE 0 END) ",
      #            "    FROM xrca_t,xrcc_t                                         ",
      #            "   WHERE xrcaent = xrccent                                     ",
      #            "     AND xrcaent = '",g_enterprise,"'                          ",
      #            "     AND xrcadocno = xrccdocno                                 ",
      #            "     AND xrcald    = xrccld                                    ",
      #            "     AND xrcastus = 'Y'                                        ",
      #            "     AND xrcald    = '",g_xrea2_d[l_ac].group1,"'              ",  
      #            "     AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' "
      #          #  "     AND xrca004   = '",g_xrea2_d[l_ac].group2,"'              "                  
      ##151223-00001#2  ---s---       
      #IF g_prog = 'axrq930' THEN
      #    CASE g_input.group
      #      WHEN 1 
      #          LET g_sql = g_sql CLIPPED ," AND xrca004 = '",g_xrea2_d[l_ac].group2,"' "
      #      WHEN 2
      #          LET g_sql = g_sql CLIPPED ," AND xrca004 = '",g_xrea2_d[l_ac].group2,"' ", #交易對象
      #                                     " AND xrca035 = '",g_xrea2_d[l_ac].group3,"' "  #科目
      #      WHEN 3
      #         LET g_sql = g_sql CLIPPED ," AND xrcadocno = '",g_xrea2_d[l_ac].group2,"'"     
      #   END CASE  
      #ELSE
      #   CASE g_input.group
      #      WHEN 1 
      #        LET g_sql = g_sql CLIPPED," AND xrca004 = '",g_xrea2_d[l_ac].group2,"'  ",
      #                                  " AND xrca015 = '",g_xrea2_d[l_ac].xrea011,"' ", #部門
      #                                  " AND xrca014 = '",g_xrea2_d[l_ac].xrea016,"' ", #人員
      #                                  " AND xrca008 = '",g_xrea2_d[l_ac].pmab053,"' "  #交易條件
      #      WHEN 2
      #        LET g_sql = g_sql CLIPPED," AND xrca004 = '",g_xrea2_d[l_ac].group2,"'  ",
      #                                  " AND xrca035 = '",g_xrea2_d[l_ac].group3,"'  ",
      #                                  " AND xrca015 = '",g_xrea2_d[l_ac].xrea011,"' ", #部門
      #                                  " AND xrca014 = '",g_xrea2_d[l_ac].xrea016,"' ", #人員
      #                                  " AND xrca008 = '",g_xrea2_d[l_ac].pmab053,"' "  #交易條件
      #      WHEN 3
      #          LET g_sql = g_sql CLIPPED ," AND xrcadocno = '",g_xrea2_d[l_ac].group2,"'"     
      #      WHEN 4
      #          LET g_sql = g_sql CLIPPED ," AND xrca004 = '",g_xrea2_d[l_ac].group2,"' "
      #      WHEN 5
      #          LET g_sql = g_sql CLIPPED ," AND xrca004 = '",g_xrea2_d[l_ac].group2,"' ", #交易對象
      #                                     " AND xrca035 = '",g_xrea2_d[l_ac].group3,"' "  #科目
      #   END CASE  
      #END IF
      ##151223-00001#2  ---e---  
      ##151203    
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrca100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #PREPARE axrq932_pb3_prep9 FROM g_sql  
      #EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
      #                               g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
      #                               g_xrea2_d[l_ac].advmoney 
      #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
         CASE g_input.group
            WHEN 1
               IF g_input.curr = 'Y' THEN 
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100 
               ELSE                                              
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
               END IF                                                 
            WHEN 2 
               IF g_input.curr = 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                                 g_xrea2_d[l_ac].xrea100 
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3                                            
               END IF
            WHEN 3
               IF g_input.curr = 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100 
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
               END IF                                           
         END CASE      
      ELSE                                                
         CASE g_input.group
            WHEN 1 
               IF g_input.curr = 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea011,
                                                 g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].pmab053,
                                                 g_xrea2_d[l_ac].xrea100
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea011,
                                                 g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].pmab053              
               END IF                                                
            WHEN 2
               IF g_input.curr = 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                                 g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,
                                                 g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].xrea100
                ELSE
                   EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                  g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                  g_xrea2_d[l_ac].advmoney 
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                                  g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,
                                                  g_xrea2_d[l_ac].pmab053                                                
                END IF
            WHEN 3
               IF g_input.curr = 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100     
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
               END IF
            WHEN 4
               IF g_input.curr = 'Y' THEN 
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100
               
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
               END IF
            WHEN 5
               IF g_input.curr= 'Y' THEN
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                 g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100
               
               ELSE
                  EXECUTE axrq932_pb3_prep9 INTO g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].retmoney,
                                                 g_xrea2_d[l_ac].addmoney,g_xrea2_d[l_ac].redmoney,
                                                 g_xrea2_d[l_ac].advmoney 
                                           USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3
               END IF
         END CASE  
      END IF      
      #160505-00007#25 mod---e---      
      IF cl_null(g_xrea2_d[l_ac].stomoney) THEN LET g_xrea2_d[l_ac].stomoney = 0 END IF
      IF cl_null(g_xrea2_d[l_ac].retmoney) THEN LET g_xrea2_d[l_ac].retmoney = 0 END IF  
      IF cl_null(g_xrea2_d[l_ac].addmoney) THEN LET g_xrea2_d[l_ac].addmoney = 0 END IF  
      IF cl_null(g_xrea2_d[l_ac].redmoney) THEN LET g_xrea2_d[l_ac].redmoney = 0 END IF 
      IF cl_null(g_xrea2_d[l_ac].advmoney) THEN LET g_xrea2_d[l_ac].advmoney = 0 END IF       
      
      #160505-00007#25 mod---s---
      ##調匯
      #LET g_sql = "   SELECT SUM(xreh115)                                                   ",
      #            "     FROM xreg_t,xreh_t                                                  ",
      #            "         ,xrea_t ",    #151223-00001#2 調匯串月結
      #            "    WHERE xregent = xrehent AND xregent = '",g_enterprise,"'             ",
      #            "      AND xregld = xrehld   AND xregld  = '",g_xrea2_d[l_ac].group1,"'   ",
      #            "      AND xregdocno = xrehdocno                                           ",
      #            "      AND xreg003 = 'AR'                              ",
      #            "      AND xreg001 = '",g_input.year,"' AND xreg002 = '",g_xrea002,"'     ",                 
      #            "      AND xregstus = 'Y'                              ",
      #            #151223-00001#2-----s
      #            "      AND xreaent = xrehent ",
      #            "      AND xreald  = xrehld ",
      #            "      AND xrea001 = xreh001 ",
      #            "      AND xrea002 = xreh002 ",
      #            "      AND xrea003 = xreh003 ",
      #            "      AND xrea004 = xreh004 ",
      #            "      AND xrea005 = xreh005 ",
      #            "      AND xrea006 = xreh006 ",
      #            "      AND xrea007 = xreh007 "
      #            #151223-00001#2-----e
      #            #"      AND xreh009 =  '",g_xrea2_d[l_ac].group2,"'                        "
      ##151223-00001#2---s---   
      #IF g_prog = 'axrq930' THEN   
      #   CASE g_input.group
      #      WHEN 1 
      #          LET g_sql = g_sql CLIPPED ," AND xreh009 = '",g_xrea2_d[l_ac].group2,"' "  #交易對象
      #      WHEN 2
      #          LET g_sql = g_sql CLIPPED ," AND xreh009 = '",g_xrea2_d[l_ac].group2,"' ", #交易對象
      #                                     " AND xreh019 = '",g_xrea2_d[l_ac].group3,"' "  #科目  
      #      WHEN 3
      #          LET g_sql = g_sql CLIPPED ," AND xreh005 = '",g_xrea2_d[l_ac].group2,"' "  #單號  
      #   END CASE
      #ELSE
      #
      #   CASE g_input.group
      #      WHEN 1 
      #        LET g_sql = g_sql CLIPPED," AND xreh009 = '",g_xrea2_d[l_ac].group2,"'  ", #交易對象
      #                                  " AND COALESCE(xreh011,' ') = COALESCE('",g_xrea2_d[l_ac].xrea011,"',' ') ", #部門
      #                                  " AND COALESCE(xreh016,' ') = COALESCE('",g_xrea2_d[l_ac].xrea016,"',' ') ",  #人員
      #                                  " AND xrea045 = '",g_xrea2_d[l_ac].pmab053,"' "  #交易條件   #albireo 151228沒單
      #      WHEN 2
      #        LET g_sql = g_sql CLIPPED," AND xreh009 = '",g_xrea2_d[l_ac].group2,"'  ",
      #                                  " AND xreh019 = '",g_xrea2_d[l_ac].group3,"'  ",
      #                                  " AND COALESCE(xreh011,' ') = COALESCE('",g_xrea2_d[l_ac].xrea011,"',' ') ", #部門
      #                                  " AND COALESCE(xreh016,' ') = COALESCE('",g_xrea2_d[l_ac].xrea016,"',' ') ",  #人員
      #                                  " AND xrea045 = '",g_xrea2_d[l_ac].pmab053,"' "  #交易條件   #albireo 151228沒單
      #      WHEN 3
      #          LET g_sql = g_sql CLIPPED ," AND xreh005 = '",g_xrea2_d[l_ac].group2,"' "     
      #      WHEN 4
      #          LET g_sql = g_sql CLIPPED ," AND xreh009 = '",g_xrea2_d[l_ac].group2,"' "
      #      WHEN 5
      #          LET g_sql = g_sql CLIPPED ," AND xreh009 = '",g_xrea2_d[l_ac].group2,"' ", #交易對象
      #                                     " AND xreh019 = '",g_xrea2_d[l_ac].group3,"' "  #科目
      #   END CASE    
      #END IF         
      ##151223-00001#2---e---
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xreh100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #
      #PREPARE axrq932_pb3_prep10 FROM g_sql  
      #EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
      #IF g_prog = 'axrq930' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' THEN   #160705-00042#10 160713 by sakura add
         CASE g_input.group
            WHEN 1 
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].xrea100
               
               ELSE  
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
               END IF
            WHEN 2
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100
               
               ELSE  
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].group3
               END IF
            WHEN 3
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].xrea100              
               ELSE  
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2                                                
               END IF         
         END CASE          
      ELSE
         CASE g_input.group
            WHEN 1 
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1 ,g_xrea2_d[l_ac].group2, #帳套/交易對象
                                                  g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,#部門/人員
                                                  g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].xrea100 #交易條件
                                                   
               ELSE
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1 ,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016,
                                                  g_xrea2_d[l_ac].pmab053
               END IF                                        
            WHEN 2
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                                  g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016, #部門/人員                                             
                                                  g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].xrea100  #交易條件              
               ELSE
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                                  g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea016, #部門/人員                                             
                                                  g_xrea2_d[l_ac].pmab053
               END IF
            WHEN 3
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].xrea100                                         
               ELSE
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2                                          
               END IF
            WHEN 4
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].xrea100                               
               ELSE
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2                                          
               END IF
            WHEN 5
               IF g_input.curr = 'Y' THEN #加上幣別
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100 
               ELSE
                  EXECUTE axrq932_pb3_prep10 INTO g_xrea2_d[l_ac].adjmoney
                                            USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                                  g_xrea2_d[l_ac].group3
               END IF                      
         END CASE    
      END IF        
      #160505-00007#25 mod---e---
      IF cl_null(g_xrea2_d[l_ac].adjmoney) THEN LET g_xrea2_d[l_ac].adjmoney = 0 END IF
      
      #151223-00001#4 add ------
      #重評前本幣 = xrea113 - 調匯金額
      LET g_xrea2_d[l_ac].xrea1136 = g_xrea2_d[l_ac].xrea1134 - g_xrea2_d[l_ac].adjmoney
      #151223-00001#4 add end---
      
      #160505-00007#25 mod---s---
      ##實際付款金額      
      #LET g_sql = "   SELECT SUM(a)                                                        ", 
      #            "     FROM( SELECT xrde119 a                                             ",
      #            "             FROM xrca_t,xrde_t                                         ",
      #            "            WHERE xrcaent = xrdeent                                     ",
      #            "              AND xrcaent = '",g_enterprise,"'                          ",
      #            "              AND xrcald = xrdeld                                       ",
      #            "              AND xrcadocno = xrdedocno                                 ",
      #            "              AND xrcald = '",g_xrea2_d[l_ac].group1,"'                 ",
      #            "              AND xrde002 = '10'                                        ",
      #            "              AND xrcastus = 'Y'                                        ",  
      #            "              AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
      #            "              AND xrca004   = '",g_xrea2_d[l_ac].group2,"'              "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #   LET g_sql = g_sql CLIPPED," AND xrca035 = '",g_xrea2_d[l_ac].group3,"'            "
      #END IF
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrca100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #LET g_sql = g_sql CLIPPED ," UNION  ALL",
      #            "   SELECT xrde119                                                 ",
      #            "      FROM xrda_t,xrde_t                                          ",
      #            "     WHERE xrdaent = xrdeent                                      ",
      #            "       AND xrdaent = '",g_enterprise,"'                           ",
      #            "       AND xrdald = xrdeld                                        ",
      #            "       AND xrdald = '",g_xrea2_d[l_ac].group1,"'                  ",
      #            "       AND xrdadocno = xrdedocno                                  ",
      #            "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'  ",
      #            "       AND xrde002 = '10'                                         ",
      #            "       AND xrdastus = 'Y'                                         ",  
      #            "       AND xrda005   = '",g_xrea2_d[l_ac].group2,"'               "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #  LET g_sql = g_sql CLIPPED," AND xrde016 = '",g_xrea2_d[l_ac].group3,"'      "
      #END IF 
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrde100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #LET g_sql = g_sql CLIPPED , ")" 
      #PREPARE axrq932_pb3_prep11 FROM g_sql  
      #EXECUTE axrq932_pb3_prep11 INTO g_xrea2_d[l_ac].paymoney
      CASE g_input.group
         WHEN 2
            IF g_input.curr = 'Y' THEN 
               EXECUTE axrq932_pb3_prep11 INTO g_xrea2_d[l_ac].paymoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100
            ELSE
               EXECUTE axrq932_pb3_prep11 INTO g_xrea2_d[l_ac].paymoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3
                                                
            END IF  
         OTHERWISE
            IF g_input.curr = 'Y' THEN 
               EXECUTE axrq932_pb3_prep11 INTO g_xrea2_d[l_ac].paymoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].xrea100
            ELSE
               EXECUTE axrq932_pb3_prep11 INTO g_xrea2_d[l_ac].paymoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2
                                                
            END IF          
      END CASE         
      #160505-00007#25 mod---e---
       IF cl_null(g_xrea2_d[l_ac].paymoney) THEN LET g_xrea2_d[l_ac].paymoney = 0 END IF  
  
      #160505-00007#25 mod---s---
      ##本期其他沖帳金額
      #LET g_sql = "   SELECT SUM(a)                                                        ", 
      #            "     FROM( SELECT (CASE WHEN xrde015 ='D' THEN xrde119 * -1 ELSE xrde119 END) a  ",
      #            "             FROM xrca_t,xrde_t                                         ",
      #            "            WHERE xrcaent = xrdeent                                     ",
      #            "              AND xrcaent = '",g_enterprise,"'                          ",
      #            "              AND xrcald = xrdeld                                       ",
      #            "              AND xrcadocno = xrdedocno                                 ",
      #            "              AND xrcald = '",g_xrea2_d[l_ac].group1,"'                 ",
      #            "              AND xrde002 <> '20' AND xrde002 <> '10'                                       ",
      #            "              AND xrcastus = 'Y'                                        ", 
      #            "              AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"' ",
      #            "              AND xrca004   = '",g_xrea2_d[l_ac].group2,"'              "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #   LET g_sql = g_sql CLIPPED," AND xrce016 = '",g_xrea2_d[l_ac].group3,"'        "
      #END IF
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrca100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #LET g_sql = g_sql CLIPPED ," UNION  ",
      #            "    SELECT (CASE WHEN xrde015 ='D' THEN xrde119 * -1 ELSE xrde119 END) ",
      #            "      FROM xrda_t,xrde_t                                          ",
      #            "     WHERE xrdaent = xrdeent                                      ",
      #            "       AND xrdaent = '",g_enterprise,"'                           ",
      #            "       AND xrdald = xrdeld                                        ",
      #            "       AND xrdald = '",g_xrea2_d[l_ac].group1,"'                  ",
      #            "       AND xrdadocno = xrdedocno                                  ",
      #            "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'  ",
      #            "              AND xrde002 <> '20' AND xrde002 <> '10'                                       ",
      #             "      AND xrdastus = 'Y'                                         ",  
      #            "       AND xrda005   = '",g_xrea2_d[l_ac].group2,"'               "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #   LET g_sql = g_sql CLIPPED," AND xrde016 = '",g_xrea2_d[l_ac].group3,"'      "
      #END IF
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrde100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #LET g_sql = g_sql CLIPPED ," UNION  ",
      #            "    SELECT (CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END)    ",
      #            "      FROM xrca_t,xrce_t                                                  ",
      #            "     WHERE xrcaent = xrceent AND xrcaent = '",g_enterprise,"'             ",
      #            "       AND xrcald = xrceld AND xrcald = '",g_xrea2_d[l_ac].group1,"'      ",
      #            "       AND xrcadocno = xrcedocno                                          ",
      #            "       AND xrce027 = 'N'                                                  ",
      #            "       AND NOT (xrce001 = 'axrt430' AND EXISTS(SELECT 1 FROM xrca_t       ",
      #            "                                                WHERE xrcaent = xrceent   ",
      #            "                                                  AND xrcadocno = xrce003 ",
      #            "                                                  AND xrcald = xrceld     ",
      #            "                                                  AND xrca001 LIKE '1%')) ", 
      #            "                  AND xrce002 LIKE '4%'                                   ",
      #            "       AND xrcastus = 'Y'                                              ",
      #            "       AND xrcadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'       ",
      #            "       AND xrca004   = '",g_xrea2_d[l_ac].group2,"'                    "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #   LET g_sql = g_sql CLIPPED," AND xrce016 = '",g_xrea2_d[l_ac].group3,"'            "
      #END IF  
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrca100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF      
      #LET g_sql = g_sql CLIPPED ," UNION  ",
      #            "    SELECT (CASE WHEN xrce015 ='D' THEN xrce119 * -1 ELSE xrce119 END) b  ",
      #            "      FROM xrda_t,xrce_t                                                  ",
      #            "     WHERE xrdaent = xrceent AND xrdaent = '",g_enterprise,"'             ",
      #            "       AND xrdald = xrceld  AND xrdald = '",g_xrea2_d[l_ac].group1,"'     ",
      #            "       AND xrdadocno = xrcedocno                                          ",
      #            "       AND xrce027  = 'N'                                                 ",
      #            "       AND xrdastus = 'Y'                                                 ",
      #            "       AND NOT (xrce001 = 'axrt430' AND EXISTS(SELECT 1 FROM xrca_t       ",
      #            "                                                WHERE xrcaent = xrceent   ",
      #            "                                                  AND xrcadocno = xrce003 ",
      #            "                                                  AND xrcald = xrceld     ",
      #            "                                                  AND xrca001 LIKE '1%')) ",                  
      #            "       AND xrce002 LIKE '4%'                                             ",               
      #            "       AND xrdadocdt BETWEEN '",g_strdate,"' AND '",g_enddate,"'         ",                  
      #            "       AND xrda005   = '",g_xrea2_d[l_ac].group2,"'                      "
      #IF g_input.group ='2' THEN  #加上科目彙總
      #   LET g_sql = g_sql CLIPPED," AND xrce016 = '",g_xrea2_d[l_ac].group3,"'      "
      #END IF
      #IF g_input.curr = 'Y' THEN #加上幣別
      #   LET g_sql = g_sql CLIPPED ," AND xrce100 = '",g_xrea2_d[l_ac].xrea100,"' "
      #END IF
      #LET g_sql = g_sql CLIPPED , ")" 
      #PREPARE axrq932_pb3_prep12 FROM g_sql  
      #EXECUTE axrq932_pb3_prep12 INTO g_xrea2_d[l_ac].anomoney
      CASE g_input.group 
         WHEN 2
            IF g_input.curr = 'Y' THEN 
               EXECUTE axrq932_pb3_prep12 INTO g_xrea2_d[l_ac].anomoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].xrea100                                
            ELSE
               EXECUTE axrq932_pb3_prep12 INTO g_xrea2_d[l_ac].anomoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group3
            
            END IF
         OTHERWISE
            IF g_input.curr = 'Y' THEN 
               EXECUTE axrq932_pb3_prep12 INTO g_xrea2_d[l_ac].anomoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].xrea100,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].xrea100 
            ELSE
               EXECUTE axrq932_pb3_prep12 INTO g_xrea2_d[l_ac].anomoney
                                         USING g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2,
                                               g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group2                                    
            END IF                       
      END CASE        
      #160505-00007#25 mod---e---
      
      IF cl_null(g_xrea2_d[l_ac].anomoney) THEN LET g_xrea2_d[l_ac].anomoney = 0 END IF 

      CALL l_xrea.clear()
      FOR l_count = 1 TO 20
         #160505-00007#25 mod---s---
         #本幣各個金額所在的區間
         #LET g_sql = "   SELECT SUM(xrea113),SUM(xrea113_debt)                                   ",     #151012-00014#4
         #LET g_sql = "   SELECT SUM(",l_field,"),SUM(",l_field2,")                               ",     #151012-00014#4                     
         #            "     FROM axrq932_tmp                                                      ",        
         #            "    WHERE day2 BETWEEN ",g_xrae[l_count].str," AND ",g_xrae[l_count].end," ",
         #            "      AND ",l_str," = '",l_str2,"'                                         ", 
         #            "      AND xrea002 ='",g_xrea002,"'                                         ",
         #            "      AND per = '2'                                                        ",                    
         #            "      AND " , g_b2_wc
         #IF g_input.curr = 'Y' THEN          
         #   LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
         #END IF            
         #IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN 
         #   LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
         #END IF   
         #LET g_sql = g_sql,l_group
         #         
         #PREPARE axrq932_pb3_prep5 FROM g_sql           
         #EXECUTE axrq932_pb3_prep5 INTO l_xrea[l_count].xrea113,l_xrea[l_count].xrea113_debt
         IF g_input.curr = 'Y' THEN      
            EXECUTE axrq932_pb3_prep5 INTO l_xrea[l_count].xrea113,l_xrea[l_count].xrea113_debt          
                                     USING g_xrae[l_count].str,g_xrae[l_count].end,l_str2,
                                           g_xrea2_d[l_ac].xrea100
         ELSE
            EXECUTE axrq932_pb3_prep5 INTO l_xrea[l_count].xrea113,l_xrea[l_count].xrea113_debt          
                                     USING g_xrae[l_count].str,g_xrae[l_count].end,l_str2          
         END IF           
         #160505-00007#25 mod---e---
          IF cl_null(l_xrea[l_count].xrea113) THEN LET l_xrea[l_count].xrea113 = 0 END IF
          IF cl_null(l_xrea[l_count].xrea113_debt) THEN LET l_xrea[l_count].xrea113_debt = 0 END IF
          
          IF l_count > 1 THEN
             IF l_xrea[l_count].xrea113 < 0 THEN
                LET l_xrea[1].xrea113 = l_xrea[1].xrea113 + l_xrea[l_count].xrea113           
                LET l_xrea[l_count].xrea113 = 0
             END IF
             IF l_xrea[l_count].xrea113_debt < 0 THEN
                LET l_xrea[1].xrea113_debt = l_xrea[1].xrea113_debt + l_xrea[l_count].xrea113_debt             
                LET l_xrea[l_count].xrea113_debt = 0
             END IF  
          END IF             
      END FOR
      
      #160505-00007#25 mod---s---
      ##不在範圍內的天數#固定塞到第21格
      ##LET g_sql = "   SELECT SUM(xrea113),SUM(xrea113_debt)            ", #151012-00014#4                      
      # LET g_sql = "   SELECT SUM(",l_field,"),SUM(",l_field2,")        ", #151012-00014#4                     
      #             "     FROM axrq932_tmp                               ",        
      #             "    WHERE day2 >  ",g_end_day,"                     ",
      #             "      AND ",l_str," = '",l_str2,"'                  ",
      #             "      AND per = '2'                                 ",                   
      #             "      AND xrea002 ='",g_xrea002,"'                  ",                      
      #             "      AND " , g_b2_wc
      #IF g_input.curr = 'Y' THEN          
      #   LET g_sql = g_sql CLIPPED , "  AND xrea100 =  '",g_xrea2_d[l_ac].xrea100,"'  "
      #END IF             
      #IF g_input.apca0012 = 'N' OR g_input.dedtype = '1' THEN  #不扣除　二類不算    
      #   LET g_sql = g_sql, " AND  xrea004 NOT LIKE '2%' "
      #END IF   
      #LET g_sql = g_sql,l_group     
      #PREPARE axrq932_pb3_prep6 FROM g_sql           
      #EXECUTE axrq932_pb3_prep6 INTO l_xrea[21].xrea113,l_xrea[21].xrea113_debt
      IF g_input.curr = 'Y' THEN 
         EXECUTE axrq932_pb3_prep6 INTO l_xrea[21].xrea113,l_xrea[21].xrea113_debt
                                  USING l_str2,g_xrea2_d[l_ac].xrea100
      ELSE
         EXECUTE axrq932_pb3_prep6 INTO l_xrea[21].xrea113,l_xrea[21].xrea113_debt
                                  USING l_str2      
      END IF         
      #160505-00007#25 mod---e---
      IF cl_null( l_xrea[21].xrea113)THEN LET  l_xrea[21].xrea113 = 0 END IF  
      IF cl_null( l_xrea[21].xrea113_debt)THEN LET  l_xrea[21].xrea113_debt = 0 END IF
      IF l_xrea[21].xrea113 < 0 THEN
             LET l_xrea[1].xrea113 = l_xrea[1].xrea113 + l_xrea[21].xrea113             
             LET l_xrea[21].xrea113 = 0          
      END IF
      IF l_xrea[21].xrea113_debt < 0 THEN
         LET l_xrea[1].xrea113_debt = l_xrea[1].xrea113_debt + l_xrea[21].xrea113_debt
         LET l_xrea[21].xrea113_debt = 0
      END IF              
      LET g_xrea2_d[l_ac].xrea103_01 = l_xrea[1].xrea113       
      LET g_xrea2_d[l_ac].xrea103_02 = l_xrea[2].xrea113  
      LET g_xrea2_d[l_ac].xrea103_03 = l_xrea[3].xrea113  
      LET g_xrea2_d[l_ac].xrea103_04 = l_xrea[4].xrea113  
      LET g_xrea2_d[l_ac].xrea103_05 = l_xrea[5].xrea113  
      LET g_xrea2_d[l_ac].xrea103_06 = l_xrea[6].xrea113  
      LET g_xrea2_d[l_ac].xrea103_07 = l_xrea[7].xrea113  
      LET g_xrea2_d[l_ac].xrea103_08 = l_xrea[8].xrea113  
      LET g_xrea2_d[l_ac].xrea103_09 = l_xrea[9].xrea113  
      LET g_xrea2_d[l_ac].xrea103_10 = l_xrea[10].xrea113
      LET g_xrea2_d[l_ac].xrea103_11 = l_xrea[11].xrea113 
      LET g_xrea2_d[l_ac].xrea103_12 = l_xrea[12].xrea113 
      LET g_xrea2_d[l_ac].xrea103_13 = l_xrea[13].xrea113 
      LET g_xrea2_d[l_ac].xrea103_14 = l_xrea[14].xrea113 
      LET g_xrea2_d[l_ac].xrea103_15 = l_xrea[15].xrea113 
      LET g_xrea2_d[l_ac].xrea103_16 = l_xrea[16].xrea113 
      LET g_xrea2_d[l_ac].xrea103_17 = l_xrea[17].xrea113 
      LET g_xrea2_d[l_ac].xrea103_18 = l_xrea[18].xrea113 
      LET g_xrea2_d[l_ac].xrea103_19 = l_xrea[19].xrea113 
      LET g_xrea2_d[l_ac].xrea103_20 = l_xrea[20].xrea113 
      LET g_xrea2_d[l_ac].xrea103_21 = l_xrea[21].xrea113
      LET g_xrea2_d[l_ac].xrea113_01 = l_xrea[1].xrea113_debt       
      LET g_xrea2_d[l_ac].xrea113_02 = l_xrea[2].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_03 = l_xrea[3].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_04 = l_xrea[4].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_05 = l_xrea[5].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_06 = l_xrea[6].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_07 = l_xrea[7].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_08 = l_xrea[8].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_09 = l_xrea[9].xrea113_debt 
      LET g_xrea2_d[l_ac].xrea113_10 = l_xrea[10].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_11 = l_xrea[11].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_12 = l_xrea[12].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_13 = l_xrea[13].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_14 = l_xrea[14].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_15 = l_xrea[15].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_16 = l_xrea[16].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_17 = l_xrea[17].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_18 = l_xrea[18].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_19 = l_xrea[19].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_20 = l_xrea[20].xrea113_debt
      LET g_xrea2_d[l_ac].xrea113_21 = l_xrea[21].xrea113_debt 
      
      LET l_pmab031 =''      
      CASE        
         WHEN g_input.group = '1' #帳套 + 交易對象   + 部門 + 人員            
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)
          WHEN g_input.group = '2' #帳套+交易對象+ 科目  + 部門 + 人員                       
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)     
            LET g_xrea2_d[l_ac].group3_desc = s_desc_get_account_desc(g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group3) 
          WHEN g_input.group = '3' #帳款單號+發票號碼                           
          
          WHEN g_input.group = '4' #帳套 + 交易對象 #150401-00001#35 ---s---
           SELECT pmab081,pmab087,pmab109 #人員 交易條件
             INTO g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].xrea011
             FROM pmab_t
            WHERE pmabent = g_enterprise
              AND pmabsite = g_input.xreasite
              AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)
            
         WHEN g_input.group = '5' #帳套 + 交易對象
            SELECT pmab081,pmab037,pmab109 #人員 交易條件
              INTO g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].xrea011
              FROM pmab_t
             WHERE pmabent = g_enterprise
               AND pmabsite = g_input.xreasite
               AND pmab001 = g_xrea2_d[l_ac].group2 #交易對象
            LET g_xrea2_d[l_ac].group1_desc = s_desc_get_ld_desc(g_xrea2_d[l_ac].group1)
            LET g_xrea2_d[l_ac].group2_desc = s_desc_get_trading_partner_abbr_desc(g_xrea2_d[l_ac].group2)
            LET g_xrea2_d[l_ac].group3_desc = s_desc_get_account_desc(g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group3)                               
      END CASE
      LET g_xrea2_d[l_ac].xrea011_desc = s_desc_get_department_desc(g_xrea2_d[l_ac].xrea011)
      LET g_xrea2_d[l_ac].xrea016_desc = s_desc_get_person_desc(g_xrea2_d[l_ac].xrea016) 
      LET g_xrea2_d[l_ac].pmab053_desc = s_desc_get_ooib002_desc(g_xrea2_d[l_ac].pmab053)  
      
     #報表用資料表
     #151223-00001#4 add xrea1136
     INSERT INTO axrq932_tmp03   #160727-00019#6   16/07/29 By 08734  axrq932_print_tmp2 ——> axrq932_tmp03
     VALUES(l_xreasite,g_input.year,g_xrea_d[l_ac].xrea002,l_xrad001,l_xrad004,l_dedtype,l_cre_desc,l_group_desc,
            g_xrea2_d[l_ac].group1,g_xrea2_d[l_ac].group1_desc,g_xrea2_d[l_ac].group2,g_xrea2_d[l_ac].group2_desc,
            g_xrea2_d[l_ac].group3,g_xrea2_d[l_ac].group3_desc,
            g_xrea2_d[l_ac].xrea011,g_xrea2_d[l_ac].xrea011_desc,g_xrea2_d[l_ac].xrea016,g_xrea2_d[l_ac].xrea016_desc,
            g_xrea2_d[l_ac].pmab053,g_xrea2_d[l_ac].pmab053_desc,g_xrea2_d[l_ac].xrea100,
            g_xrea2_d[l_ac].xrea1031,g_xrea2_d[l_ac].xrea1032,g_xrea2_d[l_ac].xrea1033,g_xrea2_d[l_ac].xrea1034,
            g_xrea2_d[l_ac].xrea1131,g_xrea2_d[l_ac].xrea1132,g_xrea2_d[l_ac].xrea1133,g_xrea2_d[l_ac].xrea1136,g_xrea2_d[l_ac].xrea1134,
            g_xrea2_d[l_ac].xrea1035,g_xrea2_d[l_ac].xrea1135,
            g_xrea2_d[l_ac].crecurr,g_xrea2_d[l_ac].crelim,
            g_xrea2_d[l_ac].stomoney,g_xrea2_d[l_ac].advmoney,g_xrea2_d[l_ac].retmoney,g_xrea2_d[l_ac].addmoney,
            g_xrea2_d[l_ac].adjmoney,g_xrea2_d[l_ac].redmoney,g_xrea2_d[l_ac].paymoney,g_xrea2_d[l_ac].anomoney,            
            g_xrea2_d[l_ac].xrea103_01,g_xrea2_d[l_ac].xrea113_01,g_xrea2_d[l_ac].xrea103_02,g_xrea2_d[l_ac].xrea113_02,
            g_xrea2_d[l_ac].xrea103_03,g_xrea2_d[l_ac].xrea113_03,g_xrea2_d[l_ac].xrea103_04,g_xrea2_d[l_ac].xrea113_04,
            g_xrea2_d[l_ac].xrea103_05,g_xrea2_d[l_ac].xrea113_05,g_xrea2_d[l_ac].xrea103_06,g_xrea2_d[l_ac].xrea113_07,
            g_xrea2_d[l_ac].xrea103_07,g_xrea2_d[l_ac].xrea113_07,g_xrea2_d[l_ac].xrea103_08,g_xrea2_d[l_ac].xrea113_08,
            g_xrea2_d[l_ac].xrea103_09,g_xrea2_d[l_ac].xrea113_09,g_xrea2_d[l_ac].xrea103_10,g_xrea2_d[l_ac].xrea113_10,
            g_xrea2_d[l_ac].xrea103_11,g_xrea2_d[l_ac].xrea113_11,g_xrea2_d[l_ac].xrea103_12,g_xrea2_d[l_ac].xrea113_12,
            g_xrea2_d[l_ac].xrea103_13,g_xrea2_d[l_ac].xrea113_13,g_xrea2_d[l_ac].xrea103_14,g_xrea2_d[l_ac].xrea113_14,
            g_xrea2_d[l_ac].xrea103_15,g_xrea2_d[l_ac].xrea113_15,g_xrea2_d[l_ac].xrea103_16,g_xrea2_d[l_ac].xrea113_16,
            g_xrea2_d[l_ac].xrea103_17,g_xrea2_d[l_ac].xrea113_17,g_xrea2_d[l_ac].xrea103_18,g_xrea2_d[l_ac].xrea113_18,
            g_xrea2_d[l_ac].xrea103_19,g_xrea2_d[l_ac].xrea113_19,g_xrea2_d[l_ac].xrea103_20,g_xrea2_d[l_ac].xrea113_20,
            g_xrea2_d[l_ac].xrea103_21,g_xrea2_d[l_ac].xrea113_21,                        
            g_xrea2_d[l_ac].mon1,g_xrea2_d[l_ac].mon2,g_xrea2_d[l_ac].mon3,g_xrea2_d[l_ac].mon4,g_xrea2_d[l_ac].mon5,
            g_xrea2_d[l_ac].mon6,g_xrea2_d[l_ac].mon7,g_xrea2_d[l_ac].mon8,g_xrea2_d[l_ac].mon9,g_xrea2_d[l_ac].mon10,
            g_xrea2_d[l_ac].mon11,g_xrea2_d[l_ac].mon12)
      
      LET l_ac = l_ac + 1       
   END FOREACH    
   CALL g_xrea2_d.deleteElement(g_xrea2_d.getLength())    
   CALL axrq932_get_type()   
   CALL axrq932_dis()
END FUNCTION

################################################################################
# Descriptions...: 帳齡天數區間置換
# Memo...........:
# Usage..........: CALL axrq932_title_change()
# Date & Author..: 2015/01/28 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_title_change()
   DEFINE l_i          LIKE type_t.num5 
   DEFINE l_j          LIKE type_t.num5   
   DEFINE l_title1     LIKE gzzd_t.gzzd005
   DEFINE l_title2     LIKE gzzd_t.gzzd005
   DEFINE l_title DYNAMIC ARRAY OF RECORD
          title1   LIKE type_t.chr500,
          title2   LIKE type_t.chr500
          END RECORD
   CALL l_title.clear()
   IF cl_null(g_input.xrad001) THEN RETURN END IF
   #儲存Table_Name,為了動態隱藏欄位
   FOR l_i = 1 TO 9
      LET l_title[l_i].title1 = 'xrea103_0'||l_i
      LET l_title[l_i].title2 = 'xrea113_0'||l_i      
   END FOR
   FOR l_i = 10 TO 20
      LET l_title[l_i].title1 = 'xrea103_'||l_i
      LET l_title[l_i].title2 = 'xrea113_'||l_i      
   END FOR
   
   #找出日期區間
   LET l_ac = 1 
   LET g_sql = " SELECT xrae003,xrae004                 ",     
               "   FROM xrae_t                          ",
               "  WHERE xraeent = ",g_enterprise,"      ",
               "    AND xrae001 = '",g_input.xrad001,"' "  
   PREPARE axrq932_pb2_prep2 FROM g_sql
   DECLARE axrq932_pb2_curs2 CURSOR FOR  axrq932_pb2_prep2
   FOREACH axrq932_pb2_curs2 INTO g_xrae[l_ac].str,g_xrae[l_ac].end            
      LET l_ac = l_ac + 1      
   END FOREACH   
   CALL g_xrae.deleteElement(g_xrae.getLength())
   #Title 置換   
   LET g_hideflag = ''
   LET l_j = 42
   FOR l_i = 1 TO 20
      LET l_title1 = ''
      LET l_title2 = ''
      #IF g_prog = 'axrq930' AND g_input.curr = 'Y' THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'axrq930' AND g_input.curr = 'Y' THEN   #160705-00042#10 160713 by sakura add
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title3' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title4' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'       
      ELSE
      #151012-00014#4 ---e---     
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title2' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
      END IF         
      LET l_title1 = g_xrae[l_i].str||'-'||g_xrae[l_i].end,l_title1
      LET l_title2 = g_xrae[l_i].str||'-'||g_xrae[l_i].end,l_title2
      CALL cl_set_comp_att_text(l_title[l_i].title1,l_title1)
      CALL cl_set_comp_att_text(l_title[l_i].title2,l_title2) 
      LET g_xg_fieldname[l_j] = l_title1 
      LET l_j = l_j +1
      LET g_xg_fieldname[l_j] = l_title2
      LET l_j = l_j +1      
      IF NOT cl_null(g_xrae[l_i].str) THEN
         CALL cl_set_comp_visible(l_title[l_i].title1,TRUE)
         IF g_input.dedtype = 'Y' THEN
            CALL cl_set_comp_visible(l_title[l_i].title2,TRUE)
         END IF
         LET g_hideflag = l_i
     ELSE
         CALL cl_set_comp_visible(l_title[l_i].title1,FALSE)
         CALL cl_set_comp_visible(l_title[l_i].title2,FALSE)
      END IF      
     #取得最後天數            
     IF NOT cl_null(g_xrae[l_i].end) THEN
        LET g_end_day = g_xrae[l_i].end
     END IF  
   END FOR
   #最後一欄
   #IF g_prog = 'axrq930' AND g_input.curr = 'Y' THEN        #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES 'axrq930' AND g_input.curr = 'Y' THEN   #160705-00042#10 160713 by sakura add
      SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title3' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
      SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title4' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'       
   ELSE   
      SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
      SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'title2' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'   
   END IF
   LET l_title1 = '>'||g_end_day,l_title1
   LET l_title2 = '>'||g_end_day,l_title2
   CALL cl_set_comp_att_text('xrea103_21',l_title1)
   CALL cl_set_comp_att_text('xrea113_21',l_title2)
   LET g_xg_fieldname[l_j] = l_title1
   LET l_j = l_j +1
   LET g_xg_fieldname[l_j] = l_title2
   #LET g_endday = l_title1
   
   
END FUNCTION

################################################################################
# Descriptions...: 匯總條件置換
# Memo...........:
# Usage..........: CALL axrq932_get_type()
# Date & Author..: 2014/01/25 By Hans 
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_get_type()
DEFINE l_title1       LIKE gzzd_t.gzzd005
DEFINE l_title2       LIKE gzzd_t.gzzd005
DEFINE l_title3       LIKE gzzd_t.gzzd005
DEFINE l_tital1_desc  LIKE gzzd_t.gzzd005
DEFINE l_tital2_desc  LIKE gzzd_t.gzzd005
DEFINE l_tital3_desc  LIKE gzzd_t.gzzd005
   
   LET l_title1 = ''
   LET l_title2 = ''
   LET l_title3 = ''
   LET l_tital1_desc = ''
   LET l_tital2_desc = ''
   LET l_tital3_desc = ''
   
   CASE
      WHEN g_input.group = '1' #帳套+交易對象
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
         LET g_xg_fieldname[9] = l_title1       
         LET g_xg_fieldname[10] = l_tital1_desc  
         LET g_xg_fieldname[11] = l_title2       
         LET g_xg_fieldname[12] = l_tital2_desc  
      WHEN g_input.group = '2' #帳套+交易對象+科目
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932' 
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_title3 FROM gzzd_t WHERE gzzd003 = 'group_11' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         SELECT gzzd005 INTO l_tital3_desc  FROM gzzd_t WHERE gzzd003 = 'group_11_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq932'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group3',l_title3)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
         CALL cl_set_comp_att_text('group3_desc',l_tital3_desc)
         LET g_xg_fieldname[9] = l_title1        
         LET g_xg_fieldname[10] = l_tital1_desc  
         LET g_xg_fieldname[11] = l_title2       
         LET g_xg_fieldname[12] = l_tital2_desc  
         LET g_xg_fieldname[13] = l_title3    
         LET g_xg_fieldname[14] = l_tital3_desc
      WHEN g_input.group = '3' #帳款單號+發票號碼 #150901-00020#4 ---s---
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_71' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_title3 FROM gzzd_t WHERE gzzd003 = 'group_81' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group3',l_title3)
         LET g_xg_fieldname[11] = l_title2
         LET g_xg_fieldname[13] = l_title3         #150901-00020#4 ---e---
      WHEN g_input.group = '4' #帳套+交易對象  #150401-00001#35 ---s---
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
         LET g_xg_fieldname[1] = l_title1
         LET g_xg_fieldname[2] = l_tital1_desc
         LET g_xg_fieldname[3] = l_title2
         LET g_xg_fieldname[4] = l_tital2_desc
      WHEN g_input.group = '5' #帳套+交易對象+科目
         SELECT gzzd005 INTO l_title1 FROM gzzd_t WHERE gzzd003 = 'group_61' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932' 
         SELECT gzzd005 INTO l_title2 FROM gzzd_t WHERE gzzd003 = 'group_21' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_title3 FROM gzzd_t WHERE gzzd003 = 'group_11' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_tital1_desc  FROM gzzd_t WHERE gzzd003 = 'group_61_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_tital2_desc  FROM gzzd_t WHERE gzzd003 = 'group_21_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         SELECT gzzd005 INTO l_tital3_desc  FROM gzzd_t WHERE gzzd003 = 'group_11_desc' AND gzzd002 = g_dlang AND gzzd001 = 'aapq932'
         CALL cl_set_comp_att_text('group1',l_title1)
         CALL cl_set_comp_att_text('group2',l_title2)
         CALL cl_set_comp_att_text('group3',l_title3)
         CALL cl_set_comp_att_text('group1_desc',l_tital1_desc)
         CALL cl_set_comp_att_text('group2_desc',l_tital2_desc)
         CALL cl_set_comp_att_text('group3_desc',l_tital3_desc)
         LET g_xg_fieldname[1] = l_title1
         LET g_xg_fieldname[2] = l_tital1_desc
         LET g_xg_fieldname[3] = l_title2
         LET g_xg_fieldname[4] = l_tital2_desc
         LET g_xg_fieldname[5] = l_title3
         LET g_xg_fieldname[6] = l_tital3_desc #150401-00001#35 ---e---
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 是否顯示壞帳
# Memo...........:
# Usage..........: CALL axrq932_dis()
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_dis()
DEFINE l_flag      LIKE type_t.chr1

   IF cl_null(g_input.b_check) THEN
      RETURN
   END IF

   IF g_input.b_check = 'Y' THEN
      LET l_flag = TRUE
   ELSE
      LET l_flag = FALSE
   END IF

      CALL cl_set_comp_visible('sel',FALSE)
      CALL cl_set_comp_visible('l_xrea103_debt,l_xrea113_debt,xrea1035,xrea1135',l_flag)
      CALL cl_set_comp_visible('xrea113_01,xrea113_02,xrea113_03,xrea113_04,xrea113_05',l_flag)
      CALL cl_set_comp_visible('xrea113_06,xrea113_07,xrea113_08,xrea113_09,xrea113_10',l_flag)
      CALL cl_set_comp_visible('xrea113_11,xrea113_12,xrea113_13,xrea113_14,xrea113_15',l_flag)
      CALL cl_set_comp_visible('xrea113_16,xrea113_17,xrea113_18,xrea113_19,xrea113_20,xrea113_21',l_flag)   
      CALL axrq932_title_change() 
END FUNCTION

################################################################################
# Descriptions...: 根據agli172設定扣除方式
# Memo...........:
# Usage..........: CALL axrq932_dedtype_def()
# Date & Author..: 2015/3/17 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq932_dedtype_def()
DEFINE l_comp    LIKE ooef_t.ooef001
DEFINE l_ld      LIKE glaa_t.glaald

   #根據營運據點取得所屬帳套
   CALL s_fin_orga_get_comp_ld(g_input.xreasite)RETURNING g_sub_success,g_errno,l_comp,l_ld
   SELECT glcb008 INTO g_input.dedtype
     FROM glcb_t
    WHERE glcbent = g_enterprise
      AND glcbld  = l_ld
      AND glcb001 = 'AR'
   IF cl_null( g_input.dedtype) THEN LET  g_input.dedtype = '2' END IF
   DISPLAY BY NAME g_input.dedtype

END FUNCTION

################################################################################
# Descriptions...: # Descriptions...: 通過客戶信評等級抓取壞帳提列比率（axri041 xraf_t）
# Memo...........:
# Usage..........: CALL axrq932_get_xrek039(p_comp,p_xrca004,p_xrek037)
# Date & Author..: 2017/07/03 By Hans
# Modify.........: #161229-00045#1
################################################################################
PRIVATE FUNCTION axrq932_get_xrek039(p_comp,p_xrca004,p_xrek037)
DEFINE p_comp        LIKE ooef_t.ooef001
DEFINE p_xrca004     LIKE xrca_t.xrca004
DEFINE p_xrek037     LIKE xrek_t.xrek037
DEFINE l_pmab004     LIKE pmab_t.pmab004
DEFINE l_xrae002     LIKE xrae_t.xrae002
DEFINE l_xraf RECORD  #壞帳提列率依信評級設定檔
       xrafent LIKE xraf_t.xrafent, #企業編號
       xraf001 LIKE xraf_t.xraf001, #帳齡類型編號
       xraf002 LIKE xraf_t.xraf002, #信評等級
       xraf003 LIKE xraf_t.xraf003, #分段一壞帳提列率
       xraf004 LIKE xraf_t.xraf004, #分段二壞帳提列率
       xraf005 LIKE xraf_t.xraf005, #分段三壞帳提列率
       xraf006 LIKE xraf_t.xraf006, #分段四壞帳提列率
       xraf007 LIKE xraf_t.xraf007, #分段五壞帳提列率
       xraf008 LIKE xraf_t.xraf008, #分段六壞帳提列率
       xraf009 LIKE xraf_t.xraf009, #分段七壞帳提列率
       xraf010 LIKE xraf_t.xraf010, #分段八壞帳提列率
       xraf011 LIKE xraf_t.xraf011, #分段九壞帳提列率
       xraf012 LIKE xraf_t.xraf012, #分段十壞帳提列率
       xraf013 LIKE xraf_t.xraf013, #分段十一壞帳提列率
       xraf014 LIKE xraf_t.xraf014, #分段十二壞帳提列率
       xraf015 LIKE xraf_t.xraf015, #分段十三壞帳提列率
       xraf016 LIKE xraf_t.xraf016, #分段十四壞帳提列率
       xraf017 LIKE xraf_t.xraf017, #分段十五壞帳提列率
       xraf018 LIKE xraf_t.xraf018, #分段十六壞帳提列率
       xraf019 LIKE xraf_t.xraf019, #分段十七壞帳提列率
       xraf020 LIKE xraf_t.xraf020, #分段十八壞帳提列率
       xraf021 LIKE xraf_t.xraf021, #分段十九壞帳提列率
       xraf022 LIKE xraf_t.xraf022  #分段二十壞帳提列率
       END RECORD
DEFINE r_xrek039     LIKE xrek_t.xrek039
   
   # 信評等級
   SELECT pmab004 INTO l_pmab004 FROM pmab_t  
     WHERE pmabent=g_enterprise AND pmab001 = p_xrca004
       AND pmabsite=p_comp    
   # 分段序號
   SELECT xrae002 INTO l_xrae002 FROM xrae_t 
     WHERE xraeent = g_enterprise
       AND xrae001 = g_input.xrad001  #帳齡類型
       AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
       AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
 
   SELECT xrafent,xraf001,xraf002,xraf003,xraf004,xraf005,xraf006,xraf007,xraf008,xraf009,xraf010,xraf011,
          xraf012,xraf013,xraf014,xraf015,xraf016,xraf017,xraf018,xraf019,xraf020,xraf021,xraf022 INTO l_xraf.* 

   FROM xraf_t 
    WHERE xrafent = g_enterprise
      AND xraf001 = g_input.xrad001  #帳齡類型
      AND xraf002 = l_pmab004 # 信評等級
         
    CASE l_xrae002   # 分段序號
       WHEN 1  LET r_xrek039= l_xraf.xraf003 
       WHEN 2  LET r_xrek039= l_xraf.xraf004
       WHEN 3  LET r_xrek039= l_xraf.xraf005
       WHEN 4  LET r_xrek039= l_xraf.xraf006
       WHEN 5  LET r_xrek039= l_xraf.xraf007
       WHEN 6  LET r_xrek039= l_xraf.xraf008
       WHEN 7  LET r_xrek039= l_xraf.xraf009
       WHEN 8  LET r_xrek039= l_xraf.xraf010
       WHEN 9  LET r_xrek039= l_xraf.xraf011
       WHEN 10  LET r_xrek039= l_xraf.xraf012
       WHEN 11  LET r_xrek039= l_xraf.xraf013
       WHEN 12  LET r_xrek039= l_xraf.xraf014
       WHEN 13  LET r_xrek039= l_xraf.xraf015
       WHEN 14  LET r_xrek039= l_xraf.xraf016
       WHEN 15  LET r_xrek039= l_xraf.xraf017
       WHEN 16  LET r_xrek039= l_xraf.xraf018
       WHEN 17  LET r_xrek039= l_xraf.xraf019
       WHEN 18  LET r_xrek039= l_xraf.xraf020
       WHEN 19  LET r_xrek039= l_xraf.xraf021
       WHEN 20  LET r_xrek039= l_xraf.xraf022
       OTHERWISE  LET r_xrek039= 0 
   END CASE
   IF SQLCA.sqlcode = 100 THEN   
      # 分段序號
      SELECT xrae005 INTO r_xrek039 FROM xrae_t 
       WHERE xraeent = g_enterprise
         AND xrae001 = g_input.xrad001  #帳齡類型
         AND xrae003 <= p_xrek037 #帳齡天數 >= 起始天數
         AND xrae004 >= p_xrek037 #帳齡天數 <= 截止天數
   END IF
   RETURN r_xrek039
END FUNCTION

 
{</section>}
 
