#該程式已解開Section, 不再透過樣板產出!
{<section id="axcq906.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:4,PR版次:4) Build-000124
#+ 
#+ Filename...: axcq906
#+ Description: 雜項入庫成本查詢作業
#+ Creator....: 01258(2014-09-02 00:00:00)
#+ Modifier...: 03297(2015-02-25 10:34:02) -SD/PR- 02040
 
{</section>}
 
{<section id="axcq906.global" >}
#應用 i07 樣板自動產生(Version:14)
#160318-00025#10  2016/04/22 By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160816-00001#10  2016/08/17 By 08742    抓取理由碼改CALL sub
#160802-00020#9   2016/09/26 By 02097    法人:視azzi800的据點權限/帳套: 視USER的帳套權限/QBE下法人/帳套不用互相勾稽
#161019-00017#9   2016/10/19 By zhujing  据点组织开窗资料整批调整:q_ooef001调整成q_ooef001_2
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xcck_m        RECORD
   xccksite LIKE xcck_t.xccksite,
   xcck021  LIKE xcck_t.xcck021,
   xcck028  LIKE xcck_t.xcck028,
   l_sdate  LIKE xcck_t.xcck013,
   l_edate  LIKE xcck_t.xcck013,
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr80, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr80, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr80, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr80,
   inba012   LIKE  type_t.chr500   #add by zhanghr
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d        RECORD
   xccksite LIKE xcck_t.xccksite,        #20150923 add chenhz
   ooefl003 LIKE ooefl_t.ooefl003,       #20150923 add chenhz
   xcck028 LIKE xcck_t.xcck028,           #20150909 add lujh
   xcck028_desc LIKE type_t.chr80,        #20150909 add lujh
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck021_desc LIKE type_t.chr500,      
   l_inba012 LIKE type_t.chr500,                 #add by zhanghr 单身1---领用类型 l_inba012
   xcck006 LIKE xcck_t.xcck006, 
   inba008 LIKE type_t.chr500, 
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
   xcck202h LIKE xcck_t.xcck202h
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_xcck_m          type_g_xcck_m
DEFINE g_xcck_m_t        type_g_xcck_m
DEFINE g_xcck_m_o        type_g_xcck_m
DEFINE g_xcck_m_mask_o   type_g_xcck_m #轉換遮罩前資料
DEFINE g_xcck_m_mask_n   type_g_xcck_m #轉換遮罩後資料
 
   DEFINE g_xcck004_t LIKE xcck_t.xcck004
DEFINE g_xcck005_t LIKE xcck_t.xcck005
DEFINE g_xcck003_t LIKE xcck_t.xcck003
DEFINE g_xcckld_t LIKE xcck_t.xcckld
DEFINE g_xcck001_t LIKE xcck_t.xcck001
 
 
DEFINE g_xcck_d          DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t        type_g_xcck_d
DEFINE g_xcck_d_o        type_g_xcck_d
DEFINE g_xcck_d_mask_o   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩前資料
DEFINE g_xcck_d_mask_n   DYNAMIC ARRAY OF type_g_xcck_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcckld LIKE xcck_t.xcckld,
      b_xcck001 LIKE xcck_t.xcck001,
      b_xcck003 LIKE xcck_t.xcck003,
      b_xcck004 LIKE xcck_t.xcck004,
      b_xcck005 LIKE xcck_t.xcck005
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_acc                 LIKE gzcb_t.gzcb007
DEFINE g_xcck2_d             DYNAMIC ARRAY OF RECORD
       xccksite              LIKE xcck_t.xccksite,        #20150923 add chenhz
       ooefl003              LIKE ooefl_t.ooefl003,       #20150923 add chenhz
       imag011               LIKE type_t.chr10, 
       imag011_desc          LIKE type_t.chr500, 
       xcck002_1             LIKE xcck_t.xcck002,
       xcck002_1_desc        LIKE type_t.chr500,
       xcck025_1             LIKE xcck_t.xcck025,
       xcck025_1_desc        LIKE type_t.chr500,
       xcck021_1             LIKE xcck_t.xcck025,
       xcck021_1_desc        LIKE type_t.chr500,       
       xcck010_1             LIKE xcck_t.xcck010,
       xcck010_1_desc        LIKE type_t.chr500, 
       xcck010_1_desc_1      LIKE type_t.chr500,         
       xcck011_1             LIKE xcck_t.xcck011,
       xcck044_1             LIKE xcck_t.xcck044,
       xcck044_1_desc        LIKE type_t.chr500,
       xcck201_1             LIKE xcck_t.xcck201,
       xcck202_1             LIKE xcck_t.xcck202,
       xcck202a_1            LIKE xcck_t.xcck202a,
       xcck202b_1            LIKE xcck_t.xcck202b,
       xcck202c_1            LIKE xcck_t.xcck202c,
       xcck202d_1            LIKE xcck_t.xcck202d,
       xcck202e_1            LIKE xcck_t.xcck202e,
       xcck202f_1            LIKE xcck_t.xcck202f,
       xcck202g_1            LIKE xcck_t.xcck202g,
       xcck202h_1            LIKE xcck_t.xcck202h
                             END RECORD

DEFINE g_rec_b2              LIKE type_t.num5
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_para_data           LIKE type_t.chr80     #采用成本域否  #fengmy150114
DEFINE g_para_data1          LIKE type_t.chr80     #采用特性否    #fengmy150114s
#2015/4/3 fengmy add------begin----
TYPE type_g_xcck_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xcck_e
DEFINE g_sql_tmp             STRING
#2015/4/3 fengmy add------end----
#add by geza 20150806(S) 
TYPE type_g_xcck3_d RECORD
   xccksite LIKE xcck_t.xccksite,        #20150923 add chenhz
   ooefl003 LIKE ooefl_t.ooefl003,       #20150923 add chenhz
   xcck028 LIKE xcck_t.xcck028, 
   xcck028_desc LIKE type_t.chr500, 
   xcck202 LIKE xcck_t.xcck202
       END RECORD
       
DEFINE g_xcck3_d   DYNAMIC ARRAY OF type_g_xcck3_d
DEFINE g_xcck3_d_t type_g_xcck3_d
DEFINE g_xcck3_d_o type_g_xcck3_d
DEFINE g_xcck3_d_mask_o   DYNAMIC ARRAY OF type_g_xcck3_d #轉換遮罩前資料
DEFINE g_xcck3_d_mask_n   DYNAMIC ARRAY OF type_g_xcck3_d #轉換遮罩後資料
#add by geza 20150806(E) 

#chenhz
 TYPE type_g_xcck4_d RECORD
   xcck006      LIKE xcck_t.xcck006, 
   xcck013      LIKE xcck_t.xcck013,
   l_inba012_4  LIKE type_t.chr500,    #add by zhanghr 页签4--l_inba012_4---领用类型
   xcck202      LIKE xcck_t.xcck202
       END RECORD  
       
DEFINE g_xcck4_d            DYNAMIC ARRAY OF type_g_xcck4_d
DEFINE g_xcck4_d_t          type_g_xcck4_d
DEFINE g_detail_cnt_4      LIKE type_t.num10
DEFINE l_sdate          LIKE xcck_t.xcck013
DEFINE l_edate          LIKE xcck_t.xcck013
DEFINE g_sql4                 STRING
DEFINE xccksite like xcck_t.xccksite
DEFINE xcck021 like xcck_t.xcck021
DEFINE xcck028 like xcck_t.xcck028

DEFINE l_inba012_1   LIKE inba_t.inba012   #add by zhanghr

#add by chenhz 15/12/04(s) 增加保留上次查询条件功能   
 TYPE type_g_tm RECORD   #添加一个数组，用于保存上一次查询的条件
    xcckcomp     STRING,
    xcck003      STRING,
    xcckld       STRING,
    xcck001      STRING,
    xcck012      STRING,
    xcck028      STRING,
    xcck021      STRING,
    xccksite     STRING,
    inba012      STRING,
    xcck010      STRING,
    xcck017      STRING,
    l_sdate      LIKE  type_t.dat,
    l_edate      LIKE  type_t.dat 

END RECORD

DEFINE g_tm             type_g_tm  
DEFINE g_wc_cs_ld         STRING                  #160802-00020#9
DEFINE g_wc_cs_comp       STRING                  #160802-00020#9
#end add-point
   
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axcq906.main" >}
#應用 a26 樣板自動產生(Version:4)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define
   
   #end add-point   
   #add-point:main段define(客製用)
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位二]的欄位值
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint302'   #160816-00001#10 mark
   LET g_acc = s_fin_get_scc_value('24','aint302','2')  #160816-00001#10  Add
   #160802-00020#9-s
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld) RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人
#160802-00020#9-e
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xcckcomp,'',xcck004,xcck005,xcck003,'',xcckld,'',xcck001,''", 
                      " FROM xcck_t",
                      " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND  
                          xcck005=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq906_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xcckcomp,t0.xcck004,t0.xcck005,t0.xcck003,t0.xcckld,t0.xcck001,t1.ooefl003 , 
       t2.xcatl003 ,t3.glaal002 ,t4.ooail003",
               " FROM xcck_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent='"||g_enterprise||"' AND t1.ooefl001=t0.xcckcomp AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t2 ON t2.xcatlent='"||g_enterprise||"' AND t2.xcatl001=t0.xcck003 AND t2.xcatl002='"||g_dlang||"' ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent='"||g_enterprise||"' AND t3.glaalld=t0.xcckld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent='"||g_enterprise||"' AND t4.ooail001=t0.xcck001 AND t4.ooail002='"||g_dlang||"' ",
 
               " WHERE t0.xcckent = '" ||g_enterprise|| "' AND t0.xcckld = ? AND t0.xcck001 = ? AND t0.xcck003 = ? AND t0.xcck004 = ? AND t0.xcck005 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
 
   #end add-point
   PREPARE axcq906_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq906 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq906_init()   
 
      #進入選單 Menu (="N")
      CALL axcq906_ui_dialog() 
      
      #add-point:畫面關閉前
      CALL axcq906_ins_xckk()
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq906
      
   END IF 
   
   CLOSE axcq906_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
{</section>}
 
{<section id="axcq906.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq906_init()
   #add-point:init段define
   
   #end add-point
   #add-point:init段define
   
   #end add-point   
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xcck001','8914')
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1  #采用特性否       
         
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150114----end 
   CALL cl_set_combo_scc('inba012','6834')     #add by zhanghr
   LET g_flag = 'N'
   CALL cl_set_comp_visible('xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h',FALSE) 
   CALL cl_set_comp_visible('xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h',FALSE)   #mark--2015/10/01 By shiun
   CALL cl_set_comp_visible('xcck202a_1,xcck202b_1,xcck202c_1,xcck202d_1,xcck202e_1,xcck202f_1,xcck202g_1,xcck202h_1',FALSE)
    INITIALIZE g_tm.* TO NULL    #add by chenhz 15/12/04 对单头条件整个数组的值初始化
   #end add-point
   
   CALL axcq906_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axcq906.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axcq906_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point  
   #add-point:ui_dialog段define

   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog 
   IF cl_null(g_wc) OR g_wc = " 1=1" THEN
      CALL axcq906_query()
   END IF
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcck_m.* TO NULL
         CALL g_xcck_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axcq906_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axcq906_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq906_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_xcck2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2) #page2  
         
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               CALL axcq906_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx2)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               
               #控制stus哪個按鈕可以按
              


            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
           #20150806--add--str--geza
         DISPLAY ARRAY g_xcck3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axcq906_idx_chk()
               CALL axcq906_ui_detailshow()
               
               #add-point:page1自定義行為
         
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 3
            
            
            #add-point:page3自定義行為
         
            #end add-point
         
         END DISPLAY
         #20150806--add--end--geza
         
         
#chenhz        
         DISPLAY ARRAY g_xcck4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt_4)
            BEFORE DISPLAY
               LET g_current_page = 4
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               DISPLAY l_ac TO FORMONLY.h_index
               DISPLAY g_xcck4_d.getLength() TO FORMONLY.h_count
               DISPLAY ' ' TO FORMONLY.p_start
               DISPLAY ' ' TO FORMONLY.p_end
         END DISPLAY
#chenhz      
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axcq906_browser_fill("")
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axcq906_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axcq906_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
         ON ACTION According
            IF g_flag = 'N' THEN
               CALL cl_set_comp_visible('xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h',TRUE) 
              CALL cl_set_comp_visible('xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h',TRUE)   #mark--2015/10/01 By shiun
               CALL cl_set_comp_visible('xcck202a_1,xcck202b_1,xcck202c_1,xcck202d_1,xcck202e_1,xcck202f_1,xcck202g_1,xcck202h_1',TRUE)
               LET g_flag = 'Y'
            ELSE
               CALL cl_set_comp_visible('xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h',FALSE) 
               CALL cl_set_comp_visible('xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h',FALSE)   #mark--2015/10/01 By shiun
               CALL cl_set_comp_visible('xcck202a_1,xcck202b_1,xcck202c_1,xcck202d_1,xcck202e_1,xcck202f_1,xcck202g_1,xcck202h_1',FALSE)
               LET g_flag = 'N'
            END IF
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axcq906_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axcq906_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axcq906_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axcq906_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axcq906_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel
                  LET g_export_node[2] = base.typeInfo.create(g_xcck2_d)
                  LET g_export_id[2]   = "s_detail2"
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
 
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
  #mark by chenhz 15/08/20(s) 换成GR报表               
#               #add-point:ON ACTION output
#               #fengmy 2015/4/3 add ----begin-----
#               DROP TABLE axcq906_tmp;
#               #創建臨時表，存放當前單身數據
#               CALL axcq906_create_temp_table()        
#               #把單身內容放入暫存檔，以便XG調用打印
#               CALL axcq906_ins_temp()          
#               LET g_param.v = "axcq906_tmp"
#               CALL axcq906_x01('1=1',g_param.v)
#               #fengmy 2015/4/3 add ----end-----   
#               #END add-point
#mark by chenhz 15/08/20(e)
#add by chenhz 15/08/20(s)
         ####    CALL cxcq906_g01(g_wc,l_sdate,l_edate)
#add by chenhz 15/08/20(e)
               EXIT DIALOG
            END IF
 
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
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
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD xcck002
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axcq906_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axcq906_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axcq906_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq906_query()
               #add-point:ON ACTION query

               #END add-point
               #應用 a59 樣板自動產生(Version:2)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
            END IF
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL axcq906_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axcq906_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axcq906_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
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
 
{</section>}
 
