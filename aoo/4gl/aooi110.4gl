#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0023(2014-08-22 10:53:35), PR版次:0023(2016-12-20 11:08:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000848
#+ Filename...: aooi110
#+ Description: 組織計劃申請作業
#+ Creator....: 02482(2013-07-01 00:00:00)
#+ Modifier...: 02294 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi110.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#151110-00030#1   2015/11/11  By Shiun 'ON ACTION unconf'少了權限控管
#151125-00001#3   2015/11/27  By Charles4m 增加詢問是否作廢。
#160224-00003#1   2016/02/24  By lixiang 根据上一版本带预设值时：新版本的生效日期要按上一版本的失效日期+1，新版本的失效日期要清空
#160203-00004#1   2016/03/15  By zhujing for HR整合將aooi110的確認段程式單獨做成元件
#160318-00025#45  2016/04/19  by 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160519-00039#1   2016/05/25  By catmoon INSERT狀態時，若變更類型(ooeb003)由新增改為修改或刪除，版本(ooeb006)需清空且開放輸入
#160812-00017#4   2016/08/15  By 06814   在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160905-00007#8   2016/09/05  By 07900   调整系统中无ENT的SQL条件增加ent
#160922-00021#1   2016/09/23  By lixiang 已确认状态下生成当前组织架构档按钮 可以使用
#161019-00017#2   2016/10/20  By lixh    q_ooef001 开窗参数没有初始化
#161108-00012#2   2016/11/09  By 08734   g_browser_cnt 由num5改為num10
#161124-00048#7   2016/12/12  By 08734   星号整批调整
#161214-00032#2   2016/12/15  By 07900   石狮通达权限设置.freestyle或者是改过section者,需检核规格【资料表关联设定】主表要跟现在程序主表一致;主sql部分要补上cl_sql_add_filter
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單頭 type 宣告
 type type_g_ooeb_m        RECORD
   ooeb001 LIKE ooeb_t.ooeb001,
   ooeb002 LIKE ooeb_t.ooeb002,
   ooeb003 LIKE ooeb_t.ooeb003,
   ooeb004 LIKE ooeb_t.ooeb004,
   ooeb005 LIKE ooeb_t.ooeb005,
   ooeb006 LIKE ooeb_t.ooeb006,
   ooeb005_desc LIKE type_t.chr80,
   ooeb007 LIKE ooeb_t.ooeb007,
   ooeb008 LIKE ooeb_t.ooeb008,
   ooebstus LIKE ooeb_t.ooebstus,
   ooebmodid LIKE ooeb_t.ooebmodid,
   ooebmodid_desc LIKE type_t.chr80,
   ooebmoddt DATETIME YEAR TO SECOND,
   ooebownid LIKE ooeb_t.ooebownid,
   ooebownid_desc LIKE type_t.chr80,
   ooebowndp LIKE ooeb_t.ooebowndp,
   ooebowndp_desc LIKE type_t.chr80,
   ooebcrtid LIKE ooeb_t.ooebcrtid,
   ooebcrtid_desc LIKE type_t.chr80,
   ooebcrtdp LIKE ooeb_t.ooebcrtdp,
   ooebcrtdp_desc LIKE type_t.chr80,
   ooebcrtdt DATETIME YEAR TO SECOND
       END RECORD

TYPE type_g_ooef_d        RECORD
   check   LIKE type_t.chr1,
   ooef001 LIKE ooef_t.ooef001,
   ooef001_desc LIKE type_t.chr80,
   ooef017 LIKE ooef_t.ooef017,
   ooef017_desc LIKE type_t.chr80
       END RECORD

#模組變數(Module Variables)
DEFINE g_ooeb_m          type_g_ooeb_m
DEFINE g_ooeb_m_t        type_g_ooeb_m
DEFINE g_ooeb_m_o        type_g_ooeb_m

DEFINE g_ooeb001_t     LIKE ooeb_t.ooeb001


DEFINE g_ooef_d          DYNAMIC ARRAY OF type_g_ooef_d
DEFINE g_ooef_d_t        type_g_ooef_d


DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_ooeb001 LIKE ooeb_t.ooeb001
         #,rank           LIKE type_t.num10
      END RECORD

DEFINE g_browser_f  RECORD    #資料瀏覽之欄位
         b_statepic     LIKE type_t.chr50,
            b_ooeb001 LIKE ooeb_t.ooeb001
         #,rank           LIKE type_t.num10
      END RECORD

#無單頭append欄位定義
#無單身append欄位定義

DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10  #161108-00012#2 num5==》num10
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

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列

DEFINE g_wc_table1           STRING             

DEFINE g_wc_table2           STRING 
DEFINE g_flag2               LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_rec_b2              LIKE type_t.num10  #161108-00012#2 num5==》num10
DEFINE g_flag3              LIKE type_t.num10  #161108-00012#2 num5==》num10
{</Module define>}
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_wcb                 STRING
DEFINE g_tree      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
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
       b_ooed001       LIKE ooed_t.ooed001,
       b_ooed002       LIKE ooed_t.ooed002,
       b_ooed003       LIKE ooed_t.ooed003,
       b_ooed004       LIKE ooed_t.ooed004,
       b_ooed004_desc  LIKE type_t.chr80,
       b_ooed005       LIKE ooed_t.ooed005
       END RECORD 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="aooi110.main" >}
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
   CALL aooi110_crt_tmp()
   
   LET g_flag2 = FALSE
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
                  LET g_forupd_sql = "SELECT ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,'',ooeb007,ooeb008,ooebstus,ooebmodid,'',ooebmoddt,ooebownid,'',ooebowndp,'',ooebcrtid,'',ooebcrtdp,'',ooebcrtdt FROM ooeb_t WHERE ooebent= ? AND ooeb001=? FOR UPDATE"
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE aooi110_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
                              
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aooi110 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aooi110_init()
 
      #進入選單 Menu (='N')
      CALL aooi110_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_aooi110
   END IF
 
   #add-point:作業離開前 name="main.exit"
               
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="aooi110.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
#檢查是否有下層
PRIVATE FUNCTION aooi110_chk_hasC1(p_ooed002,p_ooed005)
DEFINE p_ooed002     LIKE ooed_t.ooed002
DEFINE p_ooed005     LIKE ooed_t.ooed005
DEFINE li_cnt        INTEGER

   LET g_sql = "SELECT COUNT(*) FROM ooed_tmp ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed002 = '",p_ooed002,"' ",
               "   AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed005 = ? "
   PREPARE aooi110_master_chk2 FROM g_sql
   EXECUTE aooi110_master_chk2 USING p_ooed005 INTO li_cnt
   FREE aooi110_master_chk2
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

PRIVATE FUNCTION aooi110_init()
   #add-point:init段define
   
   #end add-point

   #add-point:畫面資料初始化
   
   CALL cl_set_combo_scc('ooeb004',100)
   CALL cl_set_combo_scc('ooeb003',101)
   
   LET g_flag = 'Y'
   #end add-point

   CALL cl_set_combo_scc_part('ooebstus','13','N,X,Y')

   CALL aooi110_default_search()

END FUNCTION

PRIVATE FUNCTION aooi110_ui_dialog()
   {<Local define>}
   DEFINE li_idx  LIKE type_t.num10  #161108-00012#2 num5==》num10
   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE l_id        LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE l_status    LIKE type_t.num5
   DEFINE l_value     STRING
   DEFINE arr_left    DYNAMIC ARRAY OF STRING
   DEFINE arr_right   DYNAMIC ARRAY OF STRING
   DEFINE l_dnd       ui.DragDrop
   DEFINE l_source    STRING
   DEFINE l_target    STRING
   DEFINE l_ac1       STRING
   DEFINE l_ac2       STRING
   DEFINE l_ooec004   LIKE ooec_t.ooec004
   DEFINE l_ooec004_1 LIKE ooec_t.ooec004
   DEFINE l_ooec002   LIKE ooec_t.ooec002
   DEFINE l_ooec002_1 LIKE ooec_t.ooec002
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_ooec004_t LIKE ooec_t.ooec004
   DEFINE l_ooec005_t LIKE ooec_t.ooec005
   DEFINE l_n2         LIKE type_t.num5
   DEFINE l_n3         LIKE type_t.num5
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_ooed004          LIKE ooed_t.ooed004
   DEFINE l_ooefl003         LIKE ooefl_t.ooefl003
   DEFINE l_errno            LIKE type_t.chr80
   DEFINE l_ooed003          LIKE ooed_t.ooed003
   DEFINE l_ooed006          LIKE ooed_t.ooed006
   DEFINE l_ooed007          LIKE ooed_t.ooed007
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   CALL cl_set_act_visible("accept,cancel", FALSE)

   #該樣板不需此段落CALL gfrm_curr.setElementImage("logo","logo/applogo.png")
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("mainlayout",1)
   #該樣板不需此段落CALL gfrm_curr.setElementHidden("worksheet",0)
   LET g_main_hidden = 1

   #add-point:ui_dialog段before dialog

   #end add-point

   WHILE TRUE

      CALL aooi110_browser_fill("")
      #該樣板不需此段落CALL lib_cl_dlg.cl_query_bef_disp()
      #該樣板不需此段落CALL lib_cl_dlg.cl_relate_bef_disp()
      #該樣板不需此段落CALL cl_notice()

      #CALL lib_cl_dlg.cl_query_bef_disp()
      #CALL lib_cl_dlg.cl_relate_bef_disp()


      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_ooeb001 = g_ooeb001_t
      
               THEN
               LET g_current_row = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
      
      LET g_flag = 'Y'
      IF g_ooeb_m.ooeb003 = '2' AND (g_ooeb_m.ooeb007 <= g_today AND (g_ooeb_m.ooeb008 > g_today OR g_ooeb_m.ooeb008 IS NULL))THEN
         LET g_flag = 'N'
      END IF
      
      IF g_ooeb_m.ooebstus = 'N' AND (g_ooeb_m.ooeb003 = '1' OR (g_ooeb_m.ooeb003 = '2' AND g_flag = 'Y')) THEN
         
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
            DISPLAY ARRAY g_tree TO s_tree.*
         
               ON DRAG_START(l_dnd)
                  LET l_source="RIGHT"
                  LET l_ac1 = ARR_CURR()
                  LET arr_right[l_ac1] = g_tree[l_ac1].b_ooed004
                  LET l_value = arr_right[l_ac1]
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM ooec_t
                   WHERE ooecent = g_enterprise
                     AND (ooec004 = g_tree[l_ac1].b_ooed004
                         OR ooec005 = g_tree[l_ac1].b_ooed004)
                     AND ooec002 = g_ooeb_m.ooeb005
                     AND ooec001 = g_ooeb_m.ooeb004
                     AND ooec008 = g_ooeb_m.ooeb001
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00130'
                     LET g_errparam.extend = l_value
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                  END IF
                  LET l_ooec004_t = g_tree[l_ac1].b_ooed004
                  LET l_ooec005_t = g_tree[l_ac1].b_ooed005
                  IF cl_null(l_ooec005_t) THEN
                     LET l_ooec005_t = g_ooeb_m.ooeb005
                  END IF
               ON DRAG_FINISHED(l_dnd)
                  INITIALIZE l_source TO NULL
         
               ON DRAG_ENTER(l_dnd)
                   IF l_source IS NULL THEN
                      CALL l_dnd.setOperation(NULL)
                   END IF
               ON DROP(l_dnd)
                   LET l_ac1 = l_dnd.getLocationRow()
                   LET l_n = 0
                   SELECT COUNT(*) INTO l_n
                     FROM ooec_t
                    WHERE ooecent = g_enterprise
                      AND (ooec004 = g_tree[l_ac1].b_ooed004
                          OR ooec005 = g_tree[l_ac1].b_ooed004)
                      AND ooec002 = g_ooeb_m.ooeb005
                      AND ooec001 = g_ooeb_m.ooeb004
                      AND ooec008 = g_ooeb_m.ooeb001
                   IF l_n = 0 AND NOT cl_null(g_tree[l_ac1].b_ooed004) THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00130'
                      LET g_errparam.extend = g_tree[l_ac1].b_ooed004
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                   ELSE
                      IF l_source == "RIGHT" THEN
                         #樹中互相拖
                         CALL s_transaction_begin()
                         
                         IF cl_null(l_ooec005_t) THEN
                            LET l_ooec005_t = g_ooeb_m.ooeb005
                         END IF
                         
                         #DELETE FROM ooec_t
                         # WHERE ooecent = g_enterprise
                         #   AND ooec001 = g_ooeb_m.ooeb004
                         #   AND ooec002 = g_ooeb_m.ooeb005
                         #   AND ooec003 = g_ooeb_m.ooeb006
                         #   AND ooec004 = l_ooec004_t
                         #   AND ooec005 = l_ooec005_t
                         #   AND ooec008 = g_ooeb_m.ooeb001
                         #   
                         #IF SQLCA.SQLcode  THEN 
                         #   INITIALIZE g_errparam TO NULL
                         #   LET g_errparam.code = SQLCA.sqlcode
                         #   LET g_errparam.extend = "ooec_t"
                         #   LET g_errparam.popup = TRUE
                         #   CALL cl_err()
                         #
                         #   CALL s_transaction_end('N','0') 
                         #END IF
                         
                         IF cl_null(g_tree[l_ac1].b_ooed005) THEN
                            LET g_tree[l_ac1].b_ooed005 = g_ooeb_m.ooeb005
                         END IF
                          
                         #INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008)
                         #    VALUES(g_enterprise,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_tree[l_ac1].b_ooed004,g_tree[l_ac1].b_ooed005,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooeb001)
                         #
                         UPDATE ooec_t SET ooec005 = g_tree[l_ac1].b_ooed004
                          WHERE ooecent = g_enterprise
                            AND ooec001 = g_ooeb_m.ooeb004
                            AND ooec002 = g_ooeb_m.ooeb005
                            AND ooec003 = g_ooeb_m.ooeb006
                            AND ooec004 = l_ooec004_t
                            AND ooec005 = l_ooec005_t
                            AND ooec008 = g_ooeb_m.ooeb001
                            
                         IF SQLCA.SQLcode  THEN 
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = SQLCA.sqlcode
                            LET g_errparam.extend = "ooec_t"
                            LET g_errparam.popup = TRUE
                            CALL cl_err()

                            CALL s_transaction_end('N','0') 
                         END IF
                         CALL s_transaction_end('Y','0') 
                         
                         CALL l_dnd.dropInternal()
                         
                         IF cl_null(g_tree[l_ac1].b_show) THEN
                            CALL g_tree.deleteElement(l_ac1)
                         END IF
                         FOR l_n2 = 1 TO g_tree.getLength()
                            LET g_tree[l_n2].b_hasC = aooi110_chk_hasC1(g_tree[l_n2].b_ooed002,g_tree[l_n2].b_ooed004)
                         END FOR
                      ELSE
                         #從備選單身拖到樹中
                         LET l_ac2 = l_dnd.getLocationRow()
                         LET l_ooec004 = g_tree[l_ac2].b_ooed004
                         CALL DIALOG.insertRow("s_tree",l_ac1)
                         CALL DIALOG.setCurrentRow("s_tree",l_ac1)
                         IF cl_null(l_ac1) THEN
                            LET l_ac1 = l_dnd.getLocationRow()
                         END IF
                         
                         FOR li_idx = 1 TO arr_left.getLength()
                            LET arr_right[l_ac1] = arr_left[li_idx]
                  
                            #LET arr_right[l_ac1] = l_value
                            LET g_tree[l_ac1].b_show =  arr_right[l_ac1]
                            LET g_tree[l_ac1].b_ooed004 =  arr_right[l_ac1]
                            LET g_tree[l_ac1].b_ooed005 =  l_ooec004
                            
                            IF cl_null(g_tree[l_ac2+1].b_show) THEN
                               CALL DIALOG.deleteRow("s_tree",l_ac2+1)
                               CALL g_tree.deleteElement(l_ac2+1)
                            END IF
                            
                            IF cl_null(g_tree[l_ac1].b_ooed005) THEN
                               LET g_tree[l_ac1].b_ooed005 = g_ooeb_m.ooeb005
                            END IF
                            
                            CALL s_transaction_begin()
                            
                            INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008)
                                VALUES(g_enterprise,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_tree[l_ac1].b_ooed004,g_tree[l_ac1].b_ooed005,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooeb001)
                            
                            IF SQLCA.SQLcode  THEN 
                               INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = SQLCA.sqlcode
                            LET g_errparam.extend = "ooec_t"
                            LET g_errparam.popup = TRUE
                            CALL cl_err()

                               CALL s_transaction_end('N','0') 
                            ELSE
                               CALL s_transaction_end('Y','0') 
                            END IF
                            
                            FOR l_n2 = 1 TO g_tree.getLength()
                                LET g_tree[l_n2].b_hasC = aooi110_chk_hasC1(g_tree[l_n2].b_ooed002,g_tree[l_n2].b_ooed004)
                            END FOR
                         END FOR
                      END IF
                      #CALL aooi110_tree_fill()
                      CALL aooi110_tree_refresh()
                      CALL aooi110_ooef_fill()
                   END IF
         
            END DISPLAY
            
            DISPLAY ARRAY g_ooef_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b2) #page1
         
               BEFORE ROW
                  CALL aooi110_idx_chk()
         
               BEFORE DISPLAY
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
                  LET l_ac = DIALOG.getCurrentRow("s_detail1")
                  CALL aooi110_idx_chk()
                  LET g_current_page = 1
                  
               ON DRAG_START(l_dnd)
                  LET l_source="LEFT"
                  LET l_ac = ARR_CURR()
                  LET l_i = 1
                  CALL arr_left.clear()
                  FOR li_idx = 1 TO g_ooef_d.getLength()
                     IF DIALOG.isRowSelected("s_detail1",li_idx) THEN
                        LET arr_left[l_i] = g_ooef_d[li_idx].ooef001
                        LET l_i = l_i + 1
                     END IF
                  END FOR
                  #LET arr_left[l_ac] = g_ooef_d[l_ac].ooef001
                  #LET l_value = arr_left[l_ac]

               ON DRAG_FINISHED(l_dnd)
                  INITIALIZE l_source TO NULL
               
               ON DRAG_ENTER(l_dnd)
                   IF l_source IS NULL THEN
                      CALL l_dnd.setOperation(NULL)
                   END IF
                   
               ON DROP(l_dnd)
                   IF l_source == "LEFT" THEN
                      CALL l_dnd.dropInternal()
                   ELSE
                      #從樹拖單身
                      LET l_ac = l_dnd.getLocationRow()
                      CALL DIALOG.insertRow("s_detail1",l_ac)
                      CALL DIALOG.setCurrentRow("s_detail1",l_ac)
                      IF cl_null(l_ac) THEN
                         LET l_ac = l_dnd.getLocationRow()
                      END IF
                      LET arr_left[l_ac]= l_value
                      LET g_ooef_d[l_ac].ooef001= arr_left[l_ac]
                      #LET g_ooef_d[l_ac].ooec005= l_ooec005_t
                      
                      CALL DIALOG.deleteRow("s_tree",l_ac1)
                      
                      IF cl_null(l_ooec005_t) THEN
                         LET l_ooec005_t = g_ooeb_m.ooeb005
                      END IF
                      
                      CALL s_transaction_begin()
                         
                      DELETE FROM ooec_t
                       WHERE ooecent = g_enterprise
                         AND ooec001 = g_ooeb_m.ooeb004
                         AND ooec002 = g_ooeb_m.ooeb005
                         AND ooec003 = g_ooeb_m.ooeb006
                         AND ooec004 = g_ooef_d[l_ac].ooef001
                         AND ooec005 = l_ooec005_t
                         AND ooec008 = g_ooeb_m.ooeb001
                         
                      IF SQLCA.SQLcode  THEN 
                         INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = SQLCA.sqlcode
                            LET g_errparam.extend = "ooec_t"
                            LET g_errparam.popup = TRUE
                            CALL cl_err()

                         CALL s_transaction_end('N','0') 
                      END IF
                      
                      #判斷當前的節點 是否存在子節點，若存在子節點，則把下面的子節點也全部移除
                      IF NOT aooi110_del_child(g_ooef_d[l_ac].ooef001) THEN
                         CALL s_transaction_end('N','0') 
                      ELSE
                         CALL s_transaction_end('Y','0') 
                      END IF
                      
                      FOR l_n2 = 1 TO g_tree.getLength()
                          LET g_tree[l_n2].b_hasC = aooi110_chk_hasC1(g_tree[l_n2].b_ooed002,g_tree[l_n2].b_ooed004)
                      END FOR
                      #CALL aooi110_tree_fill()
                      CALL aooi110_tree_refresh()
                      CALL aooi110_ooef_fill()
                   END IF
         
            END DISPLAY
         
            #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_qryplan
            #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_relateapps
         
            BEFORE DIALOG
               #調整
               CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_page = "first"
               LET g_current_sw = FALSE
               #回歸舊筆數位置 (回到當時異動的筆數)
               #該樣板不需此段落LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               #該樣板不需此段落IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               #該樣板不需此段落   CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               #該樣板不需此段落   LET g_current_idx = g_current_row
               #該樣板不需此段落END IF
              #IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  LET g_current_idx = g_current_row
               END IF
         
               LET g_current_row = g_current_idx #目前指標
               IF g_current_idx = 0 THEN
                  LET g_current_idx = 1
               END IF
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF
         
               #有資料才進行fetch
               IF g_current_idx <> 0 THEN
                  CALL aooi110_fetch('') # reload data
               END IF
