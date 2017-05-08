#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq505.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000028
#+ 
#+ Filename...: axcq505
#+ Description: 庫存料件成本要素成本查詢作業
#+ Creator....: 03297(2014/08/29)
#+ Modifier...: 03297(2014/08/29) -SD/PR- 01996
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq505.global" >}
#160802-00020#7   2016/10/11 By shiun       增加帳套權限管控、法人權限管控
#161108-00012#4   2016/11/09 By 08734       g_browser_cnt 由num5改為num10
#160921-00010#1   2017/01/20 By xujing      切换据点自动预设画面栏位
 
IMPORT os
IMPORT util
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xcdc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xcau003 LIKE xcau_t.xcau003, 
   xcdc009 LIKE xcdc_t.xcdc009, 
   xcdc009_desc LIKE type_t.chr500, 
   xcdc101 LIKE xcdc_t.xcdc101, 
   xcdc201 LIKE xcdc_t.xcdc201, 
   xcdc207 LIKE xcdc_t.xcdc207, 
   xcdc901 LIKE xcdc_t.xcdc901, 
   xcdc102 LIKE xcdc_t.xcdc102, 
   xcdc202 LIKE xcdc_t.xcdc202, 
   xcdc208 LIKE xcdc_t.xcdc208, 
   xcdc902 LIKE xcdc_t.xcdc902, 
   xcdcld LIKE xcdc_t.xcdcld, 
   xcdc001 LIKE xcdc_t.xcdc001, 
   xcdc002 LIKE xcdc_t.xcdc002, 
   xcdc003 LIKE xcdc_t.xcdc003, 
   xcdc004 LIKE xcdc_t.xcdc004, 
   xcdc005 LIKE xcdc_t.xcdc005, 
   xcdc006 LIKE xcdc_t.xcdc006, 
   xcdc007 LIKE xcdc_t.xcdc007, 
   xcdc008 LIKE xcdc_t.xcdc008 
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xcdc_d
DEFINE g_master_t                   type_g_xcdc_d
DEFINE g_xcdc_d          DYNAMIC ARRAY OF type_g_xcdc_d
DEFINE g_xcdc_d_t        type_g_xcdc_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
#DEFINE l_ac                 LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE l_ac                 LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
DEFINE l_ac_d               LIKE type_t.num10              #單身idx #161108-00012#4 num5==》num10
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
#DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數  #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_page       LIKE type_t.num10              #目前所在頁數  #161108-00012#4  2016/11/09 By 08734 add
#DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)  #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)  #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_detail_cnt2        LIKE type_t.num10              #單身 總筆數(所有資料)  #161108-00012#4 num5==》num10
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10  #161108-00012#4 num5==》num10
#DEFINE g_detail_idx         LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
#DEFINE g_detail_idx2        LIKE type_t.num5   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_detail_idx         LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_detail_idx2        LIKE type_t.num10   #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
 TYPE type_g_xcdc_m RECORD   
   xcdc001 LIKE xcdc_t.xcdc001, 
   xcdc002  LIKE xcdc_t.xcdc002, 
   xcdc003  LIKE xcdc_t.xcdc003,   
   xcdc004  LIKE xcdc_t.xcdc004,
   xcdc005  LIKE xcdc_t.xcdc005,
   xcdc006  LIKE xcdc_t.xcdc006,
   xcdc007  LIKE xcdc_t.xcdc007,   
   xcdc008  LIKE xcdc_t.xcdc008,   
   xcdcld   LIKE xcdc_t.xcdcld,
   xcdccomp LIKE xcdc_t.xcdccomp,  
   xcdccomp_desc LIKE ooefl_t.ooefl003,
   xcdc006_desc  LIKE imaal_t.imaal003,
   xcdc006_desc_1  LIKE imaal_t.imaal004,
   xcdcld_desc   LIKE glaal_t.glaal002,
   xcdc002_desc    LIKE xcbfl_t.xcbfl003,   
   xcdc003_desc  LIKE xcatl_t.xcatl003,  
   glaa001         LIKE glaa_t.glaa001,
   glaa001_desc  LIKE ooail_t.ooail003
     END RECORD