{<section id="axcq906.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axcq906_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point
   #add-point:browser_search段define
   
   #end add-point   
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axcq906_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   
   #end add-point
   #add-point:browser_fill段define
   
   #end add-point   
   
   #add-point:browser_fill段動作開始前
    IF cl_null(g_wc) THEN
      LET g_wc = " xcck055 = '211'"
   ELSE
      LET g_wc = g_wc," AND xcck055 = '211'"
   END IF
#160802-00020#9-s
   #增加帳套過濾條件
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc = g_wc," AND xcckld IN ",g_wc_cs_ld
   END IF
   #增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc = g_wc," AND xcckcomp IN ",g_wc_cs_comp
   END IF
#160802-00020#9-e
   #end add-point    
 
   LET l_searchcol = "xcckld,xcck001,xcck003,xcck004,xcck005"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
 
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcck_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xcckld ",
                      ", xcck001 ",
                      ", xcck003 ",
                      ", xcck004 ",
                      ", xcck005 ",
 
                      " FROM xcck_t ",
                      " ",
                      " ",
                      " WHERE xcckent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xcck_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   LET l_wc = s_chr_replace(l_wc,"xcck","t0.xcck",0)  #160802-00020#9 add
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()        
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcckld,t0.xcck001,t0.xcck003,t0.xcck004,t0.xcck005",
                " FROM xcck_t t0",
 
                
                " WHERE t0.xcckent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcck_t")
 
   #add-point:browser_fill,sql_rank前
 
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前
   
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcck_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   FOREACH browse_cur INTO g_browser[g_cnt].b_xcckld,g_browser[g_cnt].b_xcck001,g_browser[g_cnt].b_xcck003, 
       g_browser[g_cnt].b_xcck004,g_browser[g_cnt].b_xcck005 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'Foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point  
 
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_browse THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_xcckld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcck_m.* TO NULL
      CALL g_xcck_d.clear()
 
      #add-point:browser_fill段after_clear
      
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axcq906_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
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
   
   FREE browse_pre
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axcq906_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point  
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld   
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001   
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003   
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004   
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005   
 
   EXECUTE axcq906_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck003_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck001_desc 
 
   CALL axcq906_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axcq906_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   #add-point:ui_detailshow段define
   
   #end add-point
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
      #add-point:ui_detailshow段more
      
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axcq906_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point 
   #add-point:ui_browser_refresh段define
   
   #end add-point   
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcckld = g_xcck_m.xcckld 
         AND g_browser[l_i].b_xcck001 = g_xcck_m.xcck001 
         AND g_browser[l_i].b_xcck003 = g_xcck_m.xcck003 
         AND g_browser[l_i].b_xcck004 = g_xcck_m.xcck004 
         AND g_browser[l_i].b_xcck005 = g_xcck_m.xcck005 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
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
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq906_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point 
    #add-point:cs段define

   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcck_m.* TO NULL
   CALL g_xcck_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      #mark by zhanghr str
      #      CONSTRUCT  g_wc ON xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001,xcck012,xcck028,xcck021,xccksite  #modify by chenhz
      #              FROM xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001,xcck012,xcck028_1,xcck021,xccksite    #modify by chenhz
      #mark by zhanghr end
      
      #add by zhanghr start
      CONSTRUCT  g_wc ON xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001,xcck012,xcck028,xcck021,xccksite,inba012,xcck010,xcck017
              FROM xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001,xcck012,xcck028_1,xcck021,xccksite,inba012,xcck010,xcck017
      #add by zhanghr end
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            CALL axcq906_default()
            #end add-point 
            
                 #Ctrlp:construct.c.xcckcomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            IF cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef003 = 'Y'"
            ELSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #160802-00020#9-e
#            CALL q_ooef001()                           #呼叫開窗      #161019-00017#9 marked
            CALL q_ooef001_2()                           #呼叫開窗      #161019-00017#9 add
            DISPLAY g_qryparam.return1 TO xcckcomp  #顯示到畫面上
            NEXT FIELD xcckcomp                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp
         CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckcomp
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004

            #END add-point
            
 
         #Ctrlp:construct.c.xcck004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005

            #END add-point
            
 
         #Ctrlp:construct.c.xcck005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005

            #END add-point
 
         #Ctrlp:construct.c.xcck003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck003  #顯示到畫面上
            NEXT FIELD xcck003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003
         CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck003
            #END add-point
            
 
         #Ctrlp:construct.c.xcckld
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160802-00020#9-s
            #增加帳套過濾條件
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#9-e
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckld  #顯示到畫面上
            NEXT FIELD xcckld                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcckld
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001
         CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck001
            #END add-point
            
 
         #Ctrlp:construct.c.xcck001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001
      #chenhz            
         ON ACTION controlp INFIELD xcck012
            #add-point:ON ACTION controlp INFIELD xcck001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_xcck012()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck012  #顯示到畫面上
            NEXT FIELD xcck012                     #返回原欄位
            #END add-point  
  
         ON ACTION controlp INFIELD xcck028_1
            #add-point:ON ACTION controlp INFIELD xcck001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"   #获取单前层级
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck028_1
            NEXT FIELD xcck028_1
            #END add-point
 
         ON ACTION controlp INFIELD xcck021
            #add-point:ON ACTION controlp INFIELD xcck021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck021  #顯示到畫面上
            NEXT FIELD xcck021                     #返回原欄位
            #END add-point   

         ON ACTION controlp INFIELD xccksite
            #add-point:ON ACTION controlp INFIELD xcck001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'xccksite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccksite  #顯示到畫面上
            NEXT FIELD xccksite                     #返回原欄位
            #END add-point
  #chenhz
 
 #add by chenhz 15/10/13  单头增加查询条件            
           ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
 
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xccc008()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck017  #顯示到畫面上
            NEXT FIELD xcck017                     #返回原欄位
 
 #add by chenhz 15/12/04(s)  将当前栏位值赋予g_tm的值，用以保存   
 
    AFTER FIELD xcck012
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck012
       
    AFTER FIELD xcck028
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck028
       
    AFTER FIELD xcck021
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck021
       
    AFTER FIELD xccksite
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xccksite
       
    AFTER FIELD inba012
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.inba012
       
    AFTER FIELD xcck010
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck010
       
    AFTER FIELD xcck017
       CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.xcck017
 
 #add by chenhz 15/12/04(e)
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcck002,xcck025,xcck021,xcck021_desc,l_inba012,xcck006,xcck007,xcck008,xcck009, 
          xcck013,xcck010,xcck011,xcck015,xcck015_desc,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282, 
          xcck282a,xcck282b,xcck282c,xcck282d,xcck282e,xcck282f,xcck282g,xcck282h,
          xcck202,
          xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,xcck202h
           FROM s_detail1[1].xcck002,s_detail1[1].xcck025,s_detail1[1].xcck021,s_detail1[1].xcck021_desc,s_detail1[1].l_inba012, 
               s_detail1[1].xcck006,s_detail1[1].xcck007,s_detail1[1].xcck008,s_detail1[1].xcck009,s_detail1[1].xcck013, 
               s_detail1[1].xcck010,s_detail1[1].xcck011,s_detail1[1].xcck015,s_detail1[1].xcck015_desc, 
               s_detail1[1].xcck017,s_detail1[1].xcck044,s_detail1[1].xcck201,s_detail1[1].xcck040,s_detail1[1].xcck042, 
               s_detail1[1].xcck282,s_detail1[1].xcck282a,s_detail1[1].xcck282b,s_detail1[1].xcck282c,s_detail1[1].xcck282d,
               s_detail1[1].xcck282e,s_detail1[1].xcck282f,s_detail1[1].xcck282g,s_detail1[1].xcck282h,s_detail1[1].xcck202,
               s_detail1[1].xcck202a,s_detail1[1].xcck202b,s_detail1[1].xcck202c,s_detail1[1].xcck202d,s_detail1[1].xcck202e,
               s_detail1[1].xcck202f,s_detail1[1].xcck202g,s_detail1[1].xcck202h
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck002
         #應用 a03 樣板自動產生(Version:2)
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
 
         #Ctrlp:construct.c.page1.xcck025
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck025
            #add-point:ON ACTION controlp INFIELD xcck025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck025  #顯示到畫面上
            NEXT FIELD xcck025                     #返回原欄位
    
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck025
            #add-point:BEFORE FIELD xcck025

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck025
            
            #add-point:AFTER FIELD xcck025

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck021
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck021
            #add-point:ON ACTION controlp INFIELD xcck021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck021  #顯示到畫面上
            NEXT FIELD xcck021                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck021
            #add-point:BEFORE FIELD xcck021

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck021
            
            #add-point:AFTER FIELD xcck021

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck021_desc
            #add-point:BEFORE FIELD xcck021_desc

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck021_desc
            
            #add-point:AFTER FIELD xcck021_desc

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck021_desc
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck021_desc
            #add-point:ON ACTION controlp INFIELD xcck021_desc

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck006
         #應用 a03 樣板自動產生(Version:2)
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
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck013
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck010  #顯示到畫面上
            NEXT FIELD xcck010                     #返回原欄位
            #END add-point
 
         #Ctrlp:construct.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:2)
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
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck015
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck015  #顯示到畫面上
            NEXT FIELD xcck015                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck015_desc
            #add-point:BEFORE FIELD xcck015_desc

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck015_desc
            
            #add-point:AFTER FIELD xcck015_desc

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck015_desc
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck015_desc
            #add-point:ON ACTION controlp INFIELD xcck015_desc

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck017
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017

            #END add-point
 
         #Ctrlp:construct.c.page1.xcck044
         #應用 a03 樣板自動產生(Version:2)
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
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044

            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck201
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck040
            #add-point:BEFORE FIELD xcck040

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck040
            
            #add-point:AFTER FIELD xcck040

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck040
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck040
            #add-point:ON ACTION controlp INFIELD xcck040
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooai001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcck040  #顯示到畫面上
            NEXT FIELD xcck040                     #返回原欄位
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck042
            #add-point:BEFORE FIELD xcck042

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck042
            
            #add-point:AFTER FIELD xcck042

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck042
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck042
            #add-point:ON ACTION controlp INFIELD xcck042

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck282
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282

            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xcck202
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202

            #END add-point
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct
 #chenhz
       INPUT l_sdate,l_edate
          FROM l_sdate,l_edate
       END INPUT
 #chenhz
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog
#add by chenhz 15/08/18 (s) 使单身能够录入查询条件    
      
            LET g_xcck_d[1].xcck002 = ""
            DISPLAY ARRAY g_xcck_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
            END DISPLAY   
#add by chenhz 15/08/18 (e) 

#chenhz
    LET l_sdate = g_today
    LET l_edate = g_today
    DISPLAY l_sdate TO l_sdate
    DISPLAY l_edate TO l_edate
#chenhz    

         IF cl_null(g_tm.xccksite) THEN
            LET  g_tm.xccksite = g_site  
            DISPLAY g_tm.xccksite TO xccksite
         END IF

         DISPLAY g_tm.xcckcomp  TO  xcckcomp
         DISPLAY g_tm.xcck003   TO  xcck003 
         DISPLAY g_tm.xcckld    TO  xcckld
         DISPLAY g_tm.xcck001   TO  xcck001
         DISPLAY g_tm.xcck012   TO  xcck012 
         DISPLAY g_tm.xcck028   TO  xcck028
         DISPLAY g_tm.xcck021   TO  xcck021 
         DISPLAY g_tm.xccksite  TO  xccksite
         DISPLAY g_tm.inba012   TO  inba012
         DISPLAY g_tm.xcck010   TO  xcck010 
         DISPLAY g_tm.xcck017   TO  xcck017

         IF g_tm.l_sdate IS NULL THEN
            LET l_sdate =g_today
            DISPLAY l_sdate TO l_sdate       
         ELSE
            LET l_sdate = g_tm.l_sdate    
            DISPLAY l_sdate TO l_sdate
         END IF
        
         IF g_tm.l_edate IS NULL THEN
            LET l_edate =g_today
            DISPLAY l_edate TO l_edate       
         ELSE
            LET l_edate = g_tm.l_edate    
            DISPLAY l_edate TO l_edate
         END IF
        
         
         AFTER DIALOG
         
         LET g_tm.l_sdate = l_sdate
         LET g_tm.l_edate = l_edate 
         
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
   
   #add-point:cs段after_construct

   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axcq906_query()
   DEFINE ls_wc STRING
   #add-point:query段define

   #end add-point
   #add-point:query段define

   #end add-point   
 
   #add-point:query開始前

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
   CALL g_xcck_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axcq906_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axcq906_browser_fill(g_wc)
      CALL axcq906_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
     # CALL axcq906_browser_fill("F")    #mark by zhanghr
    CALL axcq906_b_fill(g_wc)
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
#   IF g_browser.getLength() = 0 THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = "-100" 
#      LET g_errparam.popup  = TRUE 
#      CALL cl_err()
#   ELSE
#      CALL axcq906_fetch("F") 
#   END IF
   
   CALL axcq906_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axcq906_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define

   #end add-point
   #add-point:fetch段define

   #end add-point   
   
   #add-point:fetch段動作開始前
   #150805-00001#4add
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
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
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
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
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
  
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   IF g_detail_cnt > 0 THEN
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   
   LET g_xcck_m.xcckld = g_browser[g_current_idx].b_xcckld
   LET g_xcck_m.xcck001 = g_browser[g_current_idx].b_xcck001
   LET g_xcck_m.xcck003 = g_browser[g_current_idx].b_xcck003
   LET g_xcck_m.xcck004 = g_browser[g_current_idx].b_xcck004
   LET g_xcck_m.xcck005 = g_browser[g_current_idx].b_xcck005
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq906_master_referesh USING  g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck003_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck001_desc 
 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcck_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq906_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq906_set_act_visible()
   CALL axcq906_set_act_no_visible()
 
   #保存單頭舊值
   LET g_xcck_m_t.* = g_xcck_m.*
   LET g_xcck_m_o.* = g_xcck_m.*
   
   #重新顯示   
   CALL axcq906_show()
 
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.insert" >}
#+ 資料新增
PRIVATE FUNCTION axcq906_insert()
   #add-point:insert段define

   #end add-point
   #add-point:insert段define

   #end add-point   
   
   #add-point:insert段before

   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcck_d.clear()
 
 
   INITIALIZE g_xcck_m.* LIKE xcck_t.*             #DEFAULT 設定
   LET g_xcckld_t = NULL
   LET g_xcck001_t = NULL
   LET g_xcck003_t = NULL
   LET g_xcck004_t = NULL
   LET g_xcck005_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值

      #end add-point 
 
      CALL axcq906_input("a")
      
      #add-point:單頭輸入後

      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq906_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcck_m.* TO NULL
         INITIALIZE g_xcck_d TO NULL
 
         CALL axcq906_show()
         RETURN
      END IF
    
      #CALL g_xcck_d.clear()
 
      
      #add-point:單頭輸入後2

      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq906_set_act_visible()
   CALL axcq906_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = '" ||g_enterprise|| "' AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq906_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axcq906_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axcq906_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck003_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck001_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq906_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   #將資料顯示到畫面上
    #add by zhanghr str
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
         g_xcck_m.xcck003_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck001,g_xcck_m.xcck001_desc,g_xcck_m.inba012 
   #add by zhanghr end
   #mark by zhanghr 
   #   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
   #       g_xcck_m.xcck003_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck001,g_xcck_m.xcck001_desc 
   #mark by zhanghr end
   DISPLAY  g_xcck_m.xccksite TO xccksite
   DISPLAY  g_xcck_m.xcck028 TO xcck028_1
   DISPLAY  g_xcck_m.xcck021 TO xcck021
   DISPLAY  g_xcck_m.l_sdate TO l_sdate
   DISPLAY  g_xcck_m.l_edate TO l_edate 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.modify" >}
