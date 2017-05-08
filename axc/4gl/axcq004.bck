#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq004.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000022
#+ 
#+ Filename...: axcq004
#+ Description: 合計金額檢核查詢作業
#+ Creator....: 00537(2014/08/28)
#+ Modifier...: 00537(2014/08/29) -SD/PR- 02040
#+ Buildtype..: 應用 q01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axcq004.global" >}
#160318-00025#52  2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160802-00020#1   2016/08/03 By Saraah  增加帳套權限管控
#160802-00020#10  2016/08/11 By Saraah  增加法人權限管控
#161004-00022#2   2016/10/05 By 02040   調整材料金額抓取改為非A.加工品的料都需顯示
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xccc_d RECORD
       
       sel LIKE type_t.chr1, 
   item LIKE type_t.chr80, 
   item_desc LIKE gzcbl_t.gzcbl004,
   xccc201 LIKE xccc_t.xccc201, 
   xccc202 LIKE xccc_t.xccc202, 
   xccc202a LIKE xccc_t.xccc202a, 
   xccc202b LIKE xccc_t.xccc202b, 
   xccc202c LIKE xccc_t.xccc202c, 
   xccc202d LIKE xccc_t.xccc202d, 
   xccc202e LIKE xccc_t.xccc202e, 
   xccc202f LIKE xccc_t.xccc202f, 
   xccc202g LIKE xccc_t.xccc202g, 
   xccc202h LIKE xccc_t.xccc202h
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_xccc_d            DYNAMIC ARRAY OF type_g_xccc_d
DEFINE g_xccc_d_t          type_g_xccc_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num5              #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num5              #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num5
DEFINE g_detail_cnt          LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num5
DEFINE g_detail_idx          LIKE type_t.num5              #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num5
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_master  RECORD 
       xccccomp         LIKE xccc_t.xccccomp,
       xccccomp_desc    LIKE ooefl_t.ooefl003,
       xccc004          LIKE xccc_t.xccc004,
       xccc005          LIKE xccc_t.xccc005,
       xcccld           LIKE xccc_t.xcccld,
       xcccld_desc      LIKE glaal_t.glaal003,
       xccc001          LIKE xccc_t.xccc001,
       xccc001_desc     LIKE ooail_t.ooail003,
       xccc003          LIKE xccc_t.xccc003,
       xccc003_desc     LIKE xcatl_t.xcatl003
       END RECORD
       
DEFINE g_xccc_d_color   DYNAMIC ARRAY OF RECORD
                           c01   STRING,
                           c02   STRING,
                           c03   STRING,
                           c04   STRING,
                           c05   STRING,
                           c06   STRING,
                           c07   STRING,
                           c08   STRING,
                           c09   STRING,
                           c10   STRING,
                           c11   STRING,
                           c12   STRING,
                           c13   STRING
                        END RECORD
DEFINE g_wc_cs_ld       STRING                #160802-00020#1 add
DEFINE g_wc_cs_comp     STRING                #160802-00020#10 add
#end add-point
 
#add-point:傳入參數說明
#2015/3/18 liuym add------str----
TYPE type_g_xccc_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xccc_e
DEFINE g_yy1 LIKE type_t.num5
DEFINE g_mm1 LIKE type_t.num5
DEFINE g_yy2 LIKE type_t.num5
DEFINE g_mm2 LIKE type_t.num5
#fengmy150806-----end
#end add-point
 
{</section>}
 
{<section id="axcq004.main" >}
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
#160802-00020#1-s add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld
#160802-00020#1-e add
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10 add
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
   DECLARE axcq004_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axcq004_master_referesh FROM g_sql
 
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq004_bcl CURSOR FROM g_forupd_sql
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      LET g_master.xccccomp = g_argv[1]   #法人
      LET g_master.xcccld   = g_argv[2]   #账套
      LET g_master.xccc004  = g_argv[3]   #年度
      LET g_master.xccc005  = g_argv[4]   #期别
      LET g_master.xccc001  = g_argv[5]   #本位币顺序
      LET g_master.xccc003  = g_argv[6]   #成本计算类型
      CALL axcq004_b_fill()
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq004 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq004_init()   
 
      #進入選單 Menu (="N")
      CALL axcq004_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq004
      
   END IF 
   
   CLOSE axcq004_cl
   
   
 
   #add-point:作業離開前
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axcq004.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq004_init()
 
   #add-point:init段define
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
#  LET g_selcolor    = "#D0E7FD"
   
     
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('item','8922')
   CALL cl_set_combo_scc('xccc001','8914')

   #end add-point
 
   CALL axcq004_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq004.default_search" >}
PRIVATE FUNCTION axcq004_default_search()
   #add-point:default_search段define
   
   #end add-point
 
 
   #add-point:default_search段開始前
   
   #end add-point
 
   #+ 此段落由子樣板qs27產生
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcccld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xccc001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xccc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xccc003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xccc004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xccc005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xccc006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xccc007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xccc008 = '", g_argv[09], "' AND "
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
 
