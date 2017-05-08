#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq519.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000013
#+ 
#+ Filename...: axcq519
#+ Description: 內部調撥成本查詢作業
#+ Creator....: 00537(2014/09/02)
#+ Modifier...: 00537(2014/09/02) -SD/PR- 09042
#+ Buildtype..: 應用 q01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq519.global" >}
#160113-00011#2  By 02040     調整參數接收
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
#160520-00003#9   2016/05/20 By zhujing     效能优化
#160523-00014#1   2016/05/13 By xianghui    上下笔切换逻辑不对
#160617-00002#2   2016/06/27 By zhujing     增加二次筛选的功能
#160802-00020#7   2016/10/07 By shiun       增加帳套權限管控、法人權限管控
#161108-00012#4   2016/11/09 By 08734       g_browser_cnt 由num5改為num10
#170316-00009#14  2017/03/31 By 09042       axcq519_tmp中xcck010_desc_1改为xcck010_desc1
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d RECORD
       
       sel LIKE type_t.chr1, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck021_desc LIKE type_t.chr500,
   xcck006 LIKE xcck_t.xcck006, 
   xcck007 LIKE xcck_t.xcck007, 
   xcck008 LIKE xcck_t.xcck008, 
   xcck009 LIKE xcck_t.xcck009, 
   xcck013 LIKE xcck_t.xcck013, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_desc LIKE type_t.chr500, 
   xcck010_desc_1 LIKE type_t.chr500, 
   xcck011 LIKE xcck_t.xcck011, 
   xcck015 LIKE xcck_t.xcck015, 
   xcck015_desc LIKE type_t.chr500, 
   xcck017 LIKE xcck_t.xcck017, 
   xcck044 LIKE xcck_t.xcck044, 
   xcck044_desc LIKE type_t.chr500, 
   xcck201 LIKE xcck_t.xcck201, 
   xcck040 LIKE xcck_t.xcck040, 
   xcck040_desc LIKE type_t.chr500, 
   xcck042 LIKE xcck_t.xcck042, 
   xcck282 LIKE xcck_t.xcck282,
   xcck282a LIKE xcck_t.xcck282a,
   xcck282b LIKE xcck_t.xcck282b,
   xcck282c LIKE xcck_t.xcck282c,
   xcck282d LIKE xcck_t.xcck282d,
   xcck282e LIKE xcck_t.xcck282e,
   xcck282f LIKE xcck_t.xcck282f,
   xcck282g LIKE xcck_t.xcck282g,
   xcck282h LIKE xcck_t.xcck282h,   
   xcck202 LIKE xcck_t.xcck202,
   xcck202a LIKE xcck_t.xcck202a,
   xcck202b LIKE xcck_t.xcck202b,
   xcck202c LIKE xcck_t.xcck202c,
   xcck202d LIKE xcck_t.xcck202d,
   xcck202e LIKE xcck_t.xcck202e,
   xcck202f LIKE xcck_t.xcck202f,
   xcck202g LIKE xcck_t.xcck202g,
   xcck202h LIKE xcck_t.xcck202h,   
   xcckld LIKE xcck_t.xcckld, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005
       END RECORD
PRIVATE TYPE type_g_xcck2_d RECORD
   xcck002 LIKE xcck_t.xcck002, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck010 LIKE xcck_t.xcck010, 
   xcck010_2_desc LIKE type_t.chr80, 
   xcck010_2_desc_1 LIKE type_t.chr80, 
   xcck011 LIKE xcck_t.xcck011,
   xcck044 LIKE xcck_t.xcck044,
   xcck201 LIKE xcck_t.xcck201,   
   xcck202 LIKE xcck_t.xcck202,
   xcck202a LIKE xcck_t.xcck202a,
   xcck202b LIKE xcck_t.xcck202b,
   xcck202c LIKE xcck_t.xcck202c,
   xcck202d LIKE xcck_t.xcck202d,
   xcck202e LIKE xcck_t.xcck202e,
   xcck202f LIKE xcck_t.xcck202f,
   xcck202g LIKE xcck_t.xcck202g,
   xcck202h LIKE xcck_t.xcck202h
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_xcck_d            DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t          type_g_xcck_d
DEFINE g_xcck2_d     DYNAMIC ARRAY OF type_g_xcck2_d
DEFINE g_xcck2_d_t   type_g_xcck2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10              #目前處理的ARRAY CNT   #161108-00012#4 num5==》num10  
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數   #161108-00012#4 num5==》num10
DEFINE g_current_row         LIKE type_t.num10              #目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_current_idx         LIKE type_t.num10  #161108-00012#4 num5==》num10
DEFINE g_detail_cnt          LIKE type_t.num10              #單身 總筆數(所有資料)   #161108-00012#4 num5==》num10
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10  #161108-00012#4 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身 所在筆數(所有資料)  #161108-00012#4 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10     #161108-00012#4 num5==》num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_master   RECORD
                  xcckcomp LIKE xcck_t.xcckcomp,
                  xcckcomp_desc LIKE ooefl_t.ooefl003,
                  xcck004 LIKE xcck_t.xcck004,
                  xcck005 LIKE xcck_t.xcck005,
                  xcckld  LIKE xcck_t.xcckld,
                  xcckld_desc   LIKE glaal_t.glaal003,
                  xcck001 LIKE xcck_t.xcck001,
                  xcck001_desc  LIKE ooail_t.ooail003,
                  xcck003 LIKE xcck_t.xcck003,
                  xcck003_desc  LIKE xcatl_t.xcatl003
                  END RECORD
                  
DEFINE g_browser   DYNAMIC ARRAY OF RECORD
                  xcckcomp LIKE xcck_t.xcckcomp,
                  xcck004 LIKE xcck_t.xcck004,
                  xcck005 LIKE xcck_t.xcck005,
                  xcckld  LIKE xcck_t.xcckld,
                  xcck001 LIKE xcck_t.xcck001,
                  xcck003 LIKE xcck_t.xcck003
                  END RECORD
                     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5   
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#4 num5==》num10
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數   #161108-00012#4 num5==》num10
DEFINE g_pagestart           LIKE type_t.num10        #161108-00012#4 num5==》num10
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150112 
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150112
#2015/3/25 ouhz add------begin----
TYPE type_g_xcck_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xcck_e
DEFINE g_sql_tmp             STRING
#2015/3/25 ouhz add------end----
DEFINE g_wc2_table1          STRING          #160617-00002#2 add
#add--160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--160802-00020#7 By shiun--(E)
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="axcq519.main" >}
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
   DECLARE axcq519_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR

 
   LET g_sql = " SELECT DISTINCT xcckcomp,xcck004,xcck005,xcckld,xcck001,xcck003 ",
               "   FROM xcck_t ",               
              "  WHERE xcckent = ? AND xcckcomp = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck004 = ? AND xcck005 = ? ",# AND xcck020 = '401' "  #fengmy150112 mark
               "   AND xcck020 = '115' "  #fengmy150112 add
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
 
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   PREPARE axcq519_master_referesh FROM g_sql 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq519_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq519 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq519_init()   
 
      #進入選單 Menu (="N")
      CALL axcq519_ui_dialog() 
      
      #add-point:畫面關閉前

      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq519
      
   END IF 
   
   CLOSE axcq519_cl
   
   
 
   #add-point:作業離開前

   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq519.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq519_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xcck001','8914')
   #fengmy 150112----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否            
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',FALSE)                
   END IF   
   #fengmy 150112----end
   #end add-point
 
   CALL axcq519_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq519.default_search" >}
PRIVATE FUNCTION axcq519_default_search()
   #add-point:default_search段define
   
   #end add-point
 
 
   #add-point:default_search段開始前
   LET g_pagestart = 1
  #160113-00011#2-add----(s) 
   IF NOT cl_null(g_argv[11]) THEN
      LET g_master.xcckcomp = g_argv[11]
      LET g_wc = g_wc , " xcckcomp = '", g_argv[11], "' AND "
   END IF   
   IF NOT cl_null(g_argv[12]) THEN
      LET g_wc = g_wc , " xcck010 = '", g_argv[12], "' AND "
   END IF
   IF NOT cl_null(g_argv[13]) THEN
      LET g_wc = g_wc , " xcck011 = '", g_argv[13], "' AND "
   END IF  
   IF NOT cl_null(g_argv[01]) THEN
      LET g_master.xcckld = g_argv[01]
   END IF    
   IF NOT cl_null(g_argv[04]) THEN
      LET g_master.xcck003 = g_argv[04]
   END IF   
   IF NOT cl_null(g_argv[05]) THEN
      LET g_master.xcck004 = g_argv[05]
   END IF 
   IF NOT cl_null(g_argv[06]) THEN
      LET g_master.xcck005 = g_argv[06]
   END IF    
  #160113-00011#2-add----(e)    
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcck002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcck003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcck004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcck005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcck006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcck007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xcck008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xcck009 = '", g_argv[10], "' AND "
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
 
   #add-point:default_search段結束前
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq519_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define
   DEFINE lb_first              BOOLEAN   #160617-00002#2 add
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_xcckcomp LIKE xcck_t.xcckcomp
   DEFINE l_xcckcomp_desc LIKE ooefl_t.ooefl003
   DEFINE l_xcckld  LIKE xcck_t.xcckld
   DEFINE l_xcckld_desc   LIKE glaal_t.glaal003
   DEFINE l_xcck001 LIKE xcck_t.xcck001
   DEFINE l_xcck001_desc  LIKE ooail_t.ooail003
   DEFINE l_xcck003 LIKE xcck_t.xcck003
   DEFINE l_xcck003_desc  LIKE xcatl_t.xcatl003
   
   
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 0
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
   #160617-00002#2 marked-S