#+ 資料修改
PRIVATE FUNCTION axcq906_modify()
   #add-point:modify段define
   
   #end add-point  
   #add-point:modify段define
   
   #end add-point    
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   CALL s_transaction_begin()
   
   OPEN axcq906_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq906_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq906_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq906_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck003_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck001_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq906_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axcq906_show()
   WHILE TRUE
      LET g_xcckld_t = g_xcck_m.xcckld
      LET g_xcck001_t = g_xcck_m.xcck001
      LET g_xcck003_t = g_xcck_m.xcck003
      LET g_xcck004_t = g_xcck_m.xcck004
      LET g_xcck005_t = g_xcck_m.xcck005
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL axcq906_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xcck_m.* = g_xcck_m_t.*
         CALL axcq906_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcck_m.xcckld != g_xcckld_t 
      OR g_xcck_m.xcck001 != g_xcck001_t 
      OR g_xcck_m.xcck003 != g_xcck003_t 
      OR g_xcck_m.xcck004 != g_xcck004_t 
      OR g_xcck_m.xcck005 != g_xcck005_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #add-point:單頭(偽)修改中
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq906_set_act_visible()
   CALL axcq906_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcckent = '" ||g_enterprise|| "' AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到對應位置
   CALL axcq906_browser_fill("")
 
   CALL axcq906_idx_chk()
 
   CLOSE axcq906_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xcck_m.xcckld,'U')
   
END FUNCTION   
 
{</section>}
 