{<section id="axcq004.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq004_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE r_success LIKE type_t.num10   #160802-00020#1 add
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 
   LET g_main_hidden = 0
   #end add-point
 
   
   CALL axcq004_b_fill()
  
   WHILE li_exit = FALSE
 
      CALL cl_dlg_query_bef_disp()  #相關查詢
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_master.xccccomp,g_master.xcccld,g_master.xccc001,g_master.xccc003  #DEL xccc004&xccc005
         
            BEFORE INPUT
#预设当前site的法人，主账套，年度期别，成本计算类型
              #fengmy150813 ---begin
              IF cl_null(g_master.xccccomp) AND cl_null(g_master.xcccld) AND cl_null(g_yy1) AND cl_null(g_mm1) 
               AND cl_null(g_yy2) AND cl_null(g_mm2) AND cl_null(g_master.xccc003) AND cl_null(g_master.xccc001) THEN
              #CALL s_axc_set_site_default() RETURNING g_master.xccccomp,g_master.xcccld,g_master.xccc004,g_master.xccc005,g_master.xccc003  
               CALL s_axc_set_site_default() RETURNING g_master.xccccomp,g_master.xcccld,g_yy2,g_mm2,g_master.xccc003  
               LET g_yy1 = g_yy2
               LET g_mm1 = g_mm2
              END IF
              #fengmy150813 ---end
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccccomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccccomp_desc 
               
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcccld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcccld_desc 

               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccc003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccc003_desc
                  
               LET g_master.xccc001 = '1'
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.xcccld
                  
                  
               CASE g_master.xccc001
                  WHEN '1' 
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa001
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc                   
                  WHEN '2'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa016
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc  
                  WHEN '3'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa020
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc  
               END CASE
 
               
            AFTER FIELD xccccomp
               IF NOT cl_null(g_master.xccccomp) THEN
#160802-00020#10-s mark
#                  IF NOT s_axc_chk_ld_comp(g_master.xccccomp,g_master.xcccld) THEN
#                     LET g_master.xccccomp = NULL
#                     NEXT FIELD CURRENT
#                  END IF
#160802-00020#10-e mark
#160802-00020#10-s add
                  #增加法人權限檢查
                  IF NOT cl_null(g_wc_cs_comp) THEN
                     IF NOT ap_chk_isExist(g_master.xccccomp,"SELECT COUNT(*) FROM ooef_t WHERE "||"ooefent = '" ||g_enterprise|| "' AND "||"ooef001 = ? AND ooef001 IN " || g_wc_cs_comp,'ais-00228',1) THEN
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     CALL s_fin_comp_chk(g_master.xccccomp) RETURNING r_success,g_errno
                     IF NOT r_success THEN
                        LET g_master.xcccld = NULL
                        INITIALIZE g_errparam.* TO NULL
                        LET g_errparam.extend = g_master.xccccomp
                        LET g_errparam.code = g_errno
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
#160802-00020#10-e add
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccccomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccccomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccccomp_desc           
 
            
            
            AFTER FIELD xcccld
               IF NOT cl_null(g_master.xcccld) THEN
                  IF NOT s_axc_chk_ld_comp(g_master.xccccomp,g_master.xcccld) THEN
                     LET g_master.xcccld = NULL
                     NEXT FIELD CURRENT
                  END IF
#160802-00020#1-s add
                  #增加帳套權限檢查
                  CALL s_fin_ld_chk(g_master.xcccld,g_user,'N') RETURNING r_success,g_errno
                  IF NOT r_success THEN
                     LET g_master.xcccld = NULL
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code = g_errno
                     LET g_errparam.replace[1] = 'agli010'
                     LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                     LET g_errparam.exeprog = 'agli010'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
#160802-00020#1-e add
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xcccld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xcccld_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xcccld_desc            
            
            
            AFTER FIELD xccc001
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.xcccld
                  
                  
               CASE g_master.xccc001
                  WHEN '1' 
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa001
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc                   
                  WHEN '2'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa016
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc  
                  WHEN '3'
                    INITIALIZE g_ref_fields TO NULL
                    LET g_ref_fields[1] = l_glaa020
                    CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                    LET g_master.xccc001_desc = '', g_rtn_fields[1] , ''
                    DISPLAY BY NAME g_master.xccc001_desc  
               END CASE                                             
            
            AFTER FIELD xccc003
               IF NOT cl_null(g_master.xccc003) THEN 
                  #此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.xccc003 
                  LET g_errshow = TRUE   #160318-00025#52
                  LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"    #160318-00025#52
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_xcat001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.xccc003 = NULL
                     NEXT FIELD CURRENT
                  END IF
               
               
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_master.xccc003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_master.xccc003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_master.xccc003_desc
            
            AFTER FIELD xccc004
#              IF NOT cl_null(g_master.xccc004) THEN
#                 IF NOT s_axc_chk_year_period(g_master.xcccld,g_master.xccc004,g_master.xccc005) THEN
#                    LET g_master.xccc004 = NULL
#                    NEXT FIELD CURRENT
#                 END IF
#              END IF
         
            AFTER FIELD xccc005
#              IF NOT cl_null(g_master.xccc005) THEN
#                 IF NOT s_axc_chk_year_period(g_master.xcccld,g_master.xccc004,g_master.xccc005) THEN
#                    LET g_master.xccc005 = NULL
#                    NEXT FIELD CURRENT
#                 END IF
#              END IF


            ON ACTION controlp INFIELD xccccomp
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE               
               LET g_qryparam.default1 = g_master.xccccomp             #給予default值
#160802-00020#10-s add
               #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
#160802-00020#10-e add               
               CALL q_ooef001_2()                                      #呼叫開窗               
               LET g_master.xccccomp = g_qryparam.return1              #將開窗取得的值回傳到變數               
               DISPLAY g_master.xccccomp TO xccccomp                   #顯示到畫面上               
               NEXT FIELD xccccomp                                     #返回原欄位            
            
            ON ACTION controlp INFIELD xcccld
            #此段落由子樣板a07產生            
            #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE               
               LET g_qryparam.default1 = g_master.xcccld               #給予default值               
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept 
               IF g_master.xccccomp IS NOT NULL THEN
                  LET g_qryparam.where = " glaacomp = '",g_master.xccccomp,"'"
               END IF
#160802-00020#1-s add
               #增加帳套過濾條件
               IF NOT cl_null(g_wc_cs_ld) THEN
                  IF cl_null(g_qryparam.where) THEN
                     LET g_qryparam.where = " 1=1"
                  END IF
                  LET g_qryparam.where = g_qryparam.where," AND glaald IN ",g_wc_cs_ld                  
               END IF
#160802-00020#1-e add
               CALL q_authorised_ld()                                   #呼叫開窗               
               LET g_master.xcccld = g_qryparam.return1               
               DISPLAY g_master.xcccld TO xcccld               
               NEXT FIELD xcccld                                        #返回原欄位
               
            
            ON ACTION controlp INFIELD xccc003
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_master.xccc003             #給予default值
               
               #給予arg
               CALL q_xcat001()                                #呼叫開窗
               
               LET g_master.xccc003 = g_qryparam.return1              
               
               DISPLAY g_master.xccc003 TO xccc003              #
               
               NEXT FIELD xccc003                          #返回原欄位
               
               
            AFTER INPUT              
               CALL axcq004_b_fill()
               
               
         END INPUT
         #end add-point
 
         #add-point:construct段落
         #fengmy150806---begin
         INPUT g_yy1,g_mm1,g_yy2,g_mm2 FROM xccc004,xccc005,xccc004_1,xccc005_1
            AFTER FIELD xccc004 
               IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                   IF g_yy1 > g_yy2 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'acr-00064'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD xccc004
                   END IF
                END IF
            AFTER FIELD xccc005
               IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
                  IF g_yy1 = g_yy2 AND 
                     g_mm1 > g_mm2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD xccc005
                  END IF
               END IF
            AFTER FIELD xccc004_1
               IF NOT cl_null(g_yy1) AND NOT cl_null(g_yy2) THEN
                   IF g_yy1 > g_yy2 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'acr-00064'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD xccc004_1
                   END IF
                END IF
            AFTER FIELD xccc005_1   
               IF NOT cl_null(g_mm1) AND NOT cl_null(g_mm2) THEN
                  IF g_yy1 = g_yy2 AND 
                     g_mm1 > g_mm2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD xccc005_1
                  END IF
               END IF               
         END INPUT
         #fengmy150806---end
         #end add-point
     
         DISPLAY ARRAY g_xccc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xccc_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL axcq004_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array

         #end add-point
 
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
      
         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
#插完栏位，对第1，22，34行设定蓝色底色
               LET g_current_page = 1
               LET g_xccc_d_color[1].c01 = 'blue reverse'
               LET g_xccc_d_color[1].c02 = 'blue reverse'
               LET g_xccc_d_color[1].c03 = 'blue reverse'
               LET g_xccc_d_color[1].c04 = 'blue reverse'
               LET g_xccc_d_color[1].c05 = 'blue reverse'
               LET g_xccc_d_color[1].c06 = 'blue reverse'
               LET g_xccc_d_color[1].c07 = 'blue reverse'
               LET g_xccc_d_color[1].c08 = 'blue reverse'
               LET g_xccc_d_color[1].c09 = 'blue reverse'
               LET g_xccc_d_color[1].c10 = 'blue reverse'
               LET g_xccc_d_color[1].c11 = 'blue reverse'
               LET g_xccc_d_color[1].c12 = 'blue reverse'
               LET g_xccc_d_color[1].c13 = 'blue reverse'
#151231-00002 --begin  22-->23  34-->35
               LET g_xccc_d_color[23].c01 = 'blue reverse'
               LET g_xccc_d_color[23].c02 = 'blue reverse'
               LET g_xccc_d_color[23].c03 = 'blue reverse'
               LET g_xccc_d_color[23].c04 = 'blue reverse'
               LET g_xccc_d_color[23].c05 = 'blue reverse'
               LET g_xccc_d_color[23].c06 = 'blue reverse'
               LET g_xccc_d_color[23].c07 = 'blue reverse'
               LET g_xccc_d_color[23].c08 = 'blue reverse'
               LET g_xccc_d_color[23].c09 = 'blue reverse'
               LET g_xccc_d_color[23].c10 = 'blue reverse'
               LET g_xccc_d_color[23].c11 = 'blue reverse'
               LET g_xccc_d_color[23].c12 = 'blue reverse'
               LET g_xccc_d_color[23].c13 = 'blue reverse'
               LET g_xccc_d_color[35].c01 = 'blue reverse'
               LET g_xccc_d_color[35].c02 = 'blue reverse'
               LET g_xccc_d_color[35].c03 = 'blue reverse'
               LET g_xccc_d_color[35].c04 = 'blue reverse'
               LET g_xccc_d_color[35].c05 = 'blue reverse'
               LET g_xccc_d_color[35].c06 = 'blue reverse'
               LET g_xccc_d_color[35].c07 = 'blue reverse'
               LET g_xccc_d_color[35].c08 = 'blue reverse'
               LET g_xccc_d_color[35].c09 = 'blue reverse'
               LET g_xccc_d_color[35].c10 = 'blue reverse'
               LET g_xccc_d_color[35].c11 = 'blue reverse'
               LET g_xccc_d_color[35].c12 = 'blue reverse'
               LET g_xccc_d_color[35].c13 = 'blue reverse'  
#151231-00002 --end  22-->23  34-->35               
               CALL DIALOG.setArrayAttributes("s_detail1",g_xccc_d_color)
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
 
 
         
            LET g_wc2 = " 1=1"
 
            #儲存WC資訊
            CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
            CALL axcq004_b_fill()
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
 
         ON ACTION datarefresh   # 重新整理
            CALL axcq004_b_fill()
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xccc_d.getLength()
               LET g_xccc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xccc_d.getLength()
               LET g_xccc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xccc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xccc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xccc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xccc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq004_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #liuym 2015/3/18 add ----str-----
               DROP TABLE axcq004_tmp;
               #创建临时表，存放当前单身数据
               CALL axcq004_create_temp_table()  
               #把单身内容放入暂存档，以便XG调用打印
               CALL axcq004_ins_temp()               
               LET g_param.v = "axcq004_tmp"
               CALL axcq004_x01('1=1',g_param.v)
               #liuym 2015/3/18 add ----end-----               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
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
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq004_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq004_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               LET g_export_node[1] = base.typeInfo.create(g_xccc_d)
               LET g_export_id[1]   = "s_detail1"
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq004.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq004_b_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   #add-point:b_fill段define
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before
   IF g_master.xccccomp IS NULL THEN RETURN END IF      #没有录单头查询条件就不要进来浪费资料，毕竟xccc之类的表都查一次还是很耗资源的
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
 
   CALL g_xccc_d.clear()
 
   #add-point:陣列清空
#下面开始填充单身，填的动作自己写，原来foreach抛弃不用，不删除是因为动了就算改动section，会被特别统计到的，可能模板的更新会享受不到
#先抓xccc的资料   库存
   LET g_sql = " SELECT SUM(xccc101),SUM(xccc102),SUM(xccc102a),SUM(xccc102b),SUM(xccc102c),SUM(xccc102d),SUM(xccc102e),SUM(xccc102f),SUM(xccc102g),SUM(xccc102h),",      #第3行-库存期初
               "        SUM(xccc201),SUM(xccc202),SUM(xccc202a),SUM(xccc202b),SUM(xccc202c),SUM(xccc202d),SUM(xccc202e),SUM(xccc202f),SUM(xccc202g),SUM(xccc202h),",      #第4行-一般采购
               "        SUM(xccc203),SUM(xccc204),SUM(xccc204a),SUM(xccc204b),SUM(xccc204c),SUM(xccc204d),SUM(xccc204e),SUM(xccc204f),SUM(xccc204g),SUM(xccc204h),",      #第5行-委外入库
               "        SUM(xccc205),SUM(xccc206),SUM(xccc206a),SUM(xccc206b),SUM(xccc206c),SUM(xccc206d),SUM(xccc206e),SUM(xccc206f),SUM(xccc206g),SUM(xccc206h),",      #第6行-工单入库
               "        SUM(xccc209),SUM(xccc210),SUM(xccc210a),SUM(xccc210b),SUM(xccc210c),SUM(xccc210d),SUM(xccc210e),SUM(xccc210f),SUM(xccc210g),SUM(xccc210h),",      #第7行-返工入库
               "        SUM(xccc211),SUM(xccc212),SUM(xccc212a),SUM(xccc212b),SUM(xccc212c),SUM(xccc212d),SUM(xccc212e),SUM(xccc212f),SUM(xccc212g),SUM(xccc212h),",      #第8行-杂项入库
               "        SUM(xccc217),SUM(xccc218),SUM(xccc218a),SUM(xccc218b),SUM(xccc218c),SUM(xccc218d),SUM(xccc218e),SUM(xccc218f),SUM(xccc218g),SUM(xccc218h),",      #第9行-调拨入库 #151231-00002   当站下线改为调拨入库
               "        SUM(xccc215),SUM(xccc216),SUM(xccc216a),SUM(xccc216b),SUM(xccc216c),SUM(xccc216d),SUM(xccc216e),SUM(xccc216f),SUM(xccc216g),SUM(xccc216h),",      #第10行-销退成本 参数设置销退作为入项写xccc215/xccc216
               "        SUM(xccc213),SUM(xccc214),SUM(xccc214a),SUM(xccc214b),SUM(xccc214c),SUM(xccc214d),SUM(xccc214e),SUM(xccc214f),SUM(xccc214g),SUM(xccc214h),",      #第11行-当站下线和入库调整  #151231-00002  搬到销退成本和小计之间，此处增加，改名入库调整-->当站下线和入库调整
               "        SUM(xccc201+xccc203+xccc205+xccc211+xccc217+xccc215+xccc209+xccc213),SUM(xccc202+xccc204+xccc206+xccc212+xccc218+xccc216+xccc210+xccc214),",                                #151231-00002 add xccc213,xccc214
               "        SUM(xccc202a+xccc204a+xccc206a+xccc212a+xccc218a+xccc216a+xccc210a+xccc214a),SUM(xccc202b+xccc204b+xccc206b+xccc212b+xccc218b+xccc216b+xccc210b+xccc214b),",                #151231-00002 add xccc214a,xccc214b
               "        SUM(xccc202c+xccc204c+xccc206c+xccc212c+xccc218c+xccc216c+xccc210c+xccc214c),SUM(xccc202d+xccc204d+xccc206d+xccc212d+xccc218d+xccc216d+xccc210d+xccc214d),",                #151231-00002 add xccc214c,xccc214d
               "        SUM(xccc202e+xccc204e+xccc206e+xccc212e+xccc218e+xccc216e+xccc210e+xccc214e),SUM(xccc202f+xccc204f+xccc206f+xccc212f+xccc218f+xccc216f+xccc210f+xccc214f),",                #151231-00002 add xccc214e,xccc214f
               "        SUM(xccc202g+xccc204g+xccc206g+xccc212g+xccc218g+xccc216g+xccc210g+xccc214g),SUM(xccc202h+xccc204h+xccc206h+xccc212h+xccc218h+xccc216h+xccc210h+xccc214h),",        #第12行-小计                   #151231-00002 add xccc214g,xccc214h
               "        SUM(xccc207),SUM(xccc208),SUM(xccc208a),SUM(xccc208b),SUM(xccc208c),SUM(xccc208d),SUM(xccc208e),SUM(xccc208f),SUM(xccc208g),SUM(xccc208h),",      #第13行-返工领出
               "        SUM(xccc301),SUM(xccc302),SUM(xccc302a),SUM(xccc302b),SUM(xccc302c),SUM(xccc302d),SUM(xccc302e),SUM(xccc302f),SUM(xccc302g),SUM(xccc302h),",      #第14行-工单发料
               "        SUM(xccc207+xccc301),SUM(xccc208+xccc302),SUM(xccc208a+xccc302a),SUM(xccc208b+xccc302b),SUM(xccc208c+xccc302c),",
               "        SUM(xccc208d+xccc302d),SUM(xccc208e+xccc302e),SUM(xccc208f+xccc302f),SUM(xccc208g+xccc302g),SUM(xccc208h+xccc302h),",                             #第15行-小计
               "        SUM(xccc309),SUM(xccc310),SUM(xccc310a),SUM(xccc310b),SUM(xccc310c),SUM(xccc310d),SUM(xccc310e),SUM(xccc310f),SUM(xccc310g),SUM(xccc310h),",      #第16行-杂项发料
#               "        SUM(xccc213),SUM(xccc214),SUM(xccc214a),SUM(xccc214b),SUM(xccc214c),SUM(xccc214d),SUM(xccc214e),SUM(xccc214f),SUM(xccc214g),SUM(xccc214h),",      #第16行-入库调整  #151231-00002  搬到销退成本和小计之间，此处mark
               "        SUM(xccc303)+SUM(xccc305),SUM(xccc304)+SUM(xccc306),SUM(xccc304a)+SUM(xccc306a),SUM(xccc304b)+SUM(xccc306b),SUM(xccc304c)+SUM(xccc306c),",
               "        SUM(xccc304d)+SUM(xccc306d),SUM(xccc304e)+SUM(xccc306e),SUM(xccc304f)+SUM(xccc306f),SUM(xccc304g)+SUM(xccc306g),SUM(xccc304h)+SUM(xccc306h),",      #第17行-销售出货
               "        SUM(xccc307),SUM(xccc308),SUM(xccc308a),SUM(xccc308b),SUM(xccc308c),SUM(xccc308d),SUM(xccc308e),SUM(xccc308f),SUM(xccc308g),SUM(xccc308h),",      #第18行-样品出货
               "        SUM(xccc311),SUM(xccc312),SUM(xccc312a),SUM(xccc312b),SUM(xccc312c),SUM(xccc312d),SUM(xccc312e),SUM(xccc312f),SUM(xccc312g),SUM(xccc312h),",      #第19行-盘盈亏
               "        SUM(xccc313),SUM(xccc314),SUM(xccc314a),SUM(xccc314b),SUM(xccc314c),SUM(xccc314d),SUM(xccc314e),SUM(xccc314f),SUM(xccc314g),SUM(xccc314h),",      #第20行-调拨出库   #151231-00002  增加调拨出库
               "        0           ,SUM(xccc903),SUM(xccc903a),SUM(xccc903b),SUM(xccc903c),SUM(xccc903d),SUM(xccc903e),SUM(xccc903f),SUM(xccc903g),SUM(xccc903h),",      #第21行-结存调整
               "        SUM(xccc901),SUM(xccc902),SUM(xccc902a),SUM(xccc902b),SUM(xccc902c),SUM(xccc902d),SUM(xccc902e),SUM(xccc902f),SUM(xccc902g),SUM(xccc902h)",       #第22行-库存期末
               "   FROM xccc_t ",
               "  WHERE xcccent  = '",g_enterprise,"'",
               "    AND xccccomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcccld   = '",g_master.xcccld,"'",      #账套
               "    AND xccc001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xccc003  = '",g_master.xccc003,"'",     #成本计算类型
#               "    AND xccc004  = '",g_master.xccc004,"'",     #年度   #fengmy150813  mark
#               "    AND xccc005  = '",g_master.xccc005,"'"      #期别   #fengmy150813  mark
               "    AND (xccc004*12+xccc005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") "  #fengmy150813 

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xccc FROM g_sql
   DECLARE b_fill_curs_xccc CURSOR FOR axcq004_pb_xccc