##  CALL cl_set_act_visible("selall,selnone,sel,unsel,insert,query", FALSE)
#   CLEAR FORM                
#  #160113-00011#2--mark--(s)
#  #INITIALIZE g_master.* TO NULL
#  #CALL g_xcck_d.clear()        
#  #CALL g_xcck2_d.clear() 
#  #INITIALIZE g_wc TO NULL
#  #INITIALIZE g_wc2 TO NULL
#  #160113-00011#2--mark--(e) 
#  #160113-00011#2--add--(s)
#   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
#      LET g_detail_idx = 1
#      LET g_detail_idx2 = 1
#      CALL axcq519_browser_fill()
#   END IF   
#   #160113-00011#2--add--(e)
   #160617-00002#2 marked-E
   #160617-00002#2 add-S
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq519_query()
   END IF
   #160617-00002#2 add-E
   #end add-point
 
  
   WHILE li_exit = FALSE
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
 
         #end add-point
 
         #add-point:construct段落
   #160617-00002#2 marked-S
#         CONSTRUCT BY NAME g_wc ON xcckcomp,xcck004,xcck005,xcckld,xcck001,xcck003
#         
#            BEFORE CONSTRUCT
#
#            AFTER FIELD xcckcomp
#               LET l_xcckcomp = GET_FLDBUF(xcckcomp)
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = l_xcckcomp
#               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET l_xcckcomp_desc = '', g_rtn_fields[1] , ''
#               DISPLAY  l_xcckcomp_desc TO FORMONLY.xcckcomp_desc
#               #fengmy 150112----begin
#               #根據參數顯示隱藏成本域 和 料件特性
#               IF cl_null(l_xcckcomp) THEN
#                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
#                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
#               ELSE
#                  CALL cl_get_para(g_enterprise,l_xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
#                  CALL cl_get_para(g_enterprise,l_xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
#               END IF                
#               IF g_para_data = 'Y' THEN
#                  CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',TRUE)                    
#               ELSE
#                  CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',FALSE)                
#               END IF 
#                          
#               IF g_para_data1 = 'Y' THEN
#                  CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',TRUE)                    
#               ELSE
#                  CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',FALSE)                
#               END IF   
#               #fengmy 150112----end               
#            AFTER FIELD xcckld
#               LET l_xcckld = GET_FLDBUF(xcckld)
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = l_xcckld
#               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET l_xcckld_desc = '', g_rtn_fields[1] , ''
#               DISPLAY  l_xcckld_desc TO FORMONLY.xcckld_desc
#               
#            AFTER FIELD xcck001
#               LET l_xcck001 = GET_FLDBUF(xcck001)
#               LET l_xcckld  = GET_FLDBUF(xcckld)
#               
#               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
#                 FROM glaa_t
#                WHERE glaaent = g_enterprise
#                  AND glaald  = l_xcckld
#                  
#                  
#               CASE l_xcck001
#                  WHEN '1' 
#                    INITIALIZE g_ref_fields TO NULL
#                    LET g_ref_fields[1] = l_glaa001
#                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''
#                                   
#                  WHEN '2'
#                    INITIALIZE g_ref_fields TO NULL
#                    LET g_ref_fields[1] = l_glaa016
#                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''  
#                  WHEN '3'
#                    INITIALIZE g_ref_fields TO NULL
#                    LET g_ref_fields[1] = l_glaa020
#                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''  
#               END CASE
#               DISPLAY  l_xcck001_desc TO FORMONLY.xcck001_desc 
#              
#            AFTER FIELD xcck003  
#               LET l_xcck003 = GET_FLDBUF(xcck003)            
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = l_xcck003
#               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET l_xcck003_desc = '', g_rtn_fields[1] , ''
#               DISPLAY  l_xcck003_desc TO FORMONLY.xcck003_desc 
#               
#               
#            ON ACTION controlp INFIELD xcckcomp
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_ooef001_2()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcckcomp       #顯示到畫面上
#               NEXT FIELD xcckcomp                          #返回原欄位
#               
#               
#            ON ACTION controlp INFIELD xcckld
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = g_user
#               LET g_qryparam.arg2 = g_dept               
#               CALL q_authorised_ld()                       #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcckld         #顯示到畫面上
#               NEXT FIELD xcckld                            #返回原欄位
#               
#                           
#            ON ACTION controlp INFIELD xcck003
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_xcat001()                             #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck003        #顯示到畫面上
#               NEXT FIELD xcck003                           #返回原欄位
#         
#         AFTER CONSTRUCT 
#            CALL axcq519_browser_fill()
#            CONTINUE DIALOG
#
#         END CONSTRUCT
   #160617-00002#2 marked-E

         
#         CONSTRUCT g_wc2 ON xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011,xcck015,xcck017,
#                            xcck201,xcck040,xcck282,xcck025,xcck021
#              FROM s_detail1[1].xcck002,s_detail1[1].xcck006,s_detail1[1].xcck007,s_detail1[1].xcck008,s_detail1[1].xcck009,
#                   s_detail1[1].xcck013,s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck015,s_detail1[1].xcck017,
#                   s_detail1[1].xcck201,s_detail1[1].xcck040,s_detail1[1].xcck282,s_detail1[1].xcck025,s_detail1[1].xcck021
#                      
#            BEFORE CONSTRUCT
#
#            ON ACTION controlp INFIELD xcck002
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_xccc002()                             #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck002        #顯示到畫面上
#               NEXT FIELD xcck002                           #返回原欄位
#
#            ON ACTION controlp INFIELD xcck006
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_indcdocno_1()                         #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck006        #顯示到畫面上
#               NEXT FIELD xcck006                           #返回原欄位
#               
#            ON ACTION controlp INFIELD xcck010
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_imaa001_10()                          #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck010        #顯示到畫面上
#               NEXT FIELD xcck010                           #返回原欄位
#               
#            ON ACTION controlp INFIELD xcck011
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_xcck011()                             #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcckcomp       #顯示到畫面上
#               NEXT FIELD xcckcomp                          #返回原欄位
#               
#            ON ACTION controlp INFIELD xcck015
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_inaa001()                             #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck015        #顯示到畫面上
#               NEXT FIELD xcck015                           #返回原欄位
#               
#            ON ACTION controlp INFIELD xcck040
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_ooai001()                             #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck040        #顯示到畫面上
#               NEXT FIELD xcck040                           #返回原欄位
#               
#            ON ACTION controlp INFIELD xcck025
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c'
#               LET g_qryparam.reqry = FALSE
#               CALL q_ooeg001_2()                           #呼叫開窗
#               DISPLAY g_qryparam.return1 TO xcck025        #顯示到畫面上
#               NEXT FIELD xcck025                           #返回原欄位
#               
##            ON ACTION controlp INFIELD xcck021
##               INITIALIZE g_qryparam.* TO NULL
##               LET g_qryparam.state = 'c'
##               LET g_qryparam.reqry = FALSE
##               CALL q_xcat001()                             #呼叫開窗
##               DISPLAY g_qryparam.return1 TO xcckcomp       #顯示到畫面上
##               NEXT FIELD xcckcomp                          #返回原欄位
#               
#            
#         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
#               DISPLAY g_detail_idx TO FORMONLY.h_index
#               DISPLAY g_xcck_d.getLength() TO FORMONLY.h_count
#               LET g_master_idx = l_ac
#               CALL axcq519_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
         DISPLAY ARRAY g_xcck2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
#               LET g_detail_idx2 = l_ac
#               DISPLAY g_detail_idx2 TO FORMONLY.idx
               #add-point:input段before row

               #end add-point
            #自訂ACTION(detail_show,page_2)
            
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
      
         BEFORE DIALOG
#            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
            #预设当前site的法人，主账套，年度期别，成本计算类型
            CALL axcq519_set_cs_default()
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF 
        
            CALL axcq519_browser_fill()
      
         #liuym add 2015/2/15  ------str------
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
                  LET g_export_node[2] = base.typeInfo.create(g_xcck2_d)
                  LET g_export_id[1]="s_detail1"
                  LET g_export_id[2]="s_detail2"
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          # liuym add 2015/2/15  ------end------ 
#         ON ACTION agendum   # 待辦事項
#            #add-point:ON ACTION agendum

#            #end add-point
#            CALL cl_user_overview()
# 
# 
#         ON ACTION datarefresh   # 重新整理
#            INITIALIZE g_wc_filter TO NULL
#            IF cl_null(g_wc) THEN
#               LET g_wc = " 1=1"
#            END IF
# 
#            IF cl_null(g_wc2) THEN
#               LET g_wc2 = " 1=1"
#            END IF 
#        
#            CALL axcq519_browser_fill()
# 
#         #+ 此段落由子樣板qs19產生
#         #有關於sel欄位選取的action段落
#         #選擇全部
#         ON ACTION selall
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
#            FOR li_idx = 1 TO g_xcck_d.getLength()
#               LET g_xcck_d[li_idx].sel = "Y"
#            END FOR
# 
#            #add-point:ui_dialog段on action selall