{<section id="axcq906.input" >}
#+ 資料輸入
PRIVATE FUNCTION axcq906_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
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
   #add-point:input段define

   #end add-point
   #add-point:input段define

   #end add-point   
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
#add by zhanghr str  
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
       g_xcck_m.xcck003_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck001,g_xcck_m.xcck001_desc,g_xcck_m.inba012 
   #add by zhangr end
   #mark by zhanghr str
   #   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
   #       g_xcck_m.xcck003_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck001,g_xcck_m.xcck001_desc 
   #mark by zhanghr end
   DISPLAY  g_xcck_m.xccksite TO xccksite
   DISPLAY  g_xcck_m.xcck028 TO xcck028_1
   DISPLAY  g_xcck_m.xcck021 TO xcck021
   DISPLAY  g_xcck_m.l_sdate TO l_sdate
   DISPLAY  g_xcck_m.l_edate TO l_edate     
   
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
   LET g_forupd_sql = "SELECT xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck202 FROM xcck_t WHERE xcckent=?  
       AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=? AND xcck002=? AND xcck006=?  
       AND xcck007=? AND xcck008=? AND xcck009=? FOR UPDATE"
   #add-point:input段define_sql

   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq906_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axcq906_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axcq906_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
    DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.inba012    # add by zhanghr
   DISPLAY  g_xcck_m.xccksite TO xccksite
   DISPLAY  g_xcck_m.xcck028 TO xcck028_1
   DISPLAY  g_xcck_m.xcck021 TO xcck021
   DISPLAY  g_xcck_m.l_sdate TO l_sdate
   DISPLAY  g_xcck_m.l_edate TO l_edate  
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前

   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axcq906.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
          g_xcck_m.xcck001,g_xcck_m.inba012   # add by zhanghr 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前

            #end add-point
          
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcckcomp
            
            #add-point:AFTER FIELD xcckcomp
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckcomp_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcckcomp
            #add-point:BEFORE FIELD xcckcomp

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcckcomp
            #add-point:ON CHANGE xcckcomp

            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck004
            #add-point:BEFORE FIELD xcck004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck004
            
            #add-point:AFTER FIELD xcck004
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck004
            #add-point:ON CHANGE xcck004

            #END add-point 
        #add by zhanghr str
         BEFORE FIELD inba012
            #add-point:BEFORE FIELD inba012
 
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inba012
            
            #add-point:AFTER FIELD inba012
 
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE inba012
            #add-point:ON CHANGE inba012
 
            #END add-point 
         #add by zhanghr end
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck005
            #add-point:BEFORE FIELD xcck005

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck005
            
            #add-point:AFTER FIELD xcck005
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck005
            #add-point:ON CHANGE xcck005

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck003
            
            #add-point:AFTER FIELD xcck003
            IF NOT cl_null(g_xcck_m.xcck003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcck003
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck003
            #add-point:BEFORE FIELD xcck003

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck003
            #add-point:ON CHANGE xcck003

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcckld
            
            #add-point:AFTER FIELD xcckld
            IF NOT cl_null(g_xcck_m.xcckld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcck_m.xcckld
               #160318-00025#10--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#10--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcckld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcckld_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcckld
            #add-point:BEFORE FIELD xcckld

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcckld
            #add-point:ON CHANGE xcckld

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck001
            
            #add-point:AFTER FIELD xcck001
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_m.xcck001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_m.xcck001_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcck_m.xcckld) AND NOT cl_null(g_xcck_m.xcck001) AND NOT cl_null(g_xcck_m.xcck003) AND NOT cl_null(g_xcck_m.xcck004) AND NOT cl_null(g_xcck_m.xcck005) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t  OR g_xcck_m.xcck001 != g_xcck001_t  OR g_xcck_m.xcck003 != g_xcck003_t  OR g_xcck_m.xcck004 != g_xcck004_t  OR g_xcck_m.xcck005 != g_xcck005_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck001
            #add-point:BEFORE FIELD xcck001

            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck001
            #add-point:ON CHANGE xcck001

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.xcckcomp
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcckcomp
            #add-point:ON ACTION controlp INFIELD xcckcomp

            #END add-point
 
         #Ctrlp:input.c.xcck004
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck004
            #add-point:ON ACTION controlp INFIELD xcck004

            #END add-point
 
         #Ctrlp:input.c.xcck005
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck005
            #add-point:ON ACTION controlp INFIELD xcck005

            #END add-point
 
         #Ctrlp:input.c.xcck003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck003
            #add-point:ON ACTION controlp INFIELD xcck003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcck003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcck_m.xcck003 = g_qryparam.return1              

            DISPLAY g_xcck_m.xcck003 TO xcck003              #

            NEXT FIELD xcck003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xcckld
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcckld
            #add-point:ON ACTION controlp INFIELD xcckld
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcck_m.xcckld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcck_m.xcckld = g_qryparam.return1              

            DISPLAY g_xcck_m.xcckld TO xcckld              #

            NEXT FIELD xcckld                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xcck001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck001
            #add-point:ON ACTION controlp INFIELD xcck001

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
            
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcck_m.xcckld             
                            ,g_xcck_m.xcck001   
                            ,g_xcck_m.xcck003   
                            ,g_xcck_m.xcck004   
                            ,g_xcck_m.xcck005   
               DISPLAY  g_xcck_m.xccksite TO xccksite
              DISPLAY  g_xcck_m.xcck028 TO xcck028_1
              DISPLAY  g_xcck_m.xcck021 TO xcck021
              DISPLAY  g_xcck_m.l_sdate TO l_sdate
              DISPLAY  g_xcck_m.l_edate TO l_edate
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前

               #end add-point
            
               #將遮罩欄位還原
               CALL axcq906_xcck_t_mask_restore('restore_mask_o')
            
               UPDATE xcck_t SET (xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001) = (g_xcck_m.xcckcomp, 
                   g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld,g_xcck_m.xcck001) 
 
                WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
                  AND xcck001 = g_xcck001_t
                  AND xcck003 = g_xcck003_t
                  AND xcck004 = g_xcck004_t
                  AND xcck005 = g_xcck005_t
 
               #add-point:單頭修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq906_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後

                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_xcck_m_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axcq906_xcck_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增

               #end add-point
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axcq906_detail_reproduce()
               END IF
            END IF
 
           LET g_xcckld_t = g_xcck_m.xcckld
           LET g_xcck001_t = g_xcck_m.xcck001
           LET g_xcck003_t = g_xcck_m.xcck003
           LET g_xcck004_t = g_xcck_m.xcck004
           LET g_xcck005_t = g_xcck_m.xcck005
 
           
           IF g_xcck_d.getLength() = 0 THEN
              NEXT FIELD xcck002
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axcq906.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcck_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axcq906_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            #add-point:資料輸入前
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axcq906_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axcq906_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005                          
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq906_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLOSE axcq906_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcck_d[l_ac].xcck002 IS NOT NULL
               AND g_xcck_d[l_ac].xcck006 IS NOT NULL
               AND g_xcck_d[l_ac].xcck007 IS NOT NULL
               AND g_xcck_d[l_ac].xcck008 IS NOT NULL
               AND g_xcck_d[l_ac].xcck009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcck_d_t.* = g_xcck_d[l_ac].*  #BACKUP
               LET g_xcck_d_o.* = g_xcck_d[l_ac].*  #BACKUP
               CALL axcq906_set_entry_b(l_cmd)
               #add-point:set_entry_b後
               
               #end add-point
               CALL axcq906_set_no_entry_b(l_cmd)
               OPEN axcq906_bcl USING g_enterprise,g_xcck_m.xcckld,
                                                g_xcck_m.xcck001,
                                                g_xcck_m.xcck003,
                                                g_xcck_m.xcck004,
                                                g_xcck_m.xcck005,
 
                                                g_xcck_d_t.xcck002
                                                ,g_xcck_d_t.xcck006
                                                ,g_xcck_d_t.xcck007
                                                ,g_xcck_d_t.xcck008
                                                ,g_xcck_d_t.xcck009
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axcq906_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axcq906_bcl INTO g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck021, 
                      g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009, 
                      g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015, 
                      g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040, 
                      g_xcck_d[l_ac].xcck042,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcck_d_t.xcck002 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
                  CALL axcq906_xcck_t_mask()
                  LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
                  
                  CALL axcq906_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xcck_d_t.* TO NULL
            INITIALIZE g_xcck_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcck_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份
            
            #end add-point
            LET g_xcck_d_t.* = g_xcck_d[l_ac].*     #新輸入資料
            LET g_xcck_d_o.* = g_xcck_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axcq906_set_entry_b(l_cmd)
            #add-point:set_entry_b後
            
            #end add-point
            CALL axcq906_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcck_d[li_reproduce_target].* = g_xcck_d[li_reproduce].*
 
               LET g_xcck_d[g_xcck_d.getLength()].xcck002 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck006 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck007 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck008 = NULL
               LET g_xcck_d[g_xcck_d.getLength()].xcck009 = NULL
 
            END IF
            
            #add-point:modify段before insert
            
            #end add-point  
 
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xcck_t 
             WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
               AND xcck001 = g_xcck_m.xcck001
               AND xcck003 = g_xcck_m.xcck003
               AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005
 
               AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007
               AND xcck008 = g_xcck_d[l_ac].xcck008
               AND xcck009 = g_xcck_d[l_ac].xcck009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前
               
               #end add-point
               INSERT INTO xcck_t
                           (xcckent,
                            xcckcomp,xcck004,xcck005,xcck003,xcckld,xcck001,
                            xcck002,xcck006,xcck007,xcck008,xcck009
                            ,xcck025,xcck021,xcck013,xcck010,xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck202) 
                     VALUES(g_enterprise,
                            g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld,g_xcck_m.xcck001,
                            g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008, 
                                g_xcck_d[l_ac].xcck009
                            ,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck021,g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010, 
                                g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
                                g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040, 
                                g_xcck_d[l_ac].xcck042,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202) 
 
               #add-point:單身新增中
               
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xcck_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcck_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前
               
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axcq906_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axcq906_bcl
               LET l_count = g_xcck_d.getLength()
            END IF 
            
            #add-point:單身刪除後
            
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcck_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck002
            
            #add-point:AFTER FIELD xcck002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck002
            CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck002_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck002
            #add-point:BEFORE FIELD xcck002
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck002
            #add-point:ON CHANGE xcck002
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck025
            
            #add-point:AFTER FIELD xcck025
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck025_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck025_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck025
            #add-point:BEFORE FIELD xcck025
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck025
            #add-point:ON CHANGE xcck025
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck021
            
            #add-point:AFTER FIELD xcck021


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck021
            #add-point:BEFORE FIELD xcck021
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck021
            #add-point:ON CHANGE xcck021
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck006
            #add-point:BEFORE FIELD xcck006
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck006
            
            #add-point:AFTER FIELD xcck006
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck006
            #add-point:ON CHANGE xcck006
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck007
            #add-point:BEFORE FIELD xcck007
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck007
            
            #add-point:AFTER FIELD xcck007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck007
            #add-point:ON CHANGE xcck007
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck008
            #add-point:BEFORE FIELD xcck008
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck008
            
            #add-point:AFTER FIELD xcck008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck008
            #add-point:ON CHANGE xcck008
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck009
            #add-point:BEFORE FIELD xcck009
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck009
            
            #add-point:AFTER FIELD xcck009
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcck_m.xcckld IS NOT NULL AND g_xcck_m.xcck001 IS NOT NULL AND g_xcck_m.xcck003 IS NOT NULL AND g_xcck_m.xcck004 IS NOT NULL AND g_xcck_m.xcck005 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck002 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck006 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck007 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck008 IS NOT NULL AND g_xcck_d[g_detail_idx].xcck009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcck_m.xcckld != g_xcckld_t OR g_xcck_m.xcck001 != g_xcck001_t OR g_xcck_m.xcck003 != g_xcck003_t OR g_xcck_m.xcck004 != g_xcck004_t OR g_xcck_m.xcck005 != g_xcck005_t OR g_xcck_d[g_detail_idx].xcck002 != g_xcck_d_t.xcck002 OR g_xcck_d[g_detail_idx].xcck006 != g_xcck_d_t.xcck006 OR g_xcck_d[g_detail_idx].xcck007 != g_xcck_d_t.xcck007 OR g_xcck_d[g_detail_idx].xcck008 != g_xcck_d_t.xcck008 OR g_xcck_d[g_detail_idx].xcck009 != g_xcck_d_t.xcck009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcck_t WHERE "||"xcckent = '" ||g_enterprise|| "' AND "||"xcckld = '"||g_xcck_m.xcckld ||"' AND "|| "xcck001 = '"||g_xcck_m.xcck001 ||"' AND "|| "xcck003 = '"||g_xcck_m.xcck003 ||"' AND "|| "xcck004 = '"||g_xcck_m.xcck004 ||"' AND "|| "xcck005 = '"||g_xcck_m.xcck005 ||"' AND "|| "xcck002 = '"||g_xcck_d[g_detail_idx].xcck002 ||"' AND "|| "xcck006 = '"||g_xcck_d[g_detail_idx].xcck006 ||"' AND "|| "xcck007 = '"||g_xcck_d[g_detail_idx].xcck007 ||"' AND "|| "xcck008 = '"||g_xcck_d[g_detail_idx].xcck008 ||"' AND "|| "xcck009 = '"||g_xcck_d[g_detail_idx].xcck009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck009
            #add-point:ON CHANGE xcck009
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck013
            #add-point:BEFORE FIELD xcck013
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck013
            
            #add-point:AFTER FIELD xcck013
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck013
            #add-point:ON CHANGE xcck013
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck010
            
            #add-point:AFTER FIELD xcck010
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck010_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck010
            #add-point:BEFORE FIELD xcck010
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck010
            #add-point:ON CHANGE xcck010
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck011
            #add-point:BEFORE FIELD xcck011
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck011
            
            #add-point:AFTER FIELD xcck011
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck011
            #add-point:ON CHANGE xcck011
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck015
            
            #add-point:AFTER FIELD xcck015


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck015
            #add-point:BEFORE FIELD xcck015
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck015
            #add-point:ON CHANGE xcck015
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck017
            #add-point:BEFORE FIELD xcck017
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck017
            
            #add-point:AFTER FIELD xcck017
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck017
            #add-point:ON CHANGE xcck017
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck044
            
            #add-point:AFTER FIELD xcck044
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck044
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck044_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck044_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck044
            #add-point:BEFORE FIELD xcck044
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck044
            #add-point:ON CHANGE xcck044
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck201
            #add-point:BEFORE FIELD xcck201
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck201
            
            #add-point:AFTER FIELD xcck201
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck201
            #add-point:ON CHANGE xcck201
            
            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck040
            
            #add-point:AFTER FIELD xcck040
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcck_d[l_ac].xcck040
            CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcck_d[l_ac].xcck040_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcck_d[l_ac].xcck040_desc


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck040
            #add-point:BEFORE FIELD xcck040
            
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck040
            #add-point:ON CHANGE xcck040
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck042
            #add-point:BEFORE FIELD xcck042
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck042
            
            #add-point:AFTER FIELD xcck042
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck042
            #add-point:ON CHANGE xcck042
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck282
            #add-point:BEFORE FIELD xcck282
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck282
            
            #add-point:AFTER FIELD xcck282
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck282
            #add-point:ON CHANGE xcck282
            
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD xcck202
            #add-point:BEFORE FIELD xcck202
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD xcck202
            
            #add-point:AFTER FIELD xcck202
            
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE xcck202
            #add-point:ON CHANGE xcck202
            
            #END add-point 
 
 
                  #Ctrlp:input.c.page1.xcck002
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck002
            #add-point:ON ACTION controlp INFIELD xcck002
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck025
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck025
            #add-point:ON ACTION controlp INFIELD xcck025
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck021
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck021
            #add-point:ON ACTION controlp INFIELD xcck021
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck006
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck006
            #add-point:ON ACTION controlp INFIELD xcck006
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck007
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck007
            #add-point:ON ACTION controlp INFIELD xcck007
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck008
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck008
            #add-point:ON ACTION controlp INFIELD xcck008
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck009
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck009
            #add-point:ON ACTION controlp INFIELD xcck009
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck013
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck013
            #add-point:ON ACTION controlp INFIELD xcck013
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck010
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck010
            #add-point:ON ACTION controlp INFIELD xcck010
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck011
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck011
            #add-point:ON ACTION controlp INFIELD xcck011
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck015
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck015
            #add-point:ON ACTION controlp INFIELD xcck015
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck017
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck017
            #add-point:ON ACTION controlp INFIELD xcck017
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck044
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck044
            #add-point:ON ACTION controlp INFIELD xcck044
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck201
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck201
            #add-point:ON ACTION controlp INFIELD xcck201
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck040
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck040
            #add-point:ON ACTION controlp INFIELD xcck040
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck042
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck042
            #add-point:ON ACTION controlp INFIELD xcck042
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck282
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck282
            #add-point:ON ACTION controlp INFIELD xcck282
            
            #END add-point
 
         #Ctrlp:input.c.page1.xcck202
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD xcck202
            #add-point:ON ACTION controlp INFIELD xcck202
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               CLOSE axcq906_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcck_d[l_ac].xcck002 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcck_d[l_ac].* = g_xcck_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               
               #end add-point
         
               #將遮罩欄位還原
               CALL axcq906_xcck_t_mask_restore('restore_mask_o')
         
               UPDATE xcck_t SET (xcckld,xcck001,xcck003,xcck004,xcck005,xcck002,xcck025,xcck021,xcck006, 
                   xcck007,xcck008,xcck009,xcck013,xcck010,xcck011,xcck015,xcck017,xcck044,xcck201,xcck040, 
                   xcck042,xcck282,xcck202) = (g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
                   g_xcck_m.xcck005,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck021, 
                   g_xcck_d[l_ac].xcck006,g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009, 
                   g_xcck_d[l_ac].xcck013,g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015, 
                   g_xcck_d[l_ac].xcck017,g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040, 
                   g_xcck_d[l_ac].xcck042,g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck202)
                WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld 
                 AND xcck001 = g_xcck_m.xcck001 
                 AND xcck003 = g_xcck_m.xcck003 
                 AND xcck004 = g_xcck_m.xcck004 
                 AND xcck005 = g_xcck_m.xcck005 
 
                 AND xcck002 = g_xcck_d_t.xcck002 #項次   
                 AND xcck006 = g_xcck_d_t.xcck006  
                 AND xcck007 = g_xcck_d_t.xcck007  
                 AND xcck008 = g_xcck_d_t.xcck008  
                 AND xcck009 = g_xcck_d_t.xcck009  
 
                 
               #add-point:單身修改中
               
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcck_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcck_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcck_m.xcckld
               LET gs_keys_bak[1] = g_xcckld_t
               LET gs_keys[2] = g_xcck_m.xcck001
               LET gs_keys_bak[2] = g_xcck001_t
               LET gs_keys[3] = g_xcck_m.xcck003
               LET gs_keys_bak[3] = g_xcck003_t
               LET gs_keys[4] = g_xcck_m.xcck004
               LET gs_keys_bak[4] = g_xcck004_t
               LET gs_keys[5] = g_xcck_m.xcck005
               LET gs_keys_bak[5] = g_xcck005_t
               LET gs_keys[6] = g_xcck_d[g_detail_idx].xcck002
               LET gs_keys_bak[6] = g_xcck_d_t.xcck002
               LET gs_keys[7] = g_xcck_d[g_detail_idx].xcck006
               LET gs_keys_bak[7] = g_xcck_d_t.xcck006
               LET gs_keys[8] = g_xcck_d[g_detail_idx].xcck007
               LET gs_keys_bak[8] = g_xcck_d_t.xcck007
               LET gs_keys[9] = g_xcck_d[g_detail_idx].xcck008
               LET gs_keys_bak[9] = g_xcck_d_t.xcck008
               LET gs_keys[10] = g_xcck_d[g_detail_idx].xcck009
               LET gs_keys_bak[10] = g_xcck_d_t.xcck009
               CALL axcq906_update_b('xcck_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcck_m),util.JSON.stringify(g_xcck_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axcq906_xcck_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcck_m.xcckld
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck001
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck003
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck004
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_m.xcck005
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck002
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck006
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck007
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck008
               LET ls_keys[ls_keys.getLength()+1] = g_xcck_d_t.xcck009
 
               CALL axcq906_key_update_b(ls_keys)
               
               #add-point:單身修改後
               
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcck_d[l_ac].* = g_xcck_d_t.*
               END IF
               CLOSE axcq906_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axcq906_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcck_d.getLength() = 0 THEN
               NEXT FIELD xcck002
            END IF
            #add-point:input段after input 
            
            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcck_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcck_d.getLength()+1
            
      END INPUT
 
 
      
 
      
 
      
 
    
      #add-point:input段more_input
      
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcckld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD imag011
 
            END CASE
         END IF
   
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
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
 
 
   
   #add-point:input段after_input
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axcq906_show()
   #add-point:show段define
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   #end add-point
   #add-point:show段define

   #end add-point
   
   #add-point:show段之前
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF  
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',TRUE)                    
   ELSE                        
#      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150114----end 
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axcq906_b_fill(g_wc2) #第一階單身填充
      CALL axcq906_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL axcq906_set_pk_array()
   #add-point:ON ACTION agendum
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld
      
      
   CASE g_xcck_m.xcck001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''                  
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   END CASE                             
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003, 
       g_xcck_m.xcck003_desc,g_xcck_m.xcckld,g_xcck_m.xcckld_desc,g_xcck_m.xcck001,g_xcck_m.xcck001_desc 
  DISPLAY  xccksite TO xccksite
   DISPLAY  xcck028 TO xcck028_1
   DISPLAY  xcck021 TO xcck021
   DISPLAY  l_sdate TO l_sdate
   DISPLAY  l_edate TO l_edate 
 
   CALL axcq906_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
 
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axcq906_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   #add-point:ref_show段define
   
   #end add-point 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference
   
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcck_d.getLength()
      #add-point:ref_show段d_reference
 
      #end add-point
   END FOR
   
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axcq906_reproduce()
   DEFINE l_newno     LIKE xcck_t.xcckld 
   DEFINE l_oldno     LIKE xcck_t.xcckld 
   DEFINE l_newno02     LIKE xcck_t.xcck001 
   DEFINE l_oldno02     LIKE xcck_t.xcck001 
   DEFINE l_newno03     LIKE xcck_t.xcck003 
   DEFINE l_oldno03     LIKE xcck_t.xcck003 
   DEFINE l_newno04     LIKE xcck_t.xcck004 
   DEFINE l_oldno04     LIKE xcck_t.xcck004 
   DEFINE l_newno05     LIKE xcck_t.xcck005 
   DEFINE l_oldno05     LIKE xcck_t.xcck005 
 
   DEFINE l_master    RECORD LIKE xcck_t.*
   DEFINE l_detail    RECORD LIKE xcck_t.*
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
   
   #end add-point
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcck_m.xcckld IS NULL
      OR g_xcck_m.xcck001 IS NULL
      OR g_xcck_m.xcck003 IS NULL
      OR g_xcck_m.xcck004 IS NULL
      OR g_xcck_m.xcck005 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   LET g_xcck_m.xcckld = ""
   LET g_xcck_m.xcck001 = ""
   LET g_xcck_m.xcck003 = ""
   LET g_xcck_m.xcck004 = ""
   LET g_xcck_m.xcck005 = ""
 
   LET g_master_insert = FALSE
   CALL axcq906_set_entry('a')
   CALL axcq906_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcck_m.xcck003_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
   LET g_xcck_m.xcckld_desc = ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc
   LET g_xcck_m.xcck001_desc = ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc
 
   
   CALL axcq906_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcck_m.* TO NULL
      INITIALIZE g_xcck_d TO NULL
 
      CALL axcq906_show()
      LET INT_FLAG = 0
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axcq906_set_act_visible()
   CALL axcq906_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcckent = '" ||g_enterprise|| "' AND",
                      " xcckld = '", g_xcck_m.xcckld, "' "
                      ," AND xcck001 = '", g_xcck_m.xcck001, "' "
                      ," AND xcck003 = '", g_xcck_m.xcck003, "' "
                      ," AND xcck004 = '", g_xcck_m.xcck004, "' "
                      ," AND xcck005 = '", g_xcck_m.xcck005, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axcq906_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axcq906_idx_chk()
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axcq906_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcck_t.*
 
 
   #add-point:delete段define
   
   #end add-point    
   #add-point:delete段define
   
   #end add-point 
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axcq906_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axcq906_detail AS ",
                "SELECT * FROM xcck_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axcq906_detail SELECT * FROM xcck_t 
                                         WHERE xcckent = g_enterprise AND xcckld = g_xcckld_t
                                         AND xcck001 = g_xcck001_t
                                         AND xcck003 = g_xcck003_t
                                         AND xcck004 = g_xcck004_t
                                         AND xcck005 = g_xcck005_t
 
   
   #將key修正為調整後   
   UPDATE axcq906_detail 
      #更新key欄位
      SET xcckld = g_xcck_m.xcckld
          , xcck001 = g_xcck_m.xcck001
          , xcck003 = g_xcck_m.xcck003
          , xcck004 = g_xcck_m.xcck004
          , xcck005 = g_xcck_m.xcck005
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axcq906_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axcq906_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcckld_t = g_xcck_m.xcckld
   LET g_xcck001_t = g_xcck_m.xcck001
   LET g_xcck003_t = g_xcck_m.xcck003
   LET g_xcck004_t = g_xcck_m.xcck004
   LET g_xcck005_t = g_xcck_m.xcck005
 
   
   DROP TABLE axcq906_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axcq906_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   #add-point:delete段define
   
   #end add-point
   
   IF g_xcck_m.xcckld IS NULL
   OR g_xcck_m.xcck001 IS NULL
   OR g_xcck_m.xcck003 IS NULL
   OR g_xcck_m.xcck004 IS NULL
   OR g_xcck_m.xcck005 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axcq906_cl USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004,g_xcck_m.xcck005
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axcq906_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE axcq906_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axcq906_master_referesh USING g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003,g_xcck_m.xcck004, 
       g_xcck_m.xcck005 INTO g_xcck_m.xcckcomp,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003,g_xcck_m.xcckld, 
       g_xcck_m.xcck001,g_xcck_m.xcckcomp_desc,g_xcck_m.xcck003_desc,g_xcck_m.xcckld_desc,g_xcck_m.xcck001_desc 
 
   
   #遮罩相關處理
   LET g_xcck_m_mask_o.* =  g_xcck_m.*
   CALL axcq906_xcck_t_mask()
   LET g_xcck_m_mask_n.* =  g_xcck_m.*
   
   CALL axcq906_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL axcq906_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
  
 
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM xcck_t WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
                                                               AND xcck001 = g_xcck_m.xcck001
                                                               AND xcck003 = g_xcck_m.xcck003
                                                               AND xcck004 = g_xcck_m.xcck004
                                                               AND xcck005 = g_xcck_m.xcck005
 
                                                               
      #add-point:單身刪除中
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除
      
      #end add-point
      
      CLEAR FORM
      CALL g_xcck_d.clear() 
 
     
      CALL axcq906_ui_browser_refresh()  
      #CALL axcq906_ui_headershow()  
      #CALL axcq906_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axcq906_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axcq906_browser_fill("F")
         CLEAR FORM
      END IF
       
   END IF
 
   CLOSE axcq906_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xcck_m.xcckld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axcq906.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq906_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_sql             STRING
  # DEFINE l_xcck201_sum     LIKE xcck_t.xcck201   #add--2015/10/01 By shiun
  # DEFINE l_xcck201_total   LIKE xcck_t.xcck201   #add--2015/10/01 By shiun
   DEFINE l_xcck202_sum     LIKE xcck_t.xcck202
   DEFINE l_xcck202a_sum    LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum    LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum    LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum    LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum    LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum    LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum    LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum    LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total   LIKE xcck_t.xcck202
   DEFINE l_xcck202a_total  LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total  LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total  LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total  LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total  LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total  LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total  LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total  LIKE xcck_t.xcck202h
   DEFINE l_xcck012         LIKE xcck_t.xcck012   #fengmy150228
   DEFINE g_wc2_table1  STRING 
   #end add-point     
   #add-point:b_fill段define

   #end add-point
   
   #先清空單身變數內容
   CALL g_xcck_d.clear()
 
 
   #add-point:b_fill段sql_before
#   CALL axcq906_b_fill_1()
#   RETURN
 CALL axcq906_b3_fill() #add by geza 20150806
   CALL axcq906_b4_fill() #add by chenhz 2015/09/23

  LET g_wc2_table1 = g_wc, " AND ", g_wc2
   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck202,t2.xcbfl003 ,t3.ooefl003 , 
       t4.imaal003 ,t5.oocal003 ,t6.ooail003 FROM xcck_t",   
               "",
               
                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=xcck025 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcck010 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t6 ON t6.ooailent='"||g_enterprise||"' AND t6.ooail001=xcck040 AND t6.ooail002='"||g_dlang||"' ",
 
               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after
   #fengmy150225  从飞毛腿追来  修改段
#   LET g_sql = "SELECT  UNIQUE t7.imag011,xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
#       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck202,t2.xcbfl003 ,t3.ooefl003 , 
#       t4.imaal003 ,t5.oocal003 ,t6.ooail003 FROM xcck_t",   
#               "",
#               
#                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=xcck025 AND t3.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcck010 AND t4.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
#               " LEFT JOIN ooail_t t6 ON t6.ooailent='"||g_enterprise||"' AND t6.ooail001=xcck040 AND t6.ooail002='"||g_dlang||"' ",
#               " LEFT JOIN imag_t t7 ON t7.imagent='"||g_enterprise||"' AND t7.imagsite = xcckcomp AND t7.imag001 = xcck010 ",
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?"  
   #modify--2015/10/02 By shiun--add xcck012 & xcck025(S)
#   LET g_sql = " SELECT  UNIQUE imag011,xcck002,
#       CASE xcck025 WHEN ' ' THEN (CASE xcck012 WHEN 'aint170' THEN (SELECT inbf002 FROM inbf_t WHERE inbfent = ",g_enterprise," AND inbfdocno = xcck006) ELSE (SELECT inba004 FROM inba_t WHERE inbaent = ",g_enterprise," AND inbadocno = xcck006) END) ELSE xcck025 END AS xcck025,
#       xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
#       xcck011,xcck015,xcck017,xcck044,xcck040,xcck042,xcck201,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
#       xcck282e,xcck282f,xcck282g,xcck282h,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
#       xcck202h,xcck202,xcbfl003 ,ooefl003 , 
#       imaal003 ,oocal003 ,ooail003,xcck012 FROM (",
#       "SELECT  UNIQUE imag011,xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
#       xcck011,xcck015,xcck017,xcck044,xcck040,xcck042,xcck201,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
#       xcck282e,xcck282f,xcck282g,xcck282h,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
#       xcck202h,xcck202,t2.xcbfl003 ,t3.ooefl003 , 
#       t4.imaal003 ,t5.oocal003 ,t6.ooail003,xcck012 FROM imag_t,xcck_t",   
#               "",
   #modify--2015/10/02 By shiun--add xcck012 & xcck025(E)            
#                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=xcck025 AND t3.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcck010 AND t4.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
#               " LEFT JOIN ooail_t t6 ON t6.ooailent='"||g_enterprise||"' AND t6.ooail001=xcck040 AND t6.ooail002='"||g_dlang||"' ",
# 
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? AND xcck004=? AND xcck005=?",
#               "   AND xcckent = imagent AND xcckcomp = imagsite AND xcck010 = imag001 AND ",g_wc    
#   #fengmy150225  从飞毛腿追来 修改段 end
#add by geza 20150806(S) #天和环境暂时不关联imag_t
   #20150908 add xcck028,'' lujh
   
   #mark by zhanghr str
#   LET g_sql = " SELECT  UNIQUE xccksite,'',xcck028,'',xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,    
#       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
#       xcck282e,xcck282f,xcck282g,xcck282h,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
#       xcck202h,xcbfl003 ,ooefl003 , 
#       imaal003 ,oocal003 ,ooail003 FROM (",
#       "SELECT  UNIQUE xccksite,'',xcck028,'',xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
#       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
#       xcck282e,xcck282f,xcck282g,xcck282h,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
#       xcck202h,t2.xcbfl003 ,t3.ooefl003 , 
#       t4.imaal003 ,t5.oocal003 ,t6.ooail003 FROM xcck_t",   
#               "",
#               
#                              " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
#               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=xcck025 AND t3.ooefl002='"||g_dlang||"' ",
#               " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcck010 AND t4.imaal002='"||g_dlang||"' ",
#               " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
#               " LEFT JOIN ooail_t t6 ON t6.ooailent='"||g_enterprise||"' AND t6.ooail001=xcck040 AND t6.ooail002='"||g_dlang||"' ",
#              # " LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xccksite AND ooefl002='"||g_dlang||"' ",
#             #  " LEFT JOIN ooefl_t t7 ON t7.ooeflent='"||g_enterprise||"' AND t7.ooefl001=xccksite AND t7.ooefl002='"||g_dlang||"' ",  #chenhz
#               " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? ",
#   #add by geza 20150806(E)
#               "    AND xcck013 between to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  "  #chenhz
  #mark by zhanghr end
   #add by zhanghr str
   LET g_sql = " SELECT  UNIQUE xccksite,'',xcck028,'',xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010,    
       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
       xcck282e,xcck282f,xcck282g,xcck282h,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
       xcck202h,xcbfl003 ,ooefl003 , 
       imaal003 ,oocal003 ,ooail003 FROM (",
       "SELECT  UNIQUE xccksite,'',xcck028,'',xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009,xcck013,xcck010, 
       xcck011,xcck015,xcck017,xcck044,xcck201,xcck040,xcck042,xcck282,xcck282a,xcck282b,xcck282c,xcck282d,
       xcck282e,xcck282f,xcck282g,xcck282h,xcck202,xcck202a,xcck202b,xcck202c,xcck202d,xcck202e,xcck202f,xcck202g,
       xcck202h,t2.xcbfl003 ,t3.ooefl003 , 
       t4.imaal003 ,t5.oocal003 ,t6.ooail003 FROM xcck_t",   
      " LEFT JOIN xcbfl_t t2 ON t2.xcbflent='"||g_enterprise||"' AND t2.xcbfl001=xcck002 AND t2.xcbfl002='"||g_dlang||"' ",
      " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=xcck025 AND t3.ooefl002='"||g_dlang||"' ",
      " LEFT JOIN imaal_t t4 ON t4.imaalent='"||g_enterprise||"' AND t4.imaal001=xcck010 AND t4.imaal002='"||g_dlang||"' ",
      " LEFT JOIN oocal_t t5 ON t5.oocalent='"||g_enterprise||"' AND t5.oocal001=xcck044 AND t5.oocal002='"||g_dlang||"' ",
      " LEFT JOIN ooail_t t6 ON t6.ooailent='"||g_enterprise||"' AND t6.ooail001=xcck040 AND t6.ooail002='"||g_dlang||"' ",
       " LEFT JOIN inba_t ON inbadocno = xcck006 AND inbaent = xcckent ",
      " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? ",
      "    AND xcck013 between to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  "  #chenhz

  #add by zhanghr end
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   LET g_sql = g_sql," AND xcck055 = '211'"
   LET l_sql = g_sql
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axcq906_fill_chk(1) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = g_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
         #add-point:b_fill段fill_before
     #mark by geza 20150806(S)
#      LET g_sql = l_sql, " ORDER BY imag_t.imag011,xcck_t.xcck002,xcck_t.xcck025,xcck_t.xcck021,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009)",
#                         " ORDER BY xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009" 
      #mark by geza 20150806(E)
      #add by geza 20150806(S)
      LET g_sql = l_sql, " ORDER BY xcck_t.xcck002,xcck_t.xcck025,xcck_t.xcck021,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009)",
                         " ORDER BY xcck002,xcck025,xcck021,xcck006,xcck007,xcck008,xcck009" 
      #add by geza 20150806(E)       
      #LET l_xcck201_sum = 0   #add--2015/10/01 By shiun
      LET l_xcck202_sum = 0
      LET l_xcck202a_sum = 0
      LET l_xcck202b_sum = 0
      LET l_xcck202c_sum = 0
      LET l_xcck202d_sum = 0
      LET l_xcck202e_sum = 0
      LET l_xcck202f_sum = 0
      LET l_xcck202g_sum = 0
      LET l_xcck202h_sum = 0
      #LET l_xcck201_total = 0   #add--2015/10/01 By shiun
      LET l_xcck202_total = 0
      LET l_xcck202a_total = 0
      LET l_xcck202b_total = 0
      LET l_xcck202c_total = 0
      LET l_xcck202d_total = 0
      LET l_xcck202e_total = 0
      LET l_xcck202f_total = 0
      LET l_xcck202g_total = 0
      LET l_xcck202h_total = 0
      LET g_sql_tmp = cl_sql_add_mask(g_sql)   #fengmy150402
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axcq906_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axcq906_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
                                                 
       FOREACH b_fill_cs INTO g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].ooefl003,g_xcck_d[l_ac].xcck028,g_xcck_d[l_ac].xcck028_desc,g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].xcck025,g_xcck_d[l_ac].xcck021,g_xcck_d[l_ac].xcck006,    #20150909 add g_xcck_d[l_ac].xcck028,g_xcck_d[l_ac].xcck028_desc lujh 
          g_xcck_d[l_ac].xcck007,g_xcck_d[l_ac].xcck008,g_xcck_d[l_ac].xcck009,g_xcck_d[l_ac].xcck013, 
          g_xcck_d[l_ac].xcck010,g_xcck_d[l_ac].xcck011,g_xcck_d[l_ac].xcck015,g_xcck_d[l_ac].xcck017, 
          g_xcck_d[l_ac].xcck044,g_xcck_d[l_ac].xcck201,g_xcck_d[l_ac].xcck040,g_xcck_d[l_ac].xcck042, 
          g_xcck_d[l_ac].xcck282,g_xcck_d[l_ac].xcck282a,g_xcck_d[l_ac].xcck282b,g_xcck_d[l_ac].xcck282c,
          g_xcck_d[l_ac].xcck282d,g_xcck_d[l_ac].xcck282e,g_xcck_d[l_ac].xcck282f,g_xcck_d[l_ac].xcck282g,
          g_xcck_d[l_ac].xcck282h,
          g_xcck_d[l_ac].xcck202,g_xcck_d[l_ac].xcck202a,g_xcck_d[l_ac].xcck202b,g_xcck_d[l_ac].xcck202c,
          g_xcck_d[l_ac].xcck202d,g_xcck_d[l_ac].xcck202e,g_xcck_d[l_ac].xcck202f,g_xcck_d[l_ac].xcck202g,
          g_xcck_d[l_ac].xcck202h,g_xcck_d[l_ac].xcck002_desc,g_xcck_d[l_ac].xcck025_desc, 
          g_xcck_d[l_ac].xcck010_desc,g_xcck_d[l_ac].xcck044_desc,g_xcck_d[l_ac].xcck040_desc
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         #成本分群
         SELECT imag011 INTO g_xcck_d[l_ac].imag011 FROM imag_t 
          WHERE imagent = g_enterprise AND imagsite = g_xcck_m.xcckcomp
            AND imag001 = g_xcck_d[l_ac].xcck010
         
         #chenhz
         SELECT ooefl003 INTO g_xcck_d[l_ac].ooefl003
           FROM ooefl_t
          WHERE ooeflent = g_enterprise 
            AND ooefl001 = g_xcck_d[l_ac].xccksite
            AND ooefl002 = g_dlang
#chenhz   

         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
         LET g_ref_fields[1] = g_xcck_d[l_ac].imag011                                                                                                                        
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''  
         DISPLAY BY NAME g_xcck_d[l_ac].imag011_desc 

         IF cl_null(g_xcck_d[l_ac].xcck025) THEN
            #库存调整单的成本中心没抓到-150228--begin
            LET l_xcck012 = ' ' 
            SELECT xcck012 INTO l_xcck012 FROM xcck_t
             WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld
               AND xcck001 = g_xcck_m.xcck001 AND xcck002 = g_xcck_d[l_ac].xcck002
               AND xcck003 = g_xcck_m.xcck003 AND xcck004 = g_xcck_m.xcck004
               AND xcck005 = g_xcck_m.xcck005 AND xcck006 = g_xcck_d[l_ac].xcck006
               AND xcck007 = g_xcck_d[l_ac].xcck007 AND xcck008 = g_xcck_d[l_ac].xcck008
               AND xcck009 = g_xcck_d[l_ac].xcck009
            IF l_xcck012 = 'aint170' THEN   
               SELECT inbf002 INTO g_xcck_d[l_ac].xcck025
                 FROM inbf_t
                WHERE inbfent = g_enterprise
                  AND inbfdocno = g_xcck_d[l_ac].xcck006
            ELSE
            #库存调整单的成本中心没抓到-150228--end
               SELECT inba004 INTO g_xcck_d[l_ac].xcck025
                 FROM inba_t
                WHERE inbaent = g_enterprise
                  AND inbadocno = g_xcck_d[l_ac].xcck006
            END IF
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck025
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck025_desc = '', g_rtn_fields[1] , ''
      
         LET g_xcck_d[l_ac].xcck201 = g_xcck_d[l_ac].xcck201 * g_xcck_d[l_ac].xcck009
         LET g_xcck_d[l_ac].xcck202 = g_xcck_d[l_ac].xcck202 * g_xcck_d[l_ac].xcck009
         
         CALL s_desc_get_stock_desc(g_site,g_xcck_d[l_ac].xcck015) RETURNING g_xcck_d[l_ac].xcck015_desc
   
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck010_desc = '', g_rtn_fields[1] , ''
         LET g_xcck_d[l_ac].xcck010_desc_1 = '', g_rtn_fields[2] , ''
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck021
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck021_desc = '', g_rtn_fields[1] , ''
          
         CALL s_desc_get_unit_desc(g_xcck_d[l_ac].xcck044) RETURNING g_xcck_d[l_ac].xcck044_desc
         
         #依成本域、成本中心、理由码小计
         #modify by zhanghr----调整任一xcck202为空值时，合计为空的问题
         LET l_xcck202_sum  = NVL(l_xcck202_sum,0) + NVL(g_xcck_d[l_ac].xcck202,0)
         LET l_xcck202a_sum = l_xcck202a_sum + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_sum = l_xcck202b_sum + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_sum = l_xcck202c_sum + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_sum = l_xcck202d_sum + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_sum = l_xcck202e_sum + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_sum = l_xcck202f_sum + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_sum = l_xcck202g_sum + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_sum = l_xcck202h_sum + g_xcck_d[l_ac].xcck202h
         LET l_xcck202_total = NVL(l_xcck202_total,0) + NVL(g_xcck_d[l_ac].xcck202,0)
         LET l_xcck202a_total = l_xcck202a_total + g_xcck_d[l_ac].xcck202a
         LET l_xcck202b_total = l_xcck202b_total + g_xcck_d[l_ac].xcck202b
         LET l_xcck202c_total = l_xcck202c_total + g_xcck_d[l_ac].xcck202c
         LET l_xcck202d_total = l_xcck202d_total + g_xcck_d[l_ac].xcck202d
         LET l_xcck202e_total = l_xcck202e_total + g_xcck_d[l_ac].xcck202e
         LET l_xcck202f_total = l_xcck202f_total + g_xcck_d[l_ac].xcck202f
         LET l_xcck202g_total = l_xcck202g_total + g_xcck_d[l_ac].xcck202g
         LET l_xcck202h_total = l_xcck202h_total + g_xcck_d[l_ac].xcck202h
         IF l_ac > 1 THEN
            IF g_xcck_d[l_ac].imag011 != g_xcck_d[l_ac - 1].imag011 OR g_xcck_d[l_ac].xcck002 != g_xcck_d[l_ac - 1].xcck002 OR g_xcck_d[l_ac].xcck025 != g_xcck_d[l_ac - 1].xcck025 OR g_xcck_d[l_ac].xcck021 != g_xcck_d[l_ac - 1].xcck021 THEN   
               #把当前行下移，并在当前行显示小计
               LET g_xcck_d[l_ac + 1].* = g_xcck_d[l_ac].*  
               INITIALIZE  g_xcck_d[l_ac].* TO NULL 
               #fengmy150114----begin
#               LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)
               LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)                               
               LET g_xcck_d[l_ac].xcck202 = NVL(l_xcck202_sum,0) - NVL(g_xcck_d[l_ac + 1].xcck202,0)
               LET g_xcck_d[l_ac].xcck202a = l_xcck202a_sum - g_xcck_d[l_ac + 1].xcck202a
               LET g_xcck_d[l_ac].xcck202b = l_xcck202b_sum - g_xcck_d[l_ac + 1].xcck202b
               LET g_xcck_d[l_ac].xcck202c = l_xcck202c_sum - g_xcck_d[l_ac + 1].xcck202c
               LET g_xcck_d[l_ac].xcck202d = l_xcck202d_sum - g_xcck_d[l_ac + 1].xcck202d
               LET g_xcck_d[l_ac].xcck202e = l_xcck202e_sum - g_xcck_d[l_ac + 1].xcck202e
               LET g_xcck_d[l_ac].xcck202f = l_xcck202f_sum - g_xcck_d[l_ac + 1].xcck202f
               LET g_xcck_d[l_ac].xcck202g = l_xcck202g_sum - g_xcck_d[l_ac + 1].xcck202g
               LET g_xcck_d[l_ac].xcck202h = l_xcck202h_sum - g_xcck_d[l_ac + 1].xcck202h
               LET l_ac = l_ac + 1
               LET l_xcck202_sum = NVL(g_xcck_d[l_ac].xcck202,0)
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
         #mark by zhanghr str         
         #         #fengmy150225----begin 
         #         SELECT inba008 INTO g_xcck_d[l_ac].inba008 FROM inba_t 
         #          WHERE inbaent = g_enterprise
         #            AND inbadocno = g_xcck_d[l_ac].xcck006
         #         IF cl_null(g_xcck_d[l_ac].inba008) THEN LET g_xcck_d[l_ac].inba008 = ' ' END IF
         #         #fengmy150225----end     
         #mark by zhanghr end
         
         #add by zhanghr str 
          SELECT inba008,inba012,gzcbl004 INTO g_xcck_d[l_ac].inba008, l_inba012_1,g_xcck_d[l_ac].l_inba012 
           FROM inba_t 
          LEFT JOIN gzcbl_t ON gzcbl001 = '6834' AND gzcbl002 = l_inba012_1  AND gzcbl003 = g_dlang
          WHERE inbaent = g_enterprise
            AND inbadocno = g_xcck_d[l_ac].xcck006
         IF cl_null(g_xcck_d[l_ac].inba008) THEN LET g_xcck_d[l_ac].inba008 = ' ' END IF
       #add by zhanghr end  
       
       #20150909--add--str--lujh
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_xcck_d[l_ac].xcck028
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xcck_d[l_ac].xcck028_desc = '', g_rtn_fields[1] , ''
         #20150909--add--end--lujh
         #end add-point
      
         #帶出公用欄位reference值
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
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
 
            CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more
    #最后一组小计
   #fengmy150114----begin
