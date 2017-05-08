#該程式未解開Section, 採用最新樣板產出!
{<section id="aprt111.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0030(2017-01-06 09:35:40), PR版次:0030(2017-02-20 14:21:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000522
#+ Filename...: aprt111
#+ Description: 永久進價調整作業
#+ Creator....: 03247(2014-03-05 16:38:53)
#+ Modifier...: 02749 -SD/PR- 09042
 
{</section>}
 
{<section id="aprt111.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
# 160318-00005#39  2016/03/30  By 07900   重复错误讯息修改
# 160406-00030#1   2016/04/07  By 08172   栏位名称重新显示
# 160318-00025#32  2016/04/12  By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
# 160506-00009#22  2016/05/14  By dongsz  增加积分单价的调价逻辑
# 160517-00014#1   2016/05/18  By dongsz  BUG调整(点击审核没有立即更新状态按钮和图片)
# 160604-00009#92  2016/0623   by 08172   新增参数判断是否抛转财务单据
# 160705-00042#10  2016/07/13  By sakura  程式中寫死g_prog部分改寫MATCHES方式
# 160816-00068#12  2016/08/17  By 08209   調整transaction
# 160905-00007#12  2016/09/05  by 08742   调整系统中无ENT的SQL条件增加ent，count(*)-->count(1)
# 161111-00028#2   2016/11/11  BY 02481   标准程式定义采用宣告模式,弃用.*写法
# 161115-00016#1   2016/11/16  By lori    欄位離開前檢查：
#                                         1.aprt113 促銷售價(prbg009),促銷會員價1~3(prbg010~prbg012) 不可大於 執行售價(prbg023)
#                                         2.aprt114 促銷售價(prbg009),促銷會員價1~3(prbg010~prbg012) 不可大於 執行售價(prbg023)
#                                         3.aprt115 促銷散客售價(prbg009) 不可大於 執行售價(prbg023)
#                                         4.aprt116 促銷會員價1~3(prbg010~prbg012) 不可大於 執行會員價(prbg023)
# 170105-00015#1   2017/01/05  By lori    促銷價不可高於原價：執行售價(prbg023) 的給值 在aprt111~119 各個作業給值的方式不同，不適合以原需求直接使用 prbg023 來判斷
#                                         修正#161115-00016#1 認定的"原價"來源字段，從執行售價(prbg023) 調整為該商品於門店商品清單中的售價(rtdx016)
# 170207-00018#7   2016/02/10  By 09042   ROWNUM整批调整
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
PRIVATE type type_g_prbf_m        RECORD
       prbfsite LIKE prbf_t.prbfsite, 
   prbfsite_desc LIKE type_t.chr80, 
   prbfdocdt LIKE prbf_t.prbfdocdt, 
   prbfdocno LIKE prbf_t.prbfdocno, 
   prbf002 LIKE prbf_t.prbf002, 
   prbf003 LIKE prbf_t.prbf003, 
   prbf001 LIKE prbf_t.prbf001, 
   prbf004 LIKE prbf_t.prbf004, 
   prbf004_desc LIKE type_t.chr80, 
   prbf005 LIKE prbf_t.prbf005, 
   prbf005_desc LIKE type_t.chr80, 
   prbf006 LIKE prbf_t.prbf006, 
   prbf007 LIKE prbf_t.prbf007, 
   prbf013 LIKE prbf_t.prbf013, 
   prbf013_desc LIKE type_t.chr80, 
   prbfunit LIKE prbf_t.prbfunit, 
   prbf010 LIKE prbf_t.prbf010, 
   prbf010_desc LIKE type_t.chr80, 
   prbf012 LIKE prbf_t.prbf012, 
   prbfud002 LIKE prbf_t.prbfud002, 
   prbfud003 LIKE prbf_t.prbfud003, 
   prbf011 LIKE prbf_t.prbf011, 
   prbf011_desc LIKE type_t.chr80, 
   prbfstus LIKE prbf_t.prbfstus, 
   prbfownid LIKE prbf_t.prbfownid, 
   prbfownid_desc LIKE type_t.chr80, 
   prbfowndp LIKE prbf_t.prbfowndp, 
   prbfowndp_desc LIKE type_t.chr80, 
   prbfcrtid LIKE prbf_t.prbfcrtid, 
   prbfcrtid_desc LIKE type_t.chr80, 
   prbfcrtdp LIKE prbf_t.prbfcrtdp, 
   prbfcrtdp_desc LIKE type_t.chr80, 
   prbfcrtdt LIKE prbf_t.prbfcrtdt, 
   prbfmodid LIKE prbf_t.prbfmodid, 
   prbfmodid_desc LIKE type_t.chr80, 
   prbfmoddt LIKE prbf_t.prbfmoddt, 
   prbfcnfid LIKE prbf_t.prbfcnfid, 
   prbfcnfid_desc LIKE type_t.chr80, 
   prbfcnfdt LIKE prbf_t.prbfcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_prbg_d        RECORD
       prbgunit LIKE prbg_t.prbgunit, 
   prbgseq LIKE prbg_t.prbgseq, 
   prbg001 LIKE prbg_t.prbg001, 
   prbgsite LIKE prbg_t.prbgsite, 
   prbgsite_desc LIKE type_t.chr500, 
   prbg003 LIKE prbg_t.prbg003, 
   prbg002 LIKE prbg_t.prbg002, 
   prbg002_desc LIKE type_t.chr500, 
   prbg002_desc_desc LIKE type_t.chr500, 
   prbg002_desc_desc_desc LIKE type_t.chr10, 
   rtaxl003 LIKE type_t.chr500, 
   prbg024 LIKE prbg_t.prbg024, 
   prbg021 LIKE prbg_t.prbg021, 
   prbg007 LIKE prbg_t.prbg007, 
   prbg023 LIKE prbg_t.prbg023, 
   prbg009 LIKE prbg_t.prbg009, 
   prbg010 LIKE prbg_t.prbg010, 
   prbg011 LIKE prbg_t.prbg011, 
   prbg012 LIKE prbg_t.prbg012, 
   prbg025 LIKE prbg_t.prbg025, 
   prbg026 LIKE prbg_t.prbg026, 
   prbgseq1 LIKE prbg_t.prbgseq1, 
   prbg004 LIKE prbg_t.prbg004, 
   prbg005 LIKE prbg_t.prbg005, 
   prbg005_desc LIKE type_t.chr500, 
   prbg006 LIKE prbg_t.prbg006, 
   prbg006_desc LIKE type_t.chr500, 
   prbg022 LIKE prbg_t.prbg022, 
   inag009 LIKE type_t.chr500, 
   prbg014 LIKE prbg_t.prbg014, 
   prbg015 LIKE prbg_t.prbg015, 
   prbg018 LIKE prbg_t.prbg018, 
   prbg018_desc LIKE type_t.chr500, 
   prbg008 LIKE prbg_t.prbg008, 
   prbg008_desc LIKE type_t.chr500, 
   prbg016 LIKE prbg_t.prbg016, 
   prbg017 LIKE prbg_t.prbg017, 
   prbg019 LIKE prbg_t.prbg019, 
   prbg020 LIKE prbg_t.prbg020, 
   prbg013 LIKE prbg_t.prbg013
       END RECORD
PRIVATE TYPE type_g_prbg3_d RECORD
       prbvstus LIKE prbv_t.prbvstus, 
   prbv001 LIKE prbv_t.prbv001, 
   prbv001_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_prbg4_d RECORD
       prbwseq LIKE prbw_t.prbwseq, 
   prbwsite LIKE prbw_t.prbwsite, 
   prbw001 LIKE prbw_t.prbw001, 
   prbw002 LIKE prbw_t.prbw002, 
   prbw003 LIKE prbw_t.prbw003, 
   prbw004 LIKE prbw_t.prbw004, 
   prbw005 LIKE prbw_t.prbw005, 
   prbw006 LIKE prbw_t.prbw006, 
   prbw007 LIKE prbw_t.prbw007, 
   prbw008 LIKE prbw_t.prbw008, 
   prbw009 LIKE prbw_t.prbw009, 
   prbw010 LIKE prbw_t.prbw010, 
   prbw011 LIKE prbw_t.prbw011, 
   prbw012 LIKE prbw_t.prbw012, 
   prbw013 LIKE prbw_t.prbw013, 
   prbw014 LIKE prbw_t.prbw014, 
   prbw022 LIKE prbw_t.prbw022, 
   prbw015 LIKE prbw_t.prbw015, 
   prbw016 LIKE prbw_t.prbw016, 
   prbw020 LIKE prbw_t.prbw020, 
   prbw021 LIKE prbw_t.prbw021, 
   prbw017 LIKE prbw_t.prbw017, 
   prbw018 LIKE prbw_t.prbw018
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_prbfunit LIKE prbf_t.prbfunit,
      b_prbfdocdt LIKE prbf_t.prbfdocdt,
      b_prbfdocno LIKE prbf_t.prbfdocno,
      b_prbf004 LIKE prbf_t.prbf004,
   b_prbf004_desc LIKE type_t.chr80,
      b_prbf005 LIKE prbf_t.prbf005,
   b_prbf005_desc LIKE type_t.chr80,
      b_prbf006 LIKE prbf_t.prbf006,
      b_prbf010 LIKE prbf_t.prbf010,
   b_prbf010_desc LIKE type_t.chr80,
      b_prbf011 LIKE prbf_t.prbf011,
   b_prbf011_desc LIKE type_t.chr80,
      b_prbf012 LIKE prbf_t.prbf012
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_prbf001       LIKE prbf_t.prbf001
DEFINE l_cmd           STRING
DEFINE g_prbg_d_colour DYNAMIC ARRAY OF RECORD
   prbgunit STRING, 
   prbgseq  STRING, 
   prbg001  STRING, 
   prbgsite STRING, 
   prbgsite_desc STRING, 
   prbg002 STRING, 
   prbg003 STRING, 
   prbg002_desc STRING, 
   prbg002_desc_desc STRING, 
   prbg002_desc_desc_desc STRING, 
   rtaxl003 STRING,
   prbgseq1 STRING, 
   prbg004 STRING, 
   prbg005 STRING, 
   prbg005_desc STRING, 
   prbg006 STRING,
   prbg006_desc STRING,   
   prbg007 STRING, 
   prbg014 STRING,
   prbg015 STRING,
   prbg018 STRING,          #150429-00002#1--add by dongsz
   prbg018_desc STRING,     #150429-00002#1--add by dongsz
   prbg008 STRING,
   prbg008_desc STRING,   
   prbg009 STRING, 
   prbg016 STRING,
   prbg017 STRING,
   prbg010 STRING, 
   prbg011 STRING, 
   prbg012 STRING, 
   prbg013 STRING
   END RECORD
DEFINE g_prbgseq_t   LIKE prbg_t.prbgseq
DEFINE l_ac_t        LIKE type_t.num5
DEFINE g_flag        LIKE type_t.chr1
DEFINE g_num1        LIKE type_t.num5
DEFINE g_num2        LIKE type_t.num5
DEFINE g_site_flag   LIKE type_t.num5
DEFINE g_flag1       LIKE type_t.chr1    #150401-00003#1--add by dongsz  #控制栏位是否带默认值，'N'时带值，'Y'不带值
DEFINE g_flag2       LIKE type_t.chr1    #150401-00003#1--add by dongsz  #控制栏位是否带默认值，'N'时带值，'Y'不带值
#20150923--add by dongsz--s
 TYPE type_g_prbk_d        RECORD
   prbkstus LIKE prbk_t.prbkstus, 
   prbk025  LIKE prbk_t.prbk025, 
   prbk003  LIKE prbk_t.prbk003,
   prbksite LIKE prbk_t.prbksite,     #20151203 dongsz add
   prbksite_desc LIKE type_t.chr500,  #20151203 dongsz add
   prbk010  LIKE prbk_t.prbk010,
   prbk011  LIKE prbk_t.prbk011, 
   prbk014  LIKE prbk_t.prbk014,
   prbk014_desc  LIKE type_t.chr500,   
   prbk018  LIKE prbk_t.prbk018,
   prbk020  LIKE prbk_t.prbk020, 
   prbk021  LIKE prbk_t.prbk021, 
   prbk022  LIKE prbk_t.prbk022,
   prbk023  LIKE prbk_t.prbk023,
   prbk028  LIKE prbk_t.prbk028,   #160506-00009#22 dongsz add
   prbk001  LIKE prbk_t.prbk001, 
   prbk002  LIKE prbk_t.prbk002,
   prbk006  LIKE prbk_t.prbk006,
   prbk007  LIKE prbk_t.prbk007
       END RECORD
DEFINE g_prbk_d          DYNAMIC ARRAY OF type_g_prbk_d
DEFINE g_prgadocno  LIKE prga_t.prgadocno  #add by guomy 2015/10/23
DEFINE g_prgatype   LIKE type_t.chr1  #add by guomy 2015/10/23
#20150923--add by dongsz--e
#end add-point
       
#模組變數(Module Variables)
DEFINE g_prbf_m          type_g_prbf_m
DEFINE g_prbf_m_t        type_g_prbf_m
DEFINE g_prbf_m_o        type_g_prbf_m
DEFINE g_prbf_m_mask_o   type_g_prbf_m #轉換遮罩前資料
DEFINE g_prbf_m_mask_n   type_g_prbf_m #轉換遮罩後資料
 
   DEFINE g_prbfdocno_t LIKE prbf_t.prbfdocno
 
 
DEFINE g_prbg_d          DYNAMIC ARRAY OF type_g_prbg_d
DEFINE g_prbg_d_t        type_g_prbg_d
DEFINE g_prbg_d_o        type_g_prbg_d
DEFINE g_prbg_d_mask_o   DYNAMIC ARRAY OF type_g_prbg_d #轉換遮罩前資料
DEFINE g_prbg_d_mask_n   DYNAMIC ARRAY OF type_g_prbg_d #轉換遮罩後資料
DEFINE g_prbg3_d          DYNAMIC ARRAY OF type_g_prbg3_d
DEFINE g_prbg3_d_t        type_g_prbg3_d
DEFINE g_prbg3_d_o        type_g_prbg3_d
DEFINE g_prbg3_d_mask_o   DYNAMIC ARRAY OF type_g_prbg3_d #轉換遮罩前資料
DEFINE g_prbg3_d_mask_n   DYNAMIC ARRAY OF type_g_prbg3_d #轉換遮罩後資料
DEFINE g_prbg4_d          DYNAMIC ARRAY OF type_g_prbg4_d
DEFINE g_prbg4_d_t        type_g_prbg4_d
DEFINE g_prbg4_d_o        type_g_prbg4_d
DEFINE g_prbg4_d_mask_o   DYNAMIC ARRAY OF type_g_prbg4_d #轉換遮罩前資料
DEFINE g_prbg4_d_mask_n   DYNAMIC ARRAY OF type_g_prbg4_d #轉換遮罩後資料
 
 
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
 
{<section id="aprt111.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:作業初始化 name="main.init"
   LET g_prbf001 = g_argv[1]  
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
                                 
   #end add-point
   LET g_forupd_sql = " SELECT prbfsite,'',prbfdocdt,prbfdocno,prbf002,prbf003,prbf001,prbf004,'',prbf005, 
       '',prbf006,prbf007,prbf013,'',prbfunit,prbf010,'',prbf012,prbfud002,prbfud003,prbf011,'',prbfstus, 
       prbfownid,'',prbfowndp,'',prbfcrtid,'',prbfcrtdp,'',prbfcrtdt,prbfmodid,'',prbfmoddt,prbfcnfid, 
       '',prbfcnfdt", 
                      " FROM prbf_t",
                      " WHERE prbfent= ? AND prbfdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
                                 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt111_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.prbfsite,t0.prbfdocdt,t0.prbfdocno,t0.prbf002,t0.prbf003,t0.prbf001, 
       t0.prbf004,t0.prbf005,t0.prbf006,t0.prbf007,t0.prbf013,t0.prbfunit,t0.prbf010,t0.prbf012,t0.prbfud002, 
       t0.prbfud003,t0.prbf011,t0.prbfstus,t0.prbfownid,t0.prbfowndp,t0.prbfcrtid,t0.prbfcrtdp,t0.prbfcrtdt, 
       t0.prbfmodid,t0.prbfmoddt,t0.prbfcnfid,t0.prbfcnfdt,t1.ooefl003 ,t2.pmaal004 ,t3.rtaxl003 ,t4.oocql004 , 
       t5.ooag011 ,t6.ooefl003 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011 ,t12.ooag011", 
 
               " FROM prbf_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.prbfsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t2 ON t2.pmaalent="||g_enterprise||" AND t2.pmaal001=t0.prbf004 AND t2.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t3 ON t3.rtaxlent="||g_enterprise||" AND t3.rtaxl001=t0.prbf005 AND t3.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t4 ON t4.oocqlent="||g_enterprise||" AND t4.oocql001='2135' AND t4.oocql002=t0.prbf013 AND t4.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.prbf010  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.prbf011 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.prbfownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.prbfowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.prbfcrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.prbfcrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.prbfmodid  ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.prbfcnfid  ",
 
               " WHERE t0.prbfent = " ||g_enterprise|| " AND t0.prbfdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprt111_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                                                                  
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprt111 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprt111_init()   
 
      #進入選單 Menu (="N")
      CALL aprt111_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                                                                  
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprt111
      
   END IF 
   
   CLOSE aprt111_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add                              
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprt111.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aprt111_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add  
   DEFINE l_msg      STRING          #150520-00024#1--add by dongsz  
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160229   
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
      CALL cl_set_combo_scc_part('prbfstus','13','N,Y,E,A,D,R,W,X')
 
      CALL cl_set_combo_scc('prbf002','6029') 
   CALL cl_set_combo_scc('prbf001','6028') 
   CALL cl_set_combo_scc('prbg001','6030') 
   CALL cl_set_combo_scc('prbgseq1','6032') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   
   #add by guomy 2015/10/21 -----(start)---
   CALL cl_set_comp_visible("prbfud002,prbfud003",FALSE)
   IF g_prbf001 = '1' OR g_prbf001 = '3' THEN
      CALL cl_set_comp_visible("prbfud002",TRUE)
     # LET prbfud002 = '1'
   END IF
   #add by guomy 2015/10/21 -----(end)--- 
   
   IF g_prbf001 = '1' OR g_prbf001 = '2' THEN
      #CALL cl_set_comp_visible("prbf002,prbf003,prbf007,prbf008,prbf009",FALSE)   #150401-00003#1--mark by dongsz
      CALL cl_set_comp_visible("prbf002,prbf003",FALSE)                        #150401-00003#1--add by dongsz
      CALL cl_set_comp_visible("prbf007",FALSE)                                #150903-00008#12 dongsz add
      CALL cl_set_comp_visible("prbg014,prbg015,prbg016,prbg017",FALSE)        #150401-00003#1--add by dongsz
   END IF
   IF g_prbf001 MATCHES '[129]' THEN
      CALL cl_set_comp_visible("prbf013",FALSE) 
   END IF
   IF g_prbf001 MATCHES '[26789]' THEN
      CALL cl_set_comp_required("prbf004",FALSE)
   END IF
   #150401-00003#1--add by dongsz--str---
   IF g_prbf001 = '3' THEN
      #CALL cl_set_comp_visible("prbf006",FALSE)    #150903-00008#12 dongsz mark
      #150520-00024#1--add by dongsz--str---
      LET l_msg = cl_getmsg('apr-00383',g_dlang)
      CALL cl_set_comp_att_text("prbg007",l_msg)
      LET l_msg = cl_getmsg('apr-00384',g_dlang)
      CALL cl_set_comp_att_text("prbg009",l_msg)
      #150520-00024#1--add by dongsz--end---
      #151013-00001#44--dongsz add--str
      CALL cl_set_comp_visible("prbg014",TRUE) 
      CALL cl_set_comp_visible("prbg015",TRUE) 
      CALL cl_set_comp_visible("prbg016",TRUE)
      CALL cl_set_comp_visible("prbg017",TRUE)
      #151013-00001#44--dongsz add--end
      #20150705--add by dongsz--s
#      LET l_msg = cl_getmsg('apr-00413',g_dlang)
#      CALL cl_set_comp_att_text("prbg016",l_msg)
#      LET l_msg = cl_getmsg('apr-00414',g_dlang)
#      CALL cl_set_comp_att_text("prbg017",l_msg)
#      LET l_msg = cl_getmsg('apr-00418',g_dlang)
#      CALL cl_set_comp_att_text("prbg010",l_msg)
#      LET l_msg = cl_getmsg('apr-00419',g_dlang)
#      CALL cl_set_comp_att_text("prbg011",l_msg)
#      LET l_msg = cl_getmsg('apr-00420',g_dlang)
#      CALL cl_set_comp_att_text("prbg012",l_msg)
      #20150705--add by dongsz--e  
   END IF
   #20150923--add by dongsz--s
   #150903-00008#14 dongsz add--str
   IF g_prbf001 = '6' THEN #促銷售價調整     
#      LET l_msg = cl_getmsg('apr-00402',g_dlang)
#      CALL cl_set_comp_att_text("prbg007",l_msg)      
#      LET l_msg = cl_getmsg('apr-00404',g_dlang)
#      CALL cl_set_comp_att_text("prbg009",l_msg) 
#      CALL cl_set_comp_visible("prbg005,prbg005_desc,prbg006,prbg006_desc,prbg007,prbg014,prbg015",FALSE) 
      #20150705--add by dongsz--s
#      LET l_msg = cl_getmsg('apr-00411',g_dlang)
#      CALL cl_set_comp_att_text("prbg0161",l_msg) 
#      LET l_msg = cl_getmsg('apr-00412',g_dlang)
#      CALL cl_set_comp_att_text("prbg0171",l_msg)
#      LET l_msg = cl_getmsg('apr-00413',g_dlang)
#      CALL cl_set_comp_att_text("prbg016",l_msg)
#      LET l_msg = cl_getmsg('apr-00414',g_dlang)
#      CALL cl_set_comp_att_text("prbg017",l_msg)
#      LET l_msg = cl_getmsg('apr-00415',g_dlang)
#      CALL cl_set_comp_att_text("prbg0101",l_msg)
#      LET l_msg = cl_getmsg('apr-00416',g_dlang)
#      CALL cl_set_comp_att_text("prbg0111",l_msg)
#      LET l_msg = cl_getmsg('apr-00417',g_dlang)
#      CALL cl_set_comp_att_text("prbg0121",l_msg)
#      LET l_msg = cl_getmsg('apr-00418',g_dlang)
#      CALL cl_set_comp_att_text("prbg010",l_msg)
#      LET l_msg = cl_getmsg('apr-00419',g_dlang)
#      CALL cl_set_comp_att_text("prbg011",l_msg)
#      LET l_msg = cl_getmsg('apr-00420',g_dlang)
#      CALL cl_set_comp_att_text("prbg012",l_msg)
      #20150705--add by dongsz--e            
   END IF
   IF g_prbf001 = '7' THEN
      CALL cl_set_comp_visible("prbg010,prbg011,prbg012",FALSE) 
   END IF
   IF g_prbf001 = '8' THEN
      CALL cl_set_comp_visible("prbg009",FALSE) 
   END IF
   #150903-00008#14 dongsz add--end
   #151013-00001#44--dongsz add--str
   IF g_prbf001 <> '3' THEN
      CALL cl_set_comp_visible("prbw020,prbw021",FALSE) 
      CALL cl_getmsg('apr-00509',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prbw015",l_msg CLIPPED)
      CALL cl_getmsg('apr-00510',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("prbw016",l_msg CLIPPED)
   END IF
   #151013-00001#44--dongsz add--end
   CALL cl_set_combo_scc('prbkstus','6034')
   CALL cl_set_combo_scc('prbk025','6779')
   CALL cl_set_combo_scc('prbk003','6033')
   #20150923--add by dongsz--e
   LET g_errshow = '1'
   #150401-00003#1--add by dongsz--end---
   #20151105--dongsz add--str---
   #件装数显示
   IF g_prbf001 <> '9' THEN
      CALL cl_set_comp_visible("prbg024",FALSE) 
   END IF
   #20151105--dongsz add--end---
   #160506-00009#22--dongsz add--str
   IF g_prbf001 NOT MATCHES '[26]' THEN
      CALL cl_set_comp_visible("prbg025,prbg026,prbw022,prbk028",FALSE)
   END IF
   #160506-00009#22--dongsz add--end
   
   #add by guomy 2015/11/20 隐藏excel产生范例和汇入excel资料按钮
   CALL cl_set_act_visible_toolbaritem("excel_example", FALSE)
   CALL cl_set_act_visible_toolbaritem("excel_load", FALSE)
   #add by geza 20160229(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbk021",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbk022",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbk023",l_gzcbl004)
   #add by geza 20160229(E)
   #add by geza 20160314(S)
   #栏位名称重新显示
   IF g_prbf001 = '3' OR g_prbf001 = '6' OR g_prbf001 = '8' THEN
      CALL s_desc_gzcbl004_desc('6899','4') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg010",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','5') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg011",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','6') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg012",l_gzcbl004)
     
   ELSE
      CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg010",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg011",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbg012",l_gzcbl004)
   END IF
   #add by yuanqy 20160407
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbw012",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbw013",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("prbw014",l_gzcbl004)
   #add by yuanqy 20160411
   #IF g_prog="aprt113" OR g_prog="aprt114" OR g_prog="aprt116" THEN                          #160705-00042#10 160713 by sakura mark
   IF g_prog MATCHES "aprt113" OR g_prog MATCHES "aprt114" OR g_prog MATCHES "aprt116" THEN   #160705-00042#10 160713 by sakura add
      
      CALL s_desc_gzcbl004_desc('6899','4') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbw012",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','5') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbw013",l_gzcbl004)
      CALL s_desc_gzcbl004_desc('6899','6') RETURNING l_gzcbl004
      CALL cl_set_comp_att_text("prbw014",l_gzcbl004)
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL aprt111_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aprt111.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aprt111_ui_dialog()
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
            CALL aprt111_insert()
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
         INITIALIZE g_prbf_m.* TO NULL
         CALL g_prbg_d.clear()
         CALL g_prbg3_d.clear()
         CALL g_prbg4_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aprt111_init()
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
               
               CALL aprt111_fetch('') # reload data
               LET l_ac = 1
               CALL aprt111_ui_detailshow() #Setting the current row 
         
               CALL aprt111_idx_chk()
               #NEXT FIELD prbgseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_prbg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt111_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL aprt111_b_fill2('0')     #20150923 dongsz add                                                                                                                                             
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
               CALL aprt111_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL DIALOG.setCellAttributes(g_prbg_d_colour)    #参数：屏幕变量,属性数组                                                                                                                                                      
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                                                                                                                    
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_prbg3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt111_idx_chk()
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
               CALL aprt111_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body3.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
         #第一階單身段落
         DISPLAY ARRAY g_prbg4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt111_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body4.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aprt111_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body4.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #20150923--add by dongsz--s
         DISPLAY ARRAY g_prbk_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aprt111_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               #LET g_detail_idx_list[1] = l_ac
               #CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作
                                                                                                                                                                     
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               #IF g_loc = 'm' THEN
               #   CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               #END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aprt111_idx_chk()
               #add-point:page1自定義行為
               #CALL DIALOG.setCellAttributes(g_prbg_d_colour)    #参数：屏幕变量,属性数组                                                                                                                                                      
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為
                                                                                                                                    
            #end add-point
               
         END DISPLAY
         #20150923--add by dongsz--e         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aprt111_browser_fill("")
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
               CALL aprt111_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aprt111_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aprt111_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                                                                                                                    
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aprt111_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aprt111_set_act_visible()   
            CALL aprt111_set_act_no_visible()
            IF NOT (g_prbf_m.prbfdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " prbfent = " ||g_enterprise|| " AND",
                                  " prbfdocno = '", g_prbf_m.prbfdocno, "' "
 
               #填到對應位置
               CALL aprt111_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "prbf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbv_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prbw_t" 
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
               CALL aprt111_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "prbf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "prbv_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "prbw_t" 
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
                  CALL aprt111_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aprt111_fetch("F")
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
               CALL aprt111_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aprt111_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt111_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aprt111_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt111_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aprt111_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt111_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aprt111_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt111_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aprt111_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aprt111_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_prbg_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_prbg3_d)
                  LET g_export_id[2]   = "s_detail3"
                  LET g_export_node[3] = base.typeInfo.create(g_prbg4_d)
                  LET g_export_id[3]   = "s_detail4"
 
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
               NEXT FIELD prbgseq
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
               CALL aprt111_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                                                                                                                                                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aprt111_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                                                                                                                                                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aprq124
            LET g_action_choice="open_aprq124"
            IF cl_auth_chk_act("open_aprq124") THEN
               
               #add-point:ON ACTION open_aprq124 name="menu.open_aprq124"
               IF NOT cl_null(g_detail_idx) AND g_detail_idx <> 0 THEN
                  IF NOT cl_null(g_prbg_d[g_detail_idx].prbg002) THEN
                     LET la_param.prog = "aprq124"
                     LET la_param.param[1] = g_prbg_d[g_detail_idx].prbg002
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                  ELSE
                     LET l_cmd = "aprq124"
                     CALL cl_cmdrun_wait(l_cmd)
                  END IF
               ELSE
                  LET l_cmd = "aprq124"
                  CALL cl_cmdrun_wait(l_cmd)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION downloadtemplet
            LET g_action_choice="downloadtemplet"
            IF cl_auth_chk_act("downloadtemplet") THEN
               
               #add-point:ON ACTION downloadtemplet name="menu.downloadtemplet"
               CALL s_excel_templet_download()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aprt111_delete()
               #add-point:ON ACTION delete name="menu.delete"
                                                                                                                                                                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprt111_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                                                                                                                                                     
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
                                                                                                                                                                     
               #END add-point
               &include "erp/apr/aprt111_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
                                                                                                                                                                     
               #END add-point
               &include "erp/apr/aprt111_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION importfromexcel
            LET g_action_choice="importfromexcel"
            IF cl_auth_chk_act("importfromexcel") THEN
               
               #add-point:ON ACTION importfromexcel name="menu.importfromexcel"
               CALL s_aprt111_excel(g_prbf_m.prbfdocno)
               CALL aprt111_ins_prbw()      #20151201 dongsz add
               CALL aprt111_b_fill()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_arti201
            LET g_action_choice="open_arti201"
            IF cl_auth_chk_act("open_arti201") THEN
               
               #add-point:ON ACTION open_arti201 name="menu.open_arti201"
               IF NOT cl_null(g_detail_idx) AND g_detail_idx <> 0 THEN
                  IF g_prbg_d[g_detail_idx].prbg001 = '1' AND NOT cl_null(g_prbg_d[g_detail_idx].prbgsite) THEN
                     LET la_param.prog = "arti201" 
                     LET la_param.param[1] = g_prbg_d[g_detail_idx].prbgsite
                     LET ls_js = util.JSON.stringify( la_param )
                     CALL cl_cmdrun_wait(ls_js)
                  ELSE
                     LET l_cmd = "arti201 "
                     CALL cl_cmdrun_wait(l_cmd) 
                  END IF
               ELSE
                  LET l_cmd = "arti201 "
                  CALL cl_cmdrun_wait(l_cmd)
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprt111_query()
               #add-point:ON ACTION query name="menu.query"
                                                                                                                                                                     
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
               CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION uploadtemplet
            LET g_action_choice="uploadtemplet"
            IF cl_auth_chk_act("uploadtemplet") THEN
               
               #add-point:ON ACTION uploadtemplet name="menu.uploadtemplet"
               CALL s_excel_templet_upload()  
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_load
            LET g_action_choice="excel_load"
            IF cl_auth_chk_act("excel_load") THEN
               
               #add-point:ON ACTION excel_load name="menu.excel_load"
               #20150714--add by dongsz--s
               LET g_etlparam[1].para_id = "g_docno"
               LET g_etlparam[1].type = "string"
               LET g_etlparam[1].value = g_prbf_m.prbfdocno
               
               LET g_etlparam[2].para_id = "g_date"
               LET g_etlparam[2].type = "date"
               LET g_etlparam[2].value = g_prbf_m.prbf006
               
               #20150729-add by dongsz-s
               LET g_etlparam[3].para_id = "g_site"
               LET g_etlparam[3].type = "string"
               LET g_etlparam[3].value = g_prbf_m.prbfsite

               LET g_etlparam[4].para_id = "g_sdate"
               LET g_etlparam[4].type = "date"
               LET g_etlparam[4].value = g_prbf_m.prbf006

               LET g_etlparam[5].para_id = "g_edate"
               LET g_etlparam[5].type = "date"
               LET g_etlparam[5].value = g_prbf_m.prbf007
               #20150729-add by dongsz-e
               
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_load"
               LET la_param.param[3] = util.JSON.stringify(g_etlparam)
               
               LET ls_js = util.JSON.stringify( la_param )
               CALL cl_cmdrun_wait(ls_js)
               
               CALL aprt111_b_fill()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_example
            LET g_action_choice="excel_example"
            IF cl_auth_chk_act("excel_example") THEN
               
               #add-point:ON ACTION excel_example name="menu.excel_example"
               LET la_param.prog = 'awsp200'
               LET la_param.param[1] = g_prog
               LET la_param.param[2] = "excel_example"
               LET ls_js = util.JSON.stringify( la_param )
               
               CALL cl_cmdrun_wait(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aprt111_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aprt111_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aprt111_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_prbf_m.prbfdocdt)
 
 
 
         
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
 
{<section id="aprt111.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aprt111_browser_fill(ps_page_action)
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
   CALL s_aooi500_sql_where(g_prog,'prbfsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where," AND prbf001 = '",g_prbf001,"' "
   LET l_wc  = g_wc.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT prbfdocno ",
                      " FROM prbf_t ",
                      " ",
                      " LEFT JOIN prbg_t ON prbgent = prbfent AND prbfdocno = prbgdocno ", "  ",
                      #add-point:browser_fill段sql(prbg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN prbv_t ON prbvent = prbfent AND prbfdocno = prbvdocno", "  ",
                      #add-point:browser_fill段sql(prbv_t1) name="browser_fill.cnt.join.prbv_t1"
                      
                      #end add-point
 
                      " LEFT JOIN prbw_t ON prbwent = prbfent AND prbfdocno = prbwdocno", "  ",
                      #add-point:browser_fill段sql(prbw_t1) name="browser_fill.cnt.join.prbw_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
                      " ",                      
 
 
 
                      " WHERE prbfent = " ||g_enterprise|| " AND prbgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("prbf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT prbfdocno ",
                      " FROM prbf_t ", 
                      "  ",
                      "  ",
                      " WHERE prbfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("prbf_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
#   LET l_sub_sql = l_sub_sql," AND prbf001 = '",g_prbf001,"' "
#   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"   
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
      INITIALIZE g_prbf_m.* TO NULL
      CALL g_prbg_d.clear()        
      CALL g_prbg3_d.clear() 
      CALL g_prbg4_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.prbfunit,t0.prbfdocdt,t0.prbfdocno,t0.prbf004,t0.prbf005,t0.prbf006,t0.prbf010,t0.prbf011,t0.prbf012 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbfstus,t0.prbfunit,t0.prbfdocdt,t0.prbfdocno,t0.prbf004,t0.prbf005, 
          t0.prbf006,t0.prbf010,t0.prbf011,t0.prbf012,t1.pmaal004 ,t2.rtaxl003 ,t3.ooag011 ,t4.ooefl003 ", 
 
                  " FROM prbf_t t0",
                  "  ",
                  "  LEFT JOIN prbg_t ON prbgent = prbfent AND prbfdocno = prbgdocno ", "  ", 
                  #add-point:browser_fill段sql(prbg_t1) name="browser_fill.join.prbg_t1"
                  
                  #end add-point
                  "  LEFT JOIN prbv_t ON prbvent = prbfent AND prbfdocno = prbvdocno", "  ", 
                  #add-point:browser_fill段sql(prbv_t1) name="browser_fill.join.prbv_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN prbw_t ON prbwent = prbfent AND prbfdocno = prbwdocno", "  ", 
                  #add-point:browser_fill段sql(prbw_t1) name="browser_fill.join.prbw_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
                  " ",                      
 
 
 
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.prbf004 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.prbf005 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prbf010  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prbf011 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prbfent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prbf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.prbfstus,t0.prbfunit,t0.prbfdocdt,t0.prbfdocno,t0.prbf004,t0.prbf005, 
          t0.prbf006,t0.prbf010,t0.prbf011,t0.prbf012,t1.pmaal004 ,t2.rtaxl003 ,t3.ooag011 ,t4.ooefl003 ", 
 
                  " FROM prbf_t t0",
                  "  ",
                                 " LEFT JOIN pmaal_t t1 ON t1.pmaalent="||g_enterprise||" AND t1.pmaal001=t0.prbf004 AND t1.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent="||g_enterprise||" AND t2.rtaxl001=t0.prbf005 AND t2.rtaxl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.prbf010  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.prbf011 AND t4.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.prbfent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("prbf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY prbfdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
#   LET g_sql = " SELECT DISTINCT t0.prbfstus,t0.prbfunit,t0.prbfdocdt,t0.prbfdocno,t0.prbf004,t0.prbf005, 
#               t0.prbf006,t0.prbf010,t0.prbf011,t0.prbf012,t1.pmaal004 ,t2.rtaxl003 ,t3.ooag011 ,t4.ooefl003 ", 
#
#               " FROM prbf_t t0",
#               "  ",
#               "  LEFT JOIN prbg_t ON prbgent = prbfent AND prbfdocno = prbgdocno ",
# 
# 
#               "  ",
#               "  ",
#                              " LEFT JOIN pmaal_t t1 ON t1.pmaalent='"||g_enterprise||"' AND t1.pmaal001=t0.prbf004 AND t1.pmaal002='"||g_lang||"' ",
#               " LEFT JOIN rtaxl_t t2 ON t2.rtaxlent='"||g_enterprise||"' AND t2.rtaxl001=t0.prbf005 AND t2.rtaxl002='"||g_lang||"' ",
#               " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.prbf010  ",
#               " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.prbf011 AND t4.ooefl002='"||g_lang||"' ",
# 
#               " WHERE t0.prbfent = '" ||g_enterprise|| "' AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("prbf_t")," AND t0.prbf001 = '",g_prbf001,"' ",
#               " ORDER BY prbfdocno ",g_order 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"prbf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
                                 
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_prbfunit,g_browser[g_cnt].b_prbfdocdt, 
          g_browser[g_cnt].b_prbfdocno,g_browser[g_cnt].b_prbf004,g_browser[g_cnt].b_prbf005,g_browser[g_cnt].b_prbf006, 
          g_browser[g_cnt].b_prbf010,g_browser[g_cnt].b_prbf011,g_browser[g_cnt].b_prbf012,g_browser[g_cnt].b_prbf004_desc, 
          g_browser[g_cnt].b_prbf005_desc,g_browser[g_cnt].b_prbf010_desc,g_browser[g_cnt].b_prbf011_desc 
 
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
         CALL aprt111_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "E"
            LET g_browser[g_cnt].b_statepic = "stus/16/ended.png"
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
   
   IF cl_null(g_browser[g_cnt].b_prbfdocno) THEN
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
 
{<section id="aprt111.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aprt111_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
                                 
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_prbf_m.prbfdocno = g_browser[g_current_idx].b_prbfdocno   
 
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
   CALL aprt111_prbf_t_mask()
   CALL aprt111_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aprt111.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aprt111_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
                                 
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
                                 
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
                                 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aprt111_ui_browser_refresh()
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
      IF g_browser[l_i].b_prbfdocno = g_prbf_m.prbfdocno 
 
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
 
{<section id="aprt111.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprt111_construct()
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
   INITIALIZE g_prbf_m.* TO NULL
   CALL g_prbg_d.clear()        
   CALL g_prbg3_d.clear() 
   CALL g_prbg4_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
   INITIALIZE g_wc2_table3 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_prbk_d.clear()    #20151110 dongsz add              
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON prbfsite,prbfdocdt,prbfdocno,prbf002,prbf003,prbf001,prbf004,prbf005, 
          prbf006,prbf007,prbf013,prbfunit,prbf010,prbf012,prbfud002,prbfud003,prbf011,prbfstus,prbfownid, 
          prbfowndp,prbfcrtid,prbfcrtdp,prbfcrtdt,prbfmodid,prbfmoddt,prbfcnfid,prbfcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                                                                                                                    
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbfcrtdt>>----
         AFTER FIELD prbfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbfmoddt>>----
         AFTER FIELD prbfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbfcnfdt>>----
         AFTER FIELD prbfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbfpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.prbfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfsite
            #add-point:ON ACTION controlp INFIELD prbfsite name="construct.c.prbfsite"
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
		
#		    LET g_qryparam.arg1 = g_site
#		    LET g_qryparam.arg2 = '8'
#		    
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbfsite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prbfsite  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO prbfsite #營運組織 

            NEXT FIELD prbfsite                     #返回原欄位                                                                                                                        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfsite
            #add-point:BEFORE FIELD prbfsite name="construct.b.prbfsite"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfsite
            
            #add-point:AFTER FIELD prbfsite name="construct.a.prbfsite"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfdocdt
            #add-point:BEFORE FIELD prbfdocdt name="construct.b.prbfdocdt"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfdocdt
            
            #add-point:AFTER FIELD prbfdocdt name="construct.a.prbfdocdt"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfdocdt
            #add-point:ON ACTION controlp INFIELD prbfdocdt name="construct.c.prbfdocdt"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfdocno
            #add-point:ON ACTION controlp INFIELD prbfdocno name="construct.c.prbfdocno"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_prbf001
            CALL q_prbfdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfdocno  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO pmaal004 #交易對象簡稱 
               #DISPLAY g_qryparam.return3 TO prbfdocno #單據編號 
               #DISPLAY g_qryparam.return4 TO prbfdocdt #單據日期 
               #DISPLAY g_qryparam.return5 TO prbf004 #供應商編號 
               #DISPLAY g_qryparam.return6 TO prbf005 #管理品類 
               #DISPLAY g_qryparam.return7 TO prbf010 #人員 

            NEXT FIELD prbfdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfdocno
            #add-point:BEFORE FIELD prbfdocno name="construct.b.prbfdocno"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfdocno
            
            #add-point:AFTER FIELD prbfdocno name="construct.a.prbfdocno"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf002
            #add-point:BEFORE FIELD prbf002 name="construct.b.prbf002"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf002
            
            #add-point:AFTER FIELD prbf002 name="construct.a.prbf002"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf002
            #add-point:ON ACTION controlp INFIELD prbf002 name="construct.c.prbf002"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf003
            #add-point:BEFORE FIELD prbf003 name="construct.b.prbf003"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf003
            
            #add-point:AFTER FIELD prbf003 name="construct.a.prbf003"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf003
            #add-point:ON ACTION controlp INFIELD prbf003 name="construct.c.prbf003"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf001
            #add-point:BEFORE FIELD prbf001 name="construct.b.prbf001"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf001
            
            #add-point:AFTER FIELD prbf001 name="construct.a.prbf001"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf001
            #add-point:ON ACTION controlp INFIELD prbf001 name="construct.c.prbf001"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf004
            #add-point:ON ACTION controlp INFIELD prbf004 name="construct.c.prbf004"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbf004  #顯示到畫面上

            NEXT FIELD prbf004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf004
            #add-point:BEFORE FIELD prbf004 name="construct.b.prbf004"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf004
            
            #add-point:AFTER FIELD prbf004 name="construct.a.prbf004"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf005
            #add-point:ON ACTION controlp INFIELD prbf005 name="construct.c.prbf005"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbf005  #顯示到畫面上

            NEXT FIELD prbf005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf005
            #add-point:BEFORE FIELD prbf005 name="construct.b.prbf005"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf005
            
            #add-point:AFTER FIELD prbf005 name="construct.a.prbf005"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf006
            #add-point:BEFORE FIELD prbf006 name="construct.b.prbf006"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf006
            
            #add-point:AFTER FIELD prbf006 name="construct.a.prbf006"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf006
            #add-point:ON ACTION controlp INFIELD prbf006 name="construct.c.prbf006"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf007
            #add-point:BEFORE FIELD prbf007 name="construct.b.prbf007"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf007
            
            #add-point:AFTER FIELD prbf007 name="construct.a.prbf007"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf007
            #add-point:ON ACTION controlp INFIELD prbf007 name="construct.c.prbf007"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf013
            #add-point:ON ACTION controlp INFIELD prbf013 name="construct.c.prbf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2135'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbf013  #顯示到畫面上
            NEXT FIELD prbf013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf013
            #add-point:BEFORE FIELD prbf013 name="construct.b.prbf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf013
            
            #add-point:AFTER FIELD prbf013 name="construct.a.prbf013"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfunit
            #add-point:BEFORE FIELD prbfunit name="construct.b.prbfunit"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfunit
            
            #add-point:AFTER FIELD prbfunit name="construct.a.prbfunit"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfunit
            #add-point:ON ACTION controlp INFIELD prbfunit name="construct.c.prbfunit"
                                                 #此段落由子樣板a08產生
            #END add-point
 
 
         #Ctrlp:construct.c.prbf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf010
            #add-point:ON ACTION controlp INFIELD prbf010 name="construct.c.prbf010"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbf010  #顯示到畫面上

            NEXT FIELD prbf010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf010
            #add-point:BEFORE FIELD prbf010 name="construct.b.prbf010"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf010
            
            #add-point:AFTER FIELD prbf010 name="construct.a.prbf010"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf012
            #add-point:BEFORE FIELD prbf012 name="construct.b.prbf012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf012
            
            #add-point:AFTER FIELD prbf012 name="construct.a.prbf012"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf012
            #add-point:ON ACTION controlp INFIELD prbf012 name="construct.c.prbf012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfud002
            #add-point:BEFORE FIELD prbfud002 name="construct.b.prbfud002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfud002
            
            #add-point:AFTER FIELD prbfud002 name="construct.a.prbfud002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfud002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfud002
            #add-point:ON ACTION controlp INFIELD prbfud002 name="construct.c.prbfud002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfud003
            #add-point:BEFORE FIELD prbfud003 name="construct.b.prbfud003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfud003
            
            #add-point:AFTER FIELD prbfud003 name="construct.a.prbfud003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfud003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfud003
            #add-point:ON ACTION controlp INFIELD prbfud003 name="construct.c.prbfud003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.prbf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf011
            #add-point:ON ACTION controlp INFIELD prbf011 name="construct.c.prbf011"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbf011  #顯示到畫面上

            NEXT FIELD prbf011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf011
            #add-point:BEFORE FIELD prbf011 name="construct.b.prbf011"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf011
            
            #add-point:AFTER FIELD prbf011 name="construct.a.prbf011"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfstus
            #add-point:BEFORE FIELD prbfstus name="construct.b.prbfstus"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfstus
            
            #add-point:AFTER FIELD prbfstus name="construct.a.prbfstus"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfstus
            #add-point:ON ACTION controlp INFIELD prbfstus name="construct.c.prbfstus"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfownid
            #add-point:ON ACTION controlp INFIELD prbfownid name="construct.c.prbfownid"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfownid  #顯示到畫面上

            NEXT FIELD prbfownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfownid
            #add-point:BEFORE FIELD prbfownid name="construct.b.prbfownid"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfownid
            
            #add-point:AFTER FIELD prbfownid name="construct.a.prbfownid"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfowndp
            #add-point:ON ACTION controlp INFIELD prbfowndp name="construct.c.prbfowndp"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfowndp  #顯示到畫面上

            NEXT FIELD prbfowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfowndp
            #add-point:BEFORE FIELD prbfowndp name="construct.b.prbfowndp"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfowndp
            
            #add-point:AFTER FIELD prbfowndp name="construct.a.prbfowndp"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfcrtid
            #add-point:ON ACTION controlp INFIELD prbfcrtid name="construct.c.prbfcrtid"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfcrtid  #顯示到畫面上

            NEXT FIELD prbfcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfcrtid
            #add-point:BEFORE FIELD prbfcrtid name="construct.b.prbfcrtid"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfcrtid
            
            #add-point:AFTER FIELD prbfcrtid name="construct.a.prbfcrtid"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.prbfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfcrtdp
            #add-point:ON ACTION controlp INFIELD prbfcrtdp name="construct.c.prbfcrtdp"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfcrtdp  #顯示到畫面上

            NEXT FIELD prbfcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfcrtdp
            #add-point:BEFORE FIELD prbfcrtdp name="construct.b.prbfcrtdp"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfcrtdp
            
            #add-point:AFTER FIELD prbfcrtdp name="construct.a.prbfcrtdp"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfcrtdt
            #add-point:BEFORE FIELD prbfcrtdt name="construct.b.prbfcrtdt"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfmodid
            #add-point:ON ACTION controlp INFIELD prbfmodid name="construct.c.prbfmodid"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfmodid  #顯示到畫面上

            NEXT FIELD prbfmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfmodid
            #add-point:BEFORE FIELD prbfmodid name="construct.b.prbfmodid"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfmodid
            
            #add-point:AFTER FIELD prbfmodid name="construct.a.prbfmodid"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfmoddt
            #add-point:BEFORE FIELD prbfmoddt name="construct.b.prbfmoddt"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.prbfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfcnfid
            #add-point:ON ACTION controlp INFIELD prbfcnfid name="construct.c.prbfcnfid"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbfcnfid  #顯示到畫面上

            NEXT FIELD prbfcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfcnfid
            #add-point:BEFORE FIELD prbfcnfid name="construct.b.prbfcnfid"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfcnfid
            
            #add-point:AFTER FIELD prbfcnfid name="construct.a.prbfcnfid"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfcnfdt
            #add-point:BEFORE FIELD prbfcnfdt name="construct.b.prbfcnfdt"
                                                                                                                                    
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON prbgunit,prbgseq,prbg001,prbgsite,prbg003,prbg002,rtaxl003,prbg024,prbg007, 
          prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbgseq1,prbg004,prbg005,prbg006,prbg006_desc, 
          prbg022,prbg014,prbg015,prbg018,prbg008,prbg008_desc,prbg016,prbg017,prbg019,prbg020,prbg013 
 
           FROM s_detail1[1].prbgunit,s_detail1[1].prbgseq,s_detail1[1].prbg001,s_detail1[1].prbgsite, 
               s_detail1[1].prbg003,s_detail1[1].prbg002,s_detail1[1].rtaxl003,s_detail1[1].prbg024, 
               s_detail1[1].prbg007,s_detail1[1].prbg023,s_detail1[1].prbg009,s_detail1[1].prbg010,s_detail1[1].prbg011, 
               s_detail1[1].prbg012,s_detail1[1].prbg025,s_detail1[1].prbg026,s_detail1[1].prbgseq1, 
               s_detail1[1].prbg004,s_detail1[1].prbg005,s_detail1[1].prbg006,s_detail1[1].prbg006_desc, 
               s_detail1[1].prbg022,s_detail1[1].prbg014,s_detail1[1].prbg015,s_detail1[1].prbg018,s_detail1[1].prbg008, 
               s_detail1[1].prbg008_desc,s_detail1[1].prbg016,s_detail1[1].prbg017,s_detail1[1].prbg019, 
               s_detail1[1].prbg020,s_detail1[1].prbg013
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                                                                                                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgunit
            #add-point:BEFORE FIELD prbgunit name="construct.b.page1.prbgunit"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgunit
            
            #add-point:AFTER FIELD prbgunit name="construct.a.page1.prbgunit"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgunit
            #add-point:ON ACTION controlp INFIELD prbgunit name="construct.c.page1.prbgunit"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgseq
            #add-point:BEFORE FIELD prbgseq name="construct.b.page1.prbgseq"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgseq
            
            #add-point:AFTER FIELD prbgseq name="construct.a.page1.prbgseq"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgseq
            #add-point:ON ACTION controlp INFIELD prbgseq name="construct.c.page1.prbgseq"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg001
            #add-point:BEFORE FIELD prbg001 name="construct.b.page1.prbg001"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg001
            
            #add-point:AFTER FIELD prbg001 name="construct.a.page1.prbg001"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg001
            #add-point:ON ACTION controlp INFIELD prbg001 name="construct.c.page1.prbg001"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgsite
            #add-point:BEFORE FIELD prbgsite name="construct.b.page1.prbgsite"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgsite
            
            #add-point:AFTER FIELD prbgsite name="construct.a.page1.prbgsite"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgsite
            #add-point:ON ACTION controlp INFIELD prbgsite name="construct.c.page1.prbgsite"
                                                                         #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site 
#            LET g_qryparam.arg2 = "8"     
#            CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbgsite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prbgsite  #顯示到畫面上

            NEXT FIELD prbgsite                     #返回原欄位                                                            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg003
            #add-point:ON ACTION controlp INFIELD prbg003 name="construct.c.page1.prbg003"
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO prbg003  #顯示到畫面上

            NEXT FIELD prbg003                     #返回原欄位                                                                                                                                   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg003
            #add-point:BEFORE FIELD prbg003 name="construct.b.page1.prbg003"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg003
            
            #add-point:AFTER FIELD prbg003 name="construct.a.page1.prbg003"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg002
            #add-point:ON ACTION controlp INFIELD prbg002 name="construct.c.page1.prbg002"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbg002  #顯示到畫面上

            NEXT FIELD prbg002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg002
            #add-point:BEFORE FIELD prbg002 name="construct.b.page1.prbg002"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg002
            
            #add-point:AFTER FIELD prbg002 name="construct.a.page1.prbg002"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaxl003
            #add-point:BEFORE FIELD rtaxl003 name="construct.b.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaxl003
            
            #add-point:AFTER FIELD rtaxl003 name="construct.a.page1.rtaxl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaxl003
            #add-point:ON ACTION controlp INFIELD rtaxl003 name="construct.c.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg024
            #add-point:BEFORE FIELD prbg024 name="construct.b.page1.prbg024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg024
            
            #add-point:AFTER FIELD prbg024 name="construct.a.page1.prbg024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg024
            #add-point:ON ACTION controlp INFIELD prbg024 name="construct.c.page1.prbg024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg007
            #add-point:BEFORE FIELD prbg007 name="construct.b.page1.prbg007"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg007
            
            #add-point:AFTER FIELD prbg007 name="construct.a.page1.prbg007"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg007
            #add-point:ON ACTION controlp INFIELD prbg007 name="construct.c.page1.prbg007"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg023
            #add-point:BEFORE FIELD prbg023 name="construct.b.page1.prbg023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg023
            
            #add-point:AFTER FIELD prbg023 name="construct.a.page1.prbg023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg023
            #add-point:ON ACTION controlp INFIELD prbg023 name="construct.c.page1.prbg023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg009
            #add-point:BEFORE FIELD prbg009 name="construct.b.page1.prbg009"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg009
            
            #add-point:AFTER FIELD prbg009 name="construct.a.page1.prbg009"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg009
            #add-point:ON ACTION controlp INFIELD prbg009 name="construct.c.page1.prbg009"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg010
            #add-point:BEFORE FIELD prbg010 name="construct.b.page1.prbg010"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg010
            
            #add-point:AFTER FIELD prbg010 name="construct.a.page1.prbg010"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg010
            #add-point:ON ACTION controlp INFIELD prbg010 name="construct.c.page1.prbg010"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg011
            #add-point:BEFORE FIELD prbg011 name="construct.b.page1.prbg011"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg011
            
            #add-point:AFTER FIELD prbg011 name="construct.a.page1.prbg011"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg011
            #add-point:ON ACTION controlp INFIELD prbg011 name="construct.c.page1.prbg011"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg012
            #add-point:BEFORE FIELD prbg012 name="construct.b.page1.prbg012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg012
            
            #add-point:AFTER FIELD prbg012 name="construct.a.page1.prbg012"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg012
            #add-point:ON ACTION controlp INFIELD prbg012 name="construct.c.page1.prbg012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg025
            #add-point:BEFORE FIELD prbg025 name="construct.b.page1.prbg025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg025
            
            #add-point:AFTER FIELD prbg025 name="construct.a.page1.prbg025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg025
            #add-point:ON ACTION controlp INFIELD prbg025 name="construct.c.page1.prbg025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg026
            #add-point:BEFORE FIELD prbg026 name="construct.b.page1.prbg026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg026
            
            #add-point:AFTER FIELD prbg026 name="construct.a.page1.prbg026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg026
            #add-point:ON ACTION controlp INFIELD prbg026 name="construct.c.page1.prbg026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgseq1
            #add-point:BEFORE FIELD prbgseq1 name="construct.b.page1.prbgseq1"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgseq1
            
            #add-point:AFTER FIELD prbgseq1 name="construct.a.page1.prbgseq1"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbgseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgseq1
            #add-point:ON ACTION controlp INFIELD prbgseq1 name="construct.c.page1.prbgseq1"
                                                                                                                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg004
            #add-point:BEFORE FIELD prbg004 name="construct.b.page1.prbg004"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg004
            
            #add-point:AFTER FIELD prbg004 name="construct.a.page1.prbg004"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg004
            #add-point:ON ACTION controlp INFIELD prbg004 name="construct.c.page1.prbg004"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg005
            #add-point:ON ACTION controlp INFIELD prbg005 name="construct.c.page1.prbg005"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbg005  #顯示到畫面上

            NEXT FIELD prbg005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg005
            #add-point:BEFORE FIELD prbg005 name="construct.b.page1.prbg005"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg005
            
            #add-point:AFTER FIELD prbg005 name="construct.a.page1.prbg005"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg006
            #add-point:ON ACTION controlp INFIELD prbg006 name="construct.c.page1.prbg006"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbg006  #顯示到畫面上

            NEXT FIELD prbg006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg006
            #add-point:BEFORE FIELD prbg006 name="construct.b.page1.prbg006"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg006
            
            #add-point:AFTER FIELD prbg006 name="construct.a.page1.prbg006"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg006_desc
            #add-point:BEFORE FIELD prbg006_desc name="construct.b.page1.prbg006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg006_desc
            
            #add-point:AFTER FIELD prbg006_desc name="construct.a.page1.prbg006_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg006_desc
            #add-point:ON ACTION controlp INFIELD prbg006_desc name="construct.c.page1.prbg006_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg022
            #add-point:BEFORE FIELD prbg022 name="construct.b.page1.prbg022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg022
            
            #add-point:AFTER FIELD prbg022 name="construct.a.page1.prbg022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg022
            #add-point:ON ACTION controlp INFIELD prbg022 name="construct.c.page1.prbg022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg014
            #add-point:BEFORE FIELD prbg014 name="construct.b.page1.prbg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg014
            
            #add-point:AFTER FIELD prbg014 name="construct.a.page1.prbg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg014
            #add-point:ON ACTION controlp INFIELD prbg014 name="construct.c.page1.prbg014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg015
            #add-point:BEFORE FIELD prbg015 name="construct.b.page1.prbg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg015
            
            #add-point:AFTER FIELD prbg015 name="construct.a.page1.prbg015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg015
            #add-point:ON ACTION controlp INFIELD prbg015 name="construct.c.page1.prbg015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.prbg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg018
            #add-point:ON ACTION controlp INFIELD prbg018 name="construct.c.page1.prbg018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbg018  #顯示到畫面上
            NEXT FIELD prbg018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg018
            #add-point:BEFORE FIELD prbg018 name="construct.b.page1.prbg018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg018
            
            #add-point:AFTER FIELD prbg018 name="construct.a.page1.prbg018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg008
            #add-point:ON ACTION controlp INFIELD prbg008 name="construct.c.page1.prbg008"
                                                                                                                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = g_site
            CALL q_oodb002_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbg008  #顯示到畫面上

            NEXT FIELD prbg008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg008
            #add-point:BEFORE FIELD prbg008 name="construct.b.page1.prbg008"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg008
            
            #add-point:AFTER FIELD prbg008 name="construct.a.page1.prbg008"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg008_desc
            #add-point:BEFORE FIELD prbg008_desc name="construct.b.page1.prbg008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg008_desc
            
            #add-point:AFTER FIELD prbg008_desc name="construct.a.page1.prbg008_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg008_desc
            #add-point:ON ACTION controlp INFIELD prbg008_desc name="construct.c.page1.prbg008_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg016
            #add-point:BEFORE FIELD prbg016 name="construct.b.page1.prbg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg016
            
            #add-point:AFTER FIELD prbg016 name="construct.a.page1.prbg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg016
            #add-point:ON ACTION controlp INFIELD prbg016 name="construct.c.page1.prbg016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg017
            #add-point:BEFORE FIELD prbg017 name="construct.b.page1.prbg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg017
            
            #add-point:AFTER FIELD prbg017 name="construct.a.page1.prbg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg017
            #add-point:ON ACTION controlp INFIELD prbg017 name="construct.c.page1.prbg017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg019
            #add-point:BEFORE FIELD prbg019 name="construct.b.page1.prbg019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg019
            
            #add-point:AFTER FIELD prbg019 name="construct.a.page1.prbg019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg019
            #add-point:ON ACTION controlp INFIELD prbg019 name="construct.c.page1.prbg019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg020
            #add-point:BEFORE FIELD prbg020 name="construct.b.page1.prbg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg020
            
            #add-point:AFTER FIELD prbg020 name="construct.a.page1.prbg020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg020
            #add-point:ON ACTION controlp INFIELD prbg020 name="construct.c.page1.prbg020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg013
            #add-point:BEFORE FIELD prbg013 name="construct.b.page1.prbg013"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg013
            
            #add-point:AFTER FIELD prbg013 name="construct.a.page1.prbg013"
                                                                                                                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.prbg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg013
            #add-point:ON ACTION controlp INFIELD prbg013 name="construct.c.page1.prbg013"
                                                                                                                                    
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON prbvstus,prbv001
           FROM s_detail3[1].prbvstus,s_detail3[1].prbv001
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbvcrtdt>>----
 
         #----<<prbvmoddt>>----
         
         #----<<prbvcnfdt>>----
         
         #----<<prbvpstdt>>----
 
 
 
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbvstus
            #add-point:BEFORE FIELD prbvstus name="construct.b.page3.prbvstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbvstus
            
            #add-point:AFTER FIELD prbvstus name="construct.a.page3.prbvstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.prbvstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbvstus
            #add-point:ON ACTION controlp INFIELD prbvstus name="construct.c.page3.prbvstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.prbv001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbv001
            #add-point:ON ACTION controlp INFIELD prbv001 name="construct.c.page3.prbv001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbv001  #顯示到畫面上
            NEXT FIELD prbv001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbv001
            #add-point:BEFORE FIELD prbv001 name="construct.b.page3.prbv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbv001
            
            #add-point:AFTER FIELD prbv001 name="construct.a.page3.prbv001"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON prbwseq,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005,prbw006,prbw007, 
          prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015,prbw016,prbw020,prbw021, 
          prbw017,prbw018
           FROM s_detail4[1].prbwseq,s_detail4[1].prbwsite,s_detail4[1].prbw001,s_detail4[1].prbw002, 
               s_detail4[1].prbw003,s_detail4[1].prbw004,s_detail4[1].prbw005,s_detail4[1].prbw006,s_detail4[1].prbw007, 
               s_detail4[1].prbw008,s_detail4[1].prbw009,s_detail4[1].prbw010,s_detail4[1].prbw011,s_detail4[1].prbw012, 
               s_detail4[1].prbw013,s_detail4[1].prbw014,s_detail4[1].prbw022,s_detail4[1].prbw015,s_detail4[1].prbw016, 
               s_detail4[1].prbw020,s_detail4[1].prbw021,s_detail4[1].prbw017,s_detail4[1].prbw018
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body3.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbwseq
            #add-point:BEFORE FIELD prbwseq name="construct.b.page4.prbwseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbwseq
            
            #add-point:AFTER FIELD prbwseq name="construct.a.page4.prbwseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbwseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbwseq
            #add-point:ON ACTION controlp INFIELD prbwseq name="construct.c.page4.prbwseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbwsite
            #add-point:BEFORE FIELD prbwsite name="construct.b.page4.prbwsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbwsite
            
            #add-point:AFTER FIELD prbwsite name="construct.a.page4.prbwsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbwsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbwsite
            #add-point:ON ACTION controlp INFIELD prbwsite name="construct.c.page4.prbwsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw001
            #add-point:BEFORE FIELD prbw001 name="construct.b.page4.prbw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw001
            
            #add-point:AFTER FIELD prbw001 name="construct.a.page4.prbw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw001
            #add-point:ON ACTION controlp INFIELD prbw001 name="construct.c.page4.prbw001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw002
            #add-point:BEFORE FIELD prbw002 name="construct.b.page4.prbw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw002
            
            #add-point:AFTER FIELD prbw002 name="construct.a.page4.prbw002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw002
            #add-point:ON ACTION controlp INFIELD prbw002 name="construct.c.page4.prbw002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw003
            #add-point:BEFORE FIELD prbw003 name="construct.b.page4.prbw003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw003
            
            #add-point:AFTER FIELD prbw003 name="construct.a.page4.prbw003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw003
            #add-point:ON ACTION controlp INFIELD prbw003 name="construct.c.page4.prbw003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw004
            #add-point:BEFORE FIELD prbw004 name="construct.b.page4.prbw004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw004
            
            #add-point:AFTER FIELD prbw004 name="construct.a.page4.prbw004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw004
            #add-point:ON ACTION controlp INFIELD prbw004 name="construct.c.page4.prbw004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw005
            #add-point:BEFORE FIELD prbw005 name="construct.b.page4.prbw005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw005
            
            #add-point:AFTER FIELD prbw005 name="construct.a.page4.prbw005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw005
            #add-point:ON ACTION controlp INFIELD prbw005 name="construct.c.page4.prbw005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw006
            #add-point:BEFORE FIELD prbw006 name="construct.b.page4.prbw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw006
            
            #add-point:AFTER FIELD prbw006 name="construct.a.page4.prbw006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw006
            #add-point:ON ACTION controlp INFIELD prbw006 name="construct.c.page4.prbw006"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw007
            #add-point:BEFORE FIELD prbw007 name="construct.b.page4.prbw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw007
            
            #add-point:AFTER FIELD prbw007 name="construct.a.page4.prbw007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw007
            #add-point:ON ACTION controlp INFIELD prbw007 name="construct.c.page4.prbw007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw008
            #add-point:BEFORE FIELD prbw008 name="construct.b.page4.prbw008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw008
            
            #add-point:AFTER FIELD prbw008 name="construct.a.page4.prbw008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw008
            #add-point:ON ACTION controlp INFIELD prbw008 name="construct.c.page4.prbw008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw009
            #add-point:BEFORE FIELD prbw009 name="construct.b.page4.prbw009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw009
            
            #add-point:AFTER FIELD prbw009 name="construct.a.page4.prbw009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw009
            #add-point:ON ACTION controlp INFIELD prbw009 name="construct.c.page4.prbw009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw010
            #add-point:BEFORE FIELD prbw010 name="construct.b.page4.prbw010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw010
            
            #add-point:AFTER FIELD prbw010 name="construct.a.page4.prbw010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw010
            #add-point:ON ACTION controlp INFIELD prbw010 name="construct.c.page4.prbw010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw011
            #add-point:BEFORE FIELD prbw011 name="construct.b.page4.prbw011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw011
            
            #add-point:AFTER FIELD prbw011 name="construct.a.page4.prbw011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw011
            #add-point:ON ACTION controlp INFIELD prbw011 name="construct.c.page4.prbw011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw012
            #add-point:BEFORE FIELD prbw012 name="construct.b.page4.prbw012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw012
            
            #add-point:AFTER FIELD prbw012 name="construct.a.page4.prbw012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw012
            #add-point:ON ACTION controlp INFIELD prbw012 name="construct.c.page4.prbw012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw013
            #add-point:BEFORE FIELD prbw013 name="construct.b.page4.prbw013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw013
            
            #add-point:AFTER FIELD prbw013 name="construct.a.page4.prbw013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw013
            #add-point:ON ACTION controlp INFIELD prbw013 name="construct.c.page4.prbw013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw014
            #add-point:BEFORE FIELD prbw014 name="construct.b.page4.prbw014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw014
            
            #add-point:AFTER FIELD prbw014 name="construct.a.page4.prbw014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw014
            #add-point:ON ACTION controlp INFIELD prbw014 name="construct.c.page4.prbw014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw022
            #add-point:BEFORE FIELD prbw022 name="construct.b.page4.prbw022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw022
            
            #add-point:AFTER FIELD prbw022 name="construct.a.page4.prbw022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw022
            #add-point:ON ACTION controlp INFIELD prbw022 name="construct.c.page4.prbw022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw015
            #add-point:BEFORE FIELD prbw015 name="construct.b.page4.prbw015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw015
            
            #add-point:AFTER FIELD prbw015 name="construct.a.page4.prbw015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw015
            #add-point:ON ACTION controlp INFIELD prbw015 name="construct.c.page4.prbw015"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw016
            #add-point:BEFORE FIELD prbw016 name="construct.b.page4.prbw016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw016
            
            #add-point:AFTER FIELD prbw016 name="construct.a.page4.prbw016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw016
            #add-point:ON ACTION controlp INFIELD prbw016 name="construct.c.page4.prbw016"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw020
            #add-point:BEFORE FIELD prbw020 name="construct.b.page4.prbw020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw020
            
            #add-point:AFTER FIELD prbw020 name="construct.a.page4.prbw020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw020
            #add-point:ON ACTION controlp INFIELD prbw020 name="construct.c.page4.prbw020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw021
            #add-point:BEFORE FIELD prbw021 name="construct.b.page4.prbw021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw021
            
            #add-point:AFTER FIELD prbw021 name="construct.a.page4.prbw021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw021
            #add-point:ON ACTION controlp INFIELD prbw021 name="construct.c.page4.prbw021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw017
            #add-point:BEFORE FIELD prbw017 name="construct.b.page4.prbw017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw017
            
            #add-point:AFTER FIELD prbw017 name="construct.a.page4.prbw017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw017
            #add-point:ON ACTION controlp INFIELD prbw017 name="construct.c.page4.prbw017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw018
            #add-point:BEFORE FIELD prbw018 name="construct.b.page4.prbw018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw018
            
            #add-point:AFTER FIELD prbw018 name="construct.a.page4.prbw018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.prbw018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw018
            #add-point:ON ACTION controlp INFIELD prbw018 name="construct.c.page4.prbw018"
            
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
                  WHEN la_wc[li_idx].tableid = "prbf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prbg_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "prbv_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
                  WHEN la_wc[li_idx].tableid = "prbw_t" 
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
 
{<section id="aprt111.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aprt111_filter()
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
      CONSTRUCT g_wc_filter ON prbfunit,prbfdocdt,prbfdocno,prbf004,prbf005,prbf006,prbf010,prbf011, 
          prbf012
                          FROM s_browse[1].b_prbfunit,s_browse[1].b_prbfdocdt,s_browse[1].b_prbfdocno, 
                              s_browse[1].b_prbf004,s_browse[1].b_prbf005,s_browse[1].b_prbf006,s_browse[1].b_prbf010, 
                              s_browse[1].b_prbf011,s_browse[1].b_prbf012
 
         BEFORE CONSTRUCT
               DISPLAY aprt111_filter_parser('prbfunit') TO s_browse[1].b_prbfunit
            DISPLAY aprt111_filter_parser('prbfdocdt') TO s_browse[1].b_prbfdocdt
            DISPLAY aprt111_filter_parser('prbfdocno') TO s_browse[1].b_prbfdocno
            DISPLAY aprt111_filter_parser('prbf004') TO s_browse[1].b_prbf004
            DISPLAY aprt111_filter_parser('prbf005') TO s_browse[1].b_prbf005
            DISPLAY aprt111_filter_parser('prbf006') TO s_browse[1].b_prbf006
            DISPLAY aprt111_filter_parser('prbf010') TO s_browse[1].b_prbf010
            DISPLAY aprt111_filter_parser('prbf011') TO s_browse[1].b_prbf011
            DISPLAY aprt111_filter_parser('prbf012') TO s_browse[1].b_prbf012
      
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
 
      CALL aprt111_filter_show('prbfunit')
   CALL aprt111_filter_show('prbfdocdt')
   CALL aprt111_filter_show('prbfdocno')
   CALL aprt111_filter_show('prbf004')
   CALL aprt111_filter_show('prbf005')
   CALL aprt111_filter_show('prbf006')
   CALL aprt111_filter_show('prbf010')
   CALL aprt111_filter_show('prbf011')
   CALL aprt111_filter_show('prbf012')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aprt111_filter_parser(ps_field)
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
 
{<section id="aprt111.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aprt111_filter_show(ps_field)
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
   LET ls_condition = aprt111_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aprt111_query()
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
   CALL g_prbg_d.clear()
   CALL g_prbg3_d.clear()
   CALL g_prbg4_d.clear()
 
   
   #add-point:query段other name="query.other"
                                 
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aprt111_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aprt111_browser_fill("")
      CALL aprt111_fetch("")
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
      CALL aprt111_filter_show('prbfunit')
   CALL aprt111_filter_show('prbfdocdt')
   CALL aprt111_filter_show('prbfdocno')
   CALL aprt111_filter_show('prbf004')
   CALL aprt111_filter_show('prbf005')
   CALL aprt111_filter_show('prbf006')
   CALL aprt111_filter_show('prbf010')
   CALL aprt111_filter_show('prbf011')
   CALL aprt111_filter_show('prbf012')
   CALL aprt111_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aprt111_fetch("F") 
      #顯示單身筆數
      CALL aprt111_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aprt111_fetch(p_flag)
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
   
   LET g_prbf_m.prbfdocno = g_browser[g_current_idx].b_prbfdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
   #遮罩相關處理
   LET g_prbf_m_mask_o.* =  g_prbf_m.*
   CALL aprt111_prbf_t_mask()
   LET g_prbf_m_mask_n.* =  g_prbf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt111_set_act_visible()   
   CALL aprt111_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   #IF g_prbf_m.prbfstus = 'N' THEN                #151109-00006#4 151223 mark TT.Jessica
   IF g_prbf_m.prbfstus MATCHES '[NDR]' THEN   # N未確認/D抽單/R已拒絕允許修改  #151109-00006#4 151223 add TT.Jessica
      CALL cl_set_act_visible("modify,delete,modify_detail",TRUE)
   ELSE
      CALL cl_set_act_visible("modify,delete,modify_detail",FALSE)
   END IF                                  
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
                                 
   #end add-point
   
   #保存單頭舊值
   LET g_prbf_m_t.* = g_prbf_m.*
   LET g_prbf_m_o.* = g_prbf_m.*
   
   LET g_data_owner = g_prbf_m.prbfownid      
   LET g_data_dept  = g_prbf_m.prbfowndp
   
   #重新顯示   
   CALL aprt111_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.insert" >}
#+ 資料新增
PRIVATE FUNCTION aprt111_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
                  DEFINE l_flag        LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004   
   DEFINE l_insert      LIKE type_t.num5 
   DEFINE l_n           LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_prbg_d.clear()   
   CALL g_prbg3_d.clear()  
   CALL g_prbg4_d.clear()  
 
 
   INITIALIZE g_prbf_m.* TO NULL             #DEFAULT 設定
   
   LET g_prbfdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   CALL g_prbk_d.clear()    #20151105 dongsz add
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbf_m.prbfownid = g_user
      LET g_prbf_m.prbfowndp = g_dept
      LET g_prbf_m.prbfcrtid = g_user
      LET g_prbf_m.prbfcrtdp = g_dept 
      LET g_prbf_m.prbfcrtdt = cl_get_current()
      LET g_prbf_m.prbfmodid = g_user
      LET g_prbf_m.prbfmoddt = cl_get_current()
      LET g_prbf_m.prbfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_prbf_m.prbfud002 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
#                  LET g_prbf_m.prbfsite = g_site
#                  LET g_prbf_m.prbfunit = g_site            
      LET g_site_flag = FALSE
      CALL s_aooi500_default(g_prog,'prbfsite',g_prbf_m.prbfsite)
         RETURNING l_insert,g_prbf_m.prbfsite
      IF NOT l_insert THEN
         RETURN
      END IF
      LET g_prbf_m.prbfunit = g_prbf_m.prbfsite 
      LET g_prbf_m.prbfdocdt = g_today
      LET g_prbf_m.prbf001 = g_prbf001
      LET g_prbf_m.prbf002 = '1'
      LET g_prbf_m.prbf006 = g_today + 1
      #150903-00008#12--dongsz add--str---
      IF g_prbf001 MATCHES '[36789]' THEN
         LET g_prbf_m.prbf007 = g_today + 1
      END IF
      #150903-00008#12--dongsz add--end---      
      #150401-00003#1--mark by dongsz--str---                  
#      IF g_prbf001 = '3' THEN
#         LET g_prbf_m.prbf007 = g_today     
#         LET g_prbf_m.prbf008 = '00:00:00'  
#         LET g_prbf_m.prbf009 = '23:59:59'  
#      END IF
      #150401-00003#1--mark by dongsz--end---
      LET g_prbf_m.prbfstus = 'N'
      LET g_prbf_m.prbf010 = g_user
      LET g_prbf_m.prbf011 = g_dept
      LET g_prbf_m.prbfud002 = '1'  #add by guomy 2015/10/21
      #dongsz--add--str---
      #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(g_prbf_m.prbfsite,g_prog,'1')
           RETURNING r_success,r_doctype
      LET g_prbf_m.prbfdocno = r_doctype
      #dongsz--add--end---
      
      #150401-00003#1--add by dongsz--str---
      #預設arti204部門品類預設值
      SELECT COUNT(*) INTO l_n
        FROM rtaz_t
       WHERE rtazent = g_enterprise
         AND rtaz001 = g_prog
         AND rtazstus = 'Y'
      IF l_n > 0 THEN
         SELECT COUNT(*) INTO l_n
           FROM rtay_t,rtax_t
          WHERE rtayent = g_enterprise
            AND rtayent = rtaxent
            AND rtay001 = g_prbf_m.prbf011
            AND rtax001 = rtay002
            AND rtax002 = '2'
            AND rtaystus = rtaxstus
            AND rtaystus = 'Y'
         IF l_n = 1 THEN
            SELECT rtay002 INTO g_prbf_m.prbf005
              FROM rtay_t,rtax_t
             WHERE rtayent = g_enterprise
               AND rtayent = rtaxent
               AND rtay001 = g_prbf_m.prbf011
               AND rtax001 = rtay002
               AND rtax002 = '2'
               AND rtaystus = rtaxstus
               AND rtaystus = 'Y'
         END IF
      END IF
      #150401-00003#1--add by dongsz--end---
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbf_m.prbf010
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_prbf_m.prbf010_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbf_m.prbf010_desc
            
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbf_m.prbf011
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbf_m.prbf011_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbf_m.prbf011_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prbf_m.prbfsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_prbf_m.prbfsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prbf_m.prbfsite_desc 
      
      LET g_prbf_m_t.* = g_prbf_m.* 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_prbf_m_t.* = g_prbf_m.*
      LET g_prbf_m_o.* = g_prbf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbf_m.prbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/ended.png")
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
 
 
 
    
      CALL aprt111_input("a")
      
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
         INITIALIZE g_prbf_m.* TO NULL
         INITIALIZE g_prbg_d TO NULL
         INITIALIZE g_prbg3_d TO NULL
         INITIALIZE g_prbg4_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aprt111_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_prbg_d.clear()
      #CALL g_prbg3_d.clear()
      #CALL g_prbg4_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aprt111_set_act_visible()   
   CALL aprt111_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prbfent = " ||g_enterprise|| " AND",
                      " prbfdocno = '", g_prbf_m.prbfdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt111_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aprt111_cl
   
   CALL aprt111_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_prbf_m_mask_o.* =  g_prbf_m.*
   CALL aprt111_prbf_t_mask()
   LET g_prbf_m_mask_n.* =  g_prbf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002, 
       g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf004_desc,g_prbf_m.prbf005,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbf013_desc,g_prbf_m.prbfunit,g_prbf_m.prbf010, 
       g_prbf_m.prbf010_desc,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011, 
       g_prbf_m.prbf011_desc,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdp_desc, 
       g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid, 
       g_prbf_m.prbfcnfid_desc,g_prbf_m.prbfcnfdt
   
   #add-point:新增結束後 name="insert.after"
   CALL aprt111_show()        #150401-00003#1--add by dongsz
   #end add-point 
   
   LET g_data_owner = g_prbf_m.prbfownid      
   LET g_data_dept  = g_prbf_m.prbfowndp
   
   #功能已完成,通報訊息中心
   CALL aprt111_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.modify" >}
#+ 資料修改
PRIVATE FUNCTION aprt111_modify()
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
   LET g_prbf_m_t.* = g_prbf_m.*
   LET g_prbf_m_o.* = g_prbf_m.*
   
   IF g_prbf_m.prbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
   CALL s_transaction_begin()
   
   OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aprt111_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbf_m_mask_o.* =  g_prbf_m.*
   CALL aprt111_prbf_t_mask()
   LET g_prbf_m_mask_n.* =  g_prbf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
   #LET l_wc2_table3 = g_wc2_table3
   #LET l_wc2_table3 = " 1=1"
 
 
 
   
   CALL aprt111_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
   #LET  g_wc2_table3 = l_wc2_table3 
 
 
 
    
   WHILE TRUE
      LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_prbf_m.prbfmodid = g_user 
LET g_prbf_m.prbfmoddt = cl_get_current()
LET g_prbf_m.prbfmodid_desc = cl_get_username(g_prbf_m.prbfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_prbf_m.prbfstus MATCHES "[DR]" THEN
         LET g_prbf_m.prbfstus = "N"
      END IF                                                            
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aprt111_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                                                                  
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE prbf_t SET (prbfmodid,prbfmoddt) = (g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt)
          WHERE prbfent = g_enterprise AND prbfdocno = g_prbfdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_prbf_m.* = g_prbf_m_t.*
            CALL aprt111_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_prbf_m.prbfdocno != g_prbf_m_t.prbfdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
                                                                                                   
         #end add-point
         
         #更新單身key值
         UPDATE prbg_t SET prbgdocno = g_prbf_m.prbfdocno
 
          WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m_t.prbfdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                                                                                                   
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prbg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
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
         
         UPDATE prbv_t
            SET prbvdocno = g_prbf_m.prbfdocno
 
          WHERE prbvent = g_enterprise AND
                prbvdocno = g_prbfdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prbv_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
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
         
         UPDATE prbw_t
            SET prbwdocno = g_prbf_m.prbfdocno
 
          WHERE prbwent = g_enterprise AND
                prbwdocno = g_prbfdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update3"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "prbw_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
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
   CALL aprt111_set_act_visible()   
   CALL aprt111_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " prbfent = " ||g_enterprise|| " AND",
                      " prbfdocno = '", g_prbf_m.prbfdocno, "' "
 
   #填到對應位置
   CALL aprt111_browser_fill("")
 
   CLOSE aprt111_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt111_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aprt111.input" >}
#+ 資料輸入
PRIVATE FUNCTION aprt111_input(p_cmd)
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
   DEFINE  l_flag                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_ooaa002             LIKE ooaa_t.ooaa002
   DEFINE  l_prbgsite            LIKE prbg_t.prbgsite
   DEFINE  l_prbg001             LIKE prbg_t.prbg001
   DEFINE  l_rtaa002             LIKE rtaa_t.rtaa002
   DEFINE  l_rtaastus            LIKE rtaa_t.rtaastus
   DEFINE  l_imaastus            LIKE imaa_t.imaastus
   DEFINE  l_imaystus            LIKE imay_t.imaystus
   DEFINE  l_imay006             LIKE imay_t.imay006
   #150312-00002#5 Modify-S By Ken 150317 原rtdx031換成imaf153
   #DEFINE  l_rtdx031             LIKE rtdx_t.rtdx031
   DEFINE  l_imaf153             LIKE imaf_t.imaf153
   #150312-00002#5 Modify-E
   DEFINE  l_sql                 STRING   
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_ooez006             LIKE ooez_t.ooez006
   DEFINE  l_ooez007             LIKE ooez_t.ooez007
   DEFINE  l_ooef019             LIKE ooef_t.ooef019   
   DEFINE  l_prbg007             LIKE prbg_t.prbg007
   DEFINE  l_prbg009             LIKE prbg_t.prbg009 
   DEFINE  l_rtax004             LIKE rtax_t.rtax004 
   DEFINE  l_prbv001_str         STRING                 #20151102 dongsz add   
   DEFINE  l_chk_type            LIKE type_t.chr1       #檢查價格類型：1.促銷售價2.促銷散客價3.促銷會員價   #170105-00015#1 170106 by lori add
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
   DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002, 
       g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf004_desc,g_prbf_m.prbf005,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbf013_desc,g_prbf_m.prbfunit,g_prbf_m.prbf010, 
       g_prbf_m.prbf010_desc,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011, 
       g_prbf_m.prbf011_desc,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdp_desc, 
       g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid, 
       g_prbf_m.prbfcnfid_desc,g_prbf_m.prbfcnfdt
   
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
   LET g_forupd_sql = "SELECT prbgunit,prbgseq,prbg001,prbgsite,prbg003,prbg002,prbg024,prbg021,prbg007, 
       prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbgseq1,prbg004,prbg005,prbg006,prbg022, 
       prbg014,prbg015,prbg018,prbg008,prbg016,prbg017,prbg019,prbg020,prbg013 FROM prbg_t WHERE prbgent=?  
       AND prbgdocno=? AND prbgseq=? AND prbgseq1=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
                                 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt111_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prbvstus,prbv001 FROM prbv_t WHERE prbvent=? AND prbvdocno=? AND prbv001=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt111_bcl2 CURSOR FROM g_forupd_sql
 
   #add-point:input段define_sql name="input.define_sql3"
   
   #end add-point    
   LET g_forupd_sql = "SELECT prbwseq,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005,prbw006,prbw007, 
       prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015,prbw016,prbw020,prbw021, 
       prbw017,prbw018 FROM prbw_t WHERE prbwent=? AND prbwdocno=? AND prbwseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql3"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprt111_bcl3 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
                                 
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aprt111_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
                                 
   #end add-point
   CALL aprt111_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003, 
       g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005,g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013, 
       g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011, 
       g_prbf_m.prbfstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
                                 
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aprt111.input.head" >}
      #單頭段
      INPUT BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003, 
          g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005,g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013, 
          g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003, 
          g_prbf_m.prbf011,g_prbf_m.prbfstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt111_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aprt111_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #CALL cl_showmsg_init()                                                                                                        
            #end add-point
            CALL aprt111_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfsite
            
            #add-point:AFTER FIELD prbfsite name="input.a.prbfsite"
            IF NOT cl_null(g_prbf_m.prbfsite) THEN
               CALL s_aooi500_chk(g_prog,'prbfsite',g_prbf_m.prbfsite,g_prbf_m.prbfsite) RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_prbf_m.prbfsite
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()

                  LET g_prbf_m.prbfsite = g_prbf_m_t.prbfsite
                  CALL s_desc_get_department_desc(g_prbf_m.prbfsite) RETURNING g_prbf_m.prbfsite_desc
                  DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc
                  NEXT FIELD CURRENT
               END IF

               LET g_site_flag = TRUE
               CALL aprt111_set_entry(p_cmd)
               CALL aprt111_set_no_entry(p_cmd)
            END IF        
            
            CALL s_desc_get_department_desc(g_prbf_m.prbfsite) RETURNING g_prbf_m.prbfsite_desc
            DISPLAY BY NAME g_prbf_m.prbfsite_desc            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfsite
            #add-point:BEFORE FIELD prbfsite name="input.b.prbfsite"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfsite
            #add-point:ON CHANGE prbfsite name="input.g.prbfsite"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfdocdt
            #add-point:BEFORE FIELD prbfdocdt name="input.b.prbfdocdt"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfdocdt
            
            #add-point:AFTER FIELD prbfdocdt name="input.a.prbfdocdt"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfdocdt
            #add-point:ON CHANGE prbfdocdt name="input.g.prbfdocdt"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfdocno
            
            #add-point:AFTER FIELD prbfdocno name="input.a.prbfdocno"
                                                                                                                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_prbf_m.prbfdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_prbf_m.prbfdocno != g_prbfdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbf_t WHERE "||"prbfent = '" ||g_enterprise|| "' AND "||"prbfdocno = '"||g_prbf_m.prbfdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_prbf_m.prbfdocno) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               CALL s_aooi100_sel_ooef004(g_prbf_m.prbfsite)
                    RETURNING l_success,l_ooef004
               LET g_chkparam.arg1 = l_ooef004
               LET g_chkparam.arg2 = g_prbf_m.prbfdocno

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooba002") THEN
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
         BEFORE FIELD prbfdocno
            #add-point:BEFORE FIELD prbfdocno name="input.b.prbfdocno"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfdocno
            #add-point:ON CHANGE prbfdocno name="input.g.prbfdocno"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf002
            #add-point:BEFORE FIELD prbf002 name="input.b.prbf002"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf002
            
            #add-point:AFTER FIELD prbf002 name="input.a.prbf002"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf002
            #add-point:ON CHANGE prbf002 name="input.g.prbf002"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf003
            #add-point:BEFORE FIELD prbf003 name="input.b.prbf003"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf003
            
            #add-point:AFTER FIELD prbf003 name="input.a.prbf003"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf003
            #add-point:ON CHANGE prbf003 name="input.g.prbf003"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf001
            #add-point:BEFORE FIELD prbf001 name="input.b.prbf001"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf001
            
            #add-point:AFTER FIELD prbf001 name="input.a.prbf001"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf001
            #add-point:ON CHANGE prbf001 name="input.g.prbf001"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf004
            
            #add-point:AFTER FIELD prbf004 name="input.a.prbf004"
                                                                                                                                    
            IF NOT cl_null(g_prbf_m.prbf004) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbf_m.prbf004

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_1") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbf_m.prbf004 = g_prbf_m_t.prbf004
                  LET g_prbf_m.prbf004_desc = ''
                  DISPLAY BY NAME g_prbf_m.prbf004,g_prbf_m.prbf004_desc
                  NEXT FIELD CURRENT
               END IF
            
               IF p_cmd = 'u' THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM prbg_t
                   WHERE prbgent = g_enterprise
                     AND prbgdocno = g_prbf_m.prbfdocno
                     AND prbg001 = '2'
                  IF l_n > 0 THEN
                     #150312-00002#5 Modify-S By Ken 150317 原rtdx031換成imaf153
                     #SELECT COUNT(*) INTO l_n FROM rtdx_t,prbg_t
                     # WHERE rtdxent = prbgent
                     #   AND rtdx001 = prbg002
                     #   AND rtdxent = g_enterprise
                     #   AND prbgdocno = g_prbf_m.prbfdocno
                     #   AND rtdx031 <> g_prbf_m.prbf004
                     #   AND rtdxsite = prbgsite
                     #   AND prbg001 = '2'
                     
                     SELECT COUNT(*) INTO l_n FROM imaf_t,prbg_t
                      WHERE imafent = prbgent
                        AND imaf001 = prbg002
                        AND imafent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND imaf153 <> g_prbf_m.prbf004
                        AND imafsite = prbgsite
                        AND prbg001 = '2'
                     #150312-00002#5 Modify-E                     
                     IF l_n > 0 THEN                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00061'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbf_m.prbf004 = g_prbf_m_t.prbf004
                        DISPLAY BY NAME g_prbf_m.prbf004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM prbg_t
                   WHERE prbgent = g_enterprise
                     AND prbgdocno = g_prbf_m.prbfdocno
                     AND prbg001 = '1'
                  IF l_n > 0 THEN
                     #150312-00002#5 Modify-S By Ken 150317 原rtdx031換成imaf153
                     #SELECT COUNT(*) INTO l_n FROM rtdx_t,prbg_t
                     # WHERE rtdxent = prbgent
                     #   AND rtdx001 = prbg002
                     #   AND rtdxent = g_enterprise
                     #   AND prbgdocno = g_prbf_m.prbfdocno
                     #   AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = prbgsite)
                     #   AND rtdx031 = g_prbf_m.prbf004
                     #   AND prbg001 = '1'
                     
                     SELECT COUNT(*) INTO l_n FROM imaf_t,prbg_t
                      WHERE imafent = prbgent
                        AND imaf001 = prbg002
                        AND imafent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND imafsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = prbgsite)
                        AND imaf153 = g_prbf_m.prbf004
                        AND prbg001 = '1'
                     #150312-00002#5 Modify-E   
                     IF l_n < 1 THEN                        
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00061'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbf_m.prbf004 = g_prbf_m_t.prbf004
                        DISPLAY BY NAME g_prbf_m.prbf004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf004
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf004
            #add-point:BEFORE FIELD prbf004 name="input.b.prbf004"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf004
            #add-point:ON CHANGE prbf004 name="input.g.prbf004"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf005
            
            #add-point:AFTER FIELD prbf005 name="input.a.prbf005"
                                                                                                                                    
            #IF NOT cl_null(g_prbf_m.prbf005) AND g_prbf_m.prbf005 <> 'ALL' THEN      #150401-00003#1--mark by dongsz
            IF NOT cl_null(g_prbf_m.prbf005) THEN                                     #150401-00003#1--add by dongsz
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
#               SELECT ooaa002 INTO l_ooaa002 FROM ooaa_t 
#                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0001'
               LET g_chkparam.arg1 = g_prbf_m.prbf005
               LET g_chkparam.arg2 = l_rtax004
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001_3") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbf_m.prbf005 = g_prbf_m_t.prbf005
                  LET g_prbf_m.prbf005_desc = ''
                  DISPLAY BY NAME g_prbf_m.prbf005,g_prbf_m.prbf005_desc
                  NEXT FIELD CURRENT
               END IF
               
               #150401-00003#1--add by dongsz--str---
               IF NOT cl_null(g_prbf_m.prbf011) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_prbf_m.prbf011
                        AND rtay002 = g_prbf_m.prbf005
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_prbf_m.prbf005 = g_prbf_m_t.prbf005
                        DISPLAY BY NAME g_prbf_m.prbf005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #150401-00003#1--add by dongsz--end---
            
               IF p_cmd = 'u' AND g_prbf_m.prbf005 <> g_prbf_m_t.prbf005 THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM prbg_t
                   WHERE prbgent = g_enterprise
                     AND prbgdocno = g_prbf_m.prbfdocno
                  IF l_n > 0 THEN
                     SELECT COUNT(*) INTO l_n FROM imaa_t,prbg_t
                      WHERE imaaent = prbgent 
                        AND imaa001 = prbg002
                        AND imaaent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND imaa009 <> g_prbf_m.prbf005
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00062'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbf_m.prbf005 = g_prbf_m_t.prbf005
                        DISPLAY BY NAME g_prbf_m.prbf005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf005
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf005
            #add-point:BEFORE FIELD prbf005 name="input.b.prbf005"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf005
            #add-point:ON CHANGE prbf005 name="input.g.prbf005"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf006
            #add-point:BEFORE FIELD prbf006 name="input.b.prbf006"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf006
            
            #add-point:AFTER FIELD prbf006 name="input.a.prbf006"
            IF NOT cl_null(g_prbf_m.prbf006) THEN
               IF g_prbf_m.prbf006 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00027'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbf_m.prbf006 = g_prbf_m_t.prbf006
                  DISPLAY BY NAME g_prbf_m.prbf006
                  NEXT FIELD prbf006
               END IF
               #150401-00003#1--mark by dongsz--str---
               IF NOT cl_null(g_prbf_m.prbf007) THEN
                  IF g_prbf_m.prbf007 < g_prbf_m.prbf006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00049'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     LET g_prbf_m.prbf006 = g_prbf_m_t.prbf006
                     DISPLAY BY NAME g_prbf_m.prbf006
                     NEXT FIELD prbf006
                  END IF
               END IF
               #150401-00003#1--mark by dongsz--end---
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf006
            #add-point:ON CHANGE prbf006 name="input.g.prbf006"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf007
            #add-point:BEFORE FIELD prbf007 name="input.b.prbf007"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf007
            
            #add-point:AFTER FIELD prbf007 name="input.a.prbf007"
            IF NOT cl_null(g_prbf_m.prbf007) AND NOT cl_null(g_prbf_m.prbf006) THEN
               IF g_prbf_m.prbf007 < g_prbf_m.prbf006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00049'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbf_m.prbf007 = g_prbf_m_t.prbf007
                  DISPLAY BY NAME g_prbf_m.prbf007
                  NEXT FIELD prbf007
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf007
            #add-point:ON CHANGE prbf007 name="input.g.prbf007"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf013
            
            #add-point:AFTER FIELD prbf013 name="input.a.prbf013"
            IF NOT cl_null(g_prbf_m.prbf013) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               #INITIALIZE g_chkparam.* TO NULL
               #
               ##設定g_chkparam.*的參數
               #LET g_chkparam.arg1 = '2135'
               #LET g_chkparam.arg2 = g_prbf_m.prbf013
               #   
               ##呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_oocq002_1") THEN
               #   #檢查成功時後續處理
               #ELSE
               #   #檢查失敗時後續處理
               #   LET g_prbf_m.prbf013 = g_prbf_m_t.prbf013
               #   DISPLAY BY NAME g_prbf_m.prbf013
               #   NEXT FIELD CURRENT
               #END IF
               SELECT COUNT(*) INTO l_n FROM oocq_t
                WHERE oocqent = g_enterprise
                  AND oocq001 = '2135'
                  AND oocq002 = g_prbf_m.prbf013
               IF l_n < 1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00485'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbf_m.prbf013 = g_prbf_m_t.prbf013
                  DISPLAY BY NAME g_prbf_m.prbf013
                  NEXT FIELD prbf013
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf013_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf013
            #add-point:BEFORE FIELD prbf013 name="input.b.prbf013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf013
            #add-point:ON CHANGE prbf013 name="input.g.prbf013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfunit
            #add-point:BEFORE FIELD prbfunit name="input.b.prbfunit"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfunit
            
            #add-point:AFTER FIELD prbfunit name="input.a.prbfunit"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfunit
            #add-point:ON CHANGE prbfunit name="input.g.prbfunit"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf010
            
            #add-point:AFTER FIELD prbf010 name="input.a.prbf010"
                                                                                                                                    
            IF NOT cl_null(g_prbf_m.prbf010) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbf_m.prbf010
               LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbf_m.prbf010 = g_prbf_m_t.prbf010
                  LET g_prbf_m.prbf010_desc = ''
                  DISPLAY BY NAME g_prbf_m.prbf010,g_prbf_m.prbf010_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf010
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf010_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf010
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag003 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf011 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf011
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf010
            #add-point:BEFORE FIELD prbf010 name="input.b.prbf010"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf010
            #add-point:ON CHANGE prbf010 name="input.g.prbf010"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf012
            #add-point:BEFORE FIELD prbf012 name="input.b.prbf012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf012
            
            #add-point:AFTER FIELD prbf012 name="input.a.prbf012"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf012
            #add-point:ON CHANGE prbf012 name="input.g.prbf012"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfud002
            #add-point:BEFORE FIELD prbfud002 name="input.b.prbfud002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfud002
            
            #add-point:AFTER FIELD prbfud002 name="input.a.prbfud002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfud002
            #add-point:ON CHANGE prbfud002 name="input.g.prbfud002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfud003
            #add-point:BEFORE FIELD prbfud003 name="input.b.prbfud003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfud003
            
            #add-point:AFTER FIELD prbfud003 name="input.a.prbfud003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfud003
            #add-point:ON CHANGE prbfud003 name="input.g.prbfud003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbf011
            
            #add-point:AFTER FIELD prbf011 name="input.a.prbf011"
                                                                                                                                    
            IF NOT cl_null(g_prbf_m.prbf011) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbf_m.prbf011
               LET g_chkparam.arg2 = g_today
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbf_m.prbf011 = g_prbf_m_t.prbf011
                  LET g_prbf_m.prbf011_desc = ''
                  DISPLAY BY NAME g_prbf_m.prbf011,g_prbf_m.prbf011_desc
                  NEXT FIELD CURRENT
               END IF
            
               #150401-00003#1--add by dongsz--str---
               IF NOT cl_null(g_prbf_m.prbf005) THEN
                  #檢查是否屬於arti204設置的部門品類
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaz_t
                   WHERE rtazent = g_enterprise
                     AND rtaz001 = g_prog
                     AND rtazstus = 'Y'
                  IF l_n > 0 THEN
                     #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
                     SELECT COUNT(*) INTO l_n FROM rtay_t
                      WHERE rtayent = g_enterprise
                        AND rtay001 = g_prbf_m.prbf011
                        AND rtay002 = g_prbf_m.prbf005
                        AND rtaystus = 'Y'
                     IF l_n < 1 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00357'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                  
                        LET g_prbf_m.prbf011 = g_prbf_m_t.prbf011
                        DISPLAY BY NAME g_prbf_m.prbf011
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
               #150401-00003#1--add by dongsz--end---
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf011
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf011_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbf011
            #add-point:BEFORE FIELD prbf011 name="input.b.prbf011"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbf011
            #add-point:ON CHANGE prbf011 name="input.g.prbf011"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbfstus
            #add-point:BEFORE FIELD prbfstus name="input.b.prbfstus"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbfstus
            
            #add-point:AFTER FIELD prbfstus name="input.a.prbfstus"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbfstus
            #add-point:ON CHANGE prbfstus name="input.g.prbfstus"
                                                                                                                                    
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.prbfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfsite
            #add-point:ON ACTION controlp INFIELD prbfsite name="input.c.prbfsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbfsite             #給予default值

            #給予arg

            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbfsite',g_prbf_m.prbfsite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
            CALL q_ooef001_24()                                #呼叫開窗

            LET g_prbf_m.prbfsite = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_prbf_m.prbfsite TO prbfsite              #顯示到畫面上
            CALL s_desc_get_department_desc(g_prbf_m.prbfsite)
               RETURNING g_prbf_m.prbfsite_desc
            DISPLAY BY NAME g_prbf_m.prbfsite_desc

            NEXT FIELD prbfsite                                                                                                                         
            #END add-point
 
 
         #Ctrlp:input.c.prbfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfdocdt
            #add-point:ON ACTION controlp INFIELD prbfdocdt name="input.c.prbfdocdt"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfdocno
            #add-point:ON ACTION controlp INFIELD prbfdocno name="input.c.prbfdocno"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbfdocno             #給予default值

            #給予arg
            CALL s_aooi100_sel_ooef004(g_prbf_m.prbfsite)
               RETURNING l_success,l_ooef004
            LET g_qryparam.arg1 = l_ooef004   #參照表編號
            LET g_qryparam.arg2 = g_prog   #對應程式代號

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_prbf_m.prbfdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbf_m.prbfdocno TO prbfdocno              #顯示到畫面上

            NEXT FIELD prbfdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf002
            #add-point:ON ACTION controlp INFIELD prbf002 name="input.c.prbf002"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf003
            #add-point:ON ACTION controlp INFIELD prbf003 name="input.c.prbf003"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf001
            #add-point:ON ACTION controlp INFIELD prbf001 name="input.c.prbf001"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf004
            #add-point:ON ACTION controlp INFIELD prbf004 name="input.c.prbf004"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbf004             #給予default值
            LET g_qryparam.default2 = g_prbf_m.prbf004_desc        #給予default值

            #給予arg

            CALL q_pmaa001_10()                                #呼叫開窗

            LET g_prbf_m.prbf004 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbf_m.prbf004_desc = g_qryparam.return2         #將開窗取得的值回傳到變數

            DISPLAY g_prbf_m.prbf004 TO prbf004              #顯示到畫面上
            DISPLAY g_prbf_m.prbf004_desc TO prbf004_desc    #顯示到畫面上

            NEXT FIELD prbf004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf005
            #add-point:ON ACTION controlp INFIELD prbf005 name="input.c.prbf005"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbf005             #給予default值
            LET g_qryparam.default2 = g_prbf_m.prbf005_desc        #給予default值

            #給予arg
            LET l_rtax004 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
#            SELECT ooaa002 INTO l_ooaa002 FROM ooaa_t 
#             WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0001'
            LET g_qryparam.arg1 = l_rtax004   #系統設定層級
            
            #150401-00003#1--add by dongsz--str---
            SELECT COUNT(*) INTO l_n
              FROM rtaz_t
             WHERE rtazent = g_enterprise
               AND rtaz001 = g_prog
               AND rtazstus = 'Y'
            IF l_n > 0 THEN
               LET g_qryparam.where = " rtax001 IN (SELECT rtay002 FROM rtay_t WHERE rtayent = ",g_enterprise," ",
                                      "                AND rtay001 = '",g_prbf_m.prbf011,"' AND rtaystus = 'Y') "
            END IF
            #150401-00003#1--add by dongsz--end---

            CALL q_rtax001_4()                                #呼叫開窗

            LET g_prbf_m.prbf005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbf_m.prbf005_desc = g_qryparam.return2         #將開窗取得的值回傳到變數

            DISPLAY g_prbf_m.prbf005 TO prbf005              #顯示到畫面上
            DISPLAY g_prbf_m.prbf005_desc TO prbf005_desc    #顯示到畫面上

            NEXT FIELD prbf005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf006
            #add-point:ON ACTION controlp INFIELD prbf006 name="input.c.prbf006"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf007
            #add-point:ON ACTION controlp INFIELD prbf007 name="input.c.prbf007"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf013
            #add-point:ON ACTION controlp INFIELD prbf013 name="input.c.prbf013"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbf013             #給予default值
            LET g_qryparam.default2 = "" #g_prbf_m.oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "2135" #s


            CALL q_oocq002()                                #呼叫開窗

            LET g_prbf_m.prbf013 = g_qryparam.return1              
            #LET g_prbf_m.oocql004 = g_qryparam.return2 
            DISPLAY g_prbf_m.prbf013 TO prbf013              #
            #DISPLAY g_prbf_m.oocql004 TO oocql004 #說明
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbf_m.prbf013
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2135'  AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbf_m.prbf013_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbf_m.prbf013_desc
            NEXT FIELD prbf013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbfunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfunit
            #add-point:ON ACTION controlp INFIELD prbfunit name="input.c.prbfunit"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf010
            #add-point:ON ACTION controlp INFIELD prbf010 name="input.c.prbf010"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbf010             #給予default值
            LET g_qryparam.default2 = g_prbf_m.prbf010_desc        #給予default值
            LET g_qryparam.default3 = g_prbf_m.prbf011
            LET g_qryparam.default4 = g_prbf_m.prbf011_desc            

            #給予arg

            CALL q_ooag001_6()                                #呼叫開窗

            LET g_prbf_m.prbf010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbf_m.prbf010_desc = g_qryparam.return2         #將開窗取得的值回傳到變數
            LET g_prbf_m.prbf011 = g_qryparam.return3
            LET g_prbf_m.prbf011_desc = g_qryparam.return4 

            DISPLAY g_prbf_m.prbf010 TO prbf010              #顯示到畫面上
            DISPLAY g_prbf_m.prbf010_desc TO prbf010_desc    #顯示到畫面上
            DISPLAY g_prbf_m.prbf011 TO prbf011              #顯示到畫面上
            DISPLAY g_prbf_m.prbf011_desc TO prbf011_desc    #顯示到畫面上

            NEXT FIELD prbf010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf012
            #add-point:ON ACTION controlp INFIELD prbf012 name="input.c.prbf012"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.prbfud002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfud002
            #add-point:ON ACTION controlp INFIELD prbfud002 name="input.c.prbfud002"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbfud003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfud003
            #add-point:ON ACTION controlp INFIELD prbfud003 name="input.c.prbfud003"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbf011
            #add-point:ON ACTION controlp INFIELD prbf011 name="input.c.prbf011"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbf_m.prbf011             #給予default值
            LET g_qryparam.default2 = g_prbf_m.prbf011_desc        #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_today #

            CALL q_ooeg001()                                #呼叫開窗

            LET g_prbf_m.prbf011 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbf_m.prbf011_desc = g_qryparam.return2         #將開窗取得的值回傳到變數

            DISPLAY g_prbf_m.prbf011 TO prbf011              #顯示到畫面上
            DISPLAY g_prbf_m.prbf011_desc TO prbf011_desc    #顯示到畫面上

            NEXT FIELD prbf011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.prbfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbfstus
            #add-point:ON ACTION controlp INFIELD prbfstus name="input.c.prbfstus"
                                                                                                                                    
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_prbf_m.prbfdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_prbf_m.prbfsite,g_prbf_m.prbfdocno,g_prbf_m.prbfdocdt,g_prog) RETURNING l_flag,g_prbf_m.prbfdocno
               IF NOT l_flag THEN
                  NEXT FIELD prbfdocno
               END IF                                                                        
               #end add-point
               
               INSERT INTO prbf_t (prbfent,prbfsite,prbfdocdt,prbfdocno,prbf002,prbf003,prbf001,prbf004, 
                   prbf005,prbf006,prbf007,prbf013,prbfunit,prbf010,prbf012,prbfud002,prbfud003,prbf011, 
                   prbfstus,prbfownid,prbfowndp,prbfcrtid,prbfcrtdp,prbfcrtdt,prbfmodid,prbfmoddt,prbfcnfid, 
                   prbfcnfdt)
               VALUES (g_enterprise,g_prbf_m.prbfsite,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002, 
                   g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005,g_prbf_m.prbf006, 
                   g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
                   g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid, 
                   g_prbf_m.prbfowndp,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid, 
                   g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_prbf_m:",SQLERRMESSAGE 
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
                  CALL aprt111_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aprt111_b_fill()
                  CALL aprt111_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               #151013-00001#38--dongsz add--s
               #单头组织为营采中心，则新增一笔生效门店资料
               LET l_n = 0
               SELECT COUNT(*) INTO l_n
                 FROM ooef_t
                WHERE ooefent = g_enterprise
                  AND ooef001 = g_prbf_m.prbfsite
                  AND ooef301 = 'Y'
                  AND ooef303 = 'Y'
               IF l_n > 0 THEN
                  INSERT INTO prbv_t (prbvent,prbvunit,prbvsite,prbvdocno,prbv001,prbvstus)
                  VALUES (g_enterprise,g_prbf_m.prbfunit,g_prbf_m.prbfsite,g_prbf_m.prbfdocno,g_prbf_m.prbfsite,'Y')
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_prbv" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #151013-00001#38--dongsz add--e
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
                                                                                                                                                                     
               #end add-point
               
               #將遮罩欄位還原
               CALL aprt111_prbf_t_mask_restore('restore_mask_o')
               
               UPDATE prbf_t SET (prbfsite,prbfdocdt,prbfdocno,prbf002,prbf003,prbf001,prbf004,prbf005, 
                   prbf006,prbf007,prbf013,prbfunit,prbf010,prbf012,prbfud002,prbfud003,prbf011,prbfstus, 
                   prbfownid,prbfowndp,prbfcrtid,prbfcrtdp,prbfcrtdt,prbfmodid,prbfmoddt,prbfcnfid,prbfcnfdt) = (g_prbf_m.prbfsite, 
                   g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001, 
                   g_prbf_m.prbf004,g_prbf_m.prbf005,g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013, 
                   g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003, 
                   g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp,g_prbf_m.prbfcrtid, 
                   g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid, 
                   g_prbf_m.prbfcnfdt)
                WHERE prbfent = g_enterprise AND prbfdocno = g_prbfdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "prbf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               #20151027--dongsz mark--str---
#               IF g_prbf001 = '1' OR g_prbf001 = '2' THEN
#                  UPDATE prbg_t SET prbg014 = g_prbf_m.prbf006,
#                                    prbg016 = g_prbf_m.prbf006
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = '1'
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "prbg_t"
#                     LET g_errparam.code   = SQLCA.sqlcode 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                     CALL s_transaction_end('N','0')
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
               #20151027--dongsz mark--end---
               #20151027--dongsz add--str---
#               IF g_prbf001 = '1' THEN
#                  UPDATE prbg_t SET prbg014 = g_prbf_m.prbf006,
#                                    prbg016 = g_prbf_m.prbf006,
#                                    prbg019 = g_prbf_m.prbf006
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '2' THEN
#                  UPDATE prbg_t SET prbg016 = g_prbf_m.prbf006,
#                                    prbg019 = g_prbf_m.prbf006
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '3' THEN
#                  UPDATE prbg_t SET prbg014 = g_prbf_m.prbf006,
#                                    prbg015 = g_prbf_m.prbf007,
#                                    prbg016 = g_prbf_m.prbf006,
#                                    prbg017 = g_prbf_m.prbf007,
#                                    prbg019 = g_prbf_m.prbf006,
#                                    prbg020 = g_prbf_m.prbf007
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '6' THEN
#                  UPDATE prbg_t SET prbg016 = g_prbf_m.prbf006,
#                                    prbg017 = g_prbf_m.prbf007,
#                                    prbg019 = g_prbf_m.prbf006,
#                                    prbg020 = g_prbf_m.prbf007
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '7' THEN
#                  UPDATE prbg_t SET prbg016 = g_prbf_m.prbf006,
#                                    prbg017 = g_prbf_m.prbf007
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '8' THEN
#                  UPDATE prbg_t SET prbg019 = g_prbf_m.prbf006,
#                                    prbg020 = g_prbf_m.prbf007
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
#               IF g_prbf001 = '9' THEN
#                  UPDATE prbg_t SET prbg016 = g_prbf_m.prbf006,
#                                    prbg017 = g_prbf_m.prbf007,
#                                    prbg019 = g_prbf_m.prbf006,
#                                    prbg020 = g_prbf_m.prbf007
#                   WHERE prbgent = g_enterprise
#                     AND prbgdocno = g_prbf_m.prbfdocno
#                     AND prbgseq1 = 1
#               END IF
               IF g_prbf001 <> '3' THEN     #151013-00001#44 dongsz add
                  UPDATE prbg_t SET prbg014 = g_prbf_m.prbf006,
                                    prbg015 = g_prbf_m.prbf007,
                                    prbg016 = g_prbf_m.prbf006,
                                    prbg017 = g_prbf_m.prbf007,
                                    prbg019 = g_prbf_m.prbf006,
                                    prbg020 = g_prbf_m.prbf007
                   WHERE prbgent = g_enterprise
                     AND prbgdocno = g_prbf_m.prbfdocno
                     AND prbgseq1 = 1
                  UPDATE prbw_t SET prbw015 = g_prbf_m.prbf006,
                                    prbw016 = g_prbf_m.prbf007,
                                    prbw020 = g_prbf_m.prbf006,    #151013-00001#44 dongsz add
                                    prbw021 = g_prbf_m.prbf007     #151013-00001#44 dongsz add
                   WHERE prbwent = g_enterprise
                     AND prbwdocno = g_prbf_m.prbfdocno
               END IF                #151013-00001#44 dongsz add
               #20151027--dongsz add--end---
               #151013-00001#44 dongsz add--str
               IF g_prbf001 = '3' THEN
                  IF g_prbf_m.prbf006 <> g_prbf_m_t.prbf006 OR g_prbf_m.prbf007 <> g_prbf_m_t.prbf007 THEN
                     UPDATE prbg_t SET prbg014 = g_prbf_m.prbf006,
                                       prbg015 = g_prbf_m.prbf007,
                                       prbg016 = g_prbf_m.prbf006,
                                       prbg017 = g_prbf_m.prbf007,
                                       prbg019 = g_prbf_m.prbf006,
                                       prbg020 = g_prbf_m.prbf007
                      WHERE prbgent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND prbgseq1 = 1
                     UPDATE prbw_t SET prbw015 = g_prbf_m.prbf006,
                                       prbw016 = g_prbf_m.prbf007,
                                       prbw020 = g_prbf_m.prbf006,    
                                       prbw021 = g_prbf_m.prbf007     
                      WHERE prbwent = g_enterprise
                        AND prbwdocno = g_prbf_m.prbfdocno
                  END IF
               END IF
               #151013-00001#44 dongsz add--end
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aprt111_prbf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_prbf_m_t)
               LET g_log2 = util.JSON.stringify(g_prbf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                                                                                                                                                     
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aprt111.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_prbg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prbg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt111_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_prbg_d.getLength()
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
            OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt111_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prbg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prbg_d[l_ac].prbgseq IS NOT NULL
               AND g_prbg_d[l_ac].prbgseq1 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_prbg_d_t.* = g_prbg_d[l_ac].*  #BACKUP
               LET g_prbg_d_o.* = g_prbg_d[l_ac].*  #BACKUP
               CALL aprt111_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                                                                                                                                                     
               #end add-point  
               CALL aprt111_set_no_entry_b(l_cmd)
               IF NOT aprt111_lock_b("prbg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt111_bcl INTO g_prbg_d[l_ac].prbgunit,g_prbg_d[l_ac].prbgseq,g_prbg_d[l_ac].prbg001, 
                      g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg024, 
                      g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg023,g_prbg_d[l_ac].prbg009, 
                      g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012,g_prbg_d[l_ac].prbg025, 
                      g_prbg_d[l_ac].prbg026,g_prbg_d[l_ac].prbgseq1,g_prbg_d[l_ac].prbg004,g_prbg_d[l_ac].prbg005, 
                      g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015, 
                      g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg016,g_prbg_d[l_ac].prbg017, 
                      g_prbg_d[l_ac].prbg019,g_prbg_d[l_ac].prbg020,g_prbg_d[l_ac].prbg013
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_prbg_d_t.prbgseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prbg_d_mask_o[l_ac].* =  g_prbg_d[l_ac].*
                  CALL aprt111_prbg_t_mask()
                  LET g_prbg_d_mask_n[l_ac].* =  g_prbg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt111_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            CALL aprt111_b_fill2('0')     #20150924 dongsz add
            #20150923--mark by dongsz--s
#            LET g_flag1 = 'N'       #150401-00003#1--add by dongsz
#            LET g_flag2 = 'N'       #150401-00003#1--add by dongsz
#            IF l_cmd = 'a' AND g_flag = 'Y' THEN
#               LET g_prbg_d_t.* = g_prbg_d[l_ac].*     #新輸入資料
#               CALL cl_show_fld_cont()
#               CALL aprt111_set_entry_b(l_cmd)
#               #add-point:modify段after_set_entry_b
#                                                                                                                     
#               #end add-point
#               CALL aprt111_set_no_entry_b(l_cmd)
#               IF lb_reproduce THEN
#                  LET lb_reproduce = FALSE
#                  LET g_prbg_d[li_reproduce_target].* = g_prbg_d[li_reproduce].*
# 
#                  LET g_prbg_d[li_reproduce_target].prbgseq = NULL
#                  LET g_prbg_d[li_reproduce_target].prbgseq1 = NULL 
#               END IF
#               #公用欄位給值(單身)
#            
#            
#               #add-point:modify段before insert           
#               LET g_prbg_d[l_ac].prbgseq1 = '0'
#               INITIALIZE g_ref_fields TO NULL
#               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
#               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
#               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
#               
#               LET g_prbg_d[l_ac+1].prbgunit = g_site
#               LET g_prbg_d[l_ac+1].prbgseq = g_prbg_d[l_ac].prbgseq
#               LET g_prbg_d[l_ac+1].prbgseq1 = '1'
#               #150401-00003#1--add by dongsz--str---
#               IF g_prbf001 = '1' OR g_prbf001 = '2' THEN
#                  LET g_prbg_d[l_ac+1].prbg014 = g_prbf_m.prbf006
#                  LET g_prbg_d[l_ac+1].prbg016 = g_prbf_m.prbf006
#               END IF
#               #150401-00003#1--add by dongsz--end---
#
#               INITIALIZE gs_keys TO NULL 
#               LET gs_keys[1] = g_prbf_m.prbfdocno
#               LET gs_keys[2] = g_prbg_d[l_ac].prbgseq
#               LET gs_keys[3] = g_prbg_d[l_ac].prbgseq1
#               CALL aprt111_insert_b('prbg_t',gs_keys,"'1'")
# 
#               IF SQLCA.SQLcode  THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "prbg_t"
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#  
#                  CALL s_transaction_end('N','0')                    
#                  
#               ELSE
#                  #先刷新資料
#                  #CALL aprt111_b_fill()
#                  #資料多語言用-增/改
#               
#                  #add-point:input段-after_insert
#                  INSERT INTO prbg_t
#                     (prbgent,
#                      prbgdocno,
#                      prbgseq,prbgseq1
#                      ,prbgunit,prbg001,prbgsite,prbg002,prbg003,prbg004,prbg005,prbg006,prbg007,prbg014,prbg015,
#                       prbg018,prbg008,prbg009,prbg016,prbg017,prbg010,prbg011,prbg012,prbg013) 
#                  VALUES(g_enterprise,
#                     g_prbf_m.prbfdocno,g_prbg_d[l_ac].prbgseq,g_prbg_d[l_ac+1].prbgseq1,
#                     g_prbg_d[l_ac].prbgunit,g_prbg_d[l_ac].prbg001,g_prbg_d[l_ac].prbgsite, 
#                     g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg003,NULL, 
#                     g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg006,
#                     g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015,
#                     g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg008,NULL,g_prbg_d[l_ac].prbg016,g_prbg_d[l_ac].prbg017,NULL, 
#                     NULL,NULL,NULL)     
#
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "prbg_t"
#                     LET g_errparam.popup = FALSE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')                    
#
#                  END IF
#
#                  CALL s_transaction_end('Y','0')
#                  ERROR 'INSERT O.K'
#                  LET g_rec_b = g_rec_b + 2
#               END IF
#               LET l_cmd = 'u'
#               LET g_prbg_d_t.* = g_prbg_d[l_ac].* 
#            END IF                
#            IF g_prbg_d[l_ac].prbgseq1 = '1' THEN
#               LET g_prbg_d[l_ac].prbg001 = ''
#               LET g_prbg_d[l_ac].prbgsite = ''
#               LET g_prbg_d[l_ac].prbgsite_desc = ''
#               LET g_prbg_d[l_ac].prbg002 = ''
#               LET g_prbg_d[l_ac].prbg002_desc = ''
##               LET g_prbg_d[l_ac].prbg002_desc1 = ''
##               LET g_prbg_d[l_ac].prbg002_desc2 = ''
#               LET g_prbg_d[l_ac].prbg002_desc_desc = ''
#               LET g_prbg_d[l_ac].prbg002_desc_desc_desc = ''
#               LET g_prbg_d[l_ac].prbg003 = ''
#            END IF
#            LET g_flag = 'N' 
#            IF l_cmd = 'u' AND g_prbg_d[l_ac].prbgseq1 = '0' THEN
#               NEXT FIELD prbg001
#            END IF                 
            #20150923--mark by dongsz--e            
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
            INITIALIZE g_prbg_d[l_ac].* TO NULL 
            INITIALIZE g_prbg_d_t.* TO NULL 
            INITIALIZE g_prbg_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_prbg_d[l_ac].prbg001 = "2"
      LET g_prbg_d[l_ac].prbg024 = "0"
      LET g_prbg_d[l_ac].prbg021 = "0"
      LET g_prbg_d[l_ac].prbg023 = "0"
      LET g_prbg_d[l_ac].prbg022 = "0"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_prbg_d_t.* = g_prbg_d[l_ac].*     #新輸入資料
            LET g_prbg_d_o.* = g_prbg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt111_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                                                                                                     
            #end add-point
            CALL aprt111_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prbg_d[li_reproduce_target].* = g_prbg_d[li_reproduce].*
 
               LET g_prbg_d[li_reproduce_target].prbgseq = NULL
               LET g_prbg_d[li_reproduce_target].prbgseq1 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_prbg_d[l_ac].prbg001 = "2"
            LET g_prbg_d[l_ac].prbgunit = g_prbf_m.prbfsite
            #LET g_prbg_d[l_ac+1].prbgunit = g_prbf_m.prbfsite     #20150923--dongsz mark
            SELECT MAX(prbgseq)+1 INTO g_prbg_d[l_ac].prbgseq FROM prbg_t
             WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
            IF cl_null(g_prbg_d[l_ac].prbgseq) THEN
               LET g_prbg_d[l_ac].prbgseq = 1
               LET g_prbg_d[l_ac].prbgsite = g_prbg_d[l_ac].prbgunit
            ELSE
               SELECT prbgsite INTO g_prbg_d[l_ac].prbgsite
                 FROM prbg_t
                WHERE prbgent = g_enterprise 
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq = g_prbg_d[l_ac].prbgseq - 1
                  #AND prbgseq1 = '0'    #20150924 dongsz mark
                  AND prbgseq1 = '1'     #20150924 dongsz add
                  AND prbg001 = '2'
               IF cl_null(g_prbg_d[l_ac].prbgsite) THEN
                  LET g_prbg_d[l_ac].prbgsite = g_prbg_d[l_ac].prbgunit
               END IF
            END IF
            #LET g_prbg_d[l_ac+1].prbgseq = g_prbg_d[l_ac].prbgseq   #20150923--dongsz mark
            #LET g_prbg_d[l_ac].prbgseq1 = '0'   #20150924 dongsz mark
            LET g_prbg_d[l_ac].prbgseq1 = '1'    #20150924 dongsz add
            LET g_prbg_d[l_ac].prbg014 = g_prbf_m.prbf006   #20150924 dongsz add
            #LET g_prbg_d[l_ac].prbg015 = g_prbf_m.prbf007   #20150924 dongsz add
            LET g_prbg_d[l_ac].prbg016 = g_prbf_m.prbf006   #20150924 dongsz add
           # LET g_prbg_d[l_ac].prbg017 = g_prbf_m.prbf007   #20150924 dongsz add
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
            
            #促销调价时单身促销日期等于单头日期
            IF g_prbf001 MATCHES '[36789]' THEN
               LET g_prbg_d[l_ac].prbg014 = g_prbf_m.prbf006
               LET g_prbg_d[l_ac].prbg016 = g_prbf_m.prbf006
               LET g_prbg_d[l_ac].prbg019 = g_prbf_m.prbf006
               LET g_prbg_d[l_ac].prbg015 = g_prbf_m.prbf007
               LET g_prbg_d[l_ac].prbg017 = g_prbf_m.prbf007
               LET g_prbg_d[l_ac].prbg020 = g_prbf_m.prbf007
            END IF
            LET g_prbg_d[l_ac].prbg024 = ""   #20151105 dongsz add
            #LET g_prbg_d[l_ac+1].prbgseq1 = '1'        #20150923--dongsz mark
            #20150923--mark by dongsz--s
#            #150401-00003#1--add by dongsz--str---
#            IF g_prbf001 = '1' OR g_prbf001 = '2' THEN
#               LET g_prbg_d[l_ac+1].prbg014 = g_prbf_m.prbf006
#               LET g_prbg_d[l_ac+1].prbg016 = g_prbf_m.prbf006
#            END IF
#            #150401-00003#1--add by dongsz--end---
            #20150923--mark by dongsz--e
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
            SELECT COUNT(1) INTO l_count FROM prbg_t 
             WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
 
               AND prbgseq = g_prbg_d[l_ac].prbgseq
               AND prbgseq1 = g_prbg_d[l_ac].prbgseq1
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                                                                                                                                                     
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys[2] = g_prbg_d[g_detail_idx].prbgseq
               LET gs_keys[3] = g_prbg_d[g_detail_idx].prbgseq1
               CALL aprt111_insert_b('prbg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_prbg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt111_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               #20150923--mark by dongsz--s
#               INSERT INTO prbg_t
#                  (prbgent,
#                   prbgdocno,
#                   prbgseq,prbgseq1
#                   ,prbgunit,prbg001,prbgsite,prbg002,prbg003,prbg004,prbg005,prbg006,prbg007,prbg014,prbg015,
#                    prbg018,prbg008,prbg009,prbg016,prbg017,prbg010,prbg011,prbg012,prbg013) 
#               VALUES(g_enterprise,
#                   g_prbf_m.prbfdocno,g_prbg_d[g_detail_idx].prbgseq,g_prbg_d[g_detail_idx+1].prbgseq1
#                   ,g_prbg_d[g_detail_idx].prbgunit,g_prbg_d[g_detail_idx].prbg001,g_prbg_d[g_detail_idx].prbgsite, 
#                       g_prbg_d[g_detail_idx].prbg002,g_prbg_d[g_detail_idx].prbg003,NULL, 
#                       g_prbg_d[g_detail_idx+1].prbg005,g_prbg_d[g_detail_idx+1].prbg006,
#                       g_prbg_d[g_detail_idx+1].prbg007,g_prbg_d[g_detail_idx+1].prbg014,g_prbg_d[g_detail_idx+1].prbg015,
#                       g_prbg_d[g_detail_idx+1].prbg018,g_prbg_d[g_detail_idx+1].prbg008,g_prbg_d[g_detail_idx+1].prbg009,
#                       g_prbg_d[g_detail_idx+1].prbg016,g_prbg_d[g_detail_idx+1].prbg017,g_prbg_d[g_detail_idx+1].prbg010, 
#                       g_prbg_d[g_detail_idx+1].prbg011,g_prbg_d[g_detail_idx+1].prbg012,g_prbg_d[g_detail_idx+1].prbg013)     
#
#               IF SQLCA.sqlcode THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = SQLCA.sqlcode
#                  LET g_errparam.extend = "prbg_t"
#                  LET g_errparam.popup = FALSE
#                  CALL cl_err()
#
#                  CALL s_transaction_end('N','0')                    
#                  CANCEL INSERT
#               END IF
#               LET g_rec_b = g_rec_b + 1 
               #20150923--mark by dongsz--e               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               #CALL g_prbg_d.deleteElement(g_prbg_d.getLength())     #20150924 dongsz mark
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
               LET gs_keys[01] = g_prbf_m.prbfdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_prbg_d_t.prbgseq
               LET gs_keys[gs_keys.getLength()+1] = g_prbg_d_t.prbgseq1
 
            
               #刪除同層單身
               IF NOT aprt111_delete_b('prbg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt111_key_delete_b(gs_keys,'prbg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                                                                                                                                                     
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt111_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                                                                                                                                                                      
               #end add-point
               LET l_count = g_prbg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                                                                                                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prbg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgunit
            #add-point:BEFORE FIELD prbgunit name="input.b.page1.prbgunit"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgunit
            
            #add-point:AFTER FIELD prbgunit name="input.a.page1.prbgunit"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbgunit
            #add-point:ON CHANGE prbgunit name="input.g.page1.prbgunit"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgseq
            #add-point:BEFORE FIELD prbgseq name="input.b.page1.prbgseq"
                                                                                                                         
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgseq
            
            #add-point:AFTER FIELD prbgseq name="input.a.page1.prbgseq"
                                                                                                                                                #此段落由子樣板a05產生
            IF  g_prbf_m.prbfdocno IS NOT NULL AND g_prbg_d[g_detail_idx].prbgseq IS NOT NULL AND g_prbg_d[g_detail_idx].prbgseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbf_m.prbfdocno != g_prbfdocno_t OR g_prbg_d[g_detail_idx].prbgseq != g_prbg_d_t.prbgseq OR g_prbg_d[g_detail_idx].prbgseq1 != g_prbg_d_t.prbgseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbg_t WHERE "||"prbgent = '" ||g_enterprise|| "' AND "||"prbgdocno = '"||g_prbf_m.prbfdocno ||"' AND "|| "prbgseq = '"||g_prbg_d[g_detail_idx].prbgseq ||"' AND "|| "prbgseq1 = '"||g_prbg_d[g_detail_idx].prbgseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbgseq
            #add-point:ON CHANGE prbgseq name="input.g.page1.prbgseq"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg001
            #add-point:BEFORE FIELD prbg001 name="input.b.page1.prbg001"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg001
            
            #add-point:AFTER FIELD prbg001 name="input.a.page1.prbg001"
              
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg001
            #add-point:ON CHANGE prbg001 name="input.g.page1.prbg001"
            IF NOT cl_null(g_prbg_d[l_ac].prbg001) THEN              
               LET g_prbg_d[l_ac].prbgsite = NULL
               LET g_prbg_d[l_ac].prbgsite_desc = NULL
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbgsite_desc
            END IF                                                                                                                                     
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgsite
            
            #add-point:AFTER FIELD prbgsite name="input.a.page1.prbgsite"
            IF NOT cl_null(g_prbg_d[l_ac].prbgsite) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               IF g_prbg_d[l_ac].prbg001 = '1' THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM rtaa_t
                   WHERE rtaaent = g_enterprise
                     AND rtaa001 = g_prbg_d[l_ac].prbgsite
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00006'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
                     NEXT FIELD prbgsite
                  END IF
                  
#                  SELECT ooez006 INTO l_ooez006
#                    FROM ooez_t
#                   WHERE ooezent = g_enterprise
#                     AND ooez001 = g_prog
#                     AND ooez002 = '1'
#                  IF SQLCA.SQLCODE = 100 THEN
#                     LET l_ooez006 = "9"
#                  END IF
#                  
#                  LET l_n = 0                 
#                  LET l_sql = " SELECT COUNT(*) FROM rtaa_t,rtab_t ",
#                              "  WHERE rtaaent = rtabent AND rtaa001 = rtab001 ",
#                              "    AND rtaaent = '",g_enterprise,"' AND rtaa001 = '",g_prbg_d[l_ac].prbgsite,"' ", 
#                              "    AND rtab002 NOT IN (SELECT ooed004 FROM ooed_t ", 
#                              "        START WITH ooed005 = '",g_prbf_m.prbfsite,"' AND ooed001 = '",l_ooez006,"' AND ooed006 <= '",g_today,"' ",
#                              "                                          AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                              "        CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001='",l_ooez006,"' AND ooed006 <= '",g_today,"' AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
#                              "        UNION SELECT ooed004 FROM ooed_t WHERE ooed004 = '",g_prbf_m.prbfsite,"') "
#                  PREPARE sel_rtaa_pre FROM l_sql
#                  EXECUTE sel_rtaa_pre INTO l_n
#                  IF l_n > 0 THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'apr-00028'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
#                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
#                     NEXT FIELD prbgsite
#                  END IF
                  CALL s_aooi500_shop_group_chk(g_prog,'prbgsite',g_prbg_d[l_ac].prbgsite,g_prbf_m.prbfsite) 
                     RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_prbg_d[l_ac].prbgsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                     CALL s_desc_get_department_desc(g_prbg_d[l_ac].prbgsite) RETURNING g_prbg_d[l_ac].prbgsite_desc
                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbgsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  SELECT rtaastus INTO l_rtaastus FROM rtaa_t
                   WHERE rtaaent = g_enterprise
                     AND rtaa001 = g_prbg_d[l_ac].prbgsite
                     
                  #20150603--huangrh add--rtak-
                  LET l_count=0
                  SELECT COUNT(*) INTO l_count
                    FROM rtak_t
                   WHERE rtakent=g_enterprise
                     AND rtak001= g_prbg_d[l_ac].prbgsite
                     AND rtak002='4'
                     AND rtak003='Y'                     
                  IF cl_null(l_count) OR l_count=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00029'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
                     NEXT FIELD prbgsite
                  END IF
                  IF l_rtaastus <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-01302'   #art-00049  #160318-00005#39 by 07900 --mod
                     LET g_errparam.extend = ''
                     #160318-00005#39  By 07900 --add-str
                     LET g_errparam.replace[1] = 'arti201'
                     LET g_errparam.replace[2] = cl_get_progname("arti201",g_lang,"2")
                      LET g_errparam.exeprog = 'arti201'
                     #160318-00005#39  By 07900 --add-end
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
                     NEXT FIELD prbgsite
                  END IF
               END IF
               
               IF g_prbg_d[l_ac].prbg001 = '2' THEN
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_prbg_d[l_ac].prbgsite
#                  LET g_chkparam.arg2 = '8'
#                  LET g_chkparam.arg3 = g_site
#
#                  #呼叫檢查存在的library
#                  IF cl_chk_exist("v_ooed004") THEN
#                     #檢查成功時後續處理
#                     #LET  = g_chkparam.return1
#                     #DISPLAY BY NAME 
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
#                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_aooi500_chk(g_prog,'prbgsite',g_prbg_d[l_ac].prbgsite,g_prbf_m.prbfsite) RETURNING l_success,l_errno
                  IF NOT l_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = g_prbg_d[l_ac].prbgsite
                     LET g_errparam.code   = l_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  
                     LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                     CALL s_desc_get_department_desc(g_prbg_d[l_ac].prbgsite) RETURNING g_prbg_d[l_ac].prbgsite_desc
                     DISPLAY BY NAME g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbgsite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF

               IF NOT cl_null(g_prbg_d[l_ac].prbg002) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
               
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg002
                  LET g_chkparam.arg2 = g_prbg_d[l_ac].prbgsite
                  LET g_chkparam.arg3 = g_prbf_m.prbf005
                  LET g_chkparam.arg4 = g_prbf_m.prbf004
               
                  #呼叫檢查存在並帶值的library
                  IF g_prbg_d[l_ac].prbg001 = '1' THEN                                 
                     #IF g_prbf_m.prbf005 <> 'ALL' THEN         #150401-00003#1--mark by dongsz
                     IF NOT cl_null(g_prbf_m.prbf005) THEN      #150401-00003#1--add by dongsz
                        IF cl_chk_exist("v_rtdx001_3") THEN
                           #檢查成功時後續處理
                           #LET  = g_chkparam.return1
                           #DISPLAY BY NAME 
                        ELSE
                           #檢查失敗時後續處理
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF cl_chk_exist("v_rtdx001_5") THEN
                           #檢查成功時後續處理
                           #LET  = g_chkparam.return1
                           #DISPLAY BY NAME 
                        ELSE
                           #檢查失敗時後續處理
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  IF g_prbg_d[l_ac].prbg001 = '2' THEN
                     #IF g_prbf_m.prbf005 <> 'ALL' THEN             #150401-00003#1--mark by dongsz
                     IF NOT cl_null(g_prbf_m.prbf005) THEN          #150401-00003#1--add by dongsz
                        IF cl_chk_exist("v_rtdx001_2") THEN
                           #檢查成功時後續處理
                           #LET  = g_chkparam.return1
                           #DISPLAY BY NAME 
                        ELSE
                           #檢查失敗時後續處理
                           NEXT FIELD CURRENT
                        END IF
                     ELSE
                        IF cl_chk_exist("v_rtdx001_4") THEN
                           #檢查成功時後續處理
                           #LET  = g_chkparam.return1
                           #DISPLAY BY NAME 
                        ELSE
                           #檢查失敗時後續處理
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  END IF
                  #檢查重複
                  IF g_prbg_d[l_ac].prbgsite <> g_prbg_d_t.prbgsite OR cl_null(g_prbg_d_t.prbgsite) THEN 
                     IF g_prbg_d[l_ac].prbg001 = '2' THEN
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n FROM prbg_t
                         #WHERE g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END )  #160905-00007#12 mark
                         WHERE  prbgent = g_enterprise AND g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) #160905-00007#12 add
                                              FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
                                             WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
                        IF l_n > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00124'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                           DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
                           NEXT FIELD prbgsite
                        END IF
                     END IF
                     IF g_prbg_d[l_ac].prbg001 = '1' THEN
                        LET l_n = 0
                        SELECT COUNT(*) INTO l_n FROM rtab_t
                         WHERE rtabent = g_enterprise
                           AND rtab001 = g_prbg_d[l_ac].prbgsite
                           AND rtab002 IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
                                            FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
                                           WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
                        IF l_n > 0 THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = 'apr-00124'
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()

                           LET g_prbg_d[l_ac].prbgsite = g_prbg_d_t.prbgsite
                           DISPLAY BY NAME g_prbg_d[l_ac].prbgsite
                           NEXT FIELD prbgsite
                        END IF
                     END IF
                  END IF
                  CALL aprt111_prbg002_rtdx(l_cmd)
               END IF                  
            END IF           
            
            IF g_prbg_d[l_ac].prbg001 = '2' THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
            END IF
            IF g_prbg_d[l_ac].prbg001 = '1' THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
               CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
            END IF               

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgsite
            #add-point:BEFORE FIELD prbgsite name="input.b.page1.prbgsite"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbgsite
            #add-point:ON CHANGE prbgsite name="input.g.page1.prbgsite"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg003
            
            #add-point:AFTER FIELD prbg003 name="input.a.page1.prbg003"
            CALL aprt111_prbg002_init()                                                                                                                      
            IF NOT cl_null(g_prbg_d[l_ac].prbg003) THEN 
               #150401-00003#1--add by dongsz--str---
			      IF cl_null(g_prbf_m.prbf005) THEN
			         #判斷商品是否歸屬arti204設定的部門可用品類
                  IF NOT s_arti204_control_check(g_prog,g_prbf_m.prbf011,'',g_prbg_d[l_ac].prbg003) THEN
                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                     NEXT FIELD CURRENT
                  END IF
			      END IF
			      #150401-00003#1--add by dongsz--end---
#此段落由子樣板a19產生
               IF g_prbg_d[l_ac].prbg001 = '2' THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg003
                  LET g_chkparam.arg2 = g_prbf_m.prbf004
                  LET g_chkparam.arg3 = g_prbg_d[l_ac].prbgsite
			      
                     
                  #呼叫檢查存在並帶值的library
                  #20150924--mark by dongsz--s
#                  IF cl_chk_exist("v_imay003_2") THEN
#                     #檢查成功時後續處理
#                     #LET  = g_chkparam.return1
#                     #DISPLAY BY NAME 
#			      
#                  ELSE
#                     #檢查失敗時後續處理
#                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
#                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
#                     NEXT FIELD CURRENT
#                  END IF
                  #20150924--mark by dongsz--e
                  #20150924--add by dongsz--s
                  IF cl_null(g_prbf_m.prbf004) THEN
                     IF cl_chk_exist("v_imay003_6") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
			            
                     ELSE
                        #檢查失敗時後續處理
                        LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                        DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     IF cl_chk_exist("v_imay003_5") THEN
                        #檢查成功時後續處理
                        #LET  = g_chkparam.return1
                        #DISPLAY BY NAME 
			            
                     ELSE
                        #檢查失敗時後續處理
                        LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                        DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #20150924--add by dongsz--e
               END IF
               IF g_prbg_d[l_ac].prbg001 = '1' THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n
                    FROM imay_t,imaa_t,rtdx_t
                   WHERE imayent = g_enterprise AND imayent = imaaent AND imayent = rtdxent 
                     AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
                     AND imay001 = imaa001 AND imay001 = rtdx001 AND imay003 = g_prbg_d[l_ac].prbg003
                  IF l_n < 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apr-00011'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                     NEXT FIELD prbg003
                  END IF
                  #150312-00002#5 Modify-S By Ken 150317 原rtdx031換成imaf153
                  #SELECT imaystus,imay006,imaastus,rtdx031 INTO l_imaystus,l_imay006,l_imaastus,l_rtdx031
                  #  FROM imay_t,imaa_t,rtdx_t
                  # WHERE imayent = g_enterprise AND imayent = imaaent AND imayent = rtdxent 
                  #   AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
                  #   AND imay001 = imaa001 AND imay001 = rtdx001 AND imay003 = g_prbg_d[l_ac].prbg003
                  #   AND ROWNUM = 1
                  
                  SELECT imaystus,imay006,imaastus,imaf153 INTO l_imaystus,l_imay006,l_imaastus,l_imaf153
                    FROM imay_t,imaa_t,imaf_t
                   WHERE imayent = g_enterprise AND imayent = imaaent AND imayent = imafent 
                     AND imafsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
                     AND imay001 = imaa001 AND imay001 = imaf001 AND imay003 = g_prbg_d[l_ac].prbg003
                     AND ROWNUM = 1
                  #150312-00002#5 Modify-E  
                  IF l_imaystus <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00047'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                     NEXT FIELD prbg003
                  END IF   
#                  IF l_imay006 <> 'Y' THEN
#                     CALL cl_err('','apm-00280',1)
#                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
#                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
#                     NEXT FIELD prbg003
#                  END IF 
                  IF l_imaastus <> 'Y' THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'art-00212'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                     NEXT FIELD prbg003
                  END IF
                  #150312-00002#5 Modify-S By Ken 150317 原rtdx031換成imaf153
                  #IF l_rtdx031 <> g_prbf_m.prbf004 THEN
                  #20150924--mark by dongsz--s
#                  IF l_imaf153 <> g_prbf_m.prbf004 THEN
#                  #150312-00002#5 Modify-E
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = 'apr-00012'
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
#                     DISPLAY BY NAME g_prbg_d[l_ac].prbg003
#                     NEXT FIELD prbg003
#                  END IF
                  #20150924--mark by dongsz--e
               END IF
               
               #檢查重複
               IF NOT cl_null(g_prbg_d[l_ac].prbgsite) AND (g_prbg_d[l_ac].prbg003 <> g_prbg_d_t.prbg003 OR cl_null(g_prbg_d_t.prbg003)) THEN 
                  IF g_prbg_d[l_ac].prbg001 = '2' THEN
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM prbg_t
                      #WHERE  g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) #160905-00007#12 mark
                      WHERE prbgent = g_enterprise AND g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) #160905-00007#12 add
                                           FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
                                          WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg003 = g_prbg_d[l_ac].prbg003)
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00124'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                        DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                        NEXT FIELD prbg003
                     END IF
                  END IF
                  IF g_prbg_d[l_ac].prbg001 = '1' THEN
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM rtab_t
                      WHERE rtabent = g_enterprise
                        AND rtab001 = g_prbg_d[l_ac].prbgsite
                        AND rtab002 IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
                                         FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
                                        WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg003 = g_prbg_d[l_ac].prbg003)
                     IF l_n > 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'apr-00124'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()

                        LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                        DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                        NEXT FIELD prbg003
                     END IF
                  END IF
               END IF
               
               IF g_prbg_d[l_ac].prbg001 = '1' THEN
                  SELECT imay001 INTO g_prbg_d[l_ac].prbg002 
                    FROM imay_t,rtdx_t
                   WHERE imayent = rtdxent AND imay001 = rtdx001
#                     AND imay003 = rtdx002 
                     AND imay003 = g_prbg_d[l_ac].prbg003 
                     AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
                     AND rtdxent = g_enterprise
                     AND ROWNUM = 1
               END IF
               IF g_prbg_d[l_ac].prbg001 = '2' THEN
                  SELECT imay001 INTO g_prbg_d[l_ac].prbg002 
                    FROM imay_t,rtdx_t
                   WHERE imayent = rtdxent AND imay001 = rtdx001
#                     AND imay003 = rtdx002 
                     AND imay003 = g_prbg_d[l_ac].prbg003 
                     AND rtdxsite = g_prbg_d[l_ac].prbgsite
                     AND rtdxent = g_enterprise
                     AND ROWNUM = 1
               END IF
               
               #150401-00003#1--add by dongsz--str---
			      IF NOT aprt111_prbg002_chk() THEN
			         LET g_prbg_d[l_ac].prbg003 = g_prbg_d_t.prbg003
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg003
                  NEXT FIELD CURRENT
			      END IF
			      #150401-00003#1--add by dongsz--end---
               
               CALL aprt111_prbg002_rtdx(l_cmd)

            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg003
            #add-point:BEFORE FIELD prbg003 name="input.b.page1.prbg003"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg003
            #add-point:ON CHANGE prbg003 name="input.g.page1.prbg003"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg002
            
            #add-point:AFTER FIELD prbg002 name="input.a.page1.prbg002"
            CALL aprt111_prbg002_init()                                                                                                                        
            IF NOT cl_null(g_prbg_d[l_ac].prbg002) THEN 
#此段落由子樣板a19產生
               #150401-00003#1--add by dongsz--str---
			      IF cl_null(g_prbf_m.prbf005) THEN
			         #判斷商品是否歸屬arti204設定的部門可用品類
                  IF NOT s_arti204_control_check(g_prog,g_prbf_m.prbf011,g_prbg_d[l_ac].prbg002,'') THEN
                     LET g_prbg_d[l_ac].prbg002 = g_prbg_d_t.prbg002
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg002
                     NEXT FIELD CURRENT
                  END IF
			      END IF
			      
			      CALL aprt111_prbg002_rtdx(l_cmd)
			      
			      IF NOT aprt111_prbg002_chk() THEN
			         LET g_prbg_d[l_ac].prbg002 = g_prbg_d_t.prbg002
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg002
                  NEXT FIELD CURRENT
			      END IF
			      #150401-00003#1--add by dongsz--end---

               #150401-00003#1--mark by dongsz--str---
#               IF NOT cl_null(g_prbg_d[l_ac].prbgsite) THEN
#                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#                  INITIALIZE g_chkparam.* TO NULL
#                  
#                  #設定g_chkparam.*的參數
#                  LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg002
#                  LET g_chkparam.arg2 = g_prbg_d[l_ac].prbgsite
#                  LET g_chkparam.arg3 = g_prbf_m.prbf005
#                  LET g_chkparam.arg4 = g_prbf_m.prbf004
#
#                  #呼叫檢查存在並帶值的library
#                  IF g_prbg_d[l_ac].prbg001 = '1' THEN
#                     IF g_prbf_m.prbf005 <> 'ALL' THEN
#                        IF cl_chk_exist("v_rtdx001_3") THEN
#                           #檢查成功時後續處理
#                           #LET  = g_chkparam.return1
#                           #DISPLAY BY NAME 
#                        ELSE
#                           #檢查失敗時後續處理
#                           NEXT FIELD CURRENT
#                        END IF
#                     ELSE
#                        IF cl_chk_exist("v_rtdx001_5") THEN
#                           #檢查成功時後續處理
#                           #LET  = g_chkparam.return1
#                           #DISPLAY BY NAME 
#                        ELSE
#                           #檢查失敗時後續處理
#                           NEXT FIELD CURRENT
#                        END IF
#                     END IF
#                  END IF
#                  IF g_prbg_d[l_ac].prbg001 = '2' THEN
#                     IF g_prbf_m.prbf005 <> 'ALL' THEN
#                        IF cl_chk_exist("v_rtdx001_2") THEN
#                           #檢查成功時後續處理
#                           #LET  = g_chkparam.return1
#                           #DISPLAY BY NAME 
#                        ELSE
#                           #檢查失敗時後續處理
#                           NEXT FIELD CURRENT
#                        END IF
#                     ELSE
#                        IF cl_chk_exist("v_rtdx001_4") THEN
#                           #檢查成功時後續處理
#                           #LET  = g_chkparam.return1
#                           #DISPLAY BY NAME 
#                        ELSE
#                           #檢查失敗時後續處理
#                           NEXT FIELD CURRENT
#                        END IF
#                     END IF
#                  END IF
#                  
#                  #檢查重複
#                  IF g_prbg_d[l_ac].prbg002 <> g_prbg_d_t.prbg002 OR cl_null(g_prbg_d_t.prbg002) THEN 
#                     IF g_prbg_d[l_ac].prbg001 = '2' THEN
#                        LET l_n = 0
#                        SELECT COUNT(*) INTO l_n FROM prbg_t
#                         #WHERE prbgent = g_enterprise
#                           #AND prbgdocno = g_prbf_m.prbfdocno
#                           #AND prbg002 = g_prbg_d[l_ac].prbg002
#                         WHERE g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
#                                              FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
#                                             WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
#                        IF l_n > 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = 'apr-00124'
#                           LET g_errparam.extend = ''
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#
#                           LET g_prbg_d[l_ac].prbg002 = g_prbg_d_t.prbg002
#                           DISPLAY BY NAME g_prbg_d[l_ac].prbg002
#                           NEXT FIELD prbg002
#                        END IF
#                     END IF
#                     IF g_prbg_d[l_ac].prbg001 = '1' THEN
#                        LET l_n = 0
#                        SELECT COUNT(*) INTO l_n FROM rtab_t
#                         WHERE rtabent = g_enterprise
#                           AND rtab001 = g_prbg_d[l_ac].prbgsite
#                           AND rtab002 IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
#                                            FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
#                                           WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
#                        IF l_n > 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = 'apr-00124'
#                           LET g_errparam.extend = ''
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#
#                           LET g_prbg_d[l_ac].prbg002 = g_prbg_d_t.prbg002
#                           DISPLAY BY NAME g_prbg_d[l_ac].prbg002
#                           NEXT FIELD prbg002
#                        END IF
#                     END IF
#                  END IF
#               END IF
               #150401-00003#1--mark by dongsz--end---
            
               CALL aprt111_prbg002_rtdx(l_cmd)
               
            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg002
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg002_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg002
            #add-point:BEFORE FIELD prbg002 name="input.b.page1.prbg002"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg002
            #add-point:ON CHANGE prbg002 name="input.g.page1.prbg002"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaxl003
            #add-point:BEFORE FIELD rtaxl003 name="input.b.page1.rtaxl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaxl003
            
            #add-point:AFTER FIELD rtaxl003 name="input.a.page1.rtaxl003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtaxl003
            #add-point:ON CHANGE rtaxl003 name="input.g.page1.rtaxl003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg024
            #add-point:BEFORE FIELD prbg024 name="input.b.page1.prbg024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg024
            
            #add-point:AFTER FIELD prbg024 name="input.a.page1.prbg024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg024
            #add-point:ON CHANGE prbg024 name="input.g.page1.prbg024"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg007
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbg_d[l_ac].prbg007,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbg007
            END IF 
 
 
 
            #add-point:AFTER FIELD prbg007 name="input.a.page1.prbg007"
            #150401-00003#1--add by dongsz--str---   
            LET l_prbg007 = g_prbg_d[l_ac].prbg007
            LET l_prbg009 = g_prbg_d[l_ac].prbg009
            IF cl_null(l_prbg007) THEN
               #LET l_prbg007 = g_prbg_d[l_ac-1].prbg007   #20150923 dongsz mark
               LET l_prbg007 = g_prbg_d[l_ac].prbg021      #20150923 dongsz add
            END IF
            IF cl_null(l_prbg009) THEN
               #LET l_prbg009 = g_prbg_d[l_ac-1].prbg009   #20150923 dongsz mark
               LET l_prbg009 = g_prbg_d[l_ac].prbg023      #20150923 dongsz add
            END IF
            IF NOT cl_null(l_prbg007) AND NOT cl_null(l_prbg009) THEN
               LET g_prbg_d[l_ac].prbg013 = (l_prbg009-l_prbg007)/l_prbg009*100
               DISPLAY BY NAME g_prbg_d[l_ac].prbg013              
            END IF
            
            CALL aprt111_prbg_required_1()
#            IF g_prbf001 = '3' THEN            
#               IF cl_null(g_prbg_d[l_ac].prbg007) THEN
#                  CALL cl_set_comp_required("prbg014,prbg015",FALSE)
#               ELSE
#                  CALL cl_set_comp_required("prbg014,prbg015",TRUE)
#               END IF
#            END IF            
            #150401-00003#1--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg007
            #add-point:BEFORE FIELD prbg007 name="input.b.page1.prbg007"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg007
            #add-point:ON CHANGE prbg007 name="input.g.page1.prbg007"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg023
            #add-point:BEFORE FIELD prbg023 name="input.b.page1.prbg023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg023
            
            #add-point:AFTER FIELD prbg023 name="input.a.page1.prbg023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg023
            #add-point:ON CHANGE prbg023 name="input.g.page1.prbg023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg009
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbg_d[l_ac].prbg009,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbg009
            END IF 
 
 
 
            #add-point:AFTER FIELD prbg009 name="input.a.page1.prbg009"
            #150401-00003#1--add by dongsz--str---  
            LET l_prbg007 = g_prbg_d[l_ac].prbg007
            LET l_prbg009 = g_prbg_d[l_ac].prbg009
            IF cl_null(l_prbg007) THEN
               #LET l_prbg007 = g_prbg_d[l_ac-1].prbg007   #20150923 dongsz mark
               LET l_prbg007 = g_prbg_d[l_ac].prbg021      #20150923 dongsz add
            END IF
            IF cl_null(l_prbg009) THEN
               #LET l_prbg009 = g_prbg_d[l_ac-1].prbg009   #20150923 dongsz mark
               LET l_prbg009 = g_prbg_d[l_ac].prbg023      #20150923 dongsz add
            END IF
            IF NOT cl_null(l_prbg007) AND NOT cl_null(l_prbg009) THEN
               LET g_prbg_d[l_ac].prbg013 = (l_prbg009-l_prbg007)/l_prbg009*100
               DISPLAY BY NAME g_prbg_d[l_ac].prbg013              
            END IF
            
            CALL aprt111_prbg_required_2()             
            #IF g_prbf001 = '3' THEN            
            #   IF cl_null(g_prbg_d[l_ac].prbg009) THEN
            #      CALL cl_set_comp_required("prbg016,prbg017",FALSE)
            #   ELSE
            #      CALL cl_set_comp_required("prbg016,prbg017",TRUE)
            #   END IF
            #END IF
            #150401-00003#1--add by dongsz--end--- 
            #20150923--add by dongsz--s
            IF NOT cl_null(g_prbg_d[l_ac].prbg009) THEN          #161115-00016#1 161116 by lori remark
           #IF NOT cl_null(g_prbg_d[l_ac].prbg009)               #150903-00008#14 dongsz add   #161115-00016#1 161116 by lori mark
           #    AND g_prbf001 <> '7' AND g_prbf001 <> '8' THEN   #150903-00008#14 dongsz add   #161115-00016#1 161116 by lori mark
               
               #161115-00016#1 161116 by lori add---(S)
               #aprt113/aprt114/aprt115 不可大於執行售價
               IF g_argv[1] = '3' OR g_argv[1] = '6' OR g_argv[1] = '7' THEN
                 #170105-00015#1 170105 by lori mod---(S) 
                 #IF NOT cl_null(g_prbg_d[l_ac].prbg023) THEN                    
                 #   IF g_prbg_d[l_ac].prbg009 > g_prbg_d[l_ac].prbg023 THEN
                 #      LET g_prbg_d[l_ac].prbg009 = g_prbg_d_o.prbg009
                 #      INITIALIZE g_errparam TO NULL
                 #      
                 #      IF g_argv[1] = '3' OR g_argv[1] = '6' THEN
                 #         LET g_errparam.code  = "apr-00553"
                 #      ELSE
                 #         LET g_errparam.code  = "apr-00555"
                 #      END IF
                 #      
                 #      LET g_errparam.popup = TRUE
                 #      CALL cl_err()
                 #   
                 #      NEXT FIELD CURRENT
                 #   END IF
                 #END IF
                  
                  CASE g_argv[1]
                     WHEN '3'   LET l_chk_type = '1'   #aprt113
                     WHEN '6'   LET l_chk_type = '1'   #aprt114
                     WHEN '7'   LET l_chk_type = '2'   #aprt115
                  END CASE
                  
                  IF NOT aprt111_chk_price(g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg009,l_chk_type) THEN
                     LET g_prbg_d[l_ac].prbg009 = g_prbg_d_o.prbg009
                     NEXT FIELD CURRENT
                  END IF                    
                 #170105-00015#1 170105 by lori mod---(E)                  
               END IF
               #161115-00016#1 161116 by lori add---(E)
                  
               IF g_prbf001 <> '7' AND g_prbf001 <> '8' THEN    #161115-00016#1 161115 by lori add
                  IF g_prbg_d[l_ac].prbg009 <> g_prbg_d_o.prbg009 OR cl_null(g_prbg_d_o.prbg009) THEN
                     LET g_prbg_d[l_ac].prbg010 = g_prbg_d[l_ac].prbg009
                     LET g_prbg_d[l_ac].prbg011 = g_prbg_d[l_ac].prbg009
                     LET g_prbg_d[l_ac].prbg012 = g_prbg_d[l_ac].prbg009
                  END IF
               END IF   #161115-00016#1 161115 by lori add   
            END IF
            
            LET g_prbg_d_o.prbg009 = g_prbg_d[l_ac].prbg009
            
            #161115-00016#1 161116 by lori add---(S)
            LET g_prbg_d_o.prbg010 = g_prbg_d[l_ac].prbg010
            LET g_prbg_d_o.prbg011 = g_prbg_d[l_ac].prbg011
            LET g_prbg_d_o.prbg012 = g_prbg_d[l_ac].prbg012           
            #161115-00016#1 161116 by lori add---(E)
            #20150923--add by dongsz--e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg009
            #add-point:BEFORE FIELD prbg009 name="input.b.page1.prbg009"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg009
            #add-point:ON CHANGE prbg009 name="input.g.page1.prbg009"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg010
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbg_d[l_ac].prbg010,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbg010
            END IF 
 
 
 
            #add-point:AFTER FIELD prbg010 name="input.a.page1.prbg010"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg010) THEN                
               #161115-00016#1 161116 by lori add---(S)
               #aprt113/aprt114/aprt115/aprt116 不可大於執行售價
               IF g_argv[1] = '3' OR g_argv[1] = '6' OR g_argv[1] = '7' OR g_argv[1] = '8' THEN
                 #170105-00015#1 170105 by lori mod---(S) 
                 #IF NOT cl_null(g_prbg_d[l_ac].prbg023) THEN
                 #   IF g_prbg_d[l_ac].prbg010 > g_prbg_d[l_ac].prbg023 THEN
                 #      LET g_prbg_d[l_ac].prbg010 = g_prbg_d_o.prbg010
                 #      INITIALIZE g_errparam TO NULL
                 #      LET g_errparam.code  = "apr-00554"
                 #      LET g_errparam.popup = TRUE
                 #      CALL cl_err()
                 #
                 #      NEXT FIELD CURRENT
                 #   END IF
                 #END IF
                 
                  LET l_chk_type = '3' 
                  
                  IF NOT aprt111_chk_price(g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg010,l_chk_type) THEN
                     LET g_prbg_d[l_ac].prbg010 = g_prbg_d_o.prbg010
                     NEXT FIELD CURRENT
                  END IF                    
                 #170105-00015#1 170105 by lori mod---(E)                  
               END IF
               #161115-00016#1 161116 by lori add---(E)               

               #20150709--add by dongsz--s
               IF g_prbg_d[l_ac].prbg010 > g_prbg_d[l_ac].prbg009 THEN
                  IF NOT cl_ask_confirm('apr-00474') THEN      #161115-00016#1 161123 By benson
                     LET g_prbg_d[l_ac].prbg010 = g_prbg_d_t.prbg010
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg010
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #20150709--add by dongsz--e               
               #20151104--dongsz add--str---
               IF g_prbg_d[l_ac].prbg010 <> g_prbg_d_o.prbg010 OR cl_null(g_prbg_d_o.prbg010) THEN
                  LET g_prbg_d[l_ac].prbg011 = g_prbg_d[l_ac].prbg010
                  LET g_prbg_d[l_ac].prbg012 = g_prbg_d[l_ac].prbg010
               END IF
               LET g_prbg_d_o.prbg010 = g_prbg_d[l_ac].prbg010
               #20151104--dongsz add--end---
            END IF 
            CALL aprt111_prbg_required_2()             #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg010
            #add-point:BEFORE FIELD prbg010 name="input.b.page1.prbg010"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg010
            #add-point:ON CHANGE prbg010 name="input.g.page1.prbg010"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbg_d[l_ac].prbg011,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbg011
            END IF 
 
 
 
            #add-point:AFTER FIELD prbg011 name="input.a.page1.prbg011"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg011) THEN                
               #161115-00016#1 161116 by lori add---(S)
               #aprt113/aprt114/aprt116 不可大於執行售價
               IF g_argv[1] = '3' OR g_argv[1] = '6' OR g_argv[1] = '8' THEN
                 #170105-00015#1 170105 by lori mod---(S)     
                 #IF NOT cl_null(g_prbg_d[l_ac].prbg023) THEN
                 #   IF g_prbg_d[l_ac].prbg011 > g_prbg_d[l_ac].prbg023 THEN
                 #      LET g_prbg_d[l_ac].prbg011 = g_prbg_d_o.prbg011
                 #      INITIALIZE g_errparam TO NULL
                 #      LET g_errparam.code  = "apr-00554"
                 #      LET g_errparam.popup = TRUE
                 #      CALL cl_err()
                 #
                 #      NEXT FIELD CURRENT
                 #   END IF
                 #END IF
                 
                  LET l_chk_type = '3' 
                  
                  IF NOT aprt111_chk_price(g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg011,l_chk_type) THEN
                     LET g_prbg_d[l_ac].prbg011 = g_prbg_d_o.prbg011
                     NEXT FIELD CURRENT
                  END IF                    
                 #170105-00015#1 170105 by lori mod---(E)                   
               END IF
               #161115-00016#1 161116 by lori add---(E)

               IF g_prbg_d[l_ac].prbg011 > g_prbg_d[l_ac].prbg009 THEN
                  IF NOT cl_ask_confirm('apr-00474') THEN      #161115-00016#1 161123 By benson
                     LET g_prbg_d[l_ac].prbg011 = g_prbg_d_t.prbg011
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg011
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL aprt111_prbg_required_2()             #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg011
            #add-point:BEFORE FIELD prbg011 name="input.b.page1.prbg011"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg011
            #add-point:ON CHANGE prbg011 name="input.g.page1.prbg011"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg012
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_prbg_d[l_ac].prbg012,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD prbg012
            END IF 
 
 
 
            #add-point:AFTER FIELD prbg012 name="input.a.page1.prbg012"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg012) THEN                
               #161115-00016#1 161116 by lori add---(S)
               #aprt113/aprt114/aprt116 不可大於執行售價
               IF g_argv[1] = '3' OR g_argv[1] = '6' OR g_argv[1] = '8' THEN
                 #170105-00015#1 170105 by lori mod---(S)     
                 #IF NOT cl_null(g_prbg_d[l_ac].prbg023) THEN
                 #   IF g_prbg_d[l_ac].prbg012 > g_prbg_d[l_ac].prbg023 THEN
                 #      LET g_prbg_d[l_ac].prbg012 = g_prbg_d_o.prbg012
                 #      INITIALIZE g_errparam TO NULL
                 #      LET g_errparam.code  = "apr-00554"
                 #      LET g_errparam.popup = TRUE
                 #      CALL cl_err()
                 #
                 #      NEXT FIELD CURRENT
                 #   END IF
                 #END IF
                 
                  LET l_chk_type = '3' 
                  
                  IF NOT aprt111_chk_price(g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg012,l_chk_type) THEN
                     LET g_prbg_d[l_ac].prbg012 = g_prbg_d_o.prbg012
                     NEXT FIELD CURRENT
                  END IF                    
                 #170105-00015#1 170105 by lori mod---(E)                     
               END IF
               #161115-00016#1 161116 by lori add---(E) 

               IF g_prbg_d[l_ac].prbg012 > g_prbg_d[l_ac].prbg009 THEN
                  IF NOT cl_ask_confirm('apr-00474') THEN      #161115-00016#1 161123 By benson
                     LET g_prbg_d[l_ac].prbg012 = g_prbg_d_t.prbg012
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg012
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            CALL aprt111_prbg_required_2()             #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg012
            #add-point:BEFORE FIELD prbg012 name="input.b.page1.prbg012"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg012
            #add-point:ON CHANGE prbg012 name="input.g.page1.prbg012"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg025
            #add-point:BEFORE FIELD prbg025 name="input.b.page1.prbg025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg025
            
            #add-point:AFTER FIELD prbg025 name="input.a.page1.prbg025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg025
            #add-point:ON CHANGE prbg025 name="input.g.page1.prbg025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg026
            #add-point:BEFORE FIELD prbg026 name="input.b.page1.prbg026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg026
            
            #add-point:AFTER FIELD prbg026 name="input.a.page1.prbg026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg026
            #add-point:ON CHANGE prbg026 name="input.g.page1.prbg026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgseq1
            #add-point:BEFORE FIELD prbgseq1 name="input.b.page1.prbgseq1"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgseq1
            
            #add-point:AFTER FIELD prbgseq1 name="input.a.page1.prbgseq1"
                                                                                                                                                #此段落由子樣板a05產生
            IF  g_prbf_m.prbfdocno IS NOT NULL AND g_prbg_d[g_detail_idx].prbgseq IS NOT NULL AND g_prbg_d[g_detail_idx].prbgseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbf_m.prbfdocno != g_prbfdocno_t OR g_prbg_d[g_detail_idx].prbgseq != g_prbg_d_t.prbgseq OR g_prbg_d[g_detail_idx].prbgseq1 != g_prbg_d_t.prbgseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbg_t WHERE "||"prbgent = '" ||g_enterprise|| "' AND "||"prbgdocno = '"||g_prbf_m.prbfdocno ||"' AND "|| "prbgseq = '"||g_prbg_d[g_detail_idx].prbgseq ||"' AND "|| "prbgseq1 = '"||g_prbg_d[g_detail_idx].prbgseq1 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbgseq1
            #add-point:ON CHANGE prbgseq1 name="input.g.page1.prbgseq1"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg004
            #add-point:BEFORE FIELD prbg004 name="input.b.page1.prbg004"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg004
            
            #add-point:AFTER FIELD prbg004 name="input.a.page1.prbg004"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg004
            #add-point:ON CHANGE prbg004 name="input.g.page1.prbg004"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg005
            
            #add-point:AFTER FIELD prbg005 name="input.a.page1.prbg005"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg005) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg005
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 

               ELSE
                  #檢查失敗時後續處理
                  LET g_prbg_d[l_ac].prbg005 = g_prbg_d_t.prbg005
                  LET g_prbg_d[l_ac].prbg005_desc = ''
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg005
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg005_desc

            CALL aprt111_prbg_required_1()               #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg005
            #add-point:BEFORE FIELD prbg005 name="input.b.page1.prbg005"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg005
            #add-point:ON CHANGE prbg005 name="input.g.page1.prbg005"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg006
            
            #add-point:AFTER FIELD prbg006 name="input.a.page1.prbg006"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg006) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #LET g_chkparam.arg1 = g_prbg_d[l_ac-1].prbgsite    #20150923 dongsz mark
               LET g_chkparam.arg1 = g_prbg_d[l_ac].prbgsite    #20150923 dongsz add
               LET g_chkparam.arg2 = g_prbg_d[l_ac].prbg006

               #20150924--mark by dongsz--s
#               SELECT prbg001 INTO l_prbg001 FROM prbg_t
#                WHERE prbgent = g_enterprise
#                  AND prbgdocno = g_prbf_m.prbfdocno
#                  AND prbgseq = g_prbg_d[l_ac].prbgseq
#                  AND prbgseq1 = '0'
               #20150924--mark by dongsz--e
               #IF l_prbg001 = '2' THEN    #20150924--mark by dongsz
               IF g_prbg_d[l_ac].prbg001 = '2' THEN    #20150924--add by dongsz
                  #呼叫檢查存在並帶值的library
                  #160318-00025#32  2016/04/12  BY pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#32  2016/04/12  BY pengxin  add(E)
                  IF cl_chk_exist("v_oodb002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #呼叫檢查存在並帶值的library
                  #160318-00025#32  2016/04/12  BY pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#32  2016/04/12  BY pengxin  add(E)
                  IF cl_chk_exist("v_oodb002_5") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 

            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbf_m.prbfsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbg_d[l_ac].prbg006
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg006_desc
            
            CALL aprt111_prbg_required_1()               #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg006
            #add-point:BEFORE FIELD prbg006 name="input.b.page1.prbg006"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg006
            #add-point:ON CHANGE prbg006 name="input.g.page1.prbg006"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg006_desc
            #add-point:BEFORE FIELD prbg006_desc name="input.b.page1.prbg006_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg006_desc
            
            #add-point:AFTER FIELD prbg006_desc name="input.a.page1.prbg006_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg006_desc
            #add-point:ON CHANGE prbg006_desc name="input.g.page1.prbg006_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg022
            #add-point:BEFORE FIELD prbg022 name="input.b.page1.prbg022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg022
            
            #add-point:AFTER FIELD prbg022 name="input.a.page1.prbg022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg022
            #add-point:ON CHANGE prbg022 name="input.g.page1.prbg022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg014
            #add-point:BEFORE FIELD prbg014 name="input.b.page1.prbg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg014
            
            #add-point:AFTER FIELD prbg014 name="input.a.page1.prbg014"
            #150401-00003#1--add by dongsz--str---
            IF NOT cl_null(g_prbg_d[l_ac].prbg014) THEN
               IF g_prbg_d[l_ac].prbg014 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbg_d[l_ac].prbg014 = g_prbg_d_t.prbg014
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg014
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbg_d[l_ac].prbg015) THEN
                  IF g_prbg_d[l_ac].prbg014 > g_prbg_d[l_ac].prbg015 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbg_d[l_ac].prbg014 = g_prbg_d_t.prbg014
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg014
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_prbf001 = '3' THEN            
               IF cl_null(g_prbg_d[l_ac].prbg007) AND cl_null(g_prbg_d[l_ac].prbg014) AND
                  cl_null(g_prbg_d[l_ac].prbg015) THEN
                  CALL cl_set_comp_required("prbg007,prbg014,prbg015",FALSE)
               ELSE
                  CALL cl_set_comp_required("prbg007,prbg014,prbg015",TRUE)
               END IF
            END IF
            CALL aprt111_prbg_required_1()
            #150401-00003#1--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg014
            #add-point:ON CHANGE prbg014 name="input.g.page1.prbg014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg015
            #add-point:BEFORE FIELD prbg015 name="input.b.page1.prbg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg015
            
            #add-point:AFTER FIELD prbg015 name="input.a.page1.prbg015"
            #150401-00003#1--add by dongsz--str---
            IF NOT cl_null(g_prbg_d[l_ac].prbg015) THEN
               IF g_prbg_d[l_ac].prbg015 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbg_d[l_ac].prbg015 = g_prbg_d_t.prbg015
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg015
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbg_d[l_ac].prbg014) THEN
                  IF g_prbg_d[l_ac].prbg014 > g_prbg_d[l_ac].prbg015 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbg_d[l_ac].prbg015 = g_prbg_d_t.prbg015
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg015
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_prbf001 = '3' THEN            
               IF cl_null(g_prbg_d[l_ac].prbg007) AND cl_null(g_prbg_d[l_ac].prbg014) AND
                  cl_null(g_prbg_d[l_ac].prbg015) THEN
                  CALL cl_set_comp_required("prbg007,prbg014,prbg015",FALSE)
               ELSE
                  CALL cl_set_comp_required("prbg007,prbg014,prbg015",TRUE)
               END IF
            END IF
            CALL aprt111_prbg_required_1()
            #150401-00003#1--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg015
            #add-point:ON CHANGE prbg015 name="input.g.page1.prbg015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg018
            
            #add-point:AFTER FIELD prbg018 name="input.a.page1.prbg018"
            IF NOT cl_null(g_prbg_d[l_ac].prbg018) THEN 
#應用 a17 樣板自動產生(Version:2)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               LET g_errshow = TRUE #是否開窗 #160318-00025#32  add
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg018
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"  #160318-00025#32  add
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooca001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_prbg_d[l_ac].prbg018 = g_prbg_d_t.prbg018
                  LET g_prbg_d[l_ac].prbg018_desc = ''
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc
                  NEXT FIELD CURRENT
               END IF


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg018_desc

            CALL aprt111_prbg_required_2()               #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg018
            #add-point:BEFORE FIELD prbg018 name="input.b.page1.prbg018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg018
            #add-point:ON CHANGE prbg018 name="input.g.page1.prbg018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg008
            
            #add-point:AFTER FIELD prbg008 name="input.a.page1.prbg008"
                                                                                                                                    
            IF NOT cl_null(g_prbg_d[l_ac].prbg008) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               #LET g_chkparam.arg1 = g_prbg_d[l_ac-1].prbgsite    #20150923 dongsz mark
               LET g_chkparam.arg1 = g_prbg_d[l_ac].prbgsite       #20150923 dongsz add
               LET g_chkparam.arg2 = g_prbg_d[l_ac].prbg008

               #20150924--mark by dongsz--s
#               SELECT prbg001 INTO l_prbg001 FROM prbg_t
#                WHERE prbgent = g_enterprise
#                  AND prbgdocno = g_prbf_m.prbfdocno
#                  AND prbgseq = g_prbg_d[l_ac].prbgseq
#                  AND prbgseq1 = '0'
               #20150924--mark by dongsz--e
               #IF l_prbg001 = '2' THEN        #20150924--mark by dongsz
               IF g_prbg_d[l_ac].prbg001 = '2' THEN        #20150924--add by dongsz               
                  #呼叫檢查存在並帶值的library
                  #160318-00025#32  2016/04/12  BY pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#32  2016/04/12  BY pengxin  add(E)
                  IF cl_chk_exist("v_oodb002") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #160318-00025#32  2016/04/12  BY pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗
                  LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610"
                  #160318-00025#32  2016/04/12  BY pengxin  add(E)
                  IF cl_chk_exist("v_oodb002_5") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 

            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbf_m.prbfsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbg_d[l_ac].prbg008
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg008_desc
            
            CALL aprt111_prbg_required_2()             #150401-00003#1--add by dongsz
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg008
            #add-point:BEFORE FIELD prbg008 name="input.b.page1.prbg008"
                                                                                                                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg008
            #add-point:ON CHANGE prbg008 name="input.g.page1.prbg008"
                                                                                                                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg008_desc
            #add-point:BEFORE FIELD prbg008_desc name="input.b.page1.prbg008_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg008_desc
            
            #add-point:AFTER FIELD prbg008_desc name="input.a.page1.prbg008_desc"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg008_desc
            #add-point:ON CHANGE prbg008_desc name="input.g.page1.prbg008_desc"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg016
            #add-point:BEFORE FIELD prbg016 name="input.b.page1.prbg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg016
            
            #add-point:AFTER FIELD prbg016 name="input.a.page1.prbg016"
            #150401-00003#1--add by dongsz--str---
            IF NOT cl_null(g_prbg_d[l_ac].prbg016) THEN
               IF g_prbg_d[l_ac].prbg016 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbg_d[l_ac].prbg016 = g_prbg_d_t.prbg016
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg016
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbg_d[l_ac].prbg017) THEN
                  IF g_prbg_d[l_ac].prbg016 > g_prbg_d[l_ac].prbg017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbg_d[l_ac].prbg016 = g_prbg_d_t.prbg016
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg016
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_prbf001 = '3' THEN            
               IF cl_null(g_prbg_d[l_ac].prbg009) AND cl_null(g_prbg_d[l_ac].prbg016) AND
                  cl_null(g_prbg_d[l_ac].prbg017) THEN
                  CALL cl_set_comp_required("prbg009,prbg016,prbg017",FALSE)
               ELSE
                  CALL cl_set_comp_required("prbg009,prbg016,prbg017",TRUE)
               END IF
               
               LET g_prbg_d[l_ac].prbg019 = g_prbg_d[l_ac].prbg016    #151013-00001#44 dongsz add
            END IF
            CALL aprt111_prbg_required_2()
            #150401-00003#1--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg016
            #add-point:ON CHANGE prbg016 name="input.g.page1.prbg016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg017
            #add-point:BEFORE FIELD prbg017 name="input.b.page1.prbg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg017
            
            #add-point:AFTER FIELD prbg017 name="input.a.page1.prbg017"
            #150401-00003#1--add by dongsz--str---
            IF NOT cl_null(g_prbg_d[l_ac].prbg017) THEN
               IF g_prbg_d[l_ac].prbg017 < g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_prbg_d[l_ac].prbg017 = g_prbg_d_t.prbg017
                  DISPLAY BY NAME g_prbg_d[l_ac].prbg017
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(g_prbg_d[l_ac].prbg016) THEN
                  IF g_prbg_d[l_ac].prbg016 > g_prbg_d[l_ac].prbg017 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00081'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_prbg_d[l_ac].prbg017 = g_prbg_d_t.prbg017
                     DISPLAY BY NAME g_prbg_d[l_ac].prbg017
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_prbf001 = '3' THEN   
               IF cl_null(g_prbg_d[l_ac].prbg009) AND cl_null(g_prbg_d[l_ac].prbg016) AND
                  cl_null(g_prbg_d[l_ac].prbg017) THEN
                  CALL cl_set_comp_required("prbg009,prbg016,prbg017",FALSE)
               ELSE
                  CALL cl_set_comp_required("prbg009,prbg016,prbg017",TRUE)
               END IF
               
               LET g_prbg_d[l_ac].prbg020 = g_prbg_d[l_ac].prbg017   #151013-00001#44 dongsz add
            END IF
            CALL aprt111_prbg_required_2()
            #150401-00003#1--add by dongsz--end---
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg017
            #add-point:ON CHANGE prbg017 name="input.g.page1.prbg017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg019
            #add-point:BEFORE FIELD prbg019 name="input.b.page1.prbg019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg019
            
            #add-point:AFTER FIELD prbg019 name="input.a.page1.prbg019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg019
            #add-point:ON CHANGE prbg019 name="input.g.page1.prbg019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg020
            #add-point:BEFORE FIELD prbg020 name="input.b.page1.prbg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg020
            
            #add-point:AFTER FIELD prbg020 name="input.a.page1.prbg020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg020
            #add-point:ON CHANGE prbg020 name="input.g.page1.prbg020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbg013
            #add-point:BEFORE FIELD prbg013 name="input.b.page1.prbg013"
                                                                                                                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbg013
            
            #add-point:AFTER FIELD prbg013 name="input.a.page1.prbg013"
                                                                                                                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbg013
            #add-point:ON CHANGE prbg013 name="input.g.page1.prbg013"
                                                                                                                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.prbgunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgunit
            #add-point:ON ACTION controlp INFIELD prbgunit name="input.c.page1.prbgunit"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgseq
            #add-point:ON ACTION controlp INFIELD prbgseq name="input.c.page1.prbgseq"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg001
            #add-point:ON ACTION controlp INFIELD prbg001 name="input.c.page1.prbg001"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgsite
            #add-point:ON ACTION controlp INFIELD prbgsite name="input.c.page1.prbgsite"
                                                                        #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbgsite             #給予default值
            LET g_qryparam.default2 = g_prbg_d[l_ac].prbgsite_desc        #給予default值

            IF g_prbg_d[l_ac].prbg001 = '1' THEN
               SELECT ooez006,ooez007 INTO l_ooez006,l_ooez007
                 FROM ooez_t
                WHERE ooezent = g_enterprise
                  AND ooez001 = g_prog
                  AND ooez002 = '1'
               IF SQLCA.SQLCODE = 100 THEN
                  #給予arg
                  LET g_qryparam.arg1 = "4"     #
                  LET g_qryparam.arg2 = g_prbf_m.prbfsite
                  LET g_qryparam.arg3 = "9"
                  CALL q_rtaa001_6()
               ELSE
                  IF l_ooez007 = 'Y' THEN
                     #給予arg
                     LET g_qryparam.arg1 = "4"     #
                     LET g_qryparam.arg2 = g_prbf_m.prbfsite
                     LET g_qryparam.arg3 = l_ooez006
                     CALL q_rtaa001_6()
                  ELSE
                     LET g_qryparam.arg1 = "4"
                     CALL q_rtaa001_4()
                  END IF
               END IF              
               
               LET g_prbg_d[l_ac].prbgsite = g_qryparam.return1              #將開窗取得的值回傳到變數
               LET g_prbg_d[l_ac].prbgsite_desc = g_qryparam.return2         #將開窗取得的值回傳到變數
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
               CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
            END IF
            IF g_prbg_d[l_ac].prbg001 = '2' THEN
               #給予arg
#               LET g_qryparam.arg1 = g_site  #
#               LET g_qryparam.arg2 = "8"     #
#
#               CALL q_ooed004()                                #呼叫開窗
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbgsite',g_prbf_m.prbfsite,'i')   #150308-00001#4 150309 by lori522612 add 'i'
               CALL q_ooef001_24()
               LET g_prbg_d[l_ac].prbgsite = g_qryparam.return1              #將開窗取得的值回傳到變數
               CALL s_desc_get_department_desc(g_prbg_d[l_ac].prbgsite)
                  RETURNING g_prbg_d[l_ac].prbgsite_desc
            END IF

            DISPLAY g_prbg_d[l_ac].prbgsite TO prbgsite              #顯示到畫面上
            DISPLAY g_prbg_d[l_ac].prbgsite_desc TO prbgsite_desc    #顯示到畫面上

            NEXT FIELD prbgsite                          #返回原欄位                                                              
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg003
            #add-point:ON ACTION controlp INFIELD prbg003 name="input.c.page1.prbg003"
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg002             #給予default值
            LET g_qryparam.default2 = g_prbg_d[l_ac].prbg003   

            #20150924--mark by dongsz--s
#            #給予arg
#            LET g_qryparam.arg1 = g_prbg_d[l_ac].prbgsite    #門店編號
#            LET g_qryparam.arg2 = g_prbf_m.prbf005           #品類
#            LET g_qryparam.arg3 = g_prbf_m.prbf004           #供應商
#            
#            IF NOT cl_null(g_prbf_m.prbf004) THEN
#               #LET g_qryparam.where = " rtdx031 = '",g_prbf_m.prbf004,"' "     #150401-00003#1--mark by dongsz
#               LET g_qryparam.where = " imaf153 = '",g_prbf_m.prbf004,"' "      #150401-00003#1--add by dongsz
#            ELSE
#               LET g_qryparam.where = " 1=1 " 
#            END IF
#            
#            #150401-00003#1--add by dongsz--str---
#            IF g_prbg_d[l_ac].prbg001 = '1' THEN
#               IF NOT cl_null(g_prbf_m.prbf005) THEN
#                  CALL q_prbg002_01()                                #呼叫開窗
#               ELSE
#                  LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
#                  CALL q_prbg002_03() 
#               END IF 
#            END IF
#            IF g_prbg_d[l_ac].prbg001 = '2' THEN
#               IF NOT cl_null(g_prbf_m.prbf005) THEN
#                  CALL q_prbg002()                                #呼叫開窗
#               ELSE
#                  LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
#                  CALL q_prbg002_02() 
#               END IF
#            END IF
#            #150401-00003#1--add by dongsz--end---
            #20150924--mark by dongsz--e
            #150401-00003#1--mark by dongsz--str---
#            IF g_prbg_d[l_ac].prbg001 = '1' THEN
#               IF g_prbf_m.prbf005 <> 'ALL' THEN
#                  CALL q_prbg002_01()                                #呼叫開窗
#               ELSE
#                  CALL q_prbg002_03() 
#               END IF
#            END IF
#            IF g_prbg_d[l_ac].prbg001 = '2' THEN
#               IF g_prbf_m.prbf005 <> 'ALL' THEN
#                  CALL q_prbg002()                                #呼叫開窗
#               ELSE
#                  CALL q_prbg002_02() 
#               END IF
#            END IF
            #150401-00003#1--mark by dongsz--end---
            
            #20150924--add by dongsz--s
            LET g_qryparam.where = " 1=1 "
            IF g_prbf_m.prbf001='1' OR g_prbf_m.prbf001='3' OR              #aprt114和116抓采购协议的商品
               (g_prbf_m.prbf001 MATCHES '[26789]' AND NOT cl_null(g_prbf_m.prbf004)) THEN  #aprt115和117如果供应商不为空也抓采购协议的商品
               LET g_qryparam.where = g_qryparam.where,
                   " AND EXISTS (SELECT 1 FROM stas_t,star_t ",
                   "              WHERE stasent=starent AND stas001=star001 AND stassite=starsite ",
                   "                AND stassite=rtdxsite AND stas003=rtdx001",
                   "                AND '",g_prbf_m.prbfdocdt,"' BETWEEN stas018 AND stas019 ",
                   "                AND star003 = '",g_prbf_m.prbf004,"' )"
            END IF
            IF NOT cl_null(g_prbf_m.prbf005) THEN  #品类不为空，按照管理品类抓商品
               LET g_qryparam.where = g_qryparam.where,
                   " AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t ",
                   "              WHERE rtawent = rtaxent AND rtaw001 = rtax001 ",
                   "                AND rtax004=",cl_get_para(g_enterprise,g_site,'E-CIR-0001')," ",
                   "                AND rtaw001='",g_prbf_m.prbf005,"' ",
                   "                AND rtaw002 = imaa009 )"
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
            END IF
            IF g_prbg_d[l_ac].prbg001 = '2' THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND rtdxsite = '",g_prbg_d[l_ac].prbgsite,"'"
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                   " AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = :ENT AND rtab001 = '",g_prbg_d[l_ac].prbgsite,"')"
            END IF
            #20150819--add by dongsz--s
            #一般调价不能调生鲜商品
            LET g_qryparam.where = g_qryparam.where," AND rtdx001 NOT IN (SELECT imaa001 FROM imaa_t ",
                                                    "                      WHERE imaaent = ",g_enterprise," ",
                                                    "                        AND imaa108 = '3') "
            #20150819--add by dongsz--e
            #20151029--dongsz add--str---
            IF g_prbf_m.prbf001 = '9' THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND imay005 <> 1 "
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND imay006 = 'Y' "
            END IF
            #20151029--dongsz add--end---
            
            CALL q_prbg002_04()
            #20150924--add by dongsz--e

            LET g_prbg_d[l_ac].prbg002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbg_d[l_ac].prbg003 = g_qryparam.return2
            LET g_prbg_d[l_ac].prbg002_desc = g_qryparam.return3
#            LET g_prbg_d[l_ac].prbg002_desc1 = g_qryparam.return4
#            LET g_prbg_d[l_ac].prbg002_desc2 = g_qryparam.return5
#            LET g_prbg_d[l_ac].prbg002_desc2_desc = g_qryparam.return6
            LET g_prbg_d[l_ac].prbg002_desc_desc = g_qryparam.return4
            LET g_prbg_d[l_ac].prbg002_desc_desc_desc = g_qryparam.return5
            LET g_prbg_d[l_ac].rtaxl003 = g_qryparam.return6

            DISPLAY g_prbg_d[l_ac].prbg002 TO prbg002              #顯示到畫面上
            DISPLAY g_prbg_d[l_ac].prbg003 TO prbg003
            DISPLAY g_prbg_d[l_ac].prbg002_desc TO prbg002_desc
#            DISPLAY g_prbg_d[l_ac].prbg002_desc1 TO prbg002_desc1
#            DISPLAY g_prbg_d[l_ac].prbg002_desc2 TO prbg002_desc2
#            DISPLAY g_prbg_d[l_ac].prbg002_desc2_desc TO prbg002_desc2_desc
            DISPLAY g_prbg_d[l_ac].prbg002_desc_desc TO prbg002_desc_desc
            DISPLAY g_prbg_d[l_ac].prbg002_desc_desc_desc TO prbg002_desc_desc_desc
            DISPLAY g_prbg_d[l_ac].rtaxl003 TO rtaxl003

            NEXT FIELD prbg003                          #返回原欄位                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg002
            #add-point:ON ACTION controlp INFIELD prbg002 name="input.c.page1.prbg002"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg002             #給予default值
            LET g_qryparam.default2 = g_prbg_d[l_ac].prbg003

            #20150924--mark by dongsz--s
#            #給予arg
#            LET g_qryparam.arg1 = g_prbg_d[l_ac].prbgsite    #門店編號
#            LET g_qryparam.arg2 = g_prbf_m.prbf005           #品類
#            LET g_qryparam.arg3 = g_prbf_m.prbf004           #供應商
#            
#            IF NOT cl_null(g_prbf_m.prbf004) THEN
#               #LET g_qryparam.where = " rtdx031 = '",g_prbf_m.prbf004,"' "    #150401-00003#1--mark by dongsz
#               LET g_qryparam.where = " imaf153 = '",g_prbf_m.prbf004,"' "     #150401-00003#1--add by dongsz               
#            ELSE
#               LET g_qryparam.where = " 1=1 " 
#            END IF
#            
#            #150401-00003#1--add by dongsz--str---
#            IF g_prbg_d[l_ac].prbg001 = '1' THEN
#               IF NOT cl_null(g_prbf_m.prbf005) THEN
#                  CALL q_prbg002_01()                                #呼叫開窗
#               ELSE
#                  LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
#                  CALL q_prbg002_03() 
#               END IF 
#            END IF
#            IF g_prbg_d[l_ac].prbg001 = '2' THEN
#               IF NOT cl_null(g_prbf_m.prbf005) THEN
#                  CALL q_prbg002()                                #呼叫開窗
#               ELSE
#                  LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
#                  CALL q_prbg002_02() 
#               END IF
#            END IF
#            #150401-00003#1--add by dongsz--end---
            #20150924--mark by dongsz--s
            #150401-00003#1--mark by dongsz--str---
#            IF g_prbg_d[l_ac].prbg001 = '1' THEN
#               IF g_prbf_m.prbf005 <> 'ALL' THEN
#                  CALL q_prbg002_01()                                #呼叫開窗
#               ELSE
#                  CALL q_prbg002_03() 
#               END IF 
#            END IF
#            IF g_prbg_d[l_ac].prbg001 = '2' THEN
#               IF g_prbf_m.prbf005 <> 'ALL' THEN
#                  CALL q_prbg002()                                #呼叫開窗
#               ELSE
#                  CALL q_prbg002_02() 
#               END IF
#            END IF
            #150401-00003#1--mark by dongsz--end---
            
            #20150924--add by dongsz--s
            LET g_qryparam.where = " 1=1 "
            IF g_prbf_m.prbf001='1' OR g_prbf_m.prbf001='3' OR              #aprt114和116抓采购协议的商品
               (g_prbf_m.prbf001 MATCHES '[26789]' AND NOT cl_null(g_prbf_m.prbf004))THEN  #aprt115和117如果供应商不为空也抓采购协议的商品
               LET g_qryparam.where = g_qryparam.where,
                   " AND EXISTS (SELECT 1 FROM stas_t,star_t ",
                   "              WHERE stasent=starent AND stas001=star001 AND stassite=starsite ",
                   "                AND stassite=rtdxsite AND stas003=rtdx001",
                   "                AND '",g_prbf_m.prbfdocdt,"' BETWEEN stas018 AND stas019 ",
                   "                AND star003 = '",g_prbf_m.prbf004,"' )"
            END IF
            IF NOT cl_null(g_prbf_m.prbf005) THEN  #品类不为空，按照管理品类抓商品
               LET g_qryparam.where = g_qryparam.where,
                   " AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t ",
                   "              WHERE rtawent = rtaxent AND rtaw001 = rtax001 ",
                   "                AND rtax004=",cl_get_para(g_enterprise,g_site,'E-CIR-0001')," ",
                   "                AND rtaw001='",g_prbf_m.prbf005,"' ",
                   "                AND rtaw002 = imaa009 )"
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",s_arti204_control_where(g_prog,g_prbf_m.prbf011,'1')
            END IF
            IF g_prbg_d[l_ac].prbg001 = '2' THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND rtdxsite = '",g_prbg_d[l_ac].prbgsite,"'"
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED,
                   " AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = :ENT AND rtab001 = '",g_prbg_d[l_ac].prbgsite,"')"
            END IF
            #20150819--add by dongsz--s
            #一般调价不能调生鲜商品
            LET g_qryparam.where = g_qryparam.where," AND rtdx001 NOT IN (SELECT imaa001 FROM imaa_t ",
                                                    "                      WHERE imaaent = ",g_enterprise," ",
                                                    "                        AND imaa108 = '3') "
            #20150819--add by dongsz--e
            #20151029--dongsz add--str---
            IF g_prbf_m.prbf001 = '9' THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND imay005 <> 1 "
            ELSE
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND imay006 = 'Y' "
            END IF
            #20151029--dongsz add--end---

            CALL q_prbg002_04() 
            #20150924--add by dongsz--e

            LET g_prbg_d[l_ac].prbg002 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbg_d[l_ac].prbg003 = g_qryparam.return2
            LET g_prbg_d[l_ac].prbg002_desc = g_qryparam.return3
#            LET g_prbg_d[l_ac].prbg002_desc1 = g_qryparam.return4
#            LET g_prbg_d[l_ac].prbg002_desc2 = g_qryparam.return5
#            LET g_prbg_d[l_ac].prbg002_desc2_desc = g_qryparam.return6
            LET g_prbg_d[l_ac].prbg002_desc_desc = g_qryparam.return4
            LET g_prbg_d[l_ac].prbg002_desc_desc_desc = g_qryparam.return5
            LET g_prbg_d[l_ac].rtaxl003 = g_qryparam.return6

            DISPLAY g_prbg_d[l_ac].prbg002 TO prbg002              #顯示到畫面上
            DISPLAY g_prbg_d[l_ac].prbg003 TO prbg003 
            DISPLAY g_prbg_d[l_ac].prbg002_desc TO prbg002_desc
#            DISPLAY g_prbg_d[l_ac].prbg002_desc1 TO prbg002_desc1
#            DISPLAY g_prbg_d[l_ac].prbg002_desc2 TO prbg002_desc2
#            DISPLAY g_prbg_d[l_ac].prbg002_desc2_desc TO prbg002_desc2_desc
            DISPLAY g_prbg_d[l_ac].prbg002_desc_desc TO prbg002_desc_desc
            DISPLAY g_prbg_d[l_ac].prbg002_desc_desc_desc TO prbg002_desc_desc_desc
            DISPLAY g_prbg_d[l_ac].rtaxl003 TO rtaxl003

            NEXT FIELD prbg002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.rtaxl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaxl003
            #add-point:ON ACTION controlp INFIELD rtaxl003 name="input.c.page1.rtaxl003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg024
            #add-point:ON ACTION controlp INFIELD prbg024 name="input.c.page1.prbg024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg007
            #add-point:ON ACTION controlp INFIELD prbg007 name="input.c.page1.prbg007"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg023
            #add-point:ON ACTION controlp INFIELD prbg023 name="input.c.page1.prbg023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg009
            #add-point:ON ACTION controlp INFIELD prbg009 name="input.c.page1.prbg009"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg010
            #add-point:ON ACTION controlp INFIELD prbg010 name="input.c.page1.prbg010"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg011
            #add-point:ON ACTION controlp INFIELD prbg011 name="input.c.page1.prbg011"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg012
            #add-point:ON ACTION controlp INFIELD prbg012 name="input.c.page1.prbg012"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg025
            #add-point:ON ACTION controlp INFIELD prbg025 name="input.c.page1.prbg025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg026
            #add-point:ON ACTION controlp INFIELD prbg026 name="input.c.page1.prbg026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbgseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgseq1
            #add-point:ON ACTION controlp INFIELD prbgseq1 name="input.c.page1.prbgseq1"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg004
            #add-point:ON ACTION controlp INFIELD prbg004 name="input.c.page1.prbg004"
                                                                                                                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg005
            #add-point:ON ACTION controlp INFIELD prbg005 name="input.c.page1.prbg005"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg005             #給予default值

            #給予arg

            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prbg_d[l_ac].prbg005 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_prbg_d[l_ac].prbg005 TO prbg005              #顯示到畫面上

            NEXT FIELD prbg005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg006
            #add-point:ON ACTION controlp INFIELD prbg006 name="input.c.page1.prbg006"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg006             #給予default值
            LET g_qryparam.default2 = g_prbg_d[l_ac].prbg006_desc

            #給予arg                                           #

            #20150924--mark by dongsz--s
#            SELECT prbgsite,prbg001 INTO l_prbgsite,l_prbg001 
#              FROM prbg_t
#             WHERE prbgent = g_enterprise
#               AND prbgdocno = g_prbf_m.prbfdocno
#               AND prbgseq = g_prbg_d[l_ac].prbgseq
#               AND prbgseq1 = '0'
            #20150924--mark by dongsz--e
            #IF l_prbg001 = '2' THEN        #20150924--mark by dongsz
            IF g_prbg_d[l_ac].prbg001 = '2' THEN        #20150924--add by dongsz
               LET g_qryparam.arg1 = l_prbgsite
               CALL q_oodb002_8()                                #呼叫開窗
            END IF
            IF l_prbg001 = '1' THEN
               CALL q_oodb002_9()                                #呼叫開窗
            END IF

            LET g_prbg_d[l_ac].prbg006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbg_d[l_ac].prbg006_desc = g_qryparam.return2

            DISPLAY g_prbg_d[l_ac].prbg006 TO prbg006              #顯示到畫面上
            DISPLAY g_prbg_d[l_ac].prbg006_desc TO prbg006_desc

            NEXT FIELD prbg006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg006_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg006_desc
            #add-point:ON ACTION controlp INFIELD prbg006_desc name="input.c.page1.prbg006_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg022
            #add-point:ON ACTION controlp INFIELD prbg022 name="input.c.page1.prbg022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg014
            #add-point:ON ACTION controlp INFIELD prbg014 name="input.c.page1.prbg014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg015
            #add-point:ON ACTION controlp INFIELD prbg015 name="input.c.page1.prbg015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg018
            #add-point:ON ACTION controlp INFIELD prbg018 name="input.c.page1.prbg018"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001_1()                                #呼叫開窗

            LET g_prbg_d[l_ac].prbg018 = g_qryparam.return1              

            DISPLAY g_prbg_d[l_ac].prbg018 TO prbg018              #

            NEXT FIELD prbg018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg008
            #add-point:ON ACTION controlp INFIELD prbg008 name="input.c.page1.prbg008"
                                                                                                                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg_d[l_ac].prbg008             #給予default值
            LET g_qryparam.default2 = g_prbg_d[l_ac].prbg008_desc

            #給予arg

            #20150924--mark by dongsz--s
#            SELECT prbgsite,prbg001 INTO l_prbgsite,l_prbg001 
#              FROM prbg_t
#             WHERE prbgent = g_enterprise
#               AND prbgdocno = g_prbf_m.prbfdocno
#               AND prbgseq = g_prbg_d[l_ac].prbgseq
#               AND prbgseq1 = '0'
            #20150924--mark by dongsz--e
            #IF l_prbg001 = '2' THEN        #20150924--mark by dongsz
            IF g_prbg_d[l_ac].prbg001 = '2' THEN        #20150924--add by dongsz
               LET g_qryparam.arg1 = l_prbgsite
               CALL q_oodb002_8()                                #呼叫開窗
            END IF
            IF l_prbg001 = '1' THEN
               CALL q_oodb002_9()                                #呼叫開窗
            END IF

            LET g_prbg_d[l_ac].prbg008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_prbg_d[l_ac].prbg008_desc = g_qryparam.return2   

            DISPLAY g_prbg_d[l_ac].prbg008 TO prbg008              #顯示到畫面上
            DISPLAY g_prbg_d[l_ac].prbg008_desc TO prbg008_desc

            NEXT FIELD prbg008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg008_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg008_desc
            #add-point:ON ACTION controlp INFIELD prbg008_desc name="input.c.page1.prbg008_desc"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg016
            #add-point:ON ACTION controlp INFIELD prbg016 name="input.c.page1.prbg016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg017
            #add-point:ON ACTION controlp INFIELD prbg017 name="input.c.page1.prbg017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg019
            #add-point:ON ACTION controlp INFIELD prbg019 name="input.c.page1.prbg019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg020
            #add-point:ON ACTION controlp INFIELD prbg020 name="input.c.page1.prbg020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.prbg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbg013
            #add-point:ON ACTION controlp INFIELD prbg013 name="input.c.page1.prbg013"
                                                                                                                                    
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_prbg_d[l_ac].* = g_prbg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt111_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_prbg_d[l_ac].prbgseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_prbg_d[l_ac].* = g_prbg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               LET l_prbg007 = g_prbg_d[l_ac].prbg007    #150401-00003#1--add by dongsz
               LET l_prbg009 = g_prbg_d[l_ac].prbg009    #150401-00003#1--add by dongsz
               #20150923--mark by dongsz--s
#               IF g_prbg_d[l_ac].prbgseq1 = '1' THEN
#                  LET g_prbg_d[l_ac].prbg001 = g_prbg_d[l_ac-1].prbg001
#                  LET g_prbg_d[l_ac].prbgsite = g_prbg_d[l_ac-1].prbgsite
#                  LET g_prbg_d[l_ac].prbg002 = g_prbg_d[l_ac-1].prbg002
#                  LET g_prbg_d[l_ac].prbg003 = g_prbg_d[l_ac-1].prbg003
#                  #150401-00003#1--add by dongsz--str---
#                  IF cl_null(l_prbg007) THEN
#                     LET l_prbg007 = g_prbg_d[l_ac-1].prbg007
#                  END IF
#                  IF cl_null(l_prbg009) THEN
#                     LET l_prbg009 = g_prbg_d[l_ac-1].prbg009
#                  END IF
#                  #150401-00003#1--add by dongsz--end---
#               END IF
               #20150923--mark by dongsz--e
               #LET g_prbg_d[l_ac].prbg013 = (g_prbg_d[l_ac].prbg009-g_prbg_d[l_ac].prbg007)/g_prbg_d[l_ac].prbg009*100  #150401-00003#1--mark by dongsz
               IF cl_null(l_prbg007) THEN
                  LET l_prbg007 = g_prbg_d[l_ac].prbg021
               END IF
               IF cl_null(l_prbg009) THEN
                  LET l_prbg009 = g_prbg_d[l_ac].prbg023
               END IF
               LET g_prbg_d[l_ac].prbg013 = (l_prbg009-l_prbg007)/l_prbg009*100       #150401-00003#1--add by dongsz
               
               IF cl_null(g_prbg_d[l_ac].prbg002) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00379'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbg_d[l_ac].* = g_prbg_d_t.*
                  NEXT FIELD prbg002
               END IF               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aprt111_prbg_t_mask_restore('restore_mask_o')
      
               UPDATE prbg_t SET (prbgdocno,prbgunit,prbgseq,prbg001,prbgsite,prbg003,prbg002,prbg024, 
                   prbg021,prbg007,prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbgseq1, 
                   prbg004,prbg005,prbg006,prbg022,prbg014,prbg015,prbg018,prbg008,prbg016,prbg017,prbg019, 
                   prbg020,prbg013) = (g_prbf_m.prbfdocno,g_prbg_d[l_ac].prbgunit,g_prbg_d[l_ac].prbgseq, 
                   g_prbg_d[l_ac].prbg001,g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg002, 
                   g_prbg_d[l_ac].prbg024,g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg023, 
                   g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012, 
                   g_prbg_d[l_ac].prbg025,g_prbg_d[l_ac].prbg026,g_prbg_d[l_ac].prbgseq1,g_prbg_d[l_ac].prbg004, 
                   g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg014, 
                   g_prbg_d[l_ac].prbg015,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg016, 
                   g_prbg_d[l_ac].prbg017,g_prbg_d[l_ac].prbg019,g_prbg_d[l_ac].prbg020,g_prbg_d[l_ac].prbg013) 
 
                WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno 
 
                  AND prbgseq = g_prbg_d_t.prbgseq #項次   
                  AND prbgseq1 = g_prbg_d_t.prbgseq1  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                                                                                                                                                     
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prbg_d[l_ac].* = g_prbg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prbg_d[l_ac].* = g_prbg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys_bak[1] = g_prbfdocno_t
               LET gs_keys[2] = g_prbg_d[g_detail_idx].prbgseq
               LET gs_keys_bak[2] = g_prbg_d_t.prbgseq
               LET gs_keys[3] = g_prbg_d[g_detail_idx].prbgseq1
               LET gs_keys_bak[3] = g_prbg_d_t.prbgseq1
               CALL aprt111_update_b('prbg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aprt111_prbg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_prbg_d[g_detail_idx].prbgseq = g_prbg_d_t.prbgseq 
                  AND g_prbg_d[g_detail_idx].prbgseq1 = g_prbg_d_t.prbgseq1 
 
                  ) THEN
                  LET gs_keys[01] = g_prbf_m.prbfdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_prbg_d_t.prbgseq
                  LET gs_keys[gs_keys.getLength()+1] = g_prbg_d_t.prbgseq1
 
                  CALL aprt111_key_update_b(gs_keys,'prbg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg_d_t)
               LET g_log2 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               #20150924--mark by dongsz--s
#               IF g_prbg_d[l_ac].prbgseq1 = '1' THEN
#                  LET g_prbg_d[l_ac].prbg001 = ''
#                  LET g_prbg_d[l_ac].prbgsite = ''
#                  LET g_prbg_d[l_ac].prbg002 = ''
#                  LET g_prbg_d[l_ac].prbg003 = ''
#               END IF
               #20150924--mark by dongsz--e
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                                                                                                     
            #end add-point
            CALL aprt111_unlock_b("prbg_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            IF p_cmd = 'u' THEN              
               UPDATE prbf_t SET (prbfmodid,prbfmoddt) = (g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt)
                WHERE prbfent = g_enterprise AND prbfdocno = g_prbf_m.prbfdocno
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "prbf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_prbg_d[l_ac].* = g_prbg_d_t.*                     
                  CALL s_transaction_end('N','0')
               END IF
            END IF
            #CALL aprt111_ins_prbw()
            #CALL aprt111_b_fill()
            CALL aprt111_show()            #150401-00003#1--add by dongsz
         #ON ACTION insert                 #20150924 dongsz mark
         #   CALL aprt111_ins_prbg()       #20150924 dongsz mark
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prbg_d[li_reproduce_target].* = g_prbg_d[li_reproduce].*
 
               LET g_prbg_d[li_reproduce_target].prbgseq = NULL
               LET g_prbg_d[li_reproduce_target].prbgseq1 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_prbg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prbg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_prbg3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body3.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prbg3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt111_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prbg3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prbg3_d[l_ac].* TO NULL 
            INITIALIZE g_prbg3_d_t.* TO NULL 
            INITIALIZE g_prbg3_d_o.* TO NULL 
            #公用欄位給值(單身2)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbg3_d[l_ac].prbvstus = 'N'
 
 
 
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            
            #end add-point
            LET g_prbg3_d_t.* = g_prbg3_d[l_ac].*     #新輸入資料
            LET g_prbg3_d_o.* = g_prbg3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt111_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt111_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prbg3_d[li_reproduce_target].* = g_prbg3_d[li_reproduce].*
 
               LET g_prbg3_d[li_reproduce_target].prbv001 = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            LET g_prbg3_d[l_ac].prbvstus = 'Y'
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body3.before_row2"
            
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
            OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt111_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prbg3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prbg3_d[l_ac].prbv001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prbg3_d_t.* = g_prbg3_d[l_ac].*  #BACKUP
               LET g_prbg3_d_o.* = g_prbg3_d[l_ac].*  #BACKUP
               CALL aprt111_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL aprt111_set_no_entry_b(l_cmd)
               IF NOT aprt111_lock_b("prbv_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt111_bcl2 INTO g_prbg3_d[l_ac].prbvstus,g_prbg3_d[l_ac].prbv001
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prbg3_d_mask_o[l_ac].* =  g_prbg3_d[l_ac].*
                  CALL aprt111_prbv_t_mask()
                  LET g_prbg3_d_mask_n[l_ac].* =  g_prbg3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt111_show()
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
               
               #add-point:單身2刪除前 name="input.body3.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prbf_m.prbfdocno
               LET gs_keys[gs_keys.getLength()+1] = g_prbg3_d_t.prbv001
            
               #刪除同層單身
               IF NOT aprt111_delete_b('prbv_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt111_key_delete_b(gs_keys,'prbv_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body3.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt111_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body3.a_delete"
               
               #end add-point
               LET l_count = g_prbg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prbg3_d.getLength() + 1) THEN
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
               
            #add-point:單身2新增前 name="input.body3.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prbv_t 
             WHERE prbvent = g_enterprise AND prbvdocno = g_prbf_m.prbfdocno
               AND prbv001 = g_prbg3_d[l_ac].prbv001
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body3.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys[2] = g_prbg3_d[g_detail_idx].prbv001
               CALL aprt111_insert_b('prbv_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prbg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt111_b_fill()
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
               LET g_prbg3_d[l_ac].* = g_prbg3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt111_bcl2
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
               LET g_prbg3_d[l_ac].* = g_prbg3_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body3.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               #將遮罩欄位還原
               CALL aprt111_prbv_t_mask_restore('restore_mask_o')
                              
               UPDATE prbv_t SET (prbvdocno,prbvstus,prbv001) = (g_prbf_m.prbfdocno,g_prbg3_d[l_ac].prbvstus, 
                   g_prbg3_d[l_ac].prbv001) #自訂欄位頁簽
                WHERE prbvent = g_enterprise AND prbvdocno = g_prbf_m.prbfdocno
                  AND prbv001 = g_prbg3_d_t.prbv001 #項次 
                  
               #add-point:單身page2修改中 name="input.body3.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prbg3_d[l_ac].* = g_prbg3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbv_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prbg3_d[l_ac].* = g_prbg3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys_bak[1] = g_prbfdocno_t
               LET gs_keys[2] = g_prbg3_d[g_detail_idx].prbv001
               LET gs_keys_bak[2] = g_prbg3_d_t.prbv001
               CALL aprt111_update_b('prbv_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt111_prbv_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prbg3_d[g_detail_idx].prbv001 = g_prbg3_d_t.prbv001 
                  ) THEN
                  LET gs_keys[01] = g_prbf_m.prbfdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prbg3_d_t.prbv001
                  CALL aprt111_key_update_b(gs_keys,'prbv_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg3_d_t)
               LET g_log2 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body3.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbvstus
            #add-point:BEFORE FIELD prbvstus name="input.b.page3.prbvstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbvstus
            
            #add-point:AFTER FIELD prbvstus name="input.a.page3.prbvstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbvstus
            #add-point:ON CHANGE prbvstus name="input.g.page3.prbvstus"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbv001
            
            #add-point:AFTER FIELD prbv001 name="input.a.page3.prbv001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prbf_m.prbfdocno IS NOT NULL AND g_prbg3_d[g_detail_idx].prbv001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbf_m.prbfdocno != g_prbfdocno_t OR g_prbg3_d[g_detail_idx].prbv001 != g_prbg3_d_t.prbv001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbv_t WHERE "||"prbvent = '" ||g_enterprise|| "' AND "||"prbvdocno = '"||g_prbf_m.prbfdocno ||"' AND "|| "prbv001 = '"||g_prbg3_d[g_detail_idx].prbv001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF NOT cl_null(g_prbg3_d[g_detail_idx].prbv001) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_prbg3_d[g_detail_idx].prbv001
               LET g_chkparam.arg2 = '8'
               LET g_chkparam.arg3 = g_prbf_m.prbfsite
               
               IF cl_chk_exist("v_ooed004") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
			      
               ELSE
                  #檢查失敗時後續處理
                  LET g_prbg3_d[g_detail_idx].prbv001 = g_prbg3_d_t.prbv001
                  DISPLAY BY NAME g_prbg3_d[g_detail_idx].prbv001
                  NEXT FIELD CURRENT
               END IF
            END IF
            
            CALL s_desc_get_department_desc(g_prbg3_d[g_detail_idx].prbv001) RETURNING g_prbg3_d[g_detail_idx].prbv001_desc
            DISPLAY BY NAME g_prbg3_d[g_detail_idx].prbv001,g_prbg3_d[g_detail_idx].prbv001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbv001
            #add-point:BEFORE FIELD prbv001 name="input.b.page3.prbv001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbv001
            #add-point:ON CHANGE prbv001 name="input.g.page3.prbv001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.prbvstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbvstus
            #add-point:ON ACTION controlp INFIELD prbvstus name="input.c.page3.prbvstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.prbv001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbv001
            #add-point:ON ACTION controlp INFIELD prbv001 name="input.c.page3.prbv001"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_prbg3_d[l_ac].prbv001             #給予default值
            LET g_qryparam.default2 = g_prbg3_d[l_ac].prbv001_desc #g_prbg3_d[l_ac].ooed004 #組織編號
            #給予arg
            LET g_qryparam.arg1 = g_prbf_m.prbfsite #s
            LET g_qryparam.arg2 = "8" #s

            CALL q_ooed004_3()                                #呼叫開窗

            #LET g_prbg3_d[l_ac].prbv001 = g_qryparam.return1       
            LET l_prbv001_str = g_qryparam.return1      
            #插入单身资料
            LET l_prbv001_str = cl_replace_str(l_prbv001_str,"|","','")
            LET l_sql = " INSERT INTO prbv_t (prbvent,prbvunit,prbvsite,prbvdocno,prbv001,prbvstus) ",
                        " SELECT ",g_enterprise,",'",g_prbf_m.prbfunit,"','",g_prbf_m.prbfsite,"', ",
                        "        '",g_prbf_m.prbfdocno,"',ooef001,'Y' ",
                        "   FROM ooef_t ",
                        "  WHERE ooefent = ",g_enterprise," ",
                        "    AND ooef001 IN ('",l_prbv001_str CLIPPED,"') ",
                        "    AND ooef001 NOT IN (SELECT prbv001 FROM prbv_t WHERE prbvent = ",g_enterprise," ",
                        "                           AND prbvdocno = '",g_prbf_m.prbfdocno,"') "
            PREPARE ins_prbv_pre FROM l_sql
            EXECUTE ins_prbv_pre
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins prbv_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
            CALL s_transaction_end('Y','0')
            #CALL aprt111_ins_prbw()
            #CALL aprt111_b_fill()
            EXIT DIALOG
            #LET g_prbg3_d[l_ac].ooed004 = g_qryparam.return2 
            #DISPLAY g_prbg3_d[l_ac].prbv001 TO prbv001              #
            #DISPLAY g_prbg3_d[l_ac].ooed004 TO ooed004 #組織編號
            #NEXT FIELD prbv001                          #返回原欄位


            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prbg3_d[l_ac].* = g_prbg3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt111_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt111_unlock_b("prbv_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            #CALL aprt111_ins_prbw()
            #CALL aprt111_b_fill()
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prbg3_d[li_reproduce_target].* = g_prbg3_d[li_reproduce].*
 
               LET g_prbg3_d[li_reproduce_target].prbv001 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prbg3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prbg3_d.getLength()+1
            END IF
            
      END INPUT
      INPUT ARRAY g_prbg4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_3)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body4.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_prbg4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aprt111_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_prbg4_d.getLength()
            #add-point:資料輸入前 name="input.body4.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_prbg4_d[l_ac].* TO NULL 
            INITIALIZE g_prbg4_d_t.* TO NULL 
            INITIALIZE g_prbg4_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
            
            #add-point:modify段before備份 name="input.body4.insert.before_bak"
            
            #end add-point
            LET g_prbg4_d_t.* = g_prbg4_d[l_ac].*     #新輸入資料
            LET g_prbg4_d_o.* = g_prbg4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aprt111_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body4.insert.after_set_entry_b"
            
            #end add-point
            CALL aprt111_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_prbg4_d[li_reproduce_target].* = g_prbg4_d[li_reproduce].*
 
               LET g_prbg4_d[li_reproduce_target].prbwseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body4.before_insert"
            
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body4.before_row2"
            
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
            OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aprt111_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_prbg4_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_prbg4_d[l_ac].prbwseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_prbg4_d_t.* = g_prbg4_d[l_ac].*  #BACKUP
               LET g_prbg4_d_o.* = g_prbg4_d[l_ac].*  #BACKUP
               CALL aprt111_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body4.after_set_entry_b"
               
               #end add-point  
               CALL aprt111_set_no_entry_b(l_cmd)
               IF NOT aprt111_lock_b("prbw_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aprt111_bcl3 INTO g_prbg4_d[l_ac].prbwseq,g_prbg4_d[l_ac].prbwsite,g_prbg4_d[l_ac].prbw001, 
                      g_prbg4_d[l_ac].prbw002,g_prbg4_d[l_ac].prbw003,g_prbg4_d[l_ac].prbw004,g_prbg4_d[l_ac].prbw005, 
                      g_prbg4_d[l_ac].prbw006,g_prbg4_d[l_ac].prbw007,g_prbg4_d[l_ac].prbw008,g_prbg4_d[l_ac].prbw009, 
                      g_prbg4_d[l_ac].prbw010,g_prbg4_d[l_ac].prbw011,g_prbg4_d[l_ac].prbw012,g_prbg4_d[l_ac].prbw013, 
                      g_prbg4_d[l_ac].prbw014,g_prbg4_d[l_ac].prbw022,g_prbg4_d[l_ac].prbw015,g_prbg4_d[l_ac].prbw016, 
                      g_prbg4_d[l_ac].prbw020,g_prbg4_d[l_ac].prbw021,g_prbg4_d[l_ac].prbw017,g_prbg4_d[l_ac].prbw018 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_prbg4_d_mask_o[l_ac].* =  g_prbg4_d[l_ac].*
                  CALL aprt111_prbw_t_mask()
                  LET g_prbg4_d_mask_n[l_ac].* =  g_prbg4_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aprt111_show()
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
               
               #add-point:單身3刪除前 name="input.body4.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_prbf_m.prbfdocno
               LET gs_keys[gs_keys.getLength()+1] = g_prbg4_d_t.prbwseq
            
               #刪除同層單身
               IF NOT aprt111_delete_b('prbw_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aprt111_key_delete_b(gs_keys,'prbw_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aprt111_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body4.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aprt111_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body4.a_delete"
               
               #end add-point
               LET l_count = g_prbg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body4.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_prbg4_d.getLength() + 1) THEN
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
               
            #add-point:單身3新增前 name="input.body4.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM prbw_t 
             WHERE prbwent = g_enterprise AND prbwdocno = g_prbf_m.prbfdocno
               AND prbwseq = g_prbg4_d[l_ac].prbwseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body4.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys[2] = g_prbg4_d[g_detail_idx].prbwseq
               CALL aprt111_insert_b('prbw_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body4.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_prbg_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aprt111_b_fill()
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
               LET g_prbg4_d[l_ac].* = g_prbg4_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt111_bcl3
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
               LET g_prbg4_d[l_ac].* = g_prbg4_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body4.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL aprt111_prbw_t_mask_restore('restore_mask_o')
                              
               UPDATE prbw_t SET (prbwdocno,prbwseq,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005, 
                   prbw006,prbw007,prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015, 
                   prbw016,prbw020,prbw021,prbw017,prbw018) = (g_prbf_m.prbfdocno,g_prbg4_d[l_ac].prbwseq, 
                   g_prbg4_d[l_ac].prbwsite,g_prbg4_d[l_ac].prbw001,g_prbg4_d[l_ac].prbw002,g_prbg4_d[l_ac].prbw003, 
                   g_prbg4_d[l_ac].prbw004,g_prbg4_d[l_ac].prbw005,g_prbg4_d[l_ac].prbw006,g_prbg4_d[l_ac].prbw007, 
                   g_prbg4_d[l_ac].prbw008,g_prbg4_d[l_ac].prbw009,g_prbg4_d[l_ac].prbw010,g_prbg4_d[l_ac].prbw011, 
                   g_prbg4_d[l_ac].prbw012,g_prbg4_d[l_ac].prbw013,g_prbg4_d[l_ac].prbw014,g_prbg4_d[l_ac].prbw022, 
                   g_prbg4_d[l_ac].prbw015,g_prbg4_d[l_ac].prbw016,g_prbg4_d[l_ac].prbw020,g_prbg4_d[l_ac].prbw021, 
                   g_prbg4_d[l_ac].prbw017,g_prbg4_d[l_ac].prbw018) #自訂欄位頁簽
                WHERE prbwent = g_enterprise AND prbwdocno = g_prbf_m.prbfdocno
                  AND prbwseq = g_prbg4_d_t.prbwseq #項次 
                  
               #add-point:單身page3修改中 name="input.body4.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_prbg4_d[l_ac].* = g_prbg4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbw_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_prbg4_d[l_ac].* = g_prbg4_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_prbf_m.prbfdocno
               LET gs_keys_bak[1] = g_prbfdocno_t
               LET gs_keys[2] = g_prbg4_d[g_detail_idx].prbwseq
               LET gs_keys_bak[2] = g_prbg4_d_t.prbwseq
               CALL aprt111_update_b('prbw_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aprt111_prbw_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_prbg4_d[g_detail_idx].prbwseq = g_prbg4_d_t.prbwseq 
                  ) THEN
                  LET gs_keys[01] = g_prbf_m.prbfdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_prbg4_d_t.prbwseq
                  CALL aprt111_key_update_b(gs_keys,'prbw_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg4_d_t)
               LET g_log2 = util.JSON.stringify(g_prbf_m),util.JSON.stringify(g_prbg4_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body4.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbwseq
            #add-point:BEFORE FIELD prbwseq name="input.b.page4.prbwseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbwseq
            
            #add-point:AFTER FIELD prbwseq name="input.a.page4.prbwseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_prbf_m.prbfdocno IS NOT NULL AND g_prbg4_d[g_detail_idx].prbwseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_prbf_m.prbfdocno != g_prbfdocno_t OR g_prbg4_d[g_detail_idx].prbwseq != g_prbg4_d_t.prbwseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM prbw_t WHERE "||"prbwent = '" ||g_enterprise|| "' AND "||"prbwdocno = '"||g_prbf_m.prbfdocno ||"' AND "|| "prbwseq = '"||g_prbg4_d[g_detail_idx].prbwseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbwseq
            #add-point:ON CHANGE prbwseq name="input.g.page4.prbwseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbwsite
            #add-point:BEFORE FIELD prbwsite name="input.b.page4.prbwsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbwsite
            
            #add-point:AFTER FIELD prbwsite name="input.a.page4.prbwsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbwsite
            #add-point:ON CHANGE prbwsite name="input.g.page4.prbwsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw001
            #add-point:BEFORE FIELD prbw001 name="input.b.page4.prbw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw001
            
            #add-point:AFTER FIELD prbw001 name="input.a.page4.prbw001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw001
            #add-point:ON CHANGE prbw001 name="input.g.page4.prbw001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw002
            #add-point:BEFORE FIELD prbw002 name="input.b.page4.prbw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw002
            
            #add-point:AFTER FIELD prbw002 name="input.a.page4.prbw002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw002
            #add-point:ON CHANGE prbw002 name="input.g.page4.prbw002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw003
            #add-point:BEFORE FIELD prbw003 name="input.b.page4.prbw003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw003
            
            #add-point:AFTER FIELD prbw003 name="input.a.page4.prbw003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw003
            #add-point:ON CHANGE prbw003 name="input.g.page4.prbw003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw004
            #add-point:BEFORE FIELD prbw004 name="input.b.page4.prbw004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw004
            
            #add-point:AFTER FIELD prbw004 name="input.a.page4.prbw004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw004
            #add-point:ON CHANGE prbw004 name="input.g.page4.prbw004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw005
            #add-point:BEFORE FIELD prbw005 name="input.b.page4.prbw005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw005
            
            #add-point:AFTER FIELD prbw005 name="input.a.page4.prbw005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw005
            #add-point:ON CHANGE prbw005 name="input.g.page4.prbw005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw006
            #add-point:BEFORE FIELD prbw006 name="input.b.page4.prbw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw006
            
            #add-point:AFTER FIELD prbw006 name="input.a.page4.prbw006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw006
            #add-point:ON CHANGE prbw006 name="input.g.page4.prbw006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw007
            #add-point:BEFORE FIELD prbw007 name="input.b.page4.prbw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw007
            
            #add-point:AFTER FIELD prbw007 name="input.a.page4.prbw007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw007
            #add-point:ON CHANGE prbw007 name="input.g.page4.prbw007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw008
            #add-point:BEFORE FIELD prbw008 name="input.b.page4.prbw008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw008
            
            #add-point:AFTER FIELD prbw008 name="input.a.page4.prbw008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw008
            #add-point:ON CHANGE prbw008 name="input.g.page4.prbw008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw009
            #add-point:BEFORE FIELD prbw009 name="input.b.page4.prbw009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw009
            
            #add-point:AFTER FIELD prbw009 name="input.a.page4.prbw009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw009
            #add-point:ON CHANGE prbw009 name="input.g.page4.prbw009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw010
            #add-point:BEFORE FIELD prbw010 name="input.b.page4.prbw010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw010
            
            #add-point:AFTER FIELD prbw010 name="input.a.page4.prbw010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw010
            #add-point:ON CHANGE prbw010 name="input.g.page4.prbw010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw011
            #add-point:BEFORE FIELD prbw011 name="input.b.page4.prbw011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw011
            
            #add-point:AFTER FIELD prbw011 name="input.a.page4.prbw011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw011
            #add-point:ON CHANGE prbw011 name="input.g.page4.prbw011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw012
            #add-point:BEFORE FIELD prbw012 name="input.b.page4.prbw012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw012
            
            #add-point:AFTER FIELD prbw012 name="input.a.page4.prbw012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw012
            #add-point:ON CHANGE prbw012 name="input.g.page4.prbw012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw013
            #add-point:BEFORE FIELD prbw013 name="input.b.page4.prbw013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw013
            
            #add-point:AFTER FIELD prbw013 name="input.a.page4.prbw013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw013
            #add-point:ON CHANGE prbw013 name="input.g.page4.prbw013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw014
            #add-point:BEFORE FIELD prbw014 name="input.b.page4.prbw014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw014
            
            #add-point:AFTER FIELD prbw014 name="input.a.page4.prbw014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw014
            #add-point:ON CHANGE prbw014 name="input.g.page4.prbw014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw022
            #add-point:BEFORE FIELD prbw022 name="input.b.page4.prbw022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw022
            
            #add-point:AFTER FIELD prbw022 name="input.a.page4.prbw022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw022
            #add-point:ON CHANGE prbw022 name="input.g.page4.prbw022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw015
            #add-point:BEFORE FIELD prbw015 name="input.b.page4.prbw015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw015
            
            #add-point:AFTER FIELD prbw015 name="input.a.page4.prbw015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw015
            #add-point:ON CHANGE prbw015 name="input.g.page4.prbw015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw016
            #add-point:BEFORE FIELD prbw016 name="input.b.page4.prbw016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw016
            
            #add-point:AFTER FIELD prbw016 name="input.a.page4.prbw016"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw016
            #add-point:ON CHANGE prbw016 name="input.g.page4.prbw016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw020
            #add-point:BEFORE FIELD prbw020 name="input.b.page4.prbw020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw020
            
            #add-point:AFTER FIELD prbw020 name="input.a.page4.prbw020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw020
            #add-point:ON CHANGE prbw020 name="input.g.page4.prbw020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw021
            #add-point:BEFORE FIELD prbw021 name="input.b.page4.prbw021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw021
            
            #add-point:AFTER FIELD prbw021 name="input.a.page4.prbw021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw021
            #add-point:ON CHANGE prbw021 name="input.g.page4.prbw021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw017
            #add-point:BEFORE FIELD prbw017 name="input.b.page4.prbw017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw017
            
            #add-point:AFTER FIELD prbw017 name="input.a.page4.prbw017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw017
            #add-point:ON CHANGE prbw017 name="input.g.page4.prbw017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbw018
            #add-point:BEFORE FIELD prbw018 name="input.b.page4.prbw018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbw018
            
            #add-point:AFTER FIELD prbw018 name="input.a.page4.prbw018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbw018
            #add-point:ON CHANGE prbw018 name="input.g.page4.prbw018"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page4.prbwseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbwseq
            #add-point:ON ACTION controlp INFIELD prbwseq name="input.c.page4.prbwseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbwsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbwsite
            #add-point:ON ACTION controlp INFIELD prbwsite name="input.c.page4.prbwsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw001
            #add-point:ON ACTION controlp INFIELD prbw001 name="input.c.page4.prbw001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw002
            #add-point:ON ACTION controlp INFIELD prbw002 name="input.c.page4.prbw002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw003
            #add-point:ON ACTION controlp INFIELD prbw003 name="input.c.page4.prbw003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw004
            #add-point:ON ACTION controlp INFIELD prbw004 name="input.c.page4.prbw004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw005
            #add-point:ON ACTION controlp INFIELD prbw005 name="input.c.page4.prbw005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw006
            #add-point:ON ACTION controlp INFIELD prbw006 name="input.c.page4.prbw006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw007
            #add-point:ON ACTION controlp INFIELD prbw007 name="input.c.page4.prbw007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw008
            #add-point:ON ACTION controlp INFIELD prbw008 name="input.c.page4.prbw008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw009
            #add-point:ON ACTION controlp INFIELD prbw009 name="input.c.page4.prbw009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw010
            #add-point:ON ACTION controlp INFIELD prbw010 name="input.c.page4.prbw010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw011
            #add-point:ON ACTION controlp INFIELD prbw011 name="input.c.page4.prbw011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw012
            #add-point:ON ACTION controlp INFIELD prbw012 name="input.c.page4.prbw012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw013
            #add-point:ON ACTION controlp INFIELD prbw013 name="input.c.page4.prbw013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw014
            #add-point:ON ACTION controlp INFIELD prbw014 name="input.c.page4.prbw014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw022
            #add-point:ON ACTION controlp INFIELD prbw022 name="input.c.page4.prbw022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw015
            #add-point:ON ACTION controlp INFIELD prbw015 name="input.c.page4.prbw015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw016
            #add-point:ON ACTION controlp INFIELD prbw016 name="input.c.page4.prbw016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw020
            #add-point:ON ACTION controlp INFIELD prbw020 name="input.c.page4.prbw020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw021
            #add-point:ON ACTION controlp INFIELD prbw021 name="input.c.page4.prbw021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw017
            #add-point:ON ACTION controlp INFIELD prbw017 name="input.c.page4.prbw017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page4.prbw018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbw018
            #add-point:ON ACTION controlp INFIELD prbw018 name="input.c.page4.prbw018"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3 after_row name="input.body4.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_prbg4_d[l_ac].* = g_prbg4_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aprt111_bcl3
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aprt111_unlock_b("prbw_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3 after_row2 name="input.body4.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body4.after_input"
            
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_prbg4_d[li_reproduce_target].* = g_prbg4_d[li_reproduce].*
 
               LET g_prbg4_d[li_reproduce_target].prbwseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_prbg4_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_prbg4_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aprt111.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_prbk_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
       
         BEFORE ROW
                  
         BEFORE DISPLAY
                          
      END DISPLAY                                                    
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD prbfsite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbgunit
 
               #add-point:input段modify_detail 

               #end add-point  
            END CASE
         END IF                                                                                    
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue("'2',"))
         CALL DIALOG.setCurrentRow("s_detail4",g_idx_group.getValue("'3',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD prbfdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD prbgunit
               WHEN "s_detail3"
                  NEXT FIELD prbvstus
               WHEN "s_detail4"
                  NEXT FIELD prbwseq
 
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
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail3",1)
         CALL g_curr_diag.setCurrentRow("s_detail4",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   IF INT_FLAG THEN
      DELETE FROM prbg_t 
       WHERE prbgent = g_enterprise
         AND prbgdocno = g_prbf_m.prbfdocno
         AND prbg002 IS NULL
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "del prbg_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF    
   CALL aprt111_ins_prbw()
   CALL aprt111_b_fill()   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aprt111_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_ooef019 LIKE ooef_t.ooef019                              
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
                                 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aprt111_b_fill() #單身填充
      CALL aprt111_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aprt111_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
         
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfsite
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfsite_desc 
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbf004
#            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbf004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbf004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbf005
#            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbf005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbf005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbf010
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbf010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbf010_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbf011
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbf011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbf011_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfmodid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbf_m.prbfcnfid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_prbf_m.prbfcnfid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbf_m.prbfcnfid_desc

   #end add-point
   
   #遮罩相關處理
   LET g_prbf_m_mask_o.* =  g_prbf_m.*
   CALL aprt111_prbf_t_mask()
   LET g_prbf_m_mask_n.* =  g_prbf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002, 
       g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf004_desc,g_prbf_m.prbf005,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbf013_desc,g_prbf_m.prbfunit,g_prbf_m.prbf010, 
       g_prbf_m.prbf010_desc,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011, 
       g_prbf_m.prbf011_desc,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdp_desc, 
       g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid, 
       g_prbf_m.prbfcnfid_desc,g_prbf_m.prbfcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbf_m.prbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/ended.png")
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
   FOR l_ac = 1 TO g_prbg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
            
            IF g_prbg_d[l_ac].prbg001 = '1' THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
               CALL ap_ref_array2(g_ref_fields,"SELECT rtaal003 FROM rtaal_t WHERE rtaalent='"||g_enterprise||"' AND rtaal001=? AND rtaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc 
            END IF
            IF g_prbg_d[l_ac].prbg001 = '2' THEN             
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_prbg_d[l_ac].prbgsite
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_prbg_d[l_ac].prbgsite_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_prbg_d[l_ac].prbgsite_desc
            END IF

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg002
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbg_d[l_ac].prbg002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbg_d[l_ac].prbg002_desc
#            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg002
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbg_d[l_ac].prbg002_desc1 = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbg_d[l_ac].prbg002_desc1
            
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg002
#            CALL ap_ref_array2(g_ref_fields,"SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? ","") RETURNING g_rtn_fields
#            LET g_prbg_d[l_ac].prbg002_desc2 = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbg_d[l_ac].prbg002_desc2
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg002_desc_desc_desc
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].rtaxl003 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].rtaxl003
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prbf_m.prbfsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbg_d[l_ac].prbg006
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg006_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prbg_d[l_ac].prbg008
            CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg008_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg018
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbg_d[l_ac].prbg018_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbg_d[l_ac].prbg018_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_prbg_d[l_ac].prbg005
#            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_prbg_d[l_ac].prbg005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_prbg_d[l_ac].prbg005_desc

      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_prbg3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_prbg4_d.getLength()
      #add-point:show段單身reference name="show.body4.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
                                 
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aprt111_detail_show()
 
   #add-point:show段之後 name="show.after"
                                 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aprt111_detail_show()
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
 
{<section id="aprt111.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aprt111_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE prbf_t.prbfdocno 
   DEFINE l_oldno     LIKE prbf_t.prbfdocno 
 
   DEFINE l_master    RECORD LIKE prbf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE prbg_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prbv_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prbw_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_doctype     LIKE rtai_t.rtai004                       
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
   
   IF g_prbf_m.prbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
    
   LET g_prbf_m.prbfdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_prbf_m.prbfownid = g_user
      LET g_prbf_m.prbfowndp = g_dept
      LET g_prbf_m.prbfcrtid = g_user
      LET g_prbf_m.prbfcrtdp = g_dept 
      LET g_prbf_m.prbfcrtdt = cl_get_current()
      LET g_prbf_m.prbfmodid = g_user
      LET g_prbf_m.prbfmoddt = cl_get_current()
      LET g_prbf_m.prbfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_prbf_m.prbfstus = 'N'

   LET g_prbf_m.prbfsite = g_site
   LET g_prbf_m.prbfunit = g_site            
   LET g_prbf_m.prbfdocdt = g_today
   LET g_prbf_m.prbf006 = g_today     
   IF g_prbf001 = '3' THEN
      LET g_prbf_m.prbf002 = '1'
      LET g_prbf_m.prbf003 = ''
      #LET g_prbf_m.prbf007 = g_today     #150401-00003#1--mark by dongsz
      #LET g_prbf_m.prbf008 = '00:00:00'  #150401-00003#1--mark by dongsz
      #LET g_prbf_m.prbf009 = '23:59:59'  #150401-00003#1--mark by dongsz
   END IF
   LET g_prbf_m.prbf010 = g_user
   LET g_prbf_m.prbf011 = g_dept
   
   #dongsz--add--str---
   #預設單據的單別
   LET r_success = ''
   LET r_doctype = ''
   CALL s_arti200_get_def_doc_type(g_prbf_m.prbfsite,g_prog,'1')
        RETURNING r_success,r_doctype
   LET g_prbf_m.prbfdocno = r_doctype
   #dongsz--add--end---
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbf_m.prbf010
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbf_m.prbf010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbf_m.prbf010_desc
         
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbf_m.prbf011
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbf_m.prbf011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbf_m.prbf011_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbf_m.prbfsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbf_m.prbfsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbf_m.prbfsite_desc 
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_prbf_m.prbfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/ended.png")
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
   
   
   CALL aprt111_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_prbf_m.* TO NULL
      INITIALIZE g_prbg_d TO NULL
      INITIALIZE g_prbg3_d TO NULL
      INITIALIZE g_prbg4_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aprt111_show()
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
   CALL aprt111_set_act_visible()   
   CALL aprt111_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " prbfent = " ||g_enterprise|| " AND",
                      " prbfdocno = '", g_prbf_m.prbfdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aprt111_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
                                 
   #end add-point
   
   CALL aprt111_idx_chk()
   
   LET g_data_owner = g_prbf_m.prbfownid      
   LET g_data_dept  = g_prbf_m.prbfowndp
   
   #功能已完成,通報訊息中心
   CALL aprt111_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aprt111_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE prbg_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE prbv_t.* #此變數樣板目前無使用
 
   DEFINE l_detail3    RECORD LIKE prbw_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
                                 
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aprt111_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
                                 
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prbg_t
    WHERE prbgent = g_enterprise AND prbgdocno = g_prbfdocno_t
 
    INTO TEMP aprt111_detail
 
   #將key修正為調整後   
   UPDATE aprt111_detail 
      #更新key欄位
      SET prbgdocno = g_prbf_m.prbfdocno
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
      #, prbvstus = "Y" 
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO prbg_t SELECT * FROM aprt111_detail
   
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
   DROP TABLE aprt111_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
                                 
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prbv_t 
    WHERE prbvent = g_enterprise AND prbvdocno = g_prbfdocno_t
 
    INTO TEMP aprt111_detail
 
   #將key修正為調整後   
   UPDATE aprt111_detail SET prbvdocno = g_prbf_m.prbfdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prbv_t SELECT * FROM aprt111_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt111_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table3.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM prbw_t 
    WHERE prbwent = g_enterprise AND prbwdocno = g_prbfdocno_t
 
    INTO TEMP aprt111_detail
 
   #將key修正為調整後   
   UPDATE aprt111_detail SET prbwdocno = g_prbf_m.prbfdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table3.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO prbw_t SELECT * FROM aprt111_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table3.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aprt111_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table3.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aprt111_delete()
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
   
   IF g_prbf_m.prbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt111_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aprt111_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_prbf_m_mask_o.* =  g_prbf_m.*
   CALL aprt111_prbf_t_mask()
   LET g_prbf_m_mask_n.* =  g_prbf_m.*
   
   CALL aprt111_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
                                                                  
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aprt111_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_prbfdocno_t = g_prbf_m.prbfdocno
 
 
      DELETE FROM prbf_t
       WHERE prbfent = g_enterprise AND prbfdocno = g_prbf_m.prbfdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
                                                                  
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_prbf_m.prbfdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #150401-00003#1--add by dongsz--str---
      IF NOT s_aooi200_del_docno(g_prbf_m.prbfdocno,g_prbf_m.prbfdocdt) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF                      
      #150401-00003#1--add by dongsz--end---      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
                                                                  
      #end add-point
      
      DELETE FROM prbg_t
       WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                                                                  
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      IF g_prbf_m.prbf001 = '3' AND g_prbf_m.prbf002 = '2' AND NOT cl_null(g_prbf_m.prbf003) THEN
         UPDATE prbd_t SET prbd010 = ''
          WHERE prbdent = g_enterprise
            AND prbddocno = g_prbf_m.prbf003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "prbd_t"
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            CALL s_transaction_end('N','0')
            RETURN
         END IF  
      END IF          
         
      CALL g_prbk_d.clear()   #150903-00008#12 dongsz add       
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM prbv_t
       WHERE prbvent = g_enterprise AND
             prbvdocno = g_prbf_m.prbfdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
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
      DELETE FROM prbw_t
       WHERE prbwent = g_enterprise AND
             prbwdocno = g_prbf_m.prbfdocno
      #add-point:單身刪除中 name="delete.body.m_delete3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete3"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_prbf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aprt111_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_prbg_d.clear() 
      CALL g_prbg3_d.clear()       
      CALL g_prbg4_d.clear()       
 
     
      CALL aprt111_ui_browser_refresh()  
      #CALL aprt111_ui_headershow()  
      #CALL aprt111_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aprt111_browser_fill("")
         CALL aprt111_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aprt111_cl
 
   #功能已完成,通報訊息中心
   CALL aprt111_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aprt111.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprt111_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_prbg004  LIKE prbg_t.prbg004
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_prbg_d.clear()
   CALL g_prbg3_d.clear()
   CALL g_prbg4_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_prbg_d_colour.clear()     
   #end add-point
   
   #判斷是否填充
   IF aprt111_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prbgunit,prbgseq,prbg001,prbgsite,prbg003,prbg002,prbg024,prbg021, 
             prbg007,prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbgseq1,prbg004,prbg005, 
             prbg006,prbg022,prbg014,prbg015,prbg018,prbg008,prbg016,prbg017,prbg019,prbg020,prbg013 , 
             t1.ooefl003 ,t2.imaal003 ,t3.imaal004 ,t4.imaa009 ,t5.oocal003 ,t6.oocal003 FROM prbg_t", 
                
                     " INNER JOIN prbf_t ON prbfent = " ||g_enterprise|| " AND prbfdocno = prbgdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=prbgsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=prbg002 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=prbg002 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaa_t t4 ON t4.imaaent="||g_enterprise||" AND t4.imaa001=prbg002  ",
               " LEFT JOIN oocal_t t5 ON t5.oocalent="||g_enterprise||" AND t5.oocal001=prbg005 AND t5.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=prbg018 AND t6.oocal002='"||g_dlang||"' ",
 
                     " WHERE prbgent=? AND prbgdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
      LET g_sql = g_sql," AND prbf001 = '",g_prbf001,"' "                                                            
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prbg_t.prbgseq,prbg_t.prbgseq1"
         
         #add-point:單身填充控制 name="b_fill.sql"
                                                                  
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt111_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aprt111_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_prbf_m.prbfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_prbf_m.prbfdocno INTO g_prbg_d[l_ac].prbgunit,g_prbg_d[l_ac].prbgseq, 
          g_prbg_d[l_ac].prbg001,g_prbg_d[l_ac].prbgsite,g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg002, 
          g_prbg_d[l_ac].prbg024,g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg023, 
          g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012, 
          g_prbg_d[l_ac].prbg025,g_prbg_d[l_ac].prbg026,g_prbg_d[l_ac].prbgseq1,g_prbg_d[l_ac].prbg004, 
          g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg014, 
          g_prbg_d[l_ac].prbg015,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg016, 
          g_prbg_d[l_ac].prbg017,g_prbg_d[l_ac].prbg019,g_prbg_d[l_ac].prbg020,g_prbg_d[l_ac].prbg013, 
          g_prbg_d[l_ac].prbgsite_desc,g_prbg_d[l_ac].prbg002_desc,g_prbg_d[l_ac].prbg002_desc_desc, 
          g_prbg_d[l_ac].prbg002_desc_desc_desc,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg018_desc  
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
         #20150923--mark by dongsz--s
#         IF g_prbg_d[l_ac].prbgseq1 = '1' THEN
#            LET g_prbg_d[l_ac].prbg001 = ''
#            LET g_prbg_d[l_ac].prbgsite = ''
#            LET g_prbg_d[l_ac].prbgsite_desc = ''
#            LET g_prbg_d[l_ac].prbg002 = ''
#            LET g_prbg_d[l_ac].prbg002_desc = ''
#            LET g_prbg_d[l_ac].prbg002_desc_desc = ''
#            LET g_prbg_d[l_ac].prbg002_desc_desc_desc = ''           
#            LET g_prbg_d[l_ac].prbg003 = ''
#         END IF
#         IF g_prbg_d[l_ac].prbgseq1 = '1' THEN
#            LET g_prbg_d_colour[l_ac].prbgunit = "red"
#            LET g_prbg_d_colour[l_ac].prbgseq = "red"
#            LET g_prbg_d_colour[l_ac].prbg001 = "red"
#            LET g_prbg_d_colour[l_ac].prbgsite = "red"
#            LET g_prbg_d_colour[l_ac].prbgsite_desc = "red"
#            LET g_prbg_d_colour[l_ac].prbg002 = "red"
#            LET g_prbg_d_colour[l_ac].prbg003 = "red"
#            LET g_prbg_d_colour[l_ac].prbg002_desc = "red"
#            LET g_prbg_d_colour[l_ac].prbg002_desc_desc = "red"
#            LET g_prbg_d_colour[l_ac].prbg002_desc_desc_desc = "red"
#            LET g_prbg_d_colour[l_ac].rtaxl003 = "red"
#            LET g_prbg_d_colour[l_ac].prbgseq1 = "red"
#            LET g_prbg_d_colour[l_ac].prbg004 = "red"
#            LET g_prbg_d_colour[l_ac].prbg005 = "red"
#            LET g_prbg_d_colour[l_ac].prbg005_desc = "red"
#            LET g_prbg_d_colour[l_ac].prbg006 = "red"
#            LET g_prbg_d_colour[l_ac].prbg006_desc = "red"
#            LET g_prbg_d_colour[l_ac].prbg007 = "red"
#            LET g_prbg_d_colour[l_ac].prbg014 = "red"
#            LET g_prbg_d_colour[l_ac].prbg015 = "red"
#            LET g_prbg_d_colour[l_ac].prbg018 = "red"        #150429-00002#1--add by dongsz
#            LET g_prbg_d_colour[l_ac].prbg018_desc = "red"   #150429-00002#1--add by dongsz
#            LET g_prbg_d_colour[l_ac].prbg008 = "red"
#            LET g_prbg_d_colour[l_ac].prbg008_desc = "red"            
#            LET g_prbg_d_colour[l_ac].prbg009 = "red"
#            LET g_prbg_d_colour[l_ac].prbg016 = "red"
#            LET g_prbg_d_colour[l_ac].prbg017 = "red"
#            LET g_prbg_d_colour[l_ac].prbg010 = "red"
#            LET g_prbg_d_colour[l_ac].prbg011 = "red"
#            LET g_prbg_d_colour[l_ac].prbg012 = "red"
#            LET g_prbg_d_colour[l_ac].prbg013 = "red" 
#         END IF           
         #20150923--mark by dongsz--e
         #add by yangxf ---start----
         IF g_prbg_d[l_ac].prbg001 = '2' THEN
            #20150923--mark by dongsz--s
#            #抓取最新進價         
#            SELECT rtdx034 INTO g_prbg_d[l_ac].rtdx034
#              FROM rtdx_t
#             WHERE rtdxent = g_enterprise
#               AND rtdxsite = g_prbg_d[l_ac].prbgsite
#               AND rtdx001 = g_prbg_d[l_ac].prbg002
            #20150923--mark by dongsz--s
            LET l_prbg004 = g_prbg_d[l_ac].prbg004
            IF cl_null(l_prbg004) THEN 
               LET l_prbg004 = ' '
            END IF 
            #抓取有效庫存數量
            SELECT SUM(inag009) INTO g_prbg_d[l_ac].inag009
              FROM inag_t
             WHERE inagent = g_enterprise
               AND inagsite = g_prbg_d[l_ac].prbgsite
               AND inag001 = g_prbg_d[l_ac].prbg002
               AND inag002 = l_prbg004
               AND inag010 = 'Y'
            IF cl_null(g_prbg_d[l_ac].inag009) THEN 
               LET g_prbg_d[l_ac].inag009 = 0
            END IF 
         END IF 
         #add by yangxf ----end-----
         
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
   IF aprt111_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prbvstus,prbv001 ,t7.ooefl003 FROM prbv_t",   
                     " INNER JOIN  prbf_t ON prbfent = " ||g_enterprise|| " AND prbfdocno = prbvdocno ",
 
                     "",
                     
                                    " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=prbv001 AND t7.ooefl002='"||g_dlang||"' ",
 
                     " WHERE prbvent=? AND prbvdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prbv_t.prbv001"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt111_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aprt111_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_prbf_m.prbfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_prbf_m.prbfdocno INTO g_prbg3_d[l_ac].prbvstus,g_prbg3_d[l_ac].prbv001, 
          g_prbg3_d[l_ac].prbv001_desc   #(ver:78)
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
   IF aprt111_fill_chk(3) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body3.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT prbwseq,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005,prbw006, 
             prbw007,prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015,prbw016, 
             prbw020,prbw021,prbw017,prbw018  FROM prbw_t",   
                     " INNER JOIN  prbf_t ON prbfent = " ||g_enterprise|| " AND prbfdocno = prbwdocno ",
 
                     "",
                     
                     
                     " WHERE prbwent=? AND prbwdocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body3.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table3) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY prbw_t.prbwseq"
         
         #add-point:單身填充控制 name="b_fill.sql3"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aprt111_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aprt111_pb3
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs3 USING g_enterprise,g_prbf_m.prbfdocno   #(ver:78)
                                               
      FOREACH b_fill_cs3 USING g_enterprise,g_prbf_m.prbfdocno INTO g_prbg4_d[l_ac].prbwseq,g_prbg4_d[l_ac].prbwsite, 
          g_prbg4_d[l_ac].prbw001,g_prbg4_d[l_ac].prbw002,g_prbg4_d[l_ac].prbw003,g_prbg4_d[l_ac].prbw004, 
          g_prbg4_d[l_ac].prbw005,g_prbg4_d[l_ac].prbw006,g_prbg4_d[l_ac].prbw007,g_prbg4_d[l_ac].prbw008, 
          g_prbg4_d[l_ac].prbw009,g_prbg4_d[l_ac].prbw010,g_prbg4_d[l_ac].prbw011,g_prbg4_d[l_ac].prbw012, 
          g_prbg4_d[l_ac].prbw013,g_prbg4_d[l_ac].prbw014,g_prbg4_d[l_ac].prbw022,g_prbg4_d[l_ac].prbw015, 
          g_prbg4_d[l_ac].prbw016,g_prbg4_d[l_ac].prbw020,g_prbg4_d[l_ac].prbw021,g_prbg4_d[l_ac].prbw017, 
          g_prbg4_d[l_ac].prbw018   #(ver:78)
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
   
   CALL g_prbg_d.deleteElement(g_prbg_d.getLength())
   CALL g_prbg3_d.deleteElement(g_prbg3_d.getLength())
   CALL g_prbg4_d.deleteElement(g_prbg4_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aprt111_pb
   FREE aprt111_pb2
 
   FREE aprt111_pb3
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_prbg_d.getLength()
      LET g_prbg_d_mask_o[l_ac].* =  g_prbg_d[l_ac].*
      CALL aprt111_prbg_t_mask()
      LET g_prbg_d_mask_n[l_ac].* =  g_prbg_d[l_ac].*
   END FOR
   
   LET g_prbg3_d_mask_o.* =  g_prbg3_d.*
   FOR l_ac = 1 TO g_prbg3_d.getLength()
      LET g_prbg3_d_mask_o[l_ac].* =  g_prbg3_d[l_ac].*
      CALL aprt111_prbv_t_mask()
      LET g_prbg3_d_mask_n[l_ac].* =  g_prbg3_d[l_ac].*
   END FOR
   LET g_prbg4_d_mask_o.* =  g_prbg4_d.*
   FOR l_ac = 1 TO g_prbg4_d.getLength()
      LET g_prbg4_d_mask_o[l_ac].* =  g_prbg4_d[l_ac].*
      CALL aprt111_prbw_t_mask()
      LET g_prbg4_d_mask_n[l_ac].* =  g_prbg4_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aprt111_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM prbg_t
       WHERE prbgent = g_enterprise AND
         prbgdocno = ps_keys_bak[1] AND prbgseq = ps_keys_bak[2] AND prbgseq1 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      #20150924--mark by dongsz--s
#      DELETE FROM prbg_t
#       WHERE prbgent = g_enterprise AND
#         prbgdocno = ps_keys_bak[1] AND prbgseq = ps_keys_bak[2]
      #20150924--mark by dongsz--e         
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
         CALL g_prbg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM prbv_t
       WHERE prbvent = g_enterprise AND
             prbvdocno = ps_keys_bak[1] AND prbv001 = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prbg3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete3"
      
      #end add-point    
      DELETE FROM prbw_t
       WHERE prbwent = g_enterprise AND
             prbwdocno = ps_keys_bak[1] AND prbwseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete3"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prbg4_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete3"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   #CALL aprt111_b_fill()       #20150924 dongsz mark                            
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aprt111_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO prbg_t
                  (prbgent,
                   prbgdocno,
                   prbgseq,prbgseq1
                   ,prbgunit,prbg001,prbgsite,prbg003,prbg002,prbg024,prbg021,prbg007,prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbg004,prbg005,prbg006,prbg022,prbg014,prbg015,prbg018,prbg008,prbg016,prbg017,prbg019,prbg020,prbg013) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_prbg_d[g_detail_idx].prbgunit,g_prbg_d[g_detail_idx].prbg001,g_prbg_d[g_detail_idx].prbgsite, 
                       g_prbg_d[g_detail_idx].prbg003,g_prbg_d[g_detail_idx].prbg002,g_prbg_d[g_detail_idx].prbg024, 
                       g_prbg_d[g_detail_idx].prbg021,g_prbg_d[g_detail_idx].prbg007,g_prbg_d[g_detail_idx].prbg023, 
                       g_prbg_d[g_detail_idx].prbg009,g_prbg_d[g_detail_idx].prbg010,g_prbg_d[g_detail_idx].prbg011, 
                       g_prbg_d[g_detail_idx].prbg012,g_prbg_d[g_detail_idx].prbg025,g_prbg_d[g_detail_idx].prbg026, 
                       g_prbg_d[g_detail_idx].prbg004,g_prbg_d[g_detail_idx].prbg005,g_prbg_d[g_detail_idx].prbg006, 
                       g_prbg_d[g_detail_idx].prbg022,g_prbg_d[g_detail_idx].prbg014,g_prbg_d[g_detail_idx].prbg015, 
                       g_prbg_d[g_detail_idx].prbg018,g_prbg_d[g_detail_idx].prbg008,g_prbg_d[g_detail_idx].prbg016, 
                       g_prbg_d[g_detail_idx].prbg017,g_prbg_d[g_detail_idx].prbg019,g_prbg_d[g_detail_idx].prbg020, 
                       g_prbg_d[g_detail_idx].prbg013)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                                                                  
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_prbg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                                                                  
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO prbv_t
                  (prbvent,
                   prbvdocno,
                   prbv001
                   ,prbvstus) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prbg3_d[g_detail_idx].prbvstus)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_prbg3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert3"
      
      #end add-point 
      INSERT INTO prbw_t
                  (prbwent,
                   prbwdocno,
                   prbwseq
                   ,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005,prbw006,prbw007,prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015,prbw016,prbw020,prbw021,prbw017,prbw018) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_prbg4_d[g_detail_idx].prbwsite,g_prbg4_d[g_detail_idx].prbw001,g_prbg4_d[g_detail_idx].prbw002, 
                       g_prbg4_d[g_detail_idx].prbw003,g_prbg4_d[g_detail_idx].prbw004,g_prbg4_d[g_detail_idx].prbw005, 
                       g_prbg4_d[g_detail_idx].prbw006,g_prbg4_d[g_detail_idx].prbw007,g_prbg4_d[g_detail_idx].prbw008, 
                       g_prbg4_d[g_detail_idx].prbw009,g_prbg4_d[g_detail_idx].prbw010,g_prbg4_d[g_detail_idx].prbw011, 
                       g_prbg4_d[g_detail_idx].prbw012,g_prbg4_d[g_detail_idx].prbw013,g_prbg4_d[g_detail_idx].prbw014, 
                       g_prbg4_d[g_detail_idx].prbw022,g_prbg4_d[g_detail_idx].prbw015,g_prbg4_d[g_detail_idx].prbw016, 
                       g_prbg4_d[g_detail_idx].prbw020,g_prbg4_d[g_detail_idx].prbw021,g_prbg4_d[g_detail_idx].prbw017, 
                       g_prbg4_d[g_detail_idx].prbw018)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert3"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'3'" THEN 
         CALL g_prbg4_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert3"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
                                 
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aprt111_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prbg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                                                                  
      #end add-point 
      
      #將遮罩欄位還原
      CALL aprt111_prbg_t_mask_restore('restore_mask_o')
               
      UPDATE prbg_t 
         SET (prbgdocno,
              prbgseq,prbgseq1
              ,prbgunit,prbg001,prbgsite,prbg003,prbg002,prbg024,prbg021,prbg007,prbg023,prbg009,prbg010,prbg011,prbg012,prbg025,prbg026,prbg004,prbg005,prbg006,prbg022,prbg014,prbg015,prbg018,prbg008,prbg016,prbg017,prbg019,prbg020,prbg013) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_prbg_d[g_detail_idx].prbgunit,g_prbg_d[g_detail_idx].prbg001,g_prbg_d[g_detail_idx].prbgsite, 
                  g_prbg_d[g_detail_idx].prbg003,g_prbg_d[g_detail_idx].prbg002,g_prbg_d[g_detail_idx].prbg024, 
                  g_prbg_d[g_detail_idx].prbg021,g_prbg_d[g_detail_idx].prbg007,g_prbg_d[g_detail_idx].prbg023, 
                  g_prbg_d[g_detail_idx].prbg009,g_prbg_d[g_detail_idx].prbg010,g_prbg_d[g_detail_idx].prbg011, 
                  g_prbg_d[g_detail_idx].prbg012,g_prbg_d[g_detail_idx].prbg025,g_prbg_d[g_detail_idx].prbg026, 
                  g_prbg_d[g_detail_idx].prbg004,g_prbg_d[g_detail_idx].prbg005,g_prbg_d[g_detail_idx].prbg006, 
                  g_prbg_d[g_detail_idx].prbg022,g_prbg_d[g_detail_idx].prbg014,g_prbg_d[g_detail_idx].prbg015, 
                  g_prbg_d[g_detail_idx].prbg018,g_prbg_d[g_detail_idx].prbg008,g_prbg_d[g_detail_idx].prbg016, 
                  g_prbg_d[g_detail_idx].prbg017,g_prbg_d[g_detail_idx].prbg019,g_prbg_d[g_detail_idx].prbg020, 
                  g_prbg_d[g_detail_idx].prbg013) 
         WHERE prbgent = g_enterprise AND prbgdocno = ps_keys_bak[1] AND prbgseq = ps_keys_bak[2] AND prbgseq1 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
                                                                  
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt111_prbg_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                                                                  
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prbv_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt111_prbv_t_mask_restore('restore_mask_o')
               
      UPDATE prbv_t 
         SET (prbvdocno,
              prbv001
              ,prbvstus) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prbg3_d[g_detail_idx].prbvstus) 
         WHERE prbvent = g_enterprise AND prbvdocno = ps_keys_bak[1] AND prbv001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbv_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbv_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt111_prbv_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "prbw_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update3"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aprt111_prbw_t_mask_restore('restore_mask_o')
               
      UPDATE prbw_t 
         SET (prbwdocno,
              prbwseq
              ,prbwsite,prbw001,prbw002,prbw003,prbw004,prbw005,prbw006,prbw007,prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014,prbw022,prbw015,prbw016,prbw020,prbw021,prbw017,prbw018) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_prbg4_d[g_detail_idx].prbwsite,g_prbg4_d[g_detail_idx].prbw001,g_prbg4_d[g_detail_idx].prbw002, 
                  g_prbg4_d[g_detail_idx].prbw003,g_prbg4_d[g_detail_idx].prbw004,g_prbg4_d[g_detail_idx].prbw005, 
                  g_prbg4_d[g_detail_idx].prbw006,g_prbg4_d[g_detail_idx].prbw007,g_prbg4_d[g_detail_idx].prbw008, 
                  g_prbg4_d[g_detail_idx].prbw009,g_prbg4_d[g_detail_idx].prbw010,g_prbg4_d[g_detail_idx].prbw011, 
                  g_prbg4_d[g_detail_idx].prbw012,g_prbg4_d[g_detail_idx].prbw013,g_prbg4_d[g_detail_idx].prbw014, 
                  g_prbg4_d[g_detail_idx].prbw022,g_prbg4_d[g_detail_idx].prbw015,g_prbg4_d[g_detail_idx].prbw016, 
                  g_prbg4_d[g_detail_idx].prbw020,g_prbg4_d[g_detail_idx].prbw021,g_prbg4_d[g_detail_idx].prbw017, 
                  g_prbg4_d[g_detail_idx].prbw018) 
         WHERE prbwent = g_enterprise AND prbwdocno = ps_keys_bak[1] AND prbwseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update3"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbw_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "prbw_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aprt111_prbw_t_mask_restore('restore_mask_n')
 
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
 
{<section id="aprt111.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aprt111_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt111.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aprt111_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aprt111.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aprt111_lock_b(ps_table,ps_page)
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
   #CALL aprt111_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "prbg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aprt111_bcl USING g_enterprise,
                                       g_prbf_m.prbfdocno,g_prbg_d[g_detail_idx].prbgseq,g_prbg_d[g_detail_idx].prbgseq1  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt111_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "prbv_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt111_bcl2 USING g_enterprise,
                                             g_prbf_m.prbfdocno,g_prbg3_d[g_detail_idx].prbv001
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt111_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "prbw_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aprt111_bcl3 USING g_enterprise,
                                             g_prbf_m.prbfdocno,g_prbg4_d[g_detail_idx].prbwseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aprt111_bcl3:",SQLERRMESSAGE 
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
 
{<section id="aprt111.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aprt111_unlock_b(ps_table,ps_page)
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
      CLOSE aprt111_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt111_bcl2
   END IF
 
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aprt111_bcl3
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
                                 
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aprt111_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
                                 
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("prbfdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("prbfdocno",TRUE)
      CALL cl_set_comp_entry("prbfdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("prbfsite",TRUE)                                                             
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("prbf004,prbf005,prbf011",TRUE)  
   #单据类型为1或3，则供应商必输
   CALL cl_set_comp_required("prbf004",FALSE)    #150401-00003#1--add by dongsz 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aprt111_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_n     LIKE type_t.num5                          
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("prbfdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      LET l_n = 0
      SELECT COUNT(*) INTO l_n FROM prbg_t
       WHERE prbgent = g_enterprise
         AND prbgdocno = g_prbf_m.prbfdocno
      IF l_n > 0 THEN
         CALL cl_set_comp_entry("prbf004,prbf005,prbf011",FALSE)
      END IF         
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("prbfdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("prbfdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF NOT s_aooi500_comp_entry(g_prog,'prbfsite') OR g_site_flag THEN
      CALL cl_set_comp_entry("prbfsite",FALSE)
   END IF                
   #单据类型为1，则供应商必输
   #150401-00003#1--add by dongsz--str---
   #IF g_prbf001 = '1' OR g_prbf001 = '3' THEN     #150603-00026#14--mark by dongsz
   #IF g_prbf001 = '1' THEN      #150603-00026#14--add by dongsz
   IF g_prbf001 = '1' OR g_prbf001 = '3' THEN
      CALL cl_set_comp_required("prbf004",TRUE)            
   END IF
   #150401-00003#1--add by dongsz--end---
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aprt111_set_entry_b(p_cmd)
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
   #20150923--mark by dongsz--s
#   IF p_cmd = 'a' THEN
#      CALL cl_set_comp_entry("prbg001,prbgsite,prbg002,prbg003",TRUE)
#      #CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012",FALSE)    #150401-00003#1--mark by dongsz
#      #CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017",FALSE) #150401-00003#1--add by dongsz  #150429-00002#1--mark by dongsz
#      CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017,prbg018",FALSE)  #150429-00002#1--add by dongsz
#   END IF   
   #20150923--mark by dongsz--e
   #150401-00003#1--add by dongsz--str---
   #单据类型为1，则进价必输；类型为2.则售价必输
   CALL cl_set_comp_required("prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017,prbg018",FALSE)    #150429-00002#1--dongsz add prbg018
   CALL cl_set_comp_required("prbg026",FALSE)    #160506-00009#22 dongsz add
   #150401-00003#1--add by dongsz--end---
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aprt111_set_no_entry_b(p_cmd)
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
   #20150923--mark by dongsz--s
#   IF p_cmd = 'u' THEN
#      IF g_prbg_d_t.prbgseq1 = '0' THEN   
#         CALL cl_set_comp_entry("prbg001,prbgsite,prbg002,prbg003",TRUE)
#         #CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012",FALSE)         #150401-00003#1--mark by dongsz
#         #CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017",FALSE) #150401-00003#1--add by dongsz  #150429-00002#1--mark by dongsz
#         CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017,prbg018",FALSE)  #150429-00002#1--add by dongsz
#      ELSE
#         CALL cl_set_comp_entry("prbg001,prbgsite,prbg002,prbg003",FALSE)
#         #CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012",TRUE)          #150401-00003#1--mark by dongsz
#         CALL cl_set_comp_entry("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg014,prbg015,prbg016,prbg017,prbg018",TRUE) #150401-00003#1--add by dongsz #150429-00002#1--dongsz add prbg018
#         CALL cl_set_comp_required("prbg005,prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012,prbg018",FALSE)    #150401-00003#1--add by dongsz #150429-00002#1--dongsz add prbg018
#      END IF
#   END IF
   #20150923--mark by dongsz--e
   #IF g_prbf001 = '2' THEN
   IF g_prbf001 = '2' OR g_prbf001 = '6' OR g_prbf001 = '7' OR g_prbf001 = '8' OR g_prbf001 = '9' THEN   #150903-00008#14 dongsz add
      CALL cl_set_comp_entry("prbg005,prbg006,prbg007",FALSE)   #150429-00002#1--dongsz add prbg005
   END IF
   IF g_prbf001 = '3' THEN
      CALL cl_set_comp_entry("prbg005,prbg018",FALSE)    #150429-00002#1--dongsz add prbg018
   END IF
   #150401-00003#1--add by dongsz--str---
   #单据类型为1，则进价必输；类型为2.则售价必输
   IF g_prbf001 = '1' OR g_prbf001 = '3' THEN
      CALL cl_set_comp_required("prbg005,prbg006,prbg007",TRUE)    #150429-00002#1--dongsz add prbg005
   END IF
   IF g_prbf001 = '2' OR g_prbf001 = '6' OR g_prbf001 = '9' THEN
      CALL cl_set_comp_required("prbg008,prbg009,prbg010,prbg011,prbg012,prbg018",TRUE) #150429-00002#1--dongsz add prbg018
   END IF
   #150401-00003#1--add by dongsz--end---
   #160506-00009#22--dongsz add--str
   IF g_prbf001 = '2' OR g_prbf001 = '6' THEN
      CALL cl_set_comp_required("prbg026",TRUE)
   END IF
   #160506-00009#22--dongsz add--end
   #150903-00008#16--dongsz add--str---
   IF g_prbf001 = '7' THEN
      CALL cl_set_comp_required("prbg009",TRUE)
   END IF
   IF g_prbf001 = '8' THEN
      CALL cl_set_comp_required("prbg010,prbg011,prbg012",TRUE)
   END IF
   #150903-00008#16--dongsz add--end---
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aprt111_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
 
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aprt111_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_prbf_m.prbfstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aprt111_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aprt111_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aprt111_default_search()
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
      LET ls_wc = ls_wc, " prbfdocno = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   LET ls_wc = ''
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = " prbfdocno = '", g_argv[02], "' AND "  
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
         INITIALIZE g_wc2_table2 TO NULL
 
         INITIALIZE g_wc2_table3 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "prbf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prbg_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "prbv_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "prbw_t" 
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
#   IF NOT cl_null(g_argv[1]) THEN
#      LET ls_wc = " prbf001 = '", g_argv[1], "' AND "
#   END IF
#   IF NOT cl_null(g_argv[02]) THEN
#      LET ls_wc = ls_wc," prbfdocno = '", g_argv[02], "' AND "  
#   END IF      
#
#   IF NOT cl_null(ls_wc) THEN
#      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
#      LET g_default = TRUE
#   ELSE
#      LET g_default = FALSE
#      #預設查詢條件
#      LET g_wc = cl_qbe_get_default_qryplan()
#      IF cl_null(g_wc) THEN
#         LET g_wc = " 1=1"
#      END IF
#   END IF
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc," AND prbf001 = '", g_argv[01], "' "
   END IF
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aprt111.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aprt111_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_param  RECORD
      prbk006         LIKE prbk_t.prbk006,
      #prbk003         LIKE prbk_t.prbk003,       #150427-00011#1--mark by dongsz
      prbk025         LIKE prbk_t.prbk025,        #150427-00011#1--add by dongsz
      wc              STRING
                   END RECORD   
   DEFINE l_sql    STRING
   DEFINE l_n      LIKE type_t.num5
   DEFINE l_n1     LIKE type_t.num5
   DEFINE l_n2     LIKE type_t.num5
   DEFINE l_n3     LIKE type_t.num5
   DEFINE l_n4     LIKE type_t.num5
   DEFINE l_n5     LIKE type_t.num5
   DEFINE l_n6     LIKE type_t.num5
   DEFINE l_cnt    LIKE type_t.num10
   DEFINE l_prbfud002 LIKE prbf_t.prbfud002  # ADD BY GUOMY 2015/10/22
   DEFINE l_msg    STRING
   #add by geza 20160121(S)  
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD       
   DEFINE ls_js        STRING
   DEFINE ls_js1       STRING    
   DEFINE l_comp       LIKE ooef_t.ooef001
   DEFINE g_glaa003    LIKE glaa_t.glaa003
   DEFINE g_glaa024    LIKE glaa_t.glaa024
   DEFINE l_stbasite   LIKE stba_t.stbasite
   DEFINE l_ooba002    LIKE ooba_t.ooba002
   DEFINE l_ooba002_1  LIKE ooba_t.ooba002
   DEFINE g_ld         LIKE apca_t.apcald
   DEFINE l_errno      LIKE type_t.chr100
   DEFINE l_pmdsdocno  LIKE pmds_t.pmdsdocno
   DEFINE l_pmdssite   LIKE pmds_t.pmdssite
   DEFINE l_pmdsdocdt  LIKE pmds_t.pmdsdocdt
   DEFINE l_prgadocno  LIKE prga_t.prgadocno
   #add by geza 20160121(E) 
   #add by 08172
   DEFINE   l_ooac002      LIKE ooac_t.ooac002
   DEFINE   l_ooac004      LIKE ooac_t.ooac004
   DEFINE   l_flag1        LIKE type_t.num5 
   #add by 08172
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
                                 
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prbf_m.prbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aprt111_cl USING g_enterprise,g_prbf_m.prbfdocno
   IF STATUS THEN
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aprt111_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
       g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
       g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt, 
       g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp_desc, 
       g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aprt111_action_chk() THEN
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno,g_prbf_m.prbf002, 
       g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf004_desc,g_prbf_m.prbf005,g_prbf_m.prbf005_desc, 
       g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbf013_desc,g_prbf_m.prbfunit,g_prbf_m.prbf010, 
       g_prbf_m.prbf010_desc,g_prbf_m.prbf012,g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011, 
       g_prbf_m.prbf011_desc,g_prbf_m.prbfstus,g_prbf_m.prbfownid,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp, 
       g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdp_desc, 
       g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid,g_prbf_m.prbfmodid_desc,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid, 
       g_prbf_m.prbfcnfid_desc,g_prbf_m.prbfcnfdt
 
   CASE g_prbf_m.prbfstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "E"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/ended.png")
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
         CASE g_prbf_m.prbfstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "E"
               HIDE OPTION "ended"
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
      CASE g_prbf_m.prbfstus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,ended,hold",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF
         WHEN "R"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,ended,hold",FALSE)
         WHEN "D"    #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed,ended,hold",FALSE)
         WHEN "X"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "confirmed"
            HIDE OPTION "ended"
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         WHEN "Y"
            HIDE OPTION "invalid" 
            #IF g_prbf001 = '3' THEN
            IF g_prbf001 MATCHES '[3678]' THEN     #150903-00008#12 dongsz add
               HIDE OPTION "unconfirmed"
               #RETURN
            END IF
            IF g_prbf001 MATCHES '[129]' THEN
               HIDE OPTION "ended"
            END IF
         WHEN "E"
            HIDE OPTION "unconfirmed"
            HIDE OPTION "confirmed"
            HIDE OPTION "invalid"
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
            CALL cl_set_act_visible("withdraw",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed,ended,hold",FALSE)
         WHEN "A"    #只能顯示確認; 其餘應用功能皆隱藏
            CALL cl_set_act_visible("confirmed",TRUE)
            CALL cl_set_act_visible("unconfirmed,invalid,ended,hold",FALSE)
      END CASE                                                                      
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT aprt111_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt111_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT aprt111_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE aprt111_cl
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
      ON ACTION ended
         IF cl_auth_chk_act("ended") THEN
            LET lc_state = "E"
            #add-point:action控制 name="statechange.ended"
            
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
      AND lc_state <> "E"
      AND lc_state <> "A"
      AND lc_state <> "D"
      AND lc_state <> "R"
      AND lc_state <> "W"
      AND lc_state <> "X"
      ) OR 
      g_prbf_m.prbfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   LET l_success = TRUE
   CASE
      WHEN lc_state = 'Y'
         CALL cl_err_collect_init()
         CALL s_aprt111_conf_chk(g_prbf_m.prbfdocno,g_prbf_m.prbfstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            #150401-00003#1--add by dongsz--str---
            #IF g_prbf_m.prbf001 = '3' THEN
            #20151027--dongsz add--str---
            #判断是否存在已参加促销活动的商品
            IF g_prbf_m.prbf001 MATCHES '[3678]' THEN
               CALL cl_err_collect_init()
               CALL s_aprt111_chk_prda(g_prbf_m.prbfdocno) RETURNING l_success
               CALL cl_err_collect_show()
               IF NOT l_success THEN
                  IF cl_ask_confirm('apr-00472') THEN
                     DELETE FROM prbg_t
                      WHERE prbgent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND EXISTS(SELECT 1 FROM s_aprt111_tmp1 WHERE prbg002 = tmp1_imaa001)

                     CALL aprt111_b_fill()

                     IF g_prbg_d.getLength()=0 THEN
                        CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
                        RETURN
                     END IF
                  END IF
               END IF
               #20151027--dongsz add--end---
               #判断调价清单日期是否重叠
               LET l_n1 = 0
               #门店进价
               SELECT COUNT(*) INTO l_n1
                 FROM prbk_t,prbg_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = prbgsite
                  AND prbg001 = '2'
                  AND prbk010 = prbg002
                  AND prbg007 IS NOT NULL
                  AND prbk025 = '1'
                  AND ((prbk006 <= prbg014 AND (prbk007 >= prbg014 AND prbk007 <= prbg015)) OR 
                       (prbk006 <= prbg014 AND prbk007 >= prbg015) OR 
                       ((prbk006 >= prbg014 AND prbk006 <= prbg015) AND prbk007 >= prbg015))
                  AND prbk003 = '3'
                  AND prbkstus IN ('1','2')
               LET l_n2 = 0
               #门店售价
               SELECT COUNT(*) INTO l_n2
                 FROM prbk_t,prbg_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = prbgsite
                  AND prbg001 = '2'
                  AND prbk010 = prbg002
                  AND prbg009 IS NOT NULL
                  AND prbk025 = '2'
                  AND ((prbk006 <= prbg016 AND (prbk007 >= prbg017 AND prbk007 <= prbg017)) OR 
                       (prbk006 <= prbg016 AND prbk007 >= prbg017) OR 
                       ((prbk006 >= prbg016 AND prbk006 <= prbg017) AND prbk007 >= prbg017))
                  AND prbk003 IN ('3','4','5')
                  AND prbkstus IN ('1','2')
               LET l_n3 = 0
               #店群进价
               SELECT COUNT(*) INTO l_n3
                 FROM prbk_t,prbg_t,rtab_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbkent = rtabent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = rtab002
                  AND prbgsite = rtab001
                  AND prbg001 = '1'
                  AND prbk010 = prbg002
                  AND prbg007 IS NOT NULL
                  AND prbk025 = '1'
                  AND ((prbk006 <= prbg014 AND (prbk007 >= prbg014 AND prbk007 <= prbg015)) OR 
                       (prbk006 <= prbg014 AND prbk007 >= prbg015) OR 
                       ((prbk006 >= prbg014 AND prbk006 <= prbg015) AND prbk007 >= prbg015))
                  AND prbk003 = '3'
                  AND prbkstus IN ('1','2')
               LET l_n4 = 0
               #店群售价
               SELECT COUNT(*) INTO l_n4
                 FROM prbk_t,prbg_t,rtab_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbkent = rtabent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = rtab002
                  AND prbgsite = rtab001
                  AND prbg001 = '1'
                  AND prbk010 = prbg002
                  AND prbg009 IS NOT NULL
                  AND prbk025 = '2'
                  AND ((prbk006 <= prbg016 AND (prbk007 >= prbg016 AND prbk007 <= prbg017)) OR 
                       (prbk006 <= prbg016 AND prbk007 >= prbg017) OR 
                       ((prbk006 >= prbg016 AND prbk006 <= prbg017) AND prbk007 >= prbg017))
                  AND prbk003 IN ('3','4','5')
                  AND prbkstus IN ('1','2')
               #20151027--dongsz add--str---
               LET l_n5 = 0
               #门店会员价
               SELECT COUNT(*) INTO l_n5
                 FROM prbk_t,prbg_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = prbgsite
                  AND prbg001 = '2'
                  AND prbk010 = prbg002
                  AND prbg010 IS NOT NULL
                  AND prbk025 = '2'
                  AND ((prbk006 <= prbg019 AND (prbk007 >= prbg019 AND prbk007 <= prbg020)) OR 
                       (prbk006 <= prbg019 AND prbk007 >= prbg020) OR 
                       ((prbk006 >= prbg019 AND prbk006 <= prbg020) AND prbk007 >= prbg020))
                  AND prbk003 IN ('3','6')
                  AND prbkstus IN ('1','2')
               LET l_n6 = 0
               #店群会员价
               SELECT COUNT(*) INTO l_n6
                 FROM prbk_t,prbg_t,rtab_t
                WHERE prbkent = g_enterprise
                  AND prbkent = prbgent
                  AND prbkent = rtabent
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq1 = '1'
                  AND prbksite = rtab002
                  AND prbgsite = rtab001
                  AND prbg001 = '1'
                  AND prbk010 = prbg002
                  AND prbg010 IS NOT NULL
                  AND prbk025 = '2'
                  AND ((prbk006 <= prbg019 AND (prbk007 >= prbg019 AND prbk007 <= prbg020)) OR 
                       (prbk006 <= prbg019 AND prbk007 >= prbg020) OR 
                       ((prbk006 >= prbg019 AND prbk006 <= prbg020) AND prbk007 >= prbg020))
                  AND prbk003 IN ('3','6')
                  AND prbkstus IN ('1','2')
               #20151027--dongsz add--end---
               #LET l_n = l_n1 + l_n2 + l_n3 + l_n4
               LET l_n = l_n1 + l_n2 + l_n3 + l_n4 + l_n5 + l_n6
               IF l_n > 0 THEN
                  #IF NOT cl_ask_confirm('apr-00358') THEN   #20151027 dongsz mark
                  IF NOT cl_ask_confirm('apr-00473') THEN    #20151027 dongsz add
                     CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
                     RETURN
                  END IF
               END IF
            END IF
            #150401-00003#1--add by dongsz--end---
            IF cl_ask_confirm('aim-00108') THEN
               CALL s_transaction_begin()
               CALL s_aprt111_conf_upd(g_prbf_m.prbfdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbf_m.prbfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  IF g_prbf001 <> '9' THEN
                     #執行日期為當前日期，則立即執行調價作業aprp125
                     LET g_success = 'Y'
                     LET g_num1 = 0
                     LET g_num2 = 0         #150427-00011#1--add dongsz
                     #150401-00003#1--add by dongsz--str---
                     #判断单身开始日期是否等于当前日期
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n
                       FROM prbg_t
                      WHERE prbgent = g_enterprise
                        AND prbgdocno = g_prbf_m.prbfdocno
                        AND prbgseq1 = '1'
                        AND ((prbg007 IS NOT NULL AND prbg014 = g_today) OR
                             (prbg009 IS NOT NULL AND prbg016 = g_today) OR
                             (prbg010 IS NOT NULL AND prbg019 = g_today))     #20151027 dongsz add
                     IF l_n > 0 THEN
                     #150401-00003#1--add by dongsz--end---
                     #IF g_prbf_m.prbf006 = g_today THEN            #150401-00003#1--mark by dongsz  
                        IF cl_ask_confirm("apr-00271") THEN
                           LET l_param.prbk006 = g_today
                           LET l_param.wc = " prbk001 = '",g_prbf_m.prbfdocno,"' "
                           IF g_prbf001 = '1' THEN
                              #LET l_param.prbk003 = '1'     #150427-00011#1--mark by dongsz
                              CALL s_aprp125_upd_price_1(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                              #150427-00011#1--add by dongsz--str---
                              CALL s_aprp125_upd_price_2(l_param.*) RETURNING g_success,g_num2
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                              #150427-00011#1--add by dongsz--end---
                           END IF
                           IF g_prbf001 = '2' THEN
                              #LET l_param.prbk003 = '2'     #150427-00011#1--mark by dongsz
                              CALL s_aprp125_upd_price_2(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                           END IF
                           IF g_prbf001 = '3' THEN
                              #LET l_param.prbk003 = '3'     #150427-00011#1--mark by dongsz
                              CALL s_aprp125_upd_price_3(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                           END IF
                           #20151027--dongsz add--str---
                           IF g_prbf001 = '6' THEN
                              CALL s_aprp125_upd_price_6(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                           END IF
                           IF g_prbf001 = '7' THEN
                              CALL s_aprp125_upd_price_7(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                           END IF
                           IF g_prbf001 = '8' THEN
                              CALL s_aprp125_upd_price_8(l_param.*) RETURNING g_success,g_num1
                              IF g_success = 'N' THEN
                                 CALL s_transaction_end('N','0')
                                 RETURN
                              END IF
                           END IF
                           #20151027--dongsz add--end---
                           LET l_sql = " UPDATE prbk_t SET prbkstus = '2' ",
                                       "  WHERE prbkent = '",g_enterprise,"' ",
                                       "    AND prbk006 = '",l_param.prbk006,"' ",
                                       "    AND prbkstus = '1' ",
                                       "    AND ",l_param.wc
                           #150427-00011#1--mark by dongsz--str---
#                           IF NOT cl_null(l_param.prbk003) THEN
#                              LET l_sql = l_sql," AND prbk003 = '",l_param.prbk003,"' "
#                           END IF
                           #150427-00011#1--mark by dongsz--end---
                           PREPARE upd_prbk_pre1 FROM l_sql
                           EXECUTE upd_prbk_pre1
                           IF SQLCA.sqlcode THEN
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'upd prbk'
                              LET g_errparam.extend = ""
                              LET g_errparam.popup = TRUE
                              LET g_success = 'N'
                              CALL s_transaction_end('N','0')
                              RETURN
                           END IF
                           IF g_success = 'Y' THEN                          
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code = 'apr-00209'
                              LET g_errparam.extend = ""
                              LET g_errparam.popup = TRUE
                              LET g_errparam.replace[1] = g_num1+g_num2
                              CALL cl_err()
                     
                           END IF
                        ELSE
                           CALL s_transaction_end('N','0')
                           RETURN
                        END IF
                     END IF
                  
                     #add by guomy 2015/10/21------start----- ------------------------------- 
                     #审核时判断如果勾选了调整则自动产生库存调整单并直接审核----------------------                     
                     IF g_prbf_m.prbfud002 = '2' and (g_prbf001 = '1' OR g_prbf001 = '3') THEN
                        LET l_cnt = 0
                        #160905-00007#12  -S
                       #SELECT count(*) INTO l_cnt
                       #  FROM prbg_t
                       # WHERE prbgdocno = g_prbf_m.prbfdocno
                        SELECT count(*) INTO l_cnt
                          FROM prbg_t
                         WHERE prbgdocno = g_prbf_m.prbfdocno
                           AND prbgent = g_enterprise
                         #160905-00007#12  -E
                        IF l_cnt <> 0 THEN
                           CALL aprt111_upd_prga()
                        END IF               
                     END IF                                         
                     IF g_success = 'Y' THEN  
                        CALL s_transaction_end('Y','1')
                        
                        #add by geza 20160121(S)   
                        #只用aprt111和aprt113在单头勾选了库存补差调整
                        #调用aapp131生成aapt320暂估单
                        IF g_prbf_m.prbfud002 = '2' AND (g_prbf001 = '1' OR g_prbf001 = '3') THEN
                            INITIALIZE l_pmdsdocno TO NULL
                            INITIALIZE l_pmdssite  TO NULL 
                            INITIALIZE l_pmdsdocdt TO NULL 
                            INITIALIZE l_prgadocno TO NULL 
                            SELECT prgadocno INTO l_prgadocno
                              FROM prga_t
                             WHERE prga003 = g_prbf_m.prbfdocno
                               AND prgaent = g_enterprise
                               AND prga001 = '2'
                               
                            SELECT pmdsdocno,pmdssite,pmdsdocdt INTO l_pmdsdocno,l_pmdssite,l_pmdsdocdt
                              FROM pmds_t
                             WHERE pmds201 = l_prgadocno
                               AND pmdsent = g_enterprise
                               AND pmds000 = '27'
                            #160604-00009#92 -s by 08172
                            CALL s_aooi200_get_slip(l_pmdsdocno) RETURNING l_flag1,l_ooac002
                            CALL cl_get_doc_para(g_enterprise,g_site,l_ooac002,'E-CIR-0066') RETURNING l_ooac004
                            IF l_ooac004='Y' THEN
                            #160604-00009#92 -e by 08172
                               INITIALIZE la_param.* TO NULL 
                               LET la_param.prog = "aapp131"
                               LET la_param.param[1] = 'Y'  
                               LET la_param.param[2] = " stbc004 = '",l_pmdsdocno,"' "
                               LET la_param.param[3] = l_pmdssite 
                               CALL s_fin_orga_get_comp_ld(l_pmdssite) RETURNING l_success,l_errno,l_comp,g_ld
                               LET la_param.param[4] = g_ld
                               LET la_param.param[5] = ''
                               LET la_param.param[6] = ''
                               LET la_param.param[7] = '1'
                               LET la_param.param[8] = '1'   
                               #抓取含发票单别
                               CALL s_ld_sel_glaa(g_ld,'glaa003|glaa024') RETURNING l_success,g_glaa003,g_glaa024
                               # 170207-00018#7  2017/02/10 By 09042 mark(S)
                               #SELECT DISTINCT ooba002 INTO l_ooba002 
                               #  FROM ooba_t 
                               #  LEFT OUTER JOIN ooac_t 
                               #    ON ooacent = oobaent 
                               #   AND ooac001 = ooba001 
                               #   AND ooac002 = ooba002 
                               # WHERE oobaent = g_enterprise
                               #   AND ooba002 IN (SELECT oobl001 
                               #                     FROM oobl_t 
                               #                    WHERE ooblent = g_enterprise
                               #                      AND oobl002 = 'aapt320')
                               #   AND oobastus = 'Y' 
                               #   AND ooba001 =  g_glaa024
                               #   AND ooac003 = 'E-FINC1001' 
                               #   AND ooac004 = 'Y' 
                               #   AND rownum = 1 
                               # ORDER BY ooba002
                               # 170207-00018#7  2017/02/10 By 09042 mark(E)
                               
                               # 170207-00018#7  2017/02/10 By 09042 add(S)
                               SELECT a.ooba002 INTO l_ooba002
                                 FROM ( 
                                       SELECT DISTINCT ooba002
                                         FROM ooba_t
                                         LEFT OUTER JOIN ooac_t  
                                           ON ooacent = oobaent
                                          AND ooac001 = ooba001
                                          AND ooac002 = ooba002
                                        WHERE oobaent = g_enterprise
                                          AND ooba002 IN (SELECT oobl001 
                                                    FROM oobl_t 
                                                   WHERE ooblent = g_enterprise
                                                     AND oobl002 = 'aapt320')
                                          AND oobastus = 'Y'
                                          AND ooba001 =  g_glaa024 
                                          AND ooac003 = 'E-FINC1001'
                                          AND ooac004 = 'Y'
                                        ORDER BY ooba002   
                                       ) a
                               WHERE rownum = 1;                                    
                               # 170207-00018#7  2017/02/10 By 09042 add(E)                                     
                               LET la_param.param[9] = l_ooba002
                               #抓取不含发票单别
                              # 170207-00018#7  2017/02/10 By 09042 mark(S)                               
                              # SELECT DISTINCT ooba002 INTO l_ooba002_1 
                              #   FROM ooba_t 
                              #   LEFT OUTER JOIN ooac_t 
                              #     ON ooacent = oobaent 
                              #    AND ooac001 = ooba001 
                              #    AND ooac002 = ooba002 
                              #  WHERE oobaent = g_enterprise
                              #    AND ooba002 IN (SELECT oobl001 
                              #                      FROM oobl_t 
                              #                     WHERE ooblent = g_enterprise
                              #                       AND oobl002 = 'aapt320')
                              #    AND oobastus = 'Y' 
                              #    AND ooba001 =  g_glaa024
                              #    AND ooac003 = 'E-FINC1001' 
                              #    AND ooac004 = 'N' 
                              #    AND rownum = 1                                  
                              #  ORDER BY ooba002
                              # 170207-00018#7  2017/02/10 By 09042 mark(E)
                              
                              # 170207-00018#7  2017/02/10 By 09042 add(S) 
                               SELECT b.ooba002 INTO l_ooba002_1
                                 FROM ( 
                                       SELECT DISTINCT ooba002
                                         FROM ooba_t
                                         LEFT OUTER JOIN ooac_t  
                                           ON ooacent = oobaent
                                          AND ooac001 = ooba001
                                          AND ooac002 = ooba002
                                        WHERE oobaent = g_enterprise
                                          AND ooba002 IN (SELECT oobl001 
                                                    FROM oobl_t 
                                                   WHERE ooblent = g_enterprise
                                                     AND oobl002 = 'aapt320')
                                          AND oobastus = 'Y'
                                          AND ooba001 =  g_glaa024 
                                          AND ooac003 = 'E-FINC1001'
                                          AND ooac004 = 'N'
                                        ORDER BY ooba002   
                                       ) b
                               WHERE rownum = 1;                       
                              # 170207-00018#7  2017/02/10 By 09042 add(E)
                               LET la_param.param[10] = l_ooba002_1 
                               LET la_param.param[11] = ''   
                               LET la_param.param[12] = l_pmdsdocdt 
                               
                               LET ls_js = util.JSON.stringify(la_param)
                               CALL cl_cmdrun_wait(ls_js)
                            END IF
                        END IF    
                        #add by geza 20160121(E)
                     ELSE 
                     	CALL s_transaction_end('N','1')
                     	RETURN 
                     END IF 
                     #add by guomy 2015/10/21------end----- ----------------------------------       
                  ELSE         #160517-00014#1 dongsz add
                     CALL s_transaction_end('N','0')   #160517-00014#1 dongsz add                     
                  END IF
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         END IF
      #150903-00008#12--dongsz add--str---
      WHEN lc_state = 'E'
         CALL cl_err_collect_init()
         CALL s_aprt111_end_chk(g_prbf_m.prbfdocno,g_prbf_m.prbfstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('apr-00469') THEN
               CALL s_transaction_begin()
               CALL s_aprt111_end_upd(g_prbf_m.prbfdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbf_m.prbfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         END IF
      #150903-00008#12--dongsz add--end---
      WHEN lc_state = 'X'
         CALL cl_err_collect_init()
         CALL s_aprt111_void_chk(g_prbf_m.prbfdocno,g_prbf_m.prbfstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('art-00039') THEN
               CALL s_transaction_begin()
               CALL s_aprt111_void_upd(g_prbf_m.prbfdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbf_m.prbfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         END IF
      WHEN lc_state = 'N'
         CALL cl_err_collect_init()
         CALL s_aprt111_unconf_chk(g_prbf_m.prbfdocno,g_prbf_m.prbfstus) RETURNING l_success
         CALL cl_err_collect_show()
         IF l_success THEN
            IF cl_ask_confirm('aim-00110') THEN
               #add by guomy 2015/10/22 ----srart----
               SELECT prbfud002 INTO l_prbfud002 
                 FROM prbf_t
                WHERE prbfdocno =g_prbf_m.prbfdocno
                  AND prbfent = g_enterprise
                IF l_prbfud002 = '2' THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apr-00475'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add                   
                   RETURN                  
                END IF 
             #add by guomy 2015/10/22 ----end----
               CALL s_transaction_begin()
               CALL s_aprt111_unconf_upd(g_prbf_m.prbfdocno) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_prbf_m.prbfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  CALL s_transaction_end('Y','1')
               END IF
            ELSE
               CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
               RETURN
            END IF
         ELSE
            CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
            RETURN
         END IF
      OTHERWISE
         CALL s_transaction_end('N','0')   #160816-00068#12 by 08209 add
         RETURN
   END CASE                 {#ADP版次:1#}                                     
   #end add-point
   
   LET g_prbf_m.prbfmodid = g_user
   LET g_prbf_m.prbfmoddt = cl_get_current()
   LET g_prbf_m.prbfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE prbf_t 
      SET (prbfstus,prbfmodid,prbfmoddt) 
        = (g_prbf_m.prbfstus,g_prbf_m.prbfmodid,g_prbf_m.prbfmoddt)     
    WHERE prbfent = g_enterprise AND prbfdocno = g_prbf_m.prbfdocno
 
    
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
         WHEN "E"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/ended.png")
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
      EXECUTE aprt111_master_referesh USING g_prbf_m.prbfdocno INTO g_prbf_m.prbfsite,g_prbf_m.prbfdocdt, 
          g_prbf_m.prbfdocno,g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf005, 
          g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf012, 
          g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbfstus,g_prbf_m.prbfownid, 
          g_prbf_m.prbfowndp,g_prbf_m.prbfcrtid,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid, 
          g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfdt,g_prbf_m.prbfsite_desc,g_prbf_m.prbf004_desc, 
          g_prbf_m.prbf005_desc,g_prbf_m.prbf013_desc,g_prbf_m.prbf010_desc,g_prbf_m.prbf011_desc,g_prbf_m.prbfownid_desc, 
          g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfmodid_desc, 
          g_prbf_m.prbfcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_prbf_m.prbfsite,g_prbf_m.prbfsite_desc,g_prbf_m.prbfdocdt,g_prbf_m.prbfdocno, 
          g_prbf_m.prbf002,g_prbf_m.prbf003,g_prbf_m.prbf001,g_prbf_m.prbf004,g_prbf_m.prbf004_desc, 
          g_prbf_m.prbf005,g_prbf_m.prbf005_desc,g_prbf_m.prbf006,g_prbf_m.prbf007,g_prbf_m.prbf013, 
          g_prbf_m.prbf013_desc,g_prbf_m.prbfunit,g_prbf_m.prbf010,g_prbf_m.prbf010_desc,g_prbf_m.prbf012, 
          g_prbf_m.prbfud002,g_prbf_m.prbfud003,g_prbf_m.prbf011,g_prbf_m.prbf011_desc,g_prbf_m.prbfstus, 
          g_prbf_m.prbfownid,g_prbf_m.prbfownid_desc,g_prbf_m.prbfowndp,g_prbf_m.prbfowndp_desc,g_prbf_m.prbfcrtid, 
          g_prbf_m.prbfcrtid_desc,g_prbf_m.prbfcrtdp,g_prbf_m.prbfcrtdp_desc,g_prbf_m.prbfcrtdt,g_prbf_m.prbfmodid, 
          g_prbf_m.prbfmodid_desc,g_prbf_m.prbfmoddt,g_prbf_m.prbfcnfid,g_prbf_m.prbfcnfid_desc,g_prbf_m.prbfcnfdt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
                                 
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
                                 
   #end add-point  
 
   CLOSE aprt111_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aprt111_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt111.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aprt111_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
                                 
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_prbg_d.getLength() THEN
         LET g_detail_idx = g_prbg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbg_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx > g_prbg3_d.getLength() THEN
         LET g_detail_idx = g_prbg3_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbg3_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbg3_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx > g_prbg4_d.getLength() THEN
         LET g_detail_idx = g_prbg4_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbg4_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbg4_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #20150923--add by dongsz--s
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_prbk_d.getLength() THEN
         LET g_detail_idx = g_prbk_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_prbk_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_prbk_d.getLength() TO FORMONLY.cnt
   END IF
   #20150923--add by dongsz--e   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprt111_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING                  
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   #20150923--add by dongsz--s
   CALL g_prbk_d.clear()
   
   LET l_ac = 1
   LET l_sql = " SELECT prbkstus,prbk025,prbk003,prbksite,ooefl003,prbk010,prbk011,prbk014,oocal003, ",
               "        prbk018,prbk020,prbk021,prbk022,prbk023,prbk028,prbk001,prbk002,prbk006,prbk007 ",  #160506-00009#22 dongsz add prbk028
               "   FROM prbk_t LEFT JOIN oocal_t ON oocalent=prbkent AND oocal001=prbk014 AND oocal002='",g_dlang,"' ",
               "               LEFT JOIN ooefl_t ON ooeflent=prbkent AND ooefl001=prbksite AND ooefl002='",g_dlang,"' ",
               "  WHERE prbkent = ",g_enterprise," ",
               #"    AND prbksite = '",g_prbg_d[g_detail_idx].prbgsite,"' ",   #151013-00001#38--dongsz mark
               #151013-00001#38--dongsz add--s
               #"    AND prbksite IN (SELECT ooed004 FROM ooed_t ",#160905-00007#12  mark
               "    AND prbksite IN (SELECT ooed004 FROM ooed_t WHERE ooedent=",g_enterprise,  #160905-00007#12  add
               "                     START WITH ooed005='",g_prbf_m.prbfsite,"' AND ooed001='10' ",
               "                           AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
               "                     CONNECT BY nocycle PRIOR ooed004=ooed005 AND ooed001='10' ",
               "                           AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
               #"                     UNION SELECT ooed004 FROM ooed_t WHERE ooed004='",g_prbf_m.prbfsite,"') ",  #160905-00007#12 mark
               "                     UNION SELECT ooed004 FROM ooed_t WHERE ooedent = ",g_enterprise," AND ooed004='",g_site,"' )",      #160905-00007#12 add         
               #151013-00001#38--dongsz add--e
               "    AND prbk010 = '",g_prbg_d[g_detail_idx].prbg002,"' ",
               "    AND prbkstus IN ('1','2') ",
               "  ORDER BY prbk006 DESC "
   PREPARE sel_prbk_pre FROM l_sql
   DECLARE sel_prbk_cs  CURSOR FOR sel_prbk_pre
   FOREACH sel_prbk_cs  INTO g_prbk_d[l_ac].prbkstus,g_prbk_d[l_ac].prbk025,g_prbk_d[l_ac].prbk003,
                             g_prbk_d[l_ac].prbksite,g_prbk_d[l_ac].prbksite_desc,
                             g_prbk_d[l_ac].prbk010,g_prbk_d[l_ac].prbk011,g_prbk_d[l_ac].prbk014,
                             g_prbk_d[l_ac].prbk014_desc,g_prbk_d[l_ac].prbk018,g_prbk_d[l_ac].prbk020,
                             g_prbk_d[l_ac].prbk021,g_prbk_d[l_ac].prbk022,g_prbk_d[l_ac].prbk023,g_prbk_d[l_ac].prbk028,  #g_prbk_d[l_ac].prbk023#22 dongsz add prbk028
                             g_prbk_d[l_ac].prbk001,g_prbk_d[l_ac].prbk002,g_prbk_d[l_ac].prbk006,g_prbk_d[l_ac].prbk007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      
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
   
   CALL g_prbk_d.deleteElement(g_prbk_d.getLength())
   
   #DISPLAY ARRAY g_prbk_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b) #page1  
   # 
   #   BEFORE ROW
   #            
   #   BEFORE DISPLAY
   #                    
   #END DISPLAY
   #20150923--add by dongsz--e   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aprt111_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aprt111_fill_chk(ps_idx)
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
 
{<section id="aprt111.status_show" >}
PRIVATE FUNCTION aprt111_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprt111.mask_functions" >}
&include "erp/apr/aprt111_mask.4gl"
 
{</section>}
 
{<section id="aprt111.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION aprt111_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   DEFINE l_success  LIKE type_t.chr2
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
   LET g_wc2_table3 = " 1=1"
 
 
   CALL aprt111_show()
   CALL aprt111_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   CALL s_aprt111_conf_chk(g_prbf_m.prbfdocno,g_prbf_m.prbfstus) RETURNING l_success
   IF NOT l_success THEN
      CLOSE aprt111_cl
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_prbf_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_prbg_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_prbg3_d))
   CALL cl_bpm_set_detail_data("s_detail4", util.JSONArray.fromFGL(g_prbg4_d))
 
 
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
   #CALL aprt111_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL aprt111_ui_headershow()
   CALL aprt111_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION aprt111_draw_out()
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
   CALL aprt111_ui_headershow()  
   CALL aprt111_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="aprt111.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aprt111_set_pk_array()
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
   LET g_pk_array[1].values = g_prbf_m.prbfdocno
   LET g_pk_array[1].column = 'prbfdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt111.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aprt111.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aprt111_msgcentre_notify(lc_state)
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
   CALL aprt111_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_prbf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aprt111.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aprt111_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#29 add-S
   SELECT prbfstus  INTO g_prbf_m.prbfstus
     FROM prbf_t
    WHERE prbfent = g_enterprise
      AND prbfdocno = g_prbf_m.prbfdocno

  IF(g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_prbf_m.prbfstus
        WHEN 'W'
           LET g_errno = 'sub-00180'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
        WHEN 'S'
           LET g_errno = 'sub-00230'
        WHEN 'E'
           LET g_errno = 'sub-01360'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_prbf_m.prbfdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL aprt111_set_act_visible()
        CALL aprt111_set_act_no_visible()
        CALL aprt111_show()
        RETURN FALSE
     END IF
   END IF
   #160818-00017#29 add-E
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aprt111.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 單身點擊新增按鈕錄入值
# Memo...........:
# Usage..........: CALL aprt111_ins_prbg()
# Date & Author..: 2014/03/14 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_ins_prbg()
   DEFINE l_n        LIKE type_t.num5 
   DEFINE l_prbg002  LIKE prbg_t.prbg002  
            SELECT prbg002 INTO l_prbg002 FROM prbg_t
             WHERE prbgent = g_enterprise
               AND prbgdocno = g_prbf_m.prbfdocno
               AND prbgseq = g_prbg_d[l_ac].prbgseq
               AND prbgseq1 = g_prbg_d[l_ac].prbgseq1
            IF cl_null(l_prbg002) THEN
               RETURN
            END IF
            #LET l_insert = TRUE
            LET g_flag = 'Y'
            LET l_ac_t = l_ac
            LET l_n = ARR_COUNT()
            LET l_ac = l_n + 1
            #CALL FGL_SET_ARR_CURR(l_ac)
            LET l_cmd = 'a'            
            INITIALIZE g_prbg_d[l_ac].* TO NULL
            #INITIALIZE g_prbg_d[l_ac+1].* TO NULL             

            LET g_prbg_d[l_ac].prbg001 = "2"
            LET g_prbg_d[l_ac].prbgunit = g_site
            #LET g_prbg_d[l_ac+1].prbgunit = g_site
            SELECT MAX(prbgseq)+1 INTO g_prbg_d[l_ac].prbgseq FROM prbg_t
             WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
            IF cl_null(g_prbg_d[l_ac].prbgseq) THEN
               LET g_prbg_d[l_ac].prbgseq = 1
               LET g_prbg_d[l_ac].prbgsite = g_prbg_d[l_ac].prbgunit
            ELSE
               SELECT prbgsite INTO g_prbg_d[l_ac].prbgsite
                 FROM prbg_t
                WHERE prbgent = g_enterprise 
                  AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgseq = g_prbg_d[l_ac].prbgseq - 1
                  AND prbgseq1 = '0'
                  AND prbg001 = '2'
               IF cl_null(g_prbg_d[l_ac].prbgsite) THEN
                  LET g_prbg_d[l_ac].prbgsite = g_prbg_d[l_ac].prbgunit
               END IF
            END IF         
            
            LET l_ac = l_ac_t
            LET g_prbg_d_t.* = g_prbg_d[l_ac].* 
            CALL FGL_SET_ARR_CURR(l_n+1)

END FUNCTION
################################################################################
# Descriptions...: 由商品編號帶值，并更新資料
# Memo...........:
# Usage..........: CALL aprt111_prbg002_rtdx(p_cmd)
# Date & Author..: 14/03/06 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_prbg002_rtdx(p_cmd)
DEFINE p_cmd          LIKE type_t.chr1
DEFINE l_ooef019      LIKE ooef_t.ooef019
DEFINE l_n            LIKE type_t.num5
DEFINE l_prbg004      LIKE prbg_t.prbg004

   SELECT imaal003,imaal004,imaa009 
     INTO g_prbg_d[l_ac].prbg002_desc,g_prbg_d[l_ac].prbg002_desc_desc,g_prbg_d[l_ac].prbg002_desc_desc_desc
     FROM imaa_t LEFT OUTER JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = g_dlang
    WHERE imaaent = g_enterprise 
      AND imaa001 = g_prbg_d[l_ac].prbg002
      
   SELECT rtaxl003 INTO g_prbg_d[l_ac].rtaxl003
     FROM rtaxl_t
    WHERE rtaxlent = g_enterprise
      AND rtaxl001 = g_prbg_d[l_ac].prbg002_desc_desc_desc
      AND rtaxl002 = g_dlang

   IF g_prbg_d[l_ac].prbg001 = '2' THEN
      #IF g_prbf001 <> '3' THEN
      IF g_prbf001 MATCHES '[12]' THEN
         #150312-00002#5 Modify-S By Ken 150317 原rtdx033換成imaa106
         #SELECT rtdx002,rtdx033,oocal003,rtdx035,rtdx034,rtdx014,rtdx016,rtdx017,rtdx018,rtdx019
         #  INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
         #       g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
         #       g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
         #       g_prbg_d[l_ac].prbg012
         #  FROM rtdx_t LEFT OUTER JOIN oocal_t ON rtdxent = oocalent AND rtdx033 = oocal001 AND oocal002 = g_dlang
         # WHERE rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
         #   AND rtdx001 = g_prbg_d[l_ac].prbg002    
         #150429-00002#1--mark by dongsz--str---
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx034,rtdx014,rtdx016,rtdx017,rtdx018,rtdx019
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#                g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#          WHERE rtdxent = imaaent AND rtdx001 = imaa001
#            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#            AND rtdx001 = g_prbg_d[l_ac].prbg002  
         #150312-00002#5 Modify-E  
         #150429-00002#1--mark by dongsz--end--- 
         #20150923--mark by dongsz--s
         #150429-00002#1--add by dongsz--str--- 
#         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
#                rtdx034,imaf113,t2.oocal003,rtdx014,
#                rtdx016,rtdx017,rtdx018,rtdx019
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
#                g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012        
#           FROM rtdx_t,imaf_t 
#                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
#                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
#          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
#            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150429-00002#1--add by dongsz--end--- 
         #20150923--mark by dongsz--e
         #20150923--add by dongsz--s
         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
                rtdx034,rtdx051,imaf113,t2.oocal003,
                rtdx014,rtdx016
           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
                g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,
                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg023    
           FROM rtdx_t,imaf_t 
                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #20150923--add by dongsz--e         
      END IF
      #160506-00009#22--dongsz add--str
      #抓取执行积分单价
      IF g_prbf001 = '2' THEN
         SELECT rtdx101 INTO g_prbg_d[l_ac].prbg025
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      END IF
      #160506-00009#22--dongsz add--end
         #150401-00003#1--mark by dongsz--str---
#         #150312-00002#5 Modify-S By Ken 150317 原rtdx033換成imaa106
#         #SELECT rtdx002,rtdx033,oocal003,rtdx035,rtdx032,rtdx014,rtdx021,rtdx038,rtdx039,rtdx040
#         #  INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#         #       g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#         #       g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#         #       g_prbg_d[l_ac].prbg012
#         #  FROM rtdx_t LEFT OUTER JOIN oocal_t ON rtdxent = oocalent AND rtdx033 = oocal001 AND oocal002 = g_dlang
#         # WHERE rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#         #   AND rtdx001 = g_prbg_d[l_ac].prbg002
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx032,rtdx014,rtdx021,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#                g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t 
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#          WHERE rtdxent = imaaent AND rtdx001 = imaa001
#            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#            AND rtdx001 = g_prbg_d[l_ac].prbg002
#         #150312-00002#5 Modify-E            
         #150401-00003#1--mark by dongsz--end--- 
         #150429-00002#1--mark by dongsz--str---
         #150401-00003#1--add by dongsz--str---
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx032,rtdx041,rtdx042,rtdx014,rtdx021,rtdx022,rtdx023,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015,
#                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg016,g_prbg_d[l_ac].prbg017,
#                g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t 
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#          WHERE rtdxent = imaaent AND rtdx001 = imaa001
#            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150401-00003#1--add by dongsz--end--- 
         #150429-00002#1--mark by dongsz--end---
         #20150923--mark by dongsz--s
         #150429-00002#1--add by dongsz--str--- 
#         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
#                rtdx032,rtdx041,rtdx042,imaf113,
#                t2.oocal003,rtdx014,rtdx021,rtdx022,
#                rtdx023,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
#                g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015,g_prbg_d[l_ac].prbg018,
#                g_prbg_d[l_ac].prbg018_desc,g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg016,
#                g_prbg_d[l_ac].prbg017,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaf_t
#                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
#                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
#          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
#            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
#            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150429-00002#1--add by dongsz--end---   
         #20150923--mark by dongsz--e
         #20150923--add by dongsz--s
      IF g_prbf001 MATCHES '[36789]' THEN
         SELECT imaf144,t1.oocal003,rtdx035,
                rtdx032,rtdx051,imaf113,t2.oocal003,
                rtdx014,rtdx021
           INTO g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
                g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,
                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg023
           FROM rtdx_t,imaf_t
                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
            AND rtdxent = g_enterprise AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002   
         #20150923--add by dongsz--e       
         IF g_prbf001 <> '9' THEN
            SELECT rtdx002 INTO g_prbg_d[l_ac].prbg003
              FROM rtdx_t
             WHERE rtdxent = g_enterprise
               AND rtdxsite = g_prbg_d[l_ac].prbgsite
               AND rtdx001 = g_prbg_d[l_ac].prbg002
         END IF
      END IF
      #add by yangxf ---start----
      #160506-00009#22--dongsz add--str
      #抓取执行积分单价
      IF g_prbf001 = '6' THEN
         SELECT rtdx102 INTO g_prbg_d[l_ac].prbg025
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      END IF
      #160506-00009#22--dongsz add--end
      #20150923--mark by dongsz--s
#      #抓取最新進價         
#      SELECT rtdx034 INTO g_prbg_d[l_ac].rtdx034
#        FROM rtdx_t
#       WHERE rtdxent = g_enterprise
#         AND rtdxsite = g_prbg_d[l_ac].prbgsite
#         AND rtdx001 = g_prbg_d[l_ac].prbg002
#      LET l_prbg004 = g_prbg_d[l_ac].prbg004
#      IF cl_null(l_prbg004) THEN 
#         LET l_prbg004 = ' '
#      END IF 
      #20150923--mark by dongsz--e
      #20150820--add by dongsz--s
      #抓取执行进价和最近入库进价
      LET g_prbg_d[l_ac].prbg021 = 0
      LET g_prbg_d[l_ac].prbg022 = 0
      IF cl_null(g_prbf_m.prbf004) THEN
         #执行进价
         #SELECT rtdx032 INTO g_prbg_d[l_ac].prbg021
         #  FROM rtdx_t
         # WHERE rtdxent = g_enterprise
         #   AND rtdxsite = g_prbg_d[l_ac].prbgsite
         #   AND rtdx001 = g_prbg_d[l_ac].prbg002
         #   AND rtdx041 <= g_prbf_m.prbfdocdt
         #   AND rtdx042 >= g_prbf_m.prbfdocdt
         #IF cl_null(g_prbg_d[l_ac].prbg021) OR g_prbg_d[l_ac].prbg021 = 0 THEN
         #   SELECT rtdx034 INTO g_prbg_d[l_ac].prbg021
         #     FROM rtdx_t
         #    WHERE rtdxent = g_enterprise
         #      AND rtdxsite = g_prbg_d[l_ac].prbgsite
         #      AND rtdx001 = g_prbg_d[l_ac].prbg002
         #END IF
         SELECT rtdx052 INTO g_prbg_d[l_ac].prbg021
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #最近入库进价
         SELECT rtdx051 INTO g_prbg_d[l_ac].prbg022
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      ELSE
         #执行进价
         #SELECT stas011 INTO g_prbg_d[l_ac].prbg021
         #  FROM stas_t,star_t
         # WHERE stasent = g_enterprise
         #   AND stasent = starent AND stas001 = star001
         #   AND stassite = g_prbg_d[l_ac].prbgsite
         #   AND star003 = g_prbf_m.prbf004
         #   AND stas003 = g_prbg_d[l_ac].prbg002
         #   AND stas026 <= g_prbf_m.prbfdocdt
         #   AND stas027 >= g_prbf_m.prbfdocdt
         #IF cl_null(g_prbg_d[l_ac].prbg021) OR g_prbg_d[l_ac].prbg021 = 0 THEN
         #   SELECT stas010 INTO g_prbg_d[l_ac].prbg021
         #     FROM stas_t,star_t
         #    WHERE stasent = g_enterprise
         #      AND stasent = starent AND stas001 = star001
         #      AND stassite = g_prbg_d[l_ac].prbgsite
         #      AND star003 = g_prbf_m.prbf004
         #      AND stas003 = g_prbg_d[l_ac].prbg002
         #END IF
         SELECT stas030 INTO g_prbg_d[l_ac].prbg021
           FROM stas_t,star_t
          WHERE stasent = g_enterprise
            AND stasent = starent AND stas001 = star001
            AND stassite = g_prbg_d[l_ac].prbgsite
            AND star003 = g_prbf_m.prbf004
            AND stas003 = g_prbg_d[l_ac].prbg002
         #最近入库进价
         SELECT stas029 INTO g_prbg_d[l_ac].prbg022
           FROM stas_t,star_t
          WHERE stasent = g_enterprise
            AND stasent = starent AND stas001 = star001
            AND stassite = g_prbg_d[l_ac].prbgsite
            AND star003 = g_prbf_m.prbf004
            AND stas003 = g_prbg_d[l_ac].prbg002
      END IF
      #抓取执行售价
      LET g_prbg_d[l_ac].prbg023 = 0
      #SELECT rtdx021 INTO g_prbg_d[l_ac].prbg023
      #  FROM rtdx_t
      # WHERE rtdxent = g_enterprise
      #   AND rtdxsite = g_prbg_d[l_ac].prbgsite
      #   AND rtdx001 = g_prbg_d[l_ac].prbg002
      #   AND rtdx022 <= g_prbf_m.prbfdocdt
      #   AND rtdx023 >= g_prbf_m.prbfdocdt
      #IF cl_null(g_prbg_d[l_ac].prbg023) OR g_prbg_d[l_ac].prbg023 = 0 THEN
      #   SELECT rtdx016 INTO g_prbg_d[l_ac].prbg023
      #     FROM rtdx_t
      #    WHERE rtdxent = g_enterprise
      #      AND rtdxsite = g_prbg_d[l_ac].prbgsite
      #      AND rtdx001 = g_prbg_d[l_ac].prbg002
      #END IF
      IF g_prbf001 <> '8' THEN
         SELECT rtdx053 INTO g_prbg_d[l_ac].prbg023
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      ELSE
         SELECT rtdx054 INTO g_prbg_d[l_ac].prbg023
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      END IF
      #20150820--add by dongsz--e
      #抓取有效庫存數量
      SELECT SUM(inag009) INTO g_prbg_d[l_ac].inag009
        FROM inag_t
       WHERE inagent = g_enterprise
         AND inagsite = g_prbg_d[l_ac].prbgsite
         AND inag001 = g_prbg_d[l_ac].prbg002
         AND inag002 = l_prbg004
         AND inag010 = 'Y'
      IF cl_null(g_prbg_d[l_ac].inag009) THEN 
         LET g_prbg_d[l_ac].inag009 = 0
      END IF 
      #add by yangxf ----end-----
      #20151201--dongsz add--s
      #抓取多条码单位
      IF g_prbf001 = '9' THEN
         SELECT imay004,oocal003 INTO g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc
           FROM imay_t LEFT JOIN oocal_t ON imayent = oocalent AND imay004 = oocal001 AND oocal002 = g_dlang
          WHERE imayent = g_enterprise
            AND imay003 = g_prbg_d[l_ac].prbg003
      END IF
      #20151201--dongsz add--e
   END IF    
   IF g_prbg_d[l_ac].prbg001 = '1' THEN
      #IF g_prbf001 <> '3' THEN
      IF g_prbf001 <> '3' AND g_prbf001 <> '6' AND g_prbf001 <> '7' AND g_prbf001 <> '8' THEN
         #150312-00002#5 Modify-S By Ken 150317 原rtdx033換成imaa106
         #SELECT rtdx002,rtdx033,oocal003,rtdx035,rtdx034,rtdx014,rtdx016,rtdx017,rtdx018,rtdx019
         #  INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
         #       g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
         #       g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
         #       g_prbg_d[l_ac].prbg012
         #  FROM rtdx_t LEFT OUTER JOIN oocal_t ON rtdxent = oocalent AND rtdx033 = oocal001 AND oocal002 = g_dlang
         #  WHERE rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
         #    AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150429-00002#1--mark by dongsz--str---
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx034,rtdx014,rtdx016,rtdx017,rtdx018,rtdx019
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#                g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t 
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#           WHERE rtdxent = imaaent AND rtdx001 = imaa001
#             AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#             AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150312-00002#5 Modify-E    
         #150429-00002#1--mark by dongsz--end---
         #20150923--mark by dongsz--s
#         #150429-00002#1--add by dongsz--str---
#         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
#                rtdx034,imaf113,t2.oocal003,rtdx014,
#                rtdx016,rtdx017,rtdx018,rtdx019
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
#                g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaf_t
#                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
#                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
#           WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
#             AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#             AND rtdx001 = g_prbg_d[l_ac].prbg002
#         #150429-00002#1--add by dongsz--str---
         #20150923--mark by dongsz--e
         #20150923--add by dongsz--s
         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
                rtdx034,rtdx051,imaf113,t2.oocal003,
                rtdx014,rtdx016
           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
                g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,
                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg023    
           FROM rtdx_t,imaf_t 
                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
            AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
         #20150923--add by dongsz--e           
      ELSE
         #150401-00003#1--mark by dongsz--str---
#         #150312-00002#5 Modify-S By Ken 150317 原rtdx033換成imaa106
#         #SELECT rtdx002,rtdx033,oocal003,rtdx035,rtdx032,rtdx014,rtdx021,rtdx038,rtdx039,rtdx040
#         #  INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#         #       g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#         #       g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#         #       g_prbg_d[l_ac].prbg012
#         #  FROM rtdx_t LEFT OUTER JOIN oocal_t ON rtdxent = oocalent AND rtdx033 = oocal001 AND oocal002 = g_dlang
#         #  WHERE rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#         #    AND rtdx001 = g_prbg_d[l_ac].prbg002
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx032,rtdx014,rtdx021,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg008,
#                g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
#                g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#           WHERE rtdxent = imaaent AND rtdx001 = imaa001
#             AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#             AND rtdx001 = g_prbg_d[l_ac].prbg002
#         #150312-00002#5 Modify-E    
         #150401-00003#1--mark by dongsz--end---
         #150429-00002#1--mark by dongsz--str---
         #150401-00003#1--add by dongsz--str---
#         SELECT rtdx002,imaa106,oocal003,rtdx035,rtdx032,rtdx041,rtdx042,rtdx014,rtdx021,rtdx022,rtdx023,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
#                g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015,
#                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg016,g_prbg_d[l_ac].prbg017,
#                g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaa_t
#           LEFT OUTER JOIN oocal_t ON imaaent = oocalent AND imaa106 = oocal001 AND oocal002 = g_dlang
#           WHERE rtdxent = imaaent AND rtdx001 = imaa001
#             AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#             AND rtdx001 = g_prbg_d[l_ac].prbg002
         #150401-00003#1--add by dongsz--end---
         #150429-00002#1--mark by dongsz--end---
         #20150923--mark by dongsz--s
#         #150429-00002#1--add by dongsz--str---
#         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
#                rtdx032,rtdx041,rtdx042,imaf113,
#                t2.oocal003,rtdx014,rtdx021,rtdx022,
#                rtdx023,rtdx038,rtdx039,rtdx040
#           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
#                g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg014,g_prbg_d[l_ac].prbg015,g_prbg_d[l_ac].prbg018,
#                g_prbg_d[l_ac].prbg018_desc,g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg016,
#                g_prbg_d[l_ac].prbg017,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,g_prbg_d[l_ac].prbg012
#           FROM rtdx_t,imaf_t
#                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
#                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
#           WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
#             AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
#             AND rtdx001 = g_prbg_d[l_ac].prbg002
#         #150429-00002#1--add by dongsz--end---
         #20150923--mark by dongsz--e
         #20150923--add by dongsz--s
         SELECT rtdx002,imaf144,t1.oocal003,rtdx035,
                rtdx032,rtdx051,imaf113,t2.oocal003,
                rtdx014,rtdx021
           INTO g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,g_prbg_d[l_ac].prbg006,
                g_prbg_d[l_ac].prbg021,g_prbg_d[l_ac].prbg022,g_prbg_d[l_ac].prbg018,g_prbg_d[l_ac].prbg018_desc,
                g_prbg_d[l_ac].prbg008,g_prbg_d[l_ac].prbg023
           FROM rtdx_t,imaf_t
                       LEFT JOIN oocal_t t1 ON imafent = t1.oocalent AND imaf144 = t1.oocal001 AND t1.oocal002 = g_dlang
                       LEFT JOIN oocal_t t2 ON imafent = t2.oocalent AND imaf113 = t2.oocal001 AND t2.oocal002 = g_dlang
          WHERE rtdxent = imafent AND rtdxsite = imafsite AND rtdx001 = imaf001
            AND rtdxent = g_enterprise AND rtdxsite = g_prbf_m.prbfsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002   
         #20150923--add by dongsz--e         
      END IF
      #160506-00009#22--dongsz add--str
      #抓取执行积分单价
      IF g_prbf001 = '2' THEN
         SELECT rtdx101 INTO g_prbg_d[l_ac].prbg025
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      END IF
      IF g_prbf001 = '6' THEN
         SELECT rtdx102 INTO g_prbg_d[l_ac].prbg025
           FROM rtdx_t
          WHERE rtdxent = g_enterprise
            AND rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
      END IF
      #160506-00009#22--dongsz add--end
   END IF
   
   #20151029--dongsz add--str---
   #多条码调价，则抓取件装数不等于1的第一个条码
   IF g_prbf001 = '9' THEN
      LET l_n = 0
      IF NOT cl_null(g_prbg_d[l_ac].prbg003) THEN
         SELECT COUNT(*) INTO l_n FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = g_prbg_d[l_ac].prbg002
            AND imay003 = g_prbg_d[l_ac].prbg003
            AND imay005 <> 1
      END IF
      IF cl_null(g_prbg_d[l_ac].prbg003) OR l_n = 0 THEN
         SELECT imay003 INTO g_prbg_d[l_ac].prbg003
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = g_prbg_d[l_ac].prbg002
            AND imay005 <> 1
            AND ROWNUM = 1
      END IF
      #抓取件装数
      SELECT imay005 INTO g_prbg_d[l_ac].prbg024 FROM imay_t
       WHERE imayent = g_enterprise
         AND imay003 = g_prbg_d[l_ac].prbg003
      #计算执行进价和执行售价
      LET g_prbg_d[l_ac].prbg021 = g_prbg_d[l_ac].prbg021*g_prbg_d[l_ac].prbg024
      LET g_prbg_d[l_ac].prbg023 = g_prbg_d[l_ac].prbg023*g_prbg_d[l_ac].prbg024
   END IF
   #20151029--dongsz add--end---
   
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prbf_m.prbfsite
   SELECT oodbl004 INTO g_prbg_d[l_ac].prbg006_desc FROM oodbl_t
    WHERE oodblent = g_enterprise
      AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbg_d[l_ac].prbg006
      AND oodbl003 = g_dlang
   SELECT oodbl004 INTO g_prbg_d[l_ac].prbg008_desc FROM oodbl_t
    WHERE oodblent = g_enterprise
      AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbg_d[l_ac].prbg008
      AND oodbl003 = g_dlang  
      
   #LET g_prbg_d[l_ac].prbg013 = (g_prbg_d[l_ac].prbg009 - g_prbg_d[l_ac].prbg007)/g_prbg_d[l_ac].prbg009 * 100   #20150923 dongsz mark
   IF g_prbf001 = '6' THEN
      LET g_prbg_d[l_ac].prbg013 = (g_prbg_d[l_ac].prbg009 - g_prbg_d[l_ac].prbg007)/g_prbg_d[l_ac].prbg009 * 100
   END IF
   #150401-00003#1--mark by dongsz--str---
#   LET g_prbg_d[l_ac+1].prbg005 = g_prbg_d[l_ac].prbg005
#   LET g_prbg_d[l_ac+1].prbg005_desc = g_prbg_d[l_ac].prbg005_desc
#   LET g_prbg_d[l_ac+1].prbg006 = g_prbg_d[l_ac].prbg006
#   LET g_prbg_d[l_ac+1].prbg006_desc = g_prbg_d[l_ac].prbg006_desc
#   #LET g_prbg_d[l_ac+1].prbg007 = g_prbg_d[l_ac].prbg007           #150401-00003#1--mark by dongsz
#   LET g_prbg_d[l_ac+1].prbg008 = g_prbg_d[l_ac].prbg008
#   LET g_prbg_d[l_ac+1].prbg008_desc = g_prbg_d[l_ac].prbg008_desc
#   #LET g_prbg_d[l_ac+1].prbg009 = g_prbg_d[l_ac].prbg009           #150401-00003#1--mark by dongsz
#   LET g_prbg_d[l_ac+1].prbg010 = g_prbg_d[l_ac].prbg010
#   LET g_prbg_d[l_ac+1].prbg011 = g_prbg_d[l_ac].prbg011
#   LET g_prbg_d[l_ac+1].prbg012 = g_prbg_d[l_ac].prbg012
#   LET g_prbg_d[l_ac+1].prbg013 = g_prbg_d[l_ac].prbg013
   #150401-00003#1--mark by dongsz--end
   #150401-00003#1--add by dongsz--str---
#   IF g_prbf001 = '2' THEN
#      LET g_prbg_d[l_ac+1].prbg009 = g_prbg_d[l_ac].prbg009
#   END IF
   #150401-00003#1--add by dongsz--end---
                                      
   DISPLAY BY NAME g_prbg_d[l_ac].prbg003,g_prbg_d[l_ac].prbg005,g_prbg_d[l_ac].prbg005_desc,
                   g_prbg_d[l_ac].prbg006,g_prbg_d[l_ac].prbg007,g_prbg_d[l_ac].prbg018,
                   g_prbg_d[l_ac].prbg018_desc,g_prbg_d[l_ac].prbg008,
                   g_prbg_d[l_ac].prbg009,g_prbg_d[l_ac].prbg010,g_prbg_d[l_ac].prbg011,
                   g_prbg_d[l_ac].prbg012
   #20150923--mark by dongsz--s
#   DISPLAY BY NAME g_prbg_d[l_ac+1].prbg005,g_prbg_d[l_ac+1].prbg005_desc,
#                   g_prbg_d[l_ac+1].prbg006,g_prbg_d[l_ac+1].prbg006_desc,
#                   g_prbg_d[l_ac+1].prbg007,g_prbg_d[l_ac+1].prbg018,g_prbg_d[l_ac+1].prbg018_desc,
#                   g_prbg_d[l_ac+1].prbg008,g_prbg_d[l_ac+1].prbg008_desc
   #20150923--mark by dongsz--e
   
   #20150923--mark by dongsz--s
#   LET l_n = 0   
#   SELECT COUNT(*) INTO l_n FROM prbg_t
#    WHERE prbgent = g_enterprise
#      AND prbgdocno = g_prbf_m.prbfdocno 
#      AND prbgseq = g_prbg_d_t.prbgseq
#      AND prbgseq1 = '1'
#   IF l_n > 0 THEN
#      UPDATE prbg_t SET (prbgdocno,prbgunit,prbgseq,prbg001,prbgsite,prbg002,prbg003,prbgseq1, 
#             prbg004,prbg005,prbg006,prbg007,prbg018,prbg008,prbg009,prbg010,prbg011,prbg012,prbg013) = (g_prbf_m.prbfdocno, 
#             g_prbg_d[l_ac].prbgunit,g_prbg_d[l_ac].prbgseq,g_prbg_d[l_ac].prbg001,g_prbg_d[l_ac].prbgsite, 
#             g_prbg_d[l_ac].prbg002,g_prbg_d[l_ac].prbg003,'1',g_prbg_d[l_ac].prbg004, 
#             g_prbg_d[l_ac+1].prbg005,g_prbg_d[l_ac+1].prbg006,g_prbg_d[l_ac+1].prbg007,g_prbg_d[l_ac+1].prbg018,
#             g_prbg_d[l_ac+1].prbg008,g_prbg_d[l_ac+1].prbg009,g_prbg_d[l_ac+1].prbg010,g_prbg_d[l_ac+1].prbg011,
#             g_prbg_d[l_ac+1].prbg012,g_prbg_d[l_ac+1].prbg013)
#       WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno  
#         AND prbgseq = g_prbg_d_t.prbgseq #項次   
#         AND prbgseq1 = '1'
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "prbg_t"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         LET g_prbg_d[l_ac].* = g_prbg_d_t.*
#         CALL s_transaction_end('N','0')
#      END IF
#   END IF
   #20150923--mark by dongsz--e   
   
END FUNCTION

################################################################################
# Descriptions...: 清空說明欄位
# Memo...........:
# Usage..........: CALL aprt111_prbg002_init()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_prbg002_init()
LET g_prbg_d[l_ac].prbg002_desc = ""
LET g_prbg_d[l_ac].prbg002_desc_desc = ""
LET g_prbg_d[l_ac].prbg002_desc_desc_desc = ""
LET g_prbg_d[l_ac].rtaxl003 = ""
END FUNCTION

################################################################################
# Descriptions...: 商品編號檢查
# Memo...........:
# Usage..........: CALL aprt111_prbg002_chk()
#                : 150401-00003#1 add
# Date & Author..: 20150413 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_prbg002_chk()
DEFINE l_n        LIKE type_t.num5
DEFINE l_rtax004  LIKE rtax_t.rtax004     #20150924 dongsz add
DEFINE l_imaa108  LIKE imaa_t.imaa108     #20150819--add by dongsz

   IF NOT cl_null(g_prbg_d[l_ac].prbgsite) THEN
      #20150924--mark by dongsz--s
#      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#      INITIALIZE g_chkparam.* TO NULL
#      
#      #設定g_chkparam.*的參數
#      LET g_chkparam.arg1 = g_prbg_d[l_ac].prbg002
#      LET g_chkparam.arg2 = g_prbg_d[l_ac].prbgsite
#      LET g_chkparam.arg3 = g_prbf_m.prbf005
#      LET g_chkparam.arg4 = g_prbf_m.prbf004
#      
#	   IF g_prbg_d[l_ac].prbg001 = '1' THEN
#	      IF NOT cl_null(g_prbf_m.prbf005) THEN
#	         IF cl_chk_exist("v_rtdx001_3") THEN
#               #檢查成功時後續處理
#               #LET  = g_chkparam.return1
#               #DISPLAY BY NAME 
#            ELSE
#               #檢查失敗時後續處理
#               RETURN FALSE
#            END IF
#         ELSE                  
#            IF cl_chk_exist("v_rtdx001_5") THEN
#               #檢查成功時後續處理
#               #LET  = g_chkparam.return1
#               #DISPLAY BY NAME 
#            ELSE
#               #檢查失敗時後續處理
#               RETURN FALSE
#            END IF
#         END IF
#      END IF
#      IF g_prbg_d[l_ac].prbg001 = '2' THEN
#         IF NOT cl_null(g_prbf_m.prbf005) THEN
#            IF cl_chk_exist("v_rtdx001_2") THEN
#               #檢查成功時後續處理
#               #LET  = g_chkparam.return1
#               #DISPLAY BY NAME 
#            ELSE
#               #檢查失敗時後續處理
#               RETURN FALSE
#            END IF
#         ELSE
#            IF cl_chk_exist("v_rtdx001_4") THEN
#               #檢查成功時後續處理
#               #LET  = g_chkparam.return1
#               #DISPLAY BY NAME 
#            ELSE
#               #檢查失敗時後續處理
#               RETURN FALSE
#            END IF
#         END IF
#      END IF
      #20150924--mark by dongsz--s
      
      #20150924--add by dongsz--s
      LET l_rtax004=cl_get_para(g_enterprise,g_site,'E-CIR-0001')
      IF g_prbg_d[l_ac].prbg001 = '2' THEN
         LET g_cnt = 0
         SELECT COUNT(*) INTO g_cnt FROM rtdx_t
          WHERE rtdxsite = g_prbg_d[l_ac].prbgsite
            AND rtdx001 = g_prbg_d[l_ac].prbg002
            AND rtdxent = g_enterprise
            AND rtdxstus = 'Y'
         IF g_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'art-00156'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
         
         IF g_prbf_m.prbf001='1' OR g_prbf_m.prbf001='3' OR              #aprt114和116抓采购协议的商品
            ((g_prbf_m.prbf001='2' OR g_prbf_m.prbf001='6' OR g_prbf_m.prbf001='7' OR g_prbf_m.prbf001='8') AND NOT cl_null(g_prbf_m.prbf004))THEN  #aprt115和117如果供应商不为空也抓采购协议的商品
            LET g_cnt = 0
            SELECT COUNT(*) INTO g_cnt
              FROM stas_t,star_t
             WHERE stasent=starent AND stas001=star001 AND stassite=starsite
               AND stasent = g_enterprise
               AND g_prbf_m.prbfdocdt BETWEEN stas018 AND stas019
               AND star003 = g_prbf_m.prbf004
               AND stas003 = g_prbg_d[l_ac].prbg002
               AND stassite = g_prbg_d[l_ac].prbgsite
            IF g_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00010'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
      ELSE
         LET g_cnt = 0
         SELECT COUNT(*) INTO g_cnt FROM rtdx_t
          WHERE rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
            AND rtdx001 = g_prbg_d[l_ac].prbg002
            AND rtdxent = g_enterprise
            AND rtdxstus = 'Y'
         IF g_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'art-00156'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
         IF g_prbf_m.prbf001='1' OR g_prbf_m.prbf001='3' OR              #aprt114和116抓采购协议的商品
                  ((g_prbf_m.prbf001='2' OR g_prbf_m.prbf001='6' OR g_prbf_m.prbf001='7' OR g_prbf_m.prbf001='8') AND NOT cl_null(g_prbf_m.prbf004))THEN  #aprt115和117如果供应商不为空也抓采购协议的商品
            LET g_cnt = 0
            SELECT COUNT(*) INTO g_cnt
              FROM stas_t,star_t
             WHERE stasent=starent AND stas001=star001 AND stassite=starsite
               AND stasent = g_enterprise
               AND g_prbf_m.prbfdocdt BETWEEN stas018 AND stas019
               AND star003 = g_prbf_m.prbf004
               AND stas003 = g_prbg_d[l_ac].prbg002
               AND rtdxsite IN (SELECT rtab002 FROM rtab_t WHERE rtabent = g_enterprise AND rtab001 = g_prbg_d[l_ac].prbgsite)
            IF g_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apr-00010'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         END IF
      END IF
      #20151105--dongsz add--str---
      #多条码商品
      LET l_n = 0
      IF g_prbf001 = '9' THEN
         SELECT COUNT(*) INTO l_n FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = g_prbg_d[l_ac].prbg002
            AND imay005 <> 1
         IF l_n < 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apr-00481'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      #20151105--dongsz add--end---
      IF NOT cl_null(g_prbf_m.prbf005) THEN  #品类不为空，按照管理品类抓商品
         LET g_cnt = 0
         SELECT COUNT(*) INTO g_cnt FROM imaa_t
          WHERE imaa001=g_prbg_d[l_ac].prbg002
            AND imaaent = g_enterprise
            AND EXISTS (SELECT 1 FROM rtaw_t,rtax_t
                         WHERE rtawent = imaaent AND rtawent = rtaxent AND rtaw001 = rtax001
                           AND rtax004=l_rtax004
                           AND rtaw001=g_prbf_m.prbf005
                           AND rtaw002 = imaa009)
         IF g_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apr-00009'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
      #20150924--add by dongsz--e
      
      #檢查重複
      IF g_prbg_d[l_ac].prbg002 <> g_prbg_d_t.prbg002 OR cl_null(g_prbg_d_t.prbg002) THEN 
         IF g_prbg_d[l_ac].prbg001 = '2' THEN
            LET l_n = 0
            #20151109--dongsz mark--str---
#            SELECT COUNT(*) INTO l_n FROM prbg_t
#             WHERE g_prbg_d[l_ac].prbgsite IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
#                                  FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
#                                 WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
            #20151109--dongsz mark--end---
            #20151109--dongsz add--str---
            IF g_prbf001 <> '9' THEN
               SELECT COUNT(*) INTO l_n FROM prbg_t
                WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgsite = g_prbg_d[l_ac].prbgsite AND prbg002 = g_prbg_d[l_ac].prbg002
                  AND prbgseq <> g_prbg_d[l_ac].prbgseq
            ELSE
               SELECT COUNT(*) INTO l_n FROM prbg_t
                WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno
                  AND prbgsite = g_prbg_d[l_ac].prbgsite AND prbg003 = g_prbg_d[l_ac].prbg003
                  AND prbgseq <> g_prbg_d[l_ac].prbgseq
            END IF
            #20151109--dongsz add--end---
            IF l_n > 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00123'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN FALSE
            END IF
         END IF
#         IF g_prbg_d[l_ac].prbg001 = '1' THEN
#            LET l_n = 0
#            SELECT COUNT(*) INTO l_n FROM rtab_t
#             WHERE rtabent = g_enterprise
#               AND rtab001 = g_prbg_d[l_ac].prbgsite
#               AND rtab002 IN (SELECT DISTINCT (CASE prbg001 WHEN '2' THEN prbgsite ELSE rtab002 END ) 
#                                FROM prbg_t LEFT OUTER JOIN rtab_t ON prbgent = rtabent AND prbgsite = rtab001
#                               WHERE prbgent = g_enterprise AND prbgdocno = g_prbf_m.prbfdocno AND prbgseq <> g_prbg_d[l_ac].prbgseq AND prbg002 = g_prbg_d[l_ac].prbg002)
#            IF l_n > 0 THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 'apr-00124'
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               RETURN FALSE
#            END IF
#         END IF
      END IF
   END IF
   
   #20150819--add by dongsz--s
   #控管一般调价不能调生鲜商品
   SELECT imaa108 INTO l_imaa108
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_prbg_d[l_ac].prbg002
   IF l_imaa108 = '3' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apr-00476'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
    
      RETURN FALSE
   END IF
   #20150819--add by dongsz--e
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 进价相关栏位必输
# Memo...........:
# Usage..........: CALL aprt111_prbg_required_1()
# Date & Author..: 20150427 By dongsz  #150401-00003#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_prbg_required_1()
DEFINE l_ooef019      LIKE ooef_t.ooef019

   #IF cl_null(g_prbg_d[l_ac].prbg005) AND cl_null(g_prbg_d[l_ac].prbg006) AND cl_null(g_prbg_d[l_ac].prbg007)    #20150923 mark by dongsz
   IF cl_null(g_prbg_d[l_ac].prbg007) THEN      #20150923 add by dongsz
      #AND (g_prbf001 <> '3' OR (g_prbf001 = '3' AND cl_null(g_prbg_d[l_ac].prbg014) AND cl_null(g_prbg_d[l_ac].prbg015))) THEN
      #CALL cl_set_comp_required("prbg005,prbg006,prbg007,prbg014,prbg015",FALSE)
      CALL cl_set_comp_required("prbg007",FALSE)
      LET g_flag1 = 'N'
      IF g_prbf001 = '1' THEN
         #CALL cl_set_comp_required("prbg005,prbg006,prbg007",TRUE)
         CALL cl_set_comp_required("prbg007",TRUE)
      END IF
   ELSE
      #CALL cl_set_comp_required("prbg005,prbg006,prbg007",TRUE)
      CALL cl_set_comp_required("prbg007",TRUE)
      #IF g_prbf001 = '3' THEN
      #   CALL cl_set_comp_required("prbg014,prbg015",TRUE)
      #END IF
      IF g_flag1 = 'N' AND g_prbf001 <> '2' THEN
         #20150923--mark by dongsz--s
#         IF cl_null(g_prbg_d[l_ac].prbg005) THEN
#            LET g_prbg_d[l_ac].prbg005 = g_prbg_d[l_ac-1].prbg005
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg006) THEN
#            LET g_prbg_d[l_ac].prbg006 = g_prbg_d[l_ac-1].prbg006
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg007) THEN
#            LET g_prbg_d[l_ac].prbg007 = g_prbg_d[l_ac-1].prbg007
#         END IF
         #20150923--mark by dongsz--e
         LET g_flag1 = 'Y'
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prbg_d[l_ac].prbg005
         CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prbg_d[l_ac].prbg005_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prbg_d[l_ac].prbg005_desc
         
         SELECT ooef019 INTO l_ooef019 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_prbf_m.prbfsite
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_ooef019
         LET g_ref_fields[2] = g_prbg_d[l_ac].prbg006
         CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prbg_d[l_ac].prbg006_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prbg_d[l_ac].prbg006_desc
      END IF
   END IF

END FUNCTION

################################################################################
# Descriptions...: 售价相关栏位必输
# Memo...........:
# Usage..........: CALL aprt111_prbg_required_2()
# Date & Author..: 20150427 By dongsz   #150401-00003#1
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_prbg_required_2()
DEFINE l_ooef019      LIKE ooef_t.ooef019

   #IF cl_null(g_prbg_d[l_ac].prbg018) AND cl_null(g_prbg_d[l_ac].prbg008) AND cl_null(g_prbg_d[l_ac].prbg009) AND    #20150923 mark by dongsz
   IF cl_null(g_prbg_d[l_ac].prbg009) AND        #20150923 add by dongsz
      cl_null(g_prbg_d[l_ac].prbg010) AND cl_null(g_prbg_d[l_ac].prbg011) AND cl_null(g_prbg_d[l_ac].prbg012) THEN
      #(g_prbf001 <> '3' OR (g_prbf001 = '3' AND cl_null(g_prbg_d[l_ac].prbg016) AND cl_null(g_prbg_d[l_ac].prbg017))) THEN
      LET g_flag2 = 'N'
      #CALL cl_set_comp_required("prbg018,prbg008,prbg009,prbg010,prbg011,prbg012,prbg016,prbg017",FALSE)
      CALL cl_set_comp_required("prbg009,prbg010,prbg011,prbg012",FALSE)
      CALL cl_set_comp_required("prbg026",FALSE)    #160506-00009#22 dongsz add
      IF g_prbf001 = '2' OR g_prbf001 = '6' OR g_prbf001 = '9' THEN
         #CALL cl_set_comp_required("prbg018,prbg008,prbg009,prbg010,prbg011,prbg012",TRUE)
         CALL cl_set_comp_required("prbg009,prbg010,prbg011,prbg012",TRUE)
      END IF
      IF g_prbf001 = '7' THEN
         CALL cl_set_comp_required("prbg009",TRUE)
      END IF
      IF g_prbf001 = '8' THEN
         CALL cl_set_comp_required("prbg010,prbg011,prbg012",TRUE)
      END IF
      #160506-00009#22--dongsz add--str
      IF g_prbf001 = '2' OR g_prbf001 = '6' THEN
         CALL cl_set_comp_required("prbg026",TRUE)
      END IF
      #160506-00009#22--dongsz add--end
   ELSE
      #CALL cl_set_comp_required("prbg018,prbg008,prbg009,prbg010,prbg011,prbg012",TRUE)
      IF g_prbf001 = '2' OR g_prbf001 = '6' OR g_prbf001 = '9' THEN
         CALL cl_set_comp_required("prbg009,prbg010,prbg011,prbg012",TRUE)
      END IF
      IF g_prbf001 = '7' THEN
         CALL cl_set_comp_required("prbg009",TRUE)
      END IF
      IF g_prbf001 = '8' THEN
         CALL cl_set_comp_required("prbg010,prbg011,prbg012",TRUE)
      END IF
      #160506-00009#22--dongsz add--str
      IF g_prbf001 = '2' OR g_prbf001 = '6' THEN
         CALL cl_set_comp_required("prbg026",TRUE)
      END IF
      #160506-00009#22--dongsz add--end
      #CALL cl_set_comp_required("prbg009,prbg010,prbg011,prbg012",TRUE)
      #IF g_prbf001 = '3' THEN
      #   CALL cl_set_comp_required("prbg016,prbg017",TRUE)
      #END IF
      IF g_flag2 = 'N' THEN
         #20150923--mark by dongsz--s
#         IF cl_null(g_prbg_d[l_ac].prbg018) THEN
#            LET g_prbg_d[l_ac].prbg018 = g_prbg_d[l_ac-1].prbg018
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg008) THEN
#            LET g_prbg_d[l_ac].prbg008 = g_prbg_d[l_ac-1].prbg008
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg009) THEN
#            LET g_prbg_d[l_ac].prbg009 = g_prbg_d[l_ac-1].prbg009
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg010) THEN
#            LET g_prbg_d[l_ac].prbg010 = g_prbg_d[l_ac-1].prbg010
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg011) THEN
#            LET g_prbg_d[l_ac].prbg011 = g_prbg_d[l_ac-1].prbg011
#         END IF
#         IF cl_null(g_prbg_d[l_ac].prbg012) THEN
#            LET g_prbg_d[l_ac].prbg012 = g_prbg_d[l_ac-1].prbg012
#         END IF
         #20150923--mark by dongsz--e
         LET g_flag2 = 'Y'
         
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_prbg_d[l_ac].prbg018
         CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prbg_d[l_ac].prbg018_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prbg_d[l_ac].prbg018_desc
         
         SELECT ooef019 INTO l_ooef019 FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_prbf_m.prbfsite
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = l_ooef019
         LET g_ref_fields[2] = g_prbg_d[l_ac].prbg008
         CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_prbg_d[l_ac].prbg008_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_prbg_d[l_ac].prbg008_desc
      END IF
   END IF

END FUNCTION

################################################################################
# Descriptions...: 选择调整则单头单身资料产生库存补差单并审核
# Memo...........:
# Date & Author..: 2015/10/22 By guomy
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_ins_prga(p_prbfdocno)
#161111-00028#2--modify----begin--------
#DEFINE l_prbf   RECORD LIKE prbf_t.*
#DEFINE l_prga   RECORD LIKE prga_t.*
#DEFINE l_prgb   RECORD LIKE prgb_t.*
#DEFINE l_prbg   RECORD LIKE prbg_t.*   
DEFINE l_prbf RECORD  #標準調價單資料表
       prbfent LIKE prbf_t.prbfent, #企業編號
       prbfunit LIKE prbf_t.prbfunit, #應用組織
       prbfsite LIKE prbf_t.prbfsite, #營運據點
       prbfdocno LIKE prbf_t.prbfdocno, #單據編號
       prbfdocdt LIKE prbf_t.prbfdocdt, #單據日期
       prbf001 LIKE prbf_t.prbf001, #單據類型
       prbf002 LIKE prbf_t.prbf002, #資料來源
       prbf003 LIKE prbf_t.prbf003, #來源單號
       prbf004 LIKE prbf_t.prbf004, #供應商編號
       prbf005 LIKE prbf_t.prbf005, #管理品類
       prbf006 LIKE prbf_t.prbf006, #開始日期
       prbf007 LIKE prbf_t.prbf007, #結束日期
       prbf008 LIKE prbf_t.prbf008, #no use
       prbf009 LIKE prbf_t.prbf009, #no use
       prbf010 LIKE prbf_t.prbf010, #人員
       prbf011 LIKE prbf_t.prbf011, #部門
       prbf012 LIKE prbf_t.prbf012, #備註
       prbfownid LIKE prbf_t.prbfownid, #資料所有者
       prbfowndp LIKE prbf_t.prbfowndp, #資料所屬部門
       prbfcrtid LIKE prbf_t.prbfcrtid, #資料建立者
       prbfcrtdp LIKE prbf_t.prbfcrtdp, #資料建立部門
       prbfcrtdt LIKE prbf_t.prbfcrtdt, #資料創建日
       prbfmodid LIKE prbf_t.prbfmodid, #資料修改者
       prbfmoddt LIKE prbf_t.prbfmoddt, #最近修改日
       prbfcnfid LIKE prbf_t.prbfcnfid, #資料確認者
       prbfcnfdt LIKE prbf_t.prbfcnfdt, #資料確認日
       prbfstus LIKE prbf_t.prbfstus, #狀態碼
       prbf013 LIKE prbf_t.prbf013 #活動類型
       END RECORD
DEFINE l_prbg RECORD  #標準調價單明細資料表
       prbgent LIKE prbg_t.prbgent, #企業編號
       prbgunit LIKE prbg_t.prbgunit, #應用組織
       prbgsite LIKE prbg_t.prbgsite, #營運據點
       prbgdocno LIKE prbg_t.prbgdocno, #單據編號
       prbgseq LIKE prbg_t.prbgseq, #項次
       prbgseq1 LIKE prbg_t.prbgseq1, #序號
       prbg001 LIKE prbg_t.prbg001, #組織類型
       prbg002 LIKE prbg_t.prbg002, #商品編號
       prbg003 LIKE prbg_t.prbg003, #商品主條碼
       prbg004 LIKE prbg_t.prbg004, #商品特征
       prbg005 LIKE prbg_t.prbg005, #採購計價單位
       prbg006 LIKE prbg_t.prbg006, #進項稅別
       prbg007 LIKE prbg_t.prbg007, #進價
       prbg008 LIKE prbg_t.prbg008, #銷項稅別
       prbg009 LIKE prbg_t.prbg009, #售價
       prbg010 LIKE prbg_t.prbg010, #會員價1
       prbg011 LIKE prbg_t.prbg011, #會員價2
       prbg012 LIKE prbg_t.prbg012, #會員價3
       prbg013 LIKE prbg_t.prbg013, #毛利率
       prbg014 LIKE prbg_t.prbg014, #進價開始日期
       prbg015 LIKE prbg_t.prbg015, #進價截止日期
       prbg016 LIKE prbg_t.prbg016, #售價開始日期
       prbg017 LIKE prbg_t.prbg017, #售價截止日期
       prbg018 LIKE prbg_t.prbg018, #銷售計價單位
       prbg019 LIKE prbg_t.prbg019, #會員價開始日期
       prbg020 LIKE prbg_t.prbg020, #會員價截止日期
       prbg021 LIKE prbg_t.prbg021, #最新進價
       prbg022 LIKE prbg_t.prbg022, #最近入庫進價
       prbg023 LIKE prbg_t.prbg023, #執行售價
       prbg024 LIKE prbg_t.prbg024, #件裝數
       prbg025 LIKE prbg_t.prbg025, #執行積分單價
       prbg026 LIKE prbg_t.prbg026  #積分單價
       END RECORD
DEFINE l_prga RECORD  #補差調整資料表
       prgaent LIKE prga_t.prgaent, #企業編號
       prgaunit LIKE prga_t.prgaunit, #應用組織
       prgasite LIKE prga_t.prgasite, #營運據點
       prgadocno LIKE prga_t.prgadocno, #單據編號
       prgadocdt LIKE prga_t.prgadocdt, #單據日期
       prga001 LIKE prga_t.prga001, #補差類型
       prga002 LIKE prga_t.prga002, #來源類型
       prga003 LIKE prga_t.prga003, #來源單號
       prga004 LIKE prga_t.prga004, #合約編號
       prga005 LIKE prga_t.prga005, #對象類型
       prga006 LIKE prga_t.prga006, #供應商編號/經銷商編號
       prga007 LIKE prga_t.prga007, #業務人員
       prga008 LIKE prga_t.prga008, #部門編號
       prga009 LIKE prga_t.prga009, #開始日期
       prga010 LIKE prga_t.prga010, #結束日期
       prga011 LIKE prga_t.prga011, #幣別
       prga012 LIKE prga_t.prga012, #稅別
       prgastus LIKE prga_t.prgastus, #狀態碼
       prgaownid LIKE prga_t.prgaownid, #資料所有者
       prgaowndp LIKE prga_t.prgaowndp, #資料所屬部門
       prgacrtid LIKE prga_t.prgacrtid, #資料建立者
       prgacrtdp LIKE prga_t.prgacrtdp, #資料建立部門
       prgacrtdt LIKE prga_t.prgacrtdt, #資料創建日
       prgamodid LIKE prga_t.prgamodid, #資料修改者
       prgamoddt LIKE prga_t.prgamoddt, #最近修改日
       prgacnfid LIKE prga_t.prgacnfid, #資料確認者
       prgacnfdt LIKE prga_t.prgacnfdt, #資料確認日
       prga013 LIKE prga_t.prga013, #補差方式
       prga014 LIKE prga_t.prga014, #承擔比例
       prga015 LIKE prga_t.prga015, #管理品類
       prga016 LIKE prga_t.prga016 #已計算補差
       END RECORD
       
DEFINE l_prgb RECORD  #補差調整明細表
       prgbent LIKE prgb_t.prgbent, #企業編號
       prgbunit LIKE prgb_t.prgbunit, #應用組織
       prgbsite LIKE prgb_t.prgbsite, #營運據點
       prgbdocno LIKE prgb_t.prgbdocno, #單據編號
       prgbseq LIKE prgb_t.prgbseq, #項次
       prgb001 LIKE prgb_t.prgb001, #補差類型
       prgb002 LIKE prgb_t.prgb002, #來源類型
       prgb003 LIKE prgb_t.prgb003, #來源單號
       prgb004 LIKE prgb_t.prgb004, #來源項次
       prgb005 LIKE prgb_t.prgb005, #對象類型
       prgb006 LIKE prgb_t.prgb006, #供應商/經銷商
       prgb007 LIKE prgb_t.prgb007, #網點編號
       prgb008 LIKE prgb_t.prgb008, #商品編號
       prgb009 LIKE prgb_t.prgb009, #商品條碼
       prgb010 LIKE prgb_t.prgb010, #商品特征
       prgb011 LIKE prgb_t.prgb011, #幣別
       prgb012 LIKE prgb_t.prgb012, #稅別
       prgb013 LIKE prgb_t.prgb013, #單位編號
       prgb014 LIKE prgb_t.prgb014, #數量
       prgb015 LIKE prgb_t.prgb015, #原價格
       prgb016 LIKE prgb_t.prgb016, #本次價格
       prgb017 LIKE prgb_t.prgb017, #本次補差
       prgb018 LIKE prgb_t.prgb018, #補差金額
       prgb019 LIKE prgb_t.prgb019, #起始日期
       prgb020 LIKE prgb_t.prgb020, #截止日期
       prgb021 LIKE prgb_t.prgb021, #結算會計期
       prgb022 LIKE prgb_t.prgb022, #合約編號
       prgb023 LIKE prgb_t.prgb023, #經營方式
       prgb024 LIKE prgb_t.prgb024, #結算方式
       prgb025 LIKE prgb_t.prgb025, #結算類型
       prgb026 LIKE prgb_t.prgb026, #結算中心
       prgb027 LIKE prgb_t.prgb027, #促銷方案
       prgb028 LIKE prgb_t.prgb028, #銷售範圍
       prgb029 LIKE prgb_t.prgb029, #銷售組織
       prgb030 LIKE prgb_t.prgb030, #銷售渠道
       prgb031 LIKE prgb_t.prgb031, #產品組
       prgb032 LIKE prgb_t.prgb032, #辦事處
       prgb033 LIKE prgb_t.prgb033, #備註
       prgb034 LIKE prgb_t.prgb034, #毛利率
       prgb035 LIKE prgb_t.prgb035  #承擔比例%
       END RECORD
#161111-00028#2--modify----end--------
DEFINE p_prbfdocno  LIKE prbf_t.prbfdocno  
DEFINE r_stau004      LIKE stau_t.stau004
DEFINE r_period       LIKE type_t.num5 
DEFINE r_period2      LIKE type_t.num5    
DEFINE l_insert      LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
DEFINE r_doctype     LIKE rtai_t.rtai004
DEFINE r_prgb014   LIKE prgb_t.prgb014
DEFINE r_prgb018   LIKE prgb_t.prgb018   
DEFINE l_stan002      LIKE stan_t.stan002
DEFINE l_stan009      LIKE stan_t.stan009
DEFINE l_stan010      LIKE stan_t.stan010
DEFINE l_stan015      LIKE stan_t.stan015   
DEFINE l_n           LIKE type_t.num5
DEFINE l_prga002     LIKE prga_t.prga002
DEFINE l_prga004     LIKE prga_t.prga004   
DEFINE l_sql         STRING 
DEFINE r_sql         STRING 
DEFINE l_msg         STRING
DEFINE l_prog       LIKE type_t.chr100 
DEFINE l_flag       LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num10  
DEFINE l_success1   LIKE type_t.chr10
DEFINE l_prgadocno LIKE prga_t.prgadocno
   
   INITIALIZE l_prbf.* TO NULL
   INITIALIZE l_prga.* TO NULL
   INITIALIZE l_prbg.* TO NULL
   INITIALIZE l_prgb.* TO NULL
   LET g_prgatype = 'Y'

   
   #SELECT * INTO l_prbf.*    #161111-00028#2--mark
   #161111-00028#2--add----begin-----------
   SELECT prbfent,prbfunit,prbfsite,prbfdocno,prbfdocdt,prbf001,prbf002,prbf003,prbf004,prbf005,
          prbf006,prbf007,prbf008,prbf009,prbf010,prbf011,prbf012,prbfownid,prbfowndp,prbfcrtid,
          prbfcrtdp,prbfcrtdt,prbfmodid,prbfmoddt,prbfcnfid,prbfcnfdt,prbfstus,prbf013 INTO l_prbf.*
   #161111-00028#2--add----end-------------
     FROM prbf_t
    WHERE prbfent = g_enterprise
      AND prbfdocno = p_prbfdocno

      #来源类型prga002：g_prog='aprt111':5,g_prog='aprt113':6	
      #IF g_prog='aprt111' THEN          #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt111' THEN   #160705-00042#10 160713 by sakura add
         LET l_prga002 = '5'
      END IF 
      #IF g_prog='aprt113' THEN          #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt113' THEN   #160705-00042#10 160713 by sakura add
         LET l_prga002 = '6'
      END IF        											
      #检查供应商合约
      SELECT COUNT(*) INTO l_n
        FROM stan_t
       WHERE stanent = l_prbf.prbfent
         AND stan005 = l_prbf.prbf004
         AND stanstus = 'Y'
      IF l_n = 1 THEN  #必须取出合约号      
         SELECT stan001 INTO l_prga004
           FROM stan_t
          WHERE stanent = g_enterprise
            AND stan005 = l_prbf.prbf004
            AND stanstus = 'Y'       
      ELSE 
         SELECT stan001 INTO l_prga004
           FROM stan_t
          WHERE stanent = g_enterprise
            AND stan005 = l_prbf.prbf004
            AND stanstus = 'Y'
            AND stan029 = (SELECT max(stan029) 
                             FROM stan_t 
                            WHERE stanent = g_enterprise 
                              AND stan005 = l_prbf.prbf004
                              AND stanstus = 'Y'  
                              AND stan029 in ('2','3','4'))
      END IF              
      LET  l_prga.prgaent	  = l_prbf.prbfent       #企业编号		
#      LET  l_prga.prgaunit  = l_prbf.prbfunit       #应用组织		
#      LET  l_prga.prgasite	 = l_prbf.prbfsite       #营运据点		
   #	LET  l_prga.prgadocno	= ''                  #单据编号		
      LET  l_prga.prgadocdt	= g_today             #单据日期		
      LET  l_prga.prga001	  =  '2'                 #补差类型	?? 6730	
      LET  l_prga.prga002	  = l_prga002            #来源类型	g_prog='aprt114':5,g_prog='aprt116':6	
      LET  l_prga.prga003	  = l_prbf.prbfdocno     #来源单号		
      LET  l_prga.prga004	  = l_prga004            #合约编号		
      LET  l_prga.prga005	  = '0'                  #对象类型		
      LET  l_prga.prga006	  = l_prbf.prbf004       #供应商编号/经销商编号			
      LET  l_prga.prga007	  = g_user               #业务人员			
      LET  l_prga.prga008	  = g_dept               #部门编号			
      LET  l_prga.prga009	  = g_today              #开始日期		
      LET  l_prga.prga010	  = g_today              #结束日期		
      LET  l_prga.prga011	  = ''                   #币别					
      LET  l_prga.prga012	  = ''                   #税别		
      LET  l_prga.prgastus	= 'N'                    #状态码				
      LET  l_prga.prgaownid	= g_user              #资料所有者		
      LET  l_prga.prgaowndp	= g_dept              #资料所有部门		
      LET  l_prga.prgacrtid	= g_user              #资料建立者		
      LET  l_prga.prgacrtdp	= g_dept              #资料建立部门		
      LET  l_prga.prgacrtdt	= cl_get_current()    #资料创建日		
      LET  l_prga.prgamodid	= g_user              #资料修改者		
      LET  l_prga.prgamoddt	= cl_get_current()    #最近修改日		
      LET  l_prga.prgacnfid = ''                    #资料确认者		
      LET  l_prga.prgacnfdt = ''                    #数据确认日		
      LET  l_prga.prga013	  = '2'                  #补差方式		
      LET  l_prga.prga014	  = '100'                #承担比例		
      LET  l_prga.prga015	  = l_prbf.prbf005       #管理品类   
      LET  l_prga.prga016    = 'N'                  #已计算补差  #151013-00001#43--dongsz add      
            
      SELECT stan006,stan007
        INTO l_prga.prga011,l_prga.prga012
        FROM stan_t
       WHERE stanent = g_enterprise
         AND stan001 = l_prga004
         
##库存补差要按门店拆单----存在预调清单的门店为生效门店依据-start-----------------------------------------
   LET r_sql = " SELECT DISTINCT prbwsite   
                   FROM prbw_t,prbf_t 
                  WHERE prbwent =prbfent AND prbfdocno = prbwdocno
                    AND prbwdocno = '",p_prbfdocno,"' 
                    AND prbwent = ",g_enterprise
   PREPARE aprt111_sel FROM r_sql
   DECLARE aprt111_cs CURSOR FOR aprt111_sel 

   FOREACH aprt111_cs INTO l_prbf.prbfsite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach aprt111_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N'
         RETURN '',''
      END IF      
       #預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      LET l_prog ='aprt602' 
      CALL s_aooi200_gen_docno(l_prbf.prbfsite,'R602',g_today,l_prog) 
         RETURNING l_flag,l_prga.prgadocno
      IF NOT l_flag THEN    
         RETURN
      END IF 
      
      LET g_prgadocno = l_prga.prgadocno        
      LET l_prga.prgasite = l_prbf.prbfsite       #营运据点
      LET l_prga.prgaunit = l_prga.prgasite       #应用组织
      
    # INSERT INTO prga_t VALUES(l_prga.*) #161111-00028#2--mark
      #161111-00028#2-add--begin------------
      INSERT INTO prga_t (prgaent,prgaunit,prgasite,prgadocno,prgadocdt,prga001,prga002,prga003,prga004,prga005,prga006,
                          prga007,prga008,prga009,prga010,prga011,prga012,prgastus,prgaownid,prgaowndp,prgacrtid,prgacrtdp,
                          prgacrtdt,prgamodid,prgamoddt,prgacnfid,prgacnfdt,prga013,prga014,prga015,prga016)
      VALUES (l_prga.prgaent,l_prga.prgaunit,l_prga.prgasite,l_prga.prgadocno,l_prga.prgadocdt,l_prga.prga001,l_prga.prga002,l_prga.prga003,l_prga.prga004,l_prga.prga005,l_prga.prga006,
                          l_prga.prga007,l_prga.prga008,l_prga.prga009,l_prga.prga010,l_prga.prga011,l_prga.prga012,l_prga.prgastus,l_prga.prgaownid,l_prga.prgaowndp,l_prga.prgacrtid,l_prga.prgacrtdp,
                          l_prga.prgacrtdt,l_prga.prgamodid,l_prga.prgamoddt,l_prga.prgacnfid,l_prga.prgacnfdt,l_prga.prga013,l_prga.prga014,l_prga.prga015,l_prga.prga016)
      #161111-00028#2-add--end--------------                    
      
      IF SQLCA.sqlcode THEN  
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "写入数据库失败 " 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         LET g_success = 'N'         
         RETURN
      END IF 
   END FOREACH
##库存补差要按门店拆单---------------------end-----------------------------------------
    


   #此时已经按照多门店拆单成每一个生效门店会有一张补差单------

   LET l_sql=" SELECT prbgent, prgaunit, prgasite, prgadocno, prbgseq, prga001, prga002, prga003,
                      prbgseq1,'0',      prga006,  '',        prbg002, prbg003, prbg004, prga011,
                      prga012, '',       '',       '',        prbg007,      '',      '',      prga009,
                      prga010, '',       prga004,  '',        '',      '',      '',      '',
                      '',      '',       '',       '',        '',      '',      '',      ''   
                 FROM prga_t,prbg_t 
                WHERE prgaent=prbgent AND prga003 = prbgdocno
                  AND prbgseq1 = '1'
                  AND prbgent = '",l_prbf.prbfent,"'  
                  AND prbgdocno = '",l_prbf.prbfdocno,"' "
  #                AND prgadocno ='",l_prga.prgadocno,"'  "


   PREPARE prbg_prepare FROM l_sql
   DECLARE prbg_curs CURSOR FOR prbg_prepare

 
   FOREACH prbg_curs INTO l_prgb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF

	   #prgb013	     #单位编号				
      SELECT imaa106
        INTO l_prgb.prgb013
        FROM imaa_t 
       WHERE imaaent = g_enterprise
         AND imaa001 = l_prgb.prgb008											
     
     #計算結算會計期
      SELECT stan002,stan009,stan010,stan015
        INTO l_stan002,l_stan009,l_stan010,l_stan015
        FROM stan_t
       WHERE stanent = g_enterprise
         AND stan001 = l_prga.prga004
      LET l_prgb.prgb026 = l_stan015
      LET l_prgb.prgb023 = l_stan002
      LET l_prgb.prgb024 = l_stan009
      LET l_prgb.prgb025 = l_stan010
      LET l_prgb.prgb035 = '100'      

      #計算結算會計期
      CALL s_asti206_get_period(l_prga.prga009,l_prga.prga010,l_prgb.prgb026,g_prog)
         RETURNING r_success,r_stau004,r_period,r_period2
      IF NOT r_success THEN
         RETURN FALSE
      ELSE
         LET l_prgb.prgb021 = r_stau004
      END IF
      	
      IF l_prga.prga013 = '1' THEN 
         LET l_prgb.prgb015 = ''
         LET l_prgb.prgb016 = '' 
      END IF 
      IF NOT cl_null(l_prgb.prgb015) AND NOT cl_null(l_prgb.prgb016) THEN
        LET l_prgb.prgb017 = l_prgb.prgb015 - l_prgb.prgb016
      END IF         
      #抓取补差资料明细并回传补差数量
      CALL aprt111_ins_prgc(l_prgb.prgbdocno,l_prgb.prgbseq,l_prgb.prgb016,l_prgb.prgbsite,l_prgb.prgb008) 
         RETURNING r_prgb014,r_prgb018                 
      LET l_prgb.prgb014 = r_prgb014
      LET l_prgb.prgb018 = r_prgb018
     
      LET l_cnt = 0
      SELECT count(*) INTO l_cnt
        FROM prgc_t
       WHERE prgcent = g_enterprise
         AND prgcdocno = l_prgb.prgbdocno
         AND prgcseq = l_prgb.prgbseq
      IF l_cnt = 0 THEN     #无补差明细资料的不进入补差单
         CONTINUE FOREACH
      END IF
      
    # INSERT INTO prgb_t VALUES(l_prgb.*)  #161111-00028#2--mark
      #161111-00028#2---add---begin-----------
      INSERT INTO prgb_t (prgbent,prgbunit,prgbsite,prgbdocno,prgbseq,prgb001,prgb002,prgb003,prgb004,prgb005,prgb006,prgb007,
                          prgb008,prgb009,prgb010,prgb011,prgb012,prgb013,prgb014,prgb015,prgb016,prgb017,prgb018,prgb019,
                          prgb020,prgb021,prgb022,prgb023,prgb024,prgb025,prgb026,prgb027,prgb028,prgb029,prgb030,prgb031,
                          prgb032,prgb033,prgb034,prgb035)
              VALUES (l_prgb.prgbent,l_prgb.prgbunit,l_prgb.prgbsite,l_prgb.prgbdocno,l_prgb.prgbseq,l_prgb.prgb001,l_prgb.prgb002,l_prgb.prgb003,l_prgb.prgb004,l_prgb.prgb005,l_prgb.prgb006,l_prgb.prgb007,
                          l_prgb.prgb008,l_prgb.prgb009,l_prgb.prgb010,l_prgb.prgb011,l_prgb.prgb012,l_prgb.prgb013,l_prgb.prgb014,l_prgb.prgb015,l_prgb.prgb016,l_prgb.prgb017,l_prgb.prgb018,l_prgb.prgb019,
                          l_prgb.prgb020,l_prgb.prgb021,l_prgb.prgb022,l_prgb.prgb023,l_prgb.prgb024,l_prgb.prgb025,l_prgb.prgb026,l_prgb.prgb027,l_prgb.prgb028,l_prgb.prgb029,l_prgb.prgb030,l_prgb.prgb031,
                          l_prgb.prgb032,l_prgb.prgb033,l_prgb.prgb034,l_prgb.prgb035)
      #161111-00028#2---add---end------------- 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "写入数据库失败!! " 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()           
         CALL s_transaction_end('N','0')        
         EXIT FOREACH
      END IF     

   END FOREACH 	
   
   #判断是否已经产生库存明细资料
    LET r_sql = " SELECT DISTINCT prgadocno  
                    FROM prga_t 
                   WHERE prgaent = ",g_enterprise,"
                     AND prga003 = '",g_prbf_m.prbfdocno,"' "
    
    PREPARE aprt111_ser3 FROM r_sql
    DECLARE aprt111_cs3 CURSOR FOR aprt111_ser3
    #多门店拆单后若果没有库存补差明细资料的删除单头资料------
    FOREACH aprt111_cs3 INTO l_prgadocno
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "foreach aprt111_cs" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          RETURN '',''
       END IF 
       LET l_cnt = 0
       SELECT count(*) INTO l_cnt         
         FROM prgb_t
        WHERE prgbent = g_enterprise
          AND prgbdocno = l_prgadocno
       IF l_cnt = 0 THEN
          DELETE FROM prga_t 
           WHERE prgaent = g_enterprise 
             AND prgadocno = l_prgadocno   
       END IF                    
       
    END FOREACH
      
   LET l_cnt = 0
   SELECT count(*) INTO l_cnt
     FROM prgb_t,prga_t
    WHERE prgbent = g_enterprise
      AND prgaent = prgbent AND prgadocno = prgbdocno
      AND prga003 = p_prbfdocno
   IF l_cnt = 0 THEN
      LET g_prgatype = 'N'    
   END IF
   
   
END FUNCTION

################################################################################
# Descriptions...: 抓取补差资料明细并回传补差数量
# Memo...........: (单身明细进入prgc_t)
# Date & Author..: 2015/10/22 By guomy
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_ins_prgc(p_prgbdocno,p_prgbseq,p_prgb016,p_prgbsite,p_prgb008)
DEFINE l_sql      STRING 
#DEFINE l_prgc     RECORD LIKE prgc_t.* #161111-00028#2--mark
#161111-00028#2---add---begin-------------
DEFINE l_prgc RECORD  #補差明細表
       prgcent LIKE prgc_t.prgcent, #企業編號
       prgcsite LIKE prgc_t.prgcsite, #營運據點
       prgcunit LIKE prgc_t.prgcunit, #應用執行組織物件
       prgcdocno LIKE prgc_t.prgcdocno, #單號
       prgcseq LIKE prgc_t.prgcseq, #項次
       prgcseq1 LIKE prgc_t.prgcseq1, #項次1
       prgc001 LIKE prgc_t.prgc001, #補差類型
       prgc002 LIKE prgc_t.prgc002, #商品編號
       prgc003 LIKE prgc_t.prgc003, #商品特徵
       prgc004 LIKE prgc_t.prgc004, #庫位管理特徵
       prgc005 LIKE prgc_t.prgc005, #庫區編號
       prgc006 LIKE prgc_t.prgc006, #儲位編號
       prgc007 LIKE prgc_t.prgc007, #批號
       prgc008 LIKE prgc_t.prgc008, #交易單位
       prgc009 LIKE prgc_t.prgc009, #數量
       prgc010 LIKE prgc_t.prgc010, #採購進價/日結成本價
       prgc011 LIKE prgc_t.prgc011, #售價
       prgc012 LIKE prgc_t.prgc012, #來源單號
       prgc013 LIKE prgc_t.prgc013, #來源項次
       prgc014 LIKE prgc_t.prgc014  #來源日期
END RECORD
#161111-00028#2---add---end---------------
DEFINE l_n        LIKE type_t.num5
DEFINE r_prgc009  LIKE prgc_t.prgc009
DEFINE r_prgb018   LIKE prgb_t.prgb018
DEFINE l_msg        STRING
DEFINE l_success   LIKE type_t.chr10   
DEFINE l_prga001   LIKE prga_t.prga001
DEFINE p_prgbdocno LIKE prgb_t.prgbdocno,
       p_prgbseq   LIKE prgb_t.prgbseq,
       p_prgb016   LIKE prgb_t.prgb016,
       p_prgbsite  LIKE prgb_t.prgbsite,
       p_prgb008   LIKE prgb_t.prgb008
#20151109 geza add(S)
DEFINE l_ooef017        LIKE ooef_t.ooef017
DEFINE l_glaald         LIKE glaa_t.glaald
DEFINE l_glaa120        LIKE glaa_t.glaa120
DEFINE l_xcbf001        LIKE xcbf_t.xcbf001   
DEFINE l_xcbf003        LIKE xcbf_t.xcbf003
DEFINE l_flag           LIKE type_t.chr1   
#20151109 geza add(E)   

   IF cl_null(p_prgbsite) OR cl_null(p_prgb008) THEN 
      RETURN '',''
   END IF 

   #add by geza 20151109(S)
   #抓取法人對應會計週期參照表
   SELECT ooef017 INTO l_ooef017
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_prgbsite
   SELECT glaald,glaa120 INTO l_glaald,l_glaa120  #20150715 dongsz add glaald,glaa120
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_ooef017
      AND glaa014 = 'Y'

   #抓取aoos020设定的成本域
   #启用成本域否
   LET l_flag = cl_get_para(g_enterprise,p_prgbsite,'S-FIN-6001')
   #成本域类型
   LET l_xcbf003 = cl_get_para(g_enterprise,p_prgbsite,'S-FIN-6002')
   
   
   #成本域编号
   SELECT xcbf001 INTO l_xcbf001
     FROM xcbf_t 
    WHERE xcbfent = g_enterprise 
      AND xcbfcomp = l_ooef017 
      AND xcbf002 = p_prgbsite
      AND xcbf003 = l_xcbf003
   #add by geza 20151109(E)
   
   #160905-00007#12 -S
  #SELECT prga001 INTO l_prga001
  #  FROM prga_t
  # WHERE prgadocno = p_prgbdocno
   SELECT prga001 INTO l_prga001
     FROM prga_t
    WHERE prgadocno = p_prgbdocno
      AND prgaent = g_enterprise
   #160905-00007#12 -E 
   IF SQLCA.sqlcode THEN
      CALL cl_errmsg('prga_t','','无此明细资料','!',1)
      LET l_success='N'
      RETURN
   END IF    
     #库存补差'aprt602'
      IF cl_null(p_prgb016) THEN 
         RETURN '',''
      END IF 
     #抓取所有的inag明细
     #抓取所有的inag明细
     #                    來源單號/來源項次/來源日期/商品编号/产品特征/库存管理特征/库区/储位/批号/单位/数量/采购进价/售价
     LET l_sql = " SELECT '','','',inag001,inag002,inag003,inag004,inag005,inag006,inag007,inag008,xccu202,'' ",
                 "   FROM xccu_t,inag_t ",
                 #add by geza 20151110(S)
                 "   LEFT OUTER JOIN ooef_t ",
                 "     ON ooefent = inagent AND ooef001 = inagsite  ",
                 #抓取该法人和组织对应成本域类型的成本域编号 
                 "   LEFT OUTER JOIN xcbf_t ",
                 "     ON xcbfent = inagent AND xcbfcomp = ooef017 
                      AND xcbf002 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                         WHEN 'Y' THEN 
                                                         CASE '",l_xcbf003,"' WHEN '1' THEN inagsite
                                                                              WHEN '2' THEN inag004
                                                         END                                                                                       
                                     END 
                      AND xcbf003 =  CASE '",l_flag,"'   WHEN 'N' THEN ' '
                                                         WHEN 'Y' THEN '",l_xcbf003,"'                                                                                      
                                     END ",
                 #add by geza 20151110(E)  
                 "  WHERE inagent = '",g_enterprise,"'",
                 "    AND inagsite = '",p_prgbsite,"'",
                 "    AND inag001 = '",p_prgb008,"'",
                 "    AND inagent = xccuent ",
                 "    AND inag001 = xccu004 ",
                 "    AND inag006 = xccu006 ",
                 "    AND inag008 > 0 ",
                 "    AND xccu202 > '",p_prgb016,"'",
                 #add by geza 20151109(S)
                 #关联xccu现在都统一把所有的key都加上  
                 "    AND xcculd = '",l_glaald,"' AND xccu001 = '1' AND xccu003 = '",l_glaa120,"' ",
                 "    AND xccu005 = inag002 AND xccu002 = COALESCE(xcbf001,xccu002) "
                 #add by geza 20151109(E) 

   #删除补差资料明细
   DELETE FROM prgc_t 
    WHERE prgcent = g_enterprise 
     AND prgcdocno = p_prgbdocno
     AND prgcseq = p_prgbseq
   LET l_prgc.prgcent = g_enterprise
   LET l_prgc.prgcsite = p_prgbsite
   LET l_prgc.prgcunit = p_prgbsite
   LET l_prgc.prgcdocno = p_prgbdocno
   LET l_prgc.prgcseq = p_prgbseq
   LET l_prgc.prgc001 = l_prga001
   PREPARE aprt602_sel_pre2 FROM l_sql
   DECLARE aprt602_sel_cs2 CURSOR FOR aprt602_sel_pre2
   LET l_n = 1
   FOREACH aprt602_sel_cs2 INTO l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014,
                                l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,l_prgc.prgc005,
                                l_prgc.prgc006,l_prgc.prgc007,l_prgc.prgc008,l_prgc.prgc009,
                                l_prgc.prgc010,l_prgc.prgc011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach aprt602_sel_cs2" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN '',''
      END IF
      #IF g_prog = 'aprt602' AND cl_null(l_prgc.prgc010) THEN        #160705-00042#10 160713 by sakura mark
      IF g_prog MATCHES 'aprt602' AND cl_null(l_prgc.prgc010) THEN   #160705-00042#10 160713 by sakura add
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_prgc.prgc002
         LET g_errparam.code   = 'apr-00410'    #此商品抓不到成本价 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN ''
      END IF 
      LET l_prgc.prgcseq1 = l_n
    
          
    # INSERT INTO prgc_t VALUES(l_prgc.*)  #161111-00028#2--mark
      #161111-00028#2---add-----begin--------
      INSERT INTO prgc_t (prgcent,prgcsite,prgcunit,prgcdocno,prgcseq,prgcseq1,prgc001,prgc002,prgc003,prgc004,
                          prgc005,prgc006,prgc007,prgc008,prgc009,prgc010,prgc011,prgc012,prgc013,prgc014)
      VALUES (l_prgc.prgcent,l_prgc.prgcsite,l_prgc.prgcunit,l_prgc.prgcdocno,l_prgc.prgcseq,l_prgc.prgcseq1,l_prgc.prgc001,l_prgc.prgc002,l_prgc.prgc003,l_prgc.prgc004,
              l_prgc.prgc005,l_prgc.prgc006,l_prgc.prgc007,l_prgc.prgc008,l_prgc.prgc009,l_prgc.prgc010,l_prgc.prgc011,l_prgc.prgc012,l_prgc.prgc013,l_prgc.prgc014)
      #161111-00028#2---add-----end----------
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT prgc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN ''
      END IF
      LET l_n = l_n + 1
   END FOREACH
     
     
   #计算本次补差数量   
   SELECT SUM(prgc009) INTO r_prgc009
     FROM prgc_t
    WHERE prgcent = g_enterprise
      AND prgcdocno = p_prgbdocno
      AND prgcseq = p_prgbseq
   IF cl_null(r_prgc009) THEN 
      LET r_prgc009 = 0
   END IF 

      #计算本次补差金额    售价-售价*毛利率-原进价=补差进价
      #计算本次补差金额
      SELECT SUM((COALESCE(prgc010,0)-p_prgb016)*prgc009) INTO r_prgb018
        FROM prgc_t
       WHERE prgcent = g_enterprise
         AND prgcdocno = p_prgbdocno
         AND prgcseq = p_prgbseq

   IF cl_null(r_prgb018) THEN 
      LET r_prgb018 = 0
   END IF

   RETURN r_prgc009,r_prgb018  
   
END FUNCTION

################################################################################
# Descriptions...: 调整后自动审核
# Memo...........:
# Usage..........: CALL aprt111_upd_prga()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/10/22 By guomy
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_upd_prga()
DEFINE lc_state LIKE type_t.chr5
DEFINE l_success   LIKE type_t.num5
DEFINE l_param  RECORD
   prbk006         LIKE prbk_t.prbk006,
   prbk025         LIKE prbk_t.prbk025,       
   wc              STRING
                END RECORD   
DEFINE l_sql    STRING
DEFINE l_n      LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num10
DEFINE l_msg         STRING
DEFINE l_success1 LIKE type_t.chr10  
   #end add-point  
   
   #add-point:statechange段開始前

   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_prbf_m.prbfdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF

   
   #add-point:stus修改前
   LET l_success = TRUE
   LET lc_state = 'Y'
   
   #g_prgatype = 'N'则没有产生库存明细资料保留相关单据不能通过审核               
   CALL aprt111_ins_prga(g_prbf_m.prbfdocno) 

   #如果有库存明细资料则进入库存调整单将自动审核进入供应商调整单
            
   IF g_prgatype ='Y' THEN   
      LET l_sql = " SELECT DISTINCT prgadocno  
                      FROM prga_t 
                     WHERE prgaent = ",g_enterprise,"
                       AND prga003 = '",g_prbf_m.prbfdocno,"' "
      
      PREPARE aprt111_ser2 FROM l_sql
      DECLARE aprt111_cs2 CURSOR FOR aprt111_ser2
      #多门店拆单后批量审核------
      FOREACH aprt111_cs2 INTO g_prgadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "foreach aprt111_cs2" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N'
            RETURN 
         END IF
         CALL s_aprt601_conf_chk(g_prgadocno,'N') RETURNING l_success
         IF l_success THEN
            CALL s_aprt601_conf_upd(g_prgadocno) RETURNING l_success,g_errno
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = g_prgadocno
               LET g_errparam.popup = FALSE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               LET g_success = 'N'
               RETURN
            END IF        
         END IF
      END FOREACH 
   END IF  
    
END FUNCTION

################################################################################
# Descriptions...: 产生预调清单
# Memo...........:
# Usage..........: CALL aprt111_ins_prbw()
# Date & Author..: 20151102 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_ins_prbw()
DEFINE l_sql      STRING

   CALL s_transaction_begin()
   #先删除预调清单资料
   DELETE FROM prbw_t WHERE prbwent = g_enterprise AND prbwdocno = g_prbf_m.prbfdocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del prbw_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #重新写入预调清单
   LET l_sql = " INSERT INTO prbw_t (prbwent,prbwunit,prbwsite,prbwdocno, ",
               "              prbwseq,prbw001,prbw002,prbw003,prbw004,prbw005,prbw019,prbw006,prbw007, ",
               "              prbw008,prbw009,prbw010,prbw011,prbw012,prbw013,prbw014, ",
               "              prbw015,prbw016,prbw017,prbw018,prbw020,prbw021,prbw022) ",  #151013-00001#44 dongsz add prbw020,prbw021  #160506-00009#22 dongsz add prbw022
               " SELECT DISTINCT ",g_enterprise,",prbfunit,prbv001,prbfdocno, ",
               "        ROWNUM,prbg002,prbg003,prbg004,'',prbg005,prbg018,'','', ",
               "        prbg006,prbg007,prbg008,prbg009,prbg010,prbg011,prbg012, ",
               #"        prbf006,prbf007,'','' ",         #151013-00001#44 dongsz mark
               "        prbg014,prbg015,'','',prbg016,prbg017,prbg026 ",   #151013-00001#44 dongsz add  #160506-00009#22 dongsz add prbg026
               "   FROM prbg_t,prbv_t,prbf_t ",
               "  WHERE prbgent = prbvent AND prbgent = ",g_enterprise," ",
               "    AND prbfent = prbgent AND prbfdocno = prbgdocno ",
               "    AND prbgdocno = prbvdocno AND prbgdocno = '",g_prbf_m.prbfdocno,"' ",
               "    AND prbgseq1 = 1 AND prbvstus = 'Y' "
   IF NOT cl_null(g_prbf_m.prbf004) THEN
      LET l_sql = l_sql," AND EXISTS (SELECT 1 FROM stas_t,star_t WHERE stasent = starent AND stas001 = star001 ",
                        "                AND stasent = ",g_enterprise," AND star003 = '",g_prbf_m.prbf004,"' ",
                        "                AND starstus = 'Y' AND stas018 <= '",g_prbf_m.prbfdocdt,"' ",
                        "                AND stas019 >= '",g_prbf_m.prbfdocdt,"' ",
                        "                AND stassite = prbv001 AND stas003 = prbg002) "                        
   ELSE
      LET l_sql = l_sql," AND EXISTS (SELECT 1 FROM rtdx_t WHERE rtdxent = ",g_enterprise," ",
                        "                AND rtdxsite = prbv001 AND rtdx001 = prbg002) "
   END IF
   LET l_sql = l_sql," ORDER BY prbv001,prbg002 "
   PREPARE ins_prbw_pre FROM l_sql
   EXECUTE ins_prbw_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins prbw_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: 檢查促銷售價/促銷散客售價/促銷會員價是否大於永久售價
# Memo...........: 1.aprt113 ,p_price=促銷售價(prbg009),p_chk_type=1; p_price=促銷會員價1~3(prbg010~prbg012),p_chk_type=3
#                  2.aprt114 ,p_price=促銷售價(prbg009),p_chk_type=1; p_price=促銷會員價1~3(prbg010~prbg012),p_chk_type=3
#                  3.aprt115 ,p_price=促銷散客售價(prbg009),p_chk_type=2
#                  4.aprt116 ,p_price=促銷會員價1~3(prbg010~prbg012),p_chk_type=3
# Usage..........: CALL aprt111_chk_price(p_prbgsite,p_prbg002,p_price,p_chk_type)
#                  RETURNING r_success
# Input parameter: 1.p_prbgsite      門店編號
#                  2.p_prbg002       商品編號
#                  3.p_price         促銷售價/促銷散客售價/促銷會員價
#                  4.p_chk_type      檢查價格類型：1.促銷售價2.促銷散客價3.促銷會員價
# Return code....: 1.r_success       檢查結果(TRUE/FALSE)
# Date & Author..: 2017/01/05 By Lori  #170105-00015#1 
# Modify.........:
################################################################################
PRIVATE FUNCTION aprt111_chk_price(p_prbgsite,p_prbg002,p_price,p_chk_type)
   DEFINE p_prbgsite      LIKE prbg_t.prbgsite   #門店編號
   DEFINE p_prbg002       LIKE prbg_t.prbg002    #商品編號
   DEFINE p_price         LIKE prbg_t.prbg009    #促銷售價/促銷散客售價/促銷會員價
   DEFINE p_chk_type      LIKE type_t.chr1       #檢查價格類型：1.促銷售價2.促銷散客價3.促銷會員價
   DEFINE r_success       LIKE type_t.num5       #檢查結果(TRUE/FALSE)]
   DEFINE l_rtdx016       LIKE rtdx_t.rtdx016    #售價

   LET r_success = TRUE
   LET l_rtdx016 = 0
   
   IF cl_null(p_prbgsite) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "art-00317"
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_prbg002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "sub-00515"
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      
      LET r_success = FALSE
      RETURN r_success   
   END IF
   
   SELECT rtdx016 INTO l_rtdx016 
     FROM rtdx_t
    WHERE rtdxent = g_enterprise
      AND rtdxsite = p_prbgsite
      AND rtdx001 = p_prbg002

   IF p_price > l_rtdx016 THEN
      INITIALIZE g_errparam TO NULL
      
      CASE p_chk_type
         WHEN '1'   LET g_errparam.code  = "apr-00553"
         WHEN '2'   LET g_errparam.code  = "apr-00555"
         WHEN '3'   LET g_errparam.code  = "apr-00556" 
      END CASE
      
      LET g_errparam.replace[1] = p_prbg002
      LET g_errparam.replace[2] = l_rtdx016
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success 
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