#            #end add-point
# 
#         #取消全部
#         ON ACTION selnone
#            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
#            FOR li_idx = 1 TO g_xcck_d.getLength()
#               LET g_xcck_d[li_idx].sel = "N"
#            END FOR
# 
#            #add-point:ui_dialog段on action selnone

#            #end add-point
# 
#         #勾選所選資料
#         ON ACTION sel
#            FOR li_idx = 1 TO g_xcck_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_xcck_d[li_idx].sel = "Y"
#               END IF
#            END FOR
# 
#            #add-point:ui_dialog段on action sel

#            #end add-point
# 
#         #取消所選資料
#         ON ACTION unsel
#            FOR li_idx = 1 TO g_xcck_d.getLength()
#               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
#                  LET g_xcck_d[li_idx].sel = "N"
#               END IF
#            END FOR
# 
#            #add-point:ui_dialog段on action unsel

#            #end add-point
# 
# 
# 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq519_filter()
            #add-point:ON ACTION filter

            #END add-point
#            EXIT DIALOG
# 
# 
#         
#         #+ 此段落由子樣板a43產生
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
#               
#               #add-point:ON ACTION insert

#               #END add-point
#               EXIT DIALOG
#            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #ouhz 2015/3/23 add ----begin-----
               DROP TABLE axcq519_tmp;
               #創建臨時表，存放當前單身數據
               CALL axcq519_create_temp_table()        
               #把單身內容放入暫存檔，以便XG調用打印
               CALL axcq519_ins_temp()          
               LET g_param.v = "axcq519_tmp"
               CALL axcq519_x01('1=1',g_param.v)
               #ouhz 2015/3/23 add ----end-----   
               #END add-point
               EXIT DIALOG
            END IF
 
   #160617-00002#2 mod-S
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               CALL axcq519_query()
               #END add-point
               
            END IF
   #160617-00002#2 mod-E
# 
# 
#         #+ 此段落由子樣板a43產生
#         ON ACTION datainfo
#            LET g_action_choice="datainfo"
#            IF cl_auth_chk_act("datainfo") THEN
#               
#               #add-point:ON ACTION datainfo

#               #END add-point
#               EXIT DIALOG
#            END IF
# 
# 
#      
#         #主選單用ACTION
#         &include "main_menu.4gl"
#         &include "relating_action.4gl"
#         #交談指令共用ACTION
#         &include "common_action.4gl"
# 
# 
#         #add-point:查詢方案相關ACTION設定前

#         #end add-point
# 
#         ON ACTION queryplansel
#            CALL cl_dlg_qryplan_select() RETURNING ls_wc
#            #不是空條件才寫入g_wc跟重新找資料
#            IF NOT cl_null(ls_wc) THEN
#               LET g_wc = ls_wc
#               CALL axcq519_b_fill()
#            END IF
# 
#         ON ACTION qbe_select
#            LET ls_wc = ""
#            CALL cl_qbe_list("c") RETURNING ls_wc
#            IF NOT cl_null(ls_wc) THEN
#               LET g_wc = ls_wc
#               CALL axcq519_b_fill()
#            END IF
# 
#         ON ACTION qbe_save
#            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
         ON ACTION first
            CALL axcq519_fetch('F')
            
         ON ACTION previous
            CALL axcq519_fetch('P')
            
         ON ACTION jump
            CALL axcq519_fetch('/')
            
         ON ACTION next
            CALL axcq519_fetch('N')
            
         ON ACTION last
            CALL axcq519_fetch('L')
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq519_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   #end add-point
 
   #add-point:b_fill段sql_before
 
   #end add-point
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
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
 
   CALL g_xcck_d.clear()
   CALL g_xcck2_d.clear()
 
 
   #add-point:陣列清空
   LET l_xcck202_sum = 0
   LET l_xcck202a_sum = 0
   LET l_xcck202b_sum = 0
   LET l_xcck202c_sum = 0
   LET l_xcck202d_sum = 0
   LET l_xcck202e_sum = 0
   LET l_xcck202f_sum = 0
   LET l_xcck202g_sum = 0
   LET l_xcck202h_sum = 0
   LET l_xcck202_total = 0
   LET l_xcck202a_total = 0 
   LET l_xcck202b_total = 0 
   LET l_xcck202c_total = 0
   LET l_xcck202d_total = 0
   LET l_xcck202e_total = 0
   LET l_xcck202f_total = 0
   LET l_xcck202g_total = 0
   LET l_xcck202h_total = 0   
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"
 
   # b_fill段sql組成及FOREACH撰寫
   #+ 此段落由子樣板qs04產生
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #160520-00003#9-marked-S
#   LET g_sql = " SELECT  UNIQUE xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011,xcck015,xcck017,xcck044,xcck009*xcck201,xcck040,xcck042,",
#               "                xcck009*xcck282,xcck009*xcck282a,xcck009*xcck282b,xcck009*xcck282c,xcck009*xcck282d,xcck009*xcck282e,xcck009*xcck282f,xcck009*xcck282g,xcck009*xcck282h,",
#               "                xcck009*xcck202,xcck009*xcck202a,xcck009*xcck202b,xcck009*xcck202c,xcck009*xcck202d,xcck009*xcck202e,xcck009*xcck202f,xcck009*xcck202g,xcck009*xcck202h ",
#               "   FROM xcck_t",
##               "  WHERE xcckent = ? AND xcckcomp = ? AND xcck004 = ? AND xcck005 = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck020 = '401' ",  #fengmy150112 mark
#               "  WHERE xcckent = ? AND xcckcomp = ? AND xcck004 = ? AND xcck005 = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck020 = '115' ",  #fengmy150112 
#               " ORDER BY xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009 "
   #160520-00003#9-marked-E
   #160520-00003#9-mod-S
   LET g_sql = " SELECT  UNIQUE xcck002,xcck025,",
               "               (SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '"||g_enterprise||"' AND ooefl001 = xcck025 AND ooefl002 = '"||g_dlang||"') t1_ooefl003,",
               "                xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,",
               "               (SELECT imaal003 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t2_imaal003,",
               "               (SELECT imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t2_imaal004,",
               "                xcck011,xcck015,",
               "               (SELECT inayl003 FROM inayl_t WHERE inaylent = '"||g_enterprise||"' AND inayl001 = xcck015 AND inayl002 = '"||g_dlang||"') t3_inayl003,",
               "                xcck017,xcck044,",
               "               (SELECT oocal003 FROM oocal_t WHERE oocalent = '"||g_enterprise||"' AND oocal001 = xcck044 AND oocal002 = '"||g_dlang||"') t4_oocal003,",
               "                xcck009*xcck201,xcck040,",
               "               (SELECT ooail003 FROM ooail_t WHERE ooailent = '"||g_enterprise||"' AND ooail001 = xcck040 AND ooail002 = '"||g_dlang||"') t5_ooail003,",
               "                xcck042,",
               "                xcck009*xcck282,xcck009*xcck282a,xcck009*xcck282b,xcck009*xcck282c,xcck009*xcck282d,xcck009*xcck282e,xcck009*xcck282f,xcck009*xcck282g,xcck009*xcck282h,",
               "                xcck009*xcck202,xcck009*xcck202a,xcck009*xcck202b,xcck009*xcck202c,xcck009*xcck202d,xcck009*xcck202e,xcck009*xcck202f,xcck009*xcck202g,xcck009*xcck202h ",
               "   FROM xcck_t",
               "  WHERE xcckent = ? AND xcckcomp = ? AND xcck004 = ? AND xcck005 = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck020 = '115' "  #fengmy150112 
   
   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   LET g_sql = g_sql," AND ",g_wc_filter CLIPPED ,        #160617-00002#2 add          
               " ORDER BY xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009 "
   #160520-00003#9-mod-E
   #add-point:b_fill段sql_after
   LET g_sql_tmp = g_sql  #by ouhz add 2015/03/25
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq519_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq519_pb
 
   OPEN b_fill_curs USING g_enterprise,g_master.xcckcomp,g_master.xcck004,g_master.xcck005,g_master.xcckld,g_master.xcck001,g_master.xcck003
   #160520-00003#9-mod-S
   FOREACH b_fill_curs INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck025_desc,g_xcck_d[l_ac].xcck021,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,
                            g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1,g_xcck_d[l_ac].xcck011,
                            g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck015_desc,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck044_desc,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040,g_xcck_d[l_ac].xcck040_desc,g_xcck_d[l_ac].xcck042,
   #160520-00003#9-mod-E
   #160520-00003#9-marked-S
#   FOREACH b_fill_curs INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck021,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,
#                            g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,
#                            g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040,g_xcck_d[l_ac].xcck042,
   #160520-00003#9-marked-E
                            g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,g_xcck_d[l_ac].xcck282d,
                            g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,g_xcck_d[l_ac].xcck282h,
                            g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,g_xcck_d[l_ac].xcck202d,
                            g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,g_xcck_d[l_ac].xcck202h
                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充
      #160520-00003#9-marked-S