#   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00205",g_lang)

   LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)                   
  
   #fengmy150114----end 
   LET g_xcck_d[l_ac].xcck202 = NVL(l_xcck202_sum,0)
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
   #fengmy150114----begin
#   LET g_xcck_d[l_ac].xcck002 = cl_getmsg("axc-00204",g_lang)

   LET g_xcck_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)                   
  
   #fengmy150114----end 
   LET g_xcck_d[l_ac].xcck202 = NVL(l_xcck202_total,0)
  
  LET g_xcck_d[l_ac].xcck202a = l_xcck202a_total
   LET g_xcck_d[l_ac].xcck202b = l_xcck202b_total
   LET g_xcck_d[l_ac].xcck202c = l_xcck202c_total
   LET g_xcck_d[l_ac].xcck202d = l_xcck202d_total
   LET g_xcck_d[l_ac].xcck202e = l_xcck202e_total
   LET g_xcck_d[l_ac].xcck202f = l_xcck202f_total
   LET g_xcck_d[l_ac].xcck202g = l_xcck202g_total
   LET g_xcck_d[l_ac].xcck202h = l_xcck202h_total
   LET l_ac = l_ac + 1
   
   CALL axcq906_b_fill2(g_wc2)  #第二階單身填充  zhanghr
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcck_d.getLength()
      LET g_xcck_d_mask_o[l_ac].* =  g_xcck_d[l_ac].*
      CALL axcq906_xcck_t_mask()
      LET g_xcck_d_mask_n[l_ac].* =  g_xcck_d[l_ac].*
   END FOR
   
 
 
   FREE axcq906_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axcq906_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   #add-point:idx_chk段define
   
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
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq906_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define
   DEFINE l_xcck202_sum     LIKE xcck_t.xcck202
   DEFINE l_xcck202a_sum    LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_sum    LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_sum    LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_sum    LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_sum    LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_sum    LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_sum    LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_sum    LIKE xcck_t.xcck202h
   DEFINE l_xcck202_total   LIKE xcck_t.xcck202
   DEFINE l_xcck202a_total  LIKE xcck_t.xcck202a
   DEFINE l_xcck202b_total  LIKE xcck_t.xcck202b
   DEFINE l_xcck202c_total  LIKE xcck_t.xcck202c
   DEFINE l_xcck202d_total  LIKE xcck_t.xcck202d
   DEFINE l_xcck202e_total  LIKE xcck_t.xcck202e
   DEFINE l_xcck202f_total  LIKE xcck_t.xcck202f
   DEFINE l_xcck202g_total  LIKE xcck_t.xcck202g
   DEFINE l_xcck202h_total  LIKE xcck_t.xcck202h 
   #151207-00005#1 20151207 add by ming -----(S) 
  # DEFINE ls_wc             STRING
   #151207-00005#1 20151207 add by ming -----(E) 
   
  DEFINE g_wc2_table1  STRING 
   #end add-point
   #add-point:b_fill2段define
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcck_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後
#   #151207-00005#1 20151207 add by ming -----(S) 
#   IF cl_null(g_wc_filter) THEN
#      LET g_wc_filter = " 1=1 "
#   END IF
#
#   IF cl_null(g_wc) THEN
#      LET g_wc = " 1=1 "
#   END IF
#
#   LET ls_wc = g_wc," AND ",g_wc_filter
#   #151207-00005#1 20151207 add by ming -----(E) 
   
  LET g_wc2_table1 = g_wc, " AND ", g_wc2
  
   CALL g_xcck2_d.clear()
   
   LET g_sql = "SELECT  UNIQUE xccksite,ooefl003,imag011,'',xcck002,'',xcck025,'',xcck021,'',xcck010,'','',xcck011,xcck044,'',SUM(xcck009 * xcck201),SUM(xcck202 * xcck009),",
               " SUM(xcck202a * xcck009),SUM(xcck202b * xcck009),SUM(xcck202c * xcck009),SUM(xcck202d * xcck009),SUM(xcck202e * xcck009),SUM(xcck202f * xcck009),",
               " SUM(xcck202g * xcck009),SUM(xcck202h * xcck009) FROM xcck_t", 
               " LEFT JOIN imag_t t1 ON t1.imagent='"||g_enterprise||"' AND t1.imagsite = xcckcomp AND t1.imag001 = xcck010 ",                     
               " LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xccksite AND ooefl002='"||g_dlang||"' ",  #chenhz
               "  LEFT JOIN inba_t ON inbadocno = xcck006 AND inbaent = xcckent ",       #add by zhanghr
              " WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=?  AND xcck055 = '211' ",
               "   AND xcck013 between to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  "  #chenhz
               
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
  
   LET g_sql = g_sql, " GROUP BY xccksite,ooefl003,imag011,xcck002,xcck025,xcck021,xcck010,xcck011,xcck044 ORDER BY xcck002,xcck025,xcck021,xcck010,xcck011,xcck044"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq906_pb1 FROM g_sql
   DECLARE b_fill_cs1 CURSOR FOR axcq906_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1
   LET l_xcck202_sum  = 0
   LET l_xcck202a_sum = 0
   LET l_xcck202b_sum = 0
   LET l_xcck202c_sum = 0
   LET l_xcck202d_sum = 0
   LET l_xcck202e_sum = 0
   LET l_xcck202f_sum = 0
   LET l_xcck202g_sum = 0
   LET l_xcck202h_sum = 0
   LET l_xcck202_total  = 0
   LET l_xcck202a_total = 0
   LET l_xcck202b_total = 0
   LET l_xcck202c_total = 0
   LET l_xcck202d_total = 0
   LET l_xcck202e_total = 0
   LET l_xcck202f_total = 0
   LET l_xcck202g_total = 0
   LET l_xcck202h_total = 0
   
   OPEN b_fill_cs1 USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003 #mark by chenhz ,g_xcck_m.xcck004,g_xcck_m.xcck005
                                            
   FOREACH b_fill_cs1 INTO g_xcck2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
                        
      #add-point:b_fill段資料填充
      #成本分群
      SELECT imag011 INTO g_xcck2_d[l_ac].imag011 FROM imag_t 
       WHERE imagent = g_enterprise AND imagsite = g_xcck_m.xcckcomp
         AND imag001 = g_xcck2_d[l_ac].xcck010_1
      
      INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
      LET g_ref_fields[1] = g_xcck2_d[l_ac].imag011                                                                                                                        
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xcck2_d[l_ac].imag011_desc = '', g_rtn_fields[1] , ''  
      DISPLAY BY NAME g_xcck2_d[l_ac].imag011_desc 
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck010_1
      CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xcck2_d[l_ac].xcck010_1_desc = '', g_rtn_fields[1] , ''
      LET g_xcck2_d[l_ac].xcck010_1_desc_1 = '', g_rtn_fields[2] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck002_1
      CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xcck2_d[l_ac].xcck002_1_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck025_1
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xcck2_d[l_ac].xcck025_1_desc = '', g_rtn_fields[1] , ''
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xcck2_d[l_ac].xcck021_1
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xcck2_d[l_ac].xcck021_1_desc = '', g_rtn_fields[1] , ''
      
      CALL s_desc_get_unit_desc(g_xcck2_d[l_ac].xcck044_1) RETURNING g_xcck2_d[l_ac].xcck044_1_desc
      
      #依成本域、成本中心、理由码小计
      LET l_xcck202_sum  = NVL(l_xcck202_sum,0)  + NVL(g_xcck2_d[l_ac].xcck202_1,0)
      LET l_xcck202a_sum = l_xcck202a_sum + g_xcck2_d[l_ac].xcck202a_1
      LET l_xcck202b_sum = l_xcck202b_sum + g_xcck2_d[l_ac].xcck202b_1
      LET l_xcck202c_sum = l_xcck202c_sum + g_xcck2_d[l_ac].xcck202c_1
      LET l_xcck202d_sum = l_xcck202d_sum + g_xcck2_d[l_ac].xcck202d_1
      LET l_xcck202e_sum = l_xcck202e_sum + g_xcck2_d[l_ac].xcck202e_1
      LET l_xcck202f_sum = l_xcck202f_sum + g_xcck2_d[l_ac].xcck202f_1
      LET l_xcck202g_sum = l_xcck202g_sum + g_xcck2_d[l_ac].xcck202g_1
      LET l_xcck202h_sum = l_xcck202h_sum + g_xcck2_d[l_ac].xcck202h_1
      LET l_xcck202_total  = NVL(l_xcck202_total,0)  + NVL(g_xcck2_d[l_ac].xcck202_1,0)
      LET l_xcck202a_total = l_xcck202a_total + g_xcck2_d[l_ac].xcck202a_1
      LET l_xcck202b_total = l_xcck202b_total + g_xcck2_d[l_ac].xcck202b_1
      LET l_xcck202c_total = l_xcck202c_total + g_xcck2_d[l_ac].xcck202c_1
      LET l_xcck202d_total = l_xcck202d_total + g_xcck2_d[l_ac].xcck202d_1
      LET l_xcck202e_total = l_xcck202e_total + g_xcck2_d[l_ac].xcck202e_1
      LET l_xcck202f_total = l_xcck202f_total + g_xcck2_d[l_ac].xcck202f_1
      LET l_xcck202g_total = l_xcck202g_total + g_xcck2_d[l_ac].xcck202g_1
      LET l_xcck202h_total = l_xcck202h_total + g_xcck2_d[l_ac].xcck202h_1
      
      IF l_ac > 1 THEN
         IF g_xcck2_d[l_ac].xcck002_1 != g_xcck2_d[l_ac - 1].xcck002_1 OR g_xcck2_d[l_ac].xcck025_1 != g_xcck2_d[l_ac - 1].xcck025_1 OR g_xcck2_d[l_ac].xcck021_1 != g_xcck2_d[l_ac - 1].xcck021_1 THEN   
            #把当前行下移，并在当前行显示小计
            LET g_xcck2_d[l_ac + 1].* = g_xcck2_d[l_ac].*  
            INITIALIZE  g_xcck2_d[l_ac].* TO NULL              
            #fengmy150114----begin
