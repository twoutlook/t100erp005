#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2016-06-17 15:44:51), PR版次:0018(2017-02-17 15:38:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000247
#+ Filename...: asrt340
#+ Description: 重覆性生產完工入庫維護作業
#+ Creator....: 00378(2014-02-26 00:00:00)
#+ Modifier...: 06821 -SD/PR- 01996
 
{</section>}
 
{<section id="asrt340.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4   2015/11/25 By 06948    增加作廢時詢問「是否作廢」
#150826-00008#4   2015/03/04 By xianghui 制造批序号调整
#160314-00009#5   2016/03/17 By zhujing  各程式增加产品特征是否需要自动开窗的程式段处理
#160316-00007#7   2016/03/18 By xianghui 库存管理特征处增加制造批序号处理
#160318-00025#17  2016/04/11 By 07900    校验代码的重复错误讯息修改
#160613-00038#1   2016/06/14 By 06821    s_aooi200_chk_slip傳入值(原寫死程式代號)，改用g_prog處理
#160816-00068#3   2016/08/17 By earl     調整transaction
#160818-00017#37  2016/08/26 By lixh     单据类作业修改，删除时需重新检查状态
#160905-00007#15  2016/09/05 by 08172    调整系统中无ENT的SQL条件增加ent
#161024-00057#11  2016/10/26 By Whitney  刪除sfad_t相關程式
#161124-00048#12  2016/12/13 By xujing   整批调整系统RECORD LIKE xxxx_t.* 星号写法
#160824-00007#285 2016/12/29 by sakura   新舊值備份處理
#160711-00040#32  2017/02/16 By xujing T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                      CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL sub_s_lot  #151012
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_sfea_m        RECORD
       sfeadocno LIKE sfea_t.sfeadocno, 
   sfeadocno_desc LIKE type_t.chr80, 
   sfeasite LIKE sfea_t.sfeasite, 
   sfeadocdt LIKE sfea_t.sfeadocdt, 
   sfea001 LIKE sfea_t.sfea001, 
   sfea002 LIKE sfea_t.sfea002, 
   sfea002_desc LIKE type_t.chr80, 
   sfea003 LIKE sfea_t.sfea003, 
   sfea003_desc LIKE type_t.chr80, 
   sfeastus LIKE sfea_t.sfeastus, 
   sfea006 LIKE sfea_t.sfea006, 
   sfea005 LIKE sfea_t.sfea005, 
   sfeaownid LIKE sfea_t.sfeaownid, 
   sfeaownid_desc LIKE type_t.chr80, 
   sfeaowndp LIKE sfea_t.sfeaowndp, 
   sfeaowndp_desc LIKE type_t.chr80, 
   sfeacrtdt LIKE sfea_t.sfeacrtdt, 
   sfeacrtid LIKE sfea_t.sfeacrtid, 
   sfeacrtid_desc LIKE type_t.chr80, 
   sfeacrtdp LIKE sfea_t.sfeacrtdp, 
   sfeacrtdp_desc LIKE type_t.chr80, 
   sfeamodid LIKE sfea_t.sfeamodid, 
   sfeamodid_desc LIKE type_t.chr80, 
   sfeamoddt LIKE sfea_t.sfeamoddt, 
   sfeacnfid LIKE sfea_t.sfeacnfid, 
   sfeacnfid_desc LIKE type_t.chr80, 
   sfeacnfdt LIKE sfea_t.sfeacnfdt, 
   sfeapstid LIKE sfea_t.sfeapstid, 
   sfeapstid_desc LIKE type_t.chr80, 
   sfeapstdt LIKE sfea_t.sfeapstdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_sfeb_d        RECORD
       sfebseq LIKE sfeb_t.sfebseq, 
   sfeb023 LIKE sfeb_t.sfeb023, 
   sfeb023_desc LIKE type_t.chr500, 
   sfeb023_desc_desc LIKE type_t.chr500, 
   sfeb024 LIKE sfeb_t.sfeb024, 
   sfeb025 LIKE sfeb_t.sfeb025, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfeb003 LIKE sfeb_t.sfeb003, 
   sfeb004 LIKE sfeb_t.sfeb004, 
   sfeb004_desc LIKE type_t.chr500, 
   sfeb004_desc_desc LIKE type_t.chr500, 
   sfeb005 LIKE sfeb_t.sfeb005, 
   sfeb006 LIKE sfeb_t.sfeb006, 
   sfeb007 LIKE sfeb_t.sfeb007, 
   sfeb008 LIKE sfeb_t.sfeb008, 
   sfeb027 LIKE sfeb_t.sfeb027, 
   sfeb009 LIKE sfeb_t.sfeb009, 
   sfeb010 LIKE sfeb_t.sfeb010, 
   sfeb011 LIKE sfeb_t.sfeb011, 
   sfeb012 LIKE sfeb_t.sfeb012, 
   sfeb013 LIKE sfeb_t.sfeb013, 
   sfeb013_desc LIKE type_t.chr500, 
   sfeb014 LIKE sfeb_t.sfeb014, 
   sfeb014_desc LIKE type_t.chr500, 
   sfeb015 LIKE sfeb_t.sfeb015, 
   sfeb016 LIKE sfeb_t.sfeb016, 
   sfeb020 LIKE sfeb_t.sfeb020, 
   sfeb020_desc LIKE type_t.chr500, 
   sfeb021 LIKE sfeb_t.sfeb021, 
   sfeb022 LIKE sfeb_t.sfeb022, 
   ooff013 LIKE ooff_t.ooff013, 
   sfebsite LIKE sfeb_t.sfebsite
       END RECORD
PRIVATE TYPE type_g_sfeb3_d RECORD
       sfecseq LIKE sfec_t.sfecseq, 
   sfecseq1 LIKE sfec_t.sfecseq1, 
   sfec018 LIKE sfec_t.sfec018, 
   sfec018_desc LIKE type_t.chr500, 
   sfec018_desc_desc LIKE type_t.chr500, 
   sfec019 LIKE sfec_t.sfec019, 
   sfec020 LIKE sfec_t.sfec020, 
   sfeb002 LIKE sfeb_t.sfeb002, 
   sfec002 LIKE sfec_t.sfec002, 
   sfec003 LIKE sfec_t.sfec003, 
   sfec003_desc LIKE type_t.chr10, 
   sfec003_desc_desc LIKE type_t.chr500, 
   sfec004 LIKE sfec_t.sfec004, 
   sfec005 LIKE sfec_t.sfec005, 
   sfec005_desc LIKE type_t.chr500, 
   sfec005_desc_desc LIKE type_t.chr500, 
   sfec006 LIKE sfec_t.sfec006, 
   sfec007 LIKE sfec_t.sfec007, 
   sfec008 LIKE sfec_t.sfec008, 
   sfec009 LIKE sfec_t.sfec009, 
   sfec010 LIKE sfec_t.sfec010, 
   sfec011 LIKE sfec_t.sfec011, 
   sfec012 LIKE sfec_t.sfec012, 
   sfec012_desc LIKE type_t.chr500, 
   sfec013 LIKE sfec_t.sfec013, 
   sfec013_desc LIKE type_t.chr500, 
   sfec014 LIKE sfec_t.sfec014, 
   sfec015 LIKE sfec_t.sfec015, 
   sfec016 LIKE sfec_t.sfec016, 
   sfec017 LIKE sfec_t.sfec017, 
   sfecsite LIKE sfec_t.sfecsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_sfeadocno LIKE sfea_t.sfeadocno,
   b_sfeadocno_desc LIKE type_t.chr80,
      b_sfeadocdt LIKE sfea_t.sfeadocdt,
      b_sfea002 LIKE sfea_t.sfea002,
   b_sfea002_desc LIKE type_t.chr80,
      b_sfea003 LIKE sfea_t.sfea003,
   b_sfea003_desc LIKE type_t.chr80,
      b_sfea001 LIKE sfea_t.sfea001,
      b_sfea006 LIKE sfea_t.sfea006,
      b_sfea005 LIKE sfea_t.sfea005
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_inao1_d RECORD
        inaoseq  LIKE inao_t.inaoseq, 
        inaoseq1 LIKE inao_t.inaoseq1, 
        inaoseq2 LIKE inao_t.inaoseq2, 
        inao001  LIKE inao_t.inao001,
        inao001_desc1 LIKE imaal_t.imaal003,
        inao001_desc2  LIKE imaal_t.imaal004,        
        inao008  LIKE inao_t.inao008, 
        inao009  LIKE inao_t.inao009, 
        inao010  LIKE inao_t.inao010, 
        inao012  LIKE inao_t.inao012
        END RECORD
 TYPE type_g_inao_d2 RECORD
        inaoseq  LIKE inao_t.inaoseq, 
        inaoseq1 LIKE inao_t.inaoseq1, 
        inaoseq2 LIKE inao_t.inaoseq2, 
        inao001  LIKE inao_t.inao001, 
        inao001_desc1 LIKE imaal_t.imaal003,
        inao001_desc2  LIKE imaal_t.imaal004,         
        inao008  LIKE inao_t.inao008, 
        inao009  LIKE inao_t.inao009, 
        inao010  LIKE inao_t.inao010, 
        inao012  LIKE inao_t.inao012
        END RECORD
        
DEFINE g_inao1_d   DYNAMIC ARRAY OF type_g_inao1_d
DEFINE g_inao1_d_t type_g_inao1_d

DEFINE g_inao_d2   DYNAMIC ARRAY OF type_g_inao_d2
DEFINE g_inao_d2_t type_g_inao_d2     

DEFINE g_wc2_table3   STRING
DEFINE g_wc2_table4   STRING

DEFINE g_entried      LIKE type_t.num5
DEFINE g_ooff013      LIKE ooff_t.ooff013
DEFINE g_srab000      LIKE srab_t.srab000   #重复性生产计划的版本
DEFINE g_srab002      LIKE srab_t.srab002   #年
DEFINE g_srab003      LIKE srab_t.srab003   #月
DEFINE g_inam         DYNAMIC ARRAY OF RECORD   #記錄產品特徵
                      inam001      LIKE inam_t.inam001,   #料件
                      inam002      LIKE inam_t.inam002,   #特征
                      inam004      LIKE inam_t.inam004    #数量
                      END RECORD

#end add-point
       
#模組變數(Module Variables)
DEFINE g_sfea_m          type_g_sfea_m
DEFINE g_sfea_m_t        type_g_sfea_m
DEFINE g_sfea_m_o        type_g_sfea_m
DEFINE g_sfea_m_mask_o   type_g_sfea_m #轉換遮罩前資料
DEFINE g_sfea_m_mask_n   type_g_sfea_m #轉換遮罩後資料
 
   DEFINE g_sfeadocno_t LIKE sfea_t.sfeadocno
 
 
DEFINE g_sfeb_d          DYNAMIC ARRAY OF type_g_sfeb_d
DEFINE g_sfeb_d_t        type_g_sfeb_d
DEFINE g_sfeb_d_o        type_g_sfeb_d
DEFINE g_sfeb_d_mask_o   DYNAMIC ARRAY OF type_g_sfeb_d #轉換遮罩前資料
DEFINE g_sfeb_d_mask_n   DYNAMIC ARRAY OF type_g_sfeb_d #轉換遮罩後資料
DEFINE g_sfeb3_d          DYNAMIC ARRAY OF type_g_sfeb3_d
DEFINE g_sfeb3_d_t        type_g_sfeb3_d
DEFINE g_sfeb3_d_o        type_g_sfeb3_d
DEFINE g_sfeb3_d_mask_o   DYNAMIC ARRAY OF type_g_sfeb3_d #轉換遮罩前資料
DEFINE g_sfeb3_d_mask_n   DYNAMIC ARRAY OF type_g_sfeb3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
 
{<section id="asrt340.main" >}
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
   CALL cl_ap_init("asr","")
 
   #add-point:作業初始化 name="main.init"
      
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
      
   #end add-point
   LET g_forupd_sql = " SELECT sfeadocno,'',sfeasite,sfeadocdt,sfea001,sfea002,'',sfea003,'',sfeastus, 
       sfea006,sfea005,sfeaownid,'',sfeaowndp,'',sfeacrtdt,sfeacrtid,'',sfeacrtdp,'',sfeamodid,'',sfeamoddt, 
       sfeacnfid,'',sfeacnfdt,sfeapstid,'',sfeapstdt", 
                      " FROM sfea_t",
                      " WHERE sfeaent= ? AND sfeadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt340_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.sfeadocno,t0.sfeasite,t0.sfeadocdt,t0.sfea001,t0.sfea002,t0.sfea003, 
       t0.sfeastus,t0.sfea006,t0.sfea005,t0.sfeaownid,t0.sfeaowndp,t0.sfeacrtdt,t0.sfeacrtid,t0.sfeacrtdp, 
       t0.sfeamodid,t0.sfeamoddt,t0.sfeacnfid,t0.sfeacnfdt,t0.sfeapstid,t0.sfeapstdt,t1.ooag011 ,t2.ooefl003 , 
       t3.ooag011 ,t4.ooefl003 ,t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooag011 ,t9.ooag011",
               " FROM sfea_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sfea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sfea003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.sfeaownid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.sfeaowndp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.sfeacrtid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.sfeacrtdp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.sfeamodid  ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.sfeacnfid  ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.sfeapstid  ",
 
               " WHERE t0.sfeaent = " ||g_enterprise|| " AND t0.sfeadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asrt340_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asrt340 WITH FORM cl_ap_formpath("asr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asrt340_init()   
 
      #進入選單 Menu (="N")
      CALL asrt340_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asrt340
      
   END IF 
   
   CLOSE asrt340_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_lot_sel_drop_tmp()   #add 151012   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asrt340.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asrt340_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('sfeastus','13','A,D,N,R,W,Y,S,Z,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('sfeb003','4019','1,2,5')
   CALL cl_set_combo_scc_part('sfec004','4019','1,2,5')
   #add 151012
   CALL cl_set_toolbaritem_visible("s_lot_ins,s_lot_sel",TRUE) #制造批序号维护、申请制造批序号维护
   CALL cl_ui_replace_sub_window(cl_ap_formpath("sub", "s_lot_s01"), "grid_s_lot", "Table", "s_detail1_s_lot_s01")
   CALL s_lot_ins_create_tmp()
   CALL s_lot_sel_create_tmp()
   #add 151012 end
   #160314-00009#5 zhujing add 2016-3-17---(S)
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("sfeb005",FALSE)
   END IF
   #160314-00009#5 zhujing add 2016-3-17---(E)   
   #end add-point
   
   #初始化搜尋條件
   CALL asrt340_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asrt340.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asrt340_ui_dialog()
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
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_cnt        LIKE type_t.num5
   #add 151012
   DEFINE l_amount  LIKE sfeb_t.sfeb008
   DEFINE l_amountr LIKE sfeb_t.sfeb011
   #add 151012 end
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
            CALL asrt340_insert()
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
         INITIALIZE g_sfea_m.* TO NULL
         CALL g_sfeb_d.clear()
         CALL g_sfeb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asrt340_init()
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
               
               CALL asrt340_fetch('') # reload data
               LET l_ac = 1
               CALL asrt340_ui_detailshow() #Setting the current row 
         
               CALL asrt340_idx_chk()
               #NEXT FIELD sfebseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_sfeb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt340_idx_chk()
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
               CALL asrt340_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                              
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_ins
            LET g_action_choice="s_lot_ins"
            IF cl_auth_chk_act("s_lot_ins") THEN
               
               #add-point:ON ACTION s_lot_ins name="menu.detail_show.page1.s_lot_ins"
               #add 151012--s
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  #单身缺少资料，不可维护！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'abm-00073'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF
               
               IF g_sfea_m.sfeastus <> 'N' THEN
                  #此笔单据状态不是未审核,不可修改！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00035'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF  
               
               IF NOT cl_null(g_sfea_m.sfeadocno) AND
                  NOT cl_null(g_sfeb_d[g_detail_idx].sfebseq) AND
                  NOT cl_null(g_sfeb_d[g_detail_idx].sfeb004) AND #料件
                  NOT cl_null(g_sfeb_d[g_detail_idx].sfeb007) AND #单位
                  NOT cl_null(g_sfeb_d[g_detail_idx].sfeb008) AND #数量
                  NOT cl_null(g_sfeb_d[g_detail_idx].sfeb013) AND 
                  NOT cl_null(g_sfea_m.sfea002) THEN  #申请人
                  LET l_success = ''
                  CALL s_transaction_begin()
                  CALL s_lot_ins(g_site,g_sfea_m.sfeadocno,
                                 #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
                                 g_sfeb_d[g_detail_idx].sfebseq,'1',
                                 #料件編號                        產品特徵
                                 g_sfeb_d[g_detail_idx].sfeb004,g_sfeb_d[g_detail_idx].sfeb005,
                                 #交易單位                      交易數量                 
                                 g_sfeb_d[g_detail_idx].sfeb007,g_sfeb_d[g_detail_idx].sfeb008,
                                 '1',g_sfea_m.sfea002,'1','',g_sfeb_d[g_detail_idx].sfeb013,
                                 g_sfeb_d[g_detail_idx].sfeb014,g_sfeb_d[g_detail_idx].sfeb015,
                                 g_sfeb_d[g_detail_idx].sfeb016
                                 )    #160316-00007#7 add sfeb016
                       RETURNING l_success,l_amount
                  IF l_success THEN
                     IF g_sfeb_d[g_detail_idx].sfeb002 = 'N' THEN
                        IF NOT asrt340_ins_inao() THEN
                           CALL s_transaction_end('N','0')
                           EXIT DIALOG
                        END IF
                     END IF
#                     IF g_sfeb_d[g_detail_idx].sfeb008 <> l_amount THEN
#                        IF cl_ask_confirm('ain-00249') THEN
#                           CALL s_aooi250_convert_qty(g_sfeb_d[g_detail_idx].sfeb004,g_sfeb_d[g_detail_idx].sfeb007,
#                                                      g_sfeb_d[g_detail_idx].sfeb010,g_sfeb_d[g_detail_idx].sfeb008)
#
#                                RETURNING l_success,g_sfeb_d[g_detail_idx].sfeb011
#                           IF g_sfeb_d[g_detail_idx].sfeb002 = 'N' THEN
#                              UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                sfeb009 = l_amount,
#                                                sfeb027 = l_amount,
#                                                sfeb011 = g_sfeb_d[g_detail_idx].sfeb011,
#                                                sfeb012 = g_sfeb_d[g_detail_idx].sfeb011
#                               WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                 AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[g_detail_idx].sfebseq
#                           ELSE
#                              UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                sfeb011 = g_sfeb_d[g_detail_idx].sfeb011
#                               WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                 AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[g_detail_idx].sfebseq
#                           END IF
#                           IF SQLCA.sqlcode THEN
#                              INITIALIZE g_errparam TO NULL
#                              LET g_errparam.code = SQLCA.sqlcode
#                              LET g_errparam.extend = "inbb_t"
#                              LET g_errparam.popup = FALSE
#                              CALL cl_err()
#                              CALL s_transaction_end('N','0')
#                              EXIT DIALOG
#                           ELSE
#                              LET g_sfeb_d[g_detail_idx].sfeb008 = l_amount
#                              IF g_sfeb_d[g_detail_idx].sfeb002 = 'N' THEN
#                                 LET g_sfeb_d[g_detail_idx].sfeb009 = l_amount
#                              END IF
#                           END IF
#                        END IF
#                     END IF
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL asrt340_show()
               END IF
               #151012--e
               #END add-point
               
            END IF
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                        
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_sfeb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt340_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body3.before_row"
                              
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 2
               #顯示單身筆數
               CALL asrt340_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
                              
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_sel
            LET g_action_choice="s_lot_sel"
            IF cl_auth_chk_act("s_lot_sel") THEN
               
               #add-point:ON ACTION s_lot_sel name="menu.detail_show.page2.s_lot_sel"
               IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
                  #未選擇資料,不可執行此操作;请选择一笔明细资料再执行此操作！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00390'  
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF

               IF g_sfea_m.sfeastus <> 'Y' THEN
                  #此笔单据状态不是未审核,不可修改！
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00189'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  EXIT DIALOG
               END IF

               IF NOT cl_null(g_sfeb3_d[g_detail_idx].sfecseq1) AND NOT cl_null(g_sfeb3_d[g_detail_idx].sfec012)THEN
                  LET l_success = ''
                  CALL s_transaction_begin()
                  #IF g_sfeb3_d[g_detail_idx].sfeb002 = 'N' THEN     #150826-00008#4--mark
                     #資料抓取來源'1'代表從現有的製造批序號庫存明細檔inai_t中抓出資料供挑選
                     #           '2'代表從單據對應的申請資料inao_t中抓取出資料供挑選
                     #    資料類型:1.申請資料， 2.實際異動資料
                     CALL s_lot_sel('2','2',
                                    #營運據點 目的單據編號
                                    g_site,g_sfea_m.sfeadocno,
                                    #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
                                    g_sfeb3_d[g_detail_idx].sfecseq,g_sfeb3_d[g_detail_idx].sfecseq1,
                                    #料件編號                        產品特徵
                                    g_sfeb3_d[g_detail_idx].sfec005,g_sfeb3_d[g_detail_idx].sfec006,
                                    #庫存管理特徵                   庫位                    
                                    g_sfeb3_d[g_detail_idx].sfec015,g_sfeb3_d[g_detail_idx].sfec012,
                                    #儲位                          批號                     
                                    g_sfeb3_d[g_detail_idx].sfec013,g_sfeb3_d[g_detail_idx].sfec014,
                                    #交易單位                      交易數量                 
                                    g_sfeb3_d[g_detail_idx].sfec008,g_sfeb3_d[g_detail_idx].sfec009,
                                    #'入庫'  作業編號 營運據點
                                    '1',g_prog,g_site,
                                    #来源單據編號       来源單據項次
                                    g_sfea_m.sfeadocno,g_sfeb3_d[g_detail_idx].sfecseq,
                                    #来源單據項序(若單據沒有到項序層則此參數固定傳0)  启用来源单据
                                    '','1'
                                    )
                          RETURNING l_success
               #150826-00008#4---mark--beg
               #   ELSE
               #      #資料抓取來源'1'代表從現有的製造批序號庫存明細檔inai_t中抓出資料供挑選
               #      #           '2'代表從單據對應的申請資料inao_t中抓取出資料供挑選
               #      #    資料類型:1.申請資料， 2.實際異動資料
               #      CALL s_lot_sel('2','2',
               #                     #營運據點 目的單據編號
               #                     g_site,g_sfea_m.sfeadocno,
               #                     #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
               #                     g_sfeb3_d[g_detail_idx].sfecseq,g_sfeb3_d[g_detail_idx].sfecseq1,
               #                     #料件編號                        產品特徵
               #                     g_sfeb3_d[g_detail_idx].sfec005,g_sfeb3_d[g_detail_idx].sfec006,
               #                     #庫存管理特徵                   庫位                    
               #                     g_sfeb3_d[g_detail_idx].sfec015,g_sfeb3_d[g_detail_idx].sfec012,
               #                     #儲位                          批號                     
               #                     g_sfeb3_d[g_detail_idx].sfec013,g_sfeb3_d[g_detail_idx].sfec014,
               #                     #交易單位                      交易數量                 
               #                     g_sfeb3_d[g_detail_idx].sfec008,g_sfeb3_d[g_detail_idx].sfec009,
               #                     #'入庫'  作業編號 營運據點
               #                     '1',g_prog,g_site,
               #                     #来源單據編號       来源單據項次
               #                     g_sfeb3_d[g_detail_idx].sfec002,g_sfeb3_d[g_detail_idx].sfec003,
               #                     #来源單據項序(若單據沒有到項序層則此參數固定傳0)  启用来源单据
               #                     '0','1'
               #                     )
               #           RETURNING l_success
               #   END IF
               #150826-00008#4---mark--end
                  IF l_success THEN
                     CALL s_transaction_end('Y','0')
                  ELSE
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL asrt340_inao_fill()   #150826-00008#4
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
                        
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
#151012---s
#         DISPLAY ARRAY g_inao1_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
#    
#            BEFORE ROW
#               CALL asrt340_idx_chk()
#               LET l_ac = DIALOG.getCurrentRow("s_detail2")
#               LET g_detail_idx = l_ac
#               
#               #add-point:page2, before row動作
#
#               #end add-point
#               
#            BEFORE DISPLAY
#               CALL FGL_SET_ARR_CURR(g_detail_idx)
#               LET l_ac = DIALOG.getCurrentRow("s_detail2")
#               CALL asrt340_idx_chk()
#               LET g_current_page = 2
#      
#            #自訂ACTION(detail_show,page_2)
#            
#         
#            #add-point:page2自定義行為
#
#            #end add-point
#         
#         END DISPLAY
#151012---e

         DISPLAY ARRAY g_inao_d2 TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL asrt340_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               
               #add-point:page4, before row動作

               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               CALL asrt340_idx_chk()
               LET g_current_page = 4
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為

            #end add-point
         
         END DISPLAY
         SUBDIALOG sub_s_lot.s_lot_display   #151012
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL asrt340_browser_fill("")
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
               CALL asrt340_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asrt340_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asrt340_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                        
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL asrt340_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL asrt340_set_act_visible()   
            CALL asrt340_set_act_no_visible()
            IF NOT (g_sfea_m.sfeadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " sfeaent = " ||g_enterprise|| " AND",
                                  " sfeadocno = '", g_sfea_m.sfeadocno, "' "
 
               #填到對應位置
               CALL asrt340_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "sfea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sfeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sfec_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL asrt340_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "sfea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sfeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sfec_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL asrt340_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asrt340_fetch("F")
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
               CALL asrt340_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asrt340_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt340_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asrt340_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt340_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asrt340_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt340_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asrt340_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt340_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asrt340_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt340_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_sfeb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_sfeb3_d)
                  LET g_export_id[2]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_inao1_d)
                  LET g_export_id[3]   = "s_detail2"
                  
                  LET g_export_node[4] = base.typeInfo.create(g_inao_d2)
                  LET g_export_id[4]   = "s_detail4"

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
               NEXT FIELD sfebseq
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
               CALL asrt340_modify()
               #add-point:ON ACTION modify name="menu.modify"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asrt340_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION qry_issue
            LET g_action_choice="qry_issue"
            IF cl_auth_chk_act("qry_issue") THEN
               
               #add-point:ON ACTION qry_issue name="menu.qry_issue"
               IF NOT cl_null(g_sfea_m.sfeadocno) THEN
                  CALL asrt340_04(g_sfea_m.sfeadocno)
                  LET g_action_choice=''
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL asrt340_delete()
               #add-point:ON ACTION delete name="menu.delete"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asrt340_insert()
               #add-point:ON ACTION insert name="menu.insert"
                              
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION store_in_by_qc
            LET g_action_choice="store_in_by_qc"
            IF cl_auth_chk_act("store_in_by_qc") THEN
               
               #add-point:ON ACTION store_in_by_qc name="menu.store_in_by_qc"
               IF NOT cl_null(g_sfea_m.sfeadocno) THEN
                  CALL s_transaction_begin()
                  CALL s_asft340_gen_store_in_by_fqc(g_sfea_m.sfeadocno)
                       RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y',1)
                  ELSE
                     CALL s_transaction_end('N',1)
                  END IF
                  LET g_action_choice=''
                  CALL asrt340_b_fill()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_fqc
            LET g_action_choice="gen_fqc"
            IF cl_auth_chk_act("gen_fqc") THEN
               
               #add-point:ON ACTION gen_fqc name="menu.gen_fqc"
                                             IF NOT cl_null(g_sfea_m.sfeadocno) THEN
                  CALL s_transaction_begin()
                  CALL asrt340_02(g_sfea_m.sfeadocno)
                       RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y',1)
                  ELSE
                     CALL s_transaction_end('N',1)
                  END IF
                  LET g_action_choice=''
                  CALL asrt340_b_fill()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                              
               #END add-point
               &include "erp/asr/asrt340_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                              
               #END add-point
               &include "erp/asr/asrt340_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asrt340_query()
               #add-point:ON ACTION query name="menu.query"
                              
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION mn_stock_in
            LET g_action_choice="mn_stock_in"
            IF cl_auth_chk_act("mn_stock_in") THEN
               
               #add-point:ON ACTION mn_stock_in name="menu.mn_stock_in"
               IF NOT cl_null(g_sfea_m.sfeadocno) THEN
                  IF g_sfea_m.sfeastus <> 'Y' THEN
                     #非审核状态,不可使用此功能!
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00189'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CONTINUE DIALOG
                  END IF               
                  CALL asrt340_01(g_sfea_m.sfeadocno)
                  LET g_action_choice=''
                  CALL asrt340_b_fill()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aqct300
            LET g_action_choice="open_aqct300"
            IF cl_auth_chk_act("open_aqct300") THEN
               
               #add-point:ON ACTION open_aqct300 name="menu.open_aqct300"
               LET la_param.prog     = "aqct300"
               LET la_param.param[03] = g_sfea_m.sfeadocno
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun(ls_js)

               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_issue_no
            LET g_action_choice="gen_issue_no"
            IF cl_auth_chk_act("gen_issue_no") THEN
               
               #add-point:ON ACTION gen_issue_no name="menu.gen_issue_no"
               IF NOT cl_null(g_sfea_m.sfeadocno) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM sfed_t
                   WHERE sfedent   = g_enterprise
                     AND sfeddocno = g_sfea_m.sfeadocno
                  IF l_cnt >0 THEN
                     #已经产生过倒扣料发料单了,不可重复产生
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00091'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     EXIT DIALOG
                  END IF                  
                  CALL s_asrt310_cre_tmp_table()
                       RETURNING l_success
                  IF NOT l_success THEN
                     EXIT DIALOG
                  END IF
                  CALL s_transaction_begin()
                  CALL asrt340_03(g_sfea_m.sfeadocno)
                       RETURNING l_success
                  IF l_success THEN
                     CALL s_transaction_end('Y',1)
                  ELSE
                     CALL s_transaction_end('N',1)
                  END IF
                  CALL s_asrt310_drop_tmp_table()
                       RETURNING l_success                  
                  IF NOT l_success THEN
                     EXIT DIALOG
                  END IF                  
                  LET g_action_choice=''
                  CALL asrt340_b_fill()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asrt340_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asrt340_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asrt340_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_sfea_m.sfeadocdt)
 
 
 
         
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
 