#抓xcce  在制
   LET g_sql = " SELECT SUM(xcce101),SUM(xcce102),SUM(xcce102a),SUM(xcce102b),SUM(xcce102c),SUM(xcce102d),SUM(xcce102e),SUM(xcce102f),SUM(xcce102g),SUM(xcce102h),",      #第25行-在制期初    25,26,27,30行要关联imaa另外写
               "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce201 ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202 ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202a ELSE 0 END),",
               "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202b ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202c ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202d ELSE 0 END),",
               "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202e ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202f ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202g ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202h ELSE 0 END),",      #第29行-在制人工费
               "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce201 ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202 ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202a ELSE 0 END),",
               "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202b ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202c ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202d ELSE 0 END),",
               "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202e ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202f ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202g ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202h ELSE 0 END),",      #第30行-在制调整
               "        SUM(xcce301),SUM(xcce302),SUM(xcce302a),SUM(xcce302b),SUM(xcce302c),SUM(xcce302d),SUM(xcce302e),SUM(xcce302f),SUM(xcce302g),SUM(xcce302h),",      #第32行-在制转出
               "        SUM(xcce303),SUM(xcce304),SUM(xcce304a),SUM(xcce304b),SUM(xcce304c),SUM(xcce304d),SUM(xcce304e),SUM(xcce304f),SUM(xcce304g),SUM(xcce304h),",      #第33行-差异转出
               "        SUM(xcce901),SUM(xcce902),SUM(xcce902a),SUM(xcce902b),SUM(xcce902c),SUM(xcce902d),SUM(xcce902e),SUM(xcce902f),SUM(xcce902g),SUM(xcce902h)",       #第34行-在制期末
               "   FROM xcce_t ",
               "  WHERE xcceent  = '",g_enterprise,"'",
               "    AND xccecomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcceld   = '",g_master.xcccld,"'",      #账套
               "    AND xcce001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcce003  = '",g_master.xccc003,"'",     #成本计算类型
