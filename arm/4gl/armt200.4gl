#該程式未解開Section, 採用最新樣板產出!
{<section id="armt200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-02-22 16:37:02), PR版次:0005(2016-08-30 10:55:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: armt200
#+ Description: RMA報價作業
#+ Creator....: 01534(2015-05-11 14:12:55)
#+ Modifier...: 05423 -SD/PR- 01534
 
{</section>}
 
{<section id="armt200.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151118-00012#1   2015/11/19  By shiun    新增s_axmt540_get_exchange傳入參數
#151224-00025#3   2015/12/24  By fionchen 產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160202-00019#2   2016/02/22  BY zhujing  rmbb单身增加单价、未税金额栏位,原总金额变成含税金额，另外添加关联显示栏位增加序号、生产日期、有效日期
#160314-00009#16  2016/03/28  By xujing   产品特征自动开窗增加参数判断
#160318-00025#33  2016/04/13  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160705-00042#12  2016/07/15  By 02159    把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#160812-00017#1   16/08/15 By 06137    在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#33  16/08/25  By lixh    单据类作业修改，删除时需重新检查状态

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
PRIVATE type type_g_rmba_m        RECORD
       rmbadocno LIKE rmba_t.rmbadocno, 
   rmbadocdt LIKE rmba_t.rmbadocdt, 
   rmba002 LIKE rmba_t.rmba002, 
   rmba002_desc LIKE type_t.chr80, 
   rmba000 LIKE rmba_t.rmba000, 
   rmba001 LIKE rmba_t.rmba001, 
   rmba001_desc LIKE type_t.chr80, 
   rmba003 LIKE rmba_t.rmba003, 
   rmba003_desc LIKE type_t.chr80, 
   rmbasite LIKE rmba_t.rmbasite, 
   rmbastus LIKE rmba_t.rmbastus, 
   rmba004 LIKE rmba_t.rmba004, 
   rmba004_desc LIKE type_t.chr80, 
   rmba005 LIKE rmba_t.rmba005, 
   rmba005_desc LIKE type_t.chr80, 
   rmba006 LIKE rmba_t.rmba006, 
   rmba006_desc LIKE type_t.chr80, 
   rmba007 LIKE rmba_t.rmba007, 
   rmba008 LIKE rmba_t.rmba008, 
   rmba009 LIKE rmba_t.rmba009, 
   rmba009_desc LIKE type_t.chr80, 
   rmba010 LIKE rmba_t.rmba010, 
   rmba010_desc LIKE type_t.chr80, 
   rmba013 LIKE rmba_t.rmba013, 
   rmba011 LIKE rmba_t.rmba011, 
   rmba012 LIKE rmba_t.rmba012, 
   rmbaownid LIKE rmba_t.rmbaownid, 
   rmbaownid_desc LIKE type_t.chr80, 
   rmbaowndp LIKE rmba_t.rmbaowndp, 
   rmbaowndp_desc LIKE type_t.chr80, 
   rmbacrtid LIKE rmba_t.rmbacrtid, 
   rmbacrtid_desc LIKE type_t.chr80, 
   rmbacrtdp LIKE rmba_t.rmbacrtdp, 
   rmbacrtdp_desc LIKE type_t.chr80, 
   rmbacrtdt LIKE rmba_t.rmbacrtdt, 
   rmbamodid LIKE rmba_t.rmbamodid, 
   rmbamodid_desc LIKE type_t.chr80, 
   rmbamoddt LIKE rmba_t.rmbamoddt, 
   rmbacnfid LIKE rmba_t.rmbacnfid, 
   rmbacnfid_desc LIKE type_t.chr80, 
   rmbacnfdt LIKE rmba_t.rmbacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_rmbb_d        RECORD
       rmbbsite LIKE rmbb_t.rmbbsite, 
   rmbbseq LIKE rmbb_t.rmbbseq, 
   rmab018 LIKE type_t.chr30, 
   rmab019 LIKE type_t.dat, 
   rmab020 LIKE type_t.dat, 
   rmab009 LIKE type_t.chr500, 
   rmab009_desc LIKE type_t.chr500, 
   rmab009_desc_desc LIKE type_t.chr500, 
   rmab010 LIKE type_t.chr500, 
   rmab010_desc LIKE type_t.chr500, 
   rmab011 LIKE type_t.chr10, 
   rmab011_desc LIKE type_t.chr500, 
   rmab012 LIKE type_t.num20_6, 
   rmab013 LIKE type_t.num20_6, 
   rmab017 LIKE type_t.chr500, 
   rmbb003 LIKE rmbb_t.rmbb003, 
   rmbb001 LIKE rmbb_t.rmbb001, 
   rmbb002 LIKE rmbb_t.rmbb002, 
   srmbb002 LIKE type_t.num20_6, 
   rmbb004 LIKE rmbb_t.rmbb004, 
   rmbb005 LIKE rmbb_t.rmbb005
       END RECORD
PRIVATE TYPE type_g_rmbb2_d RECORD
       rmbcsite LIKE rmbc_t.rmbcsite, 
   rmbcseq1 LIKE rmbc_t.rmbcseq1, 
   rmbc001 LIKE rmbc_t.rmbc001, 
   rmbc001_desc LIKE type_t.chr500, 
   rmbc001_desc_desc LIKE type_t.chr500, 
   rmbc002 LIKE rmbc_t.rmbc002, 
   rmbc002_desc LIKE type_t.chr500, 
   rmbc003 LIKE rmbc_t.rmbc003, 
   rmbc003_desc LIKE type_t.chr500, 
   rmbc004 LIKE rmbc_t.rmbc004, 
   rmbc005 LIKE rmbc_t.rmbc005, 
   rmbc006 LIKE rmbc_t.rmbc006, 
   rmbc008 LIKE rmbc_t.rmbc008, 
   rmbc007 LIKE rmbc_t.rmbc007
       END RECORD
PRIVATE TYPE type_g_rmbb3_d RECORD
       rmbdsite LIKE rmbd_t.rmbdsite, 
   rmbdseq1 LIKE rmbd_t.rmbdseq1, 
   rmbd001 LIKE rmbd_t.rmbd001, 
   rmbd001_desc LIKE type_t.chr500, 
   rmbd002 LIKE rmbd_t.rmbd002, 
   rmbd003 LIKE rmbd_t.rmbd003, 
   rmbd004 LIKE rmbd_t.rmbd004, 
   rmbd006 LIKE rmbd_t.rmbd006, 
   rmbd005 LIKE rmbd_t.rmbd005
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_rmbadocno LIKE rmba_t.rmbadocno,
      b_rmba000 LIKE rmba_t.rmba000,
      b_rmbadocdt LIKE rmba_t.rmbadocdt,
      b_rmba001 LIKE rmba_t.rmba001,
   b_rmba001_desc LIKE type_t.chr80,
      b_rmba002 LIKE rmba_t.rmba002,
   b_rmba002_desc LIKE type_t.chr80,
      b_rmba003 LIKE rmba_t.rmba003,
   b_rmba003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE  l_ooef019   LIKE ooef_t.ooef019
DEFINE   g_acc      LIKE gzcb_t.gzcb004
#end add-point
       
#模組變數(Module Variables)
DEFINE g_rmba_m          type_g_rmba_m
DEFINE g_rmba_m_t        type_g_rmba_m
DEFINE g_rmba_m_o        type_g_rmba_m
DEFINE g_rmba_m_mask_o   type_g_rmba_m #轉換遮罩前資料
DEFINE g_rmba_m_mask_n   type_g_rmba_m #轉換遮罩後資料
 
   DEFINE g_rmbadocno_t LIKE rmba_t.rmbadocno
DEFINE g_rmba000_t LIKE rmba_t.rmba000
 
 
DEFINE g_rmbb_d          DYNAMIC ARRAY OF type_g_rmbb_d
DEFINE g_rmbb_d_t        type_g_rmbb_d
DEFINE g_rmbb_d_o        type_g_rmbb_d
DEFINE g_rmbb_d_mask_o   DYNAMIC ARRAY OF type_g_rmbb_d #轉換遮罩前資料
DEFINE g_rmbb_d_mask_n   DYNAMIC ARRAY OF type_g_rmbb_d #轉換遮罩後資料
DEFINE g_rmbb2_d          DYNAMIC ARRAY OF type_g_rmbb2_d
DEFINE g_rmbb2_d_t        type_g_rmbb2_d
DEFINE g_rmbb2_d_o        type_g_rmbb2_d
DEFINE g_rmbb2_d_mask_o   DYNAMIC ARRAY OF type_g_rmbb2_d #轉換遮罩前資料
DEFINE g_rmbb2_d_mask_n   DYNAMIC ARRAY OF type_g_rmbb2_d #轉換遮罩後資料
DEFINE g_rmbb3_d          DYNAMIC ARRAY OF type_g_rmbb3_d
DEFINE g_rmbb3_d_t        type_g_rmbb3_d
DEFINE g_rmbb3_d_o        type_g_rmbb3_d
DEFINE g_rmbb3_d_mask_o   DYNAMIC ARRAY OF type_g_rmbb3_d #轉換遮罩前資料
DEFINE g_rmbb3_d_mask_n   DYNAMIC ARRAY OF type_g_rmbb3_d #轉換遮罩後資料
 
 
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
 
{<section id="armt200.main" >}
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
   CALL cl_ap_init("arm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT rmbadocno,rmbadocdt,rmba002,'',rmba000,rmba001,'',rmba003,'',rmbasite, 
       rmbastus,rmba004,'',rmba005,'',rmba006,'',rmba007,rmba008,rmba009,'',rmba010,'',rmba013,rmba011, 
       rmba012,rmbaownid,'',rmbaowndp,'',rmbacrtid,'',rmbacrtdp,'',rmbacrtdt,rmbamodid,'',rmbamoddt, 
       rmbacnfid,'',rmbacnfdt", 
                      " FROM rmba_t",
                      " WHERE rmbaent= ? AND rmbadocno=? AND rmba000=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.rmbadocno,t0.rmbadocdt,t0.rmba002,t0.rmba000,t0.rmba001,t0.rmba003, 
       t0.rmbasite,t0.rmbastus,t0.rmba004,t0.rmba005,t0.rmba006,t0.rmba007,t0.rmba008,t0.rmba009,t0.rmba010, 
       t0.rmba013,t0.rmba011,t0.rmba012,t0.rmbaownid,t0.rmbaowndp,t0.rmbacrtid,t0.rmbacrtdp,t0.rmbacrtdt, 
       t0.rmbamodid,t0.rmbamoddt,t0.rmbacnfid,t0.rmbacnfdt,t1.ooag011 ,t2.pmaal003 ,t3.ooefl003 ,t4.ooibl004 , 
       t5.oocql004 ,t6.ooail003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011", 
 
               " FROM rmba_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.rmba002  ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.rmba001 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rmba003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t4 ON t4.ooiblent="||g_enterprise||" AND t4.ooibl002=t0.rmba004 AND t4.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='238' AND t5.oocql002=t0.rmba005 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t6 ON t6.ooailent="||g_enterprise||" AND t6.ooail001=t0.rmba010 AND t6.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.rmbaownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.rmbaowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.rmbacrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.rmbacrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.rmbamodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.rmbacnfid  ",
 
               " WHERE t0.rmbaent = " ||g_enterprise|| " AND t0.rmbadocno = ? AND t0.rmba000 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE armt200_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_armt200 WITH FORM cl_ap_formpath("arm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL armt200_init()   
 
      #進入選單 Menu (="N")
      CALL armt200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_armt200
      
   END IF 
   
   CLOSE armt200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="armt200.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION armt200_init()
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
      CALL cl_set_combo_scc_part('rmbastus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('rmba012','2084')
   CALL cl_set_combo_scc('rmba013','2085')
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'armt200'                            #160705-00042#12 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#12 160715 by sakura add
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN   
      CALL cl_set_comp_visible("rmbc002,rmbc002_desc",FALSE)
   END IF  
   LET g_errshow = 1
   #end add-point
   
   #初始化搜尋條件
   CALL armt200_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="armt200.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION armt200_ui_dialog()
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
            CALL armt200_insert()
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
         INITIALIZE g_rmba_m.* TO NULL
         CALL g_rmbb_d.clear()
         CALL g_rmbb2_d.clear()
         CALL g_rmbb3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL armt200_init()
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
               
               CALL armt200_fetch('') # reload data
               LET l_ac = 1
               CALL armt200_ui_detailshow() #Setting the current row 
         
               CALL armt200_idx_chk()
               #NEXT FIELD rmbbseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_rmbb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt200_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL armt200_b_fill2('2')
CALL armt200_b_fill2('3')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
                  LET g_detail_idx = 1
               END IF
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
               CALL armt200_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
                  LET g_detail_idx = 1
               END IF
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_rmbb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL armt200_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第二階單身段落
         DISPLAY ARRAY g_rmbb3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL armt200_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL armt200_idx_chk()
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
            CALL armt200_browser_fill("")
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
               CALL armt200_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL armt200_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL armt200_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL armt200_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL armt200_set_act_visible()   
            CALL armt200_set_act_no_visible()
            IF NOT (g_rmba_m.rmbadocno IS NULL
              OR g_rmba_m.rmba000 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " rmbaent = " ||g_enterprise|| " AND",
                                  " rmbadocno = '", g_rmba_m.rmbadocno, "' "
                                  ," AND rmba000 = '", g_rmba_m.rmba000, "' "
 
               #填到對應位置
               CALL armt200_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "rmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmbb_t" 
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
               CALL armt200_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "rmba_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "rmbb_t" 
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
                  CALL armt200_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL armt200_fetch("F")
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
               CALL armt200_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL armt200_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt200_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL armt200_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt200_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL armt200_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt200_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL armt200_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt200_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL armt200_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL armt200_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_rmbb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_rmbb2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_rmbb3_d)
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
               NEXT FIELD rmbbseq
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
               CALL armt200_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL armt200_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL armt200_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL armt200_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc = " rmbadocno = '",g_rmba_m.rmbadocno,"' AND rmba000 = '",g_rmba_m.rmba000,"' AND rmbaent = ",g_enterprise," AND rmbasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt200_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc = " rmbadocno = '",g_rmba_m.rmbadocno,"' AND rmba000 = '",g_rmba_m.rmba000,"' AND rmbaent = ",g_enterprise," AND rmbasite = '",g_site,"' "
               #END add-point
               &include "erp/arm/armt200_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL armt200_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL armt200_query()
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
            CALL armt200_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL armt200_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL armt200_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_rmba_m.rmbadocdt)
 
 
 
         
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
 
{<section id="armt200.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION armt200_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT rmbadocno,rmba000 ",
                      " FROM rmba_t ",
                      " ",
                      " LEFT JOIN rmbb_t ON rmbbent = rmbaent AND rmbadocno = rmbbdocno AND rmba000 = rmbb000 ", "  ",
                      #add-point:browser_fill段sql(rmbb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN rmbc_t ON rmbcent = rmbaent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq", "  ",
                      #add-point:browser_fill段sql(rmbc_t1) name="browser_fill.cnt.join.rmbc_t1"
                      
                      #end add-point
 
                      " LEFT JOIN rmbd_t ON rmbdent = rmbaent AND rmbbdocno = rmbddocno AND rmbb000 = rmbd000 AND rmbbseq = rmbdseq", "  ",
                      #add-point:browser_fill段sql(rmbd_t1) name="browser_fill.cnt.join.rmbd_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
                      " ",
 
 
                      " WHERE rmbaent = " ||g_enterprise|| " AND rmbbent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("rmba_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT rmbadocno,rmba000 ",
                      " FROM rmba_t ", 
                      "  ",
                      "  ",
                      " WHERE rmbaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("rmba_t")
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
      INITIALIZE g_rmba_m.* TO NULL
      CALL g_rmbb_d.clear()        
      CALL g_rmbb2_d.clear() 
      CALL g_rmbb3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.rmbadocno,t0.rmba000,t0.rmbadocdt,t0.rmba001,t0.rmba002,t0.rmba003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmbastus,t0.rmbadocno,t0.rmba000,t0.rmbadocdt,t0.rmba001,t0.rmba002, 
          t0.rmba003,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rmba_t t0",
                  "  ",
                  "  LEFT JOIN rmbb_t ON rmbbent = rmbaent AND rmbadocno = rmbbdocno AND rmba000 = rmbb000 ", "  ", 
                  #add-point:browser_fill段sql(rmbb_t1) name="browser_fill.join.rmbb_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rmbc_t ON rmbcent = rmbaent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq", "  ", 
                  #add-point:browser_fill段sql(rmbc_t1) name="browser_fill.join.rmbc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN rmbd_t ON rmbdent = rmbaent AND rmbbdocno = rmbddocno AND rmbb000 = rmbd000 AND rmbbseq = rmbdseq", "  ", 
                  #add-point:browser_fill段sql(rmbd_t1) name="browser_fill.join.rmbd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
                  " ",
 
 
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.rmba001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rmba002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rmba003  ",
 
                  " WHERE t0.rmbaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rmba_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.rmbastus,t0.rmbadocno,t0.rmba000,t0.rmbadocdt,t0.rmba001,t0.rmba002, 
          t0.rmba003,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ",
                  " FROM rmba_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.rmba001 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.rmba002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.rmba003  ",
 
                  " WHERE t0.rmbaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("rmba_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   LET g_sql = " SELECT DISTINCT t0.rmbastus,t0.rmbadocno,t0.rmba000,t0.rmbadocdt,t0.rmba001,t0.rmba002, 
       t0.rmba003,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ",
               " FROM rmba_t t0",
               "  ",
               "  LEFT JOIN rmbb_t ON rmbbent = rmbaent AND rmbadocno = rmbbdocno AND rmba000 = rmbb000 ", "  ", 
               #add-point:browser_fill段sql(rmbb_t1)

               #end add-point
 
               "  LEFT JOIN rmbc_t ON rmbcent = rmbaent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq", "  ", 
               #add-point:browser_fill段sql(rmbc_t1)

               #end add-point
 
               "  LEFT JOIN rmbd_t ON rmbdent = rmbaent AND rmbbdocno = rmbddocno AND rmbb000 = rmbd000 AND rmbbseq = rmbdseq", "  ", 
               #add-point:browser_fill段sql(rmbd_t1)

               #end add-point
 
 
               "  ",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.rmba001 AND t1.pmaal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent='"||g_enterprise||"' AND t2.ooag001=t0.rmba002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent='"||g_enterprise||"' AND t3.ooefl001=t0.rmba003  AND t3.ooefl002='"||g_lang||"' ",
 
               " WHERE t0.rmbaent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("rmba_t")
   #end add-point
   LET g_sql = g_sql, " ORDER BY rmbadocno,rmba000 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"rmba_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_rmbadocno,g_browser[g_cnt].b_rmba000, 
          g_browser[g_cnt].b_rmbadocdt,g_browser[g_cnt].b_rmba001,g_browser[g_cnt].b_rmba002,g_browser[g_cnt].b_rmba003, 
          g_browser[g_cnt].b_rmba001_desc,g_browser[g_cnt].b_rmba002_desc,g_browser[g_cnt].b_rmba003_desc 
 
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
         CALL armt200_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_rmbadocno) THEN
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
 
{<section id="armt200.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION armt200_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_rmba_m.rmbadocno = g_browser[g_current_idx].b_rmbadocno   
   LET g_rmba_m.rmba000 = g_browser[g_current_idx].b_rmba000   
 
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
   CALL armt200_rmba_t_mask()
   CALL armt200_show()
      
END FUNCTION
 
{</section>}
 
{<section id="armt200.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION armt200_ui_detailshow()
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
 
{<section id="armt200.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION armt200_ui_browser_refresh()
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
      IF g_browser[l_i].b_rmbadocno = g_rmba_m.rmbadocno 
         AND g_browser[l_i].b_rmba000 = g_rmba_m.rmba000 
 
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
 
{<section id="armt200.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION armt200_construct()
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
   INITIALIZE g_rmba_m.* TO NULL
   CALL g_rmbb_d.clear()        
   CALL g_rmbb2_d.clear() 
   CALL g_rmbb3_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON rmbadocno,rmbadocdt,rmba002,rmba000,rmba001,rmba003,rmbasite,rmbastus, 
          rmba004,rmba005,rmba006,rmba007,rmba008,rmba009,rmba010,rmba013,rmba011,rmba012,rmbaownid, 
          rmbaowndp,rmbacrtid,rmbacrtdp,rmbacrtdt,rmbamodid,rmbamoddt,rmbacnfid,rmbacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rmbacrtdt>>----
         AFTER FIELD rmbacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rmbamoddt>>----
         AFTER FIELD rmbamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmbacnfdt>>----
         AFTER FIELD rmbacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rmbapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.rmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbadocno
            #add-point:ON ACTION controlp INFIELD rmbadocno name="construct.c.rmbadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rmaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbadocno  #顯示到畫面上
            NEXT FIELD rmbadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbadocno
            #add-point:BEFORE FIELD rmbadocno name="construct.b.rmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbadocno
            
            #add-point:AFTER FIELD rmbadocno name="construct.a.rmbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbadocdt
            #add-point:BEFORE FIELD rmbadocdt name="construct.b.rmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbadocdt
            
            #add-point:AFTER FIELD rmbadocdt name="construct.a.rmbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbadocdt
            #add-point:ON ACTION controlp INFIELD rmbadocdt name="construct.c.rmbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba002
            #add-point:ON ACTION controlp INFIELD rmba002 name="construct.c.rmba002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba002  #顯示到畫面上
            NEXT FIELD rmba002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba002
            #add-point:BEFORE FIELD rmba002 name="construct.b.rmba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba002
            
            #add-point:AFTER FIELD rmba002 name="construct.a.rmba002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba000
            #add-point:BEFORE FIELD rmba000 name="construct.b.rmba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba000
            
            #add-point:AFTER FIELD rmba000 name="construct.a.rmba000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba000
            #add-point:ON ACTION controlp INFIELD rmba000 name="construct.c.rmba000"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba001
            #add-point:ON ACTION controlp INFIELD rmba001 name="construct.c.rmba001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba001  #顯示到畫面上
            NEXT FIELD rmba001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba001
            #add-point:BEFORE FIELD rmba001 name="construct.b.rmba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba001
            
            #add-point:AFTER FIELD rmba001 name="construct.a.rmba001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba003
            #add-point:ON ACTION controlp INFIELD rmba003 name="construct.c.rmba003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba003  #顯示到畫面上
            NEXT FIELD rmba003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba003
            #add-point:BEFORE FIELD rmba003 name="construct.b.rmba003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba003
            
            #add-point:AFTER FIELD rmba003 name="construct.a.rmba003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbasite
            #add-point:BEFORE FIELD rmbasite name="construct.b.rmbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbasite
            
            #add-point:AFTER FIELD rmbasite name="construct.a.rmbasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbasite
            #add-point:ON ACTION controlp INFIELD rmbasite name="construct.c.rmbasite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbastus
            #add-point:BEFORE FIELD rmbastus name="construct.b.rmbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbastus
            
            #add-point:AFTER FIELD rmbastus name="construct.a.rmbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbastus
            #add-point:ON ACTION controlp INFIELD rmbastus name="construct.c.rmbastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba004
            #add-point:ON ACTION controlp INFIELD rmba004 name="construct.c.rmba004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmad002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba004  #顯示到畫面上
            NEXT FIELD rmba004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba004
            #add-point:BEFORE FIELD rmba004 name="construct.b.rmba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba004
            
            #add-point:AFTER FIELD rmba004 name="construct.a.rmba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba005
            #add-point:ON ACTION controlp INFIELD rmba005 name="construct.c.rmba005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba005  #顯示到畫面上
            NEXT FIELD rmba005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba005
            #add-point:BEFORE FIELD rmba005 name="construct.b.rmba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba005
            
            #add-point:AFTER FIELD rmba005 name="construct.a.rmba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba006
            #add-point:ON ACTION controlp INFIELD rmba006 name="construct.c.rmba006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba006  #顯示到畫面上
            NEXT FIELD rmba006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba006
            #add-point:BEFORE FIELD rmba006 name="construct.b.rmba006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba006
            
            #add-point:AFTER FIELD rmba006 name="construct.a.rmba006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba007
            #add-point:BEFORE FIELD rmba007 name="construct.b.rmba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba007
            
            #add-point:AFTER FIELD rmba007 name="construct.a.rmba007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba007
            #add-point:ON ACTION controlp INFIELD rmba007 name="construct.c.rmba007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba008
            #add-point:BEFORE FIELD rmba008 name="construct.b.rmba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba008
            
            #add-point:AFTER FIELD rmba008 name="construct.a.rmba008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba008
            #add-point:ON ACTION controlp INFIELD rmba008 name="construct.c.rmba008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba009
            #add-point:ON ACTION controlp INFIELD rmba009 name="construct.c.rmba009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_ooef019  #稅區編號 
            LET g_qryparam.arg2 = '2'            
            CALL q_isac002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba009  #顯示到畫面上
            NEXT FIELD rmba009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba009
            #add-point:BEFORE FIELD rmba009 name="construct.b.rmba009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba009
            
            #add-point:AFTER FIELD rmba009 name="construct.a.rmba009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba010
            #add-point:ON ACTION controlp INFIELD rmba010 name="construct.c.rmba010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmba010  #顯示到畫面上
            NEXT FIELD rmba010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba010
            #add-point:BEFORE FIELD rmba010 name="construct.b.rmba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba010
            
            #add-point:AFTER FIELD rmba010 name="construct.a.rmba010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba013
            #add-point:BEFORE FIELD rmba013 name="construct.b.rmba013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba013
            
            #add-point:AFTER FIELD rmba013 name="construct.a.rmba013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba013
            #add-point:ON ACTION controlp INFIELD rmba013 name="construct.c.rmba013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba011
            #add-point:BEFORE FIELD rmba011 name="construct.b.rmba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba011
            
            #add-point:AFTER FIELD rmba011 name="construct.a.rmba011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba011
            #add-point:ON ACTION controlp INFIELD rmba011 name="construct.c.rmba011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba012
            #add-point:BEFORE FIELD rmba012 name="construct.b.rmba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba012
            
            #add-point:AFTER FIELD rmba012 name="construct.a.rmba012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba012
            #add-point:ON ACTION controlp INFIELD rmba012 name="construct.c.rmba012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmbaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbaownid
            #add-point:ON ACTION controlp INFIELD rmbaownid name="construct.c.rmbaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbaownid  #顯示到畫面上
            NEXT FIELD rmbaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbaownid
            #add-point:BEFORE FIELD rmbaownid name="construct.b.rmbaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbaownid
            
            #add-point:AFTER FIELD rmbaownid name="construct.a.rmbaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbaowndp
            #add-point:ON ACTION controlp INFIELD rmbaowndp name="construct.c.rmbaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbaowndp  #顯示到畫面上
            NEXT FIELD rmbaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbaowndp
            #add-point:BEFORE FIELD rmbaowndp name="construct.b.rmbaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbaowndp
            
            #add-point:AFTER FIELD rmbaowndp name="construct.a.rmbaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbacrtid
            #add-point:ON ACTION controlp INFIELD rmbacrtid name="construct.c.rmbacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbacrtid  #顯示到畫面上
            NEXT FIELD rmbacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbacrtid
            #add-point:BEFORE FIELD rmbacrtid name="construct.b.rmbacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbacrtid
            
            #add-point:AFTER FIELD rmbacrtid name="construct.a.rmbacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rmbacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbacrtdp
            #add-point:ON ACTION controlp INFIELD rmbacrtdp name="construct.c.rmbacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbacrtdp  #顯示到畫面上
            NEXT FIELD rmbacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbacrtdp
            #add-point:BEFORE FIELD rmbacrtdp name="construct.b.rmbacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbacrtdp
            
            #add-point:AFTER FIELD rmbacrtdp name="construct.a.rmbacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbacrtdt
            #add-point:BEFORE FIELD rmbacrtdt name="construct.b.rmbacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmbamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbamodid
            #add-point:ON ACTION controlp INFIELD rmbamodid name="construct.c.rmbamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbamodid  #顯示到畫面上
            NEXT FIELD rmbamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbamodid
            #add-point:BEFORE FIELD rmbamodid name="construct.b.rmbamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbamodid
            
            #add-point:AFTER FIELD rmbamodid name="construct.a.rmbamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbamoddt
            #add-point:BEFORE FIELD rmbamoddt name="construct.b.rmbamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.rmbacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbacnfid
            #add-point:ON ACTION controlp INFIELD rmbacnfid name="construct.c.rmbacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbacnfid  #顯示到畫面上
            NEXT FIELD rmbacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbacnfid
            #add-point:BEFORE FIELD rmbacnfid name="construct.b.rmbacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbacnfid
            
            #add-point:AFTER FIELD rmbacnfid name="construct.a.rmbacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbacnfdt
            #add-point:BEFORE FIELD rmbacnfdt name="construct.b.rmbacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON rmbbsite,rmbbseq,rmab018,rmab019,rmab020,rmbb003,rmbb001,rmbb002,srmbb002, 
          rmbb004,rmbb005
           FROM s_detail1[1].rmbbsite,s_detail1[1].rmbbseq,s_detail1[1].rmab018,s_detail1[1].rmab019, 
               s_detail1[1].rmab020,s_detail1[1].rmbb003,s_detail1[1].rmbb001,s_detail1[1].rmbb002,s_detail1[1].srmbb002, 
               s_detail1[1].rmbb004,s_detail1[1].rmbb005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbbsite
            #add-point:BEFORE FIELD rmbbsite name="construct.b.page1.rmbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbbsite
            
            #add-point:AFTER FIELD rmbbsite name="construct.a.page1.rmbbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbbsite
            #add-point:ON ACTION controlp INFIELD rmbbsite name="construct.c.page1.rmbbsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbbseq
            #add-point:BEFORE FIELD rmbbseq name="construct.b.page1.rmbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbbseq
            
            #add-point:AFTER FIELD rmbbseq name="construct.a.page1.rmbbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbbseq
            #add-point:ON ACTION controlp INFIELD rmbbseq name="construct.c.page1.rmbbseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab018
            #add-point:BEFORE FIELD rmab018 name="construct.b.page1.rmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab018
            
            #add-point:AFTER FIELD rmab018 name="construct.a.page1.rmab018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab018
            #add-point:ON ACTION controlp INFIELD rmab018 name="construct.c.page1.rmab018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab019
            #add-point:BEFORE FIELD rmab019 name="construct.b.page1.rmab019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab019
            
            #add-point:AFTER FIELD rmab019 name="construct.a.page1.rmab019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab019
            #add-point:ON ACTION controlp INFIELD rmab019 name="construct.c.page1.rmab019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab020
            #add-point:BEFORE FIELD rmab020 name="construct.b.page1.rmab020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab020
            
            #add-point:AFTER FIELD rmab020 name="construct.a.page1.rmab020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmab020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab020
            #add-point:ON ACTION controlp INFIELD rmab020 name="construct.c.page1.rmab020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb003
            #add-point:BEFORE FIELD rmbb003 name="construct.b.page1.rmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb003
            
            #add-point:AFTER FIELD rmbb003 name="construct.a.page1.rmbb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb003
            #add-point:ON ACTION controlp INFIELD rmbb003 name="construct.c.page1.rmbb003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb001
            #add-point:BEFORE FIELD rmbb001 name="construct.b.page1.rmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb001
            
            #add-point:AFTER FIELD rmbb001 name="construct.a.page1.rmbb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb001
            #add-point:ON ACTION controlp INFIELD rmbb001 name="construct.c.page1.rmbb001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb002
            #add-point:BEFORE FIELD rmbb002 name="construct.b.page1.rmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb002
            
            #add-point:AFTER FIELD rmbb002 name="construct.a.page1.rmbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb002
            #add-point:ON ACTION controlp INFIELD rmbb002 name="construct.c.page1.rmbb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srmbb002
            #add-point:BEFORE FIELD srmbb002 name="construct.b.page1.srmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srmbb002
            
            #add-point:AFTER FIELD srmbb002 name="construct.a.page1.srmbb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srmbb002
            #add-point:ON ACTION controlp INFIELD srmbb002 name="construct.c.page1.srmbb002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb004
            #add-point:BEFORE FIELD rmbb004 name="construct.b.page1.rmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb004
            
            #add-point:AFTER FIELD rmbb004 name="construct.a.page1.rmbb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb004
            #add-point:ON ACTION controlp INFIELD rmbb004 name="construct.c.page1.rmbb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb005
            #add-point:BEFORE FIELD rmbb005 name="construct.b.page1.rmbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb005
            
            #add-point:AFTER FIELD rmbb005 name="construct.a.page1.rmbb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb005
            #add-point:ON ACTION controlp INFIELD rmbb005 name="construct.c.page1.rmbb005"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON rmbcsite,rmbcseq1,rmbc001,rmbc002,rmbc003,rmbc004,rmbc005,rmbc006,rmbc008, 
          rmbc007
           FROM s_detail2[1].rmbcsite,s_detail2[1].rmbcseq1,s_detail2[1].rmbc001,s_detail2[1].rmbc002, 
               s_detail2[1].rmbc003,s_detail2[1].rmbc004,s_detail2[1].rmbc005,s_detail2[1].rmbc006,s_detail2[1].rmbc008, 
               s_detail2[1].rmbc007
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbcsite
            #add-point:BEFORE FIELD rmbcsite name="construct.b.page2.rmbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbcsite
            
            #add-point:AFTER FIELD rmbcsite name="construct.a.page2.rmbcsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbcsite
            #add-point:ON ACTION controlp INFIELD rmbcsite name="construct.c.page2.rmbcsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbcseq1
            #add-point:BEFORE FIELD rmbcseq1 name="construct.b.page2.rmbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbcseq1
            
            #add-point:AFTER FIELD rmbcseq1 name="construct.a.page2.rmbcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbcseq1
            #add-point:ON ACTION controlp INFIELD rmbcseq1 name="construct.c.page2.rmbcseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc001
            #add-point:ON ACTION controlp INFIELD rmbc001 name="construct.c.page2.rmbc001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbc001  #顯示到畫面上
            NEXT FIELD rmbc001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc001
            #add-point:BEFORE FIELD rmbc001 name="construct.b.page2.rmbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc001
            
            #add-point:AFTER FIELD rmbc001 name="construct.a.page2.rmbc001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc002
            #add-point:BEFORE FIELD rmbc002 name="construct.b.page2.rmbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc002
            
            #add-point:AFTER FIELD rmbc002 name="construct.a.page2.rmbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc002
            #add-point:ON ACTION controlp INFIELD rmbc002 name="construct.c.page2.rmbc002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.rmbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc003
            #add-point:ON ACTION controlp INFIELD rmbc003 name="construct.c.page2.rmbc003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbc003  #顯示到畫面上
            NEXT FIELD rmbc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc003
            #add-point:BEFORE FIELD rmbc003 name="construct.b.page2.rmbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc003
            
            #add-point:AFTER FIELD rmbc003 name="construct.a.page2.rmbc003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc004
            #add-point:BEFORE FIELD rmbc004 name="construct.b.page2.rmbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc004
            
            #add-point:AFTER FIELD rmbc004 name="construct.a.page2.rmbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc004
            #add-point:ON ACTION controlp INFIELD rmbc004 name="construct.c.page2.rmbc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc005
            #add-point:BEFORE FIELD rmbc005 name="construct.b.page2.rmbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc005
            
            #add-point:AFTER FIELD rmbc005 name="construct.a.page2.rmbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc005
            #add-point:ON ACTION controlp INFIELD rmbc005 name="construct.c.page2.rmbc005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc006
            #add-point:BEFORE FIELD rmbc006 name="construct.b.page2.rmbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc006
            
            #add-point:AFTER FIELD rmbc006 name="construct.a.page2.rmbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc006
            #add-point:ON ACTION controlp INFIELD rmbc006 name="construct.c.page2.rmbc006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc008
            #add-point:BEFORE FIELD rmbc008 name="construct.b.page2.rmbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc008
            
            #add-point:AFTER FIELD rmbc008 name="construct.a.page2.rmbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc008
            #add-point:ON ACTION controlp INFIELD rmbc008 name="construct.c.page2.rmbc008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc007
            #add-point:BEFORE FIELD rmbc007 name="construct.b.page2.rmbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc007
            
            #add-point:AFTER FIELD rmbc007 name="construct.a.page2.rmbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.rmbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc007
            #add-point:ON ACTION controlp INFIELD rmbc007 name="construct.c.page2.rmbc007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON rmbdsite,rmbdseq1,rmbd001,rmbd002,rmbd003,rmbd004,rmbd006,rmbd005
           FROM s_detail3[1].rmbdsite,s_detail3[1].rmbdseq1,s_detail3[1].rmbd001,s_detail3[1].rmbd002, 
               s_detail3[1].rmbd003,s_detail3[1].rmbd004,s_detail3[1].rmbd006,s_detail3[1].rmbd005
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbdsite
            #add-point:BEFORE FIELD rmbdsite name="construct.b.page3.rmbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbdsite
            
            #add-point:AFTER FIELD rmbdsite name="construct.a.page3.rmbdsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbdsite
            #add-point:ON ACTION controlp INFIELD rmbdsite name="construct.c.page3.rmbdsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbdseq1
            #add-point:BEFORE FIELD rmbdseq1 name="construct.b.page3.rmbdseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbdseq1
            
            #add-point:AFTER FIELD rmbdseq1 name="construct.a.page3.rmbdseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbdseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbdseq1
            #add-point:ON ACTION controlp INFIELD rmbdseq1 name="construct.c.page3.rmbdseq1"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.rmbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd001
            #add-point:ON ACTION controlp INFIELD rmbd001 name="construct.c.page3.rmbd001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1131'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmbd001  #顯示到畫面上
            NEXT FIELD rmbd001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd001
            #add-point:BEFORE FIELD rmbd001 name="construct.b.page3.rmbd001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd001
            
            #add-point:AFTER FIELD rmbd001 name="construct.a.page3.rmbd001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd002
            #add-point:BEFORE FIELD rmbd002 name="construct.b.page3.rmbd002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd002
            
            #add-point:AFTER FIELD rmbd002 name="construct.a.page3.rmbd002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd002
            #add-point:ON ACTION controlp INFIELD rmbd002 name="construct.c.page3.rmbd002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd003
            #add-point:BEFORE FIELD rmbd003 name="construct.b.page3.rmbd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd003
            
            #add-point:AFTER FIELD rmbd003 name="construct.a.page3.rmbd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd003
            #add-point:ON ACTION controlp INFIELD rmbd003 name="construct.c.page3.rmbd003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd004
            #add-point:BEFORE FIELD rmbd004 name="construct.b.page3.rmbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd004
            
            #add-point:AFTER FIELD rmbd004 name="construct.a.page3.rmbd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd004
            #add-point:ON ACTION controlp INFIELD rmbd004 name="construct.c.page3.rmbd004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd006
            #add-point:BEFORE FIELD rmbd006 name="construct.b.page3.rmbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd006
            
            #add-point:AFTER FIELD rmbd006 name="construct.a.page3.rmbd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd006
            #add-point:ON ACTION controlp INFIELD rmbd006 name="construct.c.page3.rmbd006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd005
            #add-point:BEFORE FIELD rmbd005 name="construct.b.page3.rmbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd005
            
            #add-point:AFTER FIELD rmbd005 name="construct.a.page3.rmbd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.rmbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd005
            #add-point:ON ACTION controlp INFIELD rmbd005 name="construct.c.page3.rmbd005"
            
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
                  WHEN la_wc[li_idx].tableid = "rmba_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "rmbb_t" 
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
 
{<section id="armt200.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION armt200_filter()
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
      CONSTRUCT g_wc_filter ON rmbadocno,rmba000,rmbadocdt,rmba001,rmba002,rmba003
                          FROM s_browse[1].b_rmbadocno,s_browse[1].b_rmba000,s_browse[1].b_rmbadocdt, 
                              s_browse[1].b_rmba001,s_browse[1].b_rmba002,s_browse[1].b_rmba003
 
         BEFORE CONSTRUCT
               DISPLAY armt200_filter_parser('rmbadocno') TO s_browse[1].b_rmbadocno
            DISPLAY armt200_filter_parser('rmba000') TO s_browse[1].b_rmba000
            DISPLAY armt200_filter_parser('rmbadocdt') TO s_browse[1].b_rmbadocdt
            DISPLAY armt200_filter_parser('rmba001') TO s_browse[1].b_rmba001
            DISPLAY armt200_filter_parser('rmba002') TO s_browse[1].b_rmba002
            DISPLAY armt200_filter_parser('rmba003') TO s_browse[1].b_rmba003
      
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
 
      CALL armt200_filter_show('rmbadocno')
   CALL armt200_filter_show('rmba000')
   CALL armt200_filter_show('rmbadocdt')
   CALL armt200_filter_show('rmba001')
   CALL armt200_filter_show('rmba002')
   CALL armt200_filter_show('rmba003')
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION armt200_filter_parser(ps_field)
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
 
{<section id="armt200.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION armt200_filter_show(ps_field)
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
   LET ls_condition = armt200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION armt200_query()
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
   CALL g_rmbb_d.clear()
   CALL g_rmbb2_d.clear()
   CALL g_rmbb3_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL armt200_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL armt200_browser_fill("")
      CALL armt200_fetch("")
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
      CALL armt200_filter_show('rmbadocno')
   CALL armt200_filter_show('rmba000')
   CALL armt200_filter_show('rmbadocdt')
   CALL armt200_filter_show('rmba001')
   CALL armt200_filter_show('rmba002')
   CALL armt200_filter_show('rmba003')
   CALL armt200_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL armt200_fetch("F") 
      #顯示單身筆數
      CALL armt200_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION armt200_fetch(p_flag)
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
   CALL g_rmbb2_d.clear()
   CALL g_rmbb3_d.clear()
 
   
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
   
   LET g_rmba_m.rmbadocno = g_browser[g_current_idx].b_rmbadocno
   LET g_rmba_m.rmba000 = g_browser[g_current_idx].b_rmba000
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
   #遮罩相關處理
   LET g_rmba_m_mask_o.* =  g_rmba_m.*
   CALL armt200_rmba_t_mask()
   LET g_rmba_m_mask_n.* =  g_rmba_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt200_set_act_visible()   
   CALL armt200_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmba_m_t.* = g_rmba_m.*
   LET g_rmba_m_o.* = g_rmba_m.*
   
   LET g_data_owner = g_rmba_m.rmbaownid      
   LET g_data_dept  = g_rmba_m.rmbaowndp
   
   #重新顯示   
   CALL armt200_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.insert" >}
#+ 資料新增
PRIVATE FUNCTION armt200_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_rmbb_d.clear()   
   CALL g_rmbb2_d.clear()  
   CALL g_rmbb3_d.clear()  
 
 
   INITIALIZE g_rmba_m.* TO NULL             #DEFAULT 設定
   
   LET g_rmbadocno_t = NULL
   LET g_rmba000_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   INITIALIZE g_rmba_m_t.* LIKE rmba_t.*
   INITIALIZE g_rmba_m_o.* LIKE rmba_t.*
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmba_m.rmbaownid = g_user
      LET g_rmba_m.rmbaowndp = g_dept
      LET g_rmba_m.rmbacrtid = g_user
      LET g_rmba_m.rmbacrtdp = g_dept 
      LET g_rmba_m.rmbacrtdt = cl_get_current()
      LET g_rmba_m.rmbamodid = g_user
      LET g_rmba_m.rmbamoddt = cl_get_current()
      LET g_rmba_m.rmbastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      SELECT MAX(rmba000)+1 INTO g_rmba_m.rmba000 FROM rmba_t 
       WHERE rmbaent = g_enterprise
         AND rmbasite = g_site
         AND rmbadocno = g_rmba_m.rmbadocno
      IF cl_null(g_rmba_m.rmba000) THEN
         LET g_rmba_m.rmba000 = 0
      END IF      
      LET g_rmba_m.rmbasite = g_site
      LET g_rmba_m.rmbadocdt = g_today
      LET g_rmba_m.rmba002 = g_user
      LET g_rmba_m.rmba003 = g_dept
      CALL s_desc_get_person_desc(g_rmba_m.rmba002) RETURNING g_rmba_m.rmba002_desc
      CALL s_desc_get_department_desc(g_rmba_m.rmba003) RETURNING g_rmba_m.rmba003_desc
      DISPLAY BY NAME g_rmba_m.rmba000,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba003,
                      g_rmba_m.rmba002_desc,g_rmba_m.rmba003_desc
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_rmba_m_t.* = g_rmba_m.*
      LET g_rmba_m_o.* = g_rmba_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmba_m.rmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL armt200_input("a")
      
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
         INITIALIZE g_rmba_m.* TO NULL
         INITIALIZE g_rmbb_d TO NULL
         INITIALIZE g_rmbb2_d TO NULL
         INITIALIZE g_rmbb3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL armt200_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_rmbb_d.clear()
      #CALL g_rmbb2_d.clear()
      #CALL g_rmbb3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL armt200_set_act_visible()   
   CALL armt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmbadocno_t = g_rmba_m.rmbadocno
   LET g_rmba000_t = g_rmba_m.rmba000
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmbaent = " ||g_enterprise|| " AND",
                      " rmbadocno = '", g_rmba_m.rmbadocno, "' "
                      ," AND rmba000 = '", g_rmba_m.rmba000, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE armt200_cl
   
   CALL armt200_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
   
   #遮罩相關處理
   LET g_rmba_m_mask_o.* =  g_rmba_m.*
   CALL armt200_rmba_t_mask()
   LET g_rmba_m_mask_n.* =  g_rmba_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
       g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
       g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba009_desc, 
       g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc, 
       g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc,g_rmba_m.rmbacnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_rmba_m.rmbaownid      
   LET g_data_dept  = g_rmba_m.rmbaowndp
   
   #功能已完成,通報訊息中心
   CALL armt200_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.modify" >}
#+ 資料修改
PRIVATE FUNCTION armt200_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_rmba_m_t.* = g_rmba_m.*
   LET g_rmba_m_o.* = g_rmba_m.*
   
   IF g_rmba_m.rmbadocno IS NULL
   OR g_rmba_m.rmba000 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_rmbadocno_t = g_rmba_m.rmbadocno
   LET g_rmba000_t = g_rmba_m.rmba000
 
   CALL s_transaction_begin()
   
   OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
   #檢查是否允許此動作
   IF NOT armt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmba_m_mask_o.* =  g_rmba_m.*
   CALL armt200_rmba_t_mask()
   LET g_rmba_m_mask_n.* =  g_rmba_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
   
   CALL armt200_show()
   #add-point:modify段show之後 name="modify.after_show"
   IF g_aw = "s_detail1" THEN
      RETURN
   END IF
   IF g_detail_idx = 0 THEN
      RETURN
   END IF
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
    
   WHILE TRUE
      LET g_rmbadocno_t = g_rmba_m.rmbadocno
      LET g_rmba000_t = g_rmba_m.rmba000
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_rmba_m.rmbamodid = g_user 
LET g_rmba_m.rmbamoddt = cl_get_current()
LET g_rmba_m.rmbamodid_desc = cl_get_username(g_rmba_m.rmbamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      IF g_aw = "s_detail1" THEN
         RETURN
      END IF
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL armt200_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      CALL FGL_SET_ARR_CURR(g_detail_idx)    #add by lixh 20150804
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE rmba_t SET (rmbamodid,rmbamoddt) = (g_rmba_m.rmbamodid,g_rmba_m.rmbamoddt)
          WHERE rmbaent = g_enterprise AND rmbadocno = g_rmbadocno_t
            AND rmba000 = g_rmba000_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_rmba_m.* = g_rmba_m_t.*
            CALL armt200_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_rmba_m.rmbadocno != g_rmba_m_t.rmbadocno
      OR g_rmba_m.rmba000 != g_rmba_m_t.rmba000
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE rmbb_t SET rmbbdocno = g_rmba_m.rmbadocno
                                       ,rmbb000 = g_rmba_m.rmba000
 
          WHERE rmbbent = g_enterprise AND rmbbdocno = g_rmba_m_t.rmbadocno
            AND rmbb000 = g_rmba_m_t.rmba000
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "rmbb_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
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
         UPDATE rmbc_t
            SET rmbcdocno = g_rmba_m.rmbadocno
               ,rmbc000 = g_rmba_m.rmba000
 
          WHERE rmbcent = g_enterprise AND
                rmbcdocno = g_rmbadocno_t
            AND rmbc000 = g_rmba000_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbc_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
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
         UPDATE rmbd_t
            SET rmbddocno = g_rmba_m.rmbadocno
               ,rmbd000 = g_rmba_m.rmba000
 
          WHERE rmbdent = g_enterprise AND
                rmbddocno = g_rmbadocno_t
            AND rmbd000 = g_rmba000_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbd_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
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
   CALL armt200_set_act_visible()   
   CALL armt200_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " rmbaent = " ||g_enterprise|| " AND",
                      " rmbadocno = '", g_rmba_m.rmbadocno, "' "
                      ," AND rmba000 = '", g_rmba_m.rmba000, "' "
 
   #填到對應位置
   CALL armt200_browser_fill("")
 
   CLOSE armt200_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt200_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="armt200.input" >}
#+ 資料輸入
PRIVATE FUNCTION armt200_input(p_cmd)
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
   DEFINE  l_oodbl004  LIKE oodbl_t.oodbl004
   DEFINE  l_oodb005   LIKE oodb_t.oodb005
   DEFINE  l_oodb006   LIKE oodb_t.oodb006
   DEFINE  l_oodb011   LIKE oodb_t.oodb011
   DEFINE  l_success   LIKE type_t.num5
   DEFINE  r_success   LIKE type_t.num5
   DEFINE  l_imaa006   LIKE imaa_t.imaa006
   DEFINE  r_rate      LIKE inaj_t.inaj014
   DEFINE  i           LIKE type_t.num5
   DEFINE  l_rmbb001   LIKE rmbb_t.rmbb001   #计算未税材料金额sum    2016-2-22 zhujing add
   DEFINE  l_rmbb002   LIKE rmbb_t.rmbb002   #计算未税费用金额sum    2016-2-22 zhujing add
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
   DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
       g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
       g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba009_desc, 
       g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc, 
       g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc,g_rmba_m.rmbacnfdt
   
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
   LET g_forupd_sql = "SELECT rmbbsite,rmbbseq,rmbb003,rmbb001,rmbb002,rmbb004,rmbb005 FROM rmbb_t WHERE  
       rmbbent=? AND rmbbdocno=? AND rmbb000=? AND rmbbseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt200_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rmbcsite,rmbcseq1,rmbc001,rmbc002,rmbc003,rmbc004,rmbc005,rmbc006,rmbc008, 
       rmbc007 FROM rmbc_t WHERE rmbcent=? AND rmbcdocno=? AND rmbc000=? AND rmbcseq=? AND rmbcseq1=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt200_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point 
   LET g_forupd_sql = "SELECT rmbdsite,rmbdseq1,rmbd001,rmbd002,rmbd003,rmbd004,rmbd006,rmbd005 FROM  
       rmbd_t WHERE rmbdent=? AND rmbddocno=? AND rmbd000=? AND rmbdseq=? AND rmbdseq1=? FOR UPDATE" 
 
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE armt200_bcl3 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL armt200_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL armt200_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001, 
       g_rmba_m.rmba003,g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006, 
       g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011, 
       g_rmba_m.rmba012
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   #取得稅區
   CALL s_tax_get_ooef019(g_site) RETURNING l_success,l_ooef019
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="armt200.input.head" >}
      #單頭段
      INPUT BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001, 
          g_rmba_m.rmba003,g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006, 
          g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011, 
          g_rmba_m.rmba012 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL armt200_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL armt200_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbadocno
            
            #add-point:AFTER FIELD rmbadocno name="input.a.rmbadocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            SELECT MAX(rmba000)+1 INTO g_rmba_m.rmba000 FROM rmba_t 
             WHERE rmbaent = g_enterprise
               AND rmbasite = g_site
               AND rmbadocno = g_rmba_m.rmbadocno
            IF cl_null(g_rmba_m.rmba000) THEN
               LET g_rmba_m.rmba000 = 0
            END IF                  
            IF NOT cl_null(g_rmba_m.rmbadocno) AND NOT cl_null(g_rmba_m.rmba000) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmba_m.rmbadocno != g_rmbadocno_t  OR g_rmba_m.rmba000 != g_rmba000_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmba_t WHERE "||"rmbaent = '" ||g_enterprise|| "' AND "||"rmbadocno = '"||g_rmba_m.rmbadocno ||"' AND "|| "rmba000 = '"||g_rmba_m.rmba000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmba_m.rmbadocno               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rmaadocno") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmba_m.rmbadocno = g_rmba_m_t.rmbadocno
                  CALL armt200_rmbadocno_desc()
                  CALL armt200_default_rmbb()    
                  NEXT FIELD CURRENT
               END IF 
               IF g_rmba_m_o.rmbadocno <> g_rmba_m.rmbadocno OR g_rmba_m_o.rmbadocno IS NULL THEN               
                  CALL armt200_rmbadocno_desc()
                  CALL armt200_default_rmbb()                  
               END IF                  
            END IF
            #add by lixh 20150810  #複製
            IF l_cmd_t = 'r' THEN
               IF g_rmba_m.rmbadocno <> g_rmbadocno_t THEN
                  CALL g_rmbb2_d.clear()
                  CALL g_rmbb3_d.clear()
               END IF               
            END IF
            #add by lixh 20150810
            LET g_rmba_m_o.rmbadocno = g_rmba_m.rmbadocno
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbadocno
            #add-point:BEFORE FIELD rmbadocno name="input.b.rmbadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbadocno
            #add-point:ON CHANGE rmbadocno name="input.g.rmbadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbadocdt
            #add-point:BEFORE FIELD rmbadocdt name="input.b.rmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbadocdt
            
            #add-point:AFTER FIELD rmbadocdt name="input.a.rmbadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbadocdt
            #add-point:ON CHANGE rmbadocdt name="input.g.rmbadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba002
            
            #add-point:AFTER FIELD rmba002 name="input.a.rmba002"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmba_m.rmba002
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_rmba_m.rmba002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmba_m.rmba002_desc
            IF NOT cl_null(g_rmba_m.rmba002) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmba_m.rmba002            
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmba_m.rmba002 = g_rmba_m_t.rmba002
                  CALL s_desc_get_person_desc(g_rmba_m.rmba002) RETURNING g_rmba_m.rmba002_desc
                  NEXT FIELD CURRENT
               END IF              
               CALL s_desc_get_person_desc(g_rmba_m.rmba002) RETURNING g_rmba_m.rmba002_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba002
            #add-point:BEFORE FIELD rmba002 name="input.b.rmba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba002
            #add-point:ON CHANGE rmba002 name="input.g.rmba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba000
            #add-point:BEFORE FIELD rmba000 name="input.b.rmba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba000
            
            #add-point:AFTER FIELD rmba000 name="input.a.rmba000"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_rmba_m.rmbadocno) AND NOT cl_null(g_rmba_m.rmba000) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_rmba_m.rmbadocno != g_rmbadocno_t  OR g_rmba_m.rmba000 != g_rmba000_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmba_t WHERE "||"rmbaent = '" ||g_enterprise|| "' AND "||"rmbadocno = '"||g_rmba_m.rmbadocno ||"' AND "|| "rmba000 = '"||g_rmba_m.rmba000 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba000
            #add-point:ON CHANGE rmba000 name="input.g.rmba000"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba001
            
            #add-point:AFTER FIELD rmba001 name="input.a.rmba001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmba_m.rmba001
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmba_m.rmba001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmba_m.rmba001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba001
            #add-point:BEFORE FIELD rmba001 name="input.b.rmba001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba001
            #add-point:ON CHANGE rmba001 name="input.g.rmba001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba003
            
            #add-point:AFTER FIELD rmba003 name="input.a.rmba003"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmba_m.rmba003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmba_m.rmba003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmba_m.rmba003_desc

            IF NOT cl_null(g_rmba_m.rmba003) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmba_m.rmba003            
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmba_m.rmba003 = g_rmba_m_t.rmba003
                  CALL s_desc_get_department_desc(g_rmba_m.rmba003) RETURNING g_rmba_m.rmba003_desc
                  NEXT FIELD CURRENT
               END IF              
               CALL s_desc_get_department_desc(g_rmba_m.rmba003) RETURNING g_rmba_m.rmba003_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba003
            #add-point:BEFORE FIELD rmba003 name="input.b.rmba003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba003
            #add-point:ON CHANGE rmba003 name="input.g.rmba003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbasite
            #add-point:BEFORE FIELD rmbasite name="input.b.rmbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbasite
            
            #add-point:AFTER FIELD rmbasite name="input.a.rmbasite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbasite
            #add-point:ON CHANGE rmbasite name="input.g.rmbasite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbastus
            #add-point:BEFORE FIELD rmbastus name="input.b.rmbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbastus
            
            #add-point:AFTER FIELD rmbastus name="input.a.rmbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbastus
            #add-point:ON CHANGE rmbastus name="input.g.rmbastus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba004
            
            #add-point:AFTER FIELD rmba004 name="input.a.rmba004"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmba_m.rmba004
            CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmba_m.rmba004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmba_m.rmba004_desc
            IF NOT cl_null(g_rmba_m.rmba004) THEN
               IF NOT s_axmt540_receive_condition_chk(g_rmba_m.rmba001,g_rmba_m.rmba004) THEN
                  LET g_rmba_m.rmba004 = g_rmba_m_t.rmba004
                  CALL s_desc_get_ooib002_desc(g_rmba_m.rmba004) RETURNING g_rmba_m.rmba004_desc
                  NEXT FIELD rmba004
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_rmba_m.rmba004) RETURNING g_rmba_m.rmba004_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba004
            #add-point:BEFORE FIELD rmba004 name="input.b.rmba004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba004
            #add-point:ON CHANGE rmba004 name="input.g.rmba004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba005
            
            #add-point:AFTER FIELD rmba005 name="input.a.rmba005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmba_m.rmba005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmba_m.rmba005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmba_m.rmba005_desc
            IF NOT cl_null(g_rmba_m.rmba005) THEN
               IF NOT s_azzi650_chk_exist('238',g_rmba_m.rmba005) THEN
                  LET g_rmba_m.rmba005 = g_rmba_m_t.rmba005
                  CALL s_desc_get_acc_desc('238',g_rmba_m.rmba005) RETURNING g_rmba_m.rmba005_desc 
                  NEXT FIELD rmba005 
               END IF
            END IF
            CALL s_desc_get_acc_desc('238',g_rmba_m.rmba005) RETURNING g_rmba_m.rmba005_desc 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba005
            #add-point:BEFORE FIELD rmba005 name="input.b.rmba005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba005
            #add-point:ON CHANGE rmba005 name="input.g.rmba005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba006
            
            #add-point:AFTER FIELD rmba006 name="input.a.rmba006"
            CALL s_desc_get_tax_desc1(g_site,g_rmba_m.rmba006) RETURNING g_rmba_m.rmba006_desc
            DISPLAY BY NAME g_rmba_m.rmba006_desc            
            
            IF NOT cl_null(g_rmba_m.rmba006) THEN 
               IF g_rmba_m.rmba006 <> g_rmba_m_o.rmba006 OR cl_null(g_rmba_m_o.rmba006) THEN
                  
                  #檢查、取得稅別、單價含稅否
                  CALL s_tax_chk(g_site,g_rmba_m.rmba006) RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
       
                  IF NOT l_success THEN
                     LET g_rmba_m.rmba006 = g_rmba_m_o.rmba006
                     
                     CALL s_desc_get_tax_desc1(g_site,g_rmba_m.rmba006) RETURNING g_rmba_m.rmba006_desc
                     DISPLAY BY NAME g_rmba_m.rmba006_desc
                     
                     NEXT FIELD CURRENT
                  END IF
                  LET g_rmba_m.rmba007 = l_oodb006
                  LET g_rmba_m.rmba008 = l_oodb005
               END IF   
            END IF
            LET  g_rmba_m_o.rmba006 = g_rmba_m.rmba006
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba006
            #add-point:BEFORE FIELD rmba006 name="input.b.rmba006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba006
            #add-point:ON CHANGE rmba006 name="input.g.rmba006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba007
            #add-point:BEFORE FIELD rmba007 name="input.b.rmba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba007
            
            #add-point:AFTER FIELD rmba007 name="input.a.rmba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba007
            #add-point:ON CHANGE rmba007 name="input.g.rmba007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba008
            #add-point:BEFORE FIELD rmba008 name="input.b.rmba008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba008
            
            #add-point:AFTER FIELD rmba008 name="input.a.rmba008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba008
            #add-point:ON CHANGE rmba008 name="input.g.rmba008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba009
            
            #add-point:AFTER FIELD rmba009 name="input.a.rmba009"
            CALL s_desc_get_invoice_type_desc1(g_site,g_rmba_m.rmba009) RETURNING g_rmba_m.rmba009_desc
            DISPLAY BY NAME g_rmba_m.rmba009_desc
            
            IF NOT cl_null(g_rmba_m.rmba009) THEN 
               IF g_rmba_m.rmba009 <> g_rmba_m_o.rmba009 OR cl_null(g_rmba_m_o.rmba009) THEN

                  #取得稅區
                  CALL s_tax_get_ooef019(g_site) RETURNING l_success,l_ooef019

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = l_ooef019
                  LET g_chkparam.arg2 = g_rmba_m.rmba009
                  
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_isac002") THEN
                     LET g_rmba_m.rmba009 = g_rmba_m_o.rmba009

                     CALL s_desc_get_invoice_type_desc1(g_site,g_rmba_m.rmba009) RETURNING g_rmba_m.rmba009_desc
                     DISPLAY BY NAME g_rmba_m.rmba009_desc

                     NEXT FIELD CURRENT
                  END IF            
               END IF
            END IF 
            
            LET g_rmba_m_o.rmba009 = g_rmba_m.rmba009

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba009
            #add-point:BEFORE FIELD rmba009 name="input.b.rmba009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba009
            #add-point:ON CHANGE rmba009 name="input.g.rmba009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba010
            
            #add-point:AFTER FIELD rmba010 name="input.a.rmba010"
            IF NOT cl_null(g_rmba_m.rmba010) THEN
               IF g_rmba_m.rmba010 <> g_rmba_m_o.rmba010 OR cl_null(g_rmba_m_o.rmba010) THEN
                  
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_rmba_m.rmba010
                  LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"  #160318-00025#33  add
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooaj002") THEN
                     LET g_rmba_m.rmba010 = g_rmba_m_o.rmba010
                     
                     CALL s_desc_get_currency_desc(g_rmba_m.rmba010) RETURNING g_rmba_m.rmba010_desc
                     DISPLAY BY NAME g_rmba_m.rmba010_desc
                     
                     NEXT FIELD CURRENT
                  END IF

                  #帶出匯率
                  CALL s_axmt540_get_exchange(g_rmba_m.rmba013,g_rmba_m.rmba010,g_rmba_m.rmbadocdt) RETURNING g_rmba_m.rmba011   #151118-00012#1 By shiun   新增傳入參數g_rmba_m.rmbadocdt

#                  #更新單身
#                  IF NOT axmt540_detail_update('','',l_xmdk017,'2') THEN
#                     LET g_rmba_m.rmba010 = g_rmba_m_o.rmba010
#                     CALL s_desc_get_currency_desc(g_rmba_m.rmba010) RETURNING g_rmba_m.rmba010_desc
#                     DISPLAY BY NAME g_rmba_m.rmba010_desc
#
#                     CALL s_transaction_end('N',0)
#                     CALL s_transaction_begin()                     
#                     
#                     NEXT FIELD CURRENT
#                  END IF
                  
#                  LET g_xmdk_m.xmdk017 = l_xmdk017
#                  LET g_xmdk_m_o.xmdk017 = g_xmdk_m.xmdk017
#                  DISPLAY BY NAME g_xmdk_m.xmdk017

#               END IF
            END IF                         
         END IF
         LET g_rmba_m_o.rmba010 = g_rmba_m.rmba010
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba010
            #add-point:BEFORE FIELD rmba010 name="input.b.rmba010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba010
            #add-point:ON CHANGE rmba010 name="input.g.rmba010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba013
            #add-point:BEFORE FIELD rmba013 name="input.b.rmba013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba013
            
            #add-point:AFTER FIELD rmba013 name="input.a.rmba013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba013
            #add-point:ON CHANGE rmba013 name="input.g.rmba013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba011
            #add-point:BEFORE FIELD rmba011 name="input.b.rmba011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba011
            
            #add-point:AFTER FIELD rmba011 name="input.a.rmba011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba011
            #add-point:ON CHANGE rmba011 name="input.g.rmba011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmba012
            #add-point:BEFORE FIELD rmba012 name="input.b.rmba012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmba012
            
            #add-point:AFTER FIELD rmba012 name="input.a.rmba012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmba012
            #add-point:ON CHANGE rmba012 name="input.g.rmba012"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.rmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbadocno
            #add-point:ON ACTION controlp INFIELD rmbadocno name="input.c.rmbadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmbadocno             #給予default值


            CALL q_rmaadocno()                                #呼叫開窗

            LET g_rmba_m.rmbadocno = g_qryparam.return1              
            #LET g_rmba_m.oocql004 = g_qryparam.return2 
            DISPLAY g_rmba_m.rmbadocno TO rmbadocno              #
            #DISPLAY g_rmba_m.oocql004 TO oocql004 #說明
            NEXT FIELD rmbadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbadocdt
            #add-point:ON ACTION controlp INFIELD rmbadocdt name="input.c.rmbadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba002
            #add-point:ON ACTION controlp INFIELD rmba002 name="input.c.rmba002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_ooag001()                                #呼叫開窗

            LET g_rmba_m.rmba002 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba002 TO rmba002              #

            NEXT FIELD rmba002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba000
            #add-point:ON ACTION controlp INFIELD rmba000 name="input.c.rmba000"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba001
            #add-point:ON ACTION controlp INFIELD rmba001 name="input.c.rmba001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site


            CALL q_pmaa001_6()                                #呼叫開窗

            LET g_rmba_m.rmba001 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba001 TO rmba001              #

            NEXT FIELD rmba001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba003
            #add-point:ON ACTION controlp INFIELD rmba003 name="input.c.rmba003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today


            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_rmba_m.rmba003 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba003 TO rmba003              #

            NEXT FIELD rmba003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmbasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbasite
            #add-point:ON ACTION controlp INFIELD rmbasite name="input.c.rmbasite"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbastus
            #add-point:ON ACTION controlp INFIELD rmbastus name="input.c.rmbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba004
            #add-point:ON ACTION controlp INFIELD rmba004 name="input.c.rmba004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba004             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_rmba_m.rmba001 


            CALL q_pmad002_3()                                #呼叫開窗

            LET g_rmba_m.rmba004 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba004 TO rmba004              #

            NEXT FIELD rmba004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba005
            #add-point:ON ACTION controlp INFIELD rmba005 name="input.c.rmba005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba005             #給予default值
            LET g_qryparam.default2 = "" #g_rmba_m.oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = '238'

            CALL q_oocq002()                                #呼叫開窗

            LET g_rmba_m.rmba005 = g_qryparam.return1              
            #LET g_rmba_m.oocql004 = g_qryparam.return2 
            DISPLAY g_rmba_m.rmba005 TO rmba005              #
            #DISPLAY g_rmba_m.oocql004 TO oocql004 #說明
            NEXT FIELD rmba005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba006
            #add-point:ON ACTION controlp INFIELD rmba006 name="input.c.rmba006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site


            CALL q_oodb002_3()                                #呼叫開窗

            LET g_rmba_m.rmba006 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba006 TO rmba006              #

            NEXT FIELD rmba006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba007
            #add-point:ON ACTION controlp INFIELD rmba007 name="input.c.rmba007"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba008
            #add-point:ON ACTION controlp INFIELD rmba008 name="input.c.rmba008"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba009
            #add-point:ON ACTION controlp INFIELD rmba009 name="input.c.rmba009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = l_ooef019  #稅區編號 
            LET g_qryparam.arg2 = '2'

            CALL q_isac002_1()                                #呼叫開窗

            LET g_rmba_m.rmba009 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba009 TO rmba009              #

            NEXT FIELD rmba009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba010
            #add-point:ON ACTION controlp INFIELD rmba010 name="input.c.rmba010"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmba_m.rmba010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site


            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_rmba_m.rmba010 = g_qryparam.return1              

            DISPLAY g_rmba_m.rmba010 TO rmba010              #

            NEXT FIELD rmba010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.rmba013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba013
            #add-point:ON ACTION controlp INFIELD rmba013 name="input.c.rmba013"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba011
            #add-point:ON ACTION controlp INFIELD rmba011 name="input.c.rmba011"
            
            #END add-point
 
 
         #Ctrlp:input.c.rmba012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmba012
            #add-point:ON ACTION controlp INFIELD rmba012 name="input.c.rmba012"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmba000
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前

               #end add-point
               
               INSERT INTO rmba_t (rmbaent,rmbadocno,rmbadocdt,rmba002,rmba000,rmba001,rmba003,rmbasite, 
                   rmbastus,rmba004,rmba005,rmba006,rmba007,rmba008,rmba009,rmba010,rmba013,rmba011, 
                   rmba012,rmbaownid,rmbaowndp,rmbacrtid,rmbacrtdp,rmbacrtdt,rmbamodid,rmbamoddt,rmbacnfid, 
                   rmbacnfdt)
               VALUES (g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000, 
                   g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004, 
                   g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009, 
                   g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
                   g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
                   g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt)  

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rmba_m" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中

               #end add-point
               
               
               
               
               #add-point:單頭新增後

               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  IF g_rmbadocno_t =  g_rmba_m.rmbadocno THEN  #add by lixh 20150810
                     CALL armt200_detail_reproduce()
                     #因應特定程式需求, 重新刷新單身資料
                  END IF   
                  CALL armt200_b_fill()
               END IF
               
               #add-point:單頭新增後

               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前

               #end add-point
               
               #將遮罩欄位還原
               CALL armt200_rmba_t_mask_restore('restore_mask_o')
               
               UPDATE rmba_t SET (rmbadocno,rmbadocdt,rmba002,rmba000,rmba001,rmba003,rmbasite,rmbastus, 
                   rmba004,rmba005,rmba006,rmba007,rmba008,rmba009,rmba010,rmba013,rmba011,rmba012,rmbaownid, 
                   rmbaowndp,rmbacrtid,rmbacrtdp,rmbacrtdt,rmbamodid,rmbamoddt,rmbacnfid,rmbacnfdt) 
                   = (g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000, 
                   g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004, 
                   g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009, 
                   g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
                   g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
                   g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt) 

                WHERE rmbaent = g_enterprise AND rmbadocno = g_rmbadocno_t
                  AND rmba000 = g_rmba000_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmba_t" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中

               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL armt200_rmba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rmba_m_t)
               LET g_log2 = util.JSON.stringify(g_rmba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後
                 
               #end add-point
            END IF
            
            LET g_rmbadocno_t = g_rmba_m.rmbadocno
            LET g_rmba000_t = g_rmba_m.rmba000
            NEXT FIELD rmbcseq1 
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO rmba_t (rmbaent,rmbadocno,rmbadocdt,rmba002,rmba000,rmba001,rmba003,rmbasite, 
                   rmbastus,rmba004,rmba005,rmba006,rmba007,rmba008,rmba009,rmba010,rmba013,rmba011, 
                   rmba012,rmbaownid,rmbaowndp,rmbacrtid,rmbacrtdp,rmbacrtdt,rmbamodid,rmbamoddt,rmbacnfid, 
                   rmbacnfdt)
               VALUES (g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000, 
                   g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004, 
                   g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009, 
                   g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
                   g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
                   g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_rmba_m:",SQLERRMESSAGE 
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
                  CALL armt200_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL armt200_b_fill()
                  CALL armt200_b_fill2('0')
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
               CALL armt200_rmba_t_mask_restore('restore_mask_o')
               
               UPDATE rmba_t SET (rmbadocno,rmbadocdt,rmba002,rmba000,rmba001,rmba003,rmbasite,rmbastus, 
                   rmba004,rmba005,rmba006,rmba007,rmba008,rmba009,rmba010,rmba013,rmba011,rmba012,rmbaownid, 
                   rmbaowndp,rmbacrtid,rmbacrtdp,rmbacrtdt,rmbamodid,rmbamoddt,rmbacnfid,rmbacnfdt) = (g_rmba_m.rmbadocno, 
                   g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003, 
                   g_rmba_m.rmbasite,g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006, 
                   g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013, 
                   g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid,g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid, 
                   g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid, 
                   g_rmba_m.rmbacnfdt)
                WHERE rmbaent = g_enterprise AND rmbadocno = g_rmbadocno_t
                  AND rmba000 = g_rmba000_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "rmba_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL armt200_rmba_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_rmba_m_t)
               LET g_log2 = util.JSON.stringify(g_rmba_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                 
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_rmbadocno_t = g_rmba_m.rmbadocno
            LET g_rmba000_t = g_rmba_m.rmba000
 
            
      END INPUT
   
 
{</section>}
 
{<section id="armt200.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_rmbb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmbb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL armt200_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_rmbb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            #NEXT FIELD rmba002        #add by lixh 20150729
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
            CALL armt200_b_fill2('2')
CALL armt200_b_fill2('3')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmbb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmbb_d[l_ac].rmbbseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_rmbb_d_t.* = g_rmbb_d[l_ac].*  #BACKUP
               LET g_rmbb_d_o.* = g_rmbb_d[l_ac].*  #BACKUP
               CALL armt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL armt200_set_no_entry_b(l_cmd)
               IF NOT armt200_lock_b("rmbb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt200_bcl INTO g_rmbb_d[l_ac].rmbbsite,g_rmbb_d[l_ac].rmbbseq,g_rmbb_d[l_ac].rmbb003, 
                      g_rmbb_d[l_ac].rmbb001,g_rmbb_d[l_ac].rmbb002,g_rmbb_d[l_ac].rmbb004,g_rmbb_d[l_ac].rmbb005 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_rmbb_d_t.rmbbseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmbb_d_mask_o[l_ac].* =  g_rmbb_d[l_ac].*
                  CALL armt200_rmbb_t_mask()
                  LET g_rmbb_d_mask_n[l_ac].* =  g_rmbb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt200_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
#            FOR i = l_ac TO 1 STEP -1
#               IF cl_null(g_rmbb2_d[i].rmbcseq1) THEN
#                  CALL g_rmbb2_d.deleteElement(i) 
#               END IF
#            END FOR
#            
#            IF cl_null(g_rmbb2_d[1].rmbcseq1) THEN
#               CALL g_rmbb2_d.deleteElement(1) 
#            END IF

#            LET l_n = 0
#            SELECT COUNT(*) INTO l_n FROM rmbc_t
#             WHERE rmbcent = g_enterprise
#               AND rmbcdocno = g_rmba_m.rmbadocno
#               AND rmbc000 = g_rmba_m.rmba000
#               AND rmbcseq = g_rmbb_d[l_ac].rmbbseq
#           
#            IF l_n = 0 THEN
               CALL g_rmbb2_d.clear()
               CALL g_rmbb3_d.clear()
               CALL armt200_b_fill2('2')
               CALL armt200_b_fill2('3')               
#            END IF   
#            NEXT FIELD rmba002     #add by lixh 20150729

            
            NEXT FIELD rmbcseq1     #add by lixh 20150804
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
            INITIALIZE g_rmbb_d[l_ac].* TO NULL 
            INITIALIZE g_rmbb_d_t.* TO NULL 
            INITIALIZE g_rmbb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_rmbb_d[l_ac].rmab018 = "0"
      LET g_rmbb_d[l_ac].rmab012 = "0"
      LET g_rmbb_d[l_ac].rmab013 = "0"
      LET g_rmbb_d[l_ac].rmbb001 = "0"
      LET g_rmbb_d[l_ac].rmbb002 = "0"
      LET g_rmbb_d[l_ac].srmbb002 = "0"
      LET g_rmbb_d[l_ac].rmbb005 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
#            SELECT MAX(rmbcseq1)+1 INTO g_rmbb2_d[l_ac].rmbcseq1 FROM rmbc_t
#             WHERE rmbcent = g_enterprise
#               AND rmbcsite = g_site
#               AND rmbcdocno = g_rmba_m.rmbadocno
#               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
#               AND rmbc000 = g_rmba_m.rmba000
#            IF cl_null(g_rmbb2_d[l_ac].rmbcseq1) THEN
#               LET g_rmbb2_d[l_ac].rmbcseq1 = 1
#            END IF
#            LET g_rmbb2_d[l_ac].rmbcsite = g_site
            #end add-point
            LET g_rmbb_d_t.* = g_rmbb_d[l_ac].*     #新輸入資料
            LET g_rmbb_d_o.* = g_rmbb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL armt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmbb_d[li_reproduce_target].* = g_rmbb_d[li_reproduce].*
 
               LET g_rmbb_d[li_reproduce_target].rmbbseq = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM rmbb_t 
             WHERE rmbbent = g_enterprise AND rmbbdocno = g_rmba_m.rmbadocno
               AND rmbb000 = g_rmba_m.rmba000
 
               AND rmbbseq = g_rmbb_d[l_ac].rmbbseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               CALL armt200_insert_b('rmbb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_rmbb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt200_b_fill()
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
               LET gs_keys[01] = g_rmba_m.rmbadocno
               LET gs_keys[gs_keys.getLength()+1] = g_rmba_m.rmba000
 
               LET gs_keys[gs_keys.getLength()+1] = g_rmbb_d_t.rmbbseq
 
            
               #刪除同層單身
               IF NOT armt200_delete_b('rmbb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt200_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT armt200_key_delete_b(gs_keys,'rmbb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE armt200_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_rmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmbb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbbsite
            #add-point:BEFORE FIELD rmbbsite name="input.b.page1.rmbbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbbsite
            
            #add-point:AFTER FIELD rmbbsite name="input.a.page1.rmbbsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbbsite
            #add-point:ON CHANGE rmbbsite name="input.g.page1.rmbbsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbbseq
            #add-point:BEFORE FIELD rmbbseq name="input.b.page1.rmbbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbbseq
            
            #add-point:AFTER FIELD rmbbseq name="input.a.page1.rmbbseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmba_m.rmbadocno IS NOT NULL AND g_rmba_m.rmba000 IS NOT NULL AND g_rmbb_d[g_detail_idx].rmbbseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmba_m.rmbadocno != g_rmbadocno_t OR g_rmba_m.rmba000 != g_rmba000_t OR g_rmbb_d[g_detail_idx].rmbbseq != g_rmbb_d_t.rmbbseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmbb_t WHERE "||"rmbbent = '" ||g_enterprise|| "' AND "||"rmbbdocno = '"||g_rmba_m.rmbadocno ||"' AND "|| "rmbb000 = '"||g_rmba_m.rmba000 ||"' AND "|| "rmbbseq = '"||g_rmbb_d[g_detail_idx].rmbbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbbseq
            #add-point:ON CHANGE rmbbseq name="input.g.page1.rmbbseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab018
            #add-point:BEFORE FIELD rmab018 name="input.b.page1.rmab018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab018
            
            #add-point:AFTER FIELD rmab018 name="input.a.page1.rmab018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab018
            #add-point:ON CHANGE rmab018 name="input.g.page1.rmab018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab019
            #add-point:BEFORE FIELD rmab019 name="input.b.page1.rmab019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab019
            
            #add-point:AFTER FIELD rmab019 name="input.a.page1.rmab019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab019
            #add-point:ON CHANGE rmab019 name="input.g.page1.rmab019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab020
            #add-point:BEFORE FIELD rmab020 name="input.b.page1.rmab020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab020
            
            #add-point:AFTER FIELD rmab020 name="input.a.page1.rmab020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab020
            #add-point:ON CHANGE rmab020 name="input.g.page1.rmab020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab009
            
            #add-point:AFTER FIELD rmab009 name="input.a.page1.rmab009"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmbb_d[l_ac].rmab009
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmbb_d[l_ac].rmab009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmbb_d[l_ac].rmab009_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab009
            #add-point:BEFORE FIELD rmab009 name="input.b.page1.rmab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab009
            #add-point:ON CHANGE rmab009 name="input.g.page1.rmab009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab010
            
            #add-point:AFTER FIELD rmab010 name="input.a.page1.rmab010"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab010
            #add-point:BEFORE FIELD rmab010 name="input.b.page1.rmab010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab010
            #add-point:ON CHANGE rmab010 name="input.g.page1.rmab010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab011
            
            #add-point:AFTER FIELD rmab011 name="input.a.page1.rmab011"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmbb_d[l_ac].rmab011
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmbb_d[l_ac].rmab011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmbb_d[l_ac].rmab011_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab011
            #add-point:BEFORE FIELD rmab011 name="input.b.page1.rmab011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab011
            #add-point:ON CHANGE rmab011 name="input.g.page1.rmab011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmbb_d[l_ac].rmab012,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmab012
            END IF 
 
 
 
            #add-point:AFTER FIELD rmab012 name="input.a.page1.rmab012"
            IF NOT cl_null(g_rmbb_d[l_ac].rmab012) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab012
            #add-point:BEFORE FIELD rmab012 name="input.b.page1.rmab012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab012
            #add-point:ON CHANGE rmab012 name="input.g.page1.rmab012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab013
            #add-point:BEFORE FIELD rmab013 name="input.b.page1.rmab013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab013
            
            #add-point:AFTER FIELD rmab013 name="input.a.page1.rmab013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab013
            #add-point:ON CHANGE rmab013 name="input.g.page1.rmab013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmab017
            #add-point:BEFORE FIELD rmab017 name="input.b.page1.rmab017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmab017
            
            #add-point:AFTER FIELD rmab017 name="input.a.page1.rmab017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmab017
            #add-point:ON CHANGE rmab017 name="input.g.page1.rmab017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb003
            #add-point:BEFORE FIELD rmbb003 name="input.b.page1.rmbb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb003
            
            #add-point:AFTER FIELD rmbb003 name="input.a.page1.rmbb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbb003
            #add-point:ON CHANGE rmbb003 name="input.g.page1.rmbb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb001
            #add-point:BEFORE FIELD rmbb001 name="input.b.page1.rmbb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb001
            
            #add-point:AFTER FIELD rmbb001 name="input.a.page1.rmbb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbb001
            #add-point:ON CHANGE rmbb001 name="input.g.page1.rmbb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb002
            #add-point:BEFORE FIELD rmbb002 name="input.b.page1.rmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb002
            
            #add-point:AFTER FIELD rmbb002 name="input.a.page1.rmbb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbb002
            #add-point:ON CHANGE rmbb002 name="input.g.page1.rmbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srmbb002
            #add-point:BEFORE FIELD srmbb002 name="input.b.page1.srmbb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srmbb002
            
            #add-point:AFTER FIELD srmbb002 name="input.a.page1.srmbb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srmbb002
            #add-point:ON CHANGE srmbb002 name="input.g.page1.srmbb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb004
            #add-point:BEFORE FIELD rmbb004 name="input.b.page1.rmbb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb004
            
            #add-point:AFTER FIELD rmbb004 name="input.a.page1.rmbb004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbb004
            #add-point:ON CHANGE rmbb004 name="input.g.page1.rmbb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbb005
            #add-point:BEFORE FIELD rmbb005 name="input.b.page1.rmbb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbb005
            
            #add-point:AFTER FIELD rmbb005 name="input.a.page1.rmbb005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbb005
            #add-point:ON CHANGE rmbb005 name="input.g.page1.rmbb005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.rmbbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbbsite
            #add-point:ON ACTION controlp INFIELD rmbbsite name="input.c.page1.rmbbsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbbseq
            #add-point:ON ACTION controlp INFIELD rmbbseq name="input.c.page1.rmbbseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab018
            #add-point:ON ACTION controlp INFIELD rmab018 name="input.c.page1.rmab018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab019
            #add-point:ON ACTION controlp INFIELD rmab019 name="input.c.page1.rmab019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab020
            #add-point:ON ACTION controlp INFIELD rmab020 name="input.c.page1.rmab020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab009
            #add-point:ON ACTION controlp INFIELD rmab009 name="input.c.page1.rmab009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab010
            #add-point:ON ACTION controlp INFIELD rmab010 name="input.c.page1.rmab010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab011
            #add-point:ON ACTION controlp INFIELD rmab011 name="input.c.page1.rmab011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab012
            #add-point:ON ACTION controlp INFIELD rmab012 name="input.c.page1.rmab012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab013
            #add-point:ON ACTION controlp INFIELD rmab013 name="input.c.page1.rmab013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmab017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmab017
            #add-point:ON ACTION controlp INFIELD rmab017 name="input.c.page1.rmab017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb003
            #add-point:ON ACTION controlp INFIELD rmbb003 name="input.c.page1.rmbb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb001
            #add-point:ON ACTION controlp INFIELD rmbb001 name="input.c.page1.rmbb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb002
            #add-point:ON ACTION controlp INFIELD rmbb002 name="input.c.page1.rmbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srmbb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srmbb002
            #add-point:ON ACTION controlp INFIELD srmbb002 name="input.c.page1.srmbb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb004
            #add-point:ON ACTION controlp INFIELD rmbb004 name="input.c.page1.rmbb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.rmbb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbb005
            #add-point:ON ACTION controlp INFIELD rmbb005 name="input.c.page1.rmbb005"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmbb_d[l_ac].* = g_rmbb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_rmbb_d[l_ac].rmbbseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_rmbb_d[l_ac].* = g_rmbb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL armt200_rmbb_t_mask_restore('restore_mask_o')
      
               UPDATE rmbb_t SET (rmbbdocno,rmbb000,rmbbsite,rmbbseq,rmbb003,rmbb001,rmbb002,rmbb004, 
                   rmbb005) = (g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[l_ac].rmbbsite,g_rmbb_d[l_ac].rmbbseq, 
                   g_rmbb_d[l_ac].rmbb003,g_rmbb_d[l_ac].rmbb001,g_rmbb_d[l_ac].rmbb002,g_rmbb_d[l_ac].rmbb004, 
                   g_rmbb_d[l_ac].rmbb005)
                WHERE rmbbent = g_enterprise AND rmbbdocno = g_rmba_m.rmbadocno 
                  AND rmbb000 = g_rmba_m.rmba000 
 
                  AND rmbbseq = g_rmbb_d_t.rmbbseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmbb_d[l_ac].* = g_rmbb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbb_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmbb_d[l_ac].* = g_rmbb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys_bak[1] = g_rmbadocno_t
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys_bak[2] = g_rmba000_t
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys_bak[3] = g_rmbb_d_t.rmbbseq
               CALL armt200_update_b('rmbb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL armt200_rmbb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_rmbb_d[g_detail_idx].rmbbseq = g_rmbb_d_t.rmbbseq 
 
                  ) THEN
                  LET gs_keys[01] = g_rmba_m.rmbadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_rmba_m.rmba000
 
                  LET gs_keys[gs_keys.getLength()+1] = g_rmbb_d_t.rmbbseq
 
                  CALL armt200_key_update_b(gs_keys,'rmbb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb_d_t)
               LET g_log2 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL armt200_unlock_b("rmbb_t","'1'")
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
               LET g_rmbb_d[li_reproduce_target].* = g_rmbb_d[li_reproduce].*
 
               LET g_rmbb_d[li_reproduce_target].rmbbseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmbb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmbb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
      INPUT ARRAY g_rmbb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_rmbb_d.getLength() = 0 THEN
               NEXT FIELD rmbbseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_rmbb_d[g_detail_idx].rmbbseq) THEN
               NEXT FIELD rmbbseq
            END IF
            #add-point:資料輸入前 name="input.body2.before_input2"
            CALL armt200_b_fill2('2')  #add by lixh 20150810
            CALL armt200_b_fill2('3')  #add by lixh 20150810
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmbb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_rmbb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rmbb2_d[l_ac].* TO NULL 
            INITIALIZE g_rmbb2_d_t.* TO NULL 
            INITIALIZE g_rmbb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_rmbb2_d[l_ac].rmbc004 = "0"
      LET g_rmbb2_d[l_ac].rmbc005 = "0"
      LET g_rmbb2_d[l_ac].rmbc006 = "0"
      LET g_rmbb2_d[l_ac].rmbc008 = "0"
      LET g_rmbb2_d[l_ac].rmbc007 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            SELECT MAX(rmbcseq1)+1 INTO g_rmbb2_d[l_ac].rmbcseq1 FROM rmbc_t 
             WHERE rmbcent = g_enterprise
               AND rmbcsite = g_site
               AND rmbcdocno = g_rmba_m.rmbadocno
               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
               AND rmbc000 = g_rmba_m.rmba000
            IF cl_null(g_rmbb2_d[l_ac].rmbcseq1) THEN
               LET g_rmbb2_d[l_ac].rmbcseq1 = 1
            END IF     
            LET g_rmbb2_d[l_ac].rmbcsite = g_site            
            #end add-point
            LET g_rmbb2_d_t.* = g_rmbb2_d[l_ac].*     #新輸入資料
            LET g_rmbb2_d_o.* = g_rmbb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL armt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmbb2_d[li_reproduce_target].* = g_rmbb2_d[li_reproduce].*
 
               LET g_rmbb2_d[li_reproduce_target].rmbcseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[2] = l_ac
            LET g_current_page = 2
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN armt200_bcl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq 
 
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CLOSE armt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmbb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmbb2_d[l_ac].rmbcseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rmbb2_d_t.* = g_rmbb2_d[l_ac].*  #BACKUP
               LET g_rmbb2_d_o.* = g_rmbb2_d[l_ac].*  #BACKUP
               CALL armt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL armt200_set_no_entry_b(l_cmd)
               IF NOT armt200_lock_b("rmbc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt200_bcl2 INTO g_rmbb2_d[l_ac].rmbcsite,g_rmbb2_d[l_ac].rmbcseq1,g_rmbb2_d[l_ac].rmbc001, 
                      g_rmbb2_d[l_ac].rmbc002,g_rmbb2_d[l_ac].rmbc003,g_rmbb2_d[l_ac].rmbc004,g_rmbb2_d[l_ac].rmbc005, 
                      g_rmbb2_d[l_ac].rmbc006,g_rmbb2_d[l_ac].rmbc008,g_rmbb2_d[l_ac].rmbc007
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmbb2_d_mask_o[l_ac].* =  g_rmbb2_d[l_ac].*
                  CALL armt200_rmbc_t_mask()
                  LET g_rmbb2_d_mask_n[l_ac].* =  g_rmbb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt200_show()
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
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb2_d_t.rmbcseq1
 
 
               #刪除同層單身
               IF NOT armt200_delete_b('rmbc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE armt200_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
 
               LET l_count = g_rmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmbb2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM rmbc_t 
             WHERE rmbcent = g_enterprise AND rmbcdocno = g_rmba_m.rmbadocno AND rmbc000 = g_rmba_m.rmba000  
                 AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq AND rmbcseq1 = g_rmbb2_d[g_detail_idx2].rmbcseq1 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb2_d[g_detail_idx2].rmbcseq1
               CALL armt200_insert_b('rmbc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rmbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmbb2_d[l_ac].* = g_rmbb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt200_bcl2
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
               LET g_rmbb2_d[l_ac].* = g_rmbb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL armt200_rmbc_t_mask_restore('restore_mask_o')
               
               UPDATE rmbc_t SET (rmbcdocno,rmbc000,rmbcseq,rmbcsite,rmbcseq1,rmbc001,rmbc002,rmbc003, 
                   rmbc004,rmbc005,rmbc006,rmbc008,rmbc007) = (g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq, 
                   g_rmbb2_d[l_ac].rmbcsite,g_rmbb2_d[l_ac].rmbcseq1,g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002, 
                   g_rmbb2_d[l_ac].rmbc003,g_rmbb2_d[l_ac].rmbc004,g_rmbb2_d[l_ac].rmbc005,g_rmbb2_d[l_ac].rmbc006, 
                   g_rmbb2_d[l_ac].rmbc008,g_rmbb2_d[l_ac].rmbc007) #自訂欄位頁簽
                WHERE rmbcent = g_enterprise AND rmbcdocno = g_rmbadocno_t AND rmbc000 = g_rmba000_t  
                    AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq AND rmbcseq1 = g_rmbb2_d_t.rmbcseq1 
 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmbb2_d[l_ac].* = g_rmbb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmbb2_d[l_ac].* = g_rmbb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys_bak[1] = g_rmbadocno_t
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys_bak[2] = g_rmba000_t
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys_bak[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb2_d[g_detail_idx2].rmbcseq1
               LET gs_keys_bak[4] = g_rmbb2_d_t.rmbcseq1
               CALL armt200_update_b('rmbc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL armt200_rmbc_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb2_d_t)
               LET g_log2 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbcsite
            #add-point:BEFORE FIELD rmbcsite name="input.b.page2.rmbcsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbcsite
            
            #add-point:AFTER FIELD rmbcsite name="input.a.page2.rmbcsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbcsite
            #add-point:ON CHANGE rmbcsite name="input.g.page2.rmbcsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbcseq1
            #add-point:BEFORE FIELD rmbcseq1 name="input.b.page2.rmbcseq1"
            IF l_cmd = 'a' THEN
               SELECT MAX(rmbcseq1)+1 INTO g_rmbb2_d[l_ac].rmbcseq1 FROM rmbc_t 
                WHERE rmbcent = g_enterprise
                  AND rmbcsite = g_site
                  AND rmbcdocno = g_rmba_m.rmbadocno
                  AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
                  AND rmbc000 = g_rmba_m.rmba000
               IF cl_null(g_rmbb2_d[l_ac].rmbcseq1) THEN
                  LET g_rmbb2_d[l_ac].rmbcseq1 = 1
               END IF     
               LET g_rmbb2_d[l_ac].rmbcsite = g_site             
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbcseq1
            
            #add-point:AFTER FIELD rmbcseq1 name="input.a.page2.rmbcseq1"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmba_m.rmbadocno IS NOT NULL AND g_rmba_m.rmba000 IS NOT NULL AND g_rmbb_d[g_detail_idx].rmbbseq IS NOT NULL AND g_rmbb2_d[g_detail_idx2].rmbcseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmba_m.rmbadocno != g_rmbadocno_t OR g_rmba_m.rmba000 != g_rmba000_t OR g_rmbb_d[g_detail_idx].rmbbseq != g_rmbb_d[g_detail_idx].rmbbseq OR g_rmbb2_d[g_detail_idx2].rmbcseq1 != g_rmbb2_d_t.rmbcseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmbc_t WHERE "||"rmbcent = '" ||g_enterprise|| "' AND "||"rmbcdocno = '"||g_rmba_m.rmbadocno ||"' AND "|| "rmbcseq = '"||g_rmba_m.rmba000 ||"' AND "|| "rmbc000 = '"||g_rmbb_d[g_detail_idx].rmbbseq ||"' AND "|| "rmbcseq1 = '"||g_rmbb2_d[g_detail_idx2].rmbcseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbcseq1
            #add-point:ON CHANGE rmbcseq1 name="input.g.page2.rmbcseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc001
            
            #add-point:AFTER FIELD rmbc001 name="input.a.page2.rmbc001"

            CALL s_desc_get_item_desc(g_rmbb2_d[l_ac].rmbc001) RETURNING g_rmbb2_d[l_ac].rmbc001_desc,g_rmbb2_d[l_ac].rmbc001_desc_desc
            IF NOT cl_null(g_rmbb2_d[l_ac].rmbc001) THEN
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmbb2_d[l_ac].rmbc001
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_imaf001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmbb2_d[l_ac].rmbc001 = g_rmbb2_d_t.rmbc001
                  CALL s_desc_get_item_desc(g_rmbb2_d[l_ac].rmbc001) RETURNING g_rmbb2_d[l_ac].rmbc001_desc,g_rmbb2_d[l_ac].rmbc001_desc_desc
                  NEXT FIELD CURRENT
               END IF
               CALL armt200_set_entry_b(l_cmd)
               CALL armt200_set_no_entry_b(l_cmd)
               IF g_rmbb2_d_o.rmbc001 <> g_rmbb2_d[l_ac].rmbc001 OR g_rmbb2_d_o.rmbc001 IS NULL THEN
                  SELECT imae081 INTO g_rmbb2_d[l_ac].rmbc003 FROM imae_t
                   WHERE imaeent = g_enterprise
                     AND imaesite = g_site
                     AND imae001 = g_rmbb2_d[l_ac].rmbc001
                  CALL s_desc_get_unit_desc(g_rmbb2_d[l_ac].rmbc003) RETURNING g_rmbb2_d[l_ac].rmbc003_desc
               END IF
            END IF
            LET g_rmbb2_d_o.rmbc001 = g_rmbb2_d[l_ac].rmbc001
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc001
            #add-point:BEFORE FIELD rmbc001 name="input.b.page2.rmbc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc001
            #add-point:ON CHANGE rmbc001 name="input.g.page2.rmbc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc002
            
            #add-point:AFTER FIELD rmbc002 name="input.a.page2.rmbc002"
            CALL s_feature_description(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002)
                 RETURNING r_success,g_rmbb2_d[l_ac].rmbc002_desc
            IF NOT cl_null(g_rmbb2_d[l_ac].rmbc002) THEN
               IF NOT s_feature_check(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002) THEN
                  LET g_rmbb2_d[l_ac].rmbc002 = g_rmbb2_d_t.rmbc002
                  CALL s_feature_description(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002)
                       RETURNING r_success,g_rmbb2_d[l_ac].rmbc002_desc
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#3 add start ------------------------
               IF NOT s_feature_direct_input(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002,g_rmbb2_d_t.rmbc002,'ALL','') THEN
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#3 add end   ------------------------
            END IF
            CALL s_feature_description(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002)
                 RETURNING r_success,g_rmbb2_d[l_ac].rmbc002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc002
            #add-point:BEFORE FIELD rmbc002 name="input.b.page2.rmbc002"
            #160314-00009#16 add(s)
            IF s_feature_auto_chk(g_rmbb2_d[l_ac].rmbc001) AND cl_null(g_rmbb2_d[l_ac].rmbc002) THEN
               CALL s_feature_single(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002,'ALL','')
                  RETURNING r_success,g_rmbb2_d[l_ac].rmbc002
               CALL s_feature_description(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002)
                 RETURNING r_success,g_rmbb2_d[l_ac].rmbc002_desc
            END IF
            #160314-00009#16 add(e)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc002
            #add-point:ON CHANGE rmbc002 name="input.g.page2.rmbc002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc003
            
            #add-point:AFTER FIELD rmbc003 name="input.a.page2.rmbc003"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmbb2_d[l_ac].rmbc003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmbb2_d[l_ac].rmbc003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmbb2_d[l_ac].rmbc003_desc

            IF NOT cl_null(g_rmbb2_d[l_ac].rmbc003) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#33  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmbb2_d[l_ac].rmbc003
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"  #160318-00025#33  add
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME
               ELSE
                  #檢查失敗時後續處理
                  LET g_rmbb2_d[l_ac].rmbc003 = g_rmbb2_d_t.rmbc003
                  CALL s_desc_get_unit_desc(g_rmbb2_d[l_ac].rmbc003) RETURNING g_rmbb2_d[l_ac].rmbc003_desc
                  NEXT FIELD CURRENT
               END IF
               #單位是否允許使用
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_rmbb2_d[l_ac].rmbc001    
               LET g_chkparam.arg2 = g_rmbb2_d[l_ac].rmbc003               
               IF NOT cl_chk_exist("v_imao002") THEN
                  LET g_rmbb2_d[l_ac].rmbc003 = g_rmbb2_d_t.rmbc003
                  CALL s_desc_get_unit_desc(g_rmbb2_d[l_ac].rmbc003) RETURNING g_rmbb2_d[l_ac].rmbc003_desc
                  NEXT FIELD CURRENT
               END IF                  
               SELECT imaa006 INTO l_imaa006 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = g_rmbb2_d[l_ac].rmbc001

               CALL s_aimi190_get_convert(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc003,l_imaa006) RETURNING r_success,r_rate
               IF NOT r_success THEN
                  LET g_rmbb2_d[l_ac].rmbc003 = g_rmbb2_d_t.rmbc003
                  CALL s_desc_get_unit_desc(g_rmbb2_d[l_ac].rmbc003) RETURNING g_rmbb2_d[l_ac].rmbc003_desc
                  NEXT FIELD CURRENT
               END IF
            
            END IF

            CALL s_desc_get_unit_desc(g_rmbb2_d[l_ac].rmbc003) RETURNING g_rmbb2_d[l_ac].rmbc003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc003
            #add-point:BEFORE FIELD rmbc003 name="input.b.page2.rmbc003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc003
            #add-point:ON CHANGE rmbc003 name="input.g.page2.rmbc003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc004
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmbb2_d[l_ac].rmbc004,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmbc004
            END IF 
 
 
 
            #add-point:AFTER FIELD rmbc004 name="input.a.page2.rmbc004"
            IF NOT cl_null(g_rmbb2_d[l_ac].rmbc004) THEN 
               CALL s_axmt500_get_amount(g_rmba_m.rmbadocno,g_rmbb_d[g_detail_idx].rmbbseq,g_rmbb2_d[l_ac].rmbc004,g_rmbb2_d[l_ac].rmbc005,
                                       g_rmba_m.rmba006,g_rmba_m.rmba010,g_rmba_m.rmba011)
                             RETURNING g_rmbb2_d[l_ac].rmbc006,g_rmbb2_d[l_ac].rmbc007,g_rmbb2_d[l_ac].rmbc008            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc004
            #add-point:BEFORE FIELD rmbc004 name="input.b.page2.rmbc004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc004
            #add-point:ON CHANGE rmbc004 name="input.g.page2.rmbc004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc005
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmbb2_d[l_ac].rmbc005,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmbc005
            END IF 
 
 
 
            #add-point:AFTER FIELD rmbc005 name="input.a.page2.rmbc005"
            IF NOT cl_null(g_rmbb2_d[l_ac].rmbc005) THEN 
               CALL s_axmt500_get_amount(g_rmba_m.rmbadocno,g_rmbb_d[g_detail_idx].rmbbseq,g_rmbb2_d[l_ac].rmbc004,g_rmbb2_d[l_ac].rmbc005,
                                       g_rmba_m.rmba006,g_rmba_m.rmba010,g_rmba_m.rmba011)
                             RETURNING g_rmbb2_d[l_ac].rmbc006,g_rmbb2_d[l_ac].rmbc007,g_rmbb2_d[l_ac].rmbc008            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc005
            #add-point:BEFORE FIELD rmbc005 name="input.b.page2.rmbc005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc005
            #add-point:ON CHANGE rmbc005 name="input.g.page2.rmbc005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc006
            #add-point:BEFORE FIELD rmbc006 name="input.b.page2.rmbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc006
            
            #add-point:AFTER FIELD rmbc006 name="input.a.page2.rmbc006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc006
            #add-point:ON CHANGE rmbc006 name="input.g.page2.rmbc006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc008
            #add-point:BEFORE FIELD rmbc008 name="input.b.page2.rmbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc008
            
            #add-point:AFTER FIELD rmbc008 name="input.a.page2.rmbc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc008
            #add-point:ON CHANGE rmbc008 name="input.g.page2.rmbc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbc007
            #add-point:BEFORE FIELD rmbc007 name="input.b.page2.rmbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbc007
            
            #add-point:AFTER FIELD rmbc007 name="input.a.page2.rmbc007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbc007
            #add-point:ON CHANGE rmbc007 name="input.g.page2.rmbc007"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.rmbcsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbcsite
            #add-point:ON ACTION controlp INFIELD rmbcsite name="input.c.page2.rmbcsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbcseq1
            #add-point:ON ACTION controlp INFIELD rmbcseq1 name="input.c.page2.rmbcseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc001
            #add-point:ON ACTION controlp INFIELD rmbc001 name="input.c.page2.rmbc001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmbb2_d[l_ac].rmbc001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_imaf001_15()                                #呼叫開窗

            LET g_rmbb2_d[l_ac].rmbc001 = g_qryparam.return1              

            DISPLAY g_rmbb2_d[l_ac].rmbc001 TO rmbc001              #

            NEXT FIELD rmbc001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc002
            #add-point:ON ACTION controlp INFIELD rmbc002 name="input.c.page2.rmbc002"
            LET g_rmbb2_d_t.rmbc002 = g_rmbb2_d[l_ac].rmbc002
            CALL s_feature_single(g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002,'ALL','')
               RETURNING r_success,g_rmbb2_d[l_ac].rmbc002
            IF cl_null(g_rmbb2_d[l_ac].rmbc002) THEN
               LET g_rmbb2_d[l_ac].rmbc002 = g_rmbb2_d_t.rmbc002
            END IF
            DISPLAY g_rmbb2_d[l_ac].rmbc002 TO rmbc002
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc003
            #add-point:ON ACTION controlp INFIELD rmbc003 name="input.c.page2.rmbc003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmbb2_d[l_ac].rmbc003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_rmbb2_d[l_ac].rmbc003 = g_qryparam.return1              

            DISPLAY g_rmbb2_d[l_ac].rmbc003 TO rmbc003              #

            NEXT FIELD rmbc003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc004
            #add-point:ON ACTION controlp INFIELD rmbc004 name="input.c.page2.rmbc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc005
            #add-point:ON ACTION controlp INFIELD rmbc005 name="input.c.page2.rmbc005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc006
            #add-point:ON ACTION controlp INFIELD rmbc006 name="input.c.page2.rmbc006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc008
            #add-point:ON ACTION controlp INFIELD rmbc008 name="input.c.page2.rmbc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.rmbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbc007
            #add-point:ON ACTION controlp INFIELD rmbc007 name="input.c.page2.rmbc007"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2_after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rmbb2_d[l_ac].* = g_rmbb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt200_bcl2
               CLOSE armt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL armt200_unlock_b("rmbc_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2_after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            #2016-2-22 zhujing mod-----(S)
#            SELECT SUM(rmbc007) INTO g_rmbb_d[g_detail_idx].rmbb001 FROM rmbc_t
            SELECT SUM(rmbc007),SUM(rmbc006) 
              INTO g_rmbb_d[g_detail_idx].rmbb001,l_rmbb001 FROM rmbc_t
             WHERE rmbcent = g_enterprise
               AND rmbcsite = g_site
               AND rmbcdocno = g_rmba_m.rmbadocno
               AND rmbc000 = g_rmba_m.rmba000
               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
            SELECT SUM(rmbd005),SUM(rmbd004) 
              INTO g_rmbb_d[g_detail_idx].rmbb002,l_rmbb002 FROM rmbd_t            
             WHERE rmbdent = g_enterprise
               AND rmbdsite = g_site
               AND rmbddocno = g_rmba_m.rmbadocno
               AND rmbd000 = g_rmba_m.rmba000
               AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb001) THEN LET g_rmbb_d[g_detail_idx].rmbb001 = 0 END IF
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb002) THEN LET g_rmbb_d[g_detail_idx].rmbb002 = 0 END IF
            IF cl_null(l_rmbb001) THEN LET l_rmbb001 = 0 END IF      #2016-2-22 zhujing add
            IF cl_null(l_rmbb002) THEN LET l_rmbb002 = 0 END IF      #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].srmbb002 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002                 
            LET g_rmbb_d[g_detail_idx].rmbb005 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002    #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].rmbb004 = l_rmbb001 + l_rmbb002    #2016-2-22 zhujing add
            IF g_rmbb_d[g_detail_idx].rmab013 IS NOT NULL OR g_rmbb_d[g_detail_idx].rmab013 <> 0 THEN
               IF g_rmba_m.rmba008 = 'Y' THEN   #含税 单价=含税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb005/g_rmbb_d[g_detail_idx].rmab013
               ELSE                             #未税 单价=未税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb004/g_rmbb_d[g_detail_idx].rmab013
               END IF
            END IF
            UPDATE rmbb_t 
              SET rmbb001 = g_rmbb_d[g_detail_idx].rmbb001,
                  rmbb003 = g_rmbb_d[g_detail_idx].rmbb003,    #2016-2-22 zhujing add
                  rmbb004 = g_rmbb_d[g_detail_idx].rmbb004,    #2016-2-22 zhujing add
                  rmbb005 = g_rmbb_d[g_detail_idx].rmbb005     #2016-2-22 zhujing add
             WHERE rmbbent = g_enterprise
               AND rmbbsite = g_site
               AND rmbbdocno = g_rmba_m.rmbadocno
               AND rmbb000 = g_rmba_m.rmba000
               AND rmbbseq = g_rmbb_d[g_detail_idx].rmbbseq 
            #2016-2-22 zhujing mod-----(E)               
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rmbb2_d[li_reproduce_target].* = g_rmbb2_d[li_reproduce].*
 
               LET g_rmbb2_d[li_reproduce_target].rmbcseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmbb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmbb2_d.getLength()+1
            END IF
        
      END INPUT
      INPUT ARRAY g_rmbb3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
        
         BEFORE INPUT
            #先將上層單身的idx放入g_detail_idx
            LET g_detail_idx_tmp = g_detail_idx
            LET g_detail_idx = g_detail_idx_list[1]
            #檢查上層單身是否為空
            IF g_detail_idx = 0 OR g_rmbb_d.getLength() = 0 THEN
               NEXT FIELD rmbbseq
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_rmbb_d[g_detail_idx].rmbbseq) THEN
               NEXT FIELD rmbbseq
            END IF
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_rmbb3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_rmbb3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_rmbb3_d[l_ac].* TO NULL 
            INITIALIZE g_rmbb3_d_t.* TO NULL 
            INITIALIZE g_rmbb3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_rmbb3_d[l_ac].rmbd002 = "0"
      LET g_rmbb3_d[l_ac].rmbd003 = "0"
      LET g_rmbb3_d[l_ac].rmbd004 = "0"
      LET g_rmbb3_d[l_ac].rmbd006 = "0"
      LET g_rmbb3_d[l_ac].rmbd005 = "0"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            SELECT MAX(rmbdseq1)+1 INTO g_rmbb3_d[l_ac].rmbdseq1 FROM rmbd_t 
             WHERE rmbdent = g_enterprise
               AND rmbdsite = g_site
               AND rmbddocno = g_rmba_m.rmbadocno
               AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq
               AND rmbd000 = g_rmba_m.rmba000
            IF cl_null(g_rmbb3_d[l_ac].rmbdseq1) THEN
               LET g_rmbb3_d[l_ac].rmbdseq1 = 1
            END IF     
            LET g_rmbb3_d[l_ac].rmbdsite = g_site 
            #end add-point
            LET g_rmbb3_d_t.* = g_rmbb3_d[l_ac].*     #新輸入資料
            LET g_rmbb3_d_o.* = g_rmbb3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL armt200_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL armt200_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_rmbb3_d[li_reproduce_target].* = g_rmbb3_d[li_reproduce].*
 
               LET g_rmbb3_d[li_reproduce_target].rmbdseq1 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body3.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET g_detail_idx_list[3] = l_ac
            LET g_current_page = 3
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN armt200_bcl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq 
 
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN armt200_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE armt200_cl
               CLOSE armt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_rmbb3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_rmbb3_d[l_ac].rmbdseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_rmbb3_d_t.* = g_rmbb3_d[l_ac].*  #BACKUP
               LET g_rmbb3_d_o.* = g_rmbb3_d[l_ac].*  #BACKUP
               CALL armt200_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL armt200_set_no_entry_b(l_cmd)
               IF NOT armt200_lock_b("rmbd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH armt200_bcl3 INTO g_rmbb3_d[l_ac].rmbdsite,g_rmbb3_d[l_ac].rmbdseq1,g_rmbb3_d[l_ac].rmbd001, 
                      g_rmbb3_d[l_ac].rmbd002,g_rmbb3_d[l_ac].rmbd003,g_rmbb3_d[l_ac].rmbd004,g_rmbb3_d[l_ac].rmbd006, 
                      g_rmbb3_d[l_ac].rmbd005
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_rmbb3_d_mask_o[l_ac].* =  g_rmbb3_d[l_ac].*
                  CALL armt200_rmbd_t_mask()
                  LET g_rmbb3_d_mask_n[l_ac].* =  g_rmbb3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL armt200_show()
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
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb3_d_t.rmbdseq1
 
 
               #刪除同層單身
               IF NOT armt200_delete_b('rmbd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE armt200_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE armt200_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
 
               LET l_count = g_rmbb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_rmbb3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM rmbd_t 
             WHERE rmbdent = g_enterprise AND rmbddocno = g_rmba_m.rmbadocno AND rmbd000 = g_rmba_m.rmba000  
                 AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq AND rmbdseq1 = g_rmbb3_d[g_detail_idx2].rmbdseq1 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb3_d[g_detail_idx2].rmbdseq1
               CALL armt200_insert_b('rmbd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_rmbb_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL armt200_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
            #還原g_detail_idx
            LET g_detail_idx = g_detail_idx_tmp
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_rmbb3_d[l_ac].* = g_rmbb3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt200_bcl3
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
               LET g_rmbb3_d[l_ac].* = g_rmbb3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL armt200_rmbd_t_mask_restore('restore_mask_o')
               
               UPDATE rmbd_t SET (rmbddocno,rmbd000,rmbdseq,rmbdsite,rmbdseq1,rmbd001,rmbd002,rmbd003, 
                   rmbd004,rmbd006,rmbd005) = (g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq, 
                   g_rmbb3_d[l_ac].rmbdsite,g_rmbb3_d[l_ac].rmbdseq1,g_rmbb3_d[l_ac].rmbd001,g_rmbb3_d[l_ac].rmbd002, 
                   g_rmbb3_d[l_ac].rmbd003,g_rmbb3_d[l_ac].rmbd004,g_rmbb3_d[l_ac].rmbd006,g_rmbb3_d[l_ac].rmbd005)  
                   #自訂欄位頁簽
                WHERE rmbdent = g_enterprise AND rmbddocno = g_rmbadocno_t AND rmbd000 = g_rmba000_t  
                    AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq AND rmbdseq1 = g_rmbb3_d_t.rmbdseq1 
 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_rmbb3_d[l_ac].* = g_rmbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_rmbb3_d[l_ac].* = g_rmbb3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_rmba_m.rmbadocno
               LET gs_keys_bak[1] = g_rmbadocno_t
               LET gs_keys[2] = g_rmba_m.rmba000
               LET gs_keys_bak[2] = g_rmba000_t
               LET gs_keys[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys_bak[3] = g_rmbb_d[g_detail_idx].rmbbseq
               LET gs_keys[4] = g_rmbb3_d[g_detail_idx2].rmbdseq1
               LET gs_keys_bak[4] = g_rmbb3_d_t.rmbdseq1
               CALL armt200_update_b('rmbd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL armt200_rmbd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb3_d_t)
               LET g_log2 = util.JSON.stringify(g_rmba_m),util.JSON.stringify(g_rmbb3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbdsite
            #add-point:BEFORE FIELD rmbdsite name="input.b.page3.rmbdsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbdsite
            
            #add-point:AFTER FIELD rmbdsite name="input.a.page3.rmbdsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbdsite
            #add-point:ON CHANGE rmbdsite name="input.g.page3.rmbdsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbdseq1
            #add-point:BEFORE FIELD rmbdseq1 name="input.b.page3.rmbdseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbdseq1
            
            #add-point:AFTER FIELD rmbdseq1 name="input.a.page3.rmbdseq1"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_rmba_m.rmbadocno IS NOT NULL AND g_rmba_m.rmba000 IS NOT NULL AND g_rmbb_d[g_detail_idx].rmbbseq IS NOT NULL AND g_rmbb3_d[g_detail_idx2].rmbdseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rmba_m.rmbadocno != g_rmbadocno_t OR g_rmba_m.rmba000 != g_rmba000_t OR g_rmbb_d[g_detail_idx].rmbbseq != g_rmbb_d[g_detail_idx].rmbbseq OR g_rmbb3_d[g_detail_idx2].rmbdseq1 != g_rmbb3_d_t.rmbdseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rmbd_t WHERE "||"rmbdent = '" ||g_enterprise|| "' AND "||"rmbddocno = '"||g_rmba_m.rmbadocno ||"' AND "|| "rmbdseq = '"||g_rmba_m.rmba000 ||"' AND "|| "rmbd000 = '"||g_rmbb_d[g_detail_idx].rmbbseq ||"' AND "|| "rmbdseq1 = '"||g_rmbb3_d[g_detail_idx2].rmbdseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbdseq1
            #add-point:ON CHANGE rmbdseq1 name="input.g.page3.rmbdseq1"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd001
            
            #add-point:AFTER FIELD rmbd001 name="input.a.page3.rmbd001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_rmbb3_d[l_ac].rmbd001
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1131' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_rmbb3_d[l_ac].rmbd001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rmbb3_d[l_ac].rmbd001_desc
            IF NOT cl_null(g_rmbb3_d[l_ac].rmbd001) THEN
               IF NOT s_azzi650_chk_exist('1131',g_rmbb3_d[l_ac].rmbd001) THEN
                  LET g_rmbb3_d[l_ac].rmbd001 = g_rmbb3_d_t.rmbd001
                  CALL s_desc_get_acc_desc('1131',g_rmbb3_d[l_ac].rmbd001) RETURNING g_rmbb3_d[l_ac].rmbd001_desc
                  NEXT FIELD rmbd001
               END IF
            END IF
            CALL s_desc_get_acc_desc('1131',g_rmbb3_d[l_ac].rmbd001) RETURNING g_rmbb3_d[l_ac].rmbd001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd001
            #add-point:BEFORE FIELD rmbd001 name="input.b.page3.rmbd001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd001
            #add-point:ON CHANGE rmbd001 name="input.g.page3.rmbd001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmbb3_d[l_ac].rmbd002,"0","0","","","azz-00079",1) THEN
               NEXT FIELD rmbd002
            END IF 
 
 
 
            #add-point:AFTER FIELD rmbd002 name="input.a.page3.rmbd002"
            IF NOT cl_null(g_rmbb3_d[l_ac].rmbd002) THEN 
               CALL s_axmt500_get_amount(g_rmba_m.rmbadocno,g_rmbb_d[g_detail_idx].rmbbseq,g_rmbb3_d[l_ac].rmbd002,g_rmbb3_d[l_ac].rmbd003,
                                       g_rmba_m.rmba006,g_rmba_m.rmba010,g_rmba_m.rmba011)
                             RETURNING g_rmbb3_d[l_ac].rmbd004,g_rmbb3_d[l_ac].rmbd005,g_rmbb3_d[l_ac].rmbd006            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd002
            #add-point:BEFORE FIELD rmbd002 name="input.b.page3.rmbd002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd002
            #add-point:ON CHANGE rmbd002 name="input.g.page3.rmbd002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd003
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_rmbb3_d[l_ac].rmbd003,"0","1","","","azz-00079",1) THEN
               NEXT FIELD rmbd003
            END IF 
 
 
 
            #add-point:AFTER FIELD rmbd003 name="input.a.page3.rmbd003"
            IF NOT cl_null(g_rmbb3_d[l_ac].rmbd003) THEN 
               CALL s_axmt500_get_amount(g_rmba_m.rmbadocno,g_rmbb_d[g_detail_idx].rmbbseq,g_rmbb3_d[l_ac].rmbd002,g_rmbb3_d[l_ac].rmbd003,
                                       g_rmba_m.rmba006,g_rmba_m.rmba010,g_rmba_m.rmba011)
                             RETURNING g_rmbb3_d[l_ac].rmbd004,g_rmbb3_d[l_ac].rmbd005,g_rmbb3_d[l_ac].rmbd006            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd003
            #add-point:BEFORE FIELD rmbd003 name="input.b.page3.rmbd003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd003
            #add-point:ON CHANGE rmbd003 name="input.g.page3.rmbd003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd004
            #add-point:BEFORE FIELD rmbd004 name="input.b.page3.rmbd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd004
            
            #add-point:AFTER FIELD rmbd004 name="input.a.page3.rmbd004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd004
            #add-point:ON CHANGE rmbd004 name="input.g.page3.rmbd004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd006
            #add-point:BEFORE FIELD rmbd006 name="input.b.page3.rmbd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd006
            
            #add-point:AFTER FIELD rmbd006 name="input.a.page3.rmbd006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd006
            #add-point:ON CHANGE rmbd006 name="input.g.page3.rmbd006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmbd005
            #add-point:BEFORE FIELD rmbd005 name="input.b.page3.rmbd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmbd005
            
            #add-point:AFTER FIELD rmbd005 name="input.a.page3.rmbd005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rmbd005
            #add-point:ON CHANGE rmbd005 name="input.g.page3.rmbd005"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.rmbdsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbdsite
            #add-point:ON ACTION controlp INFIELD rmbdsite name="input.c.page3.rmbdsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbdseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbdseq1
            #add-point:ON ACTION controlp INFIELD rmbdseq1 name="input.c.page3.rmbdseq1"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd001
            #add-point:ON ACTION controlp INFIELD rmbd001 name="input.c.page3.rmbd001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_rmbb3_d[l_ac].rmbd001             #給予default值
            LET g_qryparam.default2 = "" #g_rmbb3_d[l_ac].oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = '1131'


            CALL q_oocq002()                                #呼叫開窗

            LET g_rmbb3_d[l_ac].rmbd001 = g_qryparam.return1              
            #LET g_rmbb3_d[l_ac].oocql004 = g_qryparam.return2 
            DISPLAY g_rmbb3_d[l_ac].rmbd001 TO rmbd001              #
            #DISPLAY g_rmbb3_d[l_ac].oocql004 TO oocql004 #說明
            NEXT FIELD rmbd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd002
            #add-point:ON ACTION controlp INFIELD rmbd002 name="input.c.page3.rmbd002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd003
            #add-point:ON ACTION controlp INFIELD rmbd003 name="input.c.page3.rmbd003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd004
            #add-point:ON ACTION controlp INFIELD rmbd004 name="input.c.page3.rmbd004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd006
            #add-point:ON ACTION controlp INFIELD rmbd006 name="input.c.page3.rmbd006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.rmbd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmbd005
            #add-point:ON ACTION controlp INFIELD rmbd005 name="input.c.page3.rmbd005"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3_after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_rmbb3_d[l_ac].* = g_rmbb3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE armt200_bcl3
               CLOSE armt200_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL armt200_unlock_b("rmbd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3_after_row2 name="input.body3.after_row2"
 
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            #2016-2-22 zhujing mod-----(S) 
#            SELECT SUM(rmbd005) INTO g_rmbb_d[g_detail_idx].rmbb002 FROM rmbd_t
            SELECT SUM(rmbc007),SUM(rmbc006) 
              INTO g_rmbb_d[g_detail_idx].rmbb001,l_rmbb001 FROM rmbc_t
             WHERE rmbcent = g_enterprise
               AND rmbcsite = g_site
               AND rmbcdocno = g_rmba_m.rmbadocno
               AND rmbc000 = g_rmba_m.rmba000
               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
            SELECT SUM(rmbd005),SUM(rmbd004) 
              INTO g_rmbb_d[g_detail_idx].rmbb002,l_rmbb002 FROM rmbd_t            
             WHERE rmbdent = g_enterprise
               AND rmbdsite = g_site
               AND rmbddocno = g_rmba_m.rmbadocno
               AND rmbd000 = g_rmba_m.rmba000
               AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb001) THEN LET g_rmbb_d[g_detail_idx].rmbb001 = 0 END IF   
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb002) THEN LET g_rmbb_d[g_detail_idx].rmbb002 = 0 END IF   
            IF cl_null(l_rmbb001) THEN LET l_rmbb001 = 0 END IF      #2016-2-22 zhujing add
            IF cl_null(l_rmbb002) THEN LET l_rmbb002 = 0 END IF      #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].srmbb002 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002                 
            LET g_rmbb_d[g_detail_idx].rmbb005 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002    #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].rmbb004 = l_rmbb001 + l_rmbb002    #2016-2-22 zhujing add
            IF g_rmbb_d[g_detail_idx].rmab013 IS NOT NULL OR g_rmbb_d[g_detail_idx].rmab013 <> 0 THEN
               IF g_rmba_m.rmba008 = 'Y' THEN   #含税 单价=含税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb005/g_rmbb_d[g_detail_idx].rmab013
               ELSE                             #未税 单价=未税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb004/g_rmbb_d[g_detail_idx].rmab013
               END IF
            END IF
            UPDATE rmbb_t 
               SET rmbb002 = g_rmbb_d[g_detail_idx].rmbb002,
                   rmbb003 = g_rmbb_d[g_detail_idx].rmbb003,    #2016-2-22 zhujing add
                   rmbb004 = g_rmbb_d[g_detail_idx].rmbb004,    #2016-2-22 zhujing add
                   rmbb005 = g_rmbb_d[g_detail_idx].rmbb005     #2016-2-22 zhujing add
             WHERE rmbbent = g_enterprise
               AND rmbbsite = g_site
               AND rmbbdocno = g_rmba_m.rmbadocno
               AND rmbb000 = g_rmba_m.rmba000
               AND rmbbseq = g_rmbb_d[g_detail_idx].rmbbseq 
            #2016-2-22 zhujing mod-----(E)   
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_rmbb3_d[li_reproduce_target].* = g_rmbb3_d[li_reproduce].*
 
               LET g_rmbb3_d[li_reproduce_target].rmbdseq1 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_rmbb3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_rmbb3_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="armt200.input.other" >}
      
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
            
            #end add-point  
            NEXT FIELD rmbadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD rmbbsite
               WHEN "s_detail2"
                  NEXT FIELD rmbcsite
               WHEN "s_detail3"
                  NEXT FIELD rmbdsite
 
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
 
{<section id="armt200.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION armt200_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL armt200_b_fill() #單身填充
      CALL armt200_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL armt200_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_rmba_m_mask_o.* =  g_rmba_m.*
   CALL armt200_rmba_t_mask()
   LET g_rmba_m_mask_n.* =  g_rmba_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
       g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
       g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba009_desc, 
       g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc, 
       g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc,g_rmba_m.rmbacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmba_m.rmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_rmbb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_rmbb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_rmbb3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL armt200_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION armt200_detail_show()
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
 
{<section id="armt200.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION armt200_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE rmba_t.rmbadocno 
   DEFINE l_oldno     LIKE rmba_t.rmbadocno 
   DEFINE l_newno02     LIKE rmba_t.rmba000 
   DEFINE l_oldno02     LIKE rmba_t.rmba000 
 
   DEFINE l_master    RECORD LIKE rmba_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE rmbb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE rmbc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE rmbd_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_rmba_m.rmbadocno IS NULL
   OR g_rmba_m.rmba000 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_rmbadocno_t = g_rmba_m.rmbadocno
   LET g_rmba000_t = g_rmba_m.rmba000
 
    
   LET g_rmba_m.rmbadocno = ""
   LET g_rmba_m.rmba000 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_rmba_m.rmbaownid = g_user
      LET g_rmba_m.rmbaowndp = g_dept
      LET g_rmba_m.rmbacrtid = g_user
      LET g_rmba_m.rmbacrtdp = g_dept 
      LET g_rmba_m.rmbacrtdt = cl_get_current()
      LET g_rmba_m.rmbamodid = g_user
      LET g_rmba_m.rmbamoddt = cl_get_current()
      LET g_rmba_m.rmbastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_rmba_m.rmbadocdt = g_today
   LET g_rmba_m.rmba002 = g_user
   LET g_rmba_m.rmba003 = g_dept
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_rmba_m.rmbastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL armt200_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_rmba_m.* TO NULL
      INITIALIZE g_rmbb_d TO NULL
      INITIALIZE g_rmbb2_d TO NULL
      INITIALIZE g_rmbb3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL armt200_show()
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
   CALL armt200_set_act_visible()   
   CALL armt200_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_rmbadocno_t = g_rmba_m.rmbadocno
   LET g_rmba000_t = g_rmba_m.rmba000
 
   
   #組合新增資料的條件
   LET g_add_browse = " rmbaent = " ||g_enterprise|| " AND",
                      " rmbadocno = '", g_rmba_m.rmbadocno, "' "
                      ," AND rmba000 = '", g_rmba_m.rmba000, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL armt200_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
        g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
        g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
        g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
        g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
        g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
        g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
        g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
        g_rmba_m.rmbacnfid_desc
   
    #將資料顯示到畫面上
    DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
        g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
        g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
        g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba009_desc, 
        g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
        g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc, 
        g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc, 
        g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc,g_rmba_m.rmbacnfdt
   #end add-point
   
   CALL armt200_idx_chk()
   
   LET g_data_owner = g_rmba_m.rmbaownid      
   LET g_data_dept  = g_rmba_m.rmbaowndp
   
   #功能已完成,通報訊息中心
   CALL armt200_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION armt200_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE rmbb_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE rmbc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE rmbd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE armt200_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   IF g_rmbadocno_t <> g_rmba_m.rmbadocno THEN
      CALL s_transaction_end('Y','0')
   
      #已新增完, 調整資料內容(修改時使用)
      LET g_rmbadocno_t = g_rmba_m.rmbadocno
      LET g_rmba000_t = g_rmba_m.rmba000   
   END IF
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmbb_t
    WHERE rmbbent = g_enterprise AND rmbbdocno = g_rmbadocno_t
     AND rmbb000 = g_rmba000_t
 
    INTO TEMP armt200_detail
 
   #將key修正為調整後   
   UPDATE armt200_detail 
      #更新key欄位
      SET rmbbdocno = g_rmba_m.rmbadocno
          , rmbb000 = g_rmba_m.rmba000
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO rmbb_t SELECT * FROM armt200_detail
   
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
   DROP TABLE armt200_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmbc_t 
    WHERE rmbcent = g_enterprise AND rmbcdocno = g_rmbadocno_t
    AND rmbc000 = g_rmba000_t   
 
    INTO TEMP armt200_detail
 
   #將key修正為調整後   
   UPDATE armt200_detail SET rmbcdocno = g_rmba_m.rmbadocno
                                       , rmbc000 = g_rmba_m.rmba000
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO rmbc_t SELECT * FROM armt200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt200_detail
   
   LET g_data_owner = g_rmba_m.rmbaownid      
   LET g_data_dept  = g_rmba_m.rmbaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM rmbd_t 
    WHERE rmbdent = g_enterprise AND rmbddocno = g_rmbadocno_t
    AND rmbd000 = g_rmba000_t   
 
    INTO TEMP armt200_detail
 
   #將key修正為調整後   
   UPDATE armt200_detail SET rmbddocno = g_rmba_m.rmbadocno
                                       , rmbd000 = g_rmba_m.rmba000
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO rmbd_t SELECT * FROM armt200_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE armt200_detail
   
   LET g_data_owner = g_rmba_m.rmbaownid      
   LET g_data_dept  = g_rmba_m.rmbaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_rmbadocno_t = g_rmba_m.rmbadocno
   LET g_rmba000_t = g_rmba_m.rmba000
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.delete" >}
#+ 資料刪除
PRIVATE FUNCTION armt200_delete()
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
   
   IF g_rmba_m.rmbadocno IS NULL
   OR g_rmba_m.rmba000 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt200_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE armt200_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT armt200_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_rmba_m_mask_o.* =  g_rmba_m.*
   CALL armt200_rmba_t_mask()
   LET g_rmba_m_mask_n.* =  g_rmba_m.*
   
   CALL armt200_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL armt200_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_rmbadocno_t = g_rmba_m.rmbadocno
      LET g_rmba000_t = g_rmba_m.rmba000
 
 
      DELETE FROM rmba_t
       WHERE rmbaent = g_enterprise AND rmbadocno = g_rmba_m.rmbadocno
         AND rmba000 = g_rmba_m.rmba000
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_rmba_m.rmbadocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM rmbb_t
       WHERE rmbbent = g_enterprise AND rmbbdocno = g_rmba_m.rmbadocno
         AND rmbb000 = g_rmba_m.rmba000
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
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
      DELETE FROM rmbc_t
       WHERE rmbcent = g_enterprise AND
             rmbcdocno = g_rmba_m.rmbadocno AND rmbc000 = g_rmba_m.rmba000
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
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
      DELETE FROM rmbd_t
       WHERE rmbdent = g_enterprise AND
             rmbddocno = g_rmba_m.rmbadocno AND rmbd000 = g_rmba_m.rmba000
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_rmba_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE armt200_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_rmbb_d.clear() 
      CALL g_rmbb2_d.clear()       
      CALL g_rmbb3_d.clear()       
 
     
      CALL armt200_ui_browser_refresh()  
      #CALL armt200_ui_headershow()  
      #CALL armt200_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL armt200_browser_fill("")
         CALL armt200_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE armt200_cl
 
   #功能已完成,通報訊息中心
   CALL armt200_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="armt200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION armt200_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success  LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_rmbb_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF armt200_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT rmbbsite,rmbbseq,rmbb003,rmbb001,rmbb002,rmbb004,rmbb005  FROM rmbb_t", 
                
                     " INNER JOIN rmba_t ON rmbaent = " ||g_enterprise|| " AND rmbadocno = rmbbdocno ",
                     " AND rmba000 = rmbb000 ",
 
                     #"",
                     " LEFT JOIN rmbc_t ON rmbbent = rmbcent AND rmbbdocno = rmbcdocno AND rmbb000 = rmbc000 AND rmbbseq = rmbcseq ",
               " LEFT JOIN rmbd_t ON rmbbent = rmbdent AND rmbbdocno = rmbddocno AND rmbb000 = rmbd000 AND rmbbseq = rmbdseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
                     " ",
 
 
                     
                     " WHERE rmbbent=? AND rmbbdocno=? AND rmbb000=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
#         LET g_sql =  " SELECT  UNIQUE rmbbsite,rmbbseq,rmbb001,rmbb002  FROM rmbb_t ",
#                      "   LEFT OUTER JOIN rmba_t ON rmbadocno = rmbbdocno  AND rmba000 = rmbb000 ",
#                      "   LEFT JOIN rmbc_t ON rmbbent = rmbcent AND rmbbdocno = rmbcdocno AND rmbbseq = rmbcseq AND rmbb000 = rmbc000 ",
#                      "   LEFT JOIN rmbd_t ON rmbbent = rmbdent AND rmbbdocno = rmbddocno AND rmbbseq = rmbdseq AND rmbb000 = rmbd000 ",
#                      "  WHERE rmbbent=? AND rmbbdocno=? AND rmbb000=?"
        
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
   IF NOT cl_null(g_wc2_table3) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table3 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY rmbb_t.rmbbseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt200_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR armt200_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmbb_d[l_ac].rmbbsite, 
          g_rmbb_d[l_ac].rmbbseq,g_rmbb_d[l_ac].rmbb003,g_rmbb_d[l_ac].rmbb001,g_rmbb_d[l_ac].rmbb002, 
          g_rmbb_d[l_ac].rmbb004,g_rmbb_d[l_ac].rmbb005   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #2016-2-22 zhujing mod-----(S)
#         SELECT rmab009,rmab010,rmab011,rmab012,rmab013,rmab017 
#           INTO g_rmbb_d[l_ac].rmab009,g_rmbb_d[l_ac].rmab010,g_rmbb_d[l_ac].rmab011,g_rmbb_d[l_ac].rmab012,g_rmbb_d[l_ac].rmab013,g_rmbb_d[l_ac].rmab017          
         SELECT rmab018,rmab019,rmab020,rmab009,rmab010,rmab011,rmab012,rmab013,rmab017 
           INTO g_rmbb_d[l_ac].rmab018,g_rmbb_d[l_ac].rmab019,g_rmbb_d[l_ac].rmab020,g_rmbb_d[l_ac].rmab009,g_rmbb_d[l_ac].rmab010,g_rmbb_d[l_ac].rmab011,g_rmbb_d[l_ac].rmab012,g_rmbb_d[l_ac].rmab013,g_rmbb_d[l_ac].rmab017 
           FROM rmab_t
         #2016-2-22 zhujing mod-----(E)
          WHERE rmabent = g_enterprise
            AND rmabsite = g_site
            AND rmabdocno = g_rmba_m.rmbadocno
            AND rmabseq = g_rmbb_d[l_ac].rmbbseq
         IF cl_null(g_rmbb_d[l_ac].rmbb001) THEN LET g_rmbb_d[l_ac].rmbb001 = 0 END IF
         IF cl_null(g_rmbb_d[l_ac].rmbb002) THEN LET g_rmbb_d[l_ac].rmbb002 = 0 END IF
         LET g_rmbb_d[l_ac].srmbb002 = g_rmbb_d[l_ac].rmbb001 + g_rmbb_d[l_ac].rmbb002 
         CALL s_desc_get_item_desc(g_rmbb_d[l_ac].rmab009) RETURNING g_rmbb_d[l_ac].rmab009_desc,g_rmbb_d[l_ac].rmab009_desc_desc
         CALL s_desc_get_unit_desc(g_rmbb_d[l_ac].rmab011) RETURNING g_rmbb_d[l_ac].rmab011_desc
         CALL s_feature_description(g_rmbb_d[l_ac].rmab009,g_rmbb_d[l_ac].rmab010) RETURNING r_success,g_rmbb_d[l_ac].rmab010_desc           
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
   
   CALL g_rmbb_d.deleteElement(g_rmbb_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE armt200_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_rmbb_d.getLength()
      LET g_rmbb_d_mask_o[l_ac].* =  g_rmbb_d[l_ac].*
      CALL armt200_rmbb_t_mask()
      LET g_rmbb_d_mask_n[l_ac].* =  g_rmbb_d[l_ac].*
   END FOR
   
   LET g_rmbb2_d_mask_o.* =  g_rmbb2_d.*
   FOR l_ac = 1 TO g_rmbb2_d.getLength()
      LET g_rmbb2_d_mask_o[l_ac].* =  g_rmbb2_d[l_ac].*
      CALL armt200_rmbc_t_mask()
      LET g_rmbb2_d_mask_n[l_ac].* =  g_rmbb2_d[l_ac].*
   END FOR
   LET g_rmbb3_d_mask_o.* =  g_rmbb3_d.*
   FOR l_ac = 1 TO g_rmbb3_d.getLength()
      LET g_rmbb3_d_mask_o[l_ac].* =  g_rmbb3_d[l_ac].*
      CALL armt200_rmbd_t_mask()
      LET g_rmbb3_d_mask_n[l_ac].* =  g_rmbb3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION armt200_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM rmbb_t
       WHERE rmbbent = g_enterprise AND
         rmbbdocno = ps_keys_bak[1] AND rmbb000 = ps_keys_bak[2] AND rmbbseq = ps_keys_bak[3]
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
         CALL g_rmbb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM rmbc_t
       WHERE rmbcent = g_enterprise AND
             rmbcdocno = ps_keys_bak[1] AND rmbc000 = ps_keys_bak[2] AND rmbcseq = ps_keys_bak[3] AND rmbcseq1 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_rmbb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM rmbd_t
       WHERE rmbdent = g_enterprise AND
             rmbddocno = ps_keys_bak[1] AND rmbd000 = ps_keys_bak[2] AND rmbdseq = ps_keys_bak[3] AND rmbdseq1 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_rmbb3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION armt200_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO rmbb_t
                  (rmbbent,
                   rmbbdocno,rmbb000,
                   rmbbseq
                   ,rmbbsite,rmbb003,rmbb001,rmbb002,rmbb004,rmbb005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_rmbb_d[g_detail_idx].rmbbsite,g_rmbb_d[g_detail_idx].rmbb003,g_rmbb_d[g_detail_idx].rmbb001, 
                       g_rmbb_d[g_detail_idx].rmbb002,g_rmbb_d[g_detail_idx].rmbb004,g_rmbb_d[g_detail_idx].rmbb005) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_rmbb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO rmbc_t
                  (rmbcent,
                   rmbcdocno,rmbc000,rmbcseq,
                   rmbcseq1
                   ,rmbcsite,rmbc001,rmbc002,rmbc003,rmbc004,rmbc005,rmbc006,rmbc008,rmbc007) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_rmbb2_d[g_detail_idx2].rmbcsite,g_rmbb2_d[g_detail_idx2].rmbc001,g_rmbb2_d[g_detail_idx2].rmbc002, 
                       g_rmbb2_d[g_detail_idx2].rmbc003,g_rmbb2_d[g_detail_idx2].rmbc004,g_rmbb2_d[g_detail_idx2].rmbc005, 
                       g_rmbb2_d[g_detail_idx2].rmbc006,g_rmbb2_d[g_detail_idx2].rmbc008,g_rmbb2_d[g_detail_idx2].rmbc007) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_rmbb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO rmbd_t
                  (rmbdent,
                   rmbddocno,rmbd000,rmbdseq,
                   rmbdseq1
                   ,rmbdsite,rmbd001,rmbd002,rmbd003,rmbd004,rmbd006,rmbd005) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_rmbb3_d[g_detail_idx2].rmbdsite,g_rmbb3_d[g_detail_idx2].rmbd001,g_rmbb3_d[g_detail_idx2].rmbd002, 
                       g_rmbb3_d[g_detail_idx2].rmbd003,g_rmbb3_d[g_detail_idx2].rmbd004,g_rmbb3_d[g_detail_idx2].rmbd006, 
                       g_rmbb3_d[g_detail_idx2].rmbd005)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_rmbb3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION armt200_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmbb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL armt200_rmbb_t_mask_restore('restore_mask_o')
               
      UPDATE rmbb_t 
         SET (rmbbdocno,rmbb000,
              rmbbseq
              ,rmbbsite,rmbb003,rmbb001,rmbb002,rmbb004,rmbb005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_rmbb_d[g_detail_idx].rmbbsite,g_rmbb_d[g_detail_idx].rmbb003,g_rmbb_d[g_detail_idx].rmbb001, 
                  g_rmbb_d[g_detail_idx].rmbb002,g_rmbb_d[g_detail_idx].rmbb004,g_rmbb_d[g_detail_idx].rmbb005)  
 
         WHERE rmbbent = g_enterprise AND rmbbdocno = ps_keys_bak[1] AND rmbb000 = ps_keys_bak[2] AND rmbbseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbb_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbb_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt200_rmbb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmbc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL armt200_rmbc_t_mask_restore('restore_mask_o')
               
      UPDATE rmbc_t 
         SET (rmbcdocno,rmbc000,rmbcseq,
              rmbcseq1
              ,rmbcsite,rmbc001,rmbc002,rmbc003,rmbc004,rmbc005,rmbc006,rmbc008,rmbc007) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_rmbb2_d[g_detail_idx2].rmbcsite,g_rmbb2_d[g_detail_idx2].rmbc001,g_rmbb2_d[g_detail_idx2].rmbc002, 
                  g_rmbb2_d[g_detail_idx2].rmbc003,g_rmbb2_d[g_detail_idx2].rmbc004,g_rmbb2_d[g_detail_idx2].rmbc005, 
                  g_rmbb2_d[g_detail_idx2].rmbc006,g_rmbb2_d[g_detail_idx2].rmbc008,g_rmbb2_d[g_detail_idx2].rmbc007)  
 
         WHERE rmbcent = g_enterprise AND rmbcdocno = ps_keys_bak[1] AND rmbc000 = ps_keys_bak[2] AND rmbcseq = ps_keys_bak[3] AND rmbcseq1 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt200_rmbc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "rmbd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL armt200_rmbd_t_mask_restore('restore_mask_o')
               
      UPDATE rmbd_t 
         SET (rmbddocno,rmbd000,rmbdseq,
              rmbdseq1
              ,rmbdsite,rmbd001,rmbd002,rmbd003,rmbd004,rmbd006,rmbd005) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_rmbb3_d[g_detail_idx2].rmbdsite,g_rmbb3_d[g_detail_idx2].rmbd001,g_rmbb3_d[g_detail_idx2].rmbd002, 
                  g_rmbb3_d[g_detail_idx2].rmbd003,g_rmbb3_d[g_detail_idx2].rmbd004,g_rmbb3_d[g_detail_idx2].rmbd006, 
                  g_rmbb3_d[g_detail_idx2].rmbd005) 
         WHERE rmbdent = g_enterprise AND rmbddocno = ps_keys_bak[1] AND rmbd000 = ps_keys_bak[2] AND rmbdseq = ps_keys_bak[3] AND rmbdseq1 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL armt200_rmbd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="armt200.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION armt200_key_update_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行update
   IF ps_table = 'rmbb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE rmbc_t 
         SET (rmbcdocno,rmbc000,rmbcseq) 
              = 
             (g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq) 
         WHERE rmbcent = g_enterprise AND
               rmbcdocno = ps_keys_bak[1] AND rmbc000 = ps_keys_bak[2] AND rmbcseq = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行update
   IF ps_table = 'rmbb_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update3"
      
      #end add-point
      
      UPDATE rmbd_t 
         SET (rmbddocno,rmbd000,rmbdseq) 
              = 
             (g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq) 
         WHERE rmbdent = g_enterprise AND
               rmbddocno = ps_keys_bak[1] AND rmbd000 = ps_keys_bak[2] AND rmbdseq = ps_keys_bak[3]
 
      #add-point:update_b段修改中 name="key_update_b.m_update3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update3"
      
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION armt200_key_delete_b(ps_keys_bak,ps_table)
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
   
   #如果是上層單身則進行delete
   IF ps_table = 'rmbb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM rmbc_t 
            WHERE rmbcent = g_enterprise AND
                  rmbcdocno = ps_keys_bak[1] AND rmbc000 = ps_keys_bak[2] AND rmbcseq = ps_keys_bak[3]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      
      #end add-point
   END IF
 
   #如果是上層單身則進行delete
   IF ps_table = 'rmbb_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete3"
      
      #end add-point
      
      DELETE FROM rmbd_t 
            WHERE rmbdent = g_enterprise AND
                  rmbddocno = ps_keys_bak[1] AND rmbd000 = ps_keys_bak[2] AND rmbdseq = ps_keys_bak[3]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete3"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "rmbd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete3"
      
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION armt200_lock_b(ps_table,ps_page)
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
   #CALL armt200_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "rmbb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN armt200_bcl USING g_enterprise,
                                       g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt200_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "rmbc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN armt200_bcl2 USING g_enterprise,
                                             g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq, 
 
                                             g_rmbb2_d[g_detail_idx2].rmbcseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt200_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "rmbd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN armt200_bcl3 USING g_enterprise,
                                             g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq, 
 
                                             g_rmbb3_d[g_detail_idx2].rmbdseq1
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "armt200_bcl3:",SQLERRMESSAGE 
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
 
{<section id="armt200.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION armt200_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   DEFINE  l_rmbb001   LIKE rmbb_t.rmbb001   #计算未税材料金额sum    2016-2-22 zhujing add
   DEFINE  l_rmbb002   LIKE rmbb_t.rmbb002   #计算未税费用金额sum    2016-2-22 zhujing add
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt200_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt200_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE armt200_bcl3
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
            #add by lixh 20150810
         IF ps_page = "'2'" THEN
            #2016-2-22 zhujing mod-----(S) 
#           SELECT SUM(rmbc007) INTO g_rmbb_d[g_detail_idx].rmbb001 FROM rmbc_t
            SELECT SUM(rmbd005),SUM(rmbd004) 
              INTO g_rmbb_d[g_detail_idx].rmbb002,l_rmbb002 FROM rmbd_t            
             WHERE rmbdent = g_enterprise
               AND rmbdsite = g_site
               AND rmbddocno = g_rmba_m.rmbadocno
               AND rmbd000 = g_rmba_m.rmba000
               AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq
            SELECT SUM(rmbc007),SUM(rmbc006) 
              INTO g_rmbb_d[g_detail_idx].rmbb001,l_rmbb001 FROM rmbc_t
             WHERE rmbcent = g_enterprise
               AND rmbcsite = g_site
               AND rmbcdocno = g_rmba_m.rmbadocno
               AND rmbc000 = g_rmba_m.rmba000
               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb001) THEN LET g_rmbb_d[g_detail_idx].rmbb001 = 0 END IF
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb002) THEN LET g_rmbb_d[g_detail_idx].rmbb002 = 0 END IF
            IF cl_null(l_rmbb001) THEN LET l_rmbb001 = 0 END IF      #2016-2-22 zhujing add
            IF cl_null(l_rmbb002) THEN LET l_rmbb002 = 0 END IF      #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].srmbb002 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002                 
            LET g_rmbb_d[g_detail_idx].rmbb005 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002    #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].rmbb004 = l_rmbb001 + l_rmbb002    #2016-2-22 zhujing add
            IF g_rmbb_d[g_detail_idx].rmab013 IS NOT NULL OR g_rmbb_d[g_detail_idx].rmab013 <> 0 THEN
               IF g_rmba_m.rmba008 = 'Y' THEN   #含税 单价=含税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb005/g_rmbb_d[g_detail_idx].rmab013
               ELSE                             #未税 单价=未税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb004/g_rmbb_d[g_detail_idx].rmab013
               END IF
            END IF
            UPDATE rmbb_t 
              SET rmbb001 = g_rmbb_d[g_detail_idx].rmbb001,
                  rmbb003 = g_rmbb_d[g_detail_idx].rmbb003,    #2016-2-22 zhujing add
                  rmbb004 = g_rmbb_d[g_detail_idx].rmbb004,    #2016-2-22 zhujing add
                  rmbb005 = g_rmbb_d[g_detail_idx].rmbb005     #2016-2-22 zhujing add
             WHERE rmbbent = g_enterprise
               AND rmbbsite = g_site
               AND rmbbdocno = g_rmba_m.rmbadocno
               AND rmbb000 = g_rmba_m.rmba000
               AND rmbbseq = g_rmbb_d[g_detail_idx].rmbbseq 
            #2016-2-22 zhujing mod-----(E) 
         END IF  
         
         IF ps_page = "'3'" THEN
            #2016-2-22 zhujing mod-----(S) 
#            SELECT SUM(rmbd005) INTO g_rmbb_d[g_detail_idx].rmbb002 FROM rmbd_t
            SELECT SUM(rmbd005),SUM(rmbd004) 
              INTO g_rmbb_d[g_detail_idx].rmbb002,l_rmbb002 FROM rmbd_t            
             WHERE rmbdent = g_enterprise
               AND rmbdsite = g_site
               AND rmbddocno = g_rmba_m.rmbadocno
               AND rmbd000 = g_rmba_m.rmba000
               AND rmbdseq = g_rmbb_d[g_detail_idx].rmbbseq
            SELECT SUM(rmbc007),SUM(rmbc006) 
              INTO g_rmbb_d[g_detail_idx].rmbb001,l_rmbb001 FROM rmbc_t
             WHERE rmbcent = g_enterprise
               AND rmbcsite = g_site
               AND rmbcdocno = g_rmba_m.rmbadocno
               AND rmbc000 = g_rmba_m.rmba000
               AND rmbcseq = g_rmbb_d[g_detail_idx].rmbbseq
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb001) THEN LET g_rmbb_d[g_detail_idx].rmbb001 = 0 END IF   
            IF cl_null(g_rmbb_d[g_detail_idx].rmbb002) THEN LET g_rmbb_d[g_detail_idx].rmbb002 = 0 END IF   
            IF cl_null(l_rmbb001) THEN LET l_rmbb001 = 0 END IF      #2016-2-22 zhujing add
            IF cl_null(l_rmbb002) THEN LET l_rmbb002 = 0 END IF      #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].srmbb002 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002                 
            LET g_rmbb_d[g_detail_idx].rmbb005 = g_rmbb_d[g_detail_idx].rmbb001 + g_rmbb_d[g_detail_idx].rmbb002    #2016-2-22 zhujing add
            LET g_rmbb_d[g_detail_idx].rmbb004 = l_rmbb001 + l_rmbb002    #2016-2-22 zhujing add
            IF g_rmbb_d[g_detail_idx].rmab013 IS NOT NULL OR g_rmbb_d[g_detail_idx].rmab013 <> 0 THEN
               IF g_rmba_m.rmba008 = 'Y' THEN   #含税 单价=含税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb005/g_rmbb_d[g_detail_idx].rmab013
               ELSE                             #未税 单价=未税金额/点收数量
                  LET g_rmbb_d[g_detail_idx].rmbb003 = g_rmbb_d[g_detail_idx].rmbb004/g_rmbb_d[g_detail_idx].rmab013
               END IF
            END IF
            UPDATE rmbb_t 
               SET rmbb002 = g_rmbb_d[g_detail_idx].rmbb002,
                   rmbb003 = g_rmbb_d[g_detail_idx].rmbb003,    #2016-2-22 zhujing add
                   rmbb004 = g_rmbb_d[g_detail_idx].rmbb004,    #2016-2-22 zhujing add
                   rmbb005 = g_rmbb_d[g_detail_idx].rmbb005     #2016-2-22 zhujing add
             WHERE rmbbent = g_enterprise
               AND rmbbsite = g_site
               AND rmbbdocno = g_rmba_m.rmbadocno
               AND rmbb000 = g_rmba_m.rmba000
               AND rmbbseq = g_rmbb_d[g_detail_idx].rmbbseq 
            #2016-2-22 zhujing mod-----(E)  
         END IF
            #add by lixh 20150810  
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION armt200_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("rmbadocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("rmbadocno,rmba000",TRUE)
      CALL cl_set_comp_entry("rmbadocdt",TRUE)
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
 
{<section id="armt200.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION armt200_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("rmbadocno,rmba000",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("rmbadocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("rmbadocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   CALL cl_set_comp_entry("rmba000",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION armt200_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("rmbc002",TRUE)
   CALL cl_set_comp_visible("rmbc002,rmbc002_desc",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION armt200_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   IF l_ac <> 0 THEN
      IF NOT cl_null(g_rmbb2_d[l_ac].rmbc001) THEN
         SELECT imaa005 INTO l_imaa005 FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_rmbb2_d[l_ac].rmbc001
         IF cl_null(l_imaa005) THEN
            CALL cl_set_comp_entry("rmbc002",FALSE)            
            LET g_rmbb2_d[l_ac].rmbc002 = ''
            LET g_rmbb2_d[l_ac].rmbc002_desc = ''
         END IF         
      END IF
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION armt200_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION armt200_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_rmba_m.rmbastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION armt200_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt200.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION armt200_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="armt200.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION armt200_default_search()
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
      LET ls_wc = ls_wc, " rmbadocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " rmba000 = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "rmba_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "rmbb_t" 
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
 
{<section id="armt200.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION armt200_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE r_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_rmba_m.rmbastus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_rmba_m.rmbadocno IS NULL
      OR g_rmba_m.rmba000 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN armt200_cl USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000
   IF STATUS THEN
      CLOSE armt200_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN armt200_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
       g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
       g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
       g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
       g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT armt200_action_chk() THEN
      CLOSE armt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
       g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
       g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
       g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,g_rmba_m.rmba009_desc, 
       g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
       g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc, 
       g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc, 
       g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc,g_rmba_m.rmbacnfdt
 
   CASE g_rmba_m.rmbastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
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
         CASE g_rmba_m.rmbastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
         CALL cl_set_act_visible("unconfirmed,confirmed,invalid", TRUE)
         CASE g_rmba_m.rmbastus
            WHEN "N"
               CALL cl_set_act_visible("unconfirmed",FALSE)

            WHEN "X"
               CALL cl_set_act_visible("invalid,confirmed,unconfirmed",FALSE)
               
            WHEN "Y"
               CALL cl_set_act_visible("invalid,confirmed",FALSE)      
               
         END CASE   
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            CALL s_transaction_begin()
            IF lc_state = 'N' THEN
               CALL s_armt200_unconf_chk(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
               IF NOT r_success THEN 
                  CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812                
                  RETURN
               ELSE
                  IF NOT cl_ask_confirm('aim-00108') THEN
                     CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812                  
                     RETURN
                  ELSE
                     CALL s_armt200_unconf_upd(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
                     IF NOT r_success THEN
                        CALL s_transaction_end('N','0')                       
                        RETURN
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                  END IF
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            CALL s_transaction_begin()
            IF lc_state = 'Y' THEN
               CALL s_armt200_conf_chk(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
               IF NOT r_success THEN
                  CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812               
                  RETURN
               ELSE
                  IF NOT cl_ask_confirm('aim-00108') THEN
                     CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812                  
                     RETURN
                  ELSE
                     CALL s_armt200_conf_upd(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
                     IF NOT r_success THEN
                        CALL s_transaction_end('N','0')                       
                        RETURN
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                  END IF
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            CALL s_transaction_begin()
            IF lc_state = 'X' THEN
               CALL s_armt200_invoid_chk(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
               IF NOT r_success THEN 
                  CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812               
                  RETURN
               ELSE
                  IF NOT cl_ask_confirm('aim-00109') THEN                     
                     CALL s_transaction_end('N','0')   #160812-00017#1 Add By Ken 160812
                     RETURN
                  ELSE
                     CALL s_armt200_invoid_upd(g_rmba_m.rmbadocno,g_rmba_m.rmba000) RETURNING r_success
                     IF NOT r_success THEN
                        CALL s_transaction_end('N','0')                       
                        RETURN
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                  END IF
               END IF
            END IF
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_rmba_m.rmbastus = lc_state OR cl_null(lc_state) THEN
      CLOSE armt200_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_rmba_m.rmbamodid = g_user
   LET g_rmba_m.rmbamoddt = cl_get_current()
   LET g_rmba_m.rmbastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE rmba_t 
      SET (rmbastus,rmbamodid,rmbamoddt) 
        = (g_rmba_m.rmbastus,g_rmba_m.rmbamodid,g_rmba_m.rmbamoddt)     
    WHERE rmbaent = g_enterprise AND rmbadocno = g_rmba_m.rmbadocno
      AND rmba000 = g_rmba_m.rmba000
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE armt200_master_referesh USING g_rmba_m.rmbadocno,g_rmba_m.rmba000 INTO g_rmba_m.rmbadocno, 
          g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba000,g_rmba_m.rmba001,g_rmba_m.rmba003,g_rmba_m.rmbasite, 
          g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008, 
          g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba013,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmbaownid, 
          g_rmba_m.rmbaowndp,g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdt,g_rmba_m.rmbamodid, 
          g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfdt,g_rmba_m.rmba002_desc,g_rmba_m.rmba001_desc, 
          g_rmba_m.rmba003_desc,g_rmba_m.rmba004_desc,g_rmba_m.rmba005_desc,g_rmba_m.rmba010_desc,g_rmba_m.rmbaownid_desc, 
          g_rmba_m.rmbaowndp_desc,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbamodid_desc, 
          g_rmba_m.rmbacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_rmba_m.rmbadocno,g_rmba_m.rmbadocdt,g_rmba_m.rmba002,g_rmba_m.rmba002_desc,g_rmba_m.rmba000, 
          g_rmba_m.rmba001,g_rmba_m.rmba001_desc,g_rmba_m.rmba003,g_rmba_m.rmba003_desc,g_rmba_m.rmbasite, 
          g_rmba_m.rmbastus,g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc, 
          g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009, 
          g_rmba_m.rmba009_desc,g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba013,g_rmba_m.rmba011, 
          g_rmba_m.rmba012,g_rmba_m.rmbaownid,g_rmba_m.rmbaownid_desc,g_rmba_m.rmbaowndp,g_rmba_m.rmbaowndp_desc, 
          g_rmba_m.rmbacrtid,g_rmba_m.rmbacrtid_desc,g_rmba_m.rmbacrtdp,g_rmba_m.rmbacrtdp_desc,g_rmba_m.rmbacrtdt, 
          g_rmba_m.rmbamodid,g_rmba_m.rmbamodid_desc,g_rmba_m.rmbamoddt,g_rmba_m.rmbacnfid,g_rmba_m.rmbacnfid_desc, 
          g_rmba_m.rmbacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE armt200_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL armt200_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt200.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION armt200_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_rmbb_d.getLength() THEN
         LET g_detail_idx = g_rmbb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_rmbb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_rmbb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_rmbb2_d.getLength() THEN
         LET g_detail_idx2 = g_rmbb2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_rmbb2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_rmbb2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_rmbb3_d.getLength() THEN
         LET g_detail_idx2 = g_rmbb3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_rmbb3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_rmbb3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION armt200_b_fill2(pi_idx)
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
   
   IF armt200_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_rmbb_d.getLength() > 0 THEN
               CALL g_rmbb2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT rmbcsite,rmbcseq1,rmbc001,rmbc002,rmbc003,rmbc004,rmbc005,rmbc006, 
             rmbc008,rmbc007 ,t4.imaal003 ,t5.imaal004 ,t6.oocal003 FROM rmbc_t",    
                     "",
                                    " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=rmbc001 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=rmbc001 AND t5.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=rmbc003 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE rmbcent=? AND rmbcdocno=? AND rmbc000=? AND rmbcseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  rmbc_t.rmbcseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_rmbb2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt200_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR armt200_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq  
      #      #(ver:78)
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq INTO g_rmbb2_d[l_ac].rmbcsite, 
             g_rmbb2_d[l_ac].rmbcseq1,g_rmbb2_d[l_ac].rmbc001,g_rmbb2_d[l_ac].rmbc002,g_rmbb2_d[l_ac].rmbc003, 
             g_rmbb2_d[l_ac].rmbc004,g_rmbb2_d[l_ac].rmbc005,g_rmbb2_d[l_ac].rmbc006,g_rmbb2_d[l_ac].rmbc008, 
             g_rmbb2_d[l_ac].rmbc007,g_rmbb2_d[l_ac].rmbc001_desc,g_rmbb2_d[l_ac].rmbc001_desc_desc, 
             g_rmbb2_d[l_ac].rmbc003_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_rmbb2_d.deleteElement(g_rmbb2_d.getLength())
 
      END IF
   END IF
 
   IF armt200_fill_chk(3) THEN
      IF (pi_idx = 3 OR pi_idx = 0 ) AND g_rmbb_d.getLength() > 0 THEN
               CALL g_rmbb3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT rmbdsite,rmbdseq1,rmbd001,rmbd002,rmbd003,rmbd004,rmbd006,rmbd005 , 
             t7.oocql004 FROM rmbd_t",    
                     "",
                                    " LEFT JOIN oocql_t t7 ON t7.oocqlent="||g_enterprise||" AND t7.oocql001='1131' AND t7.oocql002=rmbd001 AND t7.oocql003='"||g_dlang||"' ",
 
                     " WHERE rmbdent=? AND rmbddocno=? AND rmbd000=? AND rmbdseq=?"
         
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  rmbd_t.rmbdseq1" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill3"
         
         #end add-point
         
         #先清空資料
               CALL g_rmbb3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE armt200_pb3 FROM g_sql
         DECLARE b_fill_curs3 CURSOR FOR armt200_pb3
         
      #  OPEN b_fill_curs3 USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq  
      #      #(ver:78)
         LET l_ac = 1
         FOREACH b_fill_curs3 USING g_enterprise,g_rmba_m.rmbadocno,g_rmba_m.rmba000,g_rmbb_d[g_detail_idx].rmbbseq INTO g_rmbb3_d[l_ac].rmbdsite, 
             g_rmbb3_d[l_ac].rmbdseq1,g_rmbb3_d[l_ac].rmbd001,g_rmbb3_d[l_ac].rmbd002,g_rmbb3_d[l_ac].rmbd003, 
             g_rmbb3_d[l_ac].rmbd004,g_rmbb3_d[l_ac].rmbd006,g_rmbb3_d[l_ac].rmbd005,g_rmbb3_d[l_ac].rmbd001_desc  
               #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill3"
            
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_rmbb3_d.deleteElement(g_rmbb3_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_rmbb2_d_mask_o.* =  g_rmbb2_d.*
   FOR l_ac = 1 TO g_rmbb2_d.getLength()
      LET g_rmbb2_d_mask_o[l_ac].* =  g_rmbb2_d[l_ac].*
      CALL armt200_rmbc_t_mask()
      LET g_rmbb2_d_mask_n[l_ac].* =  g_rmbb2_d[l_ac].*
   END FOR
   LET g_rmbb3_d_mask_o.* =  g_rmbb3_d.*
   FOR l_ac = 1 TO g_rmbb3_d.getLength()
      LET g_rmbb3_d_mask_o[l_ac].* =  g_rmbb3_d[l_ac].*
      CALL armt200_rmbd_t_mask()
      LET g_rmbb3_d_mask_n[l_ac].* =  g_rmbb3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL armt200_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION armt200_fill_chk(ps_idx)
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
 
{<section id="armt200.status_show" >}
PRIVATE FUNCTION armt200_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="armt200.mask_functions" >}
&include "erp/arm/armt200_mask.4gl"
 
{</section>}
 
{<section id="armt200.signature" >}
   
 
{</section>}
 
{<section id="armt200.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION armt200_set_pk_array()
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
   LET g_pk_array[1].values = g_rmba_m.rmbadocno
   LET g_pk_array[1].column = 'rmbadocno'
   LET g_pk_array[2].values = g_rmba_m.rmba000
   LET g_pk_array[2].column = 'rmba000'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt200.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="armt200.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION armt200_msgcentre_notify(lc_state)
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
   CALL armt200_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_rmba_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="armt200.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION armt200_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#33-s
   SELECT rmbastus INTO g_rmba_m.rmbastus FROM rmba_t
    WHERE rmbaent = g_enterprise
      AND rmbadocno = g_rmba_m.rmbadocno
      AND rmba000 = g_rmba_m.rmba000
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_rmba_m.rmbastus

        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'

     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_rmba_m.rmbadocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL armt200_set_act_visible()
        CALL armt200_set_act_no_visible()
        CALL armt200_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#33-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="armt200.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt200_rmbadocno_desc()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION armt200_rmbadocno_desc()
DEFINE  l_rmaa005   LIKE rmaa_t.rmaa005
DEFINE  l_oodbl004  LIKE oodbl_t.oodbl004
DEFINE  l_oodb005   LIKE oodb_t.oodb005
DEFINE  l_oodb006   LIKE oodb_t.oodb006
DEFINE  l_oodb011   LIKE oodb_t.oodb011
DEFINE  l_success   LIKE type_t.num5

   IF NOT cl_null(g_rmba_m.rmbadocno) THEN
      SELECT rmaa001,rmaa005 INTO g_rmba_m.rmba001,l_rmaa005 FROM rmaa_t
       WHERE rmaaent = g_enterprise
         AND rmaadocno = g_rmba_m.rmbadocno
      IF NOT cl_null(g_rmba_m.rmba001) THEN
         CALL s_desc_get_trading_partner_abbr_desc(g_rmba_m.rmba001) RETURNING g_rmba_m.rmba001_desc
      ELSE 
         LET g_rmba_m.rmba001_desc = ''   
      END IF
      IF NOT cl_null(l_rmaa005) THEN
         SELECT xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,xmdk017,xmdk043,xmdk042 
           INTO g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba009,
                g_rmba_m.rmba010,g_rmba_m.rmba011,g_rmba_m.rmba012,g_rmba_m.rmba013
           FROM xmdk_t
          WHERE xmdkent = g_enterprise
            AND xmdksite = g_site
            AND xmdkdocno = l_rmaa005
      ELSE
         SELECT pmab087,pmab103,pmab084,pmab106,pmab083,pmab108,pmab107   #add by lixh 20150910
           INTO g_rmba_m.rmba004,g_rmba_m.rmba005,g_rmba_m.rmba006,g_rmba_m.rmba009,g_rmba_m.rmba010,g_rmba_m.rmba012,g_rmba_m.rmba013
           FROM pmab_t 
          WHERE pmabent = g_enterprise
            AND pmabsite = g_site
            AND pmab001 = g_rmba_m.rmba001 
         CALL s_tax_chk(g_site,g_rmba_m.rmba006) RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011  
         LET g_rmba_m.rmba007 = l_oodb006
         DISPLAY BY NAME g_rmba_m.rmba007
         LET g_rmba_m.rmba008 = l_oodb005
         DISPLAY BY NAME g_rmba_m.rmba007    
         #帶出匯率
         CALL s_axmt540_get_exchange(g_rmba_m.rmba013,g_rmba_m.rmba010,g_rmba_m.rmbadocdt) RETURNING g_rmba_m.rmba011   #151118-00012#1 By shiun   新增傳入參數g_rmba_m.rmbadocdt
      END IF 
      LET g_rmba_m.rmba004_desc = ''
      LET g_rmba_m.rmba005_desc = ''
      LET g_rmba_m.rmba006_desc = ''
      LET g_rmba_m.rmba009_desc = ''
      LET g_rmba_m.rmba010_desc = ''
      CALL s_desc_get_ooib002_desc(g_rmba_m.rmba004) RETURNING g_rmba_m.rmba004_desc
      CALL s_desc_get_acc_desc('238',g_rmba_m.rmba005) RETURNING g_rmba_m.rmba005_desc
      CALL s_desc_get_tax_desc1(g_site,g_rmba_m.rmba006) RETURNING g_rmba_m.rmba006_desc
      CALL s_desc_get_invoice_type_desc1(g_site,g_rmba_m.rmba009) RETURNING g_rmba_m.rmba009_desc
      CALL s_desc_get_currency_desc(g_rmba_m.rmba010) RETURNING g_rmba_m.rmba010_desc
   ELSE
      LET g_rmba_m.rmba001 = ''
      LET g_rmba_m.rmba001_desc = ''
      LET g_rmba_m.rmba004 = ''
      LET g_rmba_m.rmba005 = ''
      LET g_rmba_m.rmba006 = ''
      LET g_rmba_m.rmba007 = ''
      LET g_rmba_m.rmba008 = ''
      LET g_rmba_m.rmba009 = ''
      LET g_rmba_m.rmba010 = ''
      LET g_rmba_m.rmba011 = ''
      LET g_rmba_m.rmba012 = ''
      LET g_rmba_m.rmba010 = ''
      LET g_rmba_m.rmba004_desc = ''
      LET g_rmba_m.rmba005_desc = ''
      LET g_rmba_m.rmba006_desc = ''
      LET g_rmba_m.rmba009_desc = ''
      LET g_rmba_m.rmba010_desc = ''      
   END IF
   DISPLAY BY NAME g_rmba_m.rmba004,g_rmba_m.rmba004_desc,g_rmba_m.rmba005,g_rmba_m.rmba005_desc,
                   g_rmba_m.rmba006,g_rmba_m.rmba006_desc,g_rmba_m.rmba009,g_rmba_m.rmba009_desc,
                   g_rmba_m.rmba010,g_rmba_m.rmba010_desc,g_rmba_m.rmba007,g_rmba_m.rmba008,g_rmba_m.rmba011,
                   g_rmba_m.rmba012,g_rmba_m.rmba013,g_rmba_m.rmba001,g_rmba_m.rmba001_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL armt200_default_rmbb()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION armt200_default_rmbb()
DEFINE  l_sql       STRING
DEFINE  r_success   LIKE type_t.num5

   IF cl_null(g_rmba_m.rmbadocno) THEN
      RETURN
   END IF
   CALL g_rmbb_d.clear()
   #2016-2-22 zhujing mod-----(S)
#   LET l_sql = " SELECT rmabseq,rmab009,rmab010,rmab011,rmab012,rmab013,rmab017 FROM rmab_t ",
   LET l_sql = " SELECT rmabseq,rmab018,rmab019,rmab020,rmab009,rmab010,rmab011,rmab012,rmab013,rmab017 FROM rmab_t ",
               "  WHERE rmabent = '",g_enterprise,"'",
               "    AND rmabsite = '",g_site,"'",
               "    AND rmabdocno = '",g_rmba_m.rmbadocno,"'"
   PREPARE armt200_rmab_pre FROM l_sql
   DECLARE armt200_rmab_cur CURSOR FOR armt200_rmab_pre
   #先刪除再新增
   DELETE FROM rmbb_t WHERE rmbbent = g_enterprise AND rmbbsite = g_site AND rmbbdocno = g_rmba_m.rmbadocno
   LET l_ac = 1
#   FOREACH armt200_rmab_cur INTO g_rmbb_d[l_ac].rmbbseq,g_rmbb_d[l_ac].rmab009,g_rmbb_d[l_ac].rmab010,g_rmbb_d[l_ac].rmab011,g_rmbb_d[l_ac].rmab012,
   FOREACH armt200_rmab_cur INTO g_rmbb_d[l_ac].rmbbseq,g_rmbb_d[l_ac].rmab018,g_rmbb_d[l_ac].rmab019,g_rmbb_d[l_ac].rmab020,g_rmbb_d[l_ac].rmab009,
                                 g_rmbb_d[l_ac].rmab010,g_rmbb_d[l_ac].rmab011,g_rmbb_d[l_ac].rmab012,
                                 g_rmbb_d[l_ac].rmab013,g_rmbb_d[l_ac].rmab017
   #2016-2-22 zhujing mod-----(E)
      LET g_rmbb_d[l_ac].rmbbsite = g_site
      CALL s_desc_get_item_desc(g_rmbb_d[l_ac].rmab009) RETURNING g_rmbb_d[l_ac].rmab009_desc,g_rmbb_d[l_ac].rmab009_desc_desc
      CALL s_desc_get_unit_desc(g_rmbb_d[l_ac].rmab011) RETURNING g_rmbb_d[l_ac].rmab011_desc
      CALL s_feature_description(g_rmbb_d[l_ac].rmab009,g_rmbb_d[l_ac].rmab010) RETURNING r_success,g_rmbb_d[l_ac].rmab010_desc
      LET g_rmbb_d[l_ac].rmbb001 = 0
      LET g_rmbb_d[l_ac].rmbb002 = 0
      LET g_rmbb_d[l_ac].srmbb002 = 0
      LET g_rmbb_d[l_ac].rmbb003 = 0   #2016-2-22 zhujing add 单价
      LET g_rmbb_d[l_ac].rmbb004 = 0   #2016-2-22 zhujing add 未税金额
      LET g_rmbb_d[l_ac].rmbb005 = 0   #2016-2-22 zhujing add 含税金额
      #2016-2-22 zhujing mod-----(S)
#      INSERT INTO rmbb_t (rmbbent,rmbbsite,rmbbdocno,rmbbseq,rmbb000,rmbb001,rmbb002)     
#                  VALUES (g_enterprise,g_site,g_rmba_m.rmbadocno,g_rmbb_d[l_ac].rmbbseq,g_rmba_m.rmba000,g_rmbb_d[l_ac].rmbb001,g_rmbb_d[l_ac].rmbb002)  
      INSERT INTO rmbb_t (rmbbent,rmbbsite,rmbbdocno,rmbbseq,rmbb000,rmbb001,rmbb002,rmbb003,rmbb004,rmbb005)     
                  VALUES (g_enterprise,g_site,g_rmba_m.rmbadocno,g_rmbb_d[l_ac].rmbbseq,g_rmba_m.rmba000,g_rmbb_d[l_ac].rmbb001,g_rmbb_d[l_ac].rmbb002,
                          g_rmbb_d[l_ac].rmbb003,g_rmbb_d[l_ac].rmbb004,g_rmbb_d[l_ac].rmbb005)  
      #2016-2-22 zhujing mod-----(E)
      LET l_ac = l_ac + 1                  
   END FOREACH 
   LET l_ac = l_ac - 1
   CALL g_rmbb_d.deleteElement(g_rmbb_d.getLength())
   LET g_detail_idx = 1  
END FUNCTION

 
{</section>}
 