#      CALL s_desc_get_item_desc(g_xcck_d[l_ac].xcck010) RETURNING g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck010_desc_1 
#      CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
#         
#      CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck_d[l_ac].xcck040
#      CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck_d[l_ac].xcck040_desc = '', g_rtn_fields[1] , ''
#      
#      CALL s_desc_get_department_desc(g_xcck_d[l_ac].xcck025) RETURNING g_xcck_d[l_ac].xcck025_desc
      #160520-00003#9-marked-S
      
      #依成本域、成本中心、理由码小计
      LET l_xcck202_sum = l_xcck202_sum + g_xcck_d[l_ac].xcck202
      LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
      LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
      LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
      LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
      LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
      LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
      LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
      LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
      LET l_xcck202_total = l_xcck202_total + g_xcck_d[l_ac].xcck202
      LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
      LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
      LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202e
      LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
      LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
      LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
      LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
      LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
      IF l_ac > 1 THEN
         IF g_xcck_d[l_ac].xcck002 != g_xcck_d[l_ac - 1].xcck002 OR g_xcck_d[l_ac].xcck025 != g_xcck_d[l_ac - 1].xcck025 OR g_xcck_d[l_ac].xcck021 != g_xcck_d[l_ac - 1].xcck021 THEN   
            #把当前行下移，并在当前行显示小计
            LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
            INITIALIZE  g_xcck_d[l_ac].* TO NULL
            #fengmy 150112 modify--begin
#            LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
            CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
            IF g_para_data = 'Y' THEN
               LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)                    
            ELSE
               LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)                
            END IF
            #fengmy 150112 modify--begin
            LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum - g_xcck_d[l_ac + 1].xcck202
            LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
            LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
            LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
            LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
            LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
            LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
            LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
            LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
            LET l_ac = l_ac + 1
            LET l_xcck202_sum = g_xcck_d[l_ac].xcck202
            LET l_xcck202a_sum = g_xcck_d[l_ac].xcck202a
            LET l_xcck202b_sum = g_xcck_d[l_ac].xcck202b
            LET l_xcck202c_sum = g_xcck_d[l_ac].xcck202c
            LET l_xcck202d_sum = g_xcck_d[l_ac].xcck202d
            LET l_xcck202e_sum = g_xcck_d[l_ac].xcck202e
            LET l_xcck202f_sum = g_xcck_d[l_ac].xcck202f
            LET l_xcck202g_sum = g_xcck_d[l_ac].xcck202g
            LET l_xcck202h_sum = g_xcck_d[l_ac].xcck202h
         END IF
      END IF
      #end add-point
 
      CALL axcq519_detail_show("'1'")
 
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
 
   CALL g_xcck_d.deleteElement(g_xcck_d.getLength()) 
 
 
 
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
 
   #add-point:陣列長度調整
   #最后一组小计
   #fengmy 150112 modify--begin
#   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
   CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)                    
   ELSE
      LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)                
   END IF
   #fengmy 150112 modify--begin
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_sum
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum
   LET l_ac = l_ac + 1
   #合计
   #fengmy 150112 modify--begin
#   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)
   CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)                    
   ELSE
      LET g_xcck_d[l_ac].xcck025 = cl_getmsg("axc-00204",g_lang)                
   END IF
   #fengmy 150112 modify--begin
   LET g_xcck_d[l_ac].xcck202 = l_xcck202_total
   LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
   #end add-point
 
#   LET g_error_show = 0
# 
#   LET g_detail_cnt = l_ac - 1
#   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #+ 此段落由子樣板qs06產生
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axcq519_pb
 
   
   
 
 
   LET l_ac = 1
   CALL axcq519_b_fill2()
 
      CALL axcq519_filter_show('xcck002','b_xcck002')
   CALL axcq519_filter_show('xcck006','b_xcck006')
   CALL axcq519_filter_show('xcck007','b_xcck007')
   CALL axcq519_filter_show('xcck008','b_xcck008')
   CALL axcq519_filter_show('xcck009','b_xcck009')
   CALL axcq519_filter_show('xcck013','b_xcck013')
   CALL axcq519_filter_show('xcck010','b_xcck010')
   CALL axcq519_filter_show('xcck011','b_xcck011')
   CALL axcq519_filter_show('xcck015','b_xcck015')
   CALL axcq519_filter_show('xcck017','b_xcck017')
   CALL axcq519_filter_show('imag014','b_imag014')
   CALL axcq519_filter_show('xcck201','b_xcck201')
   CALL axcq519_filter_show('xcck040','b_xcck040')
   CALL axcq519_filter_show('xcck042','b_xcck042')
   CALL axcq519_filter_show('xcck282','b_xcck282')
   CALL axcq519_filter_show('xcck202','b_xcck202')
   CALL axcq519_filter_show('xcck025','b_xcck025')
   CALL axcq519_filter_show('xcck021','b_xcck021')
   CALL axcq519_filter_show('xcckld','b_xcckld')
   CALL axcq519_filter_show('xcck001','b_xcck001')
   CALL axcq519_filter_show('xcck003','b_xcck003')
   CALL axcq519_filter_show('xcck004','b_xcck004')
   CALL axcq519_filter_show('xcck005','b_xcck005')
   CALL axcq519_filter_show('xcck010_1','b_xcck010_1')
   CALL axcq519_filter_show('xcck011_1','b_xcck011_1')
   CALL axcq519_filter_show('xcck201_1','b_xcck201_1')
   CALL axcq519_filter_show('xcck202_1','b_xcck202_1')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq519_b_fill2()
   DEFINE li_ac           LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:b_fill2段define
   DEFINE l_xcck202_sum      LIKE xcck_t.xcck202
   DEFINE l_xcck202a_sum     LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum     LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum     LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum     LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum     LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum     LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum     LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum     LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total    LIKE xcck_t.xcck202
   DEFINE l_xcck202a_total   LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total   LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total   LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total   LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total   LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total   LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total   LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total   LIKE xcck_t.xcck202h
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #+ 此段落由子樣板qs07產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空
   CALL g_xcck2_d.clear()
   #end add-point
 
 
 
 
   #add-point:陣列長度調整
   LET g_cnt = l_ac
   LET l_ac = 1
   LET l_xcck202_sum = 0
   LET l_xcck202a_sum = 0
   LET l_xcck202b_sum = 0
   LET l_xcck202c_sum = 0
   LET l_xcck202d_sum = 0
   LET l_xcck202e_sum = 0
   LET l_xcck202f_sum = 0
   LET l_xcck202g_sum = 0
   LET l_xcck202h_sum = 0
   LET l_xcck202_total = 0
   LET l_xcck202a_total = 0
   LET l_xcck202b_total = 0
   LET l_xcck202c_total = 0
   LET l_xcck202d_total = 0
   LET l_xcck202e_total = 0
   LET l_xcck202f_total = 0
   LET l_xcck202g_total = 0
   LET l_xcck202h_total = 0

   #mod--160802-00020#7 By shiun--(S)