DEFINE g_master1                     type_g_xcdc_m
DEFINE g_master1_t                   type_g_xcdc_m
DEFINE g_wc3                STRING
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#4  2016/11/09 By 08734 add
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數  #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_current_idx         LIKE type_t.num10              #Browser所在筆數  #161108-00012#4 num5==》num10
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         xcdcent   LIKE xcdc_t.xcdcent,
         xcdcld    LIKE xcdc_t.xcdcld,
         xcdc001   LIKE xcdc_t.xcdc001,
         xcdc002   LIKE xcdc_t.xcdc002,
         xcdc003   LIKE xcdc_t.xcdc003,
         xcdc004   LIKE xcdc_t.xcdc004,
         xcdc005   LIKE xcdc_t.xcdc005,
         xcdc006   LIKE xcdc_t.xcdc006,
         xcdc007   LIKE xcdc_t.xcdc007,
         xcdc008   LIKE xcdc_t.xcdc008        
      END RECORD
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150114
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150114
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="axcq505.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq505_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axcq505_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq505_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq505 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq505_init()   
 
      #進入選單 Menu (="N")
      CALL axcq505_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq505
      
   END IF 
   
   CLOSE axcq505_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq505.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq505_init()
   #add-point:init段define
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
      CALL cl_set_combo_scc('b_xcau003','8901') 
 
   
   #add-point:畫面資料初始化
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcdc002,xcdc002_desc',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcdc002,xcdc002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcdc007',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcdc007',FALSE)                
   END IF   
   #fengmy 150114----end 
CALL cl_set_combo_scc('xcdc001','8914') 
   #end add-point
 
   CALL axcq505_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq505.default_search" >}
PRIVATE FUNCTION axcq505_default_search()
   #add-point:default_search段define
   
   #end add-point
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcdcld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcdc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcdc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcdc003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcdc004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcdc005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcdc006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcdc007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xcdc008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xcdc009 = '", g_argv[10], "' AND "
   END IF
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
 
   #add-point:default_search段開始後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq505_ui_dialog()
   DEFINE ls_wc    STRING
   DEFINE li_idx   LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:ui_dialog段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 
INITIALIZE g_master1 TO NULL   
   #预设当前site的法人，主账套，年度期别    
   #dorislai-20151026-modify----(S)
#SELECT ooea002 INTO g_master1.xcdccomp
#  FROM ooea_t
# WHERE ooeaent = g_enterprise
#   AND ooea001 = g_site
#   
#SELECT glaald,glaa010,glaa011,glaa120 INTO g_master1.xcdcld,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdc003
#  FROM glaa_t
# WHERE glaaent  = g_enterprise
#   AND glaacomp = g_master1.xcdccomp
#   AND glaa014 = 'Y'
#CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6010') RETURNING g_master1.xcdc004
#CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6011') RETURNING g_master1.xcdc005
#
   CALL s_axc_set_site_default() RETURNING g_master1.xcdccomp,g_master1.xcdcld,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdc003
   #dorislai-20151026-modify----(E)
LET g_master1.xcdc001 = '1'
SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
  FROM glaa_t
 WHERE glaaent = g_enterprise
   AND glaald  = g_master1.xcdcld
   
   
CASE g_master1.xcdc001
   WHEN '1' 
     LET g_master1.glaa001= l_glaa001
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = l_glaa001
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc= '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc                   
   WHEN '2'
     LET g_master1.glaa001= l_glaa016
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = l_glaa016
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc 
   WHEN '3'
     LET g_master1.glaa001= l_glaa020
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = l_glaa020
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc
END CASE

INITIALIZE g_ref_fields TO NULL
LET g_ref_fields[1] = g_master1.xcdccomp
CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
LET g_master1.xcdccomp_desc = '', g_rtn_fields[1] , ''
DISPLAY BY NAME g_master1.xcdccomp_desc 

INITIALIZE g_ref_fields TO NULL
LET g_ref_fields[1] = g_master1.xcdcld
CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
LET g_master1.xcdcld_desc = '', g_rtn_fields[1] , ''
DISPLAY BY NAME g_master1.xcdcld_desc 