#               CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
               LET g_detail_idx = 1
               CALL aooi110_ui_detailshow() #Setting the current row
         
               #筆數顯示
               LET g_current_page = 1
               CALL aooi110_idx_chk()
         
               #add-point:ui_dialog段before_dialog
               
               #單身可多選的關鍵 
               CALL DIALOG.setSelectionMode("s_detail1",1)
               #end add-point
         
         
            ON ACTION statechange
               CALL aooi110_statechange()
               LET g_action_choice = "statechange"
               EXIT DIALOG
         
            #簽核
            ON ACTION signature
               MENU "" ATTRIBUTES( STYLE="popup", IMAGE="tb/authorize/terminate.png" )
                  ON ACTION ef_sign
                  ON ACTION stop_authflow
                  ON ACTION add_auth
                  ON ACTION revoke_auth
                  ON ACTION approve
                  ON ACTION unapprove
                  ON ACTION auth_opinion
                  ON ACTION auth_status
                  ON ACTION auth_attach
                  ON ACTION authflow_designer
               END MENU
         
            #ACTION表單列
            #該樣板不需此段落ON ACTION filter
            #該樣板不需此段落   CALL aooi110_filter()
            #該樣板不需此段落   EXIT DIALOG
         
            ON ACTION first
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION previous
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION jump
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION next
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION last
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION close
               LET INT_FLAG=FALSE
               LET g_action_choice = "exit"
               EXIT WHILE
         
            ON ACTION exit
               LET g_action_choice = "exit"
               EXIT WHILE
         
            #該樣板不需此段落ON ACTION bw_first               #page first
            #該樣板不需此段落   CALL aooi110_browser_fill("F")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
         
            #該樣板不需此段落ON ACTION bw_prev                #page previous
            #該樣板不需此段落   CALL aooi110_browser_fill("P")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
         
            #該樣板不需此段落ON ACTION bw_next                #page next
            #該樣板不需此段落   CALL aooi110_browser_fill("N")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
         
            #該樣板不需此段落ON ACTION bw_last                #page last
            #該樣板不需此段落   CALL aooi110_browser_fill("L")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
         
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
         
            #該樣板不需此段落ON ACTION worksheethidden   #瀏覽頁折疊
            #該樣板不需此段落   IF g_main_hidden THEN
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",0)
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",1)
            #該樣板不需此段落      LET g_main_hidden = 0
            #該樣板不需此段落   ELSE
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",1)
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",0)
            #該樣板不需此段落      LET g_main_hidden = 1
            #該樣板不需此段落   END IF
         
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
         
         
         
            ON ACTION modify
         
               LET g_action_choice="modify"
               IF cl_auth_chk_act("modify") THEN
                  CALL aooi110_modify()
                  #add-point:ON ACTION modify
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF
         
         
         
            ON ACTION insert
         
               LET g_action_choice="insert"
               IF cl_auth_chk_act("insert") THEN
                  CALL aooi110_insert()
                  #add-point:ON ACTION insert
                  
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF
         
         
            ON ACTION query
         
               LET g_action_choice="query"
               IF cl_auth_chk_act("query") THEN
                  CALL aooi110_query()
                  #add-point:ON ACTION query
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
               END IF
         
         
            ON ACTION reproduce
         
               LET g_action_choice="reproduce"
               IF cl_auth_chk_act("reproduce") THEN
                  CALL aooi110_reproduce()
                  #add-point:ON ACTION reproduce
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                   EXIT DIALOG
               END IF
         
         
            ON ACTION produce
         
               LET g_action_choice="produce"
               IF cl_auth_chk_act("produce") THEN
                  
                  CALL s_transaction_begin()

                  IF NOT aooi110_produce() THEN
                     CALL s_transaction_end('N','0')
                  ELSE
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     IF g_flag3 THEN
                        LET g_errparam.code = ""
                     ELSE
                        LET g_errparam.code = "aoo-00362"
                     END IF
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err() 
                     LET g_flag3 = FALSE
                  END IF
                  
                  EXIT DIALOG
               END IF
               
            ON ACTION aooi100
         
               LET g_action_choice="aooi100"
               IF cl_auth_chk_act("aooi100") THEN
                  #add-point:ON ACTION produce
                  
                  CALL cl_cmdrun("aooi100")
                  
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
         
         
            ON ACTION delete
         
               LET g_action_choice="delete"
               IF cl_auth_chk_act("delete") THEN
                  CALL aooi110_delete()
                  #add-point:ON ACTION delete
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF
         
            ON ACTION ins_aooi100
               LET g_action_choice="ins_aooi100"
               IF cl_auth_chk_act("ins_aooi100") THEN
                  LET la_param.prog = 'aooi100'
                  LET la_param.param[1] = 'insert'
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
                  #CALL cl_cmdrun("aooi100 'insert' ")
                  LET g_flag2 = TRUE
                  CALL aooi110_ooef_fill()
                  EXIT DIALOG
               END IF
            
            ON ACTION upd_aooi100
               LET g_action_choice="upd_aooi100"
               IF cl_auth_chk_act("upd_aooi100") THEN
                  IF l_ac > 0 THEN
                     LET la_param.prog = 'aooi100'
                     LET la_param.param[1] = g_ooef_d[l_ac].ooef001
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
                     #CALL cl_cmdrun("aooi100 '"||g_ooef_d[l_ac].ooef001||"'")
                  END IF
                  LET g_flag2 = TRUE
                  CALL aooi110_ooef_fill()
                  EXIT DIALOG
               END IF
            
            #1.單身停在某一筆組織資料,按下 '刪除組織'action時, 
            #   開窗詢問是否確定刪除, 'Y'則刪除該筆組織資料, 保存关闭窗口后自动刷新單身組織資料頁面
            #2.本功能應搭配一支共用程式, check該組織是否已有相關的業務單據資料, 
            #    IF yes.則不可進行修改或刪除該組織的動作, 至於該共用程式應檢核哪幾個重要檔案待確認
            ON ACTION del_aooi100
               LET g_action_choice="del_aooi100"
               IF cl_auth_chk_act("del_aooi100") THEN
                  IF l_ac > 0 THEN
                     CALL s_get_orga(g_ooeb_m.ooeb004,g_ooef_d[l_ac].ooef001,g_ooeb_m.ooeb005,g_ooeb_m.ooeb007)
                         RETURNING l_success,l_ooed004,l_ooefl003,l_ooed003,l_ooed006,l_ooed007,l_errno
                     IF l_success THEN   #存在於組織結構調整計劃結存檔或當前組織結構檔 中不可删除
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aoo-00275'
                        LET g_errparam.extend = g_ooef_d[l_ac].ooef001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        RETURN
                     END IF
                     IF cl_ask_delete() THEN
                        CALL s_transaction_begin()
                        DELETE FROM ooef_t
                            WHERE ooefent = g_enterprise AND ooef001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooef_t"
                           LET g_errparam.popup = FALSE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        DELETE FROM ooab_t WHERE ooabent = g_enterprise AND ooabsite = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        
                        DELETE FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooeg_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        DELETE FROM ooefl_t WHERE ooeflent = g_enterprise AND ooefl001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooefl_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  END IF
                  LET g_flag2 = TRUE
                  CALL aooi110_ooef_fill()
                  EXIT DIALOG
               END IF
               
            ON ACTION exporttoexcel   # xj add
                LET g_action_choice="exporttoexcel"
                IF cl_auth_chk_act("exporttoexcel") THEN
      
                   CALL g_export_node.clear()
                   LET g_main_hidden = 0  #xj add
                   LET g_export_node[1] = base.typeInfo.create(g_ooef_d)
                   LET g_export_id[1]   = "s_detail1"
                
                   #add-point:ON ACTION exporttoexcel
                   #END add-point
                   CALL cl_export_to_excel_getpage()
                   CALL cl_export_to_excel()
                END IF
           
            #主選單用ACTION
            &include "main_menu.4gl"
         
            #交談指令共用ACTION
            &include "common_action.4gl"
              #CONTINUE DIALOG
         
         END DIALOG
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
       
               DISPLAY ARRAY g_tree TO s_tree.*
               END DISPLAY
               
               DISPLAY ARRAY g_ooef_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b2) #page1
       
                  BEFORE ROW
                     CALL aooi110_idx_chk()
              
                  BEFORE DISPLAY
                     CALL FGL_SET_ARR_CURR(g_detail_idx)
                     LET l_ac = DIALOG.getCurrentRow("s_detail1")
                     CALL aooi110_idx_chk()
                     LET g_current_page = 1
              
               END DISPLAY
       
       
            #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_qryplan
            #該樣板不需此段落SUBDIALOG lib_cl_dlg.dlg_relateapps
       
            BEFORE DIALOG
               CALL aooi110_browser_fill("")  
               CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
               LET g_curr_diag = ui.DIALOG.getCurrent()
               LET g_page = "first"
               LET g_current_sw = FALSE
               #回歸舊筆數位置 (回到當時異動的筆數)
               #該樣板不需此段落LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               #該樣板不需此段落IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               #該樣板不需此段落   CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               #該樣板不需此段落   LET g_current_idx = g_current_row
               #該樣板不需此段落END IF
              #IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               IF g_current_row > 1 AND g_current_sw = FALSE THEN
                  LET g_current_idx = g_current_row
               END IF
       
               LET g_current_row = g_current_idx #目前指標
               IF g_current_idx = 0 THEN
                  LET g_current_idx = 1
               END IF
               LET g_current_sw = TRUE
       
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF
       
               #有資料才進行fetch
               IF g_current_idx <> 0 THEN
                  CALL aooi110_fetch('') # reload data
               END IF
