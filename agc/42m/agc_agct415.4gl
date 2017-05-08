#該程式未解開Section, 採用最新樣板產出!
{<section id="agct415.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-08-31 14:15:16), PR版次:0007(2016-10-24 17:43:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: agct415
#+ Description: 券付款規則申請維護作業
#+ Creator....: 06137(2016-05-20 14:42:00)
#+ Modifier...: 08172 -SD/PR- 06814
 
{</section>}
 
{<section id="agct415.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
# Modify......: NO.160816-00068#11   2016/08/17   By 08209    調整transaction
#  Modifier...: NO.160818-00017#14   2016/08/25  by 08172    修改删除时重新检查状态
#  Modifier...: NO.160831-00020#1    2016/08/31  by 08172    agct415审核后没有提示发布，资料也没有做发布,对象编号不自动转换为大写
#  Modifier...: NO.160905-00007#3    2016/09/02  By zhujing  调整系统中无ENT的SQL条件增加ent
#  Modifier...: NO.160824-00007#103  2016/10/24  By 06814    新舊值相關調整
#161024-00025#1   2016/10/24 By dongsz   mmbs004增加aooi500逻辑管控
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

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
PRIVATE type type_g_mmbo_m        RECORD
       mmbosite LIKE mmbo_t.mmbosite, 
   mmbosite_desc LIKE type_t.chr80, 
   mmbodocdt LIKE mmbo_t.mmbodocdt, 
   mmbodocno LIKE mmbo_t.mmbodocno, 
   mmbo000 LIKE mmbo_t.mmbo000, 
   mmbo004 LIKE mmbo_t.mmbo004, 
   mmbo006 LIKE mmbo_t.mmbo006, 
   mmbo001 LIKE mmbo_t.mmbo001, 
   mmbo002 LIKE mmbo_t.mmbo002, 
   mmbol002 LIKE mmbol_t.mmbol002, 
   mmbol003 LIKE mmbol_t.mmbol003, 
   mmbo005 LIKE mmbo_t.mmbo005, 
   mmbo005_desc LIKE type_t.chr80, 
   mmbo007 LIKE mmbo_t.mmbo007, 
   mmbo008 LIKE mmbo_t.mmbo008, 
   mmbo014 LIKE mmbo_t.mmbo014, 
   mmbo015 LIKE mmbo_t.mmbo015, 
   mmbounit LIKE mmbo_t.mmbounit, 
   mmbounit_desc LIKE type_t.chr80, 
   mmbo016 LIKE mmbo_t.mmbo016, 
   mmboacti LIKE mmbo_t.mmboacti, 
   mmbostus LIKE mmbo_t.mmbostus, 
   mmboownid LIKE mmbo_t.mmboownid, 
   mmboownid_desc LIKE type_t.chr80, 
   mmboowndp LIKE mmbo_t.mmboowndp, 
   mmboowndp_desc LIKE type_t.chr80, 
   mmbocrtid LIKE mmbo_t.mmbocrtid, 
   mmbocrtid_desc LIKE type_t.chr80, 
   mmbocrtdp LIKE mmbo_t.mmbocrtdp, 
   mmbocrtdp_desc LIKE type_t.chr80, 
   mmbocrtdt LIKE mmbo_t.mmbocrtdt, 
   mmbomodid LIKE mmbo_t.mmbomodid, 
   mmbomodid_desc LIKE type_t.chr80, 
   mmbomoddt LIKE mmbo_t.mmbomoddt, 
   mmbocnfid LIKE mmbo_t.mmbocnfid, 
   mmbocnfid_desc LIKE type_t.chr80, 
   mmbocnfdt LIKE mmbo_t.mmbocnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmdd_d        RECORD
       mmddsite LIKE mmdd_t.mmddsite, 
   mmddunit LIKE mmdd_t.mmddunit, 
   mmdd001 LIKE mmdd_t.mmdd001, 
   mmdd002 LIKE mmdd_t.mmdd002, 
   mmdd003 LIKE mmdd_t.mmdd003, 
   mmdd004 LIKE mmdd_t.mmdd004, 
   mmdd004_desc LIKE type_t.chr500, 
   mmddacti LIKE mmdd_t.mmddacti
       END RECORD
PRIVATE TYPE type_g_mmdd2_d RECORD
       mmbssite LIKE mmbs_t.mmbssite, 
   mmbsunit LIKE mmbs_t.mmbsunit, 
   mmbs001 LIKE mmbs_t.mmbs001, 
   mmbs002 LIKE mmbs_t.mmbs002, 
   mmbs003 LIKE mmbs_t.mmbs003, 
   mmbs004 LIKE mmbs_t.mmbs004, 
   mmbs004_desc LIKE type_t.chr500, 
   mmbs005 LIKE mmbs_t.mmbs005, 
   mmbsacti LIKE mmbs_t.mmbsacti
       END RECORD
PRIVATE TYPE type_g_mmdd3_d RECORD
       mmcksite LIKE mmck_t.mmcksite, 
   mmckunit LIKE mmck_t.mmckunit, 
   mmck001 LIKE mmck_t.mmck001, 
   mmck002 LIKE mmck_t.mmck002, 
   mmck003 LIKE mmck_t.mmck003, 
   mmck004 LIKE mmck_t.mmck004, 
   mmck005 LIKE mmck_t.mmck005, 
   mmck006 LIKE mmck_t.mmck006, 
   mmck007 LIKE mmck_t.mmck007, 
   mmck008 LIKE mmck_t.mmck008, 
   mmck009 LIKE mmck_t.mmck009, 
   mmckacti LIKE mmck_t.mmckacti
       END RECORD
PRIVATE TYPE type_g_mmdd4_d RECORD
       mmdgunit LIKE type_t.chr10, 
   mmdgsite LIKE type_t.chr10, 
   mmdg001 LIKE type_t.chr30, 
   mmdg002 LIKE type_t.chr10, 
   mmdg003 LIKE type_t.num10, 
   mmdg004 LIKE type_t.num20_6, 
   mmdg005 LIKE type_t.num20_6, 
   mmdg006 LIKE type_t.num20_6, 
   mmdg007 LIKE type_t.num20_6, 
   mmdgacti LIKE type_t.chr1
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_mmbosite LIKE mmbo_t.mmbosite,
   b_mmbosite_desc LIKE type_t.chr80,
      b_mmbodocdt LIKE mmbo_t.mmbodocdt,
      b_mmbodocno LIKE mmbo_t.mmbodocno,
      b_mmbo000 LIKE mmbo_t.mmbo000,
      b_mmbo004 LIKE mmbo_t.mmbo004,
      b_mmbo006 LIKE mmbo_t.mmbo006,
      b_mmbo001 LIKE mmbo_t.mmbo001,
      b_mmbo002 LIKE mmbo_t.mmbo002,
      b_mmbo005 LIKE mmbo_t.mmbo005,
   b_mmbo005_desc LIKE type_t.chr80,
      b_mmbo007 LIKE mmbo_t.mmbo007,
      b_mmbo008 LIKE mmbo_t.mmbo008,
      b_mmbo014 LIKE mmbo_t.mmbo014,
      b_mmbo015 LIKE mmbo_t.mmbo015,
      b_mmboacti LIKE mmbo_t.mmboacti
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_mmbo_m          type_g_mmbo_m
DEFINE g_mmbo_m_t        type_g_mmbo_m
DEFINE g_mmbo_m_o        type_g_mmbo_m
DEFINE g_mmbo_m_mask_o   type_g_mmbo_m #轉換遮罩前資料
DEFINE g_mmbo_m_mask_n   type_g_mmbo_m #轉換遮罩後資料
 
   DEFINE g_mmbodocno_t LIKE mmbo_t.mmbodocno
 
 
DEFINE g_mmdd_d          DYNAMIC ARRAY OF type_g_mmdd_d
DEFINE g_mmdd_d_t        type_g_mmdd_d
DEFINE g_mmdd_d_o        type_g_mmdd_d
DEFINE g_mmdd_d_mask_o   DYNAMIC ARRAY OF type_g_mmdd_d #轉換遮罩前資料
DEFINE g_mmdd_d_mask_n   DYNAMIC ARRAY OF type_g_mmdd_d #轉換遮罩後資料
DEFINE g_mmdd2_d          DYNAMIC ARRAY OF type_g_mmdd2_d
DEFINE g_mmdd2_d_t        type_g_mmdd2_d
DEFINE g_mmdd2_d_o        type_g_mmdd2_d
DEFINE g_mmdd2_d_mask_o   DYNAMIC ARRAY OF type_g_mmdd2_d #轉換遮罩前資料
DEFINE g_mmdd2_d_mask_n   DYNAMIC ARRAY OF type_g_mmdd2_d #轉換遮罩後資料
DEFINE g_mmdd3_d          DYNAMIC ARRAY OF type_g_mmdd3_d
DEFINE g_mmdd3_d_t        type_g_mmdd3_d
DEFINE g_mmdd3_d_o        type_g_mmdd3_d
DEFINE g_mmdd3_d_mask_o   DYNAMIC ARRAY OF type_g_mmdd3_d #轉換遮罩前資料
DEFINE g_mmdd3_d_mask_n   DYNAMIC ARRAY OF type_g_mmdd3_d #轉換遮罩後資料
DEFINE g_mmdd4_d          DYNAMIC ARRAY OF type_g_mmdd4_d
DEFINE g_mmdd4_d_t        type_g_mmdd4_d
DEFINE g_mmdd4_d_o        type_g_mmdd4_d
DEFINE g_mmdd4_d_mask_o   DYNAMIC ARRAY OF type_g_mmdd4_d #轉換遮罩前資料
DEFINE g_mmdd4_d_mask_n   DYNAMIC ARRAY OF type_g_mmdd4_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
DEFINE g_master_multi_table_t    RECORD
      mmboldocno LIKE mmbol_t.mmboldocno,
      mmbol002 LIKE mmbol_t.mmbol002,
      mmbol003 LIKE mmbol_t.mmbol003
      END RECORD
 
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
DEFINE g_site_flag   LIKE type_t.num5 #sakura add
#end add-point
 
{</section>}
 
{<section id="agct415.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agc","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT mmbosite,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002, 
       '','',mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmbounit,'',mmbo016,mmboacti,mmbostus,mmboownid, 
       '',mmboowndp,'',mmbocrtid,'',mmbocrtdp,'',mmbocrtdt,mmbomodid,'',mmbomoddt,mmbocnfid,'',mmbocnfdt", 
        
                      " FROM mmbo_t",
                      " WHERE mmboent= ? AND mmbodocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct415_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.mmbosite,t0.mmbodocdt,t0.mmbodocno,t0.mmbo000,t0.mmbo004,t0.mmbo006, 
       t0.mmbo001,t0.mmbo002,t0.mmbo005,t0.mmbo007,t0.mmbo008,t0.mmbo014,t0.mmbo015,t0.mmbounit,t0.mmbo016, 
       t0.mmboacti,t0.mmbostus,t0.mmboownid,t0.mmboowndp,t0.mmbocrtid,t0.mmbocrtdp,t0.mmbocrtdt,t0.mmbomodid, 
       t0.mmbomoddt,t0.mmbocnfid,t0.mmbocnfdt,t1.ooefl003 ,t2.gcafl003 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 , 
       t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooag011",
               " FROM mmbo_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gcafl_t t2 ON t2.gcaflent="||g_enterprise||" AND t2.gcafl001=t0.mmbo005 AND t2.gcafl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.mmbounit AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.mmboownid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.mmboowndp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.mmbocrtid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.mmbocrtdp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.mmbomodid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.mmbocnfid  ",
 
               " WHERE t0.mmboent = " ||g_enterprise|| " AND t0.mmbodocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agct415_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agct415 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agct415_init()   
 
      #進入選單 Menu (="N")
      CALL agct415_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi390_drop_tmp_table()   #160627-00005#1 160627 by sakura add
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agct415
      
   END IF 
   
   CLOSE agct415_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agct415.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agct415_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('mmbostus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('mmbo000','32') 
   CALL cl_set_combo_scc('mmbo004','6516') 
   CALL cl_set_combo_scc('mmbo007','6517') 
   CALL cl_set_combo_scc('mmbo008','6517') 
   CALL cl_set_combo_scc('mmck008','6520') 
   CALL cl_set_combo_scc('mmck009','30') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_mmbo000','32')
   CALL cl_set_combo_scc_part('b_mmbo004','6516','8')
   CALL cl_set_combo_scc_part('mmbo004','6516','8') 
   CALL cl_set_combo_scc_part('mmbo007','6517','0,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L') 
   CALL cl_set_combo_scc_part('mmbo008','6517','0,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,10') 
   CALL cl_set_combo_scc_part('b_mmbo007','6517','0,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L') 
   CALL cl_set_combo_scc_part('b_mmbo008','6517','0,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,10')
   #CALL agct415_set_combo()
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #160627-00005#1 160627 by sakura add
   #end add-point
   
   #初始化搜尋條件
   CALL agct415_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="agct415.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION agct415_ui_dialog()
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
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL agct415_insert()
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
         INITIALIZE g_mmbo_m.* TO NULL
         CALL g_mmdd_d.clear()
         CALL g_mmdd2_d.clear()
         CALL g_mmdd3_d.clear()
         CALL g_mmdd4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL agct415_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
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
               
               CALL agct415_fetch('') # reload data
               LET l_ac = 1
               CALL agct415_ui_detailshow() #Setting the current row 
         
               CALL agct415_idx_chk()
               #NEXT FIELD mmdd001
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_mmdd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct415_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL agct415_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_mmdd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct415_idx_chk()
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
               CALL agct415_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmdd3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct415_idx_chk()
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
               CALL agct415_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_mmdd4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL agct415_idx_chk()
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
               CALL agct415_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL agct415_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL agct415_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL agct415_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL agct415_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL agct415_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL agct415_set_act_visible()   
            CALL agct415_set_act_no_visible()
            IF NOT (g_mmbo_m.mmbodocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " mmboent = " ||g_enterprise|| " AND",
                                  " mmbodocno = '", g_mmbo_m.mmbodocno, "' "
 
               #填到對應位置
               CALL agct415_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "mmbo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmdd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbs_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmck_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmdg_t" 
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
               CALL agct415_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
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
                     WHEN la_wc[li_idx].tableid = "mmbo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmdd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "mmbs_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmck_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "mmdg_t" 
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
                  CALL agct415_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL agct415_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL agct415_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL agct415_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct415_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL agct415_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct415_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL agct415_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct415_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL agct415_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct415_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL agct415_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL agct415_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmdd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmdd2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mmdd3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_mmdd4_d)
                  LET g_export_id[4]   = "s_detail4"
 
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
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
               NEXT FIELD mmdd001
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
               CALL agct415_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#14 -s by 08172
               CALL agct415_set_act_visible()   
               CALL agct415_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL agct415_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#14 -s by 08172
               CALL agct415_set_act_visible()   
               CALL agct415_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
               CALL s_excel_templet_download()  #add by guomy 2015/12/31 下载模板
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL agct415_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#14 -s by 08172
               CALL agct415_set_act_visible()   
               CALL agct415_set_act_no_visible()
               #160818-00017#14 -e by 08172
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL agct415_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/agc/agct415_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/agc/agct415_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION importfromexcel
            LET g_action_choice="importfromexcel"
            IF cl_auth_chk_act("importfromexcel") THEN
               
               #add-point:ON ACTION importfromexcel name="menu.importfromexcel"
               CALL s_ammt357_excel(g_mmbo_m.mmbodocno) #add by guomy 2015/1/1 增加EXCEL导入功能
               CALL agct415_b_fill()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL agct415_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload()  #add by guomy 2015/12/31 增加上传模板
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION remark
            LET g_action_choice="remark"
            IF cl_auth_chk_act("remark") THEN
               
               #add-point:ON ACTION remark name="menu.remark"
                              CALL aooi360_01('6',g_mmbo_m.mmbodocno,'','','','','','','','','')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION exclude
            LET g_action_choice="exclude"
            IF cl_auth_chk_act("exclude") THEN
               
               #add-point:ON ACTION exclude name="menu.exclude"
               IF g_mmbo_m.mmbo008 <> '0' AND g_mmbo_m.mmbo008 <> '10' THEN
                  CALL ammt350_01(g_mmbo_m.mmbodocno,g_mmbo_m.mmbo001,g_mmbo_m.mmbo005,g_mmbo_m.mmbo008,g_mmbo_m.mmbosite,g_mmbo_m.mmbounit)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL agct415_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL agct415_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL agct415_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_mmbo_m.mmbodocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="agct415.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION agct415_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING #sakura add   
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
   CALL s_aooi500_sql_where(g_prog,'mmbosite') RETURNING l_where #sakura add   
   LET l_wc = l_wc CLIPPED," AND mmbo004 = '8' "," AND ",l_where #sakura add l_where
   LET g_wc = g_wc CLIPPED," AND mmbo004 = '8' "," AND ",l_where #sakura add l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT mmbodocno ",
                      " FROM mmbo_t ",
                      " ",
                      " LEFT JOIN mmdd_t ON mmddent = mmboent AND mmbodocno = mmdddocno ", "  ",
                      #add-point:browser_fill段sql(mmdd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno", "  ",
                      #add-point:browser_fill段sql(mmbs_t1) name="browser_fill.cnt.join.mmbs_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mmck_t ON mmckent = mmboent AND mmbodocno = mmckdocno", "  ",
                      #add-point:browser_fill段sql(mmck_t1) name="browser_fill.cnt.join.mmck_t1"
                      
                      #end add-point
 
                      " LEFT JOIN mmdg_t ON mmdgent = mmboent AND mmbodocno = mmdgdocno", "  ",
                      #add-point:browser_fill段sql(mmdg_t1) name="browser_fill.cnt.join.mmdg_t1"
                      
                      #end add-point
 
 
 
                      " LEFT JOIN mmbol_t ON mmbolent = "||g_enterprise||" AND mmbodocno = mmboldocno AND mmbol001 = '",g_dlang,"' ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE mmboent = " ||g_enterprise|| " AND mmddent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmbo_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT mmbodocno ",
                      " FROM mmbo_t ", 
                      "  ",
                      "  LEFT JOIN mmbol_t ON mmbolent = "||g_enterprise||" AND mmbodocno = mmboldocno AND mmbol001 = '",g_dlang,"' ",
                      " WHERE mmboent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("mmbo_t")
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
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
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
      INITIALIZE g_mmbo_m.* TO NULL
      CALL g_mmdd_d.clear()        
      CALL g_mmdd2_d.clear() 
      CALL g_mmdd3_d.clear() 
      CALL g_mmdd4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.mmbosite,t0.mmbodocdt,t0.mmbodocno,t0.mmbo000,t0.mmbo004,t0.mmbo006,t0.mmbo001,t0.mmbo002,t0.mmbo005,t0.mmbo007,t0.mmbo008,t0.mmbo014,t0.mmbo015,t0.mmboacti Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbostus,t0.mmbosite,t0.mmbodocdt,t0.mmbodocno,t0.mmbo000,t0.mmbo004, 
          t0.mmbo006,t0.mmbo001,t0.mmbo002,t0.mmbo005,t0.mmbo007,t0.mmbo008,t0.mmbo014,t0.mmbo015,t0.mmboacti, 
          t1.ooefl003 ,t2.gcafl003 ",
                  " FROM mmbo_t t0",
                  "  ",
                  "  LEFT JOIN mmdd_t ON mmddent = mmboent AND mmbodocno = mmdddocno ", "  ", 
                  #add-point:browser_fill段sql(mmdd_t1) name="browser_fill.join.mmdd_t1"
                  
                  #end add-point
                  "  LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno", "  ", 
                  #add-point:browser_fill段sql(mmbs_t1) name="browser_fill.join.mmbs_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mmck_t ON mmckent = mmboent AND mmbodocno = mmckdocno", "  ", 
                  #add-point:browser_fill段sql(mmck_t1) name="browser_fill.join.mmck_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN mmdg_t ON mmdgent = mmboent AND mmbodocno = mmdgdocno", "  ", 
                  #add-point:browser_fill段sql(mmdg_t1) name="browser_fill.join.mmdg_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gcafl_t t2 ON t2.gcaflent="||g_enterprise||" AND t2.gcafl001=t0.mmbo005 AND t2.gcafl002='"||g_dlang||"' ",
 
               " LEFT JOIN mmbol_t ON mmbolent = "||g_enterprise||" AND mmbodocno = mmboldocno AND mmbol001 = '",g_dlang,"' ",
                  " WHERE t0.mmboent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("mmbo_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.mmbostus,t0.mmbosite,t0.mmbodocdt,t0.mmbodocno,t0.mmbo000,t0.mmbo004, 
          t0.mmbo006,t0.mmbo001,t0.mmbo002,t0.mmbo005,t0.mmbo007,t0.mmbo008,t0.mmbo014,t0.mmbo015,t0.mmboacti, 
          t1.ooefl003 ,t2.gcafl003 ",
                  " FROM mmbo_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.mmbosite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN gcafl_t t2 ON t2.gcaflent="||g_enterprise||" AND t2.gcafl001=t0.mmbo005 AND t2.gcafl002='"||g_dlang||"' ",
 
               " LEFT JOIN mmbol_t ON mmbolent = "||g_enterprise||" AND mmbodocno = mmboldocno AND mmbol001 = '",g_dlang,"' ",
                  " WHERE t0.mmboent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("mmbo_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY mmbodocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"mmbo_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
   
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbosite,g_browser[g_cnt].b_mmbodocdt, 
          g_browser[g_cnt].b_mmbodocno,g_browser[g_cnt].b_mmbo000,g_browser[g_cnt].b_mmbo004,g_browser[g_cnt].b_mmbo006, 
          g_browser[g_cnt].b_mmbo001,g_browser[g_cnt].b_mmbo002,g_browser[g_cnt].b_mmbo005,g_browser[g_cnt].b_mmbo007, 
          g_browser[g_cnt].b_mmbo008,g_browser[g_cnt].b_mmbo014,g_browser[g_cnt].b_mmbo015,g_browser[g_cnt].b_mmboacti, 
          g_browser[g_cnt].b_mmbosite_desc,g_browser[g_cnt].b_mmbo005_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      
         #end add-point
      
         #遮罩相關處理
         CALL agct415_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "A"
            LET g_browser[g_cnt].b_statepic = "stus/16/approved.png"
         WHEN "D"
            LET g_browser[g_cnt].b_statepic = "stus/16/withdraw.png"
         WHEN "R"
            LET g_browser[g_cnt].b_statepic = "stus/16/rejection.png"
         WHEN "W"
            LET g_browser[g_cnt].b_statepic = "stus/16/signing.png"
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
   
   IF cl_null(g_browser[g_cnt].b_mmbodocno) THEN
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
 
{<section id="agct415.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION agct415_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_mmbo_m.mmbodocno = g_browser[g_current_idx].b_mmbodocno   
 
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
   CALL agct415_mmbo_t_mask()
   CALL agct415_show()
      
END FUNCTION
 
{</section>}
 
{<section id="agct415.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION agct415_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION agct415_ui_browser_refresh()
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
      IF g_browser[l_i].b_mmbodocno = g_mmbo_m.mmbodocno 
 
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
 
{<section id="agct415.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION agct415_construct()
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
   INITIALIZE g_mmbo_m.* TO NULL
   CALL g_mmdd_d.clear()        
   CALL g_mmdd2_d.clear() 
   CALL g_mmdd3_d.clear() 
   CALL g_mmdd4_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON mmbosite,mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002, 
          mmbol002,mmbol003,mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmbounit,mmbo016,mmboacti,mmbostus, 
          mmboownid,mmboowndp,mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                        DISPLAY '8' TO mmbo004
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<mmbocrtdt>>----
         AFTER FIELD mmbocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<mmbomoddt>>----
         AFTER FIELD mmbomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbocnfdt>>----
         AFTER FIELD mmbocnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<mmbopstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.mmbosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbosite
            #add-point:ON ACTION controlp INFIELD mmbosite name="construct.c.mmbosite"
            #sakura---add---str
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbosite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbosite  #顯示到畫面上
            NEXT FIELD mmbosite                     #返回原欄位            
            #sakura---add---end            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbosite
            #add-point:BEFORE FIELD mmbosite name="construct.b.mmbosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbosite
            
            #add-point:AFTER FIELD mmbosite name="construct.a.mmbosite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbodocdt
            #add-point:BEFORE FIELD mmbodocdt name="construct.b.mmbodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbodocdt
            
            #add-point:AFTER FIELD mmbodocdt name="construct.a.mmbodocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbodocdt
            #add-point:ON ACTION controlp INFIELD mmbodocdt name="construct.c.mmbodocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbodocno
            #add-point:ON ACTION controlp INFIELD mmbodocno name="construct.c.mmbodocno"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '7'
            CALL q_mmbodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbodocno  #顯示到畫面上

            NEXT FIELD mmbodocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbodocno
            #add-point:BEFORE FIELD mmbodocno name="construct.b.mmbodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbodocno
            
            #add-point:AFTER FIELD mmbodocno name="construct.a.mmbodocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo000
            #add-point:BEFORE FIELD mmbo000 name="construct.b.mmbo000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo000
            
            #add-point:AFTER FIELD mmbo000 name="construct.a.mmbo000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo000
            #add-point:ON ACTION controlp INFIELD mmbo000 name="construct.c.mmbo000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo004
            #add-point:BEFORE FIELD mmbo004 name="construct.b.mmbo004"
                        DISPLAY '7' TO mmbo004
            NEXT FIELD mmbo006
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo004
            
            #add-point:AFTER FIELD mmbo004 name="construct.a.mmbo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo004
            #add-point:ON ACTION controlp INFIELD mmbo004 name="construct.c.mmbo004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo006
            #add-point:BEFORE FIELD mmbo006 name="construct.b.mmbo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo006
            
            #add-point:AFTER FIELD mmbo006 name="construct.a.mmbo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo006
            #add-point:ON ACTION controlp INFIELD mmbo006 name="construct.c.mmbo006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo001
            #add-point:ON ACTION controlp INFIELD mmbo001 name="construct.c.mmbo001"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '8'
            CALL q_mmbo001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbo001  #顯示到畫面上

            NEXT FIELD mmbo001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo001
            #add-point:BEFORE FIELD mmbo001 name="construct.b.mmbo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo001
            
            #add-point:AFTER FIELD mmbo001 name="construct.a.mmbo001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo002
            #add-point:BEFORE FIELD mmbo002 name="construct.b.mmbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo002
            
            #add-point:AFTER FIELD mmbo002 name="construct.a.mmbo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo002
            #add-point:ON ACTION controlp INFIELD mmbo002 name="construct.c.mmbo002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbol002
            #add-point:BEFORE FIELD mmbol002 name="construct.b.mmbol002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbol002
            
            #add-point:AFTER FIELD mmbol002 name="construct.a.mmbol002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbol002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbol002
            #add-point:ON ACTION controlp INFIELD mmbol002 name="construct.c.mmbol002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbol003
            #add-point:BEFORE FIELD mmbol003 name="construct.b.mmbol003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbol003
            
            #add-point:AFTER FIELD mmbol003 name="construct.a.mmbol003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbol003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbol003
            #add-point:ON ACTION controlp INFIELD mmbol003 name="construct.c.mmbol003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo005
            #add-point:ON ACTION controlp INFIELD mmbo005 name="construct.c.mmbo005"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbo005  #顯示到畫面上

            NEXT FIELD mmbo005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo005
            #add-point:BEFORE FIELD mmbo005 name="construct.b.mmbo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo005
            
            #add-point:AFTER FIELD mmbo005 name="construct.a.mmbo005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo007
            #add-point:BEFORE FIELD mmbo007 name="construct.b.mmbo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo007
            
            #add-point:AFTER FIELD mmbo007 name="construct.a.mmbo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo007
            #add-point:ON ACTION controlp INFIELD mmbo007 name="construct.c.mmbo007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo008
            #add-point:BEFORE FIELD mmbo008 name="construct.b.mmbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo008
            
            #add-point:AFTER FIELD mmbo008 name="construct.a.mmbo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo008
            #add-point:ON ACTION controlp INFIELD mmbo008 name="construct.c.mmbo008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo014
            #add-point:BEFORE FIELD mmbo014 name="construct.b.mmbo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo014
            
            #add-point:AFTER FIELD mmbo014 name="construct.a.mmbo014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo014
            #add-point:ON ACTION controlp INFIELD mmbo014 name="construct.c.mmbo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo015
            #add-point:BEFORE FIELD mmbo015 name="construct.b.mmbo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo015
            
            #add-point:AFTER FIELD mmbo015 name="construct.a.mmbo015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo015
            #add-point:ON ACTION controlp INFIELD mmbo015 name="construct.c.mmbo015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbounit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbounit
            #add-point:ON ACTION controlp INFIELD mmbounit name="construct.c.mmbounit"
                        #此段落由子樣板a08產生
            #開窗c段
           #sakura---mark---str 
			  #INITIALIZE g_qryparam.* TO NULL
           #LET g_qryparam.state = 'c'
			  #LET g_qryparam.reqry = FALSE
			  #LET g_qryparam.where = " ooef201 = 'Y' "
           #CALL q_ooef001()                           #呼叫開窗
           #DISPLAY g_qryparam.return1 TO mmbounit  #顯示到畫面上
           #
           #NEXT FIELD mmbounit                     #返回原欄位
           #sakura---mark---end


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbounit
            #add-point:BEFORE FIELD mmbounit name="construct.b.mmbounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbounit
            
            #add-point:AFTER FIELD mmbounit name="construct.a.mmbounit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo016
            #add-point:BEFORE FIELD mmbo016 name="construct.b.mmbo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo016
            
            #add-point:AFTER FIELD mmbo016 name="construct.a.mmbo016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo016
            #add-point:ON ACTION controlp INFIELD mmbo016 name="construct.c.mmbo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmboacti
            #add-point:BEFORE FIELD mmboacti name="construct.b.mmboacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmboacti
            
            #add-point:AFTER FIELD mmboacti name="construct.a.mmboacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmboacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmboacti
            #add-point:ON ACTION controlp INFIELD mmboacti name="construct.c.mmboacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbostus
            #add-point:BEFORE FIELD mmbostus name="construct.b.mmbostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbostus
            
            #add-point:AFTER FIELD mmbostus name="construct.a.mmbostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbostus
            #add-point:ON ACTION controlp INFIELD mmbostus name="construct.c.mmbostus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmboownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmboownid
            #add-point:ON ACTION controlp INFIELD mmboownid name="construct.c.mmboownid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmboownid  #顯示到畫面上

            NEXT FIELD mmboownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmboownid
            #add-point:BEFORE FIELD mmboownid name="construct.b.mmboownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmboownid
            
            #add-point:AFTER FIELD mmboownid name="construct.a.mmboownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmboowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmboowndp
            #add-point:ON ACTION controlp INFIELD mmboowndp name="construct.c.mmboowndp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmboowndp  #顯示到畫面上

            NEXT FIELD mmboowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmboowndp
            #add-point:BEFORE FIELD mmboowndp name="construct.b.mmboowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmboowndp
            
            #add-point:AFTER FIELD mmboowndp name="construct.a.mmboowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbocrtid
            #add-point:ON ACTION controlp INFIELD mmbocrtid name="construct.c.mmbocrtid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocrtid  #顯示到畫面上

            NEXT FIELD mmbocrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbocrtid
            #add-point:BEFORE FIELD mmbocrtid name="construct.b.mmbocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbocrtid
            
            #add-point:AFTER FIELD mmbocrtid name="construct.a.mmbocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mmbocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbocrtdp
            #add-point:ON ACTION controlp INFIELD mmbocrtdp name="construct.c.mmbocrtdp"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocrtdp  #顯示到畫面上

            NEXT FIELD mmbocrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbocrtdp
            #add-point:BEFORE FIELD mmbocrtdp name="construct.b.mmbocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbocrtdp
            
            #add-point:AFTER FIELD mmbocrtdp name="construct.a.mmbocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbocrtdt
            #add-point:BEFORE FIELD mmbocrtdt name="construct.b.mmbocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbomodid
            #add-point:ON ACTION controlp INFIELD mmbomodid name="construct.c.mmbomodid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbomodid  #顯示到畫面上

            NEXT FIELD mmbomodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbomodid
            #add-point:BEFORE FIELD mmbomodid name="construct.b.mmbomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbomodid
            
            #add-point:AFTER FIELD mmbomodid name="construct.a.mmbomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbomoddt
            #add-point:BEFORE FIELD mmbomoddt name="construct.b.mmbomoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mmbocnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbocnfid
            #add-point:ON ACTION controlp INFIELD mmbocnfid name="construct.c.mmbocnfid"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocnfid  #顯示到畫面上

            NEXT FIELD mmbocnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbocnfid
            #add-point:BEFORE FIELD mmbocnfid name="construct.b.mmbocnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbocnfid
            
            #add-point:AFTER FIELD mmbocnfid name="construct.a.mmbocnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbocnfdt
            #add-point:BEFORE FIELD mmbocnfdt name="construct.b.mmbocnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmddsite,mmddunit,mmdd001,mmdd002,mmdd003,mmdd004,mmddacti
           FROM s_detail1[1].mmddsite,s_detail1[1].mmddunit,s_detail1[1].mmdd001,s_detail1[1].mmdd002, 
               s_detail1[1].mmdd003,s_detail1[1].mmdd004,s_detail1[1].mmddacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddsite
            #add-point:BEFORE FIELD mmddsite name="construct.b.page1.mmddsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddsite
            
            #add-point:AFTER FIELD mmddsite name="construct.a.page1.mmddsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddsite
            #add-point:ON ACTION controlp INFIELD mmddsite name="construct.c.page1.mmddsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddunit
            #add-point:BEFORE FIELD mmddunit name="construct.b.page1.mmddunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddunit
            
            #add-point:AFTER FIELD mmddunit name="construct.a.page1.mmddunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmddunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddunit
            #add-point:ON ACTION controlp INFIELD mmddunit name="construct.c.page1.mmddunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd001
            #add-point:BEFORE FIELD mmdd001 name="construct.b.page1.mmdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd001
            
            #add-point:AFTER FIELD mmdd001 name="construct.a.page1.mmdd001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmdd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd001
            #add-point:ON ACTION controlp INFIELD mmdd001 name="construct.c.page1.mmdd001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd002
            #add-point:BEFORE FIELD mmdd002 name="construct.b.page1.mmdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd002
            
            #add-point:AFTER FIELD mmdd002 name="construct.a.page1.mmdd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd002
            #add-point:ON ACTION controlp INFIELD mmdd002 name="construct.c.page1.mmdd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd003
            #add-point:BEFORE FIELD mmdd003 name="construct.b.page1.mmdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd003
            
            #add-point:AFTER FIELD mmdd003 name="construct.a.page1.mmdd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd003
            #add-point:ON ACTION controlp INFIELD mmdd003 name="construct.c.page1.mmdd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd004
            #add-point:BEFORE FIELD mmdd004 name="construct.b.page1.mmdd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd004
            
            #add-point:AFTER FIELD mmdd004 name="construct.a.page1.mmdd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmdd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd004
            #add-point:ON ACTION controlp INFIELD mmdd004 name="construct.c.page1.mmdd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddacti
            #add-point:BEFORE FIELD mmddacti name="construct.b.page1.mmddacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddacti
            
            #add-point:AFTER FIELD mmddacti name="construct.a.page1.mmddacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.mmddacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddacti
            #add-point:ON ACTION controlp INFIELD mmddacti name="construct.c.page1.mmddacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti
           FROM s_detail2[1].mmbssite,s_detail2[1].mmbsunit,s_detail2[1].mmbs001,s_detail2[1].mmbs002, 
               s_detail2[1].mmbs003,s_detail2[1].mmbs004,s_detail2[1].mmbs005,s_detail2[1].mmbsacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbssite
            #add-point:BEFORE FIELD mmbssite name="construct.b.page2.mmbssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbssite
            
            #add-point:AFTER FIELD mmbssite name="construct.a.page2.mmbssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbssite
            #add-point:ON ACTION controlp INFIELD mmbssite name="construct.c.page2.mmbssite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbsunit
            #add-point:BEFORE FIELD mmbsunit name="construct.b.page2.mmbsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbsunit
            
            #add-point:AFTER FIELD mmbsunit name="construct.a.page2.mmbsunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbsunit
            #add-point:ON ACTION controlp INFIELD mmbsunit name="construct.c.page2.mmbsunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs001
            #add-point:BEFORE FIELD mmbs001 name="construct.b.page2.mmbs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs001
            
            #add-point:AFTER FIELD mmbs001 name="construct.a.page2.mmbs001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs001
            #add-point:ON ACTION controlp INFIELD mmbs001 name="construct.c.page2.mmbs001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs002
            #add-point:BEFORE FIELD mmbs002 name="construct.b.page2.mmbs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs002
            
            #add-point:AFTER FIELD mmbs002 name="construct.a.page2.mmbs002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbs002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs002
            #add-point:ON ACTION controlp INFIELD mmbs002 name="construct.c.page2.mmbs002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs003
            #add-point:BEFORE FIELD mmbs003 name="construct.b.page2.mmbs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs003
            
            #add-point:AFTER FIELD mmbs003 name="construct.a.page2.mmbs003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs003
            #add-point:ON ACTION controlp INFIELD mmbs003 name="construct.c.page2.mmbs003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.mmbs004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs004
            #add-point:ON ACTION controlp INFIELD mmbs004 name="construct.c.page2.mmbs004"
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			   #161024-00025#1--dongsz add--s
			   #判断aooi500是否有设定
            IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbs004',g_site,'c') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            #161024-00025#1--dongsz add--e
            #161024-00025#1--dongsz mark--s
#			   LET g_qryparam.where = " ooef201 = 'Y' "
#            CALL q_ooef001()                           #呼叫開窗
            #161024-00025#1--dongsz mark--e
            DISPLAY g_qryparam.return1 TO mmbs004  #顯示到畫面上

            NEXT FIELD mmbs004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs004
            #add-point:BEFORE FIELD mmbs004 name="construct.b.page2.mmbs004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs004
            
            #add-point:AFTER FIELD mmbs004 name="construct.a.page2.mmbs004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs005
            #add-point:BEFORE FIELD mmbs005 name="construct.b.page2.mmbs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs005
            
            #add-point:AFTER FIELD mmbs005 name="construct.a.page2.mmbs005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs005
            #add-point:ON ACTION controlp INFIELD mmbs005 name="construct.c.page2.mmbs005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbsacti
            #add-point:BEFORE FIELD mmbsacti name="construct.b.page2.mmbsacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbsacti
            
            #add-point:AFTER FIELD mmbsacti name="construct.a.page2.mmbsacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.mmbsacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbsacti
            #add-point:ON ACTION controlp INFIELD mmbsacti name="construct.c.page2.mmbsacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mmcksite,mmckunit,mmck001,mmck002,mmck003,mmck004,mmck005,mmck006,mmck007, 
          mmck008,mmck009,mmckacti
           FROM s_detail3[1].mmcksite,s_detail3[1].mmckunit,s_detail3[1].mmck001,s_detail3[1].mmck002, 
               s_detail3[1].mmck003,s_detail3[1].mmck004,s_detail3[1].mmck005,s_detail3[1].mmck006,s_detail3[1].mmck007, 
               s_detail3[1].mmck008,s_detail3[1].mmck009,s_detail3[1].mmckacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcksite
            #add-point:BEFORE FIELD mmcksite name="construct.b.page3.mmcksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcksite
            
            #add-point:AFTER FIELD mmcksite name="construct.a.page3.mmcksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmcksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcksite
            #add-point:ON ACTION controlp INFIELD mmcksite name="construct.c.page3.mmcksite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmckunit
            #add-point:BEFORE FIELD mmckunit name="construct.b.page3.mmckunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmckunit
            
            #add-point:AFTER FIELD mmckunit name="construct.a.page3.mmckunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmckunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmckunit
            #add-point:ON ACTION controlp INFIELD mmckunit name="construct.c.page3.mmckunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck001
            #add-point:BEFORE FIELD mmck001 name="construct.b.page3.mmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck001
            
            #add-point:AFTER FIELD mmck001 name="construct.a.page3.mmck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck001
            #add-point:ON ACTION controlp INFIELD mmck001 name="construct.c.page3.mmck001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck002
            #add-point:BEFORE FIELD mmck002 name="construct.b.page3.mmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck002
            
            #add-point:AFTER FIELD mmck002 name="construct.a.page3.mmck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck002
            #add-point:ON ACTION controlp INFIELD mmck002 name="construct.c.page3.mmck002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck003
            #add-point:BEFORE FIELD mmck003 name="construct.b.page3.mmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck003
            
            #add-point:AFTER FIELD mmck003 name="construct.a.page3.mmck003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck003
            #add-point:ON ACTION controlp INFIELD mmck003 name="construct.c.page3.mmck003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck004
            #add-point:BEFORE FIELD mmck004 name="construct.b.page3.mmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck004
            
            #add-point:AFTER FIELD mmck004 name="construct.a.page3.mmck004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck004
            #add-point:ON ACTION controlp INFIELD mmck004 name="construct.c.page3.mmck004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck005
            #add-point:BEFORE FIELD mmck005 name="construct.b.page3.mmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck005
            
            #add-point:AFTER FIELD mmck005 name="construct.a.page3.mmck005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck005
            #add-point:ON ACTION controlp INFIELD mmck005 name="construct.c.page3.mmck005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck006
            #add-point:BEFORE FIELD mmck006 name="construct.b.page3.mmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck006
            
            #add-point:AFTER FIELD mmck006 name="construct.a.page3.mmck006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck006
            #add-point:ON ACTION controlp INFIELD mmck006 name="construct.c.page3.mmck006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck007
            #add-point:BEFORE FIELD mmck007 name="construct.b.page3.mmck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck007
            
            #add-point:AFTER FIELD mmck007 name="construct.a.page3.mmck007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck007
            #add-point:ON ACTION controlp INFIELD mmck007 name="construct.c.page3.mmck007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck008
            #add-point:BEFORE FIELD mmck008 name="construct.b.page3.mmck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck008
            
            #add-point:AFTER FIELD mmck008 name="construct.a.page3.mmck008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck008
            #add-point:ON ACTION controlp INFIELD mmck008 name="construct.c.page3.mmck008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck009
            #add-point:BEFORE FIELD mmck009 name="construct.b.page3.mmck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck009
            
            #add-point:AFTER FIELD mmck009 name="construct.a.page3.mmck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck009
            #add-point:ON ACTION controlp INFIELD mmck009 name="construct.c.page3.mmck009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmckacti
            #add-point:BEFORE FIELD mmckacti name="construct.b.page3.mmckacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmckacti
            
            #add-point:AFTER FIELD mmckacti name="construct.a.page3.mmckacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.mmckacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmckacti
            #add-point:ON ACTION controlp INFIELD mmckacti name="construct.c.page3.mmckacti"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg003,mmdg004,mmdg005,mmdg006,mmdg007, 
          mmdgacti
           FROM s_detail4[1].mmdgunit,s_detail4[1].mmdgsite,s_detail4[1].mmdg001,s_detail4[1].mmdg002, 
               s_detail4[1].mmdg003,s_detail4[1].mmdg004,s_detail4[1].mmdg005,s_detail4[1].mmdg006,s_detail4[1].mmdg007, 
               s_detail4[1].mmdgacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgunit
            #add-point:BEFORE FIELD mmdgunit name="construct.b.page4.mmdgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgunit
            
            #add-point:AFTER FIELD mmdgunit name="construct.a.page4.mmdgunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgunit
            #add-point:ON ACTION controlp INFIELD mmdgunit name="construct.c.page4.mmdgunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgsite
            #add-point:BEFORE FIELD mmdgsite name="construct.b.page4.mmdgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgsite
            
            #add-point:AFTER FIELD mmdgsite name="construct.a.page4.mmdgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgsite
            #add-point:ON ACTION controlp INFIELD mmdgsite name="construct.c.page4.mmdgsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg001
            #add-point:BEFORE FIELD mmdg001 name="construct.b.page4.mmdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg001
            
            #add-point:AFTER FIELD mmdg001 name="construct.a.page4.mmdg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg001
            #add-point:ON ACTION controlp INFIELD mmdg001 name="construct.c.page4.mmdg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg002
            #add-point:BEFORE FIELD mmdg002 name="construct.b.page4.mmdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg002
            
            #add-point:AFTER FIELD mmdg002 name="construct.a.page4.mmdg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg002
            #add-point:ON ACTION controlp INFIELD mmdg002 name="construct.c.page4.mmdg002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg003
            #add-point:BEFORE FIELD mmdg003 name="construct.b.page4.mmdg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg003
            
            #add-point:AFTER FIELD mmdg003 name="construct.a.page4.mmdg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg003
            #add-point:ON ACTION controlp INFIELD mmdg003 name="construct.c.page4.mmdg003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg004
            #add-point:BEFORE FIELD mmdg004 name="construct.b.page4.mmdg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg004
            
            #add-point:AFTER FIELD mmdg004 name="construct.a.page4.mmdg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg004
            #add-point:ON ACTION controlp INFIELD mmdg004 name="construct.c.page4.mmdg004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg005
            #add-point:BEFORE FIELD mmdg005 name="construct.b.page4.mmdg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg005
            
            #add-point:AFTER FIELD mmdg005 name="construct.a.page4.mmdg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg005
            #add-point:ON ACTION controlp INFIELD mmdg005 name="construct.c.page4.mmdg005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg006
            #add-point:BEFORE FIELD mmdg006 name="construct.b.page4.mmdg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg006
            
            #add-point:AFTER FIELD mmdg006 name="construct.a.page4.mmdg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg006
            #add-point:ON ACTION controlp INFIELD mmdg006 name="construct.c.page4.mmdg006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg007
            #add-point:BEFORE FIELD mmdg007 name="construct.b.page4.mmdg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg007
            
            #add-point:AFTER FIELD mmdg007 name="construct.a.page4.mmdg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg007
            #add-point:ON ACTION controlp INFIELD mmdg007 name="construct.c.page4.mmdg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgacti
            #add-point:BEFORE FIELD mmdgacti name="construct.b.page4.mmdgacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgacti
            
            #add-point:AFTER FIELD mmdgacti name="construct.a.page4.mmdgacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.mmdgacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgacti
            #add-point:ON ACTION controlp INFIELD mmdgacti name="construct.c.page4.mmdgacti"
            
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
                  WHEN la_wc[li_idx].tableid = "mmbo_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmdd_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "mmbs_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mmck_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "mmdg_t" 
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
 
{<section id="agct415.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION agct415_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON mmbosite,mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002, 
          mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmboacti
                          FROM s_browse[1].b_mmbosite,s_browse[1].b_mmbodocdt,s_browse[1].b_mmbodocno, 
                              s_browse[1].b_mmbo000,s_browse[1].b_mmbo004,s_browse[1].b_mmbo006,s_browse[1].b_mmbo001, 
                              s_browse[1].b_mmbo002,s_browse[1].b_mmbo005,s_browse[1].b_mmbo007,s_browse[1].b_mmbo008, 
                              s_browse[1].b_mmbo014,s_browse[1].b_mmbo015,s_browse[1].b_mmboacti
 
         BEFORE CONSTRUCT
               DISPLAY agct415_filter_parser('mmbosite') TO s_browse[1].b_mmbosite
            DISPLAY agct415_filter_parser('mmbodocdt') TO s_browse[1].b_mmbodocdt
            DISPLAY agct415_filter_parser('mmbodocno') TO s_browse[1].b_mmbodocno
            DISPLAY agct415_filter_parser('mmbo000') TO s_browse[1].b_mmbo000
            DISPLAY agct415_filter_parser('mmbo004') TO s_browse[1].b_mmbo004
            DISPLAY agct415_filter_parser('mmbo006') TO s_browse[1].b_mmbo006
            DISPLAY agct415_filter_parser('mmbo001') TO s_browse[1].b_mmbo001
            DISPLAY agct415_filter_parser('mmbo002') TO s_browse[1].b_mmbo002
            DISPLAY agct415_filter_parser('mmbo005') TO s_browse[1].b_mmbo005
            DISPLAY agct415_filter_parser('mmbo007') TO s_browse[1].b_mmbo007
            DISPLAY agct415_filter_parser('mmbo008') TO s_browse[1].b_mmbo008
            DISPLAY agct415_filter_parser('mmbo014') TO s_browse[1].b_mmbo014
            DISPLAY agct415_filter_parser('mmbo015') TO s_browse[1].b_mmbo015
            DISPLAY agct415_filter_parser('mmboacti') TO s_browse[1].b_mmboacti
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL agct415_filter_show('mmbosite')
   CALL agct415_filter_show('mmbodocdt')
   CALL agct415_filter_show('mmbodocno')
   CALL agct415_filter_show('mmbo000')
   CALL agct415_filter_show('mmbo004')
   CALL agct415_filter_show('mmbo006')
   CALL agct415_filter_show('mmbo001')
   CALL agct415_filter_show('mmbo002')
   CALL agct415_filter_show('mmbo005')
   CALL agct415_filter_show('mmbo007')
   CALL agct415_filter_show('mmbo008')
   CALL agct415_filter_show('mmbo014')
   CALL agct415_filter_show('mmbo015')
   CALL agct415_filter_show('mmboacti')
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION agct415_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="agct415.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION agct415_filter_show(ps_field)
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
   LET ls_condition = agct415_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION agct415_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
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
   CALL g_mmdd_d.clear()
   CALL g_mmdd2_d.clear()
   CALL g_mmdd3_d.clear()
   CALL g_mmdd4_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL agct415_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL agct415_browser_fill("")
      CALL agct415_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL agct415_filter_show('mmbosite')
   CALL agct415_filter_show('mmbodocdt')
   CALL agct415_filter_show('mmbodocno')
   CALL agct415_filter_show('mmbo000')
   CALL agct415_filter_show('mmbo004')
   CALL agct415_filter_show('mmbo006')
   CALL agct415_filter_show('mmbo001')
   CALL agct415_filter_show('mmbo002')
   CALL agct415_filter_show('mmbo005')
   CALL agct415_filter_show('mmbo007')
   CALL agct415_filter_show('mmbo008')
   CALL agct415_filter_show('mmbo014')
   CALL agct415_filter_show('mmbo015')
   CALL agct415_filter_show('mmboacti')
   CALL agct415_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL agct415_fetch("F") 
      #顯示單身筆數
      CALL agct415_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION agct415_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_mmbo_m.mmbodocno = g_browser[g_current_idx].b_mmbodocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
   #遮罩相關處理
   LET g_mmbo_m_mask_o.* =  g_mmbo_m.*
   CALL agct415_mmbo_t_mask()
   LET g_mmbo_m_mask_n.* =  g_mmbo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct415_set_act_visible()   
   CALL agct415_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
      IF g_mmbo_m.mmbostus  NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_mmbo_m_t.* = g_mmbo_m.*
   LET g_mmbo_m_o.* = g_mmbo_m.*
   
   LET g_data_owner = g_mmbo_m.mmboownid      
   LET g_data_dept  = g_mmbo_m.mmboowndp
   
   #重新顯示   
   CALL agct415_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.insert" >}
#+ 資料新增
PRIVATE FUNCTION agct415_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5    #sakura add
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmdd_d.clear()   
   CALL g_mmdd2_d.clear()  
   CALL g_mmdd3_d.clear()  
   CALL g_mmdd4_d.clear()  
 
 
   INITIALIZE g_mmbo_m.* TO NULL             #DEFAULT 設定
   
   LET g_mmbodocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbo_m.mmboownid = g_user
      LET g_mmbo_m.mmboowndp = g_dept
      LET g_mmbo_m.mmbocrtid = g_user
      LET g_mmbo_m.mmbocrtdp = g_dept 
      LET g_mmbo_m.mmbocrtdt = cl_get_current()
      LET g_mmbo_m.mmbomodid = g_user
      LET g_mmbo_m.mmbomoddt = cl_get_current()
      LET g_mmbo_m.mmbostus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmbo_m.mmbo000 = "I"
      LET g_mmbo_m.mmbo004 = "8"
      LET g_mmbo_m.mmbo002 = "0"
      LET g_mmbo_m.mmbo007 = "0"
      LET g_mmbo_m.mmbo008 = "0"
      LET g_mmbo_m.mmbo016 = "N"
      LET g_mmbo_m.mmboacti = "Y"
      LET g_mmbo_m.mmbostus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_mmbo_m_t.* TO NULL
      INITIALIZE g_mmbo_m_o.* TO NULL
      #sakura---add---str
      CALL s_aooi500_default(g_prog,'mmbosite',g_mmbo_m.mmbosite)
         RETURNING l_insert,g_mmbo_m.mmbosite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_mmbo_m.mmbounit = g_mmbo_m.mmbosite
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmbo_m.mmbosite,g_prog,'1') RETURNING l_success, l_doctype
      LET g_mmbo_m.mmbodocno = l_doctype      
      #sakura---add---end     
      LET g_mmbo_m.mmbodocdt = g_today
     #LET g_mmbo_m.mmbounit  = g_site #sakura mark
     #LET g_mmbo_m.mmbosite  = g_site #sakura mark
     #CALL agct415_mmbounit_ref() #sakura mark
      CALL agct415_mmbosite_ref() #sakura add
      LET g_site_flag = FALSE       #sakura add
      LET g_mmbo_m_t.* = g_mmbo_m.* #sakura add
      LET g_mmbo_m.mmbo016 = 'Y'
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_mmbo_m_t.* = g_mmbo_m.*
      LET g_mmbo_m_o.* = g_mmbo_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbo_m.mmbostus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL agct415_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_mmbo_m.* TO NULL
         INITIALIZE g_mmdd_d TO NULL
         INITIALIZE g_mmdd2_d TO NULL
         INITIALIZE g_mmdd3_d TO NULL
         INITIALIZE g_mmdd4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL agct415_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_mmdd_d.clear()
      #CALL g_mmdd2_d.clear()
      #CALL g_mmdd3_d.clear()
      #CALL g_mmdd4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct415_set_act_visible()   
   CALL agct415_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmboent = " ||g_enterprise|| " AND",
                      " mmbodocno = '", g_mmbo_m.mmbodocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct415_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE agct415_cl
   
   CALL agct415_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
   
   #遮罩相關處理
   LET g_mmbo_m_mask_o.* =  g_mmbo_m.*
   CALL agct415_mmbo_t_mask()
   LET g_mmbo_m_mask_n.* =  g_mmbo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000, 
       g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus, 
       g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid, 
       g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_mmbo_m.mmboownid      
   LET g_data_dept  = g_mmbo_m.mmboowndp
   
   #功能已完成,通報訊息中心
   CALL agct415_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.modify" >}
#+ 資料修改
PRIVATE FUNCTION agct415_modify()
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
   LET g_mmbo_m_t.* = g_mmbo_m.*
   LET g_mmbo_m_o.* = g_mmbo_m.*
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   CALL s_transaction_begin()
   
   OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
   #檢查是否允許此動作
   IF NOT agct415_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbo_m_mask_o.* =  g_mmbo_m.*
   CALL agct415_mmbo_t_mask()
   LET g_mmbo_m_mask_n.* =  g_mmbo_m.*
   
   
   
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
 
 
 
   
   CALL agct415_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
 
 
    
   WHILE TRUE
      LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmbo_m.mmbomodid = g_user 
LET g_mmbo_m.mmbomoddt = cl_get_current()
LET g_mmbo_m.mmbomodid_desc = cl_get_username(g_mmbo_m.mmbomodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mmbo_m.mmbostus MATCHES "[DR]" THEN
         LET g_mmbo_m.mmbostus = "N"
      END IF   
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL agct415_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE mmbo_t SET (mmbomodid,mmbomoddt) = (g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt)
          WHERE mmboent = g_enterprise AND mmbodocno = g_mmbodocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_mmbo_m.* = g_mmbo_m_t.*
            CALL agct415_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_mmbo_m.mmbodocno != g_mmbo_m_t.mmbodocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE mmdd_t SET mmdddocno = g_mmbo_m.mmbodocno
 
          WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m_t.mmbodocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmdd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE mmbs_t
            SET mmbsdocno = g_mmbo_m.mmbodocno
 
          WHERE mmbsent = g_enterprise AND
                mmbsdocno = g_mmbodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmbs_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update3"
         
         #end add-point
         
         UPDATE mmck_t
            SET mmckdocno = g_mmbo_m.mmbodocno
 
          WHERE mmckent = g_enterprise AND
                mmckdocno = g_mmbodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmck_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update4"
         
         #end add-point
         
         UPDATE mmdg_t
            SET mmdgdocno = g_mmbo_m.mmbodocno
 
          WHERE mmdgent = g_enterprise AND
                mmdgdocno = g_mmbodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "mmdg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
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
   CALL agct415_set_act_visible()   
   CALL agct415_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " mmboent = " ||g_enterprise|| " AND",
                      " mmbodocno = '", g_mmbo_m.mmbodocno, "' "
 
   #填到對應位置
   CALL agct415_browser_fill("")
 
   CLOSE agct415_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct415_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="agct415.input" >}
#+ 資料輸入
PRIVATE FUNCTION agct415_input(p_cmd)
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
   DEFINE  l_ooef004       LIKE ooef_t.ooef004
   DEFINE  l_success       LIKE type_t.chr1
   DEFINE  l_errno         LIKE type_t.chr10 #sakura add
   DEFINE  l_where         STRING            #sakura add   
   DEFINE  l_flag          LIKE type_t.num5
   #160627-00005#1 160627 by sakura add(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
            oofg019        LIKE oofg_t.oofg019,  #field
            oofg020        LIKE oofg_t.oofg020   #value
                           END RECORD
   DEFINE l_count_chk      LIKE type_t.num5
   #160627-00005#1 160627 by sakura add(E)   
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
   DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000, 
       g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus, 
       g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid, 
       g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt 
 
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT mmddsite,mmddunit,mmdd001,mmdd002,mmdd003,mmdd004,mmddacti FROM mmdd_t  
       WHERE mmddent=? AND mmdddocno=? AND mmdd001=? AND mmdd003=? AND mmdd004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct415_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti FROM  
       mmbs_t WHERE mmbsent=? AND mmbsdocno=? AND mmbs004=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct415_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmcksite,mmckunit,mmck001,mmck002,mmck003,mmck004,mmck005,mmck006,mmck007, 
       mmck008,mmck009,mmckacti FROM mmck_t WHERE mmckent=? AND mmckdocno=? AND mmck003=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct415_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg003,mmdg004,mmdg005,mmdg006,mmdg007, 
       mmdgacti FROM mmdg_t WHERE mmdgent=? AND mmdgdocno=? AND mmdg003=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agct415_bcl4 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL agct415_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL agct415_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004, 
       g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit,g_mmbo_m.mmbo016, 
       g_mmbo_m.mmboacti,g_mmbo_m.mmbostus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
      LET g_mmbo_m_o.* = g_mmbo_m.*      #
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="agct415.input.head" >}
      #單頭段
      INPUT BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004, 
          g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005, 
          g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit,g_mmbo_m.mmbo016, 
          g_mmbo_m.mmboacti,g_mmbo_m.mmbostus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN
               
               #add-point:ON ACTION update_item name="input.master_input.update_item"
                           IF NOT cl_null(g_mmbo_m.mmbodocno) THEN
                  CALL n_mmbol(g_mmbo_m.mmbodocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mmbo_m.mmbodocno
#                  CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmboldocno = ? AND mmbol001 = '"||g_lang||"'","") RETURNING g_rtn_fields      #160905-00007#3 marked
                  CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmboldocno = ? AND mmbolent = "||g_enterprise||" AND mmbol001 = '"||g_lang||"'","") RETURNING g_rtn_fields      #160905-00007#3 mod
                  LET g_mmbo_m.mmbol002 = g_rtn_fields[1]
                  LET g_mmbo_m.mmbol003 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mmbo_m.mmbol002
                  DISPLAY BY NAME g_mmbo_m.mmbol003
               END IF
               #END add-point
            END IF
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct415_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            LET g_master_multi_table_t.mmboldocno = g_mmbo_m.mmbodocno
LET g_master_multi_table_t.mmbol002 = g_mmbo_m.mmbol002
LET g_master_multi_table_t.mmbol003 = g_mmbo_m.mmbol003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mmboldocno = ''
LET g_master_multi_table_t.mmbol002 = ''
LET g_master_multi_table_t.mmbol003 = ''
 
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL agct415_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL agct415_set_entry(p_cmd)
            CALL agct415_set_no_entry(p_cmd)
            #end add-point
            CALL agct415_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbosite
            
            #add-point:AFTER FIELD mmbosite name="input.a.mmbosite"
            #sakura---add---str
            LET g_mmbo_m.mmbosite_desc = ' '
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
            IF NOT cl_null(g_mmbo_m.mmbosite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmbo_m.mmbosite != g_mmbo_m_t.mmbosite OR g_mmbo_m_t.mmbosite IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'mmbosite',g_mmbo_m.mmbosite,g_mmbo_m.mmbosite)
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite
                     CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
                     DISPLAY BY NAME g_mmbo_m.mmbosite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite
               CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
               DISPLAY BY NAME g_mmbo_m.mmbosite_desc
               NEXT FIELD CURRENT
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
            CALL agct415_set_entry(p_cmd)
            CALL agct415_set_no_entry(p_cmd)            
            #sakura---add---end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbosite
            #add-point:BEFORE FIELD mmbosite name="input.b.mmbosite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbosite
            #add-point:ON CHANGE mmbosite name="input.g.mmbosite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbodocdt
            #add-point:BEFORE FIELD mmbodocdt name="input.b.mmbodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbodocdt
            
            #add-point:AFTER FIELD mmbodocdt name="input.a.mmbodocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbodocdt
            #add-point:ON CHANGE mmbodocdt name="input.g.mmbodocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbodocno
            #add-point:BEFORE FIELD mmbodocno name="input.b.mmbodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbodocno
            
            #add-point:AFTER FIELD mmbodocno name="input.a.mmbodocno"
                        IF p_cmd = 'a' AND NOT cl_null(g_mmbo_m.mmbodocno) THEN 
               IF NOT s_aooi200_chk_slip(g_mmbo_m.mmbosite,'',g_mmbo_m.mmbodocno,g_prog) THEN
                  LET g_mmbo_m.mmbodocno = g_mmbo_m_t.mmbodocno
                  DISPLAY BY NAME g_mmbo_m.mmbodocno
                  NEXT FIELD CURRENT
               END IF
            END IF
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbo_m.mmbodocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbo_t WHERE "||"mmboent = '" ||g_enterprise|| "' AND "||"mmbodocno = '"||g_mmbo_m.mmbodocno ||"'",'std-00004',0) THEN 
                     LET g_mmbo_m.mmbodocno = g_mmbo_m_t.mmbodocno
                     DISPLAY BY NAME g_mmbo_m.mmbodocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbodocno
            #add-point:ON CHANGE mmbodocno name="input.g.mmbodocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo000
            #add-point:BEFORE FIELD mmbo000 name="input.b.mmbo000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo000
            
            #add-point:AFTER FIELD mmbo000 name="input.a.mmbo000"
                        IF NOT cl_null(g_mmbo_m.mmbo000) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbo000 != g_mmbo_m_t.mmbo000)) THEN
                  IF g_mmbo_m.mmbo000 != g_mmbo_m_o.mmbo000 OR cl_null(g_mmbo_m_o.mmbo000) THEN
                     CALL agct415_mmbo000_init()
                  END IF
               END IF
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.*      #
            CALL agct415_set_entry(p_cmd)
            CALL agct415_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo000
            #add-point:ON CHANGE mmbo000 name="input.g.mmbo000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo004
            #add-point:BEFORE FIELD mmbo004 name="input.b.mmbo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo004
            
            #add-point:AFTER FIELD mmbo004 name="input.a.mmbo004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo004
            #add-point:ON CHANGE mmbo004 name="input.g.mmbo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo006
            #add-point:BEFORE FIELD mmbo006 name="input.b.mmbo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo006
            
            #add-point:AFTER FIELD mmbo006 name="input.a.mmbo006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo006
            #add-point:ON CHANGE mmbo006 name="input.g.mmbo006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo001
            #add-point:BEFORE FIELD mmbo001 name="input.b.mmbo001"
            #160627-00005#1 160627 by sakura add(S)
            IF g_mmbo_m.mmbo000 = 'I' AND cl_null(g_mmbo_m.mmbo001) THEN    
               CALL s_aooi390_gen('37') RETURNING l_success,g_mmbo_m.mmbo001,l_oofg_return              
            END IF
			#160627-00005#1 160627 by sakura add(E)            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo001
            
            #add-point:AFTER FIELD mmbo001 name="input.a.mmbo001"
            IF NOT cl_null(g_mmbo_m.mmbo001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbo001 != g_mmbo_m_t.mmbo001)) THEN   #160824-00007#103 20161024 mark by beckxie
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbo001 != g_mmbo_m_o.mmbo001)) THEN    #160824-00007#103 20161024 add by beckxie
                  CALL agct415_mmbo001_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbo_m.mmbo001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbo_m.mmbo001 = g_mmbo_m_t.mmbo001   #160824-00007#103 20161024 mark by beckxie
                     LET g_mmbo_m.mmbo001 = g_mmbo_m_o.mmbo001    #160824-00007#103 20161024 add by beckxie
                     CALL agct415_mmbo001_init()                  #160824-00007#103 20161024 add by beckxie
                     DISPLAY BY NAME g_mmbo_m.mmbo001
                     NEXT FIELD CURRENT
                  END IF
                  #160627-00005#1 160627 by sakura add(S)
                  IF NOT s_aooi390_chk('37',g_mmbo_m.mmbo001) THEN
                     #LET g_mmbo_m.mmbo001 = g_mmbo_m_t.mmbo001   #160824-00007#103 20161024 mark by beckxie
                     LET g_mmbo_m.mmbo001 = g_mmbo_m_o.mmbo001    #160824-00007#103 20161024 add by beckxie
                     CALL agct415_mmbo001_init()                  #160824-00007#103 20161024 add by beckxie
                     NEXT FIELD CURRENT
                  END IF
				      #160627-00005#1 160627 by sakura add(E)                  
                  IF g_mmbo_m.mmbo001 != g_mmbo_m_o.mmbo001 OR cl_null(g_mmbo_m_o.mmbo001) THEN
                     CALL agct415_mmbo001_init()
                  END IF
               END IF
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.*      #
            CALL agct415_set_entry(p_cmd)
            CALL agct415_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo001
            #add-point:ON CHANGE mmbo001 name="input.g.mmbo001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo002
            #add-point:BEFORE FIELD mmbo002 name="input.b.mmbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo002
            
            #add-point:AFTER FIELD mmbo002 name="input.a.mmbo002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo002
            #add-point:ON CHANGE mmbo002 name="input.g.mmbo002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbol002
            #add-point:BEFORE FIELD mmbol002 name="input.b.mmbol002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbol002
            
            #add-point:AFTER FIELD mmbol002 name="input.a.mmbol002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbol002
            #add-point:ON CHANGE mmbol002 name="input.g.mmbol002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbol003
            #add-point:BEFORE FIELD mmbol003 name="input.b.mmbol003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbol003
            
            #add-point:AFTER FIELD mmbol003 name="input.a.mmbol003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbol003
            #add-point:ON CHANGE mmbol003 name="input.g.mmbol003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo005
            
            #add-point:AFTER FIELD mmbo005 name="input.a.mmbo005"
                        LET g_mmbo_m.mmbo005_desc = ' '
            DISPLAY BY NAME g_mmbo_m.mmbo005_desc
            IF NOT cl_null(g_mmbo_m.mmbo005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmbo_m.mmbo005 != g_mmbo_m_t.mmbo005 OR g_mmbo_m_t.mmbo005 IS NULL)) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = '1'
                  LET g_chkparam.arg1 = g_mmbo_m.mmbo005
                  IF NOT cl_chk_exist("v_gcaf001_2") THEN
                     LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                     CALL agct415_mmbo005_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL agct415_mmbo005_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo005
            #add-point:BEFORE FIELD mmbo005 name="input.b.mmbo005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo005
            #add-point:ON CHANGE mmbo005 name="input.g.mmbo005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo007
            #add-point:BEFORE FIELD mmbo007 name="input.b.mmbo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo007
            
            #add-point:AFTER FIELD mmbo007 name="input.a.mmbo007"
                        IF NOT cl_null(g_mmbo_m.mmbo007) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_mmbo_m.mmbo007 != g_mmbo_m_t.mmbo007) THEN
                  IF NOT agct415_mmbo007_chk(p_cmd) THEN
                     IF NOT cl_ask_confirm(g_errno) THEN
                        LET g_mmbo_m.mmbo007 = g_mmbo_m_t.mmbo007
                        DISPLAY BY NAME g_mmbo_m.mmbo007
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo007
            #add-point:ON CHANGE mmbo007 name="input.g.mmbo007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo008
            #add-point:BEFORE FIELD mmbo008 name="input.b.mmbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo008
            
            #add-point:AFTER FIELD mmbo008 name="input.a.mmbo008"
                        IF NOT cl_null(g_mmbo_m.mmbo008) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND g_mmbo_m.mmbo008 != g_mmbo_m_t.mmbo008) THEN
                  IF NOT agct415_mmbo008_chk(p_cmd) THEN
                     IF NOT cl_ask_confirm(g_errno) THEN
                        LET g_mmbo_m.mmbo008 = g_mmbo_m_t.mmbo008
                        DISPLAY BY NAME g_mmbo_m.mmbo008
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo008
            #add-point:ON CHANGE mmbo008 name="input.g.mmbo008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo014
            #add-point:BEFORE FIELD mmbo014 name="input.b.mmbo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo014
            
            #add-point:AFTER FIELD mmbo014 name="input.a.mmbo014"
                        IF NOT cl_null(g_mmbo_m.mmbo014) THEN
               CALL agct415_mmbo014_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmbo_m.mmbo014
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmbo_m.mmbo014 = g_mmbo_m_t.mmbo014
                  DISPLAY BY NAME g_mmbo_m.mmbo014
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo014
            #add-point:ON CHANGE mmbo014 name="input.g.mmbo014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo015
            #add-point:BEFORE FIELD mmbo015 name="input.b.mmbo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo015
            
            #add-point:AFTER FIELD mmbo015 name="input.a.mmbo015"
                        IF NOT cl_null(g_mmbo_m.mmbo015) THEN
               CALL agct415_mmbo014_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmbo_m.mmbo015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmbo_m.mmbo015 = g_mmbo_m_t.mmbo015
                  DISPLAY BY NAME g_mmbo_m.mmbo015
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo015
            #add-point:ON CHANGE mmbo015 name="input.g.mmbo015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbounit
            
            #add-point:AFTER FIELD mmbounit name="input.a.mmbounit"
           #sakura---mark---str 
           #LET g_mmbo_m.mmbounit_desc = ' '
           #DISPLAY BY NAME g_mmbo_m.mmbounit_desc
           #IF NOT cl_null(g_mmbo_m.mmbounit) THEN
           #   IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmbo_m.mmbounit != g_mmbo_m_t.mmbounit OR g_mmbo_m_t.mmbounit IS NULL)) THEN
           #      INITIALIZE g_chkparam.* TO NULL
           #      LET g_errshow = '1'
           #      LET g_chkparam.arg1 = g_mmbo_m.mmbounit
           #      LET g_chkparam.arg2 = '8'
           #      LET g_chkparam.arg3 = g_site
           #      IF NOT cl_chk_exist("v_ooed004") THEN
           #         LET g_mmbo_m.mmbounit = g_mmbo_m_t.mmbounit
           #         #CALL agct415_mmbounit_ref() #sakura mark
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF
           #CALL agct415_mmbounit_ref()
           #LET g_mmbo_m.mmbosite = g_mmbo_m.mmbounit
           #sakura---mark---end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbounit
            #add-point:BEFORE FIELD mmbounit name="input.b.mmbounit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbounit
            #add-point:ON CHANGE mmbounit name="input.g.mmbounit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbo016
            #add-point:BEFORE FIELD mmbo016 name="input.b.mmbo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbo016
            
            #add-point:AFTER FIELD mmbo016 name="input.a.mmbo016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbo016
            #add-point:ON CHANGE mmbo016 name="input.g.mmbo016"
            IF g_mmbo_m.mmbo016 = 'N' THEN 
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM mmdg_t 
                WHERE mmdgent = g_enterprise
                  AND mmdgdocno = g_mmbo_m.mmbodocno
               IF l_n > 0 THEN 
                  IF cl_ask_confirm('amm-00470') THEN 
                     DELETE FROM mmdg_t WHERE mmdgent = g_enterprise AND mmdgdocno = g_mmbo_m.mmbodocno
                     CALL agct415_mmdg_display()
                  ELSE
                     LET g_mmbo_m.mmbo016 = 'Y'
                  END IF 
               END IF
            END IF 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmboacti
            #add-point:BEFORE FIELD mmboacti name="input.b.mmboacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmboacti
            
            #add-point:AFTER FIELD mmboacti name="input.a.mmboacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmboacti
            #add-point:ON CHANGE mmboacti name="input.g.mmboacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbostus
            #add-point:BEFORE FIELD mmbostus name="input.b.mmbostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbostus
            
            #add-point:AFTER FIELD mmbostus name="input.a.mmbostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbostus
            #add-point:ON CHANGE mmbostus name="input.g.mmbostus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.mmbosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbosite
            #add-point:ON ACTION controlp INFIELD mmbosite name="input.c.mmbosite"
            #sakura---add---str
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmbo_m.mmbosite             #給予default值
            CALL s_aooi500_q_where(g_prog,'mmbosite',g_mmbo_m.mmbosite,'i') RETURNING l_where #150308-00001#3 150309 pomelo add 'i'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_mmbo_m.mmbosite = g_qryparam.return1
            DISPLAY g_mmbo_m.mmbosite TO mmbosite
            CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
            NEXT FIELD mmbosite                          #返回原欄位            
            #sakura---add---end
            #END add-point
 
 
         #Ctrlp:input.c.mmbodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbodocdt
            #add-point:ON ACTION controlp INFIELD mmbodocdt name="input.c.mmbodocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbodocno
            #add-point:ON ACTION controlp INFIELD mmbodocno name="input.c.mmbodocno"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbo_m.mmbodocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            #LET g_qryparam.arg2 = "agct415" #   #160705-00042#2 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#2 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mmbo_m.mmbodocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbo_m.mmbodocno TO mmbodocno              #顯示到畫面上

            NEXT FIELD mmbodocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbo000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo000
            #add-point:ON ACTION controlp INFIELD mmbo000 name="input.c.mmbo000"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo004
            #add-point:ON ACTION controlp INFIELD mmbo004 name="input.c.mmbo004"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo006
            #add-point:ON ACTION controlp INFIELD mmbo006 name="input.c.mmbo006"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo001
            #add-point:ON ACTION controlp INFIELD mmbo001 name="input.c.mmbo001"
                        IF g_mmbo_m.mmbo000 = 'U' THEN
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_mmbo_m.mmbo001
               LET g_qryparam.arg1 = '8'
               CALL q_mmbt001()
               LET g_mmbo_m.mmbo001 = g_qryparam.return1
               DISPLAY BY NAME g_mmbo_m.mmbo001
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.mmbo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo002
            #add-point:ON ACTION controlp INFIELD mmbo002 name="input.c.mmbo002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbol002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbol002
            #add-point:ON ACTION controlp INFIELD mmbol002 name="input.c.mmbol002"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbol003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbol003
            #add-point:ON ACTION controlp INFIELD mmbol003 name="input.c.mmbol003"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo005
            #add-point:ON ACTION controlp INFIELD mmbo005 name="input.c.mmbo005"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbo_m.mmbo005             #給予default值

            #給予arg

            CALL q_gcaf001()                                #呼叫開窗

            LET g_mmbo_m.mmbo005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbo_m.mmbo005 TO mmbo005              #顯示到畫面上
            
            CALL agct415_mmbo005_ref()

            NEXT FIELD mmbo005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.mmbo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo007
            #add-point:ON ACTION controlp INFIELD mmbo007 name="input.c.mmbo007"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo008
            #add-point:ON ACTION controlp INFIELD mmbo008 name="input.c.mmbo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo014
            #add-point:ON ACTION controlp INFIELD mmbo014 name="input.c.mmbo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo015
            #add-point:ON ACTION controlp INFIELD mmbo015 name="input.c.mmbo015"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbounit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbounit
            #add-point:ON ACTION controlp INFIELD mmbounit name="input.c.mmbounit"
            #此段落由子樣板a07產生            
            #開窗i段
           #sakura---mark---str
			  #INITIALIZE g_qryparam.* TO NULL
           #LET g_qryparam.state = 'i'
			  #LET g_qryparam.reqry = FALSE
           #
           #LET g_qryparam.default1 = g_mmbo_m.mmbounit             #給予default值
           #
           ##給予arg
           #LET g_qryparam.arg1 = g_site #
           #LET g_qryparam.arg2 = '8'
           #
           #CALL q_ooed004()                                #呼叫開窗
           #
           #LET g_mmbo_m.mmbounit = g_qryparam.return1              #將開窗取得的值回傳到變數
           #
           #DISPLAY g_mmbo_m.mmbounit TO mmbounit              #顯示到畫面上
           #
           #CALL agct415_mmbounit_ref()
           #
           #NEXT FIELD mmbounit                          #返回原欄位
           #sakura---mark---end


            #END add-point
 
 
         #Ctrlp:input.c.mmbo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbo016
            #add-point:ON ACTION controlp INFIELD mmbo016 name="input.c.mmbo016"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmboacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmboacti
            #add-point:ON ACTION controlp INFIELD mmboacti name="input.c.mmboacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.mmbostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbostus
            #add-point:ON ACTION controlp INFIELD mmbostus name="input.c.mmbostus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_mmbo_m.mmbodocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_prog) RETURNING l_success,g_mmbo_m.mmbodocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_mmbo_m.mmbodocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD mmbodocno
               END IF
               LET g_mmbo_m.mmbounit = g_mmbo_m.mmbosite #sakura add
               #160707-00011#7 20160712 add by beckxie---S
               #如果新的編碼與舊的不一樣 應該做更新 
               IF g_mmbo_m_o.mmbodocno != g_mmbo_m.mmbodocno AND NOT cl_null(g_mmbo_m_o.mmbodocno) THEN
                  LET l_count_chk = 0
                  SELECT COUNT(*) INTO l_count_chk
                    FROM mmbol_t
                   WHERE mmbolent = g_enterprise
                     AND mmboldocno = g_mmbo_m_o.mmbodocno
                  IF l_count_chk > 0 THEN
                     UPDATE mmbol_t SET mmboldocno = g_mmbo_m.mmbodocno
                      WHERE mmbolent = g_enterprise
                        AND mmboldocno = g_mmbo_m_o.mmbodocno
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = 'upd mmbol_t'
                        LET g_errparam.code   = SQLCA.sqlcode
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
               
                        CALL s_transaction_end('N','0')
                        NEXT FIELD CURRENT
                     END IF
                     LET g_master_multi_table_t.mmboldocno = g_mmbo_m.mmbodocno
                  END IF 
               END IF
               #160707-00011#7 20160712 add by beckxie---E 
               #160627-00005#1 160627 by sakura add(S)
               IF g_mmbo_m.mmbo000 = 'I' THEN
                  CALL s_aooi390_get_auto_no('37',g_mmbo_m.mmbo001) RETURNING l_success,g_mmbo_m.mmbo001
                  
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi390_oofi_upd('37',g_mmbo_m.mmbo001) RETURNING l_success                  
               END IF
               #160627-00005#1 160627 by sakura add(E)               
               #end add-point
               
               INSERT INTO mmbo_t (mmboent,mmbosite,mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001, 
                   mmbo002,mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmbounit,mmbo016,mmboacti,mmbostus, 
                   mmboownid,mmboowndp,mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt) 
 
               VALUES (g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000, 
                   g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005, 
                   g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
                   g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp, 
                   g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt, 
                   g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_mmbo_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmbo_m.mmbodocno = g_master_multi_table_t.mmboldocno AND
         g_mmbo_m.mmbol002 = g_master_multi_table_t.mmbol002 AND 
         g_mmbo_m.mmbol003 = g_master_multi_table_t.mmbol003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmbolent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmbo_m.mmbodocno
            LET l_field_keys[02] = 'mmboldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmboldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbol001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmbo_m.mmbol002
            LET l_fields[01] = 'mmbol002'
            LET l_vars[02] = g_mmbo_m.mmbol003
            LET l_fields[02] = 'mmbol003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbol_t')
         END IF 
 
               
               #add-point:單頭新增後 name="input.head.a_insert"
               IF g_mmbo_m.mmbo000 = 'U' THEN
                     CALL agct415_detail_init()
                  END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL agct415_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL agct415_b_fill()
                  CALL agct415_b_fill2('0')
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
               CALL agct415_mmbo_t_mask_restore('restore_mask_o')
               
               UPDATE mmbo_t SET (mmbosite,mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002, 
                   mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmbounit,mmbo016,mmboacti,mmbostus,mmboownid, 
                   mmboowndp,mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt) = (g_mmbo_m.mmbosite, 
                   g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
                   g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008, 
                   g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit,g_mmbo_m.mmbo016,g_mmbo_m.mmboacti, 
                   g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtdp, 
                   g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfdt) 
 
                WHERE mmboent = g_enterprise AND mmbodocno = g_mmbodocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "mmbo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmbo_m.mmbodocno = g_master_multi_table_t.mmboldocno AND
         g_mmbo_m.mmbol002 = g_master_multi_table_t.mmbol002 AND 
         g_mmbo_m.mmbol003 = g_master_multi_table_t.mmbol003  THEN
         ELSE 
            LET l_var_keys[01] = g_enterprise
            LET l_field_keys[01] = 'mmbolent'
            LET l_var_keys_bak[01] = g_enterprise
            LET l_var_keys[02] = g_mmbo_m.mmbodocno
            LET l_field_keys[02] = 'mmboldocno'
            LET l_var_keys_bak[02] = g_master_multi_table_t.mmboldocno
            LET l_var_keys[03] = g_dlang
            LET l_field_keys[03] = 'mmbol001'
            LET l_var_keys_bak[03] = g_dlang
            LET l_vars[01] = g_mmbo_m.mmbol002
            LET l_fields[01] = 'mmbol002'
            LET l_vars[02] = g_mmbo_m.mmbol003
            LET l_fields[02] = 'mmbol003'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbol_t')
         END IF 
 
               
               #將遮罩欄位進行遮蔽
               CALL agct415_mmbo_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               IF NOT agct415_mmbo007_chk('u') AND g_mmbo_m.mmbo007 != g_mmbo_m_t.mmbo007 THEN
                  DELETE FROM mmdd_t WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno
                  DELETE FROM mmbs_t WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
               END IF
               IF NOT agct415_mmbo008_chk('u') AND g_mmbo_m.mmbo008 != g_mmbo_m_t.mmbo008 THEN
                  DELETE FROM mmbq_t WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
                  CALL agct415_b_fill()
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="agct415.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmdd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmdd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct415_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_mmdd_d.getLength()
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
            OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct415_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmdd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmdd_d[l_ac].mmdd001 IS NOT NULL
               AND g_mmdd_d[l_ac].mmdd003 IS NOT NULL
               AND g_mmdd_d[l_ac].mmdd004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmdd_d_t.* = g_mmdd_d[l_ac].*  #BACKUP
               LET g_mmdd_d_o.* = g_mmdd_d[l_ac].*  #BACKUP
               CALL agct415_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL agct415_set_no_entry_b(l_cmd)
               IF NOT agct415_lock_b("mmdd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct415_bcl INTO g_mmdd_d[l_ac].mmddsite,g_mmdd_d[l_ac].mmddunit,g_mmdd_d[l_ac].mmdd001, 
                      g_mmdd_d[l_ac].mmdd002,g_mmdd_d[l_ac].mmdd003,g_mmdd_d[l_ac].mmdd004,g_mmdd_d[l_ac].mmddacti 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_mmdd_d_t.mmdd001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmdd_d_mask_o[l_ac].* =  g_mmdd_d[l_ac].*
                  CALL agct415_mmdd_t_mask()
                  LET g_mmdd_d_mask_n[l_ac].* =  g_mmdd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct415_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
                        IF g_mmbo_m.mmbo007 = '0' AND l_ac > 1 THEN
               NEXT FIELD mmbs004
            END IF
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
            INITIALIZE g_mmdd_d[l_ac].* TO NULL 
            INITIALIZE g_mmdd_d_t.* TO NULL 
            INITIALIZE g_mmdd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_mmdd_d_t.* = g_mmdd_d[l_ac].*     #新輸入資料
            LET g_mmdd_d_o.* = g_mmdd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct415_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL agct415_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmdd_d[li_reproduce_target].* = g_mmdd_d[li_reproduce].*
 
               LET g_mmdd_d[li_reproduce_target].mmdd001 = NULL
               LET g_mmdd_d[li_reproduce_target].mmdd003 = NULL
               LET g_mmdd_d[li_reproduce_target].mmdd004 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_mmdd_d[l_ac].mmddsite = g_mmbo_m.mmbosite
            LET g_mmdd_d[l_ac].mmddunit = g_mmbo_m.mmbounit
            LET g_mmdd_d[l_ac].mmdd001  = g_mmbo_m.mmbo001
            LET g_mmdd_d[l_ac].mmdd002  = g_mmbo_m.mmbo005
            LET g_mmdd_d[l_ac].mmdd003  = g_mmbo_m.mmbo007
            IF g_mmbo_m.mmbo007 = '0' THEN
               LET g_mmdd_d[l_ac].mmdd004  = 'ALL'
            END IF
            LET g_mmdd_d[l_ac].mmddacti = 'Y' 
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmdd_t 
             WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno
 
               AND mmdd001 = g_mmdd_d[l_ac].mmdd001
               AND mmdd003 = g_mmdd_d[l_ac].mmdd003
               AND mmdd004 = g_mmdd_d[l_ac].mmdd004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmdd_d[g_detail_idx].mmdd001
               LET gs_keys[3] = g_mmdd_d[g_detail_idx].mmdd003
               LET gs_keys[4] = g_mmdd_d[g_detail_idx].mmdd004
               CALL agct415_insert_b('mmdd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_mmdd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct415_b_fill()
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
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmbo_m.mmbodocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd001
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd003
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd004
 
            
               #刪除同層單身
               IF NOT agct415_delete_b('mmdd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct415_key_delete_b(gs_keys,'mmdd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE agct415_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  
               #end add-point
               LET l_count = g_mmdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
            
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmdd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddsite
            #add-point:BEFORE FIELD mmddsite name="input.b.page1.mmddsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddsite
            
            #add-point:AFTER FIELD mmddsite name="input.a.page1.mmddsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmddsite
            #add-point:ON CHANGE mmddsite name="input.g.page1.mmddsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddunit
            #add-point:BEFORE FIELD mmddunit name="input.b.page1.mmddunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddunit
            
            #add-point:AFTER FIELD mmddunit name="input.a.page1.mmddunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmddunit
            #add-point:ON CHANGE mmddunit name="input.g.page1.mmddunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd001
            #add-point:BEFORE FIELD mmdd001 name="input.b.page1.mmdd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd001
            
            #add-point:AFTER FIELD mmdd001 name="input.a.page1.mmdd001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd001 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd003 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd_d[g_detail_idx].mmdd001 != g_mmdd_d_t.mmdd001 OR g_mmdd_d[g_detail_idx].mmdd003 != g_mmdd_d_t.mmdd003 OR g_mmdd_d[g_detail_idx].mmdd004 != g_mmdd_d_t.mmdd004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdd_t WHERE "||"mmddent = '" ||g_enterprise|| "' AND "||"mmdddocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdd001 = '"||g_mmdd_d[g_detail_idx].mmdd001 ||"' AND "|| "mmdd003 = '"||g_mmdd_d[g_detail_idx].mmdd003 ||"' AND "|| "mmdd004 = '"||g_mmdd_d[g_detail_idx].mmdd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdd001
            #add-point:ON CHANGE mmdd001 name="input.g.page1.mmdd001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd002
            #add-point:BEFORE FIELD mmdd002 name="input.b.page1.mmdd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd002
            
            #add-point:AFTER FIELD mmdd002 name="input.a.page1.mmdd002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdd002
            #add-point:ON CHANGE mmdd002 name="input.g.page1.mmdd002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd003
            #add-point:BEFORE FIELD mmdd003 name="input.b.page1.mmdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd003
            
            #add-point:AFTER FIELD mmdd003 name="input.a.page1.mmdd003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd001 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd003 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd_d[g_detail_idx].mmdd001 != g_mmdd_d_t.mmdd001 OR g_mmdd_d[g_detail_idx].mmdd003 != g_mmdd_d_t.mmdd003 OR g_mmdd_d[g_detail_idx].mmdd004 != g_mmdd_d_t.mmdd004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdd_t WHERE "||"mmddent = '" ||g_enterprise|| "' AND "||"mmdddocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdd001 = '"||g_mmdd_d[g_detail_idx].mmdd001 ||"' AND "|| "mmdd003 = '"||g_mmdd_d[g_detail_idx].mmdd003 ||"' AND "|| "mmdd004 = '"||g_mmdd_d[g_detail_idx].mmdd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdd003
            #add-point:ON CHANGE mmdd003 name="input.g.page1.mmdd003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdd004
            
            #add-point:AFTER FIELD mmdd004 name="input.a.page1.mmdd004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd001 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd003 IS NOT NULL AND g_mmdd_d[g_detail_idx].mmdd004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd_d[g_detail_idx].mmdd001 != g_mmdd_d_t.mmdd001 OR g_mmdd_d[g_detail_idx].mmdd003 != g_mmdd_d_t.mmdd003 OR g_mmdd_d[g_detail_idx].mmdd004 != g_mmdd_d_t.mmdd004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdd_t WHERE "||"mmddent = '" ||g_enterprise|| "' AND "||"mmdddocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdd001 = '"||g_mmdd_d[g_detail_idx].mmdd001 ||"' AND "|| "mmdd003 = '"||g_mmdd_d[g_detail_idx].mmdd003 ||"' AND "|| "mmdd004 = '"||g_mmdd_d[g_detail_idx].mmdd004 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            LET g_mmdd_d[l_ac].mmdd004_desc = ''
            DISPLAY BY NAME g_mmdd_d[l_ac].mmdd004_desc
           IF  NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmdd_d[l_ac].mmdd001) AND NOT cl_null(g_mmdd_d[l_ac].mmdd003) AND NOT cl_null(g_mmdd_d[l_ac].mmdd004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd_d[l_ac].mmdd001 != g_mmdd_d_t.mmdd001 OR g_mmdd_d[l_ac].mmdd003 != g_mmdd_d_t.mmdd003 OR g_mmdd_d[l_ac].mmdd004 != g_mmdd_d_t.mmdd004))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdd_t WHERE "||"mmddent = '" ||g_enterprise|| "' AND "||"mmdddocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdd001 = '"||g_mmdd_d[l_ac].mmdd001 ||"' AND "|| "mmdd003 = '"||g_mmdd_d[l_ac].mmdd003 ||"' AND "|| "mmdd004 = '"||g_mmdd_d[l_ac].mmdd004 ||"'",'std-00004',0) THEN 
                     LET g_mmdd_d[l_ac].mmdd004 = g_mmdd_d_t.mmdd004
                     DISPLAY BY NAME g_mmdd_d[l_ac].mmdd004
                     CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc  
                     NEXT FIELD CURRENT
                  END IF
             
                  CALL s_aint800_01_check(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'') RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc
                  IF NOT l_flag THEN    
                     LET g_mmdd_d[l_ac].mmdd004 = g_mmdd_d_t.mmdd004
                     DISPLAY BY NAME g_mmdd_d[l_ac].mmdd004
                     CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc  
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
              
                CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc              
            END IF
            DISPLAY BY NAME g_mmdd_d[l_ac].mmdd004
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdd004
            #add-point:BEFORE FIELD mmdd004 name="input.b.page1.mmdd004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdd004
            #add-point:ON CHANGE mmdd004 name="input.g.page1.mmdd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmddacti
            #add-point:BEFORE FIELD mmddacti name="input.b.page1.mmddacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmddacti
            
            #add-point:AFTER FIELD mmddacti name="input.a.page1.mmddacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmddacti
            #add-point:ON CHANGE mmddacti name="input.g.page1.mmddacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.mmddsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddsite
            #add-point:ON ACTION controlp INFIELD mmddsite name="input.c.page1.mmddsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmddunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddunit
            #add-point:ON ACTION controlp INFIELD mmddunit name="input.c.page1.mmddunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdd001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd001
            #add-point:ON ACTION controlp INFIELD mmdd001 name="input.c.page1.mmdd001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd002
            #add-point:ON ACTION controlp INFIELD mmdd002 name="input.c.page1.mmdd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd003
            #add-point:ON ACTION controlp INFIELD mmdd003 name="input.c.page1.mmdd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmdd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdd004
            #add-point:ON ACTION controlp INFIELD mmdd004 name="input.c.page1.mmdd004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'                 #150521-00027#2
            CALL s_aint800_01_controlp(g_mmbo_m.mmbo007,'',g_mmbo_m.mmbosite) RETURNING l_flag
            LET g_mmdd_d[l_ac].mmdd004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmbp004     #顯示到畫面上
        
            CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc
            NEXT FIELD mmdd004                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.mmddacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmddacti
            #add-point:ON ACTION controlp INFIELD mmddacti name="input.c.page1.mmddacti"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_mmdd_d[l_ac].* = g_mmdd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_mmdd_d[l_ac].mmdd001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmdd_d[l_ac].* = g_mmdd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL agct415_mmdd_t_mask_restore('restore_mask_o')
      
               UPDATE mmdd_t SET (mmdddocno,mmddsite,mmddunit,mmdd001,mmdd002,mmdd003,mmdd004,mmddacti) = (g_mmbo_m.mmbodocno, 
                   g_mmdd_d[l_ac].mmddsite,g_mmdd_d[l_ac].mmddunit,g_mmdd_d[l_ac].mmdd001,g_mmdd_d[l_ac].mmdd002, 
                   g_mmdd_d[l_ac].mmdd003,g_mmdd_d[l_ac].mmdd004,g_mmdd_d[l_ac].mmddacti)
                WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno 
 
                  AND mmdd001 = g_mmdd_d_t.mmdd001 #項次   
                  AND mmdd003 = g_mmdd_d_t.mmdd003  
                  AND mmdd004 = g_mmdd_d_t.mmdd004  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmdd_d[l_ac].* = g_mmdd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmdd_d[l_ac].* = g_mmdd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmdd_d[g_detail_idx].mmdd001
               LET gs_keys_bak[2] = g_mmdd_d_t.mmdd001
               LET gs_keys[3] = g_mmdd_d[g_detail_idx].mmdd003
               LET gs_keys_bak[3] = g_mmdd_d_t.mmdd003
               LET gs_keys[4] = g_mmdd_d[g_detail_idx].mmdd004
               LET gs_keys_bak[4] = g_mmdd_d_t.mmdd004
               CALL agct415_update_b('mmdd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL agct415_mmdd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_mmdd_d[g_detail_idx].mmdd001 = g_mmdd_d_t.mmdd001 
                  AND g_mmdd_d[g_detail_idx].mmdd003 = g_mmdd_d_t.mmdd003 
                  AND g_mmdd_d[g_detail_idx].mmdd004 = g_mmdd_d_t.mmdd004 
 
                  ) THEN
                  LET gs_keys[01] = g_mmbo_m.mmbodocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd001
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd003
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd_d_t.mmdd004
 
                  CALL agct415_key_update_b(gs_keys,'mmdd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL agct415_unlock_b("mmdd_t","'1'")
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
               LET g_mmdd_d[li_reproduce_target].* = g_mmdd_d[li_reproduce].*
 
               LET g_mmdd_d[li_reproduce_target].mmdd001 = NULL
               LET g_mmdd_d[li_reproduce_target].mmdd003 = NULL
               LET g_mmdd_d[li_reproduce_target].mmdd004 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmdd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmdd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmdd2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmdd2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct415_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmdd2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
                        LET g_current_page = 2
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmdd2_d[l_ac].* TO NULL 
            INITIALIZE g_mmdd2_d_t.* TO NULL 
            INITIALIZE g_mmdd2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_mmdd2_d[l_ac].mmbs005 = "N"
      LET g_mmdd2_d[l_ac].mmbsacti = "Y"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_mmdd2_d_t.* = g_mmdd2_d[l_ac].*     #新輸入資料
            LET g_mmdd2_d_o.* = g_mmdd2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct415_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL agct415_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmdd2_d[li_reproduce_target].* = g_mmdd2_d[li_reproduce].*
 
               LET g_mmdd2_d[li_reproduce_target].mmbs004 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
                        LET g_mmdd2_d[l_ac].mmbssite = g_mmbo_m.mmbosite
            LET g_mmdd2_d[l_ac].mmbsunit = g_mmbo_m.mmbounit
            LET g_mmdd2_d[l_ac].mmbs001  = g_mmbo_m.mmbo001
            LET g_mmdd2_d[l_ac].mmbs002  = g_mmbo_m.mmbo007
            LET g_mmdd2_d[l_ac].mmbs003  = g_mmbo_m.mmbo005
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
            OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct415_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmdd2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmdd2_d[l_ac].mmbs004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmdd2_d_t.* = g_mmdd2_d[l_ac].*  #BACKUP
               LET g_mmdd2_d_o.* = g_mmdd2_d[l_ac].*  #BACKUP
               CALL agct415_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL agct415_set_no_entry_b(l_cmd)
               IF NOT agct415_lock_b("mmbs_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct415_bcl2 INTO g_mmdd2_d[l_ac].mmbssite,g_mmdd2_d[l_ac].mmbsunit,g_mmdd2_d[l_ac].mmbs001, 
                      g_mmdd2_d[l_ac].mmbs002,g_mmdd2_d[l_ac].mmbs003,g_mmdd2_d[l_ac].mmbs004,g_mmdd2_d[l_ac].mmbs005, 
                      g_mmdd2_d[l_ac].mmbsacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmdd2_d_mask_o[l_ac].* =  g_mmdd2_d[l_ac].*
                  CALL agct415_mmbs_t_mask()
                  LET g_mmdd2_d_mask_n[l_ac].* =  g_mmdd2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct415_show()
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
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmbo_m.mmbodocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd2_d_t.mmbs004
            
               #刪除同層單身
               IF NOT agct415_delete_b('mmbs_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct415_key_delete_b(gs_keys,'mmbs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agct415_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                  
               #end add-point
               LET l_count = g_mmdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmdd2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmbs_t 
             WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
               AND mmbs004 = g_mmdd2_d[l_ac].mmbs004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmdd2_d[g_detail_idx].mmbs004
               CALL agct415_insert_b('mmbs_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmdd_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct415_b_fill()
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
               LET g_mmdd2_d[l_ac].* = g_mmdd2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmdd2_d[l_ac].* = g_mmdd2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL agct415_mmbs_t_mask_restore('restore_mask_o')
                              
               UPDATE mmbs_t SET (mmbsdocno,mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005, 
                   mmbsacti) = (g_mmbo_m.mmbodocno,g_mmdd2_d[l_ac].mmbssite,g_mmdd2_d[l_ac].mmbsunit, 
                   g_mmdd2_d[l_ac].mmbs001,g_mmdd2_d[l_ac].mmbs002,g_mmdd2_d[l_ac].mmbs003,g_mmdd2_d[l_ac].mmbs004, 
                   g_mmdd2_d[l_ac].mmbs005,g_mmdd2_d[l_ac].mmbsacti) #自訂欄位頁簽
                WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
                  AND mmbs004 = g_mmdd2_d_t.mmbs004 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmdd2_d[l_ac].* = g_mmdd2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmdd2_d[l_ac].* = g_mmdd2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmdd2_d[g_detail_idx].mmbs004
               LET gs_keys_bak[2] = g_mmdd2_d_t.mmbs004
               CALL agct415_update_b('mmbs_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agct415_mmbs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmdd2_d[g_detail_idx].mmbs004 = g_mmdd2_d_t.mmbs004 
                  ) THEN
                  LET gs_keys[01] = g_mmbo_m.mmbodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd2_d_t.mmbs004
                  CALL agct415_key_update_b(gs_keys,'mmbs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd2_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbssite
            #add-point:BEFORE FIELD mmbssite name="input.b.page2.mmbssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbssite
            
            #add-point:AFTER FIELD mmbssite name="input.a.page2.mmbssite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbssite
            #add-point:ON CHANGE mmbssite name="input.g.page2.mmbssite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbsunit
            #add-point:BEFORE FIELD mmbsunit name="input.b.page2.mmbsunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbsunit
            
            #add-point:AFTER FIELD mmbsunit name="input.a.page2.mmbsunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbsunit
            #add-point:ON CHANGE mmbsunit name="input.g.page2.mmbsunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs001
            #add-point:BEFORE FIELD mmbs001 name="input.b.page2.mmbs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs001
            
            #add-point:AFTER FIELD mmbs001 name="input.a.page2.mmbs001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbs001
            #add-point:ON CHANGE mmbs001 name="input.g.page2.mmbs001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs002
            #add-point:BEFORE FIELD mmbs002 name="input.b.page2.mmbs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs002
            
            #add-point:AFTER FIELD mmbs002 name="input.a.page2.mmbs002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbs002
            #add-point:ON CHANGE mmbs002 name="input.g.page2.mmbs002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs003
            #add-point:BEFORE FIELD mmbs003 name="input.b.page2.mmbs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs003
            
            #add-point:AFTER FIELD mmbs003 name="input.a.page2.mmbs003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbs003
            #add-point:ON CHANGE mmbs003 name="input.g.page2.mmbs003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs004
            
            #add-point:AFTER FIELD mmbs004 name="input.a.page2.mmbs004"
            LET g_mmdd2_d[l_ac].mmbs004_desc = ''
            DISPLAY BY NAME g_mmdd2_d[l_ac].mmbs004_desc
            #此段落由子樣板a05產生
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd2_d[g_detail_idx].mmbs004 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd2_d[g_detail_idx].mmbs004 != g_mmdd2_d_t.mmbs004)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbs_t WHERE "||"mmbsent = '" ||g_enterprise|| "' AND "||"mmbsdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbs004 = '"||g_mmdd2_d[g_detail_idx].mmbs004 ||"'",'std-00004',0) THEN 
                     LET g_mmdd2_d[l_ac].mmbs004 = g_mmdd2_d_t.mmbs004
                     DISPLAY BY NAME g_mmdd2_d[l_ac].mmbs004
                     CALL agct415_mmbs004_ref()
                     NEXT FIELD CURRENT
                  END IF
                  #161024-00025#1--dongsz mark--s
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_errshow = '1'
#                  LET g_chkparam.arg1 = g_mmdd2_d[l_ac].mmbs004
#                  LET g_chkparam.arg2 = '8'
#                 #LET g_chkparam.arg3 = g_mmbo_m.mmbounit #sakura mark
#                  LET g_chkparam.arg3 = g_mmbo_m.mmbosite #sakura add
#                  IF NOT cl_chk_exist("v_ooed004") THEN
#                     LET g_mmdd2_d[l_ac].mmbs004 = g_mmdd2_d_t.mmbs004
#                     CALL agct415_mmbs004_ref()
#                     NEXT FIELD CURRENT
#                  END IF
                  #161024-00025#1--dongsz mark--e
                  #161024-00025#1--dongsz add--s
                  IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
                     CALL s_aooi500_chk(g_prog,'mmbs004',g_mmdd2_d[l_ac].mmbs004,g_mmbo_m.mmbosite)
                        RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ""
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        LET g_mmdd2_d[l_ac].mmbs004 = g_mmdd2_d_t.mmbs004
                        CALL agct415_mmbs004_ref()
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = '1'
                     LET g_chkparam.arg1 = g_mmdd2_d[l_ac].mmbs004
                     LET g_chkparam.arg2 = '8'
                    #LET g_chkparam.arg3 = g_mmbo_m.mmbounit #sakura mark
                     LET g_chkparam.arg3 = g_mmbo_m.mmbosite #sakura add
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        LET g_mmdd2_d[l_ac].mmbs004 = g_mmdd2_d_t.mmbs004
                        CALL agct415_mmbs004_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #161024-00025#1--dongsz add--e
               END IF
            END IF
            CALL agct415_mmbs004_ref()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs004
            #add-point:BEFORE FIELD mmbs004 name="input.b.page2.mmbs004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbs004
            #add-point:ON CHANGE mmbs004 name="input.g.page2.mmbs004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbs005
            #add-point:BEFORE FIELD mmbs005 name="input.b.page2.mmbs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbs005
            
            #add-point:AFTER FIELD mmbs005 name="input.a.page2.mmbs005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbs005
            #add-point:ON CHANGE mmbs005 name="input.g.page2.mmbs005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmbsacti
            #add-point:BEFORE FIELD mmbsacti name="input.b.page2.mmbsacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmbsacti
            
            #add-point:AFTER FIELD mmbsacti name="input.a.page2.mmbsacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmbsacti
            #add-point:ON CHANGE mmbsacti name="input.g.page2.mmbsacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.mmbssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbssite
            #add-point:ON ACTION controlp INFIELD mmbssite name="input.c.page2.mmbssite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbsunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbsunit
            #add-point:ON ACTION controlp INFIELD mmbsunit name="input.c.page2.mmbsunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs001
            #add-point:ON ACTION controlp INFIELD mmbs001 name="input.c.page2.mmbs001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbs002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs002
            #add-point:ON ACTION controlp INFIELD mmbs002 name="input.c.page2.mmbs002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbs003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs003
            #add-point:ON ACTION controlp INFIELD mmbs003 name="input.c.page2.mmbs003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbs004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs004
            #add-point:ON ACTION controlp INFIELD mmbs004 name="input.c.page2.mmbs004"
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmdd2_d[l_ac].mmbs004             #給予default值

            #161024-00025#1--dongsz mark--s
#            #給予arg
#           #LET g_qryparam.arg1 = g_mmbo_m.mmbounit #sakura mark
#            LET g_qryparam.arg1 = g_mmbo_m.mmbosite #sakura add
#            LET g_qryparam.arg2 = '8'
#
#            CALL q_ooed004()                                             #呼叫開窗
            #161024-00025#1--dongsz mark--e
            #161024-00025#1--dongsz add--s
            #判断aooi500是否有设定
            IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbs004',g_mmbo_m.mmbosite,'i') 
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_mmbo_m.mmbosite   #sakura add
               LET g_qryparam.arg2 = '8'
               
               CALL q_ooed004() 
            END IF
            #161024-00025#1--dongsz add--e

            LET g_mmdd2_d[l_ac].mmbs004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmdd2_d[l_ac].mmbs004 TO mmbs004              #顯示到畫面上
            
            CALL agct415_mmbs004_ref()

            NEXT FIELD mmbs004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbs005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbs005
            #add-point:ON ACTION controlp INFIELD mmbs005 name="input.c.page2.mmbs005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.mmbsacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmbsacti
            #add-point:ON ACTION controlp INFIELD mmbsacti name="input.c.page2.mmbsacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmdd2_d[l_ac].* = g_mmdd2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agct415_unlock_b("mmbs_t","'2'")
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
               LET g_mmdd2_d[li_reproduce_target].* = g_mmdd2_d[li_reproduce].*
 
               LET g_mmdd2_d[li_reproduce_target].mmbs004 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmdd2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmdd2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmdd3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmdd3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct415_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmdd3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
                        LET g_current_page = 3
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmdd3_d[l_ac].* TO NULL 
            INITIALIZE g_mmdd3_d_t.* TO NULL 
            INITIALIZE g_mmdd3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_mmdd3_d[l_ac].mmck003 = "1"
      LET g_mmdd3_d[l_ac].mmckacti = "Y"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_mmdd3_d_t.* = g_mmdd3_d[l_ac].*     #新輸入資料
            LET g_mmdd3_d_o.* = g_mmdd3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct415_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL agct415_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmdd3_d[li_reproduce_target].* = g_mmdd3_d[li_reproduce].*
 
               LET g_mmdd3_d[li_reproduce_target].mmck003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
                        LET g_mmdd3_d[l_ac].mmcksite = g_mmbo_m.mmbosite
            LET g_mmdd3_d[l_ac].mmckunit = g_mmbo_m.mmbounit
            LET g_mmdd3_d[l_ac].mmck001  = g_mmbo_m.mmbo001
            LET g_mmdd3_d[l_ac].mmck002  = g_mmbo_m.mmbo005
            SELECT NVL(MAX(mmck003)+1,1) INTO g_mmdd3_d[l_ac].mmck003 FROM mmck_t
             WHERE mmckent = g_enterprise AND mmckdocno = g_mmbo_m.mmbodocno
            
            #LET g_mmdd3_d[l_ac].mmck004  = g_mmbo_m.mmbo014
            #LET g_mmdd3_d[l_ac].mmck005  = g_mmbo_m.mmbo015
            LET g_mmdd3_d[l_ac].mmckacti = 'Y'
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
            OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct415_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmdd3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmdd3_d[l_ac].mmck003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmdd3_d_t.* = g_mmdd3_d[l_ac].*  #BACKUP
               LET g_mmdd3_d_o.* = g_mmdd3_d[l_ac].*  #BACKUP
               CALL agct415_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL agct415_set_no_entry_b(l_cmd)
               IF NOT agct415_lock_b("mmck_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct415_bcl3 INTO g_mmdd3_d[l_ac].mmcksite,g_mmdd3_d[l_ac].mmckunit,g_mmdd3_d[l_ac].mmck001, 
                      g_mmdd3_d[l_ac].mmck002,g_mmdd3_d[l_ac].mmck003,g_mmdd3_d[l_ac].mmck004,g_mmdd3_d[l_ac].mmck005, 
                      g_mmdd3_d[l_ac].mmck006,g_mmdd3_d[l_ac].mmck007,g_mmdd3_d[l_ac].mmck008,g_mmdd3_d[l_ac].mmck009, 
                      g_mmdd3_d[l_ac].mmckacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmdd3_d_mask_o[l_ac].* =  g_mmdd3_d[l_ac].*
                  CALL agct415_mmck_t_mask()
                  LET g_mmdd3_d_mask_n[l_ac].* =  g_mmdd3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct415_show()
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
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmbo_m.mmbodocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd3_d_t.mmck003
            
               #刪除同層單身
               IF NOT agct415_delete_b('mmck_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct415_key_delete_b(gs_keys,'mmck_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agct415_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                  
               #end add-point
               LET l_count = g_mmdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
            
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmdd3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmck_t 
             WHERE mmckent = g_enterprise AND mmckdocno = g_mmbo_m.mmbodocno
               AND mmck003 = g_mmdd3_d[l_ac].mmck003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmdd3_d[g_detail_idx].mmck003
               CALL agct415_insert_b('mmck_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmdd_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct415_b_fill()
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
               LET g_mmdd3_d[l_ac].* = g_mmdd3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmdd3_d[l_ac].* = g_mmdd3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL agct415_mmck_t_mask_restore('restore_mask_o')
                              
               UPDATE mmck_t SET (mmckdocno,mmcksite,mmckunit,mmck001,mmck002,mmck003,mmck004,mmck005, 
                   mmck006,mmck007,mmck008,mmck009,mmckacti) = (g_mmbo_m.mmbodocno,g_mmdd3_d[l_ac].mmcksite, 
                   g_mmdd3_d[l_ac].mmckunit,g_mmdd3_d[l_ac].mmck001,g_mmdd3_d[l_ac].mmck002,g_mmdd3_d[l_ac].mmck003, 
                   g_mmdd3_d[l_ac].mmck004,g_mmdd3_d[l_ac].mmck005,g_mmdd3_d[l_ac].mmck006,g_mmdd3_d[l_ac].mmck007, 
                   g_mmdd3_d[l_ac].mmck008,g_mmdd3_d[l_ac].mmck009,g_mmdd3_d[l_ac].mmckacti) #自訂欄位頁簽 
 
                WHERE mmckent = g_enterprise AND mmckdocno = g_mmbo_m.mmbodocno
                  AND mmck003 = g_mmdd3_d_t.mmck003 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmdd3_d[l_ac].* = g_mmdd3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmck_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmdd3_d[l_ac].* = g_mmdd3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmdd3_d[g_detail_idx].mmck003
               LET gs_keys_bak[2] = g_mmdd3_d_t.mmck003
               CALL agct415_update_b('mmck_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agct415_mmck_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmdd3_d[g_detail_idx].mmck003 = g_mmdd3_d_t.mmck003 
                  ) THEN
                  LET gs_keys[01] = g_mmbo_m.mmbodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd3_d_t.mmck003
                  CALL agct415_key_update_b(gs_keys,'mmck_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd3_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
                          
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmcksite
            #add-point:BEFORE FIELD mmcksite name="input.b.page3.mmcksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmcksite
            
            #add-point:AFTER FIELD mmcksite name="input.a.page3.mmcksite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmcksite
            #add-point:ON CHANGE mmcksite name="input.g.page3.mmcksite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmckunit
            #add-point:BEFORE FIELD mmckunit name="input.b.page3.mmckunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmckunit
            
            #add-point:AFTER FIELD mmckunit name="input.a.page3.mmckunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmckunit
            #add-point:ON CHANGE mmckunit name="input.g.page3.mmckunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck001
            #add-point:BEFORE FIELD mmck001 name="input.b.page3.mmck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck001
            
            #add-point:AFTER FIELD mmck001 name="input.a.page3.mmck001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck001
            #add-point:ON CHANGE mmck001 name="input.g.page3.mmck001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck002
            #add-point:BEFORE FIELD mmck002 name="input.b.page3.mmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck002
            
            #add-point:AFTER FIELD mmck002 name="input.a.page3.mmck002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck002
            #add-point:ON CHANGE mmck002 name="input.g.page3.mmck002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck003
            #add-point:BEFORE FIELD mmck003 name="input.b.page3.mmck003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck003
            
            #add-point:AFTER FIELD mmck003 name="input.a.page3.mmck003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd3_d[g_detail_idx].mmck003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd3_d[g_detail_idx].mmck003 != g_mmdd3_d_t.mmck003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmck_t WHERE "||"mmckent = '" ||g_enterprise|| "' AND "||"mmckdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmck003 = '"||g_mmdd3_d[g_detail_idx].mmck003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck003
            #add-point:ON CHANGE mmck003 name="input.g.page3.mmck003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck004
            #add-point:BEFORE FIELD mmck004 name="input.b.page3.mmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck004
            
            #add-point:AFTER FIELD mmck004 name="input.a.page3.mmck004"
            IF NOT cl_null(g_mmdd3_d[l_ac].mmck004) THEN
               CALL agct415_mmck004_chk(g_mmdd3_d[l_ac].mmck004)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmdd3_d[l_ac].mmck004
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmdd3_d[l_ac].mmck004 = g_mmdd3_d_t.mmck004
                  DISPLAY BY NAME g_mmdd3_d[l_ac].mmck004
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck004
            #add-point:ON CHANGE mmck004 name="input.g.page3.mmck004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck005
            #add-point:BEFORE FIELD mmck005 name="input.b.page3.mmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck005
            
            #add-point:AFTER FIELD mmck005 name="input.a.page3.mmck005"
             IF NOT cl_null(g_mmdd3_d[l_ac].mmck005) THEN
               CALL agct415_mmck004_chk(g_mmdd3_d[l_ac].mmck005)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_mmdd3_d[l_ac].mmck005
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmdd3_d[l_ac].mmck005 = g_mmdd3_d_t.mmck005
                  DISPLAY BY NAME g_mmdd3_d[l_ac].mmck005
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck005
            #add-point:ON CHANGE mmck005 name="input.g.page3.mmck005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck006
            #add-point:BEFORE FIELD mmck006 name="input.b.page3.mmck006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck006
            
            #add-point:AFTER FIELD mmck006 name="input.a.page3.mmck006"
           IF NOT cl_null(g_mmdd3_d[l_ac].mmck006) THEN
               IF NOT cl_null(g_mmdd3_d[l_ac].mmck007) THEN
                  IF g_mmdd3_d[l_ac].mmck006 > g_mmdd3_d[l_ac].mmck007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00093'
                     LET g_errparam.extend = g_mmdd3_d[l_ac].mmck006
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 #
                     LET g_mmdd3_d[l_ac].mmck006 = g_mmdd3_d_t.mmck006
                     DISPLAY BY NAME g_mmdd3_d[l_ac].mmck006
                     NEXT FIELD mmck006
                  END IF
               END IF
            END IF
            CALL agct415_set_entry_b(p_cmd)
            CALL agct415_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck006
            #add-point:ON CHANGE mmck006 name="input.g.page3.mmck006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck007
            #add-point:BEFORE FIELD mmck007 name="input.b.page3.mmck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck007
            
            #add-point:AFTER FIELD mmck007 name="input.a.page3.mmck007"
            IF NOT cl_null(g_mmdd3_d[l_ac].mmck007) THEN
               IF NOT cl_null(g_mmdd3_d[l_ac].mmck006) THEN
                  IF g_mmdd3_d[l_ac].mmck006 > g_mmdd3_d[l_ac].mmck007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00094'
                     LET g_errparam.extend = g_mmdd3_d[l_ac].mmck007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 #
                     LET g_mmdd3_d[l_ac].mmck007 = g_mmdd3_d_t.mmck007
                     DISPLAY BY NAME g_mmdd3_d[l_ac].mmck007
                     NEXT FIELD mmck007
                  END IF
               END IF
            END IF
            CALL agct415_set_entry_b(p_cmd)
            CALL agct415_set_no_entry_b(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck007
            #add-point:ON CHANGE mmck007 name="input.g.page3.mmck007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck008
            #add-point:BEFORE FIELD mmck008 name="input.b.page3.mmck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck008
            
            #add-point:AFTER FIELD mmck008 name="input.a.page3.mmck008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck008
            #add-point:ON CHANGE mmck008 name="input.g.page3.mmck008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmck009
            #add-point:BEFORE FIELD mmck009 name="input.b.page3.mmck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmck009
            
            #add-point:AFTER FIELD mmck009 name="input.a.page3.mmck009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmck009
            #add-point:ON CHANGE mmck009 name="input.g.page3.mmck009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmckacti
            #add-point:BEFORE FIELD mmckacti name="input.b.page3.mmckacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmckacti
            
            #add-point:AFTER FIELD mmckacti name="input.a.page3.mmckacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmckacti
            #add-point:ON CHANGE mmckacti name="input.g.page3.mmckacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.mmcksite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmcksite
            #add-point:ON ACTION controlp INFIELD mmcksite name="input.c.page3.mmcksite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmckunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmckunit
            #add-point:ON ACTION controlp INFIELD mmckunit name="input.c.page3.mmckunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck001
            #add-point:ON ACTION controlp INFIELD mmck001 name="input.c.page3.mmck001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck002
            #add-point:ON ACTION controlp INFIELD mmck002 name="input.c.page3.mmck002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck003
            #add-point:ON ACTION controlp INFIELD mmck003 name="input.c.page3.mmck003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck004
            #add-point:ON ACTION controlp INFIELD mmck004 name="input.c.page3.mmck004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck005
            #add-point:ON ACTION controlp INFIELD mmck005 name="input.c.page3.mmck005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck006
            #add-point:ON ACTION controlp INFIELD mmck006 name="input.c.page3.mmck006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck007
            #add-point:ON ACTION controlp INFIELD mmck007 name="input.c.page3.mmck007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck008
            #add-point:ON ACTION controlp INFIELD mmck008 name="input.c.page3.mmck008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmck009
            #add-point:ON ACTION controlp INFIELD mmck009 name="input.c.page3.mmck009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.mmckacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmckacti
            #add-point:ON ACTION controlp INFIELD mmckacti name="input.c.page3.mmckacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmdd3_d[l_ac].* = g_mmdd3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agct415_unlock_b("mmck_t","'3'")
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
               LET g_mmdd3_d[li_reproduce_target].* = g_mmdd3_d[li_reproduce].*
 
               LET g_mmdd3_d[li_reproduce_target].mmck003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmdd3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmdd3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_mmdd4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            IF g_mmbo_m.mmbo016 = 'N' THEN 
               NEXT FIELD mmddacti
            END IF 
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmdd4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL agct415_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_mmdd4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmdd4_d[l_ac].* TO NULL 
            INITIALIZE g_mmdd4_d_t.* TO NULL 
            INITIALIZE g_mmdd4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
                  LET g_mmdd4_d[l_ac].mmdg005 = "0"
      LET g_mmdd4_d[l_ac].mmdg007 = "0"
      LET g_mmdd4_d[l_ac].mmdgacti = "Y"
 
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            LET g_mmdd4_d[l_ac].mmdgsite = g_mmbo_m.mmbosite
            LET g_mmdd4_d[l_ac].mmdgunit = g_mmbo_m.mmbounit
            LET g_mmdd4_d[l_ac].mmdg001  = g_mmbo_m.mmbo001
            LET g_mmdd4_d[l_ac].mmdg002  = g_mmbo_m.mmbo005
            SELECT MAX(mmdg003)+1 INTO g_mmdd4_d[l_ac].mmdg003
              FROM mmdg_t 
             WHERE mmdgent = g_enterprise
               AND mmdgdocno = g_mmbo_m.mmbodocno
            IF cl_null(g_mmdd4_d[l_ac].mmdg003) THEN 
               LET g_mmdd4_d[l_ac].mmdg003 = 1
            END IF 
            #end add-point
            LET g_mmdd4_d_t.* = g_mmdd4_d[l_ac].*     #新輸入資料
            LET g_mmdd4_d_o.* = g_mmdd4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL agct415_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL agct415_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmdd4_d[li_reproduce_target].* = g_mmdd4_d[li_reproduce].*
 
               LET g_mmdd4_d[li_reproduce_target].mmdg003 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
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
            OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE agct415_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_mmdd4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmdd4_d[l_ac].mmdg003 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmdd4_d_t.* = g_mmdd4_d[l_ac].*  #BACKUP
               LET g_mmdd4_d_o.* = g_mmdd4_d[l_ac].*  #BACKUP
               CALL agct415_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL agct415_set_no_entry_b(l_cmd)
               IF NOT agct415_lock_b("mmdg_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH agct415_bcl4 INTO g_mmdd4_d[l_ac].mmdgunit,g_mmdd4_d[l_ac].mmdgsite,g_mmdd4_d[l_ac].mmdg001, 
                      g_mmdd4_d[l_ac].mmdg002,g_mmdd4_d[l_ac].mmdg003,g_mmdd4_d[l_ac].mmdg004,g_mmdd4_d[l_ac].mmdg005, 
                      g_mmdd4_d[l_ac].mmdg006,g_mmdd4_d[l_ac].mmdg007,g_mmdd4_d[l_ac].mmdgacti
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmdd4_d_mask_o[l_ac].* =  g_mmdd4_d[l_ac].*
                  CALL agct415_mmdg_t_mask()
                  LET g_mmdd4_d_mask_n[l_ac].* =  g_mmdd4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL agct415_show()
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
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身4刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_mmbo_m.mmbodocno
               LET gs_keys[gs_keys.getLength()+1] = g_mmdd4_d_t.mmdg003
            
               #刪除同層單身
               IF NOT agct415_delete_b('mmdg_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT agct415_key_delete_b(gs_keys,'mmdg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE agct415_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE agct415_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_mmdd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_mmdd4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身4新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM mmdg_t 
             WHERE mmdgent = g_enterprise AND mmdgdocno = g_mmbo_m.mmbodocno
               AND mmdg003 = g_mmdd4_d[l_ac].mmdg003
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmdd4_d[g_detail_idx].mmdg003
               CALL agct415_insert_b('mmdg_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_mmdd_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL agct415_b_fill()
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
               LET g_mmdd4_d[l_ac].* = g_mmdd4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_mmdd4_d[l_ac].* = g_mmdd4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL agct415_mmdg_t_mask_restore('restore_mask_o')
                              
               UPDATE mmdg_t SET (mmdgdocno,mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg003,mmdg004,mmdg005, 
                   mmdg006,mmdg007,mmdgacti) = (g_mmbo_m.mmbodocno,g_mmdd4_d[l_ac].mmdgunit,g_mmdd4_d[l_ac].mmdgsite, 
                   g_mmdd4_d[l_ac].mmdg001,g_mmdd4_d[l_ac].mmdg002,g_mmdd4_d[l_ac].mmdg003,g_mmdd4_d[l_ac].mmdg004, 
                   g_mmdd4_d[l_ac].mmdg005,g_mmdd4_d[l_ac].mmdg006,g_mmdd4_d[l_ac].mmdg007,g_mmdd4_d[l_ac].mmdgacti)  
                   #自訂欄位頁簽
                WHERE mmdgent = g_enterprise AND mmdgdocno = g_mmbo_m.mmbodocno
                  AND mmdg003 = g_mmdd4_d_t.mmdg003 #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_mmdd4_d[l_ac].* = g_mmdd4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_mmdd4_d[l_ac].* = g_mmdd4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmdd4_d[g_detail_idx].mmdg003
               LET gs_keys_bak[2] = g_mmdd4_d_t.mmdg003
               CALL agct415_update_b('mmdg_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL agct415_mmdg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_mmdd4_d[g_detail_idx].mmdg003 = g_mmdd4_d_t.mmdg003 
                  ) THEN
                  LET gs_keys[01] = g_mmbo_m.mmbodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_mmdd4_d_t.mmdg003
                  CALL agct415_key_update_b(gs_keys,'mmdg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd4_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmdd4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgunit
            #add-point:BEFORE FIELD mmdgunit name="input.b.page4.mmdgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgunit
            
            #add-point:AFTER FIELD mmdgunit name="input.a.page4.mmdgunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdgunit
            #add-point:ON CHANGE mmdgunit name="input.g.page4.mmdgunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgsite
            #add-point:BEFORE FIELD mmdgsite name="input.b.page4.mmdgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgsite
            
            #add-point:AFTER FIELD mmdgsite name="input.a.page4.mmdgsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdgsite
            #add-point:ON CHANGE mmdgsite name="input.g.page4.mmdgsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg001
            #add-point:BEFORE FIELD mmdg001 name="input.b.page4.mmdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg001
            
            #add-point:AFTER FIELD mmdg001 name="input.a.page4.mmdg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg001
            #add-point:ON CHANGE mmdg001 name="input.g.page4.mmdg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg002
            #add-point:BEFORE FIELD mmdg002 name="input.b.page4.mmdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg002
            
            #add-point:AFTER FIELD mmdg002 name="input.a.page4.mmdg002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg002
            #add-point:ON CHANGE mmdg002 name="input.g.page4.mmdg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg003
            #add-point:BEFORE FIELD mmdg003 name="input.b.page4.mmdg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg003
            
            #add-point:AFTER FIELD mmdg003 name="input.a.page4.mmdg003"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_mmbo_m.mmbodocno IS NOT NULL AND g_mmdd4_d[g_detail_idx].mmdg003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmdd4_d[g_detail_idx].mmdg003 != g_mmdd4_d_t.mmdg003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdg_t WHERE "||"mmdgent = '" ||g_enterprise|| "' AND "||"mmdgdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdg003 = '"||g_mmdd4_d[g_detail_idx].mmdg003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg003
            #add-point:ON CHANGE mmdg003 name="input.g.page4.mmdg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmdd4_d[l_ac].mmdg004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mmdg004
            END IF 
 
 
 
            #add-point:AFTER FIELD mmdg004 name="input.a.page4.mmdg004"
            IF NOT cl_null(g_mmdd4_d[l_ac].mmdg004) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg004
            #add-point:BEFORE FIELD mmdg004 name="input.b.page4.mmdg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg004
            #add-point:ON CHANGE mmdg004 name="input.g.page4.mmdg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmdd4_d[l_ac].mmdg005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD mmdg005
            END IF 
 
 
 
            #add-point:AFTER FIELD mmdg005 name="input.a.page4.mmdg005"
            IF NOT cl_null(g_mmdd4_d[l_ac].mmdg005) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg005
            #add-point:BEFORE FIELD mmdg005 name="input.b.page4.mmdg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg005
            #add-point:ON CHANGE mmdg005 name="input.g.page4.mmdg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_mmdd4_d[l_ac].mmdg006,"0","0","","","azz-00079",1) THEN
               NEXT FIELD mmdg006
            END IF 
 
 
 
            #add-point:AFTER FIELD mmdg006 name="input.a.page4.mmdg006"
            IF NOT cl_null(g_mmdd4_d[l_ac].mmdg006) THEN 
               IF g_mmdd4_d[l_ac].mmdg005 > 0 AND g_mmdd4_d[l_ac].mmdg005<g_mmdd4_d[l_ac].mmdg006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00471'
                  LET g_errparam.extend = g_mmdd4_d[l_ac].mmdg006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_mmdd4_d[l_ac].mmdg006 = g_mmdd4_d_t.mmdg006
                  NEXT FIELD mmdg006
               END IF 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg006
            #add-point:BEFORE FIELD mmdg006 name="input.b.page4.mmdg006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg006
            #add-point:ON CHANGE mmdg006 name="input.g.page4.mmdg006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdg007
            #add-point:BEFORE FIELD mmdg007 name="input.b.page4.mmdg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdg007
            
            #add-point:AFTER FIELD mmdg007 name="input.a.page4.mmdg007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdg007
            #add-point:ON CHANGE mmdg007 name="input.g.page4.mmdg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmdgacti
            #add-point:BEFORE FIELD mmdgacti name="input.b.page4.mmdgacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmdgacti
            
            #add-point:AFTER FIELD mmdgacti name="input.a.page4.mmdgacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mmdgacti
            #add-point:ON CHANGE mmdgacti name="input.g.page4.mmdgacti"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.mmdgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgunit
            #add-point:ON ACTION controlp INFIELD mmdgunit name="input.c.page4.mmdgunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgsite
            #add-point:ON ACTION controlp INFIELD mmdgsite name="input.c.page4.mmdgsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg001
            #add-point:ON ACTION controlp INFIELD mmdg001 name="input.c.page4.mmdg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg002
            #add-point:ON ACTION controlp INFIELD mmdg002 name="input.c.page4.mmdg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg003
            #add-point:ON ACTION controlp INFIELD mmdg003 name="input.c.page4.mmdg003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg004
            #add-point:ON ACTION controlp INFIELD mmdg004 name="input.c.page4.mmdg004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg005
            #add-point:ON ACTION controlp INFIELD mmdg005 name="input.c.page4.mmdg005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg006
            #add-point:ON ACTION controlp INFIELD mmdg006 name="input.c.page4.mmdg006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdg007
            #add-point:ON ACTION controlp INFIELD mmdg007 name="input.c.page4.mmdg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.mmdgacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmdgacti
            #add-point:ON ACTION controlp INFIELD mmdgacti name="input.c.page4.mmdgacti"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmdd4_d[l_ac].* = g_mmdd4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE agct415_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL agct415_unlock_b("mmdg_t","'4'")
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
               LET g_mmdd4_d[li_reproduce_target].* = g_mmdd4_d[li_reproduce].*
 
               LET g_mmdd4_d[li_reproduce_target].mmdg003 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmdd4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmdd4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="agct415.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'4',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD mmbosite #sakura add
            #end add-point  
            NEXT FIELD mmbodocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmddsite
               WHEN "s_detail2"
                  NEXT FIELD mmbssite
               WHEN "s_detail3"
                  NEXT FIELD mmcksite
               WHEN "s_detail4"
                  NEXT FIELD mmdgunit
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION agct415_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_flag    LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      LET g_mmbo_m_o.* = g_mmbo_m.*      #
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL agct415_b_fill() #單身填充
      CALL agct415_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL agct415_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
      INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbo_m.mmbodocno
   CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmbolent = '"||g_enterprise||"' AND mmboldocno = ? AND mmbol001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mmbo_m.mmbol002 = g_rtn_fields[1] 
   LET g_mmbo_m.mmbol003 = g_rtn_fields[2] 
   DISPLAY g_mmbo_m.mmbol002 TO mmbol002
   DISPLAY g_mmbo_m.mmbol003 TO mmbol003
#
#   CALL agct415_mmbo005_ref()
#
#   CALL agct415_mmbounit_ref()
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmboownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmboownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmboownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmboowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmboowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmboowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmbocrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmbocrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmbocrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmbocrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmbocrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmbocrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmbomodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmbomodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmbomodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_mmbo_m.mmbocnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_mmbo_m.mmbocnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_mmbo_m.mmbocnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_mmbo_m_mask_o.* =  g_mmbo_m.*
   CALL agct415_mmbo_t_mask()
   LET g_mmbo_m_mask_n.* =  g_mmbo_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000, 
       g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus, 
       g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid, 
       g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbo_m.mmbostus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmdd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
        CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc     
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmdd2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
#            CALL agct415_mmbs004_ref()
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmdd3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
          
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmdd4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL agct415_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION agct415_detail_show()
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
 
{<section id="agct415.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION agct415_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE mmbo_t.mmbodocno 
   DEFINE l_oldno     LIKE mmbo_t.mmbodocno 
 
   DEFINE l_master    RECORD LIKE mmbo_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE mmdd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmbs_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmck_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mmdg_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE l_insert      LIKE type_t.num5    #sakura add
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
    
   LET g_mmbo_m.mmbodocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_mmbo_m.mmboownid = g_user
      LET g_mmbo_m.mmboowndp = g_dept
      LET g_mmbo_m.mmbocrtid = g_user
      LET g_mmbo_m.mmbocrtdp = g_dept 
      LET g_mmbo_m.mmbocrtdt = cl_get_current()
      LET g_mmbo_m.mmbomodid = g_user
      LET g_mmbo_m.mmbomoddt = cl_get_current()
      LET g_mmbo_m.mmbostus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #sakura---add---str
   CALL s_aooi500_default(g_prog,'mmbosite',g_mmbo_m.mmbosite)
      RETURNING l_insert,g_mmbo_m.mmbosite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmbo_m.mmbosite,g_prog,'1') RETURNING l_success, l_doctype
   LET g_mmbo_m.mmbodocno = l_doctype   
   #sakura---add---end    
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_mmbo_m.mmbostus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL agct415_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmbo_m.* TO NULL
      INITIALIZE g_mmdd_d TO NULL
      INITIALIZE g_mmdd2_d TO NULL
      INITIALIZE g_mmdd3_d TO NULL
      INITIALIZE g_mmdd4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL agct415_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL agct415_set_act_visible()   
   CALL agct415_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " mmboent = " ||g_enterprise|| " AND",
                      " mmbodocno = '", g_mmbo_m.mmbodocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL agct415_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL agct415_idx_chk()
   
   LET g_data_owner = g_mmbo_m.mmboownid      
   LET g_data_dept  = g_mmbo_m.mmboowndp
   
   #功能已完成,通報訊息中心
   CALL agct415_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION agct415_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmdd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE mmbs_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE mmck_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE mmdg_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE agct415_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmdd_t
    WHERE mmddent = g_enterprise AND mmdddocno = g_mmbodocno_t
 
    INTO TEMP agct415_detail
 
   #將key修正為調整後   
   UPDATE agct415_detail 
      #更新key欄位
      SET mmdddocno = g_mmbo_m.mmbodocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO mmdd_t SELECT * FROM agct415_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agct415_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmbs_t 
    WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbodocno_t
 
    INTO TEMP agct415_detail
 
   #將key修正為調整後   
   UPDATE agct415_detail SET mmbsdocno = g_mmbo_m.mmbodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmbs_t SELECT * FROM agct415_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agct415_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmck_t 
    WHERE mmckent = g_enterprise AND mmckdocno = g_mmbodocno_t
 
    INTO TEMP agct415_detail
 
   #將key修正為調整後   
   UPDATE agct415_detail SET mmckdocno = g_mmbo_m.mmbodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmck_t SELECT * FROM agct415_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agct415_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM mmdg_t 
    WHERE mmdgent = g_enterprise AND mmdgdocno = g_mmbodocno_t
 
    INTO TEMP agct415_detail
 
   #將key修正為調整後   
   UPDATE agct415_detail SET mmdgdocno = g_mmbo_m.mmbodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO mmdg_t SELECT * FROM agct415_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE agct415_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.delete" >}
#+ 資料刪除
PRIVATE FUNCTION agct415_delete()
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
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_master_multi_table_t.mmboldocno = g_mmbo_m.mmbodocno
LET g_master_multi_table_t.mmbol002 = g_mmbo_m.mmbol002
LET g_master_multi_table_t.mmbol003 = g_mmbo_m.mmbol003
 
   
   CALL s_transaction_begin()
 
   OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct415_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT agct415_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_mmbo_m_mask_o.* =  g_mmbo_m.*
   CALL agct415_mmbo_t_mask()
   LET g_mmbo_m_mask_n.* =  g_mmbo_m.*
   
   CALL agct415_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL agct415_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
 
      DELETE FROM mmbo_t
       WHERE mmboent = g_enterprise AND mmbodocno = g_mmbo_m.mmbodocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_mmbo_m.mmbodocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #sakura---add---str
      IF NOT s_aooi200_del_docno(g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #sakura---add---end      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM mmdd_t
       WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM mmbs_t
       WHERE mmbsent = g_enterprise AND
             mmbsdocno = g_mmbo_m.mmbodocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete3"
      
      #end add-point
      DELETE FROM mmck_t
       WHERE mmckent = g_enterprise AND
             mmckdocno = g_mmbo_m.mmbodocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
            #刪除除外規則設定
      DELETE FROM mmbq_t WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del mmbq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      #刪除備註
     #IF NOT s_aooi360_del('6',g_mmbo_m.mmbodocno,'','','','','','','','','','') THEN
     #   CALL s_transaction_end('N','0')
     #   RETURN
     #END IF
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM mmdg_t
       WHERE mmdgent = g_enterprise AND
             mmdgdocno = g_mmbo_m.mmbodocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_mmbo_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE agct415_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_mmdd_d.clear() 
      CALL g_mmdd2_d.clear()       
      CALL g_mmdd3_d.clear()       
      CALL g_mmdd4_d.clear()       
 
     
      CALL agct415_ui_browser_refresh()  
      #CALL agct415_ui_headershow()  
      #CALL agct415_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_enterprise
   LET l_field_keys[01] = 'mmbolent'
   LET l_var_keys_bak[02] = g_master_multi_table_t.mmboldocno
   LET l_field_keys[02] = 'mmboldocno'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mmbol_t')
 
      
      #單身多語言刪除
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL agct415_browser_fill("")
         CALL agct415_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE agct415_cl
 
   #功能已完成,通報訊息中心
   CALL agct415_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="agct415.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agct415_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_mmdd_d.clear()
   CALL g_mmdd2_d.clear()
   CALL g_mmdd3_d.clear()
   CALL g_mmdd4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF agct415_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmddsite,mmddunit,mmdd001,mmdd002,mmdd003,mmdd004,mmddacti  FROM mmdd_t", 
                
                     " INNER JOIN mmbo_t ON mmboent = " ||g_enterprise|| " AND mmbodocno = mmdddocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE mmddent=? AND mmdddocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmdd_t.mmdd001,mmdd_t.mmdd003,mmdd_t.mmdd004"
         
         #add-point:單身填充控制 name="b_fill.sql"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct415_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR agct415_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_mmbo_m.mmbodocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_mmbo_m.mmbodocno INTO g_mmdd_d[l_ac].mmddsite,g_mmdd_d[l_ac].mmddunit, 
          g_mmdd_d[l_ac].mmdd001,g_mmdd_d[l_ac].mmdd002,g_mmdd_d[l_ac].mmdd003,g_mmdd_d[l_ac].mmdd004, 
          g_mmdd_d[l_ac].mmddacti   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
                  CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmdd_d[l_ac].mmdd004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmdd_d[l_ac].mmdd004_desc
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF agct415_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti , 
             t1.ooefl003 FROM mmbs_t",   
                     " INNER JOIN  mmbo_t ON mmboent = " ||g_enterprise|| " AND mmbodocno = mmbsdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=mmbs004 AND t1.ooefl002='"||g_dlang||"' ",
 
                     " WHERE mmbsent=? AND mmbsdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmbs_t.mmbs004"
         
         #add-point:單身填充控制 name="b_fill.sql2"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct415_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR agct415_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_mmbo_m.mmbodocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_mmbo_m.mmbodocno INTO g_mmdd2_d[l_ac].mmbssite,g_mmdd2_d[l_ac].mmbsunit, 
          g_mmdd2_d[l_ac].mmbs001,g_mmdd2_d[l_ac].mmbs002,g_mmdd2_d[l_ac].mmbs003,g_mmdd2_d[l_ac].mmbs004, 
          g_mmdd2_d[l_ac].mmbs005,g_mmdd2_d[l_ac].mmbsacti,g_mmdd2_d[l_ac].mmbs004_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
                  CALL agct415_mmbs004_ref()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF agct415_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmcksite,mmckunit,mmck001,mmck002,mmck003,mmck004,mmck005,mmck006, 
             mmck007,mmck008,mmck009,mmckacti  FROM mmck_t",   
                     " INNER JOIN  mmbo_t ON mmboent = " ||g_enterprise|| " AND mmbodocno = mmckdocno ",
 
                     "",
                     
                     
                     " WHERE mmckent=? AND mmckdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
      
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmck_t.mmck003"
         
         #add-point:單身填充控制 name="b_fill.sql3"
      
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct415_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR agct415_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_mmbo_m.mmbodocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_mmbo_m.mmbodocno INTO g_mmdd3_d[l_ac].mmcksite,g_mmdd3_d[l_ac].mmckunit, 
          g_mmdd3_d[l_ac].mmck001,g_mmdd3_d[l_ac].mmck002,g_mmdd3_d[l_ac].mmck003,g_mmdd3_d[l_ac].mmck004, 
          g_mmdd3_d[l_ac].mmck005,g_mmdd3_d[l_ac].mmck006,g_mmdd3_d[l_ac].mmck007,g_mmdd3_d[l_ac].mmck008, 
          g_mmdd3_d[l_ac].mmck009,g_mmdd3_d[l_ac].mmckacti   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill3.fill"
               
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF agct415_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg003,mmdg004,mmdg005,mmdg006, 
             mmdg007,mmdgacti  FROM mmdg_t",   
                     " INNER JOIN  mmbo_t ON mmboent = " ||g_enterprise|| " AND mmbodocno = mmdgdocno ",
 
                     "",
                     
                     
                     " WHERE mmdgent=? AND mmdgdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY mmdg_t.mmdg003"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE agct415_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR agct415_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_mmbo_m.mmbodocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_mmbo_m.mmbodocno INTO g_mmdd4_d[l_ac].mmdgunit,g_mmdd4_d[l_ac].mmdgsite, 
          g_mmdd4_d[l_ac].mmdg001,g_mmdd4_d[l_ac].mmdg002,g_mmdd4_d[l_ac].mmdg003,g_mmdd4_d[l_ac].mmdg004, 
          g_mmdd4_d[l_ac].mmdg005,g_mmdd4_d[l_ac].mmdg006,g_mmdd4_d[l_ac].mmdg007,g_mmdd4_d[l_ac].mmdgacti  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill4.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_mmdd_d.deleteElement(g_mmdd_d.getLength())
   CALL g_mmdd2_d.deleteElement(g_mmdd2_d.getLength())
   CALL g_mmdd3_d.deleteElement(g_mmdd3_d.getLength())
   CALL g_mmdd4_d.deleteElement(g_mmdd4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE agct415_pb
   FREE agct415_pb2
 
   FREE agct415_pb3
 
   FREE agct415_pb4
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_mmdd_d.getLength()
      LET g_mmdd_d_mask_o[l_ac].* =  g_mmdd_d[l_ac].*
      CALL agct415_mmdd_t_mask()
      LET g_mmdd_d_mask_n[l_ac].* =  g_mmdd_d[l_ac].*
   END FOR
   
   LET g_mmdd2_d_mask_o.* =  g_mmdd2_d.*
   FOR l_ac = 1 TO g_mmdd2_d.getLength()
      LET g_mmdd2_d_mask_o[l_ac].* =  g_mmdd2_d[l_ac].*
      CALL agct415_mmbs_t_mask()
      LET g_mmdd2_d_mask_n[l_ac].* =  g_mmdd2_d[l_ac].*
   END FOR
   LET g_mmdd3_d_mask_o.* =  g_mmdd3_d.*
   FOR l_ac = 1 TO g_mmdd3_d.getLength()
      LET g_mmdd3_d_mask_o[l_ac].* =  g_mmdd3_d[l_ac].*
      CALL agct415_mmck_t_mask()
      LET g_mmdd3_d_mask_n[l_ac].* =  g_mmdd3_d[l_ac].*
   END FOR
   LET g_mmdd4_d_mask_o.* =  g_mmdd4_d.*
   FOR l_ac = 1 TO g_mmdd4_d.getLength()
      LET g_mmdd4_d_mask_o[l_ac].* =  g_mmdd4_d[l_ac].*
      CALL agct415_mmdg_t_mask()
      LET g_mmdd4_d_mask_n[l_ac].* =  g_mmdd4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION agct415_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM mmdd_t
       WHERE mmddent = g_enterprise AND
         mmdddocno = ps_keys_bak[1] AND mmdd001 = ps_keys_bak[2] AND mmdd003 = ps_keys_bak[3] AND mmdd004 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmdd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM mmbs_t
       WHERE mmbsent = g_enterprise AND
             mmbsdocno = ps_keys_bak[1] AND mmbs004 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmdd2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM mmck_t
       WHERE mmckent = g_enterprise AND
             mmckdocno = ps_keys_bak[1] AND mmck003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmdd3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM mmdg_t
       WHERE mmdgent = g_enterprise AND
             mmdgdocno = ps_keys_bak[1] AND mmdg003 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmdd4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION agct415_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO mmdd_t
                  (mmddent,
                   mmdddocno,
                   mmdd001,mmdd003,mmdd004
                   ,mmddsite,mmddunit,mmdd002,mmddacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_mmdd_d[g_detail_idx].mmddsite,g_mmdd_d[g_detail_idx].mmddunit,g_mmdd_d[g_detail_idx].mmdd002, 
                       g_mmdd_d[g_detail_idx].mmddacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_mmdd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO mmbs_t
                  (mmbsent,
                   mmbsdocno,
                   mmbs004
                   ,mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs005,mmbsacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmdd2_d[g_detail_idx].mmbssite,g_mmdd2_d[g_detail_idx].mmbsunit,g_mmdd2_d[g_detail_idx].mmbs001, 
                       g_mmdd2_d[g_detail_idx].mmbs002,g_mmdd2_d[g_detail_idx].mmbs003,g_mmdd2_d[g_detail_idx].mmbs005, 
                       g_mmdd2_d[g_detail_idx].mmbsacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_mmdd2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO mmck_t
                  (mmckent,
                   mmckdocno,
                   mmck003
                   ,mmcksite,mmckunit,mmck001,mmck002,mmck004,mmck005,mmck006,mmck007,mmck008,mmck009,mmckacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmdd3_d[g_detail_idx].mmcksite,g_mmdd3_d[g_detail_idx].mmckunit,g_mmdd3_d[g_detail_idx].mmck001, 
                       g_mmdd3_d[g_detail_idx].mmck002,g_mmdd3_d[g_detail_idx].mmck004,g_mmdd3_d[g_detail_idx].mmck005, 
                       g_mmdd3_d[g_detail_idx].mmck006,g_mmdd3_d[g_detail_idx].mmck007,g_mmdd3_d[g_detail_idx].mmck008, 
                       g_mmdd3_d[g_detail_idx].mmck009,g_mmdd3_d[g_detail_idx].mmckacti)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_mmdd3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO mmdg_t
                  (mmdgent,
                   mmdgdocno,
                   mmdg003
                   ,mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg004,mmdg005,mmdg006,mmdg007,mmdgacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmdd4_d[g_detail_idx].mmdgunit,g_mmdd4_d[g_detail_idx].mmdgsite,g_mmdd4_d[g_detail_idx].mmdg001, 
                       g_mmdd4_d[g_detail_idx].mmdg002,g_mmdd4_d[g_detail_idx].mmdg004,g_mmdd4_d[g_detail_idx].mmdg005, 
                       g_mmdd4_d[g_detail_idx].mmdg006,g_mmdd4_d[g_detail_idx].mmdg007,g_mmdd4_d[g_detail_idx].mmdgacti) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_mmdd4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION agct415_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmdd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL agct415_mmdd_t_mask_restore('restore_mask_o')
               
      UPDATE mmdd_t 
         SET (mmdddocno,
              mmdd001,mmdd003,mmdd004
              ,mmddsite,mmddunit,mmdd002,mmddacti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_mmdd_d[g_detail_idx].mmddsite,g_mmdd_d[g_detail_idx].mmddunit,g_mmdd_d[g_detail_idx].mmdd002, 
                  g_mmdd_d[g_detail_idx].mmddacti) 
         WHERE mmddent = g_enterprise AND mmdddocno = ps_keys_bak[1] AND mmdd001 = ps_keys_bak[2] AND mmdd003 = ps_keys_bak[3] AND mmdd004 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct415_mmdd_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbs_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL agct415_mmbs_t_mask_restore('restore_mask_o')
               
      UPDATE mmbs_t 
         SET (mmbsdocno,
              mmbs004
              ,mmbssite,mmbsunit,mmbs001,mmbs002,mmbs003,mmbs005,mmbsacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmdd2_d[g_detail_idx].mmbssite,g_mmdd2_d[g_detail_idx].mmbsunit,g_mmdd2_d[g_detail_idx].mmbs001, 
                  g_mmdd2_d[g_detail_idx].mmbs002,g_mmdd2_d[g_detail_idx].mmbs003,g_mmdd2_d[g_detail_idx].mmbs005, 
                  g_mmdd2_d[g_detail_idx].mmbsacti) 
         WHERE mmbsent = g_enterprise AND mmbsdocno = ps_keys_bak[1] AND mmbs004 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbs_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmbs_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct415_mmbs_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmck_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL agct415_mmck_t_mask_restore('restore_mask_o')
               
      UPDATE mmck_t 
         SET (mmckdocno,
              mmck003
              ,mmcksite,mmckunit,mmck001,mmck002,mmck004,mmck005,mmck006,mmck007,mmck008,mmck009,mmckacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmdd3_d[g_detail_idx].mmcksite,g_mmdd3_d[g_detail_idx].mmckunit,g_mmdd3_d[g_detail_idx].mmck001, 
                  g_mmdd3_d[g_detail_idx].mmck002,g_mmdd3_d[g_detail_idx].mmck004,g_mmdd3_d[g_detail_idx].mmck005, 
                  g_mmdd3_d[g_detail_idx].mmck006,g_mmdd3_d[g_detail_idx].mmck007,g_mmdd3_d[g_detail_idx].mmck008, 
                  g_mmdd3_d[g_detail_idx].mmck009,g_mmdd3_d[g_detail_idx].mmckacti) 
         WHERE mmckent = g_enterprise AND mmckdocno = ps_keys_bak[1] AND mmck003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmck_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmck_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct415_mmck_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmdg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL agct415_mmdg_t_mask_restore('restore_mask_o')
               
      UPDATE mmdg_t 
         SET (mmdgdocno,
              mmdg003
              ,mmdgunit,mmdgsite,mmdg001,mmdg002,mmdg004,mmdg005,mmdg006,mmdg007,mmdgacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmdd4_d[g_detail_idx].mmdgunit,g_mmdd4_d[g_detail_idx].mmdgsite,g_mmdd4_d[g_detail_idx].mmdg001, 
                  g_mmdd4_d[g_detail_idx].mmdg002,g_mmdd4_d[g_detail_idx].mmdg004,g_mmdd4_d[g_detail_idx].mmdg005, 
                  g_mmdd4_d[g_detail_idx].mmdg006,g_mmdd4_d[g_detail_idx].mmdg007,g_mmdd4_d[g_detail_idx].mmdgacti)  
 
         WHERE mmdgent = g_enterprise AND mmdgdocno = ps_keys_bak[1] AND mmdg003 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "mmdg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL agct415_mmdg_t_mask_restore('restore_mask_n')
 
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
 
{<section id="agct415.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION agct415_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="agct415.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION agct415_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="agct415.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION agct415_lock_b(ps_table,ps_page)
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
   #CALL agct415_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmdd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN agct415_bcl USING g_enterprise,
                                       g_mmbo_m.mmbodocno,g_mmdd_d[g_detail_idx].mmdd001,g_mmdd_d[g_detail_idx].mmdd003, 
                                           g_mmdd_d[g_detail_idx].mmdd004     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct415_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "mmbs_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agct415_bcl2 USING g_enterprise,
                                             g_mmbo_m.mmbodocno,g_mmdd2_d[g_detail_idx].mmbs004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct415_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mmck_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agct415_bcl3 USING g_enterprise,
                                             g_mmbo_m.mmbodocno,g_mmdd3_d[g_detail_idx].mmck003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct415_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "mmdg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN agct415_bcl4 USING g_enterprise,
                                             g_mmbo_m.mmbodocno,g_mmdd4_d[g_detail_idx].mmdg003
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "agct415_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION agct415_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agct415_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agct415_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agct415_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE agct415_bcl4
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION agct415_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("mmbodocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmbodocno",TRUE)
      CALL cl_set_comp_entry("mmbodocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
     #CALL cl_set_comp_entry("mmbounit",TRUE) #sakura mark
      CALL cl_set_comp_entry("mmbosite",TRUE) #sakura add
      CALL cl_set_comp_entry("mmbo000",TRUE)
      CALL cl_set_comp_entry("mmbodocdt",TRUE)
      CALL cl_set_comp_entry("mmbo001",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("mmboacti",TRUE)
  #CALL cl_set_comp_entry("mmbounit",TRUE) #sakura mark
   CALL cl_set_comp_entry("mmbosite",TRUE) #sakura add
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION agct415_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmbodocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      IF NOT agct415_detail_count() THEN
         CALL cl_set_comp_entry("mmbo000",FALSE)
        #CALL cl_set_comp_entry("mmbounit",FALSE) #sakura mark
         CALL cl_set_comp_entry("mmbosite",FALSE) #sakura add
         CALL cl_set_comp_entry("mmbo001",FALSE)
      END IF
      IF NOT cl_null(g_mmbo_m.mmbodocno) THEN
         CALL cl_set_comp_entry("mmbodocdt",FALSE)
      END IF
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("mmbodocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("mmbodocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
      IF cl_null(g_mmbo_m.mmbo000) OR g_mmbo_m.mmbo000 = 'I' THEN
      CALL cl_set_comp_entry("mmboacti",FALSE)
   END IF
   IF agct415_mmbs_count() > 0 THEN
     #CALL cl_set_comp_entry("mmbounit",FALSE) #sakura mark
      CALL cl_set_comp_entry("mmbosite",FALSE) #sakura add
   END IF
   #sakura---add---str
    IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("mmbosite,mmbodocdt,mmbodocno",FALSE)
   END IF
   #aooi500設定的欄位控卡   
   IF NOT s_aooi500_comp_entry(g_prog,'mmbosite') OR g_site_flag THEN
      CALL cl_set_comp_entry("mmbosite",FALSE)
   END IF
   #sakura---add---end    
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION agct415_set_entry_b(p_cmd)
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
      
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
      IF g_current_page = 1 THEN
      CALL cl_set_comp_entry('mmdd004',TRUE)
   END IF
   IF g_current_page = 3 THEN
    
      CALL cl_set_comp_required('mmck006,mmck007',TRUE)
   END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION agct415_set_no_entry_b(p_cmd)
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
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
      IF g_current_page = 1 THEN
      IF g_mmbo_m.mmbo007 = '0' THEN
         CALL cl_set_comp_entry('mmdd004',FALSE)
      END IF
   END IF
   IF g_current_page = 3 THEN
  

      IF cl_null(g_mmdd3_d[l_ac].mmck006) THEN
         CALL cl_set_comp_required('mmck007',FALSE)
      END IF
      IF cl_null(g_mmdd3_d[l_ac].mmck007) THEN
         CALL cl_set_comp_required('mmck006',FALSE)
      END IF
      
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION agct415_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION agct415_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_mmbo_m.mmbostus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION agct415_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct415.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION agct415_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="agct415.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION agct415_default_search()
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
      LET ls_wc = ls_wc, " mmbodocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "mmbo_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmdd_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "mmbs_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mmck_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "mmdg_t" 
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
 
{<section id="agct415.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION agct415_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
      DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
      IF g_mmbo_m.mmbostus != 'N' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN agct415_cl USING g_enterprise,g_mmbo_m.mmbodocno
   IF STATUS THEN
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN agct415_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
       g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbomodid_desc, 
       g_mmbo_m.mmbocnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT agct415_action_chk() THEN
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000, 
       g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003, 
       g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus, 
       g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid, 
       g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt 
 
 
   CASE g_mmbo_m.mmbostus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "A"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
      WHEN "D"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
      WHEN "R"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
      WHEN "W"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmbo_m.mmbostus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "A"
               HIDE OPTION "approved"
            WHEN "D"
               HIDE OPTION "withdraw"
            WHEN "R"
               HIDE OPTION "rejection"
            WHEN "W"
               HIDE OPTION "signing"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_mmbo_m.mmbostus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
            
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
            
         WHEN "Y"
            HIDE OPTION "open"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN
            
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            CALL s_transaction_end('N','0')   #160816-00068#11 by 08209 add
            RETURN 
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,hold",FALSE)
            
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT agct415_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct415_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT agct415_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE agct415_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         
            #end add-point
         END IF
         EXIT MENU
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
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_mmbo_m.mmbostus = lc_state OR cl_null(lc_state) THEN
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
   #160831-00020#1 -s by 08172
#      CALL s_ammt357_conf_chk(g_mmbo_m.mmbodocno,g_mmbo_m.mmbostus) RETURNING l_success,l_errno
#      IF NOT l_success THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = l_errno
#         LET g_errparam.extend = g_mmbo_m.mmbodocno
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         CALL s_transaction_end('N','0')
#         RETURN
#      ELSE
#         IF NOT cl_ask_confirm('aim-00108') THEN 
#            CALL s_transaction_end('N','0')
#            RETURN
#         ELSE
#            CALL s_ammt357_conf_upd(g_mmbo_m.mmbodocno) RETURNING l_success
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#         END IF
#      END IF
      CALL s_ammt357_conchk(g_mmbo_m.mmbodocno) RETURNING l_success
      IF NOT l_success THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160831-00020#1 -e by 08172
   END IF
   IF lc_state = 'X' THEN
      CALL s_ammt357_void_chk(g_mmbo_m.mmbodocno,g_mmbo_m.mmbostus) RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = g_mmbo_m.mmbodocno
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN 
            CALL s_transaction_end('N','0')
            RETURN
         ELSE
            CALL s_ammt357_void_upd(g_mmbo_m.mmbodocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_mmbo_m.mmbomodid = g_user
   LET g_mmbo_m.mmbomoddt = cl_get_current()
   LET g_mmbo_m.mmbostus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE mmbo_t 
      SET (mmbostus,mmbomodid,mmbomoddt) 
        = (g_mmbo_m.mmbostus,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt)     
    WHERE mmboent = g_enterprise AND mmbodocno = g_mmbo_m.mmbodocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "A"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/approved.png")
         WHEN "D"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/withdraw.png")
         WHEN "R"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/rejection.png")
         WHEN "W"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/signing.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE agct415_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbosite,g_mmbo_m.mmbodocdt, 
          g_mmbo_m.mmbodocno,g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002, 
          g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit, 
          g_mmbo_m.mmbo016,g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp, 
          g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt, 
          g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbounit_desc, 
          g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp_desc, 
          g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbocnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbodocno, 
          g_mmbo_m.mmbo000,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002, 
          g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008, 
          g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit_desc,g_mmbo_m.mmbo016, 
          g_mmbo_m.mmboacti,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc,g_mmbo_m.mmboowndp, 
          g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdp_desc, 
          g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
          g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
      IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE      
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE agct415_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL agct415_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct415.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION agct415_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmdd_d.getLength() THEN
         LET g_detail_idx = g_mmdd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmdd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmdd_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmdd2_d.getLength() THEN
         LET g_detail_idx = g_mmdd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmdd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmdd2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_mmdd3_d.getLength() THEN
         LET g_detail_idx = g_mmdd3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmdd3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmdd3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_mmdd4_d.getLength() THEN
         LET g_detail_idx = g_mmdd4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmdd4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmdd4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agct415_b_fill2(pi_idx)
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
   
   CALL agct415_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION agct415_fill_chk(ps_idx)
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
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="agct415.status_show" >}
PRIVATE FUNCTION agct415_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="agct415.mask_functions" >}
&include "erp/agc/agct415_mask.4gl"
 
{</section>}
 
{<section id="agct415.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION agct415_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
   LET g_wc2_table4 = " 1=1"
 
 
   CALL agct415_show()
   CALL agct415_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_ammt357_conf_chk(g_mmbo_m.mmbodocno,g_mmbo_m.mmbostus) RETURNING l_success,g_errno
   IF NOT l_success THEN
      CLOSE agct415_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmbo_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmdd_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mmdd2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_mmdd3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_mmdd4_d))
 
 
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
   #CALL agct415_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL agct415_ui_headershow()
   CALL agct415_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION agct415_draw_out()
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
   CALL agct415_ui_headershow()  
   CALL agct415_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="agct415.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION agct415_set_pk_array()
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
   LET g_pk_array[1].values = g_mmbo_m.mmbodocno
   LET g_pk_array[1].column = 'mmbodocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct415.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="agct415.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION agct415_msgcentre_notify(lc_state)
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
   CALL agct415_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_mmbo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="agct415.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION agct415_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#14 -s by 08172
   SELECT mmbostus  INTO g_mmbo_m.mmbostus
     FROM mmbo_t
    WHERE mmboent = g_enterprise
      AND mmbodocno = g_mmbo_m.mmbodocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_mmbo_m.mmbostus
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
        LET g_errparam.extend = g_mmbo_m.mmbodocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL agct415_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#14 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="agct415.other_function" readonly="Y" >}
#+
PRIVATE FUNCTION agct415_mmbodocno_chk()
DEFINE l_oobastus   LIKE ooba_t.oobastus
DEFINE l_ooef004    LIKE ooef_t.ooef004

   INITIALIZE g_errno TO NULL
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooef001 = g_site AND ooefent = g_enterprise
   IF cl_null(l_ooef004) THEN
      LET g_errno = 'art-00007' #當前登入組織設定的"單據別使用參照表"尚未設定
   ELSE
      SELECT oobastus INTO l_oobastus
        FROM ooba_t,oobl_t
       WHERE oobaent = ooblent AND ooba001 = oobl001 AND ooba002 = oobl002
         AND ooba001 = l_ooef004
         AND ooba002 = g_mmbo_m.mmbodocno
         AND oobaent = g_enterprise
         AND oobl003 = 'agct415'
      CASE
         WHEN SQLCA.sqlcode = 100 LET g_errno = 'sub-00113' #在單據別主檔中不存在
         WHEN l_oobastus <> 'Y'   LET g_errno = 'sub-00114' #此單據別無效！
         OTHERWISE LET g_errno = SQLCA.sqlcode USING '---------'
      END CASE
   END IF
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo001_chk()
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_mmbtunit LIKE mmbt_t.mmbtunit

   #初始化
   INITIALIZE g_errno TO NULL
   LET l_cnt = 0
   
   #检查：该规则编号是否存在未确认单据
   SELECT COUNT(*) INTO l_cnt
     FROM mmbo_t
    WHERE mmboent = g_enterprise AND mmbo001 = g_mmbo_m.mmbo001 AND mmbostus = 'N'
   IF l_cnt > 0 THEN
      LET g_errno = 'amm-00152' #当前规则编号仍存在未审核的单据,不允许输入 -- 请至[会员卡储值加值规则申请维护作业agct415]查询后重新输入
      RETURN
   END IF
   
   #检查规则编号
   LET l_cnt = 0
   CASE g_mmbo_m.mmbo000
      WHEN 'I'
         SELECT COUNT(*) INTO l_cnt
           FROM mmbt_t
          WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
         IF l_cnt > 0 THEN 
            LET g_errno = 'amm-00153' #申请类别为I.新增时,规则编号不可存在于[会员卡储值加值规则基本资料档]中 -- 请至[会员卡储值加值规则基本资料维护作业ammm352]中查询后重新输入!
         END IF
      WHEN 'U'
         SELECT COUNT(*) INTO l_cnt
           FROM mmbt_t
          WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001 AND mmbt004 = '8'
         IF l_cnt = 0 THEN 
            #LET g_errno = 'amm-00154' #申请类别为U.修改时,规则编号必须存在于[会员卡储值加值规则基本资料档]中 -- 请至[会员卡储值加值规则基本资料维护作业ammm352]中查询后重新输入!
            LET g_errno = 'agc-00219' #160519-00025#1 Add By Ken 160601  #申請類別為U.修改時,規則代號必須存在於[收劵活動規則單頭檔]中！
            RETURN
         END IF
         SELECT mmbtunit INTO l_mmbtunit
           FROM mmbt_t
          WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
         IF cl_null(l_mmbtunit) OR l_mmbtunit <> g_site THEN
            LET g_errno = '' #该券种制定营运组织非当前组织,不可异动
         END IF
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo001_init()
   
   IF cl_null(g_mmbo_m.mmbo000) OR cl_null(g_mmbo_m.mmbo001) THEN
      RETURN
   END IF
   
   CASE g_mmbo_m.mmbo000
      WHEN 'U'
         IF NOT cl_null(g_mmbo_m.mmbo001) THEN
            SELECT mmbtl003,mmbtl004 INTO g_mmbo_m.mmbol002,g_mmbo_m.mmbol003
              FROM mmbtl_t
             WHERE mmbtlent = g_enterprise AND mmbtl001 = g_mmbo_m.mmbo001 AND mmbtl002 = g_dlang
            SELECT CASE mmbtstus WHEN 'X' THEN 'N' ELSE 'Y' END,
                   CASE WHEN mmbt002 IS NULL THEN 2 ELSE mmbt002 +1 END,
                   mmbt004,mmbt005,mmbt006,mmbt007,mmbt008,mmbt014,mmbt015
              INTO g_mmbo_m.mmboacti,
                   g_mmbo_m.mmbo002,
                   g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,
                   g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015
              FROM mmbt_t
             WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
            LET g_mmbo_m.mmbo002 = g_mmbo_m.mmbo002 USING '<<<<<<<#'
         ELSE
            INITIALIZE g_mmbo_m.mmbol002,g_mmbo_m.mmbol003 TO NULL
            INITIALIZE g_mmbo_m.mmboacti,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                       g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015
                    TO NULL
            LET g_mmbo_m.mmbo004 = "7"
           #LET g_mmbo_m.mmbo002 = "1" #sakura mark
            LET g_mmbo_m.mmbo002 = "0" #sakura add
            LET g_mmbo_m.mmbo007 = "0"
            LET g_mmbo_m.mmbo008 = "0"
            LET g_mmbo_m.mmboacti = "Y"
         END IF
   END CASE
   DISPLAY BY NAME g_mmbo_m.mmboacti,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                   g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,
                   g_mmbo_m.mmbo015,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003
   
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo000_init()
   
   IF cl_null(g_mmbo_m.mmbo001) THEN
      RETURN
   END IF
   INITIALIZE g_mmbo_m.mmbol002,g_mmbo_m.mmbol003 TO NULL
   INITIALIZE g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
              g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015
           TO NULL
   LET g_mmbo_m.mmbo004 = "7"
  #LET g_mmbo_m.mmbo002 = "1" #sakura mark
   LET g_mmbo_m.mmbo002 = "0" #sakura add
   LET g_mmbo_m.mmbo007 = "0"
   LET g_mmbo_m.mmbo008 = "0"
   LET g_mmbo_m.mmboacti = "Y"
   DISPLAY BY NAME g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,
                   g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                   g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,
                   g_mmbo_m.mmboacti
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo005_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbo_m.mmbo005
   CALL ap_ref_array2(g_ref_fields,"SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbo_m.mmbo005_desc
END FUNCTION
#+
PRIVATE FUNCTION agct415_set_combo()
DEFINE l_values   STRING
DEFINE l_items    STRING
DEFINE l_gzcb002  LIKE gzcb_t.gzcb002
DEFINE l_gzcbl004 LIKE gzcbl_t.gzcbl004

   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   DECLARE m352_gzcb_cs1 CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t,gzcbl_t
     WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
       AND gzcb001 = '6517'   AND gzcbl003 = g_dlang
       AND gzcb002 IN ('0','1','2')
     ORDER BY gzcb001
   FOREACH m352_gzcb_cs1 INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("b_mmbo007",l_values,l_items)
   CALL cl_set_combo_items("b_mmbo008",l_values,l_items)
   CALL cl_set_combo_items("mmbo007",l_values,l_items)
   CALL cl_set_combo_items("mmbo008",l_values,l_items)
   

   
   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   DECLARE m352_gzcb_cs3 CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t,gzcbl_t
     WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
       AND gzcb001 = '6520'   AND gzcbl003 = g_dlang
     ORDER BY gzcb001
   FOREACH m352_gzcb_cs3 INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("mmck008_1",l_values,l_items)
   
   LET l_values = NULL
   LET l_items = NULL
   LET l_gzcb002 = NULL
   LET l_gzcbl004 = NULL
   DECLARE m352_gzcb_cs4 CURSOR FOR
    SELECT gzcb002,gzcbl004 FROM gzcb_t,gzcbl_t
     WHERE gzcb001 = gzcbl001 AND gzcb002 = gzcbl002
       AND gzcb001 = '30'   AND gzcbl003 = g_dlang
     ORDER BY gzcb001
   FOREACH m352_gzcb_cs4 INTO l_gzcb002,l_gzcbl004
      LET l_values = l_values CLIPPED ,",",l_gzcb002
      LET l_items  = l_items CLIPPED ,",",l_gzcb002 CLIPPED,':',l_gzcbl004
   END FOREACH
   CALL cl_set_combo_items("mmck009_1",l_values,l_items)
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo014_chk()
DEFINE l_cnt   LIKE type_t.num5

   INITIALIZE g_errno TO NULL
   
   IF cl_null(g_mmbo_m.mmbo014) OR cl_null(g_mmbo_m.mmbo015) THEN
      RETURN
   END IF
   
   IF g_mmbo_m.mmbo014 > g_mmbo_m.mmbo015 THEN
      CASE
         WHEN INFIELD(mmbo014) 
            LET g_errno = 'amm-00080' #开始日期必须小于等于结束日期
         WHEN INFIELD(mmbo015)
            LET g_errno = 'amm-00081' #结束日期必须大於等於开始日期
      END CASE
   END IF   
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mmck_t
    WHERE mmckent = g_enterprise AND mmckdocno = g_mmbo_m.mmbodocno
      AND ((mmck004 < g_mmbo_m.mmbo014) OR (mmck005 > g_mmbo_m.mmbo015))

   IF l_cnt > 0 THEN
      LET g_errno = 'amm-00244' #生效时段设定中存在不符合单头日期区间的资料,请检查
      RETURN
   END IF
END FUNCTION
#+
# Modify.........:2014/12/26 by sakura #141208-00001#5 mmbounit->mmbosite
PRIVATE FUNCTION agct415_mmbosite_ref()
   
   INITIALIZE g_ref_fields TO NULL
  #LET g_ref_fields[1] = g_mmbo_m.mmbounit #sakura mark
   LET g_ref_fields[1] = g_mmbo_m.mmbosite #skaura add
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
  #LET g_mmbo_m.mmbounit_desc = '', g_rtn_fields[1] , '' #sakura mark
   LET g_mmbo_m.mmbosite_desc = '', g_rtn_fields[1] , '' #sakura add
  #DISPLAY BY NAME g_mmbo_m.mmbounit_desc #sakura mark
   DISPLAY BY NAME g_mmbo_m.mmbosite_desc #sakura add
END FUNCTION
#+
PRIVATE FUNCTION agct415_detail_count()
DEFINE l_success    LIKE type_t.num5
DEFINE l_cnt1       LIKE type_t.num5
DEFINE l_cnt2       LIKE type_t.num5
DEFINE l_cnt3       LIKE type_t.num5
DEFINE l_cnt4       LIKE type_t.num5
   
   LET l_success = TRUE
   IF cl_null(g_mmbo_m.mmbodocno) THEN
      LET l_success = TRUE
      RETURN l_success
   END IF
   SELECT COUNT(*) INTO l_cnt1
     FROM mmdd_t
    WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt2
     FROM mmbs_t
    WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt3
     FROM mmck_t
    WHERE mmckent = g_enterprise AND mmckdocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt4
     FROM mmbq_t
    WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
   IF l_cnt1 > 0 OR l_cnt2 > 0 OR l_cnt3 > 0 OR l_cnt4 > 0 THEN
      LET l_success = FALSE
      RETURN l_success
   END IF
   RETURN l_success
END FUNCTION
#+
PRIVATE FUNCTION agct415_detail_init()
   
   IF g_mmbo_m.mmbo000 <> 'U' THEN
      RETURN
   END IF
   
   IF agct415_mmbo007_chk('a') THEN
      #储值加值一般规则设定
      INSERT INTO mmdd_t (mmddent,mmddsite,mmddunit,mmdddocno,mmdd001,mmdd002,mmdd003,mmdd004,mmddacti)   
      SELECT g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno, 
             mmdf001,mmdf002,mmdf003,mmdf004,mmdfstus
        FROM mmdf_t
       WHERE mmdfent = g_enterprise AND mmdf001 = g_mmbo_m.mmbo001
      
      #生效营运据点
      INSERT INTO mmbs_t (mmbsent,mmbssite,mmbsunit,mmbsdocno,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti)
     #SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno, #sakura mark
      SELECT g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno, #sakura add
             mmbx001,mmbx002,mmbx003,mmbx004,mmbx005,mmbxstus
        FROM mmbx_t
       WHERE mmbxent = g_enterprise AND mmbx001 = g_mmbo_m.mmbo001
   END IF
   
   #储值加值进阶规则设定
   INSERT INTO mmck_t (mmckent,mmcksite,mmckunit,mmckdocno,mmck001,mmck002,mmck003,mmck004,mmck005,mmck006,mmck007,mmck008,mmck009,mmckacti)
   SELECT g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno, 
          mmcn001,mmcn002,mmcn003,mmcn004,mmcn005,mmcn006,mmcn007,mmcn008,mmcn009,mmcnstus
     FROM mmcn_t
    WHERE mmcnent = g_enterprise AND mmcn001 = g_mmbo_m.mmbo001
   
   IF agct415_mmbo008_chk('a') THEN
      #储值加值除外规则设定
      INSERT INTO mmbq_t (mmbqent,mmbqsite,mmbqunit,mmbqdocno,mmbq001,mmbq002,mmbq003,mmbq004,mmbqacti)
     #SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno, #sakura mark
      SELECT g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno, #sakura add
             mmbv001,mmbv002,mmbv003,mmbv004,mmbvstus
        FROM mmbv_t
       WHERE mmbvent = g_enterprise AND mmbv001 = g_mmbo_m.mmbo001
   END IF
   #add by yangxf ----start----
   IF g_mmbo_m.mmbo016 = 'Y' THEN 
      INSERT INTO mmdg_t (mmdgent,mmdgsite,mmdgunit,mmdgdocno,mmdg001,mmdg002,mmdg003,mmdg004,mmdg005,mmdg006,mmdg007,mmdgacti)
      SELECT g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno, 
             mmdh001,mmdh002,mmdh003,mmdh004,mmdh005,mmdh006,mmdh007,mmdhacti
       FROM mmdh_t
      WHERE mmdhent = g_enterprise AND mmdh001 = g_mmbo_m.mmbo001
   END IF 
   #add by yangxf ----end----
   #单身填充
   CALL agct415_b_fill()
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo007_chk(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE r_success    LIKE type_t.num5
DEFINE l_mmbt007    LIKE mmbt_t.mmbt007
DEFINE l_cnt        LIKE type_t.num10
DEFINE l_cnt1       LIKE type_t.num10

   LET r_success = TRUE
   INITIALIZE g_errno TO NULL
   
   IF cl_null(g_mmbo_m.mmbo000) OR cl_null(g_mmbo_m.mmbo001) OR cl_null(g_mmbo_m.mmbo007) THEN
      RETURN r_success
   END IF

   IF p_cmd = 'a' AND g_mmbo_m.mmbo000 = 'U' THEN
      SELECT mmbt007 INTO l_mmbt007
        FROM mmbt_t
       WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
   
      IF l_mmbt007 <> g_mmbo_m.mmbo007 THEN
         LET g_errno   = 'amm-00156' #规则类型与原主档规则类型不同，将不会预设单身(一般规则、生效组织)资料，是否更改?(Y/N)
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   IF p_cmd = 'u' THEN
      #检查一般规则
      SELECT COUNT(*) INTO l_cnt
        FROM mmdd_t
       WHERE mmddent = g_enterprise AND mmdddocno = g_mmbo_m.mmbodocno
      
      #检查生效组织
      SELECT COUNT(*) INTO l_cnt1
        FROM mmbs_t
       WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
      
      IF l_cnt > 0 OR l_cnt1 > 0 THEN
         LET g_errno = 'amm-00157' #已设置单身规则设定资料，异动规则类型将会删除对应设置(一般规则、生效组织)资料，是否异动?(Y/N)
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbo008_chk(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE r_success    LIKE type_t.num5
DEFINE l_mmbt008    LIKE mmbt_t.mmbt008
DEFINE l_cnt        LIKE type_t.num10

   LET r_success = TRUE
   INITIALIZE g_errno TO NULL
   
   IF cl_null(g_mmbo_m.mmbo000) OR cl_null(g_mmbo_m.mmbo001) OR cl_null(g_mmbo_m.mmbo008) THEN
      RETURN r_success
   END IF

   IF p_cmd = 'a' AND g_mmbo_m.mmbo000 = 'U' THEN
      SELECT mmbt008 INTO l_mmbt008
        FROM mmbt_t
       WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
   
      IF l_mmbt008 <> g_mmbo_m.mmbo008 THEN
         LET g_errno   = 'amm-00158' #排除方式与原主档排除方式不同，将不会预设单身(除外规则)资料，是否更改?(Y/N)
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   IF p_cmd = 'u' THEN
      #检查一般规则
      SELECT COUNT(*) INTO l_cnt
        FROM mmbq_t
       WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
      
      IF l_cnt > 0 THEN
         LET g_errno   = 'amm-00159' #已设置除外规则设定资料，异动排除方式将会删除对应设置(除外规则)资料，是否异动?(Y/N)
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbs004_ref()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmdd2_d[l_ac].mmbs004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmdd2_d[l_ac].mmbs004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmdd2_d[l_ac].mmbs004_desc
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmck004_chk(p_mmck004)
DEFINE p_mmck004   LIKE mmck_t.mmck004

   INITIALIZE g_errno TO NULL
   
   IF cl_null(p_mmck004) THEN RETURN END IF
   
   CASE
      WHEN INFIELD(mmck004)
        #IF p_mmck004 < g_mmbo_m.mmbo014 THEN
        #   LET g_errno = 'amm-00065' #
        #   RETURN
        #END IF
         IF NOT cl_null(g_mmdd3_d[l_ac].mmck005) AND p_mmck004 > g_mmdd3_d[l_ac].mmck005 THEN
            LET g_errno = 'amm-00080' #
            RETURN
         END IF
      WHEN INFIELD(mmck005)
         #IF p_mmck004 > g_mmbo_m.mmbo015 THEN
         #   LET g_errno = 'amm-00066' #
         #   RETURN
         #END IF
         IF NOT cl_null(g_mmdd3_d[l_ac].mmck004) AND p_mmck004 < g_mmdd3_d[l_ac].mmck004 THEN
            LET g_errno = 'amm-00081' #
            RETURN
         END IF
   END CASE
END FUNCTION
#+
PRIVATE FUNCTION agct415_mmbs_count()
DEFINE l_cnt   LIKE type_t.num5

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM mmbs_t
    WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
   
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   RETURN l_cnt
END FUNCTION

################################################################################
# Descriptions...: 刷新单身资料
# Memo...........:
# Usage..........: CALL agct415_mmdg_display()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/06/25 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION agct415_mmdg_display()

    CALL g_mmdd4_d.clear()
    DISPLAY ARRAY g_mmdd4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
          
       BEFORE DISPLAY
          EXIT DISPLAY 
    
    END DISPLAY
END FUNCTION

 
{</section>}
 