#   #160520-00003#9-mod-S
#   LET g_sql = " SELECT xcck002,xcck025,xcck021,xcck010,xcck011,xcck044,SUM(xcck009*xcck201),",
#   LET g_sql = " SELECT xcck002,xcck025,xcck021,xcck010,",
#               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t1_imaal003,",
#               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t1_imaal004,",
#               "        xcck011,xcck044,SUM(xcck009*xcck201),",
#   #160520-00003#9-mod-E
#               "        SUM(xcck009*xcck202),SUM(xcck009*xcck202a),SUM(xcck009*xcck202b),SUM(xcck009*xcck202c),",
#               "        SUM(xcck009*xcck202d),SUM(xcck009*xcck202e),SUM(xcck009*xcck202f),SUM(xcck009*xcck202g),SUM(xcck009*xcck202h) ",
#               "   FROM xcck_t ",
#               "  WHERE xcckent = ? AND xcckcomp = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck004 = ? AND xcck005 = ? AND xcck020 = '115' ",
#               " GROUP BY xcck002,xcck025,xcck021,xcck009,xcck010,xcck011,xcck044 ",
#               " ORDER BY xcck002,xcck025,xcck021,xcck009,xcck010,xcck011,xcck044 "
   LET g_sql = " SELECT xcck002,xcck025,xcck021,xcck010,",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t1_imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = '"||g_enterprise||"' AND imaal001 = xcck010 AND imaal002 = '"||g_dlang||"') t1_imaal004,",
               "        xcck011,xcck044,SUM(xcck009*xcck201),",
               "        SUM(xcck009*xcck202),SUM(xcck009*xcck202a),SUM(xcck009*xcck202b),SUM(xcck009*xcck202c),",
               "        SUM(xcck009*xcck202d),SUM(xcck009*xcck202e),SUM(xcck009*xcck202f),SUM(xcck009*xcck202g),SUM(xcck009*xcck202h) ",
               "   FROM xcck_t ",
               "  WHERE xcckent = ? AND xcckcomp = ? AND xcckld = ? AND xcck001 = ? AND xcck003 = ? AND xcck004 = ? AND xcck005 = ? AND xcck020 = '115' "
    IF NOT cl_null(g_wc_cs_ld) THEN
       LET g_sql = g_sql ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   LET g_sql = g_sql , " GROUP BY xcck002,xcck025,xcck021,xcck009,xcck010,xcck011,xcck044 ",
                       " ORDER BY xcck002,xcck025,xcck021,xcck009,xcck010,xcck011,xcck044 "
   #mod--160802-00020#7 By shiun--(E)
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq519_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR axcq519_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_master.xcckcomp,g_master.xcckld,g_master.xcck001,g_master.xcck003,g_master.xcck004,g_master.xcck005
 
   FOREACH b_fill_curs2 INTO g_xcck2_d[l_ac].xcck002,g_xcck2_d[l_ac].xcck025,g_xcck2_d[l_ac].xcck021,g_xcck2_d[l_ac].xcck010,
                             g_xcck2_d[l_ac].xcck010_2_desc,g_xcck2_d[l_ac].xcck010_2_desc_1,      #160520-00003#9-add
                             g_xcck2_d[l_ac].xcck011,g_xcck2_d[l_ac].xcck044,g_xcck2_d[l_ac].xcck201,
                             g_xcck2_d[l_ac].xcck202,g_xcck2_d[l_ac].xcck202a,g_xcck2_d[l_ac].xcck202b,g_xcck2_d[l_ac].xcck202c,g_xcck2_d[l_ac].xcck202d,g_xcck2_d[l_ac].xcck202e,g_xcck2_d[l_ac].xcck202f,g_xcck2_d[l_ac].xcck202g,g_xcck2_d[l_ac].xcck202h
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #160520-00003#9-marked-S
#      CALL s_desc_get_item_desc(g_xcck2_d[l_ac].xcck010) RETURNING g_xcck2_d[l_ac].xcck010_2_desc,g_xcck2_d[l_ac].xcck010_2_desc_1 
      #160520-00003#9-marked-E
      #依成本域、成本中心、理由码小计
      LET l_xcck202_sum = l_xcck202_sum + g_xcck2_d[l_ac].xcck202
      LET l_xcck202a_sum = l_xcck202a_sum + g_xcck2_d[l_ac].xcck202a
      LET l_xcck202b_sum = l_xcck202b_sum + g_xcck2_d[l_ac].xcck202b
      LET l_xcck202c_sum = l_xcck202c_sum + g_xcck2_d[l_ac].xcck202c
      LET l_xcck202d_sum = l_xcck202d_sum + g_xcck2_d[l_ac].xcck202d
      LET l_xcck202e_sum = l_xcck202e_sum + g_xcck2_d[l_ac].xcck202e
      LET l_xcck202f_sum = l_xcck202f_sum + g_xcck2_d[l_ac].xcck202f
      LET l_xcck202g_sum = l_xcck202g_sum + g_xcck2_d[l_ac].xcck202g
      LET l_xcck202h_sum = l_xcck202h_sum + g_xcck2_d[l_ac].xcck202h
      LET l_xcck202_total = l_xcck202_total + g_xcck2_d[l_ac].xcck202
      LET l_xcck202a_total = l_xcck202a_total + g_xcck2_d[l_ac].xcck202a
      LET l_xcck202b_total = l_xcck202b_total + g_xcck2_d[l_ac].xcck202b
      LET l_xcck202c_total = l_xcck202c_total + g_xcck2_d[l_ac].xcck202c
      LET l_xcck202d_total = l_xcck202d_total + g_xcck2_d[l_ac].xcck202d
      LET l_xcck202e_total = l_xcck202e_total + g_xcck2_d[l_ac].xcck202e
      LET l_xcck202f_total = l_xcck202f_total + g_xcck2_d[l_ac].xcck202f
      LET l_xcck202g_total = l_xcck202g_total + g_xcck2_d[l_ac].xcck202g
      LET l_xcck202h_total = l_xcck202h_total + g_xcck2_d[l_ac].xcck202h
      IF l_ac > 1 THEN
         IF g_xcck2_d[l_ac].xcck002 != g_xcck2_d[l_ac - 1].xcck002 OR g_xcck2_d[l_ac].xcck025 != g_xcck2_d[l_ac - 1].xcck025 OR g_xcck2_d[l_ac].xcck021 != g_xcck2_d[l_ac - 1].xcck021 THEN   
            #把当前行下移，并在当前行显示小计
            LET g_xcck2_d[l_ac + 1].* = g_xcck2_d[l_ac].*  
            INITIALIZE  g_xcck2_d[l_ac].* TO NULL              
            LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
            #fengmy 150112 modify--begin
#            LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
            CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
            IF g_para_data = 'Y' THEN
               LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)                    
            ELSE
               LET g_xcck2_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)                
            END IF
            #fengmy 150112 modify--begin
            LET g_xcck2_d[l_ac].xcck202 = l_xcck202_sum - g_xcck2_d[l_ac + 1].xcck202
            LET g_xcck2_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck2_d[l_ac + 1].xcck202a
            LET g_xcck2_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck2_d[l_ac + 1].xcck202b
            LET g_xcck2_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck2_d[l_ac + 1].xcck202c
            LET g_xcck2_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck2_d[l_ac + 1].xcck202d
            LET g_xcck2_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck2_d[l_ac + 1].xcck202e
            LET g_xcck2_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck2_d[l_ac + 1].xcck202f
            LET g_xcck2_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck2_d[l_ac + 1].xcck202g
            LET g_xcck2_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck2_d[l_ac + 1].xcck202h
            LET l_ac = l_ac + 1
            LET l_xcck202_sum = g_xcck2_d[l_ac].xcck202
            LET l_xcck202a_sum = g_xcck2_d[l_ac].xcck202a
            LET l_xcck202b_sum = g_xcck2_d[l_ac].xcck202b
            LET l_xcck202c_sum = g_xcck2_d[l_ac].xcck202c
            LET l_xcck202d_sum = g_xcck2_d[l_ac].xcck202d
            LET l_xcck202e_sum = g_xcck2_d[l_ac].xcck202e
            LET l_xcck202f_sum = g_xcck2_d[l_ac].xcck202f
            LET l_xcck202g_sum = g_xcck2_d[l_ac].xcck202g
            LET l_xcck202h_sum = g_xcck2_d[l_ac].xcck202h
         END IF
      END IF
      
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
   CALL g_xcck2_d.deleteElement(g_xcck2_d.getLength())   
   #最后一组小计
   #fengmy 150112 modify--begin
#   LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
   CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)                    
   ELSE
      LET g_xcck2_d[l_ac].xcck025 = cl_getmsg("axc-00205",g_lang)                
   END IF
   #fengmy 150112 modify--begin
   LET g_xcck2_d[l_ac].xcck202 = l_xcck202_sum
   LET g_xcck2_d[l_ac].xcck202a = l_xcck202a_sum
   LET g_xcck2_d[l_ac].xcck202b = l_xcck202b_sum
   LET g_xcck2_d[l_ac].xcck202c = l_xcck202c_sum
   LET g_xcck2_d[l_ac].xcck202d = l_xcck202d_sum
   LET g_xcck2_d[l_ac].xcck202e = l_xcck202e_sum
   LET g_xcck2_d[l_ac].xcck202f = l_xcck202f_sum
   LET g_xcck2_d[l_ac].xcck202g = l_xcck202g_sum
   LET g_xcck2_d[l_ac].xcck202h = l_xcck202h_sum
   LET l_ac = l_ac + 1
   #合计
   #fengmy 150112 modify--begin
#   LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)
   CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   IF g_para_data = 'Y' THEN
      LET g_xcck2_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)                    
   ELSE
      LET g_xcck2_d[l_ac].xcck025 = cl_getmsg("axc-00204",g_lang)                
   END IF
   #fengmy 150112 modify--begin
   LET g_xcck2_d[l_ac].xcck202 = l_xcck202_total
   LET g_xcck2_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck2_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck2_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck2_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck2_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck2_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck2_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck2_d[l_ac].xcck202h = l_xcck202h_total
  
 
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   CLOSE b_fill_curs2
   FREE axcq519_pb2
   #end add-point
 
 
 
   #add-point:單身填充後

   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq519_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck015
            LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaa001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck015_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck040
            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck040_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck040_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck025
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck025_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.filter" >}
#+ 此段落由子樣板qs13產生
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq519_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
#   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)        #160617-00002#2 marked
#   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE) #160617-00002#2 marked
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xcck002,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck011,xcck015, 
          xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck202,xcck025,xcck021,xcckld,xcck001,xcck003, 
          xcck004,xcck005#,xcck010_1,xcck011_1,xcck201_1,xcck202_1   #160617-00002#2 marked
                          FROM s_detail1[1].b_xcck002,s_detail1[1].b_xcck006,s_detail1[1].b_xcck007, 
                              s_detail1[1].b_xcck008,s_detail1[1].b_xcck009,s_detail1[1].b_xcck013,s_detail1[1].b_xcck010, 
                              s_detail1[1].b_xcck011,s_detail1[1].b_xcck015,s_detail1[1].b_xcck017,s_detail1[1].b_xcck044, 
                              s_detail1[1].b_xcck201,s_detail1[1].b_xcck040,s_detail1[1].b_xcck042,s_detail1[1].b_xcck282, 
                              s_detail1[1].b_xcck202,s_detail1[1].b_xcck025,s_detail1[1].b_xcck021,s_detail1[1].b_xcckld, 
                              s_detail1[1].b_xcck001,s_detail1[1].b_xcck003,s_detail1[1].b_xcck004,s_detail1[1].b_xcck005#, #160617-00002#2 marked
