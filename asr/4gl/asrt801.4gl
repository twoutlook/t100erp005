#該程式未解開Section, 採用最新樣板產出!
{<section id="asrt801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2015-01-02 20:38:40), PR版次:0010(2016-12-29 18:03:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: asrt801
#+ Description: 重複性生產製程變更作業
#+ Creator....: 01258(2014-11-14 11:27:47)
#+ Modifier...: 01258 -SD/PR- 02159
 
{</section>}
 
{<section id="asrt801.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151125-00001#4   2015/11/25   By 06948    增加作廢時詢問「是否作廢」
#160318-00025#4   2016/04/12   By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160816-00001#10  16/08/17 By  08742       抓取理由碼改CALL sub
#160818-00017#37  2016/08/29   By lixh     单据类作业修改，删除时需重新检查状态
#161128-00015#1   2016/12/09   By xianghui 单头输入资料自动产生单头与单身资料，没有给g_master_insert赋值
#161124-00048#12  2016/12/13   By xujing   整批调整系统RECORD LIKE xxxx_t.* 星号写法
#160824-00007#285 2016/12/29   by sakura   新舊值備份處理
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
PRIVATE type type_g_srca_m        RECORD
       srcasite LIKE srca_t.srcasite, 
   srca000 LIKE srca_t.srca000, 
   srca001 LIKE srca_t.srca001, 
   srca001_desc LIKE type_t.chr80, 
   srca004 LIKE srca_t.srca004, 
   srca004_desc LIKE type_t.chr80, 
   srca004_desc_1 LIKE type_t.chr80, 
   srca005 LIKE srca_t.srca005, 
   srca006 LIKE srca_t.srca006, 
   srca006_desc LIKE type_t.chr80, 
   srca002 LIKE srca_t.srca002, 
   srca002_desc LIKE type_t.chr80, 
   srca900 LIKE srca_t.srca900, 
   srca902 LIKE srca_t.srca902, 
   srca905 LIKE srca_t.srca905, 
   srca905_desc LIKE type_t.chr80, 
   srca906 LIKE srca_t.srca906, 
   srcastus LIKE srca_t.srcastus, 
   srcaownid LIKE srca_t.srcaownid, 
   srcaownid_desc LIKE type_t.chr80, 
   srcaowndp LIKE srca_t.srcaowndp, 
   srcaowndp_desc LIKE type_t.chr80, 
   srcacrtid LIKE srca_t.srcacrtid, 
   srcacrtid_desc LIKE type_t.chr80, 
   srcacrtdp LIKE srca_t.srcacrtdp, 
   srcacrtdp_desc LIKE type_t.chr80, 
   srcacrtdt LIKE srca_t.srcacrtdt, 
   srcamodid LIKE srca_t.srcamodid, 
   srcamodid_desc LIKE type_t.chr80, 
   srcamoddt LIKE srca_t.srcamoddt, 
   srcacnfid LIKE srca_t.srcacnfid, 
   srcacnfid_desc LIKE type_t.chr80, 
   srcacnfdt LIKE srca_t.srcacnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_srcc_d        RECORD
       srcc007 LIKE srcc_t.srcc007, 
   srcc008 LIKE srcc_t.srcc008, 
   srcc008_desc LIKE type_t.chr500, 
   srcc009 LIKE srcc_t.srcc009, 
   srcc010 LIKE srcc_t.srcc010, 
   srcc011 LIKE srcc_t.srcc011, 
   srcc012 LIKE srcc_t.srcc012, 
   srcc012_desc LIKE type_t.chr500, 
   srcc013 LIKE srcc_t.srcc013, 
   srcc014 LIKE srcc_t.srcc014, 
   srcc014_desc LIKE type_t.chr500, 
   srcc015 LIKE srcc_t.srcc015, 
   srcc016 LIKE srcc_t.srcc016, 
   srcc016_desc LIKE type_t.chr500, 
   srcc017 LIKE srcc_t.srcc017, 
   srcc018 LIKE srcc_t.srcc018, 
   srcc019 LIKE srcc_t.srcc019, 
   srcc020 LIKE srcc_t.srcc020, 
   srcc036 LIKE srcc_t.srcc036, 
   srcc037 LIKE srcc_t.srcc037, 
   srcc037_desc LIKE type_t.chr500, 
   srcc021 LIKE srcc_t.srcc021, 
   srcc022 LIKE srcc_t.srcc022, 
   srcc023 LIKE srcc_t.srcc023, 
   srcc024 LIKE srcc_t.srcc024, 
   srcc025 LIKE srcc_t.srcc025, 
   srcc026 LIKE srcc_t.srcc026, 
   srcc046 LIKE srcc_t.srcc046, 
   srcc046_desc LIKE type_t.chr500, 
   srcc047 LIKE srcc_t.srcc047, 
   srcc048 LIKE srcc_t.srcc048, 
   srcc027 LIKE srcc_t.srcc027, 
   srcc027_desc LIKE type_t.chr500, 
   srcc028 LIKE srcc_t.srcc028, 
   srcc029 LIKE srcc_t.srcc029, 
   srcc901 LIKE srcc_t.srcc901, 
   srcc902 LIKE srcc_t.srcc902, 
   srcc905 LIKE srcc_t.srcc905, 
   srcc905_desc LIKE type_t.chr500, 
   srcc906 LIKE srcc_t.srcc906
       END RECORD
PRIVATE TYPE type_g_srcc2_d RECORD
       srcc007 LIKE srcc_t.srcc007, 
   l_srcc008_2 LIKE type_t.chr10, 
   l_srcc008_2_desc LIKE type_t.chr500, 
   l_srcc009_2 LIKE type_t.chr10, 
   l_srcc016_2 LIKE type_t.chr10, 
   l_srcc016_2_desc LIKE type_t.chr500, 
   srcc030 LIKE srcc_t.srcc030, 
   srcc031 LIKE srcc_t.srcc031, 
   srcc032 LIKE srcc_t.srcc032, 
   srcc033 LIKE srcc_t.srcc033, 
   srcc034 LIKE srcc_t.srcc034, 
   srcc035 LIKE srcc_t.srcc035, 
   srcc038 LIKE srcc_t.srcc038, 
   srcc039 LIKE srcc_t.srcc039, 
   srcc040 LIKE srcc_t.srcc040, 
   srcc041 LIKE srcc_t.srcc041, 
   srcc042 LIKE srcc_t.srcc042, 
   srcc043 LIKE srcc_t.srcc043, 
   srcc044 LIKE srcc_t.srcc044, 
   srcc045 LIKE srcc_t.srcc045
       END RECORD
PRIVATE TYPE type_g_srcc3_d RECORD
       srcdseq LIKE srcd_t.srcdseq, 
   srcd008 LIKE srcd_t.srcd008, 
   srcd009 LIKE srcd_t.srcd009, 
   srcd009_desc LIKE type_t.chr500, 
   srcd010 LIKE srcd_t.srcd010, 
   srcd011 LIKE srcd_t.srcd011, 
   srcd012 LIKE srcd_t.srcd012, 
   srcd013 LIKE srcd_t.srcd013, 
   srcd014 LIKE srcd_t.srcd014, 
   srcd901 LIKE srcd_t.srcd901, 
   srcd902 LIKE srcd_t.srcd902, 
   srcd905 LIKE srcd_t.srcd905, 
   srcd905_desc LIKE type_t.chr500, 
   srcd906 LIKE srcd_t.srcd906
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_srca001 LIKE srca_t.srca001,
   b_srca001_desc LIKE type_t.chr80,
      b_srca004 LIKE srca_t.srca004,
   b_srca004_desc LIKE type_t.chr80,
   b_srca004_desc_1 LIKE type_t.chr80,
      b_srca005 LIKE srca_t.srca005,
      b_srca006 LIKE srca_t.srca006,
   b_srca006_desc LIKE type_t.chr80,
      b_srca002 LIKE srca_t.srca002,
   b_srca002_desc LIKE type_t.chr80,
      b_srca900 LIKE srca_t.srca900,
      b_srca902 LIKE srca_t.srca902,
      b_srca905 LIKE srca_t.srca905,
   b_srca905_desc LIKE type_t.chr80,
      b_srca000 LIKE srca_t.srca000,
      b_srcasite LIKE srca_t.srcasite
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_flag                LIKE type_t.chr1
DEFINE g_flag1               LIKE type_t.chr1
DEFINE g_flag2               LIKE type_t.chr1
DEFINE g_flag4               LIKE type_t.chr1
DEFINE g_flag5               LIKE type_t.chr1
DEFINE g_flag6               LIKE type_t.chr1
DEFINE g_flag_hidden         LIKE type_t.chr1
TYPE type_g_srcc4_d RECORD
        l_srcdseq LIKE srcd_t.srcdseq, 
        l_srcd008 LIKE srcd_t.srcd008, 
        l_srcd009 LIKE srcd_t.srcd009, 
        l_srcd009_desc LIKE type_t.chr500, 
        l_srcd010 LIKE srcd_t.srcd010, 
        l_srcd011 LIKE srcd_t.srcd011, 
        l_srcd012 LIKE srcd_t.srcd012, 
        l_srcd013 LIKE srcd_t.srcd013, 
        l_srcd014 LIKE srcd_t.srcd014, 
        l_srcd901 LIKE srcd_t.srcd901,
        l_srcd902 LIKE srcd_t.srcd902,        
        l_srcd905 LIKE srcd_t.srcd905, 
        l_srcd905_desc LIKE type_t.chr500, 
        l_srcd906 LIKE srcd_t.srcd906
                  END RECORD
DEFINE g_srcc4_d   DYNAMIC ARRAY OF type_g_srcc4_d
DEFINE g_srcc4_d_t type_g_srcc4_d
DEFINE g_srcc4_d_o type_g_srcc4_d
DEFINE g_rec_b4    LIKE type_t.num5
DEFINE g_detail_idx4         LIKE type_t.num5 
DEFINE g_acc                 LIKE gzcb_t.gzcb004
DEFINE g_srcf009             LIKE srcf_t.srcf009
DEFINE g_srcf013             LIKE srcf_t.srcf013

DEFINE g_srcc_d_color        DYNAMIC ARRAY OF RECORD
       srcc007               STRING,
       srcc008               STRING,
       srcc008_desc          STRING,
       srcc009               STRING,
       srcc010               STRING,
       srcc011               STRING,
       srcc012               STRING,
       srcc012_desc          STRING,
       srcc013               STRING,
       srcc014               STRING,
       srcc014_desc          STRING,
       srcc015               STRING,
       srcc016               STRING,
       srcc016_desc          STRING,
       srcc017               STRING,
       srcc018               STRING,
       srcc019               STRING,
       srcc020               STRING,
       srcc036               STRING,
       srcc037               STRING,
       srcc037_desc          STRING,
       srcc021               STRING,
       srcc022               STRING,
       srcc023               STRING,
       srcc024               STRING,
       srcc025               STRING,
       srcc026               STRING,
       srcc046               STRING,
       srcc046_desc          STRING,
       srcc047               STRING,
       srcc048               STRING,
       srcc027               STRING,
       srcc027_desc          STRING,
       srcc028               STRING,
       srcc029               STRING,
       srcc901               STRING,
       srcc902               STRING,
       srcc905               STRING,
       srcc905_desc          STRING,
       srcc906               STRING
                             END RECORD
DEFINE g_srcc2_d_color       DYNAMIC ARRAY OF RECORD
       srcc007               STRING,
       l_srcc008_2           STRING,
       l_srcc008_2_desc      STRING,
       l_srcc009_2           STRING,
       l_srcc016_2           STRING,
       l_srcc016_2_desc      STRING,
       srcc030               STRING,
       srcc031               STRING,
       srcc032               STRING,
       srcc033               STRING,
       srcc034               STRING,
       srcc035               STRING,
       srcc038               STRING,
       srcc039               STRING,
       srcc040               STRING,
       srcc041               STRING,
       srcc042               STRING,
       srcc043               STRING,
       srcc044               STRING,
       srcc045               STRING
                             END RECORD
DEFINE g_srcc3_d_COLOR       DYNAMIC ARRAY OF RECORD
       srcdseq               STRING,
       srcd008               STRING,
       srcd009               STRING,
       srcd009_desc          STRING,
       srcd010               STRING,
       srcd011               STRING,
       srcd012               STRING,
       srcd013               STRING,
       srcd014               STRING,
       srcd901               STRING,
       srcd902               STRING,
       srcd905               STRING,
       srcd905_desc          STRING,
       srcd906               STRING
                             END RECORD
DEFINE g_srcc4_d_color       DYNAMIC ARRAY OF RECORD
       l_srcdseq             STRING,
       l_srcd008             STRING,
       l_srcd009             STRING,
       l_srcd009_desc        STRING,
       l_srcd010             STRING,
       l_srcd011             STRING,
       l_srcd012             STRING,
       l_srcd013             STRING,
       l_srcd014             STRING,
       l_srcd901             STRING,
       l_srcd902             STRING,
       l_srcd905             STRING,
       l_srcd905_desc        STRING,
       l_srcd906             STRING
                             END RECORD
#end add-point
       
#模組變數(Module Variables)
DEFINE g_srca_m          type_g_srca_m
DEFINE g_srca_m_t        type_g_srca_m
DEFINE g_srca_m_o        type_g_srca_m
DEFINE g_srca_m_mask_o   type_g_srca_m #轉換遮罩前資料
DEFINE g_srca_m_mask_n   type_g_srca_m #轉換遮罩後資料
 
   DEFINE g_srcasite_t LIKE srca_t.srcasite
DEFINE g_srca000_t LIKE srca_t.srca000
DEFINE g_srca001_t LIKE srca_t.srca001
DEFINE g_srca004_t LIKE srca_t.srca004
DEFINE g_srca005_t LIKE srca_t.srca005
DEFINE g_srca006_t LIKE srca_t.srca006
DEFINE g_srca002_t LIKE srca_t.srca002
DEFINE g_srca900_t LIKE srca_t.srca900
 
 
DEFINE g_srcc_d          DYNAMIC ARRAY OF type_g_srcc_d
DEFINE g_srcc_d_t        type_g_srcc_d
DEFINE g_srcc_d_o        type_g_srcc_d
DEFINE g_srcc_d_mask_o   DYNAMIC ARRAY OF type_g_srcc_d #轉換遮罩前資料
DEFINE g_srcc_d_mask_n   DYNAMIC ARRAY OF type_g_srcc_d #轉換遮罩後資料
DEFINE g_srcc2_d          DYNAMIC ARRAY OF type_g_srcc2_d
DEFINE g_srcc2_d_t        type_g_srcc2_d
DEFINE g_srcc2_d_o        type_g_srcc2_d
DEFINE g_srcc2_d_mask_o   DYNAMIC ARRAY OF type_g_srcc2_d #轉換遮罩前資料
DEFINE g_srcc2_d_mask_n   DYNAMIC ARRAY OF type_g_srcc2_d #轉換遮罩後資料
DEFINE g_srcc3_d          DYNAMIC ARRAY OF type_g_srcc3_d
DEFINE g_srcc3_d_t        type_g_srcc3_d
DEFINE g_srcc3_d_o        type_g_srcc3_d
DEFINE g_srcc3_d_mask_o   DYNAMIC ARRAY OF type_g_srcc3_d #轉換遮罩前資料
DEFINE g_srcc3_d_mask_n   DYNAMIC ARRAY OF type_g_srcc3_d #轉換遮罩後資料
 
 
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
 
{<section id="asrt801.main" >}
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
   LET g_forupd_sql = " SELECT srcasite,srca000,srca001,'',srca004,'','',srca005,srca006,'',srca002, 
       '',srca900,srca902,srca905,'',srca906,srcastus,srcaownid,'',srcaowndp,'',srcacrtid,'',srcacrtdp, 
       '',srcacrtdt,srcamodid,'',srcamoddt,srcacnfid,'',srcacnfdt", 
                      " FROM srca_t",
                      " WHERE srcaent= ? AND srcasite=? AND srca000=? AND srca001=? AND srca002=? AND  
                          srca004=? AND srca005=? AND srca006=? AND srca900=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt801_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.srcasite,t0.srca000,t0.srca001,t0.srca004,t0.srca005,t0.srca006, 
       t0.srca002,t0.srca900,t0.srca902,t0.srca905,t0.srca906,t0.srcastus,t0.srcaownid,t0.srcaowndp, 
       t0.srcacrtid,t0.srcacrtdp,t0.srcacrtdt,t0.srcamodid,t0.srcamoddt,t0.srcacnfid,t0.srcacnfdt,t1.srza002 , 
       t2.imaal003 ,t3.imecl005 ,t4.ecba003 ,t5.oocql004 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM srca_t t0",
                              " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srcasite AND t1.srza001=t0.srca001  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srca004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t3 ON t3.imeclent="||g_enterprise||" AND t3.imecl003=t0.srca006 AND t3.imecl004='"||g_dlang||"' ",
               " LEFT JOIN ecba_t t4 ON t4.ecbaent="||g_enterprise||" AND t4.ecbasite=t0.srcasite AND t4.ecba001=t0.srca004 AND t4.ecba002=t0.srca002  ",
               " LEFT JOIN oocql_t t5 ON t5.oocqlent="||g_enterprise||" AND t5.oocql001='225' AND t5.oocql002=t0.srca905 AND t5.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.srcaownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.srcaowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.srcacrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.srcacrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.srcamodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.srcacnfid  ",
 
               " WHERE t0.srcaent = " ||g_enterprise|| " AND t0.srcasite = ? AND t0.srca000 = ? AND t0.srca001 = ? AND t0.srca002 = ? AND t0.srca004 = ? AND t0.srca005 = ? AND t0.srca006 = ? AND t0.srca900 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asrt801_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asrt801 WITH FORM cl_ap_formpath("asr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asrt801_init()   
 
      #進入選單 Menu (="N")
      CALL asrt801_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asrt801
      
   END IF 
   
   CLOSE asrt801_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asrt801.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asrt801_init()
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
      CALL cl_set_combo_scc_part('srcastus','13','N,Y,A,D,R,W,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1','2',","1")
   CALL g_idx_group.addAttribute("'3',","1")
   CALL g_idx_group.addAttribute("","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_detail_idx4 = 1
   CALL cl_set_combo_scc('srcc010','1202')
   CALL cl_set_combo_scc('srcc901','5448') 
   CALL cl_set_combo_scc('srcd901','5448')
   CALL cl_set_combo_scc('l_srcd901','5448')
   CALL cl_set_combo_scc('srcd010','1201')
   CALL cl_set_combo_scc('l_srcd010','1201')
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = g_prog   #160816-00001#10 mark
   LET g_acc = s_fin_get_scc_value('24',g_prog,'2')  #160816-00001#10  Add
   
   IF g_argv[1] = '2' THEN
      CALL cl_set_comp_visible("srca905,srca906,srcc901,srcc905,srcc905_desc,srcc906,srcd901,srcd905,srcd905_desc,srcd906,l_srcd901,l_srcd905,l_srcd905_desc,l_srcd906",FALSE)
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL asrt801_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asrt801.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asrt801_ui_dialog()
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
            CALL asrt801_insert()
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
         INITIALIZE g_srca_m.* TO NULL
         CALL g_srcc_d.clear()
         CALL g_srcc2_d.clear()
         CALL g_srcc3_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asrt801_init()
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
               
               CALL asrt801_fetch('') # reload data
               LET l_ac = 1
               CALL asrt801_ui_detailshow() #Setting the current row 
         
               CALL asrt801_idx_chk()
               #NEXT FIELD srcc007
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_srcc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt801_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1','2',",l_ac)
               CALL asrt801_b_fill2('2')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               IF NOT cl_null(g_srcc_d[g_detail_idx].srcc007) THEN 
                  CALL s_asrt801_hint_show('srcc_t','srac_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[l_ac].srcc007,0,g_srca_m.srca900)
               END IF
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
               CALL asrt801_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL DIALOG.setCellAttributes(g_srcc_d_color)
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_srcc2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               CALL asrt801_b_fill2('2')
 
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               IF NOT cl_null(g_srcc_d[g_detail_idx].srcc007) THEN 
                  CALL s_asrt801_hint_show('srcc_t','srac_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[l_ac].srcc007,0,g_srca_m.srca900)
               END IF
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
               CALL asrt801_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               CALL DIALOG.setCellAttributes(g_srcc2_d_color)
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #第二階單身段落
         DISPLAY ARRAY g_srcc3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx2 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("",l_ac)
               
               #add-point:page3, before row動作 name="ui_dialog.body3.before_row"
               IF NOT cl_null(g_srcc3_d[g_detail_idx2].srcdseq) THEN 
                  CALL s_asrt801_hint_show('srcd_t','srad_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc3_d[g_detail_idx2].srcdseq,g_srca_m.srca900)  
               END IF                  
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL asrt801_idx_chk()
               #add-point:page3自定義行為 name="ui_dialog.body3.before_display"
               CALL DIALOG.setCellAttributes(g_srcc3_d_color)
               #end add-point
      
            #自訂ACTION(detail_show,page_3)
            
         
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_srcc4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b4)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asrt801_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac
               IF NOT cl_null(g_srcc4_d[g_detail_idx4].l_srcdseq) THEN 
                  CALL s_asrt801_hint_show('srcd_t','srad_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[g_detail_idx4].l_srcdseq,g_srca_m.srca900) 
               END IF
               
            BEFORE DISPLAY
               #如果一直都在單身2則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx4)
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL asrt801_idx_chk()
               CALL DIALOG.setCellAttributes(g_srcc4_d_color)
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL asrt801_browser_fill("")
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
               CALL asrt801_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asrt801_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asrt801_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL asrt801_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL asrt801_set_act_visible()   
            CALL asrt801_set_act_no_visible()
            IF NOT (g_srca_m.srcasite IS NULL
              OR g_srca_m.srca000 IS NULL
              OR g_srca_m.srca001 IS NULL
              OR g_srca_m.srca002 IS NULL
              OR g_srca_m.srca004 IS NULL
              OR g_srca_m.srca005 IS NULL
              OR g_srca_m.srca006 IS NULL
              OR g_srca_m.srca900 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " srcaent = " ||g_enterprise|| " AND",
                                  " srcasite = '", g_srca_m.srcasite, "' "
                                  ," AND srca000 = '", g_srca_m.srca000, "' "
                                  ," AND srca001 = '", g_srca_m.srca001, "' "
                                  ," AND srca002 = '", g_srca_m.srca002, "' "
                                  ," AND srca004 = '", g_srca_m.srca004, "' "
                                  ," AND srca005 = '", g_srca_m.srca005, "' "
                                  ," AND srca006 = '", g_srca_m.srca006, "' "
                                  ," AND srca900 = '", g_srca_m.srca900, "' "
 
               #填到對應位置
               CALL asrt801_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "srca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srcc_t" 
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
               CALL asrt801_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "srca_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "srcc_t" 
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
                  CALL asrt801_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asrt801_fetch("F")
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
               CALL asrt801_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asrt801_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt801_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asrt801_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt801_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asrt801_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt801_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asrt801_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt801_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asrt801_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asrt801_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_srcc_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_srcc2_d)
                  LET g_export_id[2]   = "s_detail2"
                  LET g_export_node[3] = base.typeInfo.create(g_srcc3_d)
                  LET g_export_id[3]   = "s_detail3"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  LET g_export_node[3] = base.typeInfo.create(g_srcc4_d)
                  LET g_export_id[3]   = "s_detail4"
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
               NEXT FIELD srcc007
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
               CALL asrt801_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asrt801_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL asrt801_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asrt801_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/asr/asrt801_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/asr/asrt801_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION hidden_1
            LET g_action_choice="hidden_1"
            IF cl_auth_chk_act("hidden_1") THEN
               
               #add-point:ON ACTION hidden_1 name="menu.hidden_1"
               IF cl_null(g_flag_hidden) OR g_flag_hidden = 'N' THEN
                  LET g_flag_hidden = 'Y' 
               ELSE
                  LET g_flag_hidden = 'N'
               END IF
               LET g_bfill = 'Y'
               CALL asrt801_show()
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asrt801_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
               CALL g_curr_diag.setCurrentRow("s_detail3",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand name="menu.stand"
               IF g_detail_idx > 0 THEN 
                  IF NOT cl_null(g_srcc_d[g_detail_idx].srcc007) AND NOT cl_null(g_srcc_d[g_detail_idx].srcc008) AND NOT cl_null(g_srcc_d[g_detail_idx].srcc009) THEN
                     CALL asrt801_01(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srca_m.srca900,'N')
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asrt801_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asrt801_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asrt801_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
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
 
{<section id="asrt801.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asrt801_browser_fill(ps_page_action)
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
   LET l_wc = l_wc," AND srcasite = '",g_site,"'"
   IF g_argv[1] = '2' THEN
      LET l_wc = l_wc," AND srca000 = '2'"
   ELSE
      LET l_wc = l_wc," AND srca000 = '1'"
   END IF
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900 ", 
 
                      " FROM srca_t ",
                      " ",
                      " LEFT JOIN srcc_t ON srccent = srcaent AND srcasite = srccsite AND srca000 = srcc000 AND srca001 = srcc001 AND srca002 = srcc002 AND srca004 = srcc004 AND srca005 = srcc005 AND srca006 = srcc006 AND srca900 = srcc900 ", "  ",
                      #add-point:browser_fill段sql(srcc_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
                      " LEFT JOIN srcd_t ON srcdent = srcaent AND srccsite = srcdsite AND srcc000 = srcd000 AND srcc001 = srcd001 AND srcc002 = srcd002 AND srcc004 = srcd004 AND srcc005 = srcd005 AND srcc006 = srcd006 AND srcc900 = srcd900 AND srcc007 = srcd007", "  ",
                      #add-point:browser_fill段sql(srcd_t1) name="browser_fill.cnt.join.srcd_t1"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE srcaent = " ||g_enterprise|| " AND srccent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("srca_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900 ", 
 
                      " FROM srca_t ", 
                      "  ",
                      "  ",
                      " WHERE srcaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("srca_t")
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
      INITIALIZE g_srca_m.* TO NULL
      CALL g_srcc_d.clear()        
      CALL g_srcc2_d.clear() 
      CALL g_srcc3_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      CALL g_srcc4_d.clear() 
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.srca001,t0.srca004,t0.srca005,t0.srca006,t0.srca002,t0.srca900,t0.srca902,t0.srca905,t0.srca000,t0.srcasite Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srcastus,t0.srca001,t0.srca004,t0.srca005,t0.srca006,t0.srca002, 
          t0.srca900,t0.srca902,t0.srca905,t0.srca000,t0.srcasite,t1.srza002 ,t2.imaal003 ,t3.imaal004 , 
          t4.imecl005 ,t5.ecba003 ,t6.oocql004 ",
                  " FROM srca_t t0",
                  "  ",
                  "  LEFT JOIN srcc_t ON srccent = srcaent AND srcasite = srccsite AND srca000 = srcc000 AND srca001 = srcc001 AND srca002 = srcc002 AND srca004 = srcc004 AND srca005 = srcc005 AND srca006 = srcc006 AND srca900 = srcc900 ", "  ", 
                  #add-point:browser_fill段sql(srcc_t1) name="browser_fill.join.srcc_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN srcd_t ON srcdent = srcaent AND srccsite = srcdsite AND srcc000 = srcd000 AND srcc001 = srcd001 AND srcc002 = srcd002 AND srcc004 = srcd004 AND srcc005 = srcd005 AND srcc006 = srcd006 AND srcc900 = srcd900 AND srcc007 = srcd007", "  ", 
                  #add-point:browser_fill段sql(srcd_t1) name="browser_fill.join.srcd_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srcasite AND t1.srza001=t0.srca001  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srca004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.srca004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t4 ON t4.imeclent="||g_enterprise||" AND t4.imecl003=t0.srca006 AND t4.imecl004='"||g_dlang||"' ",
               " LEFT JOIN ecba_t t5 ON t5.ecbaent="||g_enterprise||" AND t5.ecbasite=t0.srcasite AND t5.ecba001=t0.srca004 AND t5.ecba002=t0.srca002  ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='225' AND t6.oocql002=t0.srca905 AND t6.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.srcaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("srca_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.srcastus,t0.srca001,t0.srca004,t0.srca005,t0.srca006,t0.srca002, 
          t0.srca900,t0.srca902,t0.srca905,t0.srca000,t0.srcasite,t1.srza002 ,t2.imaal003 ,t3.imaal004 , 
          t4.imecl005 ,t5.ecba003 ,t6.oocql004 ",
                  " FROM srca_t t0",
                  "  ",
                                 " LEFT JOIN srza_t t1 ON t1.srzaent="||g_enterprise||" AND t1.srzasite=t0.srcasite AND t1.srza001=t0.srca001  ",
               " LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=t0.srca004 AND t2.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imaal_t t3 ON t3.imaalent="||g_enterprise||" AND t3.imaal001=t0.srca004 AND t3.imaal002='"||g_dlang||"' ",
               " LEFT JOIN imecl_t t4 ON t4.imeclent="||g_enterprise||" AND t4.imecl003=t0.srca006 AND t4.imecl004='"||g_dlang||"' ",
               " LEFT JOIN ecba_t t5 ON t5.ecbaent="||g_enterprise||" AND t5.ecbasite=t0.srcasite AND t5.ecba001=t0.srca004 AND t5.ecba002=t0.srca002  ",
               " LEFT JOIN oocql_t t6 ON t6.oocqlent="||g_enterprise||" AND t6.oocql001='225' AND t6.oocql002=t0.srca905 AND t6.oocql003='"||g_dlang||"' ",
 
                  " WHERE t0.srcaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("srca_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"srca_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_srca001,g_browser[g_cnt].b_srca004, 
          g_browser[g_cnt].b_srca005,g_browser[g_cnt].b_srca006,g_browser[g_cnt].b_srca002,g_browser[g_cnt].b_srca900, 
          g_browser[g_cnt].b_srca902,g_browser[g_cnt].b_srca905,g_browser[g_cnt].b_srca000,g_browser[g_cnt].b_srcasite, 
          g_browser[g_cnt].b_srca001_desc,g_browser[g_cnt].b_srca004_desc,g_browser[g_cnt].b_srca004_desc_1, 
          g_browser[g_cnt].b_srca006_desc,g_browser[g_cnt].b_srca002_desc,g_browser[g_cnt].b_srca905_desc 
 
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
         CALL asrt801_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_srcasite) THEN
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
 
{<section id="asrt801.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asrt801_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_srca_m.srcasite = g_browser[g_current_idx].b_srcasite   
   LET g_srca_m.srca000 = g_browser[g_current_idx].b_srca000   
   LET g_srca_m.srca001 = g_browser[g_current_idx].b_srca001   
   LET g_srca_m.srca002 = g_browser[g_current_idx].b_srca002   
   LET g_srca_m.srca004 = g_browser[g_current_idx].b_srca004   
   LET g_srca_m.srca005 = g_browser[g_current_idx].b_srca005   
   LET g_srca_m.srca006 = g_browser[g_current_idx].b_srca006   
   LET g_srca_m.srca900 = g_browser[g_current_idx].b_srca900   
 
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
   CALL asrt801_srca_t_mask()
   CALL asrt801_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asrt801.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asrt801_ui_detailshow()
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
 
{<section id="asrt801.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asrt801_ui_browser_refresh()
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
      IF g_browser[l_i].b_srcasite = g_srca_m.srcasite 
         AND g_browser[l_i].b_srca000 = g_srca_m.srca000 
         AND g_browser[l_i].b_srca001 = g_srca_m.srca001 
         AND g_browser[l_i].b_srca002 = g_srca_m.srca002 
         AND g_browser[l_i].b_srca004 = g_srca_m.srca004 
         AND g_browser[l_i].b_srca005 = g_srca_m.srca005 
         AND g_browser[l_i].b_srca006 = g_srca_m.srca006 
         AND g_browser[l_i].b_srca900 = g_srca_m.srca900 
 
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
 
{<section id="asrt801.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asrt801_construct()
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
   INITIALIZE g_srca_m.* TO NULL
   CALL g_srcc_d.clear()        
   CALL g_srcc2_d.clear() 
   CALL g_srcc3_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_srcc4_d.clear()
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON srca001,srca004,srca005,srca006,srca002,srca900,srca902,srca905,srca906, 
          srcastus,srcaownid,srcaowndp,srcacrtid,srcacrtdp,srcacrtdt,srcamodid,srcamoddt,srcacnfid,srcacnfdt 
 
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<srcacrtdt>>----
         AFTER FIELD srcacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<srcamoddt>>----
         AFTER FIELD srcamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<srcacnfdt>>----
         AFTER FIELD srcacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<srcapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.srca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca001
            #add-point:ON ACTION controlp INFIELD srca001 name="construct.c.srca001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca001  #顯示到畫面上
            NEXT FIELD srca001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca001
            #add-point:BEFORE FIELD srca001 name="construct.b.srca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca001
            
            #add-point:AFTER FIELD srca001 name="construct.a.srca001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca004
            #add-point:ON ACTION controlp INFIELD srca004 name="construct.c.srca004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca004  #顯示到畫面上
            NEXT FIELD srca004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca004
            #add-point:BEFORE FIELD srca004 name="construct.b.srca004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca004
            
            #add-point:AFTER FIELD srca004 name="construct.a.srca004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca005
            #add-point:ON ACTION controlp INFIELD srca005 name="construct.c.srca005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca005  #顯示到畫面上
            NEXT FIELD srca005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca005
            #add-point:BEFORE FIELD srca005 name="construct.b.srca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca005
            
            #add-point:AFTER FIELD srca005 name="construct.a.srca005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca006
            #add-point:ON ACTION controlp INFIELD srca006 name="construct.c.srca006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca006  #顯示到畫面上
            NEXT FIELD srca006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca006
            #add-point:BEFORE FIELD srca006 name="construct.b.srca006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca006
            
            #add-point:AFTER FIELD srca006 name="construct.a.srca006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca002
            #add-point:ON ACTION controlp INFIELD srca002 name="construct.c.srca002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_srac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca002  #顯示到畫面上
            NEXT FIELD srca002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca002
            #add-point:BEFORE FIELD srca002 name="construct.b.srca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca002
            
            #add-point:AFTER FIELD srca002 name="construct.a.srca002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca900
            #add-point:BEFORE FIELD srca900 name="construct.b.srca900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca900
            
            #add-point:AFTER FIELD srca900 name="construct.a.srca900"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca900
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca900
            #add-point:ON ACTION controlp INFIELD srca900 name="construct.c.srca900"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca902
            #add-point:BEFORE FIELD srca902 name="construct.b.srca902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca902
            
            #add-point:AFTER FIELD srca902 name="construct.a.srca902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca902
            #add-point:ON ACTION controlp INFIELD srca902 name="construct.c.srca902"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srca905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca905
            #add-point:ON ACTION controlp INFIELD srca905 name="construct.c.srca905"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srca905  #顯示到畫面上
            NEXT FIELD srca905                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca905
            #add-point:BEFORE FIELD srca905 name="construct.b.srca905"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca905
            
            #add-point:AFTER FIELD srca905 name="construct.a.srca905"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca906
            #add-point:BEFORE FIELD srca906 name="construct.b.srca906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca906
            
            #add-point:AFTER FIELD srca906 name="construct.a.srca906"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srca906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca906
            #add-point:ON ACTION controlp INFIELD srca906 name="construct.c.srca906"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcastus
            #add-point:BEFORE FIELD srcastus name="construct.b.srcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcastus
            
            #add-point:AFTER FIELD srcastus name="construct.a.srcastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcastus
            #add-point:ON ACTION controlp INFIELD srcastus name="construct.c.srcastus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srcaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcaownid
            #add-point:ON ACTION controlp INFIELD srcaownid name="construct.c.srcaownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcaownid  #顯示到畫面上
            NEXT FIELD srcaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcaownid
            #add-point:BEFORE FIELD srcaownid name="construct.b.srcaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcaownid
            
            #add-point:AFTER FIELD srcaownid name="construct.a.srcaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srcaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcaowndp
            #add-point:ON ACTION controlp INFIELD srcaowndp name="construct.c.srcaowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcaowndp  #顯示到畫面上
            NEXT FIELD srcaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcaowndp
            #add-point:BEFORE FIELD srcaowndp name="construct.b.srcaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcaowndp
            
            #add-point:AFTER FIELD srcaowndp name="construct.a.srcaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srcacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcacrtid
            #add-point:ON ACTION controlp INFIELD srcacrtid name="construct.c.srcacrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcacrtid  #顯示到畫面上
            NEXT FIELD srcacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcacrtid
            #add-point:BEFORE FIELD srcacrtid name="construct.b.srcacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcacrtid
            
            #add-point:AFTER FIELD srcacrtid name="construct.a.srcacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.srcacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcacrtdp
            #add-point:ON ACTION controlp INFIELD srcacrtdp name="construct.c.srcacrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcacrtdp  #顯示到畫面上
            NEXT FIELD srcacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcacrtdp
            #add-point:BEFORE FIELD srcacrtdp name="construct.b.srcacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcacrtdp
            
            #add-point:AFTER FIELD srcacrtdp name="construct.a.srcacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcacrtdt
            #add-point:BEFORE FIELD srcacrtdt name="construct.b.srcacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srcamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcamodid
            #add-point:ON ACTION controlp INFIELD srcamodid name="construct.c.srcamodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcamodid  #顯示到畫面上
            NEXT FIELD srcamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcamodid
            #add-point:BEFORE FIELD srcamodid name="construct.b.srcamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcamodid
            
            #add-point:AFTER FIELD srcamodid name="construct.a.srcamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcamoddt
            #add-point:BEFORE FIELD srcamoddt name="construct.b.srcamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.srcacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcacnfid
            #add-point:ON ACTION controlp INFIELD srcacnfid name="construct.c.srcacnfid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcacnfid  #顯示到畫面上
            NEXT FIELD srcacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcacnfid
            #add-point:BEFORE FIELD srcacnfid name="construct.b.srcacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcacnfid
            
            #add-point:AFTER FIELD srcacnfid name="construct.a.srcacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcacnfdt
            #add-point:BEFORE FIELD srcacnfdt name="construct.b.srcacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015, 
          srcc016,srcc017,srcc018,srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025, 
          srcc026,srcc046,srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc905,srcc906,l_srcc008_2, 
          l_srcc009_2,l_srcc016_2,srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040, 
          srcc041,srcc042,srcc043,srcc044,srcc045
           FROM s_detail1[1].srcc007,s_detail1[1].srcc008,s_detail1[1].srcc009,s_detail1[1].srcc010, 
               s_detail1[1].srcc011,s_detail1[1].srcc012,s_detail1[1].srcc013,s_detail1[1].srcc014,s_detail1[1].srcc015, 
               s_detail1[1].srcc016,s_detail1[1].srcc017,s_detail1[1].srcc018,s_detail1[1].srcc019,s_detail1[1].srcc020, 
               s_detail1[1].srcc036,s_detail1[1].srcc037,s_detail1[1].srcc021,s_detail1[1].srcc022,s_detail1[1].srcc023, 
               s_detail1[1].srcc024,s_detail1[1].srcc025,s_detail1[1].srcc026,s_detail1[1].srcc046,s_detail1[1].srcc047, 
               s_detail1[1].srcc048,s_detail1[1].srcc027,s_detail1[1].srcc028,s_detail1[1].srcc029,s_detail1[1].srcc901, 
               s_detail1[1].srcc905,s_detail1[1].srcc906,s_detail2[1].l_srcc008_2,s_detail2[1].l_srcc009_2, 
               s_detail2[1].l_srcc016_2,s_detail2[1].srcc030,s_detail2[1].srcc031,s_detail2[1].srcc032, 
               s_detail2[1].srcc033,s_detail2[1].srcc034,s_detail2[1].srcc035,s_detail2[1].srcc038,s_detail2[1].srcc039, 
               s_detail2[1].srcc040,s_detail2[1].srcc041,s_detail2[1].srcc042,s_detail2[1].srcc043,s_detail2[1].srcc044, 
               s_detail2[1].srcc045
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc007
            #add-point:BEFORE FIELD srcc007 name="construct.b.page1.srcc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc007
            
            #add-point:AFTER FIELD srcc007 name="construct.a.page1.srcc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc007
            #add-point:ON ACTION controlp INFIELD srcc007 name="construct.c.page1.srcc007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc008
            #add-point:ON ACTION controlp INFIELD srcc008 name="construct.c.page1.srcc008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc008  #顯示到畫面上
            NEXT FIELD srcc008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc008
            #add-point:BEFORE FIELD srcc008 name="construct.b.page1.srcc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc008
            
            #add-point:AFTER FIELD srcc008 name="construct.a.page1.srcc008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc009
            #add-point:BEFORE FIELD srcc009 name="construct.b.page1.srcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc009
            
            #add-point:AFTER FIELD srcc009 name="construct.a.page1.srcc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc009
            #add-point:ON ACTION controlp INFIELD srcc009 name="construct.c.page1.srcc009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc010
            #add-point:BEFORE FIELD srcc010 name="construct.b.page1.srcc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc010
            
            #add-point:AFTER FIELD srcc010 name="construct.a.page1.srcc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc010
            #add-point:ON ACTION controlp INFIELD srcc010 name="construct.c.page1.srcc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc011
            #add-point:BEFORE FIELD srcc011 name="construct.b.page1.srcc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc011
            
            #add-point:AFTER FIELD srcc011 name="construct.a.page1.srcc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc011
            #add-point:ON ACTION controlp INFIELD srcc011 name="construct.c.page1.srcc011"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc012
            #add-point:ON ACTION controlp INFIELD srcc012 name="construct.c.page1.srcc012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc012  #顯示到畫面上
            NEXT FIELD srcc012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc012
            #add-point:BEFORE FIELD srcc012 name="construct.b.page1.srcc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc012
            
            #add-point:AFTER FIELD srcc012 name="construct.a.page1.srcc012"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc013
            #add-point:BEFORE FIELD srcc013 name="construct.b.page1.srcc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc013
            
            #add-point:AFTER FIELD srcc013 name="construct.a.page1.srcc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc013
            #add-point:ON ACTION controlp INFIELD srcc013 name="construct.c.page1.srcc013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc014
            #add-point:ON ACTION controlp INFIELD srcc014 name="construct.c.page1.srcc014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc014  #顯示到畫面上
            NEXT FIELD srcc014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc014
            #add-point:BEFORE FIELD srcc014 name="construct.b.page1.srcc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc014
            
            #add-point:AFTER FIELD srcc014 name="construct.a.page1.srcc014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc015
            #add-point:BEFORE FIELD srcc015 name="construct.b.page1.srcc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc015
            
            #add-point:AFTER FIELD srcc015 name="construct.a.page1.srcc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc015
            #add-point:ON ACTION controlp INFIELD srcc015 name="construct.c.page1.srcc015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc016
            #add-point:ON ACTION controlp INFIELD srcc016 name="construct.c.page1.srcc016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc016  #顯示到畫面上
            NEXT FIELD srcc016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc016
            #add-point:BEFORE FIELD srcc016 name="construct.b.page1.srcc016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc016
            
            #add-point:AFTER FIELD srcc016 name="construct.a.page1.srcc016"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc017
            #add-point:BEFORE FIELD srcc017 name="construct.b.page1.srcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc017
            
            #add-point:AFTER FIELD srcc017 name="construct.a.page1.srcc017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc017
            #add-point:ON ACTION controlp INFIELD srcc017 name="construct.c.page1.srcc017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc018
            #add-point:BEFORE FIELD srcc018 name="construct.b.page1.srcc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc018
            
            #add-point:AFTER FIELD srcc018 name="construct.a.page1.srcc018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc018
            #add-point:ON ACTION controlp INFIELD srcc018 name="construct.c.page1.srcc018"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc019
            #add-point:BEFORE FIELD srcc019 name="construct.b.page1.srcc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc019
            
            #add-point:AFTER FIELD srcc019 name="construct.a.page1.srcc019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc019
            #add-point:ON ACTION controlp INFIELD srcc019 name="construct.c.page1.srcc019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc020
            #add-point:BEFORE FIELD srcc020 name="construct.b.page1.srcc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc020
            
            #add-point:AFTER FIELD srcc020 name="construct.a.page1.srcc020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc020
            #add-point:ON ACTION controlp INFIELD srcc020 name="construct.c.page1.srcc020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc036
            #add-point:BEFORE FIELD srcc036 name="construct.b.page1.srcc036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc036
            
            #add-point:AFTER FIELD srcc036 name="construct.a.page1.srcc036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc036
            #add-point:ON ACTION controlp INFIELD srcc036 name="construct.c.page1.srcc036"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc037
            #add-point:ON ACTION controlp INFIELD srcc037 name="construct.c.page1.srcc037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc037  #顯示到畫面上
            NEXT FIELD srcc037                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc037
            #add-point:BEFORE FIELD srcc037 name="construct.b.page1.srcc037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc037
            
            #add-point:AFTER FIELD srcc037 name="construct.a.page1.srcc037"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc021
            #add-point:BEFORE FIELD srcc021 name="construct.b.page1.srcc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc021
            
            #add-point:AFTER FIELD srcc021 name="construct.a.page1.srcc021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc021
            #add-point:ON ACTION controlp INFIELD srcc021 name="construct.c.page1.srcc021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc022
            #add-point:BEFORE FIELD srcc022 name="construct.b.page1.srcc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc022
            
            #add-point:AFTER FIELD srcc022 name="construct.a.page1.srcc022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc022
            #add-point:ON ACTION controlp INFIELD srcc022 name="construct.c.page1.srcc022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc023
            #add-point:BEFORE FIELD srcc023 name="construct.b.page1.srcc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc023
            
            #add-point:AFTER FIELD srcc023 name="construct.a.page1.srcc023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc023
            #add-point:ON ACTION controlp INFIELD srcc023 name="construct.c.page1.srcc023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc024
            #add-point:BEFORE FIELD srcc024 name="construct.b.page1.srcc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc024
            
            #add-point:AFTER FIELD srcc024 name="construct.a.page1.srcc024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc024
            #add-point:ON ACTION controlp INFIELD srcc024 name="construct.c.page1.srcc024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc025
            #add-point:BEFORE FIELD srcc025 name="construct.b.page1.srcc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc025
            
            #add-point:AFTER FIELD srcc025 name="construct.a.page1.srcc025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc025
            #add-point:ON ACTION controlp INFIELD srcc025 name="construct.c.page1.srcc025"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc026
            #add-point:BEFORE FIELD srcc026 name="construct.b.page1.srcc026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc026
            
            #add-point:AFTER FIELD srcc026 name="construct.a.page1.srcc026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc026
            #add-point:ON ACTION controlp INFIELD srcc026 name="construct.c.page1.srcc026"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc046
            #add-point:ON ACTION controlp INFIELD srcc046 name="construct.c.page1.srcc046"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc046  #顯示到畫面上
            NEXT FIELD srcc046                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc046
            #add-point:BEFORE FIELD srcc046 name="construct.b.page1.srcc046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc046
            
            #add-point:AFTER FIELD srcc046 name="construct.a.page1.srcc046"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc047
            #add-point:BEFORE FIELD srcc047 name="construct.b.page1.srcc047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc047
            
            #add-point:AFTER FIELD srcc047 name="construct.a.page1.srcc047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc047
            #add-point:ON ACTION controlp INFIELD srcc047 name="construct.c.page1.srcc047"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc048
            #add-point:BEFORE FIELD srcc048 name="construct.b.page1.srcc048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc048
            
            #add-point:AFTER FIELD srcc048 name="construct.a.page1.srcc048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc048
            #add-point:ON ACTION controlp INFIELD srcc048 name="construct.c.page1.srcc048"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc027
            #add-point:ON ACTION controlp INFIELD srcc027 name="construct.c.page1.srcc027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc027  #顯示到畫面上
            NEXT FIELD srcc027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc027
            #add-point:BEFORE FIELD srcc027 name="construct.b.page1.srcc027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc027
            
            #add-point:AFTER FIELD srcc027 name="construct.a.page1.srcc027"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc028
            #add-point:BEFORE FIELD srcc028 name="construct.b.page1.srcc028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc028
            
            #add-point:AFTER FIELD srcc028 name="construct.a.page1.srcc028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc028
            #add-point:ON ACTION controlp INFIELD srcc028 name="construct.c.page1.srcc028"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc029
            #add-point:BEFORE FIELD srcc029 name="construct.b.page1.srcc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc029
            
            #add-point:AFTER FIELD srcc029 name="construct.a.page1.srcc029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc029
            #add-point:ON ACTION controlp INFIELD srcc029 name="construct.c.page1.srcc029"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc901
            #add-point:BEFORE FIELD srcc901 name="construct.b.page1.srcc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc901
            
            #add-point:AFTER FIELD srcc901 name="construct.a.page1.srcc901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc901
            #add-point:ON ACTION controlp INFIELD srcc901 name="construct.c.page1.srcc901"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.srcc905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc905
            #add-point:ON ACTION controlp INFIELD srcc905 name="construct.c.page1.srcc905"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcc905  #顯示到畫面上
            NEXT FIELD srcc905                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc905
            #add-point:BEFORE FIELD srcc905 name="construct.b.page1.srcc905"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc905
            
            #add-point:AFTER FIELD srcc905 name="construct.a.page1.srcc905"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc906
            #add-point:BEFORE FIELD srcc906 name="construct.b.page1.srcc906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc906
            
            #add-point:AFTER FIELD srcc906 name="construct.a.page1.srcc906"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.srcc906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc906
            #add-point:ON ACTION controlp INFIELD srcc906 name="construct.c.page1.srcc906"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc008_2
            #add-point:BEFORE FIELD l_srcc008_2 name="construct.b.page2.l_srcc008_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc008_2
            
            #add-point:AFTER FIELD l_srcc008_2 name="construct.a.page2.l_srcc008_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_srcc008_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc008_2
            #add-point:ON ACTION controlp INFIELD l_srcc008_2 name="construct.c.page2.l_srcc008_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc009_2
            #add-point:BEFORE FIELD l_srcc009_2 name="construct.b.page2.l_srcc009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc009_2
            
            #add-point:AFTER FIELD l_srcc009_2 name="construct.a.page2.l_srcc009_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_srcc009_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc009_2
            #add-point:ON ACTION controlp INFIELD l_srcc009_2 name="construct.c.page2.l_srcc009_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc016_2
            #add-point:BEFORE FIELD l_srcc016_2 name="construct.b.page2.l_srcc016_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc016_2
            
            #add-point:AFTER FIELD l_srcc016_2 name="construct.a.page2.l_srcc016_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.l_srcc016_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc016_2
            #add-point:ON ACTION controlp INFIELD l_srcc016_2 name="construct.c.page2.l_srcc016_2"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc030
            #add-point:BEFORE FIELD srcc030 name="construct.b.page2.srcc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc030
            
            #add-point:AFTER FIELD srcc030 name="construct.a.page2.srcc030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc030
            #add-point:ON ACTION controlp INFIELD srcc030 name="construct.c.page2.srcc030"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc031
            #add-point:BEFORE FIELD srcc031 name="construct.b.page2.srcc031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc031
            
            #add-point:AFTER FIELD srcc031 name="construct.a.page2.srcc031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc031
            #add-point:ON ACTION controlp INFIELD srcc031 name="construct.c.page2.srcc031"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc032
            #add-point:BEFORE FIELD srcc032 name="construct.b.page2.srcc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc032
            
            #add-point:AFTER FIELD srcc032 name="construct.a.page2.srcc032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc032
            #add-point:ON ACTION controlp INFIELD srcc032 name="construct.c.page2.srcc032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc033
            #add-point:BEFORE FIELD srcc033 name="construct.b.page2.srcc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc033
            
            #add-point:AFTER FIELD srcc033 name="construct.a.page2.srcc033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc033
            #add-point:ON ACTION controlp INFIELD srcc033 name="construct.c.page2.srcc033"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc034
            #add-point:BEFORE FIELD srcc034 name="construct.b.page2.srcc034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc034
            
            #add-point:AFTER FIELD srcc034 name="construct.a.page2.srcc034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc034
            #add-point:ON ACTION controlp INFIELD srcc034 name="construct.c.page2.srcc034"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc035
            #add-point:BEFORE FIELD srcc035 name="construct.b.page2.srcc035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc035
            
            #add-point:AFTER FIELD srcc035 name="construct.a.page2.srcc035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc035
            #add-point:ON ACTION controlp INFIELD srcc035 name="construct.c.page2.srcc035"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc038
            #add-point:BEFORE FIELD srcc038 name="construct.b.page2.srcc038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc038
            
            #add-point:AFTER FIELD srcc038 name="construct.a.page2.srcc038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc038
            #add-point:ON ACTION controlp INFIELD srcc038 name="construct.c.page2.srcc038"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc039
            #add-point:BEFORE FIELD srcc039 name="construct.b.page2.srcc039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc039
            
            #add-point:AFTER FIELD srcc039 name="construct.a.page2.srcc039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc039
            #add-point:ON ACTION controlp INFIELD srcc039 name="construct.c.page2.srcc039"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc040
            #add-point:BEFORE FIELD srcc040 name="construct.b.page2.srcc040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc040
            
            #add-point:AFTER FIELD srcc040 name="construct.a.page2.srcc040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc040
            #add-point:ON ACTION controlp INFIELD srcc040 name="construct.c.page2.srcc040"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc041
            #add-point:BEFORE FIELD srcc041 name="construct.b.page2.srcc041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc041
            
            #add-point:AFTER FIELD srcc041 name="construct.a.page2.srcc041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc041
            #add-point:ON ACTION controlp INFIELD srcc041 name="construct.c.page2.srcc041"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc042
            #add-point:BEFORE FIELD srcc042 name="construct.b.page2.srcc042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc042
            
            #add-point:AFTER FIELD srcc042 name="construct.a.page2.srcc042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc042
            #add-point:ON ACTION controlp INFIELD srcc042 name="construct.c.page2.srcc042"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc043
            #add-point:BEFORE FIELD srcc043 name="construct.b.page2.srcc043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc043
            
            #add-point:AFTER FIELD srcc043 name="construct.a.page2.srcc043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc043
            #add-point:ON ACTION controlp INFIELD srcc043 name="construct.c.page2.srcc043"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc044
            #add-point:BEFORE FIELD srcc044 name="construct.b.page2.srcc044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc044
            
            #add-point:AFTER FIELD srcc044 name="construct.a.page2.srcc044"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc044
            #add-point:ON ACTION controlp INFIELD srcc044 name="construct.c.page2.srcc044"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc045
            #add-point:BEFORE FIELD srcc045 name="construct.b.page2.srcc045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc045
            
            #add-point:AFTER FIELD srcc045 name="construct.a.page2.srcc045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.srcc045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc045
            #add-point:ON ACTION controlp INFIELD srcc045 name="construct.c.page2.srcc045"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901, 
          srcd905,srcd906
           FROM s_detail3[1].srcdseq,s_detail3[1].srcd008,s_detail3[1].srcd009,s_detail3[1].srcd010, 
               s_detail3[1].srcd011,s_detail3[1].srcd012,s_detail3[1].srcd013,s_detail3[1].srcd014,s_detail3[1].srcd901, 
               s_detail3[1].srcd905,s_detail3[1].srcd906
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcdseq
            #add-point:BEFORE FIELD srcdseq name="construct.b.page3.srcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcdseq
            
            #add-point:AFTER FIELD srcdseq name="construct.a.page3.srcdseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcdseq
            #add-point:ON ACTION controlp INFIELD srcdseq name="construct.c.page3.srcdseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd008
            #add-point:BEFORE FIELD srcd008 name="construct.b.page3.srcd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd008
            
            #add-point:AFTER FIELD srcd008 name="construct.a.page3.srcd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd008
            #add-point:ON ACTION controlp INFIELD srcd008 name="construct.c.page3.srcd008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.srcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd009
            #add-point:ON ACTION controlp INFIELD srcd009 name="construct.c.page3.srcd009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcd009  #顯示到畫面上
            NEXT FIELD srcd009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd009
            #add-point:BEFORE FIELD srcd009 name="construct.b.page3.srcd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd009
            
            #add-point:AFTER FIELD srcd009 name="construct.a.page3.srcd009"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd010
            #add-point:BEFORE FIELD srcd010 name="construct.b.page3.srcd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd010
            
            #add-point:AFTER FIELD srcd010 name="construct.a.page3.srcd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd010
            #add-point:ON ACTION controlp INFIELD srcd010 name="construct.c.page3.srcd010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd011
            #add-point:BEFORE FIELD srcd011 name="construct.b.page3.srcd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd011
            
            #add-point:AFTER FIELD srcd011 name="construct.a.page3.srcd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd011
            #add-point:ON ACTION controlp INFIELD srcd011 name="construct.c.page3.srcd011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd012
            #add-point:BEFORE FIELD srcd012 name="construct.b.page3.srcd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd012
            
            #add-point:AFTER FIELD srcd012 name="construct.a.page3.srcd012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd012
            #add-point:ON ACTION controlp INFIELD srcd012 name="construct.c.page3.srcd012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd013
            #add-point:BEFORE FIELD srcd013 name="construct.b.page3.srcd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd013
            
            #add-point:AFTER FIELD srcd013 name="construct.a.page3.srcd013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd013
            #add-point:ON ACTION controlp INFIELD srcd013 name="construct.c.page3.srcd013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd014
            #add-point:BEFORE FIELD srcd014 name="construct.b.page3.srcd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd014
            
            #add-point:AFTER FIELD srcd014 name="construct.a.page3.srcd014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd014
            #add-point:ON ACTION controlp INFIELD srcd014 name="construct.c.page3.srcd014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd901
            #add-point:BEFORE FIELD srcd901 name="construct.b.page3.srcd901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd901
            
            #add-point:AFTER FIELD srcd901 name="construct.a.page3.srcd901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd901
            #add-point:ON ACTION controlp INFIELD srcd901 name="construct.c.page3.srcd901"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page3.srcd905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd905
            #add-point:ON ACTION controlp INFIELD srcd905 name="construct.c.page3.srcd905"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO srcd905  #顯示到畫面上
            NEXT FIELD srcd905                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd905
            #add-point:BEFORE FIELD srcd905 name="construct.b.page3.srcd905"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd905
            
            #add-point:AFTER FIELD srcd905 name="construct.a.page3.srcd905"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd906
            #add-point:BEFORE FIELD srcd906 name="construct.b.page3.srcd906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd906
            
            #add-point:AFTER FIELD srcd906 name="construct.a.page3.srcd906"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.srcd906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd906
            #add-point:ON ACTION controlp INFIELD srcd906 name="construct.c.page3.srcd906"
            
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
                  WHEN la_wc[li_idx].tableid = "srca_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "srcc_t" 
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
 
{<section id="asrt801.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asrt801_filter()
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
      CONSTRUCT g_wc_filter ON srca001,srca004,srca005,srca006,srca002,srca900,srca902,srca905,srca000, 
          srcasite
                          FROM s_browse[1].b_srca001,s_browse[1].b_srca004,s_browse[1].b_srca005,s_browse[1].b_srca006, 
                              s_browse[1].b_srca002,s_browse[1].b_srca900,s_browse[1].b_srca902,s_browse[1].b_srca905, 
                              s_browse[1].b_srca000,s_browse[1].b_srcasite
 
         BEFORE CONSTRUCT
               DISPLAY asrt801_filter_parser('srca001') TO s_browse[1].b_srca001
            DISPLAY asrt801_filter_parser('srca004') TO s_browse[1].b_srca004
            DISPLAY asrt801_filter_parser('srca005') TO s_browse[1].b_srca005
            DISPLAY asrt801_filter_parser('srca006') TO s_browse[1].b_srca006
            DISPLAY asrt801_filter_parser('srca002') TO s_browse[1].b_srca002
            DISPLAY asrt801_filter_parser('srca900') TO s_browse[1].b_srca900
            DISPLAY asrt801_filter_parser('srca902') TO s_browse[1].b_srca902
            DISPLAY asrt801_filter_parser('srca905') TO s_browse[1].b_srca905
            DISPLAY asrt801_filter_parser('srca000') TO s_browse[1].b_srca000
            DISPLAY asrt801_filter_parser('srcasite') TO s_browse[1].b_srcasite
      
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
 
      CALL asrt801_filter_show('srca001')
   CALL asrt801_filter_show('srca004')
   CALL asrt801_filter_show('srca005')
   CALL asrt801_filter_show('srca006')
   CALL asrt801_filter_show('srca002')
   CALL asrt801_filter_show('srca900')
   CALL asrt801_filter_show('srca902')
   CALL asrt801_filter_show('srca905')
   CALL asrt801_filter_show('srca000')
   CALL asrt801_filter_show('srcasite')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asrt801_filter_parser(ps_field)
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
 
{<section id="asrt801.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asrt801_filter_show(ps_field)
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
   LET ls_condition = asrt801_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asrt801_query()
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
   CALL g_srcc_d.clear()
   CALL g_srcc2_d.clear()
   CALL g_srcc3_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL g_srcc4_d.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asrt801_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asrt801_browser_fill("")
      CALL asrt801_fetch("")
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
      CALL asrt801_filter_show('srca001')
   CALL asrt801_filter_show('srca004')
   CALL asrt801_filter_show('srca005')
   CALL asrt801_filter_show('srca006')
   CALL asrt801_filter_show('srca002')
   CALL asrt801_filter_show('srca900')
   CALL asrt801_filter_show('srca902')
   CALL asrt801_filter_show('srca905')
   CALL asrt801_filter_show('srca000')
   CALL asrt801_filter_show('srcasite')
   CALL asrt801_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asrt801_fetch("F") 
      #顯示單身筆數
      CALL asrt801_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asrt801_fetch(p_flag)
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
   CALL g_srcc3_d.clear()
 
   
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
   
   LET g_srca_m.srcasite = g_browser[g_current_idx].b_srcasite
   LET g_srca_m.srca000 = g_browser[g_current_idx].b_srca000
   LET g_srca_m.srca001 = g_browser[g_current_idx].b_srca001
   LET g_srca_m.srca002 = g_browser[g_current_idx].b_srca002
   LET g_srca_m.srca004 = g_browser[g_current_idx].b_srca004
   LET g_srca_m.srca005 = g_browser[g_current_idx].b_srca005
   LET g_srca_m.srca006 = g_browser[g_current_idx].b_srca006
   LET g_srca_m.srca900 = g_browser[g_current_idx].b_srca900
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
   #遮罩相關處理
   LET g_srca_m_mask_o.* =  g_srca_m.*
   CALL asrt801_srca_t_mask()
   LET g_srca_m_mask_n.* =  g_srca_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt801_set_act_visible()   
   CALL asrt801_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_srca_m_t.* = g_srca_m.*
   LET g_srca_m_o.* = g_srca_m.*
   
   LET g_data_owner = g_srca_m.srcaownid      
   LET g_data_dept  = g_srca_m.srcaowndp
   
   #重新顯示   
   CALL asrt801_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.insert" >}
#+ 資料新增
PRIVATE FUNCTION asrt801_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   CALL g_srcc4_d.clear()
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_srcc_d.clear()   
   CALL g_srcc2_d.clear()  
   CALL g_srcc3_d.clear()  
 
 
   INITIALIZE g_srca_m.* TO NULL             #DEFAULT 設定
   
   LET g_srcasite_t = NULL
   LET g_srca000_t = NULL
   LET g_srca001_t = NULL
   LET g_srca002_t = NULL
   LET g_srca004_t = NULL
   LET g_srca005_t = NULL
   LET g_srca006_t = NULL
   LET g_srca900_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_srca_m.srcaownid = g_user
      LET g_srca_m.srcaowndp = g_dept
      LET g_srca_m.srcacrtid = g_user
      LET g_srca_m.srcacrtdp = g_dept 
      LET g_srca_m.srcacrtdt = cl_get_current()
      LET g_srca_m.srcamodid = g_user
      LET g_srca_m.srcamoddt = cl_get_current()
      LET g_srca_m.srcastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_srca_m.srcasite = g_site
      IF g_argv[1] = '2' THEN
         LET g_srca_m.srca000 = '2'
      ELSE
         LET g_srca_m.srca000 = '1'
      END IF
    # LET g_srca_m.srca900 = 1
      LET g_srca_m.srca902 = cl_get_today()
      LET g_srca_m_t.* = g_srca_m.*
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_srca_m_t.* = g_srca_m.*
      LET g_srca_m_o.* = g_srca_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srca_m.srcastus 
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
 
 
 
    
      CALL asrt801_input("a")
      
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
         INITIALIZE g_srca_m.* TO NULL
         INITIALIZE g_srcc_d TO NULL
         INITIALIZE g_srcc2_d TO NULL
         INITIALIZE g_srcc3_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL asrt801_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_srcc_d.clear()
      #CALL g_srcc2_d.clear()
      #CALL g_srcc3_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asrt801_set_act_visible()   
   CALL asrt801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srcasite_t = g_srca_m.srcasite
   LET g_srca000_t = g_srca_m.srca000
   LET g_srca001_t = g_srca_m.srca001
   LET g_srca002_t = g_srca_m.srca002
   LET g_srca004_t = g_srca_m.srca004
   LET g_srca005_t = g_srca_m.srca005
   LET g_srca006_t = g_srca_m.srca006
   LET g_srca900_t = g_srca_m.srca900
 
   
   #組合新增資料的條件
   LET g_add_browse = " srcaent = " ||g_enterprise|| " AND",
                      " srcasite = '", g_srca_m.srcasite, "' "
                      ," AND srca000 = '", g_srca_m.srca000, "' "
                      ," AND srca001 = '", g_srca_m.srca001, "' "
                      ," AND srca002 = '", g_srca_m.srca002, "' "
                      ," AND srca004 = '", g_srca_m.srca004, "' "
                      ," AND srca005 = '", g_srca_m.srca005, "' "
                      ," AND srca006 = '", g_srca_m.srca006, "' "
                      ," AND srca900 = '", g_srca_m.srca900, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asrt801_cl
   
   CALL asrt801_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
   
   #遮罩相關處理
   LET g_srca_m_mask_o.* =  g_srca_m.*
   CALL asrt801_srca_t_mask()
   LET g_srca_m_mask_n.* =  g_srca_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca001_desc,g_srca_m.srca004, 
       g_srca_m.srca004_desc,g_srca_m.srca004_desc_1,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca006_desc, 
       g_srca_m.srca002,g_srca_m.srca002_desc,g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca905_desc, 
       g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp, 
       g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp,g_srca_m.srcacrtdp_desc, 
       g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamodid_desc,g_srca_m.srcamoddt,g_srca_m.srcacnfid, 
       g_srca_m.srcacnfid_desc,g_srca_m.srcacnfdt
   
   #add-point:新增結束後 name="insert.after"
   IF g_flag = 'N' THEN
      LET g_flag = 'Y'
      CALL asrt801_modify()
   END IF
   #end add-point 
   
   LET g_data_owner = g_srca_m.srcaownid      
   LET g_data_dept  = g_srca_m.srcaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt801_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.modify" >}
#+ 資料修改
PRIVATE FUNCTION asrt801_modify()
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
   LET g_srca_m_t.* = g_srca_m.*
   LET g_srca_m_o.* = g_srca_m.*
   
   IF g_srca_m.srcasite IS NULL
   OR g_srca_m.srca000 IS NULL
   OR g_srca_m.srca001 IS NULL
   OR g_srca_m.srca002 IS NULL
   OR g_srca_m.srca004 IS NULL
   OR g_srca_m.srca005 IS NULL
   OR g_srca_m.srca006 IS NULL
   OR g_srca_m.srca900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_srcasite_t = g_srca_m.srcasite
   LET g_srca000_t = g_srca_m.srca000
   LET g_srca001_t = g_srca_m.srca001
   LET g_srca002_t = g_srca_m.srca002
   LET g_srca004_t = g_srca_m.srca004
   LET g_srca005_t = g_srca_m.srca005
   LET g_srca006_t = g_srca_m.srca006
   LET g_srca900_t = g_srca_m.srca900
 
   CALL s_transaction_begin()
   
   OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
   #檢查是否允許此動作
   IF NOT asrt801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srca_m_mask_o.* =  g_srca_m.*
   CALL asrt801_srca_t_mask()
   LET g_srca_m_mask_n.* =  g_srca_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL asrt801_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_srcasite_t = g_srca_m.srcasite
      LET g_srca000_t = g_srca_m.srca000
      LET g_srca001_t = g_srca_m.srca001
      LET g_srca002_t = g_srca_m.srca002
      LET g_srca004_t = g_srca_m.srca004
      LET g_srca005_t = g_srca_m.srca005
      LET g_srca006_t = g_srca_m.srca006
      LET g_srca900_t = g_srca_m.srca900
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_srca_m.srcamodid = g_user 
LET g_srca_m.srcamoddt = cl_get_current()
LET g_srca_m.srcamodid_desc = cl_get_username(g_srca_m.srcamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asrt801_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE srca_t SET (srcamodid,srcamoddt) = (g_srca_m.srcamodid,g_srca_m.srcamoddt)
          WHERE srcaent = g_enterprise AND srcasite = g_srcasite_t
            AND srca000 = g_srca000_t
            AND srca001 = g_srca001_t
            AND srca002 = g_srca002_t
            AND srca004 = g_srca004_t
            AND srca005 = g_srca005_t
            AND srca006 = g_srca006_t
            AND srca900 = g_srca900_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_srca_m.* = g_srca_m_t.*
            CALL asrt801_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_srca_m.srcasite != g_srca_m_t.srcasite
      OR g_srca_m.srca000 != g_srca_m_t.srca000
      OR g_srca_m.srca001 != g_srca_m_t.srca001
      OR g_srca_m.srca002 != g_srca_m_t.srca002
      OR g_srca_m.srca004 != g_srca_m_t.srca004
      OR g_srca_m.srca005 != g_srca_m_t.srca005
      OR g_srca_m.srca006 != g_srca_m_t.srca006
      OR g_srca_m.srca900 != g_srca_m_t.srca900
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE srcc_t SET srccsite = g_srca_m.srcasite
                                       ,srcc000 = g_srca_m.srca000
                                       ,srcc001 = g_srca_m.srca001
                                       ,srcc002 = g_srca_m.srca002
                                       ,srcc004 = g_srca_m.srca004
                                       ,srcc005 = g_srca_m.srca005
                                       ,srcc006 = g_srca_m.srca006
                                       ,srcc900 = g_srca_m.srca900
 
          WHERE srccent = g_enterprise AND srccsite = g_srca_m_t.srcasite
            AND srcc000 = g_srca_m_t.srca000
            AND srcc001 = g_srca_m_t.srca001
            AND srcc002 = g_srca_m_t.srca002
            AND srcc004 = g_srca_m_t.srca004
            AND srcc005 = g_srca_m_t.srca005
            AND srcc006 = g_srca_m_t.srca006
            AND srcc900 = g_srca_m_t.srca900
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "srcc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
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
         UPDATE srcd_t
            SET srcdsite = g_srca_m.srcasite
               ,srcd000 = g_srca_m.srca000
               ,srcd001 = g_srca_m.srca001
               ,srcd002 = g_srca_m.srca002
               ,srcd004 = g_srca_m.srca004
               ,srcd005 = g_srca_m.srca005
               ,srcd006 = g_srca_m.srca006
               ,srcd900 = g_srca_m.srca900
 
          WHERE srcdent = g_enterprise AND
                srcdsite = g_srcasite_t
            AND srcd000 = g_srca000_t
            AND srcd001 = g_srca001_t
            AND srcd002 = g_srca002_t
            AND srcd004 = g_srca004_t
            AND srcd005 = g_srca005_t
            AND srcd006 = g_srca006_t
            AND srcd900 = g_srca900_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srcd_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
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
   CALL asrt801_set_act_visible()   
   CALL asrt801_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " srcaent = " ||g_enterprise|| " AND",
                      " srcasite = '", g_srca_m.srcasite, "' "
                      ," AND srca000 = '", g_srca_m.srca000, "' "
                      ," AND srca001 = '", g_srca_m.srca001, "' "
                      ," AND srca002 = '", g_srca_m.srca002, "' "
                      ," AND srca004 = '", g_srca_m.srca004, "' "
                      ," AND srca005 = '", g_srca_m.srca005, "' "
                      ," AND srca006 = '", g_srca_m.srca006, "' "
                      ," AND srca900 = '", g_srca_m.srca900, "' "
 
   #填到對應位置
   CALL asrt801_browser_fill("")
 
   CLOSE asrt801_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt801_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asrt801.input" >}
#+ 資料輸入
PRIVATE FUNCTION asrt801_input(p_cmd)
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
   DEFINE  l_sys                 LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_n1                  LIKE type_t.num5
   DEFINE  l_n2                  LIKE type_t.num5
   DEFINE  l_srceseq             LIKE srce_t.srceseq
   DEFINE  l_result              LIKE type_t.num5
   DEFINE  l_srcd013_str         STRING
   DEFINE  l_srcd013_str1        STRING
   DEFINE  l_srcd013_str2        STRING
   DEFINE  l_srcd013_n1          LIKE type_t.num5
   DEFINE  l_srcd013_num         LIKE srcd_t.srcd012
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
   DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca001_desc,g_srca_m.srca004, 
       g_srca_m.srca004_desc,g_srca_m.srca004_desc_1,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca006_desc, 
       g_srca_m.srca002,g_srca_m.srca002_desc,g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca905_desc, 
       g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp, 
       g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp,g_srca_m.srcacrtdp_desc, 
       g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamodid_desc,g_srca_m.srcamoddt,g_srca_m.srcacnfid, 
       g_srca_m.srcacnfid_desc,g_srca_m.srcacnfdt
   
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
   LET g_forupd_sql = "SELECT srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015, 
       srcc016,srcc017,srcc018,srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025, 
       srcc026,srcc046,srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902,srcc905,srcc906,srcc007, 
       srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040,srcc041,srcc042,srcc043, 
       srcc044,srcc045 FROM srcc_t WHERE srccent=? AND srccsite=? AND srcc000=? AND srcc001=? AND srcc002=?  
       AND srcc004=? AND srcc005=? AND srcc006=? AND srcc900=? AND srcc007=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt801_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901, 
       srcd902,srcd905,srcd906 FROM srcd_t WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=?  
       AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=? AND srcdseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   LET g_forupd_sql = "SELECT srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901, 
       srcd902,srcd905,srcd906 FROM srcd_t WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=?  
       AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=? AND srcdseq=? AND srcd008='1'
       FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt801_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   LET g_forupd_sql = "SELECT srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901, 
       srcd902,srcd905,srcd906 FROM srcd_t WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=?  
       AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=? AND srcdseq=? AND srcd008='2'
       FOR UPDATE"
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt801_bcl4 CURSOR FROM g_forupd_sql
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asrt801_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL asrt801_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   LET g_flag = 'Y'
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asrt801.input.head" >}
      #單頭段
      INPUT BY NAME g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002, 
          g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asrt801_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL asrt801_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca001
            
            #add-point:AFTER FIELD srca001 name="input.a.srca001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_srca_m.srcasite) AND NOT cl_null(g_srca_m.srca000) AND NOT cl_null(g_srca_m.srca001) AND g_srca_m.srca002 IS NOT NULL AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND NOT cl_null(g_srca_m.srca900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t  OR g_srca_m.srca000 != g_srca000_t  OR g_srca_m.srca001 != g_srca001_t  OR g_srca_m.srca002 != g_srca002_t  OR g_srca_m.srca004 != g_srca004_t  OR g_srca_m.srca005 != g_srca005_t  OR g_srca_m.srca006 != g_srca006_t  OR g_srca_m.srca900 != g_srca900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srca_t WHERE "||"srcaent = '" ||g_enterprise|| "' AND "||"srcasite = '"||g_srca_m.srcasite ||"' AND "|| "srca000 = '"||g_srca_m.srca000 ||"' AND "|| "srca001 = '"||g_srca_m.srca001 ||"' AND "|| "srca002 = '"||g_srca_m.srca002 ||"' AND "|| "srca004 = '"||g_srca_m.srca004 ||"' AND "|| "srca005 = '"||g_srca_m.srca005 ||"' AND "|| "srca006 = '"||g_srca_m.srca006 ||"' AND "|| "srca900 = '"||g_srca_m.srca900 ||"'",'std-00004',0) THEN 
                     LET g_srca_m.srca001 = g_srca_m_t.srca001
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_srca_m.srca001) AND (cl_null(g_srca_m_t.srca001) OR g_srca_m.srca001 != g_srca_m_t.srca001) THEN
               IF NOT asrt801_srca_chk() THEN
                  LET g_srca_m.srca001 = g_srca_m_t.srca001
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asrt801_desc()
            
            IF g_flag4 = 'N' THEN
               NEXT FIELD srca004
            END IF
            IF g_flag5 = 'N' THEN
               NEXT FIELD srca005
            END IF
            IF g_flag6 = 'N' THEN
               NEXT FIELD srca006
            END IF
            IF g_flag2 = 'N' THEN
               NEXT FIELD srca002
            END IF
            
            IF g_flag = 'N' THEN
               EXIT DIALOG
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca001
            #add-point:BEFORE FIELD srca001 name="input.b.srca001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca001
            #add-point:ON CHANGE srca001 name="input.g.srca001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca004
            
            #add-point:AFTER FIELD srca004 name="input.a.srca004"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF NOT cl_null(g_srca_m.srcasite) AND NOT cl_null(g_srca_m.srca000) AND NOT cl_null(g_srca_m.srca001) AND g_srca_m.srca002 IS NOT NULL AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND NOT cl_null(g_srca_m.srca900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t  OR g_srca_m.srca000 != g_srca000_t  OR g_srca_m.srca001 != g_srca001_t  OR g_srca_m.srca002 != g_srca002_t  OR g_srca_m.srca004 != g_srca004_t  OR g_srca_m.srca005 != g_srca005_t  OR g_srca_m.srca006 != g_srca006_t  OR g_srca_m.srca900 != g_srca900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srca_t WHERE "||"srcaent = '" ||g_enterprise|| "' AND "||"srcasite = '"||g_srca_m.srcasite ||"' AND "|| "srca000 = '"||g_srca_m.srca000 ||"' AND "|| "srca001 = '"||g_srca_m.srca001 ||"' AND "|| "srca002 = '"||g_srca_m.srca002 ||"' AND "|| "srca004 = '"||g_srca_m.srca004 ||"' AND "|| "srca005 = '"||g_srca_m.srca005 ||"' AND "|| "srca006 = '"||g_srca_m.srca006 ||"' AND "|| "srca900 = '"||g_srca_m.srca900 ||"'",'std-00004',0) THEN 
                     LET g_srca_m.srca004 = g_srca_m_t.srca004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_srca_m.srca004) AND (cl_null(g_srca_m_t.srca004) OR g_srca_m.srca004 != g_srca_m_t.srca004) THEN
               IF NOT asrt801_srca_chk() THEN
                  LET g_srca_m.srca004 = g_srca_m_t.srca004
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asrt801_desc()
            
            IF g_flag1 = 'N' THEN
               NEXT FIELD srca001
            END IF
            IF g_flag5 = 'N' THEN
               NEXT FIELD srca005
            END IF
            IF g_flag6 = 'N' THEN
               NEXT FIELD srca006
            END IF
            IF g_flag2 = 'N' THEN
               NEXT FIELD srca002
            END IF
            
            IF g_flag = 'N' THEN
               EXIT DIALOG
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca004
            #add-point:BEFORE FIELD srca004 name="input.b.srca004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca004
            #add-point:ON CHANGE srca004 name="input.g.srca004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca005
            #add-point:BEFORE FIELD srca005 name="input.b.srca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca005
            
            #add-point:AFTER FIELD srca005 name="input.a.srca005"
            #應用 a05 樣板自動產生(Version:2)
            IF cl_null(g_srca_m.srca005) THEN
               LET g_srca_m.srca005 = ' '
            END IF
            #確認資料無重複
            IF NOT cl_null(g_srca_m.srcasite) AND NOT cl_null(g_srca_m.srca000) AND NOT cl_null(g_srca_m.srca001) AND g_srca_m.srca002 IS NOT NULL AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND NOT cl_null(g_srca_m.srca900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t  OR g_srca_m.srca000 != g_srca000_t  OR g_srca_m.srca001 != g_srca001_t  OR g_srca_m.srca002 != g_srca002_t  OR g_srca_m.srca004 != g_srca004_t  OR g_srca_m.srca005 != g_srca005_t  OR g_srca_m.srca006 != g_srca006_t  OR g_srca_m.srca900 != g_srca900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srca_t WHERE "||"srcaent = '" ||g_enterprise|| "' AND "||"srcasite = '"||g_srca_m.srcasite ||"' AND "|| "srca000 = '"||g_srca_m.srca000 ||"' AND "|| "srca001 = '"||g_srca_m.srca001 ||"' AND "|| "srca002 = '"||g_srca_m.srca002 ||"' AND "|| "srca004 = '"||g_srca_m.srca004 ||"' AND "|| "srca005 = '"||g_srca_m.srca005 ||"' AND "|| "srca006 = '"||g_srca_m.srca006 ||"' AND "|| "srca900 = '"||g_srca_m.srca900 ||"'",'std-00004',0) THEN 
                     LET g_srca_m.srca005 = g_srca_m_t.srca005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_srca_m.srca005 IS NOT NULL AND (cl_null(g_srca_m_t.srca005) OR g_srca_m.srca005 != g_srca_m_t.srca005) THEN
               IF NOT asrt801_srca_chk() THEN
                  LET g_srca_m.srca005 = g_srca_m_t.srca005
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asrt801_desc()
            
            IF g_flag1 = 'N' THEN
               NEXT FIELD srca001
            END IF
            IF g_flag4 = 'N' THEN
               NEXT FIELD srca004
            END IF
            IF g_flag6 = 'N' THEN
               NEXT FIELD srca006
            END IF
            IF g_flag2 = 'N' THEN
               NEXT FIELD srca002
            END IF
            
            IF g_flag = 'N' THEN
               EXIT DIALOG
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca005
            #add-point:ON CHANGE srca005 name="input.g.srca005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca006
            
            #add-point:AFTER FIELD srca006 name="input.a.srca006"
            #應用 a05 樣板自動產生(Version:2)
            IF cl_null(g_srca_m.srca006) THEN
               LET g_srca_m.srca006 = ' '
            END IF
            #確認資料無重複
            IF NOT cl_null(g_srca_m.srcasite) AND NOT cl_null(g_srca_m.srca000) AND NOT cl_null(g_srca_m.srca001) AND g_srca_m.srca002 IS NOT NULL AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND NOT cl_null(g_srca_m.srca900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t  OR g_srca_m.srca000 != g_srca000_t  OR g_srca_m.srca001 != g_srca001_t  OR g_srca_m.srca002 != g_srca002_t  OR g_srca_m.srca004 != g_srca004_t  OR g_srca_m.srca005 != g_srca005_t  OR g_srca_m.srca006 != g_srca006_t  OR g_srca_m.srca900 != g_srca900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srca_t WHERE "||"srcaent = '" ||g_enterprise|| "' AND "||"srcasite = '"||g_srca_m.srcasite ||"' AND "|| "srca000 = '"||g_srca_m.srca000 ||"' AND "|| "srca001 = '"||g_srca_m.srca001 ||"' AND "|| "srca002 = '"||g_srca_m.srca002 ||"' AND "|| "srca004 = '"||g_srca_m.srca004 ||"' AND "|| "srca005 = '"||g_srca_m.srca005 ||"' AND "|| "srca006 = '"||g_srca_m.srca006 ||"' AND "|| "srca900 = '"||g_srca_m.srca900 ||"'",'std-00004',0) THEN 
                     LET g_srca_m.srca006 = g_srca_m_t.srca006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_srca_m.srca006 IS NOT NULL AND (cl_null(g_srca_m_t.srca006) OR g_srca_m.srca006 != g_srca_m_t.srca006) THEN
               IF NOT asrt801_srca_chk() THEN
                  LET g_srca_m.srca006 = g_srca_m_t.srca006
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asrt801_desc()
            
            IF g_flag1 = 'N' THEN
               NEXT FIELD srca001
            END IF
            IF g_flag4 = 'N' THEN
               NEXT FIELD srca004
            END IF
            IF g_flag5 = 'N' THEN
               NEXT FIELD srca005
            END IF
            IF g_flag2 = 'N' THEN
               NEXT FIELD srca002
            END IF
            
            IF g_flag = 'N' THEN
               EXIT DIALOG
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca006
            #add-point:BEFORE FIELD srca006 name="input.b.srca006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca006
            #add-point:ON CHANGE srca006 name="input.g.srca006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca002
            
            #add-point:AFTER FIELD srca002 name="input.a.srca002"
            #應用 a05 樣板自動產生(Version:2)
            IF cl_null(g_srca_m.srca002) THEN
               LET g_srca_m.srca002 = ' '
            END IF
            #確認資料無重複
            IF NOT cl_null(g_srca_m.srcasite) AND NOT cl_null(g_srca_m.srca000) AND NOT cl_null(g_srca_m.srca001) AND g_srca_m.srca002 IS NOT NULL AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND NOT cl_null(g_srca_m.srca900) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t  OR g_srca_m.srca000 != g_srca000_t  OR g_srca_m.srca001 != g_srca001_t  OR g_srca_m.srca002 != g_srca002_t  OR g_srca_m.srca004 != g_srca004_t  OR g_srca_m.srca005 != g_srca005_t  OR g_srca_m.srca006 != g_srca006_t  OR g_srca_m.srca900 != g_srca900_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srca_t WHERE "||"srcaent = '" ||g_enterprise|| "' AND "||"srcasite = '"||g_srca_m.srcasite ||"' AND "|| "srca000 = '"||g_srca_m.srca000 ||"' AND "|| "srca001 = '"||g_srca_m.srca001 ||"' AND "|| "srca002 = '"||g_srca_m.srca002 ||"' AND "|| "srca004 = '"||g_srca_m.srca004 ||"' AND "|| "srca005 = '"||g_srca_m.srca005 ||"' AND "|| "srca006 = '"||g_srca_m.srca006 ||"' AND "|| "srca900 = '"||g_srca_m.srca900 ||"'",'std-00004',0) THEN 
                     LET g_srca_m.srca002 = g_srca_m_t.srca002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF g_srca_m.srca002 IS NOT NULL AND (cl_null(g_srca_m_t.srca002) OR g_srca_m.srca002 != g_srca_m_t.srca002) THEN
               IF NOT asrt801_srca_chk() THEN
                  LET g_srca_m.srca002 = g_srca_m_t.srca002
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL asrt801_desc()
            
            IF g_flag1 = 'N' THEN
               NEXT FIELD srca001
            END IF
            IF g_flag4 = 'N' THEN
               NEXT FIELD srca004
            END IF
            IF g_flag5 = 'N' THEN
               NEXT FIELD srca005
            END IF
            IF g_flag6 = 'N' THEN
               NEXT FIELD srca006
            END IF
            
            IF g_flag = 'N' THEN
               EXIT DIALOG
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca002
            #add-point:BEFORE FIELD srca002 name="input.b.srca002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca002
            #add-point:ON CHANGE srca002 name="input.g.srca002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca902
            #add-point:BEFORE FIELD srca902 name="input.b.srca902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca902
            
            #add-point:AFTER FIELD srca902 name="input.a.srca902"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca902
            #add-point:ON CHANGE srca902 name="input.g.srca902"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca905
            
            #add-point:AFTER FIELD srca905 name="input.a.srca905"
            IF NOT cl_null(g_srca_m.srca905) AND (cl_null(g_srca_m_t.srca905) OR g_srca_m.srca905 != g_srca_m_t.srca905) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_srca_m.srca905) THEN
                  LET g_srca_m.srca905 = g_srca_m_t.srca905
                  CALL asrt801_desc()
                  DISPLAY BY NAME g_srca_m.srca905_desc
                  NEXT FIELD srca905
               END IF
               CALL asrt801_desc() 
               DISPLAY BY NAME g_srca_m.srca905_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca905
            #add-point:BEFORE FIELD srca905 name="input.b.srca905"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca905
            #add-point:ON CHANGE srca905 name="input.g.srca905"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srca906
            #add-point:BEFORE FIELD srca906 name="input.b.srca906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srca906
            
            #add-point:AFTER FIELD srca906 name="input.a.srca906"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srca906
            #add-point:ON CHANGE srca906 name="input.g.srca906"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcastus
            #add-point:BEFORE FIELD srcastus name="input.b.srcastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcastus
            
            #add-point:AFTER FIELD srcastus name="input.a.srcastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcastus
            #add-point:ON CHANGE srcastus name="input.g.srcastus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.srca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca001
            #add-point:ON ACTION controlp INFIELD srca001 name="input.c.srca001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca001      #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_srca_m.srca002) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac002 = '",g_srca_m.srca002,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca004) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac004 = '",g_srca_m.srca004,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca005) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac005 = '",g_srca_m.srca005,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca006) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac006 = '",g_srca_m.srca006,"'"
            END IF
            CALL q_srac001()                                #呼叫開窗
            LET g_srca_m.srca001 = g_qryparam.return1
            DISPLAY g_srca_m.srca001 TO srca001             #
            NEXT FIELD srca001                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srca004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca004
            #add-point:ON ACTION controlp INFIELD srca004 name="input.c.srca004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca004     #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_srca_m.srca002) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac002 = '",g_srca_m.srca002,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca001) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac001 = '",g_srca_m.srca001,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca005) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac005 = '",g_srca_m.srca005,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca006) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac006 = '",g_srca_m.srca006,"'"
            END IF
            CALL q_srac004()                                #呼叫開窗
            LET g_srca_m.srca004 = g_qryparam.return1
            DISPLAY g_srca_m.srca004 TO srca004             #
            NEXT FIELD srca004                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca005
            #add-point:ON ACTION controlp INFIELD srca005 name="input.c.srca005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca005      #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_srca_m.srca002) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac002 = '",g_srca_m.srca002,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca004) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac004 = '",g_srca_m.srca004,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca001) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac001 = '",g_srca_m.srca001,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca006) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac006 = '",g_srca_m.srca006,"'"
            END IF
            CALL q_srac005()                                #呼叫開窗
            LET g_srca_m.srca005 = g_qryparam.return1
            DISPLAY g_srca_m.srca005 TO srca005             #
            NEXT FIELD srca005                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srca006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca006
            #add-point:ON ACTION controlp INFIELD srca006 name="input.c.srca006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca006      #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_srca_m.srca002) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac002 = '",g_srca_m.srca002,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca004) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac004 = '",g_srca_m.srca004,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca001) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac001 = '",g_srca_m.srca001,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca005) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac005 = '",g_srca_m.srca005,"'"
            END IF
            CALL q_srac006()                                #呼叫開窗
            LET g_srca_m.srca006 = g_qryparam.return1
            DISPLAY g_srca_m.srca006 TO srca006             #
            NEXT FIELD srca006                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srca002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca002
            #add-point:ON ACTION controlp INFIELD srca002 name="input.c.srca002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca002      #給予default值
            LET g_qryparam.where = " 1=1 "
            IF NOT cl_null(g_srca_m.srca005) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac005 = '",g_srca_m.srca005,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca004) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac004 = '",g_srca_m.srca004,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca001) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac001 = '",g_srca_m.srca001,"'"
            END IF
            IF NOT cl_null(g_srca_m.srca006) THEN
               LET g_qryparam.where = g_qryparam.where," AND srac006 = '",g_srca_m.srca006,"'"
            END IF
            CALL q_srac002()                                #呼叫開窗
            LET g_srca_m.srca002 = g_qryparam.return1
            DISPLAY g_srca_m.srca002 TO srca002             #
            NEXT FIELD srca002                              #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.srca902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca902
            #add-point:ON ACTION controlp INFIELD srca902 name="input.c.srca902"
            
            #END add-point
 
 
         #Ctrlp:input.c.srca905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca905
            #add-point:ON ACTION controlp INFIELD srca905 name="input.c.srca905"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srca_m.srca905             #給予default值
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_srca_m.srca905 = g_qryparam.return1              
            DISPLAY g_srca_m.srca905 TO srca905     
            NEXT FIELD srca905
            #END add-point
 
 
         #Ctrlp:input.c.srca906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srca906
            #add-point:ON ACTION controlp INFIELD srca906 name="input.c.srca906"
            
            #END add-point
 
 
         #Ctrlp:input.c.srcastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcastus
            #add-point:ON ACTION controlp INFIELD srcastus name="input.c.srcastus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004, 
                g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO srca_t (srcaent,srcasite,srca000,srca001,srca004,srca005,srca006,srca002, 
                   srca900,srca902,srca905,srca906,srcastus,srcaownid,srcaowndp,srcacrtid,srcacrtdp, 
                   srcacrtdt,srcamodid,srcamoddt,srcacnfid,srcacnfdt)
               VALUES (g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca004, 
                   g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900,g_srca_m.srca902, 
                   g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
                   g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
                   g_srca_m.srcacnfid,g_srca_m.srcacnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_srca_m:",SQLERRMESSAGE 
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
                  CALL asrt801_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asrt801_b_fill()
                  CALL asrt801_b_fill2('0')
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
               CALL asrt801_srca_t_mask_restore('restore_mask_o')
               
               UPDATE srca_t SET (srcasite,srca000,srca001,srca004,srca005,srca006,srca002,srca900,srca902, 
                   srca905,srca906,srcastus,srcaownid,srcaowndp,srcacrtid,srcacrtdp,srcacrtdt,srcamodid, 
                   srcamoddt,srcacnfid,srcacnfdt) = (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001, 
                   g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
                   g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid, 
                   g_srca_m.srcaowndp,g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid, 
                   g_srca_m.srcamoddt,g_srca_m.srcacnfid,g_srca_m.srcacnfdt)
                WHERE srcaent = g_enterprise AND srcasite = g_srcasite_t
                  AND srca000 = g_srca000_t
                  AND srca001 = g_srca001_t
                  AND srca002 = g_srca002_t
                  AND srca004 = g_srca004_t
                  AND srca005 = g_srca005_t
                  AND srca006 = g_srca006_t
                  AND srca900 = g_srca900_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "srca_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asrt801_srca_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_srca_m_t)
               LET g_log2 = util.JSON.stringify(g_srca_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_srcasite_t = g_srca_m.srcasite
            LET g_srca000_t = g_srca_m.srca000
            LET g_srca001_t = g_srca_m.srca001
            LET g_srca002_t = g_srca_m.srca002
            LET g_srca004_t = g_srca_m.srca004
            LET g_srca005_t = g_srca_m.srca005
            LET g_srca006_t = g_srca_m.srca006
            LET g_srca900_t = g_srca_m.srca900
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asrt801.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_srcc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION stand
            LET g_action_choice="stand"
            IF cl_auth_chk_act("stand") THEN
               
               #add-point:ON ACTION stand name="input.detail_input.page1.stand"
               IF NOT cl_null(g_srcc_d[l_ac].srcc007) AND NOT cl_null(g_srcc_d[l_ac].srcc008) AND NOT cl_null(g_srcc_d[l_ac].srcc009) THEN
                  CALL asrt801_01(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srca_m.srca900,'Y')
               END IF
               SELECT COUNT(*) INTO l_n FROM srce_t WHERE srceent=g_enterprise AND srcesite=g_site 
                  AND srce000 = g_srca_m.srca000 AND srce001 = g_srca_m.srca001 AND srce002 = g_srca_m.srca002
                  AND srce004 = g_srca_m.srca004 AND srce005 = g_srca_m.srca005 AND srce006 = g_srca_m.srca006
                  AND srce007 = g_srcc_d[l_ac].srcc007 AND srce900 = g_srca_m.srca900
               IF l_n = 0 THEN
                  LET g_srcc_d[l_ac].srcc012 = ''
                  LET g_srcc_d[l_ac].srcc013 = ''
               END IF
               IF l_n = 1 THEN
                  SELECT srce008,srce009 INTO g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013 FROM srce_t
                   WHERE srceent=g_enterprise AND srcesite=g_site 
                     AND srce000 = g_srca_m.srca000 AND srce001 = g_srca_m.srca001 AND srce002 = g_srca_m.srca002
                     AND srce004 = g_srca_m.srca004 AND srce005 = g_srca_m.srca005 AND srce006 = g_srca_m.srca006
                     AND srce007 = g_srcc_d[l_ac].srcc007 AND srce900 = g_srca_m.srca900
               END IF
               IF l_n > 1 THEN
                  LET g_srcc_d[l_ac].srcc012 = 'MULT'
                  LET g_srcc_d[l_ac].srcc013 = 0
               END IF
               UPDATE srcc_t SET srcc012=g_srcc_d[l_ac].srcc012,srcc013=g_srcc_d[l_ac].srcc013
                WHERE srccent=g_enterprise AND srccsite=g_site 
                  AND srcc000 = g_srca_m.srca000 AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004 AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006
                  AND srcc007 = g_srcc_d[l_ac].srcc007 AND srcc900 = g_srca_m.srca900
               CALL asrt801_b_fill()
               LET g_action_choice=""
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            IF g_argv[1] = '2' THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srcc_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asrt801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1','2',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_srcc_d.getLength()
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
            CALL asrt801_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srcc_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srcc_d[l_ac].srcc007 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_srcc_d_t.* = g_srcc_d[l_ac].*  #BACKUP
               LET g_srcc_d_o.* = g_srcc_d[l_ac].*  #BACKUP
               CALL asrt801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL asrt801_set_no_entry_b(l_cmd)
               IF NOT asrt801_lock_b("srcc_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt801_bcl INTO g_srcc_d[l_ac].srcc007,g_srcc_d[l_ac].srcc008,g_srcc_d[l_ac].srcc009, 
                      g_srcc_d[l_ac].srcc010,g_srcc_d[l_ac].srcc011,g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013, 
                      g_srcc_d[l_ac].srcc014,g_srcc_d[l_ac].srcc015,g_srcc_d[l_ac].srcc016,g_srcc_d[l_ac].srcc017, 
                      g_srcc_d[l_ac].srcc018,g_srcc_d[l_ac].srcc019,g_srcc_d[l_ac].srcc020,g_srcc_d[l_ac].srcc036, 
                      g_srcc_d[l_ac].srcc037,g_srcc_d[l_ac].srcc021,g_srcc_d[l_ac].srcc022,g_srcc_d[l_ac].srcc023, 
                      g_srcc_d[l_ac].srcc024,g_srcc_d[l_ac].srcc025,g_srcc_d[l_ac].srcc026,g_srcc_d[l_ac].srcc046, 
                      g_srcc_d[l_ac].srcc047,g_srcc_d[l_ac].srcc048,g_srcc_d[l_ac].srcc027,g_srcc_d[l_ac].srcc028, 
                      g_srcc_d[l_ac].srcc029,g_srcc_d[l_ac].srcc901,g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905, 
                      g_srcc_d[l_ac].srcc906,g_srcc2_d[l_ac].srcc007,g_srcc2_d[l_ac].srcc030,g_srcc2_d[l_ac].srcc031, 
                      g_srcc2_d[l_ac].srcc032,g_srcc2_d[l_ac].srcc033,g_srcc2_d[l_ac].srcc034,g_srcc2_d[l_ac].srcc035, 
                      g_srcc2_d[l_ac].srcc038,g_srcc2_d[l_ac].srcc039,g_srcc2_d[l_ac].srcc040,g_srcc2_d[l_ac].srcc041, 
                      g_srcc2_d[l_ac].srcc042,g_srcc2_d[l_ac].srcc043,g_srcc2_d[l_ac].srcc044,g_srcc2_d[l_ac].srcc045 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_srcc_d_t.srcc007,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srcc_d_mask_o[l_ac].* =  g_srcc_d[l_ac].*
                  CALL asrt801_srcc_t_mask()
                  LET g_srcc_d_mask_n[l_ac].* =  g_srcc_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt801_show()
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
            INITIALIZE g_srcc_d[l_ac].* TO NULL 
            INITIALIZE g_srcc_d_t.* TO NULL 
            INITIALIZE g_srcc_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_srcc_d[l_ac].srcc010 = "1"
      LET g_srcc_d[l_ac].srcc017 = "0"
      LET g_srcc_d[l_ac].srcc018 = "0"
      LET g_srcc_d[l_ac].srcc019 = "0"
      LET g_srcc_d[l_ac].srcc020 = "0"
      LET g_srcc_d[l_ac].srcc036 = "N"
      LET g_srcc_d[l_ac].srcc021 = "N"
      LET g_srcc_d[l_ac].srcc022 = "N"
      LET g_srcc_d[l_ac].srcc023 = "Y"
      LET g_srcc_d[l_ac].srcc024 = "N"
      LET g_srcc_d[l_ac].srcc025 = "N"
      LET g_srcc_d[l_ac].srcc026 = "N"
      LET g_srcc_d[l_ac].srcc047 = "1"
      LET g_srcc_d[l_ac].srcc048 = "1"
      LET g_srcc_d[l_ac].srcc028 = "1"
      LET g_srcc_d[l_ac].srcc029 = "1"
      LET g_srcc_d[l_ac].srcc901 = "3"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_srcc_d[l_ac].srcc902 = cl_get_today()
            LET g_srcc2_d[l_ac].srcc030 = "0"
            LET g_srcc2_d[l_ac].srcc031 = "0"
            LET g_srcc2_d[l_ac].srcc032 = "0"
            LET g_srcc2_d[l_ac].srcc033 = "0"
            LET g_srcc2_d[l_ac].srcc034 = "0"
            LET g_srcc2_d[l_ac].srcc035 = "0"
            LET g_srcc2_d[l_ac].srcc038 = "0"
            LET g_srcc2_d[l_ac].srcc039 = "0"
            LET g_srcc2_d[l_ac].srcc040 = "0"
            LET g_srcc2_d[l_ac].srcc041 = "0"
            LET g_srcc2_d[l_ac].srcc042 = "0"
            LET g_srcc2_d[l_ac].srcc043 = "0"
            LET g_srcc2_d[l_ac].srcc044 = "0"
            LET g_srcc2_d[l_ac].srcc045 = "0"
            #end add-point
            LET g_srcc_d_t.* = g_srcc_d[l_ac].*     #新輸入資料
            LET g_srcc_d_o.* = g_srcc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL asrt801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srcc_d[li_reproduce_target].* = g_srcc_d[li_reproduce].*
               LET g_srcc2_d[li_reproduce_target].* = g_srcc2_d[li_reproduce].*
 
               LET g_srcc_d[li_reproduce_target].srcc007 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            SELECT MAX(srcc007) INTO g_srcc_d[l_ac].srcc007 FROM srcc_t
             WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
               AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
               AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
            CALL cl_get_para(g_enterprise,g_site,'E-MFG-0001') RETURNING l_sys
            IF cl_null(l_sys) OR l_sys = 0 THEN
               LET l_sys = 1 
            END IF
            IF cl_null(g_srcc_d[l_ac].srcc007) OR g_srcc_d[l_ac].srcc007 = 0 THEN
               LET g_srcc_d[l_ac].srcc007 = l_sys
               LET g_srcc_d[l_ac].srcc012 = 'INIT'
               LET g_srcc_d[l_ac].srcc013 = '0'
            ELSE
               SELECT srcc008,srcc009 INTO g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013 FROM srcc_t
                WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
                  AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900 
                  AND srcc007 = g_srcc_d[l_ac].srcc007 
               LET g_srcc_d[l_ac].srcc007 = g_srcc_d[l_ac].srcc007 + l_sys                  
            END IF
            
            SELECT imae016 INTO g_srcc_d[l_ac].srcc027
              FROM imae_t
             WHERE imaeent = g_enterprise
               AND imaesite = g_site
               AND imae001 = g_srca_m.srca001

            IF cl_null(g_srcc_d[l_ac].srcc027) THEN
               SELECT imaa006 INTO g_srcc_d[l_ac].srcc027 FROM imaa_t
                WHERE imaaent = g_enterprise AND imaa001 = g_srca_m.srca001
            END IF
            LET g_srcc_d[l_ac].srcc046 = g_srcc_d[l_ac].srcc027
            CALL asrt801_b_desc()
                                      
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
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM srcc_t 
             WHERE srccent = g_enterprise AND srccsite = g_srca_m.srcasite
               AND srcc000 = g_srca_m.srca000
               AND srcc001 = g_srca_m.srca001
               AND srcc002 = g_srca_m.srca002
               AND srcc004 = g_srca_m.srca004
               AND srcc005 = g_srca_m.srca005
               AND srcc006 = g_srca_m.srca006
               AND srcc900 = g_srca_m.srca900
 
               AND srcc007 = g_srcc_d[l_ac].srcc007
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               CALL asrt801_insert_b('srcc_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_srcc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt801_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               IF g_srcc_d[l_ac].srcc012 <> 'MULT' THEN
                  SELECT COUNT(*) INTO l_n1 FROM srce_t 
                   WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                     AND srce000 = g_srca_m.srca000
                     AND srce001 = g_srca_m.srca001
                     AND srce002 = g_srca_m.srca002
                     AND srce004 = g_srca_m.srca004
                     AND srce005 = g_srca_m.srca005
                     AND srce006 = g_srca_m.srca006
                     AND srce900 = g_srca_m.srca900
                     AND srce007 = g_srcc_d[l_ac].srcc007
                  IF l_n1 = 0 THEN
                     INSERT INTO srce_t (srceent,srcesite,srce000,srce001,srce002,srce004,srce005,srce006,srce007,srceseq,
                                         srce008,srce009,srce900,srce901,srce902,srce905,srce906)
                                 VALUES (g_enterprise,g_site,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,
                                         g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[l_ac].srcc007,1,g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013,
                                         g_srca_m.srca900,'3',g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905,g_srcc_d[l_ac].srcc906)
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = "ins_srce_t"
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        CALL s_transaction_end('N','0')
                     END IF
                  END IF
               END IF  
               IF NOT asrt801_return_srcc014() THEN
                  CALL s_transaction_end('N','0')
               END IF
               CALL asrt801_show()               
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
               #变更类型是已删除的，则不可再次删除
               IF g_srcc_d[l_ac].srcc901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_srcc_d[l_ac].srcc007
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               IF NOT asrt801_return_srcc012(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[l_ac].srcc007) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT asrt801_srcc_delete(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[l_ac].srcc007) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               IF NOT asrt801_return_srcc014() THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               CALL s_transaction_end('Y','0')
               CALL asrt801_b_fill()
               LET l_cmd = 'd'     #防止进入AFTER DELETE 继续删除单身资料
               IF 1 = 2 THEN
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_srca_m.srcasite
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca000
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca001
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca002
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca004
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca005
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca006
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca900
 
               LET gs_keys[gs_keys.getLength()+1] = g_srcc_d_t.srcc007
 
            
               #刪除同層單身
               IF NOT asrt801_delete_b('srcc_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt801_key_delete_b(gs_keys,'srcc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt801_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                  END IF
               #end add-point
               LET l_count = g_srcc_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srcc_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc007
            #add-point:BEFORE FIELD srcc007 name="input.b.page1.srcc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc007
            
            #add-point:AFTER FIELD srcc007 name="input.a.page1.srcc007"
            #應用 a05 樣板自動產生(Version:2)
            IF NOT cl_ap_chk_Range(g_srcc_d[l_ac].srcc007,"0","0","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc007 = g_srcc_d_t.srcc007
               NEXT FIELD srcc007
            END IF
            #確認資料無重複
            IF  g_srca_m.srcasite IS NOT NULL AND g_srca_m.srca000 IS NOT NULL AND g_srca_m.srca001 IS NOT NULL AND g_srca_m.srca002 IS NOT NULL AND g_srca_m.srca004 IS NOT NULL AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND g_srca_m.srca900 IS NOT NULL AND g_srcc_d[g_detail_idx].srcc007 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t OR g_srca_m.srca000 != g_srca000_t OR g_srca_m.srca001 != g_srca001_t OR g_srca_m.srca002 != g_srca002_t OR g_srca_m.srca004 != g_srca004_t OR g_srca_m.srca005 != g_srca005_t OR g_srca_m.srca006 != g_srca006_t OR g_srca_m.srca900 != g_srca900_t OR g_srcc_d[g_detail_idx].srcc007 != g_srcc_d_t.srcc007)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srcc_t WHERE "||"srccent = '" ||g_enterprise|| "' AND "||"srccsite = '"||g_srca_m.srcasite ||"' AND "|| "srcc000 = '"||g_srca_m.srca000 ||"' AND "|| "srcc001 = '"||g_srca_m.srca001 ||"' AND "|| "srcc002 = '"||g_srca_m.srca002 ||"' AND "|| "srcc004 = '"||g_srca_m.srca004 ||"' AND "|| "srcc005 = '"||g_srca_m.srca005 ||"' AND "|| "srcc006 = '"||g_srca_m.srca006 ||"' AND "|| "srcc900 = '"||g_srca_m.srca900 ||"' AND "|| "srcc007 = '"||g_srcc_d[g_detail_idx].srcc007 ||"'",'std-00004',0) THEN 
                     LET g_srcc_d[l_ac].srcc007 = g_srcc_d_t.srcc007
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc007
            #add-point:ON CHANGE srcc007 name="input.g.page1.srcc007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc008
            
            #add-point:AFTER FIELD srcc008 name="input.a.page1.srcc008"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc008) THEN
               CALL s_azzi650_chk_exist('221',g_srcc_d[l_ac].srcc008) RETURNING l_success
               IF NOT l_success THEN
                  LET g_srcc_d[l_ac].srcc008 = g_srcc_d_t.srcc008
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc008
               END IF
              #IF l_cmd = 'a' OR (l_cmd = 'u' AND g_srcc_d[l_ac].srcc008 <>　g_srcc_d_t.srcc008) THEN   #160824-00007#285 by sakura mark
               IF g_srcc_d[l_ac].srcc008 <>　g_srcc_d_o.srcc008 OR cl_null(g_srcc_d_o.srcc008) THEN     #160824-00007#285 by sakura add
                  CALL asrt801_def_srcc009()
                  IF NOT cl_null(g_srcc_d[l_ac].srcc009) THEN
                     IF NOT asrt801_chk_srcc008(l_cmd) THEN
                       #LET g_srcc_d[l_ac].srcc008 = g_srcc_d_t.srcc008   #160824-00007#285 by sakura mark
                        LET g_srcc_d[l_ac].srcc008 = g_srcc_d_o.srcc008   #160824-00007#285 by sakura add
                        CALL asrt801_b_desc()
                        NEXT FIELD srcc008
                     END IF
                  END IF
               END IF
            END IF
            LET g_srcc_d_o.* = g_srcc_d[l_ac].*   #160824-00007#285 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc008
            #add-point:BEFORE FIELD srcc008 name="input.b.page1.srcc008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc008
            #add-point:ON CHANGE srcc008 name="input.g.page1.srcc008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc009
            #add-point:BEFORE FIELD srcc009 name="input.b.page1.srcc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc009
            
            #add-point:AFTER FIELD srcc009 name="input.a.page1.srcc009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc009
            #add-point:ON CHANGE srcc009 name="input.g.page1.srcc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc010
            #add-point:BEFORE FIELD srcc010 name="input.b.page1.srcc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc010
            
            #add-point:AFTER FIELD srcc010 name="input.a.page1.srcc010"
            IF g_srcc_d[l_ac].srcc010 = '1' THEN
               LET g_srcc_d[l_ac].srcc011 = ''
            END IF
            IF NOT cl_null(g_srcc_d[l_ac].srcc011) THEN
               IF NOT cl_null(g_srcc_d[l_ac].srcc010) AND g_srcc_d[l_ac].srcc010 != '1' THEN
                  SELECT COUNT(*) INTO l_n1 FROM srcc_t
                   WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
                     AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
                     AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
                     AND srcc010 != '1' AND srcc010 != g_srcc_d[l_ac].srcc010 AND srcc011 = g_srcc_d[l_ac].srcc011
                     AND srcc007 != g_srcc_d_t.srcc007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_srcc_d[l_ac].srcc010
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc_d[l_ac].srcc010 = g_srcc_d_t.srcc010
                     NEXT FIELD srcc010
                  END IF
               END IF
            END IF
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc010
            #add-point:ON CHANGE srcc010 name="input.g.page1.srcc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc011
            #add-point:BEFORE FIELD srcc011 name="input.b.page1.srcc011"
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc011
            
            #add-point:AFTER FIELD srcc011 name="input.a.page1.srcc011"
            IF NOT cl_null(g_srcc_d[l_ac].srcc011) THEN
               IF NOT cl_null(g_srcc_d[l_ac].srcc010) AND g_srcc_d[l_ac].srcc010 != '1' THEN
                  SELECT COUNT(*) INTO l_n1 FROM srcc_t
                   WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
                     AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
                     AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
                     AND srcc010 != '1' AND srcc010 != g_srcc_d[l_ac].srcc010 AND srcc011 = g_srcc_d[l_ac].srcc011
                     AND srcc007 != g_srcc_d_t.srcc007
                  IF l_n1 > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00026'
                     LET g_errparam.extend = g_srcc_d[l_ac].srcc011
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc_d[l_ac].srcc010 = g_srcc_d_t.srcc011
                     NEXT FIELD srcc011
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc011
            #add-point:ON CHANGE srcc011 name="input.g.page1.srcc011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc012
            
            #add-point:AFTER FIELD srcc012 name="input.a.page1.srcc012"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc012) AND (cl_null(g_srcc_d_t.srcc012) OR g_srcc_d[l_ac].srcc012 != g_srcc_d_t.srcc012) THEN
               IF NOT cl_null(g_srcc_d[l_ac].srcc013) THEN
                  IF NOT asrt801_chk_srcc012(l_cmd) THEN
                     LET g_srcc_d[l_ac].srcc012 = g_srcc_d_t.srcc012
                     CALL asrt801_b_desc()
                     NEXT FIELD srcc012
                  END IF
               END IF
               IF NOT cl_null(g_srcc_d[l_ac].srcc008) AND NOT cl_null(g_srcc_d[l_ac].srcc009) AND NOT cl_null(g_srcc_d[l_ac].srcc012) AND NOT cl_null(g_srcc_d[l_ac].srcc013) THEN
                  IF g_srcc_d[l_ac].srcc012 = g_srcc_d[l_ac].srcc008 AND g_srcc_d[l_ac].srcc013 = g_srcc_d[l_ac].srcc009 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_srcc_d[l_ac].srcc012
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc_d[l_ac].srcc012 = g_srcc_d_t.srcc012
                     CALL asrt801_b_desc()
                     NEXT FIELD srcc012
                  END IF
               END IF
               IF NOT cl_null(g_srcc_d[l_ac].srcc007) AND NOT cl_null(g_srcc_d[l_ac].srcc008) AND NOT cl_null(g_srcc_d[l_ac].srcc009) AND g_srcc_d[l_ac].srcc012 = 'MULT' THEN
                  CALL asrt801_01(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[l_ac].srcc007,g_srca_m.srca900,'Y')
               END IF
            END IF
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc012
            #add-point:BEFORE FIELD srcc012 name="input.b.page1.srcc012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc012
            #add-point:ON CHANGE srcc012 name="input.g.page1.srcc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc013
            #add-point:BEFORE FIELD srcc013 name="input.b.page1.srcc013"
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc013
            
            #add-point:AFTER FIELD srcc013 name="input.a.page1.srcc013"
            IF NOT cl_null(g_srcc_d[l_ac].srcc013) AND (cl_null(g_srcc_d_t.srcc013) OR g_srcc_d[l_ac].srcc013 != g_srcc_d_t.srcc013) THEN
               IF NOT cl_null(g_srcc_d[l_ac].srcc012) THEN
                  IF NOT asrt801_chk_srcc012(l_cmd) THEN
                     LET g_srcc_d[l_ac].srcc013 = g_srcc_d_t.srcc013
                     NEXT FIELD srcc013
                  END IF
               END IF
               IF NOT cl_null(g_srcc_d[l_ac].srcc008) AND NOT cl_null(g_srcc_d[l_ac].srcc009) AND NOT cl_null(g_srcc_d[l_ac].srcc012) AND NOT cl_null(g_srcc_d[l_ac].srcc013) THEN
                  IF g_srcc_d[l_ac].srcc012 = g_srcc_d[l_ac].srcc008 AND g_srcc_d[l_ac].srcc013 = g_srcc_d[l_ac].srcc009 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00008'
                     LET g_errparam.extend = g_srcc_d[l_ac].srcc013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc_d[l_ac].srcc013 = g_srcc_d_t.srcc013
                     NEXT FIELD srcc013
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc013
            #add-point:ON CHANGE srcc013 name="input.g.page1.srcc013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc014
            
            #add-point:AFTER FIELD srcc014 name="input.a.page1.srcc014"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc014
            #add-point:BEFORE FIELD srcc014 name="input.b.page1.srcc014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc014
            #add-point:ON CHANGE srcc014 name="input.g.page1.srcc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc015
            #add-point:BEFORE FIELD srcc015 name="input.b.page1.srcc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc015
            
            #add-point:AFTER FIELD srcc015 name="input.a.page1.srcc015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc015
            #add-point:ON CHANGE srcc015 name="input.g.page1.srcc015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc016
            
            #add-point:AFTER FIELD srcc016 name="input.a.page1.srcc016"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc016) AND (cl_null(g_srcc_d_t.srcc016) OR g_srcc_d[l_ac].srcc016 != g_srcc_d_t.srcc016) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_srcc_d[l_ac].srcc016
               #160318-00025#3--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aec-00010:sub-01302|aeci001|",cl_get_progname("aeci001",g_lang,"2"),"|:EXEPROGaeci001"
               #160318-00025#3--add--end
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ecaa001_1") THEN
                  LET g_srcc_d[l_ac].srcc016 = g_srcc_d_t.srcc016
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc016
               END IF               
            END IF
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc016
            #add-point:BEFORE FIELD srcc016 name="input.b.page1.srcc016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc016
            #add-point:ON CHANGE srcc016 name="input.g.page1.srcc016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc017
            #add-point:BEFORE FIELD srcc017 name="input.b.page1.srcc017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc017
            
            #add-point:AFTER FIELD srcc017 name="input.a.page1.srcc017"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc017,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc017 = g_srcc_d_t.srcc017
               NEXT FIELD srcc017
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc017
            #add-point:ON CHANGE srcc017 name="input.g.page1.srcc017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc018
            #add-point:BEFORE FIELD srcc018 name="input.b.page1.srcc018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc018
            
            #add-point:AFTER FIELD srcc018 name="input.a.page1.srcc018"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc018,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc018 = g_srcc_d_t.srcc018
               NEXT FIELD srcc018
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc018
            #add-point:ON CHANGE srcc018 name="input.g.page1.srcc018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc019
            #add-point:BEFORE FIELD srcc019 name="input.b.page1.srcc019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc019
            
            #add-point:AFTER FIELD srcc019 name="input.a.page1.srcc019"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc019,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc019 = g_srcc_d_t.srcc019
               NEXT FIELD srcc019
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc019
            #add-point:ON CHANGE srcc019 name="input.g.page1.srcc019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc020
            #add-point:BEFORE FIELD srcc020 name="input.b.page1.srcc020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc020
            
            #add-point:AFTER FIELD srcc020 name="input.a.page1.srcc020"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc020,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc020 = g_srcc_d_t.srcc020
               NEXT FIELD srcc020
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc020
            #add-point:ON CHANGE srcc020 name="input.g.page1.srcc020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc036
            #add-point:BEFORE FIELD srcc036 name="input.b.page1.srcc036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc036
            
            #add-point:AFTER FIELD srcc036 name="input.a.page1.srcc036"
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc036
            #add-point:ON CHANGE srcc036 name="input.g.page1.srcc036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc037
            
            #add-point:AFTER FIELD srcc037 name="input.a.page1.srcc037"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc037) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_srcc_d[l_ac].srcc037

               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_pmaa001_1") THEN
                  LET g_srcc_d[l_ac].srcc037 = g_srcc_d_t.srcc037
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc037
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc037
            #add-point:BEFORE FIELD srcc037 name="input.b.page1.srcc037"
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc037
            #add-point:ON CHANGE srcc037 name="input.g.page1.srcc037"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc021
            #add-point:BEFORE FIELD srcc021 name="input.b.page1.srcc021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc021
            
            #add-point:AFTER FIELD srcc021 name="input.a.page1.srcc021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc021
            #add-point:ON CHANGE srcc021 name="input.g.page1.srcc021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc022
            #add-point:BEFORE FIELD srcc022 name="input.b.page1.srcc022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc022
            
            #add-point:AFTER FIELD srcc022 name="input.a.page1.srcc022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc022
            #add-point:ON CHANGE srcc022 name="input.g.page1.srcc022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc023
            #add-point:BEFORE FIELD srcc023 name="input.b.page1.srcc023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc023
            
            #add-point:AFTER FIELD srcc023 name="input.a.page1.srcc023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc023
            #add-point:ON CHANGE srcc023 name="input.g.page1.srcc023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc024
            #add-point:BEFORE FIELD srcc024 name="input.b.page1.srcc024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc024
            
            #add-point:AFTER FIELD srcc024 name="input.a.page1.srcc024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc024
            #add-point:ON CHANGE srcc024 name="input.g.page1.srcc024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc025
            #add-point:BEFORE FIELD srcc025 name="input.b.page1.srcc025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc025
            
            #add-point:AFTER FIELD srcc025 name="input.a.page1.srcc025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc025
            #add-point:ON CHANGE srcc025 name="input.g.page1.srcc025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc026
            #add-point:BEFORE FIELD srcc026 name="input.b.page1.srcc026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc026
            
            #add-point:AFTER FIELD srcc026 name="input.a.page1.srcc026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc026
            #add-point:ON CHANGE srcc026 name="input.g.page1.srcc026"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc046
            
            #add-point:AFTER FIELD srcc046 name="input.a.page1.srcc046"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc046) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_srcc_d[l_ac].srcc046 
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_srcc_d[l_ac].srcc046 = g_srcc_d_t.srcc046
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc046
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc046
            #add-point:BEFORE FIELD srcc046 name="input.b.page1.srcc046"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc046
            #add-point:ON CHANGE srcc046 name="input.g.page1.srcc046"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc047
            #add-point:BEFORE FIELD srcc047 name="input.b.page1.srcc047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc047
            
            #add-point:AFTER FIELD srcc047 name="input.a.page1.srcc047"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc047,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc047 = g_srcc_d_t.srcc047
               NEXT FIELD srcc047
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc047
            #add-point:ON CHANGE srcc047 name="input.g.page1.srcc047"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc048
            #add-point:BEFORE FIELD srcc048 name="input.b.page1.srcc048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc048
            
            #add-point:AFTER FIELD srcc048 name="input.a.page1.srcc048"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc048,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc048 = g_srcc_d_t.srcc048
               NEXT FIELD srcc048
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc048
            #add-point:ON CHANGE srcc048 name="input.g.page1.srcc048"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc027
            
            #add-point:AFTER FIELD srcc027 name="input.a.page1.srcc027"
            CALL asrt801_b_desc()
            IF NOT cl_null(g_srcc_d[l_ac].srcc027) THEN 
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_srcc_d[l_ac].srcc027
               #160318-00025#4--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#4--add--end               
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist("v_ooca001") THEN
                  LET g_srcc_d[l_ac].srcc027 = g_srcc_d_t.srcc027
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc027
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc027
            #add-point:BEFORE FIELD srcc027 name="input.b.page1.srcc027"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc027
            #add-point:ON CHANGE srcc027 name="input.g.page1.srcc027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc028
            #add-point:BEFORE FIELD srcc028 name="input.b.page1.srcc028"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc028,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc028 = g_srcc_d_t.srcc028
               NEXT FIELD srcc028
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc028
            
            #add-point:AFTER FIELD srcc028 name="input.a.page1.srcc028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc028
            #add-point:ON CHANGE srcc028 name="input.g.page1.srcc028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc029
            #add-point:BEFORE FIELD srcc029 name="input.b.page1.srcc029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc029
            
            #add-point:AFTER FIELD srcc029 name="input.a.page1.srcc029"
            IF NOT cl_ap_chk_range(g_srcc_d[l_ac].srcc029,"0.000","1","","","azz-00079",1) THEN
               LET g_srcc_d[l_ac].srcc029 = g_srcc_d_t.srcc029
               NEXT FIELD srcc029
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc029
            #add-point:ON CHANGE srcc029 name="input.g.page1.srcc029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc901
            #add-point:BEFORE FIELD srcc901 name="input.b.page1.srcc901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc901
            
            #add-point:AFTER FIELD srcc901 name="input.a.page1.srcc901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc901
            #add-point:ON CHANGE srcc901 name="input.g.page1.srcc901"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc905
            
            #add-point:AFTER FIELD srcc905 name="input.a.page1.srcc905"
            CALL asrt801_b_desc() 
            IF NOT cl_null(g_srcc_d[l_ac].srcc905) AND (cl_null(g_srcc_d_t.srcc905) OR g_srcc_d[l_ac].srcc905 != g_srcc_d_t.srcc905) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_srcc_d[l_ac].srcc905) THEN
                  LET g_srcc_d[l_ac].srcc905 = g_srcc_d_t.srcc905
                  CALL asrt801_b_desc()
                  NEXT FIELD srcc905
               END IF               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc905
            #add-point:BEFORE FIELD srcc905 name="input.b.page1.srcc905"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc905
            #add-point:ON CHANGE srcc905 name="input.g.page1.srcc905"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc906
            #add-point:BEFORE FIELD srcc906 name="input.b.page1.srcc906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc906
            
            #add-point:AFTER FIELD srcc906 name="input.a.page1.srcc906"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc906
            #add-point:ON CHANGE srcc906 name="input.g.page1.srcc906"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.srcc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc007
            #add-point:ON ACTION controlp INFIELD srcc007 name="input.c.page1.srcc007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc008
            #add-point:ON ACTION controlp INFIELD srcc008 name="input.c.page1.srcc008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc008             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "221" #            
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc_d[l_ac].srcc008 = g_qryparam.return1               
            DISPLAY g_srcc_d[l_ac].srcc008 TO srcc008              #
            NEXT FIELD srcc008                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc009
            #add-point:ON ACTION controlp INFIELD srcc009 name="input.c.page1.srcc009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc010
            #add-point:ON ACTION controlp INFIELD srcc010 name="input.c.page1.srcc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc011
            #add-point:ON ACTION controlp INFIELD srcc011 name="input.c.page1.srcc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc012
            #add-point:ON ACTION controlp INFIELD srcc012 name="input.c.page1.srcc012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc012             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_srca_m.srca000
            LET g_qryparam.arg2 = g_srca_m.srca001
            LET g_qryparam.arg3 = g_srca_m.srca002
            LET g_qryparam.arg4 = g_srca_m.srca004
            LET g_qryparam.arg5 = g_srca_m.srca005
            LET g_qryparam.arg6 = g_srca_m.srca006            
            CALL q_srcc008()                                #呼叫開窗
            LET g_srcc_d[l_ac].srcc012 = g_qryparam.return1     
            LET g_srcc_d[l_ac].srcc013 = g_qryparam.return2             
            DISPLAY g_srcc_d[l_ac].srcc012 TO srcc012              #
            DISPLAY g_srcc_d[l_ac].srcc013 TO srcc013
            NEXT FIELD srcc012                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc013
            #add-point:ON ACTION controlp INFIELD srcc013 name="input.c.page1.srcc013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc014
            #add-point:ON ACTION controlp INFIELD srcc014 name="input.c.page1.srcc014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc015
            #add-point:ON ACTION controlp INFIELD srcc015 name="input.c.page1.srcc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc016
            #add-point:ON ACTION controlp INFIELD srcc016 name="input.c.page1.srcc016"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc016             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ecaa001_1()                                #呼叫開窗

            LET g_srcc_d[l_ac].srcc016 = g_qryparam.return1              

            DISPLAY g_srcc_d[l_ac].srcc016 TO srcc016              #

            NEXT FIELD srcc016                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc017
            #add-point:ON ACTION controlp INFIELD srcc017 name="input.c.page1.srcc017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc018
            #add-point:ON ACTION controlp INFIELD srcc018 name="input.c.page1.srcc018"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc019
            #add-point:ON ACTION controlp INFIELD srcc019 name="input.c.page1.srcc019"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc020
            #add-point:ON ACTION controlp INFIELD srcc020 name="input.c.page1.srcc020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc036
            #add-point:ON ACTION controlp INFIELD srcc036 name="input.c.page1.srcc036"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc037
            #add-point:ON ACTION controlp INFIELD srcc037 name="input.c.page1.srcc037"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc037             #給予default值

            #給予arg
            LET g_qryparam.arg1 = " ('1','3')" #交易對象類型


            CALL q_pmaa001_1()                                #呼叫開窗

            LET g_srcc_d[l_ac].srcc037 = g_qryparam.return1              

            DISPLAY g_srcc_d[l_ac].srcc037 TO srcc037              #

            NEXT FIELD srcc037                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc021
            #add-point:ON ACTION controlp INFIELD srcc021 name="input.c.page1.srcc021"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc022
            #add-point:ON ACTION controlp INFIELD srcc022 name="input.c.page1.srcc022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc023
            #add-point:ON ACTION controlp INFIELD srcc023 name="input.c.page1.srcc023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc024
            #add-point:ON ACTION controlp INFIELD srcc024 name="input.c.page1.srcc024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc025
            #add-point:ON ACTION controlp INFIELD srcc025 name="input.c.page1.srcc025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc026
            #add-point:ON ACTION controlp INFIELD srcc026 name="input.c.page1.srcc026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc046
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc046
            #add-point:ON ACTION controlp INFIELD srcc046 name="input.c.page1.srcc046"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc046             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001()                                #呼叫開窗

            LET g_srcc_d[l_ac].srcc046 = g_qryparam.return1              

            DISPLAY g_srcc_d[l_ac].srcc046 TO srcc046              #

            NEXT FIELD srcc046                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc047
            #add-point:ON ACTION controlp INFIELD srcc047 name="input.c.page1.srcc047"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc048
            #add-point:ON ACTION controlp INFIELD srcc048 name="input.c.page1.srcc048"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc027
            #add-point:ON ACTION controlp INFIELD srcc027 name="input.c.page1.srcc027"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc027             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooca001()                                #呼叫開窗

            LET g_srcc_d[l_ac].srcc027 = g_qryparam.return1              

            DISPLAY g_srcc_d[l_ac].srcc027 TO srcc027              #

            NEXT FIELD srcc027                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc028
            #add-point:ON ACTION controlp INFIELD srcc028 name="input.c.page1.srcc028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc029
            #add-point:ON ACTION controlp INFIELD srcc029 name="input.c.page1.srcc029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc901
            #add-point:ON ACTION controlp INFIELD srcc901 name="input.c.page1.srcc901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc905
            #add-point:ON ACTION controlp INFIELD srcc905 name="input.c.page1.srcc905"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srcc_d[l_ac].srcc905             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_acc
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc_d[l_ac].srcc905 = g_qryparam.return1              
            #LET g_srcc_d[l_ac].oocq002 = g_qryparam.return2 
            DISPLAY g_srcc_d[l_ac].srcc905 TO srcc905              #
            NEXT FIELD srcc905                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.srcc906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc906
            #add-point:ON ACTION controlp INFIELD srcc906 name="input.c.page1.srcc906"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_srcc_d[l_ac].* = g_srcc_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_srcc_d[l_ac].srcc007 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_srcc_d[l_ac].* = g_srcc_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               IF s_transaction_chk("N",0) THEN
                  CALL s_transaction_begin()
               END IF
               IF g_srcc_d[l_ac].srcc901 = '1' THEN
                  LET g_srcc_d[l_ac].srcc901 = '2' 
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asrt801_srcc_t_mask_restore('restore_mask_o')
      
               UPDATE srcc_t SET (srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc900,srcc007, 
                   srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015,srcc016,srcc017,srcc018, 
                   srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,srcc046, 
                   srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902,srcc905,srcc906,srcc030,srcc031, 
                   srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040,srcc041,srcc042,srcc043,srcc044, 
                   srcc045) = (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                   g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[l_ac].srcc007, 
                   g_srcc_d[l_ac].srcc008,g_srcc_d[l_ac].srcc009,g_srcc_d[l_ac].srcc010,g_srcc_d[l_ac].srcc011, 
                   g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013,g_srcc_d[l_ac].srcc014,g_srcc_d[l_ac].srcc015, 
                   g_srcc_d[l_ac].srcc016,g_srcc_d[l_ac].srcc017,g_srcc_d[l_ac].srcc018,g_srcc_d[l_ac].srcc019, 
                   g_srcc_d[l_ac].srcc020,g_srcc_d[l_ac].srcc036,g_srcc_d[l_ac].srcc037,g_srcc_d[l_ac].srcc021, 
                   g_srcc_d[l_ac].srcc022,g_srcc_d[l_ac].srcc023,g_srcc_d[l_ac].srcc024,g_srcc_d[l_ac].srcc025, 
                   g_srcc_d[l_ac].srcc026,g_srcc_d[l_ac].srcc046,g_srcc_d[l_ac].srcc047,g_srcc_d[l_ac].srcc048, 
                   g_srcc_d[l_ac].srcc027,g_srcc_d[l_ac].srcc028,g_srcc_d[l_ac].srcc029,g_srcc_d[l_ac].srcc901, 
                   g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905,g_srcc_d[l_ac].srcc906,g_srcc2_d[l_ac].srcc030, 
                   g_srcc2_d[l_ac].srcc031,g_srcc2_d[l_ac].srcc032,g_srcc2_d[l_ac].srcc033,g_srcc2_d[l_ac].srcc034, 
                   g_srcc2_d[l_ac].srcc035,g_srcc2_d[l_ac].srcc038,g_srcc2_d[l_ac].srcc039,g_srcc2_d[l_ac].srcc040, 
                   g_srcc2_d[l_ac].srcc041,g_srcc2_d[l_ac].srcc042,g_srcc2_d[l_ac].srcc043,g_srcc2_d[l_ac].srcc044, 
                   g_srcc2_d[l_ac].srcc045)
                WHERE srccent = g_enterprise AND srccsite = g_srca_m.srcasite 
                  AND srcc000 = g_srca_m.srca000 
                  AND srcc001 = g_srca_m.srca001 
                  AND srcc002 = g_srca_m.srca002 
                  AND srcc004 = g_srca_m.srca004 
                  AND srcc005 = g_srca_m.srca005 
                  AND srcc006 = g_srca_m.srca006 
                  AND srcc900 = g_srca_m.srca900 
 
                  AND srcc007 = g_srcc_d_t.srcc007 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srcc_d[l_ac].* = g_srcc_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srcc_d[l_ac].* = g_srcc_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys_bak[1] = g_srcasite_t
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys_bak[2] = g_srca000_t
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys_bak[3] = g_srca001_t
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys_bak[4] = g_srca002_t
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys_bak[5] = g_srca004_t
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys_bak[6] = g_srca005_t
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys_bak[7] = g_srca006_t
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys_bak[8] = g_srca900_t
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys_bak[9] = g_srcc_d_t.srcc007
               CALL asrt801_update_b('srcc_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asrt801_srcc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_srcc_d[g_detail_idx].srcc007 = g_srcc_d_t.srcc007 
 
                  ) THEN
                  LET gs_keys[01] = g_srca_m.srcasite
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca000
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca001
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca002
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca004
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca005
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca006
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca900
 
                  LET gs_keys[gs_keys.getLength()+1] = g_srcc_d_t.srcc007
 
                  CALL asrt801_key_update_b(gs_keys,'srcc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc_d_t)
               LET g_log2 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               IF g_srcc_d[l_ac].srcc012 <> 'MULT' AND (g_srcc_d[l_ac].srcc012 != g_srcc_d_t.srcc012 OR g_srcc_d[l_ac].srcc013 != g_srcc_d_t.srcc013) THEN
                  #新增的上站作业删除
                  DELETE FROM srce_t 
                   WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                     AND srce000 = g_srca_m.srca000
                     AND srce001 = g_srca_m.srca001
                     AND srce002 = g_srca_m.srca002
                     AND srce004 = g_srca_m.srca004
                     AND srce005 = g_srca_m.srca005
                     AND srce006 = g_srca_m.srca006
                     AND srce900 = g_srca_m.srca900
                     AND srce007 = g_srcc_d[l_ac].srcc007
                     AND srce901 = '3'
                  SELECT COUNT(*) INTO l_n2 FROM srce_t 
                   WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                     AND srce000 = g_srca_m.srca000
                     AND srce001 = g_srca_m.srca001
                     AND srce002 = g_srca_m.srca002
                     AND srce004 = g_srca_m.srca004
                     AND srce005 = g_srca_m.srca005
                     AND srce006 = g_srca_m.srca006
                     AND srce900 = g_srca_m.srca900
                     AND srce007 = g_srcc_d[l_ac].srcc007
                     AND srce008 = g_srcc_d_t.srcc012
                     AND srce009 = g_srcc_d_t.srcc013
                     AND srce901 != '3'
                  IF l_n2 > 0 THEN
                     UPDATE srce_t SET srce008 = g_srcc_d[l_ac].srcc012,
                                       srce009 = g_srcc_d[l_ac].srcc013,
                                       srce901 = '2'
                      WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                        AND srce000 = g_srca_m.srca000
                        AND srce001 = g_srca_m.srca001
                        AND srce002 = g_srca_m.srca002
                        AND srce004 = g_srca_m.srca004
                        AND srce005 = g_srca_m.srca005
                        AND srce006 = g_srca_m.srca006
                        AND srce900 = g_srca_m.srca900
                        AND srce007 = g_srcc_d[l_ac].srcc007
                        AND srce008 = g_srcc_d_t.srcc012
                        AND srce009 = g_srcc_d_t.srcc013
                        AND srce901 != '3'
                  ELSE
                     SELECT MAX(srceseq)+1 INTO l_srceseq FROM srce_t
                      WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                        AND srce000 = g_srca_m.srca000
                        AND srce001 = g_srca_m.srca001
                        AND srce002 = g_srca_m.srca002
                        AND srce004 = g_srca_m.srca004
                        AND srce005 = g_srca_m.srca005
                        AND srce006 = g_srca_m.srca006
                        AND srce900 = g_srca_m.srca900
                        AND srce007 = g_srcc_d[l_ac].srcc007
                     IF cl_null(l_srceseq) THEN
                        LET l_srceseq = 1
                     END IF
                     INSERT INTO srce_t(srceent,srcesite,srce000,srce001,srce002,srce004,srce005,srce006,srce007,srceseq,srce008,srce009,srce900,srce901,srce905,srce906)
                        VALUES(g_enterprise,g_site,g_ecca_m.ecca000,g_ecca_m.ecca001,g_ecca_m.ecca002,g_ecca_m.ecca004,g_ecca_m.ecca005,g_ecca_m.ecca006,g_srcc_d[l_ac].srcc007,l_srceseq,g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013,g_ecca_m.ecca900,'3',g_srcc_d[l_ac].srcc905,g_srcc_d[l_ac].srcc906)
                 END IF
                 UPDATE srce_t SET srce901 = '4'
                  WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite
                    AND srce000 = g_srca_m.srca000
                    AND srce001 = g_srca_m.srca001
                    AND srce002 = g_srca_m.srca002
                    AND srce004 = g_srca_m.srca004
                    AND srce005 = g_srca_m.srca005
                    AND srce006 = g_srca_m.srca006
                    AND srce900 = g_srca_m.srca900
                    AND srce007 = g_srcc_d[l_ac].srcc007
                    AND srce008 != g_srcc_d_t.srcc012
                    AND srce009 != g_srcc_d_t.srcc013
                    AND srce901 != '3'
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = " srce_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                  END IF
               END IF

               IF NOT asrt801_return_srcc014() THEN
                  LET g_srcc_d[l_ac].* = g_srcc_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               CALL asrt801_b_fill()
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL asrt801_unlock_b("srcc_t","'1'")
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
               LET g_srcc_d[li_reproduce_target].* = g_srcc_d[li_reproduce].*
               LET g_srcc2_d[li_reproduce_target].* = g_srcc2_d[li_reproduce].*
 
               LET g_srcc_d[li_reproduce_target].srcc007 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_srcc_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srcc_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_srcc2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            IF cl_null(g_argv[1]) THEN
               EXIT DIALOG
            END IF
            #end add-point
            
            CALL asrt801_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_srcc2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_srcc2_d[l_ac].* TO NULL 
            INITIALIZE g_srcc2_d_t.* TO NULL 
            INITIALIZE g_srcc2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_srcc2_d[l_ac].srcc030 = "0"
      LET g_srcc2_d[l_ac].srcc031 = "0"
      LET g_srcc2_d[l_ac].srcc032 = "0"
      LET g_srcc2_d[l_ac].srcc033 = "0"
      LET g_srcc2_d[l_ac].srcc034 = "0"
      LET g_srcc2_d[l_ac].srcc035 = "0"
      LET g_srcc2_d[l_ac].srcc038 = "0"
      LET g_srcc2_d[l_ac].srcc039 = "0"
      LET g_srcc2_d[l_ac].srcc040 = "0"
      LET g_srcc2_d[l_ac].srcc041 = "0"
      LET g_srcc2_d[l_ac].srcc042 = "0"
      LET g_srcc2_d[l_ac].srcc043 = "0"
      LET g_srcc2_d[l_ac].srcc044 = "0"
      LET g_srcc2_d[l_ac].srcc045 = "0"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_srcc2_d_t.* = g_srcc2_d[l_ac].*     #新輸入資料
            LET g_srcc2_d_o.* = g_srcc2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            
            #end add-point
            CALL asrt801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srcc_d[li_reproduce_target].* = g_srcc_d[li_reproduce].*
               LET g_srcc2_d[li_reproduce_target].* = g_srcc2_d[li_reproduce].*
 
               LET g_srcc2_d[li_reproduce_target].srcc007 = NULL
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
            CALL asrt801_b_fill2('2')
  
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srcc2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srcc2_d[l_ac].srcc007 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_srcc2_d_t.* = g_srcc2_d[l_ac].*  #BACKUP
               LET g_srcc2_d_o.* = g_srcc2_d[l_ac].*  #BACKUP
               CALL asrt801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               
               #end add-point  
               CALL asrt801_set_no_entry_b(l_cmd)
               IF NOT asrt801_lock_b("srcc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt801_bcl INTO g_srcc_d[l_ac].srcc007,g_srcc_d[l_ac].srcc008,g_srcc_d[l_ac].srcc009, 
                      g_srcc_d[l_ac].srcc010,g_srcc_d[l_ac].srcc011,g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013, 
                      g_srcc_d[l_ac].srcc014,g_srcc_d[l_ac].srcc015,g_srcc_d[l_ac].srcc016,g_srcc_d[l_ac].srcc017, 
                      g_srcc_d[l_ac].srcc018,g_srcc_d[l_ac].srcc019,g_srcc_d[l_ac].srcc020,g_srcc_d[l_ac].srcc036, 
                      g_srcc_d[l_ac].srcc037,g_srcc_d[l_ac].srcc021,g_srcc_d[l_ac].srcc022,g_srcc_d[l_ac].srcc023, 
                      g_srcc_d[l_ac].srcc024,g_srcc_d[l_ac].srcc025,g_srcc_d[l_ac].srcc026,g_srcc_d[l_ac].srcc046, 
                      g_srcc_d[l_ac].srcc047,g_srcc_d[l_ac].srcc048,g_srcc_d[l_ac].srcc027,g_srcc_d[l_ac].srcc028, 
                      g_srcc_d[l_ac].srcc029,g_srcc_d[l_ac].srcc901,g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905, 
                      g_srcc_d[l_ac].srcc906,g_srcc2_d[l_ac].srcc007,g_srcc2_d[l_ac].srcc030,g_srcc2_d[l_ac].srcc031, 
                      g_srcc2_d[l_ac].srcc032,g_srcc2_d[l_ac].srcc033,g_srcc2_d[l_ac].srcc034,g_srcc2_d[l_ac].srcc035, 
                      g_srcc2_d[l_ac].srcc038,g_srcc2_d[l_ac].srcc039,g_srcc2_d[l_ac].srcc040,g_srcc2_d[l_ac].srcc041, 
                      g_srcc2_d[l_ac].srcc042,g_srcc2_d[l_ac].srcc043,g_srcc2_d[l_ac].srcc044,g_srcc2_d[l_ac].srcc045 
 
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srcc2_d_mask_o[l_ac].* =  g_srcc2_d[l_ac].*
                  CALL asrt801_srcc_t_mask()
                  LET g_srcc2_d_mask_n[l_ac].* =  g_srcc2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt801_show()
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
               LET gs_keys[01] = g_srca_m.srcasite
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca000
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca001
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca002
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca004
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca005
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca006
               LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca900
               LET gs_keys[gs_keys.getLength()+1] = g_srcc2_d_t.srcc007
            
               #刪除同層單身
               IF NOT asrt801_delete_b('srcc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt801_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asrt801_key_delete_b(gs_keys,'srcc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt801_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_srcc_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srcc2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM srcc_t 
             WHERE srccent = g_enterprise AND srccsite = g_srca_m.srcasite
               AND srcc000 = g_srca_m.srca000
               AND srcc001 = g_srca_m.srca001
               AND srcc002 = g_srca_m.srca002
               AND srcc004 = g_srca_m.srca004
               AND srcc005 = g_srca_m.srca005
               AND srcc006 = g_srca_m.srca006
               AND srcc900 = g_srca_m.srca900
               AND srcc007 = g_srcc2_d[l_ac].srcc007
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys[9] = g_srcc2_d[g_detail_idx].srcc007
               CALL asrt801_insert_b('srcc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_srcc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt801_b_fill()
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
               LET g_srcc2_d[l_ac].* = g_srcc2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt801_bcl
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
               LET g_srcc2_d[l_ac].* = g_srcc2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               IF g_srcc_d[l_ac].srcc901 = '1' THEN
                  LET g_srcc_d[l_ac].srcc901 = '2'
               END IF
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL asrt801_srcc_t_mask_restore('restore_mask_o')
                              
               UPDATE srcc_t SET (srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc900,srcc007, 
                   srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015,srcc016,srcc017,srcc018, 
                   srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,srcc046, 
                   srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902,srcc905,srcc906,srcc030,srcc031, 
                   srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040,srcc041,srcc042,srcc043,srcc044, 
                   srcc045) = (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                   g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[l_ac].srcc007, 
                   g_srcc_d[l_ac].srcc008,g_srcc_d[l_ac].srcc009,g_srcc_d[l_ac].srcc010,g_srcc_d[l_ac].srcc011, 
                   g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013,g_srcc_d[l_ac].srcc014,g_srcc_d[l_ac].srcc015, 
                   g_srcc_d[l_ac].srcc016,g_srcc_d[l_ac].srcc017,g_srcc_d[l_ac].srcc018,g_srcc_d[l_ac].srcc019, 
                   g_srcc_d[l_ac].srcc020,g_srcc_d[l_ac].srcc036,g_srcc_d[l_ac].srcc037,g_srcc_d[l_ac].srcc021, 
                   g_srcc_d[l_ac].srcc022,g_srcc_d[l_ac].srcc023,g_srcc_d[l_ac].srcc024,g_srcc_d[l_ac].srcc025, 
                   g_srcc_d[l_ac].srcc026,g_srcc_d[l_ac].srcc046,g_srcc_d[l_ac].srcc047,g_srcc_d[l_ac].srcc048, 
                   g_srcc_d[l_ac].srcc027,g_srcc_d[l_ac].srcc028,g_srcc_d[l_ac].srcc029,g_srcc_d[l_ac].srcc901, 
                   g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905,g_srcc_d[l_ac].srcc906,g_srcc2_d[l_ac].srcc030, 
                   g_srcc2_d[l_ac].srcc031,g_srcc2_d[l_ac].srcc032,g_srcc2_d[l_ac].srcc033,g_srcc2_d[l_ac].srcc034, 
                   g_srcc2_d[l_ac].srcc035,g_srcc2_d[l_ac].srcc038,g_srcc2_d[l_ac].srcc039,g_srcc2_d[l_ac].srcc040, 
                   g_srcc2_d[l_ac].srcc041,g_srcc2_d[l_ac].srcc042,g_srcc2_d[l_ac].srcc043,g_srcc2_d[l_ac].srcc044, 
                   g_srcc2_d[l_ac].srcc045) #自訂欄位頁簽
                WHERE srccent = g_enterprise AND srccsite = g_srca_m.srcasite
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc007 = g_srcc2_d_t.srcc007 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srcc2_d[l_ac].* = g_srcc2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srcc2_d[l_ac].* = g_srcc2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys_bak[1] = g_srcasite_t
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys_bak[2] = g_srca000_t
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys_bak[3] = g_srca001_t
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys_bak[4] = g_srca002_t
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys_bak[5] = g_srca004_t
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys_bak[6] = g_srca005_t
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys_bak[7] = g_srca006_t
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys_bak[8] = g_srca900_t
               LET gs_keys[9] = g_srcc2_d[g_detail_idx].srcc007
               LET gs_keys_bak[9] = g_srcc2_d_t.srcc007
               CALL asrt801_update_b('srcc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asrt801_srcc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_srcc2_d[g_detail_idx].srcc007 = g_srcc2_d_t.srcc007 
                  ) THEN
                  LET gs_keys[01] = g_srca_m.srcasite
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca000
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca001
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca002
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca004
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca005
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca006
                  LET gs_keys[gs_keys.getLength()+1] = g_srca_m.srca900
                  LET gs_keys[gs_keys.getLength()+1] = g_srcc2_d_t.srcc007
                  CALL asrt801_key_update_b(gs_keys,'srcc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc2_d_t)
               LET g_log2 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               IF NOT asrt801_upd_srcc_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc2_d[l_ac].srcc007,0,g_srca_m.srca900) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               CALL asrt801_b_fill()
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc008_2
            
            #add-point:AFTER FIELD l_srcc008_2 name="input.a.page2.l_srcc008_2"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_srcc2_d[l_ac].l_srcc008_2
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_srcc2_d[l_ac].l_srcc008_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_srcc2_d[l_ac].l_srcc008_2_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc008_2
            #add-point:BEFORE FIELD l_srcc008_2 name="input.b.page2.l_srcc008_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_srcc008_2
            #add-point:ON CHANGE l_srcc008_2 name="input.g.page2.l_srcc008_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc009_2
            #add-point:BEFORE FIELD l_srcc009_2 name="input.b.page2.l_srcc009_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc009_2
            
            #add-point:AFTER FIELD l_srcc009_2 name="input.a.page2.l_srcc009_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_srcc009_2
            #add-point:ON CHANGE l_srcc009_2 name="input.g.page2.l_srcc009_2"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_srcc016_2
            
            #add-point:AFTER FIELD l_srcc016_2 name="input.a.page2.l_srcc016_2"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_srca_m.srcasite
            LET g_ref_fields[2] = g_srcc2_d[l_ac].l_srcc016_2
            CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
            LET g_srcc2_d[l_ac].l_srcc016_2_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_srcc2_d[l_ac].l_srcc016_2_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_srcc016_2
            #add-point:BEFORE FIELD l_srcc016_2 name="input.b.page2.l_srcc016_2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_srcc016_2
            #add-point:ON CHANGE l_srcc016_2 name="input.g.page2.l_srcc016_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc030
            #add-point:BEFORE FIELD srcc030 name="input.b.page2.srcc030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc030
            
            #add-point:AFTER FIELD srcc030 name="input.a.page2.srcc030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc030
            #add-point:ON CHANGE srcc030 name="input.g.page2.srcc030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc031
            #add-point:BEFORE FIELD srcc031 name="input.b.page2.srcc031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc031
            
            #add-point:AFTER FIELD srcc031 name="input.a.page2.srcc031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc031
            #add-point:ON CHANGE srcc031 name="input.g.page2.srcc031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc032
            #add-point:BEFORE FIELD srcc032 name="input.b.page2.srcc032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc032
            
            #add-point:AFTER FIELD srcc032 name="input.a.page2.srcc032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc032
            #add-point:ON CHANGE srcc032 name="input.g.page2.srcc032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc033
            #add-point:BEFORE FIELD srcc033 name="input.b.page2.srcc033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc033
            
            #add-point:AFTER FIELD srcc033 name="input.a.page2.srcc033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc033
            #add-point:ON CHANGE srcc033 name="input.g.page2.srcc033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc034
            #add-point:BEFORE FIELD srcc034 name="input.b.page2.srcc034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc034
            
            #add-point:AFTER FIELD srcc034 name="input.a.page2.srcc034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc034
            #add-point:ON CHANGE srcc034 name="input.g.page2.srcc034"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc035
            #add-point:BEFORE FIELD srcc035 name="input.b.page2.srcc035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc035
            
            #add-point:AFTER FIELD srcc035 name="input.a.page2.srcc035"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc035
            #add-point:ON CHANGE srcc035 name="input.g.page2.srcc035"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc038
            #add-point:BEFORE FIELD srcc038 name="input.b.page2.srcc038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc038
            
            #add-point:AFTER FIELD srcc038 name="input.a.page2.srcc038"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc038
            #add-point:ON CHANGE srcc038 name="input.g.page2.srcc038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc039
            #add-point:BEFORE FIELD srcc039 name="input.b.page2.srcc039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc039
            
            #add-point:AFTER FIELD srcc039 name="input.a.page2.srcc039"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc039
            #add-point:ON CHANGE srcc039 name="input.g.page2.srcc039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc040
            #add-point:BEFORE FIELD srcc040 name="input.b.page2.srcc040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc040
            
            #add-point:AFTER FIELD srcc040 name="input.a.page2.srcc040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc040
            #add-point:ON CHANGE srcc040 name="input.g.page2.srcc040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc041
            #add-point:BEFORE FIELD srcc041 name="input.b.page2.srcc041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc041
            
            #add-point:AFTER FIELD srcc041 name="input.a.page2.srcc041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc041
            #add-point:ON CHANGE srcc041 name="input.g.page2.srcc041"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc042
            #add-point:BEFORE FIELD srcc042 name="input.b.page2.srcc042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc042
            
            #add-point:AFTER FIELD srcc042 name="input.a.page2.srcc042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc042
            #add-point:ON CHANGE srcc042 name="input.g.page2.srcc042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc043
            #add-point:BEFORE FIELD srcc043 name="input.b.page2.srcc043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc043
            
            #add-point:AFTER FIELD srcc043 name="input.a.page2.srcc043"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc043
            #add-point:ON CHANGE srcc043 name="input.g.page2.srcc043"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc044
            #add-point:BEFORE FIELD srcc044 name="input.b.page2.srcc044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc044
            
            #add-point:AFTER FIELD srcc044 name="input.a.page2.srcc044"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc044
            #add-point:ON CHANGE srcc044 name="input.g.page2.srcc044"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcc045
            #add-point:BEFORE FIELD srcc045 name="input.b.page2.srcc045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcc045
            
            #add-point:AFTER FIELD srcc045 name="input.a.page2.srcc045"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcc045
            #add-point:ON CHANGE srcc045 name="input.g.page2.srcc045"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.l_srcc008_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc008_2
            #add-point:ON ACTION controlp INFIELD l_srcc008_2 name="input.c.page2.l_srcc008_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_srcc009_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc009_2
            #add-point:ON ACTION controlp INFIELD l_srcc009_2 name="input.c.page2.l_srcc009_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.l_srcc016_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_srcc016_2
            #add-point:ON ACTION controlp INFIELD l_srcc016_2 name="input.c.page2.l_srcc016_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc030
            #add-point:ON ACTION controlp INFIELD srcc030 name="input.c.page2.srcc030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc031
            #add-point:ON ACTION controlp INFIELD srcc031 name="input.c.page2.srcc031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc032
            #add-point:ON ACTION controlp INFIELD srcc032 name="input.c.page2.srcc032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc033
            #add-point:ON ACTION controlp INFIELD srcc033 name="input.c.page2.srcc033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc034
            #add-point:ON ACTION controlp INFIELD srcc034 name="input.c.page2.srcc034"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc035
            #add-point:ON ACTION controlp INFIELD srcc035 name="input.c.page2.srcc035"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc038
            #add-point:ON ACTION controlp INFIELD srcc038 name="input.c.page2.srcc038"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc039
            #add-point:ON ACTION controlp INFIELD srcc039 name="input.c.page2.srcc039"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc040
            #add-point:ON ACTION controlp INFIELD srcc040 name="input.c.page2.srcc040"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc041
            #add-point:ON ACTION controlp INFIELD srcc041 name="input.c.page2.srcc041"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc042
            #add-point:ON ACTION controlp INFIELD srcc042 name="input.c.page2.srcc042"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc043
            #add-point:ON ACTION controlp INFIELD srcc043 name="input.c.page2.srcc043"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc044
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc044
            #add-point:ON ACTION controlp INFIELD srcc044 name="input.c.page2.srcc044"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.srcc045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcc045
            #add-point:ON ACTION controlp INFIELD srcc045 name="input.c.page2.srcc045"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_srcc2_d[l_ac].* = g_srcc2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL asrt801_unlock_b("srcc_t","'2'")
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
               LET g_srcc_d[li_reproduce_target].* = g_srcc_d[li_reproduce].*
               LET g_srcc2_d[li_reproduce_target].* = g_srcc2_d[li_reproduce].*
 
               LET g_srcc2_d[li_reproduce_target].srcc007 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_srcc2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srcc2_d.getLength()+1
            END IF
            
      END INPUT
 
      
      INPUT ARRAY g_srcc3_d FROM s_detail3.*
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
            IF g_detail_idx = 0 OR g_srcc_d.getLength() = 0 THEN
               NEXT FIELD srcc007
            END IF
            #檢查上層單身是否有資料
            IF cl_null(g_srcc_d[g_detail_idx].srcc007) THEN
               NEXT FIELD srcc007
            END IF
            #add-point:資料輸入前 name="input.body3.before_input2"
            IF g_argv[1] = '2' THEN
               EXIT DIALOG
            END IF
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srcc3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue(""))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_srcc3_d.getLength()
            #add-point:資料輸入前 name="input.body3.before_input"
            
            #end add-point
            
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_srcc3_d[l_ac].* TO NULL 
            INITIALIZE g_srcc3_d_t.* TO NULL 
            INITIALIZE g_srcc3_d_o.* TO NULL 
            #公用欄位給值(單身3)
            
            #自定義預設值(單身3)
                  LET g_srcc3_d[l_ac].srcd008 = "1"
      LET g_srcc3_d[l_ac].srcd010 = "1"
      LET g_srcc3_d[l_ac].srcd011 = "0"
      LET g_srcc3_d[l_ac].srcd012 = "0"
      LET g_srcc3_d[l_ac].srcd014 = "Y"
      LET g_srcc3_d[l_ac].srcd901 = "3"
 
            #add-point:modify段before備份 name="input.body3.insert.before_bak"
            LET g_srcc3_d[l_ac].srcd902 = cl_get_today()
            #end add-point
            LET g_srcc3_d_t.* = g_srcc3_d[l_ac].*     #新輸入資料
            LET g_srcc3_d_o.* = g_srcc3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt801_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body3.insert.after_set_entry_b"
            
            #end add-point
            CALL asrt801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srcc3_d[li_reproduce_target].* = g_srcc3_d[li_reproduce].*
 
               LET g_srcc3_d[li_reproduce_target].srcdseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body3.before_insert"
            SELECT MAX(srcdseq)+1 INTO g_srcc3_d[l_ac].srcdseq FROM srcd_t
             WHERE srcdent = g_enterprise AND srcdsite = g_site AND srcd000 = g_srca_m.srca000
               AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004
               AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900
               AND srcd007 = g_srcc_d[g_detail_idx].srcc007
            IF cl_null(g_srcc3_d[l_ac].srcdseq) THEN
               LET g_srcc3_d[l_ac].srcdseq = 1
            END IF
            #end add-point  
            
         BEFORE ROW
            #add-point:modify段before row2 name="input.body3.before_row2"
            CALL cl_set_comp_entry("srcd011,srcd012",TRUE)
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
            OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
            #(ver:78) ---start---
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE 
               CLOSE asrt801_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            #(ver:78) --- end ---
            OPEN asrt801_bcl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001, 
                g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900, 
                g_srcc_d[g_detail_idx].srcc007
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_bcl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asrt801_cl
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_srcc3_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_srcc3_d[l_ac].srcdseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_srcc3_d_t.* = g_srcc3_d[l_ac].*  #BACKUP
               LET g_srcc3_d_o.* = g_srcc3_d[l_ac].*  #BACKUP
               CALL asrt801_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body3.after_set_entry_b"
               
               #end add-point  
               CALL asrt801_set_no_entry_b(l_cmd)
               IF NOT asrt801_lock_b("srcd_t","'3'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt801_bcl2 INTO g_srcc3_d[l_ac].srcdseq,g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009, 
                      g_srcc3_d[l_ac].srcd010,g_srcc3_d[l_ac].srcd011,g_srcc3_d[l_ac].srcd012,g_srcc3_d[l_ac].srcd013, 
                      g_srcc3_d[l_ac].srcd014,g_srcc3_d[l_ac].srcd901,g_srcc3_d[l_ac].srcd902,g_srcc3_d[l_ac].srcd905, 
                      g_srcc3_d[l_ac].srcd906
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_srcc3_d_mask_o[l_ac].* =  g_srcc3_d[l_ac].*
                  CALL asrt801_srcd_t_mask()
                  LET g_srcc3_d_mask_n[l_ac].* =  g_srcc3_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asrt801_show()
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
               IF g_srcc3_d[l_ac].srcd901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_srcc3_d[l_ac].srcd009
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               
               IF NOT asrt801_srcd_delete(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007,g_srcc3_d[l_ac].srcdseq) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF
               
               CALL s_transaction_end('Y','0')
               LET l_cmd = 'd'     #防止进入AFTER DELETE 继续删除单身资料
               IF 1 = 2 THEN
               #end add-point    
 
               #取得該筆資料key值
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys[10] = g_srcc3_d_t.srcdseq
 
 
               #刪除同層單身
               IF NOT asrt801_delete_b('srcd_t',gs_keys,"'3'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asrt801_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身3刪除中 name="input.body3.m_delete"
               
               #end add-point   
               
               CALL s_transaction_end('Y','0')
               CLOSE asrt801_bcl
                  
               LET g_rec_b = g_rec_b-1
               #add-point:單身3刪除後 name="input.body3.a_delete"
                  END IF
               #end add-point
 
               LET l_count = g_srcc_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body3.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_srcc3_d.getLength() + 1) THEN
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
            #下面产生的where条件不对
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM srcd_t 
             WHERE srcdent = g_enterprise AND srcdsite = g_srca_m.srcasite AND srcd000 = g_srca_m.srca000  
                 AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004  
                 AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900  
                 AND srcd007 = g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc3_d[g_detail_idx2].srcdseq 
           
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               IF 1 = 2 THEN
            #end add-point
    
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM srcd_t 
             WHERE srcdent = g_enterprise AND srcdsite = g_srca_m.srcasite AND srcd000 = g_srca_m.srca000  
                 AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004  
                 AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900  
                 AND srcd007 = g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc3_d[g_detail_idx2].srcdseq 
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身3新增前 name="input.body3.b_insert"
               END IF
               END IF
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys[10] = g_srcc3_d[g_detail_idx2].srcdseq
               CALL asrt801_insert_b('srcd_t',gs_keys,"'3'")
                           
               #add-point:單身新增後3 name="input.body3.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_srcc_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asrt801_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body3.after_insert"
               IF NOT asrt801_upd_srcd_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc3_d[l_ac].srcdseq,g_srca_m.srca900) THEN 
                  LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
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
               LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt801_bcl2
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
               LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
            ELSE
               #add-point:單身page3修改前 name="input.body3.b_update"
               IF g_srcc3_d[l_ac].srcd901 = '1' THEN
                  LET g_srcc3_d[l_ac].srcd901 = '2'
               END IF
               LET g_srcc3_d[l_ac].srcd902 = cl_get_today()
               
               #下面系统产生的update语句对应where条件不对
               CALL asrt801_srcd_t_mask_restore('restore_mask_o')
               
               UPDATE srcd_t SET (srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd007,srcd900, 
                   srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905, 
                   srcd906) = (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                   g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007, 
                   g_srcc3_d[l_ac].srcdseq,g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,g_srcc3_d[l_ac].srcd010, 
                   g_srcc3_d[l_ac].srcd011,g_srcc3_d[l_ac].srcd012,g_srcc3_d[l_ac].srcd013,g_srcc3_d[l_ac].srcd014, 
                   g_srcc3_d[l_ac].srcd901,g_srcc3_d[l_ac].srcd902,g_srcc3_d[l_ac].srcd905,g_srcc3_d[l_ac].srcd906)  
                   #自訂欄位頁簽
                WHERE srcdent = g_enterprise AND srcdsite = g_srcasite_t AND srcd000 = g_srca000_t AND  
                    srcd001 = g_srca001_t AND srcd002 = g_srca002_t AND srcd004 = g_srca004_t AND srcd005  
                    = g_srca005_t AND srcd006 = g_srca006_t AND srcd900 = g_srca900_t AND srcd007 =  
                    g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc3_d_t.srcdseq AND srcd008 = '1'
                    
               IF 1 = 2 THEN
               #end add-point
               
               #寫入修改者/修改日期資訊(單身3)
               
               
               #將遮罩欄位還原
               CALL asrt801_srcd_t_mask_restore('restore_mask_o')
               
               UPDATE srcd_t SET (srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007, 
                   srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905, 
                   srcd906) = (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                   g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007, 
                   g_srcc3_d[l_ac].srcdseq,g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,g_srcc3_d[l_ac].srcd010, 
                   g_srcc3_d[l_ac].srcd011,g_srcc3_d[l_ac].srcd012,g_srcc3_d[l_ac].srcd013,g_srcc3_d[l_ac].srcd014, 
                   g_srcc3_d[l_ac].srcd901,g_srcc3_d[l_ac].srcd902,g_srcc3_d[l_ac].srcd905,g_srcc3_d[l_ac].srcd906)  
                   #自訂欄位頁簽
                WHERE srcdent = g_enterprise AND srcdsite = g_srcasite_t AND srcd000 = g_srca000_t AND  
                    srcd001 = g_srca001_t AND srcd002 = g_srca002_t AND srcd004 = g_srca004_t AND srcd005  
                    = g_srca005_t AND srcd006 = g_srca006_t AND srcd900 = g_srca900_t AND srcd007 =  
                    g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc3_d_t.srcdseq
                  
               #add-point:單身page3修改中 name="input.body3.m_update"
               END IF
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys_bak[1] = g_srcasite_t
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys_bak[2] = g_srca000_t
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys_bak[3] = g_srca001_t
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys_bak[4] = g_srca002_t
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys_bak[5] = g_srca004_t
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys_bak[6] = g_srca005_t
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys_bak[7] = g_srca006_t
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys_bak[8] = g_srca900_t
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys_bak[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys[10] = g_srcc3_d[g_detail_idx2].srcdseq
               LET gs_keys_bak[10] = g_srcc3_d_t.srcdseq
               CALL asrt801_update_b('srcd_t',gs_keys,gs_keys_bak,"'3'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asrt801_srcd_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc3_d_t)
               LET g_log2 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc3_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page3修改後 name="input.body3.a_update"
               IF NOT asrt801_upd_srcd_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc3_d[l_ac].srcdseq,g_srca_m.srca900) THEN 
                  LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcdseq
            #add-point:BEFORE FIELD srcdseq name="input.b.page3.srcdseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcdseq
            
            #add-point:AFTER FIELD srcdseq name="input.a.page3.srcdseq"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  g_srca_m.srcasite IS NOT NULL AND g_srca_m.srca000 IS NOT NULL AND g_srca_m.srca001 IS NOT NULL AND g_srca_m.srca002 IS NOT NULL AND g_srca_m.srca004 IS NOT NULL AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND g_srca_m.srca900 IS NOT NULL AND g_srcc_d[g_detail_idx].srcc007 IS NOT NULL AND g_srcc3_d[g_detail_idx2].srcdseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_srca_m.srcasite != g_srcasite_t OR g_srca_m.srca000 != g_srca000_t OR g_srca_m.srca001 != g_srca001_t OR g_srca_m.srca002 != g_srca002_t OR g_srca_m.srca004 != g_srca004_t OR g_srca_m.srca005 != g_srca005_t OR g_srca_m.srca006 != g_srca006_t OR g_srca_m.srca900 != g_srca900_t OR g_srcc_d[g_detail_idx].srcc007 != g_srcc_d[g_detail_idx].srcc007 OR g_srcc3_d[g_detail_idx2].srcdseq != g_srcc3_d_t.srcdseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM srcd_t WHERE "||"srcdent = '" ||g_enterprise|| "' AND "||"srcdsite = '"||g_srca_m.srcasite ||"' AND "|| "srcd000 = '"||g_srca_m.srca000 ||"' AND "|| "srcd001 = '"||g_srca_m.srca001 ||"' AND "|| "srcd002 = '"||g_srca_m.srca002 ||"' AND "|| "srcd004 = '"||g_srca_m.srca004 ||"' AND "|| "srcd005 = '"||g_srca_m.srca005 ||"' AND "|| "srcd006 = '"||g_srca_m.srca006 ||"' AND "|| "srcd007 = '"||g_srca_m.srca900 ||"' AND "|| "srcd900 = '"||g_srcc_d[g_detail_idx].srcc007 ||"' AND "|| "srcdseq = '"||g_srcc3_d[g_detail_idx2].srcdseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcdseq
            #add-point:ON CHANGE srcdseq name="input.g.page3.srcdseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd008
            #add-point:BEFORE FIELD srcd008 name="input.b.page3.srcd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd008
            
            #add-point:AFTER FIELD srcd008 name="input.a.page3.srcd008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd008
            #add-point:ON CHANGE srcd008 name="input.g.page3.srcd008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd009
            
            #add-point:AFTER FIELD srcd009 name="input.a.page3.srcd009"
            CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,'')
            IF  g_srca_m.srcasite IS NOT NULL AND g_srca_m.srca000 IS NOT NULL AND g_srca_m.srca001 IS NOT NULL AND g_srca_m.srca002 IS NOT NULL AND g_srca_m.srca004 IS NOT NULL AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND g_srca_m.srca900 IS NOT NULL AND g_srcc_d[g_detail_idx].srcc007 IS NOT NULL AND NOT cl_null(g_srcc3_d[l_ac].srcd009) THEN 
              IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_srcc3_d[l_ac].srcd009 != g_srcc3_d_t.srcd009))) THEN 
                  IF NOT ap_chk_notDup(g_srcc3_d[l_ac].srcd009,"SELECT COUNT(*) FROM srcd_t WHERE "||"srcdent = '" ||g_enterprise|| "' AND srcdsite = '" ||g_site|| "' AND "||"srcd000 = '"||g_srca_m.srca000||"' AND "|| "srcd001 = '"||g_srca_m.srca001 ||"' AND "|| "srcd002 = '"||g_srca_m.srca002 ||"' AND "|| "srcd004 = '"||g_srca_m.srca004 ||"' AND "|| "srcd005 = '"||g_srca_m.srca005||"' AND "|| "srcd006 = '"||g_srca_m.srca006||"' AND "|| "srcd900 = "||g_srca_m.srca900||" AND "|| "srcd007 = "||g_srcc_d[g_detail_idx].srcc007||" AND "|| "srcd008 = '"||g_srcc3_d[l_ac].srcd008||"' AND "|| "srcd009 = '"||g_srcc3_d[l_ac].srcd009||"'",'aec-00028',1) THEN 
                     LET g_srcc3_d[l_ac].srcd009 =  g_srcc3_d_t.srcd009
                     CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,'')                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_srcc3_d[l_ac].srcd009) THEN
               IF NOT s_azzi650_chk_exist('223',g_srcc3_d[l_ac].srcd009) THEN
                  LET g_srcc3_d[l_ac].srcd009 =  g_srcc3_d_t.srcd009
                  CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,'')                     
                  NEXT FIELD CURRENT
               END IF
            END IF  
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd009
            #add-point:BEFORE FIELD srcd009 name="input.b.page3.srcd009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd009
            #add-point:ON CHANGE srcd009 name="input.g.page3.srcd009"
           
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd010
            #add-point:BEFORE FIELD srcd010 name="input.b.page3.srcd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd010
            
            #add-point:AFTER FIELD srcd010 name="input.a.page3.srcd010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd010
            #add-point:ON CHANGE srcd010 name="input.g.page3.srcd010"
            IF g_srcc3_d[l_ac].srcd010 = '1' THEN
               CALL cl_set_comp_entry("srcd011,srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("srcd011,srcd012",FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd011
            #add-point:BEFORE FIELD srcd011 name="input.b.page3.srcd011"
            IF g_srcc3_d[l_ac].srcd010 = '1' THEN
               CALL cl_set_comp_entry("srcd011,srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("srcd011,srcd012",FALSE)
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd011
            
            #add-point:AFTER FIELD srcd011 name="input.a.page3.srcd011"
            IF NOT cl_null(g_srcc3_d[l_ac].srcd011) AND NOT cl_null(g_srcc3_d[l_ac].srcd012) THEN
               IF g_srcc3_d[l_ac].srcd012 < g_srcc3_d[l_ac].srcd011 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_srcc3_d[l_ac].srcd011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_srcc3_d[l_ac].srcd011 = g_srcc3_d_t.srcd011
                  NEXT FIELD srcd011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd011
            #add-point:ON CHANGE srcd011 name="input.g.page3.srcd011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd012
            #add-point:BEFORE FIELD srcd012 name="input.b.page3.srcd012"
            IF g_srcc3_d[l_ac].srcd010 = '1' THEN
               CALL cl_set_comp_entry("srcd011,srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("srcd011,srcd012",FALSE)
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd012
            
            #add-point:AFTER FIELD srcd012 name="input.a.page3.srcd012"
            IF NOT cl_null(g_srcc3_d[l_ac].srcd011) AND NOT cl_null(g_srcc3_d[l_ac].srcd012) THEN
               IF g_srcc3_d[l_ac].srcd012 < g_srcc3_d[l_ac].srcd011 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_srcc3_d[l_ac].srcd012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_srcc3_d[l_ac].srcd012 = g_srcc3_d_t.srcd012
                  NEXT FIELD srcd012
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd012
            #add-point:ON CHANGE srcd012 name="input.g.page3.srcd012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd013
            #add-point:BEFORE FIELD srcd013 name="input.b.page3.srcd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd013
            
            #add-point:AFTER FIELD srcd013 name="input.a.page3.srcd013"
            IF NOT cl_null(g_srcc3_d[l_ac].srcd013) AND (cl_null(g_srcc3_d_t.srcd013) OR g_srcc3_d[l_ac].srcd013 != g_srcc3_d_t.srcd013) THEN
               IF g_srcc3_d[l_ac].srcd010 = '1' THEN
                  LET l_srcd013_str = g_srcc3_d[l_ac].srcd013
                  LET l_srcd013_n1 = l_srcd013_str.getIndexOf(".",2)
                  IF l_srcd013_n1 > 0 THEN
                     LET l_srcd013_str1 = l_srcd013_str.substring(1,l_srcd013_n1-1)
                     LET l_srcd013_str2 = l_srcd013_str.substring(l_srcd013_n1+1,l_srcd013_str.getLength())
                     CALL s_chr_alphanumeric(l_srcd013_str1,1) RETURNING l_result
                     IF l_result THEN
                        CALL s_chr_alphanumeric(l_srcd013_str2,1) RETURNING l_result 
                     END IF
                  ELSE
                     CALL s_chr_alphanumeric(g_srcc3_d[l_ac].srcd013,1) RETURNING l_result
                  END IF
                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00013'
                     LET g_errparam.extend = g_srcc3_d[l_ac].srcd013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srcc3_d[l_ac].srcd013 = g_srcc3_d_t.srcd013
                     NEXT FIELD srcd013
                  END IF
                  
                  LET l_srcd013_num = g_srcc3_d[l_ac].srcd013
                  IF l_srcd013_num > g_srcc3_d[l_ac].srcd012 OR l_srcd013_num < g_srcc3_d[l_ac].srcd011 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00015'
                     LET g_errparam.extend = g_srcc3_d[l_ac].srcd013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc3_d[l_ac].srcd013 = g_srcc3_d_t.srcd013
                     NEXT FIELD srcd013
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd013
            #add-point:ON CHANGE srcd013 name="input.g.page3.srcd013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd014
            #add-point:BEFORE FIELD srcd014 name="input.b.page3.srcd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd014
            
            #add-point:AFTER FIELD srcd014 name="input.a.page3.srcd014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd014
            #add-point:ON CHANGE srcd014 name="input.g.page3.srcd014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd901
            #add-point:BEFORE FIELD srcd901 name="input.b.page3.srcd901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd901
            
            #add-point:AFTER FIELD srcd901 name="input.a.page3.srcd901"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd901
            #add-point:ON CHANGE srcd901 name="input.g.page3.srcd901"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd905
            
            #add-point:AFTER FIELD srcd905 name="input.a.page3.srcd905"
            CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,'',g_srcc3_d[l_ac].srcd905) 
            IF NOT cl_null(g_srcc3_d[l_ac].srcd905) AND (cl_null(g_srcc3_d_t.srcd905) OR g_srcc3_d[l_ac].srcd905 != g_srcc3_d_t.srcd905) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_srcc3_d[l_ac].srcd905) THEN
                  LET g_srcc3_d[l_ac].srcd905 = g_srcc3_d_t.srcd905
                  CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,'',g_srcc3_d[l_ac].srcd905)
                  NEXT FIELD srcd905
               END IF               
            END IF          
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd905
            #add-point:BEFORE FIELD srcd905 name="input.b.page3.srcd905"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd905
            #add-point:ON CHANGE srcd905 name="input.g.page3.srcd905"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD srcd906
            #add-point:BEFORE FIELD srcd906 name="input.b.page3.srcd906"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD srcd906
            
            #add-point:AFTER FIELD srcd906 name="input.a.page3.srcd906"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE srcd906
            #add-point:ON CHANGE srcd906 name="input.g.page3.srcd906"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page3.srcdseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcdseq
            #add-point:ON ACTION controlp INFIELD srcdseq name="input.c.page3.srcdseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd008
            #add-point:ON ACTION controlp INFIELD srcd008 name="input.c.page3.srcd008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd009
            #add-point:ON ACTION controlp INFIELD srcd009 name="input.c.page3.srcd009"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srcc3_d[l_ac].srcd009             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "223" #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc3_d[l_ac].srcd009 = g_qryparam.return1  
            DISPLAY g_srcc3_d[l_ac].srcd009 TO srcd009           
            NEXT FIELD srcd009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd010
            #add-point:ON ACTION controlp INFIELD srcd010 name="input.c.page3.srcd010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd011
            #add-point:ON ACTION controlp INFIELD srcd011 name="input.c.page3.srcd011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd012
            #add-point:ON ACTION controlp INFIELD srcd012 name="input.c.page3.srcd012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd013
            #add-point:ON ACTION controlp INFIELD srcd013 name="input.c.page3.srcd013"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd014
            #add-point:ON ACTION controlp INFIELD srcd014 name="input.c.page3.srcd014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd901
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd901
            #add-point:ON ACTION controlp INFIELD srcd901 name="input.c.page3.srcd901"
            
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd905
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd905
            #add-point:ON ACTION controlp INFIELD srcd905 name="input.c.page3.srcd905"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srcc3_d[l_ac].srcd905             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_acc #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc3_d[l_ac].srcd905 = g_qryparam.return1  
            DISPLAY g_srcc3_d[l_ac].srcd905 TO srcd905            
            NEXT FIELD srcd905                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page3.srcd906
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD srcd906
            #add-point:ON ACTION controlp INFIELD srcd906 name="input.c.page3.srcd906"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page3_after_row name="input.body3.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_srcc3_d[l_ac].* = g_srcc3_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asrt801_bcl2
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL asrt801_unlock_b("srcd_t","'3'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page3_after_row2 name="input.body3.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body3.after_input"
            
            #end add-point  
 
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_srcc3_d[li_reproduce_target].* = g_srcc3_d[li_reproduce].*
 
               LET g_srcc3_d[li_reproduce_target].srcdseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_srcc3_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_srcc3_d.getLength()+1
            END IF
        
      END INPUT
 
 
 
 
{</section>}
 
{<section id="asrt801.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      INPUT ARRAY g_srcc4_d FROM s_detail4.*
         ATTRIBUTE(COUNT = g_rec_b4,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_srcc4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' AND g_rec_b4 != 0 THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx4)
            END IF
            LET g_loc = 'd'
            LET g_rec_b4 = g_srcc4_d.getLength()
            
         BEFORE INSERT
            
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_srcc4_d[l_ac].* TO NULL 
            LET g_srcc4_d[l_ac].l_srcd008 = "2"
            LET g_srcc4_d[l_ac].l_srcd010 = "1"
            LET g_srcc4_d[l_ac].l_srcd014 = "Y"
            LET g_srcc4_d[l_ac].l_srcd901 = "3"
            LET g_srcc4_d[l_ac].l_srcd902 = cl_get_today()
            INITIALIZE g_srcc4_d_t.* TO NULL 
            INITIALIZE g_srcc4_d_o.* TO NULL 
            LET g_srcc4_d_t.* = g_srcc4_d[l_ac].*     #新輸入資料
            LET g_srcc4_d_o.* = g_srcc4_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt801_set_entry_b(l_cmd)
            CALL asrt801_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_srcc4_d[li_reproduce_target].* = g_srcc4_d[li_reproduce].* 
               LET g_srcc4_d[li_reproduce_target].l_srcdseq = NULL
            END IF
            
            SELECT MAX(srcdseq)+1 INTO g_srcc4_d[l_ac].l_srcdseq FROM srcd_t
             WHERE srcdent = g_enterprise AND srcdsite = g_site AND srcd000 = g_srca_m.srca000
               AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004
               AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900
               AND srcd007 = g_srcc_d[g_detail_idx].srcc007
            IF cl_null(g_srcc4_d[l_ac].l_srcdseq) THEN
               LET g_srcc4_d[l_ac].l_srcdseq = 1
            END IF
            
         BEFORE ROW 
            CALL cl_set_comp_entry("l_srcd011,l_srcd012",TRUE)
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx4 = l_ac
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
            OPEN asrt801_bcl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001, 
                g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900, 
                g_srcc_d[g_detail_idx].srcc007
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asrt801_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CLOSE asrt801_cl
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            
            LET g_rec_b4 = g_srcc4_d.getLength()
            
            IF g_rec_b4 >= l_ac 
               AND g_srcc4_d[l_ac].l_srcdseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_srcc4_d_t.* = g_srcc4_d[l_ac].*  #BACKUP
               LET g_srcc4_d_o.* = g_srcc4_d[l_ac].*  #BACKUP
               CALL asrt801_set_entry_b(l_cmd)  
               CALL asrt801_set_no_entry_b(l_cmd)
               IF NOT asrt801_lock_b("l_srcd_t","'4'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asrt801_bcl4 INTO g_srcc4_d[l_ac].l_srcdseq,g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009, 
                      g_srcc4_d[l_ac].l_srcd010,g_srcc4_d[l_ac].l_srcd011,g_srcc4_d[l_ac].l_srcd012,g_srcc4_d[l_ac].l_srcd013, 
                      g_srcc4_d[l_ac].l_srcd014,g_srcc4_d[l_ac].l_srcd901,g_srcc4_d[l_ac].l_srcd902,g_srcc4_d[l_ac].l_srcd905,g_srcc4_d[l_ac].l_srcd906 

                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = '' 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  LET g_bfill = "N"
                  CALL asrt801_show()
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
               
               IF g_srcc4_d[l_ac].l_srcd901 = '4' THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = g_srcc4_d[l_ac].l_srcd009
                  LET g_errparam.code   = 'aec-00037' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err() 
                  CANCEL DELETE
               END IF
               
               IF NOT asrt801_srcd_delete(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[l_ac].l_srcdseq) THEN
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE
               END IF               
               CALL s_transaction_end('Y','0')              
            END IF 
            
         AFTER DELETE 
            #如果是最後一筆
            IF l_ac = (g_srcc4_d.getLength() + 1) THEN
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
            SELECT COUNT(*) INTO l_count FROM srcd_t 
             WHERE srcdent = g_enterprise AND srcdsite = g_srca_m.srcasite AND srcd000 = g_srca_m.srca000  
                 AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004  
                 AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900  
                 AND srcd007 = g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc4_d[g_detail_idx4].l_srcdseq 

                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN            
               INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys[10] = g_srcc4_d[g_detail_idx4].l_srcdseq
               CALL asrt801_insert_b('srcd_t',gs_keys,"'4'")
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               INITIALIZE g_srcc_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "srcd_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               IF NOT asrt801_upd_srcd_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[l_ac].l_srcdseq,g_srca_m.srca900) THEN 
                  LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
               CALL s_transaction_end('Y','0')
               LET g_rec_b4 = g_rec_b4 + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
               CLOSE asrt801_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
            ELSE
               IF g_srcc4_d[l_ac].l_srcd901 = '1' THEN
                  LET g_srcc4_d[l_ac].l_srcd901 = '2'
               END IF
               LET g_srcc4_d[l_ac].l_srcd902 = cl_get_today()
               
               UPDATE srcd_t SET (srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd007,srcd900, 
                   srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd905,srcd906) = (g_srca_m.srcasite, 
                   g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005, 
                   g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[l_ac].l_srcdseq, 
                   g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009,g_srcc4_d[l_ac].l_srcd010,g_srcc4_d[l_ac].l_srcd011, 
                   g_srcc4_d[l_ac].l_srcd012,g_srcc4_d[l_ac].l_srcd013,g_srcc4_d[l_ac].l_srcd014,g_srcc4_d[l_ac].l_srcd901, 
                   g_srcc4_d[l_ac].l_srcd905,g_srcc4_d[l_ac].l_srcd906) #自訂欄位頁簽
                WHERE srcdent = g_enterprise AND srcdsite = g_srcasite_t AND srcd000 = g_srca000_t AND  
                    srcd001 = g_srca001_t AND srcd002 = g_srca002_t AND srcd004 = g_srca004_t AND srcd005  
                    = g_srca005_t AND srcd006 = g_srca006_t AND srcd900 = g_srca900_t AND srcd007 =  
                    g_srcc_d[g_detail_idx].srcc007 AND srcdseq = g_srcc4_d_t.l_srcdseq AND srcd008 = '2'  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcd_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "srcd_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_srca_m.srcasite
               LET gs_keys_bak[1] = g_srcasite_t
               LET gs_keys[2] = g_srca_m.srca000
               LET gs_keys_bak[2] = g_srca000_t
               LET gs_keys[3] = g_srca_m.srca001
               LET gs_keys_bak[3] = g_srca001_t
               LET gs_keys[4] = g_srca_m.srca002
               LET gs_keys_bak[4] = g_srca002_t
               LET gs_keys[5] = g_srca_m.srca004
               LET gs_keys_bak[5] = g_srca004_t
               LET gs_keys[6] = g_srca_m.srca005
               LET gs_keys_bak[6] = g_srca005_t
               LET gs_keys[7] = g_srca_m.srca006
               LET gs_keys_bak[7] = g_srca006_t
               LET gs_keys[8] = g_srca_m.srca900
               LET gs_keys_bak[8] = g_srca900_t
               LET gs_keys[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys_bak[9] = g_srcc_d[g_detail_idx].srcc007
               LET gs_keys[10] = g_srcc4_d[g_detail_idx4].l_srcdseq
               LET gs_keys_bak[10] = g_srcc4_d_t.l_srcdseq
               CALL asrt801_update_b('srcd_t',gs_keys,gs_keys_bak,"'4'")
                     #資料多語言用-增/改
                     
               END CASE
               
               #修改歷程記錄
               LET g_log1 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc4_d_t)
               LET g_log2 = util.JSON.stringify(g_srca_m),util.JSON.stringify(g_srcc4_d[l_ac])
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               IF NOT asrt801_upd_srcd_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[l_ac].l_srcdseq,g_srca_m.srca900) THEN 
                  LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
                  CALL s_transaction_end('N','0')
               END IF
            END IF
 
         AFTER FIELD l_srcd009
            
            #add-point:AFTER FIELD l_srcd009
            CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009,'')
            IF  g_srca_m.srcasite IS NOT NULL AND g_srca_m.srca000 IS NOT NULL AND g_srca_m.srca001 IS NOT NULL AND g_srca_m.srca002 IS NOT NULL AND g_srca_m.srca004 IS NOT NULL AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND g_srca_m.srca900 IS NOT NULL AND g_srcc_d[g_detail_idx].srcc007 IS NOT NULL AND NOT cl_null(g_srcc4_d[l_ac].l_srcd009) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_srcc4_d[l_ac].l_srcd009 != g_srcc4_d_t.l_srcd009))) THEN 
                  IF NOT ap_chk_notDup(g_srcc4_d[l_ac].l_srcd009,"SELECT COUNT(*) FROM srcd_t WHERE "||"srcdent = '" ||g_enterprise|| "' AND srcdsite = '" ||g_site|| "' AND "||"srcd000 = '"||g_srca_m.srca000||"' AND "|| "srcd001 = '"||g_srca_m.srca001 ||"' AND "|| "srcd002 = '"||g_srca_m.srca002 ||"' AND "|| "srcd004 = '"||g_srca_m.srca004 ||"' AND "|| "srcd005 = '"||g_srca_m.srca005||"' AND "|| "srcd006 = '"||g_srca_m.srca006||"' AND "|| "srcd900 = "||g_srca_m.srca900||" AND "|| "srcd007 = "||g_srcc_d[g_detail_idx].srcc007||" AND "|| "srcd008 = '"||g_srcc4_d[l_ac].l_srcd008||"' AND "|| "srcd009 = '"||g_srcc4_d[l_ac].l_srcd009||"'",'aec-00028',1) THEN 
                     LET g_srcc4_d[l_ac].l_srcd009 =  g_srcc4_d_t.l_srcd009
                     CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009,'')                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF NOT cl_null(g_srcc4_d[l_ac].l_srcd009) THEN
               IF NOT s_azzi650_chk_exist('223',g_srcc4_d[l_ac].l_srcd009) THEN
                  LET g_srcc4_d[l_ac].l_srcd009 =  g_srcc4_d_t.l_srcd009
                  CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009,'')                     
                  NEXT FIELD CURRENT
               END IF
            END IF
            
         ON CHANGE l_srcd010
            #add-point:ON CHANGE l_srcd010
            IF g_srcc4_d[l_ac].l_srcd010 = '1' THEN
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",FALSE)
            END IF   
         
         BEFORE FIELD l_srcd011
            #add-point:BEFORE FIELD l_srcd011
            IF g_srcc4_d[l_ac].l_srcd010 = '1' THEN
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",FALSE)
            END IF

         AFTER FIELD l_srcd011
            IF NOT cl_null(g_srcc4_d[l_ac].l_srcd011) AND NOT cl_null(g_srcc4_d[l_ac].l_srcd012) THEN
               IF g_srcc4_d[l_ac].l_srcd012 < g_srcc4_d[l_ac].l_srcd011 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_srcc4_d[l_ac].l_srcd011
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_srcc4_d[l_ac].l_srcd011 = g_srcc4_d_t.l_srcd011
                  NEXT FIELD l_srcd011
               END IF
            END IF
            
         BEFORE FIELD l_srcd012
            #add-point:BEFORE FIELD l_srcd012
            IF g_srcc4_d[l_ac].l_srcd010 = '1' THEN
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",TRUE)
            ELSE
               CALL cl_set_comp_entry("l_srcd011,l_srcd012",FALSE)
            END IF
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_srcd012
            
            #add-point:AFTER FIELD l_srcd012
            IF NOT cl_null(g_srcc4_d[l_ac].l_srcd011) AND NOT cl_null(g_srcc4_d[l_ac].l_srcd012) THEN
               IF g_srcc4_d[l_ac].l_srcd012 < g_srcc4_d[l_ac].l_srcd011 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aim-00142'
                  LET g_errparam.extend = g_srcc4_d[l_ac].l_srcd012
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_srcc4_d[l_ac].l_srcd012 = g_srcc4_d_t.l_srcd012
                  NEXT FIELD l_srcd012
               END IF
            END IF
 
         AFTER FIELD l_srcd013
            
            #add-point:AFTER FIELD l_srcd013
            IF NOT cl_null(g_srcc4_d[l_ac].l_srcd013) AND (cl_null(g_srcc4_d_t.l_srcd013) OR g_srcc4_d[l_ac].l_srcd013 != g_srcc4_d_t.l_srcd013) THEN
               IF g_srcc4_d[l_ac].l_srcd010 = '1' THEN
                  LET l_srcd013_str = g_srcc4_d[l_ac].l_srcd013
                  LET l_srcd013_n1 = l_srcd013_str.getIndexOf(".",2)
                  IF l_srcd013_n1 > 0 THEN
                     LET l_srcd013_str1 = l_srcd013_str.substring(1,l_srcd013_n1-1)
                     LET l_srcd013_str2 = l_srcd013_str.substring(l_srcd013_n1+1,l_srcd013_str.getLength())
                     CALL s_chr_alphanumeric(l_srcd013_str1,1) RETURNING l_result
                     IF l_result THEN
                        CALL s_chr_alphanumeric(l_srcd013_str2,1) RETURNING l_result 
                     END IF
                  ELSE
                     CALL s_chr_alphanumeric(g_srcc4_d[l_ac].l_srcd013,1) RETURNING l_result
                  END IF
                  IF NOT l_result THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00013'
                     LET g_errparam.extend = g_srcc4_d[l_ac].l_srcd013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_srcc4_d[l_ac].l_srcd013 = g_srcc4_d_t.l_srcd013
                     NEXT FIELD l_srcd013
                  END IF
                  LET l_srcd013_num = g_srcc4_d[l_ac].l_srcd013
                  IF l_srcd013_num > g_srcc4_d[l_ac].l_srcd012 OR l_srcd013_num < g_srcc4_d[l_ac].l_srcd011 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aec-00015'
                     LET g_errparam.extend = g_srcc4_d[l_ac].l_srcd013
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_srcc4_d[l_ac].l_srcd013 = g_srcc4_d_t.l_srcd013
                     NEXT FIELD l_srcd013
                  END IF
               END IF
            END IF
            
         AFTER FIELD l_srcd905           
            #add-point:AFTER FIELD l_srcd905
            CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,'',g_srcc4_d[l_ac].l_srcd905) 
            IF NOT cl_null(g_srcc4_d[l_ac].l_srcd905) AND (cl_null(g_srcc4_d_t.l_srcd905) OR g_srcc4_d[l_ac].l_srcd905 != g_srcc4_d_t.l_srcd905) THEN
               IF NOT s_azzi650_chk_exist(g_acc,g_srcc4_d[l_ac].l_srcd905) THEN
                  LET g_srcc4_d[l_ac].l_srcd905 = g_srcc4_d_t.l_srcd905
                  CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,'',g_srcc4_d[l_ac].l_srcd905)
                  NEXT FIELD l_srcd905
               END IF               
            END IF   
            
         ON ACTION controlp INFIELD l_srcd009
            #add-point:ON ACTION controlp INFIELD l_srcd009
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srcc4_d[l_ac].l_srcd009             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "223" #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc4_d[l_ac].l_srcd009 = g_qryparam.return1  
            DISPLAY g_srcc4_d[l_ac].l_srcd009 TO l_srcd009           
            NEXT FIELD l_srcd009                          #返回原欄位
            
         ON ACTION controlp INFIELD l_srcd905
            #add-point:ON ACTION controlp INFIELD l_srcd905
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_srcc4_d[l_ac].l_srcd905             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_acc #s
            CALL q_oocq002()                                #呼叫開窗
            LET g_srcc4_d[l_ac].l_srcd905 = g_qryparam.return1  
            DISPLAY g_srcc4_d[l_ac].l_srcd905 TO l_srcd905            
            NEXT FIELD l_srcd905                          #返回原欄位
         
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
                  LET g_srcc4_d[l_ac].* = g_srcc4_d_t.*
               END IF
               CLOSE asrt801_bcl2
               CLOSE asrt801_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF            
            CALL asrt801_unlock_b("srcd_t","'4'")
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
  
 
         ON ACTION controlo    
            CALL FGL_SET_ARR_CURR(g_srcc4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_srcc4_d.getLength()+1
 
      END INPUT
    
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
         CALL DIALOG.setCurrentRow("s_detail3",g_detail_idx2)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD srca001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD srcc007
               WHEN "s_detail2"
                  NEXT FIELD srcc007_2
               WHEN "s_detail3"
                  NEXT FIELD srcd009
 
               #add-point:input段modify_detail 
               WHEN "s_detail4"
                   NEXT FIELD l_srcd009
               #end add-point  
            END CASE
         END IF
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1','2',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'3',"))
         CALL DIALOG.setCurrentRow("s_detail3",g_idx_group.getValue(""))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD srcasite
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD srcc007
               WHEN "s_detail2"
                  NEXT FIELD srcc007_2
               WHEN "s_detail3"
                  NEXT FIELD srcdseq
 
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
   CALL gfrm_curr.ensureFieldVisible("srcc030")
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asrt801_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asrt801_b_fill() #單身填充
      CALL asrt801_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asrt801_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_srca_m_mask_o.* =  g_srca_m.*
   CALL asrt801_srca_t_mask()
   LET g_srca_m_mask_n.* =  g_srca_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca001_desc,g_srca_m.srca004, 
       g_srca_m.srca004_desc,g_srca_m.srca004_desc_1,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca006_desc, 
       g_srca_m.srca002,g_srca_m.srca002_desc,g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca905_desc, 
       g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp, 
       g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp,g_srca_m.srcacrtdp_desc, 
       g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamodid_desc,g_srca_m.srcamoddt,g_srca_m.srcacnfid, 
       g_srca_m.srcacnfid_desc,g_srca_m.srcacnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srca_m.srcastus 
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
   FOR l_ac = 1 TO g_srcc_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_srcc2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_srcc3_d.getLength()
      #add-point:show段單身reference name="show.body3.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asrt801_detail_show()
 
   #add-point:show段之後 name="show.after"
   IF g_detail_idx > 0 THEN
      IF NOT cl_null(g_srcc_d[g_detail_idx].srcc007) THEN 
         CALL s_asrt801_hint_show('srcc_t','srac_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,0,g_srca_m.srca900)
      END IF
      IF g_detail_idx2 > 0 THEN
         IF NOT cl_null(g_srcc3_d[g_detail_idx2].srcdseq) THEN 
            CALL s_asrt801_hint_show('srcd_t','srad_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc3_d[g_detail_idx2].srcdseq,g_srca_m.srca900)
         END IF
      END IF
      IF g_detail_idx4 > 0 THEN
         IF NOT cl_null(g_srcc4_d[g_detail_idx4].l_srcdseq) THEN 
            CALL s_asrt801_hint_show('sracd_t','srad_t',g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srcc_d[g_detail_idx].srcc007,g_srcc4_d[g_detail_idx4].l_srcdseq,g_srca_m.srca900)
         END IF
      END IF
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asrt801_detail_show()
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
 
{<section id="asrt801.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asrt801_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE srca_t.srcasite 
   DEFINE l_oldno     LIKE srca_t.srcasite 
   DEFINE l_newno02     LIKE srca_t.srca000 
   DEFINE l_oldno02     LIKE srca_t.srca000 
   DEFINE l_newno03     LIKE srca_t.srca001 
   DEFINE l_oldno03     LIKE srca_t.srca001 
   DEFINE l_newno04     LIKE srca_t.srca002 
   DEFINE l_oldno04     LIKE srca_t.srca002 
   DEFINE l_newno05     LIKE srca_t.srca004 
   DEFINE l_oldno05     LIKE srca_t.srca004 
   DEFINE l_newno06     LIKE srca_t.srca005 
   DEFINE l_oldno06     LIKE srca_t.srca005 
   DEFINE l_newno07     LIKE srca_t.srca006 
   DEFINE l_oldno07     LIKE srca_t.srca006 
   DEFINE l_newno08     LIKE srca_t.srca900 
   DEFINE l_oldno08     LIKE srca_t.srca900 
 
   DEFINE l_master    RECORD LIKE srca_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE srcc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE srcd_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_srca_m.srcasite IS NULL
   OR g_srca_m.srca000 IS NULL
   OR g_srca_m.srca001 IS NULL
   OR g_srca_m.srca002 IS NULL
   OR g_srca_m.srca004 IS NULL
   OR g_srca_m.srca005 IS NULL
   OR g_srca_m.srca006 IS NULL
   OR g_srca_m.srca900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_srcasite_t = g_srca_m.srcasite
   LET g_srca000_t = g_srca_m.srca000
   LET g_srca001_t = g_srca_m.srca001
   LET g_srca002_t = g_srca_m.srca002
   LET g_srca004_t = g_srca_m.srca004
   LET g_srca005_t = g_srca_m.srca005
   LET g_srca006_t = g_srca_m.srca006
   LET g_srca900_t = g_srca_m.srca900
 
    
   LET g_srca_m.srcasite = ""
   LET g_srca_m.srca000 = ""
   LET g_srca_m.srca001 = ""
   LET g_srca_m.srca002 = ""
   LET g_srca_m.srca004 = ""
   LET g_srca_m.srca005 = ""
   LET g_srca_m.srca006 = ""
   LET g_srca_m.srca900 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_srca_m.srcaownid = g_user
      LET g_srca_m.srcaowndp = g_dept
      LET g_srca_m.srcacrtid = g_user
      LET g_srca_m.srcacrtdp = g_dept 
      LET g_srca_m.srcacrtdt = cl_get_current()
      LET g_srca_m.srcamodid = g_user
      LET g_srca_m.srcamoddt = cl_get_current()
      LET g_srca_m.srcastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_srca_m.srcastus 
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
      LET g_srca_m.srca001_desc = ''
   DISPLAY BY NAME g_srca_m.srca001_desc
   LET g_srca_m.srca004_desc = ''
   DISPLAY BY NAME g_srca_m.srca004_desc
   LET g_srca_m.srca004_desc_1 = ''
   DISPLAY BY NAME g_srca_m.srca004_desc_1
   LET g_srca_m.srca006_desc = ''
   DISPLAY BY NAME g_srca_m.srca006_desc
   LET g_srca_m.srca002_desc = ''
   DISPLAY BY NAME g_srca_m.srca002_desc
 
   
   CALL asrt801_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_srca_m.* TO NULL
      INITIALIZE g_srcc_d TO NULL
      INITIALIZE g_srcc2_d TO NULL
      INITIALIZE g_srcc3_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asrt801_show()
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
   CALL asrt801_set_act_visible()   
   CALL asrt801_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_srcasite_t = g_srca_m.srcasite
   LET g_srca000_t = g_srca_m.srca000
   LET g_srca001_t = g_srca_m.srca001
   LET g_srca002_t = g_srca_m.srca002
   LET g_srca004_t = g_srca_m.srca004
   LET g_srca005_t = g_srca_m.srca005
   LET g_srca006_t = g_srca_m.srca006
   LET g_srca900_t = g_srca_m.srca900
 
   
   #組合新增資料的條件
   LET g_add_browse = " srcaent = " ||g_enterprise|| " AND",
                      " srcasite = '", g_srca_m.srcasite, "' "
                      ," AND srca000 = '", g_srca_m.srca000, "' "
                      ," AND srca001 = '", g_srca_m.srca001, "' "
                      ," AND srca002 = '", g_srca_m.srca002, "' "
                      ," AND srca004 = '", g_srca_m.srca004, "' "
                      ," AND srca005 = '", g_srca_m.srca005, "' "
                      ," AND srca006 = '", g_srca_m.srca006, "' "
                      ," AND srca900 = '", g_srca_m.srca900, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asrt801_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL asrt801_idx_chk()
   
   LET g_data_owner = g_srca_m.srcaownid      
   LET g_data_dept  = g_srca_m.srcaowndp
   
   #功能已完成,通報訊息中心
   CALL asrt801_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asrt801_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE srcc_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE srcd_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asrt801_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM srcc_t
    WHERE srccent = g_enterprise AND srccsite = g_srcasite_t
     AND srcc000 = g_srca000_t
     AND srcc001 = g_srca001_t
     AND srcc002 = g_srca002_t
     AND srcc004 = g_srca004_t
     AND srcc005 = g_srca005_t
     AND srcc006 = g_srca006_t
     AND srcc900 = g_srca900_t
 
    INTO TEMP asrt801_detail
 
   #將key修正為調整後   
   UPDATE asrt801_detail 
      #更新key欄位
      SET srccsite = g_srca_m.srcasite
          , srcc000 = g_srca_m.srca000
          , srcc001 = g_srca_m.srca001
          , srcc002 = g_srca_m.srca002
          , srcc004 = g_srca_m.srca004
          , srcc005 = g_srca_m.srca005
          , srcc006 = g_srca_m.srca006
          , srcc900 = g_srca_m.srca900
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO srcc_t SELECT * FROM asrt801_detail
   
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
   DROP TABLE asrt801_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM srcd_t 
    WHERE srcdent = g_enterprise AND srcdsite = g_srcasite_t
    AND srcd000 = g_srca000_t   
    AND srcd001 = g_srca001_t   
    AND srcd002 = g_srca002_t   
    AND srcd004 = g_srca004_t   
    AND srcd005 = g_srca005_t   
    AND srcd006 = g_srca006_t   
    AND srcd900 = g_srca900_t   
 
    INTO TEMP asrt801_detail
 
   #將key修正為調整後   
   UPDATE asrt801_detail SET srcdsite = g_srca_m.srcasite
                                       , srcd000 = g_srca_m.srca000
                                       , srcd001 = g_srca_m.srca001
                                       , srcd002 = g_srca_m.srca002
                                       , srcd004 = g_srca_m.srca004
                                       , srcd005 = g_srca_m.srca005
                                       , srcd006 = g_srca_m.srca006
                                       , srcd900 = g_srca_m.srca900
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO srcd_t SELECT * FROM asrt801_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asrt801_detail
   
   LET g_data_owner = g_srca_m.srcaownid      
   LET g_data_dept  = g_srca_m.srcaowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_srcasite_t = g_srca_m.srcasite
   LET g_srca000_t = g_srca_m.srca000
   LET g_srca001_t = g_srca_m.srca001
   LET g_srca002_t = g_srca_m.srca002
   LET g_srca004_t = g_srca_m.srca004
   LET g_srca005_t = g_srca_m.srca005
   LET g_srca006_t = g_srca_m.srca006
   LET g_srca900_t = g_srca_m.srca900
 
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asrt801_delete()
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
   
   IF g_srca_m.srcasite IS NULL
   OR g_srca_m.srca000 IS NULL
   OR g_srca_m.srca001 IS NULL
   OR g_srca_m.srca002 IS NULL
   OR g_srca_m.srca004 IS NULL
   OR g_srca_m.srca005 IS NULL
   OR g_srca_m.srca006 IS NULL
   OR g_srca_m.srca900 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt801_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asrt801_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT asrt801_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_srca_m_mask_o.* =  g_srca_m.*
   CALL asrt801_srca_t_mask()
   LET g_srca_m_mask_n.* =  g_srca_m.*
   
   CALL asrt801_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asrt801_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_srcasite_t = g_srca_m.srcasite
      LET g_srca000_t = g_srca_m.srca000
      LET g_srca001_t = g_srca_m.srca001
      LET g_srca002_t = g_srca_m.srca002
      LET g_srca004_t = g_srca_m.srca004
      LET g_srca005_t = g_srca_m.srca005
      LET g_srca006_t = g_srca_m.srca006
      LET g_srca900_t = g_srca_m.srca900
 
 
      DELETE FROM srca_t
       WHERE srcaent = g_enterprise AND srcasite = g_srca_m.srcasite
         AND srca000 = g_srca_m.srca000
         AND srca001 = g_srca_m.srca001
         AND srca002 = g_srca_m.srca002
         AND srca004 = g_srca_m.srca004
         AND srca005 = g_srca_m.srca005
         AND srca006 = g_srca_m.srca006
         AND srca900 = g_srca_m.srca900
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_srca_m.srcasite,":",SQLERRMESSAGE  
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
      
      DELETE FROM srcc_t
       WHERE srccent = g_enterprise AND srccsite = g_srca_m.srcasite
         AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001
         AND srcc002 = g_srca_m.srca002
         AND srcc004 = g_srca_m.srca004
         AND srcc005 = g_srca_m.srca005
         AND srcc006 = g_srca_m.srca006
         AND srcc900 = g_srca_m.srca900
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
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
      DELETE FROM srcd_t
       WHERE srcdent = g_enterprise AND
             srcdsite = g_srca_m.srcasite AND srcd000 = g_srca_m.srca000 AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002 AND srcd004 = g_srca_m.srca004 AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900
      #add-point:單身刪除中 name="delete.body.m_delete2"
      DELETE FROM srcd_t
       WHERE srcdent = g_enterprise AND srcdsite = g_srca_m.srcasite AND srcd000 = g_srca_m.srca000 
         AND srcd001 = g_srca_m.srca001 AND srcd002 = g_srca_m.srca002
         AND srcd004 = g_srca_m.srca004 AND srcd005 = g_srca_m.srca005 AND srcd006 = g_srca_m.srca006 AND srcd900 = g_srca_m.srca900
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      DELETE FROM srce_t
       WHERE srceent = g_enterprise AND srcesite = g_srca_m.srcasite AND srce000 = g_srca_m.srca000 
         AND srce001 = g_srca_m.srca001 AND srce002 = g_srca_m.srca002
         AND srce004 = g_srca_m.srca004 AND srce005 = g_srca_m.srca005 AND srce006 = g_srca_m.srca006 AND srce900 = g_srca_m.srca900
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF     

      DELETE FROM srcf_t
       WHERE srcfent = g_enterprise AND srcfsite = g_srca_m.srcasite AND srcf000 = g_srca_m.srca000 
         AND srcf001 = g_srca_m.srca001 AND srcf002 = g_srca_m.srca002
         AND srcf003 = g_srca_m.srca004 AND srcf004 = g_srca_m.srca005 AND srcf005 = g_srca_m.srca006 AND srcf007= g_srca_m.srca900
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN
      END IF   
      
      CALL g_srcc4_d.clear()      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_srca_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asrt801_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_srcc_d.clear() 
      CALL g_srcc2_d.clear()       
      CALL g_srcc3_d.clear()       
 
     
      CALL asrt801_ui_browser_refresh()  
      #CALL asrt801_ui_headershow()  
      #CALL asrt801_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asrt801_browser_fill("")
         CALL asrt801_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asrt801_cl
 
   #功能已完成,通報訊息中心
   CALL asrt801_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asrt801.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asrt801_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_srcc_d.clear()
   CALL g_srcc2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_srcc4_d.clear()
   #end add-point
   
   #判斷是否填充
   IF asrt801_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014, 
             srcc015,srcc016,srcc017,srcc018,srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023, 
             srcc024,srcc025,srcc026,srcc046,srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902, 
             srcc905,srcc906,srcc007,srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc038,srcc039, 
             srcc040,srcc041,srcc042,srcc043,srcc044,srcc045 ,t1.oocql004 ,t2.oocql004 ,t3.oocql004 , 
             t4.ecaa002 ,t5.pmaal004 ,t6.oocal003 ,t7.oocal003 ,t8.oocql004 ,t10.ecaa002 FROM srcc_t", 
                
                     " INNER JOIN srca_t ON srcaent = " ||g_enterprise|| " AND srcasite = srccsite ",
                     " AND srca000 = srcc000 ",
                     " AND srca001 = srcc001 ",
                     " AND srca002 = srcc002 ",
                     " AND srca004 = srcc004 ",
                     " AND srca005 = srcc005 ",
                     " AND srca006 = srcc006 ",
                     " AND srca900 = srcc900 ",
 
                     #"",
                     " LEFT JOIN srcd_t ON srccent = srcdent AND srccsite = srcdsite AND srccsite = srcdsite AND srcc000 = srcd000 AND srcc001 = srcd001 AND srcc002 = srcd002 AND srcc004 = srcd004 AND srcc005 = srcd005 AND srcc006 = srcd006 AND srcc900 = srcd900 AND srcc007 = srcd007 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='221' AND t1.oocql002=srcc008 AND t1.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='221' AND t2.oocql002=srcc012 AND t2.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='221' AND t3.oocql002=srcc014 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t4 ON t4.ecaaent="||g_enterprise||" AND t4.ecaasite=srccsite AND t4.ecaa001=srcc016  ",
               " LEFT JOIN pmaal_t t5 ON t5.pmaalent="||g_enterprise||" AND t5.pmaal001=srcc037 AND t5.pmaal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t6 ON t6.oocalent="||g_enterprise||" AND t6.oocal001=srcc046 AND t6.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t7 ON t7.oocalent="||g_enterprise||" AND t7.oocal001=srcc027 AND t7.oocal002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t8 ON t8.oocqlent="||g_enterprise||" AND t8.oocql001='215' AND t8.oocql002=srcc905 AND t8.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t10 ON t10.ecaaent="||g_enterprise||" AND t10.ecaasite=srccsite AND t10.ecaa001=srcc016  ",
 
                     " WHERE srccent=? AND srccsite=? AND srcc000=? AND srcc001=? AND srcc002=? AND srcc004=? AND srcc005=? AND srcc006=? AND srcc900=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         IF g_flag_hidden = 'Y' THEN
            LET g_sql = g_sql," AND srcc901 != '4' "
         END IF
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
            IF NOT cl_null(g_wc2_table2) THEN 
      LET g_sql = g_sql CLIPPED," AND ", g_wc2_table2 CLIPPED
   END IF 
 
         
         LET g_sql = g_sql, " ORDER BY srcc_t.srcc007"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt801_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asrt801_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
          g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srcc_d[l_ac].srcc007, 
          g_srcc_d[l_ac].srcc008,g_srcc_d[l_ac].srcc009,g_srcc_d[l_ac].srcc010,g_srcc_d[l_ac].srcc011, 
          g_srcc_d[l_ac].srcc012,g_srcc_d[l_ac].srcc013,g_srcc_d[l_ac].srcc014,g_srcc_d[l_ac].srcc015, 
          g_srcc_d[l_ac].srcc016,g_srcc_d[l_ac].srcc017,g_srcc_d[l_ac].srcc018,g_srcc_d[l_ac].srcc019, 
          g_srcc_d[l_ac].srcc020,g_srcc_d[l_ac].srcc036,g_srcc_d[l_ac].srcc037,g_srcc_d[l_ac].srcc021, 
          g_srcc_d[l_ac].srcc022,g_srcc_d[l_ac].srcc023,g_srcc_d[l_ac].srcc024,g_srcc_d[l_ac].srcc025, 
          g_srcc_d[l_ac].srcc026,g_srcc_d[l_ac].srcc046,g_srcc_d[l_ac].srcc047,g_srcc_d[l_ac].srcc048, 
          g_srcc_d[l_ac].srcc027,g_srcc_d[l_ac].srcc028,g_srcc_d[l_ac].srcc029,g_srcc_d[l_ac].srcc901, 
          g_srcc_d[l_ac].srcc902,g_srcc_d[l_ac].srcc905,g_srcc_d[l_ac].srcc906,g_srcc2_d[l_ac].srcc007, 
          g_srcc2_d[l_ac].srcc030,g_srcc2_d[l_ac].srcc031,g_srcc2_d[l_ac].srcc032,g_srcc2_d[l_ac].srcc033, 
          g_srcc2_d[l_ac].srcc034,g_srcc2_d[l_ac].srcc035,g_srcc2_d[l_ac].srcc038,g_srcc2_d[l_ac].srcc039, 
          g_srcc2_d[l_ac].srcc040,g_srcc2_d[l_ac].srcc041,g_srcc2_d[l_ac].srcc042,g_srcc2_d[l_ac].srcc043, 
          g_srcc2_d[l_ac].srcc044,g_srcc2_d[l_ac].srcc045,g_srcc_d[l_ac].srcc008_desc,g_srcc_d[l_ac].srcc012_desc, 
          g_srcc_d[l_ac].srcc014_desc,g_srcc_d[l_ac].srcc016_desc,g_srcc_d[l_ac].srcc037_desc,g_srcc_d[l_ac].srcc046_desc, 
          g_srcc_d[l_ac].srcc027_desc,g_srcc_d[l_ac].srcc905_desc,g_srcc2_d[l_ac].l_srcc016_2_desc   
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
         LET g_srcc2_d[l_ac].l_srcc008_2 = g_srcc_d[l_ac].srcc008
         LET g_srcc2_d[l_ac].l_srcc009_2 = g_srcc_d[l_ac].srcc009
         LET g_srcc2_d[l_ac].l_srcc016_2 = g_srcc_d[l_ac].srcc016
         LET g_srcc2_d[l_ac].l_srcc008_2_desc = g_srcc_d[l_ac].srcc008_desc
         LET g_srcc2_d[l_ac].l_srcc016_2_desc = g_srcc_d[l_ac].srcc016_desc
         CALL asrt801_srcc_color()
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
   
   CALL g_srcc_d.deleteElement(g_srcc_d.getLength())
   CALL g_srcc2_d.deleteElement(g_srcc2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asrt801_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_srcc_d.getLength()
      LET g_srcc_d_mask_o[l_ac].* =  g_srcc_d[l_ac].*
      CALL asrt801_srcc_t_mask()
      LET g_srcc_d_mask_n[l_ac].* =  g_srcc_d[l_ac].*
   END FOR
   
   LET g_srcc2_d_mask_o.* =  g_srcc2_d.*
   FOR l_ac = 1 TO g_srcc2_d.getLength()
      LET g_srcc2_d_mask_o[l_ac].* =  g_srcc2_d[l_ac].*
      CALL asrt801_srcc_t_mask()
      LET g_srcc2_d_mask_n[l_ac].* =  g_srcc2_d[l_ac].*
   END FOR
   LET g_srcc3_d_mask_o.* =  g_srcc3_d.*
   FOR l_ac = 1 TO g_srcc3_d.getLength()
      LET g_srcc3_d_mask_o[l_ac].* =  g_srcc3_d[l_ac].*
      CALL asrt801_srcd_t_mask()
      LET g_srcc3_d_mask_n[l_ac].* =  g_srcc3_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asrt801_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM srcc_t
       WHERE srccent = g_enterprise AND
         srccsite = ps_keys_bak[1] AND srcc000 = ps_keys_bak[2] AND srcc001 = ps_keys_bak[3] AND srcc002 = ps_keys_bak[4] AND srcc004 = ps_keys_bak[5] AND srcc005 = ps_keys_bak[6] AND srcc006 = ps_keys_bak[7] AND srcc900 = ps_keys_bak[8] AND srcc007 = ps_keys_bak[9]
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
         CALL g_srcc_d.deleteElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_srcc2_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM srcd_t
       WHERE srcdent = g_enterprise AND
             srcdsite = ps_keys_bak[1] AND srcd000 = ps_keys_bak[2] AND srcd001 = ps_keys_bak[3] AND srcd002 = ps_keys_bak[4] AND srcd004 = ps_keys_bak[5] AND srcd005 = ps_keys_bak[6] AND srcd006 = ps_keys_bak[7] AND srcd900 = ps_keys_bak[8] AND srcd007 = ps_keys_bak[9] AND srcdseq = ps_keys_bak[10]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_srcc3_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asrt801_insert_b(ps_table,ps_keys,ps_page)
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
      
      #end add-point 
      INSERT INTO srcc_t
                  (srccent,
                   srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc900,
                   srcc007
                   ,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,srcc046,srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902,srcc905,srcc906,srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040,srcc041,srcc042,srcc043,srcc044,srcc045) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
                   ,g_srcc_d[g_detail_idx].srcc008,g_srcc_d[g_detail_idx].srcc009,g_srcc_d[g_detail_idx].srcc010, 
                       g_srcc_d[g_detail_idx].srcc011,g_srcc_d[g_detail_idx].srcc012,g_srcc_d[g_detail_idx].srcc013, 
                       g_srcc_d[g_detail_idx].srcc014,g_srcc_d[g_detail_idx].srcc015,g_srcc_d[g_detail_idx].srcc016, 
                       g_srcc_d[g_detail_idx].srcc017,g_srcc_d[g_detail_idx].srcc018,g_srcc_d[g_detail_idx].srcc019, 
                       g_srcc_d[g_detail_idx].srcc020,g_srcc_d[g_detail_idx].srcc036,g_srcc_d[g_detail_idx].srcc037, 
                       g_srcc_d[g_detail_idx].srcc021,g_srcc_d[g_detail_idx].srcc022,g_srcc_d[g_detail_idx].srcc023, 
                       g_srcc_d[g_detail_idx].srcc024,g_srcc_d[g_detail_idx].srcc025,g_srcc_d[g_detail_idx].srcc026, 
                       g_srcc_d[g_detail_idx].srcc046,g_srcc_d[g_detail_idx].srcc047,g_srcc_d[g_detail_idx].srcc048, 
                       g_srcc_d[g_detail_idx].srcc027,g_srcc_d[g_detail_idx].srcc028,g_srcc_d[g_detail_idx].srcc029, 
                       g_srcc_d[g_detail_idx].srcc901,g_srcc_d[g_detail_idx].srcc902,g_srcc_d[g_detail_idx].srcc905, 
                       g_srcc_d[g_detail_idx].srcc906,g_srcc2_d[g_detail_idx].srcc030,g_srcc2_d[g_detail_idx].srcc031, 
                       g_srcc2_d[g_detail_idx].srcc032,g_srcc2_d[g_detail_idx].srcc033,g_srcc2_d[g_detail_idx].srcc034, 
                       g_srcc2_d[g_detail_idx].srcc035,g_srcc2_d[g_detail_idx].srcc038,g_srcc2_d[g_detail_idx].srcc039, 
                       g_srcc2_d[g_detail_idx].srcc040,g_srcc2_d[g_detail_idx].srcc041,g_srcc2_d[g_detail_idx].srcc042, 
                       g_srcc2_d[g_detail_idx].srcc043,g_srcc2_d[g_detail_idx].srcc044,g_srcc2_d[g_detail_idx].srcc045) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_srcc_d.insertElement(li_idx) 
      END IF 
      IF ps_page <> "'2'" THEN 
         CALL g_srcc2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      INSERT INTO srcd_t
                  (srcdent,
                   srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007,
                   srcdseq
                   ,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905,srcd906) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
                   ,g_srcc3_d[g_detail_idx2].srcd008,g_srcc3_d[g_detail_idx2].srcd009,g_srcc3_d[g_detail_idx2].srcd010, 
                       g_srcc3_d[g_detail_idx2].srcd011,g_srcc3_d[g_detail_idx2].srcd012,g_srcc3_d[g_detail_idx2].srcd013, 
                       g_srcc3_d[g_detail_idx2].srcd014,g_srcc3_d[g_detail_idx2].srcd901,g_srcc3_d[g_detail_idx2].srcd902, 
                       g_srcc3_d[g_detail_idx2].srcd905,g_srcc3_d[g_detail_idx2].srcd906)
      IF 1 =2 THEN
      #end add-point 
      INSERT INTO srcd_t
                  (srcdent,
                   srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007,
                   srcdseq
                   ,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905,srcd906) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
                   ,g_srcc3_d[g_detail_idx2].srcd008,g_srcc3_d[g_detail_idx2].srcd009,g_srcc3_d[g_detail_idx2].srcd010, 
                       g_srcc3_d[g_detail_idx2].srcd011,g_srcc3_d[g_detail_idx2].srcd012,g_srcc3_d[g_detail_idx2].srcd013, 
                       g_srcc3_d[g_detail_idx2].srcd014,g_srcc3_d[g_detail_idx2].srcd901,g_srcc3_d[g_detail_idx2].srcd902, 
                       g_srcc3_d[g_detail_idx2].srcd905,g_srcc3_d[g_detail_idx2].srcd906)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      END IF
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'3'" THEN 
         CALL g_srcc3_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   LET ls_group = "'4',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      INSERT INTO srcd_t
                  (srcdent,
                   srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007,
                   srcdseq
                   ,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905,srcd906) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
                   ,g_srcc4_d[g_detail_idx4].l_srcd008,g_srcc4_d[g_detail_idx4].l_srcd009,g_srcc4_d[g_detail_idx4].l_srcd010, 
                       g_srcc4_d[g_detail_idx4].l_srcd011,g_srcc4_d[g_detail_idx4].l_srcd012,g_srcc4_d[g_detail_idx4].l_srcd013, 
                       g_srcc4_d[g_detail_idx4].l_srcd014,g_srcc4_d[g_detail_idx4].l_srcd901,g_srcc4_d[g_detail_idx4].l_srcd902, 
                       g_srcc4_d[g_detail_idx4].l_srcd905,g_srcc4_d[g_detail_idx4].l_srcd906)
      #add-point:insert_b段資料新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "srcd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx4
      IF ps_page <> "'4'" THEN 
         CALL g_srcc4_d.insertElement(li_idx) 
      END IF 
   END IF
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asrt801_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "srcc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL asrt801_srcc_t_mask_restore('restore_mask_o')
               
      UPDATE srcc_t 
         SET (srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,srcc006,srcc900,
              srcc007
              ,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,srcc020,srcc036,srcc037,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,srcc046,srcc047,srcc048,srcc027,srcc028,srcc029,srcc901,srcc902,srcc905,srcc906,srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc038,srcc039,srcc040,srcc041,srcc042,srcc043,srcc044,srcc045) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9]
              ,g_srcc_d[g_detail_idx].srcc008,g_srcc_d[g_detail_idx].srcc009,g_srcc_d[g_detail_idx].srcc010, 
                  g_srcc_d[g_detail_idx].srcc011,g_srcc_d[g_detail_idx].srcc012,g_srcc_d[g_detail_idx].srcc013, 
                  g_srcc_d[g_detail_idx].srcc014,g_srcc_d[g_detail_idx].srcc015,g_srcc_d[g_detail_idx].srcc016, 
                  g_srcc_d[g_detail_idx].srcc017,g_srcc_d[g_detail_idx].srcc018,g_srcc_d[g_detail_idx].srcc019, 
                  g_srcc_d[g_detail_idx].srcc020,g_srcc_d[g_detail_idx].srcc036,g_srcc_d[g_detail_idx].srcc037, 
                  g_srcc_d[g_detail_idx].srcc021,g_srcc_d[g_detail_idx].srcc022,g_srcc_d[g_detail_idx].srcc023, 
                  g_srcc_d[g_detail_idx].srcc024,g_srcc_d[g_detail_idx].srcc025,g_srcc_d[g_detail_idx].srcc026, 
                  g_srcc_d[g_detail_idx].srcc046,g_srcc_d[g_detail_idx].srcc047,g_srcc_d[g_detail_idx].srcc048, 
                  g_srcc_d[g_detail_idx].srcc027,g_srcc_d[g_detail_idx].srcc028,g_srcc_d[g_detail_idx].srcc029, 
                  g_srcc_d[g_detail_idx].srcc901,g_srcc_d[g_detail_idx].srcc902,g_srcc_d[g_detail_idx].srcc905, 
                  g_srcc_d[g_detail_idx].srcc906,g_srcc2_d[g_detail_idx].srcc030,g_srcc2_d[g_detail_idx].srcc031, 
                  g_srcc2_d[g_detail_idx].srcc032,g_srcc2_d[g_detail_idx].srcc033,g_srcc2_d[g_detail_idx].srcc034, 
                  g_srcc2_d[g_detail_idx].srcc035,g_srcc2_d[g_detail_idx].srcc038,g_srcc2_d[g_detail_idx].srcc039, 
                  g_srcc2_d[g_detail_idx].srcc040,g_srcc2_d[g_detail_idx].srcc041,g_srcc2_d[g_detail_idx].srcc042, 
                  g_srcc2_d[g_detail_idx].srcc043,g_srcc2_d[g_detail_idx].srcc044,g_srcc2_d[g_detail_idx].srcc045)  
 
         WHERE srccent = g_enterprise AND srccsite = ps_keys_bak[1] AND srcc000 = ps_keys_bak[2] AND srcc001 = ps_keys_bak[3] AND srcc002 = ps_keys_bak[4] AND srcc004 = ps_keys_bak[5] AND srcc005 = ps_keys_bak[6] AND srcc006 = ps_keys_bak[7] AND srcc900 = ps_keys_bak[8] AND srcc007 = ps_keys_bak[9]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt801_srcc_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'3',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "srcd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL asrt801_srcd_t_mask_restore('restore_mask_o')
               
      UPDATE srcd_t 
         SET (srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007,
              srcdseq
              ,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905,srcd906) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4],ps_keys[5],ps_keys[6],ps_keys[7],ps_keys[8],ps_keys[9],ps_keys[10]
              ,g_srcc3_d[g_detail_idx2].srcd008,g_srcc3_d[g_detail_idx2].srcd009,g_srcc3_d[g_detail_idx2].srcd010, 
                  g_srcc3_d[g_detail_idx2].srcd011,g_srcc3_d[g_detail_idx2].srcd012,g_srcc3_d[g_detail_idx2].srcd013, 
                  g_srcc3_d[g_detail_idx2].srcd014,g_srcc3_d[g_detail_idx2].srcd901,g_srcc3_d[g_detail_idx2].srcd902, 
                  g_srcc3_d[g_detail_idx2].srcd905,g_srcc3_d[g_detail_idx2].srcd906) 
         WHERE srcdent = g_enterprise AND srcdsite = ps_keys_bak[1] AND srcd000 = ps_keys_bak[2] AND srcd001 = ps_keys_bak[3] AND srcd002 = ps_keys_bak[4] AND srcd004 = ps_keys_bak[5] AND srcd005 = ps_keys_bak[6] AND srcd006 = ps_keys_bak[7] AND srcd900 = ps_keys_bak[8] AND srcd007 = ps_keys_bak[9] AND srcdseq = ps_keys_bak[10]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asrt801_srcd_t_mask_restore('restore_mask_n')
               
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
 
{<section id="asrt801.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asrt801_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'srcc_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE srcd_t 
         SET (srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,srcd900,srcd007) 
              = 
             (g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004, 
                 g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007)  
 
         WHERE srcdent = g_enterprise AND
               srcdsite = ps_keys_bak[1] AND srcd000 = ps_keys_bak[2] AND srcd001 = ps_keys_bak[3] AND srcd002 = ps_keys_bak[4] AND srcd004 = ps_keys_bak[5] AND srcd005 = ps_keys_bak[6] AND srcd006 = ps_keys_bak[7] AND srcd900 = ps_keys_bak[8] AND srcd007 = ps_keys_bak[9]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
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
 
{<section id="asrt801.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asrt801_key_delete_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'srcc_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      
      #end add-point
      
      DELETE FROM srcd_t 
            WHERE srcdent = g_enterprise AND
                  srcdsite = ps_keys_bak[1] AND srcd000 = ps_keys_bak[2] AND srcd001 = ps_keys_bak[3] AND srcd002 = ps_keys_bak[4] AND srcd004 = ps_keys_bak[5] AND srcd005 = ps_keys_bak[6] AND srcd006 = ps_keys_bak[7] AND srcd900 = ps_keys_bak[8] AND srcd007 = ps_keys_bak[9]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "srcd_t:",SQLERRMESSAGE 
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
 
{<section id="asrt801.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asrt801_lock_b(ps_table,ps_page)
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
   #CALL asrt801_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1','2',"
   #僅鎖定自身table
   LET ls_group = "srcc_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asrt801_bcl USING g_enterprise,
                                       g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                                           g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900, 
                                           g_srcc_d[g_detail_idx].srcc007     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt801_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'3',"
   #僅鎖定自身table
   LET ls_group = "srcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asrt801_bcl2 USING g_enterprise,
                                             g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                                                 g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006, 
                                                 g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007,
                                             g_srcc3_d[g_detail_idx2].srcdseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt801_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
   #add-point:lock_b段other name="lock_b.other"
   LET ls_group = "l_srcd_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asrt801_bcl4 USING g_enterprise,
                                             g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
                                                 g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006, 
                                                 g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007,
                                             g_srcc4_d[g_detail_idx4].l_srcdseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asrt801_bcl4" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asrt801_unlock_b(ps_table,ps_page)
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
      CLOSE asrt801_bcl
   END IF
   
 
   
   LET ls_group = "'3',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asrt801_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   LET ls_group = "'4',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asrt801_bcl4
   END IF
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asrt801_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900",TRUE)
      CALL cl_set_comp_entry("",TRUE)
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
 
{<section id="asrt801.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asrt801_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asrt801_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("srcc011,srcc013,srcc037",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asrt801_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   DEFINE l_n     LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
      
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   CALL cl_set_comp_entry("srcc009",FALSE)
   IF NOT (g_srcc_d[l_ac].srcc010 = '2' OR g_srcc_d[l_ac].srcc010 = '3') THEN
      CALL cl_set_comp_entry("srcc011",FALSE)
      LET g_srcc_d[l_ac].srcc011 = ""
   END IF
   
   IF g_srcc_d[l_ac].srcc012 = 'INIT' OR g_srcc_d[l_ac].srcc012 = 'MULT' THEN
      LET g_srcc_d[l_ac].srcc013 = 0
      CALL cl_set_comp_entry("srcc013",FALSE)
   END IF
   LET l_n = 0 
   SELECT COUNT(*) INTO l_n FROM srcc_t
    WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
      AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
      AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
      AND srcc011 = g_srcc_d[l_ac].srcc012
   IF l_n > 0 THEN
      LET g_srcc_d[l_ac].srcc013 = 0
      CALL cl_set_comp_entry("srcc013",FALSE)
   END IF
   
   IF g_srcc_d[l_ac].srcc036 = 'N' THEN
      CALL cl_set_comp_entry("srcc037",FALSE)
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asrt801_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asrt801_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_srca_m.srcastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asrt801_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asrt801_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asrt801_default_search()
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
      LET ls_wc = ls_wc, " srcasite = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " srca000 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " srca001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " srca002 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " srca004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " srca005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET ls_wc = ls_wc, " srca006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET ls_wc = ls_wc, " srca900 = '", g_argv[08], "' AND "
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
               WHEN la_wc[li_idx].tableid = "srca_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "srcc_t" 
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
 
{<section id="asrt801.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION asrt801_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   IF g_srca_m.srcastus MATCHES '[XY]' THEN
      RETURN
   END IF
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_srca_m.srcasite IS NULL
      OR g_srca_m.srca000 IS NULL      OR g_srca_m.srca001 IS NULL      OR g_srca_m.srca002 IS NULL      OR g_srca_m.srca004 IS NULL      OR g_srca_m.srca005 IS NULL      OR g_srca_m.srca006 IS NULL      OR g_srca_m.srca900 IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN asrt801_cl USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900
   IF STATUS THEN
      CLOSE asrt801_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asrt801_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
       g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite,g_srca_m.srca000, 
       g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002,g_srca_m.srca900, 
       g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaowndp, 
       g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamoddt, 
       g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc,g_srca_m.srca006_desc, 
       g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc, 
       g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc,g_srca_m.srcacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT asrt801_action_chk() THEN
      CLOSE asrt801_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca001_desc,g_srca_m.srca004, 
       g_srca_m.srca004_desc,g_srca_m.srca004_desc_1,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca006_desc, 
       g_srca_m.srca002,g_srca_m.srca002_desc,g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca905_desc, 
       g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaownid_desc,g_srca_m.srcaowndp, 
       g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp,g_srca_m.srcacrtdp_desc, 
       g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamodid_desc,g_srca_m.srcamoddt,g_srca_m.srcacnfid, 
       g_srca_m.srcacnfid_desc,g_srca_m.srcacnfdt
 
   CASE g_srca_m.srcastus
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
         CASE g_srca_m.srcastus
            
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
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      #提交和抽單一開始先無條件關
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CASE g_srca_m.srcastus
         WHEN "N"
            CALL cl_set_act_visible("unconfirmed,closed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
               CALL cl_set_act_visible("signing",TRUE)
               CALL cl_set_act_visible("confirmed",FALSE)
            END IF

         #保留修改的功能(如作廢)，隱藏其他應用功能
         WHEN "R"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "X"
            CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
            
         #只能顯示抽單;其餘應用功能皆隱藏
         WHEN "W"
             CALL cl_set_act_visible("withdraw",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)

         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

      END CASE
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT asrt801_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt801_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT asrt801_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asrt801_cl
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
            CALL s_transaction_begin()
            IF NOT s_asrt801_conf_chk(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900) THEN
               CALL s_transaction_end('N','0')
               RETURN
            ELSE
               IF NOT cl_ask_confirm('aim-00108') THEN
                  CALL s_transaction_end('N','0')
                  RETURN
               ELSE
                  IF NOT s_asrt801_conf_upd(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900) THEN
                     CALL s_transaction_end('N','0')
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF
               END IF
            END IF
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
      g_srca_m.srcastus = lc_state OR cl_null(lc_state) THEN
      CLOSE asrt801_cl
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
   
   LET g_srca_m.srcamodid = g_user
   LET g_srca_m.srcamoddt = cl_get_current()
   LET g_srca_m.srcastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE srca_t 
      SET (srcastus,srcamodid,srcamoddt) 
        = (g_srca_m.srcastus,g_srca_m.srcamodid,g_srca_m.srcamoddt)     
    WHERE srcaent = g_enterprise AND srcasite = g_srca_m.srcasite
      AND srca000 = g_srca_m.srca000      AND srca001 = g_srca_m.srca001      AND srca002 = g_srca_m.srca002      AND srca004 = g_srca_m.srca004      AND srca005 = g_srca_m.srca005      AND srca006 = g_srca_m.srca006      AND srca900 = g_srca_m.srca900
    
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
      EXECUTE asrt801_master_referesh USING g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
          g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900 INTO g_srca_m.srcasite, 
          g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca002, 
          g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid, 
          g_srca_m.srcaowndp,g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcamodid, 
          g_srca_m.srcamoddt,g_srca_m.srcacnfid,g_srca_m.srcacnfdt,g_srca_m.srca001_desc,g_srca_m.srca004_desc, 
          g_srca_m.srca006_desc,g_srca_m.srca002_desc,g_srca_m.srca905_desc,g_srca_m.srcaownid_desc, 
          g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp_desc,g_srca_m.srcamodid_desc, 
          g_srca_m.srcacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca001_desc,g_srca_m.srca004, 
          g_srca_m.srca004_desc,g_srca_m.srca004_desc_1,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca006_desc, 
          g_srca_m.srca002,g_srca_m.srca002_desc,g_srca_m.srca900,g_srca_m.srca902,g_srca_m.srca905, 
          g_srca_m.srca905_desc,g_srca_m.srca906,g_srca_m.srcastus,g_srca_m.srcaownid,g_srca_m.srcaownid_desc, 
          g_srca_m.srcaowndp,g_srca_m.srcaowndp_desc,g_srca_m.srcacrtid,g_srca_m.srcacrtid_desc,g_srca_m.srcacrtdp, 
          g_srca_m.srcacrtdp_desc,g_srca_m.srcacrtdt,g_srca_m.srcamodid,g_srca_m.srcamodid_desc,g_srca_m.srcamoddt, 
          g_srca_m.srcacnfid,g_srca_m.srcacnfid_desc,g_srca_m.srcacnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE asrt801_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asrt801_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt801.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asrt801_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_srcc_d.getLength() THEN
         LET g_detail_idx = g_srcc_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srcc_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srcc_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_srcc2_d.getLength() THEN
         LET g_detail_idx = g_srcc2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_srcc2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_srcc2_d.getLength() TO FORMONLY.cnt
   END IF
   IF g_current_page = 3 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail3")
      IF g_detail_idx2 > g_srcc3_d.getLength() THEN
         LET g_detail_idx2 = g_srcc3_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_srcc3_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_srcc3_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   IF g_current_page = 4 THEN
      LET g_detail_idx4 = g_curr_diag.getCurrentRow("s_detail4")
      IF g_detail_idx4 > g_srcc4_d.getLength() THEN
         LET g_detail_idx4 = g_srcc4_d.getLength()
      END IF
      IF g_detail_idx4 = 0 AND g_srcc4_d.getLength() <> 0 THEN
         LET g_detail_idx4 = 1
      END IF
      DISPLAY g_detail_idx4 TO FORMONLY.idx
      DISPLAY g_srcc4_d.getLength() TO FORMONLY.cnt
   END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asrt801_b_fill2(pi_idx)
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
   
   IF asrt801_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_srcc_d.getLength() > 0 THEN
               CALL g_srcc3_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014, 
             srcd901,srcd902,srcd905,srcd906 ,t11.oocql004 ,t12.oocql004 FROM srcd_t",    
                     "",
                                    " LEFT JOIN oocql_t t11 ON t11.oocqlent="||g_enterprise||" AND t11.oocql001='223' AND t11.oocql002=srcd009 AND t11.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t12 ON t12.oocqlent="||g_enterprise||" AND t12.oocql001='215' AND t12.oocql002=srcd905 AND t12.oocql003='"||g_dlang||"' ",
 
                     " WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=? AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  srcd_t.srcdseq" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         DISPLAY g_srcc_d[g_detail_idx].srcc007,g_srcc_d[g_detail_idx].srcc008,g_srcc_d[g_detail_idx].srcc008_desc,g_srcc_d[g_detail_idx].srcc009 
              TO l_srcc007,l_srcc008,l_srcc008_desc,l_srcc009
              
         LET g_sql = "SELECT  UNIQUE srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014, 
             srcd901,srcd902,srcd905,srcd906 ,t9.oocql004 ,t10.oocql004 FROM srcd_t",    
                     "",
                                    " LEFT JOIN oocql_t t9 ON t9.oocqlent='"||g_enterprise||"' AND t9.oocql001='223' AND t9.oocql002=srcd009 AND t9.oocql003='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t10 ON t10.oocqlent='"||g_enterprise||"' AND t10.oocql001='215' AND t10.oocql002=srcd905 AND t10.oocql003='"||g_dlang||"' ",
 
                     " WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=? AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=? ",
                     "   AND srcd008 = '1' "
                     
         IF g_flag_hidden = 'Y' THEN
            LET g_sql = g_sql," AND srcd901 != '4' "
         END IF
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  srcd_t.srcdseq" 
         #end add-point
         
         #先清空資料
               CALL g_srcc3_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt801_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR asrt801_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
      #    g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007  
      #      #(ver:78)
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001, 
             g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007 INTO g_srcc3_d[l_ac].srcdseq, 
             g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,g_srcc3_d[l_ac].srcd010,g_srcc3_d[l_ac].srcd011, 
             g_srcc3_d[l_ac].srcd012,g_srcc3_d[l_ac].srcd013,g_srcc3_d[l_ac].srcd014,g_srcc3_d[l_ac].srcd901, 
             g_srcc3_d[l_ac].srcd902,g_srcc3_d[l_ac].srcd905,g_srcc3_d[l_ac].srcd906,g_srcc3_d[l_ac].srcd009_desc, 
             g_srcc3_d[l_ac].srcd905_desc   #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            CALL asrt801_srcd_desc(g_srcc3_d[l_ac].srcd008,g_srcc3_d[l_ac].srcd009,g_srcc3_d[l_ac].srcd905)
            CALL asrt801_srcd_color()
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
               CALL g_srcc3_d.deleteElement(g_srcc3_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_srcc3_d_mask_o.* =  g_srcc3_d.*
   FOR l_ac = 1 TO g_srcc3_d.getLength()
      LET g_srcc3_d_mask_o[l_ac].* =  g_srcc3_d[l_ac].*
      CALL asrt801_srcd_t_mask()
      LET g_srcc3_d_mask_n[l_ac].* =  g_srcc3_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   IF asrt801_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_srcc_d.getLength() > 0 THEN
         CALL g_srcc4_d.clear()

         DISPLAY g_srcc_d[g_detail_idx].srcc007,g_srcc_d[g_detail_idx].srcc008,g_srcc_d[g_detail_idx].srcc008_desc,g_srcc_d[g_detail_idx].srcc009 
              TO l_srcc007_1,l_srcc008_1,l_srcc008_1_desc,l_srcc009_1
              
         LET g_sql = "SELECT  UNIQUE srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,srcd014,srcd901,srcd902,srcd905,srcd906 ,t9.oocql004 ,t10.oocql004 FROM srcd_t",    
                     " LEFT JOIN oocql_t t9 ON t9.oocqlent='"||g_enterprise||"' AND t9.oocql001='223' AND t9.oocql002=srcd009 AND t9.oocql003='"||g_dlang||"' ",
                     " LEFT JOIN oocql_t t10 ON t10.oocqlent='"||g_enterprise||"' AND t10.oocql001='215' AND t10.oocql002=srcd905 AND t10.oocql003='"||g_dlang||"' ",
                     " WHERE srcdent=? AND srcdsite=? AND srcd000=? AND srcd001=? AND srcd002=? AND srcd004=? AND srcd005=? AND srcd006=? AND srcd900=? AND srcd007=? ",
                     "   AND srcd008 = '2' "
                     
         IF g_flag_hidden = 'Y' THEN
            LET g_sql = g_sql," AND srcd901 != '4' "
         END IF
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  srcd_t.srcdseq" 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asrt801_pb2_1 FROM g_sql
         DECLARE b_fill_curs2_1 CURSOR FOR asrt801_pb2_1
         
         OPEN b_fill_curs2_1 USING g_enterprise,g_srca_m.srcasite,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002, 
             g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,g_srca_m.srca900,g_srcc_d[g_detail_idx].srcc007 

         LET l_ac = 1
         FOREACH b_fill_curs2_1 INTO g_srcc4_d[l_ac].l_srcdseq,g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009, 
             g_srcc4_d[l_ac].l_srcd010,g_srcc4_d[l_ac].l_srcd011,g_srcc4_d[l_ac].l_srcd012,g_srcc4_d[l_ac].l_srcd013, 
             g_srcc4_d[l_ac].l_srcd014,g_srcc4_d[l_ac].l_srcd901,g_srcc4_d[l_ac].l_srcd902,g_srcc4_d[l_ac].l_srcd905,
             g_srcc4_d[l_ac].l_srcd906,g_srcc4_d[l_ac].l_srcd009_desc,g_srcc4_d[l_ac].l_srcd905_desc 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            CALL asrt801_srcd_desc(g_srcc4_d[l_ac].l_srcd008,g_srcc4_d[l_ac].l_srcd009,g_srcc4_d[l_ac].l_srcd905)
            
            CALL asrt801_srcd2_color()
            
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
         CALL g_srcc4_d.deleteElement(g_srcc4_d.getLength())
 
      END IF
   END IF
   #end add-point
    
   LET l_ac = li_ac
   
   CALL asrt801_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asrt801_fill_chk(ps_idx)
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
 
{<section id="asrt801.status_show" >}
PRIVATE FUNCTION asrt801_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asrt801.mask_functions" >}
&include "erp/asr/asrt801_mask.4gl"
 
{</section>}
 
{<section id="asrt801.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION asrt801_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
 
 
   CALL asrt801_show()
   CALL asrt801_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_srca_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_srcc_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_srcc2_d))
   CALL cl_bpm_set_detail_data("s_detail3", util.JSONArray.fromFGL(g_srcc3_d))
 
 
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
   #CALL asrt801_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asrt801_ui_headershow()
   CALL asrt801_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION asrt801_draw_out()
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
   CALL asrt801_ui_headershow()  
   CALL asrt801_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="asrt801.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asrt801_set_pk_array()
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
   LET g_pk_array[1].values = g_srca_m.srcasite
   LET g_pk_array[1].column = 'srcasite'
   LET g_pk_array[2].values = g_srca_m.srca000
   LET g_pk_array[2].column = 'srca000'
   LET g_pk_array[3].values = g_srca_m.srca001
   LET g_pk_array[3].column = 'srca001'
   LET g_pk_array[4].values = g_srca_m.srca002
   LET g_pk_array[4].column = 'srca002'
   LET g_pk_array[5].values = g_srca_m.srca004
   LET g_pk_array[5].column = 'srca004'
   LET g_pk_array[6].values = g_srca_m.srca005
   LET g_pk_array[6].column = 'srca005'
   LET g_pk_array[7].values = g_srca_m.srca006
   LET g_pk_array[7].column = 'srca006'
   LET g_pk_array[8].values = g_srca_m.srca900
   LET g_pk_array[8].column = 'srca900'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt801.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asrt801.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asrt801_msgcentre_notify(lc_state)
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
   CALL asrt801_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_srca_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asrt801.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asrt801_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#37-s
   SELECT srcastus INTO g_srca_m.srcastus FROM srca_t
    WHERE srcaent = g_enterprise
      AND srcasite = g_srca_m.srcasite
      AND srca001 = g_srca_m.srca001
      AND srca002 = g_srca_m.srca002
      AND srca004 = g_srca_m.srca004
      AND srca005 = g_srca_m.srca005
      AND srca006 = g_srca_m.srca006
      AND srca900 = g_srca_m.srca900      
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_srca_m.srcastus
        WHEN 'W'
           LET g_errno = 'sub-01347'
        WHEN 'X'
           LET g_errno = 'sub-00229'
        WHEN 'Y'
           LET g_errno = 'sub-00178'
     END CASE

     IF NOT cl_null(g_errno) THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = g_errno
        LET g_errparam.extend = g_srca_m.srca001
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL asrt801_set_act_visible()
        CALL asrt801_set_act_no_visible()
        CALL asrt801_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#37-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asrt801.other_function" readonly="Y" >}

#单头栏位ref栏位显示
PRIVATE FUNCTION asrt801_desc()
DEFINE l_success         LIKE type_t.num5   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srca_m.srcasite
   LET g_ref_fields[2] = g_srca_m.srca001
   CALL ap_ref_array2(g_ref_fields,"SELECT srza002 FROM srza_t WHERE srzaent='"||g_enterprise||"' AND srzasite=? AND srza001=? ","") RETURNING g_rtn_fields
   LET g_srca_m.srca001_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srca_m.srca001_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srca_m.srca004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srca_m.srca004_desc = '', g_rtn_fields[1] , ''
   LET g_srca_m.srca004_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_srca_m.srca004_desc,g_srca_m.srca004_desc_1

   CALL s_feature_description(g_srca_m.srca004,g_srca_m.srca006)
        RETURNING l_success,g_srca_m.srca006_desc
   IF NOT l_success THEN
      LET g_srca_m.srca006_desc = ''
   END IF
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srca_m.srcasite
   LET g_ref_fields[2] = g_srca_m.srca004
   LET g_ref_fields[3] = g_srca_m.srca002
   CALL ap_ref_array2(g_ref_fields,"SELECT ecba003 FROM ecba_t WHERE ecbaent='"||g_enterprise||"' AND ecbasite=? AND ecba001=? AND ecba002=? ","") RETURNING g_rtn_fields
   LET g_srca_m.srca002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srca_m.srca002_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srca_m.srca905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srca_m.srca905_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srca_m.srca905_desc
          
END FUNCTION

#单头key值栏位检查
PRIVATE FUNCTION asrt801_srca_chk()
DEFINE r_success              LIKE type_t.num5
DEFINE l_sql                  STRING
DEFINE l_n                    LIKE type_t.num5

   LET r_success = FALSE
   LET g_flag1 = 'Y'
   LET g_flag2 = 'Y'
   LET g_flag4 = 'Y'
   LET g_flag5 = 'Y'
   LET g_flag6 = 'Y'
   
   LET l_sql = "SELECT COUNT(*) FROM srac_t ",
               " WHERE sracent = ",g_enterprise," AND sracsite = '",g_site,"'"
   IF NOT cl_null(g_srca_m.srca001) THEN
      LET l_sql = l_sql," AND srac001 = '",g_srca_m.srca001,"'"
   END IF
   IF g_srca_m.srca002 IS NOT NULL THEN
      LET l_sql = l_sql," AND srac002 = '",g_srca_m.srca002,"'"
   END IF
   IF NOT cl_null(g_srca_m.srca004) THEN
      LET l_sql = l_sql," AND srac004 = '",g_srca_m.srca004,"'"
   END IF
   IF g_srca_m.srca005 IS NOT NULL THEN
      LET l_sql = l_sql," AND srac005 = '",g_srca_m.srca005,"'"
   END IF
   IF g_srca_m.srca006 IS NOT NULL THEN
      LET l_sql = l_sql," AND srac006 = '",g_srca_m.srca006,"'"
   END IF
   PREPARE asrt801_srca_chk_pre FROM l_sql
   EXECUTE asrt801_srca_chk_pre INTO l_n
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = ''
      LET g_errparam.code   = "asr-00061" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF
   
   IF cl_null(g_srca_m.srca001) THEN
      LET g_flag1 = 'N'
   END IF
   IF g_srca_m.srca002 IS NULL THEN
      LET g_flag2 = 'N'
   END IF
   IF cl_null(g_srca_m.srca004) THEN
      LET g_flag4 = 'N'
   END IF
   IF g_srca_m.srca005 IS NULL THEN
      LET g_flag5 = 'N'
   END IF
   IF g_srca_m.srca006 IS NULL THEN
      LET g_flag6 = 'N'
   END IF
   
   IF NOT cl_null(g_srca_m.srca001) AND NOT cl_null(g_srca_m.srca004) AND g_srca_m.srca005 IS NOT NULL AND g_srca_m.srca006 IS NOT NULL AND g_srca_m.srca002 IS NOT NULL THEN
      #同一张重复性生产制程不可有多张未确认的变更单
      SELECT COUNT(*) INTO l_n FROM srca_t
       WHERE srcaent = g_enterprise AND srcasite = g_site AND srca000 = g_srca_m.srca000
         AND srca001 = g_srca_m.srca001 AND srca002 = g_srca_m.srca002 AND srca004 = g_srca_m.srca004
         AND srca005 = g_srca_m.srca005 AND srca006 = g_srca_m.srca006 AND srcastus = 'N'
      IF l_n > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asr-00062'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         RETURN r_success
      END IF
    
      #變更序=變更單的變更序最大值+1
      SELECT MAX(srca900)+1 INTO g_srca_m.srca900 FROM srca_t
       WHERE srcaent = g_enterprise AND srcasite = g_site AND srca000 = g_srca_m.srca000
         AND srca001 = g_srca_m.srca001 AND srca002 = g_srca_m.srca002 AND srca004 = g_srca_m.srca004
         AND srca005 = g_srca_m.srca005 AND srca006 = g_srca_m.srca006
      IF cl_null(g_srca_m.srca900) OR g_srca_m.srca900 = 0 THEN
         LET g_srca_m.srca900 = 1
      END IF
      IF NOT asrt801_gen() THEN
         RETURN r_success
      ELSE
         LET g_flag = 'N'
         LET g_master_insert = TRUE    #161128-00015#1       
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#根据单头录入资料带出重复性生产制程资料
PRIVATE FUNCTION asrt801_gen()
DEFINE r_success         LIKE type_t.num5

   LET r_success = FALSE
   
   #产生重复性生产变更单单头资料，srca_t
   IF NOT asrt801_gen_srca() THEN
      RETURN r_success
   END IF
   
   #产生重复性生产变更单单身制程资料，srcc_t
   IF NOT asrt801_gen_srcc() THEN
      RETURN r_success
   END IF
   
   #产生重复性生产变更单check in/out资料，srcd_t
   IF NOT asrt801_gen_srcd() THEN
      RETURN r_success
   END IF
   
   #产生重复性生产变更单多上站资料，srce_t
   IF NOT asrt801_gen_srce() THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

#产生重复性生产变更单单头资料，srca_t
PRIVATE FUNCTION asrt801_gen_srca()
DEFINE r_success                LIKE type_t.num5

   LET r_success = FALSE
   
   INSERT INTO srca_t(srcaent,srcasite,srca000,srca001,srca002,srca004,srca005,srca006,srca900,srca901,srca902,srca905,srca906,
                      srcaownid,srcaowndp,srcacrtid,srcacrtdp,srcacrtdt,srcastus)
               VALUES(g_enterprise,g_site,g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,
                      g_srca_m.srca006,g_srca_m.srca900,'N',g_srca_m.srca902,g_srca_m.srca905,g_srca_m.srca906,
                      g_srca_m.srcaownid,g_srca_m.srcaowndp,g_srca_m.srcacrtid,g_srca_m.srcacrtdp,g_srca_m.srcacrtdt,g_srca_m.srcastus)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'INSERT srca_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF      
   
   LET r_success = TRUE
   RETURN r_success   
END FUNCTION

#产生重复性生产变更单单身制程资料，srcc_t
PRIVATE FUNCTION asrt801_gen_srcc()
DEFINE r_success                 LIKE type_t.num5
#DEFINE l_srac                    RECORD LIKE srac_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srac RECORD  #重覆性生產計畫製程檔
       sracent LIKE srac_t.sracent, #企业编号
       sracsite LIKE srac_t.sracsite, #营运据点
       srac001 LIKE srac_t.srac001, #生产计划
       srac002 LIKE srac_t.srac002, #工艺编号
       srac004 LIKE srac_t.srac004, #料件编号
       srac005 LIKE srac_t.srac005, #BOM特性
       srac006 LIKE srac_t.srac006, #产品特征
       srac007 LIKE srac_t.srac007, #项次
       srac008 LIKE srac_t.srac008, #本站作业编号
       srac009 LIKE srac_t.srac009, #作业序
       srac010 LIKE srac_t.srac010, #群组性质
       srac011 LIKE srac_t.srac011, #群组
       srac012 LIKE srac_t.srac012, #上站作业
       srac013 LIKE srac_t.srac013, #上站制进程
       srac014 LIKE srac_t.srac014, #下站作业
       srac015 LIKE srac_t.srac015, #下站制进程
       srac016 LIKE srac_t.srac016, #工作站
       srac017 LIKE srac_t.srac017, #固定工时
       srac018 LIKE srac_t.srac018, #标准工时
       srac019 LIKE srac_t.srac019, #固定机时
       srac020 LIKE srac_t.srac020, #标准机时
       srac021 LIKE srac_t.srac021, #Move in
       srac022 LIKE srac_t.srac022, #Check in
       srac023 LIKE srac_t.srac023, #报工站
       srac024 LIKE srac_t.srac024, #PQC
       srac025 LIKE srac_t.srac025, #Check out
       srac026 LIKE srac_t.srac026, #Move out
       srac027 LIKE srac_t.srac027, #转出单位
       srac028 LIKE srac_t.srac028, #转出单位转换率分子
       srac029 LIKE srac_t.srac029, #转出单位转换率分母
       srac030 LIKE srac_t.srac030, #待Movie in 数
       srac031 LIKE srac_t.srac031, #待Check in数
       srac032 LIKE srac_t.srac032, #在制数
       srac033 LIKE srac_t.srac033, #待PQC数
       srac034 LIKE srac_t.srac034, #待Check out数
       srac035 LIKE srac_t.srac035, #待Move out数
       srac036 LIKE srac_t.srac036, #委外
       srac037 LIKE srac_t.srac037, #委外供应商
       srac038 LIKE srac_t.srac038, #良品转入
       srac039 LIKE srac_t.srac039, #返工转入
       srac040 LIKE srac_t.srac040, #良品转出
       srac041 LIKE srac_t.srac041, #返工转出
       srac042 LIKE srac_t.srac042, #当站报废
       srac043 LIKE srac_t.srac043, #当站下线
       srac044 LIKE srac_t.srac044, #委外数量
       srac045 LIKE srac_t.srac045, #委外完工数量
       srac046 LIKE srac_t.srac046, #转入单位
       srac047 LIKE srac_t.srac047, #转入单位转换率分子
       srac048 LIKE srac_t.srac048  #转入单位转换率分母
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srcc                    RECORD LIKE srcc_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcc RECORD  #重複性生產計劃製程變更檔
       srccent LIKE srcc_t.srccent, #企业编号
       srccsite LIKE srcc_t.srccsite, #营运据点
       srcc000 LIKE srcc_t.srcc000, #类型
       srcc001 LIKE srcc_t.srcc001, #生产计划
       srcc002 LIKE srcc_t.srcc002, #工艺编号
       srcc004 LIKE srcc_t.srcc004, #料件编号
       srcc005 LIKE srcc_t.srcc005, #BOM特性
       srcc006 LIKE srcc_t.srcc006, #产品特征
       srcc007 LIKE srcc_t.srcc007, #项次
       srcc008 LIKE srcc_t.srcc008, #本站作业编号
       srcc009 LIKE srcc_t.srcc009, #作业序
       srcc010 LIKE srcc_t.srcc010, #群组性质
       srcc011 LIKE srcc_t.srcc011, #群组
       srcc012 LIKE srcc_t.srcc012, #上站作业
       srcc013 LIKE srcc_t.srcc013, #上站作业序
       srcc014 LIKE srcc_t.srcc014, #下站作业
       srcc015 LIKE srcc_t.srcc015, #下站作业序
       srcc016 LIKE srcc_t.srcc016, #工作站
       srcc017 LIKE srcc_t.srcc017, #固定工时
       srcc018 LIKE srcc_t.srcc018, #标准工时
       srcc019 LIKE srcc_t.srcc019, #固定机时
       srcc020 LIKE srcc_t.srcc020, #标准机时
       srcc021 LIKE srcc_t.srcc021, #Move in
       srcc022 LIKE srcc_t.srcc022, #Check in
       srcc023 LIKE srcc_t.srcc023, #报工站
       srcc024 LIKE srcc_t.srcc024, #PQC
       srcc025 LIKE srcc_t.srcc025, #Check out
       srcc026 LIKE srcc_t.srcc026, #Move out
       srcc027 LIKE srcc_t.srcc027, #转出单位
       srcc028 LIKE srcc_t.srcc028, #单位转换率分子
       srcc029 LIKE srcc_t.srcc029, #单位转换率分母
       srcc030 LIKE srcc_t.srcc030, #待Move in数
       srcc031 LIKE srcc_t.srcc031, #待Check in数
       srcc032 LIKE srcc_t.srcc032, #在制数
       srcc033 LIKE srcc_t.srcc033, #待PQC数
       srcc034 LIKE srcc_t.srcc034, #待Check out数
       srcc035 LIKE srcc_t.srcc035, #待Move out数
       srcc036 LIKE srcc_t.srcc036, #委外
       srcc037 LIKE srcc_t.srcc037, #委外供应商
       srcc038 LIKE srcc_t.srcc038, #良品转入
       srcc039 LIKE srcc_t.srcc039, #返工转入
       srcc040 LIKE srcc_t.srcc040, #良品转出
       srcc041 LIKE srcc_t.srcc041, #返工转出
       srcc042 LIKE srcc_t.srcc042, #当站报废
       srcc043 LIKE srcc_t.srcc043, #当站下线
       srcc044 LIKE srcc_t.srcc044, #委外数量
       srcc045 LIKE srcc_t.srcc045, #委外完工数量
       srcc046 LIKE srcc_t.srcc046, #转入单位
       srcc047 LIKE srcc_t.srcc047, #转入单位转换率分子
       srcc048 LIKE srcc_t.srcc048, #转入单位转换率分母
       srcc900 LIKE srcc_t.srcc900, #变更序
       srcc901 LIKE srcc_t.srcc901, #变更类型
       srcc902 LIKE srcc_t.srcc902, #变更日期
       srcc905 LIKE srcc_t.srcc905, #变更理由
       srcc906 LIKE srcc_t.srcc906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   DECLARE asrt801_gen_srcc_curs CURSOR FOR
#    SELECT * FROM srac_t WHERE sracent = g_enterprise AND sracsite = g_site  #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT sracent,sracsite,srac001,srac002,srac004,srac005,srac006,srac007,
           srac008,srac009,srac010,srac011,srac012,srac013,srac014,srac015,srac016,
           srac017,srac018,srac019,srac020,srac021,srac022,srac023,srac024,srac025,
           srac026,srac027,srac028,srac029,srac030,srac031,srac032,srac033,srac034,
           srac035,srac036,srac037,srac038,srac039,srac040,srac041,srac042,srac043,
           srac044,srac045,srac046,srac047,srac048 
      FROM srac_t WHERE sracent = g_enterprise AND sracsite = g_site
    #161124-00048#12 add(e)
       AND srac001 = g_srca_m.srca001 AND srac002 = g_srca_m.srca002
       AND srac004 = g_srca_m.srca004 AND srac005 = g_srca_m.srca005
       AND srac006 = g_srca_m.srca006
     ORDER BY srac007
   FOREACH asrt801_gen_srcc_curs INTO l_srac.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_srcc.srccent  = g_enterprise
      LET l_srcc.srccsite = g_site
      LET l_srcc.srcc000  = g_srca_m.srca000
      LET l_srcc.srcc001  = l_srac.srac001
      LET l_srcc.srcc002  = l_srac.srac002
      LET l_srcc.srcc004  = l_srac.srac004
      LET l_srcc.srcc005  = l_srac.srac005
      LET l_srcc.srcc006  = l_srac.srac006
      LET l_srcc.srcc007  = l_srac.srac007
      LET l_srcc.srcc008  = l_srac.srac008
      LET l_srcc.srcc009  = l_srac.srac009
      LET l_srcc.srcc010  = l_srac.srac010
      LET l_srcc.srcc011  = l_srac.srac011
      LET l_srcc.srcc012  = l_srac.srac012
      LET l_srcc.srcc013  = l_srac.srac013
      LET l_srcc.srcc014  = l_srac.srac014
      LET l_srcc.srcc015  = l_srac.srac015
      LET l_srcc.srcc016  = l_srac.srac016
      LET l_srcc.srcc017  = l_srac.srac017
      LET l_srcc.srcc018  = l_srac.srac018
      LET l_srcc.srcc019  = l_srac.srac019
      LET l_srcc.srcc020  = l_srac.srac020
      LET l_srcc.srcc021  = l_srac.srac021
      LET l_srcc.srcc022  = l_srac.srac022
      LET l_srcc.srcc023  = l_srac.srac023
      LET l_srcc.srcc024  = l_srac.srac024
      LET l_srcc.srcc025  = l_srac.srac025
      LET l_srcc.srcc026  = l_srac.srac026
      LET l_srcc.srcc027  = l_srac.srac027
      LET l_srcc.srcc028  = l_srac.srac028
      LET l_srcc.srcc029  = l_srac.srac029
      LET l_srcc.srcc030  = l_srac.srac030
      LET l_srcc.srcc031  = l_srac.srac031
      LET l_srcc.srcc032  = l_srac.srac032
      LET l_srcc.srcc033  = l_srac.srac033
      LET l_srcc.srcc034  = l_srac.srac034
      LET l_srcc.srcc035  = l_srac.srac035
      LET l_srcc.srcc036  = l_srac.srac036
      LET l_srcc.srcc037  = l_srac.srac037
      LET l_srcc.srcc038  = l_srac.srac038
      LET l_srcc.srcc039  = l_srac.srac039
      LET l_srcc.srcc040  = l_srac.srac040
      LET l_srcc.srcc041  = l_srac.srac041
      LET l_srcc.srcc042  = l_srac.srac042
      LET l_srcc.srcc043  = l_srac.srac043
      LET l_srcc.srcc044  = l_srac.srac044
      LET l_srcc.srcc045  = l_srac.srac045
      LET l_srcc.srcc046  = l_srac.srac046
      LET l_srcc.srcc047  = l_srac.srac047
      LET l_srcc.srcc048  = l_srac.srac048
      LET l_srcc.srcc900  = g_srca_m.srca900
      LET l_srcc.srcc901  = '1'
      
#      INSERT INTO srcc_t VALUES l_srcc.* #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srcc_t(srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,
                         srcc006,srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,srcc013,
                         srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,srcc020,srcc021,
                         srcc022,srcc023,srcc024,srcc025,srcc026,srcc027,srcc028,srcc029,
                         srcc030,srcc031,srcc032,srcc033,srcc034,srcc035,srcc036,srcc037,
                         srcc038,srcc039,srcc040,srcc041,srcc042,srcc043,srcc044,srcc045,
                         srcc046,srcc047,srcc048,srcc900,srcc901,srcc902,srcc905,srcc906) 
                  VALUES(l_srcc.srccent,l_srcc.srccsite,l_srcc.srcc000,l_srcc.srcc001,l_srcc.srcc002,l_srcc.srcc004,l_srcc.srcc005,
                         l_srcc.srcc006,l_srcc.srcc007,l_srcc.srcc008,l_srcc.srcc009,l_srcc.srcc010,l_srcc.srcc011,l_srcc.srcc012,l_srcc.srcc013,
                         l_srcc.srcc014,l_srcc.srcc015,l_srcc.srcc016,l_srcc.srcc017,l_srcc.srcc018,l_srcc.srcc019,l_srcc.srcc020,l_srcc.srcc021,
                         l_srcc.srcc022,l_srcc.srcc023,l_srcc.srcc024,l_srcc.srcc025,l_srcc.srcc026,l_srcc.srcc027,l_srcc.srcc028,l_srcc.srcc029,
                         l_srcc.srcc030,l_srcc.srcc031,l_srcc.srcc032,l_srcc.srcc033,l_srcc.srcc034,l_srcc.srcc035,l_srcc.srcc036,l_srcc.srcc037,
                         l_srcc.srcc038,l_srcc.srcc039,l_srcc.srcc040,l_srcc.srcc041,l_srcc.srcc042,l_srcc.srcc043,l_srcc.srcc044,l_srcc.srcc045,
                         l_srcc.srcc046,l_srcc.srcc047,l_srcc.srcc048,l_srcc.srcc900,l_srcc.srcc901,l_srcc.srcc902,l_srcc.srcc905,l_srcc.srcc906)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT srcc_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_srac.* TO NULL   #清空数组
      INITIALIZE l_srcc.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
     
END FUNCTION

#产生重复性生产变更单check in/out资料，srcd_t
PRIVATE FUNCTION asrt801_gen_srcd()
DEFINE r_success                 LIKE type_t.num5
#DEFINE l_srad                    RECORD LIKE srad_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srad RECORD  #重覆性生產計畫製程Check in/Check out專案檔
       sradent LIKE srad_t.sradent, #企业编号
       sradsite LIKE srad_t.sradsite, #营运据点
       srad001 LIKE srad_t.srad001, #生产计划
       srad002 LIKE srad_t.srad002, #工艺编号
       srad004 LIKE srad_t.srad004, #料件编号
       srad005 LIKE srad_t.srad005, #BOM特性
       srad006 LIKE srad_t.srad006, #产品特征
       srad007 LIKE srad_t.srad007, #项次
       sradseq LIKE srad_t.sradseq, #项序
       srad008 LIKE srad_t.srad008, #check in/check out
       srad009 LIKE srad_t.srad009, #项目
       srad010 LIKE srad_t.srad010, #型态
       srad011 LIKE srad_t.srad011, #下限
       srad012 LIKE srad_t.srad012, #上限
       srad013 LIKE srad_t.srad013, #默认值
       srad014 LIKE srad_t.srad014  #必要
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srcd                    RECORD LIKE srcd_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcd RECORD  #重複性生產計劃製程Check in/Check out項目變更檔
       srcdent LIKE srcd_t.srcdent, #企业编号
       srcdsite LIKE srcd_t.srcdsite, #营运据点
       srcd000 LIKE srcd_t.srcd000, #类型
       srcd001 LIKE srcd_t.srcd001, #生产计划
       srcd002 LIKE srcd_t.srcd002, #工艺编号
       srcd004 LIKE srcd_t.srcd004, #料件编号
       srcd005 LIKE srcd_t.srcd005, #BOM特性
       srcd006 LIKE srcd_t.srcd006, #产品特征
       srcd007 LIKE srcd_t.srcd007, #项次
       srcdseq LIKE srcd_t.srcdseq, #项序
       srcd008 LIKE srcd_t.srcd008, #Check in/Check out
       srcd009 LIKE srcd_t.srcd009, #项目
       srcd010 LIKE srcd_t.srcd010, #形态
       srcd011 LIKE srcd_t.srcd011, #下限
       srcd012 LIKE srcd_t.srcd012, #上限
       srcd013 LIKE srcd_t.srcd013, #默认值
       srcd014 LIKE srcd_t.srcd014, #必要
       srcd900 LIKE srcd_t.srcd900, #变更序
       srcd901 LIKE srcd_t.srcd901, #变更类型
       srcd902 LIKE srcd_t.srcd902, #变更日期
       srcd905 LIKE srcd_t.srcd905, #变更理由
       srcd906 LIKE srcd_t.srcd906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   DECLARE asrt801_gen_srcd_curs CURSOR FOR
#    SELECT * FROM srad_t WHERE sradent = g_enterprise AND sradsite = g_site #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT sradent,sradsite,srad001,srad002,srad004,srad005,srad006,srad007,
           sradseq,srad008,srad009,srad010,srad011,srad012,srad013,srad014 
      FROM srad_t WHERE sradent = g_enterprise AND sradsite = g_site
    #161124-00048#12 add(e)
       AND srad001 = g_srca_m.srca001 AND srad002 = g_srca_m.srca002
       AND srad004 = g_srca_m.srca004 AND srad005 = g_srca_m.srca005
       AND srad006 = g_srca_m.srca006
     ORDER BY srad007
   FOREACH asrt801_gen_srcd_curs INTO l_srad.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_srcd.srcdent  = g_enterprise
      LET l_srcd.srcdsite = g_site
      LET l_srcd.srcd000  = g_srca_m.srca000
      LET l_srcd.srcd001  = l_srad.srad001
      LET l_srcd.srcd002  = l_srad.srad002
      LET l_srcd.srcd004  = l_srad.srad004
      LET l_srcd.srcd005  = l_srad.srad005
      LET l_srcd.srcd006  = l_srad.srad006
      LET l_srcd.srcd007  = l_srad.srad007
      LET l_srcd.srcdseq  = l_srad.sradseq
      LET l_srcd.srcd008  = l_srad.srad008
      LET l_srcd.srcd009  = l_srad.srad009
      LET l_srcd.srcd010  = l_srad.srad010
      LET l_srcd.srcd011  = l_srad.srad011
      LET l_srcd.srcd012  = l_srad.srad012
      LET l_srcd.srcd013  = l_srad.srad013
      LET l_srcd.srcd014  = l_srad.srad014
      LET l_srcd.srcd900  = g_srca_m.srca900
      LET l_srcd.srcd901  = '1'
      
#      INSERT INTO srcd_t VALUES l_srcd.*  #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srcd_t(srcdent,srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,srcd006,
                         srcd007,srcdseq,srcd008,srcd009,srcd010,srcd011,srcd012,srcd013,
                         srcd014,srcd900,srcd901,srcd902,srcd905,srcd906) 
                  VALUES(l_srcd.srcdent,l_srcd.srcdsite,l_srcd.srcd000,l_srcd.srcd001,l_srcd.srcd002,l_srcd.srcd004,l_srcd.srcd005,l_srcd.srcd006,
                         l_srcd.srcd007,l_srcd.srcdseq,l_srcd.srcd008,l_srcd.srcd009,l_srcd.srcd010,l_srcd.srcd011,l_srcd.srcd012,l_srcd.srcd013,
                         l_srcd.srcd014,l_srcd.srcd900,l_srcd.srcd901,l_srcd.srcd902,l_srcd.srcd905,l_srcd.srcd906)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT srcd_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_srad.* TO NULL   #清空数组
      INITIALIZE l_srcd.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#产生重复性生产变更单多上站资料，srce_t
PRIVATE FUNCTION asrt801_gen_srce()
DEFINE r_success                 LIKE type_t.num5
#DEFINE l_srae                    RECORD LIKE srae_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srae RECORD  #重覆性生產計畫製程上站作業檔
       sraeent LIKE srae_t.sraeent, #企业编号
       sraesite LIKE srae_t.sraesite, #营运据点
       srae001 LIKE srae_t.srae001, #生产计划
       srae002 LIKE srae_t.srae002, #工艺编号
       srae004 LIKE srae_t.srae004, #料件编号
       srae005 LIKE srae_t.srae005, #BOM特性
       srae006 LIKE srae_t.srae006, #产品特征
       srae007 LIKE srae_t.srae007, #项次
       sraeseq LIKE srae_t.sraeseq, #项序
       srae008 LIKE srae_t.srae008, #上站作业
       srae009 LIKE srae_t.srae009  #上站制进程
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srce                    RECORD LIKE srce_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srce RECORD  #重複性生產計劃製程上站作業變更檔
       srceent LIKE srce_t.srceent, #企业编号
       srcesite LIKE srce_t.srcesite, #营运据点
       srce000 LIKE srce_t.srce000, #类型
       srce001 LIKE srce_t.srce001, #生产计划
       srce002 LIKE srce_t.srce002, #工艺编号
       srce004 LIKE srce_t.srce004, #料件编号
       srce005 LIKE srce_t.srce005, #BOM特性
       srce006 LIKE srce_t.srce006, #产品特征
       srce007 LIKE srce_t.srce007, #项次
       srceseq LIKE srce_t.srceseq, #项序
       srce008 LIKE srce_t.srce008, #上站作业
       srce009 LIKE srce_t.srce009, #上站作业序
       srce900 LIKE srce_t.srce900, #变更序
       srce901 LIKE srce_t.srce901, #变更类型
       srce902 LIKE srce_t.srce902, #变更日期
       srce905 LIKE srce_t.srce905, #变更理由
       srce906 LIKE srce_t.srce906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   DECLARE asrt801_gen_srce_curs CURSOR FOR
#    SELECT * FROM srae_t WHERE sraeent = g_enterprise AND sraesite = g_site  #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT sraeent,sraesite,srae001,srae002,srae004,srae005,srae006,
           srae007,sraeseq,srae008,srae009 
      FROM srae_t WHERE sraeent = g_enterprise AND sraesite = g_site 
    #161124-00048#12 add(e)
       AND srae001 = g_srca_m.srca001 AND srae002 = g_srca_m.srca002
       AND srae004 = g_srca_m.srca004 AND srae005 = g_srca_m.srca005
       AND srae006 = g_srca_m.srca006
     ORDER BY srae007,sraeseq
   FOREACH asrt801_gen_srce_curs INTO l_srae.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      LET l_srce.srceent  = g_enterprise
      LET l_srce.srcesite = g_site
      LET l_srce.srce000  = g_srca_m.srca000
      LET l_srce.srce001  = l_srae.srae001
      LET l_srce.srce002  = l_srae.srae002
      LET l_srce.srce004  = l_srae.srae004
      LET l_srce.srce005  = l_srae.srae005
      LET l_srce.srce006  = l_srae.srae006
      LET l_srce.srce007  = l_srae.srae007
      LET l_srce.srceseq  = l_srae.sraeseq
      LET l_srce.srce008  = l_srae.srae008
      LET l_srce.srce009  = l_srae.srae009
      LET l_srce.srce900  = g_srca_m.srca900
      LET l_srce.srce901  = '1'
      
#      INSERT INTO srce_t VALUES l_srce.*  #161124-00048#12 mark
      #161124-00048#12 add(s)
      INSERT INTO srce_t(srceent,srcesite,srce000,srce001,srce002,srce004,srce005,
                         srce006,srce007,srceseq,srce008,srce009,srce900,srce901,
                         srce902,srce905,srce906) 
                  VALUES(l_srce.srceent,l_srce.srcesite,l_srce.srce000,l_srce.srce001,l_srce.srce002,l_srce.srce004,l_srce.srce005,
                         l_srce.srce006,l_srce.srce007,l_srce.srceseq,l_srce.srce008,l_srce.srce009,l_srce.srce900,l_srce.srce901,
                         l_srce.srce902,l_srce.srce905,l_srce.srce906)
      #161124-00048#12 add(e)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT srce_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
      INITIALIZE l_srae.* TO NULL   #清空数组
      INITIALIZE l_srce.* TO NULL   #清空数组
   END FOREACH
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#单身ref栏位显示
PRIVATE FUNCTION asrt801_b_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc008
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc012
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc012_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srca_m.srcasite
   LET g_ref_fields[2] = g_srcc_d[l_ac].srcc016
   CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc016_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc016_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc037
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc037_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc037_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc027
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc027_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc046
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc046_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc046_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_srcc_d[l_ac].srcc905
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_srcc_d[l_ac].srcc905_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_srcc_d[l_ac].srcc905_desc
END FUNCTION

#预设本站作业序
PRIVATE FUNCTION asrt801_def_srcc009()
DEFINE l_srcc009    LIKE srcc_t.srcc009
DEFINE l_srcc009_1  LIKE type_t.num5

   SELECT MAX(srcc009) INTO l_srcc009 FROM srcc_t
    WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
      AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
      AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
      AND srcc008 = g_srcc_d[l_ac].srcc008 AND srcc901 != '4'
   LET l_srcc009_1 = l_srcc009
   LET l_srcc009_1 = l_srcc009_1 + 1
   LET g_srcc_d[l_ac].srcc009 = l_srcc009_1
   IF cl_null(g_srcc_d[l_ac].srcc009) THEN
      LET g_srcc_d[l_ac].srcc009 = 1
   END IF
   DISPLAY BY NAME g_srcc_d[l_ac].srcc009
END FUNCTION

#本站作业、作业序检查
PRIVATE FUNCTION asrt801_chk_srcc008(p_cmd)
DEFINE p_cmd         LIKE type_t.chr1
DEFINE r_success     LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5

   LET r_success = FALSE
   LET l_n = 0
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n FROM srcc_t
       WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
         AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
         AND srcc008 = g_srcc_d[l_ac].srcc008 AND srcc009 = g_srcc_d[l_ac].srcc009 
         AND srcc901 != '4'
   ELSE
      SELECT COUNT(*) INTO l_n FROM srcc_t
       WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
         AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
         AND srcc008 = g_srcc_d[l_ac].srcc008 AND srcc009 = g_srcc_d[l_ac].srcc009
         AND srcc007!= g_srcc_d_t.srcc007
         AND srcc901 != '4'
   END IF
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aec-00006'
      LET g_errparam.extend = g_srcc_d[l_ac].srcc008
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#上站作业、作业序检查
PRIVATE FUNCTION asrt801_chk_srcc012(p_cmd)
DEFINE p_cmd         LIKE type_t.chr1
DEFINE r_success     LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5

   LET r_success = FALSE
   LET l_n = 0
   IF g_srcc_d[l_ac].srcc012 = 'INIT' OR g_srcc_d[l_ac].srcc012 = 'MULT' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   SELECT COUNT(*) INTO l_n FROM srcc_t
    WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
      AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
      AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
      AND srcc011 = g_srcc_d[l_ac].srcc012
      AND srcc901 != '4'
   IF l_n > 0 THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   
   IF p_cmd = 'a' THEN
      SELECT COUNT(*) INTO l_n FROM srcc_t
       WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
         AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
         AND srcc008 = g_srcc_d[l_ac].srcc012 AND srcc009 = g_srcc_d[l_ac].srcc013
         AND srcc901 != '4'
   ELSE
      SELECT COUNT(*) INTO l_n FROM srcc_t
       WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001 AND srcc002 = g_srca_m.srca002 AND srcc004 = g_srca_m.srca004 
         AND srcc005 = g_srca_m.srca005 AND srcc006 = g_srca_m.srca006 AND srcc900 = g_srca_m.srca900
         AND srcc008 = g_srcc_d[l_ac].srcc012 AND srcc009 = g_srcc_d[l_ac].srcc013
         AND srcc007!= g_srcc_d_t.srcc007
         AND srcc901 != '4'
   END IF
   IF l_n = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aec-00007'
      LET g_errparam.extend = g_srcc_d[l_ac].srcc012
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#单身制程变更写入变更历程档
PRIVATE FUNCTION asrt801_upd_srcc_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007)
DEFINE p_srcf000                       LIKE srcf_t.srcf000
DEFINE p_srcf001                       LIKE srcf_t.srcf001
DEFINE p_srcf002                       LIKE srcf_t.srcf002
DEFINE p_srcf003                       LIKE srcf_t.srcf003
DEFINE p_srcf004                       LIKE srcf_t.srcf004
DEFINE p_srcf005                       LIKE srcf_t.srcf005
DEFINE p_srcf006                       LIKE srcf_t.srcf006
DEFINE p_srcfseq                       LIKE srcf_t.srcfseq
DEFINE p_srcf007                       LIKE srcf_t.srcf007
DEFINE r_success                       LIKE type_t.num5
DEFINE l_flag                          LIKE type_t.chr1
#DEFINE l_srac                    RECORD LIKE srac_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srac RECORD  #重覆性生產計畫製程檔
       sracent LIKE srac_t.sracent, #企业编号
       sracsite LIKE srac_t.sracsite, #营运据点
       srac001 LIKE srac_t.srac001, #生产计划
       srac002 LIKE srac_t.srac002, #工艺编号
       srac004 LIKE srac_t.srac004, #料件编号
       srac005 LIKE srac_t.srac005, #BOM特性
       srac006 LIKE srac_t.srac006, #产品特征
       srac007 LIKE srac_t.srac007, #项次
       srac008 LIKE srac_t.srac008, #本站作业编号
       srac009 LIKE srac_t.srac009, #作业序
       srac010 LIKE srac_t.srac010, #群组性质
       srac011 LIKE srac_t.srac011, #群组
       srac012 LIKE srac_t.srac012, #上站作业
       srac013 LIKE srac_t.srac013, #上站制进程
       srac014 LIKE srac_t.srac014, #下站作业
       srac015 LIKE srac_t.srac015, #下站制进程
       srac016 LIKE srac_t.srac016, #工作站
       srac017 LIKE srac_t.srac017, #固定工时
       srac018 LIKE srac_t.srac018, #标准工时
       srac019 LIKE srac_t.srac019, #固定机时
       srac020 LIKE srac_t.srac020, #标准机时
       srac021 LIKE srac_t.srac021, #Move in
       srac022 LIKE srac_t.srac022, #Check in
       srac023 LIKE srac_t.srac023, #报工站
       srac024 LIKE srac_t.srac024, #PQC
       srac025 LIKE srac_t.srac025, #Check out
       srac026 LIKE srac_t.srac026, #Move out
       srac027 LIKE srac_t.srac027, #转出单位
       srac028 LIKE srac_t.srac028, #转出单位转换率分子
       srac029 LIKE srac_t.srac029, #转出单位转换率分母
       srac030 LIKE srac_t.srac030, #待Movie in 数
       srac031 LIKE srac_t.srac031, #待Check in数
       srac032 LIKE srac_t.srac032, #在制数
       srac033 LIKE srac_t.srac033, #待PQC数
       srac034 LIKE srac_t.srac034, #待Check out数
       srac035 LIKE srac_t.srac035, #待Move out数
       srac036 LIKE srac_t.srac036, #委外
       srac037 LIKE srac_t.srac037, #委外供应商
       srac038 LIKE srac_t.srac038, #良品转入
       srac039 LIKE srac_t.srac039, #返工转入
       srac040 LIKE srac_t.srac040, #良品转出
       srac041 LIKE srac_t.srac041, #返工转出
       srac042 LIKE srac_t.srac042, #当站报废
       srac043 LIKE srac_t.srac043, #当站下线
       srac044 LIKE srac_t.srac044, #委外数量
       srac045 LIKE srac_t.srac045, #委外完工数量
       srac046 LIKE srac_t.srac046, #转入单位
       srac047 LIKE srac_t.srac047, #转入单位转换率分子
       srac048 LIKE srac_t.srac048  #转入单位转换率分母
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srcc                    RECORD LIKE srcc_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcc RECORD  #重複性生產計劃製程變更檔
       srccent LIKE srcc_t.srccent, #企业编号
       srccsite LIKE srcc_t.srccsite, #营运据点
       srcc000 LIKE srcc_t.srcc000, #类型
       srcc001 LIKE srcc_t.srcc001, #生产计划
       srcc002 LIKE srcc_t.srcc002, #工艺编号
       srcc004 LIKE srcc_t.srcc004, #料件编号
       srcc005 LIKE srcc_t.srcc005, #BOM特性
       srcc006 LIKE srcc_t.srcc006, #产品特征
       srcc007 LIKE srcc_t.srcc007, #项次
       srcc008 LIKE srcc_t.srcc008, #本站作业编号
       srcc009 LIKE srcc_t.srcc009, #作业序
       srcc010 LIKE srcc_t.srcc010, #群组性质
       srcc011 LIKE srcc_t.srcc011, #群组
       srcc012 LIKE srcc_t.srcc012, #上站作业
       srcc013 LIKE srcc_t.srcc013, #上站作业序
       srcc014 LIKE srcc_t.srcc014, #下站作业
       srcc015 LIKE srcc_t.srcc015, #下站作业序
       srcc016 LIKE srcc_t.srcc016, #工作站
       srcc017 LIKE srcc_t.srcc017, #固定工时
       srcc018 LIKE srcc_t.srcc018, #标准工时
       srcc019 LIKE srcc_t.srcc019, #固定机时
       srcc020 LIKE srcc_t.srcc020, #标准机时
       srcc021 LIKE srcc_t.srcc021, #Move in
       srcc022 LIKE srcc_t.srcc022, #Check in
       srcc023 LIKE srcc_t.srcc023, #报工站
       srcc024 LIKE srcc_t.srcc024, #PQC
       srcc025 LIKE srcc_t.srcc025, #Check out
       srcc026 LIKE srcc_t.srcc026, #Move out
       srcc027 LIKE srcc_t.srcc027, #转出单位
       srcc028 LIKE srcc_t.srcc028, #单位转换率分子
       srcc029 LIKE srcc_t.srcc029, #单位转换率分母
       srcc030 LIKE srcc_t.srcc030, #待Move in数
       srcc031 LIKE srcc_t.srcc031, #待Check in数
       srcc032 LIKE srcc_t.srcc032, #在制数
       srcc033 LIKE srcc_t.srcc033, #待PQC数
       srcc034 LIKE srcc_t.srcc034, #待Check out数
       srcc035 LIKE srcc_t.srcc035, #待Move out数
       srcc036 LIKE srcc_t.srcc036, #委外
       srcc037 LIKE srcc_t.srcc037, #委外供应商
       srcc038 LIKE srcc_t.srcc038, #良品转入
       srcc039 LIKE srcc_t.srcc039, #返工转入
       srcc040 LIKE srcc_t.srcc040, #良品转出
       srcc041 LIKE srcc_t.srcc041, #返工转出
       srcc042 LIKE srcc_t.srcc042, #当站报废
       srcc043 LIKE srcc_t.srcc043, #当站下线
       srcc044 LIKE srcc_t.srcc044, #委外数量
       srcc045 LIKE srcc_t.srcc045, #委外完工数量
       srcc046 LIKE srcc_t.srcc046, #转入单位
       srcc047 LIKE srcc_t.srcc047, #转入单位转换率分子
       srcc048 LIKE srcc_t.srcc048, #转入单位转换率分母
       srcc900 LIKE srcc_t.srcc900, #变更序
       srcc901 LIKE srcc_t.srcc901, #变更类型
       srcc902 LIKE srcc_t.srcc902, #变更日期
       srcc905 LIKE srcc_t.srcc905, #变更理由
       srcc906 LIKE srcc_t.srcc906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   LET l_flag = 'N'
   
   IF p_srcf000 IS NULL OR p_srcf001 IS NULL OR p_srcf002 IS NULL OR p_srcf003 IS NULL OR p_srcf004 IS NULL OR p_srcf005 IS NULL OR p_srcf006 IS NULL OR p_srcfseq IS NULL OR p_srcf007 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_srac.* TO NULL
   INITIALIZE l_srcc.* TO NULL
   
#   SELECT * INTO l_srcc.* FROM srcc_t  #161124-00048#12 mark
    #161124-00048#12 add(s)
   SELECT srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,
          srcc006,srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,
          srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,
          srcc020,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,
          srcc027,srcc028,srcc029,srcc030,srcc031,srcc032,srcc033,
          srcc034,srcc035,srcc036,srcc037,srcc038,srcc039,srcc040,
          srcc041,srcc042,srcc043,srcc044,srcc045,srcc046,srcc047,
          srcc048,srcc900,srcc901,srcc902,srcc905,srcc906 
     INTO l_srcc.* FROM srcc_t 
    #161124-00048#12 add(e)
    WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = p_srcf000 AND srcc001 = p_srcf001
      AND srcc002 = p_srcf002 AND srcc004 = p_srcf003 AND srcc005 = p_srcf004 AND srcc006 = p_srcf005
      AND srcc007 = p_srcf006 AND srcc900 = p_srcf007
   IF l_srcc.srcc901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF l_srcc.srcc901 = '2' OR l_srcc.srcc901 = '4' THEN
#      SELECT * INTO l_srac.* FROM srac_t #161124-00048#12 mark
      #161124-00048#12 add(s)
      SELECT sracent,sracsite,srac001,srac002,srac004,srac005,srac006,srac007,
           srac008,srac009,srac010,srac011,srac012,srac013,srac014,srac015,srac016,
           srac017,srac018,srac019,srac020,srac021,srac022,srac023,srac024,srac025,
           srac026,srac027,srac028,srac029,srac030,srac031,srac032,srac033,srac034,
           srac035,srac036,srac037,srac038,srac039,srac040,srac041,srac042,srac043,
           srac044,srac045,srac046,srac047,srac048 INTO l_srac.* FROM srac_t
      #161124-00048#12 add(e)
       WHERE sracent = g_enterprise AND sracsite = g_site AND srac001 = p_srcf001
         AND srac002 = p_srcf002 AND srac004 = p_srcf003 AND srac005 = p_srcf004 
         AND srac006 = p_srcf005 AND srac007 = p_srcf006
   END IF
   
   LET g_srcf009 = ''
   IF l_srcc.srcc901 = '2' THEN
      LET g_srcf009 = '1'
   END IF
   IF l_srcc.srcc901 = '3' THEN
      LET g_srcf009 = '2'
   END IF
   IF l_srcc.srcc901 = '4' THEN
      INITIALIZE l_srcc.* TO NULL
      LET g_srcf009 = '3'
   END IF
   
   #项次
   IF (NOT cl_null(l_srcc.srcc007) AND (cl_null(l_srac.srac007) OR l_srcc.srcc007 != l_srac.srac007)) OR (cl_null(l_srcc.srcc007) AND NOT cl_null(l_srac.srac007)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac007',g_srcf009,l_srac.srac007,l_srcc.srcc007,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac007') THEN
         RETURN r_success
      END IF
   END IF
   
   #本站作业
   IF (NOT cl_null(l_srcc.srcc008) AND (cl_null(l_srac.srac008) OR l_srcc.srcc008 != l_srac.srac008)) OR (cl_null(l_srcc.srcc008) AND NOT cl_null(l_srac.srac008)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_srac.srac008||"' AND oocql003=? "
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac008',g_srcf009,l_srac.srac008,l_srcc.srcc008,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac008') THEN
         RETURN r_success
      END IF
   END IF
   
   #作业序
   IF (NOT cl_null(l_srcc.srcc009) AND (cl_null(l_srac.srac009) OR l_srcc.srcc009 != l_srac.srac009)) OR (cl_null(l_srcc.srcc009) AND NOT cl_null(l_srac.srac009)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac009',g_srcf009,l_srac.srac009,l_srcc.srcc009,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac009') THEN
         RETURN r_success
      END IF
   END IF
   
   #群组性质
   IF (NOT cl_null(l_srcc.srcc010) AND (cl_null(l_srac.srac010) OR l_srcc.srcc010 != l_srac.srac010)) OR (cl_null(l_srcc.srcc010) AND NOT cl_null(l_srac.srac010)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac010',g_srcf009,l_srac.srac010,l_srcc.srcc010,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac010') THEN
         RETURN r_success
      END IF
   END IF
   
   #群组
   IF (NOT cl_null(l_srcc.srcc011) AND (cl_null(l_srac.srac011) OR l_srcc.srcc011 != l_srac.srac011)) OR (cl_null(l_srcc.srcc011) AND NOT cl_null(l_srac.srac011)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac011',g_srcf009,l_srac.srac011,l_srcc.srcc011,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac011') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业
   IF (NOT cl_null(l_srcc.srcc012) AND (cl_null(l_srac.srac012) OR l_srcc.srcc012 != l_srac.srac012)) OR (cl_null(l_srcc.srcc012) AND NOT cl_null(l_srac.srac012)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_srac.srac012||"' AND oocql003=? "
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac012',g_srcf009,l_srac.srac012,l_srcc.srcc012,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac012') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业序
   IF (NOT cl_null(l_srcc.srcc013) AND (cl_null(l_srac.srac013) OR l_srcc.srcc013 != l_srac.srac013)) OR (cl_null(l_srcc.srcc013) AND NOT cl_null(l_srac.srac013)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac013',g_srcf009,l_srac.srac013,l_srcc.srcc013,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac013') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业
   IF (NOT cl_null(l_srcc.srcc014) AND (cl_null(l_srac.srac014) OR l_srcc.srcc014 != l_srac.srac014)) OR (cl_null(l_srcc.srcc014) AND NOT cl_null(l_srac.srac014)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_srac.srac014||"' AND oocql003=? "
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac014',g_srcf009,l_srac.srac014,l_srcc.srcc014,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac014') THEN
         RETURN r_success
      END IF
   END IF
   
   #下站作业序
   IF (NOT cl_null(l_srcc.srcc015) AND (cl_null(l_srac.srac015) OR l_srcc.srcc015 != l_srac.srac015)) OR (cl_null(l_srcc.srcc015) AND NOT cl_null(l_srac.srac015)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac015',g_srcf009,l_srac.srac015,l_srcc.srcc015,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac015') THEN
         RETURN r_success
      END IF
   END IF
   
   #工作站
   IF (NOT cl_null(l_srcc.srcc016) AND (cl_null(l_srac.srac016) OR l_srcc.srcc016 != l_srac.srac016)) OR (cl_null(l_srcc.srcc016) AND NOT cl_null(l_srac.srac016)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite='"||g_site||"' AND ecaa001='"||l_srac.srac016||"'"
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac016',g_srcf009,l_srac.srac016,l_srcc.srcc016,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac016') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定工时
   IF (NOT cl_null(l_srcc.srcc017) AND (cl_null(l_srac.srac017) OR l_srcc.srcc017 != l_srac.srac017)) OR (cl_null(l_srcc.srcc017) AND NOT cl_null(l_srac.srac017)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac017',g_srcf009,l_srac.srac017,l_srcc.srcc017,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac017') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准工时
   IF (NOT cl_null(l_srcc.srcc018) AND (cl_null(l_srac.srac018) OR l_srcc.srcc018 != l_srac.srac018)) OR (cl_null(l_srcc.srcc018) AND NOT cl_null(l_srac.srac018)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac018',g_srcf009,l_srac.srac018,l_srcc.srcc018,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac018') THEN
         RETURN r_success
      END IF
   END IF
   
   #固定机时
   IF (NOT cl_null(l_srcc.srcc019) AND (cl_null(l_srac.srac019) OR l_srcc.srcc019 != l_srac.srac019)) OR (cl_null(l_srcc.srcc019) AND NOT cl_null(l_srac.srac019)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac019',g_srcf009,l_srac.srac019,l_srcc.srcc019,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac019') THEN
         RETURN r_success
      END IF
   END IF
   
   #标准机时
   IF (NOT cl_null(l_srcc.srcc020) AND (cl_null(l_srac.srac020) OR l_srcc.srcc020 != l_srac.srac020)) OR (cl_null(l_srcc.srcc020) AND NOT cl_null(l_srac.srac020)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac020',g_srcf009,l_srac.srac020,l_srcc.srcc020,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac020') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外
   IF (NOT cl_null(l_srcc.srcc036) AND (cl_null(l_srac.srac036) OR l_srcc.srcc036 != l_srac.srac036)) OR (cl_null(l_srcc.srcc036) AND NOT cl_null(l_srac.srac036)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac036',g_srcf009,l_srac.srac036,l_srcc.srcc036,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac036') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外厂商
   IF (NOT cl_null(l_srcc.srcc037) AND (cl_null(l_srac.srac037) OR l_srcc.srcc037 != l_srac.srac037)) OR (cl_null(l_srcc.srcc037) AND NOT cl_null(l_srac.srac037)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001='"||l_srac.srac037||"' AND pmaal002=?"
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac037',g_srcf009,l_srac.srac037,l_srcc.srcc037,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac037') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move in
   IF (NOT cl_null(l_srcc.srcc021) AND (cl_null(l_srac.srac021) OR l_srcc.srcc021 != l_srac.srac021)) OR (cl_null(l_srcc.srcc021) AND NOT cl_null(l_srac.srac021)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac021',g_srcf009,l_srac.srac021,l_srcc.srcc021,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac021') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check in
   IF (NOT cl_null(l_srcc.srcc022) AND (cl_null(l_srac.srac022) OR l_srcc.srcc022 != l_srac.srac022)) OR (cl_null(l_srcc.srcc022) AND NOT cl_null(l_srac.srac022)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac022',g_srcf009,l_srac.srac022,l_srcc.srcc022,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac022') THEN
         RETURN r_success
      END IF
   END IF
   
   #报工站
   IF (NOT cl_null(l_srcc.srcc023) AND (cl_null(l_srac.srac023) OR l_srcc.srcc023 != l_srac.srac023)) OR (cl_null(l_srcc.srcc023) AND NOT cl_null(l_srac.srac023)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac023',g_srcf009,l_srac.srac023,l_srcc.srcc023,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac023') THEN
         RETURN r_success
      END IF
   END IF
   
   #PQC
   IF (NOT cl_null(l_srcc.srcc024) AND (cl_null(l_srac.srac024) OR l_srcc.srcc024 != l_srac.srac024)) OR (cl_null(l_srcc.srcc024) AND NOT cl_null(l_srac.srac024)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac024',g_srcf009,l_srac.srac024,l_srcc.srcc024,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac024') THEN
         RETURN r_success
      END IF
   END IF
   
   #Check out
   IF (NOT cl_null(l_srcc.srcc025) AND (cl_null(l_srac.srac025) OR l_srcc.srcc025 != l_srac.srac025)) OR (cl_null(l_srcc.srcc025) AND NOT cl_null(l_srac.srac025)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac025',g_srcf009,l_srac.srac025,l_srcc.srcc025,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac025') THEN
         RETURN r_success
      END IF
   END IF
   
   #Move out
   IF (NOT cl_null(l_srcc.srcc026) AND (cl_null(l_srac.srac026) OR l_srcc.srcc026 != l_srac.srac026)) OR (cl_null(l_srcc.srcc026) AND NOT cl_null(l_srac.srac026)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac026',g_srcf009,l_srac.srac026,l_srcc.srcc026,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac026') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位
   IF (NOT cl_null(l_srcc.srcc046) AND (cl_null(l_srac.srac046) OR l_srcc.srcc046 != l_srac.srac046)) OR (cl_null(l_srcc.srcc046) AND NOT cl_null(l_srac.srac046)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_srac.srac046||"' AND oocal002=?"
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac046',g_srcf009,l_srac.srac046,l_srcc.srcc046,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac046') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分子
   IF (NOT cl_null(l_srcc.srcc047) AND (cl_null(l_srac.srac047) OR l_srcc.srcc047 != l_srac.srac047)) OR (cl_null(l_srcc.srcc047) AND NOT cl_null(l_srac.srac047)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac047',g_srcf009,l_srac.srac047,l_srcc.srcc047,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac047') THEN
         RETURN r_success
      END IF
   END IF
   
   #转入单位转换率分母
   IF (NOT cl_null(l_srcc.srcc048) AND (cl_null(l_srac.srac048) OR l_srcc.srcc048 != l_srac.srac048)) OR (cl_null(l_srcc.srcc048) AND NOT cl_null(l_srac.srac048)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac048',g_srcf009,l_srac.srac048,l_srcc.srcc048,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac048') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位
   IF (NOT cl_null(l_srcc.srcc027) AND (cl_null(l_srac.srac027) OR l_srcc.srcc027 != l_srac.srac027)) OR (cl_null(l_srcc.srcc027) AND NOT cl_null(l_srac.srac027)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001='"||l_srac.srac027||"' AND oocal002=?"
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac027',g_srcf009,l_srac.srac027,l_srcc.srcc027,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac027') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分子
   IF (NOT cl_null(l_srcc.srcc028) AND (cl_null(l_srac.srac028) OR l_srcc.srcc028 != l_srac.srac028)) OR (cl_null(l_srcc.srcc028) AND NOT cl_null(l_srac.srac028)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac028',g_srcf009,l_srac.srac028,l_srcc.srcc028,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac028') THEN
         RETURN r_success
      END IF
   END IF
   
   #转出单位转换率分母
   IF (NOT cl_null(l_srcc.srcc029) AND (cl_null(l_srac.srac029) OR l_srcc.srcc029 != l_srac.srac029)) OR (cl_null(l_srcc.srcc029) AND NOT cl_null(l_srac.srac029)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac029',g_srcf009,l_srac.srac029,l_srcc.srcc029,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac029') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Move in数
   IF (NOT cl_null(l_srcc.srcc030) AND (cl_null(l_srac.srac030) OR l_srcc.srcc030 != l_srac.srac030)) OR (cl_null(l_srcc.srcc030) AND NOT cl_null(l_srac.srac030)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac030',g_srcf009,l_srac.srac030,l_srcc.srcc030,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac030') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Check in数
   IF (NOT cl_null(l_srcc.srcc031) AND (cl_null(l_srac.srac031) OR l_srcc.srcc031 != l_srac.srac031)) OR (cl_null(l_srcc.srcc031) AND NOT cl_null(l_srac.srac031)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac031',g_srcf009,l_srac.srac031,l_srcc.srcc031,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac031') THEN
         RETURN r_success
      END IF
   END IF
   
   #在制数
   IF (NOT cl_null(l_srcc.srcc032) AND (cl_null(l_srac.srac032) OR l_srcc.srcc032 != l_srac.srac032)) OR (cl_null(l_srcc.srcc032) AND NOT cl_null(l_srac.srac032)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac032',g_srcf009,l_srac.srac032,l_srcc.srcc032,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac032') THEN
         RETURN r_success
      END IF
   END IF
   
   #待PQC数
   IF (NOT cl_null(l_srcc.srcc033) AND (cl_null(l_srac.srac033) OR l_srcc.srcc033 != l_srac.srac033)) OR (cl_null(l_srcc.srcc033) AND NOT cl_null(l_srac.srac033)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac033',g_srcf009,l_srac.srac033,l_srcc.srcc033,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac033') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Check out数
   IF (NOT cl_null(l_srcc.srcc034) AND (cl_null(l_srac.srac034) OR l_srcc.srcc034 != l_srac.srac034)) OR (cl_null(l_srcc.srcc034) AND NOT cl_null(l_srac.srac034)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac034',g_srcf009,l_srac.srac034,l_srcc.srcc034,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac034') THEN
         RETURN r_success
      END IF
   END IF
   
   #待Move out数
   IF (NOT cl_null(l_srcc.srcc035) AND (cl_null(l_srac.srac035) OR l_srcc.srcc035 != l_srac.srac035)) OR (cl_null(l_srcc.srcc035) AND NOT cl_null(l_srac.srac035)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac035',g_srcf009,l_srac.srac035,l_srcc.srcc035,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac035') THEN
         RETURN r_success
      END IF
   END IF
   
   #良品轉入
   IF (NOT cl_null(l_srcc.srcc038) AND (cl_null(l_srac.srac038) OR l_srcc.srcc038 != l_srac.srac038)) OR (cl_null(l_srcc.srcc038) AND NOT cl_null(l_srac.srac038)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac038',g_srcf009,l_srac.srac038,l_srcc.srcc038,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac038') THEN
         RETURN r_success
      END IF
   END IF
   
   #重工轉入
   IF (NOT cl_null(l_srcc.srcc039) AND (cl_null(l_srac.srac039) OR l_srcc.srcc039 != l_srac.srac039)) OR (cl_null(l_srcc.srcc039) AND NOT cl_null(l_srac.srac039)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac039',g_srcf009,l_srac.srac039,l_srcc.srcc039,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac039') THEN
         RETURN r_success
      END IF
   END IF
   
   #良品轉出
   IF (NOT cl_null(l_srcc.srcc040) AND (cl_null(l_srac.srac040) OR l_srcc.srcc040 != l_srac.srac040)) OR (cl_null(l_srcc.srcc040) AND NOT cl_null(l_srac.srac040)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac040',g_srcf009,l_srac.srac040,l_srcc.srcc040,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac040') THEN
         RETURN r_success
      END IF
   END IF
   
   #重工轉出
   IF (NOT cl_null(l_srcc.srcc041) AND (cl_null(l_srac.srac041) OR l_srcc.srcc041 != l_srac.srac041)) OR (cl_null(l_srcc.srcc041) AND NOT cl_null(l_srac.srac041)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac041',g_srcf009,l_srac.srac041,l_srcc.srcc041,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac041') THEN
         RETURN r_success
      END IF
   END IF
   
   #當站報廢
   IF (NOT cl_null(l_srcc.srcc042) AND (cl_null(l_srac.srac042) OR l_srcc.srcc042 != l_srac.srac042)) OR (cl_null(l_srcc.srcc042) AND NOT cl_null(l_srac.srac042)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac042',g_srcf009,l_srac.srac042,l_srcc.srcc042,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac042') THEN
         RETURN r_success
      END IF
   END IF
   
   #當站下線
   IF (NOT cl_null(l_srcc.srcc043) AND (cl_null(l_srac.srac043) OR l_srcc.srcc043 != l_srac.srac043)) OR (cl_null(l_srcc.srcc043) AND NOT cl_null(l_srac.srac043)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac043',g_srcf009,l_srac.srac043,l_srcc.srcc043,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac043') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外數量
   IF (NOT cl_null(l_srcc.srcc044) AND (cl_null(l_srac.srac044) OR l_srcc.srcc044 != l_srac.srac044)) OR (cl_null(l_srcc.srcc044) AND NOT cl_null(l_srac.srac044)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac044',g_srcf009,l_srac.srac044,l_srcc.srcc044,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac044') THEN
         RETURN r_success
      END IF
   END IF
   
   #委外完工數量
   IF (NOT cl_null(l_srcc.srcc045) AND (cl_null(l_srac.srac045) OR l_srcc.srcc045 != l_srac.srac045)) OR (cl_null(l_srcc.srcc045) AND NOT cl_null(l_srac.srac045)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac045',g_srcf009,l_srac.srac045,l_srcc.srcc045,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srac045') THEN
         RETURN r_success
      END IF
   END IF
   
   #制程单身未有发生变更，则更新eccb901
   IF l_flag = 'N' THEN
      UPDATE srcc_t SET srcc901 = '1'
       WHERE srccent = g_enterprise AND srccsite = g_site AND srcc000 = p_srcf000 AND srcc001 = p_srcf001
         AND srcc002 = p_srcf002 AND srcc004 = p_srcf003 AND srcc005 = p_srcf004 AND srcc006 = p_srcf005
         AND srcc007 = p_srcf006 AND srcc900 = p_srcf007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd srcc901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
    
END FUNCTION

#check in/out变更时写入变更历程档
PRIVATE FUNCTION asrt801_upd_srcd_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007)
DEFINE p_srcf000                       LIKE srcf_t.srcf000
DEFINE p_srcf001                       LIKE srcf_t.srcf001
DEFINE p_srcf002                       LIKE srcf_t.srcf002
DEFINE p_srcf003                       LIKE srcf_t.srcf003
DEFINE p_srcf004                       LIKE srcf_t.srcf004
DEFINE p_srcf005                       LIKE srcf_t.srcf005
DEFINE p_srcf006                       LIKE srcf_t.srcf006
DEFINE p_srcfseq                       LIKE srcf_t.srcfseq
DEFINE p_srcf007                       LIKE srcf_t.srcf007
DEFINE r_success                       LIKE type_t.num5
DEFINE l_flag                          LIKE type_t.chr1
#DEFINE l_srad                    RECORD LIKE srad_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srad RECORD  #重覆性生產計畫製程Check in/Check out專案檔
       sradent LIKE srad_t.sradent, #企业编号
       sradsite LIKE srad_t.sradsite, #营运据点
       srad001 LIKE srad_t.srad001, #生产计划
       srad002 LIKE srad_t.srad002, #工艺编号
       srad004 LIKE srad_t.srad004, #料件编号
       srad005 LIKE srad_t.srad005, #BOM特性
       srad006 LIKE srad_t.srad006, #产品特征
       srad007 LIKE srad_t.srad007, #项次
       sradseq LIKE srad_t.sradseq, #项序
       srad008 LIKE srad_t.srad008, #check in/check out
       srad009 LIKE srad_t.srad009, #项目
       srad010 LIKE srad_t.srad010, #型态
       srad011 LIKE srad_t.srad011, #下限
       srad012 LIKE srad_t.srad012, #上限
       srad013 LIKE srad_t.srad013, #默认值
       srad014 LIKE srad_t.srad014  #必要
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srcd                    RECORD LIKE srcd_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcd RECORD  #重複性生產計劃製程Check in/Check out項目變更檔
       srcdent LIKE srcd_t.srcdent, #企业编号
       srcdsite LIKE srcd_t.srcdsite, #营运据点
       srcd000 LIKE srcd_t.srcd000, #类型
       srcd001 LIKE srcd_t.srcd001, #生产计划
       srcd002 LIKE srcd_t.srcd002, #工艺编号
       srcd004 LIKE srcd_t.srcd004, #料件编号
       srcd005 LIKE srcd_t.srcd005, #BOM特性
       srcd006 LIKE srcd_t.srcd006, #产品特征
       srcd007 LIKE srcd_t.srcd007, #项次
       srcdseq LIKE srcd_t.srcdseq, #项序
       srcd008 LIKE srcd_t.srcd008, #Check in/Check out
       srcd009 LIKE srcd_t.srcd009, #项目
       srcd010 LIKE srcd_t.srcd010, #形态
       srcd011 LIKE srcd_t.srcd011, #下限
       srcd012 LIKE srcd_t.srcd012, #上限
       srcd013 LIKE srcd_t.srcd013, #默认值
       srcd014 LIKE srcd_t.srcd014, #必要
       srcd900 LIKE srcd_t.srcd900, #变更序
       srcd901 LIKE srcd_t.srcd901, #变更类型
       srcd902 LIKE srcd_t.srcd902, #变更日期
       srcd905 LIKE srcd_t.srcd905, #变更理由
       srcd906 LIKE srcd_t.srcd906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   LET l_flag = 'N'
   
   IF p_srcf000 IS NULL OR p_srcf001 IS NULL OR p_srcf002 IS NULL OR p_srcf003 IS NULL OR p_srcf004 IS NULL OR p_srcf005 IS NULL OR p_srcf006 IS NULL OR p_srcfseq IS NULL OR p_srcf007 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_srad.* TO NULL
   INITIALIZE l_srcd.* TO NULL
   
#   SELECT * INTO l_srcd.* FROM srcd_t   #161124-00048#12 mark 
   #161124-00048#12 add(s)
   SELECT srcdent,srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,
          srcd006,srcd007,srcdseq,srcd008,srcd009,srcd010,srcd011,
          srcd012,srcd013,srcd014,srcd900,srcd901,srcd902,srcd905,
          srcd906 INTO l_srcd.* FROM srcd_t
   #161124-00048#12 add(e)
    WHERE srcdent = g_enterprise AND srcdsite = g_site AND srcd000 = p_srcf000 AND srcd001 = p_srcf001
      AND srcd002 = p_srcf002 AND srcd004 = p_srcf003 AND srcd005 = p_srcf004 AND srcd006 = p_srcf005
      AND srcd007 = p_srcf006 AND srcd900 = p_srcf007 AND srcdseq = p_srcfseq
   IF l_srcd.srcd901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF l_srcd.srcd901 = '2' OR l_srcd.srcd901 = '4' THEN
#      SELECT * INTO l_srad.* FROM srad_t  #161124-00048#12 mark
      #161124-00048#12 add(s)
      SELECT sradent,sradsite,srad001,srad002,srad004,srad005,srad006,srad007,
           sradseq,srad008,srad009,srad010,srad011,srad012,srad013,srad014 
        INTO l_srad.* FROM srad_t
      #161124-00048#12 add(e)
       WHERE sradent = g_enterprise AND sradsite = g_site AND srad001 = p_srcf001
         AND srad002 = p_srcf002 AND srad004 = p_srcf003 AND srad005 = p_srcf004 
         AND srad006 = p_srcf005 AND srad007 = p_srcf006 AND sradseq = p_srcfseq
   END IF
   
   LET g_srcf009 = ''
   IF l_srcd.srcd901 = '2' THEN
      IF l_srcd.srcd008 = '1' THEN
         LET g_srcf009 = '4'
      END IF
      IF l_srcd.srcd008 = '2' THEN
         LET g_srcf009 = '7'
      END IF
   END IF
   IF l_srcd.srcd901 = '3' THEN
      IF l_srcd.srcd008 = '1' THEN
         LET g_srcf009 = '5'
      END IF
      IF l_srcd.srcd008 = '2' THEN
         LET g_srcf009 = '8'
      END IF
   END IF
   IF l_srcd.srcd901 = '4' THEN
      INITIALIZE l_srcd.* TO NULL
      IF l_srcd.srcd008 = '1' THEN
         LET g_srcf009 = '6'
      END IF
      IF l_srcd.srcd008 = '2' THEN
         LET g_srcf009 = '9'
      END IF
   END IF
   
   #项次
   IF (NOT cl_null(l_srcd.srcd007) AND (cl_null(l_srad.srad007) OR l_srcd.srcd007 != l_srad.srad007)) OR (cl_null(l_srcd.srcd007) AND NOT cl_null(l_srad.srad007)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad007',g_srcf009,l_srad.srad007,l_srcd.srcd007,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad007') THEN
         RETURN r_success
      END IF
   END IF
   
   #项序
   IF (NOT cl_null(l_srcd.srcdseq) AND (cl_null(l_srad.sradseq) OR l_srcd.srcdseq != l_srad.sradseq)) OR (cl_null(l_srcd.srcdseq) AND NOT cl_null(l_srad.sradseq)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'sradseq',g_srcf009,l_srad.sradseq,l_srcd.srcdseq,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'sradseq') THEN
         RETURN r_success
      END IF
   END IF
   
   #check in/out
   IF (NOT cl_null(l_srcd.srcd008) AND (cl_null(l_srad.srad008) OR l_srcd.srcd008 != l_srad.srad008)) OR (cl_null(l_srcd.srcd008) AND NOT cl_null(l_srad.srad008)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad008',g_srcf009,l_srad.srad008,l_srcd.srcd008,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad008') THEN
         RETURN r_success
      END IF
   END IF
   
   #项目
   IF (NOT cl_null(l_srcd.srcd009) AND (cl_null(l_srad.srad009) OR l_srcd.srcd009 != l_srad.srad009)) OR (cl_null(l_srcd.srcd009) AND NOT cl_null(l_srad.srad009)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='223' AND oocql002='"||l_srad.srad009||"' AND oocql003=? "
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad009',g_srcf009,l_srad.srad009,l_srcd.srcd009,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad009') THEN
         RETURN r_success
      END IF
   END IF
   
   #形态
   IF (NOT cl_null(l_srcd.srcd010) AND (cl_null(l_srad.srad010) OR l_srcd.srcd010 != l_srad.srad010)) OR (cl_null(l_srcd.srcd010) AND NOT cl_null(l_srad.srad010)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad010',g_srcf009,l_srad.srad010,l_srcd.srcd010,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad010') THEN
         RETURN r_success
      END IF
   END IF
   
   #上限
   IF (NOT cl_null(l_srcd.srcd011) AND (cl_null(l_srad.srad011) OR l_srcd.srcd011 != l_srad.srad011)) OR (cl_null(l_srcd.srcd011) AND NOT cl_null(l_srad.srad011)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad011',g_srcf009,l_srad.srad011,l_srcd.srcd011,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad011') THEN
         RETURN r_success
      END IF
   END IF
   
   #下限
   IF (NOT cl_null(l_srcd.srcd012) AND (cl_null(l_srad.srad012) OR l_srcd.srcd012 != l_srad.srad012)) OR (cl_null(l_srcd.srcd012) AND NOT cl_null(l_srad.srad012)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad012',g_srcf009,l_srad.srad012,l_srcd.srcd012,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad012') THEN
         RETURN r_success
      END IF
   END IF
   
   #预设值
   IF (NOT cl_null(l_srcd.srcd013) AND (cl_null(l_srad.srad013) OR l_srcd.srcd013 != l_srad.srad013)) OR (cl_null(l_srcd.srcd013) AND NOT cl_null(l_srad.srad013)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad013',g_srcf009,l_srad.srad013,l_srcd.srcd013,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad013') THEN
         RETURN r_success
      END IF
   END IF
   
   #必要
   IF (NOT cl_null(l_srcd.srcd014) AND (cl_null(l_srad.srad014) OR l_srcd.srcd014 != l_srad.srad014)) OR (cl_null(l_srcd.srcd014) AND NOT cl_null(l_srad.srad014)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad014',g_srcf009,l_srad.srad014,l_srcd.srcd014,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srad014') THEN
         RETURN r_success
      END IF
   END IF
   
   #重复性生产制程上站作业未有发生变更，则更新srcd901
   IF l_flag = 'N' THEN
      UPDATE srcd_t SET srcd901 = '1'
       WHERE srcdent = g_enterprise AND srcdsite = g_site AND srcd000 = p_srcf000 AND srcd001 = p_srcf001
         AND srcd002 = p_srcf002 AND srcd004 = p_srcf003 AND srcd005 = p_srcf004 AND srcd006 = p_srcf005
         AND srcd007 = p_srcf006 AND srcdseq = p_srcfseq AND srcd900 = p_srcf007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd srcd901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#上站作业作业序变更时写入变更历程档
PUBLIC FUNCTION asrt801_upd_srce_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007)
DEFINE p_srcf000                       LIKE srcf_t.srcf000
DEFINE p_srcf001                       LIKE srcf_t.srcf001
DEFINE p_srcf002                       LIKE srcf_t.srcf002
DEFINE p_srcf003                       LIKE srcf_t.srcf003
DEFINE p_srcf004                       LIKE srcf_t.srcf004
DEFINE p_srcf005                       LIKE srcf_t.srcf005
DEFINE p_srcf006                       LIKE srcf_t.srcf006
DEFINE p_srcfseq                       LIKE srcf_t.srcfseq
DEFINE p_srcf007                       LIKE srcf_t.srcf007
DEFINE r_success                       LIKE type_t.num5
DEFINE l_flag                          LIKE type_t.chr1
#DEFINE l_srae                    RECORD LIKE srae_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srae RECORD  #重覆性生產計畫製程上站作業檔
       sraeent LIKE srae_t.sraeent, #企业编号
       sraesite LIKE srae_t.sraesite, #营运据点
       srae001 LIKE srae_t.srae001, #生产计划
       srae002 LIKE srae_t.srae002, #工艺编号
       srae004 LIKE srae_t.srae004, #料件编号
       srae005 LIKE srae_t.srae005, #BOM特性
       srae006 LIKE srae_t.srae006, #产品特征
       srae007 LIKE srae_t.srae007, #项次
       sraeseq LIKE srae_t.sraeseq, #项序
       srae008 LIKE srae_t.srae008, #上站作业
       srae009 LIKE srae_t.srae009  #上站制进程
END RECORD
#161124-00048#12 add(e)
#DEFINE l_srce                    RECORD LIKE srce_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srce RECORD  #重複性生產計劃製程上站作業變更檔
       srceent LIKE srce_t.srceent, #企业编号
       srcesite LIKE srce_t.srcesite, #营运据点
       srce000 LIKE srce_t.srce000, #类型
       srce001 LIKE srce_t.srce001, #生产计划
       srce002 LIKE srce_t.srce002, #工艺编号
       srce004 LIKE srce_t.srce004, #料件编号
       srce005 LIKE srce_t.srce005, #BOM特性
       srce006 LIKE srce_t.srce006, #产品特征
       srce007 LIKE srce_t.srce007, #项次
       srceseq LIKE srce_t.srceseq, #项序
       srce008 LIKE srce_t.srce008, #上站作业
       srce009 LIKE srce_t.srce009, #上站作业序
       srce900 LIKE srce_t.srce900, #变更序
       srce901 LIKE srce_t.srce901, #变更类型
       srce902 LIKE srce_t.srce902, #变更日期
       srce905 LIKE srce_t.srce905, #变更理由
       srce906 LIKE srce_t.srce906  #变更备注
END RECORD
#161124-00048#12 add(e)

   LET r_success = FALSE
   LET l_flag = 'N'
   
   IF p_srcf000 IS NULL OR p_srcf001 IS NULL OR p_srcf002 IS NULL OR p_srcf003 IS NULL OR p_srcf004 IS NULL OR p_srcf005 IS NULL OR p_srcf006 IS NULL OR p_srcfseq IS NULL OR p_srcf007 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   INITIALIZE l_srae.* TO NULL
   INITIALIZE l_srce.* TO NULL
   
#   SELECT * INTO l_srce.* FROM srce_t   #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srceent,srcesite,srce000,srce001,srce002,srce004,srce005,
          srce006,srce007,srceseq,srce008,srce009,srce900,srce901,
          srce902,srce905,srce906 
     INTO l_srce.* FROM srce_t
   #161124-00048#12 add(e)
    WHERE srceent = g_enterprise AND srcesite = g_site AND srce000 = p_srcf000 AND srce001 = p_srcf001
      AND srce002 = p_srcf002 AND srce004 = p_srcf003 AND srce005 = p_srcf004 AND srce006 = p_srcf005
      AND srce007 = p_srcf006 AND srce900 = p_srcf007 AND srceseq = p_srcfseq
   IF l_srce.srce901 = '1' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   IF l_srce.srce901 = '2' OR l_srce.srce901 = '4' THEN
#      SELECT * INTO l_srae.* FROM srae_t #161124-00048#12 mark
      #161124-00048#12 add(s)
      SELECT sraeent,sraesite,srae001,srae002,srae004,srae005,srae006,
             srae007,sraeseq,srae008,srae009 
        INTO l_srae.* FROM srae_t
      #161124-00048#12 add(e)
       WHERE sraeent = g_enterprise AND sraesite = g_site AND srae001 = p_srcf001
         AND srae002 = p_srcf002 AND srae004 = p_srcf003 AND srae005 = p_srcf004 
         AND srae006 = p_srcf005 AND srae007 = p_srcf006 AND sraeseq = p_srcfseq
   END IF
   
   LET g_srcf009 = ''
   IF l_srce.srce901 = '2' THEN
      LET g_srcf009 = '10'
   END IF
   IF l_srce.srce901 = '3' THEN
      LET g_srcf009 = '11'
   END IF
   IF l_srce.srce901 = '4' THEN
      INITIALIZE l_srce.* TO NULL
      LET g_srcf009 = '12'
   END IF
   
   #项次
   IF (NOT cl_null(l_srce.srce007) AND (cl_null(l_srae.srae007) OR l_srce.srce007 != l_srae.srae007)) OR (cl_null(l_srce.srce007) AND NOT cl_null(l_srae.srae007)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae007',g_srcf009,l_srae.srae007,l_srce.srce007,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae007') THEN
         RETURN r_success
      END IF
   END IF
   
   #项序
   IF (NOT cl_null(l_srce.srceseq) AND (cl_null(l_srae.sraeseq) OR l_srce.srceseq != l_srae.sraeseq)) OR (cl_null(l_srce.srceseq) AND NOT cl_null(l_srae.sraeseq)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'sraeseq',g_srcf009,l_srae.sraeseq,l_srce.srceseq,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'sraeseq') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业
   IF (NOT cl_null(l_srce.srce008) AND (cl_null(l_srae.srae008) OR l_srce.srce008 != l_srae.srae008)) OR (cl_null(l_srce.srce008) AND NOT cl_null(l_srae.srae008)) THEN
      #其說明的SQL
      LET g_srcf013 = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002='"||l_srae.srae008||"' AND oocql003=? "
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae008',g_srcf009,l_srae.srae008,l_srce.srce008,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae008') THEN
         RETURN r_success
      END IF
   END IF
   
   #上站作业序
   IF (NOT cl_null(l_srce.srce009) AND (cl_null(l_srae.srae009) OR l_srce.srce009 != l_srae.srae009)) OR (cl_null(l_srce.srce009) AND NOT cl_null(l_srae.srae009)) THEN
      #其說明的SQL
      LET g_srcf013 = ""
      IF NOT s_asrt801_ins_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae009',g_srcf009,l_srae.srae009,l_srce.srce009,g_srcf013) THEN
         RETURN r_success
      END IF
      LET l_flag = 'Y'
   ELSE
      IF NOT s_asrt801_del_srcf(p_srcf000,p_srcf001,p_srcf002,p_srcf003,p_srcf004,p_srcf005,p_srcf006,p_srcfseq,p_srcf007,'srae009') THEN
         RETURN r_success
      END IF
   END IF
   
   #重复性生产制程上站作业未有发生变更，则更新srce901
   IF l_flag = 'N' THEN
      UPDATE srce_t SET srce901 = '1'
       WHERE srceent = g_enterprise AND srcesite = g_site AND srce000 = p_srcf000 AND srce001 = p_srcf001
         AND srce002 = p_srcf002 AND srce004 = p_srcf003 AND srce005 = p_srcf004 AND srce006 = p_srcf005
         AND srce007 = p_srcf006 AND srceseq = p_srcfseq AND srce900 = p_srcf007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd srce901"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#制程资料变更时更新下站作业、作业序
PRIVATE FUNCTION asrt801_return_srcc014()
DEFINE r_success      LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5
DEFINE l_srce008      LIKE srce_t.srce008
DEFINE l_srce009      LIKE srce_t.srce009
#DEFINE l_srcc                    RECORD LIKE srcc_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcc RECORD  #重複性生產計劃製程變更檔
       srccent LIKE srcc_t.srccent, #企业编号
       srccsite LIKE srcc_t.srccsite, #营运据点
       srcc000 LIKE srcc_t.srcc000, #类型
       srcc001 LIKE srcc_t.srcc001, #生产计划
       srcc002 LIKE srcc_t.srcc002, #工艺编号
       srcc004 LIKE srcc_t.srcc004, #料件编号
       srcc005 LIKE srcc_t.srcc005, #BOM特性
       srcc006 LIKE srcc_t.srcc006, #产品特征
       srcc007 LIKE srcc_t.srcc007, #项次
       srcc008 LIKE srcc_t.srcc008, #本站作业编号
       srcc009 LIKE srcc_t.srcc009, #作业序
       srcc010 LIKE srcc_t.srcc010, #群组性质
       srcc011 LIKE srcc_t.srcc011, #群组
       srcc012 LIKE srcc_t.srcc012, #上站作业
       srcc013 LIKE srcc_t.srcc013, #上站作业序
       srcc014 LIKE srcc_t.srcc014, #下站作业
       srcc015 LIKE srcc_t.srcc015, #下站作业序
       srcc016 LIKE srcc_t.srcc016, #工作站
       srcc017 LIKE srcc_t.srcc017, #固定工时
       srcc018 LIKE srcc_t.srcc018, #标准工时
       srcc019 LIKE srcc_t.srcc019, #固定机时
       srcc020 LIKE srcc_t.srcc020, #标准机时
       srcc021 LIKE srcc_t.srcc021, #Move in
       srcc022 LIKE srcc_t.srcc022, #Check in
       srcc023 LIKE srcc_t.srcc023, #报工站
       srcc024 LIKE srcc_t.srcc024, #PQC
       srcc025 LIKE srcc_t.srcc025, #Check out
       srcc026 LIKE srcc_t.srcc026, #Move out
       srcc027 LIKE srcc_t.srcc027, #转出单位
       srcc028 LIKE srcc_t.srcc028, #单位转换率分子
       srcc029 LIKE srcc_t.srcc029, #单位转换率分母
       srcc030 LIKE srcc_t.srcc030, #待Move in数
       srcc031 LIKE srcc_t.srcc031, #待Check in数
       srcc032 LIKE srcc_t.srcc032, #在制数
       srcc033 LIKE srcc_t.srcc033, #待PQC数
       srcc034 LIKE srcc_t.srcc034, #待Check out数
       srcc035 LIKE srcc_t.srcc035, #待Move out数
       srcc036 LIKE srcc_t.srcc036, #委外
       srcc037 LIKE srcc_t.srcc037, #委外供应商
       srcc038 LIKE srcc_t.srcc038, #良品转入
       srcc039 LIKE srcc_t.srcc039, #返工转入
       srcc040 LIKE srcc_t.srcc040, #良品转出
       srcc041 LIKE srcc_t.srcc041, #返工转出
       srcc042 LIKE srcc_t.srcc042, #当站报废
       srcc043 LIKE srcc_t.srcc043, #当站下线
       srcc044 LIKE srcc_t.srcc044, #委外数量
       srcc045 LIKE srcc_t.srcc045, #委外完工数量
       srcc046 LIKE srcc_t.srcc046, #转入单位
       srcc047 LIKE srcc_t.srcc047, #转入单位转换率分子
       srcc048 LIKE srcc_t.srcc048, #转入单位转换率分母
       srcc900 LIKE srcc_t.srcc900, #变更序
       srcc901 LIKE srcc_t.srcc901, #变更类型
       srcc902 LIKE srcc_t.srcc902, #变更日期
       srcc905 LIKE srcc_t.srcc905, #变更理由
       srcc906 LIKE srcc_t.srcc906  #变更备注
END RECORD
#161124-00048#12 add(e)
DEFINE l_srcc014      LIKE srcc_t.srcc014
DEFINE l_srcc015      LIKE srcc_t.srcc015
DEFINE l_tot          LIKE type_t.num5
DEFINE l_n0           LIKE type_t.num5
DEFINE l_n1           LIKE type_t.num5
DEFINE l_n2           LIKE type_t.num5
DEFINE l_n3           LIKE type_t.num5
DEFINE l_n4           LIKE type_t.num5

   LET r_success = FALSE
   DECLARE asrt801_return_srcc014_cs1 CURSOR FOR
#    SELECT * FROM srcc_t  #161124-00048#12 mark
    #161124-00048#12 add(s)
    SELECT srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,
          srcc006,srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,
          srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,
          srcc020,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,
          srcc027,srcc028,srcc029,srcc030,srcc031,srcc032,srcc033,
          srcc034,srcc035,srcc036,srcc037,srcc038,srcc039,srcc040,
          srcc041,srcc042,srcc043,srcc044,srcc045,srcc046,srcc047,
          srcc048,srcc900,srcc901,srcc902,srcc905,srcc906 
      FROM srcc_t
    #161124-00048#12 add(e)
     WHERE srccent = g_enterprise AND srccsite = g_site
       AND srcc000 = g_srca_m.srca000
       AND srcc001 = g_srca_m.srca001
       AND srcc002 = g_srca_m.srca002
       AND srcc004 = g_srca_m.srca004
       AND srcc005 = g_srca_m.srca005
       AND srcc006 = g_srca_m.srca006
       AND srcc900 = g_srca_m.srca900      
       AND srcc901 <> '4'
       
   INITIALIZE l_srcc.* TO NULL
   FOREACH asrt801_return_srcc014_cs1 INTO l_srcc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #当前作业、作业序，不存在其他站的 上站作业 中，则更新本站对应下站为END,0
      SELECT COUNT(*) INTO l_n4 FROM srce_t 
       WHERE srceent = g_enterprise AND srcesite = g_site
         AND srce000 = g_srca_m.srca000
         AND srce001 = g_srca_m.srca001
         AND srce002 = g_srca_m.srca002
         AND srce004 = g_srca_m.srca004
         AND srce005 = g_srca_m.srca005
         AND srce006 = g_srca_m.srca006
         AND srce900 = g_srca_m.srca900      
         AND srce901 <> '4'
         AND srce008 = l_srcc.srcc008 AND srce009 = l_srcc.srcc009
      IF NOT cl_null(l_srcc.srcc007) AND l_n4 = 0 THEN 
         SELECT COUNT(*) INTO l_n4 FROM srce_t 
          WHERE srceent = g_enterprise AND srcesite = g_site
            AND srce000 = g_srca_m.srca000
            AND srce001 = g_srca_m.srca001
            AND srce002 = g_srca_m.srca002
            AND srce004 = g_srca_m.srca004
            AND srce005 = g_srca_m.srca005
            AND srce006 = g_srca_m.srca006
            AND srce900 = g_srca_m.srca900      
            AND srce901 <> '4'
            AND srce008 = l_srcc.srcc011 AND srce009 = '0'
      END IF
      IF l_n4 = 0 THEN
         UPDATE srcc_t SET srcc014 = 'END',srcc015 = '0'
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = g_srca_m.srca000
            AND srcc001 = g_srca_m.srca001
            AND srcc002 = g_srca_m.srca002
            AND srcc004 = g_srca_m.srca004
            AND srcc005 = g_srca_m.srca005
            AND srcc006 = g_srca_m.srca006
            AND srcc900 = g_srca_m.srca900
            AND srcc007 = l_srcc.srcc007
      END IF

      #多上站作業+上站製程序
      DECLARE asrt801_return_srcc014_cs2 CURSOR FOR
       SELECT srce008,srce009 FROM srce_t
        WHERE srceent = g_enterprise AND srcesite = g_site
          AND srce000 = g_srca_m.srca000
          AND srce001 = g_srca_m.srca001
          AND srce002 = g_srca_m.srca002
          AND srce004 = g_srca_m.srca004
          AND srce005 = g_srca_m.srca005
          AND srce006 = g_srca_m.srca006
          AND srce900 = g_srca_m.srca900      
          AND srce901 <> '4'
          AND srce007 = l_srcc.srcc007
          
      FOREACH asrt801_return_srcc014_cs2 INTO l_srce008,l_srce009
         #計算多上站資料有幾筆相同的上站作業+製程序
         LET l_tot = 0
         SELECT COUNT(*) INTO l_tot FROM srce_t
          WHERE srceent = g_enterprise AND srcesite = g_site
            AND srce000 = g_srca_m.srca000
            AND srce001 = g_srca_m.srca001
            AND srce002 = g_srca_m.srca002
            AND srce004 = g_srca_m.srca004
            AND srce005 = g_srca_m.srca005
            AND srce006 = g_srca_m.srca006
            AND srce900 = g_srca_m.srca900
            AND srce008 = l_srce008 AND srce009 = l_srce009
            AND srce901 != '4' 
         IF l_tot = 1 THEN
            IF NOT cl_null(l_srcc.srcc011) THEN
               #維護群組
               #更新上站作業+上站制程序且無維護群組或群組不一樣的資料對應下站程序+下站制程序為本資料的群組+本站  
               UPDATE srcc_t SET srcc014 = l_srcc.srcc011,srcc015 = '0'
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc008 = l_srce008 AND srcc009 = l_srce009
                  AND (srcc011 IS NULL OR srcc011 <> l_srcc.srcc011)
                  AND srcc901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "srcc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success 
               END IF
               #更新上站作業+上站制程序且有維護群組(相同群組)的資料對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE srcc_t SET srcc014 = l_srcc.srcc008,srcc015 = l_srcc.srcc009
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc008 = l_srce008 AND srcc009 = l_srce009
                  AND srcc007 = l_srcc.srcc007
                  AND srcc901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "srcc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success
               END IF
            ELSE
               #無維護群組
               #更新上站作業+上站制程序對應下站程序+下站制程序為本資料的本站程序+本站制程序
               UPDATE srcc_t SET srcc014 = l_srcc.srcc008,srcc015 = l_srcc.srcc009
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc008 = l_srce008 AND srcc009 = l_srce009
                  AND srcc901 != '4' 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "srcc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  RETURN r_success
               END IF
            END IF
         ELSE
            SELECT COUNT(DISTINCT srce008) INTO l_n2 FROM srce_t
             WHERE srceent = g_enterprise AND srcesite = g_site
               AND srce000 = g_srca_m.srca000
               AND srce001 = g_srca_m.srca001
               AND srce002 = g_srca_m.srca002
               AND srce004 = g_srca_m.srca004
               AND srce005 = g_srca_m.srca005
               AND srce006 = g_srca_m.srca006
               AND srce900 = g_srca_m.srca900
               AND srce008 = l_srce008 AND srce009 = l_srce009
               AND srce901 != '4' 
            SELECT COUNT(DISTINCT srce009) INTO l_n3 FROM srce_t
             WHERE srceent = g_enterprise AND srcesite = g_site
               AND srce000 = g_srca_m.srca000
               AND srce001 = g_srca_m.srca001
               AND srce002 = g_srca_m.srca002
               AND srce004 = g_srca_m.srca004
               AND srce005 = g_srca_m.srca005
               AND srce006 = g_srca_m.srca006
               AND srce900 = g_srca_m.srca900
               AND srce008 = l_srce008 AND srce009 = l_srce009
               AND srce901 != '4' 
            IF l_n2 = 1 AND l_n3 = 1 THEN
               UPDATE srcc_t SET srcc014 = 'MULT', srcc015 = '0'
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc008 = l_srce008 AND srcc009 = l_srce009
                  AND srcc901 != '4' 
            ELSE
               UPDATE srcc_t SET srcc014 = l_srcc.srcc007, srcc015 = '0'
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc008 = l_srce008 AND srcc009 = l_srce009
                  AND srcc901 != '4' 
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "srcc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               RETURN r_success
            END IF
         END IF
         SELECT COUNT(*) INTO l_n1 FROM srcc_t
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = g_srca_m.srca000
            AND srcc001 = g_srca_m.srca001
            AND srcc002 = g_srca_m.srca002
            AND srcc004 = g_srca_m.srca004
            AND srcc005 = g_srca_m.srca005
            AND srcc006 = g_srca_m.srca006
            AND srcc900 = g_srca_m.srca900
            AND srcc011 = l_srce008
            AND (srcc008 NOT IN(SELECT srcc012 FROM srcc_t 
                                 WHERE srccent = g_enterprise AND srccsite = g_site
                                   AND srcc000 = g_srca_m.srca000
                                   AND srcc001 = g_srca_m.srca001
                                   AND srcc002 = g_srca_m.srca002
                                   AND srcc004 = g_srca_m.srca004
                                   AND srcc005 = g_srca_m.srca005
                                   AND srcc006 = g_srca_m.srca006
                                   AND srcc900 = g_srca_m.srca900 
                                   AND srcc011 = l_srce008 AND srcc901 != '4') OR
                 srcc009 NOT IN(SELECT srcc009 FROM srcc_t 
                                 WHERE srccent = g_enterprise AND srccsite = g_site
                                   AND srcc000 = g_srca_m.srca000
                                   AND srcc001 = g_srca_m.srca001
                                   AND srcc002 = g_srca_m.srca002
                                   AND srcc004 = g_srca_m.srca004
                                   AND srcc005 = g_srca_m.srca005
                                   AND srcc006 = g_srca_m.srca006
                                   AND srcc900 = g_srca_m.srca900 
                                   AND srcc011 = l_srce008 AND srcc901 != '4'))
            AND srcc901 != '4' 
         IF l_n1 > 0 THEN
            IF NOT cl_null(l_srcc.srcc011) THEN
               UPDATE srcc_t SET srcc014 = l_srcc.srcc011,srcc015 = '0'
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc011 = l_srce008
                  AND (srcc008 NOT IN(SELECT srcc008 FROM srcc_t
                                       WHERE srccent = g_enterprise AND srccsite = g_site
                                         AND srcc000 = g_srca_m.srca000
                                         AND srcc001 = g_srca_m.srca001
                                         AND srcc002 = g_srca_m.srca002
                                         AND srcc004 = g_srca_m.srca004
                                         AND srcc005 = g_srca_m.srca005
                                         AND srcc006 = g_srca_m.srca006
                                         AND srcc900 = g_srca_m.srca900 
                                         AND srcc0011 = l_srce008 AND srcc901 != '4') OR
                       srcc009 NOT IN(SELECT srcc009 FROM srcc_t 
                                       WHERE srccent = g_enterprise AND srccsite = g_site
                                         AND srcc000 = g_srca_m.srca000
                                         AND srcc001 = g_srca_m.srca001
                                         AND srcc002 = g_srca_m.srca002
                                         AND srcc004 = g_srca_m.srca004
                                         AND srcc005 = g_srca_m.srca005
                                         AND srcc006 = g_srca_m.srca006
                                         AND srcc900 = g_srca_m.srca900 
                                         AND srcc011 = l_srce008 AND srcc901 != '4'))
                  AND srcc901 != '4'
            ELSE
               UPDATE srcc_t SET srcc014 = l_srcc.srcc008,srcc015 = l_srcc.srcc009
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900
                  AND srcc011 = l_srce008
                  AND (srcc008 NOT IN(SELECT srcc008 FROM srcc_t
                                       WHERE srccent = g_enterprise AND srccsite = g_site
                                         AND srcc000 = g_srca_m.srca000
                                         AND srcc001 = g_srca_m.srca001
                                         AND srcc002 = g_srca_m.srca002
                                         AND srcc004 = g_srca_m.srca004
                                         AND srcc005 = g_srca_m.srca005
                                         AND srcc006 = g_srca_m.srca006
                                         AND srcc900 = g_srca_m.srca900 
                                         AND srcc011 = l_srce008 AND srcc901 != '4') OR
                       srcc009 NOT IN(SELECT srcc009 FROM srcc_t 
                                       WHERE srccent = g_enterprise AND srccsite = g_site
                                         AND srcc000 = g_srca_m.srca000
                                         AND srcc001 = g_srca_m.srca001
                                         AND srcc002 = g_srca_m.srca002
                                         AND srcc004 = g_srca_m.srca004
                                         AND srcc005 = g_srca_m.srca005
                                         AND srcc006 = g_srca_m.srca006
                                         AND srcc900 = g_srca_m.srca900 
                                         AND srcc011 = l_srce008 AND srcc901 != '4'))
                  AND srcc901 != '4'
            END IF
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "srcc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN r_success
            END IF
         END IF
         
      END FOREACH
      
      #若当站对应下站不存在或者为空，则更新下站作业+下站作业序END+0
      SELECT srcc014,srcc015 INTO l_srcc014,l_srcc015 FROM srcc_t 
       WHERE srccent = g_enterprise AND srccsite = g_site
         AND srcc000 = g_srca_m.srca000
         AND srcc001 = g_srca_m.srca001
         AND srcc002 = g_srca_m.srca002
         AND srcc004 = g_srca_m.srca004
         AND srcc005 = g_srca_m.srca005
         AND srcc006 = g_srca_m.srca006
         AND srcc900 = g_srca_m.srca900 
         AND srcc007=l_srcc.srcc007 
         AND srcc901 != '4' 
      IF NOT cl_null(l_srcc014) AND NOT cl_null(l_srcc015) THEN
         SELECT COUNT(*) INTO l_n0 FROM srce_t 
          WHERE srceent = g_enterprise AND srcesite = g_site
            AND srce000 = g_srca_m.srca000
            AND srce001 = g_srca_m.srca001
            AND srce002 = g_srca_m.srca002
            AND srce004 = g_srca_m.srca004
            AND srce005 = g_srca_m.srca005
            AND srce006 = g_srca_m.srca006
            AND srce900 = g_srca_m.srca900
            AND srce008=l_srcc014 AND srce009=l_srcc015
            AND srce901 != '4' 
         IF l_n0 = 0 THEN
            IF l_srcc.srcc014 = 'MULT' THEN
               SELECT COUNT(*) INTO l_n0 FROM srce_t 
                WHERE srceent = g_enterprise AND srcesite = g_site
                  AND srce000 = g_srca_m.srca000
                  AND srce001 = g_srca_m.srca001
                  AND srce002 = g_srca_m.srca002
                  AND srce004 = g_srca_m.srca004
                  AND srce005 = g_srca_m.srca005
                  AND srce006 = g_srca_m.srca006
                  AND srce900 = g_srca_m.srca900
                  AND srce008=l_srcc.srcc008 AND srce009=l_srcc.srcc009
                  AND srce901 != '4' 
            ELSE
               #群组
               SELECT COUNT(*) INTO l_n0 FROM srcc_t 
                WHERE srccent = g_enterprise AND srccsite = g_site
                  AND srcc000 = g_srca_m.srca000
                  AND srcc001 = g_srca_m.srca001
                  AND srcc002 = g_srca_m.srca002
                  AND srcc004 = g_srca_m.srca004
                  AND srcc005 = g_srca_m.srca005
                  AND srcc006 = g_srca_m.srca006
                  AND srcc900 = g_srca_m.srca900 
                  AND srcc012 = l_srcc.srcc008 AND srcc013 = l_srcc.srcc009 
                  AND srcc011 = l_srcc014 AND srcc901 != '4' 
               IF l_n0 = 0 THEN
                  SELECT COUNT(*) INTO l_n0 FROM srcc_t 
                   WHERE srccent = g_enterprise AND srccsite = g_site
                     AND srcc000 = g_srca_m.srca000
                     AND srcc001 = g_srca_m.srca001
                     AND srcc002 = g_srca_m.srca002
                     AND srcc004 = g_srca_m.srca004
                     AND srcc005 = g_srca_m.srca005
                     AND srcc006 = g_srca_m.srca006
                     AND srcc900 = g_srca_m.srca900 
                     AND srcc008 = l_srcc014 AND srcc009 = l_srcc015 
                     AND srcc012 = l_srcc.srcc011 AND srcc901 != '4' 
                  IF l_n0 = 0 THEN
                     SELECT COUNT(*) INTO l_n0 FROM srcc_t 
                      WHERE srccent = g_enterprise AND srccsite = g_site
                        AND srcc000 = g_srca_m.srca000
                        AND srcc001 = g_srca_m.srca001
                        AND srcc002 = g_srca_m.srca002
                        AND srcc004 = g_srca_m.srca004
                        AND srcc005 = g_srca_m.srca005
                        AND srcc006 = g_srca_m.srca006
                        AND srcc900 = g_srca_m.srca900 
                        AND srcc011 = l_srcc014 AND srcc012 = l_srcc.srcc011
                        AND srcc901 != '4' 
                  END IF
               END IF
            END IF
         END IF
      END IF
      IF cl_null(l_srcc014) OR l_n0 = 0 THEN           
         UPDATE srcc_t SET srcc014 = 'END',srcc015 = 0
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = g_srca_m.srca000
            AND srcc001 = g_srca_m.srca001
            AND srcc002 = g_srca_m.srca002
            AND srcc004 = g_srca_m.srca004
            AND srcc005 = g_srca_m.srca005
            AND srcc006 = g_srca_m.srca006
            AND srcc900 = g_srca_m.srca900 
            AND srcc007 = l_srcc.srcc007
            AND srcc901 != '4' 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE srcc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF
      INITIALIZE l_srcc.* TO NULL
   END FOREACH
   
   #写入变更历程档，新增、修改、删除的时候可能会异动到其他资料，例如上下站资料，故重新抓取资料进行写入
   INITIALIZE l_srcc.* TO NULL
   FOREACH asrt801_return_srcc014_cs1 INTO l_srcc.*
      IF l_srcc.srcc901 = '1' THEN
         UPDATE srcc_t SET srcc901 = '2' 
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = g_srca_m.srca000
            AND srcc001 = g_srca_m.srca001
            AND srcc002 = g_srca_m.srca002
            AND srcc004 = g_srca_m.srca004
            AND srcc005 = g_srca_m.srca005
            AND srcc006 = g_srca_m.srca006
            AND srcc900 = g_srca_m.srca900 
            AND srcc007 = l_srcc.srcc007
      END IF
      IF NOT asrt801_upd_srcc_srcf(g_srca_m.srca000,g_srca_m.srca001,g_srca_m.srca002,g_srca_m.srca004,g_srca_m.srca005,g_srca_m.srca006,l_srcc.srcc007,0,g_srca_m.srca900) THEN 
         RETURN r_success
      END IF
      INITIALIZE l_srcc.* TO NULL   
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

##删除资料时，更新关联资料的上站作业
PRIVATE FUNCTION asrt801_return_srcc012(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc900,p_srcc007)
DEFINE p_srcc000                LIKE srcc_t.srcc000
DEFINE p_srcc001                LIKE srcc_t.srcc001
DEFINE p_srcc002                LIKE srcc_t.srcc002
DEFINE p_srcc004                LIKE srcc_t.srcc004
DEFINE p_srcc005                LIKE srcc_t.srcc005
DEFINE p_srcc006                LIKE srcc_t.srcc006
DEFINE p_srcc900                LIKE srcc_t.srcc900
DEFINE p_srcc007                LIKE srcc_t.srcc007
DEFINE r_success                LIKE type_t.num5
#DEFINE l_srcc                    RECORD LIKE srcc_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcc RECORD  #重複性生產計劃製程變更檔
       srccent LIKE srcc_t.srccent, #企业编号
       srccsite LIKE srcc_t.srccsite, #营运据点
       srcc000 LIKE srcc_t.srcc000, #类型
       srcc001 LIKE srcc_t.srcc001, #生产计划
       srcc002 LIKE srcc_t.srcc002, #工艺编号
       srcc004 LIKE srcc_t.srcc004, #料件编号
       srcc005 LIKE srcc_t.srcc005, #BOM特性
       srcc006 LIKE srcc_t.srcc006, #产品特征
       srcc007 LIKE srcc_t.srcc007, #项次
       srcc008 LIKE srcc_t.srcc008, #本站作业编号
       srcc009 LIKE srcc_t.srcc009, #作业序
       srcc010 LIKE srcc_t.srcc010, #群组性质
       srcc011 LIKE srcc_t.srcc011, #群组
       srcc012 LIKE srcc_t.srcc012, #上站作业
       srcc013 LIKE srcc_t.srcc013, #上站作业序
       srcc014 LIKE srcc_t.srcc014, #下站作业
       srcc015 LIKE srcc_t.srcc015, #下站作业序
       srcc016 LIKE srcc_t.srcc016, #工作站
       srcc017 LIKE srcc_t.srcc017, #固定工时
       srcc018 LIKE srcc_t.srcc018, #标准工时
       srcc019 LIKE srcc_t.srcc019, #固定机时
       srcc020 LIKE srcc_t.srcc020, #标准机时
       srcc021 LIKE srcc_t.srcc021, #Move in
       srcc022 LIKE srcc_t.srcc022, #Check in
       srcc023 LIKE srcc_t.srcc023, #报工站
       srcc024 LIKE srcc_t.srcc024, #PQC
       srcc025 LIKE srcc_t.srcc025, #Check out
       srcc026 LIKE srcc_t.srcc026, #Move out
       srcc027 LIKE srcc_t.srcc027, #转出单位
       srcc028 LIKE srcc_t.srcc028, #单位转换率分子
       srcc029 LIKE srcc_t.srcc029, #单位转换率分母
       srcc030 LIKE srcc_t.srcc030, #待Move in数
       srcc031 LIKE srcc_t.srcc031, #待Check in数
       srcc032 LIKE srcc_t.srcc032, #在制数
       srcc033 LIKE srcc_t.srcc033, #待PQC数
       srcc034 LIKE srcc_t.srcc034, #待Check out数
       srcc035 LIKE srcc_t.srcc035, #待Move out数
       srcc036 LIKE srcc_t.srcc036, #委外
       srcc037 LIKE srcc_t.srcc037, #委外供应商
       srcc038 LIKE srcc_t.srcc038, #良品转入
       srcc039 LIKE srcc_t.srcc039, #返工转入
       srcc040 LIKE srcc_t.srcc040, #良品转出
       srcc041 LIKE srcc_t.srcc041, #返工转出
       srcc042 LIKE srcc_t.srcc042, #当站报废
       srcc043 LIKE srcc_t.srcc043, #当站下线
       srcc044 LIKE srcc_t.srcc044, #委外数量
       srcc045 LIKE srcc_t.srcc045, #委外完工数量
       srcc046 LIKE srcc_t.srcc046, #转入单位
       srcc047 LIKE srcc_t.srcc047, #转入单位转换率分子
       srcc048 LIKE srcc_t.srcc048, #转入单位转换率分母
       srcc900 LIKE srcc_t.srcc900, #变更序
       srcc901 LIKE srcc_t.srcc901, #变更类型
       srcc902 LIKE srcc_t.srcc902, #变更日期
       srcc905 LIKE srcc_t.srcc905, #变更理由
       srcc906 LIKE srcc_t.srcc906  #变更备注
END RECORD
#161124-00048#12 add(e)
DEFINE l_srce007                LIKE srce_t.srce007
DEFINE l_srceseq                LIKE srce_t.srceseq
DEFINE l_srce008                LIKE srce_t.srce008
DEFINE l_srce009                LIKE srce_t.srce009
DEFINE l_srceseq_max            LIKE srce_t.srceseq
DEFINE l_n                      LIKE type_t.num5

   LET r_success = FALSE
   IF p_srcc000 IS NULL OR p_srcc001 IS NULL OR p_srcc002 IS NULL OR p_srcc004 IS NULL OR p_srcc005 IS NULL OR p_srcc006 IS NULL OR p_srcc900 IS NULL OR p_srcc007 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
#   SELECT * INTO l_srcc.* FROM srcc_t   #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,
          srcc006,srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,
          srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,
          srcc020,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,
          srcc027,srcc028,srcc029,srcc030,srcc031,srcc032,srcc033,
          srcc034,srcc035,srcc036,srcc037,srcc038,srcc039,srcc040,
          srcc041,srcc042,srcc043,srcc044,srcc045,srcc046,srcc047,
          srcc048,srcc900,srcc901,srcc902,srcc905,srcc906 
     INTO l_srcc.* FROM srcc_t  
   #161124-00048#12 add(e)
    WHERE srccent = g_enterprise AND srccsite = g_site
      AND srcc000 = p_srcc000
      AND srcc001 = p_srcc001
      AND srcc002 = p_srcc002
      AND srcc004 = p_srcc004
      AND srcc005 = p_srcc005
      AND srcc006 = p_srcc006
      AND srcc900 = p_srcc900 
      AND srcc007 = p_srcc007
   IF l_srcc.srcc014 = 'END' THEN
      LET r_success = TRUE
      RETURN r_success
   END IF      
   
   DECLARE asrt801_return_srcc012_cs1 CURSOR FOR
    SELECT srce004,srce005 FROM srce_t 
     WHERE srceent = g_enterprise AND srcesite = g_site
       AND srce000 = p_srcc000
       AND srce001 = p_srcc001
       AND srce002 = p_srcc002
       AND srce004 = p_srcc004
       AND srce005 = p_srcc005
       AND srce006 = p_srcc006
       AND srce900 = p_srcc900 
       AND srce007 = l_srcc.srcc007
       AND srce901 != '4'
   
   DECLARE asrt801_return_srcc012_cs2 CURSOR FOR
    SELECT srce007,srceseq FROM srce_t 
     WHERE srceent = g_enterprise AND srcesite = g_site
       AND srce000 = p_srcc000
       AND srce001 = p_srcc001
       AND srce002 = p_srcc002
       AND srce004 = p_srcc004
       AND srce005 = p_srcc005
       AND srce006 = p_srcc006
       AND srce900 = p_srcc900 
       AND srce008 = l_srcc.srcc008 AND srce009 = l_srcc.srcc009
       AND srce901 != '4'
   FOREACH asrt801_return_srcc012_cs2 INTO l_srce007,l_srceseq
      IF NOT asrt801_srce_delete(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc900,l_srce007,l_srceseq) THEN
         RETURN r_success
      END IF
      
      FOREACH asrt801_return_srcc012_cs1 INTO l_srce008,l_srce009
         IF l_srce008 = 'INIT' THEN
            SELECT COUNT(*) INTO l_n FROM srce_t 
             WHERE srceent = g_enterprise AND srcesite = g_site
               AND srce000 = p_srcc000
               AND srce001 = p_srcc001
               AND srce002 = p_srcc002
               AND srce004 = p_srcc004
               AND srce005 = p_srcc005
               AND srce006 = p_srcc006
               AND srce900 = p_srcc900 
               AND srce007 = l_srce007
               AND srce901 != '4'
            IF l_n > 0 THEN
               EXIT FOREACH
            END IF
         END IF
         
         SELECT MAX(srceseq) INTO l_srceseq_max FROM srce_t
          WHERE srceent = g_enterprise AND srcesite = g_site
            AND srce000 = p_srcc000
            AND srce001 = p_srcc001
            AND srce002 = p_srcc002
            AND srce004 = p_srcc004
            AND srce005 = p_srcc005
            AND srce006 = p_srcc006
            AND srce900 = p_srcc900
            AND srce007 = l_srce007
         IF cl_null(l_srceseq_max) THEN
            LET l_srceseq_max = 1
         ELSE
            LET l_srceseq_max = l_srceseq_max + 1
         END IF
         INSERT INTO srce_t(srceent,srcesite,srce000,srce001,srce002,srce004,srce005,srce006,srce007,srceseq,srce008,srce009,srce900,srce901,srce902)
                VALUES(g_enterprise,g_site,l_srcc.srcc000,l_srcc.srcc001,l_srcc.srcc002,l_srcc.srcc004,l_srcc.srcc005,l_srcc.srcc006,l_srce007,l_srceseq_max,l_srce008,l_srce009,l_srcc.srcc900,'3',l_srcc.srcc902)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins srce_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
         IF NOT asrt801_upd_srce_srcf(l_srcc.srcc000,l_srcc.srcc001,l_srcc.srcc002,l_srcc.srcc004,l_srcc.srcc005,l_srcc.srcc006,l_srce007,l_srceseq_max,l_srcc.srcc900) THEN
            RETURN r_success
         END IF
      END FOREACH
      SELECT COUNT(*) INTO l_n FROM srce_t 
       WHERE srceent = g_enterprise AND srcesite = g_site
         AND srce000 = p_srcc000
         AND srce001 = p_srcc001
         AND srce002 = p_srcc002
         AND srce004 = p_srcc004
         AND srce005 = p_srcc005
         AND srce006 = p_srcc006
         AND srce900 = p_srcc900
         AND srce007 = l_srce007 AND srce901 != '4'
      IF l_n > 1 THEN
         UPDATE srcc_t SET srcc012 = 'MULT',srcc013 = '0'
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = p_srcc000
            AND srcc001 = p_srcc001
            AND srcc002 = p_srcc002
            AND srcc004 = p_srcc004
            AND srcc005 = p_srcc005
            AND srcc006 = p_srcc006
            AND srcc900 = p_srcc900 
            AND srcc007 = l_srce007
            AND srcc901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd srcc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      IF l_n = 1 THEN
         UPDATE srcc_t 
            SET srcc012 = (SELECT srce004 FROM srce_t 
                            WHERE srceent = g_enterprise AND srcesite = g_site
                              AND srce000 = p_srcc000
                              AND srce001 = p_srcc001
                              AND srce002 = p_srcc002
                              AND srce004 = p_srcc004
                              AND srce005 = p_srcc005
                              AND srce006 = p_srcc006
                              AND srce900 = p_srcc900 
                              AND srce007 = l_srce007 
                              AND srce901 != '4'),
                srcc013 = (SELECT srce005 FROM srce_t 
                            WHERE srceent = g_enterprise AND srcesite = g_site
                              AND srce000 = p_srcc000
                              AND srce001 = p_srcc001
                              AND srce002 = p_srcc002
                              AND srce004 = p_srcc004
                              AND srce005 = p_srcc005
                              AND srce006 = p_srcc006
                              AND srce900 = p_srcc900
                              AND srce007 = l_srce007
                              AND srce901 != '4')
          WHERE srccent = g_enterprise AND srccsite = g_site
            AND srcc000 = p_srcc000
            AND srcc001 = p_srcc001
            AND srcc002 = p_srcc002
            AND srcc004 = p_srcc004
            AND srcc005 = p_srcc005
            AND srcc006 = p_srcc006
            AND srcc900 = p_srcc900 
            AND srcc007 = l_srce007
            AND srcc901 != '4'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "upd srcc_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   LET r_success = TRUE
   RETURN r_success    
   
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION asrt801_srcc_delete(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc900,p_srcc007)
DEFINE p_srcc000                LIKE srcc_t.srcc000
DEFINE p_srcc001                LIKE srcc_t.srcc001
DEFINE p_srcc002                LIKE srcc_t.srcc002
DEFINE p_srcc004                LIKE srcc_t.srcc004
DEFINE p_srcc005                LIKE srcc_t.srcc005
DEFINE p_srcc006                LIKE srcc_t.srcc006
DEFINE p_srcc900                LIKE srcc_t.srcc900
DEFINE p_srcc007                LIKE srcc_t.srcc007
DEFINE r_success                LIKE type_t.num5
DEFINE l_date                   LIKE srcc_t.srcc902
#DEFINE l_srcc                    RECORD LIKE srcc_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcc RECORD  #重複性生產計劃製程變更檔
       srccent LIKE srcc_t.srccent, #企业编号
       srccsite LIKE srcc_t.srccsite, #营运据点
       srcc000 LIKE srcc_t.srcc000, #类型
       srcc001 LIKE srcc_t.srcc001, #生产计划
       srcc002 LIKE srcc_t.srcc002, #工艺编号
       srcc004 LIKE srcc_t.srcc004, #料件编号
       srcc005 LIKE srcc_t.srcc005, #BOM特性
       srcc006 LIKE srcc_t.srcc006, #产品特征
       srcc007 LIKE srcc_t.srcc007, #项次
       srcc008 LIKE srcc_t.srcc008, #本站作业编号
       srcc009 LIKE srcc_t.srcc009, #作业序
       srcc010 LIKE srcc_t.srcc010, #群组性质
       srcc011 LIKE srcc_t.srcc011, #群组
       srcc012 LIKE srcc_t.srcc012, #上站作业
       srcc013 LIKE srcc_t.srcc013, #上站作业序
       srcc014 LIKE srcc_t.srcc014, #下站作业
       srcc015 LIKE srcc_t.srcc015, #下站作业序
       srcc016 LIKE srcc_t.srcc016, #工作站
       srcc017 LIKE srcc_t.srcc017, #固定工时
       srcc018 LIKE srcc_t.srcc018, #标准工时
       srcc019 LIKE srcc_t.srcc019, #固定机时
       srcc020 LIKE srcc_t.srcc020, #标准机时
       srcc021 LIKE srcc_t.srcc021, #Move in
       srcc022 LIKE srcc_t.srcc022, #Check in
       srcc023 LIKE srcc_t.srcc023, #报工站
       srcc024 LIKE srcc_t.srcc024, #PQC
       srcc025 LIKE srcc_t.srcc025, #Check out
       srcc026 LIKE srcc_t.srcc026, #Move out
       srcc027 LIKE srcc_t.srcc027, #转出单位
       srcc028 LIKE srcc_t.srcc028, #单位转换率分子
       srcc029 LIKE srcc_t.srcc029, #单位转换率分母
       srcc030 LIKE srcc_t.srcc030, #待Move in数
       srcc031 LIKE srcc_t.srcc031, #待Check in数
       srcc032 LIKE srcc_t.srcc032, #在制数
       srcc033 LIKE srcc_t.srcc033, #待PQC数
       srcc034 LIKE srcc_t.srcc034, #待Check out数
       srcc035 LIKE srcc_t.srcc035, #待Move out数
       srcc036 LIKE srcc_t.srcc036, #委外
       srcc037 LIKE srcc_t.srcc037, #委外供应商
       srcc038 LIKE srcc_t.srcc038, #良品转入
       srcc039 LIKE srcc_t.srcc039, #返工转入
       srcc040 LIKE srcc_t.srcc040, #良品转出
       srcc041 LIKE srcc_t.srcc041, #返工转出
       srcc042 LIKE srcc_t.srcc042, #当站报废
       srcc043 LIKE srcc_t.srcc043, #当站下线
       srcc044 LIKE srcc_t.srcc044, #委外数量
       srcc045 LIKE srcc_t.srcc045, #委外完工数量
       srcc046 LIKE srcc_t.srcc046, #转入单位
       srcc047 LIKE srcc_t.srcc047, #转入单位转换率分子
       srcc048 LIKE srcc_t.srcc048, #转入单位转换率分母
       srcc900 LIKE srcc_t.srcc900, #变更序
       srcc901 LIKE srcc_t.srcc901, #变更类型
       srcc902 LIKE srcc_t.srcc902, #变更日期
       srcc905 LIKE srcc_t.srcc905, #变更理由
       srcc906 LIKE srcc_t.srcc906  #变更备注
END RECORD
#161124-00048#12 add(e)
DEFINE l_success                LIKE type_t.num5
DEFINE l_srcdseq                LIKE srcd_t.srcdseq
DEFINE l_srceseq                LIKE srce_t.srceseq

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF p_srcc000 IS NULL OR p_srcc001 IS NULL OR p_srcc002 IS NULL OR p_srcc004 IS NULL OR p_srcc005 IS NULL OR p_srcc006 IS NULL OR p_srcc900 IS NULL OR p_srcc007 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF                
   
#   SELECT * INTO l_srcc.* FROM srcc_t   #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srccent,srccsite,srcc000,srcc001,srcc002,srcc004,srcc005,
          srcc006,srcc007,srcc008,srcc009,srcc010,srcc011,srcc012,
          srcc013,srcc014,srcc015,srcc016,srcc017,srcc018,srcc019,
          srcc020,srcc021,srcc022,srcc023,srcc024,srcc025,srcc026,
          srcc027,srcc028,srcc029,srcc030,srcc031,srcc032,srcc033,
          srcc034,srcc035,srcc036,srcc037,srcc038,srcc039,srcc040,
          srcc041,srcc042,srcc043,srcc044,srcc045,srcc046,srcc047,
          srcc048,srcc900,srcc901,srcc902,srcc905,srcc906 
     INTO l_srcc.* FROM srcc_t  
   #161124-00048#12 add(e)
    WHERE srccent = g_enterprise AND srccsite = g_site
      AND srcc000 = p_srcc000
      AND srcc001 = p_srcc001
      AND srcc002 = p_srcc002
      AND srcc004 = p_srcc004
      AND srcc005 = p_srcc005
      AND srcc006 = p_srcc006
      AND srcc900 = p_srcc900
      AND srcc007 = p_srcc007
   #原来的制程资料，删除时不做DELETE，只更新变更类型，且对应的关联表更新
   IF l_srcc.srcc901 = '1' OR l_srcc.srcc901 = '2' THEN 
      LET l_date = cl_get_today()               
      UPDATE srcc_t SET srcc901 = '4',srcc902 = l_date
       WHERE srccent = g_enterprise AND srccsite = g_site
         AND srcc000 = p_srcc000
         AND srcc001 = p_srcc001
         AND srcc002 = p_srcc002
         AND srcc004 = p_srcc004
         AND srcc005 = p_srcc005
         AND srcc006 = p_srcc006
         AND srcc900 = p_srcc900 
         AND srcc007 = p_srcc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD srcc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF

      IF NOT asrt801_upd_srcc_srcf(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc007,0,p_srcc900) THEN
         RETURN r_success
      END IF
      
      DECLARE asrt801_srcc_delete_cs0 CURSOR FOR
       SELECT srceseq FROM srce_t 
        WHERE srceent = g_enterprise AND srcesite = g_site
          AND srce000 = p_srcc000
          AND srce001 = p_srcc001
          AND srce002 = p_srcc002
          AND srce004 = p_srcc004
          AND srce005 = p_srcc005
          AND srce006 = p_srcc006
          AND srce900 = p_srcc900 
          AND srce007 = p_srcc007
      FOREACH asrt801_srcc_delete_cs0 INTO l_srceseq
         IF NOT asrt801_srce_delete(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc007,l_srceseq,p_srcc900) THEN
            RETURN r_success
         END IF
      END FOREACH
            
      DECLARE asrt801_srcc_delete_cs1 CURSOR FOR
       SELECT srcdseq FROM srcd_t 
        WHERE srcdent = g_enterprise AND srcdsite = g_site
          AND srcd000 = p_srcc000
          AND srcd001 = p_srcc001
          AND srcd002 = p_srcc002
          AND srcd004 = p_srcc004
          AND srcd005 = p_srcc005
          AND srcd006 = p_srcc006
          AND srcd900 = p_srcc900 
          AND srcd007 = p_srcc007
      FOREACH asrt801_srcc_delete_cs1 INTO l_srcdseq
         IF NOT asrt801_srcd_delete(p_srcc000,p_srcc001,p_srcc002,p_srcc004,p_srcc005,p_srcc006,p_srcc007,l_srcdseq,p_srcc900) THEN
            RETURN r_success
         END IF
      END FOREACH    
   END IF
   
   IF l_srcc.srcc901 = '3' THEN
      DELETE FROM srcc_t 
       WHERE srccent = g_enterprise AND srccsite = g_site
         AND srcc000 = p_srcc000
         AND srcc001 = p_srcc001
         AND srcc002 = p_srcc002
         AND srcc004 = p_srcc004
         AND srcc005 = p_srcc005
         AND srcc006 = p_srcc006
         AND srcc900 = p_srcc900 
         AND srcc007 = p_srcc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcc_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM srce_t 
       WHERE srceent = g_enterprise AND srcesite = g_site
         AND srce000 = p_srcc000
         AND srce001 = p_srcc001
         AND srce002 = p_srcc002
         AND srce004 = p_srcc004
         AND srce005 = p_srcc005
         AND srce006 = p_srcc006
         AND srce900 = p_srcc900 
         AND srce007 = p_srcc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      DELETE FROM srcd_t 
       WHERE srcdent = g_enterprise AND srcdsite = g_site
         AND srcd000 = p_srcc000
         AND srcd001 = p_srcc001
         AND srcd002 = p_srcc002
         AND srcd004 = p_srcc004
         AND srcd005 = p_srcc005
         AND srcd006 = p_srcc006
         AND srcd900 = p_srcc900 
         AND srcd007 = p_srcc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #变更历程档，包括srcc、srce、srcd对应的
      DELETE FROM srcf_t 
       WHERE srcfent = g_enterprise AND srcfsite = g_site
         AND srcf000 = p_srcc000
         AND srcf001 = p_srcc001
         AND srcf002 = p_srcc002
         AND srcf003 = p_srcc004
         AND srcf004 = p_srcc005
         AND srcf005 = p_srcc006
         AND srcf007 = p_srcc900 
         AND srcf006 = p_srcc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PUBLIC FUNCTION asrt801_srce_delete(p_srce000,p_srce001,p_srce002,p_srce004,p_srce005,p_srce006,p_srce900,p_srce007,p_srceseq)
DEFINE p_srce000                LIKE srce_t.srce000
DEFINE p_srce001                LIKE srce_t.srce001
DEFINE p_srce002                LIKE srce_t.srce002
DEFINE p_srce004                LIKE srce_t.srce004
DEFINE p_srce005                LIKE srce_t.srce005
DEFINE p_srce006                LIKE srce_t.srce006
DEFINE p_srce900                LIKE srce_t.srce900
DEFINE p_srce007                LIKE srce_t.srce007
DEFINE p_srceseq                LIKE srce_t.srceseq
DEFINE r_success                LIKE type_t.num5
DEFINE l_date                   LIKE srce_t.srce902
#DEFINE l_srce                    RECORD LIKE srce_t.*  #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srce RECORD  #重複性生產計劃製程上站作業變更檔
       srceent LIKE srce_t.srceent, #企业编号
       srcesite LIKE srce_t.srcesite, #营运据点
       srce000 LIKE srce_t.srce000, #类型
       srce001 LIKE srce_t.srce001, #生产计划
       srce002 LIKE srce_t.srce002, #工艺编号
       srce004 LIKE srce_t.srce004, #料件编号
       srce005 LIKE srce_t.srce005, #BOM特性
       srce006 LIKE srce_t.srce006, #产品特征
       srce007 LIKE srce_t.srce007, #项次
       srceseq LIKE srce_t.srceseq, #项序
       srce008 LIKE srce_t.srce008, #上站作业
       srce009 LIKE srce_t.srce009, #上站作业序
       srce900 LIKE srce_t.srce900, #变更序
       srce901 LIKE srce_t.srce901, #变更类型
       srce902 LIKE srce_t.srce902, #变更日期
       srce905 LIKE srce_t.srce905, #变更理由
       srce906 LIKE srce_t.srce906  #变更备注
END RECORD
#161124-00048#12 add(e)
DEFINE l_success                LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF p_srce000 IS NULL OR p_srce001 IS NULL OR p_srce002 IS NULL OR p_srce004 IS NULL OR p_srce005 IS NULL OR p_srce006 IS NULL OR p_srce900 IS NULL OR p_srce007 IS NULL OR p_srceseq IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF                
   
#   SELECT * INTO l_srce.* FROM srce_t   #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srceent,srcesite,srce000,srce001,srce002,srce004,srce005,
          srce006,srce007,srceseq,srce008,srce009,srce900,srce901,
          srce902,srce905,srce906 
     INTO l_srce.* FROM srce_t
   #161124-00048#12 add(e)
    WHERE srceent = g_enterprise AND srcesite = g_site
      AND srce000 = p_srce000
      AND srce001 = p_srce001
      AND srce002 = p_srce002
      AND srce004 = p_srce004
      AND srce005 = p_srce005
      AND srce006 = p_srce006
      AND srce900 = p_srce900
      AND srce007 = p_srce007
      AND srceseq = p_srceseq

   #原来的制程资料，删除时不做DELETE，只更新变更类型，且对应的关联表更新
   IF l_srce.srce901 = '1' OR l_srce.srce901 = '2' THEN 
      LET l_date = cl_get_today()               
      UPDATE srce_t SET srce901 = '4',srce902 = l_date
       WHERE srceent = g_enterprise AND srcesite = g_site
         AND srce000 = p_srce000
         AND srce001 = p_srce001
         AND srce002 = p_srce002
         AND srce004 = p_srce004
         AND srce005 = p_srce005
         AND srce006 = p_srce006
         AND srce900 = p_srce900 
         AND srce007 = p_srce007
         AND srceseq = p_srceseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD srce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF

      IF NOT asrt801_upd_srce_srcf(p_srce000,p_srce001,p_srce002,p_srce004,p_srce005,p_srce006,p_srce007,p_srceseq,p_srce900) THEN
         RETURN r_success
      END IF  
   END IF
   
   IF l_srce.srce901 = '3' THEN
      DELETE FROM srce_t 
       WHERE srceent = g_enterprise AND srcesite = g_site
         AND srce000 = p_srce000
         AND srce001 = p_srce001
         AND srce002 = p_srce002
         AND srce004 = p_srce004
         AND srce005 = p_srce005
         AND srce006 = p_srce006
         AND srce900 = p_srce900 
         AND srce007 = p_srce007
         AND srceseq = p_srceseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srce_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #删除对应的变更历程档
      DELETE FROM srcf_t 
       WHERE srcfent = g_enterprise AND srcfsite = g_site
         AND srcf000 = p_srce000
         AND srcf001 = p_srce001
         AND srcf002 = p_srce002
         AND srcf003 = p_srce004
         AND srcf004 = p_srce005
         AND srcf005 = p_srce006
         AND srcf007 = p_srce900 
         AND srcf006 = p_srce007
         AND srcfseq = p_srceseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#删除原有单身时不做delete，而是update变更类型为4.单身删除，以及对相关关联表的更新
PRIVATE FUNCTION asrt801_srcd_delete(p_srcd000,p_srcd001,p_srcd002,p_srcd004,p_srcd005,p_srcd006,p_srcd900,p_srcd007,p_srcdseq)
DEFINE p_srcd000                LIKE srcd_t.srcd000
DEFINE p_srcd001                LIKE srcd_t.srcd001
DEFINE p_srcd002                LIKE srcd_t.srcd002
DEFINE p_srcd004                LIKE srcd_t.srcd004
DEFINE p_srcd005                LIKE srcd_t.srcd005
DEFINE p_srcd006                LIKE srcd_t.srcd006
DEFINE p_srcd900                LIKE srcd_t.srcd900
DEFINE p_srcd007                LIKE srcd_t.srcd007
DEFINE p_srcdseq                LIKE srcd_t.srcdseq
DEFINE r_success                LIKE type_t.num5
DEFINE l_date                   LIKE srcd_t.srcd902
#DEFINE l_srcd                    RECORD LIKE srcd_t.* #161124-00048#12 mark
#161124-00048#12 add(s)
DEFINE l_srcd RECORD  #重複性生產計劃製程Check in/Check out項目變更檔
       srcdent LIKE srcd_t.srcdent, #企业编号
       srcdsite LIKE srcd_t.srcdsite, #营运据点
       srcd000 LIKE srcd_t.srcd000, #类型
       srcd001 LIKE srcd_t.srcd001, #生产计划
       srcd002 LIKE srcd_t.srcd002, #工艺编号
       srcd004 LIKE srcd_t.srcd004, #料件编号
       srcd005 LIKE srcd_t.srcd005, #BOM特性
       srcd006 LIKE srcd_t.srcd006, #产品特征
       srcd007 LIKE srcd_t.srcd007, #项次
       srcdseq LIKE srcd_t.srcdseq, #项序
       srcd008 LIKE srcd_t.srcd008, #Check in/Check out
       srcd009 LIKE srcd_t.srcd009, #项目
       srcd010 LIKE srcd_t.srcd010, #形态
       srcd011 LIKE srcd_t.srcd011, #下限
       srcd012 LIKE srcd_t.srcd012, #上限
       srcd013 LIKE srcd_t.srcd013, #默认值
       srcd014 LIKE srcd_t.srcd014, #必要
       srcd900 LIKE srcd_t.srcd900, #变更序
       srcd901 LIKE srcd_t.srcd901, #变更类型
       srcd902 LIKE srcd_t.srcd902, #变更日期
       srcd905 LIKE srcd_t.srcd905, #变更理由
       srcd906 LIKE srcd_t.srcd906  #变更备注
END RECORD
#161124-00048#12 add(e)
DEFINE l_success                LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   IF p_srcd000 IS NULL OR p_srcd001 IS NULL OR p_srcd002 IS NULL OR p_srcd004 IS NULL OR p_srcd005 IS NULL OR p_srcd006 IS NULL OR p_srcd900 IS NULL OR p_srcd007 IS NULL OR p_srcdseq IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF                
   
#   SELECT * INTO l_srcd.* FROM srcd_t   #161124-00048#12 mark
   #161124-00048#12 add(s)
   SELECT srcdent,srcdsite,srcd000,srcd001,srcd002,srcd004,srcd005,
          srcd006,srcd007,srcdseq,srcd008,srcd009,srcd010,srcd011,
          srcd012,srcd013,srcd014,srcd900,srcd901,srcd902,srcd905,
          srcd906 
     INTO l_srcd.* FROM srcd_t
   #161124-00048#12 add(e)
    WHERE srcdent = g_enterprise AND srcdsite = g_site
      AND srcd000 = p_srcd000
      AND srcd001 = p_srcd001
      AND srcd002 = p_srcd002
      AND srcd004 = p_srcd004
      AND srcd005 = p_srcd005
      AND srcd006 = p_srcd006
      AND srcd900 = p_srcd900
      AND srcd007 = p_srcd007
      AND srcdseq = p_srcdseq

   #原来的制程资料，删除时不做DELETE，只更新变更类型，且对应的关联表更新
   IF l_srcd.srcd901 = '1' OR l_srcd.srcd901 = '2' THEN 
      LET l_date = cl_get_today()               
      UPDATE srcd_t SET srcd901 = '4',srcd902 = l_date
       WHERE srcdent = g_enterprise AND srcdsite = g_site
         AND srcd000 = p_srcd000
         AND srcd001 = p_srcd001
         AND srcd002 = p_srcd002
         AND srcd004 = p_srcd004
         AND srcd005 = p_srcd005
         AND srcd006 = p_srcd006
         AND srcd900 = p_srcd900 
         AND srcd007 = p_srcd007
         AND srcdseq = p_srcdseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPD srcd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF

      IF NOT asrt801_upd_srcd_srcf(p_srcd000,p_srcd001,p_srcd002,p_srcd004,p_srcd005,p_srcd006,p_srcd007,p_srcdseq,p_srcd900) THEN
         RETURN r_success
      END IF  
   END IF
   
   IF l_srcd.srcd901 = '3' THEN
      DELETE FROM srcd_t 
       WHERE srcdent = g_enterprise AND srcdsite = g_site
         AND srcd000 = p_srcd000
         AND srcd001 = p_srcd001
         AND srcd002 = p_srcd002
         AND srcd004 = p_srcd004
         AND srcd005 = p_srcd005
         AND srcd006 = p_srcd006
         AND srcd900 = p_srcd900 
         AND srcd007 = p_srcd007
         AND srcdseq = p_srcdseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
      
      #删除对应的变更历程档
      DELETE FROM srcf_t 
       WHERE srcfent = g_enterprise AND srcfsite = g_site
         AND srcf000 = p_srcd000
         AND srcf001 = p_srcd001
         AND srcf002 = p_srcd002
         AND srcf003 = p_srcd004
         AND srcf004 = p_srcd005
         AND srcf005 = p_srcd006
         AND srcf007 = p_srcd900 
         AND srcf006 = p_srcd007
         AND srcfseq = p_srcdseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DEL srcf_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()                 
         RETURN r_success
      END IF
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#重复性生产制程单身颜色初始化
PRIVATE FUNCTION asrt801_srcc_color_init()
   LET g_srcc_d_color[l_ac].srcc007       = 'black'
   LET g_srcc_d_color[l_ac].srcc008       = 'black'
   LET g_srcc_d_color[l_ac].srcc008_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc009       = 'black'
   LET g_srcc_d_color[l_ac].srcc010       = 'black'
   LET g_srcc_d_color[l_ac].srcc011       = 'black' 
   LET g_srcc_d_color[l_ac].srcc012       = 'black'
   LET g_srcc_d_color[l_ac].srcc012_desc  = 'black' 
   LET g_srcc_d_color[l_ac].srcc013       = 'black'
   LET g_srcc_d_color[l_ac].srcc014       = 'black'
   LET g_srcc_d_color[l_ac].srcc014_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc015       = 'black'
   LET g_srcc_d_color[l_ac].srcc016       = 'black'
   LET g_srcc_d_color[l_ac].srcc016_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc017       = 'black'
   LET g_srcc_d_color[l_ac].srcc018       = 'black'
   LET g_srcc_d_color[l_ac].srcc019       = 'black'
   LET g_srcc_d_color[l_ac].srcc020       = 'black'
   LET g_srcc_d_color[l_ac].srcc036       = 'black'
   LET g_srcc_d_color[l_ac].srcc037       = 'black'
   LET g_srcc_d_color[l_ac].srcc037_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc021       = 'black'
   LET g_srcc_d_color[l_ac].srcc022       = 'black'
   LET g_srcc_d_color[l_ac].srcc023       = 'black'
   LET g_srcc_d_color[l_ac].srcc024       = 'black'
   LET g_srcc_d_color[l_ac].srcc025       = 'black'
   LET g_srcc_d_color[l_ac].srcc026       = 'black'
   LET g_srcc_d_color[l_ac].srcc046       = 'black'
   LET g_srcc_d_color[l_ac].srcc046_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc047       = 'black'
   LET g_srcc_d_color[l_ac].srcc048       = 'black'
   LET g_srcc_d_color[l_ac].srcc027       = 'black'
   LET g_srcc_d_color[l_ac].srcc027_desc  = 'black'
   LET g_srcc_d_color[l_ac].srcc028       = 'black'
   LET g_srcc_d_color[l_ac].srcc029       = 'black'
   
   LET g_srcc2_d_color[l_ac].srcc007          = 'black' 
   LET g_srcc2_d_color[l_ac].l_srcc008_2      = 'black'
   LET g_srcc2_d_color[l_ac].l_srcc008_2_desc = 'black'
   LET g_srcc2_d_color[l_ac].l_srcc009_2      = 'black'
   LET g_srcc2_d_color[l_ac].l_srcc016_2      = 'black'
   LET g_srcc2_d_color[l_ac].l_srcc016_2_desc = 'black'
   LET g_srcc2_d_color[l_ac].srcc030          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc031          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc032          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc033          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc034          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc035          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc038          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc039          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc040          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc041          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc042          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc043          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc044          = 'black' 
   LET g_srcc2_d_color[l_ac].srcc045          = 'black'
   
END FUNCTION

#重复性生产制程check in颜色初始化
PRIVATE FUNCTION asrt801_srcd_color_init()
   LET g_srcc3_d_color[l_ac].srcdseq      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd008      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd009      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd009_desc = 'black'
   LET g_srcc3_d_color[l_ac].srcd010      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd011      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd012      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd013      = 'black' 
   LET g_srcc3_d_color[l_ac].srcd014      = 'black' 
END FUNCTION

#重复性生产制程check out颜色初始化
PRIVATE FUNCTION asrt801_srcd2_color_init()
   LET g_srcc4_d_color[l_ac].l_srcdseq      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd008      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd009      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd009_desc = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd010      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd011      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd012      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd013      = 'black' 
   LET g_srcc4_d_color[l_ac].l_srcd014      = 'black' 
END FUNCTION

#重复性生产制程单身资料颜色显示
PRIVATE FUNCTION asrt801_srcc_color()
DEFINE l_srcf008               LIKE srcf_t.srcf008

   CALL asrt801_srcc_color_init()
   
   DECLARE sel_srcc_srcf_cs CURSOR FOR
   SELECT srcf008 FROM srcf_t
     WHERE srcfent = g_enterprise AND srcfsite = g_site
       AND srcf000 = g_srca_m.srca000
       AND srcf001 = g_srca_m.srca001
       AND srcf002 = g_srca_m.srca002
       AND srcf003 = g_srca_m.srca004
       AND srcf004 = g_srca_m.srca005
       AND srcf005 = g_srca_m.srca006
       AND srcf006 = g_srcc_d[l_ac].srcc007
       AND srcfseq = 0
       AND srcf007 = g_srca_m.srca900 
       
   FOREACH sel_srcc_srcf_cs INTO l_srcf008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_srcf008 = cl_replace_str(l_srcf008,'srac','srcc')

      CASE l_srcf008
         WHEN 'srcc007' 
            LET g_srcc_d_color[l_ac].srcc007       = 'red'
            LET g_srcc2_d_color[l_ac].srcc007      = 'red'
         WHEN 'srcc008' 
            LET g_srcc_d_color[l_ac].srcc008       = 'red'
            LET g_srcc_d_color[l_ac].srcc008_desc  = 'red'
            LET g_srcc2_d_color[l_ac].l_srcc008_2      = 'red'
            LET g_srcc2_d_color[l_ac].l_srcc008_2_desc = 'red'  
         WHEN 'srcc009' 
            LET g_srcc_d_color[l_ac].srcc009       = 'red'
            LET g_srcc2_d_color[l_ac].l_srcc009_2  = 'red'
         WHEN 'srcc010' 
            LET g_srcc_d_color[l_ac].srcc010       = 'red'
         WHEN 'srcc011' 
            LET g_srcc_d_color[l_ac].srcc011       = 'red'
         WHEN 'srcc012' 
            LET g_srcc_d_color[l_ac].srcc012       = 'red'
            LET g_srcc_d_color[l_ac].srcc012_desc  = 'red'
         WHEN 'srcc013' 
            LET g_srcc_d_color[l_ac].srcc013       = 'red'
         WHEN 'srcc014' 
            LET g_srcc_d_color[l_ac].srcc014       = 'red'
            LET g_srcc_d_color[l_ac].srcc014_desc  = 'red'
         WHEN 'srcc015' 
            LET g_srcc_d_color[l_ac].srcc015       = 'red'
         WHEN 'srcc016' 
            LET g_srcc_d_color[l_ac].srcc016       = 'red'
            LET g_srcc_d_color[l_ac].srcc016_desc  = 'red'
            LET g_srcc2_d_color[l_ac].l_srcc016_2      = 'red'
            LET g_srcc2_d_color[l_ac].l_srcc016_2_desc = 'red'
         WHEN 'srcc017' 
            LET g_srcc_d_color[l_ac].srcc017       = 'red'
         WHEN 'srcc018' 
            LET g_srcc_d_color[l_ac].srcc018       = 'red'
         WHEN 'srcc019' 
            LET g_srcc_d_color[l_ac].srcc019       = 'red'
         WHEN 'srcc020' 
            LET g_srcc_d_color[l_ac].srcc020       = 'red'
         WHEN 'srcc036' 
            LET g_srcc_d_color[l_ac].srcc036       = 'red'
         WHEN 'srcc037' 
            LET g_srcc_d_color[l_ac].srcc037       = 'red'
            LET g_srcc_d_color[l_ac].srcc037_desc  = 'red'
         WHEN 'srcc021' 
            LET g_srcc_d_color[l_ac].srcc021       = 'red'
         WHEN 'srcc022' 
            LET g_srcc_d_color[l_ac].srcc022       = 'red'
         WHEN 'srcc023' 
            LET g_srcc_d_color[l_ac].srcc023       = 'red'
         WHEN 'srcc024' 
            LET g_srcc_d_color[l_ac].srcc024       = 'red'
         WHEN 'srcc025' 
            LET g_srcc_d_color[l_ac].srcc025       = 'red'
         WHEN 'srcc026' 
            LET g_srcc_d_color[l_ac].srcc026       = 'red'
         WHEN 'srcc046' 
            LET g_srcc_d_color[l_ac].srcc046       = 'red'
            LET g_srcc_d_color[l_ac].srcc046_desc  = 'red'
         WHEN 'srcc047' 
            LET g_srcc_d_color[l_ac].srcc047       = 'red'
         WHEN 'srcc048' 
            LET g_srcc_d_color[l_ac].srcc048       = 'red'
         WHEN 'srcc027' 
            LET g_srcc_d_color[l_ac].srcc027       = 'red'
            LET g_srcc_d_color[l_ac].srcc027_desc  = 'red'
         WHEN 'srcc028' 
            LET g_srcc_d_color[l_ac].srcc028       = 'red'
         WHEN 'srcc029' 
            LET g_srcc_d_color[l_ac].srcc029       = 'red'
            
         WHEN 'srcc030' 
            LET g_srcc2_d_color[l_ac].srcc030      = 'red'
         WHEN 'srcc031' 
            LET g_srcc2_d_color[l_ac].srcc031      = 'red'
         WHEN 'srcc032' 
            LET g_srcc2_d_color[l_ac].srcc032      = 'red'
         WHEN 'srcc033' 
            LET g_srcc2_d_color[l_ac].srcc033      = 'red'
         WHEN 'srcc034' 
            LET g_srcc2_d_color[l_ac].srcc034      = 'red'
         WHEN 'srcc035' 
            LET g_srcc2_d_color[l_ac].srcc035      = 'red'
         WHEN 'srcc038' 
            LET g_srcc2_d_color[l_ac].srcc038      = 'red'
         WHEN 'srcc039' 
            LET g_srcc2_d_color[l_ac].srcc039      = 'red'
         WHEN 'srcc040' 
            LET g_srcc2_d_color[l_ac].srcc040      = 'red'
         WHEN 'srcc041' 
            LET g_srcc2_d_color[l_ac].srcc041      = 'red'
         WHEN 'srcc042' 
            LET g_srcc2_d_color[l_ac].srcc042      = 'red'
         WHEN 'srcc043' 
            LET g_srcc2_d_color[l_ac].srcc043      = 'red'
         WHEN 'srcc044' 
            LET g_srcc2_d_color[l_ac].srcc044      = 'red'
         WHEN 'srcc045' 
            LET g_srcc2_d_color[l_ac].srcc045      = 'red'
      END CASE
   END FOREACH
END FUNCTION

#重复性生产制程check in单身资料颜色显示
PRIVATE FUNCTION asrt801_srcd_color()
DEFINE l_srcf008               LIKE srcf_t.srcf008

   CALL asrt801_srcd_color_init()
   
   DECLARE sel_srcd_srcf_cs CURSOR FOR
    SELECT srcf008 FROM srcf_t
     WHERE srcfent = g_enterprise AND srcfsite = g_site
       AND srcf000 = g_srca_m.srca000
       AND srcf001 = g_srca_m.srca001
       AND srcf002 = g_srca_m.srca002
       AND srcf003 = g_srca_m.srca004
       AND srcf004 = g_srca_m.srca005
       AND srcf005 = g_srca_m.srca006
       AND srcf006 = g_srcc_d[g_detail_idx].srcc007
       AND srcfseq = g_srcc3_d[l_ac].srcdseq
       AND srcf007 = g_srca_m.srca900 
       AND srcf008 LIKE 'srad%'
       
   FOREACH sel_srcd_srcf_cs INTO l_srcf008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_srcf008 = cl_replace_str(l_srcf008,'srad','srcd')

      CASE l_srcf008
         WHEN 'srcdseq' 
            LET g_srcc3_d_color[l_ac].srcdseq      = 'red' 
         WHEN 'srcd008'
            LET g_srcc3_d_color[l_ac].srcd008      = 'red'
         WHEN 'srcd009'
            LET g_srcc3_d_color[l_ac].srcd009      = 'red' 
            LET g_srcc3_d_color[l_ac].srcd009_desc = 'red'
         WHEN 'srcd010'
            LET g_srcc3_d_color[l_ac].srcd010      = 'red' 
         WHEN 'srcd011'
            LET g_srcc3_d_color[l_ac].srcd011      = 'red' 
         WHEN 'srcd012'
            LET g_srcc3_d_color[l_ac].srcd012      = 'red'
         WHEN 'srcd013'            
            LET g_srcc3_d_color[l_ac].srcd013      = 'red' 
         WHEN 'srcd014'
            LET g_srcc3_d_color[l_ac].srcd014      = 'red' 
      END CASE
   END FOREACH
END FUNCTION

#重复性生产制程check out单身资料颜色显示
PRIVATE FUNCTION asrt801_srcd2_color()
DEFINE l_srcf008               LIKE srcf_t.srcf008

   CALL asrt801_srcd2_color_init()
   
   DECLARE sel_srcd2_srcf_cs CURSOR FOR
    SELECT srcf008 FROM srcf_t
     WHERE srcfent = g_enterprise AND srcfsite = g_site
       AND srcf000 = g_srca_m.srca000
       AND srcf001 = g_srca_m.srca001
       AND srcf002 = g_srca_m.srca002
       AND srcf003 = g_srca_m.srca004
       AND srcf004 = g_srca_m.srca005
       AND srcf005 = g_srca_m.srca006
       AND srcf006 = g_srcc_d[g_detail_idx].srcc007
       AND srcfseq = g_srcc4_d[l_ac].l_srcdseq
       AND srcf007 = g_srca_m.srca900 
       AND srcf008 LIKE 'srad%'
       
   FOREACH sel_srcd2_srcf_cs INTO l_srcf008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      LET l_srcf008 = cl_replace_str(l_srcf008,'srad','srcd')

      CASE l_srcf008
         WHEN 'srcdseq' 
            LET g_srcc4_d_color[l_ac].l_srcdseq      = 'red' 
         WHEN 'srcd008'
            LET g_srcc4_d_color[l_ac].l_srcd008      = 'red'
         WHEN 'srcd009'
            LET g_srcc4_d_color[l_ac].l_srcd009      = 'red' 
            LET g_srcc4_d_color[l_ac].l_srcd009_desc = 'red'
         WHEN 'srcd010'
            LET g_srcc4_d_color[l_ac].l_srcd010      = 'red' 
         WHEN 'srcd011'
            LET g_srcc4_d_color[l_ac].l_srcd011      = 'red' 
         WHEN 'srcd012'
            LET g_srcc4_d_color[l_ac].l_srcd012      = 'red'
         WHEN 'srcd013'            
            LET g_srcc4_d_color[l_ac].l_srcd013      = 'red' 
         WHEN 'srcd014'
            LET g_srcc4_d_color[l_ac].l_srcd014      = 'red' 
      END CASE
   END FOREACH
END FUNCTION

#项目说明栏位显示
PRIVATE FUNCTION asrt801_srcd_desc(p_srcd008,p_srcd009,p_srcd905)
DEFINE p_srcd008         LIKE srcd_t.srcd008
DEFINE p_srcd009         LIKE srcd_t.srcd009
DEFINE p_srcd905         LIKE srcd_t.srcd905
   
   IF NOT cl_null(p_srcd009) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_srcd009
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='223' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF p_srcd008 = '1' THEN
         LET g_srcc3_d[l_ac].srcd009_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_srcc3_d[l_ac].srcd009_desc
      END IF
      IF p_srcd008 = '2' THEN
         LET g_srcc4_d[l_ac].l_srcd009_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_srcc4_d[l_ac].l_srcd009_desc
      END IF
   END IF
   
   IF NOT cl_null(p_srcd905) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = p_srcd905
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      IF p_srcd008 = '1' THEN
         LET g_srcc3_d[l_ac].srcd905_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_srcc3_d[l_ac].srcd905_desc
      END IF
      IF p_srcd008 = '2' THEN
         LET g_srcc4_d[l_ac].l_srcd905_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_srcc4_d[l_ac].l_srcd905_desc
      END IF
   END IF
END FUNCTION

 
{</section>}
 
