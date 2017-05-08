#該程式未解開Section, 採用最新樣板產出!
{<section id="adbt701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-08-27 10:10:53), PR版次:0009(2016-10-07 09:44:57)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000081
#+ Filename...: adbt701
#+ Description: 配送排車單維護作業
#+ Creator....: 02749(2014-07-31 09:00:43)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adbt701.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#160318-00025#23   16/04/22  BY 07900   校验代码重复错误讯息的修改
#160816-00068#3    16/08/17  By earl    調整transaction
#160818-00017#7    2016/08/25    by 08172  修改删除时重新检查状态
#160825-00043#1    2016/08/30    by 06137    修正無啟用bpm時，未確認狀態按下出現抽單、提交選項問題
#160824-00007#67   2016/10/07    by 06137    修正舊值備份寫法
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
PRIVATE type type_g_dbee_m        RECORD
       dbeesite LIKE dbee_t.dbeesite, 
   dbeesite_desc LIKE type_t.chr80, 
   dbeedocdt LIKE dbee_t.dbeedocdt, 
   dbeeunit LIKE dbee_t.dbeeunit, 
   dbeedocno LIKE dbee_t.dbeedocno, 
   dbee001 LIKE dbee_t.dbee001, 
   dbee010 LIKE dbee_t.dbee010, 
   dbee010_desc LIKE type_t.chr80, 
   dbee011 LIKE dbee_t.dbee011, 
   dbee011_desc LIKE type_t.chr80, 
   dbeestus LIKE dbee_t.dbeestus, 
   dbee002 LIKE dbee_t.dbee002, 
   dbee003 LIKE dbee_t.dbee003, 
   dbee004 LIKE dbee_t.dbee004, 
   dbee004_desc LIKE type_t.chr80, 
   dbee005 LIKE dbee_t.dbee005, 
   dbee005_desc LIKE type_t.chr80, 
   dbee006 LIKE dbee_t.dbee006, 
   dbee007 LIKE dbee_t.dbee007, 
   dbee007_desc LIKE type_t.chr80, 
   dbee008 LIKE dbee_t.dbee008, 
   dbee009 LIKE dbee_t.dbee009, 
   dbee009_desc LIKE type_t.chr80, 
   dbee012 LIKE dbee_t.dbee012, 
   l_dbee0071 LIKE type_t.chr500, 
   l_dbee0071_desc LIKE type_t.chr80, 
   dbee013 LIKE dbee_t.dbee013, 
   l_dbee0091 LIKE type_t.chr500, 
   l_dbee0091_desc LIKE type_t.chr80, 
   dbeeownid LIKE dbee_t.dbeeownid, 
   dbeeownid_desc LIKE type_t.chr80, 
   dbeeowndp LIKE dbee_t.dbeeowndp, 
   dbeeowndp_desc LIKE type_t.chr80, 
   dbeecrtid LIKE dbee_t.dbeecrtid, 
   dbeecrtid_desc LIKE type_t.chr80, 
   dbeecrtdp LIKE dbee_t.dbeecrtdp, 
   dbeecrtdp_desc LIKE type_t.chr80, 
   dbeecrtdt LIKE dbee_t.dbeecrtdt, 
   dbeemodid LIKE dbee_t.dbeemodid, 
   dbeemodid_desc LIKE type_t.chr80, 
   dbeemoddt LIKE dbee_t.dbeemoddt, 
   dbeecnfid LIKE dbee_t.dbeecnfid, 
   dbeecnfid_desc LIKE type_t.chr80, 
   dbeecnfdt LIKE dbee_t.dbeecnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_dbef_d        RECORD
       dbefseq LIKE dbef_t.dbefseq, 
   dbefunit LIKE dbef_t.dbefunit, 
   dbefunit_desc LIKE type_t.chr500, 
   dbef000 LIKE dbef_t.dbef000, 
   dbef001 LIKE dbef_t.dbef001, 
   dbef002 LIKE dbef_t.dbef002, 
   dbef003 LIKE dbef_t.dbef003, 
   dbef004 LIKE dbef_t.dbef004, 
   dbef004_desc LIKE type_t.chr500, 
   dbef010 LIKE dbef_t.dbef010, 
   dbef005 LIKE dbef_t.dbef005, 
   dbef005_desc LIKE type_t.chr500, 
   dbef005_desc_1 LIKE type_t.chr500, 
   dbef009 LIKE dbef_t.dbef009, 
   dbef008 LIKE dbef_t.dbef008, 
   dbef008_desc LIKE type_t.chr500, 
   dbef007 LIKE dbef_t.dbef007, 
   dbef006 LIKE dbef_t.dbef006, 
   dbef006_desc LIKE type_t.chr500, 
   dbef011 LIKE dbef_t.dbef011, 
   l_imaa018 LIKE type_t.chr500, 
   l_imaa018_desc LIKE type_t.chr500, 
   dbef012 LIKE dbef_t.dbef012, 
   l_imaa026 LIKE type_t.chr500, 
   l_imaa026_desc LIKE type_t.chr500, 
   dbef013 LIKE dbef_t.dbef013, 
   dbef013_desc LIKE type_t.chr500, 
   dbef014 LIKE dbef_t.dbef014, 
   dbef014_desc LIKE type_t.chr500, 
   dbef015 LIKE dbef_t.dbef015, 
   dbef016 LIKE dbef_t.dbef016, 
   dbefsite LIKE dbef_t.dbefsite, 
   l_dbee012 LIKE type_t.chr500, 
   l_dbee013 LIKE type_t.chr500, 
   l_qty_chk_flag LIKE type_t.chr500
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_dbeesite LIKE dbee_t.dbeesite,
   b_dbeesite_desc LIKE type_t.chr80,
      b_dbeedocdt LIKE dbee_t.dbeedocdt,
      b_dbeedocno LIKE dbee_t.dbeedocno,
      b_dbee001 LIKE dbee_t.dbee001,
      b_dbee002 LIKE dbee_t.dbee002,
      b_dbee003 LIKE dbee_t.dbee003,
      b_dbee004 LIKE dbee_t.dbee004,
   b_dbee004_desc LIKE type_t.chr80,
      b_dbee005 LIKE dbee_t.dbee005,
   b_dbee005_desc LIKE type_t.chr80,
      b_dbee010 LIKE dbee_t.dbee010,
   b_dbee010_desc LIKE type_t.chr80,
      b_dbee011 LIKE dbee_t.dbee011,
   b_dbee011_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ins_site_flag       LIKE type_t.chr1              #紀錄dbeesite 有無輸入資料, 作為欄位entry控制判斷
DEFINE g_ins_docno_flag      LIKE type_t.chr1              #紀錄dbeedocno 有無輸入資料, 作為欄位entry控制判斷
DEFINE g_ooef004             LIKE ooef_t.ooef004
DEFINE g_volume_para         LIKE type_t.chr30             #容積單位換算率(參數)
DEFINE g_weight_para         LIKE type_t.chr30             #重量單位換算率(參數)
DEFINE g_volume_para1        LIKE type_t.chr30             #容積超量提示訊息方式(參數)
DEFINE g_weight_para1        LIKE type_t.chr30             #重量超量提示訊息方式(參數)
#end add-point
       
#模組變數(Module Variables)
DEFINE g_dbee_m          type_g_dbee_m
DEFINE g_dbee_m_t        type_g_dbee_m
DEFINE g_dbee_m_o        type_g_dbee_m
DEFINE g_dbee_m_mask_o   type_g_dbee_m #轉換遮罩前資料
DEFINE g_dbee_m_mask_n   type_g_dbee_m #轉換遮罩後資料
 
   DEFINE g_dbeedocno_t LIKE dbee_t.dbeedocno
 
 
DEFINE g_dbef_d          DYNAMIC ARRAY OF type_g_dbef_d
DEFINE g_dbef_d_t        type_g_dbef_d
DEFINE g_dbef_d_o        type_g_dbef_d
DEFINE g_dbef_d_mask_o   DYNAMIC ARRAY OF type_g_dbef_d #轉換遮罩前資料
DEFINE g_dbef_d_mask_n   DYNAMIC ARRAY OF type_g_dbef_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
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
 
{<section id="adbt701.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT dbeesite,'',dbeedocdt,dbeeunit,dbeedocno,dbee001,dbee010,'',dbee011,'', 
       dbeestus,dbee002,dbee003,dbee004,'',dbee005,'',dbee006,dbee007,'',dbee008,dbee009,'',dbee012, 
       '','',dbee013,'','',dbeeownid,'',dbeeowndp,'',dbeecrtid,'',dbeecrtdp,'',dbeecrtdt,dbeemodid,'', 
       dbeemoddt,dbeecnfid,'',dbeecnfdt", 
                      " FROM dbee_t",
                      " WHERE dbeeent= ? AND dbeedocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt701_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.dbeesite,t0.dbeedocdt,t0.dbeeunit,t0.dbeedocno,t0.dbee001,t0.dbee010, 
       t0.dbee011,t0.dbeestus,t0.dbee002,t0.dbee003,t0.dbee004,t0.dbee005,t0.dbee006,t0.dbee007,t0.dbee008, 
       t0.dbee009,t0.dbee012,t0.dbee013,t0.dbeeownid,t0.dbeeowndp,t0.dbeecrtid,t0.dbeecrtdp,t0.dbeecrtdt, 
       t0.dbeemodid,t0.dbeemoddt,t0.dbeecnfid,t0.dbeecnfdt,t2.ooag011 ,t3.ooefl003 ,t4.dbabl003 ,t5.dbael003 , 
       t6.oocal003 ,t7.oocal003 ,t8.oocal003 ,t9.oocal003 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 ,t13.ooefl003 , 
       t14.ooag011 ,t15.ooag011",
               " FROM dbee_t t0",
                              " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.dbee010  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.dbee011 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN dbabl_t t4 ON t4.dbablent="||g_enterprise||" AND t4.dbabl001=t0.dbee004 AND t4.dbabl002='"||g_dlang||"' ",
               " LEFT JOIN dbael_t t5 ON t5.dbaelent="||g_enterprise||" AND t5.dbael001=t0.dbee005 AND t5.dbael002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=t0.dbee007 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=t0.dbee009 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t8 ON t8.oocalent="||g_enterprise||" AND t8.oocal001=t0.dbee007 AND t8.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t9 ON t9.oocalent="||g_enterprise||" AND t9.oocal001=t0.dbee009 AND t9.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.dbeeownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.dbeeowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.dbeecrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.dbeecrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.dbeemodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.dbeecnfid  ",
 
               " WHERE t0.dbeeent = " ||g_enterprise|| " AND t0.dbeedocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adbt701_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbt701 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbt701_init()   
 
      #進入選單 Menu (="N")
      CALL adbt701_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbt701
      
   END IF 
   
   CLOSE adbt701_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbt701.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adbt701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('dbeestus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('dbef000','6090') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   LET g_errshow = 1   #校驗訊息彈窗   
   
   LET g_volume_para = cl_get_para(g_enterprise,g_site,'E-CIR-0012')   #容積單位 
   LET g_weight_para = cl_get_para(g_enterprise,g_site,'E-CIR-0013')   #重量單位
   LET g_volume_para1 = cl_get_para(g_enterprise,g_site,'E-CIR-0014')  #容積超量訊息警告/拒絕  
   LET g_weight_para1 = cl_get_para(g_enterprise,g_site,'E-CIR-0015')  #重量超量訊息警告/拒絕
   #end add-point
   
   #初始化搜尋條件
   CALL adbt701_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="adbt701.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adbt701_ui_dialog()
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
            CALL adbt701_insert()
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
         INITIALIZE g_dbee_m.* TO NULL
         CALL g_dbef_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL adbt701_init()
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
               
               CALL adbt701_fetch('') # reload data
               LET l_ac = 1
               CALL adbt701_ui_detailshow() #Setting the current row 
         
               CALL adbt701_idx_chk()
               #NEXT FIELD dbefseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_dbef_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL adbt701_idx_chk()
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
               CALL adbt701_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION detail_qrystr相關動作 name="menu.detail_show.page1_sub.detail_qrystr"
                  BEFORE MENU
                    IF g_detail_idx = 0 THEN
                       HIDE OPTION "prog_adbt540"
                       HIDE OPTION "prog_aint510"
                       EXIT MENU
                    ELSE
                       IF g_dbef_d[g_detail_idx].dbef000 = '1' THEN #串查出貨單
                          HIDE OPTION "prog_aint510"
                          IF cl_null(g_dbef_d[g_detail_idx].dbef001) THEN
                             HIDE OPTION "prog_adbt540"
                             EXIT MENU
                          END IF
                       ELSE                                         #串查調撥單
                          HIDE OPTION "prog_adbt540"       
                          IF cl_null(g_dbef_d[g_detail_idx].dbef001) THEN
                             HIDE OPTION "prog_aint510"
                             EXIT MENU
                          END IF                       
                       END IF
                    END IF 
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_adbt540
                  LET g_action_choice="prog_adbt540"
                  IF cl_auth_chk_act("prog_adbt540") THEN
                     
                     #add-point:ON ACTION prog_adbt540 name="menu.detail_show.page1_sub.prog_adbt540"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               #CASE g_dbef_d[g_detail_idx].dbef000
               #   WHEN "1"
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = 'adbt540'
                     LET la_param.param[1] = "1 = 1"                   
                     LET la_param.param[2] = g_dbef_d[l_ac].dbef001
                     
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun_wait(ls_js)
               #   WHEN "2"
               #      INITIALIZE la_param.* TO NULL
               #      LET la_param.prog     = 'aint510'                  
               #      LET la_param.param[1] = g_dbef_d[l_ac].dbef001
               #      
               #      LET ls_js = util.JSON.stringify(la_param)
               #      CALL cl_cmdrun_wait(ls_js)                     
               #END CASE


                     #END add-point
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_aint510
                  LET g_action_choice="prog_aint510"
                  IF cl_auth_chk_act("prog_aint510") THEN
                     
                     #add-point:ON ACTION prog_aint510 name="menu.detail_show.page1_sub.prog_aint510"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'aint510'
               LET la_param.param[1] = g_dbef_d[l_ac].dbef001

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
 
 
 
 
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL adbt701_browser_fill("")
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
               CALL adbt701_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL adbt701_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL adbt701_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
 
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL adbt701_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL adbt701_set_act_visible()   
            CALL adbt701_set_act_no_visible()
            IF NOT (g_dbee_m.dbeedocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " dbeeent = " ||g_enterprise|| " AND",
                                  " dbeedocno = '", g_dbee_m.dbeedocno, "' "
 
               #填到對應位置
               CALL adbt701_browser_fill("")
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
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "dbee_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbef_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL adbt701_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "dbee_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "dbef_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL adbt701_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL adbt701_fetch("F")
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
               CALL adbt701_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL adbt701_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt701_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL adbt701_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt701_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL adbt701_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt701_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL adbt701_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt701_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL adbt701_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL adbt701_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_dbef_d)
                  LET g_export_id[1]   = "s_detail1"
 
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
               NEXT FIELD dbefseq
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
               CALL adbt701_modify()
               #add-point:ON ACTION modify name="menu.modify"
               #160818-00017#7 -s by 08172
               CALL adbt701_set_act_visible()   
               CALL adbt701_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL adbt701_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               #160818-00017#7 -s by 08172
               CALL adbt701_set_act_visible()   
               CALL adbt701_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL adbt701_delete()
               #add-point:ON ACTION delete name="menu.delete"
               #160818-00017#7 -s by 08172
               CALL adbt701_set_act_visible()   
               CALL adbt701_set_act_no_visible()
               #160818-00017#7 -e by 08172 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adbt701_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/adb/adbt701_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/adb/adbt701_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION replanning_unloading
            LET g_action_choice="replanning_unloading"
            IF cl_auth_chk_act("replanning_unloading") THEN
               
               #add-point:ON ACTION replanning_unloading name="menu.replanning_unloading"
               CALL s_transaction_begin()
               IF adbt701_replanning_unloading() THEN
                  CALL s_transaction_end('Y',0)
               ELSE
                  CALL s_transaction_end('N',0)
               END IF                  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adbt701_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_aooi130
            LET g_action_choice="prog_aooi130"
            IF cl_auth_chk_act("prog_aooi130") THEN
               
               #add-point:ON ACTION prog_aooi130 name="menu.prog_aooi130"
               #應用 a45 樣板自動產生(Version:2)
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001",g_dbee_m.dbee010)
 


               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL adbt701_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL adbt701_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL adbt701_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_dbee_m.dbeedocdt)
 
 
 
         
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
 
{<section id="adbt701.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION adbt701_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'dbeesite') RETURNING l_where 
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
      LET l_sub_sql = " SELECT DISTINCT dbeedocno ",
                      " FROM dbee_t ",
                      " ",
                      " LEFT JOIN dbef_t ON dbefent = dbeeent AND dbeedocno = dbefdocno ", "  ",
                      #add-point:browser_fill段sql(dbef_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE dbeeent = " ||g_enterprise|| " AND dbefent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("dbee_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT dbeedocno ",
                      " FROM dbee_t ", 
                      "  ",
                      "  ",
                      " WHERE dbeeent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("dbee_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   LET l_sub_sql = l_sub_sql," AND ", l_where
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
      INITIALIZE g_dbee_m.* TO NULL
      CALL g_dbef_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.dbeesite,t0.dbeedocdt,t0.dbeedocno,t0.dbee001,t0.dbee002,t0.dbee003,t0.dbee004,t0.dbee005,t0.dbee010,t0.dbee011 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.dbeestus,t0.dbeesite,t0.dbeedocdt,t0.dbeedocno,t0.dbee001,t0.dbee002, 
          t0.dbee003,t0.dbee004,t0.dbee005,t0.dbee010,t0.dbee011,t1.ooefl003 ,t2.dbabl003 ,t3.dbael003 , 
          t4.ooag011 ,t5.ooefl003 ",
                  " FROM dbee_t t0",
                  "  ",
                  "  LEFT JOIN dbef_t ON dbefent = dbeeent AND dbeedocno = dbefdocno ", "  ", 
                  #add-point:browser_fill段sql(dbef_t1) name="browser_fill.join.dbef_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbeesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN dbabl_t t2 ON t2.dbablent="||g_enterprise||" AND t2.dbabl001=t0.dbee004 AND t2.dbabl002='"||g_dlang||"' ",
               " LEFT JOIN dbael_t t3 ON t3.dbaelent="||g_enterprise||" AND t3.dbael001=t0.dbee005 AND t3.dbael002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.dbee010  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.dbee011 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.dbeeent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("dbee_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.dbeestus,t0.dbeesite,t0.dbeedocdt,t0.dbeedocno,t0.dbee001,t0.dbee002, 
          t0.dbee003,t0.dbee004,t0.dbee005,t0.dbee010,t0.dbee011,t1.ooefl003 ,t2.dbabl003 ,t3.dbael003 , 
          t4.ooag011 ,t5.ooefl003 ",
                  " FROM dbee_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.dbeesite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN dbabl_t t2 ON t2.dbablent="||g_enterprise||" AND t2.dbabl001=t0.dbee004 AND t2.dbabl002='"||g_dlang||"' ",
               " LEFT JOIN dbael_t t3 ON t3.dbaelent="||g_enterprise||" AND t3.dbael001=t0.dbee005 AND t3.dbael002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=t0.dbee010  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.dbee011 AND t5.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.dbeeent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("dbee_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = g_sql," AND ", l_where
   #end add-point
   LET g_sql = g_sql, " ORDER BY dbeedocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"dbee_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_dbeesite,g_browser[g_cnt].b_dbeedocdt, 
          g_browser[g_cnt].b_dbeedocno,g_browser[g_cnt].b_dbee001,g_browser[g_cnt].b_dbee002,g_browser[g_cnt].b_dbee003, 
          g_browser[g_cnt].b_dbee004,g_browser[g_cnt].b_dbee005,g_browser[g_cnt].b_dbee010,g_browser[g_cnt].b_dbee011, 
          g_browser[g_cnt].b_dbeesite_desc,g_browser[g_cnt].b_dbee004_desc,g_browser[g_cnt].b_dbee005_desc, 
          g_browser[g_cnt].b_dbee010_desc,g_browser[g_cnt].b_dbee011_desc
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
         CALL adbt701_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_dbeedocno) THEN
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
 
{<section id="adbt701.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION adbt701_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_dbee_m.dbeedocno = g_browser[g_current_idx].b_dbeedocno   
 
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
   CALL adbt701_dbee_t_mask()
   CALL adbt701_show()
      
END FUNCTION
 
{</section>}
 
{<section id="adbt701.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION adbt701_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION adbt701_ui_browser_refresh()
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
      IF g_browser[l_i].b_dbeedocno = g_dbee_m.dbeedocno 
 
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
 
{<section id="adbt701.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION adbt701_construct()
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
   INITIALIZE g_dbee_m.* TO NULL
   CALL g_dbef_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON dbeesite,dbeedocdt,dbeeunit,dbeedocno,dbee001,dbee010,dbee011,dbeestus, 
          dbee002,dbee003,dbee004,dbee005,dbee006,dbee007,dbee008,dbee009,dbee012,l_dbee0071,dbee013, 
          l_dbee0091,dbeeownid,dbeeowndp,dbeecrtid,dbeecrtdp,dbeecrtdt,dbeemodid,dbeemoddt,dbeecnfid, 
          dbeecnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<dbeecrtdt>>----
         AFTER FIELD dbeecrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<dbeemoddt>>----
         AFTER FIELD dbeemoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbeecnfdt>>----
         AFTER FIELD dbeecnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<dbeepstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.dbeesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeesite
            #add-point:ON ACTION controlp INFIELD dbeesite name="construct.c.dbeesite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeesite',g_dbee_m.dbeesite,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeesite  #顯示到畫面上
            NEXT FIELD dbeesite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeesite
            #add-point:BEFORE FIELD dbeesite name="construct.b.dbeesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeesite
            
            #add-point:AFTER FIELD dbeesite name="construct.a.dbeesite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeedocdt
            #add-point:BEFORE FIELD dbeedocdt name="construct.b.dbeedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeedocdt
            
            #add-point:AFTER FIELD dbeedocdt name="construct.a.dbeedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeedocdt
            #add-point:ON ACTION controlp INFIELD dbeedocdt name="construct.c.dbeedocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeeunit
            #add-point:BEFORE FIELD dbeeunit name="construct.b.dbeeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeeunit
            
            #add-point:AFTER FIELD dbeeunit name="construct.a.dbeeunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeeunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeeunit
            #add-point:ON ACTION controlp INFIELD dbeeunit name="construct.c.dbeeunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE                #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeeunit',g_dbee_m.dbeesite,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO dbeeunit  #顯示到畫面上
            NEXT FIELD dbeeunit 
            #END add-point
 
 
         #Ctrlp:construct.c.dbeedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeedocno
            #add-point:ON ACTION controlp INFIELD dbeedocno name="construct.c.dbeedocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbeedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeedocno  #顯示到畫面上
            NEXT FIELD dbeedocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeedocno
            #add-point:BEFORE FIELD dbeedocno name="construct.b.dbeedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeedocno
            
            #add-point:AFTER FIELD dbeedocno name="construct.a.dbeedocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee001
            #add-point:BEFORE FIELD dbee001 name="construct.b.dbee001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee001
            
            #add-point:AFTER FIELD dbee001 name="construct.a.dbee001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee001
            #add-point:ON ACTION controlp INFIELD dbee001 name="construct.c.dbee001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbee010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee010
            #add-point:ON ACTION controlp INFIELD dbee010 name="construct.c.dbee010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee010  #顯示到畫面上
            NEXT FIELD dbee010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee010
            #add-point:BEFORE FIELD dbee010 name="construct.b.dbee010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee010
            
            #add-point:AFTER FIELD dbee010 name="construct.a.dbee010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee011
            #add-point:ON ACTION controlp INFIELD dbee011 name="construct.c.dbee011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee011  #顯示到畫面上
            NEXT FIELD dbee011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee011
            #add-point:BEFORE FIELD dbee011 name="construct.b.dbee011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee011
            
            #add-point:AFTER FIELD dbee011 name="construct.a.dbee011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeestus
            #add-point:BEFORE FIELD dbeestus name="construct.b.dbeestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeestus
            
            #add-point:AFTER FIELD dbeestus name="construct.a.dbeestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeestus
            #add-point:ON ACTION controlp INFIELD dbeestus name="construct.c.dbeestus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbee002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee002
            #add-point:ON ACTION controlp INFIELD dbee002 name="construct.c.dbee002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mrba001_8()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee002  #顯示到畫面上
            NEXT FIELD dbee002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee002
            #add-point:BEFORE FIELD dbee002 name="construct.b.dbee002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee002
            
            #add-point:AFTER FIELD dbee002 name="construct.a.dbee002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee003
            #add-point:BEFORE FIELD dbee003 name="construct.b.dbee003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee003
            
            #add-point:AFTER FIELD dbee003 name="construct.a.dbee003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee003
            #add-point:ON ACTION controlp INFIELD dbee003 name="construct.c.dbee003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbee004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee004
            #add-point:ON ACTION controlp INFIELD dbee004 name="construct.c.dbee004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee004  #顯示到畫面上
            NEXT FIELD dbee004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee004
            #add-point:BEFORE FIELD dbee004 name="construct.b.dbee004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee004
            
            #add-point:AFTER FIELD dbee004 name="construct.a.dbee004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee005
            #add-point:ON ACTION controlp INFIELD dbee005 name="construct.c.dbee005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee005  #顯示到畫面上
            NEXT FIELD dbee005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee005
            #add-point:BEFORE FIELD dbee005 name="construct.b.dbee005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee005
            
            #add-point:AFTER FIELD dbee005 name="construct.a.dbee005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee006
            #add-point:BEFORE FIELD dbee006 name="construct.b.dbee006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee006
            
            #add-point:AFTER FIELD dbee006 name="construct.a.dbee006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee006
            #add-point:ON ACTION controlp INFIELD dbee006 name="construct.c.dbee006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbee007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee007
            #add-point:ON ACTION controlp INFIELD dbee007 name="construct.c.dbee007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee007  #顯示到畫面上
            NEXT FIELD dbee007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee007
            #add-point:BEFORE FIELD dbee007 name="construct.b.dbee007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee007
            
            #add-point:AFTER FIELD dbee007 name="construct.a.dbee007"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee008
            #add-point:BEFORE FIELD dbee008 name="construct.b.dbee008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee008
            
            #add-point:AFTER FIELD dbee008 name="construct.a.dbee008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee008
            #add-point:ON ACTION controlp INFIELD dbee008 name="construct.c.dbee008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbee009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee009
            #add-point:ON ACTION controlp INFIELD dbee009 name="construct.c.dbee009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbee009  #顯示到畫面上
            NEXT FIELD dbee009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee009
            #add-point:BEFORE FIELD dbee009 name="construct.b.dbee009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee009
            
            #add-point:AFTER FIELD dbee009 name="construct.a.dbee009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee012
            #add-point:BEFORE FIELD dbee012 name="construct.b.dbee012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee012
            
            #add-point:AFTER FIELD dbee012 name="construct.a.dbee012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee012
            #add-point:ON ACTION controlp INFIELD dbee012 name="construct.c.dbee012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee0071
            #add-point:BEFORE FIELD l_dbee0071 name="construct.b.l_dbee0071"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee0071
            
            #add-point:AFTER FIELD l_dbee0071 name="construct.a.l_dbee0071"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_dbee0071
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee0071
            #add-point:ON ACTION controlp INFIELD l_dbee0071 name="construct.c.l_dbee0071"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee013
            #add-point:BEFORE FIELD dbee013 name="construct.b.dbee013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee013
            
            #add-point:AFTER FIELD dbee013 name="construct.a.dbee013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbee013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee013
            #add-point:ON ACTION controlp INFIELD dbee013 name="construct.c.dbee013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee0091
            #add-point:BEFORE FIELD l_dbee0091 name="construct.b.l_dbee0091"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee0091
            
            #add-point:AFTER FIELD l_dbee0091 name="construct.a.l_dbee0091"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.l_dbee0091
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee0091
            #add-point:ON ACTION controlp INFIELD l_dbee0091 name="construct.c.l_dbee0091"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeeownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeeownid
            #add-point:ON ACTION controlp INFIELD dbeeownid name="construct.c.dbeeownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeeownid  #顯示到畫面上
            NEXT FIELD dbeeownid                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeeownid
            #add-point:BEFORE FIELD dbeeownid name="construct.b.dbeeownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeeownid
            
            #add-point:AFTER FIELD dbeeownid name="construct.a.dbeeownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeeowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeeowndp
            #add-point:ON ACTION controlp INFIELD dbeeowndp name="construct.c.dbeeowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeeowndp  #顯示到畫面上
            NEXT FIELD dbeeowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeeowndp
            #add-point:BEFORE FIELD dbeeowndp name="construct.b.dbeeowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeeowndp
            
            #add-point:AFTER FIELD dbeeowndp name="construct.a.dbeeowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeecrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeecrtid
            #add-point:ON ACTION controlp INFIELD dbeecrtid name="construct.c.dbeecrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeecrtid  #顯示到畫面上
            NEXT FIELD dbeecrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeecrtid
            #add-point:BEFORE FIELD dbeecrtid name="construct.b.dbeecrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeecrtid
            
            #add-point:AFTER FIELD dbeecrtid name="construct.a.dbeecrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.dbeecrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeecrtdp
            #add-point:ON ACTION controlp INFIELD dbeecrtdp name="construct.c.dbeecrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeecrtdp  #顯示到畫面上
            NEXT FIELD dbeecrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeecrtdp
            #add-point:BEFORE FIELD dbeecrtdp name="construct.b.dbeecrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeecrtdp
            
            #add-point:AFTER FIELD dbeecrtdp name="construct.a.dbeecrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeecrtdt
            #add-point:BEFORE FIELD dbeecrtdt name="construct.b.dbeecrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeemodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeemodid
            #add-point:ON ACTION controlp INFIELD dbeemodid name="construct.c.dbeemodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeemodid  #顯示到畫面上
            NEXT FIELD dbeemodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeemodid
            #add-point:BEFORE FIELD dbeemodid name="construct.b.dbeemodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeemodid
            
            #add-point:AFTER FIELD dbeemodid name="construct.a.dbeemodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeemoddt
            #add-point:BEFORE FIELD dbeemoddt name="construct.b.dbeemoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.dbeecnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeecnfid
            #add-point:ON ACTION controlp INFIELD dbeecnfid name="construct.c.dbeecnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbeecnfid  #顯示到畫面上
            NEXT FIELD dbeecnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeecnfid
            #add-point:BEFORE FIELD dbeecnfid name="construct.b.dbeecnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeecnfid
            
            #add-point:AFTER FIELD dbeecnfid name="construct.a.dbeecnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeecnfdt
            #add-point:BEFORE FIELD dbeecnfdt name="construct.b.dbeecnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON dbefseq,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004,dbef010,dbef005, 
          dbef009,dbef008,dbef007,dbef006,dbef011,l_imaa018,dbef012,l_imaa026,dbef013,dbef014,dbef015, 
          dbef016,dbefsite,l_dbee012,l_dbee013,l_qty_chk_flag
           FROM s_detail1[1].dbefseq,s_detail1[1].dbefunit,s_detail1[1].dbef000,s_detail1[1].dbef001, 
               s_detail1[1].dbef002,s_detail1[1].dbef003,s_detail1[1].dbef004,s_detail1[1].dbef010,s_detail1[1].dbef005, 
               s_detail1[1].dbef009,s_detail1[1].dbef008,s_detail1[1].dbef007,s_detail1[1].dbef006,s_detail1[1].dbef011, 
               s_detail1[1].l_imaa018,s_detail1[1].dbef012,s_detail1[1].l_imaa026,s_detail1[1].dbef013, 
               s_detail1[1].dbef014,s_detail1[1].dbef015,s_detail1[1].dbef016,s_detail1[1].dbefsite, 
               s_detail1[1].l_dbee012,s_detail1[1].l_dbee013,s_detail1[1].l_qty_chk_flag
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbefseq
            #add-point:BEFORE FIELD dbefseq name="construct.b.page1.dbefseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbefseq
            
            #add-point:AFTER FIELD dbefseq name="construct.a.page1.dbefseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbefseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbefseq
            #add-point:ON ACTION controlp INFIELD dbefseq name="construct.c.page1.dbefseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbefunit
            #add-point:BEFORE FIELD dbefunit name="construct.b.page1.dbefunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbefunit
            
            #add-point:AFTER FIELD dbefunit name="construct.a.page1.dbefunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbefunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbefunit
            #add-point:ON ACTION controlp INFIELD dbefunit name="construct.c.page1.dbefunit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef000
            #add-point:BEFORE FIELD dbef000 name="construct.b.page1.dbef000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef000
            
            #add-point:AFTER FIELD dbef000 name="construct.a.page1.dbef000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef000
            #add-point:ON ACTION controlp INFIELD dbef000 name="construct.c.page1.dbef000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef001
            #add-point:ON ACTION controlp INFIELD dbef001 name="construct.c.page1.dbef001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef001  #顯示到畫面上
            NEXT FIELD dbef001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef001
            #add-point:BEFORE FIELD dbef001 name="construct.b.page1.dbef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef001
            
            #add-point:AFTER FIELD dbef001 name="construct.a.page1.dbef001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef002
            #add-point:BEFORE FIELD dbef002 name="construct.b.page1.dbef002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef002
            
            #add-point:AFTER FIELD dbef002 name="construct.a.page1.dbef002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef002
            #add-point:ON ACTION controlp INFIELD dbef002 name="construct.c.page1.dbef002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef003
            #add-point:BEFORE FIELD dbef003 name="construct.b.page1.dbef003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef003
            
            #add-point:AFTER FIELD dbef003 name="construct.a.page1.dbef003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef003
            #add-point:ON ACTION controlp INFIELD dbef003 name="construct.c.page1.dbef003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbef004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef004
            #add-point:ON ACTION controlp INFIELD dbef004 name="construct.c.page1.dbef004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = 'ALL'
            CALL q_pmac002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef004  #顯示到畫面上
            NEXT FIELD dbef004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef004
            #add-point:BEFORE FIELD dbef004 name="construct.b.page1.dbef004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef004
            
            #add-point:AFTER FIELD dbef004 name="construct.a.page1.dbef004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef010
            #add-point:BEFORE FIELD dbef010 name="construct.b.page1.dbef010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef010
            
            #add-point:AFTER FIELD dbef010 name="construct.a.page1.dbef010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef010
            #add-point:ON ACTION controlp INFIELD dbef010 name="construct.c.page1.dbef010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbef005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef005
            #add-point:ON ACTION controlp INFIELD dbef005 name="construct.c.page1.dbef005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef005  #顯示到畫面上
            NEXT FIELD dbef005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef005
            #add-point:BEFORE FIELD dbef005 name="construct.b.page1.dbef005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef005
            
            #add-point:AFTER FIELD dbef005 name="construct.a.page1.dbef005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef009
            #add-point:BEFORE FIELD dbef009 name="construct.b.page1.dbef009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef009
            
            #add-point:AFTER FIELD dbef009 name="construct.a.page1.dbef009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef009
            #add-point:ON ACTION controlp INFIELD dbef009 name="construct.c.page1.dbef009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbef008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef008
            #add-point:ON ACTION controlp INFIELD dbef008 name="construct.c.page1.dbef008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef008  #顯示到畫面上
            NEXT FIELD dbef008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef008
            #add-point:BEFORE FIELD dbef008 name="construct.b.page1.dbef008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef008
            
            #add-point:AFTER FIELD dbef008 name="construct.a.page1.dbef008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef007
            #add-point:BEFORE FIELD dbef007 name="construct.b.page1.dbef007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef007
            
            #add-point:AFTER FIELD dbef007 name="construct.a.page1.dbef007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef007
            #add-point:ON ACTION controlp INFIELD dbef007 name="construct.c.page1.dbef007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbef006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef006
            #add-point:ON ACTION controlp INFIELD dbef006 name="construct.c.page1.dbef006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef006  #顯示到畫面上
            NEXT FIELD dbef006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef006
            #add-point:BEFORE FIELD dbef006 name="construct.b.page1.dbef006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef006
            
            #add-point:AFTER FIELD dbef006 name="construct.a.page1.dbef006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef011
            #add-point:BEFORE FIELD dbef011 name="construct.b.page1.dbef011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef011
            
            #add-point:AFTER FIELD dbef011 name="construct.a.page1.dbef011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef011
            #add-point:ON ACTION controlp INFIELD dbef011 name="construct.c.page1.dbef011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.l_imaa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imaa018
            #add-point:ON ACTION controlp INFIELD l_imaa018 name="construct.c.page1.l_imaa018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_imaa018  #顯示到畫面上
            NEXT FIELD l_imaa018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imaa018
            #add-point:BEFORE FIELD l_imaa018 name="construct.b.page1.l_imaa018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imaa018
            
            #add-point:AFTER FIELD l_imaa018 name="construct.a.page1.l_imaa018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef012
            #add-point:BEFORE FIELD dbef012 name="construct.b.page1.dbef012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef012
            
            #add-point:AFTER FIELD dbef012 name="construct.a.page1.dbef012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef012
            #add-point:ON ACTION controlp INFIELD dbef012 name="construct.c.page1.dbef012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.l_imaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_imaa026
            #add-point:ON ACTION controlp INFIELD l_imaa026 name="construct.c.page1.l_imaa026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO l_imaa026  #顯示到畫面上
            NEXT FIELD l_imaa026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_imaa026
            #add-point:BEFORE FIELD l_imaa026 name="construct.b.page1.l_imaa026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_imaa026
            
            #add-point:AFTER FIELD l_imaa026 name="construct.a.page1.l_imaa026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef013
            #add-point:ON ACTION controlp INFIELD dbef013 name="construct.c.page1.dbef013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_dbad001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbef013  #顯示到畫面上
            NEXT FIELD dbef013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef013
            #add-point:BEFORE FIELD dbef013 name="construct.b.page1.dbef013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef013
            
            #add-point:AFTER FIELD dbef013 name="construct.a.page1.dbef013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef014
            #add-point:BEFORE FIELD dbef014 name="construct.b.page1.dbef014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef014
            
            #add-point:AFTER FIELD dbef014 name="construct.a.page1.dbef014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef014
            #add-point:ON ACTION controlp INFIELD dbef014 name="construct.c.page1.dbef014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef015
            #add-point:BEFORE FIELD dbef015 name="construct.b.page1.dbef015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef015
            
            #add-point:AFTER FIELD dbef015 name="construct.a.page1.dbef015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef015
            #add-point:ON ACTION controlp INFIELD dbef015 name="construct.c.page1.dbef015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef016
            #add-point:BEFORE FIELD dbef016 name="construct.b.page1.dbef016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef016
            
            #add-point:AFTER FIELD dbef016 name="construct.a.page1.dbef016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.dbef016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef016
            #add-point:ON ACTION controlp INFIELD dbef016 name="construct.c.page1.dbef016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.dbefsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbefsite
            #add-point:ON ACTION controlp INFIELD dbefsite name="construct.c.page1.dbefsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO dbefsite  #顯示到畫面上
            NEXT FIELD dbefsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbefsite
            #add-point:BEFORE FIELD dbefsite name="construct.b.page1.dbefsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbefsite
            
            #add-point:AFTER FIELD dbefsite name="construct.a.page1.dbefsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee012
            #add-point:BEFORE FIELD l_dbee012 name="construct.b.page1.l_dbee012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee012
            
            #add-point:AFTER FIELD l_dbee012 name="construct.a.page1.l_dbee012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_dbee012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee012
            #add-point:ON ACTION controlp INFIELD l_dbee012 name="construct.c.page1.l_dbee012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee013
            #add-point:BEFORE FIELD l_dbee013 name="construct.b.page1.l_dbee013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee013
            
            #add-point:AFTER FIELD l_dbee013 name="construct.a.page1.l_dbee013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_dbee013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee013
            #add-point:ON ACTION controlp INFIELD l_dbee013 name="construct.c.page1.l_dbee013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty_chk_flag
            #add-point:BEFORE FIELD l_qty_chk_flag name="construct.b.page1.l_qty_chk_flag"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty_chk_flag
            
            #add-point:AFTER FIELD l_qty_chk_flag name="construct.a.page1.l_qty_chk_flag"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_qty_chk_flag
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty_chk_flag
            #add-point:ON ACTION controlp INFIELD l_qty_chk_flag name="construct.c.page1.l_qty_chk_flag"
            
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
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "dbee_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "dbef_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
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
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION adbt701_filter()
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
      CONSTRUCT g_wc_filter ON dbeesite,dbeedocdt,dbeedocno,dbee001,dbee002,dbee003,dbee004,dbee005, 
          dbee010,dbee011
                          FROM s_browse[1].b_dbeesite,s_browse[1].b_dbeedocdt,s_browse[1].b_dbeedocno, 
                              s_browse[1].b_dbee001,s_browse[1].b_dbee002,s_browse[1].b_dbee003,s_browse[1].b_dbee004, 
                              s_browse[1].b_dbee005,s_browse[1].b_dbee010,s_browse[1].b_dbee011
 
         BEFORE CONSTRUCT
               DISPLAY adbt701_filter_parser('dbeesite') TO s_browse[1].b_dbeesite
            DISPLAY adbt701_filter_parser('dbeedocdt') TO s_browse[1].b_dbeedocdt
            DISPLAY adbt701_filter_parser('dbeedocno') TO s_browse[1].b_dbeedocno
            DISPLAY adbt701_filter_parser('dbee001') TO s_browse[1].b_dbee001
            DISPLAY adbt701_filter_parser('dbee002') TO s_browse[1].b_dbee002
            DISPLAY adbt701_filter_parser('dbee003') TO s_browse[1].b_dbee003
            DISPLAY adbt701_filter_parser('dbee004') TO s_browse[1].b_dbee004
            DISPLAY adbt701_filter_parser('dbee005') TO s_browse[1].b_dbee005
            DISPLAY adbt701_filter_parser('dbee010') TO s_browse[1].b_dbee010
            DISPLAY adbt701_filter_parser('dbee011') TO s_browse[1].b_dbee011
      
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
 
      CALL adbt701_filter_show('dbeesite')
   CALL adbt701_filter_show('dbeedocdt')
   CALL adbt701_filter_show('dbeedocno')
   CALL adbt701_filter_show('dbee001')
   CALL adbt701_filter_show('dbee002')
   CALL adbt701_filter_show('dbee003')
   CALL adbt701_filter_show('dbee004')
   CALL adbt701_filter_show('dbee005')
   CALL adbt701_filter_show('dbee010')
   CALL adbt701_filter_show('dbee011')
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION adbt701_filter_parser(ps_field)
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
 
{<section id="adbt701.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION adbt701_filter_show(ps_field)
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
   LET ls_condition = adbt701_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION adbt701_query()
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
   CALL g_dbef_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL adbt701_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL adbt701_browser_fill("")
      CALL adbt701_fetch("")
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
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL adbt701_filter_show('dbeesite')
   CALL adbt701_filter_show('dbeedocdt')
   CALL adbt701_filter_show('dbeedocno')
   CALL adbt701_filter_show('dbee001')
   CALL adbt701_filter_show('dbee002')
   CALL adbt701_filter_show('dbee003')
   CALL adbt701_filter_show('dbee004')
   CALL adbt701_filter_show('dbee005')
   CALL adbt701_filter_show('dbee010')
   CALL adbt701_filter_show('dbee011')
   CALL adbt701_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL adbt701_fetch("F") 
      #顯示單身筆數
      CALL adbt701_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION adbt701_fetch(p_flag)
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
   
   LET g_dbee_m.dbeedocno = g_browser[g_current_idx].b_dbeedocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
   #遮罩相關處理
   LET g_dbee_m_mask_o.* =  g_dbee_m.*
   CALL adbt701_dbee_t_mask()
   LET g_dbee_m_mask_n.* =  g_dbee_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adbt701_set_act_visible()   
   CALL adbt701_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_dbee_m_t.* = g_dbee_m.*
   LET g_dbee_m_o.* = g_dbee_m.*
   
   LET g_data_owner = g_dbee_m.dbeeownid      
   LET g_data_dept  = g_dbee_m.dbeeowndp
   
   #重新顯示   
   CALL adbt701_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.insert" >}
#+ 資料新增
PRIVATE FUNCTION adbt701_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_insert    LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_dbef_d.clear()   
 
 
   INITIALIZE g_dbee_m.* TO NULL             #DEFAULT 設定
   
   LET g_dbeedocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbee_m.dbeeownid = g_user
      LET g_dbee_m.dbeeowndp = g_dept
      LET g_dbee_m.dbeecrtid = g_user
      LET g_dbee_m.dbeecrtdp = g_dept 
      LET g_dbee_m.dbeecrtdt = cl_get_current()
      LET g_dbee_m.dbeemodid = g_user
      LET g_dbee_m.dbeemoddt = cl_get_current()
      LET g_dbee_m.dbeestus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_dbee_m.dbee006 = "0"
      LET g_dbee_m.dbee012 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      CALL s_aooi500_default(g_prog,'dbeesite',g_dbee_m.dbeesite)
         RETURNING l_insert,g_dbee_m.dbeesite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      #CALL s_aooi500_default(g_prog,'dbeeunit',g_dbee_m.dbeesite)
      #   RETURNING l_insert,g_dbee_m.dbeeunit
      #IF l_insert = FALSE THEN
      #   RETURN
      #END IF
      
      LET g_dbee_m.dbeesite_desc = s_desc_get_department_desc(g_dbee_m.dbeesite)
      LET g_dbee_m.dbeedocdt     = g_today
      
      #此處校驗不需要特地開窗
      LET g_dbee_m.dbee001       = g_today
      LET g_errshow = 0
      IF NOT adbt701_dbee001_chk() THEN
         LET g_dbee_m.dbee001       = NULL
      END IF
      LET g_errshow = 1
      
      LET g_dbee_m.dbee010       = g_user
      LET g_dbee_m.dbee010_desc  = s_desc_get_person_desc(g_dbee_m.dbee010)
      CALL adbt701_dbee011_default()
      CALL s_arti200_get_def_doc_type(g_dbee_m.dbeesite,g_prog,'1')
         RETURNING l_success,g_dbee_m.dbeedocno
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_dbee_m_t.* = g_dbee_m.*
      LET g_dbee_m_o.* = g_dbee_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbee_m.dbeestus 
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
 
 
 
    
      CALL adbt701_input("a")
      
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
         INITIALIZE g_dbee_m.* TO NULL
         INITIALIZE g_dbef_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL adbt701_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_dbef_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adbt701_set_act_visible()   
   CALL adbt701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbeeent = " ||g_enterprise|| " AND",
                      " dbeedocno = '", g_dbee_m.dbeedocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbt701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE adbt701_cl
   
   CALL adbt701_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
   
   #遮罩相關處理
   LET g_dbee_m_mask_o.* =  g_dbee_m.*
   CALL adbt701_dbee_t_mask()
   LET g_dbee_m_mask_n.* =  g_dbee_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno, 
       g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee010_desc,g_dbee_m.dbee011,g_dbee_m.dbee011_desc, 
       g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee004_desc,g_dbee_m.dbee005, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee007_desc,g_dbee_m.dbee008, 
       g_dbee_m.dbee009,g_dbee_m.dbee009_desc,g_dbee_m.dbee012,g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0071_desc, 
       g_dbee_m.dbee013,g_dbee_m.l_dbee0091,g_dbee_m.l_dbee0091_desc,g_dbee_m.dbeeownid,g_dbee_m.dbeeownid_desc, 
       g_dbee_m.dbeeowndp,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp, 
       g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemodid_desc,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfid_desc,g_dbee_m.dbeecnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_dbee_m.dbeeownid      
   LET g_data_dept  = g_dbee_m.dbeeowndp
   
   #功能已完成,通報訊息中心
   CALL adbt701_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.modify" >}
#+ 資料修改
PRIVATE FUNCTION adbt701_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_dbee_m_t.* = g_dbee_m.*
   LET g_dbee_m_o.* = g_dbee_m.*
   
   IF g_dbee_m.dbeedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
   CALL s_transaction_begin()
   
   OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
   #檢查是否允許此動作
   IF NOT adbt701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dbee_m_mask_o.* =  g_dbee_m.*
   CALL adbt701_dbee_t_mask()
   LET g_dbee_m_mask_n.* =  g_dbee_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL adbt701_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_dbee_m.dbeemodid = g_user 
LET g_dbee_m.dbeemoddt = cl_get_current()
LET g_dbee_m.dbeemodid_desc = cl_get_username(g_dbee_m.dbeemodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_dbee_m.dbeestus MATCHES "[DR]" THEN
         LET g_dbee_m.dbeestus = "N"
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL adbt701_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE dbee_t SET (dbeemodid,dbeemoddt) = (g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt)
          WHERE dbeeent = g_enterprise AND dbeedocno = g_dbeedocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_dbee_m.* = g_dbee_m_t.*
            CALL adbt701_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_dbee_m.dbeedocno != g_dbee_m_t.dbeedocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE dbef_t SET dbefdocno = g_dbee_m.dbeedocno
 
          WHERE dbefent = g_enterprise AND dbefdocno = g_dbee_m_t.dbeedocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "dbef_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL adbt701_set_act_visible()   
   CALL adbt701_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " dbeeent = " ||g_enterprise|| " AND",
                      " dbeedocno = '", g_dbee_m.dbeedocno, "' "
 
   #填到對應位置
   CALL adbt701_browser_fill("")
 
   CLOSE adbt701_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adbt701_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="adbt701.input" >}
#+ 資料輸入
PRIVATE FUNCTION adbt701_input(p_cmd)
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
   DEFINE l_wc                   STRING
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_errno                STRING
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
   DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno, 
       g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee010_desc,g_dbee_m.dbee011,g_dbee_m.dbee011_desc, 
       g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee004_desc,g_dbee_m.dbee005, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee007_desc,g_dbee_m.dbee008, 
       g_dbee_m.dbee009,g_dbee_m.dbee009_desc,g_dbee_m.dbee012,g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0071_desc, 
       g_dbee_m.dbee013,g_dbee_m.l_dbee0091,g_dbee_m.l_dbee0091_desc,g_dbee_m.dbeeownid,g_dbee_m.dbeeownid_desc, 
       g_dbee_m.dbeeowndp,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp, 
       g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemodid_desc,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfid_desc,g_dbee_m.dbeecnfdt
   
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
   LET g_forupd_sql = "SELECT dbefseq,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004,dbef010,dbef005, 
       dbef009,dbef008,dbef007,dbef006,dbef011,dbef012,dbef013,dbef014,dbef015,dbef016,dbefsite FROM  
       dbef_t WHERE dbefent=? AND dbefdocno=? AND dbefseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbt701_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL adbt701_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL adbt701_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001, 
       g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus,g_dbee_m.dbee002
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   DISPLAY BY NAME g_dbee_m.dbeesite_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="adbt701.input.head" >}
      #單頭段
      INPUT BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001, 
          g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus,g_dbee_m.dbee002 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adbt701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL adbt701_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET g_ins_site_flag = '' 
            LET g_ins_docno_flag = ''
            LET g_dbee_m_t.* = g_dbee_m.*            
            #end add-point
            CALL adbt701_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeesite
            
            #add-point:AFTER FIELD dbeesite name="input.a.dbeesite"
            LET g_dbee_m.dbeesite_desc = ' '
            DISPLAY BY NAME g_dbee_m.dbeesite_desc
            IF NOT cl_null(g_dbee_m.dbeesite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbeesite != g_dbee_m_t.dbeesite OR g_dbee_m_t.dbeesite IS NULL )) THEN
                  LET l_success = ''
                  CALL s_aooi500_chk(g_prog,'dbeesite',g_dbee_m.dbeesite,g_dbee_m.dbeesite) RETURNING l_success,l_errno                  
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()   
                  
                     LET g_dbee_m.dbeesite = g_dbee_m_t.dbeesite
                     LET g_dbee_m.dbeesite_desc = s_desc_get_department_desc(g_dbee_m.dbeesite)
                     DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_ins_site_flag = 'Y'
                  END IF
               END IF
            END IF
            LET g_dbee_m.dbeesite_desc = s_desc_get_department_desc(g_dbee_m.dbeesite)
            DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc
            
            CALL adbt701_set_entry(p_cmd)
            CALL adbt701_set_no_entry(p_cmd)            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeesite
            #add-point:BEFORE FIELD dbeesite name="input.b.dbeesite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeesite
            #add-point:ON CHANGE dbeesite name="input.g.dbeesite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeedocdt
            #add-point:BEFORE FIELD dbeedocdt name="input.b.dbeedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeedocdt
            
            #add-point:AFTER FIELD dbeedocdt name="input.a.dbeedocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeedocdt
            #add-point:ON CHANGE dbeedocdt name="input.g.dbeedocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeeunit
            #add-point:BEFORE FIELD dbeeunit name="input.b.dbeeunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeeunit
            
            #add-point:AFTER FIELD dbeeunit name="input.a.dbeeunit"
            IF NOT cl_null(g_dbee_m.dbeeunit) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbeeunit != g_dbee_m_t.dbeeunit OR g_dbee_m_t.dbeeunit IS NULL )) THEN
                  CALL s_aooi500_chk(g_prog,'dbeeunit',g_dbee_m.dbeeunit,g_dbee_m.dbeesite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_dbee_m.dbeeunit = g_dbee_m_t.dbeeunit
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeeunit
            #add-point:ON CHANGE dbeeunit name="input.g.dbeeunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeedocno
            #add-point:BEFORE FIELD dbeedocno name="input.b.dbeedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeedocno
            
            #add-point:AFTER FIELD dbeedocno name="input.a.dbeedocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_dbee_m.dbeedocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dbee_m.dbeedocno != g_dbeedocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbee_t WHERE "||"dbeeent = '" ||g_enterprise|| "' AND "||"dbeedocno = '"||g_dbee_m.dbeedocno ||"'",'std-00004',0) THEN 
                     LET g_dbee_m.dbeedocno = g_dbeedocno_t
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT s_aooi200_chk_slip(g_dbee_m.dbeesite,'',g_dbee_m.dbeedocno,g_prog) THEN
                        LET g_dbee_m.dbeedocno = g_dbeedocno_t
                        NEXT FIELD CURRENT
                     ELSE
                        LET g_ins_docno_flag = 'Y'
                     END IF                       
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeedocno
            #add-point:ON CHANGE dbeedocno name="input.g.dbeedocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee001
            
            #add-point:AFTER FIELD dbee001 name="input.a.dbee001"
            IF NOT cl_null(g_dbee_m.dbee001) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbee001 != g_dbee_m_t.dbee001 OR g_dbee_m_t.dbee001 IS NULL )) THEN
                  IF g_dbee_m.dbee001 < g_dbee_m.dbeedocdt THEN
                     LET g_dbee_m.dbee001 = g_dbee_m_t.dbee001
                     
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbee_m.dbee001
                     LET g_errparam.code   = "adb-00294"      #出貨日期不可小於排車日期
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     NEXT FIELD CURRENT
                  ELSE
                     IF NOT adbt701_dbee001_chk() THEN
                        LET g_dbee_m.dbee001 = g_dbee_m_t.dbee001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee001
            #add-point:BEFORE FIELD dbee001 name="input.b.dbee001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee001
            #add-point:ON CHANGE dbee001 name="input.g.dbee001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee010
            
            #add-point:AFTER FIELD dbee010 name="input.a.dbee010"
            LET g_dbee_m.dbee010_desc = ' '
            DISPLAY BY NAME g_dbee_m.dbee010_desc
            IF NOT cl_null(g_dbee_m.dbee010) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbee010 != g_dbee_m_t.dbee010 OR g_dbee_m_t.dbee010 IS NULL )) THEN    #160824-00007#67 Mark By Ken 161007
               IF (g_dbee_m.dbee010 != g_dbee_m_o.dbee010 OR g_dbee_m_o.dbee010 IS NULL ) THEN    #160824-00007#67 Add By Ken 161007
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbee_m.dbee010
                  #160318-00025#23  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#23  by 07900 --add-end
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     #LET g_dbee_m.dbee010 = g_dbee_m_t.dbee010  #160824-00007#67 Mark By Ken 161007
                     LET g_dbee_m.dbee010 = g_dbee_m_o.dbee010   #160824-00007#67 Add By Ken 161007
                     LET g_dbee_m.dbee010_desc  = s_desc_get_person_desc(g_dbee_m.dbee010)
                     DISPLAY BY NAME g_dbee_m.dbee010,g_dbee_m.dbee010_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbee_m.dbee010_desc  = s_desc_get_person_desc(g_dbee_m.dbee010)
            DISPLAY BY NAME g_dbee_m.dbee010_desc
            CALL adbt701_dbee011_default()
            LET g_dbee_m_o.* = g_dbee_m.*    #160824-00007#67 Add By Ken 161007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee010
            #add-point:BEFORE FIELD dbee010 name="input.b.dbee010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee010
            #add-point:ON CHANGE dbee010 name="input.g.dbee010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee011
            
            #add-point:AFTER FIELD dbee011 name="input.a.dbee011"
            LET g_dbee_m.dbee011_desc = ' '
            DISPLAY BY NAME g_dbee_m.dbee011_desc
            IF NOT cl_null(g_dbee_m.dbee011) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbee011 != g_dbee_m_t.dbee011 OR g_dbee_m_t.dbee011 IS NULL )) THEN   #160824-00007#67 Mark By Ken 161007
               IF (g_dbee_m.dbee011 != g_dbee_m_o.dbee011 OR g_dbee_m_o.dbee011 IS NULL ) THEN   #160824-00007#67 Add By Ken 161007
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_dbee_m.dbee011
                  LET g_chkparam.arg2 = g_today
                   #160318-00025#23  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                 #160318-00025#23  by 07900 --add-end 
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     #LET g_dbee_m.dbee011 = g_dbee_m_t.dbee011  #160824-00007#67 Mark By Ken 161007
                     LET g_dbee_m.dbee011 = g_dbee_m_o.dbee011   #160824-00007#67 Add By Ken 161007
                     LET g_dbee_m.dbee011_desc = s_desc_get_department_desc(g_dbee_m.dbee011)
                     DISPLAY BY NAME g_dbee_m.dbee011,g_dbee_m.dbee011_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_dbee_m.dbee011_desc = s_desc_get_department_desc(g_dbee_m.dbee011)
            DISPLAY BY NAME g_dbee_m.dbee011_desc
            LET g_dbee_m_o.* = g_dbee_m.*   #160824-00007#67 Add By Ken 161007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee011
            #add-point:BEFORE FIELD dbee011 name="input.b.dbee011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee011
            #add-point:ON CHANGE dbee011 name="input.g.dbee011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbeestus
            #add-point:BEFORE FIELD dbeestus name="input.b.dbeestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbeestus
            
            #add-point:AFTER FIELD dbeestus name="input.a.dbeestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbeestus
            #add-point:ON CHANGE dbeestus name="input.g.dbeestus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee002
            
            #add-point:AFTER FIELD dbee002 name="input.a.dbee002"
            IF NOT cl_null(g_dbee_m.dbee002) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_dbee_m.dbee002 != g_dbee_m_t.dbee002 OR g_dbee_m_t.dbee002 IS NULL )) THEN    #160824-00007#67 Mark By Ken 161007
               IF (g_dbee_m.dbee002 != g_dbee_m_o.dbee002 OR g_dbee_m_o.dbee002 IS NULL ) THEN    #160824-00007#67 Add By Ken 161007
                  IF NOT adbt701_dbee002_chk() THEN
                     #160824-00007#67 Mark By Ken 161007(S)
                     #LET g_dbee_m.dbee002 = g_dbee_m_t.dbee002
                     #LET g_dbee_m.dbee003 = g_dbee_m_t.dbee003
                     #LET g_dbee_m.dbee004 = g_dbee_m_t.dbee004
                     #LET g_dbee_m.dbee005 = g_dbee_m_t.dbee005
                     #LET g_dbee_m.dbee006 = g_dbee_m_t.dbee006
                     #LET g_dbee_m.dbee007 = g_dbee_m_t.dbee007
                     #LET g_dbee_m.dbee008 = g_dbee_m_t.dbee008
                     #LET g_dbee_m.dbee009 = g_dbee_m_t.dbee009
                     #LET g_dbee_m.l_dbee0071 = g_dbee_m_t.l_dbee0071
                     #LET g_dbee_m.l_dbee0091 = g_dbee_m_t.l_dbee0091
                     #160824-00007#67 Mark By Ken 161007(E)
                     #160824-00007#67 Add By Ken 161007(S)
                     LET g_dbee_m.dbee002 = g_dbee_m_o.dbee002
                     LET g_dbee_m.dbee003 = g_dbee_m_o.dbee003
                     LET g_dbee_m.dbee004 = g_dbee_m_o.dbee004
                     LET g_dbee_m.dbee005 = g_dbee_m_o.dbee005
                     LET g_dbee_m.dbee006 = g_dbee_m_o.dbee006
                     LET g_dbee_m.dbee007 = g_dbee_m_o.dbee007
                     LET g_dbee_m.dbee008 = g_dbee_m_o.dbee008
                     LET g_dbee_m.dbee009 = g_dbee_m_o.dbee009
                     LET g_dbee_m.l_dbee0071 = g_dbee_m_o.l_dbee0071
                     LET g_dbee_m.l_dbee0091 = g_dbee_m_o.l_dbee0091
                     #160824-00007#67 Add By Ken 161007(E)                     
                     DISPLAY BY NAME g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,
                                     g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007,
                                     g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.l_dbee0071,
                                     g_dbee_m.l_dbee0091

                     CALL adbt701_dbee_ref()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_dbee_m.dbee002 = ''
               LET g_dbee_m.dbee003 = ''
               LET g_dbee_m.dbee004 = ''
               LET g_dbee_m.dbee005 = ''
               LET g_dbee_m.dbee006 = ''
               LET g_dbee_m.dbee007 = ''
               LET g_dbee_m.dbee008 = ''
               LET g_dbee_m.dbee009 = ''
               LET g_dbee_m.l_dbee0071 = ''
               LET g_dbee_m.l_dbee0091 = ''               
               LET g_dbee_m.dbee004_desc = ''
               LET g_dbee_m.dbee005_desc = ''
               LET g_dbee_m.dbee007_desc = ''
               LET g_dbee_m.dbee009_desc = ''
               LET g_dbee_m.l_dbee0071_desc = ''
               LET g_dbee_m.l_dbee0091_desc = ''
               
               DISPLAY BY NAME g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,
                               g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee008,g_dbee_m.dbee009,
                               g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0091,
                               g_dbee_m.dbee004_desc,g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,
                               g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc
            END IF
               
            CALL adbt701_dbee_val()
            CALL adbt701_dbee_ref()
            LET g_dbee_m_o.* = g_dbee_m.*   #160824-00007#67 Add By Ken 161007
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee002
            #add-point:BEFORE FIELD dbee002 name="input.b.dbee002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee002
            #add-point:ON CHANGE dbee002 name="input.g.dbee002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee012
            #add-point:BEFORE FIELD dbee012 name="input.b.dbee012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee012
            
            #add-point:AFTER FIELD dbee012 name="input.a.dbee012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee012
            #add-point:ON CHANGE dbee012 name="input.g.dbee012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbee013
            #add-point:BEFORE FIELD dbee013 name="input.b.dbee013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbee013
            
            #add-point:AFTER FIELD dbee013 name="input.a.dbee013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbee013
            #add-point:ON CHANGE dbee013 name="input.g.dbee013"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.dbeesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeesite
            #add-point:ON ACTION controlp INFIELD dbeesite name="input.c.dbeesite"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbee_m.dbeesite    #給予default值
            CALL s_aooi500_q_where(g_prog,'dbeesite',g_dbee_m.dbeesite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
               RETURNING l_wc
            LET g_qryparam.where = l_wc
            CALL q_ooef001_24()
            LET g_dbee_m.dbeesite = g_qryparam.return1              
            LET g_dbee_m.dbeesite_desc = s_desc_get_department_desc(g_dbee_m.dbeesite)
            DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc
            NEXT FIELD dbeesite                               #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dbeedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeedocdt
            #add-point:ON ACTION controlp INFIELD dbeedocdt name="input.c.dbeedocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbeeunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeeunit
            #add-point:ON ACTION controlp INFIELD dbeeunit name="input.c.dbeeunit"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbee_m.dbeeunit     
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dbeeunit',g_dbee_m.dbeesite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()
            LET g_dbee_m.dbeeunit = g_qryparam.return1
            DISPLAY g_dbee_m.dbeeunit TO dbeeunit 
            NEXT FIELD dbeeunit 
            #END add-point
 
 
         #Ctrlp:input.c.dbeedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeedocno
            #add-point:ON ACTION controlp INFIELD dbeedocno name="input.c.dbeedocno"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbee_m.dbeedocno             #給予default值

            LET g_ooef004 = ''
            SELECT ooef004 INTO g_ooef004
              FROM ooef_t
             WHERE ooef001 = g_dbee_m.dbeesite
               AND ooefent = g_enterprise
               
            LET g_qryparam.arg1 = g_ooef004 
            LET g_qryparam.arg2 = g_prog 
            
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_dbee_m.dbeedocno = g_qryparam.return1              

            DISPLAY g_dbee_m.dbeedocno TO dbeedocno              #

            NEXT FIELD dbeedocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.dbee001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee001
            #add-point:ON ACTION controlp INFIELD dbee001 name="input.c.dbee001"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbee010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee010
            #add-point:ON ACTION controlp INFIELD dbee010 name="input.c.dbee010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_dbee_m.dbee010             #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_dbee_m.dbee010 = g_qryparam.return1   
            DISPLAY g_dbee_m.dbee010 TO dbee010              #
            LET g_dbee_m.dbee010_desc  = s_desc_get_person_desc(g_dbee_m.dbee010)
            DISPLAY BY NAME g_dbee_m.dbee010_desc            
            NEXT FIELD dbee010                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dbee011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee011
            #add-point:ON ACTION controlp INFIELD dbee011 name="input.c.dbee011"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            LET g_qryparam.default1 = g_dbee_m.dbee011             #給予default值
            CALL q_ooeg001_4()   
            LET g_dbee_m.dbee011 = g_qryparam.return1              
            DISPLAY g_dbee_m.dbee011 TO dbee011              #
            LET g_dbee_m.dbee011_desc = s_desc_get_department_desc(g_dbee_m.dbee011)
            DISPLAY BY NAME g_dbee_m.dbee011
            NEXT FIELD dbee011                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.dbeestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbeestus
            #add-point:ON ACTION controlp INFIELD dbeestus name="input.c.dbeestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbee002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee002
            #add-point:ON ACTION controlp INFIELD dbee002 name="input.c.dbee002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_dbee_m.dbee001
            LET g_qryparam.arg2 = g_dbee_m.dbeesite
            LET g_qryparam.default1 = g_dbee_m.dbee002    #給予default值
            CALL q_mrba001_9()
            LET g_dbee_m.dbee002 = g_qryparam.return1 
            DISPLAY g_dbee_m.dbee002 TO dbee002
            NEXT FIELD dbee002
            #END add-point
 
 
         #Ctrlp:input.c.dbee012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee012
            #add-point:ON ACTION controlp INFIELD dbee012 name="input.c.dbee012"
            
            #END add-point
 
 
         #Ctrlp:input.c.dbee013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbee013
            #add-point:ON ACTION controlp INFIELD dbee013 name="input.c.dbee013"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_dbee_m.dbeedocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            LET g_dbee_m.dbeeunit = g_dbee_m.dbeesite
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_dbee_m.dbeesite,g_dbee_m.dbeedocno,g_dbee_m.dbeedocdt,g_prog)
               RETURNING l_success,g_dbee_m.dbeedocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_dbee_m.dbeedocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD g_dbee_m.dbeedocno
                  CONTINUE DIALOG
               END IF
               #end add-point
               
               INSERT INTO dbee_t (dbeeent,dbeesite,dbeedocdt,dbeeunit,dbeedocno,dbee001,dbee010,dbee011, 
                   dbeestus,dbee002,dbee003,dbee004,dbee005,dbee006,dbee007,dbee008,dbee009,dbee012, 
                   dbee013,dbeeownid,dbeeowndp,dbeecrtid,dbeecrtdp,dbeecrtdt,dbeemodid,dbeemoddt,dbeecnfid, 
                   dbeecnfdt)
               VALUES (g_enterprise,g_dbee_m.dbeesite,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno, 
                   g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus,g_dbee_m.dbee002, 
                   g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
                   g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid, 
                   g_dbee_m.dbeeowndp,g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid, 
                   g_dbee_m.dbeemoddt,g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_dbee_m:",SQLERRMESSAGE 
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
                  CALL adbt701_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL adbt701_b_fill()
                  CALL adbt701_b_fill2('0')
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
               CALL adbt701_dbee_t_mask_restore('restore_mask_o')
               
               UPDATE dbee_t SET (dbeesite,dbeedocdt,dbeeunit,dbeedocno,dbee001,dbee010,dbee011,dbeestus, 
                   dbee002,dbee003,dbee004,dbee005,dbee006,dbee007,dbee008,dbee009,dbee012,dbee013,dbeeownid, 
                   dbeeowndp,dbeecrtid,dbeecrtdp,dbeecrtdt,dbeemodid,dbeemoddt,dbeecnfid,dbeecnfdt) = (g_dbee_m.dbeesite, 
                   g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010, 
                   g_dbee_m.dbee011,g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004, 
                   g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee008,g_dbee_m.dbee009, 
                   g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp,g_dbee_m.dbeecrtid, 
                   g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt,g_dbee_m.dbeecnfid, 
                   g_dbee_m.dbeecnfdt)
                WHERE dbeeent = g_enterprise AND dbeedocno = g_dbeedocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "dbee_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL adbt701_dbee_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_dbee_m_t)
               LET g_log2 = util.JSON.stringify(g_dbee_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="adbt701.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_dbef_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_dbef_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL adbt701_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_dbef_d.getLength()
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
            OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN adbt701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE adbt701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_dbef_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_dbef_d[l_ac].dbefseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_dbef_d_t.* = g_dbef_d[l_ac].*  #BACKUP
               LET g_dbef_d_o.* = g_dbef_d[l_ac].*  #BACKUP
               CALL adbt701_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL adbt701_set_no_entry_b(l_cmd)
               IF NOT adbt701_lock_b("dbef_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH adbt701_bcl INTO g_dbef_d[l_ac].dbefseq,g_dbef_d[l_ac].dbefunit,g_dbef_d[l_ac].dbef000, 
                      g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002,g_dbef_d[l_ac].dbef003,g_dbef_d[l_ac].dbef004, 
                      g_dbef_d[l_ac].dbef010,g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef009,g_dbef_d[l_ac].dbef008, 
                      g_dbef_d[l_ac].dbef007,g_dbef_d[l_ac].dbef006,g_dbef_d[l_ac].dbef011,g_dbef_d[l_ac].dbef012, 
                      g_dbef_d[l_ac].dbef013,g_dbef_d[l_ac].dbef014,g_dbef_d[l_ac].dbef015,g_dbef_d[l_ac].dbef016, 
                      g_dbef_d[l_ac].dbefsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_dbef_d_t.dbefseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_dbef_d_mask_o[l_ac].* =  g_dbef_d[l_ac].*
                  CALL adbt701_dbef_t_mask()
                  LET g_dbef_d_mask_n[l_ac].* =  g_dbef_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL adbt701_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #lori522612  150226  add ----------------------(S)
            IF NOT cl_null(g_dbef_d[l_ac].dbef001) THEN
               CALL adbt701_qty_convert_for_sum(l_ac)
            END IF
            #lori522612  150226  add ----------------------(E)            
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
            INITIALIZE g_dbef_d[l_ac].* TO NULL 
            INITIALIZE g_dbef_d_t.* TO NULL 
            INITIALIZE g_dbef_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_dbef_d[l_ac].dbef000 = "1"
      LET g_dbef_d[l_ac].dbef009 = "0"
      LET g_dbef_d[l_ac].dbef007 = "0"
      LET g_dbef_d[l_ac].dbef012 = "0"
      LET g_dbef_d[l_ac].l_qty_chk_flag = "N"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            SELECT COALESCE(MAX(dbefseq),0)+1 INTO g_dbef_d[l_ac].dbefseq
              FROM dbef_t
             WHERE dbefent = g_enterprise
               AND dbefdocno = g_dbee_m.dbeedocno

            SELECT COALESCE(MAX(dbef015),0)+1 INTO g_dbef_d[l_ac].dbef015
              FROM dbef_t
             WHERE dbefent = g_enterprise
               AND dbefdocno = g_dbee_m.dbeedocno
                  
            #end add-point
            LET g_dbef_d_t.* = g_dbef_d[l_ac].*     #新輸入資料
            LET g_dbef_d_o.* = g_dbef_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL adbt701_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL adbt701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_dbef_d[li_reproduce_target].* = g_dbef_d[li_reproduce].*
 
               LET g_dbef_d[li_reproduce_target].dbefseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM dbef_t 
             WHERE dbefent = g_enterprise AND dbefdocno = g_dbee_m.dbeedocno
 
               AND dbefseq = g_dbef_d[l_ac].dbefseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               #lori522612  150226  mod ----------------------(S)
               IF NOT adbt701_qty_chk() AND g_dbef_d[l_ac].l_qty_chk_flag = 'N' THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT 
               ELSE
                  LET g_dbef_d[l_ac].l_qty_chk_flag = 'Y'  
               END IF 
               #lori522612  150226  mod ----------------------(S)
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbee_m.dbeedocno
               LET gs_keys[2] = g_dbef_d[g_detail_idx].dbefseq
               CALL adbt701_insert_b('dbef_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               IF NOT adbt701_upd_dbee() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT 
               END IF              
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_dbef_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL adbt701_b_fill()
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
               #lori522612  150226  add ----------------------(S)
               LET g_dbef_d[g_detail_idx].l_dbee012 = 0
               LET g_dbef_d[g_detail_idx].l_dbee013 = 0
               CALL adbt701_get_amount() RETURNING g_dbee_m.dbee012,g_dbee_m.dbee013
               DISPLAY BY NAME g_dbee_m.dbee012,g_dbee_m.dbee013
               #lori522612  150226  add ----------------------(E)
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
               LET gs_keys[01] = g_dbee_m.dbeedocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_dbef_d_t.dbefseq
 
            
               #刪除同層單身
               IF NOT adbt701_delete_b('dbef_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adbt701_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT adbt701_key_delete_b(gs_keys,'dbef_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE adbt701_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
 
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE adbt701_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
 
               #end add-point
               LET l_count = g_dbef_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
 
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_dbef_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbefseq
            #add-point:BEFORE FIELD dbefseq name="input.b.page1.dbefseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbefseq
            
            #add-point:AFTER FIELD dbefseq name="input.a.page1.dbefseq"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_dbee_m.dbeedocno IS NOT NULL AND g_dbef_d[g_detail_idx].dbefseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_dbee_m.dbeedocno != g_dbeedocno_t OR g_dbef_d[g_detail_idx].dbefseq != g_dbef_d_t.dbefseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM dbef_t WHERE "||"dbefent = '" ||g_enterprise|| "' AND "||"dbefdocno = '"||g_dbee_m.dbeedocno ||"' AND "|| "dbefseq = '"||g_dbef_d[g_detail_idx].dbefseq ||"'",'std-00004',0) THEN 
                     LET g_dbef_d[l_ac].dbefseq = g_dbef_d_t.dbefseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbefseq
            #add-point:ON CHANGE dbefseq name="input.g.page1.dbefseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef000
            #add-point:BEFORE FIELD dbef000 name="input.b.page1.dbef000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef000
            
            #add-point:AFTER FIELD dbef000 name="input.a.page1.dbef000"
            #ken---add---S
            IF NOT cl_null(g_dbef_d[l_ac].dbef000) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef000 !=g_dbef_d_o.dbef000 OR g_dbef_d_o.dbef000 IS NULL )) THEN   #150427-00012#8 20150728 mark by beckxie
               IF g_dbef_d[l_ac].dbef000 !=g_dbef_d_o.dbef000 OR cl_null(g_dbef_d_o.dbef000) THEN   #150427-00012#8 20150728 add by beckxie
                  IF NOT adbt701_dbef001_chk(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002) THEN
                    NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #ken---add---E
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef000
            #add-point:ON CHANGE dbef000 name="input.g.page1.dbef000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef001
            #add-point:BEFORE FIELD dbef001 name="input.b.page1.dbef001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef001
            
            #add-point:AFTER FIELD dbef001 name="input.a.page1.dbef001"
            IF NOT cl_null(g_dbef_d[l_ac].dbef001) THEN           
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef001 !=g_dbef_d_o.dbef001 OR g_dbef_d_o.dbef001 IS NULL )) THEN   #150427-00012#8 20150728 mark by beckxie
               IF g_dbef_d[l_ac].dbef001 !=g_dbef_d_o.dbef001 OR cl_null(g_dbef_d_o.dbef001) THEN   #150427-00012#8 20150728 add by beckxie
                  #ken---add---S
                  IF NOT adbt701_dbef001_chk(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002) THEN
                     NEXT FIELD CURRENT
                  END IF                  
                  #ken---add---E                      
                  
                  IF NOT adbt701_dbef_chk_and_val() THEN
                     LET g_dbef_d[l_ac].* = g_dbef_d_o.*
                     CALL adbt701_dbef_ref()       
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_dbef_d[l_ac].dbef002) THEN
                  CALL adbt701_upd_dbee() RETURNING l_success   
               END IF   
            END IF
            CALL adbt701_dbef_ref()
            CALL adbt701_set_entry_b(l_cmd)  #ken
            CALL adbt701_set_no_entry_b(l_cmd)            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef001
            #add-point:ON CHANGE dbef001 name="input.g.page1.dbef001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef002
            #add-point:BEFORE FIELD dbef002 name="input.b.page1.dbef002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef002
            
            #add-point:AFTER FIELD dbef002 name="input.a.page1.dbef002"
            IF NOT cl_null(g_dbef_d[l_ac].dbef002) THEN            
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef002 != g_dbef_d_o.dbef002 OR g_dbef_d_o.dbef002 IS NULL )) THEN   #150427-00012#8 20150728 mark by beckxie
               IF g_dbef_d[l_ac].dbef002 != g_dbef_d_o.dbef002 OR cl_null(g_dbef_d_o.dbef002) THEN   #150427-00012#8 20150728 add by beckxie
                  #ken---add---S
                  IF NOT adbt701_dbef001_chk(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002) THEN
                     NEXT FIELD CURRENT
                  END IF                  
                  #ken---add---E
                  IF g_dbef_d[l_ac].dbef001 IS NULL THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'adb-00349'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()            
                  ELSE            
                     IF g_dbef_d[l_ac].dbef002 IS NOT NULL THEN
                        IF NOT adbt701_dbef_chk_and_val() THEN
                          LET g_dbef_d[l_ac].* = g_dbef_d_o.*
                          CALL adbt701_dbef_ref()       
                          NEXT FIELD CURRENT
                        END IF
                     END IF   
                  END IF
               END IF
               IF NOT cl_null(g_dbef_d[l_ac].dbef001) THEN
                  CALL adbt701_upd_dbee() RETURNING l_success   
               END IF            
            END IF
            CALL adbt701_dbef_ref() 
            CALL adbt701_set_entry_b(l_cmd)  #ken
            CALL adbt701_set_no_entry_b(l_cmd)    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef002
            #add-point:ON CHANGE dbef002 name="input.g.page1.dbef002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef009
            #add-point:BEFORE FIELD dbef009 name="input.b.page1.dbef009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef009
            
            #add-point:AFTER FIELD dbef009 name="input.a.page1.dbef009"
            IF NOT cl_null(g_dbef_d[l_ac].dbef009) THEN
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef009 != g_dbef_d_o.dbef009 OR g_dbef_d_o.dbef009 IS NULL )) THEN   #150427-00012#8 20150728 mark by beckxie
               IF g_dbef_d[l_ac].dbef009 != g_dbef_d_o.dbef009 OR cl_null(g_dbef_d_o.dbef009) THEN   #150427-00012#8 20150728 mark by beckxie
                  IF NOT adbt701_dbef009_chk() THEN
                     LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                     NEXT FIELD CURRENT
                  ELSE
                     CALL adbt701_qty_convert(g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef009,g_dbef_d[l_ac].dbef008,g_dbef_d[l_ac].dbef006,
                                             g_dbef_d[l_ac].l_imaa018,'',g_dbef_d[l_ac].l_imaa026,'')
                        RETURNING l_success,g_dbef_d[l_ac].dbef007,g_dbef_d[l_ac].dbef011,g_dbef_d[l_ac].dbef012 
                     IF NOT l_success THEN
                        LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                        LET g_dbef_d[l_ac].dbef007 = g_dbef_d_o.dbef007
                        LET g_dbef_d[l_ac].dbef011 = g_dbef_d_o.dbef011
                        LET g_dbef_d[l_ac].dbef012 = g_dbef_d_o.dbef012
                        NEXT FIELD CURRENT
                     END IF
                     
                     #lori522612  150226  add ----------------------(S)
                     CALL adbt701_qty_convert_for_sum(l_ac)        

                     IF NOT adbt701_qty_chk() THEN
                       LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                       LET g_dbef_d[l_ac].dbef007 = g_dbef_d_o.dbef007
                       LET g_dbef_d[l_ac].dbef011 = g_dbef_d_o.dbef011
                       LET g_dbef_d[l_ac].dbef012 = g_dbef_d_o.dbef012
                       NEXT FIELD CURRENT
                    ELSE
                       LET g_dbef_d[l_ac].l_qty_chk_flag = 'Y'
                    END IF
                    #lori522612  150226  add ----------------------(E)                    
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef009
            #add-point:ON CHANGE dbef009 name="input.g.page1.dbef009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef007
            #add-point:BEFORE FIELD dbef007 name="input.b.page1.dbef007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef007
            
            #add-point:AFTER FIELD dbef007 name="input.a.page1.dbef007"
            IF NOT cl_null(g_dbef_d[l_ac].dbef007) THEN     