#                              s_detail2[1].b_xcck010_1,s_detail2[1].b_xcck011_1,s_detail2[1].b_xcck201_1, #160617-00002#2 marked
#                              s_detail2[1].b_xcck202_1   #160617-00002#2 marked
 
         BEFORE CONSTRUCT
#            CALL cl_qbe_init()   
                     DISPLAY axcq519_filter_parser('xcck002') TO s_detail1[1].b_xcck002
            DISPLAY axcq519_filter_parser('xcck006') TO s_detail1[1].b_xcck006
            DISPLAY axcq519_filter_parser('xcck007') TO s_detail1[1].b_xcck007
            DISPLAY axcq519_filter_parser('xcck008') TO s_detail1[1].b_xcck008
            DISPLAY axcq519_filter_parser('xcck009') TO s_detail1[1].b_xcck009
            DISPLAY axcq519_filter_parser('xcck013') TO s_detail1[1].b_xcck013
            DISPLAY axcq519_filter_parser('xcck010') TO s_detail1[1].b_xcck010
            DISPLAY axcq519_filter_parser('xcck011') TO s_detail1[1].b_xcck011
            DISPLAY axcq519_filter_parser('xcck015') TO s_detail1[1].b_xcck015
            DISPLAY axcq519_filter_parser('xcck017') TO s_detail1[1].b_xcck017
            DISPLAY axcq519_filter_parser('imag014') TO s_detail1[1].b_imag014
            DISPLAY axcq519_filter_parser('xcck201') TO s_detail1[1].b_xcck201
            DISPLAY axcq519_filter_parser('xcck040') TO s_detail1[1].b_xcck040
            DISPLAY axcq519_filter_parser('xcck042') TO s_detail1[1].b_xcck042
            DISPLAY axcq519_filter_parser('xcck282') TO s_detail1[1].b_xcck282
            DISPLAY axcq519_filter_parser('xcck202') TO s_detail1[1].b_xcck202
            DISPLAY axcq519_filter_parser('xcck025') TO s_detail1[1].b_xcck025
            DISPLAY axcq519_filter_parser('xcck021') TO s_detail1[1].b_xcck021
            DISPLAY axcq519_filter_parser('xcckld') TO s_detail1[1].b_xcckld
            DISPLAY axcq519_filter_parser('xcck001') TO s_detail1[1].b_xcck001
            DISPLAY axcq519_filter_parser('xcck003') TO s_detail1[1].b_xcck003
            DISPLAY axcq519_filter_parser('xcck004') TO s_detail1[1].b_xcck004
            DISPLAY axcq519_filter_parser('xcck005') TO s_detail1[1].b_xcck005
#            DISPLAY axcq519_filter_parser('xcck010_1') TO s_detail2[1].b_xcck010_1 #160617-00002#2 marked
#            DISPLAY axcq519_filter_parser('xcck011_1') TO s_detail2[1].b_xcck011_1 #160617-00002#2 marked
#            DISPLAY axcq519_filter_parser('xcck201_1') TO s_detail2[1].b_xcck201_1 #160617-00002#2 marked
#            DISPLAY axcq519_filter_parser('xcck202_1') TO s_detail2[1].b_xcck202_1 #160617-00002#2 marked
         #160617-00002#2 add-S
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck002  #顯示到畫面上            
            NEXT FIELD xcck002                     #返回原欄位
            #END add-point
        
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inbastus = 'S'"
            CALL q_inbadocno_2()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck006  #顯示到畫面上            
            NEXT FIELD xcck006                     #返回原欄位
            
            #END add-point
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            #END add-point
 
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck011  #顯示到畫面上
            NEXT FIELD xcck011                     #返回原欄位
            
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位
            #END add-point
            
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck044  #顯示到畫面上
            NEXT FIELD xcck044                     #返回原欄位
         #160617-00002#2 add-E
 
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
      LET g_wc = g_wc_t
   END IF
   
   CALL axcq519_filter_show('xcck002','b_xcck002')
   CALL axcq519_filter_show('xcck006','b_xcck006')
   CALL axcq519_filter_show('xcck007','b_xcck007')
   CALL axcq519_filter_show('xcck008','b_xcck008')
   CALL axcq519_filter_show('xcck009','b_xcck009')
   CALL axcq519_filter_show('xcck013','b_xcck013')
   CALL axcq519_filter_show('xcck010','b_xcck010')
   CALL axcq519_filter_show('xcck011','b_xcck011')
   CALL axcq519_filter_show('xcck015','b_xcck015')
   CALL axcq519_filter_show('xcck017','b_xcck017')
   CALL axcq519_filter_show('imag014','b_imag014')
   CALL axcq519_filter_show('xcck201','b_xcck201')
   CALL axcq519_filter_show('xcck040','b_xcck040')
   CALL axcq519_filter_show('xcck042','b_xcck042')
   CALL axcq519_filter_show('xcck282','b_xcck282')
   CALL axcq519_filter_show('xcck202','b_xcck202')
   CALL axcq519_filter_show('xcck025','b_xcck025')
   CALL axcq519_filter_show('xcck021','b_xcck021')
   CALL axcq519_filter_show('xcckld','b_xcckld')
   CALL axcq519_filter_show('xcck001','b_xcck001')
   CALL axcq519_filter_show('xcck003','b_xcck003')
   CALL axcq519_filter_show('xcck004','b_xcck004')
   CALL axcq519_filter_show('xcck005','b_xcck005')
#   CALL axcq519_filter_show('xcck010_1','b_xcck010_1')   #160617-00002#2 marked
#   CALL axcq519_filter_show('xcck011_1','b_xcck011_1')   #160617-00002#2 marked
#   CALL axcq519_filter_show('xcck201_1','b_xcck201_1')   #160617-00002#2 marked
#   CALL axcq519_filter_show('xcck202_1','b_xcck202_1')   #160617-00002#2 marked
#   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)   #160617-00002#2 marked
#   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE) #160617-00002#2 marked
 
   CALL axcq519_b_fill()
   CALL axcq519_show()  #160617-00002#2 add
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.filter_parser" >}
#+ 此段落由子樣板qs14產生
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq519_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10  #161108-00012#4 num5==》num10
   DEFINE li_tmp2    LIKE type_t.num10  #161108-00012#4 num5==》num10
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
 
{</section>}
 
{<section id="axcq519.filter_show" >}
#+ 此段落由子樣板qs15產生
#+ 標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq519_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axcq519_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq519.other_function" readonly="Y" >}

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
PRIVATE FUNCTION axcq519_browser_fill()
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING   
 
   #清除畫面
   CLEAR FORM                
   CALL g_xcck_d.clear()        
   CALL g_xcck2_d.clear() 
 
   CALL g_browser.clear()
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   IF cl_null(g_wc) THEN
      LET g_wc = " xcck020 = '115' "
   ELSE
      LET g_wc = g_wc," AND xcck020 = '115' "
   END IF 
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()

   #add--160802-00020#7 By shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc = g_wc ," AND xcckld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc = g_wc ," AND xcckcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 By shiun--(E)
   
   LET l_sub_sql = " SELECT DISTINCT xcckcomp,xcck004,xcck005,xcckld,xcck001,xcck003 ",
                   "   FROM xcck_t ",
                   "  WHERE ",g_wc," AND ",g_wc2,
                   "  ORDER BY xcckcomp,xcck004,xcck005,xcckld,xcck001,xcck003 "
                   
#   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
#   
#   
#   PREPARE header_cnt_pre FROM g_sql
#   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
#   FREE header_cnt_pre
# 
#   IF g_browser_cnt > g_max_rec THEN
#      IF g_error_show = 1 THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = g_browser_cnt
#         LET g_errparam.code   = 9035 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#      END IF
#      LET g_browser_cnt = g_max_rec
#   END IF
#   
#   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   LET g_sql = l_sub_sql
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].xcckcomp,g_browser[g_cnt].xcck004,g_browser[g_cnt].xcck005,
                           g_browser[g_cnt].xcckld,g_browser[g_cnt].xcck001,g_browser[g_cnt].xcck003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
  

      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_browser.getlength())
   LET g_browser_cnt = g_browser.getLength()
 
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   CALL axcq519_fetch('F')

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
PRIVATE FUNCTION axcq519_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
    
   
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF
   
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
         #IF g_current_idx < g_header_cnt THEN     #160523-00014#1 mark 
         IF g_current_idx < g_browser.getLength() THEN  #160523-00014#1 add
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
   
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
     
   #重讀DB,因TEMP有不被更新特性
