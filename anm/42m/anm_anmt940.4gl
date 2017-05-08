#該程式未解開Section, 採用最新樣板產出!
{<section id="anmt940.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2014-09-05 14:14:24), PR版次:0013(2017-01-19 14:28:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: anmt940
#+ Description: 內部資金調度作業
#+ Creator....: 03538(2014-08-12 17:04:40)
#+ Modifier...: 03538 -SD/PR- 08171
 
{</section>}
 
{<section id="anmt940.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#150401-00001#13  2015/07/21 By RayHuang  statechange段問題修正
#150401-00001#31  2015/10/22 By Hans      修改狀況下把日期鎖掉，但新增時卻未開啟
#151125-00001#3   2015/11/27 By Charles4m 增加詢問是否作廢。
#151125-00006#3   2015/12/08 By 07166     新增[編輯完單據後立即審核]功能
#151130-00015#2   2015/12/22 BY Xiaozg    根据是否可以更改單據日期 設定開放單據日期修改
#160122-00001#2   2016/02/22 By 07673     添加交易账户编号用户权限控管
#160122-00001#2   2016/03/17 By 07900     添加交易账户编号用户权限控管,增加部门权限
#160318-00025#24  2016/04/25 BY 07900     校验代码重复错误讯息的修改
#160816-00068#7   2016/08/18 By earl      調整transaction
#160818-00017#24  2016-08-23 By 08734     删除修改未重新判断状态码
#160816-00012#3   2016/09/05 By 01531     ANM增加资金中心，帐套，法人三个栏位权限
#160913-00017#5   2016/09/23 By 07900     ANM模组调整交易客商开窗
#160912-00024#1   2016/09/20 By 01531     来源组织权限控管
#160919-00032#1   2016/10/08 By 01531     内部资金调度作业，拨入单身交易账号开窗没资料
#161021-00050#11  2016/10/28 By Reanna    资金中心开窗需调整为q_ooef001_33 新增时where条件限定ooefstus= 'Y'查询时不限定此条件；
#                                         单身两个组织详细见excel"资金单身来源组织"
#160824-00007#324 2017/01/17  By 08171    新舊值調整
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
GLOBALS "../../cfg/top_finance.inc"    #財務模組使用
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_nmbm_m        RECORD
       nmbm001 LIKE nmbm_t.nmbm001, 
   nmbm001_desc LIKE type_t.chr80, 
   nmbmdocno LIKE nmbm_t.nmbmdocno, 
   nmbmdocdt LIKE nmbm_t.nmbmdocdt, 
   nmbmstus LIKE nmbm_t.nmbmstus, 
   nmbmownid LIKE nmbm_t.nmbmownid, 
   nmbmownid_desc LIKE type_t.chr80, 
   nmbmowndp LIKE nmbm_t.nmbmowndp, 
   nmbmowndp_desc LIKE type_t.chr80, 
   nmbmcrtid LIKE nmbm_t.nmbmcrtid, 
   nmbmcrtid_desc LIKE type_t.chr80, 
   nmbmcrtdp LIKE nmbm_t.nmbmcrtdp, 
   nmbmcrtdp_desc LIKE type_t.chr80, 
   nmbmcrtdt LIKE nmbm_t.nmbmcrtdt, 
   nmbmmodid LIKE nmbm_t.nmbmmodid, 
   nmbmmodid_desc LIKE type_t.chr80, 
   nmbmmoddt LIKE nmbm_t.nmbmmoddt, 
   nmbmcnfid LIKE nmbm_t.nmbmcnfid, 
   nmbmcnfid_desc LIKE type_t.chr80, 
   nmbmcnfdt LIKE nmbm_t.nmbmcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_nmbo_d        RECORD
       nmboseq LIKE nmbo_t.nmboseq, 
   nmboseq2 LIKE nmbo_t.nmboseq2, 
   nmbo002 LIKE nmbo_t.nmbo002, 
   nmbnl003 LIKE type_t.chr500, 
   nmbo001 LIKE nmbo_t.nmbo001, 
   nmbo003 LIKE nmbo_t.nmbo003, 
   nmbo004 LIKE nmbo_t.nmbo004, 
   nmaal003 LIKE type_t.chr500, 
   nmbo006 LIKE nmbo_t.nmbo006, 
   nmbo005 LIKE nmbo_t.nmbo005, 
   nmbo012 LIKE nmbo_t.nmbo012, 
   nmbo025 LIKE nmbo_t.nmbo025, 
   pmaal004 LIKE type_t.chr500, 
   nmbo008 LIKE nmbo_t.nmbo008, 
   nmbo007 LIKE nmbo_t.nmbo007, 
   nmbo009 LIKE nmbo_t.nmbo009, 
   nmbo010 LIKE nmbo_t.nmbo010, 
   nmajl003 LIKE type_t.chr500, 
   nmbo011 LIKE nmbo_t.nmbo011, 
   nmail004 LIKE type_t.chr500, 
   nmbo013 LIKE nmbo_t.nmbo013, 
   nmbo021 LIKE nmbo_t.nmbo021, 
   glaald LIKE glaa_t.glaald, 
   glaacomp LIKE glaa_t.glaacomp
       END RECORD
PRIVATE TYPE type_g_nmbo2_d RECORD
       nmboseq LIKE nmbo_t.nmboseq, 
   nmboseq2 LIKE nmbo_t.nmboseq2, 
   nmbo002 LIKE nmbo_t.nmbo002, 
   nmbnl003 LIKE nmbnl_t.nmbnl003, 
   nmbo001 LIKE nmbo_t.nmbo001, 
   nmbo006 LIKE nmbo_t.nmbo006, 
   nmbo008 LIKE nmbo_t.nmbo008, 
   nmbo014 LIKE nmbo_t.nmbo014, 
   nmbo015 LIKE nmbo_t.nmbo015, 
   nmbo007 LIKE nmbo_t.nmbo007, 
   nmbo016 LIKE nmbo_t.nmbo016, 
   nmbo017 LIKE nmbo_t.nmbo017, 
   nmajl003 LIKE nmajl_t.nmajl003, 
   nmbo018 LIKE nmbo_t.nmbo018, 
   nmail004 LIKE nmail_t.nmail004, 
   glaald LIKE glaa_t.glaald, 
   glaacomp LIKE glaa_t.glaacomp
       END RECORD
PRIVATE TYPE type_g_nmbo3_d RECORD
       nmbgseq LIKE nmbg_t.nmbgseq, 
   nmbgseq2 LIKE nmbg_t.nmbgseq2, 
   nmbg001 LIKE nmbg_t.nmbg001, 
   nmbg003 LIKE nmbg_t.nmbg003, 
   nmbg004 LIKE nmbg_t.nmbg004, 
   nmaal003 LIKE nmaal_t.nmaal003, 
   nmbg006 LIKE nmbg_t.nmbg006, 
   nmbg005 LIKE nmbg_t.nmbg005, 
   nmbg012 LIKE nmbg_t.nmbg012, 
   nmbg025 LIKE nmbg_t.nmbg025, 
   pmaal004 LIKE pmaal_t.pmaal004, 
   nmbg008 LIKE nmbg_t.nmbg008, 
   nmbg007 LIKE nmbg_t.nmbg007, 
   nmbg009 LIKE nmbg_t.nmbg009, 
   nmbg010 LIKE nmbg_t.nmbg010, 
   nmajl003 LIKE nmajl_t.nmajl003, 
   nmbg011 LIKE nmbg_t.nmbg011, 
   nmail004 LIKE nmail_t.nmail004, 
   nmbg013 LIKE nmbg_t.nmbg013, 
   nmbg021 LIKE nmbg_t.nmbg021, 
   glaald LIKE glaa_t.glaald, 
   glaacomp LIKE glaa_t.glaacomp
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_nmbmdocno LIKE nmbm_t.nmbmdocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data           LIKE type_t.chr80             #內部銀行管理啟用否(aoos010)
DEFINE l_comp_wc             STRING
DEFINE g_sql_bank            STRING                        #160122-00001#2  by 07900 -add
DEFINE g_site_wc             STRING  #160912-00024#1 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_nmbm_m          type_g_nmbm_m
DEFINE g_nmbm_m_t        type_g_nmbm_m
DEFINE g_nmbm_m_o        type_g_nmbm_m
DEFINE g_nmbm_m_mask_o   type_g_nmbm_m #轉換遮罩前資料
DEFINE g_nmbm_m_mask_n   type_g_nmbm_m #轉換遮罩後資料
 
   DEFINE g_nmbmdocno_t LIKE nmbm_t.nmbmdocno
 
 
DEFINE g_nmbo_d          DYNAMIC ARRAY OF type_g_nmbo_d
DEFINE g_nmbo_d_t        type_g_nmbo_d
DEFINE g_nmbo_d_o        type_g_nmbo_d
DEFINE g_nmbo_d_mask_o   DYNAMIC ARRAY OF type_g_nmbo_d #轉換遮罩前資料
DEFINE g_nmbo_d_mask_n   DYNAMIC ARRAY OF type_g_nmbo_d #轉換遮罩後資料
DEFINE g_nmbo2_d          DYNAMIC ARRAY OF type_g_nmbo2_d
DEFINE g_nmbo2_d_t        type_g_nmbo2_d
DEFINE g_nmbo2_d_o        type_g_nmbo2_d
DEFINE g_nmbo2_d_mask_o   DYNAMIC ARRAY OF type_g_nmbo2_d #轉換遮罩前資料
DEFINE g_nmbo2_d_mask_n   DYNAMIC ARRAY OF type_g_nmbo2_d #轉換遮罩後資料
DEFINE g_nmbo3_d          DYNAMIC ARRAY OF type_g_nmbo3_d
DEFINE g_nmbo3_d_t        type_g_nmbo3_d
DEFINE g_nmbo3_d_o        type_g_nmbo3_d
DEFINE g_nmbo3_d_mask_o   DYNAMIC ARRAY OF type_g_nmbo3_d #轉換遮罩前資料
DEFINE g_nmbo3_d_mask_n   DYNAMIC ARRAY OF type_g_nmbo3_d #轉換遮罩後資料
 
 
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
 
{<section id="anmt940.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT nmbm001,'',nmbmdocno,nmbmdocdt,nmbmstus,nmbmownid,'',nmbmowndp,'',nmbmcrtid, 
       '',nmbmcrtdp,'',nmbmcrtdt,nmbmmodid,'',nmbmmoddt,nmbmcnfid,'',nmbmcnfdt", 
                      " FROM nmbm_t",
                      " WHERE nmbment= ? AND nmbmdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt940_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.nmbm001,t0.nmbmdocno,t0.nmbmdocdt,t0.nmbmstus,t0.nmbmownid,t0.nmbmowndp, 
       t0.nmbmcrtid,t0.nmbmcrtdp,t0.nmbmcrtdt,t0.nmbmmodid,t0.nmbmmoddt,t0.nmbmcnfid,t0.nmbmcnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooag011 ,t5.ooefl003 ,t6.ooag011 ,t7.ooag011",
               " FROM nmbm_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.nmbm001 AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.nmbmownid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.nmbmowndp AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.nmbmcrtid  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.nmbmcrtdp AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.nmbmmodid  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.nmbmcnfid  ",
 
               " WHERE t0.nmbment = " ||g_enterprise|| " AND t0.nmbmdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmt940_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmt940 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmt940_init()   
 
      #進入選單 Menu (="N")
      CALL anmt940_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmt940
      
   END IF 
   
   CLOSE anmt940_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmt940.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmt940_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('nmbmstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_get_para(g_enterprise,"","E-FIN-0001") RETURNING g_para_data
   IF g_para_data = 'Y' THEN
      CALL cl_set_comp_visible("nmbo005",TRUE)
      CALL cl_set_comp_visible("nmbg005",TRUE)
   ELSE
      CALL cl_set_comp_visible("nmbo005",FALSE)
      CALL cl_set_comp_visible("nmbg005",FALSE)
   END IF
   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()   
   #160122-00001#2 By 07900--add--str--
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   #160122-00001#2 By 07900--add--end
   #end add-point
   
   #初始化搜尋條件
   CALL anmt940_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="anmt940.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION anmt940_ui_dialog()
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
   DEFINE  l_n      LIKE type_t.num10          #151125-00006#3
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
            CALL anmt940_insert()
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
         INITIALIZE g_nmbm_m.* TO NULL
         CALL g_nmbo_d.clear()
         CALL g_nmbo2_d.clear()
         CALL g_nmbo3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL anmt940_init()
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
               
               CALL anmt940_fetch('') # reload data
               LET l_ac = 1
               CALL anmt940_ui_detailshow() #Setting the current row 
         
               CALL anmt940_idx_chk()
               #NEXT FIELD nmboseq2
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_nmbo_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt940_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL anmt940_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_nmbo2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt940_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL anmt940_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_nmbo3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL anmt940_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL anmt940_idx_chk()
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
            CALL anmt940_browser_fill("")
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
               CALL anmt940_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL anmt940_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL anmt940_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL anmt940_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL anmt940_set_act_visible()   
            CALL anmt940_set_act_no_visible()
            IF NOT (g_nmbm_m.nmbmdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " nmbment = " ||g_enterprise|| " AND",
                                  " nmbmdocno = '", g_nmbm_m.nmbmdocno, "' "
 
               #填到對應位置
               CALL anmt940_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "nmbm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbo_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbg_t" 
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
               CALL anmt940_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "nmbm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbo_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "nmbg_t" 
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
                  CALL anmt940_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL anmt940_fetch("F")
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
               CALL anmt940_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL anmt940_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt940_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL anmt940_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt940_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL anmt940_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt940_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL anmt940_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt940_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL anmt940_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL anmt940_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_nmbo_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_nmbo2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_nmbo3_d)
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
               NEXT FIELD nmboseq2
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
               CALL anmt940_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #151125-00006#3--s           
               CALL anmt940_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbm_t
                WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
                IF l_n > 0 THEN CALL anmt940_ui_headershow() END IF
                
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL anmt940_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #151125-00006#3--s           
               CALL anmt940_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbm_t
                WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
                IF l_n > 0 THEN CALL anmt940_ui_headershow() END IF
                
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL anmt940_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL anmt940_insert()
               #add-point:ON ACTION insert name="menu.insert"
               #151125-00006#3--s           
               CALL anmt940_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbm_t
                WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
                IF l_n > 0 THEN CALL anmt940_ui_headershow() END IF
               
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/anm/anmt940_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/anm/anmt940_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL anmt940_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               #151125-00006#3--s           
               CALL anmt940_immediately_conf()
               SELECT COUNT(*) INTO l_n FROM nmbm_t
                WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
                IF l_n > 0 THEN CALL anmt940_ui_headershow() END IF
                
               #151125-00006#3--e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmt940_query()
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
            CALL anmt940_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL anmt940_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL anmt940_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_nmbm_m.nmbmdocdt)
 
 
 
         
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
 
{<section id="anmt940.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION anmt940_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbm_t ",
                      " ",
                      " LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                      #add-point:browser_fill段sql(nmbo_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                      #add-point:browser_fill段sql(nmbg_t1) name="browser_fill.cnt.join.nmbg_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE nmbment = " ||g_enterprise|| " AND nmboent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("nmbm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbm_t ", 
                      "  ",
                      "  ",
                      " WHERE nmbment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("nmbm_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
#160122-00001#2 -add -str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbm_t ",
                      " LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                      " LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                      " WHERE nmbment = '" ||g_enterprise|| "' AND ",l_wc,
                      " AND TRIM(nmbo005) IS NULL AND  TRIM(nmbg005) IS NULL",
                      " AND ", l_wc2, cl_sql_add_filter("nmbm_t"),
                      " UNION ",
                      " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbo_t,nmbg_t,nmbm_t ",
                      " WHERE nmbment = '" ||g_enterprise|| "'  AND ",l_wc,
                      " AND nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                      " AND nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",                     
                      " AND nmbo005 IN (",g_sql_bank,")",      #160122-00001#2 By 07900 --mod           
                      " AND nmbg005 IN (",g_sql_bank,")",      #160122-00001#2 By 07900 --mod 
                      " AND ", l_wc2, cl_sql_add_filter("nmbm_t")
                      
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbm_t ", 
                      " LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                      " LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                      " WHERE nmbment = '" ||g_enterprise|| "' ",
                      " AND TRIM(nmbo005) IS NULL AND TRIM(nmbg005) IS NULL",
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("nmbm_t"),
                      " UNION ",
                      " SELECT DISTINCT nmbmdocno ",
                      " FROM nmbo_t,nmbg_t,nmbm_t ", 
                      " WHERE nmbment = '" ||g_enterprise|| "'  ",
                      " AND nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                      " AND nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                    
                      " AND nmbo005 IN (",g_sql_bank,")",  #160122-00001#2 By 07900 --mod            
                      " AND nmbg005 IN (",g_sql_bank,")",  #160122-00001#2 By 07900 --mod 
                      " AND ",l_wc CLIPPED, cl_sql_add_filter("nmbm_t")
   END IF
#160122-00001#2 -add -end
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
      INITIALIZE g_nmbm_m.* TO NULL
      CALL g_nmbo_d.clear()        
      CALL g_nmbo2_d.clear() 
      CALL g_nmbo3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.nmbmdocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbm_t t0",
                  "  ",
                  "  LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ", 
                  #add-point:browser_fill段sql(nmbo_t1) name="browser_fill.join.nmbo_t1"
                  
                  #end add-point
                  "  LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ", 
                  #add-point:browser_fill段sql(nmbg_t1) name="browser_fill.join.nmbg_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.nmbment = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("nmbm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbm_t t0",
                  "  ",
                  
                  " WHERE t0.nmbment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("nmbm_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
#160122-00001#2 -add -str
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbm_t t0",
                  "  LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ", 
                  "  LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ", 
                  " WHERE t0.nmbment = '" ||g_enterprise|| "'  AND ",l_wc,
                  " AND nmbo005 IS NULL  AND nmbg005 IS NULL",
                  " AND ",l_wc2, cl_sql_add_filter("nmbm_t"),
                  " UNION ",
                  " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbo_t,nmbg_t,nmbm_t t0",
                  " WHERE t0.nmbment = '" ||g_enterprise|| "'  AND ",l_wc,
                  " AND nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                  " AND nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                  
                  " AND nmbo005 IN (",g_sql_bank,")",   #160122-00001#2 By 07900 --mod
                  " AND nmbg005 IN (",g_sql_bank,")",   #160122-00001#2 By 07900 --mod
                  " AND ",l_wc2, cl_sql_add_filter("nmbm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbm_t t0",
                  " LEFT JOIN nmbo_t ON nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ", 
                  " LEFT JOIN nmbg_t ON nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                  " WHERE t0.nmbment = '" ||g_enterprise|| "'  ", 
                  " AND nmbo005 IS NULL AND nmbg005 IS NULL",
                  " AND ",l_wc, cl_sql_add_filter("nmbm_t"),
                  " UNION",
                  " SELECT DISTINCT t0.nmbmstus,t0.nmbmdocno ",
                  " FROM nmbo_t,nmbg_t,nmbm_t t0",
                  " WHERE t0.nmbment = '" ||g_enterprise|| "' ", 
                  " AND nmboent = nmbment AND nmbmdocno = nmbodocno ", "  ",
                  " AND nmbgent = nmbment AND nmbmdocno = nmbgdocno", "  ",
                  
                  " AND nmbo005 IN (",g_sql_bank,")",  #160122-00001#2 By 07900 --mod                
                  " AND nmbg005 IN (",g_sql_bank,")",  #160122-00001#2 By 07900 --mod
                  " AND ",l_wc, cl_sql_add_filter("nmbm_t")
   END IF
   #160122-00001#2 -add -end
   #end add-point
   LET g_sql = g_sql, " ORDER BY nmbmdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"nmbm_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_nmbmdocno
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
         CALL anmt940_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_nmbmdocno) THEN
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
 
{<section id="anmt940.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION anmt940_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_nmbm_m.nmbmdocno = g_browser[g_current_idx].b_nmbmdocno   
 
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
   CALL anmt940_nmbm_t_mask()
   CALL anmt940_show()
      
END FUNCTION
 
{</section>}
 
{<section id="anmt940.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION anmt940_ui_detailshow()
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
 
{<section id="anmt940.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION anmt940_ui_browser_refresh()
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
      IF g_browser[l_i].b_nmbmdocno = g_nmbm_m.nmbmdocno 
 
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
 
{<section id="anmt940.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmt940_construct()
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
   DEFINE l_wc        STRING #160912-00024#1 
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_nmbm_m.* TO NULL
   CALL g_nmbo_d.clear()        
   CALL g_nmbo2_d.clear() 
   CALL g_nmbo3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON nmbm001,nmbmdocno,nmbmdocdt,nmbmstus,nmbmownid,nmbmowndp,nmbmcrtid,nmbmcrtdp, 
          nmbmcrtdt,nmbmmodid,nmbmmoddt,nmbmcnfid,nmbmcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmbmcrtdt>>----
         AFTER FIELD nmbmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmbmmoddt>>----
         AFTER FIELD nmbmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbmcnfdt>>----
         AFTER FIELD nmbmcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmbmpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.nmbm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbm001
            #add-point:ON ACTION controlp INFIELD nmbm001 name="construct.c.nmbm001"
            #資金中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef206 = 'Y'" #160816-00012#3  add
            #CALL q_ooef001()    #161021-00050#11 mark
            CALL q_ooef001_33()  #161021-00050#11
            DISPLAY g_qryparam.return1 TO nmbm001
            DISPLAY g_qryparam.return2 TO nmbm001_desc
            NEXT FIELD nmbm001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbm001
            #add-point:BEFORE FIELD nmbm001 name="construct.b.nmbm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbm001
            
            #add-point:AFTER FIELD nmbm001 name="construct.a.nmbm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmdocno
            #add-point:ON ACTION controlp INFIELD nmbmdocno name="construct.c.nmbmdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
      
            CALL q_nmbmdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmdocno  #顯示到畫面上
            NEXT FIELD nmbmdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmdocno
            #add-point:BEFORE FIELD nmbmdocno name="construct.b.nmbmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmdocno
            
            #add-point:AFTER FIELD nmbmdocno name="construct.a.nmbmdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmdocdt
            #add-point:BEFORE FIELD nmbmdocdt name="construct.b.nmbmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmdocdt
            
            #add-point:AFTER FIELD nmbmdocdt name="construct.a.nmbmdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmdocdt
            #add-point:ON ACTION controlp INFIELD nmbmdocdt name="construct.c.nmbmdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmstus
            #add-point:BEFORE FIELD nmbmstus name="construct.b.nmbmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmstus
            
            #add-point:AFTER FIELD nmbmstus name="construct.a.nmbmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmstus
            #add-point:ON ACTION controlp INFIELD nmbmstus name="construct.c.nmbmstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmownid
            #add-point:ON ACTION controlp INFIELD nmbmownid name="construct.c.nmbmownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmownid  #顯示到畫面上
            NEXT FIELD nmbmownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmownid
            #add-point:BEFORE FIELD nmbmownid name="construct.b.nmbmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmownid
            
            #add-point:AFTER FIELD nmbmownid name="construct.a.nmbmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmowndp
            #add-point:ON ACTION controlp INFIELD nmbmowndp name="construct.c.nmbmowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmowndp  #顯示到畫面上
            NEXT FIELD nmbmowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmowndp
            #add-point:BEFORE FIELD nmbmowndp name="construct.b.nmbmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmowndp
            
            #add-point:AFTER FIELD nmbmowndp name="construct.a.nmbmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmcrtid
            #add-point:ON ACTION controlp INFIELD nmbmcrtid name="construct.c.nmbmcrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmcrtid  #顯示到畫面上
            NEXT FIELD nmbmcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmcrtid
            #add-point:BEFORE FIELD nmbmcrtid name="construct.b.nmbmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmcrtid
            
            #add-point:AFTER FIELD nmbmcrtid name="construct.a.nmbmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmbmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmcrtdp
            #add-point:ON ACTION controlp INFIELD nmbmcrtdp name="construct.c.nmbmcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmcrtdp  #顯示到畫面上
            NEXT FIELD nmbmcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmcrtdp
            #add-point:BEFORE FIELD nmbmcrtdp name="construct.b.nmbmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmcrtdp
            
            #add-point:AFTER FIELD nmbmcrtdp name="construct.a.nmbmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmcrtdt
            #add-point:BEFORE FIELD nmbmcrtdt name="construct.b.nmbmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmmodid
            #add-point:ON ACTION controlp INFIELD nmbmmodid name="construct.c.nmbmmodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmmodid  #顯示到畫面上
            NEXT FIELD nmbmmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmmodid
            #add-point:BEFORE FIELD nmbmmodid name="construct.b.nmbmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmmodid
            
            #add-point:AFTER FIELD nmbmmodid name="construct.a.nmbmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmmoddt
            #add-point:BEFORE FIELD nmbmmoddt name="construct.b.nmbmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.nmbmcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmcnfid
            #add-point:ON ACTION controlp INFIELD nmbmcnfid name="construct.c.nmbmcnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbmcnfid  #顯示到畫面上
            NEXT FIELD nmbmcnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmcnfid
            #add-point:BEFORE FIELD nmbmcnfid name="construct.b.nmbmcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmcnfid
            
            #add-point:AFTER FIELD nmbmcnfid name="construct.a.nmbmcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmcnfdt
            #add-point:BEFORE FIELD nmbmcnfdt name="construct.b.nmbmcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON nmboseq,nmbo002,nmbo001,nmbo003,nmbo004,nmbo005,nmbo012,nmbo025,nmbo008, 
          nmbo007,nmbo009,nmbo010,nmbo011,nmbo021
           FROM s_detail1[1].nmboseq,s_detail1[1].nmbo002,s_detail1[1].nmbo001,s_detail1[1].nmbo003, 
               s_detail1[1].nmbo004,s_detail1[1].nmbo005,s_detail1[1].nmbo012,s_detail1[1].nmbo025,s_detail1[1].nmbo008, 
               s_detail1[1].nmbo007,s_detail1[1].nmbo009,s_detail1[1].nmbo010,s_detail1[1].nmbo011,s_detail1[1].nmbo021 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmboseq
            #add-point:BEFORE FIELD nmboseq name="construct.b.page1.nmboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmboseq
            
            #add-point:AFTER FIELD nmboseq name="construct.a.page1.nmboseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmboseq
            #add-point:ON ACTION controlp INFIELD nmboseq name="construct.c.page1.nmboseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo002
            #add-point:ON ACTION controlp INFIELD nmbo002 name="construct.c.page1.nmbo002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmbn001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo002  #顯示到畫面上
            DISPLAY g_qryparam.return2 TO nmbnl003
            NEXT FIELD nmbo002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo002
            #add-point:BEFORE FIELD nmbo002 name="construct.b.page1.nmbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo002
            
            #add-point:AFTER FIELD nmbo002 name="construct.a.page1.nmbo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo001
            #add-point:ON ACTION controlp INFIELD nmbo001 name="construct.c.page1.nmbo001"
            #播出單身/組織編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160912-00024#1 add s---
            #LET g_qryparam.where = " ooef206 = 'Y'" #161021-00050#11 mark
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#11
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED
            #160912-00024#1 add e--
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmbo001
            NEXT FIELD nmbo001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo001
            #add-point:BEFORE FIELD nmbo001 name="construct.b.page1.nmbo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo001
            
            #add-point:AFTER FIELD nmbo001 name="construct.a.page1.nmbo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo003
            #add-point:ON ACTION controlp INFIELD nmbo003 name="construct.c.page1.nmbo003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo003  #顯示到畫面上
            NEXT FIELD nmbo003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo003
            #add-point:BEFORE FIELD nmbo003 name="construct.b.page1.nmbo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo003
            
            #add-point:AFTER FIELD nmbo003 name="construct.a.page1.nmbo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo004
            #add-point:ON ACTION controlp INFIELD nmbo004 name="construct.c.page1.nmbo004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo004  #顯示到畫面上
            NEXT FIELD nmbo004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo004
            #add-point:BEFORE FIELD nmbo004 name="construct.b.page1.nmbo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo004
            
            #add-point:AFTER FIELD nmbo004 name="construct.a.page1.nmbo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo005
            #add-point:ON ACTION controlp INFIELD nmbo005 name="construct.c.page1.nmbo005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#2 -add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"   #160122-00001#2 By 07900 --mod
            #160122-00001#2 -add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo005  #顯示到畫面上
            NEXT FIELD nmbo005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo005
            #add-point:BEFORE FIELD nmbo005 name="construct.b.page1.nmbo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo005
            
            #add-point:AFTER FIELD nmbo005 name="construct.a.page1.nmbo005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo012
            #add-point:BEFORE FIELD nmbo012 name="construct.b.page1.nmbo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo012
            
            #add-point:AFTER FIELD nmbo012 name="construct.a.page1.nmbo012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo012
            #add-point:ON ACTION controlp INFIELD nmbo012 name="construct.c.page1.nmbo012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbo025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo025
            #add-point:ON ACTION controlp INFIELD nmbo025 name="construct.c.page1.nmbo025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add      
            DISPLAY g_qryparam.return1 TO nmbo025  #顯示到畫面上
            NEXT FIELD nmbo025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo025
            #add-point:BEFORE FIELD nmbo025 name="construct.b.page1.nmbo025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo025
            
            #add-point:AFTER FIELD nmbo025 name="construct.a.page1.nmbo025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo008
            #add-point:BEFORE FIELD nmbo008 name="construct.b.page1.nmbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo008
            
            #add-point:AFTER FIELD nmbo008 name="construct.a.page1.nmbo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo008
            #add-point:ON ACTION controlp INFIELD nmbo008 name="construct.c.page1.nmbo008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo007
            #add-point:BEFORE FIELD nmbo007 name="construct.b.page1.nmbo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo007
            
            #add-point:AFTER FIELD nmbo007 name="construct.a.page1.nmbo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo007
            #add-point:ON ACTION controlp INFIELD nmbo007 name="construct.c.page1.nmbo007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo009
            #add-point:BEFORE FIELD nmbo009 name="construct.b.page1.nmbo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo009
            
            #add-point:AFTER FIELD nmbo009 name="construct.a.page1.nmbo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo009
            #add-point:ON ACTION controlp INFIELD nmbo009 name="construct.c.page1.nmbo009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.nmbo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo010
            #add-point:ON ACTION controlp INFIELD nmbo010 name="construct.c.page1.nmbo010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo010  #顯示到畫面上
            NEXT FIELD nmbo010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo010
            #add-point:BEFORE FIELD nmbo010 name="construct.b.page1.nmbo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo010
            
            #add-point:AFTER FIELD nmbo010 name="construct.a.page1.nmbo010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo011
            #add-point:ON ACTION controlp INFIELD nmbo011 name="construct.c.page1.nmbo011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbo011  #顯示到畫面上
            NEXT FIELD nmbo011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo011
            #add-point:BEFORE FIELD nmbo011 name="construct.b.page1.nmbo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo011
            
            #add-point:AFTER FIELD nmbo011 name="construct.a.page1.nmbo011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo021
            #add-point:BEFORE FIELD nmbo021 name="construct.b.page1.nmbo021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo021
            
            #add-point:AFTER FIELD nmbo021 name="construct.a.page1.nmbo021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.nmbo021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo021
            #add-point:ON ACTION controlp INFIELD nmbo021 name="construct.c.page1.nmbo021"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON nmbgseq,nmbg001,nmbg003,nmbg004,nmbg005,nmbg012,nmbg025,nmbg007,nmbg009, 
          nmbg010,nmbg021
           FROM s_detail3[1].nmbgseq,s_detail3[1].nmbg001,s_detail3[1].nmbg003,s_detail3[1].nmbg004, 
               s_detail3[1].nmbg005,s_detail3[1].nmbg012,s_detail3[1].nmbg025,s_detail3[1].nmbg007,s_detail3[1].nmbg009, 
               s_detail3[1].nmbg010,s_detail3[1].nmbg021
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbgseq
            #add-point:BEFORE FIELD nmbgseq name="construct.b.page3.nmbgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbgseq
            
            #add-point:AFTER FIELD nmbgseq name="construct.a.page3.nmbgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbgseq
            #add-point:ON ACTION controlp INFIELD nmbgseq name="construct.c.page3.nmbgseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.nmbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg001
            #add-point:ON ACTION controlp INFIELD nmbg001 name="construct.c.page3.nmbg001"
            #播入單身/組織編號
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160912-00024#1 add s---
            #LET g_qryparam.where = " ooef206 = 'Y'" #161021-00050#11 mark
            LET g_qryparam.where = " ooef201 = 'Y'"  #161021-00050#11
            CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
            LET g_qryparam.where = g_qryparam.where," AND ",l_wc CLIPPED    
            #160912-00024#1 add e--
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO nmbg001
            NEXT FIELD nmbg001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg001
            #add-point:BEFORE FIELD nmbg001 name="construct.b.page3.nmbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg001
            
            #add-point:AFTER FIELD nmbg001 name="construct.a.page3.nmbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg003
            #add-point:ON ACTION controlp INFIELD nmbg003 name="construct.c.page3.nmbg003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbg003  #顯示到畫面上
            NEXT FIELD nmbg003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg003
            #add-point:BEFORE FIELD nmbg003 name="construct.b.page3.nmbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg003
            
            #add-point:AFTER FIELD nmbg003 name="construct.a.page3.nmbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg004
            #add-point:ON ACTION controlp INFIELD nmbg004 name="construct.c.page3.nmbg004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbg004  #顯示到畫面上
            NEXT FIELD nmbg004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg004
            #add-point:BEFORE FIELD nmbg004 name="construct.b.page3.nmbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg004
            
            #add-point:AFTER FIELD nmbg004 name="construct.a.page3.nmbg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg005
            #add-point:ON ACTION controlp INFIELD nmbg005 name="construct.c.page3.nmbg005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160122-00001#2 -add -str
            LET g_qryparam.where = " nmas002 IN (",g_sql_bank,")"   #160122-00001#2 By 07900 --mod
            #160122-00001#2 -add -end
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbg004  #顯示到畫面上
            NEXT FIELD nmbg004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg005
            #add-point:BEFORE FIELD nmbg005 name="construct.b.page3.nmbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg005
            
            #add-point:AFTER FIELD nmbg005 name="construct.a.page3.nmbg005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg012
            #add-point:BEFORE FIELD nmbg012 name="construct.b.page3.nmbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg012
            
            #add-point:AFTER FIELD nmbg012 name="construct.a.page3.nmbg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg012
            #add-point:ON ACTION controlp INFIELD nmbg012 name="construct.c.page3.nmbg012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.nmbg025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg025
            #add-point:ON ACTION controlp INFIELD nmbg025 name="construct.c.page3.nmbg025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add  
            DISPLAY g_qryparam.return1 TO nmbg025  #顯示到畫面上
            NEXT FIELD nmbg025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg025
            #add-point:BEFORE FIELD nmbg025 name="construct.b.page3.nmbg025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg025
            
            #add-point:AFTER FIELD nmbg025 name="construct.a.page3.nmbg025"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg007
            #add-point:BEFORE FIELD nmbg007 name="construct.b.page3.nmbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg007
            
            #add-point:AFTER FIELD nmbg007 name="construct.a.page3.nmbg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg007
            #add-point:ON ACTION controlp INFIELD nmbg007 name="construct.c.page3.nmbg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg009
            #add-point:BEFORE FIELD nmbg009 name="construct.b.page3.nmbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg009
            
            #add-point:AFTER FIELD nmbg009 name="construct.a.page3.nmbg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg009
            #add-point:ON ACTION controlp INFIELD nmbg009 name="construct.c.page3.nmbg009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.nmbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg010
            #add-point:ON ACTION controlp INFIELD nmbg010 name="construct.c.page3.nmbg010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmbg010  #顯示到畫面上
            NEXT FIELD nmbg010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg010
            #add-point:BEFORE FIELD nmbg010 name="construct.b.page3.nmbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg010
            
            #add-point:AFTER FIELD nmbg010 name="construct.a.page3.nmbg010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg021
            #add-point:BEFORE FIELD nmbg021 name="construct.b.page3.nmbg021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg021
            
            #add-point:AFTER FIELD nmbg021 name="construct.a.page3.nmbg021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.nmbg021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg021
            #add-point:ON ACTION controlp INFIELD nmbg021 name="construct.c.page3.nmbg021"
            
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
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "nmbm_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbo_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "nmbg_t" 
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
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION anmt940_filter()
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
      CONSTRUCT g_wc_filter ON nmbmdocno
                          FROM s_browse[1].b_nmbmdocno
 
         BEFORE CONSTRUCT
               DISPLAY anmt940_filter_parser('nmbmdocno') TO s_browse[1].b_nmbmdocno
      
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
 
      CALL anmt940_filter_show('nmbmdocno')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION anmt940_filter_parser(ps_field)
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
 
{<section id="anmt940.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION anmt940_filter_show(ps_field)
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
   LET ls_condition = anmt940_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION anmt940_query()
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
   CALL g_nmbo_d.clear()
   CALL g_nmbo2_d.clear()
   CALL g_nmbo3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL anmt940_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL anmt940_browser_fill("")
      CALL anmt940_fetch("")
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
      CALL anmt940_filter_show('nmbmdocno')
   CALL anmt940_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL anmt940_fetch("F") 
      #顯示單身筆數
      CALL anmt940_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION anmt940_fetch(p_flag)
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
   
   LET g_nmbm_m.nmbmdocno = g_browser[g_current_idx].b_nmbmdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
   #遮罩相關處理
   LET g_nmbm_m_mask_o.* =  g_nmbm_m.*
   CALL anmt940_nmbm_t_mask()
   LET g_nmbm_m_mask_n.* =  g_nmbm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt940_set_act_visible()   
   CALL anmt940_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,insert,modify_detail", TRUE)
   IF g_nmbm_m.nmbmstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbm_m_t.* = g_nmbm_m.*
   LET g_nmbm_m_o.* = g_nmbm_m.*
   
   LET g_data_owner = g_nmbm_m.nmbmownid      
   LET g_data_dept  = g_nmbm_m.nmbmowndp
   
   #重新顯示   
   CALL anmt940_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.insert" >}
#+ 資料新增
PRIVATE FUNCTION anmt940_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_nmbo_d.clear()   
   CALL g_nmbo2_d.clear()  
   CALL g_nmbo3_d.clear()  
 
 
   INITIALIZE g_nmbm_m.* TO NULL             #DEFAULT 設定
   
   LET g_nmbmdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbm_m.nmbmownid = g_user
      LET g_nmbm_m.nmbmowndp = g_dept
      LET g_nmbm_m.nmbmcrtid = g_user
      LET g_nmbm_m.nmbmcrtdp = g_dept 
      LET g_nmbm_m.nmbmcrtdt = cl_get_current()
      LET g_nmbm_m.nmbmmodid = g_user
      LET g_nmbm_m.nmbmmoddt = cl_get_current()
      LET g_nmbm_m.nmbmstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_nmbm_m_t.* = g_nmbm_m.*
      LET g_nmbm_m_o.* = g_nmbm_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbm_m.nmbmstus 
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
 
 
 
    
      CALL anmt940_input("a")
      
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
         INITIALIZE g_nmbm_m.* TO NULL
         INITIALIZE g_nmbo_d TO NULL
         INITIALIZE g_nmbo2_d TO NULL
         INITIALIZE g_nmbo3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL anmt940_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_nmbo_d.clear()
      #CALL g_nmbo2_d.clear()
      #CALL g_nmbo3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt940_set_act_visible()   
   CALL anmt940_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbment = " ||g_enterprise|| " AND",
                      " nmbmdocno = '", g_nmbm_m.nmbmdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt940_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE anmt940_cl
   
   CALL anmt940_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
   
   #遮罩相關處理
   LET g_nmbm_m_mask_o.* =  g_nmbm_m.*
   CALL anmt940_nmbm_t_mask()
   LET g_nmbm_m_mask_n.* =  g_nmbm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
       g_nmbm_m.nmbmownid,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtid_desc,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid, 
       g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfid_desc,g_nmbm_m.nmbmcnfdt 
 
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_nmbm_m.nmbmownid      
   LET g_data_dept  = g_nmbm_m.nmbmowndp
   
   #功能已完成,通報訊息中心
   CALL anmt940_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.modify" >}
#+ 資料修改
PRIVATE FUNCTION anmt940_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_nmbm_m_t.* = g_nmbm_m.*
   LET g_nmbm_m_o.* = g_nmbm_m.*
   
   IF g_nmbm_m.nmbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
   CALL s_transaction_begin()
   
   OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt940_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
   #檢查是否允許此動作
   IF NOT anmt940_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbm_m_mask_o.* =  g_nmbm_m.*
   CALL anmt940_nmbm_t_mask()
   LET g_nmbm_m_mask_n.* =  g_nmbm_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL anmt940_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_nmbm_m.nmbmmodid = g_user 
LET g_nmbm_m.nmbmmoddt = cl_get_current()
LET g_nmbm_m.nmbmmodid_desc = cl_get_username(g_nmbm_m.nmbmmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_nmbm_m.nmbmstus MATCHES "[DR]" THEN 
         LET g_nmbm_m.nmbmstus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL anmt940_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE nmbm_t SET (nmbmmodid,nmbmmoddt) = (g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt)
          WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbmdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_nmbm_m.* = g_nmbm_m_t.*
            CALL anmt940_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_nmbm_m.nmbmdocno != g_nmbm_m_t.nmbmdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE nmbo_t SET nmbodocno = g_nmbm_m.nmbmdocno
 
          WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m_t.nmbmdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbo_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
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
         
         UPDATE nmbg_t
            SET nmbgdocno = g_nmbm_m.nmbmdocno
 
          WHERE nmbgent = g_enterprise AND
                nmbgdocno = g_nmbmdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "nmbg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL anmt940_set_act_visible()   
   CALL anmt940_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " nmbment = " ||g_enterprise|| " AND",
                      " nmbmdocno = '", g_nmbm_m.nmbmdocno, "' "
 
   #填到對應位置
   CALL anmt940_browser_fill("")
 
   CLOSE anmt940_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt940_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="anmt940.input" >}
#+ 資料輸入
PRIVATE FUNCTION anmt940_input(p_cmd)
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
   DEFINE  r_success             LIKE type_t.num5
   DEFINE  l_nmbm001_comp        LIKE ooef_t.ooef017
   DEFINE  l_rate2               LIKE apca_t.apca121      #匯率
   DEFINE  l_rate3               LIKE apca_t.apca121      #匯率
   DEFINE  l_glaa001             LIKE glaa_t.glaa001      #本幣幣別
   DEFINE  l_glaa005             LIKE glaa_t.glaa005      #現金變動參照表
   DEFINE  l_nmbo006             LIKE nmbo_t.nmbo006      #對應撥出項次之幣別
   DEFINE  l_nmbo012             LIKE nmbo_t.nmbo012      #對應撥出項次之出帳日期
   DEFINE  l_nmbgseq             LIKE nmbg_t.nmbgseq      #暫存項次
   DEFINE  l_glaa003             LIKE glaa_t.glaa003      #2014/12/29 liuym add  
   DEFINE  l_glaa024             LIKE glaa_t.glaa024      #2014/12/29 liuym add  
   DEFINE  l_origin_str          STRING  #160912-00024#1 
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
   DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
       g_nmbm_m.nmbmownid,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtid_desc,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid, 
       g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfid_desc,g_nmbm_m.nmbmcnfdt 
 
   
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
   LET g_forupd_sql = "SELECT nmboseq,nmboseq2,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005,nmbo012, 
       nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmboseq,nmboseq2,nmbo002,nmbo001, 
       nmbo006,nmbo008,nmbo014,nmbo015,nmbo007,nmbo016,nmbo017,nmbo018 FROM nmbo_t WHERE nmboent=? AND  
       nmbodocno=? AND nmboseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt940_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT nmbgseq,nmbgseq2,nmbg001,nmbg003,nmbg004,nmbg006,nmbg005,nmbg012,nmbg025, 
       nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021 FROM nmbg_t WHERE nmbgent=? AND nmbgdocno=?  
       AND nmbgseq2=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmt940_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL anmt940_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL anmt940_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="anmt940.input.head" >}
      #單頭段
      INPUT BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL anmt940_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #新增時強制從單頭開始填
            IF p_cmd = 'a' THEN
               NEXT FIELD nmbm001
            ELSE
               CASE g_aw
                  WHEN "s_detail1"
                     NEXT FIELD nmboseq
                  WHEN "s_detail2"
                     NEXT FIELD nmboseq_2
                  WHEN "s_detail3"
                     NEXT FIELD nmbgseq
    
               END CASE
            END IF
            #end add-point
            CALL anmt940_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbm001
            
            #add-point:AFTER FIELD nmbm001 name="input.a.nmbm001"
            LET g_nmbm_m.nmbm001_desc = ' '
            DISPLAY BY NAME g_nmbm_m.nmbm001_desc
            IF NOT cl_null(g_nmbm_m.nmbm001) THEN 
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_nmbm_m.nmbm001 != g_nmbm_m_t.nmbm001 OR g_nmbm_m_t.nmbm001 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbm_m_o.nmbm001) OR g_nmbm_m.nmbm001 != g_nmbm_m_o.nmbm001 THEN #160824-00007#324 170117 By 08171 add
#此段落由子樣板a19產生
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbm_m.nmbm001  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbm_m.nmbm001 = g_nmbm_m_t.nmbm001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbm_m.nmbm001 = g_nmbm_m_o.nmbm001 #160824-00007#324 170117 By 08171 add
                     LET g_nmbm_m.nmbm001_desc = s_desc_get_department_desc(g_nmbm_m.nmbm001)
                     DISPLAY BY NAME g_nmbm_m.nmbm001_desc                     
                     NEXT FIELD CURRENT
                  END IF
                  #取得資金中心所屬的法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_nmbm_m.nmbm001)
                   RETURNING g_sub_success,g_errno,l_nmbm001_comp,g_glaald  
                  CALL s_fin_account_center_with_ld_chk(g_nmbm_m.nmbm001,g_glaald,g_user,'6','Y','',g_today)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbm_m.nmbm001 = g_nmbm_m_t.nmbm001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbm_m.nmbm001 = g_nmbm_m_o.nmbm001 #160824-00007#324 170117 By 08171 add
                     LET g_nmbm_m.nmbm001_desc = s_desc_get_department_desc(g_nmbm_m.nmbm001)
                     DISPLAY BY NAME g_nmbm_m.nmbm001_desc                                                               
                     NEXT FIELD CURRENT
                  END IF  
                  #取得單據別參照表glaa024,後面於指定單別時使用
                  LET l_glaa024 = ''
                  CALL s_ld_sel_glaa(g_glaald,'glaa024') RETURNING  r_success,l_glaa024  
                  CALL anmt940_get_comp_wc(g_nmbm_m.nmbm001) RETURNING l_comp_wc                     
               END IF
            END IF            
            LET g_nmbm_m.nmbm001_desc = s_desc_get_department_desc(g_nmbm_m.nmbm001)
            DISPLAY BY NAME g_nmbm_m.nmbm001_desc
            LET g_nmbm_m_o.* = g_nmbm_m.* #160824-00007#324 170117 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbm001
            #add-point:BEFORE FIELD nmbm001 name="input.b.nmbm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbm001
            #add-point:ON CHANGE nmbm001 name="input.g.nmbm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmdocno
            #add-point:BEFORE FIELD nmbmdocno name="input.b.nmbmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmdocno
            
            #add-point:AFTER FIELD nmbmdocno name="input.a.nmbmdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_nmbm_m.nmbmdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_nmbm_m.nmbmdocno != g_nmbmdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbm_t WHERE "||"nmbment = '" ||g_enterprise|| "' AND "||"nmbmdocno = '"||g_nmbm_m.nmbmdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_nmbm_m.nmbmdocno) THEN
               
               #CALL s_aooi200_chk_slip(l_nmbm001_comp,l_glaa024,g_nmbm_m.nmbmdocno,'anmt940') RETURNING g_sub_success     #2014/12/29 liuym mark 
               CALL s_aooi200_fin_chk_slip(g_glaald,l_glaa024,g_nmbm_m.nmbmdocno,'anmt940') RETURNING g_sub_success        #2014/12/29 liuym add 
               IF NOT g_sub_success THEN
                  LET g_nmbm_m.nmbmdocno = g_nmbm_m_t.nmbmdocno
                  NEXT FIELD nmbmdocno
               END IF

            END IF            



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbmdocno
            #add-point:ON CHANGE nmbmdocno name="input.g.nmbmdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmdocdt
            #add-point:BEFORE FIELD nmbmdocdt name="input.b.nmbmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmdocdt
            
            #add-point:AFTER FIELD nmbmdocdt name="input.a.nmbmdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbmdocdt
            #add-point:ON CHANGE nmbmdocdt name="input.g.nmbmdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbmstus
            #add-point:BEFORE FIELD nmbmstus name="input.b.nmbmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbmstus
            
            #add-point:AFTER FIELD nmbmstus name="input.a.nmbmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbmstus
            #add-point:ON CHANGE nmbmstus name="input.g.nmbmstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmbm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbm001
            #add-point:ON ACTION controlp INFIELD nmbm001 name="input.c.nmbm001"
            #資金中心
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbm_m.nmbm001
            LET g_qryparam.where = " ooef206 = 'Y' "
            LET g_qryparam.where = g_qryparam.where," AND ooefstus= 'Y'" #161021-00050#11
            #CALL q_ooef001()    #161021-00050#11 mark
            CALL q_ooef001_33()  #161021-00050#11
            LET g_nmbm_m.nmbm001 = g_qryparam.return1
            DISPLAY g_nmbm_m.nmbm001 TO nmbm001
            DISPLAY g_nmbm_m.nmbm001_desc TO nmbm001_desc
            NEXT FIELD nmbm001
            #END add-point
 
 
         #Ctrlp:input.c.nmbmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmdocno
            #add-point:ON ACTION controlp INFIELD nmbmdocno name="input.c.nmbmdocno"
            #此段落由子樣板a07產生            
            #開窗i段             
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbm_m.nmbmdocno             #給予default值

            LET g_qryparam.where = " ooba001 = '",l_glaa024,"' AND oobx003 = 'anmt940'"
            
            CALL q_ooba002()                                #呼叫開窗

            LET g_nmbm_m.nmbmdocno = g_qryparam.return1              
            DISPLAY g_nmbm_m.nmbmdocno TO nmbmdocno              #
            NEXT FIELD nmbmdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.nmbmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmdocdt
            #add-point:ON ACTION controlp INFIELD nmbmdocdt name="input.c.nmbmdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmbmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbmstus
            #add-point:ON ACTION controlp INFIELD nmbmstus name="input.c.nmbmstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_nmbm_m.nmbmdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               #CALL s_aooi200_gen_docno(l_nmbm001_comp,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_prog)                      #2014/12/29 liuym mark
               SELECT glaa003,glaa024 INTO l_glaa003,l_glaa024 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=g_glaald  #2014/12/29 liuym add
               CALL s_aooi200_fin_gen_docno(g_glaald,l_glaa024,l_glaa003,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_prog)     #2014/12/29 liuym add
               RETURNING g_sub_success,g_nmbm_m.nmbmdocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_nmbm_m.nmbmdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD nmbmdocno
               END IF
               #end add-point
               
               INSERT INTO nmbm_t (nmbment,nmbm001,nmbmdocno,nmbmdocdt,nmbmstus,nmbmownid,nmbmowndp, 
                   nmbmcrtid,nmbmcrtdp,nmbmcrtdt,nmbmmodid,nmbmmoddt,nmbmcnfid,nmbmcnfdt)
               VALUES (g_enterprise,g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
                   g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt, 
                   g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_nmbm_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
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
                  CALL anmt940_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL anmt940_b_fill()
                  CALL anmt940_b_fill2('0')
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
               CALL anmt940_nmbm_t_mask_restore('restore_mask_o')
               
               UPDATE nmbm_t SET (nmbm001,nmbmdocno,nmbmdocdt,nmbmstus,nmbmownid,nmbmowndp,nmbmcrtid, 
                   nmbmcrtdp,nmbmcrtdt,nmbmmodid,nmbmmoddt,nmbmcnfid,nmbmcnfdt) = (g_nmbm_m.nmbm001, 
                   g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp, 
                   g_nmbm_m.nmbmcrtid,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt, 
                   g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfdt)
                WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbmdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "nmbm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL anmt940_nmbm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_nmbm_m_t)
               LET g_log2 = util.JSON.stringify(g_nmbm_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="anmt940.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_nmbo_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbo_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt940_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_nmbo_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL anmt940_show()
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
            OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbo_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbo_d[l_ac].nmboseq2 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_nmbo_d_t.* = g_nmbo_d[l_ac].*  #BACKUP
               LET g_nmbo_d_o.* = g_nmbo_d[l_ac].*  #BACKUP
               CALL anmt940_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL anmt940_set_no_entry_b(l_cmd)
               IF NOT anmt940_lock_b("nmbo_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt940_bcl INTO g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2,g_nmbo_d[l_ac].nmbo002, 
                      g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004,g_nmbo_d[l_ac].nmbo006, 
                      g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025,g_nmbo_d[l_ac].nmbo008, 
                      g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010,g_nmbo_d[l_ac].nmbo011, 
                      g_nmbo_d[l_ac].nmbo013,g_nmbo_d[l_ac].nmbo021,g_nmbo2_d[l_ac].nmboseq,g_nmbo2_d[l_ac].nmboseq2, 
                      g_nmbo2_d[l_ac].nmbo002,g_nmbo2_d[l_ac].nmbo001,g_nmbo2_d[l_ac].nmbo006,g_nmbo2_d[l_ac].nmbo008, 
                      g_nmbo2_d[l_ac].nmbo014,g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo007,g_nmbo2_d[l_ac].nmbo016, 
                      g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbo_d_t.nmboseq2,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbo_d_mask_o[l_ac].* =  g_nmbo_d[l_ac].*
                  CALL anmt940_nmbo_t_mask()
                  LET g_nmbo_d_mask_n[l_ac].* =  g_nmbo_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt940_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #控制內部銀行帳戶欄位及給值
            CALL anmt940_set_nmbo005()
            IF l_cmd = 'u' THEN
               #取得組織代碼的所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_nmbo_d[l_ac].nmbo001)
                RETURNING g_sub_success,g_errno,g_nmbo_d[l_ac].glaacomp,g_nmbo_d[l_ac].glaald            
               #取本幣幣別+現金變動參照表號
               LET l_glaa001=''
               CALL s_ld_sel_glaa(g_nmbo_d[l_ac].glaald,'glaa001|glaa005')
                    RETURNING  g_sub_success,l_glaa001,l_glaa005    
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
            INITIALIZE g_nmbo_d[l_ac].* TO NULL 
            INITIALIZE g_nmbo_d_t.* TO NULL 
            INITIALIZE g_nmbo_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_nmbo_d[l_ac].nmbo021 = 'N'
            
            #160912-00024#1 add s---
            LET g_nmbo_d[l_ac].nmbo001 = g_nmbm_m.nmbm001
            SELECT COUNT(*) INTO l_count FROM ooef_t WHERE ooefent = g_enterprise
               AND ooef201 = 'Y'
               AND ooef001 = g_nmbo_d[l_ac].nmbo001
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_nmbo_d[l_ac].nmbo001 = ''
            END IF  
            #160912-00024#1 add e---              
            #end add-point
            LET g_nmbo_d_t.* = g_nmbo_d[l_ac].*     #新輸入資料
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt940_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt940_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbo_d[li_reproduce_target].* = g_nmbo_d[li_reproduce].*
               LET g_nmbo2_d[li_reproduce_target].* = g_nmbo2_d[li_reproduce].*
 
               LET g_nmbo_d[li_reproduce_target].nmboseq2 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            #預帶項次
            IF l_cmd = 'a' THEN
               IF cl_null(g_nmbo_d[g_detail_idx].nmboseq) THEN
                  SELECT MAX(nmboseq) INTO g_nmbo_d[g_detail_idx].nmboseq
                    FROM nmbo_t
                   WHERE nmboent = g_enterprise
                     AND nmbodocno = g_nmbm_m.nmbmdocno

                  IF cl_null(g_nmbo_d[g_detail_idx].nmboseq) THEN
                     LET g_nmbo_d[g_detail_idx].nmboseq = 1
                  ELSE
                     LET g_nmbo_d[g_detail_idx].nmboseq = g_nmbo_d[g_detail_idx].nmboseq + 1
                  END IF
                  LET g_nmbo_d[g_detail_idx].nmboseq2 = g_nmbo_d[g_detail_idx].nmboseq                  
               END IF
            END IF
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
            SELECT COUNT(1) INTO l_count FROM nmbo_t 
             WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
 
               AND nmboseq2 = g_nmbo_d[l_ac].nmboseq2
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys[2] = g_nmbo_d[g_detail_idx].nmboseq2
               CALL anmt940_insert_b('nmbo_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_nmbo_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt940_b_fill()
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
               LET gs_keys[01] = g_nmbm_m.nmbmdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_nmbo_d_t.nmboseq2
 
            
               #刪除同層單身
               IF NOT anmt940_delete_b('nmbo_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt940_key_delete_b(gs_keys,'nmbo_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt940_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  #要同步刪除費用訊息
                  DELETE FROM nmbo_t
                   WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno AND
    
                         nmboseq2 = g_nmbo_d_t.nmboseq2 + 200
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbo_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
    
                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF                  
               #end add-point
               LET l_count = g_nmbo_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbo_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmboseq
            #add-point:BEFORE FIELD nmboseq name="input.b.page1.nmboseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmboseq
            
            #add-point:AFTER FIELD nmboseq name="input.a.page1.nmboseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmbm_m.nmbmdocno IS NOT NULL AND g_nmbo_d[g_detail_idx].nmboseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmbm_m.nmbmdocno != g_nmbmdocno_t OR g_nmbo_d[g_detail_idx].nmboseq != g_nmbo_d_t.nmboseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbo_t WHERE "||"nmboent = '" ||g_enterprise|| "' AND "||"nmbodocno = '"||g_nmbm_m.nmbmdocno ||"' AND "|| "nmboseq = '"||g_nmbo_d[g_detail_idx].nmboseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #撥出單身項次不可大於100筆,避免寫入銀存收支檔時會與撥出記錄項次重複
            IF g_nmbo_d[g_detail_idx].nmboseq > 100 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00239'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT       
            END IF
            LET g_nmbo_d[g_detail_idx].nmboseq2 = g_nmbo_d[g_detail_idx].nmboseq                        

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmboseq
            #add-point:ON CHANGE nmboseq name="input.g.page1.nmboseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo002
            
            #add-point:AFTER FIELD nmbo002 name="input.a.page1.nmbo002"
            LET g_nmbo_d[l_ac].nmbnl003 = ' '
            DISPLAY BY NAME g_nmbo_d[l_ac].nmbnl003            
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo002) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo002 != g_nmbo_d_t.nmbo002 OR g_nmbo_d_t.nmbo002 IS NULL )) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo002
   
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00003:sub-01302|anmi110|",cl_get_progname("anmi110",g_lang,"2"),"|:EXEPROGanmi110"
                  #160318-00025#24  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmbn001") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo_d[l_ac].nmbo002 = g_nmbo_d_t.nmbo002 
                     
                     INITIALIZE g_ref_fields TO NULL
                     LET g_ref_fields[1] = g_nmbo_d[l_ac].nmbo002
                     CALL ap_ref_array2(g_ref_fields,"SELECT nmbnl003 FROM nmbnl_t WHERE nmbnlent='"||g_enterprise||"' AND nmbnl001=? AND nmbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
                     LET g_nmbo_d[l_ac].nmbnl003 = '', g_rtn_fields[1] , ''
                     DISPLAY BY NAME g_nmbo_d[l_ac].nmbnl003         
                     NEXT FIELD CURRENT
                  END IF
            
               END IF 
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_nmbo_d[l_ac].nmbo002
               CALL ap_ref_array2(g_ref_fields,"SELECT nmbnl003 FROM nmbnl_t WHERE nmbnlent='"||g_enterprise||"' AND nmbnl001=? AND nmbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_nmbo_d[l_ac].nmbnl003 = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_nmbo_d[l_ac].nmbnl003               
            END IF 

            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo002
            #add-point:BEFORE FIELD nmbo002 name="input.b.page1.nmbo002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo002
            #add-point:ON CHANGE nmbo002 name="input.g.page1.nmbo002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo001
            
            #add-point:AFTER FIELD nmbo001 name="input.a.page1.nmbo001"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo001) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo001 != g_nmbo_d_t.nmbo001 OR g_nmbo_d_t.nmbo001 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo_d_o.nmbo001) OR g_nmbo_d[l_ac].nmbo001 != g_nmbo_d_o.nmbo001 THEN #160824-00007#324 170117 By 08171 add
                 #IF g_nmbo_d[l_ac].nmbo001 != g_nmbo_d_t.nmbo001 THEN #160824-00007#324 170117 By 08171 mark
                  IF g_nmbo_d[l_ac].nmbo001 != g_nmbo_d_o.nmbo001 THEN #160824-00007#324 170117 By 08171 add
                     IF NOT cl_ask_confirm('anm-00256') THEN   #是否確定變更
                       #LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_t.nmbo001 #160824-00007#324 170117 By 08171 mark
                        LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_o.nmbo001 #160824-00007#324 170117 By 08171 add
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_nmbo_d[l_ac].nmbo003 = ''
                        LET g_nmbo_d[l_ac].nmbo004 = ''
                        LET g_nmbo_d[l_ac].nmaal003 = ''
                        LET g_nmbo_d[l_ac].nmbo006 = ''
                        LET g_nmbo_d[l_ac].nmbo007 = ''
                        LET g_nmbo_d[l_ac].nmbo009 = ''
                        LET g_nmbo_d[l_ac].nmbo011 = ''
                     END IF
                     
                  END IF               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo001
   
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end   
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_t.nmbo001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_o.nmbo001 #160824-00007#324 170117 By 08171 add              
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160912-00024#1 add s---
                  CALL s_anm_get_site_wc('6',g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmbm_m.nmbm001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_t.nmbo001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_o.nmbo001 #160824-00007#324 170117 By 08171 add
                     NEXT FIELD CURRENT
                  END IF                  
                  #160912-00024#1 add e---
                  
                  #檢查輸入組織代碼是否存在資金中心下法人範圍內
                  #IF s_chr_get_index_of(l_comp_wc,g_nmbo_d[l_ac].nmbo001,1) = 0 THEN #160912-00024#1 mark
                  IF s_chr_get_index_of(g_site_wc,g_nmbo_d[l_ac].nmbo001,1) = 0 THEN #160912-00024#1
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00274'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_t.nmbo001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_o.nmbo001 #160824-00007#324 170117 By 08171 add
                     NEXT FIELD CURRENT                       
                  END IF
                 #CALL s_fin_account_center_with_ld_chk(g_nmbo_d[l_ac].nmbo001,g_glaald,g_user,'6','Y','',g_today)
                 #  RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_nmbo_d[l_ac].nmbo001 = g_nmbo_d_t.nmbo001                                                            
#                     NEXT FIELD CURRENT
#                  END IF         
                  #取得組織代碼的所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_nmbo_d[l_ac].nmbo001)
                   RETURNING g_sub_success,g_errno,g_nmbo_d[l_ac].glaacomp,g_nmbo_d[l_ac].glaald 
                  #取本幣幣別+現金變動參照表號
                  LET l_glaa001=''
                  CALL s_ld_sel_glaa(g_nmbo_d[l_ac].glaald,'glaa001|glaa005')
                       RETURNING  g_sub_success,l_glaa001,l_glaa005       
                  #LET g_nmbo_d_t.nmbo001 = g_nmbo_d[l_ac].nmbo001      #160824-00007#324 170117 By 08171 mark                              
               END IF               
            END IF 
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo001
            #add-point:BEFORE FIELD nmbo001 name="input.b.page1.nmbo001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo001
            #add-point:ON CHANGE nmbo001 name="input.g.page1.nmbo001"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo003
            
            #add-point:AFTER FIELD nmbo003 name="input.a.page1.nmbo003"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo003) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo003 != g_nmbo_d_t.nmbo003 OR g_nmbo_d_t.nmbo003 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo_d_o.nmbo003) OR g_nmbo_d[l_ac].nmbo003 != g_nmbo_d_o.nmbo003 THEN #160824-00007#324 170117 By 08171 add
                 #IF g_nmbo_d[l_ac].nmbo003 != g_nmbo_d_t.nmbo003 THEN #160824-00007#324 170117 By 08171 mark
                  IF g_nmbo_d[l_ac].nmbo003 != g_nmbo_d_o.nmbo003 THEN #160824-00007#324 170117 By 08171 add
                     IF NOT cl_ask_confirm('anm-00256') THEN   #是否確定變更
                       #LET g_nmbo_d[l_ac].nmbo003 = g_nmbo_d_t.nmbo003 #160824-00007#324 170117 By 08171 mark
                        LET g_nmbo_d[l_ac].nmbo003 = g_nmbo_d_o.nmbo003 #160824-00007#324 170117 By 08171 add
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_nmbo_d[l_ac].nmbo004 = ''
                        LET g_nmbo_d[l_ac].nmaal003 = ''
                        LET g_nmbo_d[l_ac].nmbo006 = ''
                     END IF
                  END IF                 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo003
                  LET g_chkparam.arg2 = g_nmbo_d[l_ac].nmbo001
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmab001_1") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo_d[l_ac].nmbo003 = g_nmbo_d_t.nmbo003 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo003 = g_nmbo_d_o.nmbo003 #160824-00007#324 170117 By 08171 add              
                     NEXT FIELD CURRENT
                  END IF
                  #LET g_nmbo_d_t.nmbo003 = g_nmbo_d[l_ac].nmbo003 #160824-00007#324 170117 By 08171 mark
               END IF               
            END IF 
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo003
            #add-point:BEFORE FIELD nmbo003 name="input.b.page1.nmbo003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo003
            #add-point:ON CHANGE nmbo003 name="input.g.page1.nmbo003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo004
            
            #add-point:AFTER FIELD nmbo004 name="input.a.page1.nmbo004"
            LET g_nmbo_d[l_ac].nmaal003 = ''
            LET g_nmbo_d[l_ac].nmbo006 = ''
            DISPLAY BY NAME g_nmbo_d[l_ac].nmaal003,g_nmbo_d[l_ac].nmbo006         
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo004) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo004 != g_nmbo_d_t.nmbo004 OR g_nmbo_d_t.nmbo004 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo_d_o.nmbo004) OR g_nmbo_d[l_ac].nmbo004 != g_nmbo_d_o.nmbo004 THEN #160824-00007#324 170117 By 08171 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo004
                  LET g_chkparam.arg2 = g_nmbo_d[l_ac].nmbo003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmas002") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo_d[l_ac].nmbo004 = g_nmbo_d_t.nmbo004 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo004 = g_nmbo_d_o.nmbo004 #160824-00007#324 170117 By 08171 add
                     LET g_nmbo_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo_d[l_ac].nmbo004)
                     LET g_nmbo_d[l_ac].nmbo006 = s_anm_get_nmas003(g_nmbo_d[l_ac].nmbo004)
                     DISPLAY BY NAME g_nmbo_d[l_ac].nmaal003,g_nmbo_d[l_ac].nmbo006                     
                     NEXT FIELD CURRENT
                  END IF 
                  #控制內部銀行帳戶欄位及給值
                  CALL anmt940_set_nmbo005()               
                   
               END IF
               LET g_nmbo_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo_d[l_ac].nmbo004)
               LET g_nmbo_d[l_ac].nmbo006 = s_anm_get_nmas003(g_nmbo_d[l_ac].nmbo004)
               DISPLAY BY NAME g_nmbo_d[l_ac].nmaal003,g_nmbo_d[l_ac].nmbo006                             
              
            END IF 
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 add #nmbo001預帶

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo004
            #add-point:BEFORE FIELD nmbo004 name="input.b.page1.nmbo004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo004
            #add-point:ON CHANGE nmbo004 name="input.g.page1.nmbo004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo005
            
            #add-point:AFTER FIELD nmbo005 name="input.a.page1.nmbo005"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo005) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo005 != g_nmbo_d_t.nmbo005 OR g_nmbo_d_t.nmbo005 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo005
                  LET g_chkparam.arg2 = g_nmbo_d[l_ac].nmbo003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmas002_5") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo_d[l_ac].nmbo005 = g_nmbo_d_t.nmbo005         
                     NEXT FIELD CURRENT
                  END IF 
                  #160122-00001#2--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmbo_d[l_ac].nmbo005,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbo_d[l_ac].nmbo005
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_nmbo_d[l_ac].nmbo005 = g_nmbo_d_t.nmbo005                 
                     NEXT FIELD CURRENT
 
                  END IF
                  #160122-00001#2--add---end
               END IF                            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo005
            #add-point:BEFORE FIELD nmbo005 name="input.b.page1.nmbo005"
            CALL anmt940_set_nmbo005()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo005
            #add-point:ON CHANGE nmbo005 name="input.g.page1.nmbo005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo012
            #add-point:BEFORE FIELD nmbo012 name="input.b.page1.nmbo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo012
            
            #add-point:AFTER FIELD nmbo012 name="input.a.page1.nmbo012"
            IF g_nmbo_d[l_ac].nmbo012 < g_nmbm_m.nmbmdocdt THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00273'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT             
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo012
            #add-point:ON CHANGE nmbo012 name="input.g.page1.nmbo012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo025
            
            #add-point:AFTER FIELD nmbo025 name="input.a.page1.nmbo025"
            LET g_nmbo_d[l_ac].pmaal004 = ' '
            DISPLAY BY NAME g_nmbo_d[l_ac].pmaal004              
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo025) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo025 != g_nmbo_d_t.nmbo025 OR g_nmbo_d_t.nmbo025 IS NULL )) THEN 
               
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo025
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
                  #160318-00025#24  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_22") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo_d[l_ac].nmbo025 = g_nmbo_d_t.nmbo025
                     LET g_nmbo_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo_d[l_ac].nmbo025)
                     DISPLAY BY NAME g_nmbo_d[l_ac].pmaal004                     
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo_d[l_ac].nmbo025)
                  DISPLAY BY NAME g_nmbo_d[l_ac].pmaal004             
               END IF                            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo025
            #add-point:BEFORE FIELD nmbo025 name="input.b.page1.nmbo025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo025
            #add-point:ON CHANGE nmbo025 name="input.g.page1.nmbo025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo_d[l_ac].nmbo008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD nmbo008
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbo008 name="input.a.page1.nmbo008"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo001) AND NOT cl_null(g_nmbo_d[l_ac].nmbo006) AND 
               NOT cl_null(g_nmbo_d[l_ac].nmbo008) THEN            
               #依原幣取位
               LET g_nmbo_d[l_ac].nmbo008 = s_curr_round(g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo006,g_nmbo_d[l_ac].nmbo008,2)
            END IF
            IF l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo008 != g_nmbo_d_t.nmbo008 OR g_nmbo_d_t.nmbo008 IS NULL ) THEN
               CALL anmt940_set_nmbg008(g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmbo008)
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo008
            #add-point:BEFORE FIELD nmbo008 name="input.b.page1.nmbo008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo008
            #add-point:ON CHANGE nmbo008 name="input.g.page1.nmbo008"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbO008) AND NOT cl_null(g_nmbo_d[l_ac].nmbo007) THEN             
               #預設本幣金額為原幣金額*匯率            
               LET g_nmbo_d[l_ac].nmbo009 = g_nmbo_d[l_ac].nmbo008 * g_nmbo_d[l_ac].nmbo007
               #依本幣取位
               IF NOT cl_null(g_nmbo_d[l_ac].nmbo001) AND NOT cl_null(l_glaa001) AND 
                  NOT cl_null(g_nmbo_d[l_ac].nmbo009) THEN                       
                  LET g_nmbo_d[l_ac].nmbo009 = s_curr_round(g_nmbo_d[l_ac].nmbo001,l_glaa001,g_nmbo_d[l_ac].nmbo009,2)
               END IF
               DISPLAY BY NAME g_nmbo_d[l_ac].nmbo009
               
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo007
            #add-point:BEFORE FIELD nmbo007 name="input.b.page1.nmbo007"
            #取匯率
            CALL s_fin_get_curr_rate(g_nmbo_d[l_ac].glaacomp,g_nmbo_d[l_ac].glaald,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo006,'S-FIN-4004')
                 RETURNING g_nmbo_d[l_ac].nmbo007,l_rate2,l_rate3
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo007
            
            #add-point:AFTER FIELD nmbo007 name="input.a.page1.nmbo007"
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 nmbo001預帶
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo007
            #add-point:ON CHANGE nmbo007 name="input.g.page1.nmbo007"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo_d[l_ac].nmbo009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD nmbo009
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbo009 name="input.a.page1.nmbo009"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo001) AND NOT cl_null(l_glaa001) AND 
               NOT cl_null(g_nmbo_d[l_ac].nmbo009) THEN        
               #依本幣取位
               LET g_nmbo_d[l_ac].nmbo009 = s_curr_round(g_nmbo_d[l_ac].nmbo001,l_glaa001,g_nmbo_d[l_ac].nmbo009,2)            
            END IF 

            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 nmbo001預帶
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo009
            #add-point:BEFORE FIELD nmbo009 name="input.b.page1.nmbo009"
            IF NOT cl_null(g_nmbo_d[l_ac].nmbO008) AND NOT cl_null(g_nmbo_d[l_ac].nmbO007) THEN
               #預設本幣金額為原幣金額*匯率            
               LET g_nmbo_d[l_ac].nmbo009 = g_nmbo_d[l_ac].nmbo008 * g_nmbo_d[l_ac].nmbo007
               #依本幣取位
               IF NOT cl_null(g_nmbo_d[l_ac].nmbo001) AND NOT cl_null(l_glaa001) AND 
                  NOT cl_null(g_nmbo_d[l_ac].nmbo009) THEN                 
                  LET g_nmbo_d[l_ac].nmbo009 = s_curr_round(g_nmbo_d[l_ac].nmbo001,l_glaa001,g_nmbo_d[l_ac].nmbo009,2)
               END IF
               DISPLAY BY NAME g_nmbo_d[l_ac].nmbo009
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo009
            #add-point:ON CHANGE nmbo009 name="input.g.page1.nmbo009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo010
            
            #add-point:AFTER FIELD nmbo010 name="input.a.page1.nmbo010"
            LET g_nmbo_d[l_ac].nmajl003 = ' '
            LET g_nmbo_d[l_ac].nmbo011 = ' '
            DISPLAY BY NAME g_nmbo_d[l_ac].nmajl003,g_nmbo_d[l_ac].nmbo011           
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo010) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo010 != g_nmbo_d_t.nmbo010 OR g_nmbo_d_t.nmbo010 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo_d_o.nmbo010) OR g_nmbo_d[l_ac].nmbo010 != g_nmbo_d_o.nmbo010 THEN #160824-00007#324 170117 By 08171 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo010
                  LET g_chkparam.arg2 = 2   
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#24  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo_d[l_ac].nmbo010 = g_nmbo_d_t.nmbo010 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo_d[l_ac].nmbo010 = g_nmbo_d_o.nmbo010 #160824-00007#324 170117 By 08171 add
                     LET g_nmbo_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo_d[l_ac].nmbo010)
                     LET g_nmbo_d[l_ac].nmbo011 = s_anm_get_nmad003(l_glaa005,g_nmbo_d[l_ac].nmbo010)
                     DISPLAY BY NAME g_nmbo_d[l_ac].nmajl003,g_nmbo_d[l_ac].nmbo011                    
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo_d[l_ac].nmbo010)
                  LET g_nmbo_d[l_ac].nmbo011 = s_anm_get_nmad003(l_glaa005,g_nmbo_d[l_ac].nmbo010)
                  DISPLAY BY NAME g_nmbo_d[l_ac].nmajl003,g_nmbo_d[l_ac].nmbo011            
               END IF                            
            END IF 
            LET g_nmbo_d_o.* = g_nmbo_d[l_ac].* #160824-00007#324 170117 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo010
            #add-point:BEFORE FIELD nmbo010 name="input.b.page1.nmbo010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo010
            #add-point:ON CHANGE nmbo010 name="input.g.page1.nmbo010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo011
            
            #add-point:AFTER FIELD nmbo011 name="input.a.page1.nmbo011"
            LET g_nmbo_d[l_ac].nmail004 = ' '
            DISPLAY BY NAME g_nmbo_d[l_ac].nmail004            
            IF NOT cl_null(g_nmbo_d[l_ac].nmbo011) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo_d[l_ac].nmbo011 != g_nmbo_d_t.nmbo011 OR g_nmbo_d_t.nmbo011 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo_d[l_ac].nmbo011  
                  LET g_chkparam.arg2 = l_glaa005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo_d[l_ac].nmbo011 = g_nmbo_d_t.nmbo011 
                     LET g_nmbo_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo_d[l_ac].nmbo011)
                     DISPLAY BY NAME g_nmbo_d[l_ac].nmail004                      
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo_d[l_ac].nmbo011)                             
                  DISPLAY BY NAME g_nmbo_d[l_ac].nmail004             
               END IF                            
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo011
            #add-point:BEFORE FIELD nmbo011 name="input.b.page1.nmbo011"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo011
            #add-point:ON CHANGE nmbo011 name="input.g.page1.nmbo011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.nmboseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmboseq
            #add-point:ON ACTION controlp INFIELD nmboseq name="input.c.page1.nmboseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo002
            #add-point:ON ACTION controlp INFIELD nmbo002 name="input.c.page1.nmbo002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo002             #給予default值



            
            CALL q_nmbn001()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo002 = g_qryparam.return1
            LET g_nmbo_d[l_ac].nmbnl003= g_qryparam.return2             

            DISPLAY BY NAME g_nmbo_d[l_ac].nmbo002,g_nmbo_d[l_ac].nmbnl003
            NEXT FIELD nmbo002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo001
            #add-point:ON ACTION controlp INFIELD nmbo001 name="input.c.page1.nmbo001"
            #播出單身/組織編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef001 IN ",l_comp_wc
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo001
            #160912-00024#1 add s---
            CALL s_anm_get_site_wc('6',g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocdt) RETURNING g_site_wc
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str
            LET g_qryparam.where = " ooef001 IN ",l_origin_str CLIPPED
            #160912-00024#1 add e---
            LET g_qryparam.where = g_qryparam.where ," AND ooef201 = 'Y'" #161021-00050#11
            CALL q_ooef001()
            LET g_nmbo_d[l_ac].nmbo001 = g_qryparam.return1
            DISPLAY g_nmbo_d[l_ac].nmbo001 TO nmbo001
            NEXT FIELD nmbo001
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo003
            #add-point:ON ACTION controlp INFIELD nmbo003 name="input.c.page1.nmbo003"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM nmaa_t ",
                                   "        WHERE nmaa004=nmab001 ",
                                   "          AND nmaaent = ",g_enterprise, #2015/04/02 by 02599 add
                                   "          AND nmaa002 = '",g_nmbo_d[l_ac].nmbo001,"')"
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo003             #給予default值


            
            CALL q_nmab001()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo003 = g_qryparam.return1              

            DISPLAY g_nmbo_d[l_ac].nmbo003 TO nmbo003              #

            NEXT FIELD nmbo003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo004
            #add-point:ON ACTION controlp INFIELD nmbo004 name="input.c.page1.nmbo004"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaa004 = '",g_nmbo_d[l_ac].nmbo003,"' "

            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo004             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_nmbo_d[l_ac].nmbo001#

            
            CALL q_nmas001()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo004 = g_qryparam.return1              
            LET g_nmbo_d[l_ac].nmaal003= s_desc_get_nmas002_desc(g_nmbo_d[l_ac].nmbo004)
            LET g_nmbo_d[l_ac].nmbo006 = s_anm_get_nmas003(g_nmbo_d[l_ac].nmbo004)
            DISPLAY g_nmbo_d[l_ac].nmbo004 TO nmbo004              #
            DISPLAY g_nmbo_d[l_ac].nmaal003 TO nmaal003
            DISPLAY g_nmbo_d[l_ac].nmbo006 TO nmbo006 
            NEXT FIELD nmbo004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo005
            #add-point:ON ACTION controlp INFIELD nmbo005 name="input.c.page1.nmbo005"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #160122-00001#2 -mark
