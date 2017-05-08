#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt030.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-10-29 17:38:41), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000070
#+ Filename...: afmt030
#+ Description: 融資資料維護
#+ Creator....: 05426(2014-08-11 09:18:56)
#+ Modifier...: 05426 -SD/PR- 00000
 
{</section>}
 
{<section id="afmt030.global" >}
#應用 t01 樣板自動產生(Version:74) 
#add-point:填寫註解說明 name="global.memo"
#Modify.........: No.151125-00001#2 15/11/27 By catmoon 作廢前詢問「是否執行作廢？」
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
PRIVATE type type_g_fmaj_m        RECORD
       fmaj001 LIKE fmaj_t.fmaj001, 
   fmaj003 LIKE fmaj_t.fmaj003, 
   fmaj003_desc LIKE type_t.chr80, 
   fmaj005 LIKE fmaj_t.fmaj005, 
   fmaj008 LIKE fmaj_t.fmaj008, 
   fmaj011 LIKE fmaj_t.fmaj011, 
   fmaj002 LIKE fmaj_t.fmaj002, 
   fmaj002_desc LIKE type_t.chr80, 
   fmaj004 LIKE fmaj_t.fmaj004, 
   fmaj006 LIKE fmaj_t.fmaj006, 
   fmaj009 LIKE fmaj_t.fmaj009, 
   fmaj012 LIKE fmaj_t.fmaj012, 
   lbl_gsfr LIKE type_t.chr500, 
   lbl_gsfr_desc LIKE type_t.chr80, 
   fmaj020 LIKE fmaj_t.fmaj020, 
   fmaj007 LIKE fmaj_t.fmaj007, 
   fmaj010 LIKE fmaj_t.fmaj010, 
   fmajstus LIKE fmaj_t.fmajstus, 
   fmajownid LIKE fmaj_t.fmajownid, 
   fmajownid_desc LIKE type_t.chr80, 
   fmajowndp LIKE fmaj_t.fmajowndp, 
   fmajowndp_desc LIKE type_t.chr80, 
   fmajcrtid LIKE fmaj_t.fmajcrtid, 
   fmajcrtid_desc LIKE type_t.chr80, 
   fmajcrtdp LIKE fmaj_t.fmajcrtdp, 
   fmajcrtdp_desc LIKE type_t.chr80, 
   fmajcrtdt LIKE fmaj_t.fmajcrtdt, 
   fmajmodid LIKE fmaj_t.fmajmodid, 
   fmajmodid_desc LIKE type_t.chr80, 
   fmajmoddt LIKE fmaj_t.fmajmoddt, 
   fmajcnfid LIKE fmaj_t.fmajcnfid, 
   fmajcnfid_desc LIKE type_t.chr80, 
   fmajcnfdt LIKE fmaj_t.fmajcnfdt, 
   fmaj013 LIKE fmaj_t.fmaj013, 
   fmaj014 LIKE fmaj_t.fmaj014, 
   fmaj015 LIKE fmaj_t.fmaj015, 
   fmaj016 LIKE fmaj_t.fmaj016, 
   fmaj017 LIKE fmaj_t.fmaj017, 
   fmaj018 LIKE fmaj_t.fmaj018, 
   fmaj019 LIKE fmaj_t.fmaj019
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_fmak_d        RECORD
       fmak011 LIKE fmak_t.fmak011, 
   fmak002 LIKE fmak_t.fmak002, 
   lbl_fmak002_desc LIKE type_t.chr500, 
   fmak003 LIKE fmak_t.fmak003, 
   fmak004 LIKE fmak_t.fmak004, 
   fmak005 LIKE fmak_t.fmak005, 
   fmak006 LIKE fmak_t.fmak006, 
   fmak007 LIKE fmak_t.fmak007, 
   fmak008 LIKE fmak_t.fmak008, 
   fmak009 LIKE fmak_t.fmak009, 
   fmak010 LIKE fmak_t.fmak010
       END RECORD
PRIVATE TYPE type_g_fmak2_d RECORD
       fmal008 LIKE fmal_t.fmal008, 
   fmal002 LIKE fmal_t.fmal002, 
   fmal003 LIKE fmal_t.fmal003, 
   fmal004 LIKE fmal_t.fmal004, 
   fmal005 LIKE fmal_t.fmal005, 
   fmal006 LIKE fmal_t.fmal006, 
   fmal007 LIKE fmal_t.fmal007
       END RECORD
PRIVATE TYPE type_g_fmak3_d RECORD
       fmam006 LIKE fmam_t.fmam006, 
   fmam002 LIKE fmam_t.fmam002, 
   lbl_fmam002_desc LIKE type_t.chr500, 
   fmam003 LIKE fmam_t.fmam003, 
   fmam004 LIKE fmam_t.fmam004, 
   fmam005 LIKE fmam_t.fmam005
       END RECORD
PRIVATE TYPE type_g_fmak4_d RECORD
       fman010 LIKE type_t.num10, 
   fman002 LIKE fman_t.fman002, 
   lbl_fman002_desc LIKE type_t.chr500, 
   fman003 LIKE fman_t.fman003, 
   fman004 LIKE fman_t.fman004, 
   fman005 LIKE fman_t.fman005, 
   fman006 LIKE fman_t.fman006, 
   fman007 LIKE fman_t.fman007, 
   fman008 LIKE fman_t.fman008, 
   fman009 LIKE fman_t.fman009
       END RECORD
PRIVATE TYPE type_g_fmak5_d RECORD
       lbl_fmaw002 LIKE type_t.chr500, 
   lbl_fmaw007 LIKE type_t.chr500, 
   lbl_fmaw008 LIKE type_t.chr500, 
   lbl_fmaw006 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_fmak6_d RECORD
       lbl_fmao002 LIKE type_t.chr500, 
   lbl_fmao003 LIKE type_t.chr500, 
   lbl_fmao004 LIKE type_t.chr500, 
   lbl_fmao005 LIKE type_t.chr500, 
   lbl_fmao006 LIKE type_t.chr500, 
   lbl_fmao007 LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_fmaj001 LIKE fmaj_t.fmaj001
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_fmaj_m          type_g_fmaj_m
DEFINE g_fmaj_m_t        type_g_fmaj_m
DEFINE g_fmaj_m_o        type_g_fmaj_m
DEFINE g_fmaj_m_mask_o   type_g_fmaj_m #轉換遮罩前資料
DEFINE g_fmaj_m_mask_n   type_g_fmaj_m #轉換遮罩後資料
 
   DEFINE g_fmaj001_t LIKE fmaj_t.fmaj001
 
 
DEFINE g_fmak_d          DYNAMIC ARRAY OF type_g_fmak_d
DEFINE g_fmak_d_t        type_g_fmak_d
DEFINE g_fmak_d_o        type_g_fmak_d
DEFINE g_fmak_d_mask_o   DYNAMIC ARRAY OF type_g_fmak_d #轉換遮罩前資料
DEFINE g_fmak_d_mask_n   DYNAMIC ARRAY OF type_g_fmak_d #轉換遮罩後資料
DEFINE g_fmak2_d          DYNAMIC ARRAY OF type_g_fmak2_d
DEFINE g_fmak2_d_t        type_g_fmak2_d
DEFINE g_fmak2_d_o        type_g_fmak2_d
DEFINE g_fmak2_d_mask_o   DYNAMIC ARRAY OF type_g_fmak2_d #轉換遮罩前資料
DEFINE g_fmak2_d_mask_n   DYNAMIC ARRAY OF type_g_fmak2_d #轉換遮罩後資料
DEFINE g_fmak3_d          DYNAMIC ARRAY OF type_g_fmak3_d
DEFINE g_fmak3_d_t        type_g_fmak3_d
DEFINE g_fmak3_d_o        type_g_fmak3_d
DEFINE g_fmak3_d_mask_o   DYNAMIC ARRAY OF type_g_fmak3_d #轉換遮罩前資料
DEFINE g_fmak3_d_mask_n   DYNAMIC ARRAY OF type_g_fmak3_d #轉換遮罩後資料
DEFINE g_fmak4_d          DYNAMIC ARRAY OF type_g_fmak4_d
DEFINE g_fmak4_d_t        type_g_fmak4_d
DEFINE g_fmak4_d_o        type_g_fmak4_d
DEFINE g_fmak4_d_mask_o   DYNAMIC ARRAY OF type_g_fmak4_d #轉換遮罩前資料
DEFINE g_fmak4_d_mask_n   DYNAMIC ARRAY OF type_g_fmak4_d #轉換遮罩後資料
DEFINE g_fmak5_d          DYNAMIC ARRAY OF type_g_fmak5_d
DEFINE g_fmak5_d_t        type_g_fmak5_d
DEFINE g_fmak5_d_o        type_g_fmak5_d
DEFINE g_fmak5_d_mask_o   DYNAMIC ARRAY OF type_g_fmak5_d #轉換遮罩前資料
DEFINE g_fmak5_d_mask_n   DYNAMIC ARRAY OF type_g_fmak5_d #轉換遮罩後資料
DEFINE g_fmak6_d          DYNAMIC ARRAY OF type_g_fmak6_d
DEFINE g_fmak6_d_t        type_g_fmak6_d
DEFINE g_fmak6_d_o        type_g_fmak6_d
DEFINE g_fmak6_d_mask_o   DYNAMIC ARRAY OF type_g_fmak6_d #轉換遮罩前資料
DEFINE g_fmak6_d_mask_n   DYNAMIC ARRAY OF type_g_fmak6_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
 
 
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
 
{<section id="afmt030.main" >}
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
   CALL cl_ap_init("afm","")
 
   #add-point:作業初始化 name="main.init"
   INITIALIZE g_errparam TO NULL
   LET g_errparam.extend = ""
   LET g_errparam.code   = "afm-00195"
   LET g_errparam.popup  = TRUE
   CALL cl_err()
   #離開作業
   CALL cl_ap_exitprogram("0")
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT fmaj001,fmaj003,'',fmaj005,fmaj008,fmaj011,fmaj002,'',fmaj004,fmaj006, 
       fmaj009,fmaj012,'','',fmaj020,fmaj007,fmaj010,fmajstus,fmajownid,'',fmajowndp,'',fmajcrtid,'', 
       fmajcrtdp,'',fmajcrtdt,fmajmodid,'',fmajmoddt,fmajcnfid,'',fmajcnfdt,fmaj013,fmaj014,fmaj015, 
       fmaj016,fmaj017,fmaj018,fmaj019", 
                      " FROM fmaj_t",
                      " WHERE fmajent= ? AND fmaj001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt030_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.fmaj001,t0.fmaj003,t0.fmaj005,t0.fmaj008,t0.fmaj011,t0.fmaj002,t0.fmaj004, 
       t0.fmaj006,t0.fmaj009,t0.fmaj012,t0.fmaj020,t0.fmaj007,t0.fmaj010,t0.fmajstus,t0.fmajownid,t0.fmajowndp, 
       t0.fmajcrtid,t0.fmajcrtdp,t0.fmajcrtdt,t0.fmajmodid,t0.fmajmoddt,t0.fmajcnfid,t0.fmajcnfdt,t0.fmaj013, 
       t0.fmaj014,t0.fmaj015,t0.fmaj016,t0.fmaj017,t0.fmaj018,t0.fmaj019,t1.fmaal003 ,t2.ooefl003 ,t3.oofa011 , 
       t4.ooefl003 ,t5.oofa011 ,t6.ooefl003 ,t7.oofa011 ,t8.oofa011",
               " FROM fmaj_t t0",
                              " LEFT JOIN fmaal_t t1 ON t1.fmaalent="||g_enterprise||" AND t1.fmaal001=t0.fmaj003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.fmaj002  ",
               " LEFT JOIN oofa_t t3 ON t3.oofaent="||g_enterprise||" AND t3.oofa002='2' AND t3.oofa003=t0.fmajownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.fmajowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent="||g_enterprise||" AND t5.oofa002='2' AND t5.oofa003=t0.fmajcrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.fmajcrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t7 ON t7.oofaent="||g_enterprise||" AND t7.oofa002='2' AND t7.oofa003=t0.fmajmodid  ",
               " LEFT JOIN oofa_t t8 ON t8.oofaent="||g_enterprise||" AND t8.oofa002='2' AND t8.oofa003=t0.fmajcnfid  ",
 
               " WHERE t0.fmajent = " ||g_enterprise|| " AND t0.fmaj001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmt030_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmt030 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmt030_init()   
 
      #進入選單 Menu (="N")
      CALL afmt030_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmt030
      
   END IF 
   
   CLOSE afmt030_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmt030.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afmt030_init()
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
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('fmajstus','13','A,D,N,R,W,Y,X')
 
      CALL cl_set_combo_scc('fmaj013','8856') 
   CALL cl_set_combo_scc('fmak005','8854') 
   CALL cl_set_combo_scc('fmak006','8855') 
   CALL cl_set_combo_scc('fmal002','8859') 
   CALL cl_set_combo_scc('fmal003','8860') 
   CALL cl_set_combo_scc('fmal004','8861') 
   CALL cl_set_combo_scc('fman004','8854') 
   CALL cl_set_combo_scc('fman006','8855') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','5','6',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('fmajstus','13','N,X,Y')
   CALL cl_set_combo_scc('fmal002','8859')   #还款性质
   CALL cl_set_combo_scc('fmal003','8860')   #付息周期
   #CALL cl_set_combo_scc('fmal004','8861')   #起始付息周期
   CALL cl_set_combo_scc_part('fmal004','8861','1,2,3,4,5,6,7,8,9,10,11,12')
   CALL cl_set_combo_scc('fman004','8854')   #利率方式
   CALL cl_set_combo_scc('fman006','8855')   #浮动方式
   #end add-point
   
   #初始化搜尋條件
   CALL afmt030_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="afmt030.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION afmt030_ui_dialog()
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
   DEFINE l_fmaa003 LIKE fmaa_t.fmaa003
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
            CALL afmt030_insert()
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
         INITIALIZE g_fmaj_m.* TO NULL
         CALL g_fmak_d.clear()
         CALL g_fmak2_d.clear()
         CALL g_fmak3_d.clear()
         CALL g_fmak4_d.clear()
         CALL g_fmak5_d.clear()
         CALL g_fmak6_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL afmt030_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_fmak_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','5','6',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','5','6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_fmak2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
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
               CALL afmt030_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmak3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmak4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page4, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmak5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_fmak6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL afmt030_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body6.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL afmt030_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body6.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
         
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL afmt030_browser_fill("")
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
               CALL afmt030_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL afmt030_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL afmt030_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL afmt030_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL afmt030_set_act_visible()   
            CALL afmt030_set_act_no_visible()
            IF NOT (g_fmaj_m.fmaj001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " fmajent = " ||g_enterprise|| " AND",
                                  " fmaj001 = '", g_fmaj_m.fmaj001, "' "
 
               #填到對應位置
               CALL afmt030_browser_fill("")
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
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmaj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmak_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmal_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmam_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fman_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL afmt030_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
               INITIALIZE g_wc2_table3 TO NULL
 
               INITIALIZE g_wc2_table4 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "fmaj_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmak_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "fmal_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fmam_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "fman_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
                  IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
                  END IF
 
                  IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL afmt030_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL afmt030_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL afmt030_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt030_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL afmt030_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt030_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL afmt030_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt030_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL afmt030_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt030_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL afmt030_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL afmt030_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_fmak_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_fmak2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_fmak3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_fmak4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_fmak5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_fmak6_d)
                  LET g_export_id[6]   = "s_detail6"
 
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
               CALL afmt030_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL afmt030_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt030_1
            LET g_action_choice="open_afmt030_1"
            IF cl_auth_chk_act("open_afmt030_1") THEN
               
               #add-point:ON ACTION open_afmt030_1 name="menu.open_afmt030_1"
               IF cl_null(g_fmaj_m.fmaj017) OR cl_null(g_fmaj_m.fmaj001) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "afm-00026" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               ELSE          
                  CALL afmt030_01(g_fmaj_m.fmaj001,g_fmaj_m.fmaj017)
               END IF
               LET g_action_choice=""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION verify
            LET g_action_choice="verify"
            IF cl_auth_chk_act("verify") THEN
               
               #add-point:ON ACTION verify name="menu.verify"
               CALL afmt030_verify()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL afmt030_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmt030_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt030_3
            LET g_action_choice="open_afmt030_3"
            IF cl_auth_chk_act("open_afmt030_3") THEN
               
               #add-point:ON ACTION open_afmt030_3 name="menu.open_afmt030_3"
               IF cl_null(g_fmaj_m.fmaj017) OR cl_null(g_fmaj_m.fmaj001) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "afm-00026" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               ELSE          
                  CALL afmt030_03(g_fmaj_m.fmaj001,g_fmaj_m.fmaj017)
               END IF
               LET g_action_choice=""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt030_5
            LET g_action_choice="open_afmt030_5"
            IF cl_auth_chk_act("open_afmt030_5") THEN
               
               #add-point:ON ACTION open_afmt030_5 name="menu.open_afmt030_5"
               SELECT DISTINCT fmaa003 INTO l_fmaa003 FROM fmaa_t WHERE fmaa001=g_fmaj_m.fmaj003
               IF l_fmaa003='5' THEN 
                  CALL afmt030_05(g_fmaj_m.fmaj001)
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "afm-00030" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
               LET g_action_choice=""
            
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt030_2
            LET g_action_choice="open_afmt030_2"
            IF cl_auth_chk_act("open_afmt030_2") THEN
               
               #add-point:ON ACTION open_afmt030_2 name="menu.open_afmt030_2"
               IF cl_null(g_fmaj_m.fmaj019) OR cl_null(g_fmaj_m.fmaj001) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "afm-00027" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
               ELSE          
                  CALL afmt030_02(g_fmaj_m.fmaj001,g_fmaj_m.fmaj019,g_fmaj_m.fmaj002)
                  
               END IF
               LET g_action_choice=""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/afm/afmt030_rep.4gl"
               #add-point:ON ACTION output.after
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL afmt030_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_afmt030_4
            LET g_action_choice="open_afmt030_4"
            IF cl_auth_chk_act("open_afmt030_4") THEN
               
               #add-point:ON ACTION open_afmt030_4 name="menu.open_afmt030_4"
               IF cl_null(g_fmaj_m.fmaj019) OR cl_null(g_fmaj_m.fmaj001) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "afm-00027" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
               ELSE          
                  CALL afmt030_04(g_fmaj_m.fmaj001,g_fmaj_m.fmaj019)
                  
               END IF
               LET g_action_choice=""
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL afmt030_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL afmt030_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL afmt030_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL afmt030_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
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
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="afmt030.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION afmt030_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
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
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT fmaj001 ",
                      " FROM fmaj_t ",
                      " ",
                      " LEFT JOIN fmak_t ON fmakent = fmajent AND fmaj001 = fmak001 ", "  ",
                      #add-point:browser_fill段sql(fmak_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN fmal_t ON fmalent = fmajent AND fmaj001 = fmal001", "  ",
                      #add-point:browser_fill段sql(fmal_t1) name="browser_fill.cnt.join.fmal_t1"
                      
                      #end add-point
 
                      " LEFT JOIN fmam_t ON fmament = fmajent AND fmaj001 = fmam001", "  ",
                      #add-point:browser_fill段sql(fmam_t1) name="browser_fill.cnt.join.fmam_t1"
                      
                      #end add-point
 
                      " LEFT JOIN fman_t ON fmanent = fmajent AND fmaj001 = fman001", "  ",
                      #add-point:browser_fill段sql(fman_t1) name="browser_fill.cnt.join.fman_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE fmajent = " ||g_enterprise|| " AND fmakent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("fmaj_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT fmaj001 ",
                      " FROM fmaj_t ", 
                      "  ",
                      "  ",
                      " WHERE fmajent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("fmaj_t")
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
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
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
      INITIALIZE g_fmaj_m.* TO NULL
      CALL g_fmak_d.clear()        
      CALL g_fmak2_d.clear() 
      CALL g_fmak3_d.clear() 
      CALL g_fmak4_d.clear() 
      CALL g_fmak5_d.clear() 
      CALL g_fmak6_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.fmaj001 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmajstus,t0.fmaj001 ",
                  " FROM fmaj_t t0",
                  "  ",
                  "  LEFT JOIN fmak_t ON fmakent = fmajent AND fmaj001 = fmak001 ", "  ", 
                  #add-point:browser_fill段sql(fmak_t1) name="browser_fill.join.fmak_t1"
                  
                  #end add-point
                  "  LEFT JOIN fmal_t ON fmalent = fmajent AND fmaj001 = fmal001", "  ", 
                  #add-point:browser_fill段sql(fmal_t1) name="browser_fill.join.fmal_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN fmam_t ON fmament = fmajent AND fmaj001 = fmam001", "  ", 
                  #add-point:browser_fill段sql(fmam_t1) name="browser_fill.join.fmam_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN fman_t ON fmanent = fmajent AND fmaj001 = fman001", "  ", 
                  #add-point:browser_fill段sql(fman_t1) name="browser_fill.join.fman_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.fmajent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("fmaj_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.fmajstus,t0.fmaj001 ",
                  " FROM fmaj_t t0",
                  "  ",
                  
                  " WHERE t0.fmajent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("fmaj_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY fmaj001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"fmaj_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_fmaj001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_fmaj001) THEN
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
 
