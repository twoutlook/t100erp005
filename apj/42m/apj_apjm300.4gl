#該程式未解開Section, 採用最新樣板產出!
{<section id="apjm300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-10-28 10:34:41), PR版次:0009(2017-02-16 17:42:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: apjm300
#+ Description: 專案主檔變更作業-多階
#+ Creator....: 01534(2015-07-06 18:47:49)
#+ Modifier...: 01534 -SD/PR- 08734
 
{</section>}
 
{<section id="apjm300.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#23  16/04/22 BY 07900   校验代码重复错误讯息的修改
#160818-00017#25 2016-08-22 By 08734  删除修改未重新判断状态码
#161108-00012#3  2016/11/09 By 08734  g_browser_cnt 由num5改為num10
#161124-00048#14 2016/12/15 By 08734  星号整批调整
#161214-00032#2  2016/12/19 By 07900  石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#170203-00002#6  2017/02/03 By 06814  新舊值寫法調整
#170207-00018#3  2017/02/10 By 08734  ROWNUM整批调整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_pjbn_m        RECORD
       pjbn000 LIKE pjbn_t.pjbn000,
   pjbn000_desc LIKE type_t.chr80,
   pjbn001 LIKE pjbn_t.pjbn001,
   pjbn002 LIKE pjbn_t.pjbn002,
   pjbnl003 LIKE pjbnl_t.pjbnl003,
   pjbnl004 LIKE pjbnl_t.pjbnl004,
   pjbn009 LIKE pjbn_t.pjbn009,
   pjbn900 LIKE pjbn_t.pjbn900,
   pjbn003 LIKE pjbn_t.pjbn003,
   pjbn003_desc LIKE type_t.chr80,
   pjbn004 LIKE pjbn_t.pjbn004,
   pjbn004_desc LIKE type_t.chr80,
   pjbn005 LIKE pjbn_t.pjbn005,
   pjbn006 LIKE pjbn_t.pjbn006,   
   pjbnstus LIKE pjbn_t.pjbnstus,
   pjbn007 LIKE pjbn_t.pjbn007,
   pjbn008 LIKE pjbn_t.pjbn008,
   pjbn010 LIKE pjbn_t.pjbn010,
   pjbn010_desc LIKE type_t.chr500,
   pjbn011 LIKE pjbn_t.pjbn011,
   pjbn012 LIKE pjbn_t.pjbn012,
   pjbn012_desc LIKE type_t.chr500,
   pjbn013 LIKE pjbn_t.pjbn013,
   pjbn014 LIKE pjbn_t.pjbn014,
   pjbn015 LIKE pjbn_t.pjbn015,
   pjbn008_desc LIKE type_t.chr80,
   pjbnownid LIKE pjbn_t.pjbnownid,
   pjbnownid_desc LIKE type_t.chr80,
   pjbnowndp LIKE pjbn_t.pjbnowndp,
   pjbnowndp_desc LIKE type_t.chr80,
   pjbncrtid LIKE pjbn_t.pjbncrtid,
   pjbncrtid_desc LIKE type_t.chr80,
   pjbncrtdp LIKE pjbn_t.pjbncrtdp,
   pjbncrtdp_desc LIKE type_t.chr80,
   pjbncrtdt DATETIME YEAR TO SECOND,
   pjbnmodid LIKE pjbn_t.pjbnmodid,
   pjbnmodid_desc LIKE type_t.chr80,
   pjbnmoddt DATETIME YEAR TO SECOND,
   pjbncnfid LIKE pjbn_t.pjbncnfid,
   pjbncnfid_desc LIKE type_t.chr80,
   pjbncnfdt DATETIME YEAR TO SECOND
                  END RECORD 
 type type_g_pjbo_m        RECORD
   pjbo002 LIKE pjbo_t.pjbo002,
   pjbol004 LIKE pjbol_t.pjbol004,
   pjbol005 LIKE pjbol_t.pjbol005,
   pjbo004 LIKE pjbo_t.pjbo004,
   pjbo004_desc LIKE type_t.chr80,
   pjbo003 LIKE pjbo_t.pjbo003,
   pjbo003_desc LIKE type_t.chr80,
   pjbo005 LIKE pjbo_t.pjbo005,
   pjbo006 LIKE pjbo_t.pjbo006,
   pjbo007 LIKE pjbo_t.pjbo007,
   pjbo008 LIKE pjbo_t.pjbo008,
   pjbo009 LIKE pjbo_t.pjbo009,
   pjbo010 LIKE pjbo_t.pjbo010,
   pjbo010_desc LIKE type_t.chr80,
   pjbo011 LIKE pjbo_t.pjbo011,
   pjbo011_desc LIKE type_t.chr80,
   pjbo012 LIKE pjbo_t.pjbo012,
   pjbo001 LIKE pjbo_t.pjbo001
       END RECORD

#單身 type 宣告
 TYPE type_g_pjbq_d        RECORD
       pjbq003 LIKE pjbq_t.pjbq003,
   pjbq004 LIKE pjbq_t.pjbq004,
   pjbq004_desc LIKE type_t.chr80,
   pjbq005 LIKE pjbq_t.pjbq005,
   pjbq005_desc LIKE type_t.chr80,
   pjbq005_desc1 LIKE type_t.chr80,
   pjbq010 LIKE pjbq_t.pjbq010,
   pjbq006 LIKE pjbq_t.pjbq006,
   pjbq006_desc LIKE type_t.chr80,
   pjbq007 LIKE pjbq_t.pjbq007,
   pjbq008 LIKE pjbq_t.pjbq008,
   pjbq009 LIKE pjbq_t.pjbq009
       END RECORD
 TYPE type_g_pjbq2_d RECORD
       pjbr003 LIKE pjbr_t.pjbr003,
   pjbr003_desc LIKE type_t.chr80,
   pjbr004 LIKE pjbr_t.pjbr004,
   pjbr005 LIKE pjbr_t.pjbr005,
   pjbr006 LIKE pjbr_t.pjbr006,
   pjbr007 LIKE pjbr_t.pjbr007,
   pjbr008 LIKE pjbr_t.pjbr008,
   pjbr009 LIKE pjbr_t.pjbr009
       END RECORD

 TYPE type_g_pjbq3_d RECORD
       pjbs003 LIKE pjbs_t.pjbs003,
   pjbs003_desc LIKE type_t.chr80,
   pjbs004 LIKE pjbs_t.pjbs004,
   pjbs004_desc LIKE type_t.chr80,
   pjbs005 LIKE pjbs_t.pjbs005,
   pjbs006 LIKE pjbs_t.pjbs006,
   pjbs007 LIKE pjbs_t.pjbs007,
   pjbs008 LIKE pjbs_t.pjbs008
       END RECORD

 TYPE type_g_pjbq4_d RECORD
       pjbt003 LIKE pjbt_t.pjbt003,
   pjbt003_desc LIKE type_t.chr80,
   pjbt004 LIKE pjbt_t.pjbt004,
   pjbt005 LIKE pjbt_t.pjbt005
       END RECORD

 TYPE type_g_pjbq5_d RECORD
       pjbp002 LIKE pjbp_t.pjbp002,
   pjbp002_desc LIKE type_t.chr80,
   pjbp003 LIKE pjbp_t.pjbp003,
   pjbp003_desc LIKE type_t.chr80,
   pjbp004 LIKE pjbp_t.pjbp004,
   pjbp005 LIKE pjbp_t.pjbp005,
   pjbp006 LIKE pjbp_t.pjbp006
       END RECORD



#模組變數(Module Variables)
DEFINE g_pjbn_m          type_g_pjbn_m
DEFINE g_pjbn_m_t        type_g_pjbn_m
DEFINE g_pjbo_m          type_g_pjbo_m
DEFINE g_pjbo_m_t        type_g_pjbo_m

DEFINE g_pjbo001_t     LIKE pjbo_t.pjbo001
DEFINE g_pjbo002_t     LIKE pjbo_t.pjbo002
DEFINE g_pjbn001_t     LIKE pjbn_t.pjbn001
DEFINE g_pjbn900_t     LIKE pjbn_t.pjbn900


#DEFINE g_pjbo002_t        LIKE pjbo_t.pjbo002
DEFINE g_pjbo003_t        LIKE pjbo_t.pjbo003
#DEFINE g_pjbo001_t      LIKE pjbo_t.pjbo001

DEFINE g_pjbq_d          DYNAMIC ARRAY OF type_g_pjbq_d
DEFINE g_pjbq_d_t        type_g_pjbq_d
DEFINE g_pjbq_d_o        type_g_pjbq_d   #170203-00002#6 20170203 add by beckxie
DEFINE g_pjbq2_d   DYNAMIC ARRAY OF type_g_pjbq2_d
DEFINE g_pjbq2_d_t type_g_pjbq2_d

DEFINE g_pjbq3_d   DYNAMIC ARRAY OF type_g_pjbq3_d
DEFINE g_pjbq3_d_t type_g_pjbq3_d

DEFINE g_pjbq4_d   DYNAMIC ARRAY OF type_g_pjbq4_d
DEFINE g_pjbq4_d_t type_g_pjbq4_d

DEFINE g_pjbq5_d   DYNAMIC ARRAY OF type_g_pjbq5_d
DEFINE g_pjbq5_d_t type_g_pjbq5_d

DEFINE g_browser  DYNAMIC ARRAY OF RECORD
       b_pjbn001   LIKE pjbn_t.pjbn001,
       b_pjbn900   LIKE pjbn_t.pjbn900
                  END RECORD

DEFINE g_tree    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
       #外顯欄位
       b_show          LIKE type_t.chr100,
       #父節點id
       b_pid           LIKE type_t.chr100,
       #本身節點id
       b_id            LIKE type_t.chr100,
       #是否展開
       b_exp           LIKE type_t.chr100,
       #是否有子節點
       b_hasC          LIKE type_t.num5,
       #是否已展開
       b_isExp         LIKE type_t.num5,
       #展開值
       b_expcode       LIKE type_t.num5,
       #tree自定義欄位
      b_pjbo001 LIKE pjbo_t.pjbo001,
      b_pjbo002 LIKE pjbo_t.pjbo002,
      b_pjbo002_desc LIKE pjbol_t.pjbol004,
      b_pjbo003 LIKE pjbo_t.pjbo003,
      b_pjbo004 LIKE pjbo_t.pjbo004,
      b_pjbo004_desc LIKE oocql_t.oocql004,
      b_pjbo005 LIKE pjbo_t.pjbo005,
      b_pjbo006 LIKE pjbo_t.pjbo006,
      b_pjbo007 LIKE pjbo_t.pjbo007,
      b_pjbo008 LIKE pjbo_t.pjbo008,
      b_pjbo009 LIKE pjbo_t.pjbo009,
      b_pjbo010 LIKE pjbo_t.pjbo010,
      b_pjbo010_desc LIKE type_t.chr500,      
      b_pjbo011 LIKE pjbo_t.pjbo011,
      b_pjbo011_desc LIKE type_t.chr500,
      b_pjbo012 LIKE pjbo_t.pjbo012
       END RECORD

DEFINE g_master_multi_table_t    RECORD
      pjbnl001      LIKE pjbnl_t.pjbnl001,
      pjbnl900      LIKE pjbnl_t.pjbnl900,   #add by lixh 20150707
      pjbnl003      LIKE pjbnl_t.pjbnl003,
      pjbnl004      LIKE pjbnl_t.pjbnl004,
      pjbol001_idx2 LIKE pjbol_t.pjbol001,
      pjbol900_idx2 LIKE pjbol_t.pjbol900,
      pjbol002_idx2 LIKE pjbol_t.pjbol002,
      pjbol004_idx2 LIKE pjbol_t.pjbol004,
      pjbol005_idx2 LIKE pjbol_t.pjbol005
      END RECORD
#無單身append欄位定義

DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc_tree             STRING
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_tree_idx         LIKE type_t.num10
DEFINE g_current_master_idx  LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ac                  LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身目前所在筆數  #161108-00012#3 num5==》num10
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數    #161108-00012#3  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數    #161108-00012#3  2016/11/09 By 08734 add
DEFINE g_tree_cnt            LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#3 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_searchtype          LIKE type_t.chr200

DEFINE g_current_master_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#3 num5==》num10
DEFINE g_tree_row            LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_tree_sw             BOOLEAN
DEFINE g_current_master_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#3 num5==》num10
DEFINE g_row_index           LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_root_search         BOOLEAN
DEFINE g_tree_root        DYNAMIC ARRAY OF INTEGER      #root資料所在

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_table1           STRING                        #第1個單身table所使用的g_wc
DEFINE g_wc_table2    STRING                        #第2個單身table所使用的g_wc

DEFINE g_wc_table3    STRING                        #第3個單身table所使用的g_wc

DEFINE g_wc_table4    STRING                        #第4個單身table所使用的g_wc

DEFINE g_wc_table5    STRING                        #第5個單身table所使用的g_wc

DEFINE g_order               STRING

DEFINE g_copy_pjbn001        LIKE pjbn_t.pjbn001
DEFINE g_copy_flag           LIKE type_t.chr1
DEFINE g_add_browse          STRING                        #新增填充用WC
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_pjbq_d_color        DYNAMIC ARRAY OF RECORD
   pjbq003 LIKE type_t.chr80,
   pjbq004 LIKE type_t.chr80,
   pjbq004_desc LIKE type_t.chr80,
   pjbq005 LIKE type_t.chr80,
   pjbq005_desc LIKE type_t.chr80,
   pjbq005_desc1 LIKE type_t.chr80,
   pjbq010 LIKE type_t.chr80,
   pjbq006 LIKE type_t.chr80,
   pjbq006_desc LIKE type_t.chr80,
   pjbq007 LIKE type_t.chr80,
   pjbq008 LIKE type_t.chr80,
   pjbq009 LIKE type_t.chr80
   END RECORD
DEFINE g_pjbq2_d_color       DYNAMIC ARRAY OF RECORD
       pjbr003 LIKE type_t.chr80,
   pjbr003_desc LIKE type_t.chr80,
   pjbr004 LIKE type_t.chr80,
   pjbr005 LIKE type_t.chr80,
   pjbr006 LIKE type_t.chr80,
   pjbr007 LIKE type_t.chr80,
   pjbr008 LIKE type_t.chr80,
   pjbr009 LIKE type_t.chr80
   END RECORD

DEFINE g_pjbq3_d_color     DYNAMIC ARRAY OF RECORD
   pjbs003 LIKE type_t.chr80,
   pjbs003_desc LIKE type_t.chr80,
   pjbs004 LIKE type_t.chr80,
   pjbs004_desc LIKE type_t.chr80,
   pjbs005 LIKE type_t.chr80,
   pjbs006 LIKE type_t.chr80,
   pjbs007 LIKE type_t.chr80,
   pjbs008 LIKE type_t.chr80
       END RECORD

   DEFINE  g_pjbq4_d_color DYNAMIC ARRAY OF RECORD
   pjbt003 LIKE type_t.chr80,
   pjbt003_desc LIKE type_t.chr80,
   pjbt004 LIKE type_t.chr80,
   pjbt005 LIKE type_t.chr80
       END RECORD

   DEFINE  g_pjbq5_d_color DYNAMIC ARRAY OF RECORD
   pjbp002 LIKE type_t.chr80,
   pjbp002_desc LIKE type_t.chr80,
   pjbp003 LIKE type_t.chr80,
   pjbp003_desc LIKE type_t.chr80,
   pjbp004 LIKE type_t.chr80,
   pjbp005 LIKE type_t.chr80,
   pjbp006 LIKE type_t.chr80
       END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="apjm300.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE l_success    LIKE type_t.num5   #add--2015/03/19 By shiun
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apj","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #add--2015/03/19 By shiun
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT pjbo002,'','',pjbo004,'',pjbo003,'',pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,'',pjbo011,'',",
                      "pjbo012,pjbo001 FROM pjbo_t WHERE pjboent= ? AND pjbo001=? AND pjbo002=? AND pjbo900 = ? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE apjm300_bcl6 CURSOR FROM g_forupd_sql 
   
   LET g_forupd_sql = "SELECT pjbn000,'',pjbn001,pjbn002,'','',pjbn009,pjbn900,pjbn003,'',pjbn004,'',pjbn005,pjbn006,pjbn007,pjbn008,'',pjbnownid,'',",
                      "pjbnowndp,'',pjbncrtid,'',pjbncrtdp,'',pjbncrtdt,pjbnmodid,'',pjbnmoddt,pjbncnfid,'',pjbncnfdt,pjbnstus",
                       " FROM pjbn_t WHERE pjbnent = ? AND pjbn001 = ? AND pjbn900 = ? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE apjm300_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjm300 WITH FORM cl_ap_formpath("apj",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apjm300_init()
 
      #進入選單 Menu (='N')
      CALL apjm300_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_apjm300
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi390_drop_tmp_table()   #add--2015/03/19 By shiun
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="apjm300.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#此段落由子樣板a06產生
PRIVATE FUNCTION apjm300_pjba_t(ps_type)
 

#   DEFINE li_cnt    LIKE type_t.num10
    DEFINE ps_type   STRING  
#   DEFINE ls_sql    STRING  
#
#   IF ps_type = "s" THEN 
#            LET ls_sql = 'SELECT pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbnstus,pjbn007,pjbn008,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt FROM pjbn_t WHERE pjbnent= ? AND pjbn001=? ' 
#      DECLARE pjbn_t_cl CURSOR FROM ls_sql 
#      OPEN pjbn_t_cl USING g_enterprise,g_pjbo_m.pjbo001,g_pjbo_m.pjbo002
#      FETCH pjbn_t_cl INTO g_pjbo_m.pjbn000,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbn003,g_pjbo_m.pjbn004,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfdt 
#
#      IF SQLCA.sqlcode THEN
#                  LET g_pjbo_m.pjbn000 = NULL 
#         LET g_pjbo_m.pjbn001 = NULL 
#         LET g_pjbo_m.pjbn002 = NULL 
#         LET g_pjbo_m.pjbn003 = NULL 
#         LET g_pjbo_m.pjbn004 = NULL 
#         LET g_pjbo_m.pjbn005 = NULL 
#         LET g_pjbo_m.pjbn006 = NULL 
#         LET g_pjbo_m.pjbnstus = NULL 
#         LET g_pjbo_m.pjbn007 = NULL 
#         LET g_pjbo_m.pjbn008 = NULL 
#         LET g_pjbo_m.pjbnownid = NULL 
#         LET g_pjbo_m.pjbnowndp = NULL 
#         LET g_pjbo_m.pjbncrtid = NULL 
#         LET g_pjbo_m.pjbncrtdp = NULL 
#         LET g_pjbo_m.pjbncrtdt = NULL 
#         LET g_pjbo_m.pjbnmodid = NULL 
#         LET g_pjbo_m.pjbnmoddt = NULL 
#         LET g_pjbo_m.pjbncnfid = NULL 
#         LET g_pjbo_m.pjbncnfdt  = NULL 
#
#      END IF 
#      RETURN 
#   END IF 
#
#      SELECT COUNT(*) INTO li_cnt FROM pjbn_t WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbo001_t
#   
#   IF li_cnt = 0 AND ps_type = "u" THEN 
#            INSERT INTO pjbn_t 
#      (pjbnent,pjbn001,pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbnstus,pjbn007,pjbn008,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt )
#      VALUES (g_enterprise,g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbo_m.pjbn000,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbn003,g_pjbo_m.pjbn004,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfdt )
#   END IF 
#
#   IF li_cnt > 0 AND ps_type = "u" THEN 
#            UPDATE pjbn_t SET 
#      (pjbn001,pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbnstus,pjbn007,pjbn008,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt ) = 
#      (g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbo_m.pjbn000,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbn003,g_pjbo_m.pjbn004,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfdt ) 
#      WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbo001_t
#
#   END IF 
#
#   IF li_cnt > 0 AND ps_type = "d" THEN 
#            DELETE FROM pjbn_t
#      WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbo001_t
#   END IF 
#
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("",SQLCA.sqlcode,0)
#   END IF 
#


END FUNCTION

PRIVATE FUNCTION apjm300_init()
   #add-point:init段define
   {<point name="init.define"/>}
   #end add-point

   LET g_bfill = "Y"
   LET g_searchtype = "3"
   LET g_error_show = 1
      CALL cl_set_combo_scc_part('pjbnstus','50','N,X,Y')

    CALL cl_set_combo_scc('pjbn007','16008')
    CALL cl_set_combo_scc('pjbo012','16003')
    CALL cl_set_combo_scc('b_pjbo012','16003')
   
   #add-point:畫面資料初始化
   {<point name="init.init"/>}
   #end add-point

   CALL apjm300_default_search()

END FUNCTION

PRIVATE FUNCTION apjm300_tree_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   {<point name="browser_search.define"/>}
   #end add-point

   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00005"
      LET g_errparam.extend = "searchcol"
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN FALSE
   END IF

   IF NOT cl_null(g_searchstr) THEN
      LET g_wc_tree = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc_tree = g_wc_tree.toLowerCase()
   ELSE
      LET g_wc_tree = " 1=1 "
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc_tree = g_wc_tree, " ORDER BY pjbo001"
   ELSE
      LET g_wc_tree = g_wc_tree, " ORDER BY ", g_searchcol
   END IF

   CALL apjm300_tree_fill()
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION apjm300_ui_dialog()
   #add-point:ui_dialog段define
   {<point name="ui_dialog.define"/>}
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   CALL cl_set_act_visible("accept,cancel", FALSE)

   #temp CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   #temp CALL gfrm_curr.setElementHidden("mainlayout",1)
   #temp CALL gfrm_curr.setElementHidden("worksheet",0)
   #temp LET g_main_hidden = 1

   #add-point:ui_dialog段before dialog
   {<point name="ui_dialog.before_dialog"/>}
   #end add-point

   WHILE TRUE

      CALL apjm300_browser_fill()

      CALL cl_notice()

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

#         INPUT g_searchstr,g_searchcol,g_searchtype FROM formonly.searchstr,formonly.cbo_searchcol,formonly.rdo_searchtype
#            BEFORE INPUT
#         END INPUT

         #左側瀏覽頁簽
         DISPLAY ARRAY g_tree TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)

            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_tree_idx = DIALOG.getCurrentRow("s_browse")
               IF g_tree_row > 1 AND g_tree_idx = 1 AND g_tree_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_tree_row)
                  LET g_tree_idx = g_tree_row
               END IF
               LET g_tree_row = g_tree_idx #目前指標
               LET g_tree_sw = TRUE

               IF g_tree_idx > g_tree.getLength() THEN
                  LET g_tree_idx = g_tree.getLength()
               END IF

               CALL apjm300_fetch2() # reload data
               #LET g_detail_idx = 1
               CALL apjm300_ui_detailshow() #Setting the current row

               CALL apjm300_idx_chk()
               #NEXT FIELD pjbq003

               ON EXPAND (g_row_index)
                  #樹展開
                  CALL apjm300_tree_expand(g_row_index)
                  LET g_tree[g_row_index].b_isExp = 1

               ON COLLAPSE (g_row_index)
                  #樹關閉

         END DISPLAY

         DISPLAY ARRAY g_pjbq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               CALL apjm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx2 = l_ac
               CALL s_apjm300_hint_show("pjbu_t","pjbq_t","pjbd_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[g_detail_idx2].pjbq003,g_pjbn_m.pjbn900)               
               
            BEFORE DISPLAY
               LET g_current_page = 1
               CALL apjm300_idx_chk()
               CALL DIALOG.setCellAttributes(g_pjbq_d_color)


         END DISPLAY

         DISPLAY ARRAY g_pjbq2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL apjm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               CALL s_apjm300_hint_show("pjbu_t","pjbr_t","pjbe_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[g_detail_idx2].pjbr003,g_pjbn_m.pjbn900)                
            BEFORE DISPLAY
               LET g_current_page = 2
               CALL apjm300_idx_chk()
               CALL DIALOG.setCellAttributes(g_pjbq2_d_color)


         END DISPLAY

         DISPLAY ARRAY g_pjbq3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL apjm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               CALL s_apjm300_hint_show("pjbu_t","pjbs_t","pjbf_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[g_detail_idx2].pjbs003,g_pjbn_m.pjbn900) 
            BEFORE DISPLAY
               LET g_current_page = 3
               CALL apjm300_idx_chk()
               CALL DIALOG.setCellAttributes(g_pjbq3_d_color)


         END DISPLAY

         DISPLAY ARRAY g_pjbq4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL apjm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx2 = l_ac
               CALL s_apjm300_hint_show("pjbu_t","pjbt_t","pjbg_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[g_detail_idx2].pjbt003,g_pjbn_m.pjbn900) 
            BEFORE DISPLAY
               LET g_current_page = 4
               CALL apjm300_idx_chk()
               CALL DIALOG.setCellAttributes(g_pjbq4_d_color)


         END DISPLAY

         DISPLAY ARRAY g_pjbq5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL apjm300_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               CALL s_apjm300_hint_show("pjbu_t","pjbp_t","pjbc_t",g_pjbn_m.pjbn001,g_pjbq5_d[g_detail_idx].pjbp002,g_pjbq5_d[g_detail_idx].pjbp003,g_pjbn_m.pjbn900) 
            BEFORE DISPLAY
               LET g_current_page = 5
               CALL apjm300_idx_chk()
               CALL DIALOG.setCellAttributes(g_pjbq5_d_color) 


         END DISPLAY
         #add by lixh  
#         DISPLAY ARRAY g_tree TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
#            BEFORE ROW
#               EXIT DISPLAY  
#         END DISPLAY

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_master_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_master_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
#            IF g_current_master_row > 1 AND g_current_master_idx = 1 AND g_current_master_sw = FALSE THEN
#               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
#               LET g_current_idx = g_current_row
#            END IF
            LET g_current_master_row = g_current_master_idx #目前指標
            IF g_current_master_idx = 0 THEN
               LET g_current_master_idx = 1
            END IF
            LET g_current_master_sw = TRUE

#            IF g_current_idx > g_tree.getLength() THEN
#               LET g_current_idx = g_tree.getLength()
#            END IF
             LET g_tree_idx = 1

            #有資料才進行fetch
            IF g_current_master_idx <> 0 THEN
               CALL apjm300_fetch('') # reload data
            END IF
            IF g_copy_flag = 'Y' THEN
               LET g_copy_pjbn001 = ''
               LET g_copy_flag = 'N'
            END IF
            #LET g_detail_idx = 1
            CALL apjm300_ui_detailshow() #Setting the current row

            #筆數顯示
            LET g_current_page = 1
            CALL apjm300_idx_chk()
            
            CALL cl_set_act_visible("reproduce,output",FALSE) 
            #NEXT FIELD pjbq003

         #add-point:ui_dialog段define
         {<point name="ui_dialog.more_displayarray"/>}
         #end add-point

         #Browser用Action

         #一般搜尋
         ON ACTION searchdata
            #取得搜尋關鍵字
            INITIALIZE g_wc_tree TO NULL
            INITIALIZE g_wc_table1 TO NULL
            INITIALIZE g_wc_table2 TO NULL

            INITIALIZE g_wc_table3 TO NULL

            INITIALIZE g_wc_table4 TO NULL

            INITIALIZE g_wc_table5 TO NULL


            LET g_searchstr = GET_FLDBUF(searchstr)
            IF NOT apjm300_tree_search("normal") THEN
               CONTINUE DIALOG
            END IF
            LET g_tree_idx = 1
            IF g_browser.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

            END IF
            LET g_action_choice = "searchdata"
            EXIT DIALOG

         #進階搜尋
         ON ACTION advancesearch


         #ACTION表單列
         ON ACTION first
            CALL apjm300_fetch('F')
            LET g_current_master_row = g_current_master_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm300_idx_chk()

         ON ACTION previous
            CALL apjm300_fetch('P')
            LET g_current_master_row = g_current_master_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm300_idx_chk()

         ON ACTION jump
            CALL apjm300_fetch('/')
            LET g_current_master_row = g_current_master_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm300_idx_chk()

         ON ACTION next
            CALL apjm300_fetch('N')
            LET g_current_master_row = g_current_master_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm300_idx_chk()

         ON ACTION last
            CALL apjm300_fetch('L')
            LET g_current_master_row = g_current_master_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apjm300_idx_chk()

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-r.png")
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementImage("mainhidden","small/arr-l.png")
               LET g_main_hidden = 1
            END IF

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_worksheet_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet",0)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-l.png")
               LET g_worksheet_hidden = 0
               NEXT FIELD b_pjbo001
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet",1)
               CALL gfrm_curr.setElementImage("worksheethidden","small/arr-r.png")
               LET g_worksheet_hidden = 1
            END IF

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF



         ON ACTION delete

            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apjm300_delete()
               #add-point:ON ACTION delete
               {<point name="menu.delete" />}
               #END add-point
            END IF
            
         ON ACTION insert_detail
            LET g_action_choice="insert_detail"
            CALL apjm300_insert('N')
            CALL apjm300_head_color()  #add by lixh 
            EXIT DIALOG
    
        ON ACTION modify_detail

            LET g_action_choice="modify_detail"
            CALL apjm300_modify('N')
            EXIT DIALOG

         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               CALL apjm300_modify('Y')
               #add-point:ON ACTION modify
               {<point name="menu.modify" />}
               #END add-point
                EXIT DIALOG
            END IF

         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN

               CALL apjm300_insert('Y')
#               IF g_copy_flag = 'Y' THEN
#                  LET g_browser[g_current_master_idx].b_pjbn001 = g_pjbn_m.pjbn001
#                  LET g_browser[g_current_master_idx].b_pjbn900 = g_pjbn_m.pjbn900
#                  CALL apjm300_fetch('')
#                  DISPLAY ARRAY g_tree TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
#                     BEFORE ROW
#                        EXIT DISPLAY
#                  END DISPLAY
#                  CALL apjm300_modify('N')
#                  LET g_action_choice = "modify"
#
#               END IF
#               CALL apjm300_head_color()
#               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
            EXIT DIALOG #mark by lixh 20150727
            
         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               {<point name="menu.output" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apjm300_query()
               #add-point:ON ACTION query
               {<point name="menu.query" />}
               #END add-point
            END IF


         ON ACTION reproduce

            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apjm300_reproduce()
               #add-point:ON ACTION reproduce
               {<point name="menu.reproduce" />}
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION statechange

            LET g_action_choice="statechange"

            CALL apjm300_statechange()
            CALL apjm300_set_act_visible()
            CALL apjm300_set_act_no_visible()
            IF NOT (g_pjbn_m.pjbn001 IS NULL   #add by lixh 
              OR g_pjbn_m.pjbn900 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pjbnent = '" ||g_enterprise|| "' AND",
                                  " pjbn001 = '", g_pjbn_m.pjbn001, "' "
                                  ," AND pjbn900 = '", g_pjbn_m.pjbn900, "' "
 
               #填到對應位置
               CALL apjm300_browser_fill()
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF            
            #EXIT DIALOG
    

#         ON ACTION upd_1
#
#            LET g_action_choice="upd_1"
#            IF cl_auth_chk_act("upd_1") THEN
#               CALL s_transaction_begin()
#          #     CALL s_apjm300_upd_status_1(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
#            
#         ON ACTION upd_un1
#
#            LET g_action_choice="upd_un1"
#            IF cl_auth_chk_act("upd_un1") THEN
#               CALL s_transaction_begin()
#            #   CALL s_apjm300_upd_status_0(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
#            
#         ON ACTION upd_2
#
#            LET g_action_choice="upd_2"
#            IF cl_auth_chk_act("upd_2") THEN
#               CALL s_transaction_begin()
#            #   CALL s_apjm300_upd_status_2(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
#            
#         ON ACTION upd_un2
#
#            LET g_action_choice="upd_un2"
#            IF cl_auth_chk_act("upd_un2") THEN
#               CALL s_transaction_begin()
#           #    CALL s_apjm300_upd_status_1(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
#            
#         ON ACTION upd_un9
#
#            LET g_action_choice="upd_un9"
#            IF cl_auth_chk_act("upd_un9") THEN
#               CALL s_transaction_begin()
#            #   CALL s_apjm300_upd_status_0(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
#            
#         ON ACTION upd_9
#
#            LET g_action_choice="upd_9"
#            IF cl_auth_chk_act("upd_9") THEN
#               CALL s_transaction_begin()
#           #    CALL s_apjm300_upd_status_9(g_pjbn_m.pjbn001,g_pjbn_m.pjbnstus,g_pjbo_m.pjbo002,g_pjbo_m.pjbo012) RETURNING g_success,g_errno
#               IF NOT g_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','1')
#               ELSE
#                  CALL s_transaction_end('Y','1')
#               END IF
#               EXIT DIALOG
#            END IF
         

         #主選單用ACTION
         &include "main_menu.4gl"

         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG

      END DIALOG

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION apjm300_browser_fill()
  {<Local define>}
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   {</Local define>}
   #add-point:browser_fill段define

   #end add-point    
   
   #add-point:browser_fill段動作開始前

   #end add-point    
#   CLEAR FORM
#   INITIALIZE g_pjbn_m.* LIKE pjbn_t.* 
#   CALL g_browser.clear()
#   CALL g_pjbq_d.clear()        
#   CALL g_pjbq2_d.clear() 
#
#   CALL g_pjbq3_d.clear() 
#
#   CALL g_pjbq4_d.clear() 
#
#   CALL g_pjbq5_d.clear() 
#   CALL g_tree.clear()
   DISPLAY BY NAME g_pjbn_m.*
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = " pjbn001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   IF g_wc2 <> " 1=1" OR NOT cl_null(g_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE pjbn001,pjbn900 FROM pjbn_t LEFT JOIN pjbp_t ON pjbpent = pjbnent AND pjbp001 = pjbn001 AND pjbp900 = pjbn900",
                      "                                   LEFT JOIN pjbo_t ON pjboent = pjbnent AND pjbo001 = pjbn001 AND pjbo900 = pjbn900",
                      "                                   LEFT JOIN pjbq_t ON pjbqent = pjboent AND pjbq001 = pjbo001 AND pjbq002 = pjbo002 AND pjbq900 = pjbo900 ",
                      "                                   LEFT JOIN pjbr_t ON pjbrent = pjboent AND pjbr001 = pjbo001 AND pjbr002 = pjbo002 AND pjbr900 = pjbo900 ",
                      "                                   LEFT JOIN pjbs_t ON pjbsent = pjboent AND pjbs001 = pjbo001 AND pjbs002 = pjbo002 AND pjbs900 = pjbo900 ",
                      "                                   LEFT JOIN pjbt_t ON pjbtent = pjboent AND pjbt001 = pjbo001 AND pjbt002 = pjbo002 AND pjbt900 = pjbo900 ",
                      " WHERE pjbnent = '" ||g_enterprise|| "' AND pjbn000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaaent = ",g_enterprise,
                      "                                                           AND pjaa006 = '3') AND ",l_wc," AND ", l_wc2 CLIPPED,cl_sql_add_filter("pjbn_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("pjbn_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE pjbn001,pjbn900  FROM pjbn_t ",
                      " WHERE pjbnent = '" ||g_enterprise|| "' AND pjbn000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaaent = ",g_enterprise,
                      "                                                           AND pjaa006 = '3') AND ",l_wc CLIPPED,cl_sql_add_filter("pjbn_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("pjbn_t")
 
   END IF 
   
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   LET g_sql = g_sql," AND pjbn015 = 'apjm300' "
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   #該樣板不需此段落IF g_browser_cnt > g_max_browse AND g_error_show = 1THEN
   #該樣板不需此段落   CALL cl_err(g_browser_cnt,'9035',1)
   #該樣板不需此段落END IF
   LET g_error_show = 0
 
   DISPLAY g_browser_cnt TO FORMONLY.cnt   #總筆數的顯示

   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_pjbn_m.* TO NULL
      CALL g_browser.clear()
      CALL g_pjbq_d.clear()        
      CALL g_pjbq2_d.clear() 
    
      CALL g_pjbq3_d.clear() 
    
      CALL g_pjbq4_d.clear() 
    
      CALL g_pjbq5_d.clear() 
      CALL g_tree.clear()
      DISPLAY BY NAME g_pjbn_m.*   
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_master_idx
   END IF
   
   #單身有輸入查詢條件且非null
   IF l_wc2 <> " 1=1" AND NOT cl_null(l_wc2) THEN 
 
      #依照xrah001,xrah002,xrah003 Browser欄位定義(取代原本bs_sql功能)
      LET l_sub_sql = " SELECT UNIQUE pjbn001,pjbn900 FROM pjbn_t LEFT JOIN pjbp_t ON pjbpent = pjbnent AND pjbp001 = pjbn001 AND pjbp900 = pjbn900 ",
                      "                                   LEFT JOIN pjbo_t ON pjboent = pjbnent AND pjbo001 = pjbn001 AND pjbo900 = pjbn900",
                      "                                   LEFT JOIN pjbq_t ON pjbqent = pjboent AND pjbq001 = pjbo001 AND pjbq002 = pjbo002 AND pjbq900 = pjbo900",
                      "                                   LEFT JOIN pjbr_t ON pjbrent = pjboent AND pjbr001 = pjbo001 AND pjbr002 = pjbo002 AND pjbr900 = pjbo900",
                      "                                   LEFT JOIN pjbs_t ON pjbsent = pjboent AND pjbs001 = pjbo001 AND pjbs002 = pjbo002 AND pjbs900 = pjbo900",
                      "                                   LEFT JOIN pjbt_t ON pjbtent = pjboent AND pjbt001 = pjbo001 AND pjbt002 = pjbo002 AND pjbt900 = pjbo900",
                      " WHERE pjbnent = '" ||g_enterprise|| "' AND pjbn000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaaent = ",g_enterprise,
                      "                                                           AND pjaa006 = '3') AND ",l_wc," AND ", l_wc2 CLIPPED,cl_sql_add_filter("pjbn_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("pjbn_t")
 
   ELSE
      #單身無輸入資料
      LET l_sub_sql = " SELECT UNIQUE pjbn001,pjbn900  FROM pjbn_t ",
                      " WHERE pjbnent = '" ||g_enterprise|| "' AND pjbn000 IN (SELECT pjaa001 FROM pjaa_t WHERE pjaaent = ",g_enterprise,
                      "                                                           AND pjaa006 = '3') AND ",l_wc CLIPPED,cl_sql_add_filter("pjbn_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("pjbn_t")
                 
   END IF
   LET l_sub_sql = l_sub_sql," AND pjbn015 = 'apjm300' "  #add by lixh 20151009
   LET l_sql_rank = "SELECT pjbn001,pjbn900,DENSE_RANK() OVER(ORDER BY pjbn001 ",g_order,") AS RANK ",
                    " FROM (",l_sub_sql,") "
                       
   #定義翻頁CURSOR
   LET g_sql= " SELECT pjbn001,pjbn900 FROM (",l_sql_rank,") WHERE RANK>=",g_pagestart,
              " AND RANK<",g_pagestart+g_max_browse,
              " ORDER BY pjbn001,pjbn900 "
                
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
#   CALL g_browser.clear()   mark by lixh 20150727
#   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_pjbn001,g_browser[g_cnt].b_pjbn900 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
                 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      #CALL g_curr_diag.setCurrentRow("s_browse",g_current_master_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_pjbn001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength() 
   
   #CALL g_browser.deleteElement(g_cnt)
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_pjbn_m.* TO NULL
      INITIALIZE g_pjbo_m.* TO NULL
      CALL g_pjbq_d.clear()        
      CALL g_pjbq2_d.clear() 
    
      CALL g_pjbq3_d.clear() 
    
      CALL g_pjbq4_d.clear() 
    
      CALL g_pjbq5_d.clear() 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()  #add by lixh -1
   LET g_rec_b = g_header_cnt
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   DISPLAY g_header_cnt TO FORMONLY.cnt           #總筆數的顯示
   DISPLAY g_current_master_idx TO FORMONLY.idx   #單身當下筆數
   #該樣板不需此段落CALL aiti807_fetch('')
   
   CALL apjm300_head_color() #add by lixh 20150728
   FREE browse_pre 

END FUNCTION
################################################################################
#填充树
################################################################################
PRIVATE FUNCTION apjm300_tree_fill()
   {<Local define>}
   DEFINE p_type   LIKE type_t.chr50
   DEFINE l_pid    LIKE type_t.chr50
   DEFINE l_cnt    LIKE type_t.num5
   {</Local define>}
   #add-point:tree_create
   {<point name="tree_create.define"/>}
   #end add-point
   
   CALL g_tree.clear()

      #抓出LV2的所有資料
      LET g_sql = " SELECT UNIQUE pjbo001,pjbo002,pjbol004,pjbo003,pjbo004,oocql004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012 ",
                  " FROM pjbo_t a LEFT OUTER JOIN pjbol_t ON a.pjboent = pjbolent AND a.pjbo001 = pjbol001 AND a.pjbo002 = pjbol002 AND a.pjbo900 = pjbol900 AND pjbol003 = '",g_dlang,"'",
                  "               LEFT OUTER JOIN oocql_t ON a.pjboent = pjbolent AND a.pjbo004 = oocql002 AND oocql001 = '8001' AND oocql003 = '",g_dlang,"'",
                  " WHERE ",
                  " pjbo001 = ? AND pjbo900 = ? AND pjboent = ?",
                  " AND ",
                  " (( SELECT COUNT(*) FROM pjbo_t b WHERE a.pjbo003 = b.pjbo002 ", 
                  " AND a.pjbo001 = b.pjbo001 AND a.pjbo900 = b.pjbo900 ",
                  ") = 0 OR ", 
                  " a.pjbo002 = a.pjbo003 )", 
                  " ORDER BY pjbo002"
      PREPARE master_getLV2 FROM g_sql
      DECLARE master_getLV2cur CURSOR FOR master_getLV2

      #以下為一般資料root(LV-2)
      #OPEN master_getLV2cur USING g_tree[l_ac-1].b_pjbo001
      OPEN master_getLV2cur USING g_pjbn_m.pjbn001,g_pjbn_m.pjbn900,g_enterprise
      LET g_cnt = 1 
     #LET g_cnt = l_ac

      FOREACH master_getLV2cur INTO g_tree[g_cnt].b_pjbo001,g_tree[g_cnt].b_pjbo002,g_tree[g_cnt].b_pjbo002_desc,g_tree[g_cnt].b_pjbo003,g_tree[g_cnt].b_pjbo004,g_tree[g_cnt].b_pjbo004_desc,g_tree[g_cnt].b_pjbo005,g_tree[g_cnt].b_pjbo006,g_tree[g_cnt].b_pjbo007,g_tree[g_cnt].b_pjbo008,g_tree[g_cnt].b_pjbo009,g_tree[g_cnt].b_pjbo010,g_tree[g_cnt].b_pjbo011,g_tree[g_cnt].b_pjbo012
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         #去除多餘空白      
         LET g_tree[g_cnt].b_pid = '0'
         LET g_tree[g_cnt].b_id = g_cnt USING "<<<"

         LET g_tree[g_cnt].b_exp = FALSE
         LET g_tree[g_cnt].b_expcode = 2
         CALL apjm300_desc_show(g_cnt)
         IF cl_null("pjbo003") THEN
            LET g_tree[g_cnt].b_hasC = FALSE
         ELSE
            LET g_tree[g_cnt].b_hasC = TRUE
         END IF
         CALL s_desc_get_person_desc(g_tree[g_cnt].b_pjbo010) RETURNING g_tree[g_cnt].b_pjbo010_desc
         CALL s_desc_get_department_desc(g_tree[g_cnt].b_pjbo011) RETURNING g_tree[g_cnt].b_pjbo011_desc
         LET g_cnt = g_cnt + 1

         IF g_cnt > g_max_rec AND g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH

   LET g_error_show = 0

    CALL g_tree.deleteElement(g_tree.getLength())
    LET l_cnt = g_tree.getLength()
    DISPLAY l_cnt TO FORMONLY.b_count

   FREE master_getLV2
   
   CALL apjm300_fetch2()
END FUNCTION

PRIVATE FUNCTION apjm300_desc_show(pi_ac)
   {<Local define>}
   DEFINE pi_ac   LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE li_tmp  LIKE type_t.num10  #161108-00012#3 num5==》num10
   {</Local define>}
   #add-point:desc_show段define
   {<point name="desc_show.define"/>}
   #end add-point

   LET li_tmp = l_ac
   LET l_ac = pi_ac


   #add-point:browser_create段desc處理
  LET g_tree[l_ac].b_show =  g_tree[l_ac].b_pjbo002


   LET l_ac = li_tmp

END FUNCTION

PRIVATE FUNCTION apjm300_find_node(pi_ac)
   {<Local define>}
   DEFINE pi_ac   LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE li_tmp  LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE ls_pid  STRING
   {</Local define>}
   #add-point:find_node段define
   {<point name="find_node.define"/>}
   #end add-point

   LET ls_pid = g_tree[pi_ac].b_pid

   LET g_sql = " SELECT UNIQUE '','','','FALSE','','',exp_code,pjbo001,pjbo002,pjbol004,pjbo003,pjbo004,oocql004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012 ",
               " FROM apjm300_tmp ",
               " WHERE pjbo003 = ? AND pjbo003 <> pjbo002",
               " ORDER BY pjbo002"
   PREPARE master_getNode FROM g_sql
   DECLARE master_getNodecur CURSOR FOR master_getNode

   LET li_idx = pi_ac
   WHILE li_idx <= g_tree.getLength()
      IF g_tree[li_idx].b_expcode = -1 THEN
         OPEN master_getNodecur USING g_tree[li_idx].b_pjbo002
         FOREACH master_getNodecur INTO g_tree[g_tree.getLength()+1].*
            CALL apjm300_desc_show(g_tree.getLength())
            LET g_tree[g_tree.getLength()].b_pid = ls_pid
            LET g_tree[g_tree.getLength()].b_id = g_tree.getLength()
            LET g_tree[g_tree.getLength()].b_hasC = apjm300_chk_hasC(g_tree.getLength())
         END FOREACH
         CALL g_tree.deleteElement(li_idx)
         CALL g_tree.deleteElement(g_tree.getLength())
      ELSE
         LET li_idx = li_idx + 1
      END IF

   END WHILE

   FREE master_getNode

   RETURN g_tree.getLength()

END FUNCTION

PRIVATE FUNCTION apjm300_chk_hasC(pi_id)
   {<Local define>}
   DEFINE pi_id    INTEGER
   DEFINE li_cnt   INTEGER
   {</Local define>}
   #add-point:chk_hasC段define
   {<point name="chk_hasC.define"/>}
   #end add-point

#   LET g_sql = "SELECT COUNT(pjbo003) FROM pjbo_t ",
#               " WHERE ",
#                "pjbo003 = ? AND ",
#                "exp_code <> '-1' AND pjbo002 <> pjbo003 "
#                 ," AND ",
#                "pjbo001 = ?"
#
#   PREPARE apjm300_temp_chk FROM g_sql
#
#   LET g_sql = "SELECT COUNT(*) FROM pjbo_t ",
#               " WHERE pjboent = '" ||g_enterprise|| "' AND ",
#               "pjbo002 <> pjbo003 AND ",
#               "pjbo003 = ? "
#                ," AND ",
#               "pjbo001 = ?"
#
#   PREPARE apjm300_master_chk FROM g_sql
#
#   CASE g_tree[pi_id].b_expcode
#      WHEN -1
#         RETURN FALSE
#      WHEN 0
#         RETURN FALSE
#      WHEN 1
#         EXECUTE apjm300_temp_chk
#           USING g_tree[pi_id].b_pjbo002
#                 ,g_tree[pi_id].b_pjbo001
#            INTO li_cnt
#         FREE apjm300_temp_chk
#      WHEN 2
#         EXECUTE apjm300_master_chk
#           USING g_tree[pi_id].b_pjbo002
#                 ,g_tree[pi_id].b_pjbo001
#            INTO li_cnt
#         FREE apjm300_master_chk
#   END CASE
#
#   IF li_cnt > 0 THEN
#      RETURN TRUE
#   ELSE
#      RETURN FALSE
#   END IF
#   
   
   LET g_sql = "SELECT COUNT(*) FROM pjbo_t ",
               " WHERE pjboent = '" ||g_enterprise|| "'",
               "   AND pjbo001 = '",g_tree[pi_id].b_pjbo001,"'",
               "   AND pjbo900 = '",g_pjbn_m.pjbn900,"' ",
               "   AND pjbo002 <> pjbo003 ",
               "   AND pjbo003 = ? "
   PREPARE apjm300_master_chk1 FROM g_sql
   EXECUTE apjm300_master_chk1 USING g_tree[pi_id].b_pjbo002 INTO li_cnt
   FREE apjm300_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
 
END FUNCTION

PRIVATE FUNCTION apjm300_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10


   FOR l_i = 1 TO g_browser.getLength()
      IF g_browser[l_i].b_pjbn001 = g_pjbn_m.pjbn001 AND g_browser[l_i].b_pjbn900 = g_pjbn_m.pjbn900 THEN         
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR

   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_master_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_master_row = g_browser_cnt
   END IF

   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION apjm300_ui_detailshow()
   #add-point:ui_detailshow段define
   {<point name="ui_detailshow.define"/>}
   #end add-point

   #add-point:ui_detailshow段before
   {<point name="ui_detailshow.before"/>}
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)


   END IF

   #add-point:ui_detailshow段after
   {<point name="ui_detailshow.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION apjm300_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   {<point name="cs.define"/>}
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_pjbn_m.* TO NULL
   INITIALIZE g_pjbo_m.* TO NULL
   CALL g_pjbq_d.clear()
   CALL g_pjbq2_d.clear()

   CALL g_pjbq3_d.clear()

   CALL g_pjbq4_d.clear()

   CALL g_pjbq5_d.clear()



   LET g_current_master_idx = 1
   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc_table1 TO NULL
   INITIALIZE g_wc_table2 TO NULL

   INITIALIZE g_wc_table3 TO NULL

   INITIALIZE g_wc_table4 TO NULL

   INITIALIZE g_wc_table5 TO NULL



   LET g_qryparam.state = 'c'

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT BY NAME g_wc ON pjbn000,pjbn001,pjbn002,pjbnl003,pjbnl004,pjbn009,pjbn900,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbn010,pjbn011,pjbn012,pjbn013,pjbn014,pjbnstus,
                                pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt
          BEFORE CONSTRUCT
             CALL cl_qbe_init()     
          
          ON ACTION controlp INFIELD pjbnownid
            #add-point:ON ACTION controlp INFIELD pjbnownid
            #此段落由子樣板a08產生
            #開窗c段
	   		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbnownid  #顯示到畫面上

            NEXT FIELD pjbnownid   

          ON ACTION controlp INFIELD pjbnowndp
            #add-point:ON ACTION controlp INFIELD pjbnowndp
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbnowndp  #顯示到畫面上

            NEXT FIELD pjbnowndp  
          ON ACTION controlp INFIELD pjbncrtid
            #add-point:ON ACTION controlp INFIELD pjbncrtid
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbncrtid  #顯示到畫面上

            NEXT FIELD pjbncrtid 
          ON ACTION controlp INFIELD pjbncrtdp
            #add-point:ON ACTION controlp INFIELD pjbncrtdp
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbncrtdp  #顯示到畫面上

            NEXT FIELD pjbncrtdp 
          ON ACTION controlp INFIELD pjbnmodid
            #add-point:ON ACTION controlp INFIELD pjbnmodid
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbnmodid  #顯示到畫面上

            NEXT FIELD pjbnmodid 
          ON ACTION controlp INFIELD pjbncnfid
            #add-point:ON ACTION controlp INFIELD pjbncnfid
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbncnfid  #顯示到畫面上

            NEXT FIELD pjbncnfid 
          ON ACTION controlp INFIELD pjbn000
            #add-point:ON ACTION controlp INFIELD pjbn000
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_pjaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn000  #顯示到畫面上

            NEXT FIELD pjbn000
         ON ACTION controlp INFIELD pjbn001
            #add-point:ON ACTION controlp INFIELD pjbn001
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn001 #顯示到畫面上
            NEXT FIELD pjbn001
            
         ON ACTION controlp INFIELD pjbn003
            #add-point:ON ACTION controlp INFIELD pjbn003
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn003 #顯示到畫面上
            NEXT FIELD pjbn003
            
         ON ACTION controlp INFIELD pjbn004
            #add-point:ON ACTION controlp INFIELD pjbn003
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
		    	LET g_qryparam.arg1 = 'ALL'
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn004 #顯示到畫面上
            NEXT FIELD pjbn004
         ON ACTION controlp INFIELD pjbn008
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '4' 
            CALL q_ooal002_0()
            DISPLAY g_qryparam.return1 TO pjbn008 #顯示到畫面上
            NEXT FIELD pjbn008

         ON ACTION controlp INFIELD pjbn012
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn012  #顯示到畫面上

            NEXT FIELD pjbn012
            
         ON ACTION controlp INFIELD pjbn010
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = '8006'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn010  #顯示到畫面上

            NEXT FIELD pjbn010
            
         ON ACTION controlp INFIELD pjbn014
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = '8007'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbn014  #顯示到畫面上

            NEXT FIELD pjbn014            
            
      END CONSTRUCT
      
      #單頭
      CONSTRUCT BY NAME g_wc2 ON pjbo002,pjbol004,pjbol005,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段more_construct
            {<point name="cs.head.before_construct"/>}


         ON ACTION controlp INFIELD pjbo002
            #add-point:ON ACTION controlp INFIELD pjbo002
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo002  #顯示到畫面上

            NEXT FIELD pjbo002                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbo002
            #add-point:BEFORE FIELD pjbo002
            {<point name="construct.b.pjbo002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo002

            #add-point:AFTER FIELD pjbo002
            {<point name="construct.a.pjbo002" />}
            #END add-point


         #----<<pjbol004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbol004
            #add-point:BEFORE FIELD pjbol004
            {<point name="construct.b.pjbol004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbol004

            #add-point:AFTER FIELD pjbol004
            {<point name="construct.a.pjbol004" />}
            #END add-point


         #Ctrlp:construct.c.pjbol004
#         ON ACTION controlp INFIELD pjbol004
            #add-point:ON ACTION controlp INFIELD pjbol004
            {<point name="construct.c.pjbol004" />}
            #END add-point

         #----<<pjbol005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbol005
            #add-point:BEFORE FIELD pjbol005
            {<point name="construct.b.pjbol005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbol005

            #add-point:AFTER FIELD pjbol005
            {<point name="construct.a.pjbol005" />}
            #END add-point


         #Ctrlp:construct.c.pjbol005
         ON ACTION controlp INFIELD pjbo003
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo003  #顯示到畫面上

            NEXT FIELD pjbo003                     #返回原欄位

         #----<<pjbo004>>----
         #Ctrlp:construct.c.pjbo004
         ON ACTION controlp INFIELD pjbo004
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a08產生
            #開窗c段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = '8001'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo004  #顯示到畫面上

            NEXT FIELD pjbo004                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbo004
            #add-point:BEFORE FIELD pjbo004
            {<point name="construct.b.pjbo004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo004

            #add-point:AFTER FIELD pjbo004
            {<point name="construct.a.pjbo004" />}
            #END add-point


         #----<<pjbo003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo003
            #add-point:BEFORE FIELD pjbo003
            {<point name="construct.b.pjbo003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo003

            #add-point:AFTER FIELD pjbo003
            {<point name="construct.a.pjbo003" />}
            #END add-point


         #Ctrlp:construct.c.pjbo003
#         ON ACTION controlp INFIELD pjbo003
            #add-point:ON ACTION controlp INFIELD pjbo003
            {<point name="construct.c.pjbo003" />}
            #END add-point

         #----<<pjbo005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo005
            #add-point:BEFORE FIELD pjbo005
            {<point name="construct.b.pjbo005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo005

            #add-point:AFTER FIELD pjbo005
            {<point name="construct.a.pjbo005" />}
            #END add-point


         #Ctrlp:construct.c.pjbo005
#         ON ACTION controlp INFIELD pjbo005
            #add-point:ON ACTION controlp INFIELD pjbo005
            {<point name="construct.c.pjbo005" />}
            #END add-point

         #----<<pjbo006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo006
            #add-point:BEFORE FIELD pjbo006
            {<point name="construct.b.pjbo006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo006

            #add-point:AFTER FIELD pjbo006
            {<point name="construct.a.pjbo006" />}
            #END add-point


         #Ctrlp:construct.c.pjbo006
#         ON ACTION controlp INFIELD pjbo006
            #add-point:ON ACTION controlp INFIELD pjbo006
            {<point name="construct.c.pjbo006" />}
            #END add-point

         #----<<pjbo007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo007
            #add-point:BEFORE FIELD pjbo007
            {<point name="construct.b.pjbo007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo007

            #add-point:AFTER FIELD pjbo007
            {<point name="construct.a.pjbo007" />}
            #END add-point


         #Ctrlp:construct.c.pjbo007
#         ON ACTION controlp INFIELD pjbo007
            #add-point:ON ACTION controlp INFIELD pjbo007
            {<point name="construct.c.pjbo007" />}
            #END add-point

         #----<<pjbo008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo008
            #add-point:BEFORE FIELD pjbo008
            {<point name="construct.b.pjbo008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo008

            #add-point:AFTER FIELD pjbo008
            {<point name="construct.a.pjbo008" />}
            #END add-point


         #Ctrlp:construct.c.pjbo008
#         ON ACTION controlp INFIELD pjbo008
            #add-point:ON ACTION controlp INFIELD pjbo008
            {<point name="construct.c.pjbo008" />}
            #END add-point

         #----<<pjbo009>>----
         #Ctrlp:construct.c.pjbo009
         ON ACTION controlp INFIELD pjbo009
            #add-point:ON ACTION controlp INFIELD pjbo009
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo009  #顯示到畫面上

            NEXT FIELD pjbo009                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbo009
            #add-point:BEFORE FIELD pjbo009
            {<point name="construct.b.pjbo009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo009

            #add-point:AFTER FIELD pjbo009
            {<point name="construct.a.pjbo009" />}
            #END add-point


         #----<<pjbo010>>----
         #Ctrlp:construct.c.pjbo010
         ON ACTION controlp INFIELD pjbo010
            #add-point:ON ACTION controlp INFIELD pjbo010
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo010  #顯示到畫面上

            NEXT FIELD pjbo010                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbo010
            #add-point:BEFORE FIELD pjbo010
            {<point name="construct.b.pjbo010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo010

            #add-point:AFTER FIELD pjbo010
            {<point name="construct.a.pjbo010" />}
            #END add-point


         ON ACTION controlp INFIELD pjbo011
            #add-point:ON ACTION controlp INFIELD pjbo010
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbo011  #顯示到畫面上

            NEXT FIELD pjbo011 
            
         #----<<pjbo011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo011
            #add-point:BEFORE FIELD pjbo011
            {<point name="construct.b.pjbo011" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo011

            #add-point:AFTER FIELD pjbo011
            {<point name="construct.a.pjbo011" />}
            #END add-point


         #Ctrlp:construct.c.pjbo011
#         ON ACTION controlp INFIELD pjbo011
            #add-point:ON ACTION controlp INFIELD pjbo011
            {<point name="construct.c.pjbo011" />}
            #END add-point

         #----<<pjbo012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo012
            #add-point:BEFORE FIELD pjbo012
            {<point name="construct.b.pjbo012" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo012

            #add-point:AFTER FIELD pjbo012
            {<point name="construct.a.pjbo012" />}
            #END add-point


         #Ctrlp:construct.c.pjbo012
#         ON ACTION controlp INFIELD pjbo012
            #add-point:ON ACTION controlp INFIELD pjbo012
            {<point name="construct.c.pjbo012" />}
            #END add-point

         #----<<pjbo001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo001
            #add-point:BEFORE FIELD pjbo001
            {<point name="construct.b.pjbo001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo001

            #add-point:AFTER FIELD pjbo001
            {<point name="construct.a.pjbo001" />}
            #END add-point


         #Ctrlp:construct.c.pjbo001
#         ON ACTION controlp INFIELD pjbo001
            #add-point:ON ACTION controlp INFIELD pjbo001
            {<point name="construct.c.pjbo001" />}
            #END add-point



      END CONSTRUCT

      #單身根據table分拆construct
      CONSTRUCT g_wc_table1 ON pjbq003,pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010
           FROM s_detail1[1].pjbq003,s_detail1[1].pjbq004,s_detail1[1].pjbq005,s_detail1[1].pjbq006,s_detail1[1].pjbq007,s_detail1[1].pjbq008,s_detail1[1].pjbq009,s_detail1[1].pjbq010

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<pjbq003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq003
            #add-point:BEFORE FIELD pjbq003
            {<point name="construct.b.page1.pjbq003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq003

            #add-point:AFTER FIELD pjbq003
            {<point name="construct.a.page1.pjbq003" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq003
#         ON ACTION controlp INFIELD pjbq003
            #add-point:ON ACTION controlp INFIELD pjbq003
            {<point name="construct.c.page1.pjbq003" />}
            #END add-point

         #----<<pjbq004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq004
            #add-point:BEFORE FIELD pjbq004
            {<point name="construct.b.page1.pjbq004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq004

            #add-point:AFTER FIELD pjbq004
            {<point name="construct.a.page1.pjbq004" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq004
         ON ACTION controlp INFIELD pjbq004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		    	LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbq004  #顯示到畫面上

            NEXT FIELD pjbq004

         #----<<pjbq005>>----
         #Ctrlp:construct.c.page1.pjbq005
         ON ACTION controlp INFIELD pjbq005
            #add-point:ON ACTION controlp INFIELD pjbq005
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbq005  #顯示到畫面上

            NEXT FIELD pjbq005                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbq005
            #add-point:BEFORE FIELD pjbq005
            {<point name="construct.b.page1.pjbq005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq005

            #add-point:AFTER FIELD pjbq005
            {<point name="construct.a.page1.pjbq005" />}
            #END add-point


         #----<<pjbq006>>----
         #Ctrlp:construct.c.page1.pjbq006
         ON ACTION controlp INFIELD pjbq006
            #add-point:ON ACTION controlp INFIELD pjbq006
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbq006  #顯示到畫面上

            NEXT FIELD pjbq006                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbq006
            #add-point:BEFORE FIELD pjbq006
            {<point name="construct.b.page1.pjbq006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq006

            #add-point:AFTER FIELD pjbq006
            {<point name="construct.a.page1.pjbq006" />}
            #END add-point


         #----<<pjbq007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq007
            #add-point:BEFORE FIELD pjbq007
            {<point name="construct.b.page1.pjbq007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq007

            #add-point:AFTER FIELD pjbq007
            {<point name="construct.a.page1.pjbq007" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq007
#         ON ACTION controlp INFIELD pjbq007
            #add-point:ON ACTION controlp INFIELD pjbq007
            {<point name="construct.c.page1.pjbq007" />}
            #END add-point

         #----<<pjbq008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq008
            #add-point:BEFORE FIELD pjbq008
            {<point name="construct.b.page1.pjbq008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq008

            #add-point:AFTER FIELD pjbq008
            {<point name="construct.a.page1.pjbq008" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq008
#         ON ACTION controlp INFIELD pjbq008
            #add-point:ON ACTION controlp INFIELD pjbq008
            {<point name="construct.c.page1.pjbq008" />}
            #END add-point

         #----<<pjbq009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq009
            #add-point:BEFORE FIELD pjbq009
            {<point name="construct.b.page1.pjbq009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq009

            #add-point:AFTER FIELD pjbq009
            {<point name="construct.a.page1.pjbq009" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq009
#         ON ACTION controlp INFIELD pjbq009
            #add-point:ON ACTION controlp INFIELD pjbq009
            {<point name="construct.c.page1.pjbq009" />}
            #END add-point

         #----<<pjbq010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq010
            #add-point:BEFORE FIELD pjbq010
            {<point name="construct.b.page1.pjbq010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq010

            #add-point:AFTER FIELD pjbq010
            {<point name="construct.a.page1.pjbq010" />}
            #END add-point


         #Ctrlp:construct.c.page1.pjbq010
#         ON ACTION controlp INFIELD pjbq010
            #add-point:ON ACTION controlp INFIELD pjbq010
            {<point name="construct.c.page1.pjbq010" />}
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc_table2 ON pjbr003,pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009
           FROM s_detail2[1].pjbr003,s_detail2[1].pjbr004,s_detail2[1].pjbr005,s_detail2[1].pjbr006,s_detail2[1].pjbr007,s_detail2[1].pjbr008,s_detail2[1].pjbr009

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body2.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理(table 2)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page2  >---------------------
         #----<<pjbr003>>----
         #Ctrlp:construct.c.page2.pjbr003
         ON ACTION controlp INFIELD pjbr003
            #add-point:ON ACTION controlp INFIELD pjbr003
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '8002'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbr003  #顯示到畫面上

            NEXT FIELD pjbr003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbr003
            #add-point:BEFORE FIELD pjbr003
            {<point name="construct.b.page2.pjbr003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr003

            #add-point:AFTER FIELD pjbr003
            {<point name="construct.a.page2.pjbr003" />}
            #END add-point


         #----<<pjbr004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr004
            #add-point:BEFORE FIELD pjbr004
            {<point name="construct.b.page2.pjbr004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr004

            #add-point:AFTER FIELD pjbr004
            {<point name="construct.a.page2.pjbr004" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr004
#         ON ACTION controlp INFIELD pjbr004
            #add-point:ON ACTION controlp INFIELD pjbr004
            {<point name="construct.c.page2.pjbr004" />}
            #END add-point

         #----<<pjbr005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr005
            #add-point:BEFORE FIELD pjbr005
            {<point name="construct.b.page2.pjbr005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr005

            #add-point:AFTER FIELD pjbr005
            {<point name="construct.a.page2.pjbr005" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr005
#         ON ACTION controlp INFIELD pjbr005
            #add-point:ON ACTION controlp INFIELD pjbr005
            {<point name="construct.c.page2.pjbr005" />}
            #END add-point

         #----<<pjbr006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr006
            #add-point:BEFORE FIELD pjbr006
            {<point name="construct.b.page2.pjbr006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr006

            #add-point:AFTER FIELD pjbr006
            {<point name="construct.a.page2.pjbr006" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr006
#         ON ACTION controlp INFIELD pjbr006
            #add-point:ON ACTION controlp INFIELD pjbr006
            {<point name="construct.c.page2.pjbr006" />}
            #END add-point

         #----<<pjbr007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr007
            #add-point:BEFORE FIELD pjbr007
            {<point name="construct.b.page2.pjbr007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr007

            #add-point:AFTER FIELD pjbr007
            {<point name="construct.a.page2.pjbr007" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr007
#         ON ACTION controlp INFIELD pjbr007
            #add-point:ON ACTION controlp INFIELD pjbr007
            {<point name="construct.c.page2.pjbr007" />}
            #END add-point

         #----<<pjbr008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr008
            #add-point:BEFORE FIELD pjbr008
            {<point name="construct.b.page2.pjbr008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr008

            #add-point:AFTER FIELD pjbr008
            {<point name="construct.a.page2.pjbr008" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr008
#         ON ACTION controlp INFIELD pjbr008
            #add-point:ON ACTION controlp INFIELD pjbr008
            {<point name="construct.c.page2.pjbr008" />}
            #END add-point

         #----<<pjbr009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr009
            #add-point:BEFORE FIELD pjbr009
            {<point name="construct.b.page2.pjbr009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr009

            #add-point:AFTER FIELD pjbr009
            {<point name="construct.a.page2.pjbr009" />}
            #END add-point


         #Ctrlp:construct.c.page2.pjbr009
#         ON ACTION controlp INFIELD pjbr009
            #add-point:ON ACTION controlp INFIELD pjbr009
            {<point name="construct.c.page2.pjbr009" />}
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc_table3 ON pjbs003,pjbs004,pjbs005,pjbs006,pjbs007,pjbs008
           FROM s_detail3[1].pjbs003,s_detail3[1].pjbs004,s_detail3[1].pjbs005,s_detail3[1].pjbs006,s_detail3[1].pjbs007,s_detail3[1].pjbs008

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body3.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理(table 3)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page3  >---------------------
         #----<<pjbs003>>----
         #Ctrlp:construct.c.page3.pjbs003
         ON ACTION controlp INFIELD pjbs003
            #add-point:ON ACTION controlp INFIELD pjbs003
            #此段落由子樣板a08產生
            #開窗c段
	   		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_mrba001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbs003  #顯示到畫面上

            NEXT FIELD pjbs003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbs003
            #add-point:BEFORE FIELD pjbs003
            {<point name="construct.b.page3.pjbs003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs003

            #add-point:AFTER FIELD pjbs003
            {<point name="construct.a.page3.pjbs003" />}
            #END add-point


         #----<<pjbs004>>----
         #Ctrlp:construct.c.page3.pjbs004
         ON ACTION controlp INFIELD pjbs004
            #add-point:ON ACTION controlp INFIELD pjbs004
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		 	   LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbs004  #顯示到畫面上

            NEXT FIELD pjbs004                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbs004
            #add-point:BEFORE FIELD pjbs004
            {<point name="construct.b.page3.pjbs004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs004

            #add-point:AFTER FIELD pjbs004
            {<point name="construct.a.page3.pjbs004" />}
            #END add-point


         #----<<pjbs005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbs005
            #add-point:BEFORE FIELD pjbs005
            {<point name="construct.b.page3.pjbs005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs005

            #add-point:AFTER FIELD pjbs005
            {<point name="construct.a.page3.pjbs005" />}
            #END add-point


         #Ctrlp:construct.c.page3.pjbs005
#         ON ACTION controlp INFIELD pjbs005
            #add-point:ON ACTION controlp INFIELD pjbs005
            {<point name="construct.c.page3.pjbs005" />}
            #END add-point

         #----<<pjbs006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbs006
            #add-point:BEFORE FIELD pjbs006
            {<point name="construct.b.page3.pjbs006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs006

            #add-point:AFTER FIELD pjbs006
            {<point name="construct.a.page3.pjbs006" />}
            #END add-point


         #Ctrlp:construct.c.page3.pjbs006
#         ON ACTION controlp INFIELD pjbs006
            #add-point:ON ACTION controlp INFIELD pjbs006
            {<point name="construct.c.page3.pjbs006" />}
            #END add-point

         #----<<pjbs007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbs007
            #add-point:BEFORE FIELD pjbs007
            {<point name="construct.b.page3.pjbs007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs007

            #add-point:AFTER FIELD pjbs007
            {<point name="construct.a.page3.pjbs007" />}
            #END add-point


         #Ctrlp:construct.c.page3.pjbs007
#         ON ACTION controlp INFIELD pjbs007
            #add-point:ON ACTION controlp INFIELD pjbs007
            {<point name="construct.c.page3.pjbs007" />}
            #END add-point

         #----<<pjbs008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbs008
            #add-point:BEFORE FIELD pjbs008
            {<point name="construct.b.page3.pjbs008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs008

            #add-point:AFTER FIELD pjbs008
            {<point name="construct.a.page3.pjbs008" />}
            #END add-point


         #Ctrlp:construct.c.page3.pjbs008
#         ON ACTION controlp INFIELD pjbs008
            #add-point:ON ACTION controlp INFIELD pjbs008
            {<point name="construct.c.page3.pjbs008" />}
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc_table4 ON pjbt003,pjbt004,pjbt005
           FROM s_detail4[1].pjbt003,s_detail4[1].pjbt004,s_detail4[1].pjbt005

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body4.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理(table 4)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page4  >---------------------
         #----<<pjbt003>>----
         #Ctrlp:construct.c.page4.pjbt003
         ON ACTION controlp INFIELD pjbt003
            #add-point:ON ACTION controlp INFIELD pjbt003
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '8003'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbt003  #顯示到畫面上

            NEXT FIELD pjbt003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbt003
            #add-point:BEFORE FIELD pjbt003
            {<point name="construct.b.page4.pjbt003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbt003

            #add-point:AFTER FIELD pjbt003
            {<point name="construct.a.page4.pjbt003" />}
            #END add-point


         #----<<pjbt004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbt004
            #add-point:BEFORE FIELD pjbt004
            {<point name="construct.b.page4.pjbt004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbt004

            #add-point:AFTER FIELD pjbt004
            {<point name="construct.a.page4.pjbt004" />}
            #END add-point


         #Ctrlp:construct.c.page4.pjbt004
#         ON ACTION controlp INFIELD pjbt004
            #add-point:ON ACTION controlp INFIELD pjbt004
            {<point name="construct.c.page4.pjbt004" />}
            #END add-point

         #----<<pjbt005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbt005
            #add-point:BEFORE FIELD pjbt005
            {<point name="construct.b.page4.pjbt005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbt005

            #add-point:AFTER FIELD pjbt005
            {<point name="construct.a.page4.pjbt005" />}
            #END add-point


         #Ctrlp:construct.c.page4.pjbt005
#         ON ACTION controlp INFIELD pjbt005
            #add-point:ON ACTION controlp INFIELD pjbt005
            {<point name="construct.c.page4.pjbt005" />}
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc_table5 ON pjbp002,pjbp003,pjbp004,pjbp005,pjbp006
           FROM s_detail5[1].pjbp002,s_detail5[1].pjbp003,s_detail5[1].pjbp004,s_detail5[1].pjbp005,s_detail5[1].pjbp006

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct
            {<point name="cs.body5.before_construct"/>}
            #end add-point

       #單身公用欄位開窗相關處理(table 5)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page5  >---------------------
         #----<<pjbp002>>----
         #Ctrlp:construct.c.page5.pjbp002
         ON ACTION controlp INFIELD pjbp002
            #add-point:ON ACTION controlp INFIELD pjbp002
            #此段落由子樣板a08產生
            #開窗c段
	   		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
		   	LET g_qryparam.arg1 = '8002'
            CALL q_oocq002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbp002  #顯示到畫面上

            NEXT FIELD pjbp002                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbp002
            #add-point:BEFORE FIELD pjbp002
            {<point name="construct.b.page5.pjbp002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp002

            #add-point:AFTER FIELD pjbp002
            {<point name="construct.a.page5.pjbp002" />}
            #END add-point


         #----<<pjbp003>>----
         #Ctrlp:construct.c.page5.pjbp003
         ON ACTION controlp INFIELD pjbp003
            #add-point:ON ACTION controlp INFIELD pjbp003
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjbp003  #顯示到畫面上

            NEXT FIELD pjbp003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD pjbp003
            #add-point:BEFORE FIELD pjbp003
            {<point name="construct.b.page5.pjbp003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp003

            #add-point:AFTER FIELD pjbp003
            {<point name="construct.a.page5.pjbp003" />}
            #END add-point


         #----<<pjbp004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp004
            #add-point:BEFORE FIELD pjbp004
            {<point name="construct.b.page5.pjbp004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp004

            #add-point:AFTER FIELD pjbp004
            {<point name="construct.a.page5.pjbp004" />}
            #END add-point


         #Ctrlp:construct.c.page5.pjbp004
#         ON ACTION controlp INFIELD pjbp004
            #add-point:ON ACTION controlp INFIELD pjbp004
            {<point name="construct.c.page5.pjbp004" />}
            #END add-point

         #----<<pjbp005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp005
            #add-point:BEFORE FIELD pjbp005
            {<point name="construct.b.page5.pjbp005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp005

            #add-point:AFTER FIELD pjbp005
            {<point name="construct.a.page5.pjbp005" />}
            #END add-point


         #Ctrlp:construct.c.page5.pjbp005
#         ON ACTION controlp INFIELD pjbp005
            #add-point:ON ACTION controlp INFIELD pjbp005
            {<point name="construct.c.page5.pjbp005" />}
            #END add-point

         #----<<pjbp006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp006
            #add-point:BEFORE FIELD pjbp006
            {<point name="construct.b.page5.pjbp006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp006

            #add-point:AFTER FIELD pjbp006
            {<point name="construct.a.page5.pjbp006" />}
            #END add-point


         #Ctrlp:construct.c.page5.pjbp006
#         ON ACTION controlp INFIELD pjbp006
            #add-point:ON ACTION controlp INFIELD pjbp006
            {<point name="construct.c.page5.pjbp006" />}
            #END add-point



      END CONSTRUCT



      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      {<point name="cs.add_cs"/>}
      #end add-point

      BEFORE DIALOG
         #add-point:cs段b_dialog
         {<point name="cs.b_dialog"/>}
         #end add-point

      ON ACTION qbe_select     #條件查詢
        #CALL cl_qbe_list() RETURNING lc_qbe_sn
        #CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
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

   IF g_wc_table1 <> " 1=1" THEN
      LET g_wc2 = g_wc2," AND", g_wc_table1
   END IF
   IF g_wc_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table2
   END IF

   IF g_wc_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table3
   END IF

   IF g_wc_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table4
   END IF

   IF g_wc_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc_table5
   END IF



   #add-point:cs段after_construct
   {<point name="cs.after_construct"/>}
   #end add-point

   IF INT_FLAG THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION apjm300_query()
   #add-point:query段define
   {<point name="query.define"/>}
   #end add-point

   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_master_idx = 0
   LET g_current_master_row = 0
   CALL cl_navigator_setting( g_current_master_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_tree.clear()
   CALL g_pjbq_d.clear()
   CALL g_pjbq2_d.clear()

   CALL g_pjbq3_d.clear()

   CALL g_pjbq4_d.clear()

   CALL g_pjbq5_d.clear()


   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
#   DISPLAY ' ' TO FORMONLY.b_index
#   DISPLAY ' ' TO FORMONLY.b_count

   CALL apjm300_construct()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_pjbn_m.* TO NULL
      INITIALIZE g_pjbo_m.* TO NULL
      LET g_wc = " 1=1"
      LET g_wc2 = " 1=1"
      RETURN
   END IF

   LET g_error_show = 1
   CALL apjm300_browser_fill()

   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL apjm300_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION apjm300_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

   CASE p_flag
      WHEN 'F' LET g_current_master_idx = 1
      WHEN 'L' LET g_current_master_idx = g_header_cnt
      WHEN 'P'
         IF g_current_master_idx > 1 THEN
            LET g_current_master_idx = g_current_master_idx - 1
         END IF
      WHEN 'N'
         IF g_current_master_idx < g_header_cnt THEN
            LET g_current_master_idx =  g_current_master_idx + 1
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
             LET g_current_master_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE

   #CALL g_curr_diag.setCurrentRow("s_browse", g_current_master_idx) #設定browse 索引
   LET g_detail_cnt = g_header_cnt

   DISPLAY g_detail_cnt TO FORMONLY.cnt
   DISPLAY g_current_master_idx TO FORMONLY.idx
#   #單身總筆數顯示
#   #LET g_detail_idx = 1
#   IF g_detail_cnt > 0 THEN
#      DISPLAY g_detail_idx TO FORMONLY.idx
#   ELSE
#      LET g_detail_idx = 0
#      DISPLAY ' ' TO FORMONLY.idx
#   END IF

   #瀏覽頁筆數顯示

   CALL cl_navigator_setting(g_current_master_idx, g_detail_cnt)

   #代表沒有資料
   IF g_current_master_idx = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_master_idx > g_browser.getLength() THEN
      LET g_current_master_idx = g_browser.getLength()
   END IF
   #by lixh 
   #代表沒有資料
   IF g_current_master_idx = 0 THEN
      RETURN
   END IF   

   IF g_copy_flag = 'Y' THEN
      LET g_pjbn_m.pjbn001 = g_copy_pjbn001
   ELSE
      LET g_pjbn_m.pjbn001 = g_browser[g_current_master_idx].b_pjbn001
      LET g_pjbn_m.pjbn900 = g_browser[g_current_master_idx].b_pjbn900
   END IF


   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbn009,pjbn010,pjbn011,pjbn012,pjbn013,pjbn900,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt
      INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,
           g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn013,
           g_pjbn_m.pjbn900,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
           g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt
      FROM pjbn_t
      WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
        AND pjbn900 = g_pjbn_m.pjbn900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbn_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_pjbn_m.* TO NULL
      RETURN
   END IF
   
   CALL s_desc_get_person_desc(g_pjbn_m.pjbnownid) RETURNING g_pjbn_m.pjbnownid_desc
   CALL s_desc_get_person_desc(g_pjbn_m.pjbncrtid) RETURNING g_pjbn_m.pjbncrtid_desc   
   CALL s_desc_get_person_desc(g_pjbn_m.pjbnmodid) RETURNING g_pjbn_m.pjbnmodid_desc
   CALL s_desc_get_person_desc(g_pjbn_m.pjbncnfid) RETURNING g_pjbn_m.pjbncnfid_desc
   CALL s_desc_get_department_desc(g_pjbn_m.pjbnowndp) RETURNING g_pjbn_m.pjbnowndp_desc
   CALL s_desc_get_department_desc(g_pjbn_m.pjbncrtdp) RETURNING g_pjbn_m.pjbncrtdp_desc  
   CALL s_desc_get_person_desc(g_pjbn_m.pjbn012) RETURNING g_pjbn_m.pjbn012_desc
      
   DISPLAY BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
           g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt,g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn013

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

   CALL cl_set_act_visible("modify,delete",TRUE)
   IF g_pjbn_m.pjbnstus = 'Y' OR  g_pjbn_m.pjbnstus = 'X' THEN
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   CALL cl_set_act_visible("reproduce,output",FALSE)
   #重新顯示
   CALL apjm300_tree_fill()

END FUNCTION

PRIVATE FUNCTION apjm300_insert(p_flag)
DEFINE p_flag   LIKE type_t.chr1
   
   IF p_flag = "Y" THEN
   
      CLEAR FORM                                #清畫面欄位內容
      
      CALL g_pjbq_d.clear()    #清除陣列
      
      CALL g_pjbq2_d.clear()   #清除陣列
   
      CALL g_pjbq3_d.clear()   #清除陣列
   
      CALL g_pjbq4_d.clear()   #清除陣列
   
      CALL g_pjbq5_d.clear()   #清除陣列
      
      INITIALIZE g_pjbq_d_t.* TO NULL    #清除陣列
      INITIALIZE g_pjbq_d_o.* TO NULL    #清除陣列   #170203-00002#6 20170203 add by beckxie
      INITIALIZE g_pjbq2_d_t.* TO NULL   #清除陣列
   
      INITIALIZE g_pjbq3_d_t.* TO NULL   #清除陣列
   
      INITIALIZE g_pjbq4_d_t.* TO NULL   #清除陣列
   
      INITIALIZE g_pjbq5_d_t.* TO NULL   #清除陣列
      
      CALL g_pjbq_d_color.clear()    #清除陣列
      
      CALL g_pjbq2_d_color.clear()   #清除陣列
   
      CALL g_pjbq3_d_color.clear()   #清除陣列
   
      CALL g_pjbq4_d_color.clear()   #清除陣列
   
      CALL g_pjbq5_d_color.clear()   #清除陣列
      
      #INITIALIZE g_pjbn_m.* LIKE pjbn_t.*             #DEFAULT 設定  #161124-00048#14  2016/12/15 By 08734 mark
      INITIALIZE g_pjbn_m.* TO NULL             #DEFAULT 設定  #161124-00048#14  2016/12/15 By 08734 add
      LET g_pjbn001_t = NULL
      LET g_pjbn900_t = NULL
      LET g_pjbo002_t = NULL
   ELSE
      CALL g_pjbq_d.clear()    #清除陣列
      CALL g_pjbq2_d.clear()   #清除陣列   
      CALL g_pjbq3_d.clear()   #清除陣列   
      CALL g_pjbq4_d.clear()   #清除陣列
      
      INITIALIZE g_pjbq_d_t.* TO NULL    #清除陣列      
      INITIALIZE g_pjbq_d_o.* TO NULL    #清除陣列      #170203-00002#6 20170203 add by beckxie
      INITIALIZE g_pjbq2_d_t.* TO NULL   #清除陣列   
      INITIALIZE g_pjbq3_d_t.* TO NULL   #清除陣列   
      INITIALIZE g_pjbq4_d_t.* TO NULL   #清除陣列 
      
      CALL g_pjbq_d_color.clear()    #清除陣列      
      CALL g_pjbq2_d_color.clear()   #清除陣列   
      CALL g_pjbq3_d_color.clear()   #清除陣列   
      CALL g_pjbq4_d_color.clear()   #清除陣列
   
   END IF
   #INITIALIZE g_pjbo_m.* LIKE pjbo_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   INITIALIZE g_pjbo_m.* TO NULL  #161124-00048#14  2016/12/15 By 08734 add
   
   LET g_pjbo001_t = NULL
   LET g_pjbo003_t = NULL

   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生
   IF p_flag = "Y" THEN
      LET g_pjbn_m.pjbn009 = 0    #add by lixh 20150706
      
      DISPLAY BY NAME g_pjbn_m.pjbn009
      LET g_pjbn_m.pjbnownid = g_user
      LET g_pjbn_m.pjbnowndp = g_dept
      LET g_pjbn_m.pjbncrtid = g_user
      LET g_pjbn_m.pjbncrtdp = g_dept
      LET g_pjbn_m.pjbncrtdt = cl_get_current()
      LET g_pjbn_m.pjbnmodid = g_user
      LET g_pjbn_m.pjbnmoddt = cl_get_current()        
      LET g_pjbn_m.pjbnstus = "N"
      LET g_pjbn_m.pjbn015 = 'apjm300'
      LET g_pjbn_m.pjbn002 = "N"
      LET g_pjbn_m.pjbn007 = "1"
      LET g_pjbn_m.pjbn005 = g_today
      SELECT ooef008 INTO g_pjbn_m.pjbn008 FROM ooef_t
       WHERE ooefent = g_enterprise AND ooef001 = 'ALL'
      CALL apjm300_pjbn008_desc(g_pjbn_m.pjbn008)
      LET g_pjbn_m_t.* = g_pjbn_m.*
   END IF
      IF NOT cl_null(g_tree_idx) AND  g_tree_idx > 0 THEN
         LET g_pjbo_m.pjbo003 = g_tree[g_tree_idx].b_pjbo002
         IF NOT cl_null(g_pjbo_m.pjbo003) THEN
            CALL apjm300_get_pjbo002()
         END IF
      END IF
      LET g_pjbo_m.pjbo009 = "N"
      LET g_pjbo_m.pjbo012 = "0"
      LET g_pjbo_m.pjbo003_desc = ''
      LET g_pjbo_m.pjbo004_desc = ''
      LET g_pjbo_m.pjbo010_desc = ''
      LET g_pjbo_m.pjbo011_desc = ''
      DISPLAY BY NAME g_pjbo_m.pjbo003_desc,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011_desc
      LET g_pjbo_m_t.* = g_pjbo_m.*

      IF p_flag = "Y" THEN
         CALL apjm300_input("a")
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_pjbn_m.* = g_pjbn_m_t.*
            CALL apjm300_show()
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT WHILE
         END IF
         IF g_copy_flag = 'Y' THEN
            EXIT WHILE
         END IF
         CALL apjm300_pjbo_input("u")
      ELSE
         CALL apjm300_pjbo_input("a")
      END IF

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_pjbo_m.* = g_pjbo_m_t.*
         CALL apjm300_show()
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

         EXIT WHILE
      END IF

      CALL g_pjbq_d.clear()
      CALL g_pjbq2_d.clear()

      CALL g_pjbq3_d.clear()

      CALL g_pjbq4_d.clear()

      CALL g_pjbq5_d.clear()



      LET g_rec_b = 0
      EXIT WHILE

   END WHILE
   #組合新增資料的條件   #add by lixh 20150724
   LET g_add_browse = " pjbnent = '" ||g_enterprise|| "' AND",
                      " pjbn001 = '", g_pjbn_m.pjbn001, "' "
                      ," AND pjbn900 = '", g_pjbn_m.pjbn900, "' "
                      
   #填到最後面
   IF p_flag = "Y" THEN   #add by lixh 20150730
      LET g_current_master_idx = g_browser.getLength() + 1
   END IF
#   CALL apjm300_browser_fill()  
#   CALL cl_notice() 
END FUNCTION

PRIVATE FUNCTION apjm300_modify(p_flag)
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE p_flag       LIKE type_t.chr1

   IF g_pjbn_m.pjbn001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   SELECT UNIQUE pjbn000,pjbn001,pjbn002,pjbn009,pjbn900,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt
     INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
          g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt
     FROM pjbn_t
    WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
      AND pjbn900 = g_pjbn_m.pjbn900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbn_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_pjbn_m.* TO NULL
      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT apjm300_action_chk() THEN
      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   LET g_pjbn001_t = g_pjbn_m.pjbn001
   LET g_pjbn900_t = g_pjbn_m.pjbn900
   CALL s_transaction_begin()
   
   OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apjm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   FETCH apjm300_cl INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn000_desc,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,g_pjbn_m.pjbn003,g_pjbn_m.pjbn003_desc,g_pjbn_m.pjbn004,g_pjbn_m.pjbn004_desc,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn008_desc,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnownid_desc,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbnowndp_desc,g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtid_desc,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdp_desc,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmodid_desc,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfid_desc,g_pjbn_m.pjbncnfdt,g_pjbn_m.pjbnstus
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_pjbn_m.pjbn001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   LET g_pjbo_m.pjbo001 = g_tree[g_tree_idx].b_pjbo001
   LET g_pjbo_m.pjbo002 = g_tree[g_tree_idx].b_pjbo002

   IF g_pjbo_m.pjbo001 IS NULL OR 
      g_pjbo_m.pjbo002 IS NULL 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
    SELECT UNIQUE pjbo002,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001
             INTO g_pjbo_m.pjbo002,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001
             FROM pjbo_t
             WHERE pjboent = g_enterprise AND pjbo001 = g_pjbo_m.pjbo001 AND pjbo002 = g_pjbo_m.pjbo002
               AND pjbo900 = g_pjbn_m.pjbn900

   ERROR ""

   LET g_pjbo001_t = g_pjbo_m.pjbo001
   LET g_pjbo002_t = g_pjbo_m.pjbo002
   

   

   OPEN apjm300_bcl6 USING g_enterprise,g_pjbo_m.pjbo001
                                                       ,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apjm300_bcl6:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE apjm300_bcl6
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH apjm300_bcl6 INTO g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_pjbo_m.pjbo001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE apjm300_bcl6
      CALL s_transaction_end('N','0')
      RETURN
   END IF

                # CALL apjm300_pjbn_t('s')

   CALL apjm300_show()
   WHILE TRUE
      LET g_pjbn001_t = g_pjbn_m.pjbn001
      LET g_pjbn900_t = g_pjbn_m.pjbn900
      LET g_pjbo001_t = g_pjbo_m.pjbo001
      LET g_pjbo002_t = g_pjbo_m.pjbo002



      #寫入修改者/修改日期資訊(單頭)
      LET g_pjbn_m.pjbnmodid = g_user
      LET g_pjbn_m.pjbnmoddt = cl_get_current()


      IF p_flag = 'Y' THEN
         CALL apjm300_input("u")     #欄位更改
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_pjbn_m.* = g_pjbn_m_t.*
            CALL apjm300_show()
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT WHILE
         END IF
      END IF
      CALL apjm300_pjbo_input("u")


      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_pjbo_m.* = g_pjbo_m_t.*
         CALL apjm300_show()
         INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9001
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_pjbo_m.pjbo001 != g_pjbo001_t
      OR g_pjbo_m.pjbo002 != g_pjbo002_t
      OR g_pjbn_m.pjbn001 != g_pjbn001_t
      OR g_pjbn_m.pjbn900 != g_pjbn900_t


      THEN
         CALL s_transaction_begin()

         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update" mark="Y"/>}
         #end add-point

         #更新單身key值
         UPDATE pjbq_t SET pjbq001 = g_pjbn_m.pjbn001
                                      ,pjbq002 = g_pjbo_m.pjbo002


          WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbn001_t
            AND pjbq002 = g_pjbo002_t
            AND pjbq900 = g_pjbn900_t


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pjbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = ""
             LET g_errparam.popup = TRUE
             CALL cl_err()

             CALL s_transaction_end('N','0')
             CONTINUE WHILE
         END IF

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update"/>}
         #end add-point

         #更新單身key值
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update2" mark="Y"/>}
         #end add-point
         UPDATE pjbr_t
            SET pjbr001 = g_pjbn_m.pjbn001
               ,pjbr002 = g_pjbo_m.pjbo002


          WHERE pjbrent = g_enterprise AND
                pjbr001 = g_pjbn001_t
            AND pjbr900 = g_pjbn900_t   
            AND pjbr002 = g_pjbo002_t


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update2"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pjbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update2"/>}
         #end add-point

         #更新單身key值
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update3" mark="Y"/>}
         #end add-point
         UPDATE pjbs_t
            SET pjbs001 = g_pjbn_m.pjbn001
               ,pjbs002 = g_pjbo_m.pjbo002


          WHERE pjbsent = g_enterprise AND
                pjbs001 = g_pjbn001_t
            AND pjbs900 = g_pjbn900_t      
            AND pjbs002 = g_pjbo002_t


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update3"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pjbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update3"/>}
         #end add-point

         #更新單身key值
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update4" mark="Y"/>}
         #end add-point
         UPDATE pjbt_t
            SET pjbt001 = g_pjbn_m.pjbn001
               ,pjbt002 = g_pjbo_m.pjbo002


          WHERE pjbtent = g_enterprise AND
                pjbt001 = g_pjbn001_t
            AND pjbt900 = g_pjbn900_t  
            AND pjbt002 = g_pjbo002_t


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update4"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pjbt_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbt_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update4"/>}
         #end add-point

         #更新單身key值
         #add-point:單身fk修改前
         {<point name="modify.body.b_fk_update5" mark="Y"/>}
         #end add-point
         UPDATE pjbp_t
            SET  pjbp001 = g_pjbo_m.pjbo001

          WHERE pjbpent = g_enterprise 
            AND pjbp001 = g_pjbo001_t 
            AND pjbo900 = g_pjbo900_t    


         #add-point:單身fk修改中
         {<point name="modify.body.m_fk_update5"/>}
         #end add-point

         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "pjbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE

         #add-point:單身fk修改後
         {<point name="modify.body.a_fk_update5"/>}
         #end add-point



         #UPDATE 多語言table key值



         CALL s_transaction_end('Y','0')
      END IF

      EXIT WHILE
   END WHILE
   #組合新增資料的條件   #add by lixh 20150724 
   LET g_add_browse = " pjbnent = '" ||g_enterprise|| "' AND",
                      " pjbn001 = '", g_pjbn_m.pjbn001, "' "
                      ," AND pjbn900 = '", g_pjbn_m.pjbn900, "' "
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_pjbn_m.pjbn001,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   CLOSE apjm300_cl
   CLOSE apjm300_bcl6
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_pjbn_m.pjbn001,'U')

END FUNCTION

PRIVATE FUNCTION apjm300_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd_t         LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#3 num5==》num10
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_pjaa007       LIKE pjaa_t.pjaa007
   DEFINE  l_success       LIKE type_t.num5   #add--2015/05/08 By shiun 增加編碼功能

   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   

   

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL apjm300_set_entry(p_cmd)
   #add-point:set_entry後
   {<point name="input.after_set_entry"/>}
   #end add-point
   CALL apjm300_set_no_entry(p_cmd)
   #add-point:set_no_entry後
   {<point name="input.after_set_no_entry"/>}
   #end add-point
   LET g_errshow = 1

   DISPLAY BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbnstus,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbnstus,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,
                    g_pjbn_m.pjbn010
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION


         ON ACTION update_item

            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               IF NOT cl_null(g_pjbn_m.pjbn001) THEN
                  CALL n_pjbnl(g_pjbn_m.pjbn001,g_pjbn_m.pjbn900)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pjbn_m.pjbn001
                  LET g_ref_fields[2] = g_pjbn_m.pjbn900
                  CALL ap_ref_array2(g_ref_fields," SELECT pjbnl003,pjbnl004 FROM pjbnl_t WHERE pjbnlent = '"
                      ||g_enterprise||"' AND pjbnl001 = ?  AND pjbnl900 = ? AND pjbnl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pjbn_m.pjbnl003 = g_rtn_fields[1]
                  LET g_pjbn_m.pjbnl004 = g_rtn_fields[2]
                  DISPLAY BY NAME g_pjbn_m.pjbnl003
                  DISPLAY BY NAME g_pjbn_m.pjbnl004   
               END IF
            END IF


         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            LET g_master_multi_table_t.pjbnl001 = g_pjbn_m.pjbn001
            LET g_master_multi_table_t.pjbnl900 = g_pjbn_m.pjbn900  #add by lixh 
            LET g_master_multi_table_t.pjbnl003 = g_pjbn_m.pjbnl003
            LET g_master_multi_table_t.pjbnl004 = g_pjbn_m.pjbnl004


            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.pjbnl001 = ''
               LET g_master_multi_table_t.pjbnl900 = ''
               LET g_master_multi_table_t.pjbnl003 = ''
               LET g_master_multi_table_t.pjbnl004 = ''


            END IF
            #add-point:資料輸入前
            {<point name="input.m.before_input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<pjbn000>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbn000

            #add-point:AFTER FIELD pjbn000
            CALL apjm300_pjbn000_desc(g_pjbn_m.pjbn000)
            IF NOT cl_null(g_pjbn_m.pjbn000) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbn_m.pjbn000

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="apj-00007:sub-01302|apji010|",cl_get_progname("apji010",g_lang,"2"),"|:EXEPROGapji010"
               #160318-00025#23  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjaa001") THEN
                  SELECT pjaa002 INTO g_pjbn_m.pjbn003 FROM pjaa_t 
                   WHERE pjaaent = g_enterprise AND pjaa001 = g_pjbn_m.pjbn000
                  DISPLAY BY NAME g_pjbn_m.pjbn003
                  CALL apjm300_pjbn003_desc(g_pjbn_m.pjbn003)
                  SELECT pjaa007 INTO l_pjaa007 FROM pjaa_t
                   WHERE pjaaent = g_enterprise AND pjaa001 = g_pjbn_m.pjbn000
                  IF NOT cl_null(l_pjaa007) AND p_cmd = 'a' THEN
                     CALL s_aooi390_1('15',l_pjaa007) RETURNING g_success,g_pjbn_m.pjbn001
                  END IF

               ELSE
                  LET g_pjbn_m.pjbn000 = g_pjbn_m_t.pjbn000
                  CALL apjm300_pjbn000_desc(g_pjbn_m.pjbn000)
                  NEXT FIELD CURRENT
               END IF
            ELSE
               NEXT FIELD CURRENT

            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbn000
            #add-point:BEFORE FIELD pjbn000
            {<point name="input.b.pjbn000" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbn000
            #add-point:ON CHANGE pjbn000
            {<point name="input.g.pjbn000" />}
            #END add-point

         #----<<pjbn001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbn001
            #add-point:BEFORE FIELD pjbn001
            {<point name="input.b.pjbn001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbn001
            IF NOT cl_null(g_pjbn_m.pjbn001) THEN
               IF g_pjbn_m.pjbn001 <> g_pjbn_m_t.pjbn001 OR g_pjbn_m_t.pjbn001 IS NULL THEN
                  SELECT MAX(pjba009)+1 INTO g_pjbn_m.pjbn009 FROM pjba_t   #版次
                   WHERE pjbaent = g_enterprise
                     AND pjba001 = g_pjbn_m.pjbn001
                  IF cl_null(g_pjbn_m.pjbn009) THEN LET g_pjbn_m.pjbn009 = 1 END IF  
                  SELECT MAX(pjbn900)+1 INTO g_pjbn_m.pjbn900 FROM pjbn_t   #變更序
                   WHERE pjbnent = g_enterprise
                     AND pjbn001 = g_pjbn_m.pjbn001
               END IF                  
               DISPLAY BY NAME g_pjbn_m.pjbn009,g_pjbn_m.pjbn900
               IF cl_null(g_pjbn_m.pjbn900) THEN LET g_pjbn_m.pjbn900 = 1 END IF            
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbn_m.pjbn001 != g_pjbn001_t OR g_pjbn_m.pjbn900 != g_pjbn900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbn_t WHERE "||"pjbnent = '" ||g_enterprise|| "' AND "||"pjbn001 = '"||g_pjbn_m.pjbn001 || "' AND "||" pjbn900 = '"||g_pjbn_m.pjbn900 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  #add--2015/05/08 By shiun--(S)
#                  IF NOT s_aooi390_chk('15',g_pjbn_m.pjbn001) THEN
#                     LET g_pjbn_m.pjbn001 = g_pjbn_m_t.pjbn001
#                     DISPLAY BY NAME g_pjbn_m.pjbn001
#                     NEXT FIELD CURRENT
#                  END IF
                  #add--2015/05/08 By shiun--(E)
               END IF
            END IF   
            IF  NOT cl_null(g_pjbn_m.pjbn001) THEN
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbn_m.pjbn001

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001_2") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbn_m.pjbn001 = g_pjbn_m_t.pjbn001
                  CALL apjm300_pjbn001_desc()
                  NEXT FIELD CURRENT
               END IF
                              
               IF NOT apjm300_pjbn001_chk() THEN
                  LET g_pjbn_m.pjbn001 = g_pjbn_m_t.pjbn001
                  CALL apjm300_pjbn001_desc()
                  NEXT FIELD pjbn001
               END IF
               
              #帶值欄位
               IF g_pjbn_m.pjbn001 <> g_pjbn_m_t.pjbn001 OR g_pjbn_m_t.pjbn001 IS NULL THEN               
                  IF NOT apjm300_pjbn_desc() THEN
                     LET g_pjbn_m.pjbn001 = g_pjbn_m_t.pjbn001
                     CALL apjm300_pjbn001_desc()
                     NEXT FIELD pjbn001
                  END IF
                  CALL apjm300_pjbo_desc() 
                  LET p_cmd = 'u' 
               END IF               
            END IF
            LET g_pjbn001_t = g_pjbn_m.pjbn001
            LET g_pjbn900_t = g_pjbn_m.pjbn900
            CALL apjm300_b_fill()
            LET g_pjbn_m_t.pjbn001 =g_pjbn_m.pjbn001

         #此段落由子樣板a04產生
         ON CHANGE pjbn001
            #add-point:ON CHANGE pjbn001
            {<point name="input.g.pjbn001" />}
            #END add-point

         #----<<pjbn002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbn002
            #add-point:BEFORE FIELD pjbn002
            {<point name="input.b.pjbn002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbn002

            #add-point:AFTER FIELD pjbn002
            {<point name="input.a.pjbn002" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbn002
            CALL apjm300_set_entry('')
            CALL apjm300_set_no_entry('')

         #----<<pjbnl003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbnl003
            #add-point:BEFORE FIELD pjbnl003
            {<point name="input.b.pjbnl003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbnl003

            #add-point:AFTER FIELD pjbnl003
            {<point name="input.a.pjbnl003" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbnl003
            #add-point:ON CHANGE pjbnl003
            {<point name="input.g.pjbnl003" />}
            #END add-point

         #----<<pjbnl004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbnl004
            #add-point:BEFORE FIELD pjbnl004
            {<point name="input.b.pjbnl004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbnl004

            #add-point:AFTER FIELD pjbnl004
            {<point name="input.a.pjbnl004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbnl004
            #add-point:ON CHANGE pjbnl004
            {<point name="input.g.pjbnl004" />}
            #END add-point

         #----<<pjbn003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbn003

            #add-point:AFTER FIELD pjbn003
            CALL apjm300_pjbn003_desc(g_pjbn_m.pjbn003)
            CALL apjm300_pjbn004_desc(g_pjbn_m.pjbn004)
            IF NOT cl_null(g_pjbn_m.pjbn003) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbn_m.pjbn003


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbn001") THEN
                  SELECT pjbn004 INTO g_pjbn_m.pjbn004 FROM pjbn_t
                   WHERE pjbn001= g_pjbn_m.pjbn003 AND pjbnent = g_enterprise
                     AND pjbn900 = g_pjbn_m.pjbn900
                  IF cl_null(g_pjbn_m.pjbn004) THEN
                     SELECT ooef016 INTO g_pjbn_m.pjbn004 FROM ooef_t
                      WHERE ooefent = g_enterprise AND ooef001 = 'ALL'
                  END IF
                  CALL apjm300_pjbn004_desc(g_pjbn_m.pjbn004)
               ELSE
                  LET g_pjbn_m.pjbn003 = g_pjbn_m_t.pjbn003
                  CALL apjm300_pjbn003_desc(g_pjbn_m.pjbn003)
                  NEXT FIELD CURRENT
               END IF
              

            END IF
            CALL apjm300_set_entry(p_cmd)
            CALL apjm300_set_no_entry(p_cmd)
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbn003
            #add-point:BEFORE FIELD pjbn003
            {<point name="input.b.pjbn003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbn003
            #add-point:ON CHANGE pjbn003
            {<point name="input.g.pjbn003" />}
            #END add-point

         #----<<pjbn004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbn004

            #add-point:AFTER FIELD pjbn004
            CALL apjm300_pjbn004_desc(g_pjbn_m.pjbn004)
            IF NOT cl_null(g_pjbn_m.pjbn004) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = 'ALL'
               LET g_chkparam.arg2 = g_pjbn_m.pjbn004

              #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooaj002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbn_m.pjbn004 = g_pjbn_m_t.pjbn004
                  CALL apjm300_pjbn004_desc(g_pjbn_m.pjbn004)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbn004
            #add-point:BEFORE FIELD pjbn004
            {<point name="input.b.pjbn004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbn004
            #add-point:ON CHANGE pjbn004
            {<point name="input.g.pjbn004" />}
            #END add-point

         #----<<pjbn005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbn005
            #add-point:BEFORE FIELD pjbn005
            {<point name="input.b.pjbn005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbn005

            #add-point:AFTER FIELD pjbn005
            {<point name="input.a.pjbn005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbn005
            #add-point:ON CHANGE pjbn005
            {<point name="input.g.pjbn005" />}
            #END add-point

         #----<<pjbn006>>----
         
         AFTER FIELD pjbn010
            
            IF NOT cl_null(g_pjbn_m.pjbn010) THEN
               IF NOT s_azzi650_chk_exist('8006',g_pjbn_m.pjbn010) THEN
                  LET g_pjbn_m.pjbn010 = g_pjbn_m_t.pjbn010
                  CALL s_desc_get_acc_desc('8006',g_pjbn_m.pjbn010) RETURNING g_pjbn_m.pjbn010_desc
                  DISPLAY BY NAME g_pjbn_m.pjbn010_desc
                  NEXT FIELD CURRENT
               END IF                             
            END IF   
            CALL s_desc_get_acc_desc('8006',g_pjbn_m.pjbn010) RETURNING g_pjbn_m.pjbn010_desc
            DISPLAY BY NAME g_pjbn_m.pjbn010_desc            
         #此段落由子樣板a01產生
         BEFORE FIELD pjbn006
            #add-point:BEFORE FIELD pjbn006
            {<point name="input.b.pjbn006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbn006

            #add-point:AFTER FIELD pjbn006
            {<point name="input.a.pjbn006" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbn006
            #add-point:ON CHANGE pjbn006
            {<point name="input.g.pjbn006" />}
            #END add-point

         #----<<pjbnstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbnstus
            #add-point:BEFORE FIELD pjbnstus
            {<point name="input.b.pjbnstus" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbnstus

            #add-point:AFTER FIELD pjbnstus
            {<point name="input.a.pjbnstus" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbnstus
            #add-point:ON CHANGE pjbnstus
            {<point name="input.g.pjbnstus" />}
            #END add-point

         #----<<pjbn007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbn007
            #add-point:BEFORE FIELD pjbn007
            {<point name="input.b.pjbn007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbn007

            #add-point:AFTER FIELD pjbn007
            {<point name="input.a.pjbn007" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbn007
            #add-point:ON CHANGE pjbn007
            {<point name="input.g.pjbn007" />}
            #END add-point

         #----<<pjbn008>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbn008

            #add-point:AFTER FIELD pjbn008
            CALL apjm300_pjbn008_desc(g_pjbn_m.pjbn008)
            IF NOT cl_null(g_pjbn_m.pjbn008) THEN

               IF NOT s_aooi070_chk_exist('4',g_pjbn_m.pjbn008) THEN
                  LET g_pjbn_m.pjbn008 = g_pjbn_m_t.pjbn008
                  CALL apjm300_pjbn008_desc(g_pjbn_m.pjbn008)
                  NEXT FIELD CURRENT
               END IF
            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbn008
            #add-point:BEFORE FIELD pjbn008
            {<point name="input.b.pjbn008" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbn008
            #add-point:ON CHANGE pjbn008
            {<point name="input.g.pjbn008" />}
            #END add-point

         #----<<pjbnownid>>----
         #----<<pjbnowndp>>----
         #----<<pjbncrtid>>----
         #----<<pjbncrtdp>>----
         #----<<pjbncrtdt>>----
         #----<<pjbnmodid>>----
         #----<<pjbnmoddt>>----
         #----<<pjbncnfid>>----
         #----<<pjbncnfdt>>----
         #----<<cbo_searchcol>>----
         #此段落由子樣板a01產生
         

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<pjbn000>>----
         #Ctrlp:input.c.pjbn000
         ON ACTION controlp INFIELD pjbn000
            #add-point:ON ACTION controlp INFIELD pjbn000
#此段落由子樣板a07產生
            #開窗i段
	   		INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn000             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "('3')" #

            CALL q_pjaa001()                                #呼叫開窗

            LET g_pjbn_m.pjbn000 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn000 TO pjbn000              #顯示到畫面上
            CALL apjm300_pjbn000_desc(g_pjbn_m.pjbn000)
            NEXT FIELD pjbn000                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbn001>>----
         #Ctrlp:input.c.pjbn001
         ON ACTION controlp INFIELD pjbn001
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_pjbn_m.pjbn001 
            CALL q_pjba001_2()                           #呼叫開窗
            LET g_pjbn_m.pjbn001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn001 TO pjbn001             #顯示到畫面上
            CALL apjm300_pjbn001_desc()
            NEXT FIELD pjbn001   
         #----<<pjbn002>>----
         #Ctrlp:input.c.pjbn002
#         ON ACTION controlp INFIELD pjbn002
            #add-point:ON ACTION controlp INFIELD pjbn002
            {<point name="input.c.pjbn002" />}
            #END add-point

         #----<<pjbnl003>>----
         #Ctrlp:input.c.pjbnl003
#         ON ACTION controlp INFIELD pjbnl003
            #add-point:ON ACTION controlp INFIELD pjbnl003
            {<point name="input.c.pjbnl003" />}
            #END add-point

         #----<<pjbnl004>>----
         #Ctrlp:input.c.pjbnl004
#         ON ACTION controlp INFIELD pjbnl004
            #add-point:ON ACTION controlp INFIELD pjbnl004
            {<point name="input.c.pjbnl004" />}
            #END add-point

         #----<<pjbn003>>----
         #Ctrlp:input.c.pjbn003
         ON ACTION controlp INFIELD pjbn003
            #add-point:ON ACTION controlp INFIELD pjbn003
#此段落由子樣板a07產生
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn003             #給予default值
            LET g_qryparam.where = " pjbn002 = 'Y'"
            #給予arg

            CALL q_pjba001()                                #呼叫開窗

            LET g_pjbn_m.pjbn003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn003 TO pjbn003              #顯示到畫面上
            CALL apjm300_pjbn003_desc(g_pjbn_m.pjbn003)
            NEXT FIELD pjbn003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbn004>>----
         #Ctrlp:input.c.pjbn004
         ON ACTION controlp INFIELD pjbn004
            #add-point:ON ACTION controlp INFIELD pjbn004
#此段落由子樣板a07產生
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "ALL" #

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pjbn_m.pjbn004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn004 TO pjbn004              #顯示到畫面上
            CALL apjm300_pjbn004_desc(g_pjbn_m.pjbn004)
            NEXT FIELD pjbn004                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbn005>>----
         #Ctrlp:input.c.pjbn005
#         ON ACTION controlp INFIELD pjbn005
            #add-point:ON ACTION controlp INFIELD pjbn005
            {<point name="input.c.pjbn005" />}
            #END add-point

         #----<<pjbn006>>----
         #Ctrlp:input.c.pjbn006
#         ON ACTION controlp INFIELD pjbn006
            #add-point:ON ACTION controlp INFIELD pjbn006
            {<point name="input.c.pjbn006" />}
            #END add-point

         #----<<pjbnstus>>----
         #Ctrlp:input.c.pjbnstus
#         ON ACTION controlp INFIELD pjbnstus
            #add-point:ON ACTION controlp INFIELD pjbnstus
            {<point name="input.c.pjbnstus" />}
            #END add-point

         #----<<pjbn007>>----
         #Ctrlp:input.c.pjbn007
#         ON ACTION controlp INFIELD pjbn007
            #add-point:ON ACTION controlp INFIELD pjbn007
            {<point name="input.c.pjbn007" />}
            #END add-point

         #----<<pjbn008>>----
         #Ctrlp:input.c.pjbn008
         ON ACTION controlp INFIELD pjbn008
            #add-point:ON ACTION controlp INFIELD pjbn008
#此段落由子樣板a07產生
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '4'

            CALL q_ooal002_0()                                #呼叫開窗

            LET g_pjbn_m.pjbn008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn008 TO pjbn008              #顯示到畫面上
            CALL apjm300_pjbn008_desc(g_pjbn_m.pjbn008)
            NEXT FIELD pjbn008                          #返回原欄位

          {#ADP版次:1#}
            #END add-point
         ON ACTION controlp INFIELD pjbn010
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a07產生
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8006" #
           
            CALL q_oocq002()                                     #呼叫開窗

            LET g_pjbn_m.pjbn010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn010 TO pjbn010             #顯示到畫面上

            NEXT FIELD pjbn010 

         ON ACTION controlp INFIELD pjbn014
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a07產生
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbn_m.pjbn014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8007" #
           
            CALL q_oocq002()                                     #呼叫開窗

            LET g_pjbn_m.pjbn014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbn_m.pjbn014 TO pjbn014              #顯示到畫面上

            NEXT FIELD pjbn014         


 #欄位開窗

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_pjbo_m.pjbo001
                            ,g_pjbo_m.pjbo002



            IF p_cmd <> 'u' THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM pjbn_t
                WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
                  AND pjbn900 = g_pjbn_m.pjbn900

               IF l_count = 0 THEN
#                  IF NOT cl_null(g_pjbn_m.pjbn003) THEN
#                     IF NOT apjm300_pjbn003_copy() THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "g_pjbn_m"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CONTINUE DIALOG
#                     ELSE
##                        IF NOT apjm300_open_s01(g_pjbn_m.pjbn001,g_pjbn_m.pjbn003) THEN
##                           INITIALIZE g_errparam TO NULL
##                           LET g_errparam.code = SQLCA.sqlcode
##                           LET g_errparam.extend = "g_pjbn_m"
##                           LET g_errparam.popup = TRUE
##                           CALL cl_err()
##
##                           CALL s_transaction_end('N','0')
##                           CONTINUE DIALOG
##                        ELSE
##                           CALL s_transaction_end('Y','0')
##                           LET g_copy_flag = 'Y'
##                           LET g_copy_pjbn001 = g_pjbn_m.pjbn001
##                           EXIT DIALOG
##                        END IF
#                     END IF
#                  END IF
                #  CALL s_aooi390_oofi_upd('15',g_pjbn_m.pjbn001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
#                  INSERT INTO pjbn_t (pjbnent,pjbn000,pjbn001,pjbn900,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt)
#                  VALUES (g_enterprise,g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
#                          g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt) # DISK WRITE

                  #add-point:單頭新增中
                  {<point name="input.head.m_insert"/>}
                  #end add-point

#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "g_pjbn_m"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                     CONTINUE DIALOG
#                  END IF
                  
#                  IF cl_null(g_pjbn_m.pjbn003) THEN
#                     IF NOT apjm300_pjbo_ins() THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "g_pjbn_m"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CONTINUE DIALOG
#                     END IF
#                  END IF
                  
                              #  CALL apjm300_pjbn_t('u')
                  INITIALIZE l_var_keys TO NULL
                  INITIALIZE l_field_keys TO NULL
                  INITIALIZE l_vars TO NULL
                  INITIALIZE l_fields TO NULL
                  IF g_pjbn_m.pjbn001 = g_master_multi_table_t.pjbnl001 AND g_pjbn_m.pjbn900 = g_master_multi_table_t.pjbnl900 AND 
                     g_pjbn_m.pjbnl003 = g_master_multi_table_t.pjbnl003 AND
                     g_pjbn_m.pjbnl004 = g_master_multi_table_t.pjbnl004  THEN
                  ELSE
                     LET l_var_keys[01] = g_pjbn_m.pjbn001
                     LET l_field_keys[01] = 'pjbnl001'
                     LET l_var_keys_bak[01] = g_master_multi_table_t.pjbnl001
                     #add by lixh
                     LET l_var_keys[02] = g_pjbn_m.pjbn900
                     LET l_field_keys[02] = 'pjbnl900'
                     LET l_var_keys_bak[02] = g_master_multi_table_t.pjbnl900
                     
                     LET l_var_keys[03] = g_dlang
                     LET l_field_keys[03] = 'pjbnl002'
                     LET l_var_keys_bak[03] = g_dlang
                     
                     LET l_vars[01] = g_pjbn_m.pjbnl003
                     LET l_fields[01] = 'pjbnl003'
                     LET l_vars[02] = g_pjbn_m.pjbnl004
                     LET l_fields[02] = 'pjbnl004'
                     LET l_vars[03] = g_enterprise
                     LET l_fields[03] = 'pjbnlent'
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbnl_t')
                  END IF
         
                  #新增專案變更歷程檔並修改單頭變更否欄位
                  IF NOT apjm300_upd_pjbn901() THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')

                  IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                     CALL apjm300_detail_reproduce()
                  END IF

#                  LET p_cmd = 'u'
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '!'
                  LET g_errparam.extend =  g_pjbn_m.pjbn001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  NEXT FIELD pjbn001
               END IF
            ELSE

               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point

               UPDATE pjbn_t SET (pjbnent,pjbn000,pjbn001,pjbn900,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt) 
                               = (g_enterprise,g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
                                  g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt)
                WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn001_t AND pjbn900 = g_pjbn900_t


               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbn_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE
                               #    CALL apjm300_pjbn_t('u')
                      INITIALIZE l_var_keys TO NULL
                      INITIALIZE l_field_keys TO NULL
                      INITIALIZE l_vars TO NULL
                      INITIALIZE l_fields TO NULL
                 IF g_pjbn_m.pjbn001 = g_master_multi_table_t.pjbnl001 AND g_pjbn_m.pjbn900 = g_master_multi_table_t.pjbnl900 AND
                    g_pjbn_m.pjbnl003 = g_master_multi_table_t.pjbnl003 AND
                    g_pjbn_m.pjbnl004 = g_master_multi_table_t.pjbnl004  THEN
                 ELSE
                    LET l_var_keys[01] = g_pjbn_m.pjbn001
                    LET l_field_keys[01] = 'pjbnl001'
                    LET l_var_keys_bak[01] = g_master_multi_table_t.pjbnl001
                     #add by lixh
                    LET l_var_keys[02] = g_pjbn_m.pjbn900
                    LET l_field_keys[02] = 'pjbnl900'
                    LET l_var_keys_bak[02] = g_master_multi_table_t.pjbnl900     
                     #add by lixh
                    LET l_var_keys[03] = g_dlang
                    LET l_field_keys[03] = 'pjbnl002'
                    LET l_var_keys_bak[03] = g_dlang
                    LET l_vars[01] = g_pjbn_m.pjbnl003
                    LET l_fields[01] = 'pjbnl003'
                    LET l_vars[02] = g_pjbn_m.pjbnl004
                    LET l_fields[02] = 'pjbnl004'
                    LET l_vars[03] = g_enterprise
                    LET l_fields[03] = 'pjbnlent'
                    CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbnl_t')
                 END IF
#          INITIALIZE l_var_keys TO NULL
#         INITIALIZE l_field_keys TO NULL
#         INITIALIZE l_vars TO NULL
#         INITIALIZE l_fields TO NULL
#         IF g_pjbo_m.pjbo001 = g_master_multi_table_t.pjbol001_idx2 AND
#         g_pjbo_m.pjbo002 = g_master_multi_table_t.pjbol002_idx2 AND
#         g_pjbo_m.pjbol004 = g_master_multi_table_t.pjbol004_idx2 AND
#         g_pjbo_m.pjbol005 = g_master_multi_table_t.pjbol005_idx2  THEN
#         ELSE
#            LET l_var_keys[01] = g_pjbo_m.pjbo001
#            LET l_field_keys[01] = 'pjbol001'
#            LET l_var_keys_bak[01] = g_master_multi_table_t.pjbol001_idx2
#            LET l_var_keys[02] = g_pjbo_m.pjbo002
#            LET l_field_keys[02] = 'pjbol002'
#            LET l_var_keys_bak[02] = g_master_multi_table_t.pjbol002_idx2
#            LET l_var_keys[03] = g_dlang
#            LET l_field_keys[03] = 'pjbol003'
#            LET l_var_keys_bak[03] = g_dlang
#            LET l_vars[01] = g_pjbo_m.pjbol004
#            LET l_fields[01] = 'pjbol004'
#            LET l_vars[02] = g_pjbo_m.pjbol005
#            LET l_fields[02] = 'pjbol005'
#            LET l_vars[03] = g_enterprise
#            LET l_fields[03] = 'pjbolent'
#            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbol_t')
#         END IF

                     #add-point:單頭修改後
                     #新增專案變更歷程檔並修改單頭變更否欄位
                     IF NOT apjm300_upd_pjbn901() THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE

            END IF
            CALL apjm300_head_color()
            LET g_pjbn001_t = g_pjbn_m.pjbn001
            LET g_pjbn900_t = g_pjbn_m.pjbn900


           #controlp
      END INPUT
  
      






      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   #add-point:input段after input
   {<point name="input.after_input"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION apjm300_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE l_sql     STRING
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point

 
   LET g_pjbn_m_t.* = g_pjbn_m.*
   LET g_pjbo_m_t.* = g_pjbo_m.*      #保存單頭舊值
   
   CALL s_desc_get_person_desc(g_pjbn_m.pjbnownid) RETURNING g_pjbn_m.pjbnownid_desc
   CALL s_desc_get_person_desc(g_pjbn_m.pjbncrtid) RETURNING g_pjbn_m.pjbncrtid_desc   
   CALL s_desc_get_person_desc(g_pjbn_m.pjbnmodid) RETURNING g_pjbn_m.pjbnmodid_desc
   CALL s_desc_get_person_desc(g_pjbn_m.pjbncnfid) RETURNING g_pjbn_m.pjbncnfid_desc
   CALL s_desc_get_department_desc(g_pjbn_m.pjbnowndp) RETURNING g_pjbn_m.pjbnowndp_desc
   CALL s_desc_get_department_desc(g_pjbn_m.pjbncrtdp) RETURNING g_pjbn_m.pjbncrtdp_desc
   
   DISPLAY BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn000_desc,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,
                   g_pjbn_m.pjbn003,g_pjbn_m.pjbn003_desc,g_pjbn_m.pjbn004,g_pjbn_m.pjbn004_desc,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbnstus,
                   g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn008_desc,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnownid_desc,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbnowndp_desc,
                   g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtid_desc,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdp_desc,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmodid_desc,
                   g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfid_desc,g_pjbn_m.pjbncnfdt,g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,
                   g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,
                   g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,
                   g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn012_desc,g_pjbn_m.pjbn013

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_pjbn_m.pjbnstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")


		
      END CASE



   IF g_bfill = "Y" THEN
      CALL apjm300_b_fill()                 #單身
   END IF

   LET l_ac_t = l_ac


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbo_m.pjbo001
            LET g_ref_fields[2] = g_pjbo_m.pjbo002
            LET g_ref_fields[3] = g_pjbn_m.pjbn900
            CALL ap_ref_array2(g_ref_fields," SELECT pjbol004,pjbol005 FROM pjbol_t WHERE pjbolent = '"||g_enterprise||"' AND pjbol001 = ? AND pjbol002 = ? AND pjbol900 = ? AND pjbol003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbo_m.pjbol004 = g_rtn_fields[1]
            LET g_pjbo_m.pjbol005 = g_rtn_fields[2]
            DISPLAY g_pjbo_m.pjbol004 TO pjbol004
            DISPLAY g_pjbo_m.pjbol005 TO pjbol005
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbo_m.pjbo004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbo_m.pjbo004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbo_m.pjbo004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbo_m.pjbo003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbo_m.pjbo003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbo_m.pjbo003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbo_m.pjbo010
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pjbo_m.pjbo010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbo_m.pjbo010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbo_m.pjbo011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbo_m.pjbo011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbo_m.pjbo011_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbn_m.pjbn001
            LET g_ref_fields[2] = g_pjbn_m.pjbn900
            CALL ap_ref_array2(g_ref_fields," SELECT pjbnl003,pjbnl004 FROM pjbnl_t WHERE pjbnlent = '"||g_enterprise||"' AND pjbnl001 = ? AND pjbnl900 = ? AND pjbnl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbn_m.pjbnl003 = g_rtn_fields[1]
            LET g_pjbn_m.pjbnl004 = g_rtn_fields[2]
            DISPLAY BY NAME g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbn_m.pjbn000
            CALL ap_ref_array2(g_ref_fields,"SELECT pjaal003 FROM pjaal_t WHERE pjaalent='"||g_enterprise||"' AND pjaal001=? AND pjaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbn_m.pjbn000_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbn_m.pjbn000_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbn_m.pjbn003
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbnl003 FROM pjbnl_t WHERE pjbnlent='"||g_enterprise||"' AND pjbnl001=? AND pjbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbn_m.pjbn003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbn_m.pjbn003_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbn_m.pjbn004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbn_m.pjbn004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbn_m.pjbn004_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbn_m.pjbn008
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbn_m.pjbn008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbn_m.pjbn008_desc
   #end add-point

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_pjbq_d.getLength()

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq_d[l_ac].pjbq004
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq_d[l_ac].pjbq004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq_d[l_ac].pjbq004_desc

            CALL apjm300_pjbq005_desc(g_pjbq_d[l_ac].pjbq005)

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq_d[l_ac].pjbq006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq_d[l_ac].pjbq006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq_d[l_ac].pjbq006_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_pjbq2_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq2_d[l_ac].pjbr003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq2_d[l_ac].pjbr003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq2_d[l_ac].pjbr003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_pjbq3_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq3_d[l_ac].pjbs003
            CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrba001=? ","") RETURNING g_rtn_fields
            LET g_pjbq3_d[l_ac].pjbs003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq3_d[l_ac].pjbs003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq3_d[l_ac].pjbs004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq3_d[l_ac].pjbs004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq3_d[l_ac].pjbs004_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_pjbq4_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq4_d[l_ac].pjbt003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8003' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq4_d[l_ac].pjbt003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq4_d[l_ac].pjbt003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_pjbq5_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq5_d[l_ac].pjbp002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq5_d[l_ac].pjbp002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq5_d[l_ac].pjbp002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq5_d[l_ac].pjbp003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pjbq5_d[l_ac].pjbp003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq5_d[l_ac].pjbp003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR





   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後
   CALL apjm300_head_color()  
   CALL s_apjm300_hint_show('pjbu_t','pjbn_t','pjba_t',g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900)
   CALL s_apjm300_hint_show('pjbu_t','pjbnl_t','pjbal_t',g_pjbn_m.pjbn001,'0',g_lang,g_pjbn_m.pjbn900)   
   IF g_detail_idx > 0 THEN 
      CALL s_apjm300_hint_show("pjbu_t","pjbo_t","pjbb_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900)
      CALL s_apjm300_hint_show("pjbu_t","pjbol_t","pjbbl_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_lang,g_pjbn_m.pjbn900)
      CALL s_apjm300_hint_show("pjbu_t","pjbp_t","pjbc_t",g_pjbn_m.pjbn001,g_pjbq5_d[g_detail_idx].pjbp002,g_pjbq5_d[g_detail_idx].pjbp003,g_pjbn_m.pjbn900)
   END IF 
   IF g_detail_idx2 > 0 THEN    
      CALL s_apjm300_hint_show("pjbu_t","pjbq_t","pjbd_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[g_detail_idx2].pjbq003,g_pjbn_m.pjbn900)
      CALL s_apjm300_hint_show("pjbu_t","pjbr_t","pjbe_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[g_detail_idx2].pjbr003,g_pjbn_m.pjbn900)
      CALL s_apjm300_hint_show("pjbu_t","pjbs_t","pjbf_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[g_detail_idx2].pjbs003,g_pjbn_m.pjbn900)
      CALL s_apjm300_hint_show("pjbu_t","pjbt_t","pjbg_t",g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[g_detail_idx2].pjbt003,g_pjbn_m.pjbn900)   
   END IF 
   #end add-point
   CALL apjm300_set_act_visible()
   CALL apjm300_set_act_no_visible()
END FUNCTION

PRIVATE FUNCTION apjm300_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE pjbo_t.pjbo001
   DEFINE l_oldno     LIKE pjbo_t.pjbo001
   DEFINE l_newno02     LIKE pjbo_t.pjbo002
   DEFINE l_oldno02     LIKE pjbo_t.pjbo002


   #DEFINE l_master    RECORD LIKE pjbo_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_master RECORD  #專案WBS變更單身檔
       pjboent LIKE pjbo_t.pjboent, #企业编号
       pjbo001 LIKE pjbo_t.pjbo001, #项目编号
       pjbo002 LIKE pjbo_t.pjbo002, #本阶WBS
       pjbo003 LIKE pjbo_t.pjbo003, #上阶WBS
       pjbo004 LIKE pjbo_t.pjbo004, #WBS类型
       pjbo005 LIKE pjbo_t.pjbo005, #计划起始日
       pjbo006 LIKE pjbo_t.pjbo006, #计划截止日
       pjbo007 LIKE pjbo_t.pjbo007, #工期天数
       pjbo008 LIKE pjbo_t.pjbo008, #工期时数
       pjbo009 LIKE pjbo_t.pjbo009, #里程碑
       pjbo010 LIKE pjbo_t.pjbo010, #负责人员
       pjbo011 LIKE pjbo_t.pjbo011, #负责部门
       pjbo012 LIKE pjbo_t.pjbo012, #状态码
       pjbo900 LIKE pjbo_t.pjbo900, #变更序
       pjbo901 LIKE pjbo_t.pjbo901, #变更类型
       pjbo902 LIKE pjbo_t.pjbo902, #变更日期
       pjbo903 LIKE pjbo_t.pjbo903, #变更理由
       pjbo904 LIKE pjbo_t.pjbo904, #变更备注
       pjbo013 LIKE pjbo_t.pjbo013, #发包总额
       pjbo014 LIKE pjbo_t.pjbo014, #未结案发包总额
       pjbo015 LIKE pjbo_t.pjbo015, #结案发包总额
       pjbo016 LIKE pjbo_t.pjbo016 #发包开账金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
   #DEFINE l_detail    RECORD LIKE pjbq_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail RECORD  #專案WBS材料預算變更檔
       pjbqent LIKE pjbq_t.pjbqent, #企业编号
       pjbq001 LIKE pjbq_t.pjbq001, #项目编号
       pjbq002 LIKE pjbq_t.pjbq002, #本阶WBS
       pjbq003 LIKE pjbq_t.pjbq003, #项次
       pjbq004 LIKE pjbq_t.pjbq004, #产品分类
       pjbq005 LIKE pjbq_t.pjbq005, #限定料号
       pjbq006 LIKE pjbq_t.pjbq006, #单位
       pjbq007 LIKE pjbq_t.pjbq007, #数量
       pjbq008 LIKE pjbq_t.pjbq008, #单价
       pjbq009 LIKE pjbq_t.pjbq009, #金额
       pjbq010 LIKE pjbq_t.pjbq010, #补充说明
       pjbq900 LIKE pjbq_t.pjbq900, #变更序
       pjbq901 LIKE pjbq_t.pjbq901, #变更类型
       pjbq902 LIKE pjbq_t.pjbq902, #变更日期
       pjbq903 LIKE pjbq_t.pjbq903, #变更理由
       pjbq904 LIKE pjbq_t.pjbq904, #变更备注
       pjbq020 LIKE pjbq_t.pjbq020, #本币税额
       pjbq021 LIKE pjbq_t.pjbq021, #产品特征
       pjbq019 LIKE pjbq_t.pjbq019, #本币含税金额
       pjbq011 LIKE pjbq_t.pjbq011, #已转请购量
       pjbq012 LIKE pjbq_t.pjbq012, #币种
       pjbq013 LIKE pjbq_t.pjbq013, #汇率
       pjbq014 LIKE pjbq_t.pjbq014, #税种
       pjbq015 LIKE pjbq_t.pjbq015, #税率
       pjbq016 LIKE pjbq_t.pjbq016, #原币含税金额
       pjbq017 LIKE pjbq_t.pjbq017, #原币税额
       pjbq018 LIKE pjbq_t.pjbq018 #本币税前金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   {<point name="reproduce.define"/>}
   #end add-point

   IF g_pjbo_m.pjbo001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   LET g_pjbn001_t = g_pjbn_m.pjbn001
   LET g_pjbn900_t = g_pjbn_m.pjbn900


   LET g_pjbn_m.pjbn001 = ""

   CALL apjm300_set_entry('a')
   CALL apjm300_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

   #公用欄位給予預設值
   #此段落由子樣板a14產生
      LET g_pjbn_m.pjbnownid = g_user
      LET g_pjbn_m.pjbnowndp = g_dept
      LET g_pjbn_m.pjbncrtid = g_user
      LET g_pjbn_m.pjbncrtdp = g_dept
      LET g_pjbn_m.pjbncrtdt = cl_get_current()
      LET g_pjbn_m.pjbnmodid = ""
      LET g_pjbn_m.pjbnmoddt = ""
      LET g_pjbn_m.pjbnstus = "N"



   #add-point:複製輸入前
   {<point name="reproduce.head.b_input"/>}
   #end add-point

   CALL apjm300_input("r")



   #add-point:完成複製段落後
   {<point name="reproduce.after_reproduce" />}
   #end add-point

END FUNCTION

PRIVATE FUNCTION apjm300_detail_reproduce()
   {<Local define>}
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   #DEFINE l_detail    RECORD LIKE pjbq_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail RECORD  #專案WBS材料預算變更檔
       pjbqent LIKE pjbq_t.pjbqent, #企业编号
       pjbq001 LIKE pjbq_t.pjbq001, #项目编号
       pjbq002 LIKE pjbq_t.pjbq002, #本阶WBS
       pjbq003 LIKE pjbq_t.pjbq003, #项次
       pjbq004 LIKE pjbq_t.pjbq004, #产品分类
       pjbq005 LIKE pjbq_t.pjbq005, #限定料号
       pjbq006 LIKE pjbq_t.pjbq006, #单位
       pjbq007 LIKE pjbq_t.pjbq007, #数量
       pjbq008 LIKE pjbq_t.pjbq008, #单价
       pjbq009 LIKE pjbq_t.pjbq009, #金额
       pjbq010 LIKE pjbq_t.pjbq010, #补充说明
       pjbq900 LIKE pjbq_t.pjbq900, #变更序
       pjbq901 LIKE pjbq_t.pjbq901, #变更类型
       pjbq902 LIKE pjbq_t.pjbq902, #变更日期
       pjbq903 LIKE pjbq_t.pjbq903, #变更理由
       pjbq904 LIKE pjbq_t.pjbq904, #变更备注
       pjbq020 LIKE pjbq_t.pjbq020, #本币税额
       pjbq021 LIKE pjbq_t.pjbq021, #产品特征
       pjbq019 LIKE pjbq_t.pjbq019, #本币含税金额
       pjbq011 LIKE pjbq_t.pjbq011, #已转请购量
       pjbq012 LIKE pjbq_t.pjbq012, #币种
       pjbq013 LIKE pjbq_t.pjbq013, #汇率
       pjbq014 LIKE pjbq_t.pjbq014, #税种
       pjbq015 LIKE pjbq_t.pjbq015, #税率
       pjbq016 LIKE pjbq_t.pjbq016, #原币含税金额
       pjbq017 LIKE pjbq_t.pjbq017, #原币税额
       pjbq018 LIKE pjbq_t.pjbq018 #本币税前金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
   #DEFINE l_detail2    RECORD LIKE pjbr_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail2 RECORD  #專案WBS人力預算變更檔
       pjbrent LIKE pjbr_t.pjbrent, #企业编号
       pjbr001 LIKE pjbr_t.pjbr001, #项目编号
       pjbr002 LIKE pjbr_t.pjbr002, #本阶WBS
       pjbr003 LIKE pjbr_t.pjbr003, #项目角色
       pjbr004 LIKE pjbr_t.pjbr004, #时数
       pjbr005 LIKE pjbr_t.pjbr005, #天数
       pjbr006 LIKE pjbr_t.pjbr006, #职能成本单价(时)
       pjbr007 LIKE pjbr_t.pjbr007, #职能成本单价(天)
       pjbr008 LIKE pjbr_t.pjbr008, #职能成本金额
       pjbr009 LIKE pjbr_t.pjbr009, #备注
       pjbr900 LIKE pjbr_t.pjbr900, #变更序
       pjbr901 LIKE pjbr_t.pjbr901, #变更类型
       pjbr902 LIKE pjbr_t.pjbr902, #变更日期
       pjbr903 LIKE pjbr_t.pjbr903, #变更理由
       pjbr904 LIKE pjbr_t.pjbr904, #变更备注
       pjbr010 LIKE pjbr_t.pjbr010, #税种
       pjbr011 LIKE pjbr_t.pjbr011, #税率
       pjbr012 LIKE pjbr_t.pjbr012, #原币含税金额
       pjbr013 LIKE pjbr_t.pjbr013, #本币税前金额
       pjbr014 LIKE pjbr_t.pjbr014 #本币含税金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)

   #DEFINE l_detail3    RECORD LIKE pjbs_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail3 RECORD  #專案WBS設備預算變更檔
       pjbsent LIKE pjbs_t.pjbsent, #企业编号
       pjbs001 LIKE pjbs_t.pjbs001, #项目编号
       pjbs002 LIKE pjbs_t.pjbs002, #本阶WBS
       pjbs003 LIKE pjbs_t.pjbs003, #限定机器
       pjbs004 LIKE pjbs_t.pjbs004, #耗用单位
       pjbs005 LIKE pjbs_t.pjbs005, #耗用数量
       pjbs006 LIKE pjbs_t.pjbs006, #单位成本率
       pjbs007 LIKE pjbs_t.pjbs007, #金额
       pjbs008 LIKE pjbs_t.pjbs008, #备注
       pjbs900 LIKE pjbs_t.pjbs900, #变更序
       pjbs901 LIKE pjbs_t.pjbs901, #变更类型
       pjbs902 LIKE pjbs_t.pjbs902, #变更日期
       pjbs903 LIKE pjbs_t.pjbs903, #变更理由
       pjbs904 LIKE pjbs_t.pjbs904, #变更备注
       pjbs009 LIKE pjbs_t.pjbs009, #税种
       pjbs010 LIKE pjbs_t.pjbs010, #税率
       pjbs011 LIKE pjbs_t.pjbs011, #原币含税金额
       pjbs012 LIKE pjbs_t.pjbs012, #本币税前金额
       pjbs013 LIKE pjbs_t.pjbs013, #本币含税金额
       pjbs014 LIKE pjbs_t.pjbs014 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)

   #DEFINE l_detail4    RECORD LIKE pjbt_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail4 RECORD  #專案WBS費用預算變更檔
       pjbtent LIKE pjbt_t.pjbtent, #企业编号
       pjbt001 LIKE pjbt_t.pjbt001, #项目编号
       pjbt002 LIKE pjbt_t.pjbt002, #本阶WBS
       pjbt003 LIKE pjbt_t.pjbt003, #费用类型
       pjbt004 LIKE pjbt_t.pjbt004, #金额
       pjbt005 LIKE pjbt_t.pjbt005, #备注
       pjbt900 LIKE pjbt_t.pjbt900, #变更序
       pjbt901 LIKE pjbt_t.pjbt901, #变更类型
       pjbt902 LIKE pjbt_t.pjbt902, #变更日期
       pjbt903 LIKE pjbt_t.pjbt903, #变更理由
       pjbt904 LIKE pjbt_t.pjbt904, #变更备注
       pjbt006 LIKE pjbt_t.pjbt006, #税种
       pjbt007 LIKE pjbt_t.pjbt007, #税率
       pjbt008 LIKE pjbt_t.pjbt008, #原币含税金额
       pjbt009 LIKE pjbt_t.pjbt009, #本币税前金额
       pjbt010 LIKE pjbt_t.pjbt010, #本币含税金额
       pjbt011 LIKE pjbt_t.pjbt011 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)

   #DEFINE l_detail5    RECORD LIKE pjbp_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_detail5 RECORD  #專案成員變更檔
       pjbpent LIKE pjbp_t.pjbpent, #企业编号
       pjbp001 LIKE pjbp_t.pjbp001, #项目编号
       pjbp002 LIKE pjbp_t.pjbp002, #项目角色
       pjbp003 LIKE pjbp_t.pjbp003, #员工编号
       pjbp004 LIKE pjbp_t.pjbp004, #生效日期
       pjbp005 LIKE pjbp_t.pjbp005, #失效日期
       pjbp006 LIKE pjbp_t.pjbp006, #备注
       pjbp900 LIKE pjbp_t.pjbp900, #变更序
       pjbp901 LIKE pjbp_t.pjbp901, #变更类型
       pjbp902 LIKE pjbp_t.pjbp902, #变更日期
       pjbp903 LIKE pjbp_t.pjbp903, #变更理由
       pjbp904 LIKE pjbp_t.pjbp904 #变更备注
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)


   {</Local define>}
   #add-point:delete段define
   {<point name="detail_reproduce.define"/>}
   #end add-point

   CALL s_transaction_begin()

   LET ld_date = cl_get_current()

   DROP TABLE apjm300_detail

   #add-point:單身複製前1
   {<point name="detail_reproduce.body.table1.b_insert" mark="Y"/>}
   #end add-point

   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
                "SELECT * FROM pjbq_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbq_t
                                         WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbn001_t
                                           AND pjbq900 = g_pjbn900_t



   #將key修正為調整後
   UPDATE apjm300_detail
      #更新key欄位
      SET pjbq001 = g_pjbn_m.pjbn001,
          pjbq900 = g_pjbn_m.pjbn900

      #更新共用欄位



   #將資料塞回原table
   INSERT INTO pjbq_t SELECT * FROM apjm300_detail

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF



   #刪除TEMP TABLE
   DROP TABLE apjm300_detail



   #CREATE TEMP TABLE
   LET ls_sql =
      "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
      "SELECT * FROM pjbr_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbr_t
                                         WHERE pjbrent = g_enterprise AND pjbr001 = g_pjbn001_t
                                           AND pjbr900 = g_pjbn900_t    


   #將key修正為調整後
   UPDATE apjm300_detail SET pjbr001 = g_pjbn_m.pjbn001,pjbr900 = g_pjbn_m.pjbn900
    



   #將資料塞回原table
   INSERT INTO pjbr_t SELECT * FROM apjm300_detail



   #刪除TEMP TABLE
   DROP TABLE apjm300_detail





   #CREATE TEMP TABLE
   LET ls_sql =
      "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
      "SELECT * FROM pjbs_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbs_t
                                         WHERE pjbsent = g_enterprise AND pjbs001 = g_pjbn001_t  AND pjbs900 = g_pjbn900_t
                               



   #將key修正為調整後
   UPDATE apjm300_detail SET pjbs001 = g_pjbn_m.pjbn001,
                             pjbs900 = g_pjbn_m.pjbn900



   #將資料塞回原table
   INSERT INTO pjbs_t SELECT * FROM apjm300_detail



   #刪除TEMP TABLE
   DROP TABLE apjm300_detail



   #CREATE TEMP TABLE
   LET ls_sql =
      "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
      "SELECT * FROM pjbt_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbt_t
                                         WHERE pjbtent = g_enterprise AND pjbt001 = g_pjbn001_t
                                           AND pjbt900 = g_pjbn900_t



   #將key修正為調整後
   UPDATE apjm300_detail SET pjbt001 = g_pjbn_m.pjbn001,pjbt900 = g_pjbn_m.pjbn900
                                   



   #將資料塞回原table
   INSERT INTO pjbt_t SELECT * FROM apjm300_detail



   #刪除TEMP TABLE
   DROP TABLE apjm300_detail



   #CREATE TEMP TABLE
   LET ls_sql =
      "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
      "SELECT * FROM pjbp_t "
   PREPARE repro_tbl5 FROM ls_sql
   EXECUTE repro_tbl5
   FREE repro_tbl5

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbp_t
                                         WHERE pjbpent = g_enterprise AND pjbp001 = g_pjbn001_t
                                           AND pjbp001 = g_pjbn900_t

   #將key修正為調整後
   UPDATE apjm300_detail SET pjbp001 = g_pjbn_m.pjbn001,pjbp900 = g_pjbn_m.pjbn900
                                 

   #將資料塞回原table
   INSERT INTO pjbp_t SELECT * FROM apjm300_detail

   #刪除TEMP TABLE
   DROP TABLE apjm300_detail


   #CREATE TEMP TABLE
   LET ls_sql =
      "CREATE GLOBAL TEMPORARY TABLE apjm300_detail AS ",
      "SELECT * FROM pjbo_t "
   PREPARE repro_tbl6 FROM ls_sql
   EXECUTE repro_tbl6
   FREE repro_tbl6

   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apjm300_detail SELECT * FROM pjbo_t
                                         WHERE pjboent = g_enterprise AND pjbo001 = g_pjbn001_t
                                           AND pjbo900 = g_pjbn900_t
   #將key修正為調整後
   UPDATE apjm300_detail SET pjbo001 = g_pjbn_m.pjbn001,pjbo900 = g_pjbn_m.pjbn900
                                 

   #將資料塞回原table
   INSERT INTO pjbo_t SELECT * FROM apjm300_detail
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF 
   UPDATE pjbo_t SET pjbo012 = '0' 
      WHERE pjboent = g_enterprise AND pjbo001 = g_pjbn001_t  AND pjbo900 = g_pjbn900_t
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF 
   #刪除TEMP TABLE
   DROP TABLE apjm300_detail

   #多語言複製段落


   CALL s_transaction_end('Y','0')

   #已新增完, 調整資料內容(修改時使用)
   LET g_pjbn001_t = g_pjbn_m.pjbn001
   LET g_pjbn900_t = g_pjbn_m.pjbn900



   DROP TABLE apjm300_detail

END FUNCTION

PRIVATE FUNCTION apjm300_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   {<point name="delete.define"/>}
   #end add-point

   IF g_pjbn_m.pjbn001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT apjm300_action_chk() THEN
      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

    SELECT UNIQUE pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt
             INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
                  g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt
             FROM pjbn_t
            WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
              AND pjbn900 = g_pjbn_m.pjbn900
              
   CALL s_transaction_begin()

   LET g_master_multi_table_t.pjbnl001 = g_pjbn_m.pjbn001
   LET g_master_multi_table_t.pjbnl900 = g_pjbn_m.pjbn900
   LET g_master_multi_table_t.pjbnl003 = g_pjbn_m.pjbnl003
   LET g_master_multi_table_t.pjbnl004 = g_pjbn_m.pjbnl004
   LET g_master_multi_table_t.pjbol001_idx2 = g_pjbo_m.pjbo001
   LET g_master_multi_table_t.pjbol900_idx2 = g_pjbn_m.pjbn900
   LET g_master_multi_table_t.pjbol002_idx2 = g_pjbo_m.pjbo002
   LET g_master_multi_table_t.pjbol004_idx2 = g_pjbo_m.pjbol004
   LET g_master_multi_table_t.pjbol005_idx2 = g_pjbo_m.pjbol005


   OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                               


   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apjm300_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   FETCH apjm300_cl INTO  g_pjbn_m.pjbn000,g_pjbn_m.pjbn000_desc,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,g_pjbn_m.pjbn003,g_pjbn_m.pjbn003_desc,g_pjbn_m.pjbn004,g_pjbn_m.pjbn004_desc,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn008_desc,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnownid_desc,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbnowndp_desc,g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtid_desc,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdp_desc,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmodid_desc,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfid_desc,g_pjbn_m.pjbncnfdt,g_pjbn_m.pjbnstus              # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_pjbo_m.pjbo001
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF

   CALL apjm300_show()

   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "pjbn001"
      LET g_doc.value1 = g_pjbn_m.pjbn001
     #CALL cl_del_doc()

      #資料備份
      LET g_pjbn001_t = g_pjbn_m.pjbn001
      LET g_pjbn900_t = g_pjbn_m.pjbn900


      #add-point:單頭刪除前
      {<point name="delete.head.b_delete" mark="Y"/>}
      #end add-point
      
      DELETE FROM pjbn_t 
       WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
         AND pjbn900 = g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_pjbn_m.pjbn001
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbnl_t 
       WHERE pjbnlent = g_enterprise AND pjbnl001 = g_pjbn_m.pjbn001
         AND pjbnl900 = g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_pjbn_m.pjbn001
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbo_t
       WHERE pjboent = g_enterprise AND pjbo001 = g_pjbn_m.pjbn001
         AND pjbo900 = g_pjbn_m.pjbn900

    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_pjbo_m.pjbo001
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbol_t
       WHERE pjbolent = g_enterprise AND pjbol001 = g_pjbn_m.pjbn001
         AND pjbol900 = g_pjbn_m.pjbn900
    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_pjbo_m.pjbo001
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbq_t
       WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbn_m.pjbn001 AND pjbq900 = g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbq_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbr_t
       WHERE pjbrent = g_enterprise 
         AND pjbr001 = g_pjbn_m.pjbn001 
         AND pjbr900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pjbs_t
       WHERE pjbsent = g_enterprise AND
             pjbs001 = g_pjbn_m.pjbn001 AND pjbs900 = g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbt_t
       WHERE pjbtent = g_enterprise AND
             pjbt001 = g_pjbn_m.pjbn001 AND pjbt900 = g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbt_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF

      DELETE FROM pjbp_t
       WHERE pjbpent = g_enterprise AND pjbp001 = g_pjbn_m.pjbn001 AND pjbp900 = g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      DELETE FROM pjbu_t
       WHERE pjbuent = g_enterprise AND pjbu001 = g_pjbn_m.pjbn001 AND pjbu004 = g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbu_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF      

      CLEAR FORM
      CALL g_pjbq_d.clear()
      CALL g_pjbq2_d.clear()

      CALL g_pjbq3_d.clear()

      CALL g_pjbq4_d.clear()

      CALL g_pjbq5_d.clear()
      CALL g_tree.clear() 


    
      CALL apjm300_ui_detailshow()
      CALL apjm300_ui_browser_refresh()
      IF g_browser_cnt > 0 THEN
         CALL apjm300_fetch('P')
      ELSE
         CLEAR FORM
#         LET g_wc = " 1=1"
#         CALL apjm300_browser_fill()
      END IF

   END IF

   CLOSE apjm300_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_pjbn_m.pjbn001,'D')

END FUNCTION

PRIVATE FUNCTION apjm300_b_fill()
   {<Local define>}
   DEFINE p_wc2      STRING
   {</Local define>}
   #add-point:b_fill段define
   DEFINE  l_pjbq901    LIKE pjbq_t.pjbq901
   #end add-point

   CALL g_pjbq_d.clear()    #g_pjbq_d 單頭及單身
   CALL g_pjbq2_d.clear()

   CALL g_pjbq3_d.clear()

   CALL g_pjbq4_d.clear()

   CALL g_pjbq5_d.clear()



   #add-point:b_fill段define
   {<point name="b_fill.sql_before"/>}
   #end add-point

   LET g_sql = "SELECT  UNIQUE pjbq003,pjbq004,'',pjbq005,'',pjbq006,'',pjbq007,pjbq008,pjbq009,pjbq010,pjbq901 FROM pjbq_t",
               " INNER JOIN pjbo_t ON pjbo001 = pjbq001 ",
               " AND pjbo002 = pjbq002 ",


               "",
               " WHERE pjbqent=? AND pjbq001=? AND pjbq002=? AND pjbq900 = ? "

   IF NOT cl_null(g_wc_table1) THEN
      LET g_sql = g_sql CLIPPED, " AND ", g_wc_table1 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY pjbq003"

   PREPARE apjm300_pb FROM g_sql
   DECLARE b_fill_cs CURSOR FOR apjm300_pb

   LET g_cnt = l_ac
   LET l_ac = 1

   OPEN b_fill_cs USING g_enterprise,g_pjbo_m.pjbo001
                                            ,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900



   FOREACH b_fill_cs INTO g_pjbq_d[l_ac].pjbq003,g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq004_desc,g_pjbq_d[l_ac].pjbq005,g_pjbq_d[l_ac].pjbq005_desc,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq006_desc,g_pjbq_d[l_ac].pjbq007,
                          g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010,l_pjbq901
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL apjm300_pjbq_set_color(l_pjbq901)
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH

   LET g_sql = "SELECT  UNIQUE pjbr003,'',pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009,pjbr901 FROM pjbr_t",
               "",
               " WHERE pjbrent=? AND pjbr001=? AND pjbr002=? AND pjbr900 = ? "

   IF NOT cl_null(g_wc_table2) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_table2 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY  pjbr_t.pjbr003"

   PREPARE apjm300_pb2 FROM g_sql
   DECLARE b_fill_cs2 CURSOR FOR apjm300_pb2

   LET l_ac = 1

   OPEN b_fill_cs2 USING g_enterprise,g_pjbo_m.pjbo001
                                            ,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900



   FOREACH b_fill_cs2 INTO g_pjbq2_d[l_ac].pjbr003,g_pjbq2_d[l_ac].pjbr003_desc,g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005,
                           g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009,l_pjbq901
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL apjm300_pjbr_set_color(l_pjbq901)
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH


   LET g_sql = "SELECT  UNIQUE pjbs003,'',pjbs004,'',pjbs005,pjbs006,pjbs007,pjbs008,pjbs901 FROM pjbs_t",
               "",
               " WHERE pjbsent=? AND pjbs001=? AND pjbs002=? AND pjbs900 = ? "

   IF NOT cl_null(g_wc_table3) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_table3 CLIPPED
   END IF

   LET g_sql = g_sql, " ORDER BY    pjbs_t.pjbs003"

   PREPARE apjm300_pb3 FROM g_sql
   DECLARE b_fill_cs3 CURSOR FOR apjm300_pb3

   LET l_ac = 1

   OPEN b_fill_cs3 USING g_enterprise,g_pjbo_m.pjbo001
                                            ,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900



   FOREACH b_fill_cs3 INTO g_pjbq3_d[l_ac].pjbs003,g_pjbq3_d[l_ac].pjbs003_desc,g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs004_desc,g_pjbq3_d[l_ac].pjbs005,
                           g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008,l_pjbq901
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL apjm300_pjbs_set_color(l_pjbq901)
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH


   LET g_sql = "SELECT  UNIQUE pjbt003,'',pjbt004,pjbt005,pjbt901 FROM pjbt_t",
               "",
               " WHERE pjbtent=? AND pjbt001=? AND pjbt002=? AND pjbt900 = ? "

   IF NOT cl_null(g_wc_table4) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_table4 CLIPPED
   END IF

   LET g_sql = g_sql, "  ORDER BY   pjbt_t.pjbt003"

   PREPARE apjm300_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR apjm300_pb4

   LET l_ac = 1

   OPEN b_fill_cs4 USING g_enterprise,g_pjbo_m.pjbo001
                                            ,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900



   FOREACH b_fill_cs4 INTO g_pjbq4_d[l_ac].pjbt003,g_pjbq4_d[l_ac].pjbt003_desc,g_pjbq4_d[l_ac].pjbt004,
                           g_pjbq4_d[l_ac].pjbt005,l_pjbq901
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL apjm300_pjbt_set_color(l_pjbq901)
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH


   LET g_sql = "SELECT  UNIQUE pjbp002,'',pjbp003,'',pjbp004,pjbp005,pjbp006,pjbp901 FROM pjbp_t",
               "",
               " WHERE pjbpent=? AND pjbp001=? AND pjbp900 = ? "

   IF NOT cl_null(g_wc_table5) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc_table5 CLIPPED
   END IF

   LET g_sql = g_sql, "  ORDER BY pjbp_t.pjbp002,pjbp_t.pjbp003"

   PREPARE apjm300_pb5 FROM g_sql
   DECLARE b_fill_cs5 CURSOR FOR apjm300_pb5

   LET l_ac = 1

   OPEN b_fill_cs5 USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                           



   FOREACH b_fill_cs5 INTO g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp002_desc,g_pjbq5_d[l_ac].pjbp003,g_pjbq5_d[l_ac].pjbp003_desc,g_pjbq5_d[l_ac].pjbp004,
                           g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006,l_pjbq901
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充
      CALL apjm300_pjbp_set_color(l_pjbq901)
      #end add-point

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF

   END FOREACH




   CALL g_pjbq_d.deleteElement(g_pjbq_d.getLength())
   CALL g_pjbq2_d.deleteElement(g_pjbq2_d.getLength())

   CALL g_pjbq3_d.deleteElement(g_pjbq3_d.getLength())

   CALL g_pjbq4_d.deleteElement(g_pjbq4_d.getLength())

   CALL g_pjbq5_d.deleteElement(g_pjbq5_d.getLength())



   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE apjm300_pb
   FREE apjm300_pb2

   FREE apjm300_pb3

   FREE apjm300_pb4

   FREE apjm300_pb5




END FUNCTION

PRIVATE FUNCTION apjm300_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   {<point name="delete_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete" mark="Y"/>}
      #end add-point
      DELETE FROM pjbq_t
       WHERE pjbqent = g_enterprise AND
         pjbq001 = ps_keys_bak[1] AND pjbq002 = ps_keys_bak[2] AND pjbq003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete2" mark="Y"/>}
      #end add-point
      DELETE FROM pjbr_t
       WHERE pjbrent = g_enterprise AND
         pjbr001 = ps_keys_bak[1] AND pjbr002 = ps_keys_bak[2] AND pjbr003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete2"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete2"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete3" mark="Y"/>}
      #end add-point
      DELETE FROM pjbs_t
       WHERE pjbsent = g_enterprise AND
         pjbs001 = ps_keys_bak[1] AND pjbs002 = ps_keys_bak[2] AND pjbs003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete3"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete3"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete4" mark="Y"/>}
      #end add-point
      DELETE FROM pjbt_t
       WHERE pjbtent = g_enterprise AND
         pjbt001 = ps_keys_bak[1] AND pjbt002 = ps_keys_bak[2] AND pjbt003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete4"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbt_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete4"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      {<point name="delete_b.b_delete5" mark="Y"/>}
      #end add-point
      DELETE FROM pjbp_t
       WHERE pjbpent = g_enterprise AND
         pjbp001 = ps_keys_bak[1] AND pjbp002 = ps_keys_bak[2] AND pjbp003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      {<point name="delete_b.m_delete5"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      {<point name="delete_b.a_delete5"/>}
      #end add-point
      RETURN
   END IF



END FUNCTION

PRIVATE FUNCTION apjm300_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   {<point name="insert_b.define"/>}
   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert" mark="Y"/>}
      #end add-point
      INSERT INTO pjbq_t
                  (pjbqent,
                   pjbq001,pjbq002,
                   pjbq003,pjbq900,
                   pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010,pjbq901)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq005,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010,'3')
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbq_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert"/>}
      #end add-point
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert2" mark="Y"/>}
      #end add-point
      INSERT INTO pjbr_t
                  (pjbrent,
                   pjbr001,pjbr002,
                   pjbr003,pjbr900,
                   pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009,pjbr901)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005,g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009,'3')
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert2"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert2"/>}
      #end add-point
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert3" mark="Y"/>}
      #end add-point
      INSERT INTO pjbs_t
                  (pjbsent,
                   pjbs001,pjbs002,
                   pjbs003,pjbs900,
                   pjbs004,pjbs005,pjbs006,pjbs007,pjbs008,pjbs901)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs005,g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008,'3')
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert3"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert3"/>}
      #end add-point
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert4" mark="Y"/>}
      #end add-point
      INSERT INTO pjbt_t
                  (pjbtent,
                   pjbt001,pjbt002,
                   pjbt003,pjbt900,
                   pjbt004,pjbt005,pjbt901)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005,'3')
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert4"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbt_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert4"/>}
      #end add-point
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段新增前
      {<point name="insert_b.b_insert5" mark="Y"/>}
      #end add-point
      INSERT INTO pjbp_t
                  (pjbpent,
                   pjbp001,pjbp002,pjbp003,pjbp900,
                   pjbp004,pjbp005,pjbp006,pjbp901)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_pjbq5_d[l_ac].pjbp004,g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006,'3')
      #add-point:insert_b段新增中
      {<point name="insert_b.m_insert5"/>}
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段新增後
      {<point name="insert_b.a_insert5"/>}
      #end add-point
   END IF



END FUNCTION

PRIVATE FUNCTION apjm300_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   {<point name="update_b.define"/>}
   #end add-point

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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbq_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update" mark="Y"/>}
      #end add-point
      UPDATE pjbq_t
         SET (pjbq001,pjbq002,
              pjbq003,pjbq900,
              pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
              g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq005,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010)
         WHERE pjbqent = g_enterprise AND pjbq001 = ps_keys_bak[1] AND pjbq002 = ps_keys_bak[2] AND pjbq003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pjbq_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pjbq_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.a_update"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbr_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update2" mark="Y"/>}
      #end add-point
      UPDATE pjbr_t
         SET (pjbr001,pjbr002,
              pjbr003,pjbr900,
              pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
              g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005,g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009)
         WHERE pjbrent = g_enterprise AND pjbr001 = ps_keys_bak[1] AND pjbr002 = ps_keys_bak[2] AND pjbr003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update2"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pjbr_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pjbr_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.a_update2"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbs_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update3" mark="Y"/>}
      #end add-point
      UPDATE pjbs_t
         SET (pjbs001,pjbs002,
              pjbs003,pjbs900,
              pjbs004,pjbs005,pjbs006,pjbs007,pjbs008)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
              g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs005,g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008)
         WHERE pjbsent = g_enterprise AND pjbs001 = ps_keys_bak[1] AND pjbs002 = ps_keys_bak[2] AND pjbs003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update3"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pjbs_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pjbs_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.a_update3"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbt_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update4" mark="Y"/>}
      #end add-point
      UPDATE pjbt_t
         SET (pjbt001,pjbt002,
              pjbt003,pjbt900,
              pjbt004,pjbt005)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
              g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005)
         WHERE pjbtent = g_enterprise AND pjbt001 = ps_keys_bak[1] AND pjbt002 = ps_keys_bak[2] AND pjbt003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update4"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pjbt_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pjbt_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.a_update4"/>}
      #end add-point
      RETURN
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pjbp_t" THEN
      #add-point:update_b段修改前
      {<point name="update_b.b_update5" mark="Y"/>}
      #end add-point
      UPDATE pjbp_t
         SET (
              pjbp001,pjbp002,pjbp003,pjbp900,
              pjbp004,pjbp005,pjbp006)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_pjbq5_d[l_ac].pjbp004,g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006)
         WHERE pjbpent = g_enterprise AND pjbp001 = ps_keys_bak[1] AND pjbp002 = ps_keys_bak[2] AND pjbp003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      {<point name="update_b.m_update5"/>}
      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "pjbp_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pjbp_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         OTHERWISE

      END CASE
      #add-point:update_b段修改後
      {<point name="update_b.a_update5"/>}
      #end add-point
      RETURN
   END IF



END FUNCTION

PRIVATE FUNCTION apjm300_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pjbn001",TRUE)
      #add-point:set_entry段欄位控制
      {<point name="set_entry.field_control"/>}
      #end add-point
   END IF
   
   CALL cl_set_comp_entry("pjbn003,pjbn007,pjbn008",TRUE)
   
END FUNCTION

PRIVATE FUNCTION apjm300_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("pjbn001",FALSE)
      #add-point:set_no_entry段欄位控制
      {<point name="set_no_entry.field_control"/>}
      #end add-point
   ELSE
      IF NOT cl_null(g_pjbn_m.pjbn003) THEN
         CALL cl_set_comp_entry("pjbn007,pjbn008",FALSE)
      END IF
   END IF

   IF g_pjbn_m.pjbn002 = 'Y' THEN
      INITIALIZE g_pjbn_m.pjbn003 TO NULL 
      DISPLAY BY NAME g_pjbn_m.pjbn003
      CALL cl_set_comp_entry("pjbn003",FALSE)
   END IF
   CALL cl_set_comp_entry("pjbn003",FALSE)
END FUNCTION

PRIVATE FUNCTION apjm300_set_entry_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
   CALL cl_set_comp_entry("pjbp002,pjbp003,pjbq003,pjbr003,pjbs003,pjbt003",TRUE)
   
END FUNCTION

PRIVATE FUNCTION apjm300_set_no_entry_b(p_cmd,p_type,p_key2,p_key3)
DEFINE p_cmd   LIKE type_t.chr1
DEFINE p_type  LIKE type_t.chr1
DEFINE p_key2  LIKE pjbp_t.pjbp002
DEFINE p_key3  LIKE pjbp_t.pjbp003
DEFINE l_count LIKE type_t.num5
   IF p_cmd = 'u' THEN 
      IF p_type = '1' THEN 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pjbd_t
          WHERE pjbdent = g_enterprise
            AND pjbd001 = g_pjbn_m.pjbn001
            AND pjbd002 = p_key2
            AND pjbd003 = p_key3
         IF l_count > 0 THEN 
            CALL cl_set_comp_entry("pjbq003",FALSE)
         END IF      
      END IF   
      IF p_type = '2' THEN 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pjbe_t
          WHERE pjbeent = g_enterprise
            AND pjbe001 = g_pjbn_m.pjbn001
            AND pjbe002 = p_key2
            AND pjbe003 = p_key3
         IF l_count > 0 THEN 
            CALL cl_set_comp_entry("pjbr003",FALSE)
         END IF      
      END IF  
     
      IF p_type = '3' THEN 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pjbf_t
          WHERE pjbfent = g_enterprise
            AND pjbf001 = g_pjbn_m.pjbn001
            AND pjbf002 = p_key2
            AND pjbf003 = p_key3

         IF l_count > 0 THEN 
            CALL cl_set_comp_entry("pjbs003",FALSE)
         END IF      
      END IF  
      
      IF p_type = '4' THEN 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pjbg_t
          WHERE pjbgent = g_enterprise
            AND pjbg001 = g_pjbn_m.pjbn001
            AND pjbg002 = p_key2
            AND pjbg003 = p_key3
         IF l_count > 0 THEN 
            CALL cl_set_comp_entry("pjbt003",FALSE)
         END IF      
      END IF 
      
      IF p_type = '5' THEN 
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM pjbc_t
          WHERE pjbcent = g_enterprise
            AND pjbc001 = g_pjbn_m.pjbn001
            AND pjbc002 = p_key2
            AND pjbc003 = p_key3
         IF l_count > 0 THEN 
            CALL cl_set_comp_entry("pjbp002,pjbp003",FALSE)
         END IF      
      END IF 
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#3 num5==》num10
   DEFINE li_cnt  LIKE type_t.num10   #161108-00012#3 num5==》num10
   DEFINE ls_wc   STRING 
   {</Local define>}
   #add-point:default_search段define
   {<point name="default_search.define"/>}
   #end add-point

   #add-point:default_search段開始前
   {<point name="default_search.before"/>}
   #end add-point

   LET g_pagestart = 1

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " pjbn001 = '", g_argv[1], "' AND "
   END IF


   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   {<point name="default_search.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION apjm300_statechange()
   {<Local define>}
   DEFINE lc_state     LIKE type_t.chr5
   DEFINE l_open_state LIKE type_t.chr1
   DEFINE r_success    LIKE type_t.num5
   ERROR ""     #清空畫面右下側ERROR區塊

   
   
   IF g_pjbn_m.pjbn001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   #檢查是否允許此動作
   IF NOT apjm300_action_chk() THEN
      CLOSE apjm300_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   IF g_pjbn_m.pjbnstus = 'Y' OR g_pjbn_m.pjbnstus = 'X' THEN
      RETURN
   END IF
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         CASE g_pjbn_m.pjbnstus
            WHEN "N"
               HIDE OPTION "open"
            WHEN "Y"
               HIDE OPTION "confirmed"

            WHEN "X"
               HIDE OPTION "void"
			
         END CASE
      CALL cl_set_act_visible("open,confirmed,void",TRUE)
      IF g_pjbn_m.pjbnstus MATCHES '[YX]' THEN
         CALL cl_set_act_visible("void,confirmed",FALSE)
      ELSE
         CALL cl_set_act_visible("open",FALSE)
	  END IF
	  
      ON ACTION open
         LET lc_state = "N"
         IF g_pjbn_m.pjbnstus = 'X' THEN LET l_open_state = 'V' END IF
         IF g_pjbn_m.pjbnstus = 'Y' THEN LET l_open_state = 'C' END IF
         EXIT MENU
      ON ACTION confirmed
         LET lc_state = "Y"

         EXIT MENU

      ON ACTION void
         LET lc_state = "X"

         EXIT MENU

	
      #add-point:stus控制
      {<point name="statechange.more_control"/>}
      #end add-point
	
   END MENU

   IF (lc_state <> "N"
      AND lc_state <> "X"

      AND lc_state <> "Y"


      ) OR
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   CASE
        WHEN lc_state = 'Y' 
           CALL s_apjm300_conf_chk(g_pjbn_m.pjbn001,g_pjbn_m.pjbn900) RETURNING r_success
           IF r_success THEN
              IF cl_ask_confirm('lib-054') THEN
                 CALL s_transaction_begin()
                 IF NOT s_apjm300_conf_upd(g_pjbn_m.pjbn001,g_pjbn_m.pjbn900) THEN
                 
                    CALL s_transaction_end('N','0')
                 ELSE 
                    CALL s_transaction_end('Y','0')
                 END IF
              ELSE   
                 RETURN  
              END IF
           ELSE
              RETURN 
           END IF

        WHEN lc_state = 'X'
           CALL s_apjm300_void_chk(g_pjbn_m.pjbn001,g_pjbn_m.pjbn900) RETURNING r_success
           IF r_success THEN
              IF cl_ask_confirm('art-00039') THEN
                 CALL s_transaction_begin()
                 CALL s_apjm300_void_upd(g_pjbn_m.pjbn001,g_pjbn_m.pjbn900) RETURNING r_success
                 IF r_success THEN
                    CALL s_transaction_end('Y','0')
                 ELSE
 
                    CALL s_transaction_end('N','0')
                    RETURN
                 END IF
              ELSE   
                 RETURN  
              END IF
           ELSE
 
              RETURN 
           END IF
   END CASE

   UPDATE pjbn_t SET pjbnstus = lc_state
    WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001



   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")


		
      END CASE
      LET g_pjbn_m.pjbnstus = lc_state
      DISPLAY BY NAME g_pjbn_m.pjbnstus
      SELECT UNIQUE pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbn009,pjbn010,pjbn011,pjbn012,pjbn013,pjbnstus,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt
        INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn013,
             g_pjbn_m.pjbnstus,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,
             g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt
        FROM pjbn_t
        WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn001
          AND pjbn900 = g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         INITIALIZE g_pjbn_m.* TO NULL
         RETURN
      END IF
      
      CALL s_desc_get_person_desc(g_pjbn_m.pjbnownid) RETURNING g_pjbn_m.pjbnownid_desc
      CALL s_desc_get_person_desc(g_pjbn_m.pjbncrtid) RETURNING g_pjbn_m.pjbncrtid_desc   
      CALL s_desc_get_person_desc(g_pjbn_m.pjbnmodid) RETURNING g_pjbn_m.pjbnmodid_desc
      CALL s_desc_get_person_desc(g_pjbn_m.pjbncnfid) RETURNING g_pjbn_m.pjbncnfid_desc
      CALL s_desc_get_department_desc(g_pjbn_m.pjbnowndp) RETURNING g_pjbn_m.pjbnowndp_desc
      CALL s_desc_get_department_desc(g_pjbn_m.pjbncrtdp) RETURNING g_pjbn_m.pjbncrtdp_desc  
      CALL s_desc_get_person_desc(g_pjbn_m.pjbn012) RETURNING g_pjbn_m.pjbn012_desc
      
      DISPLAY BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn000_desc,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004,
                   g_pjbn_m.pjbn003,g_pjbn_m.pjbn003_desc,g_pjbn_m.pjbn004,g_pjbn_m.pjbn004_desc,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,g_pjbn_m.pjbnstus,
                   g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn008_desc,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnownid_desc,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbnowndp_desc,
                   g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtid_desc,g_pjbn_m.pjbncrtdp,g_pjbn_m.pjbncrtdp_desc,g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmodid_desc,
                   g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfid_desc,g_pjbn_m.pjbncnfdt,g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,
                   g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,
                   g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001,g_pjbn_m.pjbn009,g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn012_desc,g_pjbn_m.pjbn013
   END IF

   #add-point:stus修改後
   {<point name="statechange.a_update"/>}
   #end add-point

   #add-point:statechange段結束前
   {<point name="statechange.after"/>}
   #end add-point

END FUNCTION

PRIVATE FUNCTION apjm300_idx_chk()
   #add-point:idx_chk段define
   {<point name="idx_chk.define"/>}
   #end add-point

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pjbq_d.getLength() THEN
         LET g_detail_idx = g_pjbq_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbq_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
#     DISPLAY g_detail_idx TO FORMONLY.idx
#     DISPLAY g_pjbq_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_pjbq2_d.getLength() THEN
         LET g_detail_idx = g_pjbq2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbq2_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
#     DISPLAY g_detail_idx TO FORMONLY.idx
#     DISPLAY g_pjbq2_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_pjbq3_d.getLength() THEN
         LET g_detail_idx = g_pjbq3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbq3_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
#     DISPLAY g_detail_idx TO FORMONLY.idx
#     DISPLAY g_pjbq3_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_pjbq4_d.getLength() THEN
         LET g_detail_idx = g_pjbq4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbq4_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
#     DISPLAY g_detail_idx TO FORMONLY.idx
#     DISPLAY g_pjbq4_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_pjbq5_d.getLength() THEN
         LET g_detail_idx = g_pjbq5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pjbq5_d.getLength() <> 0 THEN
         #LET g_detail_idx = 1
      END IF
#     DISPLAY g_detail_idx TO FORMONLY.idx
#     DISPLAY g_pjbq5_d.getLength() TO FORMONLY.cnt
   END IF



END FUNCTION

PRIVATE FUNCTION apjm300_tree_expand(p_id)
   {<Local define>}
   DEFINE p_id          LIKE type_t.num10
   DEFINE l_id          LIKE type_t.num10
   DEFINE l_cnt         LIKE type_t.num10
   DEFINE l_keyvalue    LIKE type_t.chr50
   DEFINE l_typevalue   LIKE type_t.chr50
   DEFINE l_type        LIKE type_t.chr50
   DEFINE l_sql         STRING
   DEFINE ls_source     LIKE type_t.chr500
   DEFINE ls_exp_code   LIKE type_t.chr500
   DEFINE l_return      LIKE type_t.num5
   DEFINE l_count       LIKE type_t.num5
   {</Local define>}
   #add-point:browser_expand段define
   {<point name="browser_expand.define"/>}
   #end add-point

   #若已經展開
   IF g_tree[p_id].b_isExp = 1 THEN
      RETURN
   END IF

   #LET li_lv = g_tree[p_id].b_expcode
   LET g_tree[p_id].b_isExp = TRUE

#   LET l_keyvalue = g_tree[p_id].b_pjbo002
#   LET l_typevalue = g_tree[p_id].b_pjbo001
#
#   CASE g_tree[p_id].b_expcode
#      WHEN -1
#         CALL g_tree.deleteElement(p_id)
#      WHEN 0
#         RETURN
#      WHEN 1
#         LET ls_source = " pjbo_t"
#         LET ls_exp_code = "exp_code"
#      WHEN 2
#         LET ls_source = "pjbo_t"
#         LET ls_exp_code = "'2'"
#   END CASE

   LET l_sql = " SELECT UNIQUE pjbo001,pjbo002,pjbol004,pjbo003,pjbo004,oocql004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012",
               "   FROM  pjbo_t LEFT OUTER JOIN pjbol_t ON pjboent = pjbolent AND pjbo001 = pjbol001 AND pjbo002 = pjbol002 AND pjbo900 = pjbol900 AND pjbol003 = '",g_dlang,"'",
                  "             LEFT OUTER JOIN oocql_t ON pjboent = pjbolent AND pjbo004 = oocql002 AND oocql001 = '8001' AND oocql003 = '",g_dlang,"'",
               "  WHERE  pjbo002 <> pjbo003",
               "    AND  pjbo001 = '",g_tree[p_id].b_pjbo001,"'",
               "    AND  pjbo003 = '",g_tree[p_id].b_pjbo002,"'",
               "    AND  pjbo900 = '",g_pjbn_m.pjbn900,"'",
               " ORDER BY pjbo002"

   PREPARE tree_expand FROM l_sql
   DECLARE tree_ex_cur CURSOR FOR tree_expand

   LET l_id = p_id + 1
   CALL g_tree.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur INTO g_tree[l_id].b_pjbo001,g_tree[l_id].b_pjbo002,g_tree[l_id].b_pjbo002_desc,g_tree[l_id].b_pjbo003,g_tree[l_id].b_pjbo004,g_tree[l_id].b_pjbo004_desc,g_tree[l_id].b_pjbo005,g_tree[l_id].b_pjbo006,g_tree[l_id].b_pjbo007,g_tree[l_id].b_pjbo008,g_tree[l_id].b_pjbo009,g_tree[l_id].b_pjbo010,g_tree[l_id].b_pjbo011,g_tree[l_id].b_pjbo012,g_tree[l_id].b_expcode
      #pid=父節點id
      LET g_tree[l_id].b_pid  = g_tree[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_tree[l_id].b_id   = g_tree[p_id].b_id||"."||l_cnt
      LET g_tree[l_id].b_exp     = FALSE
      #hasC=確認該節點是否有子孫
      #LET g_browser[l_id].b_pjbo002 = g_browser[l_id].b_pjbo002 CLIPPED
      CALL apjm300_desc_show(l_id)
      LET g_tree[l_id].b_hasC = apjm300_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_tree.insertElement(l_id)
      LET l_cnt = l_cnt + 1

   END FOREACH

   #刪除空資料
   CALL g_tree.deleteElement(l_id)
   LET l_count =  g_tree.getLength()
   DISPLAY l_count TO FORMONLY.b_count
   FREE tree_expand

END FUNCTION

PRIVATE FUNCTION apjm300_match_node(p_wc,p_type)
#   {<Local define>}
   DEFINE p_wc         LIKE type_t.chr200
   DEFINE p_type       LIKE type_t.chr10
#   DEFINE ls_code      LIKE type_t.chr50
#   DEFINE ls_code2     LIKE type_t.chr50
#   DEFINE l_bstmp      RECORD    #body欄位
#             pjbo001 VARCHAR(500),
#   pjbo002 VARCHAR(500),
#   pjbo003 VARCHAR(500),
#   pjbo004 VARCHAR(500),
#   pjbo005 VARCHAR(500),
#   pjbo006 VARCHAR(500),
#   pjbo007 VARCHAR(500),
#   pjbo008 VARCHAR(500),
#   pjbo009 VARCHAR(500),
#   pjbo010 VARCHAR(500),
#   pjbo011 VARCHAR(500),
#   pjbo012 VARCHAR(500)
#          #僅含單身table的欄位
#   END RECORD
#   DEFINE l_child_list DYNAMIC ARRAY OF RECORD    #body欄位
#             pjbo001 VARCHAR(500),
#   pjbo002 VARCHAR(500),
#   pjbo003 VARCHAR(500),
#   pjbo004 VARCHAR(500),
#   pjbo005 VARCHAR(500),
#   pjbo006 VARCHAR(500),
#   pjbo007 VARCHAR(500),
#   pjbo008 VARCHAR(500),
#   pjbo009 VARCHAR(500),
#   pjbo010 VARCHAR(500),
#   pjbo011 VARCHAR(500),
#   pjbo012 VARCHAR(500)
#          #僅含單身table的欄位
#   END RECORD
#   {</Local define>}
#   #add-point:match_node段define
#   {<point name="match_node.define"/>}
#   #end add-point
#
#   #先找出符合條件的節點並給予展開值
#   CASE p_type
#      WHEN 1
#         LET ls_code = "0"
#      WHEN 2
#         LET ls_code = "2"
#      WHEN 3
#         LET ls_code = "2"
#   END CASE
#
#   IF cl_null('pjbo003') THEN
#      LET ls_code = '0'
#   END IF
#
#   CALL s_transaction_begin()
#
#   LET g_sql = " INSERT INTO apjm300_tmp (pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,exp_code) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)"
#   PREPARE master_tmp FROM g_sql
#
#   IF g_root_search THEN
#      #DECLARE master_tmp_cur CURSOR FOR master_tmp
#      #OPEN master_tmp_cur
#      FOREACH master_extcur INTO l_bstmp.*
#         EXECUTE master_tmp USING l_bstmp.*,ls_code
#         #PUT master_tmp_cur FROM l_bstmp.*,ls_code
#      END FOREACH
#      #FLUSH master_tmp_cur
#      CALL s_transaction_end('Y','0')
#      RETURN
#   END IF
#
#   FOREACH master_extcur INTO l_bstmp.*
#      EXECUTE master_tmp USING l_bstmp.*,ls_code
#      LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
#
#      #找出符合條件的節點的所有祖先並給予展開值
#      CASE p_type
#         WHEN 1
#            LET ls_code2 = "1"
#         WHEN 2
#            LET ls_code2 = "-1"
#         WHEN 3
#            LET ls_code2 = "1"
#      END CASE
#
#      #若pid欄位存在才進行後續處理
#      #擷取該節點的父節點到temp table中
#      LET g_sql = " SELECT pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012 ",
#                  " FROM pjbo_t  ",
#                  " WHERE pjboent = '" ||g_enterprise|| "' AND pjbo002 = ? "
#                  ," AND pjbo001 = ? "
#      PREPARE master_getparent_up FROM g_sql
#
#      #擷取該節點的所有父節點
#      WHILE TRUE
#         IF cl_null(l_child_list[1].pjbo002) THEN
#            IF l_child_list.getLength() = 1 THEN
#               EXIT WHILE
#            ELSE
#               CALL l_child_list.deleteElement(1)
#               CONTINUE WHILE
#            END IF
#         END IF
#
#         EXECUTE master_getparent_up USING l_child_list[1].pjbo003
#                                           ,l_child_list[1].pjbo001
#                                           INTO l_bstmp.*
#         FREE master_getparent_up
#
#      #確定該節點是否存在於temp table中
#
#         IF STATUS = 0 AND apjm300_tmp_tbl_chk(l_bstmp.pjbo002,ls_code2
#                     ,l_bstmp.pjbo001
#                     ) THEN
#            EXECUTE master_tmp USING l_bstmp.*,ls_code2
#            LET l_child_list[l_child_list.getLength()+1].* = l_bstmp.*
#         END IF
#         CALL l_child_list.deleteElement(1)
#
#      END WHILE
#
#   END FOREACH
#
#   FREE master_tmp
#
#   CALL s_transaction_end('Y','0')

END FUNCTION

PRIVATE FUNCTION apjm300_tmp_tbl_chk(ps_id,pi_code,ps_type)
   {<Local define>}
   DEFINE ps_id       STRING
   DEFINE pi_code     LIKE type_t.num10
   DEFINE ps_type     STRING
   DEFINE ls_id       LIKE type_t.chr500
   DEFINE ls_search   LIKE type_t.chr500
   DEFINE ls_type     LIKE type_t.chr500
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_code     LIKE type_t.num10
   {</Local define>}
   #add-point:tmp_tbl_chk段define
   {<point name="tmp_tbl_chk.define"/>}
   #end add-point

   LET ls_id = ps_id
   LET ls_type = ps_type

   IF cl_null(ls_id) THEN
      RETURN TRUE
   END IF

   LET g_sql = " SELECT COUNT(*) FROM apjm300_tmp ",
               " WHERE pjbo002 = ? "
                ," AND pjbo001 = ? "
#                ," AND pjbo900 = ? "
   PREPARE apjm300_get_cnt FROM g_sql
   EXECUTE apjm300_get_cnt USING ls_id ,ls_type
                                     INTO li_cnt
   FREE apjm300_get_cnt

   IF li_cnt = 0 OR SQLCA.sqlcode THEN
      RETURN TRUE
   ELSE

      #資料已存在, 確定是否需要更新展開值
      LET g_sql = " SELECT exp_code FROM apjm300_tmp  ",
                  " WHERE pjbo002 = ? "
                   ," AND pjbo001 = ? "

      PREPARE apjm300_chk_exp FROM g_sql

      EXECUTE apjm300_chk_exp USING ls_id ,ls_type
                                        INTO li_code
      FREE apjm300_chk_exp

      #若新展開值>原展開值則做更新
      IF pi_code > li_code THEN
         LET g_sql = " UPDATE apjm300_tmp SET (exp_code) = ('",pi_code,"') ",
                     " WHERE pjbo002 = ? "
                      ," AND pjbo001 = ? "
         PREPARE apjm300_upd_exp FROM g_sql
         EXECUTE apjm300_upd_exp USING ls_id ,ls_type
         FREE apjm300_upd_exp

      END IF

      RETURN FALSE
   END IF

END FUNCTION

PRIVATE FUNCTION apjm300_tree_create(p_type)
#   {<Local define>}
   DEFINE p_type   LIKE type_t.chr50
#   DEFINE l_pid    LIKE type_t.chr50
#   {</Local define>}
#   #add-point:tree_create
#   {<point name="tree_create.define"/>}
#   #end add-point
#   
#   CALL g_tree.clear()
#   #先找出所有的帳別資料
#   LET g_sql = " SELECT UNIQUE pjbo001 FROM apjm300_tmp ORDER BY pjbo001"
#   PREPARE master_type FROM g_sql
#   DECLARE master_typecur CURSOR FOR master_type
#
#   INITIALIZE g_tree_root TO NULL
#
#   LET l_ac = 1
#   FOREACH master_typecur INTO g_tree[l_ac].b_pjbo001
#      #確定root節點所在
#      LET g_tree_root[g_tree_root.getLength()+1] = l_ac
#      #此處為帳別部分(LV-1)
#      LET g_tree[l_ac].b_pjbo002  = g_tree[l_ac].b_pjbo001
#      LET g_tree[l_ac].b_pjbo001 = g_tree[l_ac].b_pjbo001
#      LET g_tree[l_ac].b_pid = '0' CLIPPED
#      LET g_tree[l_ac].b_id = l_ac USING "<<<"
#      LET g_tree[l_ac].b_exp = TRUE
#      LET g_tree[l_ac].b_hasC = TRUE
#      LET l_pid = g_tree[l_ac].b_id CLIPPED
#      LET l_ac = l_ac + 1
#
#      #抓出LV2的所有資料
#      LET g_sql = " SELECT UNIQUE pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,exp_code FROM apjm300_tmp a ",
#                  " WHERE ",
#                  "a.pjbo001 = ? ",
#                  " AND ",
#                  " (( SELECT COUNT(*) FROM apjm300_tmp b WHERE a.pjbo003 = b.pjbo002 ",
#                  " AND a.pjbo001 = b.pjbo001",
#                  ") = 0 OR ",
#                  " a.pjbo002 = a.pjbo003 )",
#                  " ORDER BY a.pjbo002"
#      PREPARE master_getLV2 FROM g_sql
#      DECLARE master_getLV2cur CURSOR FOR master_getLV2
#
#      #以下為一般資料root(LV-2)
#      OPEN master_getLV2cur USING g_tree[l_ac-1].b_pjbo001
#
#      LET g_cnt = l_ac
#
#      FOREACH master_getLV2cur INTO g_tree[g_cnt].b_pjbo001,g_tree[g_cnt].b_pjbo002,g_tree[g_cnt].b_pjbo003,g_tree[g_cnt].b_pjbo004,g_tree[g_cnt].b_pjbo005,g_tree[g_cnt].b_pjbo006,g_tree[g_cnt].b_pjbo007,g_tree[g_cnt].b_pjbo008,g_tree[g_cnt].b_pjbo009,g_tree[g_cnt].b_pjbo010,g_tree[g_cnt].b_pjbo011,g_tree[g_cnt].b_pjbo012,g_tree[g_cnt].b_expcode
#         #去除多餘空白
#         #LET g_tree[g_cnt].b_pjbo002 = g_tree[g_cnt].b_pjbo002 CLIPPED
#         LET g_tree[g_cnt].b_pid = l_pid
#         LET g_tree[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
#         LET g_tree[g_cnt].b_exp = FALSE
#         LET g_tree[g_cnt].b_expcode = 2
#
#         IF cl_null("pjbo003") THEN
#            LET g_tree[g_cnt].b_hasC = FALSE
#         ELSE
#            LET g_tree[g_cnt].b_hasC = TRUE
#         END IF
#   
#         LET g_cnt = g_cnt + 1
#
##         IF g_cnt > g_max_rec AND g_error_show = 1 THEN
##            CALL cl_err('',9035,0)
##            EXIT FOREACH
##         END IF
#      END FOREACH
#      LET l_ac = g_tree.getLength()
#
##      IF g_cnt > g_max_rec AND g_error_show = 1 THEN
##         EXIT FOREACH
##      END IF
#   END FOREACH
#
#   LET g_error_show = 0
#
#   #組合描述欄位&刪除多於資料
#   FOR l_ac = 1 TO g_tree.getLength()
#      IF cl_null(g_tree[l_ac].b_pjbo002) THEN
#         CALL g_tree.deleteElement(l_ac)
#         LET l_ac = l_ac - 1
#      ELSE
#         CALL apjm300_desc_show(l_ac)
#      END IF
#   END FOR
#   CALL g_tree.deleteElement(l_ac)
#
##   LET g_tree_cnt = g_tree.getLength() - g_tree_root.getLength()
#   FREE tree_expand
#   FREE master_getLV2
#
END FUNCTION
#第二單頭fetch
PRIVATE FUNCTION apjm300_fetch2()
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE ls_chk     STRING
   {</Local define>}
   #add-point:fetch段define
   {<point name="fetch.define"/>}
   #end add-point

#   LET ls_chk = g_tree[g_tree_idx].b_id
#   IF ls_chk.getIndexOf('.',1) = 0 THEN
#      INITIALIZE g_pjbo_m.* TO NULL
#      DISPLAY BY NAME g_pjbo_m.*
#      DISPLAY '' TO FORMONLY.b_index
#      RETURN
#   END IF
#

   #超出範圍
   IF g_tree_idx > g_tree.getLength() THEN
      LET g_tree_idx = g_tree.getLength()
   END IF

   LET g_pjbo_m.pjbo001 = g_tree[g_tree_idx].b_pjbo001
   LET g_pjbo_m.pjbo002 = g_tree[g_tree_idx].b_pjbo002

   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE pjbo002,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001
      INTO g_pjbo_m.pjbo002,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001
      FROM pjbo_t
     WHERE pjboent = g_enterprise AND pjbo001 = g_pjbo_m.pjbo001 AND pjbo002 = g_pjbo_m.pjbo002
       AND pjbo900 = g_pjbn_m.pjbn900
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbo_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_pjbo_m.* TO NULL
      RETURN
   END IF
   
   SELECT pjbol004,pjbol004 INTO g_pjbo_m.pjbol004,g_pjbo_m.pjbol005 FROM pjbol_t
    WHERE pjbolent = g_enterprise
      AND pjbol001 = g_pjbo_m.pjbo001
      AND pjbol002 = g_pjbo_m.pjbo002
      AND pjbol900 = g_pjbn_m.pjbn900
      AND pjbol003 = g_lang
   DISPLAY BY NAME g_pjbo_m.pjbol004,g_pjbo_m.pjbol005 
   CALL apjm300_show()
END FUNCTION

PRIVATE FUNCTION apjm300_pjbn000_desc(p_pjbn000)
DEFINE p_pjbn000   LIKE pjbn_t.pjbn000
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbn000
   CALL ap_ref_array2(g_ref_fields,"SELECT pjaal003 FROM pjaal_t WHERE pjaalent='"||g_enterprise||"' AND pjaal001=? AND pjaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbn_m.pjbn000_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbn_m.pjbn000_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbn003_desc(p_pjbn003)
DEFINE p_pjbn003    LIKE pjbn_t.pjbn003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbn003
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbnl003 FROM pjbnl_t WHERE pjbnlent='"||g_enterprise||"' AND pjbnl001=? AND pjbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbn_m.pjbn003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbn_m.pjbn003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbn004_desc(p_pjbn004)
DEFINE p_pjbn004   LIKE pjbn_t.pjbn004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbn004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbn_m.pjbn004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbn_m.pjbn004_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbn008_desc(p_pjbn008)
DEFINE p_pjbn008    LIKE pjbn_t.pjbn008
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbn008
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbn_m.pjbn008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbn_m.pjbn008_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbp002_desc(p_pjbp002)
DEFINE p_pjbp002    LIKE pjbp_t.pjbp002            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pjbq5_d[l_ac].pjbp002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pjbq5_d[l_ac].pjbp002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pjbq5_d[l_ac].pjbp002_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbp003_desc(p_pjbp003)
DEFINE p_pjbp003   LIKE pjbp_t.pjbp003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbp003
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pjbq5_d[l_ac].pjbp003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq5_d[l_ac].pjbp003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_date_compare()
      IF NOT cl_null(g_pjbq5_d[l_ac].pjbp004) AND NOT cl_null(g_pjbq5_d[l_ac].pjbp005) THEN
         IF g_pjbq5_d[l_ac].pjbp005 < g_pjbq5_d[l_ac].pjbp004 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'ais-00047'
            LET g_errparam.extend = g_pjbq5_d[l_ac].pjbp005||" < "||g_pjbq5_d[l_ac].pjbp004
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      END IF
      RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq004_desc(p_pjbq004)
DEFINE p_pjbq004   LIKE pjbq_t.pjbq004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbq004
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq_d[l_ac].pjbq004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq_d[l_ac].pjbq004_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq004_pjbq005_required()
   IF cl_null(g_pjbq_d[l_ac].pjbq004) AND cl_null(g_pjbq_d[l_ac].pjbq005) THEN
      CALL cl_set_comp_required("pjbq004,pjbq005",TRUE)
   ELSE
      CALL cl_set_comp_required("pjbq004,pjbq005",FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq005_desc(p_pjbq005)
DEFINE p_pjbq005   LIKE pjbq_t.pjbq005
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =  p_pjbq005
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq_d[l_ac].pjbq005_desc = '', g_rtn_fields[1] , ''
   LET g_pjbq_d[l_ac].pjbq005_desc1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_pjbq_d[l_ac].pjbq005_desc,g_pjbq_d[l_ac].pjbq005_desc1
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq006_desc(p_pjbq006)
DEFINE p_pjbq006   LIKE pjbq_t.pjbq006 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbq006
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq_d[l_ac].pjbq006_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq_d[l_ac].pjbq006_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq009_count()
   IF NOT cl_null(g_pjbq_d[l_ac].pjbq007) AND NOT cl_null(g_pjbq_d[l_ac].pjbq008) THEN
      LET g_pjbq_d[l_ac].pjbq009 = g_pjbq_d[l_ac].pjbq007 * g_pjbq_d[l_ac].pjbq008
      CALL apjm300_pjbq009_round()
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq009_round()
DEFINE l_para   STRING 
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0006') RETURNING l_para
   CALL s_num_round(l_para,g_pjbq_d[l_ac].pjbq009,6) RETURNING g_pjbq_d[l_ac].pjbq009
   DISPLAY BY NAME g_pjbq_d[l_ac].pjbq009
END FUNCTION

PRIVATE FUNCTION apjm300_pjbr003_desc(p_pjbr003)
DEFINE p_pjbr003  LIKE pjbr_t.pjbr003
 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbr003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq2_d[l_ac].pjbr003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq2_d[l_ac].pjbr003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbq_num_compare(p_num)
DEFINE p_num   LIKE type_t.num20_6
   IF NOT cl_null(p_num) THEN
      IF p_num <= 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aim-00003'
         LET g_errparam.extend = p_num
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_pjbr008_count()
   
   IF NOT cl_null(g_pjbq2_d[l_ac].pjbr005) AND NOT cl_null(g_pjbq2_d[l_ac].pjbr007) THEN
      LET g_pjbq2_d[l_ac].pjbr008 = g_pjbq2_d[l_ac].pjbr005 * g_pjbq2_d[l_ac].pjbr007
      CALL apjm300_pjbr008_round()
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbr008_round()
DEFINE l_para   STRING 
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0006') RETURNING l_para
   CALL s_num_round(l_para,g_pjbq2_d[l_ac].pjbr008,6) RETURNING g_pjbq2_d[l_ac].pjbr008
   DISPLAY BY NAME g_pjbq2_d[l_ac].pjbr008
END FUNCTION

PRIVATE FUNCTION apjm300_pjbs003_desc(p_pjbs003)
DEFINE p_pjbs003    LIKE pjbs_t.pjbs003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbs003
   CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrba001=? ","") RETURNING g_rtn_fields
   LET g_pjbq3_d[l_ac].pjbs003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq3_d[l_ac].pjbs003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbs004_desc(p_pjbs004)
DEFINE p_pjbs004   LIKE pjbs_t.pjbs004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbs004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq3_d[l_ac].pjbs004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq3_d[l_ac].pjbs004_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbs007_count()
   IF NOT cl_null(g_pjbq3_d[l_ac].pjbs005) AND NOT cl_null(g_pjbq3_d[l_ac].pjbs006) THEN
      LET g_pjbq3_d[l_ac].pjbs007 = g_pjbq3_d[l_ac].pjbs005 * g_pjbq3_d[l_ac].pjbs006
      CALL apjm300_pjbs007_round()
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbs007_round()
DEFINE l_para   STRING 
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0006') RETURNING l_para
   CALL s_num_round(l_para,g_pjbq3_d[l_ac].pjbs007,6) RETURNING g_pjbq3_d[l_ac].pjbs007
   DISPLAY BY NAME g_pjbq3_d[l_ac].pjbs007
END FUNCTION

PRIVATE FUNCTION apjm300_pjbt003_desc(p_pjbt003)
DEFINE p_pjbt003   LIKE pjbt_t.pjbt003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbt003
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8003' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbq4_d[l_ac].pjbt003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbq4_d[l_ac].pjbt003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbt004_round()
DEFINE l_para   STRING 
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0006') RETURNING l_para
   CALL s_num_round(l_para,g_pjbq4_d[l_ac].pjbt004,6) RETURNING g_pjbq4_d[l_ac].pjbt004
   DISPLAY BY NAME g_pjbq4_d[l_ac].pjbt004
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo004_desc(p_pjbo004)
DEFINE p_pjbo004    LIKE pjbo_t.pjbo004
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbo004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8001' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbo_m.pjbo004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbo_m.pjbo004_desc
END FUNCTION

PRIVATE FUNCTION apjm300_workday_chk(p_date)
DEFINE p_date   LIKE type_t.dat
   IF NOT cl_null(p_date) AND g_pjbn_m.pjbn007 MATCHES '[12]' THEN
      IF NOT s_date_chk_workday(g_site,g_pjbn_m.pjbn008,'2',p_date) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apj-00040'
         LET g_errparam.extend = p_date
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo005_pjbo006_chk()
   IF NOT cl_null(g_pjbo_m.pjbo005) AND NOT cl_null(g_pjbo_m.pjbo006) THEN
      IF g_pjbo_m.pjbo005 > g_pjbo_m.pjbo006  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00117'
         LET g_errparam.extend = g_pjbo_m.pjbo005||" > "||g_pjbo_m.pjbo006
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_get_days_hours()
DEFINE l_para    LIKE type_t.num5
DEFINE l_days    LIKE type_t.num5
   IF NOT cl_null(g_pjbo_m.pjbo005) AND NOT cl_null(g_pjbo_m.pjbo006) THEN 
      LET g_pjbo_m.pjbo007 = s_date_get_workdays(g_site,g_pjbn_m.pjbn008,'2',g_pjbo_m.pjbo005,g_pjbo_m.pjbo006) 
      CALL cl_get_para(g_enterprise,g_site,'E-COM-0007') RETURNING l_para
      LET g_pjbo_m.pjbo008 =  g_pjbo_m.pjbo007 * l_para 
      DISPLAY BY NAME g_pjbo_m.pjbo007,g_pjbo_m.pjbo008
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo010_desc(p_pjbo010)
DEFINE p_pjbo010  LIKE pjbo_t.pjbo010
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbo010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_pjbo_m.pjbo010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbo_m.pjbo010_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo011_desc(p_pjbo011)
DEFINE p_pjbo011   LIKE pjbo_t.pjbo011
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_pjbo011
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbo_m.pjbo011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbo_m.pjbo011_desc
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo_ins()
DEFINE l_pjaa008     LIKE pjaa_t.pjaa008
DEFINE l_pjaa009     LIKE pjaa_t.pjaa009
DEFINE l_i           LIKE type_t.num5
   SELECT pjaa008,pjaa009 INTO l_pjaa008,l_pjaa009 FROM pjaa_t
    WHERE pjaaent = g_enterprise AND pjaa001 = g_pjbn_m.pjbn000
   CALL apjm300_get_auto_no(l_pjaa009,'Y') RETURNING g_pjbo_m.pjbo002
   LET g_pjbo_m.pjbo001 = g_pjbn_m.pjbn001
   LET g_pjbo_m.pjbo003 = g_pjbo_m.pjbo002
   LET g_pjbo_m.pjbo009 = "N"
   LET g_pjbo_m.pjbo012 = "0"
   INSERT INTO pjbo_t (pjboent,pjbo002,pjbo900,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001)
                  VALUES (g_enterprise,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,
                       g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001)
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd_t         LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#3 num5==》num10
   DEFINE  l_n             LIKE type_t.num5                #檢查重複用
   DEFINE  l_cnt           LIKE type_t.num5                #檢查重複用
   DEFINE  l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE  l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE  l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE  l_count         LIKE type_t.num5
   DEFINE  l_i             LIKE type_t.num5
   DEFINE  l_insert        BOOLEAN
   DEFINE  ls_return       STRING
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE  l_pjaa007       LIKE pjaa_t.pjaa007



   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""


   LET g_forupd_sql = "SELECT pjbq003,pjbq004,'',pjbq005,'',pjbq006,'',pjbq007,pjbq008,pjbq009,pjbq010 FROM pjbq_t WHERE pjbqent=? AND pjbq001=? AND pjbq002=? AND pjbq003=? AND pjbq900 = ? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apjm300_bcl CURSOR FROM g_forupd_sql


   LET g_forupd_sql = "SELECT pjbr003,'',pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009 FROM pjbr_t WHERE pjbrent=? AND pjbr001=? AND pjbr002=? AND pjbr003=? AND pjbr900 = ? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apjm300_bcl2 CURSOR FROM g_forupd_sql


   LET g_forupd_sql = "SELECT pjbs003,'',pjbs004,'',pjbs005,pjbs006,pjbs007,pjbs008 FROM pjbs_t WHERE pjbsent=? AND pjbs001=? AND pjbs002=? AND pjbs003=? AND pjbs900 = ? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apjm300_bcl3 CURSOR FROM g_forupd_sql


   LET g_forupd_sql = "SELECT pjbt003,'',pjbt004,pjbt005 FROM pjbt_t WHERE pjbtent=? AND pjbt001=? AND pjbt002=? AND pjbt003=? AND pjbt900 = ? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apjm300_bcl4 CURSOR FROM g_forupd_sql

   LET g_forupd_sql = "SELECT pjbp002,'',pjbp003,'',pjbp004,pjbp005,pjbp006 FROM pjbp_t WHERE pjbpent=? AND pjbp001=? AND pjbp002=? AND pjbp003=? AND pjbp900 = ? FOR UPDATE"
   
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apjm300_bcl5 CURSOR FROM g_forupd_sql

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL apjm300_set_entry_pjbo(p_cmd)

   CALL apjm300_set_no_entry_pjbo(p_cmd)

   LET g_errshow = 1

   DISPLAY BY NAME g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段

      INPUT BY NAME g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,
                    g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,
                    g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001
            ATTRIBUTE(WITHOUT DEFAULTS)
            
         ON ACTION update_item

            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               IF NOT cl_null(g_pjbo_m.pjbo001) AND NOT cl_null(g_pjbo_m.pjbo002)THEN
                  CALL n_pjbol(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_pjbo_m.pjbo001
                  LET g_ref_fields[2] = g_pjbo_m.pjbo002
                  LET g_ref_fields[3] = g_pjbn_m.pjbn900
                  CALL ap_ref_array2(g_ref_fields," SELECT pjbol004,pjbol005 FROM pjbol_t WHERE pjbolent = '"
                      ||g_enterprise||"' AND pjbol001 = ?  AND pjbol002 = ? AND pjbol900 = ? AND pjbol003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_pjbo_m.pjbol004 = g_rtn_fields[1]
                  LET g_pjbo_m.pjbol005 = g_rtn_fields[2]
                  DISPLAY BY NAME g_pjbo_m.pjbol004
                  DISPLAY BY NAME g_pjbo_m.pjbol005  
               END IF
            END IF

      BEFORE INPUT 
         IF s_transaction_chk("N",0) THEN
            CALL s_transaction_begin()
         END IF
         LET g_pjbo_m.pjbo001 = g_pjbn_m.pjbn001
         
         LET g_master_multi_table_t.pjbol001_idx2 = g_pjbo_m.pjbo001
         LET g_master_multi_table_t.pjbol900_idx2 = g_pjbn_m.pjbn900
         LET g_master_multi_table_t.pjbol002_idx2 = g_pjbo_m.pjbo002
         LET g_master_multi_table_t.pjbol004_idx2 = g_pjbo_m.pjbol004
         LET g_master_multi_table_t.pjbol005_idx2 = g_pjbo_m.pjbol005
         IF l_cmd_t = 'r' THEN
            LET g_master_multi_table_t.pjbol001_idx2 = ''
            LET g_master_multi_table_t.pjbol900_idx2 = ''
            LET g_master_multi_table_t.pjbol002_idx2 = ''
            LET g_master_multi_table_t.pjbol004_idx2 = ''
            LET g_master_multi_table_t.pjbol005_idx2 = ''
         END IF
         #控制key欄位可否輸入
         CALL apjm300_set_entry_pjbo(p_cmd)
       
         CALL apjm300_set_no_entry_pjbo(p_cmd)    
         
      BEFORE FIELD cbo_searchcol
                  #add-point:BEFORE FIELD cbo_searchcol
                  {<point name="input.b.cbo_searchcol" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD cbo_searchcol

            #add-point:AFTER FIELD cbo_searchcol
            {<point name="input.a.cbo_searchcol" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE cbo_searchcol
            #add-point:ON CHANGE cbo_searchcol
            {<point name="input.g.cbo_searchcol" />}
            #END add-point

         #----<<searchstr>>----
         #此段落由子樣板a01產生
         BEFORE FIELD searchstr
            #add-point:BEFORE FIELD searchstr
            {<point name="input.b.searchstr" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD searchstr

            #add-point:AFTER FIELD searchstr
            {<point name="input.a.searchstr" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE searchstr
            #add-point:ON CHANGE searchstr
            {<point name="input.g.searchstr" />}
            #END add-point

         #----<<rdo_searchtype>>----
         #此段落由子樣板a01產生
         BEFORE FIELD rdo_searchtype
            #add-point:BEFORE FIELD rdo_searchtype
            {<point name="input.b.rdo_searchtype" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD rdo_searchtype

            #add-point:AFTER FIELD rdo_searchtype
            {<point name="input.a.rdo_searchtype" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE rdo_searchtype
            #add-point:ON CHANGE rdo_searchtype
            {<point name="input.g.rdo_searchtype" />}
            #END add-point

         #----<<pjbo002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo002
            #add-point:BEFORE FIELD pjbo002
            {<point name="input.b.pjbo002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo002

            #add-point:AFTER FIELD pjbo002
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pjbo_m.pjbo001) AND NOT cl_null(g_pjbo_m.pjbo002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t  OR g_pjbo_m.pjbo002 != g_pjbo002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbo_t WHERE "||"pjboent = '" ||g_enterprise|| "' AND "||"pjbo001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbo002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbo900 = '"||g_pjbn_m.pjbn900 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbo002
            #add-point:ON CHANGE pjbo002
            {<point name="input.g.pjbo002" />}
            #END add-point

         #----<<pjbol004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbol004
            #add-point:BEFORE FIELD pjbol004
            {<point name="input.b.pjbol004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbol004

            #add-point:AFTER FIELD pjbol004
            {<point name="input.a.pjbol004" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbol004
            #add-point:ON CHANGE pjbol004
            {<point name="input.g.pjbol004" />}
            #END add-point

         #----<<pjbol005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbol005
            #add-point:BEFORE FIELD pjbol005
            {<point name="input.b.pjbol005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbol005

            #add-point:AFTER FIELD pjbol005
            {<point name="input.a.pjbol005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbol005
            #add-point:ON CHANGE pjbol005
            {<point name="input.g.pjbol005" />}
            #END add-point

         #----<<pjbo004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbo004

            #add-point:AFTER FIELD pjbo004
            CALL apjm300_pjbo004_desc(g_pjbo_m.pjbo004)
            IF NOT cl_null(g_pjbo_m.pjbo004) THEN
               IF NOT s_azzi650_chk_exist('8001',g_pjbo_m.pjbo004) THEN
                  LET g_pjbo_m.pjbo004 = g_pjbo_m_t.pjbo004
                  CALL apjm300_pjbo004_desc(g_pjbo_m.pjbo004)
                  NEXT FIELD CURRENT
               END IF
               IF NOT apjm300_pjbo004_chk() THEN
                  LET g_pjbo_m.pjbo004 = g_pjbo_m_t.pjbo004
                  CALL apjm300_pjbo004_desc(g_pjbo_m.pjbo004)
                  NEXT FIELD CURRENT               
               END IF
            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbo004
            #add-point:BEFORE FIELD pjbo004
            {<point name="input.b.pjbo004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbo004
            #add-point:ON CHANGE pjbo004
            {<point name="input.g.pjbo004" />}
            #END add-point

         #----<<pjbo003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbo003

            #add-point:AFTER FIELD pjbo003
            CALL apjm300_pjbo003_desc(g_pjbo_m.pjbo003)
            IF NOT cl_null(g_pjbo_m.pjbo003) THEN
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbn_m.pjbn001
               LET g_chkparam.arg2 = g_pjbo_m.pjbo003 
               LET g_chkparam.arg3 = g_pjbo_m.pjbo004 
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pjbo002") THEN
                  LET g_pjbo_m.pjbo003 = g_pjbo_m_t.pjbo003
                  CALL apjm300_pjbo003_desc(g_pjbo_m.pjbo003)
                  NEXT FIELD CURRENT
               ELSE
                  CALL apjm300_get_pjbo002()
               END IF
               IF g_pjbo_m.pjbo003 <> g_pjbo_m_t.pjbo003 OR g_pjbo_m_t.pjbo003 IS NULL THEN
                  CALL apjm300_get_pjbo002()
               END IF   
               IF NOT apjm300_pjbo004_chk() THEN
                  LET g_pjbo_m.pjbo003 = g_pjbo_m_t.pjbo003
                  CALL apjm300_pjbo003_desc(g_pjbo_m.pjbo003)
                  NEXT FIELD CURRENT   
               END IF                  
            END IF
            LET g_pjbo_m_t.pjbo003 = g_pjbo_m.pjbo003
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbo003
            #add-point:BEFORE FIELD pjbo003
            {<point name="input.b.pjbo003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbo003
            #add-point:ON CHANGE pjbo003
            {<point name="input.g.pjbo003" />}
            #END add-point

         #----<<pjbo005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo005
            #add-point:BEFORE FIELD pjbo005
            {<point name="input.b.pjbo005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo005
            IF NOT cl_null(g_pjbo_m.pjbo005) THEN
               IF g_pjbn_m.pjbn007 = '1' THEN
                  LET g_pjbo_m.pjbo005 = s_date_get_latest_work_date(g_site,g_pjbn_m.pjbn008,'2',-1,g_pjbo_m.pjbo005)
               END IF
               IF g_pjbn_m.pjbn007 = '2' THEN
                  LET g_pjbo_m.pjbo005 = s_date_get_latest_work_date(g_site,g_pjbn_m.pjbn008,'2',0,g_pjbo_m.pjbo005)
               END IF
               IF NOT apjm300_workday_chk(g_pjbo_m.pjbo005) THEN
                  LET g_pjbo_m.pjbo005 = g_pjbo_m_t.pjbo005
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT apjm300_pjbo005_pjbo006_chk()  THEN
                  LET g_pjbo_m.pjbo005 = g_pjbo_m_t.pjbo005
                  NEXT FIELD CURRENT
               END IF
               CALL apjm300_get_days_hours()
            END IF
         #此段落由子樣板a04產生
         ON CHANGE pjbo005
            #add-point:ON CHANGE pjbo005
            {<point name="input.g.pjbo005" />}
            #END add-point

         #----<<pjbo006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo006
            #add-point:BEFORE FIELD pjbo006
            {<point name="input.b.pjbo006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo006
            IF NOT cl_null(g_pjbo_m.pjbo006) THEN
               IF g_pjbn_m.pjbn007 = '1' THEN
                  LET g_pjbo_m.pjbo006 = s_date_get_latest_work_date(g_site,g_pjbn_m.pjbn008,'2',-1,g_pjbo_m.pjbo006)
               END IF
               IF g_pjbn_m.pjbn007 = '2' THEN
                  LET g_pjbo_m.pjbo006 = s_date_get_latest_work_date(g_site,g_pjbn_m.pjbn008,'2',0,g_pjbo_m.pjbo006)
               END IF
               IF NOT apjm300_workday_chk(g_pjbo_m.pjbo006) THEN
                  LET g_pjbo_m.pjbo006 = g_pjbo_m_t.pjbo006
                  NEXT FIELD CURRENT
               END IF
               IF NOT apjm300_pjbo005_pjbo006_chk() THEN
                  LET g_pjbo_m.pjbo006 = g_pjbo_m_t.pjbo006
                  NEXT FIELD CURRENT
               END IF
               CALL apjm300_get_days_hours()
            END IF
         #此段落由子樣板a04產生
         ON CHANGE pjbo006
            #add-point:ON CHANGE pjbo006
            {<point name="input.g.pjbo006" />}
            #END add-point

         #----<<pjbo007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo007
            #add-point:BEFORE FIELD pjbo007
            {<point name="input.b.pjbo007" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo007

            #add-point:AFTER FIELD pjbo007
            {<point name="input.a.pjbo007" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbo007
            #add-point:ON CHANGE pjbo007
            {<point name="input.g.pjbo007" />}
            #END add-point

         #----<<pjbo008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo008
            #add-point:BEFORE FIELD pjbo008
            {<point name="input.b.pjbo008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo008

            #add-point:AFTER FIELD pjbo008
            {<point name="input.a.pjbo008" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbo008
            #add-point:ON CHANGE pjbo008
            {<point name="input.g.pjbo008" />}
            #END add-point

         #----<<pjbo009>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbo009

            #add-point:AFTER FIELD pjbo009

            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbo009
            #add-point:BEFORE FIELD pjbo009
            {<point name="input.b.pjbo009" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbo009
            #add-point:ON CHANGE pjbo009
            {<point name="input.g.pjbo009" />}
            #END add-point

         #----<<pjbo010>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbo010

            #add-point:AFTER FIELD pjbo010
            CALL apjm300_pjbo010_desc(g_pjbo_m.pjbo010)
            IF NOT cl_null(g_pjbo_m.pjbo010) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbo_m.pjbo010

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  SELECT ooag003 INTO g_pjbo_m.pjbo011 FROM ooag_t
                   WHERE ooag001 = g_pjbo_m.pjbo010 AND ooagent = g_enterprise
                  DISPLAY BY NAME g_pjbo_m.pjbo011

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbo_m.pjbo010 = g_pjbo_m_t.pjbo010
                  CALL apjm300_pjbo010_desc(g_pjbo_m.pjbo010)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbo010
            #add-point:BEFORE FIELD pjbo010
            {<point name="input.b.pjbo010" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbo010
            #add-point:ON CHANGE pjbo010
            {<point name="input.g.pjbo010" />}
            #END add-point

         #----<<pjbo011>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbo011

            #add-point:AFTER FIELD pjbo011
            CALL apjm300_pjbo011_desc(g_pjbo_m.pjbo011)
            IF NOT cl_null(g_pjbo_m.pjbo011) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbo_m.pjbo011
               LET g_chkparam.arg2 = g_pjbn_m.pjbn005

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbo_m.pjbo011 = g_pjbo_m_t.pjbo011
                  CALL apjm300_pjbo011_desc(g_pjbo_m.pjbo011)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbo011
            #add-point:BEFORE FIELD pjbo011
            {<point name="input.b.pjbo011" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbo011
            #add-point:ON CHANGE pjbo011
            {<point name="input.g.pjbo011" />}
            #END add-point

         #----<<pjbo012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo012
            #add-point:BEFORE FIELD pjbo012
            {<point name="input.b.pjbo012" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo012

            #add-point:AFTER FIELD pjbo012
            {<point name="input.a.pjbo012" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbo012
            #add-point:ON CHANGE pjbo012
            {<point name="input.g.pjbo012" />}
            #END add-point

         #----<<pjbo001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbo001
            #add-point:BEFORE FIELD pjbo001
            {<point name="input.b.pjbo001" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbo001

            #add-point:AFTER FIELD pjbo001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pjbo_m.pjbo001) AND NOT cl_null(g_pjbo_m.pjbo002) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t  OR g_pjbo_m.pjbo002 != g_pjbo002_t )) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbo_t WHERE "||"pjboent = '" ||g_enterprise|| "' AND "||"pjbo001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbo002 = '"||g_pjbo_m.pjbo002 ||"' AND AND "||"pjbo900 = '"||g_pjbn_m.pjbn001 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbo001
            #add-point:ON CHANGE pjbo001
            {<point name="input.g.pjbo001" />}
            #END add-point
         ON ACTION controlp INFIELD pjbo003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbo_m.pjbo003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjbn_m.pjbn001
            LET g_qryparam.where = "pjbo004 IN (SELECT oocq002 FROM oocq_t  WHERE oocq001='8001' ",
                                   "               AND oocq009<(SELECT oocq009 FROM oocq_t ",
                                   "                             WHERE oocq001='8001' AND oocq002='",g_pjbo_m.pjbo004,"'))"
            CALL q_pjbo002_3()                                #呼叫開窗

            LET g_pjbo_m.pjbo003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbo_m.pjbo003 TO pjbo003              #顯示到畫面上
            CALL apjm300_pjbo003_desc(g_pjbo_m.pjbo003)
            NEXT FIELD pjbo003                
            
         ON ACTION controlp INFIELD pjbo004
            #add-point:ON ACTION controlp INFIELD pjbo004
            #此段落由子樣板a07產生
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbo_m.pjbo004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8001" #
            LET g_qryparam.where = "  oocq009 > (SELECT oocq009 FROM oocq_t ",
                                   "    WHERE oocq001='8001' AND oocq002 IN (SELECT pjbo004 FROM pjbo_t WHERE pjboent = '",g_enterprise,"' AND pjbo001 = '",g_pjbn_m.pjbn001,"' AND pjbo002 = '",g_pjbo_m.pjbo003,"' AND pjbo900 = '",g_pjbn_m.pjbn900,"'))"
            CALL q_oocq002_1()                                     #呼叫開窗

            LET g_pjbo_m.pjbo004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbo_m.pjbo004 TO pjbo004              #顯示到畫面上
            CALL apjm300_pjbo004_desc(g_pjbo_m.pjbo004)
            NEXT FIELD pjbo004                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbo009>>----
         #Ctrlp:input.c.pjbo009
         ON ACTION controlp INFIELD pjbo010
            #add-point:ON ACTION controlp INFIELD pjbo010
#此段落由子樣板a07產生
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbo_m.pjbo010             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pjbo_m.pjbo010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbo_m.pjbo010 TO pjbo010              #顯示到畫面上
            CALL apjm300_pjbo010_desc(g_pjbo_m.pjbo010)
            NEXT FIELD pjbo010                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbo010>>----
         #Ctrlp:input.c.pjbo010
         ON ACTION controlp INFIELD pjbo011
            #add-point:ON ACTION controlp INFIELD pjbo011
#此段落由子樣板a07產生
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbo_m.pjbo011             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pjbn_m.pjbn005 #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pjbo_m.pjbo011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbo_m.pjbo011 TO pjbo011              #顯示到畫面上
            CALL apjm300_pjbo011_desc(g_pjbo_m.pjbo011)
            NEXT FIELD pjbo011                          #返回原欄位

          {#ADP版次:1#}
            #END add-point
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_pjbo_m.pjbo001
                            ,g_pjbo_m.pjbo002



            IF p_cmd <> 'u' THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM pjbo_t
                WHERE pjboent = g_enterprise AND pjbo001 = g_pjbo_m.pjbo001
                  AND pjbo002 = g_pjbo_m.pjbo002
                  AND pjbo900 = g_pjbn_m.pjbn900

               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  {<point name="input.head.b_insert" mark="Y"/>}
                  #end add-point

                  INSERT INTO pjbo_t (pjboent,pjbo002,pjbo900,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001)
                              VALUES (g_enterprise,g_pjbo_m.pjbo002,g_pjbn_m.pjbn900,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001) # DISK WRITE

                  #add-point:單頭新增中
                  {<point name="input.head.m_insert"/>}
                  #end add-point

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_pjbo_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  ELSE
#                     IF NOT apjm300_pjbo_ins_pjbu('3') THEN
#                        CALL s_transaction_end('N','0')
#                        CONTINUE DIALOG
#                     END IF                     
                  END IF
                  #  CALL apjm300_pjbn_t('u')
                  INITIALIZE l_var_keys TO NULL
                  INITIALIZE l_field_keys TO NULL
                  INITIALIZE l_vars TO NULL
                  INITIALIZE l_fields TO NULL
                  
                  INITIALIZE l_var_keys TO NULL
                  INITIALIZE l_field_keys TO NULL
                  INITIALIZE l_vars TO NULL
                  INITIALIZE l_fields TO NULL
                  IF g_pjbo_m.pjbo001 = g_master_multi_table_t.pjbol001_idx2 AND
                     g_pjbn_m.pjbn900 = g_master_multi_table_t.pjbol900_idx2 AND
                     g_pjbo_m.pjbo002 = g_master_multi_table_t.pjbol002_idx2 AND
                     g_pjbo_m.pjbol004 = g_master_multi_table_t.pjbol004_idx2 AND
                     g_pjbo_m.pjbol005 = g_master_multi_table_t.pjbol005_idx2  THEN
               ELSE
                  LET l_var_keys[01] = g_pjbo_m.pjbo001
                  LET l_field_keys[01] = 'pjbol001'
                  LET l_var_keys_bak[01] = g_master_multi_table_t.pjbol001_idx2
                  LET l_var_keys[02] = g_pjbo_m.pjbo002
                  LET l_field_keys[02] = 'pjbol002'
                  LET l_var_keys_bak[02] = g_master_multi_table_t.pjbol002_idx2
                  #add by lixh 
                  LET l_var_keys[03] = g_pjbn_m.pjbn900
                  LET l_field_keys[03] = 'pjbol900'
                  LET l_var_keys_bak[03] = g_master_multi_table_t.pjbol900_idx2  
                  
                  LET l_var_keys[04] = g_dlang
                  LET l_field_keys[04] = 'pjbol003'
                  LET l_var_keys_bak[04] = g_dlang
                  
                  LET l_vars[01] = g_pjbo_m.pjbol004
                  LET l_fields[01] = 'pjbol004'
                  LET l_vars[02] = g_pjbo_m.pjbol005
                  LET l_fields[02] = 'pjbol005'
                  LET l_vars[03] = g_enterprise
                  LET l_fields[03] = 'pjbolent'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbol_t')
               END IF


                  #add-point:單頭新增後
                  {<point name="input.head.a_insert"/>}
                  IF NOT apjm300_pjbo_ins_pjbu('3') THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF                      
                  #end add-point
                  CALL s_transaction_end('Y','0')

#                  IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
#                     CALL apjm300_detail_reproduce()
#                  END IF

                  LET p_cmd = 'u'
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '!'
                  LET g_errparam.extend =  g_pjbo_m.pjbo001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  NEXT FIELD pjbo001
               END IF
            ELSE

               #add-point:單頭修改前
               {<point name="input.head.b_update" mark="Y"/>}
               #end add-point
#               IF NOT apjm300_pjbo_ins_pjbu('2') THEN
#                  CALL s_transaction_end('N','0')
#               END IF 
               UPDATE pjbo_t SET (pjbo002,pjbo004,pjbo003,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbo001) = (g_pjbo_m.pjbo002,g_pjbo_m.pjbo004,g_pjbo_m.pjbo003,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo011,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001)
                WHERE pjboent = g_enterprise AND pjbo001 = g_pjbo_m.pjbo001
                  AND pjbo002 = g_pjbo_m.pjbo002


               #add-point:單頭修改中
               {<point name="input.head.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbo_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  OTHERWISE
                               #    CALL apjm300_pjbn_t('u')
                     INITIALIZE l_var_keys TO NULL
                     INITIALIZE l_field_keys TO NULL
                     INITIALIZE l_vars TO NULL
                     INITIALIZE l_fields TO NULL
                    
                     INITIALIZE l_var_keys TO NULL
                     INITIALIZE l_field_keys TO NULL
                     INITIALIZE l_vars TO NULL
                     INITIALIZE l_fields TO NULL
                     IF g_pjbo_m.pjbo001 = g_master_multi_table_t.pjbol001_idx2 AND
                        g_pjbo_m.pjbo002 = g_master_multi_table_t.pjbol002_idx2 AND  
                        g_pjbn_m.pjbn900 = g_master_multi_table_t.pjbol900_idx2 AND
                        g_pjbo_m.pjbol004 = g_master_multi_table_t.pjbol004_idx2 AND
                        g_pjbo_m.pjbol005 = g_master_multi_table_t.pjbol005_idx2  THEN
                     ELSE
                        LET l_var_keys[01] = g_pjbo_m.pjbo001
                        LET l_field_keys[01] = 'pjbol001'
                        LET l_var_keys_bak[01] = g_master_multi_table_t.pjbol001_idx2
                        LET l_var_keys[02] = g_pjbo_m.pjbo002
                        LET l_field_keys[02] = 'pjbol002'
                        LET l_var_keys_bak[02] = g_master_multi_table_t.pjbol002_idx2
                        #add by lixh 
                        LET l_var_keys[03] = g_pjbn_m.pjbn900
                        LET l_field_keys[03] = 'pjbol900'
                        LET l_var_keys_bak[03] = g_master_multi_table_t.pjbol900_idx2              
                        LET l_var_keys[04] = g_dlang
                        LET l_field_keys[04] = 'pjbol003'
                        LET l_var_keys_bak[04] = g_dlang
                        LET l_vars[01] = g_pjbo_m.pjbol004
                        LET l_fields[01] = 'pjbol004'
                        LET l_vars[02] = g_pjbo_m.pjbol005
                        LET l_fields[02] = 'pjbol005'
                        LET l_vars[03] = g_enterprise
                        LET l_fields[03] = 'pjbolent'
                        CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'pjbol_t')
                     END IF

                     #add-point:單頭修改後
                     IF NOT apjm300_pjbo_ins_pjbu('2') THEN
                        CALL s_transaction_end('N','0')
                     END IF 
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE

            END IF
            LET g_pjbo001_t = g_pjbo_m.pjbo001
            LET g_pjbo002_t = g_pjbo_m.pjbo002

      END INPUT
      
      INPUT ARRAY g_pjbq5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pjbq5_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apjm300_b_fill()
            LET g_rec_b = g_pjbq5_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input5"/>}
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbq5_d[l_ac].* TO NULL

            
            CALL cl_show_fld_cont()
            CALL apjm300_set_entry_b(l_cmd)
            CALL apjm300_set_no_entry_b(l_cmd,'','','')
            #公用欄位給值(單身{page})

            LET g_pjbq5_d[l_ac].pjbp004 = g_today
            LET g_pjbq5_d_t.* = g_pjbq5_d[l_ac].*     #新輸入資料
            
         BEFORE ROW
            LET l_insert = FALSE
            LET p_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                                                
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apjm300_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apjm300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH apjm300_cl INTO g_pjbo_m.pjbn000,g_pjbo_m.pjbn000_desc,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbnl003,g_pjbo_m.pjbnl004,g_pjbo_m.pjbn003,g_pjbo_m.pjbn003_desc,g_pjbo_m.pjbn004,g_pjbo_m.pjbn004_desc,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbn008_desc,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnownid_desc,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbnowndp_desc,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtid_desc,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdp_desc,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmodid_desc,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfid_desc,g_pjbo_m.pjbncnfdt,g_pjbo_m.cbo_searchcol,g_pjbo_m.searchstr,g_pjbo_m.rdo_searchtype,g_pjbo_m.b_count,g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_pjbo_m.pjbo001,SQLCA.sqlcode,0)
            #   CLOSE apjm300_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_pjbq5_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pjbq5_d[l_ac].pjbp002 IS NOT NULL

               AND g_pjbq5_d[l_ac].pjbp003 IS NOT NULL

            THEN
               LET l_cmd='u'
               LET g_pjbq5_d_t.* = g_pjbq5_d[l_ac].*  #BACKUP
               CALL apjm300_set_entry_b(l_cmd)
               CALL apjm300_set_no_entry_b(l_cmd,'5',g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003)
               IF NOT apjm300_lock_b("pjbp_t","5") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm300_bcl5 INTO g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp002_desc,g_pjbq5_d[l_ac].pjbp003,g_pjbq5_d[l_ac].pjbp003_desc,g_pjbq5_d[l_ac].pjbp004,g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apjm300_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body5.before_row"/>}
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
         
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM pjbc_t
             WHERE pjbcent = g_enterprise
               AND pjbc001 = g_pjbn_m.pjbn001
               AND pjbc002 = g_pjbq5_d[g_detail_idx].pjbp002
               AND pjbc003 = g_pjbq5_d[g_detail_idx].pjbp003
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apj-00047'
               LET g_errparam.extend = g_pjbq5_d[g_detail_idx].pjbp002
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               CANCEL DELETE
            END IF   
            
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pjbq5_d.deleteElement(l_ac)
               NEXT FIELD pjbp001
            END IF
            IF  g_pjbq5_d_t.pjbp002 IS NOT NULL

               AND g_pjbq5_d_t.pjbp003 IS NOT NULL

            THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #add-point:單身5刪除前
               {<point name="input.body5.b_delete" mark="Y"/>}
               #end add-point

               DELETE FROM pjbp_t
                WHERE pjbpent = g_enterprise
                  AND pjbp001 = g_pjbn_m.pjbn001 
                  
                  AND pjbp002 = g_pjbq5_d_t.pjbp002

                  AND pjbp003 = g_pjbq5_d_t.pjbp003
                  AND pjbp900 = g_pjbn_m.pjbn900

               #add-point:單身5刪除中
               {<point name="input.body5.m_delete"/>}
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pjbp_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  DELETE FROM pjbu_t
                   WHERE pjbuent = g_enterprise
                     AND pjbu001 = g_pjbn_m.pjbn001 
                 
                     AND pjbu002 = g_pjbq5_d_t.pjbp002
                 
                     AND pjbu003 = g_pjbq5_d_t.pjbp003
                     AND pjbu900 = g_pjbn_m.pjbn900
                                 
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身5刪除後
                  {<point name="input.body5.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE apjm300_bcl5
               LET l_count = g_pjbq5_d.getLength()
            END IF
            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_pjbn_m.pjbn001
            LET gs_keys[2] = g_pjbq5_d[g_detail_idx].pjbp002
            LET gs_keys[3] = g_pjbq5_d[g_detail_idx].pjbp003
            LET gs_keys[4] = g_pjbn_m.pjbn900

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body5.after_delete"/>}
            #end add-point
            CALL apjm300_delete_b('pjbp_t',gs_keys,"'5'")
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM pjbp_t
             WHERE pjbpent = g_enterprise
               AND pjbp001 = g_pjbn_m.pjbn001     
               AND pjbp002 = g_pjbq5_d[l_ac].pjbp002 

               AND pjbp003 = g_pjbq5_d[l_ac].pjbp003 
               AND pjbp900 = g_pjbn_m.pjbn900  


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身5新增前
               {<point name="input.body5.b_insert"/>}
               #end add-point

               INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_pjbn_m.pjbn001
               LET gs_keys[2] = g_pjbq5_d[g_detail_idx].pjbp002
               LET gs_keys[3] = g_pjbq5_d[g_detail_idx].pjbp003
               LET gs_keys[4] = g_pjbn_m.pjbn900
               CALL apjm300_insert_b('pjbp_t',gs_keys,"'5'")

               #add-point:單身新增後5
               {<point name="input.body5.a_insert"/>}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pjbq5_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm300_b_fill()
               #資料多語言用-增/改
               IF NOT apjm300_pjbp_ins_pjbu('3') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               #add-point:單身新增後
               {<point name="input.body5.after_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pjbq5_d[l_ac].* = g_pjbq5_d_t.*
               CLOSE apjm300_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbq5_d[l_ac].* = g_pjbq5_d_t.*
            ELSE
               #add-point:單身page5修改前
               {<point name="input.body5.b_update" mark="Y"/>}
               #end add-point

               #寫入修改者/修改日期資訊(單身5)


               UPDATE pjbp_t SET (pjbp002,pjbp003,pjbp004,pjbp005,pjbp006) = (g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbq5_d[l_ac].pjbp004,g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006) #自訂欄位頁簽
                WHERE pjbpent = g_enterprise
                  AND pjbp001 = g_pjbn_m.pjbn001
                  AND pjbp002 = g_pjbq5_d_t.pjbp002
                  AND pjbp003 = g_pjbq5_d_t.pjbp003
                  AND pjbp900 = g_pjbn_m.pjbn900
               #add-point:單身page5修改中
               {<point name="input.body5.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbp_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq5_d[l_ac].* = g_pjbq5_d_t.*
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbp_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq5_d[l_ac].* = g_pjbq5_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pjbn_m.pjbn001
                     LET gs_keys_bak[1] = g_pjbn001_t            
                     LET gs_keys[2] = g_pjbq5_d[g_detail_idx].pjbp002
                     LET gs_keys_bak[2] = g_pjbq5_d_t.pjbp002
                     LET gs_keys[3] = g_pjbq5_d[g_detail_idx].pjbp003
                     LET gs_keys_bak[3] = g_pjbq5_d_t.pjbp003
                     LET gs_keys[4] = g_pjbn_m.pjbn900
                     LET gs_keys_bak[4] = g_pjbn900_t                  
                     CALL apjm300_update_b('pjbp_t',gs_keys,gs_keys_bak,"'5'")
                     #資料多語言用-增/改

               END CASE

               #add-point:單身page5修改後
               IF NOT apjm300_pjbp_ins_pjbu('2') THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point

            END IF

         #---------------------<  Detail: page5  >---------------------
         #----<<pjbp002>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbp002

            #add-point:AFTER FIELD pjbp002

            

            #此段落由子樣板a05產生
            CALL apjm300_pjbp002_desc(g_pjbq5_d[l_ac].pjbp002)
            IF  g_pjbn_m.pjbn001 IS NOT NULL AND  g_pjbq5_d[g_detail_idx].pjbp002 IS NOT NULL AND g_pjbq5_d[g_detail_idx].pjbp003 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbn_m.pjbn001 != g_pjbn001_t OR g_pjbn_m.pjbn900 != g_pjbn900_t  OR g_pjbq5_d[g_detail_idx].pjbp002 != g_pjbq5_d_t.pjbp002 OR g_pjbq5_d[g_detail_idx].pjbp003 != g_pjbq5_d_t.pjbp003)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbp_t WHERE "||"pjbpent = '" ||g_enterprise|| "' AND "||"pjbp001 = '"||g_pjbn_m.pjbn001 ||"' AND "|| "pjbp002 = '"||g_pjbq5_d[g_detail_idx].pjbp002 ||"' AND "|| "pjbp003 = '"||g_pjbq5_d[g_detail_idx].pjbp003 ||"'",'std-00004',0) THEN
                     LET g_pjbq5_d[l_ac].pjbp002 = g_pjbq5_d_t.pjbp002
                     CALL apjm300_pjbp002_desc(g_pjbq5_d[l_ac].pjbp002)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_pjbq5_d[l_ac].pjbp002) THEN
               IF NOT s_azzi650_chk_exist('8002',g_pjbq5_d[l_ac].pjbp002) THEN
                  LET g_pjbq5_d[l_ac].pjbp002 = g_pjbq5_d_t.pjbp002
                  CALL apjm300_pjbp002_desc(g_pjbq5_d[l_ac].pjbp002)
                  NEXT FIELD CURRENT
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbp002
            #add-point:BEFORE FIELD pjbp002
            {<point name="input.b.page5.pjbp002" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbp002
            #add-point:ON CHANGE pjbp002
            {<point name="input.g.page5.pjbp002" />}
            #END add-point

         #----<<pjbp003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbp003

            #add-point:AFTER FIELD pjbp003
            CALL apjm300_pjbp003_desc(g_pjbq5_d[l_ac].pjbp003)
            IF NOT cl_null(g_pjbq5_d[l_ac].pjbp003) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq5_d[l_ac].pjbp003

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbq5_d[l_ac].pjbp003 = g_pjbq5_d_t.pjbp003
                  CALL apjm300_pjbp003_desc(g_pjbq5_d[l_ac].pjbp003)
                  NEXT FIELD CURRENT
               END IF


            END IF
            

            #此段落由子樣板a05產生
            IF  g_pjbn_m.pjbn001 IS NOT NULL  AND g_pjbq5_d[g_detail_idx].pjbp002 IS NOT NULL AND g_pjbq5_d[g_detail_idx].pjbp003 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbn_m.pjbn001 != g_pjbo001_t  OR g_pjbq5_d[g_detail_idx].pjbp002 != g_pjbq5_d_t.pjbp002 OR g_pjbq5_d[g_detail_idx].pjbp003 != g_pjbq5_d_t.pjbp003)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbp_t WHERE "||"pjbpent = '" ||g_enterprise|| "' AND "||"pjbp001 = '"||g_pjbn_m.pjbn001 ||"' AND "|| "pjbp002 = '"||g_pjbq5_d[g_detail_idx].pjbp002 ||"' AND "|| "pjbp003 = '"||g_pjbq5_d[g_detail_idx].pjbp003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbp003
            #add-point:BEFORE FIELD pjbp003
            {<point name="input.b.page5.pjbp003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbp003
            #add-point:ON CHANGE pjbp003
            {<point name="input.g.page5.pjbp003" />}
            #END add-point

         #----<<pjbp004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp004
            #add-point:BEFORE FIELD pjbp004
            {<point name="input.b.page5.pjbp004" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp004

            IF NOT apjm300_date_compare() THEN
               LET g_pjbq5_d[l_ac].pjbp004 = g_pjbq5_d_t.pjbp004
               NEXT FIELD CURRENT
            END IF


         #此段落由子樣板a04產生
         ON CHANGE pjbp004
            #add-point:ON CHANGE pjbp004
            {<point name="input.g.page5.pjbp004" />}
            #END add-point

         #----<<pjbp005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp005
            #add-point:BEFORE FIELD pjbp005
            {<point name="input.b.page5.pjbp005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp005

            IF NOT apjm300_date_compare() THEN
               LET g_pjbq5_d[l_ac].pjbp005 = g_pjbq5_d_t.pjbp005
               NEXT FIELD CURRENT
            END IF


         #此段落由子樣板a04產生
         ON CHANGE pjbp005
            #add-point:ON CHANGE pjbp005
            {<point name="input.g.page5.pjbp005" />}
            #END add-point

         #----<<pjbp006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbp006
            #add-point:BEFORE FIELD pjbp006
            {<point name="input.b.page5.pjbp006" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbp006

            #add-point:AFTER FIELD pjbp006
            {<point name="input.a.page5.pjbp006" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbp006
            #add-point:ON CHANGE pjbp006
            {<point name="input.g.page5.pjbp006" />}
            #END add-point


         #---------------------<  Detail: page5  >---------------------
         #----<<pjbp002>>----
         #Ctrlp:input.c.page5.pjbp002
         ON ACTION controlp INFIELD pjbp002
            #add-point:ON ACTION controlp INFIELD pjbp002
#此段落由子樣板a07產生
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq5_d[l_ac].pjbp002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8002" #

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_pjbq5_d[l_ac].pjbp002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq5_d[l_ac].pjbp002 TO pjbp002              #顯示到畫面上
            CALL apjm300_pjbp002_desc(g_pjbq5_d[l_ac].pjbp002)
            NEXT FIELD pjbp002                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbp003>>----
         #Ctrlp:input.c.page5.pjbp003
         ON ACTION controlp INFIELD pjbp003
            #add-point:ON ACTION controlp INFIELD pjbp003
#此段落由子樣板a07產生
            #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq5_d[l_ac].pjbp003             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pjbq5_d[l_ac].pjbp003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq5_d[l_ac].pjbp003 TO pjbp003              #顯示到畫面上
            CALL apjm300_pjbp003_desc(g_pjbq5_d[l_ac].pjbp003)
            NEXT FIELD pjbp003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbp004>>----
         #Ctrlp:input.c.page5.pjbp004
#         ON ACTION controlp INFIELD pjbp004
            #add-point:ON ACTION controlp INFIELD pjbp004
            {<point name="input.c.page5.pjbp004" />}
            #END add-point

         #----<<pjbp005>>----
         #Ctrlp:input.c.page5.pjbp005
#         ON ACTION controlp INFIELD pjbp005
            #add-point:ON ACTION controlp INFIELD pjbp005
            {<point name="input.c.page5.pjbp005" />}
            #END add-point

         #----<<pjbp006>>----
         #Ctrlp:input.c.page5.pjbp006
#         ON ACTION controlp INFIELD pjbp006
            #add-point:ON ACTION controlp INFIELD pjbp006
            {<point name="input.c.page5.pjbp006" />}
            #END add-point



         AFTER ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbq5_d[l_ac].* = g_pjbq5_d_t.*
               END IF
               CLOSE apjm300_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL apjm300_unlock_b("pjbp_t","5")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body5.after_input"/>}
            #end add-point

         #add-point:page5自定義行為
         {<point name="input.page5.action"/>}
         #end add-point

      END INPUT
      
      #Page1 預設值產生於此處
      INPUT ARRAY g_pjbq_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pjbq_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apjm300_b_fill()
            LET g_rec_b = g_pjbq_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input"/>}
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                                              


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apjm300_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apjm300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH apjm300_cl INTO g_pjbo_m.pjbn000,g_pjbo_m.pjbn000_desc,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbnl003,g_pjbo_m.pjbnl004,g_pjbo_m.pjbn003,g_pjbo_m.pjbn003_desc,g_pjbo_m.pjbn004,g_pjbo_m.pjbn004_desc,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbn008_desc,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnownid_desc,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbnowndp_desc,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtid_desc,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdp_desc,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmodid_desc,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfid_desc,g_pjbo_m.pjbncnfdt,g_pjbo_m.cbo_searchcol,g_pjbo_m.searchstr,g_pjbo_m.rdo_searchtype,g_pjbo_m.b_count,g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_pjbo_m.pjbo001,SQLCA.sqlcode,0)
            #   CLOSE apjm300_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_pjbq_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pjbq_d[l_ac].pjbq003 IS NOT NULL

            THEN
               LET l_cmd='u'
               LET g_pjbq_d_t.* = g_pjbq_d[l_ac].*  #BACKUP
               LET g_pjbq_d_o.* = g_pjbq_d[l_ac].*  #BACKUP   #170203-00002#6 20170203 add by beckxie
               CALL apjm300_set_entry_b(l_cmd)
               CALL apjm300_set_no_entry_b(l_cmd,'1',g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003)
               IF NOT apjm300_lock_b("pjbq_t","1") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm300_bcl INTO g_pjbq_d[l_ac].pjbq003,g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq004_desc,g_pjbq_d[l_ac].pjbq005,g_pjbq_d[l_ac].pjbq005_desc,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq006_desc,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pjbq_d_t.pjbq003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apjm300_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

            CALL apjm300_pjbq004_pjbq005_required()

            #其他table資料備份(確定是否更改用)


            #其他table進行lock


         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbq_d[l_ac].* TO NULL

            
            CALL cl_show_fld_cont()
            CALL apjm300_set_entry_b(l_cmd)
            CALL apjm300_set_no_entry_b(l_cmd,'','','')
            #公用欄位給值(單身)
            SELECT MAX(pjbq003) + 1 INTO g_pjbq_d[l_ac].pjbq003 FROM pjbq_t
             WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbo_m.pjbo001 
               AND pjbq002 = g_pjbo_m.pjbo002
            IF cl_null(g_pjbq_d[l_ac].pjbq003) THEN LET g_pjbq_d[l_ac].pjbq003 = 1 END IF
            LET g_pjbq_d_t.* = g_pjbq_d[l_ac].*     #新輸入資料
            LET g_pjbq_d_o.* = g_pjbq_d[l_ac].*     #新輸入資料   #170203-00002#6 20170203 add by beckxie

         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM pjbq_t
             WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbo_m.pjbo001
               AND pjbq002 = g_pjbo_m.pjbo002


               AND g_pjbq_d[l_ac].pjbq003 = pjbq003


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身新增前
               {<point name="input.body.b_insert"/>}
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_pjbo_m.pjbo001
               LET gs_keys[2] = g_pjbo_m.pjbo002
               LET gs_keys[3] = g_pjbq_d[g_detail_idx].pjbq003
               LET gs_keys[4] = g_pjbn_m.pjbn900
               CALL apjm300_insert_b('pjbq_t',gs_keys,"'1'")

               #add-point:單身新增後
               {<point name="input.body.a_insert"/>}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pjbq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm300_b_fill()
               #資料多語言用-增/改
               IF NOT apjm300_pjbq_ins_pjbu('3') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               #add-point:input段-after_insert
               {<point name="input.body.a_insert2"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         BEFORE DELETE                            #是否取消單身
         
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM pjbd_t
             WHERE pjbdent = g_enterprise
               AND pjbd001 = g_pjbn_m.pjbn001
               AND pjbd002 = g_pjbo_m.pjbo002 
               AND pjbd003 = g_pjbq_d_t.pjbq003
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apj-00047'
               LET g_errparam.extend = g_pjbq_d_t.pjbq003
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               CANCEL DELETE
            END IF   
            
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pjbq_d.deleteElement(l_ac)
               NEXT FIELD pjbq003
            END IF
            IF g_pjbq_d[l_ac].pjbq003 IS NOT NULL

               THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #add-point:單身刪除前
               {<point name="input.body.b_delete" mark="Y"/>}
               #end add-point

               DELETE FROM pjbq_t
                WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbn_m.pjbn001
                                             AND pjbq002 = g_pjbo_m.pjbo002 
                                             AND pjbq003 = g_pjbq_d_t.pjbq003
                                             AND pjbq900 = g_pjbn_m.pjbn900

                      


               #add-point:單身刪除中
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pjbq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  DELETE FROM pjbu_t
                   WHERE pjbuent = g_enterprise
                     AND pjbu001 = g_pjbn_m.pjbn001 
                 
                     AND pjbu002 = g_pjbo_m.pjbo002
                 
                     AND pjbu003 = g_pjbq_d_t.pjbq003
                     AND pjbu900 = g_pjbn_m.pjbn900
                                 
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身刪除後
                  {<point name="input.body.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE apjm300_bcl
               LET l_count = g_pjbq_d.getLength()
            END IF

            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_pjbo_m.pjbo001
            LET gs_keys[2] = g_pjbo_m.pjbo002
            LET gs_keys[3] = g_pjbq_d[g_detail_idx].pjbq003
            LET gs_keys[4] = g_pjbn_m.pjbn900

         AFTER DELETE
            #add-point:單身刪除後2
            {<point name="input.body.after_delete"/>}
            #end add-point
            CALL apjm300_delete_b('pjbq_t',gs_keys,"'1'")

         #---------------------<  Detail: page1  >---------------------
         #----<<pjbq003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq003
            #add-point:BEFORE FIELD pjbq003
            {<point name="input.b.page1.pjbq003" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq003

            #add-point:AFTER FIELD pjbq003
            #此段落由子樣板a05產生
            IF  g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq_d[g_detail_idx].pjbq003 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq_d[g_detail_idx].pjbq003 != g_pjbq_d_t.pjbq003)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbq_t WHERE "||"pjbqent = '" ||g_enterprise|| "' AND "||"pjbq001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbq002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbq003 = '"||g_pjbq_d[g_detail_idx].pjbq003 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbq003
            #add-point:ON CHANGE pjbq003
            {<point name="input.g.page1.pjbq003" />}
            #END add-point

         #----<<pjbq004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq004

            #add-point:AFTER FIELD pjbq004
            CALL apjm300_pjbq004_desc(g_pjbq_d[l_ac].pjbq004)
            IF NOT cl_null(g_pjbq_d[l_ac].pjbq004) THEN
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq_d[l_ac].pjbq004
               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_rtax001") THEN
                  LET g_pjbq_d[l_ac].pjbq004 = g_pjbq_d_t.pjbq004
                  CALL apjm300_pjbq004_desc(g_pjbq_d[l_ac].pjbq004)
                  NEXT FIELD CURRENT
               ELSE
                  INITIALIZE g_pjbq_d[l_ac].pjbq005 TO NULL
                  DISPLAY BY NAME g_pjbq_d[l_ac].pjbq005
                  CALL apjm300_pjbq005_desc('')
                  INITIALIZE g_pjbq_d[l_ac].pjbq006 TO NULL
                  DISPLAY BY NAME g_pjbq_d[l_ac].pjbq006
                  CALL apjm300_pjbq006_desc('')
               END IF
               
               IF  g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq_d[g_detail_idx].pjbq003 IS NOT NULL AND g_pjbq_d[g_detail_idx].pjbq004 IS NOT NULL THEN
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq_d[g_detail_idx].pjbq003 != g_pjbq_d_t.pjbq003 OR g_pjbq_d[g_detail_idx].pjbq004 != g_pjbq_d_t.pjbq004)) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbq_t WHERE "||"pjbqent = '" ||g_enterprise|| "' AND "||"pjbq001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbq002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbq003 = '"||g_pjbq_d[g_detail_idx].pjbq003 ||"' AND pjbq004 = '"||g_pjbq_d[g_detail_idx].pjbq004||"'",'std-00004',0) THEN
                        LET g_pjbq_d[l_ac].pjbq004 = g_pjbq_d_t.pjbq004
                        CALL apjm300_pjbq004_desc(g_pjbq_d[l_ac].pjbq004)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL apjm300_pjbq004_pjbq005_required()
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq004
            #add-point:BEFORE FIELD pjbq004
            {<point name="input.b.page1.pjbq004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq004
            #add-point:ON CHANGE pjbq004
            {<point name="input.g.page1.pjbq004" />}
            #END add-point

         #----<<pjbq005>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq005

            #add-point:AFTER FIELD pjbq005
            CALL apjm300_pjbq005_desc(g_pjbq_d[l_ac].pjbq005)
            IF NOT cl_null(g_pjbq_d[l_ac].pjbq005) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq_d[l_ac].pjbq005


               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaa001") THEN
                  INITIALIZE g_pjbq_d[l_ac].pjbq004 TO NULL
                  DISPLAY BY NAME g_pjbq_d[l_ac].pjbq004
                  CALL apjm300_pjbq004_desc('')
                  SELECT imaa006 INTO g_pjbq_d[l_ac].pjbq006 FROM imaa_t
                   WHERE imaaent = g_enterprise AND imaa001 = g_pjbq_d[l_ac].pjbq005
                  DISPLAY BY NAME g_pjbq_d[l_ac].pjbq006
                  CALL apjm300_pjbq006_desc(g_pjbq_d[l_ac].pjbq006)
               ELSE
                  #LET g_pjbq_d[l_ac].pjbq005 = g_pjbq_d_t.pjbq005   #170203-00002#6 20170203 mark by beckxie
                  #170203-00002#6 20170203 add by beckxie---S
                  LET g_pjbq_d[l_ac].pjbq005 = g_pjbq_d_o.pjbq005
                  LET g_pjbq_d[l_ac].pjbq004 = g_pjbq_d_o.pjbq004
                  LET g_pjbq_d[l_ac].pjbq004_desc = g_pjbq_d_o.pjbq004_desc
                  LET g_pjbq_d[l_ac].pjbq006 = g_pjbq_d_o.pjbq006
                  LET g_pjbq_d[l_ac].pjbq006_desc = g_pjbq_d_o.pjbq006_desc
                  #170203-00002#6 20170203 add by beckxie---E
                  CALL apjm300_pjbq005_desc(g_pjbq_d[l_ac].pjbq005)
                  NEXT FIELD CURRENT
               END IF
               IF  g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq_d[g_detail_idx].pjbq003 IS NOT NULL AND g_pjbq_d[g_detail_idx].pjbq005 IS NOT NULL THEN
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq_d[g_detail_idx].pjbq003 != g_pjbq_d_t.pjbq003 OR g_pjbq_d[g_detail_idx].pjbq005 != g_pjbq_d_t.pjbq005)) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbq_t WHERE "||"pjbqent = '" ||g_enterprise|| "' AND "||"pjbq001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbq002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbq003 = '"||g_pjbq_d[g_detail_idx].pjbq003 ||"' AND pjbq005 = '"||g_pjbq_d[g_detail_idx].pjbq005||"'",'std-00004',0) THEN
                        LET g_pjbq_d[l_ac].pjbq005 = g_pjbq_d_t.pjbq005
                        CALL apjm300_pjbq005_desc(g_pjbq_d[l_ac].pjbq005)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            CALL apjm300_pjbq004_pjbq005_required()
            LET g_pjbq_d_o.* = g_pjbq_d[l_ac].*   #170203-00002#6 20170203 add by beckxie
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq005
            #add-point:BEFORE FIELD pjbq005
            {<point name="input.b.page1.pjbq005" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq005
            #add-point:ON CHANGE pjbq005
            {<point name="input.g.page1.pjbq005" />}
            #END add-point

         #----<<pjbq006>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq006

            #add-point:AFTER FIELD pjbq006
            CALL apjm300_pjbq006_desc(g_pjbq_d[l_ac].pjbq006)
            IF NOT cl_null(g_pjbq_d[l_ac].pjbq006) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq_d[l_ac].pjbq006

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbq_d[l_ac].pjbq006 = g_pjbq_d_t.pjbq006
                  CALL apjm300_pjbq006_desc(g_pjbq_d[l_ac].pjbq006)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq006
            #add-point:BEFORE FIELD pjbq006
            {<point name="input.b.page1.pjbq006" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq006
            #add-point:ON CHANGE pjbq006
            {<point name="input.g.page1.pjbq006" />}
            #END add-point

         #----<<pjbq007>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq007
            #此段落由子樣板a15產生
            #add-point:AFTER FIELD pjbq007

            IF NOT cl_null(g_pjbq_d[l_ac].pjbq007) THEN
               IF g_pjbq_d[l_ac].pjbq007 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = g_pjbq_d[l_ac].pjbq007
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbq_d[l_ac].pjbq007 = g_pjbq_d_t.pjbq007     
                  NEXT FIELD CURRENT     
               END IF                  
            END IF
            CALL apjm300_pjbq009_count()
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq007
            #add-point:BEFORE FIELD pjbq007
            {<point name="input.b.page1.pjbq007" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq007
            #add-point:ON CHANGE pjbq007
            {<point name="input.g.page1.pjbq007" />}
            #END add-point

         #----<<pjbq008>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq008
            #此段落由子樣板a15產生
            IF NOT cl_null(g_pjbq_d[l_ac].pjbq008) THEN
               IF g_pjbq_d[l_ac].pjbq008 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = g_pjbq_d[l_ac].pjbq008
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbq_d[l_ac].pjbq008 = g_pjbq_d_t.pjbq008     
                  NEXT FIELD CURRENT   
               END IF                  
            END IF
            CALL apjm300_pjbq009_count()
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq008
            #add-point:BEFORE FIELD pjbq008
            {<point name="input.b.page1.pjbq008" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq008
            #add-point:ON CHANGE pjbq008
            {<point name="input.g.page1.pjbq008" />}
            #END add-point

         #----<<pjbq009>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbq009
            #此段落由子樣板a15產生
            IF NOT cl_null(g_pjbq_d[l_ac].pjbq009) THEN
               IF g_pjbq_d[l_ac].pjbq009 <= 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = g_pjbq_d[l_ac].pjbq009
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pjbq_d[l_ac].pjbq009 = g_pjbq_d_t.pjbq009     
                  NEXT FIELD CURRENT
               END IF  
               CALL apjm300_pjbq009_round()               
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbq009
            #add-point:BEFORE FIELD pjbq009
            {<point name="input.b.page1.pjbq009" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbq009
            #add-point:ON CHANGE pjbq009
            {<point name="input.g.page1.pjbq009" />}
            #END add-point

         #----<<pjbq010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbq010
            #add-point:BEFORE FIELD pjbq010
            {<point name="input.b.page1.pjbq010" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbq010

            #add-point:AFTER FIELD pjbq010
            {<point name="input.a.page1.pjbq010" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbq010
            #add-point:ON CHANGE pjbq010
            {<point name="input.g.page1.pjbq010" />}
            #END add-point


         #---------------------<  Detail: page1  >---------------------
         #----<<pjbq003>>----
         #Ctrlp:input.c.page1.pjbq003
#         ON ACTION controlp INFIELD pjbq003
            #add-point:ON ACTION controlp INFIELD pjbq003
            {<point name="input.c.page1.pjbq003" />}
            #END add-point

         #----<<pjbq004>>----
         #Ctrlp:input.c.page1.pjbq004
         ON ACTION controlp INFIELD pjbq004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		   	LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq_d[l_ac].pjbq004             #給予default值

            #給予arg

            CALL q_rtax001()                                #呼叫開窗

            LET g_pjbq_d[l_ac].pjbq004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq_d[l_ac].pjbq004 TO pjbq004              #顯示到畫面上
            CALL apjm300_pjbq004_desc(g_pjbq_d[l_ac].pjbq004)
            NEXT FIELD pjbq004
            

         #----<<pjbq005>>----
         #Ctrlp:input.c.page1.pjbq005
         ON ACTION controlp INFIELD pjbq005
            #add-point:ON ACTION controlp INFIELD pjbq005
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq_d[l_ac].pjbq005             #給予default值

            #給予arg

            CALL q_imaa001()                                #呼叫開窗

            LET g_pjbq_d[l_ac].pjbq005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq_d[l_ac].pjbq005 TO pjbq005              #顯示到畫面上
            CALL apjm300_pjbq005_desc(g_pjbq_d[l_ac].pjbq005)
            NEXT FIELD pjbq005                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbq006>>----
         #Ctrlp:input.c.page1.pjbq006
         ON ACTION controlp INFIELD pjbq006
            #add-point:ON ACTION controlp INFIELD pjbq006
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq_d[l_ac].pjbq006             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pjbq_d[l_ac].pjbq006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq_d[l_ac].pjbq006 TO pjbq006              #顯示到畫面上
            CALL apjm300_pjbq006_desc(g_pjbq_d[l_ac].pjbq006)
            NEXT FIELD pjbq006                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbq007>>----
         #Ctrlp:input.c.page1.pjbq007
#         ON ACTION controlp INFIELD pjbq007
            #add-point:ON ACTION controlp INFIELD pjbq007
            {<point name="input.c.page1.pjbq007" />}
            #END add-point

         #----<<pjbq008>>----
         #Ctrlp:input.c.page1.pjbq008
#         ON ACTION controlp INFIELD pjbq008
            #add-point:ON ACTION controlp INFIELD pjbq008
            {<point name="input.c.page1.pjbq008" />}
            #END add-point

         #----<<pjbq009>>----
         #Ctrlp:input.c.page1.pjbq009
#         ON ACTION controlp INFIELD pjbq009
            #add-point:ON ACTION controlp INFIELD pjbq009
            {<point name="input.c.page1.pjbq009" />}
            #END add-point

         #----<<pjbq010>>----
         #Ctrlp:input.c.page1.pjbq010
#         ON ACTION controlp INFIELD pjbq010
            #add-point:ON ACTION controlp INFIELD pjbq010
            {<point name="input.c.page1.pjbq010" />}
            #END add-point



         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pjbq_d[l_ac].* = g_pjbq_d_t.*
               CLOSE apjm300_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pjbq_d[l_ac].pjbq003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbq_d[l_ac].* = g_pjbq_d_t.*
            ELSE

               #add-point:單身修改前
               {<point name="input.body.b_update" mark="Y"/>}
               #end add-point

               #寫入修改者/修改日期資訊(單身)


               UPDATE pjbq_t SET (pjbq001,pjbq002,pjbq003,pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010) = (g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq005,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010)
                WHERE pjbqent = g_enterprise AND pjbq001 = g_pjbo_m.pjbo001
                  AND pjbq002 = g_pjbo_m.pjbo002
                  AND pjbq003 = g_pjbq_d_t.pjbq003 #項次
                  AND pjbq900 = g_pjbn_m.pjbn900
               #add-point:單身修改中
               {<point name="input.body.m_update"/>}
               #end add-point

               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbq_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq_d[l_ac].* = g_pjbq_d_t.*
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbq_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq_d[l_ac].* = g_pjbq_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pjbo_m.pjbo001
                     LET gs_keys_bak[1] = g_pjbo001_t
                     LET gs_keys[2] = g_pjbo_m.pjbo002
                     LET gs_keys_bak[2] = g_pjbo002_t
                     LET gs_keys[3] = g_pjbq_d[g_detail_idx].pjbq003
                     LET gs_keys_bak[3] = g_pjbq_d_t.pjbq003
                     LET gs_keys[4] = g_pjbn_m.pjbn900
                     LET gs_keys_bak[4] = g_pjbn900_t                
                     CALL apjm300_update_b('pjbq_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改

               END CASE

               #add-point:單身修改後
               IF NOT apjm300_pjbq_ins_pjbu('2') THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point

            END IF

         AFTER ROW
            CALL apjm300_unlock_b("pjbq_t","1")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock


         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body.after_input"/>}
            #end add-point
            
         #add-point:page自定義行為
         {<point name="input.page.action"/>}
         #end add-point

      END INPUT

      INPUT ARRAY g_pjbq2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pjbq2_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apjm300_b_fill()
            LET g_rec_b = g_pjbq2_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input2"/>}
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbq2_d[l_ac].* TO NULL

            LET g_pjbq_d_t.* = g_pjbq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjm300_set_entry_b(l_cmd)
            CALL apjm300_set_no_entry_b(l_cmd,'','','')
            #公用欄位給值(單身{page})

            #add-point:modify段before insert
            {<point name="input.body2.before_insert"/>}
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET p_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                                               
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apjm300_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apjm300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH apjm300_cl INTO g_pjbo_m.pjbn000,g_pjbo_m.pjbn000_desc,g_pjbo_m.pjbn001,g_pjbo_m.pjbn002,g_pjbo_m.pjbnl003,g_pjbo_m.pjbnl004,g_pjbo_m.pjbn003,g_pjbo_m.pjbn003_desc,g_pjbo_m.pjbn004,g_pjbo_m.pjbn004_desc,g_pjbo_m.pjbn005,g_pjbo_m.pjbn006,g_pjbo_m.pjbnstus,g_pjbo_m.pjbn007,g_pjbo_m.pjbn008,g_pjbo_m.pjbn008_desc,g_pjbo_m.pjbnownid,g_pjbo_m.pjbnownid_desc,g_pjbo_m.pjbnowndp,g_pjbo_m.pjbnowndp_desc,g_pjbo_m.pjbncrtid,g_pjbo_m.pjbncrtid_desc,g_pjbo_m.pjbncrtdp,g_pjbo_m.pjbncrtdp_desc,g_pjbo_m.pjbncrtdt,g_pjbo_m.pjbnmodid,g_pjbo_m.pjbnmodid_desc,g_pjbo_m.pjbnmoddt,g_pjbo_m.pjbncnfid,g_pjbo_m.pjbncnfid_desc,g_pjbo_m.pjbncnfdt,g_pjbo_m.cbo_searchcol,g_pjbo_m.searchstr,g_pjbo_m.rdo_searchtype,g_pjbo_m.b_count,g_pjbo_m.pjbo002,g_pjbo_m.pjbol004,g_pjbo_m.pjbol005,g_pjbo_m.pjbo004,g_pjbo_m.pjbo004_desc,g_pjbo_m.pjbo003,g_pjbo_m.pjbo003_desc,g_pjbo_m.pjbo005,g_pjbo_m.pjbo006,g_pjbo_m.pjbo007,g_pjbo_m.pjbo008,g_pjbo_m.pjbo009,g_pjbo_m.pjbo010,g_pjbo_m.pjbo010_desc,g_pjbo_m.pjbo011,g_pjbo_m.pjbo011_desc,g_pjbo_m.pjbo012,g_pjbo_m.pjbo001 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_pjbo_m.pjbo001,SQLCA.sqlcode,0)
            #   CLOSE apjm300_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_pjbq2_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pjbq2_d[l_ac].pjbr003 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_pjbq2_d_t.* = g_pjbq2_d[l_ac].*  #BACKUP
               CALL apjm300_set_entry_b(l_cmd)
               CALL apjm300_set_no_entry_b(l_cmd,'2',g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003)
               IF NOT apjm300_lock_b("pjbr_t","2") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm300_bcl2 INTO g_pjbq2_d[l_ac].pjbr003,g_pjbq2_d[l_ac].pjbr003_desc,g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005,g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apjm300_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body2.before_row"/>}
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM pjbe_t
             WHERE pjbeent = g_enterprise
               AND pjbe001 = g_pjbn_m.pjbn001
               AND pjbe002 = g_pjbo_m.pjbo002 
               AND pjbe003 = g_pjbq2_d_t.pjbr003
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apj-00047'
               LET g_errparam.extend = g_pjbq2_d_t.pjbr003
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               CANCEL DELETE
            END IF            
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pjbq2_d.deleteElement(l_ac)
               NEXT FIELD pjbr003
            END IF
            IF g_pjbq2_d[l_ac].pjbr003 IS NOT NULL
            THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #add-point:單身2刪除前
               {<point name="input.body2.b_delete" mark="Y"/>}
               #end add-point

               DELETE FROM pjbr_t
                WHERE pjbrent = g_enterprise AND pjbr001 = g_pjbn_m.pjbn001
                                             AND pjbr002 = g_pjbo_m.pjbo002 
                                             AND pjbr003 = g_pjbq2_d_t.pjbr003
                                             AND pjbr900 = g_pjbn_m.pjbn900

               #add-point:單身2刪除中
               {<point name="input.body2.m_delete"/>}
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pjbq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  DELETE FROM pjbu_t
                   WHERE pjbuent = g_enterprise
                     AND pjbu001 = g_pjbn_m.pjbn001 
                 
                     AND pjbu002 = g_pjbo_m.pjbo002
                 
                     AND pjbu003 = g_pjbq2_d_t.pjbr003
                     AND pjbu900 = g_pjbn_m.pjbn900
                     
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身2刪除後
                  {<point name="input.body2.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE apjm300_bcl
               LET l_count = g_pjbq_d.getLength()
            END IF
            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_pjbo_m.pjbo001
            LET gs_keys[2] = g_pjbo_m.pjbo002
            LET gs_keys[3] = g_pjbq2_d[g_detail_idx].pjbr003
            LET gs_keys[4] = g_pjbn_m.pjbn900

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body2.after_delete"/>}
            #end add-point
            CALL apjm300_delete_b('pjbr_t',gs_keys,"'2'")
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM pjbr_t
             WHERE pjbrent = g_enterprise AND pjbr001 = g_pjbo_m.pjbo001
               AND pjbr002 = g_pjbo_m.pjbo002

               AND g_pjbq2_d[l_ac].pjbr003 = pjbr003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身2新增前
               {<point name="input.body2.b_insert"/>}
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_pjbo_m.pjbo001
               LET gs_keys[2] = g_pjbo_m.pjbo002
               LET gs_keys[3] = g_pjbq2_d[g_detail_idx].pjbr003
               LET gs_keys[4] = g_pjbn_m.pjbn900
               CALL apjm300_insert_b('pjbr_t',gs_keys,"'2'")

               #add-point:單身新增後2
               {<point name="input.body2.a_insert"/>}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pjbq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm300_b_fill()
               #資料多語言用-增/改
               IF NOT apjm300_pjbr_ins_pjbu('3') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               #add-point:單身新增後
               {<point name="input.body2.after_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pjbq2_d[l_ac].* = g_pjbq2_d_t.*
               CLOSE apjm300_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbq2_d[l_ac].* = g_pjbq2_d_t.*
            ELSE
               #add-point:單身page2修改前
               {<point name="input.body2.b_update" mark="Y"/>}
               #end add-point

               #寫入修改者/修改日期資訊(單身2)


               UPDATE pjbr_t SET (pjbr001,pjbr002,pjbr003,pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009) = (g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005,g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009) #自訂欄位頁簽
                WHERE pjbrent = g_enterprise AND pjbr001 = g_pjbo_m.pjbo001
                  AND pjbr002 = g_pjbo_m.pjbo002
                  AND pjbr003 = g_pjbq2_d_t.pjbr003 #項次
                  AND pjbr900 = g_pjbn_m.pjbn900
               #add-point:單身page2修改中
               {<point name="input.body2.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbr_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq2_d[l_ac].* = g_pjbq2_d_t.*
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbr_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq2_d[l_ac].* = g_pjbq2_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pjbo_m.pjbo001
                     LET gs_keys_bak[1] = g_pjbo001_t
                     LET gs_keys[2] = g_pjbo_m.pjbo002
                     LET gs_keys_bak[2] = g_pjbo002_t
                     LET gs_keys[3] = g_pjbq2_d[g_detail_idx].pjbr003
                     LET gs_keys_bak[3] = g_pjbq2_d_t.pjbr003
                     LET gs_keys[4] = g_pjbn_m.pjbn900
                     LET gs_keys_bak[4] = g_pjbn900_t                
                     CALL apjm300_update_b('pjbr_t',gs_keys,gs_keys_bak,"'2'")
                           #資料多語言用-增/改

               END CASE

               #add-point:單身page2修改後
               IF NOT apjm300_pjbr_ins_pjbu('2') THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point

            END IF

         #---------------------<  Detail: page2  >---------------------
         #----<<pjbr003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr003

            #add-point:AFTER FIELD pjbr003

            
            CALL apjm300_pjbr003_desc(g_pjbq2_d[l_ac].pjbr003)
            #此段落由子樣板a05產生
            
            
            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr003) THEN
               IF NOT s_azzi650_chk_exist('8002',g_pjbq2_d[l_ac].pjbr003) THEN
                  LET g_pjbq2_d[l_ac].pjbr003 = g_pjbq2_d_t.pjbr003
                  CALL apjm300_pjbr003_desc(g_pjbq2_d[l_ac].pjbr003)
                  NEXT FIELD CURRENT
               END IF
               IF g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq2_d[g_detail_idx].pjbr003 IS NOT NULL THEN
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq2_d[g_detail_idx].pjbr003 != g_pjbq2_d_t.pjbr003)) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbr_t WHERE "||"pjbrent = '" ||g_enterprise|| "' AND "||"pjbr001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbr002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbr003 = '"||g_pjbq2_d[g_detail_idx].pjbr003 ||"'",'std-00004',0) THEN
                        LET g_pjbq2_d[l_ac].pjbr003 = g_pjbq2_d_t.pjbr003
                        CALL apjm300_pjbr003_desc(g_pjbq2_d[l_ac].pjbr003)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr003
            #add-point:BEFORE FIELD pjbr003
            {<point name="input.b.page2.pjbr003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr003
            #add-point:ON CHANGE pjbr003
            {<point name="input.g.page2.pjbr003" />}
            #END add-point

         #----<<pjbr004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr004
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq2_d[l_ac].pjbr004,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbr004
            END IF


            #add-point:AFTER FIELD pjbr004

            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr004) THEN
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr004
            #add-point:BEFORE FIELD pjbr004
            {<point name="input.b.page2.pjbr004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr004
            #add-point:ON CHANGE pjbr004
            {<point name="input.g.page2.pjbr004" />}
            #END add-point

         #----<<pjbr005>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr005
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq2_d[l_ac].pjbr005,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbr005
            END IF


            #add-point:AFTER FIELD pjbr005

            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr005) THEN
               CALL apjm300_pjbr008_count()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr005
            #add-point:BEFORE FIELD pjbr005
            {<point name="input.b.page2.pjbr005" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr005
            #add-point:ON CHANGE pjbr005
            {<point name="input.g.page2.pjbr005" />}
            #END add-point

         #----<<pjbr006>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq2_d[l_ac].pjbr006,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbr006
            END IF


            #add-point:AFTER FIELD pjbr006

            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr006) THEN
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr006
            #add-point:BEFORE FIELD pjbr006
            {<point name="input.b.page2.pjbr006" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr006
            #add-point:ON CHANGE pjbr006
            {<point name="input.g.page2.pjbr006" />}
            #END add-point

         #----<<pjbr007>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr007
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq2_d[l_ac].pjbr007,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbr007
            END IF


            #add-point:AFTER FIELD pjbr007

            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr007) THEN
               CALL apjm300_pjbr008_count()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr007
            #add-point:BEFORE FIELD pjbr007
            {<point name="input.b.page2.pjbr007" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr007
            #add-point:ON CHANGE pjbr007
            {<point name="input.g.page2.pjbr007" />}
            #END add-point

         #----<<pjbr008>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbr008
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq2_d[l_ac].pjbr008,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbr008
            END IF


            #add-point:AFTER FIELD pjbr008

            IF NOT cl_null(g_pjbq2_d[l_ac].pjbr008) THEN
               CALL apjm300_pjbr008_round()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbr008
            #add-point:BEFORE FIELD pjbr008
            {<point name="input.b.page2.pjbr008" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbr008
            #add-point:ON CHANGE pjbr008
            {<point name="input.g.page2.pjbr008" />}
            #END add-point

         #----<<pjbr009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbr009
            #add-point:BEFORE FIELD pjbr009
            {<point name="input.b.page2.pjbr009" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbr009

            #add-point:AFTER FIELD pjbr009
            {<point name="input.a.page2.pjbr009" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbr009
            #add-point:ON CHANGE pjbr009
            {<point name="input.g.page2.pjbr009" />}
            #END add-point


         #---------------------<  Detail: page2  >---------------------
         #----<<pjbr003>>----
         #Ctrlp:input.c.page2.pjbr003
         ON ACTION controlp INFIELD pjbr003
            #add-point:ON ACTION controlp INFIELD pjbr003
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq2_d[l_ac].pjbr003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "8002" #

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_pjbq2_d[l_ac].pjbr003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq2_d[l_ac].pjbr003 TO pjbr003              #顯示到畫面上
            CALL apjm300_pjbr003_desc(g_pjbq2_d[l_ac].pjbr003)
            NEXT FIELD pjbr003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbr004>>----
         #Ctrlp:input.c.page2.pjbr004
#         ON ACTION controlp INFIELD pjbr004
            #add-point:ON ACTION controlp INFIELD pjbr004
            {<point name="input.c.page2.pjbr004" />}
            #END add-point

         #----<<pjbr005>>----
         #Ctrlp:input.c.page2.pjbr005
#         ON ACTION controlp INFIELD pjbr005
            #add-point:ON ACTION controlp INFIELD pjbr005
            {<point name="input.c.page2.pjbr005" />}
            #END add-point

         #----<<pjbr006>>----
         #Ctrlp:input.c.page2.pjbr006
#         ON ACTION controlp INFIELD pjbr006
            #add-point:ON ACTION controlp INFIELD pjbr006
            {<point name="input.c.page2.pjbr006" />}
            #END add-point

         #----<<pjbr007>>----
         #Ctrlp:input.c.page2.pjbr007
#         ON ACTION controlp INFIELD pjbr007
            #add-point:ON ACTION controlp INFIELD pjbr007
            {<point name="input.c.page2.pjbr007" />}
            #END add-point

         #----<<pjbr008>>----
         #Ctrlp:input.c.page2.pjbr008
#         ON ACTION controlp INFIELD pjbr008
            #add-point:ON ACTION controlp INFIELD pjbr008
            {<point name="input.c.page2.pjbr008" />}
            #END add-point

         #----<<pjbr009>>----
         #Ctrlp:input.c.page2.pjbr009
#         ON ACTION controlp INFIELD pjbr009
            #add-point:ON ACTION controlp INFIELD pjbr009
            {<point name="input.c.page2.pjbr009" />}
            #END add-point



         AFTER ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbq2_d[l_ac].* = g_pjbq2_d_t.*
               END IF
               CLOSE apjm300_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL apjm300_unlock_b("pjbr_t","2")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body2.after_input"/>}
            #end add-point

         #add-point:page2自定義行為
         {<point name="input.page2.action"/>}
         #end add-point

      END INPUT

      INPUT ARRAY g_pjbq3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pjbq3_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apjm300_b_fill()
            LET g_rec_b = g_pjbq3_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input3"/>}
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbq3_d[l_ac].* TO NULL

            LET g_pjbq_d_t.* = g_pjbq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjm300_set_entry_b(l_cmd)
            CALL apjm300_set_no_entry_b(l_cmd,'','','')
            #公用欄位給值(單身{page})

            #add-point:modify段before insert
            {<point name="input.body3.before_insert"/>}
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET p_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                                             
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apjm300_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apjm300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            LET g_rec_b = g_pjbq3_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pjbq3_d[l_ac].pjbs003 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_pjbq3_d_t.* = g_pjbq3_d[l_ac].*  #BACKUP
               CALL apjm300_set_entry_b(l_cmd)
               CALL apjm300_set_no_entry_b(l_cmd,'3',g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003)
               IF NOT apjm300_lock_b("pjbs_t","3") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm300_bcl3 INTO g_pjbq3_d[l_ac].pjbs003,g_pjbq3_d[l_ac].pjbs003_desc,g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs004_desc,g_pjbq3_d[l_ac].pjbs005,g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apjm300_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body3.before_row"/>}
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM pjbf_t
             WHERE pjbfent = g_enterprise
               AND pjbf001 = g_pjbn_m.pjbn001
               AND pjbf002 = g_pjbo_m.pjbo002 
               AND pjbf003 = g_pjbq3_d_t.pjbs003
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apj-00047'
               LET g_errparam.extend = g_pjbq3_d_t.pjbs003
               LET g_errparam.popup = TRUE
               CALL cl_err()            
               CANCEL DELETE
            END IF          
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pjbq3_d.deleteElement(l_ac)
               NEXT FIELD pjbs003
            END IF
            IF g_pjbq3_d[l_ac].pjbs003 IS NOT NULL
            THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #add-point:單身3刪除前
               {<point name="input.body3.b_delete" mark="Y"/>}
               #end add-point

               DELETE FROM pjbs_t
                WHERE pjbsent = g_enterprise AND pjbs001 = g_pjbn_m.pjbn001 
                                             AND pjbs002 = g_pjbo_m.pjbo002 

                                             AND pjbs003 = g_pjbq3_d_t.pjbs003
                                             AND pjbs900 = g_pjbn_m.pjbn900

               #add-point:單身3刪除中
               {<point name="input.body3.m_delete"/>}
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pjbq_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  DELETE FROM pjbu_t
                   WHERE pjbuent = g_enterprise
                     AND pjbu001 = g_pjbn_m.pjbn001 
                 
                     AND pjbu002 = g_pjbo_m.pjbo002
                 
                     AND pjbu003 = g_pjbq3_d_t.pjbs003
                     AND pjbu900 = g_pjbn_m.pjbn900               
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身3刪除後
                  {<point name="input.body3.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE apjm300_bcl
               LET l_count = g_pjbq_d.getLength()
            END IF
            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_pjbo_m.pjbo001
            LET gs_keys[2] = g_pjbo_m.pjbo002
            LET gs_keys[3] = g_pjbq3_d[g_detail_idx].pjbs003
            LET gs_keys[4] = g_pjbn_m.pjbn900

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body3.after_delete"/>}
            #end add-point
            CALL apjm300_delete_b('pjbs_t',gs_keys,"'3'")
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM pjbs_t
             WHERE pjbsent = g_enterprise AND pjbs001 = g_pjbo_m.pjbo001
               AND pjbs002 = g_pjbo_m.pjbo002

               AND g_pjbq3_d[l_ac].pjbs003 = pjbs003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身3新增前
               {<point name="input.body3.b_insert"/>}
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_pjbo_m.pjbo001
               LET gs_keys[2] = g_pjbo_m.pjbo002
               LET gs_keys[3] = g_pjbq3_d[g_detail_idx].pjbs003
               LET gs_keys[4] = g_pjbn_m.pjbn900
               CALL apjm300_insert_b('pjbs_t',gs_keys,"'3'")

               #add-point:單身新增後3
               {<point name="input.body3.a_insert"/>}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pjbq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm300_b_fill()
               #資料多語言用-增/改
               IF NOT apjm300_pjbs_ins_pjbu('3') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               #add-point:單身新增後
               {<point name="input.body3.after_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pjbq3_d[l_ac].* = g_pjbq3_d_t.*
               CLOSE apjm300_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbq3_d[l_ac].* = g_pjbq3_d_t.*
            ELSE
               #add-point:單身page3修改前
               {<point name="input.body3.b_update" mark="Y"/>}
               #end add-point

               #寫入修改者/修改日期資訊(單身3)


               UPDATE pjbs_t SET (pjbs001,pjbs002,pjbs003,pjbs004,pjbs005,pjbs006,pjbs007,pjbs008) = (g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs005,g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008) #自訂欄位頁簽
                WHERE pjbsent = g_enterprise AND pjbs001 = g_pjbo_m.pjbo001
                  AND pjbs002 = g_pjbo_m.pjbo002
                  AND pjbs003 = g_pjbq3_d_t.pjbs003 #項次
                  AND pjbs900 = g_pjbn_m.pjbn900
               #add-point:單身page3修改中
               {<point name="input.body3.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbs_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq3_d[l_ac].* = g_pjbq3_d_t.*
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbs_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq3_d[l_ac].* = g_pjbq3_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pjbo_m.pjbo001
                     LET gs_keys_bak[1] = g_pjbo001_t
                     LET gs_keys[2] = g_pjbo_m.pjbo002
                     LET gs_keys_bak[2] = g_pjbo002_t
                     LET gs_keys[3] = g_pjbq3_d[g_detail_idx].pjbs003
                     LET gs_keys_bak[3] = g_pjbq3_d_t.pjbs003
                     LET gs_keys[4] = g_pjbn_m.pjbn900
                     LET gs_keys_bak[4] = g_pjbn900_t                
                     CALL apjm300_update_b('pjbs_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改

               END CASE

               #add-point:單身page3修改後
               IF NOT apjm300_pjbs_ins_pjbu('2') THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point

            END IF

         #---------------------<  Detail: page3  >---------------------
         #----<<pjbs003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbs003

            #add-point:AFTER FIELD pjbs003
            CALL apjm300_pjbs003_desc(g_pjbq3_d[l_ac].pjbs003)
            IF NOT cl_null(g_pjbq3_d[l_ac].pjbs003) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq3_d[l_ac].pjbs003

               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
               #160318-00025#23  by 07900 --add-end 
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mrba001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbq3_d[l_ac].pjbs003 = g_pjbq3_d_t.pjbs003
                  CALL apjm300_pjbs003_desc(g_pjbq3_d[l_ac].pjbs003)
                  NEXT FIELD CURRENT
               END IF
               IF g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq3_d[g_detail_idx].pjbs003 IS NOT NULL THEN
                  IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq3_d[g_detail_idx].pjbs003 != g_pjbq3_d_t.pjbs003)) THEN
                     IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbs_t WHERE "||"pjbsent = '" ||g_enterprise|| "' AND "||"pjbs001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbs002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbs003 = '"||g_pjbq3_d[g_detail_idx].pjbs003 ||"'",'std-00004',0) THEN
                         LET g_pjbq3_d[l_ac].pjbs003 = g_pjbq3_d_t.pjbs003
                         CALL apjm300_pjbs003_desc(g_pjbq3_d[l_ac].pjbs003)
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF
            

            #此段落由子樣板a05產生
            

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbs003
            #add-point:BEFORE FIELD pjbs003
            {<point name="input.b.page3.pjbs003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbs003
            #add-point:ON CHANGE pjbs003
            {<point name="input.g.page3.pjbs003" />}
            #END add-point

         #----<<pjbs004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbs004

            #add-point:AFTER FIELD pjbs004
            CALL apjm300_pjbs004_desc(g_pjbq3_d[l_ac].pjbs004)
            IF NOT cl_null(g_pjbq3_d[l_ac].pjbs004) THEN
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pjbq3_d[l_ac].pjbs004
               #160318-00025#23  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#23  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME

               ELSE
                  #檢查失敗時後續處理
                  LET g_pjbq3_d[l_ac].pjbs004 = g_pjbq3_d_t.pjbs004
                  CALL apjm300_pjbs004_desc(g_pjbq3_d[l_ac].pjbs004)
                  NEXT FIELD CURRENT
               END IF


            END IF
            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbs004
            #add-point:BEFORE FIELD pjbs004
            {<point name="input.b.page3.pjbs004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbs004
            #add-point:ON CHANGE pjbs004
            {<point name="input.g.page3.pjbs004" />}
            #END add-point

         #----<<pjbs005>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbs005
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq3_d[l_ac].pjbs005,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbs005
            END IF


            #add-point:AFTER FIELD pjbs005

            IF NOT cl_null(g_pjbq3_d[l_ac].pjbs005) THEN
               CALL apjm300_pjbs007_count()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbs005
            #add-point:BEFORE FIELD pjbs005
            {<point name="input.b.page3.pjbs005" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbs005
            #add-point:ON CHANGE pjbs005
            {<point name="input.g.page3.pjbs005" />}
            #END add-point

         #----<<pjbs006>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbs006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq3_d[l_ac].pjbs006,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbs006
            END IF


            #add-point:AFTER FIELD pjbs006

            IF NOT cl_null(g_pjbq3_d[l_ac].pjbs006) THEN
               CALL apjm300_pjbs007_count()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbs006
            #add-point:BEFORE FIELD pjbs006
            {<point name="input.b.page3.pjbs006" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbs006
            #add-point:ON CHANGE pjbs006
            {<point name="input.g.page3.pjbs006" />}
            #END add-point

         #----<<pjbs007>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbs007
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq3_d[l_ac].pjbs007,"1.000","1","","","azz-00079",1) THEN
               NEXT FIELD pjbs007
            END IF


            #add-point:AFTER FIELD pjbs007

            IF NOT cl_null(g_pjbq3_d[l_ac].pjbs007) THEN
               CALL apjm300_pjbs007_round()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbs007
            #add-point:BEFORE FIELD pjbs007
            {<point name="input.b.page3.pjbs007" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbs007
            #add-point:ON CHANGE pjbs007
            {<point name="input.g.page3.pjbs007" />}
            #END add-point

         #----<<pjbs008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbs008
            #add-point:BEFORE FIELD pjbs008
            {<point name="input.b.page3.pjbs008" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbs008

            #add-point:AFTER FIELD pjbs008
            {<point name="input.a.page3.pjbs008" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbs008
            #add-point:ON CHANGE pjbs008
            {<point name="input.g.page3.pjbs008" />}
            #END add-point


         #---------------------<  Detail: page3  >---------------------
         #----<<pjbs003>>----
         #Ctrlp:input.c.page3.pjbs003
         ON ACTION controlp INFIELD pjbs003
            #add-point:ON ACTION controlp INFIELD pjbs003
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq3_d[l_ac].pjbs003             #給予default值

            #給予arg

            CALL q_mrba001_10()                                #呼叫開窗

            LET g_pjbq3_d[l_ac].pjbs003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq3_d[l_ac].pjbs003 TO pjbs003              #顯示到畫面上
            CALL apjm300_pjbs003_desc(g_pjbq3_d[l_ac].pjbs003)
            NEXT FIELD pjbs003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbs004>>----
         #Ctrlp:input.c.page3.pjbs004
         ON ACTION controlp INFIELD pjbs004
            #add-point:ON ACTION controlp INFIELD pjbs004
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq3_d[l_ac].pjbs004             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pjbq3_d[l_ac].pjbs004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq3_d[l_ac].pjbs004 TO pjbs004              #顯示到畫面上
            CALL apjm300_pjbs004_desc(g_pjbq3_d[l_ac].pjbs004)
            NEXT FIELD pjbs004                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbs005>>----
         #Ctrlp:input.c.page3.pjbs005
#         ON ACTION controlp INFIELD pjbs005
            #add-point:ON ACTION controlp INFIELD pjbs005
            {<point name="input.c.page3.pjbs005" />}
            #END add-point

         #----<<pjbs006>>----
         #Ctrlp:input.c.page3.pjbs006
#         ON ACTION controlp INFIELD pjbs006
            #add-point:ON ACTION controlp INFIELD pjbs006
            {<point name="input.c.page3.pjbs006" />}
            #END add-point

         #----<<pjbs007>>----
         #Ctrlp:input.c.page3.pjbs007
#         ON ACTION controlp INFIELD pjbs007
            #add-point:ON ACTION controlp INFIELD pjbs007
            {<point name="input.c.page3.pjbs007" />}
            #END add-point

         #----<<pjbs008>>----
         #Ctrlp:input.c.page3.pjbs008
#         ON ACTION controlp INFIELD pjbs008
            #add-point:ON ACTION controlp INFIELD pjbs008
            {<point name="input.c.page3.pjbs008" />}
            #END add-point



         AFTER ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbq3_d[l_ac].* = g_pjbq3_d_t.*
               END IF
               CLOSE apjm300_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL apjm300_unlock_b("pjbs_t","3")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body3.after_input"/>}
            #end add-point

         #add-point:page3自定義行為
         {<point name="input.page3.action"/>}
         #end add-point

      END INPUT

      INPUT ARRAY g_pjbq4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_pjbq4_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL apjm300_b_fill()
            LET g_rec_b = g_pjbq4_d.getLength()
            #add-point:資料輸入前
            {<point name="input.d.before_input4"/>}
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pjbq4_d[l_ac].* TO NULL

            LET g_pjbq_d_t.* = g_pjbq_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apjm300_set_entry_b(l_cmd)
            CALL apjm300_set_no_entry_b(l_cmd,'','','')
            #公用欄位給值(單身{page})

            #add-point:modify段before insert
            {<point name="input.body4.before_insert"/>}
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET p_cmd = ''
            #CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_n TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN apjm300_cl USING g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900
                                                              
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN apjm300_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE apjm300_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            LET g_rec_b = g_pjbq4_d.getLength()

            IF g_rec_b >= l_ac
               AND g_pjbq4_d[l_ac].pjbt003 IS NOT NULL
            THEN
               LET l_cmd='u'
               LET g_pjbq4_d_t.* = g_pjbq4_d[l_ac].*  #BACKUP
               CALL apjm300_set_entry_b(l_cmd)
               CALL apjm300_set_no_entry_b(l_cmd,'4',g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003)
               IF NOT apjm300_lock_b("pjbt_t","4") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apjm300_bcl4 INTO g_pjbq4_d[l_ac].pjbt003,g_pjbq4_d[l_ac].pjbt003_desc,g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL apjm300_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            {<point name="input.body4.before_row"/>}
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            LET l_n = 0
            SELECT COUNT(*) INTO l_n FROM pjbg_t 
             WHERE pjbgent = g_enterprise 
               AND pjbg001 = g_pjbo_m.pjbo001
               AND pjbg002 = g_pjbo_m.pjbo002
               AND pjbg003 = g_pjbq4_d_t.pjbt003
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00385'
               LET g_errparam.extend = g_pjbq4_d_t.pjbt003
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               CANCEL DELETE
            END IF  
            
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_pjbq4_d.deleteElement(l_ac)
               NEXT FIELD pjbt003
            END IF
            IF g_pjbq4_d[l_ac].pjbt003 IS NOT NULL
            THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF

               #add-point:單身4刪除前
               {<point name="input.body4.b_delete" mark="Y"/>}
               #end add-point

               DELETE FROM pjbt_t
                WHERE pjbtent = g_enterprise AND pjbt001 = g_pjbn_m.pjbn001
                                             AND pjbt002 = g_pjbo_m.pjbo002 

                                             AND pjbt003 = g_pjbq4_d_t.pjbt003
                                             AND pjbt900 = g_pjbn_m.pjbn900

               #add-point:單身4刪除中
               {<point name="input.body4.m_delete"/>}
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbq_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  DELETE FROM pjbu_t
                   WHERE pjbuent = g_enterprise
                     AND pjbu001 = g_pjbn_m.pjbn001 
                 
                     AND pjbu002 = g_pjbo_m.pjbo002
                 
                     AND pjbu003 = g_pjbq4_d_t.pjbt003
                     AND pjbu900 = g_pjbn_m.pjbn900                  
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身4刪除後
                  {<point name="input.body4.a_delete"/>}
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE apjm300_bcl
               LET l_count = g_pjbq_d.getLength()
            END IF
            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_pjbo_m.pjbo001
            LET gs_keys[2] = g_pjbo_m.pjbo002
            LET gs_keys[3] = g_pjbq4_d[g_detail_idx].pjbt003
            LET gs_keys[4] = g_pjbn_m.pjbn900

         AFTER DELETE
            #add-point:單身AFTER DELETE
            {<point name="input.body4.after_delete"/>}
            #end add-point
            CALL apjm300_delete_b('pjbt_t',gs_keys,"'4'")
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM pjbt_t
             WHERE pjbtent = g_enterprise AND pjbt001 = g_pjbo_m.pjbo001
               AND pjbt002 = g_pjbo_m.pjbo002

               AND g_pjbq4_d[l_ac].pjbt003 = pjbt003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身4新增前
               {<point name="input.body4.b_insert"/>}
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_pjbo_m.pjbo001
               LET gs_keys[2] = g_pjbo_m.pjbo002
               LET gs_keys[3] = g_pjbq4_d[g_detail_idx].pjbt003
               LET gs_keys[4] = g_pjbn_m.pjbn900
               CALL apjm300_insert_b('pjbt_t',gs_keys,"'4'")

               #add-point:單身新增後4
               {<point name="input.body4.a_insert"/>}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pjbq_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pjbt_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apjm300_b_fill()
               #資料多語言用-增/改
               IF NOT apjm300_pjbt_ins_pjbu('3') THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT               
               END IF
               #add-point:單身新增後
               {<point name="input.body4.after_insert"/>}
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pjbq4_d[l_ac].* = g_pjbq4_d_t.*
               CLOSE apjm300_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pjbq4_d[l_ac].* = g_pjbq4_d_t.*
            ELSE
               #add-point:單身page4修改前
               {<point name="input.body4.b_update" mark="Y"/>}
               #end add-point

               #寫入修改者/修改日期資訊(單身4)


               UPDATE pjbt_t SET (pjbt001,pjbt002,pjbt003,pjbt004,pjbt005) = (g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005) #自訂欄位頁簽
                WHERE pjbtent = g_enterprise AND pjbt001 = g_pjbo_m.pjbo001
                  AND pjbt002 = g_pjbo_m.pjbo002
                  AND pjbt003 = g_pjbq4_d_t.pjbt003 #項次
                  AND pjbt900 = g_pjbn_m.pjbn900
               #add-point:單身page4修改中
               {<point name="input.body4.m_update"/>}
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "pjbt_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq4_d[l_ac].* = g_pjbq4_d_t.*
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pjbt_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_pjbq4_d[l_ac].* = g_pjbq4_d_t.*
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL
                     LET gs_keys[1] = g_pjbo_m.pjbo001
                     LET gs_keys_bak[1] = g_pjbo001_t
                     LET gs_keys[2] = g_pjbo_m.pjbo002
                     LET gs_keys_bak[2] = g_pjbo002_t
                     LET gs_keys[3] = g_pjbq4_d[g_detail_idx].pjbt003
                     LET gs_keys_bak[3] = g_pjbq4_d_t.pjbt003
                     LET gs_keys[4] = g_pjbn_m.pjbn900
                     LET gs_keys_bak[4] = g_pjbn900_t                      
                     CALL apjm300_update_b('pjbt_t',gs_keys,gs_keys_bak,"'4'")
                           #資料多語言用-增/改
                    
               END CASE

               #add-point:單身page4修改後
               IF NOT apjm300_pjbt_ins_pjbu('2') THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point

            END IF

         #---------------------<  Detail: page4  >---------------------
         #----<<pjbt003>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbt003

            #add-point:AFTER FIELD pjbt003

            CALL apjm300_pjbt003_desc(g_pjbq4_d[l_ac].pjbt003)

            #此段落由子樣板a05產生
            IF  g_pjbo_m.pjbo001 IS NOT NULL AND g_pjbo_m.pjbo002 IS NOT NULL AND g_pjbq4_d[g_detail_idx].pjbt003 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pjbo_m.pjbo001 != g_pjbo001_t OR g_pjbo_m.pjbo002 != g_pjbo002_t OR g_pjbq4_d[g_detail_idx].pjbt003 != g_pjbq4_d_t.pjbt003)) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pjbt_t WHERE "||"pjbtent = '" ||g_enterprise|| "' AND "||"pjbt001 = '"||g_pjbo_m.pjbo001 ||"' AND "|| "pjbt002 = '"||g_pjbo_m.pjbo002 ||"' AND "|| "pjbt003 = '"||g_pjbq4_d[g_detail_idx].pjbt003 ||"'",'std-00004',0) THEN
                     LET g_pjbq4_d[l_ac].pjbt003 = g_pjbq4_d_t.pjbt003
                     CALL apjm300_pjbt003_desc(g_pjbq4_d[l_ac].pjbt003)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            IF NOT cl_null(g_pjbq4_d[l_ac].pjbt003) THEN
               IF NOT s_azzi650_chk_exist('8003',g_pjbq4_d[l_ac].pjbt003) THEN
                  LET g_pjbq4_d[l_ac].pjbt003 = g_pjbq4_d_t.pjbt003
                  CALL apjm300_pjbt003_desc(g_pjbq4_d[l_ac].pjbt003)
                  NEXT FIELD CURRENT
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbt003
            #add-point:BEFORE FIELD pjbt003
            {<point name="input.b.page4.pjbt003" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbt003
            #add-point:ON CHANGE pjbt003
            {<point name="input.g.page4.pjbt003" />}
            #END add-point

         #----<<pjbt004>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbt004
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_pjbq4_d[l_ac].pjbt004,"1.000","0","","","azz-00079",1) THEN
               NEXT FIELD pjbt004
            END IF


            #add-point:AFTER FIELD pjbt004

            IF NOT cl_null(g_pjbq4_d[l_ac].pjbt004) THEN
               CALL apjm300_pjbt004_round()
            END IF
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD pjbt004
            #add-point:BEFORE FIELD pjbt004
            {<point name="input.b.page4.pjbt004" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE pjbt004
            #add-point:ON CHANGE pjbt004
            {<point name="input.g.page4.pjbt004" />}
            #END add-point

         #----<<pjbt005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD pjbt005
            #add-point:BEFORE FIELD pjbt005
            {<point name="input.b.page4.pjbt005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD pjbt005

            #add-point:AFTER FIELD pjbt005
            {<point name="input.a.page4.pjbt005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE pjbt005
            #add-point:ON CHANGE pjbt005
            {<point name="input.g.page4.pjbt005" />}
            #END add-point


         #---------------------<  Detail: page4  >---------------------
         #----<<pjbt003>>----
         #Ctrlp:input.c.page4.pjbt003
         ON ACTION controlp INFIELD pjbt003
            #add-point:ON ACTION controlp INFIELD pjbt003
#此段落由子樣板a07產生
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjbq4_d[l_ac].pjbt003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = 8003 #

            CALL q_oocq002_1()                                #呼叫開窗

            LET g_pjbq4_d[l_ac].pjbt003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjbq4_d[l_ac].pjbt003 TO pjbt003              #顯示到畫面上
            CALL apjm300_pjbt003_desc(g_pjbq4_d[l_ac].pjbt003)
            NEXT FIELD pjbt003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<pjbt004>>----
         #Ctrlp:input.c.page4.pjbt004
#         ON ACTION controlp INFIELD pjbt004
            #add-point:ON ACTION controlp INFIELD pjbt004
            {<point name="input.c.page4.pjbt004" />}
            #END add-point

         #----<<pjbt005>>----
         #Ctrlp:input.c.page4.pjbt005
#         ON ACTION controlp INFIELD pjbt005
            #add-point:ON ACTION controlp INFIELD pjbt005
            {<point name="input.c.page4.pjbt005" />}
            #END add-point



         AFTER ROW
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_pjbq4_d[l_ac].* = g_pjbq4_d_t.*
               END IF
               CLOSE apjm300_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL apjm300_unlock_b("pjbt_t","4")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            {<point name="input.body4.after_input"/>}
            #end add-point

         #add-point:page4自定義行為
         {<point name="input.page4.action"/>}
         #end add-point

      END INPUT

      BEFORE DIALOG 
         CALL apjm300_head_color()  #add by lixh 20150713
         CALL cl_set_act_visible("reproduce,output",FALSE)  #add by lixh 20150803
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

END FUNCTION

PRIVATE FUNCTION apjm300_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   {<point name="lock_b.define"/>}
   #end add-point

   #先刷新資料
   #CALL apjm300_b_fill()

   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pjbq_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apjm300_bcl USING g_enterprise,
                                       g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq_d[g_detail_idx].pjbq003,g_pjbn_m.pjbn900

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apjm300_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF

   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "pjbr_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apjm300_bcl2 USING g_enterprise,
                                             g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq2_d[g_detail_idx].pjbr003,g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apjm300_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "pjbs_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apjm300_bcl3 USING g_enterprise,
                                             g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq3_d[g_detail_idx].pjbs003,g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apjm300_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "pjbt_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apjm300_bcl4 USING g_enterprise,
                                             g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,g_pjbq4_d[g_detail_idx].pjbt003,g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apjm300_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "pjbp_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN apjm300_bcl5 USING g_enterprise,
                                             g_pjbn_m.pjbn001,g_pjbq5_d[g_detail_idx].pjbp002,g_pjbq5_d[g_detail_idx].pjbp003,g_pjbn_m.pjbn900
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "apjm300_bcl5"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF



   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   {<point name="unlock_b.define"/>}
   #end add-point

   LET ls_group = "'1',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apjm300_bcl
   END IF

   LET ls_group = "'2',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apjm300_bcl2
   END IF

   LET ls_group = "'3',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apjm300_bcl3
   END IF

   LET ls_group = "'4',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apjm300_bcl4
   END IF

   LET ls_group = "'5',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apjm300_bcl5
   END IF


END FUNCTION

PRIVATE FUNCTION apjm300_set_entry_pjbo(p_cmd)
DEFINE p_cmd  LIKE type_t.chr1
   CALL cl_set_comp_entry("pjbo003,pjbo004",TRUE)
END FUNCTION

PRIVATE FUNCTION apjm300_get_pjbo002()
DEFINE l_pjaa008   LIKE pjaa_t.pjaa008
DEFINE l_pjaa009   LIKE pjaa_t.pjaa009 
DEFINE l_get_num_b   LIKE type_t.num5
DEFINE l_get_num_e   LIKE type_t.num5
DEFINE l_get_str   STRING
DEFINE l_max_num   LIKE pjbo_t.pjbo002
DEFINE l_max_pjbo003 LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_sql1      STRING
DEFINE l_format    STRING
DEFINE l_pjbo003   STRING
DEFINE l_cut_pjbo003 STRING
   SELECT pjaa008,pjaa009 INTO l_pjaa008,l_pjaa009 FROM pjaa_t
       WHERE pjaaent = g_enterprise AND pjaa001 = g_pjbn_m.pjbn000
   CALL apjm300_get_pjaa009_format(l_pjaa009) RETURNING l_format
   LET l_pjbo003 = g_pjbo_m.pjbo003
   LET l_cut_pjbo003 = cl_str_replace(l_pjbo003,'-','')
   LET l_sql = "SELECT MAX(",l_cut_pjbo003,") FROM pjbo_t "   #判断上阶WBS 是否只为00...(位数根据pjaa009所设定)
   PREPARE sel_max_pjbo003 FROM l_sql
   EXECUTE sel_max_pjbo003 INTO l_max_pjbo003
   
   LET l_sql1 = " FROM pjbo_t WHERE pjboent = ",g_enterprise,
                "  AND pjbo001 = '",g_pjbn_m.pjbn001,"' AND pjbo003 = '",g_pjbo_m.pjbo003,"'",
                "  AND pjbo900 = '",g_pjbn_m.pjbn900,"'" 
   IF l_max_pjbo003 != 0 THEN                       #如果上阶WBS不为根节点
#      LET l_get_str = l_cut_pjbo003
#      LET l_get_num_b = l_get_str.getLength() + 1
#      IF l_pjaa008 = '2' THEN
#         LET l_get_num_b = l_get_num_b + 1
#      END IF
#      LET l_get_num_e =  l_get_num_b + l_pjaa009 - 1
  
#      LET l_sql = "SELECT MAX(SUBSTR(pjbo002,",l_get_num_b,",",l_get_num_e,")) + 1",l_sql1
#      PREPARE sel_max_pjbo002_1 FROM l_sql
#      EXECUTE sel_max_pjbo002_1 INTO l_max_num
#      IF cl_null(l_max_num) THEN
#         CALL apjm300_get_auto_no(l_pjaa009,'N') RETURNING l_max_num
#      ELSE
#         LET l_max_num = l_max_num USING l_format  
#      END IF
#      IF l_pjaa008 = '2' THEN
#         LET g_pjbo_m.pjbo002 = g_pjbo_m.pjbo003,"-",l_max_num
#      ELSE
#         LET g_pjbo_m.pjbo002 = g_pjbo_m.pjbo003,l_max_num
#      END IF
      LET l_sql = "SELECT MAX(SUBSTR(pjbo002,-",l_pjaa009,")) + 1",l_sql1
      PREPARE sel_max_pjbo002_1 FROM l_sql
      EXECUTE sel_max_pjbo002_1 INTO l_max_num
      IF cl_null(l_max_num) THEN
         CALL apjm300_get_auto_no(l_pjaa009,'N') RETURNING l_max_num
      ELSE
         LET l_max_num = l_max_num USING l_format  
      END IF
      IF l_pjaa008 = '2' THEN
         LET g_pjbo_m.pjbo002 = g_pjbo_m.pjbo003,"-",l_max_num
      ELSE
         LET g_pjbo_m.pjbo002 = g_pjbo_m.pjbo003,l_max_num
      END IF
   ELSE
      LET l_sql = "SELECT MAX(pjbo002) + 1",l_sql1
      PREPARE sel_max_pjbo002_2 FROM l_sql
      EXECUTE sel_max_pjbo002_2 INTO l_max_num 
      IF cl_null(l_max_num) THEN
         CALL apjm300_get_auto_no(l_pjaa009,'N') RETURNING l_max_num
      ELSE
         LET l_max_num = l_max_num USING l_format 
      END IF
      LET g_pjbo_m.pjbo002 = l_max_num
   END IF
   DISPLAY BY NAME g_pjbo_m.pjbo002
END FUNCTION

PRIVATE FUNCTION apjm300_get_pjaa009_format(p_pjaa009)
DEFINE p_pjaa009  LIKE pjaa_t.pjaa009
DEFINE l_i        LIKE type_t.num5
DEFINE r_format   STRING
   FOR l_i = 1 TO p_pjaa009
       IF l_i = 1 THEN
          LET r_format = "&"
       ELSE
          LET r_format = r_format,"&"
       END IF
   END FOR
   RETURN r_format
END FUNCTION

PRIVATE FUNCTION apjm300_get_auto_no(p_pjaa009,p_flag)
DEFINE p_pjaa009  LIKE pjaa_t.pjaa009
DEFINE p_flag     LIKE type_t.chr1  
DEFINE r_pjbo002  LIKE pjbo_t.pjbo002
DEFINE l_i        LIKE type_t.num5
   FOR l_i = 1 TO p_pjaa009
       IF l_i = 1 THEN
          LET r_pjbo002 = "0"
       ELSE
          IF l_i = p_pjaa009 AND p_flag = 'N' THEN
             LET r_pjbo002 = r_pjbo002,"1"
             EXIT FOR
          END IF
          LET r_pjbo002 = r_pjbo002,"0"
       END IF
   END FOR
   RETURN r_pjbo002
END FUNCTION

PRIVATE FUNCTION apjm300_set_no_entry_pjbo(p_cmd)
DEFINE p_cmd  LIKE type_t.chr1
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("pjbo003,pjbo004",FALSE)
   END IF   
   IF g_pjbo_m.pjbo002 = g_pjbo_m.pjbo003 THEN
      CALL cl_set_comp_entry("pjbo003",FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION apjm300_pjbo003_desc(p_pjbo003)
DEFINE p_pjbo003  LIKE pjbo_t.pjbo003
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbn_m.pjbn001
   LET g_ref_fields[2] = p_pjbo003
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbol004 FROM pjbol_t WHERE pjbolent='"||g_enterprise||"' AND pjbol001=? AND pjbol002=? AND pjbol003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbo_m.pjbo003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pjbo_m.pjbo003_desc
END FUNCTION

PRIVATE FUNCTION apjm300_open_s01(p_pjbn001,p_pjbn003)
TYPE type_l_pjbn_m        RECORD
       pjbn005 LIKE pjbn_t.pjbn005, 
   pjbn007 LIKE pjbn_t.pjbn007, 
   pjbn008 LIKE pjbn_t.pjbn008, 
   pjbn008_desc LIKE type_t.chr80
       END RECORD
DEFINE l_pjbn_m        type_l_pjbn_m
DEFINE l_pjbn_m_t    type_l_pjbn_m
DEFINE g_pjbn_m_t    type_g_pjbn_m
   DEFINE p_pjbn001       LIKE pjbn_t.pjbn001
   DEFINE p_pjbn003       LIKE pjbn_t.pjbn003
  # DEFINE l_pjbo   RECORD LIKE pjbo_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_pjbo RECORD  #專案WBS變更單身檔
       pjboent LIKE pjbo_t.pjboent, #企业编号
       pjbo001 LIKE pjbo_t.pjbo001, #项目编号
       pjbo002 LIKE pjbo_t.pjbo002, #本阶WBS
       pjbo003 LIKE pjbo_t.pjbo003, #上阶WBS
       pjbo004 LIKE pjbo_t.pjbo004, #WBS类型
       pjbo005 LIKE pjbo_t.pjbo005, #计划起始日
       pjbo006 LIKE pjbo_t.pjbo006, #计划截止日
       pjbo007 LIKE pjbo_t.pjbo007, #工期天数
       pjbo008 LIKE pjbo_t.pjbo008, #工期时数
       pjbo009 LIKE pjbo_t.pjbo009, #里程碑
       pjbo010 LIKE pjbo_t.pjbo010, #负责人员
       pjbo011 LIKE pjbo_t.pjbo011, #负责部门
       pjbo012 LIKE pjbo_t.pjbo012, #状态码
       pjbo900 LIKE pjbo_t.pjbo900, #变更序
       pjbo901 LIKE pjbo_t.pjbo901, #变更类型
       pjbo902 LIKE pjbo_t.pjbo902, #变更日期
       pjbo903 LIKE pjbo_t.pjbo903, #变更理由
       pjbo904 LIKE pjbo_t.pjbo904, #变更备注
       pjbo013 LIKE pjbo_t.pjbo013, #发包总额
       pjbo014 LIKE pjbo_t.pjbo014, #未结案发包总额
       pjbo015 LIKE pjbo_t.pjbo015, #结案发包总额
       pjbo016 LIKE pjbo_t.pjbo016 #发包开账金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
   DEFINE l_date          LIKE type_t.dat
   #DEFINE l_pjbp   RECORD LIKE pjbp_t.*  #161124-00048#14  2016/12/15 By 08734 mark
   #161124-00048#14  2016/12/15 By 08734 add(S)
   DEFINE l_pjbp RECORD  #專案成員變更檔
       pjbpent LIKE pjbp_t.pjbpent, #企业编号
       pjbp001 LIKE pjbp_t.pjbp001, #项目编号
       pjbp002 LIKE pjbp_t.pjbp002, #项目角色
       pjbp003 LIKE pjbp_t.pjbp003, #员工编号
       pjbp004 LIKE pjbp_t.pjbp004, #生效日期
       pjbp005 LIKE pjbp_t.pjbp005, #失效日期
       pjbp006 LIKE pjbp_t.pjbp006, #备注
       pjbp900 LIKE pjbp_t.pjbp900, #变更序
       pjbp901 LIKE pjbp_t.pjbp901, #变更类型
       pjbp902 LIKE pjbp_t.pjbp902, #变更日期
       pjbp903 LIKE pjbp_t.pjbp903, #变更理由
       pjbp904 LIKE pjbp_t.pjbp904 #变更备注
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
   DEFINE l_work_date_b   LIKE type_t.dat
   DEFINE l_work_date_e   LIKE type_t.dat
   DEFINE l_work_days     LIKE type_t.num5
   DEFINE l_work_hours    LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_para          LIKE type_t.num5  
   DEFINE lwin_curr        ui.Window
   DEFINE lfrm_curr        ui.Form
   DEFINE ls_path          STRING   
   
   OPEN WINDOW w_apjm300_s01 WITH FORM cl_ap_formpath("apj","apjm300_s01")
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)

   LET g_qryparam.state = "i"
       CALL cl_set_combo_scc('pjbn007','16008')
   LET l_pjbn_m.pjbn007 = '1'
   SELECT ooef008 INTO l_pjbn_m.pjbn008 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = 'ALL'
   CALL apjm300_s01_pjbn008_desc(l_pjbn_m.pjbn008) RETURNING l_pjbn_m.pjbn008_desc
   DISPLAY BY NAME l_pjbn_m.pjbn008_desc
   #170207-00018#3    2017/02/10   By 08734 mark(S)
   #SELECT pjbo005 INTO l_pjbn_m.pjbn005 FROM pjbo_t
   # WHERE pjboent = g_enterprise AND pjbo001 = p_pjbn003 AND ROWNUM = 1
   #   ORDER BY pjbo002
   #170207-00018#3    2017/02/10   By 08734 mark(E) 
   #170207-00018#3    2017/02/10   By 08734 add(S)   
   SELECT A.pjbo005 INTO l_pjbn_m.pjbn005 FROM (SELECT pjbo005  FROM pjbo_t
    WHERE pjboent = g_enterprise AND pjbo001 = p_pjbn003 
      ORDER BY pjbo002) A
   WHERE ROWNUM = 1
   #170207-00018#3    2017/02/10   By 08734 add(E)
   LET l_pjbn_m_t.* = l_pjbn_m.*
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME l_pjbn_m.pjbn005,l_pjbn_m.pjbn007,l_pjbn_m.pjbn008 ATTRIBUTE(WITHOUT DEFAULTS)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理

            #end add-point
 
         #----<<pjbn008>>----
         #此段落由子樣板a02產生
         AFTER FIELD pjbn008
            
            #add-point:AFTER FIELD pjbn008
            CALL apjm300_s01_pjbn008_desc(l_pjbn_m.pjbn008) RETURNING l_pjbn_m.pjbn008_desc
            DISPLAY BY NAME l_pjbn_m.pjbn008_desc
            IF NOT cl_null(l_pjbn_m.pjbn008) THEN
               IF NOT s_aooi070_chk_exist('4',l_pjbn_m.pjbn008) THEN
                  LET l_pjbn_m.pjbn008 = l_pjbn_m_t.pjbn008
                  CALL apjm300_s01_pjbn008_desc(l_pjbn_m.pjbn008) RETURNING l_pjbn_m.pjbn008_desc
                  DISPLAY BY NAME l_pjbn_m.pjbn008_desc
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
         #----<<pjbn008>>----
         #Ctrlp:input.c.pjbn008
         ON ACTION controlp INFIELD pjbn008
            #add-point:ON ACTION controlp INFIELD pjbn008
#此段落由子樣板a07產生            
            #開窗i段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = l_pjbn_m.pjbn008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '4' #

            CALL q_ooal002_0()                                #呼叫開窗

            LET l_pjbn_m.pjbn008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY l_pjbn_m.pjbn008 TO pjbn008              #顯示到畫面上

            NEXT FIELD pjbn008                          #返回原欄位


            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理

            #end add-point
            
      END INPUT
    
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   CLOSE WINDOW w_apjm300_s01 
   
   #add-point:input段after input 
   IF NOT INT_FLAG THEN
      LET g_success = TRUE
      #DECLARE sel_pjbo_curs CURSOR FOR  SELECT * FROM pjbo_t WHERE pjboent = g_enterprise  #161124-00048#14  2016/12/15 By 08734 mark
      DECLARE sel_pjbo_curs CURSOR FOR  SELECT pjboent,pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,
       pjbo012,pjbo900,pjbo901,pjbo902,pjbo903,pjbo904,pjbo013,pjbo014,pjbo015,pjbo016 FROM pjbo_t WHERE pjboent = g_enterprise  #161124-00048#14  2016/12/15 By 08734 add
                                    AND pjbo001 = p_pjbn003
      FOREACH sel_pjbo_curs INTO l_pjbo.*
         IF SQLCA.SQLCODE THEN
            LET g_success = FALSE
            RETURN g_success
         END IF                                      #計算WBS 日期
         IF NOT cl_null(l_pjbo.pjbo005) AND NOT cl_null(l_pjbo.pjbo006) THEN
            LET l_date = l_pjbn_m.pjbn005 + (l_pjbo.pjbo006 - l_pjbo.pjbo005)
            

            
            UPDATE pjbo_t SET pjbo005 = l_pjbn_m.pjbn005,
                              pjbo006 = l_date
                        WHERE pjboent = g_enterprise
                          AND pjbo001 = p_pjbn001
                          AND pjbo002 = l_pjbo.pjbo002
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
               LET g_success = FALSE
               RETURN g_success
            END IF
            IF l_pjbn_m.pjbn007 MATCHES '[12]' THEN
               IF l_pjbn_m.pjbn007 = '1' THEN
                  LET l_flag = -1 
               ELSE
                  LET l_flag = 0 
               END IF
               LET l_work_date_b = s_date_get_latest_work_date(g_site,l_pjbn_m.pjbn008,'2',l_flag,l_pjbn_m.pjbn005)
               LET l_work_date_e = s_date_get_latest_work_date(g_site,l_pjbn_m.pjbn008,'2',l_flag,l_date)
               
               CALL cl_get_para(g_enterprise,g_site,'E-COM-0007') RETURNING l_para
               LET l_work_days = l_work_date_e - l_work_date_b
               LET l_work_hours =  l_work_days * l_para 
               UPDATE pjbo_t SET pjbo007 = l_work_days,
                                 pjbo008 = l_work_hours
                        WHERE pjboent = g_enterprise
                          AND pjbo001 = p_pjbn001
                          AND pjbo002 = l_pjbo.pjbo002
               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                  LET g_success = FALSE
                  RETURN g_success
               END IF
            END IF
         END IF         
      END FOREACH
      
      DECLARE sel_pjbp_curs CURSOR FOR                       #計算成員生效失效日期
        #SELECT * FROM pjbp_t WHERE pjbpent = g_enterprise  #161124-00048#14  2016/12/15 By 08734 mark
        SELECT pjbpent,pjbp001,pjbp002,pjbp003,pjbp004,pjbp005,
               pjbp006,pjbp900,pjbp901,pjbp902,pjbp903,pjbp904 
           FROM pjbp_t WHERE pjbpent = g_enterprise  #161124-00048#14  2016/12/15 By 08734 add
           AND pjbp001 = p_pjbn003
      FOREACH sel_pjbp_curs INTO l_pjbp.*
         IF SQLCA.SQLCODE THEN
            LET g_success = FALSE
            RETURN g_success
         END IF
         LET l_date = l_pjbn_m.pjbn005 + (l_pjbp.pjbp005 - l_pjbp.pjbp004)
         UPDATE pjbp_t SET pjbp004 = l_pjbn_m.pjbn005,
                              pjbp005 = l_date
                        WHERE pjbpent = g_enterprise
                          AND pjbp001 = p_pjbn001
                          AND pjbp002 = l_pjbp.pjbp002
                          AND pjbp003 = l_pjbp.pjbp003
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            LET g_success = FALSE
            RETURN g_success
         END IF
      END FOREACH        
   ELSE
      LET g_success = FALSE
   END IF
   IF g_success THEN
      UPDATE pjbn_t SET pjbn007 = l_pjbn_m.pjbn007,
                        pjbn008 = l_pjbn_m.pjbn008
                  WHERE pjbnent = g_enterprise
                    AND pjbn001 = p_pjbn001
      IF SQLCA.SQLCODE THEN
         LET g_success = FALSE
      END IF
   END IF
   RETURN g_success
END FUNCTION

PRIVATE FUNCTION apjm300_pjbn003_copy()
DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_success   LIKE type_t.num5   #add--2015/05/08 By shiun 增加編碼功能
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn000,"','",g_pjbn_m.pjbn001,"',pjbn900,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,",
                        "'",g_pjbn_m.pjbnownid,"','",g_pjbn_m.pjbnowndp,"','",g_pjbn_m.pjbncrtid,"','",g_pjbn_m.pjbncrtdp,"','','','','','','N' ",
                " FROM pjbn_t WHERE pjbnent = ",g_enterprise," AND pjbn001 = '",g_pjbn_m.pjbn003,"'", " AND pjbn900 = '",g_pjbn_m.pjbn900,"'"
   CALL s_aooi390_oofi_upd('15',g_pjbn_m.pjbn001) RETURNING l_success  #add--2015/05/08 By shiun 增加編碼功能
   LET l_sql = "INSERT INTO pjbn_t(pjbnent,pjbn000,pjbn001,pjbn900,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,",
               "pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,pjbncnfdt,pjbnstus) ",l_sql1
   PREPARE ins_pjbn_pre FROM l_sql
   EXECUTE ins_pjbn_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   UPDATE pjbn_t SET pjbncrtdt = g_pjbn_m.pjbncrtdt WHERE pjbnent = g_enterprise AND pjbn001 = g_pjbn_m.pjbn003 AND pjbn900 = g_pjbn_m.pjbn900
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbnl002,pjbnl003,pjbnl004",
                "  FROM pjbnl_t WHERE pjbnlent = ",g_enterprise," AND pjbnl001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbnl_t(pjbnlent,pjbnl001,pjbnl002,pjbnl003,pjbnl004) ",l_sql1
   PREPARE ins_pjbnl_pre FROM l_sql
   EXECUTE ins_pjbnl_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
    
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,'0' ",
                "  FROM pjbo_t WHERE pjboent = ",g_enterprise," AND pjbo001 = '",g_pjbn_m.pjbn003,"'" 
   LET l_sql = "INSERT INTO pjbo_t(pjboent,pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012) ",l_sql1
   PREPARE ins_pjbo_pre FROM l_sql
   EXECUTE ins_pjbo_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbol002,pjbol003,pjbol004,pjbol005",
                "  FROM pjbol_t WHERE pjbolent = ",g_enterprise," AND pjbol001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbol_t(pjbolent,pjbol001,pjbol002,pjbol003,pjbol004,pjbol005) ",l_sql1
   PREPARE ins_pjbol_pre FROM l_sql
   EXECUTE ins_pjbol_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbp002,pjbp003,pjbp004,pjbp005,pjbp006 ",
                "  FROM pjbp_t WHERE pjbpent = ",g_enterprise," AND pjbp001 = '",g_pjbn_m.pjbn003,"'" 
   LET l_sql = "INSERT INTO pjbp_t(pjbpent,pjbp001,pjbp002,pjbp003,pjbp004,pjbp005,pjbp006) ",l_sql1
   PREPARE ins_pjbp_pre FROM l_sql
   EXECUTE ins_pjbp_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbq002,pjbq003,pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010",
                "  FROM pjbq_t WHERE pjbqent = ",g_enterprise," AND pjbq001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbq_t(pjbqent,pjbq001,pjbq002,pjbq003,pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010) ",l_sql1
   PREPARE ins_pjbq_pre FROM l_sql
   EXECUTE ins_pjbq_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
    
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbr002,pjbr003,pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009 ",
                "  FROM pjbr_t WHERE pjbrent = ",g_enterprise," AND pjbr001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbr_t(pjbrent,pjbr001,pjbr002,pjbr003,pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009) ",l_sql1
   PREPARE ins_pjbr_pre FROM l_sql
   EXECUTE ins_pjbr_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbs002,pjbs003,pjbs004,pjbs005,pjbs006,pjbs007,pjbs008 ",
                "  FROM pjbs_t WHERE pjbsent = ",g_enterprise," AND pjbs001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbs_t(pjbsent,pjbs001,pjbs002,pjbs003,pjbs004,pjbs005,pjbs006,pjbs007,pjbs008) ",l_sql1
   PREPARE ins_pjbs_pre FROM l_sql
   EXECUTE ins_pjbs_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   LET l_sql1 = "SELECT ",g_enterprise,",'",g_pjbn_m.pjbn001,"',pjbt002,pjbt003,pjbt004,pjbt005 ",
                "  FROM pjbt_t WHERE pjbtent = ",g_enterprise," AND pjbt001 = '",g_pjbn_m.pjbn003,"'"
   LET l_sql = "INSERT INTO pjbt_t(pjbtent,pjbt001,pjbt002,pjbt003,pjbt004,pjbt005) ",l_sql1
   PREPARE ins_pjbt_pre FROM l_sql
   EXECUTE ins_pjbt_pre
   IF SQLCA.SQLCODE THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION apjm300_s01_pjbn008_desc(p_pjbn008)
DEFINE p_pjbn008   LIKE pjbn_t.pjbn008
DEFINE r_pjbn008_desc LIKE type_t.chr80
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_pjbn008 
    CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET r_pjbn008_desc = '', g_rtn_fields[1] , ''
    RETURN r_pjbn008_desc
END FUNCTION

PRIVATE FUNCTION apjm300_set_act_visible()
   CALL cl_set_act_visible("delete,modify,modify_detail,insert_detail",TRUE)
END FUNCTION

PRIVATE FUNCTION apjm300_set_act_no_visible()
   IF g_pjbn_m.pjbnstus != 'N' THEN
      CALL cl_set_act_visible("delete,modify,modify_detail,insert_detail",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbn001_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbn001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbn_m.pjbn001
   LET g_ref_fields[2] = g_pjbn_m.pjbn900
   CALL ap_ref_array2(g_ref_fields,"SELECT pjbnl003,pjbnl004 FROM pjbnl_t WHERE pjbnlent='"||g_enterprise||"' AND pjbnl001=? AND pjbnl900 = ? AND pjbnl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbn_m.pjbnl003 = '', g_rtn_fields[1] , ''
   LET g_pjbn_m.pjbnl004 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbn001_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbn001_chk()
DEFINE   l_n       LIKE type_t.num5
DEFINE   r_success LIKE type_t.num5
   LET r_success = TRUE
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pjbn_t
    WHERE pjbnent = g_enterprise
      AND pjbn001 = g_pjbn_m.pjbn001
      AND pjbn900 <> g_pjbn_m.pjbn900
      AND pjbnstus = 'N'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_pjbn_m.pjbn001
      LET g_errparam.code   = 'apj-00045' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()   
      LET r_success = FALSE 
   END IF   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 專案WBS變更單身檔
# Memo...........:
# Usage..........: CALL apjm300_pjbo_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbo_desc()
DEFINE  l_sql          STRING
DEFINE  r_success      LIKE type_t.num5
#DEFINE  l_pjbo         RECORD LIKE pjbo_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbo RECORD  #專案WBS變更單身檔
       pjboent LIKE pjbo_t.pjboent, #企业编号
       pjbo001 LIKE pjbo_t.pjbo001, #项目编号
       pjbo002 LIKE pjbo_t.pjbo002, #本阶WBS
       pjbo003 LIKE pjbo_t.pjbo003, #上阶WBS
       pjbo004 LIKE pjbo_t.pjbo004, #WBS类型
       pjbo005 LIKE pjbo_t.pjbo005, #计划起始日
       pjbo006 LIKE pjbo_t.pjbo006, #计划截止日
       pjbo007 LIKE pjbo_t.pjbo007, #工期天数
       pjbo008 LIKE pjbo_t.pjbo008, #工期时数
       pjbo009 LIKE pjbo_t.pjbo009, #里程碑
       pjbo010 LIKE pjbo_t.pjbo010, #负责人员
       pjbo011 LIKE pjbo_t.pjbo011, #负责部门
       pjbo012 LIKE pjbo_t.pjbo012, #状态码
       pjbo900 LIKE pjbo_t.pjbo900, #变更序
       pjbo901 LIKE pjbo_t.pjbo901, #变更类型
       pjbo902 LIKE pjbo_t.pjbo902, #变更日期
       pjbo903 LIKE pjbo_t.pjbo903, #变更理由
       pjbo904 LIKE pjbo_t.pjbo904, #变更备注
       pjbo013 LIKE pjbo_t.pjbo013, #发包总额
       pjbo014 LIKE pjbo_t.pjbo014, #未结案发包总额
       pjbo015 LIKE pjbo_t.pjbo015, #结案发包总额
       pjbo016 LIKE pjbo_t.pjbo016 #发包开账金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE  l_pjbo003      LIKE pjbo_t.pjbo003
DEFINE  l_pjbo901      LIKE pjbo_t.pjbo901
DEFINE  l_pjbo902      LIKE pjbo_t.pjbo902
DEFINE  l_pjbo903      LIKE pjbo_t.pjbo903
DEFINE  l_pjbo904      LIKE pjbo_t.pjbo904
DEFINE  l_pjbbl003     LIKE pjbbl_t.pjbbl003
DEFINE  l_pjbbl004     LIKE pjbbl_t.pjbbl004
DEFINE  l_pjbbl005     LIKE pjbbl_t.pjbbl005

   LET r_success = TRUE
   LET l_sql = " SELECT pjbb002,pjbb003,pjbb004,pjbb005,pjbb006,pjbb007,pjbb008,pjbb009,pjbb010,pjbb011,pjbb012 FROM pjbb_t ",
               "  WHERE pjbbent = '",g_enterprise,"'",
               "    AND pjbb001 = '",g_pjbn_m.pjbn001,"'"
   PREPARE apjm300_pjbo_pre FROM l_sql
   DECLARE apjm300_pjbo_cur CURSOR FOR apjm300_pjbo_pre
   
   LET l_sql = " SELECT pjbbl003,pjbbl004,pjbbl005 FROM pjbbl_t ",
               "  WHERE pjbblent = '",g_enterprise,"'",
               "    AND pjbbl001 = '",g_pjbn_m.pjbn001,"'",
               "    AND pjbbl002 = ? "

   PREPARE apjm300_pjbbl_pre FROM l_sql
   DECLARE apjm300_pjbbl_cur CURSOR FOR apjm300_pjbbl_pre
   
   LET l_ac = 1    
   FOREACH apjm300_pjbo_cur INTO l_pjbo.pjbo002,l_pjbo003,l_pjbo.pjbo004,l_pjbo.pjbo005,l_pjbo.pjbo006,
                                 l_pjbo.pjbo007,l_pjbo.pjbo008,l_pjbo.pjbo009,l_pjbo.pjbo010,
                                 l_pjbo.pjbo011,l_pjbo.pjbo012
      LET l_pjbo902 = g_today
      LET l_pjbo901 = 1      
      INSERT INTO pjbo_t (pjboent,pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,
                          pjbo900,pjbo901,pjbo902,pjbo903,pjbo904)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,l_pjbo.pjbo002,l_pjbo003,l_pjbo.pjbo004,l_pjbo.pjbo005,l_pjbo.pjbo006,
                          l_pjbo.pjbo007,l_pjbo.pjbo008,l_pjbo.pjbo009,l_pjbo.pjbo010,l_pjbo.pjbo011,l_pjbo.pjbo012,
                          g_pjbn_m.pjbn900,l_pjbo901,l_pjbo902,l_pjbo903,l_pjbo904)
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbo_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE         
      END IF                            
      
      FOREACH apjm300_pjbbl_cur USING l_pjbo.pjbo002 INTO l_pjbbl003,l_pjbbl004,l_pjbbl005
      
         INSERT INTO pjbol_t (pjbolent,pjbol001,pjbol002,pjbol900,pjbol003,pjbol004,pjbol005,pjbol901)
                      VALUES (g_enterprise,g_pjbn_m.pjbn001,l_pjbo.pjbo002,g_pjbn_m.pjbn900,l_pjbbl003,l_pjbbl004,l_pjbbl005,'1')
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins pjbol_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE         
         END IF            
      END FOREACH
      
      CALL apjm300_pjbq_desc(l_pjbo.pjbo002)  
       
      CALL apjm300_pjbr_desc(l_pjbo.pjbo002) 
       
      CALL apjm300_pjbs_desc(l_pjbo.pjbo002)
      
      CALL apjm300_pjbt_desc(l_pjbo.pjbo002) 
      

   END FOREACH

   CALL apjm300_tree_fill()
   DISPLAY ARRAY g_tree TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
      BEFORE ROW
         EXIT DISPLAY  
   END DISPLAY   
   FREE apjm300_pjbo_cur 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbq_desc(p_pjbo002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbq_desc(p_pjbo002)
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5
DEFINE  p_pjbo002   LIKE pjbo_t.pjbo002

   LET g_detail_idx = 1
   LET l_sql = "SELECT  UNIQUE pjbd003,pjbd004,pjbd005,pjbd010,pjbd006,pjbd007,pjbd008,pjbd009 , 
       t6.rtaxl003 ,t7.imaal003 ,t8.oocal003 FROM pjbd_t",    
               "",
         " LEFT JOIN rtaxl_t t6 ON t6.rtaxlent='"||g_enterprise||"' AND t6.rtaxl001=pjbd004 AND t6.rtaxl002='"||g_dlang||"' ",
         " LEFT JOIN imaal_t t7 ON t7.imaalent='"||g_enterprise||"' AND t7.imaal001=pjbd005 AND t7.imaal002='"||g_dlang||"' ",
         " LEFT JOIN oocal_t t8 ON t8.oocalent='"||g_enterprise||"' AND t8.oocal001=pjbd006 AND t8.oocal002='"||g_dlang||"' ",
    
               " WHERE pjbdent=? AND pjbd001=? AND pjbd002=?"
               
   PREPARE apjm300_pjbq_pre FROM l_sql
   DECLARE apjm300_pjbq_cur CURSOR FOR apjm300_pjbq_pre
   CALL g_pjbq_d.clear()
   OPEN apjm300_pjbq_cur USING g_enterprise,g_pjbn_m.pjbn001,p_pjbo002
   LET l_ac = 1
   FOREACH apjm300_pjbq_cur INTO g_pjbq_d[l_ac].pjbq003,g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq005, 
       g_pjbq_d[l_ac].pjbq010,g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008, 
       g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq004_desc,g_pjbq_d[l_ac].pjbq005_desc,g_pjbq_d[l_ac].pjbq006_desc  
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      INSERT INTO pjbq_t (pjbqent,pjbq001,pjbq002,pjbq003,pjbq004,pjbq005,pjbq006,pjbq007,pjbq008,pjbq009,pjbq010,pjbq900,pjbq901,pjbq902)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,p_pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbq_d[l_ac].pjbq004,g_pjbq_d[l_ac].pjbq005,
                          g_pjbq_d[l_ac].pjbq006,g_pjbq_d[l_ac].pjbq007,g_pjbq_d[l_ac].pjbq008,g_pjbq_d[l_ac].pjbq009,g_pjbq_d[l_ac].pjbq010,g_pjbn_m.pjbn900,'1',g_today)
      IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbq_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      
   END IF                           
      #end add-point
     
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_pjbq_d.deleteElement(g_pjbq_d.getLength())               
   LET g_rec_b = l_ac - 1
   LET l_ac = 0
   FREE apjm300_pjbq_cur 
#   DISPLAY ARRAY g_pjbq_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY 

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbn_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbn_desc()
DEFINE  l_pjbn901    LIKE pjbn_t.pjbn901
DEFINE  l_pjbn902    LIKE pjbn_t.pjbn902
DEFINE  l_pjbn903    LIKE pjbn_t.pjbn903
DEFINE  l_pjbn904    LIKE pjbn_t.pjbn904
DEFINE  l_pjbnl002   LIKE pjbnl_t.pjbnl002
DEFINE  l_pjbnl003   LIKE pjbnl_t.pjbnl003
DEFINE  l_pjbnl004   LIKE pjbnl_t.pjbnl004
DEFINE  r_success    LIKE type_t.num5
DEFINE  l_sql        STRING

   LET r_success = TRUE
   
   LET l_sql = " SELECT pjbal002,pjbal003,pjbal004  FROM pjbal_t ",
               " WHERE pjbalent = '",g_enterprise,"'",
               "   AND pjbal001 = '",g_pjbn_m.pjbn001,"'"
   PREPARE apjm300_pjbal_pre FROM l_sql
   DECLARE apjm300_pjbal_cur CURSOR FOR apjm300_pjbal_pre
   
   SELECT pjba000,pjba001,pjba002,pjba003,pjba004,pjba005,pjba006,pjba007,pjba008,pjba009,pjba010,pjba011,pjba012,pjba013 
     INTO g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,g_pjbn_m.pjbn006,
          g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,g_pjbn_m.pjbn013
     FROM pjba_t
    WHERE pjbaent = g_enterprise
      AND pjba001 = g_pjbn_m.pjbn001

   SELECT MAX(pjba009)+1 INTO g_pjbn_m.pjbn009 FROM pjba_t   #版次
    WHERE pjbaent = g_enterprise
      AND pjba001 = g_pjbn_m.pjbn001
   IF cl_null(g_pjbn_m.pjbn009) THEN LET g_pjbn_m.pjbn009 = 1 END IF  
   SELECT MAX(pjbn900)+1 INTO g_pjbn_m.pjbn900 FROM pjbn_t   #變更序
    WHERE pjbnent = g_enterprise
      AND pjbn001 = g_pjbn_m.pjbn001 
   IF cl_null(g_pjbn_m.pjbn900) THEN LET g_pjbn_m.pjbn900 = 1 END IF
   LET l_pjbn901 = 1   
   INSERT INTO pjbn_t (pjbnent,pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbn009,pjbn010,pjbn011,pjbn012,pjbn013,pjbn015,pjbn900,pjbn901,
                       pjbn902,pjbn903,pjbn904,pjbnownid,pjbnowndp,pjbncrtid,pjbncrtdp,pjbncrtdt,pjbnmodid,pjbnmoddt,pjbncnfid,
                       pjbncnfdt,pjbnstus) 
               VALUES (g_enterprise,g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,
                       g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,g_pjbn_m.pjbn010,g_pjbn_m.pjbn011,g_pjbn_m.pjbn012,
                       g_pjbn_m.pjbn013,g_pjbn_m.pjbn015,g_pjbn_m.pjbn900,l_pjbn901,l_pjbn902,
                       l_pjbn903,l_pjbn904,g_pjbn_m.pjbnownid,g_pjbn_m.pjbnowndp,g_pjbn_m.pjbncrtid,g_pjbn_m.pjbncrtdp,
                       g_pjbn_m.pjbncrtdt,g_pjbn_m.pjbnmodid,g_pjbn_m.pjbnmoddt,g_pjbn_m.pjbncnfid,g_pjbn_m.pjbncnfdt,g_pjbn_m.pjbnstus)
                       
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbn_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      LET r_success = FALSE
      
   END IF
      
   FOREACH apjm300_pjbal_cur INTO l_pjbnl002,l_pjbnl003,l_pjbnl004
      INSERT INTO pjbnl_t (pjbnlent,pjbnl001,pjbnl900,pjbnl002,pjbnl003,pjbnl004,pjbnl901)
                   VALUES (g_enterprise,g_pjbn_m.pjbn001,g_pjbn_m.pjbn900,l_pjbnl002,l_pjbnl003,l_pjbnl004,'1')
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins pjbnl_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()       
         LET r_success = FALSE         
      END IF                   
   END FOREACH
   
   SELECT pjbal003,pjbal004 INTO g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004 FROM pjbal_t
    WHERE pjbalent = g_enterprise
      AND pjbal001 = g_pjbn_m.pjbn001
      AND pjbal002 = g_lang
      
   DISPLAY BY NAME g_pjbn_m.pjbn000,g_pjbn_m.pjbn001,g_pjbn_m.pjbn002,g_pjbn_m.pjbn003,g_pjbn_m.pjbn004,g_pjbn_m.pjbn005,
                   g_pjbn_m.pjbn006,g_pjbn_m.pjbn007,g_pjbn_m.pjbn008,g_pjbn_m.pjbn009,g_pjbn_m.pjbn900,
                   g_pjbn_m.pjbnl003,g_pjbn_m.pjbnl004
   CALL apjm300_pjbp_desc()    #成員            
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbr_desc(p_pjbo002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbr_desc(p_pjbo002)
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5
DEFINE  p_pjbo002   LIKE pjbo_t.pjbo002

   CALL g_pjbq2_d.clear()
   LET l_sql = "SELECT  UNIQUE pjbe003,pjbe004,pjbe005,pjbe006,pjbe007,pjbe008,pjbe009 ,t9.oocql004 FROM pjbe_t", 
           
               "",
               " LEFT JOIN oocql_t t9 ON t9.oocqlent='"||g_enterprise||"' AND t9.oocql001='8002' AND t9.oocql002=pjbe003 AND t9.oocql003='"||g_dlang||"' ",
    
               " WHERE pjbeent=? AND pjbe001=? AND pjbe002=?"
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE apjm300_pjbr_pre FROM l_sql
   DECLARE apjm300_pjbr_cur CURSOR FOR apjm300_pjbr_pre
      
   OPEN apjm300_pjbr_cur USING g_enterprise,g_pjbn_m.pjbn001,p_pjbo002
   
   LET l_ac = 1   
   FOREACH apjm300_pjbr_cur INTO g_pjbq2_d[l_ac].pjbr003,g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005, 
       g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009, 
       g_pjbq2_d[l_ac].pjbr003_desc 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
    
      #end add-point
     
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      INSERT INTO pjbr_t (pjbrent,pjbr001,pjbr002,pjbr003,pjbr004,pjbr005,pjbr006,pjbr007,pjbr008,pjbr009,pjbr900,pjbr901,pjbr902)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,p_pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbq2_d[l_ac].pjbr004,g_pjbq2_d[l_ac].pjbr005, 
                          g_pjbq2_d[l_ac].pjbr006,g_pjbq2_d[l_ac].pjbr007,g_pjbq2_d[l_ac].pjbr008,g_pjbq2_d[l_ac].pjbr009,g_pjbn_m.pjbn900,
                          '1',g_today)
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_pjbq2_d.deleteElement(g_pjbq2_d.getLength())     
   LET g_rec_b = l_ac - 1
   LET l_ac = 0
   FREE apjm300_pjbr_cur 
#   DISPLAY ARRAY g_pjbq2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbs_desc(p_pjbo002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbs_desc(p_pjbo002)
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5
DEFINE  p_pjbo002   LIKE pjbo_t.pjbo002

   LET g_detail_idx = 1
   CALL g_pjbq3_d.clear()
    
   LET l_sql = "SELECT  UNIQUE pjbf003,pjbf004,pjbf005,pjbf006,pjbf007,pjbf008 ,t10.mrba004 ,t11.oocal003 FROM pjbf_t", 
           
               "",
               " LEFT JOIN mrba_t t10 ON t10.mrbaent='"||g_enterprise||"' AND t10.mrba001=pjbf003  ",
               " LEFT JOIN oocal_t t11 ON t11.oocalent='"||g_enterprise||"' AND t11.oocal001=pjbf004 AND t11.oocal002='"||g_dlang||"' ",
    
               " WHERE pjbfent=? AND pjbf001=? AND pjbf002=? "
   
   
   LET l_sql = l_sql, " ORDER BY  pjbf_t.pjbf003" 

                      
   #add-point:單身填充前
    
   #end add-point
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE apjm300_pjbs_pre FROM l_sql
   DECLARE apjm300_pjbs_curs CURSOR FOR apjm300_pjbs_pre
   
   OPEN apjm300_pjbs_curs USING g_enterprise,g_pjbn_m.pjbn001,p_pjbo002
   
   LET l_ac = 1
    
   FOREACH apjm300_pjbs_curs INTO g_pjbq3_d[l_ac].pjbs003,g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs005, 
       g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008,g_pjbq3_d[l_ac].pjbs003_desc, 
       g_pjbq3_d[l_ac].pjbs004_desc 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
    
      #end add-point
     
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      INSERT INTO pjbs_t (pjbsent,pjbs001,pjbs002,pjbs003,pjbs004,pjbs005,pjbs006,pjbs007,pjbs008,pjbs900,pjbs901,pjbs902)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,p_pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbq3_d[l_ac].pjbs004,g_pjbq3_d[l_ac].pjbs005, 
                          g_pjbq3_d[l_ac].pjbs006,g_pjbq3_d[l_ac].pjbs007,g_pjbq3_d[l_ac].pjbs008,g_pjbn_m.pjbn900,
                          '1',g_today)
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_pjbq3_d.deleteElement(g_pjbq3_d.getLength())
   LET g_rec_b = l_ac - 1
   LET l_ac = 0
   FREE apjm300_pjbs_curs 
#   DISPLAY ARRAY g_pjbq3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY     
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbt_desc(p_pjbo002)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbt_desc(p_pjbo002)
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5
DEFINE  p_pjbo002   LIKE pjbo_t.pjbo002

   CALL g_pjbq4_d.clear()
   LET l_sql = "SELECT  UNIQUE pjbg003,pjbg004,pjbg005 ,t12.oocql004 FROM pjbg_t",    
               "",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent='"||g_enterprise||"' AND t12.oocql001='8003' AND t12.oocql002=pjbg003 AND t12.oocql003='"||g_dlang||"' ",
    
               " WHERE pjbgent=? AND pjbg001=? AND pjbg002=?"
   
   
   LET l_sql = l_sql, " ORDER BY  pjbg_t.pjbg003" 
                      
   #add-point:單身填充前
    
   #end add-point
   
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   PREPARE apjm300_pjbt_pre FROM l_sql
   DECLARE apjm300_pjbt_cur CURSOR FOR apjm300_pjbt_pre
   
   OPEN apjm300_pjbt_cur USING  g_enterprise,g_pjbn_m.pjbn001,p_pjbo002
   LET l_ac = 1
   FOREACH apjm300_pjbt_cur INTO g_pjbq4_d[l_ac].pjbt003,g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005, 
       g_pjbq4_d[l_ac].pjbt003_desc 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充
      INSERT INTO pjbt_t (pjbtent,pjbt001,pjbt002,pjbt003,pjbt004,pjbt005,pjbt900,pjbt901,pjbt902)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,p_pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbq4_d[l_ac].pjbt004,g_pjbq4_d[l_ac].pjbt005,g_pjbn_m.pjbn900,'1',g_today)
      #end add-point
 
     
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_ac
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      
   END FOREACH
   CALL g_pjbq4_d.deleteElement(g_pjbq4_d.getLength())   
   LET g_rec_b = l_ac - 1
   LET l_ac = 0
   FREE apjm300_pjbt_cur 
#   DISPLAY ARRAY g_pjbq4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)
#      BEFORE DISPLAY
#         EXIT DISPLAY
#   END DISPLAY   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbo001_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbo001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pjbo_m.pjbo001
   LET g_ref_fields[2] = g_pjbo_m.pjbo002
   LET g_ref_fields[3] = g_pjbn_m.pjbn900
   CALL ap_ref_array2(g_ref_fields," SELECT pjbol004,pjbol005 FROM pjbol_t WHERE pjbolent = '"||g_enterprise||"' AND pjbol001 = ? AND pjbol002 = ? AND pjbol900 = ? AND pjbol003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pjbo_m.pjbol004 = g_rtn_fields[1]
   LET g_pjbo_m.pjbol005 = g_rtn_fields[2]
   DISPLAY g_pjbo_m.pjbol004 TO pjbol004
   DISPLAY g_pjbo_m.pjbol005 TO pjbol005
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbp_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbp_desc()
DEFINE  l_sql      STRING
DEFINE  r_success  LIKE type_t.num5
DEFINE  l_pjbp901  LIKE pjbp_t.pjbp901
DEFINE  l_pjbp902  LIKE pjbp_t.pjbp902
DEFINE  l_pjbp903  LIKE pjbp_t.pjbp903
DEFINE  l_pjbp904  LIKE pjbp_t.pjbp904

    LET l_sql = " SELECT pjbc002,pjbc003,pjbc004,pjbc005,pjbc006 FROM pjbc_t ",
                "  WHERE pjbcent = '",g_enterprise,"'",
                "    AND pjbc001 = '",g_pjbn_m.pjbn001,"'"
   PREPARE apjm300_pjbp_pre FROM l_sql
   DECLARE apjm300_pjbp_cur CURSOR FOR apjm300_pjbp_pre
   LET l_ac = 1    
   CALL g_pjbq5_d.clear()   
   FOREACH apjm300_pjbp_cur INTO g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbq5_d[l_ac].pjbp004,g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006
      LET l_pjbp902 = g_today
      LET l_pjbp901 = 1
      INSERT INTO pjbp_t (pjbpent,pjbp001,pjbp002,pjbp003,pjbp004,pjbp005,pjbp006,pjbp900,pjbp901,pjbp902,pjbp903,pjbp904)
                  VALUES (g_enterprise,g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbq5_d[l_ac].pjbp004,
                          g_pjbq5_d[l_ac].pjbp005,g_pjbq5_d[l_ac].pjbp006,g_pjbn_m.pjbn900,l_pjbp901,l_pjbp902,l_pjbp903,l_pjbp904)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pjbp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
         
      END IF                              
      LET l_ac = l_ac + 1   
   END FOREACH
   CALL g_pjbq5_d.deleteElement(g_pjbq5_d.getLength())

   LET g_rec_b = l_ac - 1
   LET l_ac = 0
   FREE apjm300_pjbp_cur 
   DISPLAY ARRAY g_pjbq5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_upd_pjbn901()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_upd_pjbn901()
#DEFINE l_pjba       RECORD LIKE pjba_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjba RECORD  #專案資料單頭檔
       pjbaent LIKE pjba_t.pjbaent, #企业编号
       pjba000 LIKE pjba_t.pjba000, #项目类型
       pjba001 LIKE pjba_t.pjba001, #项目编号
       pjba002 LIKE pjba_t.pjba002, #范本
       pjba003 LIKE pjba_t.pjba003, #范本项目编号
       pjba004 LIKE pjba_t.pjba004, #项目计算币种
       pjba005 LIKE pjba_t.pjba005, #立案日期
       pjba006 LIKE pjba_t.pjba006, #备注
       pjba007 LIKE pjba_t.pjba007, #WBS计划起始/截止日遇非工作日的处理方式
       pjba008 LIKE pjba_t.pjba008, #参考行事历参照表号
       pjbaownid LIKE pjba_t.pjbaownid, #资料所有者
       pjbaowndp LIKE pjba_t.pjbaowndp, #资料所有部门
       pjbacrtid LIKE pjba_t.pjbacrtid, #资料录入者
       pjbacrtdp LIKE pjba_t.pjbacrtdp, #资料录入部门
       pjbacrtdt LIKE pjba_t.pjbacrtdt, #资料创建日
       pjbamodid LIKE pjba_t.pjbamodid, #资料更改者
       pjbamoddt LIKE pjba_t.pjbamoddt, #最近更改日
       pjbacnfid LIKE pjba_t.pjbacnfid, #资料审核者
       pjbacnfdt LIKE pjba_t.pjbacnfdt, #数据审核日
       pjbastus LIKE pjba_t.pjbastus, #状态码
       pjba009 LIKE pjba_t.pjba009, #版次
       pjba010 LIKE pjba_t.pjba010, #项目进度
       pjba011 LIKE pjba_t.pjba011, #项目结案
       pjba012 LIKE pjba_t.pjba012, #结案人员
       pjba013 LIKE pjba_t.pjba013, #结案日期
       pjba014 LIKE pjba_t.pjba014, #结案理由码
       pjba015 LIKE pjba_t.pjba015, #认列方式
       pjba016 LIKE pjba_t.pjba016, #本币预算金额(税前)
       pjba017 LIKE pjba_t.pjba017, #本币合同金额(税前)
       pjba018 LIKE pjba_t.pjba018, #本币预算合同金额(含税)
       pjba019 LIKE pjba_t.pjba019, #本币合同金额(含税)
       pjba020 LIKE pjba_t.pjba020, #报价版本
       pjba021 LIKE pjba_t.pjba021, #结案阶段设置
       pjba022 LIKE pjba_t.pjba022, #结案状态
       pjba023 LIKE pjba_t.pjba023, #财会结案日
       pjba024 LIKE pjba_t.pjba024, #保固结案日
       pjba025 LIKE pjba_t.pjba025, #最终业主
       pjba026 LIKE pjba_t.pjba026, #人工分摊选项
       pjba027 LIKE pjba_t.pjba027, #请款审核单是否签回
       pjba028 LIKE pjba_t.pjba028, #签回日
       pjba029 LIKE pjba_t.pjba029, #保固切结书是否签回
       pjba030 LIKE pjba_t.pjba030, #签回日
       pjba031 LIKE pjba_t.pjba031, #保固起始日期
       pjba032 LIKE pjba_t.pjba032, #保固截止日期
       pjba033 LIKE pjba_t.pjba033, #估列保固成本
       pjba034 LIKE pjba_t.pjba034, #备注
       pjba035 LIKE pjba_t.pjba035, #检核否
       pjba036 LIKE pjba_t.pjba036, #估列材料
       pjba037 LIKE pjba_t.pjba037, #估列工包
       pjba038 LIKE pjba_t.pjba038, #估列费用
       pjba039 LIKE pjba_t.pjba039, #估列总计
       pjba040 LIKE pjba_t.pjba040, #检验否
       pjba041 LIKE pjba_t.pjba041, #估列材料
       pjba042 LIKE pjba_t.pjba042, #估列工包
       pjba043 LIKE pjba_t.pjba043, #估列费用
       pjba044 LIKE pjba_t.pjba044, #估列总计
       pjba045 LIKE pjba_t.pjba045, #检验否
       pjba046 LIKE pjba_t.pjba046, #估列材料
       pjba047 LIKE pjba_t.pjba047, #估列工包
       pjba048 LIKE pjba_t.pjba048, #估列费用
       pjba049 LIKE pjba_t.pjba049, #估列总计
       pjba050 LIKE pjba_t.pjba050, #检验否
       pjba051 LIKE pjba_t.pjba051, #项目预估成本-材料
       pjba052 LIKE pjba_t.pjba052, #项目预估成本-人工
       pjba053 LIKE pjba_t.pjba053, #项目预估成本-加工费
       pjba054 LIKE pjba_t.pjba054, #项目预估成本-制费一
       pjba055 LIKE pjba_t.pjba055, #项目预估成本-制费二
       pjba056 LIKE pjba_t.pjba056, #项目预估成本-制费三
       pjba057 LIKE pjba_t.pjba057, #项目预估成本-制费四
       pjba058 LIKE pjba_t.pjba058 #项目预估成本-制费五
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
#DEFINE l_pjbal      RECORD LIKE pjbal_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbal RECORD  #專案資料單頭檔多語言檔
       pjbalent LIKE pjbal_t.pjbalent, #企业编号
       pjbal001 LIKE pjbal_t.pjbal001, #项目编号
       pjbal002 LIKE pjbal_t.pjbal002, #语言别
       pjbal003 LIKE pjbal_t.pjbal003, #说明
       pjbal004 LIKE pjbal_t.pjbal004 #助记码
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE l_flag       LIKE type_t.num5   #記錄是否有欄位變更
DEFINE l_flag1      LIKE type_t.num5   #記錄是否有欄位變更
DEFINE r_success    LIKE type_t.num5
DEFINE l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE l_pjbu010    LIKE pjbu_t.pjbu010
DEFINE l_pjbnl002   LIKE pjbnl_t.pjbnl002
DEFINE l_pjbnl003   LIKE pjbnl_t.pjbnl003
DEFINE l_pjbnl004   LIKE pjbnl_t.pjbnl004
DEFINE l_n          LIKE type_t.num10
DEFINE l_sql        STRING

   
   LET r_success = TRUE
   LET l_flag = FALSE
   LET l_flag1 = FALSE
   LET l_pjbu009 = cl_get_current()
   #抓取單頭的值
   INITIALIZE l_pjba.* TO NULL
   INITIALIZE l_pjbal.* TO NULL
   
   LET r_success = TRUE

   SELECT pjba000,pjba001,pjba002,pjba003,pjba004,pjba005,pjba006,pjba007,pjba008,pjba009,pjba010 
     INTO l_pjba.pjba000,l_pjba.pjba001,l_pjba.pjba002,l_pjba.pjba003,l_pjba.pjba004,l_pjba.pjba005,l_pjba.pjba006,
          l_pjba.pjba007,l_pjba.pjba008,l_pjba.pjba009,l_pjba.pjba010
     FROM pjba_t
    WHERE pjbaent = g_enterprise
      AND pjba001 = g_pjbn_m.pjbn001
      
   #專案類型
   IF (NOT cl_null(g_pjbn_m.pjbn000) AND (g_pjbn_m.pjbn000 != l_pjba.pjba000 OR cl_null(l_pjba.pjba000))) OR
      (cl_null(g_pjbn_m.pjbn000) AND NOT cl_null(l_pjba.pjba000)) THEN
      #其說明的SQL
      LET l_pjbu010 = "SELECT pjaal003 FROM pjaal_t WHERE pjaalent='"||g_enterprise||"' AND pjaal001='",g_pjbn_m.pjbn000,"' AND pjaal002=? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba000",'1',l_pjba.pjba000,g_pjbn_m.pjbn000,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba000") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF    

   #範本

   IF (NOT cl_null(g_pjbn_m.pjbn002) AND (g_pjbn_m.pjbn002 != l_pjba.pjba002 OR cl_null(l_pjba.pjba002))) OR
      (cl_null(g_pjbn_m.pjbn002) AND NOT cl_null(l_pjba.pjba002)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba002",'1',l_pjba.pjba002,g_pjbn_m.pjbn002,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   
   IF (NOT cl_null(g_pjbn_m.pjbn003) AND (g_pjbn_m.pjbn003 != l_pjba.pjba003 OR cl_null(l_pjba.pjba003))) OR
      (cl_null(g_pjbn_m.pjbn003) AND NOT cl_null(l_pjba.pjba003)) THEN
      #其說明的SQL
      LET l_pjbu010 = "SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001= '",g_pjbn_m.pjbn003,"' AND pjbnl002= ? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba003",'1',l_pjba.pjba003,g_pjbn_m.pjbn003,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 

   IF (NOT cl_null(g_pjbn_m.pjbn004) AND (g_pjbn_m.pjbn004 != l_pjba.pjba004 OR cl_null(l_pjba.pjba004))) OR
      (cl_null(g_pjbn_m.pjbn004) AND NOT cl_null(l_pjba.pjba004)) THEN
      #其說明的SQL
      LET l_pjbu010 = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001='",l_pjba.pjba004,"' AND ooail002= ?"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba004",'1',l_pjba.pjba004,g_pjbn_m.pjbn004,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   
   IF (NOT cl_null(g_pjbn_m.pjbn005) AND (g_pjbn_m.pjbn005 != l_pjba.pjba005 OR cl_null(l_pjba.pjba005))) OR
      (cl_null(g_pjbn_m.pjbn005) AND NOT cl_null(l_pjba.pjba005)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba005",'1',l_pjba.pjba005,g_pjbn_m.pjbn005,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 

   IF (NOT cl_null(g_pjbn_m.pjbn006) AND (g_pjbn_m.pjbn006 != l_pjba.pjba006 OR cl_null(l_pjba.pjba006))) OR
      (cl_null(g_pjbn_m.pjbn006) AND NOT cl_null(l_pjba.pjba006)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba006",'1',l_pjba.pjba006,g_pjbn_m.pjbn006,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   IF (NOT cl_null(g_pjbn_m.pjbn007) AND (g_pjbn_m.pjbn007 != l_pjba.pjba007 OR cl_null(l_pjba.pjba007))) OR
      (cl_null(g_pjbn_m.pjbn007) AND NOT cl_null(l_pjba.pjba007)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba007",'1',l_pjba.pjba007,g_pjbn_m.pjbn007,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 

   IF (NOT cl_null(g_pjbn_m.pjbn008) AND (g_pjbn_m.pjbn008 != l_pjba.pjba008 OR cl_null(l_pjba.pjba008))) OR
      (cl_null(g_pjbn_m.pjbn008) AND NOT cl_null(l_pjba.pjba008)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba008",'1',l_pjba.pjba008,g_pjbn_m.pjbn008,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 

   IF (NOT cl_null(g_pjbn_m.pjbn009) AND (g_pjbn_m.pjbn009 != l_pjba.pjba009 OR cl_null(l_pjba.pjba009))) OR
      (cl_null(g_pjbn_m.pjbn009) AND NOT cl_null(l_pjba.pjba009)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba009",'1',l_pjba.pjba009,g_pjbn_m.pjbn009,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba009") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   #add by lixh 20150810
   IF (NOT cl_null(g_pjbn_m.pjbn010) AND (g_pjbn_m.pjbn010 != l_pjba.pjba010 OR cl_null(l_pjba.pjba010))) OR
      (cl_null(g_pjbn_m.pjbn010) AND NOT cl_null(l_pjba.pjba010)) THEN
      #其說明的SQL
      LET l_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0','0',g_pjbn_m.pjbn900,"pjba010",'1',l_pjba.pjba010,g_pjbn_m.pjbn010,l_pjbu009,l_pjbu010) THEN
         LET r_success = FALSE
         RETURN r_success
      ELSE
         LET l_flag = TRUE     #有欄位變更，則更新為'Y'
      END IF
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,0,0,g_pjbn_m.pjbn900,"pjba010") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF    
   
   #有欄位變更，則更新為'Y'
   IF l_flag THEN
      UPDATE pjbn_t SET pjbn901 = 'Y'
       WHERE pjbnent = g_enterprise
         AND pjbn001 = g_pjbn_m.pjbn001
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbn901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF
   
   LET l_sql = " SELECT pjbnl002,pjbnl003,pjbnl004  FROM pjbnl_t",
               " WHERE pjbnlent = '",g_enterprise,"'",
               "   AND pjbnl001 = '",g_pjbn_m.pjbn001,"'",
               "   AND pjbnl900 = '",g_pjbn_m.pjbn900,"'"
               
   PREPARE apjm300_pjbnl002_pre FROM l_sql
   DECLARE apjm300_pjbnl002_cs CURSOR FOR apjm300_pjbnl002_pre   
   
   #獲取變更類型
   FOREACH apjm300_pjbnl002_cs INTO l_pjbnl002,l_pjbnl003,l_pjbnl004  
      LET l_flag1 = FALSE
      LET l_n = 1
      SELECT COUNT(*) INTO l_n FROM pjbal_t
       WHERE pjbalent = g_enterprise
         AND pjbal001 = g_pjbn_m.pjbn001
         AND pjbal002 = l_pjbnl002
      IF l_n <> 1 THEN 
         UPDATE pjbnl_t SET pjbnl901 = '3' 
          WHERE pjbnlent = g_enterprise
            AND pjbnl001 = g_pjbn_m.pjbn001
            AND pjbnl900 = g_pjbn_m.pjbn900
            AND pjbnl002 = l_pjbnl002  
            #其說明的SQL
         LET l_pjbu010 = ''
         #新增資料到變更歷程檔
         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbnl002,g_pjbn_m.pjbn900,"pjbal003",'3','',l_pjbnl003,l_pjbu009,l_pjbu010) THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
         END IF   
         #新增資料到變更歷程檔
         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbnl002,g_pjbn_m.pjbn900,"pjbal004",'3','',l_pjbnl004,l_pjbu009,l_pjbu010) THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
         END IF          
      ELSE
         SELECT pjbal002,pjbal003,pjbal004 INTO l_pjbal.pjbal002,l_pjbal.pjbal003,l_pjbal.pjbal004 FROM pjbal_t 
          WHERE pjbalent = g_enterprise  
            AND pjbal001 = g_pjbn_m.pjbn001
            AND pjbal002 = l_pjbnl002
         IF (NOT cl_null(l_pjbnl003) AND (l_pjbnl003 != l_pjbal.pjbal003 OR cl_null(l_pjbal.pjbal003))) OR
            (cl_null(l_pjbnl003) AND NOT cl_null(l_pjbal.pjbal003)) THEN
            #其說明的SQL
            LET l_pjbu010 = ''
            #新增資料到變更歷程檔
            IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal003",'2',l_pjbal.pjbal003,l_pjbnl003,l_pjbu009,l_pjbu010) THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
            END IF
         ELSE
            #資料一樣，表示無變更，將變更歷程檔刪除
            IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal003") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF  
        
         IF (NOT cl_null(l_pjbnl004) AND (l_pjbnl004 != l_pjbal.pjbal004 OR cl_null(l_pjbal.pjbal004))) OR
            (cl_null(l_pjbnl004) AND NOT cl_null(l_pjbal.pjbal004)) THEN
            #其說明的SQL
            LET l_pjbu010 = ''
            #新增資料到變更歷程檔
            IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal004",'2',l_pjbal.pjbal004,l_pjbnl004,l_pjbu009,l_pjbu010) THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
            END IF
         ELSE
            #資料一樣，表示無變更，將變更歷程檔刪除
            IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal004") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF  
         
         #有欄位變更，則更新為'2'
         IF l_flag1 THEN
            UPDATE pjbnl_t SET pjbnl901 = '2'
             WHERE pjbnlent = g_enterprise
               AND pjbnl001 = g_pjbn_m.pjbn001
               AND pjbnl002 = l_pjbnl002
               AND pjbnl900 = g_pjbn_m.pjbn900
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd pjbnl901"
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               LET r_success = FALSE
               RETURN r_success
            END IF         
         END IF             
      END IF
   END FOREACH
               
#   LET l_sql = " SELECT pjbal002,pjbal003,pjbal004  FROM pjbal_t",
#               "  WHERE pjbalent = '",g_enterprise,"'",
#               "    AND pjbal001 = '",g_pjbn_m.pjbn001,"'"
#
#   PREPARE apjm300_pjbal002_pre FROM l_sql
#   DECLARE apjm300_pjbal002_cs CURSOR FOR apjm300_pjbal002_pre
#   
#   FOREACH apjm300_pjbal002_cs INTO l_pjbal.pjbal002,l_pjbal.pjbal003,l_pjbal.pjbal004
#      IF (NOT cl_null(g_pjbn_m.pjbnl003) AND (g_pjbn_m.pjbnl003 != l_pjbal.pjbal003 OR cl_null(l_pjbal.pjbal003))) OR
#         (cl_null(g_pjbn_m.pjbnl003) AND NOT cl_null(l_pjbal.pjbal003)) THEN
#         #其說明的SQL
#         LET l_pjbu010 = ''
#         #新增資料到變更歷程檔
#         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal003",'1',l_pjbal.pjbal003,g_pjbn_m.pjbnl003,l_pjbu009,l_pjbu010) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         ELSE
#            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
#         END IF
#      ELSE
#         #資料一樣，表示無變更，將變更歷程檔刪除
#         IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal003") THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      END IF  
#     
#      IF (NOT cl_null(g_pjbn_m.pjbnl004) AND (g_pjbn_m.pjbnl004 != l_pjbal.pjbal003 OR cl_null(l_pjbal.pjbal003))) OR
#         (cl_null(g_pjbn_m.pjbnl004) AND NOT cl_null(l_pjbal.pjbal003)) THEN
#         #其說明的SQL
#         LET l_pjbu010 = ''
#         #新增資料到變更歷程檔
#         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal004",'1',l_pjbal.pjbal003,g_pjbn_m.pjbnl004,l_pjbu009,l_pjbu010) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         ELSE
#            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
#         END IF
#      ELSE
#         #資料一樣，表示無變更，將變更歷程檔刪除
#         IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,'0',l_pjbal.pjbal002,g_pjbn_m.pjbn900,"pjbal004") THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      END IF  
#      
#      #有欄位變更，則更新為'Y'
#      IF l_flag1 THEN
#         UPDATE pjbnl_t SET pjbnl901 = '2'
#          WHERE pjbnlent = g_enterprise
#            AND pjbnl001 = g_pjbn_m.pjbn001
#            AND pjbnl002 = l_pjbal.pjbal002
#            AND pjbnl900 = g_pjbn_m.pjbn900
#            
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "upd pjbnl901"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#    
#            LET r_success = FALSE
#            RETURN r_success
#         END IF         
#      END IF      
#   END FOREACH
      
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_head_color()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_head_color()
DEFINE l_pjbu005        LIKE pjbu_t.pjbu005                    
DEFINE l_pjbu005_n      LIKE pjbu_t.pjbu005  
DEFINE l_pjbu005_1      LIKE pjbu_t.pjbu005 
DEFINE l_pjbu005_2      LIKE pjbu_t.pjbu005 
DEFINE l_sql            STRING

   CALL apjm300_head_init_color()                            
                                                             
#   DECLARE sel_pjbu_cs1 CURSOR FOR                           
#    SELECT pjbu005 FROM pjbu_t                               
#     WHERE pjbuent = g_enterprise                            
#       AND pjbu001 = g_pjbn_m.pjbn001                   
#       AND pjbu002 = 0                        
#       AND pjbu003 = 0                                       
#       AND pjbu004 = g_pjbn_m.pjbn900     
                         
   LET l_sql = " SELECT pjbu005 FROM pjbu_t ",                             
               "  WHERE pjbuent = '",g_enterprise,"'",                            
               "    AND pjbu001 = '",g_pjbn_m.pjbn001,"'",                   
               "    AND pjbu002 = '0' ",                     
               "    AND pjbu003 = '0' ",                                     
               "    AND pjbu004 = '",g_pjbn_m.pjbn900,"'"  

   PREPARE sel_pjbu_pre1 FROM l_sql
   DECLARE sel_pjbu_cs1 CURSOR FOR sel_pjbu_pre1
   
   FOREACH sel_pjbu_cs1 INTO l_pjbu005                       
      IF SQLCA.sqlcode THEN                                  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
             
         EXIT FOREACH                                        
      END IF 
      
      IF l_pjbu005 <> 'pjba009' THEN      
         LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjba','pjbn')
      END IF
      
      CALL cl_set_comp_font_color(l_pjbu005,"red") 
      
      IF l_pjbu005 = 'pjba003' THEN
         CALL cl_set_comp_font_color("pjbn003_desc","red") 
      END IF
      IF l_pjbu005 = 'pjba004' THEN
         CALL cl_set_comp_font_color("pjbn004_desc","red") 
      END IF     
      IF l_pjbu005 = 'pjba008' THEN
         CALL cl_set_comp_font_color("pjbn008_desc","red") 
      END IF         
   END FOREACH   
   
#   DECLARE sel_pjbu_cs2 CURSOR FOR                           
#    SELECT pjbu005 FROM pjbu_t                               
#     WHERE pjbuent = g_enterprise                            
#       AND pjbu001 = g_pjbn_m.pjbn001                   
#       AND pjbu002 = g_pjbo_m.pjbo002                      
#       AND pjbu003 = 0                                       
#       AND pjbu004 = g_pjbn_m.pjbn900   

   LET l_sql = " SELECT pjbu005 FROM pjbu_t ",                              
               "  WHERE pjbuent = '",g_enterprise,"'",                            
               "    AND pjbu001 = '",g_pjbn_m.pjbn001,"'",                   
               "    AND pjbu002 = '",g_pjbo_m.pjbo002,"'",                      
               "    AND pjbu003 = '0' ",                                      
               "    AND pjbu004 = '",g_pjbn_m.pjbn900,"'"  
               
   PREPARE sel_pjbu_pre2 FROM l_sql
   DECLARE sel_pjbu_cs2 CURSOR FOR sel_pjbu_pre2
   
   FOREACH sel_pjbu_cs2 INTO l_pjbu005_n                       
      IF SQLCA.sqlcode THEN                                  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
             
         EXIT FOREACH                                        
      END IF                                                 
                                                             
      LET l_pjbu005_n = cl_replace_str(l_pjbu005_n,'pjbb','pjbo')
                                                             
      CALL cl_set_comp_font_color(l_pjbu005_n,"red") 
      IF l_pjbu005_n = 'pjbb003' THEN
         CALL cl_set_comp_font_color("pjbo003_desc","red") 
      END IF
      IF l_pjbu005_n = 'pjbb004' THEN
         CALL cl_set_comp_font_color("pjbo004_desc","red")         
      END IF    
      IF l_pjbu005_n = 'pjbb010' THEN
         CALL cl_set_comp_font_color("pjbo010_desc","red") 
      END IF   
      IF l_pjbu005_n = 'pjbb011' THEN
         CALL cl_set_comp_font_color("pjbo011_desc","red") 
      END IF      
   END FOREACH 
   
   LET l_sql = " SELECT pjbu005 FROM pjbu_t ",                             
               "  WHERE pjbuent = '",g_enterprise,"'",                            
               "    AND pjbu001 = '",g_pjbn_m.pjbn001,"'",                   
               "    AND pjbu002 = '0' ",                     
               "    AND pjbu003 = '",g_lang,"'",                                     
               "    AND pjbu004 = '",g_pjbn_m.pjbn900,"'"  

   PREPARE sel_pjbu_pre3 FROM l_sql
   DECLARE sel_pjbu_cs3 CURSOR FOR sel_pjbu_pre3

   FOREACH sel_pjbu_cs3 INTO l_pjbu005_1                       
      IF SQLCA.sqlcode THEN                                  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
             
         EXIT FOREACH                                        
      END IF 
      
     
      LET l_pjbu005_1 = cl_replace_str(l_pjbu005_1,'pjbal','pjbnl')

      
      CALL cl_set_comp_font_color(l_pjbu005_1,"red") 
             
   END FOREACH 
   
   LET l_sql = " SELECT pjbu005 FROM pjbu_t ",                             
               "  WHERE pjbuent = '",g_enterprise,"'",                            
               "    AND pjbu001 = '",g_pjbn_m.pjbn001,"'",                   
               "    AND pjbu002 = '",g_pjbo_m.pjbo002,"'",                    
               "    AND pjbu003 = '",g_lang,"'",                                     
               "    AND pjbu004 = '",g_pjbn_m.pjbn900,"'"  

   PREPARE sel_pjbu_pre4 FROM l_sql
   DECLARE sel_pjbu_cs4 CURSOR FOR sel_pjbu_pre4

   FOREACH sel_pjbu_cs4 INTO l_pjbu005_2                       
      IF SQLCA.sqlcode THEN                                  
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
             
         EXIT FOREACH                                        
      END IF 
      
     
      LET l_pjbu005_2 = cl_replace_str(l_pjbu005_2,'pjbbl','pjbol')

      
      CALL cl_set_comp_font_color(l_pjbu005_2,"red") 
             
   END FOREACH 
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_head_init_color()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_head_init_color()
   CALL cl_set_comp_font_color("pjbn000,pjbn001,pjbn002,pjbn003,pjbn004,pjbn005,pjbn006,pjbn007,pjbn008,pjbn009,pjbn900,pjbnl003,pjbnl004","black")
   CALL cl_set_comp_font_color("pjbo001,pjbo002,pjbo003,pjbo004,pjbo005,pjbo006,pjbo007,pjbo008,pjbo009,pjbo010,pjbo011,pjbo012,pjbol004,pjbol005","black")
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbo_ins_pjbu(p_pjbo901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbo_ins_pjbu(p_pjbo901)
DEFINE   p_pjbo901    LIKE pjbo_t.pjbo901
#DEFINE   l_pjbb       RECORD LIKE pjbb_t.*  #161124-00048#15  2016/12/14 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbb RECORD  #專案WBS單身檔
       pjbbent LIKE pjbb_t.pjbbent, #企业编号
       pjbb001 LIKE pjbb_t.pjbb001, #项目编号
       pjbb002 LIKE pjbb_t.pjbb002, #本阶WBS
       pjbb003 LIKE pjbb_t.pjbb003, #上阶WBS
       pjbb004 LIKE pjbb_t.pjbb004, #WBS类型
       pjbb005 LIKE pjbb_t.pjbb005, #计划起始日
       pjbb006 LIKE pjbb_t.pjbb006, #计划截止日
       pjbb007 LIKE pjbb_t.pjbb007, #工期天数
       pjbb008 LIKE pjbb_t.pjbb008, #工期时数
       pjbb009 LIKE pjbb_t.pjbb009, #里程碑
       pjbb010 LIKE pjbb_t.pjbb010, #负责人员
       pjbb011 LIKE pjbb_t.pjbb011, #负责部门
       pjbb012 LIKE pjbb_t.pjbb012, #状态码
       pjbb013 LIKE pjbb_t.pjbb013, #发包总额
       pjbb014 LIKE pjbb_t.pjbb014, #未结案发包总额
       pjbb015 LIKE pjbb_t.pjbb015, #结案发包总额
       pjbb016 LIKE pjbb_t.pjbb016 #发包开账金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
#DEFINE   l_pjbbl      RECORD LIKE pjbbl_t.*  #161124-00048#15  2016/12/14 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbbl RECORD  #專案WBS單身檔多語言檔
       pjbblent LIKE pjbbl_t.pjbblent, #企业编号
       pjbbl001 LIKE pjbbl_t.pjbbl001, #项目编号
       pjbbl002 LIKE pjbbl_t.pjbbl002, #本阶WBS
       pjbbl003 LIKE pjbbl_t.pjbbl003, #语言别
       pjbbl004 LIKE pjbbl_t.pjbbl004, #说明
       pjbbl005 LIKE pjbbl_t.pjbbl005  #助记码
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
#DEFINE   l_pjbol      RECORD LIKE pjbol_t.*  #161124-00048#15  2016/12/14 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbol RECORD  #專案WBS變更單身檔多語言檔
       pjbolent LIKE pjbol_t.pjbolent, #企业编号
       pjbol001 LIKE pjbol_t.pjbol001, #项目编号
       pjbol002 LIKE pjbol_t.pjbol002, #本阶WBS
       pjbol900 LIKE pjbol_t.pjbol900, #变更序
       pjbol003 LIKE pjbol_t.pjbol003, #语言别
       pjbol004 LIKE pjbol_t.pjbol004, #说明
       pjbol005 LIKE pjbol_t.pjbol005, #助记码
       pjbol901 LIKE pjbol_t.pjbol901 #变更类型
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   l_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_flag1      LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10
DEFINE   l_pjbol003   LIKE pjbol_t.pjbol003
DEFINE   l_pjbol004   LIKE pjbol_t.pjbol004
DEFINE   l_pjbol005   LIKE pjbol_t.pjbol005
DEFINE   l_n          LIKE type_t.num10
DEFINE   l_sql        STRING

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbo901 = '1' THEN   #未變更
      RETURN r_success
   END IF
   
   IF p_pjbo901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbb_t
       WHERE pjbbent = g_enterprise
         AND pjbb001 = g_pjbn_m.pjbn001
         AND pjbb002 = g_pjbo_m.pjbo002 
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbo901 = '3'
      END IF      
   END IF
   INITIALIZE l_pjbb.* TO NULL
   LET l_flag = FALSE
   IF p_pjbo901 = '2' THEN   #修改
      SELECT pjbb002,pjbb003,pjbb004,pjbb005,pjbb006,pjbb007,pjbb008,pjbb009,pjbb010,pjbb011,pjbb012 
        INTO l_pjbb.pjbb002,l_pjbb.pjbb003,l_pjbb.pjbb004,l_pjbb.pjbb005,l_pjbb.pjbb006,l_pjbb.pjbb007,
             l_pjbb.pjbb008,l_pjbb.pjbb009,l_pjbb.pjbb010,l_pjbb.pjbb011,l_pjbb.pjbb012
        FROM pjbb_t 
       WHERE pjbbent = g_enterprise
         AND pjbb001 = g_pjbo_m.pjbo001
         AND pjbb002 = g_pjbo_m.pjbo002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF

   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo002 <> l_pjbb.pjbb002) OR
      (g_pjbo_m.pjbo002 IS NULL AND l_pjbb.pjbb002 IS NOT NULL) OR
      (g_pjbo_m.pjbo002 IS NOT NULL AND l_pjbb.pjbb002 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb002",p_pjbo901,l_pjbb.pjbb002,g_pjbo_m.pjbo002,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  

   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo003 <> l_pjbb.pjbb003) OR
      (g_pjbo_m.pjbo003 IS NULL AND l_pjbb.pjbb003 IS NOT NULL) OR
      (g_pjbo_m.pjbo003 IS NOT NULL AND l_pjbb.pjbb003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb003",p_pjbo901,l_pjbb.pjbb003,g_pjbo_m.pjbo003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  
  
   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo004 <> l_pjbb.pjbb004) OR
      (g_pjbo_m.pjbo004 IS NULL AND l_pjbb.pjbb004 IS NOT NULL) OR
      (g_pjbo_m.pjbo004 IS NOT NULL AND l_pjbb.pjbb004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8001' AND oocql002='",l_pjbb.pjbb004,"' AND oocql003=?"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb004",p_pjbo901,l_pjbb.pjbb004,g_pjbo_m.pjbo004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF   
   
   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo005 <> l_pjbb.pjbb005) OR
      (g_pjbo_m.pjbo005 IS NULL AND l_pjbb.pjbb005 IS NOT NULL) OR
      (g_pjbo_m.pjbo005 IS NOT NULL AND l_pjbb.pjbb005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001='",g_pjbo_m.pjbo001,"' AND pjbbl002= '",g_pjbo_m.pjbo001,"' AND pjbbl003=? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb005",p_pjbo901,l_pjbb.pjbb005,g_pjbo_m.pjbo005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF    
   
   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo006 <> l_pjbb.pjbb006) OR
      (g_pjbo_m.pjbo006 IS NULL AND l_pjbb.pjbb006 IS NOT NULL) OR
      (g_pjbo_m.pjbo006 IS NOT NULL AND l_pjbb.pjbb006 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb006",p_pjbo901,l_pjbb.pjbb006,g_pjbo_m.pjbo006,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF    

   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo007 <> l_pjbb.pjbb007) OR
      (g_pjbo_m.pjbo007 IS NULL AND l_pjbb.pjbb007 IS NOT NULL) OR
      (g_pjbo_m.pjbo007 IS NOT NULL AND l_pjbb.pjbb007 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb007",p_pjbo901,l_pjbb.pjbb007,g_pjbo_m.pjbo007,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF
   
   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo008 <> l_pjbb.pjbb008) OR
      (g_pjbo_m.pjbo008 IS NULL AND l_pjbb.pjbb008 IS NOT NULL) OR
      (g_pjbo_m.pjbo008 IS NOT NULL AND l_pjbb.pjbb008 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb008",p_pjbo901,l_pjbb.pjbb008,g_pjbo_m.pjbo008,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  

   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo009 <> l_pjbb.pjbb009) OR
      (g_pjbo_m.pjbo009 IS NULL AND l_pjbb.pjbb009 IS NOT NULL) OR
      (g_pjbo_m.pjbo009 IS NOT NULL AND l_pjbb.pjbb009 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb009",p_pjbo901,l_pjbb.pjbb009,g_pjbo_m.pjbo009,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb009") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  



   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo010 <> l_pjbb.pjbb010) OR
      (g_pjbo_m.pjbo010 IS NULL AND l_pjbb.pjbb010 IS NOT NULL) OR
      (g_pjbo_m.pjbo010 IS NOT NULL AND l_pjbb.pjbb010 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001='",l_pjbb.pjbb010,"' AND ooefl002= ? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb010",p_pjbo901,l_pjbb.pjbb010,g_pjbo_m.pjbo010,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,0,g_pjbn_m.pjbn900,"pjbb010") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo011 <> l_pjbb.pjbb011) OR
      (g_pjbo_m.pjbo011 IS NULL AND l_pjbb.pjbb011 IS NOT NULL) OR
      (g_pjbo_m.pjbo011 IS NOT NULL AND l_pjbb.pjbb011 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001='",l_pjbb.pjbb011,"' "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb011",p_pjbo901,l_pjbb.pjbb011,g_pjbo_m.pjbo011,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb011") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  

   IF p_pjbo901 = '3' OR (p_pjbo901 = '2' AND
      ((g_pjbo_m.pjbo012 <> l_pjbb.pjbb012) OR
      (g_pjbo_m.pjbo012 IS NULL AND l_pjbb.pjbb012 IS NOT NULL) OR
      (g_pjbo_m.pjbo012 IS NOT NULL AND l_pjbb.pjbb012 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb012",p_pjbo901,l_pjbb.pjbb012,g_pjbo_m.pjbo012,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbo_m.pjbo001,g_pjbo_m.pjbo002,'0',g_pjbn_m.pjbn900,"pjbb012") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   #回寫變更類型
      
   IF l_flag THEN
      UPDATE pjbo_t SET pjbo901 = p_pjbo901
       WHERE pjboent = g_enterprise
         AND pjbo001 = g_pjbn_m.pjbn001
         AND pjbo002 = g_pjbo_m.pjbo002
         AND pjbo900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbo901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF
      
   LET l_sql = " SELECT pjbol003,pjbol004,pjbol005  FROM pjbol_t",
               " WHERE pjbolent = '",g_enterprise,"'",
               "   AND pjbol001 = '",g_pjbn_m.pjbn001,"'",
               "   AND pjbol002 = '",g_pjbo_m.pjbo002,"'",
               "   AND pjbol900 = '",g_pjbn_m.pjbn900,"'"
               
   PREPARE apjm300_pjbol003_pre FROM l_sql
   DECLARE apjm300_pjbol003_cs CURSOR FOR apjm300_pjbol003_pre   
   
   #獲取變更類型
   FOREACH apjm300_pjbol003_cs INTO l_pjbol003,l_pjbol004,l_pjbol005  
      LET l_flag1 = FALSE 
      LET l_n = 1
      SELECT COUNT(*) INTO l_n FROM pjbbl_t
       WHERE pjbblent = g_enterprise
         AND pjbbl001 = g_pjbn_m.pjbn001
         AND pjbbl002 = g_pjbo_m.pjbo002
         AND pjbbl003 = l_pjbol003
      IF l_n <> 1 THEN 
         UPDATE pjbol_t SET pjbol901 = '3' 
          WHERE pjbolent = g_enterprise
            AND pjbol001 = g_pjbn_m.pjbn001
            AND pjbol002 = g_pjbo_m.pjbo002
            AND pjbol900 = g_pjbn_m.pjbn900
            AND pjbol003 = l_pjbol003  
            #其說明的SQL
         LET l_pjbu010 = ''
         #新增資料到變更歷程檔
         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbol003,g_pjbn_m.pjbn900,"pjbbl004",'3','',l_pjbol004,l_pjbu009,l_pjbu010) THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
         END IF   
         #新增資料到變更歷程檔
         IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbol003,g_pjbn_m.pjbn900,"pjbbl005",'3','',l_pjbol005,l_pjbu009,l_pjbu010) THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
         END IF          
      ELSE
         SELECT pjbbl003,pjbbl004,pjbbl005 INTO l_pjbbl.pjbbl003,l_pjbbl.pjbbl004,l_pjbbl.pjbbl005 FROM pjbbl_t 
          WHERE pjbblent = g_enterprise  
            AND pjbbl001 = g_pjbn_m.pjbn001
            AND pjbbl002 = g_pjbo_m.pjbo002
            AND pjbbl003 = l_pjbol003
         IF (NOT cl_null(l_pjbol004) AND (l_pjbol004 != l_pjbbl.pjbbl004 OR cl_null(l_pjbbl.pjbbl004))) OR
            (cl_null(l_pjbol004) AND NOT cl_null(l_pjbbl.pjbbl004)) THEN
            #其說明的SQL
            LET l_pjbu010 = ''
            #新增資料到變更歷程檔
            IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbbl.pjbbl003,g_pjbn_m.pjbn900,"pjbbl004",'2',l_pjbbl.pjbbl004,l_pjbol004,l_pjbu009,l_pjbu010) THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
            END IF
         ELSE
            #資料一樣，表示無變更，將變更歷程檔刪除
            IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbbl.pjbbl003,g_pjbn_m.pjbn900,"pjbbl004") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF  
        
         IF (NOT cl_null(l_pjbol005) AND (l_pjbol005 != l_pjbbl.pjbbl005 OR cl_null(l_pjbbl.pjbbl005))) OR
            (cl_null(l_pjbol005) AND NOT cl_null(l_pjbbl.pjbbl005)) THEN
            #其說明的SQL
            LET l_pjbu010 = ''
            #新增資料到變更歷程檔
            IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbbl.pjbbl003,g_pjbn_m.pjbn900,"pjbbl005",'2',l_pjbbl.pjbbl005,l_pjbol005,l_pjbu009,l_pjbu010) THEN
               LET r_success = FALSE
               RETURN r_success
            ELSE
               LET l_flag1 = TRUE     #有欄位變更，則更新為'Y'
            END IF
         ELSE
            #資料一樣，表示無變更，將變更歷程檔刪除
            IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,l_pjbbl.pjbbl003,g_pjbn_m.pjbn900,"pjbbl005") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF  
         
         #有欄位變更，則更新為'2'
         IF l_flag1 THEN
            UPDATE pjbol_t SET pjbol901 = '2'
             WHERE pjbolent = g_enterprise
               AND pjbol002 = g_pjbo_m.pjbo002
               AND pjbol001 = g_pjbn_m.pjbn001
               AND pjbol003 = l_pjbol003
               AND pjbol900 = g_pjbn_m.pjbn900
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "upd pjbol901"
               LET g_errparam.popup = TRUE
               CALL cl_err()
       
               LET r_success = FALSE
               RETURN r_success
            END IF         
         END IF             
      END IF
   END FOREACH  
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbp_ins_pjbu(p_pjbp901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbp_ins_pjbu(p_pjbp901)
DEFINE   p_pjbp901     LIKE pjbp_t.pjbp901
#DEFINE   l_pjbc       RECORD LIKE pjbc_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbc RECORD  #專案成員檔
       pjbcent LIKE pjbc_t.pjbcent, #企业编号
       pjbc001 LIKE pjbc_t.pjbc001, #项目编号
       pjbc002 LIKE pjbc_t.pjbc002, #项目角色
       pjbc003 LIKE pjbc_t.pjbc003, #员工编号
       pjbc004 LIKE pjbc_t.pjbc004, #生效日期
       pjbc005 LIKE pjbc_t.pjbc005, #失效日期
       pjbc006 LIKE pjbc_t.pjbc006 #备注
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbp901 = '1' THEN   #未變更
      RETURN r_success
   END IF  
   
   IF p_pjbp901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbc_t
       WHERE pjbcent = g_enterprise
         AND pjbc001 = g_pjbn_m.pjbn001
         AND pjbc002 = g_pjbq5_d[l_ac].pjbp002
         AND pjbc003 = g_pjbq5_d[l_ac].pjbp003 
         
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbp901 = '3'
      END IF      
   END IF
   
   INITIALIZE l_pjbc.* TO NULL
   
   LET l_flag = FALSE

   IF p_pjbp901 = '2' THEN   #變更
      SELECT  UNIQUE pjbc002,pjbc003,pjbc004,pjbc005,pjbc006
                INTO l_pjbc.pjbc002,l_pjbc.pjbc003,l_pjbc.pjbc004,l_pjbc.pjbc005,l_pjbc.pjbc006
                FROM pjbc_t
          WHERE pjbcent = g_enterprise
            AND pjbc001 = g_pjbn_m.pjbn001
            AND pjbc002 = g_pjbq5_d[l_ac].pjbp002
            AND pjbc003 = g_pjbq5_d[l_ac].pjbp003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF              
   END IF
   
   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
      ((g_pjbq5_d[l_ac].pjbp002 <> l_pjbc.pjbc002) OR
      (g_pjbq5_d[l_ac].pjbp002 IS NULL AND l_pjbc.pjbc002 IS NOT NULL) OR
      (g_pjbq5_d[l_ac].pjbp002 IS NOT NULL AND l_pjbc.pjbc002 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002='",l_pjbc.pjbc002,"' AND oocql003=? "
      #新增資料到變更歷程檔
      #IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq5_d[l_ac].pjbp002,g_pjbn_m.pjbn900,"pjbc002",p_pjbp901,l_pjbc.pjbc002,g_pjbq5_d[l_ac].pjbp002,l_pjbu009,g_pjbu010) THEN 
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc002",p_pjbp901,l_pjbc.pjbc002,g_pjbq5_d[l_ac].pjbp002,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      #IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq5_d[l_ac].pjbp002,g_pjbn_m.pjbn900,"pjbc002") THEN
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc002") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF    

   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
      ((g_pjbq5_d[l_ac].pjbp003 <> l_pjbc.pjbc003) OR
      (g_pjbq5_d[l_ac].pjbp003 IS NULL AND l_pjbc.pjbc003 IS NOT NULL) OR
      (g_pjbq5_d[l_ac].pjbp003 IS NOT NULL AND l_pjbc.pjbc003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001='",l_pjbc.pjbc003,"'"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc003",p_pjbp901,l_pjbc.pjbc003,g_pjbq5_d[l_ac].pjbp003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
      ((g_pjbq5_d[l_ac].pjbp004 <> l_pjbc.pjbc004) OR
      (g_pjbq5_d[l_ac].pjbp004 IS NULL AND l_pjbc.pjbc004 IS NOT NULL) OR
      (g_pjbq5_d[l_ac].pjbp004 IS NOT NULL AND l_pjbc.pjbc004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc004",p_pjbp901,l_pjbc.pjbc004,g_pjbq5_d[l_ac].pjbp004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
      ((g_pjbq5_d[l_ac].pjbp005 <> l_pjbc.pjbc005) OR
      (g_pjbq5_d[l_ac].pjbp005 IS NULL AND l_pjbc.pjbc005 IS NOT NULL) OR
      (g_pjbq5_d[l_ac].pjbp005 IS NOT NULL AND l_pjbc.pjbc005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc005",p_pjbp901,l_pjbc.pjbc005,g_pjbq5_d[l_ac].pjbp005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
      ((g_pjbq5_d[l_ac].pjbp006 <> l_pjbc.pjbc006) OR
      (g_pjbq5_d[l_ac].pjbp006 IS NULL AND l_pjbc.pjbc006 IS NOT NULL) OR
      (g_pjbq5_d[l_ac].pjbp006 IS NOT NULL AND l_pjbc.pjbc006 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc006",p_pjbp901,l_pjbc.pjbc006,g_pjbq5_d[l_ac].pjbp006,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbq5_d[l_ac].pjbp002,g_pjbq5_d[l_ac].pjbp003,g_pjbn_m.pjbn900,"pjbc006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   #回寫變更類型
   IF l_flag THEN
      UPDATE pjbp_t SET pjbp901 = p_pjbp901
       WHERE pjbpent = g_enterprise
         AND pjbp001 = g_pjbn_m.pjbn001
         AND pjbp002 = g_pjbq5_d[g_detail_idx].pjbp002
         AND pjbp003 = g_pjbq5_d[g_detail_idx].pjbp003
         AND pjbp900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbp901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbq_ins_pjbu(p_pjbq901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbq_ins_pjbu(p_pjbq901)
DEFINE   p_pjbq901    LIKE pjbq_t.pjbq901
#DEFINE   l_pjbd       RECORD LIKE pjbd_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbd RECORD  #專案WBS材料預算檔
       pjbdent LIKE pjbd_t.pjbdent, #企业编号
       pjbd001 LIKE pjbd_t.pjbd001, #项目编号
       pjbd002 LIKE pjbd_t.pjbd002, #本阶WBS
       pjbd003 LIKE pjbd_t.pjbd003, #项次
       pjbd004 LIKE pjbd_t.pjbd004, #产品分类
       pjbd005 LIKE pjbd_t.pjbd005, #限定料号
       pjbd006 LIKE pjbd_t.pjbd006, #单位
       pjbd007 LIKE pjbd_t.pjbd007, #数量
       pjbd008 LIKE pjbd_t.pjbd008, #单价
       pjbd009 LIKE pjbd_t.pjbd009, #金额
       pjbd010 LIKE pjbd_t.pjbd010, #补充说明
       pjbd011 LIKE pjbd_t.pjbd011, #已转请购量
       pjbd012 LIKE pjbd_t.pjbd012, #币种
       pjbd013 LIKE pjbd_t.pjbd013, #汇率
       pjbd014 LIKE pjbd_t.pjbd014, #税种
       pjbd015 LIKE pjbd_t.pjbd015, #税率
       pjbd016 LIKE pjbd_t.pjbd016, #原币含税金额
       pjbd017 LIKE pjbd_t.pjbd017, #原币税额
       pjbd018 LIKE pjbd_t.pjbd018, #本币税前金额
       pjbd019 LIKE pjbd_t.pjbd019, #本币含税金额
       pjbd020 LIKE pjbd_t.pjbd020, #本币税额
       pjbd021 LIKE pjbd_t.pjbd021 #产品特征
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbq901 = '1' THEN   #未變更
      RETURN r_success
   END IF   
   
   IF p_pjbq901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbd_t
       WHERE pjbdent = g_enterprise
         AND pjbd001 = g_pjbn_m.pjbn001
         AND pjbd002 = g_pjbo_m.pjbo002
         AND pjbd003 = g_pjbq_d[l_ac].pjbq003
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbq901 = '3'
      END IF      
   END IF
   
   INITIALIZE l_pjbd.* TO NULL
   LET l_flag = FALSE   
   IF p_pjbq901 = '2' THEN   #修改
      SELECT UNIQUE pjbd003,pjbd004,pjbd005,pjbd010,pjbd006,pjbd007,pjbd008,pjbd009
               INTO l_pjbd.pjbd003,l_pjbd.pjbd004,l_pjbd.pjbd005,l_pjbd.pjbd010,l_pjbd.pjbd006,l_pjbd.pjbd007,l_pjbd.pjbd008,l_pjbd.pjbd009
         
        FROM pjbd_t 
       WHERE pjbdent = g_enterprise
         AND pjbd001 = g_pjbn_m.pjbn001
         AND pjbd002 = g_pjbo_m.pjbo002
         AND pjbd003 = g_pjbq_d[l_ac].pjbq003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF   

   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq003 <> l_pjbd.pjbd003) OR
      (g_pjbq_d[l_ac].pjbq003 IS NULL AND l_pjbd.pjbd003 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq003 IS NOT NULL AND l_pjbd.pjbd003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd003",p_pjbq901,l_pjbd.pjbd003,g_pjbq_d[l_ac].pjbq003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq004 <> l_pjbd.pjbd004) OR
      (g_pjbq_d[l_ac].pjbq004 IS NULL AND l_pjbd.pjbd004 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq004 IS NOT NULL AND l_pjbd.pjbd004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001='",l_pjbd.pjbd004,"' AND rtaxl002= ? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd004",p_pjbq901,l_pjbd.pjbd004,g_pjbq_d[l_ac].pjbq004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq005 <> l_pjbd.pjbd005) OR
      (g_pjbq_d[l_ac].pjbq005 IS NULL AND l_pjbd.pjbd005 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq005 IS NOT NULL AND l_pjbd.pjbd005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001='",l_pjbd.pjbd005,"' AND imaal002=?"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd005",p_pjbq901,l_pjbd.pjbd005,g_pjbq_d[l_ac].pjbq005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq006 <> l_pjbd.pjbd006) OR
      (g_pjbq_d[l_ac].pjbq006 IS NULL AND l_pjbd.pjbd006 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq006 IS NOT NULL AND l_pjbd.pjbd006 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='",l_pjbd.pjbd006,"' AND oocal002= ?"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd006",p_pjbq901,l_pjbd.pjbd006,g_pjbq_d[l_ac].pjbq006,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF   

   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq007 <> l_pjbd.pjbd007) OR
      (g_pjbq_d[l_ac].pjbq007 IS NULL AND l_pjbd.pjbd007 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq007 IS NOT NULL AND l_pjbd.pjbd007 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd007",p_pjbq901,l_pjbd.pjbd007,g_pjbq_d[l_ac].pjbq007,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq008 <> l_pjbd.pjbd008) OR
      (g_pjbq_d[l_ac].pjbq008 IS NULL AND l_pjbd.pjbd008 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq008 IS NOT NULL AND l_pjbd.pjbd008 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd008",p_pjbq901,l_pjbd.pjbd008,g_pjbq_d[l_ac].pjbq008,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq009 <> l_pjbd.pjbd009) OR
      (g_pjbq_d[l_ac].pjbq009 IS NULL AND l_pjbd.pjbd009 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq009 IS NOT NULL AND l_pjbd.pjbd009 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd009",p_pjbq901,l_pjbd.pjbd009,g_pjbq_d[l_ac].pjbq009,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd009") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
      ((g_pjbq_d[l_ac].pjbq010 <> l_pjbd.pjbd010) OR
      (g_pjbq_d[l_ac].pjbq010 IS NULL AND l_pjbd.pjbd010 IS NOT NULL) OR
      (g_pjbq_d[l_ac].pjbq010 IS NOT NULL AND l_pjbd.pjbd010 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd010",p_pjbq901,l_pjbd.pjbd010,g_pjbq_d[l_ac].pjbq010,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq_d[l_ac].pjbq003,g_pjbn_m.pjbn900,"pjbd010") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   #回寫變更類型
   IF l_flag THEN
      UPDATE pjbq_t SET pjbq901 = p_pjbq901
       WHERE pjbqent = g_enterprise
         AND pjbq001 = g_pjbn_m.pjbn001
         AND pjbq002 = g_pjbo_m.pjbo002
         AND pjbq003 = g_pjbq_d[g_detail_idx].pjbq003
         AND pjbq900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbq901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF     
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbr_ins_pjbu(p_pjbr901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbr_ins_pjbu(p_pjbr901)
DEFINE   p_pjbr901    LIKE pjbr_t.pjbr901
#DEFINE   l_pjbe       RECORD LIKE pjbe_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbe RECORD  #專案WBS人力預算檔
       pjbeent LIKE pjbe_t.pjbeent, #企业编号
       pjbe001 LIKE pjbe_t.pjbe001, #项目编号
       pjbe002 LIKE pjbe_t.pjbe002, #本阶WBS
       pjbe003 LIKE pjbe_t.pjbe003, #项目角色
       pjbe004 LIKE pjbe_t.pjbe004, #时数
       pjbe005 LIKE pjbe_t.pjbe005, #天数
       pjbe006 LIKE pjbe_t.pjbe006, #职能成本单价(时)
       pjbe007 LIKE pjbe_t.pjbe007, #职能成本单价(天)
       pjbe008 LIKE pjbe_t.pjbe008, #职能成本金额
       pjbe009 LIKE pjbe_t.pjbe009, #备注
       pjbe010 LIKE pjbe_t.pjbe010, #税种
       pjbe011 LIKE pjbe_t.pjbe011, #税率
       pjbe012 LIKE pjbe_t.pjbe012, #原币含税金额
       pjbe013 LIKE pjbe_t.pjbe013, #本币税前金额
       pjbe014 LIKE pjbe_t.pjbe014 #本币含税金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)

DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbr901 = '1' THEN   #未變更
      RETURN r_success
   END IF  
 
   IF p_pjbr901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbe_t
       WHERE pjbeent = g_enterprise
         AND pjbe001 = g_pjbn_m.pjbn001
         AND pjbe002 = g_pjbo_m.pjbo002
         AND pjbe003 = g_pjbq2_d[l_ac].pjbr003
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbr901 = '3'
      END IF      
   END IF 
   
   INITIALIZE l_pjbe.* TO NULL
   
   LET l_flag = FALSE  
   IF p_pjbr901 = '2' THEN   #修改
      SELECT UNIQUE pjbe003,pjbe004,pjbe005,pjbe006,pjbe007,pjbe008,pjbe009 
               INTO l_pjbe.pjbe003,l_pjbe.pjbe004,l_pjbe.pjbe005,l_pjbe.pjbe006,l_pjbe.pjbe007,l_pjbe.pjbe008,l_pjbe.pjbe009         
        FROM pjbe_t 
       WHERE pjbeent = g_enterprise
         AND pjbe001 = g_pjbn_m.pjbn001
         AND pjbe002 = g_pjbo_m.pjbo002
         AND pjbe003 = g_pjbq2_d[l_ac].pjbr003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbe_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF         
   END IF   

   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr003 <> l_pjbe.pjbe003) OR
      (g_pjbq2_d[l_ac].pjbr003 IS NULL AND l_pjbe.pjbe003 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr003 IS NOT NULL AND l_pjbe.pjbe003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8002' AND oocql002='",l_pjbe.pjbe003,"' AND oocql003= ? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe003",p_pjbr901,l_pjbe.pjbe003,g_pjbq2_d[l_ac].pjbr003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  
   
   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr004 <> l_pjbe.pjbe004) OR
      (g_pjbq2_d[l_ac].pjbr004 IS NULL AND l_pjbe.pjbe004 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr004 IS NOT NULL AND l_pjbe.pjbe004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe004",p_pjbr901,l_pjbe.pjbe004,g_pjbq2_d[l_ac].pjbr004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  

   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr005 <> l_pjbe.pjbe005) OR
      (g_pjbq2_d[l_ac].pjbr005 IS NULL AND l_pjbe.pjbe005 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr005 IS NOT NULL AND l_pjbe.pjbe005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe005",p_pjbr901,l_pjbe.pjbe005,g_pjbq2_d[l_ac].pjbr005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF  
   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr006 <> l_pjbe.pjbe006) OR
      (g_pjbq2_d[l_ac].pjbr006 IS NULL AND l_pjbe.pjbe006 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr006 IS NOT NULL AND l_pjbe.pjbe006 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe006",p_pjbr901,l_pjbe.pjbe006,g_pjbq2_d[l_ac].pjbr006,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF    
   
   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr007 <> l_pjbe.pjbe007) OR
      (g_pjbq2_d[l_ac].pjbr007 IS NULL AND l_pjbe.pjbe007 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr007 IS NOT NULL AND l_pjbe.pjbe007 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe007",p_pjbr901,l_pjbe.pjbe007,g_pjbq2_d[l_ac].pjbr007,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr008 <> l_pjbe.pjbe008) OR
      (g_pjbq2_d[l_ac].pjbr008 IS NULL AND l_pjbe.pjbe008 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr008 IS NOT NULL AND l_pjbe.pjbe008 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe008",p_pjbr901,l_pjbe.pjbe008,g_pjbq2_d[l_ac].pjbr008,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF   
   
   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
      ((g_pjbq2_d[l_ac].pjbr009 <> l_pjbe.pjbe009) OR
      (g_pjbq2_d[l_ac].pjbr009 IS NULL AND l_pjbe.pjbe009 IS NOT NULL) OR
      (g_pjbq2_d[l_ac].pjbr009 IS NOT NULL AND l_pjbe.pjbe009 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe009",p_pjbr901,l_pjbe.pjbe009,g_pjbq2_d[l_ac].pjbr009,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq2_d[l_ac].pjbr003,g_pjbn_m.pjbn900,"pjbe009") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   #回寫變更類型
   IF l_flag THEN
      UPDATE pjbr_t SET pjbr901 = p_pjbr901
       WHERE pjbrent = g_enterprise
         AND pjbr001 = g_pjbn_m.pjbn001
         AND pjbr002 = g_pjbo_m.pjbo002
         AND pjbr003 = g_pjbq2_d[g_detail_idx].pjbr003
         AND pjbr900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbr901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF      
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbs_ins_pjbu(p_pjbs901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbs_ins_pjbu(p_pjbs901)
DEFINE   p_pjbs901    LIKE pjbs_t.pjbs901
#DEFINE   l_pjbf       RECORD LIKE pjbf_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbf RECORD  #專案WBS裝置預算檔
       pjbfent LIKE pjbf_t.pjbfent, #企业编号
       pjbf001 LIKE pjbf_t.pjbf001, #项目编号
       pjbf002 LIKE pjbf_t.pjbf002, #本阶WBS
       pjbf003 LIKE pjbf_t.pjbf003, #限定机器
       pjbf004 LIKE pjbf_t.pjbf004, #耗用单位
       pjbf005 LIKE pjbf_t.pjbf005, #耗用数量
       pjbf006 LIKE pjbf_t.pjbf006, #单位成本率
       pjbf007 LIKE pjbf_t.pjbf007, #金额
       pjbf008 LIKE pjbf_t.pjbf008, #备注
       pjbf009 LIKE pjbf_t.pjbf009, #税种
       pjbf010 LIKE pjbf_t.pjbf010, #税率
       pjbf011 LIKE pjbf_t.pjbf011, #原币含税金额
       pjbf012 LIKE pjbf_t.pjbf012, #本币税前金额
       pjbf013 LIKE pjbf_t.pjbf013, #本币含税金额
       pjbf014 LIKE pjbf_t.pjbf014 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbs901 = '1' THEN   #未變更
      RETURN r_success
   END IF  

   IF p_pjbs901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbf_t
       WHERE pjbfent = g_enterprise
         AND pjbf001 = g_pjbn_m.pjbn001
         AND pjbf002 = g_pjbo_m.pjbo002
         AND pjbf003 = g_pjbq3_d[l_ac].pjbs003 
         
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbs901 = '3'
      END IF      
   END IF 
   
   INITIALIZE l_pjbf.* TO NULL
   
   LET l_flag = FALSE
   IF p_pjbs901 = '2' THEN   #變更
      SELECT  UNIQUE pjbf003,pjbf004,pjbf005,pjbf006,pjbf007,pjbf008 
                INTO l_pjbf.pjbf003,l_pjbf.pjbf004,l_pjbf.pjbf005,l_pjbf.pjbf006,l_pjbf.pjbf007,l_pjbf.pjbf008
                FROM pjbf_t
          WHERE pjbfent = g_enterprise
            AND pjbf001 = g_pjbn_m.pjbn001
            AND pjbf002 = g_pjbo_m.pjbo002
            AND pjbf003 = g_pjbq3_d[l_ac].pjbs003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbf_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF              
   END IF

   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs003 <> l_pjbf.pjbf003) OR
      (g_pjbq3_d[l_ac].pjbs003 IS NULL AND l_pjbf.pjbf003 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs003 IS NOT NULL AND l_pjbf.pjbf003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrba001='",l_pjbf.pjbf003,"'"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf003",p_pjbs901,l_pjbf.pjbf003,g_pjbq3_d[l_ac].pjbs003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs004 <> l_pjbf.pjbf004) OR
      (g_pjbq3_d[l_ac].pjbs004 IS NULL AND l_pjbf.pjbf004 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs004 IS NOT NULL AND l_pjbf.pjbf004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='",l_pjbf.pjbf004,"' AND oocal002=? "
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf004",p_pjbs901,l_pjbf.pjbf004,g_pjbq3_d[l_ac].pjbs004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs005 <> l_pjbf.pjbf005) OR
      (g_pjbq3_d[l_ac].pjbs005 IS NULL AND l_pjbf.pjbf005 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs005 IS NOT NULL AND l_pjbf.pjbf005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf005",p_pjbs901,l_pjbf.pjbf005,g_pjbq3_d[l_ac].pjbs005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs006 <> l_pjbf.pjbf006) OR
      (g_pjbq3_d[l_ac].pjbs006 IS NULL AND l_pjbf.pjbf006 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs006 IS NOT NULL AND l_pjbf.pjbf006 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf006",p_pjbs901,l_pjbf.pjbf006,g_pjbq3_d[l_ac].pjbs006,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf006") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   
   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs007 <> l_pjbf.pjbf007) OR
      (g_pjbq3_d[l_ac].pjbs007 IS NULL AND l_pjbf.pjbf007 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs007 IS NOT NULL AND l_pjbf.pjbf007 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf007",p_pjbs901,l_pjbf.pjbf007,g_pjbq3_d[l_ac].pjbs007,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf007") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF
   
   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
      ((g_pjbq3_d[l_ac].pjbs008 <> l_pjbf.pjbf008) OR
      (g_pjbq3_d[l_ac].pjbs008 IS NULL AND l_pjbf.pjbf008 IS NOT NULL) OR
      (g_pjbq3_d[l_ac].pjbs008 IS NOT NULL AND l_pjbf.pjbf008 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf008",p_pjbs901,l_pjbf.pjbf008,g_pjbq3_d[l_ac].pjbs008,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq3_d[l_ac].pjbs003,g_pjbn_m.pjbn900,"pjbf008") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF    

   #回寫變更類型
   IF l_flag THEN
      UPDATE pjbs_t SET pjbs901 = p_pjbs901
       WHERE pjbsent = g_enterprise
         AND pjbs001 = g_pjbn_m.pjbn001
         AND pjbs002 = g_pjbo_m.pjbo002
         AND pjbs003 = g_pjbq3_d[g_detail_idx].pjbs003
         AND pjbs900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbs901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF 
   
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbt_ins_pjbu(p_pjbt901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbt_ins_pjbu(p_pjbt901)
DEFINE   p_pjbt901      LIKE pjbt_t.pjbt901
#DEFINE   l_pjbg       RECORD LIKE pjbg_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbg RECORD  #專案WBS費用預算檔
       pjbgent LIKE pjbg_t.pjbgent, #企业编号
       pjbg001 LIKE pjbg_t.pjbg001, #项目编号
       pjbg002 LIKE pjbg_t.pjbg002, #本阶WBS
       pjbg003 LIKE pjbg_t.pjbg003, #费用类型
       pjbg004 LIKE pjbg_t.pjbg004, #金额
       pjbg005 LIKE pjbg_t.pjbg005, #备注
       pjbg006 LIKE pjbg_t.pjbg006, #税种
       pjbg007 LIKE pjbg_t.pjbg007, #税率
       pjbg008 LIKE pjbg_t.pjbg008, #原币规划含税金额
       pjbg009 LIKE pjbg_t.pjbg009, #本币规划税前金额
       pjbg010 LIKE pjbg_t.pjbg010, #本币规划含税金额
       pjbg011 LIKE pjbg_t.pjbg011 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success    LIKE type_t.num5
DEFINE   l_pjbu009    LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010    LIKE pjbu_t.pjbu010
DEFINE   l_flag       LIKE type_t.num5
DEFINE   l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   LET l_pjbu009 = cl_get_current()
   
   IF p_pjbt901 = '1' THEN   #未變更
      RETURN r_success
   END IF  

   IF p_pjbt901 = '2' THEN   #修改
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM pjbg_t
       WHERE pjbgent = g_enterprise
         AND pjbg001 = g_pjbn_m.pjbn001
         AND pjbg002 = g_pjbo_m.pjbo002
         AND pjbg003 = g_pjbq4_d[l_ac].pjbt003 
         
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
      IF l_cnt > 0 THEN
      ELSE
         LET p_pjbt901 = '3'
      END IF      
   END IF 
   
   INITIALIZE l_pjbg.* TO NULL
   
   LET l_flag = FALSE

   IF p_pjbt901 = '2' THEN   #變更
      SELECT  UNIQUE pjbg003,pjbg004,pjbg005
                INTO l_pjbg.pjbg003,l_pjbg.pjbg004,l_pjbg.pjbg005
                FROM pjbg_t
          WHERE pjbgent = g_enterprise
            AND pjbg001 = g_pjbn_m.pjbn001
            AND pjbg002 = g_pjbo_m.pjbo002
            AND pjbg003 = g_pjbq4_d[l_ac].pjbt003 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel pjbg_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF              
   END IF

   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
      ((g_pjbq4_d[l_ac].pjbt003 <> l_pjbg.pjbg003) OR
      (g_pjbq4_d[l_ac].pjbt003 IS NULL AND l_pjbg.pjbg003 IS NOT NULL) OR
      (g_pjbq4_d[l_ac].pjbt003 IS NOT NULL AND l_pjbg.pjbg003 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='8003' AND oocql002='",l_pjbg.pjbg003,"' AND oocql003=?"
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg003",p_pjbt901,l_pjbg.pjbg003,g_pjbq4_d[l_ac].pjbt003,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg003") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
      ((g_pjbq4_d[l_ac].pjbt004 <> l_pjbg.pjbg004) OR
      (g_pjbq4_d[l_ac].pjbt004 IS NULL AND l_pjbg.pjbg004 IS NOT NULL) OR
      (g_pjbq4_d[l_ac].pjbt004 IS NOT NULL AND l_pjbg.pjbg004 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg004",p_pjbt901,l_pjbg.pjbg004,g_pjbq4_d[l_ac].pjbt004,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg004") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 
   
   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
      ((g_pjbq4_d[l_ac].pjbt005 <> l_pjbg.pjbg005) OR
      (g_pjbq4_d[l_ac].pjbt005 IS NULL AND l_pjbg.pjbg005 IS NOT NULL) OR
      (g_pjbq4_d[l_ac].pjbt005 IS NOT NULL AND l_pjbg.pjbg005 IS NULL))) THEN
      
      #欄位說明SQL
      LET g_pjbu010 = ''
      #新增資料到變更歷程檔
      IF NOT s_apjm300_ins_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg005",p_pjbt901,l_pjbg.pjbg005,g_pjbq4_d[l_ac].pjbt005,l_pjbu009,g_pjbu010) THEN      
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_flag = TRUE
   ELSE
      #資料一樣，表示無變更，將變更歷程檔刪除
      IF NOT s_apjm300_del_pjbu(g_pjbn_m.pjbn001,g_pjbo_m.pjbo002,g_pjbq4_d[l_ac].pjbt003,g_pjbn_m.pjbn900,"pjbg005") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF      
   END IF 

   #回寫變更類型
   IF l_flag THEN
      UPDATE pjbt_t SET pjbt901 = p_pjbt901
       WHERE pjbtent = g_enterprise
         AND pjbt001 = g_pjbn_m.pjbn001
         AND pjbt002 = g_pjbo_m.pjbo002
         AND pjbt003 = g_pjbq4_d[g_detail_idx].pjbt003
         AND pjbt900 = g_pjbn_m.pjbn900
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjbt901"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF    
   END IF 
   
   RETURN r_success 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbp_set_color(p_pjbp901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbp_set_color(p_pjbp901)
DEFINE   p_pjbp901     LIKE pjbp_t.pjbp901
#DEFINE   l_pjbc        RECORD LIKE pjbc_t.*
#DEFINE   r_success     LIKE type_t.num5
#DEFINE   l_pjbu009     LIKE pjbu_t.pjbu009
#DEFINE   g_pjbu010     LIKE pjbu_t.pjbu010
#DEFINE   l_flag        LIKE type_t.num5
DEFINE   l_pjbu005     LIKE pjbu_t.pjbu005


   INITIALIZE g_pjbq5_d_color[l_ac].* TO NULL

   DECLARE sel_pjbp_cs CURSOR FOR
    SELECT pjbu005 FROM pjbu_t
     WHERE pjbuent = g_enterprise
       AND pjbu001 = g_pjbn_m.pjbn001
       AND pjbu002 = g_pjbq5_d[l_ac].pjbp002
       AND pjbu003 = g_pjbq5_d[l_ac].pjbp003 
       AND pjbu004 = g_pjbn_m.pjbn900  
    
    FOREACH sel_pjbp_cs INTO l_pjbu005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjbc','pjbp')

      CASE l_pjbu005
      
         WHEN 'pjbp002' 
            LET  g_pjbq5_d_color[l_ac].pjbp002 = "red" 
            LET  g_pjbq5_d_color[l_ac].pjbp002_desc = "red"  
            
         WHEN 'pjbp003' 
            LET  g_pjbq5_d_color[l_ac].pjbp003 = "red" 
            LET  g_pjbq5_d_color[l_ac].pjbp003_desc = "red" 
          
         WHEN 'pjbp004'          
            LET  g_pjbq5_d_color[l_ac].pjbp004 = "red"  
            
         WHEN 'pjbp005'            
            LET  g_pjbq5_d_color[l_ac].pjbp005 = "red"  
            
         WHEN 'pjbp006'          
            LET  g_pjbq5_d_color[l_ac].pjbp006 = "red"   
       END CASE
    END FOREACH 
#   IF p_pjbp901 = '2' THEN   #變更
#      SELECT  UNIQUE pjbc002,pjbc003,pjbc004,pjbc005,pjbc006
#                INTO l_pjbc.pjbc002,l_pjbc.pjbc003,l_pjbc.pjbc004,l_pjbc.pjbc005,l_pjbc.pjbc006
#                FROM pjbc_t
#          WHERE pjbcent = g_enterprise
#            AND pjbc001 = g_pjbn_m.pjbn001
#            AND pjbc002 = g_pjbq5_d[l_ac].pjbp002
#            AND pjbc003 = g_pjbq5_d[l_ac].pjbp003 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'sel pjbc_t'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF              
#   END IF
#
#   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
#      ((g_pjbq5_d[l_ac].pjbp002 <> l_pjbc.pjbc002) OR
#      (g_pjbq5_d[l_ac].pjbp002 IS NULL AND l_pjbc.pjbc002 IS NOT NULL) OR
#      (g_pjbq5_d[l_ac].pjbp002 IS NOT NULL AND l_pjbc.pjbc002 IS NULL))) THEN
#      
#      LET  g_pjbq5_d_color[l_ac].pjbp002 = "red" 
#      LET  g_pjbq5_d_color[l_ac].pjbp002_desc = "red" 
#      
#   END IF 
#   
#   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
#      ((g_pjbq5_d[l_ac].pjbp003 <> l_pjbc.pjbc003) OR
#      (g_pjbq5_d[l_ac].pjbp003 IS NULL AND l_pjbc.pjbc003 IS NOT NULL) OR
#      (g_pjbq5_d[l_ac].pjbp003 IS NOT NULL AND l_pjbc.pjbc003 IS NULL))) THEN
#      
#      LET  g_pjbq5_d_color[l_ac].pjbp003 = "red" 
#      LET  g_pjbq5_d_color[l_ac].pjbp003_desc = "red" 
#      
#   END IF 
#
#   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
#      ((g_pjbq5_d[l_ac].pjbp004 <> l_pjbc.pjbc004) OR
#      (g_pjbq5_d[l_ac].pjbp004 IS NULL AND l_pjbc.pjbc004 IS NOT NULL) OR
#      (g_pjbq5_d[l_ac].pjbp004 IS NOT NULL AND l_pjbc.pjbc004 IS NULL))) THEN
#      
#      LET  g_pjbq5_d_color[l_ac].pjbp004 = "red"      
#   END IF 
#   
#   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
#      ((g_pjbq5_d[l_ac].pjbp005 <> l_pjbc.pjbc005) OR
#      (g_pjbq5_d[l_ac].pjbp005 IS NULL AND l_pjbc.pjbc005 IS NOT NULL) OR
#      (g_pjbq5_d[l_ac].pjbp005 IS NOT NULL AND l_pjbc.pjbc005 IS NULL))) THEN
#      
#      LET  g_pjbq5_d_color[l_ac].pjbp005 = "red"      
#   END IF 
#
#   IF p_pjbp901 = '3' OR (p_pjbp901 = '2' AND
#      ((g_pjbq5_d[l_ac].pjbp006 <> l_pjbc.pjbc006) OR
#      (g_pjbq5_d[l_ac].pjbp006 IS NULL AND l_pjbc.pjbc006 IS NOT NULL) OR
#      (g_pjbq5_d[l_ac].pjbp006 IS NOT NULL AND l_pjbc.pjbc006 IS NULL))) THEN
#      
#      LET  g_pjbq5_d_color[l_ac].pjbp006 = "red"      
#   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbq_set_color(p_pjbq901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbq_set_color(p_pjbq901)
DEFINE   p_pjbq901     LIKE pjbq_t.pjbq901
#DEFINE   l_pjbd        RECORD LIKE pjbd_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbd RECORD  #專案WBS材料預算檔
       pjbdent LIKE pjbd_t.pjbdent, #企业编号
       pjbd001 LIKE pjbd_t.pjbd001, #项目编号
       pjbd002 LIKE pjbd_t.pjbd002, #本阶WBS
       pjbd003 LIKE pjbd_t.pjbd003, #项次
       pjbd004 LIKE pjbd_t.pjbd004, #产品分类
       pjbd005 LIKE pjbd_t.pjbd005, #限定料号
       pjbd006 LIKE pjbd_t.pjbd006, #单位
       pjbd007 LIKE pjbd_t.pjbd007, #数量
       pjbd008 LIKE pjbd_t.pjbd008, #单价
       pjbd009 LIKE pjbd_t.pjbd009, #金额
       pjbd010 LIKE pjbd_t.pjbd010, #补充说明
       pjbd011 LIKE pjbd_t.pjbd011, #已转请购量
       pjbd012 LIKE pjbd_t.pjbd012, #币种
       pjbd013 LIKE pjbd_t.pjbd013, #汇率
       pjbd014 LIKE pjbd_t.pjbd014, #税种
       pjbd015 LIKE pjbd_t.pjbd015, #税率
       pjbd016 LIKE pjbd_t.pjbd016, #原币含税金额
       pjbd017 LIKE pjbd_t.pjbd017, #原币税额
       pjbd018 LIKE pjbd_t.pjbd018, #本币税前金额
       pjbd019 LIKE pjbd_t.pjbd019, #本币含税金额
       pjbd020 LIKE pjbd_t.pjbd020, #本币税额
       pjbd021 LIKE pjbd_t.pjbd021 #产品特征
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   r_success     LIKE type_t.num5
DEFINE   l_pjbu009     LIKE pjbu_t.pjbu009
DEFINE   g_pjbu010     LIKE pjbu_t.pjbu010
DEFINE   l_flag        LIKE type_t.num5
DEFINE   l_pjbu005     LIKE pjbu_t.pjbu005
DEFINE   l_sql         STRING

   INITIALIZE g_pjbq_d_color[l_ac].* TO NULL
   
#   DECLARE sel_pjbq_cs CURSOR FOR
#    SELECT pjbu005 FROM pjbu_t
#     WHERE pjbuent = g_enterprise
#       AND pjbu001 = g_pjbn_m.pjbn001
#       AND pjbu002 = g_pjbo_m.pjbo002
#       AND pjbu003 = g_pjbq_d[l_ac].pjbq003
#       AND pjbu004 = g_pjbn_m.pjbn900  
    LET l_sql = " SELECT pjbu005 FROM pjbu_t ",  
                "  WHERE pjbuent = '",g_enterprise,"'",
                "    AND pjbu001 = '",g_pjbn_m.pjbn001,"'",
                "    AND pjbu002 = '",g_pjbo_m.pjbo002,"'",
                "    AND pjbu003 = trim('",g_pjbq_d[l_ac].pjbq003,"')", 
                "    AND pjbu004 = ",g_pjbn_m.pjbn900
    PREPARE sel_pjbq_pre FROM l_sql
    DECLARE sel_pjbq_cs CURSOR FOR sel_pjbq_pre
      
    FOREACH sel_pjbq_cs INTO l_pjbu005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjbd','pjbq')

      CASE l_pjbu005
      
         WHEN 'pjbq003'
      
            LET g_pjbq_d_color[l_ac].pjbq003 = 'red'      

   
         WHEN 'pjbq004'
            
            LET g_pjbq_d_color[l_ac].pjbq004 = 'red'
            LET g_pjbq_d_color[l_ac].pjbq004_desc = 'red'      

         
         WHEN 'pjbq005'
            
            LET g_pjbq_d_color[l_ac].pjbq005 = 'red'    
            LET g_pjbq_d_color[l_ac].pjbq005_desc = 'red'    
            LET g_pjbq_d_color[l_ac].pjbq005_desc1 = 'red'          

         
         WHEN 'pjbq006'
            
            LET g_pjbq_d_color[l_ac].pjbq006 = 'red'   
            LET g_pjbq_d_color[l_ac].pjbq006_desc = 'red'         
  
         
         WHEN 'pjbq007'
            
            LET g_pjbq_d_color[l_ac].pjbq007 = 'red'    

         WHEN 'pjbq008'         
            
            LET g_pjbq_d_color[l_ac].pjbq008 = 'red'     

         WHEN 'pjbq009'
            
            LET g_pjbq_d_color[l_ac].pjbq009 = 'red'    

         
         WHEN 'pjbq010'
            
            LET g_pjbq_d_color[l_ac].pjbq010 = 'red'    
      END CASE
      
   END FOREACH

#   IF p_pjbq901 = '2' THEN   #修改
#      SELECT UNIQUE pjbd003,pjbd004,pjbd005,pjbd010,pjbd006,pjbd007,pjbd008,pjbd009
#               INTO l_pjbd.pjbd003,l_pjbd.pjbd004,l_pjbd.pjbd005,l_pjbd.pjbd010,l_pjbd.pjbd006,l_pjbd.pjbd007,l_pjbd.pjbd008,l_pjbd.pjbd009
#         
#        FROM pjbd_t 
#       WHERE pjbdent = g_enterprise
#         AND pjbd001 = g_pjbn_m.pjbn001
#         AND pjbd002 = g_pjbo_m.pjbo002
#         AND pjbd003 = g_pjbq_d[l_ac].pjbq003
#
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'sel pjbd_t'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF         
#   END IF   

#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq003 <> l_pjbd.pjbd003) OR
#      (g_pjbq_d[l_ac].pjbq003 IS NULL AND l_pjbd.pjbd003 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq003 IS NOT NULL AND l_pjbd.pjbd003 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq003 = 'red'      
#   END IF 
#   
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq004 <> l_pjbd.pjbd004) OR
#      (g_pjbq_d[l_ac].pjbq004 IS NULL AND l_pjbd.pjbd004 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq004 IS NOT NULL AND l_pjbd.pjbd004 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq004 = 'red'
#      LET g_pjbq_d_color[l_ac].pjbq004_desc = 'red'      
#   END IF 
#
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq005 <> l_pjbd.pjbd005) OR
#      (g_pjbq_d[l_ac].pjbq005 IS NULL AND l_pjbd.pjbd005 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq005 IS NOT NULL AND l_pjbd.pjbd005 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq005 = 'red'    
#      LET g_pjbq_d_color[l_ac].pjbq005_desc = 'red'    
#      LET g_pjbq_d_color[l_ac].pjbq005_desc1 = 'red'          
#   END IF 
#   
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq006 <> l_pjbd.pjbd006) OR
#      (g_pjbq_d[l_ac].pjbq006 IS NULL AND l_pjbd.pjbd006 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq006 IS NOT NULL AND l_pjbd.pjbd006 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq006 = 'red'   
#      LET g_pjbq_d_color[l_ac].pjbq006_desc = 'red'         
#   END IF   
#
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq007 <> l_pjbd.pjbd007) OR
#      (g_pjbq_d[l_ac].pjbq007 IS NULL AND l_pjbd.pjbd007 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq007 IS NOT NULL AND l_pjbd.pjbd007 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq007 = 'red'    
#   END IF 
#   
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq008 <> l_pjbd.pjbd008) OR
#      (g_pjbq_d[l_ac].pjbq008 IS NULL AND l_pjbd.pjbd008 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq008 IS NOT NULL AND l_pjbd.pjbd008 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq008 = 'red'     
#   END IF 
#
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq009 <> l_pjbd.pjbd009) OR
#      (g_pjbq_d[l_ac].pjbq009 IS NULL AND l_pjbd.pjbd009 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq009 IS NOT NULL AND l_pjbd.pjbd009 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq009 = 'red'    
#   END IF 
#   
#   IF p_pjbq901 = '3' OR (p_pjbq901 = '2' AND
#      ((g_pjbq_d[l_ac].pjbq010 <> l_pjbd.pjbd010) OR
#      (g_pjbq_d[l_ac].pjbq010 IS NULL AND l_pjbd.pjbd010 IS NOT NULL) OR
#      (g_pjbq_d[l_ac].pjbq010 IS NOT NULL AND l_pjbd.pjbd010 IS NULL))) THEN
#      
#      LET g_pjbq_d_color[l_ac].pjbq010 = 'red'    
#   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbr_set_color(p_pjbr901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbr_set_color(p_pjbr901)
DEFINE   p_pjbr901    LIKE pjbr_t.pjbr901
#DEFINE   l_pjbe       RECORD LIKE pjbe_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbe RECORD  #專案WBS人力預算檔
       pjbeent LIKE pjbe_t.pjbeent, #企业编号
       pjbe001 LIKE pjbe_t.pjbe001, #项目编号
       pjbe002 LIKE pjbe_t.pjbe002, #本阶WBS
       pjbe003 LIKE pjbe_t.pjbe003, #项目角色
       pjbe004 LIKE pjbe_t.pjbe004, #时数
       pjbe005 LIKE pjbe_t.pjbe005, #天数
       pjbe006 LIKE pjbe_t.pjbe006, #职能成本单价(时)
       pjbe007 LIKE pjbe_t.pjbe007, #职能成本单价(天)
       pjbe008 LIKE pjbe_t.pjbe008, #职能成本金额
       pjbe009 LIKE pjbe_t.pjbe009, #备注
       pjbe010 LIKE pjbe_t.pjbe010, #税种
       pjbe011 LIKE pjbe_t.pjbe011, #税率
       pjbe012 LIKE pjbe_t.pjbe012, #原币含税金额
       pjbe013 LIKE pjbe_t.pjbe013, #本币税前金额
       pjbe014 LIKE pjbe_t.pjbe014 #本币含税金额
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   l_pjbu005     LIKE pjbu_t.pjbu005

   INITIALIZE g_pjbq2_d_color[l_ac].* TO NULL
   DECLARE sel_pjbr_cs CURSOR FOR
    SELECT pjbu005 FROM pjbu_t
     WHERE pjbuent = g_enterprise
       AND pjbu001 = g_pjbn_m.pjbn001
       AND pjbu002 = g_pjbo_m.pjbo002
       AND pjbu003 = g_pjbq2_d[l_ac].pjbr003
       AND pjbu004 = g_pjbn_m.pjbn900  
      
    FOREACH sel_pjbr_cs INTO l_pjbu005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjbe','pjbr')

      CASE l_pjbu005 
         WHEN "pjbr003"      
            LET g_pjbq2_d_color[l_ac].pjbr003 = 'red' 
            LET g_pjbq2_d_color[l_ac].pjbr003_desc = 'red'      
 
   
         WHEN "pjbr004" 
            LET g_pjbq2_d_color[l_ac].pjbr004 = 'red'      


         WHEN "pjbr005" 
            LET g_pjbq2_d_color[l_ac].pjbr005 = 'red'      

         WHEN "pjbr006" 
            LET g_pjbq2_d_color[l_ac].pjbr006 = 'red'       
  
   
         WHEN "pjbr007" 
            LET g_pjbq2_d_color[l_ac].pjbr007 = 'red'      


         WHEN "pjbr008" 
            LET g_pjbq2_d_color[l_ac].pjbr008 = 'red'     

   
         WHEN "pjbr009" 
            LET g_pjbq2_d_color[l_ac].pjbr009 = 'red'      
      END CASE 
   END FOREACH     
#   IF p_pjbr901 = '2' THEN   #修改
#      SELECT UNIQUE pjbe003,pjbe004,pjbe005,pjbe006,pjbe007,pjbe008,pjbe009 
#               INTO l_pjbe.pjbe003,l_pjbe.pjbe004,l_pjbe.pjbe005,l_pjbe.pjbe006,l_pjbe.pjbe007,l_pjbe.pjbe008,l_pjbe.pjbe009         
#        FROM pjbe_t 
#       WHERE pjbeent = g_enterprise
#         AND pjbe001 = g_pjbn_m.pjbn001
#         AND pjbe002 = g_pjbo_m.pjbo002
#         AND pjbe003 = g_pjbq2_d[l_ac].pjbr003
#
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'sel pjbe_t'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF         
#   END IF   

#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr003 <> l_pjbe.pjbe003) OR
#      (g_pjbq2_d[l_ac].pjbr003 IS NULL AND l_pjbe.pjbe003 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr003 IS NOT NULL AND l_pjbe.pjbe003 IS NULL))) THEN
#
#      LET g_pjbq2_d_color[l_ac].pjbr003 = 'red' 
#      LET g_pjbq2_d_color[l_ac].pjbr003_desc = 'red'      
#   END IF  
#   
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr004 <> l_pjbe.pjbe004) OR
#      (g_pjbq2_d[l_ac].pjbr004 IS NULL AND l_pjbe.pjbe004 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr004 IS NOT NULL AND l_pjbe.pjbe004 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr004 = 'red'      
#   END IF  
#
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr005 <> l_pjbe.pjbe005) OR
#      (g_pjbq2_d[l_ac].pjbr005 IS NULL AND l_pjbe.pjbe005 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr005 IS NOT NULL AND l_pjbe.pjbe005 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr005 = 'red'      
#   END IF  
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr006 <> l_pjbe.pjbe006) OR
#      (g_pjbq2_d[l_ac].pjbr006 IS NULL AND l_pjbe.pjbe006 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr006 IS NOT NULL AND l_pjbe.pjbe006 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr006 = 'red'       
#   END IF    
#   
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr007 <> l_pjbe.pjbe007) OR
#      (g_pjbq2_d[l_ac].pjbr007 IS NULL AND l_pjbe.pjbe007 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr007 IS NOT NULL AND l_pjbe.pjbe007 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr007 = 'red'      
#   END IF 
#
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr008 <> l_pjbe.pjbe008) OR
#      (g_pjbq2_d[l_ac].pjbr008 IS NULL AND l_pjbe.pjbe008 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr008 IS NOT NULL AND l_pjbe.pjbe008 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr008 = 'red'     
#   END IF   
#   
#   IF p_pjbr901 = '3' OR (p_pjbr901 = '2' AND
#      ((g_pjbq2_d[l_ac].pjbr009 <> l_pjbe.pjbe009) OR
#      (g_pjbq2_d[l_ac].pjbr009 IS NULL AND l_pjbe.pjbe009 IS NOT NULL) OR
#      (g_pjbq2_d[l_ac].pjbr009 IS NOT NULL AND l_pjbe.pjbe009 IS NULL))) THEN
#      
#      LET g_pjbq2_d_color[l_ac].pjbr009 = 'red'      
#   END IF  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbs_set_color(p_pjbs901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbs_set_color(p_pjbs901)
DEFINE   p_pjbs901    LIKE pjbs_t.pjbs901
#DEFINE   l_pjbf       RECORD LIKE pjbf_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbf RECORD  #專案WBS裝置預算檔
       pjbfent LIKE pjbf_t.pjbfent, #企业编号
       pjbf001 LIKE pjbf_t.pjbf001, #项目编号
       pjbf002 LIKE pjbf_t.pjbf002, #本阶WBS
       pjbf003 LIKE pjbf_t.pjbf003, #限定机器
       pjbf004 LIKE pjbf_t.pjbf004, #耗用单位
       pjbf005 LIKE pjbf_t.pjbf005, #耗用数量
       pjbf006 LIKE pjbf_t.pjbf006, #单位成本率
       pjbf007 LIKE pjbf_t.pjbf007, #金额
       pjbf008 LIKE pjbf_t.pjbf008, #备注
       pjbf009 LIKE pjbf_t.pjbf009, #税种
       pjbf010 LIKE pjbf_t.pjbf010, #税率
       pjbf011 LIKE pjbf_t.pjbf011, #原币含税金额
       pjbf012 LIKE pjbf_t.pjbf012, #本币税前金额
       pjbf013 LIKE pjbf_t.pjbf013, #本币含税金额
       pjbf014 LIKE pjbf_t.pjbf014 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   l_pjbu005     LIKE pjbu_t.pjbu005

   INITIALIZE g_pjbq3_d_color[l_ac].* TO NULL
   DECLARE sel_pjbs_cs CURSOR FOR
    SELECT pjbu005 FROM pjbu_t
     WHERE pjbuent = g_enterprise
       AND pjbu001 = g_pjbn_m.pjbn001
       AND pjbu002 = g_pjbo_m.pjbo002
       AND pjbu003 = g_pjbq3_d[l_ac].pjbs003
       AND pjbu004 = g_pjbn_m.pjbn900  
      
    FOREACH sel_pjbs_cs INTO l_pjbu005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 

      LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjbf','pjbs')
      
      CASE l_pjbu005 
         WHEN "pjbs003"   
              
            LET g_pjbq3_d_color[l_ac].pjbs003 = 'red' 
            LET g_pjbq3_d_color[l_ac].pjbs003_desc = 'red'       


         WHEN "pjbs004" 
      
             LET g_pjbq3_d_color[l_ac].pjbs004 = 'red'   
             LET g_pjbq3_d_color[l_ac].pjbs004_desc = 'red'    
      

   
         WHEN "pjbs005" 
      
            LET g_pjbq3_d_color[l_ac].pjbs005 = 'red'   


         WHEN "pjbs006" 
      
            LET g_pjbq3_d_color[l_ac].pjbs006 = 'red'    


   
         WHEN "pjbs007" 
      
            LET g_pjbq3_d_color[l_ac].pjbs007 = 'red'    

   
         WHEN "pjbs008" 
      
            LET g_pjbq3_d_color[l_ac].pjbs008 = 'red'    
      END CASE
   END FOREACH
#   IF p_pjbs901 = '2' THEN   #變更
#      SELECT  UNIQUE pjbf003,pjbf004,pjbf005,pjbf006,pjbf007,pjbf008 
#                INTO l_pjbf.pjbf003,l_pjbf.pjbf004,l_pjbf.pjbf005,l_pjbf.pjbf006,l_pjbf.pjbf007,l_pjbf.pjbf008
#                FROM pjbf_t
#          WHERE pjbfent = g_enterprise
#            AND pjbf001 = g_pjbn_m.pjbn001
#            AND pjbf002 = g_pjbo_m.pjbo002
#            AND pjbf003 = g_pjbq3_d[l_ac].pjbs003 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'sel pjbf_t'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF              
#   END IF

#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs003 <> l_pjbf.pjbf003) OR
#      (g_pjbq3_d[l_ac].pjbs003 IS NULL AND l_pjbf.pjbf003 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs003 IS NOT NULL AND l_pjbf.pjbf003 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs003 = 'red' 
#      LET g_pjbq3_d_color[l_ac].pjbs003_desc = 'red'       
#   END IF 
#
#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs004 <> l_pjbf.pjbf004) OR
#      (g_pjbq3_d[l_ac].pjbs004 IS NULL AND l_pjbf.pjbf004 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs004 IS NOT NULL AND l_pjbf.pjbf004 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs004 = 'red'   
#      LET g_pjbq3_d_color[l_ac].pjbs004_desc = 'red'    
#      
#   END IF 
#   
#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs005 <> l_pjbf.pjbf005) OR
#      (g_pjbq3_d[l_ac].pjbs005 IS NULL AND l_pjbf.pjbf005 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs005 IS NOT NULL AND l_pjbf.pjbf005 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs005 = 'red'   
#   END IF 
#
#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs006 <> l_pjbf.pjbf006) OR
#      (g_pjbq3_d[l_ac].pjbs006 IS NULL AND l_pjbf.pjbf006 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs006 IS NOT NULL AND l_pjbf.pjbf006 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs006 = 'red'    
#   END IF 
#
#   
#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs007 <> l_pjbf.pjbf007) OR
#      (g_pjbq3_d[l_ac].pjbs007 IS NULL AND l_pjbf.pjbf007 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs007 IS NOT NULL AND l_pjbf.pjbf007 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs007 = 'red'    
#   END IF
#   
#   IF p_pjbs901 = '3' OR (p_pjbs901 = '2' AND
#      ((g_pjbq3_d[l_ac].pjbs008 <> l_pjbf.pjbf008) OR
#      (g_pjbq3_d[l_ac].pjbs008 IS NULL AND l_pjbf.pjbf008 IS NOT NULL) OR
#      (g_pjbq3_d[l_ac].pjbs008 IS NOT NULL AND l_pjbf.pjbf008 IS NULL))) THEN
#      
#      LET g_pjbq3_d_color[l_ac].pjbs008 = 'red'    
#   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbt_set_color(p_pjbt901)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbt_set_color(p_pjbt901)
DEFINE   p_pjbt901      LIKE pjbt_t.pjbt901
#DEFINE   l_pjbg       RECORD LIKE pjbg_t.*  #161124-00048#14  2016/12/15 By 08734 mark
#161124-00048#14  2016/12/15 By 08734 add(S)
DEFINE l_pjbg RECORD  #專案WBS費用預算檔
       pjbgent LIKE pjbg_t.pjbgent, #企业编号
       pjbg001 LIKE pjbg_t.pjbg001, #项目编号
       pjbg002 LIKE pjbg_t.pjbg002, #本阶WBS
       pjbg003 LIKE pjbg_t.pjbg003, #费用类型
       pjbg004 LIKE pjbg_t.pjbg004, #金额
       pjbg005 LIKE pjbg_t.pjbg005, #备注
       pjbg006 LIKE pjbg_t.pjbg006, #税种
       pjbg007 LIKE pjbg_t.pjbg007, #税率
       pjbg008 LIKE pjbg_t.pjbg008, #原币规划含税金额
       pjbg009 LIKE pjbg_t.pjbg009, #本币规划税前金额
       pjbg010 LIKE pjbg_t.pjbg010, #本币规划含税金额
       pjbg011 LIKE pjbg_t.pjbg011 #成本要素
END RECORD
#161124-00048#14  2016/12/15 By 08734 add(E)
DEFINE   l_pjbu005     LIKE pjbu_t.pjbu005

   INITIALIZE g_pjbq4_d_color[l_ac].* TO NULL
   DECLARE sel_pjbt_cs CURSOR FOR
    SELECT pjbu005 FROM pjbu_t
     WHERE pjbuent = g_enterprise
       AND pjbu001 = g_pjbn_m.pjbn001
       AND pjbu002 = g_pjbo_m.pjbo002
       AND pjbu003 = g_pjbq4_d[l_ac].pjbt003 
       AND pjbu004 = g_pjbn_m.pjbn900  
      
    FOREACH sel_pjbt_cs INTO l_pjbu005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 

      LET l_pjbu005 = cl_replace_str(l_pjbu005,'pjbg','pjbt')

      CASE l_pjbu005 
         WHEN "pjbt003" 
      
            LET g_pjbq4_d_color[l_ac].pjbt003 = 'red'  
            LET g_pjbq4_d_color[l_ac].pjbt003_desc = 'red'  
            
         WHEN "pjbt004" 
      
            LET g_pjbq4_d_color[l_ac].pjbt004 = 'red'   
      
         WHEN "pjbt005" 
            LET g_pjbq4_d_color[l_ac].pjbt005 = 'red'        
      END CASE
   END FOREACH   
   #   IF p_pjbt901 = '2' THEN   #變更
#      SELECT  UNIQUE pjbg003,pjbg004,pjbg005
#                INTO l_pjbg.pjbg003,l_pjbg.pjbg004,l_pjbg.pjbg005
#                FROM pjbg_t
#          WHERE pjbgent = g_enterprise
#            AND pjbg001 = g_pjbn_m.pjbn001
#            AND pjbg002 = g_pjbo_m.pjbo002
#            AND pjbg003 = g_pjbq4_d[l_ac].pjbt003 
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = 'sel pjbg_t'
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#      END IF              
#   END IF

#   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
#      ((g_pjbq4_d[l_ac].pjbt003 <> l_pjbg.pjbg003) OR
#      (g_pjbq4_d[l_ac].pjbt003 IS NULL AND l_pjbg.pjbg003 IS NOT NULL) OR
#      (g_pjbq4_d[l_ac].pjbt003 IS NOT NULL AND l_pjbg.pjbg003 IS NULL))) THEN
#      
#      LET g_pjbq4_d_color[l_ac].pjbt003 = 'red'  
#      LET g_pjbq4_d_color[l_ac].pjbt003_desc = 'red'  
#      
#   END IF 
#
#   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
#      ((g_pjbq4_d[l_ac].pjbt004 <> l_pjbg.pjbg004) OR
#      (g_pjbq4_d[l_ac].pjbt004 IS NULL AND l_pjbg.pjbg004 IS NOT NULL) OR
#      (g_pjbq4_d[l_ac].pjbt004 IS NOT NULL AND l_pjbg.pjbg004 IS NULL))) THEN
#      
#      LET g_pjbq4_d_color[l_ac].pjbt004 = 'red'         
#   END IF 
#   
#   IF p_pjbt901 = '3' OR (p_pjbt901 = '2' AND
#      ((g_pjbq4_d[l_ac].pjbt005 <> l_pjbg.pjbg005) OR
#      (g_pjbq4_d[l_ac].pjbt005 IS NULL AND l_pjbg.pjbg005 IS NOT NULL) OR
#      (g_pjbq4_d[l_ac].pjbt005 IS NOT NULL AND l_pjbg.pjbg005 IS NULL))) THEN
#      
#      LET g_pjbq4_d_color[l_ac].pjbt005 = 'red'        
#   END IF  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL apjm300_pjbo004_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_pjbo004_chk()
DEFINE l_oocq009       LIKE oocq_t.oocq009
DEFINE l_oocq009_1     LIKE oocq_t.oocq009
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   SELECT DISTINCT oocq009 INTO l_oocq009 FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '8001'
      AND oocq002 = g_pjbo_m.pjbo004
      
   SELECT DISTINCT oocq009 INTO l_oocq009_1 FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '8001'
      AND oocq002 = (SELECT pjbo004 FROM pjbo_t WHERE pjboent = g_enterprise 
                                                  AND pjbo001 = g_pjbo_m.pjbo001 
                                                  AND pjbo002 = g_pjbo_m.pjbo003
                                                  AND pjbo900 = g_pjbn_m.pjbn900) 
                                                  
   IF (l_oocq009 <= l_oocq009_1) OR cl_null(l_oocq009) OR cl_null(l_oocq009_1) THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apj-00048'
      LET g_errparam.extend = g_pjbo_m.pjbo004
      LET g_errparam.popup = TRUE
      CALL cl_err()      
   END IF
   
   RETURN r_success   
   
END FUNCTION

################################################################################
# Date & Author..: 2016/08/22 By 08734
# Modify.........:
################################################################################
PRIVATE FUNCTION apjm300_action_chk()
#add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#25 add-S
   SELECT pjbnstus  INTO g_pjbn_m.pjbnstus
     FROM pjbn_t
    WHERE pjbnent = g_enterprise
      AND pjbn001 = g_pjbn_m.pjbn001

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_pjbn_m.pjbnstus
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
        LET g_errparam.extend = g_pjbn_m.pjbn001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL apjm300_set_act_visible()
        CALL apjm300_set_act_no_visible()
        CALL apjm300_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#25 add-E
   #end add-point
      
   RETURN TRUE
END FUNCTION

#end add-point
 
{</section>}
 