{<section id="asrt340.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asrt340_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
         DEFINE l_success         LIKE type_t.num5
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
   #CALL g_inao1_d.clear() 
   #CALL g_inao_d2.clear()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT sfeadocno ",
                      " FROM sfea_t ",
                      " ",
                      " LEFT JOIN sfeb_t ON sfebent = sfeaent AND sfeadocno = sfebdocno ", "  ",
                      #add-point:browser_fill段sql(sfeb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN sfec_t ON sfecent = sfeaent AND sfeadocno = sfecdocno", "  ",
                      #add-point:browser_fill段sql(sfec_t1) name="browser_fill.cnt.join.sfec_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE sfeaent = " ||g_enterprise|| " AND sfebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("sfea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT sfeadocno ",
                      " FROM sfea_t ", 
                      "  ",
                      "  ",
                      " WHERE sfeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("sfea_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   LET l_sub_sql = l_sub_sql CLIPPED,"  AND sfea006 IS NOT NULL"
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"   
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
      INITIALIZE g_sfea_m.* TO NULL
      CALL g_sfeb_d.clear()        
      CALL g_sfeb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.sfeadocno,t0.sfeadocdt,t0.sfea002,t0.sfea003,t0.sfea001,t0.sfea006,t0.sfea005 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sfeastus,t0.sfeadocno,t0.sfeadocdt,t0.sfea002,t0.sfea003,t0.sfea001, 
          t0.sfea006,t0.sfea005,t1.ooag011 ,t2.ooefl003 ",
                  " FROM sfea_t t0",
                  "  ",
                  "  LEFT JOIN sfeb_t ON sfebent = sfeaent AND sfeadocno = sfebdocno ", "  ", 
                  #add-point:browser_fill段sql(sfeb_t1) name="browser_fill.join.sfeb_t1"
                  
                  #end add-point
                  "  LEFT JOIN sfec_t ON sfecent = sfeaent AND sfeadocno = sfecdocno", "  ", 
                  #add-point:browser_fill段sql(sfec_t1) name="browser_fill.join.sfec_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sfea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sfea003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.sfeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("sfea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sfeastus,t0.sfeadocno,t0.sfeadocdt,t0.sfea002,t0.sfea003,t0.sfea001, 
          t0.sfea006,t0.sfea005,t1.ooag011 ,t2.ooefl003 ",
                  " FROM sfea_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sfea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sfea003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.sfeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("sfea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY sfeadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   LET g_sql = " SELECT DISTINCT t0.sfeastus,t0.sfeadocno,t0.sfeadocdt,t0.sfea002,t0.sfea003,t0.sfea001, 
       t0.sfea006,t0.sfea005,t1.ooag011 ,t2.ooefl003 ",
               " FROM sfea_t t0",
               "  ",
               "  LEFT JOIN sfeb_t ON sfebent = sfeaent AND sfeadocno = sfebdocno ",
               "  LEFT JOIN sfec_t ON sfecent = sfeaent AND sfeadocno = sfecdocno",
 
 
 
               "  ",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent='"||g_enterprise||"' AND t1.ooag001=t0.sfea002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.sfea003 AND t2.ooefl002='"||g_lang||"' ",
 
               " WHERE t0.sfeaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("sfea_t"),
               "   AND sfea006 IS NOT NULL ",
               "   AND sfeasite = '",g_site,"'",
               " ORDER BY sfeadocno ",g_order

   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"sfea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_sfeadocno,g_browser[g_cnt].b_sfeadocdt, 
          g_browser[g_cnt].b_sfea002,g_browser[g_cnt].b_sfea003,g_browser[g_cnt].b_sfea001,g_browser[g_cnt].b_sfea006, 
          g_browser[g_cnt].b_sfea005,g_browser[g_cnt].b_sfea002_desc,g_browser[g_cnt].b_sfea003_desc 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
                  #取单据说明
      CALL s_aooi200_get_slip_desc(g_browser[g_cnt].b_sfeadocno)
                 RETURNING g_browser[g_cnt].b_sfeadocno_desc
      DISPLAY BY NAME g_browser[g_cnt].b_sfeadocno_desc
      
#      CALL s_desc_get_department_desc(g_browser[g_cnt].b_sfea003)
#           RETURNING g_browser[g_cnt].b_sfea003_desc
#      DISPLAY BY NAME g_browser[g_cnt].b_sfea003_desc
#      
#      CALL s_desc_get_person_desc(g_browser[g_cnt].b_sfea002)
#           RETURNING g_browser[g_cnt].b_sfea002_desc
#      DISPLAY BY NAME g_browser[g_cnt].b_sfea002_desc
      
      
         #end add-point
      
         #遮罩相關處理
         CALL asrt340_browser_mask()
      
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
         WHEN "S"
            LET g_browser[g_cnt].b_statepic = "stus/16/posted.png"
         WHEN "Z"
            LET g_browser[g_cnt].b_statepic = "stus/16/unposted.png"
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
   
   IF cl_null(g_browser[g_cnt].b_sfeadocno) THEN
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
 
{<section id="asrt340.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asrt340_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
      
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_sfea_m.sfeadocno = g_browser[g_current_idx].b_sfeadocno   
 
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
   CALL asrt340_sfea_t_mask()
   CALL asrt340_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asrt340.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asrt340_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
      
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
      
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
         IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asrt340_ui_browser_refresh()
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
      IF g_browser[l_i].b_sfeadocno = g_sfea_m.sfeadocno 
 
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
 
{<section id="asrt340.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asrt340_construct()
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
   INITIALIZE g_sfea_m.* TO NULL
   CALL g_sfeb_d.clear()        
   CALL g_sfeb3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
         CALL g_inao1_d.clear() 
   CALL g_inao_d2.clear() 
   INITIALIZE g_wc2_table3 TO NULL
   INITIALIZE g_wc2_table4 TO NULL
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON sfeadocno,sfeasite,sfeadocdt,sfea001,sfea002,sfea003,sfeastus,sfea006, 
          sfea005,sfeaownid,sfeaowndp,sfeacrtdt,sfeacrtid,sfeacrtdp,sfeamodid,sfeamoddt,sfeacnfid,sfeacnfdt, 
          sfeapstid,sfeapstdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<sfeacrtdt>>----
         AFTER FIELD sfeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<sfeamoddt>>----
         AFTER FIELD sfeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<sfeacnfdt>>----
         AFTER FIELD sfeacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<sfeapstdt>>----
         AFTER FIELD sfeapstdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeadocno
            #add-point:BEFORE FIELD sfeadocno name="construct.b.sfeadocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeadocno
            
            #add-point:AFTER FIELD sfeadocno name="construct.a.sfeadocno"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeadocno
            #add-point:ON ACTION controlp INFIELD sfeadocno name="construct.c.sfeadocno"
                        			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfeadocno()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeadocno  #顯示到畫面上

            NEXT FIELD sfeadocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeasite
            #add-point:BEFORE FIELD sfeasite name="construct.b.sfeasite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeasite
            
            #add-point:AFTER FIELD sfeasite name="construct.a.sfeasite"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeasite
            #add-point:ON ACTION controlp INFIELD sfeasite name="construct.c.sfeasite"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeadocdt
            #add-point:BEFORE FIELD sfeadocdt name="construct.b.sfeadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeadocdt
            
            #add-point:AFTER FIELD sfeadocdt name="construct.a.sfeadocdt"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeadocdt
            #add-point:ON ACTION controlp INFIELD sfeadocdt name="construct.c.sfeadocdt"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea001
            #add-point:BEFORE FIELD sfea001 name="construct.b.sfea001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea001
            
            #add-point:AFTER FIELD sfea001 name="construct.a.sfea001"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea001
            #add-point:ON ACTION controlp INFIELD sfea001 name="construct.c.sfea001"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.sfea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea002
            #add-point:ON ACTION controlp INFIELD sfea002 name="construct.c.sfea002"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfea002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfea002  #顯示到畫面上

            NEXT FIELD sfea002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea002
            #add-point:BEFORE FIELD sfea002 name="construct.b.sfea002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea002
            
            #add-point:AFTER FIELD sfea002 name="construct.a.sfea002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea003
            #add-point:ON ACTION controlp INFIELD sfea003 name="construct.c.sfea003"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfea003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfea003  #顯示到畫面上

            NEXT FIELD sfea003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea003
            #add-point:BEFORE FIELD sfea003 name="construct.b.sfea003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea003
            
            #add-point:AFTER FIELD sfea003 name="construct.a.sfea003"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeastus
            #add-point:BEFORE FIELD sfeastus name="construct.b.sfeastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeastus
            
            #add-point:AFTER FIELD sfeastus name="construct.a.sfeastus"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeastus
            #add-point:ON ACTION controlp INFIELD sfeastus name="construct.c.sfeastus"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea006
            #add-point:BEFORE FIELD sfea006 name="construct.b.sfea006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea006
            
            #add-point:AFTER FIELD sfea006 name="construct.a.sfea006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea006
            #add-point:ON ACTION controlp INFIELD sfea006 name="construct.c.sfea006"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfea006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfea006  #顯示到畫面上
            NEXT FIELD sfea006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea005
            #add-point:BEFORE FIELD sfea005 name="construct.b.sfea005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea005
            
            #add-point:AFTER FIELD sfea005 name="construct.a.sfea005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea005
            #add-point:ON ACTION controlp INFIELD sfea005 name="construct.c.sfea005"
                        			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfea005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfea005  #顯示到畫面上

            NEXT FIELD sfea005 
            #END add-point
 
 
         #Ctrlp:construct.c.sfeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeaownid
            #add-point:ON ACTION controlp INFIELD sfeaownid name="construct.c.sfeaownid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeaownid  #顯示到畫面上

            NEXT FIELD sfeaownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeaownid
            #add-point:BEFORE FIELD sfeaownid name="construct.b.sfeaownid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeaownid
            
            #add-point:AFTER FIELD sfeaownid name="construct.a.sfeaownid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeaowndp
            #add-point:ON ACTION controlp INFIELD sfeaowndp name="construct.c.sfeaowndp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeaowndp  #顯示到畫面上

            NEXT FIELD sfeaowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeaowndp
            #add-point:BEFORE FIELD sfeaowndp name="construct.b.sfeaowndp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeaowndp
            
            #add-point:AFTER FIELD sfeaowndp name="construct.a.sfeaowndp"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeacrtdt
            #add-point:BEFORE FIELD sfeacrtdt name="construct.b.sfeacrtdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.sfeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeacrtid
            #add-point:ON ACTION controlp INFIELD sfeacrtid name="construct.c.sfeacrtid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeacrtid  #顯示到畫面上

            NEXT FIELD sfeacrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeacrtid
            #add-point:BEFORE FIELD sfeacrtid name="construct.b.sfeacrtid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeacrtid
            
            #add-point:AFTER FIELD sfeacrtid name="construct.a.sfeacrtid"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeacrtdp
            #add-point:ON ACTION controlp INFIELD sfeacrtdp name="construct.c.sfeacrtdp"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeacrtdp  #顯示到畫面上

            NEXT FIELD sfeacrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeacrtdp
            #add-point:BEFORE FIELD sfeacrtdp name="construct.b.sfeacrtdp"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeacrtdp
            
            #add-point:AFTER FIELD sfeacrtdp name="construct.a.sfeacrtdp"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeamodid
            #add-point:ON ACTION controlp INFIELD sfeamodid name="construct.c.sfeamodid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeamodid  #顯示到畫面上

            NEXT FIELD sfeamodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeamodid
            #add-point:BEFORE FIELD sfeamodid name="construct.b.sfeamodid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeamodid
            
            #add-point:AFTER FIELD sfeamodid name="construct.a.sfeamodid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeamoddt
            #add-point:BEFORE FIELD sfeamoddt name="construct.b.sfeamoddt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.sfeacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeacnfid
            #add-point:ON ACTION controlp INFIELD sfeacnfid name="construct.c.sfeacnfid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeacnfid  #顯示到畫面上

            NEXT FIELD sfeacnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeacnfid
            #add-point:BEFORE FIELD sfeacnfid name="construct.b.sfeacnfid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeacnfid
            
            #add-point:AFTER FIELD sfeacnfid name="construct.a.sfeacnfid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeacnfdt
            #add-point:BEFORE FIELD sfeacnfdt name="construct.b.sfeacnfdt"
                        
            #END add-point
 
 
         #Ctrlp:construct.c.sfeapstid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeapstid
            #add-point:ON ACTION controlp INFIELD sfeapstid name="construct.c.sfeapstid"
                                    #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeapstid  #顯示到畫面上

            NEXT FIELD sfeapstid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeapstid
            #add-point:BEFORE FIELD sfeapstid name="construct.b.sfeapstid"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeapstid
            
            #add-point:AFTER FIELD sfeapstid name="construct.a.sfeapstid"
                        
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeapstdt
            #add-point:BEFORE FIELD sfeapstdt name="construct.b.sfeapstdt"
                        
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sfebseq,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006, 
          sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb020, 
          sfeb021,sfeb022
           FROM s_detail1[1].sfebseq,s_detail1[1].sfeb023,s_detail1[1].sfeb024,s_detail1[1].sfeb025, 
               s_detail1[1].sfeb002,s_detail1[1].sfeb003,s_detail1[1].sfeb004,s_detail1[1].sfeb005,s_detail1[1].sfeb006, 
               s_detail1[1].sfeb007,s_detail1[1].sfeb008,s_detail1[1].sfeb027,s_detail1[1].sfeb009,s_detail1[1].sfeb010, 
               s_detail1[1].sfeb011,s_detail1[1].sfeb012,s_detail1[1].sfeb013,s_detail1[1].sfeb014,s_detail1[1].sfeb015, 
               s_detail1[1].sfeb016,s_detail1[1].sfeb020,s_detail1[1].sfeb021,s_detail1[1].sfeb022
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebseq
            #add-point:BEFORE FIELD sfebseq name="construct.b.page1.sfebseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebseq
            
            #add-point:AFTER FIELD sfebseq name="construct.a.page1.sfebseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebseq
            #add-point:ON ACTION controlp INFIELD sfebseq name="construct.c.page1.sfebseq"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb023
            #add-point:BEFORE FIELD sfeb023 name="construct.b.page1.sfeb023"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb023
            
            #add-point:AFTER FIELD sfeb023 name="construct.a.page1.sfeb023"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb023
            #add-point:ON ACTION controlp INFIELD sfeb023 name="construct.c.page1.sfeb023"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb023()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb023   #顯示到畫面上
            NEXT FIELD sfeb023
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb024
            #add-point:BEFORE FIELD sfeb024 name="construct.b.page1.sfeb024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb024
            
            #add-point:AFTER FIELD sfeb024 name="construct.a.page1.sfeb024"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb024
            #add-point:ON ACTION controlp INFIELD sfeb024 name="construct.c.page1.sfeb024"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb024()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb024   #顯示到畫面上
            NEXT FIELD sfeb024
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb025
            #add-point:BEFORE FIELD sfeb025 name="construct.b.page1.sfeb025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb025
            
            #add-point:AFTER FIELD sfeb025 name="construct.a.page1.sfeb025"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb025
            #add-point:ON ACTION controlp INFIELD sfeb025 name="construct.c.page1.sfeb025"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb025()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb025   #顯示到畫面上
            NEXT FIELD sfeb025
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb002
            #add-point:BEFORE FIELD sfeb002 name="construct.b.page1.sfeb002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb002
            
            #add-point:AFTER FIELD sfeb002 name="construct.a.page1.sfeb002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb002
            #add-point:ON ACTION controlp INFIELD sfeb002 name="construct.c.page1.sfeb002"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb003
            #add-point:BEFORE FIELD sfeb003 name="construct.b.page1.sfeb003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb003
            
            #add-point:AFTER FIELD sfeb003 name="construct.a.page1.sfeb003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb003
            #add-point:ON ACTION controlp INFIELD sfeb003 name="construct.c.page1.sfeb003"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb004
            #add-point:BEFORE FIELD sfeb004 name="construct.b.page1.sfeb004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb004
            
            #add-point:AFTER FIELD sfeb004 name="construct.a.page1.sfeb004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb004
            #add-point:ON ACTION controlp INFIELD sfeb004 name="construct.c.page1.sfeb004"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb004()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb004   #顯示到畫面上
            NEXT FIELD sfeb004
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb005
            #add-point:BEFORE FIELD sfeb005 name="construct.b.page1.sfeb005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb005
            
            #add-point:AFTER FIELD sfeb005 name="construct.a.page1.sfeb005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb005
            #add-point:ON ACTION controlp INFIELD sfeb005 name="construct.c.page1.sfeb005"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb005()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb005   #顯示到畫面上
            NEXT FIELD sfeb005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb006
            #add-point:BEFORE FIELD sfeb006 name="construct.b.page1.sfeb006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb006
            
            #add-point:AFTER FIELD sfeb006 name="construct.a.page1.sfeb006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb006
            #add-point:ON ACTION controlp INFIELD sfeb006 name="construct.c.page1.sfeb006"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb006()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb006   #顯示到畫面上
            NEXT FIELD sfeb006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb007
            #add-point:BEFORE FIELD sfeb007 name="construct.b.page1.sfeb007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb007
            
            #add-point:AFTER FIELD sfeb007 name="construct.a.page1.sfeb007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb007
            #add-point:ON ACTION controlp INFIELD sfeb007 name="construct.c.page1.sfeb007"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#           CALL q_ooca001_1()                      #呼叫開窗
            CALL q_sfeb007()
            DISPLAY g_qryparam.return1 TO sfeb007   #顯示到畫面上
            NEXT FIELD sfeb007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb008
            #add-point:BEFORE FIELD sfeb008 name="construct.b.page1.sfeb008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb008
            
            #add-point:AFTER FIELD sfeb008 name="construct.a.page1.sfeb008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb008
            #add-point:ON ACTION controlp INFIELD sfeb008 name="construct.c.page1.sfeb008"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb027
            #add-point:BEFORE FIELD sfeb027 name="construct.b.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb027
            
            #add-point:AFTER FIELD sfeb027 name="construct.a.page1.sfeb027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb027
            #add-point:ON ACTION controlp INFIELD sfeb027 name="construct.c.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb009
            #add-point:BEFORE FIELD sfeb009 name="construct.b.page1.sfeb009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb009
            
            #add-point:AFTER FIELD sfeb009 name="construct.a.page1.sfeb009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb009
            #add-point:ON ACTION controlp INFIELD sfeb009 name="construct.c.page1.sfeb009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb010
            #add-point:BEFORE FIELD sfeb010 name="construct.b.page1.sfeb010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb010
            
            #add-point:AFTER FIELD sfeb010 name="construct.a.page1.sfeb010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb010
            #add-point:ON ACTION controlp INFIELD sfeb010 name="construct.c.page1.sfeb010"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#           CALL q_ooca001_1()                      #呼叫開窗
            CALL q_sfeb010()
            DISPLAY g_qryparam.return1 TO sfeb010   #顯示到畫面上
            NEXT FIELD sfeb010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb011
            #add-point:BEFORE FIELD sfeb011 name="construct.b.page1.sfeb011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb011
            
            #add-point:AFTER FIELD sfeb011 name="construct.a.page1.sfeb011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb011
            #add-point:ON ACTION controlp INFIELD sfeb011 name="construct.c.page1.sfeb011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb012
            #add-point:BEFORE FIELD sfeb012 name="construct.b.page1.sfeb012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb012
            
            #add-point:AFTER FIELD sfeb012 name="construct.a.page1.sfeb012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb012
            #add-point:ON ACTION controlp INFIELD sfeb012 name="construct.c.page1.sfeb012"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="construct.b.page1.sfeb013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="construct.a.page1.sfeb013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="construct.c.page1.sfeb013"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#           CALL q_inaa001_2()                      #呼叫開窗
            CALL q_sfeb013()
            DISPLAY g_qryparam.return1 TO sfeb013   #顯示到畫面上
            NEXT FIELD sfeb013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="construct.b.page1.sfeb014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="construct.a.page1.sfeb014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="construct.c.page1.sfeb014"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#           CALL q_inab002_3()                      #呼叫開窗
            CALL q_sfeb014()
            DISPLAY g_qryparam.return1 TO sfeb014   #顯示到畫面上
            NEXT FIELD sfeb014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb015
            #add-point:BEFORE FIELD sfeb015 name="construct.b.page1.sfeb015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb015
            
            #add-point:AFTER FIELD sfeb015 name="construct.a.page1.sfeb015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb015
            #add-point:ON ACTION controlp INFIELD sfeb015 name="construct.c.page1.sfeb015"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE                    #呼叫開窗
            CALL q_sfeb015()
            DISPLAY g_qryparam.return1 TO sfeb015   #顯示到畫面上
            NEXT FIELD sfeb015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb016
            #add-point:BEFORE FIELD sfeb016 name="construct.b.page1.sfeb016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb016
            
            #add-point:AFTER FIELD sfeb016 name="construct.a.page1.sfeb016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb016
            #add-point:ON ACTION controlp INFIELD sfeb016 name="construct.c.page1.sfeb016"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb016()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb016   #顯示到畫面上
            NEXT FIELD sfeb016
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb020
            #add-point:BEFORE FIELD sfeb020 name="construct.b.page1.sfeb020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb020
            
            #add-point:AFTER FIELD sfeb020 name="construct.a.page1.sfeb020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb020
            #add-point:ON ACTION controlp INFIELD sfeb020 name="construct.c.page1.sfeb020"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfeb020()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfeb020   #顯示到畫面上
            NEXT FIELD sfeb020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb021
            #add-point:BEFORE FIELD sfeb021 name="construct.b.page1.sfeb021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb021
            
            #add-point:AFTER FIELD sfeb021 name="construct.a.page1.sfeb021"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb021
            #add-point:ON ACTION controlp INFIELD sfeb021 name="construct.c.page1.sfeb021"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb022
            #add-point:BEFORE FIELD sfeb022 name="construct.b.page1.sfeb022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb022
            
            #add-point:AFTER FIELD sfeb022 name="construct.a.page1.sfeb022"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sfeb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb022
            #add-point:ON ACTION controlp INFIELD sfeb022 name="construct.c.page1.sfeb022"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON sfecseq,sfecseq1,sfec018,sfec019,sfec020,sfec002,sfec003,sfec004,sfec005, 
          sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,sfec016,sfec017 
 
           FROM s_detail3[1].sfecseq,s_detail3[1].sfecseq1,s_detail3[1].sfec018,s_detail3[1].sfec019, 
               s_detail3[1].sfec020,s_detail3[1].sfec002,s_detail3[1].sfec003,s_detail3[1].sfec004,s_detail3[1].sfec005, 
               s_detail3[1].sfec006,s_detail3[1].sfec007,s_detail3[1].sfec008,s_detail3[1].sfec009,s_detail3[1].sfec010, 
               s_detail3[1].sfec011,s_detail3[1].sfec012,s_detail3[1].sfec013,s_detail3[1].sfec014,s_detail3[1].sfec015, 
               s_detail3[1].sfec016,s_detail3[1].sfec017
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfecseq
            #add-point:BEFORE FIELD sfecseq name="construct.b.page3.sfecseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfecseq
            
            #add-point:AFTER FIELD sfecseq name="construct.a.page3.sfecseq"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfecseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfecseq
            #add-point:ON ACTION controlp INFIELD sfecseq name="construct.c.page3.sfecseq"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfecseq1
            #add-point:BEFORE FIELD sfecseq1 name="construct.b.page3.sfecseq1"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfecseq1
            
            #add-point:AFTER FIELD sfecseq1 name="construct.a.page3.sfecseq1"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfecseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfecseq1
            #add-point:ON ACTION controlp INFIELD sfecseq1 name="construct.c.page3.sfecseq1"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec018
            #add-point:BEFORE FIELD sfec018 name="construct.b.page3.sfec018"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec018
            
            #add-point:AFTER FIELD sfec018 name="construct.a.page3.sfec018"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec018
            #add-point:ON ACTION controlp INFIELD sfec018 name="construct.c.page3.sfec018"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec018()                       
            DISPLAY g_qryparam.return1 TO sfec018 
            NEXT FIELD sfec018
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec019
            #add-point:BEFORE FIELD sfec019 name="construct.b.page3.sfec019"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec019
            
            #add-point:AFTER FIELD sfec019 name="construct.a.page3.sfec019"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec019
            #add-point:ON ACTION controlp INFIELD sfec019 name="construct.c.page3.sfec019"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec019()                       
            DISPLAY g_qryparam.return1 TO sfec019
            NEXT FIELD sfec019
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec020
            #add-point:BEFORE FIELD sfec020 name="construct.b.page3.sfec020"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec020
            
            #add-point:AFTER FIELD sfec020 name="construct.a.page3.sfec020"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec020
            #add-point:ON ACTION controlp INFIELD sfec020 name="construct.c.page3.sfec020"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec020()                       
            DISPLAY g_qryparam.return1 TO sfec020
            NEXT FIELD sfec020
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec002
            #add-point:BEFORE FIELD sfec002 name="construct.b.page3.sfec002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec002
            
            #add-point:AFTER FIELD sfec002 name="construct.a.page3.sfec002"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec002
            #add-point:ON ACTION controlp INFIELD sfec002 name="construct.c.page3.sfec002"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec002()                       
            DISPLAY g_qryparam.return1 TO sfec002
            NEXT FIELD sfec002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec003
            #add-point:BEFORE FIELD sfec003 name="construct.b.page3.sfec003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec003
            
            #add-point:AFTER FIELD sfec003 name="construct.a.page3.sfec003"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec003
            #add-point:ON ACTION controlp INFIELD sfec003 name="construct.c.page3.sfec003"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec003()                       
            DISPLAY g_qryparam.return1 TO sfec003
            NEXT FIELD sfec003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec004
            #add-point:BEFORE FIELD sfec004 name="construct.b.page3.sfec004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec004
            
            #add-point:AFTER FIELD sfec004 name="construct.a.page3.sfec004"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec004
            #add-point:ON ACTION controlp INFIELD sfec004 name="construct.c.page3.sfec004"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec005
            #add-point:BEFORE FIELD sfec005 name="construct.b.page3.sfec005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec005
            
            #add-point:AFTER FIELD sfec005 name="construct.a.page3.sfec005"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec005
            #add-point:ON ACTION controlp INFIELD sfec005 name="construct.c.page3.sfec005"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec005()                       
            DISPLAY g_qryparam.return1 TO sfec005
            NEXT FIELD sfec005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec006
            #add-point:BEFORE FIELD sfec006 name="construct.b.page3.sfec006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec006
            
            #add-point:AFTER FIELD sfec006 name="construct.a.page3.sfec006"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec006
            #add-point:ON ACTION controlp INFIELD sfec006 name="construct.c.page3.sfec006"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec006()                       
            DISPLAY g_qryparam.return1 TO sfec006
            NEXT FIELD sfec006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec007
            #add-point:BEFORE FIELD sfec007 name="construct.b.page3.sfec007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec007
            
            #add-point:AFTER FIELD sfec007 name="construct.a.page3.sfec007"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec007
            #add-point:ON ACTION controlp INFIELD sfec007 name="construct.c.page3.sfec007"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec007()                       
            DISPLAY g_qryparam.return1 TO sfec007
            NEXT FIELD sfec007
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec008
            #add-point:BEFORE FIELD sfec008 name="construct.b.page3.sfec008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec008
            
            #add-point:AFTER FIELD sfec008 name="construct.a.page3.sfec008"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec008
            #add-point:ON ACTION controlp INFIELD sfec008 name="construct.c.page3.sfec008"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec008()                       
            DISPLAY g_qryparam.return1 TO sfec008
            NEXT FIELD sfec008
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec009
            #add-point:BEFORE FIELD sfec009 name="construct.b.page3.sfec009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec009
            
            #add-point:AFTER FIELD sfec009 name="construct.a.page3.sfec009"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec009
            #add-point:ON ACTION controlp INFIELD sfec009 name="construct.c.page3.sfec009"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec010
            #add-point:BEFORE FIELD sfec010 name="construct.b.page3.sfec010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec010
            
            #add-point:AFTER FIELD sfec010 name="construct.a.page3.sfec010"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec010
            #add-point:ON ACTION controlp INFIELD sfec010 name="construct.c.page3.sfec010"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec010()                       
            DISPLAY g_qryparam.return1 TO sfec010
            NEXT FIELD sfec010
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec011
            #add-point:BEFORE FIELD sfec011 name="construct.b.page3.sfec011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec011
            
            #add-point:AFTER FIELD sfec011 name="construct.a.page3.sfec011"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec011
            #add-point:ON ACTION controlp INFIELD sfec011 name="construct.c.page3.sfec011"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec012
            #add-point:BEFORE FIELD sfec012 name="construct.b.page3.sfec012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec012
            
            #add-point:AFTER FIELD sfec012 name="construct.a.page3.sfec012"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec012
            #add-point:ON ACTION controlp INFIELD sfec012 name="construct.c.page3.sfec012"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec012()                       
            DISPLAY g_qryparam.return1 TO sfec012
            NEXT FIELD sfec012
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec013
            #add-point:BEFORE FIELD sfec013 name="construct.b.page3.sfec013"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec013
            
            #add-point:AFTER FIELD sfec013 name="construct.a.page3.sfec013"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec013
            #add-point:ON ACTION controlp INFIELD sfec013 name="construct.c.page3.sfec013"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec013()                       
            DISPLAY g_qryparam.return1 TO sfec013
            NEXT FIELD sfec013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec014
            #add-point:BEFORE FIELD sfec014 name="construct.b.page3.sfec014"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec014
            
            #add-point:AFTER FIELD sfec014 name="construct.a.page3.sfec014"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec014
            #add-point:ON ACTION controlp INFIELD sfec014 name="construct.c.page3.sfec014"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec014()                       
            DISPLAY g_qryparam.return1 TO sfec014
            NEXT FIELD sfec014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec015
            #add-point:BEFORE FIELD sfec015 name="construct.b.page3.sfec015"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec015
            
            #add-point:AFTER FIELD sfec015 name="construct.a.page3.sfec015"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec015
            #add-point:ON ACTION controlp INFIELD sfec015 name="construct.c.page3.sfec015"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfec015()                       
            DISPLAY g_qryparam.return1 TO sfec015
            NEXT FIELD sfec015
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec016
            #add-point:BEFORE FIELD sfec016 name="construct.b.page3.sfec016"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec016
            
            #add-point:AFTER FIELD sfec016 name="construct.a.page3.sfec016"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec016
            #add-point:ON ACTION controlp INFIELD sfec016 name="construct.c.page3.sfec016"
                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfec017
            #add-point:BEFORE FIELD sfec017 name="construct.b.page3.sfec017"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfec017
            
            #add-point:AFTER FIELD sfec017 name="construct.a.page3.sfec017"
                        
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.sfec017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfec017
            #add-point:ON ACTION controlp INFIELD sfec017 name="construct.c.page3.sfec017"
                        
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
                  CONSTRUCT g_wc2_table3 ON inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao010,inao012,inaoseq_1,inaoseq1_1,inaoseq2_1,inao001_1,inao008_1,inao009_1,inao010_1,inao012_1
           FROM s_detail2[1].inaoseq,s_detail2[1].inaoseq1,s_detail2[1].inaoseq2,s_detail2[1].inao001,s_detail2[1].inao008,s_detail2[1].inao009,s_detail2[1].inao010,s_detail2[1].inao012,s_detail4[1].inaoseq_1,s_detail4[1].inaoseq1_1,s_detail4[1].inaoseq2_1,s_detail4[1].inao001_1,s_detail4[1].inao008_1,s_detail4[1].inao009_1,s_detail4[1].inao010_1,s_detail4[1].inao012_1
                      
         BEFORE CONSTRUCT
           # CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<inaoseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq
            #add-point:BEFORE FIELD inaoseq

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq
            
            #add-point:AFTER FIELD inaoseq

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq
         ON ACTION controlp INFIELD inaoseq
            #add-point:ON ACTION controlp INFIELD inaoseq

            #END add-point

         #----<<inaoseq1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq1
            #add-point:BEFORE FIELD inaoseq1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq1
            
            #add-point:AFTER FIELD inaoseq1

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq1
         ON ACTION controlp INFIELD inaoseq1
            #add-point:ON ACTION controlp INFIELD inaoseq1

            #END add-point

         #----<<inaoseq2>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq2
            #add-point:BEFORE FIELD inaoseq2

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq2
            
            #add-point:AFTER FIELD inaoseq2

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq2
         ON ACTION controlp INFIELD inaoseq2
            #add-point:ON ACTION controlp INFIELD inaoseq2

            #END add-point

         #----<<inao001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao001
            #add-point:BEFORE FIELD inao001

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao001
            
            #add-point:AFTER FIELD inao001

            #END add-point
            

         #Ctrlp:construct.c.page2.inao001
         ON ACTION controlp INFIELD inao001
            #add-point:ON ACTION controlp INFIELD inao001

            #END add-point

         #----<<inao008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao008
            #add-point:BEFORE FIELD inao008

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao008
            
            #add-point:AFTER FIELD inao008

            #END add-point
            

         #Ctrlp:construct.c.page2.inao008
         ON ACTION controlp INFIELD inao008
            #add-point:ON ACTION controlp INFIELD inao008

            #END add-point

         #----<<inao009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao009
            #add-point:BEFORE FIELD inao009

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao009
            
            #add-point:AFTER FIELD inao009

            #END add-point
            

         #Ctrlp:construct.c.page2.inao009
         ON ACTION controlp INFIELD inao009
            #add-point:ON ACTION controlp INFIELD inao009

            #END add-point

         #----<<inao010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao010
            #add-point:BEFORE FIELD inao010

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao010
            
            #add-point:AFTER FIELD inao010

            #END add-point
            

         #Ctrlp:construct.c.page2.inao010
         ON ACTION controlp INFIELD inao010
            #add-point:ON ACTION controlp INFIELD inao010

            #END add-point

         #----<<inao012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao012
            #add-point:BEFORE FIELD inao012

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao012
            
            #add-point:AFTER FIELD inao012

            #END add-point
            

         #Ctrlp:construct.c.page2.inao012
         ON ACTION controlp INFIELD inao012
            #add-point:ON ACTION controlp INFIELD inao012

            #END add-point

#---------------------<  Detail: page4  >---------------------
         #----<<inaoseq_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq_1
            #add-point:BEFORE FIELD inaoseq_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq_1
            
            #add-point:AFTER FIELD inaoseq_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq_1
         ON ACTION controlp INFIELD inaoseq_1
            #add-point:ON ACTION controlp INFIELD inaoseq_1

            #END add-point

         #----<<inaoseq1_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq1_1
            #add-point:BEFORE FIELD inaoseq1_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq1_1
            
            #add-point:AFTER FIELD inaoseq1_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq1_1
         ON ACTION controlp INFIELD inaoseq1_1
            #add-point:ON ACTION controlp INFIELD inaoseq1_1

            #END add-point

         #----<<inaoseq2_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq2_1
            #add-point:BEFORE FIELD inaoseq2_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq2_1
            
            #add-point:AFTER FIELD inaoseq2_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq2_1
         ON ACTION controlp INFIELD inaoseq2_1
            #add-point:ON ACTION controlp INFIELD inaoseq2_1

            #END add-point

         #----<<inao001_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao001_1
            #add-point:BEFORE FIELD inao001_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao001_1
            
            #add-point:AFTER FIELD inao001_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao001_1
         ON ACTION controlp INFIELD inao001_1
            #add-point:ON ACTION controlp INFIELD inao001_1

            #END add-point

         #----<<inao008_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao008_1
            #add-point:BEFORE FIELD inao008_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao008_1
            
            #add-point:AFTER FIELD inao008_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao008_1
         ON ACTION controlp INFIELD inao008_1
            #add-point:ON ACTION controlp INFIELD inao008_1

            #END add-point

         #----<<inao009_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao009_1
            #add-point:BEFORE FIELD inao009_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao009_1
            
            #add-point:AFTER FIELD inao009_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao009_1
         ON ACTION controlp INFIELD inao009_1
            #add-point:ON ACTION controlp INFIELD inao009_1

            #END add-point

         #----<<inao010_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao010_1
            #add-point:BEFORE FIELD inao010_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao010_1
            
            #add-point:AFTER FIELD inao010_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao010_1
         ON ACTION controlp INFIELD inao010_1
            #add-point:ON ACTION controlp INFIELD inao010_1

            #END add-point

         #----<<inao012_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao012_1
            #add-point:BEFORE FIELD inao012_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao012_1
            
            #add-point:AFTER FIELD inao012_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao012_1
         ON ACTION controlp INFIELD inao012_1
            #add-point:ON ACTION controlp INFIELD inao012_1

            #END add-point

   
       
      END CONSTRUCT

      CONSTRUCT g_wc2_table4 ON inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao010,inao012,inaoseq_1,inaoseq1_1,inaoseq2_1,inao001_1,inao008_1,inao009_1,inao010_1,inao012_1
           FROM s_detail4[1].inaoseq,s_detail4[1].inaoseq1,s_detail4[1].inaoseq2,s_detail4[1].inao001,s_detail4[1].inao008,s_detail4[1].inao009,s_detail4[1].inao010,s_detail4[1].inao012,s_detail4[1].inaoseq_1,s_detail4[1].inaoseq1_1,s_detail4[1].inaoseq2_1,s_detail4[1].inao001_1,s_detail4[1].inao008_1,s_detail4[1].inao009_1,s_detail4[1].inao010_1,s_detail4[1].inao012_1
                      
         BEFORE CONSTRUCT
            #CALL cl_qbe_display_condition(lc_qbe_sn)
            #add-point:cs段before_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page4  >---------------------
         #----<<inaoseq>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq
            #add-point:BEFORE FIELD inaoseq

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq
            
            #add-point:AFTER FIELD inaoseq

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq
         ON ACTION controlp INFIELD inaoseq
            #add-point:ON ACTION controlp INFIELD inaoseq

            #END add-point

         #----<<inaoseq1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq1
            #add-point:BEFORE FIELD inaoseq1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq1
            
            #add-point:AFTER FIELD inaoseq1

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq1
         ON ACTION controlp INFIELD inaoseq1
            #add-point:ON ACTION controlp INFIELD inaoseq1

            #END add-point

         #----<<inaoseq2>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq2
            #add-point:BEFORE FIELD inaoseq2

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq2
            
            #add-point:AFTER FIELD inaoseq2

            #END add-point
            

         #Ctrlp:construct.c.page2.inaoseq2
         ON ACTION controlp INFIELD inaoseq2
            #add-point:ON ACTION controlp INFIELD inaoseq2

            #END add-point

         #----<<inao001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao001
            #add-point:BEFORE FIELD inao001

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao001
            
            #add-point:AFTER FIELD inao001

            #END add-point
            

         #Ctrlp:construct.c.page2.inao001
         ON ACTION controlp INFIELD inao001
            #add-point:ON ACTION controlp INFIELD inao001

            #END add-point

         #----<<inao008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao008
            #add-point:BEFORE FIELD inao008

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao008
            
            #add-point:AFTER FIELD inao008

            #END add-point
            

         #Ctrlp:construct.c.page2.inao008
         ON ACTION controlp INFIELD inao008
            #add-point:ON ACTION controlp INFIELD inao008

            #END add-point

         #----<<inao009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao009
            #add-point:BEFORE FIELD inao009

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao009
            
            #add-point:AFTER FIELD inao009

            #END add-point
            

         #Ctrlp:construct.c.page2.inao009
         ON ACTION controlp INFIELD inao009
            #add-point:ON ACTION controlp INFIELD inao009

            #END add-point

         #----<<inao010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao010
            #add-point:BEFORE FIELD inao010

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao010
            
            #add-point:AFTER FIELD inao010

            #END add-point
            

         #Ctrlp:construct.c.page2.inao010
         ON ACTION controlp INFIELD inao010
            #add-point:ON ACTION controlp INFIELD inao010

            #END add-point

         #----<<inao012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao012
            #add-point:BEFORE FIELD inao012

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao012
            
            #add-point:AFTER FIELD inao012

            #END add-point
            

         #Ctrlp:construct.c.page2.inao012
         ON ACTION controlp INFIELD inao012
            #add-point:ON ACTION controlp INFIELD inao012

            #END add-point

#---------------------<  Detail: page4  >---------------------
         #----<<inaoseq_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq_1
            #add-point:BEFORE FIELD inaoseq_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq_1
            
            #add-point:AFTER FIELD inaoseq_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq_1
         ON ACTION controlp INFIELD inaoseq_1
            #add-point:ON ACTION controlp INFIELD inaoseq_1

            #END add-point

         #----<<inaoseq1_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq1_1
            #add-point:BEFORE FIELD inaoseq1_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq1_1
            
            #add-point:AFTER FIELD inaoseq1_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq1_1
         ON ACTION controlp INFIELD inaoseq1_1
            #add-point:ON ACTION controlp INFIELD inaoseq1_1

            #END add-point

         #----<<inaoseq2_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inaoseq2_1
            #add-point:BEFORE FIELD inaoseq2_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inaoseq2_1
            
            #add-point:AFTER FIELD inaoseq2_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inaoseq2_1
         ON ACTION controlp INFIELD inaoseq2_1
            #add-point:ON ACTION controlp INFIELD inaoseq2_1

            #END add-point

         #----<<inao001_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao001_1
            #add-point:BEFORE FIELD inao001_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao001_1
            
            #add-point:AFTER FIELD inao001_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao001_1
         ON ACTION controlp INFIELD inao001_1
            #add-point:ON ACTION controlp INFIELD inao001_1

            #END add-point

         #----<<inao008_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao008_1
            #add-point:BEFORE FIELD inao008_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao008_1
            
            #add-point:AFTER FIELD inao008_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao008_1
         ON ACTION controlp INFIELD inao008_1
            #add-point:ON ACTION controlp INFIELD inao008_1

            #END add-point

         #----<<inao009_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao009_1
            #add-point:BEFORE FIELD inao009_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao009_1
            
            #add-point:AFTER FIELD inao009_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao009_1
         ON ACTION controlp INFIELD inao009_1
            #add-point:ON ACTION controlp INFIELD inao009_1

            #END add-point

         #----<<inao010_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao010_1
            #add-point:BEFORE FIELD inao010_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao010_1
            
            #add-point:AFTER FIELD inao010_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao010_1
         ON ACTION controlp INFIELD inao010_1
            #add-point:ON ACTION controlp INFIELD inao010_1

            #END add-point

         #----<<inao012_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD inao012_1
            #add-point:BEFORE FIELD inao012_1

            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD inao012_1
            
            #add-point:AFTER FIELD inao012_1

            #END add-point
            

         #Ctrlp:construct.c.page4.inao012_1
         ON ACTION controlp INFIELD inao012_1
            #add-point:ON ACTION controlp INFIELD inao012_1

            #END add-point

   
       
      END CONSTRUCT

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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "sfea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sfeb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sfec_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
         IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
   
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table4
   END IF
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asrt340_filter()
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
      CONSTRUCT g_wc_filter ON sfeadocno,sfeadocdt,sfea002,sfea003,sfea001,sfea006,sfea005
                          FROM s_browse[1].b_sfeadocno,s_browse[1].b_sfeadocdt,s_browse[1].b_sfea002, 
                              s_browse[1].b_sfea003,s_browse[1].b_sfea001,s_browse[1].b_sfea006,s_browse[1].b_sfea005 
 
 
         BEFORE CONSTRUCT
               DISPLAY asrt340_filter_parser('sfeadocno') TO s_browse[1].b_sfeadocno
            DISPLAY asrt340_filter_parser('sfeadocdt') TO s_browse[1].b_sfeadocdt
            DISPLAY asrt340_filter_parser('sfea002') TO s_browse[1].b_sfea002
            DISPLAY asrt340_filter_parser('sfea003') TO s_browse[1].b_sfea003
            DISPLAY asrt340_filter_parser('sfea001') TO s_browse[1].b_sfea001
            DISPLAY asrt340_filter_parser('sfea006') TO s_browse[1].b_sfea006
            DISPLAY asrt340_filter_parser('sfea005') TO s_browse[1].b_sfea005
      
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
 
      CALL asrt340_filter_show('sfeadocno')
   CALL asrt340_filter_show('sfeadocdt')
   CALL asrt340_filter_show('sfea002')
   CALL asrt340_filter_show('sfea003')
   CALL asrt340_filter_show('sfea001')
   CALL asrt340_filter_show('sfea006')
   CALL asrt340_filter_show('sfea005')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asrt340_filter_parser(ps_field)
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
 
{<section id="asrt340.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asrt340_filter_show(ps_field)
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
   LET ls_condition = asrt340_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asrt340_query()
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
   CALL g_sfeb_d.clear()
   CALL g_sfeb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   #CALL g_inao_d.clear()    #151012
   CALL g_inao_d2.clear()   #151012      
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asrt340_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asrt340_browser_fill("")
      CALL asrt340_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL asrt340_filter_show('sfeadocno')
   CALL asrt340_filter_show('sfeadocdt')
   CALL asrt340_filter_show('sfea002')
   CALL asrt340_filter_show('sfea003')
   CALL asrt340_filter_show('sfea001')
   CALL asrt340_filter_show('sfea006')
   CALL asrt340_filter_show('sfea005')
   CALL asrt340_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asrt340_fetch("F") 
      #顯示單身筆數
      CALL asrt340_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asrt340_fetch(p_flag)
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
   
   LET g_sfea_m.sfeadocno = g_browser[g_current_idx].b_sfeadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
   #遮罩相關處理
   LET g_sfea_m_mask_o.* =  g_sfea_m.*
   CALL asrt340_sfea_t_mask()
   LET g_sfea_m_mask_n.* =  g_sfea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt340_set_act_visible()   
   CALL asrt340_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
      
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
      
   #end add-point
   
   #保存單頭舊值
   LET g_sfea_m_t.* = g_sfea_m.*
   LET g_sfea_m_o.* = g_sfea_m.*
   
   LET g_data_owner = g_sfea_m.sfeaownid      
   LET g_data_dept  = g_sfea_m.sfeaowndp
   
   #重新顯示   
   CALL asrt340_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.insert" >}
#+ 資料新增
PRIVATE FUNCTION asrt340_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
      
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sfeb_d.clear()   
   CALL g_sfeb3_d.clear()  
 
 
   INITIALIZE g_sfea_m.* TO NULL             #DEFAULT 設定
   
   LET g_sfeadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   #add 151012---s
   #CALL g_inao_d.clear() 
   CALL g_inao_d2.clear()
   CALL s_lot_clear_detail()
   #add 151012---e
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sfea_m.sfeaownid = g_user
      LET g_sfea_m.sfeaowndp = g_dept
      LET g_sfea_m.sfeacrtid = g_user
      LET g_sfea_m.sfeacrtdp = g_dept 
      LET g_sfea_m.sfeacrtdt = cl_get_current()
      LET g_sfea_m.sfeamodid = g_user
      LET g_sfea_m.sfeamoddt = cl_get_current()
      LET g_sfea_m.sfeastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_sfea_m_t.* TO NULL
      LET g_sfea_m.sfeastus = 'N'
      LET g_sfea_m.sfeadocdt = cl_get_today()
      LET g_sfea_m.sfea001 = cl_get_today()
      LET g_sfea_m.sfea002 = g_user
      LET g_sfea_m.sfea003 = g_dept
      LET g_sfea_m.sfeasite = g_site
      CALL asrt340_set_sfea006()
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_sfea_m_t.* = g_sfea_m.*
      LET g_sfea_m_o.* = g_sfea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sfea_m.sfeastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL asrt340_input("a")
      
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
         INITIALIZE g_sfea_m.* TO NULL
         INITIALIZE g_sfeb_d TO NULL
         INITIALIZE g_sfeb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         #add 151012  --begin--
         #INITIALIZE g_inao_d TO NULL
         INITIALIZE g_inao_d2 TO NULL
         #add 151012  --end--
         #end add-point 
         CALL asrt340_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_sfeb_d.clear()
      #CALL g_sfeb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt340_set_act_visible()   
   CALL asrt340_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " sfeaent = " ||g_enterprise|| " AND",
                      " sfeadocno = '", g_sfea_m.sfeadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asrt340_cl
   
   CALL asrt340_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
   
   #遮罩相關處理
   LET g_sfea_m_mask_o.* =  g_sfea_m.*
   CALL asrt340_sfea_t_mask()
   LET g_sfea_m_mask_n.* =  g_sfea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeadocno_desc,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001, 
       g_sfea_m.sfea002,g_sfea_m.sfea002_desc,g_sfea_m.sfea003,g_sfea_m.sfea003_desc,g_sfea_m.sfeastus, 
       g_sfea_m.sfea006,g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaownid_desc,g_sfea_m.sfeaowndp, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp, 
       g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid,g_sfea_m.sfeamodid_desc,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstid_desc,g_sfea_m.sfeapstdt 
 
   
   #add-point:新增結束後 name="insert.after"
   CALL asrt340_show()
   #end add-point 
   
   LET g_data_owner = g_sfea_m.sfeaownid      
   LET g_data_dept  = g_sfea_m.sfeaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt340_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.modify" >}
#+ 資料修改
PRIVATE FUNCTION asrt340_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
         IF g_sfea_m.sfeastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = g_sfea_m.sfeastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_sfea_m_t.* = g_sfea_m.*
   LET g_sfea_m_o.* = g_sfea_m.*
   
   IF g_sfea_m.sfeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
   CALL s_transaction_begin()
   
   OPEN asrt340_cl USING g_enterprise,g_sfea_m.sfeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt340_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
   #檢查是否允許此動作
   IF NOT asrt340_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sfea_m_mask_o.* =  g_sfea_m.*
   CALL asrt340_sfea_t_mask()
   LET g_sfea_m_mask_n.* =  g_sfea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL asrt340_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_sfea_m.sfeamodid = g_user 
LET g_sfea_m.sfeamoddt = cl_get_current()
LET g_sfea_m.sfeamodid_desc = cl_get_username(g_sfea_m.sfeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_sfea_m.sfeastus MATCHES "[DR]" THEN
         LET g_sfea_m.sfeastus = "N"
      END IF       
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asrt340_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
            
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE sfea_t SET (sfeamodid,sfeamoddt) = (g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt)
          WHERE sfeaent = g_enterprise AND sfeadocno = g_sfeadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_sfea_m.* = g_sfea_m_t.*
            CALL asrt340_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_sfea_m.sfeadocno != g_sfea_m_t.sfeadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                  
         #end add-point
         
         #更新單身key值
         UPDATE sfeb_t SET sfebdocno = g_sfea_m.sfeadocno
 
          WHERE sfebent = g_enterprise AND sfebdocno = g_sfea_m_t.sfeadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                  
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sfeb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
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
         
         UPDATE sfec_t
            SET sfecdocno = g_sfea_m.sfeadocno
 
          WHERE sfecent = g_enterprise AND
                sfecdocno = g_sfeadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                  
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sfec_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfec_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
                           #更新 申请制造批序号明细档inao000='1'
         #更新 入库制造批序号明细档inao000='2'         
         UPDATE inao_t
            SET inaodocno = g_sfea_m.sfeadocno

          WHERE inaoent = g_enterprise AND inaosite = g_site 
            AND inaodocno = g_sfeadocno_t
            AND ( inao000 = '1' OR inao000 = '2')
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "inao_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "inao_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE          
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt340_set_act_visible()   
   CALL asrt340_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " sfeaent = " ||g_enterprise|| " AND",
                      " sfeadocno = '", g_sfea_m.sfeadocno, "' "
 
   #填到對應位置
   CALL asrt340_browser_fill("")
 
   CLOSE asrt340_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt340_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asrt340.input" >}
#+ 資料輸入
PRIVATE FUNCTION asrt340_input(p_cmd)
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
   DEFINE  l_str           STRING
   DEFINE  l_valid         LIKE type_t.chr10
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_ooef004       LIKE ooef_t.ooef004
   DEFINE  l_pos           LIKE type_t.num5
   DEFINE  l_sfac002       LIKE sfac_t.sfac002
   DEFINE  l_imaa005       LIKE imaa_t.imaa005
   DEFINE  l_close_dd      LIKE type_t.dat
   DEFINE  l_where         STRING
   #add 151012 --begin
   DEFINE l_imaf071        LIKE imaf_t.imaf071
   DEFINE l_imaf081        LIKE imaf_t.imaf081
   DEFINE l_amount         LIKE sfeb_t.sfeb008
   DEFINE l_amountr        LIKE sfeb_t.sfeb011
   #add 151012 --end
   DEFINE l_sql1           STRING #160711-00040#32 add
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
   DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeadocno_desc,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001, 
       g_sfea_m.sfea002,g_sfea_m.sfea002_desc,g_sfea_m.sfea003,g_sfea_m.sfea003_desc,g_sfea_m.sfeastus, 
       g_sfea_m.sfea006,g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaownid_desc,g_sfea_m.sfeaowndp, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp, 
       g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid,g_sfea_m.sfeamodid_desc,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstid_desc,g_sfea_m.sfeapstdt 
 
   
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
   LET g_forupd_sql = "SELECT sfebseq,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006, 
       sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb020, 
       sfeb021,sfeb022,sfebsite FROM sfeb_t WHERE sfebent=? AND sfebdocno=? AND sfebseq=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql"
      
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt340_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
      
   #end add-point    
   LET g_forupd_sql = "SELECT sfecseq,sfecseq1,sfec018,sfec019,sfec020,sfec002,sfec003,sfec004,sfec005, 
       sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,sfec016,sfec017, 
       sfecsite FROM sfec_t WHERE sfecent=? AND sfecdocno=? AND sfecseq=? AND sfecseq1=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql2"
      
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt340_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
      
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asrt340_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
      
   #end add-point
   CALL asrt340_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002, 
       g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006,g_sfea_m.sfea005
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
#   CALL s_aooi360_sel('6',g_sfea_m.sfeadocno,'','','','','','','','','','4')
#      RETURNING l_success,g_ooff013
#   DISPLAY g_ooff013 TO FORMONLY.ooff013
   LET g_ooff013 = ''
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asrt340.input.head" >}
      #單頭段
      INPUT BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002, 
          g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006,g_sfea_m.sfea005 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asrt340_cl USING g_enterprise,g_sfea_m.sfeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt340_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt340_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asrt340_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
                        
            #end add-point
            CALL asrt340_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeadocno
            
            #add-point:AFTER FIELD sfeadocno name="input.a.sfeadocno"
                                    #此段落由子樣板a05產生
            IF  NOT cl_null(g_sfea_m.sfeadocno) THEN 
               #检查单别
               #CALL s_aooi200_chk_slip(g_site,'',g_sfea_m.sfeadocno,'asrt340') #160613-00038#1 mark
               CALL s_aooi200_chk_slip(g_site,'',g_sfea_m.sfeadocno,g_prog)     #160613-00038#1 add
               RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
               
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sfea_m.sfeadocno != g_sfeadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfea_t WHERE "||"sfeaent = '" ||g_enterprise|| "' AND "||"sfeadocno = '"||g_sfea_m.sfeadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  CALL asft340_get_doc_default()                  
               END IF
            END IF

            CALL s_aooi200_get_slip_desc(g_sfea_m.sfeadocno)
                 RETURNING g_sfea_m.sfeadocno_desc
            DISPLAY BY NAME g_sfea_m.sfeadocno_desc
            CALL asrt340_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeadocno
            #add-point:BEFORE FIELD sfeadocno name="input.b.sfeadocno"
            CALL asrt340_set_entry(p_cmd)           
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeadocno
            #add-point:ON CHANGE sfeadocno name="input.g.sfeadocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeasite
            #add-point:BEFORE FIELD sfeasite name="input.b.sfeasite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeasite
            
            #add-point:AFTER FIELD sfeasite name="input.a.sfeasite"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeasite
            #add-point:ON CHANGE sfeasite name="input.g.sfeasite"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeadocdt
            #add-point:BEFORE FIELD sfeadocdt name="input.b.sfeadocdt"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeadocdt
            
            #add-point:AFTER FIELD sfeadocdt name="input.a.sfeadocdt"
            LET l_close_dd = cl_get_para(g_enterprise,g_site,'S-MFG-0031')
            IF g_sfea_m.sfea001 < l_close_dd THEN
               #过帐日期小于关帐日期,不可进行过帐还原
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00105'
               LET g_errparam.extend = g_sfea_m.sfea001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_sfea_m.sfeadocdt = g_sfea_m_t.sfeadocdt
               DISPLAY BY NAME g_sfea_m.sfeadocdt
               NEXT FIELD sfeadocdt
            END IF
            CALL asrt340_get_srab000()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeadocdt
            #add-point:ON CHANGE sfeadocdt name="input.g.sfeadocdt"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea001
            #add-point:BEFORE FIELD sfea001 name="input.b.sfea001"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea001
            
            #add-point:AFTER FIELD sfea001 name="input.a.sfea001"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfea001
            #add-point:ON CHANGE sfea001 name="input.g.sfea001"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea002
            
            #add-point:AFTER FIELD sfea002 name="input.a.sfea002"
            IF NOT cl_null(g_sfea_m.sfea002) THEN
               IF cl_null(g_sfea_m_t.sfea002) OR g_sfea_m.sfea002 != g_sfea_m_t.sfea002 THEN 
                  IF NOT s_employee_chk(g_sfea_m.sfea002) THEN
                     LET g_sfea_m.sfea002 = g_sfea_m_t.sfea002
                     DISPLAY BY NAME g_sfea_m.sfea002                  
                     NEXT FIELD sfea002
                  END IF
               END IF
            END IF
            LET g_sfea_m.sfea002_desc = s_desc_get_person_desc(g_sfea_m.sfea002)
            DISPLAY BY NAME g_sfea_m.sfea002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea002
            #add-point:BEFORE FIELD sfea002 name="input.b.sfea002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfea002
            #add-point:ON CHANGE sfea002 name="input.g.sfea002"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea003
            
            #add-point:AFTER FIELD sfea003 name="input.a.sfea003"
            IF NOT cl_null(g_sfea_m.sfea003) THEN
               IF cl_null(g_sfea_m_t.sfea003) OR g_sfea_m.sfea003 != g_sfea_m_t.sfea003 THEN 
                  IF NOT s_department_chk(g_sfea_m.sfea003,g_sfea_m.sfeadocdt) THEN
                     LET g_sfea_m.sfea003 = g_sfea_m_t.sfea003
                     DISPLAY BY NAME g_sfea_m.sfea003                    
                     NEXT FIELD sfea003
                  END IF
               END IF
            END IF
            LET g_sfea_m.sfea003_desc = s_desc_get_department_desc(g_sfea_m.sfea003)
            DISPLAY BY NAME g_sfea_m.sfea003_desc
          

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea003
            #add-point:BEFORE FIELD sfea003 name="input.b.sfea003"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfea003
            #add-point:ON CHANGE sfea003 name="input.g.sfea003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeastus
            #add-point:BEFORE FIELD sfeastus name="input.b.sfeastus"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeastus
            
            #add-point:AFTER FIELD sfeastus name="input.a.sfeastus"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeastus
            #add-point:ON CHANGE sfeastus name="input.g.sfeastus"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea006
            #add-point:BEFORE FIELD sfea006 name="input.b.sfea006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea006
            
            #add-point:AFTER FIELD sfea006 name="input.a.sfea006"
            IF NOT cl_null(g_sfea_m.sfea006) THEN
               IF cl_null(g_sfea_m_t.sfea006) OR g_sfea_m.sfea006 != g_sfea_m_t.sfea006 THEN 
                  CALL asrt340_chk_sfea006()
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_sfea_m.sfea006 = g_sfea_m_t.sfea006
                     NEXT FIELD sfea006
                  END IF
               END IF            
            END IF
            CALL asrt340_get_srab000()            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfea006
            #add-point:ON CHANGE sfea006 name="input.g.sfea006"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfea005
            #add-point:BEFORE FIELD sfea005 name="input.b.sfea005"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfea005
            
            #add-point:AFTER FIELD sfea005 name="input.a.sfea005"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfea005
            #add-point:ON CHANGE sfea005 name="input.g.sfea005"
                        
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sfeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeadocno
            #add-point:ON ACTION controlp INFIELD sfeadocno name="input.c.sfeadocno"
                                    #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfea_m.sfeadocno             #給予default值

            #給予arg
            #单别参照表号
            SELECT ooef004 INTO l_ooef004
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = 'asrt340'
            #160711-00040#32 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#32 add(e)

            CALL q_ooba002_6()                                             #呼叫開窗
            LET g_sfea_m.sfeadocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY BY NAME g_sfea_m.sfeadocno               #顯示到畫面上
            NEXT FIELD sfeadocno                                           #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.sfeasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeasite
            #add-point:ON ACTION controlp INFIELD sfeasite name="input.c.sfeasite"
                        
            #END add-point
 
 
         #Ctrlp:input.c.sfeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeadocdt
            #add-point:ON ACTION controlp INFIELD sfeadocdt name="input.c.sfeadocdt"
                        
            #END add-point
 
 
         #Ctrlp:input.c.sfea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea001
            #add-point:ON ACTION controlp INFIELD sfea001 name="input.c.sfea001"
                        
            #END add-point
 
 
         #Ctrlp:input.c.sfea002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea002
            #add-point:ON ACTION controlp INFIELD sfea002 name="input.c.sfea002"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfea_m.sfea002             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_sfea_m.sfea002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sfea_m.sfea002 TO sfea002              #顯示到畫面上

            NEXT FIELD sfea002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sfea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea003
            #add-point:ON ACTION controlp INFIELD sfea003 name="input.c.sfea003"
                        #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfea_m.sfea003             #給予default值
            LET g_qryparam.arg1 = g_sfea_m.sfeadocdt  #
            CALL q_ooeg001()                                #呼叫開窗

            LET g_sfea_m.sfea003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sfea_m.sfea003 TO sfea003              #顯示到畫面上

            NEXT FIELD sfea003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sfeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeastus
            #add-point:ON ACTION controlp INFIELD sfeastus name="input.c.sfeastus"
                        
            #END add-point
 
 
         #Ctrlp:input.c.sfea006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea006
            #add-point:ON ACTION controlp INFIELD sfea006 name="input.c.sfea006"
                                    INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfea_m.sfea006             
            #給予arg
            CALL q_srza001()                                
            LET g_sfea_m.sfea006 = g_qryparam.return1      
            DISPLAY g_sfea_m.sfea006 TO sfea006            
            NEXT FIELD sfea006      
            #END add-point
 
 
         #Ctrlp:input.c.sfea005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfea005
            #add-point:ON ACTION controlp INFIELD sfea005 name="input.c.sfea005"
                        
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_sfea_m.sfeadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_sfea_m.sfeadocno,g_sfea_m.sfeadocdt,g_prog) 
                RETURNING l_success,g_sfea_m.sfeadocno
               IF NOT l_success THEN
                  NEXT FIELD sfebdocno
               END IF     

               #end add-point
               
               INSERT INTO sfea_t (sfeaent,sfeadocno,sfeasite,sfeadocdt,sfea001,sfea002,sfea003,sfeastus, 
                   sfea006,sfea005,sfeaownid,sfeaowndp,sfeacrtdt,sfeacrtid,sfeacrtdp,sfeamodid,sfeamoddt, 
                   sfeacnfid,sfeacnfdt,sfeapstid,sfeapstdt)
               VALUES (g_enterprise,g_sfea_m.sfeadocno,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001, 
                   g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006,g_sfea_m.sfea005, 
                   g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtdp, 
                   g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid, 
                   g_sfea_m.sfeapstdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_sfea_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_sfea_m_t.* = g_sfea_m.*                              
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
                              
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL asrt340_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asrt340_b_fill()
                  CALL asrt340_b_fill2('0')
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
               CALL asrt340_sfea_t_mask_restore('restore_mask_o')
               
               UPDATE sfea_t SET (sfeadocno,sfeasite,sfeadocdt,sfea001,sfea002,sfea003,sfeastus,sfea006, 
                   sfea005,sfeaownid,sfeaowndp,sfeacrtdt,sfeacrtid,sfeacrtdp,sfeamodid,sfeamoddt,sfeacnfid, 
                   sfeacnfdt,sfeapstid,sfeapstdt) = (g_sfea_m.sfeadocno,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt, 
                   g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
                   g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
                   g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
                   g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt)
                WHERE sfeaent = g_enterprise AND sfeadocno = g_sfeadocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sfea_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                              
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asrt340_sfea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_sfea_m_t)
               LET g_log2 = util.JSON.stringify(g_sfea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                              
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asrt340.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_sfeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION s_lot_ins
            LET g_action_choice="s_lot_ins"
            IF cl_auth_chk_act("s_lot_ins") THEN
               
               #add-point:ON ACTION s_lot_ins name="input.detail_input.page1.s_lot_ins"
               #add 150921  --begin--              
               IF NOT cl_null(g_sfea_m.sfeadocno) AND
                  NOT cl_null(g_sfeb_d[l_ac].sfebseq) AND
                  NOT cl_null(g_sfeb_d[l_ac].sfeb004) AND #料件
                  NOT cl_null(g_sfeb_d[l_ac].sfeb007) AND #单位
                  NOT cl_null(g_sfeb_d[l_ac].sfeb008) AND #数量
                  NOT cl_null(g_sfeb_d[l_ac].sfeb013) AND
                  NOT cl_null(g_sfea_m.sfea002) THEN  #申请人
                  LET l_success = ''
                  CALL s_lot_ins(g_site,g_sfea_m.sfeadocno,
                                 #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
                                 g_sfeb_d[l_ac].sfebseq,'1',
                                 #料件編號                        產品特徵
                                 g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                                 #交易單位                      交易數量                 
                                 g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008,
                                 '1',g_sfea_m.sfea002,'1','',g_sfeb_d[g_detail_idx].sfeb013,
                                 g_sfeb_d[g_detail_idx].sfeb014,g_sfeb_d[g_detail_idx].sfeb015,
                                 g_sfeb_d[g_detail_idx].sfeb016
                                 )   #160316-00007#7 add sfeb016
                       RETURNING l_success,l_amount
                  IF l_success THEN
                     IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
                        IF NOT asrt340_ins_inao() THEN
                           CALL s_transaction_end('N','0')
                           EXIT DIALOG
                        END IF
                     END IF
#                     IF g_sfeb_d[l_ac].sfeb008 <> l_amount THEN
#                        IF cl_ask_confirm('ain-00249') THEN
#                           CALL s_aooi250_convert_qty(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,
#                                                      g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb008)
#
#                                RETURNING l_success,g_sfeb_d[l_ac].sfeb011
#                           IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
#                              UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                sfeb009 = l_amount,
#                                                sfeb027 = l_amount,
#                                                sfeb011 = g_sfeb_d[l_ac].sfeb011,
#                                                sfeb012 = g_sfeb_d[l_ac].sfeb011
#                               WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                 AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[l_ac].sfebseq
#                           ELSE
#                              UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                sfeb011 = g_sfeb_d[l_ac].sfeb011
#                               WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                 AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[l_ac].sfebseq
#                           END IF
#                           IF SQLCA.sqlcode THEN
#                              INITIALIZE g_errparam TO NULL
#                              LET g_errparam.code = SQLCA.sqlcode
#                              LET g_errparam.extend = "sfeb_t"
#                              LET g_errparam.popup = FALSE
#                              CALL cl_err()
#                           ELSE
#                              LET g_sfeb_d[l_ac].sfeb008 = l_amount
#                              IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
#                                 LET g_sfeb_d[l_ac].sfeb009 = l_amount
#                              END IF
#                           END IF
#                        END IF
#                     END IF
                  END IF
                  CALL asrt340_show()
               END IF
               #add 150921  --end--
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sfeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt340_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_sfeb_d.getLength()
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
            OPEN asrt340_cl USING g_enterprise,g_sfea_m.sfeadocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt340_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt340_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_sfeb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sfeb_d[l_ac].sfebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*  #BACKUP
               LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*  #BACKUP
               CALL asrt340_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                              
               #end add-point  
               CALL asrt340_set_no_entry_b(l_cmd)
               IF NOT asrt340_lock_b("sfeb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt340_bcl INTO g_sfeb_d[l_ac].sfebseq,g_sfeb_d[l_ac].sfeb023,g_sfeb_d[l_ac].sfeb024, 
                      g_sfeb_d[l_ac].sfeb025,g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003,g_sfeb_d[l_ac].sfeb004, 
                      g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008, 
                      g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb009,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011, 
                      g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015, 
                      g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022, 
                      g_sfeb_d[l_ac].sfebsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sfeb_d_t.sfebseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sfeb_d_mask_o[l_ac].* =  g_sfeb_d[l_ac].*
                  CALL asrt340_sfeb_t_mask()
                  LET g_sfeb_d_mask_n[l_ac].* =  g_sfeb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt340_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_entried = TRUE
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
            INITIALIZE g_sfeb_d[l_ac].* TO NULL 
            INITIALIZE g_sfeb_d_t.* TO NULL 
            INITIALIZE g_sfeb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_sfeb_d[l_ac].sfeb002 = "N"
      LET g_sfeb_d[l_ac].sfeb008 = "0"
      LET g_sfeb_d[l_ac].sfeb027 = "0"
      LET g_sfeb_d[l_ac].sfeb009 = "0"
      LET g_sfeb_d[l_ac].sfeb011 = "0"
      LET g_sfeb_d[l_ac].sfeb012 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT MAX(sfebseq) + 1 INTO g_sfeb_d[l_ac].sfebseq FROM sfeb_t
             WHERE sfebent = g_enterprise
               AND sfebdocno = g_sfea_m.sfeadocno
            IF cl_null(g_sfeb_d[l_ac].sfebseq) THEN
               LET g_sfeb_d[l_ac].sfebseq = 1
            END IF
            #end add-point
            LET g_sfeb_d_t.* = g_sfeb_d[l_ac].*     #新輸入資料
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt340_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            LET g_sfeb_d[l_ac].sfebsite = g_site
            #生产料号
            CALL asrt340_set_sfeb023_sfeb024_sfeb025('1')
            #其他字段的DEFAULT
            CALL asrt340_sfeb023_reference() 
            #FQC否
            CALL asrt340_set_sfeb002()
            
            #end add-point
            CALL asrt340_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sfeb_d[li_reproduce_target].* = g_sfeb_d[li_reproduce].*
 
               LET g_sfeb_d[li_reproduce_target].sfebseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_entried = TRUE
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
            #产品特征
            IF g_sfeb_d[l_ac].sfeb005 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb005 = ' '
            END IF
            #库存特征
            IF g_sfeb_d[l_ac].sfeb016 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb016 = ' '
            END IF

            #复合字段检查
            #料/仓/储/批
            IF g_sfeb_d[l_ac].sfeb014 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb014 = ' '
            END IF
            IF g_sfeb_d[l_ac].sfeb015 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb015 = ' '
            END IF     
            CALL asrt340_chk_warehouses()
                 RETURNING l_success
            IF NOT l_success THEN
               CANCEL INSERT
            END IF
            #生产料号-BOM特性
            IF g_sfeb_d[l_ac].sfeb024 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb024 = ' '
            END IF
            #生产料号-产品特征
            IF g_sfeb_d[l_ac].sfeb025 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb025 = ' '
            END IF     
            CALL asrt340_chk_sfeb023_sfeb024_sfeb025()
                 RETURNING l_success
            IF NOT l_success THEN
               CANCEL INSERT
            END IF            

            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM sfeb_t 
             WHERE sfebent = g_enterprise AND sfebdocno = g_sfea_m.sfeadocno
 
               AND sfebseq = g_sfeb_d[l_ac].sfebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                              
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfea_m.sfeadocno
               LET gs_keys[2] = g_sfeb_d[g_detail_idx].sfebseq
               CALL asrt340_insert_b('sfeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #当申数据不需FQC时，新增申请数据后，自动写一笔数据到入库明细
               IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
                  CALL asrt340_ins_sfec(g_sfeb_d[l_ac].*)
                       RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_sfeb_d[l_ac].* TO NULL
                     CALL s_transaction_end('N','0')               
                  END IF
               END IF
               
               #单身备注
               IF NOT cl_null(g_sfeb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4',g_sfeb_d[l_ac].ooff013)
                       RETURNING l_success
               END IF    

               #特征值处理---多特征值录入时,要将所有的特征值INSERT至sfeb_t
               #IF g_inam.getLength() > 1 THEN
               #   CALL asrt340_feature_insert(l_cmd)
               #        RETURNING l_success
               #   IF NOT l_success THEN
               #      INITIALIZE g_sfeb_d[l_ac].* TO NULL
               #      CALL s_transaction_end('N','0')                  
               #   END IF
               #   CALL asrt340_b_fill()
               #   LET g_rec_b = g_rec_b + g_inam.getLength() - 1
               #
               #   
               #END IF
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_sfeb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt340_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               CALL asrt340_b_fill()
             
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               CALL s_transaction_end('N','0')  #151012
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
               LET gs_keys[01] = g_sfea_m.sfeadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_sfeb_d_t.sfebseq
 
            
               #刪除同層單身
               IF NOT asrt340_delete_b('sfeb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt340_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt340_key_delete_b(gs_keys,'sfeb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt340_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #add 151012 begin 删除sfeb、sfec的inao资料
               DELETE FROM inao_t
                WHERE inaoent  = g_enterprise
                  AND inaosite = g_site
                  AND inaodocno= g_sfea_m.sfeadocno
                  AND inaoseq  = g_sfeb_d_t.sfebseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "DELETE inao_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               #add 151012 end                              
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt340_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM sfec_t
                   WHERE sfecent   = g_enterprise
                     AND sfecdocno = g_sfea_m.sfeadocno
                     AND sfecseq   = g_sfeb_d_t.sfebseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "delete sfec"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_rec_b = g_rec_b + 1
                  END IF
                  

                  IF NOT cl_null(g_sfeb_d[l_ac].ooff013) THEN
                     CALL s_aooi360_gen('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4',g_sfeb_d[l_ac].ooff013)
                          RETURNING l_success
                  ELSE
                     CALL s_aooi360_del('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4')
                          RETURNING l_success
                  END IF     

                  CALL asrt340_b_fill()
               #end add-point
               LET l_count = g_sfeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                        
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sfeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfebseq
            #add-point:BEFORE FIELD sfebseq name="input.b.page1.sfebseq"
            IF l_cmd = 'a' AND cl_null(g_sfeb_d[l_ac].sfebseq) THEN
               SELECT MAX(sfebseq) + 1 INTO g_sfeb_d[l_ac].sfebseq FROM sfeb_t
                WHERE sfebent = g_enterprise
                  AND sfebdocno = g_sfea_m.sfeadocno
               IF cl_null(g_sfeb_d[l_ac].sfebseq) THEN
                  LET g_sfeb_d[l_ac].sfebseq = 1
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfebseq
            
            #add-point:AFTER FIELD sfebseq name="input.a.page1.sfebseq"
            #此段落由子樣板a05產生
            IF g_sfeb_d[l_ac].sfebseq <=0 THEN
               NEXT FIELD sfebseq
            END IF
            IF  g_sfea_m.sfeadocno IS NOT NULL AND g_sfeb_d[g_detail_idx].sfebseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfea_m.sfeadocno != g_sfeadocno_t OR g_sfeb_d[g_detail_idx].sfebseq != g_sfeb_d_t.sfebseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfeb_t WHERE "||"sfebent = '" ||g_enterprise|| "' AND "||"sfebdocno = '"||g_sfea_m.sfeadocno ||"' AND "|| "sfebseq = '"||g_sfeb_d[g_detail_idx].sfebseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfebseq
            #add-point:ON CHANGE sfebseq name="input.g.page1.sfebseq"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb023
            
            #add-point:AFTER FIELD sfeb023 name="input.a.page1.sfeb023"
            IF g_sfeb_d[l_ac].sfeb023 IS NOT NULL THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb023 != g_sfeb_d_t.sfeb023)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb023 != g_sfeb_d_o.sfeb023 OR cl_null(g_sfeb_d_o.sfeb023) THEN        #160824-00007#285 by sakura add
                  #当料号有修改时,sfeb024/sfeb025清空
                  LET g_sfeb_d[l_ac].sfeb024 = ''
                  LET g_sfeb_d[l_ac].sfeb025 = ''
                  CALL asrt340_chk_sfeb023_sfeb024_sfeb025()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb023 = g_sfeb_d_t.sfeb023   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb023 = g_sfeb_d_o.sfeb023   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb023
                  END IF  
                  #其他字段的DEFAULT
                  CALL asrt340_sfeb023_reference() 
               END IF
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb023)
                 RETURNING g_sfeb_d[l_ac].sfeb023_desc,g_sfeb_d[l_ac].sfeb023_desc_desc
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb023_desc,g_sfeb_d[l_ac].sfeb023_desc_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb023
            #add-point:BEFORE FIELD sfeb023 name="input.b.page1.sfeb023"
            IF cl_null(g_sfeb_d[l_ac].sfeb023) THEN
               CALL asrt340_set_sfeb023_sfeb024_sfeb025('1')
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb023
            #add-point:ON CHANGE sfeb023 name="input.g.page1.sfeb023"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb024
            #add-point:BEFORE FIELD sfeb024 name="input.b.page1.sfeb024"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb024
            
            #add-point:AFTER FIELD sfeb024 name="input.a.page1.sfeb024"
            IF g_sfeb_d[l_ac].sfeb024 IS NOT NULL THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb024 != g_sfeb_d_t.sfeb024)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb024 != g_sfeb_d_o.sfeb024 OR cl_null(g_sfeb_d_o.sfeb024) THEN        #160824-00007#285 by sakura add
                  CALL asrt340_chk_sfeb023_sfeb024_sfeb025()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb024 = g_sfeb_d_t.sfeb024   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb024 = g_sfeb_d_o.sfeb024   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb024
                  END IF  
               END IF
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add           
            IF g_sfeb_d[l_ac].sfeb024 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb024 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb024
            #add-point:ON CHANGE sfeb024 name="input.g.page1.sfeb024"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb025
            #add-point:BEFORE FIELD sfeb025 name="input.b.page1.sfeb025"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb025
            
            #add-point:AFTER FIELD sfeb025 name="input.a.page1.sfeb025"
            IF g_sfeb_d[l_ac].sfeb025 IS NOT NULL THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb025 != g_sfeb_d_t.sfeb025)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb025 != g_sfeb_d_o.sfeb025 OR cl_null(g_sfeb_d_o.sfeb025) THEN        #160824-00007#285 by sakura add
                  CALL asrt340_chk_sfeb023_sfeb024_sfeb025()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb025 = g_sfeb_d_t.sfeb025   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb025 = g_sfeb_d_o.sfeb025   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb025
                  END IF  
               END IF
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add            
            IF g_sfeb_d[l_ac].sfeb025 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb025 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb025
            #add-point:ON CHANGE sfeb025 name="input.g.page1.sfeb025"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb002
            #add-point:BEFORE FIELD sfeb002 name="input.b.page1.sfeb002"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb002
            
            #add-point:AFTER FIELD sfeb002 name="input.a.page1.sfeb002"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb002
            #add-point:ON CHANGE sfeb002 name="input.g.page1.sfeb002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb003
            #add-point:BEFORE FIELD sfeb003 name="input.b.page1.sfeb003"
                                    CALL cl_set_comp_entry('sfeb004',TRUE)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb003
            
            #add-point:AFTER FIELD sfeb003 name="input.a.page1.sfeb003"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb003) THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb003 != g_sfeb_d_t.sfeb003)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb003 != g_sfeb_d_o.sfeb003 OR cl_null(g_sfeb_d_o.sfeb003) THEN        #160824-00007#285 by sakura add
                  IF g_sfeb_d[l_ac].sfeb003 NOT MATCHES '[125]' THEN
                     LET g_sfeb_d[l_ac].sfeb003 = g_sfeb_d_o.sfeb003   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb003
                  END IF
                  CALL asrt340_set_sfeb002()
                  CALL asrt340_set_sfeb004()
                  CALL asrt340_sfeb004_reference()                  
               END IF 
               IF g_sfeb_d[l_ac].sfeb003 = '1' THEN
                  CALL cl_set_comp_entry('sfeb004',FALSE)
               END IF
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb003
            #add-point:ON CHANGE sfeb003 name="input.g.page1.sfeb003"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb004
            
            #add-point:AFTER FIELD sfeb004 name="input.a.page1.sfeb004"
            CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
                 RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc            
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb004) THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb004 != g_sfeb_d_t.sfeb004)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb004 != g_sfeb_d_o.sfeb004 OR cl_null(g_sfeb_d_o.sfeb004) THEN        #160824-00007#285 by sakura add
                  CALL asrt340_chk_sfeb004()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb004 = g_sfeb_d_t.sfeb004   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb004 = g_sfeb_d_o.sfeb004   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb004
                  END IF                
                  CALL asrt340_sfeb004_reference()                  
               END IF
               #add 151012 --begin
               #入库料件变化时,需删除原批序号资料(包含申请和实际的)
               IF NOT cl_null(g_sfeb_d_o.sfeb004) AND g_sfeb_d[l_ac].sfeb004 != g_sfeb_d_o.sfeb004 THEN
                  DELETE FROM inao_t
                   WHERE inaoent = g_enterprise AND inaosite = g_site
                     AND inaodocno = g_sfea_m.sfeadocno
                     AND (inaoseq = g_sfeb_d_t.sfebseq OR inaoseq = g_sfeb_d_o.sfebseq) #項次
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'del inao'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #add 151012 --end               
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            CALL asrt340_set_entry_b(l_cmd)
            CALL asrt340_set_no_entry_b(l_cmd)
            LET g_sfeb_d_o.sfeb004 = g_sfeb_d[l_ac].sfeb004  #151012
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb004
            #add-point:BEFORE FIELD sfeb004 name="input.b.page1.sfeb004"
            CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
                 RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb004
            #add-point:ON CHANGE sfeb004 name="input.g.page1.sfeb004"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb005
            #add-point:BEFORE FIELD sfeb005 name="input.b.page1.sfeb005"
            IF g_sfeb_d[l_ac].sfeb005 IS NULL THEN
               CALL asrt340_set_sfeb005()
            END IF            
            
            #IF g_sfeb_d[l_ac].sfeb005 IS NULL THEN
            #   CALL asrt340_feature(l_cmd)
            #END IF

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb005
            
            #add-point:AFTER FIELD sfeb005 name="input.a.page1.sfeb005"
            IF g_sfeb_d[l_ac].sfeb005 IS NOT NULL THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb005 != g_sfeb_d_t.sfeb005)) THEN 
                  CALL asrt340_chk_sfeb005()
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_sfeb_d[l_ac].sfeb005 = g_sfeb_d_t.sfeb005
                     NEXT FIELD sfeb005
                  END IF                                 
               END IF
            END IF
            IF g_sfeb_d[l_ac].sfeb005 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb005 = ' '
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb005
            #add-point:ON CHANGE sfeb005 name="input.g.page1.sfeb005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb006
            #add-point:BEFORE FIELD sfeb006 name="input.b.page1.sfeb006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb006
            
            #add-point:AFTER FIELD sfeb006 name="input.a.page1.sfeb006"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb006) THEN
               IF cl_null(g_sfeb_d_t.sfeb006) OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb006 != g_sfeb_d_t.sfeb006)) THEN 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb006
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                  #160318-00025#17  by 07900 --add-end
                  IF NOT cl_chk_exist("v_imaf001_2") THEN
                     LET g_sfeb_d[l_ac].sfeb006 = g_sfeb_d_t.sfeb006
                     NEXT FIELD sfeb006
                  END IF
               END IF            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb006
            #add-point:ON CHANGE sfeb006 name="input.g.page1.sfeb006"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb007
            #add-point:BEFORE FIELD sfeb007 name="input.b.page1.sfeb007"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb007
            
            #add-point:AFTER FIELD sfeb007 name="input.a.page1.sfeb007"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb007) THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb007 != g_sfeb_d_t.sfeb007)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb007 != g_sfeb_d_o.sfeb007 OR cl_null(g_sfeb_d_o.sfeb007) THEN        #160824-00007#285 by sakura add
                  CALL asrt340_chk_sfeb007()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb007 = g_sfeb_d_t.sfeb007   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb007 = g_sfeb_d_o.sfeb007   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb007
                  END IF
                  #设置sfeb008-申请数量
                  CALL asrt340_set_sfeb008()
                  #置sfeb011-参考数量
                  CALL asrt340_set_sfeb011()                    
               END IF            
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb007
            #add-point:ON CHANGE sfeb007 name="input.g.page1.sfeb007"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb008
            #add-point:BEFORE FIELD sfeb008 name="input.b.page1.sfeb008"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb008
            
            #add-point:AFTER FIELD sfeb008 name="input.a.page1.sfeb008"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb008) THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb008 != g_sfeb_d_o.sfeb008 OR cl_null(g_sfeb_d_o.sfeb008))) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb008 != g_sfeb_d_o.sfeb008 OR cl_null(g_sfeb_d_o.sfeb008) THEN   #160824-00007#285 by sakura add
                  CALL asrt340_chk_sfeb008()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb008 = g_sfeb_d_t.sfeb008   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb008 = g_sfeb_d_o.sfeb008   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb008
                  END IF
                  #置sfeb011-参考数量
                  CALL asrt340_set_sfeb011()  
                  #151012  --begin--
                  IF s_lot_batch_number(g_sfeb_d[l_ac].sfeb004,g_site) THEN
                     CALL s_lot_ins(g_site,g_sfea_m.sfeadocno,
                                    #目的單據項次                    目的單據項序(若單據沒有到項序層則此參數固定傳0)
                                    g_sfeb_d[l_ac].sfebseq,'1',
                                    #料件編號                        產品特徵
                                    g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,
                                    #交易單位                      交易數量                 
                                    g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008,
                                    '1',g_sfea_m.sfea002,'1','',g_sfeb_d[l_ac].sfeb013,
                                    g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,
                                    g_sfeb_d[l_ac].sfeb016
                                    )       #160316-00007#7 add sfeb016
                          RETURNING l_success,l_amount 
                        IF l_success THEN
                           IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
                              IF NOT asrt340_ins_inao() THEN
                              END IF
                           END IF
