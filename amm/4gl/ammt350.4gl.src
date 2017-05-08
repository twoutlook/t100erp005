#該程式已解開Section, 不再透過樣板產出!
{<section id="ammt350.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000266
#+ 
#+ Filename...: ammt350
#+ Description: 會員卡積點規則申請維護作業
#+ Creator....: 01533(2013/09/22)
#+ Modifier...: 01533(2014/01/02)
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="ammt350.global" >}
#160318-00005#23  2016/03/30 by 07675   將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#41  2016/04/25 By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160519-00006#1   2016/05/27 by 07959   (修改bug)取消复制的功能
#160530-00033#1   2016/06/06 by 08172   新增规则对象范围action
#160707-00011#1   2016/07/12 by 06814   1.mmdi_t 的資料 如果是單頭直接修改"規格對象"後, 應該要做一次同步
#160729-00077#6   2016/08/17 by 06814   新增規則對象:編號開窗&校驗&帶值的部份
#160818-00017#21  2016/08/24 By 08742   删除修改未重新判断状态码
#160901-00063#1   2016/09/01 By 08742   发生闪退
#160905-00007#6   2016/09/05 By 02599   SQL条件增加ent
#161108-00016#1   2016/11/09 by 08742   修改 g_browser_cnt 定义大小
#160824-00007#113 2016/11/21 By sakura  新舊值備份處理
    
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
PRIVATE type type_g_mmbo_m        RECORD
       mmbo000 LIKE mmbo_t.mmbo000, 
   mmbodocno LIKE mmbo_t.mmbodocno, 
   mmbodocdt LIKE mmbo_t.mmbodocdt, 
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
   mmbo017 LIKE mmbo_t.mmbo017,  
   mmbo018 LIKE mmbo_t.mmbo018,     
   mmbosite LIKE mmbo_t.mmbosite, 
   mmbosite_desc LIKE type_t.chr80, 
   mmboacti LIKE mmbo_t.mmboacti, 
   mmbounit LIKE mmbo_t.mmbounit, 
   mmbostus LIKE mmbo_t.mmbostus, 
   mmboownid LIKE mmbo_t.mmboownid, 
   mmboownid_desc LIKE type_t.chr80, 
   mmboowndp LIKE mmbo_t.mmboowndp, 
   mmboowndp_desc LIKE type_t.chr80, 
   mmbocrtid LIKE mmbo_t.mmbocrtid, 
   mmbocrtid_desc LIKE type_t.chr80, 
   mmbocrtdp LIKE mmbo_t.mmbocrtdp, 
   mmbocrtdp_desc LIKE type_t.chr80, 
   mmbocrtdt DATETIME YEAR TO SECOND, 
   mmbomodid LIKE mmbo_t.mmbomodid, 
   mmbomodid_desc LIKE type_t.chr80, 
   mmbomoddt DATETIME YEAR TO SECOND, 
   mmbocnfid LIKE mmbo_t.mmbocnfid, 
   mmbocnfid_desc LIKE type_t.chr80, 
   mmbocnfdt DATETIME YEAR TO SECOND, 
   mmbr004_1 LIKE type_t.chr80, 
   mmbr014_1 LIKE type_t.chr80, 
   mmbr016_1 LIKE type_t.chr80, 
   mmbr018_1 LIKE type_t.chr80, 
   mmbr004_1_desc LIKE type_t.chr80, 
   mmbr015_1 LIKE type_t.chr80, 
   mmbr017_1 LIKE type_t.chr80, 
   mmbr019_1 LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_mmbp_d        RECORD
       mmbpunit LIKE mmbp_t.mmbpunit, 
   mmbpsite LIKE mmbp_t.mmbpsite, 
   mmbp001 LIKE mmbp_t.mmbp001, 
   mmbp002 LIKE mmbp_t.mmbp002, 
   mmbp003 LIKE mmbp_t.mmbp003, 
   mmbp004 LIKE mmbp_t.mmbp004, 
   mmbp004_desc LIKE type_t.chr80, 
   mmbp005 LIKE mmbp_t.mmbp005, 
   mmbp006 LIKE mmbp_t.mmbp006, 
   mmbp007 LIKE mmbp_t.mmbp007, 
   mmbp008 LIKE mmbp_t.mmbp008, 
   mmbp009 LIKE mmbp_t.mmbp009,    #add by yangxf 
   mmbp010 LIKE mmbp_t.mmbp010,    #add by yangxf 
   mmbpacti LIKE mmbp_t.mmbpacti
       END RECORD
PRIVATE TYPE type_g_mmbp2_d RECORD
       mmbsunit LIKE mmbs_t.mmbsunit, 
   mmbssite LIKE mmbs_t.mmbssite, 
   mmbs001 LIKE mmbs_t.mmbs001, 
   mmbs002 LIKE mmbs_t.mmbs002, 
   mmbs003 LIKE mmbs_t.mmbs003, 
   mmbs004 LIKE mmbs_t.mmbs004, 
   mmbs004_desc LIKE type_t.chr500, 
   mmbs005 LIKE mmbs_t.mmbs005, 
   mmbsacti LIKE mmbs_t.mmbsacti
       END RECORD
PRIVATE TYPE type_g_mmbp3_d RECORD
       mmbrunit LIKE mmbr_t.mmbrunit, 
   mmbrsite LIKE mmbr_t.mmbrsite, 
   mmbr001 LIKE mmbr_t.mmbr001, 
   mmbr002 LIKE mmbr_t.mmbr002, 
   mmbr003 LIKE mmbr_t.mmbr003, 
   mmbr004 LIKE mmbr_t.mmbr004, 
   mmbr004_desc LIKE type_t.chr80, 
   mmbr005 LIKE mmbr_t.mmbr005, 
   mmbr006 LIKE mmbr_t.mmbr006, 
   mmbr007 LIKE mmbr_t.mmbr007, 
   mmbr008 LIKE mmbr_t.mmbr008, 
   mmbr009 LIKE mmbr_t.mmbr009, 
   mmbr010 LIKE mmbr_t.mmbr010, 
   mmbr011 LIKE mmbr_t.mmbr011, 
   mmbr012 LIKE mmbr_t.mmbr012, 
   mmbr013 LIKE mmbr_t.mmbr013, 
   mmbr014 LIKE mmbr_t.mmbr014, 
   mmbr015 LIKE mmbr_t.mmbr015, 
   mmbr016 LIKE mmbr_t.mmbr016, 
   mmbr017 LIKE mmbr_t.mmbr017, 
   mmbr018 LIKE mmbr_t.mmbr018, 
   mmbr019 LIKE mmbr_t.mmbr019, 
   mmbracti LIKE mmbr_t.mmbracti
       END RECORD
#160613-00031#1 160615 by sakura add(S)
PRIVATE TYPE type_g_mmbp4_d RECORD
       mmdj005 LIKE mmdj_t.mmdj005, 
       mmdj006 LIKE mmdj_t.mmdj006, 
       mmdj007 LIKE mmdj_t.mmdj007, 
       mmdj008 LIKE mmdj_t.mmdj008, 
       mmdj009 LIKE mmdj_t.mmdj009, 
       mmdj010 LIKE mmdj_t.mmdj010, 
       mmdj011 LIKE mmdj_t.mmdj011, 
       mmdjacti LIKE mmdk_t.mmdkacti
       END RECORD
#160613-00031#1 160615 by sakura add(E)       
 
 
#模組變數(Module Variables)
DEFINE g_mmbo_m          type_g_mmbo_m
DEFINE g_mmbo_m_t        type_g_mmbo_m
 
   DEFINE g_mmbodocno_t LIKE mmbo_t.mmbodocno
 
 
DEFINE g_mmbp_d          DYNAMIC ARRAY OF type_g_mmbp_d
DEFINE g_mmbp_d_t        type_g_mmbp_d
DEFINE g_mmbp2_d   DYNAMIC ARRAY OF type_g_mmbp2_d
DEFINE g_mmbp2_d_t type_g_mmbp2_d
DEFINE g_mmbp3_d   DYNAMIC ARRAY OF type_g_mmbp3_d
DEFINE g_mmbp3_d_t type_g_mmbp3_d
#160613-00031#1 160615 by sakura add(S)
DEFINE g_mmbp4_d   DYNAMIC ARRAY OF type_g_mmbp4_d
DEFINE g_mmbp4_d_t type_g_mmbp4_d
DEFINE g_mmbp4_d_o type_g_mmbp4_d
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
#160613-00031#1 160615 by sakura add(E)
#160824-00007#113 by sakura add(S)
DEFINE g_mmbp_d_o        type_g_mmbp_d
DEFINE g_mmbp2_d_o       type_g_mmbp2_d
DEFINE g_mmbp3_d_o       type_g_mmbp3_d
#160824-00007#113 by sakura add(E)
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
      b_statepic     LIKE type_t.chr50,
     #b_mmbounit LIKE mmbo_t.mmbounit,#sakura mark
      b_mmbosite LIKE mmbo_t.mmbounit,
     #b_mmbounit_desc LIKE type_t.chr80,#sakura mark
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
      
DEFINE g_browser_f  RECORD    #資料瀏覽之欄位 
      b_statepic     LIKE type_t.chr50,
     #b_mmbounit LIKE mmbo_t.mmbounit,#sakura mark
      b_mmbosite LIKE mmbo_t.mmbounit,
     #b_mmbounit_desc LIKE type_t.chr80,#sakura mark
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
      
DEFINE g_master_multi_table_t    RECORD
      mmboldocno LIKE mmbol_t.mmboldocno,
      mmbol002 LIKE mmbol_t.mmbol002,
      mmbol003 LIKE mmbol_t.mmbol003
      END RECORD
#無單身append欄位定義
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_wc2_table4   STRING   #160613-00031#1 160615 by sakura add
 
 
 
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
#DEFINE g_rec_b               LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark                      
DEFINE g_rec_b               LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add           
#DEFINE l_ac                  LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark       
DEFINE l_ac                  LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add  
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
    
#DEFINE g_pagestart           LIKE type_t.num5             #161108-00016#1   2016/11/09  by 08742 mark 
DEFINE g_pagestart           LIKE type_t.num10             #161108-00016#1   2016/11/09  by 08742 add 
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING       
 
#161108-00016#1   2016/11/09  by 08742 -S
#DEFINE g_detail_cnt          LIKE type_t.num5             #單身總筆數 
#DEFINE g_detail_idx          LIKE type_t.num5             #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5             #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5             #Browser總筆數
#DEFINE g_browser_idx         LIKE type_t.num5             #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5             #Browser目前所在筆數(暫存用)
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數  
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
#161108-00016#1   2016/11/09  by 08742 -E
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
                                                        
#DEFINE g_current_row         LIKE type_t.num5             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用) #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
#DEFINE g_current_page        LIKE type_t.num5             #目前所在頁數   #161108-00016#1   2016/11/09  by 08742 mark
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數   #161108-00016#1   2016/11/09  by 08742 add
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_ooef005      LIKE ooef_t.ooef005
DEFINE g_assign_no    LIKE type_t.chr1
DEFINE g_mmbo_m_o            type_g_mmbo_m
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_mmbp4_d_mask_o   DYNAMIC ARRAY OF type_g_mmbp4_d #轉換遮罩前資料
DEFINE g_mmbp4_d_mask_n   DYNAMIC ARRAY OF type_g_mmbp4_d #轉換遮罩後資料
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_detail_idx3         LIKE type_t.num5              #單身3目前所在筆數   #160613-00031#1 160615 by sakura add
DEFINE g_detail_idx4         LIKE type_t.num5              #單身4目前所在筆數   #160613-00031#1 160615 by sakura add
#end add-point
 
#add-point:傳入參數說明(global.argv)
DEFINE g_site_flag   LIKE type_t.num5 #sakura add
#end add-point
 
{</section>}
 