#               "    AND xcce004  = '",g_master.xccc004,"'",     #年度   #fengmy150813 mark
#               "    AND xcce005  = '",g_master.xccc005,"'"      #期别   #fengmy150813 mark
               "    AND (xcce004*12+xcce005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") "  #fengmy150813                

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcce1 FROM g_sql
   DECLARE b_fill_curs_xcce1 CURSOR FOR axcq004_pb_xcce1
  #161004-00022#2-s-mark 
  #LET g_sql = " SELECT SUM(CASE imaa004 WHEN 'M' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),",
  #            "        SUM(CASE imaa004 WHEN 'M' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),",
  #            "        SUM(CASE imaa004 WHEN 'M' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END),",      #第26行-原料投入
  #161004-00022#2-e-mark 
  #161004-00022#2-s-add  
   LET g_sql = " SELECT SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce201+xcce205+xcce207+xcce209 END),    SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202+xcce206+xcce208+xcce210 END),    SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202a+xcce206a+xcce208a+xcce210a END),",
               "        SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202b+xcce206b+xcce208b+xcce210b END),SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202c+xcce206c+xcce208c+xcce210c END),SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202d+xcce206d+xcce208d+xcce210d END),",
               "        SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202e+xcce206e+xcce208e+xcce210e END),SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202f+xcce206f+xcce208f+xcce210f END),SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202g+xcce206g+xcce208g+xcce210g END),SUM(CASE imaa004 WHEN 'A' THEN 0 ELSE xcce202h+xcce206h+xcce208h+xcce210h END),",      #第26行-原料投入           
  #161004-00022#2-e-add             
               "        SUM(CASE imaa004 WHEN 'A' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),",
               "        SUM(CASE imaa004 WHEN 'A' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),",
               "        SUM(CASE imaa004 WHEN 'A' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END)",       #第27行-半成品投入
               "   FROM xcce_t,imaa_t ",
               "  WHERE xcceent  = '",g_enterprise,"'",
               "    AND xccecomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcceld   = '",g_master.xcccld,"'",      #账套
               "    AND xcce001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcce003  = '",g_master.xccc003,"'",     #成本计算类型
#               "    AND xcce004  = '",g_master.xccc004,"'",     #年度   #fengmy150813  mark
#               "    AND xcce005  = '",g_master.xccc005,"'",     #期别   #fengmy150813  mark
               "    AND (xcce004*12+xcce005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") ",  #fengmy150813                 
               "    AND xcceent  = imaaent",
               "    AND xcce007  = imaa001"               

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcce2 FROM g_sql
   DECLARE b_fill_curs_xcce2 CURSOR FOR axcq004_pb_xcce2   

#抓xcci  拆件
   LET g_sql = " SELECT SUM(xcci101),SUM(xcci102),SUM(xcci102a),SUM(xcci102b),SUM(xcci102c),SUM(xcci102d),SUM(xcci102e),SUM(xcci102f),SUM(xcci102g),SUM(xcci102h),",      #第36行-拆件期初
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci201 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202a END),",
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202b END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202c END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202d END),",
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202e END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202f END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202g END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN 0 ELSE xcci202h END),",      #第37行-拆件投入
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci201 ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202 ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202a ELSE 0 END),",
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202b ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202c ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202d ELSE 0 END),",
               "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202e ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202f ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202g ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202h ELSE 0 END),",      #第38行-拆件人工费
               "        SUM(xcci301),SUM(xcci302),SUM(xcci302a),SUM(xcci302b),SUM(xcci302c),SUM(xcci302d),SUM(xcci302e),SUM(xcci302f),SUM(xcci302g),SUM(xcci302h),",      #第39行-拆件拆出
               "        SUM(xcci303),SUM(xcci304),SUM(xcci304a),SUM(xcci304b),SUM(xcci304c),SUM(xcci304d),SUM(xcci304e),SUM(xcci304f),SUM(xcci304g),SUM(xcci304h),",      #第40行-差异转出
               "        SUM(xcci901),SUM(xcci902),SUM(xcci902a),SUM(xcci902b),SUM(xcci902c),SUM(xcci902d),SUM(xcci902e),SUM(xcci902f),SUM(xcci902g),SUM(xcci902h)",       #第41行-拆件结存
               "   FROM xcci_t ",
               "  WHERE xccient  = '",g_enterprise,"'",
               "    AND xccicomp = '",g_master.xccccomp,"'",    #法人
               "    AND xccild   = '",g_master.xcccld,"'",      #账套
               "    AND xcci001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcci003  = '",g_master.xccc003,"'",     #成本计算类型
#               "    AND xcci004  = '",g_master.xccc004,"'",     #年度   #fengmy150813  mark
#               "    AND xcci005  = '",g_master.xccc005,"'"      #期别   #fengmy150813  mark
               "    AND (xcci004*12+xcci005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") "  #fengmy150813                 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcci FROM g_sql
   DECLARE b_fill_curs_xcci CURSOR FOR axcq004_pb_xcci               
               

#抓xccj  期初料件明細進出成本開賬檔
#   LET g_sql = " SELECT SUM(CASE xccj009 WHEN '+1' THEN xccj101 ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102 ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102a ELSE 0 END),",
#               "        SUM(CASE xccj009 WHEN '+1' THEN xccj102b ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102c ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102d ELSE 0 END),",
#               "        SUM(CASE xccj009 WHEN '+1' THEN xccj102e ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102f ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102g ELSE 0 END),SUM(CASE xccj009 WHEN '+1' THEN xccj102h ELSE 0 END),",      #第2行-开账调整
#               "        SUM(CASE xccj009 WHEN '-1' THEN xccj101 ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102 ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102a ELSE 0 END),",
#               "        SUM(CASE xccj009 WHEN '-1' THEN xccj102b ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102c ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102d ELSE 0 END),",
#               "        SUM(CASE xccj009 WHEN '-1' THEN xccj102e ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102f ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102g ELSE 0 END),SUM(CASE xccj009 WHEN '-1' THEN xccj102h ELSE 0 END)",       #第24行
   LET g_sql = " SELECT SUM(xccj101*xccj009),SUM(xccj102*xccj009),SUM(xccj102a*xccj009),SUM(xccj102b*xccj009),SUM(xccj102c*xccj009),SUM(xccj102d*xccj009),SUM(xccj102e*xccj009),SUM(xccj102f*xccj009),SUM(xccj102g*xccj009),SUM(xccj102h*xccj009)",       #第2行-开账调整
               "   FROM xccj_t ",
               "  WHERE xccjent  = '",g_enterprise,"'",
               "    AND xccjcomp = '",g_master.xccccomp,"'",    #法人
               "    AND xccjld   = '",g_master.xcccld,"'",      #账套
               "    AND xccj001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xccj003  = '",g_master.xccc003,"'",     #成本计算类型
#               "    AND xccj004  = '",g_master.xccc004,"'",     #年度   #fengmy150813 mark
#               "    AND xccj005  = '",g_master.xccc005,"'"      #期别   #fengmy150813 mark
               "    AND (xccj004*12+xccj005 BETWEEN ",g_yy1,"*12+",g_mm1," AND ",g_yy2,"*12+",g_mm2,") "  #fengmy150813                  
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xccj FROM g_sql
   DECLARE b_fill_curs_xccj CURSOR FOR axcq004_pb_xccj 

#fengmy150813-----begin
#跨年期查询，期初数量金额为起始年期对应值，期末数量金额为截止年期对应值
   #库存期初
   LET g_sql = " SELECT SUM(xccc101),SUM(xccc102),SUM(xccc102a),SUM(xccc102b),SUM(xccc102c),SUM(xccc102d),SUM(xccc102e),SUM(xccc102f),SUM(xccc102g),SUM(xccc102h)",      #第3行-库存期初   
               "   FROM xccc_t ",
               "  WHERE xcccent  = '",g_enterprise,"'",
               "    AND xccccomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcccld   = '",g_master.xcccld,"'",      #账套
               "    AND xccc001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xccc003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xccc004  = '",g_yy1,"'",     #年度   
               "    AND xccc005  = '",g_mm1,"'"      #期别 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xccc_qc FROM g_sql
   DECLARE b_fill_curs_xccc_qc CURSOR FOR axcq004_pb_xccc_qc
   #库存期末
   LET g_sql = " SELECT SUM(xccc901),SUM(xccc902),SUM(xccc902a),SUM(xccc902b),SUM(xccc902c),SUM(xccc902d),SUM(xccc902e),SUM(xccc902f),SUM(xccc902g),SUM(xccc902h)",    #第22行-库存期末
               "   FROM xccc_t ",
               "  WHERE xcccent  = '",g_enterprise,"'",
               "    AND xccccomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcccld   = '",g_master.xcccld,"'",      #账套
               "    AND xccc001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xccc003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xccc004  = '",g_yy2,"'",     #年度   
               "    AND xccc005  = '",g_mm2,"'"      #期别 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xccc_qm FROM g_sql
   DECLARE b_fill_curs_xccc_qm CURSOR FOR axcq004_pb_xccc_qm
   #在制期初
   LET g_sql = " SELECT SUM(xcce101),SUM(xcce102),SUM(xcce102a),SUM(xcce102b),SUM(xcce102c),SUM(xcce102d),SUM(xcce102e),SUM(xcce102f),SUM(xcce102g),SUM(xcce102h)",      #第25行-在制期初   
               "   FROM xcce_t ",
               "  WHERE xcceent  = '",g_enterprise,"'",
               "    AND xccecomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcceld   = '",g_master.xcccld,"'",      #账套
               "    AND xcce001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcce003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xcce004  = '",g_yy1,"'",     #年度   
               "    AND xcce005  = '",g_mm1,"'"      #期别
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcce_qc FROM g_sql
   DECLARE b_fill_curs_xcce_qc CURSOR FOR axcq004_pb_xcce_qc 
   #在制期末
   LET g_sql = " SELECT SUM(xcce901),SUM(xcce902),SUM(xcce902a),SUM(xcce902b),SUM(xcce902c),SUM(xcce902d),SUM(xcce902e),SUM(xcce902f),SUM(xcce902g),SUM(xcce902h)",       #第34行-在制期末
               "   FROM xcce_t ",
               "  WHERE xcceent  = '",g_enterprise,"'",
               "    AND xccecomp = '",g_master.xccccomp,"'",    #法人
               "    AND xcceld   = '",g_master.xcccld,"'",      #账套
               "    AND xcce001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcce003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xcce004  = '",g_yy2,"'",     #年度   
               "    AND xcce005  = '",g_mm2,"'"      #期别
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcce_qm FROM g_sql
   DECLARE b_fill_curs_xcce_qm CURSOR FOR axcq004_pb_xcce_qm
  #拆件期初
  LET g_sql = " SELECT SUM(xcci101),SUM(xcci102),SUM(xcci102a),SUM(xcci102b),SUM(xcci102c),SUM(xcci102d),SUM(xcci102e),SUM(xcci102f),SUM(xcci102g),SUM(xcci102h)",      #第36行-拆件期初
               "   FROM xcci_t ",
               "  WHERE xccient  = '",g_enterprise,"'",
               "    AND xccicomp = '",g_master.xccccomp,"'",    #法人
               "    AND xccild   = '",g_master.xcccld,"'",      #账套
               "    AND xcci001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcci003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xcci004  = '",g_yy1,"'",     #年度   
               "    AND xcci005  = '",g_mm1,"'"      #期别            
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcci_qc FROM g_sql
   DECLARE b_fill_curs_xcci_qc CURSOR FOR axcq004_pb_xcci_qc               
  #拆件期末
  LET g_sql = " SELECT SUM(xcci901),SUM(xcci902),SUM(xcci902a),SUM(xcci902b),SUM(xcci902c),SUM(xcci902d),SUM(xcci902e),SUM(xcci902f),SUM(xcci902g),SUM(xcci902h)",       #第41行-拆件结存
               "   FROM xcci_t ",
               "  WHERE xccient  = '",g_enterprise,"'",
               "    AND xccicomp = '",g_master.xccccomp,"'",    #法人
               "    AND xccild   = '",g_master.xcccld,"'",      #账套
               "    AND xcci001  = '",g_master.xccc001,"'",     #本位币顺序
               "    AND xcci003  = '",g_master.xccc003,"'",     #成本计算类型
               "    AND xcci004  = '",g_yy2,"'",     #年度   
               "    AND xcci005  = '",g_mm2,"'"      #期别            
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq004_pb_xcci_qm FROM g_sql
   DECLARE b_fill_curs_xcci_qm CURSOR FOR axcq004_pb_xcci_qm