#            LET g_xcck2_d[l_ac].xcck002_1 = cl_getmsg("axc-00205",g_lang)
            LET g_xcck2_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)                   
            #fengmy150114----end 
            
            LET g_xcck2_d[l_ac].xcck202_1  = NVL(l_xcck202_sum,0)  - NVL(g_xcck2_d[l_ac + 1].xcck202_1,0)
            LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum - g_xcck2_d[l_ac + 1].xcck202a_1
            LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum - g_xcck2_d[l_ac + 1].xcck202b_1
            LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum - g_xcck2_d[l_ac + 1].xcck202c_1
            LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum - g_xcck2_d[l_ac + 1].xcck202d_1
            LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum - g_xcck2_d[l_ac + 1].xcck202e_1
            LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum - g_xcck2_d[l_ac + 1].xcck202f_1
            LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum - g_xcck2_d[l_ac + 1].xcck202g_1
            LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum - g_xcck2_d[l_ac + 1].xcck202h_1
            LET l_ac = l_ac + 1
            LET l_xcck202_sum  = NVL(g_xcck2_d[l_ac].xcck202_1,0)
            LET l_xcck202a_sum = g_xcck2_d[l_ac].xcck202a_1
            LET l_xcck202b_sum = g_xcck2_d[l_ac].xcck202b_1
            LET l_xcck202c_sum = g_xcck2_d[l_ac].xcck202c_1
            LET l_xcck202d_sum = g_xcck2_d[l_ac].xcck202d_1
            LET l_xcck202e_sum = g_xcck2_d[l_ac].xcck202e_1
            LET l_xcck202f_sum = g_xcck2_d[l_ac].xcck202f_1
            LET l_xcck202g_sum = g_xcck2_d[l_ac].xcck202g_1
            LET l_xcck202h_sum = g_xcck2_d[l_ac].xcck202h_1
            
         END IF
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
   
   #最后一组小计
   #fengmy150114----begin