#                           IF g_sfeb_d[l_ac].sfeb008 <> l_amount THEN
#                              IF cl_ask_confirm('ain-00249') THEN
#                                 CALL s_aooi250_convert_qty(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,
#                                                            g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb008)
#                     
#                                      RETURNING l_success,g_sfeb_d[l_ac].sfeb011
#                                 IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
#                                    UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                      sfeb009 = l_amount,
#                                                      sfeb027 = l_amount,
#                                                      sfeb011 = g_sfeb_d[l_ac].sfeb011,
#                                                      sfeb012 = g_sfeb_d[l_ac].sfeb011
#                                     WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                       AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[l_ac].sfebseq
#                                 ELSE
#                                    UPDATE sfeb_t SET sfeb008 = l_amount,
#                                                      sfeb011 = g_sfeb_d[l_ac].sfeb011
#                                     WHERE sfebent = g_enterprise AND sfebsite = g_site
#                                       AND sfebdocno = g_sfea_m.sfeadocno AND sfebseq = g_sfeb_d[l_ac].sfebseq
#                                 END IF
#                                 IF SQLCA.sqlcode THEN
#                                    INITIALIZE g_errparam TO NULL
#                                    LET g_errparam.code = SQLCA.sqlcode
#                                    LET g_errparam.extend = "inbb_t"
#                                    LET g_errparam.popup = FALSE
#                                    CALL cl_err()
#                                 ELSE
#                                    LET g_sfeb_d[l_ac].sfeb008 = l_amount
#                                    IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
#                                       LET g_sfeb_d[l_ac].sfeb009 = l_amount
#                                    END IF
#                                 END IF
#                              END IF
#                           END IF
                        END IF
                     #CALL asrt340_show()
                  END IF
                 #151012--end--                    
               END IF            
            END IF
            IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
               LET g_sfeb_d[l_ac].sfeb009 = g_sfeb_d[l_ac].sfeb008
               LET g_sfeb_d[l_ac].sfeb027 = g_sfeb_d[l_ac].sfeb008
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
           #LET g_sfeb_d_o.sfeb008 = g_sfeb_d[l_ac].sfeb008   #160824-00007#285 by sakura mark
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb008
            #add-point:ON CHANGE sfeb008 name="input.g.page1.sfeb008"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb027
            #add-point:BEFORE FIELD sfeb027 name="input.b.page1.sfeb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb027
            
            #add-point:AFTER FIELD sfeb027 name="input.a.page1.sfeb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb027
            #add-point:ON CHANGE sfeb027 name="input.g.page1.sfeb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb009
            #add-point:BEFORE FIELD sfeb009 name="input.b.page1.sfeb009"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb009
            
            #add-point:AFTER FIELD sfeb009 name="input.a.page1.sfeb009"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb009
            #add-point:ON CHANGE sfeb009 name="input.g.page1.sfeb009"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb010
            #add-point:BEFORE FIELD sfeb010 name="input.b.page1.sfeb010"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb010
            
            #add-point:AFTER FIELD sfeb010 name="input.a.page1.sfeb010"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb010) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb010 != g_sfeb_d_t.sfeb010)) THEN 
                  CALL asrt340_chk_sfeb010()
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_sfeb_d[l_ac].sfeb010 = g_sfeb_d_t.sfeb010
                     NEXT FIELD sfeb010
                  END IF
               END IF            
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb010
            #add-point:ON CHANGE sfeb010 name="input.g.page1.sfeb010"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb011
            #add-point:BEFORE FIELD sfeb011 name="input.b.page1.sfeb011"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb011
            
            #add-point:AFTER FIELD sfeb011 name="input.a.page1.sfeb011"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb011) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb011 != g_sfeb_d_t.sfeb011)) THEN 
                  CALL asrt340_chk_sfeb011()
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d_t.sfeb011
                     NEXT FIELD sfeb011
                  END IF
               END IF            
            END IF 
            IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
               LET g_sfeb_d[l_ac].sfeb012 = g_sfeb_d[l_ac].sfeb011
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb011
            #add-point:ON CHANGE sfeb011 name="input.g.page1.sfeb011"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb012
            #add-point:BEFORE FIELD sfeb012 name="input.b.page1.sfeb012"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb012
            
            #add-point:AFTER FIELD sfeb012 name="input.a.page1.sfeb012"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb012
            #add-point:ON CHANGE sfeb012 name="input.g.page1.sfeb012"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb013
            
            #add-point:AFTER FIELD sfeb013 name="input.a.page1.sfeb013"
            LET g_sfeb_d[l_ac].sfeb013_desc = s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013)
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013_desc            
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb013) THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb013 != g_sfeb_d_o.sfeb013 OR cl_null(g_sfeb_d_o.sfeb013))) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb013 != g_sfeb_d_o.sfeb013 OR cl_null(g_sfeb_d_o.sfeb013) THEN   #160824-00007#285 by sakura add
                  CALL asrt340_chk_warehouses()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb013 = g_sfeb_d_t.sfeb013   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb013 = g_sfeb_d_o.sfeb013   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb013
                  END IF
               END IF 
               IF g_sfeb_d[l_ac].sfeb013 != g_sfeb_d_o.sfeb013 OR cl_null(g_sfeb_d_o.sfeb013) OR
                  g_sfeb_d[l_ac].sfeb014 != g_sfeb_d_o.sfeb014 OR g_sfeb_d_o.sfeb014 IS NULL OR 
                  g_sfeb_d[l_ac].sfeb015 != g_sfeb_d_o.sfeb015 OR g_sfeb_d_o.sfeb015 IS NULL THEN 
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','1',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)  #160316-00007#7 add sfeb016
                     RETURNING l_success
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','2',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)  #160316-00007#7 add sfeb016
                     RETURNING l_success
                  CALL asrt340_inao_fill()   
               END IF
            END IF
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            #160824-00007#285 by sakura mark(S)
            #LET g_sfeb_d_o.sfeb013 = g_sfeb_d[l_ac].sfeb013
            #LET g_sfeb_d_o.sfeb014 = g_sfeb_d[l_ac].sfeb014
            #LET g_sfeb_d_o.sfeb015 = g_sfeb_d[l_ac].sfeb015
            #160824-00007#285 by sakura mark(E)
            CALL asrt340_set_entry_b(l_cmd)
            CALL asrt340_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb013
            #add-point:BEFORE FIELD sfeb013 name="input.b.page1.sfeb013"
            LET g_sfeb_d[l_ac].sfeb013_desc = s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013)
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb013
            #add-point:ON CHANGE sfeb013 name="input.g.page1.sfeb013"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb014
            
            #add-point:AFTER FIELD sfeb014 name="input.a.page1.sfeb014"
            LET g_sfeb_d[l_ac].sfeb014_desc = s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014)
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014_desc            
            IF g_sfeb_d[l_ac].sfeb014 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb014 = ' '
            END IF            
            IF g_sfeb_d[l_ac].sfeb014 IS NOT NULL THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb014 != g_sfeb_d_t.sfeb014 OR g_sfeb_d_o.sfeb014 IS NULL)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb014 != g_sfeb_d_o.sfeb014 OR g_sfeb_d_o.sfeb014 IS NULL THEN   #160824-00007#285 by sakura add
                  CALL asrt340_chk_warehouses()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb014 = g_sfeb_d_t.sfeb014   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb014 = g_sfeb_d_o.sfeb014   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb013
                  END IF
               END IF            
               IF g_sfeb_d[l_ac].sfeb013 != g_sfeb_d_o.sfeb013 OR cl_null(g_sfeb_d_o.sfeb013) OR
                  g_sfeb_d[l_ac].sfeb014 != g_sfeb_d_o.sfeb014 OR g_sfeb_d_o.sfeb014 IS NULL OR 
                  g_sfeb_d[l_ac].sfeb015 != g_sfeb_d_o.sfeb015 OR g_sfeb_d_o.sfeb015 IS NULL THEN 
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','1',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)  #160316-00007#7 add sfeb016
                     RETURNING l_success
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','2',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)  #160316-00007#7 add sfeb016
                     RETURNING l_success
                  CALL asrt340_inao_fill()                     
               END IF
            END IF               
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            #160824-00007#285 by sakura mark(S)
            #LET g_sfeb_d_o.sfeb013 = g_sfeb_d[l_ac].sfeb013
            #LET g_sfeb_d_o.sfeb014 = g_sfeb_d[l_ac].sfeb014
            #LET g_sfeb_d_o.sfeb015 = g_sfeb_d[l_ac].sfeb015
            #160824-00007#285 by sakura mark(E)
            CALL asrt340_set_entry_b(l_cmd)
            CALL asrt340_set_no_entry_b(l_cmd)          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb014
            #add-point:BEFORE FIELD sfeb014 name="input.b.page1.sfeb014"
            LET g_sfeb_d[l_ac].sfeb014_desc = s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014)
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014_desc
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb014
            #add-point:ON CHANGE sfeb014 name="input.g.page1.sfeb014"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb015
            #add-point:BEFORE FIELD sfeb015 name="input.b.page1.sfeb015"
            IF g_sfeb_d[l_ac].sfeb015 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb015 = ' '
            END IF 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb015
            
            #add-point:AFTER FIELD sfeb015 name="input.a.page1.sfeb015"
             IF g_sfeb_d[l_ac].sfeb015 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb015 = ' '
            END IF            
            IF g_sfeb_d[l_ac].sfeb015 IS NOT NULL THEN
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfeb_d[l_ac].sfeb015 != g_sfeb_d_t.sfeb015 OR g_sfeb_d_o.sfeb015 IS NULL)) THEN   #160824-00007#285 by sakura mark
               IF g_sfeb_d[l_ac].sfeb015 != g_sfeb_d_o.sfeb015 OR g_sfeb_d_o.sfeb015 IS NULL THEN   #160824-00007#285 by sakura add
                  CALL asrt340_chk_warehouses()
                       RETURNING l_success
                  IF NOT l_success THEN
                    #LET g_sfeb_d[l_ac].sfeb015 = g_sfeb_d_t.sfeb015   #160824-00007#285 by sakura mark
                     LET g_sfeb_d[l_ac].sfeb015 = g_sfeb_d_o.sfeb015   #160824-00007#285 by sakura add
                     NEXT FIELD sfeb013
                  END IF
               END IF            
               IF g_sfeb_d[l_ac].sfeb013 != g_sfeb_d_o.sfeb013 OR cl_null(g_sfeb_d_o.sfeb013) OR
                  g_sfeb_d[l_ac].sfeb014 != g_sfeb_d_o.sfeb014 OR g_sfeb_d_o.sfeb014 IS NULL OR 
                  g_sfeb_d[l_ac].sfeb015 != g_sfeb_d_o.sfeb015 OR g_sfeb_d_o.sfeb015 IS NULL THEN 
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','1',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)   #160316-00007#7 add sfeb016
                     RETURNING l_success
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','2',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)   #160316-00007#7 add sfeb016
                     RETURNING l_success 
                  CALL asrt340_inao_fill()                     
               END IF
            END IF               
            LET g_sfeb_d_o.* = g_sfeb_d[l_ac].*   #160824-00007#285 by sakura add
            #160824-00007#285 by sakura mark(S)
            #LET g_sfeb_d_o.sfeb013 = g_sfeb_d[l_ac].sfeb013
            #LET g_sfeb_d_o.sfeb014 = g_sfeb_d[l_ac].sfeb014
            #LET g_sfeb_d_o.sfeb015 = g_sfeb_d[l_ac].sfeb015
            #160824-00007#285 by sakura mark(E)
            CALL asrt340_set_entry_b(l_cmd)
            CALL asrt340_set_no_entry_b(l_cmd)  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb015
            #add-point:ON CHANGE sfeb015 name="input.g.page1.sfeb015"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb016
            #add-point:BEFORE FIELD sfeb016 name="input.b.page1.sfeb016"
             IF g_sfeb_d[l_ac].sfeb016 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb016 = ' '
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb016
            
            #add-point:AFTER FIELD sfeb016 name="input.a.page1.sfeb016"
            IF g_sfeb_d[l_ac].sfeb016 IS NULL THEN
               LET g_sfeb_d[l_ac].sfeb016 = ' '
            END IF
            #160316-00007#7---add---end            
            IF g_sfeb_d[l_ac].sfeb016 IS NOT NULL THEN           
               IF g_sfeb_d[l_ac].sfeb016 != g_sfeb_d_o.sfeb016 OR g_sfeb_d_o.sfeb016 IS NULL THEN 
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','1',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)
                     RETURNING l_success
                  CALL s_lot_upd_inao(g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'1','2',g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_site,g_sfeb_d[l_ac].sfeb016)
                     RETURNING l_success 
                  CALL asrt340_inao_fill()                     
               END IF
            END IF               
            LET g_sfeb_d_o.sfeb016 = g_sfeb_d[l_ac].sfeb016
            CALL asrt340_set_entry_b(l_cmd)
            CALL asrt340_set_no_entry_b(l_cmd)
            #160316-00007#7---add---end            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb016
            #add-point:ON CHANGE sfeb016 name="input.g.page1.sfeb016"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb020
            
            #add-point:AFTER FIELD sfeb020 name="input.a.page1.sfeb020"
            IF NOT cl_null(g_sfeb_d[l_ac].sfeb020) THEN
               IF cl_null(g_sfeb_d_t.sfeb020) OR (g_sfeb_d[l_ac].sfeb020 != g_sfeb_d_t.sfeb020) THEN
                  CALL asft340_chk_sfeb020()
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_sfeb_d[l_ac].sfeb020 = g_sfeb_d_t.sfeb020
                     NEXT FIELD sfeb020
                  END IF
               END IF
            END IF
            LET g_sfeb_d[l_ac].sfeb020_desc = s_desc_get_acc_desc('225',g_sfeb_d[l_ac].sfeb020)
            DISPLAY BY NAME g_sfeb_d[l_ac].sfeb020_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb020
            #add-point:BEFORE FIELD sfeb020 name="input.b.page1.sfeb020"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb020
            #add-point:ON CHANGE sfeb020 name="input.g.page1.sfeb020"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb021
            #add-point:BEFORE FIELD sfeb021 name="input.b.page1.sfeb021"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb021
            
            #add-point:AFTER FIELD sfeb021 name="input.a.page1.sfeb021"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb021
            #add-point:ON CHANGE sfeb021 name="input.g.page1.sfeb021"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfeb022
            #add-point:BEFORE FIELD sfeb022 name="input.b.page1.sfeb022"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfeb022
            
            #add-point:AFTER FIELD sfeb022 name="input.a.page1.sfeb022"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfeb022
            #add-point:ON CHANGE sfeb022 name="input.g.page1.sfeb022"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sfebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfebseq
            #add-point:ON ACTION controlp INFIELD sfebseq name="input.c.page1.sfebseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb023
            #add-point:ON ACTION controlp INFIELD sfeb023 name="input.c.page1.sfeb023"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb023
            LET g_qryparam.arg1 = g_srab000
            LET g_qryparam.arg2 = g_sfea_m.sfea006
            LET g_qryparam.arg3 = g_srab002
            LET g_qryparam.arg4 = g_srab003
            
            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_item_sql('6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_srab004_1()
            IF g_qryparam.return2 IS NULL THEN
               LET g_qryparam.return2 = ' '
            END IF
            IF g_qryparam.return3 IS NULL THEN
               LET g_qryparam.return3 = ' '
            END IF            
            LET g_sfeb_d[l_ac].sfeb023 = g_qryparam.return1     #將開窗取得的值回傳到變數
            LET g_sfeb_d[l_ac].sfeb024 = g_qryparam.return2
            LET g_sfeb_d[l_ac].sfeb025 = g_qryparam.return3            
            NEXT FIELD sfeb023            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb024
            #add-point:ON ACTION controlp INFIELD sfeb024 name="input.c.page1.sfeb024"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb023
            LET g_qryparam.arg1 = g_srab000
            LET g_qryparam.arg2 = g_sfea_m.sfea006
            LET g_qryparam.arg3 = g_srab002
            LET g_qryparam.arg4 = g_srab003
            
            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_item_sql('6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_srab004_1()
            IF g_qryparam.return2 IS NULL THEN
               LET g_qryparam.return2 = ' '
            END IF
            IF g_qryparam.return3 IS NULL THEN
               LET g_qryparam.return3 = ' '
            END IF                   
            LET g_sfeb_d[l_ac].sfeb023 = g_qryparam.return1     #將開窗取得的值回傳到變數
            LET g_sfeb_d[l_ac].sfeb024 = g_qryparam.return2
            LET g_sfeb_d[l_ac].sfeb025 = g_qryparam.return3            
            NEXT FIELD sfeb024                          
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb025
            #add-point:ON ACTION controlp INFIELD sfeb025 name="input.c.page1.sfeb025"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb023
            LET g_qryparam.arg1 = g_srab000
            LET g_qryparam.arg2 = g_sfea_m.sfea006
            LET g_qryparam.arg3 = g_srab002
            LET g_qryparam.arg4 = g_srab003
            
            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_item_sql('6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_srab004_1()
            IF g_qryparam.return2 IS NULL THEN
               LET g_qryparam.return2 = ' '
            END IF
            IF g_qryparam.return3 IS NULL THEN
               LET g_qryparam.return3 = ' '
            END IF                   
            LET g_sfeb_d[l_ac].sfeb023 = g_qryparam.return1     #將開窗取得的值回傳到變數
            LET g_sfeb_d[l_ac].sfeb024 = g_qryparam.return2
            LET g_sfeb_d[l_ac].sfeb025 = g_qryparam.return3            
            NEXT FIELD sfeb025                          
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb002
            #add-point:ON ACTION controlp INFIELD sfeb002 name="input.c.page1.sfeb002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb003
            #add-point:ON ACTION controlp INFIELD sfeb003 name="input.c.page1.sfeb003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb004
            #add-point:ON ACTION controlp INFIELD sfeb004 name="input.c.page1.sfeb004"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb004   
            LET g_qryparam.arg1 = g_sfeb_d[l_ac].sfeb023
            LET g_qryparam.arg2 = g_sfeb_d[l_ac].sfeb024  

            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_item_sql('6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end

            CASE g_sfeb_d[l_ac].sfeb003 
                 WHEN '2'    #联产品
                       CALL q_bmab003_1()         
                 WHEN '5'    #副产品
                       CALL q_bmac003_2()     
            END CASE
            LET g_sfeb_d[l_ac].sfeb004 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb004 
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb005
            #add-point:ON ACTION controlp INFIELD sfeb005 name="input.c.page1.sfeb005"
                                    
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb005  
            SELECT imaa005 INTO l_imaa005 FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_sfeb_d[l_ac].sfeb004           
            LET g_qryparam.arg1 = l_imaa005
            LET g_qryparam.arg2 = '待确认'               
            CALL q_imec003()                   
            LET g_sfeb_d[l_ac].sfeb005 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb005
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb006
            #add-point:ON ACTION controlp INFIELD sfeb006 name="input.c.page1.sfeb006"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb006 
            CALL q_imaf001_5()
            LET g_sfeb_d[l_ac].sfeb006 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb006     
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb007
            #add-point:ON ACTION controlp INFIELD sfeb007 name="input.c.page1.sfeb007"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb007 
            CALL q_ooca001_1()
            LET g_sfeb_d[l_ac].sfeb007 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb007
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb008
            #add-point:ON ACTION controlp INFIELD sfeb008 name="input.c.page1.sfeb008"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb027
            #add-point:ON ACTION controlp INFIELD sfeb027 name="input.c.page1.sfeb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb009
            #add-point:ON ACTION controlp INFIELD sfeb009 name="input.c.page1.sfeb009"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb010
            #add-point:ON ACTION controlp INFIELD sfeb010 name="input.c.page1.sfeb010"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb010 
            CALL q_ooca001_1()
            LET g_sfeb_d[l_ac].sfeb010 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb010
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb011
            #add-point:ON ACTION controlp INFIELD sfeb011 name="input.c.page1.sfeb011"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb012
            #add-point:ON ACTION controlp INFIELD sfeb012 name="input.c.page1.sfeb012"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb013
            #add-point:ON ACTION controlp INFIELD sfeb013 name="input.c.page1.sfeb013"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb013
			   
            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_doc_sql("inaa001",g_sfea_m.sfeadocno,'6')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
			   
            CALL q_inaa001_2()
            LET g_sfeb_d[l_ac].sfeb013 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb013
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb014
            #add-point:ON ACTION controlp INFIELD sfeb014 name="input.c.page1.sfeb014"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb014 
            LET g_qryparam.arg1 = g_sfeb_d[l_ac].sfeb013 
            CALL q_inab002_3()
            LET g_sfeb_d[l_ac].sfeb014 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb014

            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb015
            #add-point:ON ACTION controlp INFIELD sfeb015 name="input.c.page1.sfeb015"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb016
            #add-point:ON ACTION controlp INFIELD sfeb016 name="input.c.page1.sfeb016"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb020
            #add-point:ON ACTION controlp INFIELD sfeb020 name="input.c.page1.sfeb020"
            #開窗i段
	   	   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfeb_d[l_ac].sfeb020 
            LET g_qryparam.arg1 = '225'
            #关于控制组
            LET g_qryparam.where = " 1=1 "
            CALL s_control_get_doc_sql("oocq002",g_sfea_m.sfeadocno,'8')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_oocq002()
            LET g_sfeb_d[l_ac].sfeb020 = g_qryparam.return1     #將開窗取得的值回傳到變數
            NEXT FIELD sfeb020
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb021
            #add-point:ON ACTION controlp INFIELD sfeb021 name="input.c.page1.sfeb021"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.sfeb022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfeb022
            #add-point:ON ACTION controlp INFIELD sfeb022 name="input.c.page1.sfeb022"
                        
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt340_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_sfeb_d[l_ac].sfebseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                              
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asrt340_sfeb_t_mask_restore('restore_mask_o')
      
               UPDATE sfeb_t SET (sfebdocno,sfebseq,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004, 
                   sfeb005,sfeb006,sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014, 
                   sfeb015,sfeb016,sfeb020,sfeb021,sfeb022,sfebsite) = (g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq, 
                   g_sfeb_d[l_ac].sfeb023,g_sfeb_d[l_ac].sfeb024,g_sfeb_d[l_ac].sfeb025,g_sfeb_d[l_ac].sfeb002, 
                   g_sfeb_d[l_ac].sfeb003,g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb006, 
                   g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb008,g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb009, 
                   g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb011,g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013, 
                   g_sfeb_d[l_ac].sfeb014,g_sfeb_d[l_ac].sfeb015,g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb020, 
                   g_sfeb_d[l_ac].sfeb021,g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfebsite)
                WHERE sfebent = g_enterprise AND sfebdocno = g_sfea_m.sfeadocno 
 
                  AND sfebseq = g_sfeb_d_t.sfebseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                              
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfeb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_sfeb_d[l_ac].* = g_sfeb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sfea_m.sfeadocno
               LET gs_keys_bak[1] = g_sfeadocno_t
               LET gs_keys[2] = g_sfeb_d[g_detail_idx].sfebseq
               LET gs_keys_bak[2] = g_sfeb_d_t.sfebseq
               CALL asrt340_update_b('sfeb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asrt340_sfeb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_sfeb_d[g_detail_idx].sfebseq = g_sfeb_d_t.sfebseq 
 
                  ) THEN
                  LET gs_keys[01] = g_sfea_m.sfeadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_sfeb_d_t.sfebseq
 
                  CALL asrt340_key_update_b(gs_keys,'sfeb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_sfea_m),util.JSON.stringify(g_sfeb_d_t)
               LET g_log2 = util.JSON.stringify(g_sfea_m),util.JSON.stringify(g_sfeb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_sfeb_d[l_ac].sfeb002 = 'N' THEN
                  DELETE FROM sfec_t
                   WHERE sfecent   = g_enterprise
                     AND sfecdocno = g_sfea_m.sfeadocno
                     AND sfecseq   = g_sfeb_d_t.sfebseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'delete sfec'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  END IF
                  
                  CALL asrt340_ins_sfec(g_sfeb_d[l_ac].*)
                       RETURNING l_success
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins sfec'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')                  
                  END IF
               END IF
               

               IF NOT cl_null(g_sfeb_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4',g_sfeb_d[l_ac].ooff013)
                       RETURNING l_success
               ELSE
                  CALL s_aooi360_del('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4')
                       RETURNING l_success
               END IF      
               CALL asrt340_b_fill()               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                        
            #end add-point
            CALL asrt340_unlock_b("sfeb_t","'1'")
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
               LET g_sfeb_d[li_reproduce_target].* = g_sfeb_d[li_reproduce].*
 
               LET g_sfeb_d[li_reproduce_target].sfebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sfeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sfeb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_sfeb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL asrt340_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body3.before_row"
                        
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL asrt340_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="asrt340.input.other" >}
      
      #add-point:自定義input name="input.more_input"
                  #單頭段
      INPUT g_ooff013 FROM FORMONLY.ooff013
         ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL s_transaction_begin()

            IF NOT cl_null(g_ooff013) THEN
               CALL s_aooi360_gen('6',g_sfea_m.sfeadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','4',g_ooff013)
                  RETURNING l_success
            ELSE
               CALL s_aooi360_del('6',g_sfea_m.sfeadocno,' ',' ',' ',' ',' ',' ',' ',' ',' ','4')
                  RETURNING l_success
            END IF
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF

           #controlp
      END INPUT

      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
                  
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD sfeadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sfebseq
               WHEN "s_detail3"
                  NEXT FIELD sfecseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
      
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asrt340_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
      
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asrt340_b_fill() #單身填充
      CALL asrt340_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asrt340_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            #取单据说明
            CALL s_aooi200_get_slip_desc(g_sfea_m.sfeadocno)
                 RETURNING g_sfea_m.sfeadocno_desc
            DISPLAY BY NAME g_sfea_m.sfeadocno_desc
            
            
#            CALL s_desc_get_person_desc(g_sfea_m.sfea002)
#                 RETURNING g_sfea_m.sfea002_desc
#            DISPLAY BY NAME g_sfea_m.sfea002_desc
#
#            CALL s_desc_get_department_desc(g_sfea_m.sfea003)
#                 RETURNING g_sfea_m.sfea003_desc
#            DISPLAY BY NAME g_sfea_m.sfea003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeaownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeaownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeaownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeaowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeaowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeaowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeacrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeacrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeacrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeacrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeacrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeacrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeamodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeamodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeamodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeacnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeacnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeacnfid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_sfea_m.sfeapstid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_sfea_m.sfeapstid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_sfea_m.sfeapstid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_sfea_m_mask_o.* =  g_sfea_m.*
   CALL asrt340_sfea_t_mask()
   LET g_sfea_m_mask_n.* =  g_sfea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeadocno_desc,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001, 
       g_sfea_m.sfea002,g_sfea_m.sfea002_desc,g_sfea_m.sfea003,g_sfea_m.sfea003_desc,g_sfea_m.sfeastus, 
       g_sfea_m.sfea006,g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaownid_desc,g_sfea_m.sfeaowndp, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp, 
       g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid,g_sfea_m.sfeamodid_desc,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstid_desc,g_sfea_m.sfeapstdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sfea_m.sfeastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_sfeb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
#     CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb023)
#          RETURNING g_sfeb_d[l_ac].sfeb023_desc,g_sfeb_d[l_ac].sfeb023_desc_desc
#     DISPLAY BY NAME g_sfeb_d[l_ac].sfeb023_desc,g_sfeb_d[l_ac].sfeb023_desc_desc
#     
#     CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
#          RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc
#     DISPLAY BY NAME g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc            
#
#     LET g_sfeb_d[l_ac].sfeb013_desc = s_desc_get_stock_desc(g_site,g_sfeb_d[l_ac].sfeb013)
#     DISPLAY BY NAME g_sfeb_d[l_ac].sfeb013_desc
#           
#     LET g_sfeb_d[l_ac].sfeb014_desc = s_desc_get_locator_desc(g_site,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014)
#     DISPLAY BY NAME g_sfeb_d[l_ac].sfeb014_desc
            
      LET g_sfeb_d[l_ac].sfeb020_desc = s_desc_get_acc_desc('225',g_sfeb_d[l_ac].sfeb020)
      DISPLAY BY NAME g_sfeb_d[l_ac].sfeb020_desc

      CALL s_aooi360_sel('7',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfebseq,'','','','','','','','','4')
           RETURNING l_success,g_sfeb_d[l_ac].ooff013


      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_sfeb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      SELECT sfeb002 INTO g_sfeb3_d[l_ac].sfeb002 FROM sfeb_t
       WHERE sfebent   = g_enterprise
         AND sfebdocno = g_sfea_m.sfeadocno
         AND sfebseq   = g_sfeb3_d[l_ac].sfecseq
      DISPLAY BY NAME g_sfeb3_d[l_ac].sfeb002

#      CALL s_desc_get_item_desc(g_sfeb3_d[l_ac].sfec018)
#           RETURNING g_sfeb3_d[l_ac].sfec018_desc,g_sfeb3_d[l_ac].sfec018_desc_desc
#      DISPLAY BY NAME g_sfeb3_d[l_ac].sfec005_desc,g_sfeb3_d[l_ac].sfec005_desc_desc 
#      
#      CALL s_desc_get_item_desc(g_sfeb3_d[l_ac].sfec005)
#           RETURNING g_sfeb3_d[l_ac].sfec005_desc,g_sfeb3_d[l_ac].sfec005_desc_desc
#      DISPLAY BY NAME g_sfeb3_d[l_ac].sfec005_desc,g_sfeb3_d[l_ac].sfec005_desc_desc 
#            
#      LET g_sfeb3_d[l_ac].sfec012_desc = s_desc_get_stock_desc(g_site,g_sfeb3_d[l_ac].sfec012)
#      DISPLAY BY NAME g_sfeb3_d[l_ac].sfec012_desc
#            
#      LET g_sfeb3_d[l_ac].sfec013_desc = s_desc_get_locator_desc(g_site,g_sfeb3_d[l_ac].sfec012,g_sfeb3_d[l_ac].sfec013)
#      DISPLAY BY NAME g_sfeb3_d[l_ac].sfec013_desc
      
      #判定结果说明
      LET g_sfeb3_d[l_ac].sfec003_desc_desc = s_desc_get_qc_desc(g_sfeb3_d[l_ac].sfecsite,g_sfeb3_d[l_ac].sfec003_desc)


      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
      
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asrt340_detail_show()
 
   #add-point:show段之後 name="show.after"
#151012---s
#   FOR l_ac = 1 TO g_inao1_d.getLength()
#      #帶出公用欄位reference值
#      
#      #add-point:show段單身reference
#      CALL s_desc_get_item_desc(g_inao1_d[l_ac].inao001)
#           RETURNING g_inao1_d[l_ac].inao001_desc1,g_inao1_d[l_ac].inao001_desc2
#      DISPLAY BY NAME g_inao1_d[l_ac].inao001_desc1,g_inao1_d[l_ac].inao001_desc2 
#      #end add-point
#   END FOR
#
#   FOR l_ac = 1 TO g_inao_d2.getLength()
#      #帶出公用欄位reference值
#      
#      #add-point:show段單身reference
#      CALL s_desc_get_item_desc(g_inao_d2[l_ac].inao001)
#           RETURNING g_inao_d2[l_ac].inao001_desc1,g_inao_d2[l_ac].inao001_desc2
#      DISPLAY BY NAME g_inao_d2[l_ac].inao001_desc1,g_inao_d2[l_ac].inao001_desc2 
#      #end add-point
#   END FOR
#151012---e
   
   #yemy 也要CALL一次asrt340_detail_show()吗?
   IF NOT cl_null(g_sfea_m.sfeadocno) THEN 
      CALL s_aooi360_sel('6',g_sfea_m.sfeadocno,'','','','','','','','','','4')
           RETURNING l_success,g_ooff013
      DISPLAY g_ooff013 TO FORMONLY.ooff013
   END IF
   CALL asrt340_get_srab000()
   
   LET l_ac = l_ac_t
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asrt340_detail_show()
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
 
{<section id="asrt340.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asrt340_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE sfea_t.sfeadocno 
   DEFINE l_oldno     LIKE sfea_t.sfeadocno 
 
   DEFINE l_master    RECORD LIKE sfea_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE sfeb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE sfec_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
      
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
   
   IF g_sfea_m.sfeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
    
   LET g_sfea_m.sfeadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sfea_m.sfeaownid = g_user
      LET g_sfea_m.sfeaowndp = g_dept
      LET g_sfea_m.sfeacrtid = g_user
      LET g_sfea_m.sfeacrtdp = g_dept 
      LET g_sfea_m.sfeacrtdt = cl_get_current()
      LET g_sfea_m.sfeamodid = g_user
      LET g_sfea_m.sfeamoddt = cl_get_current()
      LET g_sfea_m.sfeastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
      
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sfea_m.sfeastus 
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_sfea_m.sfeadocno_desc = ''
   DISPLAY BY NAME g_sfea_m.sfeadocno_desc
 
   
   CALL asrt340_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_sfea_m.* TO NULL
      INITIALIZE g_sfeb_d TO NULL
      INITIALIZE g_sfeb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asrt340_show()
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
   CALL asrt340_set_act_visible()   
   CALL asrt340_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " sfeaent = " ||g_enterprise|| " AND",
                      " sfeadocno = '", g_sfea_m.sfeadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt340_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
      
   #end add-point
   
   CALL asrt340_idx_chk()
   
   LET g_data_owner = g_sfea_m.sfeaownid      
   LET g_data_dept  = g_sfea_m.sfeaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt340_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asrt340_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sfeb_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE sfec_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
         DEFINE l_detail3    RECORD LIKE inao_t.*
   DEFINE l_detail4    RECORD LIKE inao_t.*
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asrt340_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sfeb_t
    WHERE sfebent = g_enterprise AND sfebdocno = g_sfeadocno_t
 
    INTO TEMP asrt340_detail
 
   #將key修正為調整後   
   UPDATE asrt340_detail 
      #更新key欄位
      SET sfebdocno = g_sfea_m.sfeadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO sfeb_t SELECT * FROM asrt340_detail
   
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
   DROP TABLE asrt340_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
      
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
      
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sfec_t 
    WHERE sfecent = g_enterprise AND sfecdocno = g_sfeadocno_t
 
    INTO TEMP asrt340_detail
 
   #將key修正為調整後   
   UPDATE asrt340_detail SET sfecdocno = g_sfea_m.sfeadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO sfec_t SELECT * FROM asrt340_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
      
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asrt340_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
         
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE asrt340_detail AS ",
      "SELECT * FROM inao_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asrt340_detail SELECT * FROM inao_t
                                         WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno = g_sfeadocno_t
                                           AND inao000 = '1'


   #將key修正為調整後   
   UPDATE asrt340_detail SET inaodocno = g_sfea_m.sfeadocno

  
   #將資料塞回原table   
   INSERT INTO inao_t SELECT * FROM asrt340_detail
   
   DROP TABLE asrt340_detail
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE asrt340_detail AS ",
      "SELECT * FROM inao_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO asrt340_detail SELECT * FROM inao_t
                                         WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno = g_sfeadocno_t
                                           AND inao000 = '2'


   #將key修正為調整後   
   UPDATE asrt340_detail SET inaodocno = g_sfea_m.sfeadocno

  
   #將資料塞回原table   
   INSERT INTO inao_t SELECT * FROM asrt340_detail   
   
   DROP TABLE asrt340_detail
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asrt340_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
         IF g_sfea_m.sfeastus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00034'
      LET g_errparam.extend = g_sfea_m.sfeastus
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_sfea_m.sfeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asrt340_cl USING g_enterprise,g_sfea_m.sfeadocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt340_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
   
   #檢查是否允許此動作
   IF NOT asrt340_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sfea_m_mask_o.* =  g_sfea_m.*
   CALL asrt340_sfea_t_mask()
   LET g_sfea_m_mask_n.* =  g_sfea_m.*
   
   CALL asrt340_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
            
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt340_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_sfeadocno_t = g_sfea_m.sfeadocno
 
 
      DELETE FROM sfea_t
       WHERE sfeaent = g_enterprise AND sfeadocno = g_sfea_m.sfeadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
            
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_sfea_m.sfeadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
                  IF NOT s_aooi200_del_docno(g_sfea_m.sfeadocno,g_sfea_m.sfeadocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
            
      #end add-point
      
      DELETE FROM sfeb_t
       WHERE sfebent = g_enterprise AND sfebdocno = g_sfea_m.sfeadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
            
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
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
      DELETE FROM sfec_t
       WHERE sfecent = g_enterprise AND
             sfecdocno = g_sfea_m.sfeadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise AND inaosite = g_site AND
             inaodocno = g_sfea_m.sfeadocno
         #AND (inao000 = '1' OR inao000 = '2')  151012

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      
      CALL g_inao1_d.clear()
      CALL g_inao_d2.clear()
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_sfea_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asrt340_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_sfeb_d.clear() 
      CALL g_sfeb3_d.clear()       
 
     
      CALL asrt340_ui_browser_refresh()  
      #CALL asrt340_ui_headershow()  
      #CALL asrt340_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asrt340_browser_fill("")
         CALL asrt340_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asrt340_cl
 
   #功能已完成,通報訊息中心
   CALL asrt340_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asrt340.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asrt340_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
      
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_sfeb_d.clear()
   CALL g_sfeb3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #CALL g_inao1_d.clear()  
#   CALL g_inao_d2.clear()
#151012---s   
#      #判斷是否填充
#   IF asrt340_fill_chk(3) THEN
#      LET g_sql = "SELECT  UNIQUE inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao010,inao012 FROM inao_t",   
#                  " INNER JOIN sfea_t ON sfeadocno = inaodocno ",
#
#                  "",
#                  
#                  " WHERE inaoent=? AND inaosite=? AND inaodocno=? AND inao000 = '1'"   
#      
#      IF NOT cl_null(g_wc2_table3) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
#      END IF
#      
#      #子單身的WC
#      
#      
#      LET g_sql = g_sql, " ORDER BY inao_t.inaoseq,inao_t.inaoseq1,inao_t.inaoseq2"
#
#      
#      PREPARE asrt340_pb3 FROM g_sql
#      DECLARE b_fill_cs3 CURSOR FOR asrt340_pb3
#      
#      LET l_ac = 1
#      
#      OPEN b_fill_cs3 USING g_enterprise,g_site,g_sfea_m.sfeadocno
#
#                                               
#      FOREACH b_fill_cs3 INTO g_inao1_d[l_ac].inaoseq,g_inao1_d[l_ac].inaoseq1,g_inao1_d[l_ac].inaoseq2,
#                              g_inao1_d[l_ac].inao001,g_inao1_d[l_ac].inao008,g_inao1_d[l_ac].inao009,
#                              g_inao1_d[l_ac].inao010,g_inao1_d[l_ac].inao012
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            EXIT FOREACH
#         END IF
#        
#         #add-point:b_fill段資料填充
#
#         #end add-point
#      
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code =  9035
#            LET g_errparam.extend =  ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#      CALL g_inao1_d.deleteElement(l_ac)
#   END IF
#
#
#   #IF asrt340_fill_chk(4) THEN  #151012
#      LET g_sql = "SELECT  UNIQUE inaoseq,inaoseq1,inaoseq2,inao001,inao008,inao009,inao010,inao012 FROM inao_t",   
#                  " INNER JOIN sfea_t ON sfeadocno = inaodocno ",
#
#                  "",
#                  
#                  " WHERE inaoent=? AND inaosite=? AND inaodocno=? AND inao000 = '2'"   
#      
#      IF NOT cl_null(g_wc2_table4) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
#      END IF
#      
#      #子單身的WC
#      
#      
#      LET g_sql = g_sql, " ORDER BY inao_t.inaoseq,inao_t.inaoseq1,inao_t.inaoseq2"
#
#      
#      PREPARE asrt340_pb4 FROM g_sql
#      DECLARE b_fill_cs4 CURSOR FOR asrt340_pb4
#      
#      LET l_ac = 1
#      
#      OPEN b_fill_cs4 USING g_enterprise,g_site,g_sfea_m.sfeadocno
#
#                                               
#      FOREACH b_fill_cs4 INTO g_inao_d2[l_ac].inaoseq,g_inao_d2[l_ac].inaoseq1,g_inao_d2[l_ac].inaoseq2,
#                              g_inao_d2[l_ac].inao001,g_inao_d2[l_ac].inao008,g_inao_d2[l_ac].inao009,
#                              g_inao_d2[l_ac].inao010,g_inao_d2[l_ac].inao012
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = SQLCA.sqlcode
#            LET g_errparam.extend = "FOREACH:"
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            EXIT FOREACH
#         END IF
#        
#         #add-point:b_fill段資料填充
#
#         #end add-point
#      
#         LET l_ac = l_ac + 1
#         IF l_ac > g_max_rec THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code =  9035
#            LET g_errparam.extend =  ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#
#            EXIT FOREACH
#         END IF
#         
#      END FOREACH
#      CALL g_inao_d2.deleteElement(l_ac)
#   #END IF   #151012-
#   
#
#   #FREE asrt340_pb3   #151012
#   FREE asrt340_pb4
#151012---e   
   #end add-point
   
   #判斷是否填充
   IF asrt340_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT sfebseq,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004,sfeb005, 
             sfeb006,sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015, 
             sfeb016,sfeb020,sfeb021,sfeb022,sfebsite ,t1.imaal003 ,t2.imaal004 ,t3.imaal003 ,t4.imaal004 , 
             t5.inaa002 ,t6.inab003 FROM sfeb_t",   
                     " INNER JOIN sfea_t ON sfeaent = " ||g_enterprise|| " AND sfeadocno = sfebdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=sfeb023 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=sfeb023 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=sfeb004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=sfeb004 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaa_t t5 ON t5.inaaent="||g_enterprise||" AND t5.inaasite=sfebsite AND t5.inaa001=sfeb013  ",
               " LEFT JOIN inab_t t6 ON t6.inabent="||g_enterprise||" AND t6.inabsite=sfebsite AND t6.inab001=sfeb013 AND t6.inab002=sfeb014  ",
 
                     " WHERE sfebent=? AND sfebdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sfeb_t.sfebseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt340_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asrt340_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_sfea_m.sfeadocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_sfea_m.sfeadocno INTO g_sfeb_d[l_ac].sfebseq,g_sfeb_d[l_ac].sfeb023, 
          g_sfeb_d[l_ac].sfeb024,g_sfeb_d[l_ac].sfeb025,g_sfeb_d[l_ac].sfeb002,g_sfeb_d[l_ac].sfeb003, 
          g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb005,g_sfeb_d[l_ac].sfeb006,g_sfeb_d[l_ac].sfeb007, 
          g_sfeb_d[l_ac].sfeb008,g_sfeb_d[l_ac].sfeb027,g_sfeb_d[l_ac].sfeb009,g_sfeb_d[l_ac].sfeb010, 
          g_sfeb_d[l_ac].sfeb011,g_sfeb_d[l_ac].sfeb012,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014, 
          g_sfeb_d[l_ac].sfeb015,g_sfeb_d[l_ac].sfeb016,g_sfeb_d[l_ac].sfeb020,g_sfeb_d[l_ac].sfeb021, 
          g_sfeb_d[l_ac].sfeb022,g_sfeb_d[l_ac].sfebsite,g_sfeb_d[l_ac].sfeb023_desc,g_sfeb_d[l_ac].sfeb023_desc_desc, 
          g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc,g_sfeb_d[l_ac].sfeb013_desc,g_sfeb_d[l_ac].sfeb014_desc  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
                  
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
   IF asrt340_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT sfecseq,sfecseq1,sfec018,sfec019,sfec020,sfec002,sfec003,sfec004, 
             sfec005,sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015, 
             sfec016,sfec017,sfecsite ,t7.imaal003 ,t8.imaal004 ,t9.qcbc002 ,t10.imaal003 ,t11.imaal004 , 
             t12.inaa002 ,t13.inab003 FROM sfec_t",   
                     " INNER JOIN  sfea_t ON sfeaent = " ||g_enterprise|| " AND sfeadocno = sfecdocno ",
 
                     "",
                     
                                    " LEFT JOIN imaal_t t7 ON t7.imaalent="||g_enterprise||" AND t7.imaal001=sfec018 AND t7.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t8 ON t8.imaalent="||g_enterprise||" AND t8.imaal001=sfec018 AND t8.imaal002='"||g_dlang||"' ",
               " LEFT JOIN qcbc_t t9 ON t9.qcbcent="||g_enterprise||" AND t9.qcbcsite=sfecsite AND t9.qcbcdocno=sfec002 AND t9.qcbcseq=sfec003  ",
               " LEFT JOIN imaal_t t10 ON t10.imaalent="||g_enterprise||" AND t10.imaal001=sfec005 AND t10.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t11 ON t11.imaalent="||g_enterprise||" AND t11.imaal001=sfec005 AND t11.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaa_t t12 ON t12.inaaent="||g_enterprise||" AND t12.inaasite=sfecsite AND t12.inaa001=sfec012  ",
               " LEFT JOIN inab_t t13 ON t13.inabent="||g_enterprise||" AND t13.inabsite=sfecsite AND t13.inab001=sfec012 AND t13.inab002=sfec013  ",
 
                     " WHERE sfecent=? AND sfecdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
            
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sfec_t.sfecseq,sfec_t.sfecseq1"
         
         #add-point:單身填充控制 name="b_fill.sql2"
            
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt340_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR asrt340_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_sfea_m.sfeadocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_sfea_m.sfeadocno INTO g_sfeb3_d[l_ac].sfecseq,g_sfeb3_d[l_ac].sfecseq1, 
          g_sfeb3_d[l_ac].sfec018,g_sfeb3_d[l_ac].sfec019,g_sfeb3_d[l_ac].sfec020,g_sfeb3_d[l_ac].sfec002, 
          g_sfeb3_d[l_ac].sfec003,g_sfeb3_d[l_ac].sfec004,g_sfeb3_d[l_ac].sfec005,g_sfeb3_d[l_ac].sfec006, 
          g_sfeb3_d[l_ac].sfec007,g_sfeb3_d[l_ac].sfec008,g_sfeb3_d[l_ac].sfec009,g_sfeb3_d[l_ac].sfec010, 
          g_sfeb3_d[l_ac].sfec011,g_sfeb3_d[l_ac].sfec012,g_sfeb3_d[l_ac].sfec013,g_sfeb3_d[l_ac].sfec014, 
          g_sfeb3_d[l_ac].sfec015,g_sfeb3_d[l_ac].sfec016,g_sfeb3_d[l_ac].sfec017,g_sfeb3_d[l_ac].sfecsite, 
          g_sfeb3_d[l_ac].sfec018_desc,g_sfeb3_d[l_ac].sfec018_desc_desc,g_sfeb3_d[l_ac].sfec003_desc, 
          g_sfeb3_d[l_ac].sfec005_desc,g_sfeb3_d[l_ac].sfec005_desc_desc,g_sfeb3_d[l_ac].sfec012_desc, 
          g_sfeb3_d[l_ac].sfec013_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
                              
#         SELECT qcbc002 INTO g_sfeb3_d[l_ac].sfec003_desc1 FROM qcbc_t
#          WHERE qcbcent   = g_enterprise
#            AND qcbcsite  = g_sfeb3_d[l_ac].sfecsite
#            AND qcbcdocno = g_sfeb3_d[l_ac].sfec002
#            AND qcbcseq   = g_sfeb3_d[l_ac].sfec003
      
         SELECT sfeb002 INTO g_sfeb3_d[l_ac].sfeb002 FROM sfeb_t
          WHERE sfebent   = g_enterprise
            AND sfebdocno = g_sfea_m.sfeadocno
            AND sfebseq   = g_sfeb3_d[l_ac].sfecseq
 
         #判定结果说明
         LET g_sfeb3_d[l_ac].sfec003_desc_desc = s_desc_get_qc_desc(g_sfeb3_d[l_ac].sfecsite,g_sfeb3_d[l_ac].sfec003_desc)
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
   IF NOT cl_null(g_sfea_m.sfeadocno) THEN   
      CALL s_lot_b_fill('2',g_site,'1',g_sfea_m.sfeadocno,'','','1')
      CALL asrt340_inao_fill()
   END IF      
   #end add-point
   
   CALL g_sfeb_d.deleteElement(g_sfeb_d.getLength())
   CALL g_sfeb3_d.deleteElement(g_sfeb3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asrt340_pb
   FREE asrt340_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_sfeb_d.getLength()
      LET g_sfeb_d_mask_o[l_ac].* =  g_sfeb_d[l_ac].*
      CALL asrt340_sfeb_t_mask()
      LET g_sfeb_d_mask_n[l_ac].* =  g_sfeb_d[l_ac].*
   END FOR
   
   LET g_sfeb3_d_mask_o.* =  g_sfeb3_d.*
   FOR l_ac = 1 TO g_sfeb3_d.getLength()
      LET g_sfeb3_d_mask_o[l_ac].* =  g_sfeb3_d[l_ac].*
      CALL asrt340_sfec_t_mask()
      LET g_sfeb3_d_mask_n[l_ac].* =  g_sfeb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asrt340_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
         LET ls_group = "'3','4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前

      #end add-point    
      DELETE FROM inao_t
       WHERE inaoent = g_enterprise AND inaosite = g_site AND
         inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5]
      #add-point:delete_b段刪除中

      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後

      #end add-point    
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
            
      #end add-point    
      DELETE FROM sfeb_t
       WHERE sfebent = g_enterprise AND
         sfebdocno = ps_keys_bak[1] AND sfebseq = ps_keys_bak[2]
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
         CALL g_sfeb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
            
      #end add-point    
      DELETE FROM sfec_t
       WHERE sfecent = g_enterprise AND
             sfecdocno = ps_keys_bak[1] AND sfecseq = ps_keys_bak[2] AND sfecseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
            
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sfeb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
            
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
      
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asrt340_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
  LET ls_group = "'3','4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前

      #end add-point 
      INSERT INTO inao_t
                  (inaoent, inaosite,inaodocno,
                   inaoseq,inaoseq1,inaoseq2,inao000,
                   inao001,inao008,inao009,inao010,inao012) 
            VALUES(g_enterprise, g_site,ps_keys[1],
                   ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],
                   g_inao1_d[g_detail_idx].inao001,g_inao1_d[g_detail_idx].inao008,
                   g_inao1_d[g_detail_idx].inao009,g_inao1_d[g_detail_idx].inao010,
                   g_inao1_d[g_detail_idx].inao012)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後

      #end add-point
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
            
      #end add-point 
      INSERT INTO sfeb_t
                  (sfebent,
                   sfebdocno,
                   sfebseq
                   ,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb020,sfeb021,sfeb022,sfebsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sfeb_d[g_detail_idx].sfeb023,g_sfeb_d[g_detail_idx].sfeb024,g_sfeb_d[g_detail_idx].sfeb025, 
                       g_sfeb_d[g_detail_idx].sfeb002,g_sfeb_d[g_detail_idx].sfeb003,g_sfeb_d[g_detail_idx].sfeb004, 
                       g_sfeb_d[g_detail_idx].sfeb005,g_sfeb_d[g_detail_idx].sfeb006,g_sfeb_d[g_detail_idx].sfeb007, 
                       g_sfeb_d[g_detail_idx].sfeb008,g_sfeb_d[g_detail_idx].sfeb027,g_sfeb_d[g_detail_idx].sfeb009, 
                       g_sfeb_d[g_detail_idx].sfeb010,g_sfeb_d[g_detail_idx].sfeb011,g_sfeb_d[g_detail_idx].sfeb012, 
                       g_sfeb_d[g_detail_idx].sfeb013,g_sfeb_d[g_detail_idx].sfeb014,g_sfeb_d[g_detail_idx].sfeb015, 
                       g_sfeb_d[g_detail_idx].sfeb016,g_sfeb_d[g_detail_idx].sfeb020,g_sfeb_d[g_detail_idx].sfeb021, 
                       g_sfeb_d[g_detail_idx].sfeb022,g_sfeb_d[g_detail_idx].sfebsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
            
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_sfeb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
            
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
            
      #end add-point 
      INSERT INTO sfec_t
                  (sfecent,
                   sfecdocno,
                   sfecseq,sfecseq1
                   ,sfec018,sfec019,sfec020,sfec002,sfec003,sfec004,sfec005,sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,sfec016,sfec017,sfecsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_sfeb3_d[g_detail_idx].sfec018,g_sfeb3_d[g_detail_idx].sfec019,g_sfeb3_d[g_detail_idx].sfec020, 
                       g_sfeb3_d[g_detail_idx].sfec002,g_sfeb3_d[g_detail_idx].sfec003,g_sfeb3_d[g_detail_idx].sfec004, 
                       g_sfeb3_d[g_detail_idx].sfec005,g_sfeb3_d[g_detail_idx].sfec006,g_sfeb3_d[g_detail_idx].sfec007, 
                       g_sfeb3_d[g_detail_idx].sfec008,g_sfeb3_d[g_detail_idx].sfec009,g_sfeb3_d[g_detail_idx].sfec010, 
                       g_sfeb3_d[g_detail_idx].sfec011,g_sfeb3_d[g_detail_idx].sfec012,g_sfeb3_d[g_detail_idx].sfec013, 
                       g_sfeb3_d[g_detail_idx].sfec014,g_sfeb3_d[g_detail_idx].sfec015,g_sfeb3_d[g_detail_idx].sfec016, 
                       g_sfeb3_d[g_detail_idx].sfec017,g_sfeb3_d[g_detail_idx].sfecsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
            
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sfec_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sfeb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
            
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
      
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asrt340_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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



   LET ls_group = "'3','4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inao_t" THEN
      #add-point:update_b段修改前

      #end add-point     
      UPDATE inao_t 
         SET (inaodocno,
              inaoseq,inaoseq1,inaoseq2,inao000,
              inao001,inao008,inao009,inao010,inao012) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5]
              ,g_inao1_d[g_detail_idx].inao001,g_inao1_d[g_detail_idx].inao008,
              g_inao1_d[g_detail_idx].inao009,g_inao1_d[g_detail_idx].inao010,
              g_inao1_d[g_detail_idx].inao012) 
         WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno = ps_keys_bak[1] AND inaoseq = ps_keys_bak[2] AND inaoseq1 = ps_keys_bak[3] AND inaoseq2 = ps_keys_bak[4] AND inao000 = ps_keys_bak[5]
      #add-point:update_b段修改中

      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "inao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "inao_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後

      #end add-point  
   END IF
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sfeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
            
      #end add-point 
      
      #將遮罩欄位還原
      CALL asrt340_sfeb_t_mask_restore('restore_mask_o')
               
      UPDATE sfeb_t 
         SET (sfebdocno,
              sfebseq
              ,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,sfeb004,sfeb005,sfeb006,sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb020,sfeb021,sfeb022,sfebsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sfeb_d[g_detail_idx].sfeb023,g_sfeb_d[g_detail_idx].sfeb024,g_sfeb_d[g_detail_idx].sfeb025, 
                  g_sfeb_d[g_detail_idx].sfeb002,g_sfeb_d[g_detail_idx].sfeb003,g_sfeb_d[g_detail_idx].sfeb004, 
                  g_sfeb_d[g_detail_idx].sfeb005,g_sfeb_d[g_detail_idx].sfeb006,g_sfeb_d[g_detail_idx].sfeb007, 
                  g_sfeb_d[g_detail_idx].sfeb008,g_sfeb_d[g_detail_idx].sfeb027,g_sfeb_d[g_detail_idx].sfeb009, 
                  g_sfeb_d[g_detail_idx].sfeb010,g_sfeb_d[g_detail_idx].sfeb011,g_sfeb_d[g_detail_idx].sfeb012, 
                  g_sfeb_d[g_detail_idx].sfeb013,g_sfeb_d[g_detail_idx].sfeb014,g_sfeb_d[g_detail_idx].sfeb015, 
                  g_sfeb_d[g_detail_idx].sfeb016,g_sfeb_d[g_detail_idx].sfeb020,g_sfeb_d[g_detail_idx].sfeb021, 
                  g_sfeb_d[g_detail_idx].sfeb022,g_sfeb_d[g_detail_idx].sfebsite) 
         WHERE sfebent = g_enterprise AND sfebdocno = ps_keys_bak[1] AND sfebseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
            
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfeb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfeb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt340_sfeb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
            
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sfec_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
            
      #end add-point  
      
      #將遮罩欄位還原
      CALL asrt340_sfec_t_mask_restore('restore_mask_o')
               
      UPDATE sfec_t 
         SET (sfecdocno,
              sfecseq,sfecseq1
              ,sfec018,sfec019,sfec020,sfec002,sfec003,sfec004,sfec005,sfec006,sfec007,sfec008,sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,sfec016,sfec017,sfecsite) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_sfeb3_d[g_detail_idx].sfec018,g_sfeb3_d[g_detail_idx].sfec019,g_sfeb3_d[g_detail_idx].sfec020, 
                  g_sfeb3_d[g_detail_idx].sfec002,g_sfeb3_d[g_detail_idx].sfec003,g_sfeb3_d[g_detail_idx].sfec004, 
                  g_sfeb3_d[g_detail_idx].sfec005,g_sfeb3_d[g_detail_idx].sfec006,g_sfeb3_d[g_detail_idx].sfec007, 
                  g_sfeb3_d[g_detail_idx].sfec008,g_sfeb3_d[g_detail_idx].sfec009,g_sfeb3_d[g_detail_idx].sfec010, 
                  g_sfeb3_d[g_detail_idx].sfec011,g_sfeb3_d[g_detail_idx].sfec012,g_sfeb3_d[g_detail_idx].sfec013, 
                  g_sfeb3_d[g_detail_idx].sfec014,g_sfeb3_d[g_detail_idx].sfec015,g_sfeb3_d[g_detail_idx].sfec016, 
                  g_sfeb3_d[g_detail_idx].sfec017,g_sfeb3_d[g_detail_idx].sfecsite) 
         WHERE sfecent = g_enterprise AND sfecdocno = ps_keys_bak[1] AND sfecseq = ps_keys_bak[2] AND sfecseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
            
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfec_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sfec_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt340_sfec_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
            
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asrt340_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="asrt340.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asrt340_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="asrt340.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asrt340_lock_b(ps_table,ps_page)
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
   #CALL asrt340_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "sfeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asrt340_bcl USING g_enterprise,
                                       g_sfea_m.sfeadocno,g_sfeb_d[g_detail_idx].sfebseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt340_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "sfec_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asrt340_bcl2 USING g_enterprise,
                                             g_sfea_m.sfeadocno,g_sfeb3_d[g_detail_idx].sfecseq,g_sfeb3_d[g_detail_idx].sfecseq1 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt340_bcl2:",SQLERRMESSAGE 
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
 
{<section id="asrt340.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asrt340_unlock_b(ps_table,ps_page)
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
      CLOSE asrt340_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asrt340_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
      
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asrt340_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   DEFINE l_fields      STRING      
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("sfeadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("sfeadocno",TRUE)
      CALL cl_set_comp_entry("sfeadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("sfeadocdt",TRUE)        
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   IF NOT cl_null(g_sfea_m.sfeadocno) THEN
      LET l_fields = s_aooi200_get_doc_fields(g_sfea_m.sfeasite,'1',g_sfea_m.sfeadocno)
      CALL cl_set_comp_entry(l_fields,TRUE)
   END IF
      
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asrt340_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fields      STRING   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("sfeadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
            
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("sfeadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("sfeadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT cl_null(g_sfea_m.sfeadocno) THEN
      LET l_fields = s_aooi200_get_doc_fields(g_sfea_m.sfeasite,'1',g_sfea_m.sfeadocno)
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asrt340_set_entry_b(p_cmd)
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
         CALL cl_set_comp_entry("sfebseq,sfeb005,sfeb014,sfeb015,sfeb016",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asrt340_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaf055  LIKE imaf_t.imaf055
   DEFINE l_inaa007  LIKE inaa_t.inaa007
   DEFINE l_imaf061  LIKE imaf_t.imaf061
   DEFINE l_cnt      LIKE type_t.num5 
   DEFINE l_imaa005  LIKE imaa_t.imaa005
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
         
   IF NOT g_entried THEN
      IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry("sfebseq",FALSE)
      END IF
   END IF

   IF INFIELD(sfeb004) OR NOT g_entried THEN
      
      #判斷料件是否存在產品特徵功能
      LET l_imaa005 = ''
      SELECT imaa005 INTO l_imaa005 FROM imaa_t 
       WHERE imaaent = g_enterprise AND imaa001 = g_sfeb_d[l_ac].sfeb004 AND imafsite = g_site
      #主档上设定不使用特征值时,"sfeb005"设定为noentry
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("sfeb005",FALSE)
      END IF
   END IF

   IF INFIELD(sfeb004) OR NOT g_entried THEN
      #若設定imaf055(庫存管理特徵)等於'0.無'時，則[C:庫存管理特徵]欄位不可輸入
      SELECT imaf055,imaf061 INTO l_imaf055,l_imaf061 FROM imaf_t 
       WHERE imafent = g_enterprise AND imaf001 = g_sfeb_d[l_ac].sfeb004 AND imafsite = g_site
      #[T:料件據點進銷存檔].[C:庫存批號控管]=1或2時,[C:限定批號]欄位才可輸入
      IF l_imaf061 NOT MATCHES '[12]' THEN
         CALL cl_set_comp_entry("sfeb015",FALSE)
      END IF
      #若設定imaf055(庫存管理特徵)等於'0.無'時，則[C:庫存管理特徵]欄位不可輸入
      IF l_imaf055 = '2' THEN
         CALL cl_set_comp_entry("sfeb016",FALSE)
      END IF
   END IF

   IF INFIELD(sfeb013) OR NOT g_entried THEN
      #若[T:庫位資料檔].[C:儲位管理]='5'(不使用儲位管理)時，則[C:限定儲位]不可以維護
      SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_sfeb_d[l_ac].sfeb013
      IF l_inaa007 = '5' THEN
         CALL cl_set_comp_entry("sfeb014",FALSE)
      END IF
   END IF

   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asrt340_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asrt340_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_sfea_m.sfeastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asrt340_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asrt340_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asrt340_default_search()
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
      LET ls_wc = ls_wc, " sfeadocno = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "sfea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sfeb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sfec_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="asrt340.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION asrt340_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
      
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_sfea_m.sfeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN asrt340_cl USING g_enterprise,g_sfea_m.sfeadocno
   IF STATUS THEN
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt340_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
       g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
       g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
       g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
       g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
   
 
   #檢查是否允許此動作
   IF NOT asrt340_action_chk() THEN
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeadocno_desc,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt,g_sfea_m.sfea001, 
       g_sfea_m.sfea002,g_sfea_m.sfea002_desc,g_sfea_m.sfea003,g_sfea_m.sfea003_desc,g_sfea_m.sfeastus, 
       g_sfea_m.sfea006,g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaownid_desc,g_sfea_m.sfeaowndp, 
       g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp, 
       g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid,g_sfea_m.sfeamodid_desc,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid, 
       g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstid_desc,g_sfea_m.sfeapstdt 
 
 
   CASE g_sfea_m.sfeastus
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
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_sfea_m.sfeastus
            
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
            WHEN "S"
               HIDE OPTION "posted"
            WHEN "Z"
               HIDE OPTION "unposted"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_sfea_m.sfeastus
         WHEN "N"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "posted"
            HIDE OPTION "unposted"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,hold",FALSE)
         WHEN "X"
            HIDE OPTION "invalid"
            HIDE OPTION "confirmed"
            HIDE OPTION "posted"
            HIDE OPTION "unposted"
         WHEN "Y"
            HIDE OPTION "confirmed"
            HIDE OPTION "invalid"
            HIDE OPTION "unposted"
         WHEN "S"
            HIDE OPTION "posted"
            HIDE OPTION "confirmed"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "invalid"
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
            IF NOT asrt340_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt340_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT asrt340_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt340_cl
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
      #         #   
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
         #仅当状态为 Y.已审核,才可以切换为N.未审核   
         IF g_sfea_m.sfeastus NOT MATCHES '[XY]' THEN
            CALL s_transaction_end('N','0')  #160816-00068#3 add
            RETURN
         END IF
         IF g_sfea_m.sfeastus = 'Y' THEN
            CALL s_transaction_begin()         
            CALL s_asrt340_unconfirm(g_sfea_m.sfeadocno)
                 RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
            ELSE
               LET g_sfea_m.sfeastus = 'N'
               CALL s_transaction_end('Y',0)         
            END IF
            CALL asrt340_show_status()
            RETURN
         END IF            
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
      #         #   
      #      #end add-point
      #   END IF
      #   EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
         #仅当状态为 N.未审核/S.已过帐时,才可以切换为Y.已审核
         IF g_sfea_m.sfeastus NOT MATCHES '[N]' THEN
            CALL s_transaction_end('N','0')  #160816-00068#3 add
            RETURN
         END IF         
         IF g_sfea_m.sfeastus = 'N' THEN
            CALL s_transaction_begin()         
            CALL s_asrt340_confirm(g_sfea_m.sfeadocno)
                 RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N',0)
            ELSE
               LET g_sfea_m.sfeastus = 'Y'
               CALL s_transaction_end('Y',0)         
            END IF
            CALL asrt340_show_status()
            RETURN                
         END IF

            #end add-point
         END IF
         EXIT MENU
      ON ACTION posted
         IF cl_auth_chk_act("posted") THEN
            LET lc_state = "S"
            #add-point:action控制 name="statechange.posted"
                           
         #过帐前状态检查
         CALL s_asrt340_post_chk(g_sfea_m.sfeadocno)
              RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')  #160816-00068#3 add
            RETURN
         END IF
         #过帐日期录入
         CALL s_asrt340_post_input(g_sfea_m.sfeadocno)
              RETURNING l_success,g_sfea_m.sfea001
         IF NOT l_success THEN
            LET INT_FLAG = 0
            CALL s_transaction_end('N','0')  #160816-00068#3 add
            RETURN
         END IF         
         CALL s_transaction_begin()         
         CALL s_asrt340_post_upd(g_sfea_m.sfeadocno,g_sfea_m.sfea001)
              RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N',0)
         ELSE
            LET g_sfea_m.sfeastus = 'S'
            CALL s_transaction_end('Y',0)         
         END IF
         CALL asrt340_show_status()
         RETURN   
            #end add-point
         END IF
         EXIT MENU
      ON ACTION unposted
         IF cl_auth_chk_act("unposted") THEN
            LET lc_state = "Z"
            #add-point:action控制 name="statechange.unposted"
         LET lc_state = "Y"
         IF g_sfea_m.sfeastus = 'S' THEN
            CALL s_transaction_begin()         
            CALL s_asrt340_unpost(g_sfea_m.sfeadocno)
                 RETURNING l_success
            IF NOT l_success THEN
               LET lc_state = "S"
               CALL s_transaction_end('N',0)
            ELSE
               LET g_sfea_m.sfeastus = 'Y'
               CALL s_transaction_end('Y',0)         
            END IF
            CALL asrt340_show_status()
            RETURN           
         END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
         #仅当状态为 N.未审核 时,才可以切换为X.作废
         IF g_sfea_m.sfeastus NOT MATCHES '[N]' THEN
            CALL s_transaction_end('N','0')  #160816-00068#3 add
            RETURN
         END IF
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
      AND lc_state <> "S"
      AND lc_state <> "Z"
      AND lc_state <> "X"
      ) OR 
      g_sfea_m.sfeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #151125-00001#4 --- add start ---
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0') 
         RETURN
      END IF
   END IF
   #151125-00001#4 --- add end   ---
   #end add-point
   
   LET g_sfea_m.sfeamodid = g_user
   LET g_sfea_m.sfeamoddt = cl_get_current()
   LET g_sfea_m.sfeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE sfea_t 
      SET (sfeastus,sfeamodid,sfeamoddt) 
        = (g_sfea_m.sfeastus,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt)     
    WHERE sfeaent = g_enterprise AND sfeadocno = g_sfea_m.sfeadocno
 
    
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
         WHEN "S"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
         WHEN "Z"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE asrt340_master_referesh USING g_sfea_m.sfeadocno INTO g_sfea_m.sfeadocno,g_sfea_m.sfeasite, 
          g_sfea_m.sfeadocdt,g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea003,g_sfea_m.sfeastus,g_sfea_m.sfea006, 
          g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaowndp,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid, 
          g_sfea_m.sfeacrtdp,g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfdt, 
          g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,g_sfea_m.sfea002_desc,g_sfea_m.sfea003_desc,g_sfea_m.sfeaownid_desc, 
          g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtid_desc,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid_desc, 
          g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_sfea_m.sfeadocno,g_sfea_m.sfeadocno_desc,g_sfea_m.sfeasite,g_sfea_m.sfeadocdt, 
          g_sfea_m.sfea001,g_sfea_m.sfea002,g_sfea_m.sfea002_desc,g_sfea_m.sfea003,g_sfea_m.sfea003_desc, 
          g_sfea_m.sfeastus,g_sfea_m.sfea006,g_sfea_m.sfea005,g_sfea_m.sfeaownid,g_sfea_m.sfeaownid_desc, 
          g_sfea_m.sfeaowndp,g_sfea_m.sfeaowndp_desc,g_sfea_m.sfeacrtdt,g_sfea_m.sfeacrtid,g_sfea_m.sfeacrtid_desc, 
          g_sfea_m.sfeacrtdp,g_sfea_m.sfeacrtdp_desc,g_sfea_m.sfeamodid,g_sfea_m.sfeamodid_desc,g_sfea_m.sfeamoddt, 
          g_sfea_m.sfeacnfid,g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstid_desc, 
          g_sfea_m.sfeapstdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
         CALL s_transaction_end('Y',0)
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
      
   #end add-point  
 
   CLOSE asrt340_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt340_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt340.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asrt340_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
         
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_inao1_d.getLength() THEN
         LET g_detail_idx = g_inao1_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inao1_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inao1_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_inao_d2.getLength() THEN
         LET g_detail_idx = g_inao_d2.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inao_d2.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inao_d2.getLength() TO FORMONLY.cnt
   END IF
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sfeb_d.getLength() THEN
         LET g_detail_idx = g_sfeb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfeb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfeb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_sfeb3_d.getLength() THEN
         LET g_detail_idx = g_sfeb3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sfeb3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sfeb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
      
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asrt340_b_fill2(pi_idx)
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
   
   CALL asrt340_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asrt340_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
            
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asrt340.status_show" >}
PRIVATE FUNCTION asrt340_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrt340.mask_functions" >}
&include "erp/asr/asrt340_mask.4gl"
 
{</section>}
 
{<section id="asrt340.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION asrt340_send()
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
 
 
   CALL asrt340_show()
   CALL asrt340_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_asrt340_confirm(g_sfea_m.sfeadocno) RETURNING l_success
   IF NOT l_success THEN
      CLOSE asrt340_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_sfea_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sfeb_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_sfeb3_d))
 
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #add-point: 提交前的ADP name="send.before_cli"
   
   #end add-point
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP name="send.after_send"
   #CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_inao_d))    #add 151012
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_inao_d2))   #add 151012      
   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL asrt340_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asrt340_ui_headershow()
   CALL asrt340_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION asrt340_draw_out()
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
   CALL asrt340_ui_headershow()  
   CALL asrt340_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="asrt340.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asrt340_set_pk_array()
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
   LET g_pk_array[1].values = g_sfea_m.sfeadocno
   LET g_pk_array[1].column = 'sfeadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt340.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asrt340.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asrt340_msgcentre_notify(lc_state)
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
   CALL asrt340_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_sfea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt340.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asrt340_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#37-s
   SELECT sfeastus INTO g_sfea_m.sfeastus FROM sfea_t
    WHERE sfeaent = g_enterprise
      AND sfeasite = g_site
      AND sfeadocno = g_sfea_m.sfeadocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_sfea_m.sfeastus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
        WHEN 'Z'
           LET g_errno = 'sub-01351'

     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_sfea_m.sfeadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL asrt340_set_act_visible()
        CALL asrt340_set_act_no_visible()
        CALL asrt340_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#37-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt340.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 按sfeb023的值重置其他相关字段值
# Memo...........:
# Usage..........: CALL asrt340_sfeb023_reference()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014/02/28 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_sfeb023_reference()
   
   #生产料号-BOM特性
   CALL asrt340_set_sfeb023_sfeb024_sfeb025('2')
   #生产料号-产品特征
   CALL asrt340_set_sfeb023_sfeb024_sfeb025('3')       
   #入库类型
   LET g_sfeb_d[l_ac].sfeb003 = '1'
   #料件
   LET g_sfeb_d[l_ac].sfeb004 = g_sfeb_d[l_ac].sfeb023
   #品名/规格
   CALL s_desc_get_item_desc(g_sfeb_d[l_ac].sfeb004)
        RETURNING g_sfeb_d[l_ac].sfeb004_desc,g_sfeb_d[l_ac].sfeb004_desc_desc  
   #其他字段预设     
   CALL asrt340_sfeb004_reference()        
 
END FUNCTION
################################################################################
# Descriptions...: 检查sfeb004的有效性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb004()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      检查通过否标识位
# Date & Author..: 2014-02-28 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb004()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   LET r_success = FALSE
   
   #1.检查料件主档
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb004
   IF NOT cl_chk_exist("v_imaf001_1") THEN
      RETURN r_success
   END IF
   
   #2.检查是否在BOM资料中存在
   CASE g_sfeb_d[l_ac].sfeb003
        WHEN '1' 
                 SELECT COUNT(*) INTO l_cnt FROM bmaa_t
                  WHERE bmaaent  = g_enterprise
                    AND bmaasite = g_sfea_m.sfeasite
                    AND bmaa001  = g_sfeb_d[l_ac].sfeb004
                    AND bmaa002  = g_sfeb_d[l_ac].sfeb024
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 0 THEN
                    #录入的料件不存在于 BOM的主件设定档中
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'asr-00034'
                    LET g_errparam.extend = g_sfeb_d[l_ac].sfeb004
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    RETURN r_success
                 END IF
        WHEN '2' 
                 SELECT COUNT(*) INTO l_cnt FROM bmab_t
                  WHERE bmabent  = g_enterprise
                    AND bmabsite = g_sfea_m.sfeasite
                    AND bmab001  = g_sfeb_d[l_ac].sfeb023
                    AND bmab002  = g_sfeb_d[l_ac].sfeb024
                    AND bmab003  = g_sfeb_d[l_ac].sfeb004
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 0 THEN
                    #录入的料件不存在于 BOM的联产品设定档中
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'asr-00035'
                    LET g_errparam.extend = g_sfeb_d[l_ac].sfeb004
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    RETURN r_success
                 END IF                 
        WHEN '3'
                 SELECT COUNT(*) INTO l_cnt FROM bmac_t
                  WHERE bmacent  = g_enterprise
                    AND bmacsite = g_sfea_m.sfeasite
                    AND bmac001  = g_sfeb_d[l_ac].sfeb023
                    AND bmac002  = g_sfeb_d[l_ac].sfeb024
                    AND bmac003  = g_sfeb_d[l_ac].sfeb004                    
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF  
                 IF l_cnt = 0 THEN
                    #录入的料件不存在于 BOM的副产品设定档中
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'asr-00036'
                    LET g_errparam.extend = g_sfeb_d[l_ac].sfeb004
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    RETURN r_success
                 END IF                  
   END CASE

   #3.检查控制组相关的料件设定
   CALL s_control_check_item(g_sfeb_d[l_ac].sfeb004,'6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 设置sfeb004的默认值
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb004()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2013-12-10 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb004()
   DEFINE l_cnt         LIKE type_t.num5

   LET g_sfeb_d[l_ac].sfeb004 = ''
   
   CASE g_sfeb_d[l_ac].sfeb003
        WHEN '1' LET g_sfeb_d[l_ac].sfeb004 = g_sfeb_d[l_ac].sfeb023
        WHEN '2' 
                 SELECT COUNT(*) INTO l_cnt FROM bmab_t
                  WHERE bmabent  = g_enterprise
                    AND bmabsite = g_sfea_m.sfeasite
                    AND bmab001  = g_sfeb_d[l_ac].sfeb023
                    AND bmab002  = g_sfeb_d[l_ac].sfeb024
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 1 THEN
                    SELECT bmab003 INTO g_sfeb_d[l_ac].sfeb004 FROM bmab_t
                     WHERE bmabent  = g_enterprise
                       AND bmabsite = g_sfea_m.sfeasite
                       AND bmab001  = g_sfeb_d[l_ac].sfeb023
                       AND bmab002  = g_sfeb_d[l_ac].sfeb024
                 END IF
        WHEN '3'
                 SELECT COUNT(*) INTO l_cnt FROM bmac_t
                  WHERE bmacent  = g_enterprise
                    AND bmacsite = g_sfea_m.sfeasite
                    AND bmac001  = g_sfeb_d[l_ac].sfeb023
                    AND bmac002  = g_sfeb_d[l_ac].sfeb024
                 IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                 IF l_cnt = 1 THEN
                    SELECT bmac003 INTO g_sfeb_d[l_ac].sfeb004 FROM bmac_t
                     WHERE bmacent  = g_enterprise
                       AND bmacsite = g_sfea_m.sfeasite
                       AND bmac001  = g_sfeb_d[l_ac].sfeb023
                       AND bmac002  = g_sfeb_d[l_ac].sfeb024
                 END IF        
   END CASE
   
END FUNCTION
################################################################################
# Descriptions...: 设置sfeb005的默认值
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb005()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2013-12-11 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb005()
   DEFINE l_cnt         LIKE type_t.num5
   
   LET g_sfeb_d[l_ac].sfeb005 = ' '
   #sfeb003 = 5.副产品时,不可对sfeb005进行预设- BY SA
   IF g_sfeb_d[l_ac].sfeb003 ='5' THEN
      RETURN 
   END IF
   
   LET g_sfeb_d[l_ac].sfeb005 = g_sfeb_d[l_ac].sfeb025
   
END FUNCTION
################################################################################
# Descriptions...: 单位 sfeb007的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb007()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-06 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb007()
   DEFINE l_imae016         LIKE imae_t.imae016

   LET l_imae016 = ''
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb004) THEN
      SELECT imae016 INTO l_imae016 FROM imae_t
       WHERE imaeent  = g_enterprise
         AND imaesite = g_site
         AND imae001  = g_sfeb_d[l_ac].sfeb004
   END IF

   LET g_sfeb_d[l_ac].sfeb007 = l_imae016
   
END FUNCTION
################################################################################
# Descriptions...: 检查sfeb005的有效性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb005()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      检查通过否标识位
# Date & Author..: 2013-12-11 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb005()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_imaa005     LIKE imaa_t.imaa005
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_errno       LIKE gzze_t.gzze001

   LET r_success = FALSE   
   SELECT imaa005 INTO l_imaa005 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_sfeb_d[l_ac].sfeb004
#   CALL s_aimi092_chk_eigenvalue(l_imaa005,'待确认 ',g_sfeb_d[l_ac].sfeb005)
#        RETURNING l_success,l_errno,g_sfeb_d[l_ac].sfeb005
#   IF NOT l_success THEN
#      CALL cl_err(g_sfeb_d[l_ac].sfeb005,l_errno,1)
#      RETURN r_success
#   END IF

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 检查 单位sfeb007 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb007()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 203-12-12 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb007()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_imaa006      LIKE imaa_t.imaa006
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   
   LET r_success = FALSE
   
   #1.检查单位资料档
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb007
   #160318-00025#17 by 07900 --add-str 
   LET g_errshow = TRUE #是否開窗
   LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
   #160318-00025#17 by 07900 --add-end
   IF NOT cl_chk_exist("v_ooca001") THEN
      RETURN r_success
   END IF   
   
   #2.检查与基础单位是否有转换率
   SELECT imaa006 INTO l_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_sfeb_d[l_ac].sfeb004
   CALL s_aimi190_get_convert(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,l_imaa006)
        RETURNING l_success,l_rate
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   #3.检查与重复性单身档中料件的单位有转换率
#   IF g_sfeb_d[l_ac].sfeb003 MATCHES '[12]' THEN
#      SELECT srab011 INTO l_srab011 FROM srab_t
#       WHERE srabent  = g_enterprise
#         AND srabsite = g_sfea_m.sfeasite
#         AND srab000  = g_srab000
#         AND srab001  = g_sfea_m.sfea006
#         AND srab002  = g_srab002
#         AND srab003  = g_srab003
#         AND srab004  = g_sfeb_d[l_ac].sfeb004

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 仓/储 sfeb013/sfeb014的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_warehouses()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-02-27 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_warehouses()
   DEFINE l_imaf091      LIKE imaf_t.imaf091
   DEFINE l_imaf092      LIKE imaf_t.imaf092
   
   LET l_imaf091 = ''
   LET l_imaf092 = ''
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb004) THEN
      SELECT imaf091,imaf092 INTO l_imaf091,l_imaf092 FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_sfea_m.sfeasite      
         AND imaf001 = g_sfeb_d[l_ac].sfeb004
   END IF

   LET g_sfeb_d[l_ac].sfeb013 = l_imaf091
   LET g_sfeb_d[l_ac].sfeb014 = l_imaf092
END FUNCTION
################################################################################
# Descriptions...: 检查 参考单位sfeb010 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb010()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 203-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb010()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_imaa006      LIKE imaa_t.imaa006
   DEFINE l_imaf015      LIKE imaf_t.imaf015
   DEFINE l_flag         LIKE type_t.chr1   #Y.需参考单位管控  N.不需要参考单位控管
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   
   LET r_success = FALSE
   
   #1.检查料件是否做参考单位的管控
   LET l_imaf015 = NULL
   SELECT imaf015 INTO l_imaf015 FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = g_site
      AND imaf001  = g_sfeb_d[l_ac].sfeb004
   IF cl_null(l_imaf015) THEN
      LET l_flag = 'N'
   ELSE
      LET l_flag = 'Y'
   END IF
   
   #2.检查sfeb010与l_flag是否匹配
   CASE
       WHEN l_flag = 'N' AND NOT cl_null(g_sfeb_d[l_ac].sfeb010)  
            #料件 %1 不做参考单位的管理，不可输入参考单位！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00034'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_sfeb_d[l_ac].sfeb004
            CALL cl_err()

            RETURN r_success
       WHEN l_flag = 'Y' AND cl_null(g_sfeb_d[l_ac].sfeb010)
            #料件 %1 设定做参考单位的管理，参考单位不可为空！
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00035'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_sfeb_d[l_ac].sfeb004
            CALL cl_err()

            RETURN r_success               
   END CASE
   
   #3.检查单位资料档
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb010
   #160318-00025#17 by 07900 --add-str 
   LET g_errshow = TRUE #是否開窗
   LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
   #160318-00025#17 by 07900 --add-end
   IF NOT cl_chk_exist("v_ooca001") THEN
      RETURN r_success
   END IF   
   
   #4.检查与基础单位是否有转换率
   SELECT imaa006 INTO l_imaa006 FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_sfeb_d[l_ac].sfeb004
   CALL s_aimi190_get_convert(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb010,l_imaa006)
        RETURNING l_success,l_rate
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
 
END FUNCTION
################################################################################
# Descriptions...: 参考单位 sfeb010的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb010()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 203-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb010()
   DEFINE l_imaf015      LIKE imaf_t.imaf015
  
   LET l_imaf015 = NULL
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb004) THEN
      SELECT imaf015 INTO l_imaf015 FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = g_sfeb_d[l_ac].sfeb004
   END IF
   LET g_sfeb_d[l_ac].sfeb010 = l_imaf015

END FUNCTION
################################################################################
# Descriptions...: 检查 申请参考数量sfeb011 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb011()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 2013-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb011()
   DEFINE r_success      LIKE type_t.num5

   LET r_success = FALSE
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb011) THEN
      IF g_sfeb_d[l_ac].sfeb011 <= 0 THEN
         RETURN r_success
      END IF
   END IF   

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 参考数量 sfeb011的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb011()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 203-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb011()
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   
   #若没有参考单位时,参考数量DEFAULT NULL
   IF cl_null(g_sfeb_d[l_ac].sfeb010) THEN
      LET g_sfeb_d[l_ac].sfeb011 = NULL
      RETURN
   END IF
   
   LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d[l_ac].sfeb008
   
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb007) AND NOT cl_null(g_sfeb_d[l_ac].sfeb010) THEN
#      CALL s_aimi190_get_convert(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010)
#           RETURNING l_success,l_rate
#      IF NOT l_success THEN
#         LET l_rate = 1
#      END IF   
      CALL s_aooi250_convert_qty(g_sfeb_d[l_ac].sfeb004,g_sfeb_d[l_ac].sfeb007,g_sfeb_d[l_ac].sfeb010,g_sfeb_d[l_ac].sfeb008)
           RETURNING l_success,g_sfeb_d[l_ac].sfeb011
      IF NOT l_success THEN
         LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d[l_ac].sfeb008
      END IF   
   END IF
   
#   LET g_sfeb_d[l_ac].sfeb011 = g_sfeb_d[l_ac].sfeb008 * l_rate
END FUNCTION
################################################################################
# Descriptions...: 插入sfec_t
# Memo...........:
# Usage..........: CALL asrt340_ins_sfec(p_sfeb)
#                  RETURNING r_success
# Input parameter: p_sfeb       sfeb单身资料
# Return code....: r_success    成功否标识符
# Date & Author..: 2014-02-07 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_ins_sfec(p_sfeb)
   DEFINE r_success       LIKE type_t.num5
#   DEFINE l_sfec          RECORD LIKE sfec_t.* #161124-00048#12 mark
   #161124-00048#12 add(s)
   DEFINE l_sfec RECORD  #完工入庫明細檔
       sfecent LIKE sfec_t.sfecent, #企业编号
       sfecsite LIKE sfec_t.sfecsite, #营运据点
       sfecdocno LIKE sfec_t.sfecdocno, #单号
       sfecseq LIKE sfec_t.sfecseq, #项次
       sfecseq1 LIKE sfec_t.sfecseq1, #项次1
       sfec001 LIKE sfec_t.sfec001, #工单单号
       sfec002 LIKE sfec_t.sfec002, #FQC单号
       sfec003 LIKE sfec_t.sfec003, #判定项次
       sfec004 LIKE sfec_t.sfec004, #入库类型
       sfec005 LIKE sfec_t.sfec005, #料件编号
       sfec006 LIKE sfec_t.sfec006, #特征
       sfec007 LIKE sfec_t.sfec007, #包装容器
       sfec008 LIKE sfec_t.sfec008, #单位
       sfec009 LIKE sfec_t.sfec009, #数量
       sfec010 LIKE sfec_t.sfec010, #参考单位
       sfec011 LIKE sfec_t.sfec011, #参考数量
       sfec012 LIKE sfec_t.sfec012, #库位
       sfec013 LIKE sfec_t.sfec013, #储位
       sfec014 LIKE sfec_t.sfec014, #批号
       sfec015 LIKE sfec_t.sfec015, #库存管理特征
       sfec016 LIKE sfec_t.sfec016, #有效日期
       sfec017 LIKE sfec_t.sfec017, #库存备注
       sfec018 LIKE sfec_t.sfec018, #生产料号
       sfec019 LIKE sfec_t.sfec019, #生产料号BOM特性
       sfec020 LIKE sfec_t.sfec020, #生产料号产品特征
       sfec021 LIKE sfec_t.sfec021, #RUN CARD
       sfec022 LIKE sfec_t.sfec022, #项目编号
       sfec023 LIKE sfec_t.sfec023, #WBS
       sfec024 LIKE sfec_t.sfec024, #活动编号
       sfec028 LIKE sfec_t.sfec028  #制造日期
END RECORD
   #161124-00048#12 add(e)
   DEFINE p_sfeb          type_g_sfeb_d  
   
   LET r_success = FALSE
   
   LET l_sfec.sfecent   = g_enterprise             #企業代碼
   LET l_sfec.sfecsite  = g_sfea_m.sfeasite        #營運據點
   LET l_sfec.sfecdocno = g_sfea_m.sfeadocno       #單號
   LET l_sfec.sfecseq   = p_sfeb.sfebseq           #項次
   LET l_sfec.sfecseq1  = 1                        #項次1
   LET l_sfec.sfec001   = ''                       #工單單號
   LET l_sfec.sfec002   = ''                       #FQC單號
   LET l_sfec.sfec003   = ''                       #判定項次
   LET l_sfec.sfec004   = p_sfeb.sfeb003           #入庫類型
   LET l_sfec.sfec005   = p_sfeb.sfeb004           #料件編號
   LET l_sfec.sfec006   = p_sfeb.sfeb005           #特徵
   LET l_sfec.sfec007   = p_sfeb.sfeb006           #包裝容器
   LET l_sfec.sfec008   = p_sfeb.sfeb007           #單位
   LET l_sfec.sfec009   = p_sfeb.sfeb008           #數量
   LET l_sfec.sfec010   = p_sfeb.sfeb010           #參考單位
   LET l_sfec.sfec011   = p_sfeb.sfeb011           #參考數量
   LET l_sfec.sfec012   = p_sfeb.sfeb013           #庫位
   LET l_sfec.sfec013   = p_sfeb.sfeb014           #儲位
   LET l_sfec.sfec014   = p_sfeb.sfeb015           #批號
   LET l_sfec.sfec015   = p_sfeb.sfeb016           #庫存管理特徵
   LET l_sfec.sfec016   = p_sfeb.sfeb021           #有效日期
   LET l_sfec.sfec017   = p_sfeb.sfeb022           #庫存備註
   LET l_sfec.sfec018   = p_sfeb.sfeb023           #生產料號
   LET l_sfec.sfec019   = p_sfeb.sfeb024           #生產料號BOM特性
   LET l_sfec.sfec020   = p_sfeb.sfeb025           #生產料號產品特徵
   
#   INSERT INTO sfec_t VALUES(l_sfec.*)  #161124-00048#12 mark
   #161124-00048#12 add(s)
   INSERT INTO sfec_t(sfecent,sfecsite,sfecdocno,sfecseq,sfecseq1,sfec001,
                      sfec002,sfec003,sfec004,sfec005,sfec006,sfec007,sfec008,
                      sfec009,sfec010,sfec011,sfec012,sfec013,sfec014,sfec015,
                      sfec016,sfec017,sfec018,sfec019,sfec020,sfec021,sfec022,
                      sfec023,sfec024,sfec028)
               VALUES(l_sfec.sfecent,l_sfec.sfecsite,l_sfec.sfecdocno,l_sfec.sfecseq,l_sfec.sfecseq1,l_sfec.sfec001,
                      l_sfec.sfec002,l_sfec.sfec003,l_sfec.sfec004,l_sfec.sfec005,l_sfec.sfec006,l_sfec.sfec007,l_sfec.sfec008,
                      l_sfec.sfec009,l_sfec.sfec010,l_sfec.sfec011,l_sfec.sfec012,l_sfec.sfec013,l_sfec.sfec014,l_sfec.sfec015,
                      l_sfec.sfec016,l_sfec.sfec017,l_sfec.sfec018,l_sfec.sfec019,l_sfec.sfec020,l_sfec.sfec021,l_sfec.sfec022,
                      l_sfec.sfec023,l_sfec.sfec024,l_sfec.sfec028)
   #161124-00048#12 add(e)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert sfec'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 检查 仓库sfeb013/储位sfeb014 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_warehouses()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 203-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_warehouses()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.num5
   DEFINE l_doc_type     LIKE ooba_t.ooba002
   
   LET r_success = FALSE

   #1.检查库存基础档
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb013) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_sfeb_d[l_ac].sfeb013
      #160318-00025#17  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
      #160318-00025#17  by 07900 --add-end
      IF NOT cl_chk_exist("v_inaa001_2") THEN
         RETURN r_success
      END IF
   END IF

   #2.检查储位
   #可以不指定储位,若储位为' '时,不做检查
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb014) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb013
      LET g_chkparam.arg3 = g_sfeb_d[l_ac].sfeb014
      #160318-00025#17 by 07900 --add-str 
      LET g_errshow = TRUE #是否開窗
      LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
       #160318-00025#17 by 07900 --add-end
      IF NOT cl_chk_exist("v_inab002") THEN
         RETURN r_success
      END IF
   END IF

   #3.检查是否通过 单别+仓库+储位 控制组的检查
   IF NOT cl_null(g_sfeb_d[l_ac].sfeb013) THEN
      CALL s_aooi200_get_slip(g_sfea_m.sfeadocno)
           RETURNING l_success,l_doc_type
      CALL s_control_chk_doc('6',l_doc_type,g_sfeb_d[l_ac].sfeb013,g_sfeb_d[l_ac].sfeb014,'','','')
          RETURNING l_success,l_flag
      IF NOT l_success OR NOT l_flag THEN
         RETURN r_success
      END IF
   END IF

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 申请数量 sfeb008的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb008()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-02-07 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb008()
   
   IF cl_null(g_sfeb_d[l_ac].sfeb008) THEN
      LET g_sfeb_d[l_ac].sfeb008 = 0
   END IF

END FUNCTION
################################################################################
# Descriptions...: 生产料号 sfeb023/BOM特性 sfeb024/产品特征 sfeb025的默认值设定
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb023_sfeb024_sfeb025(p_type)
#                  RETURNING NULL
# Input parameter: p_type    默认类型 '1'料件 '2'特性 '3'特征
# Return code....: NULL
# Date & Author..: 2014-02-27 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb023_sfeb024_sfeb025(p_type)
   DEFINE p_type         LIKE type_t.chr1      #1.料件 2.BOM特性 3.产品特征
   DEFINE l_value        LIKE srab_t.srab004   #
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql1         STRING
   DEFINE l_sql2         STRING
   DEFINE l_sql3         STRING

   #default前要看笔数是否只有一笔,若有一笔才能DEFAULT,若多笔,则不DEFAULT
   CASE p_type
        WHEN '1'  LET l_sql1 = "SELECT COUNT(UNIQUE srab004) FROM sraa_t,srab_t"
                  LET l_sql2 = "SELECT UNIQUE srab004 FROM sraa_t,srab_t"
        WHEN '2'  LET l_sql1 = "SELECT COUNT(UNIQUE srab005) FROM sraa_t,srab_t"
                  LET l_sql2 = "SELECT UNIQUE srab005 FROM sraa_t,srab_t"        
        WHEN '3'  LET l_sql1 = "SELECT COUNT(UNIQUE srab006) FROM sraa_t,srab_t"  
                  LET l_sql2 = "SELECT UNIQUE srab006 FROM sraa_t,srab_t"        
   END CASE
   LET l_sql3 = " WHERE sraaent  = srabent  AND sraaent  =  ",g_enterprise,
                "   AND sraasite = srabsite AND sraasite = '",g_sfea_m.sfeasite,"'",
                "   AND sraa000  = srab000  AND sraa000  =  ",g_srab000,                #版本
                "   AND sraa001  = srab001  AND sraa001  = '",g_sfea_m.sfea006,"'",     #生产计划
                "   AND sraa002  = srab002  AND sraa002  =  ",g_srab002,                #年
                "   AND sraa003  = srab003  AND sraa003  =  ",g_srab003                 #月   
   CASE p_type
        WHEN '2'  LET l_sql3 = l_sql3 CLIPPED,
                              "   AND srab004 = '",g_sfeb_d[l_ac].sfeb023,"'"
        WHEN '3'  LET l_sql3 = l_sql3 CLIPPED,
                              "   AND srab004 = '",g_sfeb_d[l_ac].sfeb023,"'",
                              "   AND srab005 = '",g_sfeb_d[l_ac].sfeb024,"'"
   END CASE
   
   LET l_sql1 = l_sql1 CLIPPED,l_sql3 CLIPPED
   PREPARE asrt340_set_sfeb023_sfeb024_sfeb025_p1 FROM l_sql1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asrt340_set_sfeb023_sfeb024_sfeb025_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   
   EXECUTE asrt340_set_sfeb023_sfeb024_sfeb025_p1 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'execute asrt340_set_sfeb023_sfeb024_sfeb025_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
   
   #仅一笔资料时要做预设
   IF l_cnt = 1 THEN
      LET l_sql2 = l_sql2 CLIPPED,l_sql3 CLIPPED
      PREPARE asrt340_set_sfeb023_sfeb024_sfeb025_p2 FROM l_sql2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'prepare asrt340_set_sfeb023_sfeb024_sfeb025_p2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
      
      EXECUTE asrt340_set_sfeb023_sfeb024_sfeb025_p2 INTO l_value
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'execute asrt340_set_sfeb023_sfeb024_sfeb025_p2'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
            
      CASE p_type
          WHEN '1'  LET g_sfeb_d[l_ac].sfeb023 = l_value
          WHEN '2'  LET g_sfeb_d[l_ac].sfeb024 = l_value          
          WHEN '3'  LET g_sfeb_d[l_ac].sfeb025 = l_value
      END CASE
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 设置sfea006的默认值
# Memo...........:
# Usage..........: CALL asrt340_set_sfea006()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-02-27 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfea006()
   DEFINE l_srza001      LIKE srza_t.srza001
   DEFINE l_cnt          LIKE type_t.num5
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM srza_t
    WHERE srzaent  = g_enterprise
      AND srzastus = 'Y'
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt = 1 THEN
      SELECT srza001 INTO l_srza001 FROM srza_t
       WHERE srzaent  = g_enterprise
         AND srzastus = 'Y'    
      LET g_sfea_m.sfea006 = l_srza001         
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 检查 生产料号 sfeb023/BOM特性 sfeb024/产品特征 sfeb025 是否与asrt300一致
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb023_sfeb024_sfeb025()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-02-28 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb023_sfeb024_sfeb025()
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_sql          STRING
   DEFINE l_str          STRING
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5

   LET r_success = TRUE
   #若料件不存在,则不需要做检查
   IF cl_null(g_sfeb_d[l_ac].sfeb023) THEN
      RETURN r_success
   END IF
   
   LET r_success = FALSE
   
   LET l_sql = "SELECT COUNT(*) FROM sraa_t,srab_t ",
               " WHERE sraaent  = srabent  AND sraaent  =  ",g_enterprise,
               "   AND sraasite = srabsite AND sraasite = '",g_sfea_m.sfeasite,"'",
               "   AND sraa000  = srab000  AND sraa000  =  ",g_srab000,                #版本
               "   AND sraa001  = srab001  AND sraa001  = '",g_sfea_m.sfea006,"'",     #生产计划
               "   AND sraa002  = srab002  AND sraa002  =  ",g_srab002,                #年
               "   AND sraa003  = srab003  AND sraa003  =  ",g_srab003,                #月 
               "   AND srab004 = '",g_sfeb_d[l_ac].sfeb023,"'"                  #料件
   IF g_sfeb_d[l_ac].sfeb024 IS NOT NULL THEN
      LET l_sql = l_sql CLIPPED,
                  "   AND srab005 = '",g_sfeb_d[l_ac].sfeb024,"'"               #料件-BOM属性      
   END IF
   IF g_sfeb_d[l_ac].sfeb025 IS NOT NULL THEN
      LET l_sql = l_sql CLIPPED,
                  "   AND srab006 = '",g_sfeb_d[l_ac].sfeb025,"'"               #料件-产品特征      
   END IF   

   PREPARE asrt340_chk_sfeb023_sfeb024_sfeb025_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asrt340_chk_sfeb023_sfeb024_sfeb025_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   EXECUTE asrt340_chk_sfeb023_sfeb024_sfeb025_p1 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'execute asrt340_chk_sfeb023_sfeb024_sfeb025_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF   
   
   #不存在"重复性生产计划单身档"
   IF l_cnt = 0 THEN
      #录入的资料不存在于 最新的重复性生产计划中
      LET l_str = g_sfeb_d[l_ac].sfeb023,'/',g_sfeb_d[l_ac].sfeb024,'/',g_sfeb_d[l_ac].sfeb025
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00033'
      LET g_errparam.extend = l_str
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #检查生产料号 + BOM特性在BOM维护档中是否存在
   IF g_sfeb_d[l_ac].sfeb024 IS NOT NULL THEN 
      SELECT COUNT(*) INTO l_cnt FROM bmaa_t
       WHERE bmaaent  = g_enterprise
         AND bmaasite = g_sfea_m.sfeasite
         AND bmaa001  = g_sfeb_d[l_ac].sfeb023
         AND bmaa002  = g_sfeb_d[l_ac].sfeb024
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         #录入的料件不存在于 BOM的主件设定档中
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00034'
         LET g_errparam.extend = g_sfeb_d[l_ac].sfeb023
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF   
   END IF
   
   #检查控制组相关的料件设定
   CALL s_control_check_item(g_sfeb_d[l_ac].sfeb023,'6',g_sfea_m.sfeasite,g_user,g_dept,g_sfea_m.sfeadocno)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION
################################################################################
# Descriptions...: 按sfeb004的值重置其他相关字段值
# Memo...........:
# Usage..........: CALL asrt340_sfeb004_reference()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014/02/28 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_sfeb004_reference()
   #产品特征
   CALL asrt340_set_sfeb005()
   #库存特征
   LET g_sfeb_d[l_ac].sfeb016 = ' '   
   #入库单位
   CALL asrt340_set_sfeb007()
   LET g_sfeb_d[l_ac].sfeb008 = 0
   LET g_sfeb_d[l_ac].sfeb009 = 0
   LET g_sfeb_d[l_ac].sfeb027 = 0
   #参考单位
   CALL asrt340_set_sfeb010()
   LET g_sfeb_d[l_ac].sfeb011 = 0
   LET g_sfeb_d[l_ac].sfeb012 = 0   
   #仓/储
   CALL asrt340_set_warehouses()  
   
END FUNCTION
################################################################################
# Descriptions...: 取得重复性生产的版本号
# Memo...........:
# Usage..........: CALL asrt340_get_srab000()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-06 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_get_srab000()
   
   LET g_srab002 = YEAR(g_sfea_m.sfeadocdt)
   LET g_srab003 = MONTH(g_sfea_m.sfeadocdt)
   
   #取出目前"已确认"的最大版本号
   SELECT MAX(sraa000) INTO g_srab000 FROM sraa_t
    WHERE sraaent  = g_enterprise
      AND sraasite = g_sfea_m.sfeasite
      AND sraa001  = g_sfea_m.sfea006
      AND sraa002  = g_srab002
      AND sraa003  = g_srab003
      AND sraastus = 'Y'   
   
END FUNCTION
################################################################################
# Descriptions...: 检查 重复性生产版本sfea006 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfea006()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 2014-03-06 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfea006()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_srab000      LIKE srab_t.srab000   #版本   
   DEFINE l_srab001      LIKE srab_t.srab001   #生产计划
   DEFINE l_srab002      LIKE srab_t.srab002   #年
   DEFINE l_srab003      LIKE srab_t.srab003   #月
   
   LET r_success = FALSE
   
   #检查重复性生产版本档
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_sfea_m.sfea006
   #160318-00025#17 by 07900 --add-str 
   LET g_errshow = TRUE #是否開窗
   LET g_chkparam.err_str[1] ="asr-00014:sub-01302|asri001|",cl_get_progname("asri001",g_lang,"2"),"|:EXEPROGasri001"
   #160318-00025#17 by 07900 --add-end
   IF NOT cl_chk_exist("v_srza001") THEN
      RETURN r_success
   END IF   

   #检查重复性生产计划档
   LET l_srab001 = g_sfea_m.sfea006
   LET l_srab002 = YEAR(g_sfea_m.sfeadocdt)
   LET l_srab003 = MONTH(g_sfea_m.sfeadocdt)

   #取出目前"已确认"的最大版本号
   SELECT MAX(sraa000) INTO l_srab000 FROM sraa_t
    WHERE sraaent  = g_enterprise
      AND sraasite = g_sfea_m.sfeasite
      AND sraa001  = l_srab001
      AND sraa002  = l_srab002
      AND sraa003  = l_srab003
      AND sraastus = 'Y'
   IF cl_null(l_srab000) OR SQLCA.sqlcode THEN
      #录入的版本不存在于最新的重复性生产计划中 或 录入的版本不为最新的有效生产计划
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asr-00037'
      LET g_errparam.extend = g_sfea_m.sfea006
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 产品特征录入及处理
# Memo...........:
# Usage..........: CALL asrt340_feature(p_cmd)
#                  RETURNING NULL
# Input parameter: p_cmd     标识符
# Return code....: NULL
# Date & Author..: 2014-03-17 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_feature(p_cmd)
   DEFINE p_cmd          LIKE type_t.chr1
   DEFINE l_success      LIKE type_t.num5
   
   IF cl_null(g_sfeb_d[l_ac].sfeb004) THEN
      RETURN
   END IF
   
   IF cl_null(p_cmd) OR p_cmd <> 'a' THEN
      RETURN
   END IF
   
   IF g_sfeb_d[l_ac].sfeb003 = '5' THEN
      RETURN
   END IF
   
   CALL g_inam.clear()
   
   CALL s_feature(p_cmd,g_sfeb_d[l_ac].sfeb004,'','',g_sfea_m.sfeasite,g_sfea_m.sfeadocno) 
        RETURNING l_success,g_inam
   IF NOT l_success THEN
      RETURN
   END IF
   
   IF g_inam.getLength() >= 1 THEN
      LET g_sfeb_d[l_ac].sfeb005 = g_inam[1].inam002
      LET g_sfeb_d[l_ac].sfeb008 = g_inam[1].inam004
   END IF

   
END FUNCTION
################################################################################
# Descriptions...: 检查 申请数量sfeb008 值的合法性
# Memo...........:
# Usage..........: CALL asrt340_chk_sfeb008()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success 检查通过否标识位
# Date & Author..: 2013-12-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_chk_sfeb008()
   DEFINE r_success      LIKE type_t.num5

   LET r_success = FALSE
   IF cl_null(g_sfeb_d[l_ac].sfeb008) THEN
      RETURN r_success
   END IF
   IF g_sfeb_d[l_ac].sfeb008 <= 0 THEN
      RETURN r_success
   END IF   

   LET r_success = TRUE
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 处理多笔特征值的INSERT
# Memo...........:
# Usage..........: CALL asrt340_feature_insert(p_cmd)
#                  RETURNING r_success
# Input parameter: p_cmd     标识符
# Return code....: r_success 成功否标识符
# Date & Author..: 2014-03-17 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_feature_insert(p_cmd)
   DEFINE p_cmd          LIKE type_t.chr1
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_sfeb         type_g_sfeb_d  

   
   LET r_success = FALSE

   IF g_inam.getLength() <= 1 THEN
      LET r_success = TRUE
      RETURN r_success   
   END IF
   
   LET l_cnt = g_inam.getLength()
   INITIALIZE l_sfeb.* TO NULL
   LET l_sfeb.* = g_sfeb_d[l_ac].*
   
   FOR l_i = 2 TO l_cnt
       IF g_inam[l_i].inam002 IS NULL THEN
          CONTINUE FOR
       END IF

       IF g_inam[l_i].inam004 <=0  THEN
          CONTINUE FOR
       END IF
       
       SELECT MAX(sfebseq) + 1 INTO l_sfeb.sfebseq FROM sfeb_t
        WHERE sfebent = g_enterprise
          AND sfebdocno = g_sfea_m.sfeadocno
       IF cl_null(l_sfeb.sfebseq) THEN
          LET l_sfeb.sfebseq = 1
       END IF   
       
       LET l_sfeb.sfeb005 = g_inam[l_i].inam002
       LET l_sfeb.sfeb008 = g_inam[l_i].inam004
       
       INSERT INTO sfeb_t(sfebent,sfebdocno,sfebseq,sfeb023,sfeb024,sfeb025,sfeb002,sfeb003,
                          sfeb004,sfeb005,sfeb006,sfeb007,sfeb008,sfeb027,sfeb009,sfeb010,sfeb011,
                          sfeb012,sfeb013,sfeb014,sfeb015,sfeb016,sfeb020,sfeb021,sfeb022,sfebsite) 
                   VALUES(g_enterprise,g_sfea_m.sfeadocno,l_sfeb.sfebseq,
                          l_sfeb.sfeb023,l_sfeb.sfeb024,l_sfeb.sfeb025,l_sfeb.sfeb002,l_sfeb.sfeb003,
                          l_sfeb.sfeb004,l_sfeb.sfeb005,l_sfeb.sfeb006,l_sfeb.sfeb007,l_sfeb.sfeb008,
                          l_sfeb.sfeb027,
                          l_sfeb.sfeb009,l_sfeb.sfeb010,l_sfeb.sfeb011,l_sfeb.sfeb012,l_sfeb.sfeb013, 
                          l_sfeb.sfeb014,l_sfeb.sfeb015,l_sfeb.sfeb016,l_sfeb.sfeb020,l_sfeb.sfeb021,
                          l_sfeb.sfeb022,l_sfeb.sfebsite) 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert sfeb_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF

       #当申数据不需FQC时，新增申请数据后，自动写一笔数据到入库明细
       IF l_sfeb.sfeb002 = 'N' THEN
          CALL asrt340_ins_sfec(g_sfeb_d[l_ac].*)
               RETURNING l_success
          IF NOT l_success THEN
             RETURN r_success       
          END IF
       END IF

       #单身备注
       IF NOT cl_null(l_sfeb.ooff013) THEN
          CALL s_aooi360_gen('7',g_sfea_m.sfeadocno,l_sfeb.sfebseq,' ',' ',' ',' ',' ',' ',' ',' ','4',l_sfeb.ooff013)
               RETURNING l_success
       END IF    
       
   END FOR
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 设置sfeb002的默认值
# Memo...........:
# Usage..........: CALL asrt340_set_sfeb002()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-03-17 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_set_sfeb002()
   DEFINE l_sfeb002     LIKE sfeb_t.sfeb002

   #FQC否
   SELECT srza005 INTO l_sfeb002
     FROM srza_t
    WHERE srzaent  = g_enterprise
      AND srzasite = g_sfea_m.sfeasite
      AND srza001  = g_sfea_m.sfea006
   IF cl_null(l_sfeb002) THEN
      LET l_sfeb002 = 'N'
   END IF

   #5.副产品/回收料
   IF g_sfeb_d[l_ac].sfeb003 = '5' THEN
      LET l_sfeb002 = 'N'
   END IF  
   
   LET g_sfeb_d[l_ac].sfeb002 = l_sfeb002
   
END FUNCTION

################################################################################
# Descriptions...: 检查理由码
# Memo...........:
# Usage..........: CALL asft340_chk_sfeb020()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success      成功否标识符
# Modify.........: 2014-06-20 By Carrier
################################################################################
PRIVATE FUNCTION asft340_chk_sfeb020()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.num5

   LET r_success = FALSE

   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = '225'
   LET g_chkparam.arg2 = g_sfeb_d[l_ac].sfeb020
   #160318-00025#17 by 07900 --add-str 
   LET g_errshow = TRUE #是否開窗
   LET g_chkparam.err_str[1] ="aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
   #160318-00025#17 by 07900 --add-end
   IF NOT cl_chk_exist("v_oocq002_1") THEN
      RETURN r_success
   END IF

   CALL s_control_chk_doc('8',g_sfea_m.sfeadocno,g_sfeb_d[l_ac].sfeb020,'','','','')
        RETURNING l_success,l_flag
   IF NOT l_success THEN
      RETURN r_success
   ELSE
      IF NOT l_flag THEN
         RETURN r_success
      END IF
   END IF

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 取aooi200中BY单据别设定的栏位预设值
# Memo...........:
# Usage..........: CALL asft340_get_doc_default()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-06-20 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asft340_get_doc_default()
   LET g_sfea_m.sfeadocdt  = s_aooi200_get_doc_default(g_site,'1',g_sfea_m.sfeadocno,'sfeadocdt',g_sfea_m.sfeadocdt)     #單據日期
   LET g_sfea_m.sfea001    = s_aooi200_get_doc_default(g_site,'1',g_sfea_m.sfeadocno,'sfea001'  ,g_sfea_m.sfea001  )     #過帳日期
   LET g_sfea_m.sfea002    = s_aooi200_get_doc_default(g_site,'1',g_sfea_m.sfeadocno,'sfea002'  ,g_sfea_m.sfea002  )     #申請人
   LET g_sfea_m.sfea003    = s_aooi200_get_doc_default(g_site,'1',g_sfea_m.sfeadocno,'sfea003'  ,g_sfea_m.sfea003  )     #部門
   LET g_sfea_m.sfea006    = s_aooi200_get_doc_default(g_site,'1',g_sfea_m.sfeadocno,'sfea006'  ,g_sfea_m.sfea006  )     #PBI編號

   DISPLAY BY NAME g_sfea_m.sfeadocdt
   DISPLAY BY NAME g_sfea_m.sfea001
   DISPLAY BY NAME g_sfea_m.sfea002
   DISPLAY BY NAME g_sfea_m.sfea003
   DISPLAY BY NAME g_sfea_m.sfea006

END FUNCTION

################################################################################
# Descriptions...: 各ACTION结束后,状态图片立即切换
# Memo...........:
# Usage..........: CALL asrt340_show_status()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-12-18 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION asrt340_show_status()
   DEFINE l_sfeastus         LIKE sfea_t.sfeastus
   
   SELECT sfeastus INTO l_sfeastus FROM sfea_t
    WHERE sfeaent   = g_enterprise
      AND sfeadocno = g_sfea_m.sfeadocno
      
   CASE l_sfeastus
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
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "S"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/posted.png")
      WHEN "Z"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unposted.png")
      
   END CASE
   LET g_sfea_m.sfeastus = l_sfeastus
   DISPLAY BY NAME g_sfea_m.sfeastus      
   
   SELECT sfeamodid,sfeamoddt,sfeacnfid,sfeacnfdt,sfeapstid,sfeapstdt
     INTO g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,
          g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt
     FROM sfea_t
    WHERE sfeaent   = g_enterprise
      AND sfeadocno = g_sfea_m.sfeadocno   
      
   IF NOT cl_null(g_sfea_m.sfeamodid) THEN
      LET g_sfea_m.sfeamodid_desc = cl_get_username(g_sfea_m.sfeamodid)
   ELSE
      LET g_sfea_m.sfeamodid_desc = ''
   END IF
   
   IF NOT cl_null(g_sfea_m.sfeacnfid) THEN
      LET g_sfea_m.sfeacnfid_desc = cl_get_username(g_sfea_m.sfeacnfid)
   ELSE
      LET g_sfea_m.sfeacnfid_desc = ''   
   END IF
   
   IF NOT cl_null(g_sfea_m.sfeapstid) THEN
      LET g_sfea_m.sfeapstid_desc = cl_get_username(g_sfea_m.sfeapstid)
   ELSE
      LET g_sfea_m.sfeapstid_desc = ''
   END IF
      
   DISPLAY BY NAME g_sfea_m.sfeamodid,g_sfea_m.sfeamoddt,g_sfea_m.sfeacnfid,
                   g_sfea_m.sfeacnfdt,g_sfea_m.sfeapstid,g_sfea_m.sfeapstdt,
                   g_sfea_m.sfeamodid_desc,g_sfea_m.sfeacnfid_desc,g_sfea_m.sfeapstid_desc
END FUNCTION

################################################################################
#新增制造批序号异动资料
################################################################################
PRIVATE FUNCTION asrt340_ins_inao()
DEFINE  l_sql       STRING
#DEFINE  l_inao      RECORD LIKE inao_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_inao RECORD  #製造批序號庫存異動明細檔
       inaoent LIKE inao_t.inaoent, #企业编号
       inaosite LIKE inao_t.inaosite, #营运据点
       inaodocno LIKE inao_t.inaodocno, #单号
       inaoseq LIKE inao_t.inaoseq, #项次
       inaoseq1 LIKE inao_t.inaoseq1, #项序
       inaoseq2 LIKE inao_t.inaoseq2, #序号
       inao000 LIKE inao_t.inao000, #数据类型
       inao001 LIKE inao_t.inao001, #料件编号
       inao002 LIKE inao_t.inao002, #产品特征
       inao003 LIKE inao_t.inao003, #库存管理特征
       inao004 LIKE inao_t.inao004, #包装容器编号
       inao005 LIKE inao_t.inao005, #库位
       inao006 LIKE inao_t.inao006, #储位
       inao007 LIKE inao_t.inao007, #批号
       inao008 LIKE inao_t.inao008, #制造批号
       inao009 LIKE inao_t.inao009, #制造序号
       inao010 LIKE inao_t.inao010, #制造日期
       inao011 LIKE inao_t.inao011, #有效日期
       inao012 LIKE inao_t.inao012, #数量
       inao013 LIKE inao_t.inao013, #出入库码
       inao014 LIKE inao_t.inao014, #库存单位
       inao020 LIKE inao_t.inao020, #检验合格量
       inao021 LIKE inao_t.inao021, #已入库/出货/签收量
       inao022 LIKE inao_t.inao022, #已验退/签退量
       inao023 LIKE inao_t.inao023, #已仓退/销退量
       inao024 LIKE inao_t.inao024, #已转QC量
       inao025 LIKE inao_t.inao025  #已退品量
END RECORD
#161124-00048#12 add(e)
DEFINE  r_success   LIKE type_t.num5

   #先刪除實際資料
   DELETE FROM inao_t
    WHERE inaodocno = g_sfea_m.sfeadocno
      AND inaosite = g_site
      AND inaoseq = g_sfeb_d[g_detail_idx].sfebseq
      AND inao000 = '2'
      AND inaoent = g_enterprise #160905-00007#15 by 08172

   LET l_sql = "SELECT * FROM inao_t ",
               " WHERE inaodocno = '",g_sfea_m.sfeadocno,"'",
               "   AND inaoseq = ",g_sfeb_d[g_detail_idx].sfebseq,
               "   AND inao000 = '1' "

   PREPARE asrt340_inao_pre FROM l_sql
   DECLARE asrt340_inao_ins CURSOR FOR asrt340_inao_pre

   LET r_success = TRUE
   FOREACH asrt340_inao_ins INTO l_inao.*
      LET l_inao.inao000 = '2'
      LET l_inao.inaoseq1 = 1
      INSERT INTO inao_t (inaoent,inaosite,inaodocno,inaoseq,inaoseq1,inaoseq2,inao000,inao001,inao002,inao003,inao004,inao005,inao006,
                          inao007,inao008,inao009,inao010,inao011,inao012,inao013,inao014,inao020,inao021,inao022,inao023,inao024)
                  VALUES (g_enterprise,g_site,l_inao.inaodocno,l_inao.inaoseq,l_inao.inaoseq1,l_inao.inaoseq2,l_inao.inao000,
                          l_inao.inao001,l_inao.inao002,l_inao.inao003,l_inao.inao004,l_inao.inao005,l_inao.inao006,l_inao.inao007,l_inao.inao008,
                          l_inao.inao009,l_inao.inao010,l_inao.inao011,l_inao.inao012,l_inao.inao013,l_inao.inao014,l_inao.inao020,l_inao.inao021,
                          l_inao.inao022,l_inao.inao023,l_inao.inao024)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "inao_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END FOREACH
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 实际制造批序号
# Memo...........:
# Usage..........: CALL asrt340_inao_fill()
# Date & Author..: 2016/01/21 By xianghui
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt340_inao_fill()
DEFINE l_sql  STRING
DEFINE l_cnt  LIKE type_t.num5


   CALL g_inao_d2.clear()
 
   LET g_sql = "SELECT UNIQUE inaoseq,inaoseq1,inaoseq2,inao001,imaal003,imaal004,inao008,inao009,inao010,inao012 FROM inao_t",   
               "  LEFT JOIN imaal_t ON imaalent = inaoent AND imaal001 = inao001 AND imaal002 = '",g_dlang,"'",
               " WHERE inaoent='",g_enterprise,"' ",
               "   AND inaosite='",g_site,"'",
               "   AND inaodocno='",g_sfea_m.sfeadocno,"' AND inao000 = '2'", 
               " ORDER BY inao_t.inaoseq,inao_t.inaoseq1,inao_t.inaoseq2"
   PREPARE asrt340_pb4 FROM g_sql
   DECLARE b_fill_cs4 CURSOR FOR asrt340_pb4
   LET l_cnt = 1                                         
   FOREACH b_fill_cs4 INTO g_inao_d2[l_cnt].inaoseq,g_inao_d2[l_cnt].inaoseq1,g_inao_d2[l_cnt].inaoseq2,
                           g_inao_d2[l_cnt].inao001,g_inao_d2[l_cnt].inao001_desc1,g_inao_d2[l_cnt].inao001_desc2,
                           g_inao_d2[l_cnt].inao008,g_inao_d2[l_cnt].inao009,
                           g_inao_d2[l_cnt].inao010,g_inao_d2[l_cnt].inao012
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
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_inao_d2.deleteElement(l_cnt)
   
   FREE asrt340_pb4
END FUNCTION

 
{</section>}
 
