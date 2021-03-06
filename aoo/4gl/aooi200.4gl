#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0039(2016-09-27 14:10:36), PR版次:0039(2017-01-04 17:32:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000892
#+ Filename...: aooi200
#+ Description: 單據別維護作業
#+ Creator....: 01996(2013-07-01 00:00:00)
#+ Modifier...: 02294 -SD/PR- 02295
 
{</section>}
 
{<section id="aooi200.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160225-00012#1   2016/03/02 By xanghui   变更控制组类型时检查控制组编号是否存在
#160313-00001#1   2016/03/18 By Ann_Huang 於預設欄位頁籤輸入欄位編號後須檢查若已建立過則不可重複建立
#160318-00005#30  2016/03/24 By 07900     重复错误信息修改
#160318-00025#30  2016/04/08 by 07959     將重複內容的錯誤訊息置換為公用錯誤訊息
#160419-00010#1   2016/04/20 By catmoon   檢核ooba001是否存在時，呼叫ap_chk_notDup填入的sql未考慮site條件
#160816-00001#6   2016/08/17 By 08742     抓取理由碼改CALL sub
#160818-00026#1   2016/08/19 By Sarah     1.操作整單操作的"整批產生單別"無法產生單身
#                                         2.修正第一個整批產生單身的BUG讓它可以產生單身後,但畫面沒有重新顯示,得使用者自己重新查詢才能查到資料
#160816-00033#1   2016/08/23 By xianghui  默认字段页签中设定默认值开窗选择资料后没有带出说明栏位
#160905-00007#8   2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160727-00025#1   2016/09/06 By lixiang   模具工单asft304对应单别参数下相关参数值的预设
#160919-00048#1   2016/09/19 By dorislai  修正下方單身異動時，上方的異動人員、異動時間無更新的問題
#160830-00007#2   2016/09/21 By 02295     aooi200中要將單別從無效改成有效時,判斷aooi199中是否為有效單別,若是無效的單別,則提示"此為無效單據別,不可啟用",不允許改為有效
#160914-00032#3   2016/09/27 By lixiang   (1)控制組、生命週期、庫存標籤都加上正、負向表列，s_control的處理段也要加上判斷正、負向表列的處理。
#                                         (2)控制組可開窗多選
#160804-00006#1   2016/11/04 By 02295     應用參數的參數值說明，在資料查出來不會立即顯示，必須先點到下一筆參數，再點回來才看的到
#161108-00012#2   2016/11/09 By 08734     g_browser_cnt 由num5改為num10
#161122-00032#1   2016/11/22 By 02295     整批产生点确定没有走产生发function
#161124-00048#7   2016/12/13 By 08734     星号整批调整
#161214-00032#2   2016/12/15 By 07900     石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#170104-00002#1   2017/01/04 By 02295     在填充单别单身时增加其他页签所下的条件
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
 type type_g_ooba_m        RECORD
       ooba001 LIKE ooba_t.ooba001, 
   ooba001_desc LIKE type_t.chr80,
   ooba008 LIKE ooba_t.ooba008,
   ooba009 LIKE ooba_t.ooba009,
   ooba010 LIKE ooba_t.ooba010,
   ooba011 LIKE ooba_t.ooba011,
   ooba012 LIKE ooba_t.ooba012,
   ooba013 LIKE ooba_t.ooba013,
   ooba014 LIKE ooba_t.ooba014,
   ooba015 LIKE ooba_t.ooba015,
   #160914-00032#3---s
   ooba017 LIKE ooba_t.ooba017,
   ooba018 LIKE ooba_t.ooba018,
   ooba019 LIKE ooba_t.ooba019,
   ooba020 LIKE ooba_t.ooba020
   #160914-00032#3---e
       END RECORD
 
#單身 type 宣告
 TYPE type_g_ooba_d        RECORD
       oobastus LIKE ooba_t.oobastus, 
   ooba002 LIKE ooba_t.ooba002, 
   ooba002_desc LIKE type_t.chr500, 
   oobx002 LIKE oobx_t.oobx002, 
   oobx002_desc LIKE type_t.chr500, 
   oobx003 LIKE oobx_t.oobx003, 
   oobx004 LIKE oobx_t.oobx004, 
   oobx004_desc LIKE type_t.chr500, 
   oobx005 LIKE oobx_t.oobx005, 
   oobx006 LIKE oobx_t.oobx006,
   oobx007 LIKE oobx_t.oobx007, 
   oobx008 LIKE oobx_t.oobx008
  ,ooba016 LIKE ooba_t.ooba016  #151020-00016 by whitney add
       END RECORD
       
 TYPE type_g_ooba2_d RECORD
   ooba002 LIKE ooba_t.ooba002,
   oobaownid LIKE ooba_t.oobaownid, 
   oobaownid_desc LIKE type_t.chr500, 
   oobaowndp LIKE ooba_t.oobaowndp, 
   oobaowndp_desc LIKE type_t.chr500, 
   oobacrtid LIKE ooba_t.oobacrtid, 
   oobacrtid_desc LIKE type_t.chr500, 
   oobacrtdp LIKE ooba_t.oobacrtdp, 
   oobacrtdp_desc LIKE type_t.chr500, 
   oobacrtdt DATETIME YEAR TO SECOND, 
   oobamodid LIKE ooba_t.oobamodid, 
   oobamodid_desc LIKE type_t.chr500, 
   oobamoddt DATETIME YEAR TO SECOND 
       END RECORD
       
#模組變數(Module Variables)
DEFINE g_ooba_m          type_g_ooba_m
DEFINE g_ooba_m_t        type_g_ooba_m
 
DEFINE g_ooba001_t LIKE ooba_t.ooba001
 
 
DEFINE g_ooba_d    DYNAMIC ARRAY OF type_g_ooba_d
DEFINE g_ooba_d_t  type_g_ooba_d
DEFINE g_ooba2_d   DYNAMIC ARRAY OF type_g_ooba2_d
DEFINE g_ooba2_d_t type_g_ooba2_d

#單身 type 宣告
 TYPE type_g_oobb_d        RECORD
   oobb003      LIKE oobb_t.oobb003,
   oobb004      LIKE oobb_t.oobb004,
   oobb004_desc LIKE type_t.chr80,
   oobb005      LIKE oobb_t.oobb005,
   oobb006      LIKE oobb_t.oobb006,
   oobb007      LIKE oobb_t.oobb007,
   oobb008      LIKE oobb_t.oobb008
       END RECORD

 TYPE type_g_oobb2_d RECORD
   oobc004      LIKE oobc_t.oobc004,
   oobc003      LIKE oobc_t.oobc003,
   oobc003_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb3_d RECORD
   oobd003      LIKE oobd_t.oobd003,
   oobd004      LIKE oobd_t.oobd004,
   oobd004_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb4_d RECORD
   oobh003      LIKE oobh_t.oobh003,
   oobh003_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb5_d RECORD
   oobj003      LIKE oobj_t.oobj003,
   oobj003_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb6_d RECORD
   oobk003      LIKE oobk_t.oobk003,
   oobk003_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb7_d RECORD
   oobi003      LIKE oobi_t.oobi003,
   oobi003_desc LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb8_d RECORD
   ooac003  LIKE ooac_t.ooac003,
   gzszl004 LIKE type_t.chr80,
   ooac004  LIKE ooac_t.ooac004,   
   gzsz009  LIKE type_t.chr80,
   gzsz008  LIKE type_t.chr80
       END RECORD

 TYPE type_g_oobb9_d RECORD
   gzcb002  LIKE type_t.chr80,
   gzcbl004 LIKE type_t.chr80
       END RECORD

DEFINE g_oobb_d    DYNAMIC ARRAY OF type_g_oobb_d
DEFINE g_oobb_d_t  type_g_oobb_d
DEFINE g_oobb_d_o  type_g_oobb_d
DEFINE g_oobb2_d   DYNAMIC ARRAY OF type_g_oobb2_d
DEFINE g_oobb2_d_t type_g_oobb2_d

DEFINE g_oobb3_d   DYNAMIC ARRAY OF type_g_oobb3_d
DEFINE g_oobb3_d_t type_g_oobb3_d

DEFINE g_oobb4_d   DYNAMIC ARRAY OF type_g_oobb4_d
DEFINE g_oobb4_d_t type_g_oobb4_d

DEFINE g_oobb5_d   DYNAMIC ARRAY OF type_g_oobb5_d
DEFINE g_oobb5_d_t type_g_oobb5_d

DEFINE g_oobb6_d   DYNAMIC ARRAY OF type_g_oobb6_d
DEFINE g_oobb6_d_t type_g_oobb6_d

DEFINE g_oobb7_d   DYNAMIC ARRAY OF type_g_oobb7_d
DEFINE g_oobb7_d_t type_g_oobb7_d

DEFINE g_oobb8_d   DYNAMIC ARRAY OF type_g_oobb8_d
DEFINE g_oobb8_d_t type_g_oobb8_d

DEFINE g_oobb9_d   DYNAMIC ARRAY OF type_g_oobb9_d
DEFINE g_oobb9_d_t type_g_oobb9_d



DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位

            b_ooba001 LIKE ooba_t.ooba001,
   b_ooba001_desc LIKE type_t.chr80
      END RECORD

DEFINE g_browser_f  RECORD    #資料瀏覽之欄位
            b_ooba001 LIKE ooba_t.ooba001,
   b_ooba001_desc LIKE type_t.chr80
      END RECORD

DEFINE g_master_multi_table_t    RECORD
      oobal001 LIKE oobal_t.oobal001,
      oobal002 LIKE oobal_t.oobal002,
      oobal004 LIKE oobal_t.oobal004
      END RECORD
#無單身append欄位定義

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING

DEFINE g_wc2_table3   STRING

DEFINE g_wc2_table4   STRING

DEFINE g_wc2_table5   STRING

DEFINE g_wc2_table6   STRING

DEFINE g_wc2_table7   STRING

DEFINE g_wc2_table8   STRING

DEFINE g_wc2_table9   STRING

DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_rec_b2               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE l_ac                  LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#2 num5==》num10

#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#2  2016/11/09 By 08734 add
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#2 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#2 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#2 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#2 num5==》num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_frozen           STRING                        #凍結欄位使用

DEFINE g_ecom    RECORD
      ecom001 LIKE type_t.num5,
      ecom002 LIKE type_t.chr1,
      ecom003 LIKE type_t.num5,
      ecom004 LIKE type_t.chr1,
      ecom005 LIKE type_t.num5,
      ecom008 LIKE type_t.chr1      
      END RECORD

#單身 type 宣告
 TYPE type_g_oobx_d        RECORD
   check LIKE type_t.chr1, 
   oobx001 LIKE oobx_t.oobx002, 
   oobx001_desc LIKE type_t.chr500, 
   oobx002 LIKE oobx_t.oobx002, 
   oobx002_desc LIKE type_t.chr500, 
   oobx003 LIKE oobx_t.oobx003, 
   oobx004 LIKE oobx_t.oobx004, 
   oobx004_desc LIKE type_t.chr500, 
   oobx005 LIKE oobx_t.oobx005, 
   oobx006 LIKE oobx_t.oobx006,
   oobx007 LIKE oobx_t.oobx007, 
   oobx008 LIKE oobx_t.oobx008
       END RECORD
DEFINE g_oobx_d          DYNAMIC ARRAY OF type_g_oobx_d
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_s01_wc          STRING
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過  #160919-00048#1-add
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc3          STRING                 #xj
#20151103 by stellar modify 151103-00012#1 ----- (S)
#stellar modify:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#DEFINE g_ooba001      LIKE ooba_t.ooba001    #add by lixh 20150703 150702-00006#7 
DEFINE g_ooba001      LIKE type_t.chr1000
#20151103 by stellar modify 151103-00012#1 ----- (E)
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aooi200.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
                     
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aoo","")
 
   #add-point:作業初始化 name="main.init"
                        IF NOT cl_null(g_argv[1]) THEN
      LET g_ooba_m.ooba001 = g_argv[1]
   END IF

   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   LET g_forupd_sql = "SELECT ooba001,'',ooba006,ooba002,ooba007,'','',ooba003,'','',ooba004,ooba005,'',oobastus,oobaownid,'',oobaowndp,'',oobacrtid,'',oobacrtdp,'',oobacrtdt,oobamodid,'',oobamoddt,ooba014,ooba008,ooba010,ooba012,ooba009,ooba011,ooba013,ooba015,ooba017,ooba018,ooba019,ooba020 FROM ooba_t WHERE oobaent= ? AND ooba001=? AND ooba002=? FOR UPDATE"  #160914-00032#3 add ooba017,ooba018,ooba019,ooba020
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aooi200_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
                                          
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi200 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aooi200_init()
 
      #進入選單 Menu (='N')
      CALL aooi200_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aooi200
   END IF
 
   #add-point:作業離開前 name="main.exit"
                     
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aooi200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# ooba001欄位控管
PRIVATE FUNCTION aooi200_ooba001_chk(p_ooba001)
DEFINE l_n   LIKE type_t.num5
DEFINE p_ooba001 LIKE ooba_t.ooba001
DEFINE l_sql     STRING

     
    #IF NOT ap_chk_notDup(p_ooba001,"SELECT COUNT(*) FROM ooba_t WHERE "||"oobaent = '" ||g_enterprise|| "' AND "||"ooba001 = '"||p_ooba001 ||"' ",'std-00004',0) THEN #160419-00010#1 mark
    #160419-00010#1--add--start--
     LET l_sql = " SELECT COUNT(*) FROM (",
                                        " SELECT UNIQUE ooba001 ",
                                        "   FROM ooba_t ",
                                        "   LEFT JOIN oobal_t ON ooba001 = oobal001 AND ooba002 = oobal002 AND oobal003 = '",g_dlang,"' ",
                                        "   WHERE oobaent = '"||g_enterprise||"' ",
                                        "     AND ooba001 = '"||p_ooba001 ||"' ",
                                        "     AND ooba001 IN ('",g_ooba001,"')",
                                        ")"
     IF NOT ap_chk_notDup(p_ooba001,l_sql,'std-00004',0) THEN
    #160419-00010#1--add--end----    
        RETURN FALSE
     END IF

           
     LET l_n = 0
     SELECT COUNT(*) INTO l_n FROM ooal_t
      WHERE ooal001 = '3' AND ooal002 = p_ooba001
        AND ooalent = g_enterprise
     IF l_n = 0 THEN
        IF cl_ask_confirm('aoo-00076') THEN
           CALL s_transaction_begin()
           IF NOT s_aooi070_ins(3,p_ooba001) THEN
              CALL s_transaction_end('N','0')
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'sub-01324'  #aoo-00170  #160318-00005#30  By 07900 --mod
              LET g_errparam.extend = g_ooba_m.ooba001
              #160318-00005#30  By 07900 --add-str
              LET g_errparam.replace[1] ='aooi073'
              LET g_errparam.replace[2] = cl_get_progname("aooi073",g_lang,"2")
              LET g_errparam.exeprog ='aooi073'
              #160318-00005#30  By 07900 --add-end
              LET g_errparam.popup = TRUE
              CALL cl_err()

              RETURN FALSE
           ELSE
              CALL s_transaction_end('Y','0')
           END IF
        ELSE
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'sub-01324'  #aoo-00170  #160318-00005#30  By 07900 --mod
           LET g_errparam.extend = p_ooba001
           #160318-00005#30  By 07900 --add-str
           LET g_errparam.replace[1] ='aooi073'
           LET g_errparam.replace[2] = cl_get_progname("aooi073",g_lang,"2")
           LET g_errparam.exeprog ='aooi073'
           #160318-00005#30  By 07900 --add-end
           LET g_errparam.popup = TRUE
           CALL cl_err()

           RETURN FALSE
        END IF
     END IF
     
     LET l_n = 0
     SELECT COUNT(*) INTO l_n FROM ooal_t
      WHERE ooal001 = '3' AND ooal002 = p_ooba001
        AND ooalent = g_enterprise AND ooalstus = 'Y'
     IF l_n = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'sub-01302'  #aoo-00171  #160318-00005#30  By 07900 --mod
        LET g_errparam.extend = p_ooba001
        #160318-00005#30  By 07900 --add-str
        LET g_errparam.replace[1] ='aooi073'
        LET g_errparam.replace[2] = cl_get_progname("aooi073",g_lang,"2")
        LET g_errparam.exeprog ='aooi073'
        #160318-00005#30  By 07900 --add-end
        LET g_errparam.popup = TRUE
        CALL cl_err()

        RETURN FALSE
     END IF
     
     #20151103 by stellar modify 151103-00012#1 ----- (S)
     #stellar modify:控卡只能輸入除了aooi100的單據別參照表外，還有agli010的單據別參照表
     LET l_n = 0
#     SELECT COUNT(*) INTO l_n
#       FROM (SELECT ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site),
#            (SELECT glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp= g_site)
#      WHERE (ooef004 = p_ooba001 OR glaa024 = p_ooba001)
     LET l_sql = "SELECT COUNT(*) ",
                 "  FROM (SELECT ooef004 ooef004 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"'",
                 "         UNION ",
                 "        SELECT glaa024 ooef004 FROM glaa_t WHERE glaaent = ",g_enterprise," AND glaacomp= '",g_site,"')",
                 " WHERE ooef004 = '",p_ooba001,"'"
     PREPARE aooi200_ooba001_chk_pre FROM l_sql
     EXECUTE aooi200_ooba001_chk_pre INTO l_n
     IF cl_null(l_n) OR l_n = 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'aoo-00660'
        LET g_errparam.extend = p_ooba001
        LET g_errparam.popup = TRUE
        
        CALL cl_err()
        RETURN FALSE
     END IF
     #20151103 by stellar modify 151103-00012#1 ----- (E)
     
     RETURN TRUE
END FUNCTION
# oobh003欄位控管
PRIVATE FUNCTION aooi200_oobh003_chk()
DEFINE l_n   LIKE  type_t.num5
   IF NOT ap_chk_notDup(g_oobb4_d[l_ac].oobh003 ,"SELECT COUNT(*) FROM oobh_t WHERE "||"oobhent = '" ||g_enterprise|| "' AND "||"oobh001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobh002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobh003 = '"||g_oobb4_d[l_ac].oobh003 ||"'",'std-00004',0) THEN 
       RETURN FALSE
   END IF

   INITIALIZE g_chkparam.* TO NULL
   LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
   LET g_chkparam.arg1 = g_oobb4_d[l_ac].oobh003
   LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"#要執行的建議程式待補 #160318-00025#30  add
   IF NOT cl_chk_exist("v_rtax001") THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aooi200_s01_create_tmp()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF

   DROP TABLE aooi200_s01_tmp;
   CREATE TEMP TABLE aooi200_s01_tmp(
     l_check varchar(1), 
   oobx001 varchar(5), 
   oobx001_desc varchar(500), 
   oobx002 varchar(3), 
   oobx002_desc varchar(500), 
   oobx003 varchar(10), 
   oobx004 varchar(20), 
   oobx004_desc varchar(500), 
   oobx005 varchar(1), 
   oobx006 varchar(1),
   oobx007 decimal(5,0), 
   oobx008 varchar(20)
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# oobc003欄位控管
PRIVATE FUNCTION aooi200_oobc003_chk()
DEFINE l_n LIKE type_t.num5
   IF NOT ap_chk_notDup(g_oobb2_d[l_ac].oobc003,"SELECT COUNT(*) FROM oobc_t WHERE "||"oobcent = '" ||g_enterprise|| "' AND "||"oobc001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobc002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobc003 = '"||g_oobb2_d[l_ac].oobc003 ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   IF g_oobb2_d[l_ac].oobc004 = '8' THEN 
      INITIALIZE g_chkparam.* TO NULL
      LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
      LET g_chkparam.arg1 = g_oobb2_d[l_ac].oobc003
      LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"#要執行的建議程式待補 #160318-00025#30  add
      IF NOT cl_chk_exist("v_ooag001") THEN
         RETURN FALSE
      END IF            
   ELSE 
      IF g_oobb2_d[l_ac].oobc004 = '7' THEN 
         INITIALIZE g_chkparam.* TO NULL
         LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
         LET g_chkparam.arg1 = g_oobb2_d[l_ac].oobc003
         LET g_chkparam.arg2 = g_today
         LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"#要執行的建議程式待補 #160318-00025#30  add
         IF NOT cl_chk_exist("v_ooeg001") THEN
            RETURN FALSE
         END IF
      ELSE
         INITIALIZE g_chkparam.* TO NULL
         LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
         LET g_chkparam.arg1 = g_oobb2_d[l_ac].oobc003
         LET g_chkparam.arg2 = g_oobb2_d[l_ac].oobc004
         LET g_chkparam.err_str[1] = "asr-00032:sub-01302|aooi380|",cl_get_progname("aooi380",g_lang,"2"),"|:EXEPROGaooi380"#要執行的建議程式待補 #160318-00025#30  add
         IF NOT cl_chk_exist("v_ooha001_5") THEN
            RETURN FALSE
         END IF              
      END IF
   END IF   

  
   RETURN TRUE
END FUNCTION
# oobb003欄位控管
PRIVATE FUNCTION aooi200_oobb004_chk()
DEFINE l_n  LIKE type_t.num5
   INITIALIZE g_chkparam.* TO NULL
               
   LET g_chkparam.arg1 = g_oobb_d[l_ac].oobb004
   LET g_chkparam.arg2 = g_ooba_d[g_detail_idx2].ooba002
   IF NOT cl_chk_exist("v_dzeb001_2") THEN
      RETURN FALSE
   END IF
   
   
#   LET l_n = 0 
#   SELECT COUNT(*) INTO l_n FROM dzeb_t
#    WHERE dzeb002 = g_oobb_d[l_ac].oobb004
#      AND dzebstus= 'Y'
#   IF l_n = 0 THEN
#      CALL cl_err(g_oobb_d[l_ac].oobb004,'aoo-00133',1)
#      RETURN FALSE
#   END IF
   
   RETURN TRUE
END FUNCTION
# oobi003欄位控管
PRIVATE FUNCTION aooi200_oobi003_chk()
DEFINE l_n   LIKE  type_t.num5
DEFINE l_acc LIKE  gzcb_t.gzcb004
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobi_t WHERE "||"oobient = '" ||g_enterprise|| "' AND "||"oobi001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobi002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobi003 = '"||g_oobb7_d[l_ac].oobi003 ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   
   #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003  #160816-00001#6 mark
   LET l_acc = s_fin_get_scc_value('24',g_ooba_d[g_detail_idx2].oobx003,'2')  #160816-00001#6  Add
   
   
   IF NOT s_azzi650_chk_exist(l_acc,g_oobb7_d[l_ac].oobi003) THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION
#+ 抓出oobl_t中該單據有幾筆
PRIVATE FUNCTION aooi200_oobl_count()
DEFINE r_n   LIKE type_t.num5
   LET r_n = 0
   SELECT COUNT(*) INTO r_n FROM oobl_t WHERE ooblent = g_enterprise 
      AND oobl001 = g_ooba_m.ooba001 AND oobl002 = g_ooba_d[g_detail_idx2].ooba002
   RETURN r_n
END FUNCTION
# oobj003欄位控管
PRIVATE FUNCTION aooi200_oobj003_chk()
DEFINE l_n   LIKE  type_t.num5
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobj_t WHERE "||"oobjent = '" ||g_enterprise|| "' AND "||"oobj001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobj002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobj003 = '"||g_oobb5_d[l_ac].oobj003 ||"'",'std-00004',0) THEN 
      RETURN FALSE 
   END IF

   IF NOT s_azzi650_chk_exist('220',g_oobb5_d[l_ac].oobj003) THEN
      RETURN FALSE
   END IF
  
   RETURN TRUE
END FUNCTION
# oobk欄位控管
PRIVATE FUNCTION aooi200_oobk003_chk()
DEFINE l_n   LIKE  type_t.num5
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobk_t WHERE "||"oobkent = '" ||g_enterprise|| "' AND "||"oobk001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobk002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobk003 = '"||g_oobb6_d[l_ac].oobk003 ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   
   IF NOT s_azzi650_chk_exist('220',g_oobb6_d[l_ac].oobk003) THEN
      RETURN FALSE
   END IF
   
  
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aooi200_init()
   #add-point:init段define
   DEFINE l_glaa024      LIKE glaa_t.glaa024   #20151103 by stellar add 151103-00012#1
   #end add-point

   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET g_error_show = 1
      CALL cl_set_combo_scc_part('oobastus','17','N,Y')



   #add-point:畫面資料初始化
   CALL cl_set_combo_scc("oobx003",'24')
   CALL cl_set_combo_scc("b_oobx003",'24')
   CALL cl_set_combo_scc("oobx006",'14')
   CALL cl_set_combo_scc("b_oobx006",'14')
   CALL cl_set_combo_scc("oobd003",'29')
   CALL cl_set_combo_scc("ooba014",'37')
   CALL cl_set_combo_scc("ooba015",'37')
   #160914-00032#3---s
   CALL cl_set_combo_scc("ooba017",'37')
   CALL cl_set_combo_scc("ooba018",'37')
   CALL cl_set_combo_scc("ooba019",'37')
   CALL cl_set_combo_scc("ooba020",'37')
   #160914-00032#3---e
   CALL cl_set_combo_scc("oobc004",'26')
   CALL cl_set_act_visible("open_oobl",TRUE)          {#ADP版次:1#}
   CALL cl_set_act_visible("reproduce",FALSE)  #徐晶 add 150923
   #add by lixh 20150703 150702-00006#7
   SELECT ooef004 INTO g_ooba001 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site   
   #20151103 by stellar modify 151103-00012#1 ----- (S)
   #stellar modify:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#   DISPLAY g_ooba001 TO ooba001   
   DECLARE aooi200_sel_glaa024_cs CURSOR FOR
    SELECT DISTINCT(glaa024) 
      FROM glaa_t
     WHERE glaaent = g_enterprise
       AND glaacomp= g_site
   FOREACH aooi200_sel_glaa024_cs INTO l_glaa024
      IF cl_null(g_ooba001) THEN
         LET g_ooba001 = l_glaa024 CLIPPED
      ELSE
         LET g_ooba001 = g_ooba001 CLIPPED,"','",l_glaa024 CLIPPED
      END IF
   END FOREACH
   #20151103 by stellar modify 151103-00012#1 ----- (E)
   #add by lixh 20150703 150702-00006#7   
   #end add-point
   CALL aooi200_ecom_get()
   CALL aooi200_default_search()

END FUNCTION

PRIVATE FUNCTION aooi200_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE  l_gzsz016       LIKE gzsz_t.gzsz016   
   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE l_str   STRING          {#ADP版次:1#}
      DEFINE l_glaa024     LIKE glaa_t.glaa024   #20151103 by stellar add 151103-00012#1
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   CALL cl_set_act_visible("accept,cancel", FALSE)

   CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   CALL gfrm_curr.setElementHidden("mainlayout",1)
   CALL gfrm_curr.setElementHidden("worksheet",0)
   LET g_main_hidden = 1

   #add-point:ui_dialog段before dialog
   
   #end add-point

   WHILE TRUE
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()
         INITIALIZE g_ooba_m.* TO NULL
         CALL g_ooba_d.clear()

         LET g_wc  = ' 1=1'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aooi200_init()
      END IF

      CALL aooi200_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()

      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_ooba001 = g_ooba001_t
               #AND g_browser[li_idx].b_ooba002 = g_ooba002_t


               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #INPUT g_searchstr,g_searchcol FROM formonly.searchstr,formonly.cbo_searchcol
         #
         #   BEFORE INPUT
         #
         #END INPUT

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

               CALL aooi200_fetch('') # reload data
               LET l_ac = 1
               CALL aooi200_ui_detailshow() #Setting the current row

               CALL aooi200_idx_chk()
               #NEXT FIELD oobb003

         END DISPLAY

         DISPLAY ARRAY g_ooba_d TO s_detail10.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               CALL aooi200_idx_chk()
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail10")
               LET l_ac = g_detail_idx2
               #DISPLAY g_detail_idx2 TO FORMONLY.idx
               #LET g_bfill = "Y"
               #CALL aooi200_show()
               #LET g_bfill = "N"
               CALL aooi200_b_fill('0')
               LET g_bfill = "N"
               CALL aooi200_show()
               LET g_bfill = "Y"                              
               #add-point:page1自定義行為
               #自動檢查單據別參數有沒有資料,沒有的就補上
               CALL aooi200_ooac_fill(g_ooba_d[l_ac].ooba002,g_ooba_d[l_ac].oobx003)
               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail10")
               #DISPLAY g_ooba_d.getLength() TO FORMONLY.cnt
               LET g_current_page = 9
               CALL aooi200_idx_chk() 
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_ooba2_d TO s_detail11.* ATTRIBUTES(COUNT=g_rec_b2)  
         
            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail11")
               LET g_detail_idx2 = l_ac
               #DISPLAY g_detail_idx TO FORMONLY.idx
               CALL aooi200_ui_detailshow()
               CALL aooi200_b_fill(g_page)               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail11")               
               LET g_current_page = 10
               CALL aooi200_idx_chk()
                           
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         

         DISPLAY ARRAY g_oobb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

               #add-point:page1, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL aooi200_idx_chk()
               LET g_current_page = 1
             
            #自訂ACTION(detail_show,page_1)


            #add-point:page1自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac

               #add-point:page2, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               CALL aooi200_idx_chk()
               LET g_current_page = 2
             
            #自訂ACTION(detail_show,page_2)


            #add-point:page2自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac

               #add-point:page3, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               CALL aooi200_idx_chk()
               LET g_current_page = 3
              
            #自訂ACTION(detail_show,page_3)


            #add-point:page3自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac

               #add-point:page4, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               CALL aooi200_idx_chk()
               LET g_current_page = 4

            #自訂ACTION(detail_show,page_4)


            #add-point:page4自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac

               #add-point:page5, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               CALL aooi200_idx_chk()
               LET g_current_page = 5

            #自訂ACTION(detail_show,page_5)


            #add-point:page5自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac

               #add-point:page6, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               CALL aooi200_idx_chk()
               LET g_current_page = 6

            #自訂ACTION(detail_show,page_6)


            #add-point:page6自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb7_d TO s_detail7.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_detail_idx = l_ac

               #add-point:page7, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               CALL aooi200_idx_chk()
               LET g_current_page = 7

            #自訂ACTION(detail_show,page_7)


            #add-point:page7自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb8_d TO s_detail8.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               CALL aooi200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               LET g_detail_idx = l_ac
               SELECT gzsz016 INTO l_gzsz016 FROM gzsz_t WHERE gzsz001 = 'ooac_t' AND gzsz002 = g_oobb8_d[l_ac].ooac003

               CALL aooi200_gzcb_fill(l_gzsz016)
  
               #add-point:page8, before row動作
               
               #end add-point

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail8")
               CALL aooi200_idx_chk()
               LET g_current_page = 8

            #自訂ACTION(detail_show,page_8)


            #add-point:page8自定義行為
            
            #end add-point

         END DISPLAY

         DISPLAY ARRAY g_oobb9_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail9")
               LET g_detail_idx = l_ac



            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail9")

            #自訂ACTION(detail_show,page_7)

         END DISPLAY

         #add-point:ui_dialog段自定義display array
         
         #end add-point

         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps

         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE

            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF

            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aooi200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aooi200_ui_detailshow() #Setting the current row

            #筆數顯示
            LET g_current_page = 8
            CALL aooi200_idx_chk()
            CALL cl_set_combo_scc("oobx003",'24')
            #add by lixh 20150703 150702-00006#7
            SELECT ooef004 INTO g_ooba001 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site   
            #20151103 by stellar modify 151103-00012#1 ----- (S)
            #stellar modify:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#            DISPLAY g_ooba001 TO ooba001   
            DECLARE aooi200_sel_glaa024_cs1 CURSOR FOR
             SELECT DISTINCT(glaa024) 
               FROM glaa_t
              WHERE glaaent = g_enterprise
                AND glaacomp= g_site
            FOREACH aooi200_sel_glaa024_cs1 INTO l_glaa024
               IF cl_null(g_ooba001) THEN
                  LET g_ooba001 = l_glaa024 CLIPPED
               ELSE
                  LET g_ooba001 = g_ooba001 CLIPPED,"','",l_glaa024 CLIPPED
               END IF
            END FOREACH
            #20151103 by stellar modify 151103-00012#1 ----- (E)
            #add by lixh 20150703 150702-00006#7                
            #add-point:ui_dialog段before_dialog2

          {#ADP版次:1#}
            #end add-point
            CALL cl_set_combo_scc("oobx003",'24')
            #NEXT FIELD oobb003


         #ACTION表單列
         ON ACTION filter
            CALL aooi200_filter()
            EXIT DIALOG

         ON ACTION first
            CALL aooi200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi200_idx_chk()

         ON ACTION previous
            CALL aooi200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi200_idx_chk()

         ON ACTION jump
            CALL aooi200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi200_idx_chk()

         ON ACTION next
            CALL aooi200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi200_idx_chk()

         ON ACTION last
            CALL aooi200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aooi200_idx_chk()

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
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            CONTINUE DIALOG

         ON ACTION worksheethidden   #瀏覽頁折疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            CONTINUE DIALOG

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
               CALL aooi200_delete()
               #add-point:ON ACTION delete
               
               #END add-point
               EXIT DIALOG
            END IF


         ON ACTION insert

            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aooi200_insert()
               #add-point:ON ACTION insert
               
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION modify

            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aooi200_modify()
               #add-point:ON ACTION modify
               
               #END add-point
                EXIT DIALOG
            END IF
            
         ON ACTION modify_detail

            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aooi200_modify()
               #add-point:ON ACTION modify
               
               #END add-point
                EXIT DIALOG
            END IF

         ON ACTION open_oobl

            LET g_action_choice="open_oobl"
            IF cl_auth_chk_act("open_oobl") THEN
               #add-point:ON ACTION open_oobl
               IF g_detail_idx2 > 0 THEN
                  CALL aooi199_01(g_ooba_d[g_detail_idx2].ooba002,g_ooba_d[g_detail_idx2].oobx003,'0')
               END IF                  
               LET g_action_choice="open_oobl"
               #END add-point
                EXIT DIALOG
            END IF


         ON ACTION output

            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               #add-point:ON ACTION output
               
               #END add-point
                EXIT DIALOG
            END IF

         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
              
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_ooba_d)
                  LET g_export_id[1]   = "s_detail10"
                  LET g_export_node[2] = base.typeInfo.create(g_ooba2_d)
                  LET g_export_id[2]   = "s_detail11"
                  LET g_export_node[3] = base.typeInfo.create(g_oobb_d)
                  LET g_export_id[3]   = "s_detail1"
                  LET g_export_node[4] = base.typeInfo.create(g_oobb2_d)
                  LET g_export_id[4]   = "s_detail2"
                  LET g_export_node[5] = base.typeInfo.create(g_oobb3_d)
                  LET g_export_id[5]   = "s_detail3"
                  LET g_export_node[6] = base.typeInfo.create(g_oobb4_d)
                  LET g_export_id[6]   = "s_detail4"
                  LET g_export_node[7] = base.typeInfo.create(g_oobb5_d)
                  LET g_export_id[7]   = "s_detail5"
                  LET g_export_node[8] = base.typeInfo.create(g_oobb6_d)
                  LET g_export_id[8]   = "s_detail6"
                  LET g_export_node[9] = base.typeInfo.create(g_oobb7_d)
                  LET g_export_id[9]   = "s_detail7"
                  LET g_export_node[10] = base.typeInfo.create(g_oobb8_d)
                  LET g_export_id[10]   = "s_detail8"
                  LET g_export_node[11] = base.typeInfo.create(g_oobb9_d)
                  LET g_export_id[11]   = "s_detail9"
             
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
            
         ON ACTION query

            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aooi200_query()
               #add-point:ON ACTION query
               
               #END add-point
            END IF


#         ON ACTION reproduce
#
#            LET g_action_choice="reproduce"
#            IF cl_auth_chk_act("reproduce") THEN
#               CALL aooi200_reproduce()
#               #add-point:ON ACTION reproduce
#               
#               #END add-point
#                EXIT DIALOG
#            END IF

#160818-00026#1-s mod
#從FUNCTION aooi200_input()搬到aooi200_ui_dialog()裡,改成不需要先進入修改狀態才能整批生成單別
         ON ACTION pro_ooba
            IF aooi200_s01_create_tmp() THEN 
               CALL aooi200_s01()
               CALL aooi200_browser_fill("F")
               CALL aooi200_fetch("F")
            END IF
#160818-00026#1-e mod

         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
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

PRIVATE FUNCTION aooi200_browser_search(p_type)
   {<Local define>}
   DEFINE p_type LIKE type_t.chr10
   {</Local define>}
   #add-point:browser_search段define
   
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
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1 "
   END IF

   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY ooba001"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF

   CALL aooi200_browser_fill("F")
   CALL ui.Interface.refresh()
   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION aooi200_browser_fill(ps_page_action)
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

   #清除畫面
   CLEAR FORM
   INITIALIZE g_ooba_m.* TO NULL
   CALL g_oobb_d.clear()
   CALL g_oobb2_d.clear()

   CALL g_oobb3_d.clear()

   CALL g_oobb4_d.clear()

   CALL g_oobb5_d.clear()

   CALL g_oobb6_d.clear()

   CALL g_oobb7_d.clear()

   CALL g_oobb8_d.clear()
   CALL g_ooba_d.clear()
   CALL g_ooba2_d.clear()
   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "ooba001"
                        #,",ooba002"


   ELSE
      LET l_searchcol = g_searchcol
   END IF
#20151103 by stellar modify 151103-00012#1 ----- (S)
#stellar modify:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#   #add by lixh 20150703 150702-00006#7
#   IF cl_null(g_wc) THEN
#      LET g_wc = " ooba001 = '",g_ooba001,"'"   
#   ELSE
#      LET g_wc = g_wc," AND ooba001 = '",g_ooba001,"'"   
#   END IF
#   #add by lixh 20150703 150702-00006#7
   IF cl_null(g_wc) THEN
      LET g_wc = " ooba001 IN ('",g_ooba001,"')"
   ELSE
      LET g_wc = g_wc," AND ooba001 IN ('",g_ooba001,"')"
   END IF
#20151103 by stellar modify 151103-00012#1 ----- (S)
   LET l_wc  = g_wc.trim()
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   #add-point:browser_fill,foreach前
   
   #end add-point

   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE ooba001 ",
                                   # ",ooba002 ",
                      " FROM ooba_t ",
                      " LEFT JOIN oobx_t ON oobxent = oobxent AND ooba002 = oobx001 ",
                      " LEFT JOIN oobb_t ON oobbent = oobaent AND ooba001 = oobb001 AND ooba002 = oobb002 ",
                      " LEFT JOIN oobc_t ON oobcent = oobaent AND ooba001 = oobc001 AND ooba002 = oobc002",
                      " LEFT JOIN oobd_t ON oobdent = oobaent AND ooba001 = oobd001 AND ooba002 = oobd002",
                      " LEFT JOIN oobh_t ON oobhent = oobaent AND ooba001 = oobh001 AND ooba002 = oobh002",
                      " LEFT JOIN oobj_t ON oobjent = oobaent AND ooba001 = oobj001 AND ooba002 = oobj002",
                      " LEFT JOIN oobk_t ON oobkent = oobaent AND ooba001 = oobk001 AND ooba002 = oobk002",
                      " LEFT JOIN oobi_t ON oobient = oobaent AND ooba001 = oobi001 AND ooba002 = oobi002",
                      " LEFT JOIN ooac_t ON ooacent = oobaent AND ooba001 = ooac001 AND ooba002 = ooac002",
                      " LEFT JOIN gzszl_t ON gzszl001 = 'ooac_t' AND gzszl002 = ooac003 AND gzszl003 = '",g_dlang CLIPPED,"'",
                      " LEFT JOIN oobal_t ON ooba001 = oobal001 AND ooba002 = oobal002 AND oobal003 = '",g_dlang,"' ",
                      " LEFT JOIN ooha_t ON oohaent = oobcent AND ooha001 = oobc003",
                      " WHERE oobaent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2 CLIPPED,cl_sql_add_filter("ooba_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("ooba_t") 

   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE ooba001 ",
                                   # ",ooba002 ",
                      " FROM ooba_t ",
                      " LEFT JOIN oobal_t ON ooba001 = oobal001 AND ooba002 = oobal002 AND oobal003 = '",g_dlang,"' ",
                      " WHERE oobaent = " ||g_enterprise|| " AND ",l_wc CLIPPED,cl_sql_add_filter("ooba_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("ooba_t")
   END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   #add-point:browser_fill,count前
   
   #end add-point

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #LET g_page_action = ps_page_action          # Keep Action

   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF

   CASE ps_page_action
      WHEN "F"
         LET g_pagestart = 1

      WHEN "P"
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF

   END CASE

   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
      #依照ooba001,'' Browser欄位定義(取代原本bs_sql功能)
      LET l_sql_rank = "SELECT DISTINCT ooba001,'',DENSE_RANK() OVER(ORDER BY ooba001 ",g_order,") AS RANK ",
                       " FROM ooba_t ",
                       " LEFT JOIN oobx_t ON oobxent = oobxent AND ooba002 = oobx001 ",
                       " LEFT JOIN oobb_t ON oobbent = oobaent AND ooba001 = oobb001 AND ooba002 = oobb002 ",
                       " LEFT JOIN oobc_t ON oobcent = oobaent AND ooba001 = oobc001 AND ooba002 = oobc002",
                       " LEFT JOIN oobd_t ON oobdent = oobaent AND ooba001 = oobd001 AND ooba002 = oobd002",
                       " LEFT JOIN oobh_t ON oobhent = oobaent AND ooba001 = oobh001 AND ooba002 = oobh002",
                       " LEFT JOIN oobj_t ON oobjent = oobaent AND ooba001 = oobj001 AND ooba002 = oobj002",
                       " LEFT JOIN oobk_t ON oobkent = oobaent AND ooba001 = oobk001 AND ooba002 = oobk002",
                       " LEFT JOIN oobi_t ON oobient = oobaent AND ooba001 = oobi001 AND ooba002 = oobi002",
                       " LEFT JOIN ooac_t ON ooacent = oobaent AND ooba001 = ooac001 AND ooba002 = ooac002",
                       " LEFT JOIN gzszl_t ON gzszl001 = 'ooac_t' AND gzszl002 = ooac003 AND gzszl003 = '",g_dlang CLIPPED,"'",
                       " LEFT JOIN oobal_t ON ooba001 = oobal001 AND ooba002 = oobal002 AND oobal003 = '",g_dlang,"' ",
                       " LEFT JOIN ooha_t ON oohaent = oobcent AND ooha001 = oobc003",
                       " WHERE oobaent = " ||g_enterprise|| " AND ",g_wc," AND ",g_wc2 CLIPPED,cl_sql_add_filter("ooba_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("ooba_t")
   ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT ooba001,'',DENSE_RANK() OVER(ORDER BY ooba001 ",g_order,") AS RANK ",
                       " FROM ooba_t ",
                       " WHERE oobaent = " ||g_enterprise|| " AND ", g_wc CLIPPED,cl_sql_add_filter("ooba_t")  #161214-00032#2 add CLIPPED,cl_sql_add_filter("ooba_t")
   END IF

   #定義翻頁CURSOR
   LET g_sql= "SELECT ooba001,'' FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order

   #add-point:browser_fill,before_prepare
   
   #end add-point

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_ooba001,g_browser[g_cnt].b_ooba001_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF


      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_ooba001
      CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_ooba001_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_ooba001_desc


      #add-point:browser_fill段reference
      
      #end add-point

#            #此段落由子樣板a24產生
#      CASE g_browser[g_cnt].b_statepic
#         WHEN "N"
#            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
#         WHEN "Y"
#            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"


#     END CASE


      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF

   END FOREACH

   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()

   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0

   FREE browse_pre

   #add-point:browser_fill段結束前
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi200_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point

   LET g_ooba_m.ooba001 = g_browser[g_current_idx].b_ooba001

   SELECT UNIQUE ooba001
     INTO g_ooba_m.ooba001
     FROM ooba_t
     WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001
   CALL aooi200_show2()

END FUNCTION

PRIVATE FUNCTION aooi200_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point

   #add-point:ui_detailshow段before
   
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail7",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail8",g_detail_idx)

      CALL g_curr_diag.setCurrentRow("s_detail10",g_detail_idx)
      
   END IF

   #add-point:ui_detailshow段after
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi200_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_ooba001 = g_ooba_m.ooba001
        
         THEN
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR

   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF

   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示

END FUNCTION

PRIVATE FUNCTION aooi200_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   DEFINE l_oobc004   LIKE oobc_t.oobc004
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_ooba_m.* TO NULL
   CALL g_oobb_d.clear()
   CALL g_oobb2_d.clear()

   CALL g_oobb3_d.clear()

   CALL g_oobb4_d.clear()

   CALL g_oobb5_d.clear()

   CALL g_oobb6_d.clear()

   CALL g_oobb7_d.clear()

   CALL g_oobb8_d.clear()
   CALL g_ooba_d.clear()
   CALL g_ooba2_d.clear()


   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL

   INITIALIZE g_wc2_table3 TO NULL

   INITIALIZE g_wc2_table4 TO NULL

   INITIALIZE g_wc2_table5 TO NULL

   INITIALIZE g_wc2_table6 TO NULL

   INITIALIZE g_wc2_table7 TO NULL

   INITIALIZE g_wc2_table8 TO NULL
   INITIALIZE g_wc2_table9 TO NULL


   LET g_qryparam.state = 'c'

   #add-point:cs段開始前
#20151103 by stellar mark 151103-00012#1 ----- (S)
#stellar mark:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#   #add by lixh 20150703 150702-00006#7
#   
#   LET g_ooba_m.ooba001 = g_ooba001
#   
#   CALL aooi200_ooba001_desc(g_ooba_m.ooba001) 
#   
#   DISPLAY BY NAME g_ooba_m.ooba001,g_ooba_m.ooba001_desc   
#   #add by lixh 20150703 150702-00006#7
#20151103 by stellar mark 151103-00012#1 ----- (E)
   #end add-point

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
#20151103 by stellar remark 151103-00012#1 ----- (S)
#stellar remark:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#add by lixh 20150703 150702-00006#7
      CONSTRUCT BY NAME g_wc ON ooba001,ooba008,ooba009,ooba010,ooba012,ooba013,ooba014,ooba015,ooba017,ooba018,ooba019,ooba020  #160914-00032#3 add ooba017,ooba01,ooba019,ooba020
      
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            #add-point:cs段before_construct
            
            #end add-point

         ON ACTION controlp INFIELD ooba001
            #add-point:ON ACTION controlp INFIELD ooba001
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            
            #20151103 by stellar add 151103-00012#1 ----- (S)
            #stellar add:除了aooi100的單據別參照表外，還有agli010的單據別參照表
            LET g_qryparam.where = " ooal002 IN ('",g_ooba001,"')"
            #20151103 by stellar add 151103-00012#1 ----- (E)
            
            CALL q_ooal002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooba001  #顯示到畫面上

            NEXT FIELD ooba001                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD ooba001
            #add-point:BEFORE FIELD ooba001
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooba001

            #add-point:AFTER FIELD ooba001
            
            #END add-point




      END CONSTRUCT
#add by lixh 20150703 150702-00006#7
#20151103 by stellar remark 151103-00012#1 ----- (E)

      CONSTRUCT g_wc2_table9 ON oobastus,ooba002,oobx002,oobx003,oobx004,oobx005,oobx006,oobx007,oobx008,
           ooba016,  #151020-00016 by whitney add
           oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt
           FROM s_detail10[1].oobastus,s_detail10[1].ooba002,
               s_detail10[1].oobx002,s_detail10[1].oobx003,s_detail10[1].oobx004,s_detail10[1].oobx005,s_detail10[1].oobx006,s_detail10[1].oobx007,s_detail10[1].oobx008,        
               s_detail10[1].ooba016,  #151020-00016 by whitney add
               s_detail11[1].oobaownid,s_detail11[1].oobaowndp,s_detail11[1].oobacrtid,s_detail11[1].oobacrtdp, 
               s_detail11[1].oobacrtdt,s_detail11[1].oobamodid,s_detail11[1].oobamoddt
                      
         BEFORE CONSTRUCT
#saki            CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         #此段落由子樣板a11產生
         #----<<oobaownid>>----
         ON ACTION controlp INFIELD oobaownid
            CALL q_common('ooba_t','oobaownid',TRUE,FALSE,g_ooba2_d[1].oobaownid) RETURNING ls_return
            DISPLAY ls_return TO oobaownid
            NEXT FIELD oobaownid  
         
         #----<<oobaowndp>>----
         ON ACTION controlp INFIELD oobaowndp
            CALL q_common('ooba_t','oobaowndp',TRUE,FALSE,g_ooba2_d[1].oobaowndp) RETURNING ls_return
            DISPLAY ls_return TO oobaowndp
            NEXT FIELD oobaowndp
         
         #----<<oobacrtid>>----
         ON ACTION controlp INFIELD oobacrtid
            CALL q_common('ooba_t','oobacrtid',TRUE,FALSE,g_ooba2_d[1].oobacrtid) RETURNING ls_return
            DISPLAY ls_return TO oobacrtid
            NEXT FIELD oobacrtid
         
         #----<<oobacrtdp>>----
         ON ACTION controlp INFIELD oobacrtdp
            CALL q_common('ooba_t','oobacrtdp',TRUE,FALSE,g_ooba2_d[1].oobacrtdp) RETURNING ls_return
            DISPLAY ls_return TO oobacrtdp
            NEXT FIELD oobacrtdp
         
         #----<<oobamodid>>----
         ON ACTION controlp INFIELD oobamodid
            CALL q_common('ooba_t','oobamodid',TRUE,FALSE,g_ooba2_d[1].oobamodid) RETURNING ls_return
            DISPLAY ls_return TO oobamodid
            NEXT FIELD oobamodid
         
         #----<<oobacnfid>>----
         #ON ACTION controlp INFIELD oobacnfid
         #   CALL q_common('ooba_t','oobacnfid',TRUE,FALSE,g_ooba_d[1].oobacnfid) RETURNING ls_return
         #   DISPLAY ls_return TO oobacnfid
         #   NEXT FIELD oobacnfid
         
         #----<<oobapstid>>----
         #ON ACTION controlp INFIELD oobapstid
         #   CALL q_common('ooba_t','oobapstid',TRUE,FALSE,g_ooba_d[1].oobapstid) RETURNING ls_return
         #   DISPLAY ls_return TO oobapstid
         #   NEXT FIELD oobapstid
         
         ##----<<oobacrtdt>>----
         AFTER FIELD oobacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oobamoddt>>----
         AFTER FIELD oobamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oobacnfdt>>----
         #AFTER FIELD oobacnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<oobapstdt>>----
         #AFTER FIELD oobapstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
           
         #單身一般欄位開窗相關處理
         #---------------------<  Detail: page1  >---------------------
         #----<<oobastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobastus
            #add-point:BEFORE FIELD oobastus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oobastus
            
            #add-point:AFTER FIELD oobastus

            #END add-point
            
 
         #Ctrlp:construct.c.page1.oobastus
         ON ACTION controlp INFIELD oobastus
            #add-point:ON ACTION controlp INFIELD oobastus

            #END add-point
 
         #----<<ooba002>>----
         #Ctrlp:construct.c.page1.ooba002
         ON ACTION controlp INFIELD ooba002
            #add-point:ON ACTION controlp INFIELD ooba002
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oobx001()                           #呼叫開窗 
            #151218-00001#1 20151218 modify by ming -----(S) 
            #修正「單據別」的回傳值寫到「模組別」的問題 
            #DISPLAY g_qryparam.return1 TO oobx002  #顯示到畫面上
            DISPLAY g_qryparam.return1 TO ooba002  #顯示到畫面上
            #151218-00001#1 20151218 modify by ming -----(E) 

            #151218-00001#1 20151218 modify by ming -----(S) 
            #剛好看到，順便修正 
            #NEXT FIELD oobx002                     #返回原欄位   
            NEXT FIELD ooba002                     #返回原欄位   
            #151218-00001#1 20151218 modify by ming -----(E) 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooba002
            #add-point:BEFORE FIELD ooba002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD ooba002
            
            #add-point:AFTER FIELD ooba002

            #END add-point
            
         ON ACTION controlp INFIELD oobx002
            #add-point:ON ACTION controlp INFIELD oobx002
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_gzzj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx002  #顯示到畫面上
            NEXT FIELD oobx002                     #返回原欄位            

         ON ACTION controlp INFIELD oobx003
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '24'
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx003  #顯示到畫面上
            NEXT FIELD oobx003                     #返回原欄位

         ON ACTION controlp INFIELD oobx004
            #add-point:ON ACTION controlp INFIELD oobx004
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_gzzz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx004  #顯示到畫面上
            NEXT FIELD oobx004                     #返回原欄位
#---------------------<  Detail: page2  >---------------------
          
      END CONSTRUCT

      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON oobb003,oobb004,oobb005,oobb006,oobb007,oobb008
           FROM s_detail1[1].oobb003,s_detail1[1].oobb004,s_detail1[1].oobb005,s_detail1[1].oobb006,s_detail1[1].oobb007,s_detail1[1].oobb008

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<oobb003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb003
            #add-point:BEFORE FIELD oobb003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb003

            #add-point:AFTER FIELD oobb003
            
            #END add-point


         #Ctrlp:construct.c.page1.oobb003
#         ON ACTION controlp INFIELD oobb003
            #add-point:ON ACTION controlp INFIELD oobb003
            
            #END add-point

         #----<<oobb004>>----
         #Ctrlp:construct.c.page1.oobb004
         ON ACTION controlp INFIELD oobb004
            #add-point:ON ACTION controlp INFIELD oobb004
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_dzeb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobb004  #顯示到畫面上

            NEXT FIELD oobb004                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobb004
            #add-point:BEFORE FIELD oobb004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb004

            #add-point:AFTER FIELD oobb004
            
            #END add-point


         #----<<oobb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb005
            #add-point:BEFORE FIELD oobb005
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb005

            #add-point:AFTER FIELD oobb005
            
            #END add-point


         #Ctrlp:construct.c.page1.oobb005
#         ON ACTION controlp INFIELD oobb005
            #add-point:ON ACTION controlp INFIELD oobb005
            
            #END add-point

         #----<<oobb006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb006
            #add-point:BEFORE FIELD oobb006
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb006

            #add-point:AFTER FIELD oobb006
            
            #END add-point


         #Ctrlp:construct.c.page1.oobb006
#         ON ACTION controlp INFIELD oobb006
            #add-point:ON ACTION controlp INFIELD oobb006
            
            #END add-point

         #----<<oobb007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb007
            #add-point:BEFORE FIELD oobb007
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb007

            #add-point:AFTER FIELD oobb007
            
            #END add-point


         #Ctrlp:construct.c.page1.oobb007
#         ON ACTION controlp INFIELD oobb007
            #add-point:ON ACTION controlp INFIELD oobb007
            
            #END add-point

         #----<<oobb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb008
            #add-point:BEFORE FIELD oobb008
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb008

            #add-point:AFTER FIELD oobb008
            
            #END add-point


         #Ctrlp:construct.c.page1.oobb008
#         ON ACTION controlp INFIELD oobb008
            #add-point:ON ACTION controlp INFIELD oobb008
            
            #END add-point



      END CONSTRUCT

      CONSTRUCT g_wc2_table2 ON oobc004,oobc003
           FROM s_detail2[1].oobc004,s_detail2[1].oobc003

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 2)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page2  >---------------------
         #----<<oobc003>>----
         #Ctrlp:construct.c.page2.oobc003
         ON ACTION controlp INFIELD oobc003
            #add-point:ON ACTION controlp INFIELD oobc003
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            #若查詢時,控制組類型有挑某一個值,則控制組編號開窗需要增加過濾控制組類型
            LET l_oobc004 = ''
            CALL GET_FLDBUF(oobc004) RETURNING l_oobc004
            IF l_oobc004 = '8' THEN
               CALL q_ooag001()
            ELSE
               IF l_oobc004 = '7' THEN  
                  CALL q_ooeg001_9()
               ELSE      
                  IF NOT cl_null(l_oobc004) THEN
                     LET g_qryparam.where = " ooha002='",l_oobc004 CLIPPED,"'"
                  END IF               
                  CALL q_ooha001()                                #呼叫開窗
               END IF   
            END IF            
            DISPLAY g_qryparam.return1 TO oobc003  #顯示到畫面上

            NEXT FIELD oobc003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobc003
            #add-point:BEFORE FIELD oobc003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobc003

            #add-point:AFTER FIELD oobc003
            
            #END add-point




      END CONSTRUCT

      CONSTRUCT g_wc2_table3 ON oobd003,oobd004
           FROM s_detail3[1].oobd003,s_detail3[1].oobd004

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 3)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page3  >---------------------
         #----<<oobd003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobd003
            #add-point:BEFORE FIELD oobd003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobd003

            #add-point:AFTER FIELD oobd003
            
            #END add-point


         #Ctrlp:construct.c.page3.oobd003
#         ON ACTION controlp INFIELD oobd003
            #add-point:ON ACTION controlp INFIELD oobd003
            
            #END add-point

         #----<<oobd004>>----
         #Ctrlp:construct.c.page3.oobd004
         ON ACTION controlp INFIELD oobd004
            #add-point:ON ACTION controlp INFIELD oobd004
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oobd004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobd004  #顯示到畫面上

            NEXT FIELD oobd004                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobd004
            #add-point:BEFORE FIELD oobd004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobd004

            #add-point:AFTER FIELD oobd004
            
            #END add-point




      END CONSTRUCT

      CONSTRUCT g_wc2_table4 ON oobh003
           FROM s_detail4[1].oobh003

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 4)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page4  >---------------------
         #----<<oobh003>>----
         #Ctrlp:construct.c.page4.oobh003
         ON ACTION controlp INFIELD oobh003
            #add-point:ON ACTION controlp INFIELD oobh003
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobh003  #顯示到畫面上

            NEXT FIELD oobh003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobh003
            #add-point:BEFORE FIELD oobh003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobh003

            #add-point:AFTER FIELD oobh003
            
            #END add-point




      END CONSTRUCT

      CONSTRUCT g_wc2_table5 ON oobj003
           FROM s_detail5[1].oobj003

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 5)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page5  >---------------------
         #----<<oobj003>>----
         #Ctrlp:construct.c.page5.oobj003
         ON ACTION controlp INFIELD oobj003
            #add-point:ON ACTION controlp INFIELD oobj003
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "220"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobj003  #顯示到畫面上

            NEXT FIELD oobj003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobj003
            #add-point:BEFORE FIELD oobj003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobj003

            #add-point:AFTER FIELD oobj003
            
            #END add-point




      END CONSTRUCT

      CONSTRUCT g_wc2_table6 ON oobk003
           FROM s_detail6[1].oobk003

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 6)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page6  >---------------------
         #----<<oobk003>>----
         #Ctrlp:construct.c.page6.oobk003
         ON ACTION controlp INFIELD oobk003
            #add-point:ON ACTION controlp INFIELD oobk003
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "220"
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobk003  #顯示到畫面上

            NEXT FIELD oobk003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobk003
            #add-point:BEFORE FIELD oobk003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobk003

            #add-point:AFTER FIELD oobk003
            
            #END add-point




      END CONSTRUCT

      CONSTRUCT g_wc2_table7 ON oobi003
           FROM s_detail7[1].oobi003

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct
            
            #end add-point

       #單身公用欄位開窗相關處理(table 7)


       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page7  >---------------------
         #----<<oobi003>>----
         #Ctrlp:construct.c.page7.oobi003
         ON ACTION controlp INFIELD oobi003
            #add-point:ON ACTION controlp INFIELD oobi003
            #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobi003  #顯示到畫面上

            NEXT FIELD oobi003                     #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD oobi003
            #add-point:BEFORE FIELD oobi003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobi003

            #add-point:AFTER FIELD oobi003
            
            #END add-point




      END CONSTRUCT
      
      CONSTRUCT g_wc2_table8 ON ooac003,gzszl004,ooac004
           FROM s_detail8[1].ooac003,s_detail8[1].gzszl004,s_detail8[1].ooac004

         BEFORE CONSTRUCT
           #CALL cl_qbe_display_condition(lc_qbe_sn)

      END CONSTRUCT

#      CONSTRUCT g_wc2_table8 ON ooac003,ooac004
#           FROM s_detail8[1].ooac003,s_detail8[1].ooac004
#
#         BEFORE CONSTRUCT
#            CALL cl_qbe_display_condition(lc_qbe_sn)
#            #add-point:cs段before_construct
#            
#            #end add-point
#
#       #單身公用欄位開窗相關處理(table 8)
#       #此段落由子樣板a11產生
#         ##----<<ooacownid>>----
#         #ON ACTION controlp INFIELD ooacownid
#         #   CALL q_common('type_t','ooacownid',TRUE,FALSE,g_oobb_d[1].ooacownid) RETURNING ls_return
#         #   DISPLAY ls_return TO ooacownid
#         #   NEXT FIELD ooacownid
#         #
#         ##----<<ooacowndp>>----
#         #ON ACTION controlp INFIELD ooacowndp
#         #   CALL q_common('type_t','ooacowndp',TRUE,FALSE,g_oobb_d[1].ooacowndp) RETURNING ls_return
#         #   DISPLAY ls_return TO ooacowndp
#         #   NEXT FIELD ooacowndp
#         #
#         ##----<<ooaccrtid>>----
#         #ON ACTION controlp INFIELD ooaccrtid
#         #   CALL q_common('type_t','ooaccrtid',TRUE,FALSE,g_oobb_d[1].ooaccrtid) RETURNING ls_return
#         #   DISPLAY ls_return TO ooaccrtid
#         #   NEXT FIELD ooaccrtid
#         #
#         ##----<<ooaccrtdp>>----
#         #ON ACTION controlp INFIELD ooaccrtdp
#         #   CALL q_common('type_t','ooaccrtdp',TRUE,FALSE,g_oobb_d[1].ooaccrtdp) RETURNING ls_return
#         #   DISPLAY ls_return TO ooaccrtdp
#         #   NEXT FIELD ooaccrtdp
#         #
#         ##----<<ooacmodid>>----
#         ##ON ACTION controlp INFIELD ooacmodid
#         ##   CALL q_common('type_t','ooacmodid',TRUE,FALSE,g_oobb_d[1].ooacmodid) RETURNING ls_return
#         ##   DISPLAY ls_return TO ooacmodid
#         ##   NEXT FIELD ooacmodid
#         #
#         ##----<<ooaccnfid>>----
#         ##ON ACTION controlp INFIELD ooaccnfid
#         ##   CALL q_common('type_t','ooaccnfid',TRUE,FALSE,g_oobb_d[1].ooaccnfid) RETURNING ls_return
#         ##   DISPLAY ls_return TO ooaccnfid
#         ##   NEXT FIELD ooaccnfid
#         #
#         ##----<<ooacpstid>>----
#         ##ON ACTION controlp INFIELD ooacpstid
#         ##   CALL q_common('type_t','ooacpstid',TRUE,FALSE,g_oobb_d[1].ooacpstid) RETURNING ls_return
#         ##   DISPLAY ls_return TO ooacpstid
#         ##   NEXT FIELD ooacpstid
#
#         ##----<<ooaccrtdt>>----
#         AFTER FIELD ooaccrtdt
#            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
#            IF NOT cl_null(ls_result) THEN
#               IF NOT cl_chk_date_symbol(ls_result) THEN
#                  LET ls_result = cl_add_date_extra_cond(ls_result)
#               END IF
#            END IF
#            CALL FGL_DIALOG_SETBUFFER(ls_result)
#
#         #----<<ooacmoddt>>----
#         AFTER FIELD ooacmoddt
#            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
#            IF NOT cl_null(ls_result) THEN
#               IF NOT cl_chk_date_symbol(ls_result) THEN
#                  LET ls_result = cl_add_date_extra_cond(ls_result)
#               END IF
#            END IF
#            CALL FGL_DIALOG_SETBUFFER(ls_result)
#
#         #----<<ooaccnfdt>>----
#         #AFTER FIELD ooaccnfdt
#         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
#         #   IF NOT cl_null(ls_result) THEN
#         #      IF NOT cl_chk_date_symbol(ls_result) THEN
#         #         LET ls_result = cl_add_date_extra_cond(ls_result)
#         #      END IF
#         #   END IF
#         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
#
#         #----<<ooacpstdt>>----
#         #AFTER FIELD ooacpstdt
#         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
#         #   IF NOT cl_null(ls_result) THEN
#         #      IF NOT cl_chk_date_symbol(ls_result) THEN
#         #         LET ls_result = cl_add_date_extra_cond(ls_result)
#         #      END IF
#         #   END IF
#         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
#
#
#
#       #單身一般欄位開窗相關處理
#       #---------------------<  Detail: page8  >---------------------
#         #----<<ooac003>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD ooac003
#            #add-point:BEFORE FIELD ooac003
#            
#            #END add-point
#
#         #此段落由子樣板a02產生
#         AFTER FIELD ooac003
#
#            #add-point:AFTER FIELD ooac003
#            
#            #END add-point
#
#
#         #Ctrlp:construct.c.page8.ooac003
##         ON ACTION controlp INFIELD ooac003
#            #add-point:ON ACTION controlp INFIELD ooac003
#            
#            #END add-point
#
#         #----<<gzsl004>>----
#         #----<<ooac004>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD ooac004
#            #add-point:BEFORE FIELD ooac004
#            
#            #END add-point
#
#         #此段落由子樣板a02產生
#         AFTER FIELD ooac004
#
#            #add-point:AFTER FIELD ooac004
#            
#            #END add-point
#
#
#         #Ctrlp:construct.c.page8.ooac004
##         ON ACTION controlp INFIELD ooac004
#            #add-point:ON ACTION controlp INFIELD ooac004
#            
#            #END add-point
#
#
#
#      END CONSTRUCT





      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
          {#ADP版次:1#}
      #end add-point

      BEFORE DIALOG
         #add-point:cs段b_dialog
         
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
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF

   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF

   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF

   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF

   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF

   IF g_wc2_table7 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
   END IF

   IF g_wc2_table8 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table8
   END IF
   IF g_wc2_table9 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table9
   END IF




   #add-point:cs段結束前
   
   #end add-point

   IF INT_FLAG THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION aooi200_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define
   
   #end add-point

   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT g_wc_filter ON ooba001
                          FROM s_browse[1].b_ooba001

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            DISPLAY aooi200_filter_parser('ooba001') TO s_browse[1].b_ooba001
   

      END CONSTRUCT

      #add-point:filter段add_cs
      
      #end add-point

      BEFORE DIALOG
         #add-point:filter段b_dialog
         
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

   CALL aooi200_filter_show('ooba001')

END FUNCTION

PRIVATE FUNCTION aooi200_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_tmp2    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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

PRIVATE FUNCTION aooi200_filter_show(ps_field)
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
   LET ls_condition = aooi200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

PRIVATE FUNCTION aooi200_query()
   {<Local define>}
   DEFINE ls_wc STRING
   {</Local define>}
   #add-point:query段define
   
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
   CALL g_oobb_d.clear()
   CALL g_oobb2_d.clear()

   CALL g_oobb3_d.clear()

   CALL g_oobb4_d.clear()

   CALL g_oobb5_d.clear()

   CALL g_oobb6_d.clear()

   CALL g_oobb7_d.clear()

   CALL g_oobb8_d.clear()


   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL aooi200_construct()

   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL aooi200_browser_fill("")
      CALL aooi200_fetch("")
      RETURN
   END IF

   #搜尋後資料初始化
   LET g_detail_cnt = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
   LET g_wc_filter = ""
   CALL FGL_SET_ARR_CURR(1)
   CALL aooi200_filter_show('ooba001')
   LET g_error_show = 1
   CALL aooi200_browser_fill("F")

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL aooi200_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION aooi200_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   {</Local define>}
   #add-point:fetch段define
   
   #end add-point

   IF g_browser_cnt = 0 THEN
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

         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF

         LET g_no_ask = FALSE
   END CASE

   #該樣板不需此段落CALL aooi200_browser_fill(p_flag)

   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引

   LET g_detail_cnt = g_header_cnt

   #單身總筆數顯示
   IF cl_null(g_detail_idx2) OR g_detail_idx2 = 0 THEN 
      LET g_detail_idx2 = 1
   END IF
   IF g_detail_cnt > 0 THEN
     # IF g_detail_idx2 >= g_detail_cnt THEN
     #    LET g_detail_idx2 = g_detail_cnt
     # END IF
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   #該樣板不需此段落LET g_pagestart = g_current_idx
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   #該樣板不需此段落DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   #該樣板不需此段落DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數

   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   #該樣板不需此段落CALL cl_navigator_setting( g_pagestart, g_browser_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET g_ooba_m.ooba001 = g_browser[g_current_idx].b_ooba001
   
   #重讀DB,因TEMP有不被更新特性
    SELECT UNIQUE ooba001,ooall004  
      INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc      
      FROM ooba_t
           LEFT OUTER JOIN ooall_t ON ooallent = oobaent AND ooall001 = '3' AND ooall002 = ooba001 AND ooall003 = g_dlang
     WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ooba_t"
       LET g_errparam.popup = TRUE
       CALL cl_err()

       INITIALIZE g_ooba_m.* TO NULL
       RETURN
    END IF

   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF

   #add-point:fetch段action控制
             {#ADP版次:1#}
   #end add-point

         

   #add-point:fetch結束前

          {#ADP版次:1#}
   #end add-point

   #LET g_data_owner =
   #LET g_data_group =
   #重新顯示
   LET g_bfill = "Y"
   CALL aooi200_show()
   LET g_bfill = "N"
END FUNCTION

PRIVATE FUNCTION aooi200_insert()
   #add-point:insert段define
   
   #end add-point

   #清畫面欄位內容
   CLEAR FORM
   CALL g_ooba_d.clear()
   CALL g_ooba2_d.clear()
   CALL g_oobb_d.clear()
   CALL g_oobb2_d.clear()

   CALL g_oobb3_d.clear()

   CALL g_oobb4_d.clear()

   CALL g_oobb5_d.clear()

   CALL g_oobb6_d.clear()

   CALL g_oobb7_d.clear()

   CALL g_oobb8_d.clear()



  # INITIALIZE g_ooba_m.* LIKE ooba_t.*             #DEFAULT 設定  #161124-00048#7  2016/12/13 By 08734 mark
   INITIALIZE g_ooba_m.* TO NULL             #DEFAULT 設定     #161124-00048#7  2016/12/13 By 08734 add

   LET g_ooba001_t = NULL

#160818-00026#1-s mark
#   IF NOT aooi200_s01_create_tmp() THEN 
#      RETURN
#   END IF
#160818-00026#1-e mark

   CALL s_transaction_begin()
   WHILE TRUE

      #append欄位給值




      #add-point:單頭預設值
      LET g_ooba_m.ooba008 = ""
      LET g_ooba_m.ooba009 = ""
      LET g_ooba_m.ooba010 = ""
      LET g_ooba_m.ooba011 = ""
      LET g_ooba_m.ooba012 = ""
      LET g_ooba_m.ooba013 = ""
      LET g_ooba_m.ooba014 = "1"
      LET g_ooba_m.ooba015 = "1"
      
      #160914-00032#3--s
      LET g_ooba_m.ooba017 = "1"
      LET g_ooba_m.ooba018 = "1"
      LET g_ooba_m.ooba019 = "1"
      LET g_ooba_m.ooba020 = "1"
      #160914-00032#3---e
      
      LET g_ooba_m_t.* = g_ooba_m.*
#20151103 by stellar mark 151103-00012#1 ----- (S)
#stellar mark:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#      #add by lixh 20150703 150702-00006#7
#      LET g_ooba_m.ooba001 = g_ooba001
#      CALL aooi200_ooba001_desc(g_ooba_m.ooba001)
#      DISPLAY BY NAME g_ooba_m.ooba001,g_ooba_m.ooba001_desc
#      CALL aooi200_s01()
#      
#      #add by lixh 20150703 150702-00006#7 
#20151103 by stellar mark 151103-00012#1 ----- (E)     
      #end add-point

      CALL aooi200_input("a")

      #add-point:單頭輸入後
      
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooba_m.* = g_ooba_m_t.*
         CALL aooi200_show2()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

		 CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_ooba_d.clear()
      CALL g_ooba2_d.clear()
      CALL g_oobb_d.clear()
      CALL g_oobb2_d.clear()

      CALL g_oobb3_d.clear()

      CALL g_oobb4_d.clear()

      CALL g_oobb5_d.clear()

      CALL g_oobb6_d.clear()

      CALL g_oobb7_d.clear()

      CALL g_oobb8_d.clear()



      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE

   END WHILE

   LET g_state = "Y"

   LET g_ooba001_t = g_ooba_m.ooba001

   LET g_wc = g_wc,
              " OR ( oobaent = '" ||g_enterprise|| "' AND",
              " ooba001 = '", g_ooba_m.ooba001 CLIPPED, "' "
              #," AND ooba002 = '", g_ooba_m.ooba002 CLIPPED, "' "


              , ") "

   CLOSE aooi200_cl

END FUNCTION

PRIVATE FUNCTION aooi200_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define
   
   #end add-point

   IF g_ooba_m.ooba001 IS NULL
   
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE ooba001
      INTO g_ooba_m.ooba001
      FROM ooba_t
    WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 

   ERROR ""
   
#160818-00026#1-s mark
#   IF NOT aooi200_s01_create_tmp() THEN 
#      RETURN
#   END IF
#160818-00026#1-e mark
   
   LET g_ooba001_t = g_ooba_m.ooba001

   CALL s_transaction_begin()

  #OPEN aooi200_cl USING g_enterprise,g_ooba_m.ooba001
  #                                                   
  #IF STATUS THEN
  #   CALL cl_err("OPEN aooi200_cl:", STATUS, 1)
  #   CLOSE aooi200_cl
  #   CALL s_transaction_end('N','0')
  #   RETURN
  #END IF
  #
  ##鎖住將被更改或取消的資料
  #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015
  #
  ##資料被他人LOCK, 或是sql執行時出現錯誤
  #IF SQLCA.sqlcode THEN
  #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
  #   CLOSE aooi200_cl
  #   CALL s_transaction_end('N','0')
  #   RETURN
  #END IF

            

   CALL aooi200_show2()
   WHILE TRUE
      LET g_ooba001_t = g_ooba_m.ooba001
      



      #寫入修改者/修改日期資訊(單頭)
#      LET g_ooba_m.oobamodid = g_user
#      LET g_ooba_m.oobamoddt = cl_get_current()


      #add-point:modify段修改前
         {#ADP版次:1#}
      #end add-point

      CALL aooi200_input("u")     #欄位更改

      #add-point:modify段修改後
      
      #end add-point
      #160919-00048#1-s-add
      IF g_update OR NOT INT_FLAG THEN
         LET g_ooba2_d[l_ac].oobamodid = g_user 
         LET g_ooba2_d[l_ac].oobamoddt = cl_get_current()
         LET g_ooba2_d[l_ac].oobamodid_desc = cl_get_username(g_ooba2_d[l_ac].oobamodid)
         #若有modid跟moddt則進行update
         UPDATE ooba_t SET (oobamodid,oobamoddt) = (g_ooba2_d[l_ac].oobamodid,g_ooba2_d[l_ac].oobamoddt)
          WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 
            AND ooba002 = g_ooba_d[g_detail_idx2].ooba002
      END IF
      #160919-00048#1-e-add
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooba_m.* = g_ooba_m_t.*
         CALL aooi200_show2()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
#      IF g_ooba_m.ooba001 != g_ooba001_t
#     
#
#
#      THEN
#         CALL s_transaction_begin()
#
#         #add-point:單身fk修改前
#         
#         #end add-point
#
#         #更新單身key值
#         UPDATE oobb_t SET oobb001 = g_ooba_m.ooba001
#                                      ,oobb002 = g_ooba_m.ooba002
#
#
#          WHERE oobbent = g_enterprise AND oobb001 = g_ooba001_t
#            AND oobb002 = g_ooba002_t
#
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#
#         IF SQLCA.sqlcode THEN
#             CALL cl_err("",SQLCA.sqlcode,1)
#             CALL s_transaction_end('N','0')
#             CONTINUE WHILE
#         END IF
#
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobc_t
#            SET oobc001 = g_ooba_m.ooba001
#               ,oobc002 = g_ooba_m.ooba002
#
#
#          WHERE oobcent = g_enterprise AND
#                oobc001 = g_ooba001_t
#            AND oobc002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobd_t
#            SET oobd001 = g_ooba_m.ooba001
#               ,oobd002 = g_ooba_m.ooba002
#
#
#          WHERE oobdent = g_enterprise AND
#                oobd001 = g_ooba001_t
#            AND oobd002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobh_t
#            SET oobh001 = g_ooba_m.ooba001
#               ,oobh002 = g_ooba_m.ooba002
#
#
#          WHERE oobhent = g_enterprise AND
#                oobh001 = g_ooba001_t
#            AND oobh002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobj_t
#            SET oobj001 = g_ooba_m.ooba001
#               ,oobj002 = g_ooba_m.ooba002
#
#
#          WHERE oobjent = g_enterprise AND
#                oobj001 = g_ooba001_t
#            AND oobj002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobk_t
#            SET oobk001 = g_ooba_m.ooba001
#               ,oobk002 = g_ooba_m.ooba002
#
#
#          WHERE oobkent = g_enterprise AND
#                oobk001 = g_ooba001_t
#            AND oobk002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE oobi_t
#            SET oobi001 = g_ooba_m.ooba001
#               ,oobi002 = g_ooba_m.ooba002
#
#
#          WHERE oobient = g_enterprise AND
#                oobi001 = g_ooba001_t
#            AND oobi002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#         #更新單身key值
#         #add-point:單身fk修改前
#         
#         #end add-point
#         UPDATE ooac_t
#            SET ooac001 = g_ooba_m.ooba001
#               ,ooac002 = g_ooba_m.ooba002
#
#
#          WHERE ooacent = g_enterprise AND
#                ooac001 = g_ooba001_t
#            AND ooac002 = g_ooba002_t
#
#
#         #add-point:單身fk修改中
#         
#         #end add-point
#         IF SQLCA.sqlcode THEN
#            CALL cl_err("",SQLCA.sqlcode,1)
#            CALL s_transaction_end('N','0')
#            CONTINUE WHILE
#         END IF
#         #add-point:單身fk修改後
#         
#         #end add-point
#
#
#
#
#
#         #UPDATE 多語言table key值
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#         CALL s_transaction_end('Y','0')
#      END IF

      EXIT WHILE
   END WHILE

   #修改歷程記錄
   IF NOT cl_log_modified_record(g_ooba_m.ooba001,g_site) THEN
      CALL s_transaction_end('N','0')
   END IF

   #CLOSE aooi200_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-U
   CALL cl_flow_notify(g_ooba_m.ooba001,'U')

END FUNCTION

PRIVATE FUNCTION aooi200_input(p_cmd)
   {<Local define>}
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_cmd           LIKE type_t.chr1
   DEFINE  l_ac_t          LIKE type_t.num10                #未取消的ARRAY CNT  #161108-00012#2 num5==》num10
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
   {</Local define>}
   #add-point:input段define
   DEFINE l_acc            LIKE gzcb_t.gzcb004          {#ADP版次:1#}
   DEFINE  l_gszy002       LIKE gzsy_t.gzsy002
   DEFINE  l_ooacownid     LIKE ooac_t.ooacownid
   DEFINE  l_ooacowndp     LIKE ooac_t.ooacowndp
   DEFINE  l_ooaccrtid     LIKE ooac_t.ooaccrtid
   DEFINE  l_ooaccrtdp     LIKE ooac_t.ooaccrtdp
   DEFINE  l_ooaccrtdt     DATETIME YEAR TO SECOND
   DEFINE  l_ooacmodid     LIKE type_t.chr80
   DEFINE  l_ooacmoddt     DATETIME YEAR TO SECOND
   DEFINE  l_ooba002       STRING
   DEFINE  l_ooaa002       LIKE ooaa_t.ooaa002
   DEFINE  l_length         LIKE type_t.num10
   DEFINE  l_ooba002_length LIKE type_t.num10 
   DEFINE  l_gzsz016       LIKE gzsz_t.gzsz016
   DEFINE  l_gzcb001       LIKE gzcb_t.gzcb001    #150414 by whitney add 系統分類碼
   DEFINE  l_gzcal003      LIKE gzcal_t.gzcal003  #150414 by whitney add 系統分類碼說明
   #dorislai-20150827-add----(S)
   DEFINE l_oobd004              LIKE oobd_t.oobd004   #生命週期編號
   DEFINE l_oobh003              LIKE oobh_t.oobh003   #產品分類限定
   DEFINE l_oobj003              LIKE oobj_t.oobj003   #庫存標籤(Tag)限定(From)
   DEFINE l_oobk003              LIKE oobk_t.oobk003   #庫存標籤(Tag)限定(To)
   DEFINE l_oobi003              LIKE oobi_t.oobi003   #單身理由碼
   DEFINE l_multi_oobd_ins       LIKE type_t.num5      #是否有開窗多選單生命週期編號
   DEFINE l_multi_oobh_ins       LIKE type_t.num5      #是否有開窗多選單產品分類限定 
   DEFINE l_multi_oobj_ins       LIKE type_t.num5      #是否有開窗多選單庫存標籤(Tag)限定(From)   
   DEFINE l_multi_oobk_ins       LIKE type_t.num5      #是否有開窗多選單庫存標籤(Tag)限定(To)   
   DEFINE l_multi_oobi_ins       LIKE type_t.num5      #是否有開窗多選單單身理由碼   
   DEFINE l_str                  STRING
   #dorislai-20150827-add----(E)
   DEFINE l_sql                  STRING                #160419-00010#1 add
   #end add-point
   DEFINE l_oobc003              LIKE oobc_t.oobc003  #160914-00032#3 
   DEFINE l_multi_oobc_ins       LIKE type_t.num5     #160914-00032#3 #是否有開窗多選單控制組編號
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   #add-point:input段define_sql
   
   #end add-point

   LET g_forupd_sql = "SELECT oobastus,ooba002, ",
                      "       ooba016, ", #151020-00016 by whitney add
                      "       ooba002,oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt ",
                      "  FROM ooba_t ",
                      " WHERE oobaent=? AND ooba001=? AND ooba002=? FOR UPDATE"

#   LET g_forupd_sql = "SELECT UNIQUE oobastus,ooba002,oobxl003,oobx002,gzzol003,oobx003,oobx004,gzzal003,oobx005,oobx006,oobx007,oobx008,", 
#                      "        ooba002,oobaownid,own.oofa003,oobaowndp,ow.ooefl003,oobacrtid,crt.oofa003,oobacrtdp,cr.ooefl003,oobacrtdt,oobamodid,mod.oofa003,oobamoddt ",
#                      "  FROM ooba_t", 
#                      "       LEFT OUT JOIN oobx_t ON oobaent = oobxent AND ooba002 = oobx001 ",
#                      "       LEFT OUT JOIN oobxl_t ON oobaent = oobxlent AND ooba002 = oobxl001 AND oobxl002 = '",g_lang,"'",
#                      "       LEFT OUT JOIN gzzol_t ON oobx002 = gzzol001 AND gzzol002 = '",g_lang,"'",
#                      "       LEFT OUT JOIN gzzal_t ON oobx004 = gzzal001 AND gzzal002 = '",g_lang,"'",
#                      "       LEFT OUT JOIN oofa_t own ON own.oofa002 = '2' AND own.oofa003 = oobaownid ",
#                      "       LEFT OUT JOIN oofa_t crt ON crt.oofa002 = '2' AND crt.oofa003 = oobaownid ",
#                      "       LEFT OUT JOIN oofa_t mod ON mod.oofa002 = '2' AND mod.oofa003 = oobaownid ",
#                      "       LEFT OUT JOIN ooefl_t ow ON ow.ooeflent = oobaent AND ow.ooefl001 = oobaowndp AND ow.ooefl002 = '",g_lang,"'",
#                      "       LEFT OUT JOIN ooefl_t cr ON cr.ooeflent = oobaent AND cr.ooefl001 = oobaowndp AND cr.ooefl002 = '",g_lang,"'",                   
#                      " WHERE oobaent= ? AND ooba001=? AND ooba002=? FOR UPDATE"  
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl9 CURSOR FROM g_forupd_sql 
   
   LET g_forupd_sql = "SELECT oobb003,oobb004,oobb005,oobb006,oobb007,oobb008 FROM oobb_t WHERE oobbent=? AND oobb001=? AND oobb002=? AND oobb003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobc004,oobc003 FROM oobc_t WHERE oobcent=? AND oobc001=? AND oobc002=? AND oobc003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl2 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobd003,oobd004 FROM oobd_t WHERE oobdent=? AND oobd001=? AND oobd002=? AND oobd003=? AND oobd004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl3 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobh003 FROM oobh_t WHERE oobhent=? AND oobh001=? AND oobh002=? AND oobh003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl4 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobj003 FROM oobj_t WHERE oobjent=? AND oobj001=? AND oobj002=? AND oobj003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl5 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobk003 FROM oobk_t WHERE oobkent=? AND oobk001=? AND oobk002=? AND oobk003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl6 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT oobi003 FROM oobi_t WHERE oobient=? AND oobi001=? AND oobi002=? AND oobi003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl7 CURSOR FROM g_forupd_sql

   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = "SELECT ooac003,ooac004 FROM ooac_t WHERE ooacent=? AND ooac001=? AND ooac002=? AND ooac003=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE aooi200_bcl8 CURSOR FROM g_forupd_sql

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL aooi200_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL aooi200_set_no_entry(p_cmd)

   DISPLAY BY NAME g_ooba_m.ooba001
   
   #add-point:資料輸入前
   LET g_errshow = 1
   #dorislai-20150827-add----(S)
   WHILE TRUE
      LET l_multi_oobd_ins = FALSE
      LET l_multi_oobd_ins = FALSE
      LET l_multi_oobh_ins = FALSE 
      LET l_multi_oobj_ins = FALSE   
      LET l_multi_oobk_ins = FALSE  
      LET l_multi_oobi_ins = FALSE 
      LET l_multi_oobc_ins = FALSE   #160914-00032#3 
   #dorislai-20150827-add----(E)
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT BY NAME g_ooba_m.ooba001,g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
           g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
           g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020  #160914-00032#3           
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            #add-point:單頭input前
            
            #end add-point
          
         #---------------------------<  Master  >---------------------------
         #----<<ooba001>>----
         #此段落由子樣板a02產生
         AFTER FIELD ooba001
            
            #add-point:AFTER FIELD ooba001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooba_m.ooba001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t )) THEN 
                  IF NOT aooi200_ooba001_chk(g_ooba_m.ooba001) THEN
                     LET g_ooba_m.ooba001 = g_ooba_m_t.ooba001
                     NEXT FIELD CURRENT
                  ELSE
                     CALL aooi200_s01()                
                  END IF
               END IF
            END IF

#            INITIALIZE g_chkparam.* TO NULL
#            LET g_chkparam.arg1 = g_ooba_m.ooba001
#            IF cl_chk_exist("v_ooal002_3") THEN
#               CALL aooi200_s01()
#            ELSE
#              LET g_ooba_m.ooba001 = g_ooba_m_t.ooba001
#              NEXT FIELD CURRENT             
#            END IF            
            

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooba_m.ooba001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooba_m.ooba001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooba_m.ooba001_desc
          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooba001
            #add-point:BEFORE FIELD ooba001
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ooba001
            #add-point:ON CHANGE ooba001
            
            #END add-point
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<ooba001>>----
         #Ctrlp:input.c.ooba001
         ON ACTION controlp INFIELD ooba001
            #add-point:ON ACTION controlp INFIELD ooba001
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooba_m.ooba001             #給予default值

            #給予arg
            #20151103 by stellar add 151103-00012#1 ----- (S)
            #stellar add:除了aooi100的單據別參照表外，還有agli010的單據別參照表
            LET g_qryparam.where = " ooal002 IN ('",g_ooba001,"')"
            #20151103 by stellar add 151103-00012#1 ----- (E)

            CALL q_ooal002_2()                                #呼叫開窗

            LET g_ooba_m.ooba001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooba_m.ooba001 TO ooba001              #顯示到畫面上

            NEXT FIELD ooba001                          #返回原欄位

          {#ADP版次:1#}
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            
                
            CALL cl_showmsg()
            DISPLAY BY NAME g_ooba_m.ooba001             
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
                              
#               UPDATE oobg_t SET oobg004 = g_ooba_m.oobg004,oobg003 = g_ooba_m.oobg003
#                WHERE oobgent = g_enterprise AND oobg001 = g_ooba001_t
#                  AND oobg002 = g_ooba002_t
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err("g_ooba_m",SQLCA.sqlcode,1)  
#                  ROLLBACK WORK
#               END IF
#               
#               CALL aooi200_oobl_count() RETURNING l_n
#               IF l_n = 1 AND g_ooba_m.ooba005 != g_ooba_m_t.ooba005 THEN
#                  DELETE FROM oobl_t WHERE ooblent = g_enterprise
#                     AND oobl001 = g_ooba001_t AND oobl002 = g_ooba002_t
#                     AND oobl003 = g_ooba_m_t.ooba005
#                  IF SQLCA.sqlcode THEN
#                     CALL cl_err("g_ooba_m",SQLCA.sqlcode,1)  
#                     ROLLBACK WORK
#                  END IF
#                  
#                  INSERT INTO oobl_t(ooblent,oobl001,oobl002,oobl003) 
#                  VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_m.ooba002,g_ooba_m.ooba005)
#                  IF SQLCA.sqlcode THEN
#                     CALL cl_err("g_ooba_m",SQLCA.sqlcode,1)  
#                     ROLLBACK WORK
#                  END IF
#               END IF
               #end add-point
            
               UPDATE ooba_t SET (ooba001,ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,ooba014,ooba015,
                                  ooba017,ooba018,ooba019,ooba020)   #160914-00032#3  
                                =  
                                 (g_ooba_m.ooba001,g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
                                 g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020)    #160914-00032#3  
                WHERE oobaent = g_enterprise AND ooba001 = g_ooba001_t
                  AND ooba002 = g_ooba_d[g_detail_idx2].ooba002
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "ooba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               CALL aooi200_update_b('ooba_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_ooba001_t = g_ooba_m.ooba001
 
                     #add-point:單頭修改後
                     
                     #end add-point
                     CALL s_transaction_end('Y','0')
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                                 
            END IF
           #controlp
                     
           LET g_ooba001_t = g_ooba_m.ooba001
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           IF cl_null(g_ooba_d[1].ooba002) THEN
              CALL g_ooba_d.deleteElement(1)
              NEXT FIELD ooba002
           END IF
 
      END INPUT


      #Page1 預設值產生於此處
      INPUT ARRAY g_ooba_d FROM s_detail10.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aooi200_b2_fill()
            LET g_rec_b = g_ooba_d.getLength()            
            IF g_rec_b != 0 THEN
               #2015/10/14 by stellar add ----- (S)
               IF NOT cl_null(g_detail_idx2) AND g_detail_idx2 > 0 THEN
                  LET l_ac = g_detail_idx2
               END IF
               #2015/10/14 by stellar add ----- (E)
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail10")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
#            #判定新增或修改
#            IF l_cmd = 'u' THEN
#               OPEN aooi200_cl USING g_enterprise,
#                                               g_ooba_m.ooba001
# 
#                                               
#               IF STATUS THEN
#                  CALL cl_err("OPEN aiti808_cl:", STATUS, 1)
#                  CLOSE aiti808_cl
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_ooba_d[l_ac].ooba002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_ooba_d_t.* = g_ooba_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("ooba_t","'9'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl9 INTO g_ooba_d[l_ac].oobastus,g_ooba_d[l_ac].ooba002,
                      g_ooba_d[l_ac].ooba016,  #151020-00016 by whitney add
                      g_ooba2_d[l_ac].ooba002,g_ooba2_d[l_ac].oobaownid, 
                      g_ooba2_d[l_ac].oobaowndp,g_ooba2_d[l_ac].oobacrtid, 
                      g_ooba2_d[l_ac].oobacrtdp,g_ooba2_d[l_ac].oobacrtdt,
                      g_ooba2_d[l_ac].oobamodid,g_ooba2_d[l_ac].oobamoddt
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_ooba_d_t.ooba002
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET l_lock_sw = "Y"
                  END IF
                 INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
                  CALL ap_ref_array2(g_ref_fields," SELECT oobx002,oobx003,oobx004,oobx005 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
                  LET g_ooba_d[l_ac].oobx002 = g_rtn_fields[1]
                  LET g_ooba_d[l_ac].oobx003 = g_rtn_fields[2]
                  LET g_ooba_d[l_ac].oobx004 = g_rtn_fields[3]
                  LET g_ooba_d[l_ac].oobx005 = g_rtn_fields[4]
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
                  CALL ap_ref_array2(g_ref_fields," SELECT oobx006,oobx007,oobx008 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
                  LET g_ooba_d[l_ac].oobx006 = g_rtn_fields[1]
                  LET g_ooba_d[l_ac].oobx007 = g_rtn_fields[2]
                  LET g_ooba_d[l_ac].oobx008 = g_rtn_fields[3]         
                  DISPLAY BY NAME g_ooba_d[l_ac].oobx002,g_ooba_d[l_ac].oobx003,g_ooba_d[l_ac].oobx004,g_ooba_d[l_ac].oobx005,
                                  g_ooba_d[l_ac].oobx006,g_ooba_d[l_ac].oobx007,g_ooba_d[l_ac].oobx008
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
                  CALL ap_ref_array2(g_ref_fields," SELECT oobxl003 FROM oobxl_t WHERE oobxlent = '"||g_enterprise||"' AND oobxl001 = ? AND oobxl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_ooba_d[l_ac].ooba002_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba_d[l_ac].ooba002_desc
            
#                  INITIALIZE g_ref_fields TO NULL
#                  LET g_ref_fields[1] = g_ooba_d[l_ac].oobx002
#                  CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_dlang||"'","") RETURNING g_rtn_fields
#                  LET g_ooba_d[l_ac].oobx002_desc = g_rtn_fields[1]
                  CALL s_azzi930_get_module_name(g_ooba_d[l_ac].oobx002) RETURNING g_ooba_d[l_ac].oobx002_desc   #15/06/25 Sarah add
                  DISPLAY BY NAME g_ooba_d[l_ac].oobx002_desc
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba_d[l_ac].oobx004
                  CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_ooba_d[l_ac].oobx004_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba_d[l_ac].oobx004_desc
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaownid
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
                  LET g_ooba2_d[l_ac].oobaownid_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba2_d[l_ac].oobaownid_desc
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaowndp
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_ooba2_d[l_ac].oobaowndp_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba2_d[l_ac].oobaowndp_desc
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba2_d[l_ac].oobamodid
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
                  LET g_ooba2_d[l_ac].oobamodid_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba2_d[l_ac].oobamodid_desc
         
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_ooba2_d[l_ac].oobacrtdp
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_ooba2_d[l_ac].oobacrtdp_desc = g_rtn_fields[1]
                  DISPLAY BY NAME g_ooba2_d[l_ac].oobacrtdp_desc                     
                  LET g_ooba_d_t.* = g_ooba_d[l_ac].*
                  LET g_bfill = "N"
                  CALL aooi200_b_fill('0')
                  CALL aooi200_show()
                  LET g_bfill = "Y"
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_ooba_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_ooba_d[l_ac].* TO NULL
            INITIALIZE g_ooba2_d[l_ac].* TO NULL
            CALL g_oobb_d.clear()
            CALL g_oobb2_d.clear()
            CALL g_oobb3_d.clear()         
            CALL g_oobb4_d.clear()        
            CALL g_oobb5_d.clear()       
            CALL g_oobb6_d.clear()      
            CALL g_oobb7_d.clear()        
            CALL g_oobb8_d.clear()            
            #公用欄位預設值
            #此段落由子樣板a14產生    
            LET g_ooba2_d[l_ac].oobaownid = g_user
            LET g_ooba2_d[l_ac].oobaowndp = g_dept
            LET g_ooba2_d[l_ac].oobacrtid = g_user
            LET g_ooba2_d[l_ac].oobacrtdp = g_dept 
            LET g_ooba2_d[l_ac].oobacrtdt = cl_get_current()
            LET g_ooba2_d[l_ac].oobamodid = ""
            LET g_ooba2_d[l_ac].oobamoddt = ""
            LET g_ooba_d[l_ac].oobastus = "Y"
            LET g_ooba_m.ooba008 = ""
            LET g_ooba_m.ooba009 = ""
            LET g_ooba_m.ooba010 = ""
            LET g_ooba_m.ooba011 = ""
            LET g_ooba_m.ooba012 = ""
            LET g_ooba_m.ooba013 = ""
            LET g_ooba_m.ooba014 = "1"
            LET g_ooba_m.ooba015 = "1"      
            #160914-00032#3--s
            LET g_ooba_m.ooba017 = "1"
            LET g_ooba_m.ooba018 = "1"   
            LET g_ooba_m.ooba019 = "1"
            LET g_ooba_m.ooba020 = "1"   
            #160914-00032#3---e
            #一般欄位預設值            
            
            LET g_ooba_d_t.* = g_ooba_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
           #IF lb_reproduce THEN
           #   LET lb_reproduce = FALSE
           #   LET g_ooba_d[li_reproduce_target].* = g_ooba_d[li_reproduce].*
           #   LET g_ooba2_d[li_reproduce_target].* = g_ooba2_d[li_reproduce].*
           #
           #   LET g_ooba_d[g_ooba_d.getLength()].ooba002 = NULL
           #
           #END IF
            
            #add-point:modify段before insert
#            SELECT MAX(oobb003) INTO g_oobb_d[l_ac].oobb003 FROM oobb_t
#             WHERE oobb001 = g_ooba_m.ooba001 AND oobb002 = g_ooba_m.ooba002
#            IF cl_null(g_oobb_d[l_ac].oobb003) THEN LET g_oobb_d[l_ac].oobb003 = 0 END IF
#            LET g_oobb_d[l_ac].oobb003 = g_oobb_d[l_ac].oobb003 +1
            #end add-point  
 
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
            SELECT COUNT(*) INTO l_count FROM ooba_t 
             WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001
               AND ooba002 = g_ooba_d[l_ac].ooba002
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()

               INSERT INTO ooba_t
                           (oobaent,
                            ooba001,
                            ooba002,ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,ooba014,ooba015,
                            ooba016,  #151020-00016 by whitney add
                            ooba017,ooba018,ooba019,ooba020,   #160914-00032#3
                            oobastus,oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt) 
                     VALUES(g_enterprise,
                            g_ooba_m.ooba001,
                            g_ooba_d[l_ac].ooba002,
                            g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,g_ooba_m.ooba011,
                            g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
                            g_ooba_d[l_ac].ooba016,  #151020-00016 by whitney add
                            g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020,  #160914-00032#3
                            g_ooba_d[l_ac].oobastus,g_ooba2_d[l_ac].oobaownid, 
                            g_ooba2_d[l_ac].oobaowndp,g_ooba2_d[l_ac].oobacrtid,g_ooba2_d[l_ac].oobacrtdp, 
                            g_ooba2_d[l_ac].oobacrtdt,g_ooba2_d[l_ac].oobamodid,g_ooba2_d[l_ac].oobamoddt) 
 
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_ooba_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               IF NOT aooi200_ooac_ins(l_cmd) THEN
                  CALL 	s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            
            #end add-point
                         
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_ooba_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_ooba_d.deleteElement(l_ac)
               NEXT FIELD ooba002
            END IF

            IF NOT cl_null(g_ooba_d[l_ac].ooba002)

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
               #檢查單據別最大流水號紀錄檔裡有沒有資料,有資料代表這個單據別已經有被使用,不可刪除
               SELECT COUNT(*) INTO l_cnt 
                 FROM ooef_t
                INNER JOIN oobf_t ON ooefent = oobfent AND ooef001 = oobfsite AND ooef005 = oobf001
                WHERE ooefent = g_enterprise
                  AND ooef004 = g_ooba_m.ooba001
                  AND oobf002 = g_ooba_d_t.ooba002 
                  AND oobf004 <> 0    #最大流水號=0表示先前有使用過此單據別編過單號,但又把那筆單號刪掉了                  
               IF l_cnt > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "aoo-00297"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               #end add-point

               DELETE FROM ooba_t
                WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001
                  AND ooba002 = g_ooba_d_t.ooba002 

               #add-point:單身刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身刪除後

                  DELETE FROM oobb_t
                   WHERE oobbent = g_enterprise AND
                         oobb001 = g_ooba_m.ooba001 AND oobb002 = g_ooba_d_t.ooba002
            
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobb_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobc_t
                   WHERE oobcent = g_enterprise AND
                         oobc001 = g_ooba_m.ooba001 AND oobc002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobc_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobd_t
                   WHERE oobdent = g_enterprise AND
                         oobd001 = g_ooba_m.ooba001 AND oobd002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobd_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobh_t
                   WHERE oobhent = g_enterprise AND
                         oobh001 = g_ooba_m.ooba001 AND oobh002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobh_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobj_t
                   WHERE oobjent = g_enterprise AND
                         oobj001 = g_ooba_m.ooba001 AND oobj002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobj_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobk_t
                   WHERE oobkent = g_enterprise AND
                         oobk001 = g_ooba_m.ooba001 AND oobk002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobk_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM oobi_t
                   WHERE oobient = g_enterprise AND
                         oobi001 = g_ooba_m.ooba001 AND oobi002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "oobi_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF
            
                  DELETE FROM ooac_t
                   WHERE ooacent = g_enterprise AND
                         ooac001 = g_ooba_m.ooba001 AND ooac002 = g_ooba_d_t.ooba002
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooac_t"
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     RETURN
                  END IF

                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl9
               LET l_count = g_ooba_d.getLength()
            END IF

            INITIALIZE gs_keys TO NULL
            LET gs_keys[1] = g_ooba_m.ooba001
            LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002

         AFTER DELETE
            #add-point:單身刪除後2
            
            #end add-point
            # CALL aooi200_delete_b('ooba_t',gs_keys,"'9'")
             
 
         #---------------------<  Detail: page1  >---------------------
         #----<<oobastus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobastus
            #add-point:BEFORE FIELD oobastus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oobastus
            
            #add-point:AFTER FIELD oobastus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oobastus
            #add-point:ON CHANGE oobastus
            #160830-00007#2---add---s
            IF g_ooba_d[l_ac].oobastus = 'Y' THEN 
               IF NOT cl_null(g_ooba_d[l_ac].ooba002) THEN 
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM oobx_t
                   WHERE oobxent = g_enterprise
                     AND oobx001 = g_ooba_d[l_ac].ooba002
                     AND oobxstus = 'N'  
                  IF l_cnt > 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00715'
                     LET g_errparam.extend = g_ooba_d[l_ac].oobastus
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                 
                     LET g_ooba_d[l_ac].oobastus = g_ooba_d_t.oobastus
                     DISPLAY BY NAME g_ooba_d[l_ac].oobastus
                     NEXT FIELD CURRENT                  
                  END IF                    
               END IF
            END IF
            #160830-00007#2---add---e
            #END add-point
 
         #----<<ooba002>>----
         #此段落由子樣板a02產生
         AFTER FIELD ooba002
            
            #add-point:AFTER FIELD ooba002

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
            CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_ooba_d[l_ac].ooba002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_ooba_d[l_ac].ooba002_desc

            #此段落由子樣板a05產生
            IF  g_ooba_m.ooba001 IS NOT NULL AND g_ooba_d[g_detail_idx2].ooba002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002)) THEN 
                 #IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooba_t WHERE "||"oobaent = '" ||g_enterprise|| "' AND "||"ooba001 = '"||g_ooba_m.ooba001 ||"' AND "|| "ooba002 = '"||g_ooba_d[l_ac].ooba002 ||"'",'std-00004',0) THEN #160419-00010#1 mark
                 #160419-00010#1--add--start--
                  LET l_sql = " SELECT COUNT(*) FROM (",
                                                     " SELECT UNIQUE ooba001 ",
                                                     "   FROM ooba_t ",
                                                     "   LEFT JOIN oobal_t ON ooba001 = oobal001 AND ooba002 = oobal002 AND oobal003 = '",g_dlang,"' ",
                                                     "   WHERE oobaent = '"||g_enterprise||"' ",
                                                     "     AND ooba001 = '"||g_ooba_m.ooba001 ||"' ",
                                                     "     AND ooba002 = '"||g_ooba_d[l_ac].ooba002 ||"'",
                                                     "     AND ooba001 IN ('",g_ooba001,"')",
                                                     ")"
                  IF NOT ap_chk_notDup("",l_sql,'std-00004',0) THEN
                 #160419-00010#1--add--end----    
                     LET g_ooba_d[l_ac].ooba002 = g_ooba_d_t.ooba002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_ooba_d[l_ac].ooba002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oobx001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL aooi200_ooba002_ref()
               ELSE
                  #檢查失敗時後續處理
                  LET g_ooba_d[l_ac].ooba002 = g_ooba_d_t.ooba002
                  NEXT FIELD CURRENT
               END IF               
            END IF

          {#ADP版次:1#}
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD ooba002
            #add-point:BEFORE FIELD ooba002
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE ooba002
            #add-point:ON CHANGE ooba002
            
            #END add-point
 

 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<oobastus>>----
         #Ctrlp:input.c.page1.oobastus
#         ON ACTION controlp INFIELD oobastus
            #add-point:ON ACTION controlp INFIELD oobastus
            
            #END add-point
 
         #----<<ooba002>>----
         #Ctrlp:input.c.page1.ooba002
         ON ACTION controlp INFIELD ooba002
            #add-point:ON ACTION controlp INFIELD ooba002
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooba_d[l_ac].ooba002             #給予default值

            #給予arg

            CALL q_oobx001()                                #呼叫開窗

            LET g_ooba_d[l_ac].ooba002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooba_d[l_ac].ooba002 TO ooba002              #顯示到畫面上
            CALL aooi200_ooba002_ref()
            NEXT FIELD ooba002                          #返回原欄位
            #END add-point
 
          ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_ooba_d[l_ac].* = g_ooba_d_t.*
               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_ooba_d[l_ac].ooba002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooba_d[l_ac].* = g_ooba_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               LET g_ooba2_d[l_ac].oobamodid = g_user 
               LET g_ooba2_d[l_ac].oobamoddt = cl_get_current()
 
            
               #add-point:單身修改前
               
               #end add-point
         
               UPDATE ooba_t SET (ooba001,oobastus,ooba002,ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,ooba014,ooba015,
                   ooba016,  #151020-00016 by whitney add
                   ooba017,ooba018,ooba019,ooba020,  #160914-00032#3
                   oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt) = (g_ooba_m.ooba001, 
                   g_ooba_d[l_ac].oobastus,g_ooba_d[l_ac].ooba002,g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
                   g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
                   g_ooba_d[l_ac].ooba016,  #151020-00016 by whitney add
                   g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020,  #160914-00032#3
                   g_ooba2_d[l_ac].oobaownid,g_ooba2_d[l_ac].oobaowndp,g_ooba2_d[l_ac].oobacrtid,g_ooba2_d[l_ac].oobacrtdp, 
                   g_ooba2_d[l_ac].oobacrtdt,g_ooba2_d[l_ac].oobamodid,g_ooba2_d[l_ac].oobamoddt)
                WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 
                 AND ooba002 = g_ooba_d_t.ooba002 #項次   
                    
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "ooba_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "ooba_t"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
  
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_ooba_m.ooba001
                     LET gs_keys_bak[1] = g_ooba001_t
                     LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
                     LET gs_keys_bak[2] = g_ooba_d_t.ooba002
                     CALL aooi200_update_b('ooba_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
               END CASE
               
               #add-point:單身修改後
               IF NOT aooi200_ooac_ins(l_cmd) THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               #end add-point
            END IF
         AFTER ROW
           CALL aooi200_unlock_b("ooba_t","'9'")
           CALL s_transaction_end('Y','0')

         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF cl_null(g_ooba_d[1].ooba002) THEN
               CALL g_ooba_d.deleteElement(1)
               NEXT FIELD ooba002
            END IF
            #add-point:input段after input 
            
            #end add-point    

#160818-00026#1-s mark
#從FUNCTION aooi200_input()搬到aooi200_ui_dialog()裡,改成不需要先進入修改狀態才能整批生成單別
#         ON ACTION pro_ooba
#            CALL aooi200_s01()
#160818-00026#1-e mark

         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_ooba_d.getLength()+1)
           # LET lb_reproduce = TRUE
           # LET li_reproduce = l_ac
           # LET li_reproduce_target = g_ooba_d.getLength()+1
            
      END INPUT
 
 
      
      DISPLAY ARRAY g_ooba2_d TO s_detail11.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL aooi200_b_fill('0') 
            LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail11")
            LET l_ac = g_detail_idx2
            DISPLAY g_detail_idx2 TO FORMONLY.idx
            CALL aooi200_ui_detailshow()

            LET g_bfill = "Y"
            CALL aooi200_show()
            LET g_bfill = "N"
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx2)      
         
         #add-point:page2自定義行為
         
         #end add-point
         
      END DISPLAY

      #Page1 預設值產生於此處
      INPUT ARRAY g_oobb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_1)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb_d.getLength()
            #add-point:資料輸入前
            #2015/10/14 by stellar add ----- (S)
            CALL fgl_set_arr_curr(g_detail_idx)
            #2015/10/14 by stellar add ----- (E)
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002


            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb_d[l_ac].oobb003)

            THEN
               LET l_cmd='u'
               LET g_oobb_d_t.* = g_oobb_d[l_ac].*  #BACKUP
               LET g_oobb_d_o.* = g_oobb_d[l_ac].*
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl INTO g_oobb_d[l_ac].oobb003,g_oobb_d[l_ac].oobb004,g_oobb_d[l_ac].oobb005,g_oobb_d[l_ac].oobb006,g_oobb_d[l_ac].oobb007,g_oobb_d[l_ac].oobb008
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_oobb_d_t.oobb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb_d[l_ac].* TO NULL
            LET g_oobb_d[l_ac].oobb007 = "N"


            LET g_oobb_d_t.* = g_oobb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身)


            #add-point:modify段before insert
            SELECT MAX(oobb003) INTO g_oobb_d[l_ac].oobb003 FROM oobb_t
             WHERE oobb001 = g_ooba_m.ooba001 AND oobb002 = g_ooba_d[g_detail_idx2].ooba002 AND oobbent= g_enterprise  #160905-00007#8 oobbent= g_enterprise 
            IF cl_null(g_oobb_d[l_ac].oobb003) THEN LET g_oobb_d[l_ac].oobb003 = 0 END IF
            LET g_oobb_d[l_ac].oobb003 = g_oobb_d[l_ac].oobb003 +1          {#ADP版次:1#}
            #end add-point

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

            #add-point:單身新增
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobb_t
             WHERE oobbent = g_enterprise AND oobb001 = g_ooba_m.ooba001
               AND oobb002 = g_ooba_d[g_detail_idx2].ooba002


               AND oobb003 = g_oobb_d[l_ac].oobb003


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN

               INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb_d[g_detail_idx].oobb003
               CALL aooi200_insert_b('oobb_t',gs_keys,"'1'")

               #add-point:單身新增後
               
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF

            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF

         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb_d.deleteElement(l_ac)
               NEXT FIELD oobb003
            END IF

            IF NOT cl_null(g_oobb_d[l_ac].oobb003)

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
               
               #end add-point

               DELETE FROM oobb_t
                WHERE oobbent = g_enterprise AND oobb001 = g_ooba_m.ooba001 AND
                                          oobb002 = g_ooba_d[g_detail_idx2].ooba002 AND


                      oobb003 = g_oobb_d_t.oobb003


               #add-point:單身刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb_d[g_detail_idx].oobb003


         AFTER DELETE
            #add-point:單身刪除後2
            
            #end add-point
             CALL aooi200_delete_b('oobb_t',gs_keys,"'1'")

         #---------------------<  Detail: page1  >---------------------
         #----<<oobb003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb003
            #add-point:BEFORE FIELD oobb003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb003

            #add-point:AFTER FIELD oobb003
            #此段落由子樣板a05產生
            IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_oobb_d[l_ac].oobb003 <> g_oobb_d_t.oobb003 OR cl_null(g_oobb_d_t.oobb003))) THEN
               IF NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb_d[l_ac].oobb003) THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobb_t WHERE "||"oobbent = '" ||g_enterprise|| "' AND "||"oobb001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobb002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobb003 = '"||g_oobb_d[l_ac].oobb003 ||"'",'std-00004',0) THEN
                      NEXT FIELD CURRENT
                   END IF
               END IF
            END IF  
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobb003
            #add-point:ON CHANGE oobb003
            
            #END add-point

         #----<<oobb004>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobb004

            #add-point:AFTER FIELD oobb004
            DISPLAY '' TO oobb004_desc
            IF NOT cl_null(g_oobb_d[l_ac].oobb004) THEN
               IF NOT aooi200_oobb004_chk() THEN
                  LET g_oobb_d[l_ac].oobb004 = g_oobb_d_t.oobb004
                  DISPLAY BY NAME g_oobb_d[l_ac].oobb004
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            #160313-00001#1  By Ann_Huang --- add Start ---            
            IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_oobb_d[l_ac].oobb004 <> g_oobb_d_t.oobb004 OR cl_null(g_oobb_d_t.oobb004))) THEN
               LET l_n = 0
               #是否已存在
               SELECT COUNT(*) INTO l_n FROM oobb_t
               WHERE oobb001 = g_ooba_m.ooba001  AND oobb002 = g_ooba_d[g_detail_idx2].ooba002
                 AND oobb004 = g_oobb_d[l_ac].oobb004     #欄位編號 
                 AND oobbent = g_enterprise
               IF l_n > 0 THEN              
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'aoo-00049'
                 LET g_errparam.extend = g_oobb_d[l_ac].oobb004
                 LET g_errparam.popup = TRUE
                 CALL cl_err() 
                 LET g_oobb_d[l_ac].oobb004 = g_oobb_d_t.oobb004
                 NEXT FIELD CURRENT                 
               END IF
            END IF            
            #160313-00001#1  By Ann_Huang --- add End ---            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb_d[l_ac].oobb004
            CALL ap_ref_array2(g_ref_fields,"SELECT dzebl003 FROM dzebl_t WHERE dzebl001=? AND dzebl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb_d[l_ac].oobb004_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb_d[l_ac].oobb004_desc
            
            IF NOT cl_null(g_oobb_d[l_ac].oobb004) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_oobb_d[l_ac].oobb004 <> g_oobb_d_o.oobb004 OR cl_null(g_oobb_d_o.oobb004))) THEN
               CALL aooi200_oobb004_ref()
               CALL aooi200_oobb005_desc()
               END IF
            END IF
            LET g_oobb_d_o.oobb004 = g_oobb_d[l_ac].oobb004            
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobb004
            #add-point:BEFORE FIELD oobb004
            #160816-00033#1---add---s            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb_d[l_ac].oobb004
            CALL ap_ref_array2(g_ref_fields,"SELECT dzebl003 FROM dzebl_t WHERE dzebl001=? AND dzebl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb_d[l_ac].oobb004_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb_d[l_ac].oobb004_desc 
            #160816-00033#1---add---e            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobb004
            #add-point:ON CHANGE oobb004
            
            #END add-point

         #----<<oobb005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb005
            #add-point:BEFORE FIELD oobb005
            CALL aooi200_oobb005_desc()
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb005

            #add-point:AFTER FIELD oobb005
            CALL aooi200_oobb005_desc()
            IF NOT aooi200_oobb005_chk() THEN 
               NEXT FIELD CURRENT
            END IF
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobb005
            #add-point:ON CHANGE oobb005
            
            #END add-point

         #----<<oobb006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb006
            #add-point:BEFORE FIELD oobb006
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb006

            #add-point:AFTER FIELD oobb006
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobb006
            #add-point:ON CHANGE oobb006
            
            #END add-point

         #----<<oobb007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb007
            #add-point:BEFORE FIELD oobb007
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb007

            #add-point:AFTER FIELD oobb007
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobb007
            #add-point:ON CHANGE oobb007
            
            #END add-point

         #----<<oobb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobb008
            #add-point:BEFORE FIELD oobb008
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobb008

            #add-point:AFTER FIELD oobb008
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobb008
            #add-point:ON CHANGE oobb008
            
            #END add-point


         #---------------------<  Detail: page1  >---------------------
         #----<<oobb003>>----
         #Ctrlp:input.c.page1.oobb003
#         ON ACTION controlp INFIELD oobb003
            #add-point:ON ACTION controlp INFIELD oobb003
            
            #END add-point

         #----<<oobb004>>----
         #Ctrlp:input.c.page1.oobb004
         ON ACTION controlp INFIELD oobb004
            #add-point:ON ACTION controlp INFIELD oobb004
#此段落由子樣板a07產生
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oobb_d[l_ac].oobb004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooba_d[g_detail_idx2].ooba002
            CALL q_dzeb002_6()                                #呼叫開窗

            LET g_oobb_d[l_ac].oobb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oobb_d[l_ac].oobb004 TO oobb004              #顯示到畫面上

            NEXT FIELD oobb004                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<oobb005>>----
         #Ctrlp:input.c.page1.oobb005
#         ON ACTION controlp INFIELD oobb005
            #add-point:ON ACTION controlp INFIELD oobb005
            
            #END add-point

         #----<<oobb006>>----
         #Ctrlp:input.c.page1.oobb006
#         ON ACTION controlp INFIELD oobb006
            #add-point:ON ACTION controlp INFIELD oobb006
            
            #END add-point

         #----<<oobb007>>----
         #Ctrlp:input.c.page1.oobb007
#         ON ACTION controlp INFIELD oobb007
            #add-point:ON ACTION controlp INFIELD oobb007
            
            #END add-point

         #----<<oobb008>>----
         #Ctrlp:input.c.page1.oobb008
#         ON ACTION controlp INFIELD oobb008
            #add-point:ON ACTION controlp INFIELD oobb008
            
            #END add-point



         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oobb_d[l_ac].* = g_oobb_d_t.*
               CLOSE aooi200_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_oobb_d[l_ac].oobb003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb_d[l_ac].* = g_oobb_d_t.*
            ELSE

               #add-point:單身修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身)


               UPDATE oobb_t SET (oobb001,oobb002,oobb003,oobb004,oobb005,oobb006,oobb007,oobb008) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb_d[l_ac].oobb003,g_oobb_d[l_ac].oobb004,g_oobb_d[l_ac].oobb005,g_oobb_d[l_ac].oobb006,g_oobb_d[l_ac].oobb007,g_oobb_d[l_ac].oobb008)
                WHERE oobbent = g_enterprise AND oobb001 = g_ooba_m.ooba001
                  AND oobb002 = g_ooba_d[g_detail_idx2].ooba002


                  AND oobb003 = g_oobb_d_t.oobb003 #項次


               #add-point:單身修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb_d[l_ac].* = g_oobb_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb_d[g_detail_idx].oobb003
               LET gs_keys_bak[3] = g_oobb_d_t.oobb003
               CALL aooi200_update_b('oobb_t',gs_keys,gs_keys_bak,"'1'")
                  #資料多語言用-增/改

               END IF

               #add-point:單身修改後
               
               #end add-point

            END IF

         AFTER ROW
            #add-point:單身after_row
            
            #end add-point
            CALL aooi200_unlock_b("oobb_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock


         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_2)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb2_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb2_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb2_d[l_ac].* TO NULL
            LET g_oobb2_d[l_ac].oobc004 = '0'    #160225-00012#1
            LET g_oobb2_d_t.* = g_oobb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身2)


            #add-point:modify段before insert
            
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb2_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb2_d[l_ac].oobc003)
            THEN
               LET l_cmd='u'
               LET g_oobb2_d_t.* = g_oobb2_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl2 INTO g_oobb2_d[l_ac].oobc004,g_oobb2_d[l_ac].oobc003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb2_d.deleteElement(l_ac)
               NEXT FIELD oobc003
            END IF

            IF NOT cl_null(g_oobb2_d[l_ac].oobc003)
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
               
               #end add-point

               DELETE FROM oobc_t
                WHERE oobcent = g_enterprise AND oobc001 = g_ooba_m.ooba001 AND
                                          oobc002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobc003 = g_oobb2_d_t.oobc003

               #add-point:單身2刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身2刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb2_d[g_detail_idx].oobc003


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobc_t',gs_keys,"'2'")
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

            #add-point:單身2新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobc_t
             WHERE oobcent = g_enterprise AND oobc001 = g_ooba_m.ooba001
               AND oobc002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobc003 = g_oobb2_d[l_ac].oobc003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身2新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb2_d[g_detail_idx].oobc003
               CALL aooi200_insert_b('oobc_t',gs_keys,"'2'")

               #add-point:單身新增後2
               
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb2_d[l_ac].* = g_oobb2_d_t.*
               CLOSE aooi200_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb2_d[l_ac].* = g_oobb2_d_t.*
            ELSE
               #add-point:單身page2修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身2)


               UPDATE oobc_t SET (oobc001,oobc002,oobc003,oobc004) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb2_d[l_ac].oobc003,g_oobb2_d[l_ac].oobc004) #自訂欄位頁簽
                WHERE oobcent = g_enterprise AND oobc001 = g_ooba_m.ooba001
                  AND oobc002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobc003 = g_oobb2_d_t.oobc003 #項次

               #add-point:單身page2修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb2_d[l_ac].* = g_oobb2_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb2_d[g_detail_idx].oobc003
               LET gs_keys_bak[3] = g_oobb2_d_t.oobc003
               CALL aooi200_update_b('oobc_t',gs_keys,gs_keys_bak,"'2'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page2修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page2  >---------------------
         #----<<oobc003>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobc003

            #add-point:AFTER FIELD oobc003
            #此段落由子樣板a05產生
            IF g_oobb2_d[l_ac].oobc004 = '8' THEN 
               LET g_oobb2_d[l_ac].oobc003_desc = ''
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
               CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
               LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]              
            ELSE 
               IF g_oobb2_d[l_ac].oobc004 = '7' THEN 
                  LET g_oobb2_d[l_ac].oobc003_desc = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]
               ELSE
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                  CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]                
               END IF
            END IF
            DISPLAY BY NAME g_oobb2_d[l_ac].oobc003_desc
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb2_d[l_ac].oobc003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb2_d[l_ac].oobc003 != g_oobb2_d_t.oobc003 ))) THEN
                  IF NOT aooi200_oobc003_chk() THEN
                     LET g_oobb2_d[l_ac].oobc003 = g_oobb2_d_t.oobc003
                     DISPLAY BY NAME g_oobb2_d[l_ac].oobc003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobc003
            #add-point:BEFORE FIELD oobc003
            IF g_oobb2_d[l_ac].oobc004 = '8' THEN 
               LET g_oobb2_d[l_ac].oobc003_desc = ''
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
               CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
               LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]              
            ELSE 
               IF g_oobb2_d[l_ac].oobc004 = '7' THEN 
                  LET g_oobb2_d[l_ac].oobc003_desc = ''
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]
               ELSE
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                  CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]                
               END IF
            END IF
            DISPLAY BY NAME g_oobb2_d[l_ac].oobc003_desc          
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobc003
            #add-point:ON CHANGE oobc003
            
            #END add-point
            
         #160225-00012#1
         ON CHANGE oobc004
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb2_d[l_ac].oobc003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb2_d[l_ac].oobc004 != g_oobb2_d_t.oobc004 ))) THEN
                  #INITIALIZE g_chkparam.* TO NULL                          
                  #LET g_chkparam.arg1 = g_oobb2_d[l_ac].oobc003
                  #LET g_chkparam.arg2 = g_oobb2_d[l_ac].oobc004
                  #IF NOT cl_chk_exist("v_ooha001_5") THEN
                     LET g_oobb2_d[l_ac].oobc003 = ''
                     LET g_oobb2_d[l_ac].oobc003_desc = ''
                  #  NEXT FIELD oobc003
                  #END IF                  
               END IF
            END IF
         #160225-00012#1

         #---------------------<  Detail: page2  >---------------------
         #----<<oobc003>>----
         #Ctrlp:input.c.page2.oobc003
         ON ACTION controlp INFIELD oobc003
            #add-point:ON ACTION controlp INFIELD oobc003
