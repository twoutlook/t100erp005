#該程式未解開Section, 採用最新樣板產出!
{<section id="astt802.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2016-08-10 16:05:21), PR版次:0014(2017-02-06 09:13:07)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: astt802
#+ Description: 招商租賃合約費用優惠申請
#+ Creator....: 08172(2016-04-08 09:11:16)
#+ Modifier...: 08172 -SD/PR- 07556
 
{</section>}
 
{<section id="astt802.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160421-00013#7   2016/04/22   by 08172     金额和面积的截位以及显示
#160324-00008#16  2016/05/06   by 08172     合同开窗和检查修改
#160512-00003#24  2016/06/06   by 08172     优惠面积调整
#160810-00030#1   2016/08/10   by 08172     优惠计算调整
#add by geza 20160815 #160815-00001#1  #计算优惠金额用费用单身的确认金额 
#160816-00068#1   2016/08/18   By earl      調整transaction
#160818-00017#41  2016-08-23   By 08734     删除修改未重新判断状态码
#160913-00034#4   2016/09/14   by 08172     q_pmaa001開窗修改
#170105-00005#1   2017/01/05   by 08172     单据无法删除
#170109-00031#1   2017/01/09   by 08172     单身无法录入资料；优惠金额计算为空的是时候应该给0
#170203-00024#5   2017/02/06   by Jessica   「抽單、已拒絕」修改後狀態未變'N.未確認'
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
PRIVATE type type_g_stem_m        RECORD
       stemsite LIKE stem_t.stemsite, 
   stemsite_desc LIKE type_t.chr80, 
   stemdocdt LIKE stem_t.stemdocdt, 
   stemdocno LIKE stem_t.stemdocno, 
   stem001 LIKE stem_t.stem001, 
   stem016 LIKE type_t.chr10, 
   stem002 LIKE stem_t.stem002, 
   stem002_desc LIKE type_t.chr80, 
   stem003 LIKE stem_t.stem003, 
   stem003_desc LIKE type_t.chr80, 
   stem005 LIKE stem_t.stem005, 
   stem005_desc LIKE type_t.chr80, 
   stem004 LIKE type_t.chr10, 
   stem004_desc LIKE type_t.chr80, 
   stem006 LIKE stem_t.stem006, 
   stem017 LIKE stem_t.stem017, 
   stem007 LIKE stem_t.stem007, 
   stem009 LIKE stem_t.stem009, 
   stem010 LIKE stem_t.stem010, 
   stem011 LIKE stem_t.stem011, 
   stem018 LIKE stem_t.stem018, 
   stem000 LIKE type_t.chr20, 
   stem012 LIKE stem_t.stem012, 
   stem012_desc LIKE type_t.chr80, 
   stem013 LIKE stem_t.stem013, 
   stem013_desc LIKE type_t.chr80, 
   stem034 LIKE type_t.chr500, 
   stemstus LIKE stem_t.stemstus, 
   stemownid LIKE stem_t.stemownid, 
   stemownid_desc LIKE type_t.chr80, 
   stemowndp LIKE stem_t.stemowndp, 
   stemowndp_desc LIKE type_t.chr80, 
   stemcrtid LIKE stem_t.stemcrtid, 
   stemcrtid_desc LIKE type_t.chr80, 
   stemcrtdp LIKE stem_t.stemcrtdp, 
   stemcrtdp_desc LIKE type_t.chr80, 
   stemcrtdt LIKE stem_t.stemcrtdt, 
   stemmodid LIKE stem_t.stemmodid, 
   stemmodid_desc LIKE type_t.chr80, 
   stemmoddt LIKE stem_t.stemmoddt, 
   stemcnfid LIKE stem_t.stemcnfid, 
   stemcnfid_desc LIKE type_t.chr80, 
   stemcnfdt LIKE stem_t.stemcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_sten_d        RECORD
       stenacti LIKE sten_t.stenacti, 
   stenseq LIKE sten_t.stenseq, 
   sten001 LIKE sten_t.sten001, 
   sten002 LIKE sten_t.sten002, 
   sten002_desc LIKE type_t.chr500, 
   sten003 LIKE sten_t.sten003, 
   sten004 LIKE sten_t.sten004, 
   sten007 LIKE sten_t.sten007, 
   sten012 LIKE sten_t.sten012, 
   sten005 LIKE sten_t.sten005, 
   sten009 LIKE sten_t.sten009, 
   sten009_desc LIKE type_t.chr500, 
   sten011 LIKE sten_t.sten011
       END RECORD
PRIVATE TYPE type_g_sten2_d RECORD
       steoseq LIKE steo_t.steoseq, 
   steo001 LIKE steo_t.steo001, 
   steo002 LIKE steo_t.steo002, 
   steo003 LIKE steo_t.steo003, 
   steo003_desc LIKE type_t.chr500, 
   steo004 LIKE steo_t.steo004, 
   steo005 LIKE steo_t.steo005, 
   steo006 LIKE steo_t.steo006, 
   steo007 LIKE steo_t.steo007, 
   steo007_desc LIKE type_t.chr500, 
   steo008 LIKE steo_t.steo008, 
   steo009 LIKE steo_t.steo009
       END RECORD
PRIVATE TYPE type_g_sten3_d RECORD
       stepseq LIKE step_t.stepseq, 
   step001 LIKE step_t.step001, 
   step001_desc LIKE type_t.chr500, 
   step002 LIKE step_t.step002, 
   step002_desc LIKE type_t.chr500, 
   step003 LIKE step_t.step003, 
   step004 LIKE step_t.step004, 
   step005 LIKE step_t.step005, 
   step006 LIKE step_t.step006, 
   step007 LIKE step_t.step007, 
   step007_desc LIKE type_t.chr500, 
   step008 LIKE step_t.step008
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_stemsite LIKE stem_t.stemsite,
   b_stemsite_desc LIKE type_t.chr80,
      b_stemdocdt LIKE stem_t.stemdocdt,
      b_stemdocno LIKE stem_t.stemdocno,
      b_stem001 LIKE stem_t.stem001,
      b_stem002 LIKE stem_t.stem002,
   b_stem002_desc LIKE type_t.chr80,
      b_stem003 LIKE stem_t.stem003,
   b_stem003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_site_flag           LIKE type_t.num5
#end add-point
       
#模組變數(Module Variables)
DEFINE g_stem_m          type_g_stem_m
DEFINE g_stem_m_t        type_g_stem_m
DEFINE g_stem_m_o        type_g_stem_m
DEFINE g_stem_m_mask_o   type_g_stem_m #轉換遮罩前資料
DEFINE g_stem_m_mask_n   type_g_stem_m #轉換遮罩後資料
 
   DEFINE g_stemdocno_t LIKE stem_t.stemdocno
 
 
DEFINE g_sten_d          DYNAMIC ARRAY OF type_g_sten_d
DEFINE g_sten_d_t        type_g_sten_d
DEFINE g_sten_d_o        type_g_sten_d
DEFINE g_sten_d_mask_o   DYNAMIC ARRAY OF type_g_sten_d #轉換遮罩前資料
DEFINE g_sten_d_mask_n   DYNAMIC ARRAY OF type_g_sten_d #轉換遮罩後資料
DEFINE g_sten2_d          DYNAMIC ARRAY OF type_g_sten2_d
DEFINE g_sten2_d_t        type_g_sten2_d
DEFINE g_sten2_d_o        type_g_sten2_d
DEFINE g_sten2_d_mask_o   DYNAMIC ARRAY OF type_g_sten2_d #轉換遮罩前資料
DEFINE g_sten2_d_mask_n   DYNAMIC ARRAY OF type_g_sten2_d #轉換遮罩後資料
DEFINE g_sten3_d          DYNAMIC ARRAY OF type_g_sten3_d
DEFINE g_sten3_d_t        type_g_sten3_d
DEFINE g_sten3_d_o        type_g_sten3_d
DEFINE g_sten3_d_mask_o   DYNAMIC ARRAY OF type_g_sten3_d #轉換遮罩前資料
DEFINE g_sten3_d_mask_n   DYNAMIC ARRAY OF type_g_sten3_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
 
 
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
 
{<section id="astt802.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT stemsite,'',stemdocdt,stemdocno,stem001,'',stem002,'',stem003,'',stem005, 
       '','','',stem006,stem017,stem007,stem009,stem010,stem011,stem018,'',stem012,'',stem013,'','', 
       stemstus,stemownid,'',stemowndp,'',stemcrtid,'',stemcrtdp,'',stemcrtdt,stemmodid,'',stemmoddt, 
       stemcnfid,'',stemcnfdt", 
                      " FROM stem_t",
                      " WHERE stement= ? AND stemdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt802_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.stemsite,t0.stemdocdt,t0.stemdocno,t0.stem001,t0.stem016,t0.stem002, 
       t0.stem003,t0.stem005,t0.stem004,t0.stem006,t0.stem017,t0.stem007,t0.stem009,t0.stem010,t0.stem011, 
       t0.stem018,t0.stem000,t0.stem012,t0.stem013,t0.stem034,t0.stemstus,t0.stemownid,t0.stemowndp, 
       t0.stemcrtid,t0.stemcrtdp,t0.stemcrtdt,t0.stemmodid,t0.stemmoddt,t0.stemcnfid,t0.stemcnfdt,t1.ooefl003 , 
       t2.mhbel003 ,t3.pmaal004 ,t4.rtaxl003 ,t5.oocql004 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooag011",
               " FROM stem_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stemsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t2 ON t2.mhbelent="||g_enterprise||" AND t2.mhbel001=t0.stem002 AND t2.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stem003 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t4 ON t4.rtaxlent="||g_enterprise||" AND t4.rtaxl001=t0.stem005 AND t4.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='2002' AND t5.oocql002=t0.stem004 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.stem012  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.stem013 AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.stemownid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.stemowndp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.stemcrtid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.stemcrtdp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.stemmodid  ",
               " LEFT JOIN ooag_t t13 ON t13.ooagent="||g_enterprise||" AND t13.ooag001=t0.stemcnfid  ",
 
               " WHERE t0.stement = " ||g_enterprise|| " AND t0.stemdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astt802_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt802 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt802_init()   
 
      #進入選單 Menu (="N")
      CALL astt802_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt802
      
   END IF 
   
   CLOSE astt802_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt802.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astt802_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('stemstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('sten001','6783') 
   CALL cl_set_combo_scc('steo001','6784') 
   CALL cl_set_combo_scc('steo002','6783') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
#   CALL cl_set_comp_visible("sten007,sten011",FALSE)   #160512-00003#24
   CALL cl_set_comp_visible("sten011",FALSE)            #160512-00003#24
   LET g_errshow = '1'
   CALL s_aooi500_create_temp() RETURNING l_success
#   CALL cl_set_act_visible("sten007,sten011", FALSE)   #160512-00003#24
   CALL cl_set_act_visible("sten011", FALSE)            #160512-00003#24
   CALL cl_set_combo_scc_part('sten001','6916','1,2,3,4') 
   CALL cl_set_combo_scc_part('steo002','6916','1,2,3,4')
   CALL s_asti800_set_comp_format("stem006",g_stem_m.stemsite,'2')
   CALL s_asti800_set_comp_format("stem017",g_stem_m.stemsite,'2')
   CALL s_asti800_set_comp_format("stem007",g_stem_m.stemsite,'2')
   CALL s_asti800_set_comp_format("step006",g_stem_m.stemsite,'2')
   CALL s_asti800_set_comp_format("stem018",g_stem_m.stemsite,'1')
   CALL s_asti800_set_comp_format("sten005",g_stem_m.stemsite,'1')
   CALL s_asti800_set_comp_format("steo006",g_stem_m.stemsite,'1')
   #end add-point
   
   #初始化搜尋條件
   CALL astt802_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="astt802.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION astt802_ui_dialog()
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
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
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
            CALL astt802_insert()
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
         INITIALIZE g_stem_m.* TO NULL
         CALL g_sten_d.clear()
         CALL g_sten2_d.clear()
         CALL g_sten3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL astt802_init()
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
               
               CALL astt802_fetch('') # reload data
               LET l_ac = 1
               CALL astt802_ui_detailshow() #Setting the current row 
         
               CALL astt802_idx_chk()
               #NEXT FIELD stenseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_sten_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt802_idx_chk()
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
               CALL astt802_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_sten2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt802_idx_chk()
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
               CALL astt802_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_sten3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL astt802_idx_chk()
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
               CALL astt802_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL astt802_browser_fill("")
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
               CALL astt802_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL astt802_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL astt802_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL astt802_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL astt802_set_act_visible()   
            CALL astt802_set_act_no_visible()
            IF NOT (g_stem_m.stemdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " stement = " ||g_enterprise|| " AND",
                                  " stemdocno = '", g_stem_m.stemdocno, "' "
 
               #填到對應位置
               CALL astt802_browser_fill("")
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "stem_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sten_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "steo_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "step_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL astt802_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "stem_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sten_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "steo_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "step_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
 
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
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL astt802_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL astt802_fetch("F")
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
               CALL astt802_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL astt802_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt802_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL astt802_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt802_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL astt802_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt802_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL astt802_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt802_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL astt802_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL astt802_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_sten_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_sten2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_sten3_d)
                  LET g_export_id[3]   = "s_detail3"
 
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
               NEXT FIELD stenseq
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
               CALL astt802_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL astt802_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL astt802_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astt802_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ast/astt802_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/ast/astt802_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL astt802_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION execute_deals
            LET g_action_choice="execute_deals"
            IF cl_auth_chk_act("execute_deals") THEN
               
               #add-point:ON ACTION execute_deals name="menu.execute_deals"
               IF g_stem_m.stemstus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00240' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #已经执行优惠不可再执行
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM sten_t
                WHERE stenent = g_enterprise
                  AND stendocno = g_stem_m.stemdocno
                  AND sten011 = 'Y'
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'ast-00244' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               #是否確認執行
               IF cl_ask_confirm('afa-00405') THEN
                  CALL s_transaction_begin() 
                  CALL astt802_ins_stfi() RETURNING r_success
                  IF NOT r_success THEN
                     CALL s_transaction_end('N','0')
                     CONTINUE DIALOG
                  END IF
                  CALL s_transaction_end('Y','0')
               END IF
               CALL astt802_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL astt802_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL astt802_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL astt802_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL astt802_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_stem_m.stemdocdt)
 
 
 
         
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
 
{<section id="astt802.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION astt802_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING
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
   CALL s_aooi500_sql_where(g_prog,'stemsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET l_wc  = g_wc.trim()
   LET l_wc = l_wc," AND stem000='astt802'" #08172
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT stemdocno ",
                      " FROM stem_t ",
                      " ",
                      " LEFT JOIN sten_t ON stenent = stement AND stemdocno = stendocno ", "  ",
                      #add-point:browser_fill段sql(sten_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN steo_t ON steoent = stement AND stemdocno = steodocno", "  ",
                      #add-point:browser_fill段sql(steo_t1) name="browser_fill.cnt.join.steo_t1"
                      
                      #end add-point
 
                      " LEFT JOIN step_t ON stepent = stement AND stemdocno = stepdocno", "  ",
                      #add-point:browser_fill段sql(step_t1) name="browser_fill.cnt.join.step_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE stement = " ||g_enterprise|| " AND stenent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("stem_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT stemdocno ",
                      " FROM stem_t ", 
                      "  ",
                      "  ",
                      " WHERE stement = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("stem_t")
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
      INITIALIZE g_stem_m.* TO NULL
      CALL g_sten_d.clear()        
      CALL g_sten2_d.clear() 
      CALL g_sten3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.stemsite,t0.stemdocdt,t0.stemdocno,t0.stem001,t0.stem002,t0.stem003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stemstus,t0.stemsite,t0.stemdocdt,t0.stemdocno,t0.stem001,t0.stem002, 
          t0.stem003,t1.ooefl003 ,t2.mhael023 ,t3.pmaal004 ",
                  " FROM stem_t t0",
                  "  ",
                  "  LEFT JOIN sten_t ON stenent = stement AND stemdocno = stendocno ", "  ", 
                  #add-point:browser_fill段sql(sten_t1) name="browser_fill.join.sten_t1"
                  
                  #end add-point
                  "  LEFT JOIN steo_t ON steoent = stement AND stemdocno = steodocno", "  ", 
                  #add-point:browser_fill段sql(steo_t1) name="browser_fill.join.steo_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN step_t ON stepent = stement AND stemdocno = stepdocno", "  ", 
                  #add-point:browser_fill段sql(step_t1) name="browser_fill.join.step_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stemsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhaelsite=t0.stemsite AND t2.mhael001=t0.stem002 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stem003 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stement = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("stem_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.stemstus,t0.stemsite,t0.stemdocdt,t0.stemdocno,t0.stem001,t0.stem002, 
          t0.stem003,t1.ooefl003 ,t2.mhael023 ,t3.pmaal004 ",
                  " FROM stem_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.stemsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhael_t t2 ON t2.mhaelent="||g_enterprise||" AND t2.mhaelsite=t0.stemsite AND t2.mhael001=t0.stem002 AND t2.mhael022='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.stem003 AND t3.pmaal002='"||g_dlang||"' ",
 
                  " WHERE t0.stement = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("stem_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY stemdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"stem_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_stemsite,g_browser[g_cnt].b_stemdocdt, 
          g_browser[g_cnt].b_stemdocno,g_browser[g_cnt].b_stem001,g_browser[g_cnt].b_stem002,g_browser[g_cnt].b_stem003, 
          g_browser[g_cnt].b_stemsite_desc,g_browser[g_cnt].b_stem002_desc,g_browser[g_cnt].b_stem003_desc 
 
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
         CALL astt802_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_stemdocno) THEN
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
 
{<section id="astt802.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION astt802_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_stem_m.stemdocno = g_browser[g_current_idx].b_stemdocno   
 
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
   CALL astt802_stem_t_mask()
   CALL astt802_show()
      
END FUNCTION
 
{</section>}
 
{<section id="astt802.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION astt802_ui_detailshow()
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
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION astt802_ui_browser_refresh()
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
      IF g_browser[l_i].b_stemdocno = g_stem_m.stemdocno 
 
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
 
{<section id="astt802.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt802_construct()
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
   INITIALIZE g_stem_m.* TO NULL
   CALL g_sten_d.clear()        
   CALL g_sten2_d.clear() 
   CALL g_sten3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   LET g_stem_m.stem000='astt802'
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON stemsite,stemdocdt,stemdocno,stem001,stem016,stem002,stem003,stem005, 
          stem004,stem006,stem017,stem007,stem009,stem010,stem011,stem018,stem000,stem012,stem013,stem034, 
          stemstus,stemownid,stemowndp,stemcrtid,stemcrtdp,stemcrtdt,stemmodid,stemmoddt,stemcnfid,stemcnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stemcrtdt>>----
         AFTER FIELD stemcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stemmoddt>>----
         AFTER FIELD stemmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stemcnfdt>>----
         AFTER FIELD stemcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stempstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.stemsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemsite
            #add-point:ON ACTION controlp INFIELD stemsite name="construct.c.stemsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stemsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemsite  #顯示到畫面上
            NEXT FIELD stemsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemsite
            #add-point:BEFORE FIELD stemsite name="construct.b.stemsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemsite
            
            #add-point:AFTER FIELD stemsite name="construct.a.stemsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemdocdt
            #add-point:BEFORE FIELD stemdocdt name="construct.b.stemdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemdocdt
            
            #add-point:AFTER FIELD stemdocdt name="construct.a.stemdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stemdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemdocdt
            #add-point:ON ACTION controlp INFIELD stemdocdt name="construct.c.stemdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stemdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemdocno
            #add-point:ON ACTION controlp INFIELD stemdocno name="construct.c.stemdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " stem000='astt802'"
            CALL q_stemdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemdocno  #顯示到畫面上
            NEXT FIELD stemdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemdocno
            #add-point:BEFORE FIELD stemdocno name="construct.b.stemdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemdocno
            
            #add-point:AFTER FIELD stemdocno name="construct.a.stemdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem001
            #add-point:ON ACTION controlp INFIELD stem001 name="construct.c.stem001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "stjesite='",g_site,"'"          #160324-00008#16 by 08172
            CALL q_stje001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem001  #顯示到畫面上
            NEXT FIELD stem001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem001
            #add-point:BEFORE FIELD stem001 name="construct.b.stem001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem001
            
            #add-point:AFTER FIELD stem001 name="construct.a.stem001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem016
            #add-point:BEFORE FIELD stem016 name="construct.b.stem016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem016
            
            #add-point:AFTER FIELD stem016 name="construct.a.stem016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem016
            #add-point:ON ACTION controlp INFIELD stem016 name="construct.c.stem016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stem002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem002
            #add-point:ON ACTION controlp INFIELD stem002 name="construct.c.stem002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " mhaesite='",g_site,"'"
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem002  #顯示到畫面上
            NEXT FIELD stem002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem002
            #add-point:BEFORE FIELD stem002 name="construct.b.stem002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem002
            
            #add-point:AFTER FIELD stem002 name="construct.a.stem002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem003
            #add-point:ON ACTION controlp INFIELD stem003 name="construct.c.stem003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#4 -s by 08172
            LET g_qryparam.arg1 = "('3')"
            CALL q_pmaa001_1()
#            LET g_qryparam.where = " pmaa002='3'"
#            CALL q_pmaa001_8()                           #呼叫開窗
            #160913-00034#4 -e by 08172
            DISPLAY g_qryparam.return1 TO stem003  #顯示到畫面上
            NEXT FIELD stem003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem003
            #add-point:BEFORE FIELD stem003 name="construct.b.stem003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem003
            
            #add-point:AFTER FIELD stem003 name="construct.a.stem003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem005
            #add-point:ON ACTION controlp INFIELD stem005 name="construct.c.stem005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem005  #顯示到畫面上
            NEXT FIELD stem005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem005
            #add-point:BEFORE FIELD stem005 name="construct.b.stem005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem005
            
            #add-point:AFTER FIELD stem005 name="construct.a.stem005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem004
            #add-point:ON ACTION controlp INFIELD stem004 name="construct.c.stem004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem004  #顯示到畫面上
            NEXT FIELD stem004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem004
            #add-point:BEFORE FIELD stem004 name="construct.b.stem004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem004
            
            #add-point:AFTER FIELD stem004 name="construct.a.stem004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem006
            #add-point:BEFORE FIELD stem006 name="construct.b.stem006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem006
            
            #add-point:AFTER FIELD stem006 name="construct.a.stem006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem006
            #add-point:ON ACTION controlp INFIELD stem006 name="construct.c.stem006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem017
            #add-point:BEFORE FIELD stem017 name="construct.b.stem017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem017
            
            #add-point:AFTER FIELD stem017 name="construct.a.stem017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem017
            #add-point:ON ACTION controlp INFIELD stem017 name="construct.c.stem017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem007
            #add-point:BEFORE FIELD stem007 name="construct.b.stem007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem007
            
            #add-point:AFTER FIELD stem007 name="construct.a.stem007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem007
            #add-point:ON ACTION controlp INFIELD stem007 name="construct.c.stem007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem009
            #add-point:BEFORE FIELD stem009 name="construct.b.stem009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem009
            
            #add-point:AFTER FIELD stem009 name="construct.a.stem009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem009
            #add-point:ON ACTION controlp INFIELD stem009 name="construct.c.stem009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem010
            #add-point:BEFORE FIELD stem010 name="construct.b.stem010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem010
            
            #add-point:AFTER FIELD stem010 name="construct.a.stem010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem010
            #add-point:ON ACTION controlp INFIELD stem010 name="construct.c.stem010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem011
            #add-point:BEFORE FIELD stem011 name="construct.b.stem011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem011
            
            #add-point:AFTER FIELD stem011 name="construct.a.stem011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem011
            #add-point:ON ACTION controlp INFIELD stem011 name="construct.c.stem011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem018
            #add-point:BEFORE FIELD stem018 name="construct.b.stem018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem018
            
            #add-point:AFTER FIELD stem018 name="construct.a.stem018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem018
            #add-point:ON ACTION controlp INFIELD stem018 name="construct.c.stem018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem000
            #add-point:BEFORE FIELD stem000 name="construct.b.stem000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem000
            
            #add-point:AFTER FIELD stem000 name="construct.a.stem000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem000
            #add-point:ON ACTION controlp INFIELD stem000 name="construct.c.stem000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stem012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem012
            #add-point:ON ACTION controlp INFIELD stem012 name="construct.c.stem012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem012  #顯示到畫面上
            NEXT FIELD stem012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem012
            #add-point:BEFORE FIELD stem012 name="construct.b.stem012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem012
            
            #add-point:AFTER FIELD stem012 name="construct.a.stem012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem013
            #add-point:ON ACTION controlp INFIELD stem013 name="construct.c.stem013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stem013  #顯示到畫面上
            NEXT FIELD stem013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem013
            #add-point:BEFORE FIELD stem013 name="construct.b.stem013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem013
            
            #add-point:AFTER FIELD stem013 name="construct.a.stem013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem034
            #add-point:BEFORE FIELD stem034 name="construct.b.stem034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem034
            
            #add-point:AFTER FIELD stem034 name="construct.a.stem034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stem034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem034
            #add-point:ON ACTION controlp INFIELD stem034 name="construct.c.stem034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemstus
            #add-point:BEFORE FIELD stemstus name="construct.b.stemstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemstus
            
            #add-point:AFTER FIELD stemstus name="construct.a.stemstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stemstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemstus
            #add-point:ON ACTION controlp INFIELD stemstus name="construct.c.stemstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stemownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemownid
            #add-point:ON ACTION controlp INFIELD stemownid name="construct.c.stemownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemownid  #顯示到畫面上
            NEXT FIELD stemownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemownid
            #add-point:BEFORE FIELD stemownid name="construct.b.stemownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemownid
            
            #add-point:AFTER FIELD stemownid name="construct.a.stemownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stemowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemowndp
            #add-point:ON ACTION controlp INFIELD stemowndp name="construct.c.stemowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemowndp  #顯示到畫面上
            NEXT FIELD stemowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemowndp
            #add-point:BEFORE FIELD stemowndp name="construct.b.stemowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemowndp
            
            #add-point:AFTER FIELD stemowndp name="construct.a.stemowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stemcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemcrtid
            #add-point:ON ACTION controlp INFIELD stemcrtid name="construct.c.stemcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemcrtid  #顯示到畫面上
            NEXT FIELD stemcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemcrtid
            #add-point:BEFORE FIELD stemcrtid name="construct.b.stemcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemcrtid
            
            #add-point:AFTER FIELD stemcrtid name="construct.a.stemcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stemcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemcrtdp
            #add-point:ON ACTION controlp INFIELD stemcrtdp name="construct.c.stemcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemcrtdp  #顯示到畫面上
            NEXT FIELD stemcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemcrtdp
            #add-point:BEFORE FIELD stemcrtdp name="construct.b.stemcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemcrtdp
            
            #add-point:AFTER FIELD stemcrtdp name="construct.a.stemcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemcrtdt
            #add-point:BEFORE FIELD stemcrtdt name="construct.b.stemcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stemmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemmodid
            #add-point:ON ACTION controlp INFIELD stemmodid name="construct.c.stemmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemmodid  #顯示到畫面上
            NEXT FIELD stemmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemmodid
            #add-point:BEFORE FIELD stemmodid name="construct.b.stemmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemmodid
            
            #add-point:AFTER FIELD stemmodid name="construct.a.stemmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemmoddt
            #add-point:BEFORE FIELD stemmoddt name="construct.b.stemmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.stemcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemcnfid
            #add-point:ON ACTION controlp INFIELD stemcnfid name="construct.c.stemcnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stemcnfid  #顯示到畫面上
            NEXT FIELD stemcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemcnfid
            #add-point:BEFORE FIELD stemcnfid name="construct.b.stemcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemcnfid
            
            #add-point:AFTER FIELD stemcnfid name="construct.a.stemcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemcnfdt
            #add-point:BEFORE FIELD stemcnfdt name="construct.b.stemcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON stenacti,stenseq,sten001,sten002,sten003,sten004,sten007,sten012,sten005, 
          sten009,sten011
           FROM s_detail1[1].stenacti,s_detail1[1].stenseq,s_detail1[1].sten001,s_detail1[1].sten002, 
               s_detail1[1].sten003,s_detail1[1].sten004,s_detail1[1].sten007,s_detail1[1].sten012,s_detail1[1].sten005, 
               s_detail1[1].sten009,s_detail1[1].sten011
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stenacti
            #add-point:BEFORE FIELD stenacti name="construct.b.page1.stenacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stenacti
            
            #add-point:AFTER FIELD stenacti name="construct.a.page1.stenacti"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stenacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stenacti
            #add-point:ON ACTION controlp INFIELD stenacti name="construct.c.page1.stenacti"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stenseq
            #add-point:BEFORE FIELD stenseq name="construct.b.page1.stenseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stenseq
            
            #add-point:AFTER FIELD stenseq name="construct.a.page1.stenseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.stenseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stenseq
            #add-point:ON ACTION controlp INFIELD stenseq name="construct.c.page1.stenseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten001
            #add-point:BEFORE FIELD sten001 name="construct.b.page1.sten001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten001
            
            #add-point:AFTER FIELD sten001 name="construct.a.page1.sten001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten001
            #add-point:ON ACTION controlp INFIELD sten001 name="construct.c.page1.sten001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.sten002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten002
            #add-point:ON ACTION controlp INFIELD sten002 name="construct.c.page1.sten002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where=" stae001 in ( SELECT stif004 FROM stif_t WHERE stifent ='", g_enterprise ,"' )"
            CALL q_stae001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sten002  #顯示到畫面上
            NEXT FIELD sten002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten002
            #add-point:BEFORE FIELD sten002 name="construct.b.page1.sten002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten002
            
            #add-point:AFTER FIELD sten002 name="construct.a.page1.sten002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten003
            #add-point:BEFORE FIELD sten003 name="construct.b.page1.sten003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten003
            
            #add-point:AFTER FIELD sten003 name="construct.a.page1.sten003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten003
            #add-point:ON ACTION controlp INFIELD sten003 name="construct.c.page1.sten003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten004
            #add-point:BEFORE FIELD sten004 name="construct.b.page1.sten004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten004
            
            #add-point:AFTER FIELD sten004 name="construct.a.page1.sten004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten004
            #add-point:ON ACTION controlp INFIELD sten004 name="construct.c.page1.sten004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten007
            #add-point:BEFORE FIELD sten007 name="construct.b.page1.sten007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten007
            
            #add-point:AFTER FIELD sten007 name="construct.a.page1.sten007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten007
            #add-point:ON ACTION controlp INFIELD sten007 name="construct.c.page1.sten007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten012
            #add-point:BEFORE FIELD sten012 name="construct.b.page1.sten012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten012
            
            #add-point:AFTER FIELD sten012 name="construct.a.page1.sten012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten012
            #add-point:ON ACTION controlp INFIELD sten012 name="construct.c.page1.sten012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten005
            #add-point:BEFORE FIELD sten005 name="construct.b.page1.sten005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten005
            
            #add-point:AFTER FIELD sten005 name="construct.a.page1.sten005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten005
            #add-point:ON ACTION controlp INFIELD sten005 name="construct.c.page1.sten005"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.sten009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten009
            #add-point:ON ACTION controlp INFIELD sten009 name="construct.c.page1.sten009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2132'
            CALL q_oocq002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sten009  #顯示到畫面上
            NEXT FIELD sten009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten009
            #add-point:BEFORE FIELD sten009 name="construct.b.page1.sten009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten009
            
            #add-point:AFTER FIELD sten009 name="construct.a.page1.sten009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten011
            #add-point:BEFORE FIELD sten011 name="construct.b.page1.sten011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten011
            
            #add-point:AFTER FIELD sten011 name="construct.a.page1.sten011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sten011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten011
            #add-point:ON ACTION controlp INFIELD sten011 name="construct.c.page1.sten011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON steoseq,steo001,steo002,steo003,steo004,steo005,steo006,steo007,steo008, 
          steo009
           FROM s_detail2[1].steoseq,s_detail2[1].steo001,s_detail2[1].steo002,s_detail2[1].steo003, 
               s_detail2[1].steo004,s_detail2[1].steo005,s_detail2[1].steo006,s_detail2[1].steo007,s_detail2[1].steo008, 
               s_detail2[1].steo009
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steoseq
            #add-point:BEFORE FIELD steoseq name="construct.b.page2.steoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steoseq
            
            #add-point:AFTER FIELD steoseq name="construct.a.page2.steoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steoseq
            #add-point:ON ACTION controlp INFIELD steoseq name="construct.c.page2.steoseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo001
            #add-point:BEFORE FIELD steo001 name="construct.b.page2.steo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo001
            
            #add-point:AFTER FIELD steo001 name="construct.a.page2.steo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo001
            #add-point:ON ACTION controlp INFIELD steo001 name="construct.c.page2.steo001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo002
            #add-point:BEFORE FIELD steo002 name="construct.b.page2.steo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo002
            
            #add-point:AFTER FIELD steo002 name="construct.a.page2.steo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo002
            #add-point:ON ACTION controlp INFIELD steo002 name="construct.c.page2.steo002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.steo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo003
            #add-point:ON ACTION controlp INFIELD steo003 name="construct.c.page2.steo003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steo003  #顯示到畫面上
            NEXT FIELD steo003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo003
            #add-point:BEFORE FIELD steo003 name="construct.b.page2.steo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo003
            
            #add-point:AFTER FIELD steo003 name="construct.a.page2.steo003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo004
            #add-point:BEFORE FIELD steo004 name="construct.b.page2.steo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo004
            
            #add-point:AFTER FIELD steo004 name="construct.a.page2.steo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo004
            #add-point:ON ACTION controlp INFIELD steo004 name="construct.c.page2.steo004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo005
            #add-point:BEFORE FIELD steo005 name="construct.b.page2.steo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo005
            
            #add-point:AFTER FIELD steo005 name="construct.a.page2.steo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo005
            #add-point:ON ACTION controlp INFIELD steo005 name="construct.c.page2.steo005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo006
            #add-point:BEFORE FIELD steo006 name="construct.b.page2.steo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo006
            
            #add-point:AFTER FIELD steo006 name="construct.a.page2.steo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo006
            #add-point:ON ACTION controlp INFIELD steo006 name="construct.c.page2.steo006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.steo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo007
            #add-point:ON ACTION controlp INFIELD steo007 name="construct.c.page2.steo007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2132'
            CALL q_oocq002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steo007  #顯示到畫面上
            NEXT FIELD steo007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo007
            #add-point:BEFORE FIELD steo007 name="construct.b.page2.steo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo007
            
            #add-point:AFTER FIELD steo007 name="construct.a.page2.steo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo008
            #add-point:ON ACTION controlp INFIELD steo008 name="construct.c.page2.steo008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stemdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO steo008  #顯示到畫面上
            NEXT FIELD steo008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo008
            #add-point:BEFORE FIELD steo008 name="construct.b.page2.steo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo008
            
            #add-point:AFTER FIELD steo008 name="construct.a.page2.steo008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD steo009
            #add-point:BEFORE FIELD steo009 name="construct.b.page2.steo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD steo009
            
            #add-point:AFTER FIELD steo009 name="construct.a.page2.steo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.steo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD steo009
            #add-point:ON ACTION controlp INFIELD steo009 name="construct.c.page2.steo009"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON stepseq,step001,step002,step003,step004,step005,step006,step007,step008 
 
           FROM s_detail3[1].stepseq,s_detail3[1].step001,s_detail3[1].step002,s_detail3[1].step003, 
               s_detail3[1].step004,s_detail3[1].step005,s_detail3[1].step006,s_detail3[1].step007,s_detail3[1].step008 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stepseq
            #add-point:BEFORE FIELD stepseq name="construct.b.page3.stepseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stepseq
            
            #add-point:AFTER FIELD stepseq name="construct.a.page3.stepseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.stepseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stepseq
            #add-point:ON ACTION controlp INFIELD stepseq name="construct.c.page3.stepseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.step001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step001
            #add-point:ON ACTION controlp INFIELD step001 name="construct.c.page3.step001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'step001') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'step001',g_site,'c')
               CALL q_ooef001_24()                           #呼叫開窗
            ELSE
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO step001  #顯示到畫面上
            NEXT FIELD step001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step001
            #add-point:BEFORE FIELD step001 name="construct.b.page3.step001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step001
            
            #add-point:AFTER FIELD step001 name="construct.a.page3.step001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step002
            #add-point:ON ACTION controlp INFIELD step002 name="construct.c.page3.step002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO step002  #顯示到畫面上
            NEXT FIELD step002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step002
            #add-point:BEFORE FIELD step002 name="construct.b.page3.step002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step002
            
            #add-point:AFTER FIELD step002 name="construct.a.page3.step002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step003
            #add-point:BEFORE FIELD step003 name="construct.b.page3.step003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step003
            
            #add-point:AFTER FIELD step003 name="construct.a.page3.step003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step003
            #add-point:ON ACTION controlp INFIELD step003 name="construct.c.page3.step003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step004
            #add-point:BEFORE FIELD step004 name="construct.b.page3.step004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step004
            
            #add-point:AFTER FIELD step004 name="construct.a.page3.step004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step004
            #add-point:ON ACTION controlp INFIELD step004 name="construct.c.page3.step004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step005
            #add-point:BEFORE FIELD step005 name="construct.b.page3.step005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step005
            
            #add-point:AFTER FIELD step005 name="construct.a.page3.step005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step005
            #add-point:ON ACTION controlp INFIELD step005 name="construct.c.page3.step005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step006
            #add-point:BEFORE FIELD step006 name="construct.b.page3.step006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step006
            
            #add-point:AFTER FIELD step006 name="construct.a.page3.step006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step006
            #add-point:ON ACTION controlp INFIELD step006 name="construct.c.page3.step006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.step007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step007
            #add-point:ON ACTION controlp INFIELD step007 name="construct.c.page3.step007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO step007  #顯示到畫面上
            NEXT FIELD step007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step007
            #add-point:BEFORE FIELD step007 name="construct.b.page3.step007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step007
            
            #add-point:AFTER FIELD step007 name="construct.a.page3.step007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.step008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD step008
            #add-point:ON ACTION controlp INFIELD step008 name="construct.c.page3.step008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO step008  #顯示到畫面上
            NEXT FIELD step008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD step008
            #add-point:BEFORE FIELD step008 name="construct.b.page3.step008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD step008
            
            #add-point:AFTER FIELD step008 name="construct.a.page3.step008"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "stem_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sten_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "steo_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "step_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
 
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
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION astt802_filter()
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
      CONSTRUCT g_wc_filter ON stemsite,stemdocdt,stemdocno,stem001,stem002,stem003
                          FROM s_browse[1].b_stemsite,s_browse[1].b_stemdocdt,s_browse[1].b_stemdocno, 
                              s_browse[1].b_stem001,s_browse[1].b_stem002,s_browse[1].b_stem003
 
         BEFORE CONSTRUCT
               DISPLAY astt802_filter_parser('stemsite') TO s_browse[1].b_stemsite
            DISPLAY astt802_filter_parser('stemdocdt') TO s_browse[1].b_stemdocdt
            DISPLAY astt802_filter_parser('stemdocno') TO s_browse[1].b_stemdocno
            DISPLAY astt802_filter_parser('stem001') TO s_browse[1].b_stem001
            DISPLAY astt802_filter_parser('stem002') TO s_browse[1].b_stem002
            DISPLAY astt802_filter_parser('stem003') TO s_browse[1].b_stem003
      
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
 
      CALL astt802_filter_show('stemsite')
   CALL astt802_filter_show('stemdocdt')
   CALL astt802_filter_show('stemdocno')
   CALL astt802_filter_show('stem001')
   CALL astt802_filter_show('stem002')
   CALL astt802_filter_show('stem003')
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION astt802_filter_parser(ps_field)
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
 
{<section id="astt802.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION astt802_filter_show(ps_field)
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
   LET ls_condition = astt802_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION astt802_query()
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
   CALL g_sten_d.clear()
   CALL g_sten2_d.clear()
   CALL g_sten3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL astt802_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL astt802_browser_fill("")
      CALL astt802_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL astt802_filter_show('stemsite')
   CALL astt802_filter_show('stemdocdt')
   CALL astt802_filter_show('stemdocno')
   CALL astt802_filter_show('stem001')
   CALL astt802_filter_show('stem002')
   CALL astt802_filter_show('stem003')
   CALL astt802_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL astt802_fetch("F") 
      #顯示單身筆數
      CALL astt802_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION astt802_fetch(p_flag)
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
   
   LET g_stem_m.stemdocno = g_browser[g_current_idx].b_stemdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
   #遮罩相關處理
   LET g_stem_m_mask_o.* =  g_stem_m.*
   CALL astt802_stem_t_mask()
   LET g_stem_m_mask_n.* =  g_stem_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt802_set_act_visible()   
   CALL astt802_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #170203-00024#5-S
   IF g_stem_m.stemstus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #170203-00024#5-E
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_stem_m_t.* = g_stem_m.*
   LET g_stem_m_o.* = g_stem_m.*
   
   LET g_data_owner = g_stem_m.stemownid      
   LET g_data_dept  = g_stem_m.stemowndp
   
   #重新顯示   
   CALL astt802_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.insert" >}
#+ 資料新增
PRIVATE FUNCTION astt802_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_insert      LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004
#   DEFINE l_oobx001     LIKE oobx_t.oobx001
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
 
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sten_d.clear()   
   CALL g_sten2_d.clear()  
   CALL g_sten3_d.clear()  
 
 
   INITIALIZE g_stem_m.* TO NULL             #DEFAULT 設定
   
   LET g_stemdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stem_m.stemownid = g_user
      LET g_stem_m.stemowndp = g_dept
      LET g_stem_m.stemcrtid = g_user
      LET g_stem_m.stemcrtdp = g_dept 
      LET g_stem_m.stemcrtdt = cl_get_current()
      LET g_stem_m.stemmodid = g_user
      LET g_stem_m.stemmoddt = cl_get_current()
      LET g_stem_m.stemstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_stem_m.stem018 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_stem_m.stem009 = g_today
      LET g_stem_m.stem010 = g_today
      LET g_stem_m.stem011 = g_today
      LET g_stem_m.stem000 = 'astt802'
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'stemsite',g_stem_m.stemsite)
         RETURNING l_insert,g_stem_m.stemsite
      IF NOT l_insert THEN
         RETURN
      END IF
#      LET g_stem_m.stemunit = g_stem_m.stemsite
      LET g_stem_m.stemdocdt = g_today
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_stem_m.stemsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_stem_m.stemdocno = r_doctype
#      LET g_stem_m.stem008 = 'N'
#      LET g_stem_m.stemacti = 'Y'
      LET g_stem_m.stem012 = g_user
      LET g_stem_m.stem013 = g_dept
      
#      SELECT oobx001 INTO l_oobx001 FROM oobx_t WHERE oobxent = g_enterprise AND oobx004 = "astt802"
#      LET g_stem_m.stemdocno = l_oobx001
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stem_m.stemsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemsite_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stem012
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_stem_m.stem012_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stem012_desc

      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stem013
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stem_m.stem013_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stem013_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemownid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_stem_m.stemownid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemownid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemowndp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stem_m.stemowndp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemowndp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemcrtid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_stem_m.stemcrtid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemcrtid_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemcrtdp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_stem_m.stemcrtdp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemcrtdp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_stem_m.stemmodid
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_stem_m.stemmodid_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_stem_m.stemmodid_desc
      
      LET g_stem_m_t.* = g_stem_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_stem_m_t.* = g_stem_m.*
      LET g_stem_m_o.* = g_stem_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stem_m.stemstus 
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
 
 
 
    
      CALL astt802_input("a")
      
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
         INITIALIZE g_stem_m.* TO NULL
         INITIALIZE g_sten_d TO NULL
         INITIALIZE g_sten2_d TO NULL
         INITIALIZE g_sten3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL astt802_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_sten_d.clear()
      #CALL g_sten2_d.clear()
      #CALL g_sten3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt802_set_act_visible()   
   CALL astt802_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stemdocno_t = g_stem_m.stemdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stement = " ||g_enterprise|| " AND",
                      " stemdocno = '", g_stem_m.stemdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt802_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE astt802_cl
   
   CALL astt802_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
   
   #遮罩相關處理
   LET g_stem_m_mask_o.* =  g_stem_m.*
   CALL astt802_stem_t_mask()
   LET g_stem_m_mask_n.* =  g_stem_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
       g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem002_desc,g_stem_m.stem003,g_stem_m.stem003_desc, 
       g_stem_m.stem005,g_stem_m.stem005_desc,g_stem_m.stem004,g_stem_m.stem004_desc,g_stem_m.stem006, 
       g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018, 
       g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem012_desc,g_stem_m.stem013,g_stem_m.stem013_desc, 
       g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemownid_desc,g_stem_m.stemowndp, 
       g_stem_m.stemowndp_desc,g_stem_m.stemcrtid,g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp,g_stem_m.stemcrtdp_desc, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmodid_desc,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
       g_stem_m.stemcnfid_desc,g_stem_m.stemcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_stem_m.stemownid      
   LET g_data_dept  = g_stem_m.stemowndp
   
   #功能已完成,通報訊息中心
   CALL astt802_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.modify" >}
#+ 資料修改
PRIVATE FUNCTION astt802_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   DEFINE  l_cmd                 LIKE type_t.chr1
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_stem_m_t.* = g_stem_m.*
   LET g_stem_m_o.* = g_stem_m.*
   
   IF g_stem_m.stemdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_stemdocno_t = g_stem_m.stemdocno
 
   CALL s_transaction_begin()
   
   OPEN astt802_cl USING g_enterprise,g_stem_m.stemdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt802_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
   #檢查是否允許此動作
   IF NOT astt802_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stem_m_mask_o.* =  g_stem_m.*
   CALL astt802_stem_t_mask()
   LET g_stem_m_mask_n.* =  g_stem_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL astt802_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_stemdocno_t = g_stem_m.stemdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_stem_m.stemmodid = g_user 
LET g_stem_m.stemmoddt = cl_get_current()
LET g_stem_m.stemmodid_desc = cl_get_username(g_stem_m.stemmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      LET l_cmd="u"
      CALL astt802_set_no_entry(l_cmd)
      #170203-00024#5-S
      IF g_stem_m.stemstus MATCHES '[DR]' THEN 
         LET g_stem_m.stemstus = "N"
      END IF
      #170203-00024#5-E
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL astt802_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE stem_t SET (stemmodid,stemmoddt) = (g_stem_m.stemmodid,g_stem_m.stemmoddt)
          WHERE stement = g_enterprise AND stemdocno = g_stemdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_stem_m.* = g_stem_m_t.*
            CALL astt802_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_stem_m.stemdocno != g_stem_m_t.stemdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE sten_t SET stendocno = g_stem_m.stemdocno
 
          WHERE stenent = g_enterprise AND stendocno = g_stem_m_t.stemdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sten_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
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
         
         UPDATE steo_t
            SET steodocno = g_stem_m.stemdocno
 
          WHERE steoent = g_enterprise AND
                steodocno = g_stemdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "steo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "steo_t:",SQLERRMESSAGE 
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
         
         UPDATE step_t
            SET stepdocno = g_stem_m.stemdocno
 
          WHERE stepent = g_enterprise AND
                stepdocno = g_stemdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "step_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "step_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update3"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL astt802_set_act_visible()   
   CALL astt802_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " stement = " ||g_enterprise|| " AND",
                      " stemdocno = '", g_stem_m.stemdocno, "' "
 
   #填到對應位置
   CALL astt802_browser_fill("")
 
   CLOSE astt802_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt802_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="astt802.input" >}
#+ 資料輸入
PRIVATE FUNCTION astt802_input(p_cmd)
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
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_stjesite            LIKE stje_t.stjesite
   DEFINE  l_stje005             LIKE stje_t.stje005
   DEFINE  l_stje002             LIKE stje_t.stje002
   DEFINE  l_amount              LIKE sten_t.sten005
   DEFINE  l_stem018             LIKE stem_t.stem018 #add by geza 20160623 #160604-00009#33
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
   DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
       g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem002_desc,g_stem_m.stem003,g_stem_m.stem003_desc, 
       g_stem_m.stem005,g_stem_m.stem005_desc,g_stem_m.stem004,g_stem_m.stem004_desc,g_stem_m.stem006, 
       g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018, 
       g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem012_desc,g_stem_m.stem013,g_stem_m.stem013_desc, 
       g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemownid_desc,g_stem_m.stemowndp, 
       g_stem_m.stemowndp_desc,g_stem_m.stemcrtid,g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp,g_stem_m.stemcrtdp_desc, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmodid_desc,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
       g_stem_m.stemcnfid_desc,g_stem_m.stemcnfdt
   
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
   LET g_forupd_sql = "SELECT stenacti,stenseq,sten001,sten002,sten003,sten004,sten007,sten012,sten005, 
       sten009,sten011 FROM sten_t WHERE stenent=? AND stendocno=? AND stenseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt802_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT steoseq,steo001,steo002,steo003,steo004,steo005,steo006,steo007,steo008, 
       steo009 FROM steo_t WHERE steoent=? AND steodocno=? AND steoseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt802_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT stepseq,step001,step002,step003,step004,step005,step006,step007,step008  
       FROM step_t WHERE stepent=? AND stepdocno=? AND stepseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt802_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL astt802_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL astt802_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem002, 
       g_stem_m.stem003,g_stem_m.stem005,g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007, 
       g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012, 
       g_stem_m.stem013,g_stem_m.stem034,g_stem_m.stemstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="astt802.input.head" >}
      #單頭段
      INPUT BY NAME g_stem_m.stemsite,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem002, 
          g_stem_m.stem003,g_stem_m.stem005,g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007, 
          g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012, 
          g_stem_m.stem013,g_stem_m.stem034,g_stem_m.stemstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN astt802_cl USING g_enterprise,g_stem_m.stemdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt802_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt802_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL astt802_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL astt802_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemsite
            
            #add-point:AFTER FIELD stemsite name="input.a.stemsite"
            IF NOT cl_null(g_stem_m.stemsite) THEN
               CALL s_aooi500_chk(g_prog,'stemsite',g_stem_m.stemsite,g_stem_m.stemsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_stem_m.stemsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_stem_m.stemsite = g_stem_m_t.stemsite
                  CALL s_desc_get_department_desc(g_stem_m.stemsite) RETURNING g_stem_m.stemsite_desc
                  DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL astt802_set_entry(p_cmd)
               CALL astt802_set_no_entry(p_cmd)
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stemsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stemsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stemsite_desc

#            LET g_stem_m.stemunit = g_stem_m.stemsite
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemsite
            #add-point:BEFORE FIELD stemsite name="input.b.stemsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stemsite
            #add-point:ON CHANGE stemsite name="input.g.stemsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemdocdt
            #add-point:BEFORE FIELD stemdocdt name="input.b.stemdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemdocdt
            
            #add-point:AFTER FIELD stemdocdt name="input.a.stemdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stemdocdt
            #add-point:ON CHANGE stemdocdt name="input.g.stemdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemdocno
            
            #add-point:AFTER FIELD stemdocno name="input.a.stemdocno"
            IF NOT cl_null(g_stem_m.stemdocno) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               CALL s_aooi100_sel_ooef004(g_stem_m.stemsite)
                  RETURNING l_success,l_ooef004
               LET g_chkparam.arg1 = l_ooef004
               LET g_chkparam.arg2 = g_stem_m.stemdocno
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stemdocno = g_stem_m_t.stemdocno
                  DISPLAY BY NAME g_stem_m.stemdocno
                  NEXT FIELD CURRENT
               END IF


            END IF 
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = l_ooef004
#            LET g_ref_fields[2] = g_stem_m.stemdocno
#            CALL ap_ref_array2(g_ref_fields,"SELECT oobal004 FROM oobal_t WHERE oobalent='"||g_enterprise||"' AND ooefl001=? AND ooefl002=? AND ooefl003='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_stem_m.stemdocno_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stem_m.stemdocno_desc
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_stem_m.stemdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_stem_m.stemdocno != g_stemdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM stem_t WHERE "||"stement = '" ||g_enterprise|| "' AND "||"stemdocno = '"||g_stem_m.stemdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_stem_m.stemsite,'',g_stem_m.stemdocno,g_prog) THEN
                     LET g_stem_m.stemdocno = g_stem_m_t.stemdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemdocno
            #add-point:BEFORE FIELD stemdocno name="input.b.stemdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stemdocno
            #add-point:ON CHANGE stemdocno name="input.g.stemdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem001
            #add-point:BEFORE FIELD stem001 name="input.b.stem001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem001
            
            #add-point:AFTER FIELD stem001 name="input.a.stem001"
            IF NOT cl_null(g_stem_m.stem001) THEN 
#應用 a17 樣板自動產生(Version:2)
              #欄位存在檢查
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stem_m.stem001
               LET g_chkparam.arg2 = g_stem_m.stemsite          #160324-00008#16 by 08172
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_stje001") THEN
                  #檢查成功時後續處理
                  
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stem001 = g_stem_m_t.stem001
                  DISPLAY BY NAME g_stem_m.stem001
                  NEXT FIELD CURRENT
               END IF

#               #合同归属单头组织
#               SELECT stjesite,stje005 INTO l_stjesite,l_stje005
#                 FROM stje_t
#                WHERE stjeent = g_enterprise
#                  AND stje001 = g_stem_m.stem001
#               IF l_stjesite <> g_stem_m.stemsite THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_stem_m.stem001 
#                  LET g_errparam.code   = 'ast-00227' 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  LET g_stem_m.stem001 = g_stem_m_t.stem001
#                  DISPLAY BY NAME g_stem_m.stem001
#                  NEXT FIELD CURRENT
#               END IF
#               #合同状态为2/3/4/5
#               IF l_stje005 NOT MATCHES '[2345]' THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = g_stem_m.stem001 
#                  LET g_errparam.code   = 'ast-00228' 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  LET g_stem_m.stem001 = g_stem_m_t.stem001
#                  DISPLAY BY NAME g_stem_m.stem001
#                  NEXT FIELD CURRENT
#               END IF
#               SELECT stje002 INTO l_stje002 FROM stje_t WHERE stjeent = g_enterprise AND stje001 = g_stem_t.stemd001
#               LET g_stem_m.stje002 = l_stje002
#               DISPLAY BY NAME g_stem_m.stje002
               #检查是否存在未审核资料
               IF NOT s_astt805_chk_stem(g_stem_m.stemdocno,g_stem_m.stem001) THEN
                  LET g_stem_m.stem001 = g_stem_m_t.stem001
                  DISPLAY BY NAME g_stem_m.stem001
                  NEXT FIELD stem001
               END IF
               CALL astt802_stem001_ref()
               CALL astt802_set_no_entry(p_cmd)
            ELSE
               #mark by geza 20160614(S)
#               LET g_stem_m.stem016=''
#               DISPLAY BY NAME g_stem_m.stem016
#               LET g_stem_m.stem002=''
#               LET g_stem_m.stem002_desc=''
#               DISPLAY BY NAME g_stem_m.stem002_desc
#               LET g_stem_m.stem003=''
#               LET g_stem_m.stem003_desc=''
#               DISPLAY BY NAME g_stem_m.stem003_desc
#               LET g_stem_m.stem004=''
#               LET g_stem_m.stem004_desc=''
#               DISPLAY BY NAME g_stem_m.stem004_desc
#               LET g_stem_m.stem005=''
#               LET g_stem_m.stem005_desc=''
#               DISPLAY BY NAME g_stem_m.stem005_desc
#               LET g_stem_m.stem006=''
#               LET g_stem_m.stem007=''
#               LET g_stem_m.stem009=''
#               LET g_stem_m.stem010=''
#               LET g_stem_m.stem011=''
#               LET g_stem_m.stem017=''
               #mark by geza 20160614(E)
               CALL astt802_set_no_entry(p_cmd)
            END IF 

            
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem001
            #add-point:ON CHANGE stem001 name="input.g.stem001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem002
            
            #add-point:AFTER FIELD stem002 name="input.a.stem002"
            IF NOT cl_null(g_stem_m.stem002) AND cl_null(g_stem_m.stem001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stem_m.stem002
               CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stem_m.stem002_desc
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stem_m.stem002 
               LET g_chkparam.err_str[1] = "amh-00630|",g_stem_m.stem002  
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_mhbe001") THEN
                  #檢查成功時後續處理
                  CALL astt802_stem002_ref()
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stem002 = g_stem_m_t.stem002
                  DISPLAY BY NAME g_stem_m.stem002
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stem_m.stem002
                  CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_stem_m.stem002_desc
                  NEXT FIELD CURRENT
               END IF
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM mhbe_t
                WHERE mhbeent = g_enterprise
                  AND mhbe001 = g_stem_m.stem002
                  AND mhbesite = g_stem_m.stemsite
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = "ast-00746"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_stem_m.stem002 = g_stem_m_t.stem002
                  DISPLAY BY NAME g_stem_m.stem002
                  NEXT FIELD stem002
               END IF
            END IF
            
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem002
            CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem002
            #add-point:BEFORE FIELD stem002 name="input.b.stem002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem002
            #add-point:ON CHANGE stem002 name="input.g.stem002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem003
            
            #add-point:AFTER FIELD stem003 name="input.a.stem003"
            IF NOT cl_null(g_stem_m.stem003) AND cl_null(g_stem_m.stem001) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stem_m.stem003
               CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stem_m.stem003_desc
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stem_m.stem003      
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_26") THEN
                  #檢查成功時後續處理
                  #add by geza 20160614(S)
                  IF g_stem_m.stem003 != g_stem_m_t.stem003 OR cl_null(g_stem_m_t.stem003) THEN
                     #供应商对应只有一个合同带出合同
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt
                       FROM stje_t
                      WHERE stjeent = g_enterprise
                        AND stje007 = g_stem_m.stem003
                        AND stje005 IN ('2','3','4','5')
                        AND stjestus = 'Y'
                        AND stjesite = g_stem_m.stemsite
                     IF l_cnt = 1 THEN
                        CALL astt802_stem003_ref()
                     END IF
                  END IF
                  #add by geza 20160614(E)
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stem003 = g_stem_m_t.stem003
                  DISPLAY BY NAME g_stem_m.stem003
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_stem_m.stem003
                  CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_stem_m.stem003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem003
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem003_desc
            
            LET g_stem_m_t.stem003 = g_stem_m.stem003  #add by geza 20160614
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem003
            #add-point:BEFORE FIELD stem003 name="input.b.stem003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem003
            #add-point:ON CHANGE stem003 name="input.g.stem003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem005
            
            #add-point:AFTER FIELD stem005 name="input.a.stem005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem005
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem005
            #add-point:BEFORE FIELD stem005 name="input.b.stem005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem005
            #add-point:ON CHANGE stem005 name="input.g.stem005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem004
            
            #add-point:AFTER FIELD stem004 name="input.a.stem004"
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem004
            #add-point:BEFORE FIELD stem004 name="input.b.stem004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem004
            #add-point:ON CHANGE stem004 name="input.g.stem004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem006
            #add-point:BEFORE FIELD stem006 name="input.b.stem006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem006
            
            #add-point:AFTER FIELD stem006 name="input.a.stem006"
        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem006
            #add-point:ON CHANGE stem006 name="input.g.stem006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem017
            #add-point:BEFORE FIELD stem017 name="input.b.stem017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem017
            
            #add-point:AFTER FIELD stem017 name="input.a.stem017"
   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem017
            #add-point:ON CHANGE stem017 name="input.g.stem017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem007
            #add-point:BEFORE FIELD stem007 name="input.b.stem007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem007
            
            #add-point:AFTER FIELD stem007 name="input.a.stem007"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem007
            #add-point:ON CHANGE stem007 name="input.g.stem007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem009
            #add-point:BEFORE FIELD stem009 name="input.b.stem009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem009
            
            #add-point:AFTER FIELD stem009 name="input.a.stem009"
            IF NOT cl_null(g_stem_m.stem009) THEN
               IF g_stem_m.stem009 > g_stem_m.stem010 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_stem_m.stem009
                  LET g_errparam.code   = 'ast-00454' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_stem_m.stem009 = g_stem_m_t.stem009
                  DISPLAY BY NAME g_stem_m.stem009
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem009
            #add-point:ON CHANGE stem009 name="input.g.stem009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem010
            #add-point:BEFORE FIELD stem010 name="input.b.stem010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem010
            
            #add-point:AFTER FIELD stem010 name="input.a.stem010"
            IF NOT cl_null(g_stem_m.stem010) THEN
               IF g_stem_m.stem010 < g_stem_m.stem009 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_stem_m.stem010
                  LET g_errparam.code   = 'ast-00455' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_stem_m.stem010 = g_stem_m_t.stem010
                  DISPLAY BY NAME g_stem_m.stem010
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem010
            #add-point:ON CHANGE stem010 name="input.g.stem010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem011
            #add-point:BEFORE FIELD stem011 name="input.b.stem011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem011
            
            #add-point:AFTER FIELD stem011 name="input.a.stem011"
            IF NOT cl_null(g_stem_m.stem011) THEN
               IF g_stem_m.stem011 >= g_stem_m.stem009 AND g_stem_m.stem011 <= g_stem_m.stem010 
               THEN
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_stem_m.stem011
                  LET g_errparam.code   = 'ast-00622' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_stem_m.stem011 = g_stem_m_t.stem011
                  DISPLAY BY NAME g_stem_m.stem011
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem011
            #add-point:ON CHANGE stem011 name="input.g.stem011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem018
            #add-point:BEFORE FIELD stem018 name="input.b.stem018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem018
            
            #add-point:AFTER FIELD stem018 name="input.a.stem018"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem018
            #add-point:ON CHANGE stem018 name="input.g.stem018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem000
            #add-point:BEFORE FIELD stem000 name="input.b.stem000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem000
            
            #add-point:AFTER FIELD stem000 name="input.a.stem000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem000
            #add-point:ON CHANGE stem000 name="input.g.stem000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem012
            
            #add-point:AFTER FIELD stem012 name="input.a.stem012"
            IF NOT cl_null(g_stem_m.stem012) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stem_m.stem012
               CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
               LET g_stem_m.stem012_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stem_m.stem012_desc
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stem_m.stem012

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stem012 = g_stem_m_t.stem012
                  LET g_stem_m.stem012_desc = ''
                  DISPLAY BY NAME g_stem_m.stem012,g_stem_m.stem012_desc
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem012
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_stem_m.stem012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem012_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem012
            #add-point:BEFORE FIELD stem012 name="input.b.stem012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem012
            #add-point:ON CHANGE stem012 name="input.g.stem012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem013
            
            #add-point:AFTER FIELD stem013 name="input.a.stem013"
            IF NOT cl_null(g_stem_m.stem013) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_stem_m.stem013
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_stem_m.stem013_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_stem_m.stem013_desc
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_stem_m.stem013
               LET g_chkparam.arg2 = g_today
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_stem_m.stem013 = g_stem_m_t.stem013
                  LET g_stem_m.stem013_desc = ''
                  DISPLAY BY NAME g_stem_m.stem013,g_stem_m.stem013_desc
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem013
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem013
            #add-point:BEFORE FIELD stem013 name="input.b.stem013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem013
            #add-point:ON CHANGE stem013 name="input.g.stem013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stem034
            #add-point:BEFORE FIELD stem034 name="input.b.stem034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stem034
            
            #add-point:AFTER FIELD stem034 name="input.a.stem034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stem034
            #add-point:ON CHANGE stem034 name="input.g.stem034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stemstus
            #add-point:BEFORE FIELD stemstus name="input.b.stemstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stemstus
            
            #add-point:AFTER FIELD stemstus name="input.a.stemstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stemstus
            #add-point:ON CHANGE stemstus name="input.g.stemstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.stemsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemsite
            #add-point:ON ACTION controlp INFIELD stemsite name="input.c.stemsite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stem_m.stemsite             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stemsite',g_stem_m.stemsite,'i')
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_stem_m.stemsite = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_stem_m.stemsite) RETURNING g_stem_m.stemsite_desc
            
            DISPLAY g_stem_m.stemsite TO stemsite              #
            DISPLAY g_stem_m.stemsite_desc TO stemsite_desc

            NEXT FIELD stemsite                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stemdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemdocdt
            #add-point:ON ACTION controlp INFIELD stemdocdt name="input.c.stemdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.stemdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemdocno
            #add-point:ON ACTION controlp INFIELD stemdocno name="input.c.stemdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stem_m.stemdocno             #給予default值

            #給予arg
            LET l_ooef004 = ''            
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise            
            LET g_qryparam.arg1 = l_ooef004 #
            #LET g_qryparam.arg2 = 'astt802' #   #160705-00042#5 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#5 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_stem_m.stemdocno = g_qryparam.return1              

            DISPLAY g_stem_m.stemdocno TO stemdocno              #

            NEXT FIELD stemdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stem001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem001
            #add-point:ON ACTION controlp INFIELD stem001 name="input.c.stem001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stem_m.stem001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

            LET g_qryparam.where = " stjesite = '",g_stem_m.stemsite,"' AND stje005 IN ('2','3','4','5') "      #160324-00008#16 by 08172
            CALL q_stje001()                                #呼叫開窗

            LET g_stem_m.stem001 = g_qryparam.return1              

            DISPLAY g_stem_m.stem001 TO stem001              #

            NEXT FIELD stem001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stem002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem002
            #add-point:ON ACTION controlp INFIELD stem002 name="input.c.stem002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stem_m.stem002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " mhbesite = '",g_stem_m.stemsite,"'"

 
            CALL q_mhbe001()                                #呼叫開窗
 
            LET g_stem_m.stem002 = g_qryparam.return1              

            DISPLAY g_stem_m.stem002 TO stem002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem002
            CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem002_desc

            NEXT FIELD stem002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.stem003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem003
            #add-point:ON ACTION controlp INFIELD stem003 name="input.c.stem003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stem_m.stem003             #給予default值

            #給予arg
            #160913-00034#4 -s by 08172
            LET g_qryparam.arg1 = "('3')"
            CALL q_pmaa001_1()
#            LET g_qryparam.where=" pmaa002='3'" #s
#
# 
#            CALL q_pmaa001_8()                                #呼叫開窗
 
            #160913-00034#4 -e by 08172
            LET g_stem_m.stem003 = g_qryparam.return1              

            DISPLAY g_stem_m.stem003 TO stem003              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem003
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem003_desc

            NEXT FIELD stem003                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.stem005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem005
            #add-point:ON ACTION controlp INFIELD stem005 name="input.c.stem005"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem004
            #add-point:ON ACTION controlp INFIELD stem004 name="input.c.stem004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_stem_m.stem004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s

 
            CALL q_rtax001()                                #呼叫開窗
 
            LET g_stem_m.stem004 = g_qryparam.return1              

            DISPLAY g_stem_m.stem004 TO stem004              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stem_m.stem004
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_stem_m.stem004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stem_m.stem004_desc

            NEXT FIELD stem004                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.stem006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem006
            #add-point:ON ACTION controlp INFIELD stem006 name="input.c.stem006"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem017
            #add-point:ON ACTION controlp INFIELD stem017 name="input.c.stem017"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem007
            #add-point:ON ACTION controlp INFIELD stem007 name="input.c.stem007"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem009
            #add-point:ON ACTION controlp INFIELD stem009 name="input.c.stem009"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem010
            #add-point:ON ACTION controlp INFIELD stem010 name="input.c.stem010"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem011
            #add-point:ON ACTION controlp INFIELD stem011 name="input.c.stem011"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem018
            #add-point:ON ACTION controlp INFIELD stem018 name="input.c.stem018"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem000
            #add-point:ON ACTION controlp INFIELD stem000 name="input.c.stem000"
            
            #END add-point
 
 
         #Ctrlp:input.c.stem012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem012
            #add-point:ON ACTION controlp INFIELD stem012 name="input.c.stem012"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stem_m.stem012             #給予default值
            LET g_qryparam.default2 = g_stem_m.stem012_desc #归属部门
            LET g_qryparam.default3 = g_stem_m.stem013 #說明(簡稱)
            LET g_qryparam.default4 = g_stem_m.stem013_desc #全名
            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001_6()                                #呼叫開窗

            LET g_stem_m.stem012 = g_qryparam.return1              
            LET g_stem_m.stem012_desc = g_qryparam.return2 
            LET g_stem_m.stem013 = g_qryparam.return3 
            LET g_stem_m.stem013_desc = g_qryparam.return4 
            DISPLAY g_stem_m.stem012 TO stem012              #
            DISPLAY g_stem_m.stem012_desc TO stem012_desc #归属部门
            DISPLAY g_stem_m.stem013 TO stem013 #說明(簡稱)
            DISPLAY g_stem_m.stem013_desc TO stem013_desc #全名
            NEXT FIELD stem012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stem013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem013
            #add-point:ON ACTION controlp INFIELD stem013 name="input.c.stem013"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_stem_m.stem013             #給予default值
            LET g_qryparam.default2 = g_stem_m.stem013_desc #部門編號
            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001()                                #呼叫開窗

            LET g_stem_m.stem013 = g_qryparam.return1              
            LET g_stem_m.stem013_desc = g_qryparam.return2 
            DISPLAY g_stem_m.stem013 TO stem013              #
            DISPLAY g_stem_m.stem013_desc TO stem013_desc #部門編號
            NEXT FIELD stem013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.stem034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stem034
            #add-point:ON ACTION controlp INFIELD stem034 name="input.c.stem034"
            
            #END add-point
 
 
         #Ctrlp:input.c.stemstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stemstus
            #add-point:ON ACTION controlp INFIELD stemstus name="input.c.stemstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_stem_m.stemdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_stem_m.stemsite,g_stem_m.stemdocno,g_stem_m.stemdocdt,g_prog)
               RETURNING l_flag,g_stem_m.stemdocno
               IF NOT l_flag THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_stem_m.stemdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD stemdocno
               END IF
               
               #end add-point
               
               INSERT INTO stem_t (stement,stemsite,stemdocdt,stemdocno,stem001,stem016,stem002,stem003, 
                   stem005,stem004,stem006,stem017,stem007,stem009,stem010,stem011,stem018,stem000,stem012, 
                   stem013,stem034,stemstus,stemownid,stemowndp,stemcrtid,stemcrtdp,stemcrtdt,stemmodid, 
                   stemmoddt,stemcnfid,stemcnfdt)
               VALUES (g_enterprise,g_stem_m.stemsite,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
                   g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005,g_stem_m.stem004, 
                   g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
                   g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013, 
                   g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid, 
                   g_stem_m.stemcrtdp,g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
                   g_stem_m.stemcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_stem_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #新增优惠执行情况和商户合作情况单身
               CALL astt802_ins_detail() RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL astt802_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL astt802_b_fill()
                  CALL astt802_b_fill2('0')
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
               CALL astt802_stem_t_mask_restore('restore_mask_o')
               
               UPDATE stem_t SET (stemsite,stemdocdt,stemdocno,stem001,stem016,stem002,stem003,stem005, 
                   stem004,stem006,stem017,stem007,stem009,stem010,stem011,stem018,stem000,stem012,stem013, 
                   stem034,stemstus,stemownid,stemowndp,stemcrtid,stemcrtdp,stemcrtdt,stemmodid,stemmoddt, 
                   stemcnfid,stemcnfdt) = (g_stem_m.stemsite,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
                   g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005,g_stem_m.stem004, 
                   g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
                   g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013, 
                   g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid, 
                   g_stem_m.stemcrtdp,g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
                   g_stem_m.stemcnfdt)
                WHERE stement = g_enterprise AND stemdocno = g_stemdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "stem_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #新增优惠执行情况和商户合作情况单身
               CALL astt802_ins_detail() RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL astt802_stem_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_stem_m_t)
               LET g_log2 = util.JSON.stringify(g_stem_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_stemdocno_t = g_stem_m.stemdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="astt802.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_sten_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sten_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL astt802_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_sten_d.getLength()
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
            OPEN astt802_cl USING g_enterprise,g_stem_m.stemdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN astt802_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE astt802_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_sten_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sten_d[l_ac].stenseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sten_d_t.* = g_sten_d[l_ac].*  #BACKUP
               LET g_sten_d_o.* = g_sten_d[l_ac].*  #BACKUP
               CALL astt802_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL astt802_set_no_entry_b(l_cmd)
               IF NOT astt802_lock_b("sten_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH astt802_bcl INTO g_sten_d[l_ac].stenacti,g_sten_d[l_ac].stenseq,g_sten_d[l_ac].sten001, 
                      g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007, 
                      g_sten_d[l_ac].sten012,g_sten_d[l_ac].sten005,g_sten_d[l_ac].sten009,g_sten_d[l_ac].sten011 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sten_d_t.stenseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sten_d_mask_o[l_ac].* =  g_sten_d[l_ac].*
                  CALL astt802_sten_t_mask()
                  LET g_sten_d_mask_n[l_ac].* =  g_sten_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL astt802_show()
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
            INITIALIZE g_sten_d[l_ac].* TO NULL 
            INITIALIZE g_sten_d_t.* TO NULL 
            INITIALIZE g_sten_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_sten_d[l_ac].stenacti = "Y"
      LET g_sten_d[l_ac].sten001 = "1"
      LET g_sten_d[l_ac].sten011 = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_sten_d_t.* = g_sten_d[l_ac].*     #新輸入資料
            LET g_sten_d_o.* = g_sten_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL astt802_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL astt802_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sten_d[li_reproduce_target].* = g_sten_d[li_reproduce].*
 
               LET g_sten_d[li_reproduce_target].stenseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(stenseq)+1 INTO g_sten_d[l_ac].stenseq
              FROM sten_t
             WHERE stenent = g_enterprise
               AND stendocno = g_stem_m.stemdocno
            IF cl_null(g_sten_d[l_ac].stenseq) THEN
               LET g_sten_d[l_ac].stenseq = 1
            END IF
#            LET g_sten_d[l_ac].stensite = g_stem_m.stemsite
#            LET g_sten_d[l_ac].stenunit = g_stem_m.stemunit
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
            SELECT COUNT(1) INTO l_count FROM sten_t 
             WHERE stenent = g_enterprise AND stendocno = g_stem_m.stemdocno
 
               AND stenseq = g_sten_d[l_ac].stenseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stem_m.stemdocno
               LET gs_keys[2] = g_sten_d[g_detail_idx].stenseq
               CALL astt802_insert_b('sten_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_sten_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL astt802_b_fill()
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
               LET gs_keys[01] = g_stem_m.stemdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_sten_d_t.stenseq
 
            
               #刪除同層單身
               IF NOT astt802_delete_b('sten_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt802_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT astt802_key_delete_b(gs_keys,'sten_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE astt802_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE astt802_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_sten_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sten_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stenacti
            #add-point:BEFORE FIELD stenacti name="input.b.page1.stenacti"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stenacti
            
            #add-point:AFTER FIELD stenacti name="input.a.page1.stenacti"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stenacti
            #add-point:ON CHANGE stenacti name="input.g.page1.stenacti"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stenseq
            #add-point:BEFORE FIELD stenseq name="input.b.page1.stenseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stenseq
            
            #add-point:AFTER FIELD stenseq name="input.a.page1.stenseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_stem_m.stemdocno IS NOT NULL AND g_sten_d[g_detail_idx].stenseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_stem_m.stemdocno != g_stemdocno_t OR g_sten_d[g_detail_idx].stenseq != g_sten_d_t.stenseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sten_t WHERE "||"stenent = '" ||g_enterprise|| "' AND "||"stendocno = '"||g_stem_m.stemdocno ||"' AND "|| "stenseq = '"||g_sten_d[g_detail_idx].stenseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stenseq
            #add-point:ON CHANGE stenseq name="input.g.page1.stenseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten001
            #add-point:BEFORE FIELD sten001 name="input.b.page1.sten001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten001
            
            #add-point:AFTER FIELD sten001 name="input.a.page1.sten001"
             #160512-00003#24 -s by 08172
            CALL astt802_set_no_entry_b(l_cmd)    
#            IF cl_null(g_sten_d[l_ac].sten001) AND g_sten_d[l_ac].sten001 != g_sten_d_t.sten001 OR cl_null(g_sten_d_t.sten001) THEN 
            IF cl_null(g_sten_d[l_ac].sten001) AND g_sten_d[l_ac].sten001 != g_sten_d_t.sten001 OR cl_null(g_sten_d_t.sten001) THEN  #170109-00031#1 add by 08172           
               LET g_sten_d[l_ac].sten005=''
               LET g_sten_d[l_ac].sten007=''
               LET g_sten_d[l_ac].sten012=''
            END IF #170109-00031#1 add by 08172
#            END IF 
            #160512-00003#24 -e by 08172
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten001
            #add-point:ON CHANGE sten001 name="input.g.page1.sten001"
            CALL astt802_set_no_entry_b(l_cmd)    #160512-00003#24
            #170109-00031#1 -s by 08172
            IF g_sten_d[l_ac].sten001 = '1' THEN
               LET g_sten_d[l_ac].sten005=''
               LET g_sten_d[l_ac].sten007=''
               LET g_sten_d[l_ac].sten012=''
            ELSE
               LET l_amount=0
               CALL astt802_discount(g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012)
                  RETURNING  l_amount
               LET g_sten_d[l_ac].sten005 = l_amount
               LET g_sten_d[l_ac].sten007=''
               LET g_sten_d[l_ac].sten012=''
            END IF
            #170109-00031#1 -e by 08172
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten002
            
            #add-point:AFTER FIELD sten002 name="input.a.page1.sten002"
            IF NOT cl_null(g_sten_d[l_ac].sten002) THEN
               #欄位存在檢查
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = g_sten_d[l_ac].sten002
#               CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_sten_d[l_ac].sten002_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_sten_d[l_ac].sten002_desc
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_sten_d[l_ac].sten002
               
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_stae001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_sten_d[l_ac].sten002 = ''
                  LET g_sten_d[l_ac].sten002_desc = ''
                  DISPLAY BY NAME g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten002_desc
                  NEXT FIELD sten002
               END IF
               #判断是否存在于合同对应费用明细档中
               IF NOT cl_null(g_stem_m.stem001) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM stjf_t
                   WHERE stjfent = g_enterprise
                     AND stjf001 = g_stem_m.stem001
                     AND stjf004 = g_sten_d[l_ac].sten002
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'ast-00630'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_sten_d[l_ac].sten002 = g_sten_d_t.sten002
                     LET g_sten_d[l_ac].sten002_desc = ''
                     DISPLAY BY NAME g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten002_Desc
                     NEXT FIELD sten002
                  END IF
               END IF
#               
#               IF NOT astt802_chk_sten002() THEN
#                  LET g_sten_d[l_ac].sten002 = g_sten_d_t.sten002                
#                  DISPLAY BY NAME g_sten_d[l_ac].sten002
#                  NEXT FIELD sten002
#               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sten_d[l_ac].sten002
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sten_d[l_ac].sten002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sten_d[l_ac].sten002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten002
            #add-point:BEFORE FIELD sten002 name="input.b.page1.sten002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten002
            #add-point:ON CHANGE sten002 name="input.g.page1.sten002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten003
            #add-point:BEFORE FIELD sten003 name="input.b.page1.sten003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten003
            
            #add-point:AFTER FIELD sten003 name="input.a.page1.sten003"
            IF NOT cl_null(g_sten_d[l_ac].sten003) THEN
               #日期必須在生失效日期範圍內
               IF g_sten_d[l_ac].sten003 < g_stem_m.stem011 OR g_sten_d[l_ac].sten003 > g_stem_m.stem010 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00668' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sten_d[l_ac].sten003 = g_sten_d_t.sten003
                  DISPLAY BY NAME g_sten_d[l_ac].sten003
                  NEXT FIELD sten003
               END IF
               #結束日期大於開始日期
               IF NOT cl_null(g_sten_d[l_ac].sten004) THEN
                  IF g_sten_d[l_ac].sten003 > g_sten_d[l_ac].sten004 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'amm-00080' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_sten_d[l_ac].sten003 = g_sten_d_t.sten003
                     DISPLAY BY NAME g_sten_d[l_ac].sten003
                     NEXT FIELD sten003
                  END IF
               END IF
#               IF NOT astt802_chk_sten002() THEN
#                  LET g_sten_d[l_ac].sten003 = g_sten_d_t.sten003
#                  DISPLAY BY NAME g_sten_d[l_ac].sten003
#                  NEXT FIELD sten003
#               END IF
            END IF
            #170109-00031#1 -s by 08172
            IF NOT cl_null(g_sten_d[l_ac].sten003) AND NOT cl_null(g_sten_d[l_ac].sten004) AND g_sten_d[l_ac].sten001 <> '1' THEN
               LET l_amount=0
               CALL astt802_discount(g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012)
                  RETURNING  l_amount
               LET g_sten_d[l_ac].sten005=l_amount
               DISPLAY BY NAME g_sten_d[l_ac].sten005
            END IF
            #170109-00031#1 -e by 08172
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten003
            #add-point:ON CHANGE sten003 name="input.g.page1.sten003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten004
            #add-point:BEFORE FIELD sten004 name="input.b.page1.sten004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten004
            
            #add-point:AFTER FIELD sten004 name="input.a.page1.sten004"
#            IF NOT cl_null(g_sten_d[l_ac].sten004) THEN    #160512-00003#24
            IF NOT cl_null(g_sten_d[l_ac].sten004) AND g_sten_d[l_ac].sten004!=g_sten_d_t.sten004 OR cl_null(g_sten_d_t.sten004) THEN #160512-00003#24
               #日期必須在生失效日期範圍內
               IF g_sten_d[l_ac].sten004 < g_stem_m.stem011 OR g_sten_d[l_ac].sten004 > g_stem_m.stem010 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00669' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sten_d[l_ac].sten004 = g_sten_d_t.sten004
                  DISPLAY BY NAME g_sten_d[l_ac].sten004
                  NEXT FIELD sten004
               END IF
               #結束日期大於開始日期
               IF NOT cl_null(g_sten_d[l_ac].sten003) THEN
                  IF g_sten_d[l_ac].sten003 > g_sten_d[l_ac].sten004 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = 'amm-00080' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_sten_d[l_ac].sten004 = g_sten_d_t.sten004
                     DISPLAY BY NAME g_sten_d[l_ac].sten004
                     NEXT FIELD sten004
                  END IF
               END IF
               IF NOT astt802_chk_sten002() THEN
                  LET g_sten_d[l_ac].sten003 = ''
                  LET g_sten_d[l_ac].sten004 = ''
                  DISPLAY BY NAME g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004
                  NEXT FIELD sten003
               END IF
               #160512-00003#24 -s
               IF g_sten_d[l_ac].sten001 <> '1' THEN  #170109-00031#1 add by 08172
                  LET l_amount=0
                  CALL astt802_discount(g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012)
                     RETURNING  l_amount
                  LET g_sten_d[l_ac].sten005=l_amount
                  DISPLAY BY NAME g_sten_d[l_ac].sten005
               END IF   #170109-00031#1 add by 08172
               #160512-00003#24 -e
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten004
            #add-point:ON CHANGE sten004 name="input.g.page1.sten004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten007
            #add-point:BEFORE FIELD sten007 name="input.b.page1.sten007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten007
            
            #add-point:AFTER FIELD sten007 name="input.a.page1.sten007"
            IF NOT cl_null(g_sten_d[l_ac].sten007) THEN 
               #160810-00030#1 -s by 08172
               IF g_sten_d[l_ac].sten007 = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00834' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sten_d[l_ac].sten007 = g_sten_d_t.sten007
                  DISPLAY BY NAME g_sten_d[l_ac].sten007
                  NEXT FIELD sten007
               END IF 
               #160810-00030#1 -s by 08172
               #160512-00003#24 -s by 08172
               LET l_amount=0
               CALL astt802_discount(g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012)
                  RETURNING  l_amount
               LET g_sten_d[l_ac].sten005=l_amount
               DISPLAY BY NAME g_sten_d[l_ac].sten005
               #160512-00003#24 -e by 08172
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten007
            #add-point:ON CHANGE sten007 name="input.g.page1.sten007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten012
            #add-point:BEFORE FIELD sten012 name="input.b.page1.sten012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten012
            
            #add-point:AFTER FIELD sten012 name="input.a.page1.sten012"
            IF NOT cl_null(g_sten_d[l_ac].sten012) THEN 
               #160810-00030#1 -s by 08172
               IF g_sten_d[l_ac].sten012 = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'ast-00835' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET g_sten_d[l_ac].sten012 = g_sten_d_t.sten012
                  DISPLAY BY NAME g_sten_d[l_ac].sten012
                  NEXT FIELD sten012
               END IF 
               #160810-00030#1 -s by 08172
               #160512-00003#24 -s by 08172
               LET l_amount=0
               CALL astt802_discount(g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004,g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012)
                  RETURNING  l_amount
               LET g_sten_d[l_ac].sten005=l_amount
               DISPLAY BY NAME g_sten_d[l_ac].sten005
               #160512-00003#24 -e  by 08172 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten012
            #add-point:ON CHANGE sten012 name="input.g.page1.sten012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten005
            #add-point:BEFORE FIELD sten005 name="input.b.page1.sten005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten005
            
            #add-point:AFTER FIELD sten005 name="input.a.page1.sten005"
        
            IF g_sten_d[l_ac].sten005 = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ast-00705' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_sten_d[l_ac].sten005 = g_sten_d_t.sten005
            
               NEXT FIELD sten005
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten005
            #add-point:ON CHANGE sten005 name="input.g.page1.sten005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten009
            
            #add-point:AFTER FIELD sten009 name="input.a.page1.sten009"
            IF NOT cl_null(g_sten_d[l_ac].sten009) THEN
               
               IF NOT s_azzi650_chk_exist('2132',g_sten_d[l_ac].sten009) THEN
                  LET g_sten_d[l_ac].sten009 = g_sten_d_t.sten009
                  LET g_sten_d[l_ac].sten009_desc = ''
                  DISPLAY BY NAME g_sten_d[l_ac].sten009,g_sten_d[l_ac].sten009_desc
                  NEXT FIELD sten009
               END IF
            END IF
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sten_d[l_ac].sten009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2132' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sten_d[l_ac].sten009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sten_d[l_ac].sten009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten009
            #add-point:BEFORE FIELD sten009 name="input.b.page1.sten009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten009
            #add-point:ON CHANGE sten009 name="input.g.page1.sten009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sten011
            #add-point:BEFORE FIELD sten011 name="input.b.page1.sten011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sten011
            
            #add-point:AFTER FIELD sten011 name="input.a.page1.sten011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sten011
            #add-point:ON CHANGE sten011 name="input.g.page1.sten011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.stenacti
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stenacti
            #add-point:ON ACTION controlp INFIELD stenacti name="input.c.page1.stenacti"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.stenseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stenseq
            #add-point:ON ACTION controlp INFIELD stenseq name="input.c.page1.stenseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten001
            #add-point:ON ACTION controlp INFIELD sten001 name="input.c.page1.sten001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten002
            #add-point:ON ACTION controlp INFIELD sten002 name="input.c.page1.sten002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sten_d[l_ac].sten002             #給予default值
#            LET g_qryparam.default2 = g_sten_d[l_ac].sten002_desc #費用編號
#            #給予arg
#            LET g_qryparam.arg1 = g_stem_m.stem001
            IF NOT cl_null(g_stem_m.stem001) THEN
               LET g_qryparam.where=" stae001 IN  (SELECT stjf004 FROM stjf_t WHERE stjfent ='" ,g_enterprise ,"' AND stjf001='",g_stem_m.stem001,"' )"
            END IF
            CALL q_stae001_4()                                #呼叫開窗

            LET g_sten_d[l_ac].sten002 = g_qryparam.return1              
#            LET g_sten_d[l_ac].sten002_desc = g_qryparam.return2 
            DISPLAY g_sten_d[l_ac].sten002 TO sten002              #
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sten_d[l_ac].sten002
            CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sten_d[l_ac].sten002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sten_d[l_ac].sten002_desc
#            DISPLAY g_sten_d[l_ac].sten002_desc TO sten002_desc #費用編號
            NEXT FIELD sten002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.sten003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten003
            #add-point:ON ACTION controlp INFIELD sten003 name="input.c.page1.sten003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten004
            #add-point:ON ACTION controlp INFIELD sten004 name="input.c.page1.sten004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten007
            #add-point:ON ACTION controlp INFIELD sten007 name="input.c.page1.sten007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten012
            #add-point:ON ACTION controlp INFIELD sten012 name="input.c.page1.sten012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten005
            #add-point:ON ACTION controlp INFIELD sten005 name="input.c.page1.sten005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.sten009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten009
            #add-point:ON ACTION controlp INFIELD sten009 name="input.c.page1.sten009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sten_d[l_ac].sten009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "2132" #s


            CALL q_oocq002_4()                                #呼叫開窗

            LET g_sten_d[l_ac].sten009 = g_qryparam.return1              
            CALL s_desc_get_acc_desc('2132',g_sten_d[l_ac].sten009) RETURNING g_sten_d[l_ac].sten009_desc

            DISPLAY g_sten_d[l_ac].sten009 TO sten009              #
            DISPLAY g_sten_d[l_ac].sten009_desc TO sten009_desc

            NEXT FIELD sten009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.sten011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sten011
            #add-point:ON ACTION controlp INFIELD sten011 name="input.c.page1.sten011"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_sten_d[l_ac].* = g_sten_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE astt802_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_sten_d[l_ac].stenseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_sten_d[l_ac].* = g_sten_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL astt802_sten_t_mask_restore('restore_mask_o')
      
               UPDATE sten_t SET (stendocno,stenacti,stenseq,sten001,sten002,sten003,sten004,sten007, 
                   sten012,sten005,sten009,sten011) = (g_stem_m.stemdocno,g_sten_d[l_ac].stenacti,g_sten_d[l_ac].stenseq, 
                   g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004, 
                   g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012,g_sten_d[l_ac].sten005,g_sten_d[l_ac].sten009, 
                   g_sten_d[l_ac].sten011)
                WHERE stenent = g_enterprise AND stendocno = g_stem_m.stemdocno 
 
                  AND stenseq = g_sten_d_t.stenseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_sten_d[l_ac].* = g_sten_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sten_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_sten_d[l_ac].* = g_sten_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_stem_m.stemdocno
               LET gs_keys_bak[1] = g_stemdocno_t
               LET gs_keys[2] = g_sten_d[g_detail_idx].stenseq
               LET gs_keys_bak[2] = g_sten_d_t.stenseq
               CALL astt802_update_b('sten_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL astt802_sten_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_sten_d[g_detail_idx].stenseq = g_sten_d_t.stenseq 
 
                  ) THEN
                  LET gs_keys[01] = g_stem_m.stemdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_sten_d_t.stenseq
 
                  CALL astt802_key_update_b(gs_keys,'sten_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_stem_m),util.JSON.stringify(g_sten_d_t)
               LET g_log2 = util.JSON.stringify(g_stem_m),util.JSON.stringify(g_sten_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            #add by geza 20160623 #160604-00009#33(S)
            LET l_stem018 = 0
            SELECT SUM(sten005) INTO l_stem018
              FROM sten_t
             WHERE stenent = g_enterprise 
               AND stendocno = g_stem_m.stemdocno
             
            IF cl_null(l_stem018) THEN
                LET l_stem018 = 0
            END IF
            UPDATE stem_t SET stem018 = l_stem018 
             WHERE stement = g_enterprise 
               AND stemdocno = g_stem_m.stemdocno
            SELECT stem018 INTO g_stem_m.stem018
              FROM stem_t
             WHERE stement = g_enterprise 
               AND stemdocno = g_stem_m.stemdocno             
            DISPLAY BY NAME g_stem_m.stem018
            #add by geza 20160623 #160604-00009#33(E)
            #end add-point
            CALL astt802_unlock_b("sten_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            LET g_bfill = 'N'
            CALL astt802_show()
            LET g_bfill = 'Y'
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_sten_d[li_reproduce_target].* = g_sten_d[li_reproduce].*
 
               LET g_sten_d[li_reproduce_target].stenseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sten_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sten_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
      DISPLAY ARRAY g_sten2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL astt802_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
            
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL astt802_idx_chk()
            LET g_current_page = 2
      
         #add-point:page2自定義行為 name="input.body2.action"
         CALL astt802_detail_show()
         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_sten3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW
            CALL astt802_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx = l_ac
            
            #add-point:page3, before row動作 name="input.body3.before_row"
            CALL astt802_detail_show()
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'm'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL astt802_idx_chk()
            LET g_current_page = 3
      
         #add-point:page3自定義行為 name="input.body3.action"
         
         #end add-point
      
      END DISPLAY
 
 
 
{</section>}
 
{<section id="astt802.input.other" >}
      
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
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD stemsite
            #end add-point  
            NEXT FIELD stemdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD stenacti
               WHEN "s_detail2"
                  NEXT FIELD steoseq
               WHEN "s_detail3"
                  NEXT FIELD stepseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
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
         LET g_detail_idx_list[3] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
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
 
{<section id="astt802.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION astt802_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL astt802_b_fill() #單身填充
      CALL astt802_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL astt802_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_stem_m_mask_o.* =  g_stem_m.*
   CALL astt802_stem_t_mask()
   LET g_stem_m_mask_n.* =  g_stem_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
       g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem002_desc,g_stem_m.stem003,g_stem_m.stem003_desc, 
       g_stem_m.stem005,g_stem_m.stem005_desc,g_stem_m.stem004,g_stem_m.stem004_desc,g_stem_m.stem006, 
       g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018, 
       g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem012_desc,g_stem_m.stem013,g_stem_m.stem013_desc, 
       g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemownid_desc,g_stem_m.stemowndp, 
       g_stem_m.stemowndp_desc,g_stem_m.stemcrtid,g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp,g_stem_m.stemcrtdp_desc, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmodid_desc,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
       g_stem_m.stemcnfid_desc,g_stem_m.stemcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stem_m.stemstus 
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
   FOR l_ac = 1 TO g_sten_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_sten2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_sten3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL astt802_detail_show()
 
   #add-point:show段之後 name="show.after"
   #160512-00003#24 -s
   SELECT SUM(sten005) INTO g_stem_m.stem018
     FROM sten_t
    WHERE stenent = g_enterprise 
      AND stendocno = g_stem_m.stemdocno
   
   IF cl_null(g_stem_m.stem018) THEN
      LET g_stem_m.stem018 = 0
      DISPLAY BY NAME g_stem_m.stem018
   END IF
   
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem018,'1')
            RETURNING g_stem_m.stem018
   DISPLAY BY NAME g_stem_m.stem018
   #160512-00003#24 -e
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION astt802_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
#   SELECT steoseq,steo002,steo003,steo004,steo005,steo006,steo007,steo008,steo009
#   INTO g_sten2_d[l_ac].steoseq,g_sten2_d[l_ac].steo002,g_sten2_d[l_ac].steo003,g_sten2_d[l_ac].steo004,
#        g_sten2_d[l_ac].steo005,g_sten2_d[l_ac].steo006,g_sten2_d[l_ac].steo007,g_sten2_d[l_ac].steo008,
#        g_sten2_d[l_ac].steo009
#   FROM steo_p
#   WHERE steoent = g_enterprise AND steodocno = g_stem_m.stemdocno
#   DISPLAY BY NAME g_sten2_d[l_ac].steoseq,g_sten2_d[l_ac].steo002,g_sten2_d[l_ac].steo003,g_sten2_d[l_ac].steo004,
#                   g_sten2_d[l_ac].steo005,g_sten2_d[l_ac].steo006,g_sten2_d[l_ac].steo007,g_sten2_d[l_ac].steo008,
#                   g_sten2_d[l_ac].steo009
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_sten2_d[l_ac].steo003
#   CALL ap_ref_array2(g_ref_fields,"SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , '' 
#   DISPLAY BY NAME g_sten2_d[l_ac].steo003_desc
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] ='2132'
#   LET g_ref_fields[2] = g_sten2_d[l_ac].steo007
#   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , '' 
#   DISPLAY BY NAME g_sten2_d[l_ac].steo007_desc
#  
#   SELECT stepseq,step001,step002,step003,step004,step005,step006,step007,step008
#   INTO g_sten3_d[l_ac].stepseq,g_sten3_d[l_ac].step001,g_sten3_d[l_ac].step002,g_sten3_d[l_ac].step003,
#        g_sten3_d[l_ac].step004,g_sten3_d[l_ac].step005,g_sten3_d[l_ac].step006,g_sten3_d[l_ac].step007,
#        g_sten3_d[l_ac].step008
#   FROM step_t
#   WHERE stePent = g_enterprise AND stepdocno = g_stem_m.stemdocno
#   DISPLAY BY NAME g_sten3_d[l_ac].stepseq,g_sten3_d[l_ac].step001,g_sten3_d[l_ac].step002,g_sten3_d[l_ac].step003,
#                   g_sten3_d[l_ac].step004,g_sten3_d[l_ac].step005,g_sten3_d[l_ac].step006,g_sten3_d[l_ac].step007,
#                   g_sten3_d[l_ac].step008
#                   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_sten3_d[l_ac].step001
#   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , '' 
#   DISPLAY BY NAME g_sten3_d[l_ac].step001_desc
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_sten3_d[l_ac].step001
#   LET g_ref_fields[2] = g_sten3_d[l_ac].step002
#   CALL ap_ref_array2(g_ref_fields,"SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhaelsite=? AND mhael001=? AND mhael022='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , '' 
#   DISPLAY BY NAME g_sten3_d[l_ac].step002_desc
#   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_sten3_d[l_ac].step007
#   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , '' 
#   DISPLAY BY NAME g_sten3_d[l_ac].step007_desc
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION astt802_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE stem_t.stemdocno 
   DEFINE l_oldno     LIKE stem_t.stemdocno 
 
   DEFINE l_master    RECORD LIKE stem_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE sten_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE steo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE step_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_stem_m.stemdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_stemdocno_t = g_stem_m.stemdocno
 
    
   LET g_stem_m.stemdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_stem_m.stemownid = g_user
      LET g_stem_m.stemowndp = g_dept
      LET g_stem_m.stemcrtid = g_user
      LET g_stem_m.stemcrtdp = g_dept 
      LET g_stem_m.stemcrtdt = cl_get_current()
      LET g_stem_m.stemmodid = g_user
      LET g_stem_m.stemmoddt = cl_get_current()
      LET g_stem_m.stemstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_stem_m.stemstus 
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
   
   
   CALL astt802_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_stem_m.* TO NULL
      INITIALIZE g_sten_d TO NULL
      INITIALIZE g_sten2_d TO NULL
      INITIALIZE g_sten3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL astt802_show()
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
   CALL astt802_set_act_visible()   
   CALL astt802_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_stemdocno_t = g_stem_m.stemdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " stement = " ||g_enterprise|| " AND",
                      " stemdocno = '", g_stem_m.stemdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL astt802_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL astt802_idx_chk()
   
   LET g_data_owner = g_stem_m.stemownid      
   LET g_data_dept  = g_stem_m.stemowndp
   
   #功能已完成,通報訊息中心
   CALL astt802_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION astt802_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sten_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE steo_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE step_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE astt802_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sten_t
    WHERE stenent = g_enterprise AND stendocno = g_stemdocno_t
 
    INTO TEMP astt802_detail
 
   #將key修正為調整後   
   UPDATE astt802_detail 
      #更新key欄位
      SET stendocno = g_stem_m.stemdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO sten_t SELECT * FROM astt802_detail
   
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
   DROP TABLE astt802_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM steo_t 
    WHERE steoent = g_enterprise AND steodocno = g_stemdocno_t
 
    INTO TEMP astt802_detail
 
   #將key修正為調整後   
   UPDATE astt802_detail SET steodocno = g_stem_m.stemdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO steo_t SELECT * FROM astt802_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astt802_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM step_t 
    WHERE stepent = g_enterprise AND stepdocno = g_stemdocno_t
 
    INTO TEMP astt802_detail
 
   #將key修正為調整後   
   UPDATE astt802_detail SET stepdocno = g_stem_m.stemdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO step_t SELECT * FROM astt802_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE astt802_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_stemdocno_t = g_stem_m.stemdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.delete" >}
#+ 資料刪除
PRIVATE FUNCTION astt802_delete()
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
   
   IF g_stem_m.stemdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN astt802_cl USING g_enterprise,g_stem_m.stemdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt802_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT astt802_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_stem_m_mask_o.* =  g_stem_m.*
   CALL astt802_stem_t_mask()
   LET g_stem_m_mask_n.* =  g_stem_m.*
   
   CALL astt802_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF NOT s_aooi200_del_docno(g_stem_m.stemdocno,g_stem_m.stemdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL astt802_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_stemdocno_t = g_stem_m.stemdocno
 
 
      DELETE FROM stem_t
       WHERE stement = g_enterprise AND stemdocno = g_stem_m.stemdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_stem_m.stemdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #170105-00005#1 -s by 08172 mark
#      IF NOT s_aooi200_del_docno(g_stem_m.stemdocno,g_stem_m.stemdocdt) THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF
      #170105-00005#1 -e by 08172 mark
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM sten_t
       WHERE stenent = g_enterprise AND stendocno = g_stem_m.stemdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
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
      DELETE FROM steo_t
       WHERE steoent = g_enterprise AND
             steodocno = g_stem_m.stemdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "steo_t:",SQLERRMESSAGE 
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
      DELETE FROM step_t
       WHERE stepent = g_enterprise AND
             stepdocno = g_stem_m.stemdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "step_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_stem_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE astt802_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_sten_d.clear() 
      CALL g_sten2_d.clear()       
      CALL g_sten3_d.clear()       
 
     
      CALL astt802_ui_browser_refresh()  
      #CALL astt802_ui_headershow()  
      #CALL astt802_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL astt802_browser_fill("")
         CALL astt802_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE astt802_cl
 
   #功能已完成,通報訊息中心
   CALL astt802_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="astt802.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt802_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_sten_d.clear()
   CALL g_sten2_d.clear()
   CALL g_sten3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF astt802_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stenacti,stenseq,sten001,sten002,sten003,sten004,sten007,sten012, 
             sten005,sten009,sten011 ,t1.stael003 ,t2.oocql004 FROM sten_t",   
                     " INNER JOIN stem_t ON stement = " ||g_enterprise|| " AND stemdocno = stendocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN stael_t t1 ON t1.staelent="||g_enterprise||" AND t1.stael001=sten002 AND t1.stael002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='2132' AND t2.oocql002=sten009 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE stenent=? AND stendocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sten_t.stenseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt802_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR astt802_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_stem_m.stemdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_stem_m.stemdocno INTO g_sten_d[l_ac].stenacti,g_sten_d[l_ac].stenseq, 
          g_sten_d[l_ac].sten001,g_sten_d[l_ac].sten002,g_sten_d[l_ac].sten003,g_sten_d[l_ac].sten004, 
          g_sten_d[l_ac].sten007,g_sten_d[l_ac].sten012,g_sten_d[l_ac].sten005,g_sten_d[l_ac].sten009, 
          g_sten_d[l_ac].sten011,g_sten_d[l_ac].sten002_desc,g_sten_d[l_ac].sten009_desc   #(ver:78) 
 
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
   IF astt802_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT steoseq,steo001,steo002,steo003,steo004,steo005,steo006,steo007, 
             steo008,steo009 ,t3.stael003 ,t4.oocql004 FROM steo_t",   
                     " INNER JOIN  stem_t ON stement = " ||g_enterprise|| " AND stemdocno = steodocno ",
 
                     "",
                     
                                    " LEFT JOIN stael_t t3 ON t3.staelent="||g_enterprise||" AND t3.stael001=steo003 AND t3.stael002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2132' AND t4.oocql002=steo007 AND t4.oocql003='"||g_dlang||"' ",
 
                     " WHERE steoent=? AND steodocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY steo_t.steoseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt802_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR astt802_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_stem_m.stemdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_stem_m.stemdocno INTO g_sten2_d[l_ac].steoseq,g_sten2_d[l_ac].steo001, 
          g_sten2_d[l_ac].steo002,g_sten2_d[l_ac].steo003,g_sten2_d[l_ac].steo004,g_sten2_d[l_ac].steo005, 
          g_sten2_d[l_ac].steo006,g_sten2_d[l_ac].steo007,g_sten2_d[l_ac].steo008,g_sten2_d[l_ac].steo009, 
          g_sten2_d[l_ac].steo003_desc,g_sten2_d[l_ac].steo007_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
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
   IF astt802_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT stepseq,step001,step002,step003,step004,step005,step006,step007, 
             step008 ,t5.ooefl003 ,t6.mhbel003 ,t7.rtaxl003 FROM step_t",   
                     " INNER JOIN  stem_t ON stement = " ||g_enterprise|| " AND stemdocno = stepdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=step001 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN mhbel_t t6 ON t6.mhbelent="||g_enterprise||" AND t6.mhbel001=step002 AND t6.mhbel002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t7 ON t7.rtaxlent="||g_enterprise||" AND t7.rtaxl001=step007 AND t7.rtaxl002='"||g_dlang||"' ",
 
                     " WHERE stepent=? AND stepdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY step_t.stepseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE astt802_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR astt802_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_stem_m.stemdocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_stem_m.stemdocno INTO g_sten3_d[l_ac].stepseq,g_sten3_d[l_ac].step001, 
          g_sten3_d[l_ac].step002,g_sten3_d[l_ac].step003,g_sten3_d[l_ac].step004,g_sten3_d[l_ac].step005, 
          g_sten3_d[l_ac].step006,g_sten3_d[l_ac].step007,g_sten3_d[l_ac].step008,g_sten3_d[l_ac].step001_desc, 
          g_sten3_d[l_ac].step002_desc,g_sten3_d[l_ac].step007_desc   #(ver:78)
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
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_sten_d.deleteElement(g_sten_d.getLength())
   CALL g_sten2_d.deleteElement(g_sten2_d.getLength())
   CALL g_sten3_d.deleteElement(g_sten3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE astt802_pb
   FREE astt802_pb2
 
   FREE astt802_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_sten_d.getLength()
      LET g_sten_d_mask_o[l_ac].* =  g_sten_d[l_ac].*
      CALL astt802_sten_t_mask()
      LET g_sten_d_mask_n[l_ac].* =  g_sten_d[l_ac].*
   END FOR
   
   LET g_sten2_d_mask_o.* =  g_sten2_d.*
   FOR l_ac = 1 TO g_sten2_d.getLength()
      LET g_sten2_d_mask_o[l_ac].* =  g_sten2_d[l_ac].*
      CALL astt802_steo_t_mask()
      LET g_sten2_d_mask_n[l_ac].* =  g_sten2_d[l_ac].*
   END FOR
   LET g_sten3_d_mask_o.* =  g_sten3_d.*
   FOR l_ac = 1 TO g_sten3_d.getLength()
      LET g_sten3_d_mask_o[l_ac].* =  g_sten3_d[l_ac].*
      CALL astt802_step_t_mask()
      LET g_sten3_d_mask_n[l_ac].* =  g_sten3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION astt802_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM sten_t
       WHERE stenent = g_enterprise AND
         stendocno = ps_keys_bak[1] AND stenseq = ps_keys_bak[2]
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
         CALL g_sten_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM steo_t
       WHERE steoent = g_enterprise AND
             steodocno = ps_keys_bak[1] AND steoseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "steo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sten2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM step_t
       WHERE stepent = g_enterprise AND
             stepdocno = ps_keys_bak[1] AND stepseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "step_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_sten3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION astt802_insert_b(ps_table,ps_keys,ps_page)
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
   CALL cl_set_act_visible("sten007,sten011", FALSE)
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO sten_t
                  (stenent,
                   stendocno,
                   stenseq
                   ,stenacti,sten001,sten002,sten003,sten004,sten007,sten012,sten005,sten009,sten011) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sten_d[g_detail_idx].stenacti,g_sten_d[g_detail_idx].sten001,g_sten_d[g_detail_idx].sten002, 
                       g_sten_d[g_detail_idx].sten003,g_sten_d[g_detail_idx].sten004,g_sten_d[g_detail_idx].sten007, 
                       g_sten_d[g_detail_idx].sten012,g_sten_d[g_detail_idx].sten005,g_sten_d[g_detail_idx].sten009, 
                       g_sten_d[g_detail_idx].sten011)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_sten_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO steo_t
                  (steoent,
                   steodocno,
                   steoseq
                   ,steo001,steo002,steo003,steo004,steo005,steo006,steo007,steo008,steo009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sten2_d[g_detail_idx].steo001,g_sten2_d[g_detail_idx].steo002,g_sten2_d[g_detail_idx].steo003, 
                       g_sten2_d[g_detail_idx].steo004,g_sten2_d[g_detail_idx].steo005,g_sten2_d[g_detail_idx].steo006, 
                       g_sten2_d[g_detail_idx].steo007,g_sten2_d[g_detail_idx].steo008,g_sten2_d[g_detail_idx].steo009) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "steo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sten2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO step_t
                  (stepent,
                   stepdocno,
                   stepseq
                   ,step001,step002,step003,step004,step005,step006,step007,step008) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_sten3_d[g_detail_idx].step001,g_sten3_d[g_detail_idx].step002,g_sten3_d[g_detail_idx].step003, 
                       g_sten3_d[g_detail_idx].step004,g_sten3_d[g_detail_idx].step005,g_sten3_d[g_detail_idx].step006, 
                       g_sten3_d[g_detail_idx].step007,g_sten3_d[g_detail_idx].step008)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "step_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_sten3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION astt802_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sten_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL astt802_sten_t_mask_restore('restore_mask_o')
               
      UPDATE sten_t 
         SET (stendocno,
              stenseq
              ,stenacti,sten001,sten002,sten003,sten004,sten007,sten012,sten005,sten009,sten011) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sten_d[g_detail_idx].stenacti,g_sten_d[g_detail_idx].sten001,g_sten_d[g_detail_idx].sten002, 
                  g_sten_d[g_detail_idx].sten003,g_sten_d[g_detail_idx].sten004,g_sten_d[g_detail_idx].sten007, 
                  g_sten_d[g_detail_idx].sten012,g_sten_d[g_detail_idx].sten005,g_sten_d[g_detail_idx].sten009, 
                  g_sten_d[g_detail_idx].sten011) 
         WHERE stenent = g_enterprise AND stendocno = ps_keys_bak[1] AND stenseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sten_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sten_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt802_sten_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "steo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL astt802_steo_t_mask_restore('restore_mask_o')
               
      UPDATE steo_t 
         SET (steodocno,
              steoseq
              ,steo001,steo002,steo003,steo004,steo005,steo006,steo007,steo008,steo009) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sten2_d[g_detail_idx].steo001,g_sten2_d[g_detail_idx].steo002,g_sten2_d[g_detail_idx].steo003, 
                  g_sten2_d[g_detail_idx].steo004,g_sten2_d[g_detail_idx].steo005,g_sten2_d[g_detail_idx].steo006, 
                  g_sten2_d[g_detail_idx].steo007,g_sten2_d[g_detail_idx].steo008,g_sten2_d[g_detail_idx].steo009)  
 
         WHERE steoent = g_enterprise AND steodocno = ps_keys_bak[1] AND steoseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "steo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "steo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt802_steo_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "step_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL astt802_step_t_mask_restore('restore_mask_o')
               
      UPDATE step_t 
         SET (stepdocno,
              stepseq
              ,step001,step002,step003,step004,step005,step006,step007,step008) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_sten3_d[g_detail_idx].step001,g_sten3_d[g_detail_idx].step002,g_sten3_d[g_detail_idx].step003, 
                  g_sten3_d[g_detail_idx].step004,g_sten3_d[g_detail_idx].step005,g_sten3_d[g_detail_idx].step006, 
                  g_sten3_d[g_detail_idx].step007,g_sten3_d[g_detail_idx].step008) 
         WHERE stepent = g_enterprise AND stepdocno = ps_keys_bak[1] AND stepseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "step_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "step_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL astt802_step_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION astt802_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="astt802.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION astt802_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="astt802.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION astt802_lock_b(ps_table,ps_page)
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
   #CALL astt802_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "sten_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN astt802_bcl USING g_enterprise,
                                       g_stem_m.stemdocno,g_sten_d[g_detail_idx].stenseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt802_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "steo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt802_bcl2 USING g_enterprise,
                                             g_stem_m.stemdocno,g_sten2_d[g_detail_idx].steoseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt802_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "step_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN astt802_bcl3 USING g_enterprise,
                                             g_stem_m.stemdocno,g_sten3_d[g_detail_idx].stepseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "astt802_bcl3:",SQLERRMESSAGE 
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
 
{<section id="astt802.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION astt802_unlock_b(ps_table,ps_page)
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
      CLOSE astt802_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt802_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE astt802_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION astt802_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("stemdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("stemdocno",TRUE)
      CALL cl_set_comp_entry("stemdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("stemsite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("stem001",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION astt802_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("stemdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("stemsite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("stemdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("stemdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'stemsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("stemsite",FALSE)
   END IF
   IF p_cmd = 'u' THEN
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM sten_t
       WHERE stenent = g_enterprise
         AND stendocno = g_stem_m.stemdocno
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("stem001",FALSE)
      END IF
      IF cl_null(g_stem_m.stem001) THEN
         CALL cl_set_comp_entry("stem002,stem003",FALSE)
      ELSE
         CALL cl_set_comp_entry("stem001",FALSE)
      END IF
   END IF
   IF p_cmd = 'a' THEN
      IF NOT cl_null(g_stem_m.stem001) THEN
         CALL cl_set_comp_entry("stem002,stem003,stem009,stem010,stem011",FALSE)
      ELSE
         CALL cl_set_comp_entry("stem002,stem003,stem009,stem010,stem011",TRUE)
      END IF
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION astt802_set_entry_b(p_cmd)
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
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION astt802_set_no_entry_b(p_cmd)
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
   #160512-00003#24 -s by 08172
      CASE g_sten_d[l_ac].sten001
         WHEN '1' CALL cl_set_comp_entry('sten005',TRUE)
                  CALL cl_set_comp_entry('sten007,sten012',FALSE)
         WHEN '2' CALL cl_set_comp_entry('sten012',TRUE)
                  CALL cl_set_comp_entry('sten005,sten007',FALSE)
         WHEN '3' CALL cl_set_comp_entry('sten005,sten007,sten012',FALSE)
         WHEN '4' CALL cl_set_comp_entry('sten007',TRUE)
                  CALL cl_set_comp_entry('sten005,sten012',FALSE)
      END CASE
   #160512-00003#24 -e
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION astt802_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION astt802_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_stem_m.stemstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION astt802_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt802.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION astt802_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="astt802.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION astt802_default_search()
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
      LET ls_wc = ls_wc, " stemdocno = '", g_argv[01], "' AND "
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
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "stem_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sten_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "steo_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "step_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
 
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
 
{<section id="astt802.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION astt802_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_stem_m.stemdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN astt802_cl USING g_enterprise,g_stem_m.stemdocno
   IF STATUS THEN
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN astt802_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
       g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
       g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
       g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
       g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
       g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
       g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid_desc, 
       g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT astt802_action_chk() THEN
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc,g_stem_m.stemdocdt,g_stem_m.stemdocno,g_stem_m.stem001, 
       g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem002_desc,g_stem_m.stem003,g_stem_m.stem003_desc, 
       g_stem_m.stem005,g_stem_m.stem005_desc,g_stem_m.stem004,g_stem_m.stem004_desc,g_stem_m.stem006, 
       g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011,g_stem_m.stem018, 
       g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem012_desc,g_stem_m.stem013,g_stem_m.stem013_desc, 
       g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemownid_desc,g_stem_m.stemowndp, 
       g_stem_m.stemowndp_desc,g_stem_m.stemcrtid,g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp,g_stem_m.stemcrtdp_desc, 
       g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmodid_desc,g_stem_m.stemmoddt,g_stem_m.stemcnfid, 
       g_stem_m.stemcnfid_desc,g_stem_m.stemcnfdt
 
   CASE g_stem_m.stemstus
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
         CASE g_stem_m.stemstus
            
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
      CASE g_stem_m.stemstus
          WHEN "N"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)
         WHEN "X"
            HIDE OPTION "open"
            HIDE OPTION "valid"
            CALL s_transaction_end('N','0')   #160816-00068#1
            RETURN
         WHEN "Y"
            HIDE OPTION "void"
            HIDE OPTION "invalid"  #add by geza 20160810 #160809-00026#1
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT astt802_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt802_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT astt802_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE astt802_cl
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
      g_stem_m.stemstus = lc_state OR cl_null(lc_state) THEN
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         CALL cl_err_collect_init()
         CALL s_astt802_conf_chk(g_stem_m.stemdocno,g_stem_m.stemstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_astt802_conf_upd(g_stem_m.stemdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stem_m.stemdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#1
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#1
            RETURN
         END IF
      WHEN lc_state = 'X'
         CALL cl_err_collect_init()
         CALL s_astt802_void_chk(g_stem_m.stemdocno,g_stem_m.stemstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_begin()
               CALL s_astt802_void_upd(g_stem_m.stemdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stem_m.stemdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#1
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#1
            RETURN
         END IF
      WHEN lc_state = 'N'
         CALL cl_err_collect_init()
         CALL s_astt802_unconf_chk(g_stem_m.stemdocno,g_stem_m.stemstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_begin()
               CALL s_astt802_unconf_upd(g_stem_m.stemdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_stem_m.stemdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#1
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#1
            RETURN
         END IF
      OTHERWISE
         CALL s_transaction_end('N','0')   #160816-00068#1
         RETURN
   END CASE                 {#ADP版次:1#}  
   #end add-point
   
   LET g_stem_m.stemmodid = g_user
   LET g_stem_m.stemmoddt = cl_get_current()
   LET g_stem_m.stemstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE stem_t 
      SET (stemstus,stemmodid,stemmoddt) 
        = (g_stem_m.stemstus,g_stem_m.stemmodid,g_stem_m.stemmoddt)     
    WHERE stement = g_enterprise AND stemdocno = g_stem_m.stemdocno
 
    
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
      EXECUTE astt802_master_referesh USING g_stem_m.stemdocno INTO g_stem_m.stemsite,g_stem_m.stemdocdt, 
          g_stem_m.stemdocno,g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005, 
          g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010, 
          g_stem_m.stem011,g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem013,g_stem_m.stem034, 
          g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemowndp,g_stem_m.stemcrtid,g_stem_m.stemcrtdp, 
          g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmoddt,g_stem_m.stemcnfid,g_stem_m.stemcnfdt, 
          g_stem_m.stemsite_desc,g_stem_m.stem002_desc,g_stem_m.stem003_desc,g_stem_m.stem005_desc,g_stem_m.stem004_desc, 
          g_stem_m.stem012_desc,g_stem_m.stem013_desc,g_stem_m.stemownid_desc,g_stem_m.stemowndp_desc, 
          g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp_desc,g_stem_m.stemmodid_desc,g_stem_m.stemcnfid_desc 
 
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_stem_m.stemsite,g_stem_m.stemsite_desc,g_stem_m.stemdocdt,g_stem_m.stemdocno, 
          g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem002_desc,g_stem_m.stem003, 
          g_stem_m.stem003_desc,g_stem_m.stem005,g_stem_m.stem005_desc,g_stem_m.stem004,g_stem_m.stem004_desc, 
          g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011, 
          g_stem_m.stem018,g_stem_m.stem000,g_stem_m.stem012,g_stem_m.stem012_desc,g_stem_m.stem013, 
          g_stem_m.stem013_desc,g_stem_m.stem034,g_stem_m.stemstus,g_stem_m.stemownid,g_stem_m.stemownid_desc, 
          g_stem_m.stemowndp,g_stem_m.stemowndp_desc,g_stem_m.stemcrtid,g_stem_m.stemcrtid_desc,g_stem_m.stemcrtdp, 
          g_stem_m.stemcrtdp_desc,g_stem_m.stemcrtdt,g_stem_m.stemmodid,g_stem_m.stemmodid_desc,g_stem_m.stemmoddt, 
          g_stem_m.stemcnfid,g_stem_m.stemcnfid_desc,g_stem_m.stemcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE astt802_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL astt802_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt802.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION astt802_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sten_d.getLength() THEN
         LET g_detail_idx = g_sten_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sten_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sten_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_sten2_d.getLength() THEN
         LET g_detail_idx = g_sten2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sten2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sten2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_sten3_d.getLength() THEN
         LET g_detail_idx = g_sten3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sten3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sten3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt802_b_fill2(pi_idx)
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
   
   CALL astt802_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION astt802_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="astt802.status_show" >}
PRIVATE FUNCTION astt802_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astt802.mask_functions" >}
&include "erp/ast/astt802_mask.4gl"
 
{</section>}
 
{<section id="astt802.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION astt802_send()
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
 
 
   CALL astt802_show()
   CALL astt802_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   #170203-00024#5-S
   #確認前檢核段
   IF NOT s_astt802_conf_chk(g_stem_m.stemdocno,g_stem_m.stemstus) THEN
      CLOSE astt802_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #170203-00024#5-E
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_stem_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sten_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_sten2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_sten3_d))
 
 
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
   #CALL astt802_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL astt802_ui_headershow()
   CALL astt802_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION astt802_draw_out()
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
   CALL astt802_ui_headershow()  
   CALL astt802_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="astt802.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION astt802_set_pk_array()
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
   LET g_pk_array[1].values = g_stem_m.stemdocno
   LET g_pk_array[1].column = 'stemdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt802.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="astt802.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION astt802_msgcentre_notify(lc_state)
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
   CALL astt802_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_stem_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="astt802.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION astt802_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#41 add-S
   SELECT stemstus  INTO g_stem_m.stemstus
     FROM stem_t
    WHERE stement = g_enterprise
      AND stemdocno = g_stem_m.stemdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_stem_m.stemstus
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
        LET g_errparam.extend = g_stem_m.stemdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL astt802_set_act_visible()
        CALL astt802_set_act_no_visible()
        CALL astt802_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#41 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="astt802.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 合同编号带值(astm401)
# Memo...........:
# Usage..........: CALL astt802_stem001_ref（）
# Date & Author..: 20150423 By dongsz #150402-00005#20
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_stem001_ref()
   LET g_stem_m.stem016 = ''
   LET g_stem_m.stem002 = ''
   LET g_stem_m.stem003 = ''
   LET g_stem_m.stem004 = ''
   LET g_stem_m.stem005 = ''
   LET g_stem_m.stem006 = ''
   LET g_stem_m.stem017 = ''
   LET g_stem_m.stem007 = ''
   LET g_stem_m.stem009 = ''
   LET g_stem_m.stem010 = ''
   LET g_stem_m.stem011 = ''
   SELECT stje002+1,stje008,stje007,stje028,
          stje029,stje023,stje024,
          stje025,stje011,stje012,stje042
     INTO g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem005,
          g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,
          g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje001 = g_stem_m.stem001
   LET g_stem_m.stem016 = g_stem_m.stem016 USING "<<<<<<<<<#"
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem006,'2')
            RETURNING g_stem_m.stem006
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem017,'2')
            RETURNING g_stem_m.stem017
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem007,'2')
            RETURNING g_stem_m.stem007            
   DISPLAY BY NAME  g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem004,
          g_stem_m.stem005,g_stem_m.stem006,g_stem_m.stem017,
          g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem002
   CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem003_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem005
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem005_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem004_desc
      
END FUNCTION

################################################################################
# Descriptions...: 判断同一费用编号的日期区间不可重复
# Memo...........:
# Usage..........: CALL astt802_chk_sten002()
# Date & Author..: 20150423 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_chk_sten002()
DEFINE l_n      LIKE type_t.num5
   
   IF cl_null(g_sten_d[l_ac].sten002) OR cl_null(g_sten_d[l_ac].sten003) OR
      cl_null(g_sten_d[l_ac].sten004) THEN
      RETURN TRUE
   END IF
   LET l_n = 0
#   SELECT COUNT(*) INTO l_n
#     FROM sten_t
#    WHERE stenent = g_enterprise
#      AND stendocno = g_stem_m.stemdocno
#      AND sten002 = g_sten_d[l_ac].sten002
#      AND ((sten003 <= g_sten_d[l_ac].sten003 AND sten004 >= g_sten_d[l_ac].sten003) OR
#           ((sten003 >= g_sten_d[l_ac].sten003 AND sten003 <= g_sten_d[l_ac].sten004) AND
#             sten004 >= g_sten_d[l_ac].sten003))
   SELECT COUNT(*) INTO l_n
        FROM sten_t
       WHERE stenent = g_enterprise
         AND stendocno = g_stem_m.stemdocno
         AND sten002 = g_sten_d[l_ac].sten002
    GROUP BY sten003,sten004
      HAVING ((sten003 <= g_sten_d[l_ac].sten003 AND sten004 >= g_sten_d[l_ac].sten003)
          OR (sten003 <= g_sten_d[l_ac].sten004 AND sten004 >= g_sten_d[l_ac].sten004) 
          OR (sten003 <= g_sten_d[l_ac].sten003 AND sten004 >= g_sten_d[l_ac].sten004)
          OR (sten003 >= g_sten_d[l_ac].sten003 AND sten004 <= g_sten_d[l_ac].sten004))
   
      
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ""
      LET g_errparam.code   = 'ast-00237'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 将优惠审批页签资料插入到专柜合同维护作业(astm401)优惠条件页签中
# Memo...........:
# Usage..........: CALL astt802_ins_stfi()
# Date & Author..: 20150423 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_ins_stfi()
DEFINE l_stjhseq   LIKE stjh_t.stjhseq
DEFINE l_sql       STRING
DEFINE l_time      DATETIME YEAR TO SECOND 

   SELECT MAX(stjhseq) INTO l_stjhseq
     FROM stjh_t
    WHERE stjhent = g_enterprise
      AND stjh001 = g_stem_m.stem001
   IF cl_null(l_stjhseq) THEN
      LET l_stjhseq = 0
   END IF
   #新增合同astm401的优惠条件页签
   LET l_sql = " INSERT INTO stfi_t ( stjhent, ",        #企業編號
               "                      stjhunit, ",       #應用組織
#               "                      stjhacti, ",       #資料有效
               "                      stjhsite, ",       #營運據點
               "                      stjhseq, ",        #項次
               "                      stjh001, ",        #合同編號
               "                      stjh008, ",        #優惠類型
               "                      stjh002, ",        #費用編碼
               "                      stjh006, ",        #優惠金額
               "                      stjh005, ",        #優惠結束日期
               "                      stjh004, ",        #優惠開始日期
               "                      stjh003, ",        #優惠單號
               "                      stjh007, ",        #優惠項次
#               "                      stfi009, ",        #備註
#               "                      stfi010 ) ",       #優惠原因
               " SELECT ",g_enterprise,",stenunit,stensite,ROWNUM+",l_stjhseq,", ",
               "        '",g_stem_m.stem001,"',sten001,sten002,sten005,sten003,sten004, ",
               "        stendocno,stenseq ",
               "   FROM sten_t ",
               "  WHERE stenent = ",g_enterprise," ",
               "    AND stendocno = '",g_stem_m.stemdocno,"' ",
               "    AND stenacti = 'Y' ",
               "  ORDER BY stenseq "
   PREPARE ins_stfi_pre FROM l_sql
   EXECUTE ins_stfi_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins stfi"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   #更新單身執行優惠否
   UPDATE sten_t SET sten011 = 'Y'
    WHERE stenent = g_enterprise
      AND stendocno = g_stem_m.stemdocno
      AND stenacti = 'Y'
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd sten"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF

   #更新單頭執行人員和執行日期
   LET l_time = cl_get_current()
   UPDATE stem_t SET stem014 = g_user,
                     stem015 = l_time
    WHERE stement = g_enterprise
      AND stemdocno = g_stem_m.stemdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "upd stem"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 新增单身资料
# Memo...........:
# Usage..........: CALL astt802_ins_detail()
# Date & Author..: 20150423 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_ins_detail()
DEFINE l_sql        STRING

   
   DELETE FROM steo_t
    WHERE steoent = g_enterprise
      AND steodocno = g_stem_m.stemdocno
   DELETE FROM step_t
    WHERE stepent = g_enterprise
      AND stepdocno = g_stem_m.stemdocno
   #优惠执行情况页签
   LET l_sql = " INSERT INTO steo_t ( steoent, ",           #企業編號
               "                      steounit, ",          #制定組織
               "                      steosite, ",          #營運據點
               "                      steoacti, ",          #狀態
               "                      steodocno, ",         #審批單號
               "                      steoseq, ",           #項次
               "                      steo001, ",           #執行類型
               "                      steo002, ",           #優惠類型
               "                      steo003, ",           #費用編號
               "                      steo004, ",           #優惠開始日期
               "                      steo005, ",           #優惠結束日期
               "                      steo006, ",           #優惠金額
               "                      steo007, ",           #優惠原因
               "                      steo008, ",           #優惠單號
               "                      steo009 ) ",          #優惠項次
               " SELECT ",g_enterprise,",'",g_stem_m.stemsite,"','",g_stem_m.stemsite,"','Y',",
               "        '",g_stem_m.stemdocno,"',stjhseq,CASE WHEN stjh005<'",g_stem_m.stemdocdt,"' THEN '1' ELSE '2' END,stjh008, ",
               "        stjh002,stjh004,stjh005,stjh006,sten009 ,stjh003,stjh007 ",
               "   FROM stjh_t ",
               "   LEFT JOIN sten_t ON stenent=stjhent AND stenseq=stjhseq AND stendocno=stjh003",
               "  WHERE stjhent = '",g_enterprise,"' ",
               "    AND stjh001 = '",g_stem_m.stem001,"' "

   PREPARE ins_steo_pre FROM l_sql
   EXECUTE ins_steo_pre
   IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins steo"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
 
   #商户合作情况页签
   LET l_sql = " INSERT INTO step_t ( stepent, ",            #企業編號
               "                      stepunit, ",           #制定組織
               "                      stepsite, ",           #營運據點
               "                      stepacti, ",           #狀態
               "                      stepdocno, ",          #審批單號
               "                      stepseq, ",            #項次
               "                      step001, ",            #門店編號
               "                      step002, ",            #铺位編號
               "                      step003, ",            #門牌號
               "                      step004, ",            #租賃開始日期
               "                      step005, ",            #租賃結束日期
               "                      step006, ",            #經營面積
               "                      step007, ",            #經營小類
               "                      step008 ) ",           #合同編號
               " SELECT ",g_enterprise,",'",g_stem_m.stemsite,"','",g_stem_m.stemsite,"' ,'Y',",
               "        '",g_stem_m.stemdocno,"',ROWNUM,stjesite,stje008,stje010,stje011,stje012, ",
               "        stje025,stje028,' ",g_stem_m.stem001,"'",
               "   FROM stje_t ",
               "  WHERE stjeent = ",g_enterprise," ",
               "    AND stje007 = '",g_stem_m.stem003,"' ",
               "  ORDER BY stje001 "
   PREPARE ins_step_pre FROM l_sql
   EXECUTE ins_step_pre
   IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "ins step"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 铺位带值
################################################################################
PRIVATE FUNCTION astt802_stem002_ref()
   LET g_stem_m.stem005 = ''
   LET g_stem_m.stem006 = ''
   LET g_stem_m.stem017 = ''
   LET g_stem_m.stem007 = ''
   SELECT mhbe009,mhbe006,mhbe007,mhbe008 
     INTO g_stem_m.stem005,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007
     FROM mhbe_t
    WHERE mhbeent=g_enterprise
      AND mhbe001=g_stem_m.stem002
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem006,'2')
            RETURNING g_stem_m.stem006
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem017,'2')
            RETURNING g_stem_m.stem017
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem007,'2')
            RETURNING g_stem_m.stem007
   DISPLAY BY NAME g_stem_m.stem005,g_stem_m.stem006,g_stem_m.stem017,g_stem_m.stem007
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem005
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem005_desc
END FUNCTION

################################################################################
# Descriptions...: 优惠金额计算
# Memo...........:
# Usage..........: CALL astt802_discount(p_type,p_sten002,p_strt,p_ed,p_sten007,p_sten012)
#                  RETURNING r_amount
# Input parameter: p_type     优惠类型
#                : p_sten002  费用编号
#                : p_strt     开始日期
#                : p_ed       结束日期
#                : p_sten007  优惠单价
#                : p_sten012  优惠面积
# Return code....: r_amount   优惠金额
# Date & Author..: 2016/06/02 By 08172
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_discount(p_type,p_sten002,p_strt,p_ed,p_sten007,p_sten012)
   DEFINE p_type      LIKE sten_t.sten001            
   DEFINE p_sten002   LIKE sten_t.sten002
   DEFINE p_strt      LIKE sten_t.sten003
   DEFINE p_ed        LIKE sten_t.sten004
   DEFINE p_sten007   LIKE sten_t.sten007
   DEFINE p_sten012   LIKE sten_t.sten012
   DEFINE r_amount    LIKE sten_t.sten005
   DEFINE l_amount    LIKE sten_t.sten005
   DEFINE l_sql       STRING
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_strt      LIKE sten_t.sten003
   DEFINE l_ed        LIKE sten_t.sten004
   DEFINE l_stjfseq   LIKE stjf_t.stjfseq      #项次
#   DEFINE l_stjf022   LIKE stjf_t.stjf022      #场地编号
   DEFINE l_stjf010   LIKE stjf_t.stjf010      #计算方式
   DEFINE l_stjf011   LIKE stjf_t.stjf011      #固定单位金额
   DEFINE l_stjf005   LIKE stjf_t.stjf005      #开始时间
   DEFINE l_stjf006   LIKE stjf_t.stjf006      #结束时间
   DEFINE l_sum       LIKE stjj_t.stjj005      #总面积
   DEFINE l_stjj005   LIKE stjj_t.stjj005      #经营面积
   
   LET r_amount=0
   LET l_amount=0
   LET l_sql=''
   LET l_stjf011=0
   
   LET l_stjj005=0
   #计算日期区间的总金额
   SELECT SUM(stjn006) INTO l_amount 
     FROM stjn_t
    WHERE stjnent=g_enterprise
      AND stjn001=g_stem_m.stem001
      AND stjn004='1'
      AND stjn005=p_sten002
      AND stjn002>=p_strt AND stjn002<=p_ed
   #租期优惠
   IF p_type='3' THEN
      LET r_amount=l_amount*(-1)
   END IF
   #面积优惠
   IF p_type='2' THEN
      LET l_sum=0
      LET r_amount=0
      
#      LET l_sql=" SELECT DISTINCT stjf022 FROM stjf_t",
#                 " WHERE stjfent='",g_enterprise,"'",
#                   " AND stjf001='",g_stem_m.stem001,"'",
#                   " AND stjf004='",p_sten002,"'",
#                   " AND (stjf005>='",p_strt,"' AND stjf005<='",p_ed,"'",
#                    " OR stjf006>='",p_strt,"' AND stjf006<='",p_ed,"'",
#                    " OR stjf005<='",p_strt,"' AND stjf006>='",p_ed,"')"
#      PREPARE astt802_discount_pre1 FROM l_sql
#      DECLARE astt802_discount_cur1 CURSOR FOR astt802_discount_pre1
#      FOREACH astt802_discount_cur1 INTO l_stjf022    #场地编号
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT FOREACH
#      END IF
#      SELECT stjj005 INTO l_stjj005
#        FROM stjj_t
#       WHERE stjjent=g_enterprise
#         AND stjj001=g_stem_m.stem001
#         AND stjj002=l_stjf022
#      LET l_sum=l_sum+l_stjj005 
#      END FOREACH
#      CLOSE astt802_discount_cur1
      SELECT stjf010 INTO l_stjf010 FROM stjf_t
          WHERE stjfent=g_enterprise
            AND stjf001=g_stem_m.stem001
            AND stjf004=p_sten002
            AND stjf009='3'
            AND (stjf005>=p_strt AND stjf005<=p_ed
             OR  stjf006>=p_strt AND stjf006<=p_ed
             OR  stjf005<=p_strt AND stjf006>=p_ed)
            AND ROWNUM=1
            
      SELECT COUNT(*) INTO l_n FROM(
         SELECT stjf010 FROM stjf_t
          WHERE stjfent=g_enterprise
            AND stjf001=g_stem_m.stem001
            AND stjf004=p_sten002
            AND stjf009='3'
            AND (stjf005>=p_strt AND stjf005<=p_ed
             OR  stjf006>=p_strt AND stjf006<=p_ed
             OR  stjf005<=p_strt AND stjf006>=p_ed)
            AND ROWNUM=1
      )
      IF l_n=0 THEN
         LET r_amount=0
      ELSE
         IF l_stjf010='1' THEN
            SELECT stje024 INTO l_sum
              FROM stje_t
             WHERE stjeent=g_enterprise
               AND stje001=g_stem_m.stem001
         END IF
         IF l_stjf010='2' THEN
            SELECT stje025 INTO l_sum
              FROM stje_t
             WHERE stjeent=g_enterprise
               AND stje001=g_stem_m.stem001
         END IF
      END IF
#      LET r_amount=l_amount*p_sten012*(-1)/l_sum    #160810-00030#1 by 08172
      LET r_amount=l_amount*p_sten012/l_sum    #160810-00030#1 by 08172
   END IF
   #单价优惠
   IF p_type='4' THEN
      LET l_amount=0
      LET r_amount=0
      LET l_strt=''
      LET l_ed=''
      #LET l_sql=" SELECT stjfseq,stjf005,stjf006,stjf011 FROM stjf_t",      #项次，开始日期，结束日期，固定/单价金额 #mark by geza 20160815 #160815-00001#1
      #计算优惠金额用费用单身的确认金额        
      LET l_sql=" SELECT stjfseq,stjf005,stjf006,stjf018 FROM stjf_t",      #项次，开始日期，结束日期，审核/单价金额 #add by geza 20160815 #160815-00001#1            
                " WHERE stjfent='",g_enterprise,"'",
                  " AND stjf001='",g_stem_m.stem001,"'",
                  " AND stjf004='",p_sten002,"'",
                  " AND stjf009='3' ",
                  " AND (stjf005>='",p_strt,"' AND stjf005<='",p_ed,"'",
                   " OR stjf006>='",p_strt,"' AND stjf006<='",p_ed,"'",
                   " OR stjf005<='",p_strt,"' AND stjf006>='",p_ed,"')"
      PREPARE astt802_discount_pre2 FROM l_sql
      DECLARE astt802_discount_cur2 CURSOR FOR astt802_discount_pre2
      
      FOREACH astt802_discount_cur2 INTO l_stjfseq,l_stjf005,l_stjf006,l_stjf011
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         IF l_stjf005>p_strt THEN
            LET l_strt=l_stjf005
         ELSE 
            LET l_strt=p_strt
         END IF
         IF l_stjf006<p_ed THEN
            LET l_ed=l_stjf006
         ELSE
            LET l_ed=p_ed
         END IF
         #计算费用编号日期区间金额
         SELECT SUM(stjn006) INTO l_amount 
           FROM stjn_t 
          WHERE stjnent=g_enterprise
            AND stjn001=g_stem_m.stem001
            AND stjn004='1'
            AND stjn005=p_sten002
            AND stjn010=l_stjfseq
            AND stjn002>=l_strt AND stjn002<=l_ed
#         LET r_amount=r_amount+l_amount*p_sten007*(-1)/l_stjf011   #160810-00030#1 by 08172
          LET r_amount=r_amount+l_amount*p_sten007/l_stjf011   #160810-00030#1 by 08172
      END FOREACH
   END IF
   CLOSE astt802_discount_cur2
   #170109-00031#1 -s add by 08172
   IF cl_null(r_amount) THEN
      LET r_amount = 0
   END IF 
   #170109-00031#1 -e add by 08172
   RETURN r_amount

END FUNCTION

################################################################################
################################################################################
# Descriptions...: 供应商带值 
# Memo...........:
# Usage..........: CALL astt802_stem003_ref()
# Date & Author..: 20160614By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION astt802_stem003_ref()
   LET g_stem_m.stem016 = ''
   LET g_stem_m.stem002 = ''
   LET g_stem_m.stem001 = ''
   LET g_stem_m.stem004 = ''
   LET g_stem_m.stem005 = ''
   LET g_stem_m.stem006 = ''
   LET g_stem_m.stem017 = ''
   LET g_stem_m.stem007 = ''
   LET g_stem_m.stem009 = ''
   LET g_stem_m.stem010 = ''
   LET g_stem_m.stem011 = ''
   SELECT stje001,stje002+1,stje008,stje028,
          stje029,stje023,stje024,
          stje025,stje011,stje012,stje042
     INTO g_stem_m.stem001,g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem005,
          g_stem_m.stem004,g_stem_m.stem006,g_stem_m.stem017,
          g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011
     FROM stje_t
    WHERE stjeent = g_enterprise
      AND stje007 = g_stem_m.stem003
   LET g_stem_m.stem016 = g_stem_m.stem016 USING "<<<<<<<<<#"
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem006,'2')
            RETURNING g_stem_m.stem006
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem017,'2')
            RETURNING g_stem_m.stem017
   CALL s_asti800_curr_round(g_stem_m.stemsite,'',g_stem_m.stem007,'2')
            RETURNING g_stem_m.stem007            
   DISPLAY BY NAME  g_stem_m.stem016,g_stem_m.stem002,g_stem_m.stem003,g_stem_m.stem004,
          g_stem_m.stem005,g_stem_m.stem006,g_stem_m.stem017,
          g_stem_m.stem007,g_stem_m.stem009,g_stem_m.stem010,g_stem_m.stem011 
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem002
   CALL ap_ref_array2(g_ref_fields,"SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem003
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem003_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem005
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem005_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_stem_m.stem004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_stem_m.stem004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_stem_m.stem004_desc
END FUNCTION

 
{</section>}
 