#               CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
               LET g_detail_idx = 1
               CALL aooi110_ui_detailshow() #Setting the current row
       
               #筆數顯示
               LET g_current_page = 1
               CALL aooi110_idx_chk()

               #add-point:ui_dialog段before_dialog
               
               #end add-point
       
            ON ACTION statechange
               CALL aooi110_statechange()
               LET g_action_choice = "statechange"
               EXIT DIALOG
       
            #簽核
            ON ACTION signature
               MENU "" ATTRIBUTES( STYLE="popup", IMAGE="tb/authorize/terminate.png" )
                  ON ACTION ef_sign
                  ON ACTION stop_authflow
                  ON ACTION add_auth
                  ON ACTION revoke_auth
                  ON ACTION approve
                  ON ACTION unapprove
                  ON ACTION auth_opinion
                  ON ACTION auth_status
                  ON ACTION auth_attach
                  ON ACTION authflow_designer
               END MENU
       
            #ACTION表單列
            #該樣板不需此段落ON ACTION filter
            #該樣板不需此段落   CALL aooi110_filter()
            #該樣板不需此段落   EXIT DIALOG
       
            ON ACTION first
               CALL aooi110_del_ooed_tmp()
               LET g_flag2 = FALSE
               LET g_rec_b2 = 0
               CALL aooi110_fetch('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION previous
               CALL aooi110_del_ooed_tmp()
               LET g_rec_b2 = 0
               LET g_flag2 = FALSE
               CALL aooi110_fetch('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION jump
               CALL aooi110_del_ooed_tmp()
               LET g_flag2 = FALSE
               LET g_rec_b2 = 0
               CALL aooi110_fetch('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION next
               CALL aooi110_del_ooed_tmp()
               LET g_flag2 = FALSE
               LET g_rec_b2 = 0
               CALL aooi110_fetch('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION last
               CALL aooi110_del_ooed_tmp()
               LET g_flag2 = FALSE
               LET g_rec_b2 = 0
               CALL aooi110_fetch('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL aooi110_idx_chk()
               #調整
               EXIT DIALOG
            ON ACTION close
               LET INT_FLAG=FALSE
               LET g_action_choice = "exit"
               EXIT WHILE
       
            ON ACTION exit
               LET g_action_choice = "exit"
               EXIT WHILE
       
            #該樣板不需此段落ON ACTION bw_first               #page first
            #該樣板不需此段落   CALL aooi110_browser_fill("F")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
       
            #該樣板不需此段落ON ACTION bw_prev                #page previous
            #該樣板不需此段落   CALL aooi110_browser_fill("P")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
       
            #該樣板不需此段落ON ACTION bw_next                #page next
            #該樣板不需此段落   CALL aooi110_browser_fill("N")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')
       
            #該樣板不需此段落ON ACTION bw_last                #page last
            #該樣板不需此段落   CALL aooi110_browser_fill("L")
            #該樣板不需此段落   CALL cl_ui_set_browse_page_button(g_curr_diag,g_page_action,g_pagestart,g_browser_cnt)
            #該樣板不需此段落   CALL aooi110_fetch('')

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
       
            #該樣板不需此段落ON ACTION worksheethidden   #瀏覽頁折疊
            #該樣板不需此段落   IF g_main_hidden THEN
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",0)
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",1)
            #該樣板不需此段落      LET g_main_hidden = 0
            #該樣板不需此段落   ELSE
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("mainlayout",1)
            #該樣板不需此段落      CALL gfrm_curr.setElementHidden("worksheet",0)
            #該樣板不需此段落      LET g_main_hidden = 1
            #該樣板不需此段落   END IF
       
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
       
       
       
            ON ACTION modify
       
               LET g_action_choice="modify"
               IF cl_auth_chk_act("modify") THEN
                  CALL aooi110_modify()
                  #add-point:ON ACTION modify
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF



            ON ACTION insert
       
               LET g_action_choice="insert"
               IF cl_auth_chk_act("insert") THEN
                  CALL aooi110_insert()
                  #add-point:ON ACTION insert
                  
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF
       
       
            ON ACTION query
       
               LET g_action_choice="query"
               IF cl_auth_chk_act("query") THEN
                  CALL aooi110_query()
                  #add-point:ON ACTION query
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
               END IF
       
       
            ON ACTION reproduce
       
               LET g_action_choice="reproduce"
               IF cl_auth_chk_act("reproduce") THEN
                  CALL aooi110_reproduce()
                  #add-point:ON ACTION reproduce
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                   EXIT DIALOG
               END IF
       
       
            ON ACTION produce
         
               LET g_action_choice="produce"
               IF cl_auth_chk_act("produce") THEN
                   
                  CALL s_transaction_begin()

                  IF NOT aooi110_produce() THEN
                     CALL s_transaction_end('N','0') 
                  ELSE
                     CALL s_transaction_end('Y','0')
                     INITIALIZE g_errparam TO NULL
                     IF g_flag3 THEN
                        LET g_errparam.code = ""
                     ELSE
                        LET g_errparam.code = "aoo-00362"
                     END IF
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = FALSE
                     CALL cl_err() 
                     LET g_flag3 = FALSE
                  END IF
                  
                  EXIT DIALOG
               END IF
               
            ON ACTION aooi100
         
               LET g_action_choice="aooi100"
               IF cl_auth_chk_act("aooi100") THEN
                  #add-point:ON ACTION produce
                  
                  CALL cl_cmdrun("aooi100")
                  
                  #END add-point
                   EXIT DIALOG
               END IF   
       
       
            ON ACTION output
       
               LET g_action_choice="output"
               IF cl_auth_chk_act("output") THEN
                  #add-point:ON ACTION output
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                   EXIT DIALOG
               END IF
       
       
            ON ACTION delete
       
               LET g_action_choice="delete"
               IF cl_auth_chk_act("delete") THEN
                  CALL aooi110_delete()
                  #add-point:ON ACTION delete
                  
                  CALL aooi110_del_ooed_tmp()
                  #END add-point
                  #EXIT DIALOG
                   CONTINUE WHILE
               END IF
               
            ON ACTION exporttoexcel   # xj add
                LET g_action_choice="exporttoexcel"
                IF cl_auth_chk_act("exporttoexcel") THEN
      
                   CALL g_export_node.clear()
                   LET g_main_hidden = 0  #xj add
                   LET g_export_node[1] = base.typeInfo.create(g_ooef_d)
                   LET g_export_id[1]   = "s_detail1"
                
                   #add-point:ON ACTION exporttoexcel
                   #END add-point
                   CALL cl_export_to_excel_getpage()
                   CALL cl_export_to_excel()
                END IF
                
            ON ACTION ins_aooi100
                LET g_action_choice="ins_aooi100"
                IF cl_auth_chk_act("ins_aooi100") THEN
                   LET la_param.prog = 'aooi100'
                   LET la_param.param[1] = 'insert'
                   LET ls_js = util.JSON.stringify( la_param )
                   CALL cl_cmdrun(ls_js)
                   #CALL cl_cmdrun("aooi100 'insert' ")
                   LET g_flag2 = TRUE
                   CALL aooi110_ooef_fill()
                   EXIT DIALOG
                END IF
            
            ON ACTION upd_aooi100
               LET g_action_choice="upd_aooi100"
               IF cl_auth_chk_act("upd_aooi100") THEN
                  IF l_ac > 0 THEN
                     LET la_param.prog = 'aooi100'
                     LET la_param.param[1] = g_ooef_d[l_ac].ooef001
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun(ls_js)
                     #CALL cl_cmdrun("aooi100 '"||g_ooef_d[l_ac].ooef001||"'")
                  END IF
                  LET g_flag2 = TRUE
                  CALL aooi110_ooef_fill()
                  EXIT DIALOG
               END IF
            
            #1.單身停在某一筆組織資料,按下 '刪除組織'action時, 
            #   開窗詢問是否確定刪除, 'Y'則刪除該筆組織資料, 保存关闭窗口后自动刷新單身組織資料頁面
            #2.本功能應搭配一支共用程式, check該組織是否已有相關的業務單據資料, 
            #    IF yes.則不可進行修改或刪除該組織的動作, 至於該共用程式應檢核哪幾個重要檔案待確認
            ON ACTION del_aooi100
               LET g_action_choice="del_aooi100"
               IF cl_auth_chk_act("del_aooi100") THEN
                  IF l_ac > 0 THEN
                     CALL s_get_orga(g_ooeb_m.ooeb004,g_ooef_d[l_ac].ooef001,g_ooeb_m.ooeb005,g_ooeb_m.ooeb007)
                         RETURNING l_success,l_ooed004,l_ooefl003,l_ooed003,l_ooed006,l_ooed007,l_errno
                     IF l_success THEN   #存在於組織結構調整計劃結存檔或當前組織結構檔 中不可删除
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'aoo-00275'
                        LET g_errparam.extend = g_ooef_d[l_ac].ooef001
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        RETURN
                     END IF
                     IF cl_ask_delete() THEN
                        CALL s_transaction_begin()
                        DELETE FROM ooef_t
                            WHERE ooefent = g_enterprise AND ooef001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.sqlcode THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooef_t"
                           LET g_errparam.popup = FALSE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        DELETE FROM ooab_t WHERE ooabent = g_enterprise AND ooabsite = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooab_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        
                        DELETE FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooeg_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                        DELETE FROM ooefl_t WHERE ooeflent = g_enterprise AND ooefl001 = g_ooef_d[l_ac].ooef001
                        IF SQLCA.SQLcode  THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = "ooefl_t"
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           CALL s_transaction_end('N','0')
                        END IF
                     END IF
                  END IF
                  LET g_flag2 = TRUE
                  CALL aooi110_ooef_fill()
                  EXIT DIALOG
               END IF
               
            #主選單用ACTION
            &include "main_menu.4gl"
      
            #交談指令共用ACTION
            &include "common_action.4gl"
              #CONTINUE DIALOG
      
         END DIALOG
      END IF
   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

PRIVATE FUNCTION aooi110_browser_fill(ps_page_action)
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
   DEFINE l_ooed003         LIKE ooed_t.ooed003
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_ooeb_m.* TO NULL
   
    
   CALL g_ooef_d.clear()
   LET g_rec_b2 = 0
   
   CALL g_browser.clear()

   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "ooeb001"
   ELSE
      LET l_searchcol = g_searchcol
   END IF

   LET l_wc  = g_wc.trim()
   #LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF

   #IF g_wc2 <> " 1=1" THEN
   #   #單身有輸入搜尋條件
   #   LET l_sub_sql = " SELECT UNIQUE ooeb001 ",
   #
   #                     " FROM ooeb_t ",
   #                           " ",
   #                           " LEFT JOIN ooec_t ON ooecent = ooebent AND ooeb001 = ooec001 ",
   #
   #                           " ",
   #                           " ",
   #                    " WHERE ooebent = '" ||g_enterprise|| "' AND ooecent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2
   #
   #ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE ooeb001 ",

                        " FROM ooeb_t ",
                              " ",
                              " ",
                        "WHERE ooebent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED,cl_sql_add_filter("ooeb_t")  #161214-00032#2 add ,cl_sql_add_filter("ooeb_t") 

   #END IF

   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"

   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre

   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示

   #若超過最大顯示筆數
   #該樣板不需此段落IF g_browser_cnt > g_max_browse THEN
   #該樣板不需此段落   CALL cl_err(g_browser_cnt,'9035',1)
   #該樣板不需此段落END IF

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
         LET g_pagestart = g_pagestart - 1
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF

      WHEN "N"
         LET g_pagestart = g_pagestart + 1
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
            WHILE g_pagestart > g_browser_cnt
               LET g_pagestart = g_pagestart - 1
            END WHILE
         END IF

      WHEN "L"
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod 1) + 1
         WHILE g_pagestart > g_browser_cnt
            LET g_pagestart = g_pagestart - 1
         END WHILE

      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF

   END CASE

   ##單身有輸入查詢條件且非null
   #IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN
   #   #依照ooeb001 Browser欄位定義(取代原本bs_sql功能)
   #   LET l_sql_rank = "SELECT DISTINCT ooebstus,ooeb001,DENSE_RANK() OVER(ORDER BY ooeb001 ",g_order,") AS RANK ",
   #                     " FROM ooeb_t ",
   #                           " ",
   #                           " LEFT JOIN ooec_t ON ooecent = ooebent AND ooeb001 = ooec001",
   #
   #                           " ",
   #                           " ",
   #                    " ",
   #                    " WHERE ooebent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2
   #ELSE
      #單身無輸入資料
      LET l_sql_rank = "SELECT DISTINCT ooebstus,ooeb001,DENSE_RANK() OVER(ORDER BY ooeb001 ",g_order,") AS RANK ",
                       " FROM ooeb_t ",
                            "  ",
                            "  ",
                       " WHERE ooebent = '" ||g_enterprise|| "' AND ", g_wc CLIPPED,cl_sql_add_filter("ooeb_t")  #161214-00032#2 add ,cl_sql_add_filter("ooeb_t") 
   #END IF

   #定義翻頁CURSOR
   LET g_sql= "SELECT ooebstus,ooeb001 FROM (",l_sql_rank,") WHERE ",
              " RANK >= ",g_pagestart," AND RANK<",g_pagestart+500, #調整
              " ORDER BY ",l_searchcol," ",g_order

   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_ooeb001#,g_browser[g_cnt].rank
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF



      #add-point:browser_fill段reference
      #151125-00001#3 ---mark (S)---
      #SELECT ooebstus,ooeb003,ooeb007,ooeb008 INTO g_ooeb_m.ooebstus,g_ooeb_m.ooeb003,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008
      #  FROM ooeb_t
      #  WHERE ooeb001 = g_browser[g_cnt].b_ooeb001 
      #   AND ooebent = g_enterprise
      #151125-00001#3 ---mark (E)---
      #end add-point

            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/open.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/void.png"

         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/valid.png"


      END CASE


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
   #調整 - 此段落刪除
   #151125-00001#3 ---add (S)---
   SELECT ooebstus,ooeb003,ooeb007,ooeb008 INTO g_ooeb_m.ooebstus,g_ooeb_m.ooeb003,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008
        FROM ooeb_t
        WHERE ooeb001 = g_ooeb_m_t.ooeb001
         AND ooebent = g_enterprise
   #151125-00001#3 ---add (E)---
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point

   LET g_ooeb_m.ooeb001 = g_browser[g_current_idx].b_ooeb001

    SELECT UNIQUE ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt
 INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt
 FROM ooeb_t
 WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001
   CALL aooi110_show()

END FUNCTION

PRIVATE FUNCTION aooi110_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point

   #add-point:ui_detailshow段before
   
   #end add-point

   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)

   END IF

   #add-point:ui_detailshow段after
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_ui_browser_refresh()
   {<Local define>}
   DEFINE l_i  LIKE type_t.num10
   {</Local define>}
   #add-point:ui_browser_refresh段define
   
   #end add-point

   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_ooeb001 = g_ooeb_m.ooeb001

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

PRIVATE FUNCTION aooi110_construct()
   {<Local define>}
   DEFINE lc_qbe_sn   LIKE type_t.num10
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING
   {</Local define>}
   #add-point:cs段define
   
   #end add-point

   #清除畫面
   CLEAR FORM
   INITIALIZE g_ooeb_m.* TO NULL
   CALL g_ooef_d.clear()
   LET g_rec_b2 = 0

   LET g_current_idx = 1
   LET g_action_choice = ""

   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL

   INITIALIZE g_wc_table1 TO NULL


   LET g_qryparam.state = 'c'

   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      CONSTRUCT BY NAME g_wc ON ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt

         BEFORE CONSTRUCT
            #CALL cl_qbe_init()

         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         #----<<ooeb001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb001
            #add-point:BEFORE FIELD ooeb001
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb001

            #add-point:AFTER FIELD ooeb001
            
            #END add-point


         #Ctrlp:construct.c.ooeb001
#         ON ACTION controlp INFIELD ooeb001
            #add-point:ON ACTION controlp INFIELD ooeb001
            
            #END add-point

         #----<<ooeb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb002
            #add-point:BEFORE FIELD ooeb002
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb002

            #add-point:AFTER FIELD ooeb002
            
            #END add-point


         #Ctrlp:construct.c.ooeb002
#         ON ACTION controlp INFIELD ooeb002
            #add-point:ON ACTION controlp INFIELD ooeb002
            
            #END add-point

         #----<<ooeb003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb003
            #add-point:BEFORE FIELD ooeb003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb003

            #add-point:AFTER FIELD ooeb003
            
            #END add-point


         #Ctrlp:construct.c.ooeb003
#         ON ACTION controlp INFIELD ooeb003
            #add-point:ON ACTION controlp INFIELD ooeb003
            
            #END add-point

         #----<<ooeb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb004
            #add-point:BEFORE FIELD ooeb004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb004

            #add-point:AFTER FIELD ooeb004
            
            #END add-point


         #Ctrlp:construct.c.ooeb004
#         ON ACTION controlp INFIELD ooeb004
            #add-point:ON ACTION controlp INFIELD ooeb004
            
            #END add-point

         #----<<ooeb005>>----
         #Ctrlp:construct.c.ooeb005
         ON ACTION controlp INFIELD ooeb005
            #add-point:ON ACTION controlp INFIELD ooeb005
#此段落由子樣板a08產生
            #開窗c段
            #161019-00017#2-S
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            #161019-00017#2-E            
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooeb005  #顯示到畫面上

            NEXT FIELD ooeb005                     #返回原欄位


            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD ooeb005
            #add-point:BEFORE FIELD ooeb005
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb005

            #add-point:AFTER FIELD ooeb005
            
            #END add-point


         #----<<ooeb006>>----
         #Ctrlp:construct.c.ooeb006
         ON ACTION controlp INFIELD ooeb006
            #add-point:ON ACTION controlp INFIELD ooeb006
#此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooed003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooeb006  #顯示到畫面上

            NEXT FIELD ooeb006                     #返回原欄位


            #END add-point

         #此段落由子樣板a01產生
         BEFORE FIELD ooeb006
            #add-point:BEFORE FIELD ooeb006
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb006

            #add-point:AFTER FIELD ooeb006
            
            #END add-point


         #----<<ooeb007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb007
            #add-point:BEFORE FIELD ooeb007
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb007

            #add-point:AFTER FIELD ooeb007
            
            #END add-point


         #Ctrlp:construct.c.ooeb007
#         ON ACTION controlp INFIELD ooeb007
            #add-point:ON ACTION controlp INFIELD ooeb007
            
            #END add-point

         #----<<ooeb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb008
            #add-point:BEFORE FIELD ooeb008
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb008

            #add-point:AFTER FIELD ooeb008
            
            #END add-point


         #Ctrlp:construct.c.ooeb008
#         ON ACTION controlp INFIELD ooeb008
            #add-point:ON ACTION controlp INFIELD ooeb008
            
            #END add-point

         #----<<ooebstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebstus
            #add-point:BEFORE FIELD ooebstus
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebstus

            #add-point:AFTER FIELD ooebstus
            
            #END add-point


         #Ctrlp:construct.c.ooebstus
#         ON ACTION controlp INFIELD ooebstus
            #add-point:ON ACTION controlp INFIELD ooebstus
            
            #END add-point

         #----<<ooebmodid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebmodid
            #add-point:BEFORE FIELD ooebmodid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebmodid

            #add-point:AFTER FIELD ooebmodid
            
            #END add-point


         #Ctrlp:construct.c.ooebmodid
#         ON ACTION controlp INFIELD ooebmodid
            #add-point:ON ACTION controlp INFIELD ooebmodid
            
            #END add-point

         #----<<ooebmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebmoddt
         
         AFTER FIELD ooebmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

         #----<<ooebownid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebownid
            #add-point:BEFORE FIELD ooebownid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebownid

            #add-point:AFTER FIELD ooebownid
            
            #END add-point


         #Ctrlp:construct.c.ooebownid
#         ON ACTION controlp INFIELD ooebownid
            #add-point:ON ACTION controlp INFIELD ooebownid
            
            #END add-point

         #----<<ooebowndp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebowndp
            #add-point:BEFORE FIELD ooebowndp
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebowndp

            #add-point:AFTER FIELD ooebowndp
            
            #END add-point


         #Ctrlp:construct.c.ooebowndp
#         ON ACTION controlp INFIELD ooebowndp
            #add-point:ON ACTION controlp INFIELD ooebowndp
            
            #END add-point

         #----<<ooebcrtid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtid
            #add-point:BEFORE FIELD ooebcrtid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebcrtid

            #add-point:AFTER FIELD ooebcrtid
            
            #END add-point


         #Ctrlp:construct.c.ooebcrtid
#         ON ACTION controlp INFIELD ooebcrtid
            #add-point:ON ACTION controlp INFIELD ooebcrtid
            
            #END add-point

         #----<<ooebcrtdp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtdp
            #add-point:BEFORE FIELD ooebcrtdp
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebcrtdp

            #add-point:AFTER FIELD ooebcrtdp
            
            #END add-point


         #Ctrlp:construct.c.ooebcrtdp
#         ON ACTION controlp INFIELD ooebcrtdp
            #add-point:ON ACTION controlp INFIELD ooebcrtdp
            
            #END add-point

         #----<<ooebcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtdt
            #add-point:BEFORE FIELD ooebcrtdt
            
            #END add-point
            
         AFTER FIELD ooebcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)


      END CONSTRUCT

     
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      
      #end add-point

      BEFORE DIALOG
         #add-point:cs段b_dialog
         
         #end add-point

      ON ACTION qbe_select     #條件查詢
         #CALL cl_qbe_list() RETURNING lc_qbe_sn
         #CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
         #CALL cl_qbe_save()

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
   LET g_wc2 = g_wc_table1


   IF INT_FLAG THEN
      RETURN
   END IF

END FUNCTION

PRIVATE FUNCTION aooi110_query()
   #add-point:query段define
   
   #end add-point

   #切換畫面
   #該樣板不需此段落IF g_main_hidden THEN
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("mainlayout",0)
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("worksheet",1)
   #該樣板不需此段落   LET g_main_hidden = 0
   #該樣板不需此段落END IF

   LET INT_FLAG = 0
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""

   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()
   CALL g_ooef_d.clear()
   LET g_flag2 = FALSE
   LET g_rec_b2 = 0

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   CALL aooi110_construct()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_ooeb_m.* TO NULL
      LET g_wc = " 1=1"
      LET g_wc2 = " 1=1"
      RETURN
   END IF

   LET g_wc_filter = ""
   #該樣板不需此段落
   CALL aooi110_browser_fill("F")

   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   ELSE
      CALL aooi110_fetch("F")
   END IF

END FUNCTION

PRIVATE FUNCTION aooi110_fetch(p_flag)
   {<Local define>}
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #調整
   DEFINE l_ooed003         LIKE ooed_t.ooed003
   DEFINE l_pid             LIKE type_t.chr100
   DEFINE l_pid_1           LIKE type_t.chr100
   DEFINE l_n               LIKE type_t.num5
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

   #調整
   #CALL aooi110_browser_fill(p_flag)

   #該樣板不需此段落CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引

   LET g_detail_cnt = g_header_cnt

   #單身總筆數顯示
   LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF

   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數

   #該樣板不需此段落CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   #調整
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )

   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF

   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF

   LET g_ooeb_m.ooeb001 = g_browser[g_current_idx].b_ooeb001

   #調整
   SELECT UNIQUE ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt
     INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,
          g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt
     FROM ooeb_t
    WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ooeb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_ooeb_m.* TO NULL
      RETURN
   END IF
   
   CALL aooi110_tree_fill()
   
   #重新顯示
   CALL aooi110_show()
   
   CALL cl_set_act_visible("modify,delete,produce,ins_aooi100,upd_aooi100,del_aooi100", TRUE)

   CALL aooi110_set_act_visible()
   CALL aooi110_set_act_no_visible()
   

END FUNCTION

PRIVATE FUNCTION aooi110_tree_expand(p_id)
DEFINE p_id          LIKE type_t.num10
DEFINE l_id          LIKE type_t.num10
DEFINE l_cnt         LIKE type_t.num10
DEFINE l_keyvalue    LIKE type_t.chr50
DEFINE l_typevalue   LIKE type_t.chr50
DEFINE l_type        LIKE type_t.chr50
DEFINE l_sql         LIKE type_t.chr500
DEFINE ls_source     LIKE type_t.chr500
DEFINE ls_exp_code   LIKE type_t.chr500

   #若已經展開
   IF g_tree[p_id].b_isExp = 1 THEN
      RETURN
   END IF

   LET g_tree[p_id].b_isExp = 1

   LET l_keyvalue = g_tree[p_id].b_ooed004


   LET l_sql = "SELECT UNIQUE ooed004 ",
               "  FROM ooed_tmp ",
               " WHERE ooedent = '",g_enterprise,"' ",
               "   AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
               "   AND ooed002 = '",g_tree[p_id].b_ooed002,"' ",
               "   AND ooed005 = '",l_keyvalue,"' ",
               "   AND ooed004 <> ooed005 ",
               " ORDER BY ooed004"

   PREPARE tree_expand1 FROM l_sql
   DECLARE tree_ex_cur1 CURSOR FOR tree_expand1

   LET l_id = p_id + 1
   CALL g_tree.insertElement(l_id)
   LET l_cnt = 1
   FOREACH tree_ex_cur1 INTO g_tree[l_id].b_ooed004
      IF cl_null(g_tree[l_id].b_ooed004) THEN
         CALL g_tree.deleteElement(l_id)
         EXIT FOREACH
      END IF
      #pid=父節點id
      LET g_tree[l_id].b_pid  = g_tree[p_id].b_id
      #id=本身節點id(採流水號遞增)
      LET g_tree[l_id].b_id  = g_tree[p_id].b_id||"."||l_cnt
      LET g_tree[l_id].b_exp = TRUE
      LET g_tree[l_id].b_ooed005 = g_tree[p_id].b_ooed004
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[l_id].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_tree[l_id].b_ooed004_desc = g_rtn_fields[1]
      LET g_tree[l_id].b_show =  g_tree[l_id].b_ooed004,' (',g_tree[l_id].b_ooed004_desc,')'
      LET g_tree[l_id].b_ooed002 = g_tree[p_id].b_ooed002
      #hasC=確認該節點是否有子孫
      LET g_tree[l_id].b_hasC = aooi110_chk_hasC(l_id)
      LET l_id = l_id + 1
      CALL g_tree.insertElement(l_id)
      LET l_cnt = l_cnt + 1
   END FOREACH
   LET l_cnt = l_cnt -1
   #刪除空資料
   CALL g_tree.deleteElement(l_id)

END FUNCTION

PRIVATE FUNCTION aooi110_chk_hasC(pi_id)
DEFINE pi_id    INTEGER
DEFINE li_cnt   INTEGER


   LET g_sql = "SELECT COUNT(*) FROM ooed_tmp ",
               " WHERE ooedent = '" ||g_enterprise|| "'",
               "   AND ooed002 = '",g_tree[pi_id].b_ooed002,"' ",
               "   AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed005 = ? "
   PREPARE aooi110_master_chk1 FROM g_sql
   EXECUTE aooi110_master_chk1 USING g_tree[pi_id].b_ooed004 INTO li_cnt
   FREE aooi110_master_chk1
   IF li_cnt > 0 THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

PRIVATE FUNCTION aooi110_insert()
   #add-point:insert段define
   
   #end add-point

   #清畫面欄位內容
   CLEAR FORM
   CALL g_ooef_d.clear()
   LET g_flag2 = FALSE
   LET g_rec_b2 = 0

   #INITIALIZE g_ooeb_m.* LIKE ooeb_t.*             #DEFAULT 設定   #161124-00048#7  2016/12/13 By 08734 mark
   INITIALIZE g_ooeb_m.* TO NULL             #DEFAULT 設定  #161124-00048#7  2016/12/13 By 08734 add

   WHILE TRUE

      #append欄位給值


      #一般欄位給值
            


      #add-point:單頭預設值
      INITIALIZE g_ooeb_m.* TO NULL 
      INITIALIZE g_ooeb_m_t.* TO NULL 
      INITIALIZE g_ooeb_m_o.* TO NULL 
      
      LET g_ooeb_m.ooeb003 = "1"
      LET g_ooeb_m.ooeb002 = g_today
      LET g_ooeb_m.ooebstus = "N"
      LET g_ooeb_m.ooebownid = g_user
      LET g_ooeb_m.ooebowndp = g_dept
      LET g_ooeb_m.ooebcrtid = g_user
      LET g_ooeb_m.ooebcrtdp = g_dept
      LET g_ooeb_m.ooebcrtdt = cl_get_current()
      LET g_ooeb_m.ooebmodid = g_user
      LET g_ooeb_m.ooebmoddt = cl_get_current()
      
      CALL aooi110_auto_code() RETURNING g_ooeb_m.ooeb001
      DISPLAY BY NAME g_ooeb_m.ooeb001
      
      LET g_ooeb_m_t.* = g_ooeb_m.*
      LET g_ooeb_m_o.* = g_ooeb_m.*
      #end add-point

      CALL aooi110_input("a")

      #add-point:單頭輸入後
      
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooeb_m.* = g_ooeb_m_t.*
         CALL aooi110_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF



      LET g_rec_b2 = 0
      EXIT WHILE

   END WHILE

   LET g_state = "Y"

   LET g_ooeb001_t = g_ooeb_m.ooeb001


   LET g_wc = g_wc,
              " OR (",
              " ooeb001 = '", g_ooeb_m.ooeb001 CLIPPED, "' "

              , ") "
              
   LET g_flag2 = TRUE       #新增或者修改後，顯示單身資料   
  
END FUNCTION

PRIVATE FUNCTION aooi110_modify()
   {<Local define>}
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:modify段define

   #end add-point

   IF g_ooeb_m.ooeb001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt
 INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt
 FROM ooeb_t
 WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001

   ERROR ""

   LET g_ooeb001_t = g_ooeb_m.ooeb001

   BEGIN WORK

   OPEN aooi110_cl USING g_enterprise,g_ooeb_m.ooeb001

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aooi110_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE aooi110_cl
      ROLLBACK WORK
      RETURN
   END IF

   #鎖住將被更改或取消的資料
   FETCH aooi110_cl INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb005_desc,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmodid_desc,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebownid_desc,g_ooeb_m.ooebowndp,g_ooeb_m.ooebowndp_desc,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtid_desc,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdp_desc,g_ooeb_m.ooebcrtdt

   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_ooeb_m.ooeb001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE aooi110_cl
      ROLLBACK WORK
      RETURN
   END IF

   LET g_flag2 = FALSE
   LET g_rec_b2 = 0

   CALL aooi110_show()
   WHILE TRUE
      LET g_ooeb001_t = g_ooeb_m.ooeb001


      #寫入修改者/修改日期資訊(單頭)
      LET g_ooeb_m.ooebmodid = g_user
      LET g_ooeb_m.ooebmoddt = cl_get_current()


      CALL aooi110_input("u")     #欄位更改

      #add-point:modify段修改後
      
      #end add-point

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_ooeb_m.* = g_ooeb_m_t.*
         CALL aooi110_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         EXIT WHILE
      END IF

      #若單頭key欄位有變更
      IF g_ooeb_m.ooeb001 != g_ooeb001_t

      THEN
         BEGIN WORK

         #add-point:單身fk修改前
         
         #end add-point


         #add-point:單身fk修改後
         
         #end add-point

         #UPDATE 多語言table key值


         COMMIT WORK
      END IF

      EXIT WHILE
   END WHILE
   
   LET g_flag2 = TRUE       #新增或者修改後，顯示單身資料   
  
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_ooeb_m.ooeb001,g_site) THEN
      ROLLBACK WORK
   END IF

   CLOSE aooi110_cl
   COMMIT WORK

   #流程通知預埋點-U
   CALL cl_flow_notify(g_ooeb_m.ooeb001,'U')

END FUNCTION