#此段落由子樣板a07產生
            #開窗i段
            #160914-00032#3 ---s
            INITIALIZE g_qryparam.* TO NULL   #160914-00032#3 
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #160914-00032#3--e
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oobb2_d[l_ac].oobc003             #給予default值

            #給予arg
            #若維護時,控制組類型有挑某一個值,則控制組編號開窗需要增加過濾控制組類型
            IF g_oobb2_d[l_ac].oobc004 = '8' THEN
               CALL q_ooag001()
            ELSE
               IF g_oobb2_d[l_ac].oobc004 = '7' THEN            
                  CALL q_ooeg001_9()
               ELSE
                  IF NOT cl_null(g_oobb2_d[l_ac].oobc004) AND g_oobb2_d[l_ac].oobc004 NOT MATCHES '[78]'THEN
                     LET g_qryparam.where = " ooha002='",g_oobb2_d[l_ac].oobc004 CLIPPED,"'"
                  END IF               
                  CALL q_ooha001()                                #呼叫開窗
               END IF   
            END IF 
            
            #160914-00032#3 ---s
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                     LET g_oobb2_d[l_ac].oobc003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
                  ELSE
                     LET l_multi_oobc_ins = TRUE
                     CALL aooi200_unlock_b("oobc_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
            #160914-00032#3---e
               LET g_oobb2_d[l_ac].oobc003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_oobb2_d[l_ac].oobc003 TO oobc003              #顯示到畫面上
            END IF  #160914-00032#3 
            NEXT FIELD oobc003                          #返回原欄位
            
          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page2 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb2_d[l_ac].* = g_oobb2_d_t.*
               END IF
               CLOSE aooi200_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobc_t","'2'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_3)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb3_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb3_d.getLength()
            #add-point:資料輸入前

            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb3_d[l_ac].* TO NULL

            LET g_oobb3_d_t.* = g_oobb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身3)


            #add-point:modify段before insert

            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb3_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb3_d[l_ac].oobd003)
               AND NOT cl_null(g_oobb3_d[l_ac].oobd004)

            THEN
               LET l_cmd='u'
               LET g_oobb3_d_t.* = g_oobb3_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl3 INTO g_oobb3_d[l_ac].oobd003,g_oobb3_d[l_ac].oobd004
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb3_d.deleteElement(l_ac)
               NEXT FIELD oobd003
            END IF

            IF NOT cl_null(g_oobb3_d[l_ac].oobd003)
               AND NOT cl_null(g_oobb3_d_t.oobd004)

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
               
               #end add-point

               DELETE FROM oobd_t
                WHERE oobdent = g_enterprise AND oobd001 = g_ooba_m.ooba001 AND
                                          oobd002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobd003 = g_oobb3_d_t.oobd003
                  AND oobd004 = g_oobb3_d_t.oobd004


               #add-point:單身3刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身3刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb3_d[g_detail_idx].oobd003
               LET gs_keys[4] = g_oobb3_d[g_detail_idx].oobd004


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobd_t',gs_keys,"'3'")
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

            #add-point:單身3新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobd_t
             WHERE oobdent = g_enterprise AND oobd001 = g_ooba_m.ooba001
               AND oobd002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobd003 = g_oobb3_d[l_ac].oobd003
               AND oobd004 = g_oobb3_d[l_ac].oobd004


            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身3新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb3_d[g_detail_idx].oobd003
               LET gs_keys[4] = g_oobb3_d[g_detail_idx].oobd004
               CALL aooi200_insert_b('oobd_t',gs_keys,"'3'")

               #add-point:單身新增後3
               
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobd_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb3_d[l_ac].* = g_oobb3_d_t.*
               CLOSE aooi200_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb3_d[l_ac].* = g_oobb3_d_t.*
            ELSE
               #add-point:單身page3修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身3)


               UPDATE oobd_t SET (oobd001,oobd002,oobd003,oobd004) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb3_d[l_ac].oobd003,g_oobb3_d[l_ac].oobd004) #自訂欄位頁簽
                WHERE oobdent = g_enterprise AND oobd001 = g_ooba_m.ooba001
                  AND oobd002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobd003 = g_oobb3_d_t.oobd003 #項次
                  AND oobd004 = g_oobb3_d_t.oobd004


               #add-point:單身page3修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb3_d[l_ac].* = g_oobb3_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb3_d[g_detail_idx].oobd003
               LET gs_keys_bak[3] = g_oobb3_d_t.oobd003
               LET gs_keys[4] = g_oobb3_d[g_detail_idx].oobd004
               LET gs_keys_bak[4] = g_oobb3_d_t.oobd004
               CALL aooi200_update_b('oobd_t',gs_keys,gs_keys_bak,"'3'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page3修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page3  >---------------------
         #----<<oobd003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oobd003
            #add-point:BEFORE FIELD oobd003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oobd003

            #add-point:AFTER FIELD oobd003
            #此段落由子樣板a05產生
            IF NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb3_d[l_ac].oobd003) AND NOT cl_null(g_oobb3_d[l_ac].oobd004) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb3_d[l_ac].oobd003 != g_oobb3_d_t.oobd003 OR g_oobb3_d[l_ac].oobd004 != g_oobb3_d_t.oobd004))) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobd_t WHERE "||"oobdent = '" ||g_enterprise|| "' AND "||"oobd001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobd002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobd003 = '"||g_oobb3_d[l_ac].oobd003 ||"' AND "|| "oobd004 = '"||g_oobb3_d[l_ac].oobd004 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oobd003
            #add-point:ON CHANGE oobd003
            
            #END add-point

         #----<<oobd004>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobd004

            #add-point:AFTER FIELD oobd004
            #此段落由子樣板a05產生
            DISPLAY '' TO oobd004_desc
            IF NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb3_d[l_ac].oobd003) AND NOT cl_null(g_oobb3_d[l_ac].oobd004) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb3_d[l_ac].oobd003 != g_oobb3_d_t.oobd003 OR g_oobb3_d[l_ac].oobd004 != g_oobb3_d_t.oobd004))) THEN
                  IF NOT aooi200_oobd004_chk() THEN
                     LET g_oobb3_d[l_ac].oobd004 = g_oobb3_d_t.oobd004
                     #dorislai-20150828-add---(S)
                     IF g_oobb3_d[l_ac].oobd004 = g_oobb3_d_t.oobd004 THEN
                        LET g_oobb3_d[l_ac].oobd004 = ''
                     END IF  
                     #dorislai-20150828-add---(E)                     
                     DISPLAY BY NAME g_oobb3_d[l_ac].oobd004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb3_d[l_ac].oobd003
            LET g_ref_fields[2] = g_oobb3_d[l_ac].oobd004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb3_d[l_ac].oobd004_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb3_d[l_ac].oobd004_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobd004
            #add-point:BEFORE FIELD oobd004
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb3_d[l_ac].oobd003
            LET g_ref_fields[2] = g_oobb3_d[l_ac].oobd004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb3_d[l_ac].oobd004_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb3_d[l_ac].oobd004_desc            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobd004
            #add-point:ON CHANGE oobd004
            
            #END add-point


         #---------------------<  Detail: page3  >---------------------
         #----<<oobd003>>----
         #Ctrlp:input.c.page3.oobd003