{<section id="afmt030.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION afmt030_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_fmaj_m.fmaj001 = g_browser[g_current_idx].b_fmaj001   
 
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
   CALL afmt030_fmaj_t_mask()
   CALL afmt030_show()
      
END FUNCTION
 
{</section>}
 
{<section id="afmt030.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION afmt030_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION afmt030_ui_browser_refresh()
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
      IF g_browser[l_i].b_fmaj001 = g_fmaj_m.fmaj001 
 
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
 
{<section id="afmt030.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmt030_construct()
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
   
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_fmaj_m.* TO NULL
   CALL g_fmak_d.clear()        
   CALL g_fmak2_d.clear() 
   CALL g_fmak3_d.clear() 
   CALL g_fmak4_d.clear() 
   CALL g_fmak5_d.clear() 
   CALL g_fmak6_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON fmaj001,fmaj003,fmaj005,fmaj008,fmaj011,fmaj002,fmaj004,fmaj006,fmaj009, 
          fmaj012,lbl_gsfr,lbl_gsfr_desc,fmaj020,fmaj007,fmaj010,fmajstus,fmajownid,fmajowndp,fmajcrtid, 
          fmajcrtdp,fmajcrtdt,fmajmodid,fmajmoddt,fmajcnfid,fmajcnfdt,fmaj013,fmaj014,fmaj015,fmaj016, 
          fmaj017,fmaj018,fmaj019
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<fmajcrtdt>>----
         AFTER FIELD fmajcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<fmajmoddt>>----
         AFTER FIELD fmajmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmajcnfdt>>----
         AFTER FIELD fmajcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<fmajpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj001
            #add-point:BEFORE FIELD fmaj001 name="construct.b.fmaj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj001
            
            #add-point:AFTER FIELD fmaj001 name="construct.a.fmaj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj001
            #add-point:ON ACTION controlp INFIELD fmaj001 name="construct.c.fmaj001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj003
            #add-point:ON ACTION controlp INFIELD fmaj003 name="construct.c.fmaj003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj003  #顯示到畫面上
            NEXT FIELD fmaj003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj003
            #add-point:BEFORE FIELD fmaj003 name="construct.b.fmaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj003
            
            #add-point:AFTER FIELD fmaj003 name="construct.a.fmaj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj005
            #add-point:ON ACTION controlp INFIELD fmaj005 name="construct.c.fmaj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaj005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj005  #顯示到畫面上
            NEXT FIELD fmaj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj005
            #add-point:BEFORE FIELD fmaj005 name="construct.b.fmaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj005
            
            #add-point:AFTER FIELD fmaj005 name="construct.a.fmaj005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj008
            #add-point:BEFORE FIELD fmaj008 name="construct.b.fmaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj008
            
            #add-point:AFTER FIELD fmaj008 name="construct.a.fmaj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj008
            #add-point:ON ACTION controlp INFIELD fmaj008 name="construct.c.fmaj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj011
            #add-point:BEFORE FIELD fmaj011 name="construct.b.fmaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj011
            
            #add-point:AFTER FIELD fmaj011 name="construct.a.fmaj011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj011
            #add-point:ON ACTION controlp INFIELD fmaj011 name="construct.c.fmaj011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj002
            #add-point:ON ACTION controlp INFIELD fmaj002 name="construct.c.fmaj002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_33()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj002  #顯示到畫面上
            NEXT FIELD fmaj002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj002
            #add-point:BEFORE FIELD fmaj002 name="construct.b.fmaj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj002
            
            #add-point:AFTER FIELD fmaj002 name="construct.a.fmaj002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj004
            #add-point:BEFORE FIELD fmaj004 name="construct.b.fmaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj004
            
            #add-point:AFTER FIELD fmaj004 name="construct.a.fmaj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj004
            #add-point:ON ACTION controlp INFIELD fmaj004 name="construct.c.fmaj004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj006
            #add-point:ON ACTION controlp INFIELD fmaj006 name="construct.c.fmaj006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj006  #顯示到畫面上
            NEXT FIELD fmaj006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj006
            #add-point:BEFORE FIELD fmaj006 name="construct.b.fmaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj006
            
            #add-point:AFTER FIELD fmaj006 name="construct.a.fmaj006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj009
            #add-point:BEFORE FIELD fmaj009 name="construct.b.fmaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj009
            
            #add-point:AFTER FIELD fmaj009 name="construct.a.fmaj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj009
            #add-point:ON ACTION controlp INFIELD fmaj009 name="construct.c.fmaj009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj012
            #add-point:BEFORE FIELD fmaj012 name="construct.b.fmaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj012
            
            #add-point:AFTER FIELD fmaj012 name="construct.a.fmaj012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj012
            #add-point:ON ACTION controlp INFIELD fmaj012 name="construct.c.fmaj012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_gsfr
            #add-point:BEFORE FIELD lbl_gsfr name="construct.b.lbl_gsfr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_gsfr
            
            #add-point:AFTER FIELD lbl_gsfr name="construct.a.lbl_gsfr"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.lbl_gsfr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_gsfr
            #add-point:ON ACTION controlp INFIELD lbl_gsfr name="construct.c.lbl_gsfr"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_gsfr_desc
            #add-point:BEFORE FIELD lbl_gsfr_desc name="construct.b.lbl_gsfr_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_gsfr_desc
            
            #add-point:AFTER FIELD lbl_gsfr_desc name="construct.a.lbl_gsfr_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.lbl_gsfr_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_gsfr_desc
            #add-point:ON ACTION controlp INFIELD lbl_gsfr_desc name="construct.c.lbl_gsfr_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj020
            #add-point:BEFORE FIELD fmaj020 name="construct.b.fmaj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj020
            
            #add-point:AFTER FIELD fmaj020 name="construct.a.fmaj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj020
            #add-point:ON ACTION controlp INFIELD fmaj020 name="construct.c.fmaj020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmaj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj007
            #add-point:ON ACTION controlp INFIELD fmaj007 name="construct.c.fmaj007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj007  #顯示到畫面上
            NEXT FIELD fmaj007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj007
            #add-point:BEFORE FIELD fmaj007 name="construct.b.fmaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj007
            
            #add-point:AFTER FIELD fmaj007 name="construct.a.fmaj007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj010
            #add-point:BEFORE FIELD fmaj010 name="construct.b.fmaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj010
            
            #add-point:AFTER FIELD fmaj010 name="construct.a.fmaj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj010
            #add-point:ON ACTION controlp INFIELD fmaj010 name="construct.c.fmaj010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajstus
            #add-point:BEFORE FIELD fmajstus name="construct.b.fmajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajstus
            
            #add-point:AFTER FIELD fmajstus name="construct.a.fmajstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajstus
            #add-point:ON ACTION controlp INFIELD fmajstus name="construct.c.fmajstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmajownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajownid
            #add-point:ON ACTION controlp INFIELD fmajownid name="construct.c.fmajownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajownid  #顯示到畫面上
            NEXT FIELD fmajownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajownid
            #add-point:BEFORE FIELD fmajownid name="construct.b.fmajownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajownid
            
            #add-point:AFTER FIELD fmajownid name="construct.a.fmajownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmajowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajowndp
            #add-point:ON ACTION controlp INFIELD fmajowndp name="construct.c.fmajowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajowndp  #顯示到畫面上
            NEXT FIELD fmajowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajowndp
            #add-point:BEFORE FIELD fmajowndp name="construct.b.fmajowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajowndp
            
            #add-point:AFTER FIELD fmajowndp name="construct.a.fmajowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmajcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajcrtid
            #add-point:ON ACTION controlp INFIELD fmajcrtid name="construct.c.fmajcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajcrtid  #顯示到畫面上
            NEXT FIELD fmajcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajcrtid
            #add-point:BEFORE FIELD fmajcrtid name="construct.b.fmajcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajcrtid
            
            #add-point:AFTER FIELD fmajcrtid name="construct.a.fmajcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmajcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajcrtdp
            #add-point:ON ACTION controlp INFIELD fmajcrtdp name="construct.c.fmajcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajcrtdp  #顯示到畫面上
            NEXT FIELD fmajcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajcrtdp
            #add-point:BEFORE FIELD fmajcrtdp name="construct.b.fmajcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajcrtdp
            
            #add-point:AFTER FIELD fmajcrtdp name="construct.a.fmajcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajcrtdt
            #add-point:BEFORE FIELD fmajcrtdt name="construct.b.fmajcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmajmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajmodid
            #add-point:ON ACTION controlp INFIELD fmajmodid name="construct.c.fmajmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajmodid  #顯示到畫面上
            NEXT FIELD fmajmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajmodid
            #add-point:BEFORE FIELD fmajmodid name="construct.b.fmajmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajmodid
            
            #add-point:AFTER FIELD fmajmodid name="construct.a.fmajmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajmoddt
            #add-point:BEFORE FIELD fmajmoddt name="construct.b.fmajmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmajcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajcnfid
            #add-point:ON ACTION controlp INFIELD fmajcnfid name="construct.c.fmajcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmajcnfid  #顯示到畫面上
            NEXT FIELD fmajcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajcnfid
            #add-point:BEFORE FIELD fmajcnfid name="construct.b.fmajcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajcnfid
            
            #add-point:AFTER FIELD fmajcnfid name="construct.a.fmajcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajcnfdt
            #add-point:BEFORE FIELD fmajcnfdt name="construct.b.fmajcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj013
            #add-point:BEFORE FIELD fmaj013 name="construct.b.fmaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj013
            
            #add-point:AFTER FIELD fmaj013 name="construct.a.fmaj013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj013
            #add-point:ON ACTION controlp INFIELD fmaj013 name="construct.c.fmaj013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.fmaj014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj014
            #add-point:ON ACTION controlp INFIELD fmaj014 name="construct.c.fmaj014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaj014()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj014  #顯示到畫面上
            NEXT FIELD fmaj014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj014
            #add-point:BEFORE FIELD fmaj014 name="construct.b.fmaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj014
            
            #add-point:AFTER FIELD fmaj014 name="construct.a.fmaj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj015
            #add-point:ON ACTION controlp INFIELD fmaj015 name="construct.c.fmaj015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaj015()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj015  #顯示到畫面上
            NEXT FIELD fmaj015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj015
            #add-point:BEFORE FIELD fmaj015 name="construct.b.fmaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj015
            
            #add-point:AFTER FIELD fmaj015 name="construct.a.fmaj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj016
            #add-point:ON ACTION controlp INFIELD fmaj016 name="construct.c.fmaj016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj016  #顯示到畫面上
            NEXT FIELD fmaj016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj016
            #add-point:BEFORE FIELD fmaj016 name="construct.b.fmaj016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj016
            
            #add-point:AFTER FIELD fmaj016 name="construct.a.fmaj016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj017
            #add-point:ON ACTION controlp INFIELD fmaj017 name="construct.c.fmaj017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaj017()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj017  #顯示到畫面上
            NEXT FIELD fmaj017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj017
            #add-point:BEFORE FIELD fmaj017 name="construct.b.fmaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj017
            
            #add-point:AFTER FIELD fmaj017 name="construct.a.fmaj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj018
            #add-point:ON ACTION controlp INFIELD fmaj018 name="construct.c.fmaj018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj018  #顯示到畫面上
            NEXT FIELD fmaj018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj018
            #add-point:BEFORE FIELD fmaj018 name="construct.b.fmaj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj018
            
            #add-point:AFTER FIELD fmaj018 name="construct.a.fmaj018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.fmaj019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj019
            #add-point:ON ACTION controlp INFIELD fmaj019 name="construct.c.fmaj019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmaj019()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmaj019  #顯示到畫面上
            NEXT FIELD fmaj019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj019
            #add-point:BEFORE FIELD fmaj019 name="construct.b.fmaj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj019
            
            #add-point:AFTER FIELD fmaj019 name="construct.a.fmaj019"
            
            #END add-point
            
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON fmak011,fmak002,lbl_fmak002_desc,fmak003,fmak004,fmak005,fmak006,fmak007, 
          fmak008,fmak009,fmak010
           FROM s_detail1[1].fmak011,s_detail1[1].fmak002,s_detail1[1].lbl_fmak002_desc,s_detail1[1].fmak003, 
               s_detail1[1].fmak004,s_detail1[1].fmak005,s_detail1[1].fmak006,s_detail1[1].fmak007,s_detail1[1].fmak008, 
               s_detail1[1].fmak009,s_detail1[1].fmak010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak011
            #add-point:BEFORE FIELD fmak011 name="construct.b.page1.fmak011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak011
            
            #add-point:AFTER FIELD fmak011 name="construct.a.page1.fmak011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak011
            #add-point:ON ACTION controlp INFIELD fmak011 name="construct.c.page1.fmak011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmak002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak002
            #add-point:ON ACTION controlp INFIELD fmak002 name="construct.c.page1.fmak002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmak002  #顯示到畫面上
            NEXT FIELD fmak002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak002
            #add-point:BEFORE FIELD fmak002 name="construct.b.page1.fmak002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak002
            
            #add-point:AFTER FIELD fmak002 name="construct.a.page1.fmak002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fmak002_desc
            #add-point:BEFORE FIELD lbl_fmak002_desc name="construct.b.page1.lbl_fmak002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fmak002_desc
            
            #add-point:AFTER FIELD lbl_fmak002_desc name="construct.a.page1.lbl_fmak002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.lbl_fmak002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fmak002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fmak002_desc name="construct.c.page1.lbl_fmak002_desc"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.fmak003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak003
            #add-point:ON ACTION controlp INFIELD fmak003 name="construct.c.page1.fmak003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmak003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmak003  #顯示到畫面上
            NEXT FIELD fmak003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak003
            #add-point:BEFORE FIELD fmak003 name="construct.b.page1.fmak003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak003
            
            #add-point:AFTER FIELD fmak003 name="construct.a.page1.fmak003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak004
            #add-point:BEFORE FIELD fmak004 name="construct.b.page1.fmak004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak004
            
            #add-point:AFTER FIELD fmak004 name="construct.a.page1.fmak004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak004
            #add-point:ON ACTION controlp INFIELD fmak004 name="construct.c.page1.fmak004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak005
            #add-point:BEFORE FIELD fmak005 name="construct.b.page1.fmak005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak005
            
            #add-point:AFTER FIELD fmak005 name="construct.a.page1.fmak005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak005
            #add-point:ON ACTION controlp INFIELD fmak005 name="construct.c.page1.fmak005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak006
            #add-point:BEFORE FIELD fmak006 name="construct.b.page1.fmak006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak006
            
            #add-point:AFTER FIELD fmak006 name="construct.a.page1.fmak006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak006
            #add-point:ON ACTION controlp INFIELD fmak006 name="construct.c.page1.fmak006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak007
            #add-point:BEFORE FIELD fmak007 name="construct.b.page1.fmak007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak007
            
            #add-point:AFTER FIELD fmak007 name="construct.a.page1.fmak007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak007
            #add-point:ON ACTION controlp INFIELD fmak007 name="construct.c.page1.fmak007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak008
            #add-point:BEFORE FIELD fmak008 name="construct.b.page1.fmak008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak008
            
            #add-point:AFTER FIELD fmak008 name="construct.a.page1.fmak008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak008
            #add-point:ON ACTION controlp INFIELD fmak008 name="construct.c.page1.fmak008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak009
            #add-point:BEFORE FIELD fmak009 name="construct.b.page1.fmak009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak009
            
            #add-point:AFTER FIELD fmak009 name="construct.a.page1.fmak009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak009
            #add-point:ON ACTION controlp INFIELD fmak009 name="construct.c.page1.fmak009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak010
            #add-point:BEFORE FIELD fmak010 name="construct.b.page1.fmak010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak010
            
            #add-point:AFTER FIELD fmak010 name="construct.a.page1.fmak010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fmak010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak010
            #add-point:ON ACTION controlp INFIELD fmak010 name="construct.c.page1.fmak010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON fmal008,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007
           FROM s_detail2[1].fmal008,s_detail2[1].fmal002,s_detail2[1].fmal003,s_detail2[1].fmal004, 
               s_detail2[1].fmal005,s_detail2[1].fmal006,s_detail2[1].fmal007
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal008
            #add-point:BEFORE FIELD fmal008 name="construct.b.page2.fmal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal008
            
            #add-point:AFTER FIELD fmal008 name="construct.a.page2.fmal008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal008
            #add-point:ON ACTION controlp INFIELD fmal008 name="construct.c.page2.fmal008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal002
            #add-point:BEFORE FIELD fmal002 name="construct.b.page2.fmal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal002
            
            #add-point:AFTER FIELD fmal002 name="construct.a.page2.fmal002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal002
            #add-point:ON ACTION controlp INFIELD fmal002 name="construct.c.page2.fmal002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal003
            #add-point:BEFORE FIELD fmal003 name="construct.b.page2.fmal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal003
            
            #add-point:AFTER FIELD fmal003 name="construct.a.page2.fmal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal003
            #add-point:ON ACTION controlp INFIELD fmal003 name="construct.c.page2.fmal003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal004
            #add-point:BEFORE FIELD fmal004 name="construct.b.page2.fmal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal004
            
            #add-point:AFTER FIELD fmal004 name="construct.a.page2.fmal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal004
            #add-point:ON ACTION controlp INFIELD fmal004 name="construct.c.page2.fmal004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal005
            #add-point:BEFORE FIELD fmal005 name="construct.b.page2.fmal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal005
            
            #add-point:AFTER FIELD fmal005 name="construct.a.page2.fmal005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal005
            #add-point:ON ACTION controlp INFIELD fmal005 name="construct.c.page2.fmal005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal006
            #add-point:BEFORE FIELD fmal006 name="construct.b.page2.fmal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal006
            
            #add-point:AFTER FIELD fmal006 name="construct.a.page2.fmal006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal006
            #add-point:ON ACTION controlp INFIELD fmal006 name="construct.c.page2.fmal006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal007
            #add-point:BEFORE FIELD fmal007 name="construct.b.page2.fmal007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal007
            
            #add-point:AFTER FIELD fmal007 name="construct.a.page2.fmal007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.fmal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal007
            #add-point:ON ACTION controlp INFIELD fmal007 name="construct.c.page2.fmal007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON fmam006,fmam002,lbl_fmam002_desc,fmam003,fmam004,fmam005
           FROM s_detail3[1].fmam006,s_detail3[1].fmam002,s_detail3[1].lbl_fmam002_desc,s_detail3[1].fmam003, 
               s_detail3[1].fmam004,s_detail3[1].fmam005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam006
            #add-point:BEFORE FIELD fmam006 name="construct.b.page3.fmam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam006
            
            #add-point:AFTER FIELD fmam006 name="construct.a.page3.fmam006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam006
            #add-point:ON ACTION controlp INFIELD fmam006 name="construct.c.page3.fmam006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam002
            #add-point:ON ACTION controlp INFIELD fmam002 name="construct.c.page3.fmam002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmam002  #顯示到畫面上
            NEXT FIELD fmam002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam002
            #add-point:BEFORE FIELD fmam002 name="construct.b.page3.fmam002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam002
            
            #add-point:AFTER FIELD fmam002 name="construct.a.page3.fmam002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fmam002_desc
            #add-point:BEFORE FIELD lbl_fmam002_desc name="construct.b.page3.lbl_fmam002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fmam002_desc
            
            #add-point:AFTER FIELD lbl_fmam002_desc name="construct.a.page3.lbl_fmam002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.lbl_fmam002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fmam002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fmam002_desc name="construct.c.page3.lbl_fmam002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam003
            #add-point:BEFORE FIELD fmam003 name="construct.b.page3.fmam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam003
            
            #add-point:AFTER FIELD fmam003 name="construct.a.page3.fmam003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam003
            #add-point:ON ACTION controlp INFIELD fmam003 name="construct.c.page3.fmam003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.fmam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam004
            #add-point:ON ACTION controlp INFIELD fmam004 name="construct.c.page3.fmam004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_fmak003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fmam004  #顯示到畫面上
            NEXT FIELD fmam004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam004
            #add-point:BEFORE FIELD fmam004 name="construct.b.page3.fmam004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam004
            
            #add-point:AFTER FIELD fmam004 name="construct.a.page3.fmam004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam005
            #add-point:BEFORE FIELD fmam005 name="construct.b.page3.fmam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam005
            
            #add-point:AFTER FIELD fmam005 name="construct.a.page3.fmam005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.fmam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam005
            #add-point:ON ACTION controlp INFIELD fmam005 name="construct.c.page3.fmam005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON fman010,fman002,lbl_fman002_desc,fman003,fman004,fman005,fman006,fman007, 
          fman008,fman009
           FROM s_detail4[1].fman010,s_detail4[1].fman002,s_detail4[1].lbl_fman002_desc,s_detail4[1].fman003, 
               s_detail4[1].fman004,s_detail4[1].fman005,s_detail4[1].fman006,s_detail4[1].fman007,s_detail4[1].fman008, 
               s_detail4[1].fman009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman010
            #add-point:BEFORE FIELD fman010 name="construct.b.page4.fman010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman010
            
            #add-point:AFTER FIELD fman010 name="construct.a.page4.fman010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman010
            #add-point:ON ACTION controlp INFIELD fman010 name="construct.c.page4.fman010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.fman002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman002
            #add-point:ON ACTION controlp INFIELD fman002 name="construct.c.page4.fman002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO fman002  #顯示到畫面上
            NEXT FIELD fman002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman002
            #add-point:BEFORE FIELD fman002 name="construct.b.page4.fman002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman002
            
            #add-point:AFTER FIELD fman002 name="construct.a.page4.fman002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fman002_desc
            #add-point:BEFORE FIELD lbl_fman002_desc name="construct.b.page4.lbl_fman002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fman002_desc
            
            #add-point:AFTER FIELD lbl_fman002_desc name="construct.a.page4.lbl_fman002_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.lbl_fman002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fman002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fman002_desc name="construct.c.page4.lbl_fman002_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman003
            #add-point:BEFORE FIELD fman003 name="construct.b.page4.fman003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman003
            
            #add-point:AFTER FIELD fman003 name="construct.a.page4.fman003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman003
            #add-point:ON ACTION controlp INFIELD fman003 name="construct.c.page4.fman003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman004
            #add-point:BEFORE FIELD fman004 name="construct.b.page4.fman004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman004
            
            #add-point:AFTER FIELD fman004 name="construct.a.page4.fman004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman004
            #add-point:ON ACTION controlp INFIELD fman004 name="construct.c.page4.fman004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman005
            #add-point:BEFORE FIELD fman005 name="construct.b.page4.fman005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman005
            
            #add-point:AFTER FIELD fman005 name="construct.a.page4.fman005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman005
            #add-point:ON ACTION controlp INFIELD fman005 name="construct.c.page4.fman005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman006
            #add-point:BEFORE FIELD fman006 name="construct.b.page4.fman006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman006
            
            #add-point:AFTER FIELD fman006 name="construct.a.page4.fman006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman006
            #add-point:ON ACTION controlp INFIELD fman006 name="construct.c.page4.fman006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman007
            #add-point:BEFORE FIELD fman007 name="construct.b.page4.fman007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman007
            
            #add-point:AFTER FIELD fman007 name="construct.a.page4.fman007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman007
            #add-point:ON ACTION controlp INFIELD fman007 name="construct.c.page4.fman007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman008
            #add-point:BEFORE FIELD fman008 name="construct.b.page4.fman008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman008
            
            #add-point:AFTER FIELD fman008 name="construct.a.page4.fman008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman008
            #add-point:ON ACTION controlp INFIELD fman008 name="construct.c.page4.fman008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman009
            #add-point:BEFORE FIELD fman009 name="construct.b.page4.fman009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman009
            
            #add-point:AFTER FIELD fman009 name="construct.a.page4.fman009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.fman009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman009
            #add-point:ON ACTION controlp INFIELD fman009 name="construct.c.page4.fman009"
            
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
 
            INITIALIZE g_wc2_table3 TO NULL
 
            INITIALIZE g_wc2_table4 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "fmaj_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmak_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "fmal_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "fmam_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "fman_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION afmt030_query()
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
   CALL g_fmak_d.clear()
   CALL g_fmak2_d.clear()
   CALL g_fmak3_d.clear()
   CALL g_fmak4_d.clear()
   CALL g_fmak5_d.clear()
   CALL g_fmak6_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL afmt030_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL afmt030_browser_fill("")
      CALL afmt030_fetch("")
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
   LET g_detail_idx_list[3] = 1
   LET g_detail_idx_list[4] = 1
   LET g_detail_idx_list[5] = 1
   LET g_detail_idx_list[6] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL afmt030_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL afmt030_fetch("F") 
      #顯示單身筆數
      CALL afmt030_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION afmt030_fetch(p_flag)
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
   
   LET g_fmaj_m.fmaj001 = g_browser[g_current_idx].b_fmaj001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
   #遮罩相關處理
   LET g_fmaj_m_mask_o.* =  g_fmaj_m.*
   CALL afmt030_fmaj_t_mask()
   LET g_fmaj_m_mask_n.* =  g_fmaj_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt030_set_act_visible()   
   CALL afmt030_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmaj_m_t.* = g_fmaj_m.*
   LET g_fmaj_m_o.* = g_fmaj_m.*
   
   LET g_data_owner = g_fmaj_m.fmajownid      
   LET g_data_dept  = g_fmaj_m.fmajowndp
   
   #重新顯示   
   CALL afmt030_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.insert" >}
#+ 資料新增
PRIVATE FUNCTION afmt030_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_fmak_d.clear()   
   CALL g_fmak2_d.clear()  
   CALL g_fmak3_d.clear()  
   CALL g_fmak4_d.clear()  
   CALL g_fmak5_d.clear()  
   CALL g_fmak6_d.clear()  
 
 
   INITIALIZE g_fmaj_m.* LIKE fmaj_t.*             #DEFAULT 設定
   
   LET g_fmaj001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmaj_m.fmajownid = g_user
      LET g_fmaj_m.fmajowndp = g_dept
      LET g_fmaj_m.fmajcrtid = g_user
      LET g_fmaj_m.fmajcrtdp = g_dept 
      LET g_fmaj_m.fmajcrtdt = cl_get_current()
      LET g_fmaj_m.fmajmodid = g_user
      LET g_fmaj_m.fmajmoddt = cl_get_current()
      LET g_fmaj_m.fmajstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_fmaj_m.fmaj011 = "360"
      LET g_fmaj_m.fmaj012 = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_fmaj_m_t.* = g_fmaj_m.*
      LET g_fmaj_m_o.* = g_fmaj_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmaj_m.fmajstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL afmt030_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_fmaj_m.* TO NULL
         INITIALIZE g_fmak_d TO NULL
         INITIALIZE g_fmak2_d TO NULL
         INITIALIZE g_fmak3_d TO NULL
         INITIALIZE g_fmak4_d TO NULL
         INITIALIZE g_fmak5_d TO NULL
         INITIALIZE g_fmak6_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL afmt030_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_fmak_d.clear()
      #CALL g_fmak2_d.clear()
      #CALL g_fmak3_d.clear()
      #CALL g_fmak4_d.clear()
      #CALL g_fmak5_d.clear()
      #CALL g_fmak6_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt030_set_act_visible()   
   CALL afmt030_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmaj001_t = g_fmaj_m.fmaj001
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmajent = " ||g_enterprise|| " AND",
                      " fmaj001 = '", g_fmaj_m.fmaj001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt030_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE afmt030_cl
   
   CALL afmt030_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
   
   #遮罩相關處理
   LET g_fmaj_m_mask_o.* =  g_fmaj_m.*
   CALL afmt030_fmaj_t_mask()
   LET g_fmaj_m_mask_n.* =  g_fmaj_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
       g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr,g_fmaj_m.lbl_gsfr_desc,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010, 
       g_fmaj_m.fmajstus,g_fmaj_m.fmajownid,g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp,g_fmaj_m.fmajowndp_desc, 
       g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajcrtdt, 
       g_fmaj_m.fmajmodid,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfid_desc, 
       g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017, 
       g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_fmaj_m.fmajownid      
   LET g_data_dept  = g_fmaj_m.fmajowndp
   
   #功能已完成,通報訊息中心
   CALL afmt030_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.modify" >}
#+ 資料修改
PRIVATE FUNCTION afmt030_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_fmaj_m_t.* = g_fmaj_m.*
   LET g_fmaj_m_o.* = g_fmaj_m.*
   
   IF g_fmaj_m.fmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_fmaj001_t = g_fmaj_m.fmaj001
 
   CALL s_transaction_begin()
   
   OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt030_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE afmt030_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
   #檢查是否允許此動作
   IF NOT afmt030_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmaj_m_mask_o.* =  g_fmaj_m.*
   CALL afmt030_fmaj_t_mask()
   LET g_fmaj_m_mask_n.* =  g_fmaj_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
   #LET l_wc2_table4 = g_wc2_table4
   #LET l_wc2_table4 = " 1=1"
 
 
 
   
   CALL afmt030_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_fmaj001_t = g_fmaj_m.fmaj001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_fmaj_m.fmajmodid = g_user 
LET g_fmaj_m.fmajmoddt = cl_get_current()
LET g_fmaj_m.fmajmodid_desc = cl_get_username(g_fmaj_m.fmajmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL afmt030_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE fmaj_t SET (fmajmodid,fmajmoddt) = (g_fmaj_m.fmajmodid,g_fmaj_m.fmajmoddt)
          WHERE fmajent = g_enterprise AND fmaj001 = g_fmaj001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_fmaj_m.* = g_fmaj_m_t.*
            CALL afmt030_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_fmaj_m.fmaj001 != g_fmaj_m_t.fmaj001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE fmak_t SET fmak001 = g_fmaj_m.fmaj001
 
          WHERE fmakent = g_enterprise AND fmak001 = g_fmaj_m_t.fmaj001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmak_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE fmal_t
            SET fmal001 = g_fmaj_m.fmaj001
 
          WHERE fmalent = g_enterprise AND
                fmal001 = g_fmaj001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmal_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE fmam_t
            SET fmam001 = g_fmaj_m.fmaj001
 
          WHERE fmament = g_enterprise AND
                fmam001 = g_fmaj001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fmam_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE fman_t
            SET fman001 = g_fmaj_m.fmaj001
 
          WHERE fmanent = g_enterprise AND
                fman001 = g_fmaj001_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "fman_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt030_set_act_visible()   
   CALL afmt030_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " fmajent = " ||g_enterprise|| " AND",
                      " fmaj001 = '", g_fmaj_m.fmaj001, "' "
 
   #填到對應位置
   CALL afmt030_browser_fill("")
 
   CLOSE afmt030_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt030_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="afmt030.input" >}
#+ 資料輸入
PRIVATE FUNCTION afmt030_input(p_cmd)
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
   DEFINE  l_max                 LIKE type_t.num5               #项次
   DEFINE  l_sum                 LIKE type_t.num5           
   DEFINE  l_max4                LIKE type_t.num5  
   DEFINE  l_max2                LIKE type_t.num5  
   DEFINE  l_max3                LIKE type_t.num5  
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_success             LIKE type_t.chr1
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
   DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
       g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr,g_fmaj_m.lbl_gsfr_desc,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010, 
       g_fmaj_m.fmajstus,g_fmaj_m.fmajownid,g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp,g_fmaj_m.fmajowndp_desc, 
       g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajcrtdt, 
       g_fmaj_m.fmajmodid,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfid_desc, 
       g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017, 
       g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT fmak011,fmak002,fmak003,fmak004,fmak005,fmak006,fmak007,fmak008,fmak009, 
       fmak010 FROM fmak_t WHERE fmakent=? AND fmak001=? AND fmak011=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt030_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmal008,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007 FROM fmal_t WHERE  
       fmalent=? AND fmal001=? AND fmal008=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt030_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fmam006,fmam002,fmam003,fmam004,fmam005 FROM fmam_t WHERE fmament=? AND  
       fmam001=? AND fmam002=? AND fmam003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt030_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT fman010,fman002,fman003,fman004,fman005,fman006,fman007,fman008,fman009  
       FROM fman_t WHERE fmanent=? AND fman001=? AND fman002=? AND fman009=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmt030_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL afmt030_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL afmt030_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008,g_fmaj_m.fmaj011, 
       g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009,g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr, 
       g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014, 
       g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="afmt030.input.head" >}
      #單頭段
      INPUT BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008,g_fmaj_m.fmaj011, 
          g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009,g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr, 
          g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014, 
          g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt030_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE afmt030_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL afmt030_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL afmt030_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj001
            #add-point:BEFORE FIELD fmaj001 name="input.b.fmaj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj001
            
            #add-point:AFTER FIELD fmaj001 name="input.a.fmaj001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_fmaj_m.fmaj001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmaj_t WHERE "||"fmajent = '" ||g_enterprise|| "' AND "||"fmaj001 = '"||g_fmaj_m.fmaj001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            IF NOT cl_null(g_fmaj_m.fmaj001) THEN 
               CALL s_aooi200_chk_slip(g_site,l_ooef004,g_fmaj_m.fmaj001,'afmt030') RETURNING l_success
               IF l_success = FALSE THEN 
                  LET g_fmaj_m.fmaj001 = g_fmaj_m_t.fmaj001
                  NEXT FIELD fmaj001
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj001
            #add-point:ON CHANGE fmaj001 name="input.g.fmaj001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj003
            
            #add-point:AFTER FIELD fmaj003 name="input.a.fmaj003"
            IF NOT cl_null(g_fmaj_m.fmaj003) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.default1 = ""
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmaj_m.fmaj003
               IF NOT cl_chk_exist_and_ref_val("v_fmaj003") THEN
                  #檢查失敗時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_fmaj_m.fmaj003
               CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? ","") RETURNING g_rtn_fields
               LET g_fmaj_m.fmaj003_desc = '', g_rtn_fields[1] , ''
               DISPLAY  g_fmaj_m.fmaj003_desc TO fmaj003_desc
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj003
            #add-point:BEFORE FIELD fmaj003 name="input.b.fmaj003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj003
            #add-point:ON CHANGE fmaj003 name="input.g.fmaj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj005
            #add-point:BEFORE FIELD fmaj005 name="input.b.fmaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj005
            
            #add-point:AFTER FIELD fmaj005 name="input.a.fmaj005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj005
            #add-point:ON CHANGE fmaj005 name="input.g.fmaj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj008
            #add-point:BEFORE FIELD fmaj008 name="input.b.fmaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj008
            
            #add-point:AFTER FIELD fmaj008 name="input.a.fmaj008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj008
            #add-point:ON CHANGE fmaj008 name="input.g.fmaj008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj011
            #add-point:BEFORE FIELD fmaj011 name="input.b.fmaj011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj011
            
            #add-point:AFTER FIELD fmaj011 name="input.a.fmaj011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj011
            #add-point:ON CHANGE fmaj011 name="input.g.fmaj011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj002
            
            #add-point:AFTER FIELD fmaj002 name="input.a.fmaj002"
            
            
            IF NOT cl_null(g_fmaj_m.fmaj002) THEN  
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.default1 = "error"
               LET g_chkparam.default2 = "error"
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmaj_m.fmaj002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmac002") THEN
                  #檢查成功時後續處理
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_fmaj_m.fmaj002
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? ","") RETURNING g_rtn_fields
                  LET g_fmaj_m.fmaj002_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_fmaj_m.fmaj002_desc

                  SELECT ooef017 INTO g_fmaj_m.lbl_gsfr FROM ooef_t WHERE ooefent= g_enterprise AND ooef001=g_fmaj_m.fmaj002
                  SELECT ooefl003 INTO g_fmaj_m.lbl_gsfr_desc FROM ooefl_t WHERE ooeflent=g_enterprise AND ooefl001=g_fmaj_m.fmaj002
                  DISPLAY g_fmaj_m.lbl_gsfr TO lbl_gsfr
                  DISPLAY g_fmaj_m.lbl_gsfr_desc TO lbl_gsfr_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj002
            #add-point:BEFORE FIELD fmaj002 name="input.b.fmaj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj002
            #add-point:ON CHANGE fmaj002 name="input.g.fmaj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj004
            #add-point:BEFORE FIELD fmaj004 name="input.b.fmaj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj004
            
            #add-point:AFTER FIELD fmaj004 name="input.a.fmaj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj004
            #add-point:ON CHANGE fmaj004 name="input.g.fmaj004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj006
            
            #add-point:AFTER FIELD fmaj006 name="input.a.fmaj006"
            IF NOT cl_null(g_fmaj_m.fmaj006) THEN 
               INITIALIZE g_chkparam.* TO NULL 
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmaj_m.fmaj006
               IF cl_chk_exist("v_fmac003") THEN
                  CALL cl_ref_val("v_fmac003_1")
                  #LET g_fmaj_m.fmaj006_desc = g_chkparam.return1
                  #DISPLAY g_fmaj_m.fmaj006_desc TO fmaj006_desc        
               ELSE 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT                
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj006
            #add-point:BEFORE FIELD fmaj006 name="input.b.fmaj006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj006
            #add-point:ON CHANGE fmaj006 name="input.g.fmaj006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj009
            #add-point:BEFORE FIELD fmaj009 name="input.b.fmaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj009
            
            #add-point:AFTER FIELD fmaj009 name="input.a.fmaj009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj009
            #add-point:ON CHANGE fmaj009 name="input.g.fmaj009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj012
            #add-point:BEFORE FIELD fmaj012 name="input.b.fmaj012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj012
            
            #add-point:AFTER FIELD fmaj012 name="input.a.fmaj012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj012
            #add-point:ON CHANGE fmaj012 name="input.g.fmaj012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_gsfr
            
            #add-point:AFTER FIELD lbl_gsfr name="input.a.lbl_gsfr"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_gsfr
            #add-point:BEFORE FIELD lbl_gsfr name="input.b.lbl_gsfr"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_gsfr
            #add-point:ON CHANGE lbl_gsfr name="input.g.lbl_gsfr"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj020
            #add-point:BEFORE FIELD fmaj020 name="input.b.fmaj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj020
            
            #add-point:AFTER FIELD fmaj020 name="input.a.fmaj020"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj020
            #add-point:ON CHANGE fmaj020 name="input.g.fmaj020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj007
            
            #add-point:AFTER FIELD fmaj007 name="input.a.fmaj007"
            IF NOT cl_null(g_fmaj_m.fmaj007) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaj_m.fmaj007
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_fmaj007") THEN
                  #檢查成功時後續處理
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj007
            #add-point:BEFORE FIELD fmaj007 name="input.b.fmaj007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj007
            #add-point:ON CHANGE fmaj007 name="input.g.fmaj007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj010
            #add-point:BEFORE FIELD fmaj010 name="input.b.fmaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj010
            
            #add-point:AFTER FIELD fmaj010 name="input.a.fmaj010"
            IF NOT cl_null(g_fmaj_m.fmaj010) THEN 
               IF g_fmaj_m.fmaj010 < g_fmaj_m.fmaj009 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_fmaj_m.fmaj010
                  LET g_errparam.code   = "afm-00039"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj010
            #add-point:ON CHANGE fmaj010 name="input.g.fmaj010"
            IF NOT cl_null(g_fmaj_m.fmaj010) THEN 
               IF g_fmaj_m.fmaj010 < g_fmaj_m.fmaj009 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_fmaj_m.fmaj010
                  LET g_errparam.code   = "afm-00039"
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmajstus
            #add-point:BEFORE FIELD fmajstus name="input.b.fmajstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmajstus
            
            #add-point:AFTER FIELD fmajstus name="input.a.fmajstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmajstus
            #add-point:ON CHANGE fmajstus name="input.g.fmajstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj013
            #add-point:BEFORE FIELD fmaj013 name="input.b.fmaj013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj013
            
            #add-point:AFTER FIELD fmaj013 name="input.a.fmaj013"
            IF NOT cl_null(g_fmaj_m.fmaj013) THEN 
               IF g_fmaj_m.fmaj013='1' THEN 
                  CALL cl_set_comp_entry("fmaj016,fmaj017,fmaj018,fmaj019",FALSE)
                  CALL cl_set_comp_entry("fmaj014,fmaj015",TRUE)
               END IF 
               IF g_fmaj_m.fmaj013='2' THEN 
                  CALL cl_set_comp_entry("fmaj014,fmaj015,fmaj018,fmaj019",FALSE)
                  CALL cl_set_comp_entry("fmaj016,fmaj017",TRUE)
                  LET g_fmaj_m.fmaj016=g_fmaj_m.fmaj002
                  DISPLAY g_fmaj_m.fmaj016 TO fmaj016
               END IF 
               IF g_fmaj_m.fmaj013='3' THEN 
                  CALL cl_set_comp_entry("fmaj014,fmaj015,fmaj016,fmaj017",FALSE)
                  CALL cl_set_comp_entry("fmaj018,fmaj019",TRUE)
                  LET g_fmaj_m.fmaj018=g_fmaj_m.fmaj002
                  DISPLAY g_fmaj_m.fmaj018 TO fmaj018
               END IF 
               IF g_fmaj_m.fmaj013='4' THEN 
                  CALL cl_set_comp_entry("fmaj014,fmaj015,fmaj016,fmaj017,fmaj018,fmaj019",TRUE)
                  LET g_fmaj_m.fmaj016=g_fmaj_m.fmaj002
                  LET g_fmaj_m.fmaj018=g_fmaj_m.fmaj002
                  DISPLAY g_fmaj_m.fmaj018 TO fmaj018
                  DISPLAY g_fmaj_m.fmaj016 TO fmaj016
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj013
            #add-point:ON CHANGE fmaj013 name="input.g.fmaj013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj014
            #add-point:BEFORE FIELD fmaj014 name="input.b.fmaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj014
            
            #add-point:AFTER FIELD fmaj014 name="input.a.fmaj014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj014
            #add-point:ON CHANGE fmaj014 name="input.g.fmaj014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj015
            #add-point:BEFORE FIELD fmaj015 name="input.b.fmaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj015
            
            #add-point:AFTER FIELD fmaj015 name="input.a.fmaj015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj015
            #add-point:ON CHANGE fmaj015 name="input.g.fmaj015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj016
            
            #add-point:AFTER FIELD fmaj016 name="input.a.fmaj016"
            IF NOT cl_null(g_fmaj_m.fmaj016) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmaj_m.fmaj016

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmaj016") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj016
            #add-point:BEFORE FIELD fmaj016 name="input.b.fmaj016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj016
            #add-point:ON CHANGE fmaj016 name="input.g.fmaj016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj017
            #add-point:BEFORE FIELD fmaj017 name="input.b.fmaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj017
            
            #add-point:AFTER FIELD fmaj017 name="input.a.fmaj017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj017
            #add-point:ON CHANGE fmaj017 name="input.g.fmaj017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj018
            
            #add-point:AFTER FIELD fmaj018 name="input.a.fmaj018"
            IF NOT cl_null(g_fmaj_m.fmaj018) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj018
            #add-point:BEFORE FIELD fmaj018 name="input.b.fmaj018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj018
            #add-point:ON CHANGE fmaj018 name="input.g.fmaj018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmaj019
            #add-point:BEFORE FIELD fmaj019 name="input.b.fmaj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmaj019
            
            #add-point:AFTER FIELD fmaj019 name="input.a.fmaj019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmaj019
            #add-point:ON CHANGE fmaj019 name="input.g.fmaj019"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmaj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj001
            #add-point:ON ACTION controlp INFIELD fmaj001 name="input.c.fmaj001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaj_m.fmaj001             #給予default值
            LET l_ooef004 = ''
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            LET g_qryparam.where = " ooba001 = '",l_ooef004,"' AND oobx003 = 'afmt030'"
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooba002()                                #呼叫開窗

            LET g_fmaj_m.fmaj001 = g_qryparam.return1              

            DISPLAY g_fmaj_m.fmaj001 TO fmaj001              #

            NEXT FIELD fmaj001                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.fmaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj003
            #add-point:ON ACTION controlp INFIELD fmaj003 name="input.c.fmaj003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = ""            #給予default值
            LET g_qryparam.where = "1=1" #
            CALL q_fmaa001()                                #呼叫開窗
            LET g_fmaj_m.fmaj003 = g_qryparam.return1              
            DISPLAY g_fmaj_m.fmaj003 TO fmaj003              #
            NEXT FIELD fmaj003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj005
            #add-point:ON ACTION controlp INFIELD fmaj005 name="input.c.fmaj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj008
            #add-point:ON ACTION controlp INFIELD fmaj008 name="input.c.fmaj008"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj011
            #add-point:ON ACTION controlp INFIELD fmaj011 name="input.c.fmaj011"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj002
            #add-point:ON ACTION controlp INFIELD fmaj002 name="input.c.fmaj002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaj_m.fmaj002             #給予default值
            LET g_qryparam.default2 = "" #g_fmaj_m.ooef001 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_33()                                #呼叫開窗

            LET g_fmaj_m.fmaj002 = g_qryparam.return1              
            #LET g_fmaj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmaj_m.fmaj002 TO fmaj002              #
            #DISPLAY g_fmaj_m.ooef001 TO ooef001 #組織編號
            NEXT FIELD fmaj002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj004
            #add-point:ON ACTION controlp INFIELD fmaj004 name="input.c.fmaj004"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj006
            #add-point:ON ACTION controlp INFIELD fmaj006 name="input.c.fmaj006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 =""            #給予default值

            #給予arg
            LET g_qryparam.where = "1=1" #

            
            CALL q_nmab001()                                #呼叫開窗

            LET g_fmaj_m.fmaj006 = g_qryparam.return1              

            DISPLAY g_fmaj_m.fmaj006 TO fmaj006              #

            NEXT FIELD fmaj006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj009
            #add-point:ON ACTION controlp INFIELD fmaj009 name="input.c.fmaj009"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj012
            #add-point:ON ACTION controlp INFIELD fmaj012 name="input.c.fmaj012"
            
            #END add-point
 
 
         #Ctrlp:input.c.lbl_gsfr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_gsfr
            #add-point:ON ACTION controlp INFIELD lbl_gsfr name="input.c.lbl_gsfr"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj020
            #add-point:ON ACTION controlp INFIELD fmaj020 name="input.c.fmaj020"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj007
            #add-point:ON ACTION controlp INFIELD fmaj007 name="input.c.fmaj007"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = ""             #給予default值
            LET g_qryparam.default2 = "" 
            LET g_qryparam.default3 = "" 
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_fmac001()                                #呼叫開窗

            LET g_fmaj_m.fmaj007 = g_qryparam.return1              
            DISPLAY g_fmaj_m.fmaj007 TO fmaj007              #
           

            NEXT FIELD fmaj007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj010
            #add-point:ON ACTION controlp INFIELD fmaj010 name="input.c.fmaj010"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmajstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmajstus
            #add-point:ON ACTION controlp INFIELD fmajstus name="input.c.fmajstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj013
            #add-point:ON ACTION controlp INFIELD fmaj013 name="input.c.fmaj013"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj014
            #add-point:ON ACTION controlp INFIELD fmaj014 name="input.c.fmaj014"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj015
            #add-point:ON ACTION controlp INFIELD fmaj015 name="input.c.fmaj015"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj016
            #add-point:ON ACTION controlp INFIELD fmaj016 name="input.c.fmaj016"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaj_m.fmaj016             #給予default值
            LET g_qryparam.default2 = "" #g_fmaj_m.ooef001 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_fmac002()                                #呼叫開窗

            LET g_fmaj_m.fmaj016 = g_qryparam.return1              
            #LET g_fmaj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmaj_m.fmaj016 TO fmaj016              #
            #DISPLAY g_fmaj_m.ooef001 TO ooef001 #組織編號
            NEXT FIELD fmaj016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj017
            #add-point:ON ACTION controlp INFIELD fmaj017 name="input.c.fmaj017"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmaj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj018
            #add-point:ON ACTION controlp INFIELD fmaj018 name="input.c.fmaj018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmaj_m.fmaj018             #給予default值
            LET g_qryparam.default2 = "" #g_fmaj_m.ooef001 #組織編號
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_fmac002()                                #呼叫開窗

            LET g_fmaj_m.fmaj018 = g_qryparam.return1              
            #LET g_fmaj_m.ooef001 = g_qryparam.return2 
            DISPLAY g_fmaj_m.fmaj018 TO fmaj018              #
            #DISPLAY g_fmaj_m.ooef001 TO ooef001 #組織編號
            NEXT FIELD fmaj018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.fmaj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmaj019
            #add-point:ON ACTION controlp INFIELD fmaj019 name="input.c.fmaj019"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_fmaj_m.fmaj001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_fmaj_m.fmaj001,g_today,g_prog) 
                   RETURNING l_success,g_fmaj_m.fmaj001
               IF l_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_fmaj_m.fmaj001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmaj001
               END IF 
               #end add-point
               
               INSERT INTO fmaj_t (fmajent,fmaj001,fmaj003,fmaj005,fmaj008,fmaj011,fmaj002,fmaj004,fmaj006, 
                   fmaj009,fmaj012,fmaj020,fmaj007,fmaj010,fmajstus,fmajownid,fmajowndp,fmajcrtid,fmajcrtdp, 
                   fmajcrtdt,fmajmodid,fmajmoddt,fmajcnfid,fmajcnfdt,fmaj013,fmaj014,fmaj015,fmaj016, 
                   fmaj017,fmaj018,fmaj019)
               VALUES (g_enterprise,g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
                   g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
                   g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus, 
                   g_fmaj_m.fmajownid,g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt, 
                   g_fmaj_m.fmajmodid,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013, 
                   g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018, 
                   g_fmaj_m.fmaj019) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_fmaj_m:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
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
                  CALL afmt030_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL afmt030_b_fill()
                  CALL afmt030_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL afmt030_fmaj_t_mask_restore('restore_mask_o')
               
               UPDATE fmaj_t SET (fmaj001,fmaj003,fmaj005,fmaj008,fmaj011,fmaj002,fmaj004,fmaj006,fmaj009, 
                   fmaj012,fmaj020,fmaj007,fmaj010,fmajstus,fmajownid,fmajowndp,fmajcrtid,fmajcrtdp, 
                   fmajcrtdt,fmajmodid,fmajmoddt,fmajcnfid,fmajcnfdt,fmaj013,fmaj014,fmaj015,fmaj016, 
                   fmaj017,fmaj018,fmaj019) = (g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
                   g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
                   g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus, 
                   g_fmaj_m.fmajownid,g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt, 
                   g_fmaj_m.fmajmodid,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013, 
                   g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018, 
                   g_fmaj_m.fmaj019)
                WHERE fmajent = g_enterprise AND fmaj001 = g_fmaj001_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fmaj_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL afmt030_fmaj_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_fmaj_m_t)
               LET g_log2 = util.JSON.stringify(g_fmaj_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_fmaj001_t = g_fmaj_m.fmaj001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="afmt030.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_fmak_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmak_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt030_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','5','6',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_fmak_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
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
            OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt030_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE afmt030_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmak_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmak_d[l_ac].fmak011 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_fmak_d_t.* = g_fmak_d[l_ac].*  #BACKUP
               LET g_fmak_d_o.* = g_fmak_d[l_ac].*  #BACKUP
               CALL afmt030_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL afmt030_set_no_entry_b(l_cmd)
               IF NOT afmt030_lock_b("fmak_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt030_bcl INTO g_fmak_d[l_ac].fmak011,g_fmak_d[l_ac].fmak002,g_fmak_d[l_ac].fmak003, 
                      g_fmak_d[l_ac].fmak004,g_fmak_d[l_ac].fmak005,g_fmak_d[l_ac].fmak006,g_fmak_d[l_ac].fmak007, 
                      g_fmak_d[l_ac].fmak008,g_fmak_d[l_ac].fmak009,g_fmak_d[l_ac].fmak010
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_fmak_d_t.fmak011,":",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmak_d_mask_o[l_ac].* =  g_fmak_d[l_ac].*
                  CALL afmt030_fmak_t_mask()
                  LET g_fmak_d_mask_n[l_ac].* =  g_fmak_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt030_show()
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
            INITIALIZE g_fmak_d[l_ac].* TO NULL 
            INITIALIZE g_fmak_d_t.* TO NULL 
            INITIALIZE g_fmak_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_fmak_d[l_ac].fmak010 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_fmak_d_t.* = g_fmak_d[l_ac].*     #新輸入資料
            LET g_fmak_d_o.* = g_fmak_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt030_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt030_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmak_d[li_reproduce_target].* = g_fmak_d[li_reproduce].*
               LET g_fmak5_d[li_reproduce_target].* = g_fmak5_d[li_reproduce].*
               LET g_fmak6_d[li_reproduce_target].* = g_fmak6_d[li_reproduce].*
 
               LET g_fmak_d[li_reproduce_target].fmak011 = NULL
 
            END IF
            
 
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET l_max=0
            SELECT MAX(fmak011) INTO l_max FROM fmak_t WHERE fmak001=g_fmaj_m.fmaj001  AND fmakent = g_enterprise
            IF cl_null(l_max) THEN LET l_max=0 END IF 
            IF l_max=0 THEN
               LET l_max=1
            ELSE 
               LET l_max=l_max+1
            END IF    
            LET g_fmak_d[l_ac].fmak011=l_max  
            DISPLAY g_fmak_d[l_ac].fmak011 TO fmak011
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
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmak_t 
             WHERE fmakent = g_enterprise AND fmak001 = g_fmaj_m.fmaj001
 
               AND fmak011 = g_fmak_d[l_ac].fmak011
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys[2] = g_fmak_d[g_detail_idx].fmak011
               CALL afmt030_insert_b('fmak_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               INITIALIZE g_fmak_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt030_b_fill()
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
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmaj_m.fmaj001
 
               LET gs_keys[gs_keys.getLength()+1] = g_fmak_d_t.fmak011
 
            
               #刪除同層單身
               IF NOT afmt030_delete_b('fmak_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt030_key_delete_b(gs_keys,'fmak_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt030_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_fmak_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmak_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak011
            #add-point:BEFORE FIELD fmak011 name="input.b.page1.fmak011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak011
            
            #add-point:AFTER FIELD fmak011 name="input.a.page1.fmak011"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak_d[g_detail_idx].fmak011 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak_d[g_detail_idx].fmak011 != g_fmak_d_t.fmak011)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmak_t WHERE "||"fmakent = '" ||g_enterprise|| "' AND "||"fmak001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmak011 = '"||g_fmak_d[g_detail_idx].fmak011 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak011
            #add-point:ON CHANGE fmak011 name="input.g.page1.fmak011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak002
            
            #add-point:AFTER FIELD fmak002 name="input.a.page1.fmak002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak_d[g_detail_idx].fmak002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak_d[g_detail_idx].fmak002 != g_fmak_d_t.fmak002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmak_t WHERE "||"fmakent = '" ||g_enterprise|| "' AND "||"fmak001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmak002 = '"||g_fmak_d[g_detail_idx].fmak002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmak_d[l_ac].fmak002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmac006") THEN
                  #檢查成功時後續處理
                  LET g_fmak_d[l_ac].lbl_fmak002_desc = g_chkparam.return1
                  DISPLAY g_fmak_d[l_ac].lbl_fmak002_desc TO  lbl_fmak002_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               SELECT nmaa001 INTO g_fmak_d[l_ac].fmak003 FROM nmaa_t WHERE nmaa002=g_fmaj_m.fmaj002 AND nmaa004=g_fmaj_m.fmaj006
               DISPLAY g_fmak_d[l_ac].fmak003 TO fmak003
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak002
            #add-point:BEFORE FIELD fmak002 name="input.b.page1.fmak002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak002
            #add-point:ON CHANGE fmak002 name="input.g.page1.fmak002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fmak002_desc
            #add-point:BEFORE FIELD lbl_fmak002_desc name="input.b.page1.lbl_fmak002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fmak002_desc
            
            #add-point:AFTER FIELD lbl_fmak002_desc name="input.a.page1.lbl_fmak002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fmak002_desc
            #add-point:ON CHANGE lbl_fmak002_desc name="input.g.page1.lbl_fmak002_desc"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak003
            
            #add-point:AFTER FIELD fmak003 name="input.a.page1.fmak003"
            IF NOT cl_null(g_fmak_d[l_ac].fmak003) THEN 
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmak_d[l_ac].fmak003
               LET g_chkparam.arg2 = g_fmaj_m.fmaj002
               LET g_chkparam.arg3 = g_fmak_d[l_ac].fmak002
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_fmak003") THEN
                  #檢查成功時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak003
            #add-point:BEFORE FIELD fmak003 name="input.b.page1.fmak003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak003
            #add-point:ON CHANGE fmak003 name="input.g.page1.fmak003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak004
            #add-point:BEFORE FIELD fmak004 name="input.b.page1.fmak004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak004
            
            #add-point:AFTER FIELD fmak004 name="input.a.page1.fmak004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak004
            #add-point:ON CHANGE fmak004 name="input.g.page1.fmak004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak005
            #add-point:BEFORE FIELD fmak005 name="input.b.page1.fmak005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak005
            
            #add-point:AFTER FIELD fmak005 name="input.a.page1.fmak005"
            CALL cl_set_comp_entry("fmak006",TRUE)
            IF g_fmak_d[l_ac].fmak005 = '1' THEN
               CALL cl_set_comp_entry("fmak006",FALSE)
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak005
            #add-point:ON CHANGE fmak005 name="input.g.page1.fmak005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak006
            #add-point:BEFORE FIELD fmak006 name="input.b.page1.fmak006"
            CALL cl_set_comp_entry("fmak006",TRUE)
            IF g_fmak_d[l_ac].fmak005 = '1' THEN
               CALL cl_set_comp_entry("fmak006",FALSE)
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak006
            
            #add-point:AFTER FIELD fmak006 name="input.a.page1.fmak006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak006
            #add-point:ON CHANGE fmak006 name="input.g.page1.fmak006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak007
            #add-point:BEFORE FIELD fmak007 name="input.b.page1.fmak007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak007
            
            #add-point:AFTER FIELD fmak007 name="input.a.page1.fmak007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak007
            #add-point:ON CHANGE fmak007 name="input.g.page1.fmak007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak008
            #add-point:BEFORE FIELD fmak008 name="input.b.page1.fmak008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak008
            
            #add-point:AFTER FIELD fmak008 name="input.a.page1.fmak008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak008
            #add-point:ON CHANGE fmak008 name="input.g.page1.fmak008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak009
            #add-point:BEFORE FIELD fmak009 name="input.b.page1.fmak009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak009
            
            #add-point:AFTER FIELD fmak009 name="input.a.page1.fmak009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak009
            #add-point:ON CHANGE fmak009 name="input.g.page1.fmak009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmak010
            #add-point:BEFORE FIELD fmak010 name="input.b.page1.fmak010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmak010
            
            #add-point:AFTER FIELD fmak010 name="input.a.page1.fmak010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmak010
            #add-point:ON CHANGE fmak010 name="input.g.page1.fmak010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.fmak011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak011
            #add-point:ON ACTION controlp INFIELD fmak011 name="input.c.page1.fmak011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak002
            #add-point:ON ACTION controlp INFIELD fmak002 name="input.c.page1.fmak002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmak_d[l_ac].fmak002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmak_d[l_ac].fmak002 = g_qryparam.return1              

            DISPLAY g_fmak_d[l_ac].fmak002 TO fmak002              #

            NEXT FIELD fmak002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.lbl_fmak002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fmak002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fmak002_desc name="input.c.page1.lbl_fmak002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak003
            #add-point:ON ACTION controlp INFIELD fmak003 name="input.c.page1.fmak003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmak_d[l_ac].fmak003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_fmak003()                                #呼叫開窗

            LET g_fmak_d[l_ac].fmak003 = g_qryparam.return1              

            DISPLAY g_fmak_d[l_ac].fmak003 TO fmak003              #

            NEXT FIELD fmak003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak004
            #add-point:ON ACTION controlp INFIELD fmak004 name="input.c.page1.fmak004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak005
            #add-point:ON ACTION controlp INFIELD fmak005 name="input.c.page1.fmak005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak006
            #add-point:ON ACTION controlp INFIELD fmak006 name="input.c.page1.fmak006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak007
            #add-point:ON ACTION controlp INFIELD fmak007 name="input.c.page1.fmak007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak008
            #add-point:ON ACTION controlp INFIELD fmak008 name="input.c.page1.fmak008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak009
            #add-point:ON ACTION controlp INFIELD fmak009 name="input.c.page1.fmak009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fmak010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmak010
            #add-point:ON ACTION controlp INFIELD fmak010 name="input.c.page1.fmak010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmak_d[l_ac].* = g_fmak_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_fmak_d[l_ac].fmak011 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmak_d[l_ac].* = g_fmak_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL afmt030_fmak_t_mask_restore('restore_mask_o')
      
               UPDATE fmak_t SET (fmak001,fmak011,fmak002,fmak003,fmak004,fmak005,fmak006,fmak007,fmak008, 
                   fmak009,fmak010) = (g_fmaj_m.fmaj001,g_fmak_d[l_ac].fmak011,g_fmak_d[l_ac].fmak002, 
                   g_fmak_d[l_ac].fmak003,g_fmak_d[l_ac].fmak004,g_fmak_d[l_ac].fmak005,g_fmak_d[l_ac].fmak006, 
                   g_fmak_d[l_ac].fmak007,g_fmak_d[l_ac].fmak008,g_fmak_d[l_ac].fmak009,g_fmak_d[l_ac].fmak010) 
 
                WHERE fmakent = g_enterprise AND fmak001 = g_fmaj_m.fmaj001 
 
                  AND fmak011 = g_fmak_d_t.fmak011 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmak_d[l_ac].* = g_fmak_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmak_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_fmak_d[l_ac].* = g_fmak_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys_bak[1] = g_fmaj001_t
               LET gs_keys[2] = g_fmak_d[g_detail_idx].fmak011
               LET gs_keys_bak[2] = g_fmak_d_t.fmak011
               CALL afmt030_update_b('fmak_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL afmt030_fmak_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_fmak_d[g_detail_idx].fmak011 = g_fmak_d_t.fmak011 
 
                  ) THEN
                  LET gs_keys[01] = g_fmaj_m.fmaj001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak_d_t.fmak011
 
                  CALL afmt030_key_update_b(gs_keys,'fmak_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak_d_t)
               LET g_log2 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL afmt030_unlock_b("fmak_t","'1'")
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
               LET g_fmak_d[li_reproduce_target].* = g_fmak_d[li_reproduce].*
               LET g_fmak5_d[li_reproduce_target].* = g_fmak5_d[li_reproduce].*
               LET g_fmak6_d[li_reproduce_target].* = g_fmak6_d[li_reproduce].*
 
               LET g_fmak_d[li_reproduce_target].fmak011 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmak_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmak_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_fmak2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            IF g_fmaj_m.fmaj012='Y' THEN 
               RETURN 
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmak2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt030_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmak2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmak2_d[l_ac].* TO NULL 
            INITIALIZE g_fmak2_d_t.* TO NULL 
            INITIALIZE g_fmak2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_fmak2_d_t.* = g_fmak2_d[l_ac].*     #新輸入資料
            LET g_fmak2_d_o.* = g_fmak2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt030_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt030_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmak2_d[li_reproduce_target].* = g_fmak2_d[li_reproduce].*
 
               LET g_fmak2_d[li_reproduce_target].fmal008 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            SELECT MAX(fmal008) INTO l_max2 FROM fmal_t WHERE fmal001=g_fmaj_m.fmaj001  AND fmalent = g_enterprise
            IF cl_null(l_max2) THEN LET l_max2=0 END IF 
            IF l_max2=0 THEN
               LET l_max2=1
            ELSE 
               LET l_max2=l_max2+1
            END IF    
            LET g_fmak2_d[l_ac].fmal008=l_max2  
            DISPLAY g_fmak2_d[l_ac].fmal008 TO fmal008
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
            OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt030_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE afmt030_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmak2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmak2_d[l_ac].fmal008 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmak2_d_t.* = g_fmak2_d[l_ac].*  #BACKUP
               LET g_fmak2_d_o.* = g_fmak2_d[l_ac].*  #BACKUP
               CALL afmt030_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL afmt030_set_no_entry_b(l_cmd)
               IF NOT afmt030_lock_b("fmal_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt030_bcl2 INTO g_fmak2_d[l_ac].fmal008,g_fmak2_d[l_ac].fmal002,g_fmak2_d[l_ac].fmal003, 
                      g_fmak2_d[l_ac].fmal004,g_fmak2_d[l_ac].fmal005,g_fmak2_d[l_ac].fmal006,g_fmak2_d[l_ac].fmal007 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmak2_d_mask_o[l_ac].* =  g_fmak2_d[l_ac].*
                  CALL afmt030_fmal_t_mask()
                  LET g_fmak2_d_mask_n[l_ac].* =  g_fmak2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt030_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            
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
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmaj_m.fmaj001
               LET gs_keys[gs_keys.getLength()+1] = g_fmak2_d_t.fmal008
            
               #刪除同層單身
               IF NOT afmt030_delete_b('fmal_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt030_key_delete_b(gs_keys,'fmal_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt030_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_fmak_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmak2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmal_t 
             WHERE fmalent = g_enterprise AND fmal001 = g_fmaj_m.fmaj001
               AND fmal008 = g_fmak2_d[l_ac].fmal008
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys[2] = g_fmak2_d[g_detail_idx].fmal008
               CALL afmt030_insert_b('fmal_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmak_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt030_b_fill()
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
               LET g_fmak2_d[l_ac].* = g_fmak2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmak2_d[l_ac].* = g_fmak2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL afmt030_fmal_t_mask_restore('restore_mask_o')
                              
               UPDATE fmal_t SET (fmal001,fmal008,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007) = (g_fmaj_m.fmaj001, 
                   g_fmak2_d[l_ac].fmal008,g_fmak2_d[l_ac].fmal002,g_fmak2_d[l_ac].fmal003,g_fmak2_d[l_ac].fmal004, 
                   g_fmak2_d[l_ac].fmal005,g_fmak2_d[l_ac].fmal006,g_fmak2_d[l_ac].fmal007) #自訂欄位頁簽 
 
                WHERE fmalent = g_enterprise AND fmal001 = g_fmaj_m.fmaj001
                  AND fmal008 = g_fmak2_d_t.fmal008 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmak2_d[l_ac].* = g_fmak2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmal_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_fmak2_d[l_ac].* = g_fmak2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys_bak[1] = g_fmaj001_t
               LET gs_keys[2] = g_fmak2_d[g_detail_idx].fmal008
               LET gs_keys_bak[2] = g_fmak2_d_t.fmal008
               CALL afmt030_update_b('fmal_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt030_fmal_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmak2_d[g_detail_idx].fmal008 = g_fmak2_d_t.fmal008 
                  ) THEN
                  LET gs_keys[01] = g_fmaj_m.fmaj001
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak2_d_t.fmal008
                  CALL afmt030_key_update_b(gs_keys,'fmal_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak2_d_t)
               LET g_log2 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal008
            #add-point:BEFORE FIELD fmal008 name="input.b.page2.fmal008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal008
            
            #add-point:AFTER FIELD fmal008 name="input.a.page2.fmal008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal008 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak2_d[g_detail_idx].fmal008 != g_fmak2_d_t.fmal008)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmal_t WHERE "||"fmalent = '" ||g_enterprise|| "' AND "||"fmal001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmal008 = '"||g_fmak2_d[g_detail_idx].fmal008 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal008
            #add-point:ON CHANGE fmal008 name="input.g.page2.fmal008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal002
            #add-point:BEFORE FIELD fmal002 name="input.b.page2.fmal002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal002
            
            #add-point:AFTER FIELD fmal002 name="input.a.page2.fmal002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal002 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal005 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak2_d[g_detail_idx].fmal002 != g_fmak2_d_t.fmal002 OR g_fmak2_d[g_detail_idx].fmal005 != g_fmak2_d_t.fmal005 OR g_fmak2_d[g_detail_idx].fmal006 != g_fmak2_d_t.fmal006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmal_t WHERE "||"fmalent = '" ||g_enterprise|| "' AND "||"fmal001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmal002 = '"||g_fmak2_d[g_detail_idx].fmal002 ||"' AND "|| "fmal005 = '"||g_fmak2_d[g_detail_idx].fmal005 ||"' AND "|| "fmal006 = '"||g_fmak2_d[g_detail_idx].fmal006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal002
            #add-point:ON CHANGE fmal002 name="input.g.page2.fmal002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal003
            #add-point:BEFORE FIELD fmal003 name="input.b.page2.fmal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal003
            
            #add-point:AFTER FIELD fmal003 name="input.a.page2.fmal003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal003
            #add-point:ON CHANGE fmal003 name="input.g.page2.fmal003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal004
            #add-point:BEFORE FIELD fmal004 name="input.b.page2.fmal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal004
            
            #add-point:AFTER FIELD fmal004 name="input.a.page2.fmal004"
            IF g_fmak2_d[l_ac].fmal003 <> '1' AND g_fmak2_d[l_ac].fmal003 <>'5' THEN 
               IF cl_null(g_fmak2_d[l_ac].fmal004) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = 'afm-00019' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal004
            #add-point:ON CHANGE fmal004 name="input.g.page2.fmal004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal005
            #add-point:BEFORE FIELD fmal005 name="input.b.page2.fmal005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal005
            
            #add-point:AFTER FIELD fmal005 name="input.a.page2.fmal005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal002 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal005 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak2_d[g_detail_idx].fmal002 != g_fmak2_d_t.fmal002 OR g_fmak2_d[g_detail_idx].fmal005 != g_fmak2_d_t.fmal005 OR g_fmak2_d[g_detail_idx].fmal006 != g_fmak2_d_t.fmal006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmal_t WHERE "||"fmalent = '" ||g_enterprise|| "' AND "||"fmal001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmal002 = '"||g_fmak2_d[g_detail_idx].fmal002 ||"' AND "|| "fmal005 = '"||g_fmak2_d[g_detail_idx].fmal005 ||"' AND "|| "fmal006 = '"||g_fmak2_d[g_detail_idx].fmal006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal005
            #add-point:ON CHANGE fmal005 name="input.g.page2.fmal005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal006
            #add-point:BEFORE FIELD fmal006 name="input.b.page2.fmal006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal006
            
            #add-point:AFTER FIELD fmal006 name="input.a.page2.fmal006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal002 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal005 IS NOT NULL AND g_fmak2_d[g_detail_idx].fmal006 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak2_d[g_detail_idx].fmal002 != g_fmak2_d_t.fmal002 OR g_fmak2_d[g_detail_idx].fmal005 != g_fmak2_d_t.fmal005 OR g_fmak2_d[g_detail_idx].fmal006 != g_fmak2_d_t.fmal006)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmal_t WHERE "||"fmalent = '" ||g_enterprise|| "' AND "||"fmal001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmal002 = '"||g_fmak2_d[g_detail_idx].fmal002 ||"' AND "|| "fmal005 = '"||g_fmak2_d[g_detail_idx].fmal005 ||"' AND "|| "fmal006 = '"||g_fmak2_d[g_detail_idx].fmal006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal006
            #add-point:ON CHANGE fmal006 name="input.g.page2.fmal006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmal007
            #add-point:BEFORE FIELD fmal007 name="input.b.page2.fmal007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmal007
            
            #add-point:AFTER FIELD fmal007 name="input.a.page2.fmal007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmal007
            #add-point:ON CHANGE fmal007 name="input.g.page2.fmal007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.fmal008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal008
            #add-point:ON ACTION controlp INFIELD fmal008 name="input.c.page2.fmal008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal002
            #add-point:ON ACTION controlp INFIELD fmal002 name="input.c.page2.fmal002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal003
            #add-point:ON ACTION controlp INFIELD fmal003 name="input.c.page2.fmal003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal004
            #add-point:ON ACTION controlp INFIELD fmal004 name="input.c.page2.fmal004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal005
            #add-point:ON ACTION controlp INFIELD fmal005 name="input.c.page2.fmal005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal006
            #add-point:ON ACTION controlp INFIELD fmal006 name="input.c.page2.fmal006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.fmal007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmal007
            #add-point:ON ACTION controlp INFIELD fmal007 name="input.c.page2.fmal007"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmak2_d[l_ac].* = g_fmak2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt030_unlock_b("fmal_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmak2_d[li_reproduce_target].* = g_fmak2_d[li_reproduce].*
 
               LET g_fmak2_d[li_reproduce_target].fmal008 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmak2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmak2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmak3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmak3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt030_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmak3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmak3_d[l_ac].* TO NULL 
            INITIALIZE g_fmak3_d_t.* TO NULL 
            INITIALIZE g_fmak3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_fmak3_d_t.* = g_fmak3_d[l_ac].*     #新輸入資料
            LET g_fmak3_d_o.* = g_fmak3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt030_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt030_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmak3_d[li_reproduce_target].* = g_fmak3_d[li_reproduce].*
 
               LET g_fmak3_d[li_reproduce_target].fmam002 = NULL
               LET g_fmak3_d[li_reproduce_target].fmam003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
         
            SELECT MAX(fmam006) INTO l_max3 FROM fmam_t WHERE fmam001=g_fmaj_m.fmaj001  AND fmament = g_enterprise
            IF cl_null(l_max3) THEN LET l_max3=0 END IF 
            IF l_max3=0 THEN
               LET l_max3=1
            ELSE 
               LET l_max3=l_max3+1
            END IF    
            LET g_fmak3_d[l_ac].fmam006=l_max3  
            DISPLAY g_fmak3_d[l_ac].fmam006 TO fmam006
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[3] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt030_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE afmt030_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmak3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmak3_d[l_ac].fmam002 IS NOT NULL
               AND g_fmak3_d[l_ac].fmam003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmak3_d_t.* = g_fmak3_d[l_ac].*  #BACKUP
               LET g_fmak3_d_o.* = g_fmak3_d[l_ac].*  #BACKUP
               CALL afmt030_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL afmt030_set_no_entry_b(l_cmd)
               IF NOT afmt030_lock_b("fmam_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt030_bcl3 INTO g_fmak3_d[l_ac].fmam006,g_fmak3_d[l_ac].fmam002,g_fmak3_d[l_ac].fmam003, 
                      g_fmak3_d[l_ac].fmam004,g_fmak3_d[l_ac].fmam005
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmak3_d_mask_o[l_ac].* =  g_fmak3_d[l_ac].*
                  CALL afmt030_fmam_t_mask()
                  LET g_fmak3_d_mask_n[l_ac].* =  g_fmak3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt030_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
 
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body3.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body3.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmaj_m.fmaj001
               LET gs_keys[gs_keys.getLength()+1] = g_fmak3_d_t.fmam002
               LET gs_keys[gs_keys.getLength()+1] = g_fmak3_d_t.fmam003
            
               #刪除同層單身
               IF NOT afmt030_delete_b('fmam_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt030_key_delete_b(gs_keys,'fmam_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt030_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_fmak_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmak3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fmam_t 
             WHERE fmament = g_enterprise AND fmam001 = g_fmaj_m.fmaj001
               AND fmam002 = g_fmak3_d[l_ac].fmam002
               AND fmam003 = g_fmak3_d[l_ac].fmam003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys[2] = g_fmak3_d[g_detail_idx].fmam002
               LET gs_keys[3] = g_fmak3_d[g_detail_idx].fmam003
               CALL afmt030_insert_b('fmam_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmak_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt030_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmak3_d[l_ac].* = g_fmak3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmak3_d[l_ac].* = g_fmak3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL afmt030_fmam_t_mask_restore('restore_mask_o')
                              
               UPDATE fmam_t SET (fmam001,fmam006,fmam002,fmam003,fmam004,fmam005) = (g_fmaj_m.fmaj001, 
                   g_fmak3_d[l_ac].fmam006,g_fmak3_d[l_ac].fmam002,g_fmak3_d[l_ac].fmam003,g_fmak3_d[l_ac].fmam004, 
                   g_fmak3_d[l_ac].fmam005) #自訂欄位頁簽
                WHERE fmament = g_enterprise AND fmam001 = g_fmaj_m.fmaj001
                  AND fmam002 = g_fmak3_d_t.fmam002 #項次 
                  AND fmam003 = g_fmak3_d_t.fmam003
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmak3_d[l_ac].* = g_fmak3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmam_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_fmak3_d[l_ac].* = g_fmak3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys_bak[1] = g_fmaj001_t
               LET gs_keys[2] = g_fmak3_d[g_detail_idx].fmam002
               LET gs_keys_bak[2] = g_fmak3_d_t.fmam002
               LET gs_keys[3] = g_fmak3_d[g_detail_idx].fmam003
               LET gs_keys_bak[3] = g_fmak3_d_t.fmam003
               CALL afmt030_update_b('fmam_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt030_fmam_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmak3_d[g_detail_idx].fmam002 = g_fmak3_d_t.fmam002 
                  AND g_fmak3_d[g_detail_idx].fmam003 = g_fmak3_d_t.fmam003 
                  ) THEN
                  LET gs_keys[01] = g_fmaj_m.fmaj001
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak3_d_t.fmam002
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak3_d_t.fmam003
                  CALL afmt030_key_update_b(gs_keys,'fmam_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak3_d_t)
               LET g_log2 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam006
            #add-point:BEFORE FIELD fmam006 name="input.b.page3.fmam006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam006
            
            #add-point:AFTER FIELD fmam006 name="input.a.page3.fmam006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmam006
            #add-point:ON CHANGE fmam006 name="input.g.page3.fmam006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam002
            
            #add-point:AFTER FIELD fmam002 name="input.a.page3.fmam002"
            #此段落由子樣板a05產生
            #確認資料無重複

            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak3_d[g_detail_idx].fmam002 IS NOT NULL AND g_fmak3_d[g_detail_idx].fmam003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak3_d[g_detail_idx].fmam002 != g_fmak3_d_t.fmam002 OR g_fmak3_d[g_detail_idx].fmam003 != g_fmak3_d_t.fmam003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmam_t WHERE "||"fmament = '" ||g_enterprise|| "' AND "||"fmam001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmam002 = '"||g_fmak3_d[g_detail_idx].fmam002 ||"' AND "|| "fmam003 = '"||g_fmak3_d[g_detail_idx].fmam003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmak3_d[l_ac].fmam002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmac006") THEN
                  #檢查成功時後續處理
                  LET g_fmak3_d[l_ac].lbl_fmam002_desc = g_chkparam.return1
                  DISPLAY g_fmak3_d[l_ac].lbl_fmam002_desc TO  lbl_fmam002_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF                                                                    
            END IF 
            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam002
            #add-point:BEFORE FIELD fmam002 name="input.b.page3.fmam002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmam002
            #add-point:ON CHANGE fmam002 name="input.g.page3.fmam002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fmam002_desc
            #add-point:BEFORE FIELD lbl_fmam002_desc name="input.b.page3.lbl_fmam002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fmam002_desc
            
            #add-point:AFTER FIELD lbl_fmam002_desc name="input.a.page3.lbl_fmam002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fmam002_desc
            #add-point:ON CHANGE lbl_fmam002_desc name="input.g.page3.lbl_fmam002_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam003
            #add-point:BEFORE FIELD fmam003 name="input.b.page3.fmam003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam003
            
            #add-point:AFTER FIELD fmam003 name="input.a.page3.fmam003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak3_d[g_detail_idx].fmam002 IS NOT NULL AND g_fmak3_d[g_detail_idx].fmam003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak3_d[g_detail_idx].fmam002 != g_fmak3_d_t.fmam002 OR g_fmak3_d[g_detail_idx].fmam003 != g_fmak3_d_t.fmam003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fmam_t WHERE "||"fmament = '" ||g_enterprise|| "' AND "||"fmam001 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fmam002 = '"||g_fmak3_d[g_detail_idx].fmam002 ||"' AND "|| "fmam003 = '"||g_fmak3_d[g_detail_idx].fmam003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmam003
            #add-point:ON CHANGE fmam003 name="input.g.page3.fmam003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam004
            
            #add-point:AFTER FIELD fmam004 name="input.a.page3.fmam004"
             IF NOT cl_null(g_fmak3_d[l_ac].fmam004) THEN 
               #此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmak3_d[l_ac].fmam004
               LET g_chkparam.arg2 = g_fmaj_m.fmaj002
               LET g_chkparam.arg3 = g_fmak3_d[l_ac].fmam002
                  
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_fmak003") THEN
                  #檢查成功時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF        

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam004
            #add-point:BEFORE FIELD fmam004 name="input.b.page3.fmam004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmam004
            #add-point:ON CHANGE fmam004 name="input.g.page3.fmam004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmam005
            #add-point:BEFORE FIELD fmam005 name="input.b.page3.fmam005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmam005
            
            #add-point:AFTER FIELD fmam005 name="input.a.page3.fmam005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmam005
            #add-point:ON CHANGE fmam005 name="input.g.page3.fmam005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.fmam006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam006
            #add-point:ON ACTION controlp INFIELD fmam006 name="input.c.page3.fmam006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmam002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam002
            #add-point:ON ACTION controlp INFIELD fmam002 name="input.c.page3.fmam002"
              #add-point:ON ACTION controlp INFIELD fmam002
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmak3_d[l_ac].fmam002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmak3_d[l_ac].fmam002 = g_qryparam.return1              

            DISPLAY g_fmak3_d[l_ac].fmam002 TO fmam002              #

            NEXT FIELD fmam002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.lbl_fmam002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fmam002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fmam002_desc name="input.c.page3.lbl_fmam002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmam003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam003
            #add-point:ON ACTION controlp INFIELD fmam003 name="input.c.page3.fmam003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.fmam004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam004
            #add-point:ON ACTION controlp INFIELD fmam004 name="input.c.page3.fmam004"
           #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmak3_d[l_ac].fmam004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_fmak003()                                #呼叫開窗

            LET g_fmak3_d[l_ac].fmam004 = g_qryparam.return1              

            DISPLAY g_fmak3_d[l_ac].fmam004 TO fmam004              #

            NEXT FIELD fmam004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.page3.fmam005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmam005
            #add-point:ON ACTION controlp INFIELD fmam005 name="input.c.page3.fmam005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmak3_d[l_ac].* = g_fmak3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt030_unlock_b("fmam_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmak3_d[li_reproduce_target].* = g_fmak3_d[li_reproduce].*
 
               LET g_fmak3_d[li_reproduce_target].fmam002 = NULL
               LET g_fmak3_d[li_reproduce_target].fmam003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmak3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmak3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_fmak4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            IF g_fmaj_m.fmaj012='Y' THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -100 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
            END IF 
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_fmak4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL afmt030_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_fmak4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_fmak4_d[l_ac].* TO NULL 
            INITIALIZE g_fmak4_d_t.* TO NULL 
            INITIALIZE g_fmak4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_fmak4_d_t.* = g_fmak4_d[l_ac].*     #新輸入資料
            LET g_fmak4_d_o.* = g_fmak4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL afmt030_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL afmt030_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_fmak4_d[li_reproduce_target].* = g_fmak4_d[li_reproduce].*
 
               LET g_fmak4_d[li_reproduce_target].fman002 = NULL
               LET g_fmak4_d[li_reproduce_target].fman009 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"

            LET g_fmak4_d[l_ac].fman003=g_fmaj_m.fmaj009   #预设值为单头“单款期限起”
            DISPLAY g_fmak4_d[l_ac].fman003 TO fman003
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[4] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN afmt030_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE afmt030_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_fmak4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_fmak4_d[l_ac].fman002 IS NOT NULL
               AND g_fmak4_d[l_ac].fman009 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_fmak4_d_t.* = g_fmak4_d[l_ac].*  #BACKUP
               LET g_fmak4_d_o.* = g_fmak4_d[l_ac].*  #BACKUP
               CALL afmt030_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL afmt030_set_no_entry_b(l_cmd)
               IF NOT afmt030_lock_b("fman_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH afmt030_bcl4 INTO g_fmak4_d[l_ac].fman010,g_fmak4_d[l_ac].fman002,g_fmak4_d[l_ac].fman003, 
                      g_fmak4_d[l_ac].fman004,g_fmak4_d[l_ac].fman005,g_fmak4_d[l_ac].fman006,g_fmak4_d[l_ac].fman007, 
                      g_fmak4_d[l_ac].fman008,g_fmak4_d[l_ac].fman009
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_fmak4_d_mask_o[l_ac].* =  g_fmak4_d[l_ac].*
                  CALL afmt030_fman_t_mask()
                  LET g_fmak4_d_mask_n[l_ac].* =  g_fmak4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL afmt030_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body4.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body4.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body4.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_fmaj_m.fmaj001
               LET gs_keys[gs_keys.getLength()+1] = g_fmak4_d_t.fman002
               LET gs_keys[gs_keys.getLength()+1] = g_fmak4_d_t.fman009
            
               #刪除同層單身
               IF NOT afmt030_delete_b('fman_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT afmt030_key_delete_b(gs_keys,'fman_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE afmt030_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE afmt030_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_fmak_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_fmak4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
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
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM fman_t 
             WHERE fmanent = g_enterprise AND fman001 = g_fmaj_m.fmaj001
               AND fman002 = g_fmak4_d[l_ac].fman002
               AND fman009 = g_fmak4_d[l_ac].fman009
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               LET g_fmak4_d[g_detail_idx].fman009=" "
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys[2] = g_fmak4_d[g_detail_idx].fman002
               LET gs_keys[3] = g_fmak4_d[g_detail_idx].fman009
               CALL afmt030_insert_b('fman_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_fmak_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL afmt030_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body4.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_fmak4_d[l_ac].* = g_fmak4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_fmak4_d[l_ac].* = g_fmak4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL afmt030_fman_t_mask_restore('restore_mask_o')
                              
               UPDATE fman_t SET (fman001,fman010,fman002,fman003,fman004,fman005,fman006,fman007,fman008, 
                   fman009) = (g_fmaj_m.fmaj001,g_fmak4_d[l_ac].fman010,g_fmak4_d[l_ac].fman002,g_fmak4_d[l_ac].fman003, 
                   g_fmak4_d[l_ac].fman004,g_fmak4_d[l_ac].fman005,g_fmak4_d[l_ac].fman006,g_fmak4_d[l_ac].fman007, 
                   g_fmak4_d[l_ac].fman008,g_fmak4_d[l_ac].fman009) #自訂欄位頁簽
                WHERE fmanent = g_enterprise AND fman001 = g_fmaj_m.fmaj001
                  AND fman002 = g_fmak4_d_t.fman002 #項次 
                  AND fman009 = g_fmak4_d_t.fman009
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_fmak4_d[l_ac].* = g_fmak4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fman_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_fmak4_d[l_ac].* = g_fmak4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_fmaj_m.fmaj001
               LET gs_keys_bak[1] = g_fmaj001_t
               LET gs_keys[2] = g_fmak4_d[g_detail_idx].fman002
               LET gs_keys_bak[2] = g_fmak4_d_t.fman002
               LET gs_keys[3] = g_fmak4_d[g_detail_idx].fman009
               LET gs_keys_bak[3] = g_fmak4_d_t.fman009
               CALL afmt030_update_b('fman_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL afmt030_fman_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_fmak4_d[g_detail_idx].fman002 = g_fmak4_d_t.fman002 
                  AND g_fmak4_d[g_detail_idx].fman009 = g_fmak4_d_t.fman009 
                  ) THEN
                  LET gs_keys[01] = g_fmaj_m.fmaj001
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak4_d_t.fman002
                  LET gs_keys[gs_keys.getLength()+1] = g_fmak4_d_t.fman009
                  CALL afmt030_key_update_b(gs_keys,'fman_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak4_d_t)
               LET g_log2 = util.JSON.stringify(g_fmaj_m),util.JSON.stringify(g_fmak4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman010
            #add-point:BEFORE FIELD fman010 name="input.b.page4.fman010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman010
            
            #add-point:AFTER FIELD fman010 name="input.a.page4.fman010"
            IF NOT cl_null(g_fmak4_d[l_ac].fman010) THEN 
               SELECT COUNT(*) INTO l_sum FROM fmak_t WHERE fmak011=g_fmak4_d[l_ac].fman010 AND fmak001=g_fmaj_m.fmaj001 
               IF l_sum>0 THEN 
                  SELECT fmak002,fmak005 INTO g_fmak4_d[l_ac].fman002,g_fmak4_d[l_ac].fman004 FROM fmak_t WHERE  fmak011=g_fmak4_d[l_ac].fman010 AND fmak001=g_fmaj_m.fmaj001
                  IF g_fmak4_d[l_ac].fman004='2'  THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "fman_t" 
                     LET g_errparam.code   = "afm-00025" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  ELSE 
                     SELECT ooail003  INTO g_fmak4_d[l_ac].lbl_fman002_desc FROM  ooail_t WHERE ooail001 = g_fmak4_d[l_ac].fman002
                                                                             AND ooailent=g_enterprise
                     DISPLAY g_fmak4_d[l_ac].fman002 TO fman002
                     DISPLAY g_fmak4_d[l_ac].fman004 TO fman004
                     DISPLAY g_fmak4_d[l_ac].lbl_fman002_desc TO lbl_fman002_desc                  
                  END IF                   
               ELSE 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "fman_t" 
                  LET g_errparam.code   = "afm-00024" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF 
            END IF    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman010
            #add-point:ON CHANGE fman010 name="input.g.page4.fman010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman002
            
            #add-point:AFTER FIELD fman002 name="input.a.page4.fman002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak4_d[g_detail_idx].fman002 IS NOT NULL  THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak4_d[g_detail_idx].fman002 != g_fmak4_d_t.fman002 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fman_t WHERE "||"fmanent = '" ||g_enterprise|| "' AND "||"fman002 = '"||g_fmaj_m.fmaj001 ||"' ",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.where = " 1=1"
               LET g_chkparam.arg1 = g_fmak4_d[l_ac].fman002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist_and_ref_val("v_fmac006") THEN
                  #檢查成功時後續處理
                  LET g_fmak4_d[l_ac].lbl_fman002_desc = g_chkparam.return1
                  DISPLAY g_fmak4_d[l_ac].lbl_fman002_desc TO  lbl_fman002_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = -100 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman002
            #add-point:BEFORE FIELD fman002 name="input.b.page4.fman002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman002
            #add-point:ON CHANGE fman002 name="input.g.page4.fman002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD lbl_fman002_desc
            #add-point:BEFORE FIELD lbl_fman002_desc name="input.b.page4.lbl_fman002_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD lbl_fman002_desc
            
            #add-point:AFTER FIELD lbl_fman002_desc name="input.a.page4.lbl_fman002_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE lbl_fman002_desc
            #add-point:ON CHANGE lbl_fman002_desc name="input.g.page4.lbl_fman002_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman003
            #add-point:BEFORE FIELD fman003 name="input.b.page4.fman003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman003
            
            #add-point:AFTER FIELD fman003 name="input.a.page4.fman003"
            IF NOT  cl_null(g_fmak4_d[l_ac].fman003) THEN 
               IF g_fmak4_d[l_ac].fman003< g_fmaj_m.fmaj009 OR g_fmak4_d[l_ac].fman003 >g_fmaj_m.fmaj010 THEN 
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = "afm-00021" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman003
            #add-point:ON CHANGE fman003 name="input.g.page4.fman003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman004
            #add-point:BEFORE FIELD fman004 name="input.b.page4.fman004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman004
            
            #add-point:AFTER FIELD fman004 name="input.a.page4.fman004"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman004
            #add-point:ON CHANGE fman004 name="input.g.page4.fman004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmak4_d[l_ac].fman005,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD fman005
            END IF 
 
 
 
            #add-point:AFTER FIELD fman005 name="input.a.page4.fman005"
            IF NOT cl_null(g_fmak4_d[l_ac].fman005) THEN
               IF g_fmak4_d[l_ac].fman004='1' THEN 
                  LET g_fmak4_d[l_ac].fman008 =g_fmak4_d[l_ac].fman005
                  DISPLAY g_fmak4_d[l_ac].fman008 TO fman008
               ELSE 
                   NEXT FIELD fman006              
               END IF 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman005
            #add-point:BEFORE FIELD fman005 name="input.b.page4.fman005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman005
            #add-point:ON CHANGE fman005 name="input.g.page4.fman005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman006
            #add-point:BEFORE FIELD fman006 name="input.b.page4.fman006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman006
            
            #add-point:AFTER FIELD fman006 name="input.a.page4.fman006"
            IF g_fmak4_d[l_ac].fman004='2' THEN 
               IF cl_null( g_fmak4_d[l_ac].fman006) THEN 
                  LET g_errparam.extend = g_browser_cnt
                  LET g_errparam.code   = 'afm-00023' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               ELSE 
                 NEXT FIELD fman007
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman006
            #add-point:ON CHANGE fman006 name="input.g.page4.fman006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_fmak4_d[l_ac].fman007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD fman007
            END IF 
 
 
 
            #add-point:AFTER FIELD fman007 name="input.a.page4.fman007"
            IF NOT cl_null(g_fmak4_d[l_ac].fman007) THEN
               IF g_fmak4_d[l_ac].fman004='2' THEN 
                  IF g_fmak4_d[l_ac].fman007<0 THEN 
                     LET g_errparam.extend = g_browser_cnt
                     LET g_errparam.code   = "afm-00022" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  ELSE 
                     IF g_fmak4_d[l_ac].fman006='1' THEN 
                        LET g_fmak4_d[l_ac].fman008=g_fmak4_d[l_ac].fman005*(1+g_fmak4_d[l_ac].fman007)
                     ELSE 
                        LET g_fmak4_d[l_ac].fman008=g_fmak4_d[l_ac].fman005+g_fmak4_d[l_ac].fman007
                     END IF 
                  END IF 
               ELSE 
                  LET g_fmak4_d[l_ac].fman008=g_fmak4_d[l_ac].fman005             
               END IF
               DISPLAY  g_fmak4_d[l_ac].fman008 TO fman008              
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman007
            #add-point:BEFORE FIELD fman007 name="input.b.page4.fman007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman007
            #add-point:ON CHANGE fman007 name="input.g.page4.fman007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman008
            #add-point:BEFORE FIELD fman008 name="input.b.page4.fman008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman008
            
            #add-point:AFTER FIELD fman008 name="input.a.page4.fman008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman008
            #add-point:ON CHANGE fman008 name="input.g.page4.fman008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fman009
            #add-point:BEFORE FIELD fman009 name="input.b.page4.fman009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fman009
            
            #add-point:AFTER FIELD fman009 name="input.a.page4.fman009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_fmaj_m.fmaj001 IS NOT NULL AND g_fmak4_d[g_detail_idx].fman002 IS NOT NULL AND g_fmak4_d[g_detail_idx].fman009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_fmaj_m.fmaj001 != g_fmaj001_t OR g_fmak4_d[g_detail_idx].fman002 != g_fmak4_d_t.fman002 OR g_fmak4_d[g_detail_idx].fman009 != g_fmak4_d_t.fman009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM fman_t WHERE "||"fmanent = '" ||g_enterprise|| "' AND "||"fman002 = '"||g_fmaj_m.fmaj001 ||"' AND "|| "fman009 = '"||g_fmak4_d[g_detail_idx].fman002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fman009
            #add-point:ON CHANGE fman009 name="input.g.page4.fman009"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.fman010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman010
            #add-point:ON ACTION controlp INFIELD fman010 name="input.c.page4.fman010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman002
            #add-point:ON ACTION controlp INFIELD fman002 name="input.c.page4.fman002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmak4_d[l_ac].fman002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_fmak4_d[l_ac].fman002 = g_qryparam.return1              

            DISPLAY g_fmak4_d[l_ac].fman002 TO fman002              #

            NEXT FIELD fman002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page4.lbl_fman002_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD lbl_fman002_desc
            #add-point:ON ACTION controlp INFIELD lbl_fman002_desc name="input.c.page4.lbl_fman002_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman003
            #add-point:ON ACTION controlp INFIELD fman003 name="input.c.page4.fman003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman004
            #add-point:ON ACTION controlp INFIELD fman004 name="input.c.page4.fman004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman005
            #add-point:ON ACTION controlp INFIELD fman005 name="input.c.page4.fman005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman006
            #add-point:ON ACTION controlp INFIELD fman006 name="input.c.page4.fman006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman007
            #add-point:ON ACTION controlp INFIELD fman007 name="input.c.page4.fman007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman008
            #add-point:ON ACTION controlp INFIELD fman008 name="input.c.page4.fman008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.fman009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fman009
            #add-point:ON ACTION controlp INFIELD fman009 name="input.c.page4.fman009"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_fmak4_d[l_ac].* = g_fmak4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE afmt030_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL afmt030_unlock_b("fman_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_fmak4_d[li_reproduce_target].* = g_fmak4_d[li_reproduce].*
 
               LET g_fmak4_d[li_reproduce_target].fman002 = NULL
               LET g_fmak4_d[li_reproduce_target].fman009 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_fmak4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_fmak4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
      DISPLAY ARRAY g_fmak5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL afmt030_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail5")
            LET g_detail_idx = l_ac
            
            #add-point:page5, before row動作 name="input.body5.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail5")
            CALL afmt030_idx_chk()
            LET g_current_page = 5
      
         #add-point:page5自定義行為 name="input.body5.action"
         
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_fmak6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL afmt030_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            LET g_detail_idx = l_ac
            
            #add-point:page6, before row動作 name="input.body6.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail6")
            CALL afmt030_idx_chk()
            LET g_current_page = 6
      
         #add-point:page6自定義行為 name="input.body6.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="afmt030.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','5','6',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue(""))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD fmaj001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD fmak011
               WHEN "s_detail2"
                  NEXT FIELD fmal008
               WHEN "s_detail3"
                  NEXT FIELD fmam006
               WHEN "s_detail4"
                  NEXT FIELD fman010
               WHEN "s_detail5"
                  NEXT FIELD lbl_fmaw002
               WHEN "s_detail6"
                  NEXT FIELD lbl_fmao002
 
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
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
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
         LET g_detail_idx_list[3] = 1
         LET g_detail_idx_list[4] = 1
         LET g_detail_idx_list[5] = 1
         LET g_detail_idx_list[6] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION afmt030_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL cl_set_act_visible("delete,modify,modify_detail", TRUE)
   SELECT DISTINCT fmajstus INTO g_fmaj_m.fmajstus FROM fmaj_t WHERE fmajent= g_enterprise AND fmaj001 = g_fmaj_m.fmaj001
    IF cl_null(g_fmaj_m.fmajstus) THEN
       LET g_fmaj_m.fmajstus = 'N'
    END IF
    DISPLAY BY NAME g_fmaj_m.fmajstus
    CASE g_fmaj_m.fmajstus
       WHEN "N"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",TRUE)
     WHEN "Y"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
     WHEN "X"
        CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
        CALL cl_set_act_visible("delete,modify,modify_detail",FALSE)
   END CASE 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL afmt030_b_fill() #單身填充
      CALL afmt030_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL afmt030_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_fmaj_m_mask_o.* =  g_fmaj_m.*
   CALL afmt030_fmaj_t_mask()
   LET g_fmaj_m_mask_n.* =  g_fmaj_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
       g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr,g_fmaj_m.lbl_gsfr_desc,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010, 
       g_fmaj_m.fmajstus,g_fmaj_m.fmajownid,g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp,g_fmaj_m.fmajowndp_desc, 
       g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajcrtdt, 
       g_fmaj_m.fmajmodid,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfid_desc, 
       g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017, 
       g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmaj_m.fmajstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_fmak_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_fmak2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

   
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmak3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmak4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmak5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_fmak6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL afmt030_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION afmt030_detail_show()
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
 
{<section id="afmt030.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION afmt030_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE fmaj_t.fmaj001 
   DEFINE l_oldno     LIKE fmaj_t.fmaj001 
 
   DEFINE l_master    RECORD LIKE fmaj_t.*
   DEFINE l_detail    RECORD LIKE fmak_t.*
   DEFINE l_detail2    RECORD LIKE fmal_t.*
 
   DEFINE l_detail3    RECORD LIKE fmam_t.*
 
   DEFINE l_detail4    RECORD LIKE fman_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_fmaj_m.fmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_fmaj001_t = g_fmaj_m.fmaj001
 
    
   LET g_fmaj_m.fmaj001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_fmaj_m.fmajownid = g_user
      LET g_fmaj_m.fmajowndp = g_dept
      LET g_fmaj_m.fmajcrtid = g_user
      LET g_fmaj_m.fmajcrtdp = g_dept 
      LET g_fmaj_m.fmajcrtdt = cl_get_current()
      LET g_fmaj_m.fmajmodid = g_user
      LET g_fmaj_m.fmajmoddt = cl_get_current()
      LET g_fmaj_m.fmajstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_fmaj_m.fmajstus 
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL afmt030_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_fmaj_m.* TO NULL
      INITIALIZE g_fmak_d TO NULL
      INITIALIZE g_fmak2_d TO NULL
      INITIALIZE g_fmak3_d TO NULL
      INITIALIZE g_fmak4_d TO NULL
      INITIALIZE g_fmak5_d TO NULL
      INITIALIZE g_fmak6_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL afmt030_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL afmt030_set_act_visible()   
   CALL afmt030_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_fmaj001_t = g_fmaj_m.fmaj001
 
   
   #組合新增資料的條件
   LET g_add_browse = " fmajent = " ||g_enterprise|| " AND",
                      " fmaj001 = '", g_fmaj_m.fmaj001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL afmt030_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL afmt030_idx_chk()
   
   LET g_data_owner = g_fmaj_m.fmajownid      
   LET g_data_dept  = g_fmaj_m.fmajowndp
   
   #功能已完成,通報訊息中心
   CALL afmt030_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION afmt030_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE fmak_t.*
   DEFINE l_detail2    RECORD LIKE fmal_t.*
 
   DEFINE l_detail3    RECORD LIKE fmam_t.*
 
   DEFINE l_detail4    RECORD LIKE fman_t.*
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE afmt030_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmak_t
    WHERE fmakent = g_enterprise AND fmak001 = g_fmaj001_t
 
    INTO TEMP afmt030_detail
 
   #將key修正為調整後   
   UPDATE afmt030_detail 
      #更新key欄位
      SET fmak001 = g_fmaj_m.fmaj001
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO fmak_t SELECT * FROM afmt030_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt030_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmal_t 
    WHERE fmalent = g_enterprise AND fmal001 = g_fmaj001_t
 
    INTO TEMP afmt030_detail
 
   #將key修正為調整後   
   UPDATE afmt030_detail SET fmal001 = g_fmaj_m.fmaj001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmal_t SELECT * FROM afmt030_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt030_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fmam_t 
    WHERE fmament = g_enterprise AND fmam001 = g_fmaj001_t
 
    INTO TEMP afmt030_detail
 
   #將key修正為調整後   
   UPDATE afmt030_detail SET fmam001 = g_fmaj_m.fmaj001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fmam_t SELECT * FROM afmt030_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt030_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM fman_t 
    WHERE fmanent = g_enterprise AND fman001 = g_fmaj001_t
 
    INTO TEMP afmt030_detail
 
   #將key修正為調整後   
   UPDATE afmt030_detail SET fman001 = g_fmaj_m.fmaj001
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO fman_t SELECT * FROM afmt030_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE afmt030_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_fmaj001_t = g_fmaj_m.fmaj001
 
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.delete" >}
#+ 資料刪除
PRIVATE FUNCTION afmt030_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_fmaj_m.fmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt030_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE afmt030_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT afmt030_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_fmaj_m_mask_o.* =  g_fmaj_m.*
   CALL afmt030_fmaj_t_mask()
   LET g_fmaj_m_mask_n.* =  g_fmaj_m.*
   
   CALL afmt030_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL afmt030_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_fmaj001_t = g_fmaj_m.fmaj001
 
 
      DELETE FROM fmaj_t
       WHERE fmajent = g_enterprise AND fmaj001 = g_fmaj_m.fmaj001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_fmaj_m.fmaj001,":",SQLERRMESSAGE  
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM fmak_t
       WHERE fmakent = g_enterprise AND fmak001 = g_fmaj_m.fmaj001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM fmal_t
       WHERE fmalent = g_enterprise AND
             fmal001 = g_fmaj_m.fmaj001
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM fmam_t
       WHERE fmament = g_enterprise AND
             fmam001 = g_fmaj_m.fmaj001
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM fman_t
       WHERE fmanent = g_enterprise AND
             fman001 = g_fmaj_m.fmaj001
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE afmt030_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_fmak_d.clear() 
      CALL g_fmak2_d.clear()       
      CALL g_fmak3_d.clear()       
      CALL g_fmak4_d.clear()       
      CALL g_fmak5_d.clear()       
      CALL g_fmak6_d.clear()       
 
     
      CALL afmt030_ui_browser_refresh()  
      #CALL afmt030_ui_headershow()  
      #CALL afmt030_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL afmt030_browser_fill("")
         CALL afmt030_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE afmt030_cl
 
   #功能已完成,通報訊息中心
   CALL afmt030_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="afmt030.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmt030_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_fmak_d.clear()
   CALL g_fmak2_d.clear()
   CALL g_fmak3_d.clear()
   CALL g_fmak4_d.clear()
   CALL g_fmak5_d.clear()
   CALL g_fmak6_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF afmt030_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT fmak011,fmak002,fmak003,fmak004,fmak005,fmak006,fmak007,fmak008, 
             fmak009,fmak010  FROM fmak_t",   
                     " INNER JOIN fmaj_t ON fmajent = " ||g_enterprise|| " AND fmaj001 = fmak001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE fmakent=? AND fmak001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmak_t.fmak011"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR afmt030_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_fmaj_m.fmaj001
                                               
      FOREACH b_fill_cs INTO g_fmak_d[l_ac].fmak011,g_fmak_d[l_ac].fmak002,g_fmak_d[l_ac].fmak003,g_fmak_d[l_ac].fmak004, 
          g_fmak_d[l_ac].fmak005,g_fmak_d[l_ac].fmak006,g_fmak_d[l_ac].fmak007,g_fmak_d[l_ac].fmak008, 
          g_fmak_d[l_ac].fmak009,g_fmak_d[l_ac].fmak010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
            SELECT ooail003  INTO g_fmak_d[l_ac].lbl_fmak002_desc FROM  ooail_t WHERE ooail001 = g_fmak_d[l_ac].fmak002
                                                                             AND ooailent=g_enterprise
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
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF afmt030_fill_chk(2) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT fmal008,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007  FROM fmal_t", 
                
                     " INNER JOIN  fmaj_t ON fmajent = " ||g_enterprise|| " AND fmaj001 = fmal001 ",
 
                     "",
                     
                     
                     " WHERE fmalent=? AND fmal001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmal_t.fmal008"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR afmt030_pb2
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_fmaj_m.fmaj001
                                               
      FOREACH b_fill_cs2 INTO g_fmak2_d[l_ac].fmal008,g_fmak2_d[l_ac].fmal002,g_fmak2_d[l_ac].fmal003, 
          g_fmak2_d[l_ac].fmal004,g_fmak2_d[l_ac].fmal005,g_fmak2_d[l_ac].fmal006,g_fmak2_d[l_ac].fmal007 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF afmt030_fill_chk(3) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT fmam006,fmam002,fmam003,fmam004,fmam005  FROM fmam_t",   
                     " INNER JOIN  fmaj_t ON fmajent = " ||g_enterprise|| " AND fmaj001 = fmam001 ",
 
                     "",
                     
                     
                     " WHERE fmament=? AND fmam001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fmam_t.fmam002,fmam_t.fmam003"
         
         #add-point:單身填充控制 name="b_fill.sql3"
     
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR afmt030_pb3
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_fmaj_m.fmaj001
                                               
      FOREACH b_fill_cs3 INTO g_fmak3_d[l_ac].fmam006,g_fmak3_d[l_ac].fmam002,g_fmak3_d[l_ac].fmam003, 
          g_fmak3_d[l_ac].fmam004,g_fmak3_d[l_ac].fmam005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
         SELECT ooail003  INTO g_fmak3_d[l_ac].lbl_fmam002_desc FROM  ooail_t WHERE ooail001 = g_fmak3_d[l_ac].fmam002
                                                                             AND ooailent=g_enterprise
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF afmt030_fill_chk(4) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT fman010,fman002,fman003,fman004,fman005,fman006,fman007,fman008, 
             fman009  FROM fman_t",   
                     " INNER JOIN  fmaj_t ON fmajent = " ||g_enterprise|| " AND fmaj001 = fman001 ",
 
                     "",
                     
                     
                     " WHERE fmanent=? AND fman001=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body4.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY fman_t.fman002,fman_t.fman009"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR afmt030_pb4
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_fmaj_m.fmaj001
                                               
      FOREACH b_fill_cs4 INTO g_fmak4_d[l_ac].fman010,g_fmak4_d[l_ac].fman002,g_fmak4_d[l_ac].fman003, 
          g_fmak4_d[l_ac].fman004,g_fmak4_d[l_ac].fman005,g_fmak4_d[l_ac].fman006,g_fmak4_d[l_ac].fman007, 
          g_fmak4_d[l_ac].fman008,g_fmak4_d[l_ac].fman009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         SELECT ooail003  INTO g_fmak4_d[l_ac].lbl_fman002_desc FROM  ooail_t WHERE ooail001 = g_fmak4_d[l_ac].fman002
                                                                             AND ooailent=g_enterprise
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   IF afmt030_fill_chk(5) THEN
      LET g_sql = "SELECT  UNIQUE fmaw002,fmaw007,fmaw008,fmaw006  FROM fmaw_t",   
                  " WHERE fmawent=? AND fmaw003=?  ORDER BY fmaw_t.fmaw006"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR afmt030_pb5
      
         LET l_ac = 1
      
         OPEN b_fill_cs5 USING g_enterprise,g_fmaj_m.fmaj001
                                               
         FOREACH b_fill_cs5 INTO g_fmak5_d[l_ac].lbl_fmaw002,g_fmak5_d[l_ac].lbl_fmaw007,g_fmak5_d[l_ac].lbl_fmaw008,g_fmak5_d[l_ac].lbl_fmaw006
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               EXIT FOREACH
            END IF

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
   
    IF afmt030_fill_chk(6) THEN
      LET g_sql = "SELECT  UNIQUE fmao002,fmao003,fmao004,fmao005,fmao006,fmao007  FROM fmao_t",   
                  " WHERE fmaoent=? AND fmao001=?  ORDER BY fmao002,fmao003"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE afmt030_pb6 FROM g_sql
         DECLARE b_fill_cs6 CURSOR FOR afmt030_pb6
      
         LET l_ac = 1
      
         OPEN b_fill_cs6 USING g_enterprise,g_fmaj_m.fmaj001
                                               
         FOREACH b_fill_cs6 INTO g_fmak6_d[l_ac].lbl_fmao002,g_fmak6_d[l_ac].lbl_fmao003,g_fmak6_d[l_ac].lbl_fmao004,g_fmak6_d[l_ac].lbl_fmao005,
                                 g_fmak6_d[l_ac].lbl_fmao006,g_fmak6_d[l_ac].lbl_fmao007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               EXIT FOREACH
            END IF

         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
   #end add-point
   
   CALL g_fmak_d.deleteElement(g_fmak_d.getLength())
   CALL g_fmak2_d.deleteElement(g_fmak2_d.getLength())
   CALL g_fmak3_d.deleteElement(g_fmak3_d.getLength())
   CALL g_fmak4_d.deleteElement(g_fmak4_d.getLength())
   CALL g_fmak5_d.deleteElement(g_fmak5_d.getLength())
   CALL g_fmak6_d.deleteElement(g_fmak6_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE afmt030_pb
   FREE afmt030_pb2
 
   FREE afmt030_pb3
 
   FREE afmt030_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_fmak_d.getLength()
      LET g_fmak_d_mask_o[l_ac].* =  g_fmak_d[l_ac].*
      CALL afmt030_fmak_t_mask()
      LET g_fmak_d_mask_n[l_ac].* =  g_fmak_d[l_ac].*
   END FOR
   
   LET g_fmak2_d_mask_o.* =  g_fmak2_d.*
   FOR l_ac = 1 TO g_fmak2_d.getLength()
      LET g_fmak2_d_mask_o[l_ac].* =  g_fmak2_d[l_ac].*
      CALL afmt030_fmal_t_mask()
      LET g_fmak2_d_mask_n[l_ac].* =  g_fmak2_d[l_ac].*
   END FOR
   LET g_fmak3_d_mask_o.* =  g_fmak3_d.*
   FOR l_ac = 1 TO g_fmak3_d.getLength()
      LET g_fmak3_d_mask_o[l_ac].* =  g_fmak3_d[l_ac].*
      CALL afmt030_fmam_t_mask()
      LET g_fmak3_d_mask_n[l_ac].* =  g_fmak3_d[l_ac].*
   END FOR
   LET g_fmak4_d_mask_o.* =  g_fmak4_d.*
   FOR l_ac = 1 TO g_fmak4_d.getLength()
      LET g_fmak4_d_mask_o[l_ac].* =  g_fmak4_d[l_ac].*
      CALL afmt030_fman_t_mask()
      LET g_fmak4_d_mask_n[l_ac].* =  g_fmak4_d[l_ac].*
   END FOR
   LET g_fmak5_d_mask_o.* =  g_fmak5_d.*
   FOR l_ac = 1 TO g_fmak5_d.getLength()
      LET g_fmak5_d_mask_o[l_ac].* =  g_fmak5_d[l_ac].*
      CALL afmt030_fmak_t_mask()
      LET g_fmak5_d_mask_n[l_ac].* =  g_fmak5_d[l_ac].*
   END FOR
   LET g_fmak6_d_mask_o.* =  g_fmak6_d.*
   FOR l_ac = 1 TO g_fmak6_d.getLength()
      LET g_fmak6_d_mask_o[l_ac].* =  g_fmak6_d[l_ac].*
      CALL afmt030_fmak_t_mask()
      LET g_fmak6_d_mask_n[l_ac].* =  g_fmak6_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION afmt030_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','5','6',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM fmak_t
       WHERE fmakent = g_enterprise AND
         fmak001 = ps_keys_bak[1] AND fmak011 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmak_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'5'" THEN 
         CALL g_fmak5_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'6'" THEN 
         CALL g_fmak6_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM fmal_t
       WHERE fmalent = g_enterprise AND
             fmal001 = ps_keys_bak[1] AND fmal008 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmak2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM fmam_t
       WHERE fmament = g_enterprise AND
             fmam001 = ps_keys_bak[1] AND fmam002 = ps_keys_bak[2] AND fmam003 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_fmak3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM fman_t
       WHERE fmanent = g_enterprise AND
             fman001 = ps_keys_bak[1] AND fman002 = ps_keys_bak[2] AND fman009 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_fmak4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION afmt030_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','5','6',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO fmak_t
                  (fmakent,
                   fmak001,
                   fmak011
                   ,fmak002,fmak003,fmak004,fmak005,fmak006,fmak007,fmak008,fmak009,fmak010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmak_d[g_detail_idx].fmak002,g_fmak_d[g_detail_idx].fmak003,g_fmak_d[g_detail_idx].fmak004, 
                       g_fmak_d[g_detail_idx].fmak005,g_fmak_d[g_detail_idx].fmak006,g_fmak_d[g_detail_idx].fmak007, 
                       g_fmak_d[g_detail_idx].fmak008,g_fmak_d[g_detail_idx].fmak009,g_fmak_d[g_detail_idx].fmak010) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_fmak_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'5'" THEN 
         CALL g_fmak5_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'6'" THEN 
         CALL g_fmak6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO fmal_t
                  (fmalent,
                   fmal001,
                   fmal008
                   ,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_fmak2_d[g_detail_idx].fmal002,g_fmak2_d[g_detail_idx].fmal003,g_fmak2_d[g_detail_idx].fmal004, 
                       g_fmak2_d[g_detail_idx].fmal005,g_fmak2_d[g_detail_idx].fmal006,g_fmak2_d[g_detail_idx].fmal007) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_fmak2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO fmam_t
                  (fmament,
                   fmam001,
                   fmam002,fmam003
                   ,fmam006,fmam004,fmam005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmak3_d[g_detail_idx].fmam006,g_fmak3_d[g_detail_idx].fmam004,g_fmak3_d[g_detail_idx].fmam005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_fmak3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      IF cl_null(ps_keys[3]) THEN LET ps_keys[3]=" " END IF 
      #end add-point 
      INSERT INTO fman_t
                  (fmanent,
                   fman001,
                   fman002,fman009
                   ,fman010,fman003,fman004,fman005,fman006,fman007,fman008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_fmak4_d[g_detail_idx].fman010,g_fmak4_d[g_detail_idx].fman003,g_fmak4_d[g_detail_idx].fman004, 
                       g_fmak4_d[g_detail_idx].fman005,g_fmak4_d[g_detail_idx].fman006,g_fmak4_d[g_detail_idx].fman007, 
                       g_fmak4_d[g_detail_idx].fman008)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_fmak4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION afmt030_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','5','6',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmak_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL afmt030_fmak_t_mask_restore('restore_mask_o')
               
      UPDATE fmak_t 
         SET (fmak001,
              fmak011
              ,fmak002,fmak003,fmak004,fmak005,fmak006,fmak007,fmak008,fmak009,fmak010) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmak_d[g_detail_idx].fmak002,g_fmak_d[g_detail_idx].fmak003,g_fmak_d[g_detail_idx].fmak004, 
                  g_fmak_d[g_detail_idx].fmak005,g_fmak_d[g_detail_idx].fmak006,g_fmak_d[g_detail_idx].fmak007, 
                  g_fmak_d[g_detail_idx].fmak008,g_fmak_d[g_detail_idx].fmak009,g_fmak_d[g_detail_idx].fmak010)  
 
         WHERE fmakent = g_enterprise AND fmak001 = ps_keys_bak[1] AND fmak011 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmak_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmak_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt030_fmak_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmal_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt030_fmal_t_mask_restore('restore_mask_o')
               
      UPDATE fmal_t 
         SET (fmal001,
              fmal008
              ,fmal002,fmal003,fmal004,fmal005,fmal006,fmal007) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_fmak2_d[g_detail_idx].fmal002,g_fmak2_d[g_detail_idx].fmal003,g_fmak2_d[g_detail_idx].fmal004, 
                  g_fmak2_d[g_detail_idx].fmal005,g_fmak2_d[g_detail_idx].fmal006,g_fmak2_d[g_detail_idx].fmal007)  
 
         WHERE fmalent = g_enterprise AND fmal001 = ps_keys_bak[1] AND fmal008 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmal_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmal_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt030_fmal_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fmam_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt030_fmam_t_mask_restore('restore_mask_o')
               
      UPDATE fmam_t 
         SET (fmam001,
              fmam002,fmam003
              ,fmam006,fmam004,fmam005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmak3_d[g_detail_idx].fmam006,g_fmak3_d[g_detail_idx].fmam004,g_fmak3_d[g_detail_idx].fmam005)  
 
         WHERE fmament = g_enterprise AND fmam001 = ps_keys_bak[1] AND fmam002 = ps_keys_bak[2] AND fmam003 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmam_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fmam_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt030_fmam_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "fman_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL afmt030_fman_t_mask_restore('restore_mask_o')
               
      UPDATE fman_t 
         SET (fman001,
              fman002,fman009
              ,fman010,fman003,fman004,fman005,fman006,fman007,fman008) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_fmak4_d[g_detail_idx].fman010,g_fmak4_d[g_detail_idx].fman003,g_fmak4_d[g_detail_idx].fman004, 
                  g_fmak4_d[g_detail_idx].fman005,g_fmak4_d[g_detail_idx].fman006,g_fmak4_d[g_detail_idx].fman007, 
                  g_fmak4_d[g_detail_idx].fman008) 
         WHERE fmanent = g_enterprise AND fman001 = ps_keys_bak[1] AND fman002 = ps_keys_bak[2] AND fman009 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fman_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "fman_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL afmt030_fman_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION afmt030_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt030.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION afmt030_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="afmt030.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION afmt030_lock_b(ps_table,ps_page)
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
   #CALL afmt030_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','5','6',"
   #僅鎖定自身table
   LET ls_group = "fmak_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN afmt030_bcl USING g_enterprise,
                                       g_fmaj_m.fmaj001,g_fmak_d[g_detail_idx].fmak011     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt030_bcl:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "fmal_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt030_bcl2 USING g_enterprise,
                                             g_fmaj_m.fmaj001,g_fmak2_d[g_detail_idx].fmal008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt030_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "fmam_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt030_bcl3 USING g_enterprise,
                                             g_fmaj_m.fmaj001,g_fmak3_d[g_detail_idx].fmam002,g_fmak3_d[g_detail_idx].fmam003 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt030_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "fman_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN afmt030_bcl4 USING g_enterprise,
                                             g_fmaj_m.fmaj001,g_fmak4_d[g_detail_idx].fman002,g_fmak4_d[g_detail_idx].fman009 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "afmt030_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION afmt030_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','5','6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt030_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt030_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt030_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE afmt030_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION afmt030_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("fmaj001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION afmt030_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("fmaj001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
   IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
   END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION afmt030_set_entry_b(p_cmd)
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
      IF g_fmaj_m.fmaj012='Y' THEN 
         CALL cl_set_comp_entry("fmam002,fmam003,fmam004,fmam005",FALSE)
      ELSE 
         CALL cl_set_comp_entry("fmam002,fmam003,fmam004,fmam005",TRUE)
      END IF 
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION afmt030_set_no_entry_b(p_cmd)
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
      IF g_fmaj_m.fmaj012='Y' THEN 
         CALL cl_set_comp_entry("s_detail4",FALSE)
      ELSE 
         CALL cl_set_comp_entry("fmam002,fmam003,fmam004,fmam005",TRUE)
      END IF 
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION afmt030_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION afmt030_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_fmaj_m.fmajstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION afmt030_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION afmt030_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION afmt030_default_search()
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
      LET ls_wc = ls_wc, " fmaj001 = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table3 TO NULL
 
         INITIALIZE g_wc2_table4 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "fmaj_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmak_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "fmal_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "fmam_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "fman_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
            END IF
 
            IF g_wc2_table3 <> " 1=1" AND NOT cl_null(g_wc2_table3) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
            END IF
 
            IF g_wc2_table4 <> " 1=1" AND NOT cl_null(g_wc2_table4) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
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
 
{<section id="afmt030.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION afmt030_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_fmaj_m.fmaj001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN afmt030_cl USING g_enterprise,g_fmaj_m.fmaj001
   IF STATUS THEN
      CLOSE afmt030_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN afmt030_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj005, 
       g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid, 
       g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid, 
       g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015, 
       g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc, 
       g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc, 
       g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT afmt030_action_chk() THEN
      CLOSE afmt030_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
       g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006,g_fmaj_m.fmaj009, 
       g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr,g_fmaj_m.lbl_gsfr_desc,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010, 
       g_fmaj_m.fmajstus,g_fmaj_m.fmajownid,g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp,g_fmaj_m.fmajowndp_desc, 
       g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajcrtdt, 
       g_fmaj_m.fmajmodid,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfid_desc, 
       g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017, 
       g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
 
   CASE g_fmaj_m.fmajstus
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_fmaj_m.fmajstus
            
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT afmt030_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt030_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT afmt030_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE afmt030_cl
            RETURN
         END IF
 
 
 
	  
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
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
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
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "A" 
      AND lc_state <> "D"
      AND lc_state <> "N"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_fmaj_m.fmajstus = lc_state OR cl_null(lc_state) THEN
      CLOSE afmt030_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#2 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#2 --- add end   ---
   #end add-point
   
   LET g_fmaj_m.fmajmodid = g_user
   LET g_fmaj_m.fmajmoddt = cl_get_current()
   LET g_fmaj_m.fmajstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE fmaj_t 
      SET (fmajstus,fmajmodid,fmajmoddt) 
        = (g_fmaj_m.fmajstus,g_fmaj_m.fmajmodid,g_fmaj_m.fmajmoddt)     
    WHERE fmajent = g_enterprise AND fmaj001 = g_fmaj_m.fmaj001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE afmt030_master_referesh USING g_fmaj_m.fmaj001 INTO g_fmaj_m.fmaj001,g_fmaj_m.fmaj003, 
          g_fmaj_m.fmaj005,g_fmaj_m.fmaj008,g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006, 
          g_fmaj_m.fmaj009,g_fmaj_m.fmaj012,g_fmaj_m.fmaj020,g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus, 
          g_fmaj_m.fmajownid,g_fmaj_m.fmajowndp,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtdp,g_fmaj_m.fmajcrtdt, 
          g_fmaj_m.fmajmodid,g_fmaj_m.fmajmoddt,g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013, 
          g_fmaj_m.fmaj014,g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019, 
          g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmajownid_desc,g_fmaj_m.fmajowndp_desc, 
          g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_fmaj_m.fmaj001,g_fmaj_m.fmaj003,g_fmaj_m.fmaj003_desc,g_fmaj_m.fmaj005,g_fmaj_m.fmaj008, 
          g_fmaj_m.fmaj011,g_fmaj_m.fmaj002,g_fmaj_m.fmaj002_desc,g_fmaj_m.fmaj004,g_fmaj_m.fmaj006, 
          g_fmaj_m.fmaj009,g_fmaj_m.fmaj012,g_fmaj_m.lbl_gsfr,g_fmaj_m.lbl_gsfr_desc,g_fmaj_m.fmaj020, 
          g_fmaj_m.fmaj007,g_fmaj_m.fmaj010,g_fmaj_m.fmajstus,g_fmaj_m.fmajownid,g_fmaj_m.fmajownid_desc, 
          g_fmaj_m.fmajowndp,g_fmaj_m.fmajowndp_desc,g_fmaj_m.fmajcrtid,g_fmaj_m.fmajcrtid_desc,g_fmaj_m.fmajcrtdp, 
          g_fmaj_m.fmajcrtdp_desc,g_fmaj_m.fmajcrtdt,g_fmaj_m.fmajmodid,g_fmaj_m.fmajmodid_desc,g_fmaj_m.fmajmoddt, 
          g_fmaj_m.fmajcnfid,g_fmaj_m.fmajcnfid_desc,g_fmaj_m.fmajcnfdt,g_fmaj_m.fmaj013,g_fmaj_m.fmaj014, 
          g_fmaj_m.fmaj015,g_fmaj_m.fmaj016,g_fmaj_m.fmaj017,g_fmaj_m.fmaj018,g_fmaj_m.fmaj019
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE afmt030_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL afmt030_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt030.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION afmt030_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_fmak_d.getLength() THEN
         LET g_detail_idx = g_fmak_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_fmak2_d.getLength() THEN
         LET g_detail_idx = g_fmak2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_fmak3_d.getLength() THEN
         LET g_detail_idx = g_fmak3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_fmak4_d.getLength() THEN
         LET g_detail_idx = g_fmak4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_fmak5_d.getLength() THEN
         LET g_detail_idx = g_fmak5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_fmak6_d.getLength() THEN
         LET g_detail_idx = g_fmak6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_fmak6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_fmak6_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmt030_b_fill2(pi_idx)
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
   
   CALL afmt030_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION afmt030_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  AND 
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   IF ps_idx=5 THEN 
      RETURN TRUE
   END IF  
   IF ps_idx=6 THEN 
      RETURN TRUE
   END IF       
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="afmt030.status_show" >}
PRIVATE FUNCTION afmt030_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="afmt030.mask_functions" >}
&include "erp/afm/afmt030_mask.4gl"
 
{</section>}
 
{<section id="afmt030.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION afmt030_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL afmt030_show()
   CALL afmt030_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_fmaj_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_fmak_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_fmak2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_fmak3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_fmak4_d))
   CALL cl_bpm_set_detail_data("s_detail5", util.JSONArray.fromFGL(g_fmak5_d))
   CALL cl_bpm_set_detail_data("s_detail6", util.JSONArray.fromFGL(g_fmak6_d))
 
 
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
   #CALL afmt030_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL afmt030_ui_headershow()
   CALL afmt030_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION afmt030_draw_out()
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
   CALL afmt030_ui_headershow()  
   CALL afmt030_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="afmt030.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION afmt030_set_pk_array()
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
   LET g_pk_array[1].values = g_fmaj_m.fmaj001
   LET g_pk_array[1].column = 'fmaj001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt030.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="afmt030.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION afmt030_msgcentre_notify(lc_state)
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
   CALL afmt030_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_fmaj_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="afmt030.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION afmt030_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="afmt030.other_function" readonly="Y" >}
#审核单据
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
PUBLIC FUNCTION afmt030_verify()
IF g_fmaj_m.fmajstus<>'Y'THEN 
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = "" 
   LET g_errparam.code   = "afm-00029" 
   LET g_errparam.popup  = FALSE 
   CALL cl_err()   
   RETURN
ELSE 
      
   UPDATE fmap_t SET fmap015 = '2' 
    WHERE fmapent = g_enterprise AND fmap001 = g_fmaj_m.fmaj001 AND fmap002=g_fmaj_m.fmaj019
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   END IF 
END IF  



END FUNCTION

 
{</section>}
 