#            LET g_qryparam.where = " EXISTS(SELECT 1 FROM nmab_t ",
#                                   "        WHERE nmaa004=nmab001 ",
#                                   "          AND nmaaent=nmabent ",
#                                   "          AND nmaaent=",g_enterprise, #2015/04/02 by 02599 add
#                                   "          AND nmab002 = '0')"  
            #160122-00001#2 -mark
            #160122-00001#2 -add -str
            LET g_qryparam.where =  " EXISTS(SELECT 1 FROM nmab_t ",
                                   "        WHERE nmaa004=nmab001 ",
                                   "          AND nmaaent=nmabent ",
                                   "          AND nmaaent=",g_enterprise, #2015/04/02 by 02599 add
                                   "          AND nmab002 = '0')"  ,
                                    " AND nmas002 IN (",g_sql_bank,")"    #160122-00001#2 By 07900 mod
            #160122-00001#2 -add -end
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo005             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_nmbo_d[l_ac].nmbo001#

            
            CALL q_nmas001()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo005 = g_qryparam.return1              
            DISPLAY g_nmbo_d[l_ac].nmbo005 TO nmbo005              #
            NEXT FIELD nmbo005                         #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo012
            #add-point:ON ACTION controlp INFIELD nmbo012 name="input.c.page1.nmbo012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo025
            #add-point:ON ACTION controlp INFIELD nmbo025 name="input.c.page1.nmbo025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa047 = 'Y'"
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo025             #給予default值



            
            # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add  

            LET g_nmbo_d[l_ac].nmbo025 = g_qryparam.return1              

            DISPLAY g_nmbo_d[l_ac].nmbo025 TO nmbo025              #
            LET g_nmbo_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo_d[l_ac].nmbo025)
            DISPLAY BY NAME g_nmbo_d[l_ac].pmaal004 
            NEXT FIELD nmbo025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo008
            #add-point:ON ACTION controlp INFIELD nmbo008 name="input.c.page1.nmbo008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo007
            #add-point:ON ACTION controlp INFIELD nmbo007 name="input.c.page1.nmbo007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo009
            #add-point:ON ACTION controlp INFIELD nmbo009 name="input.c.page1.nmbo009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo010
            #add-point:ON ACTION controlp INFIELD nmbo010 name="input.c.page1.nmbo010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo010             #給予default值



            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo010 = g_qryparam.return1              
            DISPLAY g_nmbo_d[l_ac].nmbo010 TO nmbo010              #
            LET g_nmbo_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo_d[l_ac].nmbo010)
            LET g_nmbo_d[l_ac].nmbo011 = s_anm_get_nmad003(l_glaa005,g_nmbo_d[l_ac].nmbo010)
            DISPLAY BY NAME g_nmbo_d[l_ac].nmajl003,g_nmbo_d[l_ac].nmbo011
            NEXT FIELD nmbo010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.nmbo011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo011
            #add-point:ON ACTION controlp INFIELD nmbo011 name="input.c.page1.nmbo011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            LET g_qryparam.default1 = g_nmbo_d[l_ac].nmbo011             #給予default值


            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmbo_d[l_ac].nmbo011 = g_qryparam.return1              
            DISPLAY g_nmbo_d[l_ac].nmbo011 TO nmbo011              #
            LET g_nmbo_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo_d[l_ac].nmbo011)
            DISPLAY BY NAME g_nmbo_d[l_ac].nmail004              
            NEXT FIELD nmbo011                          #返回原欄位


            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_nmbo_d[l_ac].* = g_nmbo_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt940_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_nmbo_d[l_ac].nmboseq2 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_nmbo_d[l_ac].* = g_nmbo_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL anmt940_nmbo_t_mask_restore('restore_mask_o')
      
               UPDATE nmbo_t SET (nmbodocno,nmboseq,nmboseq2,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006, 
                   nmbo005,nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmbo014, 
                   nmbo015,nmbo016,nmbo017,nmbo018) = (g_nmbm_m.nmbmdocno,g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2, 
                   g_nmbo_d[l_ac].nmbo002,g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004, 
                   g_nmbo_d[l_ac].nmbo006,g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025, 
                   g_nmbo_d[l_ac].nmbo008,g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010, 
                   g_nmbo_d[l_ac].nmbo011,g_nmbo_d[l_ac].nmbo013,g_nmbo_d[l_ac].nmbo021,g_nmbo2_d[l_ac].nmbo014, 
                   g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo016,g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018) 
 
                WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno 
 
                  AND nmboseq2 = g_nmbo_d_t.nmboseq2 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               UPDATE nmbo_t SET (nmbodocno,nmboseq,nmboseq2,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006, 
                   nmbo005,nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013) = 
                  (g_nmbm_m.nmbmdocno,g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2+200, 
                   g_nmbo_d[l_ac].nmbo002,g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004, 
                   g_nmbo_d[l_ac].nmbo006,g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025, 
                   g_nmbo_d[l_ac].nmbo008,g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010, 
                   g_nmbo_d[l_ac].nmbo011,g_nmbo_d[l_ac].nmbo013)
                WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno 
 
                  AND nmboseq2 = g_nmbo_d_t.nmboseq2+200 #項次
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbo_d[l_ac].* = g_nmbo_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbo_d[l_ac].* = g_nmbo_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys_bak[1] = g_nmbmdocno_t
               LET gs_keys[2] = g_nmbo_d[g_detail_idx].nmboseq2
               LET gs_keys_bak[2] = g_nmbo_d_t.nmboseq2
               CALL anmt940_update_b('nmbo_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL anmt940_nmbo_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_nmbo_d[g_detail_idx].nmboseq2 = g_nmbo_d_t.nmboseq2 
 
                  ) THEN
                  LET gs_keys[01] = g_nmbm_m.nmbmdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbo_d_t.nmboseq2
 
                  CALL anmt940_key_update_b(gs_keys,'nmbo_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL anmt940_unlock_b("nmbo_t","'1'")
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
               LET g_nmbo_d[li_reproduce_target].* = g_nmbo_d[li_reproduce].*
               LET g_nmbo2_d[li_reproduce_target].* = g_nmbo2_d[li_reproduce].*
 
               LET g_nmbo_d[li_reproduce_target].nmboseq2 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbo_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbo_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_nmbo2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            
            CALL anmt940_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmbo2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL anmt940_show()
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbo2_d[l_ac].* TO NULL 
            INITIALIZE g_nmbo2_d_t.* TO NULL 
            INITIALIZE g_nmbo2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_nmbo2_d_t.* = g_nmbo2_d[l_ac].*     #新輸入資料
            LET g_nmbo2_d_o.* = g_nmbo2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt940_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt940_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbo_d[li_reproduce_target].* = g_nmbo_d[li_reproduce].*
               LET g_nmbo2_d[li_reproduce_target].* = g_nmbo2_d[li_reproduce].*
 
               LET g_nmbo2_d[li_reproduce_target].nmboseq2 = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
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
            OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbo2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbo2_d[l_ac].nmboseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmbo2_d_t.* = g_nmbo2_d[l_ac].*  #BACKUP
               LET g_nmbo2_d_o.* = g_nmbo2_d[l_ac].*  #BACKUP
               CALL anmt940_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL anmt940_set_no_entry_b(l_cmd)
               IF NOT anmt940_lock_b("nmbo_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt940_bcl INTO g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2,g_nmbo_d[l_ac].nmbo002, 
                      g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004,g_nmbo_d[l_ac].nmbo006, 
                      g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025,g_nmbo_d[l_ac].nmbo008, 
                      g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010,g_nmbo_d[l_ac].nmbo011, 
                      g_nmbo_d[l_ac].nmbo013,g_nmbo_d[l_ac].nmbo021,g_nmbo2_d[l_ac].nmboseq,g_nmbo2_d[l_ac].nmboseq2, 
                      g_nmbo2_d[l_ac].nmbo002,g_nmbo2_d[l_ac].nmbo001,g_nmbo2_d[l_ac].nmbo006,g_nmbo2_d[l_ac].nmbo008, 
                      g_nmbo2_d[l_ac].nmbo014,g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo007,g_nmbo2_d[l_ac].nmbo016, 
                      g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbo2_d_mask_o[l_ac].* =  g_nmbo2_d[l_ac].*
                  CALL anmt940_nmbo_t_mask()
                  LET g_nmbo2_d_mask_n[l_ac].* =  g_nmbo2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt940_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            IF l_cmd = 'u' THEN
               #取得組織代碼的所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_nmbo2_d[l_ac].nmbo001)
                RETURNING g_sub_success,g_errno,g_nmbo2_d[l_ac].glaacomp,g_nmbo2_d[l_ac].glaald            
               #取本幣幣別+現金變動參照表號
               LET l_glaa001=''
               CALL s_ld_sel_glaa(g_nmbo2_d[l_ac].glaald,'glaa001|glaa005')
                    RETURNING  g_sub_success,l_glaa001,l_glaa005
               #控制存提碼是否必輸 
               IF g_nmbo2_d[l_ac].nmbo015 = 0 THEN
                  CALL cl_set_comp_required("nmbo017",FALSE)     
               ELSE
                  CALL cl_set_comp_required("nmbo017",TRUE) 
               END IF               
            END IF
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
               LET gs_keys[01] = g_nmbm_m.nmbmdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbo2_d_t.nmboseq2
            
               #刪除同層單身
               IF NOT anmt940_delete_b('nmbo_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt940_key_delete_b(gs_keys,'nmbo_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt940_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_nmbo_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbo2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM nmbo_t 
             WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
               AND nmboseq2 = g_nmbo2_d[l_ac].nmboseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys[2] = g_nmbo2_d[g_detail_idx].nmboseq2
               CALL anmt940_insert_b('nmbo_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbo_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt940_b_fill()
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
               LET g_nmbo2_d[l_ac].* = g_nmbo2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt940_bcl
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
               LET g_nmbo2_d[l_ac].* = g_nmbo2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
 
#               #end add-point
#               
#               #寫入修改者/修改日期資訊(單身2)
#               
#               
#               #將遮罩欄位還原
#               CALL anmt940_nmbo_t_mask_restore('restore_mask_o')
#                              
#               UPDATE nmbo_t SET (nmbodocno,nmboseq,nmboseq2,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006, 
#                   nmbo005,nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmbo014, 
#                   nmbo015,nmbo016,nmbo017,nmbo018) = (g_nmbm_m.nmbmdocno,g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2, 
#                   g_nmbo_d[l_ac].nmbo002,g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004, 
#                   g_nmbo_d[l_ac].nmbo006,g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025, 
#                   g_nmbo_d[l_ac].nmbo008,g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010, 
#                   g_nmbo_d[l_ac].nmbo011,g_nmbo_d[l_ac].nmbo013,g_nmbo_d[l_ac].nmbo021,g_nmbo2_d[l_ac].nmbo014, 
#                   g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo016,g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018)  
#                   #自訂欄位頁簽
#                WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
#                  AND nmboseq2 = g_nmbo2_d_t.nmboseq2 #項次 
#                  
#               #add-point:單身page2修改中 name="input.body2.m_update"
               UPDATE nmbo_t SET (nmbo014,nmbo015,nmbo016,nmbo017,nmbo018) = 
                  (g_nmbo2_d[l_ac].nmbo014,g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo016,g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018) 

                WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
                  AND nmboseq2 = g_nmbo2_d_t.nmboseq2 #項次 
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbo2_d[l_ac].* = g_nmbo2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbo_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbo2_d[l_ac].* = g_nmbo2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys_bak[1] = g_nmbmdocno_t
               LET gs_keys[2] = g_nmbo2_d[g_detail_idx].nmboseq2
               LET gs_keys_bak[2] = g_nmbo2_d_t.nmboseq2
               CALL anmt940_update_b('nmbo_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt940_nmbo_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmbo2_d[g_detail_idx].nmboseq2 = g_nmbo2_d_t.nmboseq2 
                  ) THEN
                  LET gs_keys[01] = g_nmbm_m.nmbmdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbo2_d_t.nmboseq2
                  CALL anmt940_key_update_b(gs_keys,'nmbo_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo2_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo2_d[l_ac].nmbo014,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD nmbo014
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbo014 name="input.a.page2.nmbo014"
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo014) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo014
            #add-point:BEFORE FIELD nmbo014 name="input.b.page2.nmbo014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo014
            #add-point:ON CHANGE nmbo014 name="input.g.page2.nmbo014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo2_d[l_ac].nmbo015,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD nmbo015
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbo015 name="input.a.page2.nmbo015"
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo001) AND NOT cl_null(g_nmbo2_d[l_ac].nmbo006) AND 
               NOT cl_null(g_nmbo2_d[l_ac].nmbo015) THEN           
               #依原幣取位
               LET g_nmbo2_d[l_ac].nmbo015 = s_curr_round(g_nmbo2_d[l_ac].nmbo001,g_nmbo2_d[l_ac].nmbo006,g_nmbo2_d[l_ac].nmbo015,2)
            END IF
            #控制存提碼是否必輸 
            IF g_nmbo2_d[l_ac].nmbo015 = 0 THEN
               CALL cl_set_comp_required("nmbo017",FALSE)     
            ELSE
               CALL cl_set_comp_required("nmbo017",TRUE) 
            END IF              
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo015
            #add-point:BEFORE FIELD nmbo015 name="input.b.page2.nmbo015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo015
            #add-point:ON CHANGE nmbo015 name="input.g.page2.nmbo015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo016
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo2_d[l_ac].nmbo016,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD nmbo016
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbo016 name="input.a.page2.nmbo016"
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo001) AND NOT cl_null(l_glaa001) AND 
               NOT cl_null(g_nmbo2_d[l_ac].nmbo016) THEN 
               #依本幣取位
               LET g_nmbo2_d[l_ac].nmbo016 = s_curr_round(g_nmbo2_d[l_ac].nmbo001,l_glaa001,g_nmbo2_d[l_ac].nmbo016,2)            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo016
            #add-point:BEFORE FIELD nmbo016 name="input.b.page2.nmbo016"
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo016) AND NOT cl_null(g_nmbo_d[l_ac].nmbO007) THEN
               #預設本幣金額為原幣金額*匯率
               LET g_nmbo2_d[l_ac].nmbo016 = g_nmbo2_d[l_ac].nmbo015 * g_nmbo2_d[l_ac].nmbo007
               #依本幣取位
               IF NOT cl_null(g_nmbo2_d[l_ac].nmbo001) AND NOT cl_null(l_glaa001) AND 
                  NOT cl_null(g_nmbo2_d[l_ac].nmbo016) THEN                
                  LET g_nmbo2_d[l_ac].nmbo016 = s_curr_round(g_nmbo2_d[l_ac].nmbo001,l_glaa001,g_nmbo2_d[l_ac].nmbo016,2)
               END IF
               DISPLAY BY NAME g_nmbo2_d[l_ac].nmbo016
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo016
            #add-point:ON CHANGE nmbo016 name="input.g.page2.nmbo016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo017
            
            #add-point:AFTER FIELD nmbo017 name="input.a.page2.nmbo017"
            LET g_nmbo2_d[l_ac].nmajl003 = ' '
            LET g_nmbo2_d[l_ac].nmbo018 = ' '
            DISPLAY BY NAME g_nmbo2_d[l_ac].nmajl003,g_nmbo2_d[l_ac].nmbo018          
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo017) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo2_d[l_ac].nmbo017 != g_nmbo2_d_t.nmbo017 OR g_nmbo2_d_t.nmbo017 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo2_d_o.nmbo017) OR g_nmbo2_d[l_ac].nmbo017 != g_nmbo2_d_o.nmbo017 THEN #160824-00007#324 170117 By 08171 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo2_d[l_ac].nmbo017
                  LET g_chkparam.arg2 = 2  
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#24  by 07900 --add-end                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo2_d[l_ac].nmbo017 = g_nmbo2_d_t.nmbo017  #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo2_d[l_ac].nmbo017 = g_nmbo2_d_o.nmbo017  #160824-00007#324 170117 By 08171 add
                     LET g_nmbo2_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo2_d[l_ac].nmbo017)
                     LET g_nmbo2_d[l_ac].nmbo018 = s_anm_get_nmad003(l_glaa005,g_nmbo2_d[l_ac].nmbo017)
                     DISPLAY BY NAME g_nmbo2_d[l_ac].nmajl003,g_nmbo2_d[l_ac].nmbo018                     
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo2_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo2_d[l_ac].nmbo017)
                  LET g_nmbo2_d[l_ac].nmbo018 = s_anm_get_nmad003(l_glaa005,g_nmbo2_d[l_ac].nmbo017)
                  DISPLAY BY NAME g_nmbo2_d[l_ac].nmajl003,g_nmbo2_d[l_ac].nmbo018            
               END IF                            
            END IF 
            LET g_nmbo2_d_o.* = g_nmbo2_d[l_ac].* #160824-00007#324 170117 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo017
            #add-point:BEFORE FIELD nmbo017 name="input.b.page2.nmbo017"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo017
            #add-point:ON CHANGE nmbo017 name="input.g.page2.nmbo017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbo018
            
            #add-point:AFTER FIELD nmbo018 name="input.a.page2.nmbo018"
            LET g_nmbo2_d[l_ac].nmail004 = ' '
            DISPLAY BY NAME g_nmbo2_d[l_ac].nmail004            
            IF NOT cl_null(g_nmbo2_d[l_ac].nmbo018) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo2_d[l_ac].nmbo018 != g_nmbo2_d_t.nmbo018 OR g_nmbo2_d_t.nmbo018 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo2_d[l_ac].nmbo018                    
                  LET g_chkparam.arg2 = l_glaa005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo2_d[l_ac].nmbo018 = g_nmbo2_d_t.nmbo018 
                     LET g_nmbo2_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo2_d[l_ac].nmbo018)
                     DISPLAY BY NAME g_nmbo2_d[l_ac].nmail004                      
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo2_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo2_d[l_ac].nmbo018)
                  DISPLAY BY NAME g_nmbo2_d[l_ac].nmail004            
               END IF                            
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbo018
            #add-point:BEFORE FIELD nmbo018 name="input.b.page2.nmbo018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbo018
            #add-point:ON CHANGE nmbo018 name="input.g.page2.nmbo018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.nmbo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo014
            #add-point:ON ACTION controlp INFIELD nmbo014 name="input.c.page2.nmbo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo015
            #add-point:ON ACTION controlp INFIELD nmbo015 name="input.c.page2.nmbo015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo016
            #add-point:ON ACTION controlp INFIELD nmbo016 name="input.c.page2.nmbo016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbo017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo017
            #add-point:ON ACTION controlp INFIELD nmbo017 name="input.c.page2.nmbo017"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_nmbo2_d[l_ac].nmbo017             #給予default值



            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbo2_d[l_ac].nmbo017 = g_qryparam.return1              
            DISPLAY g_nmbo2_d[l_ac].nmbo017 TO nmbo017              #
            LET g_nmbo2_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo2_d[l_ac].nmbo017)
            LET g_nmbo2_d[l_ac].nmbo018 = s_anm_get_nmad003(l_glaa005,g_nmbo2_d[l_ac].nmbo017)
            DISPLAY BY NAME g_nmbo2_d[l_ac].nmajl003,g_nmbo2_d[l_ac].nmbo018 
            NEXT FIELD nmbo017                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.nmbo018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbo018
            #add-point:ON ACTION controlp INFIELD nmbo018 name="input.c.page2.nmbo018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "
            LET g_qryparam.default1 = g_nmbo2_d[l_ac].nmbo018             #給予default值
            LET g_qryparam.default2 = "" #g_nmbo2_d[l_ac].nmad003 #現金異動碼


            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmbo2_d[l_ac].nmbo018 = g_qryparam.return1              
            DISPLAY g_nmbo2_d[l_ac].nmbo018 TO nmbo018              #
            LET g_nmbo2_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo2_d[l_ac].nmbo018)
            DISPLAY BY NAME g_nmbo2_d[l_ac].nmail004             
            NEXT FIELD nmbo018                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbo2_d[l_ac].* = g_nmbo2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt940_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt940_unlock_b("nmbo_t","'2'")
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
               LET g_nmbo_d[li_reproduce_target].* = g_nmbo_d[li_reproduce].*
               LET g_nmbo2_d[li_reproduce_target].* = g_nmbo2_d[li_reproduce].*
 
               LET g_nmbo2_d[li_reproduce_target].nmboseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbo2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbo2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_nmbo3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_nmbo3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL anmt940_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_nmbo3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            CALL anmt940_show()
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_nmbo3_d[l_ac].* TO NULL 
            INITIALIZE g_nmbo3_d_t.* TO NULL 
            INITIALIZE g_nmbo3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            LET g_nmbo3_d[l_ac].nmbg021 = 'N'
            
            #160912-00024#1 add s---
            LET g_nmbo3_d[l_ac].nmbg001 = g_nmbm_m.nmbm001
            SELECT COUNT(*) INTO l_count FROM ooef_t WHERE ooefent = g_enterprise
               AND ooef201 = 'Y'
               AND ooef001 = g_nmbo3_d[l_ac].nmbg001
            IF cl_null(l_count) THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_nmbo3_d[l_ac].nmbg001 = ''
            END IF  
            #160912-00024#1 add e---             
            #end add-point
            LET g_nmbo3_d_t.* = g_nmbo3_d[l_ac].*     #新輸入資料
            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL anmt940_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL anmt940_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_nmbo3_d[li_reproduce_target].* = g_nmbo3_d[li_reproduce].*
 
               LET g_nmbo3_d[li_reproduce_target].nmbgseq2 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            #預帶項次:帶出最小未對應項次
            IF l_cmd = 'a' THEN
               IF cl_null(g_nmbo3_d[g_detail_idx].nmbgseq) THEN
                  SELECT MIN(nmboseq) INTO g_nmbo3_d[g_detail_idx].nmbgseq
                    FROM nmbo_t
                   WHERE nmbodocno = g_nmbm_m.nmbmdocno
                     AND nmboent = g_enterprise
                     AND nmboseq2 <=100    #排除費用訊息
                     AND NOT EXISTS (SELECT 1 FROM nmbg_t WHERE nmbodocno = nmbgdocno AND nmboseq=nmbgseq
                                                            AND nmboent = nmbgent )#2015/04/02 by 02599 add
                     
                  LET g_nmbo3_d[g_detail_idx].nmbgseq2 = g_nmbo3_d[g_detail_idx].nmbgseq + 100
               END IF
            END IF
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
            OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE anmt940_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_nmbo3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_nmbo3_d[l_ac].nmbgseq2 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_nmbo3_d_t.* = g_nmbo3_d[l_ac].*  #BACKUP
               LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].*  #BACKUP
               CALL anmt940_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL anmt940_set_no_entry_b(l_cmd)
               IF NOT anmt940_lock_b("nmbg_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH anmt940_bcl2 INTO g_nmbo3_d[l_ac].nmbgseq,g_nmbo3_d[l_ac].nmbgseq2,g_nmbo3_d[l_ac].nmbg001, 
                      g_nmbo3_d[l_ac].nmbg003,g_nmbo3_d[l_ac].nmbg004,g_nmbo3_d[l_ac].nmbg006,g_nmbo3_d[l_ac].nmbg005, 
                      g_nmbo3_d[l_ac].nmbg012,g_nmbo3_d[l_ac].nmbg025,g_nmbo3_d[l_ac].nmbg008,g_nmbo3_d[l_ac].nmbg007, 
                      g_nmbo3_d[l_ac].nmbg009,g_nmbo3_d[l_ac].nmbg010,g_nmbo3_d[l_ac].nmbg011,g_nmbo3_d[l_ac].nmbg013, 
                      g_nmbo3_d[l_ac].nmbg021
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_nmbo3_d_mask_o[l_ac].* =  g_nmbo3_d[l_ac].*
                  CALL anmt940_nmbg_t_mask()
                  LET g_nmbo3_d_mask_n[l_ac].* =  g_nmbo3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL anmt940_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body3.before_row"
            #控制內部銀行帳戶欄位及給值
            CALL anmt940_set_nmbg005()
            IF l_cmd = 'u' THEN
               #取得組織代碼的所屬法人+帳別
               CALL s_fin_orga_get_comp_ld(g_nmbo3_d[l_ac].nmbg001)
                RETURNING g_sub_success,g_errno,g_nmbo3_d[l_ac].glaacomp,g_nmbo3_d[l_ac].glaald            
               #取本幣幣別+現金變動參照表號
               LET l_glaa001=''
               CALL s_ld_sel_glaa(g_nmbo3_d[l_ac].glaald,'glaa001|glaa005')
                    RETURNING  g_sub_success,l_glaa001,l_glaa005    
            END IF
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
               LET gs_keys[01] = g_nmbm_m.nmbmdocno
               LET gs_keys[gs_keys.getLength()+1] = g_nmbo3_d_t.nmbgseq2
            
               #刪除同層單身
               IF NOT anmt940_delete_b('nmbg_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT anmt940_key_delete_b(gs_keys,'nmbg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE anmt940_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE anmt940_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_nmbo_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_nmbo3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM nmbg_t 
             WHERE nmbgent = g_enterprise AND nmbgdocno = g_nmbm_m.nmbmdocno
               AND nmbgseq2 = g_nmbo3_d[l_ac].nmbgseq2
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys[2] = g_nmbo3_d[g_detail_idx].nmbgseq2
               CALL anmt940_insert_b('nmbg_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_nmbo_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL anmt940_b_fill()
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
               LET g_nmbo3_d[l_ac].* = g_nmbo3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt940_bcl2
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
               LET g_nmbo3_d[l_ac].* = g_nmbo3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL anmt940_nmbg_t_mask_restore('restore_mask_o')
                              
               UPDATE nmbg_t SET (nmbgdocno,nmbgseq,nmbgseq2,nmbg001,nmbg003,nmbg004,nmbg006,nmbg005, 
                   nmbg012,nmbg025,nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021) = (g_nmbm_m.nmbmdocno, 
                   g_nmbo3_d[l_ac].nmbgseq,g_nmbo3_d[l_ac].nmbgseq2,g_nmbo3_d[l_ac].nmbg001,g_nmbo3_d[l_ac].nmbg003, 
                   g_nmbo3_d[l_ac].nmbg004,g_nmbo3_d[l_ac].nmbg006,g_nmbo3_d[l_ac].nmbg005,g_nmbo3_d[l_ac].nmbg012, 
                   g_nmbo3_d[l_ac].nmbg025,g_nmbo3_d[l_ac].nmbg008,g_nmbo3_d[l_ac].nmbg007,g_nmbo3_d[l_ac].nmbg009, 
                   g_nmbo3_d[l_ac].nmbg010,g_nmbo3_d[l_ac].nmbg011,g_nmbo3_d[l_ac].nmbg013,g_nmbo3_d[l_ac].nmbg021)  
                   #自訂欄位頁簽
                WHERE nmbgent = g_enterprise AND nmbgdocno = g_nmbm_m.nmbmdocno
                  AND nmbgseq2 = g_nmbo3_d_t.nmbgseq2 #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_nmbo3_d[l_ac].* = g_nmbo3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_nmbo3_d[l_ac].* = g_nmbo3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_nmbm_m.nmbmdocno
               LET gs_keys_bak[1] = g_nmbmdocno_t
               LET gs_keys[2] = g_nmbo3_d[g_detail_idx].nmbgseq2
               LET gs_keys_bak[2] = g_nmbo3_d_t.nmbgseq2
               CALL anmt940_update_b('nmbg_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL anmt940_nmbg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_nmbo3_d[g_detail_idx].nmbgseq2 = g_nmbo3_d_t.nmbgseq2 
                  ) THEN
                  LET gs_keys[01] = g_nmbm_m.nmbmdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_nmbo3_d_t.nmbgseq2
                  CALL anmt940_key_update_b(gs_keys,'nmbg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo3_d_t)
               LET g_log2 = util.JSON.stringify(g_nmbm_m),util.JSON.stringify(g_nmbo3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbgseq
            #add-point:BEFORE FIELD nmbgseq name="input.b.page3.nmbgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbgseq
            
            #add-point:AFTER FIELD nmbgseq name="input.a.page3.nmbgseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_nmbm_m.nmbmdocno IS NOT NULL AND g_nmbo3_d[g_detail_idx].nmbgseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_nmbm_m.nmbmdocno != g_nmbmdocno_t OR g_nmbo3_d[g_detail_idx].nmbgseq != g_nmbo3_d_t.nmbgseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM nmbg_t WHERE "||"nmbgent = '" ||g_enterprise|| "' AND "||"nmbgdocno = '"||g_nmbm_m.nmbmdocno ||"' AND "|| "nmbgseq = '"||g_nmbo3_d[g_detail_idx].nmbgseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #撥出單身項次不可大於100筆,避免寫入銀存收支檔時會與撥出記錄項次重複
            IF g_nmbo3_d[g_detail_idx].nmbgseq > 100 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00239'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT       
            END IF
            CALL anmt940_get_nmbo(g_nmbo3_d[l_ac].nmbgseq,'nmbo008') RETURNING g_nmbo3_d[l_ac].nmbg008
            IF cl_null(g_nmbo3_d[l_ac].nmbg008) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'anm-00254'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT               
            END IF
            LET g_nmbo3_d[g_detail_idx].nmbgseq2 = g_nmbo3_d[g_detail_idx].nmbgseq + 100
            #取得對應項次撥出單身幣別
            CALL anmt940_get_nmbo(g_nmbo3_d[l_ac].nmbgseq,'nmbo006') RETURNING l_nmbo006  
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbgseq
            #add-point:ON CHANGE nmbgseq name="input.g.page3.nmbgseq"
            IF NOT cl_ask_confirm('anm-00256') THEN   #是否確定變更
               LET g_nmbo3_d[l_ac].nmbgseq = g_nmbo3_d_t.nmbgseq
               NEXT FIELD CURRENT
            ELSE
               LET l_nmbgseq = g_nmbo3_d[l_ac].nmbgseq
               INITIALIZE g_nmbo3_d[l_ac].* TO NULL                              
               LET g_nmbo3_d[l_ac].nmbgseq = l_nmbgseq
            END IF            
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg001
            
            #add-point:AFTER FIELD nmbg001 name="input.a.page3.nmbg001"
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg001) THEN 
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg001 != g_nmbo3_d_t.nmbg001 OR g_nmbo3_d_t.nmbg001 IS NULL )) THEN  #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo3_d_o.nmbg001) OR g_nmbo3_d[l_ac].nmbg001 != g_nmbo3_d_o.nmbg001 THEN #160824-00007#324 170117 By 08171 add
                 #IF g_nmbo3_d[l_ac].nmbg001 != g_nmbo3_d_t.nmbg001 THEN #160824-00007#324 170117 By 08171 mark
                  IF g_nmbo3_d[l_ac].nmbg001 != g_nmbo3_d_o.nmbg001 THEN #160824-00007#324 170117 By 08171 add
                     IF NOT cl_ask_confirm('anm-00256') THEN   #是否確定變更
                       #LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_t.nmbg001 #160824-00007#324 170117 By 08171 mark
                        LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_o.nmbg001 #160824-00007#324 170117 By 08171 add
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_nmbo3_d[l_ac].nmbg003 = ''
                        LET g_nmbo3_d[l_ac].nmbg004 = ''
                        LET g_nmbo3_d[l_ac].nmaal003 = ''
                        LET g_nmbo3_d[l_ac].nmbg006 = ''
                        LET g_nmbo3_d[l_ac].nmbg007 = ''
                        LET g_nmbo3_d[l_ac].nmbg009 = ''
                        LET g_nmbo3_d[l_ac].nmbg011 = ''
                     END IF                   
                  END IF               
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg001
   
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #160318-00025#24  by 07900 --add-end   
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_t.nmbg001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_o.nmbg001 #160824-00007#324 170117 By 08171 add        
                     NEXT FIELD CURRENT
                  END IF
                  #160912-00024#1 add s---
                  CALL s_anm_get_site_wc('6',g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocdt) RETURNING g_site_wc
                  IF cl_null(g_site_wc) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03020' #该资金中心下无可用运营据点!
                     LET g_errparam.extend = g_nmbm_m.nmbm001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_t.nmbg001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_o.nmbg001 #160824-00007#324 170117 By 08171 add
                     NEXT FIELD CURRENT
                  END IF                  
                  #160912-00024#1 add e---
                  
                  #檢查輸入組織代碼是否存在資金中心下法人範圍內
                  #IF s_chr_get_index_of(l_comp_wc,g_nmbo3_d[l_ac].nmbg001,1) = 0 THEN #160912-00024#1
                  IF s_chr_get_index_of(g_site_wc,g_nmbo3_d[l_ac].nmbg001,1) = 0 THEN #160912-00024#1
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00274'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                    #LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_t.nmbg001 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_o.nmbg001 #160824-00007#324 170117 By 08171 add
                     NEXT FIELD CURRENT                       
                  END IF                  
                 #CALL s_fin_account_center_with_ld_chk(g_nmbo3_d[l_ac].nmbg001,g_glaald,g_user,'6','Y','',g_today)
                 #  RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_nmbo3_d[l_ac].nmbg001 = g_nmbo3_d_t.nmbg001                                                            
#                     NEXT FIELD CURRENT
#                  END IF            
                  #取得組織代碼的所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_nmbo3_d[l_ac].nmbg001)
                   RETURNING g_sub_success,g_errno,g_nmbo3_d[l_ac].glaacomp,g_nmbo3_d[l_ac].glaald
                  #取本幣幣別+現金變動參照表號
                  LET l_glaa001=''
                  CALL s_ld_sel_glaa(g_nmbo3_d[l_ac].glaald,'glaa001|glaa005')
                       RETURNING  g_sub_success,l_glaa001,l_glaa005        
                  LET g_nmbo3_d_t.nmbg001 = g_nmbo3_d[l_ac].nmbg001                       
               END IF        
            END IF

            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].* #160824-00007#324 170117 By 08171 add

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg001
            #add-point:BEFORE FIELD nmbg001 name="input.b.page3.nmbg001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg001
            #add-point:ON CHANGE nmbg001 name="input.g.page3.nmbg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg003
            
            #add-point:AFTER FIELD nmbg003 name="input.a.page3.nmbg003"
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg003) THEN               
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg003 != g_nmbo3_d_t.nmbg003 OR g_nmbo3_d_t.nmbg003 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo3_d_o.nmbg003) OR g_nmbo3_d[l_ac].nmbg003 != g_nmbo3_d_o.nmbg003 THEN #160824-00007#324 170117 By 08171 add
                 #IF g_nmbo3_d[l_ac].nmbg003 != g_nmbo3_d_t.nmbg003 THEN #160824-00007#324 170117 By 08171 mark
                  IF g_nmbo3_d[l_ac].nmbg003 != g_nmbo3_d_o.nmbg003 THEN #160824-00007#324 170117 By 08171 add
                     IF NOT cl_ask_confirm('anm-00256') THEN   #是否確定變更
                       #LET g_nmbo3_d[l_ac].nmbg003 = g_nmbo3_d_t.nmbg003 #160824-00007#324 170117 By 08171 mark
                        LET g_nmbo3_d[l_ac].nmbg003 = g_nmbo3_d_o.nmbg003 #160824-00007#324 170117 By 08171 add
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_nmbo3_d[l_ac].nmbg004 = ''
                        LET g_nmbo3_d[l_ac].nmaal003 = ''
                        LET g_nmbo3_d[l_ac].nmbg006 = ''
                     END IF
                  END IF                
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg003
                  LET g_chkparam.arg2 = g_nmbo3_d[l_ac].nmbg001
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="anm-00012:sub-01302|anmi100|",cl_get_progname("anmi100",g_lang,"2"),"|:EXEPROGanmi100"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmab001_1") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo3_d[l_ac].nmbg003 = g_nmbo3_d_t.nmbg003 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg003 = g_nmbo3_d_o.nmbg003 #160824-00007#324 170117 By 08171 add              
                     NEXT FIELD CURRENT
                  END IF
                 #LET g_nmbo3_d_t.nmbg003 = g_nmbo3_d[l_ac].nmbg003 #160824-00007#324 170117 By 08171 mark
               END IF
            
            END IF
            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].* #160824-00007#324 170117 By 08171 add




            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg003
            #add-point:BEFORE FIELD nmbg003 name="input.b.page3.nmbg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg003
            #add-point:ON CHANGE nmbg003 name="input.g.page3.nmbg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg004
            
            #add-point:AFTER FIELD nmbg004 name="input.a.page3.nmbg004"
            LET g_nmbo3_d[l_ac].nmbg006 = ''
            DISPLAY g_nmbo3_d[l_ac].nmaal003 TO nmaal003_b3 
            DISPLAY g_nmbo3_d[l_ac].nmbg006 TO nmbg006            
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg004) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg004 != g_nmbo3_d_t.nmbg004 OR g_nmbo3_d_t.nmbg004 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo3_d_o.nmbg004) OR g_nmbo3_d[l_ac].nmbg004 != g_nmbo3_d_o.nmbg004 THEN #160824-00007#324 170117 By 08171 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg004
                  LET g_chkparam.arg2 = g_nmbo3_d[l_ac].nmbg003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#24  by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmas002") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo3_d[l_ac].nmbg004 = g_nmbo3_d_t.nmbg004 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg004 = g_nmbo3_d_o.nmbg004 #160824-00007#324 170117 By 08171 add
                     LET g_nmbo3_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo3_d[l_ac].nmbg004)
                     LET g_nmbo3_d[l_ac].nmbg006 = s_anm_get_nmas003(g_nmbo3_d[l_ac].nmbg004)
                     DISPLAY g_nmbo3_d[l_ac].nmaal003 TO nmaal003_b3
                     DISPLAY g_nmbo3_d[l_ac].nmbg006 TO nmbg006                     
                     NEXT FIELD CURRENT
                  END IF   
                  #控制內部銀行帳戶欄位及給值
                  CALL anmt940_set_nmbg005()
                  #撥出撥入幣別必須相同
                  LET g_nmbo3_d[l_ac].nmbg006 = s_anm_get_nmas003(g_nmbo3_d[l_ac].nmbg004)
                  IF g_nmbo3_d[l_ac].nmbg006 <> l_nmbo006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-00255'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                    #LET g_nmbo3_d[l_ac].nmbg004 = g_nmbo3_d_t.nmbg004 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg004 = g_nmbo3_d_o.nmbg004 #160824-00007#324 170117 By 08171 add
                     LET g_nmbo3_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo3_d[l_ac].nmbg004)
                     LET g_nmbo3_d[l_ac].nmbg006 = s_anm_get_nmas003(g_nmbo3_d[l_ac].nmbg004)
                     DISPLAY g_nmbo3_d[l_ac].nmaal003 TO nmaal003_b3
                     DISPLAY g_nmbo3_d[l_ac].nmbg006 TO nmbg006                     
                     NEXT FIELD CURRENT                     
                  END IF                  
               END IF    
               #160824-00007#324 170117 By 08171 --s add
               LET g_nmbo3_d[l_ac].nmaal003 = ''
               LET g_nmbo3_d[l_ac].nmbg006 = ''
               #160824-00007#324 170117 By 08171 --e add               
               LET g_nmbo3_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo3_d[l_ac].nmbg004)
               LET g_nmbo3_d[l_ac].nmbg006 = s_anm_get_nmas003(g_nmbo3_d[l_ac].nmbg004)
               DISPLAY g_nmbo3_d[l_ac].nmaal003 TO nmaal003_b3
               DISPLAY g_nmbo3_d[l_ac].nmbg006 TO nmbg006
                
            END IF 
            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].* #160824-00007#324 170117 By 08171 add



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg004
            #add-point:BEFORE FIELD nmbg004 name="input.b.page3.nmbg004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg004
            #add-point:ON CHANGE nmbg004 name="input.g.page3.nmbg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg005
            
            #add-point:AFTER FIELD nmbg005 name="input.a.page3.nmbg005"
 
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg005) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg005 != g_nmbo3_d_t.nmbg005 OR g_nmbo3_d_t.nmbg005 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo3_d_o.nmbg005) OR g_nmbo3_d[l_ac].nmbg005 != g_nmbo3_d_o.nmbg005 THEN #160824-00007#324 170117 By 08171 add
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg005
                  LET g_chkparam.arg2 = g_nmbo3_d[l_ac].nmbg003
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="ade-00010:sub-01302|anmi120|",cl_get_progname("anmi20",g_lang,"2"),"|:EXEPROGanmi120"
                  #160318-00025#24  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmas002_5") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo3_d[l_ac].nmbg005 = g_nmbo3_d_t.nmbg005 #160824-00007#324 170117 By 08171 mark    
                     LET g_nmbo3_d[l_ac].nmbg005 = g_nmbo3_d_o.nmbg005 #160824-00007#324 170117 By 08171 add
                     NEXT FIELD CURRENT
                  END IF   
                  #160122-00001#2--add---str
                  IF NOT s_anmi120_nmll002_chk(g_nmbo3_d[l_ac].nmbg005,g_user) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_nmbo3_d[l_ac].nmbg005
                     LET g_errparam.code   = 'anm-00574' 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()                      
                     NEXT FIELD CURRENT
                    #LET g_nmbo3_d[l_ac].nmbg005 = g_nmbo3_d_t.nmbg005 #160824-00007#324 170117 By 08171 mark    
                     LET g_nmbo3_d[l_ac].nmbg005 = g_nmbo3_d_o.nmbg005 #160824-00007#324 170117 By 08171 
                  END IF
                  #160122-00001#2--add---end
               END IF     
            END IF 
            
            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].* #160824-00007#324 170117 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg005
            #add-point:BEFORE FIELD nmbg005 name="input.b.page3.nmbg005"
            CALL anmt940_set_nmbg005()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg005
            #add-point:ON CHANGE nmbg005 name="input.g.page3.nmbg005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg012
            #add-point:BEFORE FIELD nmbg012 name="input.b.page3.nmbg012"
            IF cl_null(g_nmbo3_d[l_ac].nmbg012) THEN
               #取得對應項次撥出單身出帳日
               CALL anmt940_get_nmbo(g_nmbo3_d[l_ac].nmbgseq,'nmbo012') RETURNING g_nmbo3_d[l_ac].nmbg012            
            END IF

            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg012
            
            #add-point:AFTER FIELD nmbg012 name="input.a.page3.nmbg012"
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg012) THEN
               LET l_nmbo012 = ''
               CALL anmt940_get_nmbo(g_nmbo3_d[l_ac].nmbgseq,'nmbo012') RETURNING l_nmbo012
               #入帳日期不可小於出帳日期
               IF g_nmbo3_d[l_ac].nmbg012 < l_nmbo012 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00257'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg012
            #add-point:ON CHANGE nmbg012 name="input.g.page3.nmbg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg025
            
            #add-point:AFTER FIELD nmbg025 name="input.a.page3.nmbg025"
            LET g_nmbo3_d[l_ac].pmaal004 = ' '
            DISPLAY BY NAME g_nmbo3_d[l_ac].pmaal004             
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg025) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg025 != g_nmbo3_d_t.nmbg025 OR g_nmbo3_d_t.nmbg025 IS NULL )) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg025
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="apm-00044:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
                  #160318-00025#24  by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_pmaa001_22") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo3_d[l_ac].nmbg025 = g_nmbo3_d_t.nmbg025 
                     LET g_nmbo3_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo3_d[l_ac].nmbg025)
                     DISPLAY BY NAME g_nmbo3_d[l_ac].pmaal004                     
                     NEXT FIELD CURRENT                    
                  END IF 
                  LET g_nmbo3_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo3_d[l_ac].nmbg025)
                  DISPLAY BY NAME g_nmbo3_d[l_ac].pmaal004           
               END IF                            
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg025
            #add-point:BEFORE FIELD nmbg025 name="input.b.page3.nmbg025"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg025
            #add-point:ON CHANGE nmbg025 name="input.g.page3.nmbg025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg007
            #add-point:BEFORE FIELD nmbg007 name="input.b.page3.nmbg007"
            #取匯率
            CALL s_fin_get_curr_rate(g_nmbo3_d[l_ac].glaacomp,g_nmbo3_d[l_ac].glaald,g_nmbo3_d[l_ac].nmbg012,g_nmbo3_d[l_ac].nmbg006,'S-FIN-4004')
                 RETURNING g_nmbo3_d[l_ac].nmbg007,l_rate2,l_rate3
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg007
            
            #add-point:AFTER FIELD nmbg007 name="input.a.page3.nmbg007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg007
            #add-point:ON CHANGE nmbg007 name="input.g.page3.nmbg007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_nmbo3_d[l_ac].nmbg009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD nmbg009
            END IF 
 
 
 
            #add-point:AFTER FIELD nmbg009 name="input.a.page3.nmbg009"
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg001) AND NOT cl_null(l_glaa001) AND 
               NOT cl_null(g_nmbo3_d[l_ac].nmbg009) THEN 
               #依本幣取位
               LET g_nmbo3_d[l_ac].nmbg009 = s_curr_round(g_nmbo3_d[l_ac].nmbg001,l_glaa001,g_nmbo3_d[l_ac].nmbg009,2)            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg009
            #add-point:BEFORE FIELD nmbg009 name="input.b.page3.nmbg009"
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg008) AND NOT cl_null(g_nmbo3_d[l_ac].nmbg007) THEN
               #預設本幣金額為原幣金額*匯率
               LET g_nmbo3_d[l_ac].nmbg009 = g_nmbo3_d[l_ac].nmbg008 * g_nmbo3_d[l_ac].nmbg007
               #依本幣取位
               IF NOT cl_null(g_nmbo3_d[l_ac].nmbg001) AND NOT cl_null(l_glaa001) AND 
                  NOT cl_null(g_nmbo3_d[l_ac].nmbg009) THEN                
                  LET g_nmbo3_d[l_ac].nmbg009 = s_curr_round(g_nmbo3_d[l_ac].nmbg001,l_glaa001,g_nmbo3_d[l_ac].nmbg009,2)
               END IF
               DISPLAY BY NAME g_nmbo3_d[l_ac].nmbg009
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg009
            #add-point:ON CHANGE nmbg009 name="input.g.page3.nmbg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg010
            
            #add-point:AFTER FIELD nmbg010 name="input.a.page3.nmbg010"
            LET g_nmbo3_d[l_ac].nmajl003 = ' '
            LET g_nmbo3_d[l_ac].nmbg011 = ' '
            DISPLAY BY NAME g_nmbo3_d[l_ac].nmajl003,g_nmbo3_d[l_ac].nmbg011          
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg010) THEN 
#此段落由子樣板a19產生
               #IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg010 != g_nmbo3_d_t.nmbg010 OR g_nmbo3_d_t.nmbg010 IS NULL )) THEN #160824-00007#324 170117 By 08171 mark
               IF cl_null(g_nmbo3_d_o.nmbg010) OR g_nmbo3_d[l_ac].nmbg010 != g_nmbo3_d_o.nmbg010 THEN #160824-00007#324 170117 By 08171 add
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg010
                  LET g_chkparam.arg2 = 1   
                  #160318-00025#24  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aap-00002:sub-01302|aapi010|",cl_get_progname("aapi010",g_lang,"2"),"|:EXEPROGaapi010"
                  #160318-00025#24  by 07900 --add-end
	               LET g_chkparam.err_str[2] ="anm-00215:anm-00226"               
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                    #LET g_nmbo3_d[l_ac].nmbg010 = g_nmbo3_d_t.nmbg010 #160824-00007#324 170117 By 08171 mark
                     LET g_nmbo3_d[l_ac].nmbg010 = g_nmbo3_d_o.nmbg010 #160824-00007#324 170117 By 08171 add
                     LET g_nmbo3_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo3_d[l_ac].nmbg010)
                     LET g_nmbo3_d[l_ac].nmbg011 = s_anm_get_nmad003(l_glaa005,g_nmbo3_d[l_ac].nmbg010)
                     DISPLAY BY NAME g_nmbo3_d[l_ac].nmajl003,g_nmbo3_d[l_ac].nmbg011                     
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo3_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo3_d[l_ac].nmbg010)
                  LET g_nmbo3_d[l_ac].nmbg011 = s_anm_get_nmad003(l_glaa005,g_nmbo3_d[l_ac].nmbg010)
                  DISPLAY BY NAME g_nmbo3_d[l_ac].nmajl003,g_nmbo3_d[l_ac].nmbg011            
               END IF                            
            END IF 
            LET g_nmbo3_d_o.* = g_nmbo3_d[l_ac].* #160824-00007#324 170117 By 08171 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg010
            #add-point:BEFORE FIELD nmbg010 name="input.b.page3.nmbg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg010
            #add-point:ON CHANGE nmbg010 name="input.g.page3.nmbg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmbg011
            
            #add-point:AFTER FIELD nmbg011 name="input.a.page3.nmbg011"
            LET g_nmbo3_d[l_ac].nmail004 = ' '
            DISPLAY BY NAME g_nmbo3_d[l_ac].nmail004            
            IF NOT cl_null(g_nmbo3_d[l_ac].nmbg011) THEN 