PRIVATE FUNCTION aooi110_input(p_cmd)
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
   
   DEFINE l_ooeb006        LIKE ooeb_t.ooeb006
   DEFINE l_flag           LIKE type_t.num5
   
   #end add-point

   #切換畫面
   #該樣板不需此段落IF g_main_hidden THEN
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("mainlayout",0)
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("worksheet",1)
   #該樣板不需此段落   LET g_main_hidden = 0
   #該樣板不需此段落END IF

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'

   #控制key欄位可否輸入
   CALL aooi110_set_entry(p_cmd)
   CALL aooi110_set_no_entry(p_cmd)

   DISPLAY BY NAME g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt

   #add-point:資料輸入前
   
   #end add-point
   LET g_errshow = 1 
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭段
      INPUT BY NAME g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION(master_input)


         BEFORE INPUT
            LET l_flag = FALSE

         #---------------------------<  Master  >---------------------------
         #----<<ooeb001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb001
            #add-point:BEFORE FIELD ooeb001
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb001

            #add-point:AFTER FIELD ooeb001
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooeb_m.ooeb001) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooeb_m.ooeb001 != g_ooeb001_t ))) THEN
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooeb_t WHERE "||"ooebent = '" ||g_enterprise|| "' AND "||"ooeb001 = '"||g_ooeb_m.ooeb001 ||"'",'std-00004',0) THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb001
            #add-point:ON CHANGE ooeb001
            
            #END add-point

         #----<<ooeb002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb002
            #add-point:BEFORE FIELD ooeb002
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb002

            #add-point:AFTER FIELD ooeb002
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb002
            #add-point:ON CHANGE ooeb002
            
            #END add-point

         #----<<ooeb003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb003
            #add-point:BEFORE FIELD ooeb003
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb003

            #add-point:AFTER FIELD ooeb003
            IF NOT cl_null(g_ooeb_m.ooeb003) THEN
               IF g_ooeb_m.ooeb003 <> g_ooeb_m_o.ooeb003 OR cl_null(g_ooeb_m_o.ooeb003) THEN
                  IF NOT aooi110_chk_ooeb005() THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ooeb_m.ooeb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_ooeb_m.ooeb003= g_ooeb_m_o.ooeb003
                     NEXT FIELD ooeb003
                  END IF
                  #160519-00039#1--add--start--
                  IF g_ooeb_m_o.ooeb003 = '1' AND  g_ooeb_m.ooeb003 <> '1' THEN 
                     CALL cl_set_comp_entry("ooeb006",TRUE)
                     LET g_ooeb_m.ooeb006 = null
                     NEXT FIELD ooeb006 
                  END IF
                  #160519-00039#1--add--end----
                  CALL aooi110_chk_ooeb006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ooeb_m.ooeb003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_ooeb_m.ooeb003= g_ooeb_m_o.ooeb003
                     NEXT FIELD ooeb003
                  END IF
                  CALL aooi110_set_entry('a')
                  CALL aooi110_set_no_entry('a')
                  CALL aooi110_def_ooeb006()
                  CALL aooi110_out_tree()
                  
                  #add by lixiang
                  #變更類型為新增時，若選擇依上一版本带出预设值，则将当前最上层组织的上一版本的组织树预设带出
                  IF g_ooeb_m.ooeb003 = '1' AND (NOT cl_null(g_ooeb_m.ooeb004)) AND (NOT cl_null(g_ooeb_m.ooeb005)) THEN
                     SELECT MAX(ooed003) INTO l_ooeb006 FROM ooed_t
                        WHERE ooedent = g_enterprise AND ooed001 = g_ooeb_m.ooeb004 AND ooed002 = g_ooeb_m.ooeb005
                     IF l_ooeb006 > 0 THEN
                        IF cl_ask_confirm('aoo-00643') THEN
                           CALL aooi110_out_tree1()
                           LET l_flag = TRUE
                        ELSE
                           LET l_flag = FALSE
                        END IF
                     END IF
                  END IF
                  
               END IF
            END IF
            LET g_ooeb_m_o.ooeb003= g_ooeb_m.ooeb003
            #IF p_cmd = 'a' THEN
            #   CALL aooi110_tree_tmp_fill1()
            #END IF
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb003
            #add-point:ON CHANGE ooeb003
            
            #CALL aooi110_set_entry('a')
            #CALL aooi110_set_no_entry('a')
            #CALL aooi110_def_ooeb006()
            #CALL aooi110_out_tree()
            #END add-point

         #----<<ooeb004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb004
            #add-point:BEFORE FIELD ooeb004
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb004

            #add-point:AFTER FIELD ooeb004
            IF NOT cl_null(g_ooeb_m.ooeb004) THEN
               IF g_ooeb_m.ooeb004 <> g_ooeb_m_o.ooeb004 OR cl_null(g_ooeb_m_o.ooeb004) THEN
                  IF NOT aooi110_chk_ooeb005() THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ooeb_m.ooeb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_ooeb_m.ooeb004= g_ooeb_m_o.ooeb004
                     NEXT FIELD ooeb004
                  END IF
                  CALL aooi110_chk_ooeb006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ooeb_m.ooeb004
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_ooeb_m.ooeb004= g_ooeb_m_o.ooeb004
                     NEXT FIELD ooeb004
                  END IF
                  CALL aooi110_def_ooeb006()
                  CALL aooi110_out_tree()
                  
                  #add by lixiang
                  #變更類型為新增時，若選擇依上一版本带出预设值，则将当前最上层组织的上一版本的组织树预设带出
                  IF g_ooeb_m.ooeb003 = '1' AND (NOT cl_null(g_ooeb_m.ooeb005)) THEN
                     SELECT MAX(ooed003) INTO l_ooeb006 FROM ooed_t
                        WHERE ooedent = g_enterprise AND ooed001 = g_ooeb_m.ooeb004 AND ooed002 = g_ooeb_m.ooeb005
                     IF l_ooeb006 > 0 THEN
                        IF cl_ask_confirm('aoo-00643') THEN
                           CALL aooi110_out_tree1()
                           LET l_flag = TRUE
                        ELSE
                           LET l_flag = FALSE
                        END IF
                     END IF
                  END IF
                  
               END IF
               #IF p_cmd = 'a' THEN
               #   CALL aooi110_tree_tmp_fill1()
               #END IF
            END IF
            LET g_ooeb_m_o.ooeb004= g_ooeb_m.ooeb004
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb004
            #add-point:ON CHANGE ooeb004
            
            #CALL aooi110_def_ooeb006()
            #CALL aooi110_out_tree()
            #END add-point

         #----<<ooeb005>>----
         #此段落由子樣板a02產生
         AFTER FIELD ooeb005

            #add-point:AFTER FIELD ooeb005
            IF NOT cl_null(g_ooeb_m.ooeb005) THEN
               IF g_ooeb_m.ooeb005 <> g_ooeb_m_o.ooeb005 OR cl_null(g_ooeb_m_o.ooeb005) THEN
                  LET g_ooeb_m.ooeb005_desc = ""
                  DISPLAY BY NAME g_ooeb_m.ooeb005_desc
                  IF NOT cl_null(g_ooeb_m.ooeb005) THEN
                     IF NOT aooi110_chk_ooeb005() THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = g_ooeb_m.ooeb005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                    
                        LET g_ooeb_m.ooeb005= g_ooeb_m_o.ooeb005
                        CALL aooi110_ooec005_desc()
                        NEXT FIELD ooeb005
                     END IF
                  END IF
                  
                  CALL aooi110_chk_ooeb006()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_ooeb_m.ooeb005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_ooeb_m.ooeb005= g_ooeb_m_o.ooeb005
                     CALL aooi110_ooec005_desc()
                     NEXT FIELD ooeb005
                  END IF
                  CALL aooi110_def_ooeb006()
                  CALL aooi110_ooec005_desc()
                  CALL aooi110_out_tree()
                  #IF p_cmd = 'a' THEN
                  #   CALL aooi110_tree_tmp_fill1()
                  #END IF
                  #add by lixiang
                  #變更類型為新增時，若選擇依上一版本带出预设值，则将当前最上层组织的上一版本的组织树预设带出
                  IF g_ooeb_m.ooeb003 = '1' AND (NOT cl_null(g_ooeb_m.ooeb004)) THEN
                     SELECT MAX(ooed003) INTO l_ooeb006 FROM ooed_t
                        WHERE ooedent = g_enterprise AND ooed001 = g_ooeb_m.ooeb004 AND ooed002 = g_ooeb_m.ooeb005
                     IF l_ooeb006 > 0 THEN
                        IF cl_ask_confirm('aoo-00643') THEN
                           CALL aooi110_out_tree1()
                           LET l_flag = TRUE
                        ELSE
                           LET l_flag = FALSE
                        END IF
                     END IF
                  END IF
               END IF
            END IF
            LET g_ooeb_m_o.ooeb005= g_ooeb_m.ooeb005
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD ooeb005
            #add-point:BEFORE FIELD ooeb005
            
            #CALL aooi110_def_ooeb006()
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE ooeb005
            #add-point:ON CHANGE ooeb005
            
            #CALL aooi110_out_tree()
            #IF p_cmd = 'a' THEN
            #   CALL aooi110_tree_tmp_fill1()
            #END IF
            #END add-point

         #----<<ooeb006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb006
            #add-point:BEFORE FIELD ooeb006
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb006

            #add-point:AFTER FIELD ooeb006
            IF NOT aooi110_chk_ooeb005() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_ooeb_m.ooeb006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooeb_m.ooeb006= g_ooeb_m_t.ooeb006
               NEXT FIELD ooeb006
            END IF
            CALL aooi110_chk_ooeb006()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_ooeb_m.ooeb006
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooeb_m.ooeb006= g_ooeb_m_t.ooeb006
               NEXT FIELD ooeb006
            END IF
            CALL aooi110_out_tree()
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb006
            #add-point:ON CHANGE ooeb006
            
            CALL aooi110_out_tree()
            #END add-point

         #----<<ooeb007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb007
            #add-point:BEFORE FIELD ooeb007
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb007

            #add-point:AFTER FIELD ooeb007
            CALL aooi110_chk_date()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_ooeb_m.ooeb007
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooeb_m.ooeb007= g_ooeb_m_t.ooeb007
               NEXT FIELD ooeb007
            END IF
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb007
            #add-point:ON CHANGE ooeb007
            
            #END add-point

         #----<<ooeb008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooeb008
            #add-point:BEFORE FIELD ooeb008
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooeb008

            #add-point:AFTER FIELD ooeb008
            CALL aooi110_chk_date()
            IF NOT cl_null(g_errno) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_ooeb_m.ooeb008
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooeb_m.ooeb008= g_ooeb_m_t.ooeb008
               NEXT FIELD ooeb008
            END IF
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooeb008
            #add-point:ON CHANGE ooeb008
            
            #END add-point

         #----<<ooebstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebstus
            #add-point:BEFORE FIELD ooebstus
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebstus

            #add-point:AFTER FIELD ooebstus
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebstus
            #add-point:ON CHANGE ooebstus
            
            #END add-point

         #----<<ooebmodid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebmodid
            #add-point:BEFORE FIELD ooebmodid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebmodid

            #add-point:AFTER FIELD ooebmodid
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebmodid
            #add-point:ON CHANGE ooebmodid
            
            #END add-point

         #----<<ooebmoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebmoddt
            #add-point:BEFORE FIELD ooebmoddt
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebmoddt

            #add-point:AFTER FIELD ooebmoddt
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebmoddt
            #add-point:ON CHANGE ooebmoddt
            
            #END add-point

         #----<<ooebownid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebownid
            #add-point:BEFORE FIELD ooebownid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebownid

            #add-point:AFTER FIELD ooebownid
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebownid
            #add-point:ON CHANGE ooebownid
            
            #END add-point

         #----<<ooebowndp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebowndp
            #add-point:BEFORE FIELD ooebowndp
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebowndp

            #add-point:AFTER FIELD ooebowndp
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebowndp
            #add-point:ON CHANGE ooebowndp
            
            #END add-point

         #----<<ooebcrtid>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtid
            #add-point:BEFORE FIELD ooebcrtid
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebcrtid

            #add-point:AFTER FIELD ooebcrtid
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebcrtid
            #add-point:ON CHANGE ooebcrtid
            
            #END add-point

         #----<<ooebcrtdp>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtdp
            #add-point:BEFORE FIELD ooebcrtdp
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebcrtdp

            #add-point:AFTER FIELD ooebcrtdp
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebcrtdp
            #add-point:ON CHANGE ooebcrtdp
            
            #END add-point

         #----<<ooebcrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD ooebcrtdt
            #add-point:BEFORE FIELD ooebcrtdt
            
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD ooebcrtdt

            #add-point:AFTER FIELD ooebcrtdt
            
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE ooebcrtdt
            #add-point:ON CHANGE ooebcrtdt
            
            #END add-point



         #----<<ooeb005>>----
         #Ctrlp:input.c.ooeb005
         ON ACTION controlp INFIELD ooeb005
            #add-point:ON ACTION controlp INFIELD ooeb005
#此段落由子樣板a07產生
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_ooeb_m.ooeb005             #給予default值

            #給予arg
            IF NOT cl_null(g_ooeb_m.ooeb004) THEN
                CASE g_ooeb_m.ooeb004
                   WHEN '1'  LET g_qryparam.where = " ooef203 = 'Y' "
                   WHEN '4'  LET g_qryparam.where = " ooef205 = 'Y' " 
                   WHEN '5'  LET g_qryparam.where = " ooef207 = 'Y' "
                   WHEN '6'  LET g_qryparam.where = " ooef206 = 'Y' "
                   WHEN '7'  LET g_qryparam.where = " ooef206 = 'Y' "
                   WHEN '8'  LET g_qryparam.where = " ooef201 = 'Y' "
                   WHEN '9'  LET g_qryparam.where = " ooef208 = 'Y' "
                   WHEN '10' LET g_qryparam.where = " ooef210 = 'Y' "
                   WHEN '11' LET g_qryparam.where = " ooef211 = 'Y' "
                   WHEN '12' LET g_qryparam.where = " ooef212 = 'Y' "
                END CASE
            END IF
            CALL q_ooef001()                                #呼叫開窗

            LET g_ooeb_m.ooeb005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_ooeb_m.ooeb005 TO ooeb005              #顯示到畫面上
            LET g_qryparam.where =""
            CALL aooi110_ooec005_desc()
            NEXT FIELD ooeb005                          #返回原欄位


            #END add-point

         #----<<ooeb006>>----
         #Ctrlp:input.c.ooeb006
         ON ACTION controlp INFIELD ooeb006
            #add-point:ON ACTION controlp INFIELD ooeb006
#此段落由子樣板a07產生
            #開窗i段

            #給予arg
            IF NOT (g_ooeb_m.ooeb003 = '1') THEN
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_ooeb_m.ooeb006             #給予default
               IF NOT cl_null(g_ooeb_m.ooeb004) THEN
                  IF g_ooeb_m.ooeb003 = '2' THEN
                     LET g_qryparam.where = "ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed003 IN(SELECT ooed003 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND  ooed001 = '",g_ooeb_m.ooeb004,"'  AND (ooed007 >= to_date('",g_today,"','YYYY/MM/DD') OR ooed007 IS NULL))"
                  ELSE
                     LET g_qryparam.where = "ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed003 IN(SELECT ooed003 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND  ooed001 = '",g_ooeb_m.ooeb004,"'  AND ooed006 > to_date('",g_today,"','YYYY/MM/DD'))"
                  END IF
                  IF NOT cl_null(g_ooeb_m.ooeb005) THEN
                     IF g_ooeb_m.ooeb003 = '2' THEN
                        LET g_qryparam.where = "ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed002 = '",g_ooeb_m.ooeb005,"' AND ooed003 IN(SELECT ooed003 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND  ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed002 = '",g_ooeb_m.ooeb005,"' AND (ooed007 >= to_date('",g_today,"','YYYY/MM/DD') OR ooed007 IS NULL)) "
                     ELSE
                        LET g_qryparam.where = "ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed002 = '",g_ooeb_m.ooeb005,"' AND ooed003 IN(SELECT ooed003 FROM ooed_t WHERE ooedent = '",g_enterprise,"' AND  ooed001 = '",g_ooeb_m.ooeb004,"' AND ooed002 = '",g_ooeb_m.ooeb005,"' AND ooed006 > to_date('",g_today,"','YYYY/MM/DD'))"
                     END IF
                  END IF
               END IF
               
               CALL q_ooed003()                                #呼叫開窗
     
               LET g_ooeb_m.ooeb006 = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_ooeb_m.ooeb006 TO ooeb006              #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD ooeb006                          #返回原欄位

            END IF
            #END add-point


 #欄位開窗

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_ooeb_m.ooeb001
        
            IF g_ooeb_m.ooeb003 = '1' THEN
               #LET l_count = 1
               #IF NOT cl_null(g_ooeb_m.ooeb008) THEN
               #   SELECT COUNT(*) INTO l_count FROM ooeb_t WHERE ooeb004 = g_ooeb_m.ooeb004 AND ooeb005 = g_ooeb_m.ooeb005 AND ooeb007 = g_ooeb_m.ooeb007 AND ooeb008 = g_ooeb_m.ooeb008 AND g_ooeb_m.ooebstus <> 'X'
               #ELSE
               #   SELECT COUNT(*) INTO l_count FROM ooeb_t WHERE ooeb004 = g_ooeb_m.ooeb004 AND ooeb005 = g_ooeb_m.ooeb005 AND ooeb007 = g_ooeb_m.ooeb007 AND g_ooeb_m.ooebstus <> 'X'
               #END IF               
               IF (g_ooeb_m.ooeb004 != g_ooeb_m_t.ooeb004 OR cl_null(g_ooeb_m_t.ooeb004)) OR
                  (g_ooeb_m.ooeb005 != g_ooeb_m_t.ooeb005 OR cl_null(g_ooeb_m_t.ooeb005)) OR
                  (g_ooeb_m.ooeb007 != g_ooeb_m_t.ooeb007 OR cl_null(g_ooeb_m_t.ooeb007)) OR
                  (g_ooeb_m.ooeb008 != g_ooeb_m_t.ooeb008 OR (cl_null(g_ooeb_m_t.ooeb008) AND NOT cl_null(g_ooeb_m.ooeb008)) OR (cl_null(g_ooeb_m.ooeb008) AND NOT cl_null(g_ooeb_m_t.ooeb008)) ) THEN
                  LET l_count = 0
                  #mark by lixiang 2015/12/28---begin---
                  #新增時,輸入生效日期後應該要檢查 以組織類型+最上層組織+生效日期檢查不可有重複資料
                  #IF NOT cl_null(g_ooeb_m.ooeb008) THEN
                  #   SELECT COUNT(*) INTO l_count FROM ooeb_t 
                  #      WHERE ooeb004 = g_ooeb_m.ooeb004 AND ooeb005 = g_ooeb_m.ooeb005 AND ooeb007 = g_ooeb_m.ooeb007 AND ooeb008 = g_ooeb_m.ooeb008 
                  #        AND ooebstus <> 'X' AND ooebent = g_enterprise
                  #ELSE
                  #   SELECT COUNT(*) INTO l_count FROM ooeb_t 
                  #      WHERE ooeb004 = g_ooeb_m.ooeb004 AND ooeb005 = g_ooeb_m.ooeb005 AND ooeb007 = g_ooeb_m.ooeb007 
                  #        AND ooebstus <> 'X' AND ooebent = g_enterprise
                  #END IF
                  #mark by lixiang 2015/12/28---end---       
                  #add by lixiang 2015/12/28---begin=---
                  SELECT COUNT(*) INTO l_count FROM ooeb_t 
                        WHERE ooeb004 = g_ooeb_m.ooeb004 AND ooeb005 = g_ooeb_m.ooeb005 AND ooeb007 = g_ooeb_m.ooeb007
                          AND ooebstus <> 'X' AND ooebent = g_enterprise
                  #add by lixiang 2015/12/28---end=---
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     #LET g_errparam.code = 'aoo-00644'
                     LET g_errparam.code = 'aoo-00662' #add by lixiang 2015/12/28
                     LET g_errparam.extend = g_ooeb_m.ooeb005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD ooeb007
                  END IF
               END IF        
            END IF
               
            BEGIN WORK
            IF p_cmd <> 'u' THEN
               LET l_count = 1

               SELECT COUNT(*) INTO l_count FROM ooeb_t
                WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001

               IF l_count = 0 THEN

                  #add-point:單頭新增前
                  #CALL aooi110_auto_code() RETURNING g_ooeb_m.ooeb001
                  #DISPLAY BY NAME g_ooeb_m.ooeb001
                  #end add-point

                  INSERT INTO ooeb_t (ooebent,ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt)
                  VALUES (g_enterprise,g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt) # DISK WRITE
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_ooeb_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF

                  CALL aooi110_ins_ooec()
                  
                  COMMIT WORK

                  #add-point:單頭新增後
                  #IF g_ooeb_m.ooeb003 = '1' THEN
                  #   CALL aooi110_01(g_ooeb_m.ooeb001) RETURNING g_wcb
                  #   CALL aooi110_ins_tmp()
                  #END IF
                  
                  CALL aooi110_tree_tmp_fill()
                  CALL aooi110_tree_fill()
                  #end add-point

                  LET p_cmd = 'u'

               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = '!'
                  LET g_errparam.extend =  g_ooeb_m.ooeb001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  ROLLBACK WORK
                  NEXT FIELD ooeb001
               END IF
            ELSE

               #add-point:單頭修改前
               
               #end add-point

               UPDATE ooeb_t SET (ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt) = (g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt)
                WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb001_t

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_ooeb_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  ROLLBACK WORK
               END IF

               IF g_ooeb_m.ooeb005 != g_ooeb_m_t.ooeb005 OR g_ooeb_m.ooeb004 != g_ooeb_m_t.ooeb004 THEN
                  IF (g_ooeb_m.ooeb003 ='1' AND NOT l_flag) OR g_ooeb_m.ooeb003 ='2' THEN  #沒有預設上一版本的組織結構
                     DELETE FROM ooec_t WHERE ooecent = g_enterprise AND ooec008 = g_ooeb_m.ooeb001
                     
                     CALL aooi110_ins_ooec()
                  END IF
               END IF
               
               COMMIT WORK

               #add-point:單頭修改後
               #IF g_ooeb_m.ooeb003 = '1' THEN
               #   CALL aooi110_01(g_ooeb_m.ooeb001) RETURNING g_wcb
               #   DELETE FROM ooed_tmp
               #   CALL aooi110_ins_tmp()
               #END IF
               
               CALL aooi110_tree_tmp_fill()
               CALL aooi110_tree_fill()
               #end add-point

            END IF
           #controlp
      END INPUT


      #add-point:自定義input
      CONSTRUCT g_wc_table2 ON ooef001,ooef017
           FROM s_detail1[1].ooef001,s_detail1[1].ooef017

         BEFORE CONSTRUCT
            LET g_flag2 = TRUE   #表示已經走過查詢，需顯示單身資料
         
         ON ACTION controlp INFIELD ooef001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooefstus = 'Y' "
            IF NOT cl_null(g_ooeb_m.ooeb004) THEN
                CASE g_ooeb_m.ooeb004
                   WHEN '1'  LET g_qryparam.where = g_qryparam.where, " AND ooef203 = 'Y' " 
                   WHEN '4'  LET g_qryparam.where = g_qryparam.where, " AND ooef205 = 'Y' " 
                   WHEN '5'  LET g_qryparam.where = g_qryparam.where, " AND ooef207 = 'Y' "
                   WHEN '6'  LET g_qryparam.where = g_qryparam.where, " AND ooef206 = 'Y' "
                   WHEN '7'  LET g_qryparam.where = g_qryparam.where, " AND ooef206 = 'Y' "
                   WHEN '8'  LET g_qryparam.where = g_qryparam.where, " AND ooef201 = 'Y' "
                   WHEN '9'  LET g_qryparam.where = g_qryparam.where, " AND ooef208 = 'Y' "
                   WHEN '10' LET g_qryparam.where = g_qryparam.where, " AND ooef210 = 'Y' "
                   WHEN '11' LET g_qryparam.where = g_qryparam.where, " AND ooef211 = 'Y' "
                   WHEN '12' LET g_qryparam.where = g_qryparam.where, " AND ooef212 = 'Y' "
                END CASE
            END IF
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooef001  #顯示到畫面上
            NEXT FIELD ooef001
            
        ON ACTION controlp INFIELD ooef017
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooefstus = 'Y' "
            CALL q_ooef017()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ooef017  #顯示到畫面上
            NEXT FIELD ooef017
            
            
      END CONSTRUCT
      #end add-point

      BEFORE DIALOG
         #add-point:input段before dialog
         
         #end add-point
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD ooeb001
         END IF

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
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET g_action_choice="exit"
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG

   #add-point:input段after input
   CALL aooi110_ooef_fill()
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num10  #161108-00012#2 num5==》num10
   DEFINE l_sql     STRING
   {</Local define>}
   #add-point:show段define
   
   #end add-point

   #add-point:show段之前
   
   #end add-point



   LET g_ooeb_m_t.* = g_ooeb_m.*      #保存單頭舊值
   LET g_ooeb_m_o.* = g_ooeb_m.*

   CALL aooi110_ooef_fill()
   
   LET l_ac_t = l_ac

   #讀入ref值(單頭)
   #add-point:show段reference
   CALL aooi110_ooec005_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooeb_m.ooebmodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=?  ","") RETURNING g_rtn_fields
   LET g_ooeb_m.ooebmodid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooeb_m.ooebmodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooeb_m.ooebownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=?  ","") RETURNING g_rtn_fields
   LET g_ooeb_m.ooebownid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooeb_m.ooebownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooeb_m.ooebowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooeb_m.ooebowndp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooeb_m.ooebowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooeb_m.ooebcrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_ooeb_m.ooebcrtid_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooeb_m.ooebcrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_ooeb_m.ooebcrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_ooeb_m.ooebcrtdp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_ooeb_m.ooebcrtdp_desc
   #end add-point

   #將資料輸出到畫面上
   DISPLAY BY NAME g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb005_desc,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmodid_desc,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebownid_desc,g_ooeb_m.ooebowndp,g_ooeb_m.ooebowndp_desc,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtid_desc,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdp_desc,g_ooeb_m.ooebcrtdt

   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_ooeb_m.ooebstus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/void.png")

         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/valid.png")


      END CASE

   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

   #add-point:show段之後
   #CALL cl_set_act_visible("ins_aooi100,upd_aooi100,del_aooi100",TRUE)
   #IF g_ooeb_m.ooebstus <> "N" THEN
   #   CALL cl_set_act_visible("ins_aooi100,upd_aooi100,del_aooi100",FALSE)
   #END IF
   # 
   #IF g_rec_b2 > 0 THEN
   #   CALL cl_set_act_visible("upd_aooi100,del_aooi100", TRUE)
   #ELSE
   #   CALL cl_set_act_visible("upd_aooi100,del_aooi100", FALSE)
   #END IF
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_reproduce()
   {<Local define>}
   DEFINE l_newno     LIKE ooeb_t.ooeb001
   DEFINE l_oldno     LIKE ooeb_t.ooeb001

   #DEFINE l_master    RECORD LIKE ooeb_t.*  #161124-00048#7  2016/12/12 By 08734 mark
   #161124-00048#7  2016/12/12 By 08734 add(S)
   DEFINE l_master RECORD  #組織計劃申請單頭檔
       ooebent LIKE ooeb_t.ooebent, #企业编号
       ooebstus LIKE ooeb_t.ooebstus, #状态码
       ooeb001 LIKE ooeb_t.ooeb001, #申请编号
       ooeb002 LIKE ooeb_t.ooeb002, #申请日期
       ooeb003 LIKE ooeb_t.ooeb003, #变更类型
       ooeb004 LIKE ooeb_t.ooeb004, #组织类型
       ooeb005 LIKE ooeb_t.ooeb005, #最上层组织
       ooeb006 LIKE ooeb_t.ooeb006, #版本
       ooeb007 LIKE ooeb_t.ooeb007, #生效日期
       ooeb008 LIKE ooeb_t.ooeb008, #失效日期
       ooebownid LIKE ooeb_t.ooebownid, #资料所有者
       ooebowndp LIKE ooeb_t.ooebowndp, #资料所有部门
       ooebcrtid LIKE ooeb_t.ooebcrtid, #资料录入者
       ooebcrtdp LIKE ooeb_t.ooebcrtdp, #资料录入部门
       ooebcrtdt LIKE ooeb_t.ooebcrtdt, #资料创建日
       ooebmodid LIKE ooeb_t.ooebmodid, #资料更改者
       ooebmoddt LIKE ooeb_t.ooebmoddt, #最近更改日
       ooebcnfid LIKE ooeb_t.ooebcnfid, #资料审核者
       ooebcnfdt LIKE ooeb_t.ooebcnfdt #数据审核日