#   LET g_xcck2_d[l_ac].xcck002_1 = cl_getmsg("axc-00205",g_lang)

    LET g_xcck2_d[l_ac].imag011 = cl_getmsg("axc-00205",g_lang)                   

   #fengmy150114----end 
   LET g_xcck2_d[l_ac].xcck202_1  = NVL(l_xcck202_sum,0)
   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_sum 
   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_sum 
   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_sum 
   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_sum 
   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_sum 
   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_sum 
   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_sum 
   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_sum
   LET l_ac = l_ac + 1
   #合计
   #fengmy150114----begin
#   LET g_xcck2_d[l_ac].xcck002_1 = cl_getmsg("axc-00204",g_lang)

      LET g_xcck2_d[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)                   
  
   #fengmy150114----end 
   LET g_xcck2_d[l_ac].xcck202_1  = NVL(l_xcck202_total,0)
   LET g_xcck2_d[l_ac].xcck202a_1 = l_xcck202a_total
   LET g_xcck2_d[l_ac].xcck202b_1 = l_xcck202b_total
   LET g_xcck2_d[l_ac].xcck202c_1 = l_xcck202c_total
   LET g_xcck2_d[l_ac].xcck202d_1 = l_xcck202d_total
   LET g_xcck2_d[l_ac].xcck202e_1 = l_xcck202e_total
   LET g_xcck2_d[l_ac].xcck202f_1 = l_xcck202f_total
   LET g_xcck2_d[l_ac].xcck202g_1 = l_xcck202g_total
   LET g_xcck2_d[l_ac].xcck202h_1 = l_xcck202h_total
   LET l_ac = l_ac + 1
   
   FREE axcq906_pb1
   LET g_rec_b2 = l_ac - 1
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axcq906_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   #add-point:before_delete段define
   
   #end add-point 
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM xcck_t
    WHERE xcckent = g_enterprise AND xcckld = g_xcck_m.xcckld AND
                              xcck001 = g_xcck_m.xcck001 AND
                              xcck003 = g_xcck_m.xcck003 AND
                              xcck004 = g_xcck_m.xcck004 AND
                              xcck005 = g_xcck_m.xcck005 AND
 
          xcck002 = g_xcck_d_t.xcck002
      AND xcck006 = g_xcck_d_t.xcck006
      AND xcck007 = g_xcck_d_t.xcck007
      AND xcck008 = g_xcck_d_t.xcck008
      AND xcck009 = g_xcck_d_t.xcck009
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axcq906.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axcq906_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
   #add-point:delete_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axcq906_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   #add-point:insert_b段define
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axcq906_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   #add-point:update_b段define
   
   #end add-point     
   #add-point:update_b段define
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axcq906_key_update_b(ps_keys_bak)
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define
   
   #end add-point
   #add-point:update_b段define
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcck_d[l_ac].xcck002 = g_xcck_d_t.xcck002 
      AND g_xcck_d[l_ac].xcck006 = g_xcck_d_t.xcck006 
      AND g_xcck_d[l_ac].xcck007 = g_xcck_d_t.xcck007 
      AND g_xcck_d[l_ac].xcck008 = g_xcck_d_t.xcck008 
      AND g_xcck_d[l_ac].xcck009 = g_xcck_d_t.xcck009 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axcq906_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   #add-point:lock_b段define
   
   #end add-point
   
   #先刷新資料
   #CALL axcq906_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axcq906_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   #add-point:unlock_b段define
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axcq906_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
   #add-point:set_entry段define
   
   #end add-point 
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",TRUE)
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axcq906_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcckld,xcck001,xcck003,xcck004,xcck005",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axcq906_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   #add-point:set_entry_b段define
   
   #end add-point 
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axcq906_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段define
   
   #end add-point
   
   #add-point:set_no_entry_b段
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axcq906_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axcq906_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axcq906_set_act_visible_b()
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段define
   
   #end add-point
   #add-point:set_act_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq906.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axcq906_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段define
   
   #end add-point
   #add-point:set_act_no_visible_b段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq906.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axcq906_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point 
   #add-point:default_search段define
   
   #end add-point    
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcck003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcck004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcck005 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axcq906_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   #add-point:fill_chk段define
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq906.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axcq906_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段define
   
   #end add-point
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "imag011"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axcq906.mask_functions" >}
&include "erp/axc/axcq906_mask.4gl"
 
{</section>}
 
{<section id="axcq906.state_change" >}
    
 
{</section>}
 