#         ON ACTION controlp INFIELD oobd003
            #add-point:ON ACTION controlp INFIELD oobd003
            
            #END add-point

         #----<<oobd004>>----
         #Ctrlp:input.c.page3.oobd004
         ON ACTION controlp INFIELD oobd004
            #add-point:ON ACTION controlp INFIELD oobd004
            #此段落由子樣板a07產生
            #開窗i段
            #dorislai-20150827-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #dorislai-20150827-add----(E)
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oobb3_d[l_ac].oobd004             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_oobb3_d[l_ac].oobd003   #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #dorislai-20150831-add
            CALL q_oocq002()                                #呼叫開窗
            #dorislai-20150827-modify----(S)
#            INITIALIZE g_qryparam.arg1 TO null
#            LET g_oobb3_d[l_ac].oobd004 = g_qryparam.return1              #將開窗取得的值回傳到變數
#
#            DISPLAY g_oobb3_d[l_ac].oobd004 TO oobd004              #顯示到畫面上
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                     LET g_oobb3_d[l_ac].oobd004 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
                  ELSE
                     LET l_multi_oobd_ins = TRUE
                     CALL aooi200_unlock_b("oobd_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_oobb3_d[l_ac].oobd004 = g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            
            #dorislai-20150827-modify----(E)
            NEXT FIELD oobd004                          #返回原欄位

          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page3 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb3_d[l_ac].* = g_oobb3_d_t.*
               END IF
               CLOSE aooi200_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobd_t","'3'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
         #end add-point

      END INPUT

      INPUT ARRAY g_oobb4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_4)


         BEFORE INPUT          
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb4_d.getLength()+1)
              LET g_insert = 'N'
            END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb4_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb4_d[l_ac].* TO NULL

            LET g_oobb4_d_t.* = g_oobb4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身4)


            #add-point:modify段before insert
            
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb4_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb4_d[l_ac].oobh003)
            THEN
               LET l_cmd='u'
               LET g_oobb4_d_t.* = g_oobb4_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobh_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl4 INTO g_oobb4_d[l_ac].oobh003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb4_d.deleteElement(l_ac)
               NEXT FIELD oobh003
            END IF

            IF NOT cl_null(g_oobb4_d[l_ac].oobh003)
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
               
               #end add-point

               DELETE FROM oobh_t
                WHERE oobhent = g_enterprise AND oobh001 = g_ooba_m.ooba001 AND
                                          oobh002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobh003 = g_oobb4_d_t.oobh003

               #add-point:單身4刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身4刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb4_d[g_detail_idx].oobh003


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobh_t',gs_keys,"'4'")
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

            #add-point:單身4新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobh_t
             WHERE oobhent = g_enterprise AND oobh001 = g_ooba_m.ooba001
               AND oobh002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobh003 = g_oobb4_d[l_ac].oobh003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身4新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb4_d[g_detail_idx].oobh003
               CALL aooi200_insert_b('oobh_t',gs_keys,"'4'")

               #add-point:單身新增後4
          {#ADP版次:1#}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobh_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb4_d[l_ac].* = g_oobb4_d_t.*
               CLOSE aooi200_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb4_d[l_ac].* = g_oobb4_d_t.*
            ELSE
               #add-point:單身page4修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身4)


               UPDATE oobh_t SET (oobh001,oobh002,oobh003) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb4_d[l_ac].oobh003) #自訂欄位頁簽
                WHERE oobhent = g_enterprise AND oobh001 = g_ooba_m.ooba001
                  AND oobh002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobh003 = g_oobb4_d_t.oobh003 #項次

               #add-point:單身page4修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb4_d[l_ac].* = g_oobb4_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb4_d[g_detail_idx].oobh003
               LET gs_keys_bak[3] = g_oobb4_d_t.oobh003
               CALL aooi200_update_b('oobh_t',gs_keys,gs_keys_bak,"'4'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page4修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page4  >---------------------
         #----<<oobh003>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobh003

            #add-point:AFTER FIELD oobh003
            #此段落由子樣板a05產生
            DISPLAY '' TO oobh003_desc
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb4_d[l_ac].oobh003) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb4_d[l_ac].oobh003 != g_oobb4_d_t.oobh003))) THEN
                   IF NOT aooi200_oobh003_chk() THEN
                      LET g_oobb4_d[l_ac].oobh003 = g_oobb4_d_t.oobh003
                      DISPLAY BY NAME g_oobb4_d[l_ac].oobh003
                      NEXT FIELD CURRENT
                   END IF
                END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb4_d[l_ac].oobh003
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb4_d[l_ac].oobh003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb4_d[l_ac].oobh003_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobh003
            #add-point:BEFORE FIELD oobh003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb4_d[l_ac].oobh003
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb4_d[l_ac].oobh003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb4_d[l_ac].oobh003_desc            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobh003
            #add-point:ON CHANGE oobh003
            
            #END add-point


         #---------------------<  Detail: page4  >---------------------
         #----<<oobh003>>----
         #Ctrlp:input.c.page4.oobh003
         ON ACTION controlp INFIELD oobh003
            #add-point:ON ACTION controlp INFIELD oobh003
            #此段落由子樣板a07產生
            #開窗i段
            #dorislai-20150828-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #dorislai-20150828-add----(E)
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oobb4_d[l_ac].oobh003             #給予default值
            #給予arg
            CALL q_rtax001()                                #呼叫開窗
            #dorislai-20150828-modify----(S)