END RECORD
#161124-00048#7  2016/12/12 By 08734 add(E)
   #DEFINE l_detail    RECORD LIKE ooec_t.*  #161124-00048#7  2016/12/12 By 08734 mark 
   #161124-00048#7  2016/12/12 By 08734 add(S)
   DEFINE l_detail RECORD  #組織結構調整計劃暫存檔
       ooecent LIKE ooec_t.ooecent, #企业编号
       ooec001 LIKE ooec_t.ooec001, #组织类型
       ooec002 LIKE ooec_t.ooec002, #最上层组织
       ooec003 LIKE ooec_t.ooec003, #版本
       ooec004 LIKE ooec_t.ooec004, #组织编号
       ooec005 LIKE ooec_t.ooec005, #上级组织编号
       ooec006 LIKE ooec_t.ooec006, #生效日期
       ooec007 LIKE ooec_t.ooec007, #失效日期
       ooec008 LIKE ooec_t.ooec008 #申请编号
END RECORD
#161124-00048#7  2016/12/12 By 08734 add(E)

   DEFINE l_cnt       LIKE type_t.num5
   {</Local define>}
   #add-point:reproduce段define
   
   #end add-point

   #切換畫面
   #該樣板不需此段落IF g_main_hidden THEN
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("mainlayout",0)
   #該樣板不需此段落   CALL gfrm_curr.setElementHidden("worksheet",1)
   #該樣板不需此段落   LET g_main_hidden = 0
   #該樣板不需此段落END IF

   IF g_ooeb_m.ooeb001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

   CALL aooi110_set_entry('a')
   CALL aooi110_set_no_entry('a')

   CALL cl_set_head_visible("","YES")



   INPUT l_newno   # FROM

    FROM ooeb001


      #add-point:複製段落開窗/欄位控管/自定義action
      
      #end add-point

      BEFORE INPUT
         #add-point:複製段落Before input
         
         #end add-point

      AFTER FIELD ooeb001
         IF l_newno IS NULL THEN
            NEXT FIELD CURRENT
         END IF
         #add-point:AFTER FIELD ooeb001
         
         #end add-point



      AFTER INPUT
         #若取消則直接結束
         IF INT_FLAG = 1 THEN
            LET INT_FLAG = 0
            RETURN
         END IF

         #確定該key值是否有重複定義
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM ooeb_t
          WHERE ooebent = g_enterprise AND ooeb001 = l_newno

         IF l_cnt > 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00006"
            LET g_errparam.extend = "Reproduce"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            #NEXT FIELD ooeb001
         END IF

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE INPUT

   END INPUT

   IF INT_FLAG OR l_newno IS NULL THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   BEGIN WORK

  # SELECT * INTO l_master.* FROM ooeb_t  #161124-00048#7  2016/12/12 By 08734 mark
   SELECT ooebent,ooebstus,ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt,ooebmodid,ooebmoddt,ooebcnfid,ooebcnfdt 
      INTO l_master.* FROM ooeb_t  #161124-00048#7  2016/12/12 By 08734 add
    WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001

   LET l_master.ooeb001 = l_newno


   #公用欄位給予預設值(單頭)
   #此段落由子樣板a13產生
      LET l_master.ooebownid = g_user
      LET l_master.ooebowndp = g_dept
      LET l_master.ooebcrtid = g_user
      LET l_master.ooebcrtdp = g_dept
      LET l_master.ooebcrtdt = cl_get_current()
      LET l_master.ooebmodid = ''
      LET l_master.ooebmoddt = ''
      LET l_master.ooebstus = "Y"



   #公用欄位給予預設值(單身)


   #add-point:單頭複製前
   
   #end add-point

   #INSERT INTO ooeb_t VALUES (l_master.*) #複製單頭   #161124-00048#7  2016/12/12 By 08734 mark
   INSERT INTO ooeb_t(ooebent,ooebstus,ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt,ooebmodid,ooebmoddt,ooebcnfid,ooebcnfdt)
      VALUES (l_master.ooebent,l_master.ooebstus,l_master.ooeb001,l_master.ooeb002,l_master.ooeb003,l_master.ooeb004,l_master.ooeb005,l_master.ooeb006,l_master.ooeb007,l_master.ooeb008,l_master.ooebownid,l_master.ooebowndp,l_master.ooebcrtid,l_master.ooebcrtdp,l_master.ooebcrtdt,l_master.ooebmodid,l_master.ooebmoddt,l_master.ooebcnfid,l_master.ooebcnfdt)  #161124-00048#7  2016/12/12 By 08734 add
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ooeb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      ROLLBACK WORK
      RETURN
   END IF

   #add-point:單頭複製後
   
   #end add-point



   #LET g_sql = "SELECT * FROM ooec_t WHERE ooecent = '" ||g_enterprise|| "' AND ",   #161124-00048#7  2016/12/12 By 08734 mark
   LET g_sql = "SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008 FROM ooec_t WHERE ooecent = '" ||g_enterprise|| "' AND ",  #161124-00048#7  2016/12/12 By 08734 add
               " ooec008 = '",g_ooeb_m.ooeb001,"'"

   DECLARE aooi110_reproduce CURSOR FROM g_sql

   FOREACH aooi110_reproduce INTO l_detail.*
      LET l_detail.ooec008 = l_newno


      #add-point:單身複製前1
      
      #end add-point

     # INSERT INTO ooec_t VALUES (l_detail.*) #複製單身 #161124-00048#7  2016/12/12 By 08734 mark
      INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008)  
         VALUES (l_detail.ooecent,l_detail.ooec001,l_detail.ooec002,l_detail.ooec003,l_detail.ooec004,l_detail.ooec005,l_detail.ooec006,l_detail.ooec007,l_detail.ooec008) #複製單身  #161124-00048#7  2016/12/12 By 08734 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'Insert error!'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         ROLLBACK WORK
         RETURN
      END IF

      #add-point:單身複製後1
      
      #end add-point

   END FOREACH



   COMMIT WORK
   ERROR 'ROW(',l_newno,') O.K'

   CLOSE aooi110_reproduce

   LET g_state = "Y"

   LET g_wc = g_wc,
              " OR (",
              " ooeb001 = '", l_newno CLIPPED, "' "

              , ") "

   #add-point:完成複製段落後
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_delete()
   {<Local define>}
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   {</Local define>}
   #add-point:delete段define
   
   #end add-point

   IF g_ooeb_m.ooeb001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF

    SELECT UNIQUE ooeb001,ooeb002,ooeb003,ooeb004,ooeb005,ooeb006,ooeb007,ooeb008,ooebstus,ooebmodid,ooebmoddt,ooebownid,ooebowndp,ooebcrtid,ooebcrtdp,ooebcrtdt
 INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebowndp,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdt
 FROM ooeb_t
 WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001
   BEGIN WORK



   OPEN aooi110_cl USING g_enterprise,g_ooeb_m.ooeb001

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aooi110_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      CLOSE aooi110_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH aooi110_cl INTO g_ooeb_m.ooeb001,g_ooeb_m.ooeb002,g_ooeb_m.ooeb003,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb005_desc,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooebstus,g_ooeb_m.ooebmodid,g_ooeb_m.ooebmodid_desc,g_ooeb_m.ooebmoddt,g_ooeb_m.ooebownid,g_ooeb_m.ooebownid_desc,g_ooeb_m.ooebowndp,g_ooeb_m.ooebowndp_desc,g_ooeb_m.ooebcrtid,g_ooeb_m.ooebcrtid_desc,g_ooeb_m.ooebcrtdp,g_ooeb_m.ooebcrtdp_desc,g_ooeb_m.ooebcrtdt              # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_ooeb_m.ooeb001
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      ROLLBACK WORK
      RETURN
   END IF

   CALL aooi110_show()

   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = "ooeb001"
      LET g_doc.value1 = g_ooeb_m.ooeb001
#      CALL cl_del_doc()

      #add-point:單頭刪除前
      
      #end add-point

      #資料備份
      LET g_ooeb001_t = g_ooeb_m.ooeb001


      DELETE FROM ooeb_t
       WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_ooeb_m.ooeb001
      LET g_errparam.popup = FALSE
      CALL cl_err()

         ROLLBACK WORK
         RETURN
      END IF

      DELETE FROM ooed_t 
       WHERE ooedent = g_enterprise
         AND ooed001 = g_ooeb_m.ooeb004
         AND ooed002 = g_ooeb_m.ooeb005
         AND ooed003 = g_ooeb_m.ooeb006
         AND ooed008 = g_ooeb_m.ooeb001
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del ooed_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         ROLLBACK WORK
         RETURN
      END IF

      #add-point:單身刪除前
      
      #end add-point

      DELETE FROM ooec_t
       WHERE ooecent = g_enterprise AND ooec008 = g_ooeb_m.ooeb001


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooec_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

         ROLLBACK WORK
         RETURN
      END IF





      #add-point:單身刪除後
      
      #end add-point

      CLEAR FORM

      CALL aooi110_ui_browser_refresh()
      #CALL aooi110_ui_headershow()
      #CALL aooi110_ui_detailshow()

      IF g_browser_cnt > 0 THEN
         CALL aooi110_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         CALL aooi110_browser_fill("F")
      END IF

   END IF

   CLOSE aooi110_cl
   COMMIT WORK

   #流程通知預埋點-D
   CALL cl_flow_notify(g_ooeb_m.ooeb001,'D')

END FUNCTION