#               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef007 != g_dbef_d_o.dbef007 OR g_dbef_d_o.dbef007 IS NULL )) THEN   #150427-00012#8 20150728 mark by beckxie
               IF g_dbef_d[l_ac].dbef007 != g_dbef_d_o.dbef007 OR cl_null(g_dbef_d_o.dbef007) THEN   #150427-00012#8 20150728 add by beckxie
                  #數量轉換成包裝數量
                  CALL s_aooi250_convert_qty(g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef006,g_dbef_d[l_ac].dbef008,g_dbef_d[l_ac].dbef007)
                     RETURNING l_success,g_dbef_d[l_ac].dbef009 
                     
                  #包裝數量如大於最大可配送包裝數量時  秀錯誤訊息   
                  IF g_dbef_d[l_ac].dbef009 > adbt701_packing_max_qty(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbefseq,
                                           g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002) THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code   = 'adb-00351'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                     LET g_dbef_d[l_ac].dbef007 = g_dbef_d_o.dbef007
                     LET g_dbef_d[l_ac].dbef011 = g_dbef_d_o.dbef011
                     LET g_dbef_d[l_ac].dbef012 = g_dbef_d_o.dbef012
                     NEXT FIELD CURRENT
                  ELSE
                     #由包裝數量轉換相關的體積、重量
                     CALL adbt701_qty_convert(g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef009,g_dbef_d[l_ac].dbef008,g_dbef_d[l_ac].dbef006,
                                             g_dbef_d[l_ac].l_imaa018,'',g_dbef_d[l_ac].l_imaa026,'')
                        RETURNING l_success,g_dbef_d[l_ac].dbef007,g_dbef_d[l_ac].dbef011,g_dbef_d[l_ac].dbef012 
                     IF NOT l_success THEN
                        LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                        LET g_dbef_d[l_ac].dbef007 = g_dbef_d_o.dbef007
                        LET g_dbef_d[l_ac].dbef011 = g_dbef_d_o.dbef011
                        LET g_dbef_d[l_ac].dbef012 = g_dbef_d_o.dbef012
                        NEXT FIELD CURRENT
                     END IF
                     
                     #lori522612  150226  add ----------------------(S)
                     CALL adbt701_qty_convert_for_sum(l_ac)        
                     CALL adbt701_upd_dbee() RETURNING l_success   
                     IF NOT adbt701_qty_chk() THEN
                       LET g_dbef_d[l_ac].dbef009 = g_dbef_d_o.dbef009
                       LET g_dbef_d[l_ac].dbef007 = g_dbef_d_o.dbef007
                       LET g_dbef_d[l_ac].dbef011 = g_dbef_d_o.dbef011
                       LET g_dbef_d[l_ac].dbef012 = g_dbef_d_o.dbef012
                       NEXT FIELD CURRENT
                    ELSE
                       LET g_dbef_d[l_ac].l_qty_chk_flag = 'Y'                    
                    END IF
                    #lori522612  150226  add ----------------------(E)             
                  END IF
               END IF         
            END IF 
            CALL adbt701_set_entry_b(p_cmd)
            CALL adbt701_set_no_entry_b(p_cmd) 
            LET g_dbef_d_o.dbef009 = g_dbef_d[l_ac].dbef009
            LET g_dbef_d_o.dbef007 = g_dbef_d[l_ac].dbef007
            LET g_dbef_d_o.dbef011 = g_dbef_d[l_ac].dbef011
            LET g_dbef_d_o.dbef012 = g_dbef_d[l_ac].dbef012
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef007
            #add-point:ON CHANGE dbef007 name="input.g.page1.dbef007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef015
            #add-point:BEFORE FIELD dbef015 name="input.b.page1.dbef015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef015
            
            #add-point:AFTER FIELD dbef015 name="input.a.page1.dbef015"
            IF NOT cl_null(g_dbef_d[l_ac].dbef015) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_dbef_d[l_ac].dbef015 != g_dbef_d_t.dbef015 OR g_dbef_d_t.dbef015 IS NULL )) THEN
                  IF NOT adbt701_dbef015_chk() THEN
                     LET g_dbef_d[l_ac].dbef015 = g_dbef_d_t.dbef015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef015
            #add-point:ON CHANGE dbef015 name="input.g.page1.dbef015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dbef016
            #add-point:BEFORE FIELD dbef016 name="input.b.page1.dbef016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dbef016
            
            #add-point:AFTER FIELD dbef016 name="input.a.page1.dbef016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dbef016
            #add-point:ON CHANGE dbef016 name="input.g.page1.dbef016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee012
            #add-point:BEFORE FIELD l_dbee012 name="input.b.page1.l_dbee012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee012
            
            #add-point:AFTER FIELD l_dbee012 name="input.a.page1.l_dbee012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_dbee012
            #add-point:ON CHANGE l_dbee012 name="input.g.page1.l_dbee012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dbee013
            #add-point:BEFORE FIELD l_dbee013 name="input.b.page1.l_dbee013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dbee013
            
            #add-point:AFTER FIELD l_dbee013 name="input.a.page1.l_dbee013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_dbee013
            #add-point:ON CHANGE l_dbee013 name="input.g.page1.l_dbee013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_qty_chk_flag
            #add-point:BEFORE FIELD l_qty_chk_flag name="input.b.page1.l_qty_chk_flag"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_qty_chk_flag
            
            #add-point:AFTER FIELD l_qty_chk_flag name="input.a.page1.l_qty_chk_flag"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_qty_chk_flag
            #add-point:ON CHANGE l_qty_chk_flag name="input.g.page1.l_qty_chk_flag"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.dbefseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbefseq
            #add-point:ON ACTION controlp INFIELD dbefseq name="input.c.page1.dbefseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef000
            #add-point:ON ACTION controlp INFIELD dbef000 name="input.c.page1.dbef000"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef001
            #add-point:ON ACTION controlp INFIELD dbef001 name="input.c.page1.dbef001"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_dbef_d[l_ac].dbef001             #給予default值
            LET g_qryparam.default2 = "" #g_dbef_d[l_ac].xmdlseq #項次
            LET g_qryparam.default3 = "" #g_dbef_d[l_ac].xmdl008 #料件編號
            #給予arg
            LET g_qryparam.arg1 = g_dbef_d[l_ac].dbef000
            LET g_qryparam.arg2 = g_dbee_m.dbeesite
            LET g_qryparam.arg3 = g_dbee_m.dbee004
            LET g_qryparam.arg4 = g_dbee_m.dbee001
            CALL q_dbef001()                                #呼叫開窗

            LET g_dbef_d[l_ac].dbef001 = g_qryparam.return1              
            LET g_dbef_d[l_ac].dbef002 = g_qryparam.return2 
            DISPLAY BY NAME g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002
            NEXT FIELD dbef001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef002
            #add-point:ON ACTION controlp INFIELD dbef002 name="input.c.page1.dbef002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef009
            #add-point:ON ACTION controlp INFIELD dbef009 name="input.c.page1.dbef009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef007
            #add-point:ON ACTION controlp INFIELD dbef007 name="input.c.page1.dbef007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef015
            #add-point:ON ACTION controlp INFIELD dbef015 name="input.c.page1.dbef015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.dbef016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dbef016
            #add-point:ON ACTION controlp INFIELD dbef016 name="input.c.page1.dbef016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_dbee012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee012
            #add-point:ON ACTION controlp INFIELD l_dbee012 name="input.c.page1.l_dbee012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_dbee013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dbee013
            #add-point:ON ACTION controlp INFIELD l_dbee013 name="input.c.page1.l_dbee013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.l_qty_chk_flag
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_qty_chk_flag
            #add-point:ON ACTION controlp INFIELD l_qty_chk_flag name="input.c.page1.l_qty_chk_flag"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_dbef_d[l_ac].* = g_dbef_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE adbt701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_dbef_d[l_ac].dbefseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_dbef_d[l_ac].* = g_dbef_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               #lori522612  150226  mod ----------------------(S)
               IF NOT adbt701_qty_chk() AND g_dbef_d[l_ac].l_qty_chk_flag = 'N' THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  LET g_dbef_d[l_ac].l_qty_chk_flag = 'Y'  
               END IF 
               #lori522612  150226  mod ----------------------(S)               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL adbt701_dbef_t_mask_restore('restore_mask_o')
      
               UPDATE dbef_t SET (dbefdocno,dbefseq,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004, 
                   dbef010,dbef005,dbef009,dbef008,dbef007,dbef006,dbef011,dbef012,dbef013,dbef014,dbef015, 
                   dbef016,dbefsite) = (g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbefseq,g_dbef_d[l_ac].dbefunit, 
                   g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002,g_dbef_d[l_ac].dbef003, 
                   g_dbef_d[l_ac].dbef004,g_dbef_d[l_ac].dbef010,g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef009, 
                   g_dbef_d[l_ac].dbef008,g_dbef_d[l_ac].dbef007,g_dbef_d[l_ac].dbef006,g_dbef_d[l_ac].dbef011, 
                   g_dbef_d[l_ac].dbef012,g_dbef_d[l_ac].dbef013,g_dbef_d[l_ac].dbef014,g_dbef_d[l_ac].dbef015, 
                   g_dbef_d[l_ac].dbef016,g_dbef_d[l_ac].dbefsite)
                WHERE dbefent = g_enterprise AND dbefdocno = g_dbee_m.dbeedocno 
 
                  AND dbefseq = g_dbef_d_t.dbefseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_dbef_d[l_ac].* = g_dbef_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbef_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_dbef_d[l_ac].* = g_dbef_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_dbee_m.dbeedocno
               LET gs_keys_bak[1] = g_dbeedocno_t
               LET gs_keys[2] = g_dbef_d[g_detail_idx].dbefseq
               LET gs_keys_bak[2] = g_dbef_d_t.dbefseq
               CALL adbt701_update_b('dbef_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL adbt701_dbef_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_dbef_d[g_detail_idx].dbefseq = g_dbef_d_t.dbefseq 
 
                  ) THEN
                  LET gs_keys[01] = g_dbee_m.dbeedocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_dbef_d_t.dbefseq
 
                  CALL adbt701_key_update_b(gs_keys,'dbef_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_dbee_m),util.JSON.stringify(g_dbef_d_t)
               LET g_log2 = util.JSON.stringify(g_dbee_m),util.JSON.stringify(g_dbef_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF NOT adbt701_upd_dbee() THEN
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL adbt701_unlock_b("dbef_t","'1'")
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
               LET g_dbef_d[li_reproduce_target].* = g_dbef_d[li_reproduce].*
 
               LET g_dbef_d[li_reproduce_target].dbefseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_dbef_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_dbef_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="adbt701.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' OR p_cmd = 'r' THEN
            LET g_ins_site_flag = 'N' 
            LET g_ins_docno_flag = 'N'
            NEXT FIELD dbeesite
         ELSE   
            CALL adbt701_set_entry(p_cmd)
            CALL adbt701_set_no_entry(p_cmd)
         END IF   
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD dbeedocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD dbefseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adbt701_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_imaa016   LIKE imaa_t.imaa016
   DEFINE l_imaa025   LIKE imaa_t.imaa025
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL adbt701_b_fill() #單身填充
      CALL adbt701_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL adbt701_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #140513-00002#7 by benson --- S
   LET g_dbee_m.l_dbee0071 = g_dbee_m.dbee007
   LET g_dbee_m.l_dbee0071_desc =  g_dbee_m.dbee007_desc
   LET g_dbee_m.l_dbee0091 = g_dbee_m.dbee009
   LET g_dbee_m.l_dbee0091_desc =  g_dbee_m.dbee009_desc
   #140513-00002#7 by benson --- E
   #end add-point
   
   #遮罩相關處理
   LET g_dbee_m_mask_o.* =  g_dbee_m.*
   CALL adbt701_dbee_t_mask()
   LET g_dbee_m_mask_n.* =  g_dbee_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno, 
       g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee010_desc,g_dbee_m.dbee011,g_dbee_m.dbee011_desc, 
       g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee004_desc,g_dbee_m.dbee005, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee007_desc,g_dbee_m.dbee008, 
       g_dbee_m.dbee009,g_dbee_m.dbee009_desc,g_dbee_m.dbee012,g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0071_desc, 
       g_dbee_m.dbee013,g_dbee_m.l_dbee0091,g_dbee_m.l_dbee0091_desc,g_dbee_m.dbeeownid,g_dbee_m.dbeeownid_desc, 
       g_dbee_m.dbeeowndp,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp, 
       g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemodid_desc,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfid_desc,g_dbee_m.dbeecnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbee_m.dbeestus 
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
   FOR l_ac = 1 TO g_dbef_d.getLength()
      #add-point:show段單身reference name="show.body.reference"

      CALL adbt701_item_ref(g_dbef_d[l_ac].dbef005) RETURNING l_imaa016,g_dbef_d[l_ac].l_imaa018,l_imaa025,g_dbef_d[l_ac].l_imaa026
      DISPLAY BY NAME g_dbef_d[l_ac].l_imaa018,g_dbef_d[l_ac].l_imaa026
      
      CALL adbt701_dbef_ref()
         
      #lori522612  150226  add ----------------------(S)
      CALL adbt701_qty_convert_for_sum(l_ac)
      #lori522612  150226  add ----------------------(E)      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL adbt701_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION adbt701_detail_show()
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
 
{<section id="adbt701.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION adbt701_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE dbee_t.dbeedocno 
   DEFINE l_oldno     LIKE dbee_t.dbeedocno 
 
   DEFINE l_master    RECORD LIKE dbee_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE dbef_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_dbee_m.dbeedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
    
   LET g_dbee_m.dbeedocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_dbee_m.dbeeownid = g_user
      LET g_dbee_m.dbeeowndp = g_dept
      LET g_dbee_m.dbeecrtid = g_user
      LET g_dbee_m.dbeecrtdp = g_dept 
      LET g_dbee_m.dbeecrtdt = cl_get_current()
      LET g_dbee_m.dbeemodid = g_user
      LET g_dbee_m.dbeemoddt = cl_get_current()
      LET g_dbee_m.dbeestus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_dbee_m.dbeestus 
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
   
   
   CALL adbt701_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_dbee_m.* TO NULL
      INITIALIZE g_dbef_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL adbt701_show()
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
   CALL adbt701_set_act_visible()   
   CALL adbt701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " dbeeent = " ||g_enterprise|| " AND",
                      " dbeedocno = '", g_dbee_m.dbeedocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL adbt701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL adbt701_idx_chk()
   
   LET g_data_owner = g_dbee_m.dbeeownid      
   LET g_data_dept  = g_dbee_m.dbeeowndp
   
   #功能已完成,通報訊息中心
   CALL adbt701_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION adbt701_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE dbef_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE adbt701_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM dbef_t
    WHERE dbefent = g_enterprise AND dbefdocno = g_dbeedocno_t
 
    INTO TEMP adbt701_detail
 
   #將key修正為調整後   
   UPDATE adbt701_detail 
      #更新key欄位
      SET dbefdocno = g_dbee_m.dbeedocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO dbef_t SELECT * FROM adbt701_detail
   
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
   DROP TABLE adbt701_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adbt701_delete()
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
   
   IF g_dbee_m.dbeedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT adbt701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_dbee_m_mask_o.* =  g_dbee_m.*
   CALL adbt701_dbee_t_mask()
   LET g_dbee_m_mask_n.* =  g_dbee_m.*
   
   CALL adbt701_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL adbt701_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_dbeedocno_t = g_dbee_m.dbeedocno
 
 
      DELETE FROM dbee_t
       WHERE dbeeent = g_enterprise AND dbeedocno = g_dbee_m.dbeedocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_dbee_m.dbeedocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_dbee_m.dbeedocno,g_dbee_m.dbeedocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM dbef_t
       WHERE dbefent = g_enterprise AND dbefdocno = g_dbee_m.dbeedocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_dbee_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE adbt701_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_dbef_d.clear() 
 
     
      CALL adbt701_ui_browser_refresh()  
      #CALL adbt701_ui_headershow()  
      #CALL adbt701_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL adbt701_browser_fill("")
         CALL adbt701_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE adbt701_cl
 
   #功能已完成,通報訊息中心
   CALL adbt701_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="adbt701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbt701_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_dbef_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF adbt701_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT dbefseq,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004,dbef010, 
             dbef005,dbef009,dbef008,dbef007,dbef006,dbef011,dbef012,dbef013,dbef014,dbef015,dbef016, 
             dbefsite ,t1.ooefl003 ,t2.pmaal004 ,t3.imaal003 ,t4.oocal003 ,t5.oocal003 ,t8.dbadl003 , 
             t9.dbacl003 FROM dbef_t",   
                     " INNER JOIN dbee_t ON dbeeent = " ||g_enterprise|| " AND dbeedocno = dbefdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=dbefunit AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=dbef004 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=dbef005 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t4 ON t4.oocalent="||g_enterprise||" AND t4.oocal001=dbef008 AND t4.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=dbef006 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN dbadl_t t8 ON t8.dbadlent="||g_enterprise||" AND t8.dbadl001=dbef013 AND t8.dbadl002='"||g_dlang||"' ",
               " LEFT JOIN dbacl_t t9 ON t9.dbaclent="||g_enterprise||" AND t9.dbacl001=dbef014 AND t9.dbacl002='"||g_dlang||"' ",
 
                     " WHERE dbefent=? AND dbefdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY dbef_t.dbefseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE adbt701_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR adbt701_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_dbee_m.dbeedocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_dbee_m.dbeedocno INTO g_dbef_d[l_ac].dbefseq,g_dbef_d[l_ac].dbefunit, 
          g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002,g_dbef_d[l_ac].dbef003, 
          g_dbef_d[l_ac].dbef004,g_dbef_d[l_ac].dbef010,g_dbef_d[l_ac].dbef005,g_dbef_d[l_ac].dbef009, 
          g_dbef_d[l_ac].dbef008,g_dbef_d[l_ac].dbef007,g_dbef_d[l_ac].dbef006,g_dbef_d[l_ac].dbef011, 
          g_dbef_d[l_ac].dbef012,g_dbef_d[l_ac].dbef013,g_dbef_d[l_ac].dbef014,g_dbef_d[l_ac].dbef015, 
          g_dbef_d[l_ac].dbef016,g_dbef_d[l_ac].dbefsite,g_dbef_d[l_ac].dbefunit_desc,g_dbef_d[l_ac].dbef004_desc, 
          g_dbef_d[l_ac].dbef005_desc,g_dbef_d[l_ac].dbef008_desc,g_dbef_d[l_ac].dbef006_desc,g_dbef_d[l_ac].dbef013_desc, 
          g_dbef_d[l_ac].dbef014_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #lori522612  150226  add ----------------------(S)
         LET g_dbef_d[l_ac].l_qty_chk_flag = 'Y'
         #lori522612  150226  add ----------------------(E)
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_dbef_d.deleteElement(g_dbef_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE adbt701_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_dbef_d.getLength()
      LET g_dbef_d_mask_o[l_ac].* =  g_dbef_d[l_ac].*
      CALL adbt701_dbef_t_mask()
      LET g_dbef_d_mask_n[l_ac].* =  g_dbef_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION adbt701_delete_b(ps_table,ps_keys_bak,ps_page)
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
      #lori522612  150226  add ----------------------(S)
      LET g_dbef_d[g_detail_idx].l_dbee012 = 0
      LET g_dbef_d[g_detail_idx].l_dbee013 = 0
      #lori522612  150226  add ----------------------(E)
      #end add-point    
      DELETE FROM dbef_t
       WHERE dbefent = g_enterprise AND
         dbefdocno = ps_keys_bak[1] AND dbefseq = ps_keys_bak[2]
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
         CALL g_dbef_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   #lori522612  150226  add ----------------------(S)
   IF NOT adbt701_upd_dbee() THEN
      RETURN FALSE   
   END IF
   #lori522612  150226  add ----------------------(E)
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION adbt701_insert_b(ps_table,ps_keys,ps_page)
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
      LET g_dbef_d[g_detail_idx].dbefsite = g_dbee_m.dbeesite
      LET g_dbef_d[g_detail_idx].dbefunit = g_dbee_m.dbeesite
      #end add-point 
      INSERT INTO dbef_t
                  (dbefent,
                   dbefdocno,
                   dbefseq
                   ,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004,dbef010,dbef005,dbef009,dbef008,dbef007,dbef006,dbef011,dbef012,dbef013,dbef014,dbef015,dbef016,dbefsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_dbef_d[g_detail_idx].dbefunit,g_dbef_d[g_detail_idx].dbef000,g_dbef_d[g_detail_idx].dbef001, 
                       g_dbef_d[g_detail_idx].dbef002,g_dbef_d[g_detail_idx].dbef003,g_dbef_d[g_detail_idx].dbef004, 
                       g_dbef_d[g_detail_idx].dbef010,g_dbef_d[g_detail_idx].dbef005,g_dbef_d[g_detail_idx].dbef009, 
                       g_dbef_d[g_detail_idx].dbef008,g_dbef_d[g_detail_idx].dbef007,g_dbef_d[g_detail_idx].dbef006, 
                       g_dbef_d[g_detail_idx].dbef011,g_dbef_d[g_detail_idx].dbef012,g_dbef_d[g_detail_idx].dbef013, 
                       g_dbef_d[g_detail_idx].dbef014,g_dbef_d[g_detail_idx].dbef015,g_dbef_d[g_detail_idx].dbef016, 
                       g_dbef_d[g_detail_idx].dbefsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_dbef_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION adbt701_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "dbef_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL adbt701_dbef_t_mask_restore('restore_mask_o')
               
      UPDATE dbef_t 
         SET (dbefdocno,
              dbefseq
              ,dbefunit,dbef000,dbef001,dbef002,dbef003,dbef004,dbef010,dbef005,dbef009,dbef008,dbef007,dbef006,dbef011,dbef012,dbef013,dbef014,dbef015,dbef016,dbefsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_dbef_d[g_detail_idx].dbefunit,g_dbef_d[g_detail_idx].dbef000,g_dbef_d[g_detail_idx].dbef001, 
                  g_dbef_d[g_detail_idx].dbef002,g_dbef_d[g_detail_idx].dbef003,g_dbef_d[g_detail_idx].dbef004, 
                  g_dbef_d[g_detail_idx].dbef010,g_dbef_d[g_detail_idx].dbef005,g_dbef_d[g_detail_idx].dbef009, 
                  g_dbef_d[g_detail_idx].dbef008,g_dbef_d[g_detail_idx].dbef007,g_dbef_d[g_detail_idx].dbef006, 
                  g_dbef_d[g_detail_idx].dbef011,g_dbef_d[g_detail_idx].dbef012,g_dbef_d[g_detail_idx].dbef013, 
                  g_dbef_d[g_detail_idx].dbef014,g_dbef_d[g_detail_idx].dbef015,g_dbef_d[g_detail_idx].dbef016, 
                  g_dbef_d[g_detail_idx].dbefsite) 
         WHERE dbefent = g_enterprise AND dbefdocno = ps_keys_bak[1] AND dbefseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbef_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "dbef_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL adbt701_dbef_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION adbt701_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="adbt701.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION adbt701_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="adbt701.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION adbt701_lock_b(ps_table,ps_page)
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
   #CALL adbt701_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "dbef_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN adbt701_bcl USING g_enterprise,
                                       g_dbee_m.dbeedocno,g_dbef_d[g_detail_idx].dbefseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adbt701_bcl:",SQLERRMESSAGE 
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
 
{<section id="adbt701.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION adbt701_unlock_b(ps_table,ps_page)
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
      CLOSE adbt701_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION adbt701_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("dbeedocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("dbeedocno",TRUE)
      CALL cl_set_comp_entry("dbeedocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("dbeesite",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("dbee002",TRUE)
   CALL cl_set_comp_entry("dbeesite,dbeeunit",TRUE) 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION adbt701_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("dbeedocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("dbeesite",FALSE)
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("dbeedocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("dbeedocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF p_cmd = 'a' AND NOT cl_null(g_dbee_m.dbeedocno) AND g_ins_docno_flag = 'Y' THEN
      CALL cl_set_comp_entry("dbeedocno",FALSE)
   END IF  

   IF adbt701_dbef_cnt() > 0 THEN
      CALL cl_set_comp_entry("dbee002",FALSE)
   END IF
      
   #aooi500設定的欄位控卡
   IF (NOT s_aooi500_comp_entry(g_prog,'dbeesite') OR g_ins_site_flag = 'Y') THEN
      CALL cl_set_comp_entry("dbeesite",FALSE)
   END IF
   IF NOT s_aooi500_comp_entry(g_prog,'dbeeunit') THEN
      CALL cl_set_comp_entry("dbeeunit",FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION adbt701_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("dbef000",TRUE)
   CALL cl_set_comp_entry("dbef009",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION adbt701_set_no_entry_b(p_cmd)
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
   #ken---add---s
   IF NOT cl_null(g_dbef_d[l_ac].dbef001) AND NOT cl_null(g_dbef_d[l_ac].dbef002) THEN
     CALL cl_set_comp_entry("dbef000",FALSE)
   END IF
   IF NOT cl_null(g_dbef_d[l_ac].dbef007)  THEN
     CALL cl_set_comp_entry("dbef009",FALSE)
   END IF
   #ken---add---e 
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION adbt701_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION adbt701_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_dbee_m.dbeestus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION adbt701_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION adbt701_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION adbt701_default_search()
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
      LET ls_wc = ls_wc, " dbeedocno = '", g_argv[01], "' AND "
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
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "dbee_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "dbef_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
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
 
{<section id="adbt701.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION adbt701_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_dbee_m.dbeedocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
   IF STATUS THEN
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt701_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
       g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
       g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
       g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
       g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc, 
       g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp_desc, 
       g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT adbt701_action_chk() THEN
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit,g_dbee_m.dbeedocno, 
       g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee010_desc,g_dbee_m.dbee011,g_dbee_m.dbee011_desc, 
       g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee004_desc,g_dbee_m.dbee005, 
       g_dbee_m.dbee005_desc,g_dbee_m.dbee006,g_dbee_m.dbee007,g_dbee_m.dbee007_desc,g_dbee_m.dbee008, 
       g_dbee_m.dbee009,g_dbee_m.dbee009_desc,g_dbee_m.dbee012,g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0071_desc, 
       g_dbee_m.dbee013,g_dbee_m.l_dbee0091,g_dbee_m.l_dbee0091_desc,g_dbee_m.dbeeownid,g_dbee_m.dbeeownid_desc, 
       g_dbee_m.dbeeowndp,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp, 
       g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemodid_desc,g_dbee_m.dbeemoddt, 
       g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfid_desc,g_dbee_m.dbeecnfdt
 
   CASE g_dbee_m.dbeestus
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
         CASE g_dbee_m.dbeestus
            
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
      #160825-00043#1 Add By Ken 160830(S)
      CALL cl_set_act_visible("signing,withdraw,closed",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #160825-00043#1 Add By Ken 160830(E) 
      CASE g_dbee_m.dbeestus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,hold",FALSE)
            CALL s_transaction_end('N','0')   #160816-00068#3 add
            RETURN
         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed,hold",FALSE)

         WHEN "A"   #已核准
            CALL cl_set_act_visible("confirmed ",TRUE)

         WHEN "R"   #已拒絕
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "D"   #抽單
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            CALL cl_set_act_visible("invalid,confirmed",TRUE)

            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         WHEN "W"   #送簽中
            CALL cl_set_act_visible("withdraw",TRUE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT adbt701_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adbt701_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT adbt701_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE adbt701_cl
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
      g_dbee_m.dbeestus = lc_state OR cl_null(lc_state) THEN
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL s_transaction_begin()
   OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN adbt701_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CASE
      WHEN lc_state = 'Y'    #確認
         CALL cl_err_collect_init()
         IF NOT s_adbt701_conf_chk(g_dbee_m.dbeedocno,g_dbee_m.dbeestus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()               
            RETURN
         END IF
         CALL cl_err_collect_show() 
         
         IF cl_ask_confirm('aim-00108') THEN
            CALL cl_err_collect_init()
            IF NOT s_adbt701_conf_upd(g_dbee_m.dbeedocno) THEN               
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()   
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()   
            END IF
         ELSE
            LET lc_state = g_dbee_m.dbeestus
            CALL s_transaction_end('N','0')
         END IF
      
      WHEN lc_state = 'N'    #取消確認
         CALL cl_err_collect_init()
         IF NOT s_adbt701_unconf_chk(g_dbee_m.dbeedocno,g_dbee_m.dbeestus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()
            RETURN
         END IF
         CALL cl_err_collect_show()
         
         IF cl_ask_confirm('aim-00110') THEN
            CALL cl_err_collect_init()
            IF NOT s_adbt701_unconf_upd(g_dbee_m.dbeedocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()  
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()   
            END IF
         ELSE
            LET lc_state = g_dbee_m.dbeestus
            CALL s_transaction_end('N','0')
         END IF
      
      WHEN lc_state = 'X'   #作廢
         CALL cl_err_collect_init()
         IF NOT s_adbt701_invalid_chk(g_dbee_m.dbeedocno,g_dbee_m.dbeestus) THEN
            CALL s_transaction_end('N','0')
            CALL cl_err_collect_show()   #彙總錯誤訊息-顯示
            RETURN
         END IF
         CALL cl_err_collect_init()
         
         IF cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_init()
            IF NOT s_adbt701_invalid_upd(g_dbee_m.dbeedocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()  
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()  
            END IF
         ELSE
            LET lc_state = g_dbee_m.dbeestus
            CALL s_transaction_end('N','0')
         END IF
   END CASE   
   #end add-point
   
   LET g_dbee_m.dbeemodid = g_user
   LET g_dbee_m.dbeemoddt = cl_get_current()
   LET g_dbee_m.dbeestus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE dbee_t 
      SET (dbeestus,dbeemodid,dbeemoddt) 
        = (g_dbee_m.dbeestus,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt)     
    WHERE dbeeent = g_enterprise AND dbeedocno = g_dbee_m.dbeedocno
 
    
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
      EXECUTE adbt701_master_referesh USING g_dbee_m.dbeedocno INTO g_dbee_m.dbeesite,g_dbee_m.dbeedocdt, 
          g_dbee_m.dbeeunit,g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee011,g_dbee_m.dbeestus, 
          g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,g_dbee_m.dbee007, 
          g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee012,g_dbee_m.dbee013,g_dbee_m.dbeeownid,g_dbee_m.dbeeowndp, 
          g_dbee_m.dbeecrtid,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid,g_dbee_m.dbeemoddt, 
          g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfdt,g_dbee_m.dbee010_desc,g_dbee_m.dbee011_desc,g_dbee_m.dbee004_desc, 
          g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc,g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc, 
          g_dbee_m.l_dbee0091_desc,g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid_desc, 
          g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeemodid_desc,g_dbee_m.dbeecnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_dbee_m.dbeesite,g_dbee_m.dbeesite_desc,g_dbee_m.dbeedocdt,g_dbee_m.dbeeunit, 
          g_dbee_m.dbeedocno,g_dbee_m.dbee001,g_dbee_m.dbee010,g_dbee_m.dbee010_desc,g_dbee_m.dbee011, 
          g_dbee_m.dbee011_desc,g_dbee_m.dbeestus,g_dbee_m.dbee002,g_dbee_m.dbee003,g_dbee_m.dbee004, 
          g_dbee_m.dbee004_desc,g_dbee_m.dbee005,g_dbee_m.dbee005_desc,g_dbee_m.dbee006,g_dbee_m.dbee007, 
          g_dbee_m.dbee007_desc,g_dbee_m.dbee008,g_dbee_m.dbee009,g_dbee_m.dbee009_desc,g_dbee_m.dbee012, 
          g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0071_desc,g_dbee_m.dbee013,g_dbee_m.l_dbee0091,g_dbee_m.l_dbee0091_desc, 
          g_dbee_m.dbeeownid,g_dbee_m.dbeeownid_desc,g_dbee_m.dbeeowndp,g_dbee_m.dbeeowndp_desc,g_dbee_m.dbeecrtid, 
          g_dbee_m.dbeecrtid_desc,g_dbee_m.dbeecrtdp,g_dbee_m.dbeecrtdp_desc,g_dbee_m.dbeecrtdt,g_dbee_m.dbeemodid, 
          g_dbee_m.dbeemodid_desc,g_dbee_m.dbeemoddt,g_dbee_m.dbeecnfid,g_dbee_m.dbeecnfid_desc,g_dbee_m.dbeecnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE adbt701_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL adbt701_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt701.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION adbt701_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_dbef_d.getLength() THEN
         LET g_detail_idx = g_dbef_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_dbef_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_dbef_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbt701_b_fill2(pi_idx)
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
   
   CALL adbt701_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION adbt701_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="adbt701.status_show" >}
PRIVATE FUNCTION adbt701_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adbt701.mask_functions" >}
&include "erp/adb/adbt701_mask.4gl"
 
{</section>}
 
{<section id="adbt701.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION adbt701_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL adbt701_show()
   CALL adbt701_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_adbt701_conf_chk(g_dbee_m.dbeedocno,g_dbee_m.dbeestus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE adbt701_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_dbee_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_dbef_d))
 
 
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
   #CALL adbt701_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL adbt701_ui_headershow()
   CALL adbt701_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION adbt701_draw_out()
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
   CALL adbt701_ui_headershow()  
   CALL adbt701_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="adbt701.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION adbt701_set_pk_array()
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
   LET g_pk_array[1].values = g_dbee_m.dbeedocno
   LET g_pk_array[1].column = 'dbeedocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt701.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="adbt701.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION adbt701_msgcentre_notify(lc_state)
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
   CALL adbt701_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_dbee_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="adbt701.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION adbt701_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#7 -s by 08172
   SELECT dbeestus  INTO g_dbee_m.dbeestus
     FROM dbee_t
    WHERE dbeeent = g_enterprise
      AND dbeedocno = g_dbee_m.dbeedocno
   LET g_errno = ''
   IF (g_action_choice="modify" OR g_action_choice="modify_detail" OR g_action_choice="delete")  THEN
     CASE g_dbee_m.dbeestus
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
        LET g_errparam.extend = g_dbee_m.dbeedocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL adbt701_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#7 -e by 08172
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="adbt701.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭帶值欄位說明
# Memo...........:
# Usage..........: CALL adbt701_dbee_ref()
# Date & Author..: 2014/08/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbee_ref()
   LET g_dbee_m.dbee004_desc = s_desc_get_dbab001_desc(g_dbee_m.dbee004)
   LET g_dbee_m.dbee005_desc = s_desc_get_dbae001_desc(g_dbee_m.dbee005)
   LET g_dbee_m.dbee007_desc = s_desc_get_unit_desc(g_dbee_m.dbee007)
   LET g_dbee_m.dbee009_desc = s_desc_get_unit_desc(g_dbee_m.dbee009)
   LET g_dbee_m.l_dbee0071_desc = s_desc_get_unit_desc(g_dbee_m.l_dbee0071)
   LET g_dbee_m.l_dbee0091_desc = s_desc_get_unit_desc(g_dbee_m.l_dbee0091)
   
   DISPLAY BY NAME g_dbee_m.dbee004_desc,g_dbee_m.dbee005_desc,g_dbee_m.dbee007_desc, 
                   g_dbee_m.dbee009_desc,g_dbee_m.l_dbee0071_desc,g_dbee_m.l_dbee0091_desc
END FUNCTION

################################################################################
# Descriptions...: 單頭依車輛帶值
# Memo...........:
# Usage..........: CALL adbt701_dbee_val()
# Date & Author..: 2014/08/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbee_val()
   
   SELECT dbec002,dbec001,dbeb002,dbeb003,
          dbeb005,dbeb006,dbeb008
     INTO g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,
          g_dbee_m.dbee007,g_dbee_m.dbee008,g_dbee_m.dbee009
     FROM dbec_t,dbeb_t,dbea_t
    WHERE dbecent = dbebent AND dbecdocno = dbebdocno AND dbec001 = dbec001
      AND dbebent = dbeaent AND dbebdocno = dbeadocno
      AND dbeaent = g_enterprise
      AND dbeastus = 'Y'
      AND dbea001 = g_dbee_m.dbee001
      AND dbec003 = g_dbee_m.dbee002
      AND EXISTS(SELECT 1 FROM dbed_t 
                  WHERE dbedent = dbeaent AND dbeddocno = dbeadocno
                    AND dbed001 = g_dbee_m.dbeesite)

   DISPLAY BY NAME g_dbee_m.dbee003,g_dbee_m.dbee004,g_dbee_m.dbee005,g_dbee_m.dbee006,
                   g_dbee_m.dbee007,g_dbee_m.dbee008,g_dbee_m.dbee009
                   
   LET g_dbee_m.l_dbee0071 = g_dbee_m.dbee007
   LET g_dbee_m.l_dbee0091 = g_dbee_m.dbee009   
   DISPLAY BY NAME g_dbee_m.l_dbee0071,g_dbee_m.l_dbee0091   
END FUNCTION

################################################################################
# Descriptions...: 車輛編號校驗
# Memo...........:
# Usage..........: CALL adbt701_dbee002_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/08/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbee002_chk()
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_dbeedocno   LIKE dbee_t.dbeedocno
   
   LET r_success = TRUE
   LET l_dbeedocno = NULL
   
   IF adbt701_dbef_cnt() > 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adb-00297" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success       
   END IF
   
   SELECT dbeedocno INTO l_dbeedocno
     FROM dbee_t
    WHERE dbeeent = g_enterprise
      AND dbeesite = g_dbee_m.dbeesite
      AND dbeedocno <> g_dbee_m.dbeedocno
      AND dbee001 = g_dbee_m.dbee001
      AND dbee002 = g_dbee_m.dbee002
   IF l_dbeedocno IS NOT NULL THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adb-00298" 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.replace[1]  = g_dbee_m.dbee002
      LET g_errparam.replace[2]  = g_dbee_m.dbeesite 
      LET g_errparam.replace[3]  = g_dbee_m.dbee001
      LET g_errparam.replace[4]  = l_dbeedocno 
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN r_success    
   END IF   
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_dbee_m.dbee002
   LET g_chkparam.arg2 = g_dbee_m.dbee001
   LET g_chkparam.arg3 = g_dbee_m.dbeesite
   #160318-00025#23  by 07900 --add-str
   LET g_errshow = TRUE #是否開窗                   
   LET g_chkparam.err_str[1] ="amr-00004:sub-01302|amrm200|",cl_get_progname("amrm200",g_lang,"2"),"|:EXEPROGamrm200"
   #160318-00025#23  by 07900 --add-end 
   IF NOT cl_chk_exist("v_mrba001_10") THEN
      LET r_success = FALSE
      RETURN r_success     
   END IF
   
   RETURN r_success  
END FUNCTION

################################################################################
# Descriptions...: 依排車人員帶出預設部門
# Memo...........:
# Usage..........: CALL adbt701_dbee011_default()
# Date & Author..: 2014/08/27 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbee011_default()
   #帶出歸屬部門ooag003
   SELECT ooag003 INTO g_dbee_m.dbee011
     FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_dbee_m.dbee010
      
   LET g_dbee_m.dbee011_desc = s_desc_get_department_desc(g_dbee_m.dbee011)
   DISPLAY BY NAME g_dbee_m.dbee011,g_dbee_m.dbee011_desc
END FUNCTION

################################################################################
# Descriptions...: 計算配送資訊筆數
# Memo...........:
# Usage..........: CALL adbt701_dbef_cnt()
#                  RETURNING r_cnt
# Return code....: r_cnt   筆數
# Date & Author..: 2014/08/28 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef_cnt()
   DEFINE r_cnt   LIKE type_t.num5
   
   LET r_cnt = 0 
   
   SELECT COUNT(*) INTO r_cnt
     FROM dbef_t 
    WHERE dbefent = g_enterprise
      AND dbefdocno = g_dbee_m.dbeedocno
      
   RETURN r_cnt   
END FUNCTION

################################################################################
# Descriptions...: 根據來源單號和項次校驗與帶值
# Memo...........:
# Usage..........: CALL adbt701_dbef_chk_and_val()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..:2014/08/25 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef_chk_and_val()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_dbef      RECORD
            dbefunit   LIKE dbef_t.dbefunit,   #發貨組織
            dbef003    LIKE dbef_t.dbef003 ,   #出貨日期
            dbef004    LIKE dbef_t.dbef004 ,   #送貨客戶編號
            dbef005    LIKE dbef_t.dbef005 ,   #產品編號
            dbef006    LIKE dbef_t.dbef006 ,   #庫存單位     
            dbef007    LIKE dbef_t.dbef007 ,   #庫存數量
            dbef008    LIKE dbef_t.dbef008 ,   #包裝單位
            dbef009    LIKE dbef_t.dbef009 ,   #包裝數量
            dbef010    LIKE dbef_t.dbef010 ,   #商品條碼
            dbef011    LIKE dbef_t.dbef011 ,   #重量
            dbef012    LIKE dbef_t.dbef012 ,   #體積
            dbef013    LIKE dbef_t.dbef013 ,   #站點
            dbef014    LIKE dbef_t.dbef014 ,   #片區  
            imaa016    LIKE imaa_t.imaa016 ,   #料件毛重
            imaa018    LIKE imaa_t.imaa018 ,   #料件重量單位
            imaa025    LIKE imaa_t.imaa025 ,   #料件體積
            imaa026    LIKE imaa_t.imaa026     #料體積單位
                      END RECORD  
   DEFINE l_sql       STRING   
   DEFINE l_oofb019   LIKE oofb_t.oofb019
   DEFINE l_max_qty   LIKE dbef_t.dbef009
   
   LET r_success = TRUE
   INITIALIZE l_dbef.* TO NULL 
   
   #取來源單據資料
   CASE g_dbef_d[l_ac].dbef000
      WHEN '1'   #出貨單
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = g_dbef_d[l_ac].dbef001
         LET g_chkparam.arg2 = g_dbee_m.dbee003
         LET g_chkparam.arg3 = g_dbee_m.dbee001
         LET g_chkparam.arg4 = g_dbee_m.dbee004
         IF NOT cl_chk_exist("v_dbef001") THEN
            LET r_success = FALSE
            RETURN r_success 
         END IF
         
         IF cl_null(g_dbef_d[l_ac].dbef002) THEN
            RETURN r_success 
         END IF
         
         LET l_sql = "SELECT xmdlsite,xmdkdocdt,xmdk009,xmdl008, ",      #發貨組織,出貨日期,送貨客戶編號,產品編號
                     "       imaa104 ,xmdl204  ,xmdl205, ",              #庫存單位,包裝單位,包裝數量
                     "       (SELECT xmja002 FROM xmja_t ",              #商品條碼
                     "         WHERE xmjaent = xmdlent ",                
                     "           AND xmjadocno = xmdl003 ",              
                     "           AND xmjaseq = xmdl004 ), ",             
                     "       imaa016 ,imaa018  ,imaa025,imaa026, ",      #料件毛重,料件重量單位,料件體積,料件體積單位
                     "       xmdk205 ",                                  #站點
                     " FROM xmdl_t,xmdk_t,imaa_t ",
                     "WHERE xmdlent = xmdkent AND xmdldocno = xmdkdocno ",
                     "  AND xmdlent = imaaent AND xmdl008 = imaa001 ",
                     "  AND xmdlent = ",g_enterprise,
                     "  AND xmdldocno = '",g_dbef_d[l_ac].dbef001,"' ",  #來源單據編號
                     "  AND xmdlseq = ",g_dbef_d[l_ac].dbef002           #來源單據項次 
         PREPARE adbt701_sel_shipping FROM l_sql                         
         EXECUTE adbt701_sel_shipping INTO l_dbef.dbefunit,l_dbef.dbef003,l_dbef.dbef004,l_dbef.dbef005,
                                           l_dbef.dbef006 ,l_dbef.dbef008,l_dbef.dbef009,l_dbef.dbef010,
                                           l_dbef.imaa016 ,l_dbef.imaa018,l_dbef.imaa025,l_dbef.imaa026,
                                           l_dbef.dbef013 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            LET r_success = FALSE
            RETURN r_success       
         END IF  
         
      WHEN '2'   #調撥單                                                  
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = g_dbef_d[l_ac].dbef001
         LET g_chkparam.arg2 = g_dbee_m.dbee003
         LET g_chkparam.arg3 = g_dbee_m.dbee001
         IF NOT cl_chk_exist("v_dbef001_1") THEN
            LET r_success = FALSE
            RETURN r_success 
         END IF
         
         IF cl_null(g_dbef_d[l_ac].dbef002) THEN
            RETURN r_success 
         END IF    
         
         LET l_sql = "SELECT indc005,indcdocdt, ",                       #發貨組織,出貨日期,送貨客戶編號
                     "       (SELECT ooef024 FROM ooef_t ",                
                     "         WHERE ooefent = inddent ",                
                     "           AND ooef001 = indc006), ",               
                     "       indd002,indd006,indd021,indd007, ",         #產品編號,庫存單位,庫存數量,包裝單位
                     "       indd020,indd003, ",                         #包裝數量,商品條碼
                     "       imaa016,imaa018,imaa025,imaa026, ",         #料件毛重,料件重量單位,料件體積,料件體積單位
                     "       (SELECT oofb022 FROM oofb_t,ooef_t ",
                     "         WHERE oofbent = ooefent AND oofb002 = ooef012 ",
                     "           AND ooefent = indcent AND ooef001 = indc006 ",
                     "           AND oofb008 = '3'     AND oofb010 = 'Y') ", #站點
                     "  FROM indd_t,indc_t,imaa_t ",
                     " WHERE inddent = indcent AND indddocno = indcdocno ",
                     "   AND inddent = imaaent AND indd002 = imaa001 ",
                     "   AND inddent = ",g_enterprise,
                     "   AND indddocno = '",g_dbef_d[l_ac].dbef001,"' ", #來源單據編號
                     "   AND inddseq = ",g_dbef_d[l_ac].dbef002          #來源單據項次 
         PREPARE adbt701_sel_invmoving FROM l_sql 
         EXECUTE adbt701_sel_invmoving INTO l_dbef.dbefunit,l_dbef.dbef003,l_dbef.dbef004,
                                            l_dbef.dbef005 ,l_dbef.dbef006,l_dbef.dbef007,l_dbef.dbef008,
                                            l_dbef.dbef009 ,l_dbef.dbef010,
                                            l_dbef.imaa016 ,l_dbef.imaa018,l_dbef.imaa025,l_dbef.imaa026,
                                            l_dbef.dbef013
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            
            LET r_success = FALSE
            RETURN r_success       
         END IF          
         
   END CASE  
        
   LET l_max_qty = adbt701_packing_max_qty(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbefseq,
                                        g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002)
   IF l_dbef.dbef009 > l_max_qty THEN  #ken---mod   <改成>
      LET l_dbef.dbef009 = l_max_qty
   END IF   
   CALL adbt701_qty_convert(l_dbef.dbef005,l_dbef.dbef009,l_dbef.dbef008,l_dbef.dbef006,
                           l_dbef.imaa018,l_dbef.imaa016,l_dbef.imaa026,l_dbef.imaa025)
      RETURNING l_success, l_dbef.dbef007,l_dbef.dbef011,l_dbef.dbef012
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #取片區
   SELECT dbad002 INTO l_dbef.dbef014
     FROM dbad_t
    WHERE dbadent = g_enterprise
      AND dbad001 = l_dbef.dbef013  
   
   #帶值顯示
   LET g_dbef_d[l_ac].dbefunit = l_dbef.dbefunit
   LET g_dbef_d[l_ac].dbef003  = l_dbef.dbef003
   LET g_dbef_d[l_ac].dbef004  = l_dbef.dbef004
   LET g_dbef_d[l_ac].dbef004_desc = s_desc_get_trading_partner_abbr_desc(g_dbef_d[l_ac].dbef004)
   LET g_dbef_d[l_ac].dbef005  = l_dbef.dbef005                             
   LET g_dbef_d[l_ac].dbef006  = l_dbef.dbef006
   LET g_dbef_d[l_ac].dbef007  = l_dbef.dbef007
   LET g_dbef_d[l_ac].dbef008  = l_dbef.dbef008
   LET g_dbef_d[l_ac].dbef009  = l_dbef.dbef009
   LET g_dbef_d[l_ac].dbef010  = l_dbef.dbef010
   LET g_dbef_d[l_ac].dbef011  = l_dbef.dbef011
   LET g_dbef_d[l_ac].dbef012  = l_dbef.dbef012
   LET g_dbef_d[l_ac].dbef013  = l_dbef.dbef013
   LET g_dbef_d[l_ac].dbef013_desc = s_desc_get_dbad001_desc(g_dbef_d[l_ac].dbef013)
   LET g_dbef_d[l_ac].dbef014  = l_dbef.dbef014
   LET g_dbef_d[l_ac].dbef014_desc = s_desc_get_dbad002_desc(g_dbef_d[l_ac].dbef014)
   LET g_dbef_d[l_ac].l_imaa018 = l_dbef.imaa018
   LET g_dbef_d[l_ac].l_imaa026 = l_dbef.imaa026
   
   CALL adbt701_qty_convert_for_sum(l_ac)        #lori522612  150226  add
   
   LET g_dbef_d_o.* = g_dbef_d[l_ac].*
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 單身欄位說明
# Memo...........:
# Usage..........: CALL adbt701_dbef_ref()
# Date & Author..: 2014/08/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef_ref()
   LET g_dbef_d[l_ac].dbefunit_desc  = s_desc_get_department_desc(g_dbef_d[l_ac].dbefunit)                 #組織說明
   LET g_dbef_d[l_ac].dbef004_desc   = s_desc_get_trading_partner_abbr_desc(g_dbef_d[l_ac].dbef004)        #客戶編號
   CALL s_desc_get_item_desc(g_dbef_d[l_ac].dbef005) 
      RETURNING g_dbef_d[l_ac].dbef005_desc,g_dbef_d[l_ac].dbef005_desc_1    #品名,規格
   LET g_dbef_d[l_ac].dbef006_desc   = s_desc_get_unit_desc(g_dbef_d[l_ac].dbef006)
   LET g_dbef_d[l_ac].dbef008_desc   = s_desc_get_unit_desc(g_dbef_d[l_ac].dbef008)
   LET g_dbef_d[l_ac].l_imaa018_desc = s_desc_get_unit_desc(g_dbef_d[l_ac].l_imaa018)
   LET g_dbef_d[l_ac].l_imaa026_desc = s_desc_get_unit_desc(g_dbef_d[l_ac].l_imaa026)
   LET g_dbef_d[l_ac].dbef013_desc   = s_desc_get_dbad001_desc(g_dbef_d[l_ac].dbef013)
   LET g_dbef_d[l_ac].dbef014_desc   = s_desc_get_dbad002_desc(g_dbef_d[l_ac].dbef014)   
END FUNCTION

################################################################################
# Descriptions...: 取料件單位資訊
# Memo...........:
# Usage..........: CALL adbt701_item_ref(p_imaa001)
#                  RETURNING r_imaa018,r_imaa026
# Input parameter: p_imaa001   料件編號
# Return code....: r_imaa018
#                : r_imaa026
# Date & Author..: 2014/08/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_item_ref(p_imaa001)
   DEFINE p_imaa001   LIKE imaa_t.imaa001
   DEFINE r_imaa016   LIKE imaa_t.imaa016
   DEFINE r_imaa018   LIKE imaa_t.imaa018
   DEFINE r_imaa025   LIKE imaa_t.imaa025
   DEFINE r_imaa026   LIKE imaa_t.imaa026
   
   LET r_imaa016 = ''
   LET r_imaa018 = ''
   LET r_imaa025 = ''
   LET r_imaa026 = ''
   
   SELECT imaa016,imaa018,imaa025,imaa026
     INTO r_imaa016,r_imaa018,r_imaa025,r_imaa026
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = p_imaa001

   RETURN r_imaa016,r_imaa018,r_imaa025,r_imaa026
END FUNCTION

################################################################################
# Descriptions...: 依路線站點順序重新規劃卸貨順序
# Memo...........:
# Usage..........: CALL adbt701_replanning_unloading()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/08/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_replanning_unloading()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_dbefdocno LIKE dbef_t.dbefdocno
   DEFINE l_dbefseq   LIKE dbef_t.dbefseq  
   DEFINE l_dbef015   LIKE dbef_t.dbef015  
   DEFINE l_err_cnt   LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   
   IF adbt701_dbef_cnt() <= 1 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = 'adb-00301'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
  
      LET r_success = FALSE
      RETURN r_success      
   END IF


   CALL cl_err_collect_init()
   LET l_sql = "SELECT dbefdocno,dbefseq,ROW_NUMBER() OVER (ORDER BY dbaf004)",       
               "  FROM dbef_t,dbee_t,dbaf_t ",
               " WHERE dbefent = dbeeent AND dbefdocno = dbeedocno ",
               "   AND dbeeent = dbafent AND dbee004 = dbaf001 AND dbef013 = dbaf003 AND dbaf002 = '1' ",
               "   AND dbefent = ",g_enterprise,
               "   AND dbefdocno = '",g_dbee_m.dbeedocno,"' ",
               " ORDER BY dbefseq"
   PREPARE adbt701_replanning_pre FROM l_sql
   DECLARE adbt701_replanning_cur CURSOR FOR adbt701_replanning_pre
   FOREACH adbt701_replanning_cur INTO l_dbefdocno,l_dbefseq,l_dbef015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.extend = "foreach:adbt701_replanning_cur" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
      
         LET l_err_cnt = l_err_cnt + 1
      END IF

     #OPEN adbt701_bcl USING g_enterprise,l_dbefdocno,l_dbefseq     
     #IF SQLCA.sqlcode THEN
     #   INITIALIZE g_errparam TO NULL 
     #   LET g_errparam.extend = "adbt701_bcl" 
     #   LET g_errparam.code   = SQLCA.sqlcode 
     #   LET g_errparam.popup  = FALSE
     #   CALL cl_err()
     #
     #   LET l_err_cnt = l_err_cnt + 1
     #   CONTINUE FOREACH
     #END IF
      
      UPDATE dbef_t
         SET dbef015 = l_dbef015
       WHERE dbefent = g_enterprise
         AND dbefdocno = l_dbefdocno        
         AND dbefseq = l_dbefseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "Update dbef015" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE
         CALL cl_err()
 
         LET l_err_cnt = l_err_cnt + 1
         CONTINUE FOREACH
      END IF
      
      CLOSE adbt701_bcl
   END FOREACH   
   
   CALL cl_err_collect_show()
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   RETURN r_success      
END FUNCTION

################################################################################
# Descriptions...: 依包裝單位數量換算庫存數量,重量,體積
# Memo...........: 使用時機：1.輸入單號/項次後帶值 2.修改包裝數量
# Usage..........: CALL adbt701_qty_convert(p_item,p_packing_qty,p_packing_unit,p_subinv_unit,p_weight_unit,p_wunit_qty,p_volume_unit,p_vunit_qty)
#                  RETURNING r_subinv_qty,r_weight_qty,r_volume_qty
# Input parameter: p_item         料號
#                  p_packing_qty  包裝數量
#                  p_packing_unit 包裝單位
#                  p_subinv_unit  庫存單位
#                  p_weight_unit  重量單位
#                  p_wunit_qty    料件毛重單位數量,可傳空值,由函數中取值
#                  p_volume_unit  體積單位
#                  p_vunit_qty    料件體積單位數量,可傳空值,由函數中取值
# Return code....: r_success      
#                  r_subinv_qty   庫存數量
#                  r_weight_qty   重量
#                  r_volume_qty   體積
# Date & Author..: 2014/09/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_qty_convert(p_item,p_packing_qty,p_packing_unit,p_subinv_unit,p_weight_unit,p_wunit_qty,p_volume_unit,p_vunit_qty)
   DEFINE p_item          LIKE dbef_t.dbef005    #產品編號
   DEFINE p_packing_qty   LIKE dbef_t.dbef009    #包裝數量
   DEFINE p_packing_unit  LIKE dbef_t.dbef008    #包裝單位
   DEFINE p_subinv_unit   LIKE dbef_t.dbef006    #庫存單位  
   DEFINE p_weight_unit   LIKE imaa_t.imaa018    #料件重量單位
   DEFINE p_wunit_qty     LIKE imaa_t.imaa016    #料件毛重
   DEFINE p_volume_unit   LIKE imaa_t.imaa026    #料體積單位   
   DEFINE p_vunit_qty     LIKE imaa_t.imaa025    #料件體積    
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_subinv_qty    LIKE dbef_t.dbef007    #庫存數量
   DEFINE r_weight_qty    LIKE dbef_t.dbef011    #重量
   DEFINE r_volume_qty    LIKE dbef_t.dbef012    #體積
  #DEFINE l_volume_rate   LIKE type_t.num20_6    #sakura mark
  #DEFINE l_weight_rate   LIKE type_t.num20_6    #sakura mark
   DEFINE l_volume_qty    LIKE dbef_t.dbef011    #sakura add
   DEFINE l_weight_qty    LIKE dbef_t.dbef012    #sakura add  
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_imaa016       LIKE imaa_t.imaa016    #毛重
   DEFINE l_imaa018       LIKE imaa_t.imaa018
   DEFINE l_imaa025       LIKE imaa_t.imaa025    #體積
   DEFINE l_imaa026       LIKE imaa_t.imaa026
   
   LET r_success = TRUE
   LET r_subinv_qty  = 0
   LET r_weight_qty  = 0
   LET r_volume_qty  = 0
  #LET l_volume_rate = 0 #sakura mark
  #LET l_weight_rate = 0 #sakura mark
   LET l_imaa016 = ''
   LET l_imaa018 = ''
   LET l_imaa025 = ''
   LET l_imaa026 = ''
   LET l_volume_qty = 0 #sakura add
   LET l_weight_qty = 0 #sakura add  

   CALL adbt701_item_ref(p_item) RETURNING l_imaa016,l_imaa018,l_imaa025,l_imaa026
   IF NOT cl_null(p_wunit_qty) THEN
      LET l_imaa016 = p_wunit_qty
   END IF
   IF NOT cl_null(p_vunit_qty) THEN
      LET l_imaa025 = p_vunit_qty
   END IF
   
   IF cl_null(l_imaa016) THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = 'sub-00654'
      LET g_errparam.extend = p_item
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      RETURN r_success,r_subinv_qty,r_weight_qty,r_volume_qty
   END IF
   
   IF cl_null(l_imaa025) THEN
      LET r_success = FALSE
      
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = 'sub-00655'
      LET g_errparam.extend = p_item
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success,r_subinv_qty,r_weight_qty,r_volume_qty
   END IF   
   
   LET l_success = ''
   IF NOT cl_null(p_subinv_unit) THEN
      #包裝單位數量換成庫存單位數量
      CALL s_aooi250_convert_qty(p_item,p_packing_unit,p_subinv_unit,p_packing_qty) RETURNING l_success,r_subinv_qty
   
      IF NOT cl_null(p_weight_unit) OR NOT cl_null(l_imaa018) OR NOT cl_null(l_imaa016) THEN
         #重量 = 庫存單位數量 * 料件毛重 * 料件毛重單位與參數重量單位換算率
         LET l_success = ''
        #141224-00013#15---sakura---mod---str 
        #CALL s_aimi190_get_convert(p_item,p_weight_unit,g_weight_para) RETURNING l_success,l_weight_rate
         CALL s_aooi250_convert_qty(p_item,p_weight_unit,g_weight_para,l_imaa016) RETURNING l_success,l_weight_qty
         IF l_success THEN
           #LET r_weight_qty = r_subinv_qty * l_imaa016 * l_weight_rate
            LET r_weight_qty = r_subinv_qty * l_weight_qty
         END IF
        #141224-00013#15---sakura---mod---end         
      END IF

      IF NOT cl_null(p_volume_unit) OR NOT cl_null(l_imaa026) OR NOT cl_null(l_imaa025) THEN
         #體積 = 庫存單位數量 * 料件體積單位數量 * 料件體積單位與參數容積單位換算率
         LET l_success = ''
        #141224-00013#15---sakura---mod---str  
        #CALL s_aimi190_get_convert(p_item,p_volume_unit,g_volume_para) RETURNING l_success,l_volume_rate
         CALL s_aooi250_convert_qty(p_item,p_volume_unit,g_volume_para,l_imaa025) RETURNING l_success,l_volume_qty
         IF l_success THEN
           #LET r_volume_qty = r_subinv_qty * l_imaa025 * l_volume_rate
            LET r_volume_qty = r_subinv_qty * l_volume_qty
         END IF
        #141224-00013#15---sakura---mod---end 
      END IF
   END IF  
   
   RETURN r_success,r_subinv_qty,r_weight_qty,r_volume_qty
END FUNCTION

################################################################################
# Descriptions...: 包裝數量校驗
# Memo...........:
# Usage..........: CALL adbt701_dbef009_chk()
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef009_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_max_qty   LIKE dbef_t.dbef009
   
   LET r_success = TRUE
   LET l_max_qty = adbt701_packing_max_qty(g_dbee_m.dbeedocno,g_dbef_d[l_ac].dbefseq,
                                           g_dbef_d[l_ac].dbef000,g_dbef_d[l_ac].dbef001,g_dbef_d[l_ac].dbef002)
   
   IF g_dbef_d[l_ac].dbef009 > l_max_qty THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = 'adb-00351'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      LET r_success = FALSE      
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 卸貨順序校驗
# Memo...........: 同單據同站點不可重複
# Usage..........: CALL adbt701_dbef015_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/09/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef015_chk()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt
     FROM dbef_t
    WHERE dbefent = g_enterprise
      AND dbefdocno = g_dbee_m.dbeedocno
      AND dbef013 <> g_dbef_d[l_ac].dbef013
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = 'adb-00350'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 最大可配送的包裝數量
# Memo...........:
# Usage..........: CALL adbt701_packing_max_qty(p_dbefdocno,p_dbefseq,p_dbef000,p_dbef001,p_dbef002)
#                  RETURNING r_max_qty
# Input parameter: p_dbefdocno    排車單號
#                  p_dbefseq      排車項次
#                  p_dbef000      來源類型
#                  p_dbef001      來源單號
#                  p_dbef002      來源單項次
# Return code....: r_max_qty      最大可配送的包裝數量
# Date & Author..: 2014/09/29 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_packing_max_qty(p_dbefdocno,p_dbefseq,p_dbef000,p_dbef001,p_dbef002)
   DEFINE p_dbefdocno      LIKE dbef_t.dbefdocno   #排車單號
   DEFINE p_dbefseq        LIKE dbef_t.dbefseq     #排車項次
   DEFINE p_dbef000        LIKE dbef_t.dbef000     #來源類型
   DEFINE p_dbef001        LIKE dbef_t.dbef001     #來源單號
   DEFINE p_dbef002        LIKE dbef_t.dbef002     #來源單項次   
   DEFINE r_max_qty        LIKE dbef_t.dbef009
   DEFINE l_sour_qty       LIKE dbef_t.dbef009    #來源單據的出貨包裝數量
   DEFINE l_delivery_qty   LIKE dbef_t.dbef009    #已排配送的包裝數量
   
   LET r_max_qty      = 0 
   LET l_sour_qty     = 0
   LET l_delivery_qty = 0
   
   SELECT SUM(COALESCE(dbef009,0)) INTO l_delivery_qty
     FROM dbef_t,dbee_t
    WHERE dbefent = dbeeent
      AND dbefdocno = dbeedocno
      AND dbefent = g_enterprise
      AND dbef001 = p_dbef001
      AND dbef002 = p_dbef002
      AND dbeestus <> 'X'
      AND NOT ( dbefdocno = p_dbefdocno
                AND dbefseq = p_dbefseq)
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      RETURN r_max_qty
   END IF

   CASE g_dbef_d[l_ac].dbef000
      WHEN '1'   #出貨單
         SELECT SUM(xmdl205) INTO l_sour_qty
           FROM xmdl_t
          WHERE xmdlent = g_enterprise
            AND xmdldocno = p_dbef001
            AND xmdlseq = p_dbef002            
      WHEN '2'   #調撥單
         SELECT SUM(indd020) INTO l_sour_qty
           FROM indd_t
          WHERE inddent = g_enterprise
            AND indddocno = p_dbef001
            AND inddseq = p_dbef002       
   END CASE

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()

      RETURN r_max_qty
   END IF
   IF cl_null(l_delivery_qty) THEN
      LET l_delivery_qty = 0
   END IF
   LET r_max_qty = l_sour_qty - l_delivery_qty
   
   RETURN r_max_qty
END FUNCTION

################################################################################
# Descriptions...: 更新配送牌車單單頭的總重量/體積數
# Memo...........:
# Usage..........: CALL adbt701_upd_dbee()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/09/30 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_upd_dbee()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_dbee012   LIKE dbee_t.dbee012
   DEFINE l_dbee013   LIKE dbee_t.dbee013
   
   LET r_success = TRUE
   LET l_dbee012 = 0
   LET l_dbee013 = 0
   
   OPEN adbt701_cl USING g_enterprise,g_dbee_m.dbeedocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN adbt701_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE adbt701_cl
      LET r_success = FALSE
      
      RETURN r_success
   END IF
   #140513-00002#7 by benson --- S
   #IF g_dbef_d[l_ac].dbefseq = 1 THEN
   #   LET l_dbee012 = g_dbef_d[l_ac].dbef012
   #   LET l_dbee013 = g_dbef_d[l_ac].dbef011   
   #ELSE
   #   SELECT SUM(COALESCE(dbef012,0)),SUM(COALESCE(dbef011,0))  
   #     INTO l_dbee012,l_dbee013
   #     FROM dbef_t 
   #    WHERE dbefent = g_enterprise 
   #      AND dbefdocno = g_dbee_m.dbeedocno
   #      AND dbefseq <> g_dbef_d[l_ac].dbefseq
   #   
   #   LET l_dbee012 = l_dbee012 + g_dbef_d[l_ac].dbef012
   #   LET l_dbee013 = l_dbee013 + g_dbef_d[l_ac].dbef011
   #END IF
   
   #lori522612  150226  add ----------------------(S)
   #LET l_dbee012 = 0
   #LET l_dbee013 = 0
   #SELECT SUM(COALESCE(dbef012,0)),SUM(COALESCE(dbef011,0))  
   #  INTO l_dbee012,l_dbee013
   #  FROM dbef_t 
   # WHERE dbefent = g_enterprise 
   #   AND dbefdocno = g_dbee_m.dbeedocno
   CALL adbt701_get_amount() RETURNING l_dbee012,l_dbee013
   #lori522612  150226  add ----------------------(E)
   IF cl_null(l_dbee012) THEN
      LET l_dbee012 = 0
   END IF
   
   IF cl_null(l_dbee013) THEN
      LET l_dbee013 = 0
   END IF
   #140513-00002#7 by benson --- E
   
   UPDATE dbee_t
      SET dbee012 = l_dbee012,
          dbee013 = l_dbee013
    WHERE dbeeent = g_enterprise
      AND dbeedocno = g_dbee_m.dbeedocno   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "Update dbee12,dbee11" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
   END IF   

   LET g_dbee_m.dbee012 = l_dbee012
   LET g_dbee_m.dbee013 = l_dbee013
   DISPLAY BY NAME g_dbee_m.dbee012,g_dbee_m.dbee013
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查排車容積/重量有無超過
# Memo...........: 單身每筆資料輸入完&DB正式異動前檢查
# Usage..........: CALL adbt701_qty_chk()
#                  RETURNING r_success
# Return code....: r_success
# Date & Author..: 2014/09/30 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_qty_chk()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_volume_qty   LIKE dbee_t.dbee012
   DEFINE l_weight_qty   LIKE dbee_t.dbee011
   
   LET r_success = TRUE
   LET l_volume_qty = 0
   LET l_weight_qty = 0
   
   #lori522612  150226  add ----------------------(S)
   #SELECT SUM(COALESCE(dbef012,0)),SUM(COALESCE(dbef011,0))
   #  INTO l_volume_qty,l_weight_qty
   #  FROM dbef_t
   # WHERE dbefent = g_enterprise
   #   AND dbefdocno = g_dbee_m.dbeedocno
   #   AND dbefseq <> g_dbef_d[l_ac].dbefseq
   #
   #IF cl_null(l_volume_qty) THEN   LET l_volume_qty = 0    END IF
   #IF cl_null(l_weight_qty) THEN   LET l_weight_qty = 0    END IF
   #
   #LET l_volume_qty = l_volume_qty + g_dbef_d[l_ac].dbef012
   #LET l_weight_qty = l_weight_qty + g_dbef_d[l_ac].dbef011
   
   CALL adbt701_get_amount() RETURNING l_volume_qty,l_weight_qty
   IF cl_null(l_volume_qty) THEN   LET l_volume_qty = 0    END IF
   IF cl_null(l_weight_qty) THEN   LET l_weight_qty = 0    END IF
   #lori522612  150226  add ----------------------(E)
   
   #ken---add---S
   CASE 
      WHEN (g_volume_para1 = '2' AND g_dbee_m.dbee006 < l_volume_qty) AND
           (g_weight_para1 = '2' AND g_dbee_m.dbee008 < l_weight_qty)
           #錯誤：容積&重量不可超過, 用 cl_err
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.code   = 'adb-00416'
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success           
      WHEN (g_volume_para1 = '2' AND g_dbee_m.dbee006 < l_volume_qty) AND
            g_weight_para1 = '1' 
           #錯誤：容積不可超過, 用 cl_err
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.code   = 'adb-00352'
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           LET r_success = FALSE
           RETURN r_success
      WHEN (g_volume_para1 = '1' AND g_dbee_m.dbee006 >= l_volume_qty) AND
            g_weight_para1 = '2' 
           #錯誤：重量不可超過, 用 cl_err
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.code   = 'adb-00353'
           LET g_errparam.popup  = TRUE 
           CALL cl_err()     
           LET r_success = FALSE  
           RETURN r_success           
      WHEN (g_volume_para1 = '1' AND g_dbee_m.dbee006 < l_volume_qty) AND
           (g_weight_para1 = '1' AND g_dbee_m.dbee008 < l_weight_qty)
           #警告：容積&重量已超過, 用 cl_ask_confirm
           CALL cl_ask_pressanykey('adb-00417') 
      WHEN (g_volume_para1 = '1' AND g_dbee_m.dbee006 < l_volume_qty) AND
           (g_weight_para1 = '1' AND g_dbee_m.dbee008 >= l_weight_qty)
           #警告：容積已超過, 用 cl_ask_confirm
           CALL cl_ask_pressanykey('adb-00354') 
      WHEN (g_volume_para1 = '1' AND g_dbee_m.dbee006 >= l_volume_qty) AND
           (g_weight_para1 = '1' AND g_dbee_m.dbee008 < l_weight_qty)
           #警告：重量已超過, 用 cl_ask_confirm
           CALL cl_ask_pressanykey('adb-00355')
   END CASE
   #ken---add---E
   
   
   #IF g_dbee_m.dbee006 < l_volume_qty THEN
   #   CASE g_volume_para1 
   #      WHEN '1'   #警告
   #         IF NOT cl_ask_confirm('adb-00354') THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF
   #      WHEN '2'   #拒絕
   #         INITIALIZE g_errparam TO NULL 
   #         LET g_errparam.code   = 'adb-00352'
   #         LET g_errparam.popup  = TRUE 
   #         CALL cl_err()
   #
   #         LET r_success = FALSE
   #         RETURN r_success
   #   END CASE   
   #END IF
   #
   #IF g_dbee_m.dbee008 < l_weight_qty THEN
   #   CASE g_weight_para1 
   #      WHEN '1'   #警告
   #         IF NOT cl_ask_confirm('adb-00355') THEN
   #            LET r_success = FALSE
   #            RETURN r_success
   #         END IF
   #      WHEN '2'   #拒絕
   #         INITIALIZE g_errparam TO NULL 
   #         LET g_errparam.code   = 'adb-00353'
   #         LET g_errparam.popup  = TRUE 
   #         CALL cl_err()
   #
   #         LET r_success = FALSE  
   #         RETURN r_success
   #   END CASE
   #END IF
   
   RETURN r_success
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
PRIVATE FUNCTION adbt701_dbee001_chk()
   DEFINE r_success              LIKE type_t.num5
   DEFINE l_colname_1            STRING
   DEFINE l_comment_1            STRING
   
   LET r_success = TRUE
   
   CALL s_azzi902_get_gzzd("adbt701","lbl_dbee001") RETURNING l_colname_1, l_comment_1
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = g_dbee_m.dbee001
   LET g_chkparam.arg2 = g_dbee_m.dbeesite
   LET g_chkparam.err_str[1] = "adb-00387|",l_colname_1,"|",g_dbee_m.dbee001
   LET g_chkparam.err_str[2] = "adb-00413|",l_colname_1,"|",g_dbee_m.dbee001
   IF NOT cl_chk_exist("v_dbea001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查同一張配送派車單中是否有重覆的來源單號+項次
# Memo...........:
# Usage..........: CALL adbt701_dbef001_chk(p_dbefdocno,p_dbef000,p_dbef001,p_dbef002)
#                  RETURNING r_success
# Input parameter: p_dbefdocno 配送派車單號
#                : p_dbef000   來源類型
#                : p_dbef001   來源單號
#                : p_dbef002   來源項次
# Return code....: r_success
# Date & Author..: 2015-02-24 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_dbef001_chk(p_dbefdocno,p_dbef000,p_dbef001,p_dbef002)
DEFINE p_dbefdocno    LIKE dbef_t.dbefdocno
DEFINE p_dbef000      LIKE dbef_t.dbef000
DEFINE p_dbef001      LIKE dbef_t.dbef001
DEFINE p_dbef002      LIKE dbef_t.dbef002
DEFINE r_success      LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5

   LET r_success = TRUE
   
   SELECT COUNT(*) INTO l_n 
     FROM dbef_t,dbee_t
    WHERE dbefent = dbeeent
      AND dbefdocno = dbeedocno
      AND dbeestus != 'X'
      AND dbefent = g_enterprise 
      AND dbefdocno = p_dbefdocno
      AND dbef000 = p_dbef000 
      AND dbef001 = p_dbef001 
      AND dbef002 = p_dbef002 
          
   IF l_n > 0 THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "adb-00414" 
      LET g_errparam.popup  = TRUE 
      LET g_errparam.replace[1]  = p_dbef001
      LET g_errparam.replace[2]  = p_dbef002
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 計算已排容積與重量
# Memo...........:
# Usage..........: CALL adbt701_get_amount()
#                  RETURNING r_dbee012,r_dbee013
# Return code....: r_dbee012    已排容積
#                : r_dbee013    已排重量
# Date & Author..: 2015/02/26 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_get_amount()
   DEFINE r_dbee012   LIKE dbee_t.dbee012
   DEFINE r_dbee013   LIKE dbee_t.dbee013   
   DEFINE l_i         LIKE type_t.num5
   
   LET r_dbee012 = 0
   LET r_dbee013 = 0
   
   FOR l_i = 1 TO g_dbef_d.getLength()
      IF cl_null(g_dbef_d[l_i].l_dbee012) OR cl_null(g_dbef_d[l_i].l_dbee013) THEN
         CALL adbt701_qty_convert_for_sum(l_i)
      END IF
      
      LET r_dbee012 = r_dbee012 + g_dbef_d[l_i].l_dbee012
      LET r_dbee013 = r_dbee013 + g_dbef_d[l_i].l_dbee013
      
   END FOR
   
   RETURN r_dbee012,r_dbee013
END FUNCTION

################################################################################
# Descriptions...: 依庫存重量,體積換算車輛乘載的重量與體積
# Memo...........: 使用時機：1.輸入單號/項次後帶值 2.修改包裝數量/數量 3.加總已排車數量
# Usage..........: CALL adbt701_qty_convert_for_sum(p_idx)
# Input parameter: p_idx          單身指標
# Date & Author..: 2015/02/26 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adbt701_qty_convert_for_sum(p_idx)
   DEFINE p_idx          LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   
   IF p_idx > 0 THEN
      #體積
      IF g_dbef_d[p_idx].l_imaa026 = g_dbee_m.dbee007 THEN
         LET g_dbef_d[p_idx].l_dbee012 = g_dbef_d[p_idx].dbef012
      ELSE
         IF NOT cl_null(g_dbef_d[p_idx].dbef005) AND NOT cl_null(g_dbee_m.dbee007)
            AND NOT cl_null(g_dbef_d[p_idx].l_imaa026) AND g_dbef_d[p_idx].dbef012 > 0 THEN
            LET l_success = ''
            CALL s_aooi250_convert_qty(g_dbef_d[p_idx].dbef005,g_dbef_d[p_idx].l_imaa026,g_dbee_m.dbee007,g_dbef_d[p_idx].dbef012) 
               RETURNING l_success,g_dbef_d[p_idx].l_dbee012
            IF NOT l_success THEN
               LET g_dbef_d[p_idx].l_dbee012 = 0
            END IF
         END IF            
      END IF
      
      #重量
      IF g_dbef_d[p_idx].l_imaa018 = g_dbee_m.dbee009 THEN
         LET g_dbef_d[p_idx].l_dbee013 = g_dbef_d[p_idx].dbef011
      ELSE
         IF NOT cl_null(g_dbef_d[p_idx].dbef005) AND NOT cl_null(g_dbee_m.dbee009)
            AND NOT cl_null(g_dbef_d[p_idx].l_imaa018) AND g_dbef_d[p_idx].dbef011 > 0 THEN
            LET l_success = ''
            CALL s_aooi250_convert_qty(g_dbef_d[p_idx].dbef005,g_dbef_d[p_idx].l_imaa018,g_dbee_m.dbee009,g_dbef_d[p_idx].dbef011) 
               RETURNING l_success,g_dbef_d[p_idx].l_dbee013
            IF NOT l_success THEN
               LET g_dbef_d[p_idx].l_dbee013 = 0
            END IF
         END IF      
      END IF      
   END IF

   IF cl_null(g_dbef_d[p_idx].l_dbee012) THEN
      LET g_dbef_d[p_idx].l_dbee012 = 0
   END IF
   
   IF cl_null(g_dbef_d[p_idx].l_dbee013) THEN
      LET g_dbef_d[p_idx].l_dbee013 = 0
   END IF

END FUNCTION

 
{</section>}
 