{<section id="ammt350.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = "SELECT mmbo000,mmbodocno,mmbodocdt,mmbo004,mmbo006,mmbo001,mmbo002,'','',mmbo005, 
       '',mmbo007,mmbo008,mmbo014,mmbo015,mmbo017,mmbosite,'',mmboacti,mmbounit,mmbostus,mmboownid,'',mmboowndp, 
       '',mmbocrtid,'',mmbocrtdp,'',mmbocrtdt,mmbomodid,'',mmbomoddt,mmbocnfid,'',mmbocnfdt,'','','', 
       '','','','','' FROM mmbo_t WHERE mmboent= ? AND mmbodocno=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE ammt350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE mmbo000,mmbodocno,mmbodocdt,mmbo004,mmbo006,mmbo001,mmbo002,mmbo005,mmbo007, 
       mmbo008,mmbo014,mmbo015,mmbo017,mmbosite,mmboacti,mmbounit,mmbostus,mmboownid,mmboowndp,mmbocrtid,mmbocrtdp, 
       mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt",
               " FROM mmbo_t",
               " WHERE mmboent = '" ||g_enterprise|| "' AND mmbodocno = ?"
   #add-point:SQL_define

   #end add-point
   PREPARE ammt350_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammt350 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammt350_init()   
 
      #進入選單 Menu (="N")
      CALL ammt350_ui_dialog() 
      
      #add-point:畫面關閉前
      CALL s_aooi390_drop_tmp_table()   #160627-00005#2 160627 by sakura add
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammt350
      
   END IF 
   
   CLOSE ammt350_cl
   
   
 
   #add-point:作業離開前
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#4  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="ammt350.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ammt350_init()
   #add-point:init段define
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309
   #end add-point    
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx3 = 1   #160613-00031#1 160615 by sakura add
   LET g_detail_idx4 = 1   #160613-00031#1 160615 by sakura add
   LET g_error_show  = 1
   LET l_ac = 1
      CALL cl_set_combo_scc_part('mmbostus','13','N,X,Y')
 
      CALL cl_set_combo_scc('mmbo000','32') 
   CALL cl_set_combo_scc('mmbo004','6516') 
   CALL cl_set_combo_scc('mmbo007','6517') 
   CALL cl_set_combo_scc('mmbo008','6517') 
   CALL cl_set_combo_scc('mmbp005','6503') 
   CALL cl_set_combo_scc('mmbr007','6518') 
   CALL cl_set_combo_scc('mmbr010','6519') 
   CALL cl_set_combo_scc('mmbr018','6520') 
   CALL cl_set_combo_scc('mmbr019','30') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
 
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('mmbo017','6856') 
   CALL cl_set_combo_scc('b_mmbo000','32')
   CALL cl_set_combo_scc('b_mmbo004','6516')
   CALL cl_set_combo_scc_part('b_mmbo007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,Z")  #150521-00027#2 ADD T
   CALL cl_set_combo_scc_part('b_mmbo008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,W")  #150521-00027#2 ADD T
   
   CALL cl_set_combo_scc_part('mmbo007','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,Z")    #150521-00027#2 ADD T
   CALL cl_set_combo_scc_part('mmbo008','6517',"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,T,U,V,W")    #150521-00027#2 ADD T
   CALL cl_set_combo_scc_part('mmbr003','6517',"1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,Q,S,T,U,V,Z")  #150521-00027#2 DEL R
   CALL cl_set_combo_scc('mmbr018_1','6520') 
   CALL cl_set_combo_scc('mmbr019_1','30')

   LET g_ooef004 = ''
    LET g_ooef005 = ''
    SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 
      FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#4  By benson 150309
   CALL cl_set_act_visible("reproduce",FALSE)     #160519-00006#1   add
   #160613-00031#1 160615 by sakura add(S)
   CALL cl_set_comp_visible("mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019",FALSE)
   CALL cl_set_combo_scc('mmdj010','6520') 
   CALL cl_set_combo_scc('mmdj011','30')
   #160613-00031#1 160615 by sakura add(E)
   CALL s_aooi390_cre_tmp_table() RETURNING l_success   #160627-00005#2 160627 by sakura add
   #end add-point
   
   CALL ammt350_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="ammt350.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION ammt350_ui_dialog()
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   #add-point:ui_dialog段define
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   CALL gfrm_curr.setElementImage("logo","logo/applogo.png") 
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
   #+ 此段落由子樣板a42產生
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL ammt350_insert()
            #add-point:ON ACTION insert
            
            #END add-point
         END IF
 
      #add-point:action default自訂
      
      #end add-point
      OTHERWISE
         
   END CASE
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog 
   
   #end add-point
   
   WHILE TRUE 
   
      CALL ammt350_browser_fill("")
      CALL lib_cl_dlg.cl_dlg_before_display()
      CALL cl_notice()
            
      #判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      IF g_state = "Y" THEN
         FOR li_idx = 1 TO g_browser.getLength()
            IF g_browser[li_idx].b_mmbodocno = g_mmbodocno_t
 
               THEN
               LET g_current_row = li_idx
               LET g_current_idx = li_idx
               EXIT FOR
            END IF
         END FOR
         LET g_state = ""
      END IF
            
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
               
               CALL ammt350_fetch('') # reload data
               LET l_ac = 1
               CALL ammt350_ui_detailshow() #Setting the current row 
      
               CALL ammt350_idx_chk()
               #NEXT FIELD mmbp003
         
         END DISPLAY
        
         DISPLAY ARRAY g_mmbp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               CALL ammt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               
               #add-point:page1, before row動作
               
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               CALL ammt350_idx_chk()
               #add-point:page1自定義行為
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_mmbp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL ammt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               
               #add-point:page2, before row動作
                     
               #end add-point
               
            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               CALL ammt350_idx_chk()
               #add-point:page2自定義行為
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為
            
            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_mmbp3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               CALL ammt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               #LET g_detail_idx = l_ac  #160613-00031#1 160615 by sakura mark
               LET g_detail_idx3 = l_ac  #160613-00031#1 160615 by sakura add
               
               #add-point:page3, before row動作
               CALL ammt350_b_fill2('4')      #160613-00031#1 160615 by sakura add
               #CALL ammt350_show_desc(l_ac)  #160613-00031#1 160615 by sakura mark
               #end add-point
               
            BEFORE DISPLAY
               #CALL FGL_SET_ARR_CURR(g_detail_idx)   #160613-00031#1 160615 by sakura mark
               CALL FGL_SET_ARR_CURR(g_detail_idx3)   #160613-00031#1 160615 by sakura add
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               CALL ammt350_idx_chk()
               #add-point:page3自定義行為
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         #160613-00031#1 160615 by sakura add(S)
         #第二階單身段落
         DISPLAY ARRAY g_mmbp4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL ammt350_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL ammt350_idx_chk()
         
         END DISPLAY         
         #160613-00031#1 160615 by sakura add(E)         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            IF g_current_idx = 0 THEN
               LET g_current_idx = 1
            END IF
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL ammt350_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL ammt350_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL ammt350_idx_chk()
            
            #add-point:ui_dialog段before_dialog2
            #160530-00033#1 -s   by 08172
            ON ACTION rulerange
               LET g_action_choice="rulerange"
               IF cl_auth_chk_act("rulerange") THEN
                  
                  #add-point:ON ACTION rulerange name="menu.rulerange"
                  CALL ammt350_02(g_mmbo_m.mmbodocno,g_mmbo_m.mmbosite,g_mmbo_m.mmbounit,g_mmbo_m.mmbo004,g_mmbo_m.mmbo017,g_mmbo_m.mmbo001)
                  #END add-point
                  
               END IF
            #160530-00033#1 -e
            #end add-point
            
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD mmbp003
            END IF
        
         ON ACTION statechange
            CALL ammt350_statechange()
            LET g_action_choice = "statechange"
            EXIT DIALOG
      
         
          
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL ammt350_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
 
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL ammt350_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL ammt350_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #+ 此段落由子樣板a49產生
            ON ACTION filter
               #add-point:filter action
               
               #end add-point
               CALL ammt350_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            CALL ammt350_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt350_idx_chk()
            
         ON ACTION previous
            CALL ammt350_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt350_idx_chk()
            
         ON ACTION jump
            CALL ammt350_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt350_idx_chk()
            
         ON ACTION next
            CALL ammt350_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt350_idx_chk()
            
         ON ACTION last
            CALL ammt350_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL ammt350_idx_chk()
            
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            
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
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
 
         ON ACTION delete
 
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN 
               CALL ammt350_delete()
               #add-point:ON ACTION delete
               
               #END add-point
            END IF
 
 
         ON ACTION exclude
 
            LET g_action_choice="exclude"
            IF cl_auth_chk_act("exclude") THEN 
               #add-point:ON ACTION exclude
                              CALL ammt350_01(g_mmbo_m.mmbodocno,g_mmbo_m.mmbo001,g_mmbo_m.mmbo005,g_mmbo_m.mmbo008,g_mmbo_m.mmbosite,g_mmbo_m.mmbounit)
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL ammt350_insert()
               #add-point:ON ACTION insert
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify
 
            LET g_aw = ''
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN 
               CALL ammt350_modify()
               #add-point:ON ACTION modify
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION modify_detail
 
            LET g_aw = g_curr_diag.getCurrentItem()
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN 
               CALL ammt350_modify()
               #add-point:ON ACTION modify_detail
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
               
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL ammt350_query()
               #add-point:ON ACTION query
               
               #END add-point
            END IF
 
 
         ON ACTION remarks
 
            LET g_action_choice="remarks"
            IF cl_auth_chk_act("remarks") THEN 
               #add-point:ON ACTION remarks
                              CALL aooi360_01('6',g_mmbo_m.mmbodocno,'','','','','','','','','')
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION reproduce
 
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN 
               CALL ammt350_reproduce()
               #add-point:ON ACTION reproduce
               
               #END add-point
               EXIT DIALOG
            END IF
 
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL ammt350_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL ammt350_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL ammt350_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow(g_mmbo_m.mmbodocdt)
 
       #sakura---add---str---150107-00009#10
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
                  LET g_export_node[1] = base.typeInfo.create(g_mmbp_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_mmbp2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_mmbp3_d)
                  LET g_export_id[3]   = "s_detail3" 
                  #160613-00031#1 160615 by sakura add(S)
                  LET g_export_node[4] = base.typeInfo.create(g_mmbp4_d)
                  LET g_export_id[4]   = "s_detail4"
                  #160613-00031#1 160615 by sakura add(E)
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF                  
       #sakura---add---end---150107-00009#10       
         
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
 
{<section id="ammt350.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION ammt350_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
   DEFINE l_where           STRING #sakura add   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_mmbo_m.* TO NULL
   CALL g_mmbp_d.clear()        
   CALL g_mmbp2_d.clear() 
   CALL g_mmbp3_d.clear()
   CALL g_mmbp4_d.clear() #160613-00031#1 160615 by sakura add
 
   CALL g_browser.clear()
   
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "mmbodocno"
 
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      RETURN
   END IF
   
   #add-point:browser_fill,foreach前
   CALL s_aooi500_sql_where(g_prog,'mmbosite') RETURNING l_where #sakura add   
   LET l_wc = l_wc CLIPPED," AND mmbo004 = '1' "," AND ",l_where #sakura add l_where
   LET g_wc = g_wc CLIPPED," AND mmbo004 = '1' "," AND ",l_where #sakura add l_where
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE mmbodocno ",
 
                        " FROM mmbo_t ",
                              " ",
                              " LEFT JOIN mmbp_t ON mmbpent = mmboent AND mmbodocno = mmbpdocno ",
                              " LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno", 
 
                              " LEFT JOIN mmbr_t ON mmbrent = mmboent AND mmbodocno = mmbrdocno", 
 
 
                              " LEFT JOIN mmdj_t ON mmdjent = mmboent AND mmbrdocno = mmdjdocno AND mmbr003 = mmdj003 AND mmbr004 = mmdj004", "  ",
                              " LEFT JOIN mmbol_t ON mmbodocno = mmboldocno AND mmbol001 = '",g_lang,"' ", 
                              " ", 
                       " WHERE mmboent = '" ||g_enterprise|| "' AND mmbpent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("mmbo_t")
 
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE mmbodocno ",
 
                        " FROM mmbo_t ", 
                              " ",
                              " LEFT JOIN mmbol_t ON mmbodocno = mmboldocno AND mmbol001 = '",g_lang,"' ",
                        "WHERE mmboent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("mmbo_t")
   END IF
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前
   
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
   
   #LET g_page_action = ps_page_action          # Keep Action
   
   IF ps_page_action = "F" OR
      ps_page_action = "P" OR
      ps_page_action = "N" OR
      ps_page_action = "L" THEN
      LET g_page_action = ps_page_action
   END IF
   
   CASE ps_page_action
      WHEN "F" 
         LET g_pagestart = 1
          
      WHEN "P"  
         LET g_pagestart = g_pagestart - g_max_browse
         IF g_pagestart < 1 THEN
            LET g_pagestart = 1
         END IF
          
      WHEN "N"  
         LET g_pagestart = g_pagestart + g_max_browse
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
            WHILE g_pagestart > g_browser_cnt 
               LET g_pagestart = g_pagestart - g_max_browse
            END WHILE
         END IF
      
      WHEN "L"  
         LET g_pagestart = g_browser_cnt - (g_browser_cnt mod g_max_browse) + 1
         WHILE g_pagestart > g_browser_cnt 
            LET g_pagestart = g_pagestart - g_max_browse
         END WHILE
         
      WHEN '/'
         LET g_pagestart = g_jump
         IF g_pagestart > g_browser_cnt THEN
            LET g_pagestart = 1
         END IF
         
   END CASE
  
   #單身有輸入查詢條件且非null
   IF g_wc2 <> " 1=1" AND NOT cl_null(g_wc2) THEN 
      #依照mmbodocno,mmbodocdt,mmbo000,mmbo001,mmbo002,mmbo004,mmbo005,'',mmbo006,mmbo007,mmbo008,mmbo014,mmbo015,mmbounit,'',mmboacti Browser欄位定義(取代原本bs_sql功能) 
     #sakura---mark---str
     #LET l_sql_rank = "SELECT DISTINCT mmbostus,mmbounit,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
     #    mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti,DENSE_RANK() OVER(ORDER BY mmbodocno ", 
     #    g_order,") AS RANK ",     
     #sakura---mark---end
     #sakura---add---str
      LET l_sql_rank = "SELECT DISTINCT mmbostus,mmbosite,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
          mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti,DENSE_RANK() OVER(ORDER BY mmbodocno ", 
          g_order,") AS RANK ",
     #sakura---add---end
                        " FROM mmbo_t ",
                              " ",
                              " LEFT JOIN mmbp_t ON mmbpent = mmboent AND mmbodocno = mmbpdocno ",
                              " LEFT JOIN mmbs_t ON mmbsent = mmboent AND mmbodocno = mmbsdocno",
 
                              " LEFT JOIN mmbr_t ON mmbrent = mmboent AND mmbodocno = mmbrdocno",
 
                              " LEFT JOIN mmdj_t ON mmdjent = mmboent AND mmbrdocno = mmdjdocno AND mmbr003 = mmdj003 AND mmbr004 = mmdj004", "  ",
                              " LEFT JOIN mmbol_t ON mmbodocno = mmboldocno AND mmbol001 = '",g_lang,"' ",
                              " ",
                       " ",
                       " WHERE mmboent = '" ||g_enterprise|| "' AND ",g_wc," AND ",g_wc2, cl_sql_add_filter("mmbo_t")
   ELSE
      #單身無輸入資料
     #sakura---mark---str
     #LET l_sql_rank = "SELECT DISTINCT mmbostus,mmbounit,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
     #    mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti,DENSE_RANK() OVER(ORDER BY mmbodocno ", 
     #    g_order,") AS RANK ",     
     #sakura---mark---end
     #sakura---add---str     
      LET l_sql_rank = "SELECT DISTINCT mmbostus,mmbosite,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
          mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti,DENSE_RANK() OVER(ORDER BY mmbodocno ", 
          g_order,") AS RANK ",
     #sakura---add---end
                       " FROM mmbo_t ",
                            "  ",
                            "  LEFT JOIN mmbol_t ON mmbodocno = mmboldocno AND mmbol001 = '",g_lang,"' ",
                       " WHERE mmboent = '" ||g_enterprise|| "' AND ", g_wc, cl_sql_add_filter("mmbo_t")
   END IF
   
   #定義翻頁CURSOR
  #sakura---mark---str
  #LET g_sql= "SELECT mmbostus,mmbounit,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
  #    mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti FROM (",l_sql_rank,") WHERE ",
  #sakura---mark---end
  #sakura---add---str  
   LET g_sql= "SELECT mmbostus,mmbosite,'',mmbodocdt,mmbodocno,mmbo000,mmbo004,mmbo006,mmbo001,mmbo002,
       mmbo005,'',mmbo007,mmbo008,mmbo014,mmbo015,mmboacti FROM (",l_sql_rank,") WHERE ",	
  #sakura---add---end
              " RANK >= ",1," AND RANK<",1+g_max_browse,
              " ORDER BY ",l_searchcol," ",g_order
               
   #add-point:browser_fill,before_prepare
   
   #end add-point
               
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
   
   #add-point:browser_fill,open
   
   #end add-point
 
   CALL g_browser.clear()
   LET g_cnt = 1
 
 #FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbounit,g_browser[g_cnt].b_mmbounit_desc, #sakura mark 
  FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_mmbosite,g_browser[g_cnt].b_mmbosite_desc, #sakura add
      g_browser[g_cnt].b_mmbodocdt,g_browser[g_cnt].b_mmbodocno,g_browser[g_cnt].b_mmbo000, 
      g_browser[g_cnt].b_mmbo004,g_browser[g_cnt].b_mmbo006,g_browser[g_cnt].b_mmbo001,g_browser[g_cnt].b_mmbo002, 
      g_browser[g_cnt].b_mmbo005,g_browser[g_cnt].b_mmbo005_desc,g_browser[g_cnt].b_mmbo007, 
      g_browser[g_cnt].b_mmbo008,g_browser[g_cnt].b_mmbo014,g_browser[g_cnt].b_mmbo015, 
      g_browser[g_cnt].b_mmboacti
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
  
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
      LET g_browser[g_cnt].b_mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_browser[g_cnt].b_mmbo005_desc
 
      INITIALIZE g_ref_fields TO NULL
     #LET g_ref_fields[1] = g_browser[g_cnt].b_mmbounit #sakura mark
      LET g_ref_fields[1] = g_browser[g_cnt].b_mmbosite #skaura add
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_lang||"'", 
          "") RETURNING g_rtn_fields
     #LET g_browser[g_cnt].b_mmbounit_desc = '', g_rtn_fields[1] , '' #sakura mark
      LET g_browser[g_cnt].b_mmbosite_desc = '', g_rtn_fields[1] , '' #sakura add
     #DISPLAY BY NAME g_browser[g_cnt].b_mmbounit_desc #sakura mark
      DISPLAY BY NAME g_browser[g_cnt].b_mmbosite_desc #sakura add
 
  
      #add-point:browser_fill段reference
            IF g_browser[g_cnt].b_mmbo004 <> '1' THEN
         CONTINUE FOREACH
      END IF
      #end add-point
  
            #此段落由子樣板a24產生
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         
      END CASE
 
 
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   LET g_header_cnt = g_browser.getLength()
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   FREE browse_pre
   
   #add-point:browser_fill段結束前
   
   #end add-point
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
#      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)   #160519-00006#1   mark
      CALL cl_set_act_visible("statechange,modify,delete", FALSE)
   ELSE
#      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)   #160519-00006#1   mark
      CALL cl_set_act_visible("statechange,modify,delete", TRUE)     #160519-00006#1   add
      
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION ammt350_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_mmbo_m.mmbodocno = g_browser[g_current_idx].b_mmbodocno   
 
   EXECUTE ammt350_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno, 
       g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt
   CALL ammt350_show()
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION ammt350_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      #CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx3)   #160613-00031#1 160615 by sakura add
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx4)   #160613-00031#1 160615 by sakura add
 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION ammt350_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_mmbodocno = g_mmbo_m.mmbodocno 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   #DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammt350_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define
   
   #end add-point    
 
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_mmbo_m.* TO NULL
   CALL g_mmbp_d.clear()        
   CALL g_mmbp2_d.clear() 
 
   CALL g_mmbp3_d.clear()
   CALL g_mmbp4_d.clear() #160613-00031#1 160615 by sakura add   
 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
   INITIALIZE g_wc2_table4 TO NULL   #160613-00031#1 160615 by sakura add
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON mmbo000,mmbodocno,mmbodocdt,mmbo006,mmbo001,mmbo002,mmbol002, 
          mmbol003,mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmbo017,mmbosite,mmboacti,mmbounit,mmbostus,mmboownid, 
          mmboowndp,mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt,mmbr016_1, 
          mmbr017_1
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
                        
            #end add-point 
            
         #公用欄位開窗相關處理
         #此段落由子樣板a11產生
         ##----<<mmboownid>>----
         #ON ACTION controlp INFIELD mmboownid
         #   CALL q_common('mmbo_t','mmboownid',TRUE,FALSE,g_mmbo_m.mmboownid) RETURNING ls_return
         #   DISPLAY ls_return TO mmboownid
         #   NEXT FIELD mmboownid  
         #
         ##----<<mmboowndp>>----
         #ON ACTION controlp INFIELD mmboowndp
         #   CALL q_common('mmbo_t','mmboowndp',TRUE,FALSE,g_mmbo_m.mmboowndp) RETURNING ls_return
         #   DISPLAY ls_return TO mmboowndp
         #   NEXT FIELD mmboowndp
         #
         ##----<<mmbocrtid>>----
         #ON ACTION controlp INFIELD mmbocrtid
         #   CALL q_common('mmbo_t','mmbocrtid',TRUE,FALSE,g_mmbo_m.mmbocrtid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbocrtid
         #   NEXT FIELD mmbocrtid
         #
         ##----<<mmbocrtdp>>----
         #ON ACTION controlp INFIELD mmbocrtdp
         #   CALL q_common('mmbo_t','mmbocrtdp',TRUE,FALSE,g_mmbo_m.mmbocrtdp) RETURNING ls_return
         #   DISPLAY ls_return TO mmbocrtdp
         #   NEXT FIELD mmbocrtdp
         #
         ##----<<mmbomodid>>----
         #ON ACTION controlp INFIELD mmbomodid
         #   CALL q_common('mmbo_t','mmbomodid',TRUE,FALSE,g_mmbo_m.mmbomodid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbomodid
         #   NEXT FIELD mmbomodid
         #
         ##----<<mmbocnfid>>----
         #ON ACTION controlp INFIELD mmbocnfid
         #   CALL q_common('mmbo_t','mmbocnfid',TRUE,FALSE,g_mmbo_m.mmbocnfid) RETURNING ls_return
         #   DISPLAY ls_return TO mmbocnfid
         #   NEXT FIELD mmbocnfid
         #
         ##----<<mmbopstid>>----
         ##ON ACTION controlp INFIELD mmbopstid
         ##   CALL q_common('mmbo_t','mmbopstid',TRUE,FALSE,g_mmbo_m.mmbopstid) RETURNING ls_return
         ##   DISPLAY ls_return TO mmbopstid
         ##   NEXT FIELD mmbopstid
         
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
         #AFTER FIELD mmbopstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
            
         #一般欄位開窗相關處理    
         #---------------------------<  Master  >---------------------------
         #----<<mmbo000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo000
            #add-point:BEFORE FIELD mmbo000
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo000
            
            #add-point:AFTER FIELD mmbo000
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo000
         ON ACTION controlp INFIELD mmbo000
            #add-point:ON ACTION controlp INFIELD mmbo000
            
            #END add-point
 
         #----<<mmbodocno>>----
         #Ctrlp:construct.c.mmbodocno
         ON ACTION controlp INFIELD mmbodocno
            #add-point:ON ACTION controlp INFIELD mmbodocno
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
            CALL q_mmbodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbodocno  #顯示到畫面上

            NEXT FIELD mmbodocno                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbodocno
            #add-point:BEFORE FIELD mmbodocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbodocno
            
            #add-point:AFTER FIELD mmbodocno
            
            #END add-point
            
 
         #----<<mmbodocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbodocdt
            #add-point:BEFORE FIELD mmbodocdt
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbodocdt
            
            #add-point:AFTER FIELD mmbodocdt
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbodocdt
         ON ACTION controlp INFIELD mmbodocdt
            #add-point:ON ACTION controlp INFIELD mmbodocdt
            
            #END add-point
 
         #----<<mmbo004>>----
         #此段落由子樣板a01產生
       # BEFORE FIELD mmbo004
       #    #add-point:BEFORE FIELD mmbo004
 
       #    #END add-point
       #
       # #此段落由子樣板a02產生
       # AFTER FIELD mmbo004
       #    
       #    #add-point:AFTER FIELD mmbo004
            
       #    #END add-point
       #    
       #
       # #Ctrlp:construct.c.mmbo004
       # ON ACTION controlp INFIELD mmbo004
            #add-point:ON ACTION controlp INFIELD mmbo004
            
            #END add-point
 
         #----<<mmbo006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo006
            #add-point:BEFORE FIELD mmbo006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo006
            
            #add-point:AFTER FIELD mmbo006
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo006
         ON ACTION controlp INFIELD mmbo006
            #add-point:ON ACTION controlp INFIELD mmbo006
            
            #END add-point
 
         #----<<mmbo001>>----
         #Ctrlp:construct.c.mmbo001
         ON ACTION controlp INFIELD mmbo001
            #add-point:ON ACTION controlp INFIELD mmbo001
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '1'
            CALL q_mmbo001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbo001  #顯示到畫面上

            NEXT FIELD mmbo001                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo001
            #add-point:BEFORE FIELD mmbo001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo001
            
            #add-point:AFTER FIELD mmbo001
            
            #END add-point
            
 
         #----<<mmbo002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo002
            #add-point:BEFORE FIELD mmbo002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo002
            
            #add-point:AFTER FIELD mmbo002
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo002
         ON ACTION controlp INFIELD mmbo002
            #add-point:ON ACTION controlp INFIELD mmbo002
            
            #END add-point
 
         #----<<mmbol002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbol002
            #add-point:BEFORE FIELD mmbol002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbol002
            
            #add-point:AFTER FIELD mmbol002
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbol002
         ON ACTION controlp INFIELD mmbol002
            #add-point:ON ACTION controlp INFIELD mmbol002
            
            #END add-point
 
         #----<<mmbol003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbol003
            #add-point:BEFORE FIELD mmbol003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbol003
            
            #add-point:AFTER FIELD mmbol003
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbol003
         ON ACTION controlp INFIELD mmbol003
            #add-point:ON ACTION controlp INFIELD mmbol003
            
            #END add-point
 
         #----<<mmbo005>>----
         #Ctrlp:construct.c.mmbo005
         ON ACTION controlp INFIELD mmbo005
            #add-point:ON ACTION controlp INFIELD mmbo005
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '1'
            #CALL q_mmbo005()    #160729-00077#6 20160819 mark by beckxie 
            CALL q_mmbo005_1()   #160729-00077#6 20160819 add by beckxie 
            
            DISPLAY g_qryparam.return1 TO mmbo005  #顯示到畫面上

            NEXT FIELD mmbo005                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo005
            #add-point:BEFORE FIELD mmbo005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo005
            
            #add-point:AFTER FIELD mmbo005
            
            #END add-point
            
 
         #----<<mmbo007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo007
            #add-point:BEFORE FIELD mmbo007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo007
            
            #add-point:AFTER FIELD mmbo007
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo007
         ON ACTION controlp INFIELD mmbo007
            #add-point:ON ACTION controlp INFIELD mmbo007
            
            #END add-point
 
         #----<<mmbo008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo008
            #add-point:BEFORE FIELD mmbo008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo008
            
            #add-point:AFTER FIELD mmbo008
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo008
         ON ACTION controlp INFIELD mmbo008
            #add-point:ON ACTION controlp INFIELD mmbo008
            
            #END add-point
 
         #----<<mmbo014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo014
            #add-point:BEFORE FIELD mmbo014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo014
            
            #add-point:AFTER FIELD mmbo014
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo014
         ON ACTION controlp INFIELD mmbo014
            #add-point:ON ACTION controlp INFIELD mmbo014
            
            #END add-point
 
         #----<<mmbo015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo015
            #add-point:BEFORE FIELD mmbo015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo015
            
            #add-point:AFTER FIELD mmbo015
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbo015
         ON ACTION controlp INFIELD mmbo015
            #add-point:ON ACTION controlp INFIELD mmbo015
            
            #END add-point
 
         #----<<mmbosite>>----
         #Ctrlp:construct.c.mmbosite
         ON ACTION controlp INFIELD mmbosite
            #add-point:ON ACTION controlp INFIELD mmbosite
                        #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			  #LET g_qryparam.arg1 = '2'
			  #LET g_qryparam.where = "ooef201 = 'Y'"              #sakura mark
           #CALL q_ooef001()                           #呼叫開窗 #sakura mark
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbosite',g_site,'c') #sakura add  #150308-00001#4  By benson add 'c'
            CALL q_ooef001_24()                     #呼叫開窗                   #sakura add            
            DISPLAY g_qryparam.return1 TO mmbosite  #顯示到畫面上

            NEXT FIELD mmbosite                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbosite
            #add-point:BEFORE FIELD mmbosite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbosite
            
            #add-point:AFTER FIELD mmbosite
            
            #END add-point
            
 
         #----<<mmboacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmboacti
            #add-point:BEFORE FIELD mmboacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmboacti
            
            #add-point:AFTER FIELD mmboacti
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmboacti
         ON ACTION controlp INFIELD mmboacti
            #add-point:ON ACTION controlp INFIELD mmboacti
            
            #END add-point
 
         #----<<mmbounit>>----
         #Ctrlp:construct.c.mmbounit
         ON ACTION controlp INFIELD mmbounit
            #add-point:ON ACTION controlp INFIELD mmbounit
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbounit
            #add-point:BEFORE FIELD mmbounit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbounit
            
            #add-point:AFTER FIELD mmbounit
            
            #END add-point
            
 
         #----<<mmbostus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbostus
            #add-point:BEFORE FIELD mmbostus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbostus
            
            #add-point:AFTER FIELD mmbostus
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbostus
         ON ACTION controlp INFIELD mmbostus
            #add-point:ON ACTION controlp INFIELD mmbostus
            
            #END add-point
 
         #----<<mmboownid>>----
         #Ctrlp:construct.c.mmboownid
         ON ACTION controlp INFIELD mmboownid
            #add-point:ON ACTION controlp INFIELD mmboownid
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmboownid  #顯示到畫面上

            NEXT FIELD mmboownid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmboownid
            #add-point:BEFORE FIELD mmboownid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmboownid
            
            #add-point:AFTER FIELD mmboownid
            
            #END add-point
            
 
         #----<<mmboowndp>>----
         #Ctrlp:construct.c.mmboowndp
         ON ACTION controlp INFIELD mmboowndp
            #add-point:ON ACTION controlp INFIELD mmboowndp
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmboowndp  #顯示到畫面上

            NEXT FIELD mmboowndp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmboowndp
            #add-point:BEFORE FIELD mmboowndp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmboowndp
            
            #add-point:AFTER FIELD mmboowndp
            
            #END add-point
            
 
         #----<<mmbocrtid>>----
         #Ctrlp:construct.c.mmbocrtid
         ON ACTION controlp INFIELD mmbocrtid
            #add-point:ON ACTION controlp INFIELD mmbocrtid
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocrtid  #顯示到畫面上

            NEXT FIELD mmbocrtid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbocrtid
            #add-point:BEFORE FIELD mmbocrtid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbocrtid
            
            #add-point:AFTER FIELD mmbocrtid
            
            #END add-point
            
 
         #----<<mmbocrtdp>>----
         #Ctrlp:construct.c.mmbocrtdp
         ON ACTION controlp INFIELD mmbocrtdp
            #add-point:ON ACTION controlp INFIELD mmbocrtdp
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocrtdp  #顯示到畫面上

            NEXT FIELD mmbocrtdp                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbocrtdp
            #add-point:BEFORE FIELD mmbocrtdp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbocrtdp
            
            #add-point:AFTER FIELD mmbocrtdp
            
            #END add-point
            
 
         #----<<mmbocrtdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbocrtdt
            #add-point:BEFORE FIELD mmbocrtdt
            
            #END add-point
 
         #----<<mmbomodid>>----
         #Ctrlp:construct.c.mmbomodid
         ON ACTION controlp INFIELD mmbomodid
            #add-point:ON ACTION controlp INFIELD mmbomodid
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbomodid  #顯示到畫面上

            NEXT FIELD mmbomodid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbomodid
            #add-point:BEFORE FIELD mmbomodid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbomodid
            
            #add-point:AFTER FIELD mmbomodid
            
            #END add-point
            
 
         #----<<mmbomoddt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbomoddt
            #add-point:BEFORE FIELD mmbomoddt
            
            #END add-point
 
         #----<<mmbocnfid>>----
         #Ctrlp:construct.c.mmbocnfid
         ON ACTION controlp INFIELD mmbocnfid
            #add-point:ON ACTION controlp INFIELD mmbocnfid
                        #此段落由子樣板a08產生
            #開窗c段
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbocnfid  #顯示到畫面上

            NEXT FIELD mmbocnfid                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbocnfid
            #add-point:BEFORE FIELD mmbocnfid
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbocnfid
            
            #add-point:AFTER FIELD mmbocnfid
            
            #END add-point
            
 
         #----<<mmbocnfdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbocnfdt
            #add-point:BEFORE FIELD mmbocnfdt
            
            #END add-point
 
         #----<<mmbr016_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr016_1
            #add-point:BEFORE FIELD mmbr016_1
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr016_1
            
            #add-point:AFTER FIELD mmbr016_1
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbr016_1
         ON ACTION controlp INFIELD mmbr016_1
            #add-point:ON ACTION controlp INFIELD mmbr016_1
            
            #END add-point
 
         #----<<mmbr017_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr017_1
            #add-point:BEFORE FIELD mmbr017_1
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr017_1
            
            #add-point:AFTER FIELD mmbr017_1
            
            #END add-point
            
 
         #Ctrlp:construct.c.mmbr017_1
         ON ACTION controlp INFIELD mmbr017_1
            #add-point:ON ACTION controlp INFIELD mmbr017_1
            
            #END add-point
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON mmbpunit,mmbpsite,mmbp001,mmbp003,mmbp004,mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010, 
          mmbpacti
           FROM s_detail1[1].mmbpunit,s_detail1[1].mmbpsite,s_detail1[1].mmbp001,s_detail1[1].mmbp003, 
               s_detail1[1].mmbp004,s_detail1[1].mmbp005,s_detail1[1].mmbp006,s_detail1[1].mmbp007,s_detail1[1].mmbp008,
               s_detail1[1].mmbp009,s_detail1[1].mmbp010,
               s_detail1[1].mmbpacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
         #----<<mmbpunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpunit
            #add-point:BEFORE FIELD mmbpunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpunit
            
            #add-point:AFTER FIELD mmbpunit
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbpunit
         ON ACTION controlp INFIELD mmbpunit
            #add-point:ON ACTION controlp INFIELD mmbpunit
            
            #END add-point
 
         #----<<mmbpsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpsite
            #add-point:BEFORE FIELD mmbpsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpsite
            
            #add-point:AFTER FIELD mmbpsite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbpsite
         ON ACTION controlp INFIELD mmbpsite
            #add-point:ON ACTION controlp INFIELD mmbpsite
            
            #END add-point
 
         #----<<mmbp001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp001
            #add-point:BEFORE FIELD mmbp001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp001
            
            #add-point:AFTER FIELD mmbp001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp001
         ON ACTION controlp INFIELD mmbp001
            #add-point:ON ACTION controlp INFIELD mmbp001
            
            #END add-point
 
         #----<<mmbp003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp003
            #add-point:BEFORE FIELD mmbp003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp003
            
            #add-point:AFTER FIELD mmbp003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp003
         ON ACTION controlp INFIELD mmbp003
            #add-point:ON ACTION controlp INFIELD mmbp003
            
            #END add-point
 
         #----<<mmbp004>>----
         #Ctrlp:construct.c.page1.mmbp004
         ON ACTION controlp INFIELD mmbp004
            #add-point:ON ACTION controlp INFIELD mmbp004
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmbp004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbp004  #顯示到畫面上

            NEXT FIELD mmbp004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp004
            #add-point:BEFORE FIELD mmbp004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp004
            
            #add-point:AFTER FIELD mmbp004
            
            #END add-point
            
 
         #----<<mmbp005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp005
            #add-point:BEFORE FIELD mmbp005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp005
            
            #add-point:AFTER FIELD mmbp005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp005
         ON ACTION controlp INFIELD mmbp005
            #add-point:ON ACTION controlp INFIELD mmbp005
            
            #END add-point
 
         #----<<mmbp006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp006
            #add-point:BEFORE FIELD mmbp006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp006
            
            #add-point:AFTER FIELD mmbp006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp006
         ON ACTION controlp INFIELD mmbp006
            #add-point:ON ACTION controlp INFIELD mmbp006
            
            #END add-point
 
         #----<<mmbp007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp007
            #add-point:BEFORE FIELD mmbp007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp007
            
            #add-point:AFTER FIELD mmbp007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp007
         ON ACTION controlp INFIELD mmbp007
            #add-point:ON ACTION controlp INFIELD mmbp007
            
            #END add-point
 
         #----<<mmbp008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp008
            #add-point:BEFORE FIELD mmbp008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp008
            
            #add-point:AFTER FIELD mmbp008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbp008
         ON ACTION controlp INFIELD mmbp008
            #add-point:ON ACTION controlp INFIELD mmbp008
            
            #END add-point
 
         #----<<mmbpacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpacti
            #add-point:BEFORE FIELD mmbpacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpacti
            
            #add-point:AFTER FIELD mmbpacti
            
            #END add-point
            
 
         #Ctrlp:construct.c.page1.mmbpacti
         ON ACTION controlp INFIELD mmbpacti
            #add-point:ON ACTION controlp INFIELD mmbpacti
            
            #END add-point
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti
           FROM s_detail2[1].mmbsunit,s_detail2[1].mmbssite,s_detail2[1].mmbs001,s_detail2[1].mmbs002, 
               s_detail2[1].mmbs003,s_detail2[1].mmbs004,s_detail2[1].mmbs005,s_detail2[1].mmbsacti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page2  >---------------------
         #----<<mmbsunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbsunit
            #add-point:BEFORE FIELD mmbsunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbsunit
            
            #add-point:AFTER FIELD mmbsunit
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbsunit
         ON ACTION controlp INFIELD mmbsunit
            #add-point:ON ACTION controlp INFIELD mmbsunit
            
            #END add-point
 
         #----<<mmbssite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbssite
            #add-point:BEFORE FIELD mmbssite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbssite
            
            #add-point:AFTER FIELD mmbssite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbssite
         ON ACTION controlp INFIELD mmbssite
            #add-point:ON ACTION controlp INFIELD mmbssite
            
            #END add-point
 
         #----<<mmbs001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs001
            #add-point:BEFORE FIELD mmbs001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs001
            
            #add-point:AFTER FIELD mmbs001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbs001
         ON ACTION controlp INFIELD mmbs001
            #add-point:ON ACTION controlp INFIELD mmbs001
            
            #END add-point
 
         #----<<mmbs002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs002
            #add-point:BEFORE FIELD mmbs002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs002
            
            #add-point:AFTER FIELD mmbs002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbs002
         ON ACTION controlp INFIELD mmbs002
            #add-point:ON ACTION controlp INFIELD mmbs002
            
            #END add-point
 
         #----<<mmbs003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs003
            #add-point:BEFORE FIELD mmbs003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs003
            
            #add-point:AFTER FIELD mmbs003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbs003
         ON ACTION controlp INFIELD mmbs003
            #add-point:ON ACTION controlp INFIELD mmbs003
            
            #END add-point
 
         #----<<mmbs004>>----
         #Ctrlp:construct.c.page2.mmbs004
         ON ACTION controlp INFIELD mmbs004
            #add-point:ON ACTION controlp INFIELD mmbs004
                        #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			#LET g_qryparam.arg1 = '2'
#			   LET g_qryparam.where = "ooef201 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbs004',g_site,'c')   #150308-00001#4  By benson add 'c'
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.where = "ooef201 = 'Y'"
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO mmbs004  #顯示到畫面上

            NEXT FIELD mmbs004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs004
            #add-point:BEFORE FIELD mmbs004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs004
            
            #add-point:AFTER FIELD mmbs004
            
            #END add-point
            
 
         #----<<mmbs005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs005
            #add-point:BEFORE FIELD mmbs005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs005
            
            #add-point:AFTER FIELD mmbs005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbs005
         ON ACTION controlp INFIELD mmbs005
            #add-point:ON ACTION controlp INFIELD mmbs005
            
            #END add-point
 
         #----<<mmbsacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbsacti
            #add-point:BEFORE FIELD mmbsacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbsacti
            
            #add-point:AFTER FIELD mmbsacti
            
            #END add-point
            
 
         #Ctrlp:construct.c.page2.mmbsacti
         ON ACTION controlp INFIELD mmbsacti
            #add-point:ON ACTION controlp INFIELD mmbsacti
            
            #END add-point
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr003,mmbr004,mmbr005,mmbr006,mmbr007, 
          mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019, 
          mmbracti
           FROM s_detail3[1].mmbrunit,s_detail3[1].mmbrsite,s_detail3[1].mmbr001,s_detail3[1].mmbr002, 
               s_detail3[1].mmbr003,s_detail3[1].mmbr004,s_detail3[1].mmbr005,s_detail3[1].mmbr006,s_detail3[1].mmbr007, 
               s_detail3[1].mmbr008,s_detail3[1].mmbr009,s_detail3[1].mmbr010,s_detail3[1].mmbr011,s_detail3[1].mmbr012, 
               s_detail3[1].mmbr013,s_detail3[1].mmbr014,s_detail3[1].mmbr015,s_detail3[1].mmbr016,s_detail3[1].mmbr017, 
               s_detail3[1].mmbr018,s_detail3[1].mmbr019,s_detail3[1].mmbracti
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
       #---------------------<  Detail: page3  >---------------------
         #----<<mmbrunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbrunit
            #add-point:BEFORE FIELD mmbrunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbrunit
            
            #add-point:AFTER FIELD mmbrunit
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbrunit
         ON ACTION controlp INFIELD mmbrunit
            #add-point:ON ACTION controlp INFIELD mmbrunit
            
            #END add-point
 
         #----<<mmbrsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbrsite
            #add-point:BEFORE FIELD mmbrsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbrsite
            
            #add-point:AFTER FIELD mmbrsite
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbrsite
         ON ACTION controlp INFIELD mmbrsite
            #add-point:ON ACTION controlp INFIELD mmbrsite
            
            #END add-point
 
         #----<<mmbr001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr001
            #add-point:BEFORE FIELD mmbr001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr001
            
            #add-point:AFTER FIELD mmbr001
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr001
         ON ACTION controlp INFIELD mmbr001
            #add-point:ON ACTION controlp INFIELD mmbr001
            
            #END add-point
 
         #----<<mmbr002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr002
            #add-point:BEFORE FIELD mmbr002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr002
            
            #add-point:AFTER FIELD mmbr002
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr002
         ON ACTION controlp INFIELD mmbr002
            #add-point:ON ACTION controlp INFIELD mmbr002
            
            #END add-point
 
         #----<<mmbr003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr003
            #add-point:BEFORE FIELD mmbr003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr003
            
            #add-point:AFTER FIELD mmbr003
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr003
         ON ACTION controlp INFIELD mmbr003
            #add-point:ON ACTION controlp INFIELD mmbr003
            
            #END add-point
 
         #----<<mmbr004>>----
         #Ctrlp:construct.c.page3.mmbr004
         ON ACTION controlp INFIELD mmbr004
            #add-point:ON ACTION controlp INFIELD mmbr004
                        #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmbr004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmbr004  #顯示到畫面上

            NEXT FIELD mmbr004                     #返回原欄位


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr004
            #add-point:BEFORE FIELD mmbr004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr004
            
            #add-point:AFTER FIELD mmbr004
            
            #END add-point
            
 
         #----<<mmbr005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr005
            #add-point:BEFORE FIELD mmbr005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr005
            
            #add-point:AFTER FIELD mmbr005
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr005
         ON ACTION controlp INFIELD mmbr005
            #add-point:ON ACTION controlp INFIELD mmbr005
            
            #END add-point
 
         #----<<mmbr006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr006
            #add-point:BEFORE FIELD mmbr006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr006
            
            #add-point:AFTER FIELD mmbr006
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr006
         ON ACTION controlp INFIELD mmbr006
            #add-point:ON ACTION controlp INFIELD mmbr006
            
            #END add-point
 
         #----<<mmbr007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr007
            #add-point:BEFORE FIELD mmbr007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr007
            
            #add-point:AFTER FIELD mmbr007
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr007
         ON ACTION controlp INFIELD mmbr007
            #add-point:ON ACTION controlp INFIELD mmbr007
            
            #END add-point
 
         #----<<mmbr008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr008
            #add-point:BEFORE FIELD mmbr008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr008
            
            #add-point:AFTER FIELD mmbr008
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr008
         ON ACTION controlp INFIELD mmbr008
            #add-point:ON ACTION controlp INFIELD mmbr008
            
            #END add-point
 
         #----<<mmbr009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr009
            #add-point:BEFORE FIELD mmbr009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr009
            
            #add-point:AFTER FIELD mmbr009
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr009
         ON ACTION controlp INFIELD mmbr009
            #add-point:ON ACTION controlp INFIELD mmbr009
            
            #END add-point
 
         #----<<mmbr010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr010
            #add-point:BEFORE FIELD mmbr010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr010
            
            #add-point:AFTER FIELD mmbr010
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr010
         ON ACTION controlp INFIELD mmbr010
            #add-point:ON ACTION controlp INFIELD mmbr010
            
            #END add-point
 
         #----<<mmbr011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr011
            #add-point:BEFORE FIELD mmbr011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr011
            
            #add-point:AFTER FIELD mmbr011
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr011
         ON ACTION controlp INFIELD mmbr011
            #add-point:ON ACTION controlp INFIELD mmbr011
            
            #END add-point
 
         #----<<mmbr012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr012
            #add-point:BEFORE FIELD mmbr012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr012
            
            #add-point:AFTER FIELD mmbr012
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr012
         ON ACTION controlp INFIELD mmbr012
            #add-point:ON ACTION controlp INFIELD mmbr012
            
            #END add-point
 
         #----<<mmbr013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr013
            #add-point:BEFORE FIELD mmbr013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr013
            
            #add-point:AFTER FIELD mmbr013
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr013
         ON ACTION controlp INFIELD mmbr013
            #add-point:ON ACTION controlp INFIELD mmbr013
            
            #END add-point
 
         #----<<mmbr014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr014
            #add-point:BEFORE FIELD mmbr014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr014
            
            #add-point:AFTER FIELD mmbr014
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr014
         ON ACTION controlp INFIELD mmbr014
            #add-point:ON ACTION controlp INFIELD mmbr014
            
            #END add-point
 
         #----<<mmbr015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr015
            #add-point:BEFORE FIELD mmbr015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr015
            
            #add-point:AFTER FIELD mmbr015
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr015
         ON ACTION controlp INFIELD mmbr015
            #add-point:ON ACTION controlp INFIELD mmbr015
            
            #END add-point
 
         #----<<mmbr016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr016
            #add-point:BEFORE FIELD mmbr016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr016
            
            #add-point:AFTER FIELD mmbr016
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr016
         ON ACTION controlp INFIELD mmbr016
            #add-point:ON ACTION controlp INFIELD mmbr016
            
            #END add-point
 
         #----<<mmbr017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr017
            #add-point:BEFORE FIELD mmbr017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr017
            
            #add-point:AFTER FIELD mmbr017
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr017
         ON ACTION controlp INFIELD mmbr017
            #add-point:ON ACTION controlp INFIELD mmbr017
            
            #END add-point
 
         #----<<mmbr018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr018
            #add-point:BEFORE FIELD mmbr018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr018
            
            #add-point:AFTER FIELD mmbr018
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr018
         ON ACTION controlp INFIELD mmbr018
            #add-point:ON ACTION controlp INFIELD mmbr018
            
            #END add-point
 
         #----<<mmbr019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr019
            #add-point:BEFORE FIELD mmbr019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr019
            
            #add-point:AFTER FIELD mmbr019
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbr019
         ON ACTION controlp INFIELD mmbr019
            #add-point:ON ACTION controlp INFIELD mmbr019
            
            #END add-point
 
         #----<<mmbracti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbracti
            #add-point:BEFORE FIELD mmbracti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbracti
            
            #add-point:AFTER FIELD mmbracti
            
            #END add-point
            
 
         #Ctrlp:construct.c.page3.mmbracti
         ON ACTION controlp INFIELD mmbracti
            #add-point:ON ACTION controlp INFIELD mmbracti
            
            #END add-point
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令)
      #160613-00031#1 160615 by sakura add(S)
      CONSTRUCT g_wc2_table4 ON mmdj005,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti
           FROM s_detail4[1].mmdj005,s_detail4[1].mmdj006,s_detail4[1].mmdj007,s_detail4[1].mmdj008, 
               s_detail4[1].mmdj009,s_detail4[1].mmdj010,s_detail4[1].mmdj011,s_detail4[1].mmdjacti   
      END CONSTRUCT      
      #160613-00031#1 160615 by sakura add(E)
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         DISPLAY '1' TO mmbo004
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
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
   IF g_wc2_table3 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table3
   END IF
 
 
 
 
   
   #add-point:cs段結束前
   #160613-00031#1 160615 by sakura add(S)
   IF g_wc2_table4 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND EXISTS(SELECT 1 FROM mmdj_t ",
                         "             WHERE mmbrent = mmdjent AND mmbrdocno = mmdjdocno ",
                         "               AND mmbr003 = mmdj003 AND mmbr004 = mmdj004 ",
                         "               AND mmdjent = ",g_enterprise,
                         "               AND ",g_wc2_table4," ) "
   END IF 
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.filter" >}
#+ 此段落由子樣板a50產生
#+ filter過濾功能
PRIVATE FUNCTION ammt350_filter()
   #add-point:filter段define
   
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
      CONSTRUCT g_wc_filter ON mmbodocno,mmbodocdt,mmbo000,mmbo001,mmbo002,mmbo004,mmbo005,mmbo006,mmbo007, 
          mmbo008,mmbo014,mmbo015,mmbounit,mmboacti
                          FROM s_browse[1].b_mmbodocno,s_browse[1].b_mmbodocdt,s_browse[1].b_mmbo000, 
                              s_browse[1].b_mmbo001,s_browse[1].b_mmbo002,s_browse[1].b_mmbo004,s_browse[1].b_mmbo005, 
                              s_browse[1].b_mmbo006,s_browse[1].b_mmbo007,s_browse[1].b_mmbo008,s_browse[1].b_mmbo014, 
                              s_browse[1].b_mmbo015,s_browse[1].b_mmbounit,s_browse[1].b_mmboacti
 
         BEFORE CONSTRUCT
               DISPLAY ammt350_filter_parser('mmbodocno') TO s_browse[1].b_mmbodocno
            DISPLAY ammt350_filter_parser('mmbodocdt') TO s_browse[1].b_mmbodocdt
            DISPLAY ammt350_filter_parser('mmbo000') TO s_browse[1].b_mmbo000
            DISPLAY ammt350_filter_parser('mmbo001') TO s_browse[1].b_mmbo001
            DISPLAY ammt350_filter_parser('mmbo002') TO s_browse[1].b_mmbo002
            DISPLAY ammt350_filter_parser('mmbo004') TO s_browse[1].b_mmbo004
            DISPLAY ammt350_filter_parser('mmbo005') TO s_browse[1].b_mmbo005
            DISPLAY ammt350_filter_parser('mmbo006') TO s_browse[1].b_mmbo006
            DISPLAY ammt350_filter_parser('mmbo007') TO s_browse[1].b_mmbo007
            DISPLAY ammt350_filter_parser('mmbo008') TO s_browse[1].b_mmbo008
            DISPLAY ammt350_filter_parser('mmbo014') TO s_browse[1].b_mmbo014
            DISPLAY ammt350_filter_parser('mmbo015') TO s_browse[1].b_mmbo015
            DISPLAY ammt350_filter_parser('mmbounit') TO s_browse[1].b_mmbounit
            DISPLAY ammt350_filter_parser('mmboacti') TO s_browse[1].b_mmboacti
      
         #add-point:filter段cs_ctrl
         
         #end add-point
      
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
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL ammt350_filter_show('mmbodocno')
   CALL ammt350_filter_show('mmbodocdt')
   CALL ammt350_filter_show('mmbo000')
   CALL ammt350_filter_show('mmbo001')
   CALL ammt350_filter_show('mmbo002')
   CALL ammt350_filter_show('mmbo004')
   CALL ammt350_filter_show('mmbo005')
   CALL ammt350_filter_show('mmbo006')
   CALL ammt350_filter_show('mmbo007')
   CALL ammt350_filter_show('mmbo008')
   CALL ammt350_filter_show('mmbo014')
   CALL ammt350_filter_show('mmbo015')
   CALL ammt350_filter_show('mmbounit')
   CALL ammt350_filter_show('mmboacti')
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION ammt350_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
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
 
{<section id="ammt350.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION ammt350_filter_show(ps_field)
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
   LET ls_condition = ammt350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION ammt350_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
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
   CALL g_mmbp_d.clear()
   CALL g_mmbp2_d.clear()
   CALL g_mmbp3_d.clear()
 
   
   #add-point:query段other
   CALL g_mmbp4_d.clear() #160613-00031#1 160615 by sakura add
   #end add-point   
   
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL ammt350_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL ammt350_browser_fill("")
      CALL ammt350_fetch("")
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
   LET g_detail_idx3 = 1   #160613-00031#1 160615 by sakura add
   LET g_detail_idx4 = 1   #160613-00031#1 160615 by sakura add
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL ammt350_filter_show('mmbodocno')
   CALL ammt350_filter_show('mmbodocdt')
   CALL ammt350_filter_show('mmbo000')
   CALL ammt350_filter_show('mmbo001')
   CALL ammt350_filter_show('mmbo002')
   CALL ammt350_filter_show('mmbo004')
   CALL ammt350_filter_show('mmbo005')
   CALL ammt350_filter_show('mmbo006')
   CALL ammt350_filter_show('mmbo007')
   CALL ammt350_filter_show('mmbo008')
   CALL ammt350_filter_show('mmbo014')
   CALL ammt350_filter_show('mmbo015')
   CALL ammt350_filter_show('mmbounit')
   CALL ammt350_filter_show('mmboacti')
   CALL ammt350_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "-100"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
   ELSE
      CALL ammt350_fetch("F") 
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION ammt350_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point    
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
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
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
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
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_mmbo_m.mmbodocno = g_browser[g_current_idx].b_mmbodocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE ammt350_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno, 
       g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "mmbo_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      INITIALIZE g_mmbo_m.* TO NULL
      RETURN
   END IF
   
   #add-point:fetch段action控制
#       IF g_mmbo_m.mmbostus = 'Y' OR g_mmbo_m.mmbostus = 'X' THEN
#      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", FALSE)
#   ELSE
#      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
#   END IF
#   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)    #160519-00006#1   mark
   CALL cl_set_act_visible("modify,modify_detail,delete", TRUE)#取消复制功能   #160519-00006#1   add
   IF g_mmbo_m.mmbostus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
#      CALL cl_set_act_visible("modify,delete,modify_detail,reproduce", FALSE)   #160519-00006#1   mark
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE) #160519-00006#1   add
   END IF
   
   #end add-point  
   
   
   
   #add-point:fetch結束前
   
   #end add-point
   
   #LET g_data_owner =       
   #LET g_data_group =   
   
   #重新顯示   
   CALL ammt350_show()
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.insert" >}
#+ 資料新增
PRIVATE FUNCTION ammt350_insert()
   #add-point:insert段define
   #ken---add---s 需求單號：141125-00002 項次：4
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_doctype     LIKE rtai_t.rtai004    
   #ken---add---e
   DEFINE l_insert      LIKE type_t.num5 #sakura add   
   #end add-point    
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_mmbp_d.clear()   
   CALL g_mmbp2_d.clear()  
   CALL g_mmbp3_d.clear()
   CALL g_mmbp4_d.clear() #160613-00031#1 160615 by sakura add   
 
 
   INITIALIZE g_mmbo_m.* LIKE mmbo_t.*             #DEFAULT 設定
   
   LET g_mmbodocno_t = NULL
   
   LET g_master_insert = FALSE  #160613-00031#1 160615 by sakura add
 
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #此段落由子樣板a14產生    
      LET g_mmbo_m.mmboownid = g_user
      LET g_mmbo_m.mmboowndp = g_dept
      LET g_mmbo_m.mmbocrtid = g_user
      LET g_mmbo_m.mmbocrtdp = g_dept 
      LET g_mmbo_m.mmbocrtdt = cl_get_current()
      LET g_mmbo_m.mmbomodid = ""
      LET g_mmbo_m.mmbomoddt = ""
      #LET g_mmbo_m.mmbostus = ""
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_mmbo_m.mmbo000 = "I"
      LET g_mmbo_m.mmbo004 = "1"
     #LET g_mmbo_m.mmbo002 = "1" #sakura mark
      LET g_mmbo_m.mmbo002 = "0" #sakura add
      LET g_mmbo_m.mmbo007 = "0"
      LET g_mmbo_m.mmbo008 = "0"
      LET g_mmbo_m.mmboacti = "Y"
      LET g_mmbo_m.mmbostus = "N"
 
  
      #add-point:單頭預設值
      INITIALIZE g_mmbo_m_t.* TO NULL
      INITIALIZE g_mmbo_m_o.* TO NULL
      #sakura---add---str
      CALL s_aooi500_default(g_prog,'mmbosite',g_mmbo_m.mmbosite)
         RETURNING l_insert,g_mmbo_m.mmbosite
      IF l_insert = FALSE THEN
         RETURN
      END IF
      LET g_mmbo_m.mmbounit = g_mmbo_m.mmbosite      
      #sakura---add---end       
      LET g_mmbo_m.mmbodocdt = g_today
     #LET g_mmbo_m.mmbounit  = g_site #sakura mark
     #LET g_mmbo_m.mmbosite  = g_site #sakura mark
      LET g_mmbo_m.mmbostus = 'N'
      LET g_mmbo_m.mmbo017 = "1"    
      CALL ammt350_mmbosite_ref()
      
      #ken---add---s 需求單號：141125-00002 項次：4
      #預設單據的單別 
      LET l_success = ''
      LET l_doctype = ''
      CALL s_arti200_get_def_doc_type(g_mmbo_m.mmbosite,g_prog,'1')
           RETURNING l_success, l_doctype
      LET g_mmbo_m.mmbodocno = l_doctype
      #ken---add---e
      LET g_site_flag = FALSE         #sakura add
      LET g_mmbo_m_t.* = g_mmbo_m.*
      
      #end add-point 
     
      CALL ammt350_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_mmbo_m.* = g_mmbo_m_t.*
         CALL ammt350_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      CALL g_mmbp_d.clear()
      CALL g_mmbp2_d.clear()
      CALL g_mmbp3_d.clear()
      CALL g_mmbp4_d.clear() #160613-00031#1 160615 by sakura add
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   LET g_state = "Y"
   
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   
   LET g_wc = g_wc,  
              " OR ( mmboent = '" ||g_enterprise|| "' AND",
              " mmbodocno = '", g_mmbo_m.mmbodocno CLIPPED, "' "
 
              , ") "
   
   CLOSE ammt350_cl
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.modify" >}
#+ 資料修改
PRIVATE FUNCTION ammt350_modify()
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   #add-point:modify段define
   
   #end add-point    
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE ammt350_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno, 
       g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt
 
   ERROR ""
  
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   CALL s_transaction_begin()
   
   OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN ammt350_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE ammt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH ammt350_cl INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
       g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc, 
       g_mmbo_m.mmboacti,g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp, 
       g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt, 
       g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbr004_1,g_mmbo_m.mmbr014_1, 
       g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr018_1,g_mmbo_m.mmbr004_1_desc,g_mmbo_m.mmbr015_1,g_mmbo_m.mmbr017_1, 
       g_mmbo_m.mmbr019_1
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_mmbo_m.mmbodocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      CLOSE ammt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   
   
   #add-point:modify段show之前
   #160818-00017#21 by 08742 --S
   #檢查是否允許此動作
   IF NOT ammt350_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#21 by 08742 --E
   #end add-point  
   
   CALL ammt350_show()
   WHILE TRUE
      LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_mmbo_m.mmbomodid = g_user 
LET g_mmbo_m.mmbomoddt = cl_get_current()
 
      
      #add-point:modify段修改前
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_mmbo_m.mmbostus MATCHES "[DR]" THEN 
         LET g_mmbo_m.mmbostus = "N"
      END IF
      
      #end add-point
      
      CALL ammt350_input("u")     #欄位更改
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_mmbo_m.* = g_mmbo_m_t.*
         CALL ammt350_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_mmbo_m.mmbodocno != g_mmbodocno_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前
         
         #end add-point
         
         #更新單身key值
         UPDATE mmbp_t SET mmbpdocno = g_mmbo_m.mmbodocno
 
          WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbodocno_t
 
            
         #add-point:單身fk修改中
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前
         
         #end add-point
         UPDATE mmbs_t
            SET mmbsdocno = g_mmbo_m.mmbodocno
 
          WHERE mmbsent = g_enterprise AND
                mmbsdocno = g_mmbodocno_t
 
         #add-point:單身fk修改中
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "mmbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前
         
         #end add-point
         UPDATE mmbr_t
            SET mmbrdocno = g_mmbo_m.mmbodocno
 
          WHERE mmbrent = g_enterprise AND
                mmbrdocno = g_mmbodocno_t
 
         #add-point:單身fk修改中
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00009"
               LET g_errparam.extend = "mmbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #修改歷程記錄
   IF NOT cl_log_modified_record(g_mmbo_m.mmbodocno,g_site) THEN 
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE ammt350_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_mmbo_m.mmbodocno,'U')
 
END FUNCTION   
 
{</section>}
 
{<section id="ammt350.input" >}
#+ 資料輸入
PRIVATE FUNCTION ammt350_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5  #sakura add
   DEFINE  l_errno               LIKE type_t.chr10 #sakura add
   DEFINE  l_where               STRING            #sakura add 
   DEFINE  l_ac_t                LIKE type_t.num10  #160613-00031#1 160615 by sakura add
   #160627-00005#2 160627 by sakura add(S)
   DEFINE l_oofg_return    DYNAMIC ARRAY OF RECORD
            oofg019        LIKE oofg_t.oofg019,  #field
            oofg020        LIKE oofg_t.oofg020   #value
                           END RECORD
   DEFINE l_count_chk      LIKE type_t.num5
   #160627-00005#2 160627 by sakura add(E)
   #end add-point  
 
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
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
   LET g_forupd_sql = "SELECT mmbpunit,mmbpsite,mmbp001,mmbp002,mmbp003,mmbp004,'',mmbp005,mmbp006,mmbp007, 
       mmbp008,mmbpacti FROM mmbp_t WHERE mmbpent=? AND mmbpdocno=? AND mmbp003=? AND mmbp004=? FOR  
       UPDATE"
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammt350_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs004,'',mmbs005,mmbsacti  
       FROM mmbs_t WHERE mmbsent=? AND mmbsdocno=? AND mmbs004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammt350_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql
   
   #end add-point    
   LET g_forupd_sql = "SELECT mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr003,mmbr004,'',mmbr005,mmbr006,mmbr007, 
       mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019, 
       mmbracti FROM mmbr_t WHERE mmbrent=? AND mmbrdocno=? AND mmbr003=? AND mmbr004=? FOR UPDATE"
   #add-point:input段define_sql
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE ammt350_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql
   #160613-00031#1 160615 by sakura add(S)
   LET g_forupd_sql = "SELECT mmdj005,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti FROM  
       mmdj_t WHERE mmdjent=? AND mmdjdocno=? AND mmdj003=? AND mmdj004=? AND mmdj005=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammt350_bcl4 CURSOR FROM g_forupd_sql   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL ammt350_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL ammt350_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
       g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo007, 
       g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti,g_mmbo_m.mmbounit, 
       g_mmbo_m.mmbostus,g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr017_1
   
   LET lb_reproduce = FALSE
   
   #add-point:資料輸入前
   DISPLAY BY NAME g_mmbo_m.mmbo017
   
   LET g_ooef004 = ''
    LET g_ooef005 = ''
    SELECT ooef004,ooef005 INTO g_ooef004,g_ooef005 
      FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   IF cl_null(g_ooef004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00007'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
   IF cl_null(g_ooef005) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00008'
      LET g_errparam.extend = g_site
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF 
    LET g_mmbo_m_o.* = g_mmbo_m.* 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
 
{</section>}
 
{<section id="ammt350.input.head" >}
      #單頭段
      INPUT BY NAME g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
          g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo007, 
          g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti,g_mmbo_m.mmbounit, 
          g_mmbo_m.mmbostus,g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr017_1 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
 
         ON ACTION update_item
            #add-point:ON ACTION update_item
            IF cl_auth_chk_act("update_item") THEN   #151027-00016#2 20151112 add by beckxie
               IF NOT cl_null(g_mmbo_m.mmbodocno) THEN
                  CALL n_mmbol(g_mmbo_m.mmbodocno)
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_mmbo_m.mmbodocno
#                  CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmboldocno = ? AND mmbol001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 mark
                  CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmbolent="||g_enterprise||" AND mmboldocno = ? AND mmbol001 = '"||g_lang||"'","") RETURNING g_rtn_fields #160905-00007#6 add
                  LET g_mmbo_m.mmbol002 = g_rtn_fields[1]
                  LET g_mmbo_m.mmbol003 = g_rtn_fields[2]
                  DISPLAY BY NAME g_mmbo_m.mmbol002
                  DISPLAY BY NAME g_mmbo_m.mmbol003
               END IF
            END IF   #151027-00016#2 20151112 add by beckxie
            #END add-point
 
     
         BEFORE INPUT
            LET g_master_multi_table_t.mmboldocno = g_mmbo_m.mmbodocno
LET g_master_multi_table_t.mmbol002 = g_mmbo_m.mmbol002
LET g_master_multi_table_t.mmbol003 = g_mmbo_m.mmbol003
 
            IF l_cmd_t = 'r' THEN
               LET g_master_multi_table_t.mmboldocno = ''
LET g_master_multi_table_t.mmbol002 = ''
LET g_master_multi_table_t.mmbol003 = ''
 
            END IF
            #add-point:資料輸入前
            CALL ammt350_set_entry(p_cmd)
            CALL ammt350_set_no_entry(p_cmd)
            #end add-point
 
         #---------------------------<  Master  >---------------------------
         #----<<mmbo000>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo000
            #add-point:BEFORE FIELD mmbo000
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo000
            
            #add-point:AFTER FIELD mmbo000
            IF NOT cl_null(g_mmbo_m.mmbo000) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbo000 != g_mmbo_m_t.mmbo000)) THEN #160824-00007#113 by sakura mark
                  IF g_mmbo_m.mmbo000 != g_mmbo_m_o.mmbo000 OR cl_null(g_mmbo_m_o.mmbo000) THEN
                     CALL ammt350_mmbo000_init()
                  END IF
               #END IF  #160824-00007#113 by sakura mark
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.*      #
            CALL ammt350_set_entry(p_cmd)
            CALL ammt350_set_no_entry(p_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo000
            #add-point:ON CHANGE mmbo000
            
            #END add-point
 
         #----<<mmbodocno>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbodocno
            #add-point:BEFORE FIELD mmbodocno
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbodocno
            
            #add-point:AFTER FIELD mmbodocno
           IF p_cmd = 'a' AND NOT cl_null(g_mmbo_m.mmbodocno) THEN 
               IF NOT s_aooi200_chk_slip(g_mmbo_m.mmbosite,'',g_mmbo_m.mmbodocno,g_prog) AND p_cmd = 'a' THEN
                    LET g_mmbo_m.mmbodocno = g_mmbo_m_t.mmbodocno
                    NEXT FIELD CURRENT
               END IF     
            END IF
            
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_mmbo_m.mmbodocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbo_t WHERE "||"mmboent = '" ||g_enterprise|| "' AND "||"mmbodocno = '"||g_mmbo_m.mmbodocno ||"'",'std-00004',0) THEN 
                     LET g_mmbo_m.mmbodocno = g_mmbo_m_t.mmbodocno
                     DISPLAY BY NAME g_mmbo_m.mmbodocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbodocno
            #add-point:ON CHANGE mmbodocno
            
            #END add-point
 
         #----<<mmbodocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbodocdt
            #add-point:BEFORE FIELD mmbodocdt
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbodocdt
            
            #add-point:AFTER FIELD mmbodocdt
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbodocdt
            #add-point:ON CHANGE mmbodocdt
            
            #END add-point
 
         #----<<mmbo004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo004
            #add-point:BEFORE FIELD mmbo004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo004
            
            #add-point:AFTER FIELD mmbo004
                   

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo004
            #add-point:ON CHANGE mmbo004
            
            #END add-point
 
         #----<<mmbo006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo006
            #add-point:BEFORE FIELD mmbo006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo006
            
            #add-point:AFTER FIELD mmbo006
                

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo006
            #add-point:ON CHANGE mmbo006
            
            #END add-point
 
         #----<<mmbo001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo001
            #add-point:BEFORE FIELD mmbo001
            #160627-00005#2 160627 by sakura add(S)
            IF g_mmbo_m.mmbo000 = 'I' AND cl_null(g_mmbo_m.mmbo001) THEN    
               CALL s_aooi390_gen('38') RETURNING l_success,g_mmbo_m.mmbo001,l_oofg_return              
            END IF
			   #160627-00005#2 160627 by sakura add(E)             
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo001
            
            #add-point:AFTER FIELD mmbo001
            IF NOT cl_null(g_mmbo_m.mmbo001) THEN
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_mmbo_m.mmbo001 != g_mmbo_m_t.mmbo001)) THEN #160824-00007#113 by sakura mark
               IF g_mmbo_m.mmbo001 != g_mmbo_m_o.mmbo001 OR cl_null(g_mmbo_m_o.mmbo001) THEN #160824-00007#113 by sakura add
                  CALL ammt350_mmbo001_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_mmbo_m.mmbo001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     #LET g_mmbo_m.mmbo001 = g_mmbo_m_t.mmbo001 #160824-00007#113 by sakura mark
                     LET g_mmbo_m.mmbo001 = g_mmbo_m_o.mmbo001  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbo_m.mmbo001
                     NEXT FIELD CURRENT
                  END IF
                  #160627-00005#2 160627 by sakura add(S)
                  IF NOT s_aooi390_chk('38',g_mmbo_m.mmbo001) THEN
                     #LET g_mmbo_m.mmbo001 = g_mmbo_m_t.mmbo001 #160824-00007#113 by sakura mark
                     LET g_mmbo_m.mmbo001 = g_mmbo_m_o.mmbo001  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
				      #160627-00005#2 160627 by sakura add(E)                  
                  IF g_mmbo_m.mmbo001 != g_mmbo_m_o.mmbo001 OR cl_null(g_mmbo_m_o.mmbo001) THEN
                    CALL ammt350_mmbo001_init()
                  END IF
             
               END IF
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.* 
            CALL ammt350_set_entry(p_cmd)
            CALL ammt350_set_no_entry(p_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo001
            #add-point:ON CHANGE mmbo001
            
            #END add-point
 
         #----<<mmbo002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo002
            #add-point:BEFORE FIELD mmbo002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo002
            
            #add-point:AFTER FIELD mmbo002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo002
            #add-point:ON CHANGE mmbo002
            
            #END add-point
 
         #----<<mmbol002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbol002
            #add-point:BEFORE FIELD mmbol002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbol002
            
            #add-point:AFTER FIELD mmbol002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbol002
            #add-point:ON CHANGE mmbol002
            
            #END add-point
 
         #----<<mmbol003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbol003
            #add-point:BEFORE FIELD mmbol003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbol003
            
            #add-point:AFTER FIELD mmbol003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbol003
            #add-point:ON CHANGE mmbol003
            
            #END add-point
 
         #----<<mmbo005>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbo005
            
            #add-point:AFTER FIELD mmbo005
                       LET g_mmbo_m.mmbo005_desc = ''
           DISPLAY BY NAME g_mmbo_m.mmbo005_desc
             
             IF NOT cl_null( g_mmbo_m.mmbo005) THEN
                IF g_mmbo_m.mmbo017='1'  THEN #卡种
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_mman001_1") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF  
                END IF   
                IF g_mmbo_m.mmbo017='2'  THEN #会员等级
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2024'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   #160318-00025#41  2016/04/25  by pengxin  add(S)
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
                   #160318-00025#41  2016/04/25  by pengxin  add(E)
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF 
               
                   IF NOT cl_null( g_mmbo_m.mmbosite) THEN
                      #为会员等级---检查门店+规则对象---是否有重复的申请资料
                      LET l_count=0     
                      SELECT COUNT(*) INTO l_count
                        FROM mmbo_t
                       WHERE mmboent=g_enterprise
                         AND mmbo005= g_mmbo_m.mmbo005
                         AND mmbo004='1'
                         AND mmbosite= g_mmbo_m.mmbosite
                         AND mmbostus='N'
                         AND mmbodocno<>g_mmbo_m.mmbodocno
                       IF l_count>0 AND NOT cl_null(l_count) THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'amm-00488'
                          LET g_errparam.extend = g_mmbo_m.mmbo005
                          LET g_errparam.popup = TRUE
                          CALL cl_err()  
                          LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                          CALL ammt350_mmbo005_ref()                       
                          NEXT FIELD CURRENT
                       END IF
                      #为会员等级---检查门店+规则对象---不重复
                      LET l_count=0     
                      SELECT COUNT(*) INTO l_count
                        FROM mmbo_t
                       WHERE mmboent=g_enterprise
                         AND mmbo005= g_mmbo_m.mmbo005
                         AND mmbo004='1'
                         AND mmbosite= g_mmbo_m.mmbosite
                         AND mmbostus='Y'
                         AND mmbodocno<>g_mmbo_m.mmbodocno
                       IF l_count>0 AND NOT cl_null(l_count) THEN                         
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = 'amm-00487'
                          LET g_errparam.extend = g_mmbo_m.mmbo005
                          LET g_errparam.popup = TRUE
                          LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                          CALL ammt350_mmbo005_ref()                         
                          CALL cl_err()                                
                          NEXT FIELD CURRENT
                       END IF
                    END IF  
                    
                END IF 
                #160729-00077#6 20160817 add by beckxie---S
                IF g_mmbo_m.mmbo017='11'  THEN   #其他類型一
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2026'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|ammi011|",cl_get_progname("ammi011",g_lang,"2"),"|:EXEPROGammi011"
                   LET g_chkparam.err_str[2] = "aoo-00099:sub-01303|ammi011|",cl_get_progname("ammi011",g_lang,"2"),"|:EXEPROGammi011"
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF                     
                END IF 
                IF g_mmbo_m.mmbo017='12'  THEN   #其他類型二
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2027'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|ammi012|",cl_get_progname("ammi012",g_lang,"2"),"|:EXEPROGammi012"
                   LET g_chkparam.err_str[2] = "aoo-00099:sub-01303|ammi012|",cl_get_progname("ammi012",g_lang,"2"),"|:EXEPROGammi012"
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF                     
                END IF 
                IF g_mmbo_m.mmbo017='13'  THEN   #其他類型三
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2028'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|ammi013|",cl_get_progname("ammi013",g_lang,"2"),"|:EXEPROGammi013"
                   LET g_chkparam.err_str[2] = "aoo-00099:sub-01303|ammi013|",cl_get_progname("ammi013",g_lang,"2"),"|:EXEPROGammi013"
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF                     
                END IF 
                IF g_mmbo_m.mmbo017='14'  THEN   #其他類型四
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2029'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|ammi014|",cl_get_progname("ammi014",g_lang,"2"),"|:EXEPROGammi014"
                   LET g_chkparam.err_str[2] = "aoo-00099:sub-01303|ammi014|",cl_get_progname("ammi014",g_lang,"2"),"|:EXEPROGammi014"
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF                     
                END IF 
                IF g_mmbo_m.mmbo017='15'  THEN   #其他類型五
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = '2030'
                   LET g_chkparam.arg2 = g_mmbo_m.mmbo005
                   LET g_errshow = 1
                   LET g_errshow = TRUE #是否開窗 
                   LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|ammi015|",cl_get_progname("ammi015",g_lang,"2"),"|:EXEPROGammi015"
                   LET g_chkparam.err_str[2] = "aoo-00099:sub-01303|ammi015|",cl_get_progname("ammi015",g_lang,"2"),"|:EXEPROGammi015"
                    #呼叫檢查存在並帶值的library
                   IF cl_chk_exist("v_oocq002_01") THEN
                      CALL ammt350_mmbo005_ref()
                   ELSE
                      LET g_mmbo_m.mmbo005 = g_mmbo_m_t.mmbo005
                      CALL ammt350_mmbo005_ref()
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   END IF                     
                END IF 
                #160729-00077#6 20160817 add by beckxie---E
                #160707-00011#1 20160712 add by beckxie---S
                IF p_cmd = 'u' AND (g_mmbo_m_o.mmbo005 != g_mmbo_m.mmbo005 OR cl_null(g_mmbo_m_o.mmbo005)) THEN
                   LET l_cnt = 0
                   IF NOT cl_null(g_mmbo_m_o.mmbo005) THEN
                      SELECT COUNT(*) INTO l_cnt
                        FROM mmdi_t
                       WHERE mmdient = g_enterprise
                         AND mmdidocno = g_mmbo_m.mmbodocno
                         AND mmdi003 = g_mmbo_m_o.mmbo005
                   ELSE
                      SELECT COUNT(*) INTO l_cnt
                        FROM mmdi_t
                       WHERE mmdient = g_enterprise
                         AND mmdidocno = g_mmbo_m.mmbodocno
                   END IF
                   IF l_cnt > 0 THEN
                      IF NOT cl_null(g_mmbo_m_o.mmbo005) THEN
                         UPDATE mmdi_t SET mmdi003 = g_mmbo_m.mmbo005
                          WHERE mmdient = g_enterprise
                            AND mmdidocno = g_mmbo_m.mmbodocno
                            AND mmdi003 = g_mmbo_m_o.mmbo005
                      ELSE
                         UPDATE mmdi_t SET mmdi003 = g_mmbo_m.mmbo005
                          WHERE mmdient = g_enterprise
                            AND mmdidocno = g_mmbo_m.mmbodocno
                      END IF
                      IF SQLCA.sqlcode AND SQLCA.sqlcode!= -268 THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code = SQLCA.sqlcode
                         LET g_errparam.extend = "upd mmdi_t:"
                         LET g_errparam.popup = TRUE
                         CALL cl_err()
                         LET g_mmbo_m.mmbo005 = g_mmbo_m_o.mmbo005
                         CALL ammt350_mmbo005_ref()             
                         NEXT FIELD CURRENT
                      END IF
                   END IF
                END IF
                LET g_mmbo_m_o.mmbo005 = g_mmbo_m.mmbo005
                #160707-00011#1 20160712 add by beckxie---E
            END IF

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo005
            #add-point:BEFORE FIELD mmbo005
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo005
            #add-point:ON CHANGE mmbo005
            
            #END add-point
 
         #----<<mmbo005_desc>>----
         #----<<mmbo007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo007
            #add-point:BEFORE FIELD mmbo007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo007
            
            #add-point:AFTER FIELD mmbo007
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo007
            #add-point:ON CHANGE mmbo007
            IF NOT cl_null(g_mmbo_m.mmbo007) THEN
               #IF p_cmd = 'u' AND g_mmbo_m.mmbo007 <> g_mmbo_m_t.mmbo007 THEN #160824-00007#113 by sakura mark
               IF g_mmbo_m.mmbo007 != g_mmbo_m_o.mmbo007 OR cl_null(g_mmbo_m_o.mmbo007) THEN #160824-00007#113 by sakura add
                  IF g_rec_b > 0 THEN 
                     IF cl_ask_confirm('amm-00064') THEN
                        CALL g_mmbp_d.clear()
                        LET g_rec_b = 0
                        DELETE FROM mmbp_t WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno
                     ELSE
                        #LET g_mmbo_m.mmbo007 = g_mmbo_m_t.mmbo007 #160824-00007#113 by sakura mark
                        LET g_mmbo_m.mmbo007 = g_mmbo_m_o.mmbo007  #160824-00007#113 by sakura add
                     END IF
                  END IF
               END IF
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.* #160824-00007#113 by sakura add
            #END add-point
 
         #----<<mmbo008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo008
            #add-point:BEFORE FIELD mmbo008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo008
            
            #add-point:AFTER FIELD mmbo008
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo008
            #add-point:ON CHANGE mmbo008
            IF NOT cl_null(g_mmbo_m.mmbo008) THEN
               #IF p_cmd = 'u' AND g_mmbo_m.mmbo008 <> g_mmbo_m_t.mmbo008 THEN #160824-00007#113 by sakura mark
               IF g_mmbo_m.mmbo008 != g_mmbo_m_o.mmbo008 OR cl_null(g_mmbo_m_o.mmbo008) THEN #160824-00007#113 by sakura add
                  SELECT COUNT(*) INTO l_n FROM mmbq_t  
                   WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno        
                  IF l_n > 0 THEN 
                     IF cl_ask_confirm('amm-00280') THEN
                        DELETE FROM mmbq_t WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
                     ELSE
                        #LET g_mmbo_m.mmbo008 = g_mmbo_m_t.mmbo008 #160824-00007#113 by sakura mark
                        LET g_mmbo_m.mmbo008 = g_mmbo_m_o.mmbo008  #160824-00007#113 by sakura add
                     END IF
                  END IF
               END IF
            END IF
            LET g_mmbo_m_o.* = g_mmbo_m.* #160824-00007#113 by sakura add
            #END add-point
 
         #----<<mmbo014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo014
            #add-point:BEFORE FIELD mmbo014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo014
            
            #add-point:AFTER FIELD mmbo014
            IF NOT cl_null(g_mmbo_m.mmbo014) THEN
               CALL ammt350_mmbo014_mmbo015_chk()
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
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo014
            #add-point:ON CHANGE mmbo014
            
            #END add-point
 
         #----<<mmbo015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbo015
            #add-point:BEFORE FIELD mmbo015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbo015
            
            #add-point:AFTER FIELD mmbo015
            IF NOT cl_null(g_mmbo_m.mmbo015) THEN
               CALL ammt350_mmbo014_mmbo015_chk()
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
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbo015
            #add-point:ON CHANGE mmbo015
 
            #END add-point
 
         BEFORE FIELD mmbo017
 
         AFTER FIELD mmbo017
 
 
         ON CHANGE mmbo017
            IF NOT cl_null(g_mmbo_m.mmbo017) THEN
               LET g_mmbo_m.mmbo005=''
               LET g_mmbo_m.mmbo005_desc='' 
               DISPLAY BY NAME g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc   #160729-00077#6 20160818 add by beckxie
            END IF
         
         #----<<mmbosite>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbosite
            
            #add-point:AFTER FIELD mmbosite
            LET g_mmbo_m.mmbosite_desc = ' '
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
           #sakura---mark---str 
           #IF NOT cl_null(g_mmbo_m.mmbosite) THEN
           #   IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmbo_m.mmbosite != g_mmbo_m_t.mmbosite OR g_mmbo_m_t.mmbosite IS NULL)) THEN
           #      INITIALIZE g_chkparam.* TO NULL
           #      LET g_errshow = '1'
           #      LET g_chkparam.arg1 = g_mmbo_m.mmbosite
           #      LET g_chkparam.arg2 = '8'
           #      LET g_chkparam.arg3 = g_site
           #      IF NOT cl_chk_exist("v_ooed004") THEN
           #         LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite
           #         CALL ammt350_mmbosite_ref()
           #         NEXT FIELD CURRENT
           #      END IF
           #   END IF
           #END IF
           #CALL ammt350_mmbosite_ref()
           #LET g_mmbo_m.mmbounit = g_mmbo_m.mmbosite
           #sakura---mark---end
           
           #sakura---add---str
            IF NOT cl_null(g_mmbo_m.mmbosite) THEN
               #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_mmbo_m.mmbosite != g_mmbo_m_t.mmbosite OR g_mmbo_m_t.mmbosite IS NULL )) THEN #160824-00007#113 by sakura mark
               IF g_mmbo_m.mmbosite != g_mmbo_m_o.mmbosite OR cl_null(g_mmbo_m_o.mmbosite) THEN #160824-00007#113 by sakura add
                  CALL s_aooi500_chk(g_prog,'mmbosite',g_mmbo_m.mmbosite,g_mmbo_m.mmbosite)
                       RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     
                     #LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite #160824-00007#113 by sakura mark
                     LET g_mmbo_m.mmbosite = g_mmbo_m_o.mmbosite  #160824-00007#113 by sakura add
                     CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
                     DISPLAY BY NAME g_mmbo_m.mmbosite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF g_mmbo_m.mmbo017='2' AND NOT cl_null(g_mmbo_m.mmbo005) THEN
                     #为会员等级---检查门店+规则对象---是否有重复的申请资料
                     LET l_count=0
                     SELECT COUNT(*) INTO l_count
                       FROM mmbo_t
                      WHERE mmboent=g_enterprise
                        AND mmbo005= g_mmbo_m.mmbo005
                        AND mmbo004='1'
                        AND mmbosite= g_mmbo_m.mmbosite
                        AND mmbostus='N'
                        AND mmbodocno<>g_mmbo_m.mmbodocno
                     IF l_count>0 AND NOT cl_null(l_count) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00488'
                        LET g_errparam.extend = g_mmbo_m.mmbo005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        #LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite #160824-00007#113 by sakura mark
                        LET g_mmbo_m.mmbosite = g_mmbo_m_o.mmbosite  #160824-00007#113 by sakura add
                        NEXT FIELD CURRENT
                     END IF
                     #为会员等级---检查门店+规则对象---不重复
                     LET l_count=0
                     SELECT COUNT(*) INTO l_count
                       FROM mmbo_t
                      WHERE mmboent=g_enterprise
                        AND mmbo005= g_mmbo_m.mmbo005
                        AND mmbo004='1'
                        AND mmbosite= g_mmbo_m.mmbosite
                        AND mmbostus='Y'
                        AND mmbodocno<>g_mmbo_m.mmbodocno
                        AND mmbo001<>g_mmbo_m.mmbo001
                        AND mmbo001<>g_mmbo_m.mmbo001
                     IF l_count>0 AND NOT cl_null(l_count) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'amm-00487'
                        LET g_errparam.extend = g_mmbo_m.mmbo005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        
                        #LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite #160824-00007#113 by sakura mark
                        LET g_mmbo_m.mmbosite = g_mmbo_m_o.mmbosite  #160824-00007#113 by sakura add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()

               #LET g_mmbo_m.mmbosite = g_mmbo_m_t.mmbosite #160824-00007#113 by sakura mark
               LET g_mmbo_m.mmbosite = g_mmbo_m_o.mmbosite  #160824-00007#113 by sakura add
               CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
               DISPLAY BY NAME g_mmbo_m.mmbosite_desc
               NEXT FIELD CURRENT
            END IF
            LET g_site_flag = TRUE
            CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
            CALL ammt350_set_entry(p_cmd)
            CALL ammt350_set_no_entry(p_cmd)
           #sakura---add---end
            LET g_mmbo_m_o.* = g_mmbo_m.* #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbosite
            #add-point:BEFORE FIELD mmbosite
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmbosite
            #add-point:ON CHANGE mmbosite
            
            #END add-point
 
         #----<<mmbosite_desc>>----
         #----<<mmboacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmboacti
            #add-point:BEFORE FIELD mmboacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmboacti
            
            #add-point:AFTER FIELD mmboacti
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmboacti
            #add-point:ON CHANGE mmboacti
            
            #END add-point
 
         #----<<mmbounit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbounit
            #add-point:BEFORE FIELD mmbounit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbounit
            
            #add-point:AFTER FIELD mmbounit
                

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbounit
            #add-point:ON CHANGE mmbounit
            
            #END add-point
 
         #----<<mmbostus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbostus
            #add-point:BEFORE FIELD mmbostus
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbostus
            
            #add-point:AFTER FIELD mmbostus
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbostus
            #add-point:ON CHANGE mmbostus
            
            #END add-point
 
         #----<<mmboownid>>----
         #----<<mmboownid_desc>>----
         #----<<mmboowndp>>----
         #----<<mmboowndp_desc>>----
         #----<<mmbocrtid>>----
         #----<<mmbocrtid_desc>>----
         #----<<mmbocrtdp>>----
         #----<<mmbocrtdp_desc>>----
         #----<<mmbocrtdt>>----
         #----<<mmbomodid>>----
         #----<<mmbomodid_desc>>----
         #----<<mmbomoddt>>----
         #----<<mmbocnfid>>----
         #----<<mmbocnfid_desc>>----
         #----<<mmbocnfdt>>----
         #----<<mmbr004_1>>----
         #----<<mmbr014_1>>----
         #----<<mmbr016_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr016_1
            #add-point:BEFORE FIELD mmbr016_1
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr016_1
            
            #add-point:AFTER FIELD mmbr016_1
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr016_1
            #add-point:ON CHANGE mmbr016_1
            
            #END add-point
 
         #----<<mmbr018_1>>----
         #----<<mmbr004_1_desc>>----
         #----<<mmbr015_1>>----
         #----<<mmbr017_1>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr017_1
            #add-point:BEFORE FIELD mmbr017_1
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr017_1
            
            #add-point:AFTER FIELD mmbr017_1
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr017_1
            #add-point:ON CHANGE mmbr017_1
            
            
            
            
            #END add-point
 
         #----<<mmbr019_1>>----
 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<mmbo000>>----
         #Ctrlp:input.c.mmbo000
         ON ACTION controlp INFIELD mmbo000
            #add-point:ON ACTION controlp INFIELD mmbo000
            
            #END add-point
 
         #----<<mmbodocno>>----
         #Ctrlp:input.c.mmbodocno
         ON ACTION controlp INFIELD mmbodocno
            #add-point:ON ACTION controlp INFIELD mmbodocno
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbo_m.mmbodocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_ooef004 #
            #LET g_qryparam.arg2 = 'ammt350' #   #160705-00042#4 160711 by sakura mark
            LET g_qryparam.arg2 = g_prog         #160705-00042#4 160711 by sakura add

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_mmbo_m.mmbodocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbo_m.mmbodocno TO mmbodocno              #顯示到畫面上

            NEXT FIELD mmbodocno                          #返回原欄位


            #END add-point
 
         #----<<mmbodocdt>>----
         #Ctrlp:input.c.mmbodocdt
         ON ACTION controlp INFIELD mmbodocdt
            #add-point:ON ACTION controlp INFIELD mmbodocdt
            
            #END add-point
 
         #----<<mmbo004>>----
         #Ctrlp:input.c.mmbo004
         ON ACTION controlp INFIELD mmbo004
            #add-point:ON ACTION controlp INFIELD mmbo004
            
            #END add-point
 
         #----<<mmbo006>>----
         #Ctrlp:input.c.mmbo006
         ON ACTION controlp INFIELD mmbo006
            #add-point:ON ACTION controlp INFIELD mmbo006
            
            #END add-point
 
         #----<<mmbo001>>----
         #Ctrlp:input.c.mmbo001
         ON ACTION controlp INFIELD mmbo001
            #add-point:ON ACTION controlp INFIELD mmbo001
            #此段落由子樣板a07產生            
           IF g_mmbo_m.mmbo000 = 'U' THEN
           #開窗i段
		    	INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
    
                LET g_qryparam.default1 = g_mmbo_m.mmbo001             #給予default值
    
                #給予arg
                LET g_qryparam.arg1 = '1' #
    
                CALL q_mmbo001()                                #呼叫開窗
    
                LET g_mmbo_m.mmbo001 = g_qryparam.return1              #將開窗取得的值回傳到變數
    
                DISPLAY g_mmbo_m.mmbo001 TO mmbo001              #顯示到畫面上
    
                NEXT FIELD mmbo001                          #返回原欄位
           END IF

            #END add-point
 
         #----<<mmbo002>>----
         #Ctrlp:input.c.mmbo002
         ON ACTION controlp INFIELD mmbo002
            #add-point:ON ACTION controlp INFIELD mmbo002
            
            #END add-point
 
         #----<<mmbol002>>----
         #Ctrlp:input.c.mmbol002
         ON ACTION controlp INFIELD mmbol002
            #add-point:ON ACTION controlp INFIELD mmbol002
            
            #END add-point
 
         #----<<mmbol003>>----
         #Ctrlp:input.c.mmbol003
         ON ACTION controlp INFIELD mmbol003
            #add-point:ON ACTION controlp INFIELD mmbol003
            
            #END add-point
 
         #----<<mmbo005>>----
         #Ctrlp:input.c.mmbo005
         ON ACTION controlp INFIELD mmbo005
            #add-point:ON ACTION controlp INFIELD mmbo005
            #此段落由子樣板a07產生            
            #開窗i段
			  INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbo_m.mmbo005             #給予default值
            
            IF g_mmbo_m.mmbo017='1' THEN #卡种
               #給予arg
               ###################add by huangtao 150513-00011#1 begin
               LET g_qryparam.where = "mman027 = 'Y'"
               ###################end 
               CALL q_mman001()                                #呼叫開窗
            END IF
            
            IF g_mmbo_m.mmbo017='2' THEN #会员等级
               LET g_qryparam.arg1 ='2024'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            #160729-00077#6 20160817 add by beckxie---S
            IF g_mmbo_m.mmbo017='11' THEN #其他類型一
               LET g_qryparam.arg1 ='2026'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            IF g_mmbo_m.mmbo017='12' THEN #其他類型一
               LET g_qryparam.arg1 ='2027'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            IF g_mmbo_m.mmbo017='13' THEN #其他類型一
               LET g_qryparam.arg1 ='2028'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            IF g_mmbo_m.mmbo017='14' THEN #其他類型一
               LET g_qryparam.arg1 ='2029'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            IF g_mmbo_m.mmbo017='15' THEN #其他類型五
               LET g_qryparam.arg1 ='2030'
               CALL q_oocq002()                                #呼叫開窗
            END IF
            #160729-00077#6 20160817 add by beckxie---E
            LET g_mmbo_m.mmbo005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_mmbo_m.mmbo005 TO mmbo005              #顯示到畫面上
            CALL ammt350_mmbo005_ref()
            NEXT FIELD mmbo005                          #返回原欄位


            #END add-point
 
         #----<<mmbo005_desc>>----
         #----<<mmbo007>>----
         #Ctrlp:input.c.mmbo007
         ON ACTION controlp INFIELD mmbo007
            #add-point:ON ACTION controlp INFIELD mmbo007
            
            #END add-point
 
         #----<<mmbo008>>----
         #Ctrlp:input.c.mmbo008
         ON ACTION controlp INFIELD mmbo008
            #add-point:ON ACTION controlp INFIELD mmbo008
            
            #END add-point
 
         #----<<mmbo014>>----
         #Ctrlp:input.c.mmbo014
         ON ACTION controlp INFIELD mmbo014
            #add-point:ON ACTION controlp INFIELD mmbo014
            
            #END add-point
 
         #----<<mmbo015>>----
         #Ctrlp:input.c.mmbo015
         ON ACTION controlp INFIELD mmbo015
            #add-point:ON ACTION controlp INFIELD mmbo015
            
            #END add-point
 
         #----<<mmbosite>>----
         #Ctrlp:input.c.mmbosite
         ON ACTION controlp INFIELD mmbosite
            #add-point:ON ACTION controlp INFIELD mmbosite
            #此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_mmbo_m.mmbosite             #給予default值
           #sakura---add---str
            CALL s_aooi500_q_where(g_prog,'mmbosite',g_mmbo_m.mmbosite,'i') RETURNING l_where  #150308-00001#4  By benson add 'c'
            LET g_qryparam.where = l_where
            CALL q_ooef001_24()
            LET g_mmbo_m.mmbosite = g_qryparam.return1
            DISPLAY g_mmbo_m.mmbosite TO mmbosite
            CALL s_desc_get_department_desc(g_mmbo_m.mmbosite) RETURNING g_mmbo_m.mmbosite_desc
            DISPLAY BY NAME g_mmbo_m.mmbosite_desc
            NEXT FIELD mmbosite                          #返回原欄位              
           #sakura---add---end            


            #END add-point
 
         #----<<mmbosite_desc>>----
         #----<<mmboacti>>----
         #Ctrlp:input.c.mmboacti
         ON ACTION controlp INFIELD mmboacti
            #add-point:ON ACTION controlp INFIELD mmboacti
            
            #END add-point
 
         #----<<mmbounit>>----
         #Ctrlp:input.c.mmbounit
         ON ACTION controlp INFIELD mmbounit
            #add-point:ON ACTION controlp INFIELD mmbounit
            
            #END add-point
 
         #----<<mmbostus>>----
         #Ctrlp:input.c.mmbostus
         ON ACTION controlp INFIELD mmbostus
            #add-point:ON ACTION controlp INFIELD mmbostus
            
            #END add-point
 
         #----<<mmboownid>>----
         #----<<mmboownid_desc>>----
         #----<<mmboowndp>>----
         #----<<mmboowndp_desc>>----
         #----<<mmbocrtid>>----
         #----<<mmbocrtid_desc>>----
         #----<<mmbocrtdp>>----
         #----<<mmbocrtdp_desc>>----
         #----<<mmbocrtdt>>----
         #----<<mmbomodid>>----
         #----<<mmbomodid_desc>>----
         #----<<mmbomoddt>>----
         #----<<mmbocnfid>>----
         #----<<mmbocnfid_desc>>----
         #----<<mmbocnfdt>>----
         #----<<mmbr004_1>>----
         #----<<mmbr014_1>>----
         #----<<mmbr016_1>>----
         #Ctrlp:input.c.mmbr016_1
         ON ACTION controlp INFIELD mmbr016_1
            #add-point:ON ACTION controlp INFIELD mmbr016_1
            
            #END add-point
 
         #----<<mmbr018_1>>----
         #----<<mmbr004_1_desc>>----
         #----<<mmbr015_1>>----
         #----<<mmbr017_1>>----
         #Ctrlp:input.c.mmbr017_1
         ON ACTION controlp INFIELD mmbr017_1
            #add-point:ON ACTION controlp INFIELD mmbr017_1
            
            #END add-point
 
         #----<<mmbr019_1>>----
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME g_mmbo_m.mmbodocno             
 
                            
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前
                CALL s_aooi200_gen_docno(g_mmbo_m.mmbosite,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_prog) RETURNING l_flag,g_mmbo_m.mmbodocno
                  IF NOT l_flag THEN
                     NEXT FIELD mmbodocno
                  END IF
                LET g_mmbo_m.mmbounit = g_mmbo_m.mmbosite #sakura add
               
               #160627-00005#2 160627 by sakura add(S)
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
               IF g_mmbo_m.mmbo000 = 'I' THEN
                  CALL s_aooi390_get_auto_no('38',g_mmbo_m.mmbo001) RETURNING l_success,g_mmbo_m.mmbo001
                  
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_aooi390_oofi_upd('38',g_mmbo_m.mmbo001) RETURNING l_success                  
               END IF
               #160627-00005#2 160627 by sakura add(E)                
               #end add-point
               
               INSERT INTO mmbo_t (mmboent,mmbo000,mmbodocno,mmbodocdt,mmbo004,mmbo006,mmbo001,mmbo002, 
                   mmbo005,mmbo007,mmbo008,mmbo014,mmbo015,mmbo017,mmbosite,mmboacti,mmbounit,mmbostus,mmboownid, 
                   mmboowndp,mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt)
               VALUES (g_enterprise,g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004, 
                   g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005,g_mmbo_m.mmbo007, 
                   g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti, 
                   g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
                   g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
                   g_mmbo_m.mmbocnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "g_mmbo_m"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭新增中
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmbo_m.mmbodocno = g_master_multi_table_t.mmboldocno AND
         g_mmbo_m.mmbol002 = g_master_multi_table_t.mmbol002 AND 
         g_mmbo_m.mmbol003 = g_master_multi_table_t.mmbol003  THEN
         ELSE 
            LET l_var_keys[01] = g_mmbo_m.mmbodocno
            LET l_field_keys[01] = 'mmboldocno'
            LET l_var_keys_bak[01] = g_master_multi_table_t.mmboldocno
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'mmbol001'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_mmbo_m.mmbol002
            LET l_fields[01] = 'mmbol002'
            LET l_vars[02] = g_mmbo_m.mmbol003
            LET l_fields[02] = 'mmbol003'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'mmbolent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbol_t')
         END IF 
 
               
               #add-point:單頭新增後
                                  IF g_mmbo_m.mmbo000 = 'U' THEN
                     CALL ammt350_detail_init()
                  END IF 
               #160530-00033#1 -s by 08172
               IF g_mmbo_m.mmbo000 = 'U' THEN
                  CALL DIALOG.setActionActive('rulerange',FALSE)
               END IF
               INSERT INTO mmdi_t (mmdient,mmdisite,mmdiunit,mmdidocno,mmdi001,mmdi002,mmdi003,mmdiacti)
                            VALUES(g_enterprise,g_mmbo_m.mmbosite,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,g_mmbo_m.mmbo001,
                                   g_mmbo_m.mmbo017,g_mmbo_m.mmbo005,'Y')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ins mmdi_t:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  RETURN
               END IF                    
               #160530-00033#1 -e                  
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL ammt350_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前
               
               #end add-point
               
               UPDATE mmbo_t SET (mmbo000,mmbodocno,mmbodocdt,mmbo004,mmbo006,mmbo001,mmbo002,mmbo005, 
                   mmbo007,mmbo008,mmbo014,mmbo015,mmbo017,mmbosite,mmboacti,mmbounit,mmbostus,mmboownid,mmboowndp, 
                   mmbocrtid,mmbocrtdp,mmbocrtdt,mmbomodid,mmbomoddt,mmbocnfid,mmbocnfdt) = (g_mmbo_m.mmbo000, 
                   g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001, 
                   g_mmbo_m.mmbo002,g_mmbo_m.mmbo005,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014, 
                   g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti,g_mmbo_m.mmbounit,g_mmbo_m.mmbostus, 
                   g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt, 
                   g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfdt)
                WHERE mmboent = g_enterprise AND mmbodocno = g_mmbodocno_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "mmbo_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               
               #add-point:單頭修改中
               
               #end add-point
               
               
                        INITIALIZE l_var_keys TO NULL 
         INITIALIZE l_field_keys TO NULL 
         INITIALIZE l_vars TO NULL 
         INITIALIZE l_fields TO NULL 
         IF g_mmbo_m.mmbodocno = g_master_multi_table_t.mmboldocno AND
         g_mmbo_m.mmbol002 = g_master_multi_table_t.mmbol002 AND 
         g_mmbo_m.mmbol003 = g_master_multi_table_t.mmbol003  THEN
         ELSE 
            LET l_var_keys[01] = g_mmbo_m.mmbodocno
            LET l_field_keys[01] = 'mmboldocno'
            LET l_var_keys_bak[01] = g_master_multi_table_t.mmboldocno
            LET l_var_keys[02] = g_dlang
            LET l_field_keys[02] = 'mmbol001'
            LET l_var_keys_bak[02] = g_dlang
            LET l_vars[01] = g_mmbo_m.mmbol002
            LET l_fields[01] = 'mmbol002'
            LET l_vars[02] = g_mmbo_m.mmbol003
            LET l_fields[02] = 'mmbol003'
            LET l_vars[03] = g_enterprise 
            LET l_fields[03] = 'mmbolent'
            CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,'mmbol_t')
         END IF 
 
               CALL s_transaction_end('Y','0')
               
               #add-point:單頭修改後
               
               #end add-point
            END IF
            
            LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
            #controlp
            
      END INPUT
   
 
{</section>}
 
{<section id="ammt350.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_mmbp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt350_b_fill()
            LET g_rec_b = g_mmbp_d.getLength()
            #add-point:資料輸入前
            LET g_current_page = 1
            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
 
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN ammt350_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE ammt350_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_mmbp_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbp_d[l_ac].mmbp003 IS NOT NULL
               AND g_mmbp_d[l_ac].mmbp004 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_mmbp_d_t.* = g_mmbp_d[l_ac].*  #BACKUP
               LET g_mmbp_d_o.* = g_mmbp_d[l_ac].*  #BACKUP #160824-00007#113 by sakura add
               CALL ammt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL ammt350_set_no_entry_b(l_cmd)
               IF NOT ammt350_lock_b("mmbp_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt350_bcl INTO g_mmbp_d[l_ac].mmbpunit,g_mmbp_d[l_ac].mmbpsite,g_mmbp_d[l_ac].mmbp001, 
                      g_mmbp_d[l_ac].mmbp002,g_mmbp_d[l_ac].mmbp003,g_mmbp_d[l_ac].mmbp004,g_mmbp_d[l_ac].mmbp004_desc, 
                      g_mmbp_d[l_ac].mmbp005,g_mmbp_d[l_ac].mmbp006,g_mmbp_d[l_ac].mmbp007,g_mmbp_d[l_ac].mmbp008, 
                      g_mmbp_d[l_ac].mmbpacti
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_mmbp_d_t.mmbp003
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL ammt350_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
        
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbp_d[l_ac].* TO NULL 
                  LET g_mmbp_d[l_ac].mmbpacti = "Y"
 
 
            LET g_mmbp_d_t.* = g_mmbp_d[l_ac].*     #新輸入資料
            LET g_mmbp_d_o.* = g_mmbp_d[l_ac].*     #160824-00007#113 by sakura add
            CALL cl_show_fld_cont()
            CALL ammt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL ammt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbp_d[li_reproduce_target].* = g_mmbp_d[li_reproduce].*
 
               LET g_mmbp_d[li_reproduce_target].mmbp003 = NULL
               LET g_mmbp_d[li_reproduce_target].mmbp004 = NULL
 
            END IF
            #公用欄位給值(單身)
            
            
            #add-point:modify段before insert
                        LET g_mmbp_d[l_ac].mmbpsite = g_mmbo_m.mmbosite
            LET g_mmbp_d[l_ac].mmbpunit = g_mmbo_m.mmbounit
            LET g_mmbp_d[l_ac].mmbp001  = g_mmbo_m.mmbo001
            LET g_mmbp_d[l_ac].mmbp002  = g_mmbo_m.mmbo005
            LET  g_mmbp_d[l_ac].mmbp003 = g_mmbo_m.mmbo007
            IF g_mmbo_m.mmbo007 = '0' THEN
               LET g_mmbp_d[l_ac].mmbp004 = 'ALL'
            END IF
            IF g_mmbo_m.mmbo007 = '3' THEN
               LET g_mmbp_d[l_ac].mmbp005 = '1'
            END IF
            #150324-00007#4 Add-S By Ken 150427
            IF g_mmbo_m.mmbo007 = 'Z' THEN
               LET g_mmbp_d[l_ac].mmbp005 = '1'
            END IF     
            #150324-00007#4 Add-E
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmbp_t 
             WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno
 
               AND mmbp003 = g_mmbp_d[l_ac].mmbp003
               AND mmbp004 = g_mmbp_d[l_ac].mmbp004
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmbp_d[g_detail_idx].mmbp003
               LET gs_keys[3] = g_mmbp_d[g_detail_idx].mmbp004
               CALL ammt350_insert_b('mmbp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_mmbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt350_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mmbp_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmbp_d.deleteElement(l_ac)
               NEXT FIELD mmbp003
            END IF
         
            IF g_mmbp_d[l_ac].mmbp003 IS NOT NULL
               AND g_mmbp_d_t.mmbp004 IS NOT NULL
 
               THEN 
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前
               
               #end add-point 
               
               DELETE FROM mmbp_t
                WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno AND
 
                      mmbp003 = g_mmbp_d_t.mmbp003
                  AND mmbp004 = g_mmbp_d_t.mmbp004
 
                  
               #add-point:單身刪除中
               
               #end add-point 
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammt350_bcl
               LET l_count = g_mmbp_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmbp_d[g_detail_idx].mmbp003
               LET gs_keys[3] = g_mmbp_d[g_detail_idx].mmbp004
 
              
         AFTER DELETE 
            #add-point:單身刪除後2
            
            #end add-point
                           CALL ammt350_delete_b('mmbp_t',gs_keys,"'1'")
 
         #---------------------<  Detail: page1  >---------------------
         #----<<mmbpunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpunit
            #add-point:BEFORE FIELD mmbpunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpunit
            
            #add-point:AFTER FIELD mmbpunit
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbpunit
            #add-point:ON CHANGE mmbpunit
            
            #END add-point
 
         #----<<mmbpsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpsite
            #add-point:BEFORE FIELD mmbpsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpsite
            
            #add-point:AFTER FIELD mmbpsite
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbpsite
            #add-point:ON CHANGE mmbpsite
            
            #END add-point
 
         #----<<mmbp001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp001
            #add-point:BEFORE FIELD mmbp001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp001
            
            #add-point:AFTER FIELD mmbp001
                        #此段落由子樣板a05產生
            IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp_d[l_ac].mmbp001) AND NOT cl_null(g_mmbp_d[l_ac].mmbp003) AND NOT cl_null(g_mmbp_d[l_ac].mmbp004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp_d[l_ac].mmbp001 != g_mmbp_d_t.mmbp001 OR g_mmbp_d[l_ac].mmbp003 != g_mmbp_d_t.mmbp003 OR g_mmbp_d[l_ac].mmbp004 != g_mmbp_d_t.mmbp004))) THEN #160824-00008#113 by sakura mark
               IF g_mmbp_d[l_ac].mmbp001 != g_mmbp_d_o.mmbp001 OR cl_null(g_mmbp_d_o.mmbp001) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbp_t WHERE "||"mmbpent = '" ||g_enterprise|| "' AND "||"mmbpdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbp001 = '"||g_mmbp_d[l_ac].mmbp001 ||"' AND "|| "mmbp003 = '"||g_mmbp_d[l_ac].mmbp003 ||"' AND "|| "mmbp004 = '"||g_mmbp_d[l_ac].mmbp004 ||"'",'std-00004',0) THEN 
                     LET g_mmbp_d[l_ac].mmbp001 = g_mmbp_d_o.mmbp001  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbp_d_o.* = g_mmbp_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp001
            #add-point:ON CHANGE mmbp001
            
            #END add-point
 
         #----<<mmbp002>>----
         #----<<mmbp003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp003
            #add-point:BEFORE FIELD mmbp003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp003
            
            #add-point:AFTER FIELD mmbp003
                        #此段落由子樣板a05產生
            IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp_d[l_ac].mmbp001) AND NOT cl_null(g_mmbp_d[l_ac].mmbp003) AND NOT cl_null(g_mmbp_d[l_ac].mmbp004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp_d[l_ac].mmbp001 != g_mmbp_d_t.mmbp001 OR g_mmbp_d[l_ac].mmbp003 != g_mmbp_d_t.mmbp003 OR g_mmbp_d[l_ac].mmbp004 != g_mmbp_d_t.mmbp004))) THEN #160824-00008#113 by sakura mark
               IF g_mmbp_d[l_ac].mmbp003 != g_mmbp_d_o.mmbp003 OR cl_null(g_mmbp_d_o.mmbp003) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbp_t WHERE "||"mmbpent = '" ||g_enterprise|| "' AND "||"mmbpdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbp001 = '"||g_mmbp_d[l_ac].mmbp001 ||"' AND "|| "mmbp003 = '"||g_mmbp_d[l_ac].mmbp003 ||"' AND "|| "mmbp004 = '"||g_mmbp_d[l_ac].mmbp004 ||"'",'std-00004',0) THEN 
                     LET g_mmbp_d[l_ac].mmbp003 = g_mmbp_d_o.mmbp003  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbp_d_o.* = g_mmbp_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp003
            #add-point:ON CHANGE mmbp003
            
            #END add-point
 
         #----<<mmbp004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp004
            #add-point:BEFORE FIELD mmbp004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp004
            
            #add-point:AFTER FIELD mmbp004
                        #此段落由子樣板a05產生
           LET g_mmbp_d[l_ac].mmbp004_desc = ''
            DISPLAY BY NAME g_mmbp_d[l_ac].mmbp004_desc
           IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp_d[l_ac].mmbp001) AND NOT cl_null(g_mmbp_d[l_ac].mmbp003) AND NOT cl_null(g_mmbp_d[l_ac].mmbp004) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp_d[l_ac].mmbp001 != g_mmbp_d_t.mmbp001 OR g_mmbp_d[l_ac].mmbp003 != g_mmbp_d_t.mmbp003 OR g_mmbp_d[l_ac].mmbp004 != g_mmbp_d_t.mmbp004))) THEN #160824-00008#113 by sakura mark
               IF g_mmbp_d[l_ac].mmbp004 != g_mmbp_d_o.mmbp004 OR cl_null(g_mmbp_d_o.mmbp004) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbp_t WHERE "||"mmbpent = '" ||g_enterprise|| "' AND "||"mmbpdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbp001 = '"||g_mmbp_d[l_ac].mmbp001 ||"' AND "|| "mmbp003 = '"||g_mmbp_d[l_ac].mmbp003 ||"' AND "|| "mmbp004 = '"||g_mmbp_d[l_ac].mmbp004 ||"'",'std-00004',0) THEN 
                     #LET g_mmbp_d[l_ac].mmbp004 = g_mmbp_d_t.mmbp004 #160824-00007#113 by sakura mark
                     LET g_mmbp_d[l_ac].mmbp004 = g_mmbp_d_o.mmbp004  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp_d[l_ac].mmbp004
                     CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004)
                     NEXT FIELD CURRENT
                  END IF
             
                  CALL s_aint800_01_check(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004,'',g_mmbo_m.mmbosite,'') RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc
                  IF NOT l_flag THEN    
                     #LET g_mmbp_d[l_ac].mmbp004 = g_mmbp_d_t.mmbp004 #160824-00007#113 by sakura mark
                     LET g_mmbp_d[l_ac].mmbp004 = g_mmbp_d_o.mmbp004  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp_d[l_ac].mmbp004
                     CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004)
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               #CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004)
                CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc              
            END IF
            LET g_mmbp_d_o.* = g_mmbp_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp004
            #add-point:ON CHANGE mmbp004
            
            #END add-point
 
         #----<<mmbp004_desc>>----
         #----<<mmbp005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp005
            #add-point:BEFORE FIELD mmbp005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp005
            
            #add-point:AFTER FIELD mmbp005
            IF NOT cl_null(g_mmbp_d[l_ac].mmbp005) THEN
               SELECT COUNT(DISTINCT mmbp005) INTO l_n FROM mmbp_t
                WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno AND mmbp005<>g_mmbp_d[l_ac].mmbp005
               IF l_n > 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00276'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_mmbp_d[l_ac].mmbp005 = g_mmbp_d_t.mmbp005
                  NEXT FIELD mmbp005
               END IF                           
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp005
            #add-point:ON CHANGE mmbp005
            
            #END add-point
 
         #----<<mmbp006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp006
            #add-point:BEFORE FIELD mmbp006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp006
            
            #add-point:AFTER FIELD mmbp006
            IF NOT cl_null(g_mmbp_d[l_ac].mmbp006) THEN
               IF g_mmbp_d[l_ac].mmbp006 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00049'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmbp_d[l_ac].mmbp006 = g_mmbp_d_t.mmbp006
                  NEXT FIELD mmbp006
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp006
            #add-point:ON CHANGE mmbp006
            
            #END add-point
 
         #----<<mmbp007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp007
            #add-point:BEFORE FIELD mmbp007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp007
            
            #add-point:AFTER FIELD mmbp007
            IF NOT cl_null(g_mmbp_d[l_ac].mmbp007) THEN
               IF g_mmbp_d[l_ac].mmbp007 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmbp_d[l_ac].mmbp007 = g_mmbp_d_t.mmbp007
                  NEXT FIELD mmbp007
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp007
            #add-point:ON CHANGE mmbp007
            
            #END add-point
 
         #----<<mmbp008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbp008
            #add-point:BEFORE FIELD mmbp008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbp008
            
            #add-point:AFTER FIELD mmbp008
           IF NOT cl_null(g_mmbp_d[l_ac].mmbp008) THEN
               IF g_mmbp_d[l_ac].mmbp008 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  LET g_mmbp_d[l_ac].mmbp008 = g_mmbp_d_t.mmbp008
                  NEXT FIELD mmbp008
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbp008
            #add-point:ON CHANGE mmbp008
            
            #END add-point
         #add by yangxf -----start----
         AFTER FIELD mmbp009
            
            #add-point:AFTER FIELD mmbp009
           IF NOT cl_null(g_mmbp_d[l_ac].mmbp009) THEN
               IF g_mmbp_d[l_ac].mmbp009 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
 
                  LET g_mmbp_d[l_ac].mmbp009 = g_mmbp_d_t.mmbp009
                  NEXT FIELD mmbp009
               END IF
            END IF
            
         AFTER FIELD mmbp010
            
            #add-point:AFTER FIELD mmbp010
           IF NOT cl_null(g_mmbp_d[l_ac].mmbp010) THEN
               IF g_mmbp_d[l_ac].mmbp010 <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00003'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
 
                  LET g_mmbp_d[l_ac].mmbp010 = g_mmbp_d_t.mmbp010
                  NEXT FIELD mmbp010
               END IF
            END IF
         #add by yangxf ---end----
         
         #----<<mmbpacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbpacti
            #add-point:BEFORE FIELD mmbpacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbpacti
            
            #add-point:AFTER FIELD mmbpacti
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbpacti
            #add-point:ON CHANGE mmbpacti
            
            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<mmbpunit>>----
         #Ctrlp:input.c.page1.mmbpunit
         ON ACTION controlp INFIELD mmbpunit
            #add-point:ON ACTION controlp INFIELD mmbpunit
            
            #END add-point
 
         #----<<mmbpsite>>----
         #Ctrlp:input.c.page1.mmbpsite
         ON ACTION controlp INFIELD mmbpsite
            #add-point:ON ACTION controlp INFIELD mmbpsite
            
            #END add-point
 
         #----<<mmbp001>>----
         #Ctrlp:input.c.page1.mmbp001
         ON ACTION controlp INFIELD mmbp001
            #add-point:ON ACTION controlp INFIELD mmbp001
            
            #END add-point
 
         #----<<mmbp002>>----
         #----<<mmbp003>>----
         #Ctrlp:input.c.page1.mmbp003
         ON ACTION controlp INFIELD mmbp003
            #add-point:ON ACTION controlp INFIELD mmbp003
            
            #END add-point
 
         #----<<mmbp004>>----
         #Ctrlp:input.c.page1.mmbp004
         ON ACTION controlp INFIELD mmbp004
            #add-point:ON ACTION controlp INFIELD mmbp004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'                 #150521-00027#2
            CALL s_aint800_01_controlp(g_mmbo_m.mmbo007,'',g_mmbo_m.mmbosite) RETURNING l_flag
            LET g_mmbp_d[l_ac].mmbp004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmbp004     #顯示到畫面上
            #CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004)
            CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc
            NEXT FIELD mmbp004                     #返回原欄位
            #END add-point
 
         #----<<mmbp004_desc>>----
         #----<<mmbp005>>----
         #Ctrlp:input.c.page1.mmbp005
         ON ACTION controlp INFIELD mmbp005
            #add-point:ON ACTION controlp INFIELD mmbp005
                       
            #END add-point
 
         #----<<mmbp006>>----
         #Ctrlp:input.c.page1.mmbp006
         ON ACTION controlp INFIELD mmbp006
            #add-point:ON ACTION controlp INFIELD mmbp006
            
            #END add-point
 
         #----<<mmbp007>>----
         #Ctrlp:input.c.page1.mmbp007
         ON ACTION controlp INFIELD mmbp007
            #add-point:ON ACTION controlp INFIELD mmbp007
            
            #END add-point
 
         #----<<mmbp008>>----
         #Ctrlp:input.c.page1.mmbp008
         ON ACTION controlp INFIELD mmbp008
            #add-point:ON ACTION controlp INFIELD mmbp008
            
            #END add-point
 
         #----<<mmbpacti>>----
         #Ctrlp:input.c.page1.mmbpacti
         ON ACTION controlp INFIELD mmbpacti
            #add-point:ON ACTION controlp INFIELD mmbpacti
            
            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_mmbp_d[l_ac].* = g_mmbp_d_t.*
               CLOSE ammt350_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_mmbp_d[l_ac].mmbp003
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_mmbp_d[l_ac].* = g_mmbp_d_t.*
            ELSE
            
               #add-point:單身修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               UPDATE mmbp_t SET (mmbpdocno,mmbpunit,mmbpsite,mmbp001,mmbp002,mmbp003,mmbp004,mmbp005, 
                   mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti) = (g_mmbo_m.mmbodocno,g_mmbp_d[l_ac].mmbpunit,g_mmbp_d[l_ac].mmbpsite, 
                   g_mmbp_d[l_ac].mmbp001,g_mmbp_d[l_ac].mmbp002,g_mmbp_d[l_ac].mmbp003,g_mmbp_d[l_ac].mmbp004, 
                   g_mmbp_d[l_ac].mmbp005,g_mmbp_d[l_ac].mmbp006,g_mmbp_d[l_ac].mmbp007,g_mmbp_d[l_ac].mmbp008, 
                   g_mmbp_d[l_ac].mmbp009,g_mmbp_d[l_ac].mmbp010,g_mmbp_d[l_ac].mmbpacti)
                WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno 
 
                  AND mmbp003 = g_mmbp_d_t.mmbp003 #項次   
                  AND mmbp004 = g_mmbp_d_t.mmbp004  
 
                  
               #add-point:單身修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mmbp_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_mmbp_d[l_ac].* = g_mmbp_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                     LET g_mmbp_d[l_ac].* = g_mmbp_d_t.*                     
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmbp_d[g_detail_idx].mmbp003
               LET gs_keys_bak[2] = g_mmbp_d_t.mmbp003
               LET gs_keys[3] = g_mmbp_d[g_detail_idx].mmbp004
               LET gs_keys_bak[3] = g_mmbp_d_t.mmbp004
               CALL ammt350_update_b('mmbp_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #add-point:單身修改後
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row
            
            #end add-point
            CALL ammt350_unlock_b("mmbp_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            
              
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point 
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_mmbp_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmbp_d.getLength()+1
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_mmbp2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbp2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt350_b_fill()
            LET g_rec_b = g_mmbp2_d.getLength()
            #add-point:資料輸入前
            LET g_current_page = 2 
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbp2_d[l_ac].* TO NULL 
                  LET g_mmbp2_d[l_ac].mmbs005 = "N"
      LET g_mmbp2_d[l_ac].mmbsacti = "Y"
 
 
            LET g_mmbp2_d_t.* = g_mmbp2_d[l_ac].*     #新輸入資料
            LET g_mmbp2_d_o.* = g_mmbp2_d[l_ac].*     #新輸入資料 #160824-00007#113 by sakura add
            CALL cl_show_fld_cont()
            CALL ammt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL ammt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbp2_d[li_reproduce_target].* = g_mmbp2_d[li_reproduce].*
 
               LET g_mmbp2_d[li_reproduce_target].mmbs004 = NULL
            END IF
            #公用欄位給值(單身2)
            
            
            #add-point:modify段before insert
                        LET g_mmbp2_d[l_ac].mmbssite = g_mmbo_m.mmbosite
            LET g_mmbp2_d[l_ac].mmbsunit = g_mmbo_m.mmbounit
            LET g_mmbp2_d[l_ac].mmbs001  = g_mmbo_m.mmbo001
            LET g_mmbp2_d[l_ac].mmbs002  = g_mmbo_m.mmbo007
            LET g_mmbp2_d[l_ac].mmbs003  = g_mmbo_m.mmbo005
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN ammt350_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE ammt350_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_mmbp2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbp2_d[l_ac].mmbs004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmbp2_d_t.* = g_mmbp2_d[l_ac].*  #BACKUP
               LET g_mmbp2_d_o.* = g_mmbp2_d[l_ac].*  #BACKUP #160824-00007#113 by sakura add
               CALL ammt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL ammt350_set_no_entry_b(l_cmd)
               IF NOT ammt350_lock_b("mmbs_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt350_bcl2 INTO g_mmbp2_d[l_ac].mmbsunit,g_mmbp2_d[l_ac].mmbssite,g_mmbp2_d[l_ac].mmbs001, 
                      g_mmbp2_d[l_ac].mmbs002,g_mmbp2_d[l_ac].mmbs003,g_mmbp2_d[l_ac].mmbs004,g_mmbp2_d[l_ac].mmbs004_desc, 
                      g_mmbp2_d[l_ac].mmbs005,g_mmbp2_d[l_ac].mmbsacti
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL ammt350_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mmbp2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmbp2_d.deleteElement(l_ac)
               NEXT FIELD mmbs004
            END IF
         
            IF g_mmbp2_d[l_ac].mmbs004 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前
               
               #end add-point    
               
               DELETE FROM mmbs_t
                WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno AND
                      mmbs004 = g_mmbp2_d_t.mmbs004
                  
               #add-point:單身2刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身2刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammt350_bcl
               LET l_count = g_mmbp_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmbp2_d[g_detail_idx].mmbs004
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL ammt350_delete_b('mmbs_t',gs_keys,"'2'")
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmbs_t 
             WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
               AND mmbs004 = g_mmbp2_d[l_ac].mmbs004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmbp2_d[g_detail_idx].mmbs004
               CALL ammt350_insert_b('mmbs_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_mmbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt350_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
               
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_mmbp2_d[l_ac].* = g_mmbp2_d_t.*
               CLOSE ammt350_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_mmbp2_d[l_ac].* = g_mmbp2_d_t.*
            ELSE
               #add-point:單身page2修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               UPDATE mmbs_t SET (mmbsdocno,mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005, 
                   mmbsacti) = (g_mmbo_m.mmbodocno,g_mmbp2_d[l_ac].mmbsunit,g_mmbp2_d[l_ac].mmbssite, 
                   g_mmbp2_d[l_ac].mmbs001,g_mmbp2_d[l_ac].mmbs002,g_mmbp2_d[l_ac].mmbs003,g_mmbp2_d[l_ac].mmbs004, 
                   g_mmbp2_d[l_ac].mmbs005,g_mmbp2_d[l_ac].mmbsacti) #自訂欄位頁簽
                WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
                  AND mmbs004 = g_mmbp2_d_t.mmbs004 #項次 
                  
               #add-point:單身page2修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mmbs_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_mmbp2_d[l_ac].* = g_mmbp2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbs_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_mmbp2_d[l_ac].* = g_mmbp2_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmbp2_d[g_detail_idx].mmbs004
               LET gs_keys_bak[2] = g_mmbp2_d_t.mmbs004
               CALL ammt350_update_b('mmbs_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page2修改後
               
               #end add-point
            END IF
         
         #---------------------<  Detail: page2  >---------------------
         #----<<mmbsunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbsunit
            #add-point:BEFORE FIELD mmbsunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbsunit
            
            #add-point:AFTER FIELD mmbsunit
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbsunit
            #add-point:ON CHANGE mmbsunit
            
            #END add-point
 
         #----<<mmbssite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbssite
            #add-point:BEFORE FIELD mmbssite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbssite
            
            #add-point:AFTER FIELD mmbssite
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbssite
            #add-point:ON CHANGE mmbssite
            
            #END add-point
 
         #----<<mmbs001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs001
            #add-point:BEFORE FIELD mmbs001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs001
            
            #add-point:AFTER FIELD mmbs001
                        #此段落由子樣板a05產生
         


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbs001
            #add-point:ON CHANGE mmbs001
            
            #END add-point
 
         #----<<mmbs002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs002
            #add-point:BEFORE FIELD mmbs002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs002
            
            #add-point:AFTER FIELD mmbs002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbs002
            #add-point:ON CHANGE mmbs002
            
            #END add-point
 
         #----<<mmbs003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs003
            #add-point:BEFORE FIELD mmbs003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs003
            
            #add-point:AFTER FIELD mmbs003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbs003
            #add-point:ON CHANGE mmbs003
            
            #END add-point
 
         #----<<mmbs004>>----
         #此段落由子樣板a02產生
         AFTER FIELD mmbs004
            
            #add-point:AFTER FIELD mmbs004
            LET g_mmbp2_d[l_ac].mmbs004_desc = ''
            DISPLAY BY NAME g_mmbp2_d[l_ac].mmbs004_desc
            IF g_mmbo_m.mmbodocno IS NOT NULL AND g_mmbp2_d[g_detail_idx].mmbs004 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp2_d[g_detail_idx].mmbs004 != g_mmbp2_d_t.mmbs004)) THEN #160824-00008#113 by sakura mark
               IF g_mmbp2_d[l_ac].mmbs004 != g_mmbp2_d_o.mmbs004 OR cl_null(g_mmbp2_d_o.mmbs004) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbs_t WHERE "||"mmbsent = '" ||g_enterprise|| "' AND "||"mmbsdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbs004 = '"||g_mmbp2_d[g_detail_idx].mmbs004 ||"'",'std-00004',0) THEN 
                     #LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_t.mmbs004 #160824-00007#113 by sakura mark
                     LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_o.mmbs004  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp2_d[l_ac].mmbs004
                     CALL ammt350_mmbs004_ref()
                     NEXT FIELD CURRENT
                  END IF
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_errshow = '1'
#                  LET g_chkparam.arg1 = g_mmbp2_d[l_ac].mmbs004
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_mmbo_m.mmbosite
#                  IF NOT cl_chk_exist("v_ooed004") THEN
#                     LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_t.mmbs004
#                     CALL ammt350_mmbs004_ref()
#                     NEXT FIELD CURRENT
#                  END IF
                  IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
                     CALL s_aooi500_chk(g_prog,'mmbs004',g_mmbp2_d[l_ac].mmbs004,g_mmbo_m.mmbosite) RETURNING l_success,l_errno
                     IF NOT l_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_mmbp2_d[l_ac].mmbs004
                        LET g_errparam.code   = l_errno
                        LET g_errparam.popup  = TRUE
                        CALL cl_err()
                        
                        #LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_t.mmbs004 #160824-00007#113 by sakura mark
                        LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_o.mmbs004  #160824-00007#113 by sakura add
                        CALL s_desc_get_department_desc(g_mmbp2_d[l_ac].mmbs004) RETURNING g_mmbp2_d[l_ac].mmbs004_desc
                        DISPLAY BY NAME g_mmbp2_d[l_ac].mmbs004,g_mmbp2_d[l_ac].mmbs004_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_errshow = '1'
                     LET g_chkparam.arg1 = g_mmbp2_d[l_ac].mmbs004
                     LET g_chkparam.arg2 = '8'
                     LET g_chkparam.arg3 = g_mmbo_m.mmbosite
                     IF NOT cl_chk_exist("v_ooed004") THEN
                        #LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_t.mmbs004 #160824-00007#113 by sakura mark
                        LET g_mmbp2_d[l_ac].mmbs004 = g_mmbp2_d_o.mmbs004  #160824-00007#113 by sakura add
                        CALL ammt350_mmbs004_ref()
                        NEXT FIELD CURRENT
                     END IF
                  END IF 
               END IF
               CALL ammt350_mmbs004_ref()
            END IF
            LET g_mmbp2_d_o.* = g_mmbp2_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs004
            #add-point:BEFORE FIELD mmbs004
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE mmbs004
            #add-point:ON CHANGE mmbs004
            
            #END add-point
 
         #----<<mmbs004_desc>>----
         #----<<mmbs005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbs005
            #add-point:BEFORE FIELD mmbs005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbs005
            
            #add-point:AFTER FIELD mmbs005
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbs005
            #add-point:ON CHANGE mmbs005
            
            #END add-point
 
         #----<<mmbsacti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbsacti
            #add-point:BEFORE FIELD mmbsacti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbsacti
            
            #add-point:AFTER FIELD mmbsacti
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbsacti
            #add-point:ON CHANGE mmbsacti
            
            #END add-point
 
 
         #---------------------<  Detail: page2  >---------------------
         #----<<mmbsunit>>----
         #Ctrlp:input.c.page2.mmbsunit
         ON ACTION controlp INFIELD mmbsunit
            #add-point:ON ACTION controlp INFIELD mmbsunit
            
            #END add-point
 
         #----<<mmbssite>>----
         #Ctrlp:input.c.page2.mmbssite
         ON ACTION controlp INFIELD mmbssite
            #add-point:ON ACTION controlp INFIELD mmbssite
            
            #END add-point
 
         #----<<mmbs001>>----
         #Ctrlp:input.c.page2.mmbs001
         ON ACTION controlp INFIELD mmbs001
            #add-point:ON ACTION controlp INFIELD mmbs001
            
            #END add-point
 
         #----<<mmbs002>>----
         #Ctrlp:input.c.page2.mmbs002
         ON ACTION controlp INFIELD mmbs002
            #add-point:ON ACTION controlp INFIELD mmbs002
            
            #END add-point
 
         #----<<mmbs003>>----
         #Ctrlp:input.c.page2.mmbs003
         ON ACTION controlp INFIELD mmbs003
            #add-point:ON ACTION controlp INFIELD mmbs003
            
            #END add-point
 
         #----<<mmbs004>>----
         #Ctrlp:input.c.page2.mmbs004
         ON ACTION controlp INFIELD mmbs004
            #add-point:ON ACTION controlp INFIELD mmbs004
            #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_mmbp2_d[l_ac].mmbs004             #給予default值

            #給予arg
#            LET g_qryparam.arg1 = g_mmbo_m.mmbosite
#            LET g_qryparam.arg2 = '8'
#
#            CALL q_ooed004()                                #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'mmbs004') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbs004',g_mmbo_m.mmbosite,'i')   #150308-00001#4  By benson add 'c'
               CALL q_ooef001_24() 
            ELSE
               LET g_qryparam.arg1 = g_mmbo_m.mmbosite
               LET g_qryparam.arg2 = '8'
               CALL q_ooed004()
            END IF
            LET g_mmbp2_d[l_ac].mmbs004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL ammt350_mmbs004_ref()
            DISPLAY g_mmbp2_d[l_ac].mmbs004 TO mmbs004              #顯示到畫面上

            NEXT FIELD mmbs004                          #返回原欄位


            #END add-point
 
         #----<<mmbs004_desc>>----
         #----<<mmbs005>>----
         #Ctrlp:input.c.page2.mmbs005
         ON ACTION controlp INFIELD mmbs005
            #add-point:ON ACTION controlp INFIELD mmbs005
            
            #END add-point
 
         #----<<mmbsacti>>----
         #Ctrlp:input.c.page2.mmbsacti
         ON ACTION controlp INFIELD mmbsacti
            #add-point:ON ACTION controlp INFIELD mmbsacti
            
            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmbp2_d[l_ac].* = g_mmbp2_d_t.*
               END IF
               CLOSE ammt350_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt350_unlock_b("mmbs_t","'2'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_mmbp2_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmbp2_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_mmbp3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbp3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt350_b_fill()
            LET g_rec_b = g_mmbp3_d.getLength()
            #add-point:資料輸入前
            LET g_current_page = 3
            #end add-point
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbp3_d[l_ac].* TO NULL 
                  LET g_mmbp3_d[l_ac].mmbr003 = "Q"
      LET g_mmbp3_d[l_ac].mmbr005 = "Y"
      LET g_mmbp3_d[l_ac].mmbr007 = "1"
      LET g_mmbp3_d[l_ac].mmbr010 = "1"
      LET g_mmbp3_d[l_ac].mmbr011 = "0"
      LET g_mmbp3_d[l_ac].mmbr013 = "0"
      LET g_mmbp3_d[l_ac].mmbracti = "Y"
 
 
            LET g_mmbp3_d_t.* = g_mmbp3_d[l_ac].*     #新輸入資料
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*     #新輸入資料 #160824-00007#113 by sakura add
            CALL cl_show_fld_cont()
            CALL ammt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b
            
            #end add-point
            CALL ammt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbp3_d[li_reproduce_target].* = g_mmbp3_d[li_reproduce].*
 
               LET g_mmbp3_d[li_reproduce_target].mmbr003 = NULL
               LET g_mmbp3_d[li_reproduce_target].mmbr004 = NULL
            END IF
            #公用欄位給值(單身3)
            
            
            #add-point:modify段before insert
            LET g_mmbp3_d[l_ac].mmbrsite = g_mmbo_m.mmbosite
            LET g_mmbp3_d[l_ac].mmbrunit = g_mmbo_m.mmbounit
            LET g_mmbp3_d[l_ac].mmbr001  = g_mmbo_m.mmbo001
            LET g_mmbp3_d[l_ac].mmbr002  = g_mmbo_m.mmbo005 
            #160613-00031#1 160615 by sakura mark(S)
            #LET g_mmbp3_d[l_ac].mmbr014  = g_mmbo_m.mmbo014
            #LET g_mmbp3_d[l_ac].mmbr015  = g_mmbo_m.mmbo015
            #160613-00031#1 160615 by sakura mark(E)
            #CALL ammt350_show_desc(l_ac) #160613-00031#1 160615 by sakura add
            #end add-point  
            
         BEFORE ROW     
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            #LET g_detail_idx = l_ac   #160613-00031#1 160615 by sakura mark
            LET g_detail_idx3 = l_ac   #160613-00031#1 160615 by sakura add
            CALL ammt350_b_fill2('4')   #160613-00031#1 160615 by sakura add
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  STATUS
               LET g_errparam.extend = "OPEN ammt350_cl:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               CLOSE ammt350_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_mmbp3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbp3_d[l_ac].mmbr003 IS NOT NULL
               AND g_mmbp3_d[l_ac].mmbr004 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmbp3_d_t.* = g_mmbp3_d[l_ac].*  #BACKUP
               LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #BACKUP #160824-00007#113 by sakura add
               CALL ammt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b
               
               #end add-point  
               CALL ammt350_set_no_entry_b(l_cmd)
               IF NOT ammt350_lock_b("mmbr_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt350_bcl3 INTO g_mmbp3_d[l_ac].mmbrunit,g_mmbp3_d[l_ac].mmbrsite,g_mmbp3_d[l_ac].mmbr001, 
                      g_mmbp3_d[l_ac].mmbr002,g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,g_mmbp3_d[l_ac].mmbr004_desc, 
                      g_mmbp3_d[l_ac].mmbr005,g_mmbp3_d[l_ac].mmbr006,g_mmbp3_d[l_ac].mmbr007,g_mmbp3_d[l_ac].mmbr008, 
                      g_mmbp3_d[l_ac].mmbr009,g_mmbp3_d[l_ac].mmbr010,g_mmbp3_d[l_ac].mmbr011,g_mmbp3_d[l_ac].mmbr012, 
                      g_mmbp3_d[l_ac].mmbr013,g_mmbp3_d[l_ac].mmbr014,g_mmbp3_d[l_ac].mmbr015,g_mmbp3_d[l_ac].mmbr016, 
                      g_mmbp3_d[l_ac].mmbr017,g_mmbp3_d[l_ac].mmbr018,g_mmbp3_d[l_ac].mmbr019,g_mmbp3_d[l_ac].mmbracti 
 
                   IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL ammt350_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
               #CALL ammt350_show_desc(l_ac)  #160613-00031#1 160615 by sakura add
               CALL ammt350_set_entry_b(l_cmd)      
               CALL ammt350_set_no_entry_b(l_cmd)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_mmbp3_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_mmbp3_d.deleteElement(l_ac)
               NEXT FIELD mmbr003
            END IF
         
            IF g_mmbp3_d[l_ac].mmbr003 IS NOT NULL
               AND g_mmbp3_d_t.mmbr004 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               
               #add-point:單身3刪除前
               
               #end add-point    
               
               DELETE FROM mmbr_t
                WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbo_m.mmbodocno AND
                      mmbr003 = g_mmbp3_d_t.mmbr003
                  AND mmbr004 = g_mmbp3_d_t.mmbr004
                  
               #add-point:單身3刪除中
               
               #end add-point    
                  
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbp_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  #add-point:單身3刪除後
                  
                  #end add-point
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE ammt350_bcl
               LET l_count = g_mmbp_d.getLength()
            END IF 
            
                           INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               #LET gs_keys[2] = g_mmbp3_d[g_detail_idx].mmbr003   #160613-00031#1 160615 by sakura mark
               #LET gs_keys[3] = g_mmbp3_d[g_detail_idx].mmbr004   #160613-00031#1 160615 by sakura mark
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003   #160613-00031#1 160615 by sakura add
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004   #160613-00031#1 160615 by sakura add
               
 
            
         AFTER DELETE 
            #add-point:單身AFTER DELETE 
            
            #end add-point
                           CALL ammt350_delete_b('mmbr_t',gs_keys,"'3'")
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身3新增前
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM mmbr_t 
             WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbo_m.mmbodocno
               AND mmbr003 = g_mmbp3_d[l_ac].mmbr003
               AND mmbr004 = g_mmbp3_d[l_ac].mmbr004
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               #LET gs_keys[2] = g_mmbp3_d[g_detail_idx].mmbr003   #160613-00031#1 160615 by sakura mark
               #LET gs_keys[3] = g_mmbp3_d[g_detail_idx].mmbr004   #160613-00031#1 160615 by sakura mark
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003   #160613-00031#1 160615 by sakura add
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004   #160613-00031#1 160615 by sakura add            
               CALL ammt350_insert_b('mmbr_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               INITIALIZE g_mmbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL ammt350_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後
               #CALL ammt350_show_desc(l_ac)   #160613-00031#1 160615 by sakura mark
               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_mmbp3_d[l_ac].* = g_mmbp3_d_t.*
               CLOSE ammt350_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
               LET g_mmbp3_d[l_ac].* = g_mmbp3_d_t.*
            ELSE
               #add-point:單身page3修改前
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               UPDATE mmbr_t SET (mmbrdocno,mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr003,mmbr004,mmbr005, 
                   mmbr006,mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016, 
                   mmbr017,mmbr018,mmbr019,mmbracti) = (g_mmbo_m.mmbodocno,g_mmbp3_d[l_ac].mmbrunit, 
                   g_mmbp3_d[l_ac].mmbrsite,g_mmbp3_d[l_ac].mmbr001,g_mmbp3_d[l_ac].mmbr002,g_mmbp3_d[l_ac].mmbr003, 
                   g_mmbp3_d[l_ac].mmbr004,g_mmbp3_d[l_ac].mmbr005,g_mmbp3_d[l_ac].mmbr006,g_mmbp3_d[l_ac].mmbr007, 
                   g_mmbp3_d[l_ac].mmbr008,g_mmbp3_d[l_ac].mmbr009,g_mmbp3_d[l_ac].mmbr010,g_mmbp3_d[l_ac].mmbr011, 
                   g_mmbp3_d[l_ac].mmbr012,g_mmbp3_d[l_ac].mmbr013,g_mmbp3_d[l_ac].mmbr014,g_mmbp3_d[l_ac].mmbr015, 
                   g_mmbp3_d[l_ac].mmbr016,g_mmbp3_d[l_ac].mmbr017,g_mmbp3_d[l_ac].mmbr018,g_mmbp3_d[l_ac].mmbr019, 
                   g_mmbp3_d[l_ac].mmbracti) #自訂欄位頁簽
                WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbo_m.mmbodocno
                  AND mmbr003 = g_mmbp3_d_t.mmbr003 #項次 
                  AND mmbr004 = g_mmbp3_d_t.mmbr004
                  
               #add-point:單身page3修改中
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "mmbr_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                     LET g_mmbp3_d[l_ac].* = g_mmbp3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "mmbr_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_mmbp3_d[l_ac].* = g_mmbp3_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               #LET gs_keys[2] = g_mmbp3_d[g_detail_idx].mmbr003   #160613-00031#1 160615 by sakura mark
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003   #160613-00031#1 160615 by sakura add
               LET gs_keys_bak[2] = g_mmbp3_d_t.mmbr003
               #LET gs_keys[3] = g_mmbp3_d[g_detail_idx].mmbr004   #160613-00031#1 160615 by sakura mark
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004    #160613-00031#1 160615 by sakura add
               LET gs_keys_bak[3] = g_mmbp3_d_t.mmbr004
               CALL ammt350_update_b('mmbr_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               #add-point:單身page3修改後
               #CALL ammt350_show_desc(l_ac)   #160613-00031#1 160615 by sakura add
               #end add-point
            END IF
         
         #---------------------<  Detail: page3  >---------------------
         #----<<mmbrunit>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbrunit
            #add-point:BEFORE FIELD mmbrunit
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbrunit
            
            #add-point:AFTER FIELD mmbrunit
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbrunit
            #add-point:ON CHANGE mmbrunit
            
            #END add-point
 
         #----<<mmbrsite>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbrsite
            #add-point:BEFORE FIELD mmbrsite
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbrsite
            
            #add-point:AFTER FIELD mmbrsite
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbrsite
            #add-point:ON CHANGE mmbrsite
            
            #END add-point
 
         #----<<mmbr001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr001
            #add-point:BEFORE FIELD mmbr001
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr001
            
            #add-point:AFTER FIELD mmbr001
            IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr001) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr003) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp3_d[l_ac].mmbr001 != g_mmbp3_d_t.mmbr001 OR g_mmbp3_d[l_ac].mmbr003 != g_mmbp3_d_t.mmbr003 OR g_mmbp3_d[l_ac].mmbr004 != g_mmbp3_d_t.mmbr004))) THEN #160824-00008#113 by sakura mark
               IF g_mmbp3_d[l_ac].mmbr001 != g_mmbp3_d_o.mmbr001 OR cl_null(g_mmbp3_d_o.mmbr001) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbr_t WHERE "||"mmbrent = '" ||g_enterprise|| "' AND mmbrsite = '" ||g_site|| "' AND "||"mmbrdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbr001 = '"||g_mmbp3_d[l_ac].mmbr001 ||"' AND "|| "mmbr003 = '"||g_mmbp3_d[l_ac].mmbr003 ||"' AND "|| "mmbr004 = '"||g_mmbp3_d[l_ac].mmbr004 ||"'",'std-00004',0) THEN 
                     LET g_mmbp3_d[l_ac].mmbr001 = g_mmbp3_d_o.mmbr001  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr001
            #add-point:ON CHANGE mmbr001
            
            #END add-point
 
         #----<<mmbr002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr002
            #add-point:BEFORE FIELD mmbr002
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr002
            
            #add-point:AFTER FIELD mmbr002
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr002
            #add-point:ON CHANGE mmbr002
            
            #END add-point
 
         #----<<mmbr003>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr003
            #add-point:BEFORE FIELD mmbr003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr003
            
            #add-point:AFTER FIELD mmbr003
            IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr001) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr003) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp3_d[l_ac].mmbr001 != g_mmbp3_d_t.mmbr001 OR g_mmbp3_d[l_ac].mmbr003 != g_mmbp3_d_t.mmbr003 OR g_mmbp3_d[l_ac].mmbr004 != g_mmbp3_d_t.mmbr004))) THEN  #160824-00008#113 by sakura mark
               IF g_mmbp3_d[l_ac].mmbr003 != g_mmbp3_d_o.mmbr003 OR cl_null(g_mmbp3_d_o.mmbr003) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbr_t WHERE "||"mmbrent = '" ||g_enterprise|| "' AND mmbrsite = '" ||g_site|| "' AND "||"mmbrdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbr001 = '"||g_mmbp3_d[l_ac].mmbr001 ||"' AND "|| "mmbr003 = '"||g_mmbp3_d[l_ac].mmbr003 ||"' AND "|| "mmbr004 = '"||g_mmbp3_d[l_ac].mmbr004 ||"'",'std-00004',0) THEN 
                     LET g_mmbp3_d[l_ac].mmbr003 = g_mmbp3_d_o.mmbr003  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aint800_01_check(g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,'',g_mmbo_m.mmbosite,'') RETURNING l_flag,g_mmbp3_d[l_ac].mmbr004_desc
                  IF NOT l_flag THEN
                     #LET g_mmbp3_d[l_ac].mmbr003 = g_mmbp3_d_t.mmbr003 #160824-00007#113 by sakura mark
                     LET g_mmbp3_d[l_ac].mmbr003 = g_mmbp3_d_o.mmbr003  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr003
                     CALL ammt350_mmbr004_ref(g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr003
            #add-point:ON CHANGE mmbr003
             CALL ammt350_set_entry_b(l_cmd)
             CALL ammt350_set_no_entry_b(l_cmd) 
            #END add-point
 
         #----<<mmbr004>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr004
            #add-point:BEFORE FIELD mmbr004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr004
            
            #add-point:AFTER FIELD mmbr004
            LET g_mmbp3_d[l_ac].mmbr004_desc = ''
            DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr004_desc
            IF NOT cl_null(g_mmbo_m.mmbodocno) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr001) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr003) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr004) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp3_d[l_ac].mmbr001 != g_mmbp3_d_t.mmbr001 OR g_mmbp3_d[l_ac].mmbr003 != g_mmbp3_d_t.mmbr003 OR g_mmbp3_d[l_ac].mmbr004 != g_mmbp3_d_t.mmbr004))) THEN #160824-00008#113 by sakura mark
               IF g_mmbp3_d[l_ac].mmbr004 != g_mmbp3_d_o.mmbr004 OR cl_null(g_mmbp3_d_o.mmbr004) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmbr_t WHERE "||"mmbrent = '" ||g_enterprise|| "' AND mmbrsite = '" ||g_site|| "' AND "||"mmbrdocno = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmbr001 = '"||g_mmbp3_d[l_ac].mmbr001 ||"' AND "|| "mmbr003 = '"||g_mmbp3_d[l_ac].mmbr003 ||"' AND "|| "mmbr004 = '"||g_mmbp3_d[l_ac].mmbr004 ||"'",'std-00004',0) THEN 
                     #LET g_mmbp3_d[l_ac].mmbr004 = g_mmbp3_d_t.mmbr004 #160824-00007#113 by sakura mark
                     LET g_mmbp3_d[l_ac].mmbr004 = g_mmbp3_d_o.mmbr004  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr004
                     CALL ammt350_mmbr004_ref(  g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
                     NEXT FIELD CURRENT
                  END IF

                  CALL s_aint800_01_check(g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,'',g_mmbo_m.mmbosite,'') RETURNING l_flag,g_mmbp3_d[l_ac].mmbr004_desc
                  IF NOT l_flag THEN
                     #LET g_mmbp3_d[l_ac].mmbr004 = g_mmbp3_d_t.mmbr004 #160824-00007#113 by sakura mark
                     LET g_mmbp3_d[l_ac].mmbr004 = g_mmbp3_d_o.mmbr004  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr004
                     CALL ammt350_mmbr004_ref(  g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
                     NEXT FIELD CURRENT
                  END IF
                 
               END IF
               CALL ammt350_mmbr004_ref(  g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
            END IF
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr004
            #add-point:ON CHANGE mmbr004
            
            #END add-point
 
         #----<<mmbr004_desc>>----
         #----<<mmbr005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr005
            #add-point:BEFORE FIELD mmbr005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr005
            
            #add-point:AFTER FIELD mmbr005
            IF NOT cl_null(g_mmbp3_d[l_ac].mmbr005) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_mmbp3_d[l_ac].mmbr005 != g_mmbp3_d_t.mmbr005) THEN #160824-00008#113 by sakura mark
               IF g_mmbp3_d[l_ac].mmbr005 != g_mmbp3_d_o.mmbr005 OR cl_null(g_mmbp3_d_o.mmbr005) THEN #160824-00007#113 by sakura add
                  IF NOT ammt350_mmbr006_chk() THEN
                     #LET g_mmbp3_d[l_ac].mmbr005 = g_mmbp3_d_t.mmbr005 #160824-00007#113 by sakura mark
                     #160824-00007#113 by sakura add(S)
                     LET g_mmbp3_d[l_ac].mmbr005 = g_mmbp3_d_o.mmbr005
                     LET g_mmbp3_d[l_ac].mmbr006 = g_mmbp3_d_o.mmbr006
                     #160824-00007#113 by sakura add(E)
                     DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_mmbp3_d[l_ac].mmbr005 = 'N' THEN
               LET g_mmbp3_d[l_ac].mmbr006 = ''
            END IF
            CALL ammt350_set_entry_b(p_cmd)
            CALL ammt350_set_no_entry_b(p_cmd)
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr005
            #add-point:ON CHANGE mmbr005
             CALL ammt350_set_entry_b(l_cmd)
             CALL ammt350_set_no_required_b(l_cmd)
             CALL ammt350_set_required_b(l_cmd)
             CALL ammt350_set_no_entry_b(l_cmd)
            IF g_mmbp3_d[l_ac].mmbr005 = 'N' THEN
               LET  g_mmbp3_d[l_ac].mmbr006 =''
            ELSE
               IF NOT cl_null(g_mmbp3_d[l_ac].mmbr006) THEN
                  IF NOT ammt350_mmbr006_chk() THEN
                     LET g_mmbp3_d[l_ac].mmbr005 = 'N'
                     NEXT FIELD mmbr005
                  END IF
               END IF                  
            END IF
            #END add-point
 
         #----<<mmbr006>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr006
            #add-point:BEFORE FIELD mmbr006
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr006
            
            #add-point:AFTER FIELD mmbr006
            IF NOT cl_ap_chk_Range(g_mmbp3_d[l_ac].mmbr006,"0.000","0","","","azz-00079",1) THEN
               #LET g_mmbp3_d[l_ac].mmbr006 = g_mmbp3_d_t.mmbr006 #160824-00007#113 by sakura mark
               LET g_mmbp3_d[l_ac].mmbr006 = g_mmbp3_d_o.mmbr006  #160824-00007#113 by sakura add
               NEXT FIELD mmbr006
            END IF
             IF NOT cl_null(g_mmbp3_d[l_ac].mmbr006) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND g_mmbp3_d[l_ac].mmbr006 != g_mmbp3_d_t.mmbr006) THEN #160824-00008#113 by sakura mark
               IF g_mmbp3_d[l_ac].mmbr006 != g_mmbp3_d_o.mmbr006 OR cl_null(g_mmbp3_d_o.mmbr006) THEN #160824-00007#113 by sakura add
                  IF NOT ammt350_mmbr006_chk() THEN
                     #LET g_mmbp3_d[l_ac].mmbr006 = g_mmbp3_d_t.mmbr006 #160824-00007#113 by sakura mark
                     LET g_mmbp3_d[l_ac].mmbr006 = g_mmbp3_d_o.mmbr006  #160824-00007#113 by sakura add
                     DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_mmbp3_d_o.* = g_mmbp3_d[l_ac].*  #160824-00007#113 by sakura add
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr006
            #add-point:ON CHANGE mmbr006
            
            #END add-point
 
         #----<<mmbr007>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr007
            #add-point:BEFORE FIELD mmbr007
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr007
            
            #add-point:AFTER FIELD mmbr007
            IF NOT cl_null(g_mmbp3_d[l_ac].mmbr007) THEN
               CALL ammt350_mmbr007_init()
            END IF
            CALL ammt350_set_entry_b(p_cmd)
            CALL ammt350_set_no_entry_b(p_cmd) 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr007
            #add-point:ON CHANGE mmbr007
            
            #END add-point
 
         #----<<mmbr008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr008
            #add-point:BEFORE FIELD mmbr008
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr008
            
            #add-point:AFTER FIELD mmbr008
            IF NOT cl_ap_chk_Range(g_mmbp3_d[l_ac].mmbr008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmbr008
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr008
            #add-point:ON CHANGE mmbr008
            
            #END add-point
 
         #----<<mmbr009>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr009
            #add-point:BEFORE FIELD mmbr009
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr009
            
            #add-point:AFTER FIELD mmbr009
                        IF NOT cl_ap_chk_Range(g_mmbp3_d[l_ac].mmbr009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD mmbr009
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr009
            #add-point:ON CHANGE mmbr009
            
            #END add-point
 
         #----<<mmbr010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr010
            #add-point:BEFORE FIELD mmbr010
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr010
            
            #add-point:AFTER FIELD mmbr010
                        IF NOT cl_null(g_mmbp3_d[l_ac].mmbr010) THEN
               CALL ammt350_mmbr010_init()
            END IF
            CALL ammt350_set_entry_b(p_cmd)
            CALL ammt350_set_no_entry_b(p_cmd)
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr010
            #add-point:ON CHANGE mmbr010
                        CALL ammt350_set_no_required_b(l_cmd)
            CALL ammt350_set_required_b(l_cmd)
            #END add-point
 
         #----<<mmbr011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr011
            #add-point:BEFORE FIELD mmbr011
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr011
            
            #add-point:AFTER FIELD mmbr011
                         IF NOT cl_null(g_mmbp3_d[l_ac].mmbr011) THEN
               IF g_mmbp3_d[l_ac].mmbr010 = '1' THEN
                  IF g_mmbp3_d[l_ac].mmbr011 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00005'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET g_mmbp3_d[l_ac].mmbr011 = g_mmbp3_d_t.mmbr011
                     NEXT FIELD mmbr011
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr011
            #add-point:ON CHANGE mmbr011
            
            #END add-point
 
         #----<<mmbr012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr012
            #add-point:BEFORE FIELD mmbr012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr012
            
            #add-point:AFTER FIELD mmbr012
                         IF NOT cl_null(g_mmbp3_d[l_ac].mmbr012) THEN
               IF g_mmbp3_d[l_ac].mmbr010 = '3' THEN
                  IF g_mmbp3_d[l_ac].mmbr012 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00006'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET g_mmbp3_d[l_ac].mmbr012 = g_mmbp3_d_t.mmbr012
                     NEXT FIELD mmbr012
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr012
            #add-point:ON CHANGE mmbr012
            
            #END add-point
 
         #----<<mmbr013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr013
            #add-point:BEFORE FIELD mmbr013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr013
            
            #add-point:AFTER FIELD mmbr013
                         IF NOT cl_null(g_mmbp3_d[l_ac].mmbr013) THEN
               IF g_mmbp3_d[l_ac].mmbr010 <> '1' THEN
                  IF g_mmbp3_d[l_ac].mmbr013 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00005'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     LET g_mmbp3_d[l_ac].mmbr013 = g_mmbp3_d_t.mmbr013
                     NEXT FIELD mmbr013
                  END IF
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr013
            #add-point:ON CHANGE mmbr013
            
            #END add-point
 
         #----<<mmbr014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr014
            #add-point:BEFORE FIELD mmbr014
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr014
            
            #add-point:AFTER FIELD mmbr014
            IF NOT cl_null( g_mmbp3_d[l_ac].mmbr014) THEN
               IF NOT ammt350_mmbt014_chk() THEN
                  LET g_mmbp3_d[l_ac].mmbr014= g_mmbp3_d_t.mmbr014
                  DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr014
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr014
            #add-point:ON CHANGE mmbr014
            
            #END add-point
 
         #----<<mmbr015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr015
            #add-point:BEFORE FIELD mmbr015
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr015
            
            #add-point:AFTER FIELD mmbr015
            IF NOT cl_null( g_mmbp3_d[l_ac].mmbr015) THEN
               IF NOT ammt350_mmbt014_chk() THEN
                  LET g_mmbp3_d[l_ac].mmbr015= g_mmbp3_d_t.mmbr015
                  DISPLAY BY NAME g_mmbp3_d[l_ac].mmbr015
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr015
            #add-point:ON CHANGE mmbr015
            
            #END add-point
 
         #----<<mmbr016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr016
            #add-point:BEFORE FIELD mmbr016
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr016
            
            #add-point:AFTER FIELD mmbr016
            IF NOT cl_null(g_mmbp3_d[l_ac].mmbr016) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr017) THEN
               IF g_mmbp3_d[l_ac].mmbr016 > g_mmbp3_d[l_ac].mmbr017 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbr016
               END IF               
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr016
            #add-point:ON CHANGE mmbr016
            
            #END add-point
 
         #----<<mmbr017>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr017
            #add-point:BEFORE FIELD mmbr017
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr017
            
            #add-point:AFTER FIELD mmbr017
             IF NOT cl_null(g_mmbp3_d[l_ac].mmbr016) AND NOT cl_null(g_mmbp3_d[l_ac].mmbr017) THEN
               IF g_mmbp3_d[l_ac].mmbr016 > g_mmbp3_d[l_ac].mmbr017 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmbr017
               END IF               
            END IF
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr017
            #add-point:ON CHANGE mmbr017
            
            #END add-point
 
         #----<<mmbr018>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr018
            #add-point:BEFORE FIELD mmbr018
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr018
            
            #add-point:AFTER FIELD mmbr018
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr018
            #add-point:ON CHANGE mmbr018
            
            #END add-point
 
         #----<<mmbr019>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbr019
            #add-point:BEFORE FIELD mmbr019
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbr019
            
            #add-point:AFTER FIELD mmbr019
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbr019
            #add-point:ON CHANGE mmbr019
            
            #END add-point
 
         #----<<mmbracti>>----
         #此段落由子樣板a01產生
         BEFORE FIELD mmbracti
            #add-point:BEFORE FIELD mmbracti
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD mmbracti
            
            #add-point:AFTER FIELD mmbracti
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE mmbracti
            #add-point:ON CHANGE mmbracti
            
            #END add-point
 
 
         #---------------------<  Detail: page3  >---------------------
         #----<<mmbrunit>>----
         #Ctrlp:input.c.page3.mmbrunit
         ON ACTION controlp INFIELD mmbrunit
            #add-point:ON ACTION controlp INFIELD mmbrunit
            
            #END add-point
 
         #----<<mmbrsite>>----
         #Ctrlp:input.c.page3.mmbrsite
         ON ACTION controlp INFIELD mmbrsite
            #add-point:ON ACTION controlp INFIELD mmbrsite
            
            #END add-point
 
         #----<<mmbr001>>----
         #Ctrlp:input.c.page3.mmbr001
         ON ACTION controlp INFIELD mmbr001
            #add-point:ON ACTION controlp INFIELD mmbr001
            
            #END add-point
 
         #----<<mmbr002>>----
         #Ctrlp:input.c.page3.mmbr002
         ON ACTION controlp INFIELD mmbr002
            #add-point:ON ACTION controlp INFIELD mmbr002
            
            #END add-point
 
         #----<<mmbr003>>----
         #Ctrlp:input.c.page3.mmbr003
         ON ACTION controlp INFIELD mmbr003
            #add-point:ON ACTION controlp INFIELD mmbr003
            
            #END add-point
 
         #----<<mmbr004>>----
         #Ctrlp:input.c.page3.mmbr004
         ON ACTION controlp INFIELD mmbr004
            #add-point:ON ACTION controlp INFIELD mmbr004
            INITIALIZE g_qryparam.* TO NULL       
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'i'
            CALL s_aint800_01_controlp( g_mmbp3_d[l_ac].mmbr003,'',g_mmbo_m.mmbosite) RETURNING l_flag
            LET g_mmbp3_d[l_ac].mmbr004 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO  mmbr004     #顯示到畫面上
            CALL ammt350_mmbr004_ref(g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
            NEXT FIELD mmbr004                     #返回原欄位
            #END add-point
 
         #----<<mmbr004_desc>>----
         #----<<mmbr005>>----
         #Ctrlp:input.c.page3.mmbr005
         ON ACTION controlp INFIELD mmbr005
            #add-point:ON ACTION controlp INFIELD mmbr005
            
            #END add-point
 
         #----<<mmbr006>>----
         #Ctrlp:input.c.page3.mmbr006
         ON ACTION controlp INFIELD mmbr006
            #add-point:ON ACTION controlp INFIELD mmbr006
            
            #END add-point
 
         #----<<mmbr007>>----
         #Ctrlp:input.c.page3.mmbr007
         ON ACTION controlp INFIELD mmbr007
            #add-point:ON ACTION controlp INFIELD mmbr007
            
            #END add-point
 
         #----<<mmbr008>>----
         #Ctrlp:input.c.page3.mmbr008
         ON ACTION controlp INFIELD mmbr008
            #add-point:ON ACTION controlp INFIELD mmbr008
            
            #END add-point
 
         #----<<mmbr009>>----
         #Ctrlp:input.c.page3.mmbr009
         ON ACTION controlp INFIELD mmbr009
            #add-point:ON ACTION controlp INFIELD mmbr009
            
            #END add-point
 
         #----<<mmbr010>>----
         #Ctrlp:input.c.page3.mmbr010
         ON ACTION controlp INFIELD mmbr010
            #add-point:ON ACTION controlp INFIELD mmbr010
            
            #END add-point
 
         #----<<mmbr011>>----
         #Ctrlp:input.c.page3.mmbr011
         ON ACTION controlp INFIELD mmbr011
            #add-point:ON ACTION controlp INFIELD mmbr011
            
            #END add-point
 
         #----<<mmbr012>>----
         #Ctrlp:input.c.page3.mmbr012
         ON ACTION controlp INFIELD mmbr012
            #add-point:ON ACTION controlp INFIELD mmbr012
            
            #END add-point
 
         #----<<mmbr013>>----
         #Ctrlp:input.c.page3.mmbr013
         ON ACTION controlp INFIELD mmbr013
            #add-point:ON ACTION controlp INFIELD mmbr013
            
            #END add-point
 
         #----<<mmbr014>>----
         #Ctrlp:input.c.page3.mmbr014
         ON ACTION controlp INFIELD mmbr014
            #add-point:ON ACTION controlp INFIELD mmbr014
            
            #END add-point
 
         #----<<mmbr015>>----
         #Ctrlp:input.c.page3.mmbr015
         ON ACTION controlp INFIELD mmbr015
            #add-point:ON ACTION controlp INFIELD mmbr015
            
            #END add-point
 
         #----<<mmbr016>>----
         #Ctrlp:input.c.page3.mmbr016
         ON ACTION controlp INFIELD mmbr016
            #add-point:ON ACTION controlp INFIELD mmbr016
            
            #END add-point
 
         #----<<mmbr017>>----
         #Ctrlp:input.c.page3.mmbr017
         ON ACTION controlp INFIELD mmbr017
            #add-point:ON ACTION controlp INFIELD mmbr017
            
            #END add-point
 
         #----<<mmbr018>>----
         #Ctrlp:input.c.page3.mmbr018
         ON ACTION controlp INFIELD mmbr018
            #add-point:ON ACTION controlp INFIELD mmbr018
            
            #END add-point
 
         #----<<mmbr019>>----
         #Ctrlp:input.c.page3.mmbr019
         ON ACTION controlp INFIELD mmbr019
            #add-point:ON ACTION controlp INFIELD mmbr019
            
            #END add-point
 
         #----<<mmbracti>>----
         #Ctrlp:input.c.page3.mmbracti
         ON ACTION controlp INFIELD mmbracti
            #add-point:ON ACTION controlp INFIELD mmbracti
            
            #END add-point
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
 
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmbp3_d[l_ac].* = g_mmbp3_d_t.*
               END IF
               CLOSE ammt350_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt350_unlock_b("mmbr_t","'3'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 
            
            #end add-point   
    
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_mmbp3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_mmbp3_d.getLength()+1
 
      END INPUT
 
      
 
      
 
      
 
      
 
{</section>}
 
{<section id="ammt350.input.other" >}
      
      #add-point:自定義input
      #160613-00031#1 160615 by sakura add(S)
      INPUT ARRAY g_mmbp4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
         
        
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_mmbp4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL ammt350_b_fill()
            LET g_rec_b = g_mmbp4_d.getLength()
            #add-point:資料輸入前
            LET g_current_page = 4
            #160613-00031#1 160615 by sakura add(S)
            #修改時，如第三頁籤無資料則不開放第四頁籤修改
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM mmbr_t
             WHERE mmbrent = g_enterprise
               AND mmbrdocno = g_mmbo_m.mmbodocno
            IF l_cnt = 0 OR cl_null(g_mmbp3_d[g_detail_idx3].mmbr004) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  'amm-00762'
               LET g_errparam.extend =  ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               
               NEXT FIELD mmbr003
            END IF
            #160613-00031#1 160615 by sakura add(E)
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_mmbp4_d[l_ac].* TO NULL
            
            #項次
            SELECT MAX(mmdj005)+1 INTO g_mmbp4_d[l_ac].mmdj005
              FROM mmdj_t
              WHERE mmdjent = g_enterprise
                AND mmdjdocno = g_mmbo_m.mmbodocno
                AND mmdj003 = g_mmbp3_d[g_detail_idx3].mmbr003
                AND mmdj004 = g_mmbp3_d[g_detail_idx3].mmbr004
            IF cl_null(g_mmbp4_d[l_ac].mmdj005) OR g_mmbp4_d[l_ac].mmdj005 = 0 THEN
               LET g_mmbp4_d[l_ac].mmdj005 = 1
            END IF
            #LET g_mmbp4_d[l_ac].mmdj006  = g_mmbo_m.mmbo014
            #LET g_mmbp4_d[l_ac].mmdj007  = g_mmbo_m.mmbo015
            LET g_mmbp4_d[l_ac].mmdjacti  = 'Y'
            #LET g_mmbp4_d[l_ac].mmdj008 = '00:00:00'
            #LET g_mmbp4_d[l_ac].mmdj009 = '23:59:59'            

            INITIALIZE g_mmbp4_d_t.* TO NULL 
            INITIALIZE g_mmbp4_d_o.* TO NULL
            LET g_mmbp4_d_t.* = g_mmbp4_d[l_ac].*     #新輸入資料
            LET g_mmbp4_d_o.* = g_mmbp4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL ammt350_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"

            #end add-point
            CALL ammt350_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_mmbp4_d[li_reproduce_target].* = g_mmbp4_d[li_reproduce].*
 
               LET g_mmbp4_d[li_reproduce_target].mmdj005 = NULL
            END IF
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body4.before_row2"

            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx4 = l_ac
            LET g_current_page = 4
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
            OPEN ammt350_bcl3 USING g_enterprise,g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx3].mmbr003,g_mmbp3_d[g_detail_idx3].mmbr004

            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN ammt350_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE ammt350_cl
               CLOSE ammt350_bcl3
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b = g_mmbp4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_mmbp4_d[l_ac].mmdj005 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_mmbp4_d_t.* = g_mmbp4_d[l_ac].*  #BACKUP
               LET g_mmbp4_d_o.* = g_mmbp4_d[l_ac].*  #BACKUP
               CALL ammt350_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"

               #end add-point  
               CALL ammt350_set_no_entry_b(l_cmd)
               IF NOT ammt350_lock_b("mmdj_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH ammt350_bcl4 INTO g_mmbp4_d[l_ac].mmdj005,g_mmbp4_d[l_ac].mmdj006,g_mmbp4_d[l_ac].mmdj007, 
                                          g_mmbp4_d[l_ac].mmdj008,g_mmbp4_d[l_ac].mmdj009,g_mmbp4_d[l_ac].mmdj010,
										            g_mmbp4_d[l_ac].mmdj011,g_mmbp4_d[l_ac].mmdjacti
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_mmbp4_d_mask_o[l_ac].* =  g_mmbp4_d[l_ac].*
                  LET g_mmbp4_d_mask_n[l_ac].* =  g_mmbp4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL ammt350_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
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
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004
               LET gs_keys[4] = g_mmbp4_d_t.mmdj005
               
               
               #add-point:單身4刪除中 name="input.body4.m_delete"

               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE ammt350_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"

               #end add-point
 
               LET l_count = g_mmbp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"

               #end add-point
            END IF 
 
         AFTER DELETE
           CALL ammt350_delete_b('mmdj_t',gs_keys,"'4'")
         
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
            SELECT COUNT(1) INTO l_count 
			     FROM mmdj_t 
             WHERE mmdjent = g_enterprise 
			      AND mmdjdocno = g_mmbo_m.mmbodocno 
			      AND mmdj003 = g_mmbp3_d[g_detail_idx3].mmbr003  
               AND mmdj004 = g_mmbp3_d[g_detail_idx3].mmbr004 
			      AND mmdj005 = g_mmbp4_d[g_detail_idx4].mmdj005 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"

               #end add-point
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno              
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004
               LET gs_keys[4] = g_mmbp4_d[g_detail_idx4].mmdj005
               CALL ammt350_insert_b('mmdj_t',gs_keys,"'4'")
                           

            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_mmbp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "mmdj_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_mmbp4_d[l_ac].* = g_mmbp4_d_t.*
               CLOSE ammt350_bcl4
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_mmbp4_d[l_ac].* = g_mmbp4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"

               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               UPDATE mmdj_t SET (mmdjdocno,mmdj003,mmdj004,mmdj005,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti) = 
                                 (g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx3].mmbr003,g_mmbp3_d[g_detail_idx3].mmbr004, 
                                  g_mmbp4_d[l_ac].mmdj005,g_mmbp4_d[l_ac].mmdj006,g_mmbp4_d[l_ac].mmdj007,g_mmbp4_d[l_ac].mmdj008, 
                                  g_mmbp4_d[l_ac].mmdj009,g_mmbp4_d[l_ac].mmdj010,g_mmbp4_d[l_ac].mmdj011,g_mmbp4_d[l_ac].mmdjacti)  
                   #自訂欄位頁簽
                WHERE mmdjent = g_enterprise AND mmdjdocno = g_mmbodocno_t AND mmdj003 = g_mmbp3_d[g_detail_idx3].mmbr003  
                    AND mmdj004 = g_mmbp3_d[g_detail_idx3].mmbr004 AND mmdj005 = g_mmbp4_d_t.mmdj005
                  
               #add-point:單身page4修改中 name="input.body4.m_update"

               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdj_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_mmbp4_d[l_ac].* = g_mmbp4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "mmdj_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_mmbp4_d[l_ac].* = g_mmbp4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_mmbo_m.mmbodocno
               LET gs_keys_bak[1] = g_mmbodocno_t
               LET gs_keys[2] = g_mmbp3_d[g_detail_idx3].mmbr003
               LET gs_keys_bak[2] = g_mmbp3_d[g_detail_idx3].mmbr003
               LET gs_keys[3] = g_mmbp3_d[g_detail_idx3].mmbr004
               LET gs_keys_bak[3] = g_mmbp3_d[g_detail_idx3].mmbr004
               LET gs_keys[4] = g_mmbp4_d[g_detail_idx4].mmdj005
               LET gs_keys_bak[4] = g_mmbp4_d_t.mmdj005
               CALL ammt350_update_b('mmdj_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmbp4_d_t)
               LET g_log2 = util.JSON.stringify(g_mmbo_m),util.JSON.stringify(g_mmbp4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
              
            END IF
 
         AFTER FIELD mmdj005
            IF g_mmbo_m.mmbodocno IS NOT NULL AND g_mmbp3_d[g_detail_idx3].mmbr003 IS NOT NULL AND g_mmbp3_d[g_detail_idx3].mmbr004 IS NOT NULL AND g_mmbp4_d[g_detail_idx4].mmdj005 IS NOT NULL THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_mmbo_m.mmbodocno != g_mmbodocno_t OR g_mmbp3_d[g_detail_idx3].mmbr003 != g_mmbp3_d[g_detail_idx3].mmbr003 OR g_mmbp3_d[g_detail_idx3].mmbr004 != g_mmbp3_d[g_detail_idx3].mmbr004 OR g_mmbp4_d[g_detail_idx4].mmdj005 != g_mmbp4_d_t.mmdj005)) THEN #160824-00008#113 by sakura mark
               IF g_mmbp4_d[l_ac].mmdj005 != g_mmbp4_d_o.mmdj005 OR cl_null(g_mmbp4_d_o.mmdj005) THEN #160824-00007#113 by sakura add
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM mmdj_t WHERE "||"mmdjent = '" ||g_enterprise|| "' AND "||"mmdj001 = '"||g_mmbo_m.mmbodocno ||"' AND "|| "mmdj003 = '"||g_mmbp3_d[g_detail_idx3].mmbr003 ||"' AND "|| "mmdj004 = '"||g_mmbp3_d[g_detail_idx3].mmbr004 ||"' AND "|| "mmdj005 = '"||g_mmbp4_d[g_detail_idx4].mmdj005 ||"'",'std-00004',0) THEN 
                     LET g_mmbp4_d[l_ac].mmdj005 = g_mmbp4_d_o.mmdj005  #160824-00007#113 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_mmbp4_d_o.* = g_mmbp4_d[l_ac].*  #160824-00007#113 by sakura add
         
         AFTER FIELD mmdj006
            IF NOT cl_null( g_mmbp4_d[l_ac].mmdj006) THEN
               IF NOT ammt350_mmdj006_mmdj007_chk() THEN
                  LET g_mmbp4_d[l_ac].mmdj006= g_mmbp4_d_t.mmdj006
                  DISPLAY BY NAME g_mmbp4_d[l_ac].mmdj006
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD mmdj007
            IF NOT cl_null( g_mmbp4_d[l_ac].mmdj007) THEN
               IF NOT ammt350_mmdj006_mmdj007_chk() THEN
                  LET g_mmbp4_d[l_ac].mmdj007= g_mmbp4_d_t.mmdj007
                  DISPLAY BY NAME g_mmbp4_d[l_ac].mmdj007
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         AFTER FIELD mmdj008
            IF NOT cl_null(g_mmbp4_d[l_ac].mmdj008) AND NOT cl_null(g_mmbp4_d[l_ac].mmdj009) THEN
               IF g_mmbp4_d[l_ac].mmdj008 > g_mmbp4_d[l_ac].mmdj009 THEN
                  #開始時間不可大於結束時間
				      INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD mmdj008
               END IF               
            END IF
            
         AFTER FIELD mmdj009
            IF NOT cl_null(g_mmbp4_d[l_ac].mmdj008) AND NOT cl_null(g_mmbp4_d[l_ac].mmdj009) THEN
               IF g_mmbp4_d[l_ac].mmdj008 > g_mmbp4_d[l_ac].mmdj009 THEN
                  #開始時間不可大於結束時間
				      INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD mmdj009
               END IF               
            END IF            
                     
            
         AFTER ROW
            #add-point:單身page4_after_row name="input.body4.after_row"

            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_mmbp4_d[l_ac].* = g_mmbp4_d_t.*
               END IF
               CLOSE ammt350_bcl4
               CLOSE ammt350_bcl3
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL ammt350_unlock_b("mmdj_t","'4'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page4_after_row2 name="input.body4.after_row2"

            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"

            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_mmbp4_d[li_reproduce_target].* = g_mmbp4_d[li_reproduce].*
 
               LET g_mmbp4_d[li_reproduce_target].mmdj005 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_mmbp4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_mmbp4_d.getLength()+1
            END IF
        
      END INPUT      
      #160613-00031#1 160615 by sakura add(E)      
      #end add-point
      
      BEFORE DIALOG 
         #add-point:input段before dialog
         
         #end add-point    
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD mmbosite #sakura add
            NEXT FIELD mmbodocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD mmbpunit
               WHEN "s_detail2"
                  NEXT FIELD mmbsunit
               WHEN "s_detail3"
                  NEXT FIELD mmbrunit
               #160613-00031#1 160615 by sakura add(S)
               WHEN "s_detail4"
                  NEXT FIELD mmdj006               
               #160613-00031#1 160615 by sakura add(E)               
 
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
         #add-point:input段accept 

         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         LET g_detail_idx3 = 1   #160613-00031#1 160615 by sakura add
         LET g_detail_idx4 = 1   #160613-00031#1 160615 by sakura add
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
    
   #add-point:input段after input 
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION ammt350_show()
   DEFINE l_ac_t    LIKE type_t.num5
   #add-point:show段define
   DEFINE l_flag    LIKE type_t.num5
   #end add-point  
 
   #add-point:show段之前
   LET g_mmbo_m_o.* = g_mmbo_m.*  
   #end add-point
   
   
   
   LET g_mmbo_m_t.* = g_mmbo_m.*      #保存單頭舊值
   
   IF g_bfill = "Y" THEN
      CALL ammt350_b_fill() #單身填充
      CALL ammt350_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #此段落由子樣板a12產生
      #LET g_mmbo_m.mmboownid_desc = cl_get_username(g_mmbo_m.mmboownid)
      #LET g_mmbo_m.mmboowndp_desc = cl_get_deptname(g_mmbo_m.mmboowndp)
      #LET g_mmbo_m.mmbocrtid_desc = cl_get_username(g_mmbo_m.mmbocrtid)
      #LET g_mmbo_m.mmbocrtdp_desc = cl_get_deptname(g_mmbo_m.mmbocrtdp)
      #LET g_mmbo_m.mmbomodid_desc = cl_get_username(g_mmbo_m.mmbomodid)
      #LET g_mmbo_m.mmbocnfid_desc = cl_get_deptname(g_mmbo_m.mmbocnfid)
      ##LET g_mmbo_m.mmbopstid_desc = cl_get_deptname(g_mmbo_m.mmbopstid)
      
 
 
   
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL ammt350_set_pk_array()
   #add-point:ON ACTION agendum

   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference
          INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbo_m.mmbodocno
   CALL ap_ref_array2(g_ref_fields," SELECT mmbol002,mmbol003 FROM mmbol_t WHERE mmbolent = '"||g_enterprise||"' AND mmboldocno = ? AND mmbol001 = '"||g_dlang||"'","") RETURNING g_rtn_fields 
   LET g_mmbo_m.mmbol002 = g_rtn_fields[1] 
   LET g_mmbo_m.mmbol003 = g_rtn_fields[2] 
   DISPLAY g_mmbo_m.mmbol002 TO mmbol002
   DISPLAY g_mmbo_m.mmbol003 TO mmbol003
   
    CALL ammt350_mmbosite_ref()

   CALL ammt350_mmbo005_ref()    

   INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmboownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmboownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmboownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmboowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmboowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmboowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmbocrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmbocrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmbocrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmbocrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooeal003 FROM ooeal_t WHERE ooealent='"||g_enterprise||"' AND ooeal001=? AND ooeal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmbocrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmbocrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmbomodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmbomodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmbomodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmbo_m.mmbocnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_mmbo_m.mmbocnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmbo_m.mmbocnfid_desc
  
 
   #end add-point
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
       g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc, 
       g_mmbo_m.mmboacti,g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp, 
       g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt, 
       g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbr004_1,g_mmbo_m.mmbr014_1, 
       g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr018_1,g_mmbo_m.mmbr004_1_desc,g_mmbo_m.mmbr015_1,g_mmbo_m.mmbr017_1, 
       g_mmbo_m.mmbr019_1,g_mmbo_m.mmbo017
   
   #顯示狀態(stus)圖片
         #此段落由子樣板a21產生
      CASE g_mmbo_m.mmbostus
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_mmbp_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
       #CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004) 
       CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_mmbp2_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
           CALL ammt350_mmbs004_ref()
       
    

      #end add-point
   END FOR
   FOR l_ac = 1 TO g_mmbp3_d.getLength()
      #帶出公用欄位reference值
      
      #add-point:show段單身reference
            CALL ammt350_mmbr004_ref(  g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
      #end add-point
      #end add-point
   END FOR
   
   #160613-00031#1 160615 by sakura add(S)
   FOR l_ac = 1 TO g_mmbp4_d.getLength()
       
   END FOR   
   #160613-00031#1 160615 by sakura add(E)   
 
   
    
   
   #add-point:show段other
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL ammt350_detail_show()
   
   #add-point:show段之後
    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.detail_show" >}
#+ 單身reference detail_show
PRIVATE FUNCTION ammt350_detail_show()
   #add-point:detail_show段define
   
   #end add-point  
 
   #add-point:detail_show段之前
   
   #end add-point
   
   #add-point:detail_show段之後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION ammt350_reproduce()
   DEFINE l_newno     LIKE mmbo_t.mmbodocno 
   DEFINE l_oldno     LIKE mmbo_t.mmbodocno 
 
   DEFINE l_master    RECORD LIKE mmbo_t.*
   DEFINE l_detail    RECORD LIKE mmbp_t.*
   DEFINE l_detail2    RECORD LIKE mmbs_t.*
 
   DEFINE l_detail3    RECORD LIKE mmbr_t.*
   DEFINE l_detail4    RECORD LIKE mmdj_t.*   #160613-00031#1 160615 by sakura add
 
 
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   DEFINE l_insert      LIKE type_t.num5    #sakura add
   DEFINE l_success     LIKE type_t.num5    #sakura add
   DEFINE l_doctype     LIKE rtai_t.rtai004 #sakura add 
   RETURN   
   #end add-point   
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
    
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
    
   LET g_mmbo_m.mmbodocno = ""
 
    
   CALL ammt350_set_entry('a')
   CALL ammt350_set_no_entry('a')
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #此段落由子樣板a14產生    
      LET g_mmbo_m.mmboownid = g_user
      LET g_mmbo_m.mmboowndp = g_dept
      LET g_mmbo_m.mmbocrtid = g_user
      LET g_mmbo_m.mmbocrtdp = g_dept 
      LET g_mmbo_m.mmbocrtdt = cl_get_current()
      #160613-00031#1 160615 by sakura mark(S)
      #LET g_mmbo_m.mmbomodid = ""
      #LET g_mmbo_m.mmbomoddt = ""
      ##LET g_mmbo_m.mmbostus = ""
      #160613-00031#1 160615 by sakura mark(E)
      #160613-00031#1 160615 by sakura add(S)
      LET g_mmbo_m.mmbomodid = g_user
      LET g_mmbo_m.mmbomoddt = cl_get_current()      
      LET g_mmbo_m.mmbostus = 'N'
      #160613-00031#1 160615 by sakura add(E)
 
 
   
   #add-point:複製輸入前
   #sakura---add---str
   CALL s_aooi500_default(g_prog,'mmbosite',g_mmbo_m.mmbosite)
      RETURNING l_insert,g_mmbo_m.mmbosite
   IF l_insert = FALSE THEN
      RETURN
   END IF
   CALL ammt350_mmbosite_ref()
   #預設單據的單別 
   LET l_success = ''
   LET l_doctype = ''
   CALL s_arti200_get_def_doc_type(g_mmbo_m.mmbosite,g_prog,'1') RETURNING l_success, l_doctype
   LET g_mmbo_m.mmbodocno = l_doctype   
   #sakura---add---end    
   #end add-point
   
   CALL ammt350_input("r")
   
   
   #160613-00031#1 160615 by sakura add(S)
   IF INT_FLAG AND NOT g_master_insert THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_mmbo_m.* TO NULL
      INITIALIZE g_mmbp_d TO NULL
      INITIALIZE g_mmbp2_d TO NULL
      INITIALIZE g_mmbp3_d TO NULL
      INITIALIZE g_mmbp4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
 
      #end add-point
      CALL ammt350_show()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   
   #將新增的資料併入搜尋條件中
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL ammt350_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL ammt350_idx_chk()   
   #160613-00031#1 160615 by sakura add(E)
   #160613-00031#1 160615 by sakura add(S)
   #IF INT_FLAG THEN
   #   LET INT_FLAG = 0
   #   RETURN
   #END IF
   #
   #LET g_state = "Y"
   #
   #LET g_wc = g_wc,  
   #           " OR (",
   #           " mmbodocno = '", g_mmbo_m.mmbodocno CLIPPED, "' "
   #
   #           , ") "
   #
   #160613-00031#1 160615 by sakura mark(E)
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION ammt350_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE mmbp_t.*
   DEFINE l_detail2    RECORD LIKE mmbs_t.*
 
   DEFINE l_detail3    RECORD LIKE mmbr_t.*
   DEFINE l_detail4    RECORD LIKE mmdj_t.*   #160613-00031#1 160615 by sakura add
 
 
 
   #add-point:delete段define
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE ammt350_detail
   
   #add-point:單身複製前1
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE ammt350_detail AS ",
                "SELECT * FROM mmbp_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO ammt350_detail SELECT * FROM mmbp_t 
                                         WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbodocno_t
 
   
   #將key修正為調整後   
   UPDATE ammt350_detail 
      #更新key欄位
      SET mmbpdocno = g_mmbo_m.mmbodocno
 
      #更新共用欄位
      
                                       
  
   #將資料塞回原table   
   INSERT INTO mmbp_t SELECT * FROM ammt350_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt350_detail
   
   #add-point:單身複製後1
   
   #end add-point
 
   #add-point:單身複製前
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE ammt350_detail AS ",
      "SELECT * FROM mmbs_t "
   PREPARE repro_tbl2 FROM ls_sql
   EXECUTE repro_tbl2
   FREE repro_tbl2
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO ammt350_detail SELECT * FROM mmbs_t
                                         WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbodocno_t
 
 
   #將key修正為調整後   
   UPDATE ammt350_detail SET mmbsdocno = g_mmbo_m.mmbodocno
 
  
   #將資料塞回原table   
   INSERT INTO mmbs_t SELECT * FROM ammt350_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt350_detail
   
   #add-point:單身複製後
   
   #end add-point
 
   #add-point:單身複製前
   
   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE ammt350_detail AS ",
      "SELECT * FROM mmbr_t "
   PREPARE repro_tbl3 FROM ls_sql
   EXECUTE repro_tbl3
   FREE repro_tbl3
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO ammt350_detail SELECT * FROM mmbr_t
                                         WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbodocno_t
 
 
   #將key修正為調整後   
   UPDATE ammt350_detail SET mmbrdocno = g_mmbo_m.mmbodocno
 
  
   #將資料塞回原table   
   INSERT INTO mmbr_t SELECT * FROM ammt350_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt350_detail
   
   #add-point:單身複製後
   #160613-00031#1 160615 by sakura add(S)
   LET ls_sql = 
      "CREATE GLOBAL TEMPORARY TABLE ammt350_detail AS ",
      "SELECT * FROM mmdj_t "
   PREPARE repro_tbl4 FROM ls_sql
   EXECUTE repro_tbl4
   FREE repro_tbl4
      
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO ammt350_detail SELECT * FROM mmdj_t
                                         WHERE mmdjent = g_enterprise AND mmdjdocno = g_mmbodocno_t
 
 
   #將key修正為調整後   
   UPDATE ammt350_detail SET mmdjdocno = g_mmbo_m.mmbodocno
 
  
   #將資料塞回原table   
   INSERT INTO mmdj_t SELECT * FROM ammt350_detail
   
   #add-point:單身複製中
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE ammt350_detail   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
   
   DROP TABLE ammt350_detail
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.delete" >}
#+ 資料刪除
PRIVATE FUNCTION ammt350_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE ammt350_master_referesh USING g_mmbo_m.mmbodocno INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno, 
       g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006,g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo005, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmboacti, 
       g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboowndp,g_mmbo_m.mmbocrtid, 
       g_mmbo_m.mmbocrtdp,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomoddt,g_mmbo_m.mmbocnfid, 
       g_mmbo_m.mmbocnfdt
   
   LET g_master_multi_table_t.mmboldocno = g_mmbo_m.mmbodocno
LET g_master_multi_table_t.mmbol002 = g_mmbo_m.mmbol002
LET g_master_multi_table_t.mmbol003 = g_mmbo_m.mmbol003
 
 
   CALL ammt350_show()
   
   CALL s_transaction_begin()
 
   OPEN ammt350_cl USING g_enterprise,g_mmbo_m.mmbodocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN ammt350_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      CLOSE ammt350_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   FETCH ammt350_cl INTO g_mmbo_m.mmbo000,g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt,g_mmbo_m.mmbo004,g_mmbo_m.mmbo006, 
       g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo005,g_mmbo_m.mmbo005_desc, 
       g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017,g_mmbo_m.mmbosite,g_mmbo_m.mmbosite_desc, 
       g_mmbo_m.mmboacti,g_mmbo_m.mmbounit,g_mmbo_m.mmbostus,g_mmbo_m.mmboownid,g_mmbo_m.mmboownid_desc, 
       g_mmbo_m.mmboowndp,g_mmbo_m.mmboowndp_desc,g_mmbo_m.mmbocrtid,g_mmbo_m.mmbocrtid_desc,g_mmbo_m.mmbocrtdp, 
       g_mmbo_m.mmbocrtdp_desc,g_mmbo_m.mmbocrtdt,g_mmbo_m.mmbomodid,g_mmbo_m.mmbomodid_desc,g_mmbo_m.mmbomoddt, 
       g_mmbo_m.mmbocnfid,g_mmbo_m.mmbocnfid_desc,g_mmbo_m.mmbocnfdt,g_mmbo_m.mmbr004_1,g_mmbo_m.mmbr014_1, 
       g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr018_1,g_mmbo_m.mmbr004_1_desc,g_mmbo_m.mmbr015_1,g_mmbo_m.mmbr017_1, 
       g_mmbo_m.mmbr019_1              #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_mmbo_m.mmbodocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
          #資料被他人LOCK
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:delete段before ask
   #160818-00017#21 by 08742 --S
   #檢查是否允許此動作
   IF NOT ammt350_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#21 by 08742 --E
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前
      
      #end add-point   
      
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL ammt350_set_pk_array()
      #add-point:相關文件刪除前

      #end add-point   
      CALL cl_doc_remove()  
 
  
  
      #資料備份
      LET g_mmbodocno_t = g_mmbo_m.mmbodocno
 
 
      DELETE FROM mmbo_t
       WHERE mmboent = g_enterprise AND mmbodocno = g_mmbo_m.mmbodocno
 
       
      #add-point:單頭刪除中
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = g_mmbo_m.mmbodocno
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      #add-point:單頭刪除後
      #sakura---add---str
      IF NOT s_aooi200_del_docno(g_mmbo_m.mmbodocno,g_mmbo_m.mmbodocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF 
      DELETE FROM mmdi_t WHERE mmdient=g_enterprise AND mmdidocno = g_mmbo_m.mmbodocno     #160530-00033#7       
      #sakura---add---end      
      #end add-point
  
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM mmbp_t
       WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno
 
 
      #add-point:單身刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF    
 
      #add-point:單身刪除後
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM mmbs_t
       WHERE mmbsent = g_enterprise AND
             mmbsdocno = g_mmbo_m.mmbodocno
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
      
      #end add-point
 
      #add-point:單身刪除前
      
      #end add-point
      DELETE FROM mmbr_t
       WHERE mmbrent = g_enterprise AND
             mmbrdocno = g_mmbo_m.mmbodocno
      #add-point:單身刪除中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
 
      #add-point:單身刪除後
 
      #end add-point
      
      #160613-00031#1 160615 by sakura add(S)
      DELETE FROM mmdj_t
       WHERE mmdjent = g_enterprise AND
             mmdjdocno = g_mmbo_m.mmbodocno
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "mmdj_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #160613-00031#1 160615 by sakura add(E)
 
 
 
 
                                                               
      CLEAR FORM
      CALL g_mmbp_d.clear() 
      CALL g_mmbp2_d.clear()       
      CALL g_mmbp3_d.clear()
      CALL g_mmbp4_d.clear()   #160613-00031#1 160615 by sakura add
 
     
      CALL ammt350_ui_browser_refresh()  
      CALL ammt350_ui_headershow()  
      CALL ammt350_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL ammt350_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
      ELSE
         LET g_wc = " 1=1"
         CALL ammt350_browser_fill("F")
      END IF
      
      #單頭多語言刪除
      INITIALIZE l_var_keys_bak TO NULL 
   INITIALIZE l_field_keys   TO NULL 
   LET l_var_keys_bak[01] = g_master_multi_table_t.mmboldocno
   LET l_field_keys[01] = 'mmboldocno'
   LET l_var_keys_bak[02] = g_dlang
   LET l_field_keys[02] = 'mmbol001'
   CALL cl_multitable_delete(l_field_keys,l_var_keys_bak,'mmbol_t')
 
      
      #單身多語言刪除
      
      
 
      
 
 
 
   
   END IF
 
   CALL s_transaction_end('Y','0')
   
   CLOSE ammt350_cl
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_mmbo_m.mmbodocno,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="ammt350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammt350_b_fill()
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   DEFINE l_flag    LIKE type_t.num5
   #end add-point     
 
   CALL g_mmbp_d.clear()    #g_mmbp_d 單頭及單身 
   CALL g_mmbp2_d.clear()
   CALL g_mmbp3_d.clear()
 
 
   #add-point:b_fill段sql_before
   
   #end add-point
   
   #判斷是否填充
   IF ammt350_fill_chk(1) THEN
   
      LET g_sql = "SELECT  UNIQUE mmbpunit,mmbpsite,mmbp001,mmbp002,mmbp003,mmbp004,'',mmbp005,mmbp006, 
          mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti FROM mmbp_t",   
                  " INNER JOIN mmbo_t ON mmbodocno = mmbpdocno ",
 
                  #"",
                  
                  "",
                  " WHERE mmbpent=? AND mmbpdocno=?"
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table1) THEN
         LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY mmbp_t.mmbp003,mmbp_t.mmbp004"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE ammt350_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR ammt350_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_mmbo_m.mmbodocno
 
                                               
      FOREACH b_fill_cs INTO g_mmbp_d[l_ac].mmbpunit,g_mmbp_d[l_ac].mmbpsite,g_mmbp_d[l_ac].mmbp001, 
          g_mmbp_d[l_ac].mmbp002,g_mmbp_d[l_ac].mmbp003,g_mmbp_d[l_ac].mmbp004,g_mmbp_d[l_ac].mmbp004_desc, 
          g_mmbp_d[l_ac].mmbp005,g_mmbp_d[l_ac].mmbp006,g_mmbp_d[l_ac].mmbp007,g_mmbp_d[l_ac].mmbp008, 
          g_mmbp_d[l_ac].mmbp009,g_mmbp_d[l_ac].mmbp010,g_mmbp_d[l_ac].mmbpacti
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         #CALL ammt350_mmbp004_ref(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004)
         CALL s_aint800_01_show(g_mmbo_m.mmbo007,g_mmbp_d[l_ac].mmbp004,'',g_mmbo_m.mmbosite,'')  RETURNING l_flag,g_mmbp_d[l_ac].mmbp004_desc         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  9035
               LET g_errparam.extend =  ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
 
            END IF
            EXIT FOREACH
         END IF
         
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #判斷是否填充
   IF ammt350_fill_chk(2) THEN
      LET g_sql = "SELECT  UNIQUE mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs004,'',mmbs005,mmbsacti FROM mmbs_t", 
             
                  " INNER JOIN mmbo_t ON mmbodocno = mmbsdocno ",
 
                  "",
                  
                  " WHERE mmbsent=? AND mmbsdocno=?"   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      #子單身的WC
      
      
      LET g_sql = g_sql, " ORDER BY mmbs_t.mmbs004"
      
      #add-point:單身填充控制
      
      #end add-point
      
      PREPARE ammt350_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR ammt350_pb2
      
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_mmbo_m.mmbodocno
 
                                               
      FOREACH b_fill_cs2 INTO g_mmbp2_d[l_ac].mmbsunit,g_mmbp2_d[l_ac].mmbssite,g_mmbp2_d[l_ac].mmbs001, 
          g_mmbp2_d[l_ac].mmbs002,g_mmbp2_d[l_ac].mmbs003,g_mmbp2_d[l_ac].mmbs004,g_mmbp2_d[l_ac].mmbs004_desc, 
          g_mmbp2_d[l_ac].mmbs005,g_mmbp2_d[l_ac].mmbsacti
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
         CALL ammt350_mmbs004_ref()
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
   #判斷是否填充
   IF ammt350_fill_chk(3) THEN
      LET g_sql = "SELECT  UNIQUE mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr003,mmbr004,'',mmbr005,mmbr006, 
          mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018, 
          mmbr019,mmbracti FROM mmbr_t",   
                  " INNER JOIN mmbo_t ON mmbodocno = mmbrdocno ",
 
                  "",
                  " LEFT JOIN mmdj_t ON mmbrent = mmdjent AND mmbrdocno = mmdjdocno AND mmbr003 = mmdj003 AND mmbr004 = mmdj004 ",
                  
                  " WHERE mmbrent=? AND mmbrdocno=?"   
      #add-point:b_fill段sql_before
      
      #end add-point
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      
      #子單身的WC
      #160613-00031#1 160615 by sakura add(S)
      IF NOT cl_null(g_wc2_table4) THEN 
         LET g_sql = g_sql CLIPPED," AND ", g_wc2_table4 CLIPPED
      END IF      
      #160613-00031#1 160615 by sakura add(E)
      
      LET g_sql = g_sql, " ORDER BY mmbr_t.mmbr003,mmbr_t.mmbr004"
      
      #add-point:單身填充控制
         
      #end add-point
      
      PREPARE ammt350_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR ammt350_pb3
      
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_mmbo_m.mmbodocno
 
                                               
      FOREACH b_fill_cs3 INTO g_mmbp3_d[l_ac].mmbrunit,g_mmbp3_d[l_ac].mmbrsite,g_mmbp3_d[l_ac].mmbr001, 
          g_mmbp3_d[l_ac].mmbr002,g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004,g_mmbp3_d[l_ac].mmbr004_desc, 
          g_mmbp3_d[l_ac].mmbr005,g_mmbp3_d[l_ac].mmbr006,g_mmbp3_d[l_ac].mmbr007,g_mmbp3_d[l_ac].mmbr008, 
          g_mmbp3_d[l_ac].mmbr009,g_mmbp3_d[l_ac].mmbr010,g_mmbp3_d[l_ac].mmbr011,g_mmbp3_d[l_ac].mmbr012, 
          g_mmbp3_d[l_ac].mmbr013,g_mmbp3_d[l_ac].mmbr014,g_mmbp3_d[l_ac].mmbr015,g_mmbp3_d[l_ac].mmbr016, 
          g_mmbp3_d[l_ac].mmbr017,g_mmbp3_d[l_ac].mmbr018,g_mmbp3_d[l_ac].mmbr019,g_mmbp3_d[l_ac].mmbracti 
 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充
                   CALL ammt350_mmbr004_ref(  g_mmbp3_d[l_ac].mmbr003,g_mmbp3_d[l_ac].mmbr004)
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理
   
   #end add-point
   
   CALL g_mmbp_d.deleteElement(g_mmbp_d.getLength())
   CALL g_mmbp2_d.deleteElement(g_mmbp2_d.getLength())
   CALL g_mmbp3_d.deleteElement(g_mmbp3_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE ammt350_pb
   FREE ammt350_pb2
 
   FREE ammt350_pb3
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION ammt350_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM mmbp_t
       WHERE mmbpent = g_enterprise AND
         mmbpdocno = ps_keys_bak[1] AND mmbp003 = ps_keys_bak[2] AND mmbp004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ""
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point   
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM mmbs_t
       WHERE mmbsent = g_enterprise AND
         mmbsdocno = ps_keys_bak[1] AND mmbs004 = ps_keys_bak[2]
      #add-point:delete_b段刪除中
      #160613-00031#1 160615 by sakura add(S)
      
      #160613-00031#1 160615 by sakura add(E)      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM mmbr_t
       WHERE mmbrent = g_enterprise AND
         mmbrdocno = ps_keys_bak[1] AND mmbr003 = ps_keys_bak[2] AND mmbr004 = ps_keys_bak[3]
      #add-point:delete_b段刪除中
 
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:delete_b段刪除後
      #160613-00031#1 160615 by sakura add(S)
      DELETE FROM mmdj_t
       WHERE mmdjent = g_enterprise AND
             mmdjdocno = ps_keys_bak[1] AND mmdj003 = ps_keys_bak[2] AND mmdj004 = ps_keys_bak[3]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmdj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF      
      #160613-00031#1 160615 by sakura add(E)      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other
   #160613-00031#1 160615 by sakura add(S)
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前
      
      #end add-point    
      DELETE FROM mmdj_t
       WHERE mmdjent = g_enterprise AND
             mmdjdocno = ps_keys_bak[1] AND mmdj003 = ps_keys_bak[2] AND mmdj004 = ps_keys_bak[3] AND mmdj005 = ps_keys_bak[4]
      #add-point:delete_b段刪除中
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmdj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:delete_b段刪除後
      
      #end add-point    
   END IF   
   #160613-00031#1 160615 by sakura add(E)
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION ammt350_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO mmbp_t
                  (mmbpent,
                   mmbpdocno,
                   mmbp003,mmbp004
                   ,mmbpunit,mmbpsite,mmbp001,mmbp002,mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmbp_d[g_detail_idx].mmbpunit,g_mmbp_d[g_detail_idx].mmbpsite,g_mmbp_d[g_detail_idx].mmbp001, 
                       g_mmbp_d[g_detail_idx].mmbp002,g_mmbp_d[g_detail_idx].mmbp005,g_mmbp_d[g_detail_idx].mmbp006, 
                       g_mmbp_d[g_detail_idx].mmbp007,g_mmbp_d[g_detail_idx].mmbp008,g_mmbp_d[g_detail_idx].mmbp009,
                       g_mmbp_d[g_detail_idx].mmbp010,g_mmbp_d[g_detail_idx].mmbpacti) 
 
      #add-point:insert_b段資料新增中
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbp_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO mmbs_t
                  (mmbsent,
                   mmbsdocno,
                   mmbs004
                   ,mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs005,mmbsacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_mmbp2_d[g_detail_idx].mmbsunit,g_mmbp2_d[g_detail_idx].mmbssite,g_mmbp2_d[g_detail_idx].mmbs001, 
                       g_mmbp2_d[g_detail_idx].mmbs002,g_mmbp2_d[g_detail_idx].mmbs003,g_mmbp2_d[g_detail_idx].mmbs005, 
                       g_mmbp2_d[g_detail_idx].mmbsacti)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbs_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point
      #160613-00031#1 160615 by sakura modify g_detail_idx-->g_detail_idx3(S)
      INSERT INTO mmbr_t
                  (mmbrent,
                   mmbrdocno,
                   mmbr003,mmbr004
                   ,mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr005,mmbr006,mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019,mmbracti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_mmbp3_d[g_detail_idx3].mmbrunit,g_mmbp3_d[g_detail_idx3].mmbrsite,g_mmbp3_d[g_detail_idx3].mmbr001, 
                       g_mmbp3_d[g_detail_idx3].mmbr002,g_mmbp3_d[g_detail_idx3].mmbr005,g_mmbp3_d[g_detail_idx3].mmbr006, 
                       g_mmbp3_d[g_detail_idx3].mmbr007,g_mmbp3_d[g_detail_idx3].mmbr008,g_mmbp3_d[g_detail_idx3].mmbr009, 
                       g_mmbp3_d[g_detail_idx3].mmbr010,g_mmbp3_d[g_detail_idx3].mmbr011,g_mmbp3_d[g_detail_idx3].mmbr012, 
                       g_mmbp3_d[g_detail_idx3].mmbr013,g_mmbp3_d[g_detail_idx3].mmbr014,g_mmbp3_d[g_detail_idx3].mmbr015, 
                       g_mmbp3_d[g_detail_idx3].mmbr016,g_mmbp3_d[g_detail_idx3].mmbr017,g_mmbp3_d[g_detail_idx3].mmbr018, 
                       g_mmbp3_d[g_detail_idx3].mmbr019,g_mmbp3_d[g_detail_idx3].mmbracti)
      #160613-00031#1 160615 by sakura modify g_detail_idx-->g_detail_idx3(E)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmbr_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other
   #160613-00031#1 160615 by sakura add(S)
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前
      
      #end add-point 
      INSERT INTO mmdj_t
                  (mmdjent,
                   mmdjdocno,mmdj003,mmdj004,mmdj005,
				       mmdjsite,mmdjunit,
                   mmdj001,mmdj002,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],
                   g_mmbo_m.mmbosite,g_mmbo_m.mmbounit,
				       g_mmbo_m.mmbo001,g_mmbo_m.mmbo005,g_mmbp4_d[g_detail_idx4].mmdj006, 
                   g_mmbp4_d[g_detail_idx4].mmdj007,g_mmbp4_d[g_detail_idx4].mmdj008,g_mmbp4_d[g_detail_idx4].mmdj009, 
                   g_mmbp4_d[g_detail_idx4].mmdj010,g_mmbp4_d[g_detail_idx4].mmdj011,g_mmbp4_d[g_detail_idx4].mmdjacti)
      #add-point:insert_b段資料新增中
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "mmdj_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()

      END IF
      #add-point:insert_b段資料新增後
      
      #end add-point
   END IF   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION ammt350_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
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
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbp_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE mmbp_t 
         SET (mmbpdocno,
              mmbp003,mmbp004
              ,mmbpunit,mmbpsite,mmbp001,mmbp002,mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmbp_d[g_detail_idx].mmbpunit,g_mmbp_d[g_detail_idx].mmbpsite,g_mmbp_d[g_detail_idx].mmbp001, 
                  g_mmbp_d[g_detail_idx].mmbp002,g_mmbp_d[g_detail_idx].mmbp005,g_mmbp_d[g_detail_idx].mmbp006, 
                  g_mmbp_d[g_detail_idx].mmbp007,g_mmbp_d[g_detail_idx].mmbp008,g_mmbp_d[g_detail_idx].mmbp009,
                  g_mmbp_d[g_detail_idx].mmbp010,g_mmbp_d[g_detail_idx].mmbpacti)  
 
         WHERE mmbpent = g_enterprise AND mmbpdocno = ps_keys_bak[1] AND mmbp003 = ps_keys_bak[2] AND mmbp004 = ps_keys_bak[3]
      #add-point:update_b段修改中
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "mmbp_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmbp_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbs_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE mmbs_t 
         SET (mmbsdocno,
              mmbs004
              ,mmbsunit,mmbssite,mmbs001,mmbs002,mmbs003,mmbs005,mmbsacti) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_mmbp2_d[g_detail_idx].mmbsunit,g_mmbp2_d[g_detail_idx].mmbssite,g_mmbp2_d[g_detail_idx].mmbs001, 
                  g_mmbp2_d[g_detail_idx].mmbs002,g_mmbp2_d[g_detail_idx].mmbs003,g_mmbp2_d[g_detail_idx].mmbs005, 
                  g_mmbp2_d[g_detail_idx].mmbsacti) 
         WHERE mmbsent = g_enterprise AND mmbsdocno = ps_keys_bak[1] AND mmbs004 = ps_keys_bak[2]
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "mmbs_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmbs_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmbr_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      #160613-00031#1 160615 by sakura modify g_detail_idx-->g_detail_idx3(S)
      UPDATE mmbr_t 
         SET (mmbrdocno,
              mmbr003,mmbr004
              ,mmbrunit,mmbrsite,mmbr001,mmbr002,mmbr005,mmbr006,mmbr007,mmbr008,mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019,mmbracti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_mmbp3_d[g_detail_idx3].mmbrunit,g_mmbp3_d[g_detail_idx3].mmbrsite,g_mmbp3_d[g_detail_idx3].mmbr001, 
                  g_mmbp3_d[g_detail_idx3].mmbr002,g_mmbp3_d[g_detail_idx3].mmbr005,g_mmbp3_d[g_detail_idx3].mmbr006, 
                  g_mmbp3_d[g_detail_idx3].mmbr007,g_mmbp3_d[g_detail_idx3].mmbr008,g_mmbp3_d[g_detail_idx3].mmbr009, 
                  g_mmbp3_d[g_detail_idx3].mmbr010,g_mmbp3_d[g_detail_idx3].mmbr011,g_mmbp3_d[g_detail_idx3].mmbr012, 
                  g_mmbp3_d[g_detail_idx3].mmbr013,g_mmbp3_d[g_detail_idx3].mmbr014,g_mmbp3_d[g_detail_idx3].mmbr015, 
                  g_mmbp3_d[g_detail_idx3].mmbr016,g_mmbp3_d[g_detail_idx3].mmbr017,g_mmbp3_d[g_detail_idx3].mmbr018, 
                  g_mmbp3_d[g_detail_idx3].mmbr019,g_mmbp3_d[g_detail_idx3].mmbracti) 
         WHERE mmbrent = g_enterprise AND mmbrdocno = ps_keys_bak[1] AND mmbr003 = ps_keys_bak[2] AND mmbr004 = ps_keys_bak[3]
      #160613-00031#1 160615 by sakura modify g_detail_idx-->g_detail_idx3(E)
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "mmbr_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmbr_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF
 
 
   
 
   
 
   
   #add-point:update_b段other
   #160613-00031#1 160615 by sakura add(S)
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "mmdj_t" THEN
      #add-point:update_b段修改前
      
      #end add-point     
      UPDATE mmdj_t 
         SET (mmdjdocno,mmdj003,mmdj004,mmdj005
              ,mmdjunit,mmdjsite,mmdj001,mmdj002,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_mmbo_m.mmbounit,g_mmbo_m.mmbosite,g_mmbo_m.mmbo001, 
                  g_mmbo_m.mmbo005,g_mmbp4_d[g_detail_idx4].mmdj006, 
                  g_mmbp4_d[g_detail_idx4].mmdj007,g_mmbp4_d[g_detail_idx4].mmdj008,g_mmbp4_d[g_detail_idx4].mmdj009, 
                  g_mmbp4_d[g_detail_idx4].mmdj010,g_mmbp4_d[g_detail_idx4].mmdj011,g_mmbp4_d[g_detail_idx4].mmdjacti) 
         WHERE mmdjent = g_enterprise AND mmdjdocno = ps_keys_bak[1] AND mmdj003 = ps_keys_bak[2] AND mmdj004 = ps_keys_bak[3] AND mmdj005 = ps_keys_bak[4]
      #add-point:update_b段修改中
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "std-00009"
            LET g_errparam.extend = "mmdj_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            CALL s_transaction_end('N','0')
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "mmdj_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')
         OTHERWISE
            
      END CASE
      #add-point:update_b段修改後
      
      #end add-point  
   END IF   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION ammt350_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL ammt350_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "mmbp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN ammt350_bcl USING g_enterprise,
                                       g_mmbo_m.mmbodocno,g_mmbp_d[g_detail_idx].mmbp003,g_mmbp_d[g_detail_idx].mmbp004  
                                               
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammt350_bcl"
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
   
      OPEN ammt350_bcl2 USING g_enterprise,
                                             g_mmbo_m.mmbodocno,g_mmbp2_d[g_detail_idx].mmbs004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammt350_bcl2"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "mmbr_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt350_bcl3 USING g_enterprise,
                              g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx3].mmbr003,g_mmbp3_d[g_detail_idx3].mmbr004   #160613-00031#1 160615 by sakura add
                              #g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx].mmbr003,g_mmbp3_d[g_detail_idx].mmbr004    #160613-00031#1 160615 by sakura mark
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammt350_bcl3"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other
   #160613-00031#1 160615 by sakura add(S)
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "mmdj_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN ammt350_bcl4 USING g_enterprise,
           g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx3].mmbr003,g_mmbp3_d[g_detail_idx3].mmbr004,g_mmbp4_d[g_detail_idx4].mmdj005

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ammt350_bcl4"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   END IF   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION ammt350_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt350_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt350_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt350_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other
   #160613-00031#1 160615 by sakura add(S)
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE ammt350_bcl4
   END IF   
   #160613-00031#1 160615 by sakura add(E)   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION ammt350_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("mmbodocno",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_entry("mmbounit",TRUE)
      CALL cl_set_comp_entry("mmbo000",TRUE)
      CALL cl_set_comp_entry("mmbodocdt",TRUE)
      CALL cl_set_comp_entry("mmbo001",TRUE)
      CALL cl_set_comp_entry("mmbosite",TRUE) #sakura add
      CALL cl_set_comp_entry("mmbo017",TRUE) 
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後
    CALL cl_set_comp_entry("mmboacti",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION ammt350_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("mmbodocno",FALSE)
      #add-point:set_no_entry段欄位控制
            IF NOT ammt350_detail_count() THEN
         CALL cl_set_comp_entry("mmbo000",FALSE)
         CALL cl_set_comp_entry("mmbounit",FALSE)
         CALL cl_set_comp_entry("mmbo001",FALSE)
      END IF
      IF NOT cl_null(g_mmbo_m.mmbodocno) THEN
         CALL cl_set_comp_entry("mmbodocdt",FALSE)
      END IF
      CALL cl_set_comp_entry("mmbo017",FALSE) 
      #end add-point 
   END IF 
   
   #add-point:set_no_entry段欄位控制後
   IF cl_null(g_mmbo_m.mmbo000) OR g_mmbo_m.mmbo000 = 'I' THEN
      CALL cl_set_comp_entry("mmboacti",FALSE)
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
 
{<section id="ammt350.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION ammt350_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
    
   #end add-point     
   #add-point:set_entry_b段
    
   IF g_mmbo_m.mmbo007 <> '0' THEN
      CALL cl_set_comp_entry('mmbp004',TRUE)
   END IF
   IF g_mmbo_m.mmbo007 <> '3' THEN
      CALL cl_set_comp_entry('mmbp005',TRUE)
   END IF
   IF g_current_page = 3 THEN      
      CALL cl_set_comp_entry('mmbr006',TRUE)
      CALL cl_set_comp_entry('mmbr007',TRUE)
      CALL cl_set_comp_entry('mmbr008',TRUE)
      CALL cl_set_comp_entry('mmbr009',TRUE)
      CALL cl_set_comp_entry('mmbr011',TRUE)
      CALL cl_set_comp_entry('mmbr012',TRUE)
      CALL cl_set_comp_entry('mmbr013',TRUE)
      #CALL cl_set_comp_required('mmbr016,mmbr017',TRUE)   #160613-00031#1 160615 by sakura mark
      IF g_mmbp3_d[l_ac].mmbr005 = 'Y' THEN
         CALL cl_set_comp_required('mmbr006',TRUE)
      END IF 
   END IF
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="ammt350.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION ammt350_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   #add-point:set_no_entry_b段
   IF g_current_page = 1 THEN
      IF g_mmbo_m.mmbo007 = '0' THEN
        CALL cl_set_comp_entry('mmbp004',FALSE)
      END IF
      #150324-00007#4 Modify-S By Ken 150427
      #IF g_mmbo_m.mmbo007 = '3' THEN
      #   CALL cl_set_comp_entry('mmbp005',FALSE)
      #END IF
      CASE g_mmbo_m.mmbo007
         WHEN '3'
            CALL cl_set_comp_entry('mmbp005',FALSE)
         WHEN 'Z'
            CALL cl_set_comp_entry('mmbp005',FALSE)
      END CASE      
      #150324-00007#4 Modify-S
   END IF
    IF g_current_page = 3 THEN
      IF cl_null(g_mmbp3_d[l_ac].mmbr005) OR g_mmbp3_d[l_ac].mmbr005 = 'N' THEN
         CALL cl_set_comp_required('mmbr006',FALSE)
         CALL cl_set_comp_entry('mmbr006',FALSE)
      END IF
      IF g_mmbp3_d[l_ac].mmbr003 <> 'Q' THEN
         CALL cl_set_comp_entry('mmbr007,mmbr008,mmbr009',FALSE)
         LET g_mmbp3_d[l_ac].mmbr007 = ''
         LET g_mmbp3_d[l_ac].mmbr008 = ''
         LET g_mmbp3_d[l_ac].mmbr009 = ''         
      END IF
      
      CASE g_mmbp3_d[l_ac].mmbr007
         WHEN '1'
            CALL cl_set_comp_entry('mmbr008,mmbr009',FALSE)
         WHEN '2'
            CALL cl_set_comp_entry('mmbr008,mmbr009',FALSE)
         WHEN '3'
         OTHERWISE
            CALL cl_set_comp_entry('mmbr008,mmbr009',FALSE)
      END CASE
      CASE g_mmbp3_d[l_ac].mmbr010
         WHEN '1'
            CALL cl_set_comp_entry('mmbr012,mmbr013',FALSE)
         WHEN '2'
            CALL cl_set_comp_entry('mmbr011,mmbr012',FALSE)
         WHEN '3'
            CALL cl_set_comp_entry('mmbr011',FALSE)
         OTHERWISE
            CALL cl_set_comp_entry('mmbr011,mmbr012,mmbr013',FALSE)
      END CASE
      #160613-00031#1 160615 by sakura add(S)
      #IF cl_null(g_mmbp3_d[l_ac].mmbr016) THEN
      #   CALL cl_set_comp_required('mmbr017',FALSE)
      #END IF
      #IF cl_null(g_mmbp3_d[l_ac].mmbr017) THEN
      #   CALL cl_set_comp_required('mmbr016',FALSE)
      #END IF
      #160613-00031#1 160615 by sakura add(E)
   END IF  
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="ammt350.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION ammt350_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = ls_wc, " mmbodocno = '", g_argv[1], "' AND "
   END IF
   
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
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
 
{<section id="ammt350.state_change" >}
   #+ 此段落由子樣板a09產生
#+ 確認碼變更
PRIVATE FUNCTION ammt350_statechange()
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define
      DEFINE l_success   LIKE type_t.num5
   DEFINE l_errno     LIKE type_t.chr10
   #end add-point  
   
   #add-point:statechange段開始前
   #160818-00017#21 by 08742 --S
   #檢查是否允許此動作
   IF NOT ammt350_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #160818-00017#21 by 08742 --E
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_mmbo_m.mmbodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
      RETURN
   END IF
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_mmbo_m.mmbostus
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "X"
               HIDE OPTION "invalid"
            WHEN "Y"
               HIDE OPTION "confirmed"
            
         END CASE
     
      #add-point:menu前
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      
      CASE g_mmbo_m.mmbostus
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
            HIDE OPTION "open"
            HIDE OPTION "confirmed"
            RETURN
            
         WHEN "Y"
            HIDE OPTION "open"
            HIDE OPTION "invalid"
            RETURN
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
      
      END CASE
      #end add-point
      
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN   #151027-00016#2 20160115 add by beckxie
            LET lc_state = "N"
            #add-point:action控制

            #end add-point
         END IF   #151027-00016#2 20160115 add by beckxie
         EXIT MENU
      #160613-00031#1 160615 by sakura mark(S)
      #ON ACTION invalid
      #   IF cl_auth_chk_act("invalid") THEN   #151027-00016#2 20160115 add by beckxie
      #      LET lc_state = "X"
      #      #add-point:action控制
         
      #      #end add-point
      #   END IF   #151027-00016#2 20160115 add by beckxie
      #   EXIT MENU
      #160613-00031#1 160615 by sakura mark(E)
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN   #151027-00016#2 20160115 add by beckxie
            LET lc_state = "Y"
            #add-point:action控制
         
            #end add-point
         END IF   #151027-00016#2 20160115 add by beckxie
         EXIT MENU
      #160613-00031#1 160615 by sakura add(S)
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN   #151027-00016#2 20160115 add by beckxie
            LET lc_state = "X"
            #add-point:action控制
         
            #end add-point
         END IF   #151027-00016#2 20160115 add by beckxie
         EXIT MENU
     #160613-00031#1 160615 by sakura add(E)         
      
      
      
      #add-point:stus控制
      
      #end add-point
      
   END MENU
   
   IF (lc_state <> "N" 
      AND lc_state <> "X"
      AND lc_state <> "Y"
      ) OR 
      cl_null(lc_state) THEN
      RETURN
   END IF
   
   #add-point:stus修改前
      CALL s_transaction_begin()
   IF lc_state = 'Y' THEN
#      CALL s_ammt350_conf_chk(g_mmbo_m.mmbodocno) RETURNING l_success,l_errno
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
#            CALL s_ammt350_conf_upd(g_mmbo_m.mmbodocno) RETURNING l_success
#            IF NOT l_success THEN
#               CALL s_transaction_end('N','0')
#               RETURN
#            END IF
#           #160530-00033#1 -s by 08172
#            #發佈
#            #詢問是否發佈
#            IF cl_ask_confirm("amm-00178") THEN #是否進行規則發佈(Y/N)?
#               CALL s_ammm350_issue_chk(g_mmbo_m.mmbo001) RETURNING l_success,l_errno
#               IF NOT l_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = l_errno
#                  LET g_errparam.extend = g_mmbo_m.mmbodocno
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#            
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#            
#               #發佈
#               CALL s_ammm350_issue_upd(g_mmbo_m.mmbo001) RETURNING l_success
#               IF NOT l_success THEN
#                  CALL s_transaction_end('N','0')
#                  RETURN
#               END IF
#            END IF              
#            #160530-00033#1 -e  by 08172
#         END IF
#      END IF
       CALL s_ammt350_renewed(g_mmbo_m.mmbodocno,g_mmbo_m.mmbo005) RETURNING l_success
       IF NOT l_success THEN
          CALL s_transaction_end('N','0')
          RETURN
       END IF
   END IF
   IF lc_state = 'X' THEN
      CALL s_ammt350_void_chk(g_mmbo_m.mmbodocno) RETURNING l_success,l_errno
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
            CALL s_ammt350_void_upd(g_mmbo_m.mmbodocno) RETURNING l_success
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               RETURN
            END IF
         END IF
      END IF
   END IF
   #end add-point
      
   UPDATE mmbo_t SET mmbostus = lc_state 
    WHERE mmboent = g_enterprise AND mmbodocno = g_mmbo_m.mmbodocno
 
  
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
 
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
      LET g_mmbo_m.mmbostus = lc_state
      DISPLAY BY NAME g_mmbo_m.mmbostus
   END IF
 
   #add-point:stus修改後
      IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE      
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #add-point:statechange段結束前
   
   #end add-point  
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="ammt350.idx_chk" >}
#+ 單身筆數變更
PRIVATE FUNCTION ammt350_idx_chk()
   #add-point:idx_chk段define
   
   #end add-point  
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_mmbp_d.getLength() THEN
         LET g_detail_idx = g_mmbp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_mmbp2_d.getLength() THEN
         LET g_detail_idx = g_mmbp2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_mmbp2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_mmbp2_d.getLength() TO FORMONLY.cnt
   END IF
   #160613-00031#1 160615 by sakura mark(S)
   #IF g_current_page = 3 THEN
   #   LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
   #   IF g_detail_idx > g_mmbp3_d.getLength() THEN
   #      LET g_detail_idx = g_mmbp3_d.getLength()
   #   END IF
   #   IF g_detail_idx = 0 AND g_mmbp3_d.getLength() <> 0 THEN
   #      LET g_detail_idx = 1
   #   END IF
   #   DISPLAY g_detail_idx TO FORMONLY.idx
   #   DISPLAY g_mmbp3_d.getLength() TO FORMONLY.cnt
   #END IF
   #160613-00031#1 160615 by sakura mark(E)
   
   #160613-00031#1 160615 by sakura add(S)
   IF g_current_page = 3 THEN
      LET g_detail_idx3 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx3 > g_mmbp3_d.getLength() THEN
         LET g_detail_idx3 = g_mmbp3_d.getLength()
      END IF
      IF g_detail_idx3 = 0 AND g_mmbp3_d.getLength() <> 0 THEN
         LET g_detail_idx3 = 1
      END IF
      DISPLAY g_detail_idx3 TO FORMONLY.idx
      DISPLAY g_mmbp3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx4 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx4 > g_mmbp4_d.getLength() THEN
         LET g_detail_idx4 = g_mmbp4_d.getLength()
      END IF
      IF g_detail_idx4 = 0 AND g_mmbp4_d.getLength() <> 0 THEN
         LET g_detail_idx4 = 1
      END IF
      DISPLAY g_detail_idx4 TO FORMONLY.idx
      DISPLAY g_mmbp4_d.getLength() TO FORMONLY.cnt
   END IF   
   #160613-00031#1 160615 by sakura add(E)   
 
   
   #add-point:idx_chk段other
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammt350_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   DEFINE ls_chk          LIKE type_t.chr1
   #add-point:b_fill2段define
   DEFINE li_detail_idx_tmp      LIKE type_t.num10   #160613-00031#1 160615 by sakura add
   #end add-point
   
   LET li_ac = l_ac 
   
 
   #160613-00031#1 160615 by sakura add(S)
   IF g_detail_idx3 <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx3
   
   IF ammt350_fill_chk(4) THEN
      IF (pi_idx = 4 OR pi_idx = 0 ) AND g_mmbp3_d.getLength() > 0 THEN
               CALL g_mmbp4_d.clear()
 
         
         #取得該單身上階單身的idx
         
         LET g_sql = "SELECT  DISTINCT mmdj005,mmdj006,mmdj007,mmdj008,mmdj009,mmdj010,mmdj011,mmdjacti  FROM mmdj_t", 
                 
                     "",
                     
                     " WHERE mmdjent=? AND mmdjdocno=? AND mmdj003=? AND mmdj004=?"
         
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  mmdj_t.mmdj005" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill4"
 
         #end add-point
         
         #先清空資料
               CALL g_mmbp4_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE ammt350_pb4 FROM g_sql
         DECLARE b_fill_curs4 CURSOR FOR ammt350_pb4
         
         OPEN b_fill_curs4 USING g_enterprise,g_mmbo_m.mmbodocno,g_mmbp3_d[g_detail_idx3].mmbr003,g_mmbp3_d[g_detail_idx3].mmbr004 
 
         LET l_ac = 1
         FOREACH b_fill_curs4 INTO g_mmbp4_d[l_ac].mmdj005,g_mmbp4_d[l_ac].mmdj006,g_mmbp4_d[l_ac].mmdj007, 
             g_mmbp4_d[l_ac].mmdj008,g_mmbp4_d[l_ac].mmdj009,g_mmbp4_d[l_ac].mmdj010,g_mmbp4_d[l_ac].mmdj011, 
             g_mmbp4_d[l_ac].mmdjacti 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill4"
 
            #end add-point
           
            IF l_ac > g_max_rec THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            LET l_ac = l_ac + 1
            
         END FOREACH
               CALL g_mmbp4_d.deleteElement(g_mmbp4_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_mmbp4_d_mask_o.* =  g_mmbp4_d.*
   FOR l_ac = 1 TO g_mmbp4_d.getLength()
      LET g_mmbp4_d_mask_o[l_ac].* =  g_mmbp4_d[l_ac].*
      LET g_mmbp4_d_mask_n[l_ac].* =  g_mmbp4_d[l_ac].*
   END FOR
   #160613-00031#1 160615 by sakura add(E)
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL ammt350_detail_show()
   
   LET g_detail_idx3 = li_detail_idx_tmp   #160613-00031#1 160615 by sakura add
   
END FUNCTION
 
{</section>}
 
{<section id="ammt350.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION ammt350_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1')  AND 
      (cl_null(g_wc2_table3) OR g_wc2_table3.trim() = '1=1')  THEN
      #add-point:fill_chk段define
      
      #end add-point
      RETURN TRUE
   END IF 
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
   IF ps_idx = 2 AND
      ((NOT cl_null(g_wc2_table2) AND g_wc2_table2.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   IF ps_idx = 3 AND
      ((NOT cl_null(g_wc2_table3) AND g_wc2_table3.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #160613-00031#1 160615 by sakura add(S)
   IF ps_idx = 4 AND
      ((NOT cl_null(g_wc2_table4) AND g_wc2_table4.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF   
   ##160613-00031#1 160615 by sakura add(E)  
 
 
 
   #RETURN FALSE   #160613-00031#1 160615 by sakura mark
   RETURN TRUE     #160613-00031#1 160615 by sakura add
 
END FUNCTION
 
{</section>}
 
{<section id="ammt350.signature" >}
   
 
{</section>}
 
{<section id="ammt350.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION ammt350_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_mmbo_m.mmbodocno
   LET g_pk_array[1].column = 'mmbodocno'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="ammt350.other_dialog" readonly="Y" >}
 
 
{</section>}
 
{<section id="ammt350.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo001_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo001_chk()
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_mmbtunit LIKE mmbt_t.mmbtunit

   #初始化
   INITIALIZE g_errno TO NULL
   LET l_cnt = 0
   
   #检查：该规则编号是否存在未确认单据
   SELECT COUNT(*) INTO l_cnt
     FROM mmbo_t
    WHERE mmboent = g_enterprise AND mmbo001 = g_mmbo_m.mmbo001 AND mmbostus = 'N' AND mmbo004 = '1'
   IF l_cnt > 0 THEN
      LET g_errno = 'amm-00152' #当前规则编号仍存在未审核的单据,不允许输入 -- 
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
            LET g_errno = 'amm-00153' #申请类别为I.新增时,规则编号不可存在于[会员卡储值加值规则基本资料档]中 
         END IF
      WHEN 'U'
         SELECT COUNT(*) INTO l_cnt
           FROM mmbt_t
          WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001 AND mmbt004 = '1'
         IF l_cnt = 0 THEN 
            LET g_errno = 'amm-00154' 
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
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_detail_count()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_detail_count()
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
     FROM mmbp_t
    WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt2
     FROM mmbs_t
    WHERE mmbsent = g_enterprise AND mmbsdocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt3
     FROM mmbr_t
    WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbo_m.mmbodocno
   SELECT COUNT(*) INTO l_cnt4
     FROM mmbq_t
    WHERE mmbqent = g_enterprise AND mmbqdocno = g_mmbo_m.mmbodocno
   IF l_cnt1 > 0 OR l_cnt2 > 0 OR l_cnt3 > 0 OR l_cnt4 > 0 THEN
      LET l_success = FALSE
      RETURN l_success
   END IF
   RETURN l_success
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo001_init()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo001_init()
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
                   mmbt004,mmbt005,mmbt006,mmbt007,mmbt008,mmbt014,mmbt015,mmbt019,mmbt020
              INTO g_mmbo_m.mmboacti,
                   g_mmbo_m.mmbo002,
                   g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,
                   g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,g_mmbo_m.mmbo017
              FROM mmbt_t
             WHERE mmbtent = g_enterprise AND mmbt001 = g_mmbo_m.mmbo001
            LET g_mmbo_m.mmbo002 = g_mmbo_m.mmbo002 USING '<<<<<<<#'
         ELSE
            INITIALIZE g_mmbo_m.mmbol002,g_mmbo_m.mmbol003 TO NULL
            INITIALIZE g_mmbo_m.mmboacti,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                       g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,
                       g_mmbo_m.mmbo017
                    TO NULL
            LET g_mmbo_m.mmbo004 = "2"
           #LET g_mmbo_m.mmbo002 = "1" #sakura mark
            LET g_mmbo_m.mmbo002 = "0" #sakura add
            LET g_mmbo_m.mmbo007 = "0"
            LET g_mmbo_m.mmbo008 = "0"
            LET g_mmbo_m.mmboacti = "Y"
            LET g_mmbo_m.mmbo017 = "1"
         END IF
   END CASE
   DISPLAY BY NAME g_mmbo_m.mmboacti,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                   g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,
                   g_mmbo_m.mmbo015,g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,g_mmbo_m.mmbo017
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo005_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo005_ref()
   LET g_mmbo_m.mmbo005_desc = ''   #160729-00077#6 20160817 add by beckxie
   
   IF g_mmbo_m.mmbo017='1' THEN #卡种
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   IF g_mmbo_m.mmbo017='2' THEN #会员等级
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   #160729-00077#6 20160817 add by beckxie---S
   IF g_mmbo_m.mmbo017='11' THEN #其他類型一
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2026' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   IF g_mmbo_m.mmbo017='12' THEN #其他類型二
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2027' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   IF g_mmbo_m.mmbo017='13' THEN #其他類型三
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2028' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   IF g_mmbo_m.mmbo017='14' THEN #其他類型四
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2029' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   IF g_mmbo_m.mmbo017='15' THEN #其他類型五
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_mmbo_m.mmbo005
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2030' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_mmbo_m.mmbo005_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_mmbo_m.mmbo005_desc
   END IF
   #160729-00077#6 20160817 add by beckxie---E
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo005_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo005_chk()
DEFINE l_mmanstus   LIKE mman_t.mmanstus

   INITIALIZE g_errno TO NULL
   
   SELECT mmanstus INTO l_mmanstus
     FROM mman_t
    WHERE mmanent = g_enterprise AND mman001 = g_mmbo_m.mmbo005
   CASE
      WHEN SQLCA.sqlcode = 100 LET g_errno = 'amm-00003' #该卡种不存在 -- 请至[会员卡种基本资料维护作业ammm320]查询后重新输入
      WHEN l_mmanstus <> 'Y'   LET g_errno = 'amm-00004' #该卡种已无效 -- 请至[会员卡种基本资料维护作业ammm320]查询后重新输入
   END CASE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo014_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo014_chk()
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
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbosite_ref()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbosite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbo_m.mmbosite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbo_m.mmbosite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbo_m.mmbosite_desc
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbounit_chk()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbounit_chk()
RETURN TRUE
END FUNCTION
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo007_chk(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo007_chk(p_cmd)
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
        FROM mmbp_t
       WHERE mmbpent = g_enterprise AND mmbpdocno = g_mmbo_m.mmbodocno
      
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
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL ammt350_mmbo008_chk(p_cmd)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammt350_mmbo008_chk(p_cmd)
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
PUBLIC FUNCTION ammt350_mmbo014_mmbo015_chk()
DEFINE l_n    LIKE type_t.num5 
 
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
   
   SELECT COUNT(*) INTO l_n FROM mmbr_t
    WHERE mmbrent = g_enterprise AND (mmbr014 < g_mmbo_m.mmbo014 OR mmbr015 > g_mmbo_m.mmbo015) AND mmbrdocno = g_mmbo_m.mmbodocno
   
   IF l_n > 0 THEN
      LET  g_errno = 'amm-00274'
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
PUBLIC FUNCTION ammt350_mmbp004_chk(p_mmbp004)
DEFINE p_mmbp004  LIKE mmbp_t.mmbp004
DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_ooiastus LIKE ooia_t.ooiastus
DEFINE l_imaastus LIKE imaa_t.imaastus
DEFINE l_rtaxstus LIKE rtax_t.rtaxstus
DEFINE l_rtax005  LIKE rtax_t.rtax005
DEFINE l_n        LIKE type_t.num5

    CASE g_mmbo_m.mmbo007
       WHEN  '1'
          #會員等級
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2024' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00076'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00077'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  '2' 
          #會員類型
          
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2025' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00074'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00075'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '3'
          #款別類型
          
          SELECT ooiastus INTO l_ooiastus FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = p_mmbp004
          IF STATUS = 100 OR cl_null(l_ooiastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00195'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_ooiastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'aoo-00196'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aooi713'
                LET g_errparam.replace[2] = cl_get_progname('aooi713',g_lang,"2")
                LET g_errparam.exeprog    ='aooi713'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '4'
          #商品編號
          SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_mmbp004
           IF STATUS = 100 OR cl_null(l_imaastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00016'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_imaastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'art-00050'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aimm200'
                LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                LET g_errparam.exeprog    ='aimm200'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '5'
          #商品分類
           SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbp004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '6'
          #商品屬性-產地分類
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2000' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00077'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00078'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
          
       WHEN  '7'
          #商品屬性-價格帶
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2001' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00079'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00080'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '8'
          #商品屬性-品牌
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2002' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00081'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00082'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '9'
          #商品屬性-系列
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2003' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00083'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00084'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'A'
          #商品屬性-型別
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2004' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00085'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00086'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'B'
          #商品屬性-功能
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2005' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00087'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00088'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'C'
          #商品屬性-其它屬性一
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2006' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00089'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00090'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'D'
          #商品屬性-其它屬性二
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2007' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00091'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00092'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'E'
          #商品屬性-其它屬性三
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2008' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00093'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00094'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'F'
          #商品屬性-其它屬性四
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2009' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00095'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00096'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'G'
          #商品屬性-其它屬性五
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2010' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00097'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00098'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'H'
          #商品屬性-其它屬性六
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2011' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00099'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00100'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'I'
          #商品屬性-其它屬性七
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2012' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00101'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00102'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'J'
          #商品屬性-其它屬性八
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2013' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00103'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00104'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'K'
          #商品屬性-其它屬性九
            SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2014' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00105'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00106'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'L'
          #商品屬性-其它屬性十
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2015' AND oocq002 = p_mmbp004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00107'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00108'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN 'U'
         #庫區類別
         SELECT COUNT(*) INTO l_n FROM gzcb_t WHERE gzcb001 = '6200' AND gzcb002 = p_mmbp004
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00114'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE
       WHEN 'V' 
         #庫區品類(层级未添加）
          SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbp004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
         
         
    END CASE
    RETURN TRUE
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
PUBLIC FUNCTION ammt350_mmbp004_ref(p_mmbo007,p_mmbp004)
DEFINE p_mmbo007       LIKE mmbo_t.mmbo007
DEFINE p_mmbp004       LIKE mmbp_t.mmbp004
DEFINE l_mmbp004_desc  LIKE type_t.chr80

    CASE p_mmbo007
       WHEN  '1' #會員等級
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2024' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang
           
        
       WHEN  '2' #會員類型
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2025' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang
       
       WHEN  '3' #款別類型
          SELECT ooial003 INTO l_mmbp004_desc FROM ooial_t
           WHERE ooialent = g_enterprise AND ooial001 =  p_mmbp004 AND ooial002 = g_dlang
       
       WHEN '4' #商品編號
          SELECT imaal003 INTO l_mmbp004_desc FROM imaal_t
           WHERE imaalent = g_enterprise AND imaal001 = p_mmbp004 AND imaal002 = g_dlang
           
       WHEN '5' #商品分類
           SELECT rtaxl003 INTO l_mmbp004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmbp004 AND rtaxl002 = g_dlang 

       WHEN '6' #商品屬性-產地分類
           SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2000' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang
           
       WHEN '7' #商品屬性-價格帶
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang
           
       WHEN '8' #商品屬性-品牌
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2002' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  

       WHEN '9' #商品屬性-系列
           SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2003' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang   

       WHEN 'A' #商品屬性-型別
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2004' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang 

       WHEN 'B' #商品屬性-功能
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2005' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang 
       
       WHEN 'C' #商品屬性-其它屬性一
         SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2006' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  

       WHEN 'D' #商品屬性-其它屬性二
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2007' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  
   
       WHEN 'E' #商品屬性-其它屬性三
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2008' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  
       WHEN 'F' #商品屬性-其它屬性四
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2009' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  
       WHEN 'G' #商品屬性-其它屬性五
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2010' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  
        
       WHEN 'H' #商品屬性-其它屬性六
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2011' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang  
           
       WHEN 'I' #商品屬性-其它屬性七
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2012' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang   
       WHEN 'J' #商品屬性-其它屬性八
           SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2013' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang           
      
       WHEN 'K' #商品屬性-其它屬性九
           SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang   

       WHEN 'L' #商品屬性-其它屬性十
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang 
           
       WHEN 'U'
         #庫區類別
           SELECT gzcbl004 INTO l_mmbp004_desc FROM gzcbl_t 
            WHERE gzcbl001 = '6200' AND gzcbl002 = p_mmbp004 AND gzcbl003 =  g_dlang 
       WHEN 'V' 
         #庫區品類 
           SELECT rtaxl003 INTO l_mmbp004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmbp004 AND rtaxl002 = g_dlang 
            
       #150324-00007#4 Add By Ken 150408
       WHEN  'Z' #會員類型
          SELECT oocql004 INTO l_mmbp004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2131' AND oocql002 = p_mmbp004 AND oocql003 = g_dlang       
       #150324-00007#4
    END CASE 
    LET g_mmbp_d[l_ac].mmbp004_desc = l_mmbp004_desc   
    DISPLAY BY NAME g_mmbp_d[l_ac].mmbp004_desc
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
PUBLIC FUNCTION ammt350_mmbr004_chk(p_mmbr004)
DEFINE p_mmbr004   LIKE mmbr_t.mmbr004

DEFINE l_oocqstus LIKE oocq_t.oocqstus
DEFINE l_ooiastus LIKE ooia_t.ooiastus
DEFINE l_imaastus LIKE imaa_t.imaastus
DEFINE l_rtaxstus LIKE rtax_t.rtaxstus
DEFINE l_rtax005  LIKE rtax_t.rtax005
DEFINE l_n        LIKE type_t.num5
DEFINE l_ooeastus LIKE ooea_t.ooeastus
DEFINE l_inaastus LIKE inaa_t.inaastus

    CASE g_mmbp3_d[l_ac].mmbr003
       WHEN  '1'
          #會員等級
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2024' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00076'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00077'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  '2' 
          #會員類型
          
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2025' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00074'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00075'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '3'
          #款別類型
          
          SELECT ooiastus INTO l_ooiastus FROM ooia_t WHERE ooiaent = g_enterprise AND ooia001 = p_mmbr004
          IF STATUS = 100 OR cl_null(l_ooiastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00195'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_ooiastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'aoo-00196'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aooi713'
                LET g_errparam.replace[2] = cl_get_progname('aooi713',g_lang,"2")
                LET g_errparam.exeprog    ='aooi713'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '4'
          #商品編號
          SELECT imaastus INTO l_imaastus FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_mmbr004
           IF STATUS = 100 OR cl_null(l_imaastus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00016'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_imaastus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'sub-01302'  #160318-00005#23 mod'art-00050'
                LET g_errparam.extend = ''
                #160318-00005#23  --add--str
                LET g_errparam.replace[1] ='aimm200'
                LET g_errparam.replace[2] = cl_get_progname('aimm200',g_lang,"2")
                LET g_errparam.exeprog    ='aimm200'
                #160318-00005#23 --add--end
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '5'
          #商品分類
           SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbr004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '6'
          #商品屬性-產地分類
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2000' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00077'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00078'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
          
       WHEN  '7'
          #商品屬性-價格帶
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2001' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00079'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00080'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '8'
          #商品屬性-品牌
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2002' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00081'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00082'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  '9'
          #商品屬性-系列
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2003' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00083'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00084'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'A'
          #商品屬性-型別
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2004' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00085'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00086'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'B'
          #商品屬性-功能
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2005' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00087'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00088'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'C'
          #商品屬性-其它屬性一
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2006' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00089'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00090'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'D'
          #商品屬性-其它屬性二
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2007' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00091'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00092'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'E'
          #商品屬性-其它屬性三
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2008' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00093'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00094'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'F'
          #商品屬性-其它屬性四
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2009' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00095'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00096'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'G'
          #商品屬性-其它屬性五
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2010' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00097'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00098'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN  'H'
          #商品屬性-其它屬性六
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2011' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00099'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00100'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'I'
          #商品屬性-其它屬性七
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2012' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00101'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00102'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'J'
          #商品屬性-其它屬性八
           SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2013' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00103'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00104'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'K'
          #商品屬性-其它屬性九
            SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2014' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00105'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00106'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN  'L'
          #商品屬性-其它屬性十
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2015' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00107'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00108'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
          
       WHEN 'Q'
         #紀念日
          SELECT oocqstus INTO l_oocqstus FROM oocq_t
           WHERE oocqent =  g_enterprise AND oocq001 = '2050' AND oocq002 = p_mmbr004
    
          IF STATUS = 100 OR cl_null(l_oocqstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'amm-00121'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = '2050'
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_oocqstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'amm-00117'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
       WHEN 'R'
         #促銷活動檔期
       WHEN 'S'
         #營運據點
         SELECT ooeastus INTO l_ooeastus FROM ooea_t 
          WHERE ooeaent = g_enterprise AND ooea001 =p_mmbr004   AND ooea004 = 'Y'
         IF status = 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00163'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            RETURN FALSE
         END IF  
         IF l_ooeastus = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aoo-00012'
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE    
         
       WHEN 'T'
         #庫位編號
         SELECT inaastus INTO l_inaastus FROM inaa_t
          WHERE inaaent = g_enterprise AND inaa001 = p_mmbr004 AND inaasite = g_site
         IF status = 100 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00087'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         ELSE
            IF l_inaastus = 'N' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'amm-00088'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN FALSE
            END IF
         END IF
         RETURN TRUE
       WHEN 'U'
         #庫區類別
         SELECT COUNT(*) INTO l_n FROM gzcb_t WHERE gzcb001 = '6200' AND gzcb002 = p_mmbr004
         IF l_n = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00114'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
         RETURN TRUE
       WHEN 'V' 
         #庫區品類(层级未添加）
          SELECT rtaxstus ,rtax005 INTO l_rtaxstus,l_rtax005 FROM rtax_t WHERE rtaxent = g_enterprise AND rtax001 = p_mmbr004
           IF STATUS = 100 OR cl_null(l_rtaxstus) THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'art-00059'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             RETURN FALSE
          ELSE
             IF l_rtaxstus = 'N' THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00048'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
             IF l_rtax005 <> 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'art-00003'
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()

                RETURN FALSE
             END IF
          END IF
          RETURN TRUE
         
         
    END CASE
    RETURN TRUE
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
PUBLIC FUNCTION ammt350_mmbr004_ref(p_mmbr003,p_mmbr004)
DEFINE p_mmbr003  LIKE mmbr_t.mmbr003
DEFINE p_mmbr004  LIKE mmbr_t.mmbr004
DEFINE l_mmbr004_desc LIKE type_t.chr80

   CASE p_mmbr003
       WHEN  '1' #會員等級
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2024' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang
            
       WHEN  '2' #會員類型
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2025' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang
       
       WHEN  '3' #款別類型
          SELECT ooial003 INTO l_mmbr004_desc FROM ooial_t
           WHERE ooialent = g_enterprise AND ooial001 =  p_mmbr004 AND ooial002 = g_dlang
       
       WHEN '4' #商品編號
          SELECT imaal003 INTO l_mmbr004_desc FROM imaal_t
           WHERE imaalent = g_enterprise AND imaal001 = p_mmbr004 AND imaal002 = g_dlang
           
       WHEN '5' #商品分類
           SELECT rtaxl003 INTO l_mmbr004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmbr004 AND rtaxl002 = g_dlang 

       WHEN '6' #商品屬性-產地分類
           SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2000' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang
           
       WHEN '7' #商品屬性-價格帶
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2001' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang
           
       WHEN '8' #商品屬性-品牌
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2002' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  

       WHEN '9' #商品屬性-系列
           SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2003' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang   

       WHEN 'A' #商品屬性-型別
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2004' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang 

       WHEN 'B' #商品屬性-功能
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2005' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang 
       
       WHEN 'C' #商品屬性-其它屬性一
         SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2006' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  

       WHEN 'D' #商品屬性-其它屬性二
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2007' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  
   
       WHEN 'E' #商品屬性-其它屬性三
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2008' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  
       WHEN 'F' #商品屬性-其它屬性四
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2009' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  
       WHEN 'G' #商品屬性-其它屬性五
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2010' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  
        
       WHEN 'H' #商品屬性-其它屬性六
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2011' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang  
           
       WHEN 'I' #商品屬性-其它屬性七
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2012' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang   
       WHEN 'J' #商品屬性-其它屬性八
           SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2013' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang           
      
       WHEN 'K' #商品屬性-其它屬性九
           SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang   

       WHEN 'L' #商品屬性-其它屬性十
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2014' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang 
       
       WHEN 'Q' #紀念日
           SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2050' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang 
           
       WHEN 'R' #促銷活動檔期
       
       WHEN 'S' #營運據點
           SELECT ooeal003 INTO l_mmbr004_desc FROM ooeal_t
            WHERE ooealent = g_enterprise AND ooeal001 = p_mmbr004 AND ooeal002 = g_dlang
        
       WHEN 'T' #庫位編號
           SELECT inaa003 INTO l_mmbr004_desc FROM inaa_t
            WHERE inaaent = g_enterprise AND inaa001 = p_mmbr004 AND inaasite = g_site
       WHEN 'U'
         #庫區類別
           SELECT gzcbl004 INTO  l_mmbr004_desc FROM gzcbl_t 
            WHERE gzcbl001 = '6200' AND gzcbl002 = p_mmbr004 AND gzcbl003 =  g_dlang 
       WHEN 'V' 
         #庫區品類 
           SELECT rtaxl003 INTO l_mmbr004_desc FROM rtaxl_t
            WHERE rtaxlent = g_enterprise AND rtaxl001 = p_mmbr004 AND rtaxl002 = g_dlang 
            
       #150324-00007#4 Add By Ken 150408
       WHEN  'Z' #會員類型
          SELECT oocql004 INTO l_mmbr004_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql001 = '2131' AND oocql002 = p_mmbr004 AND oocql003 = g_dlang       
       #150324-00007#4            
    END CASE
    LET g_mmbp3_d[l_ac].mmbr004_desc =  l_mmbr004_desc 
    DISPLAY BY NAME  g_mmbp3_d[l_ac].mmbr004_desc 
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
PUBLIC FUNCTION ammt350_mmbs004_ref()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbp2_d[l_ac].mmbs004
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbp2_d[l_ac].mmbs004_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_mmbp2_d[l_ac].mmbs004_desc
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
PUBLIC FUNCTION ammt350_detail_init()
   IF g_mmbo_m.mmbo000 <> 'U' THEN
      RETURN
   END IF
   
   IF ammt350_mmbo007_chk('a') THEN
      #一般规则设定
      INSERT INTO mmbp_t (mmbpent,mmbpsite,mmbpunit,mmbpdocno,mmbp001,mmbp002,mmbp003,mmbp004,mmbp005,mmbp006,mmbp007,mmbp008,mmbp009,mmbp010,mmbpacti)
      SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,
             mmbu001,mmbu002,mmbu003,mmbu004,mmbu005,mmbu006,mmbu007,mmbu008,mmbu009,mmbu010,mmbustus
        FROM mmbu_t
       WHERE mmbuent = g_enterprise AND mmbu001 = g_mmbo_m.mmbo001
      
      #生效营运据点
      INSERT INTO mmbs_t (mmbsent,mmbssite,mmbsunit,mmbsdocno,mmbs001,mmbs002,mmbs003,mmbs004,mmbs005,mmbsacti)
      SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,
             mmbx001,mmbx002,mmbx003,mmbx004,mmbx005,mmbxstus
        FROM mmbx_t
       WHERE mmbxent = g_enterprise AND mmbx001 = g_mmbo_m.mmbo001
   END IF
   
   #进阶规则设定
   INSERT INTO mmbr_t (mmbrent,mmbrsite,mmbrunit,mmbrdocno,mmbr001,mmbr002,mmbr003,mmbr004,mmbr005,mmbr006,mmbr007,mmbr008,
                       mmbr009,mmbr010,mmbr011,mmbr012,mmbr013,mmbr014,mmbr015,mmbr016,mmbr017,mmbr018,mmbr019,mmbracti)
   SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,
          mmbw001,mmbw002,mmbw003,mmbw004,mmbw005,mmbw006,mmbw007,mmbw008,mmbw009,mmbw010,
          mmbw011,mmbw012,mmbw013,mmbw014,mmbw015,mmbw016,mmbw017,mmbw018,mmbw019,mmbwstus
     FROM mmbw_t
    WHERE mmbwent = g_enterprise AND mmbw001 = g_mmbo_m.mmbo001
   
   IF ammt350_mmbo008_chk('a') THEN
      #储值加值除外规则设定
      INSERT INTO mmbq_t (mmbqent,mmbqsite,mmbqunit,mmbqdocno,mmbq001,mmbq002,mmbq003,mmbq004,mmbqacti)
      SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,
             mmbv001,mmbv002,mmbv003,mmbv004,mmbvstus
        FROM mmbv_t
       WHERE mmbvent = g_enterprise AND mmbv001 = g_mmbo_m.mmbo001
   END IF
   
   #160613-00031#1 160615 by sakura add(S)
   #高端规则对应日期范围设置
   INSERT INTO mmdj_t (mmdjent, mmdjsite, mmdjunit, mmdjdocno,
                       mmdj001, mmdj002,  mmdj003,  mmdj004,  mmdj005,
                       mmdj006, mmdj007,  mmdj008,  mmdj009,  mmdj010, 
                       mmdj011, mmdjacti)
   SELECT g_enterprise,g_mmbo_m.mmbounit,g_mmbo_m.mmbounit,g_mmbo_m.mmbodocno,
          mmdk001,     mmdk002,          mmdk003,          mmdk004,             mmdk005, 
          mmdk006,     mmdk007,          mmdk008,          mmdk009,             mmdk010, 
          mmdk011,     mmdkacti
     FROM mmdk_t
    WHERE mmdkent = g_enterprise AND mmdk001 = g_mmbo_m.mmbo001   
   #160613-00031#1 160615 by sakura add(E)   
   
   #单身填充
   CALL ammt350_b_fill()
   CALL ammt350_b_fill2('4')   #160613-00031#1 160615 by sakura add
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
PUBLIC FUNCTION ammt350_show_desc(p_ac)
   DEFINE p_ac   LIKE type_t.num10
 
   IF cl_null(p_ac) OR p_ac <= 0 THEN LET p_ac = 1 END IF
   LET g_mmbo_m.mmbr004_1 = g_mmbp3_d[p_ac].mmbr004
   LET g_mmbo_m.mmbr004_1_desc = g_mmbp3_d[p_ac].mmbr004_desc 
   LET g_mmbo_m.mmbr014_1 = g_mmbp3_d[p_ac].mmbr014 
   LET g_mmbo_m.mmbr015_1 = g_mmbp3_d[p_ac].mmbr015 
   LET g_mmbo_m.mmbr016_1 = g_mmbp3_d[p_ac].mmbr016 
   LET g_mmbo_m.mmbr017_1 = g_mmbp3_d[p_ac].mmbr017 
   LET g_mmbo_m.mmbr018_1 = g_mmbp3_d[p_ac].mmbr018 
   LET g_mmbo_m.mmbr019_1 = g_mmbp3_d[p_ac].mmbr019 
   
   DISPLAY BY NAME g_mmbo_m.mmbr004_1,g_mmbo_m.mmbr004_1_desc,g_mmbo_m.mmbr014_1,g_mmbo_m.mmbr015_1,
                   g_mmbo_m.mmbr016_1,g_mmbo_m.mmbr017_1,g_mmbo_m.mmbr018_1,g_mmbo_m.mmbr019_1
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
PUBLIC FUNCTION ammt350_mmbr006_chk()
DEFINE l_cnt   LIKE type_t.num5

   IF g_mmbp3_d[l_ac].mmbr005 = 'Y' THEN
   
     SELECT COUNT(*) INTO l_cnt
       FROM mmbr_t
      WHERE mmbrent = g_enterprise AND mmbrdocno = g_mmbo_m.mmbodocno AND mmbr006 = g_mmbp3_d[l_ac].mmbr006
     IF l_cnt > 0 THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'amm-00173'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
  #當[C:互斥]為Y時,同一活動規則編號下優先序號不可重複
        RETURN FALSE
     END IF
   END IF
   RETURN TRUE
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
PUBLIC FUNCTION ammt350_set_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1   

    IF g_mmbp3_d[l_ac].mmbr005 = 'Y' THEN
       CALL cl_set_comp_required("mmbr006",TRUE)
    END IF           
    IF g_mmbp3_d[l_ac].mmbr010 = '1' THEN
       CALL cl_set_comp_required("mmbr011",TRUE)
    END IF
    IF g_mmbp3_d[l_ac].mmbr010 = '3' THEN
       CALL cl_set_comp_required("mmbr012,mmbr013",TRUE)
    END IF
    IF g_mmbp3_d[l_ac].mmbr010 = '2' THEN
       CALL cl_set_comp_required("mmbr013",TRUE)
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
PUBLIC FUNCTION ammt350_mmbr007_init()
   IF cl_null(g_mmbp3_d[l_ac].mmbr007) THEN RETURN END IF
   
   CASE g_mmbp3_d[l_ac].mmbr007
      WHEN '1'
         CALL cl_set_comp_entry('mmbr008,mmbr009',FALSE)
         INITIALIZE g_mmbp3_d[l_ac].mmbr008 TO NULL
         INITIALIZE g_mmbp3_d[l_ac].mmbr009 TO NULL
      WHEN '2'
         CALL cl_set_comp_entry('mmbr008,mmbr009',FALSE)
         INITIALIZE g_mmbp3_d[l_ac].mmbr008 TO NULL
         INITIALIZE g_mmbp3_d[l_ac].mmbr009 TO NULL
      WHEN '3'
         CALL cl_set_comp_entry('mmbr008,mmbr009',TRUE)
   END CASE
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
PUBLIC FUNCTION ammt350_set_no_required_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1   

    IF g_mmbp3_d[l_ac].mmbr005 = 'N' THEN
       CALL cl_set_comp_required("mmbr006",FALSE)
    END IF
    IF g_mmbp3_d[l_ac].mmbr010 = '1' THEN
       CALL cl_set_comp_required("mmbr013",FALSE)
    ELSE
       CALL cl_set_comp_required("mmbr011",FALSE)
    END IF
    IF g_mmbp3_d[l_ac].mmbr010 <> '3' THEN
       CALL cl_set_comp_required("mmbr012",FALSE)
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
PUBLIC FUNCTION ammt350_mmbr010_init()
IF cl_null(g_mmbp3_d[l_ac].mmbr010) THEN RETURN END IF
   
   CASE g_mmbp3_d[l_ac].mmbr010
      WHEN '1'
         INITIALIZE g_mmbp3_d[l_ac].mmbr012 TO NULL
         INITIALIZE g_mmbp3_d[l_ac].mmbr013 TO NULL
      WHEN '2'
         INITIALIZE g_mmbp3_d[l_ac].mmbr011 TO NULL
         INITIALIZE g_mmbp3_d[l_ac].mmbr012 TO NULL
      WHEN '3'
         INITIALIZE g_mmbp3_d[l_ac].mmbr011 TO NULL
   END CASE
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
PUBLIC FUNCTION ammt350_mmbt014_chk()
   INITIALIZE g_errno TO NULL
   
   IF cl_null( g_mmbp3_d[l_ac].mmbr014) THEN RETURN END IF
   
   CASE
      WHEN INFIELD(mmbr014)
         IF  g_mmbp3_d[l_ac].mmbr014 < g_mmbo_m.mmbo014 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00065'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            RETURN FALSE
         END IF
         IF NOT cl_null(g_mmbp3_d[l_ac].mmbr015) AND g_mmbp3_d[l_ac].mmbr014 > g_mmbp3_d[l_ac].mmbr015 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00080'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN FALSE
         END IF
      WHEN INFIELD(mmbr015)
         IF g_mmbp3_d[l_ac].mmbr015 > g_mmbo_m.mmbo015 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00066'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            RETURN FALSE
         END IF
         IF NOT cl_null(g_mmbp3_d[l_ac].mmbr014) AND g_mmbp3_d[l_ac].mmbr015 < g_mmbp3_d[l_ac].mmbr014 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00081'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            RETURN FALSE
         END IF
   END CASE
   RETURN TRUE
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
PUBLIC FUNCTION ammt350_mmbo000_init()
   IF cl_null(g_mmbo_m.mmbo001) THEN
      RETURN
   END IF
   INITIALIZE g_mmbo_m.mmbol002,g_mmbo_m.mmbol003 TO NULL
   INITIALIZE g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
              g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,
              g_mmbo_m.mmbo017
           TO NULL
   LET g_mmbo_m.mmbo004 = "1"
  #LET g_mmbo_m.mmbo002 = "1" #sakura mark
   LET g_mmbo_m.mmbo002 = "0" #sakura add
   LET g_mmbo_m.mmbo007 = "0"
   LET g_mmbo_m.mmbo008 = "0"
   LET g_mmbo_m.mmboacti = "Y"
   LET g_mmbo_m.mmbo017 = "1"   
   DISPLAY BY NAME g_mmbo_m.mmbol002,g_mmbo_m.mmbol003,
                   g_mmbo_m.mmbo001,g_mmbo_m.mmbo002,g_mmbo_m.mmbo004,g_mmbo_m.mmbo005,
                   g_mmbo_m.mmbo006,g_mmbo_m.mmbo007,g_mmbo_m.mmbo008,g_mmbo_m.mmbo014,g_mmbo_m.mmbo015,
                   g_mmbo_m.mmboacti,g_mmbo_m.mmbo017
END FUNCTION

################################################################################
#+ BPM提交
################################################################################
PRIVATE FUNCTION ammt350_send()
   #add-point:send段define
   DEFINE l_success LIKE type_t.num5
   DEFINE l_errno LIKE type_t.chr100
   #end add-point 
   #add-point:send段define(客製用)

   #end add-point 
 
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
   CALL ammt350_show()
   CALL ammt350_set_pk_array()
   
   #add-point: 提交前的ADP
   CALL s_ammt350_conf_chk(g_mmbo_m.mmbodocno) RETURNING l_success,l_errno
   IF NOT l_success THEN
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_mmbo_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_mmbp_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_mmbp2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_mmbp3_d))
 
   # cl_bpm_cli() 裡有包含以前的aws_condition()=>送簽資料檢核和更新單據狀況碼為'W'
   # cl_bpm_cli() 傳入參數:無  ;  回傳值: 0 開單失敗; 1 開單成功
 
   #開單失敗
   IF NOT cl_bpm_cli() THEN 
      RETURN FALSE
   END IF
 
   #add-point: 提交後的ADP

   #end add-point
 
   #此段落不需要刪除資料,但是否需要refresh圖片樣式???
   #CALL ammt350_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt350_ui_headershow()
   CALL ammt350_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION

################################################################################
#+ BPM抽單
################################################################################
PRIVATE FUNCTION ammt350_draw_out()
   #add-point:draw段define

   #end add-point
   #add-point:draw段define

   #end add-point
 
   #抽單失敗
   IF NOT cl_bpm_draw_out() THEN 
      RETURN FALSE
   END IF    
          
   #重新指定此筆單據資料狀態圖片=>抽單
   LET g_browser[g_current_row].b_statepic = "stus/16/draw_out.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL ammt350_ui_headershow()  
   CALL ammt350_ui_detailshow()
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 檢查開始日期、結束日期
# Memo...........:
# Usage..........: CALL ammt350_mmdj006_mmdj007_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2016/06/16 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt350_mmdj006_mmdj007_chk()
DEFINE r_success            LIKE type_t.num5
      
   LET r_success = TRUE
   
   #IF cl_null( g_mmbp4_d[l_ac].mmdj006) THEN RETURN END IF
   
   CASE
      WHEN INFIELD(mmdj006)
         IF g_mmbp4_d[l_ac].mmdj006 < g_mmbo_m.mmbo014 THEN
            #單身開始日期須大於等於單頭開始日期
			   INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00065'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
			
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT cl_null(g_mmbp4_d[l_ac].mmdj007) AND g_mmbp4_d[l_ac].mmdj006 > g_mmbp4_d[l_ac].mmdj007 THEN
            #開始日期必須小於等於結束日期!
			   INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00080'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
			
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN INFIELD(mmdj007)
         IF g_mmbp4_d[l_ac].mmdj007 > g_mmbo_m.mmbo015 THEN
            #單身結束日期須小於等於單頭結束日期
			   INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00066'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            LET r_success = FALSE
            RETURN r_success
         END IF
         IF NOT cl_null(g_mmbp4_d[l_ac].mmdj006) AND g_mmbp4_d[l_ac].mmdj007 < g_mmbp4_d[l_ac].mmdj006 THEN
            #結束日期必須大於等於開始日期!
			   INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'amm-00081'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            LET r_success = FALSE
            RETURN r_success
         END IF
   END CASE
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 修改/删除前行为检查(是否可允许此动作)
# Date & Author..: 2016/08/24 By 08742
# Modify.........:
################################################################################
PRIVATE FUNCTION ammt350_action_chk()
 #160818-00017#21 add-S
   SELECT mmbostus  INTO g_mmbo_m.mmbostus
     FROM mmbo_t
    WHERE mmboent = g_enterprise
      AND mmbodocno = g_mmbo_m.mmbodocno

   IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
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
        CALL ammt350_show()
        RETURN FALSE
     END IF
   END IF
   RETURN TRUE   #160901-00063#1  add
   #160818-00017#21 add-E
END FUNCTION

 
{</section>}
 