#            LET g_oobb4_d[l_ac].oobh003 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_oobb4_d[l_ac].oobh003 TO oobh003              #顯示到畫面上
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET g_oobb4_d[l_ac].oobh003 = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                  ELSE
                     LET l_multi_oobh_ins = TRUE
                     CALL aooi200_unlock_b("oobh_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_oobb4_d[l_ac].oobh003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            #dorislai-20150828-modify----(E)
            DISPLAY BY NAME g_oobb4_d[l_ac].oobh003     #add by lixh 20160108 151228-00005/1
            NEXT FIELD oobh003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page4 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb4_d[l_ac].* = g_oobb4_d_t.*
               END IF
               CLOSE aooi200_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobh_t","'4'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_5)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb5_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb5_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb5_d[l_ac].* TO NULL

            LET g_oobb5_d_t.* = g_oobb5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身5)


            #add-point:modify段before insert
            
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb5_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb5_d[l_ac].oobj003)
            THEN
               LET l_cmd='u'
               LET g_oobb5_d_t.* = g_oobb5_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobj_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl5 INTO g_oobb5_d[l_ac].oobj003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb5_d.deleteElement(l_ac)
               NEXT FIELD oobj003
            END IF

            IF NOT cl_null(g_oobb5_d[l_ac].oobj003)
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
               
               #end add-point

               DELETE FROM oobj_t
                WHERE oobjent = g_enterprise AND oobj001 = g_ooba_m.ooba001 AND
                                          oobj002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobj003 = g_oobb5_d_t.oobj003

               #add-point:單身5刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身5刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb5_d[g_detail_idx].oobj003


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobj_t',gs_keys,"'5'")
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

            #add-point:單身5新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobj_t
             WHERE oobjent = g_enterprise AND oobj001 = g_ooba_m.ooba001
               AND oobj002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobj003 = g_oobb5_d[l_ac].oobj003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身5新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb5_d[g_detail_idx].oobj003
               CALL aooi200_insert_b('oobj_t',gs_keys,"'5'")

               #add-point:單身新增後5
               
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobj_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb5_d[l_ac].* = g_oobb5_d_t.*
               CLOSE aooi200_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb5_d[l_ac].* = g_oobb5_d_t.*
            ELSE
               #add-point:單身page5修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身5)


               UPDATE oobj_t SET (oobj001,oobj002,oobj003) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb5_d[l_ac].oobj003) #自訂欄位頁簽
                WHERE oobjent = g_enterprise AND oobj001 = g_ooba_m.ooba001
                  AND oobj002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobj003 = g_oobb5_d_t.oobj003 #項次

               #add-point:單身page5修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb5_d[l_ac].* = g_oobb5_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb5_d[g_detail_idx].oobj003
               LET gs_keys_bak[3] = g_oobb5_d_t.oobj003
               CALL aooi200_update_b('oobj_t',gs_keys,gs_keys_bak,"'5'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page5修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page5  >---------------------
         #----<<oobj003>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobj003

            #add-point:AFTER FIELD oobj003
            #此段落由子樣板a05產生
            DISPLAY '' TO oobj003_desc
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb5_d[l_ac].oobj003) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb5_d[l_ac].oobj003 != g_oobb5_d_t.oobj003))) THEN
                  IF NOT aooi200_oobj003_chk() THEN
                     LET g_oobb5_d[l_ac].oobj003 = g_oobb5_d_t.oobj003
                     DISPLAY BY NAME g_oobb5_d[l_ac].oobj003
                     NEXT FIELD CURRENT
                  END IF
                END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb5_d[l_ac].oobj003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb5_d[l_ac].oobj003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb5_d[l_ac].oobj003_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobj003
            #add-point:BEFORE FIELD oobj003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb5_d[l_ac].oobj003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb5_d[l_ac].oobj003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb5_d[l_ac].oobj003_desc            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobj003
            #add-point:ON CHANGE oobj003
            
            #END add-point


         #---------------------<  Detail: page5  >---------------------
         #----<<oobj003>>----
         #Ctrlp:input.c.page5.oobj003
         ON ACTION controlp INFIELD oobj003
            #add-point:ON ACTION controlp INFIELD oobj003
            #此段落由子樣板a07產生
            #開窗i段
            #dorislai-20150828-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #dorislai-20150828-add----(E)
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oobb5_d[l_ac].oobj003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "220" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #dorislai-20150831-add
            CALL q_oocq002()                                #呼叫開窗
            #dorislai-20150828-modify----(S)