#此段落由子樣板a19產生
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_nmbo3_d[l_ac].nmbg011 != g_nmbo3_d_t.nmbg011 OR g_nmbo3_d_t.nmbg011 IS NULL )) THEN  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_nmbo3_d[l_ac].nmbg011  
                  LET g_chkparam.arg2 = l_glaa005                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     LET g_nmbo3_d[l_ac].nmbg011 = g_nmbo3_d_t.nmbg011 
                     LET g_nmbo3_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo3_d[l_ac].nmbg011)
                     DISPLAY BY NAME g_nmbo3_d[l_ac].nmail004                      
                     NEXT FIELD CURRENT
                  END IF 
                  LET g_nmbo3_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo3_d[l_ac].nmbg011)
                  DISPLAY BY NAME g_nmbo3_d[l_ac].nmail004            
               END IF                            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmbg011
            #add-point:BEFORE FIELD nmbg011 name="input.b.page3.nmbg011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmbg011
            #add-point:ON CHANGE nmbg011 name="input.g.page3.nmbg011"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.nmbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbgseq
            #add-point:ON ACTION controlp INFIELD nmbgseq name="input.c.page3.nmbgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg001
            #add-point:ON ACTION controlp INFIELD nmbg001 name="input.c.page3.nmbg001"
            #播入單身/組織編號
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef001 IN ",l_comp_wc
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg001
            #160912-00024#1 add s---
            CALL s_anm_get_site_wc('6',g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocdt) RETURNING g_site_wc
            CALL s_fin_get_wc_str(g_site_wc) RETURNING l_origin_str
            LET g_qryparam.where = " ooef001 IN ",l_origin_str CLIPPED
            #160912-00024#1 add e---
            LET g_qryparam.where = g_qryparam.where ," AND ooef201 = 'Y'" #161021-00050#11
            CALL q_ooef001()
            LET g_nmbo3_d[l_ac].nmbg001 = g_qryparam.return1
            DISPLAY g_nmbo3_d[l_ac].nmbg001 TO nmbg001
            NEXT FIELD nmbg001
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg003
            #add-point:ON ACTION controlp INFIELD nmbg003 name="input.c.page3.nmbg003"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS(SELECT 1 FROM nmaa_t ",
                                   "        WHERE nmaa004=nmab001 ",
                                   "          AND nmaaent = ",g_enterprise, #2015/04/02 by 02599 add
                                   "          AND nmaa002 = '",g_nmbo3_d[l_ac].nmbg001,"')"
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg003             #給予default值

            
            CALL q_nmab001()                                #呼叫開窗

            LET g_nmbo3_d[l_ac].nmbg003 = g_qryparam.return1              

            DISPLAY g_nmbo3_d[l_ac].nmbg003 TO nmbg003              #

            NEXT FIELD nmbg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg004
            #add-point:ON ACTION controlp INFIELD nmbg004 name="input.c.page3.nmbg004"
            #開窗i段
            
            #取得對應項次撥出單身幣別
            CALL anmt940_get_nmbo(g_nmbo3_d[l_ac].nmbgseq,'nmbo006') RETURNING l_nmbo006 #160919-00032#1 add
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaa004 = '",g_nmbo3_d[l_ac].nmbg003,"' AND ",
                                   " nmas003 = '",l_nmbo006,"' " 
                                 
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_nmbo3_d[l_ac].nmbg001 #

            
            CALL q_nmas001()                                #呼叫開窗

            LET g_nmbo3_d[l_ac].nmbg004 = g_qryparam.return1              
            LET g_nmbo3_d[l_ac].nmaal003= s_desc_get_nmas002_desc(g_nmbo3_d[l_ac].nmbg004)
            LET g_nmbo3_d[l_ac].nmbg006 = s_anm_get_nmas003(g_nmbo3_d[l_ac].nmbg004)
            DISPLAY g_nmbo3_d[l_ac].nmbg004 TO nmbg004              #
            DISPLAY g_nmbo3_d[l_ac].nmaal003 TO nmaal003 
            DISPLAY g_nmbo3_d[l_ac].nmbg006 TO nmbg006 
            NEXT FIELD nmbg004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg005
            #add-point:ON ACTION controlp INFIELD nmbg005 name="input.c.page3.nmbg005"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #160122-00001#2 -mrak
