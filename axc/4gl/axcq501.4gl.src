#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq501.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000044
#+ 
#+ Filename...: axcq501
#+ Description: 在製主件成本查詢作業
#+ Creator....: 00537(2014/08/22)
#+ Modifier...: 00537(2014/08/25) -SD/PR- 00000
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq501.global" >}
#160617-00002#1   2016/06/23  By zhujing     增加串查
#160802-00020#4   2016/08/04  By dorislai    增加帳套權限管控
#160729-00022#1   2016/08/04  By xianghui    取消新增按钮
#160802-00020#10  2016/08/11  By dorislai    增加法人權限管控
#161108-00012#4   2016/11/09  By 08734       g_browser_cnt 由num5改為num10
#160617-00002#3   2016/12/12  By lixh        增加传参g_argv[9] 工单编号   
IMPORT os
IMPORT util
#add-point:增加匯入項目
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xccd_m RECORD
   xccdcomp LIKE xccd_t.xccdcomp,
   xccdcomp_desc LIKE ooefl_t.ooefl003,
   xccdld   LIKE xccd_t.xccdld,
   xccdld_desc   LIKE glaal_t.glaal002,
   xccd003  LIKE xccd_t.xccd003,
   xccd003_desc  LIKE xcatl_t.xcatl003,
   xccd004  LIKE xccd_t.xccd004,
   xccd005  LIKE xccd_t.xccd005,
   xccd006  LIKE xccd_t.xccd006,
   xccd007  LIKE xccd_t.xccd007,
   xccd007_desc  LIKE imaal_t.imaal003,
   xccd007_desc_1  LIKE imaal_t.imaal004,
   xccd008  LIKE xccd_t.xccd008,
   imag014  LIKE imag_t.imag014,
   imag014_desc  LIKE oocal_t.oocal003,
   sfaa048  LIKE sfaa_t.sfaa048,
   xcbb006  LIKE xcbb_t.xcbb006,
   sfaa042  LIKE sfaa_t.sfaa042,
   xccd002  LIKE xccd_t.xccd002,
   xccd002_desc    LIKE xcbfl_t.xcbfl003,
   xccd010  LIKE xccd_t.xccd010,
   xccd200  LIKE xccd_t.xccd200
     END RECORD
PRIVATE TYPE type_g_xccd_d RECORD
       #statepic       LIKE type_t.chr1,
       
       item LIKE type_t.chr80, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd102a LIKE xccd_t.xccd102a, 
   xccd202a LIKE xccd_t.xccd202a, 
   xccd204a LIKE xccd_t.xccd204a, 
   xccd302a LIKE xccd_t.xccd302a, 
   xccd304a LIKE xccd_t.xccd304a, 
   xccd902a LIKE xccd_t.xccd902a, 
   xccdld LIKE xccd_t.xccdld, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd006 LIKE xccd_t.xccd006 
       END RECORD
PRIVATE TYPE type_g_xccd2_d RECORD
       item2 LIKE type_t.chr80, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd102b LIKE xccd_t.xccd102b, 
   xccd202b LIKE xccd_t.xccd202b, 
   xccd204b LIKE xccd_t.xccd204b, 
   xccd302b LIKE xccd_t.xccd302b, 
   xccd304b LIKE xccd_t.xccd304b, 
   xccd902b LIKE xccd_t.xccd902b, 
   xccdld LIKE xccd_t.xccdld, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd006 LIKE xccd_t.xccd006
       END RECORD
 
PRIVATE TYPE type_g_xccd3_d RECORD
       item3 LIKE type_t.chr80, 
   xccd001 LIKE xccd_t.xccd001, 
   xccd102c LIKE xccd_t.xccd102c, 
   xccd202c LIKE xccd_t.xccd202c, 
   xccd204c LIKE xccd_t.xccd204c, 
   xccd302c LIKE xccd_t.xccd302c, 
   xccd304c LIKE xccd_t.xccd304c, 
   xccd902c LIKE xccd_t.xccd902c, 
   xccdld LIKE xccd_t.xccdld, 
   xccd002 LIKE xccd_t.xccd002, 
   xccd003 LIKE xccd_t.xccd003, 
   xccd004 LIKE xccd_t.xccd004, 
   xccd005 LIKE xccd_t.xccd005, 
   xccd006 LIKE xccd_t.xccd006
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xccd_m
DEFINE g_master_t                   type_g_xccd_m
DEFINE g_xccd_d          DYNAMIC ARRAY OF type_g_xccd_d
DEFINE g_xccd_d_t        type_g_xccd_d
DEFINE g_xccd2_d   DYNAMIC ARRAY OF type_g_xccd2_d
DEFINE g_xccd2_d_t type_g_xccd2_d
 
DEFINE g_xccd3_d   DYNAMIC ARRAY OF type_g_xccd3_d
DEFINE g_xccd3_d_t type_g_xccd3_d
 
 
      
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
DEFINE l_ac_d               LIKE type_t.num10   #161108-00012#4 num5==》num10           #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
#DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_page       LIKE type_t.num10              #目前所在頁數   #161108-00012#4  2016/11/09 By 08734 add
#DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)   #161108-00012#4  2016/11/09 By 08734 add
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
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數   #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數   #161108-00012#4  2016/11/09 By 08734 add
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數  #161108-00012#4  2016/11/09 By 08734 mark
DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#4  2016/11/09 By 08734 add
DEFINE g_current_idx         LIKE type_t.num10              #Browser所在筆數  #161108-00012#4 num5==》num10
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_glaa015             LIKE glaa_t.glaa015           #启用第二货币
DEFINE g_glaa019             LIKE glaa_t.glaa019           #启用第三货币
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
         xccdent   LIKE xccd_t.xccdent,
         xccdld    LIKE xccd_t.xccdld,
         xccd002   LIKE xccd_t.xccd002,
         xccd003   LIKE xccd_t.xccd003,
         xccd004   LIKE xccd_t.xccd004,
         xccd005   LIKE xccd_t.xccd005,
         xccd006   LIKE xccd_t.xccd006
      END RECORD
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150112
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150112
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="axcq501.main" >}
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
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
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
   DECLARE axcq501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
 
   #end add-point
   PREPARE axcq501_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq501_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq501 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq501_init()   
 
      #進入選單 Menu (="N")
      CALL axcq501_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq501
      
   END IF 
   
   CLOSE axcq501_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq501.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq501_init()
   #add-point:init段define
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   #fengmy 150112----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
   END IF 
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否            
#150806-00012#1----begin   
   #IF g_para_data1 = 'Y' THEN
   #   CALL cl_set_comp_visible('xccd008',TRUE)                    
   #ELSE
   #   CALL cl_set_comp_visible('xccd008',FALSE)                
   #END IF
#150806-00012#1----end   
   #fengmy 150112----end
   #end add-point
 
   CALL axcq501_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq501.default_search" >}
PRIVATE FUNCTION axcq501_default_search()
 
   #預設查詢條件
   LET g_wc = cl_qbe_get_default_qryplan()
   
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," xccdcomp = '",g_argv[01],"' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc," xccdld = '",g_argv[02],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc," xccd003 = '",g_argv[03],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc," xccd004 = '",g_argv[04],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc," xccd005 = '",g_argv[05],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc," xccd007 = '",g_argv[06],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc," xccd008 = '",g_argv[07],"' AND "
   END IF
 
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc," xccd002 = '",g_argv[08],"' AND "
   END IF
   #160617-00002#3 add-S
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc," xccd006 = '",g_argv[09],"' AND "
   END IF
   #160617-00002#3 add-E
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #若無外部參數則預設為1=2
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   IF cl_null(g_wc2) THEN LET g_wc2 = ' 1=1' END IF
   
END FUNCTION
 
{</section>}
 