{<section id="axcq906.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION axcq906_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xcck_m.xcckld
   LET g_pk_array[1].column = 'xcckld'
   LET g_pk_array[2].values = g_xcck_m.xcck001
   LET g_pk_array[2].column = 'xcck001'
   LET g_pk_array[3].values = g_xcck_m.xcck003
   LET g_pk_array[3].column = 'xcck003'
   LET g_pk_array[4].values = g_xcck_m.xcck004
   LET g_pk_array[4].column = 'xcck004'
   LET g_pk_array[5].values = g_xcck_m.xcck005
   LET g_pk_array[5].column = 'xcck005'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axcq906.other_function" readonly="Y" >}

#查询时预设条件
PRIVATE FUNCTION axcq906_default()
DEFINE  l_glaa001        LIKE glaa_t.glaa001

   #预设当前site的法人，主账套，年度期别，成本计算类型
   CALL s_axc_set_site_default() RETURNING g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
  INITIALIZE g_xcck_m.xcck004 TO NULL#chenhz
  INITIALIZE g_xcck_m.xcck005 TO NULL
  DISPLAY BY NAME g_xcck_m.xcckcomp,g_xcck_m.xcckld,g_xcck_m.xcck004,g_xcck_m.xcck005,g_xcck_m.xcck003
   LET xccksite = g_site  
   DISPLAY  xccksite TO xccksite
   DISPLAY  xcck028 TO xcck028_1
   DISPLAY  xcck021 TO xcck021
   DISPLAY  l_sdate TO l_sdate
   DISPLAY  l_edate TO l_edate 
   
   #fengmy 150114----begin
   #根據參數顯示隱藏成本域 和 料件特性
   IF cl_null(g_xcck_m.xcckcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   ELSE
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
      CALL cl_get_para(g_enterprise,g_xcck_m.xcckcomp,'S-FIN-6013') RETURNING g_para_data1   #采用特性否       
   END IF  
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',TRUE)                    
   ELSE                        
      CALL cl_set_comp_visible('xcck002,xcck002_desc,xcck002_1,xcck002_1_desc',FALSE)                
   END IF   
   IF g_para_data1 = 'Y' THEN
      CALL cl_set_comp_visible('xcck011,xcck011_1',TRUE)                    
   ELSE                       
      CALL cl_set_comp_visible('xcck011,xcck011_1',FALSE)                
   END IF   
   #fengmy 150114----end    
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckcomp_desc 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcckld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcckld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcckld_desc 

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcck_m.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck003_desc
      
   LET g_xcck_m.xcck001 = '1'
   DISPLAY BY NAME g_xcck_m.xcck001
   
   SELECT glaa001 INTO l_glaa001
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_xcck_m.xcckld

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_glaa001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcck_m.xcck001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcck_m.xcck001_desc      
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
PRIVATE FUNCTION axcq906_ins_xckk()
   DEFINE l_sum_xcck201        LIKE xcck_t.xcck201
   DEFINE l_sum_xcck202        LIKE xcck_t.xcck202
   DEFINE i                    LIKE type_t.num5
   
   RETURN   #先不用这个
#   IF g_xcck_d.getLength() = 0 AND g_xcck_d.getLength() = 0 THEN RETURN END IF
##先判断单头条件是否存在与axci601的设置资料里，不存在则退出
##再判断是否已有重复单头资料的xckk/xckl，提示是否删除，若不删除，则退出
#
#  
#   IF NOT s_axcq004_upd_xckk_chk_del('2',                                     #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                     g_enterprise,                            #xckkent      传入企业编号
#                                     g_xcck_m.xcckcomp,                       #xckkcomp     传入法人
#                                     g_xcck_m.xcckld,                         #xckkld       传入账套
#                                     g_xcck_m.xcck004,                        #xckk003      传入年度
#                                     g_xcck_m.xcck005,                        #xckk004      传入期别
#                                     g_prog,                                  #xckk005      传入程序代号
#                                     g_xcck_m.xcck003,                        #xckk006      传入成本计算类型
#                                     g_xcck_m.xcck001)                                      #xckk007      传入本位币顺序
#   THEN
#      RETURN
#   END IF
#   
#   LET l_sum_xcck201 = 0
#   LET l_sum_xcck202 = 0
#   FOR i = 1 TO g_xcck_d.getLength()
#       IF g_xcck_d[i].xcck201 IS NULL THEN
#          LET g_xcck_d[i].xcck201 = 0
#       END IF
#       IF g_xcck_d[i].xcck202 IS NULL THEN
#          LET g_xcck_d[i].xcck202 = 0
#       END IF
#       LET l_sum_xcck201 = l_sum_xcck201 + g_xcck_d[i].xcck009*g_xcck_d[i].xcck201
#       LET l_sum_xcck202 = l_sum_xcck202 + g_xcck_d[i].xcck009*g_xcck_d[i].xcck202
#   END FOR
#   
##一般采购
#   FOR i = 1 TO g_xcck_d.getLength()
#      IF NOT s_axcq004_upd_xckk('2',                                          #type         传入更新类型 1：axcq004更新总报表 2：子查询作业更新分项报表
#                                g_enterprise,                                 #xckkent      传入企业编号
#                                g_xcck_m.xcckcomp,                            #xckkcomp     传入法人
#                                g_xcck_m.xcckld,                              #xckkld       传入账套
#                                '104',                                        #xckk001      传入类型代码
#                                g_xcck_m.xcck004,                             #xckk003      传入年度
#                                g_xcck_m.xcck005,                             #xckk004      传入期别
#                                g_prog,                                       #xckk005      传入程序代号
#                                g_xcck_m.xcck003,                             #xckk006      传入成本计算类型
#                                g_xcck_m.xcck001,                             #xckk007      传入本位币顺序
#                                l_sum_xcck201,                                #xckk103      传入总表/分项报表数量
#                                l_sum_xcck202,                                                #xckk104h     传入总表/分项报表金额-制费五
#                                g_xcck_d[1].xcck006,                          #xckl007      传入成本勾稽明细表-单据编号
#                                g_xcck_d[1].xcck007,                          #xckl008      传入成本勾稽明细表-项次
#                                g_xcck_d[1].xcck008,                          #xckl009      传入成本勾稽明细表-序号
#                                g_xcck_d[1].xcck010,                          #xckl010      传入成本勾稽明细表-料件
#                                g_xcck_d[1].xcck011,                          #xckl011      传入成本勾稽明细表-特性
#                                g_xcck_d[1].xcck017,                          #xckl012      传入成本勾稽明细表-批号
#                                g_xcck_d[i].xcck009*g_xcck_d[1].xcck201,      #xckl014      传入成本勾稽明细表-数量
#                                g_xcck_d[i].xcck009*g_xcck_d[10].xcck202)     #xckl015      传入成本勾稽明细表-金额
#        THEN
#         RETURN
#      END IF
#   END FOR
END FUNCTION

################################################################################
# Descriptions...: 建臨時表
# Memo...........:
# Usage..........: 
# Date & Author..: 150402 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq906_create_temp_table()
DROP TABLE axcq906_tmp;
   CREATE TEMP TABLE axcq906_tmp(
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck021_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   inba008 LIKE type_t.chr500, 
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
   xcck202 LIKE xcck_t.xcck202, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr500, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr500, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr500, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr500, 
   xcckent LIKE xcck_t.xcckent, 
   mainkey LIKE type_t.chr500
);
END FUNCTION

################################################################################
# Descriptions...: 數據傳入臨時表
# Memo...........:
# Usage..........: 
# Date & Author..: 150402 By fengmy
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq906_ins_temp()
DEFINE sr                RECORD
   xccksite LIKE xcck_t.xccksite,
   ooefl003 LIKE ooefl_t.ooefl003,
   imag011 LIKE type_t.chr10, 
   imag011_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   xcck002_desc LIKE type_t.chr500, 
   xcck025 LIKE xcck_t.xcck025, 
   xcck025_desc LIKE type_t.chr500, 
   xcck021 LIKE xcck_t.xcck021, 
   xcck021_desc LIKE type_t.chr500, 
   xcck006 LIKE xcck_t.xcck006, 
   inba008 LIKE type_t.chr500, 
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
   xcck202 LIKE xcck_t.xcck202, 
   xcckcomp LIKE xcck_t.xcckcomp, 
   xcckcomp_desc LIKE type_t.chr500, 
   xcck004 LIKE xcck_t.xcck004, 
   xcck005 LIKE xcck_t.xcck005, 
   xcck003 LIKE xcck_t.xcck003, 
   xcck003_desc LIKE type_t.chr500, 
   xcckld LIKE xcck_t.xcckld, 
   xcckld_desc LIKE type_t.chr500, 
   xcck001 LIKE xcck_t.xcck001, 
   xcck001_desc LIKE type_t.chr500, 
   xcckent LIKE xcck_t.xcckent, 
   mainkey LIKE type_t.chr500
                        END RECORD
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_success         LIKE type_t.num5                        
DEFINE l_i               LIKE type_t.num5
DEFINE l_glaa001         LIKE glaa_t.glaa001
DEFINE l_glaa016         LIKE glaa_t.glaa016
DEFINE l_glaa020         LIKE glaa_t.glaa020
DEFINE l_xcck004         LIKE type_t.chr30
DEFINE l_xcck005         LIKE type_t.chr30
DEFINE l_xcck012         LIKE xcck_t.xcck012

    #刪除臨時表中資料
    DELETE FROM axcq906_tmp
    
    LET l_success = TRUE

    FOR l_i = 1 TO g_browser.getLength()
  
#      LET sr.xcckcomp = g_browser[l_i].xcckcomp
      LET sr.xcck004  = g_browser[l_i].b_xcck004
      LET sr.xcck001  = g_browser[l_i].b_xcck001
      LET sr.xcckld   = g_browser[l_i].b_xcckld
      LET sr.xcck005  = g_browser[l_i].b_xcck005
      LET sr.xcck003  = g_browser[l_i].b_xcck003
      
      
      EXECUTE axcq906_master_referesh USING sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004, 
       sr.xcck005 INTO sr.xcckcomp,sr.xcck004,sr.xcck005,sr.xcck003,sr.xcckld, 
       sr.xcck001,sr.xcckcomp_desc,sr.xcck003_desc,sr.xcckld_desc,sr.xcck001_desc 
      
      LET l_xcck004=sr.xcck004
      LET l_xcck005=sr.xcck005
      LET sr.mainkey = sr.xcckcomp,"-",sr.xcckld,"-",l_xcck004 CLIPPED,"-",l_xcck005 CLIPPED,"-",sr.xcck001 CLIPPED,"-",sr.xcck003
  
      SELECT xcckcomp INTO sr.xcckcomp FROM xcck_t
      WHERE xcckent = g_enterprise AND xcckld = sr.xcckld   AND xcck001 = sr.xcck001
        AND xcck003 = sr.xcck003   AND xcck004 = sr.xcck004 AND xcck005 = sr.xcck005 
         
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
        
       PREPARE axcq906_ins_tmp_pre FROM g_sql_tmp
       DECLARE axcq906_ins_tmp_cs CURSOR FOR axcq906_ins_tmp_pre
      
      OPEN axcq906_ins_tmp_cs USING g_enterprise,sr.xcckld,sr.xcck001,sr.xcck003,sr.xcck004,sr.xcck005
                                               
      FOREACH axcq906_ins_tmp_cs INTO sr.xccksite,sr.ooefl003,sr.xcck002,sr.xcck025,sr.xcck021,sr.xcck006, 
          sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013, 
          sr.xcck010,sr.xcck011,sr.xcck015,sr.xcck017, 
          sr.xcck044,sr.xcck201,sr.xcck040,sr.xcck042, 
          sr.xcck282,sr.xcck202,sr.xcck002_desc,sr.xcck025_desc, 
          sr.xcck010_desc,sr.xcck044_desc,sr.xcck040_desc
          
         #成本分群
         SELECT imag011 INTO sr.imag011 FROM imag_t 
          WHERE imagent = g_enterprise AND imagsite = sr.xcckcomp
            AND imag001 = sr.xcck010
         
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
         LET g_ref_fields[1] = sr.imag011                                                                                                                        
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET sr.imag011_desc = '', g_rtn_fields[1] , ''  
         DISPLAY BY NAME sr.imag011_desc 

         IF cl_null(sr.xcck025) THEN
            LET l_xcck012 = ' ' 
            SELECT xcck012 INTO l_xcck012 FROM xcck_t
             WHERE xcckent = g_enterprise AND xcckld = sr.xcckld
               AND xcck001 = sr.xcck001 AND xcck002 = sr.xcck002
               AND xcck003 = sr.xcck003 AND xcck004 = sr.xcck004
               AND xcck005 = sr.xcck005 AND xcck006 = sr.xcck006
               AND xcck007 = sr.xcck007 AND xcck008 = sr.xcck008
               AND xcck009 = sr.xcck009
            IF l_xcck012 = 'aint170' THEN   
               SELECT inbf002 INTO sr.xcck025
                 FROM inbf_t
                WHERE inbfent = g_enterprise
                  AND inbfdocno = sr.xcck006
            ELSE
               SELECT inba004 INTO sr.xcck025
                 FROM inba_t
                WHERE inbaent = g_enterprise
                  AND inbadocno = sr.xcck006
            END IF
         END IF

         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = sr.xcck025
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET sr.xcck025_desc = '', g_rtn_fields[1] , ''
      
         LET sr.xcck201 = sr.xcck201 * sr.xcck009
         LET sr.xcck202 = sr.xcck202 * sr.xcck009
         
         CALL s_desc_get_stock_desc(g_site,sr.xcck015) RETURNING sr.xcck015_desc
   
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = sr.xcck010
         CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET sr.xcck010_desc = '', g_rtn_fields[1] , ''
         LET sr.xcck010_desc_1 = '', g_rtn_fields[2] , ''
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = sr.xcck021
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET sr.xcck021_desc = '', g_rtn_fields[1] , ''
          
         CALL s_desc_get_unit_desc(sr.xcck044) RETURNING sr.xcck044_desc
         

         SELECT inba008 INTO sr.inba008 FROM inba_t 
          WHERE inbaent = g_enterprise
            AND inbadocno = sr.xcck006
         IF cl_null(sr.inba008) THEN LET sr.inba008 = ' ' END IF
      
        INSERT INTO axcq906_tmp (xccksite,ooefl003,imag011,imag011_desc,xcck002,xcck002_desc,xcck025,
                       xcck025_desc,xcck021,xcck021_desc,xcck006,inba008,
                       xcck007,xcck008,xcck009,xcck013,xcck010,
                       xcck010_desc,xcck010_desc_1,xcck011,xcck015,xcck015_desc,
                       xcck017,xcck044,xcck044_desc,xcck201,xcck040,
                       xcck040_desc,xcck042,xcck282,xcck202,xcckcomp,
                       xcckcomp_desc,xcck004,xcck005,xcck003,xcck003_desc,
                       xcckld,xcckld_desc,xcck001,xcck001_desc,xcckent,
                       mainkey)
                       VALUES( sr.xccksite,sr.ooefl003,sr.imag011,sr.imag011_desc,sr.xcck002,sr.xcck002_desc,sr.xcck025,
                               sr.xcck025_desc,sr.xcck021,sr.xcck021_desc,sr.xcck006,sr.inba008,
                               sr.xcck007,sr.xcck008,sr.xcck009,sr.xcck013,sr.xcck010,
                               sr.xcck010_desc,sr.xcck010_desc_1,sr.xcck011,sr.xcck015,sr.xcck015_desc,
                               sr.xcck017,sr.xcck044,sr.xcck044_desc,sr.xcck201,sr.xcck040,
                               sr.xcck040_desc,sr.xcck042,sr.xcck282,sr.xcck202,sr.xcckcomp,
                               sr.xcckcomp_desc,sr.xcck004,sr.xcck005,sr.xcck003,sr.xcck003_desc,
                               sr.xcckld,sr.xcckld_desc,sr.xcck001,sr.xcck001_desc,sr.xcckent,
                               sr.mainkey )
        
       IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'insert axcq_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET l_success = FALSE
        END IF
      END FOREACH
      
      CALL cl_err_collect_show()
      IF l_success = FALSE THEN
        DELETE FROM axcq906_tmp
      END IF
      
      FREE axcq906_ins_tmp_pre
      
 END FOR
END FUNCTION

################################################################################
# Descriptions...: 品类汇总
# Memo...........:
# Usage..........: CALL axcq506_b3_fill()
#                  RETURNING 回传参数
# Date & Author..: 20150806 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq906_b3_fill()

  DEFINE g_wc2_table1  STRING 
  
  
  CALL g_xcck3_d.clear()
  LET g_wc2_table1 = g_wc, " AND ", g_wc2
  
   LET g_sql = "SELECT xccksite,ooefl003,xcck028,rtaxl003,SUM(xcck202)",
               "  FROM xcck_t ",
               "  LEFT JOIN ooefl_t ON ooefl001 = xccksite AND ooeflent = xcckent AND ooefl002 = '",g_dlang,"'",  #chenhz
               "  LEFT JOIN rtaxl_t ON rtaxl001 = xcck028 AND rtaxlent = xcckent AND rtaxl002 = '",g_dlang,"'",
               "  LEFT JOIN inba_t ON inbadocno = xcck006 AND inbaent = xcckent ",       #add by zhanghr          
               "  WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? ",
               "    AND xcck013 between to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  "  #chenhz                             
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql = g_sql," AND xcck055 = '211'"
   
   LET g_sql = g_sql," GROUP BY xccksite,ooefl003,xcck028,rtaxl003 ",
                     " ORDER BY xccksite,xcck028 "	
   PREPARE axcq906_xcck_sum_prep FROM g_sql
   DECLARE axcq906_xcck_sum_cs CURSOR FOR axcq906_xcck_sum_prep
  
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN axcq906_xcck_sum_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
                                      
   FOREACH axcq906_xcck_sum_cs INTO g_xcck3_d[l_ac].xccksite,g_xcck3_d[l_ac].ooefl003,g_xcck3_d[l_ac].xcck028,g_xcck3_d[l_ac].xcck028_desc,g_xcck3_d[l_ac].xcck202
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH xcck:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         EXIT FOREACH
      END IF
  
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck3_d[l_ac].xcck028
#      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck3_d[l_ac].xcck028_desc = '', g_rtn_fields[1] , ''
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         EXIT FOREACH
      END IF         
   END FOREACH

   CALL g_xcck3_d.deleteElement(g_xcck3_d.getLength())
   FREE axcq906_xcck_sum_prep
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
# Date & Author..: 15/09/23 By chenhz
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq906_b4_fill()
 
  DEFINE g_wc2_table1  STRING 

  CALL g_xcck4_d.clear()
  LET g_wc2_table1 = g_wc, " AND ", g_wc2
  LET g_sql4 = "SELECT DISTINCT xcck006,xcck013,gzcbl004,SUM(xcck202)",
               "  FROM xcck_t ",
               "  LEFT JOIN inba_t ON inbadocno = xcck006 AND inbaent = xcckent ",
               "  LEFT JOIN gzcbl_t ON gzcbl001 = '6834' AND gzcbl002 = inba012 AND gzcbl003 = '",g_dlang,"'",
               "  WHERE xcckent= ? AND xcckld=? AND xcck001=? AND xcck003=? ",
               "    AND xcck013 between to_date('",l_sdate,"','yy/mm/dd') AND to_date('",l_edate,"','yy/mm/dd')  "  #chenhz                             
   
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql4 = g_sql4 CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcck_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql4 = g_sql4," AND xcck055 = '211'"
   
   LET g_sql4 = g_sql4," GROUP BY xcck006,xcck013,gzcbl004 ",
                       " ORDER BY xcck013 "	
   PREPARE axcq906_xcck_sum2_prep FROM g_sql4
   DECLARE axcq906_xcck_sum2_cs CURSOR FOR axcq906_xcck_sum2_prep
  
   LET g_cnt = l_ac
   LET l_ac = 1
   
   OPEN axcq906_xcck_sum2_cs USING g_enterprise,g_xcck_m.xcckld,g_xcck_m.xcck001,g_xcck_m.xcck003
                                      
   FOREACH axcq906_xcck_sum2_cs INTO g_xcck4_d[l_ac].xcck006,g_xcck4_d[l_ac].xcck013,g_xcck4_d[l_ac].l_inba012_4,g_xcck4_d[l_ac].xcck202
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH xcck:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         EXIT FOREACH
      END IF
  
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_xcck3_d[l_ac].xcck028
#      CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#      LET g_xcck3_d[l_ac].xcck028_desc = '', g_rtn_fields[1] , ''
         
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         EXIT FOREACH
      END IF         
   END FOREACH

   CALL g_xcck4_d.deleteElement(g_xcck4_d.getLength())
   FREE axcq906_xcck_sum2_prep
END FUNCTION

 
{</section>}
 