#            LET g_qryparam.where = " EXISTS(SELECT 1 FROM nmab_t ",
#                                   "        WHERE nmaa004=nmab001 ",
#                                   "          AND nmaaent=nmabent ",
#                                   "          AND nmaaent = ",g_enterprise, #2015/04/02 by 02599 add
#                                   "          AND nmab002 = '0')"   
            #160122-00001#2 -mrak
            #160122-00001#2 -add -str 
            LET g_qryparam.where =  " EXISTS(SELECT 1 FROM nmab_t ",
                                   "        WHERE nmaa004=nmab001 ",
                                   "          AND nmaaent=nmabent ",
                                   "          AND nmaaent = ",g_enterprise, #2015/04/02 by 02599 add
                                   "          AND nmab002 = '0')",
                                   " AND nmas002 IN (",g_sql_bank,")"  #160122-00001#2 by 07900 mod 
            #160122-00001#2 -add -end                                   
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg005             #給予default值

            #給予arg
            LET g_qryparam.arg1 =  g_nmbo3_d[l_ac].nmbg001#

            
            CALL q_nmas001()                                #呼叫開窗

            LET g_nmbo3_d[l_ac].nmbg005 = g_qryparam.return1              
            DISPLAY g_nmbo3_d[l_ac].nmbg005 TO nmbg005              #
            NEXT FIELD nmbg005                         #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg012
            #add-point:ON ACTION controlp INFIELD nmbg012 name="input.c.page3.nmbg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg025
            #add-point:ON ACTION controlp INFIELD nmbg025 name="input.c.page3.nmbg025"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa047 = 'Y'"
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg025             #給予default值

            
           # CALL q_pmaa001()       #160913-00017#5  mark                  #呼叫開窗
            CALL q_pmaa001_25()     #160913-00017#5  add  

            LET g_nmbo3_d[l_ac].nmbg025 = g_qryparam.return1              

            DISPLAY g_nmbo3_d[l_ac].nmbg025 TO nmbg025              #
            LET g_nmbo3_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo3_d[l_ac].nmbg025)
            DISPLAY BY NAME g_nmbo3_d[l_ac].pmaal004 
            NEXT FIELD nmbg025                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg007
            #add-point:ON ACTION controlp INFIELD nmbg007 name="input.c.page3.nmbg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg009
            #add-point:ON ACTION controlp INFIELD nmbg009 name="input.c.page3.nmbg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg010
            #add-point:ON ACTION controlp INFIELD nmbg010 name="input.c.page3.nmbg010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '1' "   #提出
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg010             #給予default值

            
            CALL q_nmaj001()                                #呼叫開窗

            LET g_nmbo3_d[l_ac].nmbg010 = g_qryparam.return1              
            DISPLAY g_nmbo3_d[l_ac].nmbg010 TO nmbg010              #
            LET g_nmbo3_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo3_d[l_ac].nmbg010)
            LET g_nmbo3_d[l_ac].nmbg011 = s_anm_get_nmad003(l_glaa005,g_nmbo3_d[l_ac].nmbg010)
            DISPLAY BY NAME g_nmbo3_d[l_ac].nmajl003,g_nmbo3_d[l_ac].nmbg011 
            NEXT FIELD nmbg010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.nmbg011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmbg011
            #add-point:ON ACTION controlp INFIELD nmbg011 name="input.c.page3.nmbg011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",l_glaa005,"' "                       
            LET g_qryparam.default1 = g_nmbo3_d[l_ac].nmbg011             #給予default值
            
            CALL q_nmai002()                                #呼叫開窗

            LET g_nmbo3_d[l_ac].nmbg011 = g_qryparam.return1              
            DISPLAY g_nmbo3_d[l_ac].nmbg011 TO nmbg011              #
            LET g_nmbo3_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo3_d[l_ac].nmbg011)
            DISPLAY BY NAME g_nmbo3_d[l_ac].nmail004             
            NEXT FIELD nmbg011                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_nmbo3_d[l_ac].* = g_nmbo3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE anmt940_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL anmt940_unlock_b("nmbg_t","'3'")
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
               LET g_nmbo3_d[li_reproduce_target].* = g_nmbo3_d[li_reproduce].*
 
               LET g_nmbo3_d[li_reproduce_target].nmbgseq2 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_nmbo3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_nmbo3_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="anmt940.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         CALL anmt940_get_comp_wc(g_nmbm_m.nmbm001) RETURNING l_comp_wc
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD nmbmdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD nmboseq
               WHEN "s_detail2"
                  NEXT FIELD nmboseq_2
               WHEN "s_detail3"
                  NEXT FIELD nmbgseq
 
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
 