INITIALIZE g_ref_fields TO NULL
LET g_ref_fields[1] = g_master1.xcdc003
CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
LET g_master1.xcdc003_desc = '', g_rtn_fields[1] , ''
DISPLAY BY NAME g_master1.xcdc003_desc
   #end add-point
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=1" THEN
      LET g_detail_idx = 1
      CALL axcq505_b_fill()
   ELSE
      CALL axcq505_query()
   END IF
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xcdc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
              #DISPLAY g_xcdc_d.getLength() TO FORMONLY.h_count
               CALL axcq505_fetch1('')
               LET g_master_idx = l_ac
               #add-point:input段before row
               DISPLAY g_master_idx TO FORMONLY.idx
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
                       
            #end add-point
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axcq505_insert()
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq505_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq505_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axcq505_b_fill()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         
         
 
         #add-point:ui_dialog段自定義action
         ON ACTION first
            CALL axcq505_fetch1('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION previous
            CALL axcq505_fetch1('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION jump
            CALL axcq505_fetch1('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION next
            CALL axcq505_fetch1('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION last
            CALL axcq505_fetch1('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcdc_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq505_b_fill()
            END IF
      
      #  ON ACTION qbeclear   # 條件清除
      #     CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq505_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001  #160921-00010#1 add
   DEFINE l_glaa016 LIKE glaa_t.glaa016  #160921-00010#1 add
   DEFINE l_glaa020 LIKE glaa_t.glaa020  #160921-00010#1 add

   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xcdc_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xcau003,xcdc009,xcdc101,xcdc201,xcdc207,xcdc901,xcdc102,xcdc202,xcdc208, 
          xcdc902
           FROM s_detail1[1].b_xcau003,s_detail1[1].b_xcdc009,s_detail1[1].b_xcdc101,s_detail1[1].b_xcdc201, 
               s_detail1[1].b_xcdc207,s_detail1[1].b_xcdc901,s_detail1[1].b_xcdc102,s_detail1[1].b_xcdc202, 
               s_detail1[1].b_xcdc208,s_detail1[1].b_xcdc902
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xcau003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcau003
            #add-point:BEFORE FIELD b_xcau003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcau003
            
            #add-point:AFTER FIELD b_xcau003

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcau003
         ON ACTION controlp INFIELD b_xcau003
            #add-point:ON ACTION controlp INFIELD b_xcau003

            #END add-point
 
         #----<<b_xcdc009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc009
            #add-point:BEFORE FIELD b_xcdc009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc009
            
            #add-point:AFTER FIELD b_xcdc009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc009
         ON ACTION controlp INFIELD b_xcdc009
            #add-point:ON ACTION controlp INFIELD b_xcdc009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcdc009  #顯示到畫面上

            NEXT FIELD b_xcdc009                
            #END add-point
 
         #----<<xcdc009_desc>>----
         #----<<b_xcdc101>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc101
            #add-point:BEFORE FIELD b_xcdc101

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc101
            
            #add-point:AFTER FIELD b_xcdc101

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc101
         ON ACTION controlp INFIELD b_xcdc101
            #add-point:ON ACTION controlp INFIELD b_xcdc101

            #END add-point
 
         #----<<b_xcdc201>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc201
            #add-point:BEFORE FIELD b_xcdc201
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc201
            
            #add-point:AFTER FIELD b_xcdc201
 
            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc201
         ON ACTION controlp INFIELD b_xcdc201
            #add-point:ON ACTION controlp INFIELD b_xcdc201

            #END add-point
 
         #----<<b_xcdc207>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc207
            #add-point:BEFORE FIELD b_xcdc207

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc207
            
            #add-point:AFTER FIELD b_xcdc207

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc207
         ON ACTION controlp INFIELD b_xcdc207
            #add-point:ON ACTION controlp INFIELD b_xcdc207

            #END add-point
 
         #----<<b_xcdc901>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc901
            #add-point:BEFORE FIELD b_xcdc901

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc901
            
            #add-point:AFTER FIELD b_xcdc901

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc901
         ON ACTION controlp INFIELD b_xcdc901
            #add-point:ON ACTION controlp INFIELD b_xcdc901

            #END add-point
 
         #----<<b_xcdc102>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc102
            #add-point:BEFORE FIELD b_xcdc102

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc102
            
            #add-point:AFTER FIELD b_xcdc102

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc102
         ON ACTION controlp INFIELD b_xcdc102
            #add-point:ON ACTION controlp INFIELD b_xcdc102

            #END add-point
 
         #----<<b_xcdc202>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc202
            #add-point:BEFORE FIELD b_xcdc202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc202
            
            #add-point:AFTER FIELD b_xcdc202

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc202
         ON ACTION controlp INFIELD b_xcdc202
            #add-point:ON ACTION controlp INFIELD b_xcdc202

            #END add-point
 
         #----<<b_xcdc208>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc208
            #add-point:BEFORE FIELD b_xcdc208

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc208
            
            #add-point:AFTER FIELD b_xcdc208

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc208
         ON ACTION controlp INFIELD b_xcdc208
            #add-point:ON ACTION controlp INFIELD b_xcdc208

            #END add-point
 
         #----<<b_xcdc902>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xcdc902
            #add-point:BEFORE FIELD b_xcdc902

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xcdc902
            
            #add-point:AFTER FIELD b_xcdc902

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xcdc902
         ON ACTION controlp INFIELD b_xcdc902
            #add-point:ON ACTION controlp INFIELD b_xcdc902

            #END add-point
 
         #----<<b_xcdcld_1>>----
         #----<<b_xcdc001_1>>----
         #----<<b_xcdc002_1>>----
         #----<<b_xcdc003_1>>----
         #----<<b_xcdc004_1>>----
         #----<<b_xcdc005_1>>----
         #----<<b_xcdc006_1>>----
         #----<<b_xcdc007_1>>----
         #----<<b_xcdc008_1>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      CONSTRUCT BY NAME g_wc3 ON xcdccomp,xcdc004,xcdc005,xcdc006,xcdc007,xcdcld,xcdc001,xcdc002,xcdc003,xcdc008
 
         BEFORE CONSTRUCT
            #dorislai-20151026-modify----(S)
#            DISPLAY BY NAME g_master1.xcdccomp,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdcld,g_master1.xcdc001
            #160921-00010#1 add(s)
            INITIALIZE g_master1 TO NULL   
               #预设当前site的法人，主账套，年度期别    
            CALL s_axc_set_site_default() RETURNING g_master1.xcdccomp,g_master1.xcdcld,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdc003
               #dorislai-20151026-modify----(E)
            LET g_master1.xcdc001 = '1'
            SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_master1.xcdcld
                
            CASE g_master1.xcdc001
               WHEN '1' 
                 LET g_master1.glaa001= l_glaa001
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa001
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_master1.glaa001_desc= '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_master1.glaa001_desc                   
               WHEN '2'
                 LET g_master1.glaa001= l_glaa016
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa016
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_master1.glaa001_desc 
               WHEN '3'
                 LET g_master1.glaa001= l_glaa020
                 INITIALIZE g_ref_fields TO NULL
                 LET g_ref_fields[1] = l_glaa020
                 CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                 LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
                 DISPLAY BY NAME g_master1.glaa001_desc
            END CASE
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master1.xcdccomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master1.xcdccomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master1.xcdccomp_desc 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master1.xcdcld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master1.xcdcld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master1.xcdcld_desc 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master1.xcdc003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master1.xcdc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master1.xcdc003_desc  
            #160921-00010#1 add(e)
            DISPLAY BY NAME g_master1.xcdccomp,g_master1.xcdc004,g_master1.xcdc005,
                            g_master1.xcdcld,g_master1.xcdc001,g_master1.xcdc003
            #dorislai-20151026-modify----(E)                
            DISPLAY BY NAME g_master1.xcdccomp_desc,g_master1.xcdcld_desc,g_master1.glaa001,g_master1.glaa001_desc         
#          CALL cl_qbe_init()
##          CALL FGL_DIALOG_SETBUFFER(g_master1.xcdc004)
#        BEFORE FIELD xcdccomp
#           CALL FGL_DIALOG_SETBUFFER(g_master1.xcdccomp)
#        BEFORE FIELD xcdcld
#           CALL FGL_DIALOG_SETBUFFER(g_master1.xcdcld)
#        BEFORE FIELD xcdc004
#           CALL FGL_DIALOG_SETBUFFER(g_master1.xcdc004)
#        BEFORE FIELD xcdc005
#           CALL FGL_DIALOG_SETBUFFER(g_master1.xcdc005)
#        BEFORE FIELD xcdc001
#           CALL FGL_DIALOG_SETBUFFER('1')     
           #fengmy 150114----begin
           #根據參數顯示隱藏成本域 和 料件特性
           IF cl_null(g_master1.xcdccomp) THEN
              CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
              CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
           ELSE
              CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
              CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
           END IF   
           IF g_para_data = 'Y' THEN
              CALL cl_set_comp_visible('xcdc002,xcdc002_desc',TRUE)                    
           ELSE                           
              CALL cl_set_comp_visible('xcdc002,xcdc002_desc',FALSE)                
           END IF   
           IF g_para_data1 = 'Y' THEN
              CALL cl_set_comp_visible('xcdc007',TRUE)                    
           ELSE                           
              CALL cl_set_comp_visible('xcdc007',FALSE)                
           END IF   
           #fengmy 150114----end  
         ON ACTION controlp INFIELD xcdccomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdccomp  #顯示到畫面上

            NEXT FIELD xcdccomp                     #返回原欄位         
         
         
         
         ON ACTION controlp INFIELD xcdcld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(E)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdcld  #顯示到畫面上
            NEXT FIELD xcdcld                     #返回原欄位        
         
         
         
         ON ACTION controlp INFIELD xcdc003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdc003  #顯示到畫面上
            NEXT FIELD xcdc003                     #返回原欄位         
         
         
         
#         ON ACTION controlp INFIELD xcdc008
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = 'F'
#            CALL q_inaj010()                  #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcdc008  #顯示到畫面上
#            NEXT FIELD xcdc008                    #返回原欄位           
#         
         
         
         ON ACTION controlp INFIELD xcdc006
            #此段落由子樣板a08產
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdc006  #顯示到畫面上

            NEXT FIELD xcdc006                     #返回原欄位         
         
#          ON ACTION controlp INFIELD xcdc007
            #此段落由子樣板a08產生
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_xccd008()                       #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xcdc007  #顯示到畫面上
#
#            NEXT FIELD xcdc007                     #返回原欄位  
         
         ON ACTION controlp INFIELD xcdc002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdc002  #顯示到畫面上

            NEXT FIELD xcdc002                     #返回原欄位         
         
         
        
           
         
        
         
      END CONSTRUCT
      #end add-point 
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   LET g_wc3=cl_replace_str(g_wc3,"b_","")
   CALL axcq505_browser_fill()
   CALL axcq505_fetch1("F")
   #end add-point
        
   LET g_error_show = 1
  # CALL axcq505_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="axcq505.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq505_b_fill()
   DEFINE ls_wc           STRING
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET g_sql = "SELECT  UNIQUE '',xcdc009,'',xcdc101,xcdc201,xcdc207,xcdc901,xcdc102,xcdc202,xcdc208, 
       xcdc902,'','','','','','','','','' FROM xcdc_t",
 
 
               "",
               " WHERE xcdcent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("xcdc_t")
    
   LET g_sql = g_sql, cl_sql_add_filter("xcdc_t"),
                      " ORDER BY xcdc_t.xcdcld,xcdc_t.xcdc001,xcdc_t.xcdc002,xcdc_t.xcdc003,xcdc_t.xcdc004,xcdc_t.xcdc005,xcdc_t.xcdc006,xcdc_t.xcdc007,xcdc_t.xcdc008,xcdc_t.xcdc009"
  
   #add-point:b_fill段sql_after
   LET g_sql = "SELECT  UNIQUE xcau003,xcdc009,xcaul003,xcdc101,",
               "        CASE WHEN xcdc311>0 THEN (xcdc201+xcdc203+xcdc205+xcdc209+xcdc211+xcdc213+xcdc215+xcdc217+xcdc305+xcdc311) ELSE (xcdc201+xcdc203+xcdc205+xcdc209+xcdc211+xcdc213+xcdc215+xcdc217+xcdc305) END ,",
               "        CASE WHEN xcdc311<0 THEN (xcdc207+xcdc301+xcdc303+xcdc309+xcdc313+xcdc307-xcdc311) ELSE (xcdc207+xcdc301+xcdc303+xcdc309+xcdc313+xcdc307) END,",
               "        xcdc901,xcdc102,",
               "        CASE WHEN xcdc312>0 THEN (xcdc202+xcdc204+xcdc206+xcdc210+xcdc212+xcdc214+xcdc216+xcdc218+xcdc306+xcdc312) ELSE (xcdc202+xcdc204+xcdc206+xcdc210+xcdc212+xcdc214+xcdc216+xcdc218+xcdc306) END,",
               "        CASE WHEN xcdc312<0 THEN (xcdc208+xcdc302+xcdc304+xcdc310+xcdc314+xcdc308-xcdc312) ELSE (xcdc208+xcdc302+xcdc304+xcdc310+xcdc314+xcdc308) END,", 
               "        xcdc902,'','','','','','','','','' FROM xcdc_t t0",
 
               " LEFT JOIN xcau_t t1 ON t1.xcauent='"||g_enterprise||"' AND t1.xcau001=t0.xcdc009",
               "  LEFT JOIN xcaul_t t2 ON t2.xcaulent='"||g_enterprise||"' AND t2.xcaul001=t0.xcdc009 AND t2.xcaul002='"||g_dlang||"' ",
               "",
               " WHERE xcdcent= ? AND xcdcld = ? ",
               "   AND xcdc001 = ? AND xcdc002 = ? AND xcdc003 = ? AND xcdc004 = ? AND xcdc005 = ? AND xcdc006 = ? ",
               "   AND xcdc007 = ? AND xcdc008 = ?  AND ",g_wc3," AND ",ls_wc,cl_sql_add_filter("xcdc_t")
    
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcdcld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcdccomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   LET g_sql = g_sql, #cl_sql_add_filter("xcdc_t"),
                      " ORDER BY xcdc009"
  
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq505_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq505_pb
   
 #  OPEN b_fill_curs USING g_enterprise
 
   CALL g_xcdc_d.clear()
 
   #add-point:陣列清空
OPEN b_fill_curs USING g_enterprise,g_master1.xcdcld,g_master1.xcdc001,g_master1.xcdc002,g_master1.xcdc003,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdc006,g_master1.xcdc007,g_master1.xcdc008

   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_xcdc_d[l_ac].xcau003,g_xcdc_d[l_ac].xcdc009,g_xcdc_d[l_ac].xcdc009_desc, 
       g_xcdc_d[l_ac].xcdc101,g_xcdc_d[l_ac].xcdc201,g_xcdc_d[l_ac].xcdc207,g_xcdc_d[l_ac].xcdc901,g_xcdc_d[l_ac].xcdc102, 
       g_xcdc_d[l_ac].xcdc202,g_xcdc_d[l_ac].xcdc208,g_xcdc_d[l_ac].xcdc902,g_xcdc_d[l_ac].xcdcld,g_xcdc_d[l_ac].xcdc001, 
       g_xcdc_d[l_ac].xcdc002,g_xcdc_d[l_ac].xcdc003,g_xcdc_d[l_ac].xcdc004,g_xcdc_d[l_ac].xcdc005,g_xcdc_d[l_ac].xcdc006, 
       g_xcdc_d[l_ac].xcdc007,g_xcdc_d[l_ac].xcdc008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xcdc_d[l_ac].statepic = cl_get_actipic(g_xcdc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL axcq505_detail_show("'1'")      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_xcdc_d.deleteElement(g_xcdc_d.getLength())   
 
   #add-point:陣列長度調整

   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)
   
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axcq505_pb
   
   LET l_ac = 1
#   IF g_xcdc_d.getLength() > 0 THEN
#      CALL axcq505_fetch()
#   END IF
   
      CALL axcq505_filter_show('xcau003','b_xcau003')
   CALL axcq505_filter_show('xcdc009','b_xcdc009')
   CALL axcq505_filter_show('xcdc101','b_xcdc101')
   CALL axcq505_filter_show('xcdc201','b_xcdc201')
   CALL axcq505_filter_show('xcdc207','b_xcdc207')
   CALL axcq505_filter_show('xcdc901','b_xcdc901')
   CALL axcq505_filter_show('xcdc102','b_xcdc102')
   CALL axcq505_filter_show('xcdc202','b_xcdc202')
   CALL axcq505_filter_show('xcdc208','b_xcdc208')
   CALL axcq505_filter_show('xcdc902','b_xcdc902')
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq505.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq505_fetch()
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:fetch段define

   #end add-point
   
 
   #add-point:陣列清空
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後
#LET g_sql = " SELECT DISTINCT xcdccomp,xcdcld,xcdc001,xcdc002,xcdc003,xcdc004,xcdc005,xcdc006,xcdc007,xcdc008,xcdc009 ",
#               "   FROM xcdc_t ",
#               "  WHERE xcdcent= ? AND xcdcld = ? AND xcdc001 = ?",
#               "    AND xcdc002 = ? AND xcdc003 = ? AND xcdc004 = ? AND xcdc005 = ? AND xcdc006 = ? ",
#               "    AND xcdc007 = ? AND xcdc008 = ?  "
#  
#   PREPARE axcq505_fetch_pre FROM g_sql
#            
#   IF g_browser_cnt = 0 THEN
#      RETURN
#   END IF
#   
#   CASE p_flag
#      WHEN 'F' 
#         LET g_current_idx = 1
#      WHEN 'L'  
#         LET g_current_idx = g_browser_cnt              
#      WHEN 'P'
#         IF g_current_idx > 1 THEN               
#            LET g_current_idx = g_current_idx - 1
#         END IF 
#      WHEN 'N'
#         IF g_current_idx < g_browser_cnt THEN
#            LET g_current_idx =  g_current_idx + 1
#         END IF        
#      WHEN '/'
#         IF (NOT g_no_ask) THEN    
#            CALL cl_set_act_visible("accept,cancel", TRUE)    
#            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#            LET INT_FLAG = 0
# 
#            PROMPT ls_msg CLIPPED,':' FOR g_jump
#               #交談指令共用ACTION
#               &include "common_action.4gl" 
#            END PROMPT
# 
#            CALL cl_set_act_visible("accept,cancel", FALSE)    
#            IF INT_FLAG THEN
#                LET INT_FLAG = 0
#                EXIT CASE  
#            END IF           
#         END IF
#         
#         IF g_jump > 0 AND g_jump <= g_browser_cnt THEN
#             LET g_current_idx = g_jump
#         END IF
#         LET g_no_ask = FALSE  
#   END CASE 
#   
#   
#   LET g_detail_cnt = g_browser_cnt                  
#   
#   #單身總筆數顯示
#   #LET g_detail_idx = 1
#   IF g_detail_cnt > 0 THEN
#      #LET g_detail_idx = 1
#      DISPLAY g_detail_idx TO FORMONLY.idx  
#   ELSE
#      LET g_detail_idx = 0
#      DISPLAY ' ' TO FORMONLY.idx    
#   END IF
#
#   DISPLAY g_current_idx TO FORMONLY.h_index   #當下筆數
#   
#   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
#   
#   #代表沒有資料
#   IF g_current_idx = 0 THEN
#      RETURN
#   END IF
#
##单身总行数是固定的
#   DISPLAY '1' TO FORMONLY.idx
#   
#   
#   #重讀DB,因TEMP有不被更新特性
#   EXECUTE axcq505_fetch_pre USING g_browser[g_current_idx].xcdcent,g_browser[g_current_idx].xcdcld,g_browser[g_current_idx].xcdc001,g_browser[g_current_idx].xcdc002,
#                                   g_browser[g_current_idx].xcdc003,g_browser[g_current_idx].xcdc004,g_browser[g_current_idx].xcdc005,g_browser[g_current_idx].xcdc006,
#                                   g_browser[g_current_idx].xcdc007,g_browser[g_current_idx].xcdc008                                  
#      INTO g_master1.xcdccomp,g_master1.xcdcld,g_master1.xcdc001,g_master1.xcdc002,g_master1.xcdc003,g_master1.xcdc004,g_master1.xcdc005,
#           g_master1.xcdc006,g_master1.xcdc007,g_master1.xcdc008
#      
#   FREE axcq505_fetch_pre
#            
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "xcdc_t" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
# 
#      INITIALIZE g_master1.* TO NULL
#      RETURN
#   END IF
#
#   #重新顯示   
#   CALL axcq505_show()   
   #end add-point 
   
 
   #add-point:陣列筆數調整

   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq505.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq505_detail_show(ps_page)
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define
   
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq505_filter()
   #add-point:filter段define
   
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
      CONSTRUCT g_wc_filter ON xcau003,xcdc009,xcdc101,xcdc201,xcdc207,xcdc901,xcdc102,xcdc202,xcdc208, 
          xcdc902
                          FROM s_detail1[1].b_xcau003,s_detail1[1].b_xcdc009,s_detail1[1].b_xcdc101, 
                              s_detail1[1].b_xcdc201,s_detail1[1].b_xcdc207,s_detail1[1].b_xcdc901,s_detail1[1].b_xcdc102, 
                              s_detail1[1].b_xcdc202,s_detail1[1].b_xcdc208,s_detail1[1].b_xcdc902
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
                     DISPLAY axcq505_filter_parser('xcau003') TO s_detail1[1].b_xcau003
            DISPLAY axcq505_filter_parser('xcdc009') TO s_detail1[1].b_xcdc009
            DISPLAY axcq505_filter_parser('xcdc101') TO s_detail1[1].b_xcdc101
            DISPLAY axcq505_filter_parser('xcdc201') TO s_detail1[1].b_xcdc201
            DISPLAY axcq505_filter_parser('xcdc207') TO s_detail1[1].b_xcdc207
            DISPLAY axcq505_filter_parser('xcdc901') TO s_detail1[1].b_xcdc901
            DISPLAY axcq505_filter_parser('xcdc102') TO s_detail1[1].b_xcdc102
            DISPLAY axcq505_filter_parser('xcdc202') TO s_detail1[1].b_xcdc202
            DISPLAY axcq505_filter_parser('xcdc208') TO s_detail1[1].b_xcdc208
            DISPLAY axcq505_filter_parser('xcdc902') TO s_detail1[1].b_xcdc902
 
 
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
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL axcq505_filter_show('xcau003','b_xcau003')
   CALL axcq505_filter_show('xcdc009','b_xcdc009')
   CALL axcq505_filter_show('xcdc101','b_xcdc101')
   CALL axcq505_filter_show('xcdc201','b_xcdc201')
   CALL axcq505_filter_show('xcdc207','b_xcdc207')
   CALL axcq505_filter_show('xcdc901','b_xcdc901')
   CALL axcq505_filter_show('xcdc102','b_xcdc102')
   CALL axcq505_filter_show('xcdc202','b_xcdc202')
   CALL axcq505_filter_show('xcdc208','b_xcdc208')
   CALL axcq505_filter_show('xcdc902','b_xcdc902')
 
    
   CALL axcq505_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq505_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_tmp2    LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_var     STRING
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
 
{</section>}
 
{<section id="axcq505.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq505_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axcq505_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.insert" >}
#+ insert
PRIVATE FUNCTION axcq505_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq505.modify" >}
#+ modify
PRIVATE FUNCTION axcq505_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq505_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.delete" >}
#+ delete
PRIVATE FUNCTION axcq505_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq505.other_function" >}

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
PRIVATE FUNCTION axcq505_browser_fill()
   DEFINE l_cnt      LIKE type_t.num5
   
   CLEAR FORM
   CALL g_xcdc_d.clear()
   
   LET g_wc_filter = " 1=1"
   
#虽然没有browser，也要建一个类似的g_browser数组来定位在第几笔
   CALL g_browser.clear()
   
   LET g_sql = " SELECT DISTINCT xcdcent,xcdcld,xcdc001,xcdc002,xcdc003,xcdc004,xcdc005,xcdc006,xcdc007,xcdc008 ",
            "   FROM xcdc_t ",
            "  WHERE xcdcent = '",g_enterprise,"' AND ",g_wc3#," AND ",g_wc2
  
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcdcld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcdccomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   PREPARE axcq505_browser_pre FROM g_sql
   DECLARE axcq505_browser_cs CURSOR FOR axcq505_browser_pre
   
   LET l_cnt = 1
   FOREACH axcq505_browser_cs INTO g_browser[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   FREE axcq505_browser_cs
   CALL g_browser.deleteElement(l_cnt)
   
#抓总笔数
   LET g_browser_cnt = l_cnt - 1   #總筆數   
   
   IF g_browser_cnt > g_max_rec THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_rec
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
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
PRIVATE FUNCTION axcq505_show()
 SELECT glaa001,glaa016,glaa020 INTO g_glaa001,g_glaa016,g_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master1.xcdcld  
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_master1.xcdccomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_master1.xcdccomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF   
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcdc002,xcdc002_desc',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcdc002,xcdc002_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcdc007',TRUE)                    
   ELSE                           
      CALL cl_set_comp_visible('xcdc007',FALSE)                
   END IF   
   #fengmy 150114----end    
   CALL axcq505_b_fill()
   
   DISPLAY BY NAME g_master1.xcdccomp,g_master1.xcdcld,g_master1.xcdc003,g_master1.xcdc004,g_master1.xcdc005,g_master1.xcdc006,g_master1.xcdc006,
                   g_master1.xcdc008,g_master1.xcdc002,g_master1.xcdc001
   
  #DISPLAY g_master1.xcdccomp TO b_xcdccomp
#根据料号抓品名规格，成本单位
   CALL s_desc_get_item_desc(g_master1.xcdc006)
         RETURNING g_master1.xcdc006_desc,g_master1.xcdc006_desc_1

#带出显示名称
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master1.xcdccomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master1.xcdccomp_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master1.xcdcld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master1.xcdcld_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master1.xcdc003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master1.xcdc003_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master1.xcdccomp
   LET g_ref_fields[2] = g_master1.xcdc002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp = ? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master1.xcdc002_desc = '', g_rtn_fields[1] , ''   
   
   CASE g_master1.xcdc001
        WHEN '1' 
            LET g_master1.glaa001= g_glaa001
        WHEN '2' 
            LET g_master1.glaa001= g_glaa016
        WHEN '3'
            LET g_master1.glaa001= g_glaa020
   END CASE
   CASE g_master1.xcdc001
   WHEN '1' 
     LET g_master1.glaa001= g_glaa001
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_glaa001
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc= '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc                   
   WHEN '2'
     LET g_master1.glaa001= g_glaa016
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_glaa016
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc 
   WHEN '3'
     LET g_master1.glaa001= g_glaa020
     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = g_glaa020
     CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET g_master1.glaa001_desc = '', g_rtn_fields[1] , ''
     DISPLAY BY NAME g_master1.glaa001_desc
  END CASE
#带出栏位都显示一下
   DISPLAY BY NAME g_master1.xcdc006_desc,g_master1.xcdc006_desc_1,g_master1.xcdc002_desc,
                   g_master1.xcdccomp_desc,g_master1.xcdcld_desc,g_master1.xcdc003_desc,g_master1.glaa001,g_master1.glaa001_desc

#根据账套是否启用第二，第三币种，动态显示隐藏第二，第三单身
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
PRIVATE FUNCTION axcq505_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE l_cnt      LIKE type_t.num5
LET g_sql = " SELECT DISTINCT xcdccomp,xcdcld,xcdc001,xcdc002,xcdc003,xcdc004,xcdc005,xcdc006,xcdc007,xcdc008,xcdc009 ",
               "   FROM xcdc_t ",
               "  WHERE xcdcent= ? AND xcdcld = ? AND xcdc001 = ?",
               "    AND xcdc002 = ? AND xcdc003 = ? AND xcdc004 = ? AND xcdc005 = ? AND xcdc006 = ? ",
               "    AND xcdc007 = ? AND xcdc008 = ?  "
  
   PREPARE axcq505_fetch_pre FROM g_sql
            
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser_cnt              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_browser_cnt THEN
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
         
         IF g_jump > 0 AND g_jump <= g_browser_cnt THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
   
   
   LET g_detail_cnt = g_browser_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF

   DISPLAY g_current_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 THEN
      RETURN
   END IF

#单身总行数是固定的
   DISPLAY '1' TO FORMONLY.idx
   
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq505_fetch_pre USING g_browser[g_current_idx].xcdcent,g_browser[g_current_idx].xcdcld,g_browser[g_current_idx].xcdc001,g_browser[g_current_idx].xcdc002,
                                   g_browser[g_current_idx].xcdc003,g_browser[g_current_idx].xcdc004,g_browser[g_current_idx].xcdc005,g_browser[g_current_idx].xcdc006,
                                   g_browser[g_current_idx].xcdc007,g_browser[g_current_idx].xcdc008                                  
      INTO g_master1.xcdccomp,g_master1.xcdcld,g_master1.xcdc001,g_master1.xcdc002,g_master1.xcdc003,g_master1.xcdc004,g_master1.xcdc005,
           g_master1.xcdc006,g_master1.xcdc007,g_master1.xcdc008
      
   FREE axcq505_fetch_pre
            
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdc_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_master1.* TO NULL
      RETURN
   END IF

   #重新顯示   
   CALL axcq505_show()   
   #end add-point 
   
 
END FUNCTION

 
{</section>}
 