#            INITIALIZE g_qryparam.arg1 TO NULL
#            LET g_oobb5_d[l_ac].oobj003 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_oobb5_d[l_ac].oobj003 TO oobj003              #顯示到畫面上
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                     LET g_oobb5_d[l_ac].oobj003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
                  ELSE
                     LET l_multi_oobj_ins = TRUE
                     CALL aooi200_unlock_b("oobj_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_oobb5_d[l_ac].oobj003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            #dorislai-20150828-modify----(E)
            NEXT FIELD oobj003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page5 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb5_d[l_ac].* = g_oobb5_d_t.*
               END IF
               CLOSE aooi200_bcl5
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobj_t","'5'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_6)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb6_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb6_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb6_d[l_ac].* TO NULL

            LET g_oobb6_d_t.* = g_oobb6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身6)


            #add-point:modify段before insert
            
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb6_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb6_d[l_ac].oobk003)
            THEN
               LET l_cmd='u'
               LET g_oobb6_d_t.* = g_oobb6_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobk_t","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl6 INTO g_oobb6_d[l_ac].oobk003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb6_d.deleteElement(l_ac)
               NEXT FIELD oobk003
            END IF

            IF NOT cl_null(g_oobb6_d[l_ac].oobk003)
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

               #add-point:單身6刪除前
               
               #end add-point

               DELETE FROM oobk_t
                WHERE oobkent = g_enterprise AND oobk001 = g_ooba_m.ooba001 AND
                                          oobk002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobk003 = g_oobb6_d_t.oobk003

               #add-point:單身6刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身6刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb6_d[g_detail_idx].oobk003


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobk_t',gs_keys,"'6'")
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

            #add-point:單身6新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobk_t
             WHERE oobkent = g_enterprise AND oobk001 = g_ooba_m.ooba001
               AND oobk002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobk003 = g_oobb6_d[l_ac].oobk003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身6新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb6_d[g_detail_idx].oobk003
               CALL aooi200_insert_b('oobk_t',gs_keys,"'6'")

               #add-point:單身新增後6
               
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobk_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb6_d[l_ac].* = g_oobb6_d_t.*
               CLOSE aooi200_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb6_d[l_ac].* = g_oobb6_d_t.*
            ELSE
               #add-point:單身page6修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身6)


               UPDATE oobk_t SET (oobk001,oobk002,oobk003) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb6_d[l_ac].oobk003) #自訂欄位頁簽
                WHERE oobkent = g_enterprise AND oobk001 = g_ooba_m.ooba001
                  AND oobk002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobk003 = g_oobb6_d_t.oobk003 #項次

               #add-point:單身page6修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb6_d[l_ac].* = g_oobb6_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb6_d[g_detail_idx].oobk003
               LET gs_keys_bak[3] = g_oobb6_d_t.oobk003
               CALL aooi200_update_b('oobk_t',gs_keys,gs_keys_bak,"'6'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page6修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page6  >---------------------
         #----<<oobk003>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobk003

            #add-point:AFTER FIELD oobk003
            #此段落由子樣板a05產生
            DISPLAY '' TO oobk003_desc
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb6_d[l_ac].oobk003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb6_d[l_ac].oobk003 != g_oobb6_d_t.oobk003))) THEN
                  IF NOT aooi200_oobk003_chk() THEN
                     LET g_oobb6_d[l_ac].oobk003 = g_oobb6_d_t.oobk003
                     DISPLAY BY NAME g_oobb6_d[l_ac].oobk003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb6_d[l_ac].oobk003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb6_d[l_ac].oobk003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb6_d[l_ac].oobk003_desc

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobk003
            #add-point:BEFORE FIELD oobk003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb6_d[l_ac].oobk003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb6_d[l_ac].oobk003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb6_d[l_ac].oobk003_desc            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobk003
            #add-point:ON CHANGE oobk003
            
            #END add-point


         #---------------------<  Detail: page6  >---------------------
         #----<<oobk003>>----
         #Ctrlp:input.c.page6.oobk003
         ON ACTION controlp INFIELD oobk003
            #add-point:ON ACTION controlp INFIELD oobk003
            #此段落由子樣板a07產生
            #開窗i段
            #dorislai-20150828-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #dorislai-20150828-add----(E)
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oobb6_d[l_ac].oobk003             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "220" #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #dorislai-20150831-add
            CALL q_oocq002()                                #呼叫開窗
            #dorislai-20150828-modify----(S)
#            INITIALIZE g_qryparam.arg1 TO NULL
#            LET g_oobb6_d[l_ac].oobk003 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_oobb6_d[l_ac].oobk003 TO oobk003              #顯示到畫面上
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                     LET g_oobb6_d[l_ac].oobk003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
                  ELSE
                     LET l_multi_oobk_ins = TRUE
                     CALL aooi200_unlock_b("oobk_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_oobb6_d[l_ac].oobk003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            #dorislai-20150828-modify----(E)
            NEXT FIELD oobk003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page6 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb6_d[l_ac].* = g_oobb6_d_t.*
               END IF
               CLOSE aooi200_bcl6
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobk_t","'6'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_7)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
               CALL FGL_SET_ARR_CURR(g_oobb7_d.getLength()+1)
               LET g_insert = 'N'
            END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb7_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         BEFORE INSERT

            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_oobb7_d[l_ac].* TO NULL

            LET g_oobb7_d_t.* = g_oobb7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aooi200_set_entry_b(l_cmd)
            CALL aooi200_set_no_entry_b(l_cmd)
            #公用欄位給值(單身7)


            #add-point:modify段before insert
            
            #end add-point

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb7_d.getLength()

            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb7_d[l_ac].oobi003)
            THEN
               LET l_cmd='u'
               LET g_oobb7_d_t.* = g_oobb7_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("oobi_t","'7'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl7 INTO g_oobb7_d[l_ac].oobi003
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"

                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_oobb7_d.deleteElement(l_ac)
               NEXT FIELD oobi003
            END IF

            IF NOT cl_null(g_oobb7_d[l_ac].oobi003)
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

               #add-point:單身7刪除前
               
               #end add-point

               DELETE FROM oobi_t
                WHERE oobient = g_enterprise AND oobi001 = g_ooba_m.ooba001 AND
                                          oobi002 = g_ooba_d[g_detail_idx2].ooba002 AND

                      oobi003 = g_oobb7_d_t.oobi003

               #add-point:單身7刪除中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oobb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1

                  #add-point:單身7刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF
               CLOSE aooi200_bcl
               LET l_count = g_oobb_d.getLength()
            END IF

                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb7_d[g_detail_idx].oobi003


         AFTER DELETE
            #add-point:單身AFTER DELETE
            
            #end add-point
                           CALL aooi200_delete_b('oobi_t',gs_keys,"'7'")
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

            #add-point:單身7新增前
            
            #end add-point

            LET l_count = 1
            SELECT COUNT(*) INTO l_count FROM oobi_t
             WHERE oobient = g_enterprise AND oobi001 = g_ooba_m.ooba001
               AND oobi002 = g_ooba_d[g_detail_idx2].ooba002

               AND oobi003 = g_oobb7_d[l_ac].oobi003

            #資料未重複, 插入新增資料
            IF l_count = 0 THEN
               #add-point:單身7新增前
               
               #end add-point

                              INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys[3] = g_oobb7_d[g_detail_idx].oobi003
               CALL aooi200_insert_b('oobi_t',gs_keys,"'7'")

               #add-point:單身新增後7
          {#ADP版次:1#}
               #end add-point
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oobb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oobi_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aooi200_b_fill()
               #資料多語言用-增/改

               #add-point:單身新增後
               
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
               LET g_oobb7_d[l_ac].* = g_oobb7_d_t.*
               CLOSE aooi200_bcl7
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb7_d[l_ac].* = g_oobb7_d_t.*
            ELSE
               #add-point:單身page7修改前
               
               #end add-point

               #寫入修改者/修改日期資訊(單身7)


               UPDATE oobi_t SET (oobi001,oobi002,oobi003) = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb7_d[l_ac].oobi003) #自訂欄位頁簽
                WHERE oobient = g_enterprise AND oobi001 = g_ooba_m.ooba001
                  AND oobi002 = g_ooba_d[g_detail_idx2].ooba002

                  AND oobi003 = g_oobb7_d_t.oobi003 #項次

               #add-point:單身page7修改中
               
               #end add-point

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb7_d[l_ac].* = g_oobb7_d_t.*
               ELSE
                                 INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb7_d[g_detail_idx].oobi003
               LET gs_keys_bak[3] = g_oobb7_d_t.oobi003
               CALL aooi200_update_b('oobi_t',gs_keys,gs_keys_bak,"'7'")
                  #資料多語言用-增/改

               END IF
               #add-point:單身page7修改後
               
               #end add-point
            END IF

         #---------------------<  Detail: page7  >---------------------
         #----<<oobi003>>----
         #此段落由子樣板a02產生
         AFTER FIELD oobi003

            #add-point:AFTER FIELD oobi003
            #此段落由子樣板a05產生
            DISPLAY '' TO oobi003_desc
            IF  NOT cl_null(g_ooba_m.ooba001) AND NOT cl_null(g_ooba_d[g_detail_idx2].ooba002) AND NOT cl_null(g_oobb7_d[l_ac].oobi003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooba_m.ooba001 != g_ooba001_t OR g_ooba_d[g_detail_idx2].ooba002 != g_ooba_d_t.ooba002 OR g_oobb7_d[l_ac].oobi003 != g_oobb7_d_t.oobi003))) THEN
                  IF NOT aooi200_oobi003_chk() THEN
                     LET g_oobb7_d[l_ac].oobi003 = g_oobb7_d_t.oobi003
                     DISPLAY BY NAME g_oobb7_d[l_ac].oobi003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb7_d[l_ac].oobi003
            #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003  #160816-00001#6 mark
            LET l_acc = s_fin_get_scc_value('24',g_ooba_d[g_detail_idx2].oobx003,'2')  #160816-00001#6  Add
            
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||l_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb7_d[l_ac].oobi003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb7_d[l_ac].oobi003_desc

          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oobi003
            #add-point:BEFORE FIELD oobi003
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oobb7_d[l_ac].oobi003
            #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003   #160816-00001#6 mark
            LET l_acc = s_fin_get_scc_value('24',g_ooba_d[g_detail_idx2].oobx003,'2')  #160816-00001#6  Add
            
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||l_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oobb7_d[l_ac].oobi003_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oobb7_d[l_ac].oobi003_desc            
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oobi003
            #add-point:ON CHANGE oobi003
            
            #END add-point


         #---------------------<  Detail: page7  >---------------------
         #----<<oobi003>>----
         #Ctrlp:input.c.page7.oobi003
         ON ACTION controlp INFIELD oobi003
            #add-point:ON ACTION controlp INFIELD oobi003
            #此段落由子樣板a07產生
            #開窗i段
            #dorislai-20150828-add----(S)
            INITIALIZE g_qryparam.* TO NULL
            IF l_cmd = 'a' THEN
               LET g_qryparam.state = 'm'
            ELSE
               LET g_qryparam.state = 'i'
            END IF
            #dorislai-20150828-add----(E)
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_oobb7_d[l_ac].oobi003             #給予default值
            #給予arg
            #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003   #160816-00001#6 mark
            LET l_acc = s_fin_get_scc_value('24',g_ooba_d[g_detail_idx2].oobx003,'2')  #160816-00001#6  Add
            
            LET g_qryparam.arg1 = l_acc #應用分類
            LET g_qryparam.where = " oocqstus = 'Y'"        #dorislai-20150831-add
            CALL q_oocq002()                                #呼叫開窗
            #dorislai-20150828-modify----(S)
#            INITIALIZE g_qryparam.arg1 TO NULL
#            LET g_oobb7_d[l_ac].oobi003 = g_qryparam.return1              #將開窗取得的值回傳到變數
#            DISPLAY g_oobb7_d[l_ac].oobi003 TO oobi003              #顯示到畫面上
            IF l_cmd = 'a' THEN
               IF g_qryparam.str_array.getLength() > 0 THEN
                  IF g_qryparam.str_array.getLength() = 1 THEN
                     LET l_str = g_qryparam.str_array[1]           #將開窗取得的值回傳到變數 
                     LET g_oobb7_d[l_ac].oobi003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
                  ELSE
                     LET l_multi_oobi_ins = TRUE
                     CALL aooi200_unlock_b("oobi_t","'2'")
                     CALL s_transaction_end('Y','0')
                     EXIT DIALOG
                  END IF
               END IF
            ELSE
               IF NOT cl_null(g_qryparam.return1) THEN
                  LET g_oobb7_d[l_ac].oobi003 = g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            
            #dorislai-20150828-modify----(E)
            DISPLAY BY NAME g_oobb7_d[l_ac].oobi003     #add by lixh 20160108 151228-00005/1
            NEXT FIELD oobi003                          #返回原欄位

          {#ADP版次:1#}
            #END add-point



         AFTER ROW
            #add-point:單身page7 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb7_d[l_ac].* = g_oobb7_d_t.*
               END IF
               CLOSE aooi200_bcl7
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("oobi_t","'7'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      INPUT ARRAY g_oobb8_d FROM s_detail8.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效!
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)

         #自訂ACTION(detail_input,page_8)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_oobb8_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            #CALL aooi200_b_fill()
            LET g_rec_b = g_oobb8_d.getLength()
            #add-point:資料輸入前
            
            #end add-point

         

         BEFORE ROW
            LET l_insert = FALSE
#            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            CALL s_transaction_begin()
            OPEN aooi200_bcl9 USING g_enterprise,g_ooba_m.ooba001
                                                                ,g_ooba_d[g_detail_idx2].ooba002
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN aooi200_bcl9:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CLOSE aooi200_bcl9
               CALL s_transaction_end('N','0')
               RETURN
            END IF

            #FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.ooacownid,g_ooba_m.ooacowndp,g_ooba_m.ooaccrtid,g_ooba_m.ooaccrtdp,g_ooba_m.ooaccrtdt,g_ooba_m.ooacmoddt,g_ooba_m.oobg003,g_ooba_m.oobg004,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015 # 鎖住將被更改或取消的資料
            #IF SQLCA.sqlcode THEN
            #   CALL cl_err(g_ooba_m.ooba001,SQLCA.sqlcode,0)
            #   CLOSE aooi200_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF

            LET g_rec_b = g_oobb8_d.getLength()
            
            
            
            IF g_rec_b >= l_ac
               AND NOT cl_null(g_oobb8_d[l_ac].ooac003)
            THEN
               LET l_cmd='u'
               LET g_oobb8_d_t.* = g_oobb8_d[l_ac].*  #BACKUP
               CALL aooi200_set_entry_b(l_cmd)
               CALL aooi200_set_no_entry_b(l_cmd)
               IF NOT aooi200_lock_b("ooac_t","'8'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi200_bcl8 INTO g_oobb8_d[l_ac].ooac003,g_oobb8_d[l_ac].ooac004
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF

                  LET g_bfill = "N"
                  CALL aooi200_show()
                  LET g_bfill = "Y"
                  SELECT gzsz016 INTO l_gzsz016 FROM gzsz_t WHERE gzsz001 = 'ooac_t' AND gzsz002 = g_oobb8_d[l_ac].ooac003
                  CALL aooi200_gzcb_fill(l_gzsz016)
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point
            #其他table資料備份(確定是否更改用)

            #其他table進行lock

         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oobb8_d[l_ac].* = g_oobb8_d_t.*
               CLOSE aooi200_bcl8
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oobb8_d[l_ac].* = g_oobb8_d_t.*
            ELSE

               #寫入修改者/修改日期資訊(單身8)
               LET l_ooacmodid = g_user
               LET l_ooacmoddt = cl_get_current()        
           
               UPDATE ooac_t SET (ooac001,ooac002,ooac003,ooac004,ooacmodid,ooacmoddt)
                               = (g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb8_d[l_ac].ooac003,
                                  g_oobb8_d[l_ac].ooac004,l_ooacmodid,l_ooacmoddt) #自訂欄位頁簽
                WHERE ooacent = g_enterprise AND ooac001 = g_ooba_m.ooba001
                  AND ooac002 = g_ooba_d[g_detail_idx2].ooba002
                  AND ooac003 = g_oobb8_d_t.ooac003 #參數編號
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_oobb8_d[l_ac].* = g_oobb8_d_t.*
               ELSE
               
               INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_ooba_m.ooba001
               LET gs_keys_bak[1] = g_ooba001_t
               LET gs_keys[2] = g_ooba_d[g_detail_idx2].ooba002
               LET gs_keys_bak[2] = g_ooba_d_t.ooba002
               LET gs_keys[3] = g_oobb8_d[g_detail_idx].ooac003
               LET gs_keys_bak[3] = g_oobb8_d_t.ooac003
               CALL aooi200_update_b('ooac_t',gs_keys,gs_keys_bak,"'8'")
                  #資料多語言用-增/改

               END IF

            END IF

         #此段落由子樣板a01產生
         BEFORE FIELD ooac004
            #add-point:BEFORE FIELD ooac004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooac004

            IF NOT cl_null(g_oobb8_d[l_ac].ooac004) THEN
               #150414 by whitney modify start
               CALL aooi200_ooac004_chk() RETURNING l_gzcb001,l_gzcal003
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  IF g_errno = 'azz-00023' THEN
                     LET g_errparam.extend = l_gzcal003," = ",g_oobb8_d[l_ac].ooac004
                     LET g_errparam.replace[1] = l_gzcb001
                  END IF
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               #150414 by whitney modify end
                  LET g_oobb8_d[l_ac].ooac004 = g_oobb8_d_t.ooac004
                  DISPLAY BY NAME g_oobb8_d[l_ac].ooac004
                  NEXT FIELD ooac004
               END IF
            END IF


         #此段落由子樣板a04產生
         ON CHANGE ooac004
            #add-point:ON CHANGE ooac004
            
            #END add-point


         AFTER ROW
            #add-point:單身page8 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_oobb8_d[l_ac].* = g_oobb8_d_t.*
               END IF
               CLOSE aooi200_bcl8
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            #其他table進行unlock

            CALL aooi200_unlock_b("ooac_t","'8'")
            CALL s_transaction_end('Y','0')

         AFTER INPUT
            #add-point:input段after input
            
            #end add-point

      END INPUT

      DISPLAY ARRAY g_oobb9_d TO s_detail9.* ATTRIBUTES(COUNT=g_rec_b)

           BEFORE ROW
              LET l_ac = DIALOG.getCurrentRow("s_detail9")
              LET g_detail_idx = l_ac



           BEFORE DISPLAY
              CALL FGL_SET_ARR_CURR(g_detail_idx)
              LET l_ac = DIALOG.getCurrentRow("s_detail9")

           #自訂ACTION(detail_show,page_7)

        END DISPLAY

      BEFORE DIALOG
         #add-point:input段before dialog
#20151103 by stellar mark 151103-00012#1 ----- (S)
#stellar mark:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#         #add by lixh 20150703 150702-00006#7
#         IF p_cmd = 'a' THEN
#            NEXT FIELD oobastus
#         ELSE
#            CASE g_aw
#               WHEN "s_detail10"
#                  NEXT FIELD ooba002
#               WHEN "s_detail8"
#                  NEXT FIELD ooac004
#               WHEN "s_detail1"
#                  NEXT FIELD oobb003
#               WHEN "s_detail2"
#                  NEXT FIELD oobc003
#               WHEN "s_detail3"
#                  NEXT FIELD oobd003
#               WHEN "s_detail4"
#                  NEXT FIELD oobh003
#               WHEN "s_detail5"
#                  NEXT FIELD oobj003
#               WHEN "s_detail6"
#                  NEXT FIELD oobk003 
#               WHEN "s_detail7"
#                  NEXT FIELD oobi003                   
#            END CASE            
#         END IF  
#         #add by lixh 20150703 150702-00006#7    
#20151103 by stellar mark 151103-00012#1 ----- (E)     
         #end add-point
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD ooba001
         ELSE
            CASE g_aw
               WHEN "s_detail10"
                  NEXT FIELD ooba002
               WHEN "s_detail8"
                  NEXT FIELD ooac004
               WHEN "s_detail1"
                  NEXT FIELD oobb003
               WHEN "s_detail2"
                  NEXT FIELD oobc003
               WHEN "s_detail3"
                  NEXT FIELD oobd003
               WHEN "s_detail4"
                  NEXT FIELD oobh003
               WHEN "s_detail5"
                  NEXT FIELD oobj003
               WHEN "s_detail6"
                  NEXT FIELD oobk003 
               WHEN "s_detail7"
                  NEXT FIELD oobi003                   
            END CASE            
         END IF

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_dlang)

      ON ACTION controlr
         CALL cl_show_req_fields()
         
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
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
   #dorislai-20150827-add----(S) 
      #160914-00032#3 ---s
      #控制组限定
      IF l_multi_oobc_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_oobc003 = g_qryparam.str_array[l_i]
            #重覆性檢查 
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM oobc_t
             WHERE oobcent = g_enterprise
               AND oobc001 = g_ooba_m.ooba001
               AND oobc002 = g_ooba_d[g_detail_idx2].ooba002
               AND oobc003 = l_oobc003
               AND oobc004 = g_oobb2_d[l_ac].oobc004
               
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF

            INSERT INTO oobc_t(oobcent,oobc001,oobc002,oobc003,oobc004)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_oobc003,g_oobb2_d[l_ac].oobc004)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      #160914-00032#3 ---e
      #----------生命週期限定----------
      IF l_multi_oobd_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_str = g_qryparam.str_array[l_i]
            LET l_oobd004 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
            #重覆性檢查 
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM oobd_t
             WHERE oobdent = g_enterprise
               AND oobd001 = g_ooba_m.ooba001
               AND oobd002 = g_ooba_d[g_detail_idx2].ooba002
               AND oobd003 = g_oobb3_d[l_ac].oobd003
               AND oobd004 = l_oobd004
               
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF
     
            IF NOT s_azzi650_chk_exist(g_oobb3_d[l_ac].oobd003,l_oobd004) THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO oobd_t(oobdent,oobd001,oobd002,oobd003,oobd004)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb3_d[l_ac].oobd003,l_oobd004)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      #----------產品分類限定----------
      IF l_multi_oobh_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_oobh003 = g_qryparam.str_array[l_i]           
            #重覆性檢查 
            LET l_cnt = 0

            SELECT COUNT(*) INTO l_cnt 
              FROM oobh_t
             WHERE oobhent = g_enterprise 
               AND oobh001 = g_ooba_m.ooba001
               AND oobh002 = g_ooba_d[g_detail_idx2].ooba002            
               AND oobh003 = l_oobh003
   
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF
            
            LET g_errshow = TRUE #是否開窗 #160318-00025#30  add
            LET g_chkparam.arg1 = l_oobh003
            LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"#要執行的建議程式待補 #160318-00025#30  add
            IF NOT cl_chk_exist("v_rtax001") THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO oobh_t(oobhent,oobh001,oobh002,oobh003)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_oobh003)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      #----------庫存標籤(Tag)限定(From)----------
      IF l_multi_oobj_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_str = g_qryparam.str_array[l_i]           
            LET l_oobj003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
            #重覆性檢查 
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt 
              FROM oobj_t
             WHERE oobjent = g_enterprise 
               AND oobj001 = g_ooba_m.ooba001
               AND oobj002 = g_ooba_d[g_detail_idx2].ooba002
               AND oobj003 = l_oobj003
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF

            IF NOT s_azzi650_chk_exist('220',l_oobj003) THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO oobj_t(oobjent,oobj001,oobj002,oobj003)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_oobj003)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      #----------庫存標籤(Tag)限定(To)----------
      IF l_multi_oobk_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_str = g_qryparam.str_array[l_i]           
            LET l_oobk003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
            #重覆性檢查 
             SELECT COUNT(*) INTO l_cnt 
               FROM oobk_t
              WHERE oobkent = g_enterprise 
                AND oobk001 = g_ooba_m.ooba001
                AND oobk002 = g_ooba_d[g_detail_idx2].ooba002
                AND oobk003 = l_oobk003
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF

            IF NOT s_azzi650_chk_exist('220',l_oobk003) THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO oobk_t(oobkent,oobk001,oobk002,oobk003)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_oobk003)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      #----------單身理由碼----------
      IF l_multi_oobi_ins THEN
         LET g_errshow = 0
         FOR l_i = 1 TO g_qryparam.str_array.getLength()
            LET l_str = g_qryparam.str_array[l_i]           
            LET l_oobi003 = l_str.subString(1,l_str.getIndexOf('|',1)-1) 
            #重覆性檢查
            SELECT COUNT(*) INTO l_cnt 
              FROM oobi_t
             WHERE oobient = g_enterprise 
               AND oobi001 = g_ooba_m.ooba001
               AND oobi002 = g_ooba_d[g_detail_idx2].ooba002
               AND oobi003 = l_oobi003
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF
            LET g_oobb7_d[l_ac].oobi003 = l_oobi003
            IF NOT aooi200_oobi003_chk() THEN
               CONTINUE FOR
            END IF 
            
            INSERT INTO oobi_t(oobient,oobi001,oobi002,oobi003)
                 VALUES(g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_oobi003)
     
         END FOR
         LET g_errshow = 1
     
         CALL aooi200_b_fill('0')
     
         CONTINUE WHILE
      END IF
      EXIT WHILE
   END WHILE   
   #dorislai-20150827-add---(E)
END FUNCTION

PRIVATE FUNCTION aooi200_s01_fill()
DEFINE l_sql    STRING
DEFINE l_cnt    LIKE type_t.num5


   IF cl_null(g_s01_wc) THEN LET g_s01_wc = " 1=1" END IF
   
   LET l_sql = "SELECT * FROM aooi200_s01_tmp WHERE ",g_s01_wc,
               " ORDER BY oobx001"
   PREPARE oobx_pre FROM l_sql
   DECLARE oobx_cur CURSOR FOR oobx_pre
   LET l_cnt = 1
   FOREACH oobx_cur INTO g_oobx_d[l_cnt].*  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #15/06/25 Sarah add
      IF g_oobx_d[l_cnt].oobx002_desc IS NULL THEN
         CALL s_azzi930_get_module_name(g_oobx_d[l_cnt].oobx002) RETURNING g_oobx_d[l_cnt].oobx002_desc
      END IF
      #15/06/25 Sarah add
   
      LET l_cnt = l_cnt + 1 
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF       
   END FOREACH
   CALL g_oobx_d.deleteElement(g_oobx_d.getLength())
   LET g_rec_b = l_cnt - 1
   DISPLAY ARRAY g_oobx_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   
END FUNCTION

