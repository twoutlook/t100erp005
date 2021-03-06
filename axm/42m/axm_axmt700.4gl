#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt700.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-08-01 17:33:54), PR版次:0008(2016-12-29 12:54:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: axmt700
#+ Description: 客訴單維護作業
#+ Creator....: 02040(2015-09-09 15:05:15)
#+ Modifier...: 05423 -SD/PR- 08993
 
{</section>}
 
{<section id="axmt700.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151118-00012#1   2015/11/19  By Shiun      更改抓取匯率時的基準日期
#151224-00025#5   2015/12/28  By dorishsu   產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160314-00009#15  2016/03/29  By xujing     产品特征自动开窗增加参数判断
#160318-00025#35  2016/04/15  By pengxin    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160714-00003#1   2016/08/01  By zhujing    自动产生RMA单:不需指定客诉单项次
#160812-00017#5   16/08/15    By 06137      在satatchange( )的FUNCTION中，有RETURN指令但沒有加上transaction_end( ) 造成transaction沒有結束就直接RETURN
#160818-00017#44  2016/08/26  By lixh       单据类作业修改，删除时需重新检查状态
#161109-00085#9   2016/11/10  By 08993      整批調整系統星號寫法
#161207-00033#18  2016/12/20  By 08993      一次性交易對象名稱顯示要改抓pmak003
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
PRIVATE type type_g_xmfo_m        RECORD
       xmfodocno LIKE xmfo_t.xmfodocno, 
   xmfodocno_desc LIKE type_t.chr80, 
   xmfodocdt LIKE xmfo_t.xmfodocdt, 
   xmfo001 LIKE xmfo_t.xmfo001, 
   xmfo002 LIKE xmfo_t.xmfo002, 
   xmfo003 LIKE xmfo_t.xmfo003, 
   xmfo003_desc LIKE type_t.chr80, 
   xmfo004 LIKE xmfo_t.xmfo004, 
   xmfo004_desc LIKE type_t.chr80, 
   xmfostus LIKE xmfo_t.xmfostus, 
   xmfo005 LIKE xmfo_t.xmfo005, 
   xmfo005_desc LIKE type_t.chr80, 
   xmfo012 LIKE xmfo_t.xmfo012, 
   xmfo006 LIKE xmfo_t.xmfo006, 
   xmfo007 LIKE xmfo_t.xmfo007, 
   xmfo012_desc LIKE type_t.chr80, 
   xmfo012_desc_1 LIKE type_t.chr80, 
   xmfo008 LIKE xmfo_t.xmfo008, 
   xmfo009 LIKE xmfo_t.xmfo009, 
   xmfo010 LIKE xmfo_t.xmfo010, 
   xmfo011 LIKE xmfo_t.xmfo011, 
   xmfo013 LIKE xmfo_t.xmfo013, 
   xmfo013_desc LIKE type_t.chr80, 
   xmfo018 LIKE xmfo_t.xmfo018, 
   xmfo014 LIKE xmfo_t.xmfo014, 
   xmfo015 LIKE xmfo_t.xmfo015, 
   xmfo015_desc LIKE type_t.chr80, 
   xmfo016 LIKE xmfo_t.xmfo016, 
   xmfo017 LIKE xmfo_t.xmfo017, 
   xmfosite LIKE xmfo_t.xmfosite, 
   xmfoownid LIKE xmfo_t.xmfoownid, 
   xmfoownid_desc LIKE type_t.chr80, 
   xmfoowndp LIKE xmfo_t.xmfoowndp, 
   xmfoowndp_desc LIKE type_t.chr80, 
   xmfocrtid LIKE xmfo_t.xmfocrtid, 
   xmfocrtid_desc LIKE type_t.chr80, 
   xmfocrtdp LIKE xmfo_t.xmfocrtdp, 
   xmfocrtdp_desc LIKE type_t.chr80, 
   xmfocrtdt LIKE xmfo_t.xmfocrtdt, 
   xmfomodid LIKE xmfo_t.xmfomodid, 
   xmfomodid_desc LIKE type_t.chr80, 
   xmfomoddt LIKE xmfo_t.xmfomoddt, 
   xmfocnfid LIKE xmfo_t.xmfocnfid, 
   xmfocnfid_desc LIKE type_t.chr80, 
   xmfocnfdt LIKE xmfo_t.xmfocnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xmfp_d        RECORD
       xmfpseq LIKE xmfp_t.xmfpseq, 
   xmfp001 LIKE xmfp_t.xmfp001, 
   xmfpsite LIKE xmfp_t.xmfpsite
       END RECORD
PRIVATE TYPE type_g_xmfp2_d RECORD
       xmfqseq LIKE xmfq_t.xmfqseq, 
   xmfq001 LIKE xmfq_t.xmfq001, 
   xmfq001_desc LIKE type_t.chr500, 
   xmfq002 LIKE xmfq_t.xmfq002, 
   xmfq002_desc LIKE type_t.chr500, 
   xmfq003 LIKE xmfq_t.xmfq003, 
   xmfq003_desc LIKE type_t.chr500, 
   xmfqsite LIKE xmfq_t.xmfqsite
       END RECORD
PRIVATE TYPE type_g_xmfp3_d RECORD
       xmfrseq LIKE xmfr_t.xmfrseq, 
   xmfr001 LIKE xmfr_t.xmfr001, 
   xmfr002 LIKE xmfr_t.xmfr002, 
   xmfr002_desc LIKE type_t.chr500, 
   xmfr003 LIKE xmfr_t.xmfr003, 
   xmfr003_desc LIKE type_t.chr500, 
   xmfrsite LIKE xmfr_t.xmfrsite
       END RECORD
PRIVATE TYPE type_g_xmfp4_d RECORD
       xmfsseq LIKE xmfs_t.xmfsseq, 
   xmfs001 LIKE xmfs_t.xmfs001, 
   xmfs002 LIKE xmfs_t.xmfs002, 
   xmfs002_desc LIKE type_t.chr500, 
   xmfs003 LIKE xmfs_t.xmfs003, 
   xmfs003_desc LIKE type_t.chr500, 
   xmfssite LIKE xmfs_t.xmfssite
       END RECORD
PRIVATE TYPE type_g_xmfp5_d RECORD
       xmftseq LIKE xmft_t.xmftseq, 
   xmft001 LIKE xmft_t.xmft001, 
   xmft002 LIKE xmft_t.xmft002, 
   xmft002_desc LIKE type_t.chr500, 
   xmftsite LIKE xmft_t.xmftsite
       END RECORD
PRIVATE TYPE type_g_xmfp6_d RECORD
       xmfuseq LIKE xmfu_t.xmfuseq, 
   xmfu001 LIKE xmfu_t.xmfu001, 
   xmfu002 LIKE xmfu_t.xmfu002, 
   xmfu002_desc LIKE type_t.chr500, 
   xmfusite LIKE xmfu_t.xmfusite
       END RECORD
PRIVATE TYPE type_g_xmfp7_d RECORD
       xmfvseq LIKE xmfv_t.xmfvseq, 
   xmfv001 LIKE xmfv_t.xmfv001, 
   xmfv002 LIKE xmfv_t.xmfv002, 
   xmfv002_desc LIKE type_t.chr500, 
   xmfvsite LIKE xmfv_t.xmfvsite
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_xmfodocno LIKE xmfo_t.xmfodocno,
      b_xmfo001 LIKE xmfo_t.xmfo001,
      b_xmfo002 LIKE xmfo_t.xmfo002,
      b_xmfo003 LIKE xmfo_t.xmfo003,
      b_xmfo004 LIKE xmfo_t.xmfo004,
      b_xmfo005 LIKE xmfo_t.xmfo005,
      b_xmfo006 LIKE xmfo_t.xmfo006,
      b_xmfo007 LIKE xmfo_t.xmfo007
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
       
#模組變數(Module Variables)
DEFINE g_xmfo_m          type_g_xmfo_m
DEFINE g_xmfo_m_t        type_g_xmfo_m
DEFINE g_xmfo_m_o        type_g_xmfo_m
DEFINE g_xmfo_m_mask_o   type_g_xmfo_m #轉換遮罩前資料
DEFINE g_xmfo_m_mask_n   type_g_xmfo_m #轉換遮罩後資料
 
   DEFINE g_xmfodocno_t LIKE xmfo_t.xmfodocno
 
 
DEFINE g_xmfp_d          DYNAMIC ARRAY OF type_g_xmfp_d
DEFINE g_xmfp_d_t        type_g_xmfp_d
DEFINE g_xmfp_d_o        type_g_xmfp_d
DEFINE g_xmfp_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp_d #轉換遮罩前資料
DEFINE g_xmfp_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp_d #轉換遮罩後資料
DEFINE g_xmfp2_d          DYNAMIC ARRAY OF type_g_xmfp2_d
DEFINE g_xmfp2_d_t        type_g_xmfp2_d
DEFINE g_xmfp2_d_o        type_g_xmfp2_d
DEFINE g_xmfp2_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp2_d #轉換遮罩前資料
DEFINE g_xmfp2_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp2_d #轉換遮罩後資料
DEFINE g_xmfp3_d          DYNAMIC ARRAY OF type_g_xmfp3_d
DEFINE g_xmfp3_d_t        type_g_xmfp3_d
DEFINE g_xmfp3_d_o        type_g_xmfp3_d
DEFINE g_xmfp3_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp3_d #轉換遮罩前資料
DEFINE g_xmfp3_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp3_d #轉換遮罩後資料
DEFINE g_xmfp4_d          DYNAMIC ARRAY OF type_g_xmfp4_d
DEFINE g_xmfp4_d_t        type_g_xmfp4_d
DEFINE g_xmfp4_d_o        type_g_xmfp4_d
DEFINE g_xmfp4_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp4_d #轉換遮罩前資料
DEFINE g_xmfp4_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp4_d #轉換遮罩後資料
DEFINE g_xmfp5_d          DYNAMIC ARRAY OF type_g_xmfp5_d
DEFINE g_xmfp5_d_t        type_g_xmfp5_d
DEFINE g_xmfp5_d_o        type_g_xmfp5_d
DEFINE g_xmfp5_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp5_d #轉換遮罩前資料
DEFINE g_xmfp5_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp5_d #轉換遮罩後資料
DEFINE g_xmfp6_d          DYNAMIC ARRAY OF type_g_xmfp6_d
DEFINE g_xmfp6_d_t        type_g_xmfp6_d
DEFINE g_xmfp6_d_o        type_g_xmfp6_d
DEFINE g_xmfp6_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp6_d #轉換遮罩前資料
DEFINE g_xmfp6_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp6_d #轉換遮罩後資料
DEFINE g_xmfp7_d          DYNAMIC ARRAY OF type_g_xmfp7_d
DEFINE g_xmfp7_d_t        type_g_xmfp7_d
DEFINE g_xmfp7_d_o        type_g_xmfp7_d
DEFINE g_xmfp7_d_mask_o   DYNAMIC ARRAY OF type_g_xmfp7_d #轉換遮罩前資料
DEFINE g_xmfp7_d_mask_n   DYNAMIC ARRAY OF type_g_xmfp7_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
DEFINE g_wc2_table3   STRING
 
DEFINE g_wc2_table4   STRING
 
DEFINE g_wc2_table5   STRING
 
DEFINE g_wc2_table6   STRING
 
DEFINE g_wc2_table7   STRING
 
 
 
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
 
{<section id="axmt700.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT xmfodocno,'',xmfodocdt,xmfo001,xmfo002,xmfo003,'',xmfo004,'',xmfostus, 
       xmfo005,'',xmfo012,xmfo006,xmfo007,'','',xmfo008,xmfo009,xmfo010,xmfo011,xmfo013,'',xmfo018,xmfo014, 
       xmfo015,'',xmfo016,xmfo017,xmfosite,xmfoownid,'',xmfoowndp,'',xmfocrtid,'',xmfocrtdp,'',xmfocrtdt, 
       xmfomodid,'',xmfomoddt,xmfocnfid,'',xmfocnfdt", 
                      " FROM xmfo_t",
                      " WHERE xmfoent= ? AND xmfodocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xmfodocno,t0.xmfodocdt,t0.xmfo001,t0.xmfo002,t0.xmfo003,t0.xmfo004, 
       t0.xmfostus,t0.xmfo005,t0.xmfo012,t0.xmfo006,t0.xmfo007,t0.xmfo008,t0.xmfo009,t0.xmfo010,t0.xmfo011, 
       t0.xmfo013,t0.xmfo018,t0.xmfo014,t0.xmfo015,t0.xmfo016,t0.xmfo017,t0.xmfosite,t0.xmfoownid,t0.xmfoowndp, 
       t0.xmfocrtid,t0.xmfocrtdp,t0.xmfocrtdt,t0.xmfomodid,t0.xmfomoddt,t0.xmfocnfid,t0.xmfocnfdt,t1.ooag011 , 
       t2.ooefl003 ,t3.pmaal004 ,t4.imaal003 ,t5.oocal003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM xmfo_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.xmfo003  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xmfo004 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t3 ON t3.pmaalent="||g_enterprise||" AND t3.pmaal001=t0.xmfo005 AND t3.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=t0.xmfo012 AND t4.imaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=t0.xmfo015 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.xmfoownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.xmfoowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.xmfocrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.xmfocrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.xmfomodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.xmfocnfid  ",
 
               " WHERE t0.xmfoent = " ||g_enterprise|| " AND t0.xmfodocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axmt700_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmt700 WITH FORM cl_ap_formpath("axm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axmt700_init()   
 
      #進入選單 Menu (="N")
      CALL axmt700_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axmt700
      
   END IF 
   
   CLOSE axmt700_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axmt700.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axmt700_init()
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
   LET g_detail_idx_list[7] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('xmfostus','13','C,N,Y')
 
      CALL cl_set_combo_scc('xmfo016','4061') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("'4',","1")
   CALL g_idx_group.addAttribute("'5',","1")
   CALL g_idx_group.addAttribute("'6',","1")
   CALL g_idx_group.addAttribute("'7',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
   
   #初始化搜尋條件
   CALL axmt700_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axmt700.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axmt700_ui_dialog()
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
            CALL axmt700_insert()
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
         INITIALIZE g_xmfo_m.* TO NULL
         CALL g_xmfp_d.clear()
         CALL g_xmfp2_d.clear()
         CALL g_xmfp3_d.clear()
         CALL g_xmfp4_d.clear()
         CALL g_xmfp5_d.clear()
         CALL g_xmfp6_d.clear()
         CALL g_xmfp7_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axmt700_init()
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
               
               CALL axmt700_fetch('') # reload data
               LET l_ac = 1
               CALL axmt700_ui_detailshow() #Setting the current row 
         
               CALL axmt700_idx_chk()
               #NEXT FIELD xmfpseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_xmfp_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
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
               CALL axmt700_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_xmfp2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
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
               CALL axmt700_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmfp3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
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
               CALL axmt700_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmfp4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
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
               CALL axmt700_idx_chk()
               #add-point:page4自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_4)
            
         
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmfp5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[5] = l_ac
               CALL g_idx_group.addAttribute("'5',",l_ac)
               
               #add-point:page5, before row動作 name="ui_dialog.body5.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_current_page = 5
               #顯示單身筆數
               CALL axmt700_idx_chk()
               #add-point:page5自定義行為 name="ui_dialog.body5.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_5)
            
         
            #add-point:page5自定義行為 name="ui_dialog.body5.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmfp6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[6] = l_ac
               CALL g_idx_group.addAttribute("'6',",l_ac)
               
               #add-point:page6, before row動作 name="ui_dialog.body6.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
               LET g_current_page = 6
               #顯示單身筆數
               CALL axmt700_idx_chk()
               #add-point:page6自定義行為 name="ui_dialog.body6.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_6)
            
         
            #add-point:page6自定義行為 name="ui_dialog.body6.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_xmfp7_d TO s_detail7.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL axmt700_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[7] = l_ac
               CALL g_idx_group.addAttribute("'7',",l_ac)
               
               #add-point:page7, before row動作 name="ui_dialog.body7.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail7")
               LET g_current_page = 7
               #顯示單身筆數
               CALL axmt700_idx_chk()
               #add-point:page7自定義行為 name="ui_dialog.body7.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_7)
            
         
            #add-point:page7自定義行為 name="ui_dialog.body7.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL axmt700_browser_fill("")
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
               CALL axmt700_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axmt700_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL axmt700_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL axmt700_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL axmt700_set_act_visible()   
            CALL axmt700_set_act_no_visible()
            IF NOT (g_xmfo_m.xmfodocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " xmfoent = " ||g_enterprise|| " AND",
                                  " xmfodocno = '", g_xmfo_m.xmfodocno, "' "
 
               #填到對應位置
               CALL axmt700_browser_fill("")
            END IF
         
          
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xmfo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfq_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfr_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfs_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmft_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfu_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfv_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL axmt700_browser_fill("F")   #browser_fill()會將notice區塊清空
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
 
               INITIALIZE g_wc2_table5 TO NULL
 
               INITIALIZE g_wc2_table6 TO NULL
 
               INITIALIZE g_wc2_table7 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "xmfo_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfp_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "xmfq_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfr_t" 
                        LET g_wc2_table3 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfs_t" 
                        LET g_wc2_table4 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmft_t" 
                        LET g_wc2_table5 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfu_t" 
                        LET g_wc2_table6 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "xmfv_t" 
                        LET g_wc2_table7 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
                  OR NOT cl_null(g_wc2_table3)
 
                  OR NOT cl_null(g_wc2_table4)
 
                  OR NOT cl_null(g_wc2_table5)
 
                  OR NOT cl_null(g_wc2_table6)
 
                  OR NOT cl_null(g_wc2_table7)
 
 
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
 
                  IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
                  END IF
 
                  IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
                  END IF
 
                  IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL axmt700_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL axmt700_fetch("F")
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
               CALL axmt700_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axmt700_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt700_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axmt700_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt700_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axmt700_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt700_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axmt700_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt700_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axmt700_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axmt700_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_xmfp_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xmfp2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_xmfp3_d)
                  LET g_export_id[3]   = "s_detail3"
                  LET g_export_node[4] = base.typeInfo.create(g_xmfp4_d)
                  LET g_export_id[4]   = "s_detail4"
                  LET g_export_node[5] = base.typeInfo.create(g_xmfp5_d)
                  LET g_export_id[5]   = "s_detail5"
                  LET g_export_node[6] = base.typeInfo.create(g_xmfp6_d)
                  LET g_export_id[6]   = "s_detail6"
                  LET g_export_node[7] = base.typeInfo.create(g_xmfp7_d)
                  LET g_export_id[7]   = "s_detail7"
 
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
               NEXT FIELD xmfpseq
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
               CALL axmt700_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axmt700_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmfv
            LET g_action_choice="open_xmfv"
            IF cl_auth_chk_act("open_xmfv") THEN
               
               #add-point:ON ACTION open_xmfv name="menu.open_xmfv"
               CALL axmt700_action_modify('V') 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axmt700_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axmt700_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmft
            LET g_action_choice="open_xmft"
            IF cl_auth_chk_act("open_xmft") THEN
               
               #add-point:ON ACTION open_xmft name="menu.open_xmft"
               CALL axmt700_action_modify('T')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmfq
            LET g_action_choice="open_xmfq"
            IF cl_auth_chk_act("open_xmfq") THEN
               
               #add-point:ON ACTION open_xmfq name="menu.open_xmfq"
               CALL axmt700_action_modify('Q')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmfs
            LET g_action_choice="open_xmfs"
            IF cl_auth_chk_act("open_xmfs") THEN
               
               #add-point:ON ACTION open_xmfs name="menu.open_xmfs"
               CALL axmt700_action_modify('S') 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmfu
            LET g_action_choice="open_xmfu"
            IF cl_auth_chk_act("open_xmfu") THEN
               
               #add-point:ON ACTION open_xmfu name="menu.open_xmfu"
               CALL axmt700_action_modify('U')
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axm/axmt700_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axm/axmt700_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce_xmdk
            LET g_action_choice="produce_xmdk"
            IF cl_auth_chk_act("produce_xmdk") THEN
               
               #add-point:ON ACTION produce_xmdk name="menu.produce_xmdk"
               IF g_xmfo_m.xmfo016 = '2' THEN
                  IF cl_ask_confirm('axm-00719') THEN           #是否自動產生銷退單
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF axmt700_produce_xmdk(g_xmfo_m.xmfodocno) THEN
                        CALL s_transaction_end('Y','0')
                        CALL axmt700_fetch("")
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     CALL cl_err_collect_show()
                  END IF            
               END IF 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axmt700_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axmt700_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
               CALL g_curr_diag.setCurrentRow("s_detail5",1)
               CALL g_curr_diag.setCurrentRow("s_detail6",1)
               CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION produce_rma
            LET g_action_choice="produce_rma"
            IF cl_auth_chk_act("produce_rma") THEN
               
               #add-point:ON ACTION produce_rma name="menu.produce_rma"
               IF g_xmfo_m.xmfo016 = '1' THEN
                  IF cl_ask_confirm('arm-00036') THEN           #是否自動產生RMA單
                     CALL cl_err_collect_init()
                     CALL s_transaction_begin()
                     IF axmt700_produce_rma(g_xmfo_m.xmfodocno) THEN
                        CALL s_transaction_end('Y','0')
                        CALL axmt700_fetch("")
                     ELSE
                        CALL s_transaction_end('N','0')
                     END IF
                     CALL cl_err_collect_show()
                  END IF              
               END IF   
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xmfr
            LET g_action_choice="open_xmfr"
            IF cl_auth_chk_act("open_xmfr") THEN
               
               #add-point:ON ACTION open_xmfr name="menu.open_xmfr"
               CALL axmt700_action_modify('R')
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axmt700_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axmt700_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axmt700_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_xmfo_m.xmfodocdt)
 
 
 
         
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
 
{<section id="axmt700.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axmt700_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " xmfosite = '",g_site,"' " 
   ELSE
      LET g_wc = g_wc," AND xmfosite = '",g_site,"' "
   END IF
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
      LET l_sub_sql = " SELECT DISTINCT xmfodocno ",
                      " FROM xmfo_t ",
                      " ",
                      " LEFT JOIN xmfp_t ON xmfpent = xmfoent AND xmfodocno = xmfpdocno ", "  ",
                      #add-point:browser_fill段sql(xmfp_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN xmfq_t ON xmfqent = xmfoent AND xmfodocno = xmfqdocno", "  ",
                      #add-point:browser_fill段sql(xmfq_t1) name="browser_fill.cnt.join.xmfq_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmfr_t ON xmfrent = xmfoent AND xmfodocno = xmfrdocno", "  ",
                      #add-point:browser_fill段sql(xmfr_t1) name="browser_fill.cnt.join.xmfr_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmfs_t ON xmfsent = xmfoent AND xmfodocno = xmfsdocno", "  ",
                      #add-point:browser_fill段sql(xmfs_t1) name="browser_fill.cnt.join.xmfs_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmft_t ON xmftent = xmfoent AND xmfodocno = xmftdocno", "  ",
                      #add-point:browser_fill段sql(xmft_t1) name="browser_fill.cnt.join.xmft_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmfu_t ON xmfuent = xmfoent AND xmfodocno = xmfudocno", "  ",
                      #add-point:browser_fill段sql(xmfu_t1) name="browser_fill.cnt.join.xmfu_t1"
                      
                      #end add-point
 
                      " LEFT JOIN xmfv_t ON xmfvent = xmfoent AND xmfodocno = xmfvdocno", "  ",
                      #add-point:browser_fill段sql(xmfv_t1) name="browser_fill.cnt.join.xmfv_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE xmfoent = " ||g_enterprise|| " AND xmfpent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xmfo_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xmfodocno ",
                      " FROM xmfo_t ", 
                      "  ",
                      "  ",
                      " WHERE xmfoent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xmfo_t")
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
      INITIALIZE g_xmfo_m.* TO NULL
      CALL g_xmfp_d.clear()        
      CALL g_xmfp2_d.clear() 
      CALL g_xmfp3_d.clear() 
      CALL g_xmfp4_d.clear() 
      CALL g_xmfp5_d.clear() 
      CALL g_xmfp6_d.clear() 
      CALL g_xmfp7_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xmfodocno,t0.xmfo001,t0.xmfo002,t0.xmfo003,t0.xmfo004,t0.xmfo005,t0.xmfo006,t0.xmfo007 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmfostus,t0.xmfodocno,t0.xmfo001,t0.xmfo002,t0.xmfo003,t0.xmfo004, 
          t0.xmfo005,t0.xmfo006,t0.xmfo007 ",
                  " FROM xmfo_t t0",
                  "  ",
                  "  LEFT JOIN xmfp_t ON xmfpent = xmfoent AND xmfodocno = xmfpdocno ", "  ", 
                  #add-point:browser_fill段sql(xmfp_t1) name="browser_fill.join.xmfp_t1"
                  
                  #end add-point
                  "  LEFT JOIN xmfq_t ON xmfqent = xmfoent AND xmfodocno = xmfqdocno", "  ", 
                  #add-point:browser_fill段sql(xmfq_t1) name="browser_fill.join.xmfq_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmfr_t ON xmfrent = xmfoent AND xmfodocno = xmfrdocno", "  ", 
                  #add-point:browser_fill段sql(xmfr_t1) name="browser_fill.join.xmfr_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmfs_t ON xmfsent = xmfoent AND xmfodocno = xmfsdocno", "  ", 
                  #add-point:browser_fill段sql(xmfs_t1) name="browser_fill.join.xmfs_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmft_t ON xmftent = xmfoent AND xmfodocno = xmftdocno", "  ", 
                  #add-point:browser_fill段sql(xmft_t1) name="browser_fill.join.xmft_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmfu_t ON xmfuent = xmfoent AND xmfodocno = xmfudocno", "  ", 
                  #add-point:browser_fill段sql(xmfu_t1) name="browser_fill.join.xmfu_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN xmfv_t ON xmfvent = xmfoent AND xmfodocno = xmfvdocno", "  ", 
                  #add-point:browser_fill段sql(xmfv_t1) name="browser_fill.join.xmfv_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
                  " ",                      
 
 
 
                  
                  " WHERE t0.xmfoent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("xmfo_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.xmfostus,t0.xmfodocno,t0.xmfo001,t0.xmfo002,t0.xmfo003,t0.xmfo004, 
          t0.xmfo005,t0.xmfo006,t0.xmfo007 ",
                  " FROM xmfo_t t0",
                  "  ",
                  
                  " WHERE t0.xmfoent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("xmfo_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY xmfodocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"xmfo_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_xmfodocno,g_browser[g_cnt].b_xmfo001, 
          g_browser[g_cnt].b_xmfo002,g_browser[g_cnt].b_xmfo003,g_browser[g_cnt].b_xmfo004,g_browser[g_cnt].b_xmfo005, 
          g_browser[g_cnt].b_xmfo006,g_browser[g_cnt].b_xmfo007
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
         CALL axmt700_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "C"
            LET g_browser[g_cnt].b_statepic = "stus/16/closed.png"
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_xmfodocno) THEN
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
 
{<section id="axmt700.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axmt700_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xmfo_m.xmfodocno = g_browser[g_current_idx].b_xmfodocno   
 
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
   CALL axmt700_xmfo_t_mask()
   CALL axmt700_show()
      
END FUNCTION
 
{</section>}
 
{<section id="axmt700.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axmt700_ui_detailshow()
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
      CALL g_curr_diag.setCurrentRow("s_detail7",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axmt700_ui_browser_refresh()
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
      IF g_browser[l_i].b_xmfodocno = g_xmfo_m.xmfodocno 
 
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
 
{<section id="axmt700.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axmt700_construct()
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
   INITIALIZE g_xmfo_m.* TO NULL
   CALL g_xmfp_d.clear()        
   CALL g_xmfp2_d.clear() 
   CALL g_xmfp3_d.clear() 
   CALL g_xmfp4_d.clear() 
   CALL g_xmfp5_d.clear() 
   CALL g_xmfp6_d.clear() 
   CALL g_xmfp7_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
   INITIALIZE g_wc2_table4 TO NULL
 
   INITIALIZE g_wc2_table5 TO NULL
 
   INITIALIZE g_wc2_table6 TO NULL
 
   INITIALIZE g_wc2_table7 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xmfodocno,xmfodocdt,xmfo001,xmfo002,xmfo003,xmfo004,xmfostus,xmfo005, 
          xmfo012,xmfo006,xmfo007,xmfo008,xmfo009,xmfo010,xmfo011,xmfo013,xmfo013_desc,xmfo018,xmfo014, 
          xmfo015,xmfo016,xmfo017,xmfosite,xmfoownid,xmfoowndp,xmfocrtid,xmfocrtdp,xmfocrtdt,xmfomodid, 
          xmfomoddt,xmfocnfid,xmfocnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<xmfocrtdt>>----
         AFTER FIELD xmfocrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<xmfomoddt>>----
         AFTER FIELD xmfomoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmfocnfdt>>----
         AFTER FIELD xmfocnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<xmfopstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.xmfodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfodocno
            #add-point:ON ACTION controlp INFIELD xmfodocno name="construct.c.xmfodocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmfodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfodocno  #顯示到畫面上
            NEXT FIELD xmfodocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfodocno
            #add-point:BEFORE FIELD xmfodocno name="construct.b.xmfodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfodocno
            
            #add-point:AFTER FIELD xmfodocno name="construct.a.xmfodocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfodocdt
            #add-point:BEFORE FIELD xmfodocdt name="construct.b.xmfodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfodocdt
            
            #add-point:AFTER FIELD xmfodocdt name="construct.a.xmfodocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfodocdt
            #add-point:ON ACTION controlp INFIELD xmfodocdt name="construct.c.xmfodocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo001
            #add-point:BEFORE FIELD xmfo001 name="construct.b.xmfo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo001
            
            #add-point:AFTER FIELD xmfo001 name="construct.a.xmfo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo001
            #add-point:ON ACTION controlp INFIELD xmfo001 name="construct.c.xmfo001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo002
            #add-point:BEFORE FIELD xmfo002 name="construct.b.xmfo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo002
            
            #add-point:AFTER FIELD xmfo002 name="construct.a.xmfo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo002
            #add-point:ON ACTION controlp INFIELD xmfo002 name="construct.c.xmfo002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo003
            #add-point:ON ACTION controlp INFIELD xmfo003 name="construct.c.xmfo003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo003  #顯示到畫面上
            NEXT FIELD xmfo003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo003
            #add-point:BEFORE FIELD xmfo003 name="construct.b.xmfo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo003
            
            #add-point:AFTER FIELD xmfo003 name="construct.a.xmfo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo004
            #add-point:ON ACTION controlp INFIELD xmfo004 name="construct.c.xmfo004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo004  #顯示到畫面上
            NEXT FIELD xmfo004                              #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo004
            #add-point:BEFORE FIELD xmfo004 name="construct.b.xmfo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo004
            
            #add-point:AFTER FIELD xmfo004 name="construct.a.xmfo004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfostus
            #add-point:BEFORE FIELD xmfostus name="construct.b.xmfostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfostus
            
            #add-point:AFTER FIELD xmfostus name="construct.a.xmfostus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfostus
            #add-point:ON ACTION controlp INFIELD xmfostus name="construct.c.xmfostus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo005
            #add-point:ON ACTION controlp INFIELD xmfo005 name="construct.c.xmfo005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo005  #顯示到畫面上
            NEXT FIELD xmfo005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo005
            #add-point:BEFORE FIELD xmfo005 name="construct.b.xmfo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo005
            
            #add-point:AFTER FIELD xmfo005 name="construct.a.xmfo005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo012
            #add-point:BEFORE FIELD xmfo012 name="construct.b.xmfo012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo012
            
            #add-point:AFTER FIELD xmfo012 name="construct.a.xmfo012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo012
            #add-point:ON ACTION controlp INFIELD xmfo012 name="construct.c.xmfo012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_6()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo012  #顯示到畫面上
            NEXT FIELD xmfo012                     #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.xmfo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo006
            #add-point:ON ACTION controlp INFIELD xmfo006 name="construct.c.xmfo006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdldocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo006  #顯示到畫面上
            NEXT FIELD xmfo006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo006
            #add-point:BEFORE FIELD xmfo006 name="construct.b.xmfo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo006
            
            #add-point:AFTER FIELD xmfo006 name="construct.a.xmfo006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo007
            #add-point:BEFORE FIELD xmfo007 name="construct.b.xmfo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo007
            
            #add-point:AFTER FIELD xmfo007 name="construct.a.xmfo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo007
            #add-point:ON ACTION controlp INFIELD xmfo007 name="construct.c.xmfo007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo008
            #add-point:BEFORE FIELD xmfo008 name="construct.b.xmfo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo008
            
            #add-point:AFTER FIELD xmfo008 name="construct.a.xmfo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo008
            #add-point:ON ACTION controlp INFIELD xmfo008 name="construct.c.xmfo008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "xmda005 <> '8' "
            CALL q_xmdadocno_2()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo008        #顯示到畫面上
            NEXT FIELD xmfo008                           #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo009
            #add-point:BEFORE FIELD xmfo009 name="construct.b.xmfo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo009
            
            #add-point:AFTER FIELD xmfo009 name="construct.a.xmfo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo009
            #add-point:ON ACTION controlp INFIELD xmfo009 name="construct.c.xmfo009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo010
            #add-point:BEFORE FIELD xmfo010 name="construct.b.xmfo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo010
            
            #add-point:AFTER FIELD xmfo010 name="construct.a.xmfo010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo010
            #add-point:ON ACTION controlp INFIELD xmfo010 name="construct.c.xmfo010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo011
            #add-point:BEFORE FIELD xmfo011 name="construct.b.xmfo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo011
            
            #add-point:AFTER FIELD xmfo011 name="construct.a.xmfo011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo011
            #add-point:ON ACTION controlp INFIELD xmfo011 name="construct.c.xmfo011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo013
            #add-point:BEFORE FIELD xmfo013 name="construct.b.xmfo013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo013
            
            #add-point:AFTER FIELD xmfo013 name="construct.a.xmfo013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo013
            #add-point:ON ACTION controlp INFIELD xmfo013 name="construct.c.xmfo013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            LET g_qryparam.where = "xmdk002 <> '8' "
            CALL q_xmdl009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo013      #顯示到畫面上
            NEXT FIELD xmfo013                         #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo013_desc
            #add-point:BEFORE FIELD xmfo013_desc name="construct.b.xmfo013_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo013_desc
            
            #add-point:AFTER FIELD xmfo013_desc name="construct.a.xmfo013_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo013_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo013_desc
            #add-point:ON ACTION controlp INFIELD xmfo013_desc name="construct.c.xmfo013_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo018
            #add-point:BEFORE FIELD xmfo018 name="construct.b.xmfo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo018
            
            #add-point:AFTER FIELD xmfo018 name="construct.a.xmfo018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo018
            #add-point:ON ACTION controlp INFIELD xmfo018 name="construct.c.xmfo018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo014
            #add-point:BEFORE FIELD xmfo014 name="construct.b.xmfo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo014
            
            #add-point:AFTER FIELD xmfo014 name="construct.a.xmfo014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo014
            #add-point:ON ACTION controlp INFIELD xmfo014 name="construct.c.xmfo014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo015
            #add-point:BEFORE FIELD xmfo015 name="construct.b.xmfo015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo015
            
            #add-point:AFTER FIELD xmfo015 name="construct.a.xmfo015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo015
            #add-point:ON ACTION controlp INFIELD xmfo015 name="construct.c.xmfo015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo015  #顯示到畫面上
            NEXT FIELD xmfo015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo016
            #add-point:BEFORE FIELD xmfo016 name="construct.b.xmfo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo016
            
            #add-point:AFTER FIELD xmfo016 name="construct.a.xmfo016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo016
            #add-point:ON ACTION controlp INFIELD xmfo016 name="construct.c.xmfo016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo017
            #add-point:BEFORE FIELD xmfo017 name="construct.b.xmfo017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo017
            
            #add-point:AFTER FIELD xmfo017 name="construct.a.xmfo017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfo017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo017
            #add-point:ON ACTION controlp INFIELD xmfo017 name="construct.c.xmfo017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmfo017()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfo017  #顯示到畫面上
            NEXT FIELD xmfo017                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfosite
            #add-point:BEFORE FIELD xmfosite name="construct.b.xmfosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfosite
            
            #add-point:AFTER FIELD xmfosite name="construct.a.xmfosite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfosite
            #add-point:ON ACTION controlp INFIELD xmfosite name="construct.c.xmfosite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfoownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfoownid
            #add-point:ON ACTION controlp INFIELD xmfoownid name="construct.c.xmfoownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfoownid  #顯示到畫面上
            NEXT FIELD xmfoownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfoownid
            #add-point:BEFORE FIELD xmfoownid name="construct.b.xmfoownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfoownid
            
            #add-point:AFTER FIELD xmfoownid name="construct.a.xmfoownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfoowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfoowndp
            #add-point:ON ACTION controlp INFIELD xmfoowndp name="construct.c.xmfoowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfoowndp  #顯示到畫面上
            NEXT FIELD xmfoowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfoowndp
            #add-point:BEFORE FIELD xmfoowndp name="construct.b.xmfoowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfoowndp
            
            #add-point:AFTER FIELD xmfoowndp name="construct.a.xmfoowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfocrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfocrtid
            #add-point:ON ACTION controlp INFIELD xmfocrtid name="construct.c.xmfocrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfocrtid  #顯示到畫面上
            NEXT FIELD xmfocrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfocrtid
            #add-point:BEFORE FIELD xmfocrtid name="construct.b.xmfocrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfocrtid
            
            #add-point:AFTER FIELD xmfocrtid name="construct.a.xmfocrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmfocrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfocrtdp
            #add-point:ON ACTION controlp INFIELD xmfocrtdp name="construct.c.xmfocrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfocrtdp  #顯示到畫面上
            NEXT FIELD xmfocrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfocrtdp
            #add-point:BEFORE FIELD xmfocrtdp name="construct.b.xmfocrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfocrtdp
            
            #add-point:AFTER FIELD xmfocrtdp name="construct.a.xmfocrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfocrtdt
            #add-point:BEFORE FIELD xmfocrtdt name="construct.b.xmfocrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfomodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfomodid
            #add-point:ON ACTION controlp INFIELD xmfomodid name="construct.c.xmfomodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfomodid  #顯示到畫面上
            NEXT FIELD xmfomodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfomodid
            #add-point:BEFORE FIELD xmfomodid name="construct.b.xmfomodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfomodid
            
            #add-point:AFTER FIELD xmfomodid name="construct.a.xmfomodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfomoddt
            #add-point:BEFORE FIELD xmfomoddt name="construct.b.xmfomoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmfocnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfocnfid
            #add-point:ON ACTION controlp INFIELD xmfocnfid name="construct.c.xmfocnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfocnfid  #顯示到畫面上
            NEXT FIELD xmfocnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfocnfid
            #add-point:BEFORE FIELD xmfocnfid name="construct.b.xmfocnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfocnfid
            
            #add-point:AFTER FIELD xmfocnfid name="construct.a.xmfocnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfocnfdt
            #add-point:BEFORE FIELD xmfocnfdt name="construct.b.xmfocnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON xmfpseq,xmfp001,xmfpsite
           FROM s_detail1[1].xmfpseq,s_detail1[1].xmfp001,s_detail1[1].xmfpsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfpseq
            #add-point:BEFORE FIELD xmfpseq name="construct.b.page1.xmfpseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfpseq
            
            #add-point:AFTER FIELD xmfpseq name="construct.a.page1.xmfpseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfpseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfpseq
            #add-point:ON ACTION controlp INFIELD xmfpseq name="construct.c.page1.xmfpseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfp001
            #add-point:BEFORE FIELD xmfp001 name="construct.b.page1.xmfp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfp001
            
            #add-point:AFTER FIELD xmfp001 name="construct.a.page1.xmfp001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfp001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfp001
            #add-point:ON ACTION controlp INFIELD xmfp001 name="construct.c.page1.xmfp001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfpsite
            #add-point:BEFORE FIELD xmfpsite name="construct.b.page1.xmfpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfpsite
            
            #add-point:AFTER FIELD xmfpsite name="construct.a.page1.xmfpsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xmfpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfpsite
            #add-point:ON ACTION controlp INFIELD xmfpsite name="construct.c.page1.xmfpsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite
           FROM s_detail2[1].xmfqseq,s_detail2[1].xmfq001,s_detail2[1].xmfq002,s_detail2[1].xmfq003, 
               s_detail2[1].xmfqsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfqseq
            #add-point:BEFORE FIELD xmfqseq name="construct.b.page2.xmfqseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfqseq
            
            #add-point:AFTER FIELD xmfqseq name="construct.a.page2.xmfqseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfqseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfqseq
            #add-point:ON ACTION controlp INFIELD xmfqseq name="construct.c.page2.xmfqseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq001
            #add-point:BEFORE FIELD xmfq001 name="construct.b.page2.xmfq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq001
            
            #add-point:AFTER FIELD xmfq001 name="construct.a.page2.xmfq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq001
            #add-point:ON ACTION controlp INFIELD xmfq001 name="construct.c.page2.xmfq001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "296"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfq001  #顯示到畫面上
            NEXT FIELD xmfq001                 #返回原欄位
            #END add-point
 
 
         #Ctrlp:construct.c.page2.xmfq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq002
            #add-point:ON ACTION controlp INFIELD xmfq002 name="construct.c.page2.xmfq002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfq002  #顯示到畫面上
            NEXT FIELD xmfq002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq002
            #add-point:BEFORE FIELD xmfq002 name="construct.b.page2.xmfq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq002
            
            #add-point:AFTER FIELD xmfq002 name="construct.a.page2.xmfq002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq003
            #add-point:ON ACTION controlp INFIELD xmfq003 name="construct.c.page2.xmfq003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfq003  #顯示到畫面上
            NEXT FIELD xmfq003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq003
            #add-point:BEFORE FIELD xmfq003 name="construct.b.page2.xmfq003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq003
            
            #add-point:AFTER FIELD xmfq003 name="construct.a.page2.xmfq003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfqsite
            #add-point:BEFORE FIELD xmfqsite name="construct.b.page2.xmfqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfqsite
            
            #add-point:AFTER FIELD xmfqsite name="construct.a.page2.xmfqsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xmfqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfqsite
            #add-point:ON ACTION controlp INFIELD xmfqsite name="construct.c.page2.xmfqsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite
           FROM s_detail3[1].xmfrseq,s_detail3[1].xmfr001,s_detail3[1].xmfr002,s_detail3[1].xmfr003, 
               s_detail3[1].xmfrsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfrseq
            #add-point:BEFORE FIELD xmfrseq name="construct.b.page3.xmfrseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfrseq
            
            #add-point:AFTER FIELD xmfrseq name="construct.a.page3.xmfrseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmfrseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfrseq
            #add-point:ON ACTION controlp INFIELD xmfrseq name="construct.c.page3.xmfrseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr001
            #add-point:BEFORE FIELD xmfr001 name="construct.b.page3.xmfr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr001
            
            #add-point:AFTER FIELD xmfr001 name="construct.a.page3.xmfr001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmfr001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr001
            #add-point:ON ACTION controlp INFIELD xmfr001 name="construct.c.page3.xmfr001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.xmfr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr002
            #add-point:ON ACTION controlp INFIELD xmfr002 name="construct.c.page3.xmfr002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfr002  #顯示到畫面上
            NEXT FIELD xmfr002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr002
            #add-point:BEFORE FIELD xmfr002 name="construct.b.page3.xmfr002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr002
            
            #add-point:AFTER FIELD xmfr002 name="construct.a.page3.xmfr002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmfr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr003
            #add-point:ON ACTION controlp INFIELD xmfr003 name="construct.c.page3.xmfr003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfr003  #顯示到畫面上
            NEXT FIELD xmfr003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr003
            #add-point:BEFORE FIELD xmfr003 name="construct.b.page3.xmfr003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr003
            
            #add-point:AFTER FIELD xmfr003 name="construct.a.page3.xmfr003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfrsite
            #add-point:BEFORE FIELD xmfrsite name="construct.b.page3.xmfrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfrsite
            
            #add-point:AFTER FIELD xmfrsite name="construct.a.page3.xmfrsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.xmfrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfrsite
            #add-point:ON ACTION controlp INFIELD xmfrsite name="construct.c.page3.xmfrsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table4 ON xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite
           FROM s_detail4[1].xmfsseq,s_detail4[1].xmfs001,s_detail4[1].xmfs002,s_detail4[1].xmfs003, 
               s_detail4[1].xmfssite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body4.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 4)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfsseq
            #add-point:BEFORE FIELD xmfsseq name="construct.b.page4.xmfsseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfsseq
            
            #add-point:AFTER FIELD xmfsseq name="construct.a.page4.xmfsseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmfsseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfsseq
            #add-point:ON ACTION controlp INFIELD xmfsseq name="construct.c.page4.xmfsseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs001
            #add-point:BEFORE FIELD xmfs001 name="construct.b.page4.xmfs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs001
            
            #add-point:AFTER FIELD xmfs001 name="construct.a.page4.xmfs001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmfs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs001
            #add-point:ON ACTION controlp INFIELD xmfs001 name="construct.c.page4.xmfs001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page4.xmfs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs002
            #add-point:ON ACTION controlp INFIELD xmfs002 name="construct.c.page4.xmfs002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfs002  #顯示到畫面上
            NEXT FIELD xmfs002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs002
            #add-point:BEFORE FIELD xmfs002 name="construct.b.page4.xmfs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs002
            
            #add-point:AFTER FIELD xmfs002 name="construct.a.page4.xmfs002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmfs003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs003
            #add-point:ON ACTION controlp INFIELD xmfs003 name="construct.c.page4.xmfs003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfs003  #顯示到畫面上
            NEXT FIELD xmfs003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs003
            #add-point:BEFORE FIELD xmfs003 name="construct.b.page4.xmfs003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs003
            
            #add-point:AFTER FIELD xmfs003 name="construct.a.page4.xmfs003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfssite
            #add-point:BEFORE FIELD xmfssite name="construct.b.page4.xmfssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfssite
            
            #add-point:AFTER FIELD xmfssite name="construct.a.page4.xmfssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.xmfssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfssite
            #add-point:ON ACTION controlp INFIELD xmfssite name="construct.c.page4.xmfssite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table5 ON xmftseq,xmft001,xmft002,xmftsite
           FROM s_detail5[1].xmftseq,s_detail5[1].xmft001,s_detail5[1].xmft002,s_detail5[1].xmftsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body5.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 5)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmftseq
            #add-point:BEFORE FIELD xmftseq name="construct.b.page5.xmftseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmftseq
            
            #add-point:AFTER FIELD xmftseq name="construct.a.page5.xmftseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.xmftseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmftseq
            #add-point:ON ACTION controlp INFIELD xmftseq name="construct.c.page5.xmftseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmft001
            #add-point:BEFORE FIELD xmft001 name="construct.b.page5.xmft001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmft001
            
            #add-point:AFTER FIELD xmft001 name="construct.a.page5.xmft001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.xmft001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmft001
            #add-point:ON ACTION controlp INFIELD xmft001 name="construct.c.page5.xmft001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmft002
            #add-point:BEFORE FIELD xmft002 name="construct.b.page5.xmft002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmft002
            
            #add-point:AFTER FIELD xmft002 name="construct.a.page5.xmft002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.xmft002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmft002
            #add-point:ON ACTION controlp INFIELD xmft002 name="construct.c.page5.xmft002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmft002  #顯示到畫面上
            NEXT FIELD xmft002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmftsite
            #add-point:BEFORE FIELD xmftsite name="construct.b.page5.xmftsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmftsite
            
            #add-point:AFTER FIELD xmftsite name="construct.a.page5.xmftsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page5.xmftsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmftsite
            #add-point:ON ACTION controlp INFIELD xmftsite name="construct.c.page5.xmftsite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table6 ON xmfuseq,xmfu001,xmfu002,xmfusite
           FROM s_detail6[1].xmfuseq,s_detail6[1].xmfu001,s_detail6[1].xmfu002,s_detail6[1].xmfusite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body6.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 6)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfuseq
            #add-point:BEFORE FIELD xmfuseq name="construct.b.page6.xmfuseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfuseq
            
            #add-point:AFTER FIELD xmfuseq name="construct.a.page6.xmfuseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.xmfuseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfuseq
            #add-point:ON ACTION controlp INFIELD xmfuseq name="construct.c.page6.xmfuseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfu001
            #add-point:BEFORE FIELD xmfu001 name="construct.b.page6.xmfu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfu001
            
            #add-point:AFTER FIELD xmfu001 name="construct.a.page6.xmfu001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.xmfu001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfu001
            #add-point:ON ACTION controlp INFIELD xmfu001 name="construct.c.page6.xmfu001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfu002
            #add-point:BEFORE FIELD xmfu002 name="construct.b.page6.xmfu002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfu002
            
            #add-point:AFTER FIELD xmfu002 name="construct.a.page6.xmfu002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.xmfu002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfu002
            #add-point:ON ACTION controlp INFIELD xmfu002 name="construct.c.page6.xmfu002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfu002  #顯示到畫面上
            NEXT FIELD xmfu002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfusite
            #add-point:BEFORE FIELD xmfusite name="construct.b.page6.xmfusite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfusite
            
            #add-point:AFTER FIELD xmfusite name="construct.a.page6.xmfusite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page6.xmfusite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfusite
            #add-point:ON ACTION controlp INFIELD xmfusite name="construct.c.page6.xmfusite"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table7 ON xmfvseq,xmfv001,xmfv002,xmfvsite
           FROM s_detail7[1].xmfvseq,s_detail7[1].xmfv001,s_detail7[1].xmfv002,s_detail7[1].xmfvsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body7.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 7)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfvseq
            #add-point:BEFORE FIELD xmfvseq name="construct.b.page7.xmfvseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfvseq
            
            #add-point:AFTER FIELD xmfvseq name="construct.a.page7.xmfvseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.xmfvseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfvseq
            #add-point:ON ACTION controlp INFIELD xmfvseq name="construct.c.page7.xmfvseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfv001
            #add-point:BEFORE FIELD xmfv001 name="construct.b.page7.xmfv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfv001
            
            #add-point:AFTER FIELD xmfv001 name="construct.a.page7.xmfv001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.xmfv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfv001
            #add-point:ON ACTION controlp INFIELD xmfv001 name="construct.c.page7.xmfv001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfv002
            #add-point:BEFORE FIELD xmfv002 name="construct.b.page7.xmfv002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfv002
            
            #add-point:AFTER FIELD xmfv002 name="construct.a.page7.xmfv002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.xmfv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfv002
            #add-point:ON ACTION controlp INFIELD xmfv002 name="construct.c.page7.xmfv002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmfv002  #顯示到畫面上
            NEXT FIELD xmfv002                     #返回
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfvsite
            #add-point:BEFORE FIELD xmfvsite name="construct.b.page7.xmfvsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfvsite
            
            #add-point:AFTER FIELD xmfvsite name="construct.a.page7.xmfvsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page7.xmfvsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfvsite
            #add-point:ON ACTION controlp INFIELD xmfvsite name="construct.c.page7.xmfvsite"
            
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
 
            INITIALIZE g_wc2_table5 TO NULL
 
            INITIALIZE g_wc2_table6 TO NULL
 
            INITIALIZE g_wc2_table7 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "xmfo_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmfp_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "xmfq_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xmfr_t" 
                     LET g_wc2_table3 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xmfs_t" 
                     LET g_wc2_table4 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xmft_t" 
                     LET g_wc2_table5 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xmfu_t" 
                     LET g_wc2_table6 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "xmfv_t" 
                     LET g_wc2_table7 = la_wc[li_idx].wc
 
 
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
 
   IF g_wc2_table5 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
   END IF
 
   IF g_wc2_table6 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
   END IF
 
   IF g_wc2_table7 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION axmt700_filter()
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
      CONSTRUCT g_wc_filter ON xmfodocno,xmfo001,xmfo002,xmfo003,xmfo004,xmfo005,xmfo006,xmfo007
                          FROM s_browse[1].b_xmfodocno,s_browse[1].b_xmfo001,s_browse[1].b_xmfo002,s_browse[1].b_xmfo003, 
                              s_browse[1].b_xmfo004,s_browse[1].b_xmfo005,s_browse[1].b_xmfo006,s_browse[1].b_xmfo007 
 
 
         BEFORE CONSTRUCT
               DISPLAY axmt700_filter_parser('xmfodocno') TO s_browse[1].b_xmfodocno
            DISPLAY axmt700_filter_parser('xmfo001') TO s_browse[1].b_xmfo001
            DISPLAY axmt700_filter_parser('xmfo002') TO s_browse[1].b_xmfo002
            DISPLAY axmt700_filter_parser('xmfo003') TO s_browse[1].b_xmfo003
            DISPLAY axmt700_filter_parser('xmfo004') TO s_browse[1].b_xmfo004
            DISPLAY axmt700_filter_parser('xmfo005') TO s_browse[1].b_xmfo005
            DISPLAY axmt700_filter_parser('xmfo006') TO s_browse[1].b_xmfo006
            DISPLAY axmt700_filter_parser('xmfo007') TO s_browse[1].b_xmfo007
      
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
 
      CALL axmt700_filter_show('xmfodocno')
   CALL axmt700_filter_show('xmfo001')
   CALL axmt700_filter_show('xmfo002')
   CALL axmt700_filter_show('xmfo003')
   CALL axmt700_filter_show('xmfo004')
   CALL axmt700_filter_show('xmfo005')
   CALL axmt700_filter_show('xmfo006')
   CALL axmt700_filter_show('xmfo007')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION axmt700_filter_parser(ps_field)
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
 
{<section id="axmt700.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION axmt700_filter_show(ps_field)
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
   LET ls_condition = axmt700_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axmt700_query()
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
   CALL g_xmfp_d.clear()
   CALL g_xmfp2_d.clear()
   CALL g_xmfp3_d.clear()
   CALL g_xmfp4_d.clear()
   CALL g_xmfp5_d.clear()
   CALL g_xmfp6_d.clear()
   CALL g_xmfp7_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL axmt700_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axmt700_browser_fill("")
      CALL axmt700_fetch("")
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
   LET g_detail_idx_list[7] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL axmt700_filter_show('xmfodocno')
   CALL axmt700_filter_show('xmfo001')
   CALL axmt700_filter_show('xmfo002')
   CALL axmt700_filter_show('xmfo003')
   CALL axmt700_filter_show('xmfo004')
   CALL axmt700_filter_show('xmfo005')
   CALL axmt700_filter_show('xmfo006')
   CALL axmt700_filter_show('xmfo007')
   CALL axmt700_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL axmt700_fetch("F") 
      #顯示單身筆數
      CALL axmt700_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axmt700_fetch(p_flag)
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
   
   LET g_xmfo_m.xmfodocno = g_browser[g_current_idx].b_xmfodocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
   #遮罩相關處理
   LET g_xmfo_m_mask_o.* =  g_xmfo_m.*
   CALL axmt700_xmfo_t_mask()
   LET g_xmfo_m_mask_n.* =  g_xmfo_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt700_set_act_visible()   
   CALL axmt700_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmfo_m_t.* = g_xmfo_m.*
   LET g_xmfo_m_o.* = g_xmfo_m.*
   
   LET g_data_owner = g_xmfo_m.xmfoownid      
   LET g_data_dept  = g_xmfo_m.xmfoowndp
   
   #重新顯示   
   CALL axmt700_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.insert" >}
#+ 資料新增
PRIVATE FUNCTION axmt700_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#18 add
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_xmfp_d.clear()   
   CALL g_xmfp2_d.clear()  
   CALL g_xmfp3_d.clear()  
   CALL g_xmfp4_d.clear()  
   CALL g_xmfp5_d.clear()  
   CALL g_xmfp6_d.clear()  
   CALL g_xmfp7_d.clear()  
 
 
   INITIALIZE g_xmfo_m.* TO NULL             #DEFAULT 設定
   
   LET g_xmfodocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmfo_m.xmfoownid = g_user
      LET g_xmfo_m.xmfoowndp = g_dept
      LET g_xmfo_m.xmfocrtid = g_user
      LET g_xmfo_m.xmfocrtdp = g_dept 
      LET g_xmfo_m.xmfocrtdt = cl_get_current()
      LET g_xmfo_m.xmfomodid = g_user
      LET g_xmfo_m.xmfomoddt = cl_get_current()
      LET g_xmfo_m.xmfostus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_xmfo_m.xmfo014 = "0"
      LET g_xmfo_m.xmfo016 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      INITIALIZE g_xmfo_m_t.* TO NULL  
            
      LET g_xmfo_m.xmfosite = g_site
      LET g_xmfo_m.xmfodocdt = g_today
      LET g_xmfo_m.xmfo001 = g_today
      LET g_xmfo_m.xmfo002 = g_today 
      LET g_xmfo_m.xmfo003 = g_user 
      LET g_xmfo_m.xmfo004 = g_dept
      CALL s_desc_get_person_desc(g_xmfo_m.xmfo003) RETURNING g_xmfo_m.xmfo003_desc      
      CALL s_desc_get_department_desc(g_xmfo_m.xmfo004) RETURNING g_xmfo_m.xmfo004_desc
      DISPLAY BY NAME g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc      
      LET g_xmfo_m_o.* = g_xmfo_m.*   
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_xmfo_m_t.* = g_xmfo_m.*
      LET g_xmfo_m_o.* = g_xmfo_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfo_m.xmfostus 
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
    
      CALL axmt700_input("a")
      
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
         INITIALIZE g_xmfo_m.* TO NULL
         INITIALIZE g_xmfp_d TO NULL
         INITIALIZE g_xmfp2_d TO NULL
         INITIALIZE g_xmfp3_d TO NULL
         INITIALIZE g_xmfp4_d TO NULL
         INITIALIZE g_xmfp5_d TO NULL
         INITIALIZE g_xmfp6_d TO NULL
         INITIALIZE g_xmfp7_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL axmt700_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_xmfp_d.clear()
      #CALL g_xmfp2_d.clear()
      #CALL g_xmfp3_d.clear()
      #CALL g_xmfp4_d.clear()
      #CALL g_xmfp5_d.clear()
      #CALL g_xmfp6_d.clear()
      #CALL g_xmfp7_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt700_set_act_visible()   
   CALL axmt700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmfoent = " ||g_enterprise|| " AND",
                      " xmfodocno = '", g_xmfo_m.xmfodocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE axmt700_cl
   
   CALL axmt700_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
   
   #遮罩相關處理
   LET g_xmfo_m_mask_o.* =  g_xmfo_m.*
   CALL axmt700_xmfo_t_mask()
   LET g_xmfo_m_mask_n.* =  g_xmfo_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocno_desc,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002, 
       g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfostus, 
       g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo012_desc, 
       g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013, 
       g_xmfo_m.xmfo013_desc,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoownid_desc, 
       g_xmfo_m.xmfoowndp,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfomoddt, 
       g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfid_desc,g_xmfo_m.xmfocnfdt
   
   #add-point:新增結束後 name="insert.after"
   #161207-00033#18-s add
   IF NOT cl_null(g_xmfo_m.xmfo006) OR NOT cl_null(g_xmfo_m.xmfo008) THEN
      #一次性交易對象全名
      CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmfo_m.xmfo006)
           RETURNING l_pmak003

      IF NOT cl_null(l_pmak003) THEN
         LET g_xmfo_m.xmfo005_desc = l_pmak003
         DISPLAY BY NAME g_xmfo_m.xmfo005_desc
      END IF
   END IF
   #161207-00033#18-e add
   #end add-point 
   
   LET g_data_owner = g_xmfo_m.xmfoownid      
   LET g_data_dept  = g_xmfo_m.xmfoowndp
   
   #功能已完成,通報訊息中心
   CALL axmt700_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.modify" >}
#+ 資料修改
PRIVATE FUNCTION axmt700_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
   DEFINE l_wc2_table3   STRING
 
   DEFINE l_wc2_table4   STRING
 
   DEFINE l_wc2_table5   STRING
 
   DEFINE l_wc2_table6   STRING
 
   DEFINE l_wc2_table7   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_xmfo_m_t.* = g_xmfo_m.*
   LET g_xmfo_m_o.* = g_xmfo_m.*
   
   IF g_xmfo_m.xmfodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
   CALL s_transaction_begin()
   
   OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
   #檢查是否允許此動作
   IF NOT axmt700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmfo_m_mask_o.* =  g_xmfo_m.*
   CALL axmt700_xmfo_t_mask()
   LET g_xmfo_m_mask_n.* =  g_xmfo_m.*
   
   
   
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
 
   #LET l_wc2_table5 = g_wc2_table5
   #LET l_wc2_table5 = " 1=1"
 
   #LET l_wc2_table6 = g_wc2_table6
   #LET l_wc2_table6 = " 1=1"
 
   #LET l_wc2_table7 = g_wc2_table7
   #LET l_wc2_table7 = " 1=1"
 
 
 
   
   CALL axmt700_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
   #LET  g_wc2_table4 = l_wc2_table4 
 
   #LET  g_wc2_table5 = l_wc2_table5 
 
   #LET  g_wc2_table6 = l_wc2_table6 
 
   #LET  g_wc2_table7 = l_wc2_table7 
 
 
 
    
   WHILE TRUE
      LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_xmfo_m.xmfomodid = g_user 
LET g_xmfo_m.xmfomoddt = cl_get_current()
LET g_xmfo_m.xmfomodid_desc = cl_get_username(g_xmfo_m.xmfomodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL axmt700_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE xmfo_t SET (xmfomodid,xmfomoddt) = (g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt)
          WHERE xmfoent = g_enterprise AND xmfodocno = g_xmfodocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_xmfo_m.* = g_xmfo_m_t.*
            CALL axmt700_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_xmfo_m.xmfodocno != g_xmfo_m_t.xmfodocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE xmfp_t SET xmfpdocno = g_xmfo_m.xmfodocno
 
          WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfo_m_t.xmfodocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfp_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
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
         
         UPDATE xmfq_t
            SET xmfqdocno = g_xmfo_m.xmfodocno
 
          WHERE xmfqent = g_enterprise AND
                xmfqdocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfq_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
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
         
         UPDATE xmfr_t
            SET xmfrdocno = g_xmfo_m.xmfodocno
 
          WHERE xmfrent = g_enterprise AND
                xmfrdocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfr_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
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
         
         UPDATE xmfs_t
            SET xmfsdocno = g_xmfo_m.xmfodocno
 
          WHERE xmfsent = g_enterprise AND
                xmfsdocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update4"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfs_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update4"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update5"
         
         #end add-point
         
         UPDATE xmft_t
            SET xmftdocno = g_xmfo_m.xmfodocno
 
          WHERE xmftent = g_enterprise AND
                xmftdocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update5"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmft_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update5"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update6"
         
         #end add-point
         
         UPDATE xmfu_t
            SET xmfudocno = g_xmfo_m.xmfodocno
 
          WHERE xmfuent = g_enterprise AND
                xmfudocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update6"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfu_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update6"
         
         #end add-point
 
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update7"
         
         #end add-point
         
         UPDATE xmfv_t
            SET xmfvdocno = g_xmfo_m.xmfodocno
 
          WHERE xmfvent = g_enterprise AND
                xmfvdocno = g_xmfodocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update7"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "xmfv_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update7"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
         
         
         
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL axmt700_set_act_visible()   
   CALL axmt700_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xmfoent = " ||g_enterprise|| " AND",
                      " xmfodocno = '", g_xmfo_m.xmfodocno, "' "
 
   #填到對應位置
   CALL axmt700_browser_fill("")
 
   CLOSE axmt700_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt700_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="axmt700.input" >}
#+ 資料輸入
PRIVATE FUNCTION axmt700_input(p_cmd)
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
   DEFINE  l_ooef004    LIKE ooef_t.ooef004
   DEFINE  l_where      STRING
   DEFINE  l_success    LIKE type_t.num5  
   DEFINE  l_imaa005    LIKE imaa_t.imaa005 
   
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
   DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocno_desc,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002, 
       g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfostus, 
       g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo012_desc, 
       g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013, 
       g_xmfo_m.xmfo013_desc,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoownid_desc, 
       g_xmfo_m.xmfoowndp,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfomoddt, 
       g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfid_desc,g_xmfo_m.xmfocnfdt
   
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
   LET g_forupd_sql = "SELECT xmfpseq,xmfp001,xmfpsite FROM xmfp_t WHERE xmfpent=? AND xmfpdocno=? AND  
       xmfpseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite FROM xmfq_t WHERE xmfqent=? AND  
       xmfqdocno=? AND xmfqseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite FROM xmfr_t WHERE xmfrent=? AND  
       xmfrdocno=? AND xmfrseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl3 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql4"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite FROM xmfs_t WHERE xmfsent=? AND  
       xmfsdocno=? AND xmfsseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql4"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl4 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql5"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmftseq,xmft001,xmft002,xmftsite FROM xmft_t WHERE xmftent=? AND xmftdocno=?  
       AND xmftseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql5"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl5 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql6"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmfuseq,xmfu001,xmfu002,xmfusite FROM xmfu_t WHERE xmfuent=? AND xmfudocno=?  
       AND xmfuseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql6"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl6 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql7"
   
   #end add-point    
   LET g_forupd_sql = "SELECT xmfvseq,xmfv001,xmfv002,xmfvsite FROM xmfv_t WHERE xmfvent=? AND xmfvdocno=?  
       AND xmfvseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql7"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl7 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axmt700_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axmt700_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003, 
       g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007, 
       g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016,g_xmfo_m.xmfosite 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axmt700.input.head" >}
      #單頭段
      INPUT BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003, 
          g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007, 
          g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016,g_xmfo_m.xmfosite  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL axmt700_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL axmt700_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfodocno
            
            #add-point:AFTER FIELD xmfodocno name="input.a.xmfodocno"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            LET g_xmfo_m.xmfodocno_desc = ''
            CALL s_aooi200_get_slip_desc(g_xmfo_m.xmfodocno) RETURNING g_xmfo_m.xmfodocno_desc
            DISPLAY BY NAME g_xmfo_m.xmfodocno_desc
            IF NOT cl_null(g_xmfo_m.xmfodocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfo_t WHERE "||"xmfoent = '" ||g_enterprise|| "' AND "||"xmfodocno = '"||g_xmfo_m.xmfodocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_aooi200_chk_slip(g_site,'',g_xmfo_m.xmfodocno,g_prog) THEN
                     LET g_xmfo_m.xmfodocno = g_xmfo_m_o.xmfodocno
                     CALL s_aooi200_get_slip_desc(g_xmfo_m.xmfodocno) RETURNING g_xmfo_m.xmfodocno_desc
                     DISPLAY BY NAME g_xmfo_m.xmfodocno_desc                  
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfodocno
            #add-point:BEFORE FIELD xmfodocno name="input.b.xmfodocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfodocno
            #add-point:ON CHANGE xmfodocno name="input.g.xmfodocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfodocdt
            #add-point:BEFORE FIELD xmfodocdt name="input.b.xmfodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfodocdt
            
            #add-point:AFTER FIELD xmfodocdt name="input.a.xmfodocdt"
            IF NOT cl_null(g_xmfo_m.xmfo001) THEN
               IF g_xmfo_m.xmfo001 < g_xmfo_m.xmfodocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00714'          #處理期限不可小於客訴日期
                  LET g_errparam.extend = g_xmfo_m.xmfo001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xmfo001               
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfodocdt
            #add-point:ON CHANGE xmfodocdt name="input.g.xmfodocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo001
            #add-point:BEFORE FIELD xmfo001 name="input.b.xmfo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo001
            
            #add-point:AFTER FIELD xmfo001 name="input.a.xmfo001"
            IF NOT cl_null(g_xmfo_m.xmfo001) THEN
               IF g_xmfo_m.xmfo001 < g_xmfo_m.xmfodocdt THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00714'           #處理期限不可小於客訴日期
                  LET g_errparam.extend = g_xmfo_m.xmfo001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmfo_m.xmfo001 = g_xmfo_m_o.xmfo001
                  DISPLAY BY NAME g_xmfo_m.xmfo001
                  NEXT FIELD CURRENT               
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo001
            #add-point:ON CHANGE xmfo001 name="input.g.xmfo001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo002
            #add-point:BEFORE FIELD xmfo002 name="input.b.xmfo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo002
            
            #add-point:AFTER FIELD xmfo002 name="input.a.xmfo002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo002
            #add-point:ON CHANGE xmfo002 name="input.g.xmfo002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo003
            
            #add-point:AFTER FIELD xmfo003 name="input.a.xmfo003"
            LET g_xmfo_m.xmfo003_desc = ''
            CALL s_desc_get_person_desc(g_xmfo_m.xmfo003) RETURNING g_xmfo_m.xmfo003_desc
            DISPLAY BY NAME g_xmfo_m.xmfo003_desc
            IF NOT cl_null(g_xmfo_m.xmfo003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfo_m.xmfo003 != g_xmfo_m_o.xmfo003 OR cl_null(g_xmfo_m.xmfo003))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfo_m.xmfo003
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfo_m.xmfo004 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfo_m.xmfo003
                     CALL s_desc_get_department_desc(g_xmfo_m.xmfo004) RETURNING g_xmfo_m.xmfo004_desc
                     DISPLAY BY NAME g_xmfo_m.xmfo004_desc 
                  ELSE
                     LET g_xmfo_m.xmfo003 = g_xmfo_m_o.xmfo003
                     CALL s_desc_get_person_desc(g_xmfo_m.xmfo003) RETURNING g_xmfo_m.xmfo003_desc
                     DISPLAY BY NAME g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfo_m_o.xmfo003 = g_xmfo_m.xmfo003 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo003
            #add-point:BEFORE FIELD xmfo003 name="input.b.xmfo003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo003
            #add-point:ON CHANGE xmfo003 name="input.g.xmfo003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo004
            
            #add-point:AFTER FIELD xmfo004 name="input.a.xmfo004"
            LET g_xmfo_m.xmfo004_desc = ''
            CALL s_desc_get_department_desc(g_xmfo_m.xmfo004) RETURNING g_xmfo_m.xmfo004_desc
            DISPLAY BY NAME g_xmfo_m.xmfo004_desc 
            IF NOT cl_null(g_xmfo_m.xmfo004) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_xmfo_m.xmfo004
               LET g_chkparam.arg2 = g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET g_xmfo_m.xmfo004 = g_xmfo_m_o.xmfo004
                  CALL s_desc_get_department_desc(g_xmfo_m.xmfo004) RETURNING g_xmfo_m.xmfo004_desc
                  DISPLAY BY NAME g_xmfo_m.xmfo004_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET g_xmfo_m_o.xmfo004 = g_xmfo_m.xmfo004               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo004
            #add-point:BEFORE FIELD xmfo004 name="input.b.xmfo004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo004
            #add-point:ON CHANGE xmfo004 name="input.g.xmfo004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfostus
            #add-point:BEFORE FIELD xmfostus name="input.b.xmfostus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfostus
            
            #add-point:AFTER FIELD xmfostus name="input.a.xmfostus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfostus
            #add-point:ON CHANGE xmfostus name="input.g.xmfostus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo005
            
            #add-point:AFTER FIELD xmfo005 name="input.a.xmfo005"
            LET g_xmfo_m.xmfo005_desc = ''
            #CALL s_desc_get_trading_partner_abbr_desc(g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc   #161207-00033#18 MARK
            #161207-00033#18-s
            CALL axmt700_guest_desc(p_cmd,g_xmfo_m.xmfo006,g_xmfo_m.xmfo008,g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc
            #161207-00033#18-e
            DISPLAY BY NAME g_xmfo_m.xmfo005_desc            
            IF NOT cl_null(g_xmfo_m.xmfo005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfo_m.xmfo005 != g_xmfo_m_o.xmfo005 OR cl_null(g_xmfo_m_o.xmfo005))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmfo_m.xmfo005
                  LET g_chkparam.arg2 = g_site
                  #160318-00025#35  2016/04/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"
                  #160318-00025#35  2016/04/15  by pengxin  add(E)
                  IF NOT cl_chk_exist("v_pmaa001_3") THEN
                     LET g_xmfo_m.xmfo005 = g_xmfo_m_o.xmfo005
                     #CALL s_desc_get_trading_partner_abbr_desc(g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc #161207-00033#18 MARK
                     #161207-00033#18-s
                     CALL axmt700_guest_desc(p_cmd,g_xmfo_m.xmfo006,g_xmfo_m.xmfo008,g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc
                     #161207-00033#18-e
                     DISPLAY BY NAME g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT s_control_check_customer(g_xmfo_m.xmfo005,'2',g_site,g_user,g_dept,g_xmfo_m.xmfodocno) THEN
                     LET g_xmfo_m.xmfo005 = g_xmfo_m_o.xmfo005
                     #CALL s_desc_get_trading_partner_abbr_desc(g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc  #161207-00033#18 MARK
                     #161207-00033#18-s
                     CALL axmt700_guest_desc(p_cmd,g_xmfo_m.xmfo006,g_xmfo_m.xmfo008,g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc
                     #161207-00033#18-e
                     DISPLAY BY NAME g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc
                     NEXT FIELD CURRENT
                  END IF
                  #檢查此客戶是否存在出貨單
                  IF NOT cl_null(g_xmfo_m.xmfo006) AND NOT cl_null(g_xmfo_m.xmfo007) THEN
                     IF NOT axmt700_xmdkdocno_chk(g_xmfo_m.xmfo005,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00715'         #查無此客戶之出貨單單號！
                        LET g_errparam.extend = g_xmfo_m.xmfo005
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmfo_m.xmfo005 = g_xmfo_m_o.xmfo005
                        DISPLAY BY NAME g_xmfo_m.xmfo005
                        NEXT FIELD CURRENT                    
                     END IF                  
                  END IF
               END IF
               LET g_xmfo_m_o.xmfo005 = g_xmfo_m.xmfo005
            END IF
                       
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo005
            #add-point:BEFORE FIELD xmfo005 name="input.b.xmfo005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo005
            #add-point:ON CHANGE xmfo005 name="input.g.xmfo005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo012
            
            #add-point:AFTER FIELD xmfo012 name="input.a.xmfo012"
            LET g_xmfo_m.xmfo012_desc = ''
            LET g_xmfo_m.xmfo012_desc_1 = ''
            CALL s_desc_get_item_desc(g_xmfo_m.xmfo012) RETURNING g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
            IF NOT cl_null(g_xmfo_m.xmfo012) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfo_m.xmfo012 != g_xmfo_m_o.xmfo012 OR cl_null(g_xmfo_m_o.xmfo012))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmfo_m.xmfo012
                  IF NOT cl_chk_exist("v_imaf001_17") THEN
                     LET g_xmfo_m.xmfo012 = g_xmfo_m_o.xmfo012
                     CALL s_desc_get_item_desc(g_xmfo_m.xmfo012) RETURNING g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
                     DISPLAY BY NAME g_xmfo_m.xmfo012,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT s_control_check_item(g_xmfo_m.xmfo012,'2',g_site,g_user,g_dept,g_xmfo_m.xmfodocno) THEN
                     LET g_xmfo_m.xmfo012 = g_xmfo_m_o.xmfo012
                     CALL s_desc_get_item_desc(g_xmfo_m.xmfo012) RETURNING g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
                     DISPLAY BY NAME g_xmfo_m.xmfo012,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #依料件帶出銷售單位
               SELECT imaf112 INTO g_xmfo_m.xmfo015
                 FROM imaf_t
                WHERE imafent = g_enterprise
                  AND imafsite = g_site
                  AND imaf001 = g_xmfo_m.xmfo012
               IF NOT cl_null(g_xmfo_m.xmfo015) THEN
                  CALL s_desc_get_unit_desc(g_xmfo_m.xmfo015) RETURNING g_xmfo_m.xmfo015_desc   
                  DISPLAY BY NAME g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc
                  LET g_xmfo_m_o.xmfo015 = g_xmfo_m.xmfo015
               END IF   
               LET g_xmfo_m_o.xmfo012 = g_xmfo_m.xmfo012 
            END IF
            CALL axmt700_set_entry(p_cmd)
            CALL axmt700_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo012
            #add-point:BEFORE FIELD xmfo012 name="input.b.xmfo012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo012
            #add-point:ON CHANGE xmfo012 name="input.g.xmfo012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo006
            #add-point:BEFORE FIELD xmfo006 name="input.b.xmfo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo006
            
            #add-point:AFTER FIELD xmfo006 name="input.a.xmfo006"
            IF NOT cl_null(g_xmfo_m.xmfo006) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfo_m.xmfo006 != g_xmfo_m_o.xmfo006 OR cl_null(g_xmfo_m_o.xmfo006))) THEN
                  IF NOT cl_null(g_xmfo_m.xmfo007) THEN
                     IF NOT axmt700_xmdkdocno_chk(g_xmfo_m.xmfo005,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007) THEN
                        INITIALIZE g_errparam TO NULL
                        IF NOT cl_null(g_xmfo_m.xmfo005) THEN
                           LET g_errparam.code = 'axm-00715'       #查無此客戶之出貨單單號！
                        ELSE
                           LET g_errparam.code = 'arm-00016'
                        END IF
                        
                        LET g_errparam.extend = g_xmfo_m.xmfo006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmfo_m.xmfo006 = g_xmfo_m_o.xmfo006
                        DISPLAY BY NAME g_xmfo_m.xmfo006
                        NEXT FIELD CURRENT                    
                     ELSE
                        IF NOT axmt700_xmfo006_chk() THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code =  'axm-00746'   #已無數量可客訴！！
                           LET g_errparam.extend = g_xmfo_m.xmfo006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()   
                           LET g_xmfo_m.xmfo006 = g_xmfo_m_o.xmfo006
                           DISPLAY BY NAME g_xmfo_m.xmfo006                           
                        ELSE                  
                           CALL axmt700_xmdgdocno_ref() 
                        END IF
                     END IF
                  END IF

               END IF
            ELSE
               CALL axmt700_xmdkdocno_clear()            
            END IF
            CALL axmt700_set_entry(p_cmd)
            CALL axmt700_set_no_entry(p_cmd)
            LET g_xmfo_m_o.xmfo006 = g_xmfo_m.xmfo006            
            LET g_xmfo_m_o.xmfo007 = g_xmfo_m.xmfo007
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo006
            #add-point:ON CHANGE xmfo006 name="input.g.xmfo006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo007
            #add-point:BEFORE FIELD xmfo007 name="input.b.xmfo007"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo007
            
            #add-point:AFTER FIELD xmfo007 name="input.a.xmfo007"
            IF NOT cl_null(g_xmfo_m.xmfo007) THEN
               IF cl_null(g_xmfo_m.xmfo006) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adb-00410'      #請先輸入出貨單號
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_xmfo_m.xmfo007 = g_xmfo_m_o.xmfo007
                  DISPLAY BY NAME g_xmfo_m.xmfo007                  
                  CALL cl_err()               
                  NEXT FIELD xmfo006
               END IF            
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfo_m.xmfo007 != g_xmfo_m_o.xmfo007 OR cl_null(g_xmfo_m_o.xmfo007))) THEN
                  IF NOT cl_null(g_xmfo_m.xmfo006) THEN
                     IF NOT axmt700_xmdkdocno_chk(g_xmfo_m.xmfo005,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007) THEN
                        INITIALIZE g_errparam TO NULL
                        IF NOT cl_null(g_xmfo_m.xmfo005) THEN
                           LET g_errparam.code = 'axm-00715'     #查無此客戶之出貨單單號！
                        ELSE
                           LET g_errparam.code = 'arm-00016'
                        END IF
                        LET g_errparam.extend = g_xmfo_m.xmfo006
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmfo_m.xmfo007 = g_xmfo_m_o.xmfo007
                        DISPLAY BY NAME g_xmfo_m.xmfo007
                        NEXT FIELD CURRENT                    
                     ELSE
                        IF NOT axmt700_xmfo006_chk() THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code =  'axm-00746'   #已無數量可客訴！！
                           LET g_errparam.extend = g_xmfo_m.xmfo006
                           LET g_errparam.popup = TRUE
                           CALL cl_err()   
                           LET g_xmfo_m.xmfo006 = g_xmfo_m_o.xmfo006
                           DISPLAY BY NAME g_xmfo_m.xmfo006  
                           NEXT FIELD CURRENT                           
                        ELSE                      
                           CALL axmt700_xmdgdocno_ref()
                        END IF
                     END IF
                  END IF
               END IF
            ELSE
               CALL axmt700_xmdkdocno_clear()            
            END IF
            CALL axmt700_set_entry(p_cmd)
            CALL axmt700_set_no_entry(p_cmd)
            LET g_xmfo_m_o.xmfo007 = g_xmfo_m.xmfo007            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo007
            #add-point:ON CHANGE xmfo007 name="input.g.xmfo007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo013
            
            #add-point:AFTER FIELD xmfo013 name="input.a.xmfo013"
            LET g_xmfo_m.xmfo013_desc = ''
            CALL s_feature_description(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013)
              RETURNING l_success,g_xmfo_m.xmfo013_desc
            IF g_xmfo_m.xmfo013 IS NOT NULL THEN
               IF NOT s_feature_check(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013) THEN
                  LET g_xmfo_m.xmfo013 = g_xmfo_m_o.xmfo013
                  CALL s_feature_description(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013)
                    RETURNING l_success,g_xmfo_m.xmfo013_desc                  
                  DISPLAY BY NAME g_xmfo_m_o.xmfo013,g_xmfo_m_o.xmfo013_desc  
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#5---dorishsu---151228---add--
               IF NOT s_feature_direct_input(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013,g_xmfo_m_o.xmfo013,g_xmfo_m.xmfodocno,g_xmfo_m.xmfosite) THEN
                  NEXT FIELD CURRENT
               END IF
               #151224-00025#5---dorishsu---151228---end--
            END IF
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_xmfo_m.xmfo012            
            IF NOT cl_null(l_imaa005) AND cl_null(g_xmfo_m.xmfo013) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  'sub-00124'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD CURRENT  
            ELSE
               LET g_xmfo_m.xmfo013 = ' '            
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo013
            #add-point:BEFORE FIELD xmfo013 name="input.b.xmfo013"
           #160314-00009#15 add(s)  
           IF s_feature_auto_chk(g_xmfo_m.xmfo012) AND cl_null(g_xmfo_m.xmfo013) THEN #160314-00009#15 add           
              CALL s_feature_single(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013,g_site,g_xmfo_m.xmfodocno)
                 RETURNING l_success,g_xmfo_m.xmfo013
              DISPLAY BY NAME g_xmfo_m.xmfo013
              CALL s_feature_description(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013)
                 RETURNING l_success,g_xmfo_m.xmfo013_desc
           END IF
           #160314-00009#15 add(e) 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo013
            #add-point:ON CHANGE xmfo013 name="input.g.xmfo013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo018
            #add-point:BEFORE FIELD xmfo018 name="input.b.xmfo018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo018
            
            #add-point:AFTER FIELD xmfo018 name="input.a.xmfo018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo018
            #add-point:ON CHANGE xmfo018 name="input.g.xmfo018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo014
            #add-point:BEFORE FIELD xmfo014 name="input.b.xmfo014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo014
            
            #add-point:AFTER FIELD xmfo014 name="input.a.xmfo014"
            IF NOT cl_ap_chk_range(g_xmfo_m.xmfo014,"0.000","1","","","azz-00079",1) THEN
               LET g_xmfo_m.xmfo014 = g_xmfo_m_o.xmfo014
               NEXT FIELD CURRENT 
            END IF
            IF NOT cl_null(g_xmfo_m.xmfo006) AND NOT cl_null(g_xmfo_m.xmfo007) THEN 
               IF NOT axmt700_xmfo006_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'axm-00716'   #客訴數量不可大於出貨數量！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET g_xmfo_m.xmfo014 = g_xmfo_m_o.xmfo014
                  NEXT FIELD CURRENT                 
               END IF                  
            END IF
            LET g_xmfo_m_o.xmfo014 = g_xmfo_m.xmfo014
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo014
            #add-point:ON CHANGE xmfo014 name="input.g.xmfo014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo015
            
            #add-point:AFTER FIELD xmfo015 name="input.a.xmfo015"
            LET g_xmfo_m.xmfo015_desc = ''
            CALL s_desc_get_unit_desc(g_xmfo_m.xmfo015) RETURNING g_xmfo_m.xmfo015_desc
            IF NOT cl_null(g_xmfo_m.xmfo015) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xmfo_m.xmfo015 != g_xmfo_m_o.xmfo015 OR cl_null(g_xmfo_m_o.xmfo015))) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_xmfo_m.xmfo012
                  LET g_chkparam.arg2 = g_xmfo_m.xmfo015
                  IF NOT cl_chk_exist("v_imao002") THEN
                     LET g_xmfo_m.xmfo015 = g_xmfo_m_o.xmfo015
                     CALL s_desc_get_unit_desc(g_xmfo_m.xmfo015) RETURNING g_xmfo_m.xmfo015_desc
                     DISPLAY BY NAME g_xmfo_m.xmfo015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_xmfo_m_o.xmfo015 = g_xmfo_m.xmfo015 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo015
            #add-point:BEFORE FIELD xmfo015 name="input.b.xmfo015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo015
            #add-point:ON CHANGE xmfo015 name="input.g.xmfo015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfo016
            #add-point:BEFORE FIELD xmfo016 name="input.b.xmfo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfo016
            
            #add-point:AFTER FIELD xmfo016 name="input.a.xmfo016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfo016
            #add-point:ON CHANGE xmfo016 name="input.g.xmfo016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfosite
            #add-point:BEFORE FIELD xmfosite name="input.b.xmfosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfosite
            
            #add-point:AFTER FIELD xmfosite name="input.a.xmfosite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfosite
            #add-point:ON CHANGE xmfosite name="input.g.xmfosite"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xmfodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfodocno
            #add-point:ON ACTION controlp INFIELD xmfodocno name="input.c.xmfodocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfo_m.xmfodocno             #給予default值
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = g_prog
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_xmfo_m.xmfodocno = g_qryparam.return1              
            DISPLAY g_xmfo_m.xmfodocno TO xmfodocno              #
            NEXT FIELD xmfodocno                          #返回原欄位
            CALL s_aooi200_get_slip_desc(g_xmfo_m.xmfodocno) RETURNING g_xmfo_m.xmfodocno_desc
            DISPLAY BY NAME g_xmfo_m.xmfodocno_desc             
            #END add-point
 
 
         #Ctrlp:input.c.xmfodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfodocdt
            #add-point:ON ACTION controlp INFIELD xmfodocdt name="input.c.xmfodocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo001
            #add-point:ON ACTION controlp INFIELD xmfo001 name="input.c.xmfo001"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo002
            #add-point:ON ACTION controlp INFIELD xmfo002 name="input.c.xmfo002"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo003
            #add-point:ON ACTION controlp INFIELD xmfo003 name="input.c.xmfo003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfo_m.xmfo003             #給予default值
            CALL q_ooag001()                                       #呼叫開窗
            LET g_xmfo_m.xmfo003 = g_qryparam.return1           
            DISPLAY g_xmfo_m.xmfo003 TO xmfo003              
            NEXT FIELD xmfo003                                     #返回原欄位
            CALL s_desc_get_person_desc(g_xmfo_m.xmfo003) RETURNING g_xmfo_m.xmfo003_desc
            DISPLAY BY NAME g_xmfo_m.xmfo003_desc            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo004
            #add-point:ON ACTION controlp INFIELD xmfo004 name="input.c.xmfo004"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfo_m.xmfo004 
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt            
            CALL q_ooeg001()                                
            LET g_xmfo_m.xmfo004 = g_qryparam.return1              
            DISPLAY g_xmfo_m.xmfo004 TO xmfo004             
            NEXT FIELD xmfo004                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfo_m.xmfo004) RETURNING g_xmfo_m.xmfo004_desc
            DISPLAY BY NAME g_xmfo_m.xmfo004_desc            
            #END add-point
 
 
         #Ctrlp:input.c.xmfostus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfostus
            #add-point:ON ACTION controlp INFIELD xmfostus name="input.c.xmfostus"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo005
            #add-point:ON ACTION controlp INFIELD xmfo005 name="input.c.xmfo005"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "1=1 "
            LET l_where = ''
            CALL s_control_get_customer_sql('2',g_site,g_user,g_dept,g_xmfo_m.xmfodocno) RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            LET g_qryparam.default1 = g_xmfo_m.xmfo005             #給予default值
            LET g_qryparam.arg1 = g_site
            CALL q_pmaa001_6()                                #呼叫開窗
            LET g_xmfo_m.xmfo005 = g_qryparam.return1              
            DISPLAY g_xmfo_m.xmfo005 TO xmfo005              #
            NEXT FIELD xmfo005                          #返回原欄位
            #CALL s_desc_get_trading_partner_abbr_desc(g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc  #161207-00033#18 MARK
            #161207-00033#18-s
            CALL axmt700_guest_desc(p_cmd,g_xmfo_m.xmfo006,g_xmfo_m.xmfo008,g_xmfo_m.xmfo005) RETURNING g_xmfo_m.xmfo005_desc
            #161207-00033#18-e
            DISPLAY BY NAME g_xmfo_m.xmfo005_desc
            #END add-point
 
 
         #Ctrlp:input.c.xmfo012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo012
            #add-point:ON ACTION controlp INFIELD xmfo012 name="input.c.xmfo012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfo_m.xmfo012             
            CALL q_imaf001_6()                     
            LET g_xmfo_m.xmfo012 = g_qryparam.return1             
            DISPLAY g_xmfo_m.xmfo012 TO xmfo012              
            CALL s_desc_get_item_desc(g_xmfo_m.xmfo012) RETURNING g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1                          
            DISPLAY BY NAME g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1                          
            NEXT FIELD xmfo012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmfo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo006
            #add-point:ON ACTION controlp INFIELD xmfo006 name="input.c.xmfo006"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfo_m.xmfo006             
            LET g_qryparam.default2 = g_xmfo_m.xmfo007
            IF NOT cl_null(g_xmfo_m.xmfo005) THEN
               LET g_qryparam.where = " xmdk007 = '",g_xmfo_m.xmfo005,"' "
            END IF
            CALL q_xmdldocno_1()               
            LET g_xmfo_m.xmfo006 = g_qryparam.return1              
            LET g_xmfo_m.xmfo007 = g_qryparam.return2  
            DISPLAY g_xmfo_m.xmfo006 TO xmfo006              
            DISPLAY g_xmfo_m.xmfo007 TO xmfo007              
            NEXT FIELD xmfo006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.xmfo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo007
            #add-point:ON ACTION controlp INFIELD xmfo007 name="input.c.xmfo007"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo013
            #add-point:ON ACTION controlp INFIELD xmfo013 name="input.c.xmfo013"
            LET l_imaa005 = ''
            SELECT imaa005 INTO l_imaa005
              FROM imaa_t
             WHERE imaaent = g_enterprise
               AND imaa001 = g_xmfo_m.xmfo012

            IF NOT cl_null(l_imaa005) THEN
               CALL s_feature_single(g_xmfo_m.xmfo012,g_xmfo_m.xmfo013,g_site,g_xmfo_m.xmfodocno)
                 RETURNING l_success,g_xmfo_m.xmfo013
                  DISPLAY BY NAME g_xmfo_m.xmfo013
            END IF
            #END add-point
 
 
         #Ctrlp:input.c.xmfo018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo018
            #add-point:ON ACTION controlp INFIELD xmfo018 name="input.c.xmfo018"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo014
            #add-point:ON ACTION controlp INFIELD xmfo014 name="input.c.xmfo014"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo015
            #add-point:ON ACTION controlp INFIELD xmfo015 name="input.c.xmfo015"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfo016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfo016
            #add-point:ON ACTION controlp INFIELD xmfo016 name="input.c.xmfo016"
            
            #END add-point
 
 
         #Ctrlp:input.c.xmfosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfosite
            #add-point:ON ACTION controlp INFIELD xmfosite name="input.c.xmfosite"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xmfo_m.xmfodocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            #資料檢核            
            IF NOT cl_null(g_xmfo_m.xmfo006) AND NOT cl_null(g_xmfo_m.xmfo007) THEN
               #檢查出貨單
               IF NOT axmt700_xmdkdocno_chk(g_xmfo_m.xmfo005,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00715'           #查無此客戶之出貨單單號！
                  LET g_errparam.extend = g_xmfo_m.xmfo006
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xmfo006                   
               END IF 
               #檢查客訴數量
               IF NOT axmt700_xmfo006_chk() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  'axm-00716'   #客訴數量不可大於出貨數量！
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD xmfo006                 
               END IF
            END IF  
            #取單號
            CALL s_aooi200_gen_docno(g_site,g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt,g_prog) RETURNING l_success,g_xmfo_m.xmfodocno
            IF NOT l_success THEN
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00003'
               LET g_errparam.extend = g_xmfo_m.xmfodocno
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmfodocno
               CONTINUE DIALOG
            END IF
            DISPLAY BY NAME g_xmfo_m.xmfodocno            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO xmfo_t (xmfoent,xmfodocno,xmfodocdt,xmfo001,xmfo002,xmfo003,xmfo004,xmfostus, 
                   xmfo005,xmfo012,xmfo006,xmfo007,xmfo008,xmfo009,xmfo010,xmfo011,xmfo013,xmfo018,xmfo014, 
                   xmfo015,xmfo016,xmfo017,xmfosite,xmfoownid,xmfoowndp,xmfocrtid,xmfocrtdp,xmfocrtdt, 
                   xmfomodid,xmfomoddt,xmfocnfid,xmfocnfdt)
               VALUES (g_enterprise,g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002, 
                   g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005,g_xmfo_m.xmfo012, 
                   g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
                   g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015, 
                   g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp, 
                   g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt, 
                   g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_xmfo_m:",SQLERRMESSAGE 
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
                  CALL axmt700_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL axmt700_b_fill()
                  CALL axmt700_b_fill2('0')
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
               CALL axmt700_xmfo_t_mask_restore('restore_mask_o')
               
               UPDATE xmfo_t SET (xmfodocno,xmfodocdt,xmfo001,xmfo002,xmfo003,xmfo004,xmfostus,xmfo005, 
                   xmfo012,xmfo006,xmfo007,xmfo008,xmfo009,xmfo010,xmfo011,xmfo013,xmfo018,xmfo014,xmfo015, 
                   xmfo016,xmfo017,xmfosite,xmfoownid,xmfoowndp,xmfocrtid,xmfocrtdp,xmfocrtdt,xmfomodid, 
                   xmfomoddt,xmfocnfid,xmfocnfdt) = (g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001, 
                   g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
                   g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009, 
                   g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014, 
                   g_xmfo_m.xmfo015,g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid, 
                   g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid, 
                   g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt)
                WHERE xmfoent = g_enterprise AND xmfodocno = g_xmfodocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "xmfo_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfo_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="axmt700.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_xmfp_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_xmfp_d.getLength()
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
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp_d[l_ac].xmfpseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xmfp_d_t.* = g_xmfp_d[l_ac].*  #BACKUP
               LET g_xmfp_d_o.* = g_xmfp_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfp_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl INTO g_xmfp_d[l_ac].xmfpseq,g_xmfp_d[l_ac].xmfp001,g_xmfp_d[l_ac].xmfpsite 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xmfp_d_t.xmfpseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp_d_mask_o[l_ac].* =  g_xmfp_d[l_ac].*
                  CALL axmt700_xmfp_t_mask()
                  LET g_xmfp_d_mask_n[l_ac].* =  g_xmfp_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
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
            INITIALIZE g_xmfp_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp_d_t.* TO NULL 
            INITIALIZE g_xmfp_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_xmfp_d_t.* = g_xmfp_d[l_ac].*     #新輸入資料
            LET g_xmfp_d_o.* = g_xmfp_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
 
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp_d[li_reproduce_target].* = g_xmfp_d[li_reproduce].*
 
               LET g_xmfp_d[li_reproduce_target].xmfpseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #項次加1
            SELECT MAX(xmfpseq)+1 INTO g_xmfp_d[l_ac].xmfpseq FROM xmfp_t
             WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp_d[l_ac].xmfpseq) OR g_xmfp_d[l_ac].xmfpseq = 0 THEN
               LET g_xmfp_d[l_ac].xmfpseq = 1
            END IF
            LET g_xmfp_d[l_ac].xmfpsite = g_xmfo_m.xmfosite
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
            SELECT COUNT(1) INTO l_count FROM xmfp_t 
             WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfo_m.xmfodocno
 
               AND xmfpseq = g_xmfp_d[l_ac].xmfpseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp_d[g_detail_idx].xmfpseq
               CALL axmt700_insert_b('xmfp_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
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
               LET gs_keys[01] = g_xmfo_m.xmfodocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp_d_t.xmfpseq
 
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfp_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfp_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfp001
            #add-point:BEFORE FIELD xmfp001 name="input.b.page1.xmfp001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfp001
            
            #add-point:AFTER FIELD xmfp001 name="input.a.page1.xmfp001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfp001
            #add-point:ON CHANGE xmfp001 name="input.g.page1.xmfp001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfpsite
            #add-point:BEFORE FIELD xmfpsite name="input.b.page1.xmfpsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfpsite
            
            #add-point:AFTER FIELD xmfpsite name="input.a.page1.xmfpsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfpsite
            #add-point:ON CHANGE xmfpsite name="input.g.page1.xmfpsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmfp001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfp001
            #add-point:ON ACTION controlp INFIELD xmfp001 name="input.c.page1.xmfp001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmfpsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfpsite
            #add-point:ON ACTION controlp INFIELD xmfpsite name="input.c.page1.xmfpsite"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfp_d[l_ac].* = g_xmfp_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xmfp_d[l_ac].xmfpseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_xmfp_d[l_ac].* = g_xmfp_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL axmt700_xmfp_t_mask_restore('restore_mask_o')
      
               UPDATE xmfp_t SET (xmfpdocno,xmfpseq,xmfp001,xmfpsite) = (g_xmfo_m.xmfodocno,g_xmfp_d[l_ac].xmfpseq, 
                   g_xmfp_d[l_ac].xmfp001,g_xmfp_d[l_ac].xmfpsite)
                WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfo_m.xmfodocno 
 
                  AND xmfpseq = g_xmfp_d_t.xmfpseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp_d[l_ac].* = g_xmfp_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfp_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp_d[l_ac].* = g_xmfp_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp_d[g_detail_idx].xmfpseq
               LET gs_keys_bak[2] = g_xmfp_d_t.xmfpseq
               CALL axmt700_update_b('xmfp_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfp_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_xmfp_d[g_detail_idx].xmfpseq = g_xmfp_d_t.xmfpseq 
 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp_d_t.xmfpseq
 
                  CALL axmt700_key_update_b(gs_keys,'xmfp_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL axmt700_unlock_b("xmfp_t","'1'")
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
               LET g_xmfp_d[li_reproduce_target].* = g_xmfp_d[li_reproduce].*
 
               LET g_xmfp_d[li_reproduce_target].xmfpseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_xmfp2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp2_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp2_d_t.* TO NULL 
            INITIALIZE g_xmfp2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_xmfp2_d_t.* = g_xmfp2_d[l_ac].*     #新輸入資料
            LET g_xmfp2_d_o.* = g_xmfp2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp2_d[li_reproduce_target].* = g_xmfp2_d[li_reproduce].*
 
               LET g_xmfp2_d[li_reproduce_target].xmfqseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            #項次加1
            SELECT MAX(xmfqseq)+1 INTO g_xmfp2_d[l_ac].xmfqseq FROM xmfq_t
             WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp2_d[l_ac].xmfqseq) OR g_xmfp2_d[l_ac].xmfqseq = 0 THEN
               LET g_xmfp2_d[l_ac].xmfqseq = 1
            END IF
            LET g_xmfp2_d[l_ac].xmfqsite = g_xmfo_m.xmfosite
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
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp2_d[l_ac].xmfqseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp2_d_t.* = g_xmfp2_d[l_ac].*  #BACKUP
               LET g_xmfp2_d_o.* = g_xmfp2_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfq_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl2 INTO g_xmfp2_d[l_ac].xmfqseq,g_xmfp2_d[l_ac].xmfq001,g_xmfp2_d[l_ac].xmfq002, 
                      g_xmfp2_d[l_ac].xmfq003,g_xmfp2_d[l_ac].xmfqsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp2_d_mask_o[l_ac].* =  g_xmfp2_d[l_ac].*
                  CALL axmt700_xmfq_t_mask()
                  LET g_xmfp2_d_mask_n[l_ac].* =  g_xmfp2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
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
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp2_d_t.xmfqseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfq_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfq_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xmfq_t 
             WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
               AND xmfqseq = g_xmfp2_d[l_ac].xmfqseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp2_d[g_detail_idx].xmfqseq
               CALL axmt700_insert_b('xmfq_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
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
               LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl2
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
               LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmfq_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfq_t SET (xmfqdocno,xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp2_d[l_ac].xmfqseq,g_xmfp2_d[l_ac].xmfq001,g_xmfp2_d[l_ac].xmfq002,g_xmfp2_d[l_ac].xmfq003, 
                   g_xmfp2_d[l_ac].xmfqsite) #自訂欄位頁簽
                WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
                  AND xmfqseq = g_xmfp2_d_t.xmfqseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfq_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp2_d[g_detail_idx].xmfqseq
               LET gs_keys_bak[2] = g_xmfp2_d_t.xmfqseq
               CALL axmt700_update_b('xmfq_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfq_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp2_d[g_detail_idx].xmfqseq = g_xmfp2_d_t.xmfqseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp2_d_t.xmfqseq
                  CALL axmt700_key_update_b(gs_keys,'xmfq_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp2_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq001
            
            #add-point:AFTER FIELD xmfq001 name="input.a.page2.xmfq001"
            LET g_xmfp2_d[l_ac].xmfq001_desc = ''
           
            CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc

            IF NOT cl_null(g_xmfp2_d[l_ac].xmfq001) THEN
               IF NOT s_azzi650_chk_exist('296',g_xmfp2_d[l_ac].xmfq001) THEN
                  LET g_xmfp2_d[l_ac].xmfq001 = g_xmfp2_d_t.xmfq001
                  CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
                  DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc
                  NEXT FIELD CURRENT
               END IF
            LET g_xmfp2_d_t.xmfq001 = g_xmfp2_d[l_ac].xmfq001
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq001
            #add-point:BEFORE FIELD xmfq001 name="input.b.page2.xmfq001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfq001
            #add-point:ON CHANGE xmfq001 name="input.g.page2.xmfq001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq002
            
            #add-point:AFTER FIELD xmfq002 name="input.a.page2.xmfq002"
            LET g_xmfp2_d[l_ac].xmfq002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002_desc
            IF NOT cl_null(g_xmfp2_d[l_ac].xmfq002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp2_d[l_ac].xmfq002 != g_xmfp2_d_o.xmfq002 OR cl_null(g_xmfp2_d_o.xmfq002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp2_d[l_ac].xmfq002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp2_d[l_ac].xmfq003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp2_d[l_ac].xmfq002
                     CALL s_desc_get_department_desc(g_xmfp2_d[l_ac].xmfq003) RETURNING g_xmfp2_d[l_ac].xmfq003_desc
                     DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq003_desc 
                  ELSE
                     LET g_xmfp2_d[l_ac].xmfq002 = g_xmfp2_d_o.xmfq002
                     CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
                     DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002,g_xmfp2_d[l_ac].xmfq002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp2_d_o.xmfq002 = g_xmfp2_d[l_ac].xmfq002 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq002
            #add-point:BEFORE FIELD xmfq002 name="input.b.page2.xmfq002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfq002
            #add-point:ON CHANGE xmfq002 name="input.g.page2.xmfq002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfq003
            
            #add-point:AFTER FIELD xmfq003 name="input.a.page2.xmfq003"
            LET  g_xmfp2_d[l_ac].xmfq003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp2_d[l_ac].xmfq003) RETURNING  g_xmfp2_d[l_ac].xmfq003_desc
            DISPLAY BY NAME  g_xmfp2_d[l_ac].xmfq003_desc 
            IF NOT cl_null( g_xmfp2_d[l_ac].xmfq003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp2_d[l_ac].xmfq003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp2_d[l_ac].xmfq003 =  g_xmfp2_d_o.xmfq003
                  CALL s_desc_get_department_desc( g_xmfp2_d[l_ac].xmfq003) RETURNING  g_xmfp2_d[l_ac].xmfq003_desc
                  DISPLAY BY NAME  g_xmfp2_d[l_ac].xmfq003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp2_d_o.xmfq003 =  g_xmfp2_d[l_ac].xmfq003               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfq003
            #add-point:BEFORE FIELD xmfq003 name="input.b.page2.xmfq003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfq003
            #add-point:ON CHANGE xmfq003 name="input.g.page2.xmfq003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfqsite
            #add-point:BEFORE FIELD xmfqsite name="input.b.page2.xmfqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfqsite
            
            #add-point:AFTER FIELD xmfqsite name="input.a.page2.xmfqsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfqsite
            #add-point:ON CHANGE xmfqsite name="input.g.page2.xmfqsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xmfq001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq001
            #add-point:ON ACTION controlp INFIELD xmfq001 name="input.c.page2.xmfq001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq001
            LET g_qryparam.arg1 = "296"
            CALL q_oocq002()                                 
            LET g_xmfp2_d[l_ac].xmfq001 = g_qryparam.return1 
            DISPLAY g_xmfp2_d[l_ac].xmfq001 TO xmfq001              
            CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc
            NEXT FIELD xmfq001                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq002
            #add-point:ON ACTION controlp INFIELD xmfq002 name="input.c.page2.xmfq002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq002
            CALL q_ooag001()                            
            LET g_xmfp2_d[l_ac].xmfq002 = g_qryparam.return1            
            DISPLAY g_xmfp2_d[l_ac].xmfq002 TO xmfq002              
            NEXT FIELD xmfq002                          
            CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002_desc   

            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfq003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfq003
            #add-point:ON ACTION controlp INFIELD xmfq003 name="input.c.page2.xmfq003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                              
            LET g_xmfp2_d[l_ac].xmfq003 = g_qryparam.return1              
            DISPLAY g_xmfp2_d[l_ac].xmfq003 TO xmfq003              
            NEXT FIELD xmfq003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp2_d[l_ac].xmfq003) RETURNING g_xmfp2_d[l_ac].xmfq003_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq003_desc 

            #END add-point
 
 
         #Ctrlp:input.c.page2.xmfqsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfqsite
            #add-point:ON ACTION controlp INFIELD xmfqsite name="input.c.page2.xmfqsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfq_t","'2'")
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
               LET g_xmfp2_d[li_reproduce_target].* = g_xmfp2_d[li_reproduce].*
 
               LET g_xmfp2_d[li_reproduce_target].xmfqseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp2_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xmfp3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp3_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp3_d_t.* TO NULL 
            INITIALIZE g_xmfp3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_xmfp3_d_t.* = g_xmfp3_d[l_ac].*     #新輸入資料
            LET g_xmfp3_d_o.* = g_xmfp3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp3_d[li_reproduce_target].* = g_xmfp3_d[li_reproduce].*
 
               LET g_xmfp3_d[li_reproduce_target].xmfrseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            #項次加1
            SELECT MAX(xmfrseq)+1 INTO g_xmfp3_d[l_ac].xmfrseq FROM xmfr_t
             WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp3_d[l_ac].xmfrseq) OR g_xmfp3_d[l_ac].xmfrseq = 0 THEN
               LET g_xmfp3_d[l_ac].xmfrseq = 1
            END IF
            LET g_xmfp3_d[l_ac].xmfrsite = g_xmfo_m.xmfosite
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
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp3_d[l_ac].xmfrseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp3_d_t.* = g_xmfp3_d[l_ac].*  #BACKUP
               LET g_xmfp3_d_o.* = g_xmfp3_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfr_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl3 INTO g_xmfp3_d[l_ac].xmfrseq,g_xmfp3_d[l_ac].xmfr001,g_xmfp3_d[l_ac].xmfr002, 
                      g_xmfp3_d[l_ac].xmfr003,g_xmfp3_d[l_ac].xmfrsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp3_d_mask_o[l_ac].* =  g_xmfp3_d[l_ac].*
                  CALL axmt700_xmfr_t_mask()
                  LET g_xmfp3_d_mask_n[l_ac].* =  g_xmfp3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
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
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp3_d_t.xmfrseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfr_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp3_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xmfr_t 
             WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
               AND xmfrseq = g_xmfp3_d[l_ac].xmfrseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp3_d[g_detail_idx].xmfrseq
               CALL axmt700_insert_b('xmfr_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
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
               LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl3
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
               LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmfr_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfr_t SET (xmfrdocno,xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp3_d[l_ac].xmfrseq,g_xmfp3_d[l_ac].xmfr001,g_xmfp3_d[l_ac].xmfr002,g_xmfp3_d[l_ac].xmfr003, 
                   g_xmfp3_d[l_ac].xmfrsite) #自訂欄位頁簽
                WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
                  AND xmfrseq = g_xmfp3_d_t.xmfrseq #項次 
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfr_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp3_d[g_detail_idx].xmfrseq
               LET gs_keys_bak[2] = g_xmfp3_d_t.xmfrseq
               CALL axmt700_update_b('xmfr_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp3_d[g_detail_idx].xmfrseq = g_xmfp3_d_t.xmfrseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp3_d_t.xmfrseq
                  CALL axmt700_key_update_b(gs_keys,'xmfr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp3_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr001
            #add-point:BEFORE FIELD xmfr001 name="input.b.page3.xmfr001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr001
            
            #add-point:AFTER FIELD xmfr001 name="input.a.page3.xmfr001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfr001
            #add-point:ON CHANGE xmfr001 name="input.g.page3.xmfr001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr002
            
            #add-point:AFTER FIELD xmfr002 name="input.a.page3.xmfr002"
            LET g_xmfp3_d[l_ac].xmfr002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002_desc
            IF NOT cl_null(g_xmfp3_d[l_ac].xmfr002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp3_d[l_ac].xmfr002 != g_xmfp3_d_o.xmfr002 OR cl_null(g_xmfp3_d_o.xmfr002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp3_d[l_ac].xmfr002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp3_d[l_ac].xmfr003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp3_d[l_ac].xmfr002
                     CALL s_desc_get_department_desc(g_xmfp3_d[l_ac].xmfr003) RETURNING g_xmfp3_d[l_ac].xmfr003_desc
                     DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr003_desc 
                  ELSE
                     LET g_xmfp3_d[l_ac].xmfr002 = g_xmfp3_d_o.xmfr002
                     CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
                     DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002,g_xmfp3_d[l_ac].xmfr002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp3_d_o.xmfr002 = g_xmfp3_d[l_ac].xmfr002 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr002
            #add-point:BEFORE FIELD xmfr002 name="input.b.page3.xmfr002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfr002
            #add-point:ON CHANGE xmfr002 name="input.g.page3.xmfr002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfr003
            
            #add-point:AFTER FIELD xmfr003 name="input.a.page3.xmfr003"
            LET  g_xmfp3_d[l_ac].xmfr003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp3_d[l_ac].xmfr003) RETURNING  g_xmfp3_d[l_ac].xmfr003_desc
            DISPLAY BY NAME  g_xmfp3_d[l_ac].xmfr003_desc 
            IF NOT cl_null( g_xmfp3_d[l_ac].xmfr003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp3_d[l_ac].xmfr003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp3_d[l_ac].xmfr003 =  g_xmfp3_d_o.xmfr003
                  CALL s_desc_get_department_desc( g_xmfp3_d[l_ac].xmfr003) RETURNING  g_xmfp3_d[l_ac].xmfr003_desc
                  DISPLAY BY NAME  g_xmfp3_d[l_ac].xmfr003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp3_d_o.xmfr003 =  g_xmfp3_d[l_ac].xmfr003               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfr003
            #add-point:BEFORE FIELD xmfr003 name="input.b.page3.xmfr003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfr003
            #add-point:ON CHANGE xmfr003 name="input.g.page3.xmfr003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfrsite
            #add-point:BEFORE FIELD xmfrsite name="input.b.page3.xmfrsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfrsite
            
            #add-point:AFTER FIELD xmfrsite name="input.a.page3.xmfrsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfrsite
            #add-point:ON CHANGE xmfrsite name="input.g.page3.xmfrsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.xmfr001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr001
            #add-point:ON ACTION controlp INFIELD xmfr001 name="input.c.page3.xmfr001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.xmfr002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr002
            #add-point:ON ACTION controlp INFIELD xmfr002 name="input.c.page3.xmfr002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp3_d[l_ac].xmfr002             
            CALL q_ooag001()                              
            LET g_xmfp3_d[l_ac].xmfr002 = g_qryparam.return1          
            DISPLAY g_xmfp3_d[l_ac].xmfr002 TO xmfr002    
            NEXT FIELD xmfr002                        
            CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002_desc    

            #END add-point
 
 
         #Ctrlp:input.c.page3.xmfr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfr003
            #add-point:ON ACTION controlp INFIELD xmfr003 name="input.c.page3.xmfr003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp3_d[l_ac].xmfr003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                                #呼叫開窗
            LET g_xmfp3_d[l_ac].xmfr003 = g_qryparam.return1              
            DISPLAY g_xmfp3_d[l_ac].xmfr003 TO xmfr003              #
            NEXT FIELD xmfr003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp3_d[l_ac].xmfr003) RETURNING g_xmfp3_d[l_ac].xmfr003_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr003_desc 

            #END add-point
 
 
         #Ctrlp:input.c.page3.xmfrsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfrsite
            #add-point:ON ACTION controlp INFIELD xmfrsite name="input.c.page3.xmfrsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfr_t","'3'")
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
               LET g_xmfp3_d[li_reproduce_target].* = g_xmfp3_d[li_reproduce].*
 
               LET g_xmfp3_d[li_reproduce_target].xmfrseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xmfp4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_4)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp4_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp4_d_t.* TO NULL 
            INITIALIZE g_xmfp4_d_o.* TO NULL 
            #公用欄位給值(單身4)
            
            #自定義預設值(單身4)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_xmfp4_d_t.* = g_xmfp4_d[l_ac].*     #新輸入資料
            LET g_xmfp4_d_o.* = g_xmfp4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp4_d[li_reproduce_target].* = g_xmfp4_d[li_reproduce].*
 
               LET g_xmfp4_d[li_reproduce_target].xmfsseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            #項次加1
            SELECT MAX(xmfsseq)+1 INTO g_xmfp4_d[l_ac].xmfsseq FROM xmfs_t
             WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp4_d[l_ac].xmfsseq) OR g_xmfp4_d[l_ac].xmfsseq = 0 THEN
               LET g_xmfp4_d[l_ac].xmfsseq = 1
            END IF
            LET g_xmfp4_d[l_ac].xmfssite = g_xmfo_m.xmfosite
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
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp4_d[l_ac].xmfsseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp4_d_t.* = g_xmfp4_d[l_ac].*  #BACKUP
               LET g_xmfp4_d_o.* = g_xmfp4_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfs_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl4 INTO g_xmfp4_d[l_ac].xmfsseq,g_xmfp4_d[l_ac].xmfs001,g_xmfp4_d[l_ac].xmfs002, 
                      g_xmfp4_d[l_ac].xmfs003,g_xmfp4_d[l_ac].xmfssite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp4_d_mask_o[l_ac].* =  g_xmfp4_d[l_ac].*
                  CALL axmt700_xmfs_t_mask()
                  LET g_xmfp4_d_mask_n[l_ac].* =  g_xmfp4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
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
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp4_d_t.xmfsseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfs_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身4刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身4刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp4_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM xmfs_t 
             WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
               AND xmfsseq = g_xmfp4_d[l_ac].xmfsseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身4新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp4_d[g_detail_idx].xmfsseq
               CALL axmt700_insert_b('xmfs_t',gs_keys,"'4'")
                           
               #add-point:單身新增後4 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
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
               LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl4
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
               LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
            ELSE
               #add-point:單身page4修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身4)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmfs_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfs_t SET (xmfsdocno,xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp4_d[l_ac].xmfsseq,g_xmfp4_d[l_ac].xmfs001,g_xmfp4_d[l_ac].xmfs002,g_xmfp4_d[l_ac].xmfs003, 
                   g_xmfp4_d[l_ac].xmfssite) #自訂欄位頁簽
                WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
                  AND xmfsseq = g_xmfp4_d_t.xmfsseq #項次 
                  
               #add-point:單身page4修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfs_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp4_d[g_detail_idx].xmfsseq
               LET gs_keys_bak[2] = g_xmfp4_d_t.xmfsseq
               CALL axmt700_update_b('xmfs_t',gs_keys,gs_keys_bak,"'4'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp4_d[g_detail_idx].xmfsseq = g_xmfp4_d_t.xmfsseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp4_d_t.xmfsseq
                  CALL axmt700_key_update_b(gs_keys,'xmfs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp4_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page4修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs001
            #add-point:BEFORE FIELD xmfs001 name="input.b.page4.xmfs001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs001
            
            #add-point:AFTER FIELD xmfs001 name="input.a.page4.xmfs001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfs001
            #add-point:ON CHANGE xmfs001 name="input.g.page4.xmfs001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs002
            
            #add-point:AFTER FIELD xmfs002 name="input.a.page4.xmfs002"
            LET g_xmfp4_d[l_ac].xmfs002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002_desc
            IF NOT cl_null(g_xmfp4_d[l_ac].xmfs002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp4_d[l_ac].xmfs002 != g_xmfp4_d_o.xmfs002 OR cl_null(g_xmfp4_d_o.xmfs002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp4_d[l_ac].xmfs002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp4_d[l_ac].xmfs003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp4_d[l_ac].xmfs002
                     CALL s_desc_get_department_desc(g_xmfp4_d[l_ac].xmfs003) RETURNING g_xmfp4_d[l_ac].xmfs003_desc
                     DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs003_desc 
                  ELSE
                     LET g_xmfp4_d[l_ac].xmfs002 = g_xmfp4_d_o.xmfs002
                     CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
                     DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002,g_xmfp4_d[l_ac].xmfs002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp4_d_o.xmfs002 = g_xmfp4_d[l_ac].xmfs002 
            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs002
            #add-point:BEFORE FIELD xmfs002 name="input.b.page4.xmfs002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfs002
            #add-point:ON CHANGE xmfs002 name="input.g.page4.xmfs002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfs003
            
            #add-point:AFTER FIELD xmfs003 name="input.a.page4.xmfs003"
            LET  g_xmfp4_d[l_ac].xmfs003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp4_d[l_ac].xmfs003) RETURNING  g_xmfp4_d[l_ac].xmfs003_desc
            DISPLAY BY NAME  g_xmfp4_d[l_ac].xmfs003_desc 
            IF NOT cl_null( g_xmfp4_d[l_ac].xmfs003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp4_d[l_ac].xmfs003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp4_d[l_ac].xmfs003 =  g_xmfp4_d_o.xmfs003
                  CALL s_desc_get_department_desc( g_xmfp4_d[l_ac].xmfs003) RETURNING  g_xmfp4_d[l_ac].xmfs003_desc
                  DISPLAY BY NAME  g_xmfp4_d[l_ac].xmfs003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp4_d_o.xmfs003 =  g_xmfp4_d[l_ac].xmfs003               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfs003
            #add-point:BEFORE FIELD xmfs003 name="input.b.page4.xmfs003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfs003
            #add-point:ON CHANGE xmfs003 name="input.g.page4.xmfs003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfssite
            #add-point:BEFORE FIELD xmfssite name="input.b.page4.xmfssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfssite
            
            #add-point:AFTER FIELD xmfssite name="input.a.page4.xmfssite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfssite
            #add-point:ON CHANGE xmfssite name="input.g.page4.xmfssite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.xmfs001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs001
            #add-point:ON ACTION controlp INFIELD xmfs001 name="input.c.page4.xmfs001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.xmfs002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs002
            #add-point:ON ACTION controlp INFIELD xmfs002 name="input.c.page4.xmfs002"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp4_d[l_ac].xmfs002           
            CALL q_ooag001()                               
            LET g_xmfp4_d[l_ac].xmfs002 = g_qryparam.return1              
            DISPLAY g_xmfp4_d[l_ac].xmfs002 TO xmfs002           
            NEXT FIELD xmfs002                          
            CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002_desc    

            #END add-point
 
 
         #Ctrlp:input.c.page4.xmfs003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfs003
            #add-point:ON ACTION controlp INFIELD xmfs003 name="input.c.page4.xmfs003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp4_d[l_ac].xmfs003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                              
            LET g_xmfp4_d[l_ac].xmfs003 = g_qryparam.return1              
            DISPLAY g_xmfp4_d[l_ac].xmfs003 TO xmfs003             
            NEXT FIELD xmfs003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp4_d[l_ac].xmfs003) RETURNING g_xmfp4_d[l_ac].xmfs003_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs003_desc 

            #END add-point
 
 
         #Ctrlp:input.c.page4.xmfssite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfssite
            #add-point:ON ACTION controlp INFIELD xmfssite name="input.c.page4.xmfssite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page4 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl4
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfs_t","'4'")
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
               LET g_xmfp4_d[li_reproduce_target].* = g_xmfp4_d[li_reproduce].*
 
               LET g_xmfp4_d[li_reproduce_target].xmfsseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp4_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xmfp5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_5)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body5.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp5_d.getLength()
            #add-point:資料輸入前 name="input.body5.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp5_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp5_d_t.* TO NULL 
            INITIALIZE g_xmfp5_d_o.* TO NULL 
            #公用欄位給值(單身5)
            
            #自定義預設值(單身5)
            
            #add-point:modify段before備份 name="input.body5.insert.before_bak"
            
            #end add-point
            LET g_xmfp5_d_t.* = g_xmfp5_d[l_ac].*     #新輸入資料
            LET g_xmfp5_d_o.* = g_xmfp5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body5.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp5_d[li_reproduce_target].* = g_xmfp5_d[li_reproduce].*
 
               LET g_xmfp5_d[li_reproduce_target].xmftseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body5.before_insert"
            #項次加1
            SELECT MAX(xmftseq)+1 INTO g_xmfp5_d[l_ac].xmftseq FROM xmft_t
             WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp5_d[l_ac].xmftseq) OR g_xmfp5_d[l_ac].xmftseq = 0 THEN
               LET g_xmfp5_d[l_ac].xmftseq = 1
            END IF
            LET g_xmfp5_d[l_ac].xmftsite = g_xmfo_m.xmfosite
            LET g_xmfp5_d[l_ac].xmft002 = g_user
            CALL s_desc_get_person_desc(g_xmfp5_d[l_ac].xmft002) RETURNING g_xmfp5_d[l_ac].xmft002_desc
            DISPLAY BY NAME g_xmfp5_d[l_ac].xmft002_desc
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body5.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[5] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp5_d[l_ac].xmftseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp5_d_t.* = g_xmfp5_d[l_ac].*  #BACKUP
               LET g_xmfp5_d_o.* = g_xmfp5_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body5.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmft_t","'5'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl5 INTO g_xmfp5_d[l_ac].xmftseq,g_xmfp5_d[l_ac].xmft001,g_xmfp5_d[l_ac].xmft002, 
                      g_xmfp5_d[l_ac].xmftsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp5_d_mask_o[l_ac].* =  g_xmfp5_d[l_ac].*
                  CALL axmt700_xmft_t_mask()
                  LET g_xmfp5_d_mask_n[l_ac].* =  g_xmfp5_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body5.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body5.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body5.b_delete_ask"
               
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
               
               #add-point:單身5刪除前 name="input.body5.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp5_d_t.xmftseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmft_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmft_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身5刪除中 name="input.body5.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身5刪除後 name="input.body5.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body5.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp5_d.getLength() + 1) THEN
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
               
            #add-point:單身5新增前 name="input.body5.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmft_t 
             WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
               AND xmftseq = g_xmfp5_d[l_ac].xmftseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身5新增前 name="input.body5.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp5_d[g_detail_idx].xmftseq
               CALL axmt700_insert_b('xmft_t',gs_keys,"'5'")
                           
               #add-point:單身新增後5 name="input.body5.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body5.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl5
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
               LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
            ELSE
               #add-point:單身page5修改前 name="input.body5.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身5)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmft_t_mask_restore('restore_mask_o')
                              
               UPDATE xmft_t SET (xmftdocno,xmftseq,xmft001,xmft002,xmftsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp5_d[l_ac].xmftseq,g_xmfp5_d[l_ac].xmft001,g_xmfp5_d[l_ac].xmft002,g_xmfp5_d[l_ac].xmftsite)  
                   #自訂欄位頁簽
                WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
                  AND xmftseq = g_xmfp5_d_t.xmftseq #項次 
                  
               #add-point:單身page5修改中 name="input.body5.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmft_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp5_d[g_detail_idx].xmftseq
               LET gs_keys_bak[2] = g_xmfp5_d_t.xmftseq
               CALL axmt700_update_b('xmft_t',gs_keys,gs_keys_bak,"'5'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmft_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp5_d[g_detail_idx].xmftseq = g_xmfp5_d_t.xmftseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp5_d_t.xmftseq
                  CALL axmt700_key_update_b(gs_keys,'xmft_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp5_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page5修改後 name="input.body5.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmft001
            #add-point:BEFORE FIELD xmft001 name="input.b.page5.xmft001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmft001
            
            #add-point:AFTER FIELD xmft001 name="input.a.page5.xmft001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmft001
            #add-point:ON CHANGE xmft001 name="input.g.page5.xmft001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmftsite
            #add-point:BEFORE FIELD xmftsite name="input.b.page5.xmftsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmftsite
            
            #add-point:AFTER FIELD xmftsite name="input.a.page5.xmftsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmftsite
            #add-point:ON CHANGE xmftsite name="input.g.page5.xmftsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page5.xmft001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmft001
            #add-point:ON ACTION controlp INFIELD xmft001 name="input.c.page5.xmft001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page5.xmftsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmftsite
            #add-point:ON ACTION controlp INFIELD xmftsite name="input.c.page5.xmftsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page5 after_row name="input.body5.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl5
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmft_t","'5'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page5 after_row2 name="input.body5.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body5.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp5_d[li_reproduce_target].* = g_xmfp5_d[li_reproduce].*
 
               LET g_xmfp5_d[li_reproduce_target].xmftseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp5_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xmfp6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_6)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body6.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp6_d.getLength()
            #add-point:資料輸入前 name="input.body6.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp6_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp6_d_t.* TO NULL 
            INITIALIZE g_xmfp6_d_o.* TO NULL 
            #公用欄位給值(單身6)
            
            #自定義預設值(單身6)
            
            #add-point:modify段before備份 name="input.body6.insert.before_bak"
            
            #end add-point
            LET g_xmfp6_d_t.* = g_xmfp6_d[l_ac].*     #新輸入資料
            LET g_xmfp6_d_o.* = g_xmfp6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body6.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp6_d[li_reproduce_target].* = g_xmfp6_d[li_reproduce].*
 
               LET g_xmfp6_d[li_reproduce_target].xmfuseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body6.before_insert"
            #項次加1
            SELECT MAX(xmfuseq)+1 INTO g_xmfp6_d[l_ac].xmfuseq FROM xmfu_t
             WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp6_d[l_ac].xmfuseq) OR g_xmfp6_d[l_ac].xmfuseq = 0 THEN
               LET g_xmfp6_d[l_ac].xmfuseq = 1
            END IF
            LET g_xmfp6_d[l_ac].xmfusite = g_xmfo_m.xmfosite
            LET g_xmfp6_d[l_ac].xmfu002 = g_user
            CALL s_desc_get_person_desc(g_xmfp6_d[l_ac].xmfu002) RETURNING g_xmfp6_d[l_ac].xmfu002_desc
            DISPLAY BY NAME g_xmfp6_d[l_ac].xmfu002_desc            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body6.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[6] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 6
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp6_d[l_ac].xmfuseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp6_d_t.* = g_xmfp6_d[l_ac].*  #BACKUP
               LET g_xmfp6_d_o.* = g_xmfp6_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body6.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfu_t","'6'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl6 INTO g_xmfp6_d[l_ac].xmfuseq,g_xmfp6_d[l_ac].xmfu001,g_xmfp6_d[l_ac].xmfu002, 
                      g_xmfp6_d[l_ac].xmfusite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp6_d_mask_o[l_ac].* =  g_xmfp6_d[l_ac].*
                  CALL axmt700_xmfu_t_mask()
                  LET g_xmfp6_d_mask_n[l_ac].* =  g_xmfp6_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body6.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body6.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body6.b_delete_ask"
               
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
               
               #add-point:單身6刪除前 name="input.body6.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp6_d_t.xmfuseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfu_t',gs_keys,"'6'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfu_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身6刪除中 name="input.body6.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身6刪除後 name="input.body6.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body6.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp6_d.getLength() + 1) THEN
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
               
            #add-point:單身6新增前 name="input.body6.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmfu_t 
             WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
               AND xmfuseq = g_xmfp6_d[l_ac].xmfuseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身6新增前 name="input.body6.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp6_d[g_detail_idx].xmfuseq
               CALL axmt700_insert_b('xmfu_t',gs_keys,"'6'")
                           
               #add-point:單身新增後6 name="input.body6.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body6.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl6
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
               LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
            ELSE
               #add-point:單身page6修改前 name="input.body6.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身6)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmfu_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfu_t SET (xmfudocno,xmfuseq,xmfu001,xmfu002,xmfusite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp6_d[l_ac].xmfuseq,g_xmfp6_d[l_ac].xmfu001,g_xmfp6_d[l_ac].xmfu002,g_xmfp6_d[l_ac].xmfusite)  
                   #自訂欄位頁簽
                WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
                  AND xmfuseq = g_xmfp6_d_t.xmfuseq #項次 
                  
               #add-point:單身page6修改中 name="input.body6.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfu_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp6_d[g_detail_idx].xmfuseq
               LET gs_keys_bak[2] = g_xmfp6_d_t.xmfuseq
               CALL axmt700_update_b('xmfu_t',gs_keys,gs_keys_bak,"'6'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfu_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp6_d[g_detail_idx].xmfuseq = g_xmfp6_d_t.xmfuseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp6_d_t.xmfuseq
                  CALL axmt700_key_update_b(gs_keys,'xmfu_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp6_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp6_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page6修改後 name="input.body6.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfu001
            #add-point:BEFORE FIELD xmfu001 name="input.b.page6.xmfu001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfu001
            
            #add-point:AFTER FIELD xmfu001 name="input.a.page6.xmfu001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfu001
            #add-point:ON CHANGE xmfu001 name="input.g.page6.xmfu001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfusite
            #add-point:BEFORE FIELD xmfusite name="input.b.page6.xmfusite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfusite
            
            #add-point:AFTER FIELD xmfusite name="input.a.page6.xmfusite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfusite
            #add-point:ON CHANGE xmfusite name="input.g.page6.xmfusite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page6.xmfu001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfu001
            #add-point:ON ACTION controlp INFIELD xmfu001 name="input.c.page6.xmfu001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page6.xmfusite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfusite
            #add-point:ON ACTION controlp INFIELD xmfusite name="input.c.page6.xmfusite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page6 after_row name="input.body6.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl6
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfu_t","'6'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page6 after_row2 name="input.body6.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body6.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp6_d[li_reproduce_target].* = g_xmfp6_d[li_reproduce].*
 
               LET g_xmfp6_d[li_reproduce_target].xmfuseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp6_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp6_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_xmfp7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_7)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body7.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp7_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp7_d.getLength()
            #add-point:資料輸入前 name="input.body7.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp7_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp7_d_t.* TO NULL 
            INITIALIZE g_xmfp7_d_o.* TO NULL 
            #公用欄位給值(單身7)
            
            #自定義預設值(單身7)
            
            #add-point:modify段before備份 name="input.body7.insert.before_bak"
            
            #end add-point
            LET g_xmfp7_d_t.* = g_xmfp7_d[l_ac].*     #新輸入資料
            LET g_xmfp7_d_o.* = g_xmfp7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body7.insert.after_set_entry_b"
            
            #end add-point
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp7_d[li_reproduce_target].* = g_xmfp7_d[li_reproduce].*
 
               LET g_xmfp7_d[li_reproduce_target].xmfvseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body7.before_insert"
            #項次加1
            SELECT MAX(xmfvseq)+1 INTO g_xmfp7_d[l_ac].xmfvseq FROM xmfv_t
             WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp7_d[l_ac].xmfvseq) OR g_xmfp7_d[l_ac].xmfvseq = 0 THEN
               LET g_xmfp7_d[l_ac].xmfvseq = 1
            END IF
            LET g_xmfp7_d[l_ac].xmfvsite = g_xmfo_m.xmfosite
            LET g_xmfp7_d[l_ac].xmfv002 = g_user
            CALL s_desc_get_person_desc(g_xmfp7_d[l_ac].xmfv002) RETURNING g_xmfp7_d[l_ac].xmfv002_desc
            DISPLAY BY NAME g_xmfp7_d[l_ac].xmfv002_desc 
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body7.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[7] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 7
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE axmt700_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_xmfp7_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp7_d[l_ac].xmfvseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp7_d_t.* = g_xmfp7_d[l_ac].*  #BACKUP
               LET g_xmfp7_d_o.* = g_xmfp7_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body7.after_set_entry_b"
               
               #end add-point  
               CALL axmt700_set_no_entry_b(l_cmd)
               IF NOT axmt700_lock_b("xmfv_t","'7'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl7 INTO g_xmfp7_d[l_ac].xmfvseq,g_xmfp7_d[l_ac].xmfv001,g_xmfp7_d[l_ac].xmfv002, 
                      g_xmfp7_d[l_ac].xmfvsite
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp7_d_mask_o[l_ac].* =  g_xmfp7_d[l_ac].*
                  CALL axmt700_xmfv_t_mask()
                  LET g_xmfp7_d_mask_n[l_ac].* =  g_xmfp7_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body7.before_row"
            
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body7.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body7.b_delete_ask"
               
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
               
               #add-point:單身7刪除前 name="input.body7.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp7_d_t.xmfvseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfv_t',gs_keys,"'7'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfv_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身7刪除中 name="input.body7.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身7刪除後 name="input.body7.a_delete"
               
               #end add-point
               LET l_count = g_xmfp_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body7.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp7_d.getLength() + 1) THEN
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
               
            #add-point:單身7新增前 name="input.body7.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM xmfv_t 
             WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
               AND xmfvseq = g_xmfp7_d[l_ac].xmfvseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身7新增前 name="input.body7.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp7_d[g_detail_idx].xmfvseq
               CALL axmt700_insert_b('xmfv_t',gs_keys,"'7'")
                           
               #add-point:單身新增後7 name="input.body7.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body7.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl7
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
               LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
            ELSE
               #add-point:單身page7修改前 name="input.body7.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身7)
               
               
               #將遮罩欄位還原
               CALL axmt700_xmfv_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfv_t SET (xmfvdocno,xmfvseq,xmfv001,xmfv002,xmfvsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp7_d[l_ac].xmfvseq,g_xmfp7_d[l_ac].xmfv001,g_xmfp7_d[l_ac].xmfv002,g_xmfp7_d[l_ac].xmfvsite)  
                   #自訂欄位頁簽
                WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
                  AND xmfvseq = g_xmfp7_d_t.xmfvseq #項次 
                  
               #add-point:單身page7修改中 name="input.body7.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfv_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys_bak[1] = g_xmfodocno_t
               LET gs_keys[2] = g_xmfp7_d[g_detail_idx].xmfvseq
               LET gs_keys_bak[2] = g_xmfp7_d_t.xmfvseq
               CALL axmt700_update_b('xmfv_t',gs_keys,gs_keys_bak,"'7'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfv_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp7_d[g_detail_idx].xmfvseq = g_xmfp7_d_t.xmfvseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp7_d_t.xmfvseq
                  CALL axmt700_key_update_b(gs_keys,'xmfv_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp7_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp7_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page7修改後 name="input.body7.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfv001
            #add-point:BEFORE FIELD xmfv001 name="input.b.page7.xmfv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfv001
            
            #add-point:AFTER FIELD xmfv001 name="input.a.page7.xmfv001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfv001
            #add-point:ON CHANGE xmfv001 name="input.g.page7.xmfv001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfvsite
            #add-point:BEFORE FIELD xmfvsite name="input.b.page7.xmfvsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfvsite
            
            #add-point:AFTER FIELD xmfvsite name="input.a.page7.xmfvsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfvsite
            #add-point:ON CHANGE xmfvsite name="input.g.page7.xmfvsite"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page7.xmfv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfv001
            #add-point:ON ACTION controlp INFIELD xmfv001 name="input.c.page7.xmfv001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page7.xmfvsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfvsite
            #add-point:ON ACTION controlp INFIELD xmfvsite name="input.c.page7.xmfvsite"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page7 after_row name="input.body7.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE axmt700_bcl7
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfv_t","'7'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page7 after_row2 name="input.body7.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body7.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp7_d[li_reproduce_target].* = g_xmfp7_d[li_reproduce].*
 
               LET g_xmfp7_d[li_reproduce_target].xmfvseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp7_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp7_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="axmt700.input.other" >}
      
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
         CALL DIALOG.setCurrentRow("s_detail5",g_idx_group.getValue("'5',"))
         CALL DIALOG.setCurrentRow("s_detail6",g_idx_group.getValue("'6',"))
         CALL DIALOG.setCurrentRow("s_detail7",g_idx_group.getValue("'7',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD xmfodocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xmfpseq
               WHEN "s_detail2"
                  NEXT FIELD xmfqseq
               WHEN "s_detail3"
                  NEXT FIELD xmfrseq
               WHEN "s_detail4"
                  NEXT FIELD xmfsseq
               WHEN "s_detail5"
                  NEXT FIELD xmftseq
               WHEN "s_detail6"
                  NEXT FIELD xmfuseq
               WHEN "s_detail7"
                  NEXT FIELD xmfvseq
 
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
         LET g_detail_idx_list[7] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
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
         LET g_detail_idx_list[7] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
         CALL g_curr_diag.setCurrentRow("s_detail5",1)
         CALL g_curr_diag.setCurrentRow("s_detail6",1)
         CALL g_curr_diag.setCurrentRow("s_detail7",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axmt700_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_pmak003  LIKE pmak_t.pmak003   #一次性交易對象名稱   #161207-00033#18 add
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL axmt700_b_fill() #單身填充
      CALL axmt700_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axmt700_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #161207-00033#18-s add
   IF NOT cl_null(g_xmfo_m.xmfo006) OR NOT cl_null(g_xmfo_m.xmfo008) THEN
      #一次性交易對象全名
      CALL s_desc_axm_get_oneturn_guest_desc('3',g_xmfo_m.xmfo006)
           RETURNING l_pmak003
      
      IF NOT cl_null(l_pmak003) THEN
         LET g_xmfo_m.xmfo005_desc = l_pmak003
      END IF
   END IF 
   #161207-00033#18-e add     
   #end add-point
   
   #遮罩相關處理
   LET g_xmfo_m_mask_o.* =  g_xmfo_m.*
   CALL axmt700_xmfo_t_mask()
   LET g_xmfo_m_mask_n.* =  g_xmfo_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocno_desc,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002, 
       g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfostus, 
       g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo012_desc, 
       g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013, 
       g_xmfo_m.xmfo013_desc,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoownid_desc, 
       g_xmfo_m.xmfoowndp,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfomoddt, 
       g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfid_desc,g_xmfo_m.xmfocnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfo_m.xmfostus 
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xmfp_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xmfp2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmfp3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmfp4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmfp5_d.getLength()
      #add-point:show段單身reference name="show.body5.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmfp6_d.getLength()
      #add-point:show段單身reference name="show.body6.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xmfp7_d.getLength()
      #add-point:show段單身reference name="show.body7.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL axmt700_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION axmt700_detail_show()
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
 
{<section id="axmt700.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axmt700_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE xmfo_t.xmfodocno 
   DEFINE l_oldno     LIKE xmfo_t.xmfodocno 
 
   DEFINE l_master    RECORD LIKE xmfo_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xmfp_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmfq_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xmfr_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE xmfs_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE xmft_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE xmfu_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE xmfv_t.* #此變數樣板目前無使用
 
 
 
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
   
   IF g_xmfo_m.xmfodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
    
   LET g_xmfo_m.xmfodocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_xmfo_m.xmfoownid = g_user
      LET g_xmfo_m.xmfoowndp = g_dept
      LET g_xmfo_m.xmfocrtid = g_user
      LET g_xmfo_m.xmfocrtdp = g_dept 
      LET g_xmfo_m.xmfocrtdt = cl_get_current()
      LET g_xmfo_m.xmfomodid = g_user
      LET g_xmfo_m.xmfomoddt = cl_get_current()
      LET g_xmfo_m.xmfostus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_xmfo_m.xmfostus = 'N'
   LET g_xmfo_m.xmfo017 = ''
   LET g_xmfo_m.xmfo001 = g_today
   LET g_xmfo_m.xmfo002 = g_today
   LET g_xmfo_m.xmfo003 = g_user
   LET g_xmfo_m.xmfo004 = g_dept
   LET g_xmfo_m.xmfodocdt = g_today
   LET g_xmfo_m.xmfocnfid = ""
   LET g_xmfo_m.xmfocnfdt = ""
   CALL g_xmfp3_d.clear()
   CALL g_xmfp4_d.clear()
   CALL g_xmfp5_d.clear()
   CALL g_xmfp6_d.clear()
   CALL g_xmfp7_d.clear()   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_xmfo_m.xmfostus 
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_xmfo_m.xmfodocno_desc = ''
   DISPLAY BY NAME g_xmfo_m.xmfodocno_desc
 
   
   CALL axmt700_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_xmfo_m.* TO NULL
      INITIALIZE g_xmfp_d TO NULL
      INITIALIZE g_xmfp2_d TO NULL
      INITIALIZE g_xmfp3_d TO NULL
      INITIALIZE g_xmfp4_d TO NULL
      INITIALIZE g_xmfp5_d TO NULL
      INITIALIZE g_xmfp6_d TO NULL
      INITIALIZE g_xmfp7_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL axmt700_show()
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
   CALL axmt700_set_act_visible()   
   CALL axmt700_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " xmfoent = " ||g_enterprise|| " AND",
                      " xmfodocno = '", g_xmfo_m.xmfodocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axmt700_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL axmt700_idx_chk()
   
   LET g_data_owner = g_xmfo_m.xmfoownid      
   LET g_data_dept  = g_xmfo_m.xmfoowndp
   
   #功能已完成,通報訊息中心
   CALL axmt700_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axmt700_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xmfp_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE xmfq_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE xmfr_t.* #此變數樣板目前無使用
 
   DEFINE l_detail4    RECORD LIKE xmfs_t.* #此變數樣板目前無使用
 
   DEFINE l_detail5    RECORD LIKE xmft_t.* #此變數樣板目前無使用
 
   DEFINE l_detail6    RECORD LIKE xmfu_t.* #此變數樣板目前無使用
 
   DEFINE l_detail7    RECORD LIKE xmfv_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axmt700_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfp_t
    WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail 
      #更新key欄位
      SET xmfpdocno = g_xmfo_m.xmfodocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO xmfp_t SELECT * FROM axmt700_detail
   
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
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfq_t 
    WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmfqdocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmfq_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
    
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfr_t 
    WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmfrdocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmfr_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   DELETE FROM xmfr_t
    WHERE xmfrent = g_enterprise
      AND xmfrdocno = g_xmfo_m.xmfodocno    
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table4.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfs_t 
    WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmfsdocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table4.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmfs_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table4.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table4.a_insert"
   DELETE FROM xmfs_t
    WHERE xmfsent = g_enterprise
      AND xmfsdocno = g_xmfo_m.xmfodocno  
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table5.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmft_t 
    WHERE xmftent = g_enterprise AND xmftdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmftdocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table5.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmft_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table5.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table5.a_insert"
   DELETE FROM xmft_t
    WHERE xmftent = g_enterprise
      AND xmftdocno = g_xmfo_m.xmfodocno  
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table6.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfu_t 
    WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmfudocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table6.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmfu_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table6.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table6.a_insert"
   DELETE FROM xmfu_t
    WHERE xmfuent = g_enterprise
      AND xmfudocno = g_xmfo_m.xmfodocno  
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table7.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xmfv_t 
    WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfodocno_t
 
    INTO TEMP axmt700_detail
 
   #將key修正為調整後   
   UPDATE axmt700_detail SET xmfvdocno = g_xmfo_m.xmfodocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table7.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO xmfv_t SELECT * FROM axmt700_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table7.m_insert"
   DELETE FROM xmfv_t
    WHERE xmfvent = g_enterprise
      AND xmfvdocno = g_xmfo_m.xmfodocno  
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axmt700_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table7.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axmt700_delete()
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
   
   IF g_xmfo_m.xmfodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt700_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE axmt700_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT axmt700_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_xmfo_m_mask_o.* =  g_xmfo_m.*
   CALL axmt700_xmfo_t_mask()
   LET g_xmfo_m_mask_n.* =  g_xmfo_m.*
   
   CALL axmt700_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axmt700_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_xmfodocno_t = g_xmfo_m.xmfodocno
 
 
      DELETE FROM xmfo_t
       WHERE xmfoent = g_enterprise AND xmfodocno = g_xmfo_m.xmfodocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_xmfo_m.xmfodocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM xmfp_t
       WHERE xmfpent = g_enterprise AND xmfpdocno = g_xmfo_m.xmfodocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
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
      DELETE FROM xmfq_t
       WHERE xmfqent = g_enterprise AND
             xmfqdocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
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
      DELETE FROM xmfr_t
       WHERE xmfrent = g_enterprise AND
             xmfrdocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete4"
      
      #end add-point
      DELETE FROM xmfs_t
       WHERE xmfsent = g_enterprise AND
             xmfsdocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete4"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete5"
      
      #end add-point
      DELETE FROM xmft_t
       WHERE xmftent = g_enterprise AND
             xmftdocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete5"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete6"
      
      #end add-point
      DELETE FROM xmfu_t
       WHERE xmfuent = g_enterprise AND
             xmfudocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete6"
      
      #end add-point
 
      #add-point:單身刪除前 name="delete.body.b_delete7"
      
      #end add-point
      DELETE FROM xmfv_t
       WHERE xmfvent = g_enterprise AND
             xmfvdocno = g_xmfo_m.xmfodocno
      #add-point:單身刪除中 name="delete.body.m_delete7"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete7"
      #刪除單號
      IF NOT s_aooi200_del_docno(g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_xmfo_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE axmt700_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_xmfp_d.clear() 
      CALL g_xmfp2_d.clear()       
      CALL g_xmfp3_d.clear()       
      CALL g_xmfp4_d.clear()       
      CALL g_xmfp5_d.clear()       
      CALL g_xmfp6_d.clear()       
      CALL g_xmfp7_d.clear()       
 
     
      CALL axmt700_ui_browser_refresh()  
      #CALL axmt700_ui_headershow()  
      #CALL axmt700_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
      
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL axmt700_browser_fill("")
         CALL axmt700_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE axmt700_cl
 
   #功能已完成,通報訊息中心
   CALL axmt700_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axmt700.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axmt700_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_xmfp_d.clear()
   CALL g_xmfp2_d.clear()
   CALL g_xmfp3_d.clear()
   CALL g_xmfp4_d.clear()
   CALL g_xmfp5_d.clear()
   CALL g_xmfp6_d.clear()
   CALL g_xmfp7_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF axmt700_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfpseq,xmfp001,xmfpsite  FROM xmfp_t",   
                     " INNER JOIN xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfpdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE xmfpent=? AND xmfpdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfp_t.xmfpseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axmt700_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp_d[l_ac].xmfpseq,g_xmfp_d[l_ac].xmfp001, 
          g_xmfp_d[l_ac].xmfpsite   #(ver:78)
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
   IF axmt700_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite ,t1.oocql004 ,t2.ooag011 , 
             t3.ooefl003 FROM xmfq_t",   
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfqdocno ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='296' AND t1.oocql002=xmfq001 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=xmfq002  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=xmfq003 AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xmfqent=? AND xmfqdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfq_t.xmfqseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR axmt700_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp2_d[l_ac].xmfqseq,g_xmfp2_d[l_ac].xmfq001, 
          g_xmfp2_d[l_ac].xmfq002,g_xmfp2_d[l_ac].xmfq003,g_xmfp2_d[l_ac].xmfqsite,g_xmfp2_d[l_ac].xmfq001_desc, 
          g_xmfp2_d[l_ac].xmfq002_desc,g_xmfp2_d[l_ac].xmfq003_desc   #(ver:78)
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
   IF axmt700_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite ,t4.ooag011 ,t5.ooefl003 FROM xmfr_t", 
                
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfrdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=xmfr002  ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=xmfr003 AND t5.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xmfrent=? AND xmfrdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfr_t.xmfrseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR axmt700_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp3_d[l_ac].xmfrseq,g_xmfp3_d[l_ac].xmfr001, 
          g_xmfp3_d[l_ac].xmfr002,g_xmfp3_d[l_ac].xmfr003,g_xmfp3_d[l_ac].xmfrsite,g_xmfp3_d[l_ac].xmfr002_desc, 
          g_xmfp3_d[l_ac].xmfr003_desc   #(ver:78)
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
   IF axmt700_fill_chk(4) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body4.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite ,t6.ooag011 ,t7.ooefl003 FROM xmfs_t", 
                
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfsdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=xmfs002  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=xmfs003 AND t7.ooefl002='"||g_dlang||"' ",
 
                     " WHERE xmfsent=? AND xmfsdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body4.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table4) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfs_t.xmfsseq"
         
         #add-point:單身填充控制 name="b_fill.sql4"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR axmt700_pb4
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs4 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs4 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp4_d[l_ac].xmfsseq,g_xmfp4_d[l_ac].xmfs001, 
          g_xmfp4_d[l_ac].xmfs002,g_xmfp4_d[l_ac].xmfs003,g_xmfp4_d[l_ac].xmfssite,g_xmfp4_d[l_ac].xmfs002_desc, 
          g_xmfp4_d[l_ac].xmfs003_desc   #(ver:78)
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
 
   #判斷是否填充
   IF axmt700_fill_chk(5) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body5.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmftseq,xmft001,xmft002,xmftsite ,t8.ooag011 FROM xmft_t",   
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmftdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=xmft002  ",
 
                     " WHERE xmftent=? AND xmftdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body5.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table5) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table5 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmft_t.xmftseq"
         
         #add-point:單身填充控制 name="b_fill.sql5"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb5 FROM g_sql
         DECLARE b_fill_cs5 CURSOR FOR axmt700_pb5
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs5 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs5 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp5_d[l_ac].xmftseq,g_xmfp5_d[l_ac].xmft001, 
          g_xmfp5_d[l_ac].xmft002,g_xmfp5_d[l_ac].xmftsite,g_xmfp5_d[l_ac].xmft002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill5.fill"
         
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
   IF axmt700_fill_chk(6) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body6.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfuseq,xmfu001,xmfu002,xmfusite ,t9.ooag011 FROM xmfu_t",   
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfudocno ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=xmfu002  ",
 
                     " WHERE xmfuent=? AND xmfudocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body6.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table6) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table6 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfu_t.xmfuseq"
         
         #add-point:單身填充控制 name="b_fill.sql6"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb6 FROM g_sql
         DECLARE b_fill_cs6 CURSOR FOR axmt700_pb6
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs6 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs6 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp6_d[l_ac].xmfuseq,g_xmfp6_d[l_ac].xmfu001, 
          g_xmfp6_d[l_ac].xmfu002,g_xmfp6_d[l_ac].xmfusite,g_xmfp6_d[l_ac].xmfu002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill6.fill"
         
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
   IF axmt700_fill_chk(7) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body7.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT xmfvseq,xmfv001,xmfv002,xmfvsite ,t10.ooag011 FROM xmfv_t",   
              
                     " INNER JOIN  xmfo_t ON xmfoent = " ||g_enterprise|| " AND xmfodocno = xmfvdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=xmfv002  ",
 
                     " WHERE xmfvent=? AND xmfvdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body7.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table7) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table7 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY xmfv_t.xmfvseq"
         
         #add-point:單身填充控制 name="b_fill.sql7"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axmt700_pb7 FROM g_sql
         DECLARE b_fill_cs7 CURSOR FOR axmt700_pb7
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs7 USING g_enterprise,g_xmfo_m.xmfodocno   #(ver:78)
                                               
      FOREACH b_fill_cs7 USING g_enterprise,g_xmfo_m.xmfodocno INTO g_xmfp7_d[l_ac].xmfvseq,g_xmfp7_d[l_ac].xmfv001, 
          g_xmfp7_d[l_ac].xmfv002,g_xmfp7_d[l_ac].xmfvsite,g_xmfp7_d[l_ac].xmfv002_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill7.fill"
         
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
   
   CALL g_xmfp_d.deleteElement(g_xmfp_d.getLength())
   CALL g_xmfp2_d.deleteElement(g_xmfp2_d.getLength())
   CALL g_xmfp3_d.deleteElement(g_xmfp3_d.getLength())
   CALL g_xmfp4_d.deleteElement(g_xmfp4_d.getLength())
   CALL g_xmfp5_d.deleteElement(g_xmfp5_d.getLength())
   CALL g_xmfp6_d.deleteElement(g_xmfp6_d.getLength())
   CALL g_xmfp7_d.deleteElement(g_xmfp7_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE axmt700_pb
   FREE axmt700_pb2
 
   FREE axmt700_pb3
 
   FREE axmt700_pb4
 
   FREE axmt700_pb5
 
   FREE axmt700_pb6
 
   FREE axmt700_pb7
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_xmfp_d.getLength()
      LET g_xmfp_d_mask_o[l_ac].* =  g_xmfp_d[l_ac].*
      CALL axmt700_xmfp_t_mask()
      LET g_xmfp_d_mask_n[l_ac].* =  g_xmfp_d[l_ac].*
   END FOR
   
   LET g_xmfp2_d_mask_o.* =  g_xmfp2_d.*
   FOR l_ac = 1 TO g_xmfp2_d.getLength()
      LET g_xmfp2_d_mask_o[l_ac].* =  g_xmfp2_d[l_ac].*
      CALL axmt700_xmfq_t_mask()
      LET g_xmfp2_d_mask_n[l_ac].* =  g_xmfp2_d[l_ac].*
   END FOR
   LET g_xmfp3_d_mask_o.* =  g_xmfp3_d.*
   FOR l_ac = 1 TO g_xmfp3_d.getLength()
      LET g_xmfp3_d_mask_o[l_ac].* =  g_xmfp3_d[l_ac].*
      CALL axmt700_xmfr_t_mask()
      LET g_xmfp3_d_mask_n[l_ac].* =  g_xmfp3_d[l_ac].*
   END FOR
   LET g_xmfp4_d_mask_o.* =  g_xmfp4_d.*
   FOR l_ac = 1 TO g_xmfp4_d.getLength()
      LET g_xmfp4_d_mask_o[l_ac].* =  g_xmfp4_d[l_ac].*
      CALL axmt700_xmfs_t_mask()
      LET g_xmfp4_d_mask_n[l_ac].* =  g_xmfp4_d[l_ac].*
   END FOR
   LET g_xmfp5_d_mask_o.* =  g_xmfp5_d.*
   FOR l_ac = 1 TO g_xmfp5_d.getLength()
      LET g_xmfp5_d_mask_o[l_ac].* =  g_xmfp5_d[l_ac].*
      CALL axmt700_xmft_t_mask()
      LET g_xmfp5_d_mask_n[l_ac].* =  g_xmfp5_d[l_ac].*
   END FOR
   LET g_xmfp6_d_mask_o.* =  g_xmfp6_d.*
   FOR l_ac = 1 TO g_xmfp6_d.getLength()
      LET g_xmfp6_d_mask_o[l_ac].* =  g_xmfp6_d[l_ac].*
      CALL axmt700_xmfu_t_mask()
      LET g_xmfp6_d_mask_n[l_ac].* =  g_xmfp6_d[l_ac].*
   END FOR
   LET g_xmfp7_d_mask_o.* =  g_xmfp7_d.*
   FOR l_ac = 1 TO g_xmfp7_d.getLength()
      LET g_xmfp7_d_mask_o[l_ac].* =  g_xmfp7_d[l_ac].*
      CALL axmt700_xmfv_t_mask()
      LET g_xmfp7_d_mask_n[l_ac].* =  g_xmfp7_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axmt700_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM xmfp_t
       WHERE xmfpent = g_enterprise AND
         xmfpdocno = ps_keys_bak[1] AND xmfpseq = ps_keys_bak[2]
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
         CALL g_xmfp_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM xmfq_t
       WHERE xmfqent = g_enterprise AND
             xmfqdocno = ps_keys_bak[1] AND xmfqseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmfp2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM xmfr_t
       WHERE xmfrent = g_enterprise AND
             xmfrdocno = ps_keys_bak[1] AND xmfrseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_xmfp3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete4"
      
      #end add-point    
      DELETE FROM xmfs_t
       WHERE xmfsent = g_enterprise AND
             xmfsdocno = ps_keys_bak[1] AND xmfsseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete4"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_xmfp4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete4"
      
      #end add-point    
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete5"
      
      #end add-point    
      DELETE FROM xmft_t
       WHERE xmftent = g_enterprise AND
             xmftdocno = ps_keys_bak[1] AND xmftseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete5"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_xmfp5_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete5"
      
      #end add-point    
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete6"
      
      #end add-point    
      DELETE FROM xmfu_t
       WHERE xmfuent = g_enterprise AND
             xmfudocno = ps_keys_bak[1] AND xmfuseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete6"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_xmfp6_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete6"
      
      #end add-point    
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete7"
      
      #end add-point    
      DELETE FROM xmfv_t
       WHERE xmfvent = g_enterprise AND
             xmfvdocno = ps_keys_bak[1] AND xmfvseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete7"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_xmfp7_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete7"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axmt700_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO xmfp_t
                  (xmfpent,
                   xmfpdocno,
                   xmfpseq
                   ,xmfp001,xmfpsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp_d[g_detail_idx].xmfp001,g_xmfp_d[g_detail_idx].xmfpsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_xmfp_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO xmfq_t
                  (xmfqent,
                   xmfqdocno,
                   xmfqseq
                   ,xmfq001,xmfq002,xmfq003,xmfqsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp2_d[g_detail_idx].xmfq001,g_xmfp2_d[g_detail_idx].xmfq002,g_xmfp2_d[g_detail_idx].xmfq003, 
                       g_xmfp2_d[g_detail_idx].xmfqsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_xmfp2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO xmfr_t
                  (xmfrent,
                   xmfrdocno,
                   xmfrseq
                   ,xmfr001,xmfr002,xmfr003,xmfrsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp3_d[g_detail_idx].xmfr001,g_xmfp3_d[g_detail_idx].xmfr002,g_xmfp3_d[g_detail_idx].xmfr003, 
                       g_xmfp3_d[g_detail_idx].xmfrsite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_xmfp3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert4"
      
      #end add-point 
      INSERT INTO xmfs_t
                  (xmfsent,
                   xmfsdocno,
                   xmfsseq
                   ,xmfs001,xmfs002,xmfs003,xmfssite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp4_d[g_detail_idx].xmfs001,g_xmfp4_d[g_detail_idx].xmfs002,g_xmfp4_d[g_detail_idx].xmfs003, 
                       g_xmfp4_d[g_detail_idx].xmfssite)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert4"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'4'" THEN 
         CALL g_xmfp4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert4"
      
      #end add-point
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert5"
      
      #end add-point 
      INSERT INTO xmft_t
                  (xmftent,
                   xmftdocno,
                   xmftseq
                   ,xmft001,xmft002,xmftsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp5_d[g_detail_idx].xmft001,g_xmfp5_d[g_detail_idx].xmft002,g_xmfp5_d[g_detail_idx].xmftsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert5"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'5'" THEN 
         CALL g_xmfp5_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert5"
      
      #end add-point
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert6"
      
      #end add-point 
      INSERT INTO xmfu_t
                  (xmfuent,
                   xmfudocno,
                   xmfuseq
                   ,xmfu001,xmfu002,xmfusite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp6_d[g_detail_idx].xmfu001,g_xmfp6_d[g_detail_idx].xmfu002,g_xmfp6_d[g_detail_idx].xmfusite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert6"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'6'" THEN 
         CALL g_xmfp6_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert6"
      
      #end add-point
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert7"
      
      #end add-point 
      INSERT INTO xmfv_t
                  (xmfvent,
                   xmfvdocno,
                   xmfvseq
                   ,xmfv001,xmfv002,xmfvsite) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_xmfp7_d[g_detail_idx].xmfv001,g_xmfp7_d[g_detail_idx].xmfv002,g_xmfp7_d[g_detail_idx].xmfvsite) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert7"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'7'" THEN 
         CALL g_xmfp7_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert7"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axmt700_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfp_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL axmt700_xmfp_t_mask_restore('restore_mask_o')
               
      UPDATE xmfp_t 
         SET (xmfpdocno,
              xmfpseq
              ,xmfp001,xmfpsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp_d[g_detail_idx].xmfp001,g_xmfp_d[g_detail_idx].xmfpsite) 
         WHERE xmfpent = g_enterprise AND xmfpdocno = ps_keys_bak[1] AND xmfpseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfp_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfp_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfp_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfq_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmfq_t_mask_restore('restore_mask_o')
               
      UPDATE xmfq_t 
         SET (xmfqdocno,
              xmfqseq
              ,xmfq001,xmfq002,xmfq003,xmfqsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp2_d[g_detail_idx].xmfq001,g_xmfp2_d[g_detail_idx].xmfq002,g_xmfp2_d[g_detail_idx].xmfq003, 
                  g_xmfp2_d[g_detail_idx].xmfqsite) 
         WHERE xmfqent = g_enterprise AND xmfqdocno = ps_keys_bak[1] AND xmfqseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfq_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfq_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfq_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfr_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmfr_t_mask_restore('restore_mask_o')
               
      UPDATE xmfr_t 
         SET (xmfrdocno,
              xmfrseq
              ,xmfr001,xmfr002,xmfr003,xmfrsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp3_d[g_detail_idx].xmfr001,g_xmfp3_d[g_detail_idx].xmfr002,g_xmfp3_d[g_detail_idx].xmfr003, 
                  g_xmfp3_d[g_detail_idx].xmfrsite) 
         WHERE xmfrent = g_enterprise AND xmfrdocno = ps_keys_bak[1] AND xmfrseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfr_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfr_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfr_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update3"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfs_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update4"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmfs_t_mask_restore('restore_mask_o')
               
      UPDATE xmfs_t 
         SET (xmfsdocno,
              xmfsseq
              ,xmfs001,xmfs002,xmfs003,xmfssite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp4_d[g_detail_idx].xmfs001,g_xmfp4_d[g_detail_idx].xmfs002,g_xmfp4_d[g_detail_idx].xmfs003, 
                  g_xmfp4_d[g_detail_idx].xmfssite) 
         WHERE xmfsent = g_enterprise AND xmfsdocno = ps_keys_bak[1] AND xmfsseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update4"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfs_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfs_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfs_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update4"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'5',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmft_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update5"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmft_t_mask_restore('restore_mask_o')
               
      UPDATE xmft_t 
         SET (xmftdocno,
              xmftseq
              ,xmft001,xmft002,xmftsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp5_d[g_detail_idx].xmft001,g_xmfp5_d[g_detail_idx].xmft002,g_xmfp5_d[g_detail_idx].xmftsite)  
 
         WHERE xmftent = g_enterprise AND xmftdocno = ps_keys_bak[1] AND xmftseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update5"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmft_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmft_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmft_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update5"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'6',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfu_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update6"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmfu_t_mask_restore('restore_mask_o')
               
      UPDATE xmfu_t 
         SET (xmfudocno,
              xmfuseq
              ,xmfu001,xmfu002,xmfusite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp6_d[g_detail_idx].xmfu001,g_xmfp6_d[g_detail_idx].xmfu002,g_xmfp6_d[g_detail_idx].xmfusite)  
 
         WHERE xmfuent = g_enterprise AND xmfudocno = ps_keys_bak[1] AND xmfuseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update6"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfu_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfu_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfu_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update6"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'7',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "xmfv_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update7"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL axmt700_xmfv_t_mask_restore('restore_mask_o')
               
      UPDATE xmfv_t 
         SET (xmfvdocno,
              xmfvseq
              ,xmfv001,xmfv002,xmfvsite) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_xmfp7_d[g_detail_idx].xmfv001,g_xmfp7_d[g_detail_idx].xmfv002,g_xmfp7_d[g_detail_idx].xmfvsite)  
 
         WHERE xmfvent = g_enterprise AND xmfvdocno = ps_keys_bak[1] AND xmfvseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update7"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfv_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xmfv_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL axmt700_xmfv_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update7"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION axmt700_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt700.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axmt700_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="axmt700.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axmt700_lock_b(ps_table,ps_page)
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
   #CALL axmt700_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "xmfp_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN axmt700_bcl USING g_enterprise,
                                       g_xmfo_m.xmfodocno,g_xmfp_d[g_detail_idx].xmfpseq     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "xmfq_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl2 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp2_d[g_detail_idx].xmfqseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "xmfr_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl3 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp3_d[g_detail_idx].xmfrseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl3:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'4',"
   #僅鎖定自身table
   LET ls_group = "xmfs_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl4 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp4_d[g_detail_idx].xmfsseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl4:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'5',"
   #僅鎖定自身table
   LET ls_group = "xmft_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl5 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp5_d[g_detail_idx].xmftseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl5:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'6',"
   #僅鎖定自身table
   LET ls_group = "xmfu_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl6 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp6_d[g_detail_idx].xmfuseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl6:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'7',"
   #僅鎖定自身table
   LET ls_group = "xmfv_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN axmt700_bcl7 USING g_enterprise,
                                             g_xmfo_m.xmfodocno,g_xmfp7_d[g_detail_idx].xmfvseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "axmt700_bcl7:",SQLERRMESSAGE 
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
 
{<section id="axmt700.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axmt700_unlock_b(ps_table,ps_page)
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
      CLOSE axmt700_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl3
   END IF
 
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl4
   END IF
 
   LET ls_group = "'5',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl5
   END IF
 
   LET ls_group = "'6',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl6
   END IF
 
   LET ls_group = "'7',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE axmt700_bcl7
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axmt700_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("xmfodocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xmfodocno",TRUE)
      CALL cl_set_comp_entry("xmfodocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("xmfo007,xmfo008,xmfo009,xmfo010,xmfo011,xmfo012,xmfo013",TRUE)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
      CALL cl_set_comp_entry("xmfo013,xmfo013_desc",TRUE) 
   END IF   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axmt700_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_imaa005    LIKE imaa_t.imaa005  
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xmfodocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("xmfodocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("xmfodocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF cl_null(g_xmfo_m.xmfo006) THEN
      CALL cl_set_comp_entry("xmfo007",FALSE)
   END IF
   IF NOT cl_null(g_xmfo_m.xmfo006) AND NOT cl_null(g_xmfo_m.xmfo007) THEN
      CALL cl_set_comp_entry("xmfo008,xmfo009,xmfo010,xmfo011,xmfo012,xmfo013",FALSE)
   END IF
   IF cl_null(g_xmfo_m.xmfo012) THEN
      CALL cl_set_comp_entry("xmfo013",FALSE)
   ELSE
      #料件主檔無特徵類別，不能維護產品特徵
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'Y' THEN
         LET l_imaa005 = ''
         SELECT imaa005 INTO l_imaa005
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_xmfo_m.xmfo012
         IF cl_null(l_imaa005) THEN
            CALL cl_set_comp_entry("xmfo013",FALSE)
         END IF
      END IF   
    END IF
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axmt700_set_entry_b(p_cmd)
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
 
{<section id="axmt700.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axmt700_set_no_entry_b(p_cmd)
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
 
{<section id="axmt700.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axmt700_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   CALL cl_set_act_visible("statechange", TRUE)
   CALL cl_set_act_visible("produce_rma,produce_xmdk", TRUE)
   CALL cl_set_act_visible("open_xmfq,open_xmfr,open_xmfs,open_xmft,open_xmfu,open_xmfv", TRUE)
   

   CALL cl_set_comp_visible("xmfo013,xmfo013_desc",TRUE) 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axmt700_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_xmfo_m.xmfostus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   IF g_xmfo_m.xmfostus = 'C' THEN
      CALL cl_set_act_visible("statechange", FALSE)
   END IF   
   IF g_xmfo_m.xmfostus <> 'Y' OR g_xmfo_m.xmfo016 MATCHES "[02]" OR NOT cl_null(g_xmfo_m.xmfo017) THEN
      CALL cl_set_act_visible("produce_rma", FALSE)
   END IF   
   IF g_xmfo_m.xmfostus <> 'Y' OR g_xmfo_m.xmfo016 MATCHES "[01]" OR NOT cl_null(g_xmfo_m.xmfo017) THEN
      CALL cl_set_act_visible("produce_xmdk", FALSE)
   END IF   
   IF g_xmfo_m.xmfostus = 'C' THEN
      CALL cl_set_act_visible("open_xmfq,open_xmfr,open_xmfs,open_xmft,open_xmfu,open_xmfv", FALSE)
   END IF
   IF g_xmfo_m.xmfostus = 'Y' THEN
      CALL cl_set_act_visible("open_xmfq", FALSE)
   END IF   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("xmfo013,xmfo013_desc",FALSE) 
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axmt700_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axmt700_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axmt700_default_search()
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
      LET ls_wc = ls_wc, " xmfodocno = '", g_argv[01], "' AND "
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
 
         INITIALIZE g_wc2_table5 TO NULL
 
         INITIALIZE g_wc2_table6 TO NULL
 
         INITIALIZE g_wc2_table7 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "xmfo_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmfp_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "xmfq_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xmfr_t" 
                  LET g_wc2_table3 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xmfs_t" 
                  LET g_wc2_table4 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xmft_t" 
                  LET g_wc2_table5 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xmfu_t" 
                  LET g_wc2_table6 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "xmfv_t" 
                  LET g_wc2_table7 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
            OR NOT cl_null(g_wc2_table3)
 
            OR NOT cl_null(g_wc2_table4)
 
            OR NOT cl_null(g_wc2_table5)
 
            OR NOT cl_null(g_wc2_table6)
 
            OR NOT cl_null(g_wc2_table7)
 
 
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
 
            IF g_wc2_table5 <> " 1=1" AND NOT cl_null(g_wc2_table5) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table5
            END IF
 
            IF g_wc2_table6 <> " 1=1" AND NOT cl_null(g_wc2_table6) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table6
            END IF
 
            IF g_wc2_table7 <> " 1=1" AND NOT cl_null(g_wc2_table7) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table7
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
 
{<section id="axmt700.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION axmt700_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_xmfo_m.xmfodocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
   IF STATUS THEN
      CLOSE axmt700_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axmt700_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
       g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
       g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
       g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
       g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfdt, 
       g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp_desc, 
       g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT axmt700_action_chk() THEN
      CLOSE axmt700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocno_desc,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001,g_xmfo_m.xmfo002, 
       g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfostus, 
       g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo012_desc, 
       g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013, 
       g_xmfo_m.xmfo013_desc,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc, 
       g_xmfo_m.xmfo016,g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoownid_desc, 
       g_xmfo_m.xmfoowndp,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp, 
       g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfomoddt, 
       g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfid_desc,g_xmfo_m.xmfocnfdt
 
   CASE g_xmfo_m.xmfostus
      WHEN "C"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   CALL axmt700_show()  #161207-00033#18
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_xmfo_m.xmfostus
            
            WHEN "C"
               HIDE OPTION "closed"
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("confirmed,unconfirmed,closed",FALSE)  
      CASE g_xmfo_m.xmfostus
        WHEN 'N'
          CALL cl_set_act_visible("confirmed",TRUE)
        WHEN 'Y'
          CALL cl_set_act_visible("unconfirmed,closed",TRUE)
        WHEN 'C'
      END CASE  
      #end add-point
      
      
	  
      ON ACTION closed
         IF cl_auth_chk_act("closed") THEN
            LET lc_state = "C"
            #add-point:action控制 name="statechange.closed"
            
            #end add-point
         END IF
         EXIT MENU
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
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "C" 
      AND lc_state <> "N"
      AND lc_state <> "Y"
      ) OR 
      g_xmfo_m.xmfostus = lc_state OR cl_null(lc_state) THEN
      CLOSE axmt700_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   IF lc_state = "Y" THEN      
      IF NOT cl_ask_confirm('aim-00108') THEN
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      END IF
   END IF
   IF lc_state = "N" THEN         
      IF g_xmfo_m.xmfo016 MATCHES "[12]" AND NOT cl_null(g_xmfo_m.xmfo017) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00722'           #已產生RMA/銷退單，無法取消確認！
         LET g_errparam.extend = g_xmfo_m.xmfo001
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN              
      END IF
      IF NOT cl_ask_confirm('aim-00110') THEN
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN
      END IF      
   END IF    
   IF lc_state = "C" THEN         
      IF g_xmfo_m.xmfo016 MATCHES "[12]" AND cl_null(g_xmfo_m.xmfo017) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axm-00723'           #未產生RMA/銷退單，無法結案！
         LET g_errparam.extend = g_xmfo_m.xmfo001
         LET g_errparam.popup = TRUE
         CALL cl_err()  
         CALL s_transaction_end('N','0')   #160812-00017#3 Add By Ken 160815
         RETURN              
       END IF
   END IF   
   #end add-point
   
   LET g_xmfo_m.xmfomodid = g_user
   LET g_xmfo_m.xmfomoddt = cl_get_current()
   LET g_xmfo_m.xmfostus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE xmfo_t 
      SET (xmfostus,xmfomodid,xmfomoddt) 
        = (g_xmfo_m.xmfostus,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt)     
    WHERE xmfoent = g_enterprise AND xmfodocno = g_xmfo_m.xmfodocno
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "C"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/closed.png")
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE axmt700_master_referesh USING g_xmfo_m.xmfodocno INTO g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocdt, 
          g_xmfo_m.xmfo001,g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo004,g_xmfo_m.xmfostus,g_xmfo_m.xmfo005, 
          g_xmfo_m.xmfo012,g_xmfo_m.xmfo006,g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010, 
          g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo018,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo016, 
          g_xmfo_m.xmfo017,g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfocrtid, 
          g_xmfo_m.xmfocrtdp,g_xmfo_m.xmfocrtdt,g_xmfo_m.xmfomodid,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid, 
          g_xmfo_m.xmfocnfdt,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004_desc,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012_desc, 
          g_xmfo_m.xmfo015_desc,g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp_desc,g_xmfo_m.xmfocrtid_desc, 
          g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfocnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_xmfo_m.xmfodocno,g_xmfo_m.xmfodocno_desc,g_xmfo_m.xmfodocdt,g_xmfo_m.xmfo001, 
          g_xmfo_m.xmfo002,g_xmfo_m.xmfo003,g_xmfo_m.xmfo003_desc,g_xmfo_m.xmfo004,g_xmfo_m.xmfo004_desc, 
          g_xmfo_m.xmfostus,g_xmfo_m.xmfo005,g_xmfo_m.xmfo005_desc,g_xmfo_m.xmfo012,g_xmfo_m.xmfo006, 
          g_xmfo_m.xmfo007,g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009, 
          g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo013,g_xmfo_m.xmfo013_desc,g_xmfo_m.xmfo018, 
          g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo015_desc,g_xmfo_m.xmfo016,g_xmfo_m.xmfo017, 
          g_xmfo_m.xmfosite,g_xmfo_m.xmfoownid,g_xmfo_m.xmfoownid_desc,g_xmfo_m.xmfoowndp,g_xmfo_m.xmfoowndp_desc, 
          g_xmfo_m.xmfocrtid,g_xmfo_m.xmfocrtid_desc,g_xmfo_m.xmfocrtdp,g_xmfo_m.xmfocrtdp_desc,g_xmfo_m.xmfocrtdt, 
          g_xmfo_m.xmfomodid,g_xmfo_m.xmfomodid_desc,g_xmfo_m.xmfomoddt,g_xmfo_m.xmfocnfid,g_xmfo_m.xmfocnfid_desc, 
          g_xmfo_m.xmfocnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL axmt700_show()  #161207-00033#18
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE axmt700_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axmt700_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt700.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axmt700_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_xmfp_d.getLength() THEN
         LET g_detail_idx = g_xmfp_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xmfp2_d.getLength() THEN
         LET g_detail_idx = g_xmfp2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_xmfp3_d.getLength() THEN
         LET g_detail_idx = g_xmfp3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 4 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_xmfp4_d.getLength() THEN
         LET g_detail_idx = g_xmfp4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp4_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 5 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail5")
      IF g_detail_idx > g_xmfp5_d.getLength() THEN
         LET g_detail_idx = g_xmfp5_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp5_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp5_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 6 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail6")
      IF g_detail_idx > g_xmfp6_d.getLength() THEN
         LET g_detail_idx = g_xmfp6_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp6_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp6_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 7 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail7")
      IF g_detail_idx > g_xmfp7_d.getLength() THEN
         LET g_detail_idx = g_xmfp7_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xmfp7_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xmfp7_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axmt700_b_fill2(pi_idx)
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
   
   CALL axmt700_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axmt700_fill_chk(ps_idx)
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
      (cl_null(g_wc2_table4) OR g_wc2_table4.trim() = '1=1')  AND 
      (cl_null(g_wc2_table5) OR g_wc2_table5.trim() = '1=1')  AND 
      (cl_null(g_wc2_table6) OR g_wc2_table6.trim() = '1=1')  AND 
      (cl_null(g_wc2_table7) OR g_wc2_table7.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axmt700.status_show" >}
PRIVATE FUNCTION axmt700_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmt700.mask_functions" >}
&include "erp/axm/axmt700_mask.4gl"
 
{</section>}
 
{<section id="axmt700.signature" >}
   
 
{</section>}
 
{<section id="axmt700.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axmt700_set_pk_array()
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
   LET g_pk_array[1].values = g_xmfo_m.xmfodocno
   LET g_pk_array[1].column = 'xmfodocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt700.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="axmt700.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axmt700_msgcentre_notify(lc_state)
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
   CALL axmt700_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xmfo_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axmt700.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION axmt700_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#4-s
   SELECT xmfostus INTO g_xmfo_m.xmfostus FROM xmfo_t
    WHERE xmfoent = g_enterprise
      AND xmfosite = g_site
      AND xmfodocno = g_xmfo_m.xmfodocno
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_xmfo_m.xmfostus
     
        WHEN 'C'
           LET g_errno = 'ain-00197'

        WHEN 'Y'
           LET g_errno = 'sub-00178'

     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_xmfo_m.xmfodocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL axmt700_set_act_visible()
        CALL axmt700_set_act_no_visible()
        CALL axmt700_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#4-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axmt700.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 出貨單檢核
# Memo...........:
# Usage..........: CALL axmt700_xmdkdocno_chk(p_xmfo005,p_xmfo006,p_xmfo007)
#                  RETURNING TRUE/FALSE
# Input parameter: p_xmfo005     客戶編號
#                : p_xmfo006     出貨單單號
#                : p_xmfo007     出貨項次
# Return code....: TRUE/FALSE
# Date & Author..: 150911 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_xmdkdocno_chk(p_xmfo005,p_xmfo006,p_xmfo007)
DEFINE p_xmfo005 LIKE xmfo_t.xmfo005
DEFINE p_xmfo006 LIKE xmfo_t.xmfo006
DEFINE p_xmfo007 LIKE xmfo_t.xmfo007
DEFINE l_cnt     LIKE type_t.num5
DEFINE l_sql     STRING

   LET l_sql = "SELECT COUNT(*)",
               "  FROM xmdk_t,xmdl_t",
               " WHERE xmdkent = xmdlent",
               "   AND xmdkdocno = xmdldocno ",
               "   AND xmdk000 = '1' ",
               "   AND xmdkstus = 'S'",               
               "   AND xmdlent = ",g_enterprise,
               "   AND xmdldocno = '",p_xmfo006,"'", 
               "   AND xmdlseq = '",p_xmfo007,"'" 
   IF NOT cl_null(p_xmfo005) THEN
      LET l_sql = l_sql , " AND xmdk007 = '",p_xmfo005,"'"
   END IF   
   PREPARE axmt700_xmdkdocno_sel FROM l_sql
   LET l_cnt = 0
   EXECUTE axmt700_xmdkdocno_sel INTO l_cnt      
   IF l_cnt = 0 THEN
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF

END FUNCTION
################################################################################
# Descriptions...: 依出貨單帶出相關欄位值
# Memo...........:
# Usage..........: CALL axmt700_xmdgdocno_ref()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150911 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_xmdgdocno_ref()
     SELECT xmdl003,xmdl004,xmdl005,xmdl006,xmdl008,
            xmdl009,xmdl017,xmdl018,xmdk007
        INTO g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,g_xmfo_m.xmfo012,
             g_xmfo_m.xmfo013,g_xmfo_m.xmfo015,g_xmfo_m.xmfo014,g_xmfo_m.xmfo005
        FROM xmdk_t,xmdl_t
       WHERE xmdkent = xmdlent
         AND xmdkdocno = xmdldocno
         AND xmdlent = g_enterprise
         AND xmdldocno = g_xmfo_m.xmfo006
         AND xmdlseq = g_xmfo_m.xmfo007     


     LET g_xmfo_m_o.xmfo005 = g_xmfo_m.xmfo005
     CALL s_desc_get_item_desc(g_xmfo_m.xmfo012)
       RETURNING g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1
     CALL s_desc_get_unit_desc(g_xmfo_m.xmfo015) RETURNING g_xmfo_m.xmfo015_desc
     
     #161207-00033#18-s add
     CALL axmt700_guest_desc('a',g_xmfo_m.xmfo006,g_xmfo_m.xmfo008,g_xmfo_m.xmfo005)
          RETURNING g_xmfo_m.xmfo005_desc
     #161207-00033#18-e add
          
     DISPLAY BY NAME g_xmfo_m.xmfo005,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,
                     g_xmfo_m.xmfo012,g_xmfo_m.xmfo013,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,g_xmfo_m.xmfo012_desc,
                     g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo015_desc
                    ,g_xmfo_m.xmfo005_desc   #161207-00033#18 add
     
END FUNCTION

################################################################################
# Descriptions...: 清空預代值
# Memo...........:
# Usage..........: CALL axmt700_xmdkdocno_clear()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150911 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_xmdkdocno_clear()

    LET g_xmfo_m.xmfo007 = ''
    LET g_xmfo_m.xmfo008 = ''
    LET g_xmfo_m.xmfo009 = ''
    LET g_xmfo_m.xmfo010 = ''
    LET g_xmfo_m.xmfo011 = ''
    LET g_xmfo_m.xmfo012 = ''
    LET g_xmfo_m.xmfo013 = ''
    LET g_xmfo_m.xmfo014 = ''
    LET g_xmfo_m.xmfo015 = ''
    LET g_xmfo_m.xmfo012_desc = ''
    LET g_xmfo_m.xmfo012_desc_1 = ''
    LET g_xmfo_m.xmfo015_desc = ''
    DISPLAY BY NAME g_xmfo_m.xmfo007,g_xmfo_m.xmfo008,g_xmfo_m.xmfo009,g_xmfo_m.xmfo010,g_xmfo_m.xmfo011,
                    g_xmfo_m.xmfo012,g_xmfo_m.xmfo013,g_xmfo_m.xmfo014,g_xmfo_m.xmfo015,
                    g_xmfo_m.xmfo012_desc,g_xmfo_m.xmfo012_desc_1,g_xmfo_m.xmfo015_desc

END FUNCTION
################################################################################
# Descriptions...: 客訴數量檢核
# Memo...........:
# Usage..........: CALL axmt700_xmfo006_chk()
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: 
# Date & Author..: 150911 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_xmfo006_chk()
DEFINE  l_xmdl018    LIKE xmdl_t.xmdl018
DEFINE  l_xmfo014    LIKE xmfo_t.xmfo014
   
   IF cl_null(g_xmfo_m.xmfo006) OR cl_null(g_xmfo_m.xmfo007) THEN
      RETURN TRUE
   END IF
   LET l_xmdl018 = 0
   SELECT xmdl018 INTO l_xmdl018
     FROM xmdl_t
    WHERE xmdlent = g_enterprise
      AND xmdldocno = g_xmfo_m.xmfo006
      AND xmdlseq = g_xmfo_m.xmfo007
   IF cl_null(l_xmdl018) THEN LET l_xmdl018 = 0 END IF
   
   LET l_xmfo014 = 0
   SELECT SUM(xmfo014) INTO l_xmfo014
     FROM xmfo_t
    WHERE xmfoent = g_enterprise
      AND xmfodocno  <> g_xmfo_m.xmfodocno
      AND xmfo006 = g_xmfo_m.xmfo006
      AND xmfo007 = g_xmfo_m.xmfo007
      AND xmfostus <> 'X'
   IF cl_null(l_xmfo014) THEN LET l_xmfo014 = 0 END IF  
   IF l_xmdl018 - l_xmfo014 <= 0 THEN
      RETURN FALSE
   END IF   
   IF g_xmfo_m.xmfo014 > l_xmdl018 - l_xmfo014 THEN
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF      

END FUNCTION
################################################################################
# Descriptions...: 執行action修改資料前lock
# Memo...........:
# Usage..........: CALL axmt700_action_modify(p_flag)
# Input parameter: p_flag   'Q'客訴原因(xmfq_t)、'R'調查結果(xmfr_t)、'S'處理即改善對策(xmfs_t)
#                           'T'審核紀錄(xmft_t)、'U'核決紀錄(xmfu_t)、'V'結案紀錄(xmfv_t)                  
# Return code....: TRUE OR FALSE
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_action_modify(p_flag)
DEFINE p_flag       LIKE type_t.chr1
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
  
   IF g_xmfo_m.xmfodocno IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "std-00003"
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN 
   END IF

   ERROR ""

   CALL s_transaction_begin()
   
   LET g_xmfodocno_t = g_xmfo_m.xmfodocno
   
   
   OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "OPEN axmt700_cl:"
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      CLOSE axmt700_cl
      RETURN 
   END IF

   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   CALL cl_set_head_visible("","YES")

   CALL axmt700_show()   

   WHILE TRUE
      LET g_xmfodocno_t = g_xmfo_m.xmfodocno
      LET g_xmfo_m.xmfomodid = g_user
      LET g_xmfo_m.xmfomoddt = cl_get_current()

      CASE p_flag
         WHEN 'Q'  #客訴原因
           CALL axmt700_open_xmfq() #RETURNING r_success
         WHEN 'R'  #調查結果
           CALL axmt700_open_xmfr() #RETURNING r_success
         WHEN 'S'  #處理即改善對策
           CALL axmt700_open_xmfs() #RETURNING r_success
         WHEN 'T'  #審核紀錄
           CALL axmt700_open_xmft() #RETURNING r_success
         WHEN 'U'  #核決紀錄
           CALL axmt700_open_xmfu() #RETURNING r_success
         WHEN 'V'  #結案紀錄
           CALL axmt700_open_xmfv() #RETURNING r_success
         OTHERWISE EXIT CASE
      END CASE
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xmfo_m.* = g_xmfo_m_t.*
         CALL axmt700_show()
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 9001
         LET g_errparam.popup  = FALSE
         CALL cl_err()
         EXIT WHILE
      END IF

      EXIT WHILE
   END WHILE
   
   CLOSE axmt700_cl
   CALL axmt700_show() 

   #流程通知預埋點-U
   CALL cl_flow_notify(g_xmfo_m.xmfodocno,'U')
     
END FUNCTION

################################################################################
# Descriptions...: 進入客訴原因頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmfq()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmfq()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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
  
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1

   LET g_forupd_sql = "SELECT xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite FROM xmfq_t WHERE xmfqent=? AND  
       xmfqdocno=? AND xmfqseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl62 CURSOR FROM g_forupd_sql   



   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)      
      INPUT ARRAY g_xmfp2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                          
         
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp2_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp2_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp2_d_t.* TO NULL 
            INITIALIZE g_xmfp2_d_o.* TO NULL 
            LET g_xmfp2_d_t.* = g_xmfp2_d[l_ac].*     #新輸入資料
            LET g_xmfp2_d_o.* = g_xmfp2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp2_d[li_reproduce_target].* = g_xmfp2_d[li_reproduce].*
 
               LET g_xmfp2_d[li_reproduce_target].xmfqseq = NULL
            END IF 
            #項次加1
            SELECT MAX(xmfqseq)+1 INTO g_xmfp2_d[l_ac].xmfqseq FROM xmfq_t
             WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp2_d[l_ac].xmfqseq) OR g_xmfp2_d[l_ac].xmfqseq = 0 THEN
               LET g_xmfp2_d[l_ac].xmfqseq = 1
            END IF
            LET g_xmfp2_d[l_ac].xmfqsite = g_xmfo_m.xmfosite

         BEFORE ROW       
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN axmt700_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE axmt700_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_xmfp2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp2_d[l_ac].xmfqseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp2_d_t.* = g_xmfp2_d[l_ac].*  #BACKUP
               LET g_xmfp2_d_o.* = g_xmfp2_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)  
               CALL axmt700_set_no_entry_b(l_cmd)
              #IF NOT axmt700_lock_b("xmfq_t","'2'") THEN
              
               OPEN axmt700_bcl62 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp2_d[g_detail_idx].xmfqseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt700_bcl62" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'           
               ELSE
                  FETCH axmt700_bcl62 INTO g_xmfp2_d[l_ac].xmfqseq,g_xmfp2_d[l_ac].xmfq001,g_xmfp2_d[l_ac].xmfq002, 
                      g_xmfp2_d[l_ac].xmfq003,g_xmfp2_d[l_ac].xmfqsite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp2_d_mask_o[l_ac].* =  g_xmfp2_d[l_ac].*
                  CALL axmt700_xmfq_t_mask()
                  LET g_xmfp2_d_mask_n[l_ac].* =  g_xmfp2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'

            ELSE
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
                
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp2_d_t.xmfqseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfq_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfq_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF                  
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1               
               LET l_count = g_xmfp_d.getLength()               

            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp2_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmfq_t 
             WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
               AND xmfqseq = g_xmfp2_d[l_ac].xmfqseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp2_d[g_detail_idx].xmfqseq
               CALL axmt700_insert_b('xmfq_t',gs_keys,"'2'")                         
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfq_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
               CLOSE axmt700_bcl62
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
            ELSE             
               
               #將遮罩欄位還原
               CALL axmt700_xmfq_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfq_t SET (xmfqdocno,xmfqseq,xmfq001,xmfq002,xmfq003,xmfqsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp2_d[l_ac].xmfqseq,g_xmfp2_d[l_ac].xmfq001,g_xmfp2_d[l_ac].xmfq002,g_xmfp2_d[l_ac].xmfq003, 
                   g_xmfp2_d[l_ac].xmfqsite) #自訂欄位頁簽
                WHERE xmfqent = g_enterprise AND xmfqdocno = g_xmfo_m.xmfodocno
                  AND xmfqseq = g_xmfp2_d_t.xmfqseq #項次 
                  

                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfq_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfq_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp2_d[g_detail_idx].xmfqseq
                     LET gs_keys_bak[2] = g_xmfp2_d_t.xmfqseq
                     CALL axmt700_update_b('xmfq_t',gs_keys,gs_keys_bak,"'2'")
                     #資料多語言用-增/改                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfq_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp2_d[g_detail_idx].xmfqseq = g_xmfp2_d_t.xmfqseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp2_d_t.xmfqseq
                  CALL axmt700_key_update_b(gs_keys,'xmfq_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp2_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF           
            END IF


         AFTER FIELD xmfqseq

            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmfp2_d[l_ac].xmfqseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmfqseq
            END IF  
            #確認資料無重複
            IF  g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp2_d[g_detail_idx].xmfqseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp2_d[g_detail_idx].xmfqseq != g_xmfp2_d_t.xmfqseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfq_t WHERE "||"xmfqent = '" ||g_enterprise|| "' AND "||"xmfqdocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmfqseq = '"||g_xmfp2_d[g_detail_idx].xmfqseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



         AFTER FIELD xmfq001
            
            LET g_xmfp2_d[l_ac].xmfq001_desc = ''
           
            CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc

            IF NOT cl_null(g_xmfp2_d[l_ac].xmfq001) THEN
               IF NOT s_azzi650_chk_exist('296',g_xmfp2_d[l_ac].xmfq001) THEN
                  LET g_xmfp2_d[l_ac].xmfq001 = g_xmfp2_d_t.xmfq001
                  CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
                  DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc
                  NEXT FIELD CURRENT
               END IF
               LET g_xmfp2_d_t.xmfq001 = g_xmfp2_d[l_ac].xmfq001
            END IF
            

         AFTER FIELD xmfq002

            LET g_xmfp2_d[l_ac].xmfq002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002_desc
            IF NOT cl_null(g_xmfp2_d[l_ac].xmfq002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp2_d[l_ac].xmfq002 != g_xmfp2_d_o.xmfq002 OR cl_null(g_xmfp2_d_o.xmfq002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp2_d[l_ac].xmfq002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp2_d[l_ac].xmfq003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp2_d[l_ac].xmfq002
                     CALL s_desc_get_department_desc(g_xmfp2_d[l_ac].xmfq003) RETURNING g_xmfp2_d[l_ac].xmfq003_desc
                     DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq003_desc 
                  ELSE
                     LET g_xmfp2_d[l_ac].xmfq002 = g_xmfp2_d_o.xmfq002
                     CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
                     DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002,g_xmfp2_d[l_ac].xmfq002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp2_d_o.xmfq002 = g_xmfp2_d[l_ac].xmfq002 
            END IF 

            
 

         AFTER FIELD xmfq003  
         
            LET  g_xmfp2_d[l_ac].xmfq003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp2_d[l_ac].xmfq003) RETURNING  g_xmfp2_d[l_ac].xmfq003_desc
            DISPLAY BY NAME  g_xmfp2_d[l_ac].xmfq003_desc 
            IF NOT cl_null( g_xmfp2_d[l_ac].xmfq003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp2_d[l_ac].xmfq003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp2_d[l_ac].xmfq003 =  g_xmfp2_d_o.xmfq003
                  CALL s_desc_get_department_desc( g_xmfp2_d[l_ac].xmfq003) RETURNING  g_xmfp2_d[l_ac].xmfq003_desc
                  DISPLAY BY NAME  g_xmfp2_d[l_ac].xmfq003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp2_d_o.xmfq003 =  g_xmfp2_d[l_ac].xmfq003               
            END IF
     


         ON ACTION controlp INFIELD xmfq001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq001
            LET g_qryparam.arg1 = "296"
            CALL q_oocq002()                                 
            LET g_xmfp2_d[l_ac].xmfq001 = g_qryparam.return1 
            DISPLAY g_xmfp2_d[l_ac].xmfq001 TO xmfq001              
            CALL s_desc_get_acc_desc('296',g_xmfp2_d[l_ac].xmfq001) RETURNING g_xmfp2_d[l_ac].xmfq001_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq001_desc
            NEXT FIELD xmfq001                          #返回原欄位


 

         ON ACTION controlp INFIELD xmfq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq002
            CALL q_ooag001()                            
            LET g_xmfp2_d[l_ac].xmfq002 = g_qryparam.return1            
            DISPLAY g_xmfp2_d[l_ac].xmfq002 TO xmfq002              
            NEXT FIELD xmfq002                          
            CALL s_desc_get_person_desc(g_xmfp2_d[l_ac].xmfq002) RETURNING g_xmfp2_d[l_ac].xmfq002_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq002_desc   


 

         ON ACTION controlp INFIELD xmfq003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp2_d[l_ac].xmfq003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                              
            LET g_xmfp2_d[l_ac].xmfq003 = g_qryparam.return1              
            DISPLAY g_xmfp2_d[l_ac].xmfq003 TO xmfq003              
            NEXT FIELD xmfq003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp2_d[l_ac].xmfq003) RETURNING g_xmfp2_d[l_ac].xmfq003_desc
            DISPLAY BY NAME g_xmfp2_d[l_ac].xmfq003_desc  
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp2_d[l_ac].* = g_xmfp2_d_t.*
               END IF
               CLOSE axmt700_bcl62
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock            
            CALL axmt700_unlock_b("xmfq_t","'2'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT
 
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp2_d[li_reproduce_target].* = g_xmfp2_d[li_reproduce].*
 
               LET g_xmfp2_d[li_reproduce_target].xmfqseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp2_d.getLength()+1
            END IF
            
      END INPUT
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG   

END FUNCTION
################################################################################
# Descriptions...: 進入調查結果頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmfr()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmfr()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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


   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1

   LET g_forupd_sql = "SELECT xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite FROM xmfr_t WHERE xmfrent=? AND xmfrdocno=? AND xmfrseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl63 CURSOR FROM g_forupd_sql


   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_xmfp3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         
         
         BEFORE INPUT

            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp3_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp3_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp3_d_t.* TO NULL 
            INITIALIZE g_xmfp3_d_o.* TO NULL 

            LET g_xmfp3_d_t.* = g_xmfp3_d[l_ac].*     #新輸入資料
            LET g_xmfp3_d_o.* = g_xmfp3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp3_d[li_reproduce_target].* = g_xmfp3_d[li_reproduce].*
 
               LET g_xmfp3_d[li_reproduce_target].xmfrseq = NULL
            END IF
            
            #項次加1
            SELECT MAX(xmfrseq)+1 INTO g_xmfp3_d[l_ac].xmfrseq FROM xmfr_t
             WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp3_d[l_ac].xmfrseq) OR g_xmfp3_d[l_ac].xmfrseq = 0 THEN
               LET g_xmfp3_d[l_ac].xmfrseq = 1
            END IF
            LET g_xmfp3_d[l_ac].xmfrsite = g_xmfo_m.xmfosite


         BEFORE ROW     
  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 3
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN axmt700_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE axmt700_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_xmfp3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp3_d[l_ac].xmfrseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp3_d_t.* = g_xmfp3_d[l_ac].*  #BACKUP
               LET g_xmfp3_d_o.* = g_xmfp3_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               CALL axmt700_set_no_entry_b(l_cmd)
               
              #IF NOT axmt700_lock_b("xmfr_t","'3'") THEN
                 
               OPEN axmt700_bcl63 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp3_d[g_detail_idx].xmfrseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt700_bcl63" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'             
               ELSE
                  FETCH axmt700_bcl63 INTO g_xmfp3_d[l_ac].xmfrseq,g_xmfp3_d[l_ac].xmfr001,g_xmfp3_d[l_ac].xmfr002, 
                      g_xmfp3_d[l_ac].xmfr003,g_xmfp3_d[l_ac].xmfrsite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp3_d_mask_o[l_ac].* =  g_xmfp3_d[l_ac].*
                  CALL axmt700_xmfr_t_mask()
                  LET g_xmfp3_d_mask_n[l_ac].* =  g_xmfp3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #其他table資料備份(確定是否更改用)
            
            #其他table進行lock
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp3_d_t.xmfrseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfr_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfr_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1
               LET l_count = g_xmfp_d.getLength()     
            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp3_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmfr_t 
             WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
               AND xmfrseq = g_xmfp3_d[l_ac].xmfrseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
           
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp3_d[g_detail_idx].xmfrseq
               CALL axmt700_insert_b('xmfr_t',gs_keys,"'3'")
                           
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfr_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
               CLOSE axmt700_bcl63
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
            ELSE             
               
               #將遮罩欄位還原
               CALL axmt700_xmfr_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfr_t SET (xmfrdocno,xmfrseq,xmfr001,xmfr002,xmfr003,xmfrsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp3_d[l_ac].xmfrseq,g_xmfp3_d[l_ac].xmfr001,g_xmfp3_d[l_ac].xmfr002,g_xmfp3_d[l_ac].xmfr003, 
                   g_xmfp3_d[l_ac].xmfrsite) #自訂欄位頁簽
                WHERE xmfrent = g_enterprise AND xmfrdocno = g_xmfo_m.xmfodocno
                  AND xmfrseq = g_xmfp3_d_t.xmfrseq #項次 
                  
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfr_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfr_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp3_d[g_detail_idx].xmfrseq
                     LET gs_keys_bak[2] = g_xmfp3_d_t.xmfrseq
                     CALL axmt700_update_b('xmfr_t',gs_keys,gs_keys_bak,"'3'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfr_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp3_d[g_detail_idx].xmfrseq = g_xmfp3_d_t.xmfrseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp3_d_t.xmfrseq
                  CALL axmt700_key_update_b(gs_keys,'xmfr_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp3_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
            END IF

         AFTER FIELD xmfrseq

            IF NOT cl_ap_chk_range(g_xmfp3_d[l_ac].xmfrseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmfrseq
            END IF 
 
            IF g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp3_d[g_detail_idx].xmfrseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp3_d[g_detail_idx].xmfrseq != g_xmfp3_d_t.xmfrseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfr_t WHERE "||"xmfrent = '" ||g_enterprise|| "' AND "||"xmfrdocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmfrseq = '"||g_xmfp3_d[g_detail_idx].xmfrseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



         AFTER FIELD xmfr002
            
            LET g_xmfp3_d[l_ac].xmfr002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002_desc
            IF NOT cl_null(g_xmfp3_d[l_ac].xmfr002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp3_d[l_ac].xmfr002 != g_xmfp3_d_o.xmfr002 OR cl_null(g_xmfp3_d_o.xmfr002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp3_d[l_ac].xmfr002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp3_d[l_ac].xmfr003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp3_d[l_ac].xmfr002
                     CALL s_desc_get_department_desc(g_xmfp3_d[l_ac].xmfr003) RETURNING g_xmfp3_d[l_ac].xmfr003_desc
                     DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr003_desc 
                  ELSE
                     LET g_xmfp3_d[l_ac].xmfr002 = g_xmfp3_d_o.xmfr002
                     CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
                     DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002,g_xmfp3_d[l_ac].xmfr002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp3_d_o.xmfr002 = g_xmfp3_d[l_ac].xmfr002 
            END IF 

            
 

         AFTER FIELD xmfr003           

            LET  g_xmfp3_d[l_ac].xmfr003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp3_d[l_ac].xmfr003) RETURNING  g_xmfp3_d[l_ac].xmfr003_desc
            DISPLAY BY NAME  g_xmfp3_d[l_ac].xmfr003_desc 
            IF NOT cl_null( g_xmfp3_d[l_ac].xmfr003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp3_d[l_ac].xmfr003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp3_d[l_ac].xmfr003 =  g_xmfp3_d_o.xmfr003
                  CALL s_desc_get_department_desc( g_xmfp3_d[l_ac].xmfr003) RETURNING  g_xmfp3_d[l_ac].xmfr003_desc
                  DISPLAY BY NAME  g_xmfp3_d[l_ac].xmfr003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp3_d_o.xmfr003 =  g_xmfp3_d[l_ac].xmfr003               
            END IF
            
 
         ON ACTION controlp INFIELD xmfr002

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp3_d[l_ac].xmfr002             
            CALL q_ooag001()                              
            LET g_xmfp3_d[l_ac].xmfr002 = g_qryparam.return1          
            DISPLAY g_xmfp3_d[l_ac].xmfr002 TO xmfr002    
            NEXT FIELD xmfr002                        
            CALL s_desc_get_person_desc(g_xmfp3_d[l_ac].xmfr002) RETURNING g_xmfp3_d[l_ac].xmfr002_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr002_desc    

            #END add-point
 
         ON ACTION controlp INFIELD xmfr003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp3_d[l_ac].xmfr003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                                #呼叫開窗
            LET g_xmfp3_d[l_ac].xmfr003 = g_qryparam.return1              
            DISPLAY g_xmfp3_d[l_ac].xmfr003 TO xmfr003              #
            NEXT FIELD xmfr003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp3_d[l_ac].xmfr003) RETURNING g_xmfp3_d[l_ac].xmfr003_desc
            DISPLAY BY NAME g_xmfp3_d[l_ac].xmfr003_desc 

 
         AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp3_d[l_ac].* = g_xmfp3_d_t.*
               END IF
               CLOSE axmt700_bcl63
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF            
            #其他table進行unlock            
            CALL axmt700_unlock_b("xmfr_t","'3'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT

    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp3_d[li_reproduce_target].* = g_xmfp3_d[li_reproduce].*
 
               LET g_xmfp3_d[li_reproduce_target].xmfrseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp3_d.getLength()+1
            END IF
            
      END INPUT
      
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG     
   
END FUNCTION
################################################################################
# Descriptions...: 進入處理即改善對策頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmfs()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmfs()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1

   LET g_forupd_sql = "SELECT xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite FROM xmfs_t WHERE xmfsent=? AND xmfsdocno=? AND xmfsseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl64 CURSOR FROM g_forupd_sql
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      INPUT ARRAY g_xmfp4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         
         
         BEFORE INPUT

            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp4_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp4_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp4_d_t.* TO NULL 
            INITIALIZE g_xmfp4_d_o.* TO NULL 
            LET g_xmfp4_d_t.* = g_xmfp4_d[l_ac].*     #新輸入資料
            LET g_xmfp4_d_o.* = g_xmfp4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp4_d[li_reproduce_target].* = g_xmfp4_d[li_reproduce].*
 
               LET g_xmfp4_d[li_reproduce_target].xmfsseq = NULL
            END IF
            
            #項次加1
            SELECT MAX(xmfsseq)+1 INTO g_xmfp4_d[l_ac].xmfsseq FROM xmfs_t
             WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp4_d[l_ac].xmfsseq) OR g_xmfp4_d[l_ac].xmfsseq = 0 THEN
               LET g_xmfp4_d[l_ac].xmfsseq = 1
            END IF
            LET g_xmfp4_d[l_ac].xmfssite = g_xmfo_m.xmfosite


         BEFORE ROW     
 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 4
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN axmt700_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE axmt700_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_xmfp4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp4_d[l_ac].xmfsseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp4_d_t.* = g_xmfp4_d[l_ac].*  #BACKUP
               LET g_xmfp4_d_o.* = g_xmfp4_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)
               CALL axmt700_set_no_entry_b(l_cmd)
              #IF NOT axmt700_lock_b("xmfs_t","'4'") THEN
                
              OPEN axmt700_bcl64 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp4_d[g_detail_idx].xmfsseq
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL 
                 LET g_errparam.extend = "axmt700_bcl64" 
                 LET g_errparam.code   = SQLCA.sqlcode 
                 LET g_errparam.popup  = TRUE 
                 CALL cl_err()
                 LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl64 INTO g_xmfp4_d[l_ac].xmfsseq,g_xmfp4_d[l_ac].xmfs001,g_xmfp4_d[l_ac].xmfs002, 
                      g_xmfp4_d[l_ac].xmfs003,g_xmfp4_d[l_ac].xmfssite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp4_d_mask_o[l_ac].* =  g_xmfp4_d[l_ac].*
                  CALL axmt700_xmfs_t_mask()
                  LET g_xmfp4_d_mask_n[l_ac].* =  g_xmfp4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'

            ELSE
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
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp4_d_t.xmfsseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfs_t',gs_keys,"'4'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfs_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言             
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1   
               LET l_count = g_xmfp_d.getLength()              

            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp4_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmfs_t 
             WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
               AND xmfsseq = g_xmfp4_d[l_ac].xmfsseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN             
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp4_d[g_detail_idx].xmfsseq
               CALL axmt700_insert_b('xmfs_t',gs_keys,"'4'")
                           
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfs_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
               CLOSE axmt700_bcl64
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
            ELSE               
               #寫入修改者/修改日期資訊(單身4)                         
               #將遮罩欄位還原
               CALL axmt700_xmfs_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfs_t SET (xmfsdocno,xmfsseq,xmfs001,xmfs002,xmfs003,xmfssite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp4_d[l_ac].xmfsseq,g_xmfp4_d[l_ac].xmfs001,g_xmfp4_d[l_ac].xmfs002,g_xmfp4_d[l_ac].xmfs003, 
                   g_xmfp4_d[l_ac].xmfssite) #自訂欄位頁簽
                WHERE xmfsent = g_enterprise AND xmfsdocno = g_xmfo_m.xmfodocno
                  AND xmfsseq = g_xmfp4_d_t.xmfsseq #項次 
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfs_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfs_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp4_d[g_detail_idx].xmfsseq
                     LET gs_keys_bak[2] = g_xmfp4_d_t.xmfsseq
                     CALL axmt700_update_b('xmfs_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfs_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp4_d[g_detail_idx].xmfsseq = g_xmfp4_d_t.xmfsseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp4_d_t.xmfsseq
                  CALL axmt700_key_update_b(gs_keys,'xmfs_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp4_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
            END IF
         

         AFTER FIELD xmfsseq

            IF NOT cl_ap_chk_range(g_xmfp4_d[l_ac].xmfsseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmfsseq
            END IF 

            IF  g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp4_d[g_detail_idx].xmfsseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp4_d[g_detail_idx].xmfsseq != g_xmfp4_d_t.xmfsseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfs_t WHERE "||"xmfsent = '" ||g_enterprise|| "' AND "||"xmfsdocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmfsseq = '"||g_xmfp4_d[g_detail_idx].xmfsseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD xmfs002

            LET g_xmfp4_d[l_ac].xmfs002_desc = ''
            CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002_desc
            IF NOT cl_null(g_xmfp4_d[l_ac].xmfs002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xmfp4_d[l_ac].xmfs002 != g_xmfp4_d_o.xmfs002 OR cl_null(g_xmfp4_d[l_ac].xmfs002))) THEN
                  INITIALIZE g_chkparam.* TO NULL               
                  LET g_chkparam.arg1 = g_xmfp4_d[l_ac].xmfs002
                  #160318-00025#35  2016/05/15  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #160318-00025#35  2016/05/15  by pengxin  add(E)
                  IF cl_chk_exist("v_ooag001") THEN
                     SELECT ooag003 INTO g_xmfp4_d[l_ac].xmfs003 FROM ooag_t WHERE ooagent = g_enterprise AND ooag001 = g_xmfp4_d[l_ac].xmfs002
                     CALL s_desc_get_department_desc(g_xmfp4_d[l_ac].xmfs003) RETURNING g_xmfp4_d[l_ac].xmfs003_desc
                     DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs003_desc 
                  ELSE
                     LET g_xmfp4_d[l_ac].xmfs002 = g_xmfp4_d_o.xmfs002
                     CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
                     DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002,g_xmfp4_d[l_ac].xmfs002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
                LET g_xmfp4_d_o.xmfs002 = g_xmfp4_d[l_ac].xmfs002 
            END IF 
            
         AFTER FIELD xmfs003            

            LET  g_xmfp4_d[l_ac].xmfs003_desc = ''
            CALL s_desc_get_department_desc( g_xmfp4_d[l_ac].xmfs003) RETURNING  g_xmfp4_d[l_ac].xmfs003_desc
            DISPLAY BY NAME  g_xmfp4_d[l_ac].xmfs003_desc 
            IF NOT cl_null( g_xmfp4_d[l_ac].xmfs003) THEN 
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 =  g_xmfp4_d[l_ac].xmfs003
               LET g_chkparam.arg2 =  g_xmfo_m.xmfodocdt
               #160318-00025#35  2016/04/15  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#35  2016/04/15  by pengxin  add(E)
               IF NOT cl_chk_exist("v_ooeg001") THEN
                  LET  g_xmfp4_d[l_ac].xmfs003 =  g_xmfp4_d_o.xmfs003
                  CALL s_desc_get_department_desc( g_xmfp4_d[l_ac].xmfs003) RETURNING  g_xmfp4_d[l_ac].xmfs003_desc
                  DISPLAY BY NAME  g_xmfp4_d[l_ac].xmfs003_desc 
                  NEXT FIELD CURRENT            
               END IF 
               LET  g_xmfp4_d_o.xmfs003 =  g_xmfp4_d[l_ac].xmfs003               
            END IF

         ON ACTION controlp INFIELD xmfs002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp4_d[l_ac].xmfs002           
            CALL q_ooag001()                               
            LET g_xmfp4_d[l_ac].xmfs002 = g_qryparam.return1              
            DISPLAY g_xmfp4_d[l_ac].xmfs002 TO xmfs002           
            NEXT FIELD xmfs002                          
            CALL s_desc_get_person_desc(g_xmfp4_d[l_ac].xmfs002) RETURNING g_xmfp4_d[l_ac].xmfs002_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs002_desc    


         ON ACTION controlp INFIELD xmfs003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmfp4_d[l_ac].xmfs003             #給予default值
            LET g_qryparam.arg1 = g_xmfo_m.xmfodocdt 
            CALL q_ooeg001()                              
            LET g_xmfp4_d[l_ac].xmfs003 = g_qryparam.return1              
            DISPLAY g_xmfp4_d[l_ac].xmfs003 TO xmfs003             
            NEXT FIELD xmfs003                          #返回原欄位
            CALL s_desc_get_department_desc(g_xmfp4_d[l_ac].xmfs003) RETURNING g_xmfp4_d[l_ac].xmfs003_desc
            DISPLAY BY NAME g_xmfp4_d[l_ac].xmfs003_desc 

 
         AFTER ROW

            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp4_d[l_ac].* = g_xmfp4_d_t.*
               END IF
               CLOSE axmt700_bcl64
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF            
            #其他table進行unlock            
            CALL axmt700_unlock_b("xmfs_t","'4'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT
 
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp4_d[li_reproduce_target].* = g_xmfp4_d[li_reproduce].*
 
               LET g_xmfp4_d[li_reproduce_target].xmfsseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp4_d.getLength()+1
            END IF
            
      END INPUT

      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG  
END FUNCTION
################################################################################
# Descriptions...: 進入處理即審核紀錄頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmft()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmft()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1
 
   LET g_forupd_sql = "SELECT xmftseq,xmft001,xmft002,xmftsite FROM xmft_t WHERE xmftent=? AND xmftdocno=? AND xmftseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl65 CURSOR FROM g_forupd_sql

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_xmfp5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)                

         
         
         BEFORE INPUT

            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp5_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'5',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp5_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp5_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp5_d_t.* TO NULL 
            INITIALIZE g_xmfp5_d_o.* TO NULL 
            LET g_xmfp5_d_t.* = g_xmfp5_d[l_ac].*     #新輸入資料
            LET g_xmfp5_d_o.* = g_xmfp5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp5_d[li_reproduce_target].* = g_xmfp5_d[li_reproduce].* 
               LET g_xmfp5_d[li_reproduce_target].xmftseq = NULL
            END IF            

            #項次加1
            SELECT MAX(xmftseq)+1 INTO g_xmfp5_d[l_ac].xmftseq FROM xmft_t
             WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp5_d[l_ac].xmftseq) OR g_xmfp5_d[l_ac].xmftseq = 0 THEN
               LET g_xmfp5_d[l_ac].xmftseq = 1
            END IF
            LET g_xmfp5_d[l_ac].xmftsite = g_xmfo_m.xmfosite
  
         BEFORE ROW     
  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 5              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
           #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
           #IF STATUS THEN
           #   INITIALIZE g_errparam TO NULL 
           #   LET g_errparam.extend = "OPEN axmt700_cl:" 
           #   LET g_errparam.code   = STATUS 
           #   LET g_errparam.popup  = TRUE 
           #   CALL cl_err()
           #   CLOSE axmt700_cl
           #   CALL s_transaction_end('N','0')
           #   RETURN
           #END IF
            
            LET g_rec_b = g_xmfp5_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp5_d[l_ac].xmftseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp5_d_t.* = g_xmfp5_d[l_ac].*  #BACKUP
               LET g_xmfp5_d_o.* = g_xmfp5_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd) 
               CALL axmt700_set_no_entry_b(l_cmd)
              #IF NOT axmt700_lock_b("xmft_t","'5'") THEN    
               OPEN axmt700_bcl65 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp5_d[g_detail_idx].xmftseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt700_bcl65" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'              
               ELSE
                  FETCH axmt700_bcl65 INTO g_xmfp5_d[l_ac].xmftseq,g_xmfp5_d[l_ac].xmft001,g_xmfp5_d[l_ac].xmft002, 
                      g_xmfp5_d[l_ac].xmftsite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp5_d_mask_o[l_ac].* =  g_xmfp5_d[l_ac].*
                  CALL axmt700_xmft_t_mask()
                  LET g_xmfp5_d_mask_n[l_ac].* =  g_xmfp5_d[l_ac].*                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp5_d_t.xmftseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmft_t',gs_keys,"'5'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmft_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言                         
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1              
               LET l_count = g_xmfp_d.getLength()               
            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp5_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmft_t 
             WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
               AND xmftseq = g_xmfp5_d[l_ac].xmftseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp5_d[g_detail_idx].xmftseq
               CALL axmt700_insert_b('xmft_t',gs_keys,"'5'")
                           
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmft_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改               
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
               CLOSE axmt700_bcl65
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
            ELSE               
               #寫入修改者/修改日期資訊(單身5)                        
               #將遮罩欄位還原
               CALL axmt700_xmft_t_mask_restore('restore_mask_o')
                              
               UPDATE xmft_t SET (xmftdocno,xmftseq,xmft001,xmft002,xmftsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp5_d[l_ac].xmftseq,g_xmfp5_d[l_ac].xmft001,g_xmfp5_d[l_ac].xmft002,g_xmfp5_d[l_ac].xmftsite)  
                   #自訂欄位頁簽
                WHERE xmftent = g_enterprise AND xmftdocno = g_xmfo_m.xmfodocno
                  AND xmftseq = g_xmfp5_d_t.xmftseq #項次 
                                    
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmft_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmft_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp5_d[g_detail_idx].xmftseq
                     LET gs_keys_bak[2] = g_xmfp5_d_t.xmftseq
                     CALL axmt700_update_b('xmft_t',gs_keys,gs_keys_bak,"'5'")
                     #資料多語言用-增/改                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmft_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp5_d[g_detail_idx].xmftseq = g_xmfp5_d_t.xmftseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp5_d_t.xmftseq
                  CALL axmt700_key_update_b(gs_keys,'xmft_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp5_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp5_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF               
            END IF
    

         AFTER FIELD xmftseq
            IF NOT cl_ap_chk_range(g_xmfp5_d[l_ac].xmftseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmftseq
            END IF 
 
            IF g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp5_d[g_detail_idx].xmftseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp5_d[g_detail_idx].xmftseq != g_xmfp5_d_t.xmftseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmft_t WHERE "||"xmftent = '" ||g_enterprise|| "' AND "||"xmftdocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmftseq = '"||g_xmfp5_d[g_detail_idx].xmftseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
 
 
         AFTER ROW

            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp5_d[l_ac].* = g_xmfp5_d_t.*
               END IF
               CLOSE axmt700_bcl65
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF            
            #其他table進行unlock            
            CALL axmt700_unlock_b("xmft_t","'5'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT
 
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp5_d[li_reproduce_target].* = g_xmfp5_d[li_reproduce].* 
               LET g_xmfp5_d[li_reproduce_target].xmftseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp5_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp5_d.getLength()+1
            END IF
            
      END INPUT
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG  



END FUNCTION
################################################################################
# Descriptions...: 進入處理即核決紀錄頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmfu()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmfu()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1

   LET g_forupd_sql = "SELECT xmfuseq,xmfu001,xmfu002,xmfusite FROM xmfu_t WHERE xmfuent=? AND xmfudocno=? AND xmfuseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl66 CURSOR FROM g_forupd_sql


   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_xmfp6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                         
         
         BEFORE INPUT

            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp6_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'6',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp6_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp6_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp6_d_t.* TO NULL 
            INITIALIZE g_xmfp6_d_o.* TO NULL 
            LET g_xmfp6_d_t.* = g_xmfp6_d[l_ac].*     #新輸入資料
            LET g_xmfp6_d_o.* = g_xmfp6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp6_d[li_reproduce_target].* = g_xmfp6_d[li_reproduce].* 
               LET g_xmfp6_d[li_reproduce_target].xmfuseq = NULL
            END IF

            #項次加1
            SELECT MAX(xmfuseq)+1 INTO g_xmfp6_d[l_ac].xmfuseq FROM xmfu_t
             WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp6_d[l_ac].xmfuseq) OR g_xmfp6_d[l_ac].xmfuseq = 0 THEN
               LET g_xmfp6_d[l_ac].xmfuseq = 1
            END IF
            LET g_xmfp6_d[l_ac].xmfusite = g_xmfo_m.xmfosite
  
         BEFORE ROW     
 
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 6              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN axmt700_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE axmt700_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_xmfp6_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp6_d[l_ac].xmfuseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp6_d_t.* = g_xmfp6_d[l_ac].*  #BACKUP
               LET g_xmfp6_d_o.* = g_xmfp6_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)

               CALL axmt700_set_no_entry_b(l_cmd)
              #IF NOT axmt700_lock_b("xmfu_t","'6'") THEN
               OPEN axmt700_bcl66 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp6_d[g_detail_idx].xmfuseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt700_bcl66" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  RETURN FALSE              
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl66 INTO g_xmfp6_d[l_ac].xmfuseq,g_xmfp6_d[l_ac].xmfu001,g_xmfp6_d[l_ac].xmfu002, 
                      g_xmfp6_d[l_ac].xmfusite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp6_d_mask_o[l_ac].* =  g_xmfp6_d[l_ac].*
                  CALL axmt700_xmfu_t_mask()
                  LET g_xmfp6_d_mask_n[l_ac].* =  g_xmfp6_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF

            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
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
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp6_d_t.xmfuseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfu_t',gs_keys,"'6'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfu_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF                  
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1               
               LET l_count = g_xmfp_d.getLength()               
            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp6_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmfu_t 
             WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
               AND xmfuseq = g_xmfp6_d[l_ac].xmfuseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp6_d[g_detail_idx].xmfuseq
               CALL axmt700_insert_b('xmfu_t',gs_keys,"'6'")                           
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfu_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改               
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
               CLOSE axmt700_bcl66
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
            ELSE               
               #寫入修改者/修改日期資訊(單身6)                          
               #將遮罩欄位還原
               CALL axmt700_xmfu_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfu_t SET (xmfudocno,xmfuseq,xmfu001,xmfu002,xmfusite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp6_d[l_ac].xmfuseq,g_xmfp6_d[l_ac].xmfu001,g_xmfp6_d[l_ac].xmfu002,g_xmfp6_d[l_ac].xmfusite)  
                   #自訂欄位頁簽
                WHERE xmfuent = g_enterprise AND xmfudocno = g_xmfo_m.xmfodocno
                  AND xmfuseq = g_xmfp6_d_t.xmfuseq #項次 
                  
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfu_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfu_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp6_d[g_detail_idx].xmfuseq
                     LET gs_keys_bak[2] = g_xmfp6_d_t.xmfuseq
                     CALL axmt700_update_b('xmfu_t',gs_keys,gs_keys_bak,"'6'")
                     #資料多語言用-增/改                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfu_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp6_d[g_detail_idx].xmfuseq = g_xmfp6_d_t.xmfuseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp6_d_t.xmfuseq
                  CALL axmt700_key_update_b(gs_keys,'xmfu_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp6_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp6_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF               
            END IF
         
                
         AFTER FIELD xmfuseq

            IF NOT cl_ap_chk_range(g_xmfp6_d[l_ac].xmfuseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmfuseq
            END IF 
 
            IF  g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp6_d[g_detail_idx].xmfuseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp6_d[g_detail_idx].xmfuseq != g_xmfp6_d_t.xmfuseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfu_t WHERE "||"xmfuent = '" ||g_enterprise|| "' AND "||"xmfudocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmfuseq = '"||g_xmfp6_d[g_detail_idx].xmfuseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
 
 
 
         AFTER ROW

            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp6_d[l_ac].* = g_xmfp6_d_t.*
               END IF
               CLOSE axmt700_bcl66
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF   

            CALL axmt700_unlock_b("xmfu_t","'6'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT
  
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp6_d[li_reproduce_target].* = g_xmfp6_d[li_reproduce].* 
               LET g_xmfp6_d[li_reproduce_target].xmfuseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp6_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp6_d.getLength()+1
            END IF
            
      END INPUT   
   
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG     
END FUNCTION
################################################################################
# Descriptions...: 進入處理即結案紀錄頁籤進行維護
# Memo...........:
# Usage..........: CALL axmt700_open_xmfv()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 150914 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_open_xmfv()
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
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

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete") 
                      
   LET g_errshow = 1
   
   LET g_forupd_sql = "SELECT xmfvseq,xmfv001,xmfv002,xmfvsite FROM xmfv_t WHERE xmfvent=? AND xmfvdocno=? AND xmfvseq=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axmt700_bcl67 CURSOR FROM g_forupd_sql

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT ARRAY g_xmfp7_d FROM s_detail7.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert,
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)                

         
         BEFORE INPUT

            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xmfp7_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axmt700_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'7',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_xmfp7_d.getLength()

            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xmfp7_d[l_ac].* TO NULL 
            INITIALIZE g_xmfp7_d_t.* TO NULL 
            INITIALIZE g_xmfp7_d_o.* TO NULL 
            LET g_xmfp7_d_t.* = g_xmfp7_d[l_ac].*     #新輸入資料
            LET g_xmfp7_d_o.* = g_xmfp7_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axmt700_set_entry_b(l_cmd)
            CALL axmt700_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xmfp7_d[li_reproduce_target].* = g_xmfp7_d[li_reproduce].*
 
               LET g_xmfp7_d[li_reproduce_target].xmfvseq = NULL
            END IF            

            #項次加1
            SELECT MAX(xmfvseq)+1 INTO g_xmfp7_d[l_ac].xmfvseq FROM xmfv_t
             WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
            IF cl_null(g_xmfp7_d[l_ac].xmfvseq) OR g_xmfp7_d[l_ac].xmfvseq = 0 THEN
               LET g_xmfp7_d[l_ac].xmfvseq = 1
            END IF
            LET g_xmfp7_d[l_ac].xmfvsite = g_xmfo_m.xmfosite

         BEFORE ROW     

            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 7
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            #OPEN axmt700_cl USING g_enterprise,g_xmfo_m.xmfodocno
            #IF STATUS THEN
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "OPEN axmt700_cl:" 
            #   LET g_errparam.code   = STATUS 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CLOSE axmt700_cl
            #   CALL s_transaction_end('N','0')
            #   RETURN
            #END IF
            
            LET g_rec_b = g_xmfp7_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_xmfp7_d[l_ac].xmfvseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_xmfp7_d_t.* = g_xmfp7_d[l_ac].*  #BACKUP
               LET g_xmfp7_d_o.* = g_xmfp7_d[l_ac].*  #BACKUP
               CALL axmt700_set_entry_b(l_cmd)

               CALL axmt700_set_no_entry_b(l_cmd)
              #IF NOT axmt700_lock_b("xmfv_t","'7'") THEN
               OPEN axmt700_bcl67 USING g_enterprise,g_xmfo_m.xmfodocno,g_xmfp7_d[g_detail_idx].xmfvseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "axmt700_bcl67" 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()              
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt700_bcl67 INTO g_xmfp7_d[l_ac].xmfvseq,g_xmfp7_d[l_ac].xmfv001,g_xmfp7_d[l_ac].xmfv002, 
                      g_xmfp7_d[l_ac].xmfvsite
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xmfp7_d_mask_o[l_ac].* =  g_xmfp7_d[l_ac].*
                  CALL axmt700_xmfv_t_mask()
                  LET g_xmfp7_d_mask_n[l_ac].* =  g_xmfp7_d[l_ac].*                  
                  LET g_bfill = "N"
                  CALL axmt700_show()
                  LET g_bfill = "Y"                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'

            ELSE
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
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_xmfo_m.xmfodocno
               LET gs_keys[gs_keys.getLength()+1] = g_xmfp7_d_t.xmfvseq
            
               #刪除同層單身
               IF NOT axmt700_delete_b('xmfv_t',gs_keys,"'7'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT axmt700_key_delete_b(gs_keys,'xmfv_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE axmt700_bcl
                  CANCEL DELETE
               END IF                
               
               CALL s_transaction_end('Y','0')
               CLOSE axmt700_bcl
               LET g_rec_b = g_rec_b-1
               
               LET l_count = g_xmfp_d.getLength()
               
            END IF 
            
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_xmfp7_d.getLength() + 1) THEN
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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xmfv_t 
             WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
               AND xmfvseq = g_xmfp7_d[l_ac].xmfvseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xmfo_m.xmfodocno
               LET gs_keys[2] = g_xmfp7_d[g_detail_idx].xmfvseq
               CALL axmt700_insert_b('xmfv_t',gs_keys,"'7'")                         
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_xmfp_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xmfv_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL axmt700_b_fill()
               #資料多語言用-增/改               
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
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
               LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
               CLOSE axmt700_bcl67
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
            ELSE                             
               #將遮罩欄位還原
               CALL axmt700_xmfv_t_mask_restore('restore_mask_o')
                              
               UPDATE xmfv_t SET (xmfvdocno,xmfvseq,xmfv001,xmfv002,xmfvsite) = (g_xmfo_m.xmfodocno, 
                   g_xmfp7_d[l_ac].xmfvseq,g_xmfp7_d[l_ac].xmfv001,g_xmfp7_d[l_ac].xmfv002,g_xmfp7_d[l_ac].xmfvsite)  
                   #自訂欄位頁簽
                WHERE xmfvent = g_enterprise AND xmfvdocno = g_xmfo_m.xmfodocno
                  AND xmfvseq = g_xmfp7_d_t.xmfvseq #項次             
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfv_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xmfv_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
                  OTHERWISE
                     INITIALIZE gs_keys TO NULL 
                     LET gs_keys[1] = g_xmfo_m.xmfodocno
                     LET gs_keys_bak[1] = g_xmfodocno_t
                     LET gs_keys[2] = g_xmfp7_d[g_detail_idx].xmfvseq
                     LET gs_keys_bak[2] = g_xmfp7_d_t.xmfvseq
                     CALL axmt700_update_b('xmfv_t',gs_keys,gs_keys_bak,"'7'")
                     #資料多語言用-增/改                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axmt700_xmfv_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_xmfp7_d[g_detail_idx].xmfvseq = g_xmfp7_d_t.xmfvseq 
                  ) THEN
                  LET gs_keys[01] = g_xmfo_m.xmfodocno
                  LET gs_keys[gs_keys.getLength()+1] = g_xmfp7_d_t.xmfvseq
                  CALL axmt700_key_update_b(gs_keys,'xmfv_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp7_d_t)
               LET g_log2 = util.JSON.stringify(g_xmfo_m),util.JSON.stringify(g_xmfp7_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF

            END IF
         

         AFTER FIELD xmfvseq

            IF NOT cl_ap_chk_range(g_xmfp7_d[l_ac].xmfvseq,"0","0","","","azz-00079",1) THEN
               NEXT FIELD xmfvseq
            END IF 

            IF  g_xmfo_m.xmfodocno IS NOT NULL AND g_xmfp7_d[g_detail_idx].xmfvseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmfo_m.xmfodocno != g_xmfodocno_t OR g_xmfp7_d[g_detail_idx].xmfvseq != g_xmfp7_d_t.xmfvseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmfv_t WHERE "||"xmfvent = '" ||g_enterprise|| "' AND "||"xmfvdocno = '"||g_xmfo_m.xmfodocno ||"' AND "|| "xmfvseq = '"||g_xmfp7_d[g_detail_idx].xmfvseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
 
 
         AFTER ROW

            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xmfp7_d[l_ac].* = g_xmfp7_d_t.*
               END IF
               CLOSE axmt700_bcl67
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL axmt700_unlock_b("xmfv_t","'7'")
            CALL s_transaction_end('Y','0')

 
         AFTER INPUT

    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xmfp7_d[li_reproduce_target].* = g_xmfp7_d[li_reproduce].*
 
               LET g_xmfp7_d[li_reproduce_target].xmfvseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xmfp7_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xmfp7_d.getLength()+1
            END IF
            
      END INPUT
      
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel      #在dialog button (放棄)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         CALL s_transaction_end('N','0')
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         CALL s_transaction_end('N','0')
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG        
   END DIALOG     

END FUNCTION
################################################################################
# Descriptions...: 轉RMA
# Memo...........: 單據已確認、未結案狀態且單頭處理方式=1.轉RMA(armt100)
# Usage..........: axmt700_produce_rma(p_xmfodocno)
#                  RETURNING r_success
# Input parameter: p_xmfodocno    單據編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/09/15 By  Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_produce_rma(p_xmfodocno)
DEFINE  p_xmfodocno  LIKE xmfo_t.xmfodocno
#161109-00085#9-mod-s
#DEFINE  l_xmfo       RECORD LIKE xmfo_t.*   #161109-00085#9   mark
DEFINE  l_xmfo       RECORD  #客訴單單頭檔
       xmfoent LIKE xmfo_t.xmfoent, #企業編號
       xmfosite LIKE xmfo_t.xmfosite, #營運據點
       xmfodocno LIKE xmfo_t.xmfodocno, #客訴單號
       xmfodocdt LIKE xmfo_t.xmfodocdt, #客訴日期
       xmfo001 LIKE xmfo_t.xmfo001, #處理期限
       xmfo002 LIKE xmfo_t.xmfo002, #結案日期
       xmfo003 LIKE xmfo_t.xmfo003, #處理人員
       xmfo004 LIKE xmfo_t.xmfo004, #處理部門
       xmfo005 LIKE xmfo_t.xmfo005, #客戶編號
       xmfo006 LIKE xmfo_t.xmfo006, #出貨單號
       xmfo007 LIKE xmfo_t.xmfo007, #出貨項次
       xmfo008 LIKE xmfo_t.xmfo008, #訂單單號
       xmfo009 LIKE xmfo_t.xmfo009, #訂單項次
       xmfo010 LIKE xmfo_t.xmfo010, #訂單項序
       xmfo011 LIKE xmfo_t.xmfo011, #訂單分批序
       xmfo012 LIKE xmfo_t.xmfo012, #產品編號
       xmfo013 LIKE xmfo_t.xmfo013, #產品特徵
       xmfo014 LIKE xmfo_t.xmfo014, #客訴數量
       xmfo015 LIKE xmfo_t.xmfo015, #單位
       xmfo016 LIKE xmfo_t.xmfo016, #處理方式
       xmfo017 LIKE xmfo_t.xmfo017, #RMA/銷退單號
       xmfo018 LIKE xmfo_t.xmfo018, #備註
       xmfoownid LIKE xmfo_t.xmfoownid, #資料所有者
       xmfoowndp LIKE xmfo_t.xmfoowndp, #資料所屬部門
       xmfocrtid LIKE xmfo_t.xmfocrtid, #資料建立者
       xmfocrtdp LIKE xmfo_t.xmfocrtdp, #資料建立部門
       xmfocrtdt LIKE xmfo_t.xmfocrtdt, #資料創建日
       xmfomodid LIKE xmfo_t.xmfomodid, #資料修改者
       xmfomoddt LIKE xmfo_t.xmfomoddt, #最近修改日
       xmfocnfid LIKE xmfo_t.xmfocnfid, #資料確認者
       xmfocnfdt LIKE xmfo_t.xmfocnfdt, #資料確認日
       xmfopstid LIKE xmfo_t.xmfopstid, #資料過帳者
       xmfopstdt LIKE xmfo_t.xmfopstdt, #資料過帳日
       xmfostus LIKE xmfo_t.xmfostus #狀態碼
          END RECORD
#161109-00085#9-mod-e
#161109-00085#9-mod-s
#DEFINE  l_rmaa       RECORD LIKE rmaa_t.*   #161109-00085#9   mark
DEFINE  l_rmaa       RECORD  #RMA維護單單頭檔
       rmaaent LIKE rmaa_t.rmaaent, #企業編號
       rmaasite LIKE rmaa_t.rmaasite, #營運據點
       rmaadocno LIKE rmaa_t.rmaadocno, #單據單號
       rmaadocdt LIKE rmaa_t.rmaadocdt, #單據日期
       rmaa001 LIKE rmaa_t.rmaa001, #客戶編號
       rmaa002 LIKE rmaa_t.rmaa002, #業務人員
       rmaa003 LIKE rmaa_t.rmaa003, #業務部門
       rmaa004 LIKE rmaa_t.rmaa004, #客訴單號
       rmaa005 LIKE rmaa_t.rmaa005, #出貨單號
       rmaa006 LIKE rmaa_t.rmaa006, #訂單單號
       rmaa007 LIKE rmaa_t.rmaa007, #問題描述
       rmaaownid LIKE rmaa_t.rmaaownid, #資料所有者
       rmaaowndp LIKE rmaa_t.rmaaowndp, #資料所屬部門
       rmaacrtid LIKE rmaa_t.rmaacrtid, #資料建立者
       rmaacrtdp LIKE rmaa_t.rmaacrtdp, #資料建立部門
       rmaacrtdt LIKE rmaa_t.rmaacrtdt, #資料創建日
       rmaamodid LIKE rmaa_t.rmaamodid, #資料修改者
       rmaamoddt LIKE rmaa_t.rmaamoddt, #最近修改日
       rmaacnfid LIKE rmaa_t.rmaacnfid, #資料確認者
       rmaacnfdt LIKE rmaa_t.rmaacnfdt, #資料確認日
       rmaastus LIKE rmaa_t.rmaastus, #狀態碼
       rmaa008 LIKE rmaa_t.rmaa008, #扣帳日期
       rmaapstid LIKE rmaa_t.rmaapstid, #資料過帳者
       rmaapstdt LIKE rmaa_t.rmaapstdt #資料過帳日
          END RECORD
#161109-00085#9-mod-e
#161109-00085#9-mod-s
#DEFINE  l_rmab       RECORD LIKE rmab_t.*   #161109-00085#9   mark
DEFINE  l_rmab       RECORD  #RMA維護單身檔
       rmabent LIKE rmab_t.rmabent, #企業編號
       rmabsite LIKE rmab_t.rmabsite, #營運據點
       rmabdocno LIKE rmab_t.rmabdocno, #單據單號
       rmabseq LIKE rmab_t.rmabseq, #項次
       rmab001 LIKE rmab_t.rmab001, #客訴單號
       rmab002 LIKE rmab_t.rmab002, #客訴項次
       rmab003 LIKE rmab_t.rmab003, #出貨單號
       rmab004 LIKE rmab_t.rmab004, #出貨項次
       rmab005 LIKE rmab_t.rmab005, #訂單單號
       rmab006 LIKE rmab_t.rmab006, #訂單項次
       rmab007 LIKE rmab_t.rmab007, #訂單項序
       rmab008 LIKE rmab_t.rmab008, #訂單分批序
       rmab009 LIKE rmab_t.rmab009, #料號
       rmab010 LIKE rmab_t.rmab010, #產品特徵
       rmab011 LIKE rmab_t.rmab011, #單位
       rmab012 LIKE rmab_t.rmab012, #申請退貨數量
       rmab013 LIKE rmab_t.rmab013, #點收數量
       rmab014 LIKE rmab_t.rmab014, #已轉維修數量
       rmab015 LIKE rmab_t.rmab015, #已轉銷退數量
       rmab016 LIKE rmab_t.rmab016, #覆出數量
       rmab017 LIKE rmab_t.rmab017, #備註
       rmab018 LIKE rmab_t.rmab018, #序號
       rmab019 LIKE rmab_t.rmab019, #生產日期
       rmab020 LIKE rmab_t.rmab020 #有效日期
          END RECORD
#161109-00085#9-mod-e
#161109-00085#9-mod-s
#DEFINE  l_rmac       RECORD LIKE rmac_t.*  #161109-00085#9   mark
DEFINE  l_rmac       RECORD  #RMA維護單點收檔
       rmacent LIKE rmac_t.rmacent, #企業編號
       rmacsite LIKE rmac_t.rmacsite, #營運據點
       rmacdocno LIKE rmac_t.rmacdocno, #單據單號
       rmacseq LIKE rmac_t.rmacseq, #項次
       rmacseq1 LIKE rmac_t.rmacseq1, #項序
       rmac001 LIKE rmac_t.rmac001, #點收數量
       rmac002 LIKE rmac_t.rmac002, #庫位
       rmac003 LIKE rmac_t.rmac003, #儲位
       rmac004 LIKE rmac_t.rmac004, #批號
       rmac005 LIKE rmac_t.rmac005, #庫存特徵
       rmac006 LIKE rmac_t.rmac006, #點收日期
       rmac007 LIKE rmac_t.rmac007  #點收人員
          END RECORD
#161109-00085#9-mod-e
DEFINE  l_docno      LIKE rmaa_t.rmaadocno
DEFINE  l_cnt        LIKE type_t.num5
DEFINE  l_success    LIKE type_t.num5
DEFINE  r_success    LIKE type_t.num5



   LET r_success = TRUE

   
   INITIALIZE l_xmfo.* TO NULL
   INITIALIZE l_rmaa.* TO NULL
   INITIALIZE l_rmab.* TO NULL
   INITIALIZE l_rmac.* TO NULL
   
   IF cl_null(p_xmfodocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_xmfodocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success  
   END IF

   #檢查是否有已對應的RMA單
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM rmaa_t,rmab_t
    WHERE rmaaent = rmabent
      AND rmaadocno = rmabdocno
      AND rmaastus <> 'X'
      AND rmabent = g_enterprise
      AND rmab001 = p_xmfodocno
#      AND rmab002 = 0     #160714-00003#1 zhujing mod
   IF l_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'arm-00034'
      LET g_errparam.extend = p_xmfodocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success    
   END IF
   
   #依據aooi210所設置的訂單對應的RMA單別
   CALL s_aooi210_get_doc(g_site,'',4,p_xmfodocno,'armt100','arm-00035')   
        RETURNING l_success,l_docno
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success  
   END IF  
   
   IF cl_null(l_docno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00122'
      LET g_errparam.extend = p_xmfodocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF 
   
   #取單號
   CALL s_aooi200_gen_docno(g_site,l_docno,g_today,'armt100') RETURNING l_success,l_rmaa.rmaadocno
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00003'
      LET g_errparam.extend = p_xmfodocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success       
   END IF 
   #161109-00085#9-mod-s
#   SELECT * INTO l_xmfo.* FROM xmfo_t   #161109-00085#9-mark
   SELECT xmfoent,xmfosite,xmfodocno,xmfodocdt,xmfo001,xmfo002,xmfo003,xmfo004,xmfo005,xmfo006,xmfo007,xmfo008,xmfo009,
          xmfo010,xmfo011,xmfo012,xmfo013,xmfo014,xmfo015,xmfo016,xmfo017,xmfo018,xmfoownid,xmfoowndp,xmfocrtid,xmfocrtdp,
          xmfocrtdt,xmfomodid,xmfomoddt,xmfocnfid,xmfocnfdt,xmfopstid,xmfopstdt,xmfostus 
      INTO l_xmfo.xmfoent,l_xmfo.xmfosite,l_xmfo.xmfodocno,l_xmfo.xmfodocdt,l_xmfo.xmfo001,l_xmfo.xmfo002,l_xmfo.xmfo003,
           l_xmfo.xmfo004,l_xmfo.xmfo005,l_xmfo.xmfo006,l_xmfo.xmfo007,l_xmfo.xmfo008,l_xmfo.xmfo009,l_xmfo.xmfo010,
           l_xmfo.xmfo011,l_xmfo.xmfo012,l_xmfo.xmfo013,l_xmfo.xmfo014,l_xmfo.xmfo015,l_xmfo.xmfo016,l_xmfo.xmfo017,
           l_xmfo.xmfo018,l_xmfo.xmfoownid,l_xmfo.xmfoowndp,l_xmfo.xmfocrtid,l_xmfo.xmfocrtdp,l_xmfo.xmfocrtdt,
           l_xmfo.xmfomodid,l_xmfo.xmfomoddt,l_xmfo.xmfocnfid,l_xmfo.xmfocnfdt,l_xmfo.xmfopstid,l_xmfo.xmfopstdt,l_xmfo.xmfostus 
      FROM xmfo_t
   #161109-00085#9-mod-e
    WHERE xmfoent = g_enterprise
      AND xmfodocno = p_xmfodocno      
   
   LET l_rmaa.rmaadocdt = g_today          #登記日期
   LET l_rmaa.rmaa001 = l_xmfo.xmfo005     #客戶編號
   LET l_rmaa.rmaa004 = l_xmfo.xmfodocno   #客訴單號
   LET l_rmaa.rmaa005 = l_xmfo.xmfo006     #出貨單號 
   LET l_rmaa.rmaa006 = l_xmfo.xmfo008     #訂單單號  
   #業務部門、業務人員
   IF NOT cl_null(l_rmaa.rmaa005) THEN
      SELECT xmdk003,xmdk004
        INTO l_rmaa.rmaa002,l_rmaa.rmaa003
        FROM xmdk_t
       WHERE xmdkent = g_enterprise
         AND xmdkdocno = l_rmaa.rmaa005
   ELSE
      SELECT pmab081,pmab109 
        INTO l_rmaa.rmaa002,l_rmaa.rmaa003
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = g_site
         AND pmab001 = l_rmaa.rmaa001        
   END IF

   LET l_rmaa.rmaaent = g_enterprise
   LET l_rmaa.rmaasite = g_site
   LET l_rmaa.rmaaownid = g_user
   LET l_rmaa.rmaaowndp = g_dept
   LET l_rmaa.rmaacrtid = g_user
   LET l_rmaa.rmaacrtdp = g_dept
   LET l_rmaa.rmaacrtdt = cl_get_current()
   LET l_rmaa.rmaamodid = g_user
   LET l_rmaa.rmaamoddt = cl_get_current()
   LET l_rmaa.rmaastus = 'N' 
   
   LET l_rmaa.rmaa008 = g_today
   IF cl_null(l_rmaa.rmaa002) THEN
      LET l_rmaa.rmaa002 = g_user
   END IF
   IF cl_null(l_rmaa.rmaa003) THEN 
      LET l_rmaa.rmaa003 = g_dept   
   END IF   
   
   INSERT INTO rmaa_t (rmaaent,rmaasite,rmaadocdt,rmaastus,rmaadocno,
                       rmaa001, rmaa002,  rmaa003, rmaa004,  rmaa005,
                       rmaa006, rmaa007,  rmaa008,rmaaownid,rmaaowndp,
                       rmaacrtid,rmaacrtdp,rmaacrtdt,rmaamodid,rmaamoddt)
             VALUES (  l_rmaa.rmaaent,l_rmaa.rmaasite, l_rmaa.rmaadocdt, l_rmaa.rmaastus,l_rmaa.rmaadocno,
                       l_rmaa.rmaa001,  l_rmaa.rmaa002,  l_rmaa.rmaa003,  l_rmaa.rmaa004,  l_rmaa.rmaa005,
                       l_rmaa.rmaa006,  l_rmaa.rmaa007,  l_rmaa.rmaa008,l_rmaa.rmaaownid,l_rmaa.rmaaowndp,
                     l_rmaa.rmaacrtid,l_rmaa.rmaacrtdp,l_rmaa.rmaacrtdt,l_rmaa.rmaamodid,l_rmaa.rmaamoddt)          
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT INTO rmaa_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #產生單身檔
   LET l_rmab.rmabent = g_enterprise
   LET l_rmab.rmabsite = g_site
   LET l_rmab.rmabdocno = l_rmaa.rmaadocno
   LET l_rmab.rmabseq = 1                    #項次
   LET l_rmab.rmab001 = l_xmfo.xmfodocno     #客訴單號 
   LET l_rmab.rmab002 = 0 
   LET l_rmab.rmab003 = l_xmfo.xmfo006       #出貨單號
   LET l_rmab.rmab004 = l_xmfo.xmfo007       #出貨項次 
   LET l_rmab.rmab005 = l_xmfo.xmfo008       #訂單單號 
   LET l_rmab.rmab006 = l_xmfo.xmfo009       #訂單項次 
   LET l_rmab.rmab007 = l_xmfo.xmfo010       #訂單項序 
   LET l_rmab.rmab008 = l_xmfo.xmfo011       #分批序
   LET l_rmab.rmab009 = l_xmfo.xmfo012       #料號 
   LET l_rmab.rmab010 = l_xmfo.xmfo013       #產品特徵 
   LET l_rmab.rmab011 = l_xmfo.xmfo015       #單位 
   LET l_rmab.rmab012 = l_xmfo.xmfo014       #申請退貨數量 
   LET l_rmab.rmab013 = l_xmfo.xmfo014       #點收數量 
   LET l_rmab.rmab014 = 0                    #已轉維修數量 
   LET l_rmab.rmab015 = 0                    #已轉銷退數量 
   LET l_rmab.rmab016 = 0                    #覆出數量    

   INSERT INTO rmab_t
               (rmabent,rmabsite,rmabdocno,rmabseq,
                rmab001,rmab002,rmab003,rmab004,rmab005,
                rmab006,rmab007,rmab008,rmab009,rmab010,
                rmab011,rmab012,rmab013,rmab014,rmab015,
                rmab016)
      VALUES ( l_rmab.rmabent, l_rmab.rmabsite,l_rmab.rmabdocno, l_rmab.rmabseq,
               l_rmab.rmab001, l_rmab.rmab002, l_rmab.rmab003,   l_rmab.rmab004, l_rmab.rmab005,
               l_rmab.rmab006, l_rmab.rmab007, l_rmab.rmab008,   l_rmab.rmab009, l_rmab.rmab010,
               l_rmab.rmab011, l_rmab.rmab012, l_rmab.rmab013,   l_rmab.rmab014, l_rmab.rmab015,
               l_rmab.rmab016)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT INTO rmab_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
   
   #產生退品點收檔
   LET l_rmac.rmacent = g_enterprise
   LET l_rmac.rmacsite = g_site
   LET l_rmac.rmacdocno = l_rmaa.rmaadocno
   LET l_rmac.rmacseq = l_rmab.rmabseq            #項次
   LET l_rmac.rmacseq1 = 1                        #項序
   LET l_rmac.rmac001 = l_xmfo.xmfo014            #點收數量 
   LET l_rmac.rmac002 = ' '                       #庫位 
   LET l_rmac.rmac003 = ' '                       #儲位
   LET l_rmac.rmac004 = ' '                       #批號
   LET l_rmac.rmac005 = ' '                       #庫存特徵
   INSERT INTO rmac_t(rmacent,rmacdocno,rmacseq,rmacseq1,
                      rmac001,rmac002,rmac003,rmac004,rmac005,
                      rmac006,rmac007,rmacsite)
      VALUES(l_rmac.rmacent,l_rmac.rmacdocno,l_rmac.rmacseq,l_rmac.rmacseq1,
             l_rmac.rmac001,l_rmac.rmac002,l_rmac.rmac003,l_rmac.rmac004,l_rmac.rmac005,
             l_rmac.rmac006,l_rmac.rmac007,l_rmac.rmacsite)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "INSERT INTO rmab_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF NOT s_armt100_conf_chk(l_rmaa.rmaadocno) THEN
      LET r_success = FALSE
      RETURN r_success    
   END IF 
   IF NOT s_armt100_conf_upd(l_rmaa.rmaadocno) THEN
      LET r_success = FALSE
      RETURN r_success    
   END IF
   UPDATE xmfo_t
      SET xmfo017 = l_rmaa.rmaadocno
    WHERE xmfoent = g_enterprise
      AND xmfodocno = p_xmfodocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "UPDATE xmfo_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success      
   END IF 
   
 
   RETURN r_success      

END FUNCTION
################################################################################
# Descriptions...: 轉銷退
# Memo...........: 單據已確認、未結案狀態且單頭處理方式=2.轉銷退(axmt600)
# Usage..........: axmt700_produce_xmdk(p_xmfodocno)
#                  RETURNING r_success
# Input parameter: p_xmfodocno    單據編號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/09/15 By  Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_produce_xmdk(p_xmfodocno)
	DEFINE  p_xmfodocno  LIKE xmfo_t.xmfodocno
	#161109-00085#9-mod-s
	#DEFINE  l_xmfo       RECORD LIKE xmfo_t.*   #161109-00085#9   mark
   DEFINE  l_xmfo       RECORD  #客訴單單頭檔
       xmfoent LIKE xmfo_t.xmfoent, #企業編號
       xmfosite LIKE xmfo_t.xmfosite, #營運據點
       xmfodocno LIKE xmfo_t.xmfodocno, #客訴單號
       xmfodocdt LIKE xmfo_t.xmfodocdt, #客訴日期
       xmfo001 LIKE xmfo_t.xmfo001, #處理期限
       xmfo002 LIKE xmfo_t.xmfo002, #結案日期
       xmfo003 LIKE xmfo_t.xmfo003, #處理人員
       xmfo004 LIKE xmfo_t.xmfo004, #處理部門
       xmfo005 LIKE xmfo_t.xmfo005, #客戶編號
       xmfo006 LIKE xmfo_t.xmfo006, #出貨單號
       xmfo007 LIKE xmfo_t.xmfo007, #出貨項次
       xmfo008 LIKE xmfo_t.xmfo008, #訂單單號
       xmfo009 LIKE xmfo_t.xmfo009, #訂單項次
       xmfo010 LIKE xmfo_t.xmfo010, #訂單項序
       xmfo011 LIKE xmfo_t.xmfo011, #訂單分批序
       xmfo012 LIKE xmfo_t.xmfo012, #產品編號
       xmfo013 LIKE xmfo_t.xmfo013, #產品特徵
       xmfo014 LIKE xmfo_t.xmfo014, #客訴數量
       xmfo015 LIKE xmfo_t.xmfo015, #單位
       xmfo016 LIKE xmfo_t.xmfo016, #處理方式
       xmfo017 LIKE xmfo_t.xmfo017, #RMA/銷退單號
       xmfo018 LIKE xmfo_t.xmfo018, #備註
       xmfoownid LIKE xmfo_t.xmfoownid, #資料所有者
       xmfoowndp LIKE xmfo_t.xmfoowndp, #資料所屬部門
       xmfocrtid LIKE xmfo_t.xmfocrtid, #資料建立者
       xmfocrtdp LIKE xmfo_t.xmfocrtdp, #資料建立部門
       xmfocrtdt LIKE xmfo_t.xmfocrtdt, #資料創建日
       xmfomodid LIKE xmfo_t.xmfomodid, #資料修改者
       xmfomoddt LIKE xmfo_t.xmfomoddt, #最近修改日
       xmfocnfid LIKE xmfo_t.xmfocnfid, #資料確認者
       xmfocnfdt LIKE xmfo_t.xmfocnfdt, #資料確認日
       xmfopstid LIKE xmfo_t.xmfopstid, #資料過帳者
       xmfopstdt LIKE xmfo_t.xmfopstdt, #資料過帳日
       xmfostus LIKE xmfo_t.xmfostus #狀態碼
          END RECORD
#161109-00085#9-mod-e	
	#161109-00085#9-mod-s
	#DEFINE  l_xmdk       RECORD LIKE xmdk_t.*   #161109-00085#9   mark
	DEFINE  l_xmdk       RECORD  #出貨/簽收/銷退單單頭檔
       xmdkent LIKE xmdk_t.xmdkent, #企業編號
       xmdksite LIKE xmdk_t.xmdksite, #營運據點
       xmdkunit LIKE xmdk_t.xmdkunit, #應用組織
       xmdkdocno LIKE xmdk_t.xmdkdocno, #單據單號
       xmdkdocdt LIKE xmdk_t.xmdkdocdt, #單據日期
       xmdk000 LIKE xmdk_t.xmdk000, #單據性質
       xmdk001 LIKE xmdk_t.xmdk001, #扣帳日期
       xmdk002 LIKE xmdk_t.xmdk002, #出貨性質
       xmdk003 LIKE xmdk_t.xmdk003, #業務人員
       xmdk004 LIKE xmdk_t.xmdk004, #業務部門
       xmdk005 LIKE xmdk_t.xmdk005, #出通/出貨單號
       xmdk006 LIKE xmdk_t.xmdk006, #訂單單號
       xmdk007 LIKE xmdk_t.xmdk007, #訂單客戶
       xmdk008 LIKE xmdk_t.xmdk008, #收款客戶
       xmdk009 LIKE xmdk_t.xmdk009, #收貨客戶
       xmdk010 LIKE xmdk_t.xmdk010, #收款條件
       xmdk011 LIKE xmdk_t.xmdk011, #交易條件
       xmdk012 LIKE xmdk_t.xmdk012, #稅別
       xmdk013 LIKE xmdk_t.xmdk013, #稅率
       xmdk014 LIKE xmdk_t.xmdk014, #單價含稅否
       xmdk015 LIKE xmdk_t.xmdk015, #發票類型
       xmdk016 LIKE xmdk_t.xmdk016, #幣別
       xmdk017 LIKE xmdk_t.xmdk017, #匯率
       xmdk018 LIKE xmdk_t.xmdk018, #取價方式
       xmdk019 LIKE xmdk_t.xmdk019, #優惠條件
       xmdk020 LIKE xmdk_t.xmdk020, #送貨供應商
       xmdk021 LIKE xmdk_t.xmdk021, #送貨地址
       xmdk022 LIKE xmdk_t.xmdk022, #運輸方式
       xmdk023 LIKE xmdk_t.xmdk023, #交運起點
       xmdk024 LIKE xmdk_t.xmdk024, #交運終點
       xmdk025 LIKE xmdk_t.xmdk025, #航次/航班/車號
       xmdk026 LIKE xmdk_t.xmdk026, #起運日期
       xmdk027 LIKE xmdk_t.xmdk027, #嘜頭編號
       xmdk028 LIKE xmdk_t.xmdk028, #包裝單製作
       xmdk029 LIKE xmdk_t.xmdk029, #Invoice製作
       xmdk030 LIKE xmdk_t.xmdk030, #銷售通路
       xmdk031 LIKE xmdk_t.xmdk031, #銷售分類
       xmdk032 LIKE xmdk_t.xmdk032, #結關日期
       xmdk033 LIKE xmdk_t.xmdk033, #額外品名規格
       xmdk034 LIKE xmdk_t.xmdk034, #留置原因
       xmdk035 LIKE xmdk_t.xmdk035, #多角序號
       xmdk036 LIKE xmdk_t.xmdk036, #整合單號
       xmdk037 LIKE xmdk_t.xmdk037, #發票號碼
       xmdk038 LIKE xmdk_t.xmdk038, #運輸狀態
       xmdk039 LIKE xmdk_t.xmdk039, #在途成本庫位
       xmdk040 LIKE xmdk_t.xmdk040, #在途非成本庫位
       xmdk041 LIKE xmdk_t.xmdk041, #發票編號
       xmdk042 LIKE xmdk_t.xmdk042, #內外銷
       xmdk043 LIKE xmdk_t.xmdk043, #匯率計算基準
       xmdk044 LIKE xmdk_t.xmdk044, #多角流程編號
       xmdk045 LIKE xmdk_t.xmdk045, #多角性質
       xmdk051 LIKE xmdk_t.xmdk051, #總未稅金額
       xmdk052 LIKE xmdk_t.xmdk052, #總含稅金額
       xmdk053 LIKE xmdk_t.xmdk053, #總稅額
       xmdk054 LIKE xmdk_t.xmdk054, #備註
       xmdk055 LIKE xmdk_t.xmdk055, #客戶收貨日
       xmdk081 LIKE xmdk_t.xmdk081, #對應的簽收單號
       xmdk082 LIKE xmdk_t.xmdk082, #銷退方式
       xmdk083 LIKE xmdk_t.xmdk083, #多角貿易已拋轉
       xmdk084 LIKE xmdk_t.xmdk084, #折讓證明單開立否
       xmdk200 LIKE xmdk_t.xmdk200, #調貨經銷商編號
       xmdk201 LIKE xmdk_t.xmdk201, #代送商編號
       xmdk202 LIKE xmdk_t.xmdk202, #發票客戶
       xmdk203 LIKE xmdk_t.xmdk203, #促銷方案編號
       xmdk204 LIKE xmdk_t.xmdk204, #整單折扣
       xmdk205 LIKE xmdk_t.xmdk205, #送貨站點編號
       xmdk206 LIKE xmdk_t.xmdk206, #運輸路線編號
       xmdk207 LIKE xmdk_t.xmdk207, #銷售組織
       xmdk208 LIKE xmdk_t.xmdk208, #調貨出貨單號
       xmdk209 LIKE xmdk_t.xmdk209, #No Use
       xmdk210 LIKE xmdk_t.xmdk210, #No Use
       xmdk211 LIKE xmdk_t.xmdk211, #No Use
       xmdk212 LIKE xmdk_t.xmdk212, #No Use
       xmdk213 LIKE xmdk_t.xmdk213, #本幣含稅總金額
       xmdk214 LIKE xmdk_t.xmdk214, #收款完成否
       xmdkownid LIKE xmdk_t.xmdkownid, #資料所屬者
       xmdkowndp LIKE xmdk_t.xmdkowndp, #資料所有部門
       xmdkcrtid LIKE xmdk_t.xmdkcrtid, #資料建立者
       xmdkcrtdp LIKE xmdk_t.xmdkcrtdp, #資料建立部門
       xmdkcrtdt LIKE xmdk_t.xmdkcrtdt, #資料創建日
       xmdkmodid LIKE xmdk_t.xmdkmodid, #資料修改者
       xmdkmoddt LIKE xmdk_t.xmdkmoddt, #最近修改日
       xmdkcnfid LIKE xmdk_t.xmdkcnfid, #資料確認者
       xmdkcnfdt LIKE xmdk_t.xmdkcnfdt, #資料確認日
       xmdkpstid LIKE xmdk_t.xmdkpstid, #資料過帳者
       xmdkpstdt LIKE xmdk_t.xmdkpstdt, #資料過帳日
       xmdkstus LIKE xmdk_t.xmdkstus, #狀態碼
       xmdk085 LIKE xmdk_t.xmdk085, #資料來源(銷退)
       xmdk086 LIKE xmdk_t.xmdk086, #來源單號(銷退)
       xmdk046 LIKE xmdk_t.xmdk046, #整合來源
       xmdk087 LIKE xmdk_t.xmdk087, #出貨走發票倉調撥
       xmdk047 LIKE xmdk_t.xmdk047, #一次性交易對象識別碼
       xmdk088 LIKE xmdk_t.xmdk088, #來源類型
       xmdk089 LIKE xmdk_t.xmdk089  #來源單號
          END RECORD
	#161109-00085#9-mod-e
	#161109-00085#9-mod-s
	#DEFINE  l_xmdl       RECORD LIKE xmdl_t.*   #161109-00085#9   mark
	DEFINE  l_xmdl       RECORD  #出貨/簽收/銷退單單身明細檔
       xmdlent LIKE xmdl_t.xmdlent, #企業編號
       xmdlsite LIKE xmdl_t.xmdlsite, #營運據點
       xmdldocno LIKE xmdl_t.xmdldocno, #單據編號
       xmdlseq LIKE xmdl_t.xmdlseq, #項次
       xmdl001 LIKE xmdl_t.xmdl001, #出通單號
       xmdl002 LIKE xmdl_t.xmdl002, #出通項次
       xmdl003 LIKE xmdl_t.xmdl003, #訂單單號
       xmdl004 LIKE xmdl_t.xmdl004, #訂單項次
       xmdl005 LIKE xmdl_t.xmdl005, #訂單項序
       xmdl006 LIKE xmdl_t.xmdl006, #訂單分批序
       xmdl007 LIKE xmdl_t.xmdl007, #子件特性
       xmdl008 LIKE xmdl_t.xmdl008, #料件編號
       xmdl009 LIKE xmdl_t.xmdl009, #產品特徵
       xmdl010 LIKE xmdl_t.xmdl010, #包裝容器
       xmdl011 LIKE xmdl_t.xmdl011, #作業編號
       xmdl012 LIKE xmdl_t.xmdl012, #作業序
       xmdl013 LIKE xmdl_t.xmdl013, #多庫儲批出貨
       xmdl014 LIKE xmdl_t.xmdl014, #庫位
       xmdl015 LIKE xmdl_t.xmdl015, #儲位
       xmdl016 LIKE xmdl_t.xmdl016, #批號
       xmdl017 LIKE xmdl_t.xmdl017, #出貨單位
       xmdl018 LIKE xmdl_t.xmdl018, #數量
       xmdl019 LIKE xmdl_t.xmdl019, #參考單位
       xmdl020 LIKE xmdl_t.xmdl020, #參考數量
       xmdl021 LIKE xmdl_t.xmdl021, #計價單位
       xmdl022 LIKE xmdl_t.xmdl022, #計價數量
       xmdl023 LIKE xmdl_t.xmdl023, #檢驗否
       xmdl024 LIKE xmdl_t.xmdl024, #單價
       xmdl025 LIKE xmdl_t.xmdl025, #稅別
       xmdl026 LIKE xmdl_t.xmdl026, #稅率
       xmdl027 LIKE xmdl_t.xmdl027, #未稅金額
       xmdl028 LIKE xmdl_t.xmdl028, #含稅金額
       xmdl029 LIKE xmdl_t.xmdl029, #稅額
       xmdl030 LIKE xmdl_t.xmdl030, #專案編號
       xmdl031 LIKE xmdl_t.xmdl031, #WBS編號
       xmdl032 LIKE xmdl_t.xmdl032, #活動編號
       xmdl033 LIKE xmdl_t.xmdl033, #客戶料號
       xmdl034 LIKE xmdl_t.xmdl034, #QPA
       xmdl035 LIKE xmdl_t.xmdl035, #已簽收量
       xmdl036 LIKE xmdl_t.xmdl036, #已簽退量
       xmdl037 LIKE xmdl_t.xmdl037, #已銷退量
       xmdl038 LIKE xmdl_t.xmdl038, #主帳套已立帳數量
       xmdl039 LIKE xmdl_t.xmdl039, #帳套二已立帳數量
       xmdl040 LIKE xmdl_t.xmdl040, #帳套三已立帳數量
       xmdl041 LIKE xmdl_t.xmdl041, #保稅否
       xmdl042 LIKE xmdl_t.xmdl042, #取價來源
       xmdl043 LIKE xmdl_t.xmdl043, #價格來源參考單號
       xmdl044 LIKE xmdl_t.xmdl044, #價格來源參考項次
       xmdl045 LIKE xmdl_t.xmdl045, #取出價格
       xmdl046 LIKE xmdl_t.xmdl046, #價差比
       xmdl047 LIKE xmdl_t.xmdl047, #已開發票數量
       xmdl048 LIKE xmdl_t.xmdl048, #發票編號
       xmdl049 LIKE xmdl_t.xmdl049, #發票號碼
       xmdl050 LIKE xmdl_t.xmdl050, #理由碼
       xmdl051 LIKE xmdl_t.xmdl051, #備註
       xmdl052 LIKE xmdl_t.xmdl052, #庫存管理特徵
       xmdl053 LIKE xmdl_t.xmdl053, #主帳套暫估數量
       xmdl054 LIKE xmdl_t.xmdl054, #帳套二暫估數量
       xmdl055 LIKE xmdl_t.xmdl055, #帳套三暫估數量
       xmdl081 LIKE xmdl_t.xmdl081, #簽退數量(簽收、簽退單使用)
       xmdl082 LIKE xmdl_t.xmdl082, #簽退參考數量(簽收、簽退單使用)
       xmdl083 LIKE xmdl_t.xmdl083, #簽退計價數量(簽收、簽退單使用)
       xmdl084 LIKE xmdl_t.xmdl084, #簽退理由碼(簽收、簽退單使用)
       xmdl085 LIKE xmdl_t.xmdl085, #訂單開立據點
       xmdl086 LIKE xmdl_t.xmdl086, #訂單多角性質
       xmdl087 LIKE xmdl_t.xmdl087, #需自立應收否
       xmdl088 LIKE xmdl_t.xmdl088, #多角流程編號
       xmdl089 LIKE xmdl_t.xmdl089, #QC單號
       xmdl090 LIKE xmdl_t.xmdl090, #判定項次
       xmdl091 LIKE xmdl_t.xmdl091, #判定結果
       xmdl092 LIKE xmdl_t.xmdl092, #借貨還量數量
       xmdl093 LIKE xmdl_t.xmdl093, #借貨還量參考數量
       xmdl200 LIKE xmdl_t.xmdl200, #銷售通路
       xmdl201 LIKE xmdl_t.xmdl201, #產品組編碼
       xmdl202 LIKE xmdl_t.xmdl202, #銷售範圍編碼
       xmdl203 LIKE xmdl_t.xmdl203, #銷售辦公室
       xmdl204 LIKE xmdl_t.xmdl204, #出貨包裝單位
       xmdl205 LIKE xmdl_t.xmdl205, #出貨包裝數量
       xmdl206 LIKE xmdl_t.xmdl206, #簽退包裝數量
       xmdl207 LIKE xmdl_t.xmdl207, #庫存鎖定等級
       xmdl208 LIKE xmdl_t.xmdl208, #標準價
       xmdl209 LIKE xmdl_t.xmdl209, #促銷價
       xmdl210 LIKE xmdl_t.xmdl210, #交易價
       xmdl211 LIKE xmdl_t.xmdl211, #折價金額
       xmdl212 LIKE xmdl_t.xmdl212, #銷售組織
       xmdl213 LIKE xmdl_t.xmdl213, #銷售人員
       xmdl214 LIKE xmdl_t.xmdl214, #銷售部門
       xmdl215 LIKE xmdl_t.xmdl215, #合約編號
       xmdl216 LIKE xmdl_t.xmdl216, #經營方式
       xmdl217 LIKE xmdl_t.xmdl217, #結算類型
       xmdl218 LIKE xmdl_t.xmdl218, #結算方式
       xmdl219 LIKE xmdl_t.xmdl219, #交易類型
       xmdl220 LIKE xmdl_t.xmdl220, #寄銷已核銷數量
       xmdl222 LIKE xmdl_t.xmdl222, #地區編號
       xmdl223 LIKE xmdl_t.xmdl223, #縣市編號
       xmdl224 LIKE xmdl_t.xmdl224, #省區編號
       xmdl225 LIKE xmdl_t.xmdl225, #區域編號
       xmdl226 LIKE xmdl_t.xmdl226, #商品條碼
       xmdlunit LIKE xmdl_t.xmdlunit, #應用組織
       xmdlorga LIKE xmdl_t.xmdlorga, #帳務組織
       xmdl056 LIKE xmdl_t.xmdl056, #檢驗合格量
       xmdl094 LIKE xmdl_t.xmdl094, #來源單號(銷退)
       xmdl095 LIKE xmdl_t.xmdl095, #項次(銷退)
       xmdl227 LIKE xmdl_t.xmdl227, #現金折扣單號
       xmdl228 LIKE xmdl_t.xmdl228, #現金折扣單項次
       xmdl057 LIKE xmdl_t.xmdl057, #有效日期
       xmdl058 LIKE xmdl_t.xmdl058, #製造日期
       xmdl096 LIKE xmdl_t.xmdl096, #來源項次
       xmdl059 LIKE xmdl_t.xmdl059, #客戶退貨量
       xmdl060 LIKE xmdl_t.xmdl060  #放行狀態
          END RECORD
	#161109-00085#9-mod-e
	DEFINE  l_docno      LIKE xmdk_t.xmdkdocno
   DEFINE  l_xrcd113    LIKE xrcd_t.xrcd113
   DEFINE  l_xrcd114    LIKE xrcd_t.xrcd114
   DEFINE  l_xrcd115    LIKE xrcd_t.xrcd115	
	DEFINE  l_cnt        LIKE type_t.num5
	DEFINE  l_success    LIKE type_t.num5
	DEFINE  r_success    LIKE type_t.num5

	
	
	   LET r_success = TRUE
      #計算金額建立tmptable
      CALL s_tax_recount_tmp()	   
	   
	   INITIALIZE l_xmfo.* TO NULL
	   INITIALIZE l_xmdk.* TO NULL
	   INITIALIZE l_xmdl.* TO NULL
	   
	   IF cl_null(p_xmfodocno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'sub-00228'
	      LET g_errparam.extend = p_xmfodocno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF
	
	   #檢查是否有已對應的銷退單
	   LET l_cnt = 0
	   SELECT COUNT(*) INTO l_cnt
	     FROM xmdk_t,xmdl_t
	    WHERE xmdkent = xmdlent
	      AND xmdkdocno = xmdldocno
	      AND xmdkstus <> 'X'
	      AND xmdkent = g_enterprise
	      AND xmdl094 = p_xmfodocno
	      AND xmdl095 = 0
	   IF l_cnt > 0 THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'axm-00718'     #此客訴單已有存在的銷退單！
	      LET g_errparam.extend = p_xmfodocno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success      
	   END IF
	   
	   #依據aooi210所設置的訂單對應的銷退單別
	   CALL s_aooi210_get_doc(g_site,'',4,p_xmfodocno,'axmt600','axm-00720')      #【轉銷退】請挑選銷退單別！
	        RETURNING l_success,l_docno
	   IF NOT l_success THEN
	      LET r_success = FALSE
	      RETURN r_success  
	   END IF  
	   
	   IF cl_null(l_docno) THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'agl-00122'
	      LET g_errparam.extend = p_xmfodocno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success
	   END IF 
	   
	   #取單號
	   CALL s_aooi200_gen_docno(g_site,l_docno,g_today,'axmt600') RETURNING l_success,l_xmdk.xmdkdocno
	   IF NOT l_success THEN
	      INITIALIZE g_errparam TO NULL
	      LET g_errparam.code = 'apm-00003'
	      LET g_errparam.extend = p_xmfodocno
	      LET g_errparam.popup = TRUE
	      CALL cl_err()
	      LET r_success = FALSE
	      RETURN r_success         
	   END IF 
	   #161109-00085#9-mod-s
#     SELECT * INTO l_xmfo.* FROM xmfo_t   #161109-00085#9-mark
      SELECT xmfoent,xmfosite,xmfodocno,xmfodocdt,xmfo001,xmfo002,xmfo003,xmfo004,xmfo005,xmfo006,xmfo007,xmfo008,xmfo009,
             xmfo010,xmfo011,xmfo012,xmfo013,xmfo014,xmfo015,xmfo016,xmfo017,xmfo018,xmfoownid,xmfoowndp,xmfocrtid,xmfocrtdp,
             xmfocrtdt,xmfomodid,xmfomoddt,xmfocnfid,xmfocnfdt,xmfopstid,xmfopstdt,xmfostus 
         INTO l_xmfo.xmfoent,l_xmfo.xmfosite,l_xmfo.xmfodocno,l_xmfo.xmfodocdt,l_xmfo.xmfo001,l_xmfo.xmfo002,l_xmfo.xmfo003,
              l_xmfo.xmfo004,l_xmfo.xmfo005,l_xmfo.xmfo006,l_xmfo.xmfo007,l_xmfo.xmfo008,l_xmfo.xmfo009,l_xmfo.xmfo010,
              l_xmfo.xmfo011,l_xmfo.xmfo012,l_xmfo.xmfo013,l_xmfo.xmfo014,l_xmfo.xmfo015,l_xmfo.xmfo016,l_xmfo.xmfo017,
              l_xmfo.xmfo018,l_xmfo.xmfoownid,l_xmfo.xmfoowndp,l_xmfo.xmfocrtid,l_xmfo.xmfocrtdp,l_xmfo.xmfocrtdt,
              l_xmfo.xmfomodid,l_xmfo.xmfomoddt,l_xmfo.xmfocnfid,l_xmfo.xmfocnfdt,l_xmfo.xmfopstid,l_xmfo.xmfopstdt,l_xmfo.xmfostus 
         FROM xmfo_t
   #161109-00085#9-mod-e
	    WHERE xmfoent = g_enterprise
	      AND xmfodocno = p_xmfodocno     
       
      LET l_xmdk.xmdkdocdt = g_today            #單據日期
      LET l_xmdk.xmdk000 = '6'                  #銷退    
      LET l_xmdk.xmdk001 = g_today              #銷退日期      
      LET l_xmdk.xmdk005 = l_xmfo.xmfo006       #出貨單號
      LET l_xmdk.xmdk007 = l_xmfo.xmfo005       #客戶編號  
      LET l_xmdk.xmdk082 = 1                    #銷退方式：銷售退回 
      LET l_xmdk.xmdk084 = 1                    #折讓證明單開立否 
      LET l_xmdk.xmdk085 = 5                    #資料來源：客訴單轉入
      LET l_xmdk.xmdk086 = p_xmfodocno          #來源單號      
   
      IF cl_null(l_xmdk.xmdk005) THEN
         SELECT pmab081,pmab109 
           INTO l_xmdk.xmdk003,l_xmdk.xmdk004
           FROM pmab_t
          WHERE pmabent = g_enterprise
            AND pmabsite = g_site
            AND pmab001 = l_rmaa.rmaa001       
         CALL s_axmt540_client_default(l_xmdk.xmdk007,l_xmdk.xmdk003,l_xmdk.xmdk004) 
           RETURNING l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk010,l_xmdk.xmdk011,l_xmdk.xmdk012,
                     l_xmdk.xmdk015,l_xmdk.xmdk016,l_xmdk.xmdk018,l_xmdk.xmdk022,l_xmdk.xmdk023,
                     l_xmdk.xmdk024,l_xmdk.xmdk030,l_xmdk.xmdk031,l_xmdk.xmdk042,l_xmdk.xmdk043
         CALL s_axmt540_get_exchange(l_xmdk.xmdk042,l_xmdk.xmdk016,l_xmdk.xmdkdocdt)   #modify--151118-00012#1 By Shiun   新增傳入參數l_xmdk.xmdkdocdt
           RETURNING l_xmdk.xmdk017                     
      ELSE
         SELECT xmdk006,xmdk008,xmdk009,
                xmdk030,
                xmdk010,xmdk011,xmdk012,xmdk013,xmdk014,
                xmdk015,xmdk016,xmdk017,xmdk018,xmdk037,
                xmdk042,xmdk043,xmdk044,xmdk045,
                xmdk031,xmdk033,xmdk036,
                xmdk202,
                xmdk003,xmdk004                    
           INTO l_xmdk.xmdk006,l_xmdk.xmdk008,l_xmdk.xmdk009,
                l_xmdk.xmdk030,
                l_xmdk.xmdk010,l_xmdk.xmdk011,l_xmdk.xmdk012,l_xmdk.xmdk013,l_xmdk.xmdk014,
                l_xmdk.xmdk015,l_xmdk.xmdk016,l_xmdk.xmdk017,l_xmdk.xmdk018,l_xmdk.xmdk037,
                l_xmdk.xmdk042,l_xmdk.xmdk043,l_xmdk.xmdk044,l_xmdk.xmdk045,
                l_xmdk.xmdk031,l_xmdk.xmdk033,l_xmdk.xmdk036,
                l_xmdk.xmdk202,
                l_xmdk.xmdk003,l_xmdk.xmdk004  
           FROM xmdk_t
          WHERE xmdkent = g_enterprise
            AND xmdk000 IN ('1','2')
            AND xmdkdocno = l_xmdk.xmdk005        
         IF l_xmdk.xmdk043 <> '1' THEN    #若不為1:依訂單日匯率，重算匯率
            #帶出匯率
            CALL s_axmt540_get_exchange(l_xmdk.xmdk042,l_xmdk.xmdk016,l_xmdk.xmdkdocdt) RETURNING l_xmdk.xmdk017   #modify--151118-00012#1 By Shiun   新增傳入參數l_xmdk.xmdkdocdt)
         END IF
      END IF
      
      LET l_xmdk.xmdkent = g_enterprise
      LET l_xmdk.xmdksite = g_site
      LET l_xmdk.xmdkownid = g_user
      LET l_xmdk.xmdkowndp = g_dept
      LET l_xmdk.xmdkcrtid = g_user
      LET l_xmdk.xmdkcrtdp = g_dept
      LET l_xmdk.xmdkcrtdt = cl_get_current()
      LET l_xmdk.xmdkmodid = g_user
      LET l_xmdk.xmdkmoddt = cl_get_current()
      LET l_xmdk.xmdkstus = 'N' 

      INSERT INTO xmdk_t (xmdkent,xmdk000,xmdksite,xmdkdocno,xmdkdocdt,xmdkstus,
                          xmdk001,xmdk003,xmdk004,xmdk005,xmdk006,
                          xmdk007,xmdk008,xmdk009,xmdk010,xmdk011,
                          xmdk012,xmdk013,xmdk014,xmdk015,xmdk016,
                          xmdk017,xmdk018,xmdk030,xmdk031,xmdk033,
                          xmdk036,xmdk037,xmdk042,xmdk043,xmdk044,
                          xmdk045,xmdk082,xmdk085,xmdk086,xmdk202,
                          xmdkownid,xmdkowndp,xmdkcrtid,xmdkcrtdp,
                          xmdkcrtdt,xmdkmodid,xmdkmoddt)
            VALUES (l_xmdk.xmdkent,l_xmdk.xmdk000,l_xmdk.xmdksite,l_xmdk.xmdkdocno,l_xmdk.xmdkdocdt,l_xmdk.xmdkstus,
                    l_xmdk.xmdk001,l_xmdk.xmdk003,l_xmdk.xmdk004,l_xmdk.xmdk005,l_xmdk.xmdk006,
                    l_xmdk.xmdk007,l_xmdk.xmdk008,l_xmdk.xmdk009,l_xmdk.xmdk010,l_xmdk.xmdk011,
                    l_xmdk.xmdk012,l_xmdk.xmdk013,l_xmdk.xmdk014,l_xmdk.xmdk015,l_xmdk.xmdk016,
                    l_xmdk.xmdk017,l_xmdk.xmdk018,l_xmdk.xmdk030,l_xmdk.xmdk031,l_xmdk.xmdk033,
                    l_xmdk.xmdk036,l_xmdk.xmdk037,l_xmdk.xmdk042,l_xmdk.xmdk043,l_xmdk.xmdk044,
                    l_xmdk.xmdk045,l_xmdk.xmdk082,l_xmdk.xmdk085,l_xmdk.xmdk086,l_xmdk.xmdk202,
                    l_xmdk.xmdkownid,l_xmdk.xmdkowndp,l_xmdk.xmdkcrtid,l_xmdk.xmdkcrtdp,
                    l_xmdk.xmdkcrtdt,l_xmdk.xmdkmodid,l_xmdk.xmdkmoddt)              

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "INSERT INTO xmdk_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success 
      END IF	   
	   
	   #產生單身檔
	   LET l_xmdl.xmdlent = g_enterprise
	   LET l_xmdl.xmdlsite = g_site
	   LET l_xmdl.xmdldocno = l_xmdk.xmdkdocno
	   LET l_xmdl.xmdlseq = 1

      LET l_xmdl.xmdl001 = l_xmfo.xmfo006     #出貨單號
      LET l_xmdl.xmdl002 = l_xmfo.xmfo007     #出貨項次
      LET l_xmdl.xmdl003 = l_xmfo.xmfo008     #訂單單號
      LET l_xmdl.xmdl004 = l_xmfo.xmfo009     #訂單項次
      LET l_xmdl.xmdl005 = l_xmfo.xmfo010     #訂單項序
      LET l_xmdl.xmdl006 = l_xmfo.xmfo011     #分批序
      LET l_xmdl.xmdl008 = l_xmfo.xmfo012     #料號
      LET l_xmdl.xmdl009 = l_xmfo.xmfo013     #產品特徵
      LET l_xmdl.xmdl013 = 'N'                #多庫儲批
      LET l_xmdl.xmdl014 = ''                 #庫位
      LET l_xmdl.xmdl015 = ''                 #儲位      
      LET l_xmdl.xmdl017 = l_xmfo.xmfo015     #單位 
      LET l_xmdl.xmdl018 = l_xmfo.xmfo014     #數量
      LET l_xmdl.xmdl021 = l_xmfo.xmfo015     #計價單位
      LET l_xmdl.xmdl022 = l_xmfo.xmfo014     #計價數量
      LET l_xmdl.xmdl025 = l_xmdk.xmdk012     #稅別
      LET l_xmdl.xmdl026 = l_xmdk.xmdk013     #稅率
      LET l_xmdl.xmdl023 = "Y"
      LET l_xmdl.xmdl041 = "N"
      LET l_xmdl.xmdl094 = l_xmfo.xmfodocno   #來源單號
      LET l_xmdl.xmdl095 = 0                  #來源項次


      IF NOT cl_null(l_xmdl.xmdl001) AND NOT cl_null(l_xmdl.xmdl002) THEN         
         SELECT xmdl003,xmdl004,xmdl005,xmdl006,xmdl007,
                xmdl008,xmdl009,xmdl010,xmdl011,xmdl012,
                xmdl016,xmdl019,xmdl023,xmdl030,xmdl031,
                xmdl032,xmdl033,xmdl052,xmdl041,xmdl051,
                xmdl088,xmdl024,xmdl025,xmdl026,xmdl042,                              
                xmdl043,xmdl044,xmdl045,xmdl046,xmdl048,
                xmdl049,xmdl087
           INTO l_xmdl.xmdl003,l_xmdl.xmdl004,l_xmdl.xmdl005,l_xmdl.xmdl006,l_xmdl.xmdl007,
                l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl010,l_xmdl.xmdl011,l_xmdl.xmdl012,                
                l_xmdl.xmdl016,l_xmdl.xmdl019,l_xmdl.xmdl023,l_xmdl.xmdl030,l_xmdl.xmdl031,                
                l_xmdl.xmdl032,l_xmdl.xmdl033,l_xmdl.xmdl052,l_xmdl.xmdl041,l_xmdl.xmdl051,                                
                l_xmdl.xmdl088,l_xmdl.xmdl024,l_xmdl.xmdl025,l_xmdl.xmdl026,l_xmdl.xmdl042,             
                l_xmdl.xmdl043,l_xmdl.xmdl044,l_xmdl.xmdl045,l_xmdl.xmdl046,l_xmdl.xmdl048,
                l_xmdl.xmdl049,l_xmdl.xmdl087    
           FROM xmdk_t,xmdl_t
          WHERE xmdkent = xmdlent AND xmdlent = g_enterprise
            AND xmdkdocno = xmdldocno AND xmdldocno = l_xmdl.xmdl001
            AND xmdlseq = l_xmdl.xmdl002
              
      ELSE 
        LET l_xmdl.xmdl024 = 0      #單價預設為零
      END IF
      CALL s_axmt500_get_amount(l_xmdl.xmdldocno,l_xmdl.xmdlseq,l_xmdl.xmdl022,l_xmdl.xmdl024,l_xmdl.xmdl025,l_xmdk.xmdk016,l_xmdk.xmdk017)
        RETURNING l_xmdl.xmdl027,l_xmdl.xmdl028,l_xmdl.xmdl029

      INSERT INTO xmdl_t (xmdlent,xmdlsite,xmdldocno,xmdlseq,
                          xmdl001,xmdl002,xmdl003,xmdl004,xmdl005,
                          xmdl006,xmdl007,xmdl008,xmdl009,xmdl010,
                          xmdl011,xmdl012,xmdl013,xmdl014,xmdl015,
                          xmdl016,xmdl017,xmdl018,xmdl019,xmdl020,                          
                          xmdl021,xmdl022,xmdl023,xmdl024,xmdl025,
                          xmdl026,xmdl027,xmdl028,xmdl029,xmdl030,                          
                          xmdl031,xmdl032,xmdl033,                          
                          xmdl041,xmdl042,xmdl043,xmdl044,xmdl045,
                          xmdl046,xmdl048,xmdl049,xmdl050,
                          xmdl051,xmdl052,
                          xmdl088,xmdl087,xmdl094,xmdl095)
         VALUES (l_xmdl.xmdlent,l_xmdl.xmdlsite,l_xmdl.xmdldocno,l_xmdl.xmdlseq,
                 l_xmdl.xmdl001,l_xmdl.xmdl002,l_xmdl.xmdl003,l_xmdl.xmdl004,l_xmdl.xmdl005,
                 l_xmdl.xmdl006,l_xmdl.xmdl007,l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl010,
                 l_xmdl.xmdl011,l_xmdl.xmdl012,l_xmdl.xmdl013,l_xmdl.xmdl014,l_xmdl.xmdl015,
                 l_xmdl.xmdl016,l_xmdl.xmdl017,l_xmdl.xmdl018,l_xmdl.xmdl019,l_xmdl.xmdl020,                          
                 l_xmdl.xmdl021,l_xmdl.xmdl022,l_xmdl.xmdl023,l_xmdl.xmdl024,l_xmdl.xmdl025,
                 l_xmdl.xmdl026,l_xmdl.xmdl027,l_xmdl.xmdl028,l_xmdl.xmdl029,l_xmdl.xmdl030,                          
                 l_xmdl.xmdl031,l_xmdl.xmdl032,l_xmdl.xmdl033,                          
                 l_xmdl.xmdl041,l_xmdl.xmdl042,l_xmdl.xmdl043,l_xmdl.xmdl044,l_xmdl.xmdl045,
                 l_xmdl.xmdl046,l_xmdl.xmdl048,l_xmdl.xmdl049,l_xmdl.xmdl050,
                 l_xmdl.xmdl051,l_xmdl.xmdl052,
                 l_xmdl.xmdl088,l_xmdl.xmdl087,l_xmdl.xmdl094,l_xmdl.xmdl095)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "INSERT INTO xmdl_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF


      #新增多庫儲批
      IF NOT axmt540_01_xmdm_modify('6',l_xmdl.xmdlseq,l_xmdk.xmdksite,l_xmdk.xmdkdocno,l_xmdl.xmdlseq,
                                   l_xmdl.xmdl008,l_xmdl.xmdl009,l_xmdl.xmdl011,l_xmdl.xmdl012,
                                   l_xmdl.xmdl014,l_xmdl.xmdl015,l_xmdl.xmdl016,l_xmdl.xmdl052,
                                   l_xmdl.xmdl017,l_xmdl.xmdl018,l_xmdl.xmdl019,l_xmdl.xmdl020,
                                   '','') THEN

         LET r_success = FALSE
         RETURN r_success
      END IF

      #重新計算整單的未稅、含稅總金額
      CALL s_tax_recount(l_xmdk.xmdkdocno)
        RETURNING l_xmdk.xmdk051,l_xmdk.xmdk053,l_xmdk.xmdk052,l_xrcd113,l_xrcd114,l_xrcd115
 

      IF cl_null(l_xmdk.xmdk051) THEN
         LET l_xmdk.xmdk051 = 0
      END IF
      IF cl_null(l_xmdk.xmdk052) THEN
         LET l_xmdk.xmdk052 = 0
      END IF
      IF cl_null(l_xmdk.xmdk053) THEN
         LET l_xmdk.xmdk053 = 0
      END IF
      
      UPDATE xmdk_t SET xmdk051 = l_xmdk.xmdk051,
                        xmdk052 = l_xmdk.xmdk052,
                        xmdk053 = l_xmdk.xmdk053
        WHERE xmdkent = g_enterprise AND xmdkdocno = l_xmdk.xmdkdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE xmdk_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success      
      END IF 
      
      IF NOT s_axmt600_conf_chk(l_xmdk.xmdkdocno) THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF
      IF NOT s_axmt600_conf_upd(l_xmdk.xmdkdocno) THEN
         LET r_success = FALSE
         RETURN r_success 
      END IF
      
      UPDATE xmfo_t
         SET xmfo017 = l_xmdk.xmdkdocno
       WHERE xmfoent = g_enterprise
         AND xmfodocno = p_xmfodocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE xmfo_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success      
      END IF 

      
      RETURN r_success
     

END FUNCTION

################################################################################
# Descriptions...: 161207-00033#18
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/12/29 By 08992
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt700_guest_desc(p_cmd,p_xmfo006,p_xmfo008,p_xmfo005)
DEFINE p_cmd        LIKE type_t.chr1
DEFINE p_xmfo006    LIKE xmfo_t.xmfo006
DEFINE p_xmfo008    LIKE xmfo_t.xmfo008
DEFINE p_xmfo005    LIKE xmfo_t.xmfo005
DEFINE r_pmak003    LIKE pmak_t.pmak003

   LET r_pmak003 = ''
   
   IF p_cmd = 'a' THEN
      IF NOT cl_null(p_xmfo006) OR NOT cl_null(p_xmfo008) THEN
         CALL s_desc_axm_get_oneturn_guest_desc('3',p_xmfo006) RETURNING r_pmak003
      END IF
   END IF
   
   IF cl_null(r_pmak003) THEN
      CALL s_desc_get_trading_partner_abbr_desc(p_xmfo005) RETURNING r_pmak003
   END IF
   
   RETURN r_pmak003

END FUNCTION

 
{</section>}
 