PRIVATE FUNCTION aooi110_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   
   #end add-point

   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("ooeb001",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("ooeb001",FALSE)
      #end add-point
   END IF
   CALL cl_set_comp_entry("ooeb007",TRUE)
   CALL cl_set_comp_entry("ooeb006",TRUE)
   CALL cl_set_comp_entry("ooeb008",TRUE)  
   LET g_flag = 'Y'   
END FUNCTION

PRIVATE FUNCTION aooi110_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   
   #end add-point

   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("ooeb001",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point
   END IF
   IF g_ooeb_m.ooeb003 = '2' AND (g_ooeb_m.ooeb007 <= g_today AND (g_ooeb_m.ooeb008 > g_today OR g_ooeb_m.ooeb008 IS NULL))THEN
      LET g_flag = 'N'
      CALL cl_set_comp_entry("ooeb007",FALSE)
   END IF
   IF g_ooeb_m.ooeb003 = '3' THEN
      CALL cl_set_comp_entry("ooeb008",FALSE)
   END IF
   IF g_ooeb_m.ooeb003 = '1' THEN 
      CALL cl_set_comp_entry("ooeb006",FALSE)
   END IF
END FUNCTION
#樹顯示
PRIVATE FUNCTION aooi110_tree_fill()
DEFINE l_n        LIKE type_t.num5
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE ls_msg     STRING
DEFINE l_n2       LIKE type_t.num5

   DELETE FROM ooed_tmp
   
   IF NOT cl_null(g_ooeb_m.ooeb008) THEN
      LET g_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
                  #" SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"',ooec008  ",
                  " SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec007,'",g_ooeb_m.ooeb008,"',ooec008  ",
                  "   FROM ooec_t ",
                  "  WHERE ooecent = '",g_enterprise,"' ",
                  "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooec003 = '",g_ooeb_m.ooeb006,"' ",
                  "    AND ooec008 = '",g_ooeb_m.ooeb001,"' "
   ELSE
      LET g_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
                  #" SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','',ooec008  ",
                  " SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec007,'',ooec008  ",
                  "   FROM ooec_t ",
                  "  WHERE ooecent = '",g_enterprise,"' ",
                  "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooec003 = '",g_ooeb_m.ooeb006,"' ",
                  "    AND ooec008 = '",g_ooeb_m.ooeb001,"' "
   END IF
   PREPARE aooi110_ins_ooed_tmp_pre3 FROM g_sql
   EXECUTE aooi110_ins_ooed_tmp_pre3
   CALL g_tree.clear()
   LET g_cnt = 1
   LET l_n = 1
   LET g_sql = " SELECT UNIQUE ooed005,ooed003 FROM ooed_tmp ",
               "  WHERE ooedent = '" ||g_enterprise|| "' ",
               "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
               "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
               "    AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
#               "    AND ooed006 <= '",g_today,"' ",
#               "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
               "    AND ooed005 = ooed002 ",
               "  ORDER BY ooed005 "          
   PREPARE tree_pre3 FROM g_sql
   DECLARE tree_cur3 CURSOR FOR tree_pre3
   FOREACH tree_cur3 INTO g_tree[g_cnt].b_ooed005,g_tree[g_cnt].b_ooed003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_tree[g_cnt].b_ooed004 = g_tree[g_cnt].b_ooed005
      LET g_tree[g_cnt].b_ooed002 = g_tree[g_cnt].b_ooed005
      LET g_tree[g_cnt].b_pid = '0' CLIPPED
      LET g_tree[g_cnt].b_id = g_cnt USING "<<<"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[g_cnt].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_tree[g_cnt].b_ooed004_desc = g_rtn_fields[1]
      LET ls_msg = cl_getmsg("aoo-00232",g_dlang)
      LET g_tree[g_cnt].b_show =  g_tree[g_cnt].b_ooed005,' (',g_tree[g_cnt].b_ooed004_desc,')','(',ls_msg,g_tree[g_cnt].b_ooed003,')'
      LET g_tree[g_cnt].b_exp = TRUE
      LET g_tree[g_cnt].b_hasC = TRUE
      LET g_tree[g_cnt].b_isExp = TRUE
      LET l_pid = g_tree[g_cnt].b_id CLIPPED
      LET l_n = g_cnt
      LET g_cnt = g_cnt + 1   
      LET g_sql = " SELECT UNIQUE ooed004 FROM ooed_tmp ",
                  "  WHERE ooedent = '" ||g_enterprise|| "' ",
                  "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
#                  "    AND ooed006 <= '",g_today,"' ",
#                  "    AND (ooed007 IS NULL OR ooed007 >= '",g_today,"') ",
                  "    AND ooed005 = '",g_tree[l_n].b_ooed005,"' ",
                  "    AND ooed004 <> ooed005 ",
                  "  ORDER BY ooed004 "           
      PREPARE tree_pre4 FROM g_sql
      DECLARE tree_cur4 CURSOR FOR tree_pre4
      FOREACH tree_cur4 INTO g_tree[g_cnt].b_ooed004
         LET g_tree[g_cnt].b_ooed002 = g_tree[l_n].b_ooed002
         LET g_tree[g_cnt].b_ooed005 = g_tree[l_n].b_ooed002
         LET g_tree[g_cnt].b_pid = l_pid
         LET g_tree[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_tree[g_cnt].b_ooed004
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_tree[g_cnt].b_ooed004_desc = g_rtn_fields[1]
         LET g_tree[g_cnt].b_show =  g_tree[g_cnt].b_ooed004,' (',g_tree[g_cnt].b_ooed004_desc,')'
         LET g_tree[g_cnt].b_exp = TRUE
         LET g_tree[g_cnt].b_hasC = aooi110_chk_hasC(g_cnt)
         IF g_tree[g_cnt].b_hasC = 1 THEN
            CALL aooi110_tree_expand(g_cnt)
            LET g_cnt = g_tree.getLength()
         END IF
         LET g_cnt = g_cnt +1
      END FOREACH
      LET l_n = g_tree.getLength() 
   END FOREACH
   CALL g_tree.deleteElement(l_n)
   FREE tree_pre3
   FREE tree_pre4
   FOR l_n2 = 1 TO g_tree.getLength()
      IF g_tree[l_n2].b_isExp is null THEN
         CALL aooi110_tree_expand(l_n2)
      END IF
   END FOR
END FUNCTION

PRIVATE FUNCTION aooi110_default_search()
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
      LET ls_wc = ls_wc, " ooeb001 = '", g_argv[1], "' AND "
   END IF



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

PRIVATE FUNCTION aooi110_statechange()
   {<Local define>}
   DEFINE lc_state LIKE type_t.chr5
   DEFINE l_n        LIKE type_t.num10    #160203-00004#1   zhujing add      
   DEFINE l_success  LIKE type_t.num5     #160203-00004#1   zhujing add
   {</Local define>}
   #add-point:statechange段define

   #end add-point

   #add-point:statechange段開始前
   IF g_ooeb_m.ooebstus MATCHES '[XY]' THEN
      RETURN
   END IF
   CALL s_transaction_begin()   #160812-00017#4 20160815 add by beckxie
   #end add-point

   ERROR ""     #清空畫面右下側ERROR區塊

   IF g_ooeb_m.ooeb001 IS NULL

   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
      RETURN
   END IF

   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU

         CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
         CASE g_ooeb_m.ooebstus
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed",FALSE)
            #150916-00011#3 Add By Ken 150923(S)
            WHEN "Y"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)            
            #150916-00011#3 Add By Ken 150923(E)
            
            WHEN "X"
               CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
               
            #150916-00011#3 Mark By Ken 150923(S)
            #WHEN "Y"
            #   CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            #150916-00011#3 Mark By Ken 150923(E)
         END CASE
         
         ON ACTION unconfirmed
            #modify--151110-00030#1--By shiun--(S)
            LET g_action_choice = "unconfirmed"
            IF cl_auth_chk_act("unconfirmed") THEN
               LET lc_state = "N"
            END IF
            #modify--151110-00030#1--By shiun--(E)
            EXIT MENU
         #150916-00011#3 Add By Ken 150923(S)   
         ON ACTION confirmed
            LET lc_state = "Y"
            EXIT MENU          
         #150916-00011#3 Add By Ken 150923(E)
         
         ON ACTION invalid
            LET lc_state = "X"
            EXIT MENU
            
         #150916-00011#3 Mark By Ken 150923(S)
         #ON ACTION confirmed
         #   LET lc_state = "Y"
         #   EXIT MENU 
         #150916-00011#3 Mark By Ken 150923(E)
   END MENU

   IF (lc_state <> "N"
      AND lc_state <> "Y"


      AND lc_state <> "X"

      ) OR
      cl_null(lc_state) THEN
      CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
      RETURN
   END IF

   #add-point:stus修改前
   
   IF lc_state = 'X' THEN
      #151125-00001#3 ---add (S)---
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
      #151125-00001#3 ---add (E)---
         DELETE FROM ooed_t 
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
      END IF  #151125-00001#3 add
   END IF
   #160203-00004#1   zhujing mod------(S)
#   IF lc_state = 'Y' THEN
#      IF NOT cl_ask_confirm('aim-00108') THEN
#         RETURN
#      END IF
#      IF NOT aooi110_chk_conf() THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'aoo-00275'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         RETURN
#      END IF
#      CALL aooi110_confirm()
#      CALL aooi110_del_ooed_tmp()
#      RETURN
#   END IF
   IF lc_state = 'Y' THEN
      IF NOT cl_ask_confirm('aim-00108') THEN
         CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
         RETURN
      END IF
      CALL cl_err_collect_init()    
      LET l_success = TRUE 
      FOR l_n = 1 TO g_tree.getLength()
         CALL s_aooi110_conf_chk(g_ooeb_m.*,g_tree[l_n].b_ooed004) RETURNING l_success
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00275'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL cl_err_collect_show()
            CALL s_transaction_end('N','0')   #160812-00017#4 20160815 add by beckxie
            RETURN
         END IF
      END FOR
      IF l_success THEN
         #CALL s_transaction_begin()   #160812-00017#4 20160815 mark by beckxie
         CALL s_aooi110_conf_upd(g_ooeb_m.*) RETURNING l_success,g_flag3
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         ELSE
            LET g_success = 'Y'
            CALL s_transaction_end('Y','0')
         END IF
      END IF
      
      CALL aooi110_del_ooed_tmp()
      CALL cl_err_collect_show()
      RETURN
   END IF
   #160203-00004#1   zhujing mod------(E)
   
   #end add-point

   UPDATE ooeb_t SET ooebstus = lc_state
    WHERE ooebent = g_enterprise AND ooeb001 = g_ooeb_m.ooeb001


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
         #150916-00011#3 Add By Ken 150923(S)
         WHEN "Y"        
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")         
         #150916-00011#3 Add By Ken 150923(E)
         
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
            
         #150916-00011#3 Mark By Ken 150923(S)
         #WHEN "Y"
         #   CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         #150916-00011#3 Mark By Ken 150923(E)

      END CASE
   END IF

   #add-point:stus修改後

   #end add-point

   #add-point:statechange段結束前
   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aooi110_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_ooef_d.getLength() THEN
         LET g_detail_idx = g_ooef_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_ooef_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_ooef_d.getLength() TO FORMONLY.cnt
   END IF



END FUNCTION

PRIVATE FUNCTION aooi110_del_ooed_tmp()
#   IF g_action_choice="insert"  THEN
#      DELETE FROM ooed_tmp where ooed009 = '2' AND ooed008 <> g_ooeb_m.ooeb001
#   ELSE
#      DELETE FROM ooed_tmp where ooed009 = '2'
#   END IF
END FUNCTION
# 申請單號自動編碼
PRIVATE FUNCTION aooi110_auto_code()
DEFINE l_no           LIKE type_t.num10
   DEFINE ps_slip        STRING
  
   #组成流水号
   SELECT MAX(to_number(ooeb001)) +1 INTO l_no
     FROM ooeb_t
    WHERE ooebent = g_enterprise   #160905-00007#8  add 
   #如果不存在编号则是第一次编号
   IF cl_null(l_no) THEN
      LET l_no = 1
   END IF
   LET ps_slip=l_no USING "&&&&&&"
   RETURN ps_slip
END FUNCTION
# 生失效日期檢查
PRIVATE FUNCTION aooi110_chk_date()
LET g_errno = ''
   
   IF NOT cl_null(g_ooeb_m.ooeb007) AND NOT cl_null(g_ooeb_m.ooeb008) THEN
      IF g_ooeb_m.ooeb007 >= g_ooeb_m.ooeb008 THEN
         LET g_errno = 'aoo-00122'
      END IF
   END IF
END FUNCTION
# 确认ACTION
# 已使用元件 zhujing mark 160203-00004#1
PRIVATE FUNCTION aooi110_confirm()
#   DEFINE l_sql          STRING
#   DEFINE l_n            LIKE type_t.num5
#   DEFINE l_ooed003      LIKE ooed_t.ooed003
#   DEFINE l_ooed006      LIKE ooed_t.ooed006
#   DEFINE l_ooed007      LIKE ooed_t.ooed007
#   DEFINE l_ooed006_min  LIKE ooed_t.ooed006
#   DEFINE l_ooed007_max  LIKE ooed_t.ooed007
#   DEFINE l_auto         LIKE ooed_t.ooed003
#   DEFINE l_no           LIKE type_t.num5
#   DEFINE l_n1           LIKE type_t.num5
#   DEFINE l_s            LIKE type_t.num5
#   DEFINE l_sql1         STRING
#   DEFINE l_ooed003_1    LIKE ooed_t.ooed003
#   DEFINE l_ooed006_1    LIKE ooed_t.ooed006
#   DEFINE l_ooed007_1    LIKE ooed_t.ooed007
#   
#   LET l_s = 0
#   CALL s_transaction_begin()
#   LET g_success = 'Y'
#   IF g_ooeb_m.ooeb003 = '1' OR g_ooeb_m.ooeb003 = '2' THEN
#      IF g_ooeb_m.ooeb003 = '2' THEN
#         DELETE FROM ooed_t 
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#            AND ooed003 = g_ooeb_m.ooeb006
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "del_ooed"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            LET g_success = 'N'
#            RETURN
#         END IF      
#      END IF
#      LET l_n = 0
#      IF g_ooeb_m.ooeb003 = '2' THEN
#         SELECT COUNT(*) INTO l_n FROM ooed_t
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#            AND ooed003 = g_ooeb_m.ooeb006
#      ELSE
#         SELECT COUNT(*) INTO l_n FROM ooed_t
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#      END IF
#      IF l_n = 0 THEN
#         IF NOT cl_null(g_ooeb_m.ooeb008) THEN
#            LET l_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                        " SELECT DISTINCT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                        "   FROM ooec_t ",
#                        "  WHERE ooecent = '",g_enterprise,"' ",
#                        "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                        "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                        "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                        #" SELECT DISTINCT ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                        #"   FROM ooed_tmp ",
#                        #"  WHERE ooedent = '",g_enterprise,"' ",
#                        #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                        #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' "
#         ELSE
#            LET l_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                        " SELECT DISTINCT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                        "   FROM ooec_t ",
#                        "  WHERE ooecent = '",g_enterprise,"' ",
#                        "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                        "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                        "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                        #" SELECT DISTINCT ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                        #"   FROM ooed_tmp ",
#                        #"  WHERE ooedent = '",g_enterprise,"' ",
#                        #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                        #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' "
#                        
#         END IF
#         PREPARE ins_ooed_pre FROM l_sql
#         EXECUTE ins_ooed_pre
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "ins_ooed"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            LET g_success = 'N'
#            RETURN
#         END IF
#      ELSE
#         SELECT MIN(ooed006) INTO l_ooed006_min
#           FROM ooed_t
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#         
#         SELECT MAX(ooed007) INTO l_ooed007_max
#           FROM ooed_t
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#            
#         LET l_n1 = 0
#         SELECT COUNT(*) INTO l_n1
#           FROM ooed_t
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005        
#            AND ooed007 IS NULL
#         IF l_n1 > 0 THEN
#            LET l_ooed007_max = ''
#         END IF
#         IF g_ooeb_m.ooeb008 <= l_ooed006_min AND NOT cl_null(g_ooeb_m.ooeb008) THEN #此资料是历史版本
#            IF g_ooeb_m.ooeb008 = l_ooed006_min THEN
#               UPDATE ooed_t SET ooed006 = g_ooeb_m.ooeb008 + 1 
#                WHERE ooedent = g_enterprise
#                  AND ooed001 = g_ooeb_m.ooeb004
#                  AND ooed002 = g_ooeb_m.ooeb005
#                  AND ooed006 = g_ooeb_m.ooeb008
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  LET g_success = 'N'
#                  RETURN
#               END IF
#            END IF
#            SELECT MAX(to_number(ooed003)) +1 INTO l_no
#              FROM ooed_t
#             WHERE ooedent = g_enterprise
#               AND ooed001 = g_ooeb_m.ooeb004
#               AND ooed002 = g_ooeb_m.ooeb005
#            #如果不存在编号则是第一次编号
#            IF cl_null(l_no) THEN
#               LET l_no = 1
#            END IF
#            LET l_auto = l_no
#            LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                        " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                        "   FROM ooec_t ",
#                        "  WHERE ooecent = '",g_enterprise,"' ",
#                        "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                        "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                        "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                        #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                        #"   FROM ooed_tmp ",
#                        #"  WHERE ooedent = '",g_enterprise,"' ",
#                        #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                        #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                        #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#            PREPARE ins_ooed_conf_pre_4 FROM g_sql
#            EXECUTE ins_ooed_conf_pre_4
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "ins_ooed"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#               CALL s_transaction_end('N','0')
#               LET g_success = 'N'
#               RETURN
#            END IF
#            UPDATE ooeb_t 
#               SET ooebstus = 'Y'
#             WHERE ooebent = g_enterprise 
#               AND ooeb001 = g_ooeb_m.ooeb001
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "upd_ooebstus"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               CALL s_transaction_end('N','0')
#               LET g_success = 'N'
#               RETURN
#            END IF
#            CALL s_transaction_end('Y','0')
#            RETURN
#         END IF
#         IF g_ooeb_m.ooeb007 >= l_ooed007_max AND NOT cl_null(l_ooed007_max) THEN #此资料是未来的版本
#            IF g_ooeb_m.ooeb007 = l_ooed007_max THEN
#               UPDATE ooed_t SET ooed007 = g_ooeb_m.ooeb007 - 1 
#                WHERE ooedent = g_enterprise
#                  AND ooed001 = g_ooeb_m.ooeb004
#                  AND ooed002 = g_ooeb_m.ooeb005
#                  AND ooed007 = g_ooeb_m.ooeb007
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  LET g_success = 'N'
#                  RETURN
#               END IF
#            END IF
#            SELECT MAX(to_number(ooed003)) +1 INTO l_no
#              FROM ooed_t
#             WHERE ooedent = g_enterprise
#               AND ooed001 = g_ooeb_m.ooeb004
#               AND ooed002 = g_ooeb_m.ooeb005
#            #如果不存在编号则是第一次编号
#            IF cl_null(l_no) THEN
#               LET l_no = 1
#            END IF
#            LET l_auto =l_no
#            IF g_ooeb_m.ooeb008 IS NULL THEN
#               LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                           " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                           "   FROM ooec_t ",
#                           "  WHERE ooecent = '",g_enterprise,"' ",
#                           "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                           "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                           "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                          #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                          #"   FROM ooed_tmp ",
#                          #"  WHERE ooedent = '",g_enterprise,"' ",
#                          #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                          #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                          #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#            ELSE
#               LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                           " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                           "   FROM ooec_t ",
#                           "  WHERE ooecent = '",g_enterprise,"' ",
#                           "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                           "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                           "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                          #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                          #"   FROM ooed_tmp ",
#                          #"  WHERE ooedent = '",g_enterprise,"' ",
#                          #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                          #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                          #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#            END IF
#            PREPARE ins_ooed_conf_pre_5 FROM g_sql
#            EXECUTE ins_ooed_conf_pre_5
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "ins_ooed"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#               CALL s_transaction_end('N','0')
#               LET g_success = 'N'
#               RETURN
#            END IF
#            UPDATE ooeb_t 
#               SET ooebstus = 'Y'
#             WHERE ooebent = g_enterprise 
#               AND ooeb001 = g_ooeb_m.ooeb001
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "upd_ooebstus"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               CALL s_transaction_end('N','0')
#               LET g_success = 'N'
#               RETURN
#            END IF
#            CALL s_transaction_end('Y','0')
#            RETURN
#         END IF
#         LET g_sql =  " SELECT DISTINCT ooed003,ooed006,ooed007 FROM ooed_t ",
#                      "  WHERE ooedent = '",g_enterprise,"' ",
#                      "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                      "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                      "  ORDER BY ooed006,ooed007 "   
#         PREPARE aooi110_status_pb FROM g_sql
#         DECLARE aooi110_status_cs CURSOR FOR aooi110_status_pb 
#         FOREACH aooi110_status_cs INTO l_ooed003,l_ooed006,l_ooed007
#            IF SQLCA.sqlcode THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = SQLCA.sqlcode
#               LET g_errparam.extend = "FOREACH"
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               CALL s_transaction_end('N','0')
#               LET g_success = 'N'
#               RETURN
#            END IF
#            IF g_ooeb_m.ooeb008 IS NOT NULL AND g_ooeb_m.ooeb007 <= l_ooed006 AND g_ooeb_m.ooeb008 >= l_ooed006 THEN
#               SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                 FROM ooed_t
#                WHERE ooedent = g_enterprise
#                  AND ooed001 = g_ooeb_m.ooeb004
#                  AND ooed002 = g_ooeb_m.ooeb005
#               #如果不存在编号则是第一次编号
#               IF cl_null(l_no) THEN
#                  LET l_no = 1
#               END IF
#               LET l_auto =l_no
#               LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                           " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                           "   FROM ooec_t ",
#                           "  WHERE ooecent = '",g_enterprise,"' ",
#                           "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                           "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                           "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                          #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                          #"   FROM ooed_tmp ",
#                          #"  WHERE ooedent = '",g_enterprise,"' ",
#                          #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                          #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                          #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#               PREPARE ins_ooed_conf_pre_16 FROM g_sql
#               EXECUTE ins_ooed_conf_pre_16
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "ins_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  LET g_success = 'N'
#                  RETURN
#               END IF
#               UPDATE ooed_t SET ooed006 = g_ooeb_m.ooeb008 + 1 
#                WHERE ooedent = g_enterprise
#                  AND ooed001 = g_ooeb_m.ooeb004
#                  AND ooed002 = g_ooeb_m.ooeb005
#                  AND ooed003 = l_ooed003
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')
#                  LET g_success = 'N'
#                  RETURN
#               END IF
#               EXIT FOREACH
#            END IF
#            IF g_ooeb_m.ooeb008 IS NULL OR g_ooeb_m.ooeb008 >= l_ooed007_max THEN  #此资料在其他的版本内，但是最大版本（结束日期最大）
#               IF g_ooeb_m.ooeb007 = l_ooed007 OR cl_null(l_ooed007) THEN
#                  UPDATE ooed_t SET ooed007 = g_ooeb_m.ooeb007 - 1 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed003 = l_ooed003
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                    FROM ooed_t
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                  #如果不存在编号则是第一次编号
#                  IF cl_null(l_no) THEN
#                     LET l_no = 1
#                  END IF
#                  LET l_auto =l_no
#                  UPDATE ooeb_t SET ooebstus = 'X'
#                   WHERE ooebent = g_enterprise
#                     AND ooeb001 IN (SELECT ooed008 FROM ooed_t
#                                      WHERE ooedent = g_enterprise
#                                        AND ooed001 = g_ooeb_m.ooeb004
#                                        AND ooed002 = g_ooeb_m.ooeb005
#                                        AND ooed006 > g_ooeb_m.ooeb007)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "upd_ooeb"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  DELETE FROM ooed_t 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed006 > g_ooeb_m.ooeb007
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "del_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF 
#                  IF g_ooeb_m.ooeb008 IS NULL THEN
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  ELSE
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooed001,ooed002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  END IF
#                  PREPARE ins_ooed_conf_pre_12 FROM g_sql
#                  EXECUTE ins_ooed_conf_pre_12
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "ins_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  EXIT FOREACH
#               END IF
#               IF g_ooeb_m.ooeb007 >= l_ooed006 AND g_ooeb_m.ooeb007 <= l_ooed007 THEN  #开始日期在此版本范围内
#                  SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                    FROM ooed_t
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                  #如果不存在编号则是第一次编号
#                  IF cl_null(l_no) THEN
#                     LET l_no = 1
#                  END IF
#                  LET l_auto =l_no
#                  UPDATE ooed_t SET ooed007 = g_ooeb_m.ooeb007 - 1 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed003 = l_ooed003
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "upd_ooed"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  UPDATE ooeb_t SET ooebstus = 'X'
#                   WHERE ooebent = g_enterprise
#                     AND ooeb001 IN (SELECT ooed008 FROM ooed_t
#                                      WHERE ooedent = g_enterprise
#                                        AND ooed001 = g_ooeb_m.ooeb004
#                                        AND ooed002 = g_ooeb_m.ooeb005
#                                        AND ooed006 >= g_ooeb_m.ooeb007)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "upd_ooeb"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  DELETE FROM ooed_t 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed006 >= g_ooeb_m.ooeb007
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "del_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  IF g_ooeb_m.ooeb008 IS NULL THEN
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  ELSE
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  END IF
#                  PREPARE ins_ooed_conf_pre_1 FROM g_sql
#                  EXECUTE ins_ooed_conf_pre_1
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "ins_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  EXIT FOREACH
#               END IF
#               IF g_ooeb_m.ooeb007 <= l_ooed006 THEN #开始日期不在已有的版本范围内，在此版本之前，在前面的版本之后
#                  SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                    FROM ooed_t
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                  #如果不存在编号则是第一次编号
#                  IF cl_null(l_no) THEN
#                     LET l_no = 1
#                  END IF
#                  LET l_auto =l_no
#                  UPDATE ooeb_t SET ooebstus = 'X'
#                   WHERE ooebent = g_enterprise
#                     AND ooeb001 IN (SELECT ooed008 FROM ooed_t
#                                      WHERE ooedent = g_enterprise
#                                        AND ooed001 = g_ooeb_m.ooeb004
#                                        AND ooed002 = g_ooeb_m.ooeb005
#                                        AND ooed006 >= l_ooed006)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "upd_ooeb"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  DELETE FROM ooed_t 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed006 >= l_ooed006
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "del_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  IF g_ooeb_m.ooeb008 IS NULL THEN
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  ELSE
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  END IF
#                  PREPARE ins_ooed_conf_pre_2 FROM g_sql
#                  EXECUTE ins_ooed_conf_pre_2
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "ins_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  EXIT FOREACH
#               END IF
#            END IF
#            IF NOT cl_null(g_ooeb_m.ooeb008) AND g_ooeb_m.ooeb008 <= l_ooed007_max AND g_ooeb_m.ooeb007 >= l_ooed006_min THEN #此资料在其他的版本内，但不是最大版本
#               IF l_ooed006 = g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008 = l_ooed007 THEN #开始日期结束日期重叠
#                  SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                    FROM ooed_t
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                  #如果不存在编号则是第一次编号
#                  IF cl_null(l_no) THEN
#                     LET l_no = 1
#                  END IF
#                  LET l_auto =l_no
#                  UPDATE ooeb_t SET ooebstus = 'X'
#                   WHERE ooebent = g_enterprise
#                     AND ooeb001 IN (SELECT ooed008 FROM ooed_t
#                                      WHERE ooedent = g_enterprise
#                                        AND ooed001 = g_ooeb_m.ooeb004
#                                        AND ooed002 = g_ooeb_m.ooeb005
#                                        AND ooed003 = l_ooed003)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "upd_ooeb"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF                        
#                  DELETE FROM ooed_t 
#                   WHERE ooedent = g_enterprise
#                     AND ooed001 = g_ooeb_m.ooeb004
#                     AND ooed002 = g_ooeb_m.ooeb005
#                     AND ooed003 = l_ooed003
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "del_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF  
#                  IF g_ooeb_m.ooeb008 IS NULL THEN
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  ELSE
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                 "   FROM ooec_t ",
#                                 "  WHERE ooecent = '",g_enterprise,"' ",
#                                 "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                 "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                 "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                #"   FROM ooed_tmp ",
#                                #"  WHERE ooedent = '",g_enterprise,"' ",
#                                #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                  END IF
#                  PREPARE ins_ooed_conf_pre_7 FROM g_sql
#                  EXECUTE ins_ooed_conf_pre_7
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "ins_ooed"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                     LET g_success = 'N'
#                     RETURN
#                  END IF
#                  EXIT FOREACH
#               END IF
#               IF g_ooeb_m.ooeb007 > l_ooed006 THEN #此资料开始日期在一个版本日期内
#                  IF (g_ooeb_m.ooeb008 <= l_ooed007 AND l_ooed007 IS NOT NULL) OR (l_ooed007 IS NULL ) THEN
#                     SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                       FROM ooed_t
#                      WHERE ooedent = g_enterprise
#                        AND ooed001 = g_ooeb_m.ooeb004
#                        AND ooed002 = g_ooeb_m.ooeb005
#                     #如果不存在编号则是第一次编号
#                     IF cl_null(l_no) THEN
#                        LET l_no = 1
#                     END IF
#                     LET l_auto =l_no
#                     UPDATE ooed_t SET ooed007 = g_ooeb_m.ooeb007 -1
#                      WHERE ooedent = g_enterprise
#                        AND ooed001 = g_ooeb_m.ooeb004
#                        AND ooed002 = g_ooeb_m.ooeb005
#                        AND ooed003 = l_ooed003
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "upd_ooed"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                        LET g_success = 'N'
#                        RETURN
#                     END IF     
#                     IF g_ooeb_m.ooeb008 IS NULL THEN
#                     LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                 " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                #   "   FROM ooed_tmp ",
#                                #   "  WHERE ooedent = '",g_enterprise,"' ",
#                                #   "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                #   "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                #   "    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                     ELSE
#                        LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                     " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                   #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                   #"   FROM ooed_tmp ",
#                                   #"  WHERE ooedent = '",g_enterprise,"' ",
#                                   #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                   #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                   #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                     END IF
#                     PREPARE ins_ooed_conf_pre_8 FROM g_sql
#                     EXECUTE ins_ooed_conf_pre_8
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "ins_ooed"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                        LET g_success = 'N'
#                        RETURN
#                     END IF
#                     SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                       FROM ooed_t
#                      WHERE ooedent = g_enterprise
#                        AND ooed001 = g_ooeb_m.ooeb004
#                        AND ooed002 = g_ooeb_m.ooeb005
#                     #如果不存在编号则是第一次编号
#                     IF cl_null(l_no) THEN
#                        LET l_no = 1
#                     END IF
#                     LET l_auto =l_no
#                     IF g_ooeb_m.ooeb008 <= l_ooed007 AND l_ooed007 IS NOT NULL THEN
#                        LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                    " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb008+1,"','",l_ooed007,"','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                   #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb008+1,"','",l_ooed007,"','",g_ooeb_m.ooeb001,"' ",
#                                   #"   FROM ooed_tmp ",
#                                   #"  WHERE ooedent = '",g_enterprise,"' ",
#                                   #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                   #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                   #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                        PREPARE ins_ooed_conf_pre_9 FROM g_sql
#                        EXECUTE ins_ooed_conf_pre_9
#                        IF SQLCA.sqlcode THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = SQLCA.sqlcode
#                           LET g_errparam.extend = "ins_ooed"
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#
#                           CALL s_transaction_end('N','0')
#                           LET g_success = 'N'
#                           RETURN
#                        END IF
#                     END IF
#                     IF l_ooed007 IS NULL THEN
#                        LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                    " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb008+1,"','','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                   #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb008+1,"','','",g_ooeb_m.ooeb001,"' ",
#                                   #"   FROM ooed_tmp ",
#                                   #"  WHERE ooedent = '",g_enterprise,"' ",
#                                   #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                   #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                   #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                        PREPARE ins_ooed_conf_pre_10 FROM g_sql
#                        EXECUTE ins_ooed_conf_pre_10
#                        IF SQLCA.sqlcode THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = SQLCA.sqlcode
#                           LET g_errparam.extend = "ins_ooed"
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#
#                           CALL s_transaction_end('N','0')
#                           LET g_success = 'N'
#                           RETURN
#                        END IF
#                     END IF
#                     EXIT FOREACH
#                  END IF
#                  IF g_ooeb_m.ooeb008 >= l_ooed007 AND l_ooed007 IS NOT NULL THEN
#                     SELECT MAX(to_number(ooed003)) +1 INTO l_no
#                       FROM ooed_t
#                      WHERE ooedent = g_enterprise
#                        AND ooed001 = g_ooeb_m.ooeb004
#                        AND ooed002 = g_ooeb_m.ooeb005
#                     #如果不存在编号则是第一次编号
#                     IF cl_null(l_no) THEN
#                        LET l_no = 1
#                     END IF
#                     LET l_auto =l_no
#                     UPDATE ooed_t SET ooed007 = g_ooeb_m.ooeb007 -1
#                      WHERE ooedent = g_enterprise
#                        AND ooed001 = g_ooeb_m.ooeb004
#                        AND ooed002 = g_ooeb_m.ooeb005
#                        AND ooed003 = l_ooed003
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "upd_ooed"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                        LET g_success = 'N'
#                        RETURN
#                     END IF     
#                     IF g_ooeb_m.ooeb008 IS NULL THEN
#                        LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                    " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                   #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"' ",
#                                   #"   FROM ooed_tmp ",
#                                   #"  WHERE ooedent = '",g_enterprise,"' ",
#                                   #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                   #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                   #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                     ELSE
#                        LET g_sql = " INSERT INTO ooed_t(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
#                                    " SELECT DISTINCT ooecent,ooec001,ooec002,'",l_auto,"',ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                    "   FROM ooec_t ",
#                                    "  WHERE ooecent = '",g_enterprise,"' ",
#                                    "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
#                                    "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
#                                    "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
#                                   #" SELECT DISTINCT ooedent,ooed001,ooed002,'",l_auto,"',ooed004,ooed005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"' ",
#                                   #"   FROM ooed_tmp ",
#                                   #"  WHERE ooedent = '",g_enterprise,"' ",
#                                   #"    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                   #"    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                   #"    AND ooed003 = '",g_ooeb_m.ooeb006,"' "
#                     END IF
#                     PREPARE ins_ooed_conf_pre_11 FROM g_sql
#                     EXECUTE ins_ooed_conf_pre_11
#                     IF SQLCA.sqlcode THEN
#                        INITIALIZE g_errparam TO NULL
#                        LET g_errparam.code = SQLCA.sqlcode
#                        LET g_errparam.extend = "ins_ooed"
#                        LET g_errparam.popup = TRUE
#                        CALL cl_err()
#
#                        CALL s_transaction_end('N','0')
#                        LET g_success = 'N'
#                        RETURN
#                     END IF
#                     LET l_sql1 = " SELECT DISTINCT ooed003,ooed006,ooed007 FROM ooed_t ",
#                                  "  WHERE ooedent = '",g_enterprise,"' ",
#                                  "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
#                                  "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
#                                  "    AND ooed006 > '",l_ooed006,"'",
#                                  "  ORDER BY ooed006,ooed007 "
#                     PREPARE aooi110_status_pb1 FROM l_sql1
#                     DECLARE aooi110_status_cs1 CURSOR FOR aooi110_status_pb1
#                     FOREACH aooi110_status_cs1 INTO l_ooed003_1,l_ooed006_1,l_ooed007_1
#                        IF SQLCA.sqlcode THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = SQLCA.sqlcode
#                           LET g_errparam.extend = "FOREACH"
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#
#                           CALL s_transaction_end('N','0')
#                           LET g_success = 'N'
#                           RETURN
#                        END IF  
#                        IF g_ooeb_m.ooeb007 <= l_ooed006_1 AND g_ooeb_m.ooeb008 >= l_ooed006_1 AND ((g_ooeb_m.ooeb008 <= l_ooed007_1 AND l_ooed007_1 IS NOT NULL) OR l_ooed007_1 IS NULL) THEN
#                           UPDATE ooed_t SET ooed006 = g_ooeb_m.ooeb008 + 1
#                            WHERE ooedent = g_enterprise
#                              AND ooed001 = g_ooeb_m.ooeb004
#                              AND ooed002 = g_ooeb_m.ooeb005
#                              AND ooed003 = l_ooed003_1
#                           IF SQLCA.sqlcode THEN
#                              INITIALIZE g_errparam TO NULL
#                              LET g_errparam.code = SQLCA.sqlcode
#                              LET g_errparam.extend = "upd_ooed"
#                              LET g_errparam.popup = TRUE
#                              CALL cl_err()
#
#                              CALL s_transaction_end('N','0')
#                              LET g_success = 'N'
#                              RETURN
#                           END IF                  
#                           EXIT FOREACH 
#                        END IF             
#                     END FOREACH                        
#                     EXIT FOREACH
#                 END IF    
#               END IF
#            END IF 
#         END FOREACH
#      END IF
#      IF g_ooeb_m.ooeb003 = '2' THEN
#         UPDATE ooed_t SET ooed003 = g_ooeb_m.ooeb006
#          WHERE ooedent = g_enterprise
#            AND ooed001 = g_ooeb_m.ooeb004
#            AND ooed002 = g_ooeb_m.ooeb005
#            AND ooed006 = g_ooeb_m.ooeb007
#            AND ooed007 = g_ooeb_m.ooeb008
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "upd_ooed"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            CALL s_transaction_end('N','0')
#            LET g_success = 'N'
#            RETURN
#         END IF    
#      END IF 
#   END IF
#   IF g_ooeb_m.ooeb003 = '3' THEN
#      DELETE FROM ooed_t 
#       WHERE ooedent = g_enterprise
#         AND ooed001 = g_ooeb_m.ooeb004
#         AND ooed002 = g_ooeb_m.ooeb005
#         AND ooed003 = g_ooeb_m.ooeb006
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "del_ooebstus"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         CALL s_transaction_end('N','0')
#         LET g_success = 'N'
#         RETURN
#      END IF
#   END IF
#   UPDATE ooeb_t 
#      SET ooebstus = 'Y'
#    WHERE ooebent = g_enterprise 
#      AND ooeb001 = g_ooeb_m.ooeb001
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = "upd_ooebstus"
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
#
#      CALL s_transaction_end('N','0')
#      LET g_success = 'N'
#      RETURN
#   END IF
#   
#   LET g_ooeb_m.ooebstus = 'Y' 
#   
#   #如果生效日期是當下（例如，當前日期是2014/08/01,生效日期也剛好是2014/08/01，則產生ooej檔，如果生效日期大於當下，則暫不產生）
#   IF g_ooeb_m.ooeb007 <= g_today AND g_ooeb_m.ooeb008 >= g_today THEN
#      #產生當前組織架構檔
#      IF NOT aooi110_produce() THEN
#         CALL s_transaction_end('N','0')
#         LET g_success = 'N'
#         RETURN
#      END IF
#   END IF
#   
#   IF g_success = 'Y' THEN
#      CALL s_transaction_end('Y','0')
#   ELSE
#      CALL s_transaction_end('N','0')
#   END IF
END FUNCTION
# 最上層組織編號檢查
PRIVATE FUNCTION aooi110_chk_ooeb005()
DEFINE l_n         LIKE type_t.num10
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   LET g_errno = ''
   IF NOT cl_null(g_ooeb_m.ooeb005) THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL

      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_ooeb_m.ooeb005
      CASE g_ooeb_m.ooeb004
         WHEN '1'  LET g_chkparam.where = " ooef203 = 'Y' "
         WHEN '4'  LET g_chkparam.where = " ooef205 = 'Y' " 
         WHEN '5'  LET g_chkparam.where = " ooef207 = 'Y' "
         WHEN '6'  LET g_chkparam.where = " ooef206 = 'Y' "
         WHEN '7'  LET g_chkparam.where = " ooef206 = 'Y' "
         WHEN '8'  LET g_chkparam.where = " ooef201 = 'Y' "
         WHEN '9'  LET g_chkparam.where = " ooef208 = 'Y' "
         WHEN '10' LET g_chkparam.where = " ooef210 = 'Y' "
         WHEN '11' LET g_chkparam.where = " ooef211 = 'Y' "
         WHEN '12' LET g_chkparam.where = " ooef212 = 'Y' "
      END CASE

      #160318-00025#45  2016/04/26  by pengxin  add(S)
      LET g_errshow = TRUE #是否開窗 
      LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
      #160318-00025#45  2016/04/26  by pengxin  add(E)
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooef001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   IF NOT cl_null(g_ooeb_m.ooeb004) AND NOT cl_null(g_ooeb_m.ooeb005) AND NOT cl_null(g_ooeb_m.ooeb006)  
      AND (g_ooeb_m.ooeb004 <> g_ooeb_m_t.ooeb004 OR g_ooeb_m.ooeb005 <> g_ooeb_m_t.ooeb005 OR g_ooeb_m.ooeb006 <> g_ooeb_m_t.ooeb006) THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM ooeb_t
       WHERE ooebent = g_enterprise
         AND ooeb004 = g_ooeb_m.ooeb004
         AND ooeb005 = g_ooeb_m.ooeb005
         AND ooeb006 = g_ooeb_m.ooeb006
         AND ooebstus = 'Y'
      IF l_n > 0 THEN           
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00121'
         LET g_errparam.extend = g_ooeb_m.ooeb005
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success   
      END IF
   END IF
   RETURN r_success  
   
END FUNCTION
# 單身資料準備按鈕
PRIVATE FUNCTION aooi110_ins_tmp()
DEFINE l_sql     STRING
   
  
   IF cl_null(g_wcb) THEN
      RETURN
   END IF
   
   IF cl_null(g_ooeb_m.ooeb008) THEN
      #LET l_sql = " MERGE INTO ooed_tmp ",
      #            " USING (SELECT ooef001 ",
      #            "          FROM ooef_t ",
      #            "         WHERE ",g_wcb CLIPPED ,")",
      #            "    ON (ooef001 = ooed004 OR ooef001 = ooed005 OR ooef001 = ooed002 )",
      #            "  WHEN NOT MATCHED THEN ",
      #            " INSERT (ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
      #            " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
      #            "        ooef001,'",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"') "
      
      #LET l_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
      #            " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
      #            "        '",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"') "
      
   ELSE
      #LET l_sql = " MERGE INTO ooed_tmp ",
      #            " USING (SELECT ooef001 ",
      #            "          FROM ooef_t ",
      #            "         WHERE ",g_wcb CLIPPED ,")",
      #            "    ON (ooef001 = ooed004 OR ooef001 = ooed005 OR ooef001 = ooed002 )",
      #            "  WHEN NOT MATCHED THEN ",
      #            " INSERT (ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
      #            " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
      #            "        ooef001,'",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"') "
      
      #LET l_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
      #            " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
      #            "        '",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"') "
      #
       
   END IF
   PREPARE ins_ooed_tmp_pre FROM l_sql
   EXECUTE ins_ooed_tmp_pre
   
   
END FUNCTION
# 新增自動帶出版本號
PRIVATE FUNCTION aooi110_def_ooeb006()
DEFINE l_n            LIKE type_t.num10

   IF g_ooeb_m.ooeb003 = '1' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND NOT cl_null(g_ooeb_m.ooeb005) 
         AND (g_ooeb_m.ooeb004 <> g_ooeb_m_t.ooeb004 OR g_ooeb_m.ooeb005 <> g_ooeb_m_t.ooeb005 OR cl_null(g_ooeb_m_t.ooeb004) OR cl_null(g_ooeb_m_t.ooeb004) ) THEN  
         LET l_n = 0
         SELECT MAX(to_number(ooeb006)) + 1 INTO l_n
           FROM ooeb_t
          WHERE ooebent = g_enterprise
            AND ooeb004 = g_ooeb_m.ooeb004
            AND ooeb005 = g_ooeb_m.ooeb005
        IF cl_null(l_n) OR l_n = 0 THEN
           LET l_n = 1
        END IF
        LET g_ooeb_m.ooeb006 = l_n
        DISPLAY BY NAME g_ooeb_m.ooeb006    
      END IF
   END IF
END FUNCTION
# 單頭最上層組織名稱顯示
PRIVATE FUNCTION aooi110_ooec005_desc()
  SELECT ooefl003 INTO g_ooeb_m.ooeb005_desc
    FROM ooefl_t
   WHERE ooefl001 = g_ooeb_m.ooeb005
     AND ooefl002 = g_dlang
     AND ooeflent = g_enterprise
   DISPLAY BY NAME g_ooeb_m.ooeb005_desc
END FUNCTION
# 临时表填充树资料
PRIVATE FUNCTION aooi110_tree_tmp_fill()
DEFINE l_n        LIKE type_t.num5
DEFINE l_pid      LIKE type_t.chr50   #用於樹的第一層
DEFINE ls_msg     STRING
DEFINE l_n2       LIKE type_t.num5
   
   IF NOT cl_null(g_ooeb_m.ooeb008) THEN
      LET g_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
                  " SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"',ooec008  ",
                  "   FROM ooec_t ",
                  "  WHERE ooecent = '",g_enterprise,"' ",
                  "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooec003 = '",g_ooeb_m.ooeb006,"' "
   ELSE
      LET g_sql = " INSERT INTO ooed_tmp(ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008) ",
                  " SELECT ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,'",g_ooeb_m.ooeb007,"','',ooec008  ",
                  "   FROM ooec_t ",
                  "  WHERE ooecent = '",g_enterprise,"' ",
                  "    AND ooec001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooec002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooec003 = '",g_ooeb_m.ooeb006,"' ",
                  "    AND ooec008 = '",g_ooeb_m.ooeb001,"' "
   END IF
   PREPARE aooi110_ins_ooed_tmp_pre4 FROM g_sql
   EXECUTE aooi110_ins_ooed_tmp_pre4
   CALL g_tree.clear()
   LET g_cnt = 1
   LET l_n = 1
   LET g_sql = " SELECT UNIQUE ooed005,ooed003 FROM ooed_tmp ",
               "  WHERE ooedent = '" ||g_enterprise|| "' ",
               "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
               "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
               "    AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
               "    AND ooed005 = ooed002 ",
               "  ORDER BY ooed005 "
   PREPARE tree_pre FROM g_sql
   DECLARE tree_cur CURSOR FOR tree_pre
   FOREACH tree_cur INTO g_tree[g_cnt].b_ooed005,g_tree[g_cnt].b_ooed003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET g_tree[g_cnt].b_ooed004 = g_tree[g_cnt].b_ooed005
      LET g_tree[g_cnt].b_ooed002 = g_tree[g_cnt].b_ooed005
      LET g_tree[g_cnt].b_pid = '0' CLIPPED
      LET g_tree[g_cnt].b_id = g_cnt USING "<<<"
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_tree[g_cnt].b_ooed004
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_tree[g_cnt].b_ooed004_desc = g_rtn_fields[1]
       LET ls_msg = cl_getmsg("aoo-00232",g_dlang)
      LET g_tree[g_cnt].b_show =  g_tree[g_cnt].b_ooed005,' (',g_tree[g_cnt].b_ooed004_desc,')','(',ls_msg,g_tree[g_cnt].b_ooed003,')'
      LET g_tree[g_cnt].b_exp = TRUE
      LET g_tree[g_cnt].b_hasC = TRUE
      LET g_tree[g_cnt].b_isExp = TRUE
      LET l_pid = g_tree[g_cnt].b_id CLIPPED
      LET l_n = g_cnt
      LET g_cnt = g_cnt + 1
      LET g_sql = " SELECT UNIQUE ooed004 FROM ooed_tmp ",
                  "  WHERE ooedent = '" ||g_enterprise|| "' ",
                  "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
                  "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
                  "    AND ooed003 = '",g_ooeb_m.ooeb006,"' ",
                  "    AND ooed005 = '",g_tree[l_n].b_ooed005,"' ",
                  "    AND ooed004 <> ooed005 ",
                  "  ORDER BY ooed004 "
      PREPARE tree_pre1 FROM g_sql
      DECLARE tree_cur1 CURSOR FOR tree_pre1
      FOREACH tree_cur1 INTO g_tree[g_cnt].b_ooed004
         LET g_tree[g_cnt].b_ooed002 = g_tree[l_n].b_ooed002
         LET g_tree[g_cnt].b_ooed005 = g_tree[l_n].b_ooed004
         LET g_tree[g_cnt].b_pid = l_pid
         LET g_tree[g_cnt].b_id = l_pid,".",g_cnt USING "<<<"
         LET g_ref_fields[1] = g_tree[g_cnt].b_ooed004
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_tree[g_cnt].b_ooed004_desc = g_rtn_fields[1]
         LET g_tree[g_cnt].b_show =  g_tree[g_cnt].b_ooed004,' (',g_tree[g_cnt].b_ooed004_desc,')'
         LET g_tree[g_cnt].b_exp = TRUE
         LET g_tree[g_cnt].b_hasC = aooi110_chk_hasC(g_cnt)
         IF g_tree[g_cnt].b_hasC = 1 THEN
            CALL aooi110_tree_expand(g_cnt)
            LET g_cnt = g_tree.getLength()
         END IF
         LET g_cnt = g_cnt +1
      END FOREACH
      LET l_n = g_tree.getLength() 
   END FOREACH
   CALL g_tree.deleteElement(l_n)
   FREE tree_pre1
   FREE tree_pre
   FOR l_n2 = 1 TO g_tree.getLength()
      IF g_tree[l_n2].b_isExp is null THEN
         CALL aooi110_tree_expand(l_n2)
      END IF
   END FOR
END FUNCTION
#輸入版本之後帶出樹+生失效日期
PRIVATE FUNCTION aooi110_out_tree()
   IF g_ooeb_m.ooeb003 = '2' OR g_ooeb_m.ooeb003 = '3' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND  NOT cl_null(g_ooeb_m.ooeb005) AND NOT cl_null(g_ooeb_m.ooeb006) THEN
         SELECT DISTINCT ooed006,ooed007 INTO g_ooeb_m.ooeb007,g_ooeb_m.ooeb008
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
         IF cl_null(g_ooeb_m.ooeb008) THEN
            LET g_ooeb_m.ooeb008 = ""
         END IF
         LET g_sql = " INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008) ",
                     " SELECT ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,'",g_ooeb_m.ooeb001,"' ",
                     "   FROM ooed_t ",
                     "  WHERE ooedent = '",g_enterprise,"' ",
                     "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
                     "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
                     "    AND ooed003 = '",g_ooeb_m.ooeb006,"'"
         PREPARE aooi110_ins_ooed_tmp_pre6 FROM g_sql
         EXECUTE aooi110_ins_ooed_tmp_pre6
         CALL aooi110_tree_fill()
         DISPLAY ARRAY g_tree TO s_tree.*
             BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
      END IF
      CALL aooi110_set_entry('a')
      CALL aooi110_set_no_entry('a')      
   END IF
END FUNCTION
#更改狀態版本檢查
PRIVATE FUNCTION aooi110_chk_ooeb006()
DEFINE l_n       LIKE type_t.num5

   LET l_n = 0
   LET g_errno = ''
   IF g_ooeb_m.ooeb003 = '2' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND  NOT cl_null(g_ooeb_m.ooeb005) AND NOT cl_null(g_ooeb_m.ooeb006)THEN
         SELECT COUNT(*) INTO l_n
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
         IF l_n = 0 THEN
            LET g_errno = 'aoo-00093'
            RETURN
         END IF
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
            AND ooed007 < g_today
         IF l_n > 0 THEN
            LET g_errno = 'aoo-00276'
            RETURN
         END IF
      END IF
   END IF
   IF g_ooeb_m.ooeb003 = '3' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND  NOT cl_null(g_ooeb_m.ooeb005) AND NOT cl_null(g_ooeb_m.ooeb006)THEN
         SELECT COUNT(*) INTO l_n
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
         IF l_n = 0 THEN
            LET g_errno = 'aoo-00093'
            RETURN
         END IF
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
            AND ooed003 = g_ooeb_m.ooeb006
            AND ooed006 > g_today
         IF l_n = 0 THEN
            LET g_errno = 'aoo-00276'
            RETURN
         END IF
      END IF
   END IF
END FUNCTION
#刷新樹
PRIVATE FUNCTION aooi110_tree_tmp_fill1()
DEFINE l_n        LIKE type_t.num5
DEFINE l_ooed003  LIKE ooed_t.ooed003

   LET l_n = 0
   LET l_ooed003 = 0
   DELETE FROM ooed_tmp
   IF g_ooeb_m.ooeb003 = '1' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND NOT cl_null(g_ooeb_m.ooeb005) THEN
         SELECT MAX(ooed003) INTO l_ooed003
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = g_ooeb_m.ooeb004
            AND ooed002 = g_ooeb_m.ooeb005
         IF l_ooed003 > 0 THEN
            LET g_sql = " INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008) ",
                        " SELECT ooedent,ooed001,ooed002,'",g_ooeb_m.ooeb006,"',ooed004,ooed005,ooed006,ooed007,'",g_ooeb_m.ooeb001,"'  ",
                        "   FROM ooed_t ",
                        "  WHERE ooedent = '",g_enterprise,"' ",
                        "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
                        "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
                        "    AND ooed003 = '",l_ooed003,"'"
            PREPARE aooi110_ins_ooed_tmp_pre5 FROM g_sql
            EXECUTE aooi110_ins_ooed_tmp_pre5
         ELSE
            IF NOT cl_null(g_ooeb_m.ooeb008) THEN
               INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008)
                             VALUES(g_enterprise,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb005,g_ooeb_m.ooeb005,g_ooeb_m.ooeb007,g_ooeb_m.ooeb008,g_ooeb_m.ooeb001)
            ELSE
                INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008)
                             VALUES(g_enterprise,g_ooeb_m.ooeb004,g_ooeb_m.ooeb005,g_ooeb_m.ooeb006,g_ooeb_m.ooeb005,g_ooeb_m.ooeb005,g_ooeb_m.ooeb007,'',g_ooeb_m.ooeb001)  
            END IF
         END IF
         CALL aooi110_tree_tmp_fill()
         DISPLAY ARRAY g_tree TO s_tree.*
             BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
      END IF
   END IF