{<section id="axcq501.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq501_ui_dialog()
   DEFINE ls_wc    STRING
   DEFINE li_idx   LIKE type_t.num10  #161108-00012#4 num5==》num10
   #add-point:ui_dialog段define
   DEFINE la_param  RECORD
                    prog   STRING,
                    param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 
   
   #end add-point
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=1" THEN
      CALL axcq501_browser_fill()
      CALL axcq501_fetch("F")
      CALL axcq501_b_fill()
   ELSE
      CALL axcq501_query()
   END IF
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xccd_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xccd_d.getLength() TO FORMONLY.cnt
               CALL axcq501_fetch('')
               LET g_master_idx = l_ac
               #add-point:input段before row
 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
         DISPLAY ARRAY g_xccd2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xccd2_d.getLength() TO FORMONLY.cnt
               CALL axcq501_fetch('')
               LET g_master_idx = l_ac
               #add-point:input段before row
 
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
               
         END DISPLAY
 
         DISPLAY ARRAY g_xccd3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_xccd3_d.getLength() TO FORMONLY.cnt
               CALL axcq501_fetch('')
               LET g_master_idx = l_ac
               #add-point:input段before row
 
               #end add-point  
 
            #自訂ACTION(detail_show,page_3)
            
               
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            #151130-00003#4 20151207 add by ming -----(S) 
            #此程式不需要二次篩選
            CALL cl_set_act_visible("filter",FALSE)
            #151130-00003#4 20151207 add by ming -----(E) 
            CALL cl_set_act_visible("insert", FALSE)   #160729-00022#1
            #end add-point
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axcq501_insert()
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
               CALL axcq501_query()
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
            CALL axcq501_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq501_b_fill()
            END IF
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
      #  ON ACTION qbeclear   # 條件清除
      #     CLEAR FORM
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL axcq501_b_fill()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
 
         
         
 
         #add-point:ui_dialog段自定義action
         ON ACTION first
            CALL axcq501_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION previous
            CALL axcq501_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION jump
            CALL axcq501_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION next
            CALL axcq501_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION last
            CALL axcq501_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            
         ON ACTION call_axcq502 
            LET la_param.prog     = "axcq502"
            LET la_param.param[1] = g_master.xccdcomp
            LET la_param.param[2] = g_master.xccdld
            LET la_param.param[3] = g_master.xccd003
            LET la_param.param[4] = g_master.xccd004
            LET la_param.param[5] = g_master.xccd005
#            LET la_param.param[6] = g_master.xccd007   #fengmy mark 150112
            LET la_param.param[6] = g_master.xccd006    #fengmy 150112   #用单号
            LET la_param.param[7] = g_master.xccd002
            LET ls_js = util.JSON.stringify( la_param )
            CALL cl_cmdrun(ls_js)
            
         #160617-00002#1 add-S
         ON ACTION call_axcq202 
            LET la_param.prog     = "axcq202"
            LET la_param.param[1] = g_master.xccdld      #账套
            LET la_param.param[2] = g_master.xccd003     #成本计算类型
            LET la_param.param[3] = g_master.xccd004     #年度
            LET la_param.param[4] = g_master.xccd005     #期别
            LET la_param.param[5] = NULL                 #成本中心
            LET la_param.param[6] = NULL                 #费用分类
            LET la_param.param[7] = g_master.xccd006     #工单编号
            LET la_param.param[8] = NULL                 #分摊方式
            LET ls_js = util.JSON.stringify( la_param )
            CALL cl_cmdrun(ls_js)
            
         ON ACTION call_axcq528
            LET la_param.prog     = "axcq528"
            LET la_param.param[1] = NULL
            LET la_param.param[2] = NULL
            LET la_param.param[3] = g_master.xccdcomp
            LET la_param.param[4] = g_master.xccdld
            LET la_param.param[5] = g_master.xccd004
            LET la_param.param[6] = g_master.xccd005
            LET la_param.param[7] = g_master.xccd003
            LET la_param.param[8] = g_master.xccd006
            LET ls_js = util.JSON.stringify( la_param )
            CALL cl_cmdrun(ls_js)
            
         ON ACTION call_axcq519
            LET la_param.prog     = "axcq519"
            LET la_param.param[1] = g_master.xccdld   #账套
            LET la_param.param[2] = NULL              #账套本位币顺序
            LET la_param.param[3] = g_master.xccd002  #成本域
            LET la_param.param[4] = g_master.xccd003  #成本计算类型
            LET la_param.param[5] = g_master.xccd004  #年度
            LET la_param.param[6] = g_master.xccd005  #期别    
            LET la_param.param[7] = g_master.xccd006  #工单
            LET la_param.param[8] = NULL              #项次
            LET la_param.param[9] = NULL              #项序
            LET la_param.param[10] = NULL             #出入库吗
            LET la_param.param[11] = g_master.xccdcomp#法人
            LET la_param.param[12] = NULL             #料号
            LET la_param.param[13] = NULL             #特性
            LET ls_js = util.JSON.stringify( la_param )
            CALL cl_cmdrun(ls_js)
         
         ON ACTION call_axcq522
            LET la_param.prog     = "axcq522"
            LET la_param.param[1] = g_master.xccdcomp
            LET la_param.param[2] = g_master.xccdld
            LET la_param.param[3] = g_master.xccd004
            LET la_param.param[4] = g_master.xccd005
            LET la_param.param[5] = g_master.xccd003
            LET la_param.param[6] = g_master.xccd006    
            LET ls_js = util.JSON.stringify( la_param )
            CALL cl_cmdrun(ls_js)
         #160617-00002#1 add-E
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xccd_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel
                  LET g_export_node[2] = base.typeInfo.create(g_xccd2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xccd3_d)
                  LET g_export_id[3]   = "s_detail3"
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
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq501_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT BY NAME g_wc ON xccdcomp,xccdld,xccd003,xccd004,xccd005,xccd006,xccd007,xccd008,xccd002,xccd010,xccd200
 
         BEFORE CONSTRUCT
 
           
         ON ACTION controlp INFIELD xccdcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#10-add-(S)
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#10-add-(E)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdcomp  #顯示到畫面上
 
            NEXT FIELD xccdcomp                     #返回原欄位         
         
         
         
         ON ACTION controlp INFIELD xccdld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            #160802-00020#4-add-(S)
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#4-add-(E)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccdld  #顯示到畫面上
            NEXT FIELD xccdld                     #返回原欄位        
         
         
         
         ON ACTION controlp INFIELD xccd003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd003  #顯示到畫面上
            NEXT FIELD xccd003                     #返回原欄位         
         
         
         
         ON ACTION controlp INFIELD xccd006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = 'F'
            CALL q_sfaadocno_1()                   #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd006  #顯示到畫面上
            NEXT FIELD xccd006                     #返回原欄位           
         
         
         
         ON ACTION controlp INFIELD xccd007
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd007  #顯示到畫面上
 
            NEXT FIELD xccd007                     #返回原欄位         
         
          ON ACTION controlp INFIELD xccd008
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccd008()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd008  #顯示到畫面上
 
            NEXT FIELD xccd008                     #返回原欄位  
         
         ON ACTION controlp INFIELD xccd002
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccd002  #顯示到畫面上
 
            NEXT FIELD xccd002                     #返回原欄位         
         
         
         
         ON ACTION controlp INFIELD xccd010
         
        
         
      END CONSTRUCT
 
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON xccd001,xccd102a,xccd202a,xccd204a,xccd302a,xccd304a,xccd902a,xccd102b, 
          xccd202b,xccd204b,xccd302b,xccd304b,xccd902b,xccd102c,xccd202c,xccd204c,xccd302c,xccd304c, 
          xccd902c
           FROM s_detail1[1].b_xccd001,s_detail1[1].b_xccd102a,s_detail1[1].b_xccd202a,s_detail1[1].b_xccd204a, 
               s_detail1[1].b_xccd302a,s_detail1[1].b_xccd304a,s_detail1[1].b_xccd902a,s_detail2[1].b_xccd102b, 
               s_detail2[1].b_xccd202b,s_detail2[1].b_xccd204b,s_detail2[1].b_xccd302b,s_detail2[1].b_xccd304b, 
               s_detail2[1].b_xccd902b,s_detail3[1].b_xccd102c,s_detail3[1].b_xccd202c,s_detail3[1].b_xccd204c, 
               s_detail3[1].b_xccd302c,s_detail3[1].b_xccd304c,s_detail3[1].b_xccd902c
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_item>>----
         #----<<b_xccd001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd001
            #add-point:BEFORE FIELD b_xccd001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd001
            
            #add-point:AFTER FIELD b_xccd001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd001
         ON ACTION controlp INFIELD b_xccd001
            #add-point:ON ACTION controlp INFIELD b_xccd001

            #END add-point
 
         #----<<b_xccd102a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd102a
            #add-point:BEFORE FIELD b_xccd102a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd102a
            
            #add-point:AFTER FIELD b_xccd102a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd102a
         ON ACTION controlp INFIELD b_xccd102a
            #add-point:ON ACTION controlp INFIELD b_xccd102a

            #END add-point
 
         #----<<b_xccd202a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd202a
            #add-point:BEFORE FIELD b_xccd202a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd202a
            
            #add-point:AFTER FIELD b_xccd202a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd202a
         ON ACTION controlp INFIELD b_xccd202a
            #add-point:ON ACTION controlp INFIELD b_xccd202a

            #END add-point
 
         #----<<b_xccd204a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd204a
            #add-point:BEFORE FIELD b_xccd204a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd204a
            
            #add-point:AFTER FIELD b_xccd204a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd204a
         ON ACTION controlp INFIELD b_xccd204a
            #add-point:ON ACTION controlp INFIELD b_xccd204a

            #END add-point
 
         #----<<b_xccd302a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd302a
            #add-point:BEFORE FIELD b_xccd302a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd302a
            
            #add-point:AFTER FIELD b_xccd302a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd302a
         ON ACTION controlp INFIELD b_xccd302a
            #add-point:ON ACTION controlp INFIELD b_xccd302a

            #END add-point
 
         #----<<b_xccd304a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd304a
            #add-point:BEFORE FIELD b_xccd304a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd304a
            
            #add-point:AFTER FIELD b_xccd304a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd304a
         ON ACTION controlp INFIELD b_xccd304a
            #add-point:ON ACTION controlp INFIELD b_xccd304a

            #END add-point
 
         #----<<b_xccd902a>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd902a
            #add-point:BEFORE FIELD b_xccd902a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd902a
            
            #add-point:AFTER FIELD b_xccd902a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_xccd902a
         ON ACTION controlp INFIELD b_xccd902a
            #add-point:ON ACTION controlp INFIELD b_xccd902a

            #END add-point
 
         #----<<b_xccdld_1>>----
         #----<<b_xccd002_1>>----
         #----<<b_xccd003_1>>----
         #----<<b_xccd004_1>>----
         #----<<b_xccd005_1>>----
         #----<<b_xccd006_1>>----
         #----<<b_item2>>----
         #----<<b_xccd001_2>>----
         #----<<b_xccd102b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd102b
            #add-point:BEFORE FIELD b_xccd102b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd102b
            
            #add-point:AFTER FIELD b_xccd102b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd102b
         ON ACTION controlp INFIELD b_xccd102b
            #add-point:ON ACTION controlp INFIELD b_xccd102b

            #END add-point
 
         #----<<b_xccd202b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd202b
            #add-point:BEFORE FIELD b_xccd202b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd202b
            
            #add-point:AFTER FIELD b_xccd202b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd202b
         ON ACTION controlp INFIELD b_xccd202b
            #add-point:ON ACTION controlp INFIELD b_xccd202b

            #END add-point
 
         #----<<b_xccd204b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd204b
            #add-point:BEFORE FIELD b_xccd204b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd204b
            
            #add-point:AFTER FIELD b_xccd204b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd204b
         ON ACTION controlp INFIELD b_xccd204b
            #add-point:ON ACTION controlp INFIELD b_xccd204b

            #END add-point
 
         #----<<b_xccd302b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd302b
            #add-point:BEFORE FIELD b_xccd302b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd302b
            
            #add-point:AFTER FIELD b_xccd302b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd302b
         ON ACTION controlp INFIELD b_xccd302b
            #add-point:ON ACTION controlp INFIELD b_xccd302b

            #END add-point
 
         #----<<b_xccd304b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd304b
            #add-point:BEFORE FIELD b_xccd304b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd304b
            
            #add-point:AFTER FIELD b_xccd304b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd304b
         ON ACTION controlp INFIELD b_xccd304b
            #add-point:ON ACTION controlp INFIELD b_xccd304b

            #END add-point
 
         #----<<b_xccd902b>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd902b
            #add-point:BEFORE FIELD b_xccd902b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd902b
            
            #add-point:AFTER FIELD b_xccd902b

            #END add-point
            
 
         #Ctrlp:construct.c.page2.b_xccd902b
         ON ACTION controlp INFIELD b_xccd902b
            #add-point:ON ACTION controlp INFIELD b_xccd902b

            #END add-point
 
         #----<<b_xccdld_2>>----
         #----<<b_xccd002_2>>----
         #----<<b_xccd003_2>>----
         #----<<b_xccd004_2>>----
         #----<<b_xccd005_2>>----
         #----<<b_xccd006_2>>----
         #----<<b_item3>>----
         #----<<b_xccd102c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd102c
            #add-point:BEFORE FIELD b_xccd102c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd102c
            
            #add-point:AFTER FIELD b_xccd102c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd102c
         ON ACTION controlp INFIELD b_xccd102c
            #add-point:ON ACTION controlp INFIELD b_xccd102c

            #END add-point
 
         #----<<b_xccd202c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd202c
            #add-point:BEFORE FIELD b_xccd202c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd202c
            
            #add-point:AFTER FIELD b_xccd202c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd202c
         ON ACTION controlp INFIELD b_xccd202c
            #add-point:ON ACTION controlp INFIELD b_xccd202c

            #END add-point
 
         #----<<b_xccd204c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd204c
            #add-point:BEFORE FIELD b_xccd204c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd204c
            
            #add-point:AFTER FIELD b_xccd204c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd204c
         ON ACTION controlp INFIELD b_xccd204c
            #add-point:ON ACTION controlp INFIELD b_xccd204c

            #END add-point
 
         #----<<b_xccd302c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd302c
            #add-point:BEFORE FIELD b_xccd302c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd302c
            
            #add-point:AFTER FIELD b_xccd302c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd302c
         ON ACTION controlp INFIELD b_xccd302c
            #add-point:ON ACTION controlp INFIELD b_xccd302c

            #END add-point
 
         #----<<b_xccd304c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd304c
            #add-point:BEFORE FIELD b_xccd304c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd304c
            
            #add-point:AFTER FIELD b_xccd304c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd304c
         ON ACTION controlp INFIELD b_xccd304c
            #add-point:ON ACTION controlp INFIELD b_xccd304c

            #END add-point
 
         #----<<b_xccd902c>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_xccd902c
            #add-point:BEFORE FIELD b_xccd902c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_xccd902c
            
            #add-point:AFTER FIELD b_xccd902c

            #END add-point
            
 
         #Ctrlp:construct.c.page3.b_xccd902c
         ON ACTION controlp INFIELD b_xccd902c
            #add-point:ON ACTION controlp INFIELD b_xccd902c

            #END add-point
 
         #----<<b_xccdld_3>>----
         #----<<b_xccd002_3>>----
         #----<<b_xccd003_3>>----
         #----<<b_xccd004_3>>----
         #----<<b_xccd005_3>>----
         #----<<b_xccd006_3>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      BEFORE DIALOG
         CALL s_axc_set_site_default() RETURNING g_master.xccdcomp,g_master.xccdld,g_master.xccd004,g_master.xccd005,g_master.xccd003
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xccdcomp
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xccdcomp_desc = '', g_rtn_fields[1] , ''
         #fengmy 150112----begin
         #根據參數顯示隱藏成本域 和 料件特性
         IF cl_null(g_master.xccdcomp) THEN
            CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
            CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
         ELSE
            CALL cl_get_para(g_enterprise,g_master.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
            CALL cl_get_para(g_enterprise,g_master.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
         END IF
                    
         IF g_para_data = 'Y' THEN
            CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
         ELSE
            CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
         END IF
#150806-00012#1----begin          
         #IF g_para_data1 = 'Y' THEN
         #   CALL cl_set_comp_visible('xccd008',TRUE)                    
         #ELSE                              
         #   CALL cl_set_comp_visible('xccd008',FALSE)                
         #END IF   
#150806-00012#1----end         
         #fengmy 150112----end         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xccdld
         CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xccdld_desc = '', g_rtn_fields[1] , ''
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_master.xccd003
         CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_master.xccd003_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_master.xccdcomp,g_master.xccdld,g_master.xccd004,g_master.xccd005,g_master.xccd003,g_master.xccdcomp_desc,g_master.xccdld_desc,g_master.xccd003_desc
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
 
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF
           
   LET g_wc2 = g_wc_table
 
        
   #add-point:cs段after_construct
   CALL axcq501_browser_fill()
   CALL axcq501_fetch("F")
   #end add-point
        
   LET g_error_show = 1
#   CALL axcq501_b_fill()
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
 
{<section id="axcq501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq501_b_fill()
   DEFINE ls_wc           STRING
   #add-point:b_fill段define
   DEFINE l_msg           STRING
   #end add-point
 
   #add-point:b_fill段sql_before

 
      
#为了提高效率，不采用常用的foreach填充，一次性填充全部的单身
   LET g_sql = "SELECT  UNIQUE '',xccd001 xccd001_1,xccd101,xccd201,'',xccd301,xccd303,xccd901,xccdld xccdld_1,xccd002 xccd002_1,xccd003 xccd003_1,xccd004 xccd004_1,xccd005 xccd005_1,xccd006 xccd006_1,",               #第一行
               "               '',xccd001 xccd001_2,xccd102a,xccd202a,xccd204a,xccd302a,xccd304a,xccd902a,xccdld xccdld_2,xccd002 xccd002_2,xccd003 xccd003_2,xccd004 xccd004_2,xccd005 xccd005_2,xccd006 xccd006_2,",    #第二行
               "               '',xccd001 xccd001_3,xccd102b,xccd202b,xccd204b,xccd302b,xccd304b,xccd902b,xccdld xccdld_3,xccd002 xccd002_3,xccd003 xccd003_3,xccd004 xccd004_3,xccd005 xccd005_3,xccd006 xccd006_3,",    #第三行
               "               '',xccd001 xccd001_4,xccd102c,xccd202c,xccd204c,xccd302c,xccd304c,xccd902c,xccdld xccdld_4,xccd002 xccd002_4,xccd003 xccd003_4,xccd004 xccd004_4,xccd005 xccd005_4,xccd006 xccd006_4,",    #第四行
               "               '',xccd001 xccd001_5,xccd102d,xccd202d,xccd204d,xccd302d,xccd304d,xccd902d,xccdld xccdld_5,xccd002 xccd002_5,xccd003 xccd003_5,xccd004 xccd004_5,xccd005 xccd005_5,xccd006 xccd006_5,",    #第五行
               "               '',xccd001 xccd001_6,xccd102e,xccd202e,xccd204e,xccd302e,xccd304e,xccd902e,xccdld xccdld_6,xccd002 xccd002_6,xccd003 xccd003_6,xccd004 xccd004_6,xccd005 xccd005_6,xccd006 xccd006_6,",    #第六行
               "               '',xccd001 xccd001_7,xccd102f,xccd202f,xccd204f,xccd302f,xccd304f,xccd902f,xccdld xccdld_7,xccd002 xccd002_7,xccd003 xccd003_7,xccd004 xccd004_7,xccd005 xccd005_7,xccd006 xccd006_7,",    #第七行
               "               '',xccd001 xccd001_8,xccd102g,xccd202g,xccd204g,xccd302g,xccd304g,xccd902g,xccdld xccdld_8,xccd002 xccd002_8,xccd003 xccd003_8,xccd004 xccd004_8,xccd005 xccd005_8,xccd006 xccd006_8,",    #第八行
               "               '',xccd001 xccd001_9,xccd102h,xccd202h,xccd204h,xccd302h,xccd304h,xccd902h,xccdld xccdld_9,xccd002 xccd002_9,xccd003 xccd003_9,xccd004 xccd004_9,xccd005 xccd005_9,xccd006 xccd006_9,",    #第九行 
               "               '',xccd001 xccd001_10,xccd102,xccd202,xccd204,xccd302,xccd304,xccd902,xccdld xccdld_10,xccd002 xccd002_10,xccd003 xccd003_10,xccd004 xccd004_10,xccd005 xccd005_10,xccd006 xccd006_10",    #第十行  
               "  FROM xccd_t",
               " WHERE xccdent= ? AND xccdld = ? ",
               "   AND xccd001 = ? AND xccd002 = ? AND xccd003 = ? AND xccd004 = ? AND xccd005 = ? AND xccd006 = ? "              

   LET g_sql = g_sql, cl_sql_add_filter("xccd_t")
   LET g_sql = g_sql," ORDER BY xccd001 " 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq501_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq501_pb
   
   
 
   CALL g_xccd_d.clear()
   CALL g_xccd2_d.clear()   
 
   CALL g_xccd3_d.clear()   
   
   OPEN b_fill_curs USING g_enterprise,g_master.xccdld,'1',g_master.xccd002,g_master.xccd003,g_master.xccd004,g_master.xccd005,g_master.xccd006
   
   FETCH b_fill_curs INTO g_xccd_d[1].item,g_xccd_d[1].xccd001,g_xccd_d[1].xccd102a,g_xccd_d[1].xccd202a,g_xccd_d[1].xccd204a,
                          g_xccd_d[1].xccd302a,g_xccd_d[1].xccd304a,g_xccd_d[1].xccd902a,g_xccd_d[1].xccdld,g_xccd_d[1].xccd002,
                          g_xccd_d[1].xccd003,g_xccd_d[1].xccd004,g_xccd_d[1].xccd005,g_xccd_d[1].xccd006,
                          g_xccd_d[2].item,g_xccd_d[2].xccd001,g_xccd_d[2].xccd102a,g_xccd_d[2].xccd202a,g_xccd_d[2].xccd204a,
                          g_xccd_d[2].xccd302a,g_xccd_d[2].xccd304a,g_xccd_d[2].xccd902a,g_xccd_d[2].xccdld,g_xccd_d[2].xccd002,
                          g_xccd_d[2].xccd003,g_xccd_d[2].xccd004,g_xccd_d[2].xccd005,g_xccd_d[2].xccd006,
                          g_xccd_d[3].item,g_xccd_d[3].xccd001,g_xccd_d[3].xccd102a,g_xccd_d[3].xccd202a,g_xccd_d[3].xccd204a,
                          g_xccd_d[3].xccd302a,g_xccd_d[3].xccd304a,g_xccd_d[3].xccd902a,g_xccd_d[3].xccdld,g_xccd_d[3].xccd002,
                          g_xccd_d[3].xccd003,g_xccd_d[3].xccd004,g_xccd_d[3].xccd005,g_xccd_d[3].xccd006,
                          g_xccd_d[4].item,g_xccd_d[4].xccd001,g_xccd_d[4].xccd102a,g_xccd_d[4].xccd202a,g_xccd_d[4].xccd204a,
                          g_xccd_d[4].xccd302a,g_xccd_d[4].xccd304a,g_xccd_d[4].xccd902a,g_xccd_d[4].xccdld,g_xccd_d[4].xccd002,
                          g_xccd_d[4].xccd003,g_xccd_d[4].xccd004,g_xccd_d[4].xccd005,g_xccd_d[4].xccd006,
                          g_xccd_d[5].item,g_xccd_d[5].xccd001,g_xccd_d[5].xccd102a,g_xccd_d[5].xccd202a,g_xccd_d[5].xccd204a,
                          g_xccd_d[5].xccd302a,g_xccd_d[5].xccd304a,g_xccd_d[5].xccd902a,g_xccd_d[5].xccdld,g_xccd_d[5].xccd002,
                          g_xccd_d[5].xccd003,g_xccd_d[5].xccd004,g_xccd_d[5].xccd005,g_xccd_d[5].xccd006,
                          g_xccd_d[6].item,g_xccd_d[6].xccd001,g_xccd_d[6].xccd102a,g_xccd_d[6].xccd202a,g_xccd_d[6].xccd204a,
                          g_xccd_d[6].xccd302a,g_xccd_d[6].xccd304a,g_xccd_d[6].xccd902a,g_xccd_d[6].xccdld,g_xccd_d[6].xccd002,
                          g_xccd_d[6].xccd003,g_xccd_d[6].xccd004,g_xccd_d[6].xccd005,g_xccd_d[6].xccd006,
                          g_xccd_d[7].item,g_xccd_d[7].xccd001,g_xccd_d[7].xccd102a,g_xccd_d[7].xccd202a,g_xccd_d[7].xccd204a,
                          g_xccd_d[7].xccd302a,g_xccd_d[7].xccd304a,g_xccd_d[7].xccd902a,g_xccd_d[7].xccdld,g_xccd_d[7].xccd002,
                          g_xccd_d[7].xccd003,g_xccd_d[7].xccd004,g_xccd_d[7].xccd005,g_xccd_d[7].xccd006,
                          g_xccd_d[8].item,g_xccd_d[8].xccd001,g_xccd_d[8].xccd102a,g_xccd_d[8].xccd202a,g_xccd_d[8].xccd204a,
                          g_xccd_d[8].xccd302a,g_xccd_d[8].xccd304a,g_xccd_d[8].xccd902a,g_xccd_d[8].xccdld,g_xccd_d[8].xccd002,
                          g_xccd_d[8].xccd003,g_xccd_d[8].xccd004,g_xccd_d[8].xccd005,g_xccd_d[8].xccd006,
                          g_xccd_d[9].item,g_xccd_d[9].xccd001,g_xccd_d[9].xccd102a,g_xccd_d[9].xccd202a,g_xccd_d[9].xccd204a,
                          g_xccd_d[9].xccd302a,g_xccd_d[9].xccd304a,g_xccd_d[9].xccd902a,g_xccd_d[9].xccdld,g_xccd_d[9].xccd002,
                          g_xccd_d[9].xccd003,g_xccd_d[9].xccd004,g_xccd_d[9].xccd005,g_xccd_d[9].xccd006,
                          g_xccd_d[10].item,g_xccd_d[10].xccd001,g_xccd_d[10].xccd102a,g_xccd_d[10].xccd202a,g_xccd_d[10].xccd204a,
                          g_xccd_d[10].xccd302a,g_xccd_d[10].xccd304a,g_xccd_d[10].xccd902a,g_xccd_d[10].xccdld,g_xccd_d[10].xccd002,
                          g_xccd_d[10].xccd003,g_xccd_d[10].xccd004,g_xccd_d[10].xccd005,g_xccd_d[10].xccd006

   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "FETCH INTO b_fill" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs
      FREE b_fill_curs  
      RETURN
   END IF


   IF g_glaa015 ='Y' THEN
      OPEN b_fill_curs USING g_enterprise,g_master.xccdld,'2',g_master.xccd002,g_master.xccd003,g_master.xccd004,g_master.xccd005,g_master.xccd006
   
      FETCH b_fill_curs INTO g_xccd2_d[1].item2,g_xccd2_d[1].xccd001,g_xccd2_d[1].xccd102b,g_xccd2_d[1].xccd202b,g_xccd2_d[1].xccd204b,
                             g_xccd2_d[1].xccd302b,g_xccd2_d[1].xccd304b,g_xccd2_d[1].xccd902b,g_xccd2_d[1].xccdld,g_xccd2_d[1].xccd002,
                             g_xccd2_d[1].xccd003,g_xccd2_d[1].xccd004,g_xccd2_d[1].xccd005,g_xccd2_d[1].xccd006,
                             g_xccd2_d[2].item2,g_xccd2_d[2].xccd001,g_xccd2_d[2].xccd102b,g_xccd2_d[2].xccd202b,g_xccd2_d[2].xccd204b,
                             g_xccd2_d[2].xccd302b,g_xccd2_d[2].xccd304b,g_xccd2_d[2].xccd902b,g_xccd2_d[2].xccdld,g_xccd2_d[2].xccd002,
                             g_xccd2_d[2].xccd003,g_xccd2_d[2].xccd004,g_xccd2_d[2].xccd005,g_xccd2_d[2].xccd006,
                             g_xccd2_d[3].item2,g_xccd2_d[3].xccd001,g_xccd2_d[3].xccd102b,g_xccd2_d[3].xccd202b,g_xccd2_d[3].xccd204b,
                             g_xccd2_d[3].xccd302b,g_xccd2_d[3].xccd304b,g_xccd2_d[3].xccd902b,g_xccd2_d[3].xccdld,g_xccd2_d[3].xccd002,
                             g_xccd2_d[3].xccd003,g_xccd2_d[3].xccd004,g_xccd2_d[3].xccd005,g_xccd2_d[3].xccd006,
                             g_xccd2_d[4].item2,g_xccd2_d[4].xccd001,g_xccd2_d[4].xccd102b,g_xccd2_d[4].xccd202b,g_xccd2_d[4].xccd204b,
                             g_xccd2_d[4].xccd302b,g_xccd2_d[4].xccd304b,g_xccd2_d[4].xccd902b,g_xccd2_d[4].xccdld,g_xccd2_d[4].xccd002,
                             g_xccd2_d[4].xccd003,g_xccd2_d[4].xccd004,g_xccd2_d[4].xccd005,g_xccd2_d[4].xccd006,
                             g_xccd2_d[5].item2,g_xccd2_d[5].xccd001,g_xccd2_d[5].xccd102b,g_xccd2_d[5].xccd202b,g_xccd2_d[5].xccd204b,
                             g_xccd2_d[5].xccd302b,g_xccd2_d[5].xccd304b,g_xccd2_d[5].xccd902b,g_xccd2_d[5].xccdld,g_xccd2_d[5].xccd002,
                             g_xccd2_d[5].xccd003,g_xccd2_d[5].xccd004,g_xccd2_d[5].xccd005,g_xccd2_d[5].xccd006,
                             g_xccd2_d[6].item2,g_xccd2_d[6].xccd001,g_xccd2_d[6].xccd102b,g_xccd2_d[6].xccd202b,g_xccd2_d[6].xccd204b,
                             g_xccd2_d[6].xccd302b,g_xccd2_d[6].xccd304b,g_xccd2_d[6].xccd902b,g_xccd2_d[6].xccdld,g_xccd2_d[6].xccd002,
                             g_xccd2_d[6].xccd003,g_xccd2_d[6].xccd004,g_xccd2_d[6].xccd005,g_xccd2_d[6].xccd006,
                             g_xccd2_d[7].item2,g_xccd2_d[7].xccd001,g_xccd2_d[7].xccd102b,g_xccd2_d[7].xccd202b,g_xccd2_d[7].xccd204b,
                             g_xccd2_d[7].xccd302b,g_xccd2_d[7].xccd304b,g_xccd2_d[7].xccd902b,g_xccd2_d[7].xccdld,g_xccd2_d[7].xccd002,
                             g_xccd2_d[7].xccd003,g_xccd2_d[7].xccd004,g_xccd2_d[7].xccd005,g_xccd2_d[7].xccd006,
                             g_xccd2_d[8].item2,g_xccd2_d[8].xccd001,g_xccd2_d[8].xccd102b,g_xccd2_d[8].xccd202b,g_xccd2_d[8].xccd204b,
                             g_xccd2_d[8].xccd302b,g_xccd2_d[8].xccd304b,g_xccd2_d[8].xccd902b,g_xccd2_d[8].xccdld,g_xccd2_d[8].xccd002,
                             g_xccd2_d[8].xccd003,g_xccd2_d[8].xccd004,g_xccd2_d[8].xccd005,g_xccd2_d[8].xccd006,
                             g_xccd2_d[9].item2,g_xccd2_d[9].xccd001,g_xccd2_d[9].xccd102b,g_xccd2_d[9].xccd202b,g_xccd2_d[9].xccd204b,
                             g_xccd2_d[9].xccd302b,g_xccd2_d[9].xccd304b,g_xccd2_d[9].xccd902b,g_xccd2_d[9].xccdld,g_xccd2_d[9].xccd002,
                             g_xccd2_d[9].xccd003,g_xccd2_d[9].xccd004,g_xccd2_d[9].xccd005,g_xccd2_d[9].xccd006,
                             g_xccd2_d[10].item2,g_xccd2_d[10].xccd001,g_xccd2_d[10].xccd102b,g_xccd2_d[10].xccd202b,g_xccd2_d[10].xccd204b,
                             g_xccd2_d[10].xccd302b,g_xccd2_d[10].xccd304b,g_xccd2_d[10].xccd902b,g_xccd2_d[10].xccdld,g_xccd2_d[10].xccd002,
                             g_xccd2_d[10].xccd003,g_xccd2_d[10].xccd004,g_xccd2_d[10].xccd005,g_xccd2_d[10].xccd006
      
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH INTO b_fill" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_curs
         FREE b_fill_curs      
         RETURN
      END IF
   END IF
   
   IF g_glaa019 ='Y' THEN
      OPEN b_fill_curs USING g_enterprise,g_master.xccdld,'3',g_master.xccd002,g_master.xccd003,g_master.xccd004,g_master.xccd005,g_master.xccd006
   
      FETCH b_fill_curs INTO g_xccd3_d[1].item3,g_xccd3_d[1].xccd001,g_xccd3_d[1].xccd102c,g_xccd3_d[1].xccd202c,g_xccd3_d[1].xccd204c,
                             g_xccd3_d[1].xccd302c,g_xccd3_d[1].xccd304c,g_xccd3_d[1].xccd902c,g_xccd3_d[1].xccdld,g_xccd3_d[1].xccd002,
                             g_xccd3_d[1].xccd003,g_xccd3_d[1].xccd004,g_xccd3_d[1].xccd005,g_xccd3_d[1].xccd006,
                             g_xccd3_d[2].item3,g_xccd3_d[2].xccd001,g_xccd3_d[2].xccd102c,g_xccd3_d[2].xccd202c,g_xccd3_d[2].xccd204c,
                             g_xccd3_d[2].xccd302c,g_xccd3_d[2].xccd304c,g_xccd3_d[2].xccd902c,g_xccd3_d[2].xccdld,g_xccd3_d[2].xccd002,
                             g_xccd3_d[2].xccd003,g_xccd3_d[2].xccd004,g_xccd3_d[2].xccd005,g_xccd3_d[2].xccd006,
                             g_xccd3_d[3].item3,g_xccd3_d[3].xccd001,g_xccd3_d[3].xccd102c,g_xccd3_d[3].xccd202c,g_xccd3_d[3].xccd204c,
                             g_xccd3_d[3].xccd302c,g_xccd3_d[3].xccd304c,g_xccd3_d[3].xccd902c,g_xccd3_d[3].xccdld,g_xccd3_d[3].xccd002,
                             g_xccd3_d[3].xccd003,g_xccd3_d[3].xccd004,g_xccd3_d[3].xccd005,g_xccd3_d[3].xccd006,
                             g_xccd3_d[4].item3,g_xccd3_d[4].xccd001,g_xccd3_d[4].xccd102c,g_xccd3_d[4].xccd202c,g_xccd3_d[4].xccd204c,
                             g_xccd3_d[4].xccd302c,g_xccd3_d[4].xccd304c,g_xccd3_d[4].xccd902c,g_xccd3_d[4].xccdld,g_xccd3_d[4].xccd002,
                             g_xccd3_d[4].xccd003,g_xccd3_d[4].xccd004,g_xccd3_d[4].xccd005,g_xccd3_d[4].xccd006,
                             g_xccd3_d[5].item3,g_xccd3_d[5].xccd001,g_xccd3_d[5].xccd102c,g_xccd3_d[5].xccd202c,g_xccd3_d[5].xccd204c,
                             g_xccd3_d[5].xccd302c,g_xccd3_d[5].xccd304c,g_xccd3_d[5].xccd902c,g_xccd3_d[5].xccdld,g_xccd3_d[5].xccd002,
                             g_xccd3_d[5].xccd003,g_xccd3_d[5].xccd004,g_xccd3_d[5].xccd005,g_xccd3_d[5].xccd006,
                             g_xccd3_d[6].item3,g_xccd3_d[6].xccd001,g_xccd3_d[6].xccd102c,g_xccd3_d[6].xccd202c,g_xccd3_d[6].xccd204c,
                             g_xccd3_d[6].xccd302c,g_xccd3_d[6].xccd304c,g_xccd3_d[6].xccd902c,g_xccd3_d[6].xccdld,g_xccd3_d[6].xccd002,
                             g_xccd3_d[6].xccd003,g_xccd3_d[6].xccd004,g_xccd3_d[6].xccd005,g_xccd3_d[6].xccd006,
                             g_xccd3_d[7].item3,g_xccd3_d[7].xccd001,g_xccd3_d[7].xccd102c,g_xccd3_d[7].xccd202c,g_xccd3_d[7].xccd204c,
                             g_xccd3_d[7].xccd302c,g_xccd3_d[7].xccd304c,g_xccd3_d[7].xccd902c,g_xccd3_d[7].xccdld,g_xccd3_d[7].xccd002,
                             g_xccd3_d[7].xccd003,g_xccd3_d[7].xccd004,g_xccd3_d[7].xccd005,g_xccd3_d[7].xccd006,
                             g_xccd3_d[8].item3,g_xccd3_d[8].xccd001,g_xccd3_d[8].xccd102c,g_xccd3_d[8].xccd202c,g_xccd3_d[8].xccd204c,
                             g_xccd3_d[8].xccd302c,g_xccd3_d[8].xccd304c,g_xccd3_d[8].xccd902c,g_xccd3_d[8].xccdld,g_xccd3_d[8].xccd002,
                             g_xccd3_d[8].xccd003,g_xccd3_d[8].xccd004,g_xccd3_d[8].xccd005,g_xccd3_d[8].xccd006,
                             g_xccd3_d[9].item3,g_xccd3_d[9].xccd001,g_xccd3_d[9].xccd102c,g_xccd3_d[9].xccd202c,g_xccd3_d[9].xccd204c,
                             g_xccd3_d[9].xccd302c,g_xccd3_d[9].xccd304c,g_xccd3_d[9].xccd902c,g_xccd3_d[9].xccdld,g_xccd3_d[9].xccd002,
                             g_xccd3_d[9].xccd003,g_xccd3_d[9].xccd004,g_xccd3_d[9].xccd005,g_xccd3_d[9].xccd006,
                             g_xccd3_d[10].item3,g_xccd3_d[10].xccd001,g_xccd3_d[10].xccd102c,g_xccd3_d[10].xccd202c,g_xccd3_d[10].xccd204c,
                             g_xccd3_d[10].xccd302c,g_xccd3_d[10].xccd304c,g_xccd3_d[10].xccd902c,g_xccd3_d[10].xccdld,g_xccd3_d[10].xccd002,
                             g_xccd3_d[10].xccd003,g_xccd3_d[10].xccd004,g_xccd3_d[10].xccd005,g_xccd3_d[10].xccd006
                          
      IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FETCH INTO b_fill" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CLOSE b_fill_curs
         FREE b_fill_curs      
         RETURN
      END IF
   END IF
   CLOSE b_fill_curs
   FREE b_fill_curs
#填充第一列的项目内容
   LET l_msg = cl_getmsg('axc-00356',g_lang)   #在制数量
   LET g_xccd_d[1].item = l_msg
   LET l_msg = cl_getmsg('axc-00357',g_lang)   #在制成本-材料
   LET g_xccd_d[2].item = l_msg
   LET l_msg = cl_getmsg('axc-00358',g_lang)   #在制成本-人工
   LET g_xccd_d[3].item = l_msg
   LET l_msg = cl_getmsg('axc-00359',g_lang)   #在制成本-委外
   LET g_xccd_d[4].item = l_msg
   LET l_msg = cl_getmsg('axc-00360',g_lang)   #在制成本-制费一
   LET g_xccd_d[5].item = l_msg
   LET l_msg = cl_getmsg('axc-00361',g_lang)   #在制成本-制费二
   LET g_xccd_d[6].item = l_msg
   LET l_msg = cl_getmsg('axc-00362',g_lang)   #在制成本-制费三
   LET g_xccd_d[7].item = l_msg   
   LET l_msg = cl_getmsg('axc-00363',g_lang)   #在制成本-制费四
   LET g_xccd_d[8].item = l_msg 
   LET l_msg = cl_getmsg('axc-00364',g_lang)   #在制成本-制费五
   LET g_xccd_d[9].item = l_msg
   LET l_msg = cl_getmsg('axc-00365',g_lang)   #在制成本
   LET g_xccd_d[10].item = l_msg   

   IF g_glaa015 ='Y' THEN
      LET l_msg = cl_getmsg('axc-00356',g_lang)   #在制数量
      LET g_xccd2_d[1].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00357',g_lang)   #在制成本-材料
      LET g_xccd2_d[2].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00358',g_lang)   #在制成本-人工
      LET g_xccd2_d[3].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00359',g_lang)   #在制成本-委外
      LET g_xccd2_d[4].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00360',g_lang)   #在制成本-制费一
      LET g_xccd2_d[5].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00361',g_lang)   #在制成本-制费二
      LET g_xccd2_d[6].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00362',g_lang)   #在制成本-制费三
      LET g_xccd2_d[7].item2 = l_msg  
      LET l_msg = cl_getmsg('axc-00363',g_lang)   #在制成本-制费四
      LET g_xccd2_d[8].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00364',g_lang)   #在制成本-制费五
      LET g_xccd2_d[9].item2 = l_msg
      LET l_msg = cl_getmsg('axc-00365',g_lang)   #在制成本
      LET g_xccd2_d[10].item2 = l_msg   
   END IF
   
   IF g_glaa019 ='Y' THEN
      LET l_msg = cl_getmsg('axc-00356',g_lang)   #在制数量
      LET g_xccd3_d[1].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00357',g_lang)   #在制成本-材料
      LET g_xccd3_d[2].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00358',g_lang)   #在制成本-人工
      LET g_xccd3_d[3].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00359',g_lang)   #在制成本-委外
      LET g_xccd3_d[4].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00360',g_lang)   #在制成本-制费一
      LET g_xccd3_d[5].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00361',g_lang)   #在制成本-制费二
      LET g_xccd3_d[6].item3 = l_msg
      LET l_msg = cl_getmsg('axc-00362',g_lang)   #在制成本-制费三
      LET g_xccd3_d[7].item3 = l_msg   
      LET l_msg = cl_getmsg('axc-00363',g_lang)   #在制成本-制费四
      LET g_xccd3_d[8].item3 = l_msg 
      LET l_msg = cl_getmsg('axc-00364',g_lang)   #在制成本-制费五
      LET g_xccd3_d[9].item3 = l_msg 
      LET l_msg = cl_getmsg('axc-00365',g_lang)   #在制成本
      LET g_xccd3_d[10].item3 = l_msg     
   END IF
   
   LET g_detail_cnt = 10 
   DISPLAY g_detail_cnt TO FORMONLY.cnt 
   #end add-point      
 
 

   

 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq501_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   DEFINE l_cnt      LIKE type_t.num5
   
 

 

 

 

 
   LET g_sql = " SELECT DISTINCT xccdcomp,xccdld,xccd003,xccd004,xccd005,xccd006,xccd007,xccd008,xccd002,xccd010,xccd200 ",
               "   FROM xccd_t ",
               "  WHERE xccdent= ? AND xccdld = ? ",
               "    AND xccd002 = ? AND xccd003 = ? AND xccd004 = ? AND xccd005 = ? AND xccd006 = ? "
  
   PREPARE axcq501_fetch_pre FROM g_sql
            
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
   DISPLAY '10' TO FORMONLY.cnt   
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq501_fetch_pre USING g_browser[g_current_idx].xccdent,g_browser[g_current_idx].xccdld,g_browser[g_current_idx].xccd002,
                                   g_browser[g_current_idx].xccd003,g_browser[g_current_idx].xccd004,g_browser[g_current_idx].xccd005,g_browser[g_current_idx].xccd006                                   
      INTO g_master.xccdcomp,g_master.xccdld,g_master.xccd003,g_master.xccd004,g_master.xccd005,g_master.xccd006,g_master.xccd007,g_master.xccd008,g_master.xccd002,g_master.xccd010,g_master.xccd200
      
   FREE axcq501_fetch_pre
            
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccd_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_master.* TO NULL
      RETURN
   END IF
 
   #重新顯示   
   CALL axcq501_show()   
 
  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq501_detail_show(ps_page)
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
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq501_filter()
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
      CONSTRUCT g_wc_filter ON xccd001,xccd102a,xccd202a,xccd204a,xccd302a,xccd304a,xccd902a,xccd102b, 
          xccd202b,xccd204b,xccd302b,xccd304b,xccd902b,xccd102c,xccd202c,xccd204c,xccd302c,xccd304c, 
          xccd902c
                          FROM s_detail1[1].b_xccd001,s_detail1[1].b_xccd102a,s_detail1[1].b_xccd202a, 
                              s_detail1[1].b_xccd204a,s_detail1[1].b_xccd302a,s_detail1[1].b_xccd304a, 
                              s_detail1[1].b_xccd902a,s_detail2[1].b_xccd102b,s_detail2[1].b_xccd202b, 
                              s_detail2[1].b_xccd204b,s_detail2[1].b_xccd302b,s_detail2[1].b_xccd304b, 
                              s_detail2[1].b_xccd902b,s_detail3[1].b_xccd102c,s_detail3[1].b_xccd202c, 
                              s_detail3[1].b_xccd204c,s_detail3[1].b_xccd302c,s_detail3[1].b_xccd304c, 
                              s_detail3[1].b_xccd902c
 
         BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
                     DISPLAY axcq501_filter_parser('xccd001') TO s_detail1[1].b_xccd001
            DISPLAY axcq501_filter_parser('xccd102a') TO s_detail1[1].b_xccd102a
            DISPLAY axcq501_filter_parser('xccd202a') TO s_detail1[1].b_xccd202a
            DISPLAY axcq501_filter_parser('xccd204a') TO s_detail1[1].b_xccd204a
            DISPLAY axcq501_filter_parser('xccd302a') TO s_detail1[1].b_xccd302a
            DISPLAY axcq501_filter_parser('xccd304a') TO s_detail1[1].b_xccd304a
            DISPLAY axcq501_filter_parser('xccd902a') TO s_detail1[1].b_xccd902a
            DISPLAY axcq501_filter_parser('xccd102b') TO s_detail2[1].b_xccd102b
            DISPLAY axcq501_filter_parser('xccd202b') TO s_detail2[1].b_xccd202b
            DISPLAY axcq501_filter_parser('xccd204b') TO s_detail2[1].b_xccd204b
            DISPLAY axcq501_filter_parser('xccd302b') TO s_detail2[1].b_xccd302b
            DISPLAY axcq501_filter_parser('xccd304b') TO s_detail2[1].b_xccd304b
            DISPLAY axcq501_filter_parser('xccd902b') TO s_detail2[1].b_xccd902b
            DISPLAY axcq501_filter_parser('xccd102c') TO s_detail3[1].b_xccd102c
            DISPLAY axcq501_filter_parser('xccd202c') TO s_detail3[1].b_xccd202c
            DISPLAY axcq501_filter_parser('xccd204c') TO s_detail3[1].b_xccd204c
            DISPLAY axcq501_filter_parser('xccd302c') TO s_detail3[1].b_xccd302c
            DISPLAY axcq501_filter_parser('xccd304c') TO s_detail3[1].b_xccd304c
            DISPLAY axcq501_filter_parser('xccd902c') TO s_detail3[1].b_xccd902c
 
 
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
   
      CALL axcq501_filter_show('xccd001','b_xccd001')
   CALL axcq501_filter_show('xccd102a','b_xccd102a')
   CALL axcq501_filter_show('xccd202a','b_xccd202a')
   CALL axcq501_filter_show('xccd204a','b_xccd204a')
   CALL axcq501_filter_show('xccd302a','b_xccd302a')
   CALL axcq501_filter_show('xccd304a','b_xccd304a')
   CALL axcq501_filter_show('xccd902a','b_xccd902a')
   CALL axcq501_filter_show('xccd102b','b_xccd102b')
   CALL axcq501_filter_show('xccd202b','b_xccd202b')
   CALL axcq501_filter_show('xccd204b','b_xccd204b')
   CALL axcq501_filter_show('xccd302b','b_xccd302b')
   CALL axcq501_filter_show('xccd304b','b_xccd304b')
   CALL axcq501_filter_show('xccd902b','b_xccd902b')
   CALL axcq501_filter_show('xccd102c','b_xccd102c')
   CALL axcq501_filter_show('xccd202c','b_xccd202c')
   CALL axcq501_filter_show('xccd204c','b_xccd204c')
   CALL axcq501_filter_show('xccd302c','b_xccd302c')
   CALL axcq501_filter_show('xccd304c','b_xccd304c')
   CALL axcq501_filter_show('xccd902c','b_xccd902c')
 
    
   CALL axcq501_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq501_filter_parser(ps_field)
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
 
{<section id="axcq501.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq501_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.insert" >}
#+ insert
PRIVATE FUNCTION axcq501_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq501.modify" >}
#+ modify
PRIVATE FUNCTION axcq501_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq501_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.delete" >}
#+ delete
PRIVATE FUNCTION axcq501_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq501.other_function" >}

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
PRIVATE FUNCTION axcq501_show()

   #fengmy 150112----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_master.xccdcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   ELSE
      CALL cl_get_para(g_enterprise,g_master.xccdcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_master.xccdcomp,'S-FIN-6013') RETURNING g_para_data1   #采用成本域否       
   END IF
              
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xccd002,xccd002_desc',TRUE)                    
   ELSE
      CALL cl_set_comp_visible('xccd002,xccd002_desc',FALSE)                
   END IF  
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xccd008',TRUE)                    
   ELSE                              
      CALL cl_set_comp_visible('xccd008',FALSE)                
   END IF   
   #fengmy 150112----end
   CALL axcq501_b_fill()
   
   DISPLAY BY NAME g_master.xccdcomp,g_master.xccdld,g_master.xccd003,g_master.xccd004,g_master.xccd005,g_master.xccd006,g_master.xccd007,g_master.xccd008,g_master.xccd002,g_master.xccd010,g_master.xccd200
   
#根据工单抓返工否，结案日期
   SELECT sfaa042,sfaa048 INTO g_master.sfaa042,g_master.sfaa048
     FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = g_master.xccd006
      
#根据料号抓品名规格，成本单位
   CALL s_desc_get_item_desc(g_master.xccd007)
         RETURNING g_master.xccd007_desc,g_master.xccd007_desc_1

   SELECT imag014 INTO g_master.imag014
     FROM imag_t
    WHERE imagent  = g_enterprise
      AND imagsite = g_master.xccdcomp
      AND imag001  = g_master.xccd007
   
   CALL s_desc_get_unit_desc(g_master.imag014)
         RETURNING g_master.imag014_desc 
         
#抓成本阶
   SELECT DISTINCT xcbb006 INTO g_master.xcbb006
     FROM xcbb_t
    WHERE xcbbent  = g_enterprise
      AND xcbbcomp = g_master.xccdcomp
      AND xcbb001  = g_master.xccd004
      AND xcbb002  = g_master.xccd005
      AND xcbb003  = g_master.xccd007   #不写特性，因为相同料号不同特性的xcbb成本阶一样的
      AND xcbb004  = g_master.xccd008   #fengmy150803
#fengmy150803-----begin      
   IF SQLCA.SQLCODE=100 OR cl_null(g_master.xccd008) THEN
      SELECT DISTINCT xcbb006 INTO g_master.xcbb006
        FROM xcbb_t
       WHERE xcbbent  = g_enterprise
         AND xcbbcomp = g_master.xccdcomp
         AND xcbb001  = g_master.xccd004
         AND xcbb002  = g_master.xccd005
         AND xcbb003  = g_master.xccd007     
   END IF
#fengmy150803-----end 


#带出显示名称
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccdcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccdcomp_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccdld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccdld_desc = '', g_rtn_fields[1] , ''
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccd003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccd003_desc = '', g_rtn_fields[1] , ''

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccdcomp
   LET g_ref_fields[2] = g_master.xccd002
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp = ? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccd002_desc = '', g_rtn_fields[1] , ''   
   
#带出栏位都显示一下
   DISPLAY BY NAME g_master.sfaa042,g_master.sfaa048,g_master.xccd007_desc,g_master.xccd007_desc_1,g_master.imag014,g_master.xccd002_desc,
                   g_master.imag014_desc,g_master.xcbb006,g_master.xccdcomp_desc,g_master.xccdld_desc,g_master.xccd003_desc

#根据账套是否启用第二，第三币种，动态显示隐藏第二，第三单身
   SELECT glaa015,glaa019 INTO g_glaa015,g_glaa019
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xccdld
      
   CALL cl_set_comp_visible('page_3,page_4',TRUE)
   IF g_glaa015 = 'N' THEN
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   IF g_glaa019 = 'N' THEN
      CALL cl_set_comp_visible('page_4',FALSE)
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
PRIVATE FUNCTION axcq501_browser_fill()
   DEFINE l_cnt      LIKE type_t.num5
   
   CLEAR FORM
   CALL g_xccd_d.clear()
   CALL g_xccd2_d.clear()
   CALL g_xccd3_d.clear()
   LET g_wc_filter = " 1=1"
   
#虽然没有browser，也要建一个类似的g_browser数组来定位在第几笔
   CALL g_browser.clear()
   
   LET g_sql = " SELECT DISTINCT xccdent,xccdld,xccd002,xccd003,xccd004,xccd005,xccd006 ",
            "   FROM xccd_t ",
            "  WHERE xccdent = '",g_enterprise,"' AND ",g_wc," AND ",g_wc2
   #160802-00020#4-add-(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xccdld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccdcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   
   PREPARE axcq501_browser_pre FROM g_sql
   DECLARE axcq501_browser_cs CURSOR FOR axcq501_browser_pre
   
   LET l_cnt = 1
   FOREACH axcq501_browser_cs INTO g_browser[l_cnt].*
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
   
   FREE axcq501_browser_cs
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
   #160113-00011#1-add----(S)
   IF g_browser.getLength() = 0 THEN     
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err() 
      CLEAR FORM
   END IF
   #160113-00011#1-add----(E)
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
END FUNCTION

 
{</section>}
 