PRIVATE FUNCTION aooi200_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE ooba_t.ooba001
   DEFINE l_oldno     LIKE ooba_t.ooba001
   DEFINE l_newno02   LIKE ooba_t.ooba002
   DEFINE l_oldno02   LIKE ooba_t.ooba002
   #DEFINE l_master    RECORD LIKE ooba_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_master RECORD  #單據別主檔
       oobastus LIKE ooba_t.oobastus, #状态码
       oobaent LIKE ooba_t.oobaent, #企业编号
       ooba001 LIKE ooba_t.ooba001, #参照表编号
       ooba002 LIKE ooba_t.ooba002, #单据别编号
       ooba008 LIKE ooba_t.ooba008, #可用From
       ooba009 LIKE ooba_t.ooba009, #可用To
       ooba010 LIKE ooba_t.ooba010, #MRP可用From
       ooba011 LIKE ooba_t.ooba011, #MRP可用To
       ooba012 LIKE ooba_t.ooba012, #成本仓From
       ooba013 LIKE ooba_t.ooba013, #成本仓To
       oobaownid LIKE ooba_t.oobaownid, #资料所有者
       oobaowndp LIKE ooba_t.oobaowndp, #资料所有部门
       oobacrtid LIKE ooba_t.oobacrtid, #资料录入者
       oobacrtdp LIKE ooba_t.oobacrtdp, #资料录入部门
       oobacrtdt LIKE ooba_t.oobacrtdt, #资料创建日
       oobamodid LIKE ooba_t.oobamodid, #资料更改者
       oobamoddt LIKE ooba_t.oobamoddt, #最近更改日
       ooba014 LIKE ooba_t.ooba014, #产品分类-正/负向表列
       ooba015 LIKE ooba_t.ooba015, #理由码-正/负向表列
       ooba016 LIKE ooba_t.ooba016, #备注
       ooba017 LIKE ooba_t.ooba017, #控制组-正/负向表列
       ooba018 LIKE ooba_t.ooba018, #生命周期-正/负向表列
       ooba019 LIKE ooba_t.ooba019, #库存标签FROM-正/负向表列
       ooba020 LIKE ooba_t.ooba020 #库存标签TO-正/负向表列
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail    RECORD LIKE oobb_t.*   #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail RECORD  #單據別預設欄位檔
       oobbent LIKE oobb_t.oobbent, #企业编号
       oobb001 LIKE oobb_t.oobb001, #参照表号
       oobb002 LIKE oobb_t.oobb002, #单据别
       oobb003 LIKE oobb_t.oobb003, #序号
       oobb004 LIKE oobb_t.oobb004, #字段编号
       oobb005 LIKE oobb_t.oobb005, #默认值
       oobb006 LIKE oobb_t.oobb006, #默认值说明
       oobb007 LIKE oobb_t.oobb007, #可更改
       oobb008 LIKE oobb_t.oobb008 #备注
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
  # DEFINE l_detail2   RECORD LIKE oobc_t.*  #161124-00048#7  2016/12/13 By 08734 mark 
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail2 RECORD  #單據別控制組限定檔
       oobcent LIKE oobc_t.oobcent, #企业编号
       oobc001 LIKE oobc_t.oobc001, #参照表号
       oobc002 LIKE oobc_t.oobc002, #单据别
       oobc003 LIKE oobc_t.oobc003, #控制组编号
       oobc004 LIKE oobc_t.oobc004 #控制组类型
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E) 
   #DEFINE l_detail3   RECORD LIKE oobd_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail3 RECORD  #單據別生命週期限定檔
       oobdent LIKE oobd_t.oobdent, #企业编号
       oobd001 LIKE oobd_t.oobd001, #参照表号
       oobd002 LIKE oobd_t.oobd002, #单据别
       oobd003 LIKE oobd_t.oobd003, #生命周期类型
       oobd004 LIKE oobd_t.oobd004 #生命周期编号
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
  # DEFINE l_detail4   RECORD LIKE oobh_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail4 RECORD  #單據別產品分類限定檔
       oobhent LIKE oobh_t.oobhent, #企业编号
       oobh001 LIKE oobh_t.oobh001, #参照表号
       oobh002 LIKE oobh_t.oobh002, #单据别
       oobh003 LIKE oobh_t.oobh003 #产品分类
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail5   RECORD LIKE oobj_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail5 RECORD  #單據別庫存標籤From限定檔
       oobjent LIKE oobj_t.oobjent, #企业编号
       oobj001 LIKE oobj_t.oobj001, #参照表号
       oobj002 LIKE oobj_t.oobj002, #单据别
       oobj003 LIKE oobj_t.oobj003 #库存标签编号
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail6   RECORD LIKE oobk_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail6 RECORD  #單據別庫存標籤To限定檔
       oobkent LIKE oobk_t.oobkent, #企业编号
       oobk001 LIKE oobk_t.oobk001, #参照表号
       oobk002 LIKE oobk_t.oobk002, #单据别
       oobk003 LIKE oobk_t.oobk003 #库存标签编号
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail7   RECORD LIKE oobi_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail7 RECORD  #單據別單身理由碼限定檔
       oobient LIKE oobi_t.oobient, #企业编号
       oobi001 LIKE oobi_t.oobi001, #参照表号
       oobi002 LIKE oobi_t.oobi002, #单据别
       oobi003 LIKE oobi_t.oobi003 #单身理由码
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail8   RECORD LIKE ooac_t.*   #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail8 RECORD  #單據別層級參數列
       ooacent LIKE ooac_t.ooacent, #企业编号
       ooac001 LIKE ooac_t.ooac001, #参照表号
       ooac002 LIKE ooac_t.ooac002, #单据别
       ooac003 LIKE ooac_t.ooac003, #参数编号
       ooac004 LIKE ooac_t.ooac004, #参数值
       ooacownid LIKE ooac_t.ooacownid, #资料所有者
       ooacowndp LIKE ooac_t.ooacowndp, #资料所有部门
       ooaccrtid LIKE ooac_t.ooaccrtid, #资料录入者
       ooaccrtdp LIKE ooac_t.ooaccrtdp, #资料录入部门
       ooaccrtdt LIKE ooac_t.ooaccrtdt, #资料创建日
       ooacmodid LIKE ooac_t.ooacmodid, #资料更改者
       ooacmoddt LIKE ooac_t.ooacmoddt, #最近更改日
       ooacstus LIKE ooac_t.ooacstus #状态码
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   #DEFINE l_detail9   RECORD LIKE ooba_t.*  #161124-00048#7  2016/12/13 By 08734 mark
   #161124-00048#7  2016/12/13 By 08734 add(S)
   DEFINE l_detail9 RECORD  #單據別主檔
       oobastus LIKE ooba_t.oobastus, #状态码
       oobaent LIKE ooba_t.oobaent, #企业编号
       ooba001 LIKE ooba_t.ooba001, #参照表编号
       ooba002 LIKE ooba_t.ooba002, #单据别编号
       ooba008 LIKE ooba_t.ooba008, #可用From
       ooba009 LIKE ooba_t.ooba009, #可用To
       ooba010 LIKE ooba_t.ooba010, #MRP可用From
       ooba011 LIKE ooba_t.ooba011, #MRP可用To
       ooba012 LIKE ooba_t.ooba012, #成本仓From
       ooba013 LIKE ooba_t.ooba013, #成本仓To
       oobaownid LIKE ooba_t.oobaownid, #资料所有者
       oobaowndp LIKE ooba_t.oobaowndp, #资料所有部门
       oobacrtid LIKE ooba_t.oobacrtid, #资料录入者
       oobacrtdp LIKE ooba_t.oobacrtdp, #资料录入部门
       oobacrtdt LIKE ooba_t.oobacrtdt, #资料创建日
       oobamodid LIKE ooba_t.oobamodid, #资料更改者
       oobamoddt LIKE ooba_t.oobamoddt, #最近更改日
       ooba014 LIKE ooba_t.ooba014, #产品分类-正/负向表列
       ooba015 LIKE ooba_t.ooba015, #理由码-正/负向表列
       ooba016 LIKE ooba_t.ooba016, #备注
       ooba017 LIKE ooba_t.ooba017, #控制组-正/负向表列
       ooba018 LIKE ooba_t.ooba018, #生命周期-正/负向表列
       ooba019 LIKE ooba_t.ooba019, #库存标签FROM-正/负向表列
       ooba020 LIKE ooba_t.ooba020 #库存标签TO-正/负向表列
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   DEFINE l_sql       STRING          {#ADP版次:1#}
   #end add-point

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF

   IF g_ooba_m.ooba001 IS NULL
   
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL aooi200_set_entry('a')
   CALL aooi200_set_no_entry('a')

   CALL cl_set_head_visible("","YES")

      LET g_ooba_m.ooba001_desc = ''
   DISPLAY BY NAME g_ooba_m.ooba001_desc


   INPUT l_newno   # FROM
         #,l_newno02


    FROM ooba001
         #,ooba002


         ATTRIBUTE(FIELD ORDER FORM)

      #add-point:複製段落開窗/欄位控管/自定義action
      
      #end add-point

      BEFORE INPUT
         #add-point:複製段落Before input
         
         #end add-point

      AFTER FIELD ooba001
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         #add-point:AFTER FIELD ooba001
         IF NOT cl_null(l_newno) THEN
            IF NOT aooi200_ooba001_chk(l_newno) THEN
               NEXT FIELD CURRENT
            END IF
         END IF          {#ADP版次:1#}
        
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_newno
         CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_ooba_m.ooba001_desc = g_rtn_fields[1]
         DISPLAY BY NAME g_ooba_m.ooba001_desc
         #end add-point

      ON ACTION controlp INFIELD ooba001
            #add-point:ON ACTION controlp INFIELD ooba001
#此段落由子樣板a07產生
            #開窗i段
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = l_newno             #給予default值

            #給予arg
            #20151103 by stellar add 151103-00012#1 ----- (S)
            #stellar add:除了aooi100的單據別參照表外，還有agli010的單據別參照表
            LET g_qryparam.where = " ooal002 IN ('",g_ooba001,"')"
            #20151103 by stellar add 151103-00012#1 ----- (E)

            CALL q_ooal002_2()                                #呼叫開窗

            LET l_newno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY l_newno TO ooba001              #顯示到畫面上

            NEXT FIELD ooba001                          #返回原欄位

               {#ADP版次:1#}
         #end add-point



      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF

         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM ooba_t
          WHERE oobaent = g_enterprise AND ooba001 = l_newno
 
         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            #NEXT FIELD ooba001
         END IF

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT

   END INPUT

   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL s_transaction_begin()

  # SELECT * INTO l_master.* FROM ooba_t
  #  WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001
  #    AND ooba002 = g_ooba_m.ooba002


   LET l_master.ooba001 = l_newno

   #公用欄位給予預設值(單頭)
   #此段落由子樣板a13產生
#      LET l_master.oobaownid = g_user
#      LET l_master.oobaowndp = g_dept
#      LET l_master.oobacrtid = g_user
#      LET l_master.oobacrtdp = g_dept
#      LET l_master.oobacrtdt = cl_get_current()
#      LET l_master.oobamodid = "" #g_user
#      LET l_master.oobamoddt = "" #cl_get_current()
#      LET l_master.oobastus = "Y"



   #公用欄位給予預設值(單身)
   #此段落由子樣板a13產生
      LET l_detail8.ooacownid = g_user
      LET l_detail8.ooacowndp = g_dept
      LET l_detail8.ooaccrtid = g_user
      LET l_detail8.ooaccrtdp = g_dept
      LET l_detail8.ooaccrtdt = cl_get_current()
      #LET l_detail8.ooacmodid = "" #g_user
      LET l_detail8.ooacmoddt = "" #cl_get_current()
      LET l_detail8.ooacstus = "Y"



   #add-point:單頭複製前
   
   #end add-point

#   INSERT INTO ooba_t VALUES (l_master.*) #複製單頭
#
#   #add-point:單頭複製中
#   
#   #end add-point
#
#   IF SQLCA.sqlcode THEN
#      CALL cl_err("ooba_t",SQLCA.sqlcode,1)
#      CALL s_transaction_end('N','0')
#      RETURN
#   END IF


#
#      LET g_ooba_m.ooba001 = l_master.ooba001
   LET g_ooba001_t = l_master.ooba001
#   LET g_ooba_m.ooba002 = l_master.ooba002
#   LET g_ooba002_t = l_master.ooba002

   #LET g_sql = "SELECT * FROM ooba_t WHERE oobaent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobastus,oobaent,ooba001,ooba002,ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt,ooba014,ooba015,ooba016,ooba017,ooba018,ooba019,ooba020 FROM ooba_t WHERE oobaent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " ooba001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobb002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce9 CURSOR FROM g_sql

   FOREACH aooi200_reproduce9 INTO l_detail9.*
      LET l_detail9.ooba001 = l_newno
#      LET l_detail.oobb002 = l_newno02



      #add-point:單身複製前1
      LET l_detail9.oobaownid = g_user
      LET l_detail9.oobaowndp = g_dept
      LET l_detail9.oobacrtid = g_user
      LET l_detail9.oobacrtdp = g_dept
      LET l_detail9.oobacrtdt = cl_get_current()
      LET l_detail9.oobamodid = "" #g_user
      LET l_detail9.oobamoddt = "" #cl_get_current()
      LET l_detail9.oobastus = "Y"
      #end add-point

      #INSERT INTO ooba_t VALUES (l_detail9.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO ooba_t(oobastus,oobaent,ooba001,ooba002,ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,oobaownid,oobaowndp,oobacrtid,oobacrtdp,oobacrtdt,oobamodid,oobamoddt,ooba014,ooba015,ooba016,ooba017,ooba018,ooba019,ooba020)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail9.oobastus,l_detail9.oobaent,l_detail9.ooba001,l_detail9.ooba002,l_detail9.ooba008,l_detail9.ooba009,l_detail9.ooba010,l_detail9.ooba011,l_detail9.ooba012,l_detail9.ooba013,l_detail9.oobaownid,l_detail9.oobaowndp,l_detail9.oobacrtid,l_detail9.oobacrtdp,l_detail9.oobacrtdt,l_detail9.oobamodid,l_detail9.oobamoddt,l_detail9.ooba014,l_detail9.ooba015,l_detail9.ooba016,l_detail9.ooba017,l_detail9.ooba018,l_detail9.ooba019,l_detail9.ooba020) #複製單身      

      #add-point:單身複製中1
      
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後1
      
      #end add-point

   END FOREACH


  # LET g_sql = "SELECT * FROM oobb_t WHERE oobbent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobbent,oobb001,oobb002,oobb003,oobb004,oobb005,oobb006,oobb007,oobb008 FROM oobb_t WHERE oobbent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobb001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobb002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce CURSOR FROM g_sql

   FOREACH aooi200_reproduce INTO l_detail.*
      LET l_detail.oobb001 = l_newno
#      LET l_detail.oobb002 = l_newno02



      #add-point:單身複製前1
      
      #end add-point

      #INSERT INTO oobb_t VALUES (l_detail.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobb_t(oobbent,oobb001,oobb002,oobb003,oobb004,oobb005,oobb006,oobb007,oobb008)   #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail.oobbent,l_detail.oobb001,l_detail.oobb002,l_detail.oobb003,l_detail.oobb004,l_detail.oobb005,l_detail.oobb006,l_detail.oobb007,l_detail.oobb008) #複製單身

      #add-point:單身複製中1
      
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後1
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobc_t WHERE oobcent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobcent,oobc001,oobc002,oobc003,oobc004 FROM oobc_t WHERE oobcent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobc001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobc002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce2 CURSOR FROM g_sql

   FOREACH aooi200_reproduce2 INTO l_detail2.*
      LET l_detail2.oobc001 = l_newno
#      LET l_detail2.oobc002 = l_newno02



      #add-point:單身複製前2
      
      #end add-point

      #INSERT INTO oobc_t VALUES (l_detail2.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobc_t(oobcent,oobc001,oobc002,oobc003,oobc004)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail2.oobcent,l_detail2.oobc001,l_detail2.oobc002,l_detail2.oobc003,l_detail2.oobc004) #複製單身
      #add-point:單身複製中2
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後2
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobd_t WHERE oobdent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobdent,oobd001,oobd002,oobd003,oobd004 FROM oobd_t WHERE oobdent = '" ||g_enterprise|| "' AND ", #161124-00048#7  2016/12/13 By 08734 add
               " oobd001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobd002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce3 CURSOR FROM g_sql

   FOREACH aooi200_reproduce3 INTO l_detail3.*
      LET l_detail3.oobd001 = l_newno
      #LET l_detail3.oobd002 = l_newno02



      #add-point:單身複製前3
      
      #end add-point

      #INSERT INTO oobd_t VALUES (l_detail3.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobd_t(oobdent,oobd001,oobd002,oobd003,oobd004)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail3.oobdent,l_detail3.oobd001,l_detail3.oobd002,l_detail3.oobd003,l_detail3.oobd004) #複製單身
      #add-point:單身複製中3
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後3
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobh_t WHERE oobhent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobhent,oobh001,oobh002,oobh003 FROM oobh_t WHERE oobhent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobh001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobh002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce4 CURSOR FROM g_sql

   FOREACH aooi200_reproduce4 INTO l_detail4.*
      LET l_detail4.oobh001 = l_newno
      #LET l_detail4.oobh002 = l_newno02



      #add-point:單身複製前4
      
      #end add-point

      #INSERT INTO oobh_t VALUES (l_detail4.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobh_t(oobhent,oobh001,oobh002,oobh003)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail4.oobhent,l_detail4.oobh001,l_detail4.oobh002,l_detail4.oobh003) #複製單身
      #add-point:單身複製中4
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後4
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobj_t WHERE oobjent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 mark
   LET g_sql = "SELECT oobjent,oobj001,oobj002,oobj003 FROM oobj_t WHERE oobjent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobj001 = '",g_ooba_m.ooba001,"'"
               #," AND oobj002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce5 CURSOR FROM g_sql

   FOREACH aooi200_reproduce5 INTO l_detail5.*
      LET l_detail5.oobj001 = l_newno
      #LET l_detail5.oobj002 = l_newno02



      #add-point:單身複製前5
      
      #end add-point

      #INSERT INTO oobj_t VALUES (l_detail5.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark 
      INSERT INTO oobj_t(oobjent,oobj001,oobj002,oobj003)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail5.oobjent,l_detail5.oobj001,l_detail5.oobj002,l_detail5.oobj003) #複製單身
      #add-point:單身複製中5
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後5
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobk_t WHERE oobkent = '" ||g_enterprise|| "' AND ", #161124-00048#7  2016/12/13 By 08734 mark 
   LET g_sql = "SELECT oobkent,oobk001,oobk002,oobk003 FROM oobk_t WHERE oobkent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobk001 = '",g_ooba_m.ooba001,"'" 
              # ," AND oobk002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce6 CURSOR FROM g_sql

   FOREACH aooi200_reproduce6 INTO l_detail6.*
      LET l_detail6.oobk001 = l_newno
      #LET l_detail6.oobk002 = l_newno02



      #add-point:單身複製前6
      
      #end add-point

      #INSERT INTO oobk_t VALUES (l_detail6.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobk_t(oobkent,oobk001,oobk002,oobk003)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail6.oobkent,l_detail6.oobk001,l_detail6.oobk002,l_detail6.oobk003) #複製單身
      #add-point:單身複製中6
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後6
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM oobi_t WHERE oobient = '" ||g_enterprise|| "' AND ", #161124-00048#7  2016/12/13 By 08734 mark 
   LET g_sql = "SELECT oobient,oobi001,oobi002,oobi003 FROM oobi_t WHERE oobient = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " oobi001 = '",g_ooba_m.ooba001,"'"
              # ," AND oobi002 = '",g_ooba_m.ooba002,"'"


   DECLARE aooi200_reproduce7 CURSOR FROM g_sql

   FOREACH aooi200_reproduce7 INTO l_detail7.*
      LET l_detail7.oobi001 = l_newno
     # LET l_detail7.oobi002 = l_newno02



      #add-point:單身複製前7
      
      #end add-point

      #INSERT INTO oobi_t VALUES (l_detail7.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO oobi_t(oobient,oobi001,oobi002,oobi003)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail7.oobient,l_detail7.oobi001,l_detail7.oobi002,l_detail7.oobi003) #複製單身
      #add-point:單身複製中7
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後7
      
      #end add-point

   END FOREACH

   #LET g_sql = "SELECT * FROM ooac_t WHERE ooacent = '" ||g_enterprise|| "' AND ", #161124-00048#7  2016/12/13 By 08734 mark 
   LET g_sql = "SELECT ooacent,ooac001,ooac002,ooac003,ooac004,ooacownid,ooacowndp,ooaccrtid,ooaccrtdp,ooaccrtdt,ooacmodid,ooacmoddt,ooacstus FROM ooac_t WHERE ooacent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/13 By 08734 add
               " ooac001 = '",g_ooba_m.ooba001,"'"
              # ," AND ooac002 = '",g_ooba_m.ooba002,"'"
   DECLARE aooi200_reproduce8 CURSOR FROM g_sql
   FOREACH aooi200_reproduce8 INTO l_detail8.*
      LET l_detail8.ooac001 = l_newno
     # LET l_detail8.ooac002 = l_newno02



      #add-point:單身複製前8
      
      #end add-point

      #INSERT INTO ooac_t VALUES (l_detail8.*) #複製單身  #161124-00048#7  2016/12/13 By 08734 mark
      INSERT INTO ooac_t(ooacent,ooac001,ooac002,ooac003,ooac004,ooacownid,ooacowndp,ooaccrtid,ooaccrtdp,ooaccrtdt,ooacmodid,ooacmoddt,ooacstus)  #161124-00048#7  2016/12/13 By 08734 add
         VALUES (l_detail8.ooacent,l_detail8.ooac001,l_detail8.ooac002,l_detail8.ooac003,l_detail8.ooac004,l_detail8.ooacownid,l_detail8.ooacowndp,l_detail8.ooaccrtid,l_detail8.ooaccrtdp,l_detail8.ooaccrtdt,l_detail8.ooacmodid,l_detail8.ooacmoddt,l_detail8.ooacstus) #複製單身
      #add-point:單身複製中8
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error! '
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身複製後8
      
      #end add-point

   END FOREACH





   CALL s_transaction_end('Y','0')
   ERROR 'ROW(',l_newno,') O.K'

   CLOSE aooi200_reproduce

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " ooba001 = '", l_newno CLIPPED, "' "
              #," AND ooba002 = '", l_newno02 CLIPPED, "' "


              , ") "

   #add-point:完成複製段落後
          {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi200_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE l_sql     STRING
   {</Local define>}
   #add-point:show段define
   DEFINE l_acc     LIKE gzcb_t.gzcb004          {#ADP版次:1#}
   #end add-point

   #add-point:show段之前
   
   #end add-point
          
   IF g_bfill = "Y" THEN
      CALL aooi200_b2_fill()
      CALL aooi200_b_fill('0') #單身填充
   END IF

   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_ooba_m.oobaownid_desc = cl_get_username(g_ooba_m.oobaownid)
      #LET g_ooba_m.oobaowndp_desc = cl_get_deptname(g_ooba_m.oobaowndp)
      #LET g_ooba_m.oobacrtid_desc = cl_get_username(g_ooba_m.oobacrtid)
      #LET g_ooba_m.oobacrtdp_desc = cl_get_deptname(g_ooba_m.oobacrtdp)
      #LET g_ooba_m.oobamodid_desc = cl_get_username(g_ooba_m.oobamodid)
      ##LET g_ooba_m.oobacnfid_desc = cl_get_deptname(g_ooba_m.oobacnfid)
      ##LET g_ooba_m.oobapstid_desc = cl_get_deptname(g_ooba_m.oobapstid)




   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:show段reference
   SELECT ooba008,ooba009,ooba010,ooba011,ooba012,ooba013,ooba014,ooba015,
          ooba017,ooba018,ooba019,ooba020  #160914-00032#3
     INTO g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
          g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
          g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020 #160914-00032#3
     FROM ooba_t
    WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 AND ooba002 = g_ooba_d[g_detail_idx2].ooba002 
   DISPLAY BY NAME g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
                   g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
                   g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020 #160914-00032#3
                   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooba_m.ooba001
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooba_m.ooba001_desc = '', g_rtn_fields[1] , ''
  
   DISPLAY BY NAME g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
           g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
           g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020 #160914-00032#3
   LET g_ooba_m_t.* = g_ooba_m.*      #保存單頭舊值
   
          {#ADP版次:1#}
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooba_m.ooba001,g_ooba_m.ooba001_desc
   
  # #顯示狀態(stus)圖片
  #       #此段落由子樣板a21產生
  #    CASE g_ooba_m.oobastus
  #       WHEN "N"
  #          CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
  #       WHEN "Y"
  #          CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
  #
  #
  #    END CASE

IF g_bfill = "Y" THEN
   FOR l_ac = 1 TO g_ooba_d.getLength()
         #LET g_ooba2_d[l_ac].oobaownid_desc = cl_get_username(g_ooba2_d[l_ac].oobaownid)
         #LET g_ooba2_d[l_ac].oobaowndp_desc = cl_get_deptname(g_ooba2_d[l_ac].oobaowndp)
         #LET g_ooba2_d[l_ac].oobacrtid_desc = cl_get_username(g_ooba2_d[l_ac].oobacrtid)
         #LET g_ooba2_d[l_ac].oobacrtdp_desc = cl_get_deptname(g_ooba2_d[l_ac].oobacrtdp)
         #LET g_ooba2_d[l_ac].oobamodid_desc = cl_get_username(g_ooba2_d[l_ac].oobamodid)
         #LET g_ooba_d[l_ac].oobacnfid_desc = cl_get_deptname(g_ooba_d[l_ac].oobacnfid)
         #LET g_ooba_d[l_ac].oobapstid_desc = cl_get_deptname(g_ooba_d[l_ac].oobapstid)
         
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobx002,oobx003,oobx004,oobx005 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx002 = g_rtn_fields[1]
#         LET g_ooba_d[l_ac].oobx003 = g_rtn_fields[2]
#         LET g_ooba_d[l_ac].oobx004 = g_rtn_fields[3]
#         LET g_ooba_d[l_ac].oobx005 = g_rtn_fields[4]
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobx006,oobx007,oobx008 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx006 = g_rtn_fields[1]
#         LET g_ooba_d[l_ac].oobx007 = g_rtn_fields[2]
#         LET g_ooba_d[l_ac].oobx008 = g_rtn_fields[3]         
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx002,g_ooba_d[l_ac].oobx003,g_ooba_d[l_ac].oobx004,g_ooba_d[l_ac].oobx005,
#                         g_ooba_d[l_ac].oobx006,g_ooba_d[l_ac].oobx007,g_ooba_d[l_ac].oobx008
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobxl003 FROM oobxl_t WHERE oobxlent = '"||g_enterprise||"' AND oobxl001 = ? AND oobxl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].ooba002_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].ooba002_desc
#   
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].oobx002
#         CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx002_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx002_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].oobx004
#         CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx004_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx004_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaownid
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobaownid_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobaownid_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaowndp
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobaowndp_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobaowndp_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobamodid
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobamodid_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobamodid_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobacrtdp
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobacrtdp_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobacrtdp_desc   
   END FOR
END IF

   FOR l_ac = 1 TO g_oobb_d.getLength()
      #帶出公用欄位reference值
      #此段落由子樣板a12產生


      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb_d[l_ac].oobb004
#            CALL ap_ref_array2(g_ref_fields,"SELECT dzebl003 FROM dzebl_t WHERE dzebl001=? AND dzebl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb_d[l_ac].oobb004_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb_d[l_ac].oobb004_desc
#            CALL aooi200_oobb005_desc()
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb2_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oohal003 FROM oohal_t WHERE oohalent='"||g_enterprise||"' AND oohal001=? AND oohal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb2_d[l_ac].oobc003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb3_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb3_d[l_ac].oobd003
#            LET g_ref_fields[2] = g_oobb3_d[l_ac].oobd004
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb3_d[l_ac].oobd004_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb3_d[l_ac].oobd004_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb4_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb4_d[l_ac].oobh003
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb4_d[l_ac].oobh003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb4_d[l_ac].oobh003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb5_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb5_d[l_ac].oobj003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb5_d[l_ac].oobj003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb5_d[l_ac].oobj003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb6_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb6_d[l_ac].oobk003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='220' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb6_d[l_ac].oobk003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb6_d[l_ac].oobk003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb7_d.getLength()
      #帶出公用欄位reference值

      #add-point:show段單身reference
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_oobb7_d[l_ac].oobi003
#            SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||l_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_oobb7_d[l_ac].oobi003_desc = g_rtn_fields[1]
#            DISPLAY BY NAME g_oobb7_d[l_ac].oobi003_desc
          {#ADP版次:1#}
      #end add-point
   END FOR

   FOR l_ac = 1 TO g_oobb8_d.getLength()
#      SELECT gzszl004 INTO g_oobb8_d[l_ac].gzszl004 FROM gzszl_t
#       WHERE gzszl001 = 'ooac_t' AND gzszl002 = g_oobb8_d[l_ac].ooac003 AND gzszl003 = g_dlang
#      SELECT gzsz009,gzsz008 INTO g_oobb8_d[l_ac].gzsz009,g_oobb8_d[l_ac].gzsz008 FROM gzsz_t
#       WHERE gzsz001 = 'ooac_t' AND gzsz002 = g_oobb8_d[l_ac].ooac003      
#      DISPLAY BY NAME g_oobb8_d[l_ac].gzszl004,g_oobb8_d[l_ac].gzsz009,g_oobb8_d[l_ac].gzsz008
   END FOR

   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後

   #IF 本筆資料已被鎖住,不可使用open_oobl ACTION
   CALL cl_set_act_visible('open_oobl',TRUE)
  # CALL s_transaction_begin()
  # OPEN aooi200_cl USING g_enterprise,g_ooba_m.ooba001
  # IF STATUS THEN
  #    CALL cl_set_act_visible('open_oobl',FALSE)
  # END IF
  # CALL s_transaction_end('N','0')          {#ADP版次:1#}
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi200_b_fill(pi_idx)
   {<Local define>}
   DEFINE p_wc2      STRING
   DEFINE l_gzsz016  LIKE gzsz_t.gzsz016
   DEFINE pi_idx          LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE ls_chk          LIKE type_t.chr1   
   {</Local define>}
   #add-point:b_fill段define
   DEFINE l_acc     LIKE gzcb_t.gzcb004 
   #end add-point

#   CALL g_oobb_d.clear()    #g_oobb_d 單頭及單身
#   CALL g_oobb2_d.clear()
#
#   CALL g_oobb3_d.clear()
#
#   CALL g_oobb4_d.clear()
#
#   CALL g_oobb5_d.clear()
#
#   CALL g_oobb6_d.clear()
#
#   CALL g_oobb7_d.clear()
#
#   CALL g_oobb8_d.clear()



   #add-point:b_fill段sql_before
   LET li_ac = l_ac
   #end add-point

   #判斷是否填充
   IF aooi200_fill_chk(1) THEN
      IF pi_idx = 1 OR pi_idx = 0 THEN
         CALL g_oobb_d.clear()
         LET g_sql = "SELECT  UNIQUE oobb003,oobb004,dzebl003,oobb005,oobb006,oobb007,oobb008 FROM oobb_t",
                     " INNER JOIN ooba_t ON ooba001 = oobb001 ",
                     " AND ooba002 = oobb002 ",
                     " LEFT OUTER JOIN dzebl_t ON dzebl001=oobb004 AND dzebl002='"||g_dlang||"'",   
                     " WHERE oobbent=? AND oobb001=? AND oobb002=?"
   
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
   
         #子單身的WC
   
   
         LET g_sql = g_sql, " ORDER BY oobb_t.oobb003"
   
         #add-point:單身填充控制
         
         #end add-point
   
         PREPARE aooi200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aooi200_pb
   
         LET g_cnt = l_ac
         LET l_ac = 1
   
         OPEN b_fill_cs USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
   
   
   
         FOREACH b_fill_cs INTO g_oobb_d[l_ac].oobb003,g_oobb_d[l_ac].oobb004,g_oobb_d[l_ac].oobb004_desc,g_oobb_d[l_ac].oobb005,g_oobb_d[l_ac].oobb006,g_oobb_d[l_ac].oobb007,g_oobb_d[l_ac].oobb008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF
   
            #add-point:b_fill段資料填充
            
            #end add-point
   
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec AND g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               EXIT FOREACH
            END IF
   
         END FOREACH
         CALL g_oobb_d.deleteElement(g_oobb_d.getLength())
      END IF
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(2) THEN
      IF pi_idx = 2 OR pi_idx = 0 THEN
         CALL g_oobb2_d.clear()      
           LET g_sql = "SELECT  UNIQUE oobc004,oobc003,oohal003 FROM oobc_t",
                       " INNER JOIN ooba_t ON ooba001 = oobc001 AND ooba002 = oobc002 ",
                       " LEFT OUTER JOIN oohal_t ON oohalent=oobcent AND oohal001=oobc003 AND oohal002='"||g_dlang||"'",
                       " WHERE oobcent=? AND oobc001=? AND oobc002=?"
     
           IF NOT cl_null(g_wc2_table2) THEN
              LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
           END IF
     
           #子單身的WC
     
     
           LET g_sql = g_sql, " ORDER BY oobc_t.oobc003"
     
           #add-point:單身填充控制
           
           #end add-point
     
           PREPARE aooi200_pb2 FROM g_sql
           DECLARE b_fill_cs2 CURSOR FOR aooi200_pb2
     
          LET l_ac = 1
     
          OPEN b_fill_cs2 USING g_enterprise,g_ooba_m.ooba001
                                                   ,g_ooba_d[g_detail_idx2].ooba002
     
     
     
          FOREACH b_fill_cs2 INTO g_oobb2_d[l_ac].oobc004,g_oobb2_d[l_ac].oobc003,g_oobb2_d[l_ac].oobc003_desc
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                EXIT FOREACH
             END IF
     
             #add-point:b_fill段資料填充
             IF g_oobb2_d[l_ac].oobc004 = '8' THEN 
                LET g_oobb2_d[l_ac].oobc003_desc = ''
                INITIALIZE g_ref_fields TO NULL
                LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
                LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]              
             ELSE 
                IF g_oobb2_d[l_ac].oobc004 = '7' THEN 
                   LET g_oobb2_d[l_ac].oobc003_desc = ''
                   INITIALIZE g_ref_fields TO NULL
                   LET g_ref_fields[1] = g_oobb2_d[l_ac].oobc003
                   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                   LET g_oobb2_d[l_ac].oobc003_desc = g_rtn_fields[1]
                END IF
             END IF
             #end add-point
     
             LET l_ac = l_ac + 1
             IF l_ac > g_max_rec THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                EXIT FOREACH
             END IF
     
          END FOREACH
          CALL g_oobb2_d.deleteElement(g_oobb2_d.getLength())
       END IF    
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(3) THEN
      IF pi_idx = 3 OR pi_idx = 0 THEN
         CALL g_oobb3_d.clear()        
         LET g_sql = "SELECT  UNIQUE oobd003,oobd004,oocql004 FROM oobd_t",
                      " INNER JOIN ooba_t ON ooba001 = oobd001 ",
                      " AND ooba002 = oobd002 ",
                      " LEFT OUTER JOIN oocql_t ON oocqlent=oobdent AND oocql001=oobd003 AND oocql002=oobd004 AND oocql003='"||g_dlang||"'",
    
                      " WHERE oobdent=? AND oobd001=? AND oobd002=?"
    
          IF NOT cl_null(g_wc2_table3) THEN
             LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
          END IF
    
          #子單身的WC
    
    
          LET g_sql = g_sql, " ORDER BY oobd_t.oobd003,oobd_t.oobd004"
    
          #add-point:單身填充控制
          
          #end add-point
    
          PREPARE aooi200_pb3 FROM g_sql
          DECLARE b_fill_cs3 CURSOR FOR aooi200_pb3
    
         LET l_ac = 1
    
         OPEN b_fill_cs3 USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
    
    
    
         FOREACH b_fill_cs3 INTO g_oobb3_d[l_ac].oobd003,g_oobb3_d[l_ac].oobd004,g_oobb3_d[l_ac].oobd004_desc
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF
    
            #add-point:b_fill段資料填充
            
            #end add-point
    
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

               EXIT FOREACH
            END IF
    
         END FOREACH
         CALL g_oobb3_d.deleteElement(g_oobb3_d.getLength())
      END IF   
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(4) THEN
      IF pi_idx = 4 OR pi_idx = 0 THEN
         CALL g_oobb4_d.clear()   
          LET g_sql = "SELECT  UNIQUE oobh003,rtaxl003 FROM oobh_t",
                      " INNER JOIN ooba_t ON ooba001 = oobh001 ",
                      " AND ooba002 = oobh002 ",
                      " LEFT OUTER JOIN rtaxl_t ON rtaxlent=oobhent AND rtaxl001=oobh003 AND rtaxl002='"||g_dlang||"'",
                      " WHERE oobhent=? AND oobh001=? AND oobh002=?"
    
          IF NOT cl_null(g_wc2_table4) THEN
             LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
          END IF
    
          #子單身的WC
    
    
          LET g_sql = g_sql, " ORDER BY oobh_t.oobh003"
    
          #add-point:單身填充控制
          
          #end add-point
    
          PREPARE aooi200_pb4 FROM g_sql
          DECLARE b_fill_cs4 CURSOR FOR aooi200_pb4
    
         LET l_ac = 1
    
         OPEN b_fill_cs4 USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
    
    
    
         FOREACH b_fill_cs4 INTO g_oobb4_d[l_ac].oobh003,g_oobb4_d[l_ac].oobh003_desc
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF
    
            #add-point:b_fill段資料填充
            
            #end add-point
    
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

               EXIT FOREACH
            END IF
    
         END FOREACH
         CALL g_oobb4_d.deleteElement(g_oobb4_d.getLength())
      END IF
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(5) THEN
      IF pi_idx = 5 OR pi_idx = 0 THEN
         CALL g_oobb5_d.clear()   
          LET g_sql = "SELECT  UNIQUE oobj003,oocql004 FROM oobj_t",
                      " INNER JOIN ooba_t ON ooba001 = oobj001 ",
                      " AND ooba002 = oobj002 ",
                      " LEFT OUTER JOIN oocql_t ON oocqlent=oobjent AND oocql001='220' AND oocql002=oobj003 AND oocql003='"||g_dlang||"'",
                      " WHERE oobjent=? AND oobj001=? AND oobj002=?"
    
          IF NOT cl_null(g_wc2_table5) THEN
             LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
          END IF
    
          #子單身的WC
    
    
          LET g_sql = g_sql, " ORDER BY oobj_t.oobj003"
    
          #add-point:單身填充控制
          
          #end add-point
    
          PREPARE aooi200_pb5 FROM g_sql
          DECLARE b_fill_cs5 CURSOR FOR aooi200_pb5
    
         LET l_ac = 1
    
         OPEN b_fill_cs5 USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
    
    
    
         FOREACH b_fill_cs5 INTO g_oobb5_d[l_ac].oobj003,g_oobb5_d[l_ac].oobj003_desc
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF
    
            #add-point:b_fill段資料填充
            
            #end add-point
    
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

               EXIT FOREACH
            END IF
    
         END FOREACH
         CALL g_oobb5_d.deleteElement(g_oobb5_d.getLength())
      END IF
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(6) THEN
      IF pi_idx = 6 OR pi_idx = 0 THEN
         CALL g_oobb6_d.clear()  
          LET g_sql = "SELECT  UNIQUE oobk003,oocql004 FROM oobk_t",
                      " INNER JOIN ooba_t ON ooba001 = oobk001 ",
                      " AND ooba002 = oobk002 ",
                      " LEFT OUTER JOIN oocql_t ON oocqlent=oobkent AND oocql001='220' AND oocql002=oobk003 AND oocql003='"||g_dlang||"'",
                      " WHERE oobkent=? AND oobk001=? AND oobk002=?"
    
          IF NOT cl_null(g_wc2_table6) THEN
             LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
          END IF
    
          #子單身的WC
    
    
          LET g_sql = g_sql, " ORDER BY oobk_t.oobk003"
    
          #add-point:單身填充控制
          
          #end add-point
    
          PREPARE aooi200_pb6 FROM g_sql
          DECLARE b_fill_cs6 CURSOR FOR aooi200_pb6
    
         LET l_ac = 1
    
         OPEN b_fill_cs6 USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
    
    
    
         FOREACH b_fill_cs6 INTO g_oobb6_d[l_ac].oobk003,g_oobb6_d[l_ac].oobk003_desc
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               EXIT FOREACH
            END IF
    
            #add-point:b_fill段資料填充
            
            #end add-point
    
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

               EXIT FOREACH
            END IF
    
         END FOREACH
         CALL g_oobb6_d.deleteElement(g_oobb6_d.getLength())
      END IF
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(7) THEN
      IF pi_idx = 7 OR pi_idx = 0 THEN
         CALL g_oobb7_d.clear()
         #SELECT gzcb004 INTO l_acc FROM gzcb_t WHERE gzcb001=24 AND gzcb002=g_ooba_d[g_detail_idx2].oobx003     #160816-00001#6 mark
         LET l_acc = s_fin_get_scc_value('24',g_ooba_d[g_detail_idx2].oobx003,'2')  #160816-00001#6  Add
         
         LET g_sql = "SELECT  UNIQUE oobi003,oocql004 FROM oobi_t",
                     " INNER JOIN ooba_t ON ooba001 = oobi001 ",
                     " AND ooba002 = oobi002 ",
                    "  LEFT OUTER JOIN oocql_t ON oocqlent=oobient AND oocql001='",l_acc,"'",
                    "                              AND oocql002=oobi003 AND oocql003='"||g_dlang||"'",
                    " WHERE oobient=? AND oobi001=? AND oobi002=?"
   
         IF NOT cl_null(g_wc2_table7) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
         END IF
   
         #子單身的WC
   
   
         LET g_sql = g_sql, " ORDER BY oobi_t.oobi003"
   
         #add-point:單身填充控制
         
         #end add-point
   
         PREPARE aooi200_pb7 FROM g_sql
         DECLARE b_fill_cs7 CURSOR FOR aooi200_pb7
   
        LET l_ac = 1
   
        OPEN b_fill_cs7 USING g_enterprise,g_ooba_m.ooba001
                                                 ,g_ooba_d[g_detail_idx2].ooba002
   
   
   
        FOREACH b_fill_cs7 INTO g_oobb7_d[l_ac].oobi003,g_oobb7_d[l_ac].oobi003_desc
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.popup = TRUE
               CALL cl_err()

              EXIT FOREACH
           END IF
   
           #add-point:b_fill段資料填充
           
           #end add-point
   
           LET l_ac = l_ac + 1
           IF l_ac > g_max_rec THEN
              INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  9035
                LET g_errparam.extend =  ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

              EXIT FOREACH
           END IF
   
        END FOREACH
        CALL g_oobb7_d.deleteElement(g_oobb7_d.getLength())
      END IF
   END IF

   #判斷是否填充
   IF aooi200_fill_chk(8) THEN
      IF pi_idx = 8 OR pi_idx = 0 THEN
         CALL g_oobb8_d.clear()   
         LET g_sql = "SELECT  UNIQUE ooac003,gzszl004,ooac004,gzsz009,gzsz008 ",
                     "  FROM ooac_t",
                     " INNER JOIN ooba_t ON oobaent = ooacent AND ooba001 = ooac001 AND ooba002 = ooac002 ",
                     "  LEFT JOIN gzszl_t ON gzszl001 = 'ooac_t' AND gzszl002 = ooac003 AND gzszl003 = '",g_dlang CLIPPED,"'",   
                     "  LEFT JOIN gzsz_t ON gzsz001 = 'ooac_t' AND gzsz002 = ooac003 ",
                     " WHERE ooacent=? AND ooac001=? AND ooac002=?"
         IF NOT cl_null(g_wc2_table8) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
         END IF
   

         #子單身的WC 
         LET g_sql = g_sql, " ORDER BY ooac_t.ooac003"
   
         #add-point:單身填充控制
         
         #end add-point
   
         PREPARE aooi200_pb8 FROM g_sql
         DECLARE b_fill_cs8 CURSOR FOR aooi200_pb8
   
         LET l_ac = 1
         
         OPEN b_fill_cs8 USING g_enterprise,g_ooba_m.ooba001
                                                  ,g_ooba_d[g_detail_idx2].ooba002
         
         
         
         FOREACH b_fill_cs8 INTO g_oobb8_d[l_ac].ooac003,g_oobb8_d[l_ac].gzszl004,g_oobb8_d[l_ac].ooac004,g_oobb8_d[l_ac].gzsz009,g_oobb8_d[l_ac].gzsz008
           
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "FOREACH:"
                LET g_errparam.popup = TRUE
                CALL cl_err()
         
               EXIT FOREACH
            END IF
            #IF l_ac >= 1 THEN
            IF l_ac = 1 THEN   #160804-00006#1
               SELECT gzsz016 INTO l_gzsz016 FROM gzsz_t WHERE gzsz001 = 'ooac_t' AND gzsz002 = g_oobb8_d[l_ac].ooac003 
               CALL aooi200_gzcb_fill(l_gzsz016)
            END IF    #160804-00006#1
            #END IF
            
            #add-point:b_fill段資料填充
            
            #end add-point
           
            LET l_ac = l_ac + 1
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL
                 LET g_errparam.code =  9035
                 LET g_errparam.extend =  ''
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
         
               EXIT FOREACH
            END IF
         END FOREACH
         CALL g_oobb8_d.deleteElement(g_oobb8_d.getLength())
         
      END IF
   END IF


   
   #子單身的WC
   LET l_ac = li_ac


   FREE aooi200_pb
   FREE aooi200_pb2

   FREE aooi200_pb3

   FREE aooi200_pb4

   FREE aooi200_pb5

   FREE aooi200_pb6

   FREE aooi200_pb7

   FREE aooi200_pb8



END FUNCTION

PRIVATE FUNCTION aooi200_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   DEFINE  l_cnt           LIKE type_t.num5
   DEFINE  l_oobf002       LIKE oobf_t.oobf002
   #end add-point

   IF g_ooba_m.ooba001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   SELECT UNIQUE ooba001 INTO g_ooba_m.ooba001
     FROM ooba_t
    WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001 
   CALL s_transaction_begin()

   LET g_master_multi_table_t.oobal001 = g_ooba_m.ooba001
  # LET g_master_multi_table_t.oobal002 = g_ooba_m.ooba002
  # LET g_master_multi_table_t.oobal004 = g_ooba_m.oobal004

  # OPEN aooi200_cl USING g_enterprise,g_ooba_m.ooba001,g_ooba_m.ooba002
  # IF STATUS THEN
  #    CALL cl_err("OPEN aooi200_cl:", STATUS, 1)
  #    CLOSE aooi200_cl
  #    CALL s_transaction_end('N','0')
  #    RETURN
  # END IF
  #
  # FETCH aooi200_cl INTO g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba006,g_ooba_m.ooba002,g_ooba_m.ooba007,g_ooba_m.oobal004,g_ooba_m.lbl_length_desc,g_ooba_m.ooba003,g_ooba_m.ooba003_desc,g_ooba_m.lbl_result_desc,g_ooba_m.ooba004,g_ooba_m.ooba005,g_ooba_m.ooba005_desc,g_ooba_m.oobastus,g_ooba_m.oobaownid,g_ooba_m.oobaownid_desc,g_ooba_m.oobaowndp,g_ooba_m.oobaowndp_desc,g_ooba_m.oobacrtid,g_ooba_m.oobacrtid_desc,g_ooba_m.oobacrtdp,g_ooba_m.oobacrtdp_desc,g_ooba_m.oobacrtdt,g_ooba_m.oobamodid,g_ooba_m.oobamodid_desc,g_ooba_m.oobamoddt,g_ooba_m.ooba014,g_ooba_m.ooba008,g_ooba_m.ooba010,g_ooba_m.ooba012,g_ooba_m.ooba009,g_ooba_m.ooba011,g_ooba_m.ooba013,g_ooba_m.ooba015              # 鎖住將被更改或取消的資料
  # IF SQLCA.sqlcode THEN
  #    INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = g_ooba_m.ooba001
#         LET g_errparam.popup = FALSE
#         CALL cl_err()
          #資料被他人LOCK
  #    CALL s_transaction_end('N','0')
  #    RETURN
  # END IF

   CALL aooi200_show()

   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
#      INITIALIZE g_doc.* TO NULL
#      LET g_doc.column1 = "ooba001"
#      LET g_doc.value1 = g_ooba_m.ooba001
      #CALL cl_del_doc()
      CALL g_pk_array.clear()
      LET g_pk_array[1].values = g_ooba_m.ooba001
      LET g_pk_array[1].column = 'ooba001'
      CALL cl_doc_remove()
      #資料備份
      LET g_ooba001_t = g_ooba_m.ooba001
      #LET g_ooba002_t = g_ooba_m.ooba002

      #add-point:單頭刪除前
      #檢查單據別最大流水號紀錄檔裡有沒有資料,有資料代表底下的單據別已經有被使用,不可刪除
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt 
        FROM ooef_t
       INNER JOIN oobf_t ON ooefent = oobfent AND ooef001 = oobfsite AND ooef005 = oobf001
       WHERE ooefent = g_enterprise
         AND ooef004 = g_ooba_m.ooba001
         AND oobf004 <> 0    #最大流水號=0表示先前有使用過此單據別編過單號,但又把那筆單號刪掉了
      IF l_cnt > 0 THEN
         CALL cl_showmsg_init()
         DECLARE chk_data_curs1 CURSOR FOR
            SELECT DISTINCT oobf002
              FROM ooef_t
             INNER JOIN oobf_t ON ooefent = oobfent AND ooef001 = oobfsite AND ooef005 = oobf001
             WHERE ooefent = g_enterprise
               AND ooef004 = g_ooba_m.ooba001
               AND oobf004 <> 0
             ORDER BY oobf002
         FOREACH chk_data_curs1 INTO l_oobf002
            CALL cl_errmsg('','',l_oobf002,'aoo-00297',1)
         END FOREACH
         CALL cl_showmsg()
         CALL s_transaction_end('N','0')
         RETURN         
      END IF
      #end add-point

      DELETE FROM ooba_t
       WHERE oobaent = g_enterprise AND ooba001 = g_ooba_m.ooba001
        # AND ooba002 = g_ooba_m.ooba002

      #add-point:單頭刪除中
      
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = g_ooba_m.ooba001
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單頭刪除後
               {#ADP版次:1#}
      #end add-point


      #add-point:單身刪除前
      
      #end add-point

      DELETE FROM oobb_t
       WHERE oobbent = g_enterprise AND oobb001 = g_ooba_m.ooba001
        # AND oobb002 = g_ooba_m.ooba002



      #add-point:單身刪除中
      
      #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

                  

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobc_t
       WHERE oobcent = g_enterprise AND
             oobc001 = g_ooba_m.ooba001 #AND oobc002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobd_t
       WHERE oobdent = g_enterprise AND
             oobd001 = g_ooba_m.ooba001 #AND oobd002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobh_t
       WHERE oobhent = g_enterprise AND
             oobh001 = g_ooba_m.ooba001 #AND oobh002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobj_t
       WHERE oobjent = g_enterprise AND
             oobj001 = g_ooba_m.ooba001 #AND oobj002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobk_t
       WHERE oobkent = g_enterprise AND
             oobk001 = g_ooba_m.ooba001 #AND oobk002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobk_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM oobi_t
       WHERE oobient = g_enterprise AND
             oobi001 = g_ooba_m.ooba001 #AND oobi002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobi_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point

      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM ooac_t
       WHERE ooacent = g_enterprise AND
             ooac001 = g_ooba_m.ooba001 #AND ooac002 = g_ooba_m.ooba002
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      END IF

      #add-point:單身刪除後
      
      #end add-point





      CLEAR FORM
      CALL g_ooba_d.clear()
      CALL g_ooba2_d.clear()
      CALL g_oobb_d.clear()
      CALL g_oobb2_d.clear()

      CALL g_oobb3_d.clear()

      CALL g_oobb4_d.clear()

      CALL g_oobb5_d.clear()

      CALL g_oobb6_d.clear()

      CALL g_oobb7_d.clear()

      CALL g_oobb8_d.clear()



      CALL aooi200_ui_browser_refresh()
      CALL aooi200_ui_headershow()
      CALL aooi200_ui_detailshow()

      IF g_browser_cnt > 0 THEN
         CALL aooi200_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL aooi200_browser_fill("F")
      END IF

   END IF

   #CLOSE aooi200_cl
   CALL s_transaction_end('Y','0')

   #流程通知預埋點-D
   CALL cl_flow_notify(g_ooba_m.ooba001,'D')

END FUNCTION

PRIVATE FUNCTION aooi200_delete_b(ps_table,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:delete_b段define
   
   #end add-point
   
   LET g_update = TRUE  #160919-00048#1-add
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobb_t
       WHERE oobbent = g_enterprise AND
         oobb001 = ps_keys_bak[1] AND oobb002 = ps_keys_bak[2] AND oobb003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobc_t
       WHERE oobcent = g_enterprise AND
         oobc001 = ps_keys_bak[1] AND oobc002 = ps_keys_bak[2] AND oobc003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobd_t
       WHERE oobdent = g_enterprise AND
         oobd001 = ps_keys_bak[1] AND oobd002 = ps_keys_bak[2] AND oobd003 = ps_keys_bak[3] AND oobd004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobh_t
       WHERE oobhent = g_enterprise AND
         oobh001 = ps_keys_bak[1] AND oobh002 = ps_keys_bak[2] AND oobh003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobj_t
       WHERE oobjent = g_enterprise AND
         oobj001 = ps_keys_bak[1] AND oobj002 = ps_keys_bak[2] AND oobj003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobk_t
       WHERE oobkent = g_enterprise AND
         oobk001 = ps_keys_bak[1] AND oobk002 = ps_keys_bak[2] AND oobk003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobk_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM oobi_t
       WHERE oobient = g_enterprise AND
         oobi001 = ps_keys_bak[1] AND oobi002 = ps_keys_bak[2] AND oobi003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobi_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM ooac_t
       WHERE ooacent = g_enterprise AND
         ooac001 = ps_keys_bak[1] AND ooac002 = ps_keys_bak[2] AND ooac003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF

   LET ls_group = "'9',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point
      DELETE FROM ooba_t
       WHERE oobaent = g_enterprise AND
         ooba001 = ps_keys_bak[1] AND ooac002 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooba_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point
   END IF



END FUNCTION

PRIVATE FUNCTION aooi200_insert_b(ps_table,ps_keys,ps_page)
   {<Local define>}
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   {</Local define>}
   #add-point:insert_b段define
   
   #end add-point
   
   LET g_update = TRUE  #160919-00048#1-add
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobb_t
                  (oobbent,
                   oobb001,oobb002,
                   oobb003
                   ,oobb004,oobb005,oobb006,oobb007,oobb008)
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_oobb_d[g_detail_idx].oobb004,g_oobb_d[g_detail_idx].oobb005,g_oobb_d[g_detail_idx].oobb006,g_oobb_d[g_detail_idx].oobb007,g_oobb_d[g_detail_idx].oobb008)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobb_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobc_t
                  (oobcent,
                   oobc001,oobc002,
                   oobc003,oobc004
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],g_oobb2_d[g_detail_idx].oobc004
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobd_t
                  (oobdent,
                   oobd001,oobd002,
                   oobd003,oobd004
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobh_t
                  (oobhent,
                   oobh001,oobh002,
                   oobh003
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobj_t
                  (oobjent,
                   oobj001,oobj002,
                   oobj003
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobk_t
                  (oobkent,
                   oobk001,oobk002,
                   oobk003
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobk_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO oobi_t
                  (oobient,
                   oobi001,oobi002,
                   oobi003
                   )
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   )
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobi_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      INSERT INTO ooac_t
                  (ooacent,ooac001,ooac002,ooac003,ooac004)
           VALUES (g_enterprise,ps_keys[1],ps_keys[2],ps_keys[3],g_oobb8_d[g_detail_idx].ooac004)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF

END FUNCTION

PRIVATE FUNCTION aooi200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   {<Local define>}
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:update_b段define
   
   #end add-point
   
   LET g_update = TRUE  #160919-00048#1-add
   
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
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobb_t
         SET (oobb001,oobb002,
              oobb003
              ,oobb004,oobb005,oobb006,oobb007,oobb008)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_oobb_d[g_detail_idx2].oobb004,g_oobb_d[g_detail_idx2].oobb005,g_oobb_d[g_detail_idx2].oobb006,g_oobb_d[g_detail_idx2].oobb007,g_oobb_d[g_detail_idx2].oobb008)
         WHERE oobbent = g_enterprise AND oobb001 = ps_keys_bak[1] AND oobb002 = ps_keys_bak[2] AND oobb003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobc_t
         SET (oobc001,oobc002,
              oobc003,oobc004
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],g_oobb2_d[g_detail_idx].oobc003
              )
         WHERE oobcent = g_enterprise AND oobc001 = ps_keys_bak[1] AND oobc002 = ps_keys_bak[2] AND oobc003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobc_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobd_t
         SET (oobd001,oobd002,
              oobd003,oobd004
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              )
         WHERE oobdent = g_enterprise AND oobd001 = ps_keys_bak[1] AND oobd002 = ps_keys_bak[2] AND oobd003 = ps_keys_bak[3] AND oobd004 = ps_keys_bak[4]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobd_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobh_t
         SET (oobh001,oobh002,
              oobh003
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              )
         WHERE oobhent = g_enterprise AND oobh001 = ps_keys_bak[1] AND oobh002 = ps_keys_bak[2] AND oobh003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobj_t
         SET (oobj001,oobj002,
              oobj003
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              )
         WHERE oobjent = g_enterprise AND oobj001 = ps_keys_bak[1] AND oobj002 = ps_keys_bak[2] AND oobj003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobk_t
         SET (oobk001,oobk002,
              oobk003
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              )
         WHERE oobkent = g_enterprise AND oobk001 = ps_keys_bak[1] AND oobk002 = ps_keys_bak[2] AND oobk003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobk_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE oobi_t
         SET (oobi001,oobi002,
              oobi003
              )
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              )
         WHERE oobient = g_enterprise AND oobi001 = ps_keys_bak[1] AND oobi002 = ps_keys_bak[2] AND oobi003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "oobi_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF

   LET ls_group = "'8',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:update_b段修改前
      
      #end add-point
      UPDATE ooac_t
         SET (ooac001,ooac002,
              ooac003,ooac004)
              =
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_oobb8_d[g_detail_idx2].ooac004)
         WHERE ooacent = g_enterprise AND ooac001 = ps_keys_bak[1] AND ooac002 = ps_keys_bak[2] AND ooac003 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooac_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      ELSE

      END IF
      #add-point:update_b段修改後
      
      #end add-point
   END IF







END FUNCTION

PRIVATE FUNCTION aooi200_lock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:lock_b段define
   
   #end add-point

   #先刷新資料
   #CALL aooi200_b_fill()

   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "oobb_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl USING g_enterprise,
                                       g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb_d[g_detail_idx].oobb003

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF

   END IF

   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "oobc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl2 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb2_d[g_detail_idx].oobc003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "oobd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl3 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb3_d[g_detail_idx].oobd003,g_oobb3_d[g_detail_idx].oobd004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "oobh_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl4 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb4_d[g_detail_idx].oobh003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "oobj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl5 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb5_d[g_detail_idx].oobj003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl5"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'6',"
   #僅鎖定自身table
   LET ls_group = "oobk_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl6 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb6_d[g_detail_idx].oobk003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl6"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'7',"
   #僅鎖定自身table
   LET ls_group = "oobi_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl7 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb7_d[g_detail_idx].oobi003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl7"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'8',"
   #僅鎖定自身table
   LET ls_group = "ooac_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl8 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,g_oobb8_d[g_detail_idx].ooac003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl8"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF

   #鎖定整組table
   #LET ls_group = "'9',"
   #僅鎖定自身table
   LET ls_group = "ooba_t"
   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aooi200_bcl9 USING g_enterprise,
                                             g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "aooi200_bcl9"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF



   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION aooi200_unlock_b(ps_table,ps_page)
   {<Local define>}
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   {</Local define>}
   #add-point:unlock_b段define
   
   #end add-point

   LET ls_group = "'1',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl
   END IF

   LET ls_group = "'2',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl2
   END IF

   LET ls_group = "'3',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl3
   END IF

   LET ls_group = "'4',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl4
   END IF

   LET ls_group = "'5',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl5
   END IF

   LET ls_group = "'6',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl6
   END IF

   LET ls_group = "'7',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl7
   END IF

   LET ls_group = "'8',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl8
   END IF

   LET ls_group = "'9',"

   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aooi200_bcl9
   END IF



END FUNCTION

PRIVATE FUNCTION aooi200_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("ooba001",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point
   END IF

   #add-point:set_entry段欄位控制後
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi200_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("ooba001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point
   END IF

   #add-point:set_no_entry段欄位控制後
   
   #end add-point
#20151103 by stellar mark 151103-00012#1 ----- (S)
#stellar mark:除了aooi100的單據別參照表外，還有agli010的單據別參照表
#   CALL cl_set_comp_entry("ooba001",FALSE)   #add by lixh 20150703 150702-00006#7
#20151103 by stellar mark 151103-00012#1 ----- (E)
END FUNCTION

PRIVATE FUNCTION aooi200_set_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry_b段define
   
   #end add-point
   #add-point:set_entry_b段
  #CALL cl_set_comp_entry("oobh003",TRUE)
  #CALL cl_set_comp_entry("oobi003",TRUE)
   #end add-point
END FUNCTION

PRIVATE FUNCTION aooi200_set_no_entry_b(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry_b段define
   
   #end add-point
   #add-point:set_no_entry_b段
   
   #end add-point
END FUNCTION

PRIVATE FUNCTION aooi200_default_search()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE li_cnt  LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE ls_wc   STRING
   {</Local define>}
   #add-point:default_search段define
   
   #end add-point

   #add-point:default_search段開始前
   
   #end add-point

   LET g_pagestart = 1

   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF

   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " ooba001 = '", g_argv[1], "' AND "
   END IF

  # IF NOT cl_null(g_argv[02]) THEN
  #    LET ls_wc = ls_wc, " ooba002 = '", g_argv[02], "' AND "
  # END IF



   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前
   
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 寫入單據別參數資料
# Memo...........:
# Usage..........: CALL aooi200_ooac_ins(p_cmd)
#                  RETURNING 回传参数
# Input parameter: p_cmd      主單身異動別,a=新增,u=修改
# Return code....: TRUE/FALSE 本FUNCTION執行結果,TRUE=執行成功,FALSE=執行失敗
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi200_ooac_ins(p_cmd)
   DEFINE  l_gszy002       LIKE gzsy_t.gzsy002
   DEFINE  l_ooacownid     LIKE ooac_t.ooacownid
   DEFINE  l_ooacowndp     LIKE ooac_t.ooacowndp
   DEFINE  l_ooaccrtid     LIKE ooac_t.ooaccrtid
   DEFINE  l_ooaccrtdp     LIKE ooac_t.ooaccrtdp
   DEFINE  l_ooaccrtdt     DATETIME YEAR TO SECOND
   DEFINE  l_ooacstus      LIKE ooac_t.ooacstus
   DEFINE  l_ooacmodid     LIKE type_t.chr80
   DEFINE  l_ooacmoddt     DATETIME YEAR TO SECOND
   DEFINE  p_cmd           LIKE type_t.chr1
   DEFINE  l_gzsz008       LIKE gzsz_t.gzsz008
   
   IF p_cmd = 'u' THEN 
      IF g_ooba_d[g_detail_idx2].ooba002 = g_ooba_d_t.ooba002 THEN
         RETURN TRUE
      ELSE
         DELETE FROM ooac_t WHERE ooacent = g_enterprise
                              AND ooac001 = g_ooba_m.ooba001 AND ooac002 = g_ooba_d_t.ooba002
      END IF         
   END IF

   LET l_ooacownid = g_user
   LET l_ooacowndp = g_dept
   LET l_ooaccrtid = g_user
   LET l_ooaccrtdp = g_dept
   LET l_ooaccrtdt = cl_get_current()
   LET l_ooacstus = 'Y'
   DECLARE ooac_curs CURSOR FOR 
      SELECT gzsy002 FROM gzsy_t
       WHERE gzsy001 = 'ooac_t'
         AND gzsy003 = g_ooba_d[g_detail_idx2].oobx002 AND gzsy004 = g_ooba_d[g_detail_idx2].oobx003   
   FOREACH ooac_curs INTO l_gszy002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "gzsy002"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      SELECT gzsz008 INTO l_gzsz008 
        FROM gzsz_t
       WHERE gzsz001 = 'ooac_t'
         AND gzsz002 = l_gszy002 
         
      #160727-00025#1---s
      IF g_ooba_d[g_detail_idx2].oobx004 = 'asft304' THEN
         IF l_gszy002 = 'D-MFG-0020' THEN  #完工入库扣账是否自动倒扣
            LET l_gzsz008 = 'Y'
         END IF
         IF l_gszy002 = 'D-MFG-0023' THEN  #可否人工调整工艺
            LET l_gzsz008 = 'Y'
         END IF
         IF l_gszy002 = 'D-MFG-0024' THEN  #工单备料是否必须存在BOM
            LET l_gzsz008 = '2'
         END IF
         IF l_gszy002 = 'D-MFG-0038' THEN  #工单下阶备料生成时机
            LET l_gzsz008 = '3'
         END IF
         IF l_gszy002 = 'D-MFG-0045' THEN  #允许事后报工
            LET l_gzsz008 = 'Y'
         END IF
      END IF
      #160727-00025#1---e      
      INSERT INTO ooac_t (ooacent,ooac001,ooac002,ooac003,ooac004,
                          ooacownid,ooacowndp,ooaccrtid,ooaccrtdp,ooaccrtdt,ooacstus)
      VALUES (g_enterprise,g_ooba_m.ooba001,g_ooba_d[g_detail_idx2].ooba002,l_gszy002,l_gzsz008,
              l_ooacownid,l_ooacowndp,l_ooaccrtid,l_ooaccrtdp,l_ooaccrtdt,l_ooacstus)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooac_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END FOREACH
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aooi200_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_oobb_d.getLength() THEN
         LET g_detail_idx = g_oobb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_oobb2_d.getLength() THEN
         LET g_detail_idx = g_oobb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb2_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_oobb3_d.getLength() THEN
         LET g_detail_idx = g_oobb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb3_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_oobb4_d.getLength() THEN
         LET g_detail_idx = g_oobb4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb4_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_oobb5_d.getLength() THEN
         LET g_detail_idx = g_oobb5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb5_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_oobb6_d.getLength() THEN
         LET g_detail_idx = g_oobb6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb6_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 7 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail7")
      IF g_detail_idx > g_oobb7_d.getLength() THEN
         LET g_detail_idx = g_oobb7_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb7_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb7_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 8 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail8")
      IF g_detail_idx > g_oobb8_d.getLength() THEN
         LET g_detail_idx = g_oobb8_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_oobb8_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_oobb8_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 9 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail10")
      IF g_detail_idx2 > g_ooba_d.getLength() THEN
         LET g_detail_idx2 = g_ooba_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_ooba_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_ooba_d.getLength() TO FORMONLY.cnt
   END IF

   IF g_current_page = 10 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail11")
      IF g_detail_idx2 > g_ooba2_d.getLength() THEN
         LET g_detail_idx2 = g_ooba2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_ooba2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_ooba2_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

PRIVATE FUNCTION aooi200_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING

   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1')  AND
      (cl_null(g_wc2_table6) OR g_wc2_table6.trim() = '1=1')  AND
      (cl_null(g_wc2_table7) OR g_wc2_table7.trim() = '1=1')  AND
      (cl_null(g_wc2_table8) OR g_wc2_table8.trim() = '1=1')  AND 
      (cl_null(g_wc2_table9) OR g_wc2_table9.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   RETURN TRUE
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 4 AND
      ((NOT cl_null(g_wc2_table4) AND g_wc2_table4.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 5 AND
      ((NOT cl_null(g_wc2_table5) AND g_wc2_table5.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 6 AND
      ((NOT cl_null(g_wc2_table6) AND g_wc2_table6.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 7 AND
      ((NOT cl_null(g_wc2_table7) AND g_wc2_table7.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 8 AND
      ((NOT cl_null(g_wc2_table8) AND g_wc2_table8.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   IF ps_idx = 9 AND
      ((NOT cl_null(g_wc2_table9) AND g_wc2_table9.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF

   RETURN FALSE

END FUNCTION

PRIVATE FUNCTION aooi200_gzcb_fill(p_gzsz016)
DEFINE p_gzsz016   LIKE gzsz_t.gzsz016
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_gzszl006  LIKE gzszl_t.gzszl006
DEFINE l_gzszl007  LIKE gzszl_t.gzszl007
DEFINE l_ooac   RECORD
                  ooacownid      LIKE ooac_t.ooacownid,
                  ooacownid_desc LIKE type_t.chr80,
                  ooacowndp      LIKE ooac_t.ooacowndp,
                  ooacowndp_desc LIKE type_t.chr80,
                  ooaccrtid      LIKE ooac_t.ooaccrtid,
                  ooaccrtid_desc LIKE type_t.chr80,
                  ooaccrtdp      LIKE ooac_t.ooaccrtdp,
                  ooaccrtdp_desc LIKE type_t.chr80,
                  ooaccrtdt      DATETIME YEAR TO SECOND,
                  ooacmodid      LIKE ooac_t.ooacmodid,
                  ooacmodid_desc LIKE type_t.chr80,
                  ooacmoddt      DATETIME YEAR TO SECOND
                END RECORD
                
   CALL g_oobb9_d.clear()

   DECLARE gzcb_curs CURSOR FOR 
      SELECT gzcb002,gzcbl004
        FROM gzcb_t
        LEFT OUTER JOIN gzcbl_t ON gzcbl001 = p_gzsz016 AND gzcbl002 = gzcb002 AND gzcbl003 = g_dlang
       WHERE gzcb001 =  p_gzsz016
   LET l_cnt = 1
   FOREACH gzcb_curs INTO g_oobb9_d[l_cnt].gzcb002,g_oobb9_d[l_cnt].gzcbl004  
     
             
        
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_oobb9_d.deleteElement(g_oobb9_d.getLength())
   
   DISPLAY ARRAY g_oobb9_d to s_detail9.*
      BEFORE DISPLAY 
         EXIT DISPLAY
   END DISPLAY 
   SELECT gzszl006,gzszl007 INTO l_gzszl006,l_gzszl007 FROM gzszl_t
    WHERE gzszl001 = 'ooac_t' AND gzszl002 = g_oobb8_d[l_ac].ooac003 AND gzszl003 = g_dlang
   DISPLAY l_gzszl006 TO gzszl006
   DISPLAY l_gzszl007 TO gzszl007
   
   SELECT ooacownid,ooacowndp,ooaccrtid,
          ooaccrtdp,ooaccrtdt,ooacmodid,ooacmoddt 
     INTO l_ooac.ooacownid,l_ooac.ooacowndp,l_ooac.ooaccrtid,l_ooac.ooaccrtdp,
          l_ooac.ooaccrtdt,l_ooac.ooacmodid,l_ooac.ooacmoddt 
     FROM ooac_t
    WHERE ooacent = g_enterprise AND ooac001 = g_ooba_m.ooba001
      AND ooac002 = g_ooba_d[g_detail_idx2].ooba002 AND ooac003 = g_oobb8_d[l_ac].ooac003
   DISPLAY l_ooac.ooacownid TO  ooacownid
   DISPLAY l_ooac.ooacowndp TO  ooacowndp
   DISPLAY l_ooac.ooaccrtid TO  ooaccrtid
   DISPLAY l_ooac.ooaccrtdp TO  ooaccrtdp
   DISPLAY l_ooac.ooaccrtdt TO  ooaccrtdt
   DISPLAY l_ooac.ooacmodid TO  ooacmodid
   DISPLAY l_ooac.ooacmoddt TO  ooacmoddt
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooac.ooacownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET l_ooac.ooacownid_desc = g_rtn_fields[1]
   DISPLAY l_ooac.ooacownid_desc TO ooacownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooac.ooacowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_ooac.ooacowndp_desc = g_rtn_fields[1]
   DISPLAY l_ooac.ooacowndp_desc TO ooacowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooac.ooacmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET l_ooac.ooacmodid_desc = g_rtn_fields[1]
   DISPLAY l_ooac.ooacmodid_desc TO ooacmodid_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooac.ooaccrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET l_ooac.ooaccrtid_desc = g_rtn_fields[1]
   DISPLAY l_ooac.ooaccrtid_desc TO ooaccrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooac.ooaccrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_ooac.ooaccrtdp_desc = g_rtn_fields[1]
   DISPLAY l_ooac.ooaccrtdp_desc TO ooaccrtdp_desc
 
   CALL ui.Interface.refresh()
END FUNCTION

################################################################################
# Descriptions...: 料件確認後，會寄mail給相關負責人
# Memo...........: 
# Usage..........: CALL aooi200_ooac004_chk()
# Input parameter: no
# Return code....: r_gzcb001   系統分類碼
#                : r_gzcal003  說明
# Date & Author..: 
# Modify.........: 150410 by whitney no.150413-00014#1 優化錯誤訊息
################################################################################
PRIVATE FUNCTION aooi200_ooac004_chk()
DEFINE r_gzcb001   LIKE gzcb_t.gzcb001
DEFINE r_gzcal003  LIKE gzcal_t.gzcal003
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_date      LIKE type_t.dat
DEFINE l_str       LIKE gzsz_t.gzsz015
DEFINE l_gzsz  RECORD
    gzsz003    LIKE gzsz_t.gzsz003,
    gzsz015    LIKE gzsz_t.gzsz015,
    gzsz016    LIKE gzsz_t.gzsz016
           END RECORD

   LET g_errno = ''
   LET r_gzcb001 = ''
   LET r_gzcal003 = ''
   
   INITIALIZE l_gzsz.* TO NULL
   SELECT gzsz003,gzsz015,gzsz016
     INTO l_gzsz.gzsz003,l_gzsz.gzsz015,l_gzsz.gzsz016
     FROM gzsz_t 
    WHERE gzsz001 = 'ooac_t'
      AND gzsz002 = g_oobb8_d[l_ac].ooac003
   CASE l_gzsz.gzsz003
      WHEN '1'
           IF g_oobb8_d[l_ac].ooac004 NOT MATCHES '[YN]' THEN
              LET g_errno = '-25777'
           END IF
      WHEN '3'
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt
             FROM gzcb_t
            WHERE gzcb001 = l_gzsz.gzsz016
              AND gzcb002 = g_oobb8_d[l_ac].ooac004
           IF cl_null(l_cnt) OR l_cnt = 0 THEN
              SELECT gzcal003 INTO r_gzcal003
                FROM gzcal_t
               WHERE gzcal001 = l_gzcb001
                 AND gzcal002 = g_dlang
              LET r_gzcb001 = l_gzsz.gzsz016
              LET g_errno = 'azz-00023'
           END IF
      WHEN '5'
           LET l_str = cl_replace_str(l_gzsz.gzsz015,'YYYY','YY')
           SELECT TO_DATE(g_oobb8_d[l_ac].ooac004,l_str) 
             INTO l_date
             FROM dual
           IF SQLCA.sqlcode THEN
              LET g_errno = '-1218'
           ELSE
              LET g_oobb8_d[l_ac].ooac004 = l_date USING l_gzsz.gzsz015
           END IF
   END CASE
   
   RETURN r_gzcb001,r_gzcal003
END FUNCTION
# oobd004欄位控管
PRIVATE FUNCTION aooi200_oobd004_chk()
DEFINE l_n   LIKE type_t.num5
   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oobd_t WHERE "||"oobdent = '" ||g_enterprise|| "' AND "||"oobd001 = '"||g_ooba_m.ooba001 ||"' AND "|| "oobd002 = '"||g_ooba_d[g_detail_idx2].ooba002 ||"' AND "|| "oobd003 = '"||g_oobb3_d[l_ac].oobd003 ||"' AND "|| "oobd004 = '"||g_oobb3_d[l_ac].oobd004 ||"'",'std-00004',0) THEN 
      RETURN FALSE
   END IF
   
   IF NOT s_azzi650_chk_exist(g_oobb3_d[l_ac].oobd003,g_oobb3_d[l_ac].oobd004) THEN
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

PRIVATE FUNCTION aooi200_b2_fill()
   DEFINE p_wc2      STRING
   DEFINE l_gzsz016  LIKE gzsz_t.gzsz016

   CALL g_ooba_d.clear()    #g_oobb_d 單頭及單身
   CALL g_ooba2_d.clear()
   CALL g_oobb_d.clear()    
   CALL g_oobb2_d.clear()

   CALL g_oobb3_d.clear()

   CALL g_oobb4_d.clear()

   CALL g_oobb5_d.clear()

   CALL g_oobb6_d.clear()

   CALL g_oobb7_d.clear()

   CALL g_oobb8_d.clear()

   #判斷是否填充
   IF aooi200_fill_chk(9) THEN
       LET g_sql = "SELECT UNIQUE oobastus,ooba002,oobxl003,oobx002,gzzol003,oobx003,oobx004,gzzal003,oobx005,oobx006,oobx007,oobx008,",
                   "        ooba016,",  #151020-00016 by whitney add       
                   "        ooba002,oobaownid,own.ooag011,oobaowndp,ow.ooefl003,oobacrtid,crt.ooag011,oobacrtdp,cr.ooefl003,oobacrtdt,oobamodid,mod.ooag011,oobamoddt ",
                   "  FROM ooba_t", 
                   "       LEFT JOIN oobx_t ON oobaent = oobxent AND ooba002 = oobx001 ",
                   "       LEFT JOIN oobxl_t ON oobaent = oobxlent AND ooba002 = oobxl001 AND oobxl002 = '",g_lang,"'",
                   "       LEFT JOIN gzzol_t ON oobx002 = gzzol001 AND gzzol002 = '",g_lang,"'",
                   "       LEFT JOIN gzzal_t ON oobx004 = gzzal001 AND gzzal002 = '",g_lang,"'",
                   "       LEFT JOIN ooag_t own ON own.ooagent = oobaent AND own.ooag001 = oobaownid ",
                   "       LEFT JOIN ooag_t crt ON crt.ooagent = oobaent AND crt.ooag001 = oobacrtid ",
                   "       LEFT JOIN ooag_t mod ON mod.ooagent = oobaent AND mod.ooag001 = oobamodid ",
                   "       LEFT JOIN ooefl_t ow ON ow.ooeflent = oobaent AND ow.ooefl001 = oobaowndp AND ow.ooefl002 = '",g_lang,"'",
                   "       LEFT JOIN ooefl_t cr ON cr.ooeflent = oobaent AND cr.ooefl001 = oobacrtdp AND cr.ooefl002 = '",g_lang,"'",
                   #170104-00002#1---add---s                   
                   "       LEFT JOIN oobb_t ON oobbent = oobaent AND ooba001 = oobb001 AND ooba002 = oobb002 ",
                   "       LEFT JOIN oobc_t ON oobcent = oobaent AND ooba001 = oobc001 AND ooba002 = oobc002",
                   "       LEFT JOIN oobd_t ON oobdent = oobaent AND ooba001 = oobd001 AND ooba002 = oobd002",
                   "       LEFT JOIN oobh_t ON oobhent = oobaent AND ooba001 = oobh001 AND ooba002 = oobh002",
                   "       LEFT JOIN oobj_t ON oobjent = oobaent AND ooba001 = oobj001 AND ooba002 = oobj002",
                   "       LEFT JOIN oobk_t ON oobkent = oobaent AND ooba001 = oobk001 AND ooba002 = oobk002",
                   "       LEFT JOIN oobi_t ON oobient = oobaent AND ooba001 = oobi001 AND ooba002 = oobi002",
                   "       LEFT JOIN ooac_t ON ooacent = oobaent AND ooba001 = ooac001 AND ooba002 = ooac002", 
                   #170104-00002#1---add---e                   
                   " WHERE oobaent= ? AND ooba001=?"  
                  
      IF NOT cl_null(g_wc2_table9) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table9 CLIPPED
      END IF     
      #170104-00002#1---add---s
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
      END IF
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table5) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table6) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table7) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
      END IF      
      IF NOT cl_null(g_wc2_table8) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table8 CLIPPED
      END IF            
      #170104-00002#1---add---e                   
      
      LET g_sql = g_sql, " ORDER BY ooba_t.ooba002"
      
      PREPARE aooi200_pb9 FROM g_sql
      DECLARE b_fill_cs9 CURSOR FOR aooi200_pb9
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs9 USING g_enterprise,g_ooba_m.ooba001
 
                                               
      FOREACH b_fill_cs9 INTO g_ooba_d[l_ac].oobastus,g_ooba_d[l_ac].ooba002,g_ooba_d[l_ac].ooba002_desc, 
          g_ooba_d[l_ac].oobx002,g_ooba_d[l_ac].oobx002_desc,g_ooba_d[l_ac].oobx003,g_ooba_d[l_ac].oobx004, 
          g_ooba_d[l_ac].oobx004_desc,g_ooba_d[l_ac].oobx005,g_ooba_d[l_ac].oobx006,g_ooba_d[l_ac].oobx007,g_ooba_d[l_ac].oobx008,
          g_ooba_d[l_ac].ooba016,  #151020-00016 by whitney add
          g_ooba2_d[l_ac].ooba002, g_ooba2_d[l_ac].oobaownid, 
          g_ooba2_d[l_ac].oobaownid_desc,g_ooba2_d[l_ac].oobaowndp,g_ooba2_d[l_ac].oobaowndp_desc,g_ooba2_d[l_ac].oobacrtid, 
          g_ooba2_d[l_ac].oobacrtid_desc,g_ooba2_d[l_ac].oobacrtdp,g_ooba2_d[l_ac].oobacrtdp_desc,g_ooba2_d[l_ac].oobacrtdt, 
          g_ooba2_d[l_ac].oobamodid,g_ooba2_d[l_ac].oobamodid_desc,g_ooba2_d[l_ac].oobamoddt
                   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         CALL s_azzi930_get_module_name(g_ooba_d[l_ac].oobx002)   #15/06/25 Sarah add
              RETURNING g_ooba_d[l_ac].oobx002_desc
            
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
   END IF

   CALL g_ooba_d.deleteElement(g_ooba_d.getLength())
   CALL g_ooba2_d.deleteElement(g_ooba2_d.getLength())
   LET g_rec_b2 = l_ac - 1
   LET l_ac = g_cnt
   LET g_cnt = 0

   FREE aooi200_pb9

END FUNCTION

PRIVATE FUNCTION aooi200_ooba002_ref()
   SELECT oobx002,oobx003,oobx004,oobx005,oobx006,oobx007,oobx008
     INTO g_ooba_d[l_ac].oobx002,g_ooba_d[l_ac].oobx003,g_ooba_d[l_ac].oobx004,
          g_ooba_d[l_ac].oobx005,g_ooba_d[l_ac].oobx006,g_ooba_d[l_ac].oobx007,g_ooba_d[l_ac].oobx008
     FROM oobx_t 
    WHERE oobxent = g_enterprise AND oobx001 = g_ooba_d[l_ac].ooba002 

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
    CALL ap_ref_array2(g_ref_fields," SELECT oobxl003 FROM oobxl_t WHERE oobxlent = '"||g_enterprise||"' AND oobxl001 = ? AND oobxl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_ooba_d[l_ac].ooba002_desc = g_rtn_fields[1]
    DISPLAY BY NAME g_ooba_d[l_ac].ooba002_desc
   
#    INITIALIZE g_ref_fields TO NULL
#    LET g_ref_fields[1] = g_ooba_d[l_ac].oobx002
#    CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_dlang||"'","") RETURNING g_rtn_fields
#    LET g_ooba_d[l_ac].oobx002_desc = g_rtn_fields[1]
    CALL s_azzi930_get_module_name(g_ooba_d[l_ac].oobx002) RETURNING g_ooba_d[l_ac].oobx002_desc   #15/06/25 Sarah add
    DISPLAY BY NAME g_ooba_d[l_ac].oobx002_desc

    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_ooba_d[l_ac].oobx004
    CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_ooba_d[l_ac].oobx004_desc = g_rtn_fields[1]
    DISPLAY BY NAME g_ooba_d[l_ac].oobx004_desc
END FUNCTION

PRIVATE FUNCTION aooi200_s01_ins()
DEFINE l_cnt   LIKE type_t.num5
DEFINE l_sql  STRING
DEFINE l_oobacrtdt DATETIME YEAR TO SECOND
#DEFINE l_ooba  RECORD LIKE ooba_t.*  #161124-00048#7  2016/12/13 By 08734 mark
#161124-00048#7  2016/12/13 By 08734 add(S)
DEFINE l_ooba RECORD  #單據別主檔
       oobastus LIKE ooba_t.oobastus, #状态码
       oobaent LIKE ooba_t.oobaent, #企业编号
       ooba001 LIKE ooba_t.ooba001, #参照表编号
       ooba002 LIKE ooba_t.ooba002, #单据别编号
       ooba008 LIKE ooba_t.ooba008, #可用From
       ooba009 LIKE ooba_t.ooba009, #可用To
       ooba010 LIKE ooba_t.ooba010, #MRP可用From
       ooba011 LIKE ooba_t.ooba011, #MRP可用To
       ooba012 LIKE ooba_t.ooba012, #成本仓From
       ooba013 LIKE ooba_t.ooba013, #成本仓To
       oobaownid LIKE ooba_t.oobaownid, #资料所有者
       oobaowndp LIKE ooba_t.oobaowndp, #资料所有部门
       oobacrtid LIKE ooba_t.oobacrtid, #资料录入者
       oobacrtdp LIKE ooba_t.oobacrtdp, #资料录入部门
       oobacrtdt LIKE ooba_t.oobacrtdt, #资料创建日
       oobamodid LIKE ooba_t.oobamodid, #资料更改者
       oobamoddt LIKE ooba_t.oobamoddt, #最近更改日
       ooba014 LIKE ooba_t.ooba014, #产品分类-正/负向表列
       ooba015 LIKE ooba_t.ooba015, #理由码-正/负向表列
       ooba016 LIKE ooba_t.ooba016, #备注
       ooba017 LIKE ooba_t.ooba017, #控制组-正/负向表列
       ooba018 LIKE ooba_t.ooba018, #生命周期-正/负向表列
       ooba019 LIKE ooba_t.ooba019, #库存标签FROM-正/负向表列
       ooba020 LIKE ooba_t.ooba020 #库存标签TO-正/负向表列
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)  


   LET l_oobacrtdt = cl_get_current()
   LET l_sql = "SELECT 'Y' oobastus,",g_enterprise," oobaent,'",g_ooba_m.ooba001,"' ooba001,oobx001 ooba002,",
               "       'N' ooba008,'N' ooba009,'N' ooba010,'N' ooba011,'N' ooba012,'N' ooba013, ",
               "       '",g_user,"' oobaownid,'",g_dept,"' oobaowndp,",
               "       '",g_user,"' oobacrtid,'",g_dept,"' oobacrtdp,'' oobacrtdt,",
               "       '' oobamodid,'' oobamoddt,'1' ooba014,'1' ooba015, ",
               #"       ooba017,ooba018,ooba019,ooba020 ", #160914-00032#3  #161122-00032#1 mark
               "       '1' ooba017,'1' ooba018,'1' ooba019,'1' ooba020 ", #161122-00032#1 add
#               "       ,ooba016 ",  #151020-00016 by whitney add   #20151103 by stellar mark
               "  FROM aooi200_s01_tmp ",
               " WHERE l_check = 'Y' "
   LET l_sql = "INSERT INTO ooba_t (oobastus,oobaent,ooba001,ooba002,ooba008,ooba009,ooba010,",
               "                    ooba011,ooba012,ooba013,oobaownid,oobaowndp,oobacrtid,oobacrtdp,",
               #20151103 by stellar modify ----- (S)
#               "                    oobacrtdt,oobamodid,oobamoddt,ooba014,ooba015,ooba016) ",l_sql  #151020-00016 by whitney add ooba016
               "                    oobacrtdt,oobamodid,oobamoddt,ooba014,ooba015,ooba017,ooba018,ooba019,ooba020 ) ",l_sql  #160914-00032#3 add ooba017,ooba018,ooba019,ooba020
               #20151103 by stellar modify ----- (E)
   PREPARE ooba_ins_pre FROM l_sql
   EXECUTE ooba_ins_pre

   UPDATE ooba_t  
      SET oobacrtdt = l_oobacrtdt
    WHERE oobaent = g_enterprise
      AND ooba001 = g_ooba_m.ooba001 
      AND ooba002 IN (SELECT oobx001 FROM aooi200_s01_tmp WHERE l_check = 'Y' ) 
     
   #20150831-dorislai-modify----(S)
#  LET l_sql = "SELECT ",g_enterprise,",'",g_ooba_m.ooba001,"',oobx001,gzsy002,'', ",
#              "       '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"','','','','Y' ",
#              "  FROM gzsy_t,aooi200_s01_tmp",
#              " WHERE gzsy003 = oobx002 AND gzsy004 = oobx003 AND gzsy001 = 'ooac_t' AND l_check = 'Y' "
   LET l_sql = "SELECT ",g_enterprise,",'",g_ooba_m.ooba001,"',oobx001,gzsy002,gzsz008, ",
               "       '",g_user,"','",g_dept,"','",g_user,"','",g_dept,"','','','','Y' ",
               "  FROM aooi200_s01_tmp,gzsy_t",
               "  LEFT JOIN gzsz_t ON gzsy001=gzsz001 AND gzsy002=gzsz002 ",
               " WHERE gzsy003 = oobx002 AND gzsy004 = oobx003 AND gzsy001 = 'ooac_t' AND l_check = 'Y' "
   #20150831-dorislai-modify----(E)
   LET l_sql = "INSERT INTO ooac_t (ooacent,ooac001,ooac002,ooac003,ooac004,",
               "                    ooacownid,ooacowndp,ooaccrtid,ooaccrtdp,ooaccrtdt,",
               "                    ooacmodid,ooacmoddt,ooacstus) ",l_sql
   PREPARE ooac_ins_pre FROM l_sql
   EXECUTE ooac_ins_pre  
   
   UPDATE ooac_t  
      SET ooaccrtdt = l_oobacrtdt
    WHERE ooacent = g_enterprise
      AND ooac001 = g_ooba_m.ooba001
      AND ooac002 IN (SELECT oobx001 FROM aooi200_s01_tmp WHERE l_check = 'Y' )  

END FUNCTION

PRIVATE FUNCTION aooi200_show2()
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE l_sql     STRING
   
   LET g_ooba_m_t.* = g_ooba_m.*

   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:show段reference



          {#ADP版次:1#}
   #end add-point

   #將資料輸出到畫面上
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_ooba_m.ooba001
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_ooba_m.ooba001_desc = '', g_rtn_fields[1] , ''
  
   DISPLAY BY NAME g_ooba_m.ooba001,g_ooba_m.ooba001_desc,g_ooba_m.ooba008,g_ooba_m.ooba009,g_ooba_m.ooba010,
           g_ooba_m.ooba011,g_ooba_m.ooba012,g_ooba_m.ooba013,g_ooba_m.ooba014,g_ooba_m.ooba015,
           g_ooba_m.ooba017,g_ooba_m.ooba018,g_ooba_m.ooba019,g_ooba_m.ooba020 #160914-00032#3
   
  # #顯示狀態(stus)圖片
  #       #此段落由子樣板a21產生
  #    CASE g_ooba_m.oobastus
  #       WHEN "N"
  #          CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
  #       WHEN "Y"
  #          CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
  #
  #
  #    END CASE
          
   
   FOR l_ac = 1 TO g_ooba_d.getLength()
#         LET g_ooba2_d[l_ac].oobaownid_desc = cl_get_username(g_ooba2_d[l_ac].oobaownid)
#         LET g_ooba2_d[l_ac].oobaowndp_desc = cl_get_deptname(g_ooba2_d[l_ac].oobaowndp)
#         LET g_ooba2_d[l_ac].oobacrtid_desc = cl_get_username(g_ooba2_d[l_ac].oobacrtid)
#         LET g_ooba2_d[l_ac].oobacrtdp_desc = cl_get_deptname(g_ooba2_d[l_ac].oobacrtdp)
#         LET g_ooba2_d[l_ac].oobamodid_desc = cl_get_username(g_ooba2_d[l_ac].oobamodid)
#         #LET g_ooba_d[l_ac].oobacnfid_desc = cl_get_deptname(g_ooba_d[l_ac].oobacnfid)
#         #LET g_ooba_d[l_ac].oobapstid_desc = cl_get_deptname(g_ooba_d[l_ac].oobapstid)
#         
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobx002,oobx003,oobx004,oobx005 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx002 = g_rtn_fields[1]
#         LET g_ooba_d[l_ac].oobx003 = g_rtn_fields[2]
#         LET g_ooba_d[l_ac].oobx004 = g_rtn_fields[3]
#         LET g_ooba_d[l_ac].oobx005 = g_rtn_fields[4]
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobx006,oobx007,oobx008 FROM oobx_t WHERE oobxent = '"||g_enterprise||"' AND oobx001 = ? ","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx006 = g_rtn_fields[1]
#         LET g_ooba_d[l_ac].oobx007 = g_rtn_fields[2]
#         LET g_ooba_d[l_ac].oobx008 = g_rtn_fields[3]         
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx002,g_ooba_d[l_ac].oobx003,g_ooba_d[l_ac].oobx004,g_ooba_d[l_ac].oobx005,
#                         g_ooba_d[l_ac].oobx006,g_ooba_d[l_ac].oobx007,g_ooba_d[l_ac].oobx008
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].ooba002
#         CALL ap_ref_array2(g_ref_fields," SELECT oobxl003 FROM oobxl_t WHERE oobxlent = '"||g_enterprise||"' AND oobxl001 = ? AND oobxl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].ooba002_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].ooba002_desc
#   
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].oobx002
#         CALL ap_ref_array2(g_ref_fields,"SELECT gzzol003 FROM gzzol_t WHERE gzzol001=? AND gzzol002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx002_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx002_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba_d[l_ac].oobx004
#         CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba_d[l_ac].oobx004_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba_d[l_ac].oobx004_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaownid
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobaownid_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobaownid_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobaowndp
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobaowndp_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobaowndp_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobamodid
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobamodid_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobamodid_desc
#
#         INITIALIZE g_ref_fields TO NULL
#         LET g_ref_fields[1] = g_ooba2_d[l_ac].oobacrtdp
#         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#         LET g_ooba2_d[l_ac].oobacrtdp_desc = g_rtn_fields[1]
#         DISPLAY BY NAME g_ooba2_d[l_ac].oobacrtdp_desc   
   END FOR
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後

   #IF 本筆資料已被鎖住,不可使用open_oobl ACTION
   CALL cl_set_act_visible('open_oobl',TRUE)
  # CALL s_transaction_begin()
  # OPEN aooi200_cl USING g_enterprise,g_ooba_m.ooba001
  # IF STATUS THEN
  #    CALL cl_set_act_visible('open_oobl',FALSE)
  # END IF
  # CALL s_transaction_end('N','0')     
END FUNCTION

PRIVATE FUNCTION aooi200_ecom_get()
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0001') RETURNING g_ecom.ecom001
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0002') RETURNING g_ecom.ecom002
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0003') RETURNING g_ecom.ecom003
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0004') RETURNING g_ecom.ecom004
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0005') RETURNING g_ecom.ecom005
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0008') RETURNING g_ecom.ecom008
END FUNCTION

PRIVATE FUNCTION aooi200_s01()
DEFINE l_sql    STRING
DEFINE l_cnt    LIKE type_t.num5
DEFINE lwin_curr        ui.Window
DEFINE lfrm_curr        ui.Form
DEFINE ls_path          STRING

   LET l_sql = "SELECT 'N',oobx001,oobxl003,oobx002,gzzol003,oobx003, ",
               "       oobx004,gzzal003,oobx005,oobx006,oobx007,oobx008 ",
               "  FROM oobx_t ",
               "  LEFT OUTER JOIN oobxl_t ON oobxent = oobxlent AND oobx001 = oobxl001 AND oobxl002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN gzzol_t ON oobx002 = gzzol001 AND gzzol002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN gzzal_t ON oobx004 = gzzal001 AND gzzal002 = '",g_dlang,"'",
               " WHERE oobxent = '",g_enterprise,"'",
               "   AND oobxstus = 'Y' ",
               "   AND oobx001 NOT IN (SELECT ooba002 FROM ooba_t WHERE oobaent = '",g_enterprise,"' AND ooba001 = '",g_ooba_m.ooba001,"')"  #160818-00026#1 mod oobx002->oobx001
   LET l_sql = "INSERT INTO aooi200_s01_tmp ",
               "(l_check,oobx001,oobx001_desc,oobx002,oobx002_desc,oobx003,",
               " oobx004,oobx004_desc,oobx005,oobx006,oobx007,oobx008) ",l_sql
   PREPARE aooi200_s01_tmp_ins FROM l_sql
   EXECUTE aooi200_s01_tmp_ins
  
   OPEN WINDOW w_aooi200_s01 WITH FORM cl_ap_formpath("aoo","aooi200_s01")
    
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)    
   LET g_s01_wc = " 1=1"
   CALL cl_set_combo_scc('oobx003','24') 
   CALL cl_set_combo_scc('oobx006','14')    
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM) 
      INPUT ARRAY g_oobx_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_ooba_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
            CALL aooi200_s01_fill()
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            DISPLAY g_rec_b TO FORMONLY.cnt
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx
            
         ON CHANGE check
            IF NOT cl_null(g_oobx_d[l_ac].check) THEN 
               IF g_oobx_d[l_ac].check = 'Y' THEN 
                  UPDATE aooi200_s01_tmp 
                     SET l_check = 'Y' 
                   WHERE oobx001 = g_oobx_d[l_ac].oobx001  
               ELSE
                  UPDATE aooi200_s01_tmp 
                     SET l_check = 'N' 
                   WHERE oobx001 = g_oobx_d[l_ac].oobx001         
               END IF
            END IF
            
         AFTER ROW
   
         AFTER INPUT 
         
         ON ACTION check_all
            UPDATE aooi200_s01_tmp 
               SET l_check = 'Y'
            CALL aooi200_s01_fill()               
            CONTINUE DIALOG
             
         ON ACTION uncheck_all  
            UPDATE aooi200_s01_tmp 
               SET l_check = 'N'
            CALL aooi200_s01_fill()               
            CONTINUE DIALOG
         
         ON ACTION query
            CALL aooi200_s01_construct()
            CALL aooi200_s01_fill()
            CONTINUE DIALOG
            
         ON ACTION accept
            ACCEPT DIALOG
      
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG  
            
         ON ACTION close
            LET INT_FLAG = 1
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = 1
            EXIT DIALOG
            
      END INPUT
      
   END DIALOG   
   IF NOT INT_FLAG THEN     
      CALL aooi200_s01_ins()
   END IF
   CLOSE WINDOW w_aooi200_s01
   DROP TABLE aooi200_s01_tmp;
END FUNCTION

PRIVATE FUNCTION aooi200_oobb004_ref()
   SELECT dzep012 INTO g_oobb_d[l_ac].oobb005 FROM dzep_t WHERE dzep002 = g_oobb_d[l_ac].oobb004
END FUNCTION

PRIVATE FUNCTION aooi200_oobb005_desc()
DEFINE l_dzep010  LIKE dzep_t.dzep010
DEFINE l_dzep011  LIKE dzep_t.dzep011
   
   #IF g_oobb_d[l_ac].oobb006 IS NULL THEN   #160816-00033#1 mark
      SELECT dzep010,dzep011 INTO l_dzep010,l_dzep011 FROM dzep_t WHERE dzep002 = g_oobb_d[l_ac].oobb004
      IF l_dzep010 = '03' OR l_dzep010 = '02' AND NOT cl_null(l_dzep011) THEN 
         LET g_oobb_d[l_ac].oobb006 = ''
         SELECT gzcbl004 INTO g_oobb_d[l_ac].oobb006 
           FROM gzcbl_t
          WHERE gzcbl001 = l_dzep011
            AND gzcbl002 = g_oobb_d[l_ac].oobb005
            AND gzcbl003 = g_dlang      
      END IF
   #END IF           #160816-00033#1 mark
END FUNCTION

PRIVATE FUNCTION aooi200_oobb005_chk()
DEFINE l_dzep010  LIKE dzep_t.dzep010
DEFINE l_dzep011  LIKE dzep_t.dzep011
DEFINE l_cnt      LIKE type_t.num5   
DEFINE r_success  LIKE type_t.num5

   LET r_success = TRUE
   IF NOT cl_null(g_oobb_d[l_ac].oobb004) AND NOT cl_null(g_oobb_d[l_ac].oobb005) THEN
      SELECT dzep010,dzep011 INTO l_dzep010,l_dzep011 FROM dzep_t WHERE dzep002 = g_oobb_d[l_ac].oobb004
      IF l_dzep010 = '03' OR l_dzep010 = '02' AND NOT cl_null(l_dzep011) THEN
         LET l_cnt = 0      
         SELECT COUNT(*) INTO l_cnt
           FROM gzcb_t
          WHERE gzcb001 = l_dzep011
            AND gzcb002 = g_oobb_d[l_ac].oobb005
         IF l_cnt = 0 THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00294'
            LET g_errparam.extend = g_oobb_d[l_ac].oobb005
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            LET g_oobb_d[l_ac].oobb005 = g_oobb_d_t.oobb005
            LET r_success = FALSE 
         END IF        
      END IF
   END IF
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 自動檢查單據別參數有沒有資料,沒有的就補上
# Memo...........:
# Usage..........: CALL aooi200_ooac_fill(p_ooba002,p_oobx003)
# Input parameter: p_ooba002   單據別編號
#                : p_oobx003   單據性質
# Return code....: 無
# Date & Author..: 14/11/04 By Sarah
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi200_ooac_fill(p_ooba002,p_oobx003)
DEFINE p_ooba002       LIKE ooba_t.ooba002
DEFINE p_oobx003       LIKE oobx_t.oobx003
DEFINE l_flag          LIKE type_t.num5
DEFINE l_oobaent       LIKE ooba_t.oobaent
DEFINE l_ooba001       LIKE ooba_t.ooba001
DEFINE l_ooba002       LIKE ooba_t.ooba002
#DEFINE l_gzsy          RECORD LIKE gzsy_t.*  #161124-00048#7  2016/12/13 By 08734 mark 
#161124-00048#7  2016/12/13 By 08734 add(S)
DEFINE l_gzsy RECORD  #單據別參數單據性質表
       gzsy001 LIKE gzsy_t.gzsy001, #表格编号
       gzsy002 LIKE gzsy_t.gzsy002, #参数编号
       gzsy003 LIKE gzsy_t.gzsy003, #模组别
       gzsy004 LIKE gzsy_t.gzsy004, #关联单据性质
       gzsy005 LIKE gzsy_t.gzsy005 #已抛转
END RECORD
#161124-00048#7  2016/12/13 By 08734 add(E)
DEFINE l_gzsz008       LIKE gzsz_t.gzsz008
DEFINE l_success       LIKE type_t.num5

   IF p_ooba002 IS NULL OR p_oobx003 IS NULL THEN RETURN END IF

   LET l_flag = FALSE

   #依據傳入的單據性質(gzsy004)與單據別參數編號(gzsy002)，
   #抓出應該要寫入的單據別參照表號(ooba001)、單據別(ooba002)，
   #以此為基準一筆一筆寫入ooac_t
   DECLARE sel_ooba_cur CURSOR FOR
      #SELECT oobaent,ooba001,ooba002,gzsy_t.*,gzsz008  #161124-00048#7  2016/12/13 By 08734 mark
      SELECT oobaent,ooba001,ooba002,gzsy001,gzsy002,gzsy003,gzsy004,gzsy005,gzsz008  #161124-00048#7  2016/12/13 By 08734 add
        FROM ooba_t
       INNER JOIN oobx_t ON oobaent=oobxent AND ooba002=oobx001
       INNER JOIN gzsy_t ON gzsy004=oobx003 AND gzsy001='ooac_t'
        LEFT JOIN gzsz_t ON gzsz002=gzsy002 AND gzsz001='ooac_t'
       WHERE ooba002 = p_ooba002
         AND oobx003 = p_oobx003
         #AND NOT EXISTS (SELECT * FROM ooac_t  #161124-00048#7  2016/12/13 By 08734 mark
         AND NOT EXISTS (SELECT ooacent,ooac001,ooac002,ooac003,ooac004,ooacownid,ooacowndp,ooaccrtid,ooaccrtdp,ooaccrtdt,ooacmodid,ooacmoddt,ooacstus FROM ooac_t  #161124-00048#7  2016/12/13 By 08734 add
                          WHERE ooacent=oobaent
                            AND ooac001=ooba001
                            AND ooac002=ooba002
                            AND ooac003=gzsy002)
   FOREACH sel_ooba_cur INTO l_oobaent,l_ooba001,l_ooba002,l_gzsy.*,l_gzsz008
      CALL s_azzi991_insert_ooac(l_oobaent,l_ooba001,l_ooba002,l_gzsy.gzsy002,l_gzsz008,'2')
           RETURNING l_success
      IF NOT l_success THEN
         EXIT FOREACH
      END IF    
      
      LET l_flag = TRUE   
      
      #更新gzsy_t的已拋轉='Y'
      UPDATE gzsy_t SET gzsy005 = 'Y'
       WHERE gzsy001 = l_gzsy.gzsy001
         AND gzsy002 = l_gzsy.gzsy002
         AND gzsy004 = l_gzsy.gzsy004
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         LET l_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF l_flag THEN
      CALL aooi200_b_fill('0') #單身填充
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aooi200_ooba001_desc(p_ooba001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION aooi200_ooba001_desc(p_ooba001)
DEFINE   p_ooba001    LIKE ooba_t.ooba001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_ooba001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='3' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooba_m.ooba001_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooba_m.ooba001_desc
END FUNCTION

PRIVATE FUNCTION aooi200_s01_construct()
DEFINE ls_wc  STRING

   CLEAR FORM
   CALL g_oobx_d.clear()
   
   LET ls_wc = g_s01_wc
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)   
      CONSTRUCT g_s01_wc ON oobx001,oobx002,oobx003,oobx004,oobx005,oobx006,oobx007,oobx008    
           FROM s_detail1[1].oobx001,s_detail1[1].oobx002,s_detail1[1].oobx003,s_detail1[1].oobx004,
                s_detail1[1].oobx005,s_detail1[1].oobx006,s_detail1[1].oobx007,s_detail1[1].oobx008
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD oobx001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_oobx001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx001  #顯示到畫面上

            NEXT FIELD oobx001                     #返回原欄位

         ON ACTION controlp INFIELD oobx002
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_gzzj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx002  #顯示到畫面上

            NEXT FIELD oobx002                     #返回原欄位

         ON ACTION controlp INFIELD oobx003
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '24'
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx003  #顯示到畫面上
            NEXT FIELD oobx003                     #返回原欄位

         ON ACTION controlp INFIELD oobx004
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_gzzz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oobx004  #顯示到畫面上

            NEXT FIELD oobx004                     #返回原欄位
         
      END CONSTRUCT
      BEFORE DIALOG 
         CALL cl_qbe_init()
         
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         CANCEL DIALOG
         
   END DIALOG         
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_s01_wc = ls_wc
   END IF      
END FUNCTION

#end add-point
 
{</section>}
 