#这只特殊，刷新db，正常应该值没变
   EXECUTE axcq519_master_referesh USING g_enterprise,g_browser[g_browser_idx].xcckcomp,g_browser[g_browser_idx].xcckld,g_browser[g_browser_idx].xcck001,
                                         g_browser[g_browser_idx].xcck003,g_browser[g_browser_idx].xcck004,g_browser[g_browser_idx].xcck005
                                   INTO g_master.xcckcomp,g_master.xcck004,g_master.xcck005,
                                        g_master.xcckld,g_master.xcck001,g_master.xcck003
   #重新顯示   
   CALL axcq519_show()
 
 
 
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
PRIVATE FUNCTION axcq519_show()
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #fengmy 150112----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_master.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_master.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF                
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',FALSE)                
   END IF 
              
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',FALSE)                
   END IF   
   #fengmy 150112----end
 
   DISPLAY BY NAME g_master.xcckcomp,g_master.xcck004,g_master.xcck005,g_master.xcckld,g_master.xcck001,g_master.xcck003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckcomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckld_desc
   
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xcckld
      
      
   CASE g_master.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''
                       
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''  
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''  
   END CASE
   DISPLAY BY NAME g_master.xcck001_desc
              
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcck003_desc

   CALL axcq519_b_fill()
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
PRIVATE FUNCTION axcq519_set_cs_default()
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020 

   IF g_master.xcckcomp IS NULL THEN 
      CALL s_axc_set_site_default() RETURNING g_master.xcckcomp,g_master.xcckld,g_master.xcck004,g_master.xcck005,g_master.xcck003
   END IF
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcckld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.xcck003_desc
      
   LET g_master.xcck001 = '1'
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xcckld
      
      
   CASE g_master.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_master.xcck001_desc                   
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_master.xcck001_desc  
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xcck001_desc = '', g_rtn_fields[1] , ''
        DISPLAY BY NAME g_master.xcck001_desc  
   END CASE
   
   DISPLAY BY NAME g_master.xcckcomp,g_master.xcck004,g_master.xcck005,g_master.xcckld,g_master.xcck001,g_master.xcck003
END FUNCTION

################################################################################
# Descriptions...: 創建暫存檔
# Memo...........:
# Date & Author..: 2015/3/25 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq519_create_temp_table()
DROP TABLE axcq519_tmp;
   CREATE TEMP TABLE axcq519_tmp(
   xcck002          VARCHAR(30),
   xcck025          VARCHAR(10), 
   xcck025_desc     VARCHAR(100), 
   xcck021          VARCHAR(10), 
   xcck006          VARCHAR(20), 
   xcck007          INTEGER, 
   xcck008          SMALLINT, 
   xcck009          SMALLINT,
   xcck013          DATE,   
   xcck010          VARCHAR(40), 
   xcck010_desc     VARCHAR(100), 
   #xcck010_desc_1  LIKE type_t.chr100, #170316-00009#14  by 09042 mark
   xcck010_desc1    VARCHAR(100),       #170316-00009#14  by 09042 add
   xcck011          VARCHAR(256), 
   xcck015          VARCHAR(10), 
   xcck015_desc     VARCHAR(100), 
   xcck017          VARCHAR(30), 
   xcck044          VARCHAR(10), 
   xcck044_desc     VARCHAR(100), 
   xcck201          DECIMAL(20,6), 
   xcck040          VARCHAR(10), 
   xcck040_desc     VARCHAR(100), 
   xcck042          DECIMAL(20,10), 
   xcck282          DECIMAL(20,6), 
   xcck282a         DECIMAL(20,6), 
   xcck282b         DECIMAL(20,6), 
   xcck282c         DECIMAL(20,6), 
   xcck282d         DECIMAL(20,6), 
   xcck282e         DECIMAL(20,6), 
   xcck282f         DECIMAL(20,6), 
   xcck282g         DECIMAL(20,6), 
   xcck282h         DECIMAL(20,6), 
   xcck202          DECIMAL(20,6), 
   xcck202a         DECIMAL(20,6), 
   xcck202b         DECIMAL(20,6), 
   xcck202c         DECIMAL(20,6), 
   xcck202d         DECIMAL(20,6), 
   xcck202e         DECIMAL(20,6), 
   xcck202f         DECIMAL(20,6), 
   xcck202g         DECIMAL(20,6), 
   xcck202h         DECIMAL(20,6), 
   xcckcomp         VARCHAR(10), 
   xcckcomp_desc    VARCHAR(100), 
   xcck004          SMALLINT, 
   xcck001          VARCHAR(1), 
   xcck001_desc     VARCHAR(100), 
   xcckld           VARCHAR(5), 
   xcckld_desc      VARCHAR(100), 
   xcck005          SMALLINT, 
   xcck003          VARCHAR(10), 
   xcck003_desc     VARCHAR(100),
   xcckkey          VARCHAR(1000)
);
END FUNCTION

################################################################################
# Descriptions...: 將單身數據存放在暫存檔
# Date & Author..: 2015/3/25 By ouhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq519_ins_temp()
DEFINE l_cnt         LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE sr                RECORD
   xcck002         LIKE xcck_t.xcck002,
   xcck025         LIKE xcck_t.xcck025, 
   xcck025_desc    LIKE type_t.chr100, 
   xcck021         LIKE xcck_t.xcck021, 
   xcck006         LIKE xcck_t.xcck006, 
   xcck007         LIKE xcck_t.xcck007, 
   xcck008         LIKE xcck_t.xcck008, 
   xcck009         LIKE xcck_t.xcck009,
   xcck013         LIKE xcck_t.xcck013,   
   xcck010         LIKE xcck_t.xcck010, 
   xcck010_desc    LIKE type_t.chr100, 
   xcck010_desc_1  LIKE type_t.chr100, 
   xcck011         LIKE xcck_t.xcck011, 
   xcck015         LIKE xcck_t.xcck015, 
   xcck015_desc    LIKE type_t.chr100, 
   xcck017         LIKE xcck_t.xcck017, 
   xcck044         LIKE xcck_t.xcck044, 
   xcck044_desc    LIKE type_t.chr100, 
   xcck201         LIKE xcck_t.xcck201, 
   xcck040         LIKE xcck_t.xcck040, 
   xcck040_desc    LIKE type_t.chr100, 
   xcck042         LIKE xcck_t.xcck042, 
   xcck282         LIKE xcck_t.xcck282,
   xcck282a        LIKE xcck_t.xcck282a, 
   xcck282b        LIKE xcck_t.xcck282b, 
   xcck282c        LIKE xcck_t.xcck282c, 
   xcck282d        LIKE xcck_t.xcck282d, 
   xcck282e        LIKE xcck_t.xcck282e, 
   xcck282f        LIKE xcck_t.xcck282f, 
   xcck282g        LIKE xcck_t.xcck282g, 
   xcck282h        LIKE xcck_t.xcck282h, 
   xcck202         LIKE xcck_t.xcck202, 
   xcck202a        LIKE xcck_t.xcck202a, 
   xcck202b        LIKE xcck_t.xcck202b, 
   xcck202c        LIKE xcck_t.xcck202c, 
   xcck202d        LIKE xcck_t.xcck202d, 
   xcck202e        LIKE xcck_t.xcck202e, 
   xcck202f        LIKE xcck_t.xcck202f, 
   xcck202g        LIKE xcck_t.xcck202g, 
   xcck202h        LIKE xcck_t.xcck202h,    
   xcckcomp        LIKE xcck_t.xcckcomp, 
   xcckcomp_desc   LIKE type_t.chr100, 
   xcck004         LIKE xcck_t.xcck004, 
   xcck001         LIKE xcck_t.xcck001, 
   xcck001_desc    LIKE type_t.chr100, 
   xcckld          LIKE xcck_t.xcckld, 
   xcckld_desc     LIKE type_t.chr100, 
   xcck005         LIKE xcck_t.xcck005, 
   xcck003         LIKE xcck_t.xcck003, 
   xcck003_desc    LIKE type_t.chr100,
   xcckkey         LIKE type_t.chr1000
                        END RECORD