#fengmy150813-----end

#定义完cursor，开始插入单身对应栏位
#3~21行，xccc的地盘         
#这里解释下，因为正常的单身每一列都是一个栏位，但是这里是每一格都是不同栏位，所以以第四行为代表，作为欺骗开发工具，告诉它这一列都是第四行的column name和type，实际插入时每一行都是自己的栏位
   OPEN b_fill_curs_xccc
   FETCH b_fill_curs_xccc INTO g_xccc_d[3].xccc201,g_xccc_d[3].xccc202,g_xccc_d[3].xccc202a,g_xccc_d[3].xccc202b,g_xccc_d[3].xccc202c,g_xccc_d[3].xccc202d,g_xccc_d[3].xccc202e,g_xccc_d[3].xccc202f,g_xccc_d[3].xccc202g,g_xccc_d[3].xccc202h,     #第3行-期初库存
                               g_xccc_d[4].xccc201,g_xccc_d[4].xccc202,g_xccc_d[4].xccc202a,g_xccc_d[4].xccc202b,g_xccc_d[4].xccc202c,g_xccc_d[4].xccc202d,g_xccc_d[4].xccc202e,g_xccc_d[4].xccc202f,g_xccc_d[4].xccc202g,g_xccc_d[4].xccc202h,     #第4行-采购入库
                               g_xccc_d[5].xccc201,g_xccc_d[5].xccc202,g_xccc_d[5].xccc202a,g_xccc_d[5].xccc202b,g_xccc_d[5].xccc202c,g_xccc_d[5].xccc202d,g_xccc_d[5].xccc202e,g_xccc_d[5].xccc202f,g_xccc_d[5].xccc202g,g_xccc_d[5].xccc202h,     #第5行-委外入库
                               g_xccc_d[6].xccc201,g_xccc_d[6].xccc202,g_xccc_d[6].xccc202a,g_xccc_d[6].xccc202b,g_xccc_d[6].xccc202c,g_xccc_d[6].xccc202d,g_xccc_d[6].xccc202e,g_xccc_d[6].xccc202f,g_xccc_d[6].xccc202g,g_xccc_d[6].xccc202h,     #第6行-工单入库
                               g_xccc_d[7].xccc201,g_xccc_d[7].xccc202,g_xccc_d[7].xccc202a,g_xccc_d[7].xccc202b,g_xccc_d[7].xccc202c,g_xccc_d[7].xccc202d,g_xccc_d[7].xccc202e,g_xccc_d[7].xccc202f,g_xccc_d[7].xccc202g,g_xccc_d[7].xccc202h,     #第7行-返工入库
                               g_xccc_d[8].xccc201,g_xccc_d[8].xccc202,g_xccc_d[8].xccc202a,g_xccc_d[8].xccc202b,g_xccc_d[8].xccc202c,g_xccc_d[8].xccc202d,g_xccc_d[8].xccc202e,g_xccc_d[8].xccc202f,g_xccc_d[8].xccc202g,g_xccc_d[8].xccc202h,     #第8行-杂项入库
                               g_xccc_d[9].xccc201,g_xccc_d[9].xccc202,g_xccc_d[9].xccc202a,g_xccc_d[9].xccc202b,g_xccc_d[9].xccc202c,g_xccc_d[9].xccc202d,g_xccc_d[9].xccc202e,g_xccc_d[9].xccc202f,g_xccc_d[9].xccc202g,g_xccc_d[9].xccc202h,     #第9行-调拨入库
                               g_xccc_d[10].xccc201,g_xccc_d[10].xccc202,g_xccc_d[10].xccc202a,g_xccc_d[10].xccc202b,g_xccc_d[10].xccc202c,g_xccc_d[10].xccc202d,g_xccc_d[10].xccc202e,g_xccc_d[10].xccc202f,g_xccc_d[10].xccc202g,g_xccc_d[10].xccc202h,     #第10行-销退成本
                               g_xccc_d[11].xccc201,g_xccc_d[11].xccc202,g_xccc_d[11].xccc202a,g_xccc_d[11].xccc202b,g_xccc_d[11].xccc202c,g_xccc_d[11].xccc202d,g_xccc_d[11].xccc202e,g_xccc_d[11].xccc202f,g_xccc_d[11].xccc202g,g_xccc_d[11].xccc202h,     #第11行-小计
                               g_xccc_d[12].xccc201,g_xccc_d[12].xccc202,g_xccc_d[12].xccc202a,g_xccc_d[12].xccc202b,g_xccc_d[12].xccc202c,g_xccc_d[12].xccc202d,g_xccc_d[12].xccc202e,g_xccc_d[12].xccc202f,g_xccc_d[12].xccc202g,g_xccc_d[12].xccc202h,     #第12行-返工领出
                               g_xccc_d[13].xccc201,g_xccc_d[13].xccc202,g_xccc_d[13].xccc202a,g_xccc_d[13].xccc202b,g_xccc_d[13].xccc202c,g_xccc_d[13].xccc202d,g_xccc_d[13].xccc202e,g_xccc_d[13].xccc202f,g_xccc_d[13].xccc202g,g_xccc_d[13].xccc202h,     #第13行-工单领用
                               g_xccc_d[14].xccc201,g_xccc_d[14].xccc202,g_xccc_d[14].xccc202a,g_xccc_d[14].xccc202b,g_xccc_d[14].xccc202c,g_xccc_d[14].xccc202d,g_xccc_d[14].xccc202e,g_xccc_d[14].xccc202f,g_xccc_d[14].xccc202g,g_xccc_d[14].xccc202h,     #第14行-小计
                               g_xccc_d[15].xccc201,g_xccc_d[15].xccc202,g_xccc_d[15].xccc202a,g_xccc_d[15].xccc202b,g_xccc_d[15].xccc202c,g_xccc_d[15].xccc202d,g_xccc_d[15].xccc202e,g_xccc_d[15].xccc202f,g_xccc_d[15].xccc202g,g_xccc_d[15].xccc202h,     #第15行-杂项发料
                               g_xccc_d[16].xccc201,g_xccc_d[16].xccc202,g_xccc_d[16].xccc202a,g_xccc_d[16].xccc202b,g_xccc_d[16].xccc202c,g_xccc_d[16].xccc202d,g_xccc_d[16].xccc202e,g_xccc_d[16].xccc202f,g_xccc_d[16].xccc202g,g_xccc_d[16].xccc202h,     #第16行-销售出货
                               g_xccc_d[17].xccc201,g_xccc_d[17].xccc202,g_xccc_d[17].xccc202a,g_xccc_d[17].xccc202b,g_xccc_d[17].xccc202c,g_xccc_d[17].xccc202d,g_xccc_d[17].xccc202e,g_xccc_d[17].xccc202f,g_xccc_d[17].xccc202g,g_xccc_d[17].xccc202h,     #第17行-销售费用
                               g_xccc_d[18].xccc201,g_xccc_d[18].xccc202,g_xccc_d[18].xccc202a,g_xccc_d[18].xccc202b,g_xccc_d[18].xccc202c,g_xccc_d[18].xccc202d,g_xccc_d[18].xccc202e,g_xccc_d[18].xccc202f,g_xccc_d[18].xccc202g,g_xccc_d[18].xccc202h,     #第18行-盘盈亏
                               g_xccc_d[19].xccc201,g_xccc_d[19].xccc202,g_xccc_d[19].xccc202a,g_xccc_d[19].xccc202b,g_xccc_d[19].xccc202c,g_xccc_d[19].xccc202d,g_xccc_d[19].xccc202e,g_xccc_d[19].xccc202f,g_xccc_d[19].xccc202g,g_xccc_d[19].xccc202h,     #第19行-调拨出库
                               g_xccc_d[20].xccc201,g_xccc_d[20].xccc202,g_xccc_d[20].xccc202a,g_xccc_d[20].xccc202b,g_xccc_d[20].xccc202c,g_xccc_d[20].xccc202d,g_xccc_d[20].xccc202e,g_xccc_d[20].xccc202f,g_xccc_d[20].xccc202g,g_xccc_d[20].xccc202h,     #第20行-结存调整
                               g_xccc_d[21].xccc201,g_xccc_d[21].xccc202,g_xccc_d[21].xccc202a,g_xccc_d[21].xccc202b,g_xccc_d[21].xccc202c,g_xccc_d[21].xccc202d,g_xccc_d[21].xccc202e,g_xccc_d[21].xccc202f,g_xccc_d[21].xccc202g,g_xccc_d[21].xccc202h,     #第21行-期末结存
                               g_xccc_d[22].xccc201,g_xccc_d[22].xccc202,g_xccc_d[22].xccc202a,g_xccc_d[22].xccc202b,g_xccc_d[22].xccc202c,g_xccc_d[22].xccc202d,g_xccc_d[22].xccc202e,g_xccc_d[22].xccc202f,g_xccc_d[22].xccc202g,g_xccc_d[22].xccc202h      #第22行-期末结存    #151231-00002 加一行，中文注释以后调                           

   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xccc" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xccc
      FREE b_fill_curs_xccc  
      RETURN
   END IF