END FUNCTION
################################################################################
# Descriptions...: 检查结存档是否已经存在资料
# Memo...........:
# Usage..........: CALL aooi110_chk_conf()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success 狀態
# Date & Author..: 2014/1/7 By xumm
# Modify.........: 已使用元件 zhujing mark #160203-00004#1
################################################################################
PRIVATE FUNCTION aooi110_chk_conf()
#DEFINE r_success      LIKE type_t.num5
#DEFINE l_n            LIKE type_t.num5
#DEFINE l_n2            LIKE type_t.num5
#
#   LET r_success = TRUE
#   IF g_ooeb_m.ooeb003 = '1' THEN
#      IF cl_null(g_ooeb_m.ooeb008) THEN
#         FOR l_n2 = 1 TO g_tree.getLength()
#             LET l_n = 0
#             SELECT COUNT(*) INTO l_n
#               FROM ooed_t
#              WHERE ooedent = g_enterprise
#                AND ooed001 = g_ooeb_m.ooeb004
#                AND ooed002 <> g_ooeb_m.ooeb005
#                AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb007)
#                AND ooed004 = g_tree[l_n2].b_id
#             IF l_n > 0 THEN
#                LET r_success = FALSE
#                EXIT FOR
#             END IF
#         END FOR
##         SELECT COUNT(*) INTO l_n
##           FROM ooed_tmp
##          WHERE ooedent = g_enterprise
##            AND ooed001 = g_ooeb_m.ooeb004
##            AND ooed002 = g_ooeb_m.ooeb005
##            AND ooed004 IN (SELECT ooed004 
##                              FROM ooed_t
##                             WHERE ooedent = g_enterprise
##                               AND ooed001 = g_ooeb_m.ooeb004
##                               AND ooed002 <> g_ooeb_m.ooeb005
##                               AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb007)
##                             )             
#      ELSE
#         FOR l_n2 = 1 TO g_tree.getLength()
#             LET l_n = 0
#             SELECT COUNT(*) INTO l_n
#               FROM ooed_t
#              WHERE ooedent = g_enterprise
#                AND ooed001 = g_ooeb_m.ooeb004
#                AND ooed002 <> g_ooeb_m.ooeb005
#                AND (ooed006 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
#                     OR ooed007 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
#                     OR (ooed006 <= g_ooeb_m.ooeb007 AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb008)))
#                AND ooed004 = g_tree[l_n2].b_id
#             IF l_n > 0 THEN
#                LET r_success = FALSE
#                EXIT FOR
#             END IF
#         END FOR
##         SELECT COUNT(*) INTO l_n
##           FROM ooed_tmp
##          WHERE ooedent = g_enterprise
##            AND ooed001 = g_ooeb_m.ooeb004
##            AND ooed002 = g_ooeb_m.ooeb005
##            AND ooed004 IN (SELECT ooed004 
##                              FROM ooed_t
##                             WHERE ooedent = g_enterprise
##                               AND ooed001 = g_ooeb_m.ooeb004
##                               AND ooed002 <> g_ooeb_m.ooeb005
##                               AND (ooed006 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
##                                    OR ooed007 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
##                                    OR (ooed006 <= g_ooeb_m.ooeb007 AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb008)))
##                             )
##           AND ooed008 = g_ooeb_m.ooeb001  
#      END IF
#      IF l_n > 0 THEN
#         LET r_success = FALSE
#      END IF
#   END IF
#   IF g_ooeb_m.ooeb003 = '2' THEN
#      IF cl_null(g_ooeb_m.ooeb008) THEN
#         FOR l_n2 = 1 TO g_tree.getLength()
#             LET l_n = 0
#             SELECT COUNT(*) INTO l_n
#               FROM ooed_t
#              WHERE ooedent = g_enterprise
#                AND ooed001 = g_ooeb_m.ooeb004
#                AND ooed002 <> g_ooeb_m.ooeb005
#                AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb007)
#                AND ooed004 = g_tree[l_n2].b_id
#             IF l_n > 0 THEN
#                LET r_success = FALSE
#                EXIT FOR
#             END IF
#         END FOR                    
#      ELSE
#         FOR l_n2 = 1 TO g_tree.getLength()
#             LET l_n = 0
#             SELECT COUNT(*) INTO l_n
#               FROM ooed_t
#              WHERE ooedent = g_enterprise
#                AND ooed001 = g_ooeb_m.ooeb004
#                AND ooed002 <> g_ooeb_m.ooeb005
#                AND (ooed006 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
#                     OR ooed007 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
#                     OR (ooed006 <= g_ooeb_m.ooeb007 AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb008)))
#                AND ooed004 = g_tree[l_n2].b_id
#             IF l_n > 0 THEN
#                LET r_success = FALSE
#                EXIT FOR
#             END IF
#         END FOR
##         SELECT COUNT(*) INTO l_n
##           FROM ooed_tmp
##          WHERE ooedent = g_enterprise
##            AND ooed001 = g_ooeb_m.ooeb004
##            AND ooed002 = g_ooeb_m.ooeb005
##            AND ooed004 IN (SELECT ooed004 
##                              FROM ooed_t
##                             WHERE ooedent = g_enterprise
##                               AND ooed001 = g_ooeb_m.ooeb004
##                               AND ooed002 = g_ooeb_m.ooeb005
##                               AND ooed003 <> g_ooeb_m.ooeb006
##                               AND (ooed006 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
##                                    OR ooed007 BETWEEN g_ooeb_m.ooeb007 AND g_ooeb_m.ooeb008
##                                    OR (ooed006 <= g_ooeb_m.ooeb007 AND (ooed007 IS NULL OR ooed007 >= g_ooeb_m.ooeb008)))
##                             )
##           AND ooed008 <> g_ooeb_m.ooeb001  
#      END IF
#   END IF
#   RETURN r_success
END FUNCTION