DEFINE l_i               LIKE type_t.num10  #161108-00012#4 num5==》num10
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_xcck004         LIKE type_t.chr30
DEFINE l_xcck005         LIKE type_t.chr30                        

    #刪除臨時表中資料
    DELETE FROM axcq519_tmp
    
    LET l_success = TRUE

    FOR l_i = 1 TO g_browser.getLength()
  
      LET sr.xcckcomp = g_browser[l_i].xcckcomp
      LET sr.xcck004  = g_browser[l_i].xcck004
      LET sr.xcck001  = g_browser[l_i].xcck001
      LET sr.xcckld   = g_browser[l_i].xcckld
      LET sr.xcck005  = g_browser[l_i].xcck005
      LET sr.xcck003  = g_browser[l_i].xcck003
      
      EXECUTE axcq519_master_referesh USING sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005 
      INTO  sr.xcckcomp,sr.xcck004,sr.xcck001,sr.xcckld,sr.xcck005,sr.xcck003,sr.xcckcomp_desc,
            sr.xcck001_desc,sr.xcckld_desc,sr.xcck003_desc
      LET l_xcck004=sr.xcck004
      LET l_xcck005=sr.xcck005
      LET sr.xcckkey = sr.xcckcomp,"-",sr.xcckld,"-",l_xcck004 CLIPPED,"-",l_xcck005 CLIPPED,"-",sr.xcck001 CLIPPED,"-",sr.xcck003
  
  
      #法人，账套，成本计算类型
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xcckcomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xcckcomp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xcckcomp_desc 
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xcckld
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xcckld_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xcckld_desc 
     
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = sr.xcck003
      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET sr.xcck003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME sr.xcck003_desc
       
       
       PREPARE axcq519_ins_tmp_pre FROM g_sql_tmp
       DECLARE axcq519_ins_tmp_cs CURSOR FOR axcq519_ins_tmp_pre
      
       OPEN axcq519_ins_tmp_cs USING g_enterprise,sr.xcckcomp,sr.xcck004,sr.xcck005,sr.xcckld,sr.xcck001,sr.xcck003
       
       FOREACH axcq519_ins_tmp_cs INTO sr.xcck002,sr.xcck025,sr.xcck021,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,
                                       sr.xcck011,sr.xcck015,sr.xcck017,sr.xcck044, sr.xcck201,sr.xcck040,sr.xcck042,
                                       sr.xcck282,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,sr.xcck282g,sr.xcck282h,
                                       sr.xcck202,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h
          
      
       CALL s_desc_get_stock_desc(g_site,sr.xcck015) RETURNING sr.xcck015_desc
         
       CALL s_desc_get_unit_desc(sr.xcck044) RETURNING sr.xcck044_desc
      
       CALL s_desc_get_currency_desc(sr.xcck040) RETURNING sr.xcck040_desc
      
       CALL s_desc_get_department_desc(sr.xcck025) RETURNING sr.xcck025_desc  
      
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
       LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''

       LET sr.xcck202a  = sr.xcck202a  * sr.xcck009
       LET sr.xcck202b  = sr.xcck202b  * sr.xcck009
       LET sr.xcck202c  = sr.xcck202c  * sr.xcck009
       LET sr.xcck202d  = sr.xcck202d  * sr.xcck009
       LET sr.xcck202e  = sr.xcck202e  * sr.xcck009
       LET sr.xcck202f  = sr.xcck202f  * sr.xcck009
       LET sr.xcck202g  = sr.xcck202g  * sr.xcck009
       LET sr.xcck202h  = sr.xcck202h  * sr.xcck009
      
      
       INSERT INTO axcq519_tmp #( xcck002,xcck025,xcck025_desc,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc_1,xcck011,    #170316-00009#14 by 09042 mark
                               ( xcck002,xcck025,xcck025_desc,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,xcck010_desc,xcck010_desc1,xcck011,      #170316-00009#14 by 09042 add
                                 xcck015,xcck015_desc,xcck017,xcck044,xcck044_desc,xcck201,xcck040,xcck040_desc,xcck042,xcck282,xcck282a,xcck282b,xcck282c,
                                 xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,                                
                                 xcck202h,xcckcomp,xcckcomp_desc,xcck004,xcck001,xcck001_desc,xcckld,xcckld_desc,xcck005,xcck003,xcck003_desc,xcckkey )
                        VALUES ( sr.xcck002,sr.xcck025,sr.xcck025_desc,sr.xcck021,sr.xcck006,sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,
                                 sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck015,sr.xcck015_desc,sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck201,
                                 sr.xcck040,sr.xcck040_desc,sr.xcck042,sr.xcck282,sr.xcck282a,sr.xcck282b,sr.xcck282c,sr.xcck282d,sr.xcck282e,sr.xcck282f,
                                 sr.xcck282g,sr.xcck282h,sr.xcck202,sr.xcck202a,sr.xcck202b,sr.xcck202c,sr.xcck202d,sr.xcck202e,sr.xcck202f,sr.xcck202g,sr.xcck202h,
                                 sr.xcckcomp,sr.xcckcomp_desc,sr.xcck004,sr.xcck001,sr.xcck001_desc,sr.xcckld,sr.xcckld_desc,sr.xcck005,sr.xcck003,sr.xcck003_desc,sr.xcckkey)       
      
      
      IF SQLCA.sqlcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'insert tmp'
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF   
     END FOREACH
     
     CALL cl_err_collect_show()
     IF l_success = FALSE THEN
        DELETE FROM axcq519_tmp
     END IF
      
     FREE axcq519_ins_tmp_pre
   END FOR      
    
   
END FUNCTION

################################################################################
# Date & Author..: 2016-6-27 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq519_query()
   #add-point:query段define name="query.define_customerization"

   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"

   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"

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
   INITIALIZE g_master.* TO NULL
   CALL g_xcck_d.clear()
   CALL g_xcck2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq519_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axcq519_browser_fill()
      CALL axcq519_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axcq519_browser_fill()
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axcq519_fetch("F") 
   END IF
   
   CALL axcq519_idx_chk()
   
   LET g_wc_filter = ""

END FUNCTION

################################################################################
# Date & Author..: 2016-6-27 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq519_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:ui_dialog段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_xcckcomp LIKE xcck_t.xcckcomp
   DEFINE l_xcckcomp_desc LIKE ooefl_t.ooefl003
   DEFINE l_xcckld  LIKE xcck_t.xcckld
   DEFINE l_xcckld_desc   LIKE glaal_t.glaal003
   DEFINE l_xcck001 LIKE xcck_t.xcck001
   DEFINE l_xcck001_desc  LIKE ooail_t.ooail003
   DEFINE l_xcck003 LIKE xcck_t.xcck003
   DEFINE l_xcck003_desc  LIKE xcatl_t.xcatl003
   
   
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 0
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
#  CALL cl_set_act_visible("selall,selnone,sel,unsel,insert,query", FALSE)
   CLEAR FORM                 
   INITIALIZE g_master.* TO NULL
   CALL g_xcck_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'   
  #160113-00011#2--mark--(s)
  #INITIALIZE g_master.* TO NULL
  #CALL g_xcck_d.clear()        
  #CALL g_xcck2_d.clear() 
  #INITIALIZE g_wc TO NULL
  #INITIALIZE g_wc2 TO NULL
  #160113-00011#2--mark--(e) 
  #160113-00011#2--add--(s)
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axcq519_browser_fill()
   END IF   
   #160113-00011#2--add--(e)
   #end add-point

  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落

         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc ON xcckcomp,xcck004,xcck005,xcckld,xcck001,xcck003
         
            BEFORE CONSTRUCT

            AFTER FIELD xcckcomp
               LET l_xcckcomp = GET_FLDBUF(xcckcomp)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xcckcomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xcckcomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xcckcomp_desc TO FORMONLY.xcckcomp_desc
               #fengmy 150112----begin
               #根據參數顯示隱藏成本域 和 料件特性
               IF cl_null(l_xcckcomp) THEN
                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
               ELSE
                  CALL cl_get_para(g_enterprise,l_xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
                  CALL cl_get_para(g_enterprise,l_xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
               END IF                
               IF g_para_data = 'Y' THEN
                  CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',TRUE)                    
               ELSE
                  CALL cl_set_comp_visible('b_xcck002,b_xcck002_desc,xcck002_2,xcck002_2_desc',FALSE)                
               END IF 
                          
               IF g_para_data1 = 'Y' THEN
                  CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',TRUE)                    
               ELSE
                  CALL cl_set_comp_visible('b_xcck011,b_xcck011_2',FALSE)                
               END IF   
               #fengmy 150112----end               
            AFTER FIELD xcckld
               LET l_xcckld = GET_FLDBUF(xcckld)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xcckld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xcckld_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xcckld_desc TO FORMONLY.xcckld_desc
               
            AFTER FIELD xcck001
               LET l_xcck001 = GET_FLDBUF(xcck001)
               LET l_xcckld  = GET_FLDBUF(xcckld)
               
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = l_xcckld
                  
                  
               CASE l_xcck001
                  WHEN '1' 
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa001
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''
                                   
                  WHEN '2'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa016
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''  
                  WHEN '3'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa020
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET l_xcck001_desc = '', g_rtn_fields[1] , ''  
               END CASE
               DISPLAY  l_xcck001_desc TO FORMONLY.xcck001_desc 
              
            AFTER FIELD xcck003  
               LET l_xcck003 = GET_FLDBUF(xcck003)            
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xcck003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xcck003_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xcck003_desc TO FORMONLY.xcck003_desc 
               
               
            ON ACTION controlp INFIELD xcckcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #add--160802-00020#7 By shiun--(S)
      	      #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #add--160802-00020#7 By shiun--(E)
               CALL q_ooef001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcckcomp       #顯示到畫面上
               NEXT FIELD xcckcomp                          #返回原欄位
               
               
            ON ACTION controlp INFIELD xcckld
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
               CALL q_authorised_ld()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcckld         #顯示到畫面上
               NEXT FIELD xcckld                            #返回原欄位
               
                           
            ON ACTION controlp INFIELD xcck003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcat001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xcck003        #顯示到畫面上
               NEXT FIELD xcck003                           #返回原欄位
         
         AFTER CONSTRUCT 
#            CALL axcq519_browser_fill()
#            CONTINUE DIALOG

      END CONSTRUCT
         
         
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         CALL axcq519_set_cs_default()
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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
   
   #add-point:cs段after_construct name="cs.after_construct"

   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION

################################################################################
# Date & Author..: 2016-6-27 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq519_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"

   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"

   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"

   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xcck_d.getLength() THEN
         LET g_detail_idx = g_xcck_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcck_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcck_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
 
   
   #add-point:idx_chk段other name="idx_chk.other"

   #end add-point  
   
END FUNCTION

 
{</section>}
 