#fengmy150813----begin--更新--期初取起始年期数据/期末取截止年期数据
   OPEN b_fill_curs_xccc_qc
   FETCH b_fill_curs_xccc_qc INTO g_xccc_d[3].xccc201,g_xccc_d[3].xccc202,g_xccc_d[3].xccc202a,g_xccc_d[3].xccc202b,g_xccc_d[3].xccc202c,g_xccc_d[3].xccc202d,g_xccc_d[3].xccc202e,g_xccc_d[3].xccc202f,g_xccc_d[3].xccc202g,g_xccc_d[3].xccc202h     #第3行-期初库存
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xccc_qc" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xccc_qc
      FREE b_fill_curs_xccc_qc  
      RETURN
   END IF
   OPEN b_fill_curs_xccc_qm
   FETCH b_fill_curs_xccc_qm INTO g_xccc_d[22].xccc201,g_xccc_d[22].xccc202,g_xccc_d[22].xccc202a,g_xccc_d[22].xccc202b,g_xccc_d[22].xccc202c,g_xccc_d[22].xccc202d,g_xccc_d[22].xccc202e,g_xccc_d[22].xccc202f,g_xccc_d[22].xccc202g,g_xccc_d[22].xccc202h      #第22行-期末结存     #151231-00002 21-->22 
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xccc_qm" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xccc_qm
      FREE b_fill_curs_xccc_qm  
      RETURN
   END IF
#fengmy150813----end 
#24,28,29,31~33行，xcce1
   OPEN b_fill_curs_xcce1
   FETCH b_fill_curs_xcce1 INTO g_xccc_d[25].xccc201,g_xccc_d[25].xccc202,g_xccc_d[25].xccc202a,g_xccc_d[25].xccc202b,g_xccc_d[25].xccc202c,g_xccc_d[25].xccc202d,g_xccc_d[25].xccc202e,g_xccc_d[25].xccc202f,g_xccc_d[25].xccc202g,g_xccc_d[25].xccc202h,     #第25行-期初在制      #151231-00002 24 -->25
                                g_xccc_d[29].xccc201,g_xccc_d[29].xccc202,g_xccc_d[29].xccc202a,g_xccc_d[29].xccc202b,g_xccc_d[29].xccc202c,g_xccc_d[29].xccc202d,g_xccc_d[29].xccc202e,g_xccc_d[29].xccc202f,g_xccc_d[29].xccc202g,g_xccc_d[29].xccc202h,     #第29行-在制人工费    #151231-00002 28 -->29
                                g_xccc_d[30].xccc201,g_xccc_d[30].xccc202,g_xccc_d[30].xccc202a,g_xccc_d[30].xccc202b,g_xccc_d[30].xccc202c,g_xccc_d[30].xccc202d,g_xccc_d[30].xccc202e,g_xccc_d[30].xccc202f,g_xccc_d[30].xccc202g,g_xccc_d[30].xccc202h,     #第30行-在制调整      #151231-00002 29 -->30
                                g_xccc_d[32].xccc201,g_xccc_d[32].xccc202,g_xccc_d[32].xccc202a,g_xccc_d[32].xccc202b,g_xccc_d[32].xccc202c,g_xccc_d[32].xccc202d,g_xccc_d[32].xccc202e,g_xccc_d[32].xccc202f,g_xccc_d[32].xccc202g,g_xccc_d[32].xccc202h,     #第32行-在制转出      #151231-00002 31 -->31
                                g_xccc_d[33].xccc201,g_xccc_d[33].xccc202,g_xccc_d[33].xccc202a,g_xccc_d[33].xccc202b,g_xccc_d[33].xccc202c,g_xccc_d[33].xccc202d,g_xccc_d[33].xccc202e,g_xccc_d[33].xccc202f,g_xccc_d[33].xccc202g,g_xccc_d[33].xccc202h,     #第33行-差异转出      #151231-00002 32 -->32
                                g_xccc_d[34].xccc201,g_xccc_d[34].xccc202,g_xccc_d[34].xccc202a,g_xccc_d[34].xccc202b,g_xccc_d[34].xccc202c,g_xccc_d[34].xccc202d,g_xccc_d[34].xccc202e,g_xccc_d[34].xccc202f,g_xccc_d[34].xccc202g,g_xccc_d[34].xccc202h      #第34行-期末在制      #151231-00002 33 -->33                                

   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcce1" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcce1
      FREE b_fill_curs_xcce1  
      RETURN
   END IF
#fengmy150813----begin--更新--期初取起始年期数据/期末取截止年期数据
   OPEN b_fill_curs_xcce_qc
   FETCH b_fill_curs_xcce_qc INTO g_xccc_d[25].xccc201,g_xccc_d[25].xccc202,g_xccc_d[25].xccc202a,g_xccc_d[25].xccc202b,g_xccc_d[25].xccc202c,g_xccc_d[25].xccc202d,g_xccc_d[25].xccc202e,g_xccc_d[25].xccc202f,g_xccc_d[25].xccc202g,g_xccc_d[25].xccc202h     #第25行-期初在制     #151231-00002 24 -->25
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcce_qc" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcce_qc
      FREE b_fill_curs_xcce_qc  
      RETURN
   END IF
   OPEN b_fill_curs_xcce_qm
   FETCH b_fill_curs_xcce_qm INTO g_xccc_d[34].xccc201,g_xccc_d[34].xccc202,g_xccc_d[34].xccc202a,g_xccc_d[34].xccc202b,g_xccc_d[34].xccc202c,g_xccc_d[34].xccc202d,g_xccc_d[34].xccc202e,g_xccc_d[34].xccc202f,g_xccc_d[34].xccc202g,g_xccc_d[34].xccc202h      #第34行-期末在制     #151231-00002 33 -->34  
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcce_qm" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcce_qm
      FREE b_fill_curs_xcce_qm  
      RETURN
   END IF
#fengmy150813----end    
#25,26,27,30   
   OPEN b_fill_curs_xcce2
   FETCH b_fill_curs_xcce2 INTO g_xccc_d[26].xccc201,g_xccc_d[26].xccc202,g_xccc_d[26].xccc202a,g_xccc_d[26].xccc202b,g_xccc_d[26].xccc202c,g_xccc_d[26].xccc202d,g_xccc_d[26].xccc202e,g_xccc_d[26].xccc202f,g_xccc_d[26].xccc202g,g_xccc_d[26].xccc202h,     #第26行-原料投入      #151231-00002 25 -->26  
                                g_xccc_d[27].xccc201,g_xccc_d[27].xccc202,g_xccc_d[27].xccc202a,g_xccc_d[27].xccc202b,g_xccc_d[27].xccc202c,g_xccc_d[27].xccc202d,g_xccc_d[27].xccc202e,g_xccc_d[27].xccc202f,g_xccc_d[27].xccc202g,g_xccc_d[27].xccc202h      #第27行-半成品投入    #151231-00002 26 -->27

   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcce2" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcce2
      FREE b_fill_curs_xcce2  
      RETURN
   END IF

#151231-00002 --begin 行数+1
   #原材料+半成品小计      28行
   LET g_xccc_d[28].xccc201 = g_xccc_d[26].xccc201 + g_xccc_d[27].xccc201
   LET g_xccc_d[28].xccc202 = g_xccc_d[26].xccc202 + g_xccc_d[27].xccc202
   LET g_xccc_d[28].xccc202a = g_xccc_d[26].xccc202a + g_xccc_d[27].xccc202a
   LET g_xccc_d[28].xccc202b = g_xccc_d[26].xccc202b + g_xccc_d[27].xccc202b
   LET g_xccc_d[28].xccc202c = g_xccc_d[26].xccc202c + g_xccc_d[27].xccc202c
   LET g_xccc_d[28].xccc202d = g_xccc_d[26].xccc202d + g_xccc_d[27].xccc202d
   LET g_xccc_d[28].xccc202e = g_xccc_d[26].xccc202e + g_xccc_d[27].xccc202e
   LET g_xccc_d[28].xccc202f = g_xccc_d[26].xccc202f + g_xccc_d[27].xccc202f
   LET g_xccc_d[28].xccc202g = g_xccc_d[26].xccc202g + g_xccc_d[27].xccc202g
   LET g_xccc_d[28].xccc202h = g_xccc_d[26].xccc202h + g_xccc_d[27].xccc202h
   
   #在制合计   31行  = 28+29+30
   LET g_xccc_d[31].xccc201 = g_xccc_d[28].xccc201 + g_xccc_d[29].xccc201 + g_xccc_d[30].xccc201
   LET g_xccc_d[31].xccc202 = g_xccc_d[28].xccc202 + g_xccc_d[29].xccc202 + g_xccc_d[30].xccc202
   LET g_xccc_d[31].xccc202a = g_xccc_d[28].xccc202a + g_xccc_d[29].xccc202a + g_xccc_d[30].xccc202a
   LET g_xccc_d[31].xccc202b = g_xccc_d[28].xccc202b + g_xccc_d[29].xccc202b + g_xccc_d[30].xccc202b
   LET g_xccc_d[31].xccc202c = g_xccc_d[28].xccc202c + g_xccc_d[29].xccc202c + g_xccc_d[30].xccc202c
   LET g_xccc_d[31].xccc202d = g_xccc_d[28].xccc202d + g_xccc_d[29].xccc202d + g_xccc_d[30].xccc202d
   LET g_xccc_d[31].xccc202e = g_xccc_d[28].xccc202e + g_xccc_d[29].xccc202e + g_xccc_d[30].xccc202e
   LET g_xccc_d[31].xccc202f = g_xccc_d[28].xccc202f + g_xccc_d[29].xccc202f + g_xccc_d[30].xccc202f
   LET g_xccc_d[31].xccc202g = g_xccc_d[28].xccc202g + g_xccc_d[29].xccc202g + g_xccc_d[30].xccc202g
   LET g_xccc_d[31].xccc202h = g_xccc_d[28].xccc202h + g_xccc_d[29].xccc202h + g_xccc_d[30].xccc202h