#依單頭選定的組織職能QBE篩選出組織基本資料檔的組織節點,顯示於本單身中以備拖拉組織樹
PRIVATE FUNCTION aooi110_ooef_fill()
 
    CALL g_ooef_d.clear()
    
    IF g_flag2 = FALSE THEN
       RETURN
    END IF
    
    IF cl_null(g_wc_table2) THEN
       LET g_wc_table2 =  " 1=1"
    END IF
    
    LET g_sql = " SELECT 'N',ooef001,t1.ooefl003,ooef017,t2.ooefl003 FROM ooef_t ",
                " LEFT JOIN ooefl_t t1 ON t1.ooeflent = ooefent AND t1.ooefl001 = ooef001 AND t1.ooefl002 = '"||g_dlang||"' ",
                " LEFT JOIN ooefl_t t2 ON t2.ooeflent = ooefent AND t2.ooefl001 = ooef017 AND t2.ooefl002 = '"||g_dlang||"' ",
                " WHERE ooefent = '",g_enterprise,"' AND ooefstus = 'Y' AND ",g_wc_table2 CLIPPED,
                "  AND ooef001 <> '",g_ooeb_m.ooeb005,"' "

    #组织树维护作业aooi110中，组织树类型财务组需要用到的为：
    #                          .账务中心组织（树中的节点是所有组织即可）
    #                          .预算中心组织（树中的节点是只有预算组织打勾的才可以选）
    #                          .资产中心组织（树中的节点是只有资产组织打勾的才可以选）
    #                          .资金中心组织（树中的节点是只有资金组织打勾的才可以选）
    #                          .资金计划组织（树中的节点是只有资金组织打勾的才可以选）
    CASE g_ooeb_m.ooeb004
       WHEN '1'  LET g_sql = g_sql , " AND ooef203 = 'Y' " 
       WHEN '4'  LET g_sql = g_sql , " AND ooef205 = 'Y' " 
       WHEN '5'  LET g_sql = g_sql , " AND ooef207 = 'Y' "
       WHEN '6'  LET g_sql = g_sql , " AND ooef206 = 'Y' "
       WHEN '7'  LET g_sql = g_sql , " AND ooef206 = 'Y' "
       WHEN '8'  LET g_sql = g_sql , " AND ooef201 = 'Y' "
       WHEN '9'  LET g_sql = g_sql , " AND ooef208 = 'Y' "
       WHEN '10' LET g_sql = g_sql , " AND ooef210 = 'Y' "
       WHEN '11' LET g_sql = g_sql , " AND ooef211 = 'Y' "
       WHEN '12' LET g_sql = g_sql , " AND ooef212 = 'Y' "
    END CASE
    
    #子階與父階關係為一對一,但財務的五個中心除外(帳務中心/預算中心/資金結算中心/資金計劃中心/資產中心)
    #   其同一子階可存在多個父階之下,為一對多觀念
    #IF g_ooeb_m.ooeb004 MATCHES '[128]' THEN
    #營運據點也可以一對多
    IF g_ooeb_m.ooeb004 MATCHES '[129]' OR g_ooeb_m.ooeb004 = '10' OR g_ooeb_m.ooeb004 = '11' OR g_ooeb_m.ooeb004 ='12' THEN
       LET g_sql = g_sql , " AND ooef001 NOT IN (SELECT ooec004 FROM ooec_t WHERE ooecent = '",g_enterprise,"' AND ooec008 = '",g_ooeb_m.ooeb001,"' ) ",
                           " AND ooef001 NOT IN (SELECT ooec005 FROM ooec_t WHERE ooecent = '",g_enterprise,"' AND ooec008 = '",g_ooeb_m.ooeb001,"' ) "
    END IF
    
    LET g_sql = g_sql , " ORDER BY ooef001 "
    
    PREPARE aooi110_pb2 FROM g_sql
    DECLARE b_fill_cs2 CURSOR FOR aooi110_pb2
    
    LET g_cnt = l_ac
    LET l_ac = 1
    
    FOREACH b_fill_cs2 INTO g_ooef_d[l_ac].check,g_ooef_d[l_ac].ooef001,g_ooef_d[l_ac].ooef001_desc,g_ooef_d[l_ac].ooef017,g_ooef_d[l_ac].ooef017_desc
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "FOREACH:"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          EXIT FOREACH
       END IF
    
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
    
    CALL g_ooef_d.deleteElement(g_ooef_d.getLength())
    
    LET g_rec_b2 = l_ac - 1
    LET l_ac = g_cnt
    LET g_cnt = 0
    
    FREE aooi110_pb2

    #LET g_flag2 = FALSE
    
END FUNCTION

# 創建臨時表
PRIVATE FUNCTION aooi110_crt_tmp()

   DROP TABLE ooed_tmp

   CREATE TEMP TABLE ooed_tmp
   (
       ooedent       INT,
       ooed001       VARCHAR(10),
       ooed002       VARCHAR(10),
       ooed003       VARCHAR(10),
       ooed004       VARCHAR(10),
       ooed005       VARCHAR(10),
       ooed006       DATE,
       ooed007       DATE,
       ooed008       VARCHAR(10)
   );
END FUNCTION

#樹初始化，重新生成根節點
PRIVATE FUNCTION aooi110_ins_ooec()
DEFINE l_sql     STRING

   
   IF cl_null(g_ooeb_m.ooeb008) THEN
      LET l_sql = " INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008) ",
                  " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
                  "        '",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','','",g_ooeb_m.ooeb001,"') "
   ELSE
      LET l_sql = " INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008) ",
                  " VALUES ('",g_enterprise,"','",g_ooeb_m.ooeb004,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb006,"',",
                  "        '",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb005,"','",g_ooeb_m.ooeb007,"','",g_ooeb_m.ooeb008,"','",g_ooeb_m.ooeb001,"') "
   END IF
   PREPARE ins_ooec_pre FROM l_sql
   EXECUTE ins_ooec_pre
   
   CALL aooi110_tree_tmp_fill()
   DISPLAY ARRAY g_tree TO s_tree.*
       BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   
   
END FUNCTION

#刷新樹
PRIVATE FUNCTION aooi110_tree_refresh()
     
     CALL aooi110_tree_fill()
     
     DISPLAY ARRAY g_tree TO s_tree.*
         BEFORE DISPLAY
           EXIT DISPLAY
     END DISPLAY
     
END FUNCTION

#產生當前組織結構檔
PRIVATE FUNCTION aooi110_produce()
#DEFINE l_ooej    RECORD LIKE ooej_t.*  #161124-00048#7  2016/12/12 By 08734 mark
#161124-00048#7  2016/12/12 By 08734 add(S)
DEFINE l_ooej RECORD  #目前組織結構檔
       ooejent LIKE ooej_t.ooejent, #企业编号
       ooej001 LIKE ooej_t.ooej001, #组织类型
       ooej002 LIKE ooej_t.ooej002, #最上层组织
       ooej003 LIKE ooej_t.ooej003, #版本
       ooej004 LIKE ooej_t.ooej004, #组织编号
       ooej005 LIKE ooej_t.ooej005, #上级组织编号
       ooej006 LIKE ooej_t.ooej006, #生效日期
       ooej007 LIKE ooej_t.ooej007 #失效日期
END RECORD
#161124-00048#7  2016/12/12 By 08734 add(E)
#DEFINE l_ooed    RECORD LIKE ooed_t.*  #161124-00048#7  2016/12/12 By 08734 mark  
#161124-00048#7  2016/12/12 By 08734 add(S)
DEFINE l_ooed RECORD  #組織結構調整計劃結存檔
       ooedent LIKE ooed_t.ooedent, #企业编号
       ooed001 LIKE ooed_t.ooed001, #组织类型
       ooed002 LIKE ooed_t.ooed002, #最上层组织
       ooed003 LIKE ooed_t.ooed003, #版本
       ooed004 LIKE ooed_t.ooed004, #组织编号
       ooed005 LIKE ooed_t.ooed005, #上级组织编号
       ooed006 LIKE ooed_t.ooed006, #生效日期
       ooed007 LIKE ooed_t.ooed007, #失效日期
       ooed008 LIKE ooed_t.ooed008 #申请编号
END RECORD
#161124-00048#7  2016/12/12 By 08734 add(E)
DEFINE r_success LIKE type_t.num5

    LET r_success = TRUE
    
    IF g_ooeb_m.ooeb001 IS NULL THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "std-00003"
       LET g_errparam.extend = ""
       LET g_errparam.popup = FALSE
       CALL cl_err()

       LET r_success = FALSE
       RETURN r_success
    END IF
    
    IF g_ooeb_m.ooebstus <> 'Y' THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "sub-00475"
       LET g_errparam.extend = ""
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET r_success = FALSE
       RETURN r_success
    END IF
    
    #生效日期不是今天，是否確認產生組織結構檔？
    IF g_ooeb_m.ooeb007 > g_today THEN
       IF NOT cl_ask_confirm('aoo-00367') THEN
          LET g_flag3 = TRUE
          RETURN r_success
      END IF
    END IF
    
    #失效日期已小於今天，是否確認產生組織結構檔？
    IF g_ooeb_m.ooeb008 < g_today THEN
       IF NOT cl_ask_confirm('aoo-00368') THEN
          LET g_flag3 = TRUE
          RETURN r_success
      END IF
    END IF
    
    INITIALIZE l_ooej.* TO NULL
    INITIALIZE l_ooed.* TO NULL
    
    #DELETE FROM ooej_t WHERE ooejent = g_enterprise AND ooej008 = g_ooeb_m.ooeb001
    DELETE FROM ooej_t WHERE ooejent = g_enterprise AND ooej001 = g_ooeb_m.ooeb004
                         AND ooej002 = g_ooeb_m.ooeb005 
                        #AND ooej003 = g_ooeb_m.ooeb006
                         
    DECLARE ooej_cs CURSOR FOR 
       #SELECT * FROM ooed_t WHERE ooedent = g_enterprise AND ooed008 = g_ooeb_m.ooeb001  #161124-00048#7  2016/12/12 By 08734 mark
       SELECT ooedent,ooed001,ooed002,ooed003,ooed004,ooed005,ooed006,ooed007,ooed008 
          FROM ooed_t WHERE ooedent = g_enterprise AND ooed008 = g_ooeb_m.ooeb001  #161124-00048#7  2016/12/12 By 08734 add
       
    FOREACH ooej_cs INTO l_ooed.*
    
       INSERT INTO ooej_t(ooejent,ooej001,ooej002,ooej003,ooej004,ooej005,ooej006,ooej007)
           VALUES(l_ooed.ooedent,l_ooed.ooed001,l_ooed.ooed002,l_ooed.ooed003,l_ooed.ooed004,l_ooed.ooed005,l_ooed.ooed006,l_ooed.ooed007)
       
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'ooej_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       
       INITIALIZE l_ooej.* TO NULL
       INITIALIZE l_ooed.* TO NULL
       
    END FOREACH
    
    RETURN r_success

END FUNCTION

#判斷當前的節點 是否存在子節點，若存在子節點，則把下面的子節點也全部移除
PRIVATE FUNCTION aooi110_del_child(p_ooec005)
DEFINE p_ooec005     LIKE ooec_t.ooec005
DEFINE l_i           LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_arr     DYNAMIC ARRAY OF RECORD
            ooec004  LIKE ooec_t.ooec004
                 END RECORD
                     
   LET r_success = TRUE
   
   LET l_n = 1
   
   LET l_sql = "SELECT ooec004 FROM ooec_t ",
               " WHERE ooecent = '" ||g_enterprise|| "'",
               "   AND ooec008 = '",g_ooeb_m.ooeb001,"' ",
               "   AND ooec004 <> ooec005 ",
               "   AND ooec005 = '",p_ooec005,"' "
               
   PREPARE aooi110_del_ooec_pr FROM l_sql
   DECLARE aooi110_del_ooec_cs CURSOR FOR aooi110_del_ooec_pr
   
   FOREACH aooi110_del_ooec_cs INTO l_arr[l_n].ooec004
   
      DELETE FROM ooec_t
       WHERE ooecent = g_enterprise
         AND ooec001 = g_ooeb_m.ooeb004
         AND ooec002 = g_ooeb_m.ooeb005
         AND ooec003 = g_ooeb_m.ooeb006
         AND ooec004 = l_arr[l_n].ooec004
         AND ooec005 = p_ooec005
         AND ooec008 = g_ooeb_m.ooeb001
         
      IF SQLCA.SQLcode  THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooec_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         RETURN r_success
      END IF
      
      LET l_n = l_n + 1 
   END FOREACH

   CALL l_arr.deleteElement(l_arr.getLength())
   
   FOR l_i = 1 TO l_arr.getLength()
   
     IF NOT aooi110_del_child(l_arr[l_i].ooec004) THEN
        LET r_success = FALSE
        RETURN r_success
     END IF
     
   END FOR
   
   RETURN r_success
   
END FUNCTION

PRIVATE FUNCTION aooi110_set_act_visible()

   CALL cl_set_act_visible("modify,delete,produce,ins_aooi100,upd_aooi100,del_aooi100", TRUE)

END FUNCTION

PRIVATE FUNCTION aooi110_set_act_no_visible()
   
   #CALL cl_set_act_visible("reproduce",FALSE)  #160922-00021#1
   
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,delete", FALSE)
   END IF
   IF g_ooeb_m.ooebstus <> "N" THEN
      CALL cl_set_act_visible("modify,delete",FALSE)
   END IF
   
   IF g_ooeb_m.ooebstus <> "Y" THEN
      CALL cl_set_act_visible("produce",FALSE)
   END IF

   IF g_rec_b2 <= 0 OR cl_null(g_rec_b2) THEN
      CALL cl_set_act_visible("upd_aooi100,del_aooi100", FALSE)
   END IF
   
END FUNCTION

#變更類型為新增時，若選擇依上一版本带出预设值，则将当前最上层组织的上一版本的组织树预设带出
PRIVATE FUNCTION aooi110_out_tree1()
DEFINE l_ooeb006   LIKE ooeb_t.ooeb006

   IF g_ooeb_m.ooeb003 = '1' THEN
      IF NOT cl_null(g_ooeb_m.ooeb004) AND  NOT cl_null(g_ooeb_m.ooeb005) AND  NOT cl_null(g_ooeb_m.ooeb006) THEN
         
         SELECT MAX(ooed003) INTO l_ooeb006 FROM ooed_t
            WHERE ooedent = g_enterprise AND ooed001 = g_ooeb_m.ooeb004 AND ooed002 = g_ooeb_m.ooeb005
         IF l_ooeb006 > 0 THEN
            DELETE FROM ooec_t WHERE ooecent = g_enterprise AND ooec008 = g_ooeb_m.ooeb001
         
            SELECT DISTINCT ooed006,ooed007 INTO g_ooeb_m.ooeb007,g_ooeb_m.ooeb008
              FROM ooed_t
             WHERE ooedent = g_enterprise
               AND ooed001 = g_ooeb_m.ooeb004
               AND ooed002 = g_ooeb_m.ooeb005
               AND ooed003 = l_ooeb006
               
            #160224-00003#1---add---begin---
            IF NOT cl_null(g_ooeb_m.ooeb008) THEN
               LET g_ooeb_m.ooeb007 = g_ooeb_m.ooeb008 + 1
               LET g_ooeb_m.ooeb008 = ""
            END IF
            #160224-00003#1 --add---end-----
            
            IF cl_null(g_ooeb_m.ooeb008) THEN
               LET g_ooeb_m.ooeb008 = ""
            END IF
            LET g_sql = " INSERT INTO ooec_t(ooecent,ooec001,ooec002,ooec003,ooec004,ooec005,ooec006,ooec007,ooec008) ",
                        " SELECT ooedent,ooed001,ooed002,'",g_ooeb_m.ooeb006,"',ooed004,ooed005,ooed006,ooed007,'",g_ooeb_m.ooeb001,"' ",
                        "   FROM ooed_t ",
                        "  WHERE ooedent = '",g_enterprise,"' ",
                        "    AND ooed001 = '",g_ooeb_m.ooeb004,"' ",
                        "    AND ooed002 = '",g_ooeb_m.ooeb005,"' ",
                        "    AND ooed003 = '",l_ooeb006,"'"
            PREPARE aooi110_ins_ooed_tmp_pre7 FROM g_sql
            EXECUTE aooi110_ins_ooed_tmp_pre7
            CALL aooi110_tree_fill()
            DISPLAY ARRAY g_tree TO s_tree.*
                BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
          END IF
          
          CALL aooi110_set_entry('u')
          CALL aooi110_set_no_entry('u')  
      
      END IF
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