{<section id="anmt940.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION anmt940_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE  l_glaa005             LIKE glaa_t.glaa005      #現金變動參照表
   DEFINE  l_nmbm001_comp        LIKE ooef_t.ooef017
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   CALL s_fin_orga_get_comp_ld(g_nmbm_m.nmbm001)
                 RETURNING g_sub_success,g_errno,l_nmbm001_comp,g_glaald  
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL anmt940_b_fill() #單身填充
      CALL anmt940_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL anmt940_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   LET g_nmbm_m.nmbm001_desc = s_desc_get_department_desc(g_nmbm_m.nmbm001)
   
   #end add-point
   
   #遮罩相關處理
   LET g_nmbm_m_mask_o.* =  g_nmbm_m.*
   CALL anmt940_nmbm_t_mask()
   LET g_nmbm_m_mask_n.* =  g_nmbm_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
       g_nmbm_m.nmbmownid,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtid_desc,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid, 
       g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfid_desc,g_nmbm_m.nmbmcnfdt 
 
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbm_m.nmbmstus 
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
   FOR l_ac = 1 TO g_nmbo_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      #取得組織代碼的所屬法人+帳別
      CALL s_fin_orga_get_comp_ld(g_nmbo_d[l_ac].nmbo001)
       RETURNING g_sub_success,g_errno,g_nmbo_d[l_ac].glaacomp,g_nmbo_d[l_ac].glaald            
      #取本幣幣別+現金變動參照表號
      LET l_glaa005=''
      CALL s_ld_sel_glaa(g_nmbo_d[l_ac].glaald,'glaa005')
           RETURNING  g_sub_success,l_glaa005       
      #調度說明
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_nmbo_d[l_ac].nmbo002
      CALL ap_ref_array2(g_ref_fields,"SELECT nmbnl003 FROM nmbnl_t WHERE nmbnlent='"||g_enterprise||"' AND nmbnl001=? AND nmbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbo_d[l_ac].nmbnl003 = '', g_rtn_fields[1] , ''
      #帳戶說明
      LET g_nmbo_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo_d[l_ac].nmbo004)
      #交易對象簡稱      
      LET g_nmbo_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo_d[l_ac].nmbo025)      
      #存提碼說明
      LET g_nmbo_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo_d[l_ac].nmbo010)
      #現金異動碼說明
      LET g_nmbo_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo_d[l_ac].nmbo011)            
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_nmbo2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      #取得組織代碼的所屬法人+帳別
      CALL s_fin_orga_get_comp_ld(g_nmbo2_d[l_ac].nmbo001)
       RETURNING g_sub_success,g_errno,g_nmbo2_d[l_ac].glaacomp,g_nmbo2_d[l_ac].glaald            
      #取本幣幣別+現金變動參照表號
      LET l_glaa005=''
      CALL s_ld_sel_glaa(g_nmbo2_d[l_ac].glaald,'glaa005')
           RETURNING  g_sub_success,l_glaa005      
      #調度說明
      INITIALIZE g_ref_fields TO NULL 
      LET g_ref_fields[1] = g_nmbo2_d[l_ac].nmbo002
      CALL ap_ref_array2(g_ref_fields,"SELECT nmbnl003 FROM nmbnl_t WHERE nmbnlent='"||g_enterprise||"' AND nmbnl001=? AND nmbnl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_nmbo2_d[l_ac].nmbnl003 = '', g_rtn_fields[1] , ''
      #存提碼說明
      LET g_nmbo2_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo2_d[l_ac].nmbo017)
      #現金異動碼說明
      LET g_nmbo2_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo2_d[l_ac].nmbo018)
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_nmbo3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      #取得組織代碼的所屬法人+帳別
      CALL s_fin_orga_get_comp_ld(g_nmbo3_d[l_ac].nmbg001)
       RETURNING g_sub_success,g_errno,g_nmbo3_d[l_ac].glaacomp,g_nmbo3_d[l_ac].glaald            
      #取本幣幣別+現金變動參照表號
      LET l_glaa005=''
      CALL s_ld_sel_glaa(g_nmbo3_d[l_ac].glaald,'glaa005')
           RETURNING  g_sub_success,l_glaa005      
      #帳戶說明
      LET g_nmbo3_d[l_ac].nmaal003 = s_desc_get_nmas002_desc(g_nmbo3_d[l_ac].nmbg004)
      #交易對象簡稱      
      LET g_nmbo3_d[l_ac].pmaal004 = s_desc_get_trading_partner_abbr_desc(g_nmbo3_d[l_ac].nmbg025)
      #存提碼說明
      LET g_nmbo3_d[l_ac].nmajl003 = s_desc_get_nmajl003_desc(g_nmbo3_d[l_ac].nmbg010) 
      #現金異動碼說明
      LET g_nmbo3_d[l_ac].nmail004 = s_desc_get_nmail004_desc(l_glaa005,g_nmbo3_d[l_ac].nmbg011)         
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL anmt940_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION anmt940_detail_show()
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
 