#35~40行 xcci
   OPEN b_fill_curs_xcci
   FETCH b_fill_curs_xcci INTO g_xccc_d[36].xccc201,g_xccc_d[36].xccc202,g_xccc_d[36].xccc202a,g_xccc_d[36].xccc202b,g_xccc_d[36].xccc202c,g_xccc_d[36].xccc202d,g_xccc_d[36].xccc202e,g_xccc_d[36].xccc202f,g_xccc_d[36].xccc202g,g_xccc_d[36].xccc202h,     #第36行-拆件期初
                               g_xccc_d[37].xccc201,g_xccc_d[37].xccc202,g_xccc_d[37].xccc202a,g_xccc_d[37].xccc202b,g_xccc_d[37].xccc202c,g_xccc_d[37].xccc202d,g_xccc_d[37].xccc202e,g_xccc_d[37].xccc202f,g_xccc_d[37].xccc202g,g_xccc_d[37].xccc202h,     #第37行-拆件投入
                               g_xccc_d[38].xccc201,g_xccc_d[38].xccc202,g_xccc_d[38].xccc202a,g_xccc_d[38].xccc202b,g_xccc_d[38].xccc202c,g_xccc_d[38].xccc202d,g_xccc_d[38].xccc202e,g_xccc_d[38].xccc202f,g_xccc_d[38].xccc202g,g_xccc_d[38].xccc202h,     #第38行-拆件人工费
                               g_xccc_d[39].xccc201,g_xccc_d[39].xccc202,g_xccc_d[39].xccc202a,g_xccc_d[39].xccc202b,g_xccc_d[39].xccc202c,g_xccc_d[39].xccc202d,g_xccc_d[39].xccc202e,g_xccc_d[39].xccc202f,g_xccc_d[39].xccc202g,g_xccc_d[39].xccc202h,     #第39行-拆件拆出
                               g_xccc_d[40].xccc201,g_xccc_d[40].xccc202,g_xccc_d[40].xccc202a,g_xccc_d[40].xccc202b,g_xccc_d[40].xccc202c,g_xccc_d[40].xccc202d,g_xccc_d[40].xccc202e,g_xccc_d[40].xccc202f,g_xccc_d[40].xccc202g,g_xccc_d[40].xccc202h,     #第40行-差异转出
                               g_xccc_d[41].xccc201,g_xccc_d[41].xccc202,g_xccc_d[41].xccc202a,g_xccc_d[41].xccc202b,g_xccc_d[41].xccc202c,g_xccc_d[41].xccc202d,g_xccc_d[41].xccc202e,g_xccc_d[41].xccc202f,g_xccc_d[41].xccc202g,g_xccc_d[41].xccc202h      #第41行-拆件结存
#151231-00002 --end 行数+1                               
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcci" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcci
      FREE b_fill_curs_xcci  
      RETURN
   END IF
#fengmy150813----begin--更新--期初取起始年期数据/期末取截止年期数据
   OPEN b_fill_curs_xcci_qc
   FETCH b_fill_curs_xcci_qc INTO g_xccc_d[36].xccc201,g_xccc_d[36].xccc202,g_xccc_d[36].xccc202a,g_xccc_d[36].xccc202b,g_xccc_d[36].xccc202c,g_xccc_d[36].xccc202d,g_xccc_d[36].xccc202e,g_xccc_d[36].xccc202f,g_xccc_d[36].xccc202g,g_xccc_d[36].xccc202h     #第36行-拆件期初   #151231-00002  35-->36
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcci_qc" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcci_qc
      FREE b_fill_curs_xcci_qc  
      RETURN
   END IF
   OPEN b_fill_curs_xcci_qm
   FETCH b_fill_curs_xcci_qm INTO g_xccc_d[41].xccc201,g_xccc_d[41].xccc202,g_xccc_d[41].xccc202a,g_xccc_d[41].xccc202b,g_xccc_d[41].xccc202c,g_xccc_d[41].xccc202d,g_xccc_d[41].xccc202e,g_xccc_d[41].xccc202f,g_xccc_d[41].xccc202g,g_xccc_d[41].xccc202h      #第41行-拆件结存    #151231-00002  35-->36  
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xcci_qm" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xcci_qm
      FREE b_fill_curs_xcci_qm  
      RETURN
   END IF
#fengmy150813----end    
#2,23行 xcci
   OPEN b_fill_curs_xccj
   FETCH b_fill_curs_xccj INTO g_xccc_d[2].xccc201,g_xccc_d[2].xccc202,g_xccc_d[2].xccc202a,g_xccc_d[2].xccc202b,g_xccc_d[2].xccc202c,g_xccc_d[2].xccc202d,g_xccc_d[2].xccc202e,g_xccc_d[2].xccc202f,g_xccc_d[2].xccc202g,g_xccc_d[2].xccc202h               #第2行-开账调整
#                               g_xccc_d[23].xccc201,g_xccc_d[23].xccc202,g_xccc_d[23].xccc202a,g_xccc_d[23].xccc202b,g_xccc_d[23].xccc202c,g_xccc_d[23].xccc202d,g_xccc_d[23].xccc202e,g_xccc_d[23].xccc202f,g_xccc_d[23].xccc202g,g_xccc_d[23].xccc202h      #第23行
                              
   IF SQLCA.sqlcode AND SQLCA.sqlcode != 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "b_fill_curs_xccj" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE b_fill_curs_xccj
      FREE b_fill_curs_xccj  
      RETURN
   END IF
   

#151231-00002 --begin 重新整理
#对所有第一列“核对项目”赋值，确切文字内容见scc-8922，注释仅为参考文字，描述不一定完全一致
   LET g_xccc_d[1].item_desc = cl_getmsg('axc-00379',g_lang)   #库存
   LET g_xccc_d[1].item = '901'                                #库存之类的仅为显示用的title行，存的项目代码是9开头，后面跟的是它在axcq004里的行数
   LET g_xccc_d[2].item = '103'                                #开账调整
   LET g_xccc_d[3].item = '101'                                #期初库存
   LET g_xccc_d[4].item = '102'                                #一般采购
   LET g_xccc_d[5].item = '117'                                #委外入库
   LET g_xccc_d[6].item = '105'                                #工单入库
   LET g_xccc_d[7].item = '115'                                #返工入库
   LET g_xccc_d[8].item = '104'                                #杂项入库
   LET g_xccc_d[9].item = '118'                                #当站下线入库
   LET g_xccc_d[10].item = '112'                               #销退入库
   LET g_xccc_d[11].item = '106'                               #当站下线和入库调整 
   LET g_xccc_d[12].item_desc = cl_getmsg('axc-00380',g_lang)  #（小计）：
   LET g_xccc_d[12].item = '911'
   LET g_xccc_d[13].item = '114'                               #返工领出
   LET g_xccc_d[14].item = '107'                               #工单领用
   LET g_xccc_d[15].item_desc = cl_getmsg('axc-00380',g_lang)  #（小计）：
   LET g_xccc_d[15].item = '914'
   LET g_xccc_d[16].item = '108'                               #杂项发料   
   LET g_xccc_d[17].item = '110'                               #销售出货
   LET g_xccc_d[18].item = '111'                               #样品出货
   LET g_xccc_d[19].item = '109'                               #盘点盈亏
   LET g_xccc_d[20].item = '119'                               #调拨出库
   LET g_xccc_d[21].item = '113'                               #结存调整
   LET g_xccc_d[22].item = '116'                               #期末结存
   LET g_xccc_d[23].item_desc = cl_getmsg('axc-00381',g_lang)  #在制下阶
   LET g_xccc_d[23].item = '922'
   LET g_xccc_d[24].item = '215'                               #开账调整
   LET g_xccc_d[25].item = '201'                               #期初在制
   LET g_xccc_d[26].item = '216'                               #原料投入
   LET g_xccc_d[27].item = '217'                               #半成品投入
   LET g_xccc_d[28].item_desc = cl_getmsg('axc-00382',g_lang)  #小计（原料+半成品）：
   LET g_xccc_d[28].item = '927'
   LET g_xccc_d[29].item = '200'                               #DL+OH+S
   LET g_xccc_d[30].item = '210'                               #ADJUST（在制调整）
   LET g_xccc_d[31].item_desc =  cl_getmsg('axc-00383',g_lang) #合计：
   LET g_xccc_d[31].item = '930'
   LET g_xccc_d[32].item = '211'                               #在制转出
   LET g_xccc_d[33].item = '212'                               #差异转出
   LET g_xccc_d[34].item = '214'                               #期末在制
   LET g_xccc_d[35].item_desc = cl_getmsg('axc-00384',g_lang)  #拆件工单下阶
   LET g_xccc_d[35].item = '934'
   LET g_xccc_d[36].item = '301'                               #拆件期初
   LET g_xccc_d[37].item = '302'                               #拆件投入
   LET g_xccc_d[38].item = '306'                               #DL+OH+S
   LET g_xccc_d[39].item = '303'                               #拆件拆出
   LET g_xccc_d[40].item = '304'                               #差异转出
   LET g_xccc_d[41].item = '305'                               #拆件结存
