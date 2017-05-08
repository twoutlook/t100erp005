#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0024(2017-02-08 10:59:27), PR版次:0024(2017-02-20 10:07:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000444
#+ Filename...: apmt420
#+ Description: 一般採購詢價作業
#+ Creator....: 02294(2013-11-15 16:50:22)
#+ Modifier...: 05423 -SD/PR- 01996
 
{</section>}
 
{<section id="apmt420.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151224-00025#3     2015/12/24  By fionchen  產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160314-00009#3     2016/03/16  By zhujing   各程式增加产品特征是否需要自动开窗的程式段处理
#160318-00025#17    2016/04/11  By 07900     重复错误讯息修改(类型2)
#160510-00011#2     2016/05/26  By Jessica   執行[刪除]或[作廢]時，若有啟用EBCHAIN整合，需調用對方服務「詢價單刪除/作廢」
#160803-00028#1     2016/08/04  By lixiang   修正录入单别后带出的说明不正确的问题
#160812-00017#7     2016/08/16  By Ken       因應產品程式撰寫各支作業應標準一致化，以降低後續維護成本，針對寫法不夠標準的程式進行調整
#                                            在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN 
#160804-00018#1     2016/08/16  By lixiang   若料件使用产品特征栏位，则控管该栏位必输
#160818-00017#27    2016/08/29  By lixiang   单据类作业修改，删除时需重新检查状态
#161116-00041#1     2016/11/24  By shiun     產品特徵可不輸入
#161124-00048#9     2016/12/19  By zhujing   .*整批调整
#160824-00007#341   2017/01/06  By 06137     修正舊值備份寫法
#161031-00025#10    2017/02/07  By zhujing   1.將aooi360_01以嵌入的方式，用頁籤放在apmt420單頭多帳期頁籤與異動資訊頁籤中間
#                                              要可修改
#                                              控制類型 =3:內部資訊傳遞 取消不要了
#                                              項次固定寫入0
#                                            2.原apmt420的備註action，改為確認後可執行，直接修改單頭新的"備註"頁籤
#                                            3.apmt420單身最後面增加顯示"長備註"欄位，一樣抓取aooi360的備註顯示
#                                              項次 = 單身項次
#                                              控制類型 = 列印在後
#160711-00040#24    2017/02/20 By xujing   T類作業的單別開窗的where條件(找CALL q_ooba002_開頭的)增加如下程式段
#                                          CALL s_control_get_docno_sql(g_user,g_dept) RETURNING l_success,l_sql1
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT FGL aoo_aooi360_01   #161031-00025#10 add
#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_pmdf_m        RECORD
       pmdf001 LIKE pmdf_t.pmdf001, 
   pmdfsite LIKE pmdf_t.pmdfsite, 
   pmdfdocno LIKE pmdf_t.pmdfdocno, 
   pmdfdocno_desc LIKE type_t.chr80, 
   pmdfdocdt LIKE pmdf_t.pmdfdocdt, 
   pmdf004 LIKE pmdf_t.pmdf004, 
   pmdf004_desc LIKE type_t.chr80, 
   pmdf002 LIKE pmdf_t.pmdf002, 
   pmdf002_desc LIKE type_t.chr80, 
   pmdf003 LIKE pmdf_t.pmdf003, 
   pmdf003_desc LIKE type_t.chr80, 
   pmdfstus LIKE pmdf_t.pmdfstus, 
   pmdf005 LIKE pmdf_t.pmdf005, 
   pmdf005_desc LIKE type_t.chr80, 
   pmdf006 LIKE pmdf_t.pmdf006, 
   pmdf006_desc LIKE type_t.chr80, 
   pmdf007 LIKE pmdf_t.pmdf007, 
   pmdf008 LIKE pmdf_t.pmdf008, 
   pmdf009 LIKE pmdf_t.pmdf009, 
   pmdf009_desc LIKE type_t.chr80, 
   pmdf010 LIKE pmdf_t.pmdf010, 
   pmdf010_desc LIKE type_t.chr80, 
   pmdf030 LIKE pmdf_t.pmdf030, 
   pmdfownid LIKE pmdf_t.pmdfownid, 
   pmdfownid_desc LIKE type_t.chr80, 
   pmdfowndp LIKE pmdf_t.pmdfowndp, 
   pmdfowndp_desc LIKE type_t.chr80, 
   pmdfcrtid LIKE pmdf_t.pmdfcrtid, 
   pmdfcrtid_desc LIKE type_t.chr80, 
   pmdfcrtdp LIKE pmdf_t.pmdfcrtdp, 
   pmdfcrtdp_desc LIKE type_t.chr80, 
   pmdfcrtdt LIKE pmdf_t.pmdfcrtdt, 
   pmdfmodid LIKE pmdf_t.pmdfmodid, 
   pmdfmodid_desc LIKE type_t.chr80, 
   pmdfmoddt LIKE pmdf_t.pmdfmoddt, 
   pmdfcnfid LIKE pmdf_t.pmdfcnfid, 
   pmdfcnfid_desc LIKE type_t.chr80, 
   pmdfcnfdt LIKE pmdf_t.pmdfcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_pmdg_d        RECORD
       pmdgsite LIKE pmdg_t.pmdgsite, 
   pmdg001 LIKE pmdg_t.pmdg001, 
   pmdgseq LIKE pmdg_t.pmdgseq, 
   pmdg002 LIKE pmdg_t.pmdg002, 
   pmdg002_desc LIKE type_t.chr500, 
   pmdg003 LIKE pmdg_t.pmdg003, 
   pmdg003_desc LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   pmdg004 LIKE pmdg_t.pmdg004, 
   pmdg004_desc LIKE type_t.chr500, 
   pmdg005 LIKE pmdg_t.pmdg005, 
   pmdg005_desc LIKE type_t.chr500, 
   pmdg014 LIKE pmdg_t.pmdg014, 
   pmdg014_desc LIKE type_t.chr500, 
   pmdg015 LIKE pmdg_t.pmdg015, 
   pmdg008 LIKE pmdg_t.pmdg008, 
   pmdg008_desc LIKE type_t.chr500, 
   pmdg007 LIKE pmdg_t.pmdg007, 
   pmdg009 LIKE pmdg_t.pmdg009, 
   pmdg010 LIKE pmdg_t.pmdg010, 
   pmdg018 LIKE pmdg_t.pmdg018, 
   pmdg018_desc LIKE type_t.chr500, 
   pmdg011 LIKE pmdg_t.pmdg011, 
   pmdg012 LIKE pmdg_t.pmdg012, 
   pmdg013 LIKE pmdg_t.pmdg013, 
   pmdg017 LIKE pmdg_t.pmdg017, 
   pmdg016 LIKE pmdg_t.pmdg016, 
   pmdg016_desc LIKE type_t.chr500, 
   pmdg030 LIKE pmdg_t.pmdg030, 
   ooff013 LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pmdg2_d RECORD
       seq LIKE type_t.chr500, 
   pmdh001 LIKE pmdh_t.pmdh001, 
   pmdh002 LIKE pmdh_t.pmdh002, 
   pmdh003 LIKE pmdh_t.pmdh003, 
   pmdh004 LIKE pmdh_t.pmdh004
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_pmdfdocno LIKE pmdf_t.pmdfdocno,
      b_pmdfdocdt LIKE pmdf_t.pmdfdocdt,
      b_pmdf002 LIKE pmdf_t.pmdf002,
   b_pmdf002_desc LIKE type_t.chr80,
      b_pmdf003 LIKE pmdf_t.pmdf003,
   b_pmdf003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag      LIKE type_t.num5   #標記單據編號是否已編號
DEFINE g_tax_app   LIKE oodb_t.oodb011
#161031-00025#10---s
GLOBALS
TYPE type_g_ooff_d        RECORD
       ooff001 LIKE ooff_t.ooff001, 
   ooff002 LIKE ooff_t.ooff002, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff013 LIKE ooff_t.ooff013, 
   ooff014 LIKE ooff_t.ooff014
       END RECORD
 
DEFINE g_ooff_d4          DYNAMIC ARRAY OF type_g_ooff_d

DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
DEFINE g_wc2_i36001      STRING             #备注单身QBE條件
DEFINE g_d_idx_i36001    LIKE type_t.num5   #备注单身所在筆數
DEFINE g_d_cnt_i36001    LIKE type_t.num5   #备注单身總筆數
DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
DEFINE g_ooff001_d       LIKE ooff_t.ooff001
DEFINE g_ooff002_d       LIKE ooff_t.ooff002
DEFINE g_ooff003_d       LIKE ooff_t.ooff003
DEFINE g_ooff004_d       LIKE ooff_t.ooff004
DEFINE g_ooff005_d       LIKE ooff_t.ooff005
DEFINE g_ooff006_d       LIKE ooff_t.ooff006
DEFINE g_ooff007_d       LIKE ooff_t.ooff007
DEFINE g_ooff008_d       LIKE ooff_t.ooff008
DEFINE g_ooff009_d       LIKE ooff_t.ooff009
DEFINE g_ooff010_d       LIKE ooff_t.ooff010
DEFINE g_ooff011_d       LIKE ooff_t.ooff011
END GLOBALS
DEFINE g_detail_id          STRING           #紀錄停留在哪個Page
#161031-00025#10---e
#end add-point
       
#模組變數(Module Variables)
DEFINE g_pmdf_m          type_g_pmdf_m
DEFINE g_pmdf_m_t        type_g_pmdf_m
DEFINE g_pmdf_m_o        type_g_pmdf_m
DEFINE g_pmdf_m_mask_o   type_g_pmdf_m #轉換遮罩前資料
DEFINE g_pmdf_m_mask_n   type_g_pmdf_m #轉換遮罩後資料
 
   DEFINE g_pmdfdocno_t LIKE pmdf_t.pmdfdocno
 
 
DEFINE g_pmdg_d          DYNAMIC ARRAY OF type_g_pmdg_d
DEFINE g_pmdg_d_t        type_g_pmdg_d
DEFINE g_pmdg_d_o        type_g_pmdg_d
DEFINE g_pmdg_d_mask_o   DYNAMIC ARRAY OF type_g_pmdg_d #轉換遮罩前資料
DEFINE g_pmdg_d_mask_n   DYNAMIC ARRAY OF type_g_pmdg_d #轉換遮罩後資料
DEFINE g_pmdg2_d          DYNAMIC ARRAY OF type_g_pmdg2_d
DEFINE g_pmdg2_d_t        type_g_pmdg2_d
DEFINE g_pmdg2_d_o        type_g_pmdg2_d
DEFINE g_pmdg2_d_mask_o   DYNAMIC ARRAY OF type_g_pmdg2_d #轉換遮罩前資料
DEFINE g_pmdg2_d_mask_n   DYNAMIC ARRAY OF type_g_pmdg2_d #轉換遮罩後資料
 
 
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
 
{<section id="apmt420.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   LET g_flag = FALSE
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT pmdf001,pmdfsite,pmdfdocno,'',pmdfdocdt,pmdf004,'',pmdf002,'',pmdf003, 
       '',pmdfstus,pmdf005,'',pmdf006,'',pmdf007,pmdf008,pmdf009,'',pmdf010,'',pmdf030,pmdfownid,'', 
       pmdfowndp,'',pmdfcrtid,'',pmdfcrtdp,'',pmdfcrtdt,pmdfmodid,'',pmdfmoddt,pmdfcnfid,'',pmdfcnfdt", 
        
                      " FROM pmdf_t",
                      " WHERE pmdfent= ? AND pmdfdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt420_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.pmdf001,t0.pmdfsite,t0.pmdfdocno,t0.pmdfdocdt,t0.pmdf004,t0.pmdf002, 
       t0.pmdf003,t0.pmdfstus,t0.pmdf005,t0.pmdf006,t0.pmdf007,t0.pmdf008,t0.pmdf009,t0.pmdf010,t0.pmdf030, 
       t0.pmdfownid,t0.pmdfowndp,t0.pmdfcrtid,t0.pmdfcrtdp,t0.pmdfcrtdt,t0.pmdfmodid,t0.pmdfmoddt,t0.pmdfcnfid, 
       t0.pmdfcnfdt,t1.pmaal004 ,t2.ooag011 ,t3.ooefl003 ,t4.ooail003 ,t5.ooibl004 ,t6.oocql004 ,t7.ooag011 , 
       t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011",
               " FROM pmdf_t t0",
                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.pmdf004 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.pmdf002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.pmdf003 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooail_t t4 ON t4.ooailent="||g_enterprise||" AND t4.ooail001=t0.pmdf005 AND t4.ooail002='"||g_dlang||"' ",
               " LEFT JOIN ooibl_t t5 ON t5.ooiblent="||g_enterprise||" AND t5.ooibl002=t0.pmdf009 AND t5.ooibl003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='238' AND t6.oocql002=t0.pmdf010 AND t6.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.pmdfownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.pmdfowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.pmdfcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.pmdfcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.pmdfmodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.pmdfcnfid  ",
 
               " WHERE t0.pmdfent = " ||g_enterprise|| " AND t0.pmdfdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmt420_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmt420 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmt420_init()   
 
      #進入選單 Menu (="N")
      CALL apmt420_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmt420
      
   END IF 
   
   CLOSE apmt420_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmt420.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmt420_init()
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
      CALL cl_set_combo_scc_part('pmdfstus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdg004,pmdg004_desc",FALSE)
   END IF
   
   #若是[P:一般採購詢價作業]時，單身的[C:作業編號]、[C:製程序]兩個欄位必須隱藏
   IF g_argv[1] = '1' THEN   #一般採購
      CALL cl_set_comp_visible("pmdg014,pmdg014_desc,pmdg015",FALSE)
   END IF
   #161031-00025#10----s
   #子程式畫面取代主程式元件
   CALL cl_ui_replace_sub_window(cl_ap_formpath("aoo", "aooi360_01"), "grid_memo", "Table", "s_detail1_aooi360_01")
   CALL cl_set_combo_scc_part('ooff012','11','1,2,4')
   CALL cl_set_comp_visible("ooff003",FALSE)
   #161031-00025#10---e
   #end add-point
   
   #初始化搜尋條件
   CALL apmt420_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="apmt420.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION apmt420_ui_dialog()
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
            CALL apmt420_insert()
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
         INITIALIZE g_pmdf_m.* TO NULL
         CALL g_pmdg_d.clear()
         CALL g_pmdg2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL apmt420_init()
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
               
               CALL apmt420_fetch('') # reload data
               LET l_ac = 1
               CALL apmt420_ui_detailshow() #Setting the current row 
         
               CALL apmt420_idx_chk()
               #NEXT FIELD pmdgseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_pmdg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt420_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL apmt420_b_fill2('2')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               #add by lixiang 2016/1/13---begin---
               CALL apmt420_set_act_visible_b()
               CALL apmt420_set_act_no_visible_b()
               #add by lixiang 2016/1/13---end----
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
               CALL apmt420_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_pmdg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL apmt420_idx_chk()
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
               CALL apmt420_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #单头备注显示
         SUBDIALOG aoo_aooi360_01.aooi360_01_display     #161031-00025#10 add     
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL apmt420_browser_fill("")
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
               CALL apmt420_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL apmt420_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL apmt420_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         #161031-00025#10---s
         ON ACTION remarks_page
            LET g_detail_id = "remarks_page"
            NEXT FIELD ooff012
         #161031-00025#10---e
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL apmt420_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL apmt420_set_act_visible()   
            CALL apmt420_set_act_no_visible()
            IF NOT (g_pmdf_m.pmdfdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " pmdfent = " ||g_enterprise|| " AND",
                                  " pmdfdocno = '", g_pmdf_m.pmdfdocno, "' "
 
               #填到對應位置
               CALL apmt420_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "pmdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdg_t" 
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
               CALL apmt420_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "pmdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "pmdg_t" 
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
                  CALL apmt420_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL apmt420_fetch("F")
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
               CALL apmt420_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL apmt420_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt420_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL apmt420_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt420_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL apmt420_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt420_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL apmt420_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt420_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL apmt420_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL apmt420_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_pmdg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_pmdg2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161031-00025#10---s
                  LET g_export_node[3] = base.typeInfo.create(g_ooff_d4)
                  LET g_export_id[3]   = "s_detail1_aooi360_01"
                  #161031-00025#10---e     
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
               NEXT FIELD pmdgseq
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
               CALL apmt420_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL apmt420_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL apmt420_delete()
               #add-point:ON ACTION delete name="menu.delete"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmt420_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL apmr420_g01("pmdfent ="|| g_enterprise ||" AND pmdfdocno ='"|| g_pmdf_m.pmdfdocno||"'")
               LET g_rep_wc = "pmdfent ="|| g_enterprise ||" AND pmdfdocno ='"|| g_pmdf_m.pmdfdocno||"'"
               #END add-point
               &include "erp/apm/apmt420_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL apmr420_g01("pmdfent ="|| g_enterprise ||" AND pmdfdocno ='"|| g_pmdf_m.pmdfdocno||"'")
               LET g_rep_wc = "pmdfent ="|| g_enterprise ||" AND pmdfdocno ='"|| g_pmdf_m.pmdfdocno||"'"
               #END add-point
               &include "erp/apm/apmt420_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL apmt420_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL apmt420_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION memo
            LET g_action_choice="memo"
            IF cl_auth_chk_act("memo") THEN
               
               #add-point:ON ACTION memo name="menu.memo"
               #161031-00025#10---s
#               CALL aooi360_02('6',g_prog,g_pmdf_m.pmdfdocno,'','','','','','','','','')
               IF NOT cl_null(g_pmdf_m.pmdfdocno) THEN
                  CALL apmt420_memos()
               END IF
               #161031-00025#10---e
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_apmt420_01
            LET g_action_choice="open_apmt420_01"
            IF cl_auth_chk_act("open_apmt420_01") THEN
               
               #add-point:ON ACTION open_apmt420_01 name="menu.open_apmt420_01"
               IF l_ac > 0 THEN   #防止數組溢出錯誤
                  IF g_pmdg_d[l_ac].pmdg009 = 'Y' AND NOT cl_null(g_pmdf_m.pmdfdocno) AND NOT cl_null(g_pmdg_d[l_ac].pmdgseq) THEN
                     CALL apmt420_01('2',g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg007,g_pmdg_d[l_ac].pmdg008)
                     CALL apmt420_show()
                  END IF
                END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL apmt420_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL apmt420_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL apmt420_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_pmdf_m.pmdfdocdt)
 
 
 
         
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
 
{<section id="apmt420.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION apmt420_browser_fill(ps_page_action)
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
   #161031-00025#10---s
   IF cl_null(g_add_browse) THEN
      CALL aooi360_01_clear_detail()   #清除备注单身
   END IF
   #161031-00025#10---e
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
   #IF cl_null(g_wc) OR g_wc = " 1=1" THEN
   IF cl_null(g_wc) THEN
      IF g_argv[1] = '1' THEN
         LET g_wc = " pmdf001 = 'N' "
      END IF
      IF g_argv[1] = '2' THEN
         LET g_wc = " pmdf001 = 'Y' "
      END IF
   ELSE
      IF g_argv[1] = '1' THEN
         LET g_wc = g_wc, " AND pmdf001 = 'N' "
      END IF
      IF g_argv[1] = '2' THEN
         LET g_wc = g_wc, " AND pmdf001 = 'Y' "
      END IF
   END IF
   
   LET g_wc = g_wc, " AND pmdfsite = '",g_site,"' "
   
   LET l_wc  = g_wc.trim()
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT pmdfdocno ",
                      " FROM pmdf_t ",
                      " ",
                      " LEFT JOIN pmdg_t ON pmdgent = pmdfent AND pmdfdocno = pmdgdocno ", "  ",
                      #add-point:browser_fill段sql(pmdg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN pmdh_t ON pmdhent = pmdfent AND pmdgdocno = pmdhdocno AND pmdgseq = pmdhseq", "  ",
                      #add-point:browser_fill段sql(pmdh_t1) name="browser_fill.cnt.join.pmdh_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE pmdfent = " ||g_enterprise|| " AND pmdgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("pmdf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT pmdfdocno ",
                      " FROM pmdf_t ", 
                      "  ",
                      "  ",
                      " WHERE pmdfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("pmdf_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   #161031-00025#10---s
   IF NOT cl_null(g_wc2_i36001) AND g_wc2_i36001 <> " 1=1" THEN
      LET l_sub_sql = l_sub_sql CLIPPED, " AND pmdfdocno IN ( SELECT ooff003 FROM ooff_t WHERE ooffent = ",g_enterprise," AND ooff001 = '6' AND ooff003= 0 AND ",g_wc2_i36001 CLIPPED ,")"
   END IF
   #161031-00025#10---e
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
      INITIALIZE g_pmdf_m.* TO NULL
      CALL g_pmdg_d.clear()        
      CALL g_pmdg2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.pmdfdocno,t0.pmdfdocdt,t0.pmdf002,t0.pmdf003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdfstus,t0.pmdfdocno,t0.pmdfdocdt,t0.pmdf002,t0.pmdf003,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM pmdf_t t0",
                  "  ",
                  "  LEFT JOIN pmdg_t ON pmdgent = pmdfent AND pmdfdocno = pmdgdocno ", "  ", 
                  #add-point:browser_fill段sql(pmdg_t1) name="browser_fill.join.pmdg_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN pmdh_t ON pmdhent = pmdfent AND pmdgdocno = pmdhdocno AND pmdgseq = pmdhseq", "  ", 
                  #add-point:browser_fill段sql(pmdh_t1) name="browser_fill.join.pmdh_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmdf002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmdf003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdfent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("pmdf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.pmdfstus,t0.pmdfdocno,t0.pmdfdocdt,t0.pmdf002,t0.pmdf003,t1.ooag011 , 
          t2.ooefl003 ",
                  " FROM pmdf_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.pmdf002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.pmdf003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.pmdfent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("pmdf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY pmdfdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"pmdf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_pmdfdocno,g_browser[g_cnt].b_pmdfdocdt, 
          g_browser[g_cnt].b_pmdf002,g_browser[g_cnt].b_pmdf003,g_browser[g_cnt].b_pmdf002_desc,g_browser[g_cnt].b_pmdf003_desc 
 
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
         CALL apmt420_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_pmdfdocno) THEN
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
 
{<section id="apmt420.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION apmt420_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_pmdf_m.pmdfdocno = g_browser[g_current_idx].b_pmdfdocno   
 
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
   CALL apmt420_pmdf_t_mask()
   CALL apmt420_show()
      
END FUNCTION
 
{</section>}
 
{<section id="apmt420.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION apmt420_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION apmt420_ui_browser_refresh()
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
      IF g_browser[l_i].b_pmdfdocno = g_pmdf_m.pmdfdocno 
 
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
 
{<section id="apmt420.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmt420_construct()
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
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#10
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_pmdf_m.* TO NULL
   CALL g_pmdg_d.clear()        
   CALL g_pmdg2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON pmdf001,pmdfsite,pmdfdocno,pmdfdocno_desc,pmdfdocdt,pmdf004,pmdf002, 
          pmdf003,pmdfstus,pmdf005,pmdf006,pmdf007,pmdf008,pmdf009,pmdf010,pmdf030,pmdfownid,pmdfowndp, 
          pmdfcrtid,pmdfcrtdp,pmdfcrtdt,pmdfmodid,pmdfmoddt,pmdfcnfid,pmdfcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<pmdfcrtdt>>----
         AFTER FIELD pmdfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<pmdfmoddt>>----
         AFTER FIELD pmdfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdfcnfdt>>----
         AFTER FIELD pmdfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<pmdfpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf001
            #add-point:BEFORE FIELD pmdf001 name="construct.b.pmdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf001
            
            #add-point:AFTER FIELD pmdf001 name="construct.a.pmdf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf001
            #add-point:ON ACTION controlp INFIELD pmdf001 name="construct.c.pmdf001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfsite
            #add-point:BEFORE FIELD pmdfsite name="construct.b.pmdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfsite
            
            #add-point:AFTER FIELD pmdfsite name="construct.a.pmdfsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfsite
            #add-point:ON ACTION controlp INFIELD pmdfsite name="construct.c.pmdfsite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfdocno
            #add-point:ON ACTION controlp INFIELD pmdfdocno name="construct.c.pmdfdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmdfdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfdocno  #顯示到畫面上

            NEXT FIELD pmdfdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfdocno
            #add-point:BEFORE FIELD pmdfdocno name="construct.b.pmdfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfdocno
            
            #add-point:AFTER FIELD pmdfdocno name="construct.a.pmdfdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfdocno_desc
            #add-point:BEFORE FIELD pmdfdocno_desc name="construct.b.pmdfdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfdocno_desc
            
            #add-point:AFTER FIELD pmdfdocno_desc name="construct.a.pmdfdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfdocno_desc
            #add-point:ON ACTION controlp INFIELD pmdfdocno_desc name="construct.c.pmdfdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfdocdt
            #add-point:BEFORE FIELD pmdfdocdt name="construct.b.pmdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfdocdt
            
            #add-point:AFTER FIELD pmdfdocdt name="construct.a.pmdfdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfdocdt
            #add-point:ON ACTION controlp INFIELD pmdfdocdt name="construct.c.pmdfdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf004
            #add-point:ON ACTION controlp INFIELD pmdf004 name="construct.c.pmdf004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf004  #顯示到畫面上

            NEXT FIELD pmdf004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf004
            #add-point:BEFORE FIELD pmdf004 name="construct.b.pmdf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf004
            
            #add-point:AFTER FIELD pmdf004 name="construct.a.pmdf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf002
            #add-point:ON ACTION controlp INFIELD pmdf002 name="construct.c.pmdf002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf002  #顯示到畫面上

            NEXT FIELD pmdf002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf002
            #add-point:BEFORE FIELD pmdf002 name="construct.b.pmdf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf002
            
            #add-point:AFTER FIELD pmdf002 name="construct.a.pmdf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf003
            #add-point:ON ACTION controlp INFIELD pmdf003 name="construct.c.pmdf003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf003  #顯示到畫面上

            NEXT FIELD pmdf003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf003
            #add-point:BEFORE FIELD pmdf003 name="construct.b.pmdf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf003
            
            #add-point:AFTER FIELD pmdf003 name="construct.a.pmdf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfstus
            #add-point:BEFORE FIELD pmdfstus name="construct.b.pmdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfstus
            
            #add-point:AFTER FIELD pmdfstus name="construct.a.pmdfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfstus
            #add-point:ON ACTION controlp INFIELD pmdfstus name="construct.c.pmdfstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf005
            #add-point:ON ACTION controlp INFIELD pmdf005 name="construct.c.pmdf005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf005  #顯示到畫面上

            NEXT FIELD pmdf005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf005
            #add-point:BEFORE FIELD pmdf005 name="construct.b.pmdf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf005
            
            #add-point:AFTER FIELD pmdf005 name="construct.a.pmdf005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf006
            #add-point:ON ACTION controlp INFIELD pmdf006 name="construct.c.pmdf006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf006  #顯示到畫面上

            NEXT FIELD pmdf006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf006
            #add-point:BEFORE FIELD pmdf006 name="construct.b.pmdf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf006
            
            #add-point:AFTER FIELD pmdf006 name="construct.a.pmdf006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf007
            #add-point:BEFORE FIELD pmdf007 name="construct.b.pmdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf007
            
            #add-point:AFTER FIELD pmdf007 name="construct.a.pmdf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf007
            #add-point:ON ACTION controlp INFIELD pmdf007 name="construct.c.pmdf007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf008
            #add-point:BEFORE FIELD pmdf008 name="construct.b.pmdf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf008
            
            #add-point:AFTER FIELD pmdf008 name="construct.a.pmdf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf008
            #add-point:ON ACTION controlp INFIELD pmdf008 name="construct.c.pmdf008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf009
            #add-point:ON ACTION controlp INFIELD pmdf009 name="construct.c.pmdf009"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooib002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf009  #顯示到畫面上

            NEXT FIELD pmdf009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf009
            #add-point:BEFORE FIELD pmdf009 name="construct.b.pmdf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf009
            
            #add-point:AFTER FIELD pmdf009 name="construct.a.pmdf009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf010
            #add-point:ON ACTION controlp INFIELD pmdf010 name="construct.c.pmdf010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '238'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdf010  #顯示到畫面上

            NEXT FIELD pmdf010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf010
            #add-point:BEFORE FIELD pmdf010 name="construct.b.pmdf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf010
            
            #add-point:AFTER FIELD pmdf010 name="construct.a.pmdf010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf030
            #add-point:BEFORE FIELD pmdf030 name="construct.b.pmdf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf030
            
            #add-point:AFTER FIELD pmdf030 name="construct.a.pmdf030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf030
            #add-point:ON ACTION controlp INFIELD pmdf030 name="construct.c.pmdf030"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfownid
            #add-point:ON ACTION controlp INFIELD pmdfownid name="construct.c.pmdfownid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfownid  #顯示到畫面上

            NEXT FIELD pmdfownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfownid
            #add-point:BEFORE FIELD pmdfownid name="construct.b.pmdfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfownid
            
            #add-point:AFTER FIELD pmdfownid name="construct.a.pmdfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfowndp
            #add-point:ON ACTION controlp INFIELD pmdfowndp name="construct.c.pmdfowndp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfowndp  #顯示到畫面上

            NEXT FIELD pmdfowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfowndp
            #add-point:BEFORE FIELD pmdfowndp name="construct.b.pmdfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfowndp
            
            #add-point:AFTER FIELD pmdfowndp name="construct.a.pmdfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfcrtid
            #add-point:ON ACTION controlp INFIELD pmdfcrtid name="construct.c.pmdfcrtid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfcrtid  #顯示到畫面上

            NEXT FIELD pmdfcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfcrtid
            #add-point:BEFORE FIELD pmdfcrtid name="construct.b.pmdfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfcrtid
            
            #add-point:AFTER FIELD pmdfcrtid name="construct.a.pmdfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmdfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfcrtdp
            #add-point:ON ACTION controlp INFIELD pmdfcrtdp name="construct.c.pmdfcrtdp"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfcrtdp  #顯示到畫面上

            NEXT FIELD pmdfcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfcrtdp
            #add-point:BEFORE FIELD pmdfcrtdp name="construct.b.pmdfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfcrtdp
            
            #add-point:AFTER FIELD pmdfcrtdp name="construct.a.pmdfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfcrtdt
            #add-point:BEFORE FIELD pmdfcrtdt name="construct.b.pmdfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfmodid
            #add-point:ON ACTION controlp INFIELD pmdfmodid name="construct.c.pmdfmodid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfmodid  #顯示到畫面上

            NEXT FIELD pmdfmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfmodid
            #add-point:BEFORE FIELD pmdfmodid name="construct.b.pmdfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfmodid
            
            #add-point:AFTER FIELD pmdfmodid name="construct.a.pmdfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfmoddt
            #add-point:BEFORE FIELD pmdfmoddt name="construct.b.pmdfmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmdfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfcnfid
            #add-point:ON ACTION controlp INFIELD pmdfcnfid name="construct.c.pmdfcnfid"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdfcnfid  #顯示到畫面上

            NEXT FIELD pmdfcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfcnfid
            #add-point:BEFORE FIELD pmdfcnfid name="construct.b.pmdfcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfcnfid
            
            #add-point:AFTER FIELD pmdfcnfid name="construct.a.pmdfcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfcnfdt
            #add-point:BEFORE FIELD pmdfcnfdt name="construct.b.pmdfcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON pmdg001,pmdgseq,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014,pmdg015,pmdg008, 
          pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030,ooff013
           FROM s_detail1[1].pmdg001,s_detail1[1].pmdgseq,s_detail1[1].pmdg002,s_detail1[1].pmdg003, 
               s_detail1[1].pmdg004,s_detail1[1].pmdg005,s_detail1[1].pmdg014,s_detail1[1].pmdg015,s_detail1[1].pmdg008, 
               s_detail1[1].pmdg007,s_detail1[1].pmdg009,s_detail1[1].pmdg010,s_detail1[1].pmdg018,s_detail1[1].pmdg011, 
               s_detail1[1].pmdg012,s_detail1[1].pmdg013,s_detail1[1].pmdg017,s_detail1[1].pmdg016,s_detail1[1].pmdg030, 
               s_detail1[1].ooff013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg001
            #add-point:BEFORE FIELD pmdg001 name="construct.b.page1.pmdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg001
            
            #add-point:AFTER FIELD pmdg001 name="construct.a.page1.pmdg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg001
            #add-point:ON ACTION controlp INFIELD pmdg001 name="construct.c.page1.pmdg001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdgseq
            #add-point:BEFORE FIELD pmdgseq name="construct.b.page1.pmdgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdgseq
            
            #add-point:AFTER FIELD pmdgseq name="construct.a.page1.pmdgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdgseq
            #add-point:ON ACTION controlp INFIELD pmdgseq name="construct.c.page1.pmdgseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg002
            #add-point:ON ACTION controlp INFIELD pmdg002 name="construct.c.page1.pmdg002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg002  #顯示到畫面上

            NEXT FIELD pmdg002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg002
            #add-point:BEFORE FIELD pmdg002 name="construct.b.page1.pmdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg002
            
            #add-point:AFTER FIELD pmdg002 name="construct.a.page1.pmdg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg003
            #add-point:ON ACTION controlp INFIELD pmdg003 name="construct.c.page1.pmdg003"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg003  #顯示到畫面上

            NEXT FIELD pmdg003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg003
            #add-point:BEFORE FIELD pmdg003 name="construct.b.page1.pmdg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg003
            
            #add-point:AFTER FIELD pmdg003 name="construct.a.page1.pmdg003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg004
            #add-point:BEFORE FIELD pmdg004 name="construct.b.page1.pmdg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg004
            
            #add-point:AFTER FIELD pmdg004 name="construct.a.page1.pmdg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg004
            #add-point:ON ACTION controlp INFIELD pmdg004 name="construct.c.page1.pmdg004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg005
            #add-point:ON ACTION controlp INFIELD pmdg005 name="construct.c.page1.pmdg005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaf001_12()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg005  #顯示到畫面上
             
            NEXT FIELD pmdg005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg005
            #add-point:BEFORE FIELD pmdg005 name="construct.b.page1.pmdg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg005
            
            #add-point:AFTER FIELD pmdg005 name="construct.a.page1.pmdg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg014
            #add-point:ON ACTION controlp INFIELD pmdg014 name="construct.c.page1.pmdg014"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '221'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg014  #顯示到畫面上

            NEXT FIELD pmdg014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg014
            #add-point:BEFORE FIELD pmdg014 name="construct.b.page1.pmdg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg014
            
            #add-point:AFTER FIELD pmdg014 name="construct.a.page1.pmdg014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg015
            #add-point:BEFORE FIELD pmdg015 name="construct.b.page1.pmdg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg015
            
            #add-point:AFTER FIELD pmdg015 name="construct.a.page1.pmdg015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg015
            #add-point:ON ACTION controlp INFIELD pmdg015 name="construct.c.page1.pmdg015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg008
            #add-point:ON ACTION controlp INFIELD pmdg008 name="construct.c.page1.pmdg008"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg008  #顯示到畫面上

            NEXT FIELD pmdg008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg008
            #add-point:BEFORE FIELD pmdg008 name="construct.b.page1.pmdg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg008
            
            #add-point:AFTER FIELD pmdg008 name="construct.a.page1.pmdg008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg007
            #add-point:BEFORE FIELD pmdg007 name="construct.b.page1.pmdg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg007
            
            #add-point:AFTER FIELD pmdg007 name="construct.a.page1.pmdg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg007
            #add-point:ON ACTION controlp INFIELD pmdg007 name="construct.c.page1.pmdg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg009
            #add-point:BEFORE FIELD pmdg009 name="construct.b.page1.pmdg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg009
            
            #add-point:AFTER FIELD pmdg009 name="construct.a.page1.pmdg009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg009
            #add-point:ON ACTION controlp INFIELD pmdg009 name="construct.c.page1.pmdg009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg010
            #add-point:BEFORE FIELD pmdg010 name="construct.b.page1.pmdg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg010
            
            #add-point:AFTER FIELD pmdg010 name="construct.a.page1.pmdg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg010
            #add-point:ON ACTION controlp INFIELD pmdg010 name="construct.c.page1.pmdg010"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg018
            #add-point:ON ACTION controlp INFIELD pmdg018 name="construct.c.page1.pmdg018"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg018  #顯示到畫面上

            NEXT FIELD pmdg018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg018
            #add-point:BEFORE FIELD pmdg018 name="construct.b.page1.pmdg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg018
            
            #add-point:AFTER FIELD pmdg018 name="construct.a.page1.pmdg018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg011
            #add-point:BEFORE FIELD pmdg011 name="construct.b.page1.pmdg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg011
            
            #add-point:AFTER FIELD pmdg011 name="construct.a.page1.pmdg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg011
            #add-point:ON ACTION controlp INFIELD pmdg011 name="construct.c.page1.pmdg011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg012
            #add-point:BEFORE FIELD pmdg012 name="construct.b.page1.pmdg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg012
            
            #add-point:AFTER FIELD pmdg012 name="construct.a.page1.pmdg012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg012
            #add-point:ON ACTION controlp INFIELD pmdg012 name="construct.c.page1.pmdg012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg013
            #add-point:BEFORE FIELD pmdg013 name="construct.b.page1.pmdg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg013
            
            #add-point:AFTER FIELD pmdg013 name="construct.a.page1.pmdg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg013
            #add-point:ON ACTION controlp INFIELD pmdg013 name="construct.c.page1.pmdg013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg017
            #add-point:BEFORE FIELD pmdg017 name="construct.b.page1.pmdg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg017
            
            #add-point:AFTER FIELD pmdg017 name="construct.a.page1.pmdg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg017
            #add-point:ON ACTION controlp INFIELD pmdg017 name="construct.c.page1.pmdg017"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.pmdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg016
            #add-point:ON ACTION controlp INFIELD pmdg016 name="construct.c.page1.pmdg016"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '263'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmdg016  #顯示到畫面上

            NEXT FIELD pmdg016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg016
            #add-point:BEFORE FIELD pmdg016 name="construct.b.page1.pmdg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg016
            
            #add-point:AFTER FIELD pmdg016 name="construct.a.page1.pmdg016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg030
            #add-point:BEFORE FIELD pmdg030 name="construct.b.page1.pmdg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg030
            
            #add-point:AFTER FIELD pmdg030 name="construct.a.page1.pmdg030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.pmdg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg030
            #add-point:ON ACTION controlp INFIELD pmdg030 name="construct.c.page1.pmdg030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="construct.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="construct.a.page1.ooff013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="construct.c.page1.ooff013"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON NULL
           FROM NULL
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD seq
            #add-point:BEFORE FIELD seq name="construct.b.page2.seq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD seq
            
            #add-point:AFTER FIELD seq name="construct.a.page2.seq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.seq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD seq
            #add-point:ON ACTION controlp INFIELD seq name="construct.c.page2.seq"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      SUBDIALOG aoo_aooi360_01.aooi360_01_construct   #备注单身  #161031-00025#10
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
                  WHEN la_wc[li_idx].tableid = "pmdf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "pmdg_t" 
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
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION apmt420_filter()
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
      CONSTRUCT g_wc_filter ON pmdfdocno,pmdfdocdt,pmdf002,pmdf003
                          FROM s_browse[1].b_pmdfdocno,s_browse[1].b_pmdfdocdt,s_browse[1].b_pmdf002, 
                              s_browse[1].b_pmdf003
 
         BEFORE CONSTRUCT
               DISPLAY apmt420_filter_parser('pmdfdocno') TO s_browse[1].b_pmdfdocno
            DISPLAY apmt420_filter_parser('pmdfdocdt') TO s_browse[1].b_pmdfdocdt
            DISPLAY apmt420_filter_parser('pmdf002') TO s_browse[1].b_pmdf002
            DISPLAY apmt420_filter_parser('pmdf003') TO s_browse[1].b_pmdf003
      
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
 
      CALL apmt420_filter_show('pmdfdocno')
   CALL apmt420_filter_show('pmdfdocdt')
   CALL apmt420_filter_show('pmdf002')
   CALL apmt420_filter_show('pmdf003')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION apmt420_filter_parser(ps_field)
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
 
{<section id="apmt420.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION apmt420_filter_show(ps_field)
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
   LET ls_condition = apmt420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION apmt420_query()
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
   CALL g_pmdg_d.clear()
   CALL g_pmdg2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#10
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL apmt420_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL apmt420_browser_fill("")
      CALL apmt420_fetch("")
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
      CALL apmt420_filter_show('pmdfdocno')
   CALL apmt420_filter_show('pmdfdocdt')
   CALL apmt420_filter_show('pmdf002')
   CALL apmt420_filter_show('pmdf003')
   CALL apmt420_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL apmt420_fetch("F") 
      #顯示單身筆數
      CALL apmt420_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION apmt420_fetch(p_flag)
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
   CALL g_pmdg2_d.clear()
 
   
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
   
   LET g_pmdf_m.pmdfdocno = g_browser[g_current_idx].b_pmdfdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
   #遮罩相關處理
   LET g_pmdf_m_mask_o.* =  g_pmdf_m.*
   CALL apmt420_pmdf_t_mask()
   LET g_pmdf_m_mask_n.* =  g_pmdf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt420_set_act_visible()   
   CALL apmt420_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   IF g_pmdf_m.pmdfstus NOT MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改 2015-5-27 zhujing mod
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF      
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_pmdf_m_t.* = g_pmdf_m.*
   LET g_pmdf_m_o.* = g_pmdf_m.*
   
   LET g_data_owner = g_pmdf_m.pmdfownid      
   LET g_data_dept  = g_pmdf_m.pmdfowndp
   
   #重新顯示   
   CALL apmt420_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.insert" >}
#+ 資料新增
PRIVATE FUNCTION apmt420_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_pmdg_d.clear()   
   CALL g_pmdg2_d.clear()  
 
 
   INITIALIZE g_pmdf_m.* TO NULL             #DEFAULT 設定
   
   LET g_pmdfdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL aooi360_01_clear_detail()   #清除备注单身  #161031-00025#10
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdf_m.pmdfownid = g_user
      LET g_pmdf_m.pmdfowndp = g_dept
      LET g_pmdf_m.pmdfcrtid = g_user
      LET g_pmdf_m.pmdfcrtdp = g_dept 
      LET g_pmdf_m.pmdfcrtdt = cl_get_current()
      LET g_pmdf_m.pmdfmodid = g_user
      LET g_pmdf_m.pmdfmoddt = cl_get_current()
      LET g_pmdf_m.pmdfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_pmdf_m.pmdfstus = "N"
 
  
      #add-point:單頭預設值 name="insert.default"
     
      LET g_pmdf_m.pmdfsite = g_site
      LET g_pmdf_m.pmdfdocdt = g_today
      LET g_pmdf_m.pmdf002 = g_user
      LET g_pmdf_m.pmdf003 = g_dept
      CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
      DISPLAY BY NAME g_pmdf_m.pmdf002_desc
      
      CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
      DISPLAY BY NAME g_pmdf_m.pmdf003_desc
      
      #若是[P:一般採購詢價作業]在新增時[C:委外否(pmdf001)]預設為'N'
      #若是[P:委外採購詢價作業]在新增時[C:委外否(pmdf001)]預設為'Y'
      IF g_argv[1] = '1' THEN
         LET g_pmdf_m.pmdf001 = 'N'
      END IF
      IF g_argv[1] = '2' THEN
         LET g_pmdf_m.pmdf001 = 'Y'
      END IF
      #161031-00025#10---s
      LET g_ooff001_d = '6'   #6.單據單頭備註
      LET g_ooff002_d = g_prog
      LET g_ooff003_d = ''    #单号
      LET g_ooff004_d = 0     #项次
      LET g_ooff005_d = ' '
      LET g_ooff006_d = ' '
      LET g_ooff007_d = ' '
      LET g_ooff008_d = ' '
      LET g_ooff009_d = ' '
      LET g_ooff010_d = ' '
      LET g_ooff011_d = ' '
      #161031-00025#10---e
      INITIALIZE g_pmdf_m_t.* TO NULL
      LET g_pmdf_m_t.* = g_pmdf_m.*
      
      LET g_flag = FALSE  #標記單據別是否已編號，如果已編號，則單據編號、單據日期欄位不可以錄入
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_pmdf_m_t.* = g_pmdf_m.*
      LET g_pmdf_m_o.* = g_pmdf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdf_m.pmdfstus 
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
 
 
 
    
      CALL apmt420_input("a")
      
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
         INITIALIZE g_pmdf_m.* TO NULL
         INITIALIZE g_pmdg_d TO NULL
         INITIALIZE g_pmdg2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL apmt420_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_pmdg_d.clear()
      #CALL g_pmdg2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL apmt420_set_act_visible()   
   CALL apmt420_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdfent = " ||g_enterprise|| " AND",
                      " pmdfdocno = '", g_pmdf_m.pmdfdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt420_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE apmt420_cl
   
   CALL apmt420_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
   
   #遮罩相關處理
   LET g_pmdf_m_mask_o.* =  g_pmdf_m.*
   CALL apmt420_pmdf_t_mask()
   LET g_pmdf_m_mask_n.* =  g_pmdf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc,g_pmdf_m.pmdfdocdt, 
       g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003, 
       g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf006, 
       g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfownid_desc, 
       g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfmoddt, 
       g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_pmdf_m.pmdfownid      
   LET g_data_dept  = g_pmdf_m.pmdfowndp
   
   #功能已完成,通報訊息中心
   CALL apmt420_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.modify" >}
#+ 資料修改
PRIVATE FUNCTION apmt420_modify()
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
   LET g_pmdf_m_t.* = g_pmdf_m.*
   LET g_pmdf_m_o.* = g_pmdf_m.*
   
   IF g_pmdf_m.pmdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
   CALL s_transaction_begin()
   
   OPEN apmt420_cl USING g_enterprise,g_pmdf_m.pmdfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt420_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt420_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
   #檢查是否允許此動作
   IF NOT apmt420_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdf_m_mask_o.* =  g_pmdf_m.*
   CALL apmt420_pmdf_t_mask()
   LET g_pmdf_m_mask_n.* =  g_pmdf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL apmt420_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_pmdf_m.pmdfmodid = g_user 
LET g_pmdf_m.pmdfmoddt = cl_get_current()
LET g_pmdf_m.pmdfmodid_desc = cl_get_username(g_pmdf_m.pmdfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_pmdf_m.pmdfstus MATCHES "[DR]" THEN 
         LET g_pmdf_m.pmdfstus = "N"
      END IF

      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL apmt420_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE pmdf_t SET (pmdfmodid,pmdfmoddt) = (g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt)
          WHERE pmdfent = g_enterprise AND pmdfdocno = g_pmdfdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_pmdf_m.* = g_pmdf_m_t.*
            CALL apmt420_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_pmdf_m.pmdfdocno != g_pmdf_m_t.pmdfdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE pmdg_t SET pmdgdocno = g_pmdf_m.pmdfdocno
 
          WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m_t.pmdfdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "pmdg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
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
         UPDATE pmdh_t
            SET pmdhdocno = g_pmdf_m.pmdfdocno
 
          WHERE pmdhent = g_enterprise AND
                pmdhdocno = g_pmdfdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdh_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
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
   CALL apmt420_set_act_visible()   
   CALL apmt420_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " pmdfent = " ||g_enterprise|| " AND",
                      " pmdfdocno = '", g_pmdf_m.pmdfdocno, "' "
 
   #填到對應位置
   CALL apmt420_browser_fill("")
 
   CLOSE apmt420_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt420_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="apmt420.input" >}
#+ 資料輸入
PRIVATE FUNCTION apmt420_input(p_cmd)
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
   DEFINE  l_ooef019       LIKE ooef_t.ooef019
   DEFINE  l_success       LIKE type_t.num5
   DEFINE  l_flag          LIKE type_t.num5
   DEFINE  l_pmdg010       LIKE pmdg_t.pmdg010
   DEFINE  l_pmdgseq       LIKE pmdg_t.pmdgseq
   DEFINE  l_pmdh001       LIKE pmdh_t.pmdh001
   DEFINE  l_pmdh002       LIKE pmdh_t.pmdh002
   DEFINE  l_pmdhseq       LIKE pmdh_t.pmdhseq
   DEFINE  l_pmdh003       LIKE pmdh_t.pmdh003
   
   DEFINE  l_ooba002       LIKE ooba_t.ooba002
   DEFINE  l_site          LIKE ooef_t.ooef001
   DEFINE  l_ooba014       LIKE ooba_t.ooba014
   DEFINE  l_sql1          STRING
   DEFINE  l_sql2          STRING
   DEFINE  l_sql           STRING
   DEFINE  l_pmab039       LIKE pmab_t.pmab039
   DEFINE  l_oodb005       LIKE oodb_t.oodb005
   DEFINE  l_inam          DYNAMIC ARRAY OF RECORD   #記錄產品特徵
              inam001      LIKE inam_t.inam001,
              inam002      LIKE inam_t.inam002,
              inam004      LIKE inam_t.inam004
                        END RECORD
   DEFINE l_imaa005        LIKE imaa_t.imaa005
   #161124-00048#9 mod-S
#   DEFINE l_pmdg           RECORD LIKE pmdg_t.*
   DEFINE l_pmdg RECORD  #詢價單明細檔
          pmdgent LIKE pmdg_t.pmdgent, #企业编号
          pmdgsite LIKE pmdg_t.pmdgsite, #营运据点
          pmdgdocno LIKE pmdg_t.pmdgdocno, #询价单号
          pmdgseq LIKE pmdg_t.pmdgseq, #项次
          pmdg001 LIKE pmdg_t.pmdg001, #委外否
          pmdg002 LIKE pmdg_t.pmdg002, #供应商编号
          pmdg003 LIKE pmdg_t.pmdg003, #料件编号
          pmdg004 LIKE pmdg_t.pmdg004, #产品特征
          pmdg005 LIKE pmdg_t.pmdg005, #包装容器
          pmdg007 LIKE pmdg_t.pmdg007, #询价数量
          pmdg008 LIKE pmdg_t.pmdg008, #询价单位
          pmdg009 LIKE pmdg_t.pmdg009, #分量计价否
          pmdg010 LIKE pmdg_t.pmdg010, #单价
          pmdg011 LIKE pmdg_t.pmdg011, #税率
          pmdg012 LIKE pmdg_t.pmdg012, #折扣率
          pmdg013 LIKE pmdg_t.pmdg013, #最低采购量
          pmdg014 LIKE pmdg_t.pmdg014, #作业编号
          pmdg015 LIKE pmdg_t.pmdg015, #作业序
          pmdg016 LIKE pmdg_t.pmdg016, #运输方式
          pmdg017 LIKE pmdg_t.pmdg017, #有效日期
          pmdg018 LIKE pmdg_t.pmdg018, #税种
          pmdg030 LIKE pmdg_t.pmdg030  #备注
   END RECORD
   #161124-00048#9 mod-E
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
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc,g_pmdf_m.pmdfdocdt, 
       g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003, 
       g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf006, 
       g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfownid_desc, 
       g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfmoddt, 
       g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
   
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
   LET g_forupd_sql = "SELECT pmdgsite,pmdg001,pmdgseq,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014,pmdg015, 
       pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030 FROM  
       pmdg_t WHERE pmdgent=? AND pmdgdocno=? AND pmdgseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt420_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT pmdh001,pmdh002,pmdh003,pmdh004 FROM pmdh_t WHERE pmdhent=? AND pmdhdocno=?  
       AND pmdhseq=? AND pmdh001=? AND pmdh002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmt420_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL apmt420_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   #將單身輸入權限放入共用變數給嵌入的子程式用, 若子程式要自己控管, 還是可以從子程式中覆蓋掉值
   #161031-00025#10---s
   LET g_detail_insert = l_allow_insert
   LET g_detail_delete = l_allow_delete
   #161031-00025#10---e
   #end add-point
   CALL apmt420_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004, 
       g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007, 
       g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010,g_pmdf_m.pmdf030
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_errshow = 1
   LET g_flag = FALSE  #標記單據別是否已編號，如果已編號，則單據編號、單據日期欄位不可以錄入
   CALL apmt420_set_no_entry(p_cmd)
   CALL apmt420_set_entry(p_cmd)
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="apmt420.input.head" >}
      #單頭段
      INPUT BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004, 
          g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007, 
          g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010,g_pmdf_m.pmdf030 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN apmt420_cl USING g_enterprise,g_pmdf_m.pmdfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt420_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt420_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL apmt420_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            IF l_cmd_t = 'r' THEN
               CALL apmt420_reproduce_init()
            END IF
            #end add-point
            CALL apmt420_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf001
            #add-point:BEFORE FIELD pmdf001 name="input.b.pmdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf001
            
            #add-point:AFTER FIELD pmdf001 name="input.a.pmdf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf001
            #add-point:ON CHANGE pmdf001 name="input.g.pmdf001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfsite
            #add-point:BEFORE FIELD pmdfsite name="input.b.pmdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfsite
            
            #add-point:AFTER FIELD pmdfsite name="input.a.pmdfsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdfsite
            #add-point:ON CHANGE pmdfsite name="input.g.pmdfsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfdocno
            
            #add-point:AFTER FIELD pmdfdocno name="input.a.pmdfdocno"
            #此段落由子樣板a05產生
            #160803-00028#1---s
            #CALL apmt420_get_oobal004(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            CALL s_aooi200_get_slip_desc(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            #160803-00028#1---e
            DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc
            
            IF  NOT cl_null(g_pmdf_m.pmdfdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdf_m.pmdfdocno != g_pmdfdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdf_t WHERE "||"pmdfent = '" ||g_enterprise|| "' AND "||"pmdfdocno = '"||g_pmdf_m.pmdfdocno ||"'",'std-00004',0) THEN 
                     LET g_pmdf_m.pmdfdocno = g_pmdf_m_t.pmdfdocno
                     #160803-00028#1---s
                     #CALL apmt420_get_oobal004(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
                     CALL s_aooi200_get_slip_desc(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
                     #160803-00028#1---e
                     DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_pmdf_m.pmdfdocno,g_prog) THEN
                     LET g_pmdf_m.pmdfdocno = g_pmdf_m_t.pmdfdocno
                     #160803-00028#1---s
                     #CALL apmt420_get_oobal004(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
                     CALL s_aooi200_get_slip_desc(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
                     #160803-00028#1---e
                     DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL apmt420_get_col_default()
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfdocno
            #add-point:BEFORE FIELD pmdfdocno name="input.b.pmdfdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdfdocno
            #add-point:ON CHANGE pmdfdocno name="input.g.pmdfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfdocdt
            #add-point:BEFORE FIELD pmdfdocdt name="input.b.pmdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfdocdt
            
            #add-point:AFTER FIELD pmdfdocdt name="input.a.pmdfdocdt"
            #IF NOT cl_null(g_pmdf_m.pmdfdocdt) THEN
            #   CALL s_aooi200_gen_docno(g_site,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_prog) RETURNING l_success,g_pmdf_m.pmdfdocno
            #   IF NOT l_success THEN
            #      CALL cl_err(g_pmdf_m.pmdfdocno,'apm-00003',1)
            #      LET g_pmdf_m.pmdfdocdt = g_pmdf_m_t.pmdfdocdt
            #      DISPLAY g_pmdf_m.pmdfdocdt TO pmdfdocdt
            #      NEXT FIELD pmdfdocno           
            #   END IF
            #ELSE
            #   NEXT FIELD pmdfdocdt
            #END IF
            #LET g_flag = TRUE
            #CALL apmt420_set_entry(p_cmd)
            #CALL apmt420_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdfdocdt
            #add-point:ON CHANGE pmdfdocdt name="input.g.pmdfdocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf004
            
            #add-point:AFTER FIELD pmdf004 name="input.a.pmdf004"
            CALL apmt420_pmdf004_ref(g_pmdf_m.pmdf004) RETURNING g_pmdf_m.pmdf004_desc
            DISPLAY BY NAME g_pmdf_m.pmdf004_desc
            
            IF NOT cl_null(g_pmdf_m.pmdf004) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdf_m.pmdf004 != g_pmdf_m_t.pmdf004 OR cl_null(g_pmdf_m_t.pmdf004))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdf_m.pmdf004 != g_pmdf_m_o.pmdf004 OR cl_null(g_pmdf_m_o.pmdf004)) THEN    #160824-00007#341 Add By Ken 170106
                  IF NOT apmt420_pmdf004_chk(g_pmdf_m.pmdf004) THEN
                     #LET g_pmdf_m.pmdf004 = g_pmdf_m_t.pmdf004  #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf004 = g_pmdf_m_o.pmdf004   #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdf004_ref(g_pmdf_m.pmdf004) RETURNING g_pmdf_m.pmdf004_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf004_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF g_pmdf_m.pmdf004 != g_pmdf_m_t.pmdf004 OR cl_null(g_pmdf_m_t.pmdf004) THEN  #160824-00007#341 Mark By Ken 170106
                  IF g_pmdf_m.pmdf004 != g_pmdf_m_o.pmdf004 OR cl_null(g_pmdf_m_o.pmdf004) THEN   #160824-00007#341 Add By Ken 170106
                     #根據供應商帶欄位預設值
                     CALL apmt420_pmdf004_desc()
                   END IF
               END IF
            END IF 
            CALL apmt420_set_entry(p_cmd)
            CALL apmt420_set_no_entry(p_cmd)
            LET g_pmdf_m_o.* = g_pmdf_m.*    #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf004
            #add-point:BEFORE FIELD pmdf004 name="input.b.pmdf004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf004
            #add-point:ON CHANGE pmdf004 name="input.g.pmdf004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf002
            
            #add-point:AFTER FIELD pmdf002 name="input.a.pmdf002"
            CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
            DISPLAY BY NAME g_pmdf_m.pmdf002_desc
            
            IF NOT cl_null(g_pmdf_m.pmdf002) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdf_m.pmdf002 != g_pmdf_m_t.pmdf002 OR cl_null(g_pmdf_m_t.pmdf002))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdf_m.pmdf002 != g_pmdf_m_o.pmdf002 OR cl_null(g_pmdf_m_o.pmdf002)) THEN    #160824-00007#341 Add By Ken 170106
                  #此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdf_m.pmdf002
                  #160318-00025#17  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#17  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     SELECT ooag003 INTO g_pmdf_m.pmdf003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_pmdf_m.pmdf002
                     CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf003_desc                      
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdf_m.pmdf002 = g_pmdf_m_t.pmdf002  #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf002 = g_pmdf_m_o.pmdf002   #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf002
            #add-point:BEFORE FIELD pmdf002 name="input.b.pmdf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf002
            #add-point:ON CHANGE pmdf002 name="input.g.pmdf002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf003
            
            #add-point:AFTER FIELD pmdf003 name="input.a.pmdf003"
            CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
            DISPLAY BY NAME g_pmdf_m.pmdf003_desc  
            
            IF NOT cl_null(g_pmdf_m.pmdf003) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdf_m.pmdf003
               LET g_chkparam.arg2 = g_pmdf_m.pmdfdocdt

               #160318-00025#17 by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#17 by 07900 --add-end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  #LET g_pmdf_m.pmdf003 = g_pmdf_m_t.pmdf003  #160824-00007#341 Mark By Ken 170106
                  LET g_pmdf_m.pmdf003 = g_pmdf_m_o.pmdf003   #160824-00007#341 Add By Ken 170106
                  CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
                  DISPLAY BY NAME g_pmdf_m.pmdf003_desc 
                  NEXT FIELD CURRENT
               END IF           
            END IF 
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf003
            #add-point:BEFORE FIELD pmdf003 name="input.b.pmdf003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf003
            #add-point:ON CHANGE pmdf003 name="input.g.pmdf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdfstus
            #add-point:BEFORE FIELD pmdfstus name="input.b.pmdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdfstus
            
            #add-point:AFTER FIELD pmdfstus name="input.a.pmdfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdfstus
            #add-point:ON CHANGE pmdfstus name="input.g.pmdfstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf005
            
            #add-point:AFTER FIELD pmdf005 name="input.a.pmdf005"
            CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
            DISPLAY BY NAME g_pmdf_m.pmdf005_desc 
            IF NOT cl_null(g_pmdf_m.pmdf005) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdf_m.pmdf005 != g_pmdf_m_t.pmdf005 OR cl_null(g_pmdf_m_t.pmdf005))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdf_m.pmdf005 != g_pmdf_m_o.pmdf005 OR cl_null(g_pmdf_m_o.pmdf005)) THEN    #160824-00007#341 Add By Ken 170106
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_pmdf_m.pmdf005
   
                  #160318-00025#16 by 07900 --add-str 
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] ="aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150"
                  #160318-00025#16 by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooaj002") THEN
                     #檢查成功時後續處理
                     #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準),更新单身及子作业中的单价
                     LET l_pmdgseq = 0
                     LET l_pmdg010 = 0
                     DECLARE pmdf005_cs CURSOR FOR 
                         SELECT pmdgseq,pmdg010 FROM pmdg_t WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
                     FOREACH pmdf005_cs INTO l_pmdgseq,l_pmdg010
                        CALL s_curr_round(g_site,g_pmdf_m.pmdf005,l_pmdg010,'1') RETURNING l_pmdg010
                        UPDATE pmdg_t SET pmdg010 = l_pmdg010 
                          WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
                            AND pmdgseq = l_pmdgseq
                     END FOREACH
                     CALL apmt420_b_fill()
                     #更新子作业中的单价
                     LET l_pmdhseq = 0
                     LET l_pmdh003 = 0
                     LET l_pmdh001 = 0
                     LET l_pmdh002 = 0
                     DECLARE pmdf005_cs2 CURSOR FOR 
                         SELECT pmdhseq,pmdh001,pmdh002,pmdh003 FROM pmdh_t WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
                     FOREACH pmdf005_cs2 INTO l_pmdhseq,l_pmdh001,l_pmdh002,l_pmdh003
                        CALL s_curr_round(g_site,g_pmdf_m.pmdf005,l_pmdh003,'1') RETURNING l_pmdh003
                        UPDATE pmdh_t SET pmdh003 = l_pmdh003 
                          WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
                            AND pmdhseq = l_pmdhseq AND pmdh001 = l_pmdh001 AND pmdh002 = l_pmdh002
                     END FOREACH   
                     CALL apmt420_pmdh_fill()                     
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdf_m.pmdf005 = g_pmdf_m_t.pmdf005  #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf005 = g_pmdf_m_o.pmdf005   #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf005_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf005
            #add-point:BEFORE FIELD pmdf005 name="input.b.pmdf005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf005
            #add-point:ON CHANGE pmdf005 name="input.g.pmdf005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf006
            
            #add-point:AFTER FIELD pmdf006 name="input.a.pmdf006"
            CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
            DISPLAY BY NAME g_pmdf_m.pmdf006_desc 
            IF NOT cl_null(g_pmdf_m.pmdf006) THEN 
               #IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdf_m.pmdf006 != g_pmdf_m_t.pmdf006 OR cl_null(g_pmdf_m_t.pmdf006))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdf_m.pmdf006 != g_pmdf_m_o.pmdf006 OR cl_null(g_pmdf_m_o.pmdf006)) THEN    #160824-00007#341 Add By Ken 170106
                  #此段落由子樣板a19產生
                  CALL s_tax_chk(g_site,g_pmdf_m.pmdf006)
                        RETURNING l_success,g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf008,g_pmdf_m.pmdf007,g_tax_app
                     DISPLAY BY NAME g_pmdf_m.pmdf008,g_pmdf_m.pmdf007
                  IF NOT l_success THEN
                     #LET g_pmdf_m.pmdf006 = g_pmdf_m_t.pmdf006  #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf006 = g_pmdf_m_o.pmdf006   #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf006_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf006
            #add-point:BEFORE FIELD pmdf006 name="input.b.pmdf006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf006
            #add-point:ON CHANGE pmdf006 name="input.g.pmdf006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf007
            #add-point:BEFORE FIELD pmdf007 name="input.b.pmdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf007
            
            #add-point:AFTER FIELD pmdf007 name="input.a.pmdf007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf007
            #add-point:ON CHANGE pmdf007 name="input.g.pmdf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf008
            #add-point:BEFORE FIELD pmdf008 name="input.b.pmdf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf008
            
            #add-point:AFTER FIELD pmdf008 name="input.a.pmdf008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf008
            #add-point:ON CHANGE pmdf008 name="input.g.pmdf008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf009
            
            #add-point:AFTER FIELD pmdf009 name="input.a.pmdf009"
            CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
            DISPLAY BY NAME g_pmdf_m.pmdf009_desc 
            IF NOT cl_null(g_pmdf_m.pmdf009) THEN 
               #如果供應商欄位有值，則要判斷當前付款條件是否在供應商付款條件中
               IF NOT cl_null(g_pmdf_m.pmdf004) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdf_m.pmdf004
                  LET g_chkparam.arg2 = g_pmdf_m.pmdf009
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_pmad002_1") THEN
                     #檢查成功時後續處理
                     
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdf_m.pmdf009 = g_pmdf_m_t.pmdf009   #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf009 = g_pmdf_m_o.pmdf009    #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf009_desc 
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #如果供應商欄位沒有值，則需判斷當前付款條件是否在付款條件檔 中
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdf_m.pmdf009
                  #160318-00025#17 by 07900 --add-str 
                 LET g_errshow = TRUE #是否開窗
                 LET g_chkparam.err_str[1] ="apm-00186:sub-01302|aooi716|",cl_get_progname("aooi716",g_lang,"2"),"|:EXEPROGaooi716"
                 #160318-00025#17 by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooib002") THEN
                     #檢查成功時後續處理
                     
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdf_m.pmdf009 = g_pmdf_m_t.pmdf009   #160824-00007#341 Mark By Ken 170106
                     LET g_pmdf_m.pmdf009 = g_pmdf_m_o.pmdf009    #160824-00007#341 Add By Ken 170106                     
                     CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
                     DISPLAY BY NAME g_pmdf_m.pmdf009_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf009
            #add-point:BEFORE FIELD pmdf009 name="input.b.pmdf009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf009
            #add-point:ON CHANGE pmdf009 name="input.g.pmdf009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf010
            
            #add-point:AFTER FIELD pmdf010 name="input.a.pmdf010"
            CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
            DISPLAY BY NAME g_pmdf_m.pmdf010_desc 
            IF NOT cl_null(g_pmdf_m.pmdf010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_pmdf_m.pmdf010

                #160318-00025#17  by 07900 --add-str 
               LET g_errshow = TRUE #是否開窗
               LET g_chkparam.err_str[1] ="apm-00070:sub-01302|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               LET g_chkparam.err_str[2] ="apm-00069:sub-01303|apmi012|",cl_get_progname("apmi012",g_lang,"2"),"|:EXEPROGapmi012"
               #160318-00025#17  by 07900 --add-end    
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_238") THEN
                  #檢查成功時後續處理
                  
               ELSE
                  #檢查失敗時後續處理
                  #LET g_pmdf_m.pmdf010 = g_pmdf_m_t.pmdf010  #160824-00007#341 Mark By Ken 170106
                  LET g_pmdf_m.pmdf010 = g_pmdf_m_o.pmdf010   #160824-00007#341 Add By Ken 170106
                  CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
                  DISPLAY BY NAME g_pmdf_m.pmdf010_desc 
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_pmdf_m_o.* = g_pmdf_m.*   #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf010
            #add-point:BEFORE FIELD pmdf010 name="input.b.pmdf010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf010
            #add-point:ON CHANGE pmdf010 name="input.g.pmdf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdf030
            #add-point:BEFORE FIELD pmdf030 name="input.b.pmdf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdf030
            
            #add-point:AFTER FIELD pmdf030 name="input.a.pmdf030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdf030
            #add-point:ON CHANGE pmdf030 name="input.g.pmdf030"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pmdf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf001
            #add-point:ON ACTION controlp INFIELD pmdf001 name="input.c.pmdf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfsite
            #add-point:ON ACTION controlp INFIELD pmdfsite name="input.c.pmdfsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfdocno
            #add-point:ON ACTION controlp INFIELD pmdfdocno name="input.c.pmdfdocno"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdfdocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooef001 = g_site AND ooefent  = g_enterprise
            LET g_qryparam.arg1 = l_ooef004 #
            LET g_qryparam.arg2 = g_prog #
            #160711-00040#24 add(s)
            CALL s_control_get_docno_sql(g_user,g_dept)
                RETURNING l_success,l_sql1
            IF NOT cl_null(l_sql1) THEN
               LET g_qryparam.where = l_sql1
            END IF
            #160711-00040#24 add(e)
            CALL q_ooba002_1()                                #呼叫開窗

            LET g_pmdf_m.pmdfdocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            #160803-00028#1---s
            #CALL apmt420_get_oobal004(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            CALL s_aooi200_get_slip_desc(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            #160803-00028#1---e
            DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc

            DISPLAY g_pmdf_m.pmdfdocno TO pmdfdocno              #顯示到畫面上

            NEXT FIELD pmdfdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfdocdt
            #add-point:ON ACTION controlp INFIELD pmdfdocdt name="input.c.pmdfdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf004
            #add-point:ON ACTION controlp INFIELD pmdf004 name="input.c.pmdf004"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.where = "1=1 "
            LET l_sql = ''
            CALL s_control_get_doc_sql("pmaa083",g_pmdf_m.pmdfdocno,'2') RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF

            LET g_qryparam.default1 = g_pmdf_m.pmdf004             #給予default值

            #給予arg

            CALL q_pmaa001_3()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_pmdf_m.pmdf004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf004 TO pmdf004              #顯示到畫面上
            CALL apmt420_pmdf004_ref(g_pmdf_m.pmdf004) RETURNING g_pmdf_m.pmdf004_desc
            DISPLAY BY NAME g_pmdf_m.pmdf004_desc
            

            NEXT FIELD pmdf004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf002
            #add-point:ON ACTION controlp INFIELD pmdf002 name="input.c.pmdf002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf002             #給予default值

            #給予arg

            CALL q_ooag001()                                #呼叫開窗

            LET g_pmdf_m.pmdf002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf002 TO pmdf002              #顯示到畫面上
            CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
            DISPLAY BY NAME g_pmdf_m.pmdf002_desc
            
            NEXT FIELD pmdf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf003
            #add-point:ON ACTION controlp INFIELD pmdf003 name="input.c.pmdf003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdf_m.pmdfdocdt #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_pmdf_m.pmdf003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf003 TO pmdf003              #顯示到畫面上
            CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
            DISPLAY BY NAME g_pmdf_m.pmdf003_desc
                        
            NEXT FIELD pmdf003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdfstus
            #add-point:ON ACTION controlp INFIELD pmdfstus name="input.c.pmdfstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf005
            #add-point:ON ACTION controlp INFIELD pmdf005 name="input.c.pmdf005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site #

            CALL q_ooaj002_1()                                #呼叫開窗

            LET g_pmdf_m.pmdf005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf005 TO pmdf005              #顯示到畫面上
            CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
            DISPLAY BY NAME g_pmdf_m.pmdf005_desc

            NEXT FIELD pmdf005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf006
            #add-point:ON ACTION controlp INFIELD pmdf006 name="input.c.pmdf006"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf006             #給予default值

            #給予arg

            CALL q_oodb002_2()                                #呼叫開窗

            LET g_pmdf_m.pmdf006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf006 TO pmdf006              #顯示到畫面上
            CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
            DISPLAY BY NAME g_pmdf_m.pmdf006_desc            
            
            NEXT FIELD pmdf006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf007
            #add-point:ON ACTION controlp INFIELD pmdf007 name="input.c.pmdf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf008
            #add-point:ON ACTION controlp INFIELD pmdf008 name="input.c.pmdf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmdf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf009
            #add-point:ON ACTION controlp INFIELD pmdf009 name="input.c.pmdf009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf009             #給予default值

            #給予arg
            IF NOT cl_null(g_pmdf_m.pmdf004) THEN
               LET g_qryparam.arg1 = g_pmdf_m.pmdf004 #
               CALL q_pmad002_2()                                #呼叫開窗
            ELSE
               CALL q_ooib002_1()
            END IF

            LET g_pmdf_m.pmdf009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf009 TO pmdf009              #顯示到畫面上
            CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
            DISPLAY BY NAME g_pmdf_m.pmdf009_desc         

            NEXT FIELD pmdf009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf010
            #add-point:ON ACTION controlp INFIELD pmdf010 name="input.c.pmdf010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdf_m.pmdf010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '238' #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmdf_m.pmdf010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdf_m.pmdf010 TO pmdf010              #顯示到畫面上
            CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
            DISPLAY BY NAME g_pmdf_m.pmdf010_desc

            NEXT FIELD pmdf010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.pmdf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdf030
            #add-point:ON ACTION controlp INFIELD pmdf030 name="input.c.pmdf030"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_pmdf_m.pmdfdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_prog) RETURNING l_success,g_pmdf_m.pmdfdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_pmdf_m.pmdfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmdfdocno
               END IF
               #end add-point
               
               INSERT INTO pmdf_t (pmdfent,pmdf001,pmdfsite,pmdfdocno,pmdfdocdt,pmdf004,pmdf002,pmdf003, 
                   pmdfstus,pmdf005,pmdf006,pmdf007,pmdf008,pmdf009,pmdf010,pmdf030,pmdfownid,pmdfowndp, 
                   pmdfcrtid,pmdfcrtdp,pmdfcrtdt,pmdfmodid,pmdfmoddt,pmdfcnfid,pmdfcnfdt)
               VALUES (g_enterprise,g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt, 
                   g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005, 
                   g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
                   g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
                   g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt)  
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_pmdf_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               LET g_ooff003_d = g_pmdf_m.pmdfdocno   #161031-00025#10
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL apmt420_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL apmt420_b_fill()
                  CALL apmt420_b_fill2('0')
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
               CALL apmt420_pmdf_t_mask_restore('restore_mask_o')
               
               UPDATE pmdf_t SET (pmdf001,pmdfsite,pmdfdocno,pmdfdocdt,pmdf004,pmdf002,pmdf003,pmdfstus, 
                   pmdf005,pmdf006,pmdf007,pmdf008,pmdf009,pmdf010,pmdf030,pmdfownid,pmdfowndp,pmdfcrtid, 
                   pmdfcrtdp,pmdfcrtdt,pmdfmodid,pmdfmoddt,pmdfcnfid,pmdfcnfdt) = (g_pmdf_m.pmdf001, 
                   g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002, 
                   g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007, 
                   g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid, 
                   g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid, 
                   g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt)
                WHERE pmdfent = g_enterprise AND pmdfdocno = g_pmdfdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "pmdf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL apmt420_pmdf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_pmdf_m_t)
               LET g_log2 = util.JSON.stringify(g_pmdf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                  #若有修改稅別時，需呼叫取稅率的應用元件重新更新單身每一筆資料的稅率
                  IF ((g_pmdf_m.pmdf006 != g_pmdf_m_t.pmdf006 OR cl_null(g_pmdf_m_t.pmdf006)) AND NOT cl_null(g_pmdf_m.pmdf006)) 
                      OR (cl_null(g_pmdf_m.pmdf006) AND NOT cl_null(g_pmdf_m_t.pmdf006)) THEN
                     UPDATE pmdg_t SET pmdg011 = g_pmdf_m.pmdf007 
                       WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
                  END IF
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "g_pmdf_m"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL apmt420_show()
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="apmt420.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_pmdg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_pmdg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL apmt420_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_pmdg_d.getLength()
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
            CALL apmt420_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN apmt420_cl USING g_enterprise,g_pmdf_m.pmdfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN apmt420_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE apmt420_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_pmdg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_pmdg_d[l_ac].pmdgseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_pmdg_d_t.* = g_pmdg_d[l_ac].*  #BACKUP
               LET g_pmdg_d_o.* = g_pmdg_d[l_ac].*  #BACKUP
               CALL apmt420_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL apmt420_set_no_entry_b(l_cmd)
               IF NOT apmt420_lock_b("pmdg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt420_bcl INTO g_pmdg_d[l_ac].pmdgsite,g_pmdg_d[l_ac].pmdg001,g_pmdg_d[l_ac].pmdgseq, 
                      g_pmdg_d[l_ac].pmdg002,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg005, 
                      g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg008,g_pmdg_d[l_ac].pmdg007, 
                      g_pmdg_d[l_ac].pmdg009,g_pmdg_d[l_ac].pmdg010,g_pmdg_d[l_ac].pmdg018,g_pmdg_d[l_ac].pmdg011, 
                      g_pmdg_d[l_ac].pmdg012,g_pmdg_d[l_ac].pmdg013,g_pmdg_d[l_ac].pmdg017,g_pmdg_d[l_ac].pmdg016, 
                      g_pmdg_d[l_ac].pmdg030
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_pmdg_d_t.pmdgseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_pmdg_d_mask_o[l_ac].* =  g_pmdg_d[l_ac].*
                  CALL apmt420_pmdg_t_mask()
                  LET g_pmdg_d_mask_n[l_ac].* =  g_pmdg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL apmt420_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #mark by lixiang 2016/1/13-begin---
            #調整成符合規範的寫法，放到set_act_visible相關function中
            #IF g_pmdg_d[l_ac].pmdg009 = 'N' THEN
            #   CALL cl_set_act_visible("open_apmt420_01",FALSE)
            #ELSE
            #   CALL cl_set_act_visible("open_apmt420_01",TRUE)
            #END IF
            #mark by lixiang 2016/1/13---end--
            #add by lixiang 2016/1/13---begin---
            CALL apmt420_set_act_visible_b()
            CALL apmt420_set_act_no_visible_b()
            #add by lixiang 2016/1/13---end----
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
            INITIALIZE g_pmdg_d[l_ac].* TO NULL 
            INITIALIZE g_pmdg_d_t.* TO NULL 
            INITIALIZE g_pmdg_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_pmdg_d[l_ac].pmdg009 = "N"
      LET g_pmdg_d[l_ac].pmdg012 = "0"
      LET g_pmdg_d[l_ac].pmdg013 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_pmdg_d_t.* = g_pmdg_d[l_ac].*     #新輸入資料
            LET g_pmdg_d_o.* = g_pmdg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL apmt420_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL apmt420_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_pmdg_d[li_reproduce_target].* = g_pmdg_d[li_reproduce].*
 
               LET g_pmdg_d[li_reproduce_target].pmdgseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_pmdg_d[l_ac].pmdgsite = g_site
            LET g_pmdg_d[l_ac].pmdg001 = g_pmdf_m.pmdf001
            
            SELECT MAX(pmdgseq)+1 INTO g_pmdg_d[l_ac].pmdgseq FROM pmdg_t
               WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
            IF cl_null(g_pmdg_d[l_ac].pmdgseq) OR g_pmdg_d[l_ac].pmdgseq = 0 THEN
               LET g_pmdg_d[l_ac].pmdgseq = 1
            END IF
            
            #單頭pmdf004有輸入值時，單身供應商欄位預設單頭pmdf004的值
            IF NOT cl_null(g_pmdf_m.pmdf004) THEN
               LET g_pmdg_d[l_ac].pmdg002 = g_pmdf_m.pmdf004
               CALL apmt420_pmdf004_ref(g_pmdg_d[l_ac].pmdg002) RETURNING g_pmdg_d[l_ac].pmdg002_desc
               DISPLAY BY NAME g_pmdg_d[l_ac].pmdg002_desc
            END IF
            
            #LET g_pmdg_d[l_ac].pmdg004 = ' '
            #LET g_pmdg_d[l_ac].pmdg014 = ' '
            #LET g_pmdg_d[l_ac].pmdg015 = ' '
            
            #稅別、稅率
            LET g_pmdg_d[l_ac].pmdg018 = g_pmdf_m.pmdf006
            LET g_pmdg_d[l_ac].pmdg011 = g_pmdf_m.pmdf007
            LET g_pmdg_d[l_ac].pmdg017 = g_pmdf_m.pmdfdocdt
            
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
            SELECT COUNT(1) INTO l_count FROM pmdg_t 
             WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
 
               AND pmdgseq = g_pmdg_d[l_ac].pmdgseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
 
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdf_m.pmdfdocno
               LET gs_keys[2] = g_pmdg_d[g_detail_idx].pmdgseq
               CALL apmt420_insert_b('pmdg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               #161031-00025#10---s
               IF NOT cl_null(g_pmdg_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,'','','','','','','','1',g_pmdg_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#10---e
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_pmdg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL apmt420_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               LET l_pmdgseq = NULL
               
               INITIALIZE l_pmdg.* TO NULL               
               SELECT pmdgent,pmdgsite,pmdg001,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014,pmdg015, 
                      pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030 
                INTO l_pmdg.pmdgent,l_pmdg.pmdgsite,l_pmdg.pmdg001,l_pmdg.pmdg002,l_pmdg.pmdg003,l_pmdg.pmdg004,l_pmdg.pmdg005,l_pmdg.pmdg014,
                     l_pmdg.pmdg015,l_pmdg.pmdg008,l_pmdg.pmdg007,l_pmdg.pmdg009,l_pmdg.pmdg010,l_pmdg.pmdg018,
                     l_pmdg.pmdg011,l_pmdg.pmdg012,l_pmdg.pmdg013,l_pmdg.pmdg017,l_pmdg.pmdg016,l_pmdg.pmdg030 
                 FROM pmdg_t 
                WHERE pmdgent = g_enterprise
                  AND pmdgsite = g_site
                  AND pmdgdocno = g_pmdf_m.pmdfdocno
                  AND pmdgseq = g_pmdg_d[l_ac].pmdgseq
               
               IF l_inam.getLength() > 1 THEN  #因為第一筆資料已呈現在畫面並寫入DB, 從第二筆開始處理           
                  IF cl_null(l_pmdgseq) THEN   
                     SELECT MAX(pmdgseq) INTO l_pmdgseq
                       FROM pmdg_t
                      WHERE pmdgent   = g_enterprise
                        AND pmdgsite  = g_site
                        AND pmdgdocno = g_pmdf_m.pmdfdocno                     
                  END IF 
                  
                  LET l_pmdg.pmdg009 = 'N'
                  
                  FOR l_i = 2 TO l_inam.getLength() 
                     IF cl_null(l_pmdgseq) OR l_pmdgseq = 0 THEN
                        LET l_pmdgseq = 1
                     ELSE
                        LET l_pmdgseq = l_pmdgseq + 1             
                     END IF 
                     
                     INSERT INTO pmdg_t
                         (pmdgent,pmdgdocno,pmdgseq,pmdgsite,pmdg001,pmdg002,pmdg003,pmdg004,pmdg005,
                          pmdg014,pmdg015,pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030) 
                       VALUES(g_enterprise,g_pmdf_m.pmdfdocno,l_pmdgseq,l_pmdg.pmdgsite,l_pmdg.pmdg001,l_pmdg.pmdg002, 
                              l_pmdg.pmdg003,l_inam[l_i].inam002,l_pmdg.pmdg005,l_pmdg.pmdg014,l_pmdg.pmdg015,l_pmdg.pmdg008, 
                              l_inam[l_i].inam004,l_pmdg.pmdg009,l_pmdg.pmdg010,l_pmdg.pmdg018,l_pmdg.pmdg011,l_pmdg.pmdg012, 
                              l_pmdg.pmdg013,l_pmdg.pmdg017,l_pmdg.pmdg016,l_pmdg.pmdg030)
                         
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "pmdg_t"
                        LET g_errparam.popup = FALSE
                        CALL cl_err()

                     END IF
                     #161031-00025#10---s
                     IF NOT cl_null(g_pmdg_d[l_ac].ooff013) THEN
                        CALL s_aooi360_gen('7',g_prog,g_pmdf_m.pmdfdocno,l_pmdgseq,'','','','','','','','1',g_pmdg_d[l_ac].ooff013) RETURNING l_success
                     END IF
                     #161031-00025#10---e
                  END FOR
                  CALL apmt420_b_fill()
                  LET g_rec_b = l_inam.getLength() - 1
               END IF
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
               LET gs_keys[01] = g_pmdf_m.pmdfdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_pmdg_d_t.pmdgseq
 
            
               #刪除同層單身
               IF NOT apmt420_delete_b('pmdg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt420_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT apmt420_key_delete_b(gs_keys,'pmdg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE apmt420_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               #161031-00025#10---s
               CALL s_aooi360_del('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d_t.pmdgseq,'','','','','','','','1') RETURNING l_success
               #161031-00025#10---e    
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE apmt420_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  DELETE FROM pmdh_t
                    WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno 
                      AND pmdhseq = g_pmdg_d_t.pmdgseq
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdg_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     CANCEL DELETE
                  END IF
               #end add-point
               LET l_count = g_pmdg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_pmdg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg001
            #add-point:BEFORE FIELD pmdg001 name="input.b.page1.pmdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg001
            
            #add-point:AFTER FIELD pmdg001 name="input.a.page1.pmdg001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg001
            #add-point:ON CHANGE pmdg001 name="input.g.page1.pmdg001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdgseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdg_d[l_ac].pmdgseq,"1","1","","","azz-00079",1) THEN
               NEXT FIELD pmdgseq
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdgseq name="input.a.page1.pmdgseq"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_pmdf_m.pmdfdocno) AND NOT cl_null(g_pmdg_d[l_ac].pmdgseq) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdf_m.pmdfdocno != g_pmdfdocno_t OR g_pmdg_d[l_ac].pmdgseq != g_pmdg_d_t.pmdgseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdg_t WHERE "||"pmdgent = '" ||g_enterprise|| "' AND "||"pmdgdocno = '"||g_pmdf_m.pmdfdocno ||"' AND "|| "pmdgseq = '"||g_pmdg_d[l_ac].pmdgseq ||"'",'std-00004',0) THEN 
                     LET g_pmdg_d[l_ac].pmdgseq = g_pmdg_d_t.pmdgseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdgseq
            #add-point:BEFORE FIELD pmdgseq name="input.b.page1.pmdgseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdgseq
            #add-point:ON CHANGE pmdgseq name="input.g.page1.pmdgseq"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg002
            
            #add-point:AFTER FIELD pmdg002 name="input.a.page1.pmdg002"
            CALL apmt420_pmdf004_ref(g_pmdg_d[l_ac].pmdg002) RETURNING g_pmdg_d[l_ac].pmdg002_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg002_desc
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg002) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg002 != g_pmdg_d_t.pmdg002)) THEN
                  IF NOT apmt420_pmdf004_chk(g_pmdg_d[l_ac].pmdg002) THEN
                     LET g_pmdg_d[l_ac].pmdg002 = g_pmdg_d_t.pmdg002
                     CALL apmt420_pmdf004_ref(g_pmdg_d[l_ac].pmdg002) RETURNING g_pmdg_d[l_ac].pmdg002_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg002_desc
                     NEXT FIELD CURRENT
                  END IF       
               END IF
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg002
            #add-point:BEFORE FIELD pmdg002 name="input.b.page1.pmdg002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg002
            #add-point:ON CHANGE pmdg002 name="input.g.page1.pmdg002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg003
            
            #add-point:AFTER FIELD pmdg003 name="input.a.page1.pmdg003"
            CALL apmt420_pmdg003_ref(g_pmdg_d[l_ac].pmdg003) RETURNING g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg003) THEN 
               IF g_pmdg_d[l_ac].pmdg003 != g_pmdg_d_o.pmdg003 OR cl_null(g_pmdg_d_t.pmdg003) THEN
                  IF NOT apmt420_pmdg003_chk(g_pmdg_d[l_ac].pmdg003) THEN
                     LET g_pmdg_d[l_ac].pmdg003 = g_pmdg_d_t.pmdg003
                     CALL apmt420_pmdg003_ref(g_pmdg_d[l_ac].pmdg003) RETURNING g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
                     NEXT FIELD CURRENT
                  ELSE
                     LET g_pmdg_d[l_ac].pmdg004 = ' '
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004
                     
                     LET g_pmdg_d[l_ac].pmdg005 = ''
                     LET g_pmdg_d[l_ac].pmdg008 = ''
                     SELECT imaf157,imaf143 INTO g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg008 FROM imaf_t
                        WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdg_d[l_ac].pmdg003
                        
                     #如果整體參數使用採購計價單位時，[C:詢價單位]=[T:料件據點進銷存檔].[C:採購計價單位] 
                     IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') THEN
                        SELECT imaf144 INTO g_pmdg_d[l_ac].pmdg008 FROM imaf_t
                           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdg_d[l_ac].pmdg003
                     END IF
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg008
                     CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
                     
                     CALL apmt420_pmdg008_ref(g_pmdg_d[l_ac].pmdg008) RETURNING g_pmdg_d[l_ac].pmdg008_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg008_desc
                     
                     #依據單頭的稅別與單身的料號呼叫取稅率的應用元件，取得稅率值後更新顯示在pmdg011欄位
                     LET l_pmab039 = ''
                     SELECT pmab039 INTO l_pmab039 FROM pmab_t,pmaa_t 
                        WHERE pmaaent = pmabent AND pmaa001 = pmab001 AND pmaastus = 'Y'
                          AND pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmdg_d[l_ac].pmdg002
                     IF SQLCA.sqlcode = 100 THEN
                        SELECT pmab039 INTO l_pmab039 FROM pmab_t,pmaa_t 
                           WHERE pmaaent = pmabent AND pmaa001 = pmab001 AND pmaastus = 'Y'
                             AND pmabent = g_enterprise AND pmabsite = 'ALL' AND pmab001 = g_pmdg_d[l_ac].pmdg002
                     END IF
                    IF g_tax_app = '2' THEN
                    #依料件設定
                        IF (NOT cl_null(g_pmdg_d[l_ac].pmdg002)) AND (NOT cl_null(l_pmab039)) THEN
                           CALL s_tax_chktype(g_site,g_pmdg_d[l_ac].pmdg002,g_pmdg_d[l_ac].pmdg003,'2',l_pmab039)
                              RETURNING l_success,g_pmdg_d[l_ac].pmdg018,g_pmdg_d[l_ac].pmdg011
                           IF NOT l_success THEN
                              LET g_pmdg_d[l_ac].pmdg003 = g_pmdg_d_t.pmdg003
                              CALL apmt420_pmdg003_ref(g_pmdg_d[l_ac].pmdg003) RETURNING g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
                              DISPLAY BY NAME g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
                              NEXT FIELD CURRENT
                           END IF
                        END IF
                     ELSE
                     #依正常稅率                     
                        DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018,g_pmdg_d[l_ac].pmdg011
                        CALL apmt420_pmdf006_ref(g_pmdg_d[l_ac].pmdg018) RETURNING g_pmdg_d[l_ac].pmdg018_desc
                        DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018_desc   
                     END IF                        
                  END IF
               END IF
            END IF 
            CALL apmt420_set_entry_b(l_cmd)
            CALL apmt420_set_no_entry_b(l_cmd)
            #160314-00009#3   marked by zhujing 2016-3-16-----(S)
#            LET l_imaa005 = ''
#            CALL apmt420_get_imaa005(g_enterprise,g_pmdg_d[l_ac].pmdg003) RETURNING l_imaa005
            CALL l_inam.clear()     
#            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(l_imaa005) THEN
            #160314-00009#3   marked by zhujing 2016-3-16-----(E)
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND s_feature_auto_chk(g_pmdg_d[l_ac].pmdg003) AND cl_null(g_pmdg_d[l_ac].pmdg004) THEN  #160314-00009#3   mod by zhujing 2016-3-16
               IF l_cmd = 'a' THEN  
                  CALL s_feature(l_cmd,g_pmdg_d[l_ac].pmdg003,'','',g_site,g_pmdf_m.pmdfdocno) RETURNING l_success,l_inam
                  LET g_pmdg_d[l_ac].pmdg004 = l_inam[1].inam002
                  LET g_pmdg_d[l_ac].pmdg007 = l_inam[1].inam004
                  DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg007
               END IF
            END IF   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg003
            #add-point:BEFORE FIELD pmdg003 name="input.b.page1.pmdg003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg003
            #add-point:ON CHANGE pmdg003 name="input.g.page1.pmdg003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg004
            
            #add-point:AFTER FIELD pmdg004 name="input.a.page1.pmdg004"
            CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004_desc

            IF g_pmdg_d[l_ac].pmdg004 IS NOT NULL THEN
               IF NOT cl_null(g_pmdg_d[l_ac].pmdg004) THEN   #161116-00041#1-add
                  IF NOT s_feature_check(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) THEN
                     LET g_pmdg_d[l_ac].pmdg004 = g_pmdg_d_t.pmdg004
                     CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF   #161116-00041#1-add
               #151224-00025#3 add start ------------------------
               IF NOT s_feature_direct_input(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_pmdg_d_t.pmdg004,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfsite) THEN
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#3 add end   ------------------------  
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg004
            #add-point:BEFORE FIELD pmdg004 name="input.b.page1.pmdg004"
            #160314-00009#3   add by zhujing 2016-3-16-----(S)
#            IF NOT cl_null(g_pmdg_d[l_ac].pmdg003) AND cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
#               IF s_feature_auto_chk(g_pmdg_d[l_ac].pmdg003) AND cl_null(g_pmdg_d[l_ac].pmdg004) THEN
#                  CALL s_feature_single(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_site,'') RETURNING l_success,g_pmdg_d[l_ac].pmdg004
#                  DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004
#                  CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) 
#                     RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
#               END IF
#            END IF
            #160314-00009#3   add by zhujing 2016-3-16-----(E)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg004
            #add-point:ON CHANGE pmdg004 name="input.g.page1.pmdg004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg005
            
            #add-point:AFTER FIELD pmdg005 name="input.a.page1.pmdg005"
            CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg005 != g_pmdg_d_t.pmdg005 OR cl_null(g_pmdg_d_t.pmdg005))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdg_d[l_ac].pmdg005
                 #160318-00025#17  by 07900 --add-str
                 LET g_errshow = TRUE #是否開窗                   
                 LET g_chkparam.err_str[1] ="aim-00002:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"
                 #160318-00025#17  by 07900 --add-end 
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_imaa001_3") THEN
                     #檢查成功時後續處理
                     IF cl_chk_exist("v_imaf001_2") THEN
                     
                     ELSE
                        #檢查失敗時後續處理
                        LET g_pmdg_d[l_ac].pmdg005 = g_pmdg_d_t.pmdg005
                        CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
                        DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmdg_d[l_ac].pmdg005 = g_pmdg_d_t.pmdg005
                     CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg005
            #add-point:BEFORE FIELD pmdg005 name="input.b.page1.pmdg005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg005
            #add-point:ON CHANGE pmdg005 name="input.g.page1.pmdg005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg014
            
            #add-point:AFTER FIELD pmdg014 name="input.a.page1.pmdg014"
            CALL apmt420_pmdg014_ref(g_pmdg_d[l_ac].pmdg014) RETURNING g_pmdg_d[l_ac].pmdg014_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg014_desc
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg014) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg014 != g_pmdg_d_t.pmdg014 OR cl_null(g_pmdg_d_t.pmdg014))) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdg_d[l_ac].pmdg014
   
                  #160318-00025#17 by 07900 --add-str 
                 LET g_errshow = TRUE #是否開窗
                 LET g_chkparam.err_str[1] ="aqc-00017:sub-01302|aeci004|",cl_get_progname("aeci004",g_lang,"2"),"|:EXEPROGaeci004"
                 LET g_chkparam.err_str[2] ="aqc-00016:sub-01303|aeci004|",cl_get_progname("aeci004",g_lang,"2"),"|:EXEPROGaeci004"
                 #160318-00025#17 by 07900 --add-end    
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oocq002_221") THEN
                     #檢查成功時後續處理
                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmdg_d[l_ac].pmdg014 = g_pmdg_d_t.pmdg014
                     CALL apmt420_pmdg014_ref(g_pmdg_d[l_ac].pmdg014) RETURNING g_pmdg_d[l_ac].pmdg014_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg014
            #add-point:BEFORE FIELD pmdg014 name="input.b.page1.pmdg014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg014
            #add-point:ON CHANGE pmdg014 name="input.g.page1.pmdg014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg015
            #add-point:BEFORE FIELD pmdg015 name="input.b.page1.pmdg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg015
            
            #add-point:AFTER FIELD pmdg015 name="input.a.page1.pmdg015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg015
            #add-point:ON CHANGE pmdg015 name="input.g.page1.pmdg015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg008
            
            #add-point:AFTER FIELD pmdg008 name="input.a.page1.pmdg008"
            CALL apmt420_pmdg008_ref(g_pmdg_d[l_ac].pmdg008) RETURNING g_pmdg_d[l_ac].pmdg008_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg008_desc
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg008) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg008 != g_pmdg_d_t.pmdg008 OR cl_null(g_pmdg_d_t.pmdg008))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdg_d[l_ac].pmdg008 != g_pmdg_d_o.pmdg008 OR cl_null(g_pmdg_d_o.pmdg008)) THEN   #160824-00007#341 Add By Ken 170106
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdg_d[l_ac].pmdg008
   
                  #160318-00025#17 by 07900 --add-str 
                 LET g_errshow = TRUE #是否開窗
                 LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
                 #160318-00025#17 by 07900 --add-end   
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooca001") THEN
                     #檢查成功時後續處理 
                     #根據單位對數量與最低採購數量進行取位
                     IF NOT cl_null(g_pmdg_d[l_ac].pmdg007) OR NOT cl_null(g_pmdg_d[l_ac].pmdg013) THEN
                        CALL apmt420_pmdg008_round()
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     #LET g_pmdg_d[l_ac].pmdg008 = g_pmdg_d_t.pmdg008  #160824-00007#341 Mark By Ken 170106
                     LET g_pmdg_d[l_ac].pmdg008 = g_pmdg_d_o.pmdg008   #160824-00007#341 Add By Ken 170106
                     CALL apmt420_pmdg008_ref(g_pmdg_d[l_ac].pmdg008) RETURNING g_pmdg_d[l_ac].pmdg008_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg008_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_pmdg_d_o.* = g_pmdg_d[l_ac].*    #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg008
            #add-point:BEFORE FIELD pmdg008 name="input.b.page1.pmdg008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg008
            #add-point:ON CHANGE pmdg008 name="input.g.page1.pmdg008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdg_d[l_ac].pmdg007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pmdg007
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdg007 name="input.a.page1.pmdg007"
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg007) THEN 
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg007 != g_pmdg_d_t.pmdg007 OR cl_null(g_pmdg_d_t.pmdg007))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdg_d[l_ac].pmdg007 != g_pmdg_d_o.pmdg007 OR cl_null(g_pmdg_d_o.pmdg007)) THEN   #160824-00007#341 Add By Ken 170106
                  #根據單位對數量與最低採購數量進行取位
                  CALL apmt420_pmdg008_round()
               END IF
            END IF 
            LET g_pmdg_d_o.* = g_pmdg_d[l_ac].*    #160824-00007#341 Add By Ken 170106

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg007
            #add-point:BEFORE FIELD pmdg007 name="input.b.page1.pmdg007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg007
            #add-point:ON CHANGE pmdg007 name="input.g.page1.pmdg007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg009
            #add-point:BEFORE FIELD pmdg009 name="input.b.page1.pmdg009"
            LET g_pmdg_d_t.pmdg009 = g_pmdg_d[l_ac].pmdg009
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg009
            
            #add-point:AFTER FIELD pmdg009 name="input.a.page1.pmdg009"
            CALL apmt420_set_entry_b(l_cmd)
            CALL apmt420_set_no_entry_b(l_cmd)
            
            IF g_pmdg_d[l_ac].pmdg009 = 'Y' AND g_pmdg_d[l_ac].pmdg009 != g_pmdg_d_t.pmdg009 THEN
               #當勾選時開出apmt420_01子程式維護量計價資料
               CALL apmt420_01('1',g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg007,g_pmdg_d[l_ac].pmdg008)
               
               #当勾选分量计价时，單價欄位不可以維護，那單價的值是由分量計架維護好后回寫，用單價最大的那一個回寫
               SELECT pmdh003,pmdh004 INTO g_pmdg_d[l_ac].pmdg010,g_pmdg_d[l_ac].pmdg012 FROM pmdh_t 
                 WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno AND pmdhseq = g_pmdg_d[l_ac].pmdgseq
                   AND pmdh003 = (SELECT MAX(pmdh003) FROM pmdh_t WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno AND pmdhseq = g_pmdg_d[l_ac].pmdgseq)
               IF cl_null(g_pmdg_d[l_ac].pmdg010) THEN
                  LET g_pmdg_d[l_ac].pmdg010 = 0
               END IF
               IF cl_null(g_pmdg_d[l_ac].pmdg012) THEN
                  LET g_pmdg_d[l_ac].pmdg012 = 0
               END IF
               DISPLAY BY NAME g_pmdg_d[l_ac].pmdg010,g_pmdg_d[l_ac].pmdg012
            END IF
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg009
            #add-point:ON CHANGE pmdg009 name="input.g.page1.pmdg009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdg_d[l_ac].pmdg010,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdg010
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdg010 name="input.a.page1.pmdg010"
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg010) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg010 != g_pmdg_d_t.pmdg010 OR cl_null(g_pmdg_d_t.pmdg010))) THEN 
                  IF NOT cl_null(g_pmdf_m.pmdf005) THEN
                     #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
                     CALL s_curr_round(g_site,g_pmdf_m.pmdf005,g_pmdg_d[l_ac].pmdg010,'1') RETURNING g_pmdg_d[l_ac].pmdg010
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg010
                  END IF
               END IF                  
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg010
            #add-point:BEFORE FIELD pmdg010 name="input.b.page1.pmdg010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg010
            #add-point:ON CHANGE pmdg010 name="input.g.page1.pmdg010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg018
            
            #add-point:AFTER FIELD pmdg018 name="input.a.page1.pmdg018"
            CALL apmt420_pmdf006_ref(g_pmdg_d[l_ac].pmdg018) RETURNING g_pmdg_d[l_ac].pmdg018_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018_desc 
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg018) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg018 != g_pmdg_d_t.pmdg018 OR cl_null(g_pmdg_d_t.pmdg018))) THEN
                  #此段落由子樣板a19產生
                  CALL s_tax_chk(g_site,g_pmdg_d[l_ac].pmdg018)
                        RETURNING l_success,g_pmdg_d[l_ac].pmdg018_desc,l_oodb005,g_pmdg_d[l_ac].pmdg011,g_tax_app
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg011
                  IF NOT l_success THEN
                     LET g_pmdg_d[l_ac].pmdg018 = g_pmdg_d_t.pmdg018
                     CALL apmt420_pmdf006_ref(g_pmdg_d[l_ac].pmdg018) RETURNING g_pmdg_d[l_ac].pmdg018_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg018
            #add-point:BEFORE FIELD pmdg018 name="input.b.page1.pmdg018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg018
            #add-point:ON CHANGE pmdg018 name="input.g.page1.pmdg018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg011
            #add-point:BEFORE FIELD pmdg011 name="input.b.page1.pmdg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg011
            
            #add-point:AFTER FIELD pmdg011 name="input.a.page1.pmdg011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg011
            #add-point:ON CHANGE pmdg011 name="input.g.page1.pmdg011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdg_d[l_ac].pmdg012,"0.000","1","100.000","1","azz-00087",1) THEN 
 
               NEXT FIELD pmdg012
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdg012 name="input.a.page1.pmdg012"
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg012) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg012
            #add-point:BEFORE FIELD pmdg012 name="input.b.page1.pmdg012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg012
            #add-point:ON CHANGE pmdg012 name="input.g.page1.pmdg012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg013
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_pmdg_d[l_ac].pmdg013,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD pmdg013
            END IF 
 
 
 
            #add-point:AFTER FIELD pmdg013 name="input.a.page1.pmdg013"
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg013) THEN
               #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg013 != g_pmdg_d_t.pmdg013 OR cl_null(g_pmdg_d_t.pmdg013))) THEN   #160824-00007#341 Mark By Ken 170106
               IF (g_pmdg_d[l_ac].pmdg013 != g_pmdg_d_o.pmdg013 OR cl_null(g_pmdg_d_o.pmdg013)) THEN    #160824-00007#341 Add By Ken 170106
                  #根據單位對數量與最低採購數量進行取位
                  CALL apmt420_pmdg008_round()
               END IF            
            END IF 
            LET g_pmdg_d_o.* = g_pmdg_d[l_ac].*    #160824-00007#341 Add By Ken 170106
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg013
            #add-point:BEFORE FIELD pmdg013 name="input.b.page1.pmdg013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg013
            #add-point:ON CHANGE pmdg013 name="input.g.page1.pmdg013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg017
            #add-point:BEFORE FIELD pmdg017 name="input.b.page1.pmdg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg017
            
            #add-point:AFTER FIELD pmdg017 name="input.a.page1.pmdg017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg017
            #add-point:ON CHANGE pmdg017 name="input.g.page1.pmdg017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg016
            
            #add-point:AFTER FIELD pmdg016 name="input.a.page1.pmdg016"
            CALL apmt420_pmdg016_ref(g_pmdg_d[l_ac].pmdg016) RETURNING g_pmdg_d[l_ac].pmdg016_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg016_desc
            IF NOT cl_null(g_pmdg_d[l_ac].pmdg016) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmdg_d[l_ac].pmdg016 != g_pmdg_d_t.pmdg016 OR cl_null(g_pmdg_d_t.pmdg016))) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_pmdg_d[l_ac].pmdg016
   
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oocq002_263") THEN
                     #檢查成功時後續處理 
                     
                  ELSE
                     #檢查失敗時後續處理
                     LET g_pmdg_d[l_ac].pmdg016 = g_pmdg_d_t.pmdg016
                     CALL apmt420_pmdg016_ref(g_pmdg_d[l_ac].pmdg016) RETURNING g_pmdg_d[l_ac].pmdg016_desc
                     DISPLAY BY NAME g_pmdg_d[l_ac].pmdg016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg016
            #add-point:BEFORE FIELD pmdg016 name="input.b.page1.pmdg016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg016
            #add-point:ON CHANGE pmdg016 name="input.g.page1.pmdg016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmdg030
            #add-point:BEFORE FIELD pmdg030 name="input.b.page1.pmdg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmdg030
            
            #add-point:AFTER FIELD pmdg030 name="input.a.page1.pmdg030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmdg030
            #add-point:ON CHANGE pmdg030 name="input.g.page1.pmdg030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.page1.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.page1.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.page1.ooff013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.pmdg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg001
            #add-point:ON ACTION controlp INFIELD pmdg001 name="input.c.page1.pmdg001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdgseq
            #add-point:ON ACTION controlp INFIELD pmdgseq name="input.c.page1.pmdgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg002
            #add-point:ON ACTION controlp INFIELD pmdg002 name="input.c.page1.pmdg002"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE
			
			LET g_qryparam.where = "1=1 "
            LET l_sql = ''
            CALL s_control_get_doc_sql("pmaa083",g_pmdf_m.pmdfdocno,'2') RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg002             #給予default值

            #給予arg

            CALL q_pmaa001_3()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_pmdg_d[l_ac].pmdg002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg002 TO pmdg002              #顯示到畫面上
            CALL apmt420_pmdf004_ref(g_pmdg_d[l_ac].pmdg002) RETURNING g_pmdg_d[l_ac].pmdg002_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg002_desc
  
            NEXT FIELD pmdg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg003
            #add-point:ON ACTION controlp INFIELD pmdg003 name="input.c.page1.pmdg003"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg003             #給予default值
            LET g_qryparam.where = "1=1 "
            LET l_sql = ''
            CALL s_control_get_doc_sql("imaf016",g_pmdf_m.pmdfdocno,'4') RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF

            LET l_sql = ''
            CALL s_control_get_doc_sql("imaa009",g_pmdf_m.pmdfdocno,'5') RETURNING l_success,l_sql
            IF l_success THEN
               IF cl_null(l_sql) THEN
                  LET l_sql = " 1=1"
               END IF
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF
            
            
            #LET g_qryparam.where = " SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' "
            #
            ##獲取單據別
			#LET l_ooba002 = ''
			#CALL s_aooi200_get_slip(g_pmdf_m.pmdfdocno) RETURNING l_success,l_ooba002
			##獲取單號的營運據點
			#LET l_site = ''
			#CALL s_aooi200_get_site(g_pmdf_m.pmdfdocno) RETURNING l_success,l_site
			##獲取參照表編號
			#LET l_ooef004 = ''
			#SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = l_site
			#
			##判斷是否有設定生命週期範圍
			#LET l_n = 0
			#SELECT COUNT(oobd004) INTO l_n FROM ooba_t,oobd_t WHERE oobaent=oobdent AND ooba001=oobd001 AND ooba002=oobd002 
            #    AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_ooba002 AND oobd003='210'
            #IF l_n > 0 THEN
            #   LET g_qryparam.where = g_qryparam.where," AND imaf016 IN (SELECT oobd004 FROM oobd_t WHERE oobdent = '",g_enterprise,"' AND oobd001 = '",l_ooef004,"' AND oobd002 = '",l_ooba002,"' AND oobd003 = '210') "
            #END IF
            #
            #LET g_qryparam.where = " imaa001 IN ( ",g_qryparam.where,")" 
            #
            #
            ##判斷是否在產品分類設定範圍內
            #LET l_n = 0
            #SELECT COUNT(oobh003) INTO l_n FROM ooba_t,oobh_t WHERE oobaent=oobhent AND ooba001=oobh001 AND ooba002=oobh002
            #    AND oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_ooba002
            #IF l_n > 0 THEN
            #   LET l_ooba014 = ''
            #   SELECT ooba014 INTO l_ooba014 FROM ooba_t WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_ooba002
            #   #正向列表
            #   IF l_ooba014 = '1' THEN
            #      LET g_qryparam.where = g_qryparam.where," AND imaa009 IN (SELECT oobh003 FROM oobh_t WHERE oobhent = '",g_enterprise,"' AND oobh001 = '",l_ooef004,"' AND oobh002 = '",l_ooba002,"' ) "
            #   END IF
            #   
            #   #負向列表
            #   IF l_ooba014 = '2' THEN
            #      LET g_qryparam.where = g_qryparam.where," AND imaa009 NOT IN (SELECT oobh003 FROM oobh_t WHERE oobhent = '",g_enterprise,"' AND oobh001 = '",l_ooef004,"' AND oobh002 = '",l_ooba002,"' ) "
            #   END IF
            #END IF 

            #給予arg

            CALL q_imaf001()                                #呼叫開窗
            LET g_qryparam.where = " "

            LET g_pmdg_d[l_ac].pmdg003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg003 TO pmdg003              #顯示到畫面上
            CALL apmt420_pmdg003_ref(g_pmdg_d[l_ac].pmdg003) RETURNING g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
   
            NEXT FIELD pmdg003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg004
            #add-point:ON ACTION controlp INFIELD pmdg004 name="input.c.page1.pmdg004"
            LET l_imaa005 = ''
            CALL apmt420_get_imaa005(g_enterprise,g_pmdg_d[l_ac].pmdg003) RETURNING l_imaa005
               
            IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' AND NOT cl_null(l_imaa005) THEN
               IF l_cmd = 'a' THEN            
                  CALL l_inam.clear()            
                  CALL s_feature(l_cmd,g_pmdg_d[l_ac].pmdg003,'','',g_site,g_pmdf_m.pmdfdocno) RETURNING l_success,l_inam
                  LET g_pmdg_d[l_ac].pmdg004 = l_inam[1].inam002
                  LET g_pmdg_d[l_ac].pmdg007 = l_inam[1].inam004
                  DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg007
               END IF
               IF l_cmd = 'u' THEN
                  CALL s_feature_single(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_site,g_pmdf_m.pmdfdocno)
                     RETURNING l_success,g_pmdg_d[l_ac].pmdg004
                  CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
                  DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004_desc
               END IF
            END IF   
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg005
            #add-point:ON ACTION controlp INFIELD pmdg005 name="input.c.page1.pmdg005"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg005             #給予default值
            

            #給予arg

            CALL q_imaf001_12()                                #呼叫開窗

            LET g_pmdg_d[l_ac].pmdg005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
 
            DISPLAY g_pmdg_d[l_ac].pmdg005 TO pmdg005              #顯示到畫面上
            

            NEXT FIELD pmdg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg014
            #add-point:ON ACTION controlp INFIELD pmdg014 name="input.c.page1.pmdg014"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "221" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmdg_d[l_ac].pmdg014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg014 TO pmdg014              #顯示到畫面上
            CALL apmt420_pmdg014_ref(g_pmdg_d[l_ac].pmdg014) RETURNING g_pmdg_d[l_ac].pmdg014_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg014_desc           

            NEXT FIELD pmdg014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg015
            #add-point:ON ACTION controlp INFIELD pmdg015 name="input.c.page1.pmdg015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg008
            #add-point:ON ACTION controlp INFIELD pmdg008 name="input.c.page1.pmdg008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg008             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_pmdg_d[l_ac].pmdg008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg008 TO pmdg008              #顯示到畫面上
            CALL apmt420_pmdg008_ref(g_pmdg_d[l_ac].pmdg008) RETURNING g_pmdg_d[l_ac].pmdg008_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg008_desc            

            NEXT FIELD pmdg008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg007
            #add-point:ON ACTION controlp INFIELD pmdg007 name="input.c.page1.pmdg007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg009
            #add-point:ON ACTION controlp INFIELD pmdg009 name="input.c.page1.pmdg009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg010
            #add-point:ON ACTION controlp INFIELD pmdg010 name="input.c.page1.pmdg010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg018
            #add-point:ON ACTION controlp INFIELD pmdg018 name="input.c.page1.pmdg018"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg018             #給予default值

            #給予arg

            CALL q_oodb002_2()                                #呼叫開窗

            LET g_pmdg_d[l_ac].pmdg018 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg018 TO pmdg018              #顯示到畫面上
            CALL apmt420_pmdf006_ref(g_pmdg_d[l_ac].pmdg018) RETURNING g_pmdg_d[l_ac].pmdg018_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018_desc

            NEXT FIELD pmdg018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg011
            #add-point:ON ACTION controlp INFIELD pmdg011 name="input.c.page1.pmdg011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg012
            #add-point:ON ACTION controlp INFIELD pmdg012 name="input.c.page1.pmdg012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg013
            #add-point:ON ACTION controlp INFIELD pmdg013 name="input.c.page1.pmdg013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg017
            #add-point:ON ACTION controlp INFIELD pmdg017 name="input.c.page1.pmdg017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg016
            #add-point:ON ACTION controlp INFIELD pmdg016 name="input.c.page1.pmdg016"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdg_d[l_ac].pmdg016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "263" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_pmdg_d[l_ac].pmdg016 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdg_d[l_ac].pmdg016 TO pmdg016              #顯示到畫面上
            CALL apmt420_pmdg016_ref(g_pmdg_d[l_ac].pmdg016) RETURNING g_pmdg_d[l_ac].pmdg016_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg016_desc

            NEXT FIELD pmdg016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.pmdg030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmdg030
            #add-point:ON ACTION controlp INFIELD pmdg030 name="input.c.page1.pmdg030"
         ON ACTION open_apmt420_01

            LET g_action_choice="open_apmt420_01"
            IF cl_auth_chk_act("open_apmt420_01") THEN 
               IF l_ac > 0 THEN   #防止數組溢出錯誤
                  IF g_pmdg_d[l_ac].pmdg009 = 'Y' AND NOT cl_null(g_pmdf_m.pmdfdocno) AND NOT cl_null(g_pmdg_d[l_ac].pmdgseq) THEN
                     CALL apmt420_01('1',g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004,g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg007,g_pmdg_d[l_ac].pmdg008)
                     NEXT FIELD CURRENT
                  END IF
                END IF                
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.page1.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1.ooff013"
            #161031-00025#10 add-S
            IF NOT cl_null(g_pmdf_m.pmdfdocno) AND l_ac > 0 THEN
               CALL aooi360_02('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,'','','','','','','','1')
               CALL s_aooi360_sel('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,'','','','','','','','1') RETURNING l_success,g_pmdg_d[l_ac].ooff013
               LET g_ooff001_d = '6'   #6.單據單頭備註
               LET g_ooff002_d = g_prog
               LET g_ooff003_d = g_pmdf_m.pmdfdocno   #单号
               LET g_ooff004_d = 0     #项次
               LET g_ooff005_d = ' '
               LET g_ooff006_d = ' '
               LET g_ooff007_d = ' '
               LET g_ooff008_d = ' '
               LET g_ooff009_d = ' '
               LET g_ooff010_d = ' '
               LET g_ooff011_d = ' '
               CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
            END IF
            #161031-00025#10 add-E
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_pmdg_d[l_ac].* = g_pmdg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE apmt420_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_pmdg_d[l_ac].pmdgseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_pmdg_d[l_ac].* = g_pmdg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF cl_null(g_pmdg_d[l_ac].pmdg004) THEN
                  LET g_pmdg_d[l_ac].pmdg004 = ' '
               END IF
               IF cl_null(g_pmdg_d[l_ac].pmdg014) THEN
                  LET g_pmdg_d[l_ac].pmdg014 = ' '
               END IF
               IF cl_null(g_pmdg_d[l_ac].pmdg015) THEN
                  LET g_pmdg_d[l_ac].pmdg015 = ' '
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL apmt420_pmdg_t_mask_restore('restore_mask_o')
      
               UPDATE pmdg_t SET (pmdgdocno,pmdgsite,pmdg001,pmdgseq,pmdg002,pmdg003,pmdg004,pmdg005, 
                   pmdg014,pmdg015,pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017, 
                   pmdg016,pmdg030) = (g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgsite,g_pmdg_d[l_ac].pmdg001, 
                   g_pmdg_d[l_ac].pmdgseq,g_pmdg_d[l_ac].pmdg002,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004, 
                   g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg008, 
                   g_pmdg_d[l_ac].pmdg007,g_pmdg_d[l_ac].pmdg009,g_pmdg_d[l_ac].pmdg010,g_pmdg_d[l_ac].pmdg018, 
                   g_pmdg_d[l_ac].pmdg011,g_pmdg_d[l_ac].pmdg012,g_pmdg_d[l_ac].pmdg013,g_pmdg_d[l_ac].pmdg017, 
                   g_pmdg_d[l_ac].pmdg016,g_pmdg_d[l_ac].pmdg030)
                WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno 
 
                  AND pmdgseq = g_pmdg_d_t.pmdgseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_pmdg_d[l_ac].* = g_pmdg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_pmdg_d[l_ac].* = g_pmdg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_pmdf_m.pmdfdocno
               LET gs_keys_bak[1] = g_pmdfdocno_t
               LET gs_keys[2] = g_pmdg_d[g_detail_idx].pmdgseq
               LET gs_keys_bak[2] = g_pmdg_d_t.pmdgseq
               CALL apmt420_update_b('pmdg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL apmt420_pmdg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_pmdg_d[g_detail_idx].pmdgseq = g_pmdg_d_t.pmdgseq 
 
                  ) THEN
                  LET gs_keys[01] = g_pmdf_m.pmdfdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_pmdg_d_t.pmdgseq
 
                  CALL apmt420_key_update_b(gs_keys,'pmdg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_pmdf_m),util.JSON.stringify(g_pmdg_d_t)
               LET g_log2 = util.JSON.stringify(g_pmdf_m),util.JSON.stringify(g_pmdg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_pmdg_d[l_ac].pmdgseq != g_pmdg_d_t.pmdgseq THEN
                  UPDATE pmdh_t SET pmdhseq = g_pmdg_d[l_ac].pmdgseq
                    WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
                      AND pmdhseq = g_pmdg_d_t.pmdgseq 
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdh_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')                    
                  END IF
               END IF
               IF g_pmdg_d[l_ac].pmdg009 = 'N' THEN
                  #判斷是否有維護分量計價
                  DELETE FROM pmdh_t 
                     WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
                       AND pmdhseq = g_pmdg_d[l_ac].pmdgseq
                  IF SQLCA.SQLcode  THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmdh_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')                    
                  END IF
               END IF
               #161031-00025#10---s
               CALL s_aooi360_del('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d_t.pmdgseq,'','','','','','','','1') RETURNING l_success
               IF NOT cl_null(g_pmdg_d[l_ac].ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,'','','','','','','','1',g_pmdg_d[l_ac].ooff013) RETURNING l_success
               END IF
               #161031-00025#10---e
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL apmt420_unlock_b("pmdg_t","'1'")
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
               LET g_pmdg_d[li_reproduce_target].* = g_pmdg_d[li_reproduce].*
 
               LET g_pmdg_d[li_reproduce_target].pmdgseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_pmdg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_pmdg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
      DISPLAY ARRAY g_pmdg2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL apmt420_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx2 = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"
             
            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            CALL apmt420_idx_chk()
            LET g_current_page = 2
      
         #自訂ACTION(detail_show,page_2)
         
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
{</section>}
 
{<section id="apmt420.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身  #161031-00025#10
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #161031-00025#10---s
         #為了修改功能doubleClick可以直接進入單身, 需指定要進入哪一個單身
         IF NOT cl_null(p_cmd) AND p_cmd != 'a' THEN
            CASE g_aw
               WHEN "s_detail1_aooi360_01"
                  NEXT FIELD ooff012     
            END CASE
         END IF
         #161031-00025#10---e
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD pmdfdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD pmdgsite
               WHEN "s_detail2"
                  NEXT FIELD seq
 
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
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   #若user操作時 點了退出，apmt420_01的子作業中維護的資料需要刪除
   #判斷是否有維護分量計價
   IF l_ac > 0 AND INT_FLAG = TRUE THEN
      IF p_cmd = 'a' OR (p_cmd = 'u' AND g_pmdg_d_t.pmdg009 = 'N')THEN
         DELETE FROM pmdh_t 
            WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
              AND pmdhseq = g_pmdg_d[l_ac].pmdgseq
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdh_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            CALL s_transaction_end('N','0')                    
         END IF
      END IF
   END IF
   CALL apmt420_show()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION apmt420_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL apmt420_b_fill() #單身填充
      CALL apmt420_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL apmt420_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
            #160803-00028#1---s
            #CALL apmt420_pmdfdocno_ref(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            CALL s_aooi200_get_slip_desc(g_pmdf_m.pmdfdocno) RETURNING g_pmdf_m.pmdfdocno_desc
            #160803-00028#1---e
            DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc
            
            #CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf002_desc
            #
            #CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf003_desc
            #
            #CALL apmt420_pmdf004_ref(g_pmdf_m.pmdf004) RETURNING g_pmdf_m.pmdf004_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf004_desc
            #
            #CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf005_desc
            
            CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
            DISPLAY BY NAME g_pmdf_m.pmdf006_desc
            
            #CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf009_desc
            #
            #CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
            #DISPLAY BY NAME g_pmdf_m.pmdf010_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfownid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfcrtdp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfmodid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfmodid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfmodid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfcnfid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfcnfid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfcnfid_desc


   #end add-point
   
   #遮罩相關處理
   LET g_pmdf_m_mask_o.* =  g_pmdf_m.*
   CALL apmt420_pmdf_t_mask()
   LET g_pmdf_m_mask_n.* =  g_pmdf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc,g_pmdf_m.pmdfdocdt, 
       g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003, 
       g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf006, 
       g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfownid_desc, 
       g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfmoddt, 
       g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdf_m.pmdfstus 
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
   FOR l_ac = 1 TO g_pmdg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            #CALL apmt420_pmdf004_ref(g_pmdg_d[l_ac].pmdg002) RETURNING g_pmdg_d[l_ac].pmdg002_desc
            #DISPLAY BY NAME g_pmdg_d[l_ac].pmdg002_desc

            CALL apmt420_pmdg003_ref(g_pmdg_d[l_ac].pmdg003) RETURNING g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg003_desc,g_pmdg_d[l_ac].imaal004
            
            CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004_desc

            #CALL apmt420_pmdg005_ref(g_pmdg_d[l_ac].pmdg005) RETURNING g_pmdg_d[l_ac].pmdg005_desc
            #DISPLAY BY NAME g_pmdg_d[l_ac].pmdg005_desc
            #
            #CALL apmt420_pmdg014_ref(g_pmdg_d[l_ac].pmdg014) RETURNING g_pmdg_d[l_ac].pmdg014_desc
            #DISPLAY BY NAME g_pmdg_d[l_ac].pmdg014_desc
            #
            #CALL apmt420_pmdg008_ref(g_pmdg_d[l_ac].pmdg008) RETURNING g_pmdg_d[l_ac].pmdg008_desc
            #DISPLAY BY NAME g_pmdg_d[l_ac].pmdg008_desc
            #
            #CALL apmt420_pmdg016_ref(g_pmdg_d[l_ac].pmdg016) RETURNING g_pmdg_d[l_ac].pmdg016_desc
            #DISPLAY BY NAME g_pmdg_d[l_ac].pmdg016_desc
            
            CALL apmt420_pmdf006_ref(g_pmdg_d[l_ac].pmdg018) RETURNING g_pmdg_d[l_ac].pmdg018_desc
            DISPLAY BY NAME g_pmdg_d[l_ac].pmdg018_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_pmdg2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   CALL apmt420_pmdh_fill()
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL apmt420_detail_show()
 
   #add-point:show段之後 name="show.after"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION apmt420_detail_show()
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
 
{<section id="apmt420.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION apmt420_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE pmdf_t.pmdfdocno 
   DEFINE l_oldno     LIKE pmdf_t.pmdfdocno 
 
   DEFINE l_master    RECORD LIKE pmdf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE pmdg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE pmdh_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_pmdf_m.pmdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
    
   LET g_pmdf_m.pmdfdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_pmdf_m.pmdfownid = g_user
      LET g_pmdf_m.pmdfowndp = g_dept
      LET g_pmdf_m.pmdfcrtid = g_user
      LET g_pmdf_m.pmdfcrtdp = g_dept 
      LET g_pmdf_m.pmdfcrtdt = cl_get_current()
      LET g_pmdf_m.pmdfmodid = g_user
      LET g_pmdf_m.pmdfmoddt = cl_get_current()
      LET g_pmdf_m.pmdfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_pmdf_m.pmdfstus 
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
      LET g_pmdf_m.pmdfdocno_desc = ''
   DISPLAY BY NAME g_pmdf_m.pmdfdocno_desc
 
   
   CALL apmt420_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_pmdf_m.* TO NULL
      INITIALIZE g_pmdg_d TO NULL
      INITIALIZE g_pmdg2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL apmt420_show()
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
   CALL apmt420_set_act_visible()   
   CALL apmt420_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " pmdfent = " ||g_enterprise|| " AND",
                      " pmdfdocno = '", g_pmdf_m.pmdfdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL apmt420_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL apmt420_idx_chk()
   
   LET g_data_owner = g_pmdf_m.pmdfownid      
   LET g_data_dept  = g_pmdf_m.pmdfowndp
   
   #功能已完成,通報訊息中心
   CALL apmt420_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION apmt420_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE pmdg_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE pmdh_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE apmt420_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdg_t
    WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdfdocno_t
 
    INTO TEMP apmt420_detail
 
   #將key修正為調整後   
   UPDATE apmt420_detail 
      #更新key欄位
      SET pmdgdocno = g_pmdf_m.pmdfdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO pmdg_t SELECT * FROM apmt420_detail
   
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
   DROP TABLE apmt420_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   #複製分量計價單身(子作業)
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE apmt420_detail2 AS ",
                "SELECT * FROM pmdh_t "
   PREPARE repro_tb2 FROM ls_sql
   EXECUTE repro_tb2
   FREE repro_tb2
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO apmt420_detail2 SELECT * FROM pmdh_t 
                                         WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdfdocno_t

   
   #將key修正為調整後   
   UPDATE apmt420_detail2 
      #更新key欄位
      SET pmdhdocno = g_pmdf_m.pmdfdocno

   #將資料塞回原table   
   INSERT INTO pmdh_t SELECT * FROM apmt420_detail2
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "reproduce"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   #刪除TEMP TABLE
   DROP TABLE apmt420_detail
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM pmdh_t 
    WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdfdocno_t
 
    INTO TEMP apmt420_detail
 
   #將key修正為調整後   
   UPDATE apmt420_detail SET pmdhdocno = g_pmdf_m.pmdfdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO pmdh_t SELECT * FROM apmt420_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE apmt420_detail
   
   LET g_data_owner = g_pmdf_m.pmdfownid      
   LET g_data_dept  = g_pmdf_m.pmdfowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.delete" >}
#+ 資料刪除
PRIVATE FUNCTION apmt420_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_ooff012        LIKE ooff_t.ooff012  #161031-00025#10
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_pmdf_m.pmdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN apmt420_cl USING g_enterprise,g_pmdf_m.pmdfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt420_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE apmt420_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT apmt420_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_pmdf_m_mask_o.* =  g_pmdf_m.*
   CALL apmt420_pmdf_t_mask()
   LET g_pmdf_m_mask_n.* =  g_pmdf_m.*
   
   CALL apmt420_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL apmt420_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_pmdfdocno_t = g_pmdf_m.pmdfdocno
 
 
      DELETE FROM pmdf_t
       WHERE pmdfent = g_enterprise AND pmdfdocno = g_pmdf_m.pmdfdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_pmdf_m.pmdfdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#10---s
#      IF NOT s_aooi360_del('6',g_prog,g_pmdf_m.pmdfdocno,'','','','','','','','','4') THEN
#         CALL s_transaction_end('N','0')
#         RETURN
#      END IF       
      #161031-00025#10---e
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM pmdg_t
       WHERE pmdgent = g_enterprise AND pmdgdocno = g_pmdf_m.pmdfdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      DELETE FROM pmdh_t
       WHERE pmdhent = g_enterprise AND pmdhdocno = g_pmdf_m.pmdfdocno
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmdh_t"
         LET g_errparam.popup = FALSE
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
      
            
                                                               
 
 
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM pmdh_t
       WHERE pmdhent = g_enterprise AND
             pmdhdocno = g_pmdf_m.pmdfdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      #161031-00025#10---s
      #单头的aooi360_01的备注单身资料同步删除
      DECLARE ooff_cs CURSOR FOR
         SELECT ooff012 INTO l_ooff012 FROM ooff_t WHERE ooffent = g_enterprise AND ooff001 = '6' AND ooff002 = g_pmdf_m.pmdfdocno AND ooff003 = 0
      FOREACH ooff_cs INTO l_ooff012   
         IF NOT s_aooi360_del('6',g_prog,g_pmdf_m.pmdfdocno,'','','','','','','','',l_ooff012) THEN
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END FOREACH
      CALL aooi360_01_clear_detail()   #清除备注单身  
      
      #单身的长备注栏位也要同步删除
      IF NOT s_aooi360_del('7',g_prog,g_pmdf_m.pmdfdocno,'','','','','','','','','1') THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #161031-00025#10---e
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_pmdf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE apmt420_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_pmdg_d.clear() 
      CALL g_pmdg2_d.clear()       
 
     
      CALL apmt420_ui_browser_refresh()  
      #CALL apmt420_ui_headershow()  
      #CALL apmt420_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      #160510-00011#2-S
      IF NOT s_aws_ebc_inquiry_cancel(g_pmdf_m.pmdfdocno,'D') THEN
         CALL cl_err() 
         CALL s_transaction_end('N','0')
      END IF
      #160510-00011#2-E
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL apmt420_browser_fill("")
         CALL apmt420_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE apmt420_cl
 
   #功能已完成,通報訊息中心
   CALL apmt420_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="apmt420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmt420_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_pmdg_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF apmt420_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT pmdgsite,pmdg001,pmdgseq,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014, 
             pmdg015,pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016, 
             pmdg030 ,t1.pmaal004 ,t2.imaal003 ,t3.imaal003 ,t4.oocql004 ,t5.oocal003 ,t6.oocql004 FROM pmdg_t", 
                
                     " INNER JOIN pmdf_t ON pmdfent = " ||g_enterprise|| " AND pmdfdocno = pmdgdocno ",
 
                     #"",
                     " LEFT JOIN pmdh_t ON pmdgent = pmdhent AND pmdgdocno = pmdhdocno AND pmdgseq = pmdhseq ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=pmdg002 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdg003 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=pmdg005 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='221' AND t4.oocql002=pmdg014 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=pmdg008 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='263' AND t6.oocql002=pmdg016 AND t6.oocql003='"||g_dlang||"' ",
 
                     " WHERE pmdgent=? AND pmdgdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY pmdg_t.pmdgseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt420_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR apmt420_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_pmdf_m.pmdfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_pmdf_m.pmdfdocno INTO g_pmdg_d[l_ac].pmdgsite,g_pmdg_d[l_ac].pmdg001, 
          g_pmdg_d[l_ac].pmdgseq,g_pmdg_d[l_ac].pmdg002,g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004, 
          g_pmdg_d[l_ac].pmdg005,g_pmdg_d[l_ac].pmdg014,g_pmdg_d[l_ac].pmdg015,g_pmdg_d[l_ac].pmdg008, 
          g_pmdg_d[l_ac].pmdg007,g_pmdg_d[l_ac].pmdg009,g_pmdg_d[l_ac].pmdg010,g_pmdg_d[l_ac].pmdg018, 
          g_pmdg_d[l_ac].pmdg011,g_pmdg_d[l_ac].pmdg012,g_pmdg_d[l_ac].pmdg013,g_pmdg_d[l_ac].pmdg017, 
          g_pmdg_d[l_ac].pmdg016,g_pmdg_d[l_ac].pmdg030,g_pmdg_d[l_ac].pmdg002_desc,g_pmdg_d[l_ac].pmdg003_desc, 
          g_pmdg_d[l_ac].pmdg005_desc,g_pmdg_d[l_ac].pmdg014_desc,g_pmdg_d[l_ac].pmdg008_desc,g_pmdg_d[l_ac].pmdg016_desc  
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
         CALL s_feature_description(g_pmdg_d[l_ac].pmdg003,g_pmdg_d[l_ac].pmdg004) RETURNING l_success,g_pmdg_d[l_ac].pmdg004_desc
         DISPLAY BY NAME g_pmdg_d[l_ac].pmdg004_desc
         #161031-00025#10---s
         CALL s_aooi360_sel('7',g_prog,g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdgseq,'','','','','','','','1') RETURNING l_success,g_pmdg_d[l_ac].ooff013
         #161031-00025#10---e
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
   CALL apmt420_pmdh_fill()
   #161031-00025#10---s
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog
   LET g_ooff003_d = g_pmdf_m.pmdfdocno   #单号
   LET g_ooff004_d = 0     #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 
   #161031-00025#10---e   
   #end add-point
   
   CALL g_pmdg_d.deleteElement(g_pmdg_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE apmt420_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_pmdg_d.getLength()
      LET g_pmdg_d_mask_o[l_ac].* =  g_pmdg_d[l_ac].*
      CALL apmt420_pmdg_t_mask()
      LET g_pmdg_d_mask_n[l_ac].* =  g_pmdg_d[l_ac].*
   END FOR
   
   LET g_pmdg2_d_mask_o.* =  g_pmdg2_d.*
   FOR l_ac = 1 TO g_pmdg2_d.getLength()
      LET g_pmdg2_d_mask_o[l_ac].* =  g_pmdg2_d[l_ac].*
      CALL apmt420_pmdh_t_mask()
      LET g_pmdg2_d_mask_n[l_ac].* =  g_pmdg2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION apmt420_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM pmdg_t
       WHERE pmdgent = g_enterprise AND
         pmdgdocno = ps_keys_bak[1] AND pmdgseq = ps_keys_bak[2]
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
         CALL g_pmdg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM pmdh_t
       WHERE pmdhent = g_enterprise AND
             pmdhdocno = ps_keys_bak[1] AND pmdhseq = ps_keys_bak[2] AND pmdh001 = ps_keys_bak[3] AND pmdh002 = ps_keys_bak[4]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_pmdg2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION apmt420_insert_b(ps_table,ps_keys,ps_page)
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
      IF cl_null(g_pmdg_d[g_detail_idx].pmdg004) THEN
         LET g_pmdg_d[g_detail_idx].pmdg004 = ' '
      END IF
      IF cl_null(g_pmdg_d[l_ac].pmdg014) THEN
         LET g_pmdg_d[g_detail_idx].pmdg014 = ' '
      END IF
      IF cl_null(g_pmdg_d[g_detail_idx].pmdg015) THEN
         LET g_pmdg_d[g_detail_idx].pmdg015 = ' '
      END IF
      #end add-point 
      INSERT INTO pmdg_t
                  (pmdgent,
                   pmdgdocno,
                   pmdgseq
                   ,pmdgsite,pmdg001,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014,pmdg015,pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_pmdg_d[g_detail_idx].pmdgsite,g_pmdg_d[g_detail_idx].pmdg001,g_pmdg_d[g_detail_idx].pmdg002, 
                       g_pmdg_d[g_detail_idx].pmdg003,g_pmdg_d[g_detail_idx].pmdg004,g_pmdg_d[g_detail_idx].pmdg005, 
                       g_pmdg_d[g_detail_idx].pmdg014,g_pmdg_d[g_detail_idx].pmdg015,g_pmdg_d[g_detail_idx].pmdg008, 
                       g_pmdg_d[g_detail_idx].pmdg007,g_pmdg_d[g_detail_idx].pmdg009,g_pmdg_d[g_detail_idx].pmdg010, 
                       g_pmdg_d[g_detail_idx].pmdg018,g_pmdg_d[g_detail_idx].pmdg011,g_pmdg_d[g_detail_idx].pmdg012, 
                       g_pmdg_d[g_detail_idx].pmdg013,g_pmdg_d[g_detail_idx].pmdg017,g_pmdg_d[g_detail_idx].pmdg016, 
                       g_pmdg_d[g_detail_idx].pmdg030)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_pmdg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO pmdh_t
                  (pmdhent,
                   pmdhdocno,pmdhseq,
                   pmdh001,pmdh002
                   ,pmdh003,pmdh004) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_pmdg2_d[g_detail_idx2].pmdh003,g_pmdg2_d[g_detail_idx2].pmdh004)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_pmdg2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION apmt420_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      IF cl_null(g_pmdg_d[g_detail_idx].pmdg004) THEN
         LET g_pmdg_d[g_detail_idx].pmdg004 = ' '
      END IF
      IF cl_null(g_pmdg_d[l_ac].pmdg014) THEN
         LET g_pmdg_d[g_detail_idx].pmdg014 = ' '
      END IF
      IF cl_null(g_pmdg_d[g_detail_idx].pmdg015) THEN
         LET g_pmdg_d[g_detail_idx].pmdg015 = ' '
      END IF
      #end add-point 
      
      #將遮罩欄位還原
      CALL apmt420_pmdg_t_mask_restore('restore_mask_o')
               
      UPDATE pmdg_t 
         SET (pmdgdocno,
              pmdgseq
              ,pmdgsite,pmdg001,pmdg002,pmdg003,pmdg004,pmdg005,pmdg014,pmdg015,pmdg008,pmdg007,pmdg009,pmdg010,pmdg018,pmdg011,pmdg012,pmdg013,pmdg017,pmdg016,pmdg030) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_pmdg_d[g_detail_idx].pmdgsite,g_pmdg_d[g_detail_idx].pmdg001,g_pmdg_d[g_detail_idx].pmdg002, 
                  g_pmdg_d[g_detail_idx].pmdg003,g_pmdg_d[g_detail_idx].pmdg004,g_pmdg_d[g_detail_idx].pmdg005, 
                  g_pmdg_d[g_detail_idx].pmdg014,g_pmdg_d[g_detail_idx].pmdg015,g_pmdg_d[g_detail_idx].pmdg008, 
                  g_pmdg_d[g_detail_idx].pmdg007,g_pmdg_d[g_detail_idx].pmdg009,g_pmdg_d[g_detail_idx].pmdg010, 
                  g_pmdg_d[g_detail_idx].pmdg018,g_pmdg_d[g_detail_idx].pmdg011,g_pmdg_d[g_detail_idx].pmdg012, 
                  g_pmdg_d[g_detail_idx].pmdg013,g_pmdg_d[g_detail_idx].pmdg017,g_pmdg_d[g_detail_idx].pmdg016, 
                  g_pmdg_d[g_detail_idx].pmdg030) 
         WHERE pmdgent = g_enterprise AND pmdgdocno = ps_keys_bak[1] AND pmdgseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt420_pmdg_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "pmdh_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL apmt420_pmdh_t_mask_restore('restore_mask_o')
               
      UPDATE pmdh_t 
         SET (pmdhdocno,pmdhseq,
              pmdh001,pmdh002
              ,pmdh003,pmdh004) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_pmdg2_d[g_detail_idx2].pmdh003,g_pmdg2_d[g_detail_idx2].pmdh004) 
         WHERE pmdhent = g_enterprise AND pmdhdocno = ps_keys_bak[1] AND pmdhseq = ps_keys_bak[2] AND pmdh001 = ps_keys_bak[3] AND pmdh002 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdh_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL apmt420_pmdh_t_mask_restore('restore_mask_n')
               
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
 
{<section id="apmt420.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION apmt420_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'pmdg_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE pmdh_t 
         SET (pmdhdocno,pmdhseq) 
              = 
             (g_pmdf_m.pmdfdocno,g_pmdg_d[g_detail_idx].pmdgseq) 
         WHERE pmdhent = g_enterprise AND
               pmdhdocno = ps_keys_bak[1] AND pmdhseq = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
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
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION apmt420_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'pmdg_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM pmdh_t 
            WHERE pmdhent = g_enterprise AND
                  pmdhdocno = ps_keys_bak[1] AND pmdhseq = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "pmdh_t:",SQLERRMESSAGE 
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
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION apmt420_lock_b(ps_table,ps_page)
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
   #CALL apmt420_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "pmdg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN apmt420_bcl USING g_enterprise,
                                       g_pmdf_m.pmdfdocno,g_pmdg_d[g_detail_idx].pmdgseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt420_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "pmdh_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN apmt420_bcl2 USING g_enterprise,
                                             g_pmdf_m.pmdfdocno,g_pmdg_d[g_detail_idx].pmdgseq,
                                             g_pmdg2_d[g_detail_idx2].pmdh001,g_pmdg2_d[g_detail_idx2].pmdh002 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apmt420_bcl2:",SQLERRMESSAGE 
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
 
{<section id="apmt420.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION apmt420_unlock_b(ps_table,ps_page)
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
      CLOSE apmt420_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE apmt420_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION apmt420_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("pmdfdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("pmdfdocno",TRUE)
      CALL cl_set_comp_entry("pmdfdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("pmdfdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("pmdg002",TRUE)
   CALL cl_set_comp_entry("pmdf002,pmdf003,pmdf004,pmdf005,pmdf006,pmdf009,pmdf010,pmdf030",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION apmt420_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_fields  STRING
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("pmdfdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("pmdfdocdt",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("pmdfdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("pmdfdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   #IF g_flag THEN   #單據別已經編號，單據編號、單據日期欄位不可修改
   #   CALL cl_set_comp_entry("pmdfdocno,pmdfdocdt",FALSE)
   #END IF
   #
   IF NOT cl_null(g_pmdf_m.pmdf004) THEN
      CALL cl_set_comp_entry("pmdg002",FALSE)
   END IF
   
   #依單據別設定判斷欄位是否需要做輸入控制
   IF NOT cl_null(g_pmdf_m.pmdfdocno) THEN
      LET l_fields = ''
      CALL s_aooi200_get_doc_fields(g_site,'1',g_pmdf_m.pmdfdocno) RETURNING l_fields
      CALL cl_set_comp_entry(l_fields,FALSE)
   END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION apmt420_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("pmdg004,pmdg010,pmdg012",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION apmt420_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
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
  
   #當料件有使用產品特徵功能時此欄位才可輸入
   LET l_imaa005  = ''
   SELECT imaa005 INTO l_imaa005 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_pmdg_d[l_ac].pmdg003
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pmdg004",FALSE)
   END IF
   
   IF g_pmdg_d[l_ac].pmdg009 = 'Y' THEN
      CALL cl_set_comp_entry("pmdg010,pmdg012",FALSE)
      LET g_pmdg_d[l_ac].pmdg010 = 0
      LET g_pmdg_d[l_ac].pmdg012 = 0
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION apmt420_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("open_apmt420_01",TRUE)  #add by lixiang 2016/1/13
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION apmt420_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_pmdf_m.pmdfstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail,open_apmt420_01", FALSE)  #add by lixiang 2016/1/13 open_apmt420_01
   END IF

   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION apmt420_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("open_apmt420_01",TRUE) #add by lixiang 2016/1/13
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION apmt420_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   #add by lixiang 2016/1/13--begin---
   IF g_pmdf_m.pmdfstus NOT MATCHES "[NDR]" OR g_pmdg_d[l_ac].pmdg009 = 'N' THEN
      CALL cl_set_act_visible("open_apmt420_01",FALSE)
   END IF
   #add by lixiang 2016/1/13--end---
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION apmt420_default_search()
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
      LET ls_wc = ls_wc, " pmdfdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " pmdfdocno = '", g_argv[02], "' AND "
   END IF
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
               WHEN la_wc[li_idx].tableid = "pmdf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "pmdg_t" 
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
   IF g_argv[01] = '1' THEN
      LET g_wc = g_wc , " AND pmdf001 = 'N' "
   END IF
   IF g_argv[01] = '2' THEN
      LET g_wc = g_wc , " AND pmdf001 = 'Y' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmt420.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION apmt420_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_pmdf_m.pmdfstus = 'X' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_pmdf_m.pmdfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN apmt420_cl USING g_enterprise,g_pmdf_m.pmdfdocno
   IF STATUS THEN
      CLOSE apmt420_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN apmt420_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
       g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
       g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
       g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
       g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT apmt420_action_chk() THEN
      CLOSE apmt420_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc,g_pmdf_m.pmdfdocdt, 
       g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003, 
       g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf006, 
       g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf009_desc, 
       g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfownid_desc, 
       g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc,g_pmdf_m.pmdfcrtdp, 
       g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfmoddt, 
       g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
 
   CASE g_pmdf_m.pmdfstus
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
         CASE g_pmdf_m.pmdfstus
            
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
      CALL cl_set_act_visible("open,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_pmdf_m.pmdfstus 
         WHEN "N"
            CALL cl_set_act_visible("open",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)
            
         WHEN "X"
            CALL cl_set_act_visible("open,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT apmt420_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt420_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT apmt420_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE apmt420_cl
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
      g_pmdf_m.pmdfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE apmt420_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
      CALL s_transaction_begin()
      IF lc_state = 'Y' THEN
         CALL s_apmt420_conf_chk(g_pmdf_m.pmdfdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN
            ELSE
               CALL s_apmt420_conf_upd(g_pmdf_m.pmdfdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      IF lc_state = 'N' THEN
         CALL s_apmt420_unconf_chk(g_pmdf_m.pmdfdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00110') THEN
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN
            ELSE
               CALL s_apmt420_unconf_upd(g_pmdf_m.pmdfdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
      IF lc_state = 'X' THEN
         CALL s_apmt420_invalid_chk(g_pmdf_m.pmdfdocno) RETURNING l_success
         IF NOT l_success THEN
            CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
            RETURN
         ELSE
            IF NOT cl_ask_confirm('aim-00109') THEN
               CALL s_transaction_end('N','0')     #160812-00017#7 Add By Ken 160816
               RETURN
            ELSE
               CALL s_apmt420_invalid_upd(g_pmdf_m.pmdfdocno) RETURNING l_success
               IF NOT l_success THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  #160510-00011#2-S
                  IF NOT s_aws_ebc_inquiry_cancel(g_pmdf_m.pmdfdocno,'X') THEN
                     CALL cl_err() 
                     CALL s_transaction_end('N','0')
                  END IF
                  #160510-00011#2-E
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
         END IF
      END IF
   #end add-point
   
   LET g_pmdf_m.pmdfmodid = g_user
   LET g_pmdf_m.pmdfmoddt = cl_get_current()
   LET g_pmdf_m.pmdfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE pmdf_t 
      SET (pmdfstus,pmdfmodid,pmdfmoddt) 
        = (g_pmdf_m.pmdfstus,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt)     
    WHERE pmdfent = g_enterprise AND pmdfdocno = g_pmdf_m.pmdfdocno
 
    
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
      EXECUTE apmt420_master_referesh USING g_pmdf_m.pmdfdocno INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite, 
          g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003,g_pmdf_m.pmdfstus, 
          g_pmdf_m.pmdf005,g_pmdf_m.pmdf006,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf010, 
          g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
          g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt, 
          g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf009_desc, 
          g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid_desc, 
          g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc, 
          g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc, 
          g_pmdf_m.pmdf003,g_pmdf_m.pmdf003_desc,g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc, 
          g_pmdf_m.pmdf006,g_pmdf_m.pmdf006_desc,g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009, 
          g_pmdf_m.pmdf009_desc,g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid, 
          g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc, 
          g_pmdf_m.pmdfcrtdp,g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc, 
          g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE apmt420_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL apmt420_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt420.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION apmt420_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_pmdg_d.getLength() THEN
         LET g_detail_idx = g_pmdg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_pmdg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_pmdg_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_pmdg2_d.getLength() THEN
         LET g_detail_idx2 = g_pmdg2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_pmdg2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_pmdg2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmt420_b_fill2(pi_idx)
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
   
   IF apmt420_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_pmdg_d.getLength() > 0 THEN
               CALL g_pmdg2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT pmdh001,pmdh002,pmdh003,pmdh004  FROM pmdh_t",    
                     "",
                     
                     " WHERE pmdhent=? AND pmdhdocno=? AND pmdhseq=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  pmdh_t.pmdh001,pmdh_t.pmdh002" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         
         #end add-point
         
         #先清空資料
               CALL g_pmdg2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE apmt420_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR apmt420_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_pmdf_m.pmdfdocno,g_pmdg_d[g_detail_idx].pmdgseq   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_pmdf_m.pmdfdocno,g_pmdg_d[g_detail_idx].pmdgseq INTO g_pmdg2_d[l_ac].pmdh001, 
             g_pmdg2_d[l_ac].pmdh002,g_pmdg2_d[l_ac].pmdh003,g_pmdg2_d[l_ac].pmdh004   #(ver:78)
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
               CALL g_pmdg2_d.deleteElement(g_pmdg2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_pmdg2_d_mask_o.* =  g_pmdg2_d.*
   FOR l_ac = 1 TO g_pmdg2_d.getLength()
      LET g_pmdg2_d_mask_o[l_ac].* =  g_pmdg2_d[l_ac].*
      CALL apmt420_pmdh_t_mask()
      LET g_pmdg2_d_mask_n[l_ac].* =  g_pmdg2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL apmt420_pmdh_fill()
   #end add-point
    
   LET l_ac = li_ac
   
   CALL apmt420_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION apmt420_fill_chk(ps_idx)
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
 
{<section id="apmt420.status_show" >}
PRIVATE FUNCTION apmt420_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmt420.mask_functions" >}
&include "erp/apm/apmt420_mask.4gl"
 
{</section>}
 
{<section id="apmt420.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION apmt420_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL apmt420_show()
   CALL apmt420_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   IF NOT s_apmt420_conf_chk(g_pmdf_m.pmdfdocno) THEN 
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_pmdf_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_pmdg_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_pmdg2_d))
 
 
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
   #CALL apmt420_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL apmt420_ui_headershow()
   CALL apmt420_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION apmt420_draw_out()
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
   CALL apmt420_ui_headershow()  
   CALL apmt420_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="apmt420.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION apmt420_set_pk_array()
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
   LET g_pk_array[1].values = g_pmdf_m.pmdfdocno
   LET g_pk_array[1].column = 'pmdfdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt420.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="apmt420.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION apmt420_msgcentre_notify(lc_state)
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
   CALL apmt420_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_pmdf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="apmt420.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION apmt420_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#27--s
   SELECT pmdfstus INTO g_pmdf_m.pmdfstus FROM pmdf_t WHERE pmdfent = g_enterprise AND pmdfdocno = g_pmdf_m.pmdfdocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
      LET g_errno = NULL
      CASE g_pmdf_m.pmdfstus  
        WHEN "Y"
           LET g_errno = 'sub-00178'
        WHEN "C"
           LET g_errno = 'ain-00197'
        WHEN "W"
           LET g_errno = 'sub-01347'
        WHEN "X"
           LET g_errno = 'sub-00229'
      
      END CASE
      
      IF NOT cl_null(g_errno) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = g_errno
         LET g_errparam.extend = g_pmdf_m.pmdfstus
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_errno = NULL
         CALL apmt420_set_act_visible()
         CALL apmt420_set_act_no_visible()
         CALL apmt420_show()
         RETURN FALSE
      END IF
   END IF
   #160818-00017#27---e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="apmt420.other_function" readonly="Y" >}
#複製功能單頭初始化
PRIVATE FUNCTION apmt420_reproduce_init()
      LET g_pmdf_m.pmdfdocno = ''
      LET g_pmdf_m.pmdfdocno_desc = ''
      LET g_pmdf_m.pmdfdocdt = g_today
      DISPLAY BY NAME g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocno_desc,g_pmdf_m.pmdfdocdt
      LET g_pmdf_m.pmdfstus = 'N'
      CALL gfrm_curr.setElementImage("statechange", "stus/32/open.png")
      DISPLAY BY NAME g_pmdf_m.pmdfstus
      LET g_pmdf_m.pmdf002 = g_user
      LET g_pmdf_m.pmdf003 = g_dept
      CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
      DISPLAY BY NAME g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc
      
      CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
      DISPLAY BY NAME g_pmdf_m.pmdf003,g_pmdf_m.pmdf003_desc
      
      LET g_pmdf_m.pmdfownid = g_user
      LET g_pmdf_m.pmdfowndp = g_dept
      LET g_pmdf_m.pmdfcrtid = g_user
      LET g_pmdf_m.pmdfcrtdp = g_dept 
      LET g_pmdf_m.pmdfcrtdt = cl_get_current()
      LET g_pmdf_m.pmdfmodid = NULL
      LET g_pmdf_m.pmdfmodid_desc = NULL
      LET g_pmdf_m.pmdfmoddt = NULL
      LET g_pmdf_m.pmdfcnfid = NULL
      LET g_pmdf_m.pmdfcnfid_desc = NULL
      LET g_pmdf_m.pmdfcnfdt = NULL
      
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfownid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfownid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfownid_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfowndp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfowndp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfowndp_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfcrtid
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfcrtid_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfcrtid_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmdf_m.pmdfcrtdp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmdf_m.pmdfcrtdp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmdf_m.pmdfcrtdp_desc


            DISPLAY BY NAME g_pmdf_m.pmdfownid,g_pmdf_m.pmdfownid_desc,g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfowndp_desc,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtid_desc,g_pmdf_m.pmdfcrtdp,g_pmdf_m.pmdfcrtdp_desc,g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmodid_desc,g_pmdf_m.pmdfmoddt,g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfid_desc,g_pmdf_m.pmdfcnfdt
   
      
      INITIALIZE g_pmdf_m_t.* TO NULL
      LET g_pmdf_m_t.* = g_pmdf_m.*
               
END FUNCTION
#已經自動編號過的單據編號，抓取對應的單據別說明
PRIVATE FUNCTION apmt420_pmdfdocno_ref(p_pmdfdocno)
DEFINE p_pmdfdocno    LIKE pmdf_t.pmdfdocno
DEFINE l_oobal002     LIKE oobal_t.oobal002
DEFINE l_ooef004      LIKE ooef_t.ooef004
DEFINE r_pmdfdocno_desc  LIKE oobal_t.oobal004
DEFINE l_flag          LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_flag1         LIKE type_t.num5          #标识符，TRUE/FALSE
DEFINE l_site          LIKE type_t.chr20


      LET l_flag = TRUE
      LET l_flag1 = TRUE
      LET l_ooef004 = NULL
      LET l_oobal002 = NULL
      IF NOT cl_null(p_pmdfdocno) THEN
         CALL s_aooi200_get_site(p_pmdfdocno) RETURNING l_flag,l_site
         IF l_flag THEN
            SELECT ooef004 INTO l_ooef004 FROM ooef_t
             WHERE ooef005 = l_site
               AND ooefent = g_enterprise
         END IF
         CALL s_aooi200_get_slip(p_pmdfdocno) RETURNING l_flag1,l_oobal002
         IF l_flag1 THEN
            IF NOT cl_null(l_oobal002) AND NOT cl_null(l_ooef004) THEN
               SELECT oobal004 INTO r_pmdfdocno_desc FROM oobal_t
                WHERE oobal001 = l_ooef004
                  AND oobal002 = l_oobal002
                  AND oobal003 = g_dlang
                  AND oobalent = g_enterprise
            ELSE
               LET r_pmdfdocno_desc = ""
            END IF
         END IF
      ELSE
         LET r_pmdfdocno_desc = ""
      END IF

      RETURN r_pmdfdocno_desc
      
END FUNCTION
#未自動編號的單據別，抓取對應的說明
PRIVATE FUNCTION apmt420_get_oobal004(p_pmdfdocno)
DEFINE p_pmdfdocno    LIKE pmdf_t.pmdfdocno
DEFINE r_pmdfdocno_desc  LIKE oobal_t.oobal004

      IF NOT cl_null(p_pmdfdocno) THEN
         SELECT oobal004 INTO r_pmdfdocno_desc FROM oobal_t,ooef_t
          WHERE ooef001 = g_site AND ooefent = oobalent
            AND oobal001 = ooef004
            AND oobal002 = p_pmdfdocno
            AND oobal003 = g_dlang
            AND oobalent = g_enterprise
      END IF
   
      RETURN r_pmdfdocno_desc
   
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf004_chk(p_pmdf004)
DEFINE p_pmdf004    LIKE pmdf_t.pmdf004
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5

      LET r_success = TRUE
      
      IF NOT cl_null(p_pmdf004) THEN
         #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
         CALL s_control_chk_doc('2',g_pmdf_m.pmdfdocno,p_pmdf004,'','','','') RETURNING l_success,l_flag
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            IF NOT l_flag THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00239'
               LET g_errparam.extend = p_pmdf004
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
         
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = p_pmdf004

            
         #呼叫檢查存在並帶值的library
         IF cl_chk_exist("v_pmaa001_1") THEN
            #檢查成功時後續處理             
         ELSE
            #檢查失敗時後續處理
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
      
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf004_ref(p_pmdf004)
DEFINE p_pmdf004     LIKE pmdf_t.pmdf004
DEFINE r_pmaal004    LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf004
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmaal004 = '', g_rtn_fields[1] , ''
       RETURN r_pmaal004
       
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf005_ref(p_pmdf005)
DEFINE p_pmdf005      LIKE pmdf_t.pmdf005
DEFINE r_pmdf005_desc LIKE ooail_t.ooail003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf005
       CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdf005_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdf005_desc
     
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf006_ref(p_pmdf006)
DEFINE p_pmdf006      LIKE pmdf_t.pmdf006
DEFINE r_pmdf006_desc LIKE oodbl_t.oodbl004
DEFINE l_ooef019      LIKE ooef_t.ooef019

       LET l_ooef019 = ''
       SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
       
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf006
       CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001 = '"||l_ooef019||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdf006_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdf006_desc
      
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf009_ref(p_pmdf009)
DEFINE p_pmdf009      LIKE pmdf_t.pmdf009
DEFINE r_pmdf009_desc LIKE ooibl_t.ooibl004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf009
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdf009_desc = g_rtn_fields[1]
       RETURN r_pmdf009_desc
    
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf010_ref(p_pmdf010)
DEFINE p_pmdf010      LIKE pmdf_t.pmdf010
DEFINE r_pmdf010_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf010
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='238' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdf010_desc = g_rtn_fields[1]
       RETURN r_pmdf010_desc
   
END FUNCTION

PRIVATE FUNCTION apmt420_pmdf002_ref(p_pmdf002)
DEFINE p_pmdf002      LIKE pmdf_t.pmdf002
DEFINE r_pmdf002_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf002
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET r_pmdf002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdf002_desc

END FUNCTION

PRIVATE FUNCTION apmt420_pmdf003_ref(p_pmdf003)
DEFINE p_pmdf003      LIKE pmdf_t.pmdf003
DEFINE r_pmdf003_desc LIKE oofa_t.oofa011

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdf003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdf003_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdf003_desc

END FUNCTION

PRIVATE FUNCTION apmt420_pmdg003_ref(p_pmdg003)
DEFINE p_pmdg003      LIKE pmdg_t.pmdg003
DEFINE r_imaal003     LIKE imaal_t.imaal003
DEFINE r_imaal004     LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdg003
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004

END FUNCTION

PRIVATE FUNCTION apmt420_pmdg005_ref(p_pmdg005)
DEFINE p_pmdg005      LIKE pmdg_t.pmdg005
DEFINE r_imaal003     LIKE imaal_t.imaal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdg005
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       RETURN r_imaal003

END FUNCTION

PRIVATE FUNCTION apmt420_pmdg014_ref(p_pmdg014)
DEFINE p_pmdg014      LIKE pmdg_t.pmdg014
DEFINE r_pmdg014_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdg014
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdg014_desc = g_rtn_fields[1]
       RETURN r_pmdg014_desc
   
END FUNCTION
#呼叫單位取位的應用元件對數量與最低採購數量進行取位
PRIVATE FUNCTION apmt420_pmdg008_round()
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
        
       LET l_success = NULL
       LET l_ooca002 = 0
       LET l_ooca004 = NULL
       
       #抓取单位档中的小数位数和舍入类型
       IF NOT cl_null(g_pmdg_d[l_ac].pmdg008) THEN
          CALL s_aooi250_get_msg(g_pmdg_d[l_ac].pmdg008) RETURNING l_success,l_ooca002,l_ooca004
          IF l_success THEN
             IF NOT cl_null(g_pmdg_d[l_ac].pmdg007) THEN
                CALL s_num_round(l_ooca004,g_pmdg_d[l_ac].pmdg007,l_ooca002) RETURNING g_pmdg_d[l_ac].pmdg007
                DISPLAY BY NAME g_pmdg_d[l_ac].pmdg007
             END IF
             IF NOT cl_null(g_pmdg_d[l_ac].pmdg013) THEN
                CALL s_num_round(l_ooca004,g_pmdg_d[l_ac].pmdg013,l_ooca002) RETURNING g_pmdg_d[l_ac].pmdg013
                DISPLAY BY NAME g_pmdg_d[l_ac].pmdg013
             END IF
          END IF
       END IF
       
END FUNCTION

PRIVATE FUNCTION apmt420_pmdg008_ref(p_pmdg008)
DEFINE p_pmdg008      LIKE pmdg_t.pmdg008
DEFINE r_pmdg008_desc LIKE oocal_t.oocal003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdg008
       CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdg008_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdg008_desc

END FUNCTION

PRIVATE FUNCTION apmt420_pmdg016_ref(p_pmdg016)
DEFINE p_pmdg016      LIKE pmdg_t.pmdg016
DEFINE r_pmdg016_desc LIKE oocql_t.oocql004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdg016
       CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='263' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmdg016_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmdg016_desc

END FUNCTION

PRIVATE FUNCTION apmt420_pmdg003_chk(p_pmdg003)
DEFINE p_pmdg003    LIKE pmdg_t.pmdg003
DEFINE l_success    LIKE type_t.num5
DEFINE l_flag       LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5
  
      LET r_success = TRUE
      
      IF NOT cl_null(p_pmdg003) THEN
         #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
         CALL s_control_chk_doc('4',g_pmdf_m.pmdfdocno,p_pmdg003,'','','','') RETURNING l_success,l_flag
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            IF NOT l_flag THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00015'
               LET g_errparam.extend = p_pmdg003
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         
         #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
         CALL s_control_chk_doc('5',g_pmdf_m.pmdfdocno,g_pmdg_d[l_ac].pmdg003,'','','','') RETURNING l_success,l_flag
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         ELSE
            IF NOT l_flag THEN
               #CALL cl_err(p_pmdg003,'apm-00238',1)
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF

         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
         
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = g_pmdg_d[l_ac].pmdg003
           
         #呼叫檢查存在並帶值的library
         IF cl_chk_exist("v_imaa001") THEN
            IF NOT cl_chk_exist("v_imaf001_1") THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         ELSE
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      RETURN r_success
            
END FUNCTION

PRIVATE FUNCTION apmt420_pmdh_fill()
DEFINE li_ac           LIKE type_t.num5

       CALL g_pmdg2_d.clear()

       LET g_sql = "SELECT  UNIQUE pmdhseq,pmdh001,pmdh002,pmdh003,pmdh004 FROM pmdh_t",    
                   "",
                   " WHERE pmdhent=? AND pmdhdocno=? "
       
       IF NOT cl_null(g_wc2_table2) THEN
          LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
       END IF
       
       LET g_sql = g_sql, " ORDER BY  pmdh_t.pmdhseq,pmdh_t.pmdh001,pmdh_t.pmdh002" 
       
       PREPARE apmt420_pb3 FROM g_sql
       DECLARE b_fill_curs3 CURSOR FOR apmt420_pb3
       
       OPEN b_fill_curs3 USING g_enterprise,g_pmdf_m.pmdfdocno
       LET li_ac = 1
       FOREACH b_fill_curs3 INTO g_pmdg2_d[li_ac].seq,g_pmdg2_d[li_ac].pmdh001,g_pmdg2_d[li_ac].pmdh002,g_pmdg2_d[li_ac].pmdh003,g_pmdg2_d[li_ac].pmdh004
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF

          LET li_ac = li_ac + 1
          IF l_ac > g_max_rec THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  9035
             LET g_errparam.extend =  ''
             LET g_errparam.popup = FALSE
             CALL cl_err()

             EXIT FOREACH
          END IF
          
       END FOREACH
       CALL g_pmdg2_d.deleteElement(g_pmdg2_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 取得單據別設定的欄位預設值
# Memo...........: 需搭配單據別aooi200的設定
# Usage..........: CALL apmt420_get_col_default()
# Date & Author..: 2014/03/10 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt420_get_col_default()
   LET g_pmdf_m.pmdfdocdt = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdfdocdt',g_pmdf_m.pmdfdocdt)
   LET g_pmdf_m.pmdf002 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf002',g_pmdf_m.pmdf002)
   LET g_pmdf_m.pmdf003 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf003',g_pmdf_m.pmdf003)
   LET g_pmdf_m.pmdf004 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf004',g_pmdf_m.pmdf004)
   LET g_pmdf_m.pmdf005 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf005',g_pmdf_m.pmdf005)
   LET g_pmdf_m.pmdf006 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf006',g_pmdf_m.pmdf006)
   LET g_pmdf_m.pmdf007 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf007',g_pmdf_m.pmdf007)
   LET g_pmdf_m.pmdf008 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf008',g_pmdf_m.pmdf008)
   LET g_pmdf_m.pmdf009 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf009',g_pmdf_m.pmdf009)
   LET g_pmdf_m.pmdf010 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf010',g_pmdf_m.pmdf010)
   LET g_pmdf_m.pmdf030 = s_aooi200_get_doc_default(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf030',g_pmdf_m.pmdf030)
   
   DISPLAY BY NAME g_pmdf_m.pmdfdocdt,g_pmdf_m.pmdf002,g_pmdf_m.pmdf002_desc,g_pmdf_m.pmdfdocno_desc,
       g_pmdf_m.pmdf004,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf003,g_pmdf_m.pmdf003_desc, 
       g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf005_desc,g_pmdf_m.pmdf006,g_pmdf_m.pmdf006_desc, 
       g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,g_pmdf_m.pmdf009_desc,g_pmdf_m.pmdf010,g_pmdf_m.pmdf010_desc, 
       g_pmdf_m.pmdf030
       
       
   CALL apmt420_pmdf002_ref(g_pmdf_m.pmdf002) RETURNING g_pmdf_m.pmdf002_desc
   DISPLAY BY NAME g_pmdf_m.pmdf002_desc
   
   CALL apmt420_pmdf003_ref(g_pmdf_m.pmdf003) RETURNING g_pmdf_m.pmdf003_desc
   DISPLAY BY NAME g_pmdf_m.pmdf003_desc
   
   CALL apmt420_pmdf004_ref(g_pmdf_m.pmdf004) RETURNING g_pmdf_m.pmdf004_desc
   DISPLAY BY NAME g_pmdf_m.pmdf004_desc
   
   CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
   DISPLAY BY NAME g_pmdf_m.pmdf005_desc
   
   CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
   DISPLAY BY NAME g_pmdf_m.pmdf006_desc
   
   CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
   DISPLAY BY NAME g_pmdf_m.pmdf009_desc
   
   CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
   DISPLAY BY NAME g_pmdf_m.pmdf010_desc
            
END FUNCTION
#根據供應商帶出相關欄位預設值
PRIVATE FUNCTION apmt420_pmdf004_desc()
DEFINE l_success   LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmab      RECORD LIKE pmab_t.*
DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企业编号
       pmabsite LIKE pmab_t.pmabsite, #营运据点
       pmab001 LIKE pmab_t.pmab001, #交易对象编号
       pmab002 LIKE pmab_t.pmab002, #信用额度检查
       pmab003 LIKE pmab_t.pmab003, #额度交易对象
       pmab004 LIKE pmab_t.pmab004, #信用评核等级
       pmab005 LIKE pmab_t.pmab005, #额度计算币种
       pmab006 LIKE pmab_t.pmab006, #企业额度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
       pmab010 LIKE pmab_t.pmab010, #允许除外额度
       pmab011 LIKE pmab_t.pmab011, #额度警示水准一
       pmab012 LIKE pmab_t.pmab012, #水准一通知层
       pmab013 LIKE pmab_t.pmab013, #额度警示水准二
       pmab014 LIKE pmab_t.pmab014, #水准二通知层
       pmab015 LIKE pmab_t.pmab015, #额度警示水准三
       pmab016 LIKE pmab_t.pmab016, #水准三通知层
       pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
       pmab018 LIKE pmab_t.pmab018, #预期应收通知层
       pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
       pmab031 LIKE pmab_t.pmab031, #负责采购人员
       pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
       pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
       pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
       pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
       pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
       pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
       pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
       pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
       pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
       pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
       pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
       pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
       pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
       pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
       pmab046 LIKE pmab_t.pmab046, #供应商折扣率
       pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
       pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
       pmab052 LIKE pmab_t.pmab052, #可提前收货天数
       pmab053 LIKE pmab_t.pmab053, #惯用交易条件
       pmab054 LIKE pmab_t.pmab054, #惯用取价方式
       pmab055 LIKE pmab_t.pmab055, #应付账款类别
       pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
       pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
       pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
       pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
       pmab061 LIKE pmab_t.pmab061, #价格评分
       pmab062 LIKE pmab_t.pmab062, #达交率评分
       pmab063 LIKE pmab_t.pmab063, #质量评分
       pmab064 LIKE pmab_t.pmab064, #配合度评分
       pmab065 LIKE pmab_t.pmab065, #调整加减分
       pmab066 LIKE pmab_t.pmab066, #定性评分一
       pmab067 LIKE pmab_t.pmab067, #定性评分二
       pmab068 LIKE pmab_t.pmab068, #定性评分三
       pmab069 LIKE pmab_t.pmab069, #定性评分四
       pmab070 LIKE pmab_t.pmab070, #定性评分五
       pmab071 LIKE pmab_t.pmab071, #检验程度
       pmab072 LIKE pmab_t.pmab072, #检验水准
       pmab073 LIKE pmab_t.pmab073, #检验级数
       pmab080 LIKE pmab_t.pmab080, #客户ABC分类
       pmab081 LIKE pmab_t.pmab081, #负责业务人员
       pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
       pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
       pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
       pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
       pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
       pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
       pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
       pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
       pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
       pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
       pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
       pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
       pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
       pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
       pmab096 LIKE pmab_t.pmab096, #客户折扣率
       pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
       pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
       pmab102 LIKE pmab_t.pmab102, #可提前交货天数
       pmab103 LIKE pmab_t.pmab103, #惯用交易条件
       pmab104 LIKE pmab_t.pmab104, #惯用取价方式
       pmab105 LIKE pmab_t.pmab105, #应收账款类别
       pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
       pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
       pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
       pmabownid LIKE pmab_t.pmabownid, #资料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
       pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
       pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
       pmabstus LIKE pmab_t.pmabstus, #状态码
       pmab059 LIKE pmab_t.pmab059, #负责采购部门
       pmab109 LIKE pmab_t.pmab109, #负责业务部门
       pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
       pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
       pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
       pmab020 LIKE pmab_t.pmab020, #除外额有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
END RECORD
#161124-00048#9 mod-E

        INITIALIZE l_pmab.* TO NULL        
	    
        #先抓據點級
        #161124-00048#9 mod-S
#        SELECT pmab_t.* INTO l_pmab.* FROM pmab_t,pmaa_t 
        SELECT pmab_t.pmabent,  pmab_t.pmabsite, pmab_t.pmab001,  pmab_t.pmab002,  pmab_t.pmab003,
               pmab_t.pmab004,  pmab_t.pmab005,  pmab_t.pmab006,  pmab_t.pmab007,  pmab_t.pmab008,
               pmab_t.pmab009,  pmab_t.pmab010,  pmab_t.pmab011,  pmab_t.pmab012,  pmab_t.pmab013,
               pmab_t.pmab014,  pmab_t.pmab015,  pmab_t.pmab016,  pmab_t.pmab017,  pmab_t.pmab018,
               pmab_t.pmab030,  pmab_t.pmab031,  pmab_t.pmab032,  pmab_t.pmab033,  pmab_t.pmab034,
               pmab_t.pmab035,  pmab_t.pmab036,  pmab_t.pmab037,  pmab_t.pmab038,  pmab_t.pmab039,
               pmab_t.pmab040,  pmab_t.pmab041,  pmab_t.pmab042,  pmab_t.pmab043,  pmab_t.pmab044,
               pmab_t.pmab045,  pmab_t.pmab046,  pmab_t.pmab047,  pmab_t.pmab048,  pmab_t.pmab049,
               pmab_t.pmab050,  pmab_t.pmab051,  pmab_t.pmab052,  pmab_t.pmab053,  pmab_t.pmab054,
               pmab_t.pmab055,  pmab_t.pmab056,  pmab_t.pmab057,  pmab_t.pmab058,  pmab_t.pmab060,
               pmab_t.pmab061,  pmab_t.pmab062,  pmab_t.pmab063,  pmab_t.pmab064,  pmab_t.pmab065,
               pmab_t.pmab066,  pmab_t.pmab067,  pmab_t.pmab068,  pmab_t.pmab069,  pmab_t.pmab070,
               pmab_t.pmab071,  pmab_t.pmab072,  pmab_t.pmab073,  pmab_t.pmab080,  pmab_t.pmab081,
               pmab_t.pmab082,  pmab_t.pmab083,  pmab_t.pmab084,  pmab_t.pmab085,  pmab_t.pmab086,
               pmab_t.pmab087,  pmab_t.pmab088,  pmab_t.pmab089,  pmab_t.pmab090,  pmab_t.pmab091,
               pmab_t.pmab092,  pmab_t.pmab093,  pmab_t.pmab094,  pmab_t.pmab095,  pmab_t.pmab096,
               pmab_t.pmab097,  pmab_t.pmab098,  pmab_t.pmab099,  pmab_t.pmab100,  pmab_t.pmab101,
               pmab_t.pmab102,  pmab_t.pmab103,  pmab_t.pmab104,  pmab_t.pmab105,  pmab_t.pmab106,
               pmab_t.pmab107,  pmab_t.pmab108,  pmab_t.pmabownid,pmab_t.pmabowndp,pmab_t.pmabcrtid,
               pmab_t.pmabcrtdp,pmab_t.pmabcrtdt,pmab_t.pmabmodid,pmab_t.pmabmoddt,pmab_t.pmabcnfid,
               pmab_t.pmabcnfdt,pmab_t.pmabstus, pmab_t.pmab059,  pmab_t.pmab109,  pmab_t.pmab110,
               pmab_t.pmab111,  pmab_t.pmab019,  pmab_t.pmab020,  pmab_t.pmab112 
          INTO l_pmab.*  
          FROM pmab_t,pmaa_t 
        #161124-00048#9 mod-E
              WHERE pmabent = pmaaent AND pmab001 = pmaa001 AND pmaastus = 'Y'
                AND pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = g_pmdf_m.pmdf004  
        #據點級沒有設置慣用資料，則抓集團層
        IF SQLCA.sqlcode = 100 THEN
             #161124-00048#9 mod-S
#             SELECT pmab_t.* INTO l_pmab.* FROM pmab_t,pmaa_t 
             SELECT pmab_t.pmabent,  pmab_t.pmabsite, pmab_t.pmab001,  pmab_t.pmab002,  pmab_t.pmab003,
                    pmab_t.pmab004,  pmab_t.pmab005,  pmab_t.pmab006,  pmab_t.pmab007,  pmab_t.pmab008,
                    pmab_t.pmab009,  pmab_t.pmab010,  pmab_t.pmab011,  pmab_t.pmab012,  pmab_t.pmab013,
                    pmab_t.pmab014,  pmab_t.pmab015,  pmab_t.pmab016,  pmab_t.pmab017,  pmab_t.pmab018,
                    pmab_t.pmab030,  pmab_t.pmab031,  pmab_t.pmab032,  pmab_t.pmab033,  pmab_t.pmab034,
                    pmab_t.pmab035,  pmab_t.pmab036,  pmab_t.pmab037,  pmab_t.pmab038,  pmab_t.pmab039,
                    pmab_t.pmab040,  pmab_t.pmab041,  pmab_t.pmab042,  pmab_t.pmab043,  pmab_t.pmab044,
                    pmab_t.pmab045,  pmab_t.pmab046,  pmab_t.pmab047,  pmab_t.pmab048,  pmab_t.pmab049,
                    pmab_t.pmab050,  pmab_t.pmab051,  pmab_t.pmab052,  pmab_t.pmab053,  pmab_t.pmab054,
                    pmab_t.pmab055,  pmab_t.pmab056,  pmab_t.pmab057,  pmab_t.pmab058,  pmab_t.pmab060,
                    pmab_t.pmab061,  pmab_t.pmab062,  pmab_t.pmab063,  pmab_t.pmab064,  pmab_t.pmab065,
                    pmab_t.pmab066,  pmab_t.pmab067,  pmab_t.pmab068,  pmab_t.pmab069,  pmab_t.pmab070,
                    pmab_t.pmab071,  pmab_t.pmab072,  pmab_t.pmab073,  pmab_t.pmab080,  pmab_t.pmab081,
                    pmab_t.pmab082,  pmab_t.pmab083,  pmab_t.pmab084,  pmab_t.pmab085,  pmab_t.pmab086,
                    pmab_t.pmab087,  pmab_t.pmab088,  pmab_t.pmab089,  pmab_t.pmab090,  pmab_t.pmab091,
                    pmab_t.pmab092,  pmab_t.pmab093,  pmab_t.pmab094,  pmab_t.pmab095,  pmab_t.pmab096,
                    pmab_t.pmab097,  pmab_t.pmab098,  pmab_t.pmab099,  pmab_t.pmab100,  pmab_t.pmab101,
                    pmab_t.pmab102,  pmab_t.pmab103,  pmab_t.pmab104,  pmab_t.pmab105,  pmab_t.pmab106,
                    pmab_t.pmab107,  pmab_t.pmab108,  pmab_t.pmabownid,pmab_t.pmabowndp,pmab_t.pmabcrtid,
                    pmab_t.pmabcrtdp,pmab_t.pmabcrtdt,pmab_t.pmabmodid,pmab_t.pmabmoddt,pmab_t.pmabcnfid,
                    pmab_t.pmabcnfdt,pmab_t.pmabstus, pmab_t.pmab059,  pmab_t.pmab109,  pmab_t.pmab110,
                    pmab_t.pmab111,  pmab_t.pmab019,  pmab_t.pmab020,  pmab_t.pmab112 
               INTO l_pmab.*  
               FROM pmab_t,pmaa_t 
              #161124-00048#9 mod-E
              WHERE pmabent = pmaaent AND pmab001 = pmaa001 AND pmaastus = 'Y'
                AND pmabent = g_enterprise AND pmabsite = 'ALL' AND pmab001 = g_pmdf_m.pmdf004  
        END IF     
        
        #先判斷欄位是否在單據別設定的預設欄位中，如果存在，則不重新帶值，不存在，則根據供應商帶預設值
        IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf005') THEN
           LET g_pmdf_m.pmdf005 = l_pmab.pmab033
           CALL apmt420_pmdf005_ref(g_pmdf_m.pmdf005) RETURNING g_pmdf_m.pmdf005_desc
           DISPLAY BY NAME g_pmdf_m.pmdf005_desc
        END IF
        
        IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf006') THEN
           LET g_pmdf_m.pmdf006 = l_pmab.pmab034
           CALL apmt420_pmdf006_ref(g_pmdf_m.pmdf006) RETURNING g_pmdf_m.pmdf006_desc
           DISPLAY BY NAME g_pmdf_m.pmdf006_desc
           
           #根據稅別帶出稅率、含稅否等
           IF NOT cl_null(g_pmdf_m.pmdf006) THEN
              CALL s_tax_chk(g_site,g_pmdf_m.pmdf006)
                  RETURNING l_success,g_pmdf_m.pmdf004_desc,g_pmdf_m.pmdf008,g_pmdf_m.pmdf007,g_tax_app
              DISPLAY BY NAME g_pmdf_m.pmdf008,g_pmdf_m.pmdf007 
           END IF
        END IF
        
        IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf009') THEN
           LET g_pmdf_m.pmdf009 = l_pmab.pmab037
           CALL apmt420_pmdf009_ref(g_pmdf_m.pmdf009) RETURNING g_pmdf_m.pmdf009_desc
           DISPLAY BY NAME g_pmdf_m.pmdf009_desc
        END IF
        
        IF NOT s_aooi200_chk_doc_fields(g_site,'1',g_pmdf_m.pmdfdocno,'pmdf010') THEN
           LET g_pmdf_m.pmdf010 = l_pmab.pmab053
           CALL apmt420_pmdf010_ref(g_pmdf_m.pmdf010) RETURNING g_pmdf_m.pmdf010_desc
           DISPLAY BY NAME g_pmdf_m.pmdf010_desc
        END IF
        
END FUNCTION
################################################################################
# Descriptions...: 取得產品特徵類別
# Memo...........:
# Usage..........: CALL apmt420_get_imaa005(p_enterprise,p_imaa001)
#                  RETURNING r_imaa005
# Input parameter: p_enterprise   企業編號
#                : p_imaa001      料號
# Return code....: r_imaa005      特徵類別
# Date & Author..: 2014/06/12 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt420_get_imaa005(p_enterprise,p_imaa001)
   DEFINE p_enterprise   LIKE type_t.num5,
          p_imaa001      LIKE imaa_t.imaa001
   DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = p_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005   
END FUNCTION

################################################################################
# Descriptions...: 維護備註單身
# Memo...........: #161031-00025#10 add
################################################################################
PRIVATE FUNCTION apmt420_memos()
DEFINE l_sql      STRING

   IF g_pmdf_m.pmdfdocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   LET l_sql = " SELECT pmdf001,pmdfsite,pmdfdocno,pmdfdocdt,pmdf004,pmdf002,pmdf003, 
                        pmdfstus,pmdf005,pmdf006,pmdf007,pmdf008,pmdf009,pmdf010,pmdf030,pmdfownid,
                        pmdfowndp,pmdfcrtid,pmdfcrtdp,pmdfcrtdt,pmdfmodid,pmdfmoddt,pmdfcnfid,pmdfcnfdt",         
               " FROM pmdf_t",
               " WHERE pmdfent= ? AND pmdfdocno=? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE apmt420_ooff_cl CURSOR FROM l_sql
   
   CALL s_transaction_begin()
   
   OPEN apmt420_ooff_cl USING g_enterprise,g_pmdf_m.pmdfdocno

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN apmt420_ooff_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE apmt420_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #鎖住將被更改的資料
   FETCH apmt420_ooff_cl INTO g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt, 
                              g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003, 
                              g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf006, 
                              g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,
                              g_pmdf_m.pmdf010,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,
                              g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
                              g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt, 
                              g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt
                              
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_pmdf_m.pmdfdocno 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      CLOSE apmt420_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN 
   END IF
 
   #檢查是否允許此動作
   IF NOT apmt420_action_chk() THEN
      CLOSE apmt420_ooff_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_pmdf_m.pmdf001,g_pmdf_m.pmdfsite,g_pmdf_m.pmdfdocno,g_pmdf_m.pmdfdocdt, 
                   g_pmdf_m.pmdf004,g_pmdf_m.pmdf002,g_pmdf_m.pmdf003, 
                   g_pmdf_m.pmdfstus,g_pmdf_m.pmdf005,g_pmdf_m.pmdf006, 
                   g_pmdf_m.pmdf007,g_pmdf_m.pmdf008,g_pmdf_m.pmdf009,
                   g_pmdf_m.pmdf010,g_pmdf_m.pmdf030,g_pmdf_m.pmdfownid,
                   g_pmdf_m.pmdfowndp,g_pmdf_m.pmdfcrtid,g_pmdf_m.pmdfcrtdp, 
                   g_pmdf_m.pmdfcrtdt,g_pmdf_m.pmdfmodid,g_pmdf_m.pmdfmoddt, 
                   g_pmdf_m.pmdfcnfid,g_pmdf_m.pmdfcnfdt
                              
   LET g_detail_insert = cl_auth_detail_input("insert")
   LET g_detail_delete = cl_auth_detail_input("delete")
   
   LET g_ooff001_d = '6'   #6.單據單頭備註
   LET g_ooff002_d = g_prog   
   LET g_ooff003_d = g_pmdf_m.pmdfdocno   #单号  
   LET g_ooff004_d = 0    #项次
   LET g_ooff005_d = ' '
   LET g_ooff006_d = ' '
   LET g_ooff007_d = ' '
   LET g_ooff008_d = ' '
   LET g_ooff009_d = ' '
   LET g_ooff010_d = ' '
   LET g_ooff011_d = ' '
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      SUBDIALOG aoo_aooi360_01.aooi360_01_input   #备注单身
      
      ON ACTION accept  
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄) 
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   CLOSE apmt420_ooff_cl
   
   CALL s_transaction_end('Y','0')
   
   CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)   #备注单身 

END FUNCTION

 
{</section>}
 