{<section id="anmt940.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION anmt940_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE nmbm_t.nmbmdocno 
   DEFINE l_oldno     LIKE nmbm_t.nmbmdocno 
 
   DEFINE l_master    RECORD LIKE nmbm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE nmbo_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmbg_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_nmbm_m.nmbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
    
   LET g_nmbm_m.nmbmdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_nmbm_m.nmbmownid = g_user
      LET g_nmbm_m.nmbmowndp = g_dept
      LET g_nmbm_m.nmbmcrtid = g_user
      LET g_nmbm_m.nmbmcrtdp = g_dept 
      LET g_nmbm_m.nmbmcrtdt = cl_get_current()
      LET g_nmbm_m.nmbmmodid = g_user
      LET g_nmbm_m.nmbmmoddt = cl_get_current()
      LET g_nmbm_m.nmbmstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_nmbm_m.nmbmstus 
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
   
   
   CALL anmt940_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_nmbm_m.* TO NULL
      INITIALIZE g_nmbo_d TO NULL
      INITIALIZE g_nmbo2_d TO NULL
      INITIALIZE g_nmbo3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL anmt940_show()
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
   CALL anmt940_set_act_visible()   
   CALL anmt940_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " nmbment = " ||g_enterprise|| " AND",
                      " nmbmdocno = '", g_nmbm_m.nmbmdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL anmt940_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL anmt940_idx_chk()
   
   LET g_data_owner = g_nmbm_m.nmbmownid      
   LET g_data_dept  = g_nmbm_m.nmbmowndp
   
   #功能已完成,通報訊息中心
   CALL anmt940_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION anmt940_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE nmbo_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE nmbg_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE anmt940_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbo_t
    WHERE nmboent = g_enterprise AND nmbodocno = g_nmbmdocno_t
 
    INTO TEMP anmt940_detail
 
   #將key修正為調整後   
   UPDATE anmt940_detail 
      #更新key欄位
      SET nmbodocno = g_nmbm_m.nmbmdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO nmbo_t SELECT * FROM anmt940_detail
   
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
   DROP TABLE anmt940_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM nmbg_t 
    WHERE nmbgent = g_enterprise AND nmbgdocno = g_nmbmdocno_t
 
    INTO TEMP anmt940_detail
 
   #將key修正為調整後   
   UPDATE anmt940_detail SET nmbgdocno = g_nmbm_m.nmbmdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO nmbg_t SELECT * FROM anmt940_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE anmt940_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.delete" >}
#+ 資料刪除
PRIVATE FUNCTION anmt940_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE  l_n             LIKE type_t.num10 #160122-00001#2 add
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_nmbm_m.nmbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt940_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE anmt940_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT anmt940_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_nmbm_m_mask_o.* =  g_nmbm_m.*
   CALL anmt940_nmbm_t_mask()
   LET g_nmbm_m_mask_n.* =  g_nmbm_m.*
   
   CALL anmt940_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL anmt940_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
#160122-00001#2 -add -str
      LET l_n = 0 
      #單身存在當前用戶沒有權限的交易帳戶編碼
      #160122-00001#2--mod--str--by 02599
#      SELECT COUNT(*) INTO l_n FROM nmbo_t,nmbg_t
#       WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
#         AND nmbgent = g_enterprise AND nmbgdocno = g_nmbm_m.nmbmdocno    
#         AND nmbo005 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')        
#         AND nmbg005 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')   
#      #160122-00001#2 By 07900 --add--str
#         AND TRIM(nmbo005) IS NOT NULL AND TRIM(nmbg005) IS NOT NULL 
      #拨出单身：查询没有权限的交易账户资料
      SELECT COUNT(*) INTO l_n FROM nmbo_t
       WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno  
         AND nmbo005 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')        
         AND nmbo005 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')   
         AND TRIM(nmbo005) IS NOT NULL 
      IF l_n = 0 THEN
         #拨入单身：查询没有权限的交易账户资料
         SELECT COUNT(*) INTO l_n FROM nmbg_t
          WHERE nmbgent = g_enterprise AND nmbgdocno = g_nmbm_m.nmbmdocno    
            AND nmbg005 NOT IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')        
            AND nmbg005 NOT IN( SELECT UNIQUE nmlm001 FROM nmlm_t WHERE nmlment = g_enterprise AND nmlm002 = g_dept AND nmlmstus ='Y')   
            AND TRIM(nmbg005) IS NOT NULL
      END IF
      #160122-00001#2--mod--end by 02599         
      IF l_n > 0 THEN
         IF NOT cl_ask_confirm('anm-00395') THEN
            CLOSE anmt940_cl
            CALL s_transaction_end('N','0')
            RETURN
          END IF
      END IF   
      #160122-00001#2 By 07900 --add--end
#      IF l_n = 0 THEN #160122-00001#2 mark by 02599
#160122-00001#2 -add -end
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_nmbmdocno_t = g_nmbm_m.nmbmdocno
 
 
      DELETE FROM nmbm_t
       WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      IF NOT s_aooi200_fin_del_docno(g_glaald,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_nmbm_m.nmbmdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
#      END IF #160122-00001#2 -add #160122-00001#2 mark by 02599
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM nmbo_t
       WHERE nmboent = g_enterprise AND nmbodocno = g_nmbm_m.nmbmdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      #160126-00010#14---add---str
      #   AND (nmbo005 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')
      #    OR nmbo005 IS NULL)              #160122-00001#2 by 07900 --mark 
      #160126-00010#14--add---end
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
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
      DELETE FROM nmbg_t
       WHERE nmbgent = g_enterprise AND
             nmbgdocno = g_nmbm_m.nmbmdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      #160126-00010#14---add---str
     #    AND (nmbg005 IN( SELECT UNIQUE nmll001 FROM nmll_t WHERE nmllent = g_enterprise AND nmll002 = g_user AND nmllstus ='Y')
     #     OR nmbg005 IS NULL)    #160122-00001#2  by 07900 --mark
      #160126-00010#14--add---end
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_nmbm_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE anmt940_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_nmbo_d.clear() 
      CALL g_nmbo2_d.clear()       
      CALL g_nmbo3_d.clear()       
 
     
      CALL anmt940_ui_browser_refresh()  
      #CALL anmt940_ui_headershow()  
      #CALL anmt940_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL anmt940_browser_fill("")
         CALL anmt940_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE anmt940_cl
 
   #功能已完成,通報訊息中心
   CALL anmt940_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="anmt940.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmt940_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_i        LIKE type_t.num10
   DEFINE l_j        LIKE type_t.num10
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_nmbo_d.clear()
   CALL g_nmbo2_d.clear()
   CALL g_nmbo3_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF anmt940_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmboseq,nmboseq2,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005, 
             nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmboseq,nmboseq2, 
             nmbo002,nmbo001,nmbo006,nmbo008,nmbo014,nmbo015,nmbo007,nmbo016,nmbo017,nmbo018  FROM nmbo_t", 
                
                     " INNER JOIN nmbm_t ON nmbment = " ||g_enterprise|| " AND nmbmdocno = nmbodocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE nmboent=? AND nmbodocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      #160122-00001#2---add---str
         LET g_sql = g_sql," AND (nmbo005 IN (",g_sql_bank,") OR TRIM(nmbo005) IS NULL)"     #160122-00001#2 by 07900 --mod  
      #160122-00001#2 -add---end
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbo_t.nmboseq2"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt940_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR anmt940_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_nmbm_m.nmbmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_nmbm_m.nmbmdocno INTO g_nmbo_d[l_ac].nmboseq,g_nmbo_d[l_ac].nmboseq2, 
          g_nmbo_d[l_ac].nmbo002,g_nmbo_d[l_ac].nmbo001,g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004, 
          g_nmbo_d[l_ac].nmbo006,g_nmbo_d[l_ac].nmbo005,g_nmbo_d[l_ac].nmbo012,g_nmbo_d[l_ac].nmbo025, 
          g_nmbo_d[l_ac].nmbo008,g_nmbo_d[l_ac].nmbo007,g_nmbo_d[l_ac].nmbo009,g_nmbo_d[l_ac].nmbo010, 
          g_nmbo_d[l_ac].nmbo011,g_nmbo_d[l_ac].nmbo013,g_nmbo_d[l_ac].nmbo021,g_nmbo2_d[l_ac].nmboseq, 
          g_nmbo2_d[l_ac].nmboseq2,g_nmbo2_d[l_ac].nmbo002,g_nmbo2_d[l_ac].nmbo001,g_nmbo2_d[l_ac].nmbo006, 
          g_nmbo2_d[l_ac].nmbo008,g_nmbo2_d[l_ac].nmbo014,g_nmbo2_d[l_ac].nmbo015,g_nmbo2_d[l_ac].nmbo007, 
          g_nmbo2_d[l_ac].nmbo016,g_nmbo2_d[l_ac].nmbo017,g_nmbo2_d[l_ac].nmbo018   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #項次大於200表示為費用訊息,不顯示於撥出單身頁籤;
         #反之則為撥出單身,不顯示於費用訊息頁籤
         IF g_nmbo_d[l_ac].nmboseq2 > 200 THEN 
            INITIALIZE g_nmbo_d[l_ac].* TO NULL
         ELSE
            INITIALIZE g_nmbo2_d[l_ac].* TO NULL
         END IF
       
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
   IF anmt940_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT nmbgseq,nmbgseq2,nmbg001,nmbg003,nmbg004,nmbg006,nmbg005,nmbg012, 
             nmbg025,nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021  FROM nmbg_t",   
                     " INNER JOIN  nmbm_t ON nmbment = " ||g_enterprise|| " AND nmbmdocno = nmbgdocno ",
 
                     "",
                     
                     
                     " WHERE nmbgent=? AND nmbgdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
      #160122-00001#2---add---str
         LET g_sql = g_sql," AND (nmbg005 IN (",g_sql_bank,") OR TRIM(nmbg005) IS NULL)"     #160122-00001#2 by 07900 mod  
      #160122-00001#2 -add---end
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY nmbg_t.nmbgseq2"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE anmt940_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR anmt940_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_nmbm_m.nmbmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_nmbm_m.nmbmdocno INTO g_nmbo3_d[l_ac].nmbgseq,g_nmbo3_d[l_ac].nmbgseq2, 
          g_nmbo3_d[l_ac].nmbg001,g_nmbo3_d[l_ac].nmbg003,g_nmbo3_d[l_ac].nmbg004,g_nmbo3_d[l_ac].nmbg006, 
          g_nmbo3_d[l_ac].nmbg005,g_nmbo3_d[l_ac].nmbg012,g_nmbo3_d[l_ac].nmbg025,g_nmbo3_d[l_ac].nmbg008, 
          g_nmbo3_d[l_ac].nmbg007,g_nmbo3_d[l_ac].nmbg009,g_nmbo3_d[l_ac].nmbg010,g_nmbo3_d[l_ac].nmbg011, 
          g_nmbo3_d[l_ac].nmbg013,g_nmbo3_d[l_ac].nmbg021   #(ver:78)
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
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   FOR l_i =1 TO g_nmbo_d.getLength()-1
      #刪除撥出單身中沒有資料的陣列
      IF cl_null(g_nmbo_d[l_i].nmboseq) THEN
         CALL g_nmbo_d.deleteElement(l_i)
         LET l_i = l_i -1
      END IF
   END FOR   
   FOR l_j =1 TO g_nmbo2_d.getLength()-1
      #刪除費用訊息中沒有資料的陣列
      IF cl_null(g_nmbo2_d[l_j].nmboseq) THEN
         CALL g_nmbo2_d.deleteElement(l_j)
         LET l_j = l_j -1
      END IF      
   END FOR
   #end add-point
   
   CALL g_nmbo_d.deleteElement(g_nmbo_d.getLength())
   CALL g_nmbo2_d.deleteElement(g_nmbo2_d.getLength())
   CALL g_nmbo3_d.deleteElement(g_nmbo3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE anmt940_pb
   FREE anmt940_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_nmbo_d.getLength()
      LET g_nmbo_d_mask_o[l_ac].* =  g_nmbo_d[l_ac].*
      CALL anmt940_nmbo_t_mask()
      LET g_nmbo_d_mask_n[l_ac].* =  g_nmbo_d[l_ac].*
   END FOR
   
   LET g_nmbo2_d_mask_o.* =  g_nmbo2_d.*
   FOR l_ac = 1 TO g_nmbo2_d.getLength()
      LET g_nmbo2_d_mask_o[l_ac].* =  g_nmbo2_d[l_ac].*
      CALL anmt940_nmbo_t_mask()
      LET g_nmbo2_d_mask_n[l_ac].* =  g_nmbo2_d[l_ac].*
   END FOR
   LET g_nmbo3_d_mask_o.* =  g_nmbo3_d.*
   FOR l_ac = 1 TO g_nmbo3_d.getLength()
      LET g_nmbo3_d_mask_o[l_ac].* =  g_nmbo3_d[l_ac].*
      CALL anmt940_nmbg_t_mask()
      LET g_nmbo3_d_mask_n[l_ac].* =  g_nmbo3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION anmt940_delete_b(ps_table,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM nmbo_t
       WHERE nmboent = g_enterprise AND
         nmbodocno = ps_keys_bak[1] AND nmboseq2 = ps_keys_bak[2]
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
         CALL g_nmbo_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbo2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM nmbg_t
       WHERE nmbgent = g_enterprise AND
             nmbgdocno = ps_keys_bak[1] AND nmbgseq2 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_nmbo3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION anmt940_insert_b(ps_table,ps_keys,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #新增撥出單身至nmbo_t
      INSERT INTO nmbo_t
                 (nmboent,
                  nmbodocno,nmboseq,nmboseq2,
                  nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005,   #3
                  nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,   #4
                  nmbo011,nmbo013,nmbo014,nmbo015,nmbo016,nmbo017,   #5
                  nmbo018,nmbo021)                                   #6
            VALUES(g_enterprise,
                   ps_keys[1],g_nmbo_d[g_detail_idx].nmboseq,ps_keys[2],
                   #3
                   g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo003,                    
                   g_nmbo_d[g_detail_idx].nmbo004,g_nmbo_d[g_detail_idx].nmbo006,g_nmbo_d[g_detail_idx].nmbo005,
                   #4
                   g_nmbo_d[g_detail_idx].nmbo012,g_nmbo_d[g_detail_idx].nmbo025,g_nmbo_d[g_detail_idx].nmbo008,                    
                   g_nmbo_d[g_detail_idx].nmbo007,g_nmbo_d[g_detail_idx].nmbo009,g_nmbo_d[g_detail_idx].nmbo010, 
                   #5
                   g_nmbo_d[g_detail_idx].nmbo011,g_nmbo_d[g_detail_idx].nmbo013,0,0,0,'',
                   #6
                   '',g_nmbo_d[g_detail_idx].nmbo021) 
#      #end add-point 
#      INSERT INTO nmbo_t
#                  (nmboent,
#                   nmbodocno,
#                   nmboseq2
#                   ,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005,nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmbo002,nmbo001,nmbo006,nmbo008,nmbo014,nmbo015,nmbo007,nmbo016,nmbo017,nmbo018) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2]
#                   ,g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo003, 
#                       g_nmbo_d[g_detail_idx].nmbo004,g_nmbo_d[g_detail_idx].nmbo006,g_nmbo_d[g_detail_idx].nmbo005, 
#                       g_nmbo_d[g_detail_idx].nmbo012,g_nmbo_d[g_detail_idx].nmbo025,g_nmbo_d[g_detail_idx].nmbo008, 
#                       g_nmbo_d[g_detail_idx].nmbo007,g_nmbo_d[g_detail_idx].nmbo009,g_nmbo_d[g_detail_idx].nmbo010, 
#                       g_nmbo_d[g_detail_idx].nmbo011,g_nmbo_d[g_detail_idx].nmbo013,g_nmbo_d[g_detail_idx].nmbo021, 
#                       g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo006, 
#                       g_nmbo_d[g_detail_idx].nmbo008,g_nmbo2_d[g_detail_idx].nmbo014,g_nmbo2_d[g_detail_idx].nmbo015, 
#                       g_nmbo_d[g_detail_idx].nmbo007,g_nmbo2_d[g_detail_idx].nmbo016,g_nmbo2_d[g_detail_idx].nmbo017, 
#                       g_nmbo2_d[g_detail_idx].nmbo018)
#      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_nmbo_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_nmbo2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #新增費用訊息(手續費)至nmbo_t
      INSERT INTO nmbo_t
                 (nmboent,
                  nmbodocno,nmboseq,nmboseq2,
                  nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005,   #3
                  nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,   #4
                  nmbo011,nmbo013,nmbo014,nmbo015,nmbo016,nmbo017,   #5
                  nmbo018,nmbo021)                                           #6
            VALUES(g_enterprise,
                   ps_keys[1],g_nmbo_d[g_detail_idx].nmboseq,ps_keys[2]+200,
                   #3
                   g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo003,                    
                   g_nmbo_d[g_detail_idx].nmbo004,g_nmbo_d[g_detail_idx].nmbo006,g_nmbo_d[g_detail_idx].nmbo005,
                   #4
                   g_nmbo_d[g_detail_idx].nmbo012,g_nmbo_d[g_detail_idx].nmbo025,g_nmbo_d[g_detail_idx].nmbo008,                    
                   g_nmbo_d[g_detail_idx].nmbo007,g_nmbo_d[g_detail_idx].nmbo009,g_nmbo_d[g_detail_idx].nmbo010, 
                   #5
                   g_nmbo_d[g_detail_idx].nmbo011,g_nmbo_d[g_detail_idx].nmbo013,0,0,0,'',
                   #6
                   '',g_nmbo_d[g_detail_idx].nmbo021)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbo_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
      END IF                   
      #end add-point 
   END IF
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      INSERT INTO nmbg_t
                  (nmbgent,
                   nmbgdocno,nmbgseq2,nmbgseq,
                   nmbg001,nmbg003,nmbg004,nmbg006,nmbg005,nmbg012,nmbg025,nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],g_nmbo3_d[g_detail_idx].nmbgseq,
                   g_nmbo3_d[g_detail_idx].nmbg001,g_nmbo3_d[g_detail_idx].nmbg003,g_nmbo3_d[g_detail_idx].nmbg004, 
                   g_nmbo3_d[g_detail_idx].nmbg006,g_nmbo3_d[g_detail_idx].nmbg005,g_nmbo3_d[g_detail_idx].nmbg012, 
                   g_nmbo3_d[g_detail_idx].nmbg025,g_nmbo3_d[g_detail_idx].nmbg008,g_nmbo3_d[g_detail_idx].nmbg007, 
                   g_nmbo3_d[g_detail_idx].nmbg009,g_nmbo3_d[g_detail_idx].nmbg010,g_nmbo3_d[g_detail_idx].nmbg011, 
                   g_nmbo3_d[g_detail_idx].nmbg013,g_nmbo3_d[g_detail_idx].nmbg021)
#      #end add-point 
#      INSERT INTO nmbg_t
#                  (nmbgent,
#                   nmbgdocno,
#                   nmbgseq2
#                   ,nmbg001,nmbg003,nmbg004,nmbg006,nmbg005,nmbg012,nmbg025,nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021) 
#            VALUES(g_enterprise,
#                   ps_keys[1],ps_keys[2]
#                   ,g_nmbo3_d[g_detail_idx].nmbg001,g_nmbo3_d[g_detail_idx].nmbg003,g_nmbo3_d[g_detail_idx].nmbg004, 
#                       g_nmbo3_d[g_detail_idx].nmbg006,g_nmbo3_d[g_detail_idx].nmbg005,g_nmbo3_d[g_detail_idx].nmbg012, 
#                       g_nmbo3_d[g_detail_idx].nmbg025,g_nmbo3_d[g_detail_idx].nmbg008,g_nmbo3_d[g_detail_idx].nmbg007, 
#                       g_nmbo3_d[g_detail_idx].nmbg009,g_nmbo3_d[g_detail_idx].nmbg010,g_nmbo3_d[g_detail_idx].nmbg011, 
#                       g_nmbo3_d[g_detail_idx].nmbg013,g_nmbo3_d[g_detail_idx].nmbg021)
#      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_nmbo3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION anmt940_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   LET ls_group = "'1','2',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL anmt940_nmbo_t_mask_restore('restore_mask_o')
               
      UPDATE nmbo_t 
         SET (nmbodocno,
              nmboseq2
              ,nmbo002,nmbo001,nmbo003,nmbo004,nmbo006,nmbo005,nmbo012,nmbo025,nmbo008,nmbo007,nmbo009,nmbo010,nmbo011,nmbo013,nmbo021,nmbo002,nmbo001,nmbo006,nmbo008,nmbo014,nmbo015,nmbo007,nmbo016,nmbo017,nmbo018) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo003, 
                  g_nmbo_d[g_detail_idx].nmbo004,g_nmbo_d[g_detail_idx].nmbo006,g_nmbo_d[g_detail_idx].nmbo005, 
                  g_nmbo_d[g_detail_idx].nmbo012,g_nmbo_d[g_detail_idx].nmbo025,g_nmbo_d[g_detail_idx].nmbo008, 
                  g_nmbo_d[g_detail_idx].nmbo007,g_nmbo_d[g_detail_idx].nmbo009,g_nmbo_d[g_detail_idx].nmbo010, 
                  g_nmbo_d[g_detail_idx].nmbo011,g_nmbo_d[g_detail_idx].nmbo013,g_nmbo_d[g_detail_idx].nmbo021, 
                  g_nmbo_d[g_detail_idx].nmbo002,g_nmbo_d[g_detail_idx].nmbo001,g_nmbo_d[g_detail_idx].nmbo006, 
                  g_nmbo_d[g_detail_idx].nmbo008,g_nmbo2_d[g_detail_idx].nmbo014,g_nmbo2_d[g_detail_idx].nmbo015, 
                  g_nmbo_d[g_detail_idx].nmbo007,g_nmbo2_d[g_detail_idx].nmbo016,g_nmbo2_d[g_detail_idx].nmbo017, 
                  g_nmbo2_d[g_detail_idx].nmbo018) 
         WHERE nmboent = g_enterprise AND nmbodocno = ps_keys_bak[1] AND nmboseq2 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt940_nmbo_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "nmbg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL anmt940_nmbg_t_mask_restore('restore_mask_o')
               
      UPDATE nmbg_t 
         SET (nmbgdocno,
              nmbgseq2
              ,nmbg001,nmbg003,nmbg004,nmbg006,nmbg005,nmbg012,nmbg025,nmbg008,nmbg007,nmbg009,nmbg010,nmbg011,nmbg013,nmbg021) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_nmbo3_d[g_detail_idx].nmbg001,g_nmbo3_d[g_detail_idx].nmbg003,g_nmbo3_d[g_detail_idx].nmbg004, 
                  g_nmbo3_d[g_detail_idx].nmbg006,g_nmbo3_d[g_detail_idx].nmbg005,g_nmbo3_d[g_detail_idx].nmbg012, 
                  g_nmbo3_d[g_detail_idx].nmbg025,g_nmbo3_d[g_detail_idx].nmbg008,g_nmbo3_d[g_detail_idx].nmbg007, 
                  g_nmbo3_d[g_detail_idx].nmbg009,g_nmbo3_d[g_detail_idx].nmbg010,g_nmbo3_d[g_detail_idx].nmbg011, 
                  g_nmbo3_d[g_detail_idx].nmbg013,g_nmbo3_d[g_detail_idx].nmbg021) 
         WHERE nmbgent = g_enterprise AND nmbgdocno = ps_keys_bak[1] AND nmbgseq2 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "nmbg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL anmt940_nmbg_t_mask_restore('restore_mask_n')
 
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
 
{<section id="anmt940.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION anmt940_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt940.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION anmt940_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="anmt940.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION anmt940_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   DEFINE l_nmboseq2  LIKE nmbo_t.nmboseq2
   IF ps_page = "'2'" THEN
      LET l_nmboseq2 = g_nmbo_d[g_detail_idx].nmboseq2
      LET g_nmbo_d[g_detail_idx].nmboseq2 = g_nmbo2_d[g_detail_idx].nmboseq2      
   END IF
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL anmt940_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "nmbo_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN anmt940_bcl USING g_enterprise,
                                       g_nmbm_m.nmbmdocno,g_nmbo_d[g_detail_idx].nmboseq2     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt940_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "nmbg_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN anmt940_bcl2 USING g_enterprise,
                                             g_nmbm_m.nmbmdocno,g_nmbo3_d[g_detail_idx].nmbgseq2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "anmt940_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   IF ps_page = "'2'" THEN
      LET g_nmbo_d[g_detail_idx].nmboseq2 = l_nmboseq2
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION anmt940_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1','2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt940_bcl
   END IF
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE anmt940_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION anmt940_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("nmbmdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("nmbmdocno",TRUE)
      CALL cl_set_comp_entry("nmbmdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("nmbmdocdt",TRUE)  #150401-00001#31 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION anmt940_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_success  LIKE type_t.num5     #151130-00015#2 
   DEFINE l_slip     LIKE type_t.chr10  #151130-00015#2
   DEFINE l_dfin0033  LIKE type_t.chr80 #151130-00015#2
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("nmbmdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("nmbmdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("nmbmdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #151130-00015#2 -begin -add by XZG 20151222
      IF NOT cl_null(g_nmbm_m.nmbmdocno) THEN  
            #获取单别
            CALL s_aooi200_fin_get_slip(g_nmbm_m.nmbmdocno) RETURNING l_success,l_slip
            #是否可改日期
            CALL s_fin_get_doc_para(g_glaald,g_nmbm_m.nmbm001,l_slip,'D-FIN-0033') RETURNING l_dfin0033
            IF l_dfin0033 = "N"  THEN 
               CALL cl_set_comp_entry("nmbmdocdt",FALSE)
            ELSE 
               CALL cl_set_comp_entry("nmbmdocdt",TRUE)
            END IF          
         END IF 
      #151130-00015#2  -end
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION anmt940_set_entry_b(p_cmd)
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
 
{<section id="anmt940.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION anmt940_set_no_entry_b(p_cmd)
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
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION anmt940_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE) #iluym 2014/11/27 add
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION anmt940_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   #iluym 2014/11/27 add---str
   IF g_nmbm_m.nmbmstus <> "N" THEN
      CALL cl_set_act_visible("modify,modify_detail,delete", FALSE)
   END IF
   #----add----end   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_nmbm_m.nmbmstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION anmt940_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION anmt940_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION anmt940_default_search()
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
      LET ls_wc = ls_wc, " nmbmdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "nmbm_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbo_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "nmbg_t" 
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
 
{<section id="anmt940.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION anmt940_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_nmbm_m.nmbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN anmt940_cl USING g_enterprise,g_nmbm_m.nmbmdocno
   IF STATUS THEN
      CLOSE anmt940_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN anmt940_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
       g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
       g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
       g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT anmt940_action_chk() THEN
      CLOSE anmt940_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
       g_nmbm_m.nmbmownid,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid, 
       g_nmbm_m.nmbmcrtid_desc,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid, 
       g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfid_desc,g_nmbm_m.nmbmcnfdt 
 
 
   CASE g_nmbm_m.nmbmstus
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
         CASE g_nmbm_m.nmbmstus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_nmbm_m.nmbmstus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#7 add
            RETURN   #151013-00016#7 151102 by sakura add
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W" #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"  #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT anmt940_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt940_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT anmt940_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE anmt940_cl
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
      g_nmbm_m.nmbmstus = lc_state OR cl_null(lc_state) THEN
      CLOSE anmt940_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認
   IF lc_state = 'Y' THEN
      IF g_nmbm_m.nmbmstus = 'N' THEN
         CALL s_anmt940_conf_chk(g_nmbm_m.nmbmdocno) RETURNING g_sub_success
         IF NOT g_sub_success THEN
            CALL s_transaction_end('N','0')           #150401-00001#13
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
               CALL s_transaction_end('N','0')        #150401-00001#13
               RETURN
            ELSE
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               CALL s_anmt940_conf_upd(g_nmbm_m.nmbmdocno) RETURNING g_sub_success
               CALL cl_err_collect_show()
               IF NOT g_sub_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF  
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL s_anmt940_unconf_chk(g_nmbm_m.nmbmdocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         CALL s_transaction_end('N','0')           #150401-00001#13
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL s_transaction_end('N','0')        #150401-00001#13
            RETURN
         ELSE
            CALL s_transaction_begin()
            CALL s_anmt940_unconf_upd(g_nmbm_m.nmbmdocno) RETURNING g_sub_success
            IF NOT g_sub_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
         END IF
      END IF
   END IF   
   
   #151125-00001#3 ---add (S)---
   IF lc_state = "X" THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #151125-00001#3 ---add (E)---
   #end add-point
   
   LET g_nmbm_m.nmbmmodid = g_user
   LET g_nmbm_m.nmbmmoddt = cl_get_current()
   LET g_nmbm_m.nmbmstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE nmbm_t 
      SET (nmbmstus,nmbmmodid,nmbmmoddt) 
        = (g_nmbm_m.nmbmstus,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt)     
    WHERE nmbment = g_enterprise AND nmbmdocno = g_nmbm_m.nmbmdocno
 
    
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
      EXECUTE anmt940_master_referesh USING g_nmbm_m.nmbmdocno INTO g_nmbm_m.nmbm001,g_nmbm_m.nmbmdocno, 
          g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus,g_nmbm_m.nmbmownid,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmcrtid, 
          g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid, 
          g_nmbm_m.nmbmcnfdt,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid_desc, 
          g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_nmbm_m.nmbm001,g_nmbm_m.nmbm001_desc,g_nmbm_m.nmbmdocno,g_nmbm_m.nmbmdocdt,g_nmbm_m.nmbmstus, 
          g_nmbm_m.nmbmownid,g_nmbm_m.nmbmownid_desc,g_nmbm_m.nmbmowndp,g_nmbm_m.nmbmowndp_desc,g_nmbm_m.nmbmcrtid, 
          g_nmbm_m.nmbmcrtid_desc,g_nmbm_m.nmbmcrtdp,g_nmbm_m.nmbmcrtdp_desc,g_nmbm_m.nmbmcrtdt,g_nmbm_m.nmbmmodid, 
          g_nmbm_m.nmbmmodid_desc,g_nmbm_m.nmbmmoddt,g_nmbm_m.nmbmcnfid,g_nmbm_m.nmbmcnfid_desc,g_nmbm_m.nmbmcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE anmt940_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL anmt940_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt940.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION anmt940_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_nmbo_d.getLength() THEN
         LET g_detail_idx = g_nmbo_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbo_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbo_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_nmbo2_d.getLength() THEN
         LET g_detail_idx = g_nmbo2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbo2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbo2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_nmbo3_d.getLength() THEN
         LET g_detail_idx = g_nmbo3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_nmbo3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_nmbo3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmt940_b_fill2(pi_idx)
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
   
   CALL anmt940_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION anmt940_fill_chk(ps_idx)
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
 
{<section id="anmt940.status_show" >}
PRIVATE FUNCTION anmt940_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="anmt940.mask_functions" >}
&include "erp/anm/anmt940_mask.4gl"
 
{</section>}
 
{<section id="anmt940.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION anmt940_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL anmt940_show()
   CALL anmt940_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_nmbm_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_nmbo_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_nmbo2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_nmbo3_d))
 
 
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
   #CALL anmt940_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL anmt940_ui_headershow()
   CALL anmt940_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION anmt940_draw_out()
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
   CALL anmt940_ui_headershow()  
   CALL anmt940_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="anmt940.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION anmt940_set_pk_array()
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
   LET g_pk_array[1].values = g_nmbm_m.nmbmdocno
   LET g_pk_array[1].column = 'nmbmdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt940.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="anmt940.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION anmt940_msgcentre_notify(lc_state)
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
   CALL anmt940_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_nmbm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="anmt940.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION anmt940_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#24 add-S
   SELECT nmbmstus  INTO g_nmbm_m.nmbmstus
     FROM nmbm_t
    WHERE nmbment = g_enterprise
      AND nmbmdocno = g_nmbm_m.nmbmdocno

   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_nmbm_m.nmbmstus
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
        LET g_errparam.extend = g_nmbm_m.nmbmdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL anmt940_set_act_visible()
        CALL anmt940_set_act_no_visible()
        CALL anmt940_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#24 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="anmt940.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 設定撥入單身內部銀行帳戶之欄位控制及給值
# Memo...........:
# Usage..........: CALL anmt940_set_nmbo005()
#                  

# Date & Author..: 14/08/25 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_set_nmbo005()
   DEFINE l_flag        LIKE type_t.chr1
   IF l_ac > 0 THEN
      #判斷是否為內部銀行
      CALL s_anmt940_chk_nmab002(g_nmbo_d[l_ac].nmbo003,g_nmbo_d[l_ac].nmbo004) RETURNING l_flag
   ELSE
      LET l_flag = 'N'
   END IF
   IF g_para_data = 'Y' THEN  #內部銀行管理為啟用
      IF l_flag = 'Y' THEN    #內部銀行
         LET g_nmbo_d[l_ac].nmbo005 = g_nmbo_d[l_ac].nmbo004
         CALL cl_set_comp_entry("nmbo005",FALSE)
      ELSE
         CALL cl_set_comp_entry("nmbo005",TRUE)
      END IF   
   ELSE
      LET g_nmbo_d[l_ac].nmbo005 = ''
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 設定撥出單身內部銀行帳戶之欄位控制及給值
# Memo...........:
# Usage..........: anmt940_set_nmbg005()
#                  

# Date & Author..: 14/08/25 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_set_nmbg005()
   DEFINE l_flag        LIKE type_t.chr1
   IF l_ac > 0 THEN
      #判斷是否為內部銀行
      CALL s_anmt940_chk_nmab002(g_nmbo3_d[l_ac].nmbg003,g_nmbo3_d[l_ac].nmbg004) RETURNING l_flag
   ELSE
      LET l_flag = 'N'
   END IF
   IF g_para_data = 'Y' THEN  #內部銀行管理為啟用
      IF l_flag = 'Y' THEN   #內部銀行
         LET g_nmbo3_d[l_ac].nmbg005 = g_nmbo3_d[l_ac].nmbg004
         CALL cl_set_comp_entry("nmbg005",FALSE)
      ELSE
         CALL cl_set_comp_entry("nmbg005",TRUE)
      END IF   
   ELSE
      LET g_nmbo3_d[l_ac].nmbg005 = ''
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 取得對應撥出項次之資料
# Memo...........:
# Usage..........: CALL anmt940_get_nmbo(p_nmbgseq)
#                  RETURNING r_nmbo006
# Input parameter: p_nmbgseq      對應項次
#                  p_feld         需求欄位
# Return code....: 1. r_nmbo006   對應撥出項次之幣別
#                  2. r_nmbo008   對應撥出項次之原幣金額
#                  3. r_nmbo012   對應撥出項次之出帳日
#                 
# Date & Author..: 14/08/29 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_get_nmbo(p_nmbgseq,p_feld)
   DEFINE  p_nmbgseq    LIKE nmbg_t.nmbgseq
   DEFINE  p_feld       STRING
   DEFINE  r_nmbo006    LIKE nmbo_t.nmbo006
   DEFINE  r_nmbo008    LIKE nmbo_t.nmbo008   
   DEFINE  r_nmbo012    LIKE nmbo_t.nmbo012
   
   SELECT nmbo006,nmbo008,nmbo012 INTO r_nmbo006,r_nmbo008,r_nmbo012 FROM nmbo_t
    WHERE nmboent = g_enterprise 
      AND nmbodocno = g_nmbm_m.nmbmdocno
      AND nmboseq2 = p_nmbgseq
   CASE p_feld
      WHEN 'nmbo006'   #幣別
         RETURN r_nmbo006
      WHEN 'nmbo008'   #原幣金額
         RETURN r_nmbo008         
      WHEN 'nmbo012'   #出帳日期
         RETURN r_nmbo012
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 修改撥出金額時,若撥入金額已經有值需要連動修改
# Memo...........:
# Usage..........: CALL anmt940_set_nmbg008(p_nmboseq,p_nmbo008)
#                  
# Input parameter: p_nmboseq      對應項次
#                  p_nmbo008      原幣金額
# Date & Author..: 14/09/05 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_set_nmbg008(p_nmboseq,p_nmbo008)
   DEFINE p_nmboseq     LIKE nmbo_t.nmboseq
   DEFINE p_nmbo008     LIKE nmbo_t.nmbo008
   DEFINE l_nmbg001     LIKE nmbg_t.nmbg001
   DEFINE l_nmbg006     LIKE nmbg_t.nmbg006
   DEFINE l_nmbg007     LIKE nmbg_t.nmbg007    
   DEFINE l_nmbg008     LIKE nmbg_t.nmbg008
   DEFINE l_nmbg009     LIKE nmbg_t.nmbg009
   DEFINE l_glaa001     LIKE glaa_t.glaa001
   DEFINE l_glaacomp    LIKE glaa_t.glaacomp
   DEFINE l_glaald      LIKE glaa_t.glaald
   
   SELECT nmbg001,nmbg006,nmbg007,nmbg008 INTO 
          l_nmbg001,l_nmbg006,l_nmbg007,l_nmbg008
     FROM nmbg_t
    WHERE nmbgent = g_enterprise
      AND nmbgdocno = g_nmbm_m.nmbmdocno
      AND nmbgseq = p_nmboseq
      
   IF NOT cl_null(l_nmbg001) AND l_nmbg008 <> 0 THEN
      #取得組織代碼的所屬法人+帳別
      CALL s_fin_orga_get_comp_ld(l_nmbg001)
       RETURNING g_sub_success,g_errno,l_glaacomp,l_glaald
 
      #取本幣幣別+現金變動參照表號
      LET l_glaa001=''
      CALL s_ld_sel_glaa(l_glaald,'glaa001')
           RETURNING  g_sub_success,l_glaa001 

      LET l_nmbg008 = p_nmbo008
      #依原幣取位      
      IF NOT cl_null(l_nmbg001) AND NOT cl_null(l_nmbg006) AND 
         NOT cl_null(l_nmbg008) THEN            
         LET l_nmbg008 = s_curr_round(l_nmbg001,l_nmbg006,l_nmbg008,2)
      END IF      
      #預設本幣金額為原幣金額*匯率
      LET l_nmbg009 = l_nmbg008 * l_nmbg007      
      #依本幣取位
      IF NOT cl_null(l_nmbg001) AND NOT cl_null(l_glaa001) AND 
         NOT cl_null(l_nmbg009) THEN                
         LET l_nmbg009 = s_curr_round(l_nmbg001,l_glaa001,l_nmbg009,2)     
      END IF
      UPDATE nmbg_t SET nmbg008 = l_nmbg008,
                        nmbg009 = l_nmbg009
       WHERE nmbgent = g_enterprise
         AND nmbgdocno = g_nmbm_m.nmbmdocno
         AND nmbgseq = p_nmboseq      
        
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 取得資金中心底下所屬的法人範圍,並轉換為sql條件
# Memo...........:
# Usage..........: CALL anmt940_get_comp_wc()
#                  RETURNING r_wc
# Input parameter: p_nmbm001      資金中心
#
# Return code....: r_wc           法人範圍條件
#
# Date & Author..: 14/09/16 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_get_comp_wc(p_nmbm001)
   DEFINE p_nmbm001           LIKE nmbm_t.nmbm001
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING   
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('6',p_nmbm001,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING r_wc
   
   LET tok = base.StringTokenizer.create(r_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc   
END FUNCTION

################################################################################
# Descriptions...: 编辑后立即审核
# Memo...........:
# Usage..........: CALL anmt940_immediately_conf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/12/08 By 07166
# Modify.........:
################################################################################
PRIVATE FUNCTION anmt940_immediately_conf()
#151125-00006#3--s
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_doc_success     LIKE type_t.num5
   DEFINE l_slip            LIKE ooba_t.ooba002
   DEFINE l_dfin0031        LIKE type_t.chr1
   DEFINE l_count           LIKE type_t.num5
   DEFINE l_glaald          LIKE glaa_t.glaald
   DEFINE l_ooef017         LIKE ooef_t.ooef017
  
   SELECT ooef017 INTO l_ooef017 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_nmbm_m.nmbm001
   
   SELECT glaald INTO l_glaald
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'

   IF cl_null(l_glaald)           THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbm_m.nmbm001)   THEN RETURN END IF   #無資料直接返回不做處理
   IF cl_null(g_nmbm_m.nmbmdocno) THEN RETURN END IF   #無資料直接返回不做處理
    
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbo_t WHERE nmboent = g_enterprise
      AND nmbodocno = g_nmbm_m.nmbmdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #第一单身無資料直接返回不做處理

   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmbg_t WHERE nmbgent = g_enterprise
      AND nmbgdocno = g_nmbm_m.nmbmdocno
      
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      RETURN 
   END IF                   #第二单身無資料直接返回不做處理
   
   #取得單別
   CALL s_aooi200_fin_get_slip(g_nmbm_m.nmbmdocno) RETURNING l_success,l_slip
   #取得單別設置的"是否直接審核"參數
   CALL s_fin_get_doc_para(l_glaald,g_nmbm_m.nmbm001,l_slip,'D-FIN-0031') RETURNING l_dfin0031

   IF cl_null(l_dfin0031) OR l_dfin0031 MATCHES '[Nn]' THEN RETURN END IF #參數值為空或為N則不做直接審核邏輯
   IF NOT cl_ask_confirm('aap-00403') THEN RETURN END IF  #询问是否立即审核?
   
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_doc_success = TRUE
        
   IF NOT s_anmt940_conf_chk(g_nmbm_m.nmbmdocno) THEN
      LET l_doc_success = FALSE
   END IF
   
   IF NOT s_anmt940_conf_upd(g_nmbm_m.nmbmdocno) THEN
      LET l_doc_success = FALSE
   END IF 
   
   #異動狀態碼欄位/修改人/修改日期
   LET g_nmbm_m.nmbmmoddt = cl_get_current()
   LET g_nmbm_m.nmbmcnfdt = cl_get_current()
   UPDATE nmbm_t SET nmbmstus = 'Y',
                     nmbmmodid= g_user,
                     nmbmmoddt= g_nmbm_m.nmbmmoddt,
                     nmbmcnfid= g_user,
                     nmbmcnfdt= g_nmbm_m.nmbmcnfdt
    WHERE nmbment = g_enterprise 
      AND nmbmdocno = g_nmbm_m.nmbmdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      LET l_doc_success = FALSE
   END IF
   IF l_doc_success = TRUE THEN
      CALL s_transaction_end('Y',1)
   ELSE
      CALL s_transaction_end('N',1)
      CALL cl_err_collect_show()
   END IF
#151125-00006#3--e
END FUNCTION

 
{</section>}
 