#151231-00002 --end 重新整理
   FOR l_cnt = 1 TO 41    #151231-00002  40-->41
#把空的栏位填0
       IF l_cnt = '1' OR l_cnt = '23' OR l_cnt = '35' THEN    #这几项不用填0   #151231-00002  22-->23  34-->35
          CONTINUE FOR           
       END IF   
       IF g_xccc_d[l_cnt].xccc201 IS NULL THEN LET g_xccc_d[l_cnt].xccc201 = 0 END IF
       IF g_xccc_d[l_cnt].xccc202 IS NULL THEN LET g_xccc_d[l_cnt].xccc202 = 0 END IF 
       IF g_xccc_d[l_cnt].xccc202a IS NULL THEN LET g_xccc_d[l_cnt].xccc202a = 0 END IF
       IF g_xccc_d[l_cnt].xccc202b IS NULL THEN LET g_xccc_d[l_cnt].xccc202b = 0 END IF
       IF g_xccc_d[l_cnt].xccc202c IS NULL THEN LET g_xccc_d[l_cnt].xccc202c = 0 END IF
       IF g_xccc_d[l_cnt].xccc202d IS NULL THEN LET g_xccc_d[l_cnt].xccc202d = 0 END IF
       IF g_xccc_d[l_cnt].xccc202e IS NULL THEN LET g_xccc_d[l_cnt].xccc202e = 0 END IF
       IF g_xccc_d[l_cnt].xccc202f IS NULL THEN LET g_xccc_d[l_cnt].xccc202f = 0 END IF
       IF g_xccc_d[l_cnt].xccc202g IS NULL THEN LET g_xccc_d[l_cnt].xccc202g = 0 END IF
       IF g_xccc_d[l_cnt].xccc202h IS NULL THEN LET g_xccc_d[l_cnt].xccc202h = 0 END IF       
       IF l_cnt = '1' OR l_cnt = '12' OR l_cnt = '15' OR l_cnt = '23' OR     #这几项不用引用scc-8922  #151231-00002  11-->12  14-->15  22-->23
          l_cnt = '28' OR l_cnt = '31' OR l_cnt = '35' THEN     #151231-00002  27-->28  30-->31  34-->35
          CONTINUE FOR           
       END IF
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = '8922'
       LET g_ref_fields[2] = g_xccc_d[l_cnt].item
       CALL ap_ref_array2(g_ref_fields," SELECT gzcbl004,gzcbl005,gzcbl006 FROM gzcbl_t WHERE gzcbl001 = ? AND gzcbl002 = ? AND gzcbl003 = '"||g_dlang||"'","") RETURNING g_rtn_fields
       LET g_xccc_d[l_cnt].item_desc = g_rtn_fields[1]
       DISPLAY BY NAME g_xccc_d[l_cnt].item_desc
   END FOR

   #end add-point

 

 

 

 
END FUNCTION
 
{</section>}
 
{<section id="axcq004.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq004_b_fill2()
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #+ 此段落由子樣板qs07產生
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整
   
   #end add-point
 
 
 
   #add-point:單身填充後
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axcq004.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq004_detail_show(ps_page)
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
 
{<section id="axcq004.filter" >}
#+ 此段落由子樣板qs13產生
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq004_filter()
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
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON item,xccc201,xccc202,xccc202a,xccc202b,xccc202c,xccc202d,xccc202e,xccc202f, 
          xccc202g,xccc202h
                          FROM s_detail1[1].b_item,s_detail1[1].b_xccc201,s_detail1[1].b_xccc202,s_detail1[1].b_xccc202a, 
                              s_detail1[1].b_xccc202b,s_detail1[1].b_xccc202c,s_detail1[1].b_xccc202d, 
                              s_detail1[1].b_xccc202e,s_detail1[1].b_xccc202f,s_detail1[1].b_xccc202g, 
                              s_detail1[1].b_xccc202h
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
                     DISPLAY axcq004_filter_parser('item') TO s_detail1[1].b_item
            DISPLAY axcq004_filter_parser('xccc201') TO s_detail1[1].b_xccc201
            DISPLAY axcq004_filter_parser('xccc202') TO s_detail1[1].b_xccc202
            DISPLAY axcq004_filter_parser('xccc202a') TO s_detail1[1].b_xccc202a
            DISPLAY axcq004_filter_parser('xccc202b') TO s_detail1[1].b_xccc202b
            DISPLAY axcq004_filter_parser('xccc202c') TO s_detail1[1].b_xccc202c
            DISPLAY axcq004_filter_parser('xccc202d') TO s_detail1[1].b_xccc202d
            DISPLAY axcq004_filter_parser('xccc202e') TO s_detail1[1].b_xccc202e
            DISPLAY axcq004_filter_parser('xccc202f') TO s_detail1[1].b_xccc202f
            DISPLAY axcq004_filter_parser('xccc202g') TO s_detail1[1].b_xccc202g
            DISPLAY axcq004_filter_parser('xccc202h') TO s_detail1[1].b_xccc202h
 
 
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
 
      CALL axcq004_filter_show('item','b_item')
   CALL axcq004_filter_show('xccc201','b_xccc201')
   CALL axcq004_filter_show('xccc202','b_xccc202')
   CALL axcq004_filter_show('xccc202a','b_xccc202a')
   CALL axcq004_filter_show('xccc202b','b_xccc202b')
   CALL axcq004_filter_show('xccc202c','b_xccc202c')
   CALL axcq004_filter_show('xccc202d','b_xccc202d')
   CALL axcq004_filter_show('xccc202e','b_xccc202e')
   CALL axcq004_filter_show('xccc202f','b_xccc202f')
   CALL axcq004_filter_show('xccc202g','b_xccc202g')
   CALL axcq004_filter_show('xccc202h','b_xccc202h')
 
   CALL axcq004_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq004.filter_parser" >}
#+ 此段落由子樣板qs14產生
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq004_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
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
 
{<section id="axcq004.filter_show" >}
#+ 此段落由子樣板qs15產生
#+ 標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq004_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq004_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq004.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 创建暂存档
# Memo...........:
# Date & Author..: 2015/3/18 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq004_create_temp_table()
   DROP TABLE axcq004_tmp;
   CREATE TEMP TABLE axcq004_tmp(
   xccccomp       LIKE xccc_t.xccccomp,
   xccccomp_desc  LIKE type_t.chr100,     
   xcccld         LIKE xccc_t.xcccld,
   xcccld_desc    LIKE type_t.chr100,
   xccc001        LIKE xccc_t.xccc001,
   xccc001_desc   LIKE type_t.chr100,
   xccc003        LIKE xccc_t.xccc003,
   xccc003_desc   LIKE type_t.chr100,
   xccc004        LIKE xccc_t.xccc004,
 # xccc004_e      LIKE xccc_t.xccc004,       #160107-00007#1 add
   xccc005        LIKE xccc_t.xccc005,
 # xccc005_e      LIKE xccc_t.xccc005,       #160107-00007#1 add 
   item           LIKE type_t.chr100,  
   item_desc      LIKE type_t.chr100,
   xccc201        LIKE xccc_t.xccc201, 
   xccc202        LIKE xccc_t.xccc202, 
   xccc202a       LIKE xccc_t.xccc202a, 
   xccc202b       LIKE xccc_t.xccc202b, 
   xccc202c       LIKE xccc_t.xccc202c, 
   xccc202d       LIKE xccc_t.xccc202d, 
   xccc202e       LIKE xccc_t.xccc202e, 
   xccc202f       LIKE xccc_t.xccc202f, 
   xccc202g       LIKE xccc_t.xccc202g, 
   xccc202h       LIKE xccc_t.xccc202h,
   xcccent        LIKE xccc_t.xcccent   
   );
END FUNCTION

################################################################################
# Descriptions...: 将当前单身数据放入暂存档
# Date & Author..: 2015/3/19 By liuym
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq004_ins_temp()
DEFINE l_cnt         LIKE type_t.num5
   FOR l_cnt=1 TO 40 
      INSERT INTO axcq004_tmp (xccccomp,xccccomp_desc,xcccld,xcccld_desc,xccc001,xccc001_desc,xccc003,xccc003_desc,xccc004,xccc005, 
                              item ,item_desc,xccc201,xccc202,xccc202a,xccc202b,xccc202c,xccc202d,xccc202e, xccc202f,xccc202g, xccc202h,xcccent)
                       VALUES (  g_master.xccccomp,g_master.xccccomp_desc,g_master.xcccld,g_master.xcccld_desc,g_master.xccc001,g_master.xccc001_desc,
                              #  g_master.xccc003,g_master.xccc003_desc,g_master.xccc004,g_master.xccc005 ,        #160107-00007#1 mark
                                 g_master.xccc003,g_master.xccc003_desc,g_yy1,g_mm1 ,                              #160107-00007#1 add 
                                 g_xccc_d[l_cnt].item,g_xccc_d[l_cnt].item_desc,g_xccc_d[l_cnt].xccc201,g_xccc_d[l_cnt].xccc202, g_xccc_d[l_cnt].xccc202a,
                                 g_xccc_d[l_cnt].xccc202b, g_xccc_d[l_cnt].xccc202c,g_xccc_d[l_cnt].xccc202d,g_xccc_d[l_cnt].xccc202e,g_xccc_d[l_cnt].xccc202f,               
                                 g_xccc_d[l_cnt].xccc202g, g_xccc_d[l_cnt].xccc202h,g_enterprise  )       
   END FOR                                 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'insert tmp'
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 

END FUNCTION

 
{</section>}
 
